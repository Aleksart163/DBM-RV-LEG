local mod	= DBM:NewMod(1826, "DBM-Party-Legion", 11, 860)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(114261, 114260) --Тонни, Мрргрия
mod:SetEncounterID(1957)--Shared (so not used for encounter START since it'd fire 3 mods)
mod:DisableESCombatDetection()--However, with ES disabled, EncounterID can be used for BOSS_KILL/ENCOUNTER_END
mod:DisableIEEUCombatDetection()
mod:SetZone()
mod:SetBossHPInfoToHighest()

mod.noNormal = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 227568 227420 227783",
	"SPELL_CAST_SUCCESS 227777 227453",
	"SPELL_AURA_APPLIED 227777 227568",
	"SPELL_AURA_REMOVED 227777",
	"SPELL_PERIODIC_DAMAGE 227480",
	"SPELL_PERIODIC_MISSED 227480",
	"SPELL_ABSORBED 227480",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_HEALTH boss1 boss2"
)

--"Однажды в Западном крае" https://ru.wowhead.com/npc=114260/мрргрия/эпохальный-журнал-сражений
local warnPhase						= mod:NewPhaseChangeAnnounce(1)
local warnPhase2					= mod:NewPrePhaseAnnounce(2, 1, 227783)
local warnPhase3					= mod:NewPrePhaseAnnounce(3, 1, 227453)
local warnLegSweep					= mod:NewCastAnnounce(227568, 4) --Пламенная подсечка
local warnLegSweep2					= mod:NewTargetAnnounce(227568, 3) --Пламенная подсечка
--Тонни
local specWarnLegSweep				= mod:NewSpecialWarningRun(227568, "Melee", nil, nil, 4, 3) --Пламенная подсечка
local specWarnLegSweep2				= mod:NewSpecialWarningDodge(227568, "Ranged", nil, nil, 2, 2) --Пламенная подсечка
local specWarnFlameGale				= mod:NewSpecialWarningDodge(227453, nil, nil, nil, 2, 2) --Ураган пламени
local specWarnFlameGale2			= mod:NewSpecialWarningYouMove(227480, nil, nil, nil, 1, 2) --Ураган пламени
--Мрргрия
local specWarnThunderRitual			= mod:NewSpecialWarningYouMoveAway(227777, nil, nil, nil, 4, 3) --Ритуал грома
local specWarnBubbleBlast			= mod:NewSpecialWarningInterrupt(227420, "HasInterrupt", nil, nil, 1, 2) --Взрыв пузыря
local specWarnWashAway				= mod:NewSpecialWarningDodge(227783, nil, nil, nil, 1, 2) --Ураганная волна

--Тонни
local timerLegSweepCD				= mod:NewCDTimer(20, 227568, nil, "Melee", nil, 2, nil, DBM_CORE_DEADLY_ICON) --Пламенная подсечка +++
local timerFlameGaleCD				= mod:NewCDTimer(30.5, 227453, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Ураган пламени +++ +- 1 сек
--Мрргрия
local timerThunderRitualCD			= mod:NewCDTimer(16.5, 227777, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Ритуал грома
local timerWashAwayCD				= mod:NewCDTimer(23, 227783, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Ураганная волна

local yellThunderRitual				= mod:NewYell(227777, nil, nil, nil, "YELL") --Ритуал грома
local yellThunderRitual2			= mod:NewShortFadesYell(227777, nil, nil, nil, "YELL") --Ритуал грома

local countdownFlameGale			= mod:NewCountdown(30.5, 227453, nil, nil, 5) --Ураган пламени
local countdownWashAway				= mod:NewCountdown("Alt23", 227783, nil, nil, 5) --Ураганная волна

local warned_preP1 = false
local warned_preP2 = false
local warned_preP3 = false
local warned_preP4 = false
mod:AddRangeFrameOption(5, 227777)

mod.vb.phase = 1

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	warned_preP1 = false
	warned_preP2 = false
	warned_preP3 = false
	warned_preP4 = false
	if self:IsHard() then
		timerLegSweepCD:Start(9.5-delay) --Пламенная подсечка +++
		timerFlameGaleCD:Start(22.5-delay) --Ураган пламени +++
	--	countdownFlameGale:Start(22.5-delay) --Ураган пламени +++
	else
		timerLegSweepCD:Start(9.5-delay) --Пламенная подсечка
		timerFlameGaleCD:Start(22.5-delay) --Ураган пламени
	--	countdownFlameGale:Start(22.5-delay) --Ураган пламени
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 227568 then
		warnLegSweep:Show()
		specWarnLegSweep:Show()
		specWarnLegSweep:Play("runout")
		specWarnLegSweep2:Show()
		specWarnLegSweep2:Play("watchstep")
		if self:IsHard() then
			timerLegSweepCD:Start()
		else
			timerLegSweepCD:Start()
		end
	elseif spellId == 227420 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnBubbleBlast:Show(args.sourceName)
		specWarnBubbleBlast:Play("kickcast")
	elseif spellId == 227783 then --Ураганная волна
		specWarnWashAway:Show()
		specWarnWashAway:Play("watchwave")
		timerWashAwayCD:Start()
		countdownWashAway:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 227777 then
		if self:IsHard() then
			timerThunderRitualCD:Start()
		else
			timerThunderRitualCD:Start(18)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 227777 then --Ритуал грома
		if args:IsPlayer() then
			specWarnThunderRitual:Show()
			specWarnThunderRitual:Play("range5")
			yellThunderRitual:Yell()
			yellThunderRitual2:Countdown(6, 3)
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(5)
			end
		end
	elseif spellId == 227568 then --Пламенная подсечка
		warnLegSweep2:CombinedShow(0.5, args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 227777 then --Ритуал грома
		if args:IsPlayer() then
			yellThunderRitual2:Cancel()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 227480 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		if self:IsHard() then
			specWarnFlameGale2:Show()
			specWarnFlameGale2:Play("runaway")
		end
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
mod.SPELL_PERIODIC_DAMAGE = mod.SPELL_ABSORBED

--[[
function mod:OnSync(msg)
	if msg == "Tonny" then --Ураган пламени
		specWarnFlameGale:Show()
		if self:IsHard() then
			timerFlameGaleCD:Start()
			countdownFlameGale:Start()
		else
			timerFlameGaleCD:Start()
			countdownFlameGale:Start()
		end
	elseif msg == "Phase2" then --Фаза 2
		self.vb.phase = 3
		warned_preP4 = true
		timerLegSweepCD:Start(10)
		timerFlameGaleCD:Start(22)
		countdownFlameGale:Start(22)
	end
end]]

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Tonny then
	--	self:SendSync("Tonny")
		specWarnFlameGale:Show()
		if self:IsHard() then
			timerFlameGaleCD:Start()
			countdownFlameGale:Start()
		else
			timerFlameGaleCD:Start()
			countdownFlameGale:Start()
		end
	elseif msg == L.Phase3 then
	--	self:SendSync("Phase2")
		self.vb.phase = 3
		warned_preP4 = true
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase))
		warnPhase:Play("phasechange")
		timerLegSweepCD:Start(10)
		timerFlameGaleCD:Start(22)
		countdownFlameGale:Start(22)
	end
end

function mod:UNIT_HEALTH(uId)
	if not self:IsNormal() then --миф и миф+
		if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 114261 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.61 then --Тонни скоро фаза 2
			warned_preP1 = true
			warnPhase2:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
		elseif self.vb.phase == 1 and warned_preP1 and not warned_preP2 and self:GetUnitCreatureId(uId) == 114261 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.51 then --Тонни фаза 2
			self.vb.phase = 2
			warned_preP2 = true
			warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase))
			warnPhase:Play("phasechange")
			timerLegSweepCD:Stop()
			timerFlameGaleCD:Stop()
			countdownFlameGale:Cancel()
			timerThunderRitualCD:Start(8)
			timerWashAwayCD:Start(16)
			countdownWashAway:Start(16)
		elseif self.vb.phase == 2 and warned_preP2 and not warned_preP3 and self:GetUnitCreatureId(uId) == 114260 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.61 then --Мрргрия скоро фаза 3
			warned_preP3 = true
			warnPhase3:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
--[[		elseif self.vb.phase == 2 and warned_preP3 and not warned_preP4 and self:GetUnitCreatureId(uId) == 114260 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.51 then --Мрргрия фаза 3
			self.vb.phase = 3
			warned_preP4 = true
			timerLegSweepCD:Start(10)
			timerFlameGaleCD:Start(22)
			countdownFlameGale:Start(22)]]
		end
	else
		if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 114261 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.61 then --Тонни скоро фаза 2
			warned_preP1 = true
		elseif self.vb.phase == 1 and warned_preP1 and not warned_preP2 and self:GetUnitCreatureId(uId) == 114261 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.51 then --Тонни фаза 2
			self.vb.phase = 2
			warned_preP2 = true
			warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase))
			warnPhase:Play("phasechange")
			timerLegSweepCD:Stop()
			timerFlameGaleCD:Stop()
			countdownFlameGale:Cancel()
			timerThunderRitualCD:Start(8)
			timerWashAwayCD:Start(16)
			countdownWashAway:Start(16)
		elseif self.vb.phase == 2 and warned_preP2 and not warned_preP3 and self:GetUnitCreatureId(uId) == 114260 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.61 then --Мрргрия скоро фаза 3
			warned_preP3 = true
--[[		elseif self.vb.phase == 2 and warned_preP3 and not warned_preP4 and self:GetUnitCreatureId(uId) == 114260 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.51 then --Мрргрия фаза 3
			self.vb.phase = 3
			warned_preP4 = true
			timerLegSweepCD:Start(10)
			timerFlameGaleCD:Start(22)
			countdownFlameGale:Start(22)]]
		end
	end
end
