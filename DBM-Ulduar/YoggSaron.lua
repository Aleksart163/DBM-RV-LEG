local mod	= DBM:NewMod("YoggSaron", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
mod:SetCreatureID(33288)
mod:SetUsedIcons(8, 7, 6, 5, 4, 3, 2, 1)

mod:RegisterCombat("yell", L.YellPull)

mod:RegisterEvents(
	"SPELL_CAST_START 64059 64189 63138",
	"SPELL_CAST_SUCCESS 64144",
	"SPELL_AURA_APPLIED 63802 63830 63881 64126 64125 63138 63894 64167 64163 64465 64152 64153 64156 64157",
	"SPELL_AURA_REMOVED 63894 64167 64163 64152 64153 64156 64157",
	"SPELL_AURA_REMOVED_DOSE 63050",
	"SPELL_SUMMON 62979",
	"UNIT_HEALTH"
)

local warnMadness 					= mod:NewCastAnnounce(64059, 4) --Доведение до помешательства
local warnFervorCast 				= mod:NewCastAnnounce(63138, 3)
local warnSqueeze					= mod:NewTargetAnnounce(64125, 3)
local warnFervor					= mod:NewTargetAnnounce(63138, 4)
local warnDeafeningRoarSoon			= mod:NewPreWarnAnnounce(64189, 5, 3)
local warnGuardianSpawned 			= mod:NewAnnounce("WarningGuardianSpawned", 3, 62979)
local warnCrusherTentacleSpawned	= mod:NewAnnounce("WarningCrusherTentacleSpawned", 2)
local warnSanity 					= mod:NewAnnounce("WarningSanity", 3, 63050)
local warnBrainLink 				= mod:NewTargetAnnounce(63802, 3)
local warnBrainPortalSoon			= mod:NewAnnounce("WarnBrainPortalSoon", 2)
local warnEmpowerSoon				= mod:NewSoonAnnounce(64486, 4)
local warnPhase						= mod:NewPhaseChangeAnnounce(1, nil, nil, nil, nil, nil, 2)
local warnMaladyoftheMind			= mod:NewTargetAnnounce(63830, 4)
local warnDrainingPoison			= mod:NewTargetAnnounce(64152, 3, nil, "PoisonDispeller") --Иссушающий яд
local warnBlackPlague				= mod:NewTargetAnnounce(64153, 3, nil, "DiseaseDispeller") --Черная чума
local warnApathy					= mod:NewTargetAnnounce(64156, 3, nil, "MagicDispeller2") --Апатия
local warnCurseofDoom				= mod:NewTargetAnnounce(64157, 3, nil, "CurseDispeller") --Проклятие рока

local specWarnDrainingPoison		= mod:NewSpecialWarningYou(64152, nil, nil, nil, 2, 3) --Иссушающий яд
local specWarnDrainingPoison2		= mod:NewSpecialWarningYouDispel(64152, "PoisonDispeller", nil, nil, 2, 3) --Иссушающий яд
local specWarnBlackPlague			= mod:NewSpecialWarningYou(64153, nil, nil, nil, 2, 3) --Черная чума
local specWarnBlackPlague2			= mod:NewSpecialWarningYouDispel(64153, "DiseaseDispeller", nil, nil, 2, 3) --Черная чума
local specWarnApathy				= mod:NewSpecialWarningYou(64156, nil, nil, nil, 2, 3) --Апатия
local specWarnApathy2				= mod:NewSpecialWarningYouDispel(64156, "MagicDispeller2", nil, nil, 2, 3) --Апатия
local specWarnCurseofDoom			= mod:NewSpecialWarningYou(64157, nil, nil, nil, 2, 3) --Проклятие рока
local specWarnCurseofDoom2			= mod:NewSpecialWarningYouDispel(64157, "CurseDispeller", nil, nil, 2, 3) --Проклятие рока
local specWarnMaladyoftheMind		= mod:NewSpecialWarningCloseMoveAway(63830, nil, nil, nil, 3, 6) --Душевная болезнь
local specWarnGuardianLow 			= mod:NewSpecialWarning("SpecWarnGuardianLow", false)
local specWarnBrainLink 			= mod:NewSpecialWarningYouRunning(63802, nil, nil, nil, 4, 6) --Схожее мышление
local specWarnSanity 				= mod:NewSpecialWarning("SpecWarnSanity", nil, nil, nil, 5, 6) --Здравомыслие
local specWarnMadnessOutNow			= mod:NewSpecialWarning("SpecWarnMadnessOutNow")
local specWarnBrainPortalSoon		= mod:NewSpecialWarning("specWarnBrainPortalSoon", false)
local specWarnDeafeningRoar			= mod:NewSpecialWarningCast(64189, "SpellCaster", nil, nil, 3, 3) --Оглушающий рев
local specWarnDeafeningRoar2		= mod:NewSpecialWarningSpell(64189, "-SpellCaster", nil, nil, 2, 3) --Оглушающий рев
local specWarnFervor				= mod:NewSpecialWarningYou(63138, nil, nil, nil, 2, 3) --Рвение Сары
local specWarnFervorCast			= mod:NewSpecialWarning("SpecWarnFervorCast", "Melee", nil, nil, 2, 2) --Рвение Сары

local timerFervor					= mod:NewTargetTimer(15, 63138, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Рвение Сары
local brainportal					= mod:NewTimer(20, "NextPortal", nil, nil, nil, 7)
local timerLunaricGaze				= mod:NewCastTimer(4, 64163)
local timerNextLunaricGaze			= mod:NewCDTimer(8.5, 64163)
local timerEmpower					= mod:NewCDTimer(46, 64465)
local timerEmpowerDuration			= mod:NewBuffActiveTimer(10, 64465)
local timerMadness 					= mod:NewCastTimer(60, 64059, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Доведение до помешательства
local timerCastDeafeningRoar		= mod:NewCastTimer(2.3, 64189)
local timerNextDeafeningRoar		= mod:NewNextTimer(30, 64189)
local timerAchieve					= mod:NewAchievementTimer(420, 12396, "TimerSpeedKill", nil, nil, 7)
local enrageTimer					= mod:NewBerserkTimer(900)

local yellMaladyoftheMind			= mod:NewYellMoveAway(63830, nil, nil, nil, "YELL") --Душевная болезнь
local yellSqueeze					= mod:NewYellHelp(64126, nil, nil, nil, "YELL") --Сдавливание
local yellBrainLink					= mod:NewYell(63802, nil, nil, nil, "YELL") --Схожее мышление
local yellDrainingPoison			= mod:NewYellDispel(64152, nil, nil, nil, "YELL") --Иссушающий яд
local yellBlackPlague				= mod:NewYellDispel(64153, nil, nil, nil, "YELL") --Черная чума
local yellApathy					= mod:NewYellDispel(64156, nil, nil, nil, "YELL") --Апатия
local yellCurseofDoom				= mod:NewYellDispel(64157, nil, nil, nil, "YELL") --Проклятие рока

--mod:AddBoolOption("ShowSaraHealth")
mod:AddSetIconOption("SetIconOnFearTarget", 63830, true, false, {8}) --Душевная болезнь
mod:AddSetIconOption("SetIconOnFervorTarget", 63138, true, false, {7}) --Рвение Сары
mod:AddSetIconOption("SetIconOnSqueezeTarget", 64126, true, false, {7}) --Сдавливание
mod:AddSetIconOption("SetIconOnBrainLinkTarget", 63802, true, false, {6, 5}) --Схожее мышление
mod:AddSetIconOption("SetIconOnCurseofDoomTarget", 64157, true, false, {4}) --Проклятие рока
mod:AddSetIconOption("SetIconOnApathyTarget", 64156, true, false, {3}) --Апатия
mod:AddSetIconOption("SetIconOnBlackPlagueTarget", 64153, true, false, {2}) --Черная чума
mod:AddSetIconOption("SetIconOnDrainingPoisonTarget", 64152, true, false, {1}) --Иссушающий яд

mod.vb.phase = 1
local targetWarningsShown			= {}
local brainLinkTargets = {}
local brainLinkIcon = 6
local Guardians = 0

function mod:OnCombatStart(delay)
	Guardians = 0
	self.vb.phase = 1
	enrageTimer:Start()
	timerAchieve:Start()
--[[	if self.Options.ShowSaraHealth and not self.Options.HealthFrame then
		DBM.BossHealth:Show(L.name)
	end
	if self.Options.ShowSaraHealth then
		DBM.BossHealth:AddBoss(33134, L.Sara)
	end]]
	table.wipe(targetWarningsShown)
	table.wipe(brainLinkTargets)
end

function mod:FervorTarget()
	local targetname = self:GetBossTarget(33134)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnFervorCast:Show()
	end
end

function mod:warnBrainLink()
	warnBrainLink:Show(table.concat(brainLinkTargets, "<, >"))
	table.wipe(brainLinkTargets)
	brainLinkIcon = 6
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 64059 then --Доведение до помешательства
		timerMadness:Start()
		warnMadness:Show()
		brainportal:Schedule(60)
		warnBrainPortalSoon:Schedule(78)
		specWarnBrainPortalSoon:Schedule(78)
		specWarnMadnessOutNow:Schedule(55)
	elseif spellId == 64189 then --Оглушающий рев
		timerNextDeafeningRoar:Start()
		warnDeafeningRoarSoon:Schedule(55)
		timerCastDeafeningRoar:Start()
		if self:IsSpellCaster() then
			specWarnDeafeningRoar:Show()
			specWarnDeafeningRoar:Play("stopcast")
		else
			specWarnDeafeningRoar2:Show()
			specWarnDeafeningRoar2:Play("aesoon")
		end
	elseif spellId == 63138 then --Рвение Сары
		self:ScheduleMethod(0.1, "FervorTarget")
		warnFervorCast:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 64144 and self:GetUnitCreatureId(args.sourceGUID) == 33966 then --Извержение
		warnCrusherTentacleSpawned:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 63802 then --Схожее мышление
		self:UnscheduleMethod("warnBrainLink")
		brainLinkTargets[#brainLinkTargets + 1] = args.destName
		if self.Options.SetIconOnBrainLinkTarget then
			self:SetIcon(args.destName, brainLinkIcon, 30)
			brainLinkIcon = brainLinkIcon - 1
		end
		if args:IsPlayer() then
			specWarnBrainLink:Show()
			specWarnBrainLink:Play("gather")
			yellBrainLink:Yell()
		end
		mod:ScheduleMethod(0.2, "warnBrainLink")
	elseif spellId == 63830 or spellId == 63881 then --Душевная болезнь
		if args:IsPlayer() then
			yellMaladyoftheMind:Yell()
		elseif self:CheckNearby(15, args.destName) then
			specWarnMaladyoftheMind:Show(args.destName)
			specWarnMaladyoftheMind:Play("runaway")
		else
			warnMaladyoftheMind:CombinedShow(0.5, args.destName)
		end
		if self.Options.SetIconOnFearTarget then
			self:SetIcon(args.destName, 8, 5) 
		end
	elseif spellId == 64126 or spellId == 64125 then --Сдавливание
		if args:IsPlayer() then
			yellSqueeze:Yell()
		else
			warnSqueeze:Show(args.destName)
		end
		if self.Options.SetIconOnSqueezeTarget then
			self:SetIcon(args.destName, 7, 10) 
		end
	elseif spellId == 63138 then --Рвение Сары
		timerFervor:Start(args.destName)
		if args:IsPlayer() then
			specWarnFervor:Show()
			specWarnFervor:Play("targetyou")
		else
			warnFervor:Show(args.destName)
		end
		if self.Options.SetIconOnFervorTarget then
			self:SetIcon(args.destName, 7, 15)
		end
	elseif spellId == 63894 then --Теневой барьер (начало фазы 2)
		self.vb.phase = 2
		brainportal:Start(60)
		warnBrainPortalSoon:Schedule(57)
		specWarnBrainPortalSoon:Schedule(57)
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase))
		warnPhase:Play("phasechange")
--[[		if self.Options.ShowSaraHealth then
			DBM.BossHealth:RemoveBoss(33134)
			if not self.Options.HealthFrame then
				DBM.BossHealth:Hide()
			end
		end]]
	elseif spellId == 64167 or spellId == 64163 then --Взгляд безумца
		timerLunaricGaze:Start()
	elseif spellId == 64465 then --Маяк тени
		timerEmpower:Start()
		timerEmpowerDuration:Start()
		warnEmpowerSoon:Schedule(40)
	elseif spellId == 64152 then --Иссушающий яд
		if args:IsPlayer() and not self:IsPoisonDispeller() then
			specWarnDrainingPoison:Show()
			specWarnDrainingPoison:Play("targetyou")
			yellDrainingPoison:Yell()
		elseif args:IsPlayer() and self:IsPoisonDispeller() then
			specWarnDrainingPoison2:Show()
			specWarnDrainingPoison2:Play("dispelnow")
			yellDrainingPoison:Yell()
		else
			warnDrainingPoison:CombinedShow(0.3, args.destName)
		end
		if self.Options.SetIconOnDrainingPoisonTarget then
			self:SetIcon(args.destName, 1, 18) 
		end
	elseif spellId == 64153 then --Черная чума
		if args:IsPlayer() and not self:IsDiseaseDispeller() then
			specWarnBlackPlague:Show()
			specWarnBlackPlague:Play("targetyou")
			yellBlackPlague:Yell()
		elseif args:IsPlayer() and self:IsDiseaseDispeller() then
			specWarnBlackPlague2:Show()
			specWarnBlackPlague2:Play("dispelnow")
			yellBlackPlague:Yell()
		else
			warnBlackPlague:CombinedShow(0.3, args.destName)
		end
		if self.Options.SetIconOnBlackPlagueTarget then
			self:SetIcon(args.destName, 2, 24) 
		end
	elseif spellId == 64156 then --Апатия
		if args:IsPlayer() and not self:IsMagicDispeller2() then
			specWarnApathy:Show()
			specWarnApathy:Play("targetyou")
			yellApathy:Yell()
		elseif args:IsPlayer() and self:IsMagicDispeller2() then
			specWarnApathy2:Show()
			specWarnApathy2:Play("dispelnow")
			yellApathy:Yell()
		else
			warnApathy:CombinedShow(0.3, args.destName)
		end
		if self.Options.SetIconOnApathyTarget then
			self:SetIcon(args.destName, 3, 20) 
		end
	elseif spellId == 64157 then --Проклятие рока
		if args:IsPlayer() and not self:IsCurseDispeller() then
			specWarnCurseofDoom:Show()
			specWarnCurseofDoom:Play("targetyou")
			yellCurseofDoom:Yell()
		elseif args:IsPlayer() and self:IsCurseDispeller() then
			specWarnCurseofDoom2:Show()
			specWarnCurseofDoom2:Play("dispelnow")
			yellCurseofDoom:Yell()
		else
			warnCurseofDoom:CombinedShow(0.3, args.destName)
		end
		if self.Options.SetIconOnCurseofDoomTarget then
			self:SetIcon(args.destName, 4, 12) 
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 63894 then --Теневой барьер (начало фазы 3)
		if mod:LatencyCheck() then
			self:SendSync("Phase3")	-- Sync this because you don't get it in your combat log if you are in brain room.
		end
	elseif spellId == 64167 or spellId == 64163 then --Взгляд безумца
		timerNextLunaricGaze:Start()
	elseif spellId == 64152 then --Иссушающий яд
		if self.Options.SetIconOnDrainingPoisonTarget then
			self:RemoveIcon(args.destName)
		end
	elseif spellId == 64153 then --Черная чума
		if self.Options.SetIconOnBlackPlagueTarget then
			self:RemoveIcon(args.destName)
		end
	elseif spellId == 64156 then --Апатия
		if self.Options.SetIconOnApathyTarget then
			self:RemoveIcon(args.destName)
		end
	elseif spellId == 64157 then --Проклятие рока
		if self.Options.SetIconOnCurseofDoomTarget then
			self:RemoveIcon(args.destName)
		end
	end
end

function mod:SPELL_AURA_REMOVED_DOSE(args)
	local spellId = args.spellId
	if spellId == 63050 and args.destGUID == UnitGUID("player") then --Здравомыслие
		if args.amount == 50 then
			warnSanity:Show(args.amount)
		elseif args.amount == 25 or args.amount == 15 or args.amount == 5 then
			warnSanity:Show(args.amount)
			specWarnSanity:Show(args.amount)
		end
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 62979 then --Призыв стража
		Guardians = Guardians + 1
		warnGuardianSpawned:Show(Guardians)
	end
end

function mod:UNIT_HEALTH(uId)
	if self.vb.phase == 1 and uId == "target" and self:GetUnitCreatureId(uId) == 33136 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.3 and not targetWarningsShown[UnitGUID(uId)] then
		targetWarningsShown[UnitGUID(uId)] = true
		specWarnGuardianLow:Show()
	end
end

function mod:OnSync(msg)
	if msg == "Phase3" then
		self.vb.phase = 3
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase))
		warnPhase:Play("phasechange")
		brainportal:Stop()
        timerEmpower:Start()
        warnEmpowerSoon:Schedule(40)	
		warnBrainPortalSoon:Cancel()
		timerNextDeafeningRoar:Start(30)
		warnDeafeningRoarSoon:Schedule(25)
	end
end
