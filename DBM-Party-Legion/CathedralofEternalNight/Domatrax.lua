local mod	= DBM:NewMod(1904, "DBM-Party-Legion", 12, 900)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(119542)--119883 Fel Portal Guardian 118834
mod:SetEncounterID(2053)
mod:SetZone()
--mod:SetHotfixNoticeRev(15186)
--mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 236543 234107 241622",
	"SPELL_CAST_SUCCESS 234107",
	"SPELL_AURA_APPLIED 243157",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1",
	"UNIT_HEALTH"
)
--TODO, other warnings? portal spawns/phases?
--TODO, announce portal guardians, they fire UNIT_TARGETABLE_CHANGED (maybe other things?)
local warnApproachingDoom			= mod:NewCastAnnounce(241622, 2) --Приближение погибели
local warnFrenzy					= mod:NewSpellAnnounce(243157, 4) --Бешенство
local warnApproachingDoom2			= mod:NewSoonAnnounce(241622, 1) --Приближение погибели

local specWarnFelsoulCleave			= mod:NewSpecialWarningDodge(236543, "Tank", nil, nil, 1, 2) --Удар оскверненной души
local specWarnChaoticEnergy			= mod:NewSpecialWarningMoveTo(234107, nil, nil, nil, 3, 5) --Хаотическая энергия
local specWarnAdds					= mod:NewSpecialWarningAdds(200597, "-Healer", nil, nil, 1, 2) --Открыть портал Скверны

local timerFelsoulCleaveCD			= mod:NewCDTimer(17, 236543, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON) --Удар оскверненной души
local timerChaoticEnergyCD			= mod:NewCDTimer(30, 234107, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Хаотическая энергия
local timerApproachingDoom			= mod:NewCastTimer(20, 241622, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON) --Приближение погибели

local countdownChaosEnergy			= mod:NewCountdown(30, 234107) --Хаотическая энергия

mod:AddInfoFrameOption(238410, true)

local shield = DBM:GetSpellInfo(238410)

mod.vb.phase = 1
local warned_preP1 = false
local warned_preP2 = false
local warned_preP3 = false
local warned_preP4 = false

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	warned_preP1 = false
	warned_preP2 = false
	warned_preP3 = false
	warned_preP4 = false
	timerFelsoulCleaveCD:Start(9.5-delay)
	timerChaoticEnergyCD:Start(31-delay)
	countdownChaosEnergy:Start(31-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(shield)
		DBM.InfoFrame:Show(2, "enemypower", 2, ALTERNATE_POWER_INDEX)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 236543 then
		specWarnFelsoulCleave:Show()
		specWarnFelsoulCleave:Play("shockwave")
		timerFelsoulCleaveCD:Start()
	elseif spellId == 234107 then
		specWarnChaoticEnergy:Show(shield)
		specWarnChaoticEnergy:Play("findshield")
		countdownChaosEnergy:Start(5)
	elseif spellId == 241622 then
		if self:AntiSpam(2, 1) then
			warnApproachingDoom:Show()
			specWarnAdds:Show()
			specWarnAdds:Play("killmob")
		end
		timerApproachingDoom:Start(nil, args.sourceGUID)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 234107 then
		timerChaoticEnergyCD:Start()
		countdownChaosEnergy:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 243157 then --Бешенство
		warnFrenzy:Show()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 118834 or cid == 119883 then--Portal Guardians
		timerApproachingDoom:Stop(args.destGUID)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 235822 or spellId == 235862 then--Start Wave 01/Start Wave 02
		specWarnAdds:Show()
		specWarnAdds:Play("killmob")
	end
end

function mod:UNIT_HEALTH(uId)
	if self:IsHard() then --миф и миф+
		if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 119542 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.95 then
			warned_preP1 = true
			warnApproachingDoom2:Show()
		elseif self.vb.phase == 1 and warned_preP1 and not warned_preP2 and self:GetUnitCreatureId(uId) == 119542 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.90 then
			self.vb.phase = 2
			warned_preP2 = true
		elseif self.vb.phase == 2 and warned_preP2 and not warned_preP3 and self:GetUnitCreatureId(uId) == 119542 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.55 then
			warned_preP3 = true
			warnApproachingDoom2:Show()
		elseif self.vb.phase == 2 and warned_preP3 and not warned_preP4 and self:GetUnitCreatureId(uId) == 119542 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.50 then
			self.vb.phase = 3
			warned_preP4 = true
		end
	else
		if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 119542 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.95 then
			warned_preP1 = true
			warnApproachingDoom2:Show()
		elseif self.vb.phase == 1 and warned_preP1 and not warned_preP2 and self:GetUnitCreatureId(uId) == 119542 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.90 then
			self.vb.phase = 2
			warned_preP2 = true
		elseif self.vb.phase == 2 and warned_preP2 and not warned_preP3 and self:GetUnitCreatureId(uId) == 119542 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.55 then
			warned_preP3 = true
			warnApproachingDoom2:Show()
		elseif self.vb.phase == 2 and warned_preP3 and not warned_preP4 and self:GetUnitCreatureId(uId) == 119542 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.50 then
			self.vb.phase = 3
			warned_preP4 = true
		end
	end
end
