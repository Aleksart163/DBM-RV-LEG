if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

--Прошляпанное очко Мурчаля ✔✔

----------------
-- Заклинания --
----------------
L= DBM:GetModLocalization("Spells")

L:SetGeneralLocalization({
	name = "Hechizos de banda"
})

L:SetOptionLocalization({
	YellOnHeroism = "Avisar, cuando alguien esta usando hechizo $spell:32182 o similar",
	YellOnResurrect = "Avisar, cuando y sobre quien han usado $spell:20484 o similar",
	YellOnPortal = "Avisar, cuando alguien esta abriendo $spell:224871 o similar",
	YellOnSoulwell = "Avisar, cuando alquien esta usando hechizo $spell:29893",
	YellOnSoulstone = "Avisar, sobre quien han usado $spell:20707",
	YellOnRitualofSummoning = "Avisar, cuando alguien esta usando hechizo $spell:698",
	YellOnSpiritCauldron = "Avisar, cuando alguien esta poniendo $spell:188036",
	YellOnLavish = "Avisar, cuando alguien esta poniendo $spell:201352 o similar"
})

L:SetMiscLocalization{
	HeroismYell = "[DBM RV] %s usando %s!",
	PortalYell = "[DBM RV] %s abriendo %s!",
	SoulwellYell = "[DBM RV] %s poniendo %s!",
	SoulstoneYell = "[DBM RV] %s usando %s sobre %s!",
	SummoningYell = "[DBM RV] %s empieza %s!"
}
