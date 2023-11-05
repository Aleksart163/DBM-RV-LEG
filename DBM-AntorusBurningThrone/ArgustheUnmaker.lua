local mod	= DBM:NewMod(2031, "DBM-AntorusBurningThrone", nil, 946)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17742 $"):sub(12, -3))
mod:SetCreatureID(124828)
mod:SetEncounterID(2092)
mod:SetZone()
mod:SetBossHPInfoToHighest()--Because of heal on mythic
mod:SetUsedIcons(8, 7, 6, 5, 4, 3)
mod:SetHotfixNoticeRev(17742)
mod:SetMinSyncRevision(17742)
mod:DisableIEEUCombatDetection()
mod.respawnTime = 30

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 248165 248317 257296 255594 257645 252516 256542 255648 257619 256544",
	"SPELL_CAST_SUCCESS 248499 258039 258838 252729 252616 256388 258029 251570 257619 255826",
	"SPELL_AURA_APPLIED 248499 248396 250669 251570 255199 253021 255496 255496 255478 252729 252616 255433 255430 255429 255425 255422 255419 255418 258647 258646 257869 257931 257966 258838 256388 257299 258029",
	"SPELL_AURA_APPLIED_DOSE 248499 258039 258838 257299",
	"SPELL_AURA_REMOVED 250669 251570 255199 253021 255496 255496 255478 255433 255430 255429 255425 255422 255419 255418 248499 258039 257966 258647 258646 258838 248396 257869",
	"SPELL_INTERRUPT",
	"SPELL_PERIODIC_DAMAGE 248167",
	"SPELL_PERIODIC_MISSED 248167",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_DIED",
	"UNIT_HEALTH boss1",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5"
)

--Аргус Порабощенный https://ru.wowhead.com/npc=124828/аргус-порабощенный/эпохальный-журнал-сражений
local warnPhase						= mod:NewPhaseChangeAnnounce(1) --Фаза
local warnPrePhase2					= mod:NewPrePhaseAnnounce(2, 1)
local warnPrePhase3					= mod:NewPrePhaseAnnounce(3, 1)
local warnPrePhase4					= mod:NewPrePhaseAnnounce(4, 1)
local warnReapSoul					= mod:NewTargetSourceAnnounce(256542, 4) --Жатва душ
local warnEndofAllThings			= mod:NewTargetSourceAnnounce(256544, 4) --Конец всего сущего
--Stage One: Storm and Sky
local warnTorturedRage				= mod:NewCountAnnounce(257296, 2) --Ярость порабощенного
local warnSweepingScythe			= mod:NewStackAnnounce(248499, 2, nil, "Tank|Healer") --Сметающая коса
local warnBlightOrb					= mod:NewCountAnnounce(248317, 2) --Чумная сфера
local warnSkyandSea					= mod:NewTargetAnnounce(255594, 1) --Небо и море
--Stage one Mythic
local warnSargRage					= mod:NewTargetAnnounce(257869, 3) --Ярость Саргераса
local warnSargFear					= mod:NewTargetAnnounce(257931, 3) --Страх перед Саргерасом
--Stage Two: The Protector Redeemed
local warnSoulburst					= mod:NewTargetAnnounce(250669, 2) --Взрывная душа
local warnSoulbomb					= mod:NewTargetNoFilterAnnounce(251570, 4) --Бомба души
local warnSoulbomb2					= mod:NewEndTargetAnnounce(251570, 4) --Бомба души
local warnAvatarofAggra				= mod:NewTargetNoFilterAnnounce(255199, 1) --Аватара Агграмара
--Stage Three: The Arcane Masters
--local warnCosmicBeaconCast			= mod:NewCastAnnounce(252616, 2) --Космический маяк
local warnCosmicBeacon				= mod:NewTargetAnnounce(252616, 2) --Космический маяк
local warnDiscsofNorg				= mod:NewCastAnnounce(252516, 1) --Диски Норганнона
--Stage Three Mythic
local warnSargSentence				= mod:NewTargetAnnounce(257966, 4) --Приговор Саргераса
local warnEdgeofAnni				= mod:NewCountAnnounce(258834, 4) --Грань аннигиляции
local warnSoulRendingScythe			= mod:NewStackAnnounce(258838, 2, nil, "Tank|Healer") --Рассекающая коса
--Stage Four: The Gift of Life, The Forge of Loss (Non Mythic)
local warnGiftOfLifebinder			= mod:NewCastAnnounce(257619, 1) --Дар Хранительницы жизни
local warnDeadlyScythe				= mod:NewStackAnnounce(258039, 2, nil, "Tank|Healer") --Смертоносная коса

local specWarnEndofAllThings		= mod:NewSpecialWarningInterrupt(256544, "HasInterrupt", nil, nil, 3, 6) --Конец всего сущего
--Stage One: Storm and Sky
local specWarnSweepingScythe		= mod:NewSpecialWarningStack(248499, nil, 3, nil, nil, 3, 5) --Сметающая коса
local specWarnSweepingScytheTaunt	= mod:NewSpecialWarningTaunt(248499, "Tank", nil, nil, 3, 2) --Сметающая коса
local specWarnConeofDeath			= mod:NewSpecialWarningDodge(248165, nil, nil, nil, 2, 2) --Конус смерти
local specWarnSoulblight			= mod:NewSpecialWarningYouMoveAway(248396, nil, nil, nil, 5, 6) --Изнуряющая чума
local specWarnGiftofSea				= mod:NewSpecialWarningYouMoveAway(258647, nil, nil, nil, 3, 6) --Дар моря
local specWarnGiftofSky				= mod:NewSpecialWarningYouMoveAway(258646, nil, nil, nil, 3, 6) --Дар небес
--Mythic P1
local specWarnSargGaze				= mod:NewSpecialWarningPreWarn(258068, nil, 5, nil, nil, 3, 6) --Пристальный взгляд Саргераса
local specWarnSargRage				= mod:NewSpecialWarningMoveAway(257869, nil, nil, nil, 3, 6) --Ярость Саргераса
local specWarnSargFear				= mod:NewSpecialWarningShare(257931, nil, nil, nil, 3, 6) --Страх перед Саргерасом
local specWarnGTFO					= mod:NewSpecialWarningYouMove(248167, nil, nil, nil, 1, 2) --Смертоносный туман
--Stage Two: The Protector Redeemed
local specWarnSoulburst				= mod:NewSpecialWarningYouMoveAway(250669, nil, nil, nil, 1, 2) --Взрывная душа
local specWarnSoulbomb				= mod:NewSpecialWarningYouMoveAway(251570, nil, nil, nil, 5, 6) --Бомба души 
local specWarnSoulbombMoveTo		= mod:NewSpecialWarningMoveTo(251570, nil, nil, nil, 1, 2) --Бомба души
local specWarnEdgeofObliteration	= mod:NewSpecialWarningDodge(255826, nil, nil, nil, 2, 2) --Коса разрушения
local specWarnAvatarofAggra			= mod:NewSpecialWarningYou(255199, nil, nil, nil, 1, 2) --Аватара Агграмара
--Stage Three: The Arcane Masters
local specWarnCosmicRay				= mod:NewSpecialWarningYouMoveAway(252729, nil, nil, nil, 1, 2) --Космический луч
--Stage Three Mythic
local specWarnSargSentence			= mod:NewSpecialWarningYouDontMove(257966, nil, nil, nil, 5, 6) --Приговор Саргераса
local specWarnEdgeofAnni			= mod:NewSpecialWarningDodge(258834, nil, nil, nil, 2, 2) --Грань аннигиляции
local specWarnSoulrendingScythe		= mod:NewSpecialWarningStack(258838, nil, 2, nil, nil, 3, 2) --Рассекающая коса
local specWarnSoulrendingScytheTaunt= mod:NewSpecialWarningTaunt(258838, nil, nil, nil, 1, 2) --Рассекающая коса
--Stage Four: The Gift of Life, The Forge of Loss (Non Mythic)
local specWarnEmberofRage			= mod:NewSpecialWarningDodge(257299, nil, nil, nil, 2, 2) --Глыбы ярости
local specWarnDeadlyScythe			= mod:NewSpecialWarningStack(258039, nil, 3, nil, nil, 1, 2) --Смертоносная коса
local specWarnDeadlyScytheTaunt		= mod:NewSpecialWarningTaunt(258039, nil, nil, nil, 1, 2) --Смертоносная коса
local specWarnApocModule			= mod:NewSpecialWarningSwitchCount(258007, "-Healer", nil, nil, 3, 6) --Модуль апокалипсиса (мифик)
local specWarnReorgModule			= mod:NewSpecialWarningSwitch(256389, "RangedDps", nil, nil, 3, 6) --Модуль пересозидания
local specWarnReorgModule2			= mod:NewSpecialWarningSoon(256389, "RangedDps", nil, nil, 1, 3) --Модуль пересозидания

local timerNextPhase				= mod:NewPhaseTimer(74)
--Stage 1
mod:AddTimerLine(SCENARIO_STAGE:format(1))
local timerSweepingScytheCD			= mod:NewCDCountTimer(5.6, 248499, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON) --Сметающая коса 5.6-15.7
local timerConeofDeathCD			= mod:NewCDCountTimer(21, 248165, nil, nil, nil, 3) --Конус смерти (под героик норм)
local timerBlightOrbCD				= mod:NewCDCountTimer(25, 248317, nil, nil, nil, 3) --Чумная сфера (под героик норм)
local timerTorturedRageCD			= mod:NewCDCountTimer(13, 257296, nil, nil, nil, 2, nil, DBM_CORE_HEALER_ICON) --Ярость порабощенного 13-16
local timerSkyandSeaCD				= mod:NewCDCountTimer(24.9, 255594, nil, nil, nil, 7) --Небо и море 24.9-27.8
--Stage 2
mod:AddTimerLine(SCENARIO_STAGE:format(2))
local timerSoulBombCD				= mod:NewNextTimer(42, 251570, nil, nil, nil, 3, nil, DBM_CORE_HEALER_ICON..DBM_CORE_DEADLY_ICON) --Бомба души
local timerSoulBomb					= mod:NewTargetTimer(15, 251570, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON..DBM_CORE_MYTHIC_ICON) --Бомба души
local timerSoulBurstCD				= mod:NewNextCountTimer("d42", 250669, nil, nil, nil, 3) --Взрывная душа
local timerEdgeofObliterationCD		= mod:NewCDCountTimer(34, 255826, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Коса разрушения
local timerAvatarofAggraCD			= mod:NewCDTimer(59.9, 255199, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON) --Аватара Агграмара
--Stage 3
mod:AddTimerLine(SCENARIO_STAGE:format(3))
local timerDiscsofNorg				= mod:NewCastTimer(12, 252516, nil, nil, nil, 7) --Диски Норганнона
local timerAddsCD					= mod:NewAddsTimer(14, 253021, nil, nil, nil, 1, nil, DBM_CORE_TANK_ICON..DBM_CORE_DAMAGE_ICON) --треш
--Stage 4
mod:AddTimerLine(SCENARIO_STAGE:format(4))
local timerDeadlyScytheCD			= mod:NewCDTimer(5.5, 258039, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON..DBM_CORE_DEADLY_ICON) --Смертоносная коса
local timerReorgModuleCD			= mod:NewCDTimer(48, 256389, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON..DBM_CORE_MYTHIC_ICON) --Модуль пересозидания
local timerReapSoul					= mod:NewCastTimer(14, 256542, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Жатва душ
local timerEndofAllThings			= mod:NewCastTimer(15, 256544, nil, nil, nil, 2, nil, DBM_CORE_INTERRUPT_ICON..DBM_CORE_DEADLY_ICON) --Конец всего сущего
--Mythic
mod:AddTimerLine(ENCOUNTER_JOURNAL_SECTION_FLAG12)
local timerSargGazeCD				= mod:NewCDCountTimer(35, 258068, nil, nil, nil, 3, nil, DBM_CORE_MYTHIC_ICON..DBM_CORE_DEADLY_ICON) --Пристальный взгляд Саргераса
local timerApocModuleCD				= mod:NewCDCountTimer(48, 258007, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON..DBM_CORE_MYTHIC_ICON) --Модуль апокалипсиса
local timerSoulrendingScytheCD		= mod:NewCDTimer(8.5, 258838, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON) --Рассекающая коса
local timerSargSentenceCD			= mod:NewTimer(35.2, "timerSargSentenceCD", 257966, nil, nil, 3, DBM_CORE_MYTHIC_ICON..DBM_CORE_DEADLY_ICON) --Приговор Саргераса
local timerEdgeofAnniCD				= mod:NewCDTimer(5.5, 258834, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Грань аннигиляции

local yells = {
yellGiftofSky						= mod:NewYell(258646, L.SkyText, nil, nil, "YELL"), --Дар небес
yellGiftofSky2						= mod:NewFadesYell(258646, nil, nil, nil, "YELL"), --Дар небес
yellGiftofSea						= mod:NewYell(258647, L.SeaText, nil, nil, "YELL"), --Дар моря
yellGiftofSea2						= mod:NewFadesYell(258647, nil, nil, nil, "YELL"), --Дар моря
yellSoulblightFades					= mod:NewShortFadesYell(248396, nil, nil, nil, "YELL"), --Изнуряющая чума
yellSoulblight						= mod:NewYell(248396, L.Blight2, nil, nil, "YELL"), --Изнуряющая чума
yellSargRage						= mod:NewYell(257869, L.Rage, nil, nil, "YELL"), --Ярость Саргераса
yellSargFear						= mod:NewYell(257931, L.Fear, nil, nil, "YELL"), --Страх перед Саргерасом
yellSargFearCombo					= mod:NewComboYell(257931, 5782, nil, nil, "YELL"), --Страх перед Саргерасом
yellSoulbomb						= mod:NewPosYell(251570, DBM_CORE_AUTO_YELL_CUSTOM_POSITION, nil, nil, "YELL"), --Бомба души
yellSoulbombFades					= mod:NewIconFadesYell(251570, 155188, nil, nil, "YELL"), --Бомба души
yellSoulburst						= mod:NewPosYell(250669, DBM_CORE_AUTO_YELL_CUSTOM_POSITION, nil, nil, "YELL"), --Взрывная душа
yellSoulburstFades					= mod:NewIconFadesYell(250669, nil, nil, nil, "YELL"), --Взрывная душа
yellSargSentence					= mod:NewYell(257966, nil, nil, nil, "YELL"), --Приговор Саргераса
yellSargSentenceFades				= mod:NewShortFadesYell(257966, nil, nil, nil, "YELL"), --Приговор Саргераса
yellCosmicRay						= mod:NewYell(252729, nil, nil, nil, "YELL") --Космический луч
}

local berserkTimer					= mod:NewBerserkTimer(600)
--Stage One: Storm and Sky
local countdownSweapingScythe		= mod:NewCountdown("Alt5", 248499, false, nil, 3) --Сметающая коса Off by default since it'd be almost non stop, so users can elect into this one
local countdownSargGaze				= mod:NewCountdown(35, 258068, nil, nil, 5) --Пристальный взгляд Саргераса
local countdownSkyandSea			= mod:NewCountdown("AltTwo24.9", 255594, nil, nil, 3) --Небо и море
--Stage Two: The Protector Redeemed
local countdownSoulbomb				= mod:NewCountdown("AltTwo50", 251570, nil, nil, 5) --Бомба души
local countdownSoulbomb2			= mod:NewCountdownFades("AltTwo15", 251570, nil, nil, 5) --Бомба души
--Stage Three: Mythic
local countdownSoulScythe			= mod:NewCountdown("Alt5", 258838, "Tank", nil, 3) --Рассекающая коса
--Stage Four
local countdownDeadlyScythe			= mod:NewCountdown("Alt5", 258039, false, nil, 3) --Смертоносная коса Off by default since it'd be almost non stop, so users can elect into this one
local countdownReorgModule			= mod:NewCountdown("Alt48", 256389, "RangedDps", nil, 5) --Модуль пересозидания
local countdownApocModule			= mod:NewCountdown("Alt48", 258029, "Dps", nil, 5) --Модуль апокалипсиса
local countdownEndofAllThings		= mod:NewCountdown(15, 256544, nil, nil, 5) --Конец всего сущего

mod:AddInfoFrameOption(nil, true)--Change to EJ entry since spell not localized
mod:AddRangeFrameOption(5, 257869) --Ярость Саргераса
mod:AddNamePlateOption("NPAuraOnInevitability", 253021)
mod:AddNamePlateOption("NPAuraOnCosmosSword", 255496)
mod:AddNamePlateOption("NPAuraOnEternalBlades", 255478)
mod:AddNamePlateOption("NPAuraOnVulnerability", 255418)
mod:AddSetIconOption("SetIconOnSoulBomb", 251570, true, false, {8}) --Бомба души
mod:AddSetIconOption("SetIconOnSoulBurst", 250669, true, false, {7, 3}) --Взрывная душа
mod:AddSetIconOption("SetIconGift", 255594, true, false, {6, 5}) --Небо и море 5 and 6
mod:AddSetIconOption("SetIconOnAvatar", 255199, true, false, {4}) --Аватара Агграмара 4
mod:AddBoolOption("ShowProshlyapationOfMurchal1", true)
mod:AddBoolOption("ShowProshlyapationOfMurchal2", true)
mod:AddBoolOption("AutoProshlyapMurchal", true)

local soulbomb = replaceSpellLinks(251570)
local soulburst = replaceSpellLinks(250669)
local sargerasGaze = replaceSpellLinks(258068) --Пристальный взгляд Саргераса
local apocalypsisModule = replaceSpellLinks(258029) --Модуль апокалипсиса
local reoriginationModule = replaceSpellLinks(256389) --Модуль пересозидания
local playerAvatar = false
mod.vb.phase = 1
mod.vb.kurators = 7
mod.vb.coneCount = 0
mod.vb.SkyandSeaCount = 0
mod.vb.blightOrbCount = 0
mod.vb.TorturedRage = 0
mod.vb.soulBurstIcon = 3
mod.vb.moduleCount = 0
mod.vb.EdgeofObliteration = 0
mod.vb.sentenceCount = 0
mod.vb.gazeCount = 0
mod.vb.scytheCastCount = 0
mod.vb.rangeCheckNoTouchy = false
local warned_preP1 = false
local warned_preP2 = false
local warned_preP3 = false
local warned_preP4 = false
local playerName = UnitName("player")
--P3 Mythic Timers
local torturedRage = {40, 40, 50, 30, 35, 10, 8, 35, 10, 8, 35}--3 timers from method video not logs, verify by logs to improve accuracy
local sargSentenceTimers = {53, 57, 60, 53, 53}--1 timer from method video not logs, verify by logs to improve accuracy
local apocModuleTimers = {30.1, 45.5, 45.5, 44, 51.5, 51.5} --новые и точные таймеры Модулей в мифике
local sargGazeTimers = {20, 75, 70, 53, 53} --новые и точные таймеры взгляда Саргераса
local edgeofAnni = {5, 5, 90, 5, 45, 5}--All timers from method video (6:05 P3 start, 6:10, 6:15, 7:45, 7:50, 8:35, 8:40)
--Both of these should be in fearCheck object for efficiency but with uncertainty of async, I don't want to come back and fix this later. Doing it this way ensures without a doubt it'll work by calling on load and again on combatstart
local tankStacks = {}

local function fearCheck(self)
	self:Unschedule(fearCheck)
	if DBM:UnitDebuff("player", 257931) then
		local comboActive = false
		if DBM:UnitDebuff("player", 250669) then
			yells.yellSargFearCombo:Yell(L.Burst)
			comboActive = true
		elseif DBM:UnitDebuff("player", 251570) then
			yells.yellSargFearCombo:Yell(L.Bomb)
			comboActive = true
		elseif DBM:UnitDebuff("player", 257966) then
			yells.yellSargFearCombo:Yell(L.Sentence)
			comboActive = true
		elseif DBM:UnitDebuff("player", 248396) then
			yells.yellSargFearCombo:Yell(L.Blight)
			comboActive = true
		end
	end
end

local function ToggleRangeFinder(self, hide) --взгляд Саргераса
	--1 фаза
	--1ый ок, 2ой ок, 3ий ок, 4-ый +1.5 сек задержка
	if self:IsTank() or not self.Options.RangeFrame then return end--Tanks don't get rage
	if not hide then
		if not UnitIsDeadOrGhost("player") then
			specWarnSargGaze:Show()
			specWarnSargGaze:Play("range5")
			DBM.RangeCheck:Show(5)
			self.vb.rangeCheckNoTouchy = true--Prevent SPELL_AURA_REMOVED of revious rage closing range finder during window we're expecting next rage
		end
	end
	if hide and not DBM:UnitDebuff("player", 257869) then
		DBM.RangeCheck:Hide()
		self.vb.rangeCheckNoTouchy = false
	end
end

local function startAnnihilationStuff(self, quiet)
	self.vb.EdgeofObliteration = self.vb.EdgeofObliteration + 1
	if quiet then--Second cast within 5 second period, do a quiet 2nd warn
		warnEdgeofAnni:Show(self.vb.EdgeofObliteration)
	else--Special warning
		if not UnitIsDeadOrGhost("player") then
			specWarnEdgeofAnni:Show(self.vb.EdgeofObliteration)
			specWarnEdgeofAnni:Play("watchstep")
		end
	end
	local timer = edgeofAnni[self.vb.EdgeofObliteration+1]
	if timer then
		timerEdgeofAnniCD:Start(timer, self.vb.EdgeofObliteration+1)
		self:Schedule(timer, startAnnihilationStuff, self, timer < 6)
	end
end

local function delayedBoonCheck(self)
	specWarnSoulbombMoveTo:Show(DBM_CORE_ROOM_EDGE)
	specWarnSoulbombMoveTo:Play("bombnow")--Detonate Soon makes more sense than "run to edge" which is still too assumptive
end

local updateInfoFrame
do
	local lines = {}
	local sortedLines = {}
	local function addLine(key, value)
		-- sort by insertion order
		lines[key] = value
		sortedLines[#sortedLines + 1] = key
	end
	updateInfoFrame = function()
		table.wipe(lines)
		table.wipe(sortedLines)
		--Boss Powers first
		for i = 1, 5 do
			local uId = "boss"..i
			--Primary Power
			local currentPower, maxPower = UnitPower(uId), UnitPowerMax(uId)
			if maxPower and maxPower ~= 0 then--Prevent division by 0 in addition to filtering non existing units that may still return false on UnitExists()
				if currentPower / maxPower * 100 >= 1 then
					addLine(UnitName(uId), currentPower)
				end
			end
			--Alternate Power
			local currentAltPower, maxAltPower = UnitPower(uId, 10), UnitPowerMax(uId, 10)
			if maxAltPower and maxAltPower ~= 0 then--Prevent division by 0 in addition to filtering non existing units that may still return false on UnitExists()
				if currentAltPower / maxAltPower * 100 >= 1 then
					addLine(UnitName(uId), currentAltPower)
				end
			end
		end
		--Tank Debuffs
		for i = 1, #tankStacks do
			local name = tankStacks[i]
			local uId = DBM:GetRaidUnitId(name)
			if not uId then break end
			local _, _, _, currentStack = DBM:UnitDebuff(uId, 248499, 258039, 258838)
			if currentStack then
				addLine(name, currentStack)
			end
		end
		return lines, sortedLines
	end
end

local function startProshlyapationOfMurchal1(self)
	smartChat(L.ProshlyapMurchal:format(DbmRV, sargerasGaze), "rw")
end

local function startProshlyapationOfMurchal2(self)
	if self:IsMythic() then
		smartChat(L.ProshlyapMurchal:format(DbmRV, apocalypsisModule), "rw")
	else
		smartChat(L.ProshlyapMurchal:format(DbmRV, reoriginationModule), "rw")
	end
end

local function startProshlyapationOfMurchal3(self)
	RepopMe()
end

local premsg_values = {
	args_destName,
	scheduleDelay,
	proshlyap1_rw, proshlyap2_rw
}
local playerOnlyName = UnitName("player")

local function sendAnnounce(self)
	if premsg_values.args_destName == nil then
		premsg_values.args_destName = "Unknown"
	end

	if premsg_values.proshlyap1_rw == 1 then
		self:Schedule(premsg_values.scheduleDelay, startProshlyapationOfMurchal1, self)
		premsg_values.proshlyap1_rw = 0
	elseif premsg_values.proshlyap2_rw == 1 then
		self:Schedule(premsg_values.scheduleDelay, startProshlyapationOfMurchal2, self)
		premsg_values.proshlyap2_rw = 0
	end

	premsg_values.args_destName = nil
	premsg_values.scheduleDelay = nil
end

local function announceList(premsg_announce, value)
	if premsg_announce == "premsg_ArgustheUnmaker_proshlyap1_rw" then
		premsg_values.proshlyap1_rw = value
	elseif premsg_announce == "premsg_ArgustheUnmaker_proshlyap2_rw" then
		premsg_values.proshlyap2_rw = value
	end
end

local function prepareMessage(self, premsg_announce, args_sourceName, args_destName, scheduleDelay)
	if self:AntiSpam(1, "prepareMessage") then
		premsg_values.args_destName = args_destName
		premsg_values.scheduleDelay = scheduleDelay
		announceList(premsg_announce, 1)
		self:SendSync(premsg_announce, playerOnlyName)
		self:Schedule(1, sendAnnounce, self)
	end
end

function mod:OnCombatStart(delay)
	playerAvatar = false
	table.wipe(tankStacks)
	self.vb.phase = 1
	self.vb.kurators = 7
	self.vb.coneCount = 0
	self.vb.SkyandSeaCount = 0
	self.vb.blightOrbCount = 0
	self.vb.TorturedRage = 0
	self.vb.soulBurstIcon = 3
	self.vb.EdgeofObliteration = 0
	self.vb.moduleCount = 0
	self.vb.sentenceCount = 0
	self.vb.gazeCount = 0
	self.vb.scytheCastCount = 0
	self.vb.rangeCheckNoTouchy = false
	warned_preP1 = false
	warned_preP2 = false
	warned_preP3 = false
	warned_preP4 = false
	timerSweepingScytheCD:Start(5.5-delay, 1)
	countdownSweapingScythe:Start(5.5)
	timerTorturedRageCD:Start(12-delay, 1)
	timerBlightOrbCD:Start(35-delay, 1) --Чумная сфера+++
	if self:IsMythic() then
		timerSweepingScytheCD:Start(6-delay, 1) --Смертоносная коса+++
		timerSargGazeCD:Start(8.5-delay, 1) --Пристальный взгляд Саргераса+++
		countdownSargGaze:Start(8.5) --Пристальный взгляд Саргераса+++
		if not DBM.Options.IgnoreRaidAnnounce2 and self.Options.ShowProshlyapationOfMurchal1 and DBM:GetRaidRank() > 0 then
			prepareMessage(self, "premsg_ArgustheUnmaker_proshlyap1_rw", nil, nil, 2.5)
		end
		self:Schedule(6, ToggleRangeFinder, self)--Call Show 5 seconds Before NEXT rages get applied (2 seconds before cast + 3 sec cast time)
		berserkTimer:Start(660-delay)
		timerSkyandSeaCD:Start(11-delay, 1) --Небо и море+++
		countdownSkyandSea:Start(11-delay)
		timerConeofDeathCD:Start(31-delay, 1) --Конус смерти+++
	elseif self:IsHeroic() then
		timerSweepingScytheCD:Start(5.5-delay, 1) --Смертоносная коса
		berserkTimer:Start(720-delay)
		timerSkyandSeaCD:Start(11-delay, 1) --Небо и море+++
		countdownSkyandSea:Start(11-delay) --Небо и море+++
		timerConeofDeathCD:Start(31-delay, 1)
	else
		timerSweepingScytheCD:Start(5.5-delay, 1) --Смертоносная коса
		berserkTimer:Start(720-delay)
		timerSkyandSeaCD:Start(10.1-delay, 1) --Небо и море+++
		countdownSkyandSea:Start(10.1-delay) --Небо и море+++
		timerConeofDeathCD:Start(30.3-delay, 1)
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Show(6, "function", updateInfoFrame, false, false)
	end
	if self.Options.NPAuraOnInevitability or self.Options.NPAuraOnCosmosSword or self.Options.NPAuraOnEternalBlades or self.Options.NPAuraOnVulnerability then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.NPAuraOnInevitability or self.Options.NPAuraOnCosmosSword or self.Options.NPAuraOnEternalBlades or self.Options.NPAuraOnVulnerability then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 248165 then
		self.vb.coneCount = self.vb.coneCount + 1
		if not UnitIsDeadOrGhost("player") then
			specWarnConeofDeath:Show()
			specWarnConeofDeath:Play("shockwave")
		end
		timerConeofDeathCD:Start(nil, self.vb.coneCount+1)
	elseif spellId == 256544 then --Конец всего сущего
		warnEndofAllThings:Show(args.sourceName)
		warnEndofAllThings:Play("kickcast")
		specWarnEndofAllThings:Schedule(12)
		specWarnEndofAllThings:ScheduleVoice(12, "kickcast")
		timerEndofAllThings:Start(15)
		countdownEndofAllThings:Start(15)
	elseif spellId == 248317 then
		self.vb.blightOrbCount = self.vb.blightOrbCount + 1
		warnBlightOrb:Show(self.vb.blightOrbCount)
		timerBlightOrbCD:Start(nil, self.vb.blightOrbCount+1)
	elseif spellId == 257296 then
		self.vb.TorturedRage = self.vb.TorturedRage + 1
		warnTorturedRage:Show(self.vb.TorturedRage)
		if self:IsMythic() and self.vb.phase == 3 then
			local timer = torturedRage[self.vb.TorturedRage+1]
			if timer then
				timerTorturedRageCD:Start(timer, self.vb.TorturedRage+1)
			end
		else
			timerTorturedRageCD:Start(nil, self.vb.TorturedRage+1)
		end
	elseif spellId == 255594 then --Небо и море
		self.vb.SkyandSeaCount = self.vb.SkyandSeaCount + 1
		if self:IsHeroic() then
			timerSkyandSeaCD:Start(25.5, self.vb.SkyandSeaCount+1)
			countdownSkyandSea:Start(25.5)
		elseif self:IsMythic() then
			timerSkyandSeaCD:Start(25.5, self.vb.SkyandSeaCount+1)
			countdownSkyandSea:Start(25.5)
		else
			timerSkyandSeaCD:Start(nil, self.vb.SkyandSeaCount+1)
			countdownSkyandSea:Start()
		end
	elseif spellId == 252516 then
		warnDiscsofNorg:Show()
		timerDiscsofNorg:Start()
	elseif spellId == 255648 then --Ярость Голганнета (фаза 2)
		self.vb.phase = 2
		self.vb.scytheCastCount = 0
		warned_preP2 = true
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(2))
		timerConeofDeathCD:Stop()
		timerBlightOrbCD:Stop()
		timerTorturedRageCD:Stop()
		timerSweepingScytheCD:Stop()
		countdownSweapingScythe:Cancel()
		timerSkyandSeaCD:Stop()
		countdownSkyandSea:Cancel()
		timerNextPhase:Start(15)
		timerSweepingScytheCD:Start(16.8, 1)
		countdownSweapingScythe:Start(16.8)
		timerAvatarofAggraCD:Start(24)
		timerEdgeofObliterationCD:Start(21, 1)
		timerSoulBombCD:Start(31) --Бомба души
		countdownSoulbomb:Start(31) --Бомба души
		timerSoulBurstCD:Start(31, 1) --Взрывная душа
		if self:IsMythic() then
			self:Unschedule(ToggleRangeFinder)
			self.vb.gazeCount = 0
			timerSargGazeCD:Stop()
			countdownSargGaze:Cancel()
			self:Unschedule(startProshlyapationOfMurchal1)
			timerSargGazeCD:Start(32, 1) --Пристальный взгляд Саргераса (было 26.7)
			countdownSargGaze:Start(32) --Пристальный взгляд Саргераса
			if not DBM.Options.IgnoreRaidAnnounce2 and self.Options.ShowProshlyapationOfMurchal1 and DBM:GetRaidRank() > 0 then
				prepareMessage(self, "premsg_ArgustheUnmaker_proshlyap1_rw", nil, nil, 26)
			end
			self:Schedule(29.5, ToggleRangeFinder, self)--Call Show 5 seconds Before NEXT rages get applied (2 seconds before cast + 3 sec cast time)
		end
	elseif spellId == 257645 then --Временной взрыв (Фаза 3)
		timerAvatarofAggraCD:Stop()--Always cancel this here, it's not canceled by argus becoming inactive and can still be cast during argus inactive transition phase
		if self.vb.phase < 3 then
			self:Unschedule(ToggleRangeFinder)
			self.vb.phase = 3
			warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(3))
			timerSweepingScytheCD:Stop()
			countdownSweapingScythe:Cancel()
			timerTorturedRageCD:Stop()
			timerSoulBombCD:Stop()
			countdownSoulbomb:Cancel()
			timerSoulBurstCD:Stop()
			timerEdgeofObliterationCD:Stop()
			timerAvatarofAggraCD:Stop()
			timerSargGazeCD:Stop()
			countdownSargGaze:Cancel()
			self:Unschedule(startProshlyapationOfMurchal1)
			if not self:IsMythic() then
				self.vb.kurators = 7
				timerAddsCD:Start(14) --точно под гер
				countdownSargGaze:Start(14)
				if self.Options.InfoFrame then
					DBM.InfoFrame:Hide()
				end
			end
		end
	elseif spellId == 256542 then --Жатва душ (под обычку таймер норм)
		warnReapSoul:Show(args.sourceName)
		timerReapSoul:Start()
		if not self:IsMythic() then
			self.vb.phase = 4
			if self.Options.InfoFrame then
				DBM.InfoFrame:Show(6, "function", updateInfoFrame, false, false)
			end
		end
		self:Unschedule(ToggleRangeFinder)
		timerDiscsofNorg:Stop()
		timerSargGazeCD:Stop()
		countdownSargGaze:Cancel()
		self:Unschedule(startProshlyapationOfMurchal1)
		timerNextPhase:Start(35)--or 53.8
	elseif spellId == 257619 then --Дар Хранительницы жизни (p4/p3mythic)
		warnGiftOfLifebinder:Show()
		if self.Options.AutoProshlyapMurchal then
			self:Schedule(11.1, startProshlyapationOfMurchal3, self)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 248499 then
		self.vb.scytheCastCount = self.vb.scytheCastCount + 1
		timerSweepingScytheCD:Start(5.6, self.vb.scytheCastCount+1)
		countdownSweapingScythe:Start(5.6)
	elseif spellId == 258039 then --Смертоносная коса
		timerDeadlyScytheCD:Start()
		countdownDeadlyScythe:Start(5.5)
	elseif spellId == 258838 then --Рассекающая коса (мифик)
		timerSoulrendingScytheCD:Start()
		countdownSoulScythe:Start(8.5)
	elseif spellId == 255826 then
		self.vb.EdgeofObliteration = self.vb.EdgeofObliteration + 1
		if not UnitIsDeadOrGhost("player") then
			specWarnEdgeofObliteration:Schedule(5)
			specWarnEdgeofObliteration:ScheduleVoice(5, "watchstep")
		end
		timerEdgeofObliterationCD:Start(nil, self.vb.EdgeofObliteration+1)
	elseif spellId == 251570 then --Бомба души
		countdownSoulbomb2:Start()
	elseif spellId == 257619 then --Дар Хранительницы жизни
		if not self:IsMythic() then
			warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(4))
		end
	elseif spellId == 256388 or spellId == 258029 then
		DBM:Debug("checking proshlyapation of Murchal 1", 2)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 248499 then --Сметающая коса (обычка/героик)
		local uId = DBM:GetRaidUnitId(args.destName)
		if uId and self:IsTanking(uId) then
			local amount = args.amount or 1
			if not tContains(tankStacks, args.destName) then
				table.insert(tankStacks, args.destName)
			end
			if amount == 3 then
				if args:IsPlayer() then
					specWarnSweepingScythe:Show(amount)
					specWarnSweepingScythe:Play("stackhigh")
				end
			elseif amount >= 4 then
				if args:IsPlayer() then
					specWarnSweepingScythe:Show(amount)
					specWarnSweepingScythe:Play("stackhigh")
				else--Taunt as soon as stacks are clear, regardless of stack count.
					local _, _, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
					local remaining
					if expireTime then
						remaining = expireTime-GetTime()
					end
					if not UnitIsDeadOrGhost("player") and (not remaining or remaining and remaining < 5.6) then
						specWarnSweepingScytheTaunt:Show(args.destName)
						specWarnSweepingScytheTaunt:Play("tauntboss")
					else
						warnSweepingScythe:Show(args.destName, amount)
					end
				end
			else
				warnSweepingScythe:Show(args.destName, amount)
			end
		end
	elseif spellId == 258039 then --Смертоносная коса (героик)
		local uId = DBM:GetRaidUnitId(args.destName)
		if uId and self:IsTanking(uId) then
			local amount = args.amount or 1
			if not tContains(tankStacks, args.destName) then
				table.insert(tankStacks, args.destName)
			end
			if amount >= 3 then
				if args:IsPlayer() then
					specWarnDeadlyScythe:Show(amount)
					specWarnDeadlyScythe:Play("stackhigh")
				else
					warnDeadlyScythe:Show(args.destName, amount)
				end
			end
		end
	elseif spellId == 258838 then --Рассекающая коса (мифик)
		local uId = DBM:GetRaidUnitId(args.destName)
		if uId and self:IsTanking(uId) then
			local amount = args.amount or 1
			if not tContains(tankStacks, args.destName) then
				table.insert(tankStacks, args.destName)
			end
			if amount >= 2 then
				if args:IsPlayer() then
					specWarnSoulrendingScythe:Show(amount)
					specWarnSoulrendingScythe:Play("stackhigh")
				else
					warnSoulRendingScythe:Show(args.destName, amount)
				end
			end
		end
	elseif spellId == 248396 then
		if args:IsPlayer() then
			specWarnSoulblight:Show()
			specWarnSoulblight:Play("runout")
			yells.yellSoulblight:Yell(playerName)
			yells.yellSoulblightFades:Countdown(8, 3)
			fearCheck(self)
		end
	elseif spellId == 250669 then --Взрывная душа
		warnSoulburst:CombinedShow(0.3, args.destName)--2 Targets
		if self.vb.soulBurstIcon > 7 then
			self.vb.soulBurstIcon = 3
		end
		local icon = self.vb.soulBurstIcon
		if args:IsPlayer() then
			specWarnSoulburst:Show()
			specWarnSoulburst:Play("targetyou")
			specWarnSoulburst:ScheduleVoice(self:IsMythic() and 7 or 10, "bombnow")
			yells.yellSoulburst:Yell(icon, soulburst, icon)
			yells.yellSoulburstFades:Countdown(self:IsMythic() and 12 or 15, 4, icon)
			fearCheck(self)
		end
		if self.Options.SetIconOnSoulBurst then
			self:SetIcon(args.destName, icon)
		end
		self.vb.soulBurstIcon = self.vb.soulBurstIcon + 4--Icons 3 and 7 used to match BW
	elseif spellId == 251570 then --Бомба души
		timerSoulBomb:Start(self:IsMythic() and 12 or 15, args.destName)
		if args:IsPlayer() then
			specWarnSoulbomb:Show()
			specWarnSoulbomb:Play("targetyou")--Would be better if bombrun was "bomb on you" and not "bomb on you, run". Since Don't want to give misinformation, generic it is
			self:Schedule(self:IsMythic() and 5 or 8, delayedBoonCheck, self)
			yells.yellSoulbomb:Yell(8, soulbomb, 8)
			yells.yellSoulbombFades:Countdown(self:IsMythic() and 12 or 15, 3, 8)
			fearCheck(self)
		elseif playerAvatar then
			specWarnSoulbombMoveTo:Show(args.destName)
			specWarnSoulbombMoveTo:Play("helpsoak")
		else
			warnSoulbomb:Show(args.destName)
		end
		if self.Options.SetIconOnSoulBomb then
			self:SetIcon(args.destName, 8)
		end
		if self.vb.phase == 4 then
			timerSoulBurstCD:Start(40, 2)
			timerSoulBombCD:Start(80)
			countdownSoulbomb:Start(80)
			timerSoulBurstCD:Start(80, 1)
		else
			timerSoulBurstCD:Start(20.1, 2) --все отличные таймеры
			timerSoulBombCD:Start(42)
			countdownSoulbomb:Start(42)
			timerSoulBurstCD:Start(42, 1)
		end
	elseif spellId == 255199 then
		if self.vb.phase == 2 then--Sometime gets cast once in p3, don't want to start timer if it does
			timerAvatarofAggraCD:Start()
		end
		if args:IsPlayer() then
			specWarnAvatarofAggra:Show()
			specWarnAvatarofAggra:Play("targetyou")
			playerAvatar = true
		else
			warnAvatarofAggra:Show(args.destName)
		end
		if self.Options.SetIconOnAvatar then
			self:SetIcon(args.destName, 4)
		end
	elseif spellId == 253021 then--Inevitability
		if self.Options.NPAuraOnInevitability then
			DBM.Nameplate:Show(true, args.destGUID, spellId, nil, 20)
		end
	elseif spellId == 255496 then--Sword of the Cosmos
		if self.Options.NPAuraOnCosmosSword then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 255478 then--Blades of the Eternal
		if self.Options.NPAuraOnEternalBlades then
			DBM.Nameplate:Show(true, args.destGUID, spellId, nil, 40)
		end
	elseif spellId == 252729 then --Космический луч
		if args:IsPlayer() and self:AntiSpam(2, "cosmic") then
			specWarnCosmicRay:Show()
			specWarnCosmicRay:Play("targetyou")
			yells.yellCosmicRay:Yell()
		end
	elseif spellId == 252616 then
		warnCosmicBeacon:CombinedShow(0.5, args.destName)
	elseif spellId == 258647 then --Дар моря
		warnSkyandSea:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnGiftofSea:Show()
			specWarnGiftofSea:Play("runout")
			yells.yellGiftofSea:Yell(playerName)
			yells.yellGiftofSea2:Countdown(5, 2)
		end
		if self.Options.SetIconGift then
			self:SetIcon(args.destName, 6)
		end
	elseif spellId == 258646 then --Дар небес
		warnSkyandSea:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnGiftofSky:Show()
			specWarnGiftofSky:Play("runout")
			yells.yellGiftofSky:Yell(playerName)
			yells.yellGiftofSky2:Countdown(5, 2)
		end
		if self.Options.SetIconGift then
			self:SetIcon(args.destName, 5)
		end
	elseif spellId == 255433 or spellId == 255430 or spellId == 255429 or spellId == 255425 or spellId == 255422 or spellId == 255419 or spellId == 255418 then--Vulnerability
		if self.Options.NPAuraOnVulnerability then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
		if self.Options.SetIconOnVulnerability then
			if spellId == 255433 then--Arcane
				self:ScanForMobs(args.destGUID, 2, 5, 1, 0.2, 15)
			elseif spellId == 255430 then--Shadow
				self:ScanForMobs(args.destGUID, 2, 3, 1, 0.2, 15)
			elseif spellId == 255429 then--Fire
				self:ScanForMobs(args.destGUID, 2, 2, 1, 0.2, 15)
			elseif spellId == 255425 then--Frost
				self:ScanForMobs(args.destGUID, 2, 6, 1, 0.2, 15)
			elseif spellId == 255422 then--Nature
				self:ScanForMobs(args.destGUID, 2, 4, 1, 0.2, 15)
			elseif spellId == 255419 then--Holy
				self:ScanForMobs(args.destGUID, 2, 1, 1, 0.2, 15)
			elseif spellId == 255418 then--Melee
				self:ScanForMobs(args.destGUID, 2, 7, 1, 0.2, 15)
			end
		end
	elseif spellId == 257869 then --Ярость Саргераса
		warnSargRage:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnSargRage:Show()
			specWarnSargRage:Play("scatter")
			yells.yellSargRage:Yell()
		end
	elseif spellId == 257931 then --Страх перед Саргерасом
		warnSargFear:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnSargFear:Show()
			specWarnSargFear:Play("gathershare")
			yells.yellSargFear:Yell()
			fearCheck(self)
		end
	elseif spellId == 257966 then --Приговор Саргераса
		if self:AntiSpam(5, 6) then
			self.vb.sentenceCount = self.vb.sentenceCount + 1
			local timer = sargSentenceTimers[self.vb.sentenceCount+1]
			if timer then
				timerSargSentenceCD:Start(timer, self.vb.sentenceCount+1)
			end
		end
		warnSargSentence:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnSargSentence:Show()
			specWarnSargSentence:Play("targetyou")
			yells.yellSargSentence:Yell()
			yells.yellSargSentenceFades:Countdown(30, 3)
			fearCheck(self)
		end
	elseif spellId == 256388 or spellId == 258029 then --Процесс инициализации (новый в об и гер) Schedule(46.5), ScheduleVoice(46.5, "killmob")
		self.vb.moduleCount = self.vb.moduleCount + 1
		if spellId == 258029 then --мифик
			if not UnitIsDeadOrGhost("player") then
				specWarnApocModule:Show(self.vb.moduleCount)
				specWarnApocModule:Play("mobkill")
			end
			local timer = apocModuleTimers[self.vb.moduleCount+1] or 46.5
			timerApocModuleCD:Start(timer, self.vb.moduleCount+1)
			countdownApocModule:Start(timer)
			if not DBM.Options.IgnoreRaidAnnounce2 and self.Options.ShowProshlyapationOfMurchal2 and DBM:GetRaidRank() > 0 then
				prepareMessage(self, "premsg_ArgustheUnmaker_proshlyap2_rw", nil, nil, timer-6)
			end
		elseif spellId == 256388 and self:AntiSpam(2, "reorgmodule") then --обычка и гер
			if not UnitIsDeadOrGhost("player") then
				specWarnReorgModule:Show()
				specWarnReorgModule:Play("mobkill")
			end
			timerReorgModuleCD:Start(46.5)
			countdownReorgModule:Start(46.5)
			if not DBM.Options.IgnoreRaidAnnounce2 and self.Options.ShowProshlyapationOfMurchal2 and DBM:GetRaidRank() > 0 then
				prepareMessage(self, "premsg_ArgustheUnmaker_proshlyap2_rw", nil, nil, 40.5)
			end
		end
		DBM:Debug("checking proshlyapation of Murchal 2", 2)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 250669 then
		if args:IsPlayer() then
			yells.yellSoulburstFades:Cancel()
			specWarnSoulburst:CancelVoice()
		end
		if self.Options.SetIconOnSoulBurst then
			self:RemoveIcon(args.destName)
		end
	elseif spellId == 251570 then --Бомба души
		warnSoulbomb2:Show(args.destName)
		timerSoulBomb:Cancel(args.destName)
		countdownSoulbomb2:Cancel()
		if args:IsPlayer() then
			self:Unschedule(delayedBoonCheck)
			yells.yellSoulbombFades:Cancel()
		end
		if self.Options.SetIconOnSoulBomb then
			self:RemoveIcon(args.destName)
		end
	elseif spellId == 255199 then
		if args:IsPlayer() then
			playerAvatar = false
		end
		if self.Options.SetIconOnAvatar then
			self:RemoveIcon(args.destName)
		end
	elseif spellId == 258647 then --Дар моря
		if args:IsPlayer() then
			yells.yellGiftofSea2:Cancel()
		end
		if self.Options.SetIconGift then
			self:RemoveIcon(args.destName)
		end
	elseif spellId == 258646 then --Дар небес
		if args:IsPlayer() then
			yells.yellGiftofSky2:Cancel()
		end
		if self.Options.SetIconGift then
			self:RemoveIcon(args.destName)
		end
	elseif spellId == 253021 then--Inevitability
		if self.Options.NPAuraOnInevitability then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 255496 then--Sword of the Cosmos
		if self.Options.NPAuraOnCosmosSword then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 255478 then--Blades of the Eternal
		if self.Options.NPAuraOnEternalBlades then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 255433 or spellId == 255430 or spellId == 255429 or spellId == 255425 or spellId == 255422 or spellId == 255419 or spellId == 255418 then--Vulnerability
		if self.Options.NPAuraOnVulnerability then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 248499 then --Сметающая коса (обычка)
		tDeleteItem(tankStacks, args.destName)
	elseif spellId == 258039 then --Смертоносная коса (героик)
		tDeleteItem(tankStacks, args.destName)
		local uId = DBM:GetRaidUnitId(args.destName)
		if uId and self:IsTanking(uId) then
			if not args:IsPlayer() then--Removed from tank that's not you (only time it's removed is on death)
				if self.vb.phase < 3 then
					specWarnDeadlyScytheTaunt:Show(args.destName)
					specWarnDeadlyScytheTaunt:Play("tauntboss")
				end
			end
		end
	elseif spellId == 258838 then --Рассекающая коса (мифик)
		tDeleteItem(tankStacks, args.destName)
		local uId = DBM:GetRaidUnitId(args.destName)
		if uId and self:IsTanking(uId) then
			if not args:IsPlayer() then--Removed from tank that's not you (only time it's removed is on death)
				specWarnSoulrendingScytheTaunt:Show(args.destName)
				specWarnSoulrendingScytheTaunt:Play("tauntboss")
			end
		end
	elseif spellId == 257966 then--Sentence of Sargeras
		if args:IsPlayer() then
			yells.yellSargSentenceFades:Cancel()
		end
	elseif spellId == 248396 and args:IsPlayer() then
		yells.yellSoulblightFades:Cancel()
	elseif spellId == 257869 then --Ярость Саргераса
		if args:IsPlayer() and self.Options.RangeFrame and not self.vb.rangeCheckNoTouchy then
			DBM.RangeCheck:Hide()
		end
	end
end

function mod:SPELL_INTERRUPT(args)
	if type(args.extraSpellId) == "number" and args.extraSpellId == 256544 then
		self.vb.TorturedRage = 0
		specWarnEndofAllThings:Cancel()
		timerEndofAllThings:Cancel()
		countdownEndofAllThings:Cancel()
		if self:IsMythic() then --Волосали
			self:Unschedule(ToggleRangeFinder)--Redundant, for good measure
			self.vb.gazeCount = 0
			self.vb.EdgeofObliteration = 0
			timerSoulrendingScytheCD:Start(4) --Рассекающая коса+++
			countdownSoulScythe:Start(4) --Рассекающая коса+++
			timerEdgeofAnniCD:Start(5, 1) --Грань аннигиляции+++
			self:Schedule(5, startAnnihilationStuff, self) --Грань аннигиляции
			timerSargGazeCD:Start(20, 1) --Пристальный взгляд Саргераса
			countdownSargGaze:Start(20) --Пристальный взгляд Саргераса
			if not DBM.Options.IgnoreRaidAnnounce2 and self.Options.ShowProshlyapationOfMurchal1 and DBM:GetRaidRank() > 0 then
				prepareMessage(self, "premsg_ArgustheUnmaker_proshlyap1_rw", nil, nil, 14)
			end
			self:Schedule(17.5, ToggleRangeFinder, self)--Call Show 5 seconds Before NEXT rages get applied (2 seconds before cast + 3 sec cast time)
			timerApocModuleCD:Start(30.1, 1)
			countdownApocModule:Start(30.1)
			if not DBM.Options.IgnoreRaidAnnounce2 and self.Options.ShowProshlyapationOfMurchal2 and DBM:GetRaidRank() > 0 then
				prepareMessage(self, "premsg_ArgustheUnmaker_proshlyap2_rw", nil, nil, 24.1)
			end
			timerTorturedRageCD:Start(40, 1)
			timerSargSentenceCD:Start(53, 1)
			--self:Schedule(63, checkForMissingSentence, self)
		else
			if not DBM.Options.IgnoreRaidAnnounce2 and self.Options.ShowProshlyapationOfMurchal2 and DBM:GetRaidRank() > 0 then
				prepareMessage(self, "premsg_ArgustheUnmaker_proshlyap2_rw", nil, nil, 7)
			end
			if self:IsHeroic() then
				timerDeadlyScytheCD:Start(5) --Смертоносная коса
				timerReorgModuleCD:Start(13)
				countdownReorgModule:Start(13)
			else
				timerSweepingScytheCD:Start(5, 1)
				countdownSweapingScythe:Start(5)
				timerReorgModuleCD:Start(13)
				countdownReorgModule:Start(13)
			end
--[[			local currentPowerPercent = UnitPower("boss1")/UnitPowerMax("boss1")
			local remainingPercent
			if currentPowerPercent then
				remainingPercent = 1.0 - currentPowerPercent
			end
			if remainingPercent then
				timerReorgModuleCD:Start(48.1*remainingPercent, 1)
				countdownReorgModule:Start(48.1*remainingPercent)
			end]]
			timerTorturedRageCD:Start(10, 1) --Ярость порабощенного
			timerSoulBurstCD:Start(20, 1) --Взрывная душа
			timerSoulBombCD:Start(20) --Бомба душа
			countdownSoulbomb:Start(20) --Бомба душа
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 248167 and destGUID == UnitGUID("player") and self:AntiSpam(2, 5) then
		specWarnGTFO:Show()
		specWarnGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:find("spell:258068") then --Пристальный взгляд Саргераса
		self.vb.gazeCount = self.vb.gazeCount + 1
		if self.vb.phase == 2 then
			timerSargGazeCD:Start(59.7, self.vb.gazeCount+1)
			countdownSargGaze:Start(59.7)
			if not DBM.Options.IgnoreRaidAnnounce2 and self.Options.ShowProshlyapationOfMurchal1 and DBM:GetRaidRank() > 0 then
				prepareMessage(self, "premsg_ArgustheUnmaker_proshlyap1_rw", nil, nil, 53.7)
			end
		elseif self.vb.phase == 3 then
			local timer = sargGazeTimers[self.vb.gazeCount+1]
			if timer then
				timerSargGazeCD:Start(timer, self.vb.gazeCount+1)
				countdownSargGaze:Start(timer)
				self:Unschedule(ToggleRangeFinder)
				self:Schedule(5, ToggleRangeFinder, self, true)--Call hide 2 seconds after rages go out, function will check player for debuff and decide
				self:Schedule(timer-2.5, ToggleRangeFinder, self)--Call Show 5 seconds Before NEXT rages get applied (2 seconds before cast + 3 sec cast time)
				if not DBM.Options.IgnoreRaidAnnounce2 and self.Options.ShowProshlyapationOfMurchal1 and DBM:GetRaidRank() > 0 then
					prepareMessage(self, "premsg_ArgustheUnmaker_proshlyap1_rw", nil, nil, timer-6)
				end
			end
		else--Stage 1
			timerSargGazeCD:Start(35, self.vb.gazeCount+1)
			countdownSargGaze:Start(35)
			self:Unschedule(ToggleRangeFinder)
			self:Schedule(5, ToggleRangeFinder, self, true)--Call hide 2 seconds after rages go out, function will check player for debuff and decide
			self:Schedule(32.5, ToggleRangeFinder, self)--Call Show 5 seconds Before NEXT rages get applied (2 seconds before cast + 3 sec cast time)
			if not DBM.Options.IgnoreRaidAnnounce2 and self.Options.ShowProshlyapationOfMurchal1 and DBM:GetRaidRank() > 0 then
				prepareMessage(self, "premsg_ArgustheUnmaker_proshlyap1_rw", nil, nil, 29)
			end
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 257300 and self:AntiSpam(5, 1) then--Ember of Rage
		if not UnitIsDeadOrGhost("player") then
			specWarnEmberofRage:Show()
			specWarnEmberofRage:Play("watchstep")
		end
	elseif spellId == 34098 and self.vb.phase == 2 then--ClearAllDebuffs (12 before Tempoeral Blast)
		self:Unschedule(ToggleRangeFinder)
		self.vb.phase = 3
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(3))
		timerSweepingScytheCD:Stop()
		countdownSweapingScythe:Cancel()
		timerTorturedRageCD:Stop()
		timerSoulBombCD:Stop()
		countdownSoulbomb:Cancel()
		timerSoulBurstCD:Stop()
		timerEdgeofObliterationCD:Stop()
		timerSargGazeCD:Stop()
		countdownSargGaze:Cancel()
		self:Unschedule(startProshlyapationOfMurchal1)
		if not self:IsMythic() then
			if self.Options.InfoFrame then
				DBM.InfoFrame:Hide()
			end
		end
	end
end

function mod:UNIT_HEALTH(uId)
	if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 124828 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.76 then --скоро фаза 2
		warned_preP1 = true
		warnPrePhase2:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
	elseif self.vb.phase == 2 and warned_preP2 and not warned_preP3 and self:GetUnitCreatureId(uId) == 124828 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.46 then --скоро фаза 3
		warned_preP3 = true
		warnPrePhase3:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
	elseif self.vb.phase == 2 and warned_preP3 and not warned_preP4 and self:GetUnitCreatureId(uId) == 124828 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.41 then --фаза 3
		warned_preP4 = true
		timerSweepingScytheCD:Stop()
		countdownSweapingScythe:Cancel()
		timerTorturedRageCD:Stop()
		timerSoulBombCD:Stop()
		countdownSoulbomb:Cancel()
		timerSoulBurstCD:Stop()
		timerEdgeofObliterationCD:Stop()
		timerAvatarofAggraCD:Stop()
		timerSargGazeCD:Stop()
		countdownSargGaze:Cancel()
		specWarnEdgeofObliteration:Cancel()
		specWarnEdgeofObliteration:CancelVoice()
		self:Unschedule(startProshlyapationOfMurchal1)
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 127192 then
		self.vb.kurators = self.vb.kurators - 1
		if self.vb.kurators == 1 then
			warnPrePhase4:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
		end
	end
end

function mod:OnSync(premsg_announce, sender)
	if sender < playerOnlyName then
		announceList(premsg_announce, 0)
	end
end
