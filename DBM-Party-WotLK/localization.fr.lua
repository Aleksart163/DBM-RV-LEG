if GetLocale() ~= "frFR" then return end
local L

local optionWarning		= "Activer l'alerte : %s"
local optionPreWarning	= "Activer la pré-alerte : %s"

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

------------
-- Loken --
------------
L = DBM:GetModLocalization(600)

---------
--Trash--
---------
L = DBM:GetModLocalization("HoLTrash")

L:SetGeneralLocalization({
	name = "Les salles de Foudre Trash"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetMiscLocalization({
	RPLoken = "J'ai vu la grandeur et la décadence des empires... La naissance et l'extinction d'espèces entières... Pendant d'innombrables millénaires, la seule constante a été la stupidité des mortels. Votre présence ici ne fait que le confirmer."
})

---------------
-- The Nexus --
---------------
-- Anomalus --
--------------
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
	SplitTrigger1 	= "Il y en aura assez pour tout le monde.",
	SplitTrigger2 	= "Vous allez être trop bien servis !"
})

-----------------
-- Keristrasza --
-----------------
L = DBM:GetModLocalization(621)

---------------------------------
-- Commander Kolurg/Stoutbeard --
---------------------------------
L = DBM:GetModLocalization("Commander")

local commander = "Unknown"
if UnitFactionGroup("player") == "Alliance" then
	commander = "Commandant Kolurg"
elseif UnitFactionGroup("player") == "Horde" then
	commander = "Commandant Rudebarbe"
end

L:SetGeneralLocalization({
	name = commander
})

----------------------
-- Utgarde Pinnacle --
------------------------
-- Skadi the Ruthless --
------------------------
L = DBM:GetModLocalization(643)

-------------------
--  King Ymiron  --
-------------------
L = DBM:GetModLocalization(644)

-------------
--Трэш-мобы--
-------------
L = DBM:GetModLocalization("UPTrash")

L:SetGeneralLocalization({
	name = "Cime d’Utgarde Trash"
})

-------------------------
--  Svala Sorrowgrave  --
-------------------------
L = DBM:GetModLocalization(641)

--[[L:SetTimerLocalization({
	timerRoleplay		= "Свала Вечноскорбящая активируется" --Добавить если получится
})]]

--[[L:SetOptionLocalization({
	timerRoleplay		= "Отсчет времени для представления перед активацией Свалы Вечноскорбящей" --Добавить если получится
})]]

L:SetMiscLocalization({
	SvalaRoleplayStart	= "Votre seigneurie ! J`ai fait ainsi que vous m`aviez commandé, et j`implore à présent votre bénédiction !" --специально от Няша
})

---------------------
-- Gortok Palehoof --
---------------------
L = DBM:GetModLocalization(642)

---------------------
-- Pit of Saron --
-------------------
--  Ick and Krick  --
-------------------
L = DBM:GetModLocalization(609)

L:SetMiscLocalization({
	Barrage		= "%s commence à invoquer rapidement des mines explosives !"
})

----------------------------
--  Forgemaster Garfrost  --
----------------------------
L = DBM:GetModLocalization(608)

L:SetMiscLocalization({
	SaroniteRockThrow			= "%s vous lance un énorme bloc de saronite !" --специально от Няша
})

----------------------------
--  Scourgelord Tyrannus  --
----------------------------
L = DBM:GetModLocalization(610)

L:SetMiscLocalization({
	CombatStart		= "Hélas, mes très, très braves aventuriers, votre intrusion touche à sa fin. Entendez-vous le claquement de l'acier sur les os qui monte du tunnel, derrière vous ? C'est le son de votre mort imminente.",
	HoarfrostTarget	= "^%%s fixe (%S+) du regard et prépare une attaque de glace !",
	YellCombatEnd	= "Impossible.... Frigecroc.... avertis...."
})
