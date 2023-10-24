local mod	= DBM:NewMod(1501, "DBM-Party-Legion", 6, 726)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
mod:SetCreatureID(98208)
mod:SetEncounterID(1829)
mod:SetZone()
mod:SetUsedIcons(8)
mod.noNormal = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 203957 220871 203176",
	"SPELL_AURA_APPLIED_DOSE 203176",
	"SPELL_AURA_REMOVED 220871",
	"SPELL_CAST_START 202974 203882 203176",
	"SPELL_DAMAGE 203833",
	"SPELL_MISSED 203833",
	"UNIT_SPELLCAST_SUCCEEDED boss1",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_HEALTH boss1"
)

--Советник Вандрос https://ru.wowhead.com/npc=98208/советник-вандрос/эпохальный-журнал-сражений
local warnBlast						= mod:NewStackAnnounce(203176, 2, nil, nil, 2) --Ускоряющий взрыв
local warnTimeLock					= mod:NewTargetAnnounce(203957, 4) --Временное ограничение
local warnUnstableMana				= mod:NewTargetAnnounce(220871, 4) --Нестабильная мана
local warnPhase						= mod:NewPhaseChangeAnnounce(1)
local warnPhase2					= mod:NewPrePhaseAnnounce(2, 1, 220871)

local specWarnTimeSplit				= mod:NewSpecialWarningMove(203833, nil, nil, nil, 1, 2) --Расщепление времени
local specWarnForceBomb				= mod:NewSpecialWarningDodge(202974, nil, nil, nil, 2, 6) --Силовая бомба
local specWarnBlast					= mod:NewSpecialWarningCount(203176, "HasInterrupt", nil, 2, 1, 2) --Ускоряющий взрыв
local specWarnBlastStacks			= mod:NewSpecialWarningDispel(203176, "MagicDispeller", nil, nil, 3, 2) --Ускоряющий взрыв
local specWarnTimeLock				= mod:NewSpecialWarningInterrupt(203957, "HasInterrupt", nil, nil, 1, 2) --Временное ограничение
local specWarnUnstableMana			= mod:NewSpecialWarningYouMoveAway(220871, nil, nil, nil, 3, 6) --Нестабильная мана
local specWarnUnstableMana2			= mod:NewSpecialWarningCloseMoveAway(220871, nil, nil, nil, 2, 5) --Нестабильная мана

local timerUnstableMana				= mod:NewTargetTimer(8, 220871, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Нестабильная мана
local timerUnstableManaCD			= mod:NewCDTimer(35.5, 220871, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON..DBM_CORE_MYTHIC_ICON) --Нестабильная мана
local timerForceBombD				= mod:NewCDTimer(31.8, 202974, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Силовая бомба
local timerEvent					= mod:NewCastTimer(124, 203914, nil, nil, nil, 6, nil, DBM_CORE_DEADLY_ICON) --Изгнание во времени

local yellUnstableMana				= mod:NewYellMoveAway(220871, nil, nil, nil, "YELL") --Нестабильная мана
local yellUnstableMana2				= mod:NewFadesYell(220871, nil, nil, nil, "YELL") --Нестабильная мана
local yellTimeLock					= mod:NewYellHelp(203957, nil, nil, nil, "YELL") --Временное ограничение

local countdownEvent				= mod:NewCountdownFades(124, 203914, nil, nil, 10) --Изгнание во времени

mod:AddSetIconOption("SetIconOnUnstableMana", 220871, true, false, {8}) --Нестабильная мана

mod.vb.phase = 1
mod.vb.interruptCount = 0
local warned_preP1 = false
local warned_preP2 = false

function mod:OnCombatStart(delay)
	self.vb.interruptCount = 0
	self.vb.phase = 1
	warned_preP1 = false
	warned_preP2 = false
	if self:IsHard() then
		timerForceBombD:Start(28-delay) --Силовая бомба +++
	else
		timerForceBombD:Start(23-delay) --Силовая бомба
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 203957 then --Временное ограничение
		if args:IsPlayer() then
			yellTimeLock:Yell()
		else
			warnTimeLock:Show(args.destName)
			if self:AntiSpam(3, 2) then
				if not UnitIsDeadOrGhost("player") then
					specWarnTimeLock:Show()
					specWarnTimeLock:Play("kickcast")
				end
			end
		end
	elseif spellId == 220871 then --Нестабильная мана
		timerUnstableMana:Start(args.destName)
		if args:IsPlayer() then
			specWarnUnstableMana:Show()
			specWarnUnstableMana:Play("runout")
			specWarnUnstableMana:ScheduleVoice(1, "keepmove")
			yellUnstableMana:Yell()
			yellUnstableMana2:Countdown(8, 3)
		elseif self:CheckNearby(15, args.destName) then
			specWarnUnstableMana2:Show(args.destName)
			specWarnUnstableMana2:Play("runout")
		else
			warnUnstableMana:Show(args.destName)
		end
		if self.Options.SetIconOnUnstableMana then
			self:SetIcon(args.destName, 8, 8)
		end
		timerUnstableManaCD:Start()
	elseif spellId == 203176 and not args:IsDestTypePlayer() then --Ускоряющий взрыв
		local amount = args.amount or 1
		if amount >= 2 then
			if not UnitIsDeadOrGhost("player") then
				specWarnBlastStacks:Show(args.destName)
				specWarnBlastStacks:Play("dispelboss")
			end
		else
			warnBlast:Show(args.destName, amount)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 202974 then
		if not UnitIsDeadOrGhost("player") then
			specWarnForceBomb:Show()
			specWarnForceBomb:Play("watchstep")
		end
		if self:IsHard() then
			if self.vb.phase == 1 then
				timerForceBombD:Start(45)
			else
				timerForceBombD:Start(42.5)
			end
		else
			timerForceBombD:Start()
		end
	elseif spellId == 203882 then
		timerForceBombD:Cancel()
		timerEvent:Start()
		countdownEvent:Start()
	elseif spellId == 203176 then
		if self.vb.interruptCount == 3 then self.vb.interruptCount = 0 end
		self.vb.interruptCount = self.vb.interruptCount + 1
		local kickCount = self.vb.interruptCount
		specWarnBlast:Show(kickCount)
		if kickCount == 1 then
			specWarnBlast:Play("kick1r")
		elseif kickCount == 2 then
			specWarnBlast:Play("kick2r")
		elseif kickCount == 3 then
			specWarnBlast:Play("kick3r")
		end
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 203833 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		if not self:IsNormal() then
			specWarnTimeSplit:Show()
			specWarnTimeSplit:Play("runaway")
		end
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 147995 then--Interrupt Channeling
		self.vb.interruptCount = 0
		timerEvent:Cancel()
		countdownEvent:Cancel()
		timerForceBombD:Start(20)--20-23
	end
end

function mod:UNIT_HEALTH(uId)
	if not self:IsNormal() then --миф и миф+
		if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 98208 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.61 then
			warned_preP1 = true
			warnPhase2:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
		elseif self.vb.phase == 1 and warned_preP1 and not warned_preP2 and self:GetUnitCreatureId(uId) == 98208 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.51 then
			self.vb.phase = 2
			warned_preP2 = true
		end
	else
		if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 98208 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.61 then
			warned_preP1 = true
		elseif self.vb.phase == 1 and warned_preP1 and not warned_preP2 and self:GetUnitCreatureId(uId) == 98208 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.51 then
			self.vb.phase = 2
			warned_preP2 = true
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.RPVandros then
		self:SendSync("VandrosRP")
	end
end

function mod:OnSync(msg)
	if msg == "VandrosRP" then
		if not self:IsNormal() then --Гер, миф, миф+ и прошляп очка Мурчаля
			self.vb.interruptCount = 0
			timerEvent:Cancel()
			countdownEvent:Cancel()
			timerForceBombD:Start(27)
			warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase))
			timerUnstableManaCD:Start(5.5)
		else
			self.vb.interruptCount = 0
			timerEvent:Cancel()
			countdownEvent:Cancel()
			timerForceBombD:Start(27)
			warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase))
		end
	end
end
