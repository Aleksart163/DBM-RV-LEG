if GetLocale() ~= "deDE" then return end

local L

---------------
-- Odyn --
---------------
L= DBM:GetModLocalization(1819)

L:SetOptionLocalization({
	ShowProshlyapMurchal = "Spezialwarnung für $spell:227629 (nur als Leiter/Assistent)"
})

L:SetMiscLocalization({
	ProshlyapMurchal = "%s %s in 5 Sekunden"
})

---------------------------
-- Guarm --
---------------------------
L= DBM:GetModLocalization(1830)

L:SetOptionLocalization({
	YellActualRaidIcon		= "Ändere alle DBM Schreie für instabiler Schaum derart, dass statt der entsprechenden Farbe das tatsächlich auf das Ziel gesetzte Zeichen angesagt wird (nur als Schlachtzugsleiter)",
	FilterSameColor			= "Unterdrücke Zeichensetzung, Schreie und Spezialwarnungen für instabile Schäume, falls diese den bestehenden Farben der Spieler entsprechen"
})

---------------------------
-- Helya --
---------------------------
L= DBM:GetModLocalization(1829)

L:SetTimerLocalization({
	OrbsTimerText		= "Nächste Kugeln (%d-%s)"
})

L:SetMiscLocalization({
	phaseThree		= "Eure Mühen sind umsonst, Sterbliche! Odyn wird NIEMALS frei sein!",
	near			= "Nähe",--needs to be verified (video-captured translation) ("Ein Zuschlagendes Tentakel erscheint in Helyas Nähe!")
	far				= "weit",--needs to be verified (video-captured translation) ("Ein Zuschlagendes Tentakel erscheint weit von Helya entfernt!")
	multiple		= "Mehrere"--needs to be verified (unused)
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("TrialofValorTrash")

L:SetGeneralLocalization({
	name =	"Trash der Prüfung der Tapferkeit"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetMiscLocalization({
	RP1 = "Champions! Ihr habt das Blut von Helyas Schergen vergossen. Es ist Zeit, die Schreckensherrschaft der Meereshexe in Helheim zu beenden. Doch zuerst eine letzte Herausforderung!"
})
