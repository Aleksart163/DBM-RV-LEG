if GetLocale() ~= "ukUK" then return end

--- New Proshlyapation Ochka Murchalya Proshlyapenko? ---

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
	InfoFrameBehavior 	= "Встановлення інформації, яку Інформаційне вікно показує під час бою",
	TimeRelease 		= "Показувати гравців, на яких вплинула Витримка часу",
	TimeBomb 			= "Показувати гравців, які постраждали від Часової Бомби"
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
	First 			= "Перший",
	Second 			= "Другий",
	Third 			= "Третій",
	Adds1 			= "Прислужники! Швидко до мене!", --нужна проверка
	Adds2 			= "Покажіть цим нікчемам, як битися!" --нужна проверка
})

--------
--Крос--
--------
L= DBM:GetModLocalization(1713)

L:SetWarningLocalization({
	warnSlamSoon		= "Руйнування мосту через %ds"
})

L:SetOptionLocalization({
	warnSlamSoon		= "Попереджати заздалегідь про $spell:205862"
})

L:SetMiscLocalization({
	MoveLeft 			= "Рухайтеся вліво",
	MoveRight 			= "Рухайтеся вправо"
})

-----------------------------
--Верховный ботаник Тел'арн--
-----------------------------
L= DBM:GetModLocalization(1761)

L:SetWarningLocalization({
	warnStarLow				= "У Сфери плазми мало хп"
})

L:SetOptionLocalization({
	warnStarLow				= "Спец-попередження коли у Сфери плазми мало здоров'я (на ~25%)"
})

------------------------
--Звездный авгур Этрей--
------------------------
L= DBM:GetModLocalization(1732)

L:SetOptionLocalization({
	ShowProshlyapationOfMurchal = "Спец-попередження про $spell:205408 (потрібні права лідера рейду)",
	ConjunctionYellFilter 		= "Під час $spell:205408, відключити всі інші повідомлення і просто спамити свій знак, поки не закінчиться з'єднання."
})

L:SetMiscLocalization({
	ProshlyapMurchal = "%s %s через 5 сек!"
})

----------------------------
--Великий магистр Элисанда--
----------------------------
L= DBM:GetModLocalization(1743)

L:SetTimerLocalization({
	timerFastTimeBubble 	= "Уповільнювальне поле (%d)",
	timerSlowTimeBubble 	= "Поле, що прискорює (%d)"
})

L:SetOptionLocalization({
	timerFastTimeBubble 	= "Показувати час дії для $spell:209166",
	timerSlowTimeBubble 	= "Показувати час дії для $spell:209165"
})

L:SetMiscLocalization({
	noCLEU4EchoRings		= "Хвилі часу зметуть вас!", --нужна проверка
	noCLEU4EchoOrbs			= "Час нестабільний - зараз ви самі в цьому переконаєтеся." --нужна проверка
})

-----------
--Гул'дан--
-----------
L= DBM:GetModLocalization(1737)

L:SetMiscLocalization({
	mythicPhase3		= "Повернемо душу Іллідана в тіло... Владика Легіону не повинен його отримати." --нужна проверка
})

-------------
--Треш-мобы--
-------------
L = DBM:GetModLocalization("NightholdTrash")

L:SetGeneralLocalization({
	name =	"Трэш Цитадели Ночи"
})

L:SetMiscLocalization({
	prePullRP1 		= "Я передбачала ваш прихід, нитки долі, що привели вас сюди, і ваші жалюгідні спроби зупинити Легіон.", --нужна проверка
	prePullRP2 		= "О, а ось і наші герої. Такі самовпевнені. Саме це вас і погубить!" --нужна проверка
})
