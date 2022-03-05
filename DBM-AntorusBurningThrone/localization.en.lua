if GetLocale() ~= "ruRU" and GetLocale() ~= "ruRU" then return end
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
	YellPullGarothi = "Enemy combatants detected. Threat level nominal."
})

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

L:SetMiscLocalization({
	YellPullCouncil = "This is one engagement you will not walk away from."
})

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

L:SetOptionLocalization({
	timerObfuscator		= DBM_CORE_AUTO_TIMER_OPTIONS["cdcount"]:format("ej16501"),
	timerDestructor 	= DBM_CORE_AUTO_TIMER_OPTIONS["cdcount"]:format("ej16502"),
	timerPurifier 		= DBM_CORE_AUTO_TIMER_OPTIONS["cdcount"]:format("ej16500"),
	timerBats	 		= DBM_CORE_AUTO_TIMER_OPTIONS["cdcount"]:format("ej17039")
})

L:SetMiscLocalization({
	YellPullEonar = "Champions! The forces of the Legion seek to capture my essense for their infernal master!",
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

L:SetMiscLocalization({
	YellPullHasabel = "Is this the best you could muster? Hah. Pathetic.",
	YellPullHasabel2 = "Your war ends here.",
	YellPullHasabel3 = "The Legion devastates all who oppose us!",
	YellPullHasabel4 = "Every world in our path has fallen. Yours is next."
})

---------------------------
-- Imonar the Soulhunter --
---------------------------
L= DBM:GetModLocalization(2009)

L:SetMiscLocalization({
	DispelMe = "Dispel Me!"
})

L:SetMiscLocalization({
	YellPullImonar = "Your bones will be my biggest payday.",
	YellPullImonar2 = "Think I'll keep a few of your parts as a trophy.",
	YellPullImonar3 = "Your heads will adorn my trophy room."
})

---------------------------
-- Kin'garoth --
---------------------------
L= DBM:GetModLocalization(2004)

L:SetOptionLocalization({
	InfoFrame =	"Show InfoFrame for fight overview",
	UseAddTime = "Always show timers for what's coming next when boss leaves initialisation phase instead of hiding them. (If disabled, correct timers will resume when boss becomes active again, but may leave little warning if any cooldowns only had 1-2 seconds left)"
})

L:SetMiscLocalization({
	YellPullKingaroth = "Time to work.",
	YellPullKingaroth2 = "You hope to topple my machines with those pathetic weapons?",
	YellPullKingaroth3 = "Prepare to be deconstructed."
})

---------------------------
-- Varimathras --
---------------------------
L= DBM:GetModLocalization(1983)

L:SetMiscLocalization({
	YellPullVarimathras = "Draw your blades! I will show you torment!",
	YellPullVarimathras2 = "Come, then. We will trade pain for pain!"
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
	timerBossIncoming		= DBM_INCOMING
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
	IgnoreFirstKick		= "With this option, very first interrupt is excluded in rotation (Requires raid leader)"
})

L:SetMiscLocalization({
	YellPullCoven = "I can't wait to hear your flesh sizzle."
})

---------------------------
-- Aggramar --
---------------------------
L= DBM:GetModLocalization(1984)

L:SetWarningLocalization({
	Phase1 = "Phase 2 soon",
	Phase2 = "Фаза 2",
	Phase3 = "Phase 3 soon",
	Phase4 = "Фаза 3"
})

L:SetOptionLocalization({
	Phase1 = "Warn in advance about phase 2 (on ~83%)",
	Phase2 = "Объявлять фазу 2",
	Phase3 = "Warn in advance about phase 3 (on ~43%)",
	Phase4 = "Объявлять фазу 3",
	ignoreThreeTank	= "Filter Rend/Foe Taunt special warnings when using 3 or more tanks (since DBM can't determine exact tanking rotation in this setup). If any tanks die and it drops to 2, filter auto disables"
})

L:SetMiscLocalization({
	YellPullAggramar = "You will burn!",
	Foe			=	"Foe",
	Rend		=	"Rend",
	Tempest 	=	"Tempest",
	Current		=	"Current:"
})

---------------------------
-- Argus the Unmaker --
---------------------------
L= DBM:GetModLocalization(2031)

L:SetWarningLocalization({
	Phase1 = "Phase 2 soon",
	Phase2 = "Phase 2",
	Phase3 = "Phase 3 soon",
	Phase4 = "Phase 3",
	Phase5 = "Phase 4 soon",
	Phase6 = "Phase 4"
})

L:SetTimerLocalization({
	timerSargSentenceCD	= "Sentence CD (%s)"
})

L:SetOptionLocalization({
	Phase1 = "Warn in advance about phase 2 (on ~74%)",
	Phase2 = "Announce Phase 2",
	Phase3 = "Warn in advance about phase 3 (on ~44%)",
	Phase4 = "Announce Phase 3",
	Phase5 = "Warn in advance about phase 4 (on 1 Constellar Designate)",
	Phase6 = "Announce Phase 4",
	timerSargSentenceCD = DBM_CORE_AUTO_TIMER_OPTIONS["cdcount"]:format(257966)
})

L:SetMiscLocalization({
	YellPullArgus = "Death! Death and pain!",
	SeaText		=	"{rt6} Haste/Vers",
	SkyText		=	"{rt5} Crit/Mast",
	Blight		=	"Blight",
	Burst		=	"Burst",
	Sentence	=	"Sentence",
	Bomb		=	"Bomb"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("AntorusTrash")

L:SetGeneralLocalization({
	name =	"Antorus Trash"
})
