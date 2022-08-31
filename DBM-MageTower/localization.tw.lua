if GetLocale() ~= "zhTW" then return end
local L

--Прошляпанное очко Мурчаля ✔

------------------------
-- Mage Tower: TANK --
------------------------
L= DBM:GetModLocalization("Kruul")

L:SetGeneralLocalization({
	name =	"大領主回歸"
})

------------------------
-- Mage Tower: Healer --
------------------------
L= DBM:GetModLocalization("ErdrisThorn")

L:SetGeneralLocalization({
	name =	"終結復活者的威脅"
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("FelTotem")

L:SetGeneralLocalization({
	name =	"魔化圖騰的落敗"
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("ImpossibleFoe")

L:SetGeneralLocalization({
	name =	"難以對付的敵人"
})

L:SetMiscLocalization({
	impServants =	"趁小鬼僕從還沒有強化亞加薩，趕緊殺死小鬼僕從！"
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("Queen")

L:SetGeneralLocalization({
	name =	"神御女王之怒"
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("Twins")

L:SetGeneralLocalization({
	name =	"阻止他們"
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("Xylem")

L:SetGeneralLocalization({
	name =	"閉上眼睛"
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
	Agatha1 = "Even now, my sayaad tempt your weak-willed mages. Your allies will surrender willingly to the Legion!"
})
