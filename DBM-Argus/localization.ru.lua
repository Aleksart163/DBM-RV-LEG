if GetLocale() ~= "ruRU" then return end

local L

--Прошляпанное очко Мурчаля ✔

----------------
--rare enemies--
----------------
L = DBM:GetModLocalization("RareEnemiesArgus")

L:SetGeneralLocalization({
	name = "Очень опасные враги Аргуса"
})

L:SetMiscLocalization{
	MurchalProshlyap = "скоро будет здесь!",
	MurchalProshlyap2 = "прибыл! Скорее в укрытие!"
}
