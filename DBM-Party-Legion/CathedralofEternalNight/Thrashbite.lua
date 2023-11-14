local mod	= DBM:NewMod(1906, "DBM-Party-Legion", 12, 900)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17745 $"):sub(12, -3))
mod:SetCreatureID(117194)
mod:SetEncounterID(2057)
mod:SetZone()
mod:SetUsedIcons(8)
mod:SetMinSyncRevision(17745)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 238484 237726",
	"SPELL_AURA_REMOVED 237726",
	"SPELL_CAST_START 237276",
	"SPELL_CAST_SUCCESS 243124"
)

--Долбогрыз Глумливый https://ru.wowhead.com/npc=117194/долбогрыз-глумливый/эпохальный-журнал-сражений
local warnHeaveCrud					= mod:NewSpellAnnounce(243124, 2) --Бросок дубины

local specWarnPulvCrudgel			= mod:NewSpecialWarningRun(237276, "Melee", nil, nil, 4, 5) --Сокрушающая дубина
local specWarnPulvCrudgel2			= mod:NewSpecialWarningDodge(237276, "Ranged", nil, nil, 2, 2) --Сокрушающая дубина
local specWarnMindControl			= mod:NewSpecialWarningSwitchCount(238484, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switch:format(238484), nil, 1, 2) --Завораживающая биография
local specWarnScornfulGaze			= mod:NewSpecialWarningYouMoveAway(237726, nil, nil, nil, 4, 3) --Глумливый взгляд
local specWarnScornfulGaze2			= mod:NewSpecialWarningTargetDodge(237726, nil, nil, nil, 2, 2) --Глумливый взгляд
local specWarnScornfulGaze3			= mod:NewSpecialWarningYouDefensive(237726, nil, nil, nil, 3, 3) --Глумливый взгляд
local specWarnScornfulGaze4			= mod:NewSpecialWarningTargetSoak(237726, "Tank", nil, nil, 3, 6) --Глумливый взгляд

local timerPulvCrudgelCD			= mod:NewCDTimer(34.2, 237276, nil, nil, nil, 2, nil, DBM_CORE_TANK_ICON..DBM_CORE_DEADLY_ICON) --Сокрушающая дубина
local timerScornfulGazeCD			= mod:NewCDTimer(36.5, 237726, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Глумливый взгляд
local timerScornfulGaze				= mod:NewCastTimer(7, 237726, nil, nil, nil, 7) --Глумливый взгляд
local timerHeaveCrudCD				= mod:NewCDTimer(36.5, 243124, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Бросок дубины

local countdownScornfulGaze			= mod:NewCountdown(37, 237726, nil, nil, 5) --Глумливый взгляд
local countdownScornfulGaze2		= mod:NewCountdownFades("Alt7", 237726, nil, nil, 5) --Глумливый взгляд

local yellScornfulGaze				= mod:NewYell(237726, nil, nil, nil, "YELL") --Глумливый взгляд
local yellScornfulGaze2				= mod:NewFadesYell(237726, nil, nil, nil, "YELL") --Глумливый взгляд

mod:AddSetIconOption("SetIconOnScornfulGaze", 237726, true, false, {8}) --Глумливый взгляд

function mod:OnCombatStart(delay)
	if not self:IsNormal() then
		timerPulvCrudgelCD:Start(6-delay) --Сокрушающая дубина +++
		timerHeaveCrudCD:Start(17.5-delay) --Бросок дубины +++
		timerScornfulGazeCD:Start(26.7-delay) --Глумливый взгляд +++
		countdownScornfulGaze:Start(26.7-delay) --Глумливый взгляд +++
	else
		timerPulvCrudgelCD:Start(6-delay) --Сокрушающая дубина
		timerHeaveCrudCD:Start(15.5-delay) --Бросок дубины
		timerScornfulGazeCD:Start(26.7-delay)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 238484 then
		specWarnMindControl:Show(args.destName)
--[[		if args:IsPlayer() then
			--Add a yell?
			specWarnMindControl:Play("targetyou")
		else
			specWarnMindControl:Play("findmc")
		end]]
	elseif spellId == 237726 then --Глумливый взгляд
		timerScornfulGaze:Start()
		timerScornfulGazeCD:Start()
		timerHeaveCrudCD:Start(27.5)
		countdownScornfulGaze2:Start()
		countdownScornfulGaze:Start()
		if args:IsPlayer() and not self:IsTank() then
			specWarnScornfulGaze:Show()
		--	specWarnScornfulGaze:Play("runaway")
			specWarnScornfulGaze3:Schedule(3.5)
		--	specWarnScornfulGaze3:ScheduleVoice(3.5, "defensive")
			yellScornfulGaze:Yell()
			yellScornfulGaze2:Countdown(7, 3)
		elseif args:IsPlayer() and self:IsTank() then
			specWarnScornfulGaze:Show()
		--	specWarnScornfulGaze:Play("runaway")
			specWarnScornfulGaze3:Schedule(3.5)
		--	specWarnScornfulGaze3:ScheduleVoice(3.5, "defensive")
			yellScornfulGaze:Yell()
			yellScornfulGaze2:Countdown(7, 3)
		elseif self:CheckNearby(15, args.destName) then
			specWarnScornfulGaze2:Show(args.destName)
		--	specWarnScornfulGaze2:Play("watchstep")
		else
			specWarnScornfulGaze4:Show(args.destName)
		--	specWarnScornfulGaze4:Play("helpsoak")
		end
		if self.Options.SetIconOnScornfulGaze then
			self:SetIcon(args.destName, 8, 7)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 237726 then --Глумливый взгляд
		timerScornfulGaze:Cancel()
		countdownScornfulGaze2:Cancel()
		if args:IsPlayer() then
			specWarnScornfulGaze3:Cancel()
			yellScornfulGaze2:Cancel()
		end
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 237276 then --Сокрушающая дубина
		if not UnitIsDeadOrGhost("player") then
			specWarnPulvCrudgel:Show()
		--	specWarnPulvCrudgel:Play("justrun")
			specWarnPulvCrudgel2:Show()
		--	specWarnPulvCrudgel2:Play("watchstep")
		end
		timerPulvCrudgelCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 243124 then
		warnHeaveCrud:Show()
	end
end
