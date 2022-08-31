if GetLocale() ~= "koKR" then return end
local L

--Прошляпанное очко Мурчаля ✔

------------------------
-- Mage Tower: TANK --
------------------------
L= DBM:GetModLocalization("Kruul")

L:SetGeneralLocalization({
	name =	"대군주의 귀환"
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
	impServants = "임프 하수인들이 아가타에게 힘을 불어넣기 전에 처치하세요!"
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("Queen")

L:SetGeneralLocalization({
	name =	"여신왕의 분노"
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("Twins")

L:SetGeneralLocalization({
	name =	"쌍둥이의 싸움 막기"
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
