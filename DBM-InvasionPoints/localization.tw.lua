if GetLocale() ~= "zhTW" then return end

local L

-----------------------
-- Inquisitor Meto --
-----------------------
L= DBM:GetModLocalization(2012)

L:SetMiscLocalization({
	Pull = "你注定會死！" --
})

-----------------------
-- Occularus --
-----------------------
L= DBM:GetModLocalization(2013)

L:SetMiscLocalization({
	Pull = "我看到你靈魂的弱點了！" --
})

-----------------------
-- Sotanathor --
-----------------------
L= DBM:GetModLocalization(2014)

L:SetMiscLocalization({
	Pull = "來吧，小傢伙，讓我殺了你們！" --
})

-----------------------
-- Mistress Alluradel --
-----------------------
L= DBM:GetModLocalization(2011)

L:SetMiscLocalization({
	Pull = "新的玩具嗎？真是難以抗拒啊！" --
})

-----------------------
-- Matron Folnuna --
-----------------------
L= DBM:GetModLocalization(2010)

L:SetMiscLocalization({
	Pull = "對…小傢伙，靠近一點！" --
})

-----------------------
-- Pit Lord Vilemus --
-----------------------
L= DBM:GetModLocalization(2015)

L:SetMiscLocalization({
	Pull = "魔火會燒盡所有世界！" --
})

-----------
-- Trash --
-----------
L= DBM:GetModLocalization("InvasionPointsTrash")

L:SetGeneralLocalization({
	name = "侵略點小怪"
})

L:SetMiscLocalization{
	MurchalOchkenProshlyapen = "快靠近火盆！", --快靠近火盆！[閃霜]來了！
	MurchalOchkenProshlyapen2 = "這個區域被", --這個區域被[焚滅]鎖定了！
	MurchalOchkenProshlyapen3 = "梭塔納索的斧頭發出" --梭塔納索的斧頭發出[毀滅浪潮]！
}
