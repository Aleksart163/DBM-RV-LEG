if GetLocale() ~= "frFR" then return end

local L

--Прошляпанное очко Мурчаля ✔✔

------------------------
-- Mage Tower: TANK --
------------------------
L= DBM:GetModLocalization("Kruul")

L:SetGeneralLocalization({
	name =	"Le retour du généralissime"
})

------------------------
-- Mage Tower: Healer --
------------------------
L= DBM:GetModLocalization("ErdrisThorn")

L:SetGeneralLocalization({
	name =	"Halte au Ressuscité"
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("FelTotem")

L:SetGeneralLocalization({
	name =	"La chute des Totems-Fétides"
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("ImpossibleFoe")

L:SetGeneralLocalization({
	name =	"Une adversaire impossible"
})

L:SetMiscLocalization({
	impServants = "Tuez les diablotins serviteurs avant qu’ils énergisent Agatha "
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("Queen")

L:SetGeneralLocalization({
	name = "La fureur de la Déesse-Reine"
})

L:SetMiscLocalization({
	MurchalProshlyapRP = "Que… qu’est-ce que je suis en train de faire ? C’est impardonnable !" --
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("Twins")

L:SetGeneralLocalization({
	name = "Gêner les jumeaux"
})

L:SetMiscLocalization({
	TwinsRP1 = "Inutile ! Laisse-moi faire ce dont tu ne peux pas te charger, mon frère.", --
	TwinsRP2 = "Une fois encore, je dois faire le ménage derrière toi, mon frère !" --
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("Xylem")

L:SetGeneralLocalization({
	name = "Fermer l’œil"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetMiscLocalization({
	Xylem = "Non… Je n’aurais jamais dû…" --
})

------------------------
-- Mage Tower: Timers --
------------------------
L= DBM:GetModLocalization("Timers")

L:SetGeneralLocalization({
	name = "Chronomètres de début de bataille"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetMiscLocalization({
	Kruul = "Arrogants imbéciles ! Je détiens la puissance des âmes d’un millier de mondes !", --
	Twins = "Je ne peux pas te laisser déchaîner ta puissance sur Azeroth, Raëst. Si tu n’abandonnes pas, je serai forcé de te détruire !", --
	ErdrisThorn = "Il est hors de question que je reste en arrière ! Les attaques sur mon village doivent cesser !", --
	Agatha = "En ce moment même, mes sayaad séduisent vos mages les plus faibles. Vos alliés se rendront de leur plein gré à la Légion !", --
	Sigryn = "Tu ne pourra pas te cacher éternellement derrière ces murs, Odyn !", --
	Xylem = "Grâce à l’iris de focalisation, je peux imprégner ma splendide personne de toute l’énergie arcanique des lignes telluriques d’Azeroth !" -- Trop tard, chasseresse !
})
