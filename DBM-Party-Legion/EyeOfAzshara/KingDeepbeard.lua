local mod	= DBM:NewMod(1491, "DBM-Party-Legion", 3, 716)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(91797)
mod:SetEncounterID(1812)
mod:SetZone()
mod:SetUsedIcons(8, 7)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 193152 193093 193018",
	"SPELL_CAST_SUCCESS 193051 193152",
	"SPELL_AURA_APPLIED 193018 197550",
	"SPELL_AURA_REMOVED 193018",
	"UNIT_HEALTH boss1"
)

--Король Волнобород https://ru.wowhead.com/npc=91797/король-волнобород/эпохальный-журнал-сражений
local warnBubbles					= mod:NewTargetAnnounce(193018, 4) --Пузырь газа
local warnFrenzy					= mod:NewTargetAnnounce(197550, 4) --Бешенство
local warnFrenzy2					= mod:NewSoonAnnounce(197550, 1) --Бешенство
local warnCallSeas					= mod:NewSpellAnnounce(193051, 2) --Зов морей

local specWarnQuake					= mod:NewSpecialWarningMoveAway(193152, nil, nil, nil, 1, 2) --Землетрясение
local specWarnQuake2				= mod:NewSpecialWarningYouMove(193152, nil, nil, nil, 2, 2) --Землетрясение
local specWarnGroundSlam			= mod:NewSpecialWarningDodge(193093, "Melee", nil, nil, 1, 3) --Удар по земле
local specWarnBubbles2				= mod:NewSpecialWarningYou(193018, nil, nil, nil, 3, 3) --Пузырь газа
local specWarnBubbles3				= mod:NewSpecialWarningEnd(193018, nil, nil, nil, 1, 2) --Пузырь газа
--local specWarnCallSeas				= mod:NewSpecialWarningDodge(193051, nil, nil, nil, 2, 2) --Зов морей

local timerQuakeCD					= mod:NewCDTimer(21.8, 193152, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Землетрясение 21-25 +++
local timerCallSeasCD				= mod:NewNextTimer(30, 193051, nil, nil, nil, 2) --Зов морей
local timerGroundSlamCD				= mod:NewCDTimer(18.2, 193093, nil, "Melee", nil, 5, nil, DBM_CORE_TANK_ICON..DBM_CORE_DEADLY_ICON) --Удар по земле 18.2-30
local timerBubblesCD				= mod:NewNextTimer(32, 193018, nil, nil, nil, 7) --Пузырь газа
local timerBubbles					= mod:NewTargetTimer(20, 193047, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Взрыв газа+++

local countdownQuake				= mod:NewCountdown(21.8, 193152, nil, nil, 5) --Землетрясение

local yellBubbles					= mod:NewYell(193018, nil, nil, nil, "YELL") --Пузырь газа
local yellBubbles2					= mod:NewFadesYell(193018, nil, nil, nil, "YELL") --Пузырь газа

mod:AddSetIconOption("SetIconOnBubbles", 193018, true, false, {8, 7}) --Пузырь газа

mod:AddRangeFrameOption(5, 193152) --Землетрясение

mod.vb.bubblesIcon = 8
mod.vb.phase = 1
local warned_preP1 = false
local warned_preP2 = false

function mod:OnCombatStart(delay)
	self.vb.bubblesIcon = 8
	self.vb.phase = 1
	warned_preP1 = false
	warned_preP2 = false
	if not self:IsNormal() then
		timerGroundSlamCD:Start(5-delay) --Удар по земле+++
		timerBubblesCD:Start(10-delay) --Пузырь газа+++
		timerQuakeCD:Start(16-delay) --Землетрясение+++
		countdownQuake:Start(16-delay) --Землетрясение+++
		timerCallSeasCD:Start(20.5-delay) --Зов морей+++
	else
		timerBubblesCD:Start(10-delay) --Пузырь газа
		timerQuakeCD:Start(15-delay) --Землетрясение
		timerCallSeasCD:Start(20-delay) --Зов морей
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 193152 then --Землетрясение
		specWarnQuake:Show()
		specWarnQuake:Play("range5")
		if self:IsHard() then
			timerQuakeCD:Start(24)
			countdownQuake:Start(24)
		else
			timerQuakeCD:Start()
			countdownQuake:Start()
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(5, nil, nil, nil, nil, 5.5)
		end
	elseif spellId == 193093 then --Удар по земле
		specWarnGroundSlam:Show()
		specWarnGroundSlam:Play("shockwave")
		timerGroundSlamCD:Start()
	elseif spellId == 193018 then --Пузырь газа
		timerBubblesCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 193051 then --Зов морей
		warnCallSeas:Show()
		warnCallSeas:Play("watchstep")
		timerCallSeasCD:Start()
	elseif spellId == 193152 then --Землетрясение
		specWarnQuake2:Schedule(1)
		specWarnQuake2:ScheduleVoice(1, "watchstep")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 193018 then --Пузырь газа
		self.vb.bubblesIcon = self.vb.bubblesIcon - 1
		warnBubbles:CombinedShow(1.5, args.destName)
		timerBubbles:Start(args.destName)
		if args:IsPlayer() then
			specWarnBubbles2:Show()
			specWarnBubbles2:Play("takedamage")
			yellBubbles:Yell()
			yellBubbles2:Countdown(20, 3)
		end
		if self.Options.SetIconOnBubbles then
			self:SetIcon(args.destName, self.vb.bubblesIcon)
		end
	elseif spellId == 197550 then --Бешенство
		warnFrenzy:Show(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 193018 then --Пузырь газа
		self.vb.bubblesIcon = self.vb.bubblesIcon + 1
		timerBubbles:Cancel(args.destName)
		if args:IsPlayer() then
			specWarnBubbles3:Show()
			yellBubbles2:Cancel()
		end
		if self.Options.SetIconOnBubbles then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:UNIT_HEALTH(uId)
	if self:IsHard() then --миф и миф+
		if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 91797 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.41 then --Король Волнобород
			warned_preP1 = true
			warnFrenzy2:Show()
		elseif self.vb.phase == 1 and warned_preP1 and not warned_preP2 and self:GetUnitCreatureId(uId) == 91797 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.31 then --Король Волнобород
			warned_preP2 = true
			self.vb.phase = 2
		end
	else
		if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 91797 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.41 then --Король Волнобород
			warned_preP1 = true
		elseif self.vb.phase == 1 and warned_preP1 and not warned_preP2 and self:GetUnitCreatureId(uId) == 91797 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.31 then --Король Волнобород
			warned_preP2 = true
			self.vb.phase = 2
		end
	end
end
