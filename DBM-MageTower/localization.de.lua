if GetLocale() ~= "deDE" then return end
local L

--Прошляпанное очко Мурчаля ✔

------------------------
-- Mage Tower: TANK --
------------------------
L= DBM:GetModLocalization("Kruul")

L:SetGeneralLocalization({
	name =	"Rückkehr des Hochlords"
})

------------------------
-- Mage Tower: Healer --
------------------------
L= DBM:GetModLocalization("ErdrisThorn")

L:SetGeneralLocalization({
	name =	"Das Ende der erwachten Bedrohung"
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("FelTotem")

L:SetGeneralLocalization({
	name =	"Sturz der Teufelstotems"
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("ImpossibleFoe")

L:SetGeneralLocalization({
	name =	"Ein unmöglicher Feind"
})

L:SetMiscLocalization({
	impServants =	"Tötet die Wichteldiener, bevor sie Agatha Energie gewähren!"--needs to be verified (video-captured translation)
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("Queen")

L:SetGeneralLocalization({
	name =	"Zorn der Gottkönigin"
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("Twins")

L:SetGeneralLocalization({
	name =	"Zwillinge bezwingen"
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("Xylem")

L:SetGeneralLocalization({
	name =	"Ein Auge zudrücken"
})

------------------------
-- Mage Tower: Timers --
------------------------
L= DBM:GetModLocalization("Timers")

L:SetGeneralLocalization({
	name = "Kampfstart-Timer"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetMiscLocalization({
	Kruul = "Arrogantes Pack! Ich trage die Seelen von tausend unterworfenen Welten in mir!",
	Twins = "Ich kann nicht zulassen, dass du deine Macht auf Azeroth entfesselst, Raest. Wenn du nicht einhältst, bin ich gezwungen, dich zu vernichten!",
	ErdrisThorn1 = "Nie im Leben ziehe ich mich zurück! Wir müssen den Angriffen auf mein Dorf ein Ende setzen!"
})
