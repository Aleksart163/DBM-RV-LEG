if GetLocale() ~= "koKR" then return end

local L

---------------
-- Odyn --
---------------
L= DBM:GetModLocalization(1819)

---------------------------
-- Guarm --
---------------------------
L= DBM:GetModLocalization(1830)

L:SetOptionLocalization({
	YellActualRaidIcon		= "거품에 걸렸을 때 나오는 DBM 대화 알림을 일치하는 디버프 색상 대신 플레이어에게 설정된 아이콘 표시로 변경 (공대장 권한 필요)",
	FilterSameColor			= "거품이 맞는 브레스와 같은 색이면 아이콘 설정, 대화창 알림, 특수 경고 안함"
})

---------------------------
-- Helya --
---------------------------
L= DBM:GetModLocalization(1829)

L:SetTimerLocalization({
	OrbsTimerText		= "다음 구슬 (%d-%s)"
})

L:SetMiscLocalization({
	phaseThree =	"발버둥쳐 봐야 소용 없다, 필멸자여! 오딘은 풀려나지 않아!",
	near =			"가까운",
	far =			"먼",
	multiple =		"양쪽"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("TrialofValorTrash")

L:SetGeneralLocalization({
	name =	"용맹의 시험 일반몹"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetMiscLocalization({
	RP1 = "용사들아! 너흰 헬리아의 하수인들의 피를 쏟았다. 이제 헬하임으로 직접 들어가, 그 바다 마녀의 공포 통치를 끝내야 한다. 하지만 그 전에... 최후의 시험이다!"
})
