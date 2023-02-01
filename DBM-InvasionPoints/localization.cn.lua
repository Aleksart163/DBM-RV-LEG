if GetLocale() ~= "zhCN" then return end

local L

-----------------------
-- Inquisitor Meto --
-----------------------
L= DBM:GetModLocalization(2012)

L:SetMiscLocalization({
	Pull = "你的命运只有死亡！" --
})

-----------------------
-- Occularus --
-----------------------
L= DBM:GetModLocalization(2013)

L:SetMiscLocalization({
	Pull = "我看到了你灵魂中的弱点！" --
})

-----------------------
-- Sotanathor --
-----------------------
L= DBM:GetModLocalization(2014)

L:SetMiscLocalization({
	Pull = "Come, small ones. Die by my hand!"
})

-----------------------
-- Mistress Alluradel --
-----------------------
L= DBM:GetModLocalization(2011)

L:SetMiscLocalization({
	Pull = "新玩具？真迷人！" --
})

-----------------------
-- Matron Folnuna --
-----------------------
L= DBM:GetModLocalization(2010)

L:SetMiscLocalization({
	Pull = "Yes... come closer, little ones!"
})

-----------------------
-- Pit Lord Vilemus --
-----------------------
L= DBM:GetModLocalization(2015)

L:SetMiscLocalization({
	Pull = "所有的世界都将在邪火中燃烧！" --
})

-----------
-- Trash --
-----------
L= DBM:GetModLocalization("InvasionPointsTrash")

L:SetGeneralLocalization({
	name = "侵入点小怪"
})

L:SetMiscLocalization{
	MurchalOchkenProshlyapen = "快靠近火盆！" --快靠近火盆！[快速冻结]即将爆发！
}
