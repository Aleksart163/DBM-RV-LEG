if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L
--------------------------------------------WARNING---------------------------------------------------
--Do you want to help translate this module to your native language? Write to the author of this addon
--Aleksart163#1671 (discord)
--/w Tielle or /w Куплиняшка (in the game)
--------------------------------------------WARNING---------------------------------------------------

-------------------------
-- Rompemundos garothi --
-------------------------
L= DBM:GetModLocalization(1992)

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})
--[[
L:SetMiscLocalization({
	YellPullGarothi = "Enemigos detectados. Nivel de amenaza: mínimo."
})
--]]

---------------------------------
-- Canes manáfagos de Sargeras --
---------------------------------
L= DBM:GetModLocalization(1987)

L:SetOptionLocalization({
	SequenceTimers =	"Secuenciar los temporizadores en función al último lanzamiento de cada habilidad en lugar del siguiente para reducir el desajuste de temporizadores a cambio de una leve pérdida de precisión (uno o dos segundos de margen de error)"
})

------------------------
-- Alto Mando antoran --
------------------------
L= DBM:GetModLocalization(1997)
--[[
L:SetMiscLocalization({
	YellPullCouncil	= "Que os quede claro: no saldréis con vida de esta batalla."
})
--]]

----------------------------------
-- Eonar, la Patrona de la Vida --
----------------------------------
L= DBM:GetModLocalization(2025)

L:SetTimerLocalization({
	timerObfuscator		=	"Ofuscador (%s)",
	timerDestructor 	=	"Destructor (%s)",
	timerPurifier 		=	"Purificador (%s)",
	timerBats	 		=	"Murciélagos (%s)"
})

L:SetOptionLocalization({
	timerObfuscator		=	DBM_CORE_AUTO_TIMER_OPTIONS["cdcount"]:format("ej16501"),
	timerDestructor 	=	DBM_CORE_AUTO_TIMER_OPTIONS["cdcount"]:format("ej16502"),
	timerPurifier 		=	DBM_CORE_AUTO_TIMER_OPTIONS["cdcount"]:format("ej16500"),
	timerBats	 		=	DBM_CORE_AUTO_TIMER_OPTIONS["cdcount"]:format("ej17039")
})

if GetLocale() == "esES" then
L:SetMiscLocalization({
	YellPullEonar = "¡Campeones! ¡Las fuerzas de la Legión buscan capturar mi esencia para su maestro infernal!", --
	Obfuscators =	"Ofuscador",
	Destructors =	"Destructor",
	Purifiers 	=	"Purificador",
	Bats 		=	"Murciélagos",
	EonarHealth	= 	"Salud de Eonar",
	EonarPower	= 	"Energía de Eonar",
	NextLoc		=	"Siguiente:"
})
else
L:SetMiscLocalization({
	YellPullEonar = "¡Campeones! ¡Las fuerzas de la Legión quieren capturar mi esencia para su amo infernal!", --
	Obfuscators =	"Ofuscador",
	Destructors =	"Destructor",
	Purifiers 	=	"Purificador",
	Bats 		=	"Murciélagos",
	EonarHealth	= 	"Salud de Eonar",
	EonarPower	= 	"Energía de Eonar",
	NextLoc		=	"Siguiente:"
})
end

---------------------------------
-- Vigilante de portal Hasabel --
---------------------------------
L= DBM:GetModLocalization(1985)

L:SetOptionLocalization({
	ShowAllPlatforms =	"Mostrar todos los avisos independientemente de tu plataforma actual"
})

--[[L:SetMiscLocalization({
	YellPullHasabel = "Ха! Так это и есть лучшие из защитников Азерота?",
	YellPullHasabel2 = "Ваш поход закончится здесь.",
	YellPullHasabel3 = "Легион сокрушает всех своих врагов!",
	YellPullHasabel4 = "Нам покорились все миры. Ваш – следующий."
})]]

--------------------------------
-- Imonar el Cazador de Almas --
--------------------------------
L= DBM:GetModLocalization(2009)

L:SetMiscLocalization({
	DispelMe = "¡Disipadme!"
})

----------------
-- Kin'garoth --
----------------
L= DBM:GetModLocalization(2004)

L:SetOptionLocalization({
	InfoFrame =	"Mostrar marco de información con una vista general del combate",
	UseAddTime = "Mostrar temporizadores de la fase de despligue durante la fase de construcción"
})

-----------------
-- Varimathras --
-----------------
L= DBM:GetModLocalization(1983)

------------------------
-- Aquelarre shivarra --
------------------------
L= DBM:GetModLocalization(1986)
--[[
L:SetWarningLocalization({
	Amantul = "Мучения Аман`тула через 5 сек - переключитесь",
	Norgannon = "Мучения Норганнона через 5 сек - бегите в центр",
	Golgannet = "Мучения Голганнета через 5 сек - держите радиус 2м",
	Kazgagot = "Мучения Каз`горота через 5 сек - уйдите с центра"
})]]

L:SetTimerLocalization({
	timerBossIncoming = DBM_INCOMING,
	timerAmanThul = "Tormento de Aman'thul",
	timerKhazgoroth = "Tormento de Khaz'goroth",
	timerNorgannon = "Tormento de Norgannon",
	timerGolganneth = "Tormento de Golganneth"
})

L:SetOptionLocalization({
	timerBossIncoming	= "Mostrar temporizador para el siguiente cambio de jefe",
	TauntBehavior		= "Patrón de avisos para el cambio de tanque",
	TwoMythicThreeNon	= "Cambiar a dos acumulaciones en mítico, tres en otras dificultades",--Default
	TwoAlways			= "Cambiar a dos acumulaciones en todas las dificultades",
	ThreeAlways			= "Cambiar a tres acumulaciones en todas las dificultades",
	SetLighting			= "Bajar automáticamente la calidad de iluminación a bajo al iniciar el combate (se restaurará a su configuración anterior al terminar el combate; no funciona en Mac)",
	InterruptBehavior	= "Patrón de interrupcionesS (requiere ser líder de banda)",
	Three				= "Rotación de tres jugadores",--Default
	Four				= "Rotación de cuatro jugadores",
	Five				= "Rotación de cinco jugadores",
	IgnoreFirstKick		= "Excluir la primera interrupción de la rotación (requiere ser líder de banda)",
	timerAmanThul 		= "Mostrar temporizador para el lanzamiento de $spell:250335",
	timerKhazgoroth 	= "Mostrar temporizador para el lanzamiento de $spell:250333",
	timerNorgannon 		= "Mostrar temporizador para el lanzamiento de $spell:250334",
	timerGolganneth 	= "Mostrar temporizador para el lanzamiento de $spell:249793"
})

--------------
-- Aggramar --
--------------
L= DBM:GetModLocalization(1984)

L:SetOptionLocalization({
	ignoreThreeTank	= "Deshabilitar avisos especiales de provocar para Domaenemigos y Desgarro de llamas cuando haya tres o más tanques en el grupo de banda (DBM no puede determinar una rotación exacta con esa composición). Si muere uno de los tanques, los avisos se rehabilitan automáticamente."
})

L:SetMiscLocalization({
--	YellPullAggramar = "¡Arderéis!",
	Blaze		= "Llamarada voraz",
	Foe			= "Doma",
	Rend		= "Desgarro",
	Tempest 	= "Tempestad",
	Current		= "Actual:"
})

--------------------------
-- Argus el Aniquilador --
--------------------------
L= DBM:GetModLocalization(2031)

L:SetTimerLocalization({
	timerSargSentenceCD	= "Sentencia TdR (%s)"
})

L:SetOptionLocalization({
	timerSargSentenceCD		=	DBM_CORE_AUTO_TIMER_OPTIONS["cdcount"]:format(257966)
})

L:SetMiscLocalization({
--	YellPullArgus = "¡Muerte! ¡Muerte y dolor!",
	SeaText		= "Celeridad/Versatilidad en %s",
	SkyText		= "Crítico/Maestría en %s",
	Blight		= "Añublo",
	Burst		= "Ráfaga",
	Sentence	= "Sentencia",
	Bomb		= "Bomba",
	Blight2		= "Añublo en %s!",
	Burst2		= "Ráfaga en mí!",
--	Sentence2	= "Sentencia en %s!",
--	Bomb2		= "BOMBA DE ALMAS",
	Rage		= "IRA",
	Fear		= "MIEDO"
})

----------------------
-- Enemigos menores --
----------------------
L = DBM:GetModLocalization("AntorusTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})
--need translate
L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT,
	BossActivation = DBM_CORE_GENERIC_TIMER_ROLE_PLAY
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetMiscLocalization({
	RPImonar = "Halt!"
})
