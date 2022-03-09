local mod	= DBM:NewMod("EoATrash", "DBM-Party-Legion", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17522 $"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 196870 195046 195284 197105",
	"SPELL_AURA_APPLIED 196127 192706 197105"
)

--TODO, still missing some GTFOs for this. Possibly other important spells.
local warnArcaneBomb			= mod:NewTargetAnnounce(192706, 4) --Чародейская бомба
local warnPolymorph				= mod:NewTargetAnnounce(197105, 1) --Превращение в рыбу

local specWarnPolymorph			= mod:NewSpecialWarningInterrupt(197105, "HasInterrupt", nil, nil, 3, 5) --Превращение в рыбу
local specWarnPolymorph2		= mod:NewSpecialWarningDispel(197105, "Healer", nil, nil, 3, 5) --Превращение в рыбу
local specWarnStorm				= mod:NewSpecialWarningInterrupt(196870, "HasInterrupt", nil, nil, 1, 2)
local specWarnRejuvWaters		= mod:NewSpecialWarningInterrupt(195046, "HasInterrupt", nil, nil, 1, 2)
local specWarnUndertow			= mod:NewSpecialWarningInterrupt(195284, "HasInterrupt", nil, nil, 1, 2)--Might only be interruptable by stuns, if so change option default?
local specWarnSpraySand			= mod:NewSpecialWarningDodge(196127, "Tank", nil, nil, 1, 2)
local specWarnArcaneBomb		= mod:NewSpecialWarningMoveAway(192706, nil, nil, nil, 3, 2) --Чародейская бомба
local specWarnArcaneBomb2		= mod:NewSpecialWarningDispel(192706, "Healer", nil, nil, 3, 5) --Чародейская бомба

local timerPolymorph			= mod:NewTargetTimer(8, 197105, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON) --Превращение в рыбу

local yellArcaneBomb			= mod:NewYell(192706, nil, nil, nil, "YELL")
local yellPolymorph				= mod:NewYell(197105, nil, nil, nil, "YELL") --Превращение в рыбу

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 196870 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnStorm:Show(args.sourceName)
		specWarnStorm:Play("kickcast")
	elseif spellId == 195046 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnRejuvWaters:Show(args.sourceName)
		specWarnRejuvWaters:Play("kickcast")
	elseif spellId == 195284 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnUndertow:Show(args.sourceName)
		specWarnUndertow:Play("kickcast")
	elseif spellId == 197105 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Превращение в рыбу
		specWarnPolymorph:Show(args.sourceName)
		specWarnPolymorph:Play("kickcast")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 196127 then
		specWarnSpraySand:Show()
		specWarnSpraySand:Play("shockwave")
	elseif spellId == 192706 then --Чародейская бомба
		warnArcaneBomb:Show(args.destName)
		if args:IsPlayer() then
			specWarnArcaneBomb:Show()
			specWarnArcaneBomb:Play("runout")
			yellArcaneBomb:Yell()
		else
			specWarnArcaneBomb2:Show(args.destName)
		end
	elseif spellId == 197105 then --Превращение
		warnPolymorph:Show(args.destName)
		timerPolymorph:Start(args.destName)
		if args:IsPlayer() then
			yellPolymorph:Yell()
		else
			specWarnPolymorph2:Show(args.destName)
		end
	end
end
