if GetLocale() ~= "koKR" then return end

local L

------------------
--  Grim Batol  --
---------------------
-- General Umbriss --
---------------------
L= DBM:GetModLocalization(131)

--------------------------
-- Forgemaster Throngus --
--------------------------
L= DBM:GetModLocalization(132)

-------------------------
-- Drahga Shadowburner --
-------------------------
L= DBM:GetModLocalization(133)

------------
-- Erudax --
------------
L= DBM:GetModLocalization(134)

--------------------------------
--  Lost City of the Tol'vir  --
--------------------------------
-- General Husam --
-------------------
L= DBM:GetModLocalization(117)

--------------
-- Lockmaw --
--------------
L= DBM:GetModLocalization(118)

L:SetOptionLocalization{
	RangeFrame	= "거리 창 보기(5m)"
}

----------
-- Augh --
----------
L = DBM:GetModLocalization("Augh")

L:SetGeneralLocalization({
	name = "오우"
})

------------------------
-- High Prophet Barim --
------------------------
L= DBM:GetModLocalization(119)

------------------------------------
-- Siamat, Lord of the South Wind --
------------------------------------
L= DBM:GetModLocalization(122)

L:SetWarningLocalization{
	specWarnPhase2Soon	= "5초 후 2 단계 시작!"
}

L:SetOptionLocalization{
	specWarnPhase2Soon	= "2 단계 이전에 특수 경고 보기"
}

---------------------
--  The Stonecore  --
---------------------
-- Corborus --
--------------
L= DBM:GetModLocalization(110)

L:SetWarningLocalization({
	WarnEmerge		= "등장",
	WarnSubmerge	= "잠수"
})

L:SetTimerLocalization({
	TimerEmerge		= "다음 등장",
	TimerSubmerge	= "다음 잠수"
})

L:SetOptionLocalization({
	WarnEmerge		= "등장 알림 보기",
	WarnSubmerge	= "잠수 알림 보기",
	TimerEmerge		= "다음 등장 바 보기",
	TimerSubmerge	= "다음 잠수 바 보기",
	RangeFrame		= "거리 창 보기(5m)"
})

--------------
-- Slabhide --
--------------
L= DBM:GetModLocalization(111)

L:SetWarningLocalization({
	WarnAirphase				= "공중 단계",
	WarnGroundphase				= "지상 단계",
	specWarnCrystalStorm		= "수정 폭풍 - 숨으세요!"
})

L:SetTimerLocalization({
	TimerAirphase				= "다음 공중 단계",
	TimerGroundphase			= "다음 지상 단계"
})

L:SetOptionLocalization({
	WarnAirphase				= "공중 단계 알림 보기",
	WarnGroundphase				= "지상 단계 알림 보기",
	TimerAirphase				= "다음 공중 단계 바 보기",
	TimerGroundphase			= "다음 지상 단계 바 보기",
	specWarnCrystalStorm		= "$spell:92265 특수 경고 보기"
})

-----------
-- Ozruk --
-----------
L= DBM:GetModLocalization(112)

-------------------------
-- High Priestess Azil --
------------------------
L= DBM:GetModLocalization(113)

---------------------------
--  The Vortex Pinnacle  --
---------------------------
-- Grand Vizier Ertan --
------------------------
L= DBM:GetModLocalization(114)

L:SetMiscLocalization{
	Retract		= "회오리 방패를 가까이 끌어당깁니다!"
}

--------------
-- Altairus --
--------------
L= DBM:GetModLocalization(115)

-----------
-- Asaad --
-----------
L= DBM:GetModLocalization(116)

---------------------------
--  The Throne of Tides  --
---------------------------
-- Lady Naz'jar --
------------------
L= DBM:GetModLocalization(101)

----------------------
-- Commander Ulthok --
----------------------
L= DBM:GetModLocalization(102)

-------------------------
-- Erunak Stonespeaker --
-------------------------
L= DBM:GetModLocalization(103)

------------
-- Ozumat --
------------
L= DBM:GetModLocalization(104)

L:SetTimerLocalization{
	TimerPhase		= "2 단계"
}

L:SetOptionLocalization{
	TimerPhase		= "2 단계 바 보기"
}

----------------
--  End Time  --
-------------------
-- Echo of Baine --
-------------------
L= DBM:GetModLocalization(340)

-------------------
-- Echo of Jaina --
-------------------
L= DBM:GetModLocalization(285)

L:SetTimerLocalization{
	TimerFlarecoreDetonate	= "섬광핵 폭발"
}

L:SetOptionLocalization{
	TimerFlarecoreDetonate	= "$spell:101927 폭발 바 보기"
}

----------------------
-- Echo of Sylvanas --
----------------------
L= DBM:GetModLocalization(323)

---------------------
-- Echo of Tyrande --
---------------------
L= DBM:GetModLocalization(283)

--------------
-- Murozond --
--------------
L= DBM:GetModLocalization(289)

L:SetMiscLocalization{
	Kill		= "넌 네가 무슨 짓을 저지르는지 모른다. 아만툴... 내가... 본... 것은..."
}
