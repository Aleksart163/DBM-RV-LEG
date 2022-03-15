if GetLocale() ~= "ruRU" then return end
local L
--$spell:137162
--------------------------------
--Разрушитель миров Кин'гарота--
--------------------------------
L= DBM:GetModLocalization(1992)

L:SetWarningLocalization({
	Reaktor = "Скоро Реактор апокалипсиса"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	Reaktor = "Предупреждать заранее о $spell:244152 (за ~3% до каста)"
})

L:SetMiscLocalization({
	YellPullGarothi = "Обнаружен противник. Уровень угрозы - номинальный."
})

--------------------
--Гончие Саргераса--
--------------------
L= DBM:GetModLocalization(1987)

L:SetOptionLocalization({
	SequenceTimers = "Уменьшить кд в таймерах на героической/мифической сложности за счет незначительной точности таймеров (на 1-2 секунды раньше)"
})

--------------------------
--Военный совет Анторуса--
--------------------------
L= DBM:GetModLocalization(1997)

L:SetMiscLocalization({
	YellPullCouncil = "От меня ещё никто не уходил живым."
})

----------------------------------
--Хранительница порталов Азабель--
----------------------------------
L= DBM:GetModLocalization(1985)

L:SetOptionLocalization({
	ShowAllPlatforms = "Показать все анонсы независимо от местоположения платформы игрока"
})

L:SetMiscLocalization({
	YellPullHasabel = "Ха! Так это и есть лучшие из защитников Азерота?",
	YellPullHasabel2 = "Ваш поход закончится здесь.",
	YellPullHasabel3 = "Легион сокрушает всех своих врагов!",
	YellPullHasabel4 = "Нам покорились все миры. Ваш – следующий."
})

------------------------------
--Эонар, Хранительница жизни--
------------------------------
L= DBM:GetModLocalization(2025)

L:SetTimerLocalization({
	timerObfuscator		= "След. Маскировщик (%s)",
	timerDestructor 	= "След. Разрушитель (%s)",
	timerPurifier 		= "След. Очиститель (%s)",
	timerBats	 		= "След. Летучие мыши (%s)"
})

L:SetOptionLocalization({
	timerObfuscator		= DBM_CORE_AUTO_TIMER_OPTIONS["cdcount"]:format("ej16501"),
	timerDestructor 	= DBM_CORE_AUTO_TIMER_OPTIONS["cdcount"]:format("ej16502"),
	timerPurifier 		= DBM_CORE_AUTO_TIMER_OPTIONS["cdcount"]:format("ej16500"),
	timerBats	 		= DBM_CORE_AUTO_TIMER_OPTIONS["cdcount"]:format("ej17039")
})

L:SetMiscLocalization({
	YellPullEonar = "Герои! Демоны пытаются захватить мою сущность для своего повелителя.",
	Obfuscators = "Маскировщик",
	Destructors = "Разрушитель",
	Purifiers 	= "Очиститель",
	Bats 		= "Летучие мыши",
	EonarHealth	= "Здоровье Эонар",
	EonarPower	= "Сила Эонар",
	NextLoc		= "След:"
})

--------------------
--Ловец душ Имонар--
--------------------
L= DBM:GetModLocalization(2009)

L:SetWarningLocalization({
	Phase2 = "Скоро фаза 2",
	Phase3 = "Скоро фаза 3",
	Phase4 = "Скоро фаза 4",
	Phase5 = "Скоро фаза 5"
})

L:SetOptionLocalization({
	Phase2 = "Предупреждать заранее о фазе 2 (на ~70%, на ~84% в мифике)",
	Phase3 = "Предупреждать заранее о фазе 3 (на ~37%, на ~64% в мифике)",
	Phase4 = "Предупреждать заранее о фазе 4 (на ~44% в мифике)",
	Phase5 = "Предупреждать заранее о фазе 5 (на ~24% в мифике)"
})

L:SetMiscLocalization({
	DispelMe = "Диспел мне!",
	YellPullImonar = "Ваши кости будут щедро оплачены.",
	YellPullImonar2 = "Я оставлю от вас пару кусочков на память.",
	YellPullImonar3 = "Ваши головы украсят мою коллекцию."
})

-------------
--Кин'гарот--
-------------
L= DBM:GetModLocalization(2004)

L:SetOptionLocalization({
	InfoFrame =	"Показать информационное табло для обзора боя",
	UseAddTime = "Всегда показывать таймеры, когда босс выходит из фазы инициализации, вместо того, чтобы скрывать их. (Если таймеры отключены, они возобновятся, когда босс снова станет активным, но могут оставить мало предупреждений, если до окончания действия таймеров осталось 1-2 секунды)."
})

L:SetMiscLocalization({
	YellPullKingaroth = "За работу!",
	YellPullKingaroth2 = "И вы надеетесь одолеть мои машины этим жалким оружием?",
	YellPullKingaroth3 = "Приготовьтесь к утилизации."
})

--------------
--Вариматрас--
--------------
L= DBM:GetModLocalization(1983)

L:SetMiscLocalization({
	YellPullVarimathras = "Идите сюда и познайте страдания!",
	YellPullVarimathras2 = "Нападайте! Я покажу вам, что такое боль!"
})

----------------
--Ковен шиварр--
----------------
L= DBM:GetModLocalization(1986)

L:SetWarningLocalization({
	Amantul = "Мучения Аман`тула через 5 сек - переключитесь",
	Norgannon = "Мучения Норганнона через 5 сек - бегите в центр",
	Golgannet = "Мучения Голганнета через 5 сек - держите радиус 2м",
	Kazgagot = "Мучения Каз`горота через 5 сек - уйдите с центра"
})

L:SetTimerLocalization({
	timerBossIncoming = DBM_INCOMING
})

L:SetOptionLocalization({
	Amantul = "Спец-предупреждение за 5 сек до появления $spell:252479",
	Norgannon = "Спец-предупреждение за 5 сек до появления $spell:244740",
	Golgannet = "Спец-предупреждение за 5 сек до появления $spell:244756",
	Kazgagot = "Спец-предупреждение за 5 сек до появления $spell:244733",
	timerBossIncoming	= "Показать таймер для следующей смены босса",
	TauntBehavior		= "Настройка поведения при смене танка",
	TwoMythicThreeNon	= "Обмен при 2 стаках на мифик сложности, на 3 стаках в других",--Default
	TwoAlways			= "Всегда меняться на 2 стаках независимо от сложности",
	ThreeAlways			= "Всегда меняться на 3 стаках независимо от сложности",
	SetLighting			= "Автоматическое переключение освещения на низкий уровень, когда ковен задействован и восстановление в конце боя на прежний уровень (не поддерживается в mac-клиенте, т.к. mac-клиент не поддерживает низкое освещение)",
	InterruptBehavior	= "Настройка поведения прерывания для рейда (требуется права лидера рейда)",
	Three				= "Чередование 3 человек",--Default
	Four				= "Чередование 4 человек",
	Five				= "Чередование 5 человек",
	IgnoreFirstKick		= "При использовании этой опции первое прерывание исключается из чередования (требуется права лидера рейда)"
})

L:SetMiscLocalization({
	YellPullCoven = "Сейчас ваша плоть зашипит на огне."
})

------------
--Агграмар--
------------
L= DBM:GetModLocalization(1984)

L:SetWarningLocalization({
	Phase1 = "Скоро фаза 2",
	Phase2 = "Фаза 2",
	Phase3 = "Скоро фаза 3",
	Phase4 = "Фаза 3"
})

L:SetOptionLocalization({
	Phase1 = "Предупреждать заранее о фазе 2 (на ~84%)",
	Phase2 = "Объявлять фазу 2",
	Phase3 = "Предупреждать заранее о фазе 3 (на ~44%)",
	Phase4 = "Объявлять фазу 3",
	ignoreThreeTank	= "Фильтр специальных предупреждений (Пламя/Сокрушитель) при использовании 3 и более танков (так как DBM не может определить точное чередование танков при таком раскладе). Если танки погибают и количество танков уменьшается до 2, фильтр автоматически отключается."
})

L:SetMiscLocalization({
	YellPullAggramar = "Вы сгорите!",
	Foe			= "Сокрушитель",
	Rend		= "Пламя",
	Tempest 	= "Буря",
	Current		= "Текущий:"
})

----------------------
--Аргус Порабощенный--
----------------------
L= DBM:GetModLocalization(2031)

L:SetWarningLocalization({
	Phase1 = "Скоро фаза 2",
	Phase2 = "Фаза 2",
	Phase3 = "Скоро фаза 3",
	Phase4 = "Фаза 3",
	Phase5 = "Скоро фаза 4",
	Phase6 = "Фаза 4"
})

L:SetTimerLocalization({
	timerSargSentenceCD	= "Восс. Приговор (%s)"
})

L:SetOptionLocalization({
	Phase1 = "Предупреждать заранее о фазе 2 (на ~74%)",
	Phase2 = "Объявлять фазу 2",
	Phase3 = "Предупреждать заранее о фазе 3 (на ~44%)",
	Phase4 = "Объявлять фазу 3",
	Phase5 = "Предупреждать заранее о фазе 4 (на 1 Констеллар-кураторе)",
	Phase6 = "Объявлять фазу 4",
	timerSargSentenceCD = DBM_CORE_AUTO_TIMER_OPTIONS["cdcount"]:format(257966)
})

L:SetMiscLocalization({
	YellPullArgus = "Смерть! Смерть и боль!",
	SeaText		= "{rt6} Хаста/Верса на мне!",
	SkyText		= "{rt5} Крит/Маст на мне!",
	Blight		= "Чумная сфера на мне!",
	Burst		= "Взрыв на мне!",
	Sentence	= "Приговор на мне!",
	Bomb		= "Бомба на мне!"
})

-------------
--Треш-мобы--
-------------
L = DBM:GetModLocalization("AntorusTrash")

L:SetGeneralLocalization({
	name =	"Трэш АПТ"
})
