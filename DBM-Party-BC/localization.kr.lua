if GetLocale() ~= "koKR" then return end
local L

---------------------------
--  The Shattered Halls  --
--------------------------------
--  Grand Warlock Nethekurse  --
--------------------------------
L = DBM:GetModLocalization(566)

--------------------------
--  Blood Guard Porung  --
--------------------------
L = DBM:GetModLocalization(728)

--------------------------
--  Warbringer O'mrogg  --
--------------------------
L = DBM:GetModLocalization(568)

----------------------------------
--  Warchief Kargath Bladefist  --
----------------------------------
L = DBM:GetModLocalization(569)

------------------
--  Slave Pens  --
--------------------------
--  Mennu the Betrayer  --
--------------------------
L = DBM:GetModLocalization(570)

---------------------------
--  Rokmar the Crackler  --
---------------------------
L = DBM:GetModLocalization(571)

------------------
--  Quagmirran  --
------------------
L = DBM:GetModLocalization(572)

---------
--Trash--
---------
L = DBM:GetModLocalization("TSPTrash")

L:SetGeneralLocalization({
	name = "강제 노역소 일반몹"
})

------------------
--  Mana-Tombs  --
-------------------
--  Pandemonius  --
-------------------
L = DBM:GetModLocalization(534)

---------------
--  Tavarok  --
---------------
L = DBM:GetModLocalization(535)

----------------------------
--  Nexus-Prince Shaffar  --
----------------------------
L = DBM:GetModLocalization(537)

-----------
--  Yor  --
-----------
L = DBM:GetModLocalization(536)

------------------------
--  The Black Morass  --
------------------------
--  Chrono Lord Deja  --
------------------------
L = DBM:GetModLocalization(552)

----------------
--  Temporus  --
----------------
L = DBM:GetModLocalization(553)

--------------
--  Aeonus  --
--------------
L = DBM:GetModLocalization(554)

L:SetMiscLocalization({
    AeonusFrenzy	= "%s|1이;가; 광란의 상태에 빠집니다!"--확인필요
})

---------------------
--  Portal Timers  --
---------------------
L = DBM:GetModLocalization("PT")

L:SetGeneralLocalization({
	name = "검은 늪: 차원문"
})

L:SetWarningLocalization({
    WarnWavePortalSoon	= "곧 다음 차원문",
    WarnWavePortal		= "차원문 #%d",
    WarnBossPortal		= "우두머리 등장"
})

L:SetTimerLocalization({
	TimerNextPortal		= "차원문 #%d"
})

L:SetOptionLocalization({
    WarnWavePortalSoon	= "다음 차원문 이전에 알림 보기",
    WarnWavePortal		= "차원문 알림 보기",
    WarnBossPortal		= "우두머리 등장 알림 보기",
	TimerNextPortal		= "우두머리 처치 이후 다음 차원문 바 보기",
	ShowAllPortalTimers	= "모든 차원문 바 보기(부정확함)"
})

L:SetMiscLocalization({
	PortalCheck			= "시간의 균열 열림: (%d+)/18",
	Shielddown			= "No! Damn this feeble, mortal coil!"--확인필요
})

--------------------
--  The Arcatraz  --
----------------------------
--  Zereketh the Unbound  --
----------------------------
L = DBM:GetModLocalization(548)

-----------------------------
--  Dalliah the Doomsayer  --
-----------------------------
L = DBM:GetModLocalization(549)

---------------------------------
--  Wrath-Scryer Soccothrates  --
---------------------------------
L = DBM:GetModLocalization(550)

-------------------------
--  Harbinger Skyriss  --
-------------------------
L = DBM:GetModLocalization(551)

L:SetMiscLocalization({
	Split			= "밤하늘의 무한한 별처럼 온 우주를 덮으리라!"
})

--------------------------
--  Magisters' Terrace  --
--------------------------
--  Selin Fireheart  --
-----------------------
L = DBM:GetModLocalization(530)

----------------
--  Vexallus  --
----------------
L = DBM:GetModLocalization(531)

--------------------------
--  Priestess Delrissa  --
--------------------------
L = DBM:GetModLocalization(532)

L:SetMiscLocalization({
--	DelrissaPull	= "저들을 밟아줘라.",
	DelrissaEnd		= "뭔가... 잘못됐어..."
})

------------------------------------
--  Kael'thas Sunstrider (Party)  --
------------------------------------
L = DBM:GetModLocalization(533)

L:SetMiscLocalization({
	KaelP2				= "세상을... 거꾸로... 뒤집어주마."
})
