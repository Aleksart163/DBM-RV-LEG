if GetLocale() ~= "ruRU" then return end

local L

-----------------------
--  Общие параметры  --
-----------------------
L = DBM:GetModLocalization("Battlegrounds")

L:SetGeneralLocalization({
	name = "Общие параметры"
})

L:SetWarningLocalization({
	Start = "Битва началась!"
})

L:SetTimerLocalization({
	timerCombatStart	= DBM_CORE_GENERIC_TIMER_COMBAT,
	TimerInvite 		= "%s"
})

L:SetOptionLocalization({
	Start		 		= "Спец-предупреждение \"Битва началась!\" при начале боя на полях боя",
	timerCombatStart 	= DBM_CORE_OPTION_TIMER_COMBAT,
	ColorByClass		= "Показывать имена цветом класса в таблице очков",
	ShowInviteTimer		= "Отсчет времени до входа на поле боя",
	AutoSpirit			= "Автоматически покидать тело",
	HideBossEmoteFrame	= "Скрыть фрейм эмоций рейдового босса"
})

L:SetMiscLocalization({
	BgStart1 			= "Битва начнется через 1 минуту.", --
	BgStart2 			= "Битва начнется через минуту!", --
	BgStart3 			= "Битва начнется через 30 секунд. Приготовиться!", --
	BgStart4 			= "Битва начнется через 30 секунд!", --
	BgStart5 			= "Второй раунд сражения за Берег Древних начнется через 1 минуту.", --вероятно точно
	BgStart6 			= "Второй раунд начинается через 30 секунд.  Приготовьтесь!", --вроде точно, ещё раз проверить
	BgStart 			= "Битва началась!", --
	ArenaInvite			= "Приглашение на Арену"
})

-------------
--  Арены  --
-------------
L = DBM:GetModLocalization("Arenas")

L:SetGeneralLocalization({
	name = "Арена"
})

L:SetTimerLocalization({
	timerCombatStart = DBM_CORE_GENERIC_TIMER_COMBAT,
	TimerShadow	= "Сумеречное зрение"
})

L:SetOptionLocalization({
	timerCombatStart = DBM_CORE_OPTION_TIMER_COMBAT,
	TimerShadow = "Отсчет времени до сумеречного зрения"
})

L:SetMiscLocalization({ --Одна минута до начала боя на арене!
	Start30			= "Тридцать секунд до начала боя на арене!", --
	Start15			= "Пятнадцать секунд до начала боя на арене!", --
	Start			= "Битва на арене началась!" --
})

----------------
--  Альтерак  --
----------------
L = DBM:GetModLocalization("z30")

L:SetTimerLocalization({
	TimerTower	= "%s",
	TimerGY		= "%s"
})

L:SetOptionLocalization({
	TimerTower	= "Отсчет времени до захвата башен",
	TimerGY		= "Отсчет времени до захвата кладбищ",
	AutoTurnIn	= "Автоматическая сдача заданий"
})

--------------------
--  Низина Арати  --
--------------------
L = DBM:GetModLocalization("z529")

L:SetTimerLocalization({
	TimerCap	= "%s"
})

L:SetOptionLocalization({
	TimerWin				= "Отсчет времени до победы",
	TimerCap				= "Отсчет времени до захвата",
	ShowAbEstimatedPoints	= "Отображать предполагаемое кол-во очков, оставшееся до победы/поражения",
	ShowAbBasesToWin		= "Отображать кол-во баз, необходимое для победы"
})

L:SetMiscLocalization({
	ScoreExpr	= "(%d+)/1500",
	WinBarText	= "%s побеждает",
	BasesToWin	= "Баз для победы: %d"
})

----------------------------
--  Каньон Суровых Ветров --
----------------------------
L = DBM:GetModLocalization("z1105")

L:SetTimerLocalization({
	TimerCap	= "%s"
})

L:SetOptionLocalization({
	TimerCap	= "Отсчет времени до захвата",
	TimerWin	= "Отсчет времени до победы"
})

L:SetMiscLocalization({
	ScoreExpr	= "(%d+)/1500",
	WinBarText	= "%s побеждает"
})

----------------
--  Око Бури  --
----------------
L = DBM:GetModLocalization("z566")

L:SetTimerLocalization({
	TimerFlag		= "Восстановление флага"
})

L:SetOptionLocalization({
	TimerWin 		= "Отсчет времени до победы",
	TimerFlag 		= "Отсчет времени до восстановления флага",
	ShowPointFrame	= "Отображать флагоносца и предполагаемые очки"
})

L:SetMiscLocalization({
	ScoreExpr		= "(%d+)/1500",
	WinBarText 		= "%s побеждает",
	Flag			= "Флаг",
	FlagReset 		= "Флаг возвращен на базу.",
	FlagTaken 		= "(.+) захватывает флаг!",
	FlagCaptured	= "(.+) захватил флаг!", --"Орда захватила флаг!"
	FlagDropped		= "Флаг уронили!"
})

--------------------------
--  Ущелье Песни Войны  --
--------------------------
L = DBM:GetModLocalization("z489")

L:SetTimerLocalization({
	TimerFlag	= "Восстановление флага"
})

L:SetOptionLocalization({
	TimerFlag					= "Отсчет времени до восстановления флага",
	ShowFlagCarrier				= "Показывать флагоносца",
	ShowFlagCarrierErrorNote	= "Сообщение об ошибке выбора флагоносца в режиме боя"
})

L:SetMiscLocalization({
	InfoErrorText		= "Функция выбора флагоносца будет восстановлена после выхода из режима боя.",
	ExprFlagPickUp		= "(.+) несет флаг (%w+)!",
	ExprFlagCaptured	= "(.+) захватывает флаг (%w+)!",
	ExprFlagReturn		= "(.+) возвращает на базу флаг (%w+)!",
	FlagAlliance		= "Флаг Альянса: ",
	FlagHorde			= "Флаг Орды: ",
	FlagBase			= "База",
	Vulnerable1			= "Персонажи, несущие флаг, стали более уязвимы!",
	Vulnerable2			= "Персонажи, несущие флаг, стали еще более уязвимы!",
	ExprFlagPickUp2		= "Флаг (%w+) у (.+)!" -- only used for Russian language
})

-------------------------
--  Остров Завоеваний  --
-------------------------
L = DBM:GetModLocalization("z628")

L:SetWarningLocalization({
	WarnSiegeEngine		= "Осадная машина готова!",
	WarnSiegeEngineSoon	= "Осадная машина через ~10 сек"
})

L:SetTimerLocalization({
	TimerPOI			= "%s",
	TimerSiegeEngine	= "Осадная машина готова"
})

L:SetOptionLocalization({
	TimerPOI			= "Отсчет времени до захвата",
	TimerSiegeEngine	= "Отсчет времени до создания Осадной машины",
	WarnSiegeEngine		= "Предупреждение, когда создание Осадной машины завершено",
	WarnSiegeEngineSoon	= "Предупреждение, когда создание Осадной машины почти завершено",
	ShowGatesHealth		= "Отображать здоровье поврежденых ворот (значение здоровья может быть некорректным после захода в уже начавшееся поле боя!)"
})

L:SetMiscLocalization({ --Доделать Прошляпэйшен Мурчаля (Прошляпенко)
	GatesHealthFrame		= "Поврежденые ворота",
	SiegeEngine				= "Осадная машина",
	GoblinStartAlliance		= "See those seaforium bombs? Use them on the gates while I repair the siege engine!",
	GoblinStartHorde		= "Я буду работать над осадной машиной, я ты меня прикрывай. Вот, можешь пользоваться этими сефориевыми бомбами, если тебе надо взорвать ворота.",
	GoblinHalfwayAlliance	= "I'm halfway there! Keep the Horde away from here.  They don't teach fighting in engineering school!",
	GoblinHalfwayHorde		= "I'm about halfway done! Keep the Alliance away - fighting's not in my contract!",
	GoblinFinishedAlliance	= "My finest work so far! This siege engine is ready for action!",
	GoblinFinishedHorde		= "The siege engine is ready to roll!",
	GoblinBrokenAlliance	= "It's broken already?! No worries. It's nothing I can't fix.",
	GoblinBrokenHorde		= "It's broken again?! I'll fix it... just don't expect the warranty to cover this"
})

----------------
--  Два Пика  --
----------------
L = DBM:GetModLocalization("z726")

L:SetTimerLocalization({
	TimerFlag	= "Восстановление флага"
})

L:SetOptionLocalization({
	TimerFlag					= "Отсчет времени до восстановления флага",
	ShowFlagCarrier				= "Показывать флагоносца",
	ShowFlagCarrierErrorNote	= "Сообщение об ошибке выбора флагоносца в режиме боя"
})

L:SetMiscLocalization({
	InfoErrorText		= "Функция выбора флагоносца будет восстановлена после выхода из режима боя.",
	ExprFlagPickUp		= "(.+) несет флаг (%w+)!", --"Флаг (%w+) у (.+)!"
	ExprFlagCaptured	= "(.+) захватывает флаг (%w+)!",
	ExprFlagReturn		= "(.+) возвращает на базу флаг (%w+)!",
	FlagAlliance		= "Флаг Альянса: ",
	FlagHorde			= "Флаг Орды: ",
	FlagBase			= "База",
	Vulnerable1			= "Персонажи, несущие флаг, стали более уязвимы!",
	Vulnerable2			= "Персонажи, несущие флаг, стали еще более уязвимы!"
})

------------------------
--  Битва за Гилнеас  --
------------------------
L = DBM:GetModLocalization("z761")

L:SetTimerLocalization({
	TimerCap	= "%s"
})

L:SetOptionLocalization({
	TimerWin					= "Отсчет времени до победы",
	TimerCap					= "Отсчет времени до захвата",
	ShowGilneasEstimatedPoints	= "Отображать предполагаемое кол-во очков, оставшееся до победы/поражения",
	ShowGilneasBasesToWin		= "Отображать кол-во баз, необходимое для победы"
})

L:SetMiscLocalization({
	ScoreExpr	= "(%d+)/1500",
	WinBarText	= "%s побеждает",
	BasesToWin	= "Баз для победы: %d"
})

-----------------------
--  Сверкающие копи  --
-----------------------
L = DBM:GetModLocalization("z727")

L:SetTimerLocalization({
	TimerCart	= "Восстановление вагонетки"
})

L:SetOptionLocalization({
	TimerCart	= "Отсчет времени до восстановления вагонетки"
})

L:SetMiscLocalization({
	Capture		= "захвачена"
})

--------------------
--  Храм Котмогу  --
--------------------
L = DBM:GetModLocalization("z998")

L:SetOptionLocalization({
	TimerWin					= "Отсчет времени до победы",
	ShowKotmoguEstimatedPoints	= "Отображать предполагаемое кол-во очков, оставшееся до победы/поражения",
	ShowKotmoguOrbsToWin		= "Отображать кол-во сфер, необходимое для победы"
})

L:SetMiscLocalization({
	OrbTaken 	= "(%S+) захватывает (%S+) сферу!",
	OrbReturn 	= "(%S+) сфера возвращена!",
	ScoreExpr	= "(%d+)/1500",
	WinBarText	= "Предположительно %s побеждает",
	OrbsToWin	= "Сфер для победы: %d"
})
