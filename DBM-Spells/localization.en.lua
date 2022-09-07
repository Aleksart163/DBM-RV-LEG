local L

--Прошляпанное очко Мурчаля ✔✔

------------
-- Spells --
------------
L= DBM:GetModLocalization("Spells")

L:SetGeneralLocalization({
	name = "Raid Spells"
})

L:SetOptionLocalization({
	YellOnHeroism = "Announce when someone is casting a spell $spell:32182 or equivalent",
	YellOnResurrect = "Announce when someone has been subjected to $spell:20484 or equivalent",
	YellOnPortal = "Announce when someone opens $spell:224871 or equivalent",
	YellOnSoulwell = "Announce when someone is casting a spell $spell:29893",
	YellOnSoulstone = "Announce when someone has been subjected to $spell:20707",
	YellOnRitualofSummoning = "Announce when someone is casting a spell $spell:698",
	YellOnSpiritCauldron = "Announce when someone puts $spell:188036",
	YellOnLavish = "Announce when someone puts $spell:201352 or equivalent"
})

L:SetMiscLocalization{
	HeroismYell = "[DBM RV] %s uses %s!",
	PortalYell = "[DBM RV] %s opens %s!",
	SoulwellYell = "[DBM RV] %s puts %s!",
	SoulstoneYell = "[DBM RV] %s applies %s to %s!",
	SummoningYell = "[DBM RV] %s begins %s!"
}
