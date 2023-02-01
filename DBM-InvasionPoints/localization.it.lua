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
	Pull = "Come, small ones. Die by my hand!"
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
	Pull = "Yes... come closer, little ones!"
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
	MurchalOchkenProshlyapen = "Raggiungi un braciere!" --Raggiungi un braciere! Sta per apparire una [Prigione di Ghiaccio]!
}
