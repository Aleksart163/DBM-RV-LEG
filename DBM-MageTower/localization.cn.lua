if GetLocale() ~= "zhCN" then return end

local L

--Прошляпанное очко Мурчаля ✔

------------------------
-- Mage Tower: TANK --
------------------------
L= DBM:GetModLocalization("Kruul")

L:SetGeneralLocalization({
	name =	"돌아온 대군주"
})

------------------------
-- Mage Tower: Healer --
------------------------
L= DBM:GetModLocalization("ErdrisThorn")

L:SetGeneralLocalization({
	name =	"되살아난 위협의 끝"
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("FelTotem")

L:SetGeneralLocalization({
	name =	"지옥토템의 몰락"
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("ImpossibleFoe")

L:SetGeneralLocalization({
	name =	"말도 안 되게 강력한 적"
})

L:SetMiscLocalization({
	impServants = "击杀小鬼仆从，别让他们为阿加莎补充能量！" --
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("Queen")

L:SetGeneralLocalization({
	name =	"여신왕의 분노"
})

L:SetMiscLocalization({
	MurchalProshlyapRP = "我……我在做什么？这不对！" --
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("Twins")

L:SetGeneralLocalization({
	name =	"쌍둥이의 싸움 막기"
})

L:SetMiscLocalization({
	TwinsRP1 = "废物！让开，看我是怎么做的，兄弟。", --
	TwinsRP2 = "我又得帮你收拾烂摊子了，兄弟！" --
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("Xylem")

L:SetGeneralLocalization({
	name =	"눈동자가 어둠에 물들기 전에"
})

------------------------
-- Mage Tower: Timers --
------------------------
L= DBM:GetModLocalization("Timers")

L:SetGeneralLocalization({
	name = "战斗开始计时器"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetMiscLocalization({
	Kruul = "傲慢的蠢货！我掌握着千万世界的灵魂之力！", --
	Twins1 = "我不能让你祸害艾泽拉斯，莱斯特。如果你不投降，我只能毁掉你了！", --
	ErdrisThorn1 = "我不回去！我要阻止对镇子的攻击！", --
	Agatha1 = "此刻，我的萨亚德正在诱惑软弱的法师。你的盟友会自愿倒向军团！", --
	Sigryn1 = "你别想永远躲在高墙后面，奥丁！" --
})
