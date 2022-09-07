local mod	= DBM:NewMod("Queen", "DBM-MageTower")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(116484, 116499, 116496) --Сигрин, Ярл Вельбранд, Руновидец Фальяр
mod:SetEncounterID(2059)
mod:SetZone()
mod:SetBossHPInfoToHighest()
mod.soloChallenge = true
mod.onlyNormal = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 238694 237870 237947 237945 237857",
	"SPELL_CAST_SUCCESS 237849 238432",
	"SPELL_AURA_APPLIED 36300 237945",
	"SPELL_AURA_APPLIED_DOSE 36300",
	"SPELL_AURA_REMOVED 237945",
	"CHAT_MSG_MONSTER_SAY",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED"
)

--Прошляпанное очко Мурчаля ✔ Ярость королевы-богини
--Сигрин
local warnGrowth				= mod:NewStackAnnounce(36300, 3) --Рост
local warnHurlAxe				= mod:NewSpellAnnounce(237870, 2, nil, false) --Бросок топора
local warnAdvance				= mod:NewSpellAnnounce(237849, 2) --Продвижение

--Сигрин
local specWarnThrowSpear		= mod:NewSpecialWarningDodge(238694, nil, nil, nil, 1, 2) --Бросок копья
local specWarnBloodFather		= mod:NewSpecialWarningTargetInt(237945, nil, nil, nil, 3, 5) --Кровь отца
local specWarnDarkWings			= mod:NewSpecialWarningDodge(237772, nil, nil, nil, 2, 2) --Темные крылья
--Ярл Вельбранд
local specWarnBerserkersRage	= mod:NewSpecialWarningRun(237947, nil, nil, nil, 4, 2) --Ярость берсерка
local specWarnBladeStorm		= mod:NewSpecialWarningRun(237857, nil, nil, nil, 4, 2) --Вихрь клинков
--Руновидец Фальяр
local specWarnRunicDetonation	= mod:NewSpecialWarningSoak(237914, nil, nil, nil, 2, 3) --Руническая детонация
local specWarnKnowledge			= mod:NewSpecialWarningSwitch(237952, nil, nil, nil, 1, 2) --Знание предков

--Сигрин
local timerThrowSpearCD			= mod:NewCDTimer(13.4, 238694, nil, nil, nil, 3) --Бросок копья
--local timerAdvanceCD			= mod:NewCDTimer(13.4, 237849, nil, nil, nil, 2) --Продвижение
local timerBloodFatherCD		= mod:NewCDCountTimer(13.4, 237945, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Кровь отца
local timerBloodFather			= mod:NewCastTimer(27, 237945, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Кровь отца
local timerDarkWingsCD			= mod:NewCDTimer(20, 237772, nil, nil, nil, 3) --Темные крылья
--Ярл Вельбранд
local timerBerserkersRageCD		= mod:NewCDCountTimer(13.4, 237947, nil, nil, nil, 3) --Ярость берсерка
local timerBladeStormCD			= mod:NewCDCountTimer(13.4, 237857, nil, nil, nil, 2) --Вихрь клинков
--Руновидец Фальяр
local timerRunicDetonationCD	= mod:NewCDCountTimer(13.4, 237914, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Руническая детонация
local timerKnowledgeCD			= mod:NewCDCountTimer(13.4, 237952, nil, nil, nil, 3) --Знание предков

local countdownBloodFather		= mod:NewCountdown(13.4, 237945) --Кровь отца

local bladeStormTimers = {125.0, 105.0, 30.0}
local berserkerRageTimers = {26.0, 175.0}
local bloodFatherTimers = {89.5, 120.0, 120.0, 120.0, 120.0}
local ancestralKnowledgeTimers = {98.4, 69.2, 118.4, 66.3, 26.7, 27.1, 27.5}--Rest 25

local bloodCount = 0
local bladeCount = 0
local berserkerCount = 0
local runicDetonationCount = 0
local knowledgeCast = 0

function mod:OnCombatStart(delay)
	bloodCount = 0
	bladeCount = 0
	berserkerCount = 0
	runicDetonationCount = 0
	knowledgeCast = 0
--	timerThrowSpearCD:Start(14.4)
	--timerAdvanceCD:Start(20.5)
--	timerBerserkersRageCD:Start(26, 1)
	timerRunicDetonationCD:Start(38.5, 1) --Руническая детонация+++
	self:ScheduleMethod(38.5, "RunicDetonation")
	timerBloodFatherCD:Start(89.5, 1) --Кровь отца+++
	countdownBloodFather:Start(89.5) --Кровь отца+++
--	timerKnowledgeCD:Start(98, 1)
--	timerBladeStormCD:Start(125, 1)
--	timerDarkWingsCD:Start(146)
	DBM:AddMsg("Есть вероятность, что таймеры при начале боя будут включаться, если только вы сами ударите Сигрин. Не медлите и вступайте в бой скорее, от этого зависит их точность.")
end

function mod:OnCombatEnd()
	self:UnscheduleMethod("RunicDetonation")
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 238694 then
		specWarnThrowSpear:Show()
		specWarnThrowSpear:Play("watchstep")
		timerThrowSpearCD:Start()
	elseif spellId == 237870 then
		warnHurlAxe:Show()
	elseif spellId == 237947 then
		berserkerCount = berserkerCount + 1
		specWarnBerserkersRage:Show()
		specWarnBerserkersRage:Play("justrun")
		local timer = berserkerRageTimers[berserkerCount+1]
		if timer then
			timerBerserkersRageCD:Start(timer, berserkerCount+1)
		end
	elseif spellId == 237945 then
		bloodCount = bloodCount + 1
		specWarnBloodFather:Show(args.sourceName)
		specWarnBloodFather:Play("crowdcontrol")
		local timer = bloodFatherTimers[bloodCount+1]
		if timer then
			timerBloodFatherCD:Start(timer, bloodCount+1)
			countdownBloodFather:Start(timer)
		end
	elseif spellId == 237857 then
		bladeCount = bladeCount + 1
		specWarnBladeStorm:Show()
		specWarnBladeStorm:Play("justrun")
		local timer = bladeStormTimers[bladeCount+1]
		if timer then
			timerBladeStormCD:Start(timer, bladeCount+1)
		end
	elseif spellId == 237952 then
		knowledgeCast = knowledgeCast + 1
		specWarnKnowledge:Show()
		specWarnKnowledge:Play("targetchange")
		local timer = ancestralKnowledgeTimers[knowledgeCast+1] or 25
		if timer then
			timerBladeStormCD:Start(timer, knowledgeCast+1)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if (spellId == 237849 or spellId == 238432) and self:AntiSpam(5, 1) then
		warnAdvance:Show()
		--timerAdvanceCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 36300 then --Рост
		local amount = args.amount or 1
		if amount >= 1 then
			warnGrowth:Show(args.destName, amount)
		end
	elseif spellId == 237945 and not args:IsDestTypePlayer() then --Кровь отца
		timerBloodFather:Start()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 237945 then --Кровь отца
		timerBloodFather:Cancel()
	end
end

function mod:UNIT_DIED(args)
	if args.destGUID == UnitGUID("player") then
		DBM:EndCombat(self, true)
	end
end

function mod:CHAT_MSG_MONSTER_SAY(msg)
	if msg == L.SigrynRP1 then
		DBM:EndCombat(self)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 237772 then--Dark Wings
		specWarnDarkWings:Show()
		specWarnDarkWings:Play("stilldanger")
		timerDarkWingsCD:Start()
	end
end

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 237914 then--Runic Detonation
		runicDetonationCount = runicDetonationCount + 1
		specWarnRunicDetonation:Show(RUNES)
		specWarnRunicDetonation:Play("157060")
		timerRunicDetonationCD:Start()
	elseif spellId == 237772 then--Dark Wings
		specWarnDarkWings:Show()
		specWarnDarkWings:Play("stilldanger")
		timerDarkWingsCD:Start()
	end
end]]

function mod:RunicDetonation()
	runicDetonationCount = runicDetonationCount + 1
	specWarnRunicDetonation:Show()
	specWarnRunicDetonation:Play("157060")
	timerRunicDetonationCD:Start(30, runicDetonationCount+1)
	self:ScheduleMethod(30, "RunicDetonation")
end
