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
	MurchalProshlyap = "chegará logo, logo!",
	MurchalProshlyap2 = "chegou! Protejam-se!"
}
