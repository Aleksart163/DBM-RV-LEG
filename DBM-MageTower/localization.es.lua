if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

--Прошляпанное очко Мурчаля ✔

------------------------
-- Mage Tower: TANK --
------------------------
L= DBM:GetModLocalization("Kruul")

L:SetGeneralLocalization({
	name =	"El retorno del Alto Señor"
})

L:SetWarningLocalization({
	Phase2 = "Pronto la fase 2"
})

L:SetOptionLocalization({
	Phase2 = "Advertir de antemano sobre la fase 2 (en un ~10%)"
})

------------------------
-- Mage Tower: Healer --
------------------------
L= DBM:GetModLocalization("ErdrisThorn")

L:SetGeneralLocalization({
	name =	"Fin a la amenaza resucitada"
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("FelTotem")

L:SetGeneralLocalization({
	name =	"La caída de los Tótem Vil"
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("ImpossibleFoe")

L:SetGeneralLocalization({
	name =	"Rival imposible"
})

L:SetMiscLocalization({
	impServants = "¡Asesina a los Sirvientes diablillos antes de que aumenten la energía de Agatha!"
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("Queen")

L:SetGeneralLocalization({
	name =	"La furia de la Reina diosa"
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("Twins")

L:SetGeneralLocalization({
	name =	"Fiasco de los gemelos"
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("Xylem")

L:SetGeneralLocalization({
	name =	"Cerrar el ojo"
})

------------------------
-- Mage Tower: Timers --
------------------------
L= DBM:GetModLocalization("Timers")

L:SetGeneralLocalization({
	name = "Temporizadores de inicio de batalla"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetMiscLocalization({
	Kruul = "¡Estúpidos arrogantes! ¡Tengo el poder de las almas de mil mundos conquistados!",
	Twins1 = "Raest, no puedo permitir que liberes tu poder sobre Azeroth. ¡Si no te detienes, tendré que destruirte!",
	ErdrisThorn1 = "¡No me quedaré de brazos cruzados! ¡Hay que detener los ataques a mi poblado!",
	Agatha1 = "En este momento, mis sayaad están tentando a tus débiles magos. ¡Tus aliados se entregarán a la Legión por propia voluntad!"
})
