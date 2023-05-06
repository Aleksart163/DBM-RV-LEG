if GetLocale() ~= "frFR" then return end

local L

--Прошляпанное очко Мурчаля ✔✔

-------------------
-- Sorts de RAID --
-------------------
L= DBM:GetModLocalization("Spells")

L:SetGeneralLocalization({
	name = "Sorts de RAID"
})

L:SetOptionLocalization({
	YellOnMassRes = "Signaler quand quelqu'un applique un sort $spell:212036 ou similaire",
	YellOnHeroism = "Signaler quand quelqu'un applique un sort $spell:32182 ou similaire",
	YellOnResurrect = "Signaler quand quelqu'un est devenu la cible d'un sort $spell:20484 ou similaire",
	YellOnPortal = "Signaler quand quelqu'un ouvre $spell:224871 ou similaire",
	YellOnSoulwell = "Signaler quand quelqu'un applique un sort $spell:29893",
	YellOnSoulstone = "Signaler quand quelqu'un est devenu la cible d'un sort $spell:20707",
	YellOnRitualofSummoning = "Signaler quand quelqu'un applique un sort $spell:698",
	YellOnSpiritCauldron = "Signaler quand quelqu'un met $spell:188036",
	YellOnLavish = "Signaler quand quelqu'un met $spell:201352 ou similaire",
	YellOnRepair = "Signaler quand quelqu'un met $spell:199109 ou similaire",
	YellOnPylon = "Signaler quand quelqu'un met $spell:199115",
	YellOnBank = "Signaler quand quelqu'un met $spell:83958"
})

L:SetMiscLocalization{
	InnervateYell = "%s sur %s!",
	SymbolHopeYell = "Application %s!",
	HeroismYell = "%s %s utilise %s!",
	PortalYell = "%s %s ouvre %s!",
	SoulwellYell = "%s %s établit %s!",
	SoulstoneYell = "%s %s s'applique %s sur %s!",
	SummoningYell = "%s %s commence %s!"
}
