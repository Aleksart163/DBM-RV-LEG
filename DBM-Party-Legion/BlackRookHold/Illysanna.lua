local mod	= DBM:NewMod(1653, "DBM-Party-Legion", 1, 740)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
mod:SetCreatureID(98696)
mod:SetEncounterID(1833)
mod:SetZone()
mod:SetUsedIcons(8, 7, 3, 2, 1)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 197478 197687 197546",
	"SPELL_AURA_REMOVED 197478 197687",
	"SPELL_CAST_START 197418 197546 197974 197797",
	"SPELL_CAST_SUCCESS 197478",
	"SPELL_PERIODIC_DAMAGE 197521 197821",
	"SPELL_PERIODIC_MISSED 197521 197821",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--Иллисанна Гребень Ворона
local warnBrutalGlaive				= mod:NewTargetAnnounce(197546, 3) --Жуткая глефа
local warnDarkRush					= mod:NewTargetAnnounce(197478, 3) --Темный рывок
local warnEyeBeam					= mod:NewTargetAnnounce(197687, 4) --Пронзающий взгляд
local warnArcaneBlitz				= mod:NewCastAnnounce(197797, 4) --Чародейская бомбардировка

local specWarnSummonAdds			= mod:NewSpecialWarningSwitch(245546, "Tank|Dps", nil, nil, 1, 2) --Вызов помощников
local specWarnArcaneBlitz			= mod:NewSpecialWarningInterrupt(197797, "HasInterrupt", nil, nil, 1, 2) --Чародейская бомбардировка
local specWarnBonebreakingStrike	= mod:NewSpecialWarningDodge(197974, "Melee", nil, nil, 2, 2) --Костедробящий удар
local specWarnFelblazedGround		= mod:NewSpecialWarningYouMove(197821, nil, nil, nil, 1, 3) --Отпечаток пламени Скверны
local specWarnBlazingTrail			= mod:NewSpecialWarningYouMove(197521, nil, nil, nil, 1, 3) --Огненный след
local specWarnBrutalGlaive			= mod:NewSpecialWarningYouMoveAway(197546, nil, nil, nil, 4, 6) --Жуткая глефа
local specWarnBrutalGlaive2			= mod:NewSpecialWarningCloseMoveAway(197546, nil, nil, nil, 2, 5) --Жуткая глефа
local specWarnBrutalGlaive3			= mod:NewSpecialWarningYouDefensive(197546, "-Tank", nil, nil, 5, 6) --Жуткая глефа
local specWarnVengefulShear			= mod:NewSpecialWarningYouDefensive(197418, "Tank", nil, nil, 3, 6) --Мстительное рассечение
local specWarnDarkRush				= mod:NewSpecialWarningYouRunning(197478, nil, nil, nil, 1, 2) --Темный рывок
local specWarnEyeBeam				= mod:NewSpecialWarningYouRun(197687, nil, nil, nil, 4, 6) --Пронзающий взгляд

local timerBrutalGlaiveCD			= mod:NewCDTimer(15, 197546, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON..DBM_CORE_HEALER_ICON) --Жуткая глефа +++
local timerVengefulShearCD			= mod:NewCDTimer(11, 197418, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON..DBM_CORE_DEADLY_ICON) --Мстительное рассечение 11-16
local timerDarkRushCD				= mod:NewCDTimer(30, 197478, nil, nil, nil, 7) --Темный рывок
local timerEyeBeam					= mod:NewCastTimer(44.5, 197696, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Пронзающий взгляд
local timerEyeBeamCD				= mod:NewNextTimer(103, 197696, nil, nil, nil, 6, nil, DBM_CORE_DEADLY_ICON) --Пронзающий взгляд

local yellBrutalGlaive				= mod:NewYellMoveAway(197546, nil, nil, nil, "YELL") --Жуткая глефа
local yellEyeBeam					= mod:NewYell(197687, nil, nil, nil, "YELL") --Пронзающий взгляд
local yellDarkRush					= mod:NewYell(197478, nil, nil, nil, "YELL") --Темный рывок

local countdownEyeBeam				= mod:NewCountdown(103, 197696, nil, nil, 5) --Пронзающий взгляд
local countdownEyeBeam2				= mod:NewCountdownFades("Alt44.5", 197696, nil, nil, 5) --Пронзающий взгляд

mod:AddSetIconOption("SetIconOnEyeBeam", 197687, true, false, {8}) --Пронзающий взгляд
mod:AddSetIconOption("SetIconOnBrutalGlaive", 197546, true, false, {7}) --Жуткая глефа
mod:AddSetIconOption("SetIconOnDarkRush", 197478, true, false, {3, 2, 1}) --Темный рывок

mod.vb.phase = 1

function mod:BrutalGlaiveTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnBrutalGlaive:Show()
		specWarnBrutalGlaive:Play("runout")
		yellBrutalGlaive:Yell()
	elseif self:CheckNearby(10, targetname) then
		specWarnBrutalGlaive2:Show(targetname)
		specWarnBrutalGlaive2:Play("runout")
	else
		warnBrutalGlaive:Show(targetname)
	end
	if self.Options.SetIconOnBrutalGlaive then
		self:SetIcon(targetname, 7, 15)
	end
end

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	if self:IsHard() then
		timerBrutalGlaiveCD:Start(6-delay) --Жуткая глефа +++
		timerVengefulShearCD:Start(9-delay) --Мстительное рассечение +++
		timerDarkRushCD:Start(13-delay) --Темный рывок +++
		timerEyeBeamCD:Start(38.5-delay) --Пронзающий взгляд +++
		countdownEyeBeam:Start(38.5-delay) --Пронзающий взгляд +++
	elseif self:IsHeroic() then
		timerBrutalGlaiveCD:Start(6.5-delay) --Жуткая глефа+++
		timerVengefulShearCD:Start(9.5-delay) --Мстительное рассечение+++
		timerDarkRushCD:Start(12.5-delay) --Темный рывок+++
		timerEyeBeamCD:Start(53-delay) --Пронзающий взгляд+++
		countdownEyeBeam:Start(53-delay) --Пронзающий взгляд+++
	else
		timerBrutalGlaiveCD:Start(5.5-delay) --Жуткая глефа
		timerVengefulShearCD:Start(8-delay) --Мстительное рассечение
		timerDarkRushCD:Start(12.1-delay) --Темный рывок
		timerEyeBeamCD:Start(40-delay) --Пронзающий взгляд
		countdownEyeBeam:Start(40-delay) --Пронзающий взгляд +++
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 197418 then
		specWarnVengefulShear:Show()
		specWarnVengefulShear:Play("defensive")
		timerVengefulShearCD:Start()
	elseif spellId == 197546 then
		timerBrutalGlaiveCD:Start()
		self:BossTargetScanner(args.sourceGUID, "BrutalGlaiveTarget", 0.1, 2)
	elseif spellId == 197974 then
		if not UnitIsDeadOrGhost("player") then
			specWarnBonebreakingStrike:Show()
			specWarnBonebreakingStrike:Play("shockwave")
		end
	elseif spellId == 197797 then --Чародейская бомбардировка
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnArcaneBlitz:Show()
			specWarnArcaneBlitz:Play("kickcast")
		else
			warnArcaneBlitz:Show()
			warnArcaneBlitz:Play("kickcast")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 197478 then --Темный рывок
		if self:IsHard() then
			timerDarkRushCD:Start(31)
		else
			timerDarkRushCD:Start()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 197478 then --Темный рывок
		warnDarkRush:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnDarkRush:Show()
			specWarnDarkRush:Play("targetyou")
			yellDarkRush:Yell()
		end
		if self.Options.SetIconOnDarkRush then
			self:SetAlphaIcon(0.5, args.destName, 3)
		end
	elseif spellId == 197687 then --Пронзающий взгляд
		if args:IsPlayer() then
			specWarnEyeBeam:Show()
			specWarnEyeBeam:Play("laserrun")
			yellEyeBeam:Yell()
		else
			warnEyeBeam:Show(args.destName)
		end
		if self.Options.SetIconOnEyeBeam then
			self:SetIcon(args.destName, 8, 12)
		end
	elseif spellId == 197546 then --Жуткая глефа
		warnBrutalGlaive:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnBrutalGlaive3:Show()
			specWarnBrutalGlaive3:Play("defensive")
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 197478 and self.Options.SetIconOnDarkRush then --Темный рывок
		self:SetIcon(args.destName, 0)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 197521 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		if self:IsHard() then
			specWarnBlazingTrail:Show()
			specWarnBlazingTrail:Play("runaway")
		end
	elseif spellId == 197821 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		if self:IsHard() then
			specWarnFelblazedGround:Show()
			specWarnFelblazedGround:Play("runaway")
		end
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 197622 then --Прыжок на фазу 2
		self.vb.phase = self.vb.phase + 1
		if not UnitIsDeadOrGhost("player") then
			specWarnSummonAdds:Show()
			specWarnSummonAdds:Play("mobkill")
		end
		timerBrutalGlaiveCD:Stop()
		timerVengefulShearCD:Stop()
		timerDarkRushCD:Stop()
		timerEyeBeamCD:Stop()
		if self:IsHard() then
			timerEyeBeam:Start()
			countdownEyeBeam2:Start()
		end
	elseif spellId == 197394 then --реген энергии
		if self.vb.phase >= 2 then
			timerEyeBeam:Stop()
			countdownEyeBeam2:Cancel()
			timerBrutalGlaiveCD:Start(4)
			timerDarkRushCD:Start(11)
			timerVengefulShearCD:Start(7.5)
			timerEyeBeamCD:Start()
			countdownEyeBeam:Start()
		end
	end
end
