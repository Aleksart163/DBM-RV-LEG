local mod	= DBM:NewMod("ImpossibleFoe", "DBM-MageTower")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17745 $"):sub(12, -3))
mod:SetCreatureID(115638) --Агата
mod:SetZone()

mod.soloChallenge = true
mod.onlyNormal = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 242989",
	"SPELL_CAST_SUCCESS 242989",
	"SPELL_AURA_APPLIED 243113 243027",
	"SPELL_AURA_REMOVED 243113 243027",
	"SPELL_PERIODIC_DAMAGE 236161",
	"SPELL_PERIODIC_MISSED 236161",
	"UNIT_HEALTH",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

--Прошляпанное очко Мурчаля ✔ Невероятный противник
local warnDarkFury				= mod:NewEndTargetAnnounce(243113, 2) --Темная ярость
local warnTranslocate			= mod:NewSoonAnnounce(242989, 1) --Перемещение
local warnTranslocate2			= mod:NewSpellAnnounce(242989, 2) --Перемещение
local warnPhase					= mod:NewPhaseChangeAnnounce(1)
local warnPrePhase2				= mod:NewPrePhaseAnnounce(2, 1)

local specWarnUmbralImp			= mod:NewSpecialWarningSwitch2(243027, nil, nil, nil, 1, 3) --Мрачный бес
local specWarnImpServants		= mod:NewSpecialWarningSwitch(235140, nil, nil, nil, 1, 2) --Месть Агаты
local specWarnDarkFury			= mod:NewSpecialWarningMoreDamage(243113, nil, nil, nil, 3, 6) --Темная ярость
local specWarnPlagueZone		= mod:NewSpecialWarningYouMove(236161, nil, nil, nil, 1, 2) --Область чумы

local timerImpServantsCD		= mod:NewCDTimer(45, 235140, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON) --Месть Агаты
local timerDarkFuryCD			= mod:NewCDTimer(50, 243113, nil, nil, nil, 6, nil, DBM_CORE_DEADLY_ICON..DBM_CORE_INTERRUPT_ICON) --Темная ярость
local timerShadowShieldCD		= mod:NewCDTimer(55, 243027, nil, nil, nil, 7) --Щит Тени

local countdownDarkFury			= mod:NewCountdown(50, 243113, nil, nil, 5) --Темная ярость
local countdownImpServants		= mod:NewCountdown("Alt45", 235140, nil, nil, 5) --Месть Агаты

mod:AddSetIconOption("SetIconOnShadowShield", 243027, true, false, {7})
mod:AddInfoFrameOption(243113, true)

mod.vb.phase = 1

local warned_preP1 = false
local warned_preP2 = false
local warned_preP3 = false
local warned_preP4 = false

function mod:OnCombatStart(delay)
	warned_preP1 = false
	warned_preP2 = false
	warned_preP3 = false
	warned_preP4 = false
	self.vb.phase = 1
	timerImpServantsCD:Start(15-delay) --Месть Агаты+++
	countdownImpServants:Start(15-delay) --Месть Агаты+++
	timerDarkFuryCD:Start(50-delay) --Темная ярость+++
	countdownDarkFury:Start(50-delay) --Темная ярость+++
	timerShadowShieldCD:Start(56-delay) --Щит Тени
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 242989 then --Перемещение
		if self.vb.phase >= 2 then
			warnTranslocate2:Show()
		end
	end
end
	
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 242989 then --Перемещение
		if self.vb.phase == 1 then
			self.vb.phase = 2
			warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase))
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 243113 then --Темная ярость
		specWarnDarkFury:Show(args.destName)
	--	specWarnDarkFury:Play("attackshield")
		timerDarkFuryCD:Start()
		countdownDarkFury:Start()
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(2, "enemyabsorb", args.spellName)
		end
	elseif spellId == 243027 then --Щит Тени
		specWarnUmbralImp:Show(args.sourceName)
	--	specWarnUmbralImp:Play("killmob")
		timerShadowShieldCD:Start()
		if self.Options.SetIconOnShadowShield then
		--	self:ScanForMobs(115642, 0, 7, 1, 0.1, 12, "SetIconOnShadowShield")
			self:SetIcon(args.sourceName, 7)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 243113 then --Темная ярость
		warnDarkFury:Show(args.destName)
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 236161 and destGUID == UnitGUID("player") and self:AntiSpam(3, "plaguezone") then --Область чумы
		specWarnPlagueZone:Show()
	--	specWarnPlagueZone:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	if args.destGUID == UnitGUID("player") then
		DBM:EndCombat(self, true)
	end
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 115638 then --Агата
		DBM:EndCombat(self)
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:find(L.impServants) or msg == L.impServants then
		specWarnImpServants:Show()
	--	specWarnImpServants:Play("bigmob")
		timerImpServantsCD:Start()
		countdownImpServants:Start()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 241502 then --Валун огня Скверны
		DBM:Debug("checking proshlyapation of Murchal", 2)
	end
end

function mod:UNIT_HEALTH(uId)
	if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 115638 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.60 then --Агата
		warned_preP1 = true
		warnPrePhase2:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
	elseif self.vb.phase == 2 and warned_preP1 and not warned_preP2 and self:GetUnitCreatureId(uId) == 115638 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.40 then --Агата
		warned_preP2 = true
		warnTranslocate:Show()
	--	warnTranslocate:Play("specialsoon")
	elseif self.vb.phase == 2 and warned_preP2 and not warned_preP3 and self:GetUnitCreatureId(uId) == 115638 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.25 then --Агата
		warned_preP3 = true
		warnTranslocate:Show()
	--	warnTranslocate:Play("specialsoon")
	elseif self.vb.phase == 2 and warned_preP3 and not warned_preP4 and self:GetUnitCreatureId(uId) == 115638 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.10 then --Агата
		warned_preP4 = true
		warnTranslocate:Show()
	--	warnTranslocate:Play("specialsoon")
	end
end
