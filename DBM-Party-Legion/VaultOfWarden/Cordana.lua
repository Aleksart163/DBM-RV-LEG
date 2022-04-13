local mod	= DBM:NewMod(1470, "DBM-Party-Legion", 10, 707)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(95888)
mod:SetEncounterID(1818)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 213576 213583 197251 213685 197422",
	"SPELL_AURA_APPLIED 205004 197541",
	"SPELL_AURA_REMOVED 206567 197422",
	"UNIT_SPELLCAST_SUCCEEDED boss1",
	"UNIT_HEALTH boss1"
)

local warnDeepeningShadows			= mod:NewSpellAnnounce(213583, 4) --Сгущающиеся тени
local warnVengeance					= mod:NewSpellAnnounce(205004, 4) --Отмщение
local warnCreepingDoom				= mod:NewSpellAnnounce(197422, 4) --Ползучая гибель

local specWarnPhase1				= mod:NewSpecialWarning("Phase1", nil, nil, nil, 1, 2) --скоро фаза 2
local specWarnPhase2				= mod:NewSpecialWarning("Phase2", nil, nil, nil, 1, 2) --фаза 2

local specWarnDetonation			= mod:NewSpecialWarningYouDefensive(197541, nil, nil, nil, 2, 5) --Мгновенный взрыв
local specWarnKick					= mod:NewSpecialWarningSpell(197251, "Tank", nil, nil, 3, 2) --Сбивающий с ног удар
local specWarnDeepeningShadows		= mod:NewSpecialWarningMoveTo(213583, nil, nil, nil, 3, 6) --Сгущающиеся тени
local specWarnHiddenStarted			= mod:NewSpecialWarningSpell(192750, nil, nil, nil, 2, 2) --Пелена тьмы
local specWarnHiddenOver			= mod:NewSpecialWarningEnd(192750, nil, nil, nil, 1, 2) --Пелена тьмы
local specWarnCreepingDoom			= mod:NewSpecialWarningDodge(197422, nil, nil, nil, 2, 5) --Ползучая гибель
local specWarnVengeance				= mod:NewSpecialWarningMoveTo(205004, nil, nil, nil, 3, 6) --Отмщение
local specWarnVengeance2			= mod:NewSpecialWarningSwitch(205004, "-Healer", nil, nil, 3, 6) --Отмщение

--local timerDetonation				= mod:NewTargetTimer(10, 197541, nil, nil, nil, 3, nil, DBM_CORE_HEALER_ICON) --Мгновенный взрыв
local timerKickCD					= mod:NewCDTimer(16, 197251, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON) --Сбивающий с ног удар 16-42
local timerDeepeningShadowsCD		= mod:NewCDTimer(30.5, 213576, nil, nil, nil, 3) --Сгущающиеся тени
local timerCreepingDoomCD			= mod:NewCDTimer(74.5, 197422, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Ползучая гибель
local timerCreepingDoom				= mod:NewBuffActiveTimer(35, 197422, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Ползучая гибель 35-40
local timerVengeanceCD				= mod:NewCDTimer(35, 205004, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON) --Отмщение 35-40

local countdownCreepingDoom			= mod:NewCountdown(74.5, 197422) --Ползучая гибель

mod.vb.phase = 1
local warned_preP1 = false
local warned_preP2 = false

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	warned_preP1 = false
	warned_preP2 = false
	timerKickCD:Start(8.3-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 213576 or spellId == 213583 then
		if ExtraActionBarFrame:IsShown() then--Has light
			specWarnDeepeningShadows:Show(args.spellName)
			specWarnDeepeningShadows:Play("213576")
		else
			warnDeepeningShadows:Show()
		end
		timerDeepeningShadowsCD:Start()
	elseif spellId == 197251 then
		specWarnKick:Show()
		specWarnKick:Play("carefly")
		timerKickCD:Start()
	elseif spellId == 197422 then --первая Ползучая гибель
		warnCreepingDoom:Show()
		specWarnCreepingDoom:Show()
		specWarnCreepingDoom:Play("stilldanger")
		specWarnCreepingDoom:ScheduleVoice(2, "keepmove")
		timerKickCD:Stop()
		timerDeepeningShadowsCD:Stop()
		timerCreepingDoom:Start()
		timerCreepingDoomCD:Start()
		countdownCreepingDoom:Start()
	elseif spellId == 213685 then --вторая Ползучая гибель
		warnCreepingDoom:Show()
		specWarnCreepingDoom:Show()
		specWarnCreepingDoom:Play("stilldanger")
		specWarnCreepingDoom:ScheduleVoice(2, "keepmove")
		timerCreepingDoom:Start(20)
		timerCreepingDoomCD:Start(64.5)
		countdownCreepingDoom:Start(64.5)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if args.spellId == 205004 then
		if ExtraActionBarFrame:IsShown() then--Has light
			specWarnVengeance:Show(args.spellName)
			specWarnVengeance:Play(205004)
		else
			warnVengeance:Show()
			specWarnVengeance2:Show()
		end
		timerVengeanceCD:Start()
	elseif spellId == 197541 then
	--	timerDetonation:Start(args.destName)
		if args:IsPlayer() then
			specWarnDetonation:Show()
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 206567 then
		specWarnHiddenOver:Show()
		specWarnHiddenOver:Play("phasechange")
		--timerVengeanceCD:Start(14)
		timerKickCD:Start(15.5)--15-20
		timerDeepeningShadowsCD:Start(20)--20-25
	elseif spellId == 197422 then --Первая ползучая гибель
		specWarnPhase2:Show()
		specWarnPhase2:Play("phasechange")
		timerVengeanceCD:Start(14)
		timerDeepeningShadowsCD:Start(12)
		timerKickCD:Start(20)--Small sample
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 203416 then--Shadowstep. Faster than 206567 applied
		timerDeepeningShadowsCD:Stop()
		timerKickCD:Stop()
		specWarnHiddenStarted:Show()
	end
end

function mod:UNIT_HEALTH(uId)
	if self:IsHard() then --миф и миф+
		if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 95888 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.44 then
			warned_preP1 = true
			specWarnPhase1:Show()
		elseif self.vb.phase == 1 and warned_preP1 and not warned_preP2 and self:GetUnitCreatureId(uId) == 95888 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.41 then
			self.vb.phase = 2
			warned_preP2 = true
		end
	else
		if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 95888 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.41 then
			self.vb.phase = 2
			warned_preP1 = true
		end
	end
end
