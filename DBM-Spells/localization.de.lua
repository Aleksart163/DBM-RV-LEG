if GetLocale() ~= "deDE" then return end

local L

--Прошляпанное очко Мурчаля [✔]

-----------------
-- Raid-zauber --
-----------------
L= DBM:GetModLocalization("Spells")

L:SetGeneralLocalization({
	name = "Raid-zauber"
})

L:SetOptionLocalization({
	YellOnNapull	 		= "Melden Sie, wenn jemand verwendet $spell:57934 oder ein ähnliches",
	YellOnRaidCooldown 		= "Melden Sie, wenn jemand verwendet $spell:97462 oder ein ähnliches",
	YellOnResurrect 		= "Melden Sie, wenn jemand verwendet $spell:20484 oder ein ähnliches",
	YellOnMassRes 			= "Melden Sie, wenn jemand verwendet $spell:212036 oder ein ähnliches",
	YellOnHeroism 			= "Melden Sie, wenn jemand verwendet $spell:32182 oder ein ähnliches",
	YellOnPortal 			= "Benachrichtigen Sie mich, jemand den öffnet $spell:224871 oder ein ähnliches",
	YellOnSoulwell 			= "Bericht, wenn jemand die setzt $spell:29893",
	YellOnSoulstone 		= "Melden Sie, wenn jemand verwendet $spell:20707",
	YellOnRitualofSummoning = "Melden Sie, wenn jemand verwendet $spell:698",
	YellOnSummoning 		= "Melden Sie, wenn Sie einen Zauber wirken $spell:7720",
	YellOnSpiritCauldron 	= "Melden Sie, wenn jemand verwendet $spell:188036",
	YellOnLavish 			= "Melden Sie, wenn jemand verwendet $spell:201352 oder ein ähnliches",
	YellOnRepair 			= "Melden Sie, wenn jemand verwendet $spell:199109 oder ein ähnliches",
	YellOnPylon 			= "Melden Sie, wenn jemand verwendet $spell:199115",
	YellOnBank 				= "Melden Sie, wenn jemand verwendet $spell:83958",
	YellOnToys 				= "Melden Sie, wenn jemand Spielzeug setzt $spell:61031",
	AutoSpirit 				= "Automatisch Geist freilassen"
})

L:SetMiscLocalization{
--	WhisperThanks 	= "%s Vielen Dank für %s!",
	SpellNameYell 	= "Anwendung %s!",
	HeroismYell	  	= "%s %s nutzt %s!",
	PortalYell 		= "%s %s öffnet %s!",
	SoulwellYell 	= "%s %s richtet ein %s!",
	SoulstoneYell 	= "%s %s wendet %s auf %s!",
	SummoningYell 	= "%s %s nutzt %s!"
}
