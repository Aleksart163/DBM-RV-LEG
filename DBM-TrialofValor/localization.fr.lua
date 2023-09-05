if GetLocale() ~= "frFR" then return end
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
	MurchalProshlyapation2 = "Vous rejoindrez bientôt les rangs de mes kvaldirs !",
	MurchalProshlyapation3 = "Vos efforts sont vains, mortels ! Odyn ne retrouvera JAMAIS sa liberté !",
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
	RP1 = "Champions ! Vous avez versé le sang des serviteurs de Helya. Il est temps d’envahir Helheim et de mettre fin au règne de la sorcière. Mais d’abord… un ultime défi !" --
})
