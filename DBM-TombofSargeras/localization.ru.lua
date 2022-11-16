if GetLocale() ~= "ruRU" then return end

local L

---------
--Горот--
---------
L= DBM:GetModLocalization(1862)

---------------------------
--Демоническая инквизиция--
---------------------------
L= DBM:GetModLocalization(1867)

-------------
--Харджатан--
-------------
L= DBM:GetModLocalization(1856)

---------------
--Сестры Луны--
---------------
L= DBM:GetModLocalization(1903)

-------------------
--Госпожа Сашж`ин--
-------------------
L= DBM:GetModLocalization(1861)

L:SetOptionLocalization({
	TauntOnPainSuccess = "Синхронизирует таймеры и предупреждение о таунте, чтобы $spell:230214 кастовалось успешно при старте (для некоторых мифических страт, где вы специально позволяете Бремени тикать один раз, в противном случае НЕ рекомендуется использовать эту опцию)"
})

------------------
--Сонм страданий--
------------------
L= DBM:GetModLocalization(1896)

L:SetOptionLocalization({
	IgnoreTemplarOn3Tank = "Игнорировать Оживленных Храмовников во время $spell:236513 (информационное окно/анонсы/таблички с именами) при использовании 3 и более танков (не меняйте это в середине боя, это нарушит подсчеты)"
})

-------------------
--Бдительная дева--
-------------------
L= DBM:GetModLocalization(1897)

-------------------
--Аватара Падшего--
-------------------
L= DBM:GetModLocalization(1873)

L:SetOptionLocalization({
	InfoFrame =	"Показывать информационное окно для обзора боя"
})

L:SetMiscLocalization({
	FallenAvatarDialog = "Когда-то эта оболочка была наполнена мощью самого Саргераса. Но нашей главной целью всегда был храм - с его помощью мы испепелим ваш мир!"
})

--------------
--Кил`джеден--
--------------
L= DBM:GetModLocalization(1898)

L:SetWarningLocalization({
	warnSingularitySoon = "Разрывающая Сингулярность на %ds"
})

L:SetOptionLocalization({
	warnSingularitySoon = DBM_CORE_AUTO_ANNOUNCE_OPTIONS.soon:format(235059)
})

L:SetMiscLocalization({
	Obelisklasers = "Лазеры обелиска"
})

-------------
--Треш-мобы--
-------------
L = DBM:GetModLocalization("TombSargTrash")

L:SetGeneralLocalization({
	name = "Трэш Гробницы Саргераса"
})
