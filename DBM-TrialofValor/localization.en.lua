local L

---------------
-- Odyn --
---------------
L= DBM:GetModLocalization(1819)

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
	phaseThree		= "Your efforts are for naught, mortals! Odyn will NEVER be free!",
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
	timerRoleplay = "Show timer to the start of the battle with Odyn"
})

L:SetTimerLocalization({
	timerRoleplay = GUILD_INTEREST_RP
})

L:SetMiscLocalization({
	RP1 = "Champions! You have spilled the blood of Helya's minions. The time has come to enter Helheim itself and end the sea witch's dark reign. But first... a final challenge!"
})
