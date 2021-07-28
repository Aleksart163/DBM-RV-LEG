if GetLocale() ~= "ruRU" then return end

local L

---------------------------
-- Garothi Worldbreaker --
---------------------------
L= DBM:GetModLocalization(1992)

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})

---------------------------
-- Hounds of Sargeras --
---------------------------
L= DBM:GetModLocalization(1987)

L:SetOptionLocalization({
	SequenceTimers =	"Последовательность таймеров восстановления на героическом / мифическом уровне сложности отключена. Использование предыдущих способностей вместо применения текущей способности, чтобы уменьшить беспорядок в таймере за счет незначительной точности таймера (на 1-2 секунды раньше)"
})

---------------------------
-- War Council --
---------------------------
L= DBM:GetModLocalization(1997)

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})
---------------------------
-- Eonar, the Lifebinder --
---------------------------
L= DBM:GetModLocalization(2025)

L:SetTimerLocalization({
	timerObfuscator		=	"Next Obfuscator (%s)",
	timerDestructor 	=	"Next Destructor (%s)",
	timerPurifier 		=	"След. Очиститель (%s)",
	timerBats	 		=	"След. птицы (%s)"
})

L:SetOptionLocalization({
	timerObfuscator		=	DBM_CORE_AUTO_TIMER_OPTIONS["cdcount"]:format("ej16501"),
	timerDestructor 	=	DBM_CORE_AUTO_TIMER_OPTIONS["cdcount"]:format("ej16502"),
	timerPurifier 		=	DBM_CORE_AUTO_TIMER_OPTIONS["cdcount"]:format("ej16500"),
	timerBats	 		=	DBM_CORE_AUTO_TIMER_OPTIONS["cdcount"]:format("ej17039")
})

L:SetMiscLocalization({
	Obfuscators =	"Obfuscator",
	Destructors =	"Destructor",
	Purifiers 	="Очиститель",
	Bats 		="Птицы",
	EonarHealth	="Эонар ХП",
	EonarPower	="Эонар мощь",
	NextLoc		="След.:"
})

---------------------------
-- Portal Keeper Hasabel --
---------------------------
L= DBM:GetModLocalization(1985)

L:SetOptionLocalization({
	ShowAllPlatforms =	"Показать все объявления независимо от местоположения платформы игрока"
})

---------------------------
-- Imonar the Soulhunter --
---------------------------
L= DBM:GetModLocalization(2009)

L:SetMiscLocalization({
	DispelMe =		"ДИСПЕЛ мне, блеать!!!"
})

---------------------------
-- Kin'garoth --
---------------------------
L= DBM:GetModLocalization(2004)

L:SetOptionLocalization({
	InfoFrame =	"Show InfoFrame for fight overview",
	UseAddTime = "Always show timers for what's coming next when boss leaves initialisation phase instead of hiding them. (If disabled, correct timers will resume when boss becomes active again, but may leave little warning if any cooldowns only had 1-2 seconds left)"
})

---------------------------
-- Varimathras --
---------------------------
L= DBM:GetModLocalization(1983)

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})
---------------------------
-- The Coven of Shivarra --
---------------------------
L= DBM:GetModLocalization(1986)

L:SetTimerLocalization({
	timerBossIncoming		= DBM_INCOMING
})

L:SetOptionLocalization({
	timerBossIncoming	= "Показать таймер следующей смены босса",
	TauntBehavior		= "Set taunt behavior for tank swaps",
	TwoMythicThreeNon	= "Swap at 2 stacks on mythic, 3 stacks on other difficulties",--Default
	TwoAlways			= "Always swap at 2 stacks regardless of difficulty",
	ThreeAlways			= "Always swap at 3 stacks regardless of difficulty",
	SetLighting			= "Automatically turn lighting setting to low when coven is engaged and restore on combat end (Not supported in mac client since mac client doesn't support low lighting)",
	InterruptBehavior	= "Set interrupt behavior for raid (Requires raid leader)",
	Three				= "3 person rotation ",--Default
	Four				= "4 person rotation ",
	Five				= "5 person rotation ",
	IgnoreFirstKick		= "With this option, very first interrupt is excluded in rotation (Requires raid leader)"
})

---------------------------
-- Aggramar --
---------------------------
L= DBM:GetModLocalization(1984)

L:SetOptionLocalization({
	ignoreThreeTank	= "Filter Rend/Foe Taunt special warnings when using 3 or more tanks (since DBM can't determine exact tanking rotation in this setup). If any tanks die and it drops to 2, filter auto disables"
})

L:SetMiscLocalization({
	Foe			=	"Враг",
	Rend		=	"Раздирать",
	Tempest 	=	"Буря",
	Current		=	"Текущий:"
})

---------------------------
-- Argus the Unmaker --
---------------------------
L= DBM:GetModLocalization(2031)

L:SetTimerLocalization({
	timerSargSentenceCD	= "Приговор кд (%s)"
})

L:SetOptionLocalization({
	timerSargSentenceCD		=	DBM_CORE_AUTO_TIMER_OPTIONS["cdcount"]:format(257966)
})

L:SetMiscLocalization({
	SeaText		=	"{rt6} Haste/Vers",
	SkyText		=	"{rt5} Crit/Mast",
	Blight		=	"Blight",
	Burst		=	"Burst",
	Sentence	=	"Приговор",
	Bomb		=	"Бомба"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("AntorusTrash")

L:SetGeneralLocalization({
	name =	"Antorus Trash"
})
