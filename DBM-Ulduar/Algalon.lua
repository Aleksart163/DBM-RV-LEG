local mod	= DBM:NewMod("Algalon", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
mod:SetCreatureID(32871)

mod:RegisterCombat("yell", L.YellPull)
mod:RegisterKill("yell", L.YellKill)
mod:SetWipeTime(20)

mod:RegisterEvents(
	"SPELL_CAST_START 64584 64443",
	"SPELL_CAST_SUCCESS 65108 64122 64598 62301 64412",
	"SPELL_AURA_APPLIED 64412",
	"SPELL_AURA_APPLIED_DOSE 64412",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_HEALTH"
)

---Proshlyapation---
local warnPhasePunch		    = mod:NewStackAnnounce(64412, 1, nil, "Tank|Healer")
local announceBigBang			= mod:NewSpellAnnounce(64584, 4) --Большой взрыв
local warnPhase2				= mod:NewPhaseAnnounce(2)
local warnPhase2Soon			= mod:NewAnnounce("WarnPhase2Soon", 2)
local announcePreBigBang		= mod:NewPreWarnAnnounce(64584, 10, 3) --Большой взрыв
local announceBlackHole			= mod:NewSpellAnnounce(65108, 2)
local announceCosmicSmash		= mod:NewAnnounce("WarningCosmicSmash", 4, 62311)

local specwarnStarLow			= mod:NewSpecialWarning("warnStarLow", "Tank|Healer", nil, nil, 2, 3) --хп звезды
local specWarnPhasePunch		= mod:NewSpecialWarningStack(64412, nil, 3, nil, nil, 3, 3) --Фазовый удар
local specWarnPhasePunch2		= mod:NewSpecialWarningTaunt(64412, "Tank", nil, nil, 3, 3) --Фазовый удар
local specWarnBigBang			= mod:NewSpecialWarningMoveTo(64584, "-Tank", nil, nil, 3, 6) --Большой взрыв
local specWarnBigBang2			= mod:NewSpecialWarningDefensive(64584, "Tank", nil, nil, 5, 6) --Большой взрыв
local specWarnCosmicSmash		= mod:NewSpecialWarningDodge(62311, nil, nil, nil, 2, 3) --Кара небесная

local timerCombatStart		    = mod:NewTimer(7, "TimerCombatStart", 2457)
local timerBigBang				= mod:NewCDCountTimer(90.5, 64584, nil, nil, nil, 7) --Большой взрыв
local timerBigBangCast			= mod:NewCastTimer(8, 64584, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Большой взрыв
local timerNextCollapsingStar	= mod:NewTimer(15, "NextCollapsingStar")
local timerCDCosmicSmash		= mod:NewCDCountTimer(25, 62311, nil, nil, nil, 3, nil, DBM_CORE_HEALER_ICON) --Кара небесная
local timerCastCosmicSmash		= mod:NewCastTimer(4.5, 62311, nil, nil, nil, 2, nil, DBM_CORE_HEALER_ICON)
local timerPhasePunch			= mod:NewBuffActiveTimer(45, 64412, nil, "Tank", nil, 3, nil, DBM_CORE_TANK_ICON)
local timerNextPhasePunch		= mod:NewNextTimer(16, 64412, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_TANK_ICON..DBM_CORE_DEADLY_ICON)
local enrageTimer				= mod:NewBerserkTimer(360)

local countdownBigBang			= mod:NewCountdown(90.5, 64584, nil, nil, 5) --Большой взрыв
local countdownBigBang2			= mod:NewCountdownFades(8, 64584, nil, nil, 5) --Большой взрыв

local warned_preP2 = false
local warned_star = false
local blackHole = DBM:GetSpellInfo(183790) --Черная дыра

mod.vb.MurchalOchkenProshlyapationCount = 0
mod.vb.CosmicCount = 0

function mod:OnCombatStart(delay)
	self.vb.MurchalOchkenProshlyapationCount = 0
	self.vb.CosmicCount = 0
	warned_preP2 = false
	warned_star = false
	local text = select(3, GetWorldStateUIInfo(1)) 
	local _, _, time = string.find(text, L.PullCheck)
	if not time then 
        	time = 60 
    	end
	time = tonumber(time)
	if time == 60 then
		timerCombatStart:Start(26.5-delay)
		self:ScheduleMethod(26.5-delay, "startTimers")	-- 26 seconds roleplaying
	else 
		timerCombatStart:Start(-delay)
		self:ScheduleMethod(8-delay, "startTimers")	-- 8 seconds roleplaying
	end 
end

function mod:startTimers()
	enrageTimer:Start()
	timerBigBang:Start(nil, 1)
	countdownBigBang:Start()
	announcePreBigBang:Schedule(80)
	timerCDCosmicSmash:Start(nil, 1)
	timerNextCollapsingStar:Start()
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 64584 or spellId == 64443 then --Большой взрыв
		self.vb.MurchalOchkenProshlyapationCount = self.vb.MurchalOchkenProshlyapationCount + 1
		timerBigBang:Start(nil, self.vb.MurchalOchkenProshlyapationCount+1)
		countdownBigBang:Start()
		timerBigBangCast:Start()
		countdownBigBang2:Start()
		announceBigBang:Show()
		announcePreBigBang:Schedule(80)
		if self:IsTank() then
			specWarnBigBang2:Show()
			specWarnBigBang2:Play("defensive")
		else
			specWarnBigBang:Show(blackHole)
			specWarnBigBang:Play("justrun")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 65108 or spellId == 64122 then --Взрыв черной дыры
		announceBlackHole:Show()
		warned_star = false
	elseif spellId == 64598 or spellId == 62301 then --Кара небесная
		self.vb.CosmicCount = self.vb.CosmicCount + 1
		timerCastCosmicSmash:Start()
		timerCDCosmicSmash:Start(nil, self.vb.CosmicCount+1)
		announceCosmicSmash:Show()
		specWarnCosmicSmash:Show()
	elseif spellId == 64412 then --Фазовый удар
		timerNextPhasePunch:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 64412 then --Фазовый удар
		local amount = args.amount or 1
        if amount >= 3 then
            if args:IsPlayer() then
                specWarnPhasePunch:Show(args.amount)
                specWarnPhasePunch:Play("stackhigh")
            else
				local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", args.spellName)
				local remaining
				if expireTime then
					remaining = expireTime-GetTime()
				end
				if not UnitIsDeadOrGhost("player") and (not remaining or remaining and remaining < 45) then
					specWarnPhasePunch2:Show(args.destName)
					specWarnPhasePunch2:Play("tauntboss")
				else
					warnPhasePunch:Show(args.destName, amount)
				end
			end
		else	
			warnPhasePunch:Show(args.destName, amount)
			timerPhasePunch:Start(args.destName)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED


function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg == L.Emote_CollapsingStar or msg:find(L.Emote_CollapsingStar) then
		timerNextCollapsingStar:Start()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Phase2 or msg:find(L.Phase2) then
		timerNextCollapsingStar:Cancel()
		warnPhase2:Show()
	end
end

function mod:UNIT_HEALTH(uId)
	if not warned_preP2 and self:GetUnitCreatureId(uId) == 32871 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.23 then
		warned_preP2 = true
		warnPhase2Soon:Show()
		warnPhase2Soon:Play("phasechange")
	elseif not warned_star and self:GetUnitCreatureId(uId) == 32955 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.25 then
		warned_star = true
		specwarnStarLow:Show()
	end
end
