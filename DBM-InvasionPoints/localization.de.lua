if GetLocale() ~= "deDE" then return end

local L

-----------------------
-- Inquisitor Meto --
-----------------------
L= DBM:GetModLocalization(2012)

L:SetMiscLocalization({
	Pull = "Der Tod ist Euer Schicksal." --
})

-----------------------
-- Occularus --
-----------------------
L= DBM:GetModLocalization(2013)

L:SetMiscLocalization({
	Pull = "Ich sehe die Schwäche in Eurer Seele!" --
})

-----------------------
-- Sotanathor --
-----------------------
L= DBM:GetModLocalization(2014)

L:SetMiscLocalization({
	Pull = "Come, small ones. Die by my hand!"
})

-----------------------
-- Mistress Alluradel --
-----------------------
L= DBM:GetModLocalization(2011)

L:SetMiscLocalization({
	Pull = "Neues Spielzeug? Wie verlockend!" --
})

-----------------------
-- Matron Folnuna --
-----------------------
L= DBM:GetModLocalization(2010)

L:SetMiscLocalization({
	Pull = "Ja... kommt näher, kleine Wesen!" --
})

-----------------------
-- Pit Lord Vilemus --
-----------------------
L= DBM:GetModLocalization(2015)

L:SetMiscLocalization({
	Pull = "Alle Welten werden im Teufelsfeuer brennen!" --
})

-----------
-- Trash --
-----------
L= DBM:GetModLocalization("InvasionPointsTrash")

L:SetGeneralLocalization({
	name = "Трэш Точек вторжения"
})

L:SetMiscLocalization{
	MurchalOchkenProshlyapen = "Schnell zu einer Kohlenpfanne!", --Schnell zu einer Kohlenpfanne! [Blitzeis] kommt!
	MurchalOchkenProshlyapen2 = "Dieses Gebiet wird für eine" --Dieses Gebiet wird für eine [Auslöschung] anvisiert!
}
