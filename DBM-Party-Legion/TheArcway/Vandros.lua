local mod	= DBM:NewMod(1501, "DBM-Party-Legion", 6, 726)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(98208)
mod:SetEncounterID(1829)
mod:SetZone()

mod.noNormal = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 203957 220871",
	"SPELL_AURA_APPLIED_DOSE 203176",
	"SPELL_CAST_START 202974 203882 203176",
	"SPELL_DAMAGE 203833",
	"SPELL_MISSED 203833",
	"UNIT_SPELLCAST_SUCCEEDED boss1",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_HEALTH boss1"
)

--TODO, it might be time to build an interrupt table ("hasInterrupt") for better option defaults for spammy interrupt warnings.
--Force bomb might be more consistent now, need more logs, last log was 35
local warnTimeLock					= mod:NewTargetAnnounce(203957, 4) --Временное ограничение
local warnUnstableMana				= mod:NewTargetAnnounce(203176, 2) --Ускоряющий взрыв
local warnPhase						= mod:NewAnnounce("Phase1", 1, "Interface\\Icons\\Spell_Nature_WispSplode") --Скоро фаза 2
local warnPhase2					= mod:NewAnnounce("Phase2", 1, "Interface\\Icons\\Spell_Nature_WispSplode") --Скоро фаза 2

local specWarnTimeSplit				= mod:NewSpecialWarningMove(203833, nil, nil, nil, 1, 2)
local specWarnForceBomb				= mod:NewSpecialWarningDodge(202974, nil, nil, nil, 2, 5) --Силовая бомба
local specWarnBlast					= mod:NewSpecialWarningInterrupt(203176, "HasInterrupt", nil, 2, 1, 2) --Ускоряющий взрыв
local specWarnBlastStacks			= mod:NewSpecialWarningDispel(203176, "MagicDispeller") --Ускоряющий взрыв
local specWarnTimeLock				= mod:NewSpecialWarningInterrupt(203957, "HasInterrupt", nil, 2, 1, 2) --Временное ограничение
local specWarnUnstableMana			= mod:NewSpecialWarningMove(203176, nil, nil, nil, 1, 2) --Ускоряющий взрыв

local timerForceBombD				= mod:NewCDTimer(31.8, 202974, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Силовая бомба
local timerEvent					= mod:NewCastTimer(124, 203914, nil, nil, nil, 6, nil, DBM_CORE_DEADLY_ICON) --Изгнание во времени

local countdownEvent				= mod:NewCountdownFades(124, 203914, nil, nil, 10) --Изгнание во времени

mod.vb.phase = 1
mod.vb.interruptCount = 0
local warned_preP1 = false
local warned_preP2 = false

function mod:OnCombatStart(delay)
	self.vb.interruptCount = 0
	self.vb.phase = 1
	warned_preP1 = false
	warned_preP2 = false
	timerForceBombD:Start(23-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 203957 then
		--if people run different directions 2-3 of these can activate at once.
		--So combined show and anti spam measures used.
		warnTimeLock:CombinedShow(0.5, args.destName)
		if self:AntiSpam(3, 2) then
			specWarnTimeLock:Show(args.sourceName)
			specWarnTimeLock:Play("kickcast")
		end
	elseif spellId == 220871 then
		if args:IsPlayer() then
			specWarnUnstableMana:Show()
			specWarnUnstableMana:Play("runout")
			specWarnUnstableMana:ScheduleVoice(1, "keepmove")
		else
			warnUnstableMana:Show(args.destName)
		end
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	local spellId = args.spellId
	if spellId == 203176 then
		if args.amount >= 4 then
			specWarnBlastStacks:Show(args.destName)
			specWarnBlastStacks:Play("dispelboss")
		end
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 202974 then
		specWarnForceBomb:Show()
		specWarnForceBomb:Play("157349")
		timerForceBombD:Start()
	elseif spellId == 203882 then
		timerForceBombD:Cancel()
		timerEvent:Start()
		countdownEvent:Start()
	elseif spellId == 203176 then
		if self.vb.interruptCount == 3 then self.vb.interruptCount = 0 end
		self.vb.interruptCount = self.vb.interruptCount + 1
		local kickCount = self.vb.interruptCount
		specWarnBlast:Show()
		--Takes 3 to block all casts, it only takes 2 in a row to break his stacks though.
		--3 count still makes sense for 2 though because you know which cast to skip to maintain order. Kick 1-2, skip 3, easy
		--A group with only one interruptor won't be able to prevent his stacks and need to use dispels on boss instead
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
		specWarnTimeSplit:Show()
		specWarnTimeSplit:Play("runaway")
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
	if self:IsHard() then --миф и миф+
		if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 98208 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.56 then
			warned_preP1 = true
			warnPhase:Show()
		elseif self.vb.phase == 1 and warned_preP1 and not warned_preP2 and self:GetUnitCreatureId(uId) == 98208 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.51 then
			self.vb.phase = 2
			warned_preP2 = true
		end
	else
		if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 98208 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.56 then
			warned_preP1 = true
			warnPhase:Show()
		elseif self.vb.phase == 1 and warned_preP1 and not warned_preP2 and self:GetUnitCreatureId(uId) == 98208 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.51 then
			self.vb.phase = 2
			warned_preP2 = true
		end
	end
end

--[[function mod:OnSync(msg)
	if msg == "RPPhase2" then
		if self:IsHard() then
			if self.vb.phase == 2 and warned_preP2 then
				timerEvent:Cancel()
				timerForceBombD:Start(27)
				warnPhase2:Show()
				countdownEvent
			end
		else
			if self.vb.phase == 2 and warned_preP1 then
				timerEvent:Cancel()
				timerForceBombD:Start(27)
				warnPhase2:Show()
				
			end
		end
	end
end]]

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.RPVandros or msg:find(L.RPVandros) then
		self:SendSync("RPVandros")
	end
end

function mod:OnSync(msg, GUID)
	if msg == "RPVandros" then
		if self:IsHard() then
			timerEvent:Cancel()
			countdownEvent:Cancel()
			timerForceBombD:Start(27)
			warnPhase2:Show()
		else
			timerEvent:Cancel()
			countdownEvent:Cancel()
			timerForceBombD:Start(27)
			warnPhase2:Show()
		end
	end
end
