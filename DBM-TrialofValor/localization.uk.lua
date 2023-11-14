if GetLocale() ~= "ukUK" then return end

--- New Proshlyapation Ochka Murchalya Proshlyapenko? ---

local L

--------
--Один--
--------
L= DBM:GetModLocalization(1819)

L:SetOptionLocalization({
	ShowProshlyapMurchal = "Спец-попередження про $spell:227629 (потрібні права лідера рейду)"
})

L:SetMiscLocalization({
--	MurchalProshlyapation2 = "Неплохо... пока! Но я сам буду решать, достойны ли вы!", --нужна проверка
--	MurchalProshlyapation3 = "Напрасно я вас пожалел. Ну держитесь!",
	ProshlyapMurchal = "%s %s через 5 сек"
})

--------
--Гарм--
--------
L= DBM:GetModLocalization(1830)

---------
--Хелия--
---------
L= DBM:GetModLocalization(1829)

L:SetTimerLocalization({
	OrbsTimerText = "~ Сфера (%d-%s)"
})

L:SetMiscLocalization({
	MurchalProshlyapation2 = "Скоро вы пополните ряды моих квалдиров!",
	MurchalProshlyapation3 = "Даже не надейтесь, смертные! Один НИКОГДА не обретет свободу!",
	near = "Біля",
	far = "Вдалині",
	multiple = "множинний"
})

-------------
--Треш-мобы--
-------------
L = DBM:GetModLocalization("TrialofValorTrash")

L:SetGeneralLocalization({
	name =	"Трэш Испытания Доблести"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetMiscLocalization({
--	RP1 = "Герои! Вы пролили кровь слуг Хелии. Пришло время отправиться в Хельхейм и положить конец владычеству ведьмы! Но сперва – последнее испытание!" --нужна проверка
})
