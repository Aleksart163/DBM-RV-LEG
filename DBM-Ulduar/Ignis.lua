local mod	= DBM:NewMod("Ignis", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
mod:SetCreatureID(33118)
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START 62680 63472 62488",
	"SPELL_CAST_SUCCESS 62548 63474",
	"SPELL_AURA_APPLIED 62717 63477 62382 63536",
	"SPELL_AURA_REMOVED 62717 63477"
)

local warnSlagPot				= mod:NewTargetAnnounce(63477, 4) --Шлаковый ковш

local specWarnBrittle			= mod:NewSpecialWarningSwitch2(62382, "SpellCaster", nil, nil, 3, 3) --Ломкость
local specWarnFlameJets			= mod:NewSpecialWarningCast(63472, "SpellCaster", nil, nil, 3, 3) --Струи пламени
local specWarnFlameJets2		= mod:NewSpecialWarningSpell(63472, "-SpellCaster", nil, nil, 2, 3) --Струи пламени
local specWarnSlagImbued		= mod:NewSpecialWarningYouMoreDamage(63536, nil, nil, nil, 3, 2) --Магическая зола

local timerSlagImbued			= mod:NewBuffActiveTimer(10, 63536, nil, nil, nil, 7) --Магическая зола
local timerIronConstructCD		= mod:NewCDCountTimer(30, "ej17250", nil, nil, nil, 1, 64473, DBM_CORE_TANK_ICON..DBM_CORE_DAMAGE_ICON) --Железное создание
local timerFlameJetsCast		= mod:NewCastTimer(2.7, 63472, nil, nil, nil, 7) --Струи пламени
local timerFlameJetsCooldown	= mod:NewCDTimer(35, 63472, nil, nil, nil, 7) --Струи пламени
local timerScorchCooldown		= mod:NewNextTimer(25, 63473, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Ожог
local timerScorchCast			= mod:NewCastTimer(3, 63473, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Ожог
local timerSlagPot				= mod:NewTargetTimer(10, 63477, nil, nil, nil, 7) --Шлаковый ковш
local timerAchieve				= mod:NewAchievementTimer(240, 12325, "TimerSpeedKill", nil, nil, 7)
local enrageTimer				= mod:NewBerserkTimer(600)

local countdownFlameJets		= mod:NewCountdown(35, 63472, nil, nil, 5) --Струи пламени

local yellSlagPot				= mod:NewYellHelp(62717, nil, nil, nil, "YELL") --Шлаковый ковш
local yellSlagPot2				= mod:NewFadesYell(62717, nil, nil, nil, "YELL") --Шлаковый ковш

mod:AddSetIconOption("SlagPotIcon", 62717, true, false, {8})

mod.vb.MurchalOchkenProshlyapationCount = 0

function mod:OnCombatStart(delay)
	self.vb.MurchalOchkenProshlyapationCount = 0
	enrageTimer:Start(-delay)
	timerAchieve:Start(-delay)
	timerFlameJetsCooldown:Start(30-delay) --Струи пламени
	timerIronConstructCD:Start(15-delay, 1) --Железное создание
	timerScorchCooldown:Start(12-delay) --Ожог
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 62680 or spellId == 63472 then --Струи пламени
		timerFlameJetsCast:Start()
		if self:IsSpellCaster() then
			specWarnFlameJets:Show()
			specWarnFlameJets:Play("stopcast")
		else
			specWarnFlameJets2:Show()
			specWarnFlameJets2:Play("aesoon")
		end
		timerFlameJetsCooldown:Start()
		countdownFlameJets:Start()
	elseif spellId == 62488 then --Задействовать создание
		self.vb.MurchalOchkenProshlyapationCount = self.vb.MurchalOchkenProshlyapationCount + 1
		timerIronConstructCD:Start(nil, self.vb.MurchalOchkenProshlyapationCount+1)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 62548 or spellId == 63474 then --Ожог
		timerScorchCast:Start()
		timerScorchCooldown:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 62717 or spellId == 63477 then --Шлаковый ковш
		timerSlagPot:Start(args.destName)
		if args:IsPlayer() then
			yellSlagPot:Yell()
			yellSlagPot2:Countdown(10, 3)
		else
			warnSlagPot:Show(args.destName)
		end
		if self.Options.SlagPotIcon then
			self:SetIcon(args.destName, 8)
		end
	elseif spellId == 62382 then --Ломкость
		if self:AntiSpam(3, "brittle") then
			specWarnBrittle:Show(args.destName)
			specWarnBrittle:Play("killmob")
		end
	elseif spellId == 63536 then --Магическая зола
		if args:IsPlayer() then
			specWarnSlagImbued:Show()
			timerSlagImbued:Start()
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 62717 or spellId == 63477 then --Шлаковый ковш
		timerSlagPot:Stop()
		if args:IsPlayer() then
			yellSlagPot2:Cancel()
		end
		if self.Options.SlagPotIcon then
			self:RemoveIcon(args.destName)
		end
	end
end
