if GetLocale() ~= "ukUK" then return end

--- New Proshlyapation Ochka Murchalya Proshlyapenko? ---

local L

--Прошляпанное очко Мурчаля [✔]

----------------
-- Заклинания --
----------------
L= DBM:GetModLocalization("Spells")

L:SetGeneralLocalization({
	name = "Рейдові заклинання"
})

L:SetOptionLocalization({
	YellOnNapull	 		= "Сообщать, когда кто-то применяет заклинание $spell:57934 или аналогичные ему",
	YellOnRaidCooldown 		= "Повідомляти, коли хтось застосовує заклинання $spell:97462 або аналогічні йому",
	YellOnResurrect 		= "Повідомляти, коли на когось застосували $spell:20484 або аналогічні йому",
	YellOnMassRes 			= "Повідомляти, коли хтось застосовує заклинання $spell:212036 або аналогічні йому",
	YellOnHeroism 			= "Повідомляти, коли хтось застосовує заклинання $spell:32182 або аналогічні йому",
	YellOnPortal 			= "Повідомляти, коли хтось відкриває $spell:224871 або аналогічні йому",
	YellOnSoulwell 			= "Повідомляти, коли хтось застосовує заклинання $spell:29893",
	YellOnSoulstone 		= "Повідомляти, коли на когось застосували $spell:20707",
	YellOnRitualofSummoning = "Повідомляти, коли хтось застосовує заклинання $spell:698",
	YellOnSummoning 		= "Повідомляти, коли ви застосовуєте заклинання $spell:7720",
	YellOnSpiritCauldron 	= "Повідомляти, коли хтось ставить $spell:188036",
	YellOnLavish 			= "Повідомляти, коли хтось ставить $spell:201352 або аналогічні йому",
	YellOnRepair 			= "Повідомляти, коли хтось ставить $spell:199109 або аналогічні йому",
	YellOnPylon 			= "Повідомляти, коли хтось ставить $spell:199115",
	YellOnBank 				= "Повідомляти, коли хтось ставить $spell:83958",
	YellOnToys 				= "Повідомляти, коли хтось ставить іграшки типу $spell:61031",
	AutoSpirit 				= "Автоматично залишати тіло"
})

L:SetMiscLocalization{
--	WhisperThanks 	= "%s Спасибо тебе за %s!",
	SpellNameYell 	= "Использую %s!",
	HeroismYell 	= "%s %s использует %s!",
	PortalYell 		= "%s %s открывает %s!",
	SoulwellYell 	= "%s %s ставит %s!",
	SoulstoneYell 	= "%s %s применяет %s на %s!",
	SummoningYell 	= "%s %s начинает %s!"
}
