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
	OrbsTimerText		= "След. Сфера (%d-%s)"
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
