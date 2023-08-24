if GetLocale() ~= "frFR" then return end

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
	proshlyapMurchal = "Assez ! Tout cela n’a que trop duré."
})

-----------------------
--Black Rook Hold Trash
-----------------------
L = DBM:GetModLocalization("BRHTrash")

L:SetGeneralLocalization({
	name =	"Bastion du Freux Trash"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_DOOR_OPENING
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_DOOR_OPENING
})

L:SetMiscLocalization({
	RP1 = "Je comprends, maintenant…"
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
	ThrowYell = "Lancer sur %s!"
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
	ParanoiaYell = "%s sur %s. ENFUIS-TOI loin de moi!"
}

L:SetMiscLocalization({
	XavApoc = "Vous allez agoniser lentement et dans la douleur.",
	XavApoc2 = "Je vais briser votre esprit si fragile !"
})

-----------------------
--Darkheart Thicket Trash
-----------------------
L = DBM:GetModLocalization("DHTTrash")

L:SetGeneralLocalization({
	name =	"Fourré Sombrecœur Trash"
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
	name =	"L’Œil d’Azshara Trash"
})

-----------------------
-- <<<Halls of Valor>>> --
-----------------------

-----------------------
-- Hymdall --
-----------------------
L= DBM:GetModLocalization(1485)

L:SetMiscLocalization({
	proshlyapMurchal = "Vous avez livré un beau combat ! Vous pouvez passer."
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
	MurchalProshlyapOchko = "Blessé, Fenryr se replie dans sa tanière."
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
	OchkenMurchalProshlyapen = "Assez ! Je… J’abandonne ! Vous êtes de remarquables créatures. Comme promis, voici votre juste récompense." --
})

-----------------------
--Halls of Valor Trash
-----------------------
L = DBM:GetModLocalization("HoVTrash")

L:SetGeneralLocalization({
	name =	"Salles des Valeureux Trash"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT,
	BossActivation = DBM_CORE_GENERIC_TIMER_ROLE_PLAY
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetMiscLocalization({
	RPSolsten = "Vous profanez ce rituel par votre présence, mortels !",
	RPSolsten2 = "Hyrja… La fureur des tempêtes est à tes ordres !",
	RPOlmyr = "Vous n’empêcherez pas l’ascension d’Hyrja !",
	RPOlmyr2 = "Que la Lumière brille éternellement en toi, Hyrja !",
	RPSkovald = "Non ! Moi aussi, j’ai prouvé ma valeur, Odyn. Je suis Skovald, le Dieu-Roi ! Ces mortels ne peuvent pas contester l’égide qui me revient de droit !",
	RPOdyn = "Impressionnant ! Je n’aurais jamais cru rencontrer des guerriers capables de rivaliser avec les Valarjar… et pourtant, vous voilà."
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
	name =	"Repaire de Neltharion Trash"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetMiscLocalization({
	RoleP1 = "Navarrogg ? Espèce de traître ! Tu oses t’allier à ces intrus pour nous défier ?!"
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
	RPVandros = "Assez ! Vous outrepassez votre rang, rats !"
})

-----------------------
--The Arcway Trash
-----------------------
L = DBM:GetModLocalization("ArcwayTrash")

L:SetGeneralLocalization({
	name =	"L’Arcavia Trash"
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
	name =	"Cour des Étoiles Trash"
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
	proshlyapMurchal = "Vous partez déjà, grande magistrice ?",
	Gloves1			= "On m’a raconté que la taupe portait des gants pour masquer d’affreuses cicatrices.",
	Gloves2			= "On dit que la taupe porte toujours des gants.",
	Gloves3			= "Le bruit court que la taupe porte toujours des gants.",
	Gloves4			= "Il paraît que la taupe prend toujours soin de cacher ses mains.",
	Gloves5			= false,
	Gloves6			= false,
	NoGloves1		= "Vous savez… J’ai trouvé une paire de gants abandonnée dans l’arrière-salle. Il faut croire que la taupe n’en porte pas.",
	NoGloves2		= "J’ai entendu dire que la taupe évite de porter des gants, de crainte que cela ne nuise à sa dextérité.",
	NoGloves3		= "On dit que la taupe déteste porter des gants.",
	NoGloves4		= "Le bruit court que la taupe ne porte jamais de gants.",
	NoGloves5		= false,
	NoGloves6		= false,
	NoGloves7		= false,
	Cape1			= "Quelqu’un affirme que la taupe portait une cape lors de son passage ici.",
	Cape2			= "On dit que la taupe aime porter des capes.",
	NoCape1			= "Il paraît que la taupe n’aime pas les capes et refuse d’en porter.",
	NoCape2			= "J’ai entendu dire que la taupe avait laissé sa cape au palais avant de venir ici.",
	LightVest1		= "On raconte que la taupe ne porte pas de gilet sombre ce soir.",
	LightVest2		= "Il paraît que la taupe porte un gilet clair ce soir.",
	LightVest3		= "La taupe préfère les gilets de couleur claire.",
	DarkVest1		= "La taupe préfère les gilets sombres… comme la nuit.",
	DarkVest2		= "J’ai entendu dire que la taupe porte un gilet de couleur sombre ce soir.",
	DarkVest3		= "D’après les rumeurs, la taupe évite les tenues de couleur claire pour mieux se fondre dans la masse.",
	DarkVest4		= "Une chose est sûre, la taupe préfère les vêtements sombres.",
	Female1			= "Quelqu’un l’a vue arriver en compagnie d’Élisande.",
	Female2			= "Le bruit court que notre hôte ne serait pas un homme.",
	Female3			= "On dit que la taupe est ici et que c’est une vraie beauté.",
	Female4			= "On me dit qu’une femme ne cesse de poser des questions à propos du quartier…",
	Female5			= false,
	Male1			= "À en croire la rumeur, la taupe ne serait pas une espionne.",
	Male2			= "À en croire l’un des musiciens, il n’arrêtait pas de poser des questions sur le quartier.",
	Male3			= "Une invitée l’aurait vu entrer dans le manoir au côté de la grande magistrice.",
	Male4			= "Il paraît que l’espion est ici et qu’il est fort séduisant, de surcroît.",
	Male5			= false,
	Male6			= false,
	ShortSleeve1	= "Quelqu’un m’a dit que la taupe détestait porter des manches longues.",
	ShortSleeve2	= "Une de mes amies prétend avoir vu la tenue que porte notre taupe. À l’en croire, ce ne serait pas un habit à manches longues.",
	ShortSleeve3	= "Il paraît que la taupe porte des manches courtes pour rester plus libre de ses mouvements.",
	ShortSleeve4	= "Il paraît que la taupe aime sentir la caresse du vent sur sa peau et ne porte pas de manches longues ce soir.",
	ShortSleeve5	= false,
	LongSleeve1 	= "D’après l’un de mes amis, la taupe porterait un habit à manches longues.",
	LongSleeve2 	= "Il paraît que la taupe porte une tenue à manches longues ce soir.",
	LongSleeve3 	= "J’ai brièvement entraperçu la taupe dans sa tenue à manches longues tout à l’heure.",
	LongSleeve4 	= "Quelqu’un m’a dit que les bras de la taupe étaient dissimulés par un habit à manches longues, ce soir.",
	LongSleeve5 	= false,
	Potions1		= "La taupe porte des potions à la ceinture. J’en mettrais ma main au feu !",
	Potions2		= "Ça reste entre nous… La taupe se fait passer pour un alchimiste et porte des potions à sa ceinture.",
	Potions3		= "J’ai entendu dire que la taupe a apporté quelques potions… au cas où.",
	Potions4		= "J’ai entendu dire que la taupe a apporté quelques potions. Je me demande bien pourquoi.",
	Potions5		= false,
	Potions6		= false,
	NoPotions1		= "Une musicienne m’a dit avoir vu la taupe jeter sa dernière potion. Il semblerait donc qu’il ne lui en reste plus.",
	NoPotions2		= "Il paraît que la taupe ne transporte aucune potion.",
	Book1			= "Il paraît que la taupe porte toujours un livre des secrets à sa ceinture.",
	Book2			= "Le bruit court que la taupe adore lire et transporte toujours au moins un livre.",
	Book3			= false,
	Pouch1			= "On raconte que la taupe ne se sépare jamais de sa sacoche magique.",
	Pouch2			= "D’après l’un de mes amis, la taupe aime l’or et les sacoches qui en sont pleines.",
	Pouch3			= "On raconte que la sacoche de la taupe est pleine d’or. Si ça, ce n’est pas un signe extérieur de richesse…",
	Pouch4			= "On raconte que la sacoche de la taupe est bordée d’une élégante broderie.",
	Pouch5			= false,
	Pouch6			= false,
	Pouch7			= false,
	Found			= "N’allez pas trop vite en besogne", --Allons, Tielle. N’allez pas trop vite en besogne. Et si vous me suiviez, que nous puissions en parler en privé ?
	--
	Gloves		= "Wears gloves/Носит перчатки",
	NoGloves	= "No gloves/Без перчаток",
	Cape		= "Wearing a cape/Носит плащ",
	Nocape		= "No cape/Без плаща",
	LightVest	= "Light vest/Светлый жилет",
	DarkVest	= "Dark vest/Темный жилет",
	Female		= "Female/Женщина",
	Male		= "Male/Мужчина",
	ShortSleeve = "Short sleeves/Короткие рукава",
	LongSleeve	= "Long sleeves/Длинные рукава",
	Potions		= "Potions/Зелья",
	NoPotions	= "No potions/Нет зелий",
	Book		= "Book/Книга",
	Pouch		= "Pouch/Кошель"
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
	Proshlyaping = "Vous croyez avoir gagné ? Vous n’avez fait que survivre à la tempête… Les océans sont inexorables.", --
	TaintofSeaYell = "%s se dissipe avec %s. ATTENTION !"
})

-----------------------
--Maw of Souls Trash
-----------------------
L = DBM:GetModLocalization("MawTrash")

L:SetGeneralLocalization({
	name =	"La Gueule des âmes Trash"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetMiscLocalization({
	Helya = "Vous allez TOUS regretter d’avoir osé pénétrer dans mon royaume."
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
	name =	"Assaut sur le fort Pourpre Trash"
})

L:SetWarningLocalization({
	WarningPortalSoon	= "New portal soon",
	WarningPortalNow	= "Portal #%d",
	WarningBossNow		= "Boss incoming"
})

L:SetTimerLocalization({
	timerRoleplay 		= DBM_CORE_GENERIC_TIMER_COMBAT,
	TimerPortal			= "Portal CD"
})

L:SetOptionLocalization({
	timerRoleplay 			= DBM_CORE_OPTION_TIMER_COMBAT,
	WarningPortalNow		= "Show warning for new portal",
	WarningPortalSoon		= "Show pre-warning for new portal",
	WarningBossNow			= "Show warning for boss incoming",
	TimerPortal				= "Show timer for next portal (after Boss)"
})

L:SetMiscLocalization({
	MurchalOchkenShlyapen = "Gardes, nous partons ! Ces aventuriers vont se charger de la suite ! Allez, en route !", --
	MillificentRP = "Enfin libre ! Débarrassée de ce maudit piège ! Ah celui-là, quel…" --
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
	MurchalProshlyapOchko = "Les contre-mesures de la salle sont maintenant armées."
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
	name =	"Caveau des Gardiennes Trash"
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

L:SetMiscLocalization({
	proshlyapMurchalRP = "Comme vous êtes prévisible. Je savais que vous viendriez." --Прошляпанное очко Мурчаля Прошляпенко
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
	Tonny = "Ça vous dit de faire un tour ?",
	Phase3 = "Mon univers est là : vous et moi !"
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
	IntangiblePresence = "Незримое присутствие",
	IntangiblePresence2 = "Körperlose Präsenz",
	IntangiblePresence3 = "Intangible Presence",
	IntangiblePresence4 = "Presencia intangible",
	IntangiblePresence5 = "Présence immatérielle",
	IntangiblePresence6 = "Presenza Intangibile",
	IntangiblePresence7 = "Presença Intangível",
	IntangiblePresence8 = "무형의 존재",
	IntangiblePresence9 = "无形",
	SharedSufferingYell = "%s sur %s. ENFUIS-TOI loin de moi!",
	Perephase1 = "L’heure est venue de vous affronter les yeux dans les yeux !",
	Perephase2 = "Au galop, Minuit ! Vers la victoire !"
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
	name =	"Retour à Karazhan Trash"
})

L:SetOptionLocalization({
	timerRoleplay = "Отсчет времени до начала представления \"La belle bête\"",
	timerRoleplay2 = "Отсчет времени до начала представления \"De l’amour à la mer\"",
	timerRoleplay3 = "Отсчет времени до начала представления \"Lokdu\"",
	timerRoleplay4 = DBM_CORE_OPTION_TIMER_DOOR_OPENING,
	OperaActivation = DBM_CORE_GENERIC_TIMER_ROLE_PLAY
})

L:SetTimerLocalization({
	timerRoleplay = "\"Opéra : La belle bête\"",
	timerRoleplay2 = "\"De l’amour à la mer\"",
	timerRoleplay3 = "\"Lokdu\"",
	timerRoleplay4 = DBM_CORE_GENERIC_TIMER_DOOR_OPENING
})

L:SetMiscLocalization({
	Beauty = "Bonsoir et bienvenue, mesdames et messieurs. Nous sommes heureux de vous accueillir à la représentation de ce soir !",
	Westfall = "Mesdames et messieurs, bienvenue à la représentation de ce soir !",
	Wikket = "Mesdames et messieurs, bienvenue à notre… ARGH !",
	Medivh1 = "J’ai laissé tant de parcelles de mon être dans cette tour…",
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
	name =	"Cathédrale de la Nuit éternelle Trash"
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
	name =	"Siège du triumvirat Trash"
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
	RP1 = "The Shadowguard is building up its presence near the temple.",
	RP2 = "I sense great despair emanating from within. L'ura...",
	RP3 = "Such chaos... such anguish. I have never sensed anything like it before."
})

----------
--Мифик+--
----------
L = DBM:GetModLocalization("MAffix")

L:SetGeneralLocalization({
	name = "M+ Affixes"
})
