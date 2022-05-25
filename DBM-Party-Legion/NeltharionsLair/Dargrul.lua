local mod	= DBM:NewMod(1687, "DBM-Party-Legion", 5, 767)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(91007)
mod:SetEncounterID(1793)
mod:SetZone()
mod:SetUsedIcons(7)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 200732 200551 200637 200700 200404",
	"SPELL_AURA_APPLIED 200154",
	"SPELL_AURA_REMOVED 200154",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

local warnCrystalSpikes				= mod:NewSpellAnnounce(200551, 2) --Кристальные шипы
local warnBurningHatred				= mod:NewTargetAnnounce(200154, 3) --Пламенная ненависть

local specWarnMoltenCrash			= mod:NewSpecialWarningDefensive(200732, "Tank", nil, nil, 3, 3) --Магматический удар
local specWarnLandSlide				= mod:NewSpecialWarningSpell(200700, "Tank", nil, nil, 1, 2) --Оползень
local specWarnMagmaSculptor			= mod:NewSpecialWarningSwitch(200637, "Dps", nil, nil, 1, 2) --Ваятель магмы
local specWarnMagmaWave				= mod:NewSpecialWarningMoveTo(200404, nil, nil, nil, 4, 5) --Магматическая волна
local specWarnBurningHatred			= mod:NewSpecialWarningYouRun(200154, nil, nil, nil, 4, 3) --Пламенная ненависть

local timerMoltenCrashCD			= mod:NewCDTimer(16.5, 200732, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON..DBM_CORE_DEADLY_ICON) --Магматический удар 16.5-23
local timerLandSlideCD				= mod:NewCDTimer(16.5, 200700, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON) --Оползень 16.5-27
local timerCrystalSpikesCD			= mod:NewCDTimer(21.4, 200551, nil, nil, nil, 3) --Кристальные шипы +++
local timerMagmaSculptorCD			= mod:NewCDTimer(71, 200637, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON) --Ваятель магмы +++
local timerMagmaWaveCD				= mod:NewCDTimer(60, 200404, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Магматическая волна +++
local timerBurningHatred			= mod:NewTargetTimer(30, 200154, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Пламенная ненависть +++

local yellBurningHatred				= mod:NewYell(200154, nil, nil, nil, "YELL") --Пламенная ненависть
local yellBurningHatred2			= mod:NewFadesYell(200154, nil, nil, nil, "YELL") --Пламенная ненависть

local countdownMagmaWave			= mod:NewCountdown(60, 200404) --Магматическая волна
local countdownMagmaWave2			= mod:NewCountdownFades("AltTwo6", 200404) --Магматическая волна

mod:AddSetIconOption("SetIconOnBurningHatred", 200154, true, false, {7}) --Пламенная ненависть

local shelterName = DBM:GetSpellInfo(200551) --Кристальные шипы

function mod:OnCombatStart(delay)
	if self:IsHard() then
		timerMagmaSculptorCD:Start(9.3-delay) --Ваятель магмы +++
		timerLandSlideCD:Start(15.8-delay) --Оползень +++
		timerMoltenCrashCD:Start(19-delay) --Магматический удар +++
		timerCrystalSpikesCD:Start(5.8-delay) --Кристальные шипы +++	
		timerMagmaWaveCD:Start(66.5-delay) --Магматическая волна +++
		countdownMagmaWave:Start(66.5-delay) --Магматическая волна +++
	else
		timerMagmaSculptorCD:Start(7.3-delay) --Ваятель магмы
		timerLandSlideCD:Start(15.8-delay) --Оползень
		timerMoltenCrashCD:Start(19-delay) --Магматический удар
		timerCrystalSpikesCD:Start(21.5-delay) --Кристальные шипы
		timerMagmaWaveCD:Start(65-delay) --Магматическая волна
		countdownMagmaWave:Start(65-delay) --Магматическая волна
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 200732 then --Магматический удар
		specWarnMoltenCrash:Show()
		specWarnMoltenCrash:Play("defensive")
		if self:IsHard() then
			timerMoltenCrashCD:Start(17)
		else
			timerMoltenCrashCD:Start()
		end
	elseif spellId == 200551 then --Кристальные шипы
		warnCrystalSpikes:Show()
		if self:IsHard() then
			timerCrystalSpikesCD:Start(22)
		else
			timerCrystalSpikesCD:Start()
		end
	elseif spellId == 200637 then --Ваятель магмы
		specWarnMagmaSculptor:Show()
		specWarnMagmaSculptor:Play("killbigmob")
		if self:IsHard() then
			timerMagmaSculptorCD:Start(71.5)
		else
			timerMagmaSculptorCD:Start()
		end
	elseif spellId == 200700 then --Оползень
		specWarnLandSlide:Show()
		specWarnLandSlide:Play("shockwave")
		if self:IsHard() then
			timerLandSlideCD:Start(17)
		else
			timerLandSlideCD:Start()
		end
	elseif spellId == 200404 and self:AntiSpam(3, 1) then --Магматическая волна
		specWarnMagmaWave:Show(shelterName)
		specWarnMagmaWave:Play("findshelter")
		countdownMagmaWave2:Start()
		if self:IsHard() then
			timerMagmaWaveCD:Start(61)
			countdownMagmaWave:Start(61)
		else
			timerMagmaWaveCD:Start()
			countdownMagmaWave:Start()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 200154 then --Пламенная ненависть
		timerBurningHatred:Start(args.destName)
		if args:IsPlayer() then
			specWarnBurningHatred:Show()
			specWarnBurningHatred:Play("targetyou")
			yellBurningHatred:Yell()
			yellBurningHatred2:Countdown(30, 3)
		else
			warnBurningHatred:Show(args.destName)
		end
		if self.Options.SetIconOnBurningHatred then
			self:SetIcon(args.destName, 7)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 200154 then
		timerBurningHatred:Cancel(args.destName)
		if args:IsPlayer() then
			yellBurningHatred2:Cancel()
		end
		if self.Options.SetIconOnBurningHatred then
			self:SetIcon(args.destName, 0)
		end
	end
end
--[[
--1 second faster than combat log. 1 second slower than Unit event callout but that's no longer reliable.
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:find("spell:200404") and self:AntiSpam(3, 1) then
		specWarnMagmaWave:Show(shelterName)
		specWarnMagmaWave:Play("findshelter")
		if self:IsHard() then
			timerMagmaWaveCD:Start(61)
			countdownMagmaWave:Start(61)
		else
			timerMagmaWaveCD:Start()
			countdownMagmaWave:Start()
		end
	end
end
]]