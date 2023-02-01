if GetLocale() ~= "deDE" then return end

local L

--Прошляпанное очко Мурчаля ✔

----------------
--rare enemies--
----------------
L = DBM:GetModLocalization("RareEnemiesArgus")

L:SetGeneralLocalization({
	name = "Sehr gefährliche Feinde auf Argus"
})

L:SetMiscLocalization{
	MurchalOchkenProshlyapen = "wird bald eintreffen!",
	MurchalOchkenProshlyapen2 = "ist eingetroffen! Geht in Deckung!"
}
