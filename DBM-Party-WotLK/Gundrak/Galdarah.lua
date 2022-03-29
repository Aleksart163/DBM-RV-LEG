local mod	= DBM:NewMod(596, "DBM-Party-WotLK", 2, 274)
local L		= mod:GetLocalizedStrings()

--mod.statTypes = "normal,heroic,timewalker"

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(29306)
mod:SetEncounterID(390, 391, 1981)
mod:SetModelID(27061)
--
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
)
