if GetLocale() ~= "ptBR" then return end

local L

-----------------------
-- Inquisitor Meto --
-----------------------
L= DBM:GetModLocalization(2012)

L:SetMiscLocalization({
	Pull = "Seu destino é a morte!" --
})

-----------------------
-- Occularus --
-----------------------
L= DBM:GetModLocalization(2013)

L:SetMiscLocalization({
	Pull = "Eu vejo a fraqueza em sua alma!" --
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
	Pull = "Novos brinquedinhos? Impossível resistir!" --
})

-----------------------
-- Matron Folnuna --
-----------------------
L= DBM:GetModLocalization(2010)

L:SetMiscLocalization({
	Pull = "Sim... mais perto, pequeninos!" --
})

-----------------------
-- Pit Lord Vilemus --
-----------------------
L= DBM:GetModLocalization(2015)

L:SetMiscLocalization({
	Pull = "Todos os mundos queimarão no fogo vil!" --
})

-----------
-- Trash --
-----------
L= DBM:GetModLocalization("InvasionPointsTrash")

L:SetGeneralLocalization({
	name = "Pontos de Invasão Besteira"
})

L:SetMiscLocalization{
	MurchalOchkenProshlyapen = "Pegue um Braseiro!", --Pegue um Braseiro! Lá vem o [Congelamento Instantâneo]!
	MurchalOchkenProshlyapen2 = "A área foi marcada para sofrer uma", --A área foi marcada para sofrer uma [Obliteração]!
	MurchalOchkenProshlyapen3 = "O machado de Sotanathor emite" --O machado de Sotanathor emite [Rastro de Destruição]!
}
