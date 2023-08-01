local mod	= DBM:NewMod(1470, "DBM-Party-Legion", 10, 707)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
mod:SetCreatureID(95888)
mod:SetEncounterID(1818)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 213576 213583 197251 213685 197422",
	"SPELL_AURA_APPLIED 205004 197541 216870 206567",
	"SPELL_AURA_REMOVED 206567 197422",
	"SPELL_PERIODIC_DAMAGE 216870",
	"SPELL_PERIODIC_MISSED 216870",
	"UNIT_SPELLCAST_SUCCEEDED boss1",
	"UNIT_HEALTH boss1"
)

--Кордана Оскверненная Песнь https://ru.wowhead.com/npc=95888/кордана-оскверненная-песнь#abilities;mode:
local warnPhase						= mod:NewPhaseChangeAnnounce(1)
local warnPhase2					= mod:NewPrePhaseAnnounce(2, 1, 213576)
local warnPhase3					= mod:NewPrePhaseAnnounce(3, 1, 197422)
local warnDeepeningShadows			= mod:NewSpellAnnounce(213583, 4) --Сгущающиеся тени
local warnCreepingDoom				= mod:NewSoonAnnounce(197422, 1) --Ползучая гибель

local specWarnFelGlaive				= mod:NewSpecialWarningDodge(197333, nil, nil, nil, 1, 2) --Глефа Скверны
local specWarnDeepeningShadows2		= mod:NewSpecialWarningYouMove(213583, "nil", nil, nil, 5, 6) --Сгущающиеся тени
local specWarnDetonation			= mod:NewSpecialWarningYouDefensive(197541, nil, nil, nil, 2, 5) --Мгновенный взрыв
local specWarnKick					= mod:NewSpecialWarningSpell(197251, "Tank", nil, nil, 3, 2) --Сбивающий с ног удар
local specWarnDeepeningShadows		= mod:NewSpecialWarningMoveTo(213583, nil, nil, nil, 3, 6) --Сгущающиеся тени
local specWarnHiddenStarted			= mod:NewSpecialWarningSpell(192750, nil, nil, nil, 2, 2) --Пелена тьмы
local specWarnHiddenOver			= mod:NewSpecialWarningEnd(192750, nil, nil, nil, 1, 2) --Пелена тьмы
local specWarnCreepingDoom			= mod:NewSpecialWarningDodge(197422, nil, nil, nil, 2, 5) --Ползучая гибель
local specWarnCreepingDoom2			= mod:NewSpecialWarningEnd(197422, nil, nil, nil, 1, 2) --Ползучая гибель
local specWarnVengeance				= mod:NewSpecialWarningSwitch(197796, "-Healer", nil, nil, 3, 6) --Отмщение

--local timerDetonation				= mod:NewTargetTimer(10, 197541, nil, nil, nil, 3, nil, DBM_CORE_HEALER_ICON) --Мгновенный взрыв
local timerFelGlaiveCD				= mod:NewCDCountTimer(10, 197333, nil, nil, nil, 7) --Глефа Скверны
local timerKickCD					= mod:NewCDTimer(15.7, 197251, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON) --Сбивающий с ног удар 16-42
local timerDeepeningShadowsCD		= mod:NewCDTimer(30.5, 213576, nil, nil, nil, 2) --Сгущающиеся тени
local timerCreepingDoomCD			= mod:NewCDCountTimer(74.5, 197422, nil, nil, nil, 7) --Ползучая гибель
local timerCreepingDoom				= mod:NewBuffActiveTimer(35, 197422, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Ползучая гибель 35-40
local timerVengeanceCD				= mod:NewCDTimer(35, 205004, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON) --Отмщение

local countdownFelGlaive			= mod:NewCountdown(5, 197333, nil, nil, 3) --Глефа Скверны
local countdownCreepingDoom			= mod:NewCountdown("Alt74.5", 197422, nil, nil, 5) --Ползучая гибель
local countdownCreepingDoom2		= mod:NewCountdownFades("Alt35", 197422, nil, nil, 5) --Ползучая гибель

mod.vb.phase = 1
mod.vb.proshlyapCount = 1
mod.vb.ochkenShlyapenCount = 0
mod.vb.proshlyapenCount = 0

local warned_preP1 = false
local warned_preP2 = false
local warned_preP3 = false
local MurchalOchkenProshlyapenTimers1 = {15.7, 7.2, 12.1, 7.2, 7.2, 7.2, 7.2, 7.2, 7.2, 7.2, 7.2, 7.2, 7.2, 7.2, 7.2, 7.2, 7.2, 7.2, 7.2, 7.2, 7.2, 7.2, 7.2, 7.2}
local MurchalOchkenProshlyapenTimers2 = {52.8, 11.2, 7, 14.5, 8.7, 7.2, 11.7, 7.3, 7.2, 7.3, 15.8, 7.2, 7.3, 7.2, 7.2, 7.4, 13.2, 13.2, 7.2, 7.2, 7.3, 7.3, 7.4, 13.1, 17, 7.4}
----------------------------------------  0,    1,   2,   3,   4,   5,    6,   7,   8,   9,   10   11,  12,  13,  14,  15,  16,   17,   18,  19,  20

local function startMurchalOchkenProshlyapen(self) -- Прошляпанное очко Мурчаля Прошляпенко
	self.vb.ochkenShlyapenCount = self.vb.ochkenShlyapenCount + 1
	if self.vb.phase == 1 then
		local proshlyap = self:IsMythic() and MurchalOchkenProshlyapenTimers1[self.vb.ochkenShlyapenCount+1] or self:IsHeroic() and MurchalOchkenProshlyapenTimers1[self.vb.ochkenShlyapenCount+1]
		if proshlyap then
			specWarnFelGlaive:Show()
			timerFelGlaiveCD:Start(proshlyap, self.vb.ochkenShlyapenCount+1)
			countdownFelGlaive:Start(proshlyap)
			self:Schedule(proshlyap, startMurchalOchkenProshlyapen, self)
		end
	elseif self.vb.phase == 3 then
		local proshlyap = self:IsMythic() and MurchalOchkenProshlyapenTimers2[self.vb.ochkenShlyapenCount+1] or self:IsHeroic() and MurchalOchkenProshlyapenTimers2[self.vb.ochkenShlyapenCount+1]
		if proshlyap then
			specWarnFelGlaive:Show()
			timerFelGlaiveCD:Start(proshlyap, self.vb.ochkenShlyapenCount+1)
			countdownFelGlaive:Start(proshlyap)
			self:Schedule(proshlyap, startMurchalOchkenProshlyapen, self)
		end
	end
end

--[[
local function MurchalOchkenProshlyapen(self)
	self.vb.ochkenShlyapenCount = self.vb.ochkenShlyapenCount + 1
	if self:IsHard() then
		if self.vb.phase == 1 and self.vb.ochkenShlyapenCount == 1 then -- 1 фаза
			timerFelGlaiveCD:Start(7.2, self.vb.ochkenShlyapenCount+1)
			countdownFelGlaive:Start(7.2)
			self:Schedule(7.2, MurchalOchkenProshlyapen, self)
		elseif self.vb.phase == 1 and self.vb.ochkenShlyapenCount == 2 then --
			timerFelGlaiveCD:Start(12.1, self.vb.ochkenShlyapenCount+1)
			countdownFelGlaive:Start(12.1)
			self:Schedule(12.1, MurchalOchkenProshlyapen, self)
		elseif self.vb.phase == 1 and self.vb.ochkenShlyapenCount >= 3 then --
			timerFelGlaiveCD:Start(7.2, self.vb.ochkenShlyapenCount+1)
			self:Schedule(7.2, MurchalOchkenProshlyapen, self)
			countdownFelGlaive:Start(7.2)
		elseif self.vb.phase == 2 and self.vb.ochkenShlyapenCount == 1 then -- 2 фаза
		if self.vb.phase == 2 and self.vb.ochkenShlyapenCount == 1 then -- 2 фаза
			self.vb.ochkenShlyapenCount = 0
		elseif self.vb.phase == 3 and self.vb.ochkenShlyapenCount == 1 then -- 3 фаза
			timerFelGlaiveCD:Start(11.1, self.vb.ochkenShlyapenCount+1)
			self:Schedule(11.1, MurchalOchkenProshlyapen, self)
		elseif self.vb.phase == 3 and self.vb.ochkenShlyapenCount == 2 then --
			timerFelGlaiveCD:Start(7, self.vb.ochkenShlyapenCount+1)
			self:Schedule(7, MurchalOchkenProshlyapen, self)
		elseif self.vb.phase == 3 and self.vb.ochkenShlyapenCount == 3 then --
			timerFelGlaiveCD:Start(14.4, self.vb.ochkenShlyapenCount+1)
			self:Schedule(14.4, MurchalOchkenProshlyapen, self)
		elseif self.vb.phase == 3 and self.vb.ochkenShlyapenCount == 4 then --
			timerFelGlaiveCD:Start(8.6, self.vb.ochkenShlyapenCount+1)
			self:Schedule(8.6, MurchalOchkenProshlyapen, self)
		elseif self.vb.phase == 3 and self.vb.ochkenShlyapenCount == 5 then
			timerFelGlaiveCD:Start(7.1, self.vb.ochkenShlyapenCount+1)
			self:Schedule(7.1, MurchalOchkenProshlyapen, self)
		elseif self.vb.phase == 3 and self.vb.ochkenShlyapenCount == 6 then
			timerFelGlaiveCD:Start(11.6, self.vb.ochkenShlyapenCount+1)
			self:Schedule(11.6, MurchalOchkenProshlyapen, self)
		elseif self.vb.phase == 3 and self.vb.ochkenShlyapenCount == 7 then
			timerFelGlaiveCD:Start(7.1, self.vb.ochkenShlyapenCount+1)
			self:Schedule(7.1, MurchalOchkenProshlyapen, self)
		elseif self.vb.phase == 3 and self.vb.ochkenShlyapenCount == 8 then
			timerFelGlaiveCD:Start(15, self.vb.ochkenShlyapenCount+1)
			self:Schedule(15, MurchalOchkenProshlyapen, self)
		elseif self.vb.phase == 3 and self.vb.ochkenShlyapenCount == 9 then
			timerFelGlaiveCD:Start(15, self.vb.ochkenShlyapenCount+1)
			self:Schedule(15, MurchalOchkenProshlyapen, self)
		elseif self.vb.phase == 3 and self.vb.ochkenShlyapenCount == 10 then
			timerFelGlaiveCD:Start(15.5, self.vb.ochkenShlyapenCount+1)
			self:Schedule(15.5, MurchalOchkenProshlyapen, self)
		elseif self.vb.phase == 3 and self.vb.ochkenShlyapenCount == 11 then
			timerFelGlaiveCD:Start(7.1, self.vb.ochkenShlyapenCount+1)
			self:Schedule(7.1, MurchalOchkenProshlyapen, self)
		elseif self.vb.phase == 3 and self.vb.ochkenShlyapenCount == 12 then
			timerFelGlaiveCD:Start(7.1, self.vb.ochkenShlyapenCount+1)
			self:Schedule(7.1, MurchalOchkenProshlyapen, self)
		elseif self.vb.phase == 3 and self.vb.ochkenShlyapenCount >= 13 then
			timerFelGlaiveCD:Start(7.1, self.vb.ochkenShlyapenCount+1)
			self:Schedule(7.1, MurchalOchkenProshlyapen, self)
		end
	end
end]]

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.proshlyapCount = 1
	self.vb.ochkenShlyapenCount = 0
	self.vb.proshlyapenCount = 0
	warned_preP1 = false
	warned_preP2 = false
	warned_preP3 = false
	self:Schedule(15.7, startMurchalOchkenProshlyapen, self)
--	self:Schedule(15.7, MurchalOchkenProshlyapen, self)
	timerFelGlaiveCD:Start(15.7-delay, 1) --Глефа Скверны
	countdownFelGlaive:Start(15.7-delay)
	timerDeepeningShadowsCD:Start(11-delay) --Сгущающиеся тени
	timerKickCD:Start(8.3-delay) --Сбивающий с ног удар
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 213576 or spellId == 213583 and self:AntiSpam(5, 1) then --Сгущающиеся тени
		if ExtraActionBarFrame:IsShown() then--Has light
			specWarnDeepeningShadows:Show(args.spellName)
			specWarnDeepeningShadows:Play("213576")
		else
			warnDeepeningShadows:Show()
		end
		timerDeepeningShadowsCD:Start()
	elseif spellId == 197251 then --Сбивающий с ног удар
		self.vb.proshlyapenCount = self.vb.proshlyapenCount + 1
		specWarnKick:Show()
		specWarnKick:Play("carefly")
		if self.vb.phase == 1 then
			timerKickCD:Start(21)
		elseif self.vb.phase == 2 then -- выглядит отлично
			timerKickCD:Start()
		elseif self.vb.phase == 3 then
			if self.vb.proshlyapenCount == 1 then
				timerKickCD:Start(28.8)
			elseif self.vb.proshlyapenCount == 2 then
				timerKickCD:Start(20.5)
			elseif self.vb.proshlyapenCount == 3 then
				timerKickCD:Start(21.7)
			elseif self.vb.proshlyapenCount == 4 then
				timerKickCD:Start(23)
			elseif self.vb.proshlyapenCount == 5 then
				timerKickCD:Start(21.6)
			elseif self.vb.proshlyapenCount == 6 then
				timerKickCD:Start(20.5)
			elseif self.vb.proshlyapenCount == 7 then
				timerKickCD:Start(20.5)
			elseif self.vb.proshlyapenCount == 8 then
				timerKickCD:Start(21.7)
			elseif self.vb.proshlyapenCount == 9 then
				timerKickCD:Start(20.5)
			elseif self.vb.proshlyapenCount == 10 then
				timerKickCD:Start(24.2)
			else
				timerKickCD:Start(25)
			end
		end
	elseif spellId == 197422 then --первая Ползучая гибель (длится 35 сек)
		self.vb.phase = 3
		self.vb.ochkenShlyapenCount = 0
		self.vb.proshlyapenCount = 0
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase))
		warnPhase:Play("phasechange")
		if not UnitIsDeadOrGhost("player") then
			specWarnCreepingDoom:Show()
			specWarnCreepingDoom:Play("watchstep")
		end
		timerKickCD:Stop()
		timerDeepeningShadowsCD:Stop()
		timerCreepingDoom:Start()
		countdownCreepingDoom2:Start()
		countdownCreepingDoom:Start()
		timerFelGlaiveCD:Stop()
		countdownFelGlaive:Cancel()
		warnCreepingDoom:Schedule(69.5)
		timerCreepingDoomCD:Start(74.5, self.vb.proshlyapCount+1)
		countdownCreepingDoom:Start(74.5)
		timerVengeanceCD:Start(49)
		timerDeepeningShadowsCD:Start(46.5)
		timerKickCD:Start(57.8)
		timerFelGlaiveCD:Start(52.8, 1)
		countdownFelGlaive:Start(52.8)
		self:Schedule(52.8, startMurchalOchkenProshlyapen, self)
--		self:Schedule(52.8, MurchalOchkenProshlyapen, self)
		self:UnregisterShortTermEvents()
	elseif spellId == 213685 then --вторая Ползучая гибель
		self.vb.proshlyapCount = self.vb.proshlyapCount + 1
		if not UnitIsDeadOrGhost("player") then
			specWarnCreepingDoom:Show()
			specWarnCreepingDoom:Play("watchstep")
		end
		--точные таймеры-------------
	--	specWarnCreepingDoom2:Schedule(20)
	--	specWarnCreepingDoom2:ScheduleVoice(20, "watchstep")
		timerCreepingDoomCD:Start(64, self.vb.proshlyapCount+1)
		countdownCreepingDoom:Start(64)
		warnCreepingDoom:Schedule(59)
		timerCreepingDoom:Start(20)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if args.spellId == 205004 then --Отмщение
		if not UnitIsDeadOrGhost("player") then
			specWarnVengeance:Show()
			specWarnVengeance:Play("killmob")
		end
		if self:IsMythic() then
			timerVengeanceCD:Start(44)
		else
			timerVengeanceCD:Start()
		end
	elseif spellId == 197541 then
	--	timerDetonation:Start(args.destName)
		if args:IsPlayer() then
			specWarnDetonation:Show()
			specWarnDetonation:Play("defensive")
		end
	elseif spellId == 216870 then --Сгущающиеся тени
		if self:IsHard() then
			specWarnDeepeningShadows2:Show()
			specWarnDeepeningShadows2:Play("runaway")
		end
	elseif spellId == 206567 and self:AntiSpam(2, "hidden") then --Похищенный свет
		timerDeepeningShadowsCD:Stop()
		timerKickCD:Stop()
		timerFelGlaiveCD:Stop()
		countdownFelGlaive:Cancel()
		if not UnitIsDeadOrGhost("player") then
			specWarnHiddenStarted:Show()
		--	specWarnHiddenStarted:Play("end")
		end
		self.vb.ochkenShlyapenCount = 0
		self:Unschedule(startMurchalOchkenProshlyapen)
	--	self:Unschedule(MurchalOchkenProshlyapen)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 206567 then --Похищенный свет
		self:RegisterShortTermEvents(
			"INSTANCE_ENCOUNTER_ENGAGE_UNIT"
		)
	elseif spellId == 197422 then --Первая ползучая гибель
		specWarnCreepingDoom2:Show()
		specWarnCreepingDoom2:Play("end")
	end
end

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	for i = 1, 5 do
		local unitID = "boss"..i
		local GUID = UnitGUID(unitID)
		local cid = self:GetCIDFromGUID(GUID)
		if cid == 95888 then
			specWarnHiddenOver:Show()
			specWarnHiddenOver:Play("end")
			timerDeepeningShadowsCD:Start(9.5) --Сгущающиеся тени
			timerKickCD:Start(10.8) --Сбивающий с ног удар
			timerFelGlaiveCD:Start(33.6, 1) --глефа
			countdownFelGlaive:Start(33.6)
			specWarnFelGlaive:Schedule(33.6)
		--	self:Schedule(33.6, MurchalOchkenProshlyapen, self)
		end
	end
end

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 203416 then--Shadowstep. Faster than 206567 applied
		timerDeepeningShadowsCD:Stop()
		timerKickCD:Stop()
		if not UnitIsDeadOrGhost("player") then
			specWarnHiddenStarted:Show()
		--	specWarnHiddenStarted:Play("end")
		end
	end
end]]

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 216870 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		if self:IsHard() then
			specWarnDeepeningShadows2:Show()
			specWarnDeepeningShadows2:Play("runaway")
		end
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_HEALTH(uId) --об, гер, миф, миф+ и прошляпанное очко Мурчаля Прошляпенко
	if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 95888 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.81 then
		warned_preP1 = true
		warnPhase2:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
	elseif self.vb.phase == 1 and warned_preP1 and not warned_preP2 and self:GetUnitCreatureId(uId) == 95888 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.76 then
		warned_preP2 = true
		self.vb.phase = 2
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase))
		warnPhase:Play("phasechange")
	elseif self.vb.phase == 2 and warned_preP2 and not warned_preP3 and self:GetUnitCreatureId(uId) == 95888 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.46 then
		warned_preP3 = true
		warnPhase3:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
	end
end
