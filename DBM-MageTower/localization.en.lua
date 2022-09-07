local L

--Прошляпанное очко Мурчаля ✔✔

------------------------
-- Mage Tower: TANK --
------------------------
L= DBM:GetModLocalization("Kruul")

L:SetGeneralLocalization({
	name =	"The Highlord's Return"
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
	impServants = "Kill the Imp Servants before they energize Agatha!"
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("Queen")

L:SetGeneralLocalization({
	name =	"The God-Queen's Fury"
})

L:SetMiscLocalization({
	SigrynRP1 = "What... what am I doing? This is not right!"
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("Twins")

L:SetGeneralLocalization({
	name =	"Thwarting the Twins"
})

L:SetMiscLocalization({
	TwinsRP1 = "Useless! Stand aside while I do what you cannot, brother.", --
	TwinsRP2 = "Once again I must clean up your mess, brother!" --
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("Xylem")

L:SetGeneralLocalization({
	name =	"Closing the Eye"
})

------------------------
-- Mage Tower: Timers --
------------------------
L= DBM:GetModLocalization("Timers")

L:SetGeneralLocalization({
	name = "Combat start timers"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetMiscLocalization({
	Kruul = "Arrogant fools! I am empowered by the souls of a thousand conquered worlds!",
	Twins1 = "I cannot let you unleash your power upon Azeroth, Raest. If you do not yield, I will be forced to destroy you!",
	ErdrisThorn1 = "No way I'm staying behind! The attacks on my town must be stopped!",
	Agatha1 = "Even now, my sayaad tempt your weak-willed mages. Your allies will surrender willingly to the Legion!",
	Sigryn1 = "You cannot hide behind these walls forever, Odyn!"
--	Sigryn2 = "What's this? The outsider has come to stop me? I owe you much, but I cannot allow you to impede my quest for justice!"
})
