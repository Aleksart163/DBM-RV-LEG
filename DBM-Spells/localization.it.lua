if GetLocale() ~= "itIT" then return end

local L

--Прошляпанное очко Мурчаля [✔]

----------------------
-- Incantesimi RAID --
----------------------
L= DBM:GetModLocalization("Spells")

L:SetGeneralLocalization({
	name = "Incantesimi RAID"
})

L:SetOptionLocalization({
	YellOnMassRes = "Segnala quando qualcuno lancia l'incantesimo $spell:212036 o simili",
	YellOnManaRegen = "Segnala quando qualcuno lancia l'incantesimo $spell:29166 o simili",
	YellOnHeroism = "Segnala quando qualcuno lancia l'incantesimo $spell:32182 o simili",
	YellOnResurrect = "Segnala quando qualcuno è diventato un obiettivo $spell:20484 o simili",
	YellOnPortal = "Segnala quando qualcuno apre $spell:224871 o simili",
	YellOnSoulwell = "Segnala quando qualcuno lancia l'incantesimo $spell:29893",
	YellOnSoulstone = "Segnala quando qualcuno è diventato un obiettivo $spell:20707",
	YellOnRitualofSummoning = "Segnala quando qualcuno lancia l'incantesimo $spell:698",
	YellOnSummoning = "Segnala quando si applica un incantesimo $spell:7720",
	YellOnSpiritCauldron = "Segnala quando qualcuno mette $spell:188036",
	YellOnLavish = "Segnala quando qualcuno mette $spell:201352 o simili",
	YellOnRepair = "Segnala quando qualcuno mette $spell:199109 o simili",
	YellOnPylon = "Segnala quando qualcuno mette $spell:199115",
	YellOnBank = "Segnala quando qualcuno mette $spell:83958"
})

L:SetMiscLocalization{
	WhisperThanks = "%s Grazie per %s!",
	InnervateYell = "%s su %s!",
	SymbolHopeYell = "Utilizzo %s!",
	HeroismYell = "%s %s utilizza %s!",
	PortalYell = "%s %s apre %s!",
	SoulwellYell = "%s %s mette %s!",
	SoulstoneYell = "%s %s applica la %s a %s!",
	SummoningYell = "%s %s inizia %s!",
	SummonYell = "%s %s applica la %s a %s!"
}
