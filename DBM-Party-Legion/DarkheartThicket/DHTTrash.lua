local mod	= DBM:NewMod("DHTTrash", "DBM-Party-Legion", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
--	"SPELL_AURA_APPLIED 240447",
--	"SPELL_AURA_REMOVED 240447",
	"SPELL_CAST_START 198379 201226"
)
--Треш Чащи Темного Сердца

local specWarnPrimalRampage				= mod:NewSpecialWarningDodge(198379, "Melee", nil, nil, 1, 2)
local specWarnBloodAssault				= mod:NewSpecialWarningDodge(201226, nil, nil, nil, 2, 2) --Кровавая атака

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 198379 then
		specWarnPrimalRampage:Show()
		specWarnPrimalRampage:Play("chargemove")
	elseif spellId == 201226 then --Кровавая атака
		specWarnBloodAssault:Show()
		specWarnBloodAssault:Play("chargemove")
	end
end
