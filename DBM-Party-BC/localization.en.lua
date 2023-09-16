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
	name = "The Slave Pens Trash"
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
    AeonusFrenzy	= "%s goes into a frenzy!"
})

---------------------
--  Portal Timers  --
---------------------
L = DBM:GetModLocalization("PT")

L:SetGeneralLocalization({
	name = "Portal Timers (CoT)"
})

L:SetWarningLocalization({
    WarnWavePortalSoon	= "New portal soon",
    WarnWavePortal		= "Portal %d",
    WarnBossPortal		= "Boss incoming"
})

L:SetTimerLocalization({
	TimerNextPortal		= "Portal %d"
})

L:SetOptionLocalization({
    WarnWavePortalSoon	= "Show pre-warning for new portal",
    WarnWavePortal		= "Show warning for new portal",
    WarnBossPortal		= "Show warning for boss incoming",
	TimerNextPortal		= "Show timer for next portal (after Boss)",
	ShowAllPortalTimers	= "Show timers for all portals (inaccurate)"
})

L:SetMiscLocalization({
	Shielddown			= "No! Damn this feeble, mortal coil!"
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
	Split	= "We span the universe, as countless as the stars!"
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
	DelrissaEnd		= "Not what I had... planned."
})

------------------------------------
--  Kael'thas Sunstrider (Party)  --
------------------------------------
L = DBM:GetModLocalization(533)

L:SetMiscLocalization({
	KaelP2	= "I'll turn your world... upside... down."
})
