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
	MurchalProshlyap = "sta per arrivare!",
	MurchalProshlyap2 = "è arrivata! Mettiti al riparo!"
}
