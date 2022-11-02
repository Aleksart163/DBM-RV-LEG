if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L

--Прошляпанное очко Мурчаля ✔✔

------------------------
-- Mage Tower: TANK --
------------------------
L= DBM:GetModLocalization("Kruul")

if GetLocale() == "esES" then
L:SetGeneralLocalization({
	name =	"El retorno del Alto Señor" --
})
else
L:SetGeneralLocalization({
	name =	"El regreso del Alto señor" --
})
end

------------------------
-- Mage Tower: Healer --
------------------------
L= DBM:GetModLocalization("ErdrisThorn")

if GetLocale() == "esES" then
L:SetGeneralLocalization({
	name =	"Fin a la amenaza resucitada" --
})
else
L:SetGeneralLocalization({
	name =	"La amenaza no regresará" --
})
end

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("FelTotem")

if GetLocale() == "esES" then
L:SetGeneralLocalization({
	name =	"La caída de los Tótem Vil" --
})
else
L:SetGeneralLocalization({
	name =	"La caída de Viltótem" --
})
end

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("ImpossibleFoe")

if GetLocale() == "esES" then
L:SetGeneralLocalization({
	name = "Rival imposible" --
})

L:SetMiscLocalization({
	impServants = "¡Acaba con los sirvientes diablillos antes de que potencien a Agatha!" --
})
else
L:SetGeneralLocalization({
	name = "Un enemigo imposible" --
})

L:SetMiscLocalization({
	impServants = "¡Asesina a los Sirvientes diablillos antes de que aumenten la energía de Agatha!" --
})
end

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("Queen")

if GetLocale() == "esES" then
L:SetGeneralLocalization({
	name =	"La furia de la Reina diosa" --
})

L:SetMiscLocalization({
	MurchalProshlyapRP = "¿Qué... qué estoy haciendo? ¡Esto no está bien!" --
})
else
L:SetGeneralLocalization({
	name =	"La furia de la Reina divina" --
})

L:SetMiscLocalization({
	MurchalProshlyapRP = "¿Qué... qué estoy haciendo? ¡Esto no está bien!" --
})
end

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("Twins")

if GetLocale() == "esES" then
L:SetGeneralLocalization({
	name =	"Fiasco de los gemelos" --
})

L:SetMiscLocalization({
	TwinsRP1 = "¡Inútil! Apártate mientras hago lo que tú no puedes, hermano.", --
	TwinsRP2 = "¡Siempre me toca a mí deshacer tus entuertos!" -- 
})
else
L:SetGeneralLocalization({
	name =	"Frustración gemela" --
})

L:SetMiscLocalization({
	TwinsRP1 = "¡Inútil! Hazte a un lado. Yo me encargaré de lo que no eres capaz de hacer.", --
	TwinsRP2 = "¡Una vez más, debo arreglar tu desorden, hermano!" --
})
end

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("Xylem")

if GetLocale() == "esES" then
L:SetGeneralLocalization({
	name =	"Cerrar el ojo" --
})
else
L:SetGeneralLocalization({
	name =	"Ojos cerrados" --
})
end

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

if GetLocale() == "esES" then
L:SetMiscLocalization({
	Xylem = "No... ¡Esto no está bien!" --
})
else
L:SetMiscLocalization({
	Xylem = "No... ¡no puede ser!" --
})
end

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

if GetLocale() == "esES" then
L:SetMiscLocalization({
	Kruul = "Qué arrogancia. ¡Sentiréis el poder de las almas de mil mundos conquistados!", --
	Twins = "No pienso dejar que desates ese poder, Raest. Si no te rindes, ¡me veré obligado a destruirte!", --
	ErdrisThorn = "¡Ni hablar! ¡Esta es mi aldea y no pienso dejar que la ataquen!", --
	Agatha = "En estos momentos, mis sayaad están tentando a vuestros magos. ¡Tus aliados se rendirán voluntariamente a la Legión!", --
	Sigryn = "¡No podrás esconderte para siempre tras esas paredes, Odyn!", --
	Xylem = "Con el iris de enfoque en mi poder, ¡puedo absorber la energía Arcana de las líneas Ley de Azeroth!" --
})
else
L:SetMiscLocalization({
	Kruul = "¡Estúpidos arrogantes! ¡Tengo el poder de las almas de mil mundos conquistados!", --
	Twins = "Raest, no puedo permitir que liberes tu poder sobre Azeroth. ¡Si no te detienes, tendré que destruirte!", --
	ErdrisThorn = "¡No me quedaré de brazos cruzados! ¡Hay que detener los ataques a mi poblado!", --
	Agatha = "En este momento, mis sayaad están tentando a tus débiles magos. ¡Tus aliados se entregarán a la Legión por propia voluntad!", --
	Sigryn = "¡No puedes esconderte detrás de estos muros por siempre, Odyn!", --
	Xylem = "Con el Iris de enfoque bajo mi control, puedo absorber la energía arcana de las líneas Ley de Azeroth hacia mi magnífico ser." --
})
end
