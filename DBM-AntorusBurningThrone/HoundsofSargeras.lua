local mod	= DBM:NewMod(1987, "DBM-AntorusBurningThrone", nil, 946)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(122477, 122135)--122477 F'harg, 122135 Shatug
mod:SetEncounterID(2074)
mod:SetZone()
mod:SetBossHPInfoToHighest()
mod:SetUsedIcons(5, 4, 3, 2, 1)
mod:SetHotfixNoticeRev(16949)
mod.respawnTime = 29--Guessed, it's not 4 anymore

mod:RegisterCombat("combat")
--mod:RegisterCombat("yell", L.YellPullHounds)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 244057 244056 249113",
	"SPELL_CAST_SUCCESS 244072 251445 245098 244086",
	"SPELL_AURA_APPLIED 244768 248815 254429 248819 244054 244055 251356 251447 251448",
	"SPELL_AURA_REMOVED 244768 248815 254429 248819 251356 244054 244055",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2"
)

local Fharg = DBM:EJ_GetSectionInfo(15842)
local Shatug = DBM:EJ_GetSectionInfo(15836)
--[[
(ability.id = 244057 or ability.id = 244056) and type = "begincast"
 or (ability.id = 244072 or ability.id = 251445 or ability.id = 245098 or ability.id = 251356 or ability.id = 254429) and type = "cast"
--]]
--F'harg
local warnDesolateGaze					= mod:NewTargetAnnounce(244768, 3) --Опустошающий взгляд
local warnEnflamedCorruption			= mod:NewSpellAnnounce(244057, 3) --Возгорание порчи
--local warnEnflamed						= mod:NewTargetAnnounce(248815, 3) --Возгорание
local warnMoltenTouch					= mod:NewSpellAnnounce(244072, 2) --Касание магмы
--Shatug
local warnWeightofDarkness				= mod:NewTargetAnnounce(254429, 3) --Бремя тьмы
local warnSiphonCorruption				= mod:NewSpellAnnounce(244056, 3) --Вытягивание порчи
local warnSiphoned						= mod:NewTargetAnnounce(248819, 3, nil, false, 2) --Вытягивание
--General/Mythic
local warnFocusingPower					= mod:NewSpellAnnounce(251356, 2) --Фокусирование силы
local warnDarkReconstitution			= mod:NewTargetSourceAnnounce(249113, 3) --Темное восстановление

--F'harg
local specWarnMoltenTouch				= mod:NewSpecialWarningDodge(244072, nil, nil, nil, 2, 2) --Касание магмы
local specWarnDesolateGaze				= mod:NewSpecialWarningYouMoveAway(244768, nil, nil, nil, 1, 5) --Опустошающий взгляд
local specWarnEnflamed					= mod:NewSpecialWarningYouMoveAway(248815, nil, nil, nil, 1, 5) --Возгорание
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)
--Shatug
local specWarnComsumingSphere			= mod:NewSpecialWarningDodge(244131, nil, nil, nil, 2, 2) --Поглощаяющая сфера
local specWarnWeightOfDarkness			= mod:NewSpecialWarningYouShare(254429, nil, nil, nil, 3, 5) --Бремя тьмы
local specWarnSiphoned					= mod:NewSpecialWarningYouShare(248819, nil, nil, nil, 3, 5) --Вытягивание
--Mythic
local specWarnFlameTouched				= mod:NewSpecialWarningYouPos(244054, nil, nil, nil, 3, 5) --Касание пламени
local specWarnShadowtouched				= mod:NewSpecialWarningYouPos(244055, nil, nil, nil, 3, 5) --Касание тьмы
local specWarnDarkReconstitution		= mod:NewSpecialWarningSwitch(249113, "-Healer", nil, nil, 3, 3) --Темное восстановление

--General/Mythic
local timerFocusingPower				= mod:NewCastTimer(15, 251356, nil, nil, nil, 6) --Фокусирование силы
local timerDarkReconstitution			= mod:NewCastTimer(15, 249113, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON..DBM_CORE_MYTHIC_ICON) --Темное восстановление
mod:AddTimerLine(Fharg)
local timerBurningMawCD					= mod:NewCDTimer(11, 251448, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON) --Пылающая пасть
local timerMoltenTouchCD				= mod:NewCDTimer(95.9, 244072, nil, nil, nil, 3) --Касание магмы
local timerEnflamedCorruptionCD			= mod:NewCDTimer(95.9, 244057, nil, nil, nil, 7) --Возгорание порчи
local timerDesolateGazeCD				= mod:NewCDTimer(95.9, 244768, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Опустошающий взгляд
mod:AddTimerLine(Shatug)
local timerCorruptingMawCD				= mod:NewCDTimer(11, 251447, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON) --Заразная пасть
local timerComsumingSphereCD			= mod:NewCDTimer(77, 244131, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Поглощаяющая сфера
local timerWeightOfDarknessCD			= mod:NewCDTimer(77, 254429, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Бремя тьмы
local timerSiphonCorruptionCD			= mod:NewCDTimer(77, 244056, nil, nil, nil, 7) --Вытягивание порчи

local yellTouched						= mod:NewPosYell(244054, DBM_CORE_AUTO_YELL_CUSTOM_POSITION) --Касание пламени и тьмы
local yellWeightOfDarkness				= mod:NewYell(254429, nil, nil, nil, "YELL") --Бремя тьмы
local yellWeightOfDarknessFades			= mod:NewShortFadesYell(254429, nil, nil, nil, "YELL") --Бремя тьмы
local yellEnflamed						= mod:NewShortFadesYell(248815, nil, nil, nil, "YELL") --Возгорание
local yellDesolateGaze					= mod:NewYell(244768, nil, nil, nil, "YELL") --Опустошающий взгляд
local yellSiphoned						= mod:NewShortFadesYell(248819, nil, nil, nil, "YELL") --Вытягивание

local berserkTimer						= mod:NewBerserkTimer(600)

--F'harg
local countdownBurningMaw				= mod:NewCountdown("Alt10", 251448, "Tank", nil, 3) --Пылающая пасть
--Shatug
local countdownCorruptingMaw			= mod:NewCountdown("Alt10", 251447, "Tank", nil, 3) --Заразная пасть

local countdownDarkReconstitution		= mod:NewCountdownFades(15, 249113, nil, nil, 5) --Темное восстановление

mod:AddSetIconOption("SetIconOnWeightofDarkness2", 254429, true, false, {5, 4, 3, 2, 1}) --Бремя тьмы
--mod:AddInfoFrameOption(239154, true)
mod:AddRangeFrameOption("5/8")
mod:AddBoolOption("SequenceTimers", false)

mod.vb.WeightDarkIcon = 0
mod.vb.longTimer = 95.9
mod.vb.mediumTimer = 77
local FlameTouched = false
local Shadowtouched = false

local function UpdateAllTimers(self)
	countdownBurningMaw:Cancel()
	countdownCorruptingMaw:Cancel()
	--Fire Doggo
	timerBurningMawCD:Stop()
	if timerMoltenTouchCD:GetTime() > 0 then
		timerMoltenTouchCD:AddTime(15) --Касание магмы
	end
	if timerDesolateGazeCD:GetTime() > 0 then
		timerDesolateGazeCD:AddTime(15) --Опустошающий взгляд
	end
	if timerEnflamedCorruptionCD:GetTime() > 0 then
		timerEnflamedCorruptionCD:AddTime(15) --Возгорание порчи
	end
	--Shadow Doggo
	timerCorruptingMawCD:Stop()
	if timerComsumingSphereCD:GetTime() > 0 then
		timerComsumingSphereCD:AddTime(15) --Поглощаяющая сфера
	end
	if timerWeightOfDarknessCD:GetTime() > 0 then
		timerWeightOfDarknessCD:AddTime(15) --Бремя тьмы
	end
	if timerSiphonCorruptionCD:GetTime() > 0 then
		timerSiphonCorruptionCD:AddTime(15) --Вытягивание порчи
	end
end

function mod:OnCombatStart(delay)
	if self:AntiSpam(10, 1) then
		--Do nothing, it just disables UpdateAllTimers/Focused Power from firing on pull
	end
	self.vb.WeightDarkIcon = 0
	--Fire doggo
	berserkTimer:Start(-delay)
	timerBurningMawCD:Start(9-delay) --Пылающая пасть
	timerCorruptingMawCD:Start(12-delay) --Заразная пасть
	--Shadow doggo
	if self:IsMythic() then
		FlameTouched = false
		Shadowtouched = false
		self.vb.longTimer = 88.3--88.3-89
		self.vb.mediumTimer = 71.4--71.4-73
		timerMoltenTouchCD:Start(21.5-delay) --Касание магмы+++
		timerSiphonCorruptionCD:Start(25.5-delay) --Вытягивание порчи+++
		timerEnflamedCorruptionCD:Start(49.6-delay) --Возгорание порчи +1.2 сек
	elseif self:IsHeroic() then
		self.vb.longTimer = 95.9
		self.vb.mediumTimer = 77
		timerMoltenTouchCD:Start(22-delay) --Касание магмы+++
		timerSiphonCorruptionCD:Start(26.2-delay) --Вытягивание порчи+++
		timerEnflamedCorruptionCD:Start(52.6-delay) --Возгорание порчи+++
	else
		self.vb.longTimer = 104
		self.vb.mediumTimer = 85
		--Molten touch not even cast
		if not self:IsLFR() then
			timerSiphonCorruptionCD:Start(27.4-delay) --Вытягивание порчи+++
			timerEnflamedCorruptionCD:Start(55.6-delay) --Возгорание порчи+++
		end
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(5)--Molten Touch (assumed)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.SetIconOnWeightofDarkness2 then
		self:SetIcon(args.destName, 0)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 244057 then --Возгорание порчи
		warnEnflamedCorruption:Show()
		if self:IsHeroic() then
			timerEnflamedCorruptionCD:Start(95.9) --Возгорание порчи
			timerDesolateGazeCD:Start(33) --Опустошающий взгляд+++
			if timerBurningMawCD:GetTime() < 9 then
				timerBurningMawCD:Start(10)
			end
		elseif self:IsMythic() then
			timerEnflamedCorruptionCD:Start(89.5) --Возгорание порчи
			timerDesolateGazeCD:Start(30) --Опустошающий взгляд
			if timerBurningMawCD:GetTime() < 9 then
				timerBurningMawCD:Start(16)
			end
		else --обычка и лфр
			timerEnflamedCorruptionCD:Start(104) --Возгорание порчи+++
			timerDesolateGazeCD:Start(34) --Опустошающий взгляд+++
		end
	elseif spellId == 244056 then --Вытягивание порчи
		warnSiphonCorruption:Show()
		if self:IsHeroic() then
			timerSiphonCorruptionCD:Start(79) --Вытягивание порчи+++
			timerComsumingSphereCD:Start(26) --Поглощаяющая сфера+++
			specWarnComsumingSphere:Schedule(26) --Поглощаяющая сфера+++
			specWarnComsumingSphere:ScheduleVoice(26, "watchorb") --Поглощаяющая сфера+++
			timerWeightOfDarknessCD:Start(52) --Бремя тьмы+++ (уже пофиксил с нового видео за 27 число)
			if timerCorruptingMawCD:GetTime() < 9 then
				timerCorruptingMawCD:Start(10)
			end
		elseif self:IsMythic() then
			timerSiphonCorruptionCD:Start(72) --Вытягивание порчи+++
			timerComsumingSphereCD:Start(24) --Поглощаяющая сфера
			specWarnComsumingSphere:Schedule(24) --Поглощаяющая сфера
			specWarnComsumingSphere:ScheduleVoice(24, "watchorb") --Поглощаяющая сфера
			timerWeightOfDarknessCD:Start(47) --Бремя тьмы вроде точно
			if timerCorruptingMawCD:GetTime() < 9 then
				timerCorruptingMawCD:Start(16)
			end
		else --обычка и лфр
			timerSiphonCorruptionCD:Start(85) --Вытягивание порчи+++
			timerComsumingSphereCD:Start(28) --Поглощаяющая сфера+++
			specWarnComsumingSphere:Schedule(28) --Поглощаяющая сфера+++
			specWarnComsumingSphere:ScheduleVoice(28, "watchorb") --Поглощаяющая сфера+++
		end
	elseif spellId == 249113 then --Темное восстановление
		warnDarkReconstitution:Show(args.sourceName)
		timerDarkReconstitution:Start()
		countdownDarkReconstitution:Start()
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if cid == 122477 then --Фарг
			if args:IsPlayer() and FlameTouched then
				specWarnDarkReconstitution:Show()
				specWarnDarkReconstitution:Play("killmob")
			end
		elseif cid == 122135 then --Шатуг
			if args:IsPlayer() and Shadowtouched then
				specWarnDarkReconstitution:Show()
				specWarnDarkReconstitution:Play("killmob")
			end
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 244086 and self:AntiSpam(3, 1) then --Касание магмы (244072 изначальный) 
	--	warnMoltenTouch:Show()
	--	warnMoltenTouch:Play("watchstep")
		specWarnMoltenTouch:Show()
		specWarnMoltenTouch:Play("watchstep")
		if not self.Options.SequenceTimers or self:IsEasy() then
			timerMoltenTouchCD:Start(self.vb.longTimer)
		else
			if self:IsMythic() then
				timerEnflamedCorruptionCD:Start(30.5)
			else
				timerEnflamedCorruptionCD:Start(33)--33-34.2
			end
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
	if spellId == 244768 then
		warnDesolateGaze:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnDesolateGaze:Show()
			specWarnDesolateGaze:Play("runout")
			yellDesolateGaze:Yell()
		end
	elseif spellId == 251356 and self:AntiSpam(10, 1) then --Фокусирование силы
		warnFocusingPower:Show()
		timerFocusingPower:Start()
		UpdateAllTimers(self)
	elseif spellId == 248815 then --Возгорание
	--	warnEnflamed:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnEnflamed:Show()
			specWarnEnflamed:Play("scatter")
			yellEnflamed:Countdown(3)
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8)
			end
		end
	elseif spellId == 248819 then --Вытягивание
		warnSiphoned:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnSiphoned:Show()
			specWarnSiphoned:Play("gathershare")
			yellSiphoned:Countdown(3)
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8)
			end
		end
	elseif spellId == 254429 then
		self.vb.WeightDarkIcon = self.vb.WeightDarkIcon + 1
		warnWeightofDarkness:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnWeightOfDarkness:Show()
			specWarnWeightOfDarkness:Play("gathershare")
			yellWeightOfDarkness:Yell()
			yellWeightOfDarknessFades:Countdown(5, 3)
		end
		if self.Options.SetIconOnWeightofDarkness2 then
			self:SetIcon(args.destName, self.vb.WeightDarkIcon)
		end
	elseif spellId == 244054 then --Касание пламени
		if args:IsPlayer() then
			FlameTouched = true
			specWarnFlameTouched:Show(self:IconNumToTexture(7))--Red X for flame (more voted on red x than orange circle)
			specWarnFlameTouched:Play("flameonyou")
			yellTouched:Yell(7, "", 7)
		end
	elseif spellId == 244055 then --Касание тьмы
		if args:IsPlayer() then
			Shadowtouched = true
			specWarnShadowtouched:Show(self:IconNumToTexture(3))--Purple diamond for shadow
			specWarnShadowtouched:Play("shadowonyou")
			yellTouched:Yell(3, "", 3)
		end
	elseif spellId == 251448 then --Пылающая пасть
		if self:IsMythic() then
			timerBurningMawCD:Start(10.5)
		else
			timerCorruptingMawCD:Start() --Под нормал точно 11
		end
	elseif spellId == 251447 then --Заразная пасть
		if self:IsMythic() then
			timerCorruptingMawCD:Start(10.5)
		else
			timerCorruptingMawCD:Start() --Под нормал точно 11
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
			yellSiphoned:Cancel()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(5)
			end
		end
	elseif spellId == 254429 then
		if self.Options.SetIconOnWeightofDarkness2 then
			self:SetIcon(args.destName, 0)
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

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show()
		specWarnGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc, _, _, target)
	if msg:find("spell:238502") then

	end
end
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 244159 then--Consuming Sphere
		specWarnComsumingSphere:Show()
		specWarnComsumingSphere:Play("watchorb")
--[[		if not self.Options.SequenceTimers or self:IsEasy() then
			timerComsumingSphereCD:Start(self.vb.mediumTimer)
		else
			if self:IsMythic() then
				timerWeightOfDarknessCD:Start(24.3)
			else
				timerWeightOfDarknessCD:Start(25.6)--25.6-27
			end
		end]]
	elseif spellId == 244064 then --Опустошающий взгляд
--[[		if not self.Options.SequenceTimers or self:IsEasy() then
			timerDesolateGazeCD:Start(self.vb.longTimer)
		else
			if self:IsMythic() then
				timerMoltenTouchCD:Start(29.2)
			else
				timerMoltenTouchCD:Start(31.6)--31.6-33
			end
		end]]
	elseif spellId == 244069 then--Weight of Darkness
		self.vb.WeightDarkIcon = 0
--[[		if not self.Options.SequenceTimers or self:IsEasy() then
			timerWeightOfDarknessCD:Start(self.vb.mediumTimer)
		else
			if self:IsMythic() then
				timerSiphonCorruptionCD:Start(24.3)
			else
				timerSiphonCorruptionCD:Start(26.7)--26.7-26.9
			end
		end]]
	end
end
