if GetLocale() ~= "deDE" then return end
local L

----------------------------------
--  Ahn'Kahet: The Old Kingdom  --
----------------------------------
--  Prince Taldaram  --
-----------------------
L = DBM:GetModLocalization(581)

-------------------
--  Elder Nadox  --
-------------------
L = DBM:GetModLocalization(580)

---------------------------
--  Jedoga Shadowseeker  --
---------------------------
L = DBM:GetModLocalization(582)

---------------------
--  Herald Volazj  --
---------------------
L = DBM:GetModLocalization(584)

----------------
--  Amanitar  --
----------------
L = DBM:GetModLocalization(583)

---------------
--  Gundrak  --
----------------
--  Slad'ran  --
----------------
L = DBM:GetModLocalization(592)

---------------
--  Moorabi  --
---------------
L = DBM:GetModLocalization(594)

-------------------------
--  Drakkari Colossus  --
-------------------------
L = DBM:GetModLocalization(593)

-----------------
--  Gal'darah  --
-----------------
L = DBM:GetModLocalization(596)

-------------------------
--  Eck the Ferocious  --
-------------------------
L = DBM:GetModLocalization(595)

--------------------------
--  Halls of Lightning  --
--------------------------
--  General Bjarngrim  --
-------------------------
L = DBM:GetModLocalization(597)

-------------
--  Ionar  --
-------------
L = DBM:GetModLocalization(599)

---------------
--  Volkhan  --
---------------
L = DBM:GetModLocalization(598)

-------------
--  Loken  --
-------------
L = DBM:GetModLocalization(600)

---------
--Trash--
---------
L = DBM:GetModLocalization("HoLTrash")

L:SetGeneralLocalization({
	name = "Trash des Die Hallen der Blitze"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetMiscLocalization({
	RPLoken = "Ich habe den Aufstieg und Untergang von Imperien gesehen... Geburt und Ausrottung ganzer Spezies... Unzählige Jahrtausende lang war die Dummheit der Sterblichen die einzige Konstante. Eure Anwesenheit hier bestätigt das."
})

-----------------
--  The Nexus  --
-----------------
--  Anomalus  --
----------------
L = DBM:GetModLocalization(619)

-------------------------------
--  Ormorok the Tree-Shaper  --
-------------------------------
L = DBM:GetModLocalization(620)

----------------------------
--  Grand Magus Telestra  --
----------------------------
L = DBM:GetModLocalization(618)

L:SetMiscLocalization({
	SplitTrigger1		= "Es ist genug von mir für alle da.",
	SplitTrigger2		= "Ich teile mehr aus, als ihr verkraften könnt"
})

-------------------
--  Keristrasza  --
-------------------
L = DBM:GetModLocalization(621)

-----------------------------------
--  Commander Kolurg/Stoutbeard  --
-----------------------------------
L = DBM:GetModLocalization("Commander")

local commander = "Eingefrorener Kommandant"
if UnitFactionGroup("player") == "Alliance" then
	commander = "Kommandant Kolurg"
elseif UnitFactionGroup("player") == "Horde" then
	commander = "Kommandant Starkbart"
end

L:SetGeneralLocalization({
	name = commander
})

------------------------
--  Utgarde Pinnacle  --
--------------------------
--  Skadi the Ruthless  --
--------------------------
L = DBM:GetModLocalization(643)

L:SetMiscLocalization({
	CombatStart		= "Welche Hunde wagen es, hier einzudringen? Auf sie, meine Brüder! Ein Fest für den, der mir ihre Köpfe bringt!",
	Phase2			= "Ihr räudigen Halunken! Eure Leichen werden feine Appetithappen für meinen neuen Drachen abgeben!"
})

-------------------
--  King Ymiron  --
-------------------
L = DBM:GetModLocalization(644)

-------------
--Трэш-мобы--
-------------
L = DBM:GetModLocalization("UPTrash")

L:SetGeneralLocalization({
	name = "Trash des Turm Utgarde"
})

-------------------------
--  Svala Sorrowgrave  --
-------------------------
L = DBM:GetModLocalization(641)

L:SetTimerLocalization({
	timerRoleplay		= "Svala Grabesleid aktiv"
})

L:SetOptionLocalization({
	timerRoleplay		= "Zeige Dauer des Rollenspiels bevor Svala Grabesleid aktiv wird"
})

L:SetMiscLocalization({
	SvalaRoleplayStart	= "Mein Meister! Ich tat, was Ihr verlangtet, und ersuche Euch um Euren Segen!"
})

-----------------------
--  Gortok Palehoof  --
-----------------------
L = DBM:GetModLocalization(642)

--------------------
--  Pit of Saron  --
---------------------
--  Ick and Krick  --
---------------------
L = DBM:GetModLocalization(609)

L:SetMiscLocalization({
	Barrage	= "%s fängt an, schnell explosive Minen herbeizuzaubern!"
})

----------------------------
--  Forgemaster Garfrost  --
----------------------------
L = DBM:GetModLocalization(608)

L:SetOptionLocalization({
	AchievementCheck			= "Verkünde Warnungen für den Erfolg 'Elfer raus!' an Gruppe"
})

L:SetMiscLocalization({
	SaroniteRockThrow	= "%s schleudert Euch einen massiven Saronitstein entgegen!",
	AchievementWarning	= "Warnung: %s hat %d Stapel von Permafrost",
	AchievementFailed	= ">> ERFOLG FEHLGESCHLAGEN: %s hat %d Stapel von Permafrost <<"
})

----------------------------
--  Scourgelord Tyrannus  --
----------------------------
L = DBM:GetModLocalization(610)

L:SetMiscLocalization({
	CombatStart	= "Ach, Ihr tapferen, tapferen Helden, Euer kleiner Aufstand endet hier. Hört Ihr das Geklapper von Stahl und Knochen aus dem Tunnel hinter Euch? Das ist das Geräusch Eures Todes.",
	HoarfrostTarget	= "Der Frostwyrm Raufang wendet sich (%S+) zu und bereitet einen eisigen Angriff vor!",
	YellCombatEnd	= "Unmöglich... Raufang... warne..."
})
