local mod	= DBM:NewMod("Thorim", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
mod:SetCreatureID(32865)
mod:SetUsedIcons(8)

mod:RegisterCombat("yell", L.YellPhase1)
mod:RegisterKill("yell", L.YellKill)

mod:RegisterEvents(
	"SPELL_CAST_START 62042 62016 64390",
	"SPELL_CAST_SUCCESS 62042 62466 62130 62580",
	"SPELL_AURA_APPLIED 62042 62130 62526 62527 62279 62507",
	"SPELL_AURA_APPLIED_DOSE 62279",
	"SPELL_AURA_REMOVED 62130",
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_DAMAGE 62017"
)

local warnFrostboltVolley		= mod:NewSpellAnnounce(62580, 4) --Залп ледяных стрел
local warnTouchDominion			= mod:NewTargetSourceAnnounce2(62507, 2) --Прикосновение власти
local warnChainLightning		= mod:NewTargetAnnounce(64390, 4) --Цепная молния
local warnLightningCharge		= mod:NewStackAnnounce(62279, 2) --Разряд молнии
local warnStormhammer2			= mod:NewSpellAnnounce(62042, 2)
local warnChargeOrb				= mod:NewCastAnnounce(62016, 4) --Заряженный шар
local warnPhase2				= mod:NewPhaseAnnounce(2, 1)
local warnStormhammer			= mod:NewTargetAnnounce(62470, 2)
local warnUnbalancingStrike		= mod:NewTargetAnnounce(62130, 4)	-- nice blizzard, very new stuff, hmm or not? ^^ aq40 4tw :)
local warningBomb				= mod:NewTargetAnnounce(62526, 4)

local specWarnOrb				= mod:NewSpecialWarningMove(62017)
local specWarnUnbalancingStrike	= mod:NewSpecialWarningYou(62130, nil, nil, nil, 5, 6) --Дисбалансирующий удар
local specWarnUnbalancingStrike2 = mod:NewSpecialWarningTaunt(62130, "Tank", nil, nil, 3, 6) --Дисбалансирующий удар
local specWarnLightningCharge	= mod:NewSpecialWarningDodgeCount(62466, nil, nil, nil, 1, 5) --Разряд молнии
local specWarnLightningCharge2	= mod:NewSpecialWarningSoon(62466, nil, nil, nil, 2, 3) --Разряд молнии

local timerFrostboltVolley		= mod:NewCDTimer(25, 62580, nil, nil, nil, 2, nil, DBM_CORE_HEALER_ICON..DBM_CORE_MAGIC_ICON) --Залп ледяных стрел
local timerChainLightningCD		= mod:NewCDTimer(30, 64390, nil, nil, nil, 3, nil) --Цепная молния
local timerStormhammerCD		= mod:NewCDTimer(17, 62042, nil, nil, nil, 3, nil)
local timerChargeOrbCD			= mod:NewCDTimer(17.5, 62016, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
local timerLightningChargeCD	= mod:NewCDCountTimer(16, 62466, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Разряд молнии
local timerUnbalancingStrikeCD	= mod:NewCDCountTimer(25.5, 62130, nil, "Tank|Healer", nil, 3, nil, DBM_CORE_TANK_ICON..DBM_CORE_DEADLY_ICON) --Дисбалансирующий удар
local timerUnbalancingStrike	= mod:NewTargetTimer(15, 62130, nil, "Tank", nil, 3, nil, DBM_CORE_DEADLY_ICON) --Дисбалансирующий удар
--local timerStormhammer			= mod:NewCastTimer(16.5, 62042)
local timerHardmode				= mod:NewAchievementTimer(111, 12351, "TimerSpeedKill", nil, nil, 7)
local enrageTimer				= mod:NewBerserkTimer(369)

local yellUnbalancingStrike		= mod:NewYell(62130, nil, nil, nil, "YELL") --Дисбалансирующий удар
local yellChainLightning		= mod:NewYell(64390, nil, nil, nil, "YELL") --Цепная молния

mod:AddSetIconOption("SetIconOnUnbalancingStrike", 62130, true, false, {8})
mod:AddBoolOption("RangeFrame")

local Hardmode = false
mod.vb.MurchalOchkenProshlyapationCount = 0
mod.vb.strikeCount = 0

function mod:MurchalProshlyapationTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		yellChainLightning:Yell()
	else
		warnChainLightning:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	Hardmode = false
	self.vb.MurchalOchkenProshlyapationCount = 0
	self.vb.strikeCount = 0
	enrageTimer:Start()
	timerHardmode:Start()
	timerChargeOrbCD:Start(32-delay)
	timerStormhammerCD:Start(42-delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(10)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 62042 then
		warnStormhammer2:Show()
		timerStormhammerCD:Start()
	elseif spellId == 62016 then --Заряженный шар
		warnChargeOrb:Show()
		timerChargeOrbCD:Start()
	elseif spellId == 64390 then --Цепная молния
		self:BossTargetScanner(args.sourceGUID, "MurchalProshlyapationTarget", 0.1, 2)
	--	timerChainLightningCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 62042 then --Молот бури
	elseif spellId == 62466 then --Разряд молнии
		self.vb.MurchalOchkenProshlyapationCount = self.vb.MurchalOchkenProshlyapationCount + 1
		specWarnLightningCharge:Show(self.vb.MurchalOchkenProshlyapationCount)
		specWarnLightningCharge:Play("watchstep")
		specWarnLightningCharge2:Schedule(11)
		specWarnLightningCharge2:ScheduleVoice(11, "specialsoon")
		timerLightningChargeCD:Start(nil, self.vb.MurchalOchkenProshlyapationCount+1)
	elseif spellId == 62130 then --Дисбалансирующий удар
		self.vb.strikeCount = self.vb.strikeCount + 1
		timerUnbalancingStrikeCD:Start(nil, self.vb.strikeCount+1)
	elseif spellId == 62580 then --Залп ледяных стрел
		warnFrostboltVolley:Show()
	--	timerFrostboltVolley:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 62042 then --Молот бури
		warnStormhammer:Show(args.destName)
	elseif spellId == 62130 then --Дисбалансирующий удар
		if args:IsPlayer() then
			specWarnUnbalancingStrike:Show()
			specWarnUnbalancingStrike:Play("stackhigh")
			yellUnbalancingStrike:Yell()
		else
			local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", args.spellName)
			local remaining
			if expireTime then
				remaining = expireTime-GetTime()
			end
			if not UnitIsDeadOrGhost("player") and (not remaining or remaining and remaining < 5) then
				specWarnUnbalancingStrike2:Show(args.destName)
				specWarnUnbalancingStrike2:Play("tauntboss")
			else
				warnUnbalancingStrike:Show(args.destName)
			end
			timerUnbalancingStrike:Start(args.destName)
		end
		if self.Options.SetIconOnUnbalancingStrike then
			self:SetIcon(args.destName, 8)
		end
	elseif spellId == 62526 or spellId == 62527 then --Взрыв руны
		self:SetIcon(args.destName, 8, 5)
		warningBomb:Show(args.destName)
	elseif spellId == 62279 then --Разряд молнии
		local amount = args.amount or 1
		if amount % 2 == 0 then
			warnLightningCharge:Show(args.destName, amount)
		end
	elseif spellId == 62507 then --Прикосновение власти
		warnTouchDominion:Show(args.sourceName, args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 62130 then --Дисбалансирующий удар
		if args:IsPlayer() then
			timerUnbalancingStrike:Stop()
		end
		if self.Options.SetIconOnUnbalancingStrike then
			self:RemoveIcon(args.destName)
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellPhase2 and mod:LatencyCheck() then
		self:SendSync("Phase2")
	end
end

local spam = 0
function mod:SPELL_DAMAGE(args)
	local spellId = args.spellId
	if spellId == 62017 then --Поражение громом
		if bit.band(args.destFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) ~= 0
		and bit.band(args.destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0
		and GetTime() - spam > 5 then
			spam = GetTime()
			specWarnOrb:Show()
		end
	end
end

function mod:OnSync(event, arg)
	if event == "Phase2" then
		if timerHardmode:GetTime() > 0 then
			Hardmode = true
		end
		warnPhase2:Show()
		warnPhase2:Play("phasechange")
		enrageTimer:Stop()
		timerHardmode:Stop()
		timerChargeOrbCD:Stop()
		timerStormhammerCD:Stop()
		timerUnbalancingStrikeCD:Start(26.3, 1)
		specWarnLightningCharge2:Schedule(31.5)
		specWarnLightningCharge2:ScheduleVoice(31.5, "specialsoon")
		timerLightningChargeCD:Start(36.5, 1)
		timerChainLightningCD:Start(30.3)
		enrageTimer:Start(300)
		if Hardmode then
			timerFrostboltVolley:Start(24.8)
		end
	end
end
