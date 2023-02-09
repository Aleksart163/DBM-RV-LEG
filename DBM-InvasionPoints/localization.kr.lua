if GetLocale() ~= "koKR" then return end

local L

-----------------------
-- Inquisitor Meto --
-----------------------
L= DBM:GetModLocalization(2012)

L:SetMiscLocalization({
	Pull = "너의 앞에 놓인 건 죽음뿐이다!"
})

-----------------------
-- Occularus --
-----------------------
L= DBM:GetModLocalization(2013)

L:SetMiscLocalization({
	Pull = "네 영혼의 나약함이 보이는구나!" --
})

-----------------------
-- Sotanathor --
-----------------------
L= DBM:GetModLocalization(2014)

L:SetMiscLocalization({
	Pull = "와라, 조그만 놈들아. 내 손에 죽어라!"
})

-----------------------
-- Mistress Alluradel --
-----------------------
L= DBM:GetModLocalization(2011)

L:SetMiscLocalization({
	Pull = "새 노리개네? 예쁘기도 하지!" --
})

-----------------------
-- Matron Folnuna --
-----------------------
L= DBM:GetModLocalization(2010)

L:SetMiscLocalization({
	Pull = "그래... 가까이 오거라, 귀여운 것들!" --
})

-----------------------
-- Pit Lord Vilemus --
-----------------------
L= DBM:GetModLocalization(2015)

L:SetMiscLocalization({
	Pull = "온 세계가 지옥불에 탈 것이다!" --
})

-----------
-- Trash --
-----------
L= DBM:GetModLocalization("InvasionPointsTrash")

L:SetGeneralLocalization({
	name = "침공 거점 일반몹"
})

L:SetMiscLocalization{
	MurchalOchkenProshlyapen = "화로로 가십시오!", --화로로 가십시오! 곧 [순간 빙결]이 시전됩니다!
	MurchalOchkenProshlyapen2 = "의 대상이 되었습니다!" --이 지역은 [소멸 광선]의 대상이 되었습니다!
}
