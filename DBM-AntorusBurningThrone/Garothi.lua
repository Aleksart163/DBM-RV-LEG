local mod	= DBM:NewMod(1992, "DBM-AntorusBurningThrone", nil, 946)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(122450)
mod:SetEncounterID(2076)
mod:SetZone()
--mod:SetBossHPInfoToHighest()
mod:SetUsedIcons(8, 6, 5, 4, 3, 2, 1)
mod:SetHotfixNoticeRev(16962)
mod:SetMinSyncRevision(16962)
mod:DisableIEEUCombatDetection()
mod.respawnTime = 29
mod:DisableRegenDetection()--Prevent false combat when fighting trash

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 244969 240277 246663",
	"SPELL_CAST_SUCCESS 246220 244399 245294 246919 244294 246663 244969",
	"SPELL_AURA_APPLIED 246220 244410 246919 246965",--246897
	"SPELL_AURA_REMOVED 246220 244410 246919",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3",--Assuming cannons are unique boss unitID
	"UNIT_HEALTH boss1"
)

local annihilator = DBM:EJ_GetSectionInfo(15917)
local Decimator = DBM:EJ_GetSectionInfo(15915)
--TODO, work in range frame to include searing barrage, for ranged
--[[
(ability.id = 244969 or ability.id = 240277) and type = "begincast"
 or (ability.id = 244399 or ability.id = 245294 or ability.id = 246919 or ability.id = 244294) and type = "cast"
 or (ability.id = 246220) and type = "applydebuff"
--]]
local warnFelBombardment				= mod:NewTargetAnnounce(246220, 3) --Обстрел скверны
local warnDecimation					= mod:NewTargetAnnounce(244410, 3) --Децимация
local warnPhase							= mod:NewPhaseChangeAnnounce(1)
local warnPrePhase2						= mod:NewPrePhaseAnnounce(2, 1)
local warnPrePhase3						= mod:NewPrePhaseAnnounce(3, 1)
local warnApocDrive						= mod:NewSpellAnnounce(244152, 3, nil, "Healer") --Реактор апокалипсиса

local specWarnFelBombardment			= mod:NewSpecialWarningYouMoveAway(246220, nil, nil, nil, 3, 5) --Обстрел скверны
local specWarnFelBombardment2			= mod:NewSpecialWarningYou(246220, nil, nil, nil, 1, 2) --Обстрел скверны
local specWarnFelBombardmentTaunt		= mod:NewSpecialWarningTaunt(246220, nil, nil, nil, 3, 5) --Обстрел скверны
local specWarnApocDrive					= mod:NewSpecialWarningSwitch(244152, "-Healer", nil, nil, 1, 2) --Реактор апокалипсиса
local specWarnEradication				= mod:NewSpecialWarningRun(244969, nil, nil, nil, 4, 6) --Искоренение
local specWarnEradication2				= mod:NewSpecialWarningDefensive(244969, nil, nil, nil, 3, 6) --Искоренение
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)
--Decimator
local specWarnDecimation				= mod:NewSpecialWarningYouMoveAway(244410, nil, nil, nil, 4, 5) --Децимация
local specWarnDecimation2				= mod:NewSpecialWarningDodge(244410, "-Tank", nil, nil, 2, 2) --Децимация

local specWarnSurgingFel				= mod:NewSpecialWarningDodge(246663, nil, nil, nil, 2, 2) --Всплеск скверны
--Annihilator
local specWarnAnnihilation				= mod:NewSpecialWarningSoak(244761, nil, nil, nil, 2, 5) --Аннигиляция

local timerFelBombardmentCD				= mod:NewNextTimer(20.7, 246220, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON) --Обстрел скверны
local timerApocDriveCast				= mod:NewCastTimer(30, 244152, nil, nil, nil, 6, nil, DBM_CORE_DEADLY_ICON) --Реактор апокалипсиса
local timerSurgingFelCD					= mod:NewCDTimer(6.5, 246663, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Всплеск скверны
local timerSurgingFelCast				= mod:NewCastTimer(4, 246663, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Всплеск скверны
local timerEradicationCast				= mod:NewCastTimer(6, 244969, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Искоренение
local timerSpecialCD					= mod:NewNextSpecialTimer(20) --Когда оружие неизвестно
mod:AddTimerLine(Decimator)
local timerDecimationCD					= mod:NewNextTimer(31.6, 244410, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON..DBM_CORE_MYTHIC_ICON) --Децимация
mod:AddTimerLine(annihilator)
local timerAnnihilationCD				= mod:NewNextTimer(31.6, 244761, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON..DBM_CORE_MYTHIC_ICON) --Аннигиляция

local yellFelBombardment2				= mod:NewYell(246220, nil, nil, nil, "YELL") --Обстрел скверны
local yellFelBombardment				= mod:NewFadesYell(246220, nil, nil, nil, "YELL") --Обстрел скверны
local yellDecimation					= mod:NewYell(244410, nil, nil, nil, "YELL") --Децимация
local yellDecimationFades				= mod:NewShortFadesYell(244410, nil, nil, nil, "YELL") --Децимация

local berserkTimer						= mod:NewBerserkTimer(600)

local countdownChooseCannon				= mod:NewCountdown(15, 245124, nil, nil, 5)
local countdownDecimation				= mod:NewCountdown(15, 244410, nil, nil, 5) --Децимация
local countdownAnnihilation				= mod:NewCountdown(15, 244761, nil, nil, 5) --Аннигиляция
local countdownFelBombardment			= mod:NewCountdown("Alt20", 246220, "Tank", nil, 5) --Обстрел скверны

mod:AddSetIconOption("SetIconOnDecimation", 244410, true, false, {6, 5, 4, 3, 2, 1}) --Децимация
mod:AddSetIconOption("SetIconOnBombardment", 246220, true, false, {8}) --Обстрел скверны
mod:AddRangeFrameOption("7/17")

mod.vb.deciminationActive = 0
mod.vb.FelBombardmentActive = 0
mod.vb.phase = 1
mod.vb.lastCannon = 1--Anniilator 1 decimator 2
mod.vb.annihilatorHaywire = false

local debuffFilter
local updateRangeFrame
local warned_preP1 = false
local warned_preP2 = false

do
	debuffFilter = function(uId)
		if DBM:UnitDebuff(uId, 244410, 246919, 246220) then
			return true
		end
	end
	updateRangeFrame = function(self)
		if not self.Options.RangeFrame then return end
		if self.vb.deciminationActive > 0 then
			if DBM:UnitDebuff("player", 244410, 246919) then
				DBM.RangeCheck:Show(17)--Show Everyone
			else
				DBM.RangeCheck:Show(17, debuffFilter)--Show only those affected by debuff
			end
		elseif self.vb.FelBombardmentActive > 0 then
			if DBM:UnitDebuff("player", 246220) then
				DBM.RangeCheck:Show(7)--Will round to 8
			else
				DBM.RangeCheck:Show(7, debuffFilter)
			end
		else
			DBM.RangeCheck:Hide()
		end
	end
end

function mod:OnCombatStart(delay)
	warned_preP1 = false
	warned_preP2 = false
	self.vb.deciminationActive = 0
	self.vb.FelBombardmentActive = 0
	self.vb.lastCannon = 1--Anniilator 1 decimator 2
	self.vb.annihilatorHaywire = false
	self.vb.phase = 1
	berserkTimer:Start(-delay)
	timerSpecialCD:Start(8.5-delay)--First one random.
	countdownChooseCannon:Start(8.5-delay)
	timerFelBombardmentCD:Start(9.7-delay)
	countdownFelBombardment:Start(9.7-delay)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 244969 and self:AntiSpam(3, 1) then --Искоренение
		if not UnitIsDeadOrGhost("player") then
			specWarnEradication:Show()
			specWarnEradication:Play("justrun")
		end
		if self:IsMythic() then
			if not UnitIsDeadOrGhost("player") then
				specWarnEradication2:Schedule(2.5)
				specWarnEradication2:ScheduleVoice(2.5, "defensive")
			end
			timerEradicationCast:Start(5.5)
			countdownChooseCannon:Start(5.5)
		else
			if not UnitIsDeadOrGhost("player") then
				specWarnEradication2:Schedule(2.5)
				specWarnEradication2:ScheduleVoice(2.5, "defensive")
			end
			timerEradicationCast:Start(5.5)
			countdownChooseCannon:Start(5.5)
		end
		timerSurgingFelCD:Cancel()
		timerSurgingFelCast:Cancel()
		specWarnSurgingFel:Cancel()
	elseif spellId == 240277 then --Реактор апокалипсиса
		warnApocDrive:Show()
		timerDecimationCD:Stop()
		timerFelBombardmentCD:Stop()
		countdownFelBombardment:Cancel()
		countdownChooseCannon:Cancel()
		timerAnnihilationCD:Stop()
		if not UnitIsDeadOrGhost("player") then
			specWarnApocDrive:Show()
			specWarnApocDrive:Play("targetchange")
		end
		timerApocDriveCast:Start()
		if self:IsHeroic() then
			timerSurgingFelCD:Start(10.5)
			timerSurgingFelCast:Schedule(10.5) --в других сложностях возможны другие цифры
			if not UnitIsDeadOrGhost("player") then
				specWarnSurgingFel:Schedule(10.5)
				specWarnSurgingFel:ScheduleVoice(10.5, "watchstep")
			end
		elseif self:IsMythic() then
			timerSurgingFelCD:Start(5.5)
			timerSurgingFelCast:Schedule(5.5)
			if not UnitIsDeadOrGhost("player") then
				specWarnSurgingFel:Schedule(5.5)
				specWarnSurgingFel:ScheduleVoice(5.5, "watchstep")
			end
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 244399 or spellId == 245294 or spellId == 246919 then --Децимация
		self.vb.lastCannon = 2--Anniilator 1 decimator 2
		if self.vb.phase == 1 then
			timerAnnihilationCD:Start(16)
			countdownAnnihilation:Start(16)
		elseif self.vb.phase > 1 and not self:IsMythic() then
			timerDecimationCD:Start(16)
			countdownDecimation:Start(16)
		elseif self.vb.phase == 3 and self:IsMythic() then
			timerDecimationCD:Start(32)
			countdownDecimation:Start(32)
			timerAnnihilationCD:Start(16)
			countdownAnnihilation:Start(16)
			specWarnAnnihilation:Schedule(16)
			specWarnAnnihilation:ScheduleVoice(16, "helpsoak")
			specWarnAnnihilation:Schedule(22)
			specWarnAnnihilation:ScheduleVoice(22, "helpsoak")
		end
	elseif spellId == 244294 then --Аннигиляция
		specWarnAnnihilation:Show()
		specWarnAnnihilation:Play("helpsoak")
		if self.vb.annihilatorHaywire then
			DBM:AddMsg("Blizzard fixed haywire Annihilator, tell DBM author")
		else
			self.vb.lastCannon = 1--Annihilation 1 Decimation 2
			if self.vb.phase == 1 or self:IsMythic() then
				timerDecimationCD:Start(16)
				countdownDecimation:Start(16)
			elseif self.vb.phase > 1 and not self:IsMythic() then
				timerAnnihilationCD:Start(16)
				countdownAnnihilation:Start(16)
			end
		end
	elseif spellId == 246663 then --Всплеск скверны
		if self:IsHeroic() then
			timerSurgingFelCD:Start()
			timerSurgingFelCast:Schedule(6.5)
			if not UnitIsDeadOrGhost("player") then
				specWarnSurgingFel:Schedule(6.5)
				specWarnSurgingFel:ScheduleVoice(6.5, "watchstep")
			end
		elseif self:IsMythic() then
			if not UnitIsDeadOrGhost("player") then
				specWarnSurgingFel:Schedule(1.5)
				specWarnSurgingFel:ScheduleVoice(1.5, "watchstep")
			end
			timerSurgingFelCast:Schedule(1.5)
		end
	elseif spellId == 244969 then --Искоренение
		if self.vb.phase == 2 then
			timerSurgingFelCD:Cancel()
			timerSurgingFelCast:Cancel()
			specWarnSurgingFel:Cancel()
		end
	--[[elseif spellId == 246220 then --Обстрел скверны
		local targetname = self:GetBossTarget(122450)
		if not targetname then return end
		warnFelBombardment:Show(targetname)]]
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 246220 then --Обстрел скверны
		self.vb.FelBombardmentActive = self.vb.FelBombardmentActive + 1
		warnFelBombardment:Show(args.destName)
		if args:IsPlayer() then
			specWarnFelBombardment2:Show()
			specWarnFelBombardment2:Play("targetyou")
			specWarnFelBombardment:Schedule(3.5)
			specWarnFelBombardment:ScheduleVoice(3.5, "runout")
			yellFelBombardment2:Yell()
			yellFelBombardment:Countdown(7, 3)
		elseif self:IsTank() then
			specWarnFelBombardmentTaunt:Show(args.destName)
			specWarnFelBombardmentTaunt:Play("tauntboss")
		end
		updateRangeFrame(self)
		if self.Options.SetIconOnBombardment then
			self:SetIcon(args.destName, 8, 13)
		end
	elseif spellId == 244410 or spellId == 246919 then --Децимация
		self.vb.deciminationActive = self.vb.deciminationActive + 1
		warnDecimation:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnDecimation:Show()
			specWarnDecimation:Play("runout")
			yellDecimation:Yell()
			if spellId ~= 246919 then
				yellDecimationFades:Countdown(5, 3)
			end
		elseif self:AntiSpam(3, 2) then
			if not UnitIsDeadOrGhost("player") then
				specWarnDecimation2:Schedule(4.5)
				specWarnDecimation2:ScheduleVoice(4.5, "watchstep")
			end
		end
		if self.Options.SetIconOnDecimation then
			self:SetIcon(args.destName, self.vb.deciminationActive)
		end
		updateRangeFrame(self)
	elseif spellId == 246965 then--Haywire (Annihilator)
		self.vb.annihilatorHaywire = true
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 246220 then
		self.vb.FelBombardmentActive = self.vb.FelBombardmentActive - 1
		if args:IsPlayer() then
			yellFelBombardment:Cancel()
		end
		updateRangeFrame(self)
	elseif spellId == 244410 or spellId == 246919 then
		self.vb.deciminationActive = self.vb.deciminationActive - 1
		if args:IsPlayer() then
			yellDecimationFades:Cancel()
		end
		if self.Options.SetIconOnDecimation then
			self:SetIcon(args.destName, 0)
		end
		updateRangeFrame(self)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 245515 or spellId == 245527 then--decimator-cannon-eject/annihilator-cannon-eject
		self.vb.phase = self.vb.phase + 1
		timerApocDriveCast:Stop()
		timerSurgingFelCast:Cancel()
		timerSurgingFelCD:Cancel()
	--	specWarnSurgingFel:Cancel()
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase))
		if self.vb.phase == 2 and not self:IsMythic() then
			if spellId == 245515 then --(когда уничтожен Дециматор)
				timerAnnihilationCD:Start(21.5)
				countdownChooseCannon:Start(21.5)
			else--245527 (когда уничтожен Аннигилятор)
				timerDecimationCD:Start(21.5)
				countdownChooseCannon:Start(21.5)
			end
		elseif self:IsMythic() then
			if self.vb.lastCannon == 1 then--Annihilator Cannon
				timerDecimationCD:Start(21.5) --было 22
			else
				timerAnnihilationCD:Start(22)
			end
			--timerSpecialCD:Start(22)--Random cannon
		end
		timerFelBombardmentCD:Start(23)
		countdownFelBombardment:Start(23)
	elseif spellId == 244150 then--Fel Bombardment
		if self:IsMythic() then
			timerFelBombardmentCD:Start(15.7)
			countdownFelBombardment:Start(15.7)
		else
			timerFelBombardmentCD:Start(20.7)
			countdownFelBombardment:Start(20.7)
		end
	elseif spellId == 245124 then
		if self.vb.annihilatorHaywire and self.vb.lastCannon == 2 then 
			self.vb.lastCannon = 1
			specWarnAnnihilation:Show()
			specWarnAnnihilation:Play("helpsoak")
			if self.vb.phase == 1 or self:IsMythic() then
				timerDecimationCD:Start(15.8)
				countdownChooseCannon:Start(15.8)
			elseif self.vb.phase > 1 and not self:IsMythic() then
				timerAnnihilationCD:Start(15.8)
				countdownChooseCannon:Start(15.8)
			end
		end
	end
end

function mod:UNIT_HEALTH(uId)
	if self:IsHeroic() or self:IsMythic() then
		if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 122450 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.71 then --Скоро фаза 2 (за 5%)
			warned_preP1 = true
			warnPrePhase2:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
		elseif self.vb.phase == 2 and warned_preP1 and not warned_preP2 and self:GetUnitCreatureId(uId) == 122450 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.40 then --Скоро фаза 3 (за 5%)
			warned_preP2 = true
			warnPrePhase3:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
		end
	elseif self:IsNormal() or self:IsLFR() then
		if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 122450 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.66 then --Скоро фаза 2 (за 5%)
			warned_preP1 = true
			warnPrePhase2:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
		elseif self.vb.phase == 2 and warned_preP1 and not warned_preP2 and self:GetUnitCreatureId(uId) == 122450 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.26 then --Скоро фаза 3 (за 5%)
			warned_preP2 = true
			warnPrePhase3:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
		end
	end
end
