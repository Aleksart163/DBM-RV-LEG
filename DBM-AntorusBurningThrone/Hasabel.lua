local mod	= DBM:NewMod(1985, "DBM-AntorusBurningThrone", nil, 946)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(122104)
mod:SetEncounterID(2064)
mod:DisableESCombatDetection()--Remove if blizz fixes clicking portals causing this event to fire (even though boss isn't engaged)
mod:SetZone()
--mod:SetBossHPInfoToHighest()
--mod:SetUsedIcons(1, 2, 3, 4, 5, 6)
mod:SetHotfixNoticeRev(17650)
mod:SetMinSyncRevision(17650)
mod:DisableIEEUCombatDetection()
mod.respawnTime = 30

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 243983 244709 245504 244607 244915 246805 244689 244000",
	"SPELL_CAST_SUCCESS 245050 244598 244016",
	"SPELL_AURA_APPLIED 244016 244383 244613 244949 244849 245050 245118",
	"SPELL_AURA_APPLIED_DOSE 244016",
	"SPELL_AURA_REFRESH 244016",
	"SPELL_AURA_REMOVED 244383 244613 244849 245118",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 player",
	"UNIT_HEALTH boss1 boss2 boss3 boss4 boss5"
)

local Nexus = DBM:EJ_GetSectionInfo(15799)
local Xoroth = DBM:EJ_GetSectionInfo(15800)
local Rancora = DBM:EJ_GetSectionInfo(15801)
local Nathreza = DBM:EJ_GetSectionInfo(15802)

local warnXorothPortal2					= mod:NewSoonAnnounce(244318, 1) --Усиленный портал Зорот
local warnRancoraPortal2				= mod:NewSoonAnnounce(246082, 1) --Усиленный портал Ранкора
local warnNathrezaPortal2				= mod:NewSoonAnnounce(246157, 1) --Усиленный портал Натреза
--Platform: Nexus
local warnRealityTear					= mod:NewStackAnnounce(244016, 1, nil, "Tank|Healer") --Разрыв реальности
--Platform: Xoroth
local warnXorothPortal					= mod:NewSpellAnnounce(244318, 2, nil, nil, nil, nil, nil, 7) --Усиленный портал Зорот
local warnAegisofFlames					= mod:NewTargetAnnounce(244383, 3, nil, nil, nil, nil, nil, nil, true) --Пламенная эгида
local warnAegisofFlamesEnded			= mod:NewEndAnnounce(244383, 1) --Пламенная эгида
local warnEverburningFlames				= mod:NewTargetAnnounce(244613, 2, nil, false) --Неугасающее пламя
--Platform: Rancora
local warnRancoraPortal					= mod:NewSpellAnnounce(246082, 2, nil, nil, nil, nil, nil, 7) --Усиленный портал Ранкора
local warnCausticSlime					= mod:NewTargetAnnounce(244849, 2, nil, false) --Едкая слизь
--Platform: Nathreza
local warnNathrezaPortal				= mod:NewSpellAnnounce(246157, 2, nil, nil, nil, nil, nil, 7) --Усиленный портал Натреза
local warnDelusions						= mod:NewTargetAnnounce(245050, 2, nil, "Healer") --Заблуждения
local warnCloyingShadows				= mod:NewTargetAnnounce(245118, 2, nil, false) --Надоедливые тени
local warnHungeringGloom				= mod:NewTargetAnnounce(245075, 2, nil, false) --Алчущий сумрак

local specWarnXorothPortal				= mod:NewSpecialWarningMoveTo(244073, "MeleeDps", nil, nil, 3, 6) --портал Зорот
local specWarnRancoraPortal				= mod:NewSpecialWarningMoveTo(244136, "MeleeDps", nil, nil, 3, 6) --портал Ранкора
local specWarnNathrezaPortal			= mod:NewSpecialWarningMoveTo(244146, "MeleeDps", nil, nil, 3, 6) --портал Натреза
--Platform: Nexus
local specWarnRealityTear				= mod:NewSpecialWarningStack(244016, nil, 3, nil, nil, 3, 5) --Разрыв реальности
local specWarnRealityTearOther			= mod:NewSpecialWarningTaunt(244016, nil, nil, nil, 3, 5) --Разрыв реальности
local specWarnTransportPortal			= mod:NewSpecialWarningSwitch(244677, "-Healer", nil, 2, 1, 2) --Транспортный портал
local specWarnCollapsingWorld			= mod:NewSpecialWarningDodgeCount(243983, nil, nil, nil, 2, 3) --Гибнущий мир
local specWarnFelstormBarrage			= mod:NewSpecialWarningDodge(244000, nil, nil, nil, 2, 3) --Шквальный обстрел Скверны
local specWarnFieryDetonation			= mod:NewSpecialWarningInterrupt(244709, "HasInterrupt", nil, 2, 1, 2) --Огненный подрыв
local specWarnHowlingShadows			= mod:NewSpecialWarningInterrupt(245504, "HasInterrupt", nil, nil, 1, 2) --Воющие тени
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)
--Platform: Xoroth
local specWarnFlamesofXoroth			= mod:NewSpecialWarningInterrupt(244607, "HasInterrupt", nil, nil, 1, 2) --Пламя Зорота
local specWarnSupernova					= mod:NewSpecialWarningDodge(244598, nil, nil, nil, 2, 2) --Сверхновая
local specWarnEverburningFlames			= mod:NewSpecialWarningMoveTo(244613, nil, nil, nil, 1) --Неугасающее пламя No voice yet
--Platform: Rancora
local specWarnFelSilkWrap				= mod:NewSpecialWarningYou(244949, nil, nil, nil, 1, 2) --Кокон из скверношелка
local specWarnFelSilkWrapOther			= mod:NewSpecialWarningSwitch(244949, "Dps", nil, nil, 1, 2) --Кокон из скверношелка
local specWarnLeechEssence				= mod:NewSpecialWarningSpell(244915, nil, nil, nil, 1, 2) --Поглощение сущности Don't know what to do for voice yet til strat divised
local specWarnCausticSlime				= mod:NewSpecialWarningMoveTo(244849, nil, nil, nil, 1) --Едкая слизь No voice yet
local specWarnCausticSlimeLFR			= mod:NewSpecialWarningMoveAway(244849, nil, nil, nil, 1) --Едкая слизь No voice yet
--Platform: Nathreza
local specWarnDelusions					= mod:NewSpecialWarningYou(245050, nil, nil, nil, 1, 2) --Заблуждения
--local specWarnCorrupt					= mod:NewSpecialWarningInterrupt(245040, "HasInterrupt", nil, nil, 1, 2)
local specWarnCloyingShadows			= mod:NewSpecialWarningYou(245118, nil, nil, nil, 1) --Надоедливые тени No voice yet (you warning for now, since it's secondary debuff you move to fel miasma)
local specWarnHungeringGloom			= mod:NewSpecialWarningMoveTo(245075, nil, nil, nil, 1) --Алчущий сумрак No voice yet

--Platform: Nexus
mod:AddTimerLine(Nexus)
local timerRealityTearCD				= mod:NewCDTimer(12.1, 244016, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON) --Разрыв реальности
local timerCollapsingWorldCD			= mod:NewCDTimer(32.9, 243983, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Гибнущий мир 32.9-41
local timerFelstormBarrageCD			= mod:NewCDTimer(32.2, 244000, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Шквальный обстрел Скверны 32.9-41
local timerTransportPortalCD			= mod:NewCDTimer(41.2, 244677, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON) --Транспортный портал 41.2-60. most of time 42 on nose.
--Platform: Xoroth
mod:AddTimerLine(Xoroth)
--local timerSupernovaCD					= mod:NewCDTimer(6.1, 244598, nil, nil, nil, 3)
local timerFlamesofXorothCD				= mod:NewCDTimer(6.9, 244607, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON) --Пламя Зорота
--Platform: Rancora
mod:AddTimerLine(Rancora)
local timerFelSilkWrapCD				= mod:NewCDTimer(16.6, 244949, nil, nil, nil, 3, nil, DBM_CORE_DAMAGE_ICON) --Кокон из скверношелка
local timerPoisonEssenceCD				= mod:NewCDTimer(9.4, 246316, nil, nil, nil, 2, nil, DBM_CORE_HEALER_ICON)
local timerLeechEssenceCD				= mod:NewCDTimer(9.4, 244915, nil, nil, nil, 2, nil, DBM_CORE_HEALER_ICON) --Поглощение сущности
--Platform: Nathreza
mod:AddTimerLine(Nathreza)
local timerDelusionsCD					= mod:NewCDTimer(14.6, 245050, nil, nil, nil, 3, nil, DBM_CORE_HEALER_ICON..DBM_CORE_MAGIC_ICON) --Заблуждения

local yellEverburningFlames				= mod:NewFadesYell(244613, nil, nil, nil, "YELL") --Неугасающее пламя
local yellFelSilkWrap					= mod:NewYell(244949, nil, nil, nil, "YELL") --Кокон из скверношелка
local yellCausticSlime					= mod:NewFadesYell(244849, nil, nil, nil, "YELL") --Едкая слизь
local yellCloyingShadows				= mod:NewFadesYell(245118, nil, nil, nil, "YELL") --Надоедливые тени

local berserkTimer						= mod:NewBerserkTimer(600)

--Platform: Nexus
local countdownCollapsingWorld			= mod:NewCountdown(50, 243983, true, 3, 5) --Гибнущий мир
local countdownRealityTear				= mod:NewCountdown("Alt12", 244016, false, 2, 3) --Разрыв реальности
local countdownFelstormBarrage			= mod:NewCountdown("AltTwo32", 244000, nil, nil, 3) --Шквальный обстрел Скверны

mod:AddRangeFrameOption("8/10")
mod:AddBoolOption("ShowAllPlatforms", false)

local warned_preP1 = false
local warned_preP2 = false
local warned_preP3 = false

mod.vb.phase = 0
mod.vb.shieldsActive = false
mod.vb.felBarrageCast = 0
mod.vb.worldCount = 0
mod.vb.firstPortal = false
local playerPlatform = 1--1 Nexus, 2 Xoroth, 3 Rancora, 4 Nathreza
local mindFog, aegisFlames, felMiasma = DBM:GetSpellInfo(245099), DBM:GetSpellInfo(244383), DBM:GetSpellInfo(244826)

local updateRangeFrame
do
	local function debuffFilter(uId)
		if DBM:UnitDebuff(uId, 244613, 245075, 244849) then
			return true
		end
	end
	updateRangeFrame = function(self)
		if not self.Options.RangeFrame then return end
		if DBM:UnitDebuff("player", 244849) then
			DBM.RangeCheck:Show(10)
		elseif DBM:UnitDebuff("player", 244613, 245118, 245075) then
			DBM.RangeCheck:Show(8)
		else
			DBM.RangeCheck:Show(10, debuffFilter)
		end
	end
end

local function updateAllTimers(self, ICD)
	DBM:Debug("updateAllTimers running", 3)
	if timerCollapsingWorldCD:GetRemaining() < ICD then
		local elapsed, total = timerCollapsingWorldCD:GetTime()
		local extend = ICD - (total-elapsed)
		DBM:Debug("timerCollapsingWorldCD extended by: "..extend, 2)
		timerCollapsingWorldCD:Stop()
		timerCollapsingWorldCD:Update(elapsed, total+extend)
		countdownCollapsingWorld:Cancel()
		countdownCollapsingWorld:Start(ICD)
	end
	if timerFelstormBarrageCD:GetRemaining() < ICD then
		local elapsed, total = timerFelstormBarrageCD:GetTime()
		local extend = ICD - (total-elapsed)
		DBM:Debug("timerFelstormBarrageCD extended by: "..extend, 2)
		timerFelstormBarrageCD:Stop()
		timerFelstormBarrageCD:Update(elapsed, total+extend)
		countdownFelstormBarrage:Cancel()
		countdownFelstormBarrage:Start(ICD)
	end
	if self.vb.firstPortal and timerTransportPortalCD:GetRemaining() < ICD then
		local elapsed, total = timerTransportPortalCD:GetTime()
		local extend = ICD - (total-elapsed)
		DBM:Debug("timerTransportPortalCD extended by: "..extend, 2)
		timerTransportPortalCD:Stop()
		timerTransportPortalCD:Update(elapsed, total+extend)
	end
end

function mod:OnCombatStart(delay)
	self.vb.phase = 0
	warned_preP1 = false
	warned_preP2 = false
	warned_preP3 = false
	self.vb.shieldsActive = false
	self.vb.firstPortal = false
	self.vb.felBarrageCast = 0
	self.vb.worldCount = 0
	playerPlatform = 1--Nexus
	berserkTimer:Start(-delay)
	timerRealityTearCD:Start(6.2-delay)
	countdownRealityTear:Start(6.2-delay)
	if self:IsMythic() then
		timerCollapsingWorldCD:Start(11-delay) --Гибнущий мир
		countdownCollapsingWorld:Start(11-delay) --Гибнущий мир
		timerFelstormBarrageCD:Start(27-delay) --Шквальный обстрел Скверны
		countdownFelstormBarrage:Start(27-delay) --Шквальный обстрел Скверны
	else
		timerCollapsingWorldCD:Start(10.5-delay) --Гибнущий мир
		countdownCollapsingWorld:Start(10.5-delay) --Гибнущий мир
		timerFelstormBarrageCD:Start(25.2-delay) --Шквальный обстрел Скверны
		countdownFelstormBarrage:Start(25.2-delay) --Шквальный обстрел Скверны
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 243983 then --Гибнущий мир
		self.vb.worldCount = self.vb.worldCount + 1
		if self:IsEasy() then
			timerCollapsingWorldCD:Start(37.7)--37, but offen delayed by ICD
			countdownCollapsingWorld:Start(37.8)
		elseif self:IsMythic() then
			timerCollapsingWorldCD:Start(28)
			countdownCollapsingWorld:Start(28)
		else
			timerCollapsingWorldCD:Start()
			countdownCollapsingWorld:Start(31.9)
		end
		if self.Options.ShowAllPlatforms or playerPlatform == 1 then--Actually on nexus platform
			if not UnitIsDeadOrGhost("player") then
				specWarnCollapsingWorld:Show(self.vb.worldCount)
				specWarnCollapsingWorld:Play("watchstep")
			end
		end
		updateAllTimers(self, 9.7)
	elseif spellId == 244709 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnFieryDetonation:Show()
		specWarnFieryDetonation:Play("kickcast")
	elseif spellId == 245504 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnHowlingShadows:Show()
		specWarnHowlingShadows:Play("kickcast")
	elseif spellId == 244607 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnFlamesofXoroth:Show()
		specWarnFlamesofXoroth:Play("kickcast")
		if self:IsMythic() then
			timerFlamesofXorothCD:Start(7.5)
		else
			timerFlamesofXorothCD:Start()
		end
	elseif spellId == 246316 then--Rancora platform
		timerPoisonEssenceCD:Start()
	elseif spellId == 244915 or spellId == 246805 then
		if self.Options.ShowAllPlatforms or playerPlatform == 3 then--Actually on Rancora platform
			specWarnLeechEssence:Show()
			if self:IsMythic() then
				timerLeechEssenceCD:Start(10)
			else
				timerLeechEssenceCD:Start()
			end
		end
	elseif spellId == 244689 then --Транспортный портал
		if self:IsMythic() then
			timerTransportPortalCD:Start(40)
		else
			timerTransportPortalCD:Start()
		end
		if self.Options.ShowAllPlatforms or playerPlatform == 1 then--Actually on nexus platform
			if not UnitIsDeadOrGhost("player") then
				specWarnTransportPortal:Show()
				specWarnTransportPortal:Play("mobkill")
			end
		end
		updateAllTimers(self, 8.5)
	elseif spellId == 244000 then --Шквальный обстрел Скверны
		self.vb.felBarrageCast = self.vb.felBarrageCast + 1
		if self:IsEasy() then
			timerFelstormBarrageCD:Start(37.8)--37.8-43.8
			countdownFelstormBarrage:Start(37.8)
		elseif self:IsMythic() then
			timerFelstormBarrageCD:Start(28.6)
			countdownFelstormBarrage:Start(28.6)
		else
			timerFelstormBarrageCD:Start()--32.9-41
			countdownFelstormBarrage:Start(32.2)
		end
		if self.Options.ShowAllPlatforms or playerPlatform == 1 then--Actually on nexus platform
			if not UnitIsDeadOrGhost("player") then
				specWarnFelstormBarrage:Show()
				specWarnFelstormBarrage:Play("farfromline")
			end
		end
		updateAllTimers(self, 9.7)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 245050 then--Delusions
		timerDelusionsCD:Start()
	elseif spellId == 244598 and self:AntiSpam(5, 1) then--Supernova
		if self.Options.ShowAllPlatforms or playerPlatform == 2 then--Actually on Xoroth platform
			specWarnSupernova:Show()
			specWarnSupernova:Play("watchstep")
		end
	elseif spellId == 244016 then
		timerRealityTearCD:Start()
		countdownRealityTear:Start(12.2)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 244016 then
		local uId = DBM:GetRaidUnitId(args.destName)
--		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 3 then
				if args:IsPlayer() then--At this point the other tank SHOULD be clear.
					specWarnRealityTear:Show(amount)
					specWarnRealityTear:Play("stackhigh")
				else--Taunt as soon as stacks are clear, regardless of stack count.
					local _, _, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
					local remaining
					if expireTime then
						remaining = expireTime-GetTime()
					end
					if not UnitIsDeadOrGhost("player") and (not remaining or remaining and remaining < 12) then
						specWarnRealityTearOther:Show(args.destName)
						specWarnRealityTearOther:Play("tauntboss")
					else
						warnRealityTear:Show(args.destName, amount)
					end
				end
			else
				warnRealityTear:Show(args.destName, amount)
			end
--		end
	elseif spellId == 244383 and self:AntiSpam(2, args.destName) then--Aegis of Flames
		self.vb.shieldsActive = true
		warnAegisofFlames:Show(args.destName)
	elseif spellId == 244613 then--Everburning Flames
		warnEverburningFlames:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			specWarnEverburningFlames:Show(mindFog)
			yellEverburningFlames:Countdown(10)
			updateRangeFrame(self)
		end
	elseif spellId == 244849 then--Caustic Slime
		warnCausticSlime:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			if self.vb.shieldsActive then--Show moveto message
				specWarnCausticSlime:Show(aegisFlames)
			else--Show LFR/You message
				specWarnCausticSlimeLFR:Show()
			end
			yellCausticSlime:Countdown(20)
			updateRangeFrame(self)
		end
	elseif spellId == 245118 then--Cloying Shadows
		warnCloyingShadows:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			specWarnCloyingShadows:Show()
			yellCloyingShadows:Countdown(30)
			updateRangeFrame(self)
		end
	elseif spellId == 245075 then
		warnHungeringGloom:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			specWarnHungeringGloom:Show(felMiasma)
			updateRangeFrame(self)
		end
	elseif spellId == 244949 then--Felsilk Wrap
		if args:IsPlayer() then
			specWarnFelSilkWrap:Show()
			specWarnRealityTearOther:Play("targetyou")
			yellFelSilkWrap:Yell()
		else
			if self.Options.ShowAllPlatforms or playerPlatform == 3 then--Actually on Rancora platform
				specWarnFelSilkWrapOther:Show()
				if self.Options.SpecWarn244949switch then
					specWarnFelSilkWrapOther:Play("changetarget")
				end
				if self:IsMythic() then
					timerFelSilkWrapCD:Start(16)
				else
					timerFelSilkWrapCD:Start()
				end
			end
		end
	elseif spellId == 245050 then--Delusions
		warnDelusions:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnDelusions:Show()
			specWarnDelusions:Play("targetyou")
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
mod.SPELL_AURA_REFRESH = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 244383 then--Aegis of Flames
		self.vb.shieldsActive = false
		warnAegisofFlamesEnded:Show()
	elseif spellId == 244613 then--Everburning Flames
		if args:IsPlayer() then
			yellEverburningFlames:Cancel()
			updateRangeFrame(self)
		end
	elseif spellId == 244849 then--Caustic Slime
		if args:IsPlayer() then
			yellCausticSlime:Cancel()
			updateRangeFrame(self)
		end
	elseif spellId == 245118 then--Cloying Shadows
		if args:IsPlayer() then
			yellCloyingShadows:Cancel()
			--updateRangeFrame(self)
		end
	elseif spellId == 245075 then--Hungering Gloom
		if args:IsPlayer() then
			updateRangeFrame(self)
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show()
		specWarnGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 124396 then --Вулканар (платформа Зорота)
		--timerSupernovaCD:Stop()
		timerFlamesofXorothCD:Stop()
	elseif cid == 124395 then --Леди Дацидия (платформа Ранкора)
		timerFelSilkWrapCD:Stop()
		timerLeechEssenceCD:Stop()--Add appropriate boss filter when mythic add support added
	elseif cid == 124394 then --Лорд Эйлгар (платформа Натреза)
		timerDelusionsCD:Stop()--Add appropriate boss filter when mythic add support added
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 257939 then --Врата: Зорот
		self.vb.firstPortal = true
		warnXorothPortal:Show()
		warnXorothPortal:Play("newportal")
		self.vb.phase = 1
	--	if args:IsPlayer() and self:IsMeleeDps() then
		if not UnitIsDeadOrGhost("player") then
			specWarnXorothPortal:Show(Xoroth)
			specWarnXorothPortal:Play("justrun")
		end
	elseif spellId == 257941 then --Врата: Ранкора
		warnRancoraPortal:Show()
		warnRancoraPortal:Play("newportal")
		self.vb.phase = 2
	--	if args:IsPlayer() and self:IsMeleeDps() then
		if not UnitIsDeadOrGhost("player") then
			specWarnRancoraPortal:Show(Rancora)
			specWarnRancoraPortal:Play("justrun")
		end
	elseif spellId == 257942 then --Врата: Натреза
		warnNathrezaPortal:Show()
		warnNathrezaPortal:Play("newportal")
		self.vb.phase = 3
	--	if args:IsPlayer() and self:IsMeleeDps() then
		if not UnitIsDeadOrGhost("player") then
			specWarnNathrezaPortal:Show(Nathreza)
			specWarnNathrezaPortal:Play("justrun")
		end
	elseif spellId == 244455 then --платформа Зорот
		playerPlatform = 2
	elseif spellId == 244512 then --платформа Ранкора
		playerPlatform = 3
	elseif spellId == 244513 then --платформа Натреза
		playerPlatform = 4
	elseif spellId == 244450 then --платформа Нексус
		playerPlatform = 1
	end
end

function mod:UNIT_HEALTH(uId)
	if self.vb.phase == 0 and not warned_preP1 and self:GetUnitCreatureId(uId) == 122104 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.96 then --скоро фаза 1
		warned_preP1 = true
		warnXorothPortal2:Show()
	elseif self.vb.phase == 1 and warned_preP1 and not warned_preP2 and self:GetUnitCreatureId(uId) == 122104 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.66 then --скоро фаза 2
		warned_preP2 = true
		warnRancoraPortal2:Show()
	elseif self.vb.phase == 2 and warned_preP2 and not warned_preP3 and self:GetUnitCreatureId(uId) == 122104 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.36 then --скоро фаза 3
		warned_preP3 = true
		warnNathrezaPortal2:Show()
	end
end
 