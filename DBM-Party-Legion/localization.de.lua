if GetLocale() ~= "deDE" then return end

local L

-----------------------
-- <<<Black Rook Hold>>> --
-----------------------

-----------------------
-- The Amalgam of Souls --
-----------------------
L= DBM:GetModLocalization(1518)

-----------------------
-- Illysanna Ravencrest --
-----------------------
L= DBM:GetModLocalization(1653)

-----------------------
-- Smashspite the Hateful --
-----------------------
L= DBM:GetModLocalization(1664)

-----------------------
-- Lord Kur'talos Ravencrest --
-----------------------
L= DBM:GetModLocalization(1672)

L:SetMiscLocalization({
	proshlyapMurchal = "Es reicht! Genug der Scharade."
})

-----------------------
--Black Rook Hold Trash
-----------------------
L = DBM:GetModLocalization("BRHTrash")

L:SetGeneralLocalization({
	name =	"Trash der Rabenwehr"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_DOOR_OPENING
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_DOOR_OPENING
})

L:SetMiscLocalization({
	RP1 = "Jetzt... Jetzt sehe ich..."
})

-----------------------
-- <<<Darkheart Thicket>>> --
-----------------------

-----------------------
-- Arch-Druid Glaidalis --
-----------------------
L= DBM:GetModLocalization(1654)

-----------------------
-- Oakheart --
-----------------------
L= DBM:GetModLocalization(1655)

L:SetMiscLocalization({
	ThrowYell = "Wurf auf %s!"
})

-----------------------
-- Dresaron --
-----------------------
L= DBM:GetModLocalization(1656)

-----------------------
-- Shade of Xavius --
-----------------------
L= DBM:GetModLocalization(1657)

L:SetMiscLocalization{
	ParanoiaYell = "%s auf %s. Lauf vor mir weg!"
}

L:SetMiscLocalization({
	XavApoc = "Ihr werdet langsam und qualvoll dahinsiechen.",
	XavApoc2 = "Ich werde Euren gläsernen Verstand zerbersten lassen!"
})

-----------------------
--Darkheart Thicket Trash
-----------------------
L = DBM:GetModLocalization("DHTTrash")

L:SetGeneralLocalization({
	name =	"Trash des Finsterherzdickichts"
})

-----------------------
-- <<<Eye of Azshara>>> --
-----------------------

-----------------------
-- Warlord Parjesh --
-----------------------
L= DBM:GetModLocalization(1480)

-----------------------
-- Lady Hatecoil --
-----------------------
L= DBM:GetModLocalization(1490)

-----------------------
-- King Deepbeard --
-----------------------
L= DBM:GetModLocalization(1491)

-----------------------
-- Serpentrix --
-----------------------
L= DBM:GetModLocalization(1479)

-----------------------
-- Wrath of Azshara --
-----------------------
L= DBM:GetModLocalization(1492)

-----------------------
--Eye of Azshara Trash
-----------------------
L = DBM:GetModLocalization("EoATrash")

L:SetGeneralLocalization({
	name =	"Trash des Auge Azsharas"
})

-----------------------
-- <<<Halls of Valor>>> --
-----------------------

-----------------------
-- Hymdall --
-----------------------
L= DBM:GetModLocalization(1485)

L:SetMiscLocalization({
	proshlyapMurchal = "Ein glorreicher Kampf! Ihr dürft passieren."
})

-----------------------
-- Hyrja --
-----------------------
L= DBM:GetModLocalization(1486)

-----------------------
-- Fenryr --
-----------------------
L= DBM:GetModLocalization(1487)

L:SetMiscLocalization({
	MurchalProshlyapOchko = "Fenryr zieht sich verwundet in seinen Bau zurück."
})

-----------------------
-- God-King Skovald --
-----------------------
L= DBM:GetModLocalization(1488)

-----------------------
-- Odyn --
-----------------------
L= DBM:GetModLocalization(1489)

L:SetMiscLocalization({
	OchkenMurchalProshlyapen = "Genug! Ich... gebe auf! Ihr seid wahrhaft bemerkenswerte Kreaturen. Nun, wie versprochen – Eure gerechte Belohnung."
})

-----------------------
--Halls of Valor Trash
-----------------------
L = DBM:GetModLocalization("HoVTrash")

L:SetGeneralLocalization({
	name =	"Trash der Hallen der Tapferkeit"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT, 
	BossActivation = DBM_CORE_GENERIC_TIMER_ROLE_PLAY
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetMiscLocalization({
	RPSolsten = "Ihr entweiht dieses Ritual mit Eurer Anwesenheit, Sterbliche!", --
	RPSolsten2 = "Hyrja... der Zorn des Sturms dient Eurem Wort!", --
	RPOlmyr = "Ihr werdet Hyrjas Aufstieg nicht stören!", --
	RPOlmyr2 = "Das Licht erstrahlt auf ewig in Euch, Hyrja!", --
	RPSkovald = "Nein! Auch ich habe mich bewiesen, Odyn. Ich bin Gottkönig Skovald! Diese Sterblichen werden mir die Aegis nicht streitig machen!", --
	RPOdyn = "Höchst beeindruckend! Ich hielt die Kräfte der Valarjar stets für unerreicht... und dennoch steht Ihr hier vor mir." --
})

-----------------------
-- <<<Neltharion's Lair>>> --
-----------------------

-----------------------
-- Rokmora --
-----------------------
L= DBM:GetModLocalization(1662)

-----------------------
-- Ularogg Cragshaper --
-----------------------
L= DBM:GetModLocalization(1665)

-----------------------
-- Naraxas --
-----------------------
L= DBM:GetModLocalization(1673)

-----------------------
-- Dargrul the Underking --
-----------------------
L= DBM:GetModLocalization(1687)

-----------------------
--Neltharion's Lair Trash
-----------------------
L = DBM:GetModLocalization("NLTrash")

L:SetGeneralLocalization({
	name =	"Trash des Neltharions Hort"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetMiscLocalization({
	RoleP1 = "Navarrogg?! Verräter! Ihr führt diese Eindringlinge gegen uns ins Feld?!"
})

-----------------------
-- <<<The Arcway>>> --
-----------------------

-----------------------
-- Ivanyr --
-----------------------
L= DBM:GetModLocalization(1497)

-----------------------
-- Nightwell Sentry --
-----------------------
L= DBM:GetModLocalization(1498)

-----------------------
-- General Xakal --
-----------------------
L= DBM:GetModLocalization(1499)

-----------------------
-- Nal'tira --
-----------------------
L= DBM:GetModLocalization(1500)

-----------------------
-- Advisor Vandros --
-----------------------
L= DBM:GetModLocalization(1501)

L:SetMiscLocalization({
	RPVandros = "Es reicht! Ihr kleinen Monster geratet außer Kontrolle."
})

-----------------------
--The Arcway Trash
-----------------------
L = DBM:GetModLocalization("ArcwayTrash")

L:SetGeneralLocalization({
	name =	"Trash des Arkus"
})

-----------------------
-- <<<Court of Stars>>> --
-----------------------

-----------------------
-- Patrol Captain Gerdo --
-----------------------
L= DBM:GetModLocalization(1718)

-----------------------
-- Talixae Flamewreath --
-----------------------
L= DBM:GetModLocalization(1719)

-----------------------
-- Advisor Melandrus --
-----------------------
L= DBM:GetModLocalization(1720)

-----------------------
--Court of Stars Trash
-----------------------
L = DBM:GetModLocalization("CoSTrash")

L:SetGeneralLocalization({
	name = "Trash des Hofs der Sterne"
})

L:SetOptionLocalization({
	YellOnEating = "Melden, wenn jemand einen Zauber anwendet $spell:208585",
	YellOnSiphoningMagic = "Melden, wenn jemand einen Zauber anwendet $spell:208427",
	YellOnPurifying = "Melden, wenn jemand einen Zauber anwendet $spell:209767",
	YellOnDraining = "Melden, wenn jemand einen Zauber anwendet $spell:208334",
	YellOnInvokingText = "Melden, wenn jemand einen Zauber anwendet $spell:210872",
	YellOnDrinking = "Melden, wenn jemand einen Zauber anwendet $spell:210307",
	YellOnReleaseSpores = "Melden, wenn jemand einen Zauber anwendet $spell:208939",
	YellOnShuttingDown = "Melden, wenn jemand einen Zauber anwendet $spell:208370",
	YellOnTreating = "Melden, wenn jemand einen Zauber anwendet $spell:210925",
	YellOnPilfering = "Melden, wenn jemand einen Zauber anwendet $spell:210217",
	YellOnDefacing = "Melden, wenn jemand einen Zauber anwendet $spell:210330",
	YellOnTinkering = "Melden, wenn jemand einen Zauber anwendet $spell:210922",
	warnSpy = "Spezialwarnung, wenn ein Spion entdeckt wird",
	SpyHelper	= "Hilf bei der Erkennung des Spions",
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetMiscLocalization({
	SpellUseYell = "%s %s verwendet %s!",
	--
	proshlyapMurchal = "Müsst Ihr schon gehen, Großmagistrix?",
	Gloves1			= "Einem Gerücht zufolge trägt der Spion immer Handschuhe.",
	Gloves2			= "Wie ich hörte, verbirgt der Spion sorgfältig die Hände.",
	Gloves3			= "Ich hörte, dass der Spion immer Handschuhe anlegt.",
	Gloves4			= "Jemand behauptete, dass der Spion Handschuhe trägt, um sichtbare Narben zu verbergen.",
	Gloves5			= false,
	Gloves6			= false,
	NoGloves1		= "Es gibt Gerüchte, dass der Spion niemals Handschuhe trägt.",
	NoGloves2		= "Wisst Ihr... Ich habe ein zusätzliches Paar Handschuhe im Hinterzimmer gefunden. Wahrscheinlich ist der Spion hier irgendwo mit bloßen Händen unterwegs.",
	NoGloves3		= "Mir ist zu Ohren gekommen, dass der Spion ungern Handschuhe trägt.",
	NoGloves4		= "Ich hörte, dass der Spion es vermeidet, Handschuhe zu tragen, falls er schnell handeln muss.",
	NoGloves5		= false,
	NoGloves6		= false,
	NoGloves7		= false,
	Cape1			= "Jemand erwähnte, dass der Spion vorhin hier hereinkam und einen Umhang trug.",
	Cape2			= "Mir ist zu Ohren gekommen, dass der Spion gerne Umhänge trägt.",
	NoCape1			= "Ich hörte, dass der Spion keine Umhänge mag und sich weigert, einen zu tragen.",
	NoCape2			= "Ich hörte, dass der Spion seinen Umhang im Palast gelassen hat, bevor er hierhergekommen ist.",
	LightVest1		= "Der Spion bevorzugt auf jeden Fall Westen mit hellen Farben.",
	LightVest2		= "Wie ich hörte, trägt der Spion auf der Party heute Abend eine helle Weste.",
	LightVest3		= "Die Leute sagen, dass der Spion heute Abend keine dunkle Weste trägt.",
	DarkVest1		= "Der Spion bevorzugt auf alle Fälle dunkle Kleidung.",
	DarkVest2		= "Ich hörte, dass die Weste des Spions heute Abend von dunkler, kräftiger Farbe ist.",
	DarkVest3		= "Dem Spion gefallen Westen mit dunklen Farben... dunkel wie die Nacht.",
	DarkVest4		= "Gerüchten zufolge vermeidet der Spion es, helle Kleidung zu tragen, damit er nicht so auffällt.",
	Female1			= "Ein Gast hat beobachtet, wie sie und Elisande vorhin gemeinsam eingetroffen sind.",
	Female2			= "Wie ich höre, hat eine Frau sich ständig nach diesem Bezirk erkundigt...",
	Female3			= "Jemand hat behauptet, dass unser neuester Gast nicht männlich ist.",
	Female4			= "Man sagt, die Spionin wäre hier und sie wäre eine wahre Augenweide.",
	Female5			= false,
	Male1			= "Irgendwo habe ich gehört, dass der Spion nicht weiblich ist.",
	Male2			= "Ich hörte, dass der Spion ein äußerst gutaussehender Herr ist.",
	Male3			= "Ein Gast sagte, sie sah, wie ein Herr an der Seite der Großmagistrix das Anwesen betreten hat.",
	Male4			= "Einer der Musiker sagte, er stellte unablässig Fragen über den Bezirk.",
	Male5			= false,
	Male6			= false,
	ShortSleeve1	= "Mir ist zu Ohren gekommen, dass der Spion kurze Ärmel trägt, damit er seine Arme ungehindert bewegen kann.",
	ShortSleeve2	= "Jemand sagte mir, dass der Spion lange Ärmel hasst.",
	ShortSleeve3	= "Eine meiner Freundinnen sagte, dass sie die Kleidung des Spions gesehen hat. Er trägt keine langen Ärmel.",
	ShortSleeve4	= "Man hat mir zugetragen, dass der Spion die kühle Luft mag und deshalb heute Abend keine langen Ärmel trägt.",
	ShortSleeve5	= false,
	LongSleeve1		= "Wie ich hörte, trägt der Spion heute Abend Kleidung mit langen Ärmeln.",
	LongSleeve2		= "Jemand sagte, dass der Spion heute Abend seine Arme mit langen Ärmeln bedeckt.",
	LongSleeve3		= "Ich habe am frühen Abend einen kurzen Blick auf die langen Ärmel des Spions erhascht.",
	LongSleeve4		= "Einer meiner Freunde erwähnte, dass der Spion lange Ärmel trägt.",
	LongSleeve5 	= false,
	Potions1		= "Ich hörte, dass der Spion Tränke mitgebracht hat... Ich frage mich wieso?",
	Potions2		= "Von mir habt Ihr das nicht... aber der Spion verkleidet sich als Alchemist und trägt Tränke an seinem Gürtel.",
	Potions3		= "Ich bin mir ziemlich sicher, dass der Spion Tränke am Gürtel trägt.",
	Potions4		= "Wie ich hörte, hat der Spion einige Tränke mitgebracht... für alle Fälle.",
	Potions5		= false,
	Potions6		= false,
	NoPotions1		= "Wie ich hörte, hat der Spion keine Tränke bei sich.",
	NoPotions2		= "Eine Musikerin erzählte mir, dass sie gesehen hat, wie der Spion seinen letzten Trank wegwarf und jetzt keinen mehr übrig hat.",
	Book1			= "Ich hörte, dass der Spion immer ein Buch mit niedergeschriebenen Geheimnissen am Gürtel trägt.",
	Book2			= "Gerüchten zufolge liest der Spion gerne und trägt immer mindestens ein Buch bei sich.",
	Book3			= false,
	Pouch1			= "Ich hörte, dass der Spion immer einen magischen Beutel mit sich herumträgt.",
	Pouch2			= "Ein Freund behauptet, dass der Spion Gold liebt und einen Gürtelbeutel voll davon hat.",
	Pouch3			= "Ich hörte, dass der Gürtelbeutel des Spions mit ausgefallenem Garn gesäumt wurde.",
	Pouch4			= "Mir ist zu Ohren gekommen, dass der Gürtelbeutel des Spions mit Gold gefüllt ist, um besonders extravagant zu erscheinen.",
	Pouch5			= false,
	Pouch6			= false,
	Pouch7			= false,
	Found			= "Wieso folgt Ihr mir nicht, damit wir in etwas privaterer Umgebung darüber sprechen können...", -- Na, na, wir wollen doch nicht voreilig sein, НИК. Wieso folgt Ihr mir nicht, damit wir in etwas privaterer Umgebung darüber sprechen können...
	--
	Gloves			= "Handschuhe/Wears gloves",
	NoGloves		= "keine Handschuhe/No gloves",
	Cape			= "Umhang/Wearing a cape",
	Nocape			= "kein Umhang/No cape",
	LightVest		= "helle Weste/Light vest",
	DarkVest		= "dunkle Weste/Dark vest",
	Female			= "weiblich/Female",
	Male			= "männlich/Male",
	ShortSleeve		= "kurze Ärmel/Short sleeves",
	LongSleeve		= "lange Ärmel/Long sleeves",
	Potions			= "Tränke/Potions",
	NoPotions		= "keine Tränke/No potions",
	Book			= "Buch/Book",
	Pouch			= "Beutel/Pouch"
})

-----------------------
-- <<<The Maw of Souls>>> --
-----------------------

-----------------------
-- Ymiron, the Fallen King --
-----------------------
L= DBM:GetModLocalization(1502)

-----------------------
-- Harbaron --
-----------------------
L= DBM:GetModLocalization(1512)

-----------------------
-- Helya --
-----------------------
L= DBM:GetModLocalization(1663)

L:SetMiscLocalization({
	Proshlyaping = "Ihr glaubt, Ihr habt gewonnen? Ihr habt nur den Sturm überstanden. Die See ist unbezwingbar.", --
	TaintofSeaYell = "%s verschwindet mit %s. Sich vorsehen!"
})

-----------------------
--Maw of Souls Trash
-----------------------
L = DBM:GetModLocalization("MawTrash")

L:SetGeneralLocalization({
	name =	"Trash des Seelenschlundes"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetMiscLocalization({
	Helya = "Ihr werdet bereuen, in mein Reich eingedrungen zu sein."
})

-----------------------
-- <<<Assault Violet Hold>>> --
-----------------------

-----------------------
-- Mindflayer Kaahrj --
-----------------------
L= DBM:GetModLocalization(1686)

-----------------------
-- Millificent Manastorm --
-----------------------
L= DBM:GetModLocalization(1688)

-----------------------
-- Festerface --
-----------------------
L= DBM:GetModLocalization(1693)

-----------------------
-- Shivermaw --
-----------------------
L= DBM:GetModLocalization(1694)

-----------------------
-- Blood-Princess Thal'ena --
-----------------------
L= DBM:GetModLocalization(1702)

-----------------------
-- Anub'esset --
-----------------------
L= DBM:GetModLocalization(1696)

-----------------------
-- Sael'orn --
-----------------------
L= DBM:GetModLocalization(1697)

-----------------------
-- Fel Lord Betrug --
-----------------------
L= DBM:GetModLocalization(1711)

-----------------------
--Assault Violet Hold Trash
-----------------------
L = DBM:GetModLocalization("AVHTrash")

L:SetGeneralLocalization({
	name =	"Trash des Sturms auf die VF"
})

L:SetWarningLocalization({
	WarningPortalSoon	= "Neues Portal bald",
	WarningPortalNow	= "Portal %d",
	WarningBossNow		= "Boss kommt"
})

L:SetTimerLocalization({
	TimerPortal			= "Portal CD"
})

L:SetOptionLocalization({
	WarningPortalNow		= "Zeige Warnung für neues Portal",
	WarningPortalSoon		= "Zeige Vorwarnung für neues Portal",
	WarningBossNow			= "Zeige Warnung für neuen Boss",
	TimerPortal				= "Zeige Timer für nächstes Portal (nach einem Boss)"
})

L:SetMiscLocalization({
	Malgath		=	"Lord Malgath"
})

-----------------------
-- <<<Vault of the Wardens>>> --
-----------------------

-----------------------
-- Tirathon Saltheril --
-----------------------
L= DBM:GetModLocalization(1467)

-----------------------
-- Inquisitor Tormentorum --
-----------------------
L= DBM:GetModLocalization(1695)

-----------------------
-- Ash'golm --
-----------------------
L= DBM:GetModLocalization(1468)

L:SetMiscLocalization({
	MurchalProshlyapOchko = "Die Gegenmaßnahmen des Raumes sind nun aktiviert."
})

-----------------------
-- Glazer --
-----------------------
L= DBM:GetModLocalization(1469)

-----------------------
-- Cordana --
-----------------------
L= DBM:GetModLocalization(1470)

-----------------------
--Vault of Wardens Trash
-----------------------
L = DBM:GetModLocalization("VoWTrash")

L:SetGeneralLocalization({
	name =	"Trash des Verlieses der Wächterinnen"
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

L:SetMiscLocalization({
	proshlyapMurchalRP = "Wie lächerlich berechenbar! Ich wusste, Ihr würdet kommen." --Прошляпанное очко Мурчаля Прошляпенко
})

-----------------------
-- <<<Return To Karazhan>>> --
-----------------------

-----------------------
-- Maiden of Virtue --
-----------------------
L= DBM:GetModLocalization(1825)

-----------------------
-- Opera Hall: Wikket  --
-----------------------
L= DBM:GetModLocalization(1820)

-----------------------
-- Opera Hall: Westfall Story --
-----------------------
L= DBM:GetModLocalization(1826)

L:SetMiscLocalization({
	Tonny = "Wagen wir ein Tänzchen?",
	Phase3 = "Du und ich gegen den Rest der Welt, Baby!"
})

-----------------------
-- Opera Hall: Beautiful Beast  --
-----------------------
L= DBM:GetModLocalization(1827)

-----------------------
-- Attumen the Huntsman --
-----------------------
L= DBM:GetModLocalization(1835)

L:SetMiscLocalization({
	Tip1 = "Ein Geist ist bei einer unbekannten Person erschienen. Dies geschieht, wenn das Geisterziel BigWigs verwendet, eine alte Version von DBM hat oder überhaupt keine Addons verwendet.",
	SharedSufferingYell = "%s auf %s. Lauf vor mir weg!",
	Perephase1 = "Ich stelle mich der Beute. Auge in Auge!",
	Perephase2 = "Wir reiten, Mittnacht! Zum Sieg!"
})

-----------------------
-- Moroes --
-----------------------
L= DBM:GetModLocalization(1837)

-----------------------
-- The Curator --
-----------------------
L= DBM:GetModLocalization(1836)

-----------------------
-- Shade of Medivh --
-----------------------
L= DBM:GetModLocalization(1817)

-----------------------
-- Mana Devourer --
-----------------------
L= DBM:GetModLocalization(1818)

-----------------------
-- Viz'aduum the Watcher --
-----------------------
L= DBM:GetModLocalization(1838)

-----------------------
--Nightbane
-----------------------
L = DBM:GetModLocalization("Nightbane")

L:SetGeneralLocalization({
	name =	"Schrecken der Nacht"
})

-----------------------
--Return To Karazhan Trash
-----------------------
L = DBM:GetModLocalization("RTKTrash")

L:SetGeneralLocalization({
	name =	"Trash der Rückkehr nach Karazhan"
})

L:SetOptionLocalization({
	timerRoleplay = "Countdown zum Beginn der Show \"Das schöne Biest\"",
	timerRoleplay2 = "Countdown zum Beginn der Show \"Westfall Story\"",
	timerRoleplay3 = "Countdown zum Beginn der Show \"Wikket\"",
	timerRoleplay4 = DBM_CORE_OPTION_TIMER_DOOR_OPENING,
	OperaActivation = DBM_CORE_GENERIC_TIMER_ROLE_PLAY
})

L:SetTimerLocalization({
	timerRoleplay = "\"Das schöne Biest\"",
	timerRoleplay2 = "\"Westfall Story\"",
	timerRoleplay3 = "\"Wikket\"",
	timerRoleplay4 = DBM_CORE_GENERIC_TIMER_DOOR_OPENING
})

L:SetMiscLocalization({
	Beauty = "Guten Abend, meine Damen und Herren. Wir heißen Euch voller Stolz willkommen zu unserer heutigen Vorstellung!",
	Westfall = "Meine Damen und Herren, willkommen zu unserer heutigen Vorstellung!",
	Wikket = "Willkommen, meine Damen und Herren, zu... UFF!",
	Medivh1 = "Ich habe so viel von mir selbst in diesem Turm zurückgelassen...",
	speedRun = "Die seltsame Kühle einer dunklen Präsenz durchweht die Luft..."
})

-----------------------
-- <<<Cathedral of Eternal Night >>> --
-----------------------

-----------------------
-- Agronox --
-----------------------
L= DBM:GetModLocalization(1905)

-----------------------
-- Trashbite the Scornful  --
-----------------------
L= DBM:GetModLocalization(1906)

-----------------------
-- Domatrax --
-----------------------
L= DBM:GetModLocalization(1904)

-----------------------
-- Mephistroth  --
-----------------------
L= DBM:GetModLocalization(1878)

-----------------------
--Cathedral of Eternal Night Trash
-----------------------
L = DBM:GetModLocalization("CoENTrash")

L:SetGeneralLocalization({
	name =	"Trash der Kathedr. d. ew. Nacht"
})

-----------------------
-- <<<Seat of Triumvirate >>> --
-----------------------

-----------------------
-- Zuraal --
-----------------------
L= DBM:GetModLocalization(1979)

-----------------------
-- Saprish  --
-----------------------
L= DBM:GetModLocalization(1980)

-----------------------
-- Viceroy Nezhar --
-----------------------
L= DBM:GetModLocalization(1981)

-----------------------
-- L'ura  --
-----------------------
L= DBM:GetModLocalization(1982)

-----------------------
--Seat of Triumvirate Trash
-----------------------
L = DBM:GetModLocalization("SoTTrash")

L:SetGeneralLocalization({
	name =	"Trash des Sitzes des Triumvirats"
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

L:SetMiscLocalization({
	RP1 = "Die Schattenwache verstärkt ihre Truppen in der Nähe des Tempels.",
	RP2 = "Ich spüre große Verzweiflung innerhalb der Gemäuer. L'ura...",
	RP3 = "Dieses Chaos... diese Qualen. Etwas Derartiges habe ich noch nie gespürt."
})

----------
--Мифик+--
----------
L = DBM:GetModLocalization("MAffix")

L:SetGeneralLocalization({
	name = "M+ Affixe"
})
