if GetLocale() ~= "zhTW" then return end
local L

--Прошляпанное очко Мурчаля ✔✔

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
	impServants =	"趁小鬼僕從還沒有強化亞加薩，趕緊殺死小鬼僕從！" --
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("Queen")

L:SetGeneralLocalization({
	name =	"神御女王之怒"
})

L:SetMiscLocalization({
	SigrynRP1 = "我…我在做什麼？這樣不對！" --
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("Twins")

L:SetGeneralLocalization({
	name =	"阻止他們"
})

L:SetMiscLocalization({
	TwinsRP1 = "沒用！走開，哥哥，你辦不到的事我來做。", --
	TwinsRP2 = "哥哥，我又在幫你收拾殘局了！" --
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
	Kruul = "傲慢的笨蛋！我已經吸收了無數靈魂的力量！", --
	Twins1 = "雷斯特，我不能讓你對艾澤拉斯釋放力量。要是你不住手，就是在逼我殺了你！", --
	ErdrisThorn1 = "我才不要袖手旁觀！我不想看到村子再受到攻擊！", --
	Agatha1 = "此時，我的薩亞德迷惑了你那些意志軟弱的法師。你的盟友會很樂意向燃燒軍團屈服！", --
	Sigryn1 = "歐丁，你別想永遠躲在英靈殿裡！" --
})
