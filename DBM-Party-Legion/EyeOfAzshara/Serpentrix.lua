local mod	= DBM:NewMod(1479, "DBM-Party-Legion", 3, 716)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(91808)
mod:SetEncounterID(1813)
mod:SetZone(1456)
mod:SetUsedIcons(7)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED 191855 191797",
	"SPELL_AURA_REMOVED 191855"
)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 192003 192005 191848 192050",
	"SPELL_CAST_SUCCESS 191855",
	"SPELL_DAMAGE 191858",
	"SPELL_MISSED 191858",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_HEALTH boss1"
)

--Змеикс https://ru.wowhead.com/npc=91808/змеикс
local warnSubmerge					= mod:NewSoonAnnounce(191873, 1) --Погружение
local warnToxicWound				= mod:NewTargetAnnounce(191855, 2) --Отравленная рана
local warnWinds						= mod:NewSpellAnnounce(191798, 2) --Жестокие ветра
local warnRampage					= mod:NewSpellAnnounce(191848, 2) --Буйство

local specWarnPoisonSpit			= mod:NewSpecialWarningDodge(192050, nil, nil, nil, 2, 3) --Ядовитый плевок
local specWarnToxicWound			= mod:NewSpecialWarningYouRun(191855, nil, nil, nil, 4, 3) --Отравленная рана
local specWarnToxicWound2			= mod:NewSpecialWarningEnd(191855, nil, nil, nil, 1, 2) --Отравленная рана
local specWarnToxicWound3			= mod:NewSpecialWarningCloseMoveAway(191855, nil, nil, nil, 1, 2) --Отравленная рана
local specWarnSubmerge				= mod:NewSpecialWarningSwitch(191873, nil, nil, nil, 1, 2) --Погружение
local specWarnToxicPool				= mod:NewSpecialWarningYouMove(191858, nil, nil, nil, 1, 2) --Ядовитая лужа
local specWarnBlazingNova			= mod:NewSpecialWarningInterrupt(192003, "HasInterrupt", nil, nil, 1, 2) --Вспышка пламени
local specWarnArcaneBlast			= mod:NewSpecialWarningInterrupt(192005, "HasInterrupt", nil, nil, 1, 2) --Чародейская вспышка
local specWarnRampage				= mod:NewSpecialWarningInterrupt(191848, "HasInterrupt", nil, nil, 3, 5) --Буйство

local yellToxicWound				= mod:NewYell(191855, nil, nil, nil, "YELL") --Отравленная рана
local yellToxicWound2				= mod:NewFadesYell(191855, nil, nil, nil, "YELL") --Отравленная рана

--Next timers always, unless rampage is not interrupted (Boss will not cast anything else during rampages)
local timerToxicWound				= mod:NewTargetTimer(6, 191855, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Отравленная рана+++
local timerToxicWoundCD				= mod:NewCDTimer(16, 191855, nil, nil, nil, 7) --Отравленная рана
local timerWindsCD					= mod:NewNextTimer(30, 191798, nil, nil, nil, 2) --Жестокие ветра

mod:AddSetIconOption("SetIconOnToxicWound", 191855, true, false, {7}) --Отравленная рана

local wrathMod

function mod:UpdateWinds()
	timerWindsCD:Stop()
end

mod.vb.phase = 1
local warned_preP1 = false
local warned_preP2 = false
local warned_preP3 = false
local warned_preP4 = false

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	warned_preP1 = false
	warned_preP2 = false
	warned_preP3 = false
	warned_preP4 = false
	timerToxicWoundCD:Start(6-delay)
	timerWindsCD:Stop()
	timerWindsCD:Start(33-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 191855 then --Отравленная рана
		warnToxicWound:Show(args.destName)
		timerToxicWound:Start(args.destName)
		if args:IsPlayer() then
			specWarnToxicWound:Show()
			specWarnToxicWound:Play("justrun")
			specWarnToxicWound:ScheduleVoice(1.5, "keepmove")
			yellToxicWound:Yell()
			yellToxicWound2:Countdown(6, 3)
		elseif self:CheckNearby(10, args.destName) then
			specWarnToxicWound3:Show(args.destName)
			specWarnToxicWound3:Play("runaway")
		end
		if self.Options.SetIconOnToxicWound then
			self:SetIcon(args.destName, 7)
		end
	elseif spellId == 191797 and self:AntiSpam(3, 2) then--Violent Winds
		if not wrathMod then wrathMod = DBM:GetModByName("1492") end
		if wrathMod.vb.phase == 2 then return end--Phase 2 against Wrath of Azshara, which means this is happening every 10 seconds
		warnWinds:Show()
		if self:IsInCombat() then--Boss engaged it's 30
			timerWindsCD:Start()
		else--Zone wide, it's every 90 seconds
			timerWindsCD:Start(90)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 191855 then --Отравленная рана
		timerToxicWound:Cancel(args.destName)
		if args:IsPlayer() then
			specWarnToxicWound2:Show()
			yellToxicWound2:Cancel()
		end
		if self.Options.SetIconOnToxicWound then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 192003 and self:CheckInterruptFilter(args.sourceGUID, false, true) then--Blazing Nova
		specWarnBlazingNova:Show()
		specWarnBlazingNova:Play("kickcast")
	elseif spellId == 192005 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnArcaneBlast:Show()
		specWarnArcaneBlast:Play("kickcast")
	elseif spellId == 191848 then --Буйство
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnRampage:Show()
			specWarnRampage:Play("kickcast")
		else
			warnRampage:Show()
			warnRampage:Play("kickcast")
		end
	elseif spellId == 192050 then --Ядовитый плевок
		if not UnitIsDeadOrGhost("player") then
			specWarnPoisonSpit:Show()
			specWarnPoisonSpit:Play("watchstep")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 191855 then
		timerToxicWoundCD:Start()
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 191858 and destGUID == UnitGUID("player") and self:AntiSpam(2.5, 1) then
		if not self:IsNormal() then
			specWarnToxicPool:Show()
			specWarnToxicPool:Play("runaway")
		end
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:find("spell:191873") then
		if not UnitIsDeadOrGhost("player") then
			specWarnSubmerge:Show()
			specWarnSubmerge:Play("phasechange")
		end
		timerToxicWoundCD:Cancel()
	end
end

function mod:UNIT_HEALTH(uId)
	if self:IsHard() then --миф и миф+
		if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 91808 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.73 then --68%
			warned_preP1 = true
			warnSubmerge:Show()
		elseif self.vb.phase == 1 and warned_preP1 and not warned_preP2 and self:GetUnitCreatureId(uId) == 91808 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.68 then --Погружение
			self.vb.phase = 2
			warned_preP2 = true
		elseif self.vb.phase == 2 and warned_preP2 and not warned_preP3 and self:GetUnitCreatureId(uId) == 91808 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.39 then --34%
			warned_preP3 = true
			warnSubmerge:Show()
		elseif self.vb.phase == 2 and warned_preP3 and not warned_preP4 and self:GetUnitCreatureId(uId) == 91808 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.34 then
			self.vb.phase = 3
			warned_preP4 = true
		end
	else
		if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 91808 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.73 then --68%
			warned_preP1 = true
		elseif self.vb.phase == 1 and warned_preP1 and not warned_preP2 and self:GetUnitCreatureId(uId) == 91808 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.68 then --Погружение
			self.vb.phase = 2
			warned_preP2 = true
		elseif self.vb.phase == 2 and warned_preP2 and not warned_preP3 and self:GetUnitCreatureId(uId) == 91808 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.39 then --34%
			warned_preP3 = true
		elseif self.vb.phase == 2 and warned_preP3 and not warned_preP4 and self:GetUnitCreatureId(uId) == 91808 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.34 then
			self.vb.phase = 3
			warned_preP4 = true
		end
	end
end
