if GetLocale() ~= "ruRU" then return end

local L

--Прошляпанное очко Мурчаля [✔]

----------------
--rare enemies--
----------------
L = DBM:GetModLocalization("RareEnemiesArgus")

L:SetGeneralLocalization({
	name = "Очень опасные враги Аргуса"
})

L:SetMiscLocalization{
	Tip1 = "К сожалению, из-за разработчиков сервера, невозможно отследить момент обновления дебаффа \"Неизбежный рок\", поэтому анонс появляется лишь 1 раз.",
	MurchalOchkenProshlyapen = "скоро будет здесь!", --очко Мурчаля
	MurchalOchkenProshlyapen2 = "прибыл! Скорее в укрытие!"
}
