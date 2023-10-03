if GetLocale() ~= "deDE" then return end

local L
--------------------------------------------WARNING---------------------------------------------------
--Do you want to help translate this module to your native language? Write to the author of this addon
--Aleksart163#1671 (discord)
--/w Tielle or /w Куплиняшка (in the game)
--------------------------------------------WARNING---------------------------------------------------

---------------------------
-- Garothi Worldbreaker --
---------------------------
L= DBM:GetModLocalization(1992)

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
--	YellPullGarothi = "Feindliche Kombattanten registriert. Bedrohung nominal."
})

---------------------------
-- Hounds of Sargeras --
---------------------------
L= DBM:GetModLocalization(1987)

L:SetOptionLocalization({
	SequenceTimers =	"Ändere auf heroischem/mythischem Schwierigkeitsgrad die Reihung der Timer für die Abklingzeiten der Bossfähigkeiten zugunsten der Übersichtlichkeit auf Kosten der Genauigkeit (1-2s zeitiger)"
})

---------------------------
-- War Council --
---------------------------
L= DBM:GetModLocalization(1997)

L:SetMiscLocalization({
--	YellPullCouncil	= "Von dieser Begegnung werdet Ihr nicht mehr erzählen können."
})

---------------------------
-- Eonar, the Lifebinder --
---------------------------
L= DBM:GetModLocalization(2025)

L:SetTimerLocalization({
	timerObfuscator		= "Nächster Verdunkler (%s)",
	timerDestructor 	= "Nächster Zerstörer (%s)",
	timerPurifier 		= "Nächster Läuterer (%s)",
	timerBats	 		= "Nächste Fledermäuse (%s)"
})

L:SetOptionLocalization({
	ShowProshlyapationOfMurchal = "Spezialwarnung für $spell:249121 (nur als Leiter/Assistent)"
})

L:SetMiscLocalization({
	ProshlyapMurchal = "%s %s (%s Gruppe) in 10 Sek!",
	YellPullEonar = "Champions! Die Streitmacht der Legion versucht, meine Essenz für ihren infernalen Meister zu stehlen!",
	Obfuscators = "Verdunkler",
	Destructors = "Zerstörer",
	Purifiers 	= "Läuterer",
	Bats 		= "Fledermäuse",
	EonarHealth	= "Eonar Leben",
	EonarPower	= "Eonar Energie",
	NextLoc		= "Nächste:"
})

---------------------------
-- Portal Keeper Hasabel --
---------------------------
L= DBM:GetModLocalization(1985)

L:SetOptionLocalization({
	ShowAllPlatforms =	"Zeige alle Ansagen unabhängig von der Spielerplattform"
})
--[[
L:SetMiscLocalization({
	YellPullHasabel = "Mehr konntet Ihr nicht aufbringen? Ha. Jämmerlich.",
	YellPullHasabel2 = "Euer Krieg endet hier.",
	YellPullHasabel3 = "Die Legion vernichtet jeden, der sich ihr widersetzt!"
--	YellPullHasabel4 = "Нам покорились все миры. Ваш – следующий."
})
--]]

---------------------------
-- Imonar the Soulhunter --
---------------------------
L= DBM:GetModLocalization(2009)
--https://diealdor.fandom.com/wiki/Antorus,_der_Brennende_Thron#Imonar
L:SetMiscLocalization({
--	YellPullImonar = "Eure Knochen werden mich reich machen.",
--	YellPullImonar2 = "Eure Köpfe werden mein Trophäenzimmer zieren.",
--	YellPullImonar3 = "Ich denke, ein paar Teile von Euch behalte ich als Trophäen.",
	DispelMe = "Reinige mich!"
})
--Eure Knochen werden mich reich machen.
---------------------------
-- Kin'garoth --
---------------------------
L= DBM:GetModLocalization(2004)

L:SetOptionLocalization({
	InfoFrame =	"Zeige Infofenster für Kampfübersicht",
	UseAddTime = "Zeige, während der Boss sich in der Bauphase befindet, weiterhin die Timer zur Anzeige was als Nächstes kommt, anstatt sie zu verstecken (falls deaktiviert, werden die korrekten Timer fortgesetzt, wenn der Boss wieder aktiv wird, bieten aber ggf. nur eine geringe Vorwarnzeit, falls Fähigkeiten in 1-2 Sekunden wieder verfügbar sein sollten)"
})
--[[
L:SetMiscLocalization({
	YellPullKingaroth = "An die Arbeit.",
	YellPullKingaroth2 = "Ihr plant wirklich, mit diesen armseligen Waffen meine Maschinen zu bezwingen?",
	YellPullKingaroth3 = "Euch demontiere ich im Handumdrehen."
})
--]]

---------------------------
-- Varimathras --
---------------------------
L= DBM:GetModLocalization(1983)

L:SetOptionLocalization({
	ShowProshlyapSoulburnin = "Spezialwarnung für $spell:244093 (nur als Leiter/Assistent)"
})

L:SetMiscLocalization({
	ProshlyapSoulburnin = "%s %s in 5 Sek!",
	YellPullVarimathras = "Dann kommt. Vergelten wir Schmerz mit Schmerz!",
	YellPullVarimathras2 = "Zieht Eure Klingen! Ich werde Euch wahre Qualen zeigen!"
})

---------------------------
-- The Coven of Shivarra --
---------------------------
L= DBM:GetModLocalization(1986)

L:SetWarningLocalization({
	Amantul 			= "Pein von Aman'thul nach 5 sek - Ziel wechseln",
	Norgannon 			= "Pein von Norgannon nach 5 sek - lauf in die Mitte",
	Golgannet 			= "Pein von Golganneth nach 5 sek - haltet radius 2m",
	Kazgagot 			= "Pein von Khaz'goroth nach 5 sek - geh von der Mitte weg"
})

L:SetTimerLocalization({
	timerBossIncoming	= DBM_INCOMING,
	timerAmanThul 		= "Aman'thul",
	timerKhazgoroth 	= "Flammen",
	timerNorgannon 		= "Heer",
	timerGolganneth 	= "Blitz"
})

L:SetOptionLocalization({
	ShowProshlyapMurchal = "Spezialwarnung zum $journal:16138 (nur als Leiter/Assistent)",
	Amantul 			= "Spezialwarnung zum 5 Sekunden vor Erscheinen $spell:252479",
	Norgannon 			= "Spezialwarnung zum 5 Sekunden vor Erscheinen $spell:244740",
	Golgannet 			= "Spezialwarnung zum 5 Sekunden vor Erscheinen $spell:244756",
	Kazgagot 			= "Spezialwarnung zum 5 Sekunden vor Erscheinen $spell:244733",
	timerBossIncoming	= "Zeige Zeit bis nächsten Bosswechsel",
	TauntBehavior		= "Setze Spottverhalten für Tankwechsel",
	TwoMythicThreeNon	= "Wechsel bei 2 Stacks (mythisch) bzw. 3 Stacks (andere Schwierigkeitsgrade)",
	TwoAlways			= "Wechsel immer bei 2 Stacks (unabhängig vom Schwierigkeitsgrad)",
	ThreeAlways			= "Wechsel immer bei 3 Stacks (unabhängig vom Schwierigkeitsgrad)",
	SetLighting			= "Grafikeinstellung 'Beleuchtungsqualität' automat. auf 'Niedrig' setzen (wird nach dem Kampfende auf die vorherige Einstellung zurückgesetzt)",
	InterruptBehavior	= "Setze Unterbrechungsverhalten für Schlachtzug (nur als Schlachtzugsleiter)",
	Three				= "3-Personen-Rotation",
	Four				= "4-Personen-Rotation",
	Five				= "5-Personen-Rotation",
	IgnoreFirstKick		= "Allererste Unterbrechung bei der Rotation nicht berücksichtigen (nur als Schlachtzugsleiter)",
	timerAmanThul 		= "Wirkzeit von $spell:250335 anzeigen",
	timerKhazgoroth 	= "Wirkzeit von $spell:250333 anzeigen",
	timerNorgannon 		= "Wirkzeit von $spell:250334 anzeigen",
	timerGolganneth 	= "Wirkzeit von $spell:249793 anzeigen"
})

L:SetMiscLocalization({
	ProshlyapMurchal4	= "%s Heer - ALLES IN DIE MITTE",
	ProshlyapMurchal3	= "%s Blitz - RADIUS 2 METER",
	ProshlyapMurchal2	= "%s Flammen - ALLE SIND AUS DEM ZENTRUM VERSCHWUNDEN",
	ProshlyapMurchal1	= "%s Aman'thul - ZIEL WECHSELN",
	YellPullCoven		= "Ich möchte Eure Glieder schmoren sehen!" --на всякий случай потом погуглить и проверить
})
--

---------------------------
-- Aggramar --
---------------------------
L= DBM:GetModLocalization(1984)

L:SetOptionLocalization({
	ShowProshlyapMurchal1 = "Spezialwarnung für $spell:244688 (nur als Leiter/Assistent)",
	ShowProshlyapMurchal2 = "Spezialwarnung für $spell:244912 (nur als Leiter/Assistent)",
	ignoreThreeTank	= "Unterdrücke Schnitt/Brecher Spottspezialwarnungen bei Verwendung von drei oder mehr Tanks (da DBM für diese Zusammensetzung die genaue Tankrotation nicht bestimmen kann). Falls ein Tank stirbt und die Anzahl auf 2 fällt, wird dieser Filter automatisch deaktiviert."
})

L:SetMiscLocalization({
	MurchalProshlyapation = "%s %s in 5 Sek!",
--	YellPullAggramar = "Ihr... werdet... brennen!", -- или Die Flammen werden Euch verzehren!
--	Blaze		= "Unersättliche Feuersbrunst",
	Foe			= "Brecher",
	Rend		= "Schnitt",
	Tempest 	= "Sturm",
	Current		= "Aktuell:"
})

---------------------------
-- Argus the Unmaker --
---------------------------
L= DBM:GetModLocalization(2031)

L:SetTimerLocalization({
	timerSargSentenceCD	= "Urteil CD (%s)"
})

L:SetOptionLocalization({
	ShowProshlyapationOfMurchal1 = "Spezialwarnung für $spell:258068 (nur als Leiter/Assistent)",
	ShowProshlyapationOfMurchal2 = "Spezialwarnung für $spell:256389 (nur als Leiter/Assistent)",
	AutoProshlyapMurchal = "Automatisch Geist freilassen"
})

L:SetMiscLocalization({
	ProshlyapMurchal = "%s %s in 5 Sek!",
--	YellPullArgus = "Tod! Tod und Schmerz!",
	SeaText		= "Tempo/Viels auf %s",
	SkyText		= "Krit/Meist auf %s",
	Blight		= "SEUCHE",
	Burst		= "EXPLOSION",
	Sentence	= "URTEIL",
	Bomb		= "BOMBE",
	Blight2		= "SEUCHE auf %s!",
	Burst2		= "Explosion ist auf mir!",
--	Sentence2	= "Urteil auf %s!",
--	Bomb2		= "SEELENBOMBE!",
	Rage		= "WUT",
	Fear		= "FURCHT"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("AntorusTrash")

L:SetGeneralLocalization({
	name =	"Trash des Antorus"
})

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
