local mod	= DBM:NewMod(1656, "DBM-Party-Legion", 2, 762)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(99200)
mod:SetEncounterID(1838)
mod:DisableESCombatDetection()--Remove if blizz fixes trash firing ENCOUNTER_START
mod:SetZone()
mod:SetMinSyncRevision(15190)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 199389 199345",
	"SPELL_PERIODIC_DAMAGE 199460",
	"SPELL_PERIODIC_MISSED 199460",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

local warnRoar						= mod:NewSpellAnnounce(199389, 3) --Сотрясающий землю рык
local warnDownDraft					= mod:NewPreWarnAnnounce(199345, 5, 1) --Нисходящий поток

local specWarnDownDraft				= mod:NewSpecialWarningMoveBoss(199345, nil, nil, nil, 2, 2) --Нисходящий поток
local specWarnBreath				= mod:NewSpecialWarningDodge(199332, nil, nil, nil, 2, 2) --Дыхание порчи
local specWarnFallingRocks			= mod:NewSpecialWarningYouMove(199460, nil, nil, nil, 1, 2) --Каменная осыпь

local timerBreathCD					= mod:NewCDTimer(13.5, 199332, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON..DBM_CORE_DEADLY_ICON) --Дыхание порчи 15/20 сойдёт
local timerEarthShakerCD			= mod:NewCDTimer(21, 199389, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Сотрясающий землю рык (если после дыхания, то норм кд)
local timerDownDraftCD				= mod:NewCDTimer(31.5, 199345, nil, nil, nil, 7) --Нисходящий поток 30-42 +++
local timerDownDraft				= mod:NewCastTimer(9, 199345, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Нисходящий поток +++

local countdownDownDraft			= mod:NewCountdown(31.5, 199345) --Нисходящий поток

function mod:OnCombatStart(delay)
	timerBreathCD:Start(13-delay) --Дыхание порчи +++
	timerEarthShakerCD:Start(20-delay) --Сотрясающий землю рык +++
	timerDownDraftCD:Start(20-delay) --Нисходящий поток +++
	warnDownDraft:Schedule(15-delay) --Нисходящий поток +++
	countdownDownDraft:Start(20-delay) --Нисходящий поток +++
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 199389 then
		warnRoar:Show()
	--	timerEarthShakerCD:Start()
	elseif spellId == 199345 then
		specWarnDownDraft:Show()
		specWarnDownDraft:Play("keepmove")
		timerDownDraftCD:Start()
		timerDownDraft:Start()
		warnDownDraft:Schedule(26.5)
		countdownDownDraft:Start()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 199460 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnFallingRocks:Show()
		specWarnFallingRocks:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 199332 then--Even with this scanner, it's abougt 50/50 hit or miss you can grab a target at all
		specWarnBreath:Show()
		specWarnBreath:Play("breathsoon")
		timerBreathCD:Start()
		timerEarthShakerCD:Start(5)
	end
end
