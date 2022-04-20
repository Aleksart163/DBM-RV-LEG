local mod	= DBM:NewMod(728, "DBM-Party-BC", 1, 259)
local L		= mod:GetLocalizedStrings()

--mod.statTypes = "normal,heroic,timewalker"

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(20923)
mod:SetEncounterID(1935)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
)
