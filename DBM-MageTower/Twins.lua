local mod	= DBM:NewMod("Twins", "DBM-MageTower")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(116409, 116410) --Рейст Волшебное Копье, Карам Волшебное Копье
mod:SetZone()
mod:SetBossHPInfoToHighest()

mod.soloChallenge = true
mod.onlyNormal = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 235578",
	"SPELL_AURA_APPLIED 235308",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_HEALTH",
	"UNIT_DIED"
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
local specWarnGrasp				= mod:NewSpecialWarningInterrupt(235578, nil, nil, nil, 3, 3) --Потусторонняя хватка

--Карам
local timerFixateCD				= mod:NewCDTimer(35, 202081, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Сосредоточение внимания
--Рейст
local timerHandCD				= mod:NewNextTimer(28, 235580, nil, nil, nil, 1, 235578, DBM_CORE_DAMAGE_ICON..DBM_CORE_DEADLY_ICON) --Потусторонняя длань
local timerRuneCD				= mod:NewCDTimer(35, 235446, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON..DBM_CORE_DEADLY_ICON) --Разлом

local countHand					= mod:NewCountdown(28, 235580, nil, nil, 5) --Потусторонняя длань
local countdownRune				= mod:NewCountdown("Alt35", 235446, nil, nil, 5) --Разлом
local countdownFixate			= mod:NewCountdown("AltTwo35", 202081, nil, nil, 5) --Сосредоточение внимания

mod.vb.phase = 1

local warned_preP1 = false
local warned_preP2 = false
local warned_preP3 = false

function mod:OnCombatStart(delay)
	warned_preP1 = false
	warned_preP2 = false
	warned_preP3 = false
	self.vb.phase = 1
	timerHandCD:Start(44.5) --Потусторонняя длань
	countHand:Start(44.5) --Потусторонняя длань
	self:ScheduleMethod(44.5, "Hand") --Потусторонняя длань
	DBM:AddMsg("Есть вероятность, что таймеры при начале боя будут включаться, если только вы сами ударите Карама. Не медлите и вступайте в бой скорее, от этого зависит их точность.")
end

function mod:OnCombatEnd()
	self:UnscheduleMethod("Hand")
	self:UnscheduleMethod("Shadowfiend")
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 235578 and self:AntiSpam(3, 1) then --Потусторонняя хватка
		specWarnGrasp:Show()
		specWarnGrasp:Play("kickcast")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 235308 then --Чистилище
		timerFixateCD:Start(40)
		countdownFixate:Start(40)
		specWarnFixate:Schedule(40)
		specWarnFixate:ScheduleVoice(40, "justrun")
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
		timerHandCD:Cancel()
		countHand:Cancel()
		self:UnscheduleMethod("Hand")
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.TwinsRP1 then
		self.vb.phase = 2
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase))
		timerRuneCD:Start(15) --Разлом
		countdownRune:Start(15) --Разлом
		self:ScheduleMethod(15, "Shadowfiend") --Разлом
	elseif msg == L.TwinsRP2 then
		self.vb.phase = 3
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase))
	end
end

function mod:UNIT_HEALTH(uId)
	if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 116410 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.51 then --Карам
		warned_preP1 = true
		warnPrePhase2:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
	elseif self.vb.phase == 2 and warned_preP1 and not warned_preP2 and self:GetUnitCreatureId(uId) == 116410 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.31 then --Карам
		warned_preP2 = true
		warnPrePhase3:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
	elseif self.vb.phase == 3 and warned_preP2 and not warned_preP3 and self:GetUnitCreatureId(uId) == 116410 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.10 then --Карам
		warned_preP3 = true
		warnPrePhase4:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
	end
end

function mod:Hand()
	if self.vb.phase < 4 then
		timerHandCD:Start(45)
		countHand:Start(45)
		self:ScheduleMethod(45, "Hand")
	end
end

function mod:Shadowfiend()
	specWarnRift:Show()
	specWarnRift:Play("killmob")
	timerRuneCD:Start(35)
	countdownRune:Start(35)
	self:ScheduleMethod(35, "Shadowfiend")
end
