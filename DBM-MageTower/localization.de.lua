if GetLocale() ~= "deDE" then return end

local L

--Прошляпанное очко Мурчаля ✔✔

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
	impServants = "Tötet die Wichteldiener, bevor sie Agatha Energie gewähren!" --
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("Queen")

L:SetGeneralLocalization({
	name =	"Zorn der Gottkönigin"
})

L:SetMiscLocalization({
	MurchalProshlyapRP = "Was... tue ich da? Das ist falsch!" --
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("Twins")

L:SetGeneralLocalization({
	name =	"Zwillinge bezwingen"
})

L:SetMiscLocalization({
	TwinsRP1 = "Absolut nutzlos! Tritt zur Seite, Bruder, während ich deine Arbeit mache.", --
	TwinsRP2 = "Wieder einmal muss ich hinter dir aufräumen, Bruder!" --
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
	Kruul = "Arrogantes Pack! Ich trage die Seelen von tausend unterworfenen Welten in mir!", --
	Twins1 = "Ich kann nicht zulassen, dass du deine Macht auf Azeroth entfesselst, Raest. Wenn du nicht einhältst, bin ich gezwungen, dich zu vernichten!", --
	ErdrisThorn1 = "Nie im Leben ziehe ich mich zurück! Wir müssen den Angriffen auf mein Dorf ein Ende setzen!", --
	Agatha1 = "Meine Sayaad bringen Eure schwachen Magier bereits in Versuchung. Eure Verbündeten werden sich widerstandslos der Legion beugen.", --
	Sigryn1 = "Ihr könnt Euch nicht ewig hinter diesen Mauern verstecken, Odyn!" --
--	Sigryn2 = "What's this? The outsider has come to stop me? I owe you much, but I cannot allow you to impede my quest for justice!"
})
