if GetLocale() ~= "ukUK" then return end

--- New Proshlyapation Ochka Murchalya Proshlyapenko? ---

local L

--------------------------------
--Разрушитель миров Кин'гарота--
--------------------------------
L= DBM:GetModLocalization(1992)

--------------------
--Гончие Саргераса--
--------------------
L= DBM:GetModLocalization(1987)

L:SetOptionLocalization({
	SequenceTimers = "Зменшити кд у таймерах на героїчній/міфічній складності за рахунок незначної точності таймерів (на 1-2 секунди раніше)"
})

--------------------------
--Военный совет Анторуса--
--------------------------
L= DBM:GetModLocalization(1997)

L:SetMiscLocalization({
	FelshieldYell = "Я ЖМУ %s!"
})

----------------------------------
--Хранительница порталов Азабель--
----------------------------------
L= DBM:GetModLocalization(1985)

L:SetOptionLocalization({
	ShowAllPlatforms = "Показати всі анонси незалежно від місця розташування платформи гравця"
})

------------------------------
--Эонар, Хранительница жизни--
------------------------------
L= DBM:GetModLocalization(2025)

L:SetTimerLocalization({
	timerObffuscator 	= "~ Маскувальник (%s)",
	timerDestructor 	= "~ Руйнівник (%s)",
	timerPurifier 		= "~ Очищувач (%s)",
	timerBats 			= "~ Птахи (%s)"
})

L:SetOptionLocalization({
	ShowProshlyapationOfMurchal = "Спец-предупреждение об $spell:249121 (требуются права лидера рейда)",
	timerObfuscator		= DBM_CORE_AUTO_TIMER_OPTIONS["cdcount"]:format("ej16501"),
	timerDestructor 	= DBM_CORE_AUTO_TIMER_OPTIONS["cdcount"]:format("ej16502"),
	timerPurifier 		= DBM_CORE_AUTO_TIMER_OPTIONS["cdcount"]:format("ej16500"),
	timerBats	 		= DBM_CORE_AUTO_TIMER_OPTIONS["cdcount"]:format("ej17039")
})

L:SetMiscLocalization({
	ProshlyapMurchal 	= "%s %s (%s група) через 10 сек!",
	Obfuscators 		= "Маскувальник",
	Destructors 		= "Руйнівник",
	Purifiers 			= "Очищувач",
	Bats 				= "Птахи",
	EonarHealth 		= "Здоров'я Еонар",
	EonarPower 			= "Сила Еонар",
	NextLoc 			= "~"
})

--------------------
--Ловец душ Имонар--
--------------------
L= DBM:GetModLocalization(2009)

L:SetWarningLocalization({
	PulseGrenade = "Імпульсна граната - стій подалі від інших"
})

L:SetOptionLocalization({
	PulseGrenade = "Спец-попередження \"стій подалі від інших\" коли ви ціль $spell:250006"
})

L:SetMiscLocalization({
	DispelMe = "Диспел мені!"
})

-------------
--Кин'гарот--
-------------
L= DBM:GetModLocalization(2004)

L:SetOptionLocalization({
	InfoFrame 	= "Показати інформаційне табло для огляду бою",
	UseAddTime 	= "Завжди показувати таймери, коли бос виходить із фази ініціалізації, замість того, щоб приховувати їх. (Якщо таймери відключені, вони відновляться, коли бос знову стане активним, але можуть залишити мало попереджень, якщо до закінчення дії таймерів залишилося 1-2 секунди)."
})

--------------
--Вариматрас--
--------------
L= DBM:GetModLocalization(1983)

L:SetOptionLocalization({
	ShowProshlyapSoulburnin = "Спец-попередження про $spell:244093 (потрібні права лідера рейду)"
})

L:SetMiscLocalization({
	ProshlyapSoulburnin 	= "%s %s через 5 сек!",

})

----------------
--Ковен шиварр--
----------------
L= DBM:GetModLocalization(1986)

L:SetWarningLocalization({
	Amantul 			= "Аман`тул через 5 сек - переключись",
	Kazgagot 			= "Каз`горот через 5 сек - йди з центру",
	Norgannon 			= "Норганнон через 5 сек - біжи в центр",
	Golgannet 			= "Голганнет через 5 сек - тримай радіус 2м"
})

L:SetTimerLocalization({
	timerBossIncoming 	= DBM_INCOMING,
	timerAmanThul 		= "~ Амантул",
	timerKhazgoroth		= "~ Полум'я",
	timerNorgannon 		= "~ Стіна",
	timerGolganneth 	= "~ Блискавка"
})

L:SetOptionLocalization({
	ShowProshlyapMurchal = "Спец-попередження про $journal:16138 (потрібні права лідера рейду)",
	Amantul 			= "Спец-попередження за 5 сек до появи $spell:252479",
	Norgannon 			= "Спец-попередження за 5 сек до появи $spell:244740",
	Golgannet 			= "Спец-попередження за 5 сек до появи $spell:244756",
	Kazgagot 			= "Спец-попередження за 5 сек до появи $spell:244733",
	timerBossIncoming 	= "Показати таймер для наступної зміни боса",
	TauntBehavior 		= "Налаштування поведінки при зміні танка",
	TwoMythicThreeNon 	= "Обмін на 2 стаках на міфік складності, на 3 стаках на інших",
	TwoAlways 			= "Завжди мінятися на 2 стаках незалежно від складності",
	ThreeAlways 		= "Завжди мінятися на 3 стаках незалежно від складності",
	SetLighting 		= "Автоматичне перемикання освітлення на низький рівень, коли ковен задіяний, і відновлення наприкінці бою на колишній рівень (не підтримується в mac-клієнті, тому що mac-клієнт не підтримує низьке освітлення)",
	InterruptBehavior 	= "Налаштування поведінки переривання для рейду (потрібні права лідера рейду)",
	Three 				= "Чергування 3 осіб",
	Four 				= "Чергування 4 осіб",
	Five 				= "Чергування 5 осіб",
	IgnoreFirstKick 	= "При використанні цієї опції перше переривання виключається з чергування (потрібні права лідера рейду)",
	timerAmanThul 		= "Відлік часу застосування заклинання $spell:250335",
	timerKhazgoroth 	= "Відлік часу застосування заклинання $spell:250333",
	timerNorgannon 		= "Відлік часу застосування заклинання $spell:250334",
	timerGolganneth 	= "Відлік часу застосування заклинання $spell:249793"
})

L:SetMiscLocalization({
	ProshlyapMurchal4	= "%s СТЕНКА - ВСЕ В ЦЕНТР!",
	ProshlyapMurchal3	= "%s МОЛНИИ - ДЕРЖИМ РАДИУС 2 МЕТРА!",
	ProshlyapMurchal2	= "%s ПЛАМЯ - УШЛИ ВСЕ С ЦЕНТРА!",
	ProshlyapMurchal1	= "%s АМАНТУЛ - СВИЧ В ТРЕШ!",
	ProshlyapMurchal5	= "%s ВЕСЬ УРОН ПО БОССУ!"
})

------------
--Агграмар--
------------
L= DBM:GetModLocalization(1984)

L:SetWarningLocalization({
	FlameRend1 = "ЧЕРГА ІНШОЇ ГРУПИ"
})

L:SetOptionLocalization({
	ShowProshlyapMurchal1 	= "Спец-попередження про $spell:244688 (потрібні права лідера рейду)",
	ShowProshlyapMurchal2 	= "Спец-попередження про $spell:244912 (потрібні права лідера рейду)",
	FlameRend1 				= "Спец-попередження під час $spell:245463, коли не ваша черга (тільки міфік)",
	ignoreThreeTank 		= "Фільтр спеціальних попереджень (Полум'я/Круйнівник) під час використання 3 і більше танків (оскільки DBM не може визначити точне чергування танків при такому розкладі). Якщо танки гинуть і кількість танків зменшується до 2, фільтр автоматично відключається."
})

L:SetMiscLocalization({
	MurchalProshlyapation 	= "%s %s через 5 сек!",
	ProshlyapMurchal2		= "%s КОНТРОЛИМ МОБОВ!",
	ProshlyapMurchal1		= "%s ВСЕ ПОД БОССА!",
	Foe 					= "Шредер",
	Rend 					= "Полум'я",
	Tempest 				= "Буря",
	Current					= "Поточний:"
})

----------------------
--Аргус Порабощенный--
----------------------
L= DBM:GetModLocalization(2031)

L:SetTimerLocalization({
	timerSargSentenceCD		= "~ Вирок (%s)"
})

L:SetOptionLocalization({
	ShowProshlyapationOfMurchal1 	= "Спец-попередження про $spell:258068 (потрібні права лідера рейду)",
	ShowProshlyapationOfMurchal2 	= "Спец-попередження про $spell:256389 (потрібні права лідера рейду)",
	AutoProshlyapMurchal 			= "Автоматично залишати тіло",
	timerSargSentenceCD 			= DBM_CORE_AUTO_TIMER_OPTIONS["cdcount"]:format(257966)
})

L:SetMiscLocalization({
	ProshlyapMurchal = "%s %s через 5 сек!",
	SeaText		= "Хаст/Верса на %s",
	SkyText		= "Крит/Мастери на %s",
	Blight		= "ЧУМА",
	Burst		= "ВИБУХ",
	Sentence	= "ПРИГОВОР",
	Bomb		= "БОМБА",
	Blight2		= "Чума на %s!",
	Burst2		= "Взрыв на мне!",
--	Sentence2	= "Приговор на %s!",
	Rage		= "ЯРОСТЬ",
	Fear		= "СТРАХ"
})

-------------
--Треш-мобы--
-------------
L = DBM:GetModLocalization("AntorusTrash")

L:SetGeneralLocalization({
	name =	"Трэш АПТ"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT,
	BossActivation = DBM_CORE_GENERIC_TIMER_ROLE_PLAY
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetMiscLocalization({
	RPImonar = "Стояти!"--необходима проверка
})
