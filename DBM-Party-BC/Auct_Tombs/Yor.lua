local mod	= DBM:NewMod(536, "DBM-Party-BC", 4, 250)
local L		= mod:GetLocalizedStrings()

--mod.statTypes = "normal,heroic,timewalker"

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(22930)
--mod:SetEncounterID(250)--Verify before enable

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
)
