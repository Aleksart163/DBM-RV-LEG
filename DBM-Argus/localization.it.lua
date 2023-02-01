if GetLocale() ~= "itIT" then return end

local L

--Прошляпанное очко Мурчаля ✔

----------------
--rare enemies--
----------------
L = DBM:GetModLocalization("RareEnemiesArgus")

L:SetGeneralLocalization({
	name = "Nemici molto pericolosi su Argus"
})

L:SetMiscLocalization{
	MurchalOchkenProshlyapen = "sta per arrivare!",
	MurchalOchkenProshlyapen2 = "è arrivata! Mettiti al riparo!"
}
