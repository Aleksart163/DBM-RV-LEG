if GetLocale() ~= "ptBR" then return end

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
	proshlyapMurchal = "Chega! Estou cansado disso."
})

-----------------------
--Black Rook Hold Trash
-----------------------
L = DBM:GetModLocalization("BRHTrash")

L:SetGeneralLocalization({
	name =	"Castelo Corvo Negro Besteira"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_DOOR_OPENING
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_DOOR_OPENING
})

L:SetMiscLocalization({
	RP1 = "Agora... agora eu vejo..."
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
	ParanoiaYell = "%s em %s. FUJAM de mim!"
}

L:SetMiscLocalization({
	XavApoc = "Você vai definhar lenta e dolorosamente.",
	XavApoc2 = "Vou romper sua mente frágil!"
})

-----------------------
--Darkheart Thicket Trash
-----------------------
L = DBM:GetModLocalization("DHTTrash")

L:SetGeneralLocalization({
	name =	"Bosque Corenegro Besteira"
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
	name =	"Olho de Azshara Besteira"
})

-----------------------
-- <<<Halls of Valor>>> --
-----------------------

-----------------------
-- Hymdall --
-----------------------
L= DBM:GetModLocalization(1485)

L:SetMiscLocalization({
	proshlyapMurchal = "Um bom combate! O caminho adiante está aberto."
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
	MurchalProshlyapOchko = "Ferido, Fenryr recua para a sua toca."
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
	OchkenMurchalProshlyapen = "Chega! Eu... me rendo! Vocês são criaturas realmente incríveis. Como prometido, vocês terão sua justa recompensa." --
})

-----------------------
--Halls of Valor Trash
-----------------------
L = DBM:GetModLocalization("HoVTrash")

L:SetGeneralLocalization({
	name =	"Salões da Bravura Besteira"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT,
	BossActivation = DBM_CORE_GENERIC_TIMER_ROLE_PLAY
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetMiscLocalization({
	RPSolsten = "Vocês maculam este ritual com sua presença, mortais!",
	RPSolsten2 = "Hyrja... a fúria da tempestade está sob seu comando!",
	RPOlmyr = "Vocês não negarão a ascensão de Hyrja!",
	RPOlmyr2 = "A Luz brilha eternamente em você, Hyrja!",
	RPSkovald = "Não! Eu também provei meu valor, Odyn. Eu sou o Deus-Rei Skovald! Esses mortais não ousam desafiar meu direito à égide!",
	RPOdyn = "Muito impressionante! Eu nunca pensei que encontraria alguém capaz de igualar Valarjar em força... porém, aí estão vocês."
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
	name =	"Covil de Neltharion Besteira"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetMiscLocalization({
	RoleP1 = "Navarrogg?! Traidor! Você liderou esses intrusos contra nós?!"
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

L:SetMiscLocalization({
	batSpawn		=	"Reinforcements to me! NOW!"
})

-----------------------
-- Nal'tira --
-----------------------
L= DBM:GetModLocalization(1500)

-----------------------
-- Advisor Vandros --
-----------------------
L= DBM:GetModLocalization(1501)

L:SetMiscLocalization({
	RPVandros = "Chega! Vocês, pestinhas, estão fora de controle!"
})

-----------------------
--The Arcway Trash
-----------------------
L = DBM:GetModLocalization("ArcwayTrash")

L:SetGeneralLocalization({
	name =	"O Arcâneo Besteira"
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
	name =	"Pátio das Estrelas Besteira"
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
	proshlyapMurchal = "Precisa sair tão cedo, Grã-Magistra?",
	Gloves1			= "Alguém disse que o espião usa luvas para esconder cicatrizes.",
	Gloves2			= "Dizem que o espião fica escondendo as mãos.",
	Gloves3			= "Corre um boato de que o espião sempre usa luvas.",
	Gloves4			= "Ouvi dizer que o espião sempre usa luvas.",
	NoGloves1		= "Sabe de uma coisa... Encontrei um par de luvas lá atrás. Imagino que o espião esteja por aí de mãos nuas.",
	NoGloves2		= "Estão dizendo que o espião nunca usa luvas.",
	NoGloves3		= "Estão dizendo que o espião evita usar luvas, para o caso de precisar agir rapidamente.",
	NoGloves4		= "Ouvi dizer que o espião não gosta de usar luvas.",
	Cape1			= "Ouvi dizer que o espião gosta de usar capas.",
	Cape2			= "Alguém falou que o espião chegou mais cedo usando uma capa.",
	NoCape1			= "Ouvi dizer que o espião não gosta de capas e se recusa a usar uma.",
	NoCape2			= "Ouvi dizer que o espião deixou a capa no palácio antes de vir pra cá.",
	LightVest1		= "O espião definitivamente prefere coletes de cor clara.",
	LightVest2		= "Estão dizendo que o espião não está usando colete escuro hoje.",
	LightVest3		= "Ouvi dizer que o espião está usando um colete claro.",
	DarkVest1		= "O espião definitivamente prefere roupas escuras.",
	DarkVest2		= "Ouvi dizer que as vestes do espião têm um tom escuro e rico esta noite.",
	DarkVest3		= "Corre um boato que o espião evitou roupas de cores claras para não chamar a atenção.",
	DarkVest4		= "O espião gosta de coletes escuros... como a noite.",
	Female1			= "Ouvi falar que uma mulher está fazendo várias perguntas sobre o distrito...",
	Female2			= "Um convidado viu ela e Elisande chegarem juntas.",
	Female3			= "Tem gente dizendo que é uma nova convidada, e não convidado.",
	Female4			= "Dizem que a espiã está aqui e que ela é um colírio para os olhos.",
	Male1			= "Ouvi dizer que o espião está aqui e é muito bonito.",
	Male2			= "Ouvi dizer por aí que o espião não é uma mulher.",
	Male3			= "Um dos músicos disse que ele não parava de perguntar sobre o distrito.",
	Male4			= "Um convidado disse que o viu entrando na mansão ao lado da Grã-magistra.",
	ShortSleeve1	= "Uma amiga minha disse que viu a roupa espião. Não tinha mangas longas.",
	ShortSleeve2	= "Alguém me disse que o espião odeia mangas compridas.",
	ShortSleeve3	= "Dizem que o espião usa mangas curtas para manter os braços livres.",
	ShortSleeve4	= "Ouvi dizer que o espião gosta de ar fresco e não está usando mangas compridas.",
	LongSleeve1 	= "Alguém me disse que o espião está cobrindo os braços com mangas compridas.",
	LongSleeve2 	= "Ouvi dizer que a roupa do espião é de manga comprida.",
	LongSleeve3 	= "Um amigo meu disse que o espião está de mangas compridas.",
	LongSleeve4 	= "Eu mal consegui espiar as mangas compridas do espião.",
	Potions1		= "Disseram que o espião trouxe poções, por que será?",
	Potions2		= "Disseram que o espião trouxe algumas poções... só por garantia.",
	Potions3		= "Eu não lhe disse nada... mas o espião está disfarçado de alquimista, carregando poções no cinto.",
	Potions4		= "Tenho certeza de que o espião tem poções no cinto.",
	NoPotions1		= "Disseram que o espião não está carregando poções.",
	NoPotions2		= "Uma musicista me contou que viu o espião jogar fora a última poção que tinha. Agora ele não tem mais nenhuma.",
	Book1			= "Corre um boato de que o espião adora ler e sempre carrega pelo menos um livro.",
	Book2			= "Soube que o espião sempre carrega um caderno de segredos no cinto.",
	Pouch1			= "Ouvi dizer que a pochete do espião é forrada com fios finos.",
	Pouch2			= "Ouvi dizer que a pochete do espião está cheia de ouro para mostrar extravagância.",
	Pouch3			= "Um amigo disse que o espião ama ouro e uma pochete bem cheia disso.",
	Pouch4			= "Ouvi dizer que o espião sempre anda com uma bolsa mágica.",
	Found			= "Ora, ora, não sejamos apressados", -- Ora, ora, não sejamos apressados, НИК. Que tal me seguir e conversar em um local mais reservado...
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
	Proshlyaping = "Vocês acham que venceram? Apenas sobreviveram à tempestade... Os mares são implacáveis.", --
	TaintofSeaYell = "%s desaparece. CUIDADO!"
})

-----------------------
--Maw of Souls Trash
-----------------------
L = DBM:GetModLocalization("MawTrash")

L:SetGeneralLocalization({
	name =	"Gorja das Almas Besteira"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetMiscLocalization({
	Helya = "TODOS vocês vão se arrepender de invadir o meu reino."
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
	name =	"Ataque ao Castelo Violeta Besteira"
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
	MillificentRP = "Наконец-то я вырвалась из ловушки! Ну и..." --need localization
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
	MurchalProshlyapOchko = "As medidas de defesa da sala estão armadas."
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
	name =	"Câmara das Guardiãs Besteira"
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

L:SetMiscLocalization({
	proshlyapMurchalRP = "Totalmente previsível! Eu sabia que você viria." --Прошляпанное очко Мурчаля Прошляпенко
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
	Tonny = "Quer dar uma voltinha?",
	Phase3 = "Só eu e você contra o mundo, meu bem!"
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
--	ProshlyapAnala = "Em breve %s!",
	SharedSufferingYell = "%s em %s. FUJAM de mim!",
	Perephase1 = "Hora de enfrentar a presa cara a cara!",
	Perephase2 = "Venha, Meia-noite! Rumo à vitória!"
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
	name =	"Retorno a Karazhan Besteira"
})

L:SetOptionLocalization({
	timerRoleplay = "Отсчет времени до начала представления \"Fera Bela\"",
	timerRoleplay2 = "Отсчет времени до начала представления \"Amor, Cerrado Amor\"",
	timerRoleplay3 = "Отсчет времени до начала представления \"Galeroz\"",
	timerRoleplay4 = DBM_CORE_OPTION_TIMER_DOOR_OPENING,
	OperaActivation = "Активировать представление в Опере в 1 нажатие"
})

L:SetTimerLocalization({
	timerRoleplay = "\"Fera Bela\"",
	timerRoleplay2 = "\"Amor, Cerrado Amor\"",
	timerRoleplay3 = "\"Galeroz\"",
	timerRoleplay4 = DBM_CORE_GENERIC_TIMER_DOOR_OPENING
})

L:SetMiscLocalization({
	Beauty = "Boa noite, senhoras e senhores. Temos o prazer de apresentar o grande espetáculo desta noite.",
	Westfall = "Senhoras e senhores, sejam bem-vindos à grande apresentação da noite!",
	Wikket = "Boa noite, senhoras e senhores, sejam bem... AU!",
	Medivh1 = "Eu deixei tantos fragmentos meus nesta torre...",
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
	name =	"Catedral da Noite Eterna Besteira"
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
	name =	"Sede do Triunvirato Besteira"
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
	RP1 = "A Guarda Sombria vem fortalecendo sua presença perto do templo.",
	RP2 = "Sinto um desespero imenso emanando lá de dentro. L'ura...",
	RP3 = "Quanto caos... quanta angústia. Eu nunca senti nada igual."
})

----------
--Мифик+--
----------
L = DBM:GetModLocalization("MAffix")

L:SetGeneralLocalization({
	name = "M+ Afixos"
})
