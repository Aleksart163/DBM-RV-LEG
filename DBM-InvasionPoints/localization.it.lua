if GetLocale() ~= "itIT" then return end

local L

-----------------------
-- Inquisitor Meto --
-----------------------
L= DBM:GetModLocalization(2012)

L:SetMiscLocalization({
	Pull = "Il tuo destino è la morte!" --
})

-----------------------
-- Occularus --
-----------------------
L= DBM:GetModLocalization(2013)

L:SetMiscLocalization({
	Pull = "Vedo debolezza nella tua anima!" --
})

-----------------------
-- Sotanathor --
-----------------------
L= DBM:GetModLocalization(2014)

L:SetMiscLocalization({
	Pull = "Venite, piccoletti. Morite per mano mia!" --
})

-----------------------
-- Mistress Alluradel --
-----------------------
L= DBM:GetModLocalization(2011)

L:SetMiscLocalization({
	Pull = "Nuovi giocattoli? Irresistibili!" --
})

-----------------------
-- Matron Folnuna --
-----------------------
L= DBM:GetModLocalization(2010)

L:SetMiscLocalization({
	Pull = "Sì... avvicinatevi, piccoletti! Ahahah!" --
})

-----------------------
-- Pit Lord Vilemus --
-----------------------
L= DBM:GetModLocalization(2015)

L:SetMiscLocalization({
	Pull = "Tutti i mondi bruceranno nel vilfuoco!" --
})

-----------
-- Trash --
-----------
L= DBM:GetModLocalization("InvasionPointsTrash")

L:SetGeneralLocalization({
	name = "Punti di Invasione Spazzatura"
})

L:SetMiscLocalization{
	MurchalOchkenProshlyapen = "Raggiungi un braciere!", --Raggiungi un braciere! Sta per apparire una [Prigione di Ghiaccio]!
	MurchalOchkenProshlyapen2 = "L'area è stata scelta come bersaglio di", --L'area è stata scelta come bersaglio di [Annientamento]!
	MurchalOchkenProshlyapen3 = "L'ascia di Sotanathor emette delle" --L'ascia di Sotanathor emette delle [Scie di Distruzione]!
}
