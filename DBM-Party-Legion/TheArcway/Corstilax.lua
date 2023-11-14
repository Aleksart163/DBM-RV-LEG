local mod	= DBM:NewMod(1498, "DBM-Party-Legion", 6, 726)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17745 $"):sub(12, -3))
mod:SetCreatureID(98205)
mod:SetEncounterID(1825)
mod:SetZone()
mod:SetUsedIcons(8, 7)
mod:SetMinSyncRevision(17745)
mod.noNormal = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 196068 195804",
	"SPELL_AURA_REMOVED 195804",
	"SPELL_CAST_START 196070 196115 220481",
	"SPELL_PERIODIC_DAMAGE 220500",
	"SPELL_PERIODIC_MISSED 220500",
	"SPELL_CAST_SUCCESS 195791"
)

--Корстилакс https://ru.wowhead.com/npc=98205/корстилакс/эпохальный-журнал-сражений
local warnSupression				= mod:NewTargetAnnounce(196070, 4) --Протокол подавления

local specWarnCleansing2			= mod:NewSpecialWarningRun(196115, nil, nil, nil, 4, 5) --Очищающая сила
local specWarnDestabilizedOrb2		= mod:NewSpecialWarningYouMove(220500, nil, nil, nil, 1, 2) --Дестабилизированная сфера аура
local specWarnDestabilizedOrb		= mod:NewSpecialWarningDodge(220481, nil, nil, nil, 2, 2) --Дестабилизированная сфера
local specWarnSupression			= mod:NewSpecialWarningYouRun(196070, nil, nil, nil, 4, 6) --Протокол подавления
local specWarnSupression2			= mod:NewSpecialWarningCloseMoveAway(196070, nil, nil, nil, 2, 2) --Протокол подавления
local specWarnQuarantine			= mod:NewSpecialWarningTargetHelp(195804, nil, nil, nil, 1, 2) --Карантин
local specWarnCleansing				= mod:NewSpecialWarningSpell(196115, nil, nil, nil, 2, 2) --Очищающая сила

local timerDestabilizedOrbCD		= mod:NewNextTimer(26, 220481, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON..DBM_CORE_MYTHIC_ICON) --Дестабилизированная сфера
local timerSupressionCD				= mod:NewNextTimer(46, 196070, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Протокол подавления
local timerQuarantineCD				= mod:NewNextTimer(46, 195804, nil, nil, nil, 7) --Карантин
local timerCleansingCD				= mod:NewNextTimer(49, 196115, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Очищающая сила
local timerCleansing				= mod:NewCastTimer(10, 196115, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Очищающая сила

local yellSupression				= mod:NewYell(196070, nil, nil, nil, "YELL") --Протокол подавления
local yellSupression2				= mod:NewFadesYell(196070, nil, nil, nil, "YELL") --Протокол подавления
local yellQuarantine				= mod:NewYellHelp(195804, nil, nil, nil, "YELL") --Карантин

local countdownCleansing			= mod:NewCountdown(49, 196115, nil, nil, 5) --Очищающая сила
local countdownCleansing2			= mod:NewCountdown("Alt10", 196115, nil, nil, 5) --Очищающая сила

mod:AddSetIconOption("SetIconOnSupression", 196068, true, false, {8}) --Протокол подавления
mod:AddSetIconOption("SetIconOnQuarantine", 195791, true, false, {7}) --Карантин

function mod:OnCombatStart(delay)
	if not self:IsNormal() then
		timerSupressionCD:Start(6-delay) --Протокол подавления
		timerQuarantineCD:Start(22.5-delay) --Карантин
		timerCleansingCD:Start(30-delay) --Очищающая сила
		countdownCleansing:Start(30-delay) --Очищающая сила
		timerDestabilizedOrbCD:Start(8.5-delay) --Дестабилизированная сфера
	else
		timerSupressionCD:Start(5-delay) --Протокол подавления
		timerQuarantineCD:Start(22.5-delay) --Карантин
		timerCleansingCD:Start(30-delay) --Очищающая сила
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 196070 then
		timerSupressionCD:Start()
	elseif spellId == 196115 then
		if not UnitIsDeadOrGhost("player") then
			specWarnCleansing:Show()
		--	specWarnCleansing:Play("aesoon")
			specWarnCleansing2:Schedule(6)
		--	specWarnCleansing2:ScheduleVoice(6, "justrun")
		end
		timerCleansingCD:Start()
		countdownCleansing:Start()
		countdownCleansing2:Start()
		timerCleansing:Start()
	elseif spellId == 220481 then --Дестабилизированная сфера
		if not UnitIsDeadOrGhost("player") then
			specWarnDestabilizedOrb:Show()
		--	specWarnDestabilizedOrb:Play("watchstep")
		end
		timerDestabilizedOrbCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 196068 then --Протокол подавления
		warnSupression:Show(args.destName)
		if args:IsPlayer() then
			specWarnSupression:Show()
		--	specWarnSupression:Play("runout")
		--	specWarnSupression:ScheduleVoice(1, "keeprun")
			yellSupression:Yell()
		elseif self:CheckNearby(10, args.destName) then
			specWarnSupression2:Show(args.destName)
		--	specWarnSupression2:Play("runout")
		end
		if self.Options.SetIconOnSupression then
			self:SetIcon(args.destName, 8, 7)
		end
	elseif spellId == 195804 then --Карантин
		if args:IsPlayer() then
			yellQuarantine:Yell()
		else
			if not UnitIsDeadOrGhost("player") then
				specWarnQuarantine:Show(args.destName)
			--	specWarnQuarantine:Play("readyrescue")
			end
		end
		if self.Options.SetIconOnQuarantine then
			self:SetIcon(args.destName, 7)
		end
	elseif spellId == 220500 then --Дестабилизированная сфера аура
		if not self:IsNormal() then
			if args:IsPlayer() then
				specWarnDestabilizedOrb2:Show()
			--	specWarnDestabilizedOrb2:Play("runout")
			end
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 195804 then --Карантин
		if self.Options.SetIconOnQuarantine then
			self:SetIcon(args.destName, 0)
		end
--[[	elseif spellId == 196068 then --Протокол подавления
		if self.Options.SetIconOnSupression then
			self:SetIcon(args.destName, 0)
		end]]
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 195791 then
		timerQuarantineCD:Start()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 220500 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		if not self:IsNormal() then
			specWarnDestabilizedOrb2:Show()
		--	specWarnDestabilizedOrb2:Play("runaway")
		end
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
