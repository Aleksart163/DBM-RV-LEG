local mod	= DBM:NewMod(1836, "DBM-Party-Legion", 11, 860)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
mod:SetCreatureID(114462)
mod:SetEncounterID(1964)
mod:SetZone()
--mod:SetUsedIcons(1)
--mod:SetHotfixNoticeRev(14922)
--mod.respawnTime = 30

mod.noNormal = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 234416",
	"SPELL_AURA_APPLIED 227254 227257",
	"SPELL_AURA_APPLIED_DOSE 227257",
	"SPELL_AURA_REMOVED 227254",
	"SPELL_PERIODIC_DAMAGE 227465",
	"SPELL_PERIODIC_MISSED 227465",
	"SPELL_SUMMON 227267",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--Смотритель и прошляпанное очко Мурчаля Прошляпенко [✔]
local warnOverload					= mod:NewStackAnnounce(227257, 4, nil, nil, 2) --Перегрузка
local warnAdds						= mod:NewSpellAnnounce(227267, 3, nil, "Healer") --Призыв нестабильной энергии
local warnEvo						= mod:NewSpellAnnounce(227254, 3, nil, "Healer") --Прилив сил

local specWarnPowerDischarge2		= mod:NewSpecialWarningDodge(227279, nil, nil, nil, 2, 2) --Разряд энергии
local specWarnAdds					= mod:NewSpecialWarningSwitch(227267, "-Healer", nil, nil, 1, 2) --Призыв нестабильной энергии
local specWarnPowerDischarge		= mod:NewSpecialWarningYouMove(227465, nil, nil, nil, 1, 2) --Разряд энергии
local specWarnEvo					= mod:NewSpecialWarningMoreDamage(227254, "-Healer", nil, nil, 3, 2) --Прилив сил
local specWarnEvo2					= mod:NewSpecialWarningSoon(227254, nil, nil, nil, 1, 2) --Прилив сил
local specWarnOverload				= mod:NewSpecialWarningDefensive(227257, nil, nil, nil, 3, 6) --Перегрузка

local timerSummonAddCD				= mod:NewNextTimer(9.5, 227267, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON) --Призыв нестабильной энергии
local timerPowerDischargeCD			= mod:NewCDTimer(14, 227279, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Разряд энергии
local timerEvoCD					= mod:NewNextTimer(70, 227254, nil, nil, nil, 7) --Прилив сил
local timerEvo						= mod:NewBuffActiveTimer(20, 227254, nil, nil, nil, 6, nil, DBM_CORE_DEADLY_ICON) --Прилив сил

local countdownEvo					= mod:NewCountdown(70, 227254, nil, nil, 5) --Прилив сил

mod.vb.powerDischargeCast = 0

local powerDischarges = {14, 14, 14, 45.2, 14, 14, 45.2, 14, 14, 45.2, 14, 14, 45.2, 14, 14, 45.2, 14, 14, 45.2, 14, 14, 45.2}

local function startPowerDischarge(self) --Прошляпанное очко Мурчаля Прошляпенко
	self.vb.powerDischargeCast = self.vb.powerDischargeCast + 1
	if not UnitIsDeadOrGhost("player") then
		specWarnPowerDischarge2:Show()
		specWarnPowerDischarge2:Play("watchstep")
	end
	local timer = self:IsHard() and powerDischarges[self.vb.powerDischargeCast+1] or self:IsHeroic() and powerDischarges[self.vb.powerDischargeCast+1]
	if timer then
		timerPowerDischargeCD:Start(timer, self.vb.powerDischargeCast+1)
		self:Schedule(timer, startPowerDischarge, self)
	end
end

function mod:OnCombatStart(delay)
	self.vb.powerDischargeCast = 0
	if not self:IsNormal() then
		timerSummonAddCD:Start(6-delay) --Призыв нестабильной энергии
		specWarnEvo2:Schedule(48-delay)
		specWarnEvo2:ScheduleVoice(48-delay, "specialsoon")
		timerEvoCD:Start(53-delay) --Прилив сил
		countdownEvo:Start(53) --Прилив сил
		timerPowerDischargeCD:Start(13-delay) --Разряд энергии
		self:Schedule(13, startPowerDischarge, self)
	end
--		timerSummonAddCD:Start(6-delay)
--		timerPowerDischargeCD:Start(13.5)
--		timerEvoCD:Start(68-delay)
--		countdownEvo:Start(68)
--	end
end

function mod:OnCombatEnd()

end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 227267 then --Призыв нестабильной энергии
		warnAdds:Show()
		if not UnitIsDeadOrGhost("player") then
			specWarnAdds:Show()
			specWarnAdds:Play("switch")
		end
		timerSummonAddCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 227254 then --Прилив сил
		timerSummonAddCD:Stop()
	--	timerPowerDischargeCD:Stop()
		warnEvo:Show()
		specWarnEvo:Show(args.destName)
		specWarnOverload:Schedule(17)
		specWarnOverload:ScheduleVoice(17, "defensive")
		timerEvo:Start()
		countdownEvo:Start(20)
	elseif spellId == 227257 then --Перегрузка
		local amount = args.amount or 1
		warnOverload:Show(args.destName, amount)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 227254 then --Прилив сил
		timerSummonAddCD:Start(6)
	--	timerPowerDischargeCD:Start(13)
		specWarnEvo2:Schedule(48.5)
		specWarnEvo2:ScheduleVoice(48.5, "specialsoon")
		timerEvoCD:Start(53.5) --для миф0 норм
		countdownEvo:Start(53.5) --для миф0 норм
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 227465 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		if self:IsHard() then
			specWarnPowerDischarge:Show()
			specWarnPowerDischarge:Play("runaway")
		end
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 227278 then
	--	timerPowerDischargeCD:Start() --сломано со стороны сервера
	end
end
