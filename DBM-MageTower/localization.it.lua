if GetLocale() ~= "itIT" then return end

local L

--Прошляпанное очко Мурчаля ✔✔

------------------------
-- Mage Tower: TANK --
------------------------
L= DBM:GetModLocalization("Kruul")

L:SetGeneralLocalization({
	name =	"Il ritorno del Gran Signore" --
})

------------------------
-- Mage Tower: Healer --
------------------------
L= DBM:GetModLocalization("ErdrisThorn")

L:SetGeneralLocalization({
	name =	"Fine del Pericolo Risorto" --
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("FelTotem")

L:SetGeneralLocalization({
	name =	"La caduta dei Totem Vile" --
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("ImpossibleFoe")

L:SetGeneralLocalization({
	name =	"Un nemico impossibile" --
})

L:SetMiscLocalization({
	impServants = "Uccidi gli Imp Servitori prima che potenzino Agatha!" --
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("Queen")

L:SetGeneralLocalization({
	name =	"Furia della Dea-Sovrana" --
})

L:SetMiscLocalization({
	MurchalProshlyapRP = "Cosa... Cosa sto facendo? Questo non è giusto!" --
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("Twins")

L:SetGeneralLocalization({
	name =	"Contrastare i Gemelli" --
})

L:SetMiscLocalization({
	TwinsRP1 = "Inutile! Fatti da parte e lascia fare a me, fratello.", --
	TwinsRP2 = "Ancora una volta mi tocca rimediare ai tuoi disastri, fratello!" --
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("Xylem")

L:SetGeneralLocalization({
	name =	"Chiudere l'occhio" --
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetMiscLocalization({
	Xylem = "No... non può essere!" --
})

------------------------
-- Mage Tower: Timers --
------------------------
L= DBM:GetModLocalization("Timers")

L:SetGeneralLocalization({
	name = "Combat start timers"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetMiscLocalization({
	Kruul = "Stolti arroganti! Io brandisco il potere di migliaia di mondi conquistati!", --
	Twins = "Non posso permetterti di scatenare il tuo potere su Azeroth, Raest. Se non ti arrendi, sarò costretto ad ucciderti.", --
	ErdrisThorn = "Non ci penso nemmeno ad andarmene! Devo fermare gli attacchi al mio villaggio!", --
	Agatha = "Proprio in questo momento le mie Sayaad stanno corrompendo i vostri deboli Maghi. I tuoi alleati si arrenderanno alla Legione!", --
	Sigryn = "Non puoi nasconderti dietro queste mura per sempre, Odyn!", --
	Xylem = "Con l'Iride Focalizzante nelle mie mani, posso convogliare l'energia arcana delle linee di faglia di Azeroth direttamente nel mio magnifico corpo!" -- Arrivi tardi!
})
