if GetLocale() ~= "zhTW" then return end

local L

--Прошляпанное очко Мурчаля ✔

----------------
--rare enemies--
----------------
L = DBM:GetModLocalization("RareEnemiesArgus")

L:SetGeneralLocalization({
	name = "阿格斯上非常危险的敌人" --right?
})

L:SetMiscLocalization{
	MurchalProshlyap = "就快來了！",
	MurchalProshlyap2 = "來了！快躲起來！"
}
