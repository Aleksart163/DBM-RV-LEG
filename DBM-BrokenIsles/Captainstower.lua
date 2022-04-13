local mod	= DBM:NewMod("Captainstower", "DBM-BrokenIsles", nil, 822)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
--mod:SetCreatureID(104290, 104289, 103757, 104294, 103653, 104292) 
mod:SetZone()
--mod:SetMinSyncRevision(17622)
mod.isTrashMod = true

--mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START 203342 204739 205425 204238 203884",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"UNIT_SPELLCAST_SUCCEEDED",
	"UNIT_DIED"
)

--local warnYaksam				= mod:NewCastAnnounce(223373, 3) --Отрыжка
--local warnJetsam				= mod:NewTargetAnnounce(220295, 2) --Мусор

local specWarnSmokeBomb			= mod:NewSpecialWarningInterrupt(203342, "-Healer", nil, nil, 1, 5) --Дымовая шашка
local specWarnBlizzard			= mod:NewSpecialWarningInterrupt(204739, "-Healer", nil, nil, 3, 5) --Снежная буря
local specWarnWailingArrow		= mod:NewSpecialWarningInterrupt(205425, "SpellCaster", nil, nil, 3, 5) --Стенающая стрела
local specWarnHealingTouch		= mod:NewSpecialWarningInterrupt(203884, nil, nil, nil, 3, 5) --Целительное прикосновение
local specWarnArcaneOrb			= mod:NewSpecialWarningDodge(204238, nil, nil, nil, 2, 5) --Чародейская сфера
--local specWarnPowerWordBarrier	= mod:NewSpecialWarningMove(204760, nil, nil, nil, 1, 2) --Барьер

--local specWarnGetsam			= mod:NewSpecialWarningDodge(220340, "-Tank", nil, nil, 1, 2) --Мусорка
--local specWarnBreakSam			= mod:NewSpecialWarningSpell(223317, "Melee", nil, nil, 1, 2) --Мусоробой

--local timerSmokeBombCD		= mod:NewCDTimer(21, 203342, nil, nil, nil, 5, nil, DBM_CORE_DEADLY_ICON) --Дымовая шашка
local timerBlizzardCD			= mod:NewCDTimer(20, 204739, nil, "-Healer", nil, 4, nil, DBM_CORE_INTERRUPT_ICON) --Снежная буря
local timerWailingArrowCD		= mod:NewCDTimer(21, 205425, nil, "SpellCaster", nil, 4, nil, DBM_CORE_INTERRUPT_ICON) --Стенающая стрела
--local timerPowerWordBarrierCD	= mod:NewCDTimer(50, 204760, nil, nil, nil, 1, nil, DBM_CORE_TANK_ICON) --Барьер
--local timerHealingTouchCD		= mod:NewCDTimer(50, 203884, nil, nil, nil, 1, nil, DBM_CORE_TANK_ICON) --Целительное прикосновение
--local timerArcaneOrbCD		= mod:NewCDTimer(50, 204238, nil, nil, nil, 1, nil, DBM_CORE_TANK_ICON) --Чародейская сфера

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 203342 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Дымовая шашка
		specWarnSmokeBomb:Show()
		specWarnSmokeBomb:Play("kickcast")
	elseif spellId == 204739 then --Снежная буря
		timerBlizzardCD:Start()
		specWarnBlizzard:Show()
		specWarnBlizzard:Play("kickcast")
	elseif spellId == 205425 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Стенающая стрела
		timerWailingArrowCD:Start()
		specWarnWailingArrow:Show()
		specWarnWailingArrow:Play("kickcast")
	elseif spellId == 204238 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Чародейская сфера
		specWarnArcaneOrb:Show()
	elseif spellId == 203884 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Целительное прикосновение
		specWarnHealingTouch:Show()
		specWarnHealingTouch:Play("kickcast")
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 104289 then --Алина
		timerWailingArrowCD:Cancel()
	elseif cid == 103757 then --Костехлада
		timerBlizzardCD:Cancel()
	end
end
--104290 Гримшмекс, 104289 Алина, 103757 Костехлада, 104294 Брикстон, 103653 Блэкмоу, 104292 Острый коготь
