if GetLocale() ~= "ruRU" then return end

local L
--$spell:137162
--------------------------------
--Разрушитель миров Кин'гарота--
--------------------------------
L= DBM:GetModLocalization(1992)

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
--[[
L:SetMiscLocalization({
	YellPullCouncil	= "От меня ещё никто не уходил живым."
})]]

----------------------------------
--Хранительница порталов Азабель--
----------------------------------
L= DBM:GetModLocalization(1985)

L:SetOptionLocalization({
	ShowAllPlatforms = "Показать все анонсы независимо от местоположения платформы игрока"
})
--[[
L:SetMiscLocalization({
	YellPullHasabel = "Ха! Так это и есть лучшие из защитников Азерота?",
	YellPullHasabel2 = "Ваш поход закончится здесь.",
	YellPullHasabel3 = "Легион сокрушает всех своих врагов!"
	YellPullHasabel4 = "Нам покорились все миры. Ваш – следующий."
})]]

------------------------------
--Эонар, Хранительница жизни--
------------------------------
L= DBM:GetModLocalization(2025)

L:SetTimerLocalization({
	timerObfuscator		= "~ Маскировщик (%s)",
	timerDestructor 	= "~ Разрушитель (%s)",
	timerPurifier 		= "~ Очиститель (%s)",
	timerBats	 		= "~ Птицы (%s)"
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
	Bats 		= "Птицы",
	EonarHealth	= "Здоровье Эонар",
	EonarPower	= "Сила Эонар",
	NextLoc		= "~"
})

--------------------
--Ловец душ Имонар--
--------------------
L= DBM:GetModLocalization(2009)

L:SetWarningLocalization({
	PulseGrenade = "Импульсная граната - стойте подальше от других"
})

L:SetOptionLocalization({
	PulseGrenade = "Спец-предупреждение \"стойте подальше от других\" когда вы цель $spell:250006"
})

L:SetMiscLocalization({
--	YellPullImonar = "Ваши кости будут щедро оплачены.",
--	YellPullImonar2 = "Я оставлю от вас пару кусочков на память.",
--	YellPullImonar3 = "Ваши головы украсят мою коллекцию.",
	DispelMe = "Диспел мне!"
})

-------------
--Кин'гарот--
-------------
L= DBM:GetModLocalization(2004)

L:SetOptionLocalization({
	InfoFrame =	"Показать информационное табло для обзора боя",
	UseAddTime = "Всегда показывать таймеры, когда босс выходит из фазы инициализации, вместо того, чтобы скрывать их. (Если таймеры отключены, они возобновятся, когда босс снова станет активным, но могут оставить мало предупреждений, если до окончания действия таймеров осталось 1-2 секунды)."
})
--[[
L:SetMiscLocalization({
	YellPullKingaroth = "За работу!",
	YellPullKingaroth2 = "И вы надеетесь одолеть мои машины этим жалким оружием?",
	YellPullKingaroth3 = "Приготовьтесь к утилизации."
})]]

--------------
--Вариматрас--
--------------
L= DBM:GetModLocalization(1983)
--[[
L:SetMiscLocalization({
	YellPullVarimathras = "Идите сюда и познайте страдания!",
	YellPullVarimathras2 = "Нападайте! Я покажу вам, что такое боль!"
})]]

----------------
--Ковен шиварр--
----------------
L= DBM:GetModLocalization(1986)

L:SetWarningLocalization({
	Amantul 			= "Мучения Аман`тула через 5 сек - переключитесь",
	Kazgagot 			= "Мучения Каз`горота через 5 сек - уйдите с центра",
	Norgannon 			= "Мучения Норганнона через 5 сек - бегите в центр",
	Golgannet 			= "Мучения Голганнета через 5 сек - держите радиус 2м"
})

L:SetTimerLocalization({
	timerBossIncoming 	= DBM_INCOMING,
	timerAmanThul 		= "~ Амантул",
	timerKhazgoroth 	= "~ Пламя",
	timerNorgannon 		= "~ Стенка",
	timerGolganneth 	= "~ Молнии"
})

L:SetOptionLocalization({
	ShowProshlyapMurchal = "Показать прошляп Мурчаля об $journal:16138 (требуются права лидера рейда)",
	Amantul 			= "Спец-предупреждение за 5 сек до появления $spell:252479",
	Norgannon 			= "Спец-предупреждение за 5 сек до появления $spell:244740",
	Golgannet 			= "Спец-предупреждение за 5 сек до появления $spell:244756",
	Kazgagot 			= "Спец-предупреждение за 5 сек до появления $spell:244733",
	timerBossIncoming	= "Показать таймер для следующей смены босса",
	TauntBehavior		= "Настройка поведения при смене танка",
	TwoMythicThreeNon	= "Обмен при 2 стаках на мифик сложности, на 3 стаках в других",--Default
	TwoAlways			= "Всегда меняться на 2 стаках независимо от сложности",
	ThreeAlways			= "Всегда меняться на 3 стаках независимо от сложности",
	SetLighting			= "Автоматическое переключение освещения на низкий уровень, когда ковен задействован и восстановление в конце боя на прежний уровень (не поддерживается в mac-клиенте, т.к. mac-клиент не поддерживает низкое освещение)",
	InterruptBehavior	= "Настройка поведения прерывания для рейда (требуются права лидера рейда)",
	Three				= "Чередование 3 человек",--Default
	Four				= "Чередование 4 человек",
	Five				= "Чередование 5 человек",
	IgnoreFirstKick		= "При использовании этой опции первое прерывание исключается из чередования (требуются права лидера рейда)",
	timerAmanThul 		= "Отсчет времени применения заклинания $spell:250335",
	timerKhazgoroth 	= "Отсчет времени применения заклинания $spell:250333",
	timerNorgannon 		= "Отсчет времени применения заклинания $spell:250334",
	timerGolganneth 	= "Отсчет времени применения заклинания $spell:249793"
})

L:SetMiscLocalization({
	ProshlyapMurchal4	= "СТЕНКА - ВСЕ В ЦЕНТР",
	ProshlyapMurchal3	= "МОЛНИИ - ДЕРЖИМ РАДИУС 2 МЕТРА",
	ProshlyapMurchal2	= "ПЛАМЯ - ВСЕ УШЛИ С ЦЕНТРА",
	ProshlyapMurchal1	= "АМАНТУЛ - СВИЧ В ТРЕШ",
	YellPullCoven		= "Сейчас ваша плоть зашипит на огне."
})

------------
--Агграмар--
------------
L= DBM:GetModLocalization(1984)

L:SetWarningLocalization({
--	FlameRend1 = "Урон делит 1-ая группа",
--	FlameRend2 = "Урон делит 2-ая группа",
	FlameRend3 = "Очередь другой группы"
})

L:SetOptionLocalization({
	FlameRend1 = "Спец-предупреждение во время $spell:245463 для первой группы (только мифик)",
	FlameRend2 = "Спец-предупреждение во время $spell:245463 для второй группы (только мифик)",
	FlameRend3 = "Спец-предупреждение во время $spell:245463, когда не ваша очередь (только мифик)",
	ignoreThreeTank	= "Фильтр специальных предупреждений (Пламя/Сокрушитель) при использовании 3 и более танков (так как DBM не может определить точное чередование танков при таком раскладе). Если танки погибают и количество танков уменьшается до 2, фильтр автоматически отключается."
})

L:SetMiscLocalization({
--	YellPullAggramar = "Вы сгорите!",
	Foe			= "Сокрушитель",
	Rend		= "Пламя",
	Tempest 	= "Буря",
	Current		= "Текущий:"
})

----------------------
--Аргус Порабощенный--
----------------------
L= DBM:GetModLocalization(2031)

L:SetTimerLocalization({
	timerSargSentenceCD	= "~ Приговор (%s)"
})

L:SetOptionLocalization({
	timerSargSentenceCD = DBM_CORE_AUTO_TIMER_OPTIONS["cdcount"]:format(257966)
})

L:SetMiscLocalization({
--	YellPullArgus = "Смерть! Смерть и боль!",
	SeaText		= "Хаста/Верса на %s",
	SkyText		= "Крит/Маст на %s",
	Blight		= "Чума на %s!",
	Burst		= "Взрыв на мне!",
	Sentence	= "Приговор на %s!",
	Bomb		= "БОМБА НА МНЕ!"
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
	RPImonar = "Стоять!"
})
