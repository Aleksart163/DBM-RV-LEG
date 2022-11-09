if GetLocale() ~= "ruRU" then return end

local L

--Прошляпанное очко Мурчаля ✔✔

----------------
-- Заклинания --
----------------
L= DBM:GetModLocalization("Spells")

L:SetGeneralLocalization({
	name = "Рейдовые заклинания"
})

L:SetOptionLocalization({
	YellOnHeroism = "Сообщать, когда кто-то применяет заклинание $spell:32182 или аналогичные ему",
	YellOnResurrect = "Сообщать, когда на кого-то применили $spell:20484 или аналогичные ему",
	YellOnPortal = "Сообщать, когда кто-то открывает $spell:224871 или аналогичные ему",
	YellOnSoulwell = "Сообщать, когда кто-то применяет заклинание $spell:29893",
	YellOnSoulstone = "Сообщать, когда на кого-то применили $spell:20707",
	YellOnRitualofSummoning = "Сообщать, когда кто-то применяет заклинание $spell:698",
	YellOnSpiritCauldron = "Сообщать, когда кто-то ставит $spell:188036",
	YellOnLavish = "Сообщать, когда кто-то ставит $spell:201352 или аналогичные ему",
	YellOnRepair = "Сообщать, когда кто-то ставит $spell:199109 или аналогичные ему",
	YellOnPylon = "Сообщать, когда кто-то ставит $spell:199115"
})

L:SetMiscLocalization{
	HeroismYell = "%s %s использует %s!",
	PortalYell = "%s %s открывает %s!",
	SoulwellYell = "%s %s ставит %s!",
	SoulstoneYell = "%s %s применяет %s на %s!",
	SummoningYell = "%s %s начинает %s!"
}
