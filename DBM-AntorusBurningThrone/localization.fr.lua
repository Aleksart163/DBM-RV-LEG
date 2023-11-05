if GetLocale() ~= "frFR" then return end

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

---------------------------
-- Hounds of Sargeras --
---------------------------
L= DBM:GetModLocalization(1987)

L:SetOptionLocalization({
	SequenceTimers = "Squence the cooldown timers on heroic/mythic difficulty off previous ability casts instead of current ability cast to reduce timer clutter at expense of minor timer accuracy (1-2sec early)"
})

---------------------------
-- War Council --
---------------------------
L= DBM:GetModLocalization(1997)

---------------------------
-- Eonar, the Lifebinder --
---------------------------
L= DBM:GetModLocalization(2025)

L:SetTimerLocalization({
	timerObfuscator		= "Next Obfuscator (%s)",
	timerDestructor 	= "Next Destructor (%s)",
	timerPurifier 		= "Next Purifier (%s)",
	timerBats	 		= "Next Bats (%s)"
})

L:SetMiscLocalization({
	ProshlyapMurchal = "%s %s (%s group) dans 10 sec !",
	YellPullEonar = "Les troupes de la Légion veulent s’emparer de mon essence pour leur maître !", --
	Obfuscators = "Obfuscator",
	Destructors = "Destructor",
	Purifiers 	= "Purifier",
	Bats 		= "Bats",
	EonarHealth	= "Eonar Health",
	EonarPower	= "Eonar Power",
	NextLoc		= "Next:"
})

---------------------------
-- Portal Keeper Hasabel --
---------------------------
L= DBM:GetModLocalization(1985)

L:SetOptionLocalization({
	ShowAllPlatforms = "Show all announces regardless of player platform location"
})

---------------------------
-- Imonar the Soulhunter --
---------------------------
L= DBM:GetModLocalization(2009)

L:SetWarningLocalization({
	PulseGrenade = "Pulse Grenade - stay away from others"
})

L:SetOptionLocalization({
	PulseGrenade = "Show special warning \"stay away from others\" when you are affected by $spell:250006"
})

L:SetMiscLocalization({
	DispelMe = "Dispel Me!"
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

L:SetOptionLocalization({
	ShowProshlyapSoulburnin = "Afficher une alerte spéciale pour $spell:244093 (nécessite d'être chef du raid ou assistant)"
})

L:SetMiscLocalization({
	ProshlyapSoulburnin = "%s %s dans 5 sec"
})

---------------------------
-- The Coven of Shivarra --
---------------------------
L= DBM:GetModLocalization(1986)

L:SetWarningLocalization({
	Amantul = "Torment of Aman'Thul in 5 sec - switch target",
	Norgannon = "Torment of Norgannon in 5 sec - run to the center",
	Golgannet = "Torment of Golganneth in 5 sec - keep a distance of 2m",
	Kazgagot = "Torment of Khaz'goroth in 5 sec - leave the center"
})

L:SetTimerLocalization({
	timerBossIncoming = DBM_INCOMING,
	timerAmanThul = "Aman'Thul",
	timerKhazgoroth = "Flammes",
	timerNorgannon = "Armée",
	timerGolganneth = "Éclairs"
})

L:SetOptionLocalization({
	Amantul = "Show special warning 5 seconds before appearing $spell:252479",
	Norgannon = "Show special warning 5 seconds before appearing $spell:244740",
	Golgannet = "Show special warning 5 seconds before appearing $spell:244756",
	Kazgagot = "Show special warning 5 seconds before appearing $spell:244733",
	timerBossIncoming	= "Show timer for next boss swap",
	TauntBehavior		= "Set taunt behavior for tank swaps",
	TwoMythicThreeNon	= "Swap at 2 stacks on mythic, 3 stacks on other difficulties",--Default
	TwoAlways			= "Always swap at 2 stacks regardless of difficulty",
	ThreeAlways			= "Always swap at 3 stacks regardless of difficulty",
	SetLighting			= "Automatically turn lighting setting to low when coven is engaged and restore on combat end (Not supported in mac client since mac client doesn't support low lighting)",
	InterruptBehavior	= "Set interrupt behavior for raid (Requires raid leader)",
	Three				= "3 person rotation ",--Default
	Four				= "4 person rotation ",
	Five				= "5 person rotation ",
	IgnoreFirstKick		= "With this option, very first interrupt is excluded in rotation (Requires raid leader)",
	timerAmanThul 		= "Durée d'incantation de $spell:250335",
	timerKhazgoroth 	= "Durée d'incantation de $spell:250333",
	timerNorgannon 		= "Durée d'incantation de $spell:250334",
	timerGolganneth 	= "Durée d'incantation de $spell:249793"
})

---------------------------
-- Aggramar --
---------------------------
L= DBM:GetModLocalization(1984)

L:SetWarningLocalization({
	FlameRend1 = "TOUR D'UN AUTRE GROUPE"
})

L:SetOptionLocalization({
	ShowProshlyapMurchal1 = "Afficher une alerte spéciale pour $spell:244688 (nécessite d'être chef du raid ou assistant)",
	ShowProshlyapMurchal2 = "Afficher une alerte spéciale pour $spell:244912 (nécessite d'être chef du raid ou assistant)",
--	FlameRend1 = "Show special warning during $spell:245463 for the first group (only in mythic)",
--	FlameRend2 = "Show special warning during $spell:245463 for the second group (only in mythic)",
	FlameRend1 = "Afficher une alerte spéciale pendant $spell:245463 quand ce n'est pas votre tour (mythique uniquement)",
	ignoreThreeTank	= "Filter Rend/Foe Taunt special warnings when using 3 or more tanks (since DBM can't determine exact tanking rotation in this setup). If any tanks die and it drops to 2, filter auto disables"
})

L:SetMiscLocalization({
--	Blaze		= "Brasier vorace",
	Foe			= "Foe",
	Rend		= "Rend",
	Tempest 	= "Tempest",
	Current		= "Current:"
})

---------------------------
-- Argus the Unmaker --
---------------------------
L= DBM:GetModLocalization(2031)

L:SetTimerLocalization({
	timerSargSentenceCD	= "Sentence CD (%s)"
})

L:SetMiscLocalization({
	SeaText		= "Haste/Vers sur %s",
	SkyText		= "Crit/Mast sur %s",
	Blight		= "Fléau",
	Burst		= "Explosion",
	Sentence	= "Condamnation",
	Bomb		= "BOMBE",
	Blight2		= "Fléau sur %s!",
	Burst2		= "Explosion sur moi!",
--	Sentence2	= "Condamnation sur %s!",
--	Bomb2		= "Bombe d'âme!",
	Rage		= "RAGE",
	Fear		= "PEUR"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("AntorusTrash")

L:SetGeneralLocalization({
	name =	"Antorus Trash"
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
