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

L:SetWarningLocalization({
--	Rebirth = "%s применяет заклинание %s на %s"
})

L:SetOptionLocalization({
--	Rebirth = "Объявлять (с целью) источник использования заклинания $spell:20484",
	YellOnMassRes = "Сообщать, когда кто-то применяет заклинание $spell:212036 или аналогичные ему",
	YellOnManaRegen = "Сообщать, когда кто-то применяет заклинание $spell:29166 или аналогичные ему",
	YellOnHeroism = "Сообщать, когда кто-то применяет заклинание $spell:32182 или аналогичные ему",
	YellOnResurrect = "Сообщать, когда на кого-то применили $spell:20484 или аналогичные ему",
	YellOnPortal = "Сообщать, когда кто-то открывает $spell:224871 или аналогичные ему",
	YellOnSoulwell = "Сообщать, когда кто-то применяет заклинание $spell:29893",
	YellOnSoulstone = "Сообщать, когда на кого-то применили $spell:20707",
	YellOnRitualofSummoning = "Сообщать, когда кто-то применяет заклинание $spell:698",
	YellOnSpiritCauldron = "Сообщать, когда кто-то ставит $spell:188036",
	YellOnLavish = "Сообщать, когда кто-то ставит $spell:201352 или аналогичные ему",
	YellOnRepair = "Сообщать, когда кто-то ставит $spell:199109 или аналогичные ему",
	YellOnPylon = "Сообщать, когда кто-то ставит $spell:199115",
	YellOnBank = "Сообщать, когда кто-то ставит $spell:83958",
	YellOnToys = "Сообщать, когда кто-то ставит игрушки типо $spell:61031"
})

L:SetMiscLocalization{
	InnervateYell = "%s на %s!",
	SymbolHopeYell = "Использую %s!",
	HeroismYell = "%s %s использует %s!",
	PortalYell = "%s %s открывает %s!",
	SoulwellYell = "%s %s ставит %s!",
	SoulstoneYell = "%s %s применяет %s на %s!",
	SummoningYell = "%s %s начинает %s!"
}
