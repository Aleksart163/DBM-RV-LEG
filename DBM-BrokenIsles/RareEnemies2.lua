local mod	= DBM:NewMod("RareEnemies2", "DBM-BrokenIsles", nil, 822)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetZone()
mod:SetMinSyncRevision(17650)

mod:RegisterEvents(
	"SPELL_CAST_START 223637 223693 239513 240095 195493 217857 238586 218435 218427 233220 240105 240115 240126 216504 219200",
	"SPELL_CAST_SUCCESS 205259",
	"SPELL_AURA_APPLIED 223447 233213 216456 219256",
	"SPELL_AURA_REMOVED 223447",
	"UNIT_DIED"
)

--прошляпанное очко Мурчаля Прошляпенко ✔✔✔
local warnCoreofDepravity			= mod:NewTargetAnnounce(223447, 2) --Сердце порочности
local warnHatefulSmash				= mod:NewTargetAnnounce(238586, 2) --Полный ненависти удар
local warnCarrionSwarm				= mod:NewTargetAnnounce(240105, 2) --Темная стая
local warnBrinyBubble				= mod:NewTargetAnnounce(216456, 2) --Соленый пузырь
local warnGlitteringBlast			= mod:NewTargetAnnounce(219200, 2) --Сияющий взрыв
local warnExpensiveDistraction		= mod:NewTargetAnnounce(219256, 2) --Дорогое отвлечение

--Главный казначей Джабрилл
local specWarnGlitteringBlast		= mod:NewSpecialWarningYouMoveAway(219200, nil, nil, nil, 4, 2) --Сияющий взрыв
local specWarnGlitteringBlast2		= mod:NewSpecialWarningTargetDodge(219200, nil, nil, nil, 2, 3) --Сияющий взрыв
local specWarnExpensiveDistraction	= mod:NewSpecialWarningYou(219256, nil, nil, nil, 1, 2) --Дорогое отвлечение
local specWarnExpensiveDistraction2 = mod:NewSpecialWarningDispel(219256, "MagicDispeller2", nil, nil, 1, 2) --Дорогое отвлечение
--Эгир Сокрушитель Волн
local specWarnCrushingWave			= mod:NewSpecialWarningDodge(216504, nil, nil, nil, 2, 2) --Сокрушительная волна
local specWarnBrinyBubble			= mod:NewSpecialWarningYou(216456, nil, nil, nil, 1, 2) --Соленый пузырь
local specWarnBrinyBubble2			= mod:NewSpecialWarningSwitch(216456, nil, nil, nil, 1, 2) --Соленый пузырь
--Валакар Жаждущий
local specWarnViolentDischarge		= mod:NewSpecialWarningInterrupt2(218435, "HasInterrupt2", nil, nil, 2, 3) --Бурный разряд
local specWarnSiphonMagic			= mod:NewSpecialWarningInterrupt(218427, "-Healer", nil, nil, 1, 3) --Похитить магию
--Руновидец Сигвид
local specWarnShatteredRune			= mod:NewSpecialWarningInterrupt(195493, "-Healer", nil, nil, 1, 3) --Расколотая руна
local specWarnUnraveltheRunes		= mod:NewSpecialWarningInterrupt2(217857, "HasInterrupt2", nil, nil, 2, 3) --Расплетение рун
--Гигантский инфернал
local specWarnBlazingHellfire		= mod:NewSpecialWarningInterrupt(205259, "-Healer", nil, nil, 3, 3) --Слепящее адское пламя
--Агмозул
local specWarnHatefulSmash			= mod:NewSpecialWarningYouMoveAway(238586, nil, nil, nil, 4, 2) --Полный ненависти удар
local specWarnHatefulSmash2			= mod:NewSpecialWarningTargetDodge(238586, nil, nil, nil, 2, 3) --Полный ненависти удар
--Шел'дрозул
local specWarnFelFissure			= mod:NewSpecialWarningDodge(223637, nil, nil, nil, 2, 3) --Разлом Скверны
local specWarnTrueChaos				= mod:NewSpecialWarningInterrupt2(223693, "HasInterrupt2", nil, nil, 1, 3) --Истинный Хаос
local specWarnCoreofDepravity		= mod:NewSpecialWarningYouMoveAway(223447, nil, nil, nil, 4, 2) --Сердце порочности
--Аркутаз
local specWarnRainofFire			= mod:NewSpecialWarningDodge(240095, nil, nil, nil, 2, 2) --Огненный ливень
local specWarnFireball				= mod:NewSpecialWarningInterrupt(239513, "-Healer", nil, nil, 1, 3) --Огненный шар
--Тар'гокк
local specWarnThunderingStomp		= mod:NewSpecialWarningDodge(240126, nil, nil, nil, 2, 2) --Грохочущий топот
--Призывательница Скверны Талезра
local specWarnFelshardMeteors		= mod:NewSpecialWarningDodge(233213, nil, nil, nil, 2, 3) --Метеориты из осколков Скверны
local specWarnIncineratingBlast		= mod:NewSpecialWarningInterrupt(233220, "-Healer", nil, nil, 1, 3) --Опаляющий взрыв
--Поработитель Вал'рек
local specWarnCarrionSwarm			= mod:NewSpecialWarningYouMoveAway(240105, nil, nil, nil, 4, 2) --Темная стая
local specWarnCarrionSwarm2			= mod:NewSpecialWarningTargetDodge(240105, nil, nil, nil, 2, 3) --Темная стая
local specWarnPlagueVolley			= mod:NewSpecialWarningInterrupt(240115, "-Healer", nil, nil, 1, 3) --Чумной залп

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
		specWarnHatefulSmash:Play("runaway")
		yellHatefulSmash:Yell()
	elseif self:CheckNearby(5, targetname) then
		specWarnHatefulSmash2:Show(targetname)
		specWarnHatefulSmash2:Play("runout")
	else
		warnHatefulSmash:Show(targetname)
	end
end

function mod:carrionSwarmTarget(targetname, uId) --прошляпанное очко Мурчаля Прошляпенко ✔
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnCarrionSwarm:Show()
		specWarnCarrionSwarm:Play("runaway")
		yellCarrionSwarm:Yell()
	elseif self:CheckNearby(5, targetname) then
		specWarnCarrionSwarm2:Show(targetname)
		specWarnCarrionSwarm2:Play("runout")
	else
		warnCarrionSwarm:Show(targetname)
	end
end

function mod:glitteringBlastTarget(targetname, uId) --прошляпанное очко Мурчаля Прошляпенко ✔
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnGlitteringBlast:Show()
		specWarnGlitteringBlast:Play("runaway")
		yellGlitteringBlast:Yell()
	elseif self:CheckNearby(5, targetname) then
		specWarnGlitteringBlast2:Show(targetname)
		specWarnGlitteringBlast2:Play("runout")
	else
		warnGlitteringBlast:Show(targetname)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 223637 then --Разлом Скверны
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if (cid == 117066 or cid == 117420 or cid == 118017 or cid == 117060 or cid == 117059 or cid == 118016 or cid == 120310 or cid == 118013) then
			specWarnFelFissure:Show()
			specWarnFelFissure:Play("watchstep")
		end
	elseif spellId == 223693 then --Истинный Хаос
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if (cid == 117066 or cid == 117420 or cid == 118017 or cid == 117060 or cid == 117059 or cid == 118016 or cid == 120310 or cid == 118013) then
			specWarnTrueChaos:Show()
			specWarnTrueChaos:Play("kickcast")
		end
	elseif spellId == 239513 then --Огненный шар
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if (cid == 117065 or cid == 117969 or cid == 120126 or cid == 117991 or cid == 117067 or cid == 117970 or cid == 117973) then
			specWarnFireball:Show()
			specWarnFireball:Play("kickcast")
		end
	elseif spellId == 240095 then --Огненный ливень
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if (cid == 117065 or cid == 117039 or cid == 117969 or cid == 117040 or cid == 117991 or cid == 117067 or cid == 117035 or cid == 117970 or cid == 118006 or cid == 117038 or cid == 117973 or cid == 117036) then
			specWarnRainofFire:Show()
			specWarnRainofFire:Play("watchstep")
		end
	elseif spellId == 240126 then --Грохочущий топот
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if (cid == 117040 or cid == 117035 or cid == 118006 or cid == 117038 or cid == 117036) then
			specWarnThunderingStomp:Show()
			specWarnThunderingStomp:Play("watchstep")
		end
	elseif spellId == 238586 then --Полный ненависти удар
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if (cid == 117039 or cid == 116955 or cid == 117048 or cid == 117049 or cid == 117964 or cid == 117047 or cid == 117959 or cid == 117962 or cid == 117053 or cid == 117967) then
			self:BossTargetScanner(args.sourceGUID, "hatefulSmashTarget", 0.1, 2)
		end
	elseif spellId == 195493 then --Расколотая руна
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if cid == 109318 then
			specWarnShatteredRune:Show()
			specWarnShatteredRune:Play("kickcast")
		end
	elseif spellId == 217857 then --Расплетение рун
		specWarnUnraveltheRunes:Show()
		specWarnUnraveltheRunes:Play("kickcast")
	elseif spellId == 218435 then --Бурный разряд
		specWarnViolentDischarge:Show()
		specWarnViolentDischarge:Play("kickcast")
	elseif spellId == 218427 then --Похитить магию
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if cid == 109575 then
			specWarnSiphonMagic:Show()
			specWarnSiphonMagic:Play("kickcast")
		end
	elseif spellId == 233220 then --Опаляющий взрыв
		specWarnIncineratingBlast:Show()
		specWarnIncineratingBlast:Play("kickcast")
	elseif spellId == 240105 then --Темная стая
		self:BossTargetScanner(args.sourceGUID, "carrionSwarmTarget", 0.1, 2)
	elseif spellId == 240115 then --Чумной залп
		specWarnPlagueVolley:Show()
		specWarnPlagueVolley:Play("kickcast")
	elseif spellId == 216504 then --Сокрушительная волна
		specWarnCrushingWave:Show()
		specWarnCrushingWave:Play("watchstep")
	elseif spellId == 219200 then --Сияющий взрыв
		self:BossTargetScanner(args.sourceGUID, "glitteringBlastTarget", 0.1, 2)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 205259 then --Слепящее адское пламя
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if (cid == 117055 or cid == 117054) then
			specWarnBlazingHellfire:Show()
			specWarnBlazingHellfire:Play("kickcast")
			timerBlazingHellfireCD:Start()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 223447 then --Сердце порочности
		timerCoreofDepravity:Start(args.destName)
		if args:IsPlayer() then
			specWarnCoreofDepravity:Schedule(4.5)
			specWarnCoreofDepravity:ScheduleVoice(4.5, "runaway")
			yellCoreofDepravity:Yell()
			yellCoreofDepravity2:Countdown(9, 3)
		else
			warnCoreofDepravity:CombinedShow(0.3, args.destName)
		end
	elseif spellId == 233213 and not args:IsDestTypePlayer() then --Метеориты из осколков Скверны
		specWarnFelshardMeteors:Show()
		specWarnFelshardMeteors:Play("watchstep")
	elseif spellId == 216456 then --Соленый пузырь
		warnBrinyBubble:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnBrinyBubble:Show()
			specWarnBrinyBubble:Play("targetyou")
			yellBrinyBubble:Yell()
		else
			specWarnBrinyBubble2:Show()
			specWarnBrinyBubble2:Play("killmob")
		end
	elseif spellId == 219256 then --Дорогое отвлечение
		warnExpensiveDistraction:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnExpensiveDistraction:Show()
			specWarnExpensiveDistraction:Play("targetyou")
		else
			specWarnExpensiveDistraction2:CombinedShow(0.3, args.destName)
			specWarnExpensiveDistraction2:Play("dispelnow")
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

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if (cid == 117055 or cid == 117054) then
		timerBlazingHellfireCD:Cancel()
	end
end
