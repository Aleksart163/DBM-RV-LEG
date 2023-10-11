local mod	= DBM:NewMod("TNTrash", "DBM-Party-WotLK", 4, 281)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 13323",
	"SPELL_AURA_APPLIED 13323",
	"SPELL_AURA_REMOVED 13323"
)

--Нексус треш https://www.wowhead.com/ru/zone=4265/нексус#npcs
local warnPolymorph						= mod:NewTargetAnnounce(13323, 2) --Превращение

local specWarnPolymorph					= mod:NewSpecialWarningInterrupt(13323, "HasInterrupt", nil, nil, 1, 2) --Превращение

local yellPolymorph						= mod:NewYellDispel(13323, nil, nil, nil, "YELL") --Превращение
local yellPolymorph2					= mod:NewFadesYell(13323, nil, nil, nil, "YELL") --Превращение

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 13323 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Превращение
		specWarnPolymorph:Show()
		specWarnPolymorph:Play("kickcast")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 13323 then --Превращение
		if args:IsPlayer() then
			yellPolymorph:Yell()
			yellPolymorph2:Countdown(6, 3)
		else
			warnPolymorph:CombinedShow(0.3, args.destName)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 13323 then --Превращение
		if args:IsPlayer() then
			yellPolymorph2:Cancel()
		end
	end
end
