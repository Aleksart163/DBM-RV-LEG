local mod	= DBM:NewMod("RareEnemies", "DBM-BrokenIsles", nil, 822)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetZone()
mod:SetMinSyncRevision(17650)

mod.noStatistics = true
mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 221424 222676 189157 214095 218245 218250 223101 223104 219060 206762 203671 222596 216808 216837 218885 223659 223630 207002 206995 206972 216981 216970 219108 218875 218871 218435 218427 214500 222442 222446 222279 218855 224743 225254 222483 207084 207056 216143 216276 218385 219121 219109 207199 225243 217140 224659",
	"SPELL_CAST_SUCCESS 221422 223094 216881 218969 224745 222504 222483 216150 218407 224659",
	"SPELL_AURA_APPLIED 221422 221425 222676 218250 223094 219102 219087 206795 219060 223630 206972 219661 219646 37587 222631 219627 224743 225254 207199 225243 217140 225222",
	"SPELL_AURA_APPLIED_DOSE 221425",
	"SPELL_AURA_REMOVED 221422 221425",
	"SPELL_PERIODIC_DAMAGE 218960 222444 217130",
	"SPELL_PERIODIC_MISSED 218960 222444 217130",
	"CHAT_MSG_MONSTER_SAY",
	"GOSSIP_SHOW",
	"UNIT_DIED"
)

--прошляпанное очко Мурчаля Прошляпенко ✔✔✔
local warnCrushArmor			= mod:NewStackAnnounce(221425, 1) --Сокрушение доспеха
local warnImpale				= mod:NewTargetAnnounce(222676, 4) --Прокалывание
local warnArcticTorrent			= mod:NewTargetAnnounce(218245, 4) --Арктический поток
local warnWebWrap				= mod:NewTargetAnnounce(223094, 3) --Кокон
local warnClubSlam				= mod:NewTargetAnnounce(203671, 4) --Мощный удар дубиной
local warnHorrificVisage		= mod:NewSpellAnnounce(216881, 2) --Ужасающий лик
local warnRemnantofLight		= mod:NewTargetAnnounce(216837, 3) --Частица Света
local warnFelFissure			= mod:NewTargetAnnounce(218885, 3) --Разлом скверны
local warnDepthCharge			= mod:NewTargetAnnounce(207002, 3) --Глубинная бомба
local warnCinderwingsGaze		= mod:NewTargetAnnounce(222446, 2) --Взор Пеплокрыла
--Фьордан https://www.wowhead.com/ru/npc=109584/фьордан
--Ральф Костолом https://www.wowhead.com/ru/npc=109317/ральф-костолом
--Мастер косы Силь'раман
local specWarnCalloftheBrood	= mod:NewSpecialWarningInterrupt(224659, "HasInterrupt", nil, nil, 1, 2) --Призыв выводка
local specWarnCalloftheBrood2	= mod:NewSpecialWarningSwitch(224659, "-Healer", nil, nil, 1, 2) --Призыв выводка
local specWarnWickedSlice		= mod:NewSpecialWarningYou(225222, nil, nil, nil, 2, 3) --Жестокое рассечение
--Капитан Дарган
local specWarnSoulofMist		= mod:NewSpecialWarningInterrupt(217140, "HasInterrupt", nil, nil, 1, 2) --Душа тумана
local specWarnSoulofMist2	 	= mod:NewSpecialWarningDispel(217140, "MagicDispeller", nil, nil, 1, 3) --Душа тумана
local specWarnSoulofMist3		= mod:NewSpecialWarningReflect(217140, "-MagicDispeller", nil, nil, 1, 2) --Душа тумана
local specWarnCreepingMist		= mod:NewSpecialWarningYouMove(217130, nil, nil, nil, 1, 2) --Ползучий туман
--Марблуб Громадный
local specWarnShakeOff			= mod:NewSpecialWarningInterrupt2(219109, nil, nil, nil, 2, 2) --Стряхивание
local specWarnEnragedRoar		= mod:NewSpecialWarningInterrupt(219121, "HasInterrupt", nil, nil, 1, 2) --Яростный рев
--Магистр Злисса
local specWarnArcaneBarrier		= mod:NewSpecialWarningInterrupt(207199, "HasInterrupt", nil, nil, 1, 2) --Барьер Чар
local specWarnArcaneBarrier2 	= mod:NewSpecialWarningDispel(207199, "MagicDispeller", nil, nil, 1, 3) --Барьер Чар
local specWarnNetherSuppression	= mod:NewSpecialWarningYou(225243, nil, nil, nil, 1, 2) --Подавление Пустоты
local specWarnNetherSuppression2 = mod:NewSpecialWarningInterrupt2(225243, nil, nil, nil, 1, 2) --Подавление Пустоты
--Литерон
local specWarnShatteredEarth	= mod:NewSpecialWarningDodge(218407, nil, nil, nil, 2, 3) --Расколовшаяся земля
local specWarnBiteFrenzy		= mod:NewSpecialWarningYouDefensive(218385, nil, nil, nil, 3, 3) --Бешеный укус
local specWarnBiteFrenzy2		= mod:NewSpecialWarningTargetDodge(218385, nil, nil, nil, 2, 2) --Бешеный укус
--Охотница Эстрид
local specWarnCommandCharge		= mod:NewSpecialWarningInterrupt(216276, "HasInterrupt", nil, nil, 1, 2) --Команда: Вперед!
local specWarnBearTrap			= mod:NewSpecialWarningTargetDodge(216143, nil, nil, nil, 2, 2) --Капкан на медведя
local specWarnBearTrap2			= mod:NewSpecialWarningYouMove(216143, nil, nil, nil, 3, 3) --Капкан на медведя
local specWarnBarrage			= mod:NewSpecialWarningInterrupt2(216150, nil, nil, nil, 2, 2) --Шквал
--Мават'аки
local specWarnWhistlingWinds	= mod:NewSpecialWarningTargetDodge(207056, nil, nil, nil, 2, 2) --Свистящие ветра
local specWarnWhistlingWinds2	= mod:NewSpecialWarningYouMove(207056, nil, nil, nil, 2, 2) --Свистящие ветра
local specWarnBlizzard			= mod:NewSpecialWarningInterrupt(207084, "HasInterrupt", nil, nil, 1, 2) --Снежная буря
--Морской король Волноросс
local specWarnSeaQuake			= mod:NewSpecialWarningInterrupt2(222483, nil, nil, nil, 3, 5) --Сотрясение моря
local specWarnCalloftheSeas		= mod:NewSpecialWarningSwitch(222504, "-Healer", nil, nil, 1, 2) --Зов морей
--Ревизор Изиэль
local specWarnMassSlow			= mod:NewSpecialWarningInterrupt(225254, "HasInterrupt", nil, nil, 1, 2) --Массовое замедление
local specWarnMassSlow2			= mod:NewSpecialWarningYou(225254, nil, nil, nil, 1, 3) --Массовое замедление
local specWarnLivingLedgers		= mod:NewSpecialWarningSwitch(224745, "-Healer", nil, nil, 1, 2) --Живые гроссбухи
local specWarnAnalyze			= mod:NewSpecialWarningInterrupt(224743, "HasInterrupt", nil, nil, 1, 2) --Анализ
local specWarnAnalyze2			= mod:NewSpecialWarningYou(224743, nil, nil, nil, 2, 3) --Анализ
--Грозовое Крыло
local specWarnTempestRush		= mod:NewSpecialWarningDodge(218855, nil, nil, nil, 2, 2) --Стремительность урагана
local specWarnWildWrath			= mod:NewSpecialWarningTarget(37587, nil, nil, nil, 2, 2) --Звериный гнев
--Углекрыл
local specWarnCinderwingsGaze	= mod:NewSpecialWarningInterrupt2(222446, nil, nil, nil, 3, 3) --Взор Пеплокрыла
local specWarnTaintedSpew		= mod:NewSpecialWarningDodge(222279, nil, nil, nil, 2, 2) --Выброс порчи
--Картакс
local specWarnHellfireandBrimstone	= mod:NewSpecialWarningInterrupt2(214500, nil, nil, nil, 3, 3) --Адское пламя и сера
local specWarnInferno			= mod:NewSpecialWarningDodge(222442, nil, nil, nil, 2, 2) --Преисподняя
local specWarnInferno2			= mod:NewSpecialWarningYouMove(222444, nil, nil, nil, 1, 2) --Преисподняя
--Аода Сухой Лепесток
local specWarnCorruptionSpear	= mod:NewSpecialWarningYouMoveAway(219627, nil, nil, nil, 1, 2) --Копье взрывной порчи
local specWarnCorruptionSpear2	= mod:NewSpecialWarningTargetDodge(219627, nil, nil, nil, 2, 2) --Копье взрывной порчи
local specWarnRapidShot			= mod:NewSpecialWarningDefensive(219661, nil, nil, nil, 2, 3) --Быстрострел
local specWarnShieldofDarkness 	= mod:NewSpecialWarningDispel(219646, "MagicDispeller", nil, nil, 1, 3) --Щит Тьмы
--Нилаатрия Позабытая
local specWarnCryoftheForgotten	= mod:NewSpecialWarningInterrupt(219108, "HasInterrupt", nil, nil, 1, 2) --Плач забытого
--Арканор Могучий
local specWarnExposedCore		= mod:NewSpecialWarningMoreDamage(219102, "-Healer", nil, nil, 1, 2) --Уязвимое место
local specWarnOverdrive			= mod:NewSpecialWarningDefensive(219087, nil, nil, nil, 2, 3) --Форсаж
local specWarnProtectiveShell	= mod:NewSpecialWarningInterrupt(219060, "HasInterrupt", nil, nil, 1, 2) --Защитная раковина
local specWarnProtectiveShell2 = mod:NewSpecialWarningDispel(219060, "MagicDispeller", nil, nil, 3, 2) --Защитная раковина
--Шепчущая
local specWarnWhisperingCurse	= mod:NewSpecialWarningInterrupt2(218875, nil, nil, nil, 1, 2) --Шепчущее проклятие
local specWarnLostWail			= mod:NewSpecialWarningInterrupt(218871, "HasInterrupt", nil, nil, 1, 2) --Вой заблудшей души
--Валакар Жаждущий
local specWarnViolentDischarge	= mod:NewSpecialWarningInterrupt2(218435, nil, nil, nil, 2, 3) --Бурный разряд
local specWarnSiphonMagic		= mod:NewSpecialWarningInterrupt(218427, "HasInterrupt", nil, nil, 1, 3) --Похитить магию
--
local specWarnElemRes			= mod:NewSpecialWarningDodge(216970, nil, nil, nil, 2, 3) --Стихийный резонанс
local specWarnCrysShards		= mod:NewSpecialWarningDodge(216981, nil, nil, nil, 2, 3) --Осколки кристалла
local specWarnDepthCharge		= mod:NewSpecialWarningYouMove(207002, nil, nil, nil, 3, 3) --Глубинная бомба
local specWarnTidalEruption		= mod:NewSpecialWarningDodge(206995, nil, nil, nil, 2, 2) --Приливное извержение
local specWarnHullBreach		= mod:NewSpecialWarningYouDefensive(206972, nil, nil, nil, 1, 3) --Пробой корпуса
local specWarnSoulCleave		= mod:NewSpecialWarningDodge(223630, nil, nil, nil, 2, 5) --Раскалывание душ
local specWarnSoulCleave2		= mod:NewSpecialWarningYou(223630, nil, nil, nil, 1, 3) --Раскалывание душ
local specWarnWorldBreaker		= mod:NewSpecialWarningDodge(223659, nil, nil, nil, 2, 5) --Миродробитель
local specWarnFelFissure		= mod:NewSpecialWarningDodge(218885, nil, nil, nil, 2, 5) --Разлом скверны
local specWarnFelFissure2		= mod:NewSpecialWarningYouMove(218960, nil, nil, nil, 1, 5) --Разлом скверны
local specWarnWickedLeap		= mod:NewSpecialWarningDodge(216808, nil, nil, nil, 2, 5) --Жестокий прыжок
local specWarnWickedLeap2		= mod:NewSpecialWarningTargetDodge(216808, nil, nil, nil, 2, 5) --Жестокий прыжок
local specWarnHorrificVisage	= mod:NewSpecialWarningSoonLookAway(216881, nil, nil, nil, 3, 5) --Ужасающий лик
local specWarnRemnantofLight	= mod:NewSpecialWarningInterrupt2(216837, nil, nil, nil, 2, 5) --Частица Света
local specWarnClubSlam			= mod:NewSpecialWarningYouDefensive(203671, nil, nil, nil, 3, 5) --Мощный удар дубиной
local specWarnClubSlam2			= mod:NewSpecialWarningDodge(203671, nil, nil, nil, 2, 5) --Мощный удар дубиной
local specWarnCrushingBite		= mod:NewSpecialWarningYouDefensive(206795, nil, nil, nil, 2, 5) --Дробящий укус
local specWarnFearsomeShriek	= mod:NewSpecialWarningInterrupt(206762, "HasInterrupt", nil, nil, 1, 2) --Пугающий визг
local specWarnWebWrap			= mod:NewSpecialWarningSwitch(223094, "-Healer", nil, nil, 3, 2) --Кокон
local specWarnFertilize			= mod:NewSpecialWarningInterrupt2(223104, nil, nil, nil, 3, 2) --Удобрение
local specWarnEnchantedVenom	= mod:NewSpecialWarningInterrupt(223101, "HasInterrupt", nil, nil, 1, 2) --Зачарованный яд
local specWarnDeathWail			= mod:NewSpecialWarningRun(189157, "Melee", nil, nil, 4, 5) --Вой смерти
local specWarnArcticTorrent		= mod:NewSpecialWarningDodge(218245, nil, nil, nil, 2, 3) --Арктический поток
local specWarnDeathWail2		= mod:NewSpecialWarningDodge(189157, "Ranged", nil, nil, 2, 3) --Вой смерти
local specWarnFlrglDrglDrglGrgl2 = mod:NewSpecialWarningDodge(218250, nil, nil, nil, 2, 3) --Флргл Дргл Дргл Гргл
local specWarnBladeBarrage		= mod:NewSpecialWarningInterrupt2(222596, nil, nil, nil, 2, 3) --Залп клинков
local specWarnChaosPyre			= mod:NewSpecialWarningYouMove(222631, nil, nil, nil, 1, 2) --Погребальный костер Хаоса
local specWarnFlrglDrglDrglGrgl	= mod:NewSpecialWarningInterrupt(218250, "HasInterrupt", nil, nil, 3, 5) --Флргл Дргл Дргл Гргл
local specWarnFear				= mod:NewSpecialWarningInterrupt(221424, "HasInterrupt", nil, nil, 3, 5) --Страх
local specWarnArcaneResonance	= mod:NewSpecialWarningInterrupt2(214095, nil, nil, nil, 3, 5) --Резонанс
local specWarnImpale			= mod:NewSpecialWarningInterrupt(222676, "HasInterrupt", nil, nil, 3, 5) --Прокалывание
local specWarnViciousBite		= mod:NewSpecialWarningYouDefensive(221422, nil, nil, nil, 2, 5) --Яростный укус
local specWarnCrushArmor		= mod:NewSpecialWarningStack(221425, nil, 3, nil, nil, 3, 5) --Сокрушение доспеха
--Морской король Волноросс
local timerSeaQuakeCD			= mod:NewCDTimer(21.5, 222483, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Сотрясение моря

local timerClubSlamCD			= mod:NewCDTimer(20, 203671, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Мощный удар дубиной
local timerFearsomeShriekCD		= mod:NewCDTimer(23, 206762, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Пугающий визг
local timerOverdriveCD			= mod:NewCDTimer(30, 219087, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Форсаж
local timerProtectiveShellCD	= mod:NewCDTimer(30, 219060, nil, nil, nil, 3, nil, DBM_CORE_INTERRUPT_ICON) --Защитная раковина
local timerExposedCoreCD		= mod:NewCDTimer(30, 219102, nil, nil, nil, 3, nil, DBM_CORE_DAMAGE_ICON) --Уязвимое место
local timerWebWrapCD			= mod:NewCDTimer(22, 223094, nil, nil, nil, 3, nil, DBM_CORE_DAMAGE_ICON) --Кокон
local timerFertilizeCD			= mod:NewCDTimer(22, 223104, nil, nil, nil, 3, nil, DBM_CORE_DAMAGE_ICON) --Удобрение
--Камнепад оползающий
local timerElemResCD			= mod:NewCDTimer(35, 216970, nil, nil, nil, 2, nil) --Стихийный резонанс
local timerCrysShardsCD			= mod:NewCDTimer(35, 216981, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Осколки кристалла
--Олокк Кораблекрушитель
local timerDepthChargeCD		= mod:NewCDTimer(25, 207002, nil, nil, nil, 3, nil) --Глубинная бомба
local timerHullBreachCD			= mod:NewCDTimer(12, 206972, nil, nil, nil, 3, nil, DBM_CORE_TANK_ICON) --Пробой корпуса
local timerTidalEruptionCD		= mod:NewCDTimer(19, 206995, nil, nil, nil, 2, nil) --Приливное извержение
--Воспламеан
local timerFelFissureCD			= mod:NewCDTimer(20, 218885, nil, nil, nil, 3, nil) --Разлом скверны
local timerFelMeteorCD			= mod:NewCDTimer(15, 218969, nil, nil, nil, 2, nil) --Метеорит скверны
--Лагерта
local timerWickedLeapCD			= mod:NewCDTimer(35, 216808, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Жестокий прыжок
local timerHorrificVisageCD		= mod:NewCDTimer(35, 216881, nil, nil, nil, 7, nil) --Ужасающий лик
local timerRemnantofLightCD		= mod:NewCDTimer(35, 216837, nil, nil, nil, 7, nil) --Частица Света
--Яростная китовая акула
local timerViciousBite			= mod:NewTargetTimer(15, 221422, nil, nil, nil, 5, nil) --Яростный укус
local timerViciousBiteCD		= mod:NewCDTimer(30, 221422, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON) --Яростный укус
local timerCrushArmor			= mod:NewTargetTimer(20, 221425, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON) --Сокрушение доспеха
--Джейд темная гавань
local timerBladeBarrageCD		= mod:NewCDTimer(13, 222596, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Залп клинков
local timerImpaleCD				= mod:NewCDTimer(10.5, 222676, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON) --Прокалывание
--Гргл бргл
local timerArcticTorrentCD		= mod:NewCDTimer(35, 218245, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Арктический поток
local timerFlrglDrglDrglGrglCD	= mod:NewCDTimer(20, 218250, nil, nil, nil, 2, nil, DBM_CORE_INTERRUPT_ICON) --Флргл Дргл Дргл Гргл

local timerRoleplay				= mod:NewTimer(30, "timerRoleplay", "Interface\\Icons\\Spell_Holy_BorrowedTime", nil, nil, 7) --Ролевая игра

local yellBearTrap				= mod:NewYell(216143, nil, nil, nil, "YELL") --Капкан на медведя
local yellWhistlingWinds		= mod:NewYell(207056, nil, nil, nil, "YELL") --Свистящие ветра
local yellCinderwingsGaze		= mod:NewYell(222446, nil, nil, nil, "YELL") --Взор Пеплокрыла
local yellDepthCharge			= mod:NewYell(207002, nil, nil, nil, "YELL") --Глубинная бомба
local yellFelFissure			= mod:NewYell(218885, nil, nil, nil, "YELL") --Разлом скверны
local yellWickedLeap			= mod:NewYell(216808, nil, nil, nil, "YELL") --Жестокий прыжок
local yellRemnantofLight		= mod:NewYell(216837, nil, nil, nil, "YELL") --Частица Света
local yellClubSlam				= mod:NewYell(203671, nil, nil, nil, "YELL") --Мощный удар дубиной
local yellWebWrap				= mod:NewYell(223094, nil, nil, nil, "YELL") --Кокон
local yellImpale				= mod:NewYell(222676, nil, nil, nil, "YELL") --Прокалывание
local yellImpaleFades			= mod:NewFadesYell(222676, nil, nil, nil, "YELL") --Прокалывание
local yellArcticTorrent			= mod:NewYell(218245, nil, nil, nil, "YELL") --Арктический поток

function mod:BiteFrenzyTarget(targetname, uId) --прошляпанное очко Мурчаля Прошляпенко ✔
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnBiteFrenzy:Show()
		specWarnBiteFrenzy:Play("defensive")
	else
		specWarnBiteFrenzy2:Show(targetname)
		specWarnBiteFrenzy2:Play("watchstep")
	end
end

function mod:bearTrapTarget(targetname, uId) --прошляпанное очко Мурчаля Прошляпенко ✔
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnBearTrap2:Show()
		specWarnBearTrap2:Play("runout")
		yellBearTrap:Yell()
	else
		specWarnBearTrap:Show(targetname)
		specWarnBearTrap:Play("watchstep")
	end
end

function mod:whistlingWindsTarget(targetname, uId) --прошляпанное очко Мурчаля Прошляпенко ✔
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnWhistlingWinds2:Show()
		specWarnWhistlingWinds2:Play("targetyou")
		yellWhistlingWinds:Yell()
	else
		specWarnWhistlingWinds:Show(targetname)
		specWarnWhistlingWinds:Play("watchstep")
	end
end

function mod:cinderwingsGazeTarget(targetname, uId) --прошляпанное очко Мурчаля Прошляпенко ✔
	if not targetname then return end
	if targetname == UnitName("player") then
		yellCinderwingsGaze:Yell()
	else
		warnCinderwingsGaze:Show(targetname)
	end
end

function mod:ArcticTorrentTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnArcticTorrent:Show()
		specWarnArcticTorrent:Play("targetyou")
		yellArcticTorrent:Yell()
	else
		warnArcticTorrent:Show(targetname)
		specWarnArcticTorrent:Show()
		specWarnArcticTorrent:Play("watchstep")
	end
end

function mod:ClubSlamTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnClubSlam:Show()
		specWarnClubSlam:Play("defensive")
		yellClubSlam:Yell()
	else
		warnClubSlam:Show(targetname)
		specWarnClubSlam2:Show()
		specWarnClubSlam2:Play("watchstep")
	end
end

function mod:WickedLeapTarget(targetname, uId) --Жестокий прыжок
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnWickedLeap:Show()
		specWarnWickedLeap:Play("watchstep")
		yellWickedLeap:Yell()
	else
		specWarnWickedLeap2:Show(targetname)
		specWarnWickedLeap2:Play("watchstep")
	end
end

function mod:RemnantofLightTarget(targetname, uId) --Частица Света
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnRemnantofLight:Show()
		specWarnRemnantofLight:Play("kickcast")
		specWarnHorrificVisage:Schedule(5)
		specWarnHorrificVisage:ScheduleVoice(5, "watchstep")
		yellRemnantofLight:Yell()
	else
		warnRemnantofLight:Show(targetname)
		specWarnRemnantofLight:Show()
		specWarnRemnantofLight:Play("kickcast")
		specWarnHorrificVisage:Schedule(5)
		specWarnHorrificVisage:ScheduleVoice(5, "watchstep")
	end
end

function mod:FelFissureTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnFelFissure:Show()
		specWarnFelFissure:Play("watchstep")
		yellFelFissure:Yell()
	else
		warnFelFissure:Show(targetname)
		specWarnFelFissure:Show()
		specWarnFelFissure:Play("watchstep")
	end
end

function mod:DepthChargeTarget(targetname, uId) --Глубинная бомба
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnDepthCharge:Show()
		specWarnDepthCharge:Play("runout")
		yellDepthCharge:Yell()
	else
		warnDepthCharge:Show(targetname)
	end
end

function mod:OverdriveTarget(targetname, uId) --Форсаж
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnOverdrive:Show()
		specWarnOverdrive:Play("defensive")
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 221424 then --Страх
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnFear:Show()
			specWarnFear:Play("kickcast")
		end
	elseif spellId == 222676 then --Прокалывание
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnImpale:Show()
			specWarnImpale:Play("kickcast")
		end
		timerImpaleCD:Start()
	elseif spellId == 189157 then --Вой смерти
		specWarnDeathWail:Show()
		specWarnDeathWail:Play("justrun")
		specWarnDeathWail2:Show()
		specWarnDeathWail2:Play("watchstep")
	elseif spellId == 214095 then --Резонанс
		specWarnArcaneResonance:Show()
		specWarnArcaneResonance:Play("kickcast")
	elseif spellId == 218245 then --Арктический поток
		self:BossTargetScanner(args.sourceGUID, "ArcticTorrentTarget", 0.1, 2)
		timerArcticTorrentCD:Start()
		timerFlrglDrglDrglGrglCD:Start()
	elseif spellId == 218250 then --Флргл Дргл Дргл Гргл
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnFlrglDrglDrglGrgl:Show()
			specWarnFlrglDrglDrglGrgl:Play("kickcast")
		end
	elseif spellId == 222596 then --Залп клинков
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if (cid == 103975 or cid == 111939) then
			specWarnBladeBarrage:Show()
			specWarnBladeBarrage:Play("kickcast")
			timerBladeBarrageCD:Start()
		end
	elseif spellId == 223101 then --Зачарованный яд
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnEnchantedVenom:Show()
			specWarnEnchantedVenom:Play("kickcast")
		end
	elseif spellId == 223104 then --Удобрение
		specWarnFertilize:Show()
		specWarnFertilize:Play("kickcast")
		timerFertilizeCD:Start()
	elseif spellId == 219060 then --Защитная раковина
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnProtectiveShell:Show()
			specWarnProtectiveShell:Play("kickcast")
		end
		timerProtectiveShellCD:Start()
	elseif spellId == 219060 then --Пугающий визг
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnFearsomeShriek:Show()
			specWarnFearsomeShriek:Play("kickcast")
		end
		timerFearsomeShriekCD:Start()
	elseif spellId == 203671 then --Мощный удар дубиной
		self:BossTargetScanner(args.sourceGUID, "ClubSlamTarget", 0.1, 2)
		timerClubSlamCD:Start()
	elseif spellId == 216808 then --Жестокий прыжок
		self:BossTargetScanner(args.sourceGUID, "WickedLeapTarget", 0.1, 2)
		timerWickedLeapCD:Start()
	elseif spellId == 216837 then --Частица Света
		self:BossTargetScanner(args.sourceGUID, "RemnantofLightTarget", 0.1, 2)
		timerRemnantofLightCD:Start()
	elseif spellId == 218885 then --Разлом скверны
		self:BossTargetScanner(args.sourceGUID, "FelFissureTarget", 0.1, 2)
		timerFelFissureCD:Start()
	elseif spellId == 223659 then --Миродробитель
		specWarnWorldBreaker:Show()
		specWarnWorldBreaker:Play("watchstep")
	elseif spellId == 223630 then --Раскалывание душ
		specWarnSoulCleave:Show()
		specWarnSoulCleave:Play("watchstep")
	elseif spellId == 207002 then --Глубинная бомба
		self:BossTargetScanner(args.sourceGUID, "DepthChargeTarget", 0.1, 2)
		timerDepthChargeCD:Start()
	elseif spellId == 206972 then --Пробой корпуса
		timerHullBreachCD:Start()
	elseif spellId == 206995 then --Приливное извержение
		specWarnTidalEruption:Show()
		specWarnTidalEruption:Play("watchstep")
		timerTidalEruptionCD:Start()
	elseif spellId == 216981 then --Осколки кристалла
		specWarnCrysShards:Show()
		specWarnCrysShards:Play("watchstep")
		timerCrysShardsCD:Start()
	elseif spellId == 219108 then --Плач забытого
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnCryoftheForgotten:Show()
			specWarnCryoftheForgotten:Play("kickcast")
		end
	elseif spellId == 218875 then --Шепчущее проклятие
		specWarnWhisperingCurse:Show()
		specWarnWhisperingCurse:Play("kickcast")
	elseif spellId == 218871 then --Вой заблудшей души
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnLostWail:Show()
			specWarnLostWail:Play("kickcast")
		end
	elseif spellId == 218435 then --Бурный разряд
		specWarnViolentDischarge:Show()
		specWarnViolentDischarge:Play("kickcast")
	elseif spellId == 218427 then --Похитить магию
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if cid == 109575 then
			if self:CheckInterruptFilter(args.sourceGUID, false, true) then
				specWarnSiphonMagic:Show()
				specWarnSiphonMagic:Play("kickcast")
			end
		end
	elseif spellId == 214500 then --Адское пламя и сера
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if cid == 111731 then
			if self:CheckInterruptFilter(args.sourceGUID, false, true) then
				specWarnHellfireandBrimstone:Show()
				specWarnHellfireandBrimstone:Play("kickcast")
			end
		end
	elseif spellId == 222442 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Преисподняя
		specWarnInferno:Show()
		specWarnInferno:Play("watchstep")
	elseif spellId == 222279 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Выброс порчи
		specWarnTaintedSpew:Show()
		specWarnTaintedSpew:Play("watchstep")
	elseif spellId == 222446 then --Взор Пеплокрыла
		self:BossTargetScanner(args.sourceGUID, "cinderwingsGazeTarget", 0.1, 2)
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnCinderwingsGaze:Show()
			specWarnCinderwingsGaze:Play("kickcast")
		end
	elseif spellId == 218855 then --Стремительность урагана
		specWarnTempestRush:Show()
		specWarnTempestRush:Play("watchstep")
	elseif spellId == 224743 then --Анализ
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnAnalyze:Show()
			specWarnAnalyze:Play("kickcast")
		end
	elseif spellId == 225254 then --Массовое замедление
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnMassSlow:Show()
			specWarnMassSlow:Play("kickcast")
		end
	elseif spellId == 222483 then --Сотрясение моря
		specWarnSeaQuake:Show()
		specWarnSeaQuake:Play("kickcast")
		timerSeaQuakeCD:Start()
	elseif spellId == 207084 then --Снежная буря
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnBlizzard:Show()
			specWarnBlizzard:Play("kickcast")
		end
	elseif spellId == 207056 then --Свистящие ветра
		self:BossTargetScanner(args.sourceGUID, "whistlingWindsTarget", 0.1, 2)
	elseif spellId == 216143 then --Капкан на медведя
		self:BossTargetScanner(args.sourceGUID, "bearTrapTarget", 0.1, 2)
	elseif spellId == 216276 then --Команда: Вперед!
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnCommandCharge:Show()
			specWarnCommandCharge:Play("kickcast")
		end
	elseif spellId == 218385 then --Бешеный укус
		self:BossTargetScanner(args.sourceGUID, "BiteFrenzyTarget", 0.1, 2)
	elseif spellId == 219121 then --Яростный рев
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnEnragedRoar:Show()
			specWarnEnragedRoar:Play("kickcast")
		end
	elseif spellId == 219109 then --Стряхивание
		specWarnShakeOff:Show()
		specWarnShakeOff:Play("kickcast")
	elseif spellId == 207199 then --Барьер Чар
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnArcaneBarrier:Show()
			specWarnArcaneBarrier:Play("kickcast")
		end
	elseif spellId == 225243 then --Подавление Пустоты
		specWarnNetherSuppression2:Show()
		specWarnNetherSuppression2:Play("kickcast")
	elseif spellId == 217140 then --Душа тумана
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnSoulofMist:Show()
			specWarnSoulofMist:Play("kickcast")
		end
	elseif spellId == 224659 then --Призыв выводка
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnCalloftheBrood:Show()
			specWarnCalloftheBrood:Play("kickcast")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 221422 then --Яростный укус
		timerViciousBiteCD:Start()
	elseif spellId == 218250 then --Флргл Дргл Дргл Гргл
		specWarnFlrglDrglDrglGrgl2:Show()
		specWarnFlrglDrglDrglGrgl2:Play("watchstep")
	elseif spellId == 223094 then --Кокон
		timerWebWrapCD:Start()
	elseif spellId == 216881 then --Ужасающий лик
		warnHorrificVisage:Show()
		timerHorrificVisageCD:Start()
		DBM:AddMsg("Босс фиряет, когда стоишь спиной? Это ошибка у разработчиков сервера - будем ждать починки.")
	elseif spellId == 218969 then --Метеорит скверны
		timerFelMeteorCD:Start()
	elseif spellId == 224745 then --Живые гроссбухи
		specWarnLivingLedgers:Show()
		specWarnLivingLedgers:Play("mobkill")
	elseif spellId == 222504 then --Зов морей
		specWarnCalloftheSeas:Show()
		specWarnCalloftheSeas:Play("mobkill")
	elseif spellId == 222483 then --Сотрясение моря
		specWarnSeaQuake:Show()
		specWarnSeaQuake:Play("kickcast")
	elseif spellId == 216150 then --Шквал
		specWarnBarrage:Show()
		specWarnBarrage:Play("kickcast")
	elseif spellId == 218407 then --Расколовшаяся земля
		specWarnShatteredEarth:Show()
		specWarnShatteredEarth:Play("watchstep")
	elseif spellId == 224659 then --Призыв выводка
		specWarnCalloftheBrood2:Show()
		specWarnCalloftheBrood2:Play("mobkill")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 221422 then --Яростный укус
		timerViciousBite:Start(args.destName)
		if args:IsPlayer() then
			specWarnViciousBite:Show()
			specWarnViciousBite:Play("defensive")
		end
	elseif spellId == 221425 then --Сокрушение доспеха
		local amount = args.amount or 1
		warnCrushArmor:Show(args.destName, amount)
		timerCrushArmor:Start(args.destName)
		if amount >= 3 then
			if args:IsPlayer() then
				specWarnCrushArmor:Show(args.amount)
				specWarnCrushArmor:Play("stackhigh")
			end
		end
	elseif spellId == 222676 then --Прокалывание
		warnImpale:Show(args.destName)
		if args:IsPlayer() then
			yellImpale:Yell()
			yellImpaleFades:Countdown(3)
		end
	elseif spellId == 223094 then --Кокон
		warnWebWrap:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			yellWebWrap:Yell()
		else
			specWarnWebWrap:Show()
			specWarnWebWrap:Play("mobkill")
		end
	elseif spellId == 219102 then --Уязвимое место
		specWarnExposedCore:Show(args.destName)
		timerExposedCoreCD:Start()
	elseif spellId == 219087 then --Форсаж
		self:BossTargetScanner(args.sourceGUID, "OverdriveTarget", 0.1, 2)
		timerOverdriveCD:Start()
	elseif spellId == 206795 then --Дробящий укус
		if args:IsPlayer() then
			specWarnCrushingBite:Show()
			specWarnCrushingBite:Play("defensive")
		end
	elseif spellId == 219060 then --Защитная раковина
		specWarnProtectiveShell2:Show(args.destName)
		specWarnProtectiveShell2:Play("dispelnow")
	elseif spellId == 223630 then --Раскалывание душ
		specWarnSoulCleave2:Show()
		specWarnSoulCleave2:Play("targetyou")
	elseif spellId == 206972 then --Пробой корпуса
		if args:IsPlayer() then
			specWarnHullBreach:Show()
			specWarnHullBreach:Play("defensive")
		end
	elseif spellId == 219661 and not args:IsDestTypePlayer() then --Быстрострел
		specWarnRapidShot:Show()
		specWarnRapidShot:Play("defensive")
	elseif spellId == 219646 then --Щит Тьмы
		specWarnShieldofDarkness:Show(args.destName)
		specWarnShieldofDarkness:Play("dispelnow")
	elseif spellId == 37587 then --Звериный гнев
		specWarnWildWrath:Show(args.destName)
		specWarnHullBreach:Play("watchstep")
	elseif spellId == 222631 then --Погребальный костер Хаоса
		specWarnChaosPyre:Show()
		specWarnChaosPyre:Play("runout")
	elseif spellId == 219627 then --Копье взрывной порчи
		if args:IsPlayer() then
			specWarnCorruptionSpear:Show()
			specWarnCorruptionSpear:Play("runout")
		else
			specWarnCorruptionSpear2:Show(args.destName)
			specWarnCorruptionSpear2:Play("watchstep")
		end
	elseif spellId == 224743 then --Анализ
		if args:IsPlayer() then
			specWarnAnalyze2:Show()
			specWarnAnalyze2:Play("targetyou")
		end
	elseif spellId == 225254 then --Массовое замедление
		if args:IsPlayer() then
			specWarnMassSlow2:Show()
			specWarnMassSlow2:Play("targetyou")
		end
	elseif spellId == 207199 then --Барьер Чар
		specWarnArcaneBarrier2:Show(args.destName)
		specWarnArcaneBarrier2:Play("dispelnow")
	elseif spellId == 225243 then --Подавление Пустоты
		if args:IsPlayer() then
			specWarnNetherSuppression:Show()
			specWarnNetherSuppression:Play("targetyou")
		end
	elseif spellId == 217140 then --Душа тумана
		if self:IsMagicDispeller() then
			specWarnSoulofMist2:Show(args.destName)
			specWarnSoulofMist2:Play("dispelnow")
		else
			specWarnSoulofMist3:Show(args.destName)
			specWarnSoulofMist3:Play("stopattack")
		end
	elseif spellId == 225222 then --Жестокое рассечение
		if args:IsPlayer() then
			specWarnWickedSlice:Show()
			specWarnWickedSlice:Play("defensive")
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 221422 then --Яростный укус
		timerViciousBite:Cancel(args.destName)
	elseif spellId == 221425 then --Сокрушение доспеха
		timerCrushArmor:Cancel(args.destName)
	end
end

function mod:CHAT_MSG_MONSTER_SAY(msg)
	if msg == L.PullSkulvrax then
		timerRoleplay:Start(31)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 218960 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnFelFissure2:Show()
		specWarnFelFissure2:Play("runaway")
	elseif spellId == 222444 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then --Преисподняя
		specWarnInferno2:Show()
		specWarnInferno2:Play("runaway")
	elseif spellId == 217130 and destGUID == UnitGUID("player") and self:AntiSpam(2, 3) then --Ползучий туман
		specWarnCreepingMist:Show()
		specWarnCreepingMist:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 104481 then --Алаваште https://ru.wowhead.com/npc=104481/алаваште +++
		timerFearsomeShriekCD:Cancel()
	elseif cid == 109641 then --Арканор могучий https://ru.wowhead.com/npc=109641/арканор-могучий
		timerProtectiveShellCD:Cancel()
		timerExposedCoreCD:Cancel()
		timerOverdriveCD:Cancel()
	elseif cid == 111454 then --Бестрикс https://ru.wowhead.com/npc=111454/бестрикс
		timerWebWrapCD:Cancel()
		timerFertilizeCD:Cancel()
	elseif cid == 103975 then --Джейд темная гавань https://ru.wowhead.com/npc=103975/джейд-темная-гавань +++
		timerBladeBarrageCD:Cancel()
		timerImpaleCD:Cancel()
	elseif cid == 109648 then --Гргл бргл https://ru.wowhead.com/npc=109648/знахарь-гргл-бргл
		timerArcticTorrentCD:Cancel()
		timerFlrglDrglDrglGrglCD:Cancel()
	elseif cid == 99899 then --Яростная китовая акула https://ru.wowhead.com/npc=99899/яростная-китовая-акула
		timerViciousBiteCD:Cancel()
	elseif cid == 105899 then --Оглок неистовый https://ru.wowhead.com/npc=105899/оглок-неистовый
		timerClubSlamCD:Cancel()
	elseif cid == 109015 then --Лагерта https://ru.wowhead.com/npc=109015/лагерта +++
		specWarnHorrificVisage:Cancel()
		timerWickedLeapCD:Cancel()
		timerHorrificVisageCD:Cancel()
		timerRemnantofLightCD:Cancel()
	elseif cid == 109630 then --Воспламеан https://ru.wowhead.com/npc=109630/воспламеан
		timerFelFissureCD:Cancel()
		timerFelMeteorCD:Cancel()
	elseif cid == 104484 then --Олокк Кораблекрушитель https://ru.wowhead.com/npc=104484/олокк-кораблекрушитель
		timerDepthChargeCD:Cancel()
		timerHullBreachCD:Cancel()
		timerTidalEruptionCD:Cancel()
	elseif cid == 109113 then --Камнепад оползающий https://ru.wowhead.com/npc=109113/камнепад-оползающий
		timerCrysShardsCD:Cancel()
		timerElemResCD:Cancel()
	elseif cid == 111434 then --Морской король Волноросс https://www.wowhead.com/ru/npc=111434/морской-король-волноросс#abilities
		timerSeaQuakeCD:Cancel()
	end
end

function mod:GOSSIP_SHOW()
	local guid = UnitGUID("npc")
	if not guid then return end
	local cid = self:GetCIDFromGUID(guid)
	if cid == 97215 then -- Повелитель зверей Пао'лек
		if select('#', GetGossipOptions()) > 0 then
			SelectGossipOption(1)
			CloseGossip()
		end
	end
end
