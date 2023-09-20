local mod	= DBM:NewMod(1732, "DBM-Nighthold", nil, 786)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17603 $"):sub(12, -3))
mod:SetCreatureID(103758)
mod:SetEncounterID(1863)
mod:SetZone()
--mod:SetUsedIcons(8, 7, 6, 3, 2, 1)
mod:SetHotfixNoticeRev(15841)
mod.respawnTime = 30

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 205408 206949 206517 207720 207439 216909",
	"SPELL_CAST_SUCCESS 206464 206464 206936 205649 207143 205984 214335 214167 221875 205408",
	"SPELL_AURA_APPLIED 205429 216344 216345 205445 205984 214335 214167 206585 206936 205649 207143 206398",
	"SPELL_AURA_REMOVED 205429 216344 216345 205445 205984 214335 214167 206585 206936 205649 207143",
	"SPELL_SUMMON 207813",
--	"SPELL_PERIODIC_DAMAGE 206398",
--	"SPELL_PERIODIC_MISSED 206398",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1",
	"UNIT_AURA player",
	"UNIT_HEALTH boss1"
)

--TODO, void ejection gone?
--[[
(ability.id = 205408 or ability.id = 206949 or ability.id = 206517 or ability.id = 207720 or ability.id = 207439 or ability.id = 216909 or ability.id = 221875) and type = "begincast" or
(ability.id = 205984 or ability.id = 214335 or ability.id = 214167 or ability.id = 221875) and type = "cast" or
(ability.id = 206464 or ability.id = 206936 or ability.id = 205649 or ability.id = 207143) and type = "cast"
--]]
--Base abilities
local warnPhase						= mod:NewPhaseChangeAnnounce(1)
local warnPhase2					= mod:NewPrePhaseAnnounce(2, 1)
local warnStarSignCrab				= mod:NewTargetAnnounce(205429, 2)--Yellow (looks orange but icon text is yellow)
local warnStarSignDragon			= mod:NewTargetAnnounce(216344, 2)--Blue
local warnStarSignHunter			= mod:NewTargetAnnounce(216345, 2)--Green
local warnStarSignWolf				= mod:NewTargetAnnounce(205445, 2)--Red
local warnGravitationalPull			= mod:NewTargetAnnounce(205984, 3, nil, "Tank")
--Stage One: The Dome of Observation
local warnCoronalEjection			= mod:NewTargetAnnounce(206464, 2)
--Stage Two: Absolute Zero
local warnIcyEjection				= mod:NewTargetAnnounce(206936, 2) --Выброс льда
--Stage Three: A Shattered World
local warnFelEjection				= mod:NewTargetAnnounce(205649, 2)
local warnFelEjectionPuddle			= mod:NewCountAnnounce(205649, 2)
--Stage Four: Inevitable Fate
--local warnVoidEjection				= mod:NewTargetAnnounce(207143, 2)

local specWarnGravitationalPull		= mod:NewSpecialWarningYou(205984, nil, nil, nil, 3, 2)
local specWarnGravitationalPullOther= mod:NewSpecialWarningTaunt(205984, nil, nil, nil, 1, 2)
--Stage One: The Dome of Observation
local specWarnCoronalEjection		= mod:NewSpecialWarningMoveAway(206464, nil, nil, nil, 1, 2)
--Stage Two: Absolute Zero
local specWarnIcyEjection			= mod:NewSpecialWarningYouMoveAway(206936, nil, nil, nil, 1, 2) --Выброс льда
local specWarnFrigidNova			= mod:NewSpecialWarningRunning(206949, nil, nil, nil, 3, 6) --Ледяная новая
local specWarnFrigidNova2			= mod:NewSpecialWarningSoon(206949, nil, nil, nil, 2, 3) --Ледяная новая
--Stage Three: A Shattered World
local specWarnFelEjection			= mod:NewSpecialWarningMoveAway(205649, nil, nil, nil, 1, 2)
local specWarnFelNova				= mod:NewSpecialWarningRun(206517, nil, nil, nil, 4, 5) --Новая Скверны
local specWarnFelNova2				= mod:NewSpecialWarningSoon(206517, nil, nil, nil, 2, 3) --Новая Скверны
local specWarnFelFlame				= mod:NewSpecialWarningYouMove(206398, nil, nil, nil, 1, 2)
--Stage Four: Inevitable Fate
local specWarnThing					= mod:NewSpecialWarningSwitch("ej13057", "Tank", nil, 2, 1, 2)
local specWarnWitnessVoid			= mod:NewSpecialWarningLookAway(207720, nil, nil, nil, 3, 2) --Видение Бездны
local specWarnVoidEjection			= mod:NewSpecialWarningMoveAway(207143, nil, nil, nil, 1, 2)--Should this be a move away, does void burst do any damage?
local specWarnVoidNova				= mod:NewSpecialWarningSpell(207439, nil, nil, nil, 2, 2)
local specWarnWorldDevouringForce	= mod:NewSpecialWarningDodge(216909, nil, nil, nil, 3, 6) --Всепожирающая сила
local specWarnWorldDevouringForce2	= mod:NewSpecialWarningSoon(216909, nil, nil, nil, 2, 3) --Всепожирающая сила
--Mythic
local specWarnConjunction			= mod:NewSpecialWarningMoveAway(205408, nil, nil, nil, 3, 6) --Великое соединение
local specWarnConjunction2			= mod:NewSpecialWarningSoon(205408, nil, nil, nil, 2, 3) --Великое соединение
local specWarnStarSignHunter		= mod:NewSpecialWarningYou(216345, nil, nil, nil, 1, 6) --Звездный знак: охотник
local specWarnStarSignCrab			= mod:NewSpecialWarningYou(205429, nil, nil, nil, 1, 6) --Звездный знак: краб
local specWarnStarSignWolf			= mod:NewSpecialWarningYou(205445, nil, nil, nil, 1, 6) --Звездный знак: волк
local specWarnStarSignDragon		= mod:NewSpecialWarningYou(216344, nil, nil, nil, 1, 6) --Звездный знак: дракон

--Base abilities
local timerGravPullCD				= mod:NewCDTimer(28, 205984, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)
--Stage One: The Dome of Observation
mod:AddTimerLine(SCENARIO_STAGE:format(1))
--local timerCoronalEjectionCD		= mod:NewCDTimer(16, 206464, nil, nil, nil, 3)--CD is not known, always push phase 2 before this is cast 2nd time
--Stage Two: Absolute Zero
mod:AddTimerLine(SCENARIO_STAGE:format(2))
local timerIcyEjectionCD			= mod:NewCDCountTimer(16, 206936, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Выброс льда
local timerFrigidNovaCD				= mod:NewCDCountTimer(61.5, 206949, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Ледяная новая
--Stage Three: A Shattered World
mod:AddTimerLine(SCENARIO_STAGE:format(3))
local timerFelEjectionCD			= mod:NewCDCountTimer(16, 205649, nil, nil, nil, 3)
local timerFelNovaCD				= mod:NewCDCountTimer(25, 206517, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Новая Скверны
--Stage Four: Inevitable Fate
mod:AddTimerLine(SCENARIO_STAGE:format(4))
local timerWitnessVoid				= mod:NewCastTimer(2.7, 207720, nil, nil, nil, 2)
local timerWitnessVoidCD			= mod:NewCDTimer(13, 207720, nil, nil, nil, 7)
--local timerVoidEjectionCD			= mod:NewCDCountTimer(16, 207143, nil, nil, nil, 3)--Where did it go? wasn't on normal test and wasn't on heroic retest
local timerVoidNovaCD				= mod:NewCDCountTimer(74, 207439, nil, nil, nil, 2)--Only saw a single pull it was cast twice, so CD needs more verification
local timerWorldDevouringForceCD	= mod:NewCDCountTimer(42, 216909, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON..DBM_CORE_MYTHIC_ICON) --Всепожирающая сила
mod:AddTimerLine(ENCOUNTER_JOURNAL_SECTION_FLAG12)
local timerConjunctionCD			= mod:NewCDTimer(16, 205408, nil, nil, nil, 7) --Великое соединение
local timerConjunction				= mod:NewBuffActiveTimer(15, 205408, nil, nil, nil, 7) --Великое соединение

local yellFelEjection				= mod:NewYell(205649, nil, nil, nil, "YELL")
local yellIcyEjection				= mod:NewYell(206936, nil, nil, nil, "YELL") --Выброс льда
local yellIcyEjection2				= mod:NewFadesYell(206936, nil, nil, nil, "YELL") --Выброс льда
local yellGravitationalPull			= mod:NewFadesYell(205984, nil, nil, nil, "YELL")
local yellFelEjectionFade			= mod:NewFadesYell(205649, nil, nil, nil, "YELL")
local yellConjunctionSign			= mod:NewPosYell(205408, DBM_CORE_AUTO_YELL_CUSTOM_POSITION, nil, nil, "YELL") --Великое соединение

local berserkTimer					= mod:NewBerserkTimer(463)

--Base abilities
local countdownConjunction			= mod:NewCountdown(15, 205408, nil, nil, 5) --Великое соединение
local countdownConjunctionFades		= mod:NewCountdownFades(15, 205408, nil, nil, 5) --Великое соединение
local countdownGravPull				= mod:NewCountdownFades("AltTwo10", 205984, nil, nil, 5)--Maybe change to everyone if it works like I think
--Stage One: The Dome of Observation
--Stage Two: Absolute Zero
local countdownFrigidNova			= mod:NewCountdown("Alt61.5", 206949, nil, nil, 5) --Ледяная новая
--Stage Three: A Shattered World
local countdownFelNova				= mod:NewCountdown("Alt25", 206517, nil, nil, 5) --Новая Скверны
--Stage Four: Inevitable Fate
local countWorldDevouringForce		= mod:NewCountdown("Alt15", 216909, nil, nil, 5) --Всепожирающая сила

mod:AddRangeFrameOption("5/8")
mod:AddInfoFrameOption(205408)--really needs a "various" option
mod:AddBoolOption("ConjunctionYellFilter", true)
mod:AddBoolOption("ShowProshlyapationOfMurchal", true)

local warned_preP1 = false
local warned_preP2 = false
local warned_preP3 = false
local frigidNova = replaceSpellLinks(206949) --Ледяная новая
local FelNova = replaceSpellLinks(206517) --Новая Скверны
local devouringForce = replaceSpellLinks(216909) --Всепожирающая сила
local grandConjunction = replaceSpellLinks(205408) --Великое соединение

local function startProshlyapationOfMurchal1(self)
	smartChat(L.ProshlyapMurchal:format(DbmRV, frigidNova), "rw")
end

local function startProshlyapationOfMurchal2(self)
	smartChat(L.ProshlyapMurchal:format(DbmRV, FelNova), "rw")
end

local function startProshlyapationOfMurchal3(self)
	smartChat(L.ProshlyapMurchal:format(DbmRV, devouringForce), "rw")
end

local function startProshlyapationOfMurchal4(self)
	smartChat(L.ProshlyapMurchal:format(DbmRV, grandConjunction), "rw")
end

local premsg_values = {
	args_destName,
	scheduleDelay,
	proshlyap1_rw, proshlyap2_rw, proshlyap3_rw, proshlyap4_rw
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
	elseif premsg_values.proshlyap3_rw == 1 then
		self:Schedule(premsg_values.scheduleDelay, startProshlyapationOfMurchal3, self)
		premsg_values.proshlyap3_rw = 0
	elseif premsg_values.proshlyap4_rw == 1 then
		self:Schedule(premsg_values.scheduleDelay, startProshlyapationOfMurchal4, self)
		premsg_values.proshlyap4_rw = 0
	end

	premsg_values.args_destName = nil
	premsg_values.scheduleDelay = nil
end

local function announceList(premsg_announce, value)
	if premsg_announce == "premsg_Etraeus_proshlyap1_rw" then
		premsg_values.proshlyap1_rw = value
	elseif premsg_announce == "premsg_Etraeus_proshlyap2_rw" then
		premsg_values.proshlyap2_rw = value
	elseif premsg_announce == "premsg_Etraeus_proshlyap3_rw" then
		premsg_values.proshlyap3_rw = value
	elseif premsg_announce == "premsg_Etraeus_proshlyap4_rw" then
		premsg_values.proshlyap4_rw = value
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

mod.vb.StarSigns = 0
mod.vb.phase = 1
mod.vb.icyEjectionCount = 0
mod.vb.felEjectionCount = 0
mod.vb.frostNovaCount = 0
mod.vb.felNovaCount = 0
mod.vb.voidNovaCount = 0
mod.vb.grandConCount = 0
mod.vb.conActive = false
mod.vb.worldDestroyingCount = 0
mod.vb.isPhaseChanging = false
local icyEjectionTimers = {24.5, 34.1, 6.5, 4.8, 50.2, 1.2, 2.4, 25.6, 2.8}--43.3, 35.6, 8.1, 4.1, 52.2, 1.2, 2.4
local felEjectionTimers = {18.2, 3.6, 3.2, 2.4, 10.2, 4.4, 2.8, 32.8, 4.0, 1.6, 4.0, 4.5, 22.3, 6.9, 17.0, 1.6, 1.2, 2.0, 18.3, 0.4}--10 after 4, 32 after 7, 22 after 12, 17 after 14, 18 after 18
local mythicfelEjectionTimers = {17.4, 3.2, 2.8, 2.4, 9.3, 2.4, 3.2, 30, 2, 1.2, 12.6, 1.2, 1.7, 21.1, 5.6, 9.3, 2.5, 1.5, 24.3, 3.2}
local voidEjectionTimers = {24, 3.2, 14.1, 17.4, 0.8, 4.7, 25.7, 2.3}
--local felNovaTImers = {34.8, 31.3, 29.3}--Latest is 47.1, 45.0, 25.1. Currently unused. for now just doing 45 or 25
local worldDestroyingTimers = {22, 41.3, 57, 51.8}
local ps1Grand = {15, 12.2}
local ps2Grand = {27, 43.9, 58.3}
local ps3Grand = {58.7, 43, 41.4}
local ps4Grand = {46.5, 61.6, 51.2}
local abZeroDebuff, chilledDebuff, gravPullDebuff = DBM:GetSpellInfo(206585), DBM:GetSpellInfo(206589), DBM:GetSpellInfo(205984)
local icyEjectionDebuff, coronalEjectionDebuff, voidEjectionDebuff = DBM:GetSpellInfo(206936), DBM:GetSpellInfo(206464), DBM:GetSpellInfo(207143)
local crabDebuff, dragonDebuff, hunterDebuff, wolfDebuff = DBM:GetSpellInfo(205429), DBM:GetSpellInfo(216344), DBM:GetSpellInfo(216345), DBM:GetSpellInfo(205445)
local crabs = {}
local dragons = {}
local hunters = {}
local wolves = {}
local playerAffected = false
local UnitDebuff = UnitDebuff
local voidWarned = false
local chilledFilter, tankFilter
do
	chilledFilter = function(uId)
		if UnitDebuff(uId, chilledDebuff) then
			return true
		end
	end
	tankFilter = function(uId)
		if mod:IsTanking(uId, "boss1") then
			return true
		end
	end
end

local updateInfoFrame
do
	local lines = {}
	updateInfoFrame = function()
		table.wipe(lines)
		local infoNeeded = false
		--Star Signs Helper
		--If player has debuff, find and show other players with same debuff as player
		if UnitDebuff("player", crabDebuff) then
			infoNeeded = true
			for i = 1, #crabs do
				local name = crabs[i]
				lines[name] = ""
			end
		elseif UnitDebuff("player", dragonDebuff) then
			infoNeeded = true
			for i = 1, #dragons do
				local name = dragons[i]
				lines[name] = ""
			end
		elseif UnitDebuff("player", hunterDebuff) then
			infoNeeded = true
			for i = 1, #hunters do
				local name = hunters[i]
				lines[name] = ""
			end
		elseif UnitDebuff("player", wolfDebuff) then
			infoNeeded = true
			for i = 1, #wolves do
				local name = wolves[i]
				lines[name] = ""
			end
		else--Player has no debuff, show overview frame with total debuff counts remaining
			local crabsigns, dragonsigns, huntersigns, wolfsigns = #crabs, #dragons, #hunters, #wolves
			--FIXME, figure out why colors are wrong
			if crabsigns > 0 then
				lines["|cff7d0aCD"..crabDebuff.."|r"] = crabsigns
				infoNeeded = true
			end
			if dragonsigns > 0 then
				lines["|c69ccf0CD"..dragonDebuff.."|r"] = dragonsigns
				infoNeeded = true
			end
			if huntersigns > 0 then
				lines["|cabd473CD"..hunterDebuff.."|r"] = huntersigns
				infoNeeded = true
			end
			if wolfsigns > 0 then
				lines["|cff0000CD"..wolfDebuff.."|r"] = wolfsigns
				infoNeeded = true
			end
		end
		if not infoNeeded then--Nothing left, hide infoframe
			DBM.InfoFrame:Hide()
		end
		return lines
	end
end

local function updateRangeFrame(self, force)
	if not self.Options.RangeFrame then return end
	if UnitDebuff("player", icyEjectionDebuff) or UnitDebuff("player", coronalEjectionDebuff) then
		DBM.RangeCheck:Show(8)
	elseif self.vb.phase == 2 and self:IsTank() then--Spread for iceburst
		DBM.RangeCheck:Show(6)
	elseif UnitDebuff("Player", gravPullDebuff) or UnitDebuff("player", voidEjectionDebuff) or force or self.vb.StarSigns > 0 then
		DBM.RangeCheck:Show(5)
	elseif UnitDebuff("player", abZeroDebuff) then
		DBM.RangeCheck:Show(8, chilledFilter)
	elseif self.vb.phase == 2 and self:IsMelee() then--Avoid tanks iceburst
		DBM.RangeCheck:Show(6, tankFilter)
	else
		DBM.RangeCheck:Hide()
	end
end

--This function went from pretty to ugly but it should work
local function showConjunction(self)
	if UnitDebuff("player", crabDebuff) then
		warnStarSignCrab:Show(table.concat(crabs, "<, >"))
	elseif UnitDebuff("player", dragonDebuff) then
		warnStarSignDragon:Show(table.concat(dragons, "<, >"))
	elseif UnitDebuff("player", hunterDebuff) then
		warnStarSignHunter:Show(table.concat(hunters, "<, >"))
	elseif UnitDebuff("player", wolfDebuff) then
		warnStarSignWolf:Show(table.concat(wolves, "<, >"))
	end
end

local function updateConjunctionYell(self, spellName, icon)
	if not self.Options.ConjunctionYellFilter then return end
	if UnitDebuff("player", spellName) then
		yellConjunctionSign:Yell(icon, "", icon)
		self:Schedule(2, updateConjunctionYell, self, spellName, icon)
	end
end

function mod:OnCombatStart(delay)
	warned_preP1 = false
	warned_preP2 = false
	warned_preP3 = false
	voidWarned = false
	playerAffected = false
	self.vb.StarSigns = 0
	self.vb.phase = 1
	self.vb.isPhaseChanging = false
	if self:IsMythic() then
		self.vb.grandConCount = 0
		self.vb.conActive = false
		self.vb.worldDestroyingCount = 0
--		timerCoronalEjectionCD:Start(12-delay)--Still could be health based
		timerConjunctionCD:Start(15-delay)
		countdownConjunction:Start(15-delay)
		specWarnConjunction2:Schedule(10-delay) --Великое соединение
		specWarnConjunction2:ScheduleVoice(10, "specialsoon") --Великое соединение
		if not DBM.Options.IgnoreRaidAnnounce2 and self.Options.ShowProshlyapationOfMurchal and DBM:GetRaidRank() > 0 then
			prepareMessage(self, "premsg_Etraeus_proshlyap4_rw", nil, nil, 9)
		end
	else
--		timerCoronalEjectionCD:Start(12.9-delay)--Still could be health based
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 205408 then --Великое соединение
		self.vb.grandConCount = self.vb.grandConCount + 1
		self.vb.conActive = true
		C_Timer.After(19, function() self.vb.conActive = false end)
		specWarnConjunction:Show()
		specWarnConjunction:Play("scatter")
		local timers
		if self.vb.phase == 1 then
			timers = ps1Grand[self.vb.grandConCount+1]
		elseif self.vb.phase == 2 then
			timers = ps2Grand[self.vb.grandConCount+1]
		elseif self.vb.phase == 3 then
			timers = ps3Grand[self.vb.grandConCount+1]
		else
			timers = ps4Grand[self.vb.grandConCount+1]
		end
		if timers then
			timerConjunctionCD:Start(timers)
			countdownConjunction:Start(timers)
			specWarnConjunction2:Schedule(timers-5)
			specWarnConjunction2:ScheduleVoice(timers-5, "specialsoon")
			if not DBM.Options.IgnoreRaidAnnounce2 and self.Options.ShowProshlyapationOfMurchal and DBM:GetRaidRank() > 0 then
				prepareMessage(self, "premsg_Etraeus_proshlyap4_rw", nil, nil, timers-6)
			end
		end
		updateRangeFrame(self, true)
		self:Schedule(4.5, showConjunction, self)
		table.wipe(crabs)
		table.wipe(dragons)
		table.wipe(hunters)
		table.wipe(wolves)
	elseif spellId == 206949 then --Ледяная новая
		self.vb.frostNovaCount = self.vb.frostNovaCount + 1
		specWarnFrigidNova:Show()
		specWarnFrigidNova:Play("gathershare")
		timerFrigidNovaCD:Start(nil, self.vb.frostNovaCount+1)
		countdownFrigidNova:Start()
		specWarnFrigidNova2:Schedule(56.5)
		specWarnFrigidNova2:ScheduleVoice(56.5, "specialsoon")
		if not DBM.Options.IgnoreRaidAnnounce2 and self.Options.ShowProshlyapationOfMurchal and DBM:GetRaidRank() > 0 then
			prepareMessage(self, "premsg_Etraeus_proshlyap1_rw", nil, nil, 55.5)
		end
	elseif spellId == 206517 then --Новая Скверны
		self.vb.felNovaCount = self.vb.felNovaCount + 1
		specWarnFelNova:Show()
		specWarnFelNova:Play("justrun")
		if self.vb.felNovaCount < 3 then
			timerFelNovaCD:Start(44, self.vb.felNovaCount+1)
			countdownFelNova:Start(44)
			specWarnFelNova2:Schedule(39)
			specWarnFelNova2:ScheduleVoice(39, "specialsoon")
			if not DBM.Options.IgnoreRaidAnnounce2 and self.Options.ShowProshlyapationOfMurchal and DBM:GetRaidRank() > 0 then
				prepareMessage(self, "premsg_Etraeus_proshlyap2_rw", nil, nil, 38)
			end
		else
			timerFelNovaCD:Start(nil, self.vb.felNovaCount+1)
			countdownFelNova:Start()
			specWarnFelNova2:Schedule(20)
			specWarnFelNova2:ScheduleVoice(20, "specialsoon")
			if not DBM.Options.IgnoreRaidAnnounce2 and self.Options.ShowProshlyapationOfMurchal and DBM:GetRaidRank() > 0 then
				prepareMessage(self, "premsg_Etraeus_proshlyap2_rw", nil, nil, 19)
			end
		end
	elseif spellId == 207720 then
		specWarnWitnessVoid:Show()
		specWarnWitnessVoid:Play("turnaway")
		timerWitnessVoid:Start(nil, args.sourceGUID)
		if self:IsMythic() then
			timerWitnessVoidCD:Start(13, args.sourceGUID)
		else
			timerWitnessVoidCD:Start(14.5, args.sourceGUID)
		end
	elseif spellId == 207439 then
		self.vb.voidNovaCount = self.vb.voidNovaCount + 1
		specWarnVoidNova:Show()
		specWarnVoidNova:Play("aesoon")
		timerVoidNovaCD:Start(nil, self.vb.voidNovaCount+1)
	elseif spellId == 216909 then
		self.vb.worldDestroyingCount = self.vb.worldDestroyingCount + 1
		specWarnWorldDevouringForce:Show()
		specWarnWorldDevouringForce:Play("farfromline")
		local timer = worldDestroyingTimers[self.vb.worldDestroyingCount+1]
		if timer then
			timerWorldDevouringForceCD:Start(timer, self.vb.worldDestroyingCount+1)
			countWorldDevouringForce:Start(timer)
			specWarnWorldDevouringForce2:Schedule(timer-5)
			specWarnWorldDevouringForce2:ScheduleVoice(timer-5, "specialsoon")
			if not DBM.Options.IgnoreRaidAnnounce2 and self.Options.ShowProshlyapationOfMurchal and DBM:GetRaidRank() > 0 then
				prepareMessage(self, "premsg_Etraeus_proshlyap3_rw", nil, nil, timer-6)
			end
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 206464 then
		--timerCoronalEjectionCD:Start()
	elseif spellId == 206936 and not self.vb.isPhaseChanging then
		self.vb.icyEjectionCount = self.vb.icyEjectionCount + 1
		local timer = icyEjectionTimers[self.vb.icyEjectionCount+1]
		if timer and timer >= 4 then--No sense in starting timers for the sub 4 second casts
			timerIcyEjectionCD:Start(timer, self.vb.icyEjectionCount+1)
		end
	elseif spellId == 205649 and not self.vb.isPhaseChanging then
		self.vb.felEjectionCount = self.vb.felEjectionCount + 1
		--10 after 4, 32 after 7, 22 after 12, 17 after 14, 18 after 18
		--9.4 after 4, 31.2 after 7, 14 after 10 (Mythic)
		--The rest are like sub 5 second timers with variations to boot so not worth timers
		local timer = self:IsMythic() and mythicfelEjectionTimers[self.vb.felEjectionCount+1] or felEjectionTimers[self.vb.felEjectionCount+1]
		if timer and timer >= 4 then--No sense in starting timers for the sub 5 second casts
			timerFelEjectionCD:Start(timer, self.vb.felEjectionCount+1)
		end
	elseif spellId == 207143 and not self.vb.isPhaseChanging then
		DBM:Debug("Void Ejection is back", 2)
--[[		self.vb.voidEjectionCount = self.vb.voidEjectionCount + 1
		local timer = voidEjectionTimers[self.vb.voidEjectionCount+1]
		if timer and timer >= 4 then--No sense in starting timers for the sub 4 second casts
			timerVoidEjectionCD:Start(timer, self.vb.voidEjectionCount+1)
		end--]]
	elseif spellId == 205984 or spellId == 214335 or spellId == 214167 then--205984 Frost, 214167 Fel, 214335 Void
		if spellId == 214335 then
			timerGravPullCD:Start(65)
		else--29
			timerGravPullCD:Start()
		end
		if args:IsPlayer() then
			specWarnGravitationalPull:Show()
			specWarnGravitationalPull:Play("targetyou")
		elseif self:IsTank() then
			specWarnGravitationalPullOther:Show(args.destName)
			specWarnGravitationalPullOther:Play("tauntboss")
		else
			warnGravitationalPull:Show(args.destName)
		end
	elseif spellId == 221875 then
		self.vb.isPhaseChanging = false
	elseif spellId == 205408 then --Великое соединение
		countdownConjunctionFades:Start()
		timerConjunction:Start()
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 207813 then
		specWarnThing:Show()
		specWarnThing:Play("bigmob")
		timerWitnessVoidCD:Start(10, args.destGUID)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 205429 or spellId == 216344 or spellId == 216345 or spellId == 205445 then--Star Signs
		self.vb.StarSigns = self.vb.StarSigns + 1
		if spellId == 205429 then --Звездный знак: краб
			crabs[#crabs + 1] = args.destName
			if args:IsPlayer() then
				specWarnStarSignCrab:Show()
				yellConjunctionSign:Yell(2, "", 2)--Orange Circle
				self:Schedule(2, updateConjunctionYell, self, args.spellName, 2)
				specWarnStarSignCrab:Play("205408c")
				playerAffected = true
			end
		elseif spellId == 216344 then --Звездный знак: дракон
			dragons[#dragons + 1] = args.destName
			if args:IsPlayer() then
				specWarnStarSignDragon:Show()
				yellConjunctionSign:Yell(6, "", 6)--Blue Square
				self:Schedule(2, updateConjunctionYell, self, args.spellName, 6)
				specWarnStarSignDragon:Play("205408d")
				playerAffected = true
			end
		elseif spellId == 216345 then --Звездный знак: охотник
			hunters[#hunters + 1] = args.destName
			if args:IsPlayer() then
				specWarnStarSignHunter:Show()
				yellConjunctionSign:Yell(4, "", 4)--Green Triangle
				self:Schedule(2, updateConjunctionYell, self, args.spellName, 4)
				specWarnStarSignHunter:Play("205408h")
				playerAffected = true
			end
		elseif spellId == 205445 then --Звездный знак: волк
			wolves[#wolves + 1] = args.destName
			if args:IsPlayer() then
				specWarnStarSignWolf:Show()
				yellConjunctionSign:Yell(7, "", 7)--Red Cross
				self:Schedule(2, updateConjunctionYell, self, args.spellName, 7)
				specWarnStarSignWolf:Play("205408w")
				playerAffected = true
			end
		end
		if self.vb.StarSigns == 1 then
			updateRangeFrame(self)
			if self.Options.InfoFrame and not DBM.InfoFrame:IsShown() then
				DBM.InfoFrame:Show(15, "function", updateInfoFrame, false, true)
			end
		end
	elseif spellId == 206464 then
		warnCoronalEjection:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnCoronalEjection:Show()
			specWarnCoronalEjection:Play("runout")
			updateRangeFrame(self)
		end
	elseif spellId == 205984 or spellId == 214335 or spellId == 214167 then
		if args:IsPlayer() then
			updateRangeFrame(self)
			local _, _, _, _, _, duration, expires, _, _ = UnitDebuff("player", args.spellName)
			if expires then
				local remaining = expires-GetTime()
				countdownGravPull:Start(remaining)
				if self.Options.ConjunctionYellFilter and self.vb.conActive then return end--No ejection yells during conjunction
				yellGravitationalPull:Schedule(remaining-1, 1)
				yellGravitationalPull:Schedule(remaining-2, 2)
				yellGravitationalPull:Schedule(remaining-3, 3)
			end
		end
	elseif spellId == 206585 then
		updateRangeFrame(self)
	elseif spellId == 206936 then
		warnIcyEjection:CombinedShow(0.5, args.destName)--If only one, move this to else rule to filter from player
		if args:IsPlayer() then
			specWarnIcyEjection:Show()
			specWarnIcyEjection:Play("runout")
			yellIcyEjection:Yell()
			updateRangeFrame(self)
			if self.Options.ConjunctionYellFilter and self.vb.conActive then return end--No ejection yells during conjunction
			yellIcyEjection2:Schedule(9, 1)
			yellIcyEjection2:Schedule(8, 2)
			yellIcyEjection2:Schedule(7, 3)
		end
	elseif spellId == 205649 then
		warnFelEjection:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnFelEjection:Show()
			specWarnFelEjection:Play("runout")
			specWarnFelEjection:ScheduleVoice(1, "keepmove")
			warnFelEjectionPuddle:Schedule(2, 3)
			warnFelEjectionPuddle:Schedule(4, 2)
			warnFelEjectionPuddle:Schedule(6, 1)
			warnFelEjectionPuddle:Schedule(8, 0)
			if self.Options.ConjunctionYellFilter and self.vb.conActive then return end--No ejection yells during conjunction
			yellFelEjection:Yell()
			yellFelEjectionFade:Schedule(7, 1)
			yellFelEjectionFade:Schedule(6, 2)
			yellFelEjectionFade:Schedule(5, 3)
		end
	elseif spellId == 207143 then
		--warnVoidEjection:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnVoidEjection:Show()
			specWarnVoidEjection:Play("runout")
		end
	elseif spellId == 206398 and args:IsPlayer() and self:AntiSpam(2, 1) and not UnitDebuff("Player", gravPullDebuff) then
		specWarnFelFlame:Show()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 205429 or spellId == 216344 or spellId == 216345 or spellId == 205445 then--Star Signs
		self.vb.StarSigns = self.vb.StarSigns - 1
		if args:IsPlayer() then
			playerAffected = false
		end
		if self.vb.StarSigns == 0 then
			updateRangeFrame(self)
		end
		if spellId == 205429 then--Crab
			tDeleteItem(crabs, args.destName)
		elseif spellId == 216344 then--Dragon
			tDeleteItem(dragons, args.destName)
		elseif spellId == 216345 then--Hunter
			tDeleteItem(hunters, args.destName)
		elseif spellId == 205445 then--Wolf
			tDeleteItem(wolves, args.destName)
		end
	elseif spellId == 205984 or spellId == 214335 or spellId == 214167 then
		if args:IsPlayer() then
			updateRangeFrame(self)
			yellGravitationalPull:Cancel()
			countdownGravPull:Cancel()
		end
	elseif spellId == 206585 then
		updateRangeFrame(self)
	elseif spellId == 206464 and args:IsPlayer() then
		updateRangeFrame(self)
	elseif spellId == 206936 and args:IsPlayer() then
		yellIcyEjection2:Cancel()
		updateRangeFrame(self)
	elseif spellId == 205649 and args:IsPlayer() then
		yellFelEjectionFade:Cancel()
		warnFelEjectionPuddle:Cancel()
		updateRangeFrame(self)
	elseif spellId == 207143 and args:IsPlayer() then
		updateRangeFrame(self)
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 104880 then--Thing That Should Not Be
		timerWitnessVoidCD:Cancel(args.destGUID)
		timerWitnessVoid:Cancel(args.destGUID)
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 206398 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) and not UnitDebuff("Player", gravPullDebuff) then
		specWarnFelFlame:Show()
		specWarnFelFlame:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

--Phases can also be done with Nether Traversal (221875) with same timing.
--However, this is more robust since unique spellids for each phase is better than same used for all 3
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 222130 then --Фаза 2
		self.vb.phase = 2
		self.vb.isPhaseChanging = true
		self.vb.frostNovaCount = 0
		self.vb.icyEjectionCount = 0
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase))
		warnPhase:Play("phasechange")
--		timerCoronalEjectionCD:Stop()
		timerConjunctionCD:Stop()
		countdownConjunction:Cancel()
		specWarnConjunction2:Cancel()
		specWarnConjunction2:CancelVoice()
		self:Unschedule(startProshlyapationOfMurchal4)
		timerGravPullCD:Start(28.7)
		if not self:IsEasy() then
			timerFrigidNovaCD:Start(48, 1) --Ледяная новая (точно под миф)
			countdownFrigidNova:Start(48) --Ледяная новая (точно под миф)
			specWarnFrigidNova2:Schedule(43)
			specWarnFrigidNova2:ScheduleVoice(43, "specialsoon")
			if not DBM.Options.IgnoreRaidAnnounce2 and self.Options.ShowProshlyapationOfMurchal and DBM:GetRaidRank() > 0 then 
				prepareMessage(self, "premsg_Etraeus_proshlyap1_rw", nil, nil, 42) --Ледяная новая (точно под миф)
			end
		end
		if self:IsMythic() then
			self:Unschedule(showConjunction)
			self.vb.grandConCount = 0
			timerIcyEjectionCD:Start(15, 1)
			timerConjunctionCD:Start(24)
			countdownConjunction:Start(24)
			specWarnConjunction2:Schedule(19)
			specWarnConjunction2:ScheduleVoice(19, "specialsoon")
			if not DBM.Options.IgnoreRaidAnnounce2 and self.Options.ShowProshlyapationOfMurchal and DBM:GetRaidRank() > 0 then
				prepareMessage(self, "premsg_Etraeus_proshlyap4_rw", nil, nil, 18)
			end
		else
			timerIcyEjectionCD:Start(23.3, 1)
		end
	elseif spellId == 222133 then --Фаза 3
		self.vb.phase = 3
		self.vb.isPhaseChanging = true
		self.vb.felEjectionCount = 0
		self.vb.felNovaCount = 0
		timerIcyEjectionCD:Stop()
		timerFrigidNovaCD:Stop()
		countdownFrigidNova:Cancel()
		specWarnFrigidNova2:Cancel()
		specWarnFrigidNova2:CancelVoice()
		self:Unschedule(startProshlyapationOfMurchal1)
		timerGravPullCD:Stop()
		timerConjunctionCD:Stop()
		countdownConjunction:Cancel()
		specWarnConjunction2:Cancel()
		specWarnConjunction2:CancelVoice()
		self:Unschedule(startProshlyapationOfMurchal4)
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase))
		warnPhase:Play("phasechange")
		timerGravPullCD:Start(29)
		if self:IsMythic() then
			self:Unschedule(showConjunction)
			self.vb.grandConCount = 0
			timerFelEjectionCD:Start(17.5, 1)
			timerFelNovaCD:Start(51, 1)
			countdownFelNova:Start(51)
			specWarnFelNova2:Schedule(46)
			specWarnFelNova2:ScheduleVoice(46, "specialsoon")
			if not DBM.Options.IgnoreRaidAnnounce2 and self.Options.ShowProshlyapationOfMurchal and DBM:GetRaidRank() > 0 then
				prepareMessage(self, "premsg_Etraeus_proshlyap2_rw", nil, nil, 45)
			end
			timerConjunctionCD:Start(58)
			countdownConjunction:Start(58)
			specWarnConjunction2:Schedule(53)
			specWarnConjunction2:ScheduleVoice(53, "specialsoon")
			if not DBM.Options.IgnoreRaidAnnounce2 and self.Options.ShowProshlyapationOfMurchal and DBM:GetRaidRank() > 0 then
				prepareMessage(self, "premsg_Etraeus_proshlyap4_rw", nil, nil, 52)
			end
		else
			timerFelEjectionCD:Start(18.2, 1)
			if not self:IsEasy() then
				timerFelNovaCD:Start(57.7, 1)
				countdownFelNova:Start(57.7)
				specWarnFelNova2:Schedule(52.7)
				specWarnFelNova2:ScheduleVoice(52.7, "specialsoon")
				if not DBM.Options.IgnoreRaidAnnounce2 and self.Options.ShowProshlyapationOfMurchal and DBM:GetRaidRank() > 0 then
					prepareMessage(self, "premsg_Etraeus_proshlyap2_rw", nil, nil, 51.7)
				end
			end
		end
	elseif spellId == 222134 then --Фаза 4
		self.vb.phase = 4
		self.vb.isPhaseChanging = true
		self.vb.voidNovaCount = 0
		--self.vb.voidEjectionCount = 0
		timerFelEjectionCD:Stop()
		timerFelNovaCD:Stop()
		countdownFelNova:Cancel()
		specWarnFelNova2:Cancel()
		specWarnFelNova2:CancelVoice()
		self:Unschedule(startProshlyapationOfMurchal2)
		timerGravPullCD:Stop()
		timerConjunctionCD:Stop()
		countdownConjunction:Cancel()
		specWarnConjunction2:Cancel()
		specWarnConjunction2:CancelVoice()
		self:Unschedule(startProshlyapationOfMurchal4)
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase))
		warnPhase:Play("phasechange")
		timerGravPullCD:Start(19.6)
		if not self:IsEasy() then--Was never used on normal, probably not LFR either then
			--timerVoidEjectionCD:Start(24, 1)
			timerVoidNovaCD:Start(39.2, 1)
		end
		if self:IsMythic() then
			self:Unschedule(showConjunction)
			self.vb.grandConCount = 0
			self.vb.worldDestroyingCount = 0
			timerWorldDevouringForceCD:Start(22, 1)
			countWorldDevouringForce:Start(22)
			specWarnWorldDevouringForce2:Schedule(17)
			specWarnWorldDevouringForce2:ScheduleVoice(17, "specialsoon")
			if not DBM.Options.IgnoreRaidAnnounce2 and self.Options.ShowProshlyapationOfMurchal and DBM:GetRaidRank() > 0 then
				prepareMessage(self, "premsg_Etraeus_proshlyap3_rw", nil, nil, 16)
			end
			timerConjunctionCD:Start(46)
			countdownConjunction:Start(46)
			specWarnConjunction2:Schedule(41)
			specWarnConjunction2:ScheduleVoice(41, "specialsoon")
			if not DBM.Options.IgnoreRaidAnnounce2 and self.Options.ShowProshlyapationOfMurchal and DBM:GetRaidRank() > 0 then
				prepareMessage(self, "premsg_Etraeus_proshlyap4_rw", nil, nil, 40)
			end
			berserkTimer:Start(201)
		else
			berserkTimer:Start(231)
		end
	end
end

function mod:UNIT_HEALTH(uId)
	if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 103758 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.94 then
		warned_preP1 = true
		warnPhase2:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
	elseif self.vb.phase == 2 and warned_preP1 and not warned_preP2 and self:GetUnitCreatureId(uId) == 103758 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.64 then
		warned_preP2 = true
		warnPhase2:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
	elseif self.vb.phase == 3 and warned_preP1 and warned_preP2 and not warned_preP3 and self:GetUnitCreatureId(uId) == 103758 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.34 then
		warned_preP3 = true
		warnPhase2:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
	end
end

do
	function mod:UNIT_AURA(uId)
		local hasDebuff = UnitDebuff("player", voidEjectionDebuff)
		if hasDebuff and not voidWarned then
			voidWarned = true
			specWarnVoidEjection:Show()
			specWarnVoidEjection:Play("runout")
			--yellScornedTouch:Yell()
			--if self.Options.RangeFrame then
			--	DBM.RangeCheck:Show(8)
			--end
		elseif not hasDebuff and voidWarned then
			voidWarned = false
			--if self.Options.RangeFrame then
			--	DBM.RangeCheck:Hide()
			--end
		end
	end
end

function mod:OnSync(premsg_announce, sender)
	if sender < playerOnlyName then
		announceList(premsg_announce, 0)
	end
end
