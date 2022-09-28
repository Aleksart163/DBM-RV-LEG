if GetLocale() ~= "itIT" then return end

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
	proshlyapMurchal = "Basta! Mi sono stancato."
})

-----------------------
--Black Rook Hold Trash
-----------------------
L = DBM:GetModLocalization("BRHTrash")

L:SetGeneralLocalization({
	name =	"Forte Corvonero Spazzatura"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_DOOR_OPENING
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_DOOR_OPENING
})

L:SetMiscLocalization({
	RP1 = "Ora... Ora capisco..."
})

----------
--Мифик+--
----------
L = DBM:GetModLocalization("MAffix")

L:SetGeneralLocalization({
	name = "Mythic+ keys"
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

-----------------------
-- Dresaron --
-----------------------
L= DBM:GetModLocalization(1656)

-----------------------
-- Shade of Xavius --
-----------------------
L= DBM:GetModLocalization(1657)

L:SetMiscLocalization{
	ParanoiaYell = "%s su di %s. SCAPPA da me!"
}

L:SetMiscLocalization({
	XavApoc = "Scomparirai lentamente e dolorosamente.",
	XavApoc2 = "Piegherò la vostra debole mente!"
})

-----------------------
--Darkheart Thicket Trash
-----------------------
L = DBM:GetModLocalization("DHTTrash")

L:SetGeneralLocalization({
	name =	"Boschetto Cuortetro Spazzatura"
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
	name =	"Occhio di Azshara Spazzatura"
})

-----------------------
-- <<<Halls of Valor>>> --
-----------------------

-----------------------
-- Hymdall --
-----------------------
L= DBM:GetModLocalization(1485)

L:SetMiscLocalization({
	proshlyapMurchal = "Una grande battaglia! Ora potete passare."
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
	MurchalProshlyapOchko = "Ferito, Fenryr si nasconde nella sua tana."
})

-----------------------
-- God-King Skovald --
-----------------------
L= DBM:GetModLocalization(1488)

-----------------------
-- Odyn --
-----------------------
L= DBM:GetModLocalization(1489)

-----------------------
--Halls of Valor Trash
-----------------------
L = DBM:GetModLocalization("HoVTrash")

L:SetGeneralLocalization({
	name =	"Sale del Valore Spazzatura"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT,
	BossActivation = DBM_CORE_GENERIC_TIMER_ROLE_PLAY
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetMiscLocalization({
	RPSolsten = "State profanando il rituale con la vostra presenza, mortali!",
	RPSolsten2 = "Hyrja... la furia della tempesta è al tuo comando!",
	RPOlmyr = "Non fermerete l'ascensione di Hyrja!",
	RPOlmyr2 = "La Luce brilla in eterno dentro di te, Hyrja!",
	RPSkovald = "No! Anch'io ho dimostrato il mio valore, Odyn. Sono il Dio-Sovrano Skovald! Questi mortali non oseranno sfidarmi per ottenere l'Egida!",
	RPOdyn = "Davvero impressionante! Non avrei mai pensato di incontrare qualcuno con la stessa forza dei Valarjar... Eppure, eccovi qui."
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
	name =	"Antro di Neltharion Spazzatura"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetMiscLocalization({
	RoleP1 = "Navarrogg? Traditore! Guideresti questi intrusi contro di noi?"
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
	RPVandros = "Basta! Voi piccole bestie state esagerando!"
})

-----------------------
--The Arcway Trash
-----------------------
L = DBM:GetModLocalization("ArcwayTrash")

L:SetGeneralLocalization({
	name =	"Arcavia Spazzatura"
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
	name =	"Corte delle Stelle Spazzatura"
})

L:SetOptionLocalization({
	SpyHelper	= "Help identify the spy",
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetMiscLocalization({
	--
	proshlyapMurchal = "Te ne vai così presto, Gran Magistra?",
	Gloves1			= "Ho sentito che la spia porta sempre i guanti.",
	Gloves2			= "Voci dicono che la spia porti sempre i guanti.",
	Gloves3			= "Qualcuno dice che la spia porta sempre dei guanti per nascondere delle cicatrici.",
	Gloves4			= "Ho sentito che la spia tiene sempre accuratamente nascoste le sue mani.",
	NoGloves1		= "Sai... ho trovato un altro paio di guanti nella stanza sul retro. È probabile che la spia sia qui in giro con le mani scoperte.",
	NoGloves2		= "Voci dicono che la spia non porti mai i guanti.",
	NoGloves3		= "Ho sentito che alla spia non piacciono i guanti.",
	NoGloves4		= "Ho sentito che la spia non porta mai i guanti, in caso abbia bisogno di agire in fretta.",
	Cape1			= "Ho sentito che la spia adora indossare mantelli.",
	Cape2			= "Qualcuno diceva che la spia è arrivata presto e indossava un mantello.",
	NoCape1			= "Ho sentito che la spia odia i mantelli e si rifiuta di indossarne uno.",
	NoCape2			= "Ho sentito che la spia ha lasciato il suo mantello al palazzo prima di venire qui.",
	LightVest1		= "La gente dice che la spia non indossa colori scuri stasera.",
	LightVest2		= "Ho sentito che la spia alla festa di stasera indossa un abito dai colori chiari.",
	LightVest3		= "Di sicuro la spia preferisce gli abiti dai colori chiari.",
	DarkVest1		= "Voci dicono che la spia eviti gli abiti dai colori chiari per passare meglio inosservata.",
	DarkVest2		= "La spia ama gli abiti scuri, questo è certo.",
	DarkVest3		= "Ho sentito che stasera l'abito della spia è molto scuro.",
	DarkVest4		= "Alla spia piacciono gli abiti dai colori scuri... come la notte.",
	Female1			= "Qualcuno dice che il nuovo ospite non è un maschio.",
	Female2			= "Dicono che la spia sia qui e sia incredibilmente bella.",
	Female3			= "Ho sentito che una donna ha fatto un sacco di domande sul distretto...",
	Female4			= "Un ospite l'ha vista arrivare prima assieme a Elisande.",
	Male1			= "Una delle musiciste dice che non ha smesso di farle domande a proposito del distretto.",
	Male2			= "Un ospite dice di averlo visto entrare nella villa a fianco della Gran Magistra.",
	Male3			= "Ho sentito che la spia è qui, pare sia davvero bellissimo.",
	Male4			= "Ho sentito in giro che la spia non è una donna.",
	ShortSleeve1	= "Ho sentito che la spia ama l'aria fresca e porta le maniche corte, stasera.",
	ShortSleeve2	= "Mi hanno detto che la spia odia le maniche lunghe.",
	ShortSleeve3	= "Ho sentito che la spia porta le maniche corte, per essere più libera per ogni evenienza.",
	ShortSleeve4	= "Un mio amico dice che l'abito indossato dalla spia è a maniche corte.",
	LongSleeve1 	= "Qualcuno dice che la spia stia nascondendo le sue braccia con delle maniche lunghe, stasera.",
	LongSleeve2 	= "Un mio amico dice che la spia ha le maniche lunghe.",
	LongSleeve3 	= "Ho sentito che la spia porta un abito con le maniche lunghe, stasera.",
	LongSleeve4 	= "Ho visto per un attimo la spia all'inizio della serata, aveva le maniche lunghe.",
	Potions1		= "Io non ti ho detto nulla, ma... la spia si è travestita da alchimista e porta delle pozioni legate alla cintura.",
	Potions2		= "Ho sentito che la spia ha portato con sé alcune pozioni... se può servire.",
	Potions3		= "Ho sentito che la spia ha portato con sé delle pozioni... mi chiedo perché.",
	Potions4		= "Sono quasi sicuro che la spia abbia delle pozioni alla cintura.",
	NoPotions1		= "Un musicante mi ha detto di aver visto la spia buttare via la sua ultima pozione. Probabilmente non ne ha altre.",
	NoPotions2		= "Ho sentito che la spia non ha pozioni con sé.",
	Book1			= "Ho sentito che la spia ha sempre un libro pieno di segreti legato alla cintura.",
	Book2			= "Voci dicono che la spia ami leggere e porti sempre con sé almeno un libro.",
	Pouch1			= "Ho sentito che la borsa da cintura della spia è piena di oro per sembrare stravagante.",
	Pouch2			= "Un amico mi ha detto che la spia ama l'oro e ne ha una borsa piena.",
	Pouch3			= "Ho sentito che la borsa da cintura della spia è ricamata con un filo stravagante.",
	Pouch4			= "Ho sentito che la spia si porta sempre dietro una borsa magica.",
	Found			= "Su, su, non perdiamo la calma", -- Su, su, non perdiamo la calma, Няшмен. Perché non mi segui, così possiamo parlare più tranquillamente...
	--
	Gloves		= "gloves",
	NoGloves	= "no gloves",
	Cape		= "cape",
	Nocape		= "no cape",
	LightVest	= "light vest",
	DarkVest	= "dark vest",
	Female		= "female",
	Male		= "male",
	ShortSleeve = "short sleeves",
	LongSleeve	= "long sleeves",
	Potions		= "potions",
	NoPotions	= "no potions",
	Book		= "book",
	Pouch		= "pouch"
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
	TaintofSeaYell = "%s sparisce con %s. Avvertenza!"
})

-----------------------
--Maw of Souls Trash
-----------------------
L = DBM:GetModLocalization("MawTrash")

L:SetGeneralLocalization({
	name =	"Fauci delle Anime Spazzatura"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetMiscLocalization({
	Helya = "Vi pentirete tutti quanti di essere entrati nel mio reame."
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
	name =	"Assalto alla Fortezza Violacea Spazzatura"
})

L:SetWarningLocalization({
	WarningPortalSoon	= "New portal soon",
	WarningPortalNow	= "Portal #%d",
	WarningBossNow		= "Boss incoming"
})

L:SetTimerLocalization({
	TimerPortal			= "Portal CD"
})

L:SetOptionLocalization({
	WarningPortalNow		= "Show warning for new portal",
	WarningPortalSoon		= "Show pre-warning for new portal",
	WarningBossNow			= "Show warning for boss incoming",
	TimerPortal				= "Show timer for next portal (after Boss)"
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
	MurchalProshlyapOchko = "Le contromisure della stanza sono ora attive."
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
	name =	"Segrete delle Custodi Spazzatura"
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

L:SetMiscLocalization({
	proshlyapMurchalRP = "Come siete prevedibili! Sapevo sareste venuti." --Прошляпанное очко Мурчаля Прошляпенко
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
	Tonny = "Andiamo a farci un giro?",
	Phase3 = "Siamo noi due contro il mondo, piccola!"
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
	SharedSufferingYell = "%s su di %s. SCAPPA da me!",
	Perephase1 = "È ora di affrontare la preda faccia a faccia!",
	Perephase2 = "Al galoppo, Mezzanotte! Verso la vittoria!"
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
	name =	"Nightbane"
})

-----------------------
--Return To Karazhan Trash
-----------------------
L = DBM:GetModLocalization("RTKTrash")

L:SetGeneralLocalization({
	name =	"Ritorno a Karazhan	Spazzatura"
})

L:SetOptionLocalization({
	timerRoleplay = "Отсчет времени до начала представления \"La Bella e il Bruto\"",
	timerRoleplay2 = "Отсчет времени до начала представления \"Mrrgria\"",
	timerRoleplay3 = "Отсчет времени до начала представления \"Il Mago di Hoz\"",
	timerRoleplay4 = DBM_CORE_OPTION_TIMER_DOOR_OPENING,
	OperaActivation = DBM_CORE_GENERIC_TIMER_ROLE_PLAY
})

L:SetTimerLocalization({
	timerRoleplay = "\"La Bella e il Bruto\"",
	timerRoleplay2 = "\"Mrrgria\"",
	timerRoleplay3 = "\"Il Mago di Hoz\"",
	timerRoleplay4 = DBM_CORE_GENERIC_TIMER_DOOR_OPENING
})

L:SetMiscLocalization({
	Beauty = "Buonasera, signore e signori, siamo lieti di darvi il benvenuto alla rappresentazione di questa sera!",
	Westfall = "Signore e signori, benvenuti alla rappresentazione di questa sera!",
	Wikket = "Signore e signori, benvenuti alla... OOOF!",
	Medivh1 = "Ho lasciato così tanti frammenti di me stesso in questa torre...",
	speedRun = "The strange chill of a dark presence winds through the air..."
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
	name =	"Cattedrale della Notte Eterna Spazzatura"
})

-----------------------
-- <<<Seat of Triumvirate >>> --
-----------------------

-----------------------
-- Zuraal --
-----------------------
L= DBM:GetModLocalization(1979)

L:SetWarningLocalization({
	UmbraShift = "Umbra Shift on you - destroy the enemies"
})

L:SetOptionLocalization({
	UmbraShift = "Show special warning \"destroy the enemies\" when you target $spell:244433"
})

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
	name =	"Seggio del Triumvirato Spazzatura"
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
	RP1 = "La Guardia dell'Ombra sta aumentando la sua presenza nei pressi del Tempio.",
	RP2 = "Percepisco una grande disperazione emanare dall'interno. L'ura...",
	RP3 = "Quanto caos... quanta angoscia. Non ho mai sentito nulla del genere prima d'ora."
})
