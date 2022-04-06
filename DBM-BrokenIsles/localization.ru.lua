if GetLocale() ~= "ruRU" then return end

local L

-----------$spell:137162
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
	name ="Штурм Сторожевой башни"
})

----------------
--Редкие враги--
----------------
L = DBM:GetModLocalization("RareEnemies")

L:SetGeneralLocalization({
	name ="Редкие враги"
})

L:SetTimerLocalization({
	timerRoleplay = GUILD_INTEREST_RP
})

L:SetOptionLocalization({
	timerRoleplay = "Отсчет времени до начала боя с Скал'вракс"
})

L:SetMiscLocalization({
	PullSkulvrax = "Я... еще жива..."
})
