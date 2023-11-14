local mod	= DBM:NewMod(1987, "DBM-AntorusBurningThrone", nil, 946)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17745 $"):sub(12, -3))
mod:SetCreatureID(122477, 122135) --122477 Ф'арг, 122135 Шатуг
mod:SetEncounterID(2074)
mod:SetZone()
mod:SetBossHPInfoToHighest()
mod:SetUsedIcons(5, 4, 3, 2, 1)
mod:SetHotfixNoticeRev(17745)
mod:SetMinSyncRevision(17745)
mod:DisableIEEUCombatDetection()
mod.respawnTime = 30

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 244057 244056 249113",
	"SPELL_CAST_SUCCESS 244072 251445 245098 244086",
	"SPELL_AURA_APPLIED 244768 248815 254429 248819 244054 244055 251356 251447 251448 244071 244072",
	"SPELL_AURA_REMOVED 244768 248815 254429 248819 251356 244054 244055 244071",
	"SPELL_PERIODIC_DAMAGE 245022",
	"SPELL_PERIODIC_MISSED 245022",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2"
)

local Fharg = DBM:EJ_GetSectionInfo(15842)
local Shatug = DBM:EJ_GetSectionInfo(15836)
--F'harg
local warnDesolateGaze					= mod:NewTargetAnnounce(244768, 3) --Опустошающий взгляд
local warnEnflamedCorruption			= mod:NewSpellAnnounce(244057, 3) --Возгорание порчи
local warnMoltenTouch					= mod:NewTargetAnnounce(244072, 2) --Касание магмы
--Shatug
local warnWeightofDarkness				= mod:NewTargetAnnounce(254429, 2) --Бремя тьмы
local warnWeightofDarkness3				= mod:NewTargetAnnounce(244071, 3) --Бремя тьмы
local warnSiphonCorruption				= mod:NewSpellAnnounce(244056, 3) --Вытягивание порчи
--General/Mythic
local warnFocusingPower					= mod:NewSpellAnnounce(251356, 2) --Фокусирование силы
local warnDarkReconstitution			= mod:NewTargetSourceAnnounce(249113, 3) --Темное восстановление

--Фарг
local specWarnMoltenTouch				= mod:NewSpecialWarningDodge(244163, nil, nil, nil, 2, 3) --Жаркая вспышка
local specWarnDesolateGaze				= mod:NewSpecialWarningYouMoveAway(244768, nil, nil, nil, 1, 5) --Опустошающий взгляд
local specWarnEnflamed					= mod:NewSpecialWarningYouMoveAway(248815, nil, nil, nil, 1, 5) --Возгорание
local specWarnEnflamed2					= mod:NewSpecialWarningSoon(244057, nil, nil, nil, 1, 2) --Возгорание
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)
--Шатуг
local specWarnComsumingSphere			= mod:NewSpecialWarningDodge(244131, nil, nil, nil, 2, 3) --Поглощаяющая сфера
local specWarnComsumingSphere2			= mod:NewSpecialWarningSoon(244131, nil, nil, nil, 1, 2) --Поглощаяющая сфера
local specWarnWeightOfDarkness			= mod:NewSpecialWarningYouShare(254429, nil, nil, nil, 3, 6) --Бремя тьмы
local specWarnWeightOfDarkness2			= mod:NewSpecialWarningSoon(254429, nil, nil, nil, 1, 2) --Бремя тьмы
local specWarnSiphoned					= mod:NewSpecialWarningYouShare(248819, nil, nil, nil, 3, 6) --Вытягивание
local specWarnSiphoned2					= mod:NewSpecialWarningSoon(244056, nil, nil, nil, 1, 2) --Вытягивание
--Mythic
local specWarnFlameTouched				= mod:NewSpecialWarningYouPos(244054, nil, nil, nil, 3, 6) --Касание пламени
local specWarnShadowtouched				= mod:NewSpecialWarningYouPos(244055, nil, nil, nil, 3, 6) --Касание тьмы
local specWarnDarkReconstitution		= mod:NewSpecialWarningSwitch(249113, "Dps|Tank", nil, nil, 3, 3) --Темное восстановление
local specWarnBurningRemnant			= mod:NewSpecialWarningYouMove(245022, nil, nil, nil, 1, 2) --Пылающий след

--General/Mythic
local timerFocusingPower				= mod:NewCastTimer(15, 251356, nil, nil, nil, 6) --Фокусирование силы
local timerDarkReconstitution			= mod:NewCastTimer(15, 249113, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON..DBM_CORE_MYTHIC_ICON) --Темное восстановление
mod:AddTimerLine(Fharg)
local timerBurningMawCD					= mod:NewCDTimer(11, 251448, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON) --Пылающая пасть
local timerMoltenTouchCD				= mod:NewCDTimer(95.9, 244163, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON..DBM_CORE_MYTHIC_ICON) --Жаркая вспышка
local timerDesolateGazeCD				= mod:NewCDTimer(95.9, 244768, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Опустошающий взгляд
local timerEnflamedCorruptionCD			= mod:NewCDTimer(95.9, 244057, nil, nil, nil, 7) --Возгорание порчи
local timerEnflamedCorruption			= mod:NewCastTimer(10, 244057, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Возгорание порчи
mod:AddTimerLine(Shatug)
local timerCorruptingMawCD				= mod:NewCDTimer(11, 251447, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON) --Заразная пасть
local timerComsumingSphereCD			= mod:NewCDTimer(77, 244131, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON..DBM_CORE_MYTHIC_ICON) --Поглощаяющая сфера
local timerWeightOfDarknessCD			= mod:NewCDTimer(77, 254429, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Бремя тьмы
local timerSiphonCorruptionCD			= mod:NewCDTimer(77, 244056, nil, nil, nil, 7) --Вытягивание порчи
local timerSiphonCorruption				= mod:NewCastTimer(10, 244056, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Вытягивание порчи

local yellTouched						= mod:NewPosYell(244054, DBM_CORE_AUTO_YELL_CUSTOM_POSITION, nil, nil, "YELL") --Касание пламени и тьмы
local yellMoltenTouch					= mod:NewYell(244072, nil, nil, nil, "YELL") --Касание магмы
local yellWeightOfDarkness				= mod:NewYell(254429, nil, nil, nil, "YELL") --Бремя тьмы
local yellWeightOfDarknessFades			= mod:NewShortFadesYell(254429, nil, nil, nil, "YELL") --Бремя тьмы
local yellEnflamed						= mod:NewShortFadesYell(248815, nil, nil, nil, "YELL") --Возгорание
local yellDesolateGaze					= mod:NewYell(244768, nil, nil, nil, "YELL") --Опустошающий взгляд
local yellDesolateGazeFades				= mod:NewShortFadesYell(244768, nil, nil, nil, "YELL") --Опустошающий взгляд
local yellSiphoned						= mod:NewYell(248819, nil, nil, nil, "YELL") --Вытягивание
local yellSiphonedFades					= mod:NewShortFadesYell(248819, nil, nil, nil, "YELL") --Вытягивание

local berserkTimer						= mod:NewBerserkTimer(600)

--Шатуг
local countdownSiphonCorruption			= mod:NewCountdown(77, 244056, nil, nil, 5) --Вытягивание порчи
local countdownComsumingSphere			= mod:NewCountdown(77, 244131, nil, nil, 5) --Поглощаяющая сфера
local countdownWeightOfDarkness			= mod:NewCountdown(77, 254429, nil, nil, 5) --Бремя тьмы
--local countdownCorruptingMaw			= mod:NewCountdown("AltTwo10", 251447, "Tank", nil, 3) --Заразная пасть
--Фарг
local countdownEnflamedCorruption		= mod:NewCountdown("Alt95.9", 244057, nil, nil, 5) --Возгорание порчи
local countdownDesolateGaze				= mod:NewCountdown("Alt95.9", 244768, nil, nil, 5) --Опустошающий взгляд
--local countdownBurningMaw				= mod:NewCountdown("AltTwo10", 251448, "Tank", nil, 3) --Пылающая пасть

local countdownDarkReconstitution		= mod:NewCountdownFades(15, 249113, nil, nil, 5) --Темное восстановление

mod:AddSetIconOption("SetIconOnWeightofDarkness", 254429, true, false, {5, 4, 3, 2, 1}) --Бремя тьмы
--mod:AddInfoFrameOption(239154, true)
mod:AddRangeFrameOption("5/8")

mod.vb.WeightDarkIcon = 0
mod.vb.longTimer = 95.9
mod.vb.mediumTimer = 77
local FlameTouched = false
local Shadowtouched = false
local shadow = replaceSpellLinks(244055) --Касание Тьмы
local flame = replaceSpellLinks(244054) --Касание пламени

local function UpdateAllTimers(self)
--	countdownBurningMaw:Cancel()
--	countdownCorruptingMaw:Cancel()
	--Fire Doggo
	timerBurningMawCD:Stop()
	if timerMoltenTouchCD:GetTime() > 0 then
		timerMoltenTouchCD:AddTime(15) --Касание магмы
	end
	if timerDesolateGazeCD:GetTime() > 0 then
		timerDesolateGazeCD:AddTime(15) --Опустошающий взгляд
		countdownDesolateGaze:Cancel() --Опустошающий взгляд
	end
	if timerEnflamedCorruptionCD:GetTime() > 0 then
		specWarnEnflamed2:Cancel() --Возгорание порчи
		timerEnflamedCorruptionCD:AddTime(15) --Возгорание порчи
		countdownEnflamedCorruption:Cancel() --Возгорание порчи
	end
	--Shadow Doggo
	timerCorruptingMawCD:Stop()
	if timerComsumingSphereCD:GetTime() > 0 then
		specWarnComsumingSphere2:Cancel()
		timerComsumingSphereCD:AddTime(15) --Поглощаяющая сфера
		countdownComsumingSphere:Cancel() --Поглощаяющая сфера
	end
	if timerWeightOfDarknessCD:GetTime() > 0 then
		specWarnWeightOfDarkness2:Cancel()
		timerWeightOfDarknessCD:AddTime(15) --Бремя тьмы
		countdownWeightOfDarkness:Cancel() --Бремя тьмы
	end
	if timerSiphonCorruptionCD:GetTime() > 0 then
		specWarnSiphoned2:Cancel()
		timerSiphonCorruptionCD:AddTime(15) --Вытягивание порчи
		countdownSiphonCorruption:Cancel() --Вытягивание порчи
	end
end
--Шатуг (Всё прошляпано Мурчалем)
local function UpdateShatugAndProshlyapMurchalTimers(self)
	timerCorruptingMawCD:Cancel()
	if timerComsumingSphereCD:GetTime() <= 15 then --Поглощаяющая сфера +
		specWarnComsumingSphere2:Cancel()
		timerComsumingSphereCD:Cancel()
		countdownComsumingSphere:Cancel()
	end
	if timerWeightOfDarknessCD:GetTime() <= 15 then --Бремя тьмы +
		specWarnWeightOfDarkness2:Cancel()
		timerWeightOfDarknessCD:Cancel()
		countdownWeightOfDarkness:Cancel()
	end
	if timerSiphonCorruptionCD:GetTime() <= 15 then --Вытягивание порчи +
		specWarnSiphoned2:Cancel()
		timerSiphonCorruptionCD:Cancel()
		countdownSiphonCorruption:Cancel()
	end
end
--Фарг (Всё прошляпано Мурчалем)
local function UpdateFhargAndProshlyapMurchalTimers(self)
	timerBurningMawCD:Cancel()
	if timerMoltenTouchCD:GetTime() <= 15 then --Жаркая вспышка
		timerMoltenTouchCD:Cancel()
	end
	if timerDesolateGazeCD:GetTime() <= 15 then --Опустошающий взгляд
		timerDesolateGazeCD:Cancel()
		countdownDesolateGaze:Cancel()
	end
	if timerEnflamedCorruptionCD:GetTime() <= 15 then --Возгорание порчи
		specWarnEnflamed2:Cancel()
		timerEnflamedCorruptionCD:Cancel()
		countdownEnflamedCorruption:Cancel()
	end
end

function mod:OnCombatStart(delay)
	if self:AntiSpam(10, 1) then
		--Do nothing, it just disables UpdateAllTimers/Focused Power from firing on pull
	end
	self.vb.WeightDarkIcon = 0
	--Fire doggo
	berserkTimer:Start(-delay)
	timerBurningMawCD:Start(9-delay) --Пылающая пасть+++ (под героик точно)
	timerCorruptingMawCD:Start(11-delay) --Заразная пасть+++ (под героик точно)
	if self:IsMythic() then
		FlameTouched = false
		Shadowtouched = false
		self.vb.longTimer = 88.3--88.3-89
		self.vb.mediumTimer = 71.4--71.4-73
		timerMoltenTouchCD:Start(21.5-delay) --Жаркая вспышка+++
		timerSiphonCorruptionCD:Start(25.3-delay) --Вытягивание порчи+++
		countdownSiphonCorruption:Start(25.3-delay) --Вытягивание порчи+++
		specWarnSiphoned2:Schedule(15.3-delay) --Вытягивание порчи+++
	--	specWarnSiphoned2:ScheduleVoice(15.3-delay, "aesoon") --Вытягивание порчи+++
		timerEnflamedCorruptionCD:Start(49.5-delay) --Возгорание порчи+++
		countdownEnflamedCorruption:Start(49.5-delay) --Возгорание порчи+++
		specWarnEnflamed2:Schedule(39.5) --Возгорание порчи+++
	elseif self:IsHeroic() then
		self.vb.longTimer = 95.9
		self.vb.mediumTimer = 77
		timerMoltenTouchCD:Start(21.6-delay) --Жаркая вспышка+++
		timerSiphonCorruptionCD:Start(26.2-delay) --Вытягивание порчи+++
		countdownSiphonCorruption:Start(26.2-delay) --Вытягивание порчи+++
		specWarnSiphoned2:Schedule(16.2-delay) --Вытягивание порчи+++
	--	specWarnSiphoned2:ScheduleVoice(16.2-delay, "aesoon") --Вытягивание порчи+++
		timerEnflamedCorruptionCD:Start(52.5-delay) --Возгорание порчи+++
		countdownEnflamedCorruption:Start(52.5-delay) --Возгорание порчи+++
		specWarnEnflamed2:Schedule(42.5) --Возгорание порчи+++
	else
		self.vb.longTimer = 104
		self.vb.mediumTimer = 85
		--Molten touch not even cast
		if not self:IsLFR() then
			timerSiphonCorruptionCD:Start(27.4-delay) --Вытягивание порчи+++
			countdownSiphonCorruption:Start(27.4-delay) --Вытягивание порчи+++
			specWarnSiphoned2:Schedule(17.4-delay) --Вытягивание порчи+++
		--	specWarnSiphoned2:ScheduleVoice(17.4-delay, "aesoon") --Вытягивание порчи+++
			timerEnflamedCorruptionCD:Start(55.6-delay) --Возгорание порчи+++
			countdownEnflamedCorruption:Start(55.6-delay) --Возгорание порчи+++
			specWarnEnflamed2:Schedule(45.6) --Возгорание порчи
		end
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(5)--Molten Touch (assumed)
	end
end

function mod:OnCombatEnd()
	timerWeightOfDarknessCD:Stop()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 244057 then --Возгорание порчи
		warnEnflamedCorruption:Show()
		if self:IsHeroic() then
			timerEnflamedCorruption:Start() --Возгорание порчи
			timerBurningMawCD:Stop()
			timerEnflamedCorruptionCD:Start(98) --Возгорание порчи
			countdownEnflamedCorruption:Start(98) --Возгорание порчи
			specWarnEnflamed2:Schedule(88) --Возгорание порчи
			timerDesolateGazeCD:Start(33) --Опустошающий взгляд+++
			countdownDesolateGaze:Start(33) --Опустошающий взгляд+++
			timerBurningMawCD:Start(10)
		elseif self:IsMythic() then
			timerEnflamedCorruption:Start(15) --Возгорание порчи
			timerBurningMawCD:Stop()
			timerEnflamedCorruptionCD:Start(90) --Возгорание порчи+++
			countdownEnflamedCorruption:Start(90) --Возгорание порчи+++
			specWarnEnflamed2:Schedule(80) --Возгорание порчи+++
			timerDesolateGazeCD:Start(29.9) --Опустошающий взгляд
			countdownDesolateGaze:Start(29.9) --Опустошающий взгляд
			timerBurningMawCD:Start(16)
		else --обычка и лфр
			timerEnflamedCorruption:Start() --Возгорание порчи
			timerEnflamedCorruptionCD:Start(104) --Возгорание порчи+++
			countdownEnflamedCorruption:Start(104) --Возгорание порчи+++
			specWarnEnflamed2:Schedule(94) --Возгорание порчи
			timerDesolateGazeCD:Start(34) --Опустошающий взгляд+++
			countdownDesolateGaze:Start(34) --Опустошающий взгляд+++
		end
	elseif spellId == 244056 then --Вытягивание порчи
		warnSiphonCorruption:Show()
		if self:IsHeroic() then
			timerSiphonCorruption:Start() --Вытягивание порчи
			timerCorruptingMawCD:Stop()
			timerSiphonCorruptionCD:Start(79) --Вытягивание порчи+++
			countdownSiphonCorruption:Start(79) --Вытягивание порчи+++
			specWarnSiphoned2:Schedule(69) --Вытягивание порчи+++
		--	specWarnSiphoned2:ScheduleVoice(69, "aesoon") --Вытягивание порчи+++
			timerComsumingSphereCD:Start(26) --Поглощаяющая сфера+++
			countdownComsumingSphere:Start(26) --Поглощаяющая сфера+++
			specWarnComsumingSphere2:Schedule(16) --Поглощаяющая сфера+++
		--	specWarnComsumingSphere2:ScheduleVoice(16, "specialsoon")
			timerWeightOfDarknessCD:Start(52) --Бремя тьмы+++
			countdownWeightOfDarkness:Start(52) --Бремя тьмы+++
			specWarnWeightOfDarkness2:Schedule(42) --Бремя тьмы
			timerCorruptingMawCD:Start(10)
		elseif self:IsMythic() then
			timerSiphonCorruption:Start(15) --Вытягивание порчи
			timerCorruptingMawCD:Stop()
			timerSiphonCorruptionCD:Start(72) --Вытягивание порчи+++
			countdownSiphonCorruption:Start(72) --Вытягивание порчи+++
			specWarnSiphoned2:Schedule(59) --Вытягивание порчи+++
		--	specWarnSiphoned2:ScheduleVoice(59, "aesoon") --Вытягивание порчи+++
			timerComsumingSphereCD:Start(24) --Поглощаяющая сфера+++
			countdownComsumingSphere:Start(24) --Поглощаяющая сфера+++
			specWarnComsumingSphere2:Schedule(14) --Поглощаяющая сфера+++
		--	specWarnComsumingSphere2:ScheduleVoice(14, "specialsoon")
			timerWeightOfDarknessCD:Start(47) --Бремя тьмы+++
			countdownWeightOfDarkness:Start(47) --Бремя тьмы+++
			specWarnWeightOfDarkness2:Schedule(37) --Бремя тьмы+++
			timerCorruptingMawCD:Start(16)
		else --обычка и лфр
			timerSiphonCorruption:Start() --Вытягивание порчи
			timerSiphonCorruptionCD:Start(85) --Вытягивание порчи+++
			countdownSiphonCorruption:Start(85) --Вытягивание порчи+++
			specWarnSiphoned2:Schedule(75) --Вытягивание порчи+++
		--	specWarnSiphoned2:ScheduleVoice(75, "aesoon") --Вытягивание порчи+++
			timerComsumingSphereCD:Start(28) --Поглощаяющая сфера+++
			countdownComsumingSphere:Start(28) --Поглощаяющая сфера+++
			specWarnComsumingSphere2:Schedule(18) --Поглощаяющая сфера+++
		--	specWarnComsumingSphere2:ScheduleVoice(18, "specialsoon")
		end
	elseif spellId == 249113 then --Темное восстановление
		warnDarkReconstitution:Show(args.sourceName)
		timerDarkReconstitution:Start()
		countdownDarkReconstitution:Start()
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if cid == 122477 then --Фарг
			if FlameTouched then
				if not UnitIsDeadOrGhost("player") then
					specWarnDarkReconstitution:Show()
				--	specWarnDarkReconstitution:Play("mobkill")
				end
			end
			UpdateFhargAndProshlyapMurchalTimers(self)
		elseif cid == 122135 then --Шатуг
			if Shadowtouched then
				if not UnitIsDeadOrGhost("player") then
					specWarnDarkReconstitution:Show()
				--	specWarnDarkReconstitution:Play("mobkill")
				end
			end
			UpdateShatugAndProshlyapMurchalTimers(self)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 244086 and self:AntiSpam(3, 2) then --Касание магмы (244072 изначальный) 
		if not UnitIsDeadOrGhost("player") then
			specWarnMoltenTouch:Show()
		--	specWarnMoltenTouch:Play("watchstep")
		end
		if self:IsMythic() then
			timerMoltenTouchCD:Start(88.8)
		elseif self:IsHeroic() then
			timerMoltenTouchCD:Start(98)
		end
--[[	elseif spellId == 251445 then
		warnBurningMaw:Show(args.destName)
		if self:IsMythic() then
			timerBurningMawCD:Start(9.7)
			if self:CheckInterruptFilter(args.sourceGUID, true) then
				countdownBurningMaw:Start(9.7)
			end
		else
			timerBurningMawCD:Start()
			if self:CheckInterruptFilter(args.sourceGUID, true) then
				countdownBurningMaw:Start()
			end
		end
	elseif spellId == 245098 then
		warnCorruptingMaw:Show(args.destName)
		timerCorruptingMawCD:Start()
		if self:CheckInterruptFilter(args.sourceGUID, true) then
			countdownCorruptingMaw:Start()
		end]]
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 244768 then --Опустошающий взгляд
		warnDesolateGaze:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnDesolateGaze:Show()
		--	specWarnDesolateGaze:Play("runout")
			yellDesolateGaze:Yell()
			yellDesolateGazeFades:Countdown(8, 3)
		end
	elseif spellId == 251356 and self:AntiSpam(10, 1) then --Фокусирование силы
		warnFocusingPower:Show()
		timerFocusingPower:Start()
		UpdateAllTimers(self)
	elseif spellId == 248815 then --Возгорание
		if args:IsPlayer() then
			specWarnEnflamed:Show()
		--	specWarnEnflamed:Play("scatter")
			yellEnflamed:Countdown(3)
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8)
			end
		end
	elseif spellId == 248819 then --Вытягивание
		if args:IsPlayer() then
			specWarnSiphoned:Show()
		--	specWarnSiphoned:Play("gathershare")
			yellSiphoned:Yell()
			yellSiphonedFades:Countdown(3, 2)
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8)
			end
		end
	elseif spellId == 254429 then --Бремя тьмы
		self.vb.WeightDarkIcon = self.vb.WeightDarkIcon + 1
		warnWeightofDarkness:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnWeightOfDarkness:Show()
		--	specWarnWeightOfDarkness:Play("gathershare")
			yellWeightOfDarkness:Yell()
			yellWeightOfDarknessFades:Countdown(5, 3)
		end
		if self.Options.SetIconOnWeightofDarkness then
			self:SetIcon(args.destName, self.vb.WeightDarkIcon)
		end
	elseif spellId == 244071 then --Бремя тьмы
		warnWeightofDarkness3:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			yellWeightOfDarkness:Yell()
		end
	elseif spellId == 244054 then --Касание пламени
		if args:IsPlayer() then
			FlameTouched = true
			specWarnFlameTouched:Show(self:IconNumToTexture(7))--Red X for flame (more voted on red x than orange circle)
		--	specWarnFlameTouched:Play("flameonyou")
			yellTouched:Yell(7, flame, 7)
		end
	elseif spellId == 244055 then --Касание тьмы
		if args:IsPlayer() then
			Shadowtouched = true
			specWarnShadowtouched:Show(self:IconNumToTexture(3))--Purple diamond for shadow
		--	specWarnShadowtouched:Play("shadowonyou")
			yellTouched:Yell(3, shadow, 3)
		end
	elseif spellId == 251448 then --Пылающая пасть
		if self:IsMythic() then
			timerBurningMawCD:Start(10.5)
		else
			timerBurningMawCD:Start() --Под нормал точно 11
		end
	elseif spellId == 251447 then --Заразная пасть
		if self:IsMythic() then
			timerCorruptingMawCD:Start(10.5)
		else
			timerCorruptingMawCD:Start() --Под нормал точно 11
		end
	elseif spellId == 244072 then --Касание магмы
		warnMoltenTouch:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			yellMoltenTouch:Yell()
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 248815 then --Возгорание
		if args:IsPlayer() then
			yellEnflamed:Cancel()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(5)
			end
		end
	elseif spellId == 248819 then --Вытягивание
		if args:IsPlayer() then
			yellSiphonedFades:Cancel()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(5)
			end
		end
	elseif spellId == 254429 then --Бремя тьмы
		self.vb.WeightDarkIcon = self.vb.WeightDarkIcon - 1
		if self.Options.SetIconOnWeightofDarkness then
			self:RemoveIcon(args.destName)
		end
		if args:IsPlayer() then
			yellWeightOfDarknessFades:Cancel()
		end
	elseif spellId == 244054 then --Касание пламени
		if args:IsPlayer() then
			FlameTouched = false
		end
	elseif spellId == 244055 then --Касание тьмы
		if args:IsPlayer() then
			Shadowtouched = false
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 245022 and destGUID == UnitGUID("player") and self:AntiSpam(3, "hidden") then
		specWarnBurningRemnant:Show()
	--	specWarnBurningRemnant:Play("runout")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 244159 then --Поглощаяющая сфера (разрабы починили? нихуя себе)
		if not UnitIsDeadOrGhost("player") then
			specWarnComsumingSphere:Show()
		--	specWarnComsumingSphere:Play("watchorb")
		end
		DBM:Debug("checking proshlyapation of Murchal 1", 2)
	elseif spellId == 244064 then --Опустошающий взгляд
		DBM:Debug("checking proshlyapation of Murchal 2", 2)
	elseif spellId == 244069 then --Бремя Тьмы
		DBM:Debug("checking proshlyapation of Murchal 3", 2)
	end
end
