local mod	= DBM:NewMod("RareEnemies3", "DBM-BrokenIsles", nil, 822)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetZone()
mod:SetMinSyncRevision(17650)

mod.noStatistics = true
mod.isTrashMod = true

--Тут будут новые прошляпы от Мурчаля

mod:RegisterEvents(
	"SPELL_CAST_START 254099 254106 254044 254046 251302 251317 241917 254477",
	"SPELL_CAST_SUCCESS 252055",
	"SPELL_AURA_APPLIED 254106 254480 252037 252038",
	"SPELL_AURA_APPLIED_DOSE 252037",
--	"SPELL_AURA_REMOVED ",
--	"SPELL_PERIODIC_DAMAGE ",
--	"SPELL_PERIODIC_MISSED ",
	"UNIT_DIED"
)

--прошляпанное очко Мурчаля Прошляпенко ✔✔✔

local warnIgnition					= mod:NewTargetAnnounce(254480, 2) --Зажигание
local warnMajesticRoar				= mod:NewStackAnnounce(252037, 3) --Величественный рык
-----------
--Мак'ари--
-----------
--Соролис Нелюбимец Судьбы
local specWarnDarkRift				= mod:NewSpecialWarning("Proshlyap", nil, nil, nil, 1, 2) --Разлом Тьмы
--local specWarnDarkRift				= mod:NewSpecialWarningInterrupt2(254099, nil, nil, nil, 1, 2) --Разлом Тьмы
local specWarnChaoticFlames			= mod:NewSpecialWarning("Proshlyap", nil, nil, nil, 1, 2) --Пламя хаоса
--local specWarnChaoticFlames			= mod:NewSpecialWarningInterrupt(254106, "HasInterrupt", nil, nil, 1, 2) --Пламя хаоса
local specWarnChaoticFlames2		= mod:NewSpecialWarningYou(254106, nil, nil, nil, 2, 3) --Пламя хаоса
--Ядовитый небесный скат
local specWarnShatteringScreech		= mod:NewSpecialWarning("Proshlyap", nil, nil, nil, 1, 2) --Сокрушающий визг
--local specWarnShatteringScreech			= mod:NewSpecialWarningInterrupt(254044, "HasInterrupt", nil, nil, 1, 2) --Сокрушающий визг
local specWarnDarkTorrent			= mod:NewSpecialWarning("Proshlyap", nil, nil, nil, 1, 2) --Темный поток
--local specWarnDarkTorrent				= mod:NewSpecialWarningInterrupt2(254046, nil, nil, nil, 2, 2) --Темный поток

--Турек Мерцающий https://www.wowhead.com/ru/npc=126868/турек-мерцающий
--Вестник хаоса https://www.wowhead.com/ru/npc=126896/вестник-хаоса
--Каара Бледная https://www.wowhead.com/ru/npc=126860/каара-бледная
--Слизон Последний из Змеев https://www.wowhead.com/ru/npc=126913/слизон-последний-из-змеев
--Пастух Кравос https://www.wowhead.com/ru/npc=126852/пастух-кравос
--Темный чародей Воруун https://www.wowhead.com/ru/npc=122838/темный-чародей-воруун
--Баруут Кровожадный https://www.wowhead.com/ru/npc=126862/баруут-кровожадный
--Инструктор Тарахна https://www.wowhead.com/ru/npc=126900/инструктор-тарахна
--Чемпион джед'хин Воруск https://www.wowhead.com/ru/npc=126899/чемпион-джедхин-воруск
--Командир Ксетгар https://www.wowhead.com/ru/npc=126910/командир-ксетгар
--Скрииг Пожиратель https://www.wowhead.com/ru/npc=126912/скрииг-пожиратель
--Капитан Фарук https://www.wowhead.com/ru/npc=126869/капитан-фарук
--Дозорный Куро https://www.wowhead.com/ru/npc=126866/дозорный-куро
--Дозорный Танос https://www.wowhead.com/ru/npc=126865/дозорный-танос
--Зул'тан Многоликий https://www.wowhead.com/ru/npc=126908/зултан-многоликий
--Надзирательница И'Беда https://www.wowhead.com/ru/npc=124440/надзирательница-ибеда
--Надзирательница И'cорна https://www.wowhead.com/ru/npc=125497/надзирательница-иcорна
--Надзирательница И'Морна https://www.wowhead.com/ru/npc=125498/надзирательница-иморна
--Физл Кексовор https://www.wowhead.com/ru/npc=126864/физл-кексовор
--Искаженное чудовище https://www.wowhead.com/ru/npc=126815/искаженное-чудовище
--Сабуул https://www.wowhead.com/ru/npc=126898/сабуул
--Мраколиск https://www.wowhead.com/ru/npc=126885/мраколиск
--Атаксон https://www.wowhead.com/ru/npc=126887/атаксон
--------------------
--Пустоши Анторуса--
--------------------
--Главный алхимик Мункул
local specWarnThrowFelflameImp			= mod:NewSpecialWarning("Proshlyap", nil, nil, nil, 1, 2) --Бросок беса пламени Скверны
--local specWarnThrowFelflameImp			= mod:NewSpecialWarningYouMoveAway(241917, nil, nil, nil, 2, 3) --Бросок беса пламени Скверны
local specWarnThrowFelflameImp2			= mod:NewSpecialWarningCloseMoveAway(241917, nil, nil, nil, 2, 3) --Бросок беса пламени Скверны
--Вечнопылающий вестник ужаса
local specWarnBlisteringFel			= mod:NewSpecialWarning("Proshlyap", nil, nil, nil, 1, 2) --Жгучая Скверна
--local specWarnBlisteringFel			= mod:NewSpecialWarningDodge(254477, nil, nil, nil, 2, 3) --Жгучая Скверна
local specWarnBlisteringFel2		= mod:NewSpecialWarningCloseMoveAway(254477, nil, nil, nil, 2, 3) --Жгучая Скверна
local specWarnIgnition				= mod:NewSpecialWarningYouMoveAway(254480, nil, nil, nil, 4, 3) --Зажигание
--Провидец Ксанариан https://www.wowhead.com/ru/npc=127096/провидец-ксанариан
--Лейтенант Закаар https://www.wowhead.com/ru/npc=126254/лейтенант-закаар
--Язвоглот https://www.wowhead.com/ru/npc=122958/язвоглот
--Госпожа Ил'тендра https://www.wowhead.com/ru/npc=122947/госпожа-илтендра
--Смотритель Айвал https://www.wowhead.com/ru/npc=127291/смотритель-айвал
--Повелитель гнева Ярез https://www.wowhead.com/ru/npc=126338/повелитель-гнева-ярез
--Яд'орн https://www.wowhead.com/ru/npc=126115/ядорн
--Варга https://www.wowhead.com/ru/npc=126208/варга
--Инквизитор Ветроз https://www.wowhead.com/ru/npc=126946/инквизитор-ветроз
--Гар'зот https://www.wowhead.com/ru/npc=122999/гарзот
--Терек Подборщик https://www.wowhead.com/ru/npc=124804/терек-подборщик
--Миродробитель Скуул https://www.wowhead.com/ru/npc=127118/миродробитель-скуул
--Вракс'тул https://www.wowhead.com/ru/npc=126199/вракстул
--Хранительница Бездны Валсурана https://www.wowhead.com/ru/npc=127300/хранительница-бездны-валсурана
--Пузцилла https://www.wowhead.com/ru/npc=126040/пузцилла
--Псарь Керракс https://www.wowhead.com/ru/npc=127288/псарь-керракс
--Командир Текслаз https://www.wowhead.com/ru/npc=127084/командир-текслаз
--Адмирал Рел'вар https://www.wowhead.com/ru/npc=127090/адмирал-релвар
--Хадрокс https://www.wowhead.com/ru/npc=127670/хадрокс
--Радикс https://www.wowhead.com/ru/npc=127671/радикс
-----------
--Крокуун--
-----------
--Нароу https://www.wowhead.com/ru/npc=126419/нароу
local specWarnSovereignsTear			= mod:NewSpecialWarning("Proshlyap", nil, nil, nil, 1, 2) --Слеза властителя
--local specWarnSovereignsTear			= mod:NewSpecialWarningYou(252038, nil, nil, nil, 1, 3) --Слеза властителя
local specWarnAmbush					= mod:NewSpecialWarningDodge(252055, nil, nil, nil, 2, 3) --Внезапный удар
--Командир Сатренаэль
local specWarnColossalBlowback			= mod:NewSpecialWarning("Proshlyap", nil, nil, nil, 1, 2) --Мощнейший удар с размаха
--local specWarnColossalBlowback			= mod:NewSpecialWarningDodge(251302, nil, nil, nil, 2, 3) --Мощнейший удар с размаха
local specWarnColossalBlowback2			= mod:NewSpecialWarningCloseMoveAway(251302, nil, nil, nil, 2, 3) --Мощнейший удар с размаха
local specWarnImperiousBeam				= mod:NewSpecialWarning("Proshlyap", nil, nil, nil, 1, 2) --Деспотический луч
--local specWarnImperiousBeam				= mod:NewSpecialWarningInterrupt2(251317, nil, nil, nil, 2, 2) --Деспотический луч
--Талестра Злобная https://www.wowhead.com/ru/npc=123689/талестра-злобная
--Осадный мастер Вораан https://www.wowhead.com/ru/npc=120393/осадный-мастер-вораан
--Сестра Диверсия https://www.wowhead.com/ru/npc=123464/сестра-диверсия
--Командир Эндаксий https://www.wowhead.com/ru/npc=124775/командир-эндаксий
--Командир Викайя https://www.wowhead.com/ru/npc=122911/командир-викайя
--Вагат Обманутый https://www.wowhead.com/ru/npc=125388/вагат-обманутый
--Казадуум https://www.wowhead.com/ru/npc=125824/казадуум
--Мать бесов Леглата https://www.wowhead.com/ru/npc=125820/мать-бесов-леглата
--Смолоплюй https://www.wowhead.com/ru/npc=125479/смолоплюй

local yellIgnition						= mod:NewYell(254480, nil, nil, nil, "YELL") --Зажигание
local yellIgnition2						= mod:NewFadesYell(254480, nil, nil, nil, "YELL") --Зажигание

function mod:ColossalBlowbackTarget(targetname, uId) --прошляпанное очко Мурчаля Прошляпенко ✔
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnColossalBlowback:Show()
		specWarnColossalBlowback:Play("watchstep")
	else
		specWarnThrowFelflameImp2:Show(targetname)
		specWarnThrowFelflameImp2:Play("watchstep")
	end
end

function mod:ThrowFelflameImpTarget(targetname, uId) --прошляпанное очко Мурчаля Прошляпенко ✔
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnThrowFelflameImp:Show()
		specWarnThrowFelflameImp:Play("runaway")
	else
		specWarnColossalBlowback2:Show(targetname)
		specWarnColossalBlowback2:Play("watchstep")
	end
end

function mod:BlisteringFelTarget(targetname, uId) --прошляпанное очко Мурчаля Прошляпенко ✔
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnBlisteringFel:Show()
		specWarnBlisteringFel:Play("runaway")
	else
		specWarnBlisteringFel2:Show(targetname)
		specWarnBlisteringFel2:Play("watchstep")
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 254099 then --Разлом Тьмы
		specWarnDarkRift:Show()
		specWarnDarkRift:Play("kickcast")
	elseif spellId == 254106 then --Пламя хаоса
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnChaoticFlames:Show()
			specWarnChaoticFlames:Play("kickcast")
		end
	elseif spellId == 254044 then --Сокрушающий визг
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnShatteringScreech:Show()
			specWarnShatteringScreech:Play("kickcast")
		end
	elseif spellId == 254046 then --Темный поток
		specWarnDarkTorrent:Show()
		specWarnDarkTorrent:Play("kickcast")
	elseif spellId == 251302 then --Мощнейший удар с размаха
		self:BossTargetScanner(args.sourceGUID, "ColossalBlowbackTarget", 0.1, 2)
	elseif spellId == 251317 then --Деспотический луч
		specWarnImperiousBeam:Show()
		specWarnImperiousBeam:Play("kickcast")
	elseif spellId == 241917 then --Бросок беса пламени Скверны
		self:BossTargetScanner(args.sourceGUID, "ThrowFelflameImpTarget", 0.1, 2)
	elseif spellId == 254477 then --Жгучая Скверна
		self:BossTargetScanner(args.sourceGUID, "BlisteringFelTarget", 0.1, 2)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 252055 then --Внезапный удар
		specWarnAmbush:Show()
		specWarnAmbush:Play("watchstep")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 254106 then --Пламя хаоса
		if args:IsPlayer() then
			specWarnChaoticFlames2:Show()
			specWarnChaoticFlames2:Play("defensive")
		end
	elseif spellId == 254480 then --Зажигание
		warnIgnition:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnIgnition:Show()
			specWarnIgnition:Play("defensive")
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
			specWarnSovereignsTear:Play("defensive")
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
