local mod	= DBM:NewMod(1480, "DBM-Party-Legion", 3, 716)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(91784)
mod:SetEncounterID(1810)
mod:SetZone()
mod:SetUsedIcons(8, 7)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 192094 197064 197495 192131",
	"SPELL_AURA_APPLIED_DOSE 197495",
	"SPELL_CAST_START 192072 192073 196563 197502 191900",
	"SPELL_PERIODIC_DAMAGE 192053",
	"SPELL_PERIODIC_MISSED 192053",
	"UNIT_HEALTH boss1"
)

--Полководец Паржеш https://ru.wowhead.com/npc=91784/полководец-паржеш/эпохальный-журнал-сражений
local warnEnrage2					= mod:NewSoonAnnounce(197064, 1) --Исступление
local warnEnrage					= mod:NewTargetAnnounce(197064, 4) --Исступление
local warnImpalingSpear				= mod:NewTargetAnnounce(192094, 4) --Пронзающее копье
local warnRestoration				= mod:NewCastAnnounce(197502, 4) --Исцеление
local warnMotivated					= mod:NewStackAnnounce(197495, 3) --Мотивация
local warnThrowSpear				= mod:NewTargetAnnounce(192131, 3) --Бросок копья

local specWarnThrowSpear			= mod:NewSpecialWarningYouDefensive(192131, nil, nil, nil, 3, 3) --Бросок копья
local specWarnQuicksand				= mod:NewSpecialWarningYouMove(192053, nil, nil, nil, 1, 2) --Зыбучие пески
local specWarnReinforcements		= mod:NewSpecialWarningSwitch(196563, "Tank", nil, nil, 1, 2) --Вызов подкрепления
local specWarnCrashingwave			= mod:NewSpecialWarningDodge(191900, nil, nil, nil, 2, 2) --Сокрушительная волна
local specWarnImpalingSpear			= mod:NewSpecialWarningMoveTo(192094, nil, nil, nil, 3, 5) --Пронзающее копье
local specWarnImpalingSpear2		= mod:NewSpecialWarningDodge(192094, nil, nil, nil, 2, 2) --Пронзающее копье
local specWarnRestoration			= mod:NewSpecialWarningInterrupt(197502, "HasInterrupt", nil, nil, 1, 2) --Исцеление

local timerHatecoilCD				= mod:NewCDTimer(28, 192072, nil, nil, nil, 1, nil, DBM_CORE_TANK_ICON..DBM_CORE_DAMAGE_ICON) --Вызов подкрепления+++
local timerSpearCD					= mod:NewCDTimer(26.5, 192094, nil, nil, nil, 7) --Пронзающее копье+++
local timerThrowSpear				= mod:NewTargetTimer(9, 192131, nil, nil, nil, 3, nil, DBM_CORE_HEALER_ICON..DBM_CORE_DEADLY_ICON) --Бросок копья+++

local yellImpalingSpear				= mod:NewYell(192094, nil, nil, nil, "YELL") --Пронзающее копье
local yellImpalingSpear2			= mod:NewShortFadesYell(192094, nil, nil, nil, "YELL") --Пронзающее копье
local yellThrowSpear				= mod:NewYell(192131, nil, nil, nil, "YELL") --Бросок копья
local yellThrowSpear2				= mod:NewShortFadesYell(192131, nil, nil, nil, "YELL") --Бросок копья

local countdownSpear				= mod:NewCountdown(26.5, 192094, nil, nil, 5) --Пронзающее копье
local countdownSpear2				= mod:NewCountdownFades("Alt5", 192094, nil, nil, 5) --Пронзающее копье

mod:AddSetIconOption("SetIconOnImpalingSpear", 192094, true, false, {8}) --Пронзающее копье
mod:AddSetIconOption("SetIconOnThrowSpear", 192131, true, false, {7}) --Бросок копья

local trash = DBM:GetSpellInfo(192072)

mod.vb.phase = 1
local warned_preP1 = false
local warned_preP2 = false

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	warned_preP1 = false
	warned_preP2 = false
	if not self:IsNormal() then
		timerHatecoilCD:Start(3-delay) --Вызов подкрепления
		timerSpearCD:Start(28.5-delay) --Пронзающее копье+++
		countdownSpear:Start(28.5-delay) --Пронзающее копье+++
	else
		timerHatecoilCD:Start(3-delay) --Вызов подкрепления
		timerSpearCD:Start(28-delay) --Пронзающее копье
		countdownSpear:Start(28-delay) --Пронзающее копье
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 192094 then --Пронзающее копье
		timerSpearCD:Start()
		countdownSpear:Start()
		countdownSpear2:Start()
		if args:IsPlayer() then
			specWarnImpalingSpear:Show(trash)
			specWarnImpalingSpear:Play("192094")
			yellImpalingSpear:Yell()
			yellImpalingSpear2:Countdown(5, 3)
		else
			warnImpalingSpear:Show(args.destName)
			specWarnImpalingSpear2:Show()
		end
		if self.Options.SetIconOnImpalingSpear then
			self:SetIcon(args.destName, 8, 5)
		end
	elseif spellId == 197064 then --Исступление
		warnEnrage:Show(args.destName)
	elseif spellId == 197495 then --Мотивация
		local amount = args.amount or 1
		warnMotivated:Show(args.destName, amount)
	elseif spellId == 192131 then --Бросок копья
		warnThrowSpear:Show(args.destName)
		timerThrowSpear:Start(args.destName)
		if args:IsPlayer() then
			if self:IsHard() then
				specWarnThrowSpear:Show()
				specWarnThrowSpear:Play("defensive")
				yellThrowSpear:Yell()
				yellThrowSpear2:Countdown(9, 3)
			else
				yellThrowSpear:Yell()
				yellThrowSpear2:Countdown(9, 3)
			end
		end
		if self.Options.SetIconOnThrowSpear then
			self:SetIcon(args.destName, 7, 9)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 192073 and self:IsNormal() then--Caster mob
		specWarnReinforcements:Show()
		specWarnReinforcements:Play("bigmobsoon")
		timerHatecoilCD:Start(20)
	elseif spellId == 192072 and self:IsNormal() then--Melee mob
		specWarnReinforcements:Show()
		specWarnReinforcements:Play("bigmobsoon")
		timerHatecoilCD:Start(33)
	elseif spellId == 196563 then--Both of them (heroic+)
		specWarnReinforcements:Show()
		specWarnReinforcements:Play("bigmobsoon")
		timerHatecoilCD:Start()
	elseif spellId == 197502 then
		specWarnRestoration:Show()
		specWarnRestoration:Play("kickcast")
	elseif spellId == 191900 then
		specWarnCrashingwave:Show()
		specWarnCrashingwave:Play("chargemove")
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 192053 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then --Зыбучие пески (после чарджа)
		if self:IsHard() then
			specWarnQuicksand:Show()
			specWarnQuicksand:Play("runaway")
		end
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_HEALTH(uId)
	if self:IsHard() then --миф и миф+
		if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 91784 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.40 then --Полководец Паржеш
			warned_preP1 = true
			warnEnrage2:Show()
		elseif self.vb.phase == 1 and warned_preP1 and not warned_preP2 and self:GetUnitCreatureId(uId) == 91784 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.30 then --Полководец Паржеш
			warned_preP2 = true
			self.vb.phase = 2
		end
	else
		if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 91784 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.40 then --Полководец Паржеш
			warned_preP1 = true
		elseif self.vb.phase == 1 and warned_preP1 and not warned_preP2 and self:GetUnitCreatureId(uId) == 91784 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.30 then --Полководец Паржеш
			warned_preP2 = true
			self.vb.phase = 2
		end
	end
end
