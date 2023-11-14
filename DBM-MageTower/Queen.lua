local mod	= DBM:NewMod("Queen", "DBM-MageTower")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17745 $"):sub(12, -3))
mod:SetCreatureID(116484, 116499, 116496) --Сигрин, Ярл Вельбранд, Руновидец Фальяр
mod:SetEncounterID(2059)
mod:SetZone()
mod:SetBossHPInfoToHighest()

mod.soloChallenge = true
mod.onlyNormal = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 238694 237870 237947 237945 237857 237952",
	"SPELL_CAST_SUCCESS 237849 238432",
	"SPELL_AURA_APPLIED 36300 237945",
	"SPELL_AURA_APPLIED_DOSE 36300",
	"SPELL_AURA_REMOVED 237945 237949",
	"SPELL_PERIODIC_DAMAGE 238691",
	"SPELL_PERIODIC_MISSED 238691",
	"CHAT_MSG_MONSTER_SAY",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED"
)

--Прошляпанное очко Мурчаля Прошляпенко ✔ Ярость королевы-богини
--Сигрин
local warnGrowth				= mod:NewStackAnnounce(36300, 3) --Рост
local warnHurlAxe				= mod:NewSpellAnnounce(237870, 2, nil, false) --Бросок топора
local warnAdvance				= mod:NewSpellAnnounce(237849, 2) --Продвижение

--Сигрин
local specWarnThrowSpear		= mod:NewSpecialWarningDodge(238694, nil, nil, nil, 1, 2) --Бросок копья
local specWarnBloodFather		= mod:NewSpecialWarningTargetInt(237945, nil, nil, nil, 3, 5) --Кровь отца
local specWarnDarkWings			= mod:NewSpecialWarningDodge(237772, nil, nil, nil, 2, 2) --Темные крылья
local specWarnSpearofVengeance	= mod:NewSpecialWarningYouMove(238691, nil, nil, nil, 1, 2) --Копье отмщени
--Ярл Вельбранд
local specWarnBerserkersRage	= mod:NewSpecialWarningRun(237947, nil, nil, nil, 4, 3) --Ярость берсерка
local specWarnBladeStorm		= mod:NewSpecialWarningRun(237857, nil, nil, nil, 4, 3) --Вихрь клинков
--Руновидец Фальяр
local specWarnRunicDetonation	= mod:NewSpecialWarningSoak(237914, nil, nil, nil, 2, 3) --Руническая детонация
local specWarnKnowledge			= mod:NewSpecialWarningSwitch(237952, nil, nil, nil, 3, 3) --Знание предков

--Сигрин
local timerThrowSpearCD			= mod:NewCDTimer(13.4, 238694, nil, nil, nil, 3) --Бросок копья
--local timerAdvanceCD			= mod:NewCDTimer(13.4, 237849, nil, nil, nil, 2) --Продвижение
local timerBloodFatherCD		= mod:NewCDCountTimer(13.4, 237945, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Кровь отца
local timerBloodFather			= mod:NewCastTimer(27, 237945, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Кровь отца
local timerDarkWingsCD			= mod:NewCDTimer(20, 237772, nil, nil, nil, 3) --Темные крылья
--Ярл Вельбранд
local timerBerserkersRageCD		= mod:NewCDCountTimer(13.4, 237947, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Ярость берсерка
local timerBladeStormCD			= mod:NewCDCountTimer(13.4, 237857, nil, nil, nil, 2) --Вихрь клинков
--Руновидец Фальяр
local timerRunicDetonationCD	= mod:NewCDCountTimer(13.4, 237914, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Руническая детонация
local timerKnowledgeCD			= mod:NewCDCountTimer(13.4, 237952, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Знание предков
--local timerKnowledge			= mod:NewCastTimer(20, 237952, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Знание предков

local countdownBloodFather		= mod:NewCountdown(15, 237945, nil, nil, 5) --Кровь отца
local countdownBerserkersRage	= mod:NewCountdown(15, 237947, nil, nil, 5) --Ярость берсерка
local countdownKnowledge		= mod:NewCountdown(15, 237952, nil, nil, 5) --Знание предков
local countdownKnowledge2		= mod:NewCountdownFades("Alt20", 237952, nil, nil, 5) --Знание предков

local berserkerRageTimers = {31.0, 175.0}
local bloodFatherTimers = {65.0, 70.0, 100.0}
local knowledgeTimers = {101, 69.2, 118.4, 66.3, 26.7, 27.1, 27.5}
local bladeStormTimers = {110.0, 105.0, 30.0}
--local bloodFatherTimers = {65, 120.0, 120.0, 120.0, 120.0} --Кровь отца (которые были раньше)

mod.vb.bloodCount = 0
mod.vb.detonationCount = 0
mod.vb.berserkerCount = 0
mod.vb.bladeCount = 0
mod.vb.knowledgeCast = 0

function mod:OnCombatStart(delay)
	self.vb.bloodCount = 0
	self.vb.detonationCount = 0
	self.vb.berserkerCount = 0
	self.vb.bladeCount = 0
	self.vb.knowledgeCast = 0
--	timerThrowSpearCD:Start(14.4)
	--timerAdvanceCD:Start(20.5)
	timerBerserkersRageCD:Start(31, 1) --Ярость берсерка+++
	countdownBerserkersRage:Start(31) --Ярость берсерка+++
	--
	timerBloodFatherCD:Start(65, 1) --Кровь отца+++
	countdownBloodFather:Start(65) --Кровь отца+++
	--
	timerKnowledgeCD:Start(101, 1) --Знание предков
	countdownKnowledge:Start(101) --Знание предков
	--
	timerRunicDetonationCD:Start(41, 1) --Руническая детонация+++
	timerBladeStormCD:Start(110, 1)
--	timerDarkWingsCD:Start(146)
	DBM:AddMsg("Есть вероятность, что спеллы \"Ярость берсерка\", \"Знание предков\" и \"Кровь отца\" после 1-го применения будут происходить с большой задержкой - необходимо чтоб разрабы чинили свои кривые тайминги. Если это произошло (или нет) просьба связаться с автором аддона.")
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 238694 then
		specWarnThrowSpear:Show()
	--	specWarnThrowSpear:Play("watchstep")
		timerThrowSpearCD:Start()
	elseif spellId == 237870 then
		warnHurlAxe:Show()
	elseif spellId == 237947 then --Ярость берсерка
		self.vb.berserkerCount = self.vb.berserkerCount + 1
		specWarnBerserkersRage:Show()
	--	specWarnBerserkersRage:Play("justrun")
		local timer = berserkerRageTimers[self.vb.berserkerCount+1]
		if timer then
			timerBerserkersRageCD:Start(timer, self.vb.berserkerCount+1)
			countdownBerserkersRage:Start(timer)
		end
	elseif spellId == 237945 then --Кровь отца
		self.vb.bloodCount = self.vb.bloodCount + 1
		specWarnBloodFather:Show(args.sourceName)
	--	specWarnBloodFather:Play("crowdcontrol")
		local timer = bloodFatherTimers[self.vb.bloodCount+1]
		if timer then
			timerBloodFatherCD:Start(timer, self.vb.bloodCount+1)
			countdownBloodFather:Start(timer)
		end
	elseif spellId == 237857 then --Вихрь клинков
		self.vb.bladeCount = self.vb.bladeCount + 1
		specWarnBladeStorm:Show()
	--	specWarnBladeStorm:Play("justrun")
		local timer = bladeStormTimers[self.vb.bladeCount+1]
		if timer then
			timerBladeStormCD:Start(timer, self.vb.bladeCount+1)
		end
	elseif spellId == 237952 then --Знание предков
		self.vb.knowledgeCast = self.vb.knowledgeCast + 1
		specWarnKnowledge:Show()
	--	specWarnKnowledge:Play("targetchange")
		local timer = knowledgeTimers[self.vb.knowledgeCast+1] or 25
		if timer then
			timerKnowledgeCD:Start(timer, self.vb.knowledgeCast+1)
			countdownKnowledge:Start(timer)
		end
	--	timerKnowledge:Start()
		countdownKnowledge2:Start()
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
	elseif spellId == 237949 then --Знание предков
	--	timerKnowledge:Cancel()
		countdownKnowledge2:Cancel()
	end
end

function mod:UNIT_DIED(args)
	if args.destGUID == UnitGUID("player") then
		DBM:EndCombat(self, true)
	end
end

function mod:CHAT_MSG_MONSTER_SAY(msg)
	if msg == L.MurchalProshlyapRP then
		DBM:EndCombat(self)
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:find("spell:237761") then --Темные крылья
		specWarnDarkWings:Show()
	--	specWarnDarkWings:Play("stilldanger")
		timerDarkWingsCD:Start() -- подправить таймер
	elseif msg:find("spell:237908") then --Руническая детонация
		self.vb.detonationCount = self.vb.detonationCount + 1
		specWarnRunicDetonation:Show()
	--	specWarnRunicDetonation:Play("157060")
		timerRunicDetonationCD:Start(30, self.vb.detonationCount+1)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 238691 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnSpearofVengeance:Show()
	--	specWarnSpearofVengeance:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
