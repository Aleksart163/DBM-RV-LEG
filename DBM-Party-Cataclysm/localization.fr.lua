if GetLocale() ~= "frFR" then return end

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
	RangeFrame	= "Afficher la fenêtre de portée (5 mêtres)"
}

----------
-- Augh --
----------
L = DBM:GetModLocalization("Augh")

L:SetGeneralLocalization({
	name = "Augh"		-- he is fightable after Lockmaw :o
})

------------------------
-- High Prophet Barim --
------------------------
L= DBM:GetModLocalization(119)

------------------------------------
-- Siamat, Lord of the South Wind --
------------------------------------
L= DBM:GetModLocalization(122)

---------------------
--  The Stonecore  --
---------------------
-- Corborus --
--------------
L= DBM:GetModLocalization(110)

L:SetWarningLocalization({
	WarnEmerge	= "Surgit",
	WarnSubmerge	= "S'enterre"
})

L:SetTimerLocalization({
	TimerEmerge	= "Surgit",
	TimerSubmerge	= "S'enterre"
})

L:SetOptionLocalization({
	WarnEmerge	= "Afficher l'alerte lorsqu'il surgit",
	WarnSubmerge	= "Afficher l'alerte lorsqu'il s'enterre",
	TimerEmerge	= "Afficher le temps lorsqu'il surgit",
	TimerSubmerge	= "Afficher le temps lorsqu'il s'enterre"
})

--------------
-- Slabhide --
--------------
L= DBM:GetModLocalization(111)

L:SetWarningLocalization({
	specWarnCrystalStorm		= "Tempête de cristal - Cachez vous derrière les pierres !"
})

L:SetOptionLocalization({
	specWarnCrystalStorm		= "Afficher une alerte spéciale pour le sort $spell:92265"
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

--------------
-- Altairus --
--------------
L= DBM:GetModLocalization(115)

L:SetOptionLocalization({
	BreathIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(88308)
})

-----------
-- Asaad --
-----------
L= DBM:GetModLocalization(116)

L:SetMiscLocalization({
	YellProshlyapMurchal = "Al'Akir, ton serviteur implore ton aide !"
})

-------------
--Треш-мобы--
-------------
L = DBM:GetModLocalization("TVPTrash")

L:SetGeneralLocalization({
	name =	"La cime du Vortex Trash"
})

---------------------------
--  The Throne of Tides  --
---------------------------
-- Lady Naz'jar --
------------------
L= DBM:GetModLocalization(101)

-----======-----------
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
	TimerFlarecoreDetonate	= "Flarecore detonate"
}

L:SetOptionLocalization{
	TimerFlarecoreDetonate	= "Show timer for $spell:101927 detonate"
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
	Kill		= "You know not what you have done. Aman'Thul... What I... have... seen..."
}
