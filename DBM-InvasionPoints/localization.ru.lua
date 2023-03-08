if GetLocale() ~= "ruRU" then return end

local L

-------------------
--Инквизитор Мето--
-------------------
L= DBM:GetModLocalization(2012)

L:SetMiscLocalization({
	Pull = "Тебя ждет только смерть!" --
})

------------
--Окулярус--
------------
L= DBM:GetModLocalization(2013)

L:SetMiscLocalization({
	Pull = "Я чувствую слабость в ваших душах!" --
})

-------------
--Сотанатор--
-------------
L= DBM:GetModLocalization(2014)

L:SetMiscLocalization({
	Pull = "Идите сюда, малыши! Пора умирать!" --
})

----------------------
--Госпожа Аллюрадель--
----------------------
L= DBM:GetModLocalization(2011)

L:SetMiscLocalization({
	Pull = "Новые игрушки? Как мило!" --
})

-------------------
--Госпожа Фолнуна--
-------------------
L= DBM:GetModLocalization(2010)

L:SetMiscLocalization({
	Pull = "Подходите ближе... малыши!" --
})

----------------------------------
--Властитель преисподней Веролом--
----------------------------------
L= DBM:GetModLocalization(2015)

L:SetMiscLocalization({
	Pull = "Все миры сгорят в огне Скверны!" --
})

-----------
-- Trash --
-----------
L= DBM:GetModLocalization("InvasionPointsTrash")

L:SetGeneralLocalization({
	name = "Трэш Точек вторжения"
})

L:SetMiscLocalization{
	MurchalOchkenProshlyapen = "Подойдите к жаровне!", --а лучше к очку Мурчаля
	MurchalOchkenProshlyapen2 = "Эта область выбрана целью для", --Эта область выбрана целью для [Уничтожения]
	MurchalOchkenProshlyapen3 = "Топор Сотанатора порождает серию" --Топор Сотанатора порождает серию [волн разрушения]!
}
