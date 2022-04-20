if GetLocale() ~= "zhCN" then return end
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
    AeonusFrenzy	= "%s被激怒了!"
})

---------------------
--  Portal Timers  --
---------------------
L = DBM:GetModLocalization("PT")

L:SetGeneralLocalization({
	name = "时间裂隙(時光洞穴)"
})

L:SetWarningLocalization({
    WarnWavePortalSoon	= "新的时间裂隙即将到来",
    WarnWavePortal		= "第%d个时间裂隙",
    WarnBossPortal		= "首领到来"
})

L:SetTimerLocalization({
	TimerNextPortal		= "第%d个时间裂隙"
})

L:SetOptionLocalization({
    WarnWavePortalSoon	= "为新的时间裂隙显示预先警告",
    WarnWavePortal		= "为新的时间裂隙显示警告",
    WarnBossPortal		= "为首领到来显示警告",
	TimerNextPortal		= "为下一次时间裂隙显示计时器(击败首领后)",
	ShowAllPortalTimers	= "为所有时间裂隙显示计时器(不准确)"
})

L:SetMiscLocalization({
	PortalCheck			= "时间裂隙开启:(%d+)/18",
	Shielddown			= "这个该死的躯体既虛弱又平凡!"
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
	Split	= "我们跨越宇宙之间，被我们摧毁的世界像星星一样数不尽!"
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
--	DelrissaPull	= "Annihilate them.",
	DelrissaEnd		= "跟我计划的...不一样。"
})

------------------------------------
--  Kael'thas Sunstrider (Party)  --
------------------------------------
L = DBM:GetModLocalization(533)

L:SetMiscLocalization({
	KaelP2	= "我要让你们的世界彻底颠覆。"
})
