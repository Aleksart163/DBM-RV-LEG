local mod	= DBM:NewMod(1986, "DBM-AntorusBurningThrone", nil, 946)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(122468, 122467, 122469)--122468 Noura, 122467 Asara, 122469 Diima, 125436 Thu'raya (mythic only)
mod:SetEncounterID(2073)
mod:SetZone()
mod:SetBossHPInfoToHighest()
mod:SetUsedIcons(8, 7, 6, 5, 4, 3, 2, 1)
mod:SetHotfixNoticeRev(16963)
mod:DisableIEEUCombatDetection()
mod.respawnTime = 28

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 245627 252861 253650 250648 250095 245303",
	"SPELL_CAST_SUCCESS 244899 253520 245532 250335 250333 250334 249793 245518 246329",
	"SPELL_AURA_APPLIED 244899 253520 245518 245586 250757 249863 256356",
	"SPELL_AURA_APPLIED_DOSE 244899 245518",
	"SPELL_AURA_REMOVED 253520 245586 249863 250757",
	"SPELL_PERIODIC_DAMAGE 245634 253020",
	"SPELL_PERIODIC_MISSED 245634 253020",
	"UNIT_DIED",
	"UNIT_TARGETABLE_CHANGED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5"
)

local Noura = DBM:EJ_GetSectionInfo(15967)
local Asara = DBM:EJ_GetSectionInfo(15968)
local Diima = DBM:EJ_GetSectionInfo(15969)
local Thuraya = DBM:EJ_GetSectionInfo(16398)
local torment = DBM:EJ_GetSectionInfo(16138)
--All
local warnActivated						= mod:NewTargetAnnounce(118212, 3, 78740, nil, nil, nil, nil, nil, true) --Активация
--Noura, Mother of Flames
local warnFieryStrike					= mod:NewStackAnnounce(244899, 2, nil, "Tank") --Пламенный удар
local warnWhirlingSaber					= mod:NewSpellAnnounce(245627, 2) --Вращающийся меч
local warnFulminatingPulse				= mod:NewTargetAnnounce(253520, 3) --Гремучий импульс
--Asara, Mother of Night
--Diima, Mother of Gloom
local warnChilledBlood					= mod:NewTargetAnnounce(245586, 2) --Студеная кровь
local warnChilledBlood2					= mod:NewTargetAnnounce(129148, 3) --Заморозка
local warnFlashFreeze					= mod:NewStackAnnounce(245518, 2, nil, "Tank") --Морозная вспышка
--Thu'raya, Mother of the Cosmos (Mythic)
local warnCosmicGlare					= mod:NewTargetAnnounce(250757, 3) --Космический отблеск
--Мучения
local specWarnAmantul2					= mod:NewSpecialWarningSoon(250335, nil, nil, nil, 1, 2) --Мучения Амантула
local specWarnNorgannon2				= mod:NewSpecialWarningSoon(250334, nil, nil, nil, 1, 2) --Мучения Норганнона
local specWarnGolgannet2				= mod:NewSpecialWarningSoon(249793, nil, nil, nil, 1, 2) --Мучения Голганнета
local specWarnKazgagot2					= mod:NewSpecialWarningSoon(250333, nil, nil, nil, 1, 2) --Мучения Казгарота
local specWarnAmantul					= mod:NewSpecialWarning("Amantul", "-Healer", nil, nil, 3, 6) --Мучения Амантула
local specWarnNorgannon					= mod:NewSpecialWarning("Norgannon", nil, nil, nil, 3, 6) --Мучения Норганнона
local specWarnGolgannet					= mod:NewSpecialWarning("Golgannet", nil, nil, nil, 3, 6) --Мучения Голганнета
local specWarnKazgagot					= mod:NewSpecialWarning("Kazgagot", nil, nil, nil, 3, 6) --Мучения Казгарота
--General
local specWarnGTFO						= mod:NewSpecialWarningYouMove(245634, nil, nil, nil, 1, 2) --Вращающийся меч
local specWarnGTFO2						= mod:NewSpecialWarningYouMove(253020, nil, nil, nil, 1, 2) --Буря тьмы
local specWarnActivated					= mod:NewSpecialWarningSwitchCount(118212, "Tank", nil, 2, 3, 2)
--Noura, Mother of Flames
local specWarnFieryStrike				= mod:NewSpecialWarningStack(244899, nil, 2, nil, nil, 1, 6) --Пламенный удар
local specWarnFieryStrikeOther			= mod:NewSpecialWarningTaunt(244899, nil, nil, nil, 1, 2) --Пламенный удар
local specWarnFulminatingPulse			= mod:NewSpecialWarningYouMoveAway(253520, nil, nil, nil, 1, 3) --Гремучий импульс
--Asara, Mother of Night
local specWarnShadowBlades				= mod:NewSpecialWarningDodge(246329, nil, nil, nil, 2, 2) --Теневые клинки
local specWarnStormofDarkness			= mod:NewSpecialWarningIcePud(252861, nil, nil, nil, 2, 3) --Буря тьмы
--Diima, Mother of Gloom
local specWarnFlashfreeze				= mod:NewSpecialWarningStack(245518, nil, 2, nil, nil, 1, 6) --Морозная вспышка
local specWarnFlashfreezeOther			= mod:NewSpecialWarningTaunt(245518, nil, nil, nil, 1, 2) --Морозная вспышка
local specWarnChilledBlood				= mod:NewSpecialWarningTarget(245586, "Healer", nil, nil, 1, 2) --Студеная кровь
local specWarnChilledBlood2				= mod:NewSpecialWarningYou(245586, nil, nil, nil, 2, 2) --Студеная кровь
local specWarnOrbofFrost				= mod:NewSpecialWarningDodge(253650, nil, nil, nil, 1, 2) --Сфера льда
--Thu'raya, Mother of the Cosmos (Mythic)
local specWarnTouchoftheCosmos			= mod:NewSpecialWarningInterruptCount(250648, "HasInterrupt", nil, nil, 1, 2) --Прикосновение космоса
local specWarnCosmicGlare				= mod:NewSpecialWarningYou(250757, nil, nil, nil, 1, 2) --Космический отблеск
--Torment of the Titans
local specWarnTormentofTitans			= mod:NewSpecialWarningSpell("ej16138", nil, nil, nil, 1, 7)

--General
local timerBossIncoming					= mod:NewTimer(61, "timerBossIncoming", nil, nil, nil, 1)
--Noura, Mother of Flames
mod:AddTimerLine(Noura)
local timerFieryStrikeCD				= mod:NewCDTimer(10.5, 244899, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON) --Пламенный удар
local timerWhirlingSaberCD				= mod:NewNextTimer(35.1, 245627, nil, nil, nil, 3) --Вращающийся меч 35-45
local timerFulminatingPulseCD			= mod:NewNextTimer(40.1, 253520, nil, nil, nil, 3) --Гремучий импульс
--Asara, Mother of Night
mod:AddTimerLine(Asara)
local timerShadowBladesCD				= mod:NewCDTimer(28, 246329, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Теневые клинки
local timerStormofDarknessCD			= mod:NewNextCountTimer(56.8, 252861, nil, nil, nil, 2, nil, DBM_CORE_HEALER_ICON) --Буря тьмы
--Diima, Mother of Gloom
mod:AddTimerLine(Diima)
local timerFlashFreezeCD				= mod:NewCDTimer(10.1, 245518, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON) --Морозная вспышка
local timerChilledBloodCD				= mod:NewNextTimer(25.4, 245586, nil, nil, nil, 5, nil, DBM_CORE_HEALER_ICON) --Студеная кровь
local timerOrbofFrostCD					= mod:NewNextTimer(30, 253650, nil, nil, nil, 3)
--Thu'raya, Mother of the Cosmos (Mythic)
mod:AddTimerLine(Thuraya)
local timerCosmicGlareCD				= mod:NewCDTimer(15, 250757, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Космический отблеск
--Torment of the Titans
mod:AddTimerLine(torment)
--Activations timers
local timerMachinationsofAmanThulCD		= mod:NewCastTimer(90, 250335, nil, nil, nil, 6, nil, DBM_CORE_HEALER_ICON..DBM_CORE_DEADLY_ICON) --Махинации Амантула
local timerFlamesofKhazgorothCD			= mod:NewCastTimer(90, 250333, nil, nil, nil, 6, nil, DBM_CORE_DEADLY_ICON) --Пламя Казгарота
local timerSpectralArmyofNorgannonCD	= mod:NewCastTimer(90, 250334, nil, nil, nil, 6, nil, DBM_CORE_DEADLY_ICON) --Армия Норганнона
local timerFuryofGolgannethCD			= mod:NewCastTimer(90, 249793, nil, nil, nil, 6, nil, DBM_CORE_DEADLY_ICON) --Мучения Голганнета
--Шиварры
local timerDiimaCD						= mod:NewCDTimer(194.5, "ej15969", nil, nil, nil, 6, 253189, DBM_CORE_TANK_ICON) --Дима
local timerNouraCD						= mod:NewCDTimer(194.5, "ej15967", nil, nil, nil, 6, 253189, DBM_CORE_TANK_ICON) --Нура
local timerAsaraCD						= mod:NewCDTimer(194.5, "ej15968", nil, nil, nil, 6, 253189, DBM_CORE_TANK_ICON) --Азара
local timerThurayaCD					= mod:NewCDTimer(242, "ej16398", nil, nil, nil, 6, 253189, DBM_CORE_TANK_ICON..DBM_CORE_MYTHIC_ICON) --Зурайя
----Actual phase stuff
local timerMachinationsofAman			= mod:NewCastTimer(25, 250095, nil, nil, nil, 5, nil, DBM_CORE_DAMAGE_ICON) --Махинации Амантула

local yellFulminatingPulse2				= mod:NewYell(253520, nil, nil, nil, "YELL") --Гремучий импульс
local yellFulminatingPulse				= mod:NewFadesYell(253520, nil, nil, nil, "YELL") --Гремучий импульс
local yellFlashfreeze					= mod:NewYell(245518, nil, false, nil, "YELL") --Морозная вспышка
local yellCosmicGlare					= mod:NewYell(250757, nil, nil, nil, "YELL") --Космический отблеск
local yellCosmicGlareFades				= mod:NewShortFadesYell(250757, nil, nil, nil, "YELL") --Космический отблеск

local berserkTimer						= mod:NewBerserkTimer(720) --(под героик точно)

--Noura, Mother of Flames
local countdownTitans					= mod:NewCountdown(90, "ej16138", nil, nil, 5)
local countdownFulminatingPulse			= mod:NewCountdown("Alt40", 253520, "Healer", nil, 5)
--Asara, Mother of Night
local countdownStormofDarkness			= mod:NewCountdown("AltTwo57", 252861, nil, nil, 5) --Буря тьмы

mod:AddSetIconOption("SetIconOnFulminatingPulse2", 253520, true, false, {6, 5, 4}) --Гремучий импульс на 3 цели
mod:AddSetIconOption("SetIconOnChilledBlood2", 245586, true, false, {3, 2, 1}) --Студеная кровь на 3 цели
mod:AddSetIconOption("SetIconOnCosmicGlare", 250757, true, false, {8, 7}) --Космический отблеск на 2
mod:AddInfoFrameOption(245586, true) --Студеная кровь
mod:AddNamePlateOption("NPAuraOnVisageofTitan", 249863)
mod:AddBoolOption("SetLighting", true)
mod:AddBoolOption("IgnoreFirstKick", false)
mod:AddMiscLine(DBM_CORE_OPTION_CATEGORY_DROPDOWNS)
mod:AddDropdownOption("InterruptBehavior", {"Three", "Four", "Five"}, "Three", "misc")
mod:AddDropdownOption("TauntBehavior", {"TwoMythicThreeNon", "TwoAlways", "ThreeAlways"}, "TwoMythicThreeNon", "misc")

local titanCount = {}
mod.vb.shivarrsCount = 0
mod.vb.stormCount = 0
mod.vb.chilledCount = 0
mod.vb.MachinationsLeft = 0
mod.vb.fpIcon = 4
mod.vb.chilledIcon = 1
mod.vb.glareIcon = 7
mod.vb.touchCosmosCast = 0
mod.vb.interruptBehavior = "Three"
mod.vb.ignoreFirstInterrupt = false
mod.vb.firstCastHappend = false
local CVAR1, CVAR2 = nil, nil

function mod:OnCombatStart(delay)
	self.vb.shivarrsCount = 0
	self.vb.stormCount = 0
	self.vb.chilledCount = 0
	self.vb.MachinationsLeft = 0
	self.vb.fpIcon = 4
	self.vb.chilledIcon = 1
	self.vb.glareIcon = 7
	self.vb.touchCosmosCast = 0
	self.vb.interruptBehavior = "Three"
	self.vb.ignoreFirstInterrupt = false
	self.vb.firstCastHappend = false
	if self:IsMythic() then
		self:SetCreatureID(122468, 122467, 122469, 125436)
	else
		self:SetCreatureID(122468, 122467, 122469)
	end
	--Diima, Mother of Gloom is first one to go inactive
	berserkTimer:Start(-delay)
	timerWhirlingSaberCD:Start(8.5-delay) --Вращающийся меч (под гер и мифик точно)
	timerFieryStrikeCD:Start(11-delay)
	timerShadowBladesCD:Start(15-delay) --Теневые клинки (под гер и мифик вроде точно)
	if not self:IsEasy() then
		timerFulminatingPulseCD:Start(20.3-delay)
		countdownFulminatingPulse:Start(20.3-delay)
		timerStormofDarknessCD:Start(29-delay, 1) --Буря тьмы  (под гер и мифик вроде точно)
		countdownStormofDarkness:Start(29-delay)
	end
	if self.Options.NPAuraOnVisageofTitan then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
	if self.Options.SetLighting and not IsMacClient() then--Mac client doesn't support low (1) setting for lighting (and not InCombatLockdown() needed?)
		CVAR1, CVAR2 = GetCVar("graphicsLightingQuality") or 3, GetCVar("raidGraphicsLightingQuality") or 2--Non raid cvar is nil if 3 (default) and raid one is nil if 2 (default)
		SetCVar("graphicsLightingQuality", 1)
		SetCVar("raidGraphicsLightingQuality", 1)
	end
	if UnitIsGroupLeader("player") and not self:IsLFR() then
		if self.Options.InterruptBehavior == "Three" then
			self:SendSync("Three", self.Options.IgnoreFirstKick)
		elseif self.Options.InterruptBehavior == "Four" then
			self:SendSync("Four", self.Options.IgnoreFirstKick)
		elseif self.Options.InterruptBehavior == "Five" then
			self:SendSync("Five", self.Options.IgnoreFirstKick)
		end
	end
end

function mod:OnCombatEnd()
	table.wipe(titanCount)
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.NPAuraOnVisageofTitan then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
	--Attempt restore right away
	if (CVAR1 or CVAR2) and not InCombatLockdown() then
		SetCVar("graphicsLightingQuality", CVAR1)
		SetCVar("raidGraphicsLightingQuality", CVAR2)
		CVAR1, CVAR2 = nil, nil
	end
end

--Backup check on leaving combat if OnCombatEnd wasn't successful
function mod:OnLeavingCombat()
	if CVAR1 or CVAR2 then
		SetCVar("graphicsLightingQuality", CVAR1)
		SetCVar("raidGraphicsLightingQuality", CVAR2)
		CVAR1, CVAR2 = nil, nil
	end
end

function mod:OnTimerRecovery()
	if self:IsMythic() then
		self:SetCreatureID(122468, 122467, 122469, 125436)
	else
		self:SetCreatureID(122468, 122467, 122469)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 245627 then --Вращающийся меч
		warnWhirlingSaber:Show()
		if self:IsHeroic() or self:IsMythic() then --смотрится норм под героик
			timerWhirlingSaberCD:Start(36)
		else
			timerWhirlingSaberCD:Start()
		end
	elseif spellId == 252861 then --Буря тьмы
		self.vb.stormCount = self.vb.stormCount + 1
		if not UnitIsDeadOrGhost("player") then
			specWarnStormofDarkness:Show()
			specWarnStormofDarkness:Play("findshelter")
		end
		if self:IsHeroic() or self:IsMythic() then --смотрится норм под героик
			timerStormofDarknessCD:Start(58, self.vb.stormCount+1)
			countdownStormofDarkness:Start(58)
		else
			timerStormofDarknessCD:Start(56.8, self.vb.stormCount+1)
			countdownStormofDarkness:Start(56.8)
		end
	elseif spellId == 253650 then
		if not UnitIsDeadOrGhost("player") then
			specWarnOrbofFrost:Show()
			specWarnOrbofFrost:Play("161411")
		end
		timerOrbofFrostCD:Start()
	elseif spellId == 250095 and self:AntiSpam(3, 1) then
		timerMachinationsofAman:Start()
	elseif spellId == 250648 then --Прикосновение космоса
		if self.vb.firstCastHappend or not self.vb.ignoreFirstInterrupt then
			self.vb.touchCosmosCast = self.vb.touchCosmosCast + 1
		end
		if (self.vb.interruptBehavior == "Three" and self.vb.touchCosmosCast == 4) or (self.vb.interruptBehavior == "Four" and self.vb.touchCosmosCast == 5) or (self.vb.interruptBehavior == "Five" and self.vb.touchCosmosCast == 6) then
			self.vb.touchCosmosCast = 0
		end
		local kickCount = self.vb.touchCosmosCast
		specWarnTouchoftheCosmos:Show(args.sourceName, kickCount)
		if kickCount == 0 then
			specWarnTouchoftheCosmos:Play("kickcast")
		else
			specWarnTouchoftheCosmos:Play("kick"..kickCount.."r")
		end
		if not self.vb.firstCastHappend then self.vb.firstCastHappend = true end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 244899 then
		timerFieryStrikeCD:Start()
	elseif spellId == 245518 then
		timerFlashFreezeCD:Start()
	elseif spellId == 253520 and self:AntiSpam(3, 3) then
		timerFulminatingPulseCD:Start()
		countdownFulminatingPulse:Start(40.1)
	elseif spellId == 245532 and self:AntiSpam(3, 2) then
		timerChilledBloodCD:Start()
		specWarnChilledBlood:Play("healall")
	elseif (spellId == 250335 or spellId == 250333 or spellId == 250334 or spellId == 249793) and self:IsInCombat() then --Мучения титанов
		self.vb.shivarrsCount = self.vb.shivarrsCount + 1
		countdownTitans:Start()
		if spellId == 250335 then --Махинации Амантула
			timerMachinationsofAmanThulCD:Start()
			specWarnAmantul2:Schedule(80)
			if not UnitIsDeadOrGhost("player") then
				specWarnAmantul:Schedule(85)
				specWarnAmantul:ScheduleVoice(85, "mobkill")
			end
		elseif spellId == 250333 then --Пламя Казгарота
			timerFlamesofKhazgorothCD:Start()
			specWarnKazgagot2:Schedule(80)
			if not UnitIsDeadOrGhost("player") then
				specWarnKazgagot:Schedule(85)
				specWarnKazgagot:ScheduleVoice(85, "watchstep")
			end
		elseif spellId == 250334 then --Призрачная армия Норганнона
			timerSpectralArmyofNorgannonCD:Start()
			specWarnNorgannon2:Schedule(80)
			if not UnitIsDeadOrGhost("player") then
				specWarnNorgannon:Schedule(85)
				specWarnNorgannon:ScheduleVoice(85, "watchstep")
			end
		elseif spellId == 249793 then --Ярость Голганнета
			timerFuryofGolgannethCD:Start()
			specWarnGolgannet2:Schedule(80)
			if not UnitIsDeadOrGhost("player") then
				specWarnGolgannet:Schedule(85)
				specWarnGolgannet:ScheduleVoice(85, "watchstep")
			end
		end
		if self:IsMythic() then
			if self.vb.shivarrsCount == 1 then --свалила Дима
				timerDiimaCD:Start(190.5)
			elseif self.vb.shivarrsCount == 2 then --свалила Зурайя
				timerThurayaCD:Start(190.5)
			elseif self.vb.shivarrsCount == 5 then --свалила Нура
				timerNouraCD:Start(190.5)
			elseif self.vb.shivarrsCount == 6 then --свалила Азара
				timerAsaraCD:Start(190.5)
			elseif self.vb.shivarrsCount == 9 then --свалила Дима
				timerDiimaCD:Start(190.5)
			elseif self.vb.shivarrsCount == 10 then --свалила Зурайя
				timerThurayaCD:Start(190.5)
			elseif self.vb.shivarrsCount == 13 then --свалила Нура
				timerNouraCD:Start(190.5)
			elseif self.vb.shivarrsCount == 14 then --свалила Азара
				timerAsaraCD:Start(190.5)
			end
		else
			if self.vb.shivarrsCount == 1 then --свалила Дима
				timerDiimaCD:Start(190.5)
			elseif self.vb.shivarrsCount == 3 then --свалила Нура
				timerNouraCD:Start(190.5)
			elseif self.vb.shivarrsCount == 5 then --свалила Азара
				timerAsaraCD:Start(190.5)
			elseif self.vb.shivarrsCount == 7 then --свалила Дима
				timerDiimaCD:Start(190.5)
			elseif self.vb.shivarrsCount == 9 then --свалила Нура
				timerNouraCD:Start(190.5)
			elseif self.vb.shivarrsCount == 11 then --свалила Азара
				timerAsaraCD:Start(190.5)
			end
		end
	elseif spellId == 246329 then --Теневые клинки
		if not UnitIsDeadOrGhost("player") then
			specWarnShadowBlades:Show()
			specWarnShadowBlades:Play("watchwave")
		end
		timerShadowBladesCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 244899 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			local tauntStack = 3
			if self:IsMythic() and self.Options.TauntBehavior == "TwoMythicThreeNon" or self.Options.TauntBehavior == "TwoAlways" then
				tauntStack = 2
			end
			if amount >= tauntStack then
				if args:IsPlayer() then--At this point the other tank SHOULD be clear.
					specWarnFieryStrike:Show(amount)
					specWarnFieryStrike:Play("stackhigh")
				else
					local _, _, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
					local remaining
					if expireTime then
						remaining = expireTime-GetTime()
					end
					if not UnitIsDeadOrGhost("player") and (not remaining or remaining and remaining < 10) then
						specWarnFieryStrikeOther:Show(args.destName)
						specWarnFieryStrikeOther:Play("tauntboss")
					else
						warnFieryStrike:Show(args.destName, amount)
					end
				end
			else
				warnFieryStrike:Show(args.destName, amount)
			end
		end
	elseif spellId == 253520 then
		warnFulminatingPulse:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnFulminatingPulse:Show()
			specWarnFulminatingPulse:Play("runout")
			yellFulminatingPulse2:Yell()
			yellFulminatingPulse:Countdown(10, 3)
		end
		if self.Options.SetIconOnFulminatingPulse2 then
			self:SetIcon(args.destName, self.vb.fpIcon)
		end
		self.vb.fpIcon = self.vb.fpIcon + 1
	elseif spellId == 245518 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			local tauntStack = 3
			if self:IsMythic() and self.Options.TauntBehavior == "TwoMythicThreeNon" or self.Options.TauntBehavior == "TwoAlways" then
				tauntStack = 2
			end
			if amount >= tauntStack then--Lasts 30 seconds, unknown reapplication rate, fine tune!
				if args:IsPlayer() then--At this point the other tank SHOULD be clear.
					specWarnFlashfreeze:Show(amount)
					specWarnFlashfreeze:Play("stackhigh")
				else--Taunt as soon as stacks are clear, regardless of stack count.
					local _, _, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
					local remaining
					if expireTime then
						remaining = expireTime-GetTime()
					end
					if not UnitIsDeadOrGhost("player") and (not remaining or remaining and remaining < 9.6) then
						specWarnFlashfreezeOther:Show(args.destName)
						specWarnFlashfreezeOther:Play("tauntboss")
					else
						warnFlashFreeze:Show(args.destName, amount)
					end
				end
			else
				warnFlashFreeze:Show(args.destName, amount)
			end
		end
	elseif spellId == 245586 then --Студеная кровь
		self.vb.chilledCount = self.vb.chilledCount + 1
		if args:IsPlayer() then
			specWarnChilledBlood2:Show()
			specWarnChilledBlood2:Play("targetyou")
		end
		if self.Options.specwarn245586target then
			specWarnChilledBlood:CombinedShow(0.3, args.destName)
		else
			warnChilledBlood:CombinedShow(0.3, args.destName)
		end
		if self.Options.InfoFrame and not DBM.InfoFrame:IsShown() then
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(6, "playerabsorb", args.spellName, select(17, DBM:UnitDebuff(args.destName, args.spellName)))
		end
		if self.Options.SetIconOnChilledBlood2 then
			self:SetIcon(args.destName, self.vb.chilledIcon)
		end
		self.vb.chilledIcon = self.vb.chilledIcon + 1
	elseif spellId == 250757 then
		warnCosmicGlare:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnCosmicGlare:Show()
			specWarnCosmicGlare:Play("targetyou")
			yellCosmicGlare:Yell()
			yellCosmicGlareFades:Countdown(4)
		end
		if self.Options.SetIconOnCosmicGlare then
			self:SetIcon(args.destName, self.vb.glareIcon)
		end
		self.vb.glareIcon = self.vb.glareIcon + 1
	elseif spellId == 249863 then
		if self.Options.NPAuraOnVisageofTitan then
			DBM.Nameplate:Show(true, args.destGUID, spellId, nil, 30)
		end
	elseif spellId == 256356 then --Заморозка
		warnChilledBlood2:CombinedShow(0.3, args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 253520 then
		self.vb.fpIcon = self.vb.fpIcon - 1
		if args:IsPlayer() then
			yellFulminatingPulse:Cancel()
		end
		if self.Options.SetIconOnFulminatingPulse2 then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 245586 then
		self.vb.chilledCount = self.vb.chilledCount - 1
		if self.Options.InfoFrame and self.vb.chilledCount == 0 then
			DBM.InfoFrame:Hide()
		end
		if self.Options.SetIconOnChilledBlood2 then
			self:SetIcon(args.destName, 0)
		end
		self.vb.chilledIcon = self.vb.chilledIcon - 1
	elseif spellId == 249863 then--Bonecage Armor
		if self.Options.NPAuraOnVisageofTitan then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 250757 then
		self.vb.glareIcon = self.vb.glareIcon - 1
		if args:IsPlayer() then
			yellCosmicGlareFades:Cancel()
		end
		if self.Options.SetIconOnCosmicGlare then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 245634 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show()
		specWarnGTFO:Play("runaway")
	elseif spellId == 253020 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO2:Show()
		specWarnGTFO2:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 125837 then--Torment of Amanthul
		self.vb.MachinationsLeft = self.vb.MachinationsLeft - 1
		if self.vb.MachinationsLeft == 0 then
			timerMachinationsofAman:Stop()
		end
	end
end

--"<94.13 21:56:15> [UNIT_SPELLCAST_SUCCEEDED] Diima, Mother of Gloom(??) [[boss3:Torment of Khaz'goroth::3-3779-1712-25990-259066-00119F734F:259066]]", -- [1126]
--"<94.33 21:56:15> [CHAT_MSG_RAID_BOSS_EMOTE] |TInterface\\Icons\\ABILITY_MONK_BREATHOFFIRE:20|tThe Coven prepares to unleash the  |cFFFF0000|Hspell:245671|h[Flames of Khaz'goroth]|h|r!#Diima, Mother of Gloom###
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 259068 or spellId == 259066 or spellId == 259069 or spellId == 259070 then
		local name = UnitName(uId)
		name = string.split(",", name)--Strip title
		specWarnTormentofTitans:Show()
		if spellId == 259068 then--Torment of Aman'Thul
			self.vb.MachinationsLeft = 4
			specWarnTormentofTitans:Play("mobkill")
		elseif spellId == 259066 then--Torment of Khaz'goroth
			specWarnTormentofTitans:Play("runtoedge")
			specWarnTormentofTitans:ScheduleVoice(1, "mobkill")
		elseif spellId == 259069 then--Torment of Norgannon
			specWarnTormentofTitans:Play("watchstep")
		elseif spellId == 259070 then--Torment of Golganneth
			specWarnTormentofTitans:Play("scatter")
			specWarnTormentofTitans:ScheduleVoice(1, "mobkill")
		end
		if not titanCount[name] then
			titanCount[name] = 1
		elseif titanCount[name] then
			titanCount[name] = titanCount[name] + 1
		end
		if titanCount[name] == 2 then
			titanCount[name] = 0
			timerBossIncoming:Start(8.7, name)
		end
		DBM:Debug("UNIT_SPELLCAST_SUCCEEDED fired with: "..name, 2)
	elseif spellId == 250752 then --Космический отблеск
		timerCosmicGlareCD:Start()
	end
end

--"<196.23 00:02:34> [UNIT_TARGETABLE_CHANGED] boss3#true#true#true#Diima, Mother of Gloom#Creature-0-2083-1712-12288-122469-0000111E27#elite#2150947263", -- [1436]
--"<196.23 00:02:34> [UNIT_TARGETABLE_CHANGED] nameplate2#false#false#true#Noura, Mother of Flames#Creature-0-2083-1712-12288-122468-0000111E27#elite#2150947229", -- [1437]
--"<196.23 00:02:34> [UNIT_TARGETABLE_CHANGED] boss2#false#false#true#Noura, Mother of Flames#Creature-0-2083-1712-12288-122468-0000111E27#elite#2150947229", -- [1438]
--"<198.19 00:02:36> [UNIT_SPELLCAST_SUCCEEDED] Noura, Mother of Flames(??) [[boss2:Spectral Army of Norgannon::3-2083-1712-12288-250334-000B1120DC:250334]]", -- [1456]
function mod:UNIT_TARGETABLE_CHANGED(uId)
	local cid = self:GetUnitCreatureId(uId)
	if cid == 122468 then--Noura
		if UnitExists(uId) then
			if self.Options.SpecWarn118212switchcount then
				specWarnActivated:Show(UnitName(uId))
				specWarnActivated:Play("changetarget")
			else
				warnActivated:Show(UnitName(uId))
			end
			DBM:Debug("UNIT_TARGETABLE_CHANGED, Boss Engaging", 2)
			timerWhirlingSaberCD:Start(9)
			timerFieryStrikeCD:Start(11.8)
			if not self:IsEasy() then
				timerFulminatingPulseCD:Start(20.6)
				countdownFulminatingPulse:Start(20.6)
			end
		else
			DBM:Debug("UNIT_TARGETABLE_CHANGED, Boss Leaving", 2)
			timerFieryStrikeCD:Stop()
			timerWhirlingSaberCD:Stop()
			timerFulminatingPulseCD:Stop()
			countdownFulminatingPulse:Cancel()
		end
	elseif cid == 122467 then--Asara
		if UnitExists(uId) then
			if self.Options.SpecWarn118212switchcount then
				specWarnActivated:Show(UnitName(uId))
				specWarnActivated:Play("changetarget")
			else
				warnActivated:Show(UnitName(uId))
			end
			DBM:Debug("UNIT_TARGETABLE_CHANGED, Boss Engaging", 2)
			--TODO, timers, never saw her leave so never saw her return
		else
			DBM:Debug("UNIT_TARGETABLE_CHANGED, Boss Leaving", 2)
			timerShadowBladesCD:Stop()
			timerStormofDarknessCD:Stop()
			countdownStormofDarkness:Cancel()
		end
	elseif cid == 122469 then--Diima
		if UnitExists(uId) then
			if self.Options.SpecWarn118212switchcount then
				specWarnActivated:Show(UnitName(uId))
				specWarnActivated:Play("changetarget")
			else
				warnActivated:Show(UnitName(uId))
			end
			DBM:Debug("UNIT_TARGETABLE_CHANGED, Boss Engaging", 2)
			if self:IsHeroic() or self:IsMythic() then --Выходит дима и в героике всё точно
				timerChilledBloodCD:Start(8)
			else
				timerChilledBloodCD:Start(6.5)
			end
			timerFlashFreezeCD:Start(10.1)
			if not self:IsEasy() then
				if self:IsHeroic() then --в героике всё точно
					timerOrbofFrostCD:Start(30.5)
				else
					timerOrbofFrostCD:Start(30)
				end
			end
		else
			DBM:Debug("UNIT_TARGETABLE_CHANGED, Boss Leaving", 2)
			timerFlashFreezeCD:Stop()
			timerChilledBloodCD:Stop()
			timerOrbofFrostCD:Stop()
		end
	elseif cid == 125436 then--Thu'raya (mythic only)
		if UnitExists(uId) then
			self.vb.touchCosmosCast = 0
			if self.Options.SpecWarn118212switchcount then
				specWarnActivated:Show(UnitName(uId))
				specWarnActivated:Play("changetarget")
			else
				warnActivated:Show(UnitName(uId))
			end
			DBM:Debug("UNIT_TARGETABLE_CHANGED, Boss Engaging", 2)
			timerCosmicGlareCD:Start(5)
		else
			DBM:Debug("UNIT_TARGETABLE_CHANGED, Boss Leaving", 2)
			timerCosmicGlareCD:Stop()
		end
	end
end

function mod:OnSync(msg, firstInterrupt)
	if self:IsLFR() then return end
	if msg == "Three" then
		self.vb.interruptBehavior = "Three"
	elseif msg == "Four" then
		self.vb.interruptBehavior = "Four"
	elseif msg == "Five" then
		self.vb.interruptBehavior = "Five"
	end	
	if firstInterrupt then
		self.vb.ignoreFirstInterrupt = firstInterrupt == "true" and true or false
	end
end
