if GetLocale() ~= "deDE" then return end

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
	RangeFrame	= "Zeige Abstandsfenster (5m)"
}

----------
-- Augh --
----------
L = DBM:GetModLocalization("Augh")

L:SetGeneralLocalization({
	name = "Augh"
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
	specWarnPhase2Soon	= "Phase 2 in 5 Sekunden"
}

L:SetOptionLocalization{
	specWarnPhase2Soon	= "Spezialwarnung für baldige Phase 2 (5 Sekunden)"
}

---------------------
--  The Stonecore  --
---------------------
-- Corborus --
--------------
L= DBM:GetModLocalization(110)

L:SetWarningLocalization({
	WarnEmerge		= "Auftauchen",
	WarnSubmerge	= "Abtauchen"
})

L:SetTimerLocalization({
	TimerEmerge		= "Nächstes Auftauchen",
	TimerSubmerge	= "Nächstes Abtauchen"
})

L:SetOptionLocalization({
	WarnEmerge		= "Zeige Warnung für Auftauchen",
	WarnSubmerge	= "Zeige Warnung für Abtauchen",
	TimerEmerge		= "Zeige Zeit bis Auftauchen",
	TimerSubmerge	= "Zeige Zeit bis Abtauchen",
	RangeFrame		= "Zeige Abstandsfenster (5m)"
})

--------------
-- Slabhide --
--------------
L= DBM:GetModLocalization(111)

L:SetWarningLocalization({
	WarnAirphase			= "Luftphase",
	WarnGroundphase			= "Bodenphase",
	specWarnCrystalStorm	= "Kristallsturm - Geh in Deckung"
})

L:SetTimerLocalization({
	TimerAirphase			= "Nächste Luftphase",
	TimerGroundphase		= "Nächste Bodenphase"
})

L:SetOptionLocalization({
	WarnAirphase			= "Zeige Warnung, wenn Plattenhaut abhebt",
	WarnGroundphase			= "Zeige Warnung, wenn Plattenhaut landet",
	TimerAirphase			= "Zeige Zeit bis nächste Luftphase",
	TimerGroundphase		= "Zeige Zeit bis nächste Bodenphase",
	specWarnCrystalStorm	= "Spezialwarnung für $spell:92265"
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
	Retract		= "%s zieht sein Wirbelsturmschild zurück!"
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
	TimerPhase		= "Phase 2"
}

L:SetOptionLocalization{
	TimerPhase		= "Zeige Zeit bis Phase 2"
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
	TimerFlarecoreDetonate	= "Flammenkern detoniert"
}

L:SetOptionLocalization{
	TimerFlarecoreDetonate	= "Zeige Zeit bis $spell:101927 detoniert"
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
	Kill		= "Ihr wisst nicht, was Ihr getan habt. Aman'Thul... Was ich... gesehen... habe..."
}
