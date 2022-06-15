local mod	= DBM:NewMod(1469, "DBM-Party-Legion", 10, 707)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(95887)
mod:SetEncounterID(1817)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 193443 194942",
	"SPELL_PERIODIC_DAMAGE 194945",
	"SPELL_PERIODIC_MISSED 194945"
)

local warnGaze						= mod:NewSpellAnnounce(194942, 2) --Подавляющий взгляд

local specWarnFocused				= mod:NewSpecialWarningSpell(194289, nil, nil, nil, 2, 2) --Фокусировка
local specWarnGazeGTFO				= mod:NewSpecialWarningMove(194945, nil, nil, nil, 1, 2)

local timerGazeCD					= mod:NewCDTimer(19.4, 194942, nil, nil, nil, 3) --Подавляющий взгляд

function mod:OnCombatStart(delay)
	timerGazeCD:Start(11.8-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 193443 then --Фокусировка
		timerGazeCD:Stop()
		specWarnFocused:Show()
		specWarnFocused:Play("specialsoon")
	elseif spellId == 194942 then --Подавляющий взгляд
		warnGaze:Show()
		timerGazeCD:Start()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 194945 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then --Подавляющий взгляд
		specWarnGazeGTFO:Show()
		specWarnGazeGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
