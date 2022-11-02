if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L

-------------------------
-- Torreón Grajo Negro --
-------------------------

-----------------------
-- Amalgama de almas --
-----------------------
L= DBM:GetModLocalization(1518)

-----------------------------
-- Illysanna Cresta Cuervo --
-----------------------------
L= DBM:GetModLocalization(1653)

----------------------------
-- Atizarrabias el Odioso --
----------------------------
L= DBM:GetModLocalization(1664)

----------------------------------
-- Lord Kur'talos Cresta Cuervo --
----------------------------------
L= DBM:GetModLocalization(1672)

if GetLocale() == "esES" then
L:SetMiscLocalization({
	proshlyapMurchal = "¡Basta! Me estoy cansando." --
})
else
L:SetMiscLocalization({
	proshlyapMurchal = "¡Suficiente! Estoy cansado de esto." --
})
end

----------------------
-- Enemigos menores --
----------------------
L = DBM:GetModLocalization("BRHTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_DOOR_OPENING
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_DOOR_OPENING
})

if GetLocale() == "esES" then
L:SetMiscLocalization({
	RP1 = "Ahora... Ahora lo veo..." --
})
else
L:SetMiscLocalization({
	RP1 = "Ahora... ya veo..." --
})
end

-----------------------------
-- Arboleda Corazón Oscuro --
-----------------------------

-----------------------
-- Archidruida Glaidalis --
-----------------------
L= DBM:GetModLocalization(1654)

----------------------
-- Corazón de Roble --
----------------------
L= DBM:GetModLocalization(1655)

L:SetMiscLocalization({
	ThrowYell = "Lanzamiento en %s!"
})

--------------
-- Dresaron --
--------------
L= DBM:GetModLocalization(1656)

----------------------
-- Sombra de Xavius --
----------------------
L= DBM:GetModLocalization(1657)

L:SetMiscLocalization{
	ParanoiaYell = "%s en %s. ALEJAROS de mi!"
}

if GetLocale() == "esES" then
L:SetMiscLocalization({
	XavApoc = "Os consumiréis, lenta y dolorosamente.",
	XavApoc2 = "¡Destruiré vuestras débiles mentes!"
})
else
L:SetMiscLocalization({
	XavApoc = "Te apagarás lenta y dolorosamente.", --
	XavApoc2 = "¡Quebraré tu mente débil!" --
})
end

----------------------
-- Enemigos menores --
----------------------
L = DBM:GetModLocalization("DHTTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})

--------------------
-- Ojo de Azshara --
--------------------

--------------------------------
-- Señor de la guerra Parjesh --
--------------------------------
L= DBM:GetModLocalization(1480)

--------------------------
-- Lady Espiral de Odio --
--------------------------
L= DBM:GetModLocalization(1490)

-----------------------
-- Rey Barbaprofunda --
-----------------------
L= DBM:GetModLocalization(1491)

----------------
-- Serpentrix --
----------------
L= DBM:GetModLocalization(1479)

-----------------------
-- Cólera de Azshara --
-----------------------
L= DBM:GetModLocalization(1492)

----------------------
-- Enemigos menores --
----------------------
L = DBM:GetModLocalization("EoATrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})

---------------------
-- Salas del Valor --
---------------------

-----------------------
-- Hymdall --
-----------------------
L= DBM:GetModLocalization(1485)

if GetLocale() == "esES" then
L:SetMiscLocalization({
	proshlyapMurchal = "¡Una batalla excelente! El camino está despejado." --
})
else
L:SetMiscLocalization({
	proshlyapMurchal = "¡Una batalla bien peleada! El camino por delante está abierto." --
})
end

-----------------------
-- Hyrja --
-----------------------
L= DBM:GetModLocalization(1486)

------------
-- Fenryr --
------------
L= DBM:GetModLocalization(1487)

if GetLocale() == "esES" then
L:SetMiscLocalization({
	MurchalProshlyapOchko = "Herido, Fenryr se retira a su guarida." --
})
else
L:SetMiscLocalization({
	MurchalProshlyapOchko = "Herido, Fenryr se retira a su guarida." --
})
end

----------------------
-- Rey dios Skovald --
----------------------
L= DBM:GetModLocalization(1488)

----------
-- Odyn --
----------
L= DBM:GetModLocalization(1489)

----------------------
-- Enemigos menores --
----------------------
L = DBM:GetModLocalization("HoVTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT,
	BossActivation = DBM_CORE_GENERIC_TIMER_ROLE_PLAY
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

if GetLocale() == "esES" then
L:SetMiscLocalization({
	RPSolsten = "¡Vuestra presencia mancilla el ritual, mortales!", --
	RPSolsten2 = "Hyrja... ¡la furia de la tormenta está a tus órdenes!", --
	RPOlmyr = "¡No impediréis la ascensión de Hyrja!", --
	RPOlmyr2 = "Hyrja, ¡la Luz brilla eternamente en ti!", --
	RPSkovald = "¡No! Yo también he demostrado mi valía, Odyn. ¡Soy el rey dios Skovald! Estos mortales no me arrebatarán la égida.", --
	RPOdyn = "Impresionante. Nunca pensé que encontraría a alguien capaz de igualar la fuerza de los Valarjar... pero aquí estáis." --
})
else
L:SetMiscLocalization({
	RPSolsten = "¡Ensucian el ritual con su presencia, mortales!", --
	RPSolsten2 = "Hyrja... ¡la furia de las tormentas está bajo tus órdenes!", --
	RPOlmyr = "¡No negarás la ascensión de Hyrja!", --
	RPOlmyr2 = "¡La Luz brilla eternamente en ti, Hyrja!", --
	RPSkovald = "¡No! Yo también he probado mi valor. ¡Soy El Rey Divino Skovald! ¡Estos mortales no pueden desafiar mi petición por la égida!", --
	RPOdyn = "¡Qué impresionante! Nunca imaginé conocer a alguien que pudiera igualar la fuerza de Valarjar... y entonces, apareces tú." --
})
end

---------------------------
-- Guarida de Neltharion --
---------------------------

-------------
-- Rokmora --
-------------
L= DBM:GetModLocalization(1662)

--------------------------
-- Ularogg Formarriscos --
--------------------------
L= DBM:GetModLocalization(1665)

-------------
-- Naraxas --
-------------
L= DBM:GetModLocalization(1673)

--------------------------
-- Dargrul el Infrarrey --
--------------------------
L= DBM:GetModLocalization(1687)

----------------------
-- Enemigos menores --
----------------------
L = DBM:GetModLocalization("NLTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

if GetLocale() == "esES" then
L:SetMiscLocalization({
	RoleP1 = "¿Navarrogg? ¡Traidor! ¿Osas liderar a los intrusos contra nosotros?"
})
else
L:SetMiscLocalization({
	RoleP1 = "¡¿Navarrogg?! ¡Traidor! ¿Has conducido a estos intruso hasta nosotros?"
})
end

-----------------
-- La Arquería --
-----------------

------------
-- Ivanyr --
------------
L= DBM:GetModLocalization(1497)

---------------
-- Corstilax --
---------------
L= DBM:GetModLocalization(1498)

-------------------
-- General Xakal --
-------------------
L= DBM:GetModLocalization(1499)

--------------
-- Nal'tira --
--------------
L= DBM:GetModLocalization(1500)

-----------------------
-- Consejero Vandros --
-----------------------
L= DBM:GetModLocalization(1501)

if GetLocale() == "esES" then
L:SetMiscLocalization({
	RPVandros = "¡Ya basta! ¡Os estáis descontrolando, pequeñas bestias!"
})
else
L:SetMiscLocalization({
	RPVandros = "¡Suficiente! ¡Pequeñas bestias incontrolables!"
})
end

----------------------
-- Enemigos menores --
----------------------
L = DBM:GetModLocalization("ArcwayTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})

----------------------------
-- Corte de las Estrellas --
----------------------------

----------------------------------
-- Capitán de patrulleros Gerdo --
----------------------------------
L= DBM:GetModLocalization(1718)

-----------------------------
-- Talixae Corona de Fuego --
-----------------------------
L= DBM:GetModLocalization(1719)

-------------------------
-- Consejero Melandrus --
-------------------------
L= DBM:GetModLocalization(1720)

----------------------
-- Enemigos menores --
----------------------
L = DBM:GetModLocalization("CoSTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})

L:SetWarningLocalization({
	warnSpy = "Se ha encontrado un espía"
})

L:SetOptionLocalization({
	YellOnEating = "Avisar, cuando alguien esta usando hechizo $spell:208585",
	YellOnSiphoningMagic = "Avisar, cuando alguien esta usando hechizo $spell:208427",
	YellOnPurifying = "Avisar, cuando alguien esta usando hechizo $spell:209767",
	YellOnDraining = "Avisar, cuando alguien esta usando hechizo $spell:208334",
	YellOnInvokingText = "Avisar, cuando alguien esta usando hechizo $spell:210872",
	YellOnDrinking = "Avisar, cuando alguien esta usando hechizo $spell:210307",
	YellOnReleaseSpores = "Avisar, cuando alguien esta usando hechizo $spell:208939",
	YellOnShuttingDown = "Avisar, cuando alguien esta usando hechizo $spell:208370",
	YellOnTreating = "Avisar, cuando alguien esta usando hechizo $spell:210925",
	YellOnPilfering = "Avisar, cuando alguien esta usando hechizo $spell:210217",
	YellOnDefacing = "Avisar, cuando alguien esta usando hechizo $spell:210330",
	YellOnTinkering = "Avisar, cuando alguien esta usando hechizo $spell:210922",
	warnSpy = "Avisar, cuando se descubre un espía",
	SpyHelper	= "Ayudar a encontrar al espía",
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

if GetLocale() == "esES" then
L:SetMiscLocalization({
	EatingYell = "[DBM RV] %s usando %s!",
	SiphoningMagic = "[DBM RV] %s usando %s!",
	PurifyingYell = "[DBM RV] %s usando %s!",
	DrainingYell = "[DBM RV] %s usando %s!",
	InvokingTextYell = "[DBM RV] %s usando %s!",
	DrinkingYell = "[DBM RV] %s usando %s!",
	ReleaseSporesYell = "[DBM RV] %s usando %s!",
	ShuttingDownYell = "[DBM RV] %s usando %s!",
	TreatingYell = "[DBM RV] %s usando %s!",
	PilferingYell = "[DBM RV] %s usando %s!",
	DefacingYell = "[DBM RV] %s usando %s!",
	TinkeringYell = "[DBM RV] %s usando %s!",
	--
	proshlyapMurchal = "¿Tan pronto nos abandonas, Gran Magistrix?",
	Gloves1			= "Dicen los rumores que el espía siempre lleva guantes.",
	Gloves2			= "He oído que el espía siempre lleva las manos enfundadas en guantes.",
	Gloves3			= "Hay quien dice que el espía lleva guantes para ocultar sus notables cicatrices.",
	Gloves4			= "He oído que el espía oculta sus manos con cuidado.",
	Gloves5			= false,
	Gloves6			= false,
	NoGloves1		= "Dicen los rumores que el espía nunca lleva guantes.",
	NoGloves2		= "Me encontré un par de guantes de más en la habitación trasera. Probablemente el espía se pasee por aquí con las manos desnudas.",
	NoGloves3		= "He oído que al espía no le gusta llevar guantes.",
	NoGloves4		= "He oído que el espía evita llevar guantes, por si necesita actuar rápido.",
	NoGloves5		= false,
	NoGloves6		= false,
	NoGloves7		= false,
	Cape1			= "Dicen que al espía le gusta llevar capa.",
	Cape2			= "Alguien mencionó que el espía llegó antes con una capa.",
	NoCape1			= "He oído que al espía no le gustan las capas y se niega a llevar una.",
	NoCape2			= "He oído que el espía se dejó la capa en palacio antes de venir aquí.",
	LightVest1		= "La gente dice que el espía no lleva un jubón oscuro esta noche.",
	LightVest2		= "Definitivamente, el espía prefiere los ropajes de colores claros.",
	LightVest3		= "He oído que el espía lleva un jubón más ligero en la fiesta de esta noche.",
	DarkVest1		= "Dicen los rumores que el espía evita llevar colores claros para ocultarse mejor.",
	DarkVest2		= "Al espía le gusta la ropa de colores oscuros... como la noche.",
	DarkVest3		= "He oído que el espía lleva un jubón oscuro intenso esta noche.",
	DarkVest4		= "Definitivamente, el espía prefiere la ropa oscura.",
	Female1			= "Dicen que la espía está aquí y que es digna de ver.",
	Female2			= "Hay alguien que dice que nuestro nuevo invitado no es un hombre.",
	Female3			= "He oído que una mujer no ha parado de hacer preguntas sobre el distrito...",
	Female4			= "Un invitado las ha visto a ella y a Elisande llegar juntas.",
	Female5			= false,
	Male1			= "Uno de los músicos dice que ese tipo no paraba de hacer preguntas sobre el distrito.",
	Male2			= "Una invitada dice que lo vio entrar en la mansión junto a la Gran Magistrix.",
	Male3			= "He oído por ahí que el espía no es una mujer.",
	Male4			= "He oído que el espía está aquí y que es bastante guapo.",
	Male5			= false,
	Male6			= false,
	ShortSleeve1	= "He oído que al espía le gusta el aire fresco y que esta noche no lleva manga larga.",
	ShortSleeve2	= "Me ha dicho una amiga que ha visto cómo va vestido el espía. No llevaba manga larga.",
	ShortSleeve3	= "He oído que el espía lleva manga corta para que sus brazos queden libres.",
	ShortSleeve4	= "Me han dicho que el espía odia llevar manga larga.",
	ShortSleeve5	= false,
	LongSleeve1 	= "Al principio de la noche llegué a ver de refilón las mangas largas del espía.",
	LongSleeve2 	= "Se dice que esta noche el espía cubre sus brazos con mangas largas.",
	LongSleeve3 	= "He oído que el espía lleva manga larga esta noche.",
	LongSleeve4 	= "Un amigo me ha dicho que el espía lleva manga larga.",
	LongSleeve5 	= false,
	Potions1		= "Algo me dice que el espía lleva pociones en el cinturón.",
	Potions2		= "No te lo he dicho... pero el espía está disfrazado de alquimista y lleva pociones en el cinturón.",
	Potions3		= "He oído que el espía ha traído algunas pociones... por si acaso.",
	Potions4		= "He oído que el espía ha traído pociones. Me pregunto por qué.",
	Potions5		= false,
	Potions6		= false,
	NoPotions1		= "Un músico me ha dicho que ha visto al espía tirar su última poción y que ya no tiene más.",
	NoPotions2		= "He oído que el espía no lleva encima ninguna poción.",
	Book1			= "He oído que el espía siempre lleva un libro de secretos escritos en el cinturón.",
	Book2			= "Dicen los rumores que al espía le encanta leer y que siempre lleva al menos un libro encima.",
	Book3			= false,
	Pouch1			= "Dicen que la faltriquera del espía está rematada con hilos de lujo.",
	Pouch2			= "He oído que el espía siempre lleva una faltriquera mágica.",
	Pouch3			= "Un amigo me ha dicho que al espía le encanta el oro y que lleva una faltriquera llena.",
	Pouch4			= "Dicen que la faltriquera del espía está llena de oro para demostrar extravagancia.",
	Pouch5			= false,
	Pouch6			= false,
	Pouch7			= false,
	Found			= "Bueno, bueno, no nos precipitemos.", --Bueno, bueno, no nos precipitemos. ¿Y si me acompañas para poder discutirlo en un ambiente más privado...?
	--
	Gloves		= "guantes/Wears gloves",
	NoGloves	= "sin guantes/No gloves",
	Cape		= "capa/Wearing a cape",
	Nocape		= "sin capa/No cape",
	LightVest	= "jubón claro/Light vest",
	DarkVest	= "jubón oscuro/Dark vest",
	Female		= "mujer/Female",
	Male		= "hombre/Male",
	ShortSleeve = "manga corta/Short sleeves",
	LongSleeve	= "manga larga/Long sleeves",
	Potions		= "pociones/Potions",
	NoPotions	= "sin pociones/No potions",
	Book		= "libro/Book",
	Pouch		= "faltriquera/Pouch"
})
else--esMX
L:SetMiscLocalization({
	EatingYell = "[DBM RV] %s usando %s!",
	SiphoningMagic = "[DBM RV] %s usando %s!",
	PurifyingYell = "[DBM RV] %s usando %s!",
	DrainingYell = "[DBM RV] %s usando %s!",
	InvokingTextYell = "[DBM RV] %s usando %s!",
	DrinkingYell = "[DBM RV] %s usando %s!",
	ReleaseSporesYell = "[DBM RV] %s usando %s!",
	ShuttingDownYell = "[DBM RV] %s usando %s!",
	TreatingYell = "[DBM RV] %s usando %s!",
	PilferingYell = "[DBM RV] %s usando %s!",
	DefacingYell = "[DBM RV] %s usando %s!",
	TinkeringYell = "[DBM RV] %s usando %s!",
	--
	proshlyapMurchal = "¿Debes irte tan pronto, Gran magistrix?", --
	Gloves1			= "Oí que el espía siempre usa guantes.",
	Gloves2			= "Dicen los rumores que el espía siempre usa guantes.",
	Gloves3			= "Oí que el espía se cubre cuidadosamente las manos.",
	Gloves4			= "Alguien dijo que el espía usa guantes para cubrir cicatrices evidentes.",
	Gloves5			= false,
	Gloves6			= false,
	NoGloves1		= "Oí que al espía no le gusta usar guantes.",
	NoGloves2		= "Sabes... encontré otro par de guantes en la sala trasera. Seguro que el espía ande por aquí con las manos descubiertas.",
	NoGloves3		= "Oí que el espía evita usar guantes, en caso de que tenga que tomar decisiones rápidas.",
	NoGloves4		= "Hay un rumor de que el espía nunca usa guantes.",
	NoGloves5		= false,
	NoGloves6		= false,
	NoGloves7		= false,
	Cape1			= "Alguien mencionó que el espía pasó por aquí usando una capa.",
	Cape2			= "Escuché que al espía le gusta usar capas.",
	NoCape1			= "Escuché que el espía odia las capas y se rehúsa a usar una.",
	NoCape2			= "Oí que el espía dejó la capa en el palacio antes de venir aquí.",
	LightVest1		= "La gente dice que el espía no viste un jubón oscuro esta noche.",
	LightVest2		= "Oí que el espía vestirá un jubón de color claro para la fiesta de esta noche.",
	LightVest3		= "El espía definitivamente prefiere los jubones de colores claros.",
	DarkVest1		= "Dicen los rumores que el espía está evitando usar ropa de colores claros para intentar pasar más desapercibido.",
	DarkVest2		= "Al espía le gustan los jubones de colores oscuros... como la noche.",
	DarkVest3		= "Escuché que el chaleco del espía es de un tono oscuro muy exquisito esta misma noche.",
	DarkVest4		= "El espía definitivamente prefiere la ropa oscura.",
	Female1			= "Escuché que una mujer no deja de preguntar sobre el distrito...",
	Female2			= "Un invitado la vio a ella y a Elisande llegar juntas hace rato.",
	Female3			= "Dicen que la espía está aquí y que es impresionante.",
	Female4			= "Alguien anda diciendo que nuestro nuevo huésped no es hombre.",
	Female5			= false,
	Male1			= "Oí por ahí que el espía no es mujer.",
	Male2			= "Uno de los músicos dijo que no dejaba de preguntar sobre el distrito.",
	Male3			= "Oí que el espía está aquí y que es muy apuesto.",
	Male4			= "Un invitado dijo que lo vio entrar a la mansión junto con la gran magistrix.",
	Male5			= false,
	Male6			= false,
	ShortSleeve1	= "Escuché que el espía disfruta del aire fresco y no usará mangas largas esta noche.",
	ShortSleeve2	= "Alguien me dijo que el espía odia usar mangas largas.",
	ShortSleeve3	= "Una amiga me contó que vio el atuendo que llevaba puesto el espía. No usaba mangas largas.",
	ShortSleeve4	= "Tengo entendido que el espía usa mangas cortas para dejar sus brazos al descubierto.",
	ShortSleeve5	= false,
	LongSleeve1 	= "Alguien dijo que el espía cubrirá sus brazos con mangas largas esta noche.",
	LongSleeve2 	= "Un amigo mío mencionó que el espía lleva puestas mangas largas.",
	LongSleeve3 	= "Oí que el traje del espía es de mangas largas esta noche.",
	LongSleeve4 	= "Más temprano pude ver las mangas largas del espía.",
	LongSleeve5 	= false,
	Potions1		= "Tengo la certeza de que el espía tiene pociones en su cinturón.",
	Potions2		= "Tengo entendido que el espía trajo consigo algunas pociones... por si acaso.",
	Potions3		= "No te lo dije... pero el espía se disfraza como un alquimista y lleva pociones en su cinturón.",
	Potions4		= "Tengo entendido que el espía trajo varias pociones. Me pregunto para qué.",
	Potions5		= false,
	Potions6		= false,
	NoPotions1		= "Un músico me dijo que vio al espía tirar su última poción verde y que ya no le quedan más.",
	NoPotions2		= "Oí que el espía no tiene pociones.",
	Book1			= "Oí que el espía siempre lleva un libro de secretos en el cinturón.",
	Book2			= "Dicen que al espía le encanta leer y siempre lleva al menos un libro.",
	Book3			= false,
	Pouch1			= "Escuché que la bolsa del cinturón del espía tiene un bordado de lujo.",
	Pouch2			= "Oí que la bolsa del cinturón del espía está llena de oro para demostrar su extravagancia.",
	Pouch3			= "Oí que el espía siempre lleva consigo una bolsa mágica.",
	Pouch4			= "Un amigo dijo que al espía le encanta el oro y un bolso lleno de él.",
	Pouch5			= false,
	Pouch6			= false,
	Pouch7			= false,
	Found			= "Mejor sígueme y hablemos de esto en un lugar algo más privado…", --Calma, no nos apuremos, НИК. Mejor sígueme y hablemos de esto en un lugar algo más privado…
	--
	Gloves		= "guantes/Wears gloves",
	NoGloves	= "sin guantes/No gloves",
	Cape		= "capa/Wearing a cape",
	Nocape		= "sin capa/No cape",
	LightVest	= "jubón claro/Light vest",
	DarkVest	= "jubón oscuro/Dark vest",
	Female		= "mujer/Female",
	Male		= "hombre/Male",
	ShortSleeve = "manga corta/Short sleeves",
	LongSleeve	= "manga larga/Long sleeves",
	Potions		= "pociones/Potions",
	NoPotions	= "sin pociones/No potions",
	Book		= "libro/Book",
	Pouch		= "bolsa/Pouch"
})
end

--------------------
-- Fauce de Almas --
--------------------

--------------------------
-- Ymiron, el Rey Caído --
--------------------------
L= DBM:GetModLocalization(1502)

--------------
-- Harbaron --
--------------
L= DBM:GetModLocalization(1512)

-----------
-- Helya --
-----------
L= DBM:GetModLocalization(1663)

L:SetMiscLocalization({
	TaintofSeaYell = "%s desaparece con %s. Cuidado!"
})

----------------------
-- Enemigos menores --
----------------------
L = DBM:GetModLocalization("MawTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

if GetLocale() == "esES" then
L:SetMiscLocalization({
	Helya = "¡Lamentaréis haber entrado en mi reino!"
})
else
L:SetMiscLocalization({
	Helya = "TODOS lamentarán haber entrado en mi reino." --
})
end

-------------------------------
-- Asalto al Bastión Violeta --
-------------------------------

---------------------------
-- Destripamentes Kaahrj --
---------------------------
L= DBM:GetModLocalization(1686)

-------------------------------
-- Malífica Tormenta de Maná --
-------------------------------
L= DBM:GetModLocalization(1688)

----------------
-- Fazinfecta --
----------------
L= DBM:GetModLocalization(1693)

------------------
-- Estremefauce --
------------------
L= DBM:GetModLocalization(1694)

---------------------------------
-- Princesa de Sangre Thal'ena --
---------------------------------
L= DBM:GetModLocalization(1702)

----------------
-- Anub'esset --
----------------
L= DBM:GetModLocalization(1696)

--------------
-- Sael'orn --
--------------
L= DBM:GetModLocalization(1697)

----------------------
-- Señor vil Betrug --
----------------------
L= DBM:GetModLocalization(1711)

----------------------
-- Enemigos menores --
----------------------
L = DBM:GetModLocalization("AVHTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})

L:SetWarningLocalization({
	WarningPortalSoon	= "Siguiente portal en breve",
	WarningPortalNow	= "Portal %d",
	WarningBossNow		= "Jefe en breve"
})

L:SetTimerLocalization({
	TimerPortal			= "Portal"
})

L:SetOptionLocalization({
	WarningPortalNow		= "Mostrar aviso cuando aparezca un portal",
	WarningPortalSoon		= "Mostrar aviso previo para el siguiente portal",
	WarningBossNow			= "Mostrar aviso previo para el siguiente jefe",
	TimerPortal				= "Mostrar temporizador para el siguiente portal (después de jefe)"
})

L:SetMiscLocalization({
	Malgath		=	"Lord Malgath"
})

-----------------------------
-- Cámara de las Celadoras --
-----------------------------

------------------------
-- Tirathon Saltheril --
------------------------
L= DBM:GetModLocalization(1467)

----------------------------
-- Inquisidor Tormentorum --
----------------------------
L= DBM:GetModLocalization(1695)

----------------
-- Ceniz'golm --
----------------
L= DBM:GetModLocalization(1468)

if GetLocale() == "esES" then
L:SetMiscLocalization({
	MurchalProshlyapOchko = "Las contramedidas de la sala están activadas." --
})
else
L:SetMiscLocalization({
	MurchalProshlyapOchko = "Las contramedidas de la habitación están armadas." --
})
end

----------------
-- Observador --
----------------
L= DBM:GetModLocalization(1469)

----------------------
-- Cordana Cantovil --
----------------------
L= DBM:GetModLocalization(1470)

----------------------
-- Enemigos menores --
----------------------
L = DBM:GetModLocalization("VoWTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

if GetLocale() == "esES" then --Прошляпанное очко Мурчаля Прошляпенко (очередной)
L:SetMiscLocalization({
	proshlyapMurchalRP = "¡Qué predecibles! Sabía que acabaríais viniendo."
})
else
L:SetMiscLocalization({
	proshlyapMurchalRP = "¡Pero qué previsible! Sabía que vendrías." --
})
end

------------------------
-- Regreso a Karazhan --
------------------------

------------------------
-- Doncella de Virtud --
------------------------
L= DBM:GetModLocalization(1825)

------------------------------
-- Sala de la Ópera: Makaku --
------------------------------
L= DBM:GetModLocalization(1820)

--------------------------------------------
-- Sala de la Ópera: Historia de Poniente --
--------------------------------------------
L= DBM:GetModLocalization(1826)

if GetLocale() == "esES" then
L:SetMiscLocalization({
	Tonny = "¿Nos damos un garbeo?",
	Phase3 = "¡Somos tú y yo contra el mundo!"
})
else
L:SetMiscLocalization({
	Tonny = "¿Quieres ir por un paseo?", --
	Phase3 = "¡Somos tu yo contra el mundo, sí!" --
})
end

------------------------------------
-- Sala de la Ópera: Bella Bestia --
------------------------------------
L= DBM:GetModLocalization(1827)

------------------------
-- Attumen el Montero --
------------------------
L= DBM:GetModLocalization(1835)
--Волосали
if GetLocale() == "esES" then
L:SetMiscLocalization({
	SharedSufferingYell = "%s en %s. ALEJAROS de mi!",
	Perephase1 = "¡Hora de enfrentarme a mi presa cara a cara!",
	Perephase2 = "¡Cabalgamos, Medianoche! ¡Hacia la victoria!"
})
else
L:SetMiscLocalization({
	SharedSufferingYell = "%s en %s. ALEJAROS de mi!",
	Perephase1 = "¡Hora de enfrentarme a mi presa cara a cara!", --
	Perephase2 = "¡Cabalgamos, Medianoche! ¡A la victoria!" --
})
end

------------
-- Moroes --
------------
L= DBM:GetModLocalization(1837)

-------------
-- Curator --
-------------
L= DBM:GetModLocalization(1836)

----------------------
-- Sombra de Medivh --
----------------------
L= DBM:GetModLocalization(1817)

-----------------------
-- Devorador de maná --
-----------------------
L= DBM:GetModLocalization(1818)

-----------------------------
-- Viz'aduum el Observador --
-----------------------------
L= DBM:GetModLocalization(1838)

--------------
-- Nocturno --
--------------
L = DBM:GetModLocalization("Nightbane")

L:SetGeneralLocalization({
	name =	"Nocturno"
})

----------------------
-- Enemigos menores --
----------------------
L = DBM:GetModLocalization("RTKTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})

if GetLocale() == "esES" then
L:SetOptionLocalization({
	timerRoleplay = "Отсчет времени до начала представления \"Bella Bestia\"",
	timerRoleplay2 = "Отсчет времени до начала представления \"Historia de Poniente\"",
	timerRoleplay3 = "Отсчет времени до начала представления \"Makaku\"",
	timerRoleplay4 = DBM_CORE_OPTION_TIMER_DOOR_OPENING,
	OperaActivation = DBM_CORE_GENERIC_TIMER_ROLE_PLAY
})

L:SetTimerLocalization({
	timerRoleplay = "\"Bella Bestia\"",
	timerRoleplay2 = "\"Historia de Poniente\"",
	timerRoleplay3 = "\"Makaku\"",
	timerRoleplay4 = DBM_CORE_GENERIC_TIMER_DOOR_OPENING
})

L:SetMiscLocalization({
	Beauty = "Buenas tardes, señoras y señores. ¡Sed bienvenidos a la representación de esta noche!",
	Westfall = "¡Bienvenidos, señoras y señores, a la representación de esta tarde!",
	Wikket = "Señoras y señores, bienvenidos a nuestra... ¡AY!",
	Medivh1 = "He dejado tantos fragmentos de mí mismo por esta torre...",
	speedRun = "La brisa fría de una presencia oscura colma el aire..."
})
else
L:SetOptionLocalization({
	timerRoleplay = "Отсчет времени до начала представления \"bestia hermosa\"",
	timerRoleplay2 = "Отсчет времени до начала представления \"Páramos de Poniente\"",
	timerRoleplay3 = "Отсчет времени до начала представления \"Makaku\"",
	timerRoleplay4 = DBM_CORE_OPTION_TIMER_DOOR_OPENING,
	OperaActivation = DBM_CORE_GENERIC_TIMER_ROLE_PLAY
})

L:SetTimerLocalization({
	timerRoleplay = "\"bestia hermosa\"",
	timerRoleplay2 = "\"Páramos de Poniente\"",
	timerRoleplay3 = "\"Makaku\"",
	timerRoleplay4 = DBM_CORE_GENERIC_TIMER_DOOR_OPENING
})

L:SetMiscLocalization({
	Beauty = "Buenas noches damas y caballeros. Orgullosamente les damos la bienvenida a la presentación programada para esta noche.", --
	Westfall = "¡Damas y caballeros, bienvenidos a la presentación estelar de esta tarde!", --
	Wikket = "Bienvenidos, señoras y señores, a nuestro... ¡UFF!", --
	Medivh1 = "He dejado muchos fragmentos de mí mismo por toda esta torre...", --
	speedRun = "La brisa fría de una presencia oscura colma el aire..."
})
end

---------------------------------
-- Catedral de la Noche Eterna --
---------------------------------

-------------
-- Agronox --
-------------
L= DBM:GetModLocalization(1905)

-------------------------------
-- Dientizador el Desdeñoso  --
-------------------------------
L= DBM:GetModLocalization(1906)

--------------
-- Domatrax --
--------------
L= DBM:GetModLocalization(1904)

------------------
-- Mephistroth  --
------------------
L= DBM:GetModLocalization(1878)

----------------------
-- Enemigos menores --
----------------------
L = DBM:GetModLocalization("CoENTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})

---------------------------
-- Trono del Triunvirato --
---------------------------

-------------------------
-- Zuraal el Ascendido --
-------------------------
L= DBM:GetModLocalization(1979)

-------------
-- Saprish --
-------------
L= DBM:GetModLocalization(1980)

-------------------
-- Virrey Nezhar --
-------------------
L= DBM:GetModLocalization(1981)

-----------
-- L'ura --
-----------
L= DBM:GetModLocalization(1982)

----------------------
-- Enemigos menores --
----------------------
L = DBM:GetModLocalization("SoTTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_DOOR_OPENING,
	timerRoleplay2 = DBM_CORE_OPTION_TIMER_COMBAT,
	AlleriaActivation = DBM_CORE_GENERIC_TIMER_ROLE_PLAY
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_DOOR_OPENING,
	timerRoleplay2 = DBM_CORE_GENERIC_TIMER_COMBAT
})
if GetLocale() == "esES" then
L:SetMiscLocalization({
	RP1 = "La Guardia de las Sombras está aumentando su presencia cerca del templo.",
	RP2 = "Percibo una gran desesperación que emana del interior. L'ura...",
	RP3 = "Cuánto caos y cuánto tormento... Jamás había sentido algo parecido."
})
else
L:SetMiscLocalization({
	RP1 = "La Guardia de las Sombras está fortaleciendo su posición cerca del templo.", --
	RP2 = "Percibo una gran desesperación que emana del interior. L'ura...", --
	RP3 = "Cuánto caos... Cuánta angustia. Nunca antes sentí algo así." --
})
end

----------
--Мифик+--
----------
L = DBM:GetModLocalization("MAffix")

L:SetGeneralLocalization({
	name = "Afijos M+"
})
