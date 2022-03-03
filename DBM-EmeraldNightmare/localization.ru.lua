if GetLocale() ~= "ruRU" then return end
local L

------------
--Низендра--
------------
L= DBM:GetModLocalization(1703)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})

--------------------------
--Ил'гинот, Сердце Порчи--
--------------------------
L= DBM:GetModLocalization(1738)

L:SetOptionLocalization({
	SetIconOnlyOnce2	= "Устанавливать метку только один раз за сканирование ила а затем отключать, пока хотя бы один не взорвется (экспериментально)",
	InfoFrameBehavior	= "Информация, отображаемая в информационном окне во время боя",
	Fixates				= "Показывать игроков с Сосредоточением внимания",
	Adds				= "Показывать количество для всех типов аддов"
})

----------------------
--Элерет Дикая Лань --
----------------------
L= DBM:GetModLocalization(1744)

L:SetWarningLocalization({
	warnWebOfPain		= ">%s< связан с >%s<",--Only this needs localizing
	specWarnWebofPain	= "Вы связаны с >%s<"--Only this needs localizing
})

---------
--Урсок--
---------
L= DBM:GetModLocalization(1667)

L:SetOptionLocalization({
	NoAutoSoaking2		= "Disable all auto soaking related warnings/arrows/HUDs for Focused Gaze"
})

L:SetMiscLocalization({
	SoakersText			= "Soakers Assigned: %s"
})

-------------------
--Драконы Кошмара--
----------=--------
L= DBM:GetModLocalization(1704)

-----------
--Кенарий--
-----------
L= DBM:GetModLocalization(1750)

L:SetMiscLocalization({
	BrambleYell			= "Колючки рядом с " .. UnitName("player") .. "!",
	BrambleMessage		= "Внимание: DBM не может определить за кем следуют колючки. Он предупреждает о цели спавна. Босс выбирает игрока и кидает в него колючки. После этого колючки выбирают новую цель, которую невозможно определить"
})

----------
--Ксавий--
----------
L= DBM:GetModLocalization(1726)

L:SetOptionLocalization({
	InfoFrameFilterDream	= "Фильтровать игроков с $spell:206005 из информационного окна"
})

-------------
--Треш-мобы--
-------------
L = DBM:GetModLocalization("EmeraldNightmareTrash")

L:SetGeneralLocalization({
	name =	"Трэш Изумрудного кошмара"
})
