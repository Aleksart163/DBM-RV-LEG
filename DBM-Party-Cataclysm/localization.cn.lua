if GetLocale() ~= "zhCN" then return end

local L

------------------
--  Grim Batol  --
---------------------
-- General Umbriss --
---------------------
L= DBM:GetModLocalization(131)

--------------------------
-- Forgemaster Throngus --
--------------------------
L= DBM:GetModLocalization(132)

-------------------------
-- Drahga Shadowburner --
-------------------------
L= DBM:GetModLocalization(133)

------------
-- Erudax --
------------
L= DBM:GetModLocalization(134)

----------------------------
--  Halls of Origination  --
----------------------------
-- Temple Guardian Anhuur --
----------------------------
L= DBM:GetModLocalization(124)

---------------------
-- Earthrager Ptah --
---------------------
L= DBM:GetModLocalization(125)

L:SetMiscLocalization{
	Kill		= "塔赫……不复存在了……"
}

--------------
-- Anraphet --
--------------
L= DBM:GetModLocalization(126)

L:SetTimerLocalization({
	achievementGauntlet	= "限时挑战"
})

L:SetMiscLocalization({
	Brann				= "好啊，我们走！只需要在门禁系统中输入最终登录序列……然后……"
})

------------
-- Isiset --
------------
L= DBM:GetModLocalization(127)

L:SetWarningLocalization({
	WarnSplitSoon	= "即将分裂"
})

L:SetOptionLocalization({
	WarnSplitSoon	= "提前警报：分裂"
})

-------------
-- Ammunae --
-------------
L= DBM:GetModLocalization(128)

-------------
-- Setesh  --
-------------
L= DBM:GetModLocalization(129)

----------
-- Rajh --
----------
L= DBM:GetModLocalization(130)

--------------------------------
--  Lost City of the Tol'vir  --
--------------------------------
-- General Husam --
-------------------
L= DBM:GetModLocalization(117)

--------------
-- Lockmaw --
--------------
L= DBM:GetModLocalization(118)

L:SetOptionLocalization{
	RangeFrame	= "距离监视器（5码）"
}

----------
-- Augh --
----------
L = DBM:GetModLocalization("Augh")

L:SetGeneralLocalization({
	name = "奥弗"		-- he is fightable after Lockmaw :o
})

------------------------
-- High Prophet Barim --
------------------------
L= DBM:GetModLocalization(119)

------------------------------------
-- Siamat, Lord of the South Wind --
------------------------------------
L= DBM:GetModLocalization(122)

L:SetWarningLocalization{
	specWarnPhase2Soon	= "5秒后进入第2阶段"
}

L:SetOptionLocalization{
	specWarnPhase2Soon	= "特殊警报：第2阶段即将开始（约5秒）"
}

---------------------
--  The Stonecore  --
---------------------
-- Corborus --
--------------
L= DBM:GetModLocalization(110)

L:SetWarningLocalization({
	WarnEmerge		= "出现",
	WarnSubmerge	= "钻地"
})

L:SetTimerLocalization({
	TimerEmerge		= "下一次出现",
	TimerSubmerge	= "下一次钻地"
})

L:SetOptionLocalization({
	WarnEmerge		= "警报：出现",
	WarnSubmerge	= "警报：钻地",
	TimerEmerge		= "计时条：下一次出现",
	TimerSubmerge	= "计时条：下一次钻地",
	RangeFrame		= "距离监视器（5码）"
})


--------------
-- Slabhide --
--------------
L= DBM:GetModLocalization(111)

L:SetWarningLocalization({
	WarnAirphase			= "空中阶段",
	WarnGroundphase			= "地面阶段",
	specWarnCrystalStorm	= "水晶风暴 - 寻找掩护"
})

L:SetTimerLocalization({
	TimerAirphase			= "下一次空中阶段",
	TimerGroundphase		= "下一次地面阶段"
})

L:SetOptionLocalization({
	WarnAirphase			= "警报：岩皮起飞",
	WarnGroundphase			= "警报：岩皮落地",
	TimerAirphase			= "计时条：下一次空中阶段",
	TimerGroundphase		= "计时条：下一次地面阶段",
	specWarnCrystalStorm	= "特殊警报：$spell:92265"
})

-----------
-- Ozruk --
-----------
L= DBM:GetModLocalization(112)

-------------------------
-- High Priestess Azil --
------------------------
L= DBM:GetModLocalization(113)

---------------------------
--  The Vortex Pinnacle  --
---------------------------
-- Grand Vizier Ertan --
------------------------
L= DBM:GetModLocalization(114)

L:SetMiscLocalization{
	Retract		= "%s收回了他的旋风之盾！"
}

--------------
-- Altairus --
--------------
L= DBM:GetModLocalization(115)

L:SetOptionLocalization({
	BreathIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(88308)
})

-----------
-- Asaad --
-----------
L= DBM:GetModLocalization(116)

L:SetMiscLocalization({
	YellProshlyapMurchal = "奥拉基尔，你的仆从请求你的帮助！"
})

-------------
--Треш-мобы--
-------------
L = DBM:GetModLocalization("TVPTrash")

L:SetGeneralLocalization({
	name = "旋云之巅 Trash"
})

---------------------------
--  The Throne of Tides  --
---------------------------
-- Lady Naz'jar --
------------------
L= DBM:GetModLocalization(101)

----------------------
-- Commander Ulthok --
----------------------
L= DBM:GetModLocalization(102)

-------------------------
-- Erunak Stonespeaker --
-------------------------
L= DBM:GetModLocalization(103)

------------
-- Ozumat --
------------
L= DBM:GetModLocalization(104)

----------------
--  End Time  --
-------------------
-- Echo of Baine --
-------------------
L= DBM:GetModLocalization(340)

-------------------
-- Echo of Jaina --
-------------------
L= DBM:GetModLocalization(285)

L:SetTimerLocalization{
	TimerFlarecoreDetonate	= "炙焰之核"
}

L:SetOptionLocalization{
	TimerFlarecoreDetonate	= "计时条：$spell:101927引爆"
}

----------------------
-- Echo of Sylvanas --
----------------------
L= DBM:GetModLocalization(323)

---------------------
-- Echo of Tyrande --
---------------------
L= DBM:GetModLocalization(283)

--------------
-- Murozond --
--------------
L= DBM:GetModLocalization(289)

L:SetMiscLocalization{
	Kill		= "你根本不明白你究竟干了什么。阿曼苏尔……我……看到……的……"
}

-----------
-- Trash --
-----------
L = DBM:GetModLocalization("ETTrash")

L:SetGeneralLocalization{
	name = "时光之末小怪"
}

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetMiscLocalization({
	ProshlyapM = "“时光之末”，我曾经这么称呼这个地方，我看不到从此以后的时间。什么？你想要……阻止我？改变我花费了无尽时间编织的命运？" --
})
