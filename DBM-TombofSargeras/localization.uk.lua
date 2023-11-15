if GetLocale() ~= "ukUK" then return end

--- New Proshlyapation Ochka Murchalya Proshlyapenko? ---

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
	TauntOnPainSuccess = "Синхронізує таймери та попередження про таунт, щоб $spell:230214 кастувалося успішно під час старту (для деяких міфічних страт, де ви спеціально дозволяєте Бремени цокати один раз, інакше НЕ рекомендується використовувати цю опцію)"
})

------------------
--Сонм страданий--
------------------
L= DBM:GetModLocalization(1896)

L:SetOptionLocalization({
	IgnoreTemplarOn3Tank = "Ігнорувати Жвавих Храмівників під час $spell:236513 (інформаційне вікно/анонси/таблички з іменами) під час використання 3 і більше танків (не міняйте це в середині бою, це порушить підрахунки)"
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
	InfoFrame =	"Показувати інформаційне вікно для огляду бою"
})

L:SetMiscLocalization({
	FallenAvatarDialog = "Колись ця оболонка була наповнена міццю самого Саргераса. Але нашою головною метою завжди був храм - з його допомогою ми спопелимо ваш світ!" --нужна проверка
})

--------------
--Кил`джеден--
--------------
L= DBM:GetModLocalization(1898)

L:SetWarningLocalization({
	warnSingularitySoon = "Розриває Сингулярність на %ds"
})

L:SetOptionLocalization({
	warnSingularitySoon = DBM_CORE_AUTO_ANNOUNCE_OPTIONS.soon:format(235059)
})

L:SetMiscLocalization({
	Obelisklasers = "Лазери обеліска"
})

-------------
--Треш-мобы--
-------------
L = DBM:GetModLocalization("TombSargTrash")

L:SetGeneralLocalization({
	name = "Трэш Гробницы Саргераса"
})
