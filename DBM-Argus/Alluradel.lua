local mod	= DBM:NewMod(2011, "DBM-Argus", nil, 959)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(124625)
mod:SetEncounterID(2083)
--mod:SetReCombatTime(20)
mod:SetZone()
--mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat_yell", L.Pull)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 247549 247604",
	"SPELL_CAST_SUCCESS 247517",
	"SPELL_AURA_APPLIED 247551 247544 247517",
	"SPELL_AURA_APPLIED_DOSE 247544"
)

local warnBeguilingCharm			= mod:NewTargetAnnounce(247549, 4) --Обманные чары
local warnBeguilingCharm2			= mod:NewSoonAnnounce(247549, 1) --Обманные чары
local warnFelLash					= mod:NewSpellAnnounce(247604, 2) --Бич Скверны
local warnHeartBreaker				= mod:NewTargetAnnounce(247517, 3, nil, "Healer") --Разбитое сердце

local specWarnFelLash				= mod:NewSpecialWarningDodge(247604, "-Tank", nil, nil, 2, 2) --Бич Скверны
local specWarnBeguilingCharm		= mod:NewSpecialWarningLookAway(247549, nil, nil, nil, 3, 5) --Обманные чары
local specWarnSadist				= mod:NewSpecialWarningStack(247544, nil, 15, nil, nil, 1, 2) --Садизм
local specWarnSadistOther			= mod:NewSpecialWarningTaunt(247544, nil, nil, nil, 1, 2) --Садизм

local timerBeguilingCharmCD			= mod:NewCDTimer(47, 247549, nil, nil, nil, 2, nil, DBM_CORE_IMPORTANT_ICON) --Обманные чары +++
local timerFelLashCD				= mod:NewCDTimer(36, 247604, nil, "Melee", nil, 5, nil, DBM_CORE_TANK_ICON) --Бич Скверны +++
local timerHeartBreakerCD			= mod:NewCDTimer(24.5, 247517, nil, nil, nil, 2, nil, DBM_CORE_HEALER_ICON..DBM_CORE_MAGIC_ICON) --Разбитое сердце +++

local countdownBeguilingCharm		= mod:NewCountdown(47, 247549, nil, nil, 5) --Обманные чары

mod:AddReadyCheckOption(48620, false)

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then
		timerHeartBreakerCD:Start(6.5-delay) --Разбитое сердце +++
		timerFelLashCD:Start(16.5-delay) --Бич Скверны +++
		timerBeguilingCharmCD:Start(32.5-delay) --Обманные чары +++
		countdownBeguilingCharm:Start(32.5-delay) --Обманные чары +++
		warnBeguilingCharm2:Schedule(22.5-delay) --Обманные чары
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 247549 then --Обманные чары
		specWarnBeguilingCharm:Schedule(1.5)
		specWarnBeguilingCharm:ScheduleVoice(1.5, "turnaway")
		timerBeguilingCharmCD:Start()
		countdownBeguilingCharm:Start()
		warnBeguilingCharm2:Schedule(37)
	elseif spellId == 247604 then --Бич Скверны
		warnFelLash:Show()
		specWarnFelLash:Show()
		specWarnFelLash:Play("watchstep")
		timerFelLashCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 247517 then --Разбитое сердце
		timerHeartBreakerCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 247551 then
		warnBeguilingCharm:CombinedShow(0.5, args.destName)
	elseif spellId == 247544 then
		local amount = args.amount or 1
		if (amount >= 15) and self:AntiSpam(4, 4) then--First warning at 12, then spam every 4 seconds above.
			if self:IsTanking("player", "boss1", nil, true) then
				specWarnSadist:Show(amount)
				specWarnSadist:Play("changemt")
			else
				specWarnSadistOther:Show(L.name)
				specWarnSadistOther:Play("changemt")
			end
		end
	elseif spellId == 247517 then
		warnHeartBreaker:CombinedShow(0.3, args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
