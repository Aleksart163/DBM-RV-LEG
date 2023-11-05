if GetLocale() ~= "ruRU" then return end

local L

----------------------------------
-- Верховный некромансер Равенн --
----------------------------------
L = DBM:GetModLocalization("Ravenn")

L:SetGeneralLocalization({
	name = "(Прошляп очка Мурчаля) Верховный некромансер Равенн"
})

L:SetTimerLocalization{
	MurchalProshlyapTimer	= "Ожившая тыква"
}

L:SetOptionLocalization({
	MurchalProshlyapTimer	= "Отсчет времени до появления Оживших тыкв"
})

L:SetMiscLocalization({
	MurchalProshlyap1 = "И восстанут мертвые... И вопли живых сменят тишину...",
	MurchalProshlyap2 = "Бегите, пока можете... Мертвые идут!",
	MurchalProshlyap3 = "Посмотрим... как хорошо вы бегаете?"
})

----------
-- Омен --
----------
L = DBM:GetModLocalization("Omen")

L:SetGeneralLocalization({
	name = "Омен"
})

-------------------------------
-- Королевская хим. компания --
-------------------------------
L = DBM:GetModLocalization("d288")

L:SetTimerLocalization{
	HummelActive		= "Хаммел вступает в бой",
	BaxterActive		= "Бакстер вступает в бой",
	FryeActive			= "Фрай вступает в бой"
}

L:SetOptionLocalization({
	TrioActiveTimer		= "Отсчет времени до вступления Троих аптекарей в бой"
})

L:SetMiscLocalization({
	SayCombatStart		= "Тебе хоть сказали, кто я и чем занимаюсь?"
})

----------------------------
-- Повелитель Холода Ахун --
----------------------------
L = DBM:GetModLocalization("d286")

L:SetWarningLocalization({
	Emerged			= "Ахун появился",
	specWarnAttack	= "Ахун уязвим - атакуйте сейчас!"
})

L:SetTimerLocalization{
	SubmergTimer	= "Исчезновение",
	EmergeTimer		= "Появление"
}

L:SetOptionLocalization({
	Emerged			= "Предупреждение, когда Ахун появляется",
	specWarnAttack	= "Спец-предупреждение, когда Ахун становится уязвим",
	SubmergTimer	= "Отсчет времени до исчезновения",
	EmergeTimer		= "Отсчет времени до появления"
})

L:SetMiscLocalization({
	Pull			= "Камень Льда растаял!"
})

-------------------
-- Корен Худовар --
-------------------
L = DBM:GetModLocalization("d287")

L:SetWarningLocalization({
	specWarnBrew		= "Избавьтесь от варева прежде, чем она бросит вам другое!",
	specWarnBrewStun	= "СОВЕТ: Вы получили удар, не забудьте выпить варево в следующий раз!"
})

L:SetOptionLocalization({
	specWarnBrew		= "Спец-предупреждение для $spell:47376",
	specWarnBrewStun	= "Спец-предупреждение для $spell:47340"
})

L:SetMiscLocalization({
	YellBarrel			= "Бочка на мне!"
})

----------------
--  Brewfest  --
----------------
L = DBM:GetModLocalization("Brew")

L:SetGeneralLocalization({
	name = "Пивной фестиваль"
})

L:SetOptionLocalization({
	NormalizeVolume			= "Автоматически нормализовать громкость звукового канала DIALOG в соответствии с громкостью музыкального канала при нахождении в зоне Пивного Фестиваля, чтобы он не был таким раздражающе громким. (Если громкость музыкального звука не установлена, то громкость будет отключена.)"
})

------------------------
-- Всадник без головы --
------------------------
L = DBM:GetModLocalization("d285")

L:SetWarningLocalization({
	WarnPhase				= "Фаза %d",
	warnHorsemanSoldiers	= "Призыв Пульсирующих тыкв",
	warnHorsemanHead		= "Появилась голова всадника!"
})

L:SetOptionLocalization({
	WarnPhase				= "Предупреждение о смене фаз",
	warnHorsemanSoldiers	= "Предупреждать о призыве Пульсирующих тыкв",
	warnHorsemanHead		= "Спец-предупрежение о появлении головы всадника"
})

L:SetMiscLocalization({
	HorsemanSummon			= "Всадник встает…",
	HorsemanSoldiers		= "Восстаньте слуги, устремитесь в бой! Пусть павший рыцарь обретет покой!"
})

-------------------------
-- Омерзительный Гринч --
-------------------------
L = DBM:GetModLocalization("Greench")

L:SetGeneralLocalization({
	name = "Омерзительный Гринч"
})

---------------------------
-- Растения против Зомби --
---------------------------
L = DBM:GetModLocalization("PlantsVsZombies")

L:SetGeneralLocalization({
	name = "Растения против зомби"
})

L:SetWarningLocalization({
	warnTotalAdds	= "Всего появилось зомби с прошлой большой волны: %d",
	specWarnWave	= "Большая волна!"
})

L:SetTimerLocalization{
	timerWave		= "След. большая волна"
}

L:SetOptionLocalization({
	warnTotalAdds	= "Объявлять общее число появившихся аддов между каждой большой волной",
	specWarnWave	= "Спец-предупреждение когда начинается большая волна",
	timerWave		= "Отсчет времени до следующей большой волны"
})

L:SetMiscLocalization({
	MassiveWave		= "Приближается большая волна зомби!"
})

--------------------------
-- Вторжение демонов --
--------------------------
L = DBM:GetModLocalization("DemonInvasions")

L:SetGeneralLocalization({
	name = "Вторжение демонов"
})
