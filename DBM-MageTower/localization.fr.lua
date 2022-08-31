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
	Twins1 = "Je ne peux pas te laisser déchaîner ta puissance sur Azeroth, Raëst. Si tu n’abandonnes pas, je serai forcé de te détruire !", --
	ErdrisThorn1 = "Il est hors de question que je reste en arrière ! Les attaques sur mon village doivent cesser !", --
	Agatha1 = "En ce moment même, mes sayaad séduisent vos mages les plus faibles. Vos alliés se rendront de leur plein gré à la Légion !" --
})
