local mod	= DBM:NewMod(2031, "DBM-AntorusBurningThrone", nil, 946)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(124828)
mod:SetEncounterID(2092)
mod:SetZone()
mod:SetBossHPInfoToHighest()--Because of heal on mythic
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
mod:SetHotfixNoticeRev(16993)
mod:SetMinSyncRevision(16895)
mod.respawnTime = 30

mod:RegisterCombat("combat")
--mod:RegisterCombat("combat_yell", L.YellPullArgus)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 248165 248317 257296 255594 257645 252516 256542 255648 257619 256544",
	"SPELL_CAST_SUCCESS 248499 258039 258838 252729 252616 256388 258029 251570",
	"SPELL_AURA_APPLIED 248499 248396 250669 251570 255199 253021 255496 255496 255478 252729 252616 255433 255430 255429 255425 255422 255419 255418 258647 258646 257869 257931 257966 258838 256388 257299",
	"SPELL_AURA_APPLIED_DOSE 248499 258039 258838 257299",
	"SPELL_AURA_REMOVED 250669 251570 255199 253021 255496 255496 255478 255433 255430 255429 255425 255422 255419 255418 248499 258039 257966 258647 258646 258838 248396 257869",
	"SPELL_INTERRUPT",
	"SPELL_PERIODIC_DAMAGE 248167",
	"SPELL_PERIODIC_MISSED 248167",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5",
	"UNIT_DIED",
	"UNIT_HEALTH boss1"
)

--Аргус Порабощенный https://ru.wowhead.com/npc=124828/аргус-порабощенный/эпохальный-журнал-сражений
local warnPhase						= mod:NewPhaseChangeAnnounce(1) --Фаза
--local warnPhase1					= mod:NewAnnounce("Phase1", 1, "Interface\\Icons\\Spell_Nature_WispSplode") --Скоро фаза 2
--local warnPhase2					= mod:NewAnnounce("Phase3", 1, "Interface\\Icons\\Spell_Nature_WispSplode") --Скоро фаза 3
--local warnPhase3					= mod:NewAnnounce("Phase5", 1, "Interface\\Icons\\Spell_Nature_WispSplode") --Скоро фаза 4
local warnPrePhase2					= mod:NewPrePhaseAnnounce(2, 1)
local warnPrePhase3					= mod:NewPrePhaseAnnounce(3, 1)
local warnPrePhase4					= mod:NewPrePhaseAnnounce(4, 1)
local warnReapSoul					= mod:NewTargetSourceAnnounce(256542, 4) --Жатва душ
local warnEndofAllThings			= mod:NewTargetSourceAnnounce(256544, 4) --Конец всего сущего
--Stage One: Storm and Sky
local warnTorturedRage				= mod:NewCountAnnounce(257296, 2) --Ярость порабощенного
local warnSweepingScythe			= mod:NewStackAnnounce(248499, 2, nil, "Tank|Healer") --Сметающая коса
local warnBlightOrb					= mod:NewCountAnnounce(248317, 2) --Чумная сфера
local warnSoulblight				= mod:NewTargetAnnounce(248396, 2, nil, false, 2) --Изнуряющая чума
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
local warnCosmicRay					= mod:NewTargetAnnounce(252729, 3) --Космический луч
--local warnCosmicBeaconCast			= mod:NewCastAnnounce(252616, 2) --Космический маяк
local warnCosmicBeacon				= mod:NewTargetAnnounce(252616, 2) --Космический маяк
local warnDiscsofNorg				= mod:NewCastAnnounce(252516, 1) --Диски Норганнона
--Stage Three Mythic
local warnSargSentence				= mod:NewTargetAnnounce(257966, 3) --Приговор Саргераса
local warnEdgeofAnni				= mod:NewCountAnnounce(258834, 4) --Грань аннигиляции
local warnSoulRendingScythe			= mod:NewStackAnnounce(258838, 2, nil, "Tank|Healer") --Рассекающая коса
--Stage Four: The Gift of Life, The Forge of Loss (Non Mythic)
local warnReorgModule				= mod:NewSpellAnnounce(256389, 3, nil, "-Ranged") --Модуль пересозидания
local warnGiftOfLifebinder			= mod:NewCastAnnounce(257619, 1) --Дар Хранительницы жизни
local warnDeadlyScythe				= mod:NewStackAnnounce(258039, 2, nil, "Tank|Healer") --Смертоносная коса

local specWarnEndofAllThings		= mod:NewSpecialWarningInterrupt(256544, "HasInterrupt", nil, nil, 3, 5) --Конец всего сущего
--Stage One: Storm and Sky
local specWarnSweepingScythe		= mod:NewSpecialWarningStack(248499, nil, 3, nil, nil, 3, 6) --Сметающая коса
local specWarnSweepingScytheTaunt	= mod:NewSpecialWarningTaunt(248499, "Tank", nil, nil, 3, 2) --Сметающая коса
local specWarnConeofDeath			= mod:NewSpecialWarningDodge(248165, nil, nil, nil, 1, 2) --Конус смерти
local specWarnSoulblight			= mod:NewSpecialWarningYouMoveAway(248396, nil, nil, nil, 1, 2) --Изнуряющая чума
local specWarnGiftofSea				= mod:NewSpecialWarningYouMoveAway(258647, nil, nil, nil, 3, 5) --Дар моря
local specWarnGiftofSky				= mod:NewSpecialWarningYouMoveAway(258646, nil, nil, nil, 3, 5) --Дар небес
--Mythic P1
local specWarnSargGaze				= mod:NewSpecialWarningPreWarn(258068, nil, 5, nil, nil, 1, 2)
local specWarnSargRage				= mod:NewSpecialWarningYouMoveAway(257869, nil, nil, nil, 3, 2) --Ярость Саргераса
local specWarnSargFear				= mod:NewSpecialWarningMoveTo(257931, nil, nil, nil, 3, 2) --Страх перед Саргерасом
local specWarnGTFO					= mod:NewSpecialWarningYouMove(248167, nil, nil, nil, 1, 2)
--Stage Two: The Protector Redeemed
local specWarnSoulburst				= mod:NewSpecialWarningYouMoveAway(250669, nil, nil, nil, 1, 2) --Взрывная душа
local specWarnSoulbomb				= mod:NewSpecialWarningYouMoveAway(251570, nil, nil, nil, 3, 5) --Бомба души 
local specWarnSoulbombMoveTo		= mod:NewSpecialWarningMoveTo(251570, nil, nil, nil, 1, 2) --Бомба души
local specWarnEdgeofObliteration	= mod:NewSpecialWarningDodge(255826, nil, nil, nil, 2, 2) --Коса разрушения
local specWarnAvatarofAggra			= mod:NewSpecialWarningYou(255199, nil, nil, nil, 1, 2) --Аватара Агграмара
--Stage Three: The Arcane Masters
local specWarnCosmicRay				= mod:NewSpecialWarningYouMoveAway(252729, nil, nil, nil, 1, 2) --Космический луч
--Stage Three Mythic
local specWarnSargSentence			= mod:NewSpecialWarningYou(257966, nil, nil, nil, 1, 2) --Приговор Саргераса
local specWarnApocModule			= mod:NewSpecialWarningSwitchCount(258029, "Dps", nil, nil, 3, 2) --Процесс инициализации (мифик)
local specWarnEdgeofAnni			= mod:NewSpecialWarningDodge(258834, nil, nil, nil, 2, 2) --Грань аннигиляции
local specWarnSoulrendingScythe		= mod:NewSpecialWarningStack(258838, nil, 2, nil, nil, 3, 2) --Рассекающая коса
local specWarnSoulrendingScytheTaunt= mod:NewSpecialWarningTaunt(258838, nil, nil, nil, 1, 2) --Рассекающая коса
--Stage Four: The Gift of Life, The Forge of Loss (Non Mythic)
local specWarnEmberofRage			= mod:NewSpecialWarningDodge(257299, nil, nil, nil, 2, 2) --Глыбы ярости
local specWarnEmberofRage2			= mod:NewSpecialWarningStack(257299, nil, 1, nil, nil, 1, 3) --Глыбы ярости
local specWarnDeadlyScythe			= mod:NewSpecialWarningStack(258039, nil, 3, nil, nil, 1, 2) --Смертоносная коса
local specWarnDeadlyScytheTaunt		= mod:NewSpecialWarningTaunt(258039, nil, nil, nil, 1, 2) --Смертоносная коса
local specWarnReorgModule			= mod:NewSpecialWarningSwitch(256389, "RangedDps", nil, nil, 3, 2) --Модуль пересозидания

local timerNextPhase				= mod:NewPhaseTimer(74)
--Stage One: Storm and Sky
mod:AddTimerLine(SCENARIO_STAGE:format(1))
local timerSweepingScytheCD			= mod:NewCDCountTimer(5.6, 248499, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON) --Сметающая коса 5.6-15.7
local timerConeofDeathCD			= mod:NewCDCountTimer(21, 248165, nil, nil, nil, 3) --Конус смерти (под героик норм)
local timerBlightOrbCD				= mod:NewCDCountTimer(25, 248317, nil, nil, nil, 3) --Чумная сфера (под героик норм)
local timerTorturedRageCD			= mod:NewCDCountTimer(13, 257296, nil, nil, nil, 2, nil, DBM_CORE_HEALER_ICON) --Ярость порабощенного 13-16
local timerSkyandSeaCD				= mod:NewCDCountTimer(24.9, 255594, nil, nil, nil, 5) --Небо и море 24.9-27.8
mod:AddTimerLine(ENCOUNTER_JOURNAL_SECTION_FLAG12)--Mythic Stage 1
local timerSargGazeCD				= mod:NewCDCountTimer(35.2, 258068, nil, nil, nil, 3, nil, DBM_CORE_HEROIC_ICON)
--Stage Two: The Protector Redeemed
mod:AddTimerLine(SCENARIO_STAGE:format(2))
local timerSoulBombCD				= mod:NewNextTimer(42, 251570, nil, nil, nil, 3, nil, DBM_CORE_TANK_ICON..DBM_CORE_DEADLY_ICON) --Бомба души
local timerSoulBomb					= mod:NewTargetTimer(15, 251570, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON..DBM_CORE_MYTHIC_ICON) --Бомба души (в гере 15, в других проверить)
local timerSoulBurstCD				= mod:NewNextCountTimer("d42", 250669, nil, nil, nil, 3) --Взрывная душа
local timerEdgeofObliterationCD		= mod:NewCDCountTimer(34, 255826, nil, nil, nil, 2) --Коса разрушения
local timerAvatarofAggraCD			= mod:NewCDTimer(59.9, 255199, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON) --Аватара Агграмара
--Stage Three: The Arcane Masters
mod:AddTimerLine(SCENARIO_STAGE:format(3))
local timerCosmicRayCD				= mod:NewCDTimer(19.9, 252729, nil, nil, nil, 3) --Космический луч All adds seem to cast it at same time, so one timer for all
local timerCosmicBeaconCD			= mod:NewCDTimer(19.9, 252616, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON) --Космический маяк All adds seem to cast it at same time, so one timer for all
local timerDiscsofNorg				= mod:NewCastTimer(12, 252516, nil, nil, nil, 6) --Диски Норганнона
local timerAddsCD					= mod:NewAddsTimer(14, 253021, nil, nil, nil, 1, nil, DBM_CORE_TANK_ICON..DBM_CORE_DAMAGE_ICON) --треш
mod:AddTimerLine(ENCOUNTER_JOURNAL_SECTION_FLAG12)--Mythic 3
local timerSoulrendingScytheCD		= mod:NewCDTimer(8.5, 258838, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON) --Рассекающая коса
local timerSargSentenceCD			= mod:NewTimer(35.2, "timerSargSentenceCD", 257966, nil, nil, 3, DBM_CORE_HEROIC_ICON) --Приговор Саргераса
local timerEdgeofAnniCD				= mod:NewCDTimer(5.5, 258834, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Грань аннигиляции
--Stage Four: The Gift of Life, The Forge of Loss (Non Mythic)
mod:AddTimerLine(SCENARIO_STAGE:format(4))
local timerDeadlyScytheCD			= mod:NewCDTimer(5.5, 258039, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON..DBM_CORE_DEADLY_ICON) --Смертоносная коса
local timerReorgModuleCD			= mod:NewCDCountTimer(48, 256389, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON..DBM_CORE_MYTHIC_ICON) --Модуль пересозидания
local timerReapSoul					= mod:NewCastTimer(13, 256542, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Жатва душ
local timerEndofAllThings			= mod:NewCastTimer(15, 256544, nil, nil, nil, 2, nil, DBM_CORE_INTERRUPT_ICON..DBM_CORE_DEADLY_ICON) --Конец всего сущего

local yellGiftofSky					= mod:NewYell(258646, L.SkyText, nil, nil, "YELL") --Дар небес
local yellGiftofSky2				= mod:NewFadesYell(258646, nil, nil, nil, "YELL") --Дар небес
local yellGiftofSea					= mod:NewYell(258647, L.SeaText, nil, nil, "YELL") --Дар моря
local yellGiftofSea2				= mod:NewFadesYell(258647, nil, nil, nil, "YELL") --Дар моря
local yellSoulblightFades			= mod:NewShortFadesYell(248396, nil, nil, nil, "YELL") --Изнуряющая чума
local yellSoulblight				= mod:NewYell(248396, L.Blight, nil, nil, "YELL") --Изнуряющая чума
local yellSargRage					= mod:NewShortYell(257869, 6612, nil, nil, "YELL") --Ярость Саргераса
local yellSargFear					= mod:NewShortYell(257931, 5782, nil, nil, "YELL") --Страх перед Саргерасом
local yellSargFearCombo				= mod:NewComboYell(257931, 5782, nil, nil, "YELL") --Страх перед Саргерасом
local yellSoulbomb					= mod:NewPosYell(251570, DBM_CORE_AUTO_YELL_CUSTOM_POSITION, nil, nil, "YELL") --Бомба души
local yellSoulbombFades				= mod:NewIconFadesYell(251570, 155188) --Бомба души
local yellSoulburst					= mod:NewPosYell(250669, DBM_CORE_AUTO_YELL_CUSTOM_POSITION, nil, nil, "YELL") --Взрывная душа
local yellSoulburstFades			= mod:NewIconFadesYell(250669, nil, nil, nil, "YELL") --Взрывная душа
local yellSargSentence				= mod:NewYell(257966, L.Sentence, nil, nil, "YELL") --Приговор Саргераса
local yellSargSentenceFades			= mod:NewShortFadesYell(257966, nil, nil, nil, "YELL") --Приговор Саргераса
local yellCosmicRay					= mod:NewYell(252729, nil, nil, nil, "YELL") --Космический луч

local berserkTimer					= mod:NewBerserkTimer(600)

--Stage One: Storm and Sky
local countdownSweapingScythe		= mod:NewCountdown("Alt5", 248499, false, nil, 3) --Сметающая коса Off by default since it'd be almost non stop, so users can elect into this one
local countdownSargGaze				= mod:NewCountdown(35, 258068, nil, nil, 5)
--Stage Two: The Protector Redeemed
local countdownSoulbomb				= mod:NewCountdown("AltTwo50", 251570, nil, nil, 5) --Бомба души
local countdownSoulbomb2			= mod:NewCountdownFades("AltTwo15", 251570, nil, nil, 5) --Бомба души
--Stage Three: Mythic
local countdownSoulScythe			= mod:NewCountdown("Alt5", 258838, "Tank", nil, 3) --Рассекающая коса
--Stage Four
local countdownDeadlyScythe			= mod:NewCountdown("Alt5", 258039, false, nil, 3) --Смертоносная коса Off by default since it'd be almost non stop, so users can elect into this one
local countdownReorgModule			= mod:NewCountdown("Alt48", 256389, "RangedDps", nil, 5) --Модуль пересозидания
local countdownApocModule			= mod:NewCountdown("Alt48", 258029, "Dps", nil, 5)
local countdownEndofAllThings		= mod:NewCountdown(15, 256544, nil, nil, 5) --Конец всего сущего

mod:AddSetIconOption("SetIconOnSoulBomb", 251570, true, false, {8}) --Бомба души
mod:AddSetIconOption("SetIconOnSoulBurst", 250669, true, false, {7, 3}) --Взрывная душа
mod:AddSetIconOption("SetIconGift", 255594, true, false, {6, 5}) --Небо и море 5 and 6
mod:AddSetIconOption("SetIconOnAvatar", 255199, true, false, {4}) --Аватара Агграмара 4
mod:AddSetIconOption("SetIconOnVulnerability", 252516, true, false, {7, 6, 5, 4, 3, 2, 1}) --дебаффы кураторов 1-7
mod:AddInfoFrameOption(nil, true)--Change to EJ entry since spell not localized
mod:AddRangeFrameOption(5, 257869) --Ярость Саргераса
mod:AddNamePlateOption("NPAuraOnInevitability", 253021)
mod:AddNamePlateOption("NPAuraOnCosmosSword", 255496)
mod:AddNamePlateOption("NPAuraOnEternalBlades", 255478)
mod:AddNamePlateOption("NPAuraOnVulnerability", 255418)

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
mod.vb.firstscytheSwap = false
mod.vb.rangeCheckNoTouchy = false
local warned_preP1 = false
local warned_preP2 = false
local warned_preP3 = false
local warned_preP4 = false
local warned_preP5 = false
local warned_preP6 = false
local playerName = UnitName("player")
--P3 Mythic Timers
local torturedRage = {40, 40, 50, 30, 35, 10, 8, 35, 10, 8, 35}--3 timers from method video not logs, verify by logs to improve accuracy
local sargSentenceTimers = {53, 56.9, 60, 53, 53}--1 timer from method video not logs, verify by logs to improve accuracy
local apocModuleTimers = {31, 47, 47, 46.6, 53, 53} --Some variation detected in logs do to delay in combat log between spawn and cast (one timer from method video)
local sargGazeTimers = {23, 75, 70, 53, 53}--1 timer from method video not logs, verify by logs to improve accuracy
local edgeofAnni = {5, 5, 90, 5, 45, 5}--All timers from method video (6:05 P3 start, 6:10, 6:15, 7:45, 7:50, 8:35, 8:40)
--Both of these should be in fearCheck object for efficiency but with uncertainty of async, I don't want to come back and fix this later. Doing it this way ensures without a doubt it'll work by calling on load and again on combatstart
local tankStacks = {}

local function fearCheck(self)
	self:Unschedule(fearCheck)
	if DBM:UnitDebuff("player", 257931) then
		local comboActive = false
		if DBM:UnitDebuff("player", 250669) then
			yellSargFearCombo:Yell(L.Burst)
			comboActive = true
		elseif DBM:UnitDebuff("player", 251570) then
			yellSargFearCombo:Yell(L.Bomb)
			comboActive = true
		elseif DBM:UnitDebuff("player", 257966) then
			yellSargFearCombo:Yell(L.Sentence)
			comboActive = true
		elseif DBM:UnitDebuff("player", 248396) then
			yellSargFearCombo:Yell(L.Blight)
			comboActive = true
		end
		if comboActive then
			self:Schedule(2, fearCheck, self)
		end
	end
end

local function ToggleRangeFinder(self, hide)
	if self:IsTank() or not self.Options.RangeFrame then return end--Tanks don't get rage
	if not hide then
		specWarnSargGaze:Show()
		specWarnSargGaze:Play("range5")
		DBM.RangeCheck:Show(5)
		self.vb.rangeCheckNoTouchy = true--Prevent SPELL_AURA_REMOVED of revious rage closing range finder during window we're expecting next rage
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
		specWarnEdgeofAnni:Show(self.vb.EdgeofObliteration)
		specWarnEdgeofAnni:Play("watchstep")
	end
	local timer = edgeofAnni[self.vb.EdgeofObliteration+1]
	if timer then
		timerEdgeofAnniCD:Start(timer, self.vb.EdgeofObliteration+1)
		self:Schedule(timer, startAnnihilationStuff, self, timer < 6)
	end
end

--[[
local function checkForMissingSentence(self)
	self:Unschedule(checkForMissingSentence)
	self.vb.sentenceCount = self.vb.sentenceCount + 1
	local timer = sargSentenceTimers[self.vb.sentenceCount+1]
	if timer then
		timerSargSentenceCD:Start(timer-10, self.vb.sentenceCount+1)--Timer minus 10 or next expected sentence cast
		self:Schedule(timer, checkForMissingSentence, self)--10 seconds after expected sentence cast
	end
	DBM:Debug("checkForMissingSentence ran, which means all sentence immuned", 2)
end
--]]

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
	self.vb.firstscytheSwap = false
	self.vb.rangeCheckNoTouchy = false
	warned_preP1 = false
	warned_preP2 = false
	warned_preP3 = false
	warned_preP4 = false
	warned_preP5 = false
	warned_preP6 = false
	timerSweepingScytheCD:Start(5.5-delay, 1)
	countdownSweapingScythe:Start(5.5)
	timerTorturedRageCD:Start(12-delay, 1)
	timerConeofDeathCD:Start(30.3-delay, 1)
	timerBlightOrbCD:Start(35.2-delay, 1)
	if self:IsMythic() then
		timerSargGazeCD:Start(8.2-delay, 1)
		countdownSargGaze:Start(8.2)
		self:Schedule(6.2, ToggleRangeFinder, self)--Call Show 5 seconds Before NEXT rages get applied (2 seconds before cast + 3 sec cast time)
		berserkTimer:Start(660-delay)
		timerSkyandSeaCD:Start(10.1-delay, 1)
		timerConeofDeathCD:Start(30.3-delay, 1)
	elseif self:IsHeroic() then
		berserkTimer:Start(720-delay)
		timerSkyandSeaCD:Start(11.5-delay, 1)
		timerConeofDeathCD:Start(31-delay, 1)
	else
		berserkTimer:Start(720-delay)
		timerSkyandSeaCD:Start(10.1-delay, 1)
		timerConeofDeathCD:Start(30.3-delay, 1)
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Show(6, "function", updateInfoFrame, false, false)
	end
	if self.Options.NPAuraOnInevitability or self.Options.NPAuraOnCosmosSword or self.Options.NPAuraOnEternalBlades or self.Options.NPAuraOnVulnerability then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
	DBM:AddMsg("Закрываешь Аргуса в мифе? Свяжись с автором аддона и помоги починить таймеры на боссе.")
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
		specWarnConeofDeath:Show()
		specWarnConeofDeath:Play("shockwave")
		timerConeofDeathCD:Start(nil, self.vb.coneCount+1)
	elseif spellId == 256544 then --Конец всего сущего
		warnEndofAllThings:Show(args.sourceName)
		warnEndofAllThings:Play("kickcast")
		specWarnEndofAllThings:Schedule(12)
		specWarnEndofAllThings:ScheduleVoice(12, "kickcast")
		timerEndofAllThings:Start(15)
		countdownEndofAllThings:Start(15)
	--	self:SendSync("EndofAllThings")
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
	elseif spellId == 255594 then
		self.vb.SkyandSeaCount = self.vb.SkyandSeaCount + 1
		if self:IsHeroic() then
			timerSkyandSeaCD:Start(26, self.vb.SkyandSeaCount+1)
		else
			timerSkyandSeaCD:Start(nil, self.vb.SkyandSeaCount+1)
		end
	elseif spellId == 252516 then
		warnDiscsofNorg:Show()
		timerDiscsofNorg:Start()
	elseif spellId == 255648 then--Golganneth's Wrath
		self.vb.phase = 2
		self.vb.scytheCastCount = 0
		self.vb.firstscytheSwap = false
		warned_preP2 = true
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(2))
		timerConeofDeathCD:Stop()
		timerBlightOrbCD:Stop()
		timerTorturedRageCD:Stop()
		timerSweepingScytheCD:Stop()
		countdownSweapingScythe:Cancel()
		timerSkyandSeaCD:Stop()
		timerNextPhase:Start(15)
		timerSweepingScytheCD:Start(16.8, 1)
		countdownSweapingScythe:Start(16.8)
		timerAvatarofAggraCD:Start(24)
		timerEdgeofObliterationCD:Start(21, 1)
		timerSoulBombCD:Start(30.3)
		countdownSoulbomb:Start(30.3)
		timerSoulBurstCD:Start(30.3, 1)
		if self:IsMythic() then
			self:Unschedule(ToggleRangeFinder)
			self.vb.gazeCount = 0
			timerSargGazeCD:Stop()
			countdownSargGaze:Cancel()
			timerSargGazeCD:Start(25.7, 1)
			countdownSargGaze:Start(25.7)
			self:Schedule(23.7, ToggleRangeFinder, self)--Call Show 5 seconds Before NEXT rages get applied (2 seconds before cast + 3 sec cast time)
		end
	elseif spellId == 257645 then--Temporal Blast (Stage 3)
		timerAvatarofAggraCD:Stop()--Always cancel this here, it's not canceled by argus becoming inactive and can still be cast during argus inactive transition phase
		if self.vb.phase < 3 then
			self:Unschedule(ToggleRangeFinder)
			self.vb.phase = 3
			warned_preP4 = true
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
			if not self:IsMythic() then
				self.vb.kurators = 7
				timerAddsCD:Start(14) --точно под гер
				timerCosmicRayCD:Start(28) --точно под гер
				timerCosmicBeaconCD:Start(40)
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
			warned_preP6 = true
			warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(4))
			if self.Options.InfoFrame then
				DBM.InfoFrame:Show(6, "function", updateInfoFrame, false, false)
			end
		end
		timerCosmicRayCD:Stop()
		timerCosmicBeaconCD:Stop()
		timerDiscsofNorg:Stop()
		timerSargGazeCD:Stop()
		self:Unschedule(ToggleRangeFinder)
		countdownSargGaze:Cancel()
		timerNextPhase:Start(35)--or 53.8
	elseif spellId == 257619 then--Gift of the Lifebinder (p4/p3mythic)
		warnGiftOfLifebinder:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 248499 then
		self.vb.scytheCastCount = self.vb.scytheCastCount + 1
		if self.vb.scytheCastCount == 3 then
			self.vb.firstscytheSwap = true
		end
		timerSweepingScytheCD:Start(5.6, self.vb.scytheCastCount+1)
		countdownSweapingScythe:Start(5.6)
	elseif spellId == 258039 then
		timerDeadlyScytheCD:Start()
		countdownDeadlyScythe:Start(5.5)
	elseif spellId == 258838 then--Mythic Scythe
		timerSoulrendingScytheCD:Start()
		countdownSoulScythe:Start(8.5)
	elseif spellId == 255826 then
		self.vb.EdgeofObliteration = self.vb.EdgeofObliteration + 1
		specWarnEdgeofObliteration:Show()
		specWarnEdgeofObliteration:Play("watchstep")
		timerEdgeofObliterationCD:Start(nil, self.vb.EdgeofObliteration+1)
	elseif spellId == 252729 and self:AntiSpam(5, 3) then
		timerCosmicRayCD:Start()
	elseif spellId == 252616 and self:AntiSpam(5, 4) then
	--	warnCosmicBeaconCast:Show()
		timerCosmicBeaconCD:Start()
--[[	elseif spellId == 256388 and self:AntiSpam(5, 8) then --Процесс инициализации (старый в об и гер)
		self.vb.moduleCount = self.vb.moduleCount + 1
		specWarnReorgModule:Show(self.vb.moduleCount)
		specWarnReorgModule:Play("killmob")
		timerReorgModuleCD:Start(nil, self.vb.moduleCount+1)
		countdownReorgModule:Start()]]
	elseif spellId == 258029 and self:AntiSpam(5, 7) then --Процесс инициализации (мифик)
		self.vb.moduleCount = self.vb.moduleCount + 1
		specWarnApocModule:Show(self.vb.moduleCount)
		specWarnApocModule:Play("killmob")
		local timer = apocModuleTimers[self.vb.moduleCount+1] or 46.6
		timerReorgModuleCD:Start(timer, self.vb.moduleCount+1)
		countdownApocModule:Start(timer)
	elseif spellId == 251570 then --Бомба души
		countdownSoulbomb2:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 248499 then--Heroic/non mythic
		local uId = DBM:GetRaidUnitId(args.destName)
		if uId and self:IsTanking(uId) then
			local amount = args.amount or 1
			--tankStacks[args.destName] = amount
			if not tContains(tankStacks, args.destName) then
				table.insert(tankStacks, args.destName)
			end
			local swapAmount = (self:IsLFR() or not self.vb.firstscytheSwap) and 3 or 2
			if amount >= swapAmount then
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
	elseif spellId == 258039 then--Heroic
		local uId = DBM:GetRaidUnitId(args.destName)
		if uId and self:IsTanking(uId) then
			local amount = args.amount or 1
			--tankStacks[args.destName] = amount
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
	elseif spellId == 258838 then--Mythic
		local uId = DBM:GetRaidUnitId(args.destName)
		if uId and self:IsTanking(uId) then
			local amount = args.amount or 1
			--tankStacks[args.destName] = amount
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
		warnSoulblight:Show(args.destName)
		if args:IsPlayer() then
			specWarnSoulblight:Show()
			specWarnSoulblight:Play("runout")
			yellSoulblight:Yell(playerName)
			yellSoulblightFades:Countdown(8, 3)
			fearCheck(self)
		end
	elseif spellId == 250669 then
		warnSoulburst:CombinedShow(0.3, args.destName)--2 Targets
		if self.vb.soulBurstIcon > 7 then
			self.vb.soulBurstIcon = 3
		end
		local icon = self.vb.soulBurstIcon
		if args:IsPlayer() then
			specWarnSoulburst:Show()
			specWarnSoulburst:Play("targetyou")
			specWarnSoulburst:ScheduleVoice(self:IsMythic() and 7 or 10, "bombnow")
			yellSoulburst:Yell(icon, L.Burst, icon)
			yellSoulburstFades:Countdown(self:IsMythic() and 12 or 15, 4, icon)
			fearCheck(self)
		end
		if self.Options.SetIconOnSoulBurst then
			self:SetIcon(args.destName, icon)
		end
		self.vb.soulBurstIcon = self.vb.soulBurstIcon + 4--Icons 3 and 7 used to match BW
	elseif spellId == 251570 then --Бомба души
		timerSoulBomb:Start(args.destName)
		if args:IsPlayer() then
			specWarnSoulbomb:Show()
			specWarnSoulbomb:Play("targetyou")--Would be better if bombrun was "bomb on you" and not "bomb on you, run". Since Don't want to give misinformation, generic it is
			self:Schedule(self:IsMythic() and 5 or 8, delayedBoonCheck, self)
			yellSoulbomb:Yell(2, L.Bomb, 2)
			yellSoulbombFades:Countdown(self:IsMythic() and 12 or 15, 4, 2)
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
			timerSoulBurstCD:Start(19.8, 2)
			timerSoulBombCD:Start(41.3)
			countdownSoulbomb:Start(41.3)
			timerSoulBurstCD:Start(41.3, 1)
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
	elseif spellId == 252729 then
		if args:IsPlayer() then
			specWarnCosmicRay:Show()
			specWarnCosmicRay:Play("targetyou")
			yellCosmicRay:Yell()
		else
			warnCosmicRay:CombinedShow(0.3, args.destName)
		end
	elseif spellId == 252616 then
		warnCosmicBeacon:CombinedShow(0.3, args.destName)
	elseif spellId == 258647 then--Gift of Sea
		warnSkyandSea:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnGiftofSea:Show()
			specWarnGiftofSea:Play("targetyou")
			yellGiftofSea:Yell(playerName)
			yellGiftofSea2:Countdown(5, 3)
		end
		if self.Options.SetIconGift then
			self:SetIcon(args.destName, 6)
		end
	elseif spellId == 258646 then--Gift of Sky
		warnSkyandSea:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnGiftofSky:Show()
			specWarnGiftofSky:Play("targetyou")
			yellGiftofSky:Yell(playerName)
			yellGiftofSky2:Countdown(5, 3)
		end
		if self.Options.SetIconGift then
			self:SetIcon(args.destName, 5)
		end
	elseif spellId == 255433 or spellId == 255430 or spellId == 255429 or spellId == 255425 or spellId == 255422 or spellId == 255419 or spellId == 255418 then--Vulnerability
		if self.Options.NPAuraOnVulnerability then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
		if self.Options.SetIconOnVulnerability then
			if spellId == 255433 then --Тайная
				self:SetIcon(args.destName, 4)
			elseif spellId == 255430 then --Тьма
				self:SetIcon(args.destName, 3)
			elseif spellId == 255429 then --Огонь
				self:SetIcon(args.destName, 2)
			elseif spellId == 255425 then --Лед
				self:SetIcon(args.destName, 5)
			elseif spellId == 255422 then --Природа
				self:SetIcon(args.destName, 6)
			elseif spellId == 255419 then --Свет
				self:SetIcon(args.destName, 7)
			elseif spellId == 255418 then --Физ.урон
				self:SetIcon(args.destName, 1)
			end
		end
	elseif spellId == 257869 then
		warnSargRage:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnSargRage:Show()
			specWarnSargRage:Play("scatter")
			yellSargRage:Yell()
		end
	elseif spellId == 257931 then
		warnSargFear:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnSargFear:Show(DBM_ALLY)
			specWarnSargFear:Play("gathershare")
			yellSargFear:Yell()
			fearCheck(self)
		end
	elseif spellId == 257966 then--Sentence of Sargeras
		if self:AntiSpam(5, 6) then
			--self:Unschedule(checkForMissingSentence)
			self.vb.sentenceCount = self.vb.sentenceCount + 1
			local timer = sargSentenceTimers[self.vb.sentenceCount+1]
			if timer then
				timerSargSentenceCD:Start(timer, self.vb.sentenceCount+1)
				--self:Schedule(timer+10, checkForMissingSentence, self)--Check for missing sentence event 10 seconds after expected to recover timer if all immuned
			end
		end
		warnSargSentence:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnSargSentence:Show()
			specWarnSargSentence:Play("targetyou")
			yellSargSentence:Yell(playerName)
			yellSargSentenceFades:Countdown(30, 3)
			fearCheck(self)
		end
	elseif spellId == 256388 and self:AntiSpam(3, 2) then --Процесс инициализации (новый в об и гер)
		self.vb.moduleCount = self.vb.moduleCount + 1
		warnReorgModule:Show()
		specWarnReorgModule:Schedule(46.5)
		specWarnReorgModule:ScheduleVoice(46.5, "killmob")
		timerReorgModuleCD:Start(46.5, self.vb.moduleCount+1)
		countdownReorgModule:Start(46.5)
--[[	elseif spellId == 257299 then --Глыбы ярости ( не идёт, слишком дохуя)
		local amount = args.amount or 1
		if amount >= 1 then
			if args:IsPlayer() then
				specWarnEmberofRage2:Show(amount)
				specWarnEmberofRage2:Play("stackhigh")
			end
		end]]
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 250669 then
		if args:IsPlayer() then
			yellSoulburstFades:Cancel()
			specWarnSoulburst:CancelVoice()
		end
		if self.Options.SetIconOnSoulBurst then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 251570 then --Бомба души
		warnSoulbomb2:Show(args.destName)
		timerSoulBomb:Cancel(args.destName)
		countdownSoulbomb2:Cancel()
		if args:IsPlayer() then
			self:Unschedule(delayedBoonCheck)
			yellSoulbombFades:Cancel()
		end
		if self.Options.SetIconOnSoulBomb then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 255199 then
		if args:IsPlayer() then
			playerAvatar = false
		end
		if self.Options.SetIconOnAvatar then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 258647 then--Gift of Sea
		if args:IsPlayer() then
			yellGiftofSea2:Cancel()
		end
		if self.Options.SetIconGift then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 258646 then--Gift of Sky
		if args:IsPlayer() then
			yellGiftofSky2:Cancel()
		end
		if self.Options.SetIconGift then
			self:SetIcon(args.destName, 0)
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
	elseif spellId == 248499 then
		--tankStacks[args.destName] = nil
		tDeleteItem(tankStacks, args.destName)
	elseif spellId == 258039 then--Heroic
		--tankStacks[args.destName] = nil
		tDeleteItem(tankStacks, args.destName)
		local uId = DBM:GetRaidUnitId(args.destName)
		if uId and self:IsTanking(uId) then
			if not args:IsPlayer() then--Removed from tank that's not you (only time it's removed is on death)
				specWarnDeadlyScytheTaunt:Show(args.destName)
				specWarnDeadlyScytheTaunt:Play("tauntboss")
			end
		end
	elseif spellId == 258838 then--Mythic
		--tankStacks[args.destName] = nil
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
			yellSargSentenceFades:Cancel()
		end
	elseif spellId == 248396 and args:IsPlayer() then
		yellSoulblightFades:Cancel()
	elseif spellId == 257869 then
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
		if self:IsMythic() then
			self:Unschedule(ToggleRangeFinder)--Redundant, for good measure
			self.vb.gazeCount = 0
			self.vb.EdgeofObliteration = 0
			timerSoulrendingScytheCD:Start(3.5)
			countdownSoulScythe:Start(3.5)
			timerEdgeofAnniCD:Start(5, 1)
			self:Schedule(5, startAnnihilationStuff, self)
			timerSargGazeCD:Start(20.2, 1)
			countdownSargGaze:Start(20.2)
			self:Schedule(18.2, ToggleRangeFinder, self)--Call Show 5 seconds Before NEXT rages get applied (2 seconds before cast + 3 sec cast time)
			timerReorgModuleCD:Start(31.3, 1)
			countdownApocModule:Start(31.3)
			timerTorturedRageCD:Start(40, 1)
			timerSargSentenceCD:Start(53, 1)
			--self:Schedule(63, checkForMissingSentence, self)
		else
			if not self:IsHeroic() then
				timerSweepingScytheCD:Start(5, 1)
				countdownSweapingScythe:Start(5)
				timerReorgModuleCD:Start(13, 1)
				countdownReorgModule:Start(13)
				specWarnReorgModule:Schedule(13)
				specWarnReorgModule:ScheduleVoice(13, "killmob")
			else -- под героик всё норм
				timerDeadlyScytheCD:Start(5) --Смертоносная коса
				timerReorgModuleCD:Start(13, 1)
				countdownReorgModule:Start(13)
				specWarnReorgModule:Schedule(13)
				specWarnReorgModule:ScheduleVoice(13, "killmob")
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

--"<47.47 22:23:32> [UNIT_SPELLCAST_SUCCEEDED] Argus the Unmaker(Sharmonk) [[boss1:Sargeras' Gaze::3-3769-1712-19636-258068-0047AD517B:258068]]", -- [96]
--"<47.64 22:23:32> [CHAT_MSG_RAID_BOSS_EMOTE] |TInterface\\Icons\\Sha_Ability_Rogue_BloodyEye_nightmare:20|t|cFFFF0000|Hspell:258068|h[Sargeras' Gaze]|h|r is cast upon the battle...#Argus the Unmaker#####0#0##0#22#nil#0#false#false#false#false"
--"<50.46 22:23:35> [CLEU] SPELL_AURA_APPLIED##nil#Player-1313-093344FD#Mehlas#257869#Sargeras' Rage#DEBUFF#nil", -- [137]
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:find("spell:258068") then
		self.vb.gazeCount = self.vb.gazeCount + 1
		if self.vb.phase == 2 then
			timerSargGazeCD:Start(59.7, self.vb.gazeCount+1)
			countdownSargGaze:Start(59.7)
		elseif self.vb.phase == 3 then
			local timer = sargGazeTimers[self.vb.gazeCount+1]
			if timer then
				timerSargGazeCD:Start(timer, self.vb.gazeCount+1)
				countdownSargGaze:Start(timer)
				self:Unschedule(ToggleRangeFinder)
				self:Schedule(5, ToggleRangeFinder, self, true)--Call hide 2 seconds after rages go out, function will check player for debuff and decide
				self:Schedule(timer-2, ToggleRangeFinder, self)--Call Show 5 seconds Before NEXT rages get applied (2 seconds before cast + 3 sec cast time)
			end
		else--Stage 1
			timerSargGazeCD:Start(35.2, self.vb.gazeCount+1)
			countdownSargGaze:Start(35.2)
			self:Unschedule(ToggleRangeFinder)
			self:Schedule(5, ToggleRangeFinder, self, true)--Call hide 2 seconds after rages go out, function will check player for debuff and decide
			self:Schedule(33.2, ToggleRangeFinder, self)--Call Show 5 seconds Before NEXT rages get applied (2 seconds before cast + 3 sec cast time)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 257300 and self:AntiSpam(5, 1) then--Ember of Rage
		specWarnEmberofRage:Show()
		specWarnEmberofRage:Play("watchstep")
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
		if not self:IsMythic() then
			timerCosmicRayCD:Start(42)
			timerCosmicBeaconCD:Start(52)
			if self.Options.InfoFrame then
				DBM.InfoFrame:Hide()
			end
		end
	end
end

--RL can run this macro to auto release everyone in raid any time they hit it
--/run DBM:GetModByName("2031"):SendSync("Release")
function mod:OnSync(msg, sender)
	if not self:IsInCombat() then return end
	if msg == "Release" and DBM:GetRaidRank(sender) == 2 then
		RepopMe()
	end
end

function mod:UNIT_HEALTH(uId)
	if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 124828 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.76 then --скоро фаза 2
		warned_preP1 = true
		warnPrePhase2:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
	elseif self.vb.phase == 2 and warned_preP2 and not warned_preP3 and self:GetUnitCreatureId(uId) == 124828 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.46 then --скоро фаза 3
		warned_preP3 = true
		warnPrePhase3:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
	elseif self.vb.phase == 2 and warned_preP3 and self:GetUnitCreatureId(uId) == 124828 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.41 then --фаза 3
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
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 127192 then
		self.vb.kurators = self.vb.kurators - 1
		if self.vb.kurators == 1 then
			warned_preP5 = true
			warnPrePhase4:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
		end
	end
end

--[[
function mod:OnSync(msg)
	if msg == "EndofAllThings" then -- под обычку таймер норм где 19.8 сек каста
		warnEndofAllThings:Show(args.sourceName)
		warnEndofAllThings:Play("kickcast")
		specWarnEndofAllThings:Schedule(12)
		specWarnEndofAllThings:ScheduleVoice(12, "kickcast")
		timerEndofAllThings:Start(15)
		countdownEndofAllThings:Start(15)
	end
end]]