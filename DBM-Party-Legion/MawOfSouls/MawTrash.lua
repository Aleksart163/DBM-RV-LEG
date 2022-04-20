local mod	= DBM:NewMod("MawTrash", "DBM-Party-Legion", 8)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17522 $"):sub(12, -3))
--mod:SetEncounterID(1823)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 198405 195031 195293 196885",
	"SPELL_CAST_SUCCESS 195279",
	"SPELL_AURA_APPLIED 195279",
	"SPELL_AURA_REMOVED 195279"
)

local warnScream				= mod:NewSpellAnnounce(198405, 4) --Леденящий душу вопль

local specWarnBind				= mod:NewSpecialWarningYouDefensive(195279, nil, nil, nil, 2, 5) --Связывание
local specWarnScream			= mod:NewSpecialWarningInterrupt(198405, "HasInterrupt", nil, nil, 1, 2) --Леденящий душу вопль
local specWarnDebilitatingShout	= mod:NewSpecialWarningInterrupt(195293, "HasInterrupt", nil, nil, 1, 2) --Истощающий крик
local specWarnGiveNoQuarter		= mod:NewSpecialWarningDodge(196885, nil, nil, nil, 2, 3) --Не щадить никого

local specWarnDefiantStrike		= mod:NewSpecialWarningDodge(195031, nil, nil, nil, 1, 2)

local timerBindCD				= mod:NewCDTimer(15, 195279, nil, "Tank", nil, 3, nil, DBM_CORE_TANK_ICON) --Связывание
local timerDebilitatingShoutCD	= mod:NewCDTimer(13.5, 195293, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON) --Истощающий крик
local timerGiveNoQuarterCD		= mod:NewCDTimer(10, 196885, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Не щадить никого

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 198405 then
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnScream:Show(args.sourceName)
			specWarnScream:Play("kickcast")
		else
			warnScream:Show()
		end
	elseif spellId == 195031 and self:AntiSpam(3, 1) then
		specWarnDefiantStrike:Show()
		specWarnDefiantStrike:Play("chargemove")
	elseif spellId == 195293 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Истощающий крик
		specWarnDebilitatingShout:Show()
		specWarnDebilitatingShout:Play("kickcast")
		timerDebilitatingShoutCD:Start()
	elseif spellId == 196885 then --Не щадить никого
		specWarnGiveNoQuarter:Show()
		specWarnGiveNoQuarter:Play("stilldanger")
		timerGiveNoQuarterCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 195279 then --Связывание
		timerBindCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 195279 then --Связывание
		if args:IsPlayer() then
			specWarnBind:Show()
		end
	end
end

--[[function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 195279 then

end]]
