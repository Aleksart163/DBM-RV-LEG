local mod	= DBM:NewMod("Razorscale", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
mod:SetCreatureID(33186)
--mod:SetEncounterID(1139)
mod:SetUsedIcons(7)

--mod:RegisterCombat("combat")
mod:RegisterCombat("yell", L.YellAir)

mod:RegisterEvents(
	"SPELL_CAST_START 64021 63236 64759",
	"SPELL_AURA_APPLIED 62794 64771",
	"SPELL_AURA_APPLIED_DOSE 64771",
	"SPELL_AURA_REMOVED 64771",
	"SPELL_DAMAGE 64733 64704",
	"SPELL_MISSED 64733 64704",
	"CHAT_MSG_MONSTER_YELL",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_HEALTH boss1"
)

local warnPhase2					= mod:NewPrePhaseAnnounce(2, 1)
local warnPhase						= mod:NewPhaseChangeAnnounce(1)
local warnDevouringFlame			= mod:NewTargetAnnounce(63236, 2) --Лавовая бомба
local warnFuseArmor				    = mod:NewStackAnnounce(64771, 1, nil, "Tank|Healer") --Плавящийся доспех
local warnTurretsReadySoon			= mod:NewAnnounce("warnTurretsReadySoon", 1, 48642)
local warnTurretsReady				= mod:NewAnnounce("warnTurretsReady", 2, 48642)
--local warnDevouringFlameCast		= mod:NewAnnounce("WarnDevouringFlameCast", 2, 64733, false, "OptionDevouringFlame") -- new option is just a work-around...the saved variable handling will be updated to allow changing and updating default values soon

local specWarnChainLightning		= mod:NewSpecialWarningInterrupt(64759, "HasInterrupt", nil, nil, 1, 3) --Цепная молния
local specWarnFuseArmor				= mod:NewSpecialWarningStack(64771, nil, 2, nil, nil, 3, 3) --Плавящийся доспех
local specWarnFuseArmor2			= mod:NewSpecialWarningTaunt(64771, "Tank", nil, nil, 3, 3) --Плавящийся доспех
local specWarnHarpooned				= mod:NewSpecialWarningMoreDamage(62794, "-Healer", nil, nil, 3, 2) --Гарпун
local specWarnDevouringFlame		= mod:NewSpecialWarningYou(63236, nil, nil, nil, 1, 2) --Лавовая бомба
local specWarnDevouringFlame2		= mod:NewSpecialWarningYouMove(64733, nil, nil, nil, 1, 2) --Лавовая бомба

local timerDeepBreathCD				= mod:NewCDTimer(21, 64021, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Огненное дыхание
local timerDeepBreathCast			= mod:NewCastTimer(2.5, 64021, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Огненное дыхание
local timerHarpooned				= mod:NewBuffActiveTimer(30, 62794, nil, nil, nil, 3, nil, DBM_CORE_DAMAGE_ICON) --Гарпун
local timerFuseArmor				= mod:NewTargetTimer(20, 64771, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_TANK_ICON..DBM_CORE_DEADLY_ICON)
local timerTurret1					= mod:NewTimer(53, "timerTurret1", 48642, nil, nil, 7) --Запуск гарпуна
local timerTurret2					= mod:NewTimer(73, "timerTurret2", 48642, nil, nil, 7) --Запуск гарпуна
local timerTurret3					= mod:NewTimer(93, "timerTurret3", 48642, nil, nil, 7) --Запуск гарпуна
local timerTurret4					= mod:NewTimer(113, "timerTurret4", 48642, nil, nil, 7) --Запуск гарпуна
local timerGrounded                 = mod:NewTimer(45, "timerGrounded", 241458, nil, nil, 7) --На земле
local enrageTimer					= mod:NewBerserkTimer(900)

local countdownTurret				= mod:NewCountdown(113, 48642, nil, nil, 5) --Запуск гарпуна

mod:AddSetIconOption("SetIconOnDevouringFlame", 63236, true, false, {7})

local combattime = 0
local warned_preP1 = false

mod.vb.phase = 1

function mod:DevouringFlameTarget(targetname, uId) --Лавовая бомба
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnDevouringFlame:Show()
		specWarnDevouringFlame:Play("runout")
	else
		warnDevouringFlame:Show(targetname)
	end
	if self.Options.SetIconOnDevouringFlame then
		self:SetIcon(targetname, 7, 3)
	end
end

function mod:OnCombatStart(delay)
	warned_preP1 = false
	self.vb.phase = 1
	enrageTimer:Start(-delay)
	combattime = GetTime()
	--- Всё прошляпано Мурчалем ---
	warnTurretsReadySoon:Schedule(102-delay)
	warnTurretsReady:Schedule(112-delay)
	timerTurret1:Start(52-delay)
	timerTurret2:Start(72-delay)
	timerTurret3:Start(92-delay)
	timerTurret4:Start(112-delay)
	countdownTurret:Start(112-delay)
end

function mod:OnCombatEnd()
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 64021 then --Огненное дыхание
		timerDeepBreathCast:Start()
		if self.vb.phase == 2 then
			timerDeepBreathCD:Start(16.5)
		end
	elseif spellId == 63236 then --Лавовая бомба
		self:BossTargetScanner(args.sourceGUID, "DevouringFlameTarget", 0.2, 2)
	elseif spellId == 64759 then --Цепная молния
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnChainLightning:Show()
			specWarnChainLightning:Play("kickcast")
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 62794 then --Гарпун
		if not UnitIsDeadOrGhost("player") then
			specWarnHarpooned:Show()
		end
	elseif spellId == 64771 then --Плавящийся доспех
		local amount = args.amount or 1
        if amount >= 2 then
            if args:IsPlayer() then
                specWarnFuseArmor:Show(args.amount)
                specWarnFuseArmor:Play("stackhigh")
            else
				local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", args.spellName)
				local remaining
				if expireTime then
					remaining = expireTime-GetTime()
				end
				if not UnitIsDeadOrGhost("player") and (not remaining or remaining and remaining < 12) then
					specWarnFuseArmor2:Show(args.destName)
					specWarnFuseArmor2:Play("tauntboss")
				else
					warnFuseArmor:Show(args.destName, amount)
				end
			end
		else	
			warnFuseArmor:Show(args.destName, amount)
			timerFuseArmor:Start(args.destName)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 64771 then --Плавящийся доспех
		timerFuseArmor:Stop()
	end
end

function mod:SPELL_DAMAGE(args)
	local spellId = args.spellId
	if (spellId == 64733 or spellId == 64704) and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then --Лавовая бомба
		specWarnDevouringFlame2:Show()
		specWarnDevouringFlame2:Play("runout")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:CHAT_MSG_RAID_BOSS_EMOTE(emote)
	if emote == L.EmotePhase2 or emote:find(L.EmotePhase2) then
		self.vb.phase = 2
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase))
		warnPhase:Play("phasechange")
		timerTurret1:Stop()
		timerTurret2:Stop()
		timerTurret3:Stop()
		timerTurret4:Stop()
		timerGrounded:Stop()
		timerHarpooned:Stop()
		timerDeepBreathCD:Stop()
		countdownTurret:Cancel()
		timerDeepBreathCD:Start(23)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg, mob)
	if (msg == L.YellAir or msg == L.YellAir2) and GetTime() - combattime > 30 then
		warnTurretsReadySoon:Schedule(103)
		warnTurretsReady:Schedule(113)
		timerTurret1:Start()
		timerTurret2:Start()
		timerTurret3:Start()
		timerTurret4:Start()
		countdownTurret:Start()
	elseif msg == L.YellGround then
		timerHarpooned:Start(30)
		timerDeepBreathCD:Start(30)
		timerGrounded:Start(40)
		countdownTurret:Start(40)
	end
end

function mod:UNIT_HEALTH(uId)
	if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 33186 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.61 then
		warned_preP1 = true
		warnPhase2:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
	end
end
