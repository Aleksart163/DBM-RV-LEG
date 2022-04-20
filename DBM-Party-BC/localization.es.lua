if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

-------------------------
-- Las Salas Arrasadas --
-------------------------
----------------------------
-- Brujo supremo Malbisal --
----------------------------
L = DBM:GetModLocalization(566)

------------------------------
-- Guardia de sangre Porung --
------------------------------
L = DBM:GetModLocalization(728)

-----------------------
-- Belisario O'mrogg --
-----------------------
L = DBM:GetModLocalization(568)

-------------------------
-- Kargath Garrafilada --
-------------------------
L = DBM:GetModLocalization(569)

-----------------------------
-- Recinto de los Esclavos --
-----------------------------
----------------------
-- Mennu el Traidor --
----------------------
L = DBM:GetModLocalization(570)

------------------------
-- Rokmar el Crujidor --
------------------------
L = DBM:GetModLocalization(571)

----------------
-- Quagmirran --
----------------
L = DBM:GetModLocalization(572)

--------------------
-- Tumbas de Maná --
--------------------
-----------------
-- Pandemonius --
-----------------
L = DBM:GetModLocalization(534)

-------------
-- Tavarok --
-------------
L = DBM:GetModLocalization(535)

---------------------------
-- Príncipe-nexo Shaffar --
---------------------------
L = DBM:GetModLocalization(537)

---------
-- Yor --
---------
L = DBM:GetModLocalization(536)

----------------------
-- La Ciénaga Negra --
----------------------
--------------------
-- Cronolord Deja --
--------------------
L = DBM:GetModLocalization(552)

--------------
-- Temporus --
--------------
L = DBM:GetModLocalization(553)

------------
-- Aeonus --
------------
L = DBM:GetModLocalization(554)

L:SetMiscLocalization({
    AeonusFrenzy	= "¡%s entra en Frenesí!"
})

--------------------------------
-- Temporizadores de portales --
--------------------------------
L = DBM:GetModLocalization("PT")

L:SetGeneralLocalization({
	name = "Temporizadores de portales"
})

L:SetWarningLocalization({
    WarnWavePortalSoon	= "Siguiente portal en breve",
    WarnWavePortal		= "Portal %d",
    WarnBossPortal		= "Jefe en breve"
})

L:SetTimerLocalization({
	TimerNextPortal		= "Portal %d"
})

L:SetOptionLocalization({
    WarnWavePortalSoon	= "Mostrar aviso previo para el siguiente portal",
    WarnWavePortal		= "Mostrar aviso cuando aparezca un portal",
    WarnBossPortal		= "Mostrar aviso previo para el siguiente jefe",
	TimerNextPortal		= "Mostrar temporizador para el siguiente portal (después de jefe)",
	ShowAllPortalTimers	= "Mostrar temporizadores para todos los portales (impreciso)"
})

L:SetMiscLocalization({
	PortalCheck			= "Grietas en el Tiempo abiertas: (%d+)/18",
	Shielddown			= "¡No...malditos sean estos débiles mortales...!"
})

-----------------
-- El Arcatraz --
-----------------
--------------------------
-- Zereketh el Desatado --
--------------------------
L = DBM:GetModLocalization(548)

---------------------------------
-- Dalliah la Oradora del Sino --
---------------------------------
L = DBM:GetModLocalization(549)

------------------
-- Soccothrates --
------------------
L = DBM:GetModLocalization(550)

------------------------
-- Presagista Cieloriss --
------------------------
L = DBM:GetModLocalization(551)

L:SetMiscLocalization({
	Split	= "¡Abarcamos el universo, somos tantos como las estrellas!"
})

-------------------------
-- Bancal del Magister --
-------------------------
----------------------------
-- Selin Corazón de Fuego --
----------------------------
L = DBM:GetModLocalization(530)

--------------
-- Vexallus --
--------------
L = DBM:GetModLocalization(531)

--------------------------
-- Sacerdotisa Delrissa --
--------------------------
L = DBM:GetModLocalization(532)

L:SetMiscLocalization({
	DelrissaPull	= "Aniquiladlos.",
	DelrissaEnd		= "Esto no lo había planeado."
})

---------------
-- Kael'thas --
---------------
L = DBM:GetModLocalization(533)

L:SetMiscLocalization({
	KaelP2	= "Pondré vuestro mundo... cabeza... abajo."
})
