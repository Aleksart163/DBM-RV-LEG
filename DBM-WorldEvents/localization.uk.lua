if GetLocale() ~= "ukUK" then return end

--- New Proshlyapation Ochka Murchalya Proshlyapenko? ---

local L

----------------------------------
-- Верховный некромансер Равенн --
----------------------------------
L = DBM:GetModLocalization("Ravenn")

L:SetGeneralLocalization({
	name = "(Прошляп очка Мурчаля) Верховний некромансер Равенн"
})

L:SetTimerLocalization{
	MurchalProshlyapTimer	= "Ожилий гарбуз"
}

L:SetOptionLocalization({
	MurchalProshlyapTimer	= "Відлік часу до появи ожилих гарбузів"
})

L:SetMiscLocalization({
--	MurchalProshlyap1 = "И восстанут мертвые... И вопли живых сменят тишину...", --нужна проверка
--	MurchalProshlyap2 = "Бегите, пока можете... Мертвые идут!",
--	MurchalProshlyap3 = "Посмотрим... как хорошо вы бегаете?"
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
	HummelActive 		= "Хаммел вступає в бій",
	BaxterActive 		= "Бакстер вступає в бій",
	FryeActive 			= "Фрай вступає в бій"
}

L:SetOptionLocalization({
	TrioActiveTimer		= "Відлік часу до вступу Трьох аптекарів у бій"
})

L:SetMiscLocalization({
--	SayCombatStart		= "Тебе хоть сказали, кто я и чем занимаюсь?" --нужна проверка
})

----------------------------
-- Повелитель Холода Ахун --
----------------------------
L = DBM:GetModLocalization("d286")

L:SetWarningLocalization({
	Emerged			= "Ахун з'явився",
	specWarnAttack	= "Ахун вразливий - атакуйте зараз!"
})

L:SetTimerLocalization{
	SubmergTimer 	= "Зникнення",
	EmergeTimer 	= "Поява"
}

L:SetOptionLocalization({
	Emerged 		= "Попередження, коли Ахун з'являється",
	specWarnAttack 	= "Спец-попередження, коли Ахун стає вразливим",
	SubmergTimer 	= "Відлік часу до зникнення",
	EmergeTimer 	= "Відлік часу до появи"
})

L:SetMiscLocalization({
	Pull			= "Камінь Льоду розтанув!"
})

-------------------
-- Корен Худовар --
-------------------
L = DBM:GetModLocalization("d287")

L:SetWarningLocalization({
	specWarnBrew 		= "Позбавтеся від варива перш, ніж вона кине вам інше!",
	specWarnBrewStun 	= "ПОРАДА: Ви отримали удар, не забудьте випити вариво наступного разу!"
})

L:SetOptionLocalization({
	specWarnBrew 		= "Спец-попередження для $spell:47376",
	specWarnBrewStun 	= "Спецпопередження для $spell:47340"
})

L:SetMiscLocalization({
	YellBarrel			= "Бочка на мені!"
})

----------------
--  Brewfest  --
----------------
L = DBM:GetModLocalization("Brew")

L:SetGeneralLocalization({
	name = "Пивний фестиваль"
})

L:SetOptionLocalization({
	NormalizeVolume			= "Автоматично нормалізувати гучність звукового каналу DIALOG відповідно до гучності музичного каналу під час перебування в зоні Пивного Фестивалю, щоб він не був таким дратівливо гучним. (Якщо гучність музичного звуку не встановлена, то гучність буде вимкнена.)"
})

------------------------
-- Всадник без головы --
------------------------
L = DBM:GetModLocalization("d285")

L:SetWarningLocalization({
	WarnPhase 				= "Фаза %d",
	warnHorsemanSoldiers 	= "Заклик Пульсуючих гарбузів",
	warnHorsemanHead 		= "З'явилася голова вершника!"
})

L:SetOptionLocalization({
	WarnPhase 				= "Попередження про зміну фаз",
	warnHorsemanSoldiers 	= "Попереджати про заклик Пульсуючих гарбузів",
	warnHorsemanHead 		= "Спец-попередження про появу голови вершника"
})

L:SetMiscLocalization({
	HorsemanSummon			= "Всадник встает…", --нужна проверка
	HorsemanSoldiers		= "Восстаньте слуги, устремитесь в бой! Пусть павший рыцарь обретет покой!" --нужна проверка
})

-------------------------
-- Омерзительный Гринч --
-------------------------
L = DBM:GetModLocalization("Greench")

L:SetGeneralLocalization({
	name = "Огидний Грінч"
})

---------------------------
-- Растения против Зомби --
---------------------------
L = DBM:GetModLocalization("PlantsVsZombies")

L:SetGeneralLocalization({
	name = "Рослини проти зомбі"
})

L:SetWarningLocalization({
	warnTotalAdds	= "Всего появилось зомби с прошлой большой волны: %d", --нужна проверка
	specWarnWave	= "Большая волна!" --нужна проверка
})

L:SetTimerLocalization{
	timerWave		= "Слід. велика хвиля"
}

L:SetOptionLocalization({
	warnTotalAdds 	= "Оголошувати загальну кількість аддів, що з'явилися між кожною великою хвилею",
	specWarnWave 	= "Спец-попередження коли починається велика хвиля",
	timerWave 		= "Відлік часу до наступної великої хвилі"
})

L:SetMiscLocalization({
	MassiveWave		= "Приближается большая волна зомби!" --нужна проверка
})

--------------------------
-- Вторжение демонов --
--------------------------
L = DBM:GetModLocalization("DemonInvasions")

L:SetGeneralLocalization({
	name = "Вторгнення демонів"
})
