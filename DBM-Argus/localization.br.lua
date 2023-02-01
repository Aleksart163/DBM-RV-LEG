if GetLocale() ~= "ptBR" then return end

local L

----------------
--rare enemies--
----------------
L = DBM:GetModLocalization("RareEnemiesArgus")

L:SetGeneralLocalization({
	name = "Inimigos muito perigosos na Argus"
})

L:SetMiscLocalization{
	MurchalOchkenProshlyapen = "chegará logo, logo!",
	MurchalOchkenProshlyapen2 = "chegou! Protejam-se!"
}
