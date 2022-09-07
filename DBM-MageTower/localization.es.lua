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
	impServants = "¡Asesina a los Sirvientes diablillos antes de que aumenten la energía de Agatha!" --
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("Queen")

L:SetGeneralLocalization({
	name =	"La furia de la Reina diosa"
})

L:SetMiscLocalization({
	SigrynRP1 = "¿Qué... qué estoy haciendo? ¡Esto no está bien!"
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("Twins")

L:SetGeneralLocalization({
	name =	"Fiasco de los gemelos"
})

L:SetMiscLocalization({
	TwinsRP1 = "¡Inútil! Hazte a un lado. Yo me encargaré de lo que no eres capaz de hacer.", --
	TwinsRP2 = "¡Una vez más, debo arreglar tu desorden, hermano!" --
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
	name = "Temporizadores del principio de la batalla"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetMiscLocalization({
	Kruul = "¡Estúpidos arrogantes! ¡Tengo el poder de las almas de mil mundos conquistados!", --
	Twins1 = "Raest, no puedo permitir que liberes tu poder sobre Azeroth. ¡Si no te detienes, tendré que destruirte!", --
	ErdrisThorn1 = "¡No me quedaré de brazos cruzados! ¡Hay que detener los ataques a mi poblado!", --
	Agatha1 = "En este momento, mis sayaad están tentando a tus débiles magos. ¡Tus aliados se entregarán a la Legión por propia voluntad!", --
	Sigryn1 = "¡No puedes esconderte detrás de estos muros por siempre, Odyn!"
})
