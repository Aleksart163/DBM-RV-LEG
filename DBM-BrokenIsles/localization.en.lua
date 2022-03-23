local L

-----------------------
-- Ana-Mouz --
-----------------------
L= DBM:GetModLocalization(1790)

-----------------------
-- Apocron --
-----------------------
L= DBM:GetModLocalization(1956)

-----------------------
-- Brutallus --
-----------------------
L= DBM:GetModLocalization(1883)

-----------------------
-- Calamir --
-----------------------
L= DBM:GetModLocalization(1774)

-----------------------
-- Drugon the Frostblood --
-----------------------
L= DBM:GetModLocalization(1789)

-----------------------
-- Flotsam --
-----------------------
L= DBM:GetModLocalization(1795)

-----------------------
-- Humongris --
-----------------------
L= DBM:GetModLocalization(1770)

-----------------------
-- Levantus --
-----------------------
L= DBM:GetModLocalization(1769)

-----------------------
-- Malificus --
-----------------------
L= DBM:GetModLocalization(1884)

-----------------------
-- Na'zak the Fiend --
-----------------------
L= DBM:GetModLocalization(1783)

-----------------------
-- Nithrogg --
-----------------------
L= DBM:GetModLocalization(1749)

-----------------------
-- Shar'thos --
-----------------------
L= DBM:GetModLocalization(1763)

-----------------------
-- Si'vash --
-----------------------
L= DBM:GetModLocalization(1885)

-----------------------
-- The Soultakers --
-----------------------
L= DBM:GetModLocalization(1756)

-----------------------
-- Withered J'im --
-----------------------
L= DBM:GetModLocalization(1796)

------------------
--Капитаны башен--
------------------
L = DBM:GetModLocalization("Captainstower")

L:SetGeneralLocalization({
	name ="Warden Tower Assault"
})

----------------
--Редкие враги--
----------------
L = DBM:GetModLocalization("RareEnemies")

L:SetGeneralLocalization({
	name ="Rare enemies"
})

L:SetTimerLocalization({
	timerRoleplay = GUILD_INTEREST_RP
})

L:SetOptionLocalization({
	timerRoleplay = "Countdown to the start of the battle with Skul'vrax"
})

L:SetMiscLocalization({
	PullSkulvrax = "I... survived the fall."
})
