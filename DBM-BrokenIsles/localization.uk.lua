if GetLocale() ~= "ukUK" then return end

--- New Proshlyapation Ochka Murchalya Proshlyapenko? ---

local L

--Прошляпанное очко Мурчаля ✔

-----------
--Ана-Муз--
-----------
L= DBM:GetModLocalization(1790)

-----------
--Апокрон--
-----------------------
L= DBM:GetModLocalization(1956)

-----------
--Бруталл--
-----------
L= DBM:GetModLocalization(1883)

-----------
--Каламир--
-----------
L= DBM:GetModLocalization(1774)

------------------------
--Драгон Зиморожденный--
------------------------
L= DBM:GetModLocalization(1789)

-----------
--Обломок--
-----------
L= DBM:GetModLocalization(1795)

-------------
--Хумонгрис--
-------------
L= DBM:GetModLocalization(1770)

------------
--Левантия--
------------
L= DBM:GetModLocalization(1769)

-------------
--Малификус--
-------------
L= DBM:GetModLocalization(1884)

--------------------
--На'зак Одержимый--
--------------------
L= DBM:GetModLocalization(1783)

-----------
--Нитхегг--
-----------
L= DBM:GetModLocalization(1749)

-----------
--Шар'тос--
-----------
L= DBM:GetModLocalization(1763)

----------
--Си'ваш--
----------
L= DBM:GetModLocalization(1885)

----------------------
--Охотники за душами--
----------------------
L= DBM:GetModLocalization(1756)

------------------
--Иссохший Дж'им--
------------------
L= DBM:GetModLocalization(1796)

------------------
--Капитаны башен--
------------------
L = DBM:GetModLocalization("Captainstower")

L:SetGeneralLocalization({
	name = "Штурм Сторожової вежі"
})

------------------
--Редкие враги 1--
------------------
L = DBM:GetModLocalization("RareEnemies")

L:SetGeneralLocalization({
	name = "Дуже небезпечні вороги"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetMiscLocalization({
	PullSkulvrax = "Я... ще жива..."--нужна проверка
})

------------------
--Редкие враги 2--
------------------
L = DBM:GetModLocalization("RareEnemies2")

L:SetGeneralLocalization({
	name = "Дуже небезпечні вороги 2"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})
