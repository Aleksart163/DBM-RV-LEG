local L

---------------
-- Odyn --
---------------
L= DBM:GetModLocalization(1819)

L:SetOptionLocalization({
	ShowProshlyapMurchal = "Show announcements for $spell:227629 (Requires raid leader)"
})

L:SetMiscLocalization({
	MurchalProshlyapation2 = "Well done... so far! But I will judge for myself whether you are worthy!",
	MurchalProshlyapation3 = "It seems I have been too gentle. Have at thee!",
	ProshlyapMurchal = "%s %s in 5 sec"
})

---------------------------
-- Guarm --
---------------------------
L= DBM:GetModLocalization(1830)

L:SetOptionLocalization({
	YellActualRaidIcon		= "Change all DBM yells for foam to say icon set on player instead of matching colors (Requires raid leader)",
	FilterSameColor			= "Do not set icons, yell, or give special warning for Foams if they match players existing color"
})

---------------------------
-- Helya --
---------------------------
L= DBM:GetModLocalization(1829)

L:SetTimerLocalization({
	OrbsTimerText		= "Next Orbs (%d-%s)"
})

L:SetMiscLocalization({
	MurchalProshlyapation2 = "Soon you will join the ranks of my Kvaldir!",
	MurchalProshlyapation3 = "Your efforts are for naught, mortals! Odyn will NEVER be free!",
	near			= "near",
	far				= "far",
	multiple		= "Multiple"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("TrialofValorTrash")

L:SetGeneralLocalization({
	name =	"Trial of Valor Trash"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetMiscLocalization({
	RP1 = "Champions! You have spilled the blood of Helya's minions. The time has come to enter Helheim itself and end the sea witch's dark reign. But first... a final challenge!"
})
