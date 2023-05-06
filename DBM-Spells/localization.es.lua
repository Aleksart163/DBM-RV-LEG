if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L

--Прошляпанное очко Мурчаля [✔]

----------------
-- Заклинания --
----------------
L= DBM:GetModLocalization("Spells")

L:SetGeneralLocalization({
	name = "Hechizos de banda"
})

L:SetOptionLocalization({
	YellOnMassRes = "Avisar, cuando alguien esta usando hechizo $spell:212036 o similar",
	YellOnManaRegen = "Avisar, cuando alguien esta usando hechizo $spell:29166 o similar",
	YellOnHeroism = "Avisar, cuando alguien esta usando hechizo $spell:32182 o similar",
	YellOnResurrect = "Avisar, cuando y sobre quien han usado $spell:20484 o similar",
	YellOnPortal = "Avisar, cuando alguien esta abriendo $spell:224871 o similar",
	YellOnSoulwell = "Avisar, cuando alquien esta usando hechizo $spell:29893",
	YellOnSoulstone = "Avisar, sobre quien han usado $spell:20707",
	YellOnRitualofSummoning = "Avisar, cuando alguien esta usando hechizo $spell:698",
	YellOnSpiritCauldron = "Avisar, cuando alguien esta poniendo $spell:188036",
	YellOnLavish = "Avisar, cuando alguien esta poniendo $spell:201352 o similar",
	YellOnRepair = "Avisar, cuando alguien esta poniendo $spell:199109 o similar",
	YellOnPylon = "Avisar, cuando alguien esta poniendo $spell:199115",
	YellOnBank = "Avisar, cuando alguien esta poniendo $spell:83958"
})

L:SetMiscLocalization{
	InnervateYell = "%s en %s!",
	SymbolHopeYell = "Aplicación de %s!",
	HeroismYell = "%s %s usando %s!",
	PortalYell = "%s %s abriendo %s!",
	SoulwellYell = "%s %s poniendo %s!",
	SoulstoneYell = "%s %s usando %s sobre %s!",
	SummoningYell = "%s %s empieza %s!"
}
