if GetLocale() ~= "zhTW" then return end
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
	SplitTrigger1		= "這裡有我千萬個分身。",
	SplitTrigger2		= "我要讓你們嚐嚐無所適從的滋味!"
})

-------------------
--  Keristrasza  --
-------------------
L = DBM:GetModLocalization(621)

-----------------------------------
--  Commander Kolurg/Stoutbeard  --
-----------------------------------
L = DBM:GetModLocalization("Commander")

local commander = "未知"
if UnitFactionGroup("player") == "Alliance" then
	commander = "指揮官寇勒格"
elseif UnitFactionGroup("player") == "Horde" then
	commander = "指揮官厚鬚"
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
	CombatStart		= "哪來的蠢狗敢入侵此地?打起精神來，我的兄弟們!誰能把他們的頭顱帶來，我會好好的犒賞一番!",
	Phase2			= "你們這些沒教養的垃圾!你們的屍體剛好拿來當龍的點心!"
})

-------------------
--  King Ymiron  --
-------------------
L = DBM:GetModLocalization(644)

-------------------------
--  Svala Sorrowgrave  --
-------------------------
L = DBM:GetModLocalization(641)

L:SetWarningLocalization({
	timerRoleplay		= "絲瓦拉·悲傷亡墓活動"
})

L:SetTimerLocalization({
	timerRoleplay		= "為絲瓦拉·悲傷亡墓能夠活動前的角色扮演顯示計時器"
})

L:SetOptionLocalization({
	SvalaRoleplayStart	= "陛下!我已完成您的要求，如今懇求您的祝福!"
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

L:SetOptionLocalization({
})

L:SetMiscLocalization({
	Barrage		= "%s開始迅速地召喚爆裂地雷!"
})

----------------------------
--  Forgemaster Garfrost  --
----------------------------
L = DBM:GetModLocalization(608)

L:SetOptionLocalization({
	AchievementCheck	= "提示 '別到十一' 的成就警告到隊伍頻道"
})

L:SetMiscLocalization({
	SaroniteRockThrow	= "%s對你丟出一大塊薩鋼巨石!",
	AchievementWarning	= "小心: %s已擁有%d層極寒冰霜",
	AchievementFailed	= ">> 成就失敗: %s已超過%d層極寒冰霜 <<"
})

----------------------------
--  Scourgelord Tyrannus  --
----------------------------
L = DBM:GetModLocalization(610)

L:SetOptionLocalization({
})

L:SetMiscLocalization({
	CombatStart		= "終於，勇敢、勇敢的冒險者，你的干擾終到盡頭。你聽見了身後隧道中的金屬與骨頭敲擊聲嗎?這就是你即將面對的死亡之聲。",
	HoarfrostTarget	= "冰霜巨龍霜牙凝視著(%S+)，準備發動寒冰攻擊!",
	YellCombatEnd	= "不可能...霜牙...警告..."
})
