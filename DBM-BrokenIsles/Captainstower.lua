local mod	= DBM:NewMod("Captainstower", "DBM-BrokenIsles", nil, 822)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17745 $"):sub(12, -3))
mod:SetZone()
mod:SetMinSyncRevision(17745)

mod.noStatistics = true
mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 203342 205425 204238 203884",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"UNIT_SPELLCAST_SUCCEEDED",
	"UNIT_DIED"
)

--local warnYaksam				= mod:NewCastAnnounce(223373, 3) --Отрыжка
--local warnJetsam				= mod:NewTargetAnnounce(220295, 2) --Мусор

local specWarnSmokeBomb			= mod:NewSpecialWarningInterrupt(203342, "HasInterrupt", nil, nil, 1, 3) --Дымовая шашка
local specWarnWailingArrow		= mod:NewSpecialWarningInterrupt(205425, "SpellCaster", nil, nil, 3, 3) --Стенающая стрела
local specWarnHealingTouch		= mod:NewSpecialWarningInterrupt(203884, "HasInterrupt", nil, nil, 1, 3) --Целительное прикосновение
local specWarnArcaneOrb			= mod:NewSpecialWarningDodge(204238, nil, nil, nil, 2, 5) --Чародейская сфера
--local specWarnPowerWordBarrier	= mod:NewSpecialWarningMove(204760, nil, nil, nil, 1, 2) --Барьер

--local specWarnGetsam			= mod:NewSpecialWarningDodge(220340, "-Tank", nil, nil, 1, 2) --Мусорка
--local specWarnBreakSam			= mod:NewSpecialWarningSpell(223317, "Melee", nil, nil, 1, 2) --Мусоробой

--local timerSmokeBombCD		= mod:NewCDTimer(21, 203342, nil, nil, nil, 5, nil, DBM_CORE_DEADLY_ICON) --Дымовая шашка
local timerWailingArrowCD		= mod:NewCDTimer(21, 205425, nil, "SpellCaster", nil, 4, nil, DBM_CORE_INTERRUPT_ICON) --Стенающая стрела

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 203342 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Дымовая шашка
		specWarnSmokeBomb:Show()
	--	specWarnSmokeBomb:Play("kickcast")
	elseif spellId == 205425 then --Стенающая стрела
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if cid == 104289 then
			timerWailingArrowCD:Start()
		end
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnWailingArrow:Show()
		--	specWarnWailingArrow:Play("kickcast")
		end
	elseif spellId == 204238 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Чародейская сфера
		specWarnArcaneOrb:Show()
	elseif spellId == 203884 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Целительное прикосновение
		specWarnHealingTouch:Show()
	--	specWarnHealingTouch:Play("kickcast")
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 104289 then --Алина
		timerWailingArrowCD:Cancel()
	end
end
--104290 Гримшмекс, 104289 Алина, 103757 Костехлада, 104294 Брикстон, 103653 Блэкмоу, 104292 Острый коготь
