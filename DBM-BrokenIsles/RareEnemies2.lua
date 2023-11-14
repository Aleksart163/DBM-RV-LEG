local mod	= DBM:NewMod("RareEnemies2", "DBM-BrokenIsles", nil, 822)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17745 $"):sub(12, -3))
mod:SetZone()
mod:SetMinSyncRevision(17745)

mod.noStatistics = true
mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 223637 223693 239513 240095 195493 217857 238586 233220 240105 240115 240126 216504 219200 240015 240009 186612 212549 222326 222318 224703 219293 207460 217562 207344 219554 207729 207734 217167 217111 219799",
	"SPELL_CAST_SUCCESS 205259 206946 222532 219799",
	"SPELL_AURA_APPLIED 223447 233213 216456 219256 186620 217002",
--	"SPELL_AURA_APPLIED_DOSE 218875",
	"SPELL_AURA_REMOVED 223447",
	"SPELL_PERIODIC_DAMAGE 217136",
	"SPELL_PERIODIC_MISSED 217136",
	"UNIT_DIED"
)

--прошляпанное очко Мурчаля Прошляпенко ✔✔✔
local warnCoreofDepravity			= mod:NewTargetAnnounce(223447, 2) --Сердце порочности
local warnHatefulSmash				= mod:NewTargetAnnounce(238586, 3) --Полный ненависти удар
local warnCarrionSwarm				= mod:NewTargetAnnounce(240105, 3) --Темная стая
local warnBrinyBubble				= mod:NewTargetAnnounce(216456, 2) --Соленый пузырь
local warnGlitteringBlast			= mod:NewTargetAnnounce(219200, 3) --Сияющий взрыв
local warnExpensiveDistraction		= mod:NewTargetAnnounce(219256, 2) --Дорогое отвлечение
--Предвестник криков
local specWarnTaintedEruption		= mod:NewSpecialWarningDodge(219799, nil, nil, nil, 2, 2) --Извержение порчи
local specWarnTaintedEruption2		= mod:NewSpecialWarningInterrupt(219799, "HasInterrupt", nil, nil, 1, 2) --Извержение порчи
--Катоу Дикий
local specWarnFlameBomb				= mod:NewSpecialWarningDodge(217111, nil, nil, nil, 2, 2) --Огненная бомба
local specWarnFlameBomb2			= mod:NewSpecialWarningYouMove(217136, nil, nil, nil, 1, 2) --Огненная бомба
local specWarnBestialChoke			= mod:NewSpecialWarningYouDefensive(217002, nil, nil, nil, 3, 3) --Звериное удушение
--Стражница душ Альдора
local specWarnSoulHarvest			= mod:NewSpecialWarningInterrupt2(217167, nil, nil, nil, 2, 3) --Жатва душ
--Осквернилия
local specWarnMuckInfusion			= mod:NewSpecialWarningInterrupt(207734, "HasInterrupt", nil, nil, 3, 3) --Сила навоза
local specWarnSickeningBolt			= mod:NewSpecialWarningInterrupt(207729, "HasInterrupt", nil, nil, 1, 2) --Тошнотворная стрела
--Илдис
local specWarnTormentingFoliage		= mod:NewSpecialWarningDodge(219554, nil, nil, nil, 2, 3) --Истязающие заросли
--Ормагрогг
local specWarnEssenceTheft			= mod:NewSpecialWarningInterrupt(207344, "HasInterrupt", nil, nil, 1, 2) --Похищение сущности
--Мелисандра
local specWarnVolatileTempest		= mod:NewSpecialWarningInterrupt2(217562, nil, nil, nil, 2, 3) --Нестабильная буря
--Косумот Алчущий
local specWarnShadowBoltVolley		= mod:NewSpecialWarningInterrupt(222318, "HasInterrupt", nil, nil, 3, 3) --Залп стрел Тьмы
local specWarnGluttonousShadows		= mod:NewSpecialWarningDodge(222326, nil, nil, nil, 2, 3) --Прожорливые тени
local specWarnVoidFissures			= mod:NewSpecialWarningSwitch(206946, "-Healer", nil, nil, 1, 2) --Разломы Бездны
--Мортиферос
local specWarnDecayingCarrion		= mod:NewSpecialWarningInterrupt2(186612, nil, nil, nil, 2, 3) --Разлагающаяся мертвечина
local specWarnTerrifyingRoar		= mod:NewSpecialWarningInterrupt(212549, "HasInterrupt", nil, nil, 1, 2) --Ужасающий рев
local specWarnCripplingGloom		= mod:NewSpecialWarningYou(186620, nil, nil, nil, 1, 2) --Калечащий мрак
--Главный казначей Джабрилл
local specWarnGlitteringBlast		= mod:NewSpecialWarningYouMoveAway(219200, nil, nil, nil, 4, 2) --Сияющий взрыв
local specWarnGlitteringBlast2		= mod:NewSpecialWarningTargetDodge(219200, nil, nil, nil, 2, 3) --Сияющий взрыв
local specWarnExpensiveDistraction	= mod:NewSpecialWarningYou(219256, nil, nil, nil, 1, 2) --Дорогое отвлечение
local specWarnExpensiveDistraction2 = mod:NewSpecialWarningDispel(219256, "MagicDispeller2", nil, nil, 1, 2) --Дорогое отвлечение
--Эгир Сокрушитель Волн
local specWarnCrushingWave			= mod:NewSpecialWarningDodge(216504, nil, nil, nil, 2, 2) --Сокрушительная волна
local specWarnBrinyBubble			= mod:NewSpecialWarningYou(216456, nil, nil, nil, 1, 2) --Соленый пузырь
local specWarnBrinyBubble2			= mod:NewSpecialWarningSwitch(216456, "-Healer", nil, nil, 1, 2) --Соленый пузырь
--Руновидец Сигвид
local specWarnShatteredRune			= mod:NewSpecialWarningInterrupt(195493, "HasInterrupt", nil, nil, 1, 2) --Расколотая руна
local specWarnUnraveltheRunes		= mod:NewSpecialWarningInterrupt2(217857, nil, nil, nil, 2, 3) --Расплетение рун
--Аз'жатар
local specWarnDeafeningRoar			= mod:NewSpecialWarningInterrupt(224703, "HasInterrupt", nil, nil, 1, 2) --Оглушающий рев
--Потокий
local specWarnFreezingMist			= mod:NewSpecialWarningInterrupt2(222532, nil, nil, nil, 1, 2) --Леденящий туман
--Шалас'аман
local specWarnTerrifyingRoar2		= mod:NewSpecialWarningInterrupt(219293, "HasInterrupt", nil, nil, 1, 2) --Ужасающий рев
local specWarnSowNightmareSeeds		= mod:NewSpecialWarningInterrupt(207460, "HasInterrupt", nil, nil, 2, 2) --Посев зерен кошмарника
--Гигантский инфернал
local specWarnBlazingHellfire		= mod:NewSpecialWarningInterrupt(205259, "HasInterrupt", nil, nil, 3, 3) --Слепящее адское пламя
--Агмозул
local specWarnHatefulSmash			= mod:NewSpecialWarningYouMoveAway(238586, nil, nil, nil, 4, 2) --Полный ненависти удар
local specWarnHatefulSmash2			= mod:NewSpecialWarningTargetDodge(238586, nil, nil, nil, 2, 3) --Полный ненависти удар
--Шел'дрозул
local specWarnFelFissure			= mod:NewSpecialWarningDodge(223637, nil, nil, nil, 2, 3) --Разлом Скверны
local specWarnTrueChaos				= mod:NewSpecialWarningInterrupt2(223693, nil, nil, nil, 1, 2) --Истинный Хаос
local specWarnCoreofDepravity		= mod:NewSpecialWarningYouMoveAway(223447, nil, nil, nil, 4, 2) --Сердце порочности
--Аркутаз
local specWarnRainofFire			= mod:NewSpecialWarningDodge(240095, nil, nil, nil, 1, 2) --Огненный ливень
local specWarnFireball				= mod:NewSpecialWarningInterrupt(239513, "HasInterrupt", nil, nil, 1, 2) --Огненный шар
--Тар'гокк
local specWarnThunderingStomp		= mod:NewSpecialWarningDodge(240126, nil, nil, nil, 2, 2) --Грохочущий топот
--Призывательница Скверны Талезра
local specWarnFelshardMeteors		= mod:NewSpecialWarningDodge(233213, nil, nil, nil, 2, 3) --Метеориты из осколков Скверны
local specWarnIncineratingBlast		= mod:NewSpecialWarningInterrupt(233220, "HasInterrupt", nil, nil, 1, 2) --Опаляющий взрыв
--Поработитель Вал'рек
local specWarnCarrionSwarm			= mod:NewSpecialWarningYouMoveAway(240105, nil, nil, nil, 4, 2) --Темная стая
local specWarnCarrionSwarm2			= mod:NewSpecialWarningTargetDodge(240105, nil, nil, nil, 2, 3) --Темная стая
local specWarnPlagueVolley			= mod:NewSpecialWarningInterrupt(240115, "HasInterrupt", nil, nil, 1, 2) --Чумной залп
--Командир Зартак
local specWarnShadowCrash			= mod:NewSpecialWarningInterrupt(240015, "HasInterrupt", nil, nil, 1, 2) --Темное сокрушение
local specWarnHowlfromBeyond		= mod:NewSpecialWarningInterrupt2(240009, nil, nil, nil, 2, 3) --Потусторонний вой

local timerBlazingHellfireCD		= mod:NewCDTimer(16, 205259, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Слепящее адское пламя
local timerCoreofDepravity			= mod:NewTargetTimer(9, 223447, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Сердце порочности

local yellCoreofDepravity			= mod:NewYell(223447, nil, nil, nil, "YELL") --Сердце порочности
local yellCoreofDepravity2			= mod:NewFadesYell(223447, nil, nil, nil, "YELL") --Сердце порочности
local yellHatefulSmash				= mod:NewYell(238586, nil, nil, nil, "YELL") --Полный ненависти удар
local yellCarrionSwarm				= mod:NewYell(240105, nil, nil, nil, "YELL") --Темная стая
local yellBrinyBubble				= mod:NewYellHelp(216456, nil, nil, nil, "YELL") --Соленый пузырь
local yellGlitteringBlast			= mod:NewYell(219200, nil, nil, nil, "YELL") --Сияющий взрыв

function mod:hatefulSmashTarget(targetname, uId) --прошляпанное очко Мурчаля Прошляпенко ✔
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnHatefulSmash:Show()
	--	specWarnHatefulSmash:Play("runaway")
		yellHatefulSmash:Yell()
	elseif self:CheckNearby(5, targetname) then
		specWarnHatefulSmash2:Show(targetname)
	--	specWarnHatefulSmash2:Play("runout")
	else
		warnHatefulSmash:Show(targetname)
	end
end

function mod:carrionSwarmTarget(targetname, uId) --прошляпанное очко Мурчаля Прошляпенко ✔
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnCarrionSwarm:Show()
	--	specWarnCarrionSwarm:Play("runaway")
		yellCarrionSwarm:Yell()
	elseif self:CheckNearby(5, targetname) then
		specWarnCarrionSwarm2:Show(targetname)
	--	specWarnCarrionSwarm2:Play("runout")
	else
		warnCarrionSwarm:Show(targetname)
	end
end

function mod:glitteringBlastTarget(targetname, uId) --прошляпанное очко Мурчаля Прошляпенко ✔
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnGlitteringBlast:Show()
	--	specWarnGlitteringBlast:Play("runaway")
		yellGlitteringBlast:Yell()
	elseif self:CheckNearby(5, targetname) then
		specWarnGlitteringBlast2:Show(targetname)
	--	specWarnGlitteringBlast2:Play("runout")
	else
		warnGlitteringBlast:Show(targetname)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 223637 then --Разлом Скверны
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if cid == 117066 or cid == 117420 or cid == 118017 or cid == 117060 or cid == 117059 or cid == 118016 or cid == 120310 or cid == 118013 or cid == 117061 then -- 117061 навязанный разрабами
			specWarnFelFissure:Show()
		--	specWarnFelFissure:Play("watchstep")
		end
	elseif spellId == 223693 then --Истинный Хаос
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if cid == 117066 or cid == 117420 or cid == 118017 or cid == 117060 or cid == 117059 or cid == 118016 or cid == 120310 or cid == 118013 or cid == 117061 then -- 117061 навязанный разрабами
			specWarnTrueChaos:Show()
		--	specWarnTrueChaos:Play("kickcast")
		end
	elseif spellId == 239513 then --Огненный шар
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if cid == 117065 or cid == 117969 or cid == 120126 or cid == 117991 or cid == 117067 or cid == 117970 or cid == 117973 then --
			specWarnFireball:Show()
		--	specWarnFireball:Play("kickcast")
		end
	elseif spellId == 240095 then --Огненный ливень
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if cid == 117065 or cid == 117039 or cid == 117969 or cid == 117040 or cid == 117991 or cid == 117067 or cid == 117035 or cid == 117970 or cid == 118006 or cid == 117038 or cid == 117973 or cid == 117036 then --
			specWarnRainofFire:Show()
		--	specWarnRainofFire:Play("watchstep")
		end
	elseif spellId == 240126 then --Грохочущий топот
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if cid == 117040 or cid == 117035 or cid == 118006 or cid == 117038 or cid == 117036 then --
			specWarnThunderingStomp:Show()
		--	specWarnThunderingStomp:Play("watchstep")
		end
	elseif spellId == 238586 then --Полный ненависти удар
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if cid == 117039 or cid == 116955 or cid == 117048 or cid == 117049 or cid == 117964 or cid == 117047 or cid == 117959 or cid == 117962 or cid == 117053 or cid == 117967 then --
			self:BossTargetScanner(args.sourceGUID, "hatefulSmashTarget", 0.1, 2)
		end
	elseif spellId == 195493 then --Расколотая руна
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if cid == 109318 then
			if self:CheckInterruptFilter(args.sourceGUID, false, true) then
				specWarnShatteredRune:Show()
			--	specWarnShatteredRune:Play("kickcast")
			end
		end
	elseif spellId == 217857 then --Расплетение рун
		specWarnUnraveltheRunes:Show()
	--	specWarnUnraveltheRunes:Play("kickcast")
	elseif spellId == 233220 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Опаляющий взрыв
		specWarnIncineratingBlast:Show()
	--	specWarnIncineratingBlast:Play("kickcast")
	elseif spellId == 240105 then --Темная стая
		self:BossTargetScanner(args.sourceGUID, "carrionSwarmTarget", 0.1, 2)
	elseif spellId == 240115 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Чумной залп
		specWarnPlagueVolley:Show()
	--	specWarnPlagueVolley:Play("kickcast")
	elseif spellId == 216504 then --Сокрушительная волна
		specWarnCrushingWave:Show()
	--	specWarnCrushingWave:Play("watchstep")
	elseif spellId == 219200 then --Сияющий взрыв
		self:BossTargetScanner(args.sourceGUID, "glitteringBlastTarget", 0.1, 2)
	elseif spellId == 240015 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Темное сокрушение
		specWarnShadowCrash:Show()
	--	specWarnShadowCrash:Play("kickcast")
	elseif spellId == 240009 then --Потусторонний вой
		specWarnHowlfromBeyond:Show()
	--	specWarnHowlfromBeyond:Play("kickcast")
	elseif spellId == 186612 then --Разлагающаяся мертвечина
		specWarnDecayingCarrion:Show()
	--	specWarnDecayingCarrion:Play("kickcast")
	elseif spellId == 212549 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Ужасающий рев
		specWarnTerrifyingRoar:Show()
	--	specWarnTerrifyingRoar:Play("kickcast")
	elseif spellId == 222326 then --Прожорливые тени
		specWarnGluttonousShadows:Show()
	--	specWarnGluttonousShadows:Play("watchstep")
	elseif spellId == 222318 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Залп стрел Тьмы
		specWarnShadowBoltVolley:Show()
	--	specWarnShadowBoltVolley:Play("kickcast")
	elseif spellId == 224703 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Оглушающий рев
		specWarnDeafeningRoar:Show()
	--	specWarnDeafeningRoar:Play("kickcast")
	elseif spellId == 219293 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Ужасающий рев
		specWarnTerrifyingRoar2:Show()
	--	specWarnTerrifyingRoar2:Play("kickcast")
	elseif spellId == 207460 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Посев зерен кошмарника
		specWarnSowNightmareSeeds:Show()
	--	specWarnSowNightmareSeeds:Play("kickcast")
	elseif spellId == 217562 then --Нестабильная буря
		specWarnVolatileTempest:Show()
	--	specWarnVolatileTempest:Play("kickcast")
	elseif spellId == 207344 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Похищение сущности
		specWarnEssenceTheft:Show()
	--	specWarnEssenceTheft:Play("kickcast")
	elseif spellId == 219554 then --Истязающие заросли
		specWarnTormentingFoliage:Show()
	--	specWarnTormentingFoliage:Play("watchstep")
	elseif spellId == 207734 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Сила навоза
		specWarnMuckInfusion:Show()
	--	specWarnMuckInfusion:Play("kickcast")
	elseif spellId == 207729 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Тошнотворная стрела
		specWarnSickeningBolt:Show()
	--	specWarnSickeningBolt:Play("kickcast")
	elseif spellId == 217167 then --Жатва душ
		specWarnSoulHarvest:Show()
	--	specWarnSoulHarvest:Play("kickcast")
	elseif spellId == 217111 then --Огненная бомба
		specWarnFlameBomb:Show()
	--	specWarnFlameBomb:Play("watchstep")
	elseif spellId == 219799 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Извержение порчи
		specWarnTaintedEruption2:Show()
	--	specWarnTaintedEruption2:Play("kickcast")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 205259 then --Слепящее адское пламя
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if cid == 117055 or cid == 117054 then
			specWarnBlazingHellfire:Show()
		--	specWarnBlazingHellfire:Play("kickcast")
			timerBlazingHellfireCD:Start()
		end
	elseif spellId == 206946 then --Разлом Бездны
		specWarnVoidFissures:Show()
	--	specWarnVoidFissures:Play("killmob")
	elseif spellId == 222532 then --Леденящий туман
		specWarnFreezingMist:Show()
	--	specWarnFreezingMist:Play("kickcast")
	elseif spellId == 219799 then --Извержение порчи
		specWarnTaintedEruption:Show()
	--	specWarnTaintedEruption:Play("watchstep")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 223447 then --Сердце порочности
		timerCoreofDepravity:Start(args.destName)
		if args:IsPlayer() then
			specWarnCoreofDepravity:Schedule(4.5)
		--	specWarnCoreofDepravity:ScheduleVoice(4.5, "runaway")
			yellCoreofDepravity:Yell()
			yellCoreofDepravity2:Countdown(9, 3)
		else
			warnCoreofDepravity:CombinedShow(0.3, args.destName)
		end
	elseif spellId == 233213 and not args:IsDestTypePlayer() then --Метеориты из осколков Скверны
		specWarnFelshardMeteors:Show()
	--	specWarnFelshardMeteors:Play("watchstep")
	elseif spellId == 216456 then --Соленый пузырь
		warnBrinyBubble:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnBrinyBubble:Show()
		--	specWarnBrinyBubble:Play("targetyou")
			yellBrinyBubble:Yell()
		else
			specWarnBrinyBubble2:Show()
		--	specWarnBrinyBubble2:Play("killmob")
		end
	elseif spellId == 219256 then --Дорогое отвлечение
		warnExpensiveDistraction:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnExpensiveDistraction:Show()
		--	specWarnExpensiveDistraction:Play("targetyou")
		else
			specWarnExpensiveDistraction2:CombinedShow(0.3, args.destName)
		--	specWarnExpensiveDistraction2:ScheduleVoice(0.3, "dispelnow")
		end
	elseif spellId == 186620 then --Калечащий мрак
		if args:IsPlayer() then
			specWarnCripplingGloom:Show()
		--	specWarnCripplingGloom:Play("targetyou")
		end
	elseif spellId == 217002 then --Звериное удушение
		if args:IsPlayer() then
			specWarnBestialChoke:Show()
		--	specWarnBestialChoke:Play("defensive")
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 223447 then --Сердце порочности
		timerCoreofDepravity:Cancel(args.destName)
		if args:IsPlayer() then
			specWarnCoreofDepravity:Cancel()
			yellCoreofDepravity2:Cancel()
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 217136 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then --Огненная бомба
		specWarnFlameBomb2:Show()
	--	specWarnFlameBomb2:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 117055 or cid == 117054 then
		timerBlazingHellfireCD:Cancel()
	end
end
