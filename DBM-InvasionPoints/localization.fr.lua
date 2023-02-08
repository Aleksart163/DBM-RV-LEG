if GetLocale() ~= "frFR" then return end

local L

-----------------------
-- Inquisitor Meto --
-----------------------
L= DBM:GetModLocalization(2012)

L:SetMiscLocalization({
	Pull = "La mort est votre seul destin !" --
})

-----------------------
-- Occularus --
-----------------------
L= DBM:GetModLocalization(2013)

L:SetMiscLocalization({
	Pull = "Je vois la faiblesse dans votre âme !" --
})

-----------------------
-- Sotanathor --
-----------------------
L= DBM:GetModLocalization(2014)

L:SetMiscLocalization({
	Pull = "Come, small ones. Die by my hand!"
})

-----------------------
-- Mistress Alluradel --
-----------------------
L= DBM:GetModLocalization(2011)

L:SetMiscLocalization({
	Pull = "De nouveaux jouets ? Je ne peux pas résister !" --
})

-----------------------
-- Matron Folnuna --
-----------------------
L= DBM:GetModLocalization(2010)

L:SetMiscLocalization({
	Pull = "Yes... come closer, little ones!"
})

-----------------------
-- Pit Lord Vilemus --
-----------------------
L= DBM:GetModLocalization(2015)

L:SetMiscLocalization({
	Pull = "Tous les mondes seront ravagés par le gangrefeu !" --
})

-----------
-- Trash --
-----------
L= DBM:GetModLocalization("InvasionPointsTrash")

L:SetGeneralLocalization({
	name = "Sites d’invasion Trash"
})

L:SetMiscLocalization{
	MurchalOchkenProshlyapen = "Approchez-vous d’un brasero !", --Approchez-vous d’un brasero ! [Gel instantané] va frapper !
	MurchalOchkenProshlyapen2 = "Cette zone est la cible" --Cette zone est la cible d’[Oblitération] !
}
