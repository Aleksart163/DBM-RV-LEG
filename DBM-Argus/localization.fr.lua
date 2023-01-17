if GetLocale() ~= "frFR" then return end

local L

--Прошляпанное очко Мурчаля ✔

----------------
--rare enemies--
----------------
L = DBM:GetModLocalization("RareEnemiesArgus")

L:SetGeneralLocalization({
	name = "Ennemis très dangereux sur Argus"
})

L:SetMiscLocalization{
	MurchalProshlyap = "sera bientôt là !",
	MurchalProshlyap2 = "est arrivé ! À couvert !"
}
