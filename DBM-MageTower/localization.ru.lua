if GetLocale() ~= "ruRU" then return end
local L

--Прошляпанное очко Мурчаля ✔

-----------------------
-- Башня магов: Танк -- (Дк, Монах, Медведь, Ппал, Пвар, Дх)
-----------------------
L= DBM:GetModLocalization("Kruul")

L:SetGeneralLocalization({
	name = "Возвращение верховного лорда"
})

L:SetWarningLocalization({
	Phase2 = "Скоро фаза 2",
})

L:SetOptionLocalization({
	Phase2 = "Предупреждать заранее о фазе 2 (на ~10%)",
})

----------------------
-- Башня магов: Хил -- (Хпал, Хприст, Монах, Дерево)
----------------------
L= DBM:GetModLocalization("ErdrisThorn")

L:SetGeneralLocalization({
	name = "Последнее восстание"
})

---------------------
-- Башня магов: ДД -- (БистМастер, Дестрик, ДЦ, Монах)
---------------------
L= DBM:GetModLocalization("FelTotem")

L:SetGeneralLocalization({
	name = "Падение Тотема Скверны"
})

---------------------
-- Башня магов: ДД -- (Элем, Ферал, Фаер, Фури, Головорез, Анхоли)
----------------------
L= DBM:GetModLocalization("ImpossibleFoe")

L:SetGeneralLocalization({
	name = "Невероятный противник"
})

L:SetMiscLocalization({
	impServants = "Kill the Imp Servants before they energize Agatha!"
})

---------------------
-- Башня магов: ДД -- (Аркан, Ликвидация, Демон, Энх, Рпал)
---------------------
L= DBM:GetModLocalization("Queen")

L:SetGeneralLocalization({
	name = "Ярость королевы-богини"
})

---------------------
-- Башня магов: ДД -- (Афлик, Сова, Фрост, Стрельба хант, ШП)
---------------------
L= DBM:GetModLocalization("Twins")

L:SetGeneralLocalization({
	name = "Разделение близнецов"
})

---------------------
-- Башня магов: ДД -- (Армс, ФростДк, Дх, Скрытность, Сурв)
---------------------
L= DBM:GetModLocalization("Xylem")

L:SetGeneralLocalization({
	name = "Око Бури"
})

--------------------------
-- Башня магов: Таймеры --
--------------------------
L= DBM:GetModLocalization("Timers")

L:SetGeneralLocalization({
	name = "Таймеры начала боя"
})

L:SetOptionLocalization({
	timerRoleplay = "Отсчет времени до начала боя"
})

L:SetTimerLocalization({
	timerRoleplay = "Начало боя"
})

L:SetMiscLocalization({ --Отсчеты при начале боя
	Kruul = "Дерзкие глупцы! Меня питают души тысяч покоренных миров!",
	Twins = "Я не позволю тебе обрушить эту силу на Азерот, Рейст. Остановись, или мне придется убить тебя!",
	ErdrisThorn1 = "Нет уж! Пора положить конец атакам на мой город!"
})
