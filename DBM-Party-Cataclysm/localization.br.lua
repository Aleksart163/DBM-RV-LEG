if GetLocale() ~= "ptBR" then return end

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
	RangeFrame	= "Exibir medidor de distância (5 metros)"
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

L:SetWarningLocalization{
	specWarnPhase2Soon	= "Fase 2 em 5 segundos"
}

L:SetOptionLocalization{
	specWarnPhase2Soon	= "Exibir aviso especial para fase 2 em breve (5 segundos)"
}

---------------------
--  The Stonecore  --
---------------------
-- Corborus --
--------------
L= DBM:GetModLocalization(110)

L:SetWarningLocalization({
	WarnEmerge		= "Emergir",
	WarnSubmerge	= "Submergir"
})

L:SetTimerLocalization({
	TimerEmerge		= "Próx. Emergir",
	TimerSubmerge	= "Próx. Submergir"
})

L:SetOptionLocalization({
	WarnEmerge		= "Exibir aviso para emergir",
	WarnSubmerge	= "Exibir aviso para submergir",
	TimerEmerge		= "Exibir cronógrafo para emergir",
	TimerSubmerge	= "Exibir cronógrafo para submergir",
	RangeFrame		= "Exibir medidor de distância (5 metros)"
})

--------------
-- Slabhide --
--------------
L= DBM:GetModLocalization(111)

L:SetWarningLocalization({
	WarnAirphase			= "Fase aérea",
	WarnGroundphase			= "Fase terrestre",
	specWarnCrystalStorm	= "Tempestade de Cristal - Proteja-se"
})

L:SetTimerLocalization({
	TimerAirphase			= "Próx. Fase aérea",
	TimerGroundphase		= "Próx. Fase terrestre"
})

L:SetOptionLocalization({
	WarnAirphase			= "Exibir aviso quando Couro-pétreo levanta voo",
	WarnGroundphase			= "Exibir aviso quando Couro-pétreo pousa",
	TimerAirphase			= "Exibir cronógrafo para próxima fase aérea",
	TimerGroundphase		= "Exibir cronógrafo para próxima fase terrestre",
	specWarnCrystalStorm	= "Exibir aviso especial para $spell:92265"
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
	Retract		= "%s retracts its cyclone shield!"
}

--------------
-- Altairus --
--------------
L= DBM:GetModLocalization(115)

L:SetOptionLocalization({
	BreathIcon	= DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(88308)
})

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
	TimerFlarecoreDetonate	= "Flamífero explode"
}

L:SetOptionLocalization{
	TimerFlarecoreDetonate	= "Exibir cronógrafo para detonação de $spell:101927"
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
