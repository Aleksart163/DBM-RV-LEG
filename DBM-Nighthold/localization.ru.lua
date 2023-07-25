if GetLocale() ~= "ruRU" then return end

local L

--Прошляпанное очко Мурчаля Прошляпенко [✔]

-------------
--Скорпирон--
-------------
L= DBM:GetModLocalization(1706)

----------------------------
--Хрономатическая аномалия--
----------------------------
L= DBM:GetModLocalization(1725)

L:SetOptionLocalization({
	InfoFrameBehavior	= "Установка информации, которую Информационное окно показывает во время боя",
	TimeRelease			= "Показывать игроков, на которых повлияло Выдержка времени",
	TimeBomb			= "Показывать игроков, пострадавших от Часовой Бомбы"
})

-------------
--Триллиакс--
-------------
L= DBM:GetModLocalization(1731)

------------------------------------
--Заклинательница клинков Алуриэль--
------------------------------------
L= DBM:GetModLocalization(1751)

-------------
--Тихондрий--
-------------
L= DBM:GetModLocalization(1762)

L:SetMiscLocalization({
	First				= "Первый",
	Second				= "Второй",
	Third				= "Третий",
	Adds1				= "Прислужники! Живо ко мне!",
	Adds2				= "Покажите этим ничтожествам, как сражаться!"
})

--------
--Крос--
--------
L= DBM:GetModLocalization(1713)

L:SetWarningLocalization({
	warnSlamSoon		= "Разрушение моста через %ds"
})

L:SetOptionLocalization({
	warnSlamSoon		= "Предупреждать заранее о $spell:205862"
})

L:SetMiscLocalization({
	MoveLeft			= "Двигайтесь влево",
	MoveRight			= "Двигайтесь вправо"
})

-----------------------------
--Верховный ботаник Тел'арн--
-----------------------------
L= DBM:GetModLocalization(1761)

L:SetWarningLocalization({
	warnStarLow				= "У Сферы плазмы мало хп"
})

L:SetOptionLocalization({
	warnStarLow				= "Спец-предупреждение когда у Сферы плазмы мало здоровья (на ~25%)"
})

------------------------
--Звездный авгур Этрей--
------------------------
L= DBM:GetModLocalization(1732)

L:SetOptionLocalization({
	ConjunctionYellFilter	= "Во время $spell:205408, отключить все другие сообщения и просто спамить свой знак, пока не закончится соединение."
})

----------------------------
--Великий магистр Элисанда--
----------------------------
L= DBM:GetModLocalization(1743)

L:SetTimerLocalization({
	timerFastTimeBubble		= "Замедляющее поле (%d)",
	timerSlowTimeBubble		= "Ускоряющее поле (%d)"
})

L:SetOptionLocalization({
	timerFastTimeBubble		= "Показывать время действия для $spell:209166",
	timerSlowTimeBubble		= "Показывать время действия для $spell:209165"
})

L:SetMiscLocalization({
	noCLEU4EchoRings		= "Волны времени сметут вас!",
	noCLEU4EchoOrbs			= "Время нестабильно – сейчас вы сами в этом убедитесь."
})

-----------
--Гул'дан--
-----------
L= DBM:GetModLocalization(1737)

L:SetMiscLocalization({
	mythicPhase3		= "Вернем душу Иллидана в тело... Владыка Легиона не должен его заполучить."
})

-------------
--Треш-мобы--
-------------
L = DBM:GetModLocalization("NightholdTrash")

L:SetGeneralLocalization({
	name =	"Трэш Цитадели Ночи"
})

L:SetMiscLocalization({
	prePullRP1				= "Я предвидела ваш приход, нити судьбы, что привели вас сюда, и ваши жалкие попытки остановить Легион.", --Элисанда
	prePullRP2				= "О, а вот и наши герои. Такие самоуверенные. Именно это вас и погубит!" --Гулдан
})
