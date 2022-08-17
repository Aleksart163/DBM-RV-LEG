local L

--Прошляпанное очко Мурчаля ✔

------------------------
-- Mage Tower: TANK --
------------------------
L= DBM:GetModLocalization("Kruul")

L:SetGeneralLocalization({
	name =	"The Highlord's Return"
})

L:SetWarningLocalization({
	Phase2 = "Phase 2 soon"
})

L:SetOptionLocalization({
	Phase2 = "Warn in advance about phase 2 (on ~10%)"
})

------------------------
-- Mage Tower: Healer --
------------------------
L= DBM:GetModLocalization("ErdrisThorn")

L:SetGeneralLocalization({
	name =	"End of the Risen Threat"
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("FelTotem")

L:SetGeneralLocalization({
	name =	"Feltotem's Fall"
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("ImpossibleFoe")

L:SetGeneralLocalization({
	name =	"An Impossible Foe"
})

L:SetMiscLocalization({
	impServants =	"Kill the Imp Servants before they energize Agatha!"
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("Queen")

L:SetGeneralLocalization({
	name =	"The God-Queen's Fury"
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("Twins")

L:SetGeneralLocalization({
	name =	"Thwarting the Twins"
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("Xylem")

L:SetGeneralLocalization({
	name =	"Closing the Eye"
})

--------------------------
-- Mage Tower: Timers --
--------------------------
L= DBM:GetModLocalization("Timers")

L:SetGeneralLocalization({
	name = "Combat start timers"
})

L:SetOptionLocalization({
	timerRoleplay = "Countdown to the start of the battle"
})

L:SetTimerLocalization({
	timerRoleplay = "Battle Start"
})

L:SetMiscLocalization({
	Kruul = "Arrogant fools! I am empowered by the souls of a thousand conquered worlds!",
	Twins = "I cannot let you unleash your power upon Azeroth, Raest. If you do not yield, I will be forced to destroy you!",
	ErdrisThorn1 = "Нет уж! Пора положить конец атакам на мой город!"
})
