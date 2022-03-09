local mod	= DBM:NewMod("RareEnemies", "DBM-BrokenIsles", nil, 822)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
--mod:SetCreatureID(103975, 99899, 102303)
--mod:SetEncounterID(1951)
--mod:SetReCombatTime(20)
mod:SetZone()
mod:SetMinSyncRevision(17622)

--mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START 221424 222676 189157 214095 218245 218250 217527 213585 206794 223101 223104 220197",
	"SPELL_CAST_SUCCESS 221422 214183 223094",
	"SPELL_AURA_APPLIED 221422 221425 222676 218250 223094",
	"SPELL_AURA_APPLIED_DOSE 221425",
	"SPELL_AURA_REMOVED 221422",
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warnCrushArmor			= mod:NewStackAnnounce(221425, 1) --Сокрушение доспеха
local warnImpale				= mod:NewTargetAnnounce(222676, 4) --Прокалывание
local warnArcticTorrent			= mod:NewTargetAnnounce(218245, 4) --Арктический поток
local warnWebWrap				= mod:NewTargetAnnounce(223094, 3) --Кокон

local specWarnArcticSlam		= mod:NewSpecialWarningRun(220197, "Melee", nil, nil, 4, 5) --Арктический мощный удар
local specWarnArcticSlam2		= mod:NewSpecialWarningDodge(220197, "Ranged", nil, nil, 2, 5) --Арктический мощный удар
local specWarnWebWrap			= mod:NewSpecialWarningSwitch(223094, "-Healer", nil, nil, 3, 2) --Кокон
local specWarnFertilize			= mod:NewSpecialWarningInterrupt(223104, "HasInterrupt2", nil, nil, 3, 2) --Удобрение
local specWarnEnchantedVenom	= mod:NewSpecialWarningInterrupt(223101, nil, nil, nil, 1, 2) --Зачарованный яд
local specWarnNova				= mod:NewSpecialWarningRun(206794, "Melee", nil, nil, 4, 5) --Новая
local specWarnNova2				= mod:NewSpecialWarningDodge(206794, "Ranged", nil, nil, 2, 3) --Новая
local specWarnCorruptionBarrage = mod:NewSpecialWarningDodge(213585, nil, nil, nil, 2, 3) --Обстрел порчей
local specWarnOverflowingTaint 	= mod:NewSpecialWarningDodge(217527, nil, nil, nil, 2, 3) --Переполняющая порча
local specWarnVortex			= mod:NewSpecialWarningInterrupt(214183, nil, nil, nil, 3, 5) --Воронка
local specWarnDeathWail			= mod:NewSpecialWarningRun(189157, "Melee", nil, nil, 4, 5) --Вой смерти
local specWarnArcticTorrent		= mod:NewSpecialWarningDodge(218245, nil, nil, nil, 2, 3) --Арктический поток
local specWarnDeathWail2		= mod:NewSpecialWarningDodge(189157, "Ranged", nil, nil, 2, 3) --Вой смерти
local specWarnFlrglDrglDrglGrgl2 = mod:NewSpecialWarningDodge(218250, nil, nil, nil, 2, 3) --Флргл Дргл Дргл Гргл
local specWarnBladeBarrage		= mod:NewSpecialWarningDodge(222596, "Ranged", nil, nil, 2, 3) --Залп клинков
local specWarnBladeBarrage2		= mod:NewSpecialWarningRun(222596, "Melee", nil, nil, 4, 5) --Залп клинков
local specWarnFlrglDrglDrglGrgl	= mod:NewSpecialWarningInterrupt(218250, "-Healer", nil, nil, 3, 5) --Флргл Дргл Дргл Гргл
local specWarnFear				= mod:NewSpecialWarningInterrupt(221424, "-Healer", nil, nil, 3, 5) --Страх
local specWarnArcaneResonance	= mod:NewSpecialWarningInterrupt2(214095, "HasInterrupt2", nil, nil, 3, 5) --Резонанс
local specWarnImpale			= mod:NewSpecialWarningInterrupt(222676, "-Healer", nil, nil, 3, 5) --Прокалывание
local specWarnViciousBite		= mod:NewSpecialWarningYouDefensive(221422, nil, nil, nil, 2, 5) --Яростный укус
local specWarnCrushArmor		= mod:NewSpecialWarningStack(221425, nil, 3, nil, nil, 3, 5) --Сокрушение доспеха

local timerArcticSlamCD			= mod:NewCDTimer(20, 220197, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Арктический мощный удар
local timerWebWrapCD			= mod:NewCDTimer(22, 223094, nil, nil, nil, 3, nil, DBM_CORE_DAMAGE_ICON) --Кокон
local timerFertilizeCD			= mod:NewCDTimer(22, 223104, nil, nil, nil, 3, nil, DBM_CORE_DAMAGE_ICON) --Удобрение
local timerOverflowingTaintCD	= mod:NewCDTimer(15, 217527, nil, nil, nil, 3, nil) --Переполняющая порча
local timerViciousBite			= mod:NewTargetTimer(15, 221422, nil, nil, nil, 5, nil) --Яростный укус
local timerViciousBiteCD		= mod:NewCDTimer(30, 221422, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON) --Яростный укус
local timerCrushArmor			= mod:NewTargetTimer(20, 221425, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON) --Сокрушение доспеха
local timerBladeBarrageCD		= mod:NewCDTimer(30, 222596, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Залп клинков
local timerImpaleCD				= mod:NewCDTimer(20, 222676, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON) --Прокалывание
local timerArcticTorrentCD		= mod:NewCDTimer(35, 218245, nil, nil, nil, 3, nil) --Арктический поток
local timerFlrglDrglDrglGrglCD	= mod:NewCDTimer(18, 218250, nil, nil, nil, 2, nil) --Флргл Дргл Дргл Гргл

local yellWebWrap				= mod:NewYell(223094, nil, nil, nil, "YELL") --Кокон
local yellImpale				= mod:NewYell(222676, nil, nil, nil, "YELL") --Прокалывание
local yellArcticTorrent			= mod:NewYell(218245, nil, nil, nil, "YELL") --Арктический поток

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 221424 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Страх
		specWarnFear:Show()
	elseif spellId == 222676 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Прокалывание
		timerImpaleCD:Start()
		specWarnImpale:Show()
	elseif spellId == 189157 then --Вой смерти
		specWarnDeathWail:Show()
		specWarnDeathWail2:Show()
	elseif spellId == 214095 then --Резонанс
		specWarnArcaneResonance:Show()
	elseif spellId == 218245 then --Арктический поток
		local targetname = self:GetBossTarget(109648)
		if not targetname then return end
		warnArcticTorrent:Show(targetname)
		specWarnArcticTorrent:Show()
		if targetname == UnitName("player") then
			yellImpale:Yell()
		end
		timerArcticTorrentCD:Start()
		timerFlrglDrglDrglGrglCD:Start()
	elseif spellId == 218250 then --Флргл Дргл Дргл Гргл
		specWarnFlrglDrglDrglGrgl:Show()
	elseif spellId == 222596 then --Залп клинков
		specWarnBladeBarrage:Show()
		specWarnBladeBarrage2:Show()
		timerBladeBarrageCD:Start()
	elseif spellId == 217527 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Переполняющая порча
		specWarnOverflowingTaint:Show()
		timerOverflowingTaintCD:Start()
	elseif spellId == 213585 then --Обстрел порчей
		specWarnCorruptionBarrage:Show()
	elseif spellId == 206794 then --Новая
		specWarnNova:Show()
		specWarnNova2:Show()
	elseif spellId == 223101 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Обстрел порчей
		specWarnEnchantedVenom:Show()
	elseif spellId == 223104 then --Удобрение
		specWarnFertilize:Show()
		timerFertilizeCD:Start()
	elseif spellId == 220197 then --Арктический мощный удар
		specWarnArcticSlam:Show()
		specWarnArcticSlam2:Show()
		timerArcticSlamCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 221422 then --Яростный укус
		timerViciousBiteCD:Start()
	elseif spellId == 218250 then --Прокалывание
		specWarnFlrglDrglDrglGrgl2:Show()
	elseif spellId == 214183 then --Воронка
		specWarnVortex:Show()
	elseif spellId == 223094 then --Кокон
		timerWebWrapCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 221422 then --Яростный укус
		timerViciousBite:Start(args.destName)
		if args:IsPlayer() then
			specWarnViciousBite:Show()
		end
	elseif spellId == 221425 then --Сокрушение доспеха
		local amount = args.amount or 1
		warnCrushArmor:Show(args.destName, amount)
		timerCrushArmor:Start(args.destName)
		if amount >= 3 then
			if args:IsPlayer() then
				specWarnCrushArmor:Show(args.amount)
			end
		end
	elseif spellId == 222676 then --Прокалывание
		warnImpale:Show(args.destName)
		if args:IsPlayer() then
			yellImpale:Yell()
		end
	elseif spellId == 223094 then --Кокон
		warnWebWrap:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			yellWebWrap:Yell()
		else
			specWarnWebWrap:Show()
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

-- https://ru.wowhead.com/npc=101649/ледяной-осколок
-- https://ru.wowhead.com/npc=111454/бестрикс
-- https://ru.wowhead.com/npc=93654/скалвракс скалвракс
-- https://ru.wowhead.com/npc=103975/джейд-темная-гавань#abilities Джейд
-- https://ru.wowhead.com/npc=99899/яростная-китовая-акула акула
-- https://ru.wowhead.com/npc=102303/лейтенант-стратмар стратмар
