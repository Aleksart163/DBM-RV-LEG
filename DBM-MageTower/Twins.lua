local mod	= DBM:NewMod("Twins", "DBM-MageTower")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17745 $"):sub(12, -3))
mod:SetCreatureID(116409, 116410) --Рейст Волшебное Копье, Карам Волшебное Копье
mod:SetZone()
mod:SetBossHPInfoToHighest()

mod.soloChallenge = true
mod.onlyNormal = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 235578",
	"SPELL_AURA_APPLIED 235308",
	"SPELL_AURA_REMOVED 235308",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_HEALTH",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2"
)

--Прошляпанное очко Мурчаля ✔✔ Разделить близнецов
local warnPhase					= mod:NewPhaseChangeAnnounce(1)
local warnPrePhase2				= mod:NewPrePhaseAnnounce(2, 1)
local warnPrePhase3				= mod:NewPrePhaseAnnounce(3, 1)
local warnPrePhase4				= mod:NewPrePhaseAnnounce(4, 1)

--Карам
local specWarnFixate			= mod:NewSpecialWarningRun(202081, nil, nil, nil, 4, 3) --Сосредоточение внимания
--Рейст
local specWarnRift				= mod:NewSpecialWarningSwitch(235446, nil, nil, nil, 1, 2) --Разлом
local specWarnRune2				= mod:NewSpecialWarningSoak(236460, nil, nil, nil, 3, 3) --Руна призыва
local specWarnGrasp				= mod:NewSpecialWarningInterrupt(235578, nil, nil, nil, 3, 3) --Потусторонняя хватка

--Карам
local timerFixateCD				= mod:NewCDTimer(35, 202081, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Сосредоточение внимания
--Рейст
local timerHandCD				= mod:NewNextTimer(28, 235580, nil, nil, nil, 1, 235578, DBM_CORE_DAMAGE_ICON..DBM_CORE_DEADLY_ICON) --Потусторонняя длань
local timerRuneCD				= mod:NewCDTimer(35, 235446, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON..DBM_CORE_DEADLY_ICON) --Разлом
local timerRune2CD				= mod:NewCDTimer(35, 236460, nil, nil, nil, 1, nil, DBM_CORE_DEADLY_ICON) --Руна призыва

local countHand					= mod:NewCountdown(28, 235580, nil, nil, 5) --Потусторонняя длань
local countdownRune2			= mod:NewCountdown("Alt35", 236460, nil, nil, 5) --Руна призыва
local countdownFixate			= mod:NewCountdown("AltTwo35", 202081, nil, nil, 5) --Сосредоточение внимания

mod.vb.phase = 1
mod.vb.purgatoryCount = 0

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
	self.vb.purgatoryCount = 0
end

function mod:OnCombatEnd()
	self:UnscheduleMethod("Hand")
	self:UnscheduleMethod("Shadowfiend")
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 235578 and self:AntiSpam(2, 1) then --Потусторонняя хватка
		specWarnGrasp:Show()
	--	specWarnGrasp:Play("kickcast")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 235308 then --Чистилище
		timerFixateCD:Start(37)
		countdownFixate:Start(37)
		warned_preP4 = false
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 235308 then --Чистилище and self:GetUnitCreatureId(args.destName) == 116410
		self.vb.purgatoryCount = self.vb.purgatoryCount + 1
		specWarnFixate:Show()
	--	specWarnFixate:Play("justrun")
		warned_preP4 = true
		if self.vb.purgatoryCount == 1 then
			self:UnscheduleMethod("Shadowfiend")
			timerRuneCD:Stop()
		elseif self.vb.purgatoryCount == 2 then
			self:UnscheduleMethod("Shadowfiend")
			timerRuneCD:Stop()
			timerRuneCD:Start(2) --Разлом
			self:ScheduleMethod(2, "Shadowfiend") --Разлом
		end
	end
end

function mod:UNIT_DIED(args)
	if args.destGUID == UnitGUID("player") then
		DBM:EndCombat(self, true)
	end
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 116409 then --Рейст
		DBM:EndCombat(self)
	elseif cid == 116410 then --Карам
		self.vb.phase = 4
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase))
		timerHandCD:Stop()
		countHand:Cancel()
		self:UnscheduleMethod("Hand")
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.TwinsRP1 then
		self.vb.phase = 2
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase))
		timerRuneCD:Start(5) --Разлом
		self:ScheduleMethod(5, "Shadowfiend") --Разлом
		timerHandCD:Start(53) --Потусторонняя длань
		countHand:Start(53) --Потусторонняя длань
		self:ScheduleMethod(53, "Hand") --Потусторонняя длань
	elseif msg == L.TwinsRP2 then
		self.vb.phase = 3
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase))
		countHand:Cancel()
		self:UnscheduleMethod("Shadowfiend")
		timerRuneCD:Start(5) --Разлом
		self:ScheduleMethod(5, "Shadowfiend") --Разлом
		self:UnscheduleMethod("Hand") --Потусторонняя длань
		timerHandCD:Start(42) --Потусторонняя длань
		countHand:Start(42) --Потусторонняя длань
		self:ScheduleMethod(42, "Hand") --Потусторонняя длань
		timerRune2CD:Start(26.5) --Руна призыва
		countdownRune2:Start(26.5) --Руна призыва
	end
end

function mod:UNIT_HEALTH(uId)
	if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 116410 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.45 then --Карам (скоро фаза 2)
		warned_preP1 = true
		warnPrePhase2:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
	elseif self.vb.phase == 2 and warned_preP1 and warned_preP4 and not warned_preP2 and self:GetUnitCreatureId(uId) == 116410 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.45 then --Карам (скоро фаза 3)
		warned_preP2 = true
		warnPrePhase3:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
	elseif self.vb.phase == 3 and warned_preP2 and warned_preP4 and not warned_preP3 and self:GetUnitCreatureId(uId) == 116410 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.10 then --Карам
		warned_preP3 = true
		warnPrePhase4:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
	end
end

function mod:Hand()
	if self.vb.phase < 4 then
		timerHandCD:Start(27.5)
		countHand:Start(27.5)
		self:ScheduleMethod(27.5, "Hand")
	end
end

function mod:Shadowfiend()
	specWarnRift:Show()
--	specWarnRift:Play("killmob")
	timerRuneCD:Start(11)
	self:ScheduleMethod(11, "Shadowfiend")
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 236460 then --Руна призыва
		specWarnRune2:Show()
	--	specWarnRune2:Play("helpsoak")
		if self.vb.phase < 4 then
			timerRune2CD:Start(35.5)
			countdownRune2:Start(35.5)
		elseif self.vb.phase == 4 then
			timerRune2CD:Start(23.5)
			countdownRune2:Start(23.5)
		end
	end
end
