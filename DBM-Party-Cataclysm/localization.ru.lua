if GetLocale() ~= "ruRU" then return end

local L

--------------
--Грим Батол--
-------------------
--Генерал Умбрисс--
-------------------
L= DBM:GetModLocalization(131)

-------------------------
--Начальник кузни Тронг--
-------------------------
L= DBM:GetModLocalization(132)

----------------------
--Драгх Горячий Мрак--
----------------------
L= DBM:GetModLocalization(133)

----------------------------
--Эрудакс, властитель недр--
----------------------------
L= DBM:GetModLocalization(134)

----------------------------
--Затерянный город Тол'вир--
----------------------------

-----------------
--Генерал Хусам--
-----------------
L= DBM:GetModLocalization(117)

------------
--Зубохлоп--
------------
L= DBM:GetModLocalization(118)

L:SetOptionLocalization{
	RangeFrame	= "Окно проверки дистанции (5м)"
}

-------
--Ауг--
-------
L = DBM:GetModLocalization("Augh")

L:SetGeneralLocalization({
	name = "Ауг"
})

--------------------------
--Верховный пророк Барим--
--------------------------
L= DBM:GetModLocalization(119)

----------
--Сиамат--
----------
L= DBM:GetModLocalization(122)

L:SetWarningLocalization{
	specWarnPhase2Soon	= "2-ая фаза через 5 сек"
}

L:SetOptionLocalization{
	specWarnPhase2Soon	= "Показывать особое предупреждение перед началом 2-ой фазы (5 сек)"
}

------------------
--Каменные Недра--
------------------

----------
--Корбор--
----------
L= DBM:GetModLocalization(110)

L:SetWarningLocalization({
	WarnEmerge		= "Появление",
	WarnSubmerge	= "Погружение"
})

L:SetTimerLocalization({
	TimerEmerge		= "Появление",
	TimerSubmerge	= "Погружение"
})

L:SetOptionLocalization({
	WarnEmerge		= "Показывать предупреждения о появлении",
	WarnSubmerge	= "Показывать предупреждения о погружении",
	TimerEmerge		= "Показывать таймер до появления",
	TimerSubmerge	= "Показывать таймер до погружения",
	RangeFrame		= "Окно проверки дистанции (5м)"
})

-------------
--Камнешкур--
-------------
L= DBM:GetModLocalization(111)

L:SetWarningLocalization({
	WarnAirphase				= "Воздушная фаза",
	WarnGroundphase				= "Наземная фаза",
	specWarnCrystalStorm		= "Кристальная буря - в укрытие!"
})

L:SetTimerLocalization({
	TimerAirphase				= "След. воздушная фаза",
	TimerGroundphase			= "След. наземная фаза"
})

L:SetOptionLocalization({
	WarnAirphase				= "Показывать предупреждения когда Камнешкур взлетает",
	WarnGroundphase				= "Показывать предупреждения когда Камнешкур приземляется",
	TimerAirphase				= "Показывать таймер следующей воздушной фаза",
	TimerGroundphase			= "Показывать таймер следующей наземной фаза",
	specWarnCrystalStorm		= "Показывать особое предупреждение для $spell:92265"
})

---------
--Озрук--
---------
L= DBM:GetModLocalization(112)

------------------------
--Верховная жрица Азил--
------------------------
L= DBM:GetModLocalization(113)

------------------
--Вершина Смерча--
------------------
------------------------
--Великий визирь Эртан--
------------------------
L= DBM:GetModLocalization(114)

L:SetMiscLocalization{
	Retract		= "%s притягивает к себе охранный смерч!"
}

-------------
--Альтаирий--
-------------
L= DBM:GetModLocalization(115)

L:SetOptionLocalization({
	BreathIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(88308)
})

------------------------
--Асаад, калиф зефиров--
------------------------
L= DBM:GetModLocalization(116)

L:SetMiscLocalization({
	YellProshlyapMurchal = "Ал'акир, твой слуга взывает о помощи!"
})

-------------
--Треш-мобы--
-------------
L = DBM:GetModLocalization("TVPTrash")

L:SetGeneralLocalization({
	name = "Трэш ВС"
})

-----------------
--Трон Приливов--
-----------------

----------------
--Леди Наз'жар--
----------------
L= DBM:GetModLocalization(101)

---------------------------------------
--Командир Улток, разлагающийся принц--
---------------------------------------
L= DBM:GetModLocalization(102)

-------------------------------------------------------
--Эрунак Говорящий с Камнем|Подчиняющий разум Гур'ша--
-------------------------------------------------------
L= DBM:GetModLocalization(103)

----------
--Озумат--
----------
L= DBM:GetModLocalization(104)

----------------
--Конец Времен--
----------------

-------------
--Эхо Бейна--
-------------
L= DBM:GetModLocalization(340)

--------------
--Эхо Джайны--
--------------
L= DBM:GetModLocalization(285)

L:SetTimerLocalization{
	TimerFlarecoreDetonate	= "Взрыв пламенных недр"
}

L:SetOptionLocalization{
	TimerFlarecoreDetonate	= "Отсчет времени до взрыва $spell:101927"
}

----------------
--Эхо Сильваны--
----------------
L= DBM:GetModLocalization(323)

---------------
--Эхо Тиранды--
---------------
L= DBM:GetModLocalization(283)

------------
--Дорнозму--
------------
L= DBM:GetModLocalization(289)

L:SetMiscLocalization{
	Kill		= "Что... вы наделали... Аман'тул... Я...видел..."
}

-----------
-- Trash --
-----------
L = DBM:GetModLocalization("ETTrash")

L:SetGeneralLocalization{
	name = "Трэш Конца Времён"
}

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetMiscLocalization({
	ProshlyapM = "Однажды я назвал это место \"Концом Времен\". Я еще не видел тогда... я не знал. Что вы надеетесь сделать? Остановить меня? Изменить судьбу, которую я ткал столь неустанно?" --
})
