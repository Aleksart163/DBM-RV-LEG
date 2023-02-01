if GetLocale() ~= "deDE" then return end

local L

--Прошляпанное очко Мурчаля ✔✔

-----------------
-- Raid-zauber --
-----------------
L= DBM:GetModLocalization("Spells")

L:SetGeneralLocalization({
	name = "Raid-zauber"
})

L:SetOptionLocalization({
	YellOnHeroism = "Melden Sie, wenn jemand verwendet $spell:32182 oder ein ähnliches",
	YellOnResurrect = "Melden Sie, wenn jemand verwendet $spell:20484 oder ein ähnliches",
	YellOnPortal = "Benachrichtigen Sie mich, jemand den öffnet $spell:224871 oder ein ähnliches",
	YellOnSoulwell = "Bericht, wenn jemand die setzt $spell:29893",
	YellOnSoulstone = "Melden Sie, wenn jemand verwendet $spell:20707",
	YellOnRitualofSummoning = "Melden Sie, wenn jemand verwendet $spell:698",
	YellOnSpiritCauldron = "Melden Sie, wenn jemand verwendet $spell:188036",
	YellOnLavish = "Melden Sie, wenn jemand verwendet $spell:201352 oder ein ähnliches",
	YellOnRepair = "Melden Sie, wenn jemand verwendet $spell:199109 oder ein ähnliches",
	YellOnPylon = "Melden Sie, wenn jemand verwendet $spell:199115",
	YellOnBank = "Melden Sie, wenn jemand verwendet $spell:83958"
})

L:SetMiscLocalization{
	HeroismYell = "%s %s nutzt %s!",
	PortalYell = "%s %s öffnet %s!",
	SoulwellYell = "%s %s richtet ein %s!",
	SoulstoneYell = "%s %s wendet %s auf %s!",
	SummoningYell = "%s %s nutzt %s!"
}
