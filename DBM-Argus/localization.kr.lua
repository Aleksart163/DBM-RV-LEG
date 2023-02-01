if GetLocale() ~= "koKR" then return end

local L

--Прошляпанное очко Мурчаля ✔

----------------
--rare enemies--
----------------
L = DBM:GetModLocalization("RareEnemiesArgus")

L:SetGeneralLocalization({
	name = "매우 위험한 적 아르거스" --right?
})

L:SetMiscLocalization{
	MurchalOchkenProshlyapen = "가 곧 도착합니다!",
	MurchalOchkenProshlyapen2 = "가 도착했습니다! 숨을 곳을 찾으십시오!"
}
