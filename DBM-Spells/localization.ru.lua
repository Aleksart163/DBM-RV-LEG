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
	YellOnLavish = "Сообщать, когда кто-то ставит $spell:201352 или аналогичные ему"
})

L:SetMiscLocalization{
	HeroismYell = "[DBM RV] %s использует %s!",
	PortalYell = "[DBM RV] %s открывает %s!",
	SoulwellYell = "[DBM RV] %s ставит %s!",
	SoulstoneYell = "[DBM RV] %s применяет %s на %s!",
	SummoningYell = "[DBM RV] %s начинает %s!"
}
