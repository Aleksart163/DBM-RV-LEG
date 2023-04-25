if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L

----------------
-- Grim Batol --
----------------
---------------------
-- General Umbriss --
---------------------
L= DBM:GetModLocalization(131)

-------------------------------
-- Maestro de forja Throngus --
-------------------------------
L= DBM:GetModLocalization(132)

-------------------------
-- Drahga Quemasombras --
-------------------------
L= DBM:GetModLocalization(133)

-------------------------------------------
-- Erudax, el Duque de las profundidades --
-------------------------------------------
L= DBM:GetModLocalization(134)

-----------------------------------
-- Ciudad Perdida de los Tol'vir --
-----------------------------------
-------------------
-- General Husam --
-------------------
L= DBM:GetModLocalization(117)

-----------------
-- Cierrafauce --
-----------------
L= DBM:GetModLocalization(118)

L:SetOptionLocalization{
	RangeFrame	= "Mostrar marco de distancia (5 m)"
}

----------
-- Augh --
----------
L = DBM:GetModLocalization("Augh")

L:SetGeneralLocalization({
	name = "Augh"		-- he is fightable after Lockmaw :o
})

------------------------
-- Sumo profeta Barim --
------------------------
L= DBM:GetModLocalization(119)

------------
-- Siamat --
------------
L= DBM:GetModLocalization(122)

L:SetWarningLocalization{
	specWarnPhase2Soon	= "Fase 2 en 5 s"
}

L:SetOptionLocalization{
	specWarnPhase2Soon	= "Mostrar aviso especial 5 s antes de la fase 2"
}

----------------------
-- El Núcleo Pétreo --
----------------------
--------------
-- Corborus --
--------------
L= DBM:GetModLocalization(110)

L:SetWarningLocalization({
	WarnEmerge		= "Corborus ha regresado",
	WarnSubmerge	= "Corborus se sumerge"
})

L:SetTimerLocalization({
	TimerEmerge		= "Emersión",
	TimerSubmerge	= "Sumersión"
})

L:SetOptionLocalization({
	WarnEmerge		= "Mostrar aviso cuando Corborus regrese a la superficie",
	WarnSubmerge	= "Mostrar aviso cuando Corborus se sumerja en la tierra",
	TimerEmerge		= "Mostrar temporizador para cuando Corborus regrese a la superficie",
	TimerSubmerge	= "Mostrar temporizador para cuando Corborus se sumerja en la tierra",
	RangeFrame		= "Mostrar marco de distancia (5 m)"
})

----------------
-- Pielpétrea --
----------------
L= DBM:GetModLocalization(111)

L:SetWarningLocalization({
	WarnAirphase			= "Fase aérea",
	WarnGroundphase			= "Fase en tierra",
	specWarnCrystalStorm	= "Tormenta de cristales - ¡ponte a cubierto!"
})

L:SetTimerLocalization({
	TimerAirphase			= "Siguiente fase aérea",
	TimerGroundphase		= "Siguiente fase en tierra"
})

L:SetOptionLocalization({
	WarnAirphase			= "Mostrar aviso cuando Pielpétrea se eleve",
	WarnGroundphase			= "Mostrar aviso cuando Pielpétrea aterrice",
	TimerAirphase			= "Mostrar temporizador para la siguiente fase aérea",
	TimerGroundphase		= "Mostrar temporizador para la siguiente fase en tierra",
	specWarnCrystalStorm	= "Mostrar aviso especial para $spell:92265"
})

-----------
-- Ozruk --
-----------
L= DBM:GetModLocalization(112)

-------------------------
-- Suma sacerdotisa Azil --
------------------------
L= DBM:GetModLocalization(113)

---------------------------
-- La Cumbre del Vórtice --
---------------------------
----------------------
-- Gran visir Ertan --
----------------------
L= DBM:GetModLocalization(114)

L:SetMiscLocalization{
	Retract		= "¡%s retira su Escudo de ciclón!"
}

--------------
-- Altairus --
--------------
L= DBM:GetModLocalization(115)

L:SetOptionLocalization({
	BreathIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(88308)
})

----------------------------------
-- Asaad, califa de los Céfiros --
----------------------------------
L= DBM:GetModLocalization(116)

if GetLocale() == "esES" then
L:SetMiscLocalization({
	YellProshlyapMurchal = "¡Al'Akir, tu siervo reclama tu ayuda!"
})
else
L:SetMiscLocalization({
	YellProshlyapMurchal = "¡Al'Akir, tu sirviente te necesita!"
})
end

-------------
--Треш-мобы--
-------------
L = DBM:GetModLocalization("TVPTrash")

L:SetGeneralLocalization({
	name = "Enemigos menores"
})

---------------------------
--  Trono de las Mareas  --
---------------------------
-- Lady Naz'jar --
------------------
L= DBM:GetModLocalization(101)

-----------------------
-- Comandante Ulthok --
-----------------------
L= DBM:GetModLocalization(102)

---------------------------
-- Dominamentes Ghur'sha --
---------------------------
L= DBM:GetModLocalization(103)

------------
-- Ozumat --
------------
L= DBM:GetModLocalization(104)

L:SetTimerLocalization{
	TimerPhase		= "Fase 2"
}

L:SetOptionLocalization{
	TimerPhase		= "Mostrar temporizador para fase 2"
}

---------------------
-- Fin de los Días --
---------------------
------------------
-- Eco de Baine --
------------------
L= DBM:GetModLocalization(340)

------------------
-- Eco de Jaina --
------------------
L= DBM:GetModLocalization(285)

L:SetTimerLocalization{
	TimerFlarecoreDetonate	= "Bengala del Núcleo explota"
}

L:SetOptionLocalization{
	TimerFlarecoreDetonate	= "Mostrar temporizador para cuando explote $spell:101927"
}

---------------------
-- Eco de Sylvanas --
---------------------
L= DBM:GetModLocalization(323)

--------------------
-- Eco de Tyrande --
--------------------
L= DBM:GetModLocalization(283)

--------------
-- Murozond --
--------------
L= DBM:GetModLocalization(289)

L:SetMiscLocalization{
	Kill		= "No tenéis ni idea de lo que habéis hecho. Aman'Thul... Lo que... he... visto..."
}
