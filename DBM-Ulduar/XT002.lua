local mod	= DBM:NewMod("XT002", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
mod:SetCreatureID(33293)
mod:SetUsedIcons(8, 7)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START 62776",
	"SPELL_AURA_APPLIED 62775 63018 65121 63024 64234 63849",
	"SPELL_AURA_REMOVED 63018 65121 63024 64234 63849",
	"SPELL_DAMAGE 64208 64206",
	"SPELL_MISSED 64208 64206",
	"SPELL_ABSORBED 64208 64206",
	"UNIT_DIED",
	"UNIT_HEALTH boss1"
)

local warnPhase						= mod:NewPhaseChangeAnnounce(1)
local warnPhase2					= mod:NewPrePhaseAnnounce(2, 1)
local warnLightBomb					= mod:NewTargetAnnounce(65121, 3) --Опаляющий свет
local warnGravityBomb				= mod:NewTargetAnnounce(64234, 4) --Гравитационная бомба

local specWarnExposedHeart			= mod:NewSpecialWarningMoreDamage(63849, "-Healer", nil, nil, 3, 6) --Обнаженное сердце
local specWarnTympanicTantrum		= mod:NewSpecialWarningDefensive(62776, nil, nil, nil, 3, 6) --Раскаты ярости
local specWarnLightBomb				= mod:NewSpecialWarningYouMoveAway(65121, nil, nil, nil, 4, 5) --Опаляющий свет
local specWarnGravityBomb			= mod:NewSpecialWarningYouMoveAway(64234, nil, nil, nil, 5, 6) --Гравитационная бомба
local specWarnConsumption			= mod:NewSpecialWarningYouMove(64206, nil, nil, nil, 1, 3)--Hard mode void zone dropped by Gravity Bomb

local timerTympanicTantrumCD		= mod:NewCDTimer(60, 62776, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Раскаты ярости
local timerTympanicTantrumCast		= mod:NewCastTimer(10, 62776, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Раскаты ярости
local timerHeart					= mod:NewCastTimer(30, 63849, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON)
local timerLightBombCD		        = mod:NewCDTimer(20, 65121, nil, "Healer", nil, 3, nil, DBM_CORE_HEALER_ICON) --Опаляющий свет
local timerLightBomb				= mod:NewTargetTimer(9, 65121, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Опаляющий свет
local timerGravityBombCD			= mod:NewCDTimer(20, 64234, nil, nil, nil, 7) --Гравитационная бомба
local timerGravityBomb				= mod:NewTargetTimer(9, 64234, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Гравитационная бомба
local timerAchieve					= mod:NewAchievementTimer(205, 12329, "TimerSpeedKill", nil, nil, 7)
local enrageTimer					= mod:NewBerserkTimer(600)

local countdownTympanicTantrum		= mod:NewCountdown(60, 62776, nil, nil, 5) --Раскаты ярости

local yellLightBomb					= mod:NewYell(65121, nil, nil, nil, "YELL") --Опаляющий свет
local yellLightBomb2				= mod:NewFadesYell(65121, nil, nil, nil, "YELL") --Опаляющий свет
local yellGravityBomb				= mod:NewYellMoveAway(64234, nil, nil, nil, "YELL") --Гравитационная бомба
local yellGravityBomb2				= mod:NewFadesYell(64234, nil, nil, nil, "YELL") --Гравитационная бомба

mod:AddSetIconOption("SetIconOnGravityBombTarget", 63024, true, false, {8})
mod:AddSetIconOption("SetIconOnLightBombTarget", 63018, true, false, {7})
mod:AddBoolOption("ShowProshlyapationOfMurchal", true)
mod:AddRangeFrameOption("8")

mod.vb.phase = 1

local warned_preP1 = false
local warned_preP2 = false
local warned_preP3 = false
local warned_preP4 = false

local ochko = replaceSpellLinks(62776) --Прошляпанное очко Мурчаля

local function startMurchalProshlyapation(self)
	smartChat(L.ProshlyapMurchal:format(DbmRV, ochko), "rw")
end

local premsg_values = {
	args_destName,
	scheduleDelay,
	ochko_rw
}
local playerOnlyName = UnitName("player")

local function sendAnnounce(self)
	if premsg_values.args_destName == nil then
		premsg_values.args_destName = "Unknown"
	end

	if premsg_values.ochko_rw == 1 then
		self:Schedule(premsg_values.scheduleDelay, startMurchalProshlyapation, self)
		premsg_values.ochko_rw = 0
	end

	premsg_values.args_destName = nil
	premsg_values.scheduleDelay = nil
end

local function announceList(premsg_announce, value)
	if premsg_announce == "premsg_XT002_ochko_rw" then
		premsg_values.ochko_rw = value
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
	self.vb.phase = 1
	warned_preP1 = false
	warned_preP2 = false
	warned_preP3 = false
	warned_preP4 = false
	enrageTimer:Start(-delay)
	timerAchieve:Start()
	timerLightBombCD:Start(11-delay) --Опаляющий свет
	timerGravityBombCD:Start(20.5-delay) --Гравитационная бомба
	timerTympanicTantrumCD:Start(30-delay) --Раскаты ярости
	countdownTympanicTantrum:Start(30-delay) --Раскаты ярости
	if not DBM.Options.IgnoreRaidAnnounce2 and self.Options.ShowProshlyapationOfMurchal and DBM:GetRaidRank() > 0 then
		prepareMessage(self, "premsg_XT002_ochko_rw", nil, nil, 24)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 62776 then --Раскаты ярости
		specWarnTympanicTantrum:Show()
		specWarnTympanicTantrum:Play("defensive")
		timerTympanicTantrumCast:Start()
		timerTympanicTantrumCD:Start()
		countdownTympanicTantrum:Start()
		if not DBM.Options.IgnoreRaidAnnounce2 and self.Options.ShowProshlyapationOfMurchal and DBM:GetRaidRank() > 0 then
			prepareMessage(self, "premsg_XT002_ochko_rw", nil, nil, 54)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 63018 or spellId == 65121 then --Опаляющий свет
		if args:IsPlayer() then
			specWarnLightBomb:Show()
			specWarnLightBomb:Play("runout")
			yellLightBomb:Yell()
			yellLightBomb2:Countdown(9, 3)
		else
			warnLightBomb:Show(args.destName)
		end
		if self.Options.SetIconOnLightBombTarget then
			self:SetIcon(args.destName, 7, 9)
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(8)
		end
		timerLightBomb:Start(args.destName)
		timerLightBombCD:Start()
	elseif spellId == 63024 or spellId == 64234 then --Гравитационная бомба
		if args:IsPlayer() then
			specWarnGravityBomb:Show()
			specWarnGravityBomb:Play("runout")
			yellGravityBomb:Yell()
			yellGravityBomb2:Countdown(10, 3)
		else
			warnGravityBomb:Show(args.destName)
		end
		if self.Options.SetIconOnGravityBombTarget then
			self:SetIcon(args.destName, 8, 9)
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(11)
		end
		timerGravityBomb:Start(args.destName)
		timerGravityBombCD:Start()
	elseif spellId == 63849 then --Обнаженное сердце
		specWarnExposedHeart:Show()
		timerLightBombCD:Stop()
		timerGravityBombCD:Stop()
		timerTympanicTantrumCD:Stop()
		countdownTympanicTantrum:Cancel()
		timerTympanicTantrumCD:Start(115)
		countdownTympanicTantrum:Start(115)
		timerHeart:Start()
		self:Unschedule(startMurchalProshlyapation)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 63018 or spellId == 65121 then --Опаляющий свет
		if self.Options.SetIconOnLightBombTarget then
			self:RemoveIcon(args.destName)
		end
	elseif spellId == 63024 or spellId == 64234 then --Гравитационная бомба
		if self.Options.SetIconOnGravityBombTarget then
			self:RemoveIcon(args.destName)
		end
	elseif spellId == 63849 then --Обнаженное сердце
		timerHeart:Stop()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 33329 and self.vb.phase == 1 and not warned_preP2 then --Сердце
		self.vb.phase = 2
		warned_preP2 = true
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase))
		warnPhase:Play("phasechange")
		timerTympanicTantrumCD:Stop()
		countdownTympanicTantrum:Cancel()
		timerTympanicTantrumCD:Start(25)
		countdownTympanicTantrum:Start(25)
		timerGravityBombCD:Start(15)
		if not DBM.Options.IgnoreRaidAnnounce2 and self.Options.ShowProshlyapationOfMurchal and DBM:GetRaidRank() > 0 then
			prepareMessage(self, "premsg_XT002_ochko_rw", nil, nil, 19)
		end
	end
end

function mod:UNIT_HEALTH(uId)
	if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 33293 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.81 then
		warned_preP1 = true
		warnPhase2:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
	elseif self.vb.phase == 1 and warned_preP1 and not warned_preP3 and self:GetUnitCreatureId(uId) == 33293 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.56 then
		warned_preP3 = true
		warnPhase2:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
	elseif self.vb.phase == 1 and warned_preP1 and warned_preP3 and not warned_preP4 and self:GetUnitCreatureId(uId) == 33293 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.31 then
		warned_preP4 = true
		warnPhase2:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
	end
end

do 
	local lastConsumption = 0
	function mod:SPELL_DAMAGE(args)
		local spellId = args.spellId
		if spellId == 64208 or spellId == 64206 and args:IsPlayer() and time() - lastConsumption > 2 then
			specWarnConsumption:Show()
			lastConsumption = time()
		end
	end
end

function mod:OnSync(premsg_announce, sender)
	if sender < playerOnlyName then
		announceList(premsg_announce, 0)
	end
end
