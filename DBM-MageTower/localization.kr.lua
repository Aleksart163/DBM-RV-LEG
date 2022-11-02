if GetLocale() ~= "koKR" then return end

local L

--Прошляпанное очко Мурчаля ✔✔

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
	impServants = "임프 하수인이 아가타에게 힘을 불어넣기 전에 그들을 처치해야 합니다!" --
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("Queen")

L:SetGeneralLocalization({
	name =	"여신왕의 분노"
})

L:SetMiscLocalization({
	MurchalProshlyapRP = "내가... 뭘 하는 거지? 이건 옳지 않아!"
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("Twins")

L:SetGeneralLocalization({
	name =	"쌍둥이의 싸움 막기"
})

L:SetMiscLocalization({
	TwinsRP1 = "형편없군! 내가 처리할 테니 저리 비켜라, 형제여.",
	TwinsRP2 = "형제여, 또 내가 너의 뒤치다꺼리를 해야 하는구나!"
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("Xylem")

L:SetGeneralLocalization({
	name =	"눈동자가 어둠에 물들기 전에"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetMiscLocalization({
	Xylem = "안 돼... 옳지 않아!" --
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
	Kruul = "오만하고 멍청한 것들! 나에게는 수천 개의 세계에서 얻은 영혼의 힘이 흘러넘친다!", --
	Twins = "라이스트, 네가 아제로스를 뒤흔들게 할 수는 없어. 그만두지 않으면 널 쓰러뜨리겠다!", --
	ErdrisThorn = "보고만 있지 않을 거야! 내 마을을 지켜야 해!", --
	Agatha = "지금도 내 세이야드는 의지가 약한 마법사들을 유혹하고 있다. 네 동맹은 제 발로 군단에 굴복할 것이다!", --
	Sigryn = "이 벽 뒤에 영영 숨을 수 있을 것 같으냐, 오딘!", --
	Xylem = "집중의 눈동자를 내가 통제하는 한, 아제로스의 지맥에 흐르는 비전 마력은 모두 위대한 이 나에게로 흘러 들어온다!" -- 너무 늦었다!
})
