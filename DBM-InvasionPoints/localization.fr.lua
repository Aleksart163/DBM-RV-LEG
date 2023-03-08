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
	Pull = "Approchez, vulnérables créatures. Je vais vous tuer de mes propres mains !" --
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
	Pull = "Oui… Approchez, mes petits !" --
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
	MurchalOchkenProshlyapen2 = "Cette zone est la cible", --Cette zone est la cible d’[Oblitération] !
	MurchalOchkenProshlyapen3 = "La hache de Sotanathor envoie des" --La hache de Sotanathor envoie des [Sillages de destruction] !
}
