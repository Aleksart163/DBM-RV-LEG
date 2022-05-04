local mod	= DBM:NewMod(1838, "DBM-Party-Legion", 11, 860)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(114790)
mod:SetEncounterID(2017)
mod:SetZone()
mod:SetUsedIcons(1, 2, 3)
--mod:SetHotfixNoticeRev(14922)
--mod.respawnTime = 30

mod.noNormal = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 229151 229083 230084",
	"SPELL_CAST_SUCCESS 229610",
	"SPELL_AURA_APPLIED 229159 229241",
	"SPELL_AURA_REMOVED 229159",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_HEALTH boss1",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO: Burning Blast INterrupt helper. Figure out CD, then what to do with it
--TODO: figure out what to do with Felguard Sentry (115730)
--ALL
local warnChaoticShadows			= mod:NewTargetAnnounce(229159, 3) --Тени Хаоса
local warnFelBeam					= mod:NewTargetNoFilterAnnounce(229242, 4) --Приказ: луч Скверны
local warnDisintegrate				= mod:NewSpellAnnounce(229151, 4) --Расщепление	Switch to special warning if target scanning works
local warnPhase						= mod:NewAnnounce("Phase1", 1, "Interface\\Icons\\Spell_Nature_WispSplode") --Скоро фаза 2
local warnPhase2					= mod:NewAnnounce("Phase2", 1, "Interface\\Icons\\Spell_Nature_WispSplode") --Скоро фаза 3
local warnPhase22					= mod:NewPhaseAnnounce(2, 2)
local warnPhase33					= mod:NewPhaseAnnounce(3, 2)

--ALL
local specWarnChaoticShadows		= mod:NewSpecialWarningYou(229159, nil, nil, nil, 1, 2) --Тени Хаоса
local specWarnChaoticShadows2		= mod:NewSpecialWarningYouMoveAway(229159, nil, nil, nil, 3, 5) --Тени Хаоса
local specWarnBurningBlast			= mod:NewSpecialWarningInterruptCount(229083, "HasInterrupt", nil, nil, 1, 2) --Выброс пламени
--Phase 1
local specWarnFelBeam				= mod:NewSpecialWarningYouMoveAway(229242, nil, nil, nil, 4, 5) --Приказ: луч Скверны
--ALL
local timerChaoticShadowsCD			= mod:NewCDTimer(30, 229159, nil, nil, nil, 3) --Тени Хаоса
local timerDisintegrateCD			= mod:NewCDTimer(10.8, 229151, nil, nil, nil, 3) --Расщепление
--Phase 1
local timerFelBeamCD				= mod:NewCDTimer(40, 229242, 219084, nil, nil, 3) --Приказ: луч Скверны
local timerBombardmentCD			= mod:NewCDTimer(25, 229284, 229287, nil, nil, 3) --Приказ: бомбардировка
local timerStabilizeRiftCD			= mod:NewCDTimer(25, 230084, nil, nil, nil, 1) --Стабилизация разлома
local timerStabilizeRift			= mod:NewCastTimer(30, 230084, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON) --Стабилизация разлома

local yellFelBeam					= mod:NewYell(229242, nil, nil, nil, "YELL") --Приказ: луч Скверны
local yellChaoticShadows			= mod:NewPosYell(229159, DBM_CORE_AUTO_YELL_CUSTOM_POSITION, nil, nil, "YELL") --Тени Хаоса
local yellChaoticShadows2			= mod:NewFadesYell(229159, nil, nil, nil, "YELL") --Тени Хаоса

--local berserkTimer					= mod:NewBerserkTimer(300)

--local countdownFocusedGazeCD		= mod:NewCountdown(40, 198006)

mod:AddSetIconOption("SetIconOnShadows", 229159, true, false, {3, 2, 1}) --Тени Хаоса
mod:AddRangeFrameOption(6, 230066) --Флегма тьмы
--mod:AddInfoFrameOption(198108, false)

mod.vb.phase = 1
mod.vb.kickCount = 0
local chaoticShadowsTargets = {}
local laserWarned = false
local warned_preP1 = false
local warned_preP2 = false
local warned_preP3 = false
local warned_preP4 = false

local function breakShadows(self)
	warnChaoticShadows:Show(table.concat(chaoticShadowsTargets, "<, >"))
	table.wipe(chaoticShadowsTargets)
end

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.kickCount = 0
	laserWarned = false
	warned_preP1 = false
	warned_preP2 = false
	warned_preP3 = false
	warned_preP4 = false
	table.wipe(chaoticShadowsTargets)
	--These timers seem to vary about 1-2 sec
	timerFelBeamCD:Start(5.2-delay)
	timerDisintegrateCD:Start(10.8-delay)
	timerChaoticShadowsCD:Start(15.5-delay)
	timerBombardmentCD:Start(25.5-delay)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 229151 then
		warnDisintegrate:Show()
		timerDisintegrateCD:Show()
	elseif spellId == 229083 then--Burning Blast
		if self.vb.kickCount == 2 then self.vb.kickCount = 0 end
		self.vb.kickCount = self.vb.kickCount + 1
		local kickCount = self.vb.kickCount
		specWarnBurningBlast:Show(args.sourceName, kickCount)
		if kickCount == 1 then
			specWarnBurningBlast:Play("kick1r")
		elseif kickCount == 2 then
			specWarnBurningBlast:Play("kick2r")
		end
	elseif spellId == 230084 then ----Стабилизация разлома
		timerStabilizeRift:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 229610 then--Demonic Portal (both times or just once?)
		self.vb.phase = self.vb.phase + 1
		self.vb.kickCount = 0
		--Cancel stuff
		timerDisintegrateCD:Stop()
		timerChaoticShadowsCD:Stop()
		timerBombardmentCD:Stop()
		if self.vb.phase == 2 then
			warnPhase22:Show()
			warned_preP2 = true
			timerFelBeamCD:Stop()
			--Variable based on how long it takesto engage boss
			--timerDisintegrateCD:Start(15)--Cast when boss engaged
			timerDisintegrateCD:Start(15)
		--	timerBombardmentCD:Start(41)
		--	timerChaoticShadowsCD:Start(45)
		elseif self.vb.phase == 3 then
			warnPhase33:Show()
			warned_preP4 = true
			--Variable based on how long it takesto engage boss
		--	timerChaoticShadowsCD:Start(41)
			timerStabilizeRiftCD:Start(20.5)
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(6)
			end
		end
	elseif spellId == 230084 then--Stabilize Rift
		DBM:Debug("THE RIFT")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 229159 then
		local name = args.destName
		if not tContains(chaoticShadowsTargets, name) then
			chaoticShadowsTargets[#chaoticShadowsTargets+1] = name
		end
		local count = #chaoticShadowsTargets
		self:Unschedule(breakShadows)
		--TODO, when phase detection is working, Improve this
		if count == 3 then
			breakShadows(self)
		else
			self:Schedule(1, breakShadows, self)
		end
		if args:IsPlayer() then
			specWarnChaoticShadows:Show()
			specWarnChaoticShadows:Play("runout")
			specWarnChaoticShadows2:Schedule(5)
			yellChaoticShadows:Yell(count, args.spellName, count)
			yellChaoticShadows2:Countdown(10, 3)
		end
		if self.Options.SetIconOnShadows then
			self:SetIcon(name, count)
		end
	elseif spellId == 229241 then
		timerFelBeamCD:Start()
		if args:IsPlayer() then
			specWarnFelBeam:Show()
			specWarnFelBeam:Play("justrun")
			specWarnFelBeam:ScheduleVoice(1, "keepmove")
			yellFelBeam:Yell()
		else
			warnFelBeam:Show(args.destName)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 229159 then
		if args:IsPlayer() then
			specWarnChaoticShadows2:Cancel()
			yellChaoticShadows2:Cancel()
		end
		if self.Options.SetIconOnShadows then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 229284 then--Bombardment (more reliable than auras, which can be fickle and apply/remove multiple times
		timerBombardmentCD:Start()
	end
end

function mod:UNIT_HEALTH(uId)
	if self:IsHard() then --миф и миф+
		if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 114790 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.68 then
			warned_preP1 = true
			warnPhase:Show()
		elseif self.vb.phase == 2 and warned_preP2 and not warned_preP3 and self:GetUnitCreatureId(uId) == 114790 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.35 then
			warned_preP3 = true
			warnPhase2:Show()
		end
	end
end
