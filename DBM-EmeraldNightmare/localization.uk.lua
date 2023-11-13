if GetLocale() ~= "ukUK" then return end

--- New Proshlyapation Ochka Murchalya Proshlyapenko? ---

local L
------------
--Низендра--
------------
L= DBM:GetModLocalization(1703)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})

--------------------------
--Ил'гинот, Сердце Порчи--
--------------------------
L= DBM:GetModLocalization(1738)

L:SetOptionLocalization({
	SetIconOnlyOnce2 	= "Встановлювати мітку тільки один раз за сканування гною, а потім відключати, поки хоча б один не вибухне (експериментально)",
	InfoFrameBehavior 	= "Інформація, що відображається в інформаційному вікні під час бою",
	Fixates 			= "Показувати гравців із Зосередженням уваги",
	Adds 				= "Показувати кількість для всіх типів аддів"
})

----------------------
--Элерет Дикая Лань --
----------------------
L= DBM:GetModLocalization(1744)

L:SetWarningLocalization({
	warnWebOfPain 		= ">%s< пов'язаний з >%s<",
	specWarnWebofPain 	= "Ви пов'язані з >%s<"
})

---------
--Урсок--
---------
L= DBM:GetModLocalization(1667)

L:SetWarningLocalization({
	Phase1 				= "Фаза 2 незабаром",
	Phase2 				= "Фаза 2"
})

L:SetOptionLocalization({
	Phase1 				= "Попереджати заздалегідь про фазу 2 (на ~33%)",
	Phase2 				= "Оголошувати фазу 2",
	NoAutoSoaking2 		= "Вимкнути всі попередження/стрілки для $spell:198006"
})

L:SetMiscLocalization({
	SoakersText 		= "Призначено замочування: %s"
})

-------------------
--Драконы Кошмара--
----------=--------
L= DBM:GetModLocalization(1704)

-----------
--Кенарий--
-----------
L= DBM:GetModLocalization(1750)

L:SetMiscLocalization({
	BrambleYell 		= "Колючки поруч із " ... UnitName("player") ... "!",
	BrambleMessage 		= "Увага: DBM не може визначити, за ким слідують колючки. Він попереджає про мету спавна. Бос вибирає гравця і кидає в нього колючки. Після цього колючки вибирають нову ціль, яку неможливо визначити"
})

----------
--Ксавий--
----------
L= DBM:GetModLocalization(1726)

L:SetOptionLocalization({
	InfoFrameFilterDream = "Фільтрувати гравців з $spell:206005 з інформаційного вікна"
})

-------------
--Треш-мобы--
-------------
L = DBM:GetModLocalization("EmeraldNightmareTrash")

L:SetGeneralLocalization({
	name =	"Трэш Изумрудного кошмара"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})
