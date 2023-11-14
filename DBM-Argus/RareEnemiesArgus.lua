local mod	= DBM:NewMod("RareEnemiesArgus", "DBM-Argus", nil, 822)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17745 $"):sub(12, -3))
mod:SetZone()
mod:SetMinSyncRevision(17650)

mod.noStatistics = true
mod.isTrashMod = true

--Тут будут новые прошляпы Мурчаля и Idiot`а--

mod:RegisterEvents(
	"SPELL_CAST_START 254099 254106 254044 254046 251302 251317 241917 254477 252663 222623 253972 254266 233228 254190 254288 222596 251091 251284 251703 251689 251683 251470 251714 252064 252057 252065 185777 233306 242021 238592 242069 203956 249854 238984 237308 220267 250963 251246 251276 251265 244623 242471 242397 254079 254012 254026 253978 249879 254168 254163 222900 253563",
	"SPELL_CAST_SUCCESS 252055 223421 242071 203109 254079",
	"SPELL_AURA_APPLIED 254106 254480 252037 252038 254015 254268 233228 254200 222620 252057 253068 218121 183270 220267 251245 246317 253978 254281 238681 253545",
	"SPELL_AURA_APPLIED_DOSE 252037 183270 246317",
	"SPELL_AURA_REMOVED 254200 253545",
	"SPELL_PERIODIC_DAMAGE 222631 250926 223292 254218",
	"SPELL_PERIODIC_MISSED 222631 250926 223292 254218",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"LOADING_SCREEN_DISABLED",
	"UNIT_DIED"
)

--прошляпанное очко Мурчаля Прошляпенко [✔]

local warnMajesticRoar				= mod:NewStackAnnounce(252037, 3) --Величественный рык
local warnIgnition					= mod:NewTargetAnnounce(254480, 2) --Зажигание
local warnHeadCrack					= mod:NewTargetAnnounce(254015, 2) --Трещина в черепе
local warnEnrage					= mod:NewTargetAnnounce(218121, 2) --Исступление
local warnDreadInspiration			= mod:NewTargetAnnounce(251245, 2) --Жуткое воодушевление
------------------------------------------------МАК'АРИ------------------------------------------------------------------------
--Зул'тан Многоликий https://www.wowhead.com/ru/npc=126908/зултан-многоликий
local specWarnOozingPool			= mod:NewSpecialWarningYouMove(254218, nil, nil, nil, 1, 2) --Склизкая лужа
--Чемпион джед'хин Воруск
local specWarnIronCharge			= mod:NewSpecialWarningYouMoveAway(254163, nil, nil, nil, 1, 3) --Железный рывок
local specWarnSeismicStomp			= mod:NewSpecialWarningDodge(254168, nil, nil, nil, 2, 2) --Сотрясающий топот
--Слизон Последний из Змеев https://www.wowhead.com/ru/npc=126913/слизон-последний-из-змеев
local specWarnVenomousFangs		 	= mod:NewSpecialWarningYouDispel(254281, "PoisonDispeller", nil, nil, 2, 2) --Отравленные клыки
--Пастух Кравос
local specWarnBladestorm			= mod:NewSpecialWarningInterrupt2(253978, nil, nil, nil, 1, 2) --Вихрь клинков
local specWarnBladestorm2			= mod:NewSpecialWarningDodge(253978, nil, nil, nil, 2, 2) --Вихрь клинков
--Дозорный Куро https://www.wowhead.com/ru/npc=126866/дозорный-куро
local specWarnSearingWrath			= mod:NewSpecialWarningInterrupt(254026, "HasInterrupt", nil, nil, 1, 2) --Жгучий гнев
--Дозорный Танос https://www.wowhead.com/ru/npc=126865/дозорный-танос
local specWarnAnnihilation			= mod:NewSpecialWarningDodge(254012, nil, nil, nil, 2, 3) --Аннигиляция
--Капитан Фарук https://www.wowhead.com/ru/npc=126869/капитан-фарук
local specWarnNegationBlade			= mod:NewSpecialWarningStack(246317, nil, 3, nil, nil, 2, 2) --Подавляющий клинок
--Атаксон
local specWarnUmbralCrush			= mod:NewSpecialWarningInterrupt2(254079, nil, nil, nil, 1, 2) --Теневое сокрушение
local specWarnUmbralCrush2			= mod:NewSpecialWarningSwitch(254079, "-Healer", nil, nil, 2, 3) --Теневое сокрушение
--Вестник хаоса https://www.wowhead.com/ru/npc=126896/вестник-хаоса
local specWarnVoidExhaust			= mod:NewSpecialWarningInterrupt2(242397, nil, nil, nil, 2, 2) --Извержение Бездны
local specWarnDarkBolt				= mod:NewSpecialWarningInterrupt(242471, "HasInterrupt", nil, nil, 1, 2) --Мрачная стрела
--Темный чародей Воруун
local specWarnShadowStorm			= mod:NewSpecialWarningInterrupt(254288, "HasInterrupt", nil, nil, 1, 2) --Буря Тени
--Инструктор Тарахна
local specWarnShadowNova			= mod:NewSpecialWarningInterrupt(254190, "HasInterrupt", nil, nil, 1, 2) --Кольцо Тьмы
local specWarnDarkSurge				= mod:NewSpecialWarningYouMoveAway(254200, nil, nil, nil, 4, 3) --Темная волна
local specWarnDarkSurge2			= mod:NewSpecialWarningCloseMoveAway(254200, nil, nil, nil, 2, 3) --Темная волна
local specWarnDarkSurge3			= mod:NewSpecialWarningYouMove(254200, nil, nil, nil, 2, 2) --Темная волна
--Командир Ксетгар
local specWarnScorchingSwipe		= mod:NewSpecialWarningInterrupt2(233228, nil, nil, nil, 1, 2) --Опаляющий размах
local specWarnScorchingSwipe2		= mod:NewSpecialWarningYou(233228, nil, nil, nil, 2, 3) --Опаляющий размах
local specWarnChaoticFelburst		= mod:NewSpecialWarningDodge(223421, nil, nil, nil, 2, 3) --Хаотический взрыв Скверны
--Скрииг Пожиратель
local specWarnRavenousScream		= mod:NewSpecialWarningInterrupt(254266, "HasInterrupt", nil, nil, 1, 2) --Хищный визг
local specWarnBloodySwipe			= mod:NewSpecialWarningYou(254268, nil, nil, nil, 2, 3) --Кровавый размах
--Соролис Нелюбимец Судьбы
local specWarnDarkRift				= mod:NewSpecialWarningInterrupt2(254099, nil, nil, nil, 1, 2) --Разлом Тьмы
local specWarnChaoticFlames			= mod:NewSpecialWarningInterrupt(254106, "HasInterrupt", nil, nil, 1, 2) --Пламя хаоса
local specWarnChaoticFlames2		= mod:NewSpecialWarningYou(254106, nil, nil, nil, 2, 3) --Пламя хаоса
--Ядовитый небесный скат
local specWarnShatteringScreech		= mod:NewSpecialWarningInterrupt(254044, "HasInterrupt", nil, nil, 1, 2) --Сокрушающий визг
local specWarnDarkTorrent			= mod:NewSpecialWarningInterrupt2(254046, nil, nil, nil, 2, 2) --Темный поток
--Надзирательница И'Морна
local specWarnChaosSlash			= mod:NewSpecialWarningYou(222623, nil, nil, nil, 1, 2) --Рассекающий удар Хаоса
local specWarnChaosPyre				= mod:NewSpecialWarningYouMove(222631, nil, nil, nil, 1, 2) --Погребальный костер Хаоса
local specWarnWrathofArgus			= mod:NewSpecialWarningCloseMoveAway(252663, nil, nil, nil, 1, 2) --Гнев Аргуса
local specWarnWrathofArgus2			= mod:NewSpecialWarningYou(252663, nil, nil, nil, 1, 2) --Гнев Аргуса
--Надзирательница И'Беда https://www.wowhead.com/ru/npc=124440/надзирательница-ибеда
--Надзирательница И'cорна https://www.wowhead.com/ru/npc=125497/надзирательница-иcорна
--Физл Кексовор https://www.wowhead.com/ru/npc=126864/физл-кексовор
local specWarnBurrow				= mod:NewSpecialWarningInterrupt(253972, "HasInterrupt", nil, nil, 1, 2) --Зарыться
--Турек Мерцающий https://www.wowhead.com/ru/npc=126868/турек-мерцающий
--Каара Бледная https://www.wowhead.com/ru/npc=126860/каара-бледная
--Баруут Кровожадный https://www.wowhead.com/ru/npc=126862/баруут-кровожадный
--Искаженное чудовище https://www.wowhead.com/ru/npc=126815/искаженное-чудовище
--Сабуул https://www.wowhead.com/ru/npc=126898/сабуул
--Мраколиск https://www.wowhead.com/ru/npc=126885/мраколиск
------------------------------------------------ПУСТОШИ АНТОРУСА------------------------------------------------------------------
--Навлекающий погибель Супракс https://www.wowhead.com/ru/npc=127703/навлекающий-погибель-супракс
local specWarnDoomStar				= mod:NewSpecialWarningInterrupt(253563, "HasInterrupt", nil, nil, 1, 2) --Звезда рока
local specWarnEmpoweredDoom 		= mod:NewSpecialWarningYou(253545, nil, nil, nil, 3, 6) --Неизбежный рок
local specWarnEmpoweredDoom2		= mod:NewSpecialWarningMoveTo(253545, nil, nil, nil, 3, 6) --Неизбежный рок
--Повелитель гнева Ярез https://www.wowhead.com/ru/npc=126338/повелитель-гнева-ярез
--анонс взят с Пастуха Кравос
--Язвоглот
local specWarnBlisteringWave		= mod:NewSpecialWarningInterrupt2(249879, nil, nil, nil, 1, 2) --Кипящая волна
--Командир Текслаз https://www.wowhead.com/ru/npc=127084/командир-текслаз
local specWarnIntimidatingRoar		= mod:NewSpecialWarningInterrupt(222900, "HasInterrupt", nil, nil, 1, 2) --Устрашающий рев
--Гар'зот
local specWarnGlaiveBlast			= mod:NewSpecialWarningDodge(244623, nil, nil, nil, 2, 3) --Удар властителя преисподней
local specWarnRainofFire			= mod:NewSpecialWarningYouMove(223292, nil, nil, nil, 1, 2) --Огненный ливень
--Яд'орн https://www.wowhead.com/ru/npc=126115/ядорн
local specWarnPoisonNova			= mod:NewSpecialWarningInterrupt(220267, "HasInterrupt", nil, nil, 1, 2) --Ядовитая звезда
local specWarnPoisonNova2		 	= mod:NewSpecialWarningYouDispel(220267, "PoisonDispeller", nil, nil, 1, 2) --Ядовитая звезда
--Лейтенант Закаар https://www.wowhead.com/ru/npc=126254/лейтенант-закаар
local specWarnWitheringRoar			= mod:NewSpecialWarningStack(183270, nil, 3, nil, nil, 1, 2) --Губительный рев
--Госпожа Ил'тендра
local specWarnInfernalTempest		= mod:NewSpecialWarningInterrupt2(249854, nil, nil, nil, 2, 2) --Инфернальная буря
local specWarnFelFireball			= mod:NewSpecialWarningInterrupt(238984, "HasInterrupt", nil, nil, 1, 2) --Огненный шар Скверны
--Хадрокс и Радикс и Адмирал Рел'вар
local specWarnEarthshatteringSlash	= mod:NewSpecialWarningYouMove(203956, nil, nil, nil, 2, 2) --Взмах землекрушителя
local specWarnEarthshatteringSlash2	= mod:NewSpecialWarningCloseMoveAway(203956, nil, nil, nil, 2, 2) --Взмах землекрушителя
--Смотритель Айвал
local specWarnShadowBolt2			= mod:NewSpecialWarningInterrupt(238592, "HasInterrupt", nil, nil, 1, 3) --Стрела Тьмы
local specWarnChaosGlare			= mod:NewSpecialWarningDodge(242069, nil, nil, nil, 2, 3) --Взор Хаоса
--Вракс'тул, Провидец Ксанариан и Инквизитор Ветроз
local specWarnFelNova				= mod:NewSpecialWarningDodge(237308, nil, nil, nil, 2, 3) --Кольцо энергии Скверны
local specWarnProphecyofCalamity	= mod:NewSpecialWarningYou(253068, nil, nil, nil, 1, 2) --Предсказание катастрофы
local specWarnProphecyofCalamity2 	= mod:NewSpecialWarningYouDispel(253068, "CurseDispeller", nil, nil, 1, 3) --Предсказание катастрофы
local specWarnShadowfrostNova		= mod:NewSpecialWarningInterrupt(242021, "HasInterrupt", nil, nil, 1, 3) --Кольцо льда Тьмы
--Хранительница Бездны Валсурана
local specWarnShadowRend			= mod:NewSpecialWarningInterrupt2(203109, nil, nil, nil, 2, 2) --Темное кровопускание
local specWarnTorrentofShadow		= mod:NewSpecialWarningInterrupt(233306, "HasInterrupt", nil, nil, 1, 3) --Темный поток
--Пузцилла
local specWarnImps					= mod:NewSpecialWarningSwitch(242071, "-Healer", nil, nil, 2, 2) --Бесы!
local specWarnChaosNova				= mod:NewSpecialWarningInterrupt(185777, "HasInterrupt", nil, nil, 1, 3) --Кольцо Хаоса
--Главный алхимик Мункул
local specWarnThrowFelflameImp		= mod:NewSpecialWarningYouMoveAway(241917, nil, nil, nil, 2, 3) --Бросок беса пламени Скверны
local specWarnThrowFelflameImp2		= mod:NewSpecialWarningCloseMoveAway(241917, nil, nil, nil, 2, 3) --Бросок беса пламени Скверны
--Вечнопылающий вестник ужаса
local specWarnBlisteringFel			= mod:NewSpecialWarningDodge(254477, nil, nil, nil, 2, 3) --Жгучая Скверна
local specWarnBlisteringFel2		= mod:NewSpecialWarningCloseMoveAway(254477, nil, nil, nil, 2, 3) --Жгучая Скверна
local specWarnIgnition				= mod:NewSpecialWarningYouMoveAway(254480, nil, nil, nil, 4, 3) --Зажигание
--Параксий
local specWarnParaxisIncoming		= mod:NewSpecialWarningSpell(255102, nil, nil, nil, 2, 3) --"Параксий" на подходе
local specWarnTheParaxis			= mod:NewSpecialWarningMoveTo(252508, nil, nil, nil, 4, 6) --"Параксий"
--Варга https://www.wowhead.com/ru/npc=126208/варга
--Миродробитель Скуул https://www.wowhead.com/ru/npc=127118/миродробитель-скуул
--Псарь Керракс https://www.wowhead.com/ru/npc=127288/псарь-керракс
------------------------------------------------КРОКУУН------------------------------------------------------------------------
--Командир Викайя
local specWarnFelBackdraft				= mod:NewSpecialWarningInterrupt2(251265, nil, nil, nil, 1, 2) --Обратный поток Скверны
local specWarnSunderingCrash			= mod:NewSpecialWarningDodge(251276, nil, nil, nil, 2, 2) --Раскалывающий натиск
local specWarnSunderingCrash2			= mod:NewSpecialWarningCloseMoveAway(251276, nil, nil, nil, 2, 2) --Раскалывающий натиск
--Командир Эндаксий
local specWarnBrutishSlam				= mod:NewSpecialWarningDodge(251246, nil, nil, nil, 2, 2) --Жестокий мощный удар
local specWarnOverpoweringFlurry		= mod:NewSpecialWarningDodge(250963, nil, nil, nil, 1, 2) --Подавляющий шквал
--Вагат Обманутый
local specWarnShadowBolt				= mod:NewSpecialWarningInterrupt(252065, "HasInterrupt", nil, nil, 1, 3) --Стрела Тьмы
local specWarnCripplingBurst			= mod:NewSpecialWarningInterrupt(252057, "HasInterrupt", nil, nil, 1, 3) --Калечащий порыв
local specWarnCripplingBurst2			= mod:NewSpecialWarningYou(252057, nil, nil, nil, 1, 3) --Калечащий порыв
local specWarnCripplingBurst3 			= mod:NewSpecialWarningYouDispel(252057, "MagicDispeller2", nil, nil, 1, 3) --Калечащий порыв
local specWarnCarrionSwarm				= mod:NewSpecialWarningDodge(252064, nil, nil, nil, 2, 3) --Темная стая
local specWarnCarrionSwarm2				= mod:NewSpecialWarningCloseMoveAway(252064, nil, nil, nil, 2, 3) --Темная стая
--Смолоплюй
local specWarnTarExpulsion				= mod:NewSpecialWarningDodge(251714, nil, nil, nil, 2, 3) --Извержение смолы
--Казадуум https://www.wowhead.com/ru/npc=125824/казадуум
local specWarnInfernalSmash				= mod:NewSpecialWarningInterrupt2(251470, nil, nil, nil, 1, 2) --Инфернальный мощный удар
--Нароу
local specWarnSovereignsTear			= mod:NewSpecialWarningYou(252038, nil, nil, nil, 1, 3) --Слеза властителя
local specWarnAmbush					= mod:NewSpecialWarningDodge(252055, nil, nil, nil, 2, 3) --Внезапный удар
--Командир Сатренаэль
local specWarnColossalBlowback			= mod:NewSpecialWarningDodge(251302, nil, nil, nil, 2, 3) --Мощнейший удар с размаха
local specWarnColossalBlowback2			= mod:NewSpecialWarningCloseMoveAway(251302, nil, nil, nil, 2, 3) --Мощнейший удар с размаха
local specWarnImperiousBeam				= mod:NewSpecialWarningInterrupt2(251317, nil, nil, nil, 2, 2) --Деспотический луч
--Талестра Злобная
local specWarnBladeBarrage				= mod:NewSpecialWarningInterrupt2(222596, nil, nil, nil, 2, 3) --Залп клинков
local specWarnFelStrike					= mod:NewSpecialWarningYou(222620, nil, nil, nil, 1, 3) --Удар Скверны
--Осадный мастер Вораан
local specWarnSunderedGround			= mod:NewSpecialWarningYouMove(250926, nil, nil, nil, 1, 2) --Расколотая земля
local specWarnOrderBombardment			= mod:NewSpecialWarningInterrupt2(251091, nil, nil, nil, 2, 2) --Приказ начать обстрел
--Сестра Диверсия
local specWarnObey						= mod:NewSpecialWarningRun(251284, nil, nil, nil, 4, 3) --Повиновение
--Мать бесов Леглата
local specWarnWrathBolt					= mod:NewSpecialWarningInterrupt(251703, "HasInterrupt", nil, nil, 1, 2) --Стрела гнева
local specWarnMatronsRage				= mod:NewSpecialWarningYouDefensive(251689, nil, nil, nil, 2, 3) --Материнский гнев
local specWarnMatronsRage2				= mod:NewSpecialWarningCloseMoveAway(251689, nil, nil, nil, 2, 3) --Материнский гнев
local specWarnEldersWrath				= mod:NewSpecialWarningInterrupt2(251683, nil, nil, nil, 2, 2) --Ярость старейшины
--Терек Подборщик https://www.wowhead.com/ru/npc=124804/терек-подборщик

mod:AddTimerLine(GENERAL)
local timerRavenousScreamCD				= mod:NewCDTimer(20, 254266, nil, nil, nil, 4) --Хищный визг
local timerChaosGlareCD					= mod:NewCDTimer(20, 242069, nil, nil, nil, 7) --Взор Хаоса
local timerParaxisIncomingCD			= mod:NewCDTimer(181.5, 255102, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --"Параксий" на подходе

local countdownParaxisIncoming			= mod:NewCountdown(181.5, 255102, nil, nil, 10) --"Параксий" на подходе

local yellEmpoweredDoom					= mod:NewFadesYell(253545, nil, nil, nil, "YELL") --Неизбежный рок
local yellIronCharge					= mod:NewYell(254163, nil, nil, nil, "YELL") --Железный рывок
local yellVoidExhaust					= mod:NewYell(242397, nil, nil, nil, "YELL") --Извержение Бездны
local yellEarthshatteringSlash			= mod:NewYell(203956, nil, nil, nil, "YELL") --Взмах землекрушителя
local yellChaosGlare					= mod:NewYell(242069, nil, nil, nil, "YELL") --Взор Хаоса
local yellCarrionSwarm					= mod:NewYell(252064, nil, nil, nil, "YELL") --Темная стая
local yellDarMatronsRage				= mod:NewYell(251689, nil, nil, nil, "YELL") --Материнский гнев
local yellDarkSurge						= mod:NewYell(254200, nil, nil, nil, "YELL") --Темная волна
local yellDarkSurge2					= mod:NewFadesYell(254200, nil, nil, nil, "YELL") --Темная волна
local yellIgnition						= mod:NewYell(254480, nil, nil, nil, "YELL") --Зажигание
local yellIgnition2						= mod:NewFadesYell(254480, nil, nil, nil, "YELL") --Зажигание

local shield = DBM:GetSpellInfo(252509) --Защита Света
local doom   = DBM:GetSpellInfo(253563) --Звезда рока
	
function mod:IronChargeTarget(targetname, uId) --прошляпанное очко Мурчаля Прошляпенко ✔
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnIronCharge:Show()
	--	specWarnIronCharge:Play("targetyou")
		yellIronCharge:Yell() 
	end
end

function mod:VoidExhaustTarget(targetname, uId) --прошляпанное очко Мурчаля Прошляпенко ✔
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnVoidExhaust:Show()
	--	specWarnVoidExhaust:Play("kickcast")
		yellVoidExhaust:Yell()
	else
		specWarnVoidExhaust:Show()
	--	specWarnVoidExhaust:Play("kickcast")
	end
end

function mod:SunderingCrashTarget(targetname, uId) --прошляпанное очко Мурчаля Прошляпенко ✔
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnSunderingCrash:Show()
	--	specWarnSunderingCrash:Play("runaway")
	elseif self:CheckNearby(15, targetname) then
		specWarnSunderingCrash2:Show()
	--	specWarnSunderingCrash2:Play("watchstep")
	end
end

function mod:ChaosGlareTarget(targetname, uId) --прошляпанное очко Мурчаля Прошляпенко ✔
	if not targetname then return end
	if targetname == UnitName("player") then
		yellChaosGlare:Yell() 
	end
end

function mod:EarthshatteringSlashTarget(targetname, uId) --прошляпанное очко Мурчаля Прошляпенко ✔
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnEarthshatteringSlash:Show()
	--	specWarnEarthshatteringSlash:Play("runaway")
		yellEarthshatteringSlash:Yell() 
	elseif self:CheckNearby(15, targetname) then
		specWarnEarthshatteringSlash2:Show()
	--	specWarnEarthshatteringSlash2:Play("watchstep")
	end
end

function mod:CarrionSwarmTarget(targetname, uId) --прошляпанное очко Мурчаля Прошляпенко ✔
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnCarrionSwarm:Show()
	--	specWarnCarrionSwarm:Play("watchstep")
		yellCarrionSwarm:Yell() 
	elseif self:CheckNearby(15, targetname) then
		specWarnCarrionSwarm2:Show()
	--	specWarnCarrionSwarm2:Play("watchstep")
	end
end

function mod:MatronsRageTarget(targetname, uId) --прошляпанное очко Мурчаля Прошляпенко ✔
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnMatronsRage:Show()
	--	specWarnMatronsRage:Play("defensive")
		yellDarMatronsRage:Yell() 
	elseif self:CheckNearby(15, targetname) then
		specWarnMatronsRage2:Show()
	--	specWarnMatronsRage2:Play("watchstep")
	end
end

function mod:ChaosSlashTarget(targetname, uId) --прошляпанное очко Мурчаля Прошляпенко ✔
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnChaosSlash:Show()
	--	specWarnChaosSlash:Play("targetyou")
	end
end

function mod:ColossalBlowbackTarget(targetname, uId) --прошляпанное очко Мурчаля Прошляпенко ✔
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnColossalBlowback:Show()
	--	specWarnColossalBlowback:Play("watchstep")
	else
		specWarnThrowFelflameImp2:Show(targetname)
	--	specWarnThrowFelflameImp2:Play("watchstep")
	end
end

function mod:ThrowFelflameImpTarget(targetname, uId) --прошляпанное очко Мурчаля Прошляпенко ✔
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnThrowFelflameImp:Show()
	--	specWarnThrowFelflameImp:Play("runaway")
	else
		specWarnColossalBlowback2:Show(targetname)
	--	specWarnColossalBlowback2:Play("watchstep")
	end
end

function mod:BlisteringFelTarget(targetname, uId) --прошляпанное очко Мурчаля Прошляпенко ✔
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnBlisteringFel:Show()
	--	specWarnBlisteringFel:Play("runaway")
	else
		specWarnBlisteringFel2:Show(targetname)
	--	specWarnBlisteringFel2:Play("watchstep")
	end
end

function mod:WrathofArgusTarget(targetname, uId) --прошляпанное очко Мурчаля Прошляпенко ✔
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnWrathofArgus2:Show()
	--	specWarnWrathofArgus2:Play("targetyou")
	elseif self:CheckNearby(10, targetname) then
		specWarnWrathofArgus:Show(targetname)
	--	specWarnWrathofArgus:Play("runaway")
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 254099 then --Разлом Тьмы
		specWarnDarkRift:Show()
	--	specWarnDarkRift:Play("kickcast")
	elseif spellId == 254106 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Пламя хаоса
		specWarnChaoticFlames:Show()
	--	specWarnChaoticFlames:Play("kickcast")
	elseif spellId == 254044 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Сокрушающий визг
		specWarnShatteringScreech:Show()
	--	specWarnShatteringScreech:Play("kickcast")
	elseif spellId == 254046 then --Темный поток
		specWarnDarkTorrent:Show()
	--	specWarnDarkTorrent:Play("kickcast")
	elseif spellId == 251302 then --Мощнейший удар с размаха
		self:BossTargetScanner(args.sourceGUID, "ColossalBlowbackTarget", 0.1, 2)
	elseif spellId == 251317 then --Деспотический луч
		specWarnImperiousBeam:Show()
	--	specWarnImperiousBeam:Play("kickcast")
	elseif spellId == 241917 then --Бросок беса пламени Скверны
		self:BossTargetScanner(args.sourceGUID, "ThrowFelflameImpTarget", 0.1, 2)
	elseif spellId == 254477 then --Жгучая Скверна
		self:BossTargetScanner(args.sourceGUID, "BlisteringFelTarget", 0.1, 2)
	elseif spellId == 252663 then --Гнев Аргуса
		self:BossTargetScanner(args.sourceGUID, "WrathofArgusTarget", 0.1, 2)
	elseif spellId == 222623 then --Рассекающий удар Хаоса
		self:BossTargetScanner(args.sourceGUID, "ChaosSlashTarget", 0.1, 2)
	elseif spellId == 253972 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Пламя хаоса
		specWarnBurrow:Show()
	--	specWarnBurrow:Play("kickcast")
	elseif spellId == 254266 then --Хищный визг
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnRavenousScream:Show()
		--	specWarnRavenousScream:Play("kickcast")
		end
		timerRavenousScreamCD:Start()
	elseif spellId == 233228 then --Опаляющий размах
		specWarnScorchingSwipe:Show()
	--	specWarnScorchingSwipe:Play("kickcast")
	elseif spellId == 254190 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Кольцо Тьмы
		specWarnShadowNova:Show()
	--	specWarnShadowNova:Play("kickcast")
	elseif spellId == 254288 then --Буря Тени
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnShadowStorm:Show()
		--	specWarnShadowStorm:Play("kickcast")
		end
	elseif spellId == 222596 then --Залп клинков
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if cid == 123689 then
			specWarnBladeBarrage:Show()
		--	specWarnBladeBarrage:Play("kickcast")
		end
	elseif spellId == 251091 then --Приказ начать обстрел
		specWarnOrderBombardment:Show()
	--	specWarnOrderBombardment:Play("kickcast")
	elseif spellId == 251284 then --Повиновение
		specWarnObey:Show()
		specWarnObey:Play("justrun")
	elseif spellId == 251703 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Стрела гнева
		specWarnWrathBolt:Show()
	--	specWarnWrathBolt:Play("kickcast")
	elseif spellId == 251689 then --Материнский гнев
		self:BossTargetScanner(args.sourceGUID, "MatronsRageTarget", 0.1, 2)
	elseif spellId == 251683 then --Материнский гнев
		specWarnEldersWrath:Show()
	--	specWarnEldersWrath:Play("kickcast")
	elseif spellId == 251470 then --Инфернальный мощный удар
		specWarnInfernalSmash:Show()
	--	specWarnInfernalSmash:Play("kickcast")
	elseif spellId == 251714 then --Извержение смолы
		specWarnTarExpulsion:Show()
	--	specWarnTarExpulsion:Play("watchstep")
	elseif spellId == 252064 then --Темная стая
		self:BossTargetScanner(args.sourceGUID, "CarrionSwarmTarget", 0.1, 2)
	elseif spellId == 252057 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Калечащий порыв
		specWarnCripplingBurst:Show()
	--	specWarnCripplingBurst:Play("kickcast")
	elseif spellId == 185777 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Кольцо Хаоса
		specWarnChaosNova:Show()
	--	specWarnChaosNova:Play("kickcast")
	elseif spellId == 233306 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Темный поток
		specWarnTorrentofShadow:Show()
	--	specWarnTorrentofShadow:Play("kickcast")
	elseif spellId == 242021 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Кольцо льда Тьмы
		specWarnShadowfrostNova:Show()
	--	specWarnShadowfrostNova:Play("kickcast")
	elseif spellId == 238592 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Стрела Тьмы
--		if cid == 127291 then
		specWarnShadowBolt2:Show()
	--	specWarnShadowBolt2:Play("kickcast")
	elseif spellId == 242069 then --Взор Хаоса
		self:BossTargetScanner(args.sourceGUID, "ChaosGlareTarget", 0.1, 2)
		specWarnChaosGlare:Show()
	--	specWarnChaosGlare:Play("watchstep")
		timerChaosGlareCD:Start()
	elseif spellId == 203956 then --Взмах землекрушителя
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if cid == 126164 or cid == 126196 or cid == 127090 then
			self:BossTargetScanner(args.sourceGUID, "EarthshatteringSlashTarget", 0.1, 2)
		end
	elseif spellId == 249854 then --Инфернальная буря
		specWarnInfernalTempest:Show()
	--	specWarnInfernalTempest:Play("kickcast")
	elseif spellId == 238984 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Огненный шар Скверны
--		if cid == 122947 then
		specWarnFelFireball:Show()
	--	specWarnFelFireball:Play("kickcast")
	elseif spellId == 237308 then --Кольцо энергии Скверны
--		if cid == 126946 then
		specWarnFelNova:Show()
	--	specWarnFelNova:Play("watchstep")
	elseif spellId == 220267 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Ядовитая звезда
		specWarnPoisonNova:Show()
	--	specWarnPoisonNova:Play("kickcast")
	elseif spellId == 250963 then --Подавляющий шквал
		specWarnOverpoweringFlurry:Show()
	--	specWarnOverpoweringFlurry:Play("watchstep")
	elseif spellId == 251246 then --Жестокий мощный удар
		specWarnBrutishSlam:Show()
	--	specWarnBrutishSlam:Play("watchstep")
	elseif spellId == 251276 then --Раскалывающий натиск
		self:BossTargetScanner(args.sourceGUID, "SunderingCrashTarget", 0.1, 2)
	elseif spellId == 251265 then --Обратный поток Скверны
		specWarnFelBackdraft:Show()
	--	specWarnFelBackdraft:Play("kickcast")
	elseif spellId == 244623 then --Удар властителя преисподней
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if cid == 122999 then
			specWarnGlaiveBlast:Show()
		--	specWarnGlaiveBlast:Play("watchstep")
		end
	elseif spellId == 242397 then --Извержение Бездны
		self:BossTargetScanner(args.sourceGUID, "VoidExhaustTarget", 0.1, 2)
	elseif spellId == 242471 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Мрачная стрела
		specWarnDarkBolt:Show()
	--	specWarnDarkBolt:Play("kickcast")
	elseif spellId == 254079 then --Теневое сокрушение
		specWarnUmbralCrush:Show()
	--	specWarnUmbralCrush:Play("kickcast")
	elseif spellId == 254012 then --Аннигиляция
		specWarnAnnihilation:Show()
	--	specWarnAnnihilation:Play("watchstep")
	elseif spellId == 254026 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Жгучий гнев
		specWarnSearingWrath:Show()
	--	specWarnSearingWrath:Play("kickcast")
	elseif spellId == 253978 then --Вихрь клинков
		specWarnBladestorm:Show()
	--	specWarnBladestorm:Play("kickcast")
	elseif spellId == 249879 then --Вихрь клинков
		specWarnBlisteringWave:Show()
	--	specWarnBlisteringWave:Play("kickcast")
	elseif spellId == 254168 then --Сотрясающий топот
		specWarnSeismicStomp:Show()
	--	specWarnSeismicStomp:Play("watchstep")
	elseif spellId == 254163 then --Железный рывок
		self:BossTargetScanner(args.sourceGUID, "IronChargeTarget", 0.1, 2)
	elseif spellId == 222900 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Устрашающий рев
		specWarnIntimidatingRoar:Show()
	--	specWarnIntimidatingRoar:Play("kickcast")
	elseif spellId == 253563 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Звезда рока
		specWarnDoomStar:Show()
	--	specWarnDoomStar:Play("kickcast")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 252055 then --Внезапный удар
		specWarnAmbush:Show()
	--	specWarnAmbush:Play("watchstep")
	elseif spellId == 223421 then --Хаотический взрыв Скверны
		specWarnChaoticFelburst:Show()
	--	specWarnChaoticFelburst:Play("watchstep")
	elseif spellId == 242071 then --Бесы!
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if cid == 126040 then
			specWarnImps:Show()
		--	specWarnImps:Play("mobkill")
		end
	elseif spellId == 203109 then --Темное кровопускание
		specWarnShadowRend:Show()
	--	specWarnShadowRend:Play("watchstep")
	elseif spellId == 254079 then --Теневое сокрушение
		specWarnUmbralCrush2:Show()
	--	specWarnUmbralCrush2:Play("mobkill")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 254106 then --Пламя хаоса
		if args:IsPlayer() then
			specWarnChaoticFlames2:Show()
		--	specWarnChaoticFlames2:Play("defensive")
		end
	elseif spellId == 254480 then --Зажигание
		warnIgnition:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnIgnition:Show()
		--	specWarnIgnition:Play("defensive")
			yellIgnition:Yell()
			yellIgnition2:Countdown(8, 3)
		end
	elseif spellId == 252037 then --Величественный рык
		local amount = args.amount or 1
		if amount >= 1 then
			warnMajesticRoar:Show(args.destName, amount)
		end
	elseif spellId == 252038 then --Слеза властителя
		if args:IsPlayer() then
			specWarnSovereignsTear:Show()
		--	specWarnSovereignsTear:Play("defensive")
		end
	elseif spellId == 254015 then --Трещина в черепе
		warnHeadCrack:Show(args.destName)
	elseif spellId == 254268 then --Кровавый размах
		if args:IsPlayer() then
			specWarnBloodySwipe:Show()
		--	specWarnBloodySwipe:Play("defensive")
		end
	elseif spellId == 233228 then --Опаляющий размах
		if args:IsPlayer() then
			specWarnScorchingSwipe2:Show()
		--	specWarnScorchingSwipe2:Play("defensive")
		end
	elseif spellId == 254200 then --Темная волна
		if args:IsPlayer() then
			specWarnDarkSurge:Show()
		--	specWarnDarkSurge:Play("runaway")
			yellDarkSurge:Yell()
			yellDarkSurge2:Countdown(5, 3)
		elseif self:CheckNearby(10, args.destName) then
			specWarnDarkSurge2:Show()
		--	specWarnDarkSurge2:Play("watchstep")
		end
	elseif spellId == 222620 then --Удар Скверны
		if args:IsPlayer() then
			specWarnFelStrike:Show()
		--	specWarnFelStrike:Play("defensive")
		end
	elseif spellId == 252057 then --Удар Скверны
		if args:IsPlayer() and not self:IsMagicDispeller2() then
			specWarnCripplingBurst2:Show()
		--	specWarnCripplingBurst2:Play("targetyou")
		elseif args:IsPlayer() and self:IsMagicDispeller2() then
			specWarnCripplingBurst3:Show()
		--	specWarnCripplingBurst3:Play("dispelnow")
		end
	elseif spellId == 253068 then --Предсказание катастрофы
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if cid == 126199 or cid == 126946 or cid == 127096 then
			if args:IsPlayer() and not self:IsCurseDispeller() then
				specWarnProphecyofCalamity:Show()
			--	specWarnProphecyofCalamity:Play("defensive")
			elseif args:IsPlayer() and self:IsCurseDispeller() then
				specWarnProphecyofCalamity2:Show()
			--	specWarnProphecyofCalamity2:Play("dispelnow")
			end
		end
	elseif spellId == 218121 then --Исступление
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if cid == 126164 or cid == 126196 or cid == 127090 then
			warnEnrage:Show(args.destName)
		end
	elseif spellId == 183270 then --Губительный рев
		local amount = args.amount or 1
		if args:IsPlayer() then
			if amount >= 3 then
				specWarnWitheringRoar:Show(amount)
			--	specWarnWitheringRoar:Play("stackhigh")
			end
		end
	elseif spellId == 220267 then --Ядовитая звезда
		if args:IsPlayer() and self:IsPoisonDispeller() then
			specWarnPoisonNova2:Show()
		--	specWarnPoisonNova2:Play("dispelnow")
		end
	elseif spellId == 251245 then --Жуткое воодушевление
		warnDreadInspiration:Show(args.destName)
	elseif spellId == 246317 then --Подавляющий клинок
		local amount = args.amount or 1
		if amount >= 3 then
			if args:IsPlayer() then
				specWarnNegationBlade:Show(args.amount)
			--	specWarnNegationBlade:Play("stackhigh")
			end
		end
	elseif spellId == 253978 and not args:IsDestTypePlayer() then --Вихрь клинков
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if cid == 126852 then --Пастух Кравос
			specWarnBladestorm2:Show()
		--	specWarnBladestorm2:Play("watchstep")
		end
	elseif spellId == 238681 and not args:IsDestTypePlayer() then --Вихрь клинков
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if cid == 126338 then --Повелитель гнева Ярез
			specWarnBladestorm2:Show()
		--	specWarnBladestorm2:Play("watchstep")
		end
	elseif spellId == 254281 then --Отравленные клыки
		if args:IsPlayer() and self:IsPoisonDispeller() then
			specWarnVenomousFangs:Show()
		--	specWarnVenomousFangs:Play("dispelnow")
		end
	elseif spellId == 253545 then --Неизбежный рок
		if args:IsPlayer() then
			DBM:AddMsg(L.Tip1)
			specWarnEmpoweredDoom:Show()
		--	specWarnEmpoweredDoom:Play("targetyou")
			specWarnEmpoweredDoom2:Cancel()
			yellEmpoweredDoom:Cancel()
			specWarnEmpoweredDoom2:Schedule(25, doom)
		--	specWarnEmpoweredDoom2:ScheduleVoice(25, "runintofire")
			yellEmpoweredDoom:Countdown(30, 5)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 254200 then --Темная волна
		if args:IsPlayer() then
			specWarnDarkSurge3:Show()
		--	specWarnDarkSurge3:Play("watchstep")
		end
	elseif spellId == 253545 then --Неизбежный рок
		if args:IsPlayer() then
			specWarnEmpoweredDoom2:Cancel()
			yellEmpoweredDoom:Cancel()
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 222631 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then --Погребальный костер Хаоса
		specWarnChaosPyre:Show()
	--	specWarnChaosPyre:Play("runaway")
	elseif spellId == 250926 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then --Расколотая земля
		specWarnSunderedGround:Show()
	--	specWarnSunderedGround:Play("runaway")
	elseif spellId == 223292 and destGUID == UnitGUID("player") and self:AntiSpam(2, 3) then --Огненный ливень
		specWarnRainofFire:Show()
	--	specWarnRainofFire:Play("runaway")
	elseif spellId == 254218 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then --Склизкая лужа
		specWarnOozingPool:Show()
	--	specWarnOozingPool:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 127291 then --Смотритель Айвал+++
		timerChaosGlareCD:Cancel()
	elseif cid == 126912 then --Скрииг Пожиратель+++
		timerRavenousScreamCD:Cancel()
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if strmatch(msg, L.MurchalOchkenProshlyapen) then
		specWarnParaxisIncoming:Show()
	--	specWarnParaxisIncoming:Play("watchstep")
		timerParaxisIncomingCD:Start()
		countdownParaxisIncoming:Start()
	elseif strmatch(msg, L.MurchalOchkenProshlyapen2) then
		specWarnTheParaxis:Show(shield)
	--	specWarnTheParaxis:Play("findshield")
		timerParaxisIncomingCD:Cancel()
		countdownParaxisIncoming:Cancel()
	end
end

--[[
function mod:LOADING_SCREEN_DISABLED()
	if timerParaxisIncomingCD:GetTime() > 1 then
		timerParaxisIncomingCD:Cancel()
		countdownParaxisIncoming:Cancel()
	end
end]]
