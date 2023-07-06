local mod	= DBM:NewMod(599, "DBM-Party-WotLK", 3, 275)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(28546)
mod:SetEncounterID(559, 560, 1984)
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 52658 59795",
	"SPELL_AURA_REMOVED 52658 59795",
	"SPELL_CAST_START 52770",
	"UNIT_HEALTH boss1"
)

local warningDisperseSoon	= mod:NewSoonAnnounce(52770, 2)
local warningOverload		= mod:NewTargetAnnounce(52658, 2)

local specWarnOverload		= mod:NewSpecialWarningYouMoveAway(52658, nil, nil, nil, 3, 6) --Статическая перегрузка
local specWarnDisperse		= mod:NewSpecialWarningRun(52770, nil, nil, nil, 3, 6) --Рассеяние

local timerOverload			= mod:NewTargetTimer(10, 52658, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Рассеяние
local timerDisperse			= mod:NewBuffFadesTimer(13, 52770, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Рассеяние

local yellOverload			= mod:NewYellMoveAway(52658, nil, nil, nil, "YELL") --Статическая перегрузка
local yellOverload2			= mod:NewFadesYell(52658, nil, nil, nil, "YELL") --Статическая перегрузка

mod:AddRangeFrameOption(10, 52658)
mod:AddSetIconOption("SetIconOnOverloadTarget", 59795, true, false, {8})

local warnedDisperse = false

function mod:OnCombatStart()
	warnedDisperse = false
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(52658, 59795) then --Статическая перегрузка
		if args:IsPlayer() then
			specWarnOverload:Show()
			specWarnOverload:Play("runaway")
			yellOverload:Yell()
			yellOverload2:Countdown(10, 3)
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10)
			end
		else
			warningOverload:Show(args.destName)
		end
		timerOverload:Start(args.destName)
		if self.Options.SetIconOnOverloadTarget then
			self:SetIcon(args.destName, 8)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(52658, 59795) then
		if args:IsPlayer() and self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
		if self.Options.SetIconOnOverloadTarget then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 52770 then --Рассеяние
		specWarnDisperse:Show()
		specWarnDisperse:Play("runaway")
		timerDisperse:Start()
	end
end

function mod:UNIT_HEALTH(uId)
	if not warnedDisperse and self:GetUnitCreatureId(uId) == 28546 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.56 then
		warnedDisperse = true
		warningDisperseSoon:Show()
	end
end
