if GetLocale() ~= "ruRU" then return end

local L

--------
--Один--
--------
L= DBM:GetModLocalization(1819)

--------
--Гарм--
--------
L= DBM:GetModLocalization(1830)

---------
--Хелия--
---------
L= DBM:GetModLocalization(1829)

L:SetTimerLocalization({
	OrbsTimerText = "След. Сфера (%d-%s)"
})

L:SetMiscLocalization({
	phaseThree = "Даже не надейтесь, смертные! Один НИКОГДА не обретет свободу!",
	near = "Возле",
	far = "Вдалеке",
	multiple = "множественный"
})

-------------
--Треш-мобы--
-------------
L = DBM:GetModLocalization("TrialofValorTrash")

L:SetGeneralLocalization({
	name =	"Трэш Испытания Доблести"
})

L:SetOptionLocalization({
	timerRoleplay = "Отсчет времени до начала боя с Одином"
})

L:SetTimerLocalization({
	timerRoleplay = "Начало боя"
})

L:SetMiscLocalization({
	RP1 = "Герои! Вы пролили кровь слуг Хелии. Пришло время отправиться в Хельхейм и положить конец владычеству ведьмы! Но сперва - последнее испытание!"
})
