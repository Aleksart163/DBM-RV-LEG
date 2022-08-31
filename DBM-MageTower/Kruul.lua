local mod	= DBM:NewMod("Kruul", "DBM-MageTower", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(117933, 117198) --Инквизитор Варисс, Верховный лорд Круул
mod:SetZone()
mod:SetBossHPInfoToHighest()
mod.soloChallenge = true
mod.onlyNormal = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 234423 233473 234631 241717 236537 236572 234676",
	"SPELL_CAST_SUCCESS 236572",
	"SPELL_AURA_APPLIED 234422 234423",
	"SPELL_AURA_APPLIED_DOSE 234422",
	"SPELL_SUMMON 234428",
	"SPELL_PERIODIC_DAMAGE 234675",
	"SPELL_PERIODIC_MISSED 234675",
	"UNIT_HEALTH",
	"UNIT_DIED"
)

--Прошляпанное очко Мурчаля ✔ Верховный лорд Круул
local warnDrainLife				= mod:NewTargetAnnounce(234423, 3) --Похищение жизни
local warnPhase					= mod:NewPhaseChangeAnnounce(1)
local warnPhase2				= mod:NewPrePhaseAnnounce(2, 1)
--Tank (Kruul)
local warnHolyWard				= mod:NewCastAnnounce(233473, 1) --Священный оберег
local warnDecay					= mod:NewStackAnnounce(234422, 4) --Аура разложения
--Мобы
local warnTormentingEye			= mod:NewSpellAnnounce(234428, 2) --Призыв истязающего глаза
--local warnNetherAberration		= mod:NewSpellAnnounce(235110, 2) --Аберрация Пустоты
local warnInfernal				= mod:NewSpellAnnounce(235112, 3, 157898) --Призыв тлеющего инфернала

local specWarnDecay				= mod:NewSpecialWarningStack(234422, nil, 5, nil, nil, 1, 5) --Аура разложения
local specWarnDrainLife			= mod:NewSpecialWarningInterrupt(234423, nil, nil, 2, 3, 2) --Похищение жизни
local specWarnSmash				= mod:NewSpecialWarningDodge(234631, nil, nil, nil, 2, 2) --Мощный удар
local specWarnAnnihilate		= mod:NewSpecialWarningDefensive(236572, nil, nil, nil, 3, 3) --Аннигиляция
local specWarnNetherstomp		= mod:NewSpecialWarningYouMove(234675, nil, nil, nil, 3, 3) --Растаптывание Пустоты

local timerDrainLifeCD			= mod:NewCDTimer(24.3, 234423, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON) --Похищение жизни
local timerHolyWardCD			= mod:NewCDTimer(60, 233473, nil, nil, nil, 3, nil, DBM_CORE_HEALER_ICON) --Священный оберег
local timerHolyWard				= mod:NewCastTimer(8, 233473, nil, false, nil, 3, nil, DBM_CORE_HEALER_ICON) --Священный оберег
local timerTormentingEyeCD		= mod:NewCDTimer(15.4, 234428, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON) --Призыв истязающего глаза
local timerInfernalCD			= mod:NewCDTimer(75, 235112, nil, nil, nil, 1, 157898, DBM_CORE_DAMAGE_ICON..DBM_CORE_DEADLY_ICON) --Призыв тлеющего инфернала
--Phase 2
local timerAnnihilateCD			= mod:NewCDCountTimer(40, 236572, nil, nil, nil, 3, nil, DBM_CORE_TANK_ICON..DBM_CORE_DEADLY_ICON) --Аннигиляция

local countdownInfernal			= mod:NewCountdown(74.5, 235112, nil, nil, 5) --Призыв тлеющего инфернала
local countdownDrainLife		= mod:NewCountdown("Alt24", 234423, nil, nil, 5) --Похищение жизни

mod.vb.phase = 1
mod.vb.annihilateCast = 0
local activeBossGUIDS = {}
local warned_preP1 = false
local firstAnnihilate = false

function mod:OnCombatStart(delay)
	warned_preP1 = false
	firstAnnihilate = false
	self.vb.phase = 1
	self.vb.annihilateCast = 0
	timerTormentingEyeCD:Start(11.5) --Призыв истязающего глаза+++
	timerDrainLifeCD:Start(11.5) --Похищение жизни+++
	countdownDrainLife:Start(11.5) --Похищение жизни+++
	timerHolyWardCD:Start(60) --Священный оберег
	timerInfernalCD:Start(44.5) --Призыв тлеющего инфернала
	countdownInfernal:Start(44.5) --Призыв тлеющего инфернала
	self:ScheduleMethod(44.5, "Infernal") --Призыв тлеющего инфернала
	DBM:AddMsg("Есть вероятность, что таймеры при начале боя будут включаться, если только вы сами ударите Варисса. Не медлите и вступайте в бой скорее, от этого зависит их точность.")
end

function mod:OnCombatEnd()
	self:UnscheduleMethod("Infernal")
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 234423 then --Похищение жизни
		specWarnDrainLife:Show()
		specWarnDrainLife:Play("kickcast")
		timerDrainLifeCD:Start(27)
		countdownDrainLife:Start(27)
	elseif spellId == 233473 then --Священный оберег
		warnHolyWard:Show()
		timerHolyWard:Start()
		timerHolyWardCD:Start()
	elseif (spellId == 234631 or spellId == 241717 or spellId == 236537) and self:AntiSpam(2.5, 1) then --Мощный удар
		specWarnSmash:Show()
		specWarnSmash:Play("shockwave")
	elseif spellId == 236572 then --Аннигиляция
		specWarnAnnihilate:Show()
		specWarnAnnihilate:Play("defensive")
		if not firstAnnihilate then
			firstAnnihilate = true
			timerInfernalCD:Start(9)
			countdownInfernal:Start(9)
			self:UnscheduleMethod("Infernal")
			self:ScheduleMethod(9, "Infernal")
		end
	elseif spellId == 234676 then --Кривое зеркало
		specWarnTwistedReflection:Show()
		specWarnTwistedReflection:Play("kickcast")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 236572 then --Аннигиляция
		self.vb.annihilateCast = self.vb.annihilateCast + 1
		timerAnnihilateCD:Start(25, self.vb.annihilateCast+1)
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 234428 then --Призыв истязающего глаза
		timerTormentingEyeCD:Start(27)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 234422 then --Аура разложения
		local amount = args.amount or 1
		if amount >= 5 then
			specWarnDecay:Show(amount)
			specWarnDecay:Play("stackhigh")
		elseif amount % 2 == 0 then
			warnDecay:Show(args.destName, amount)
		end
	elseif spellId == 234423 then --Похищение жизни
		warnDrainLife:Show(args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 234675 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnNetherstomp:Show()
		specWarnNetherstomp:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_HEALTH(uId)
	if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 117933 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.10 then --Варисс
		warned_preP1 = true
		warnPhase2:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
	end
end

function mod:UNIT_DIED(args)
	if args.destGUID == UnitGUID("player") then
		DBM:EndCombat(self, true)
	end
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 117933 then --Варисс
		self.vb.phase = 2
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase))
		timerDrainLifeCD:Stop()
		countdownDrainLife:Cancel()
		timerTormentingEyeCD:Stop()
		timerInfernalCD:Stop()
		countdownInfernal:Cancel()
		self:UnscheduleMethod("Infernal")
	elseif cid == 117198 then --Круул
		DBM:EndCombat(self)
	end
end

function mod:Infernal()
	if self.vb.phase == 1 then
		warnInfernal:Show()
		timerInfernalCD:Start(75)
		countdownInfernal:Start(75)
		self:ScheduleMethod(75, "Infernal")
	else
		warnInfernal:Show()
		timerInfernalCD:Start(45)
		countdownInfernal:Start(45)
		self:ScheduleMethod(45, "Infernal")
	end
end
