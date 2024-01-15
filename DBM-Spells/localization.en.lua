local L

--Прошляпанное очко Мурчаля [✔]

------------
-- Spells --
------------
L= DBM:GetModLocalization("Spells")

L:SetGeneralLocalization({
	name = "Raid Spells"
})

L:SetOptionLocalization({
	YellOnNapull	 		= "Announce when someone is casting a spell $spell:57934 or equivalent",
	YellOnRaidCooldown 		= "Announce when someone is casting a spell $spell:97462 or equivalent",
	YellOnResurrect 		= "Announce when someone has been subjected to $spell:20484 or equivalent",
	YellOnMassRes 			= "Announce when someone is casting a spell $spell:212036 or equivalent",
	YellOnHeroism 			= "Announce when someone is casting a spell $spell:32182 or equivalent",
	YellOnPortal 			= "Announce when someone opens $spell:224871 or equivalent",
	YellOnSoulwell 			= "Announce when someone is casting a spell $spell:29893",
	YellOnSoulstone 		= "Announce when someone has been subjected to $spell:20707",
	YellOnRitualofSummoning = "Announce when someone is casting a spell $spell:698",
	YellOnSummoning 		= "Announce when you cast a spell $spell:7720",
	YellOnSpiritCauldron 	= "Announce when someone puts $spell:188036",
	YellOnLavish 			= "Announce when someone puts $spell:201352 or equivalent",
	YellOnRepair 			= "Announce when someone puts $spell:199109 or equivalent",
	YellOnPylon 			= "Announce when someone puts $spell:199115",
	YellOnBank 				= "Announce when someone puts $spell:83958",
	YellOnToys 				= "Announce when someone puts toys like $spell:61031",
	AutoSpirit 				= "Auto-release spirit"
})

L:SetMiscLocalization{
--	WhisperThanks 	= "%s Thank you for %s!",
	SpellNameYell 	= "Using %s!",
	HeroismYell 	= "%s %s uses %s!",
	PortalYell 		= "%s %s opens %s!",
	SoulwellYell 	= "%s %s puts %s!",
	SoulstoneYell	= "%s %s applies %s to %s!",
	SummoningYell 	= "%s %s begins %s!"
}
