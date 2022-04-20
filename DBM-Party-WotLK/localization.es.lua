if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

---------------------------------
-- Ahn'Kahet: El Antiguo Reino --
---------------------------------
-----------------------
-- Príncipe Taldaram --
-----------------------
L = DBM:GetModLocalization(581)

--------------------
-- Ancestro Nadox --
--------------------
L = DBM:GetModLocalization(580)

-------------------------
-- Jedoga Buscasombras --
-------------------------
L = DBM:GetModLocalization(582)

--------------------
-- Heraldo Volazj --
--------------------
L = DBM:GetModLocalization(584)

--------------
-- Amanitar --
--------------
L = DBM:GetModLocalization(583)

-------------
-- Gundrak --
-------------
--------------
-- Slad'ran --
--------------
L = DBM:GetModLocalization(592)

-------------
-- Moorabi --
-------------
L = DBM:GetModLocalization(594)

---------------------
-- Coloso Drakkari --
---------------------
L = DBM:GetModLocalization(593)

---------------
-- Gal'darah --
---------------
L = DBM:GetModLocalization(596)

------------------
-- Eck el Feroz --
------------------
L = DBM:GetModLocalization(595)

---------------------------
-- Cámaras de Relámpagos --
---------------------------
-----------------------
-- General Bjarngrim --
-----------------------
L = DBM:GetModLocalization(597)

-----------
-- Ionar --
-----------
L = DBM:GetModLocalization(599)

-------------
-- Volkhan --
-------------
L = DBM:GetModLocalization(598)

-----------
-- Loken --
-----------
L = DBM:GetModLocalization(600)

-------------
-- El Nexo --
-------------
--------------
-- Anomalus --
--------------
L = DBM:GetModLocalization(619)

------------------------
-- Ormorok el Talador --
------------------------
L = DBM:GetModLocalization(620)

------------------------
-- Gran maga Telestra --
------------------------
L = DBM:GetModLocalization(618)

L:SetMiscLocalization({
	SplitTrigger1 = "¡Tendréis más de lo que podéis soportar!",
	SplitTrigger2 = "¡Tendréis más de lo que podéis soportar!"
})

-----------------
-- Keristrasza --
-----------------
L = DBM:GetModLocalization(621)

-----------------------------------
-- Comandante Kolurg/Barbarrecia --
-----------------------------------
L = DBM:GetModLocalization("Commander")

local commander = "Comandante"
if UnitFactionGroup("player") == "Alliance" then
	commander = "Comandante Kolurg"
elseif UnitFactionGroup("player") == "Horde" then
	commander = "Comandante Barbarrecia"
end

L:SetGeneralLocalization({
	name = commander
})

-------------------------
-- Pináculo de Utgarde --
-------------------------
-------------------------
-- Skadi el Despiadado --
-------------------------
L = DBM:GetModLocalization(643)

L:SetMiscLocalization({
	CombatStart		= "¿Qué chuchos son los que se atreven a irrumpir aquí? ¡Adelante, hermanos! ¡Un festín para quien me traiga sus cabezas!",
	Phase2			= "¡Bastardos malnacidos! ¡Vuestros cadáveres serán un buen bocado para mis nuevos dracos!"
})

----------------
-- Rey Ymiron --
----------------
L = DBM:GetModLocalization(644)

---------------------
-- Svala Tumbapena --
---------------------
L = DBM:GetModLocalization(641)

L:SetTimerLocalization({
	timerRoleplay		= "Comienza el encuentro"
})

L:SetOptionLocalization({
	timerRoleplay		= "Mostrar tiempo de diálogo antes de que Svala ataque"
})

L:SetMiscLocalization({
	SvalaRoleplayStart	= "¡Mi señor! He hecho lo que pedisteis, ¡y ahora suplico vuestra bendición!"
})

--------------------------
-- Gortok Pezuña Pálida --
--------------------------
L = DBM:GetModLocalization(642)

-------------------
-- Foso de Saron --
-------------------
-----------------
-- Agh y Puagh --
-----------------
L = DBM:GetModLocalization(609)

L:SetMiscLocalization({
	Barrage					= "¡%s comienza a invocar minas explosivas!"
})
-------------------------------
-- Maestro de forja Gargelus --
-------------------------------
L = DBM:GetModLocalization(608)

L:SetOptionLocalization({
	AchievementCheck	= "Anunciar avisos del logro 'Solo once campanadas' en el chat de grupo"
})

L:SetMiscLocalization({
	SaroniteRockThrow	= "¡%s te lanza un pedrusco de saronita enorme!",
	AchievementWarning	= "Aviso: %s tiene %d acumulaciones de Escarcha permanente",
	AchievementFailed	= ">> LOGRO FALLADO: %s tiene %d acumulaciones de Escarcha permanente <<"
})

--------------------------------
-- Señor de la Plaga Tyrannus --
--------------------------------
L = DBM:GetModLocalization(610)

L:SetMiscLocalization({
	CombatStart					= "¡Ay! Valientes aventureros, vuestra intromisión ha llegado a su fin. ¿Oís el ruido de huesos y acero acercándose por ese túnel? Es el sonido de vuestra inminente muerte.", --Cannot promise just yet if this is right emote, it may be the second emote after this, will need to do more testing.
	HoarfrostTarget				= "¡La vermis de escarcha Dientrefrío mira a (%S+) y prepara un helado ataque!",
	YellCombatEnd				= "Imposible... Dientefrío... Avisa..."
})
