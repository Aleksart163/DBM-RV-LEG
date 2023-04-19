local mod	= DBM:NewMod("Xylem", "DBM-MageTower")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
mod:SetCreatureID(115244)
mod:SetZone()

mod.soloChallenge = true
mod.onlyNormal = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 234728 242316 232673",
	"SPELL_AURA_APPLIED 231443 233248",
	"SPELL_AURA_REMOVED 233248",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_CAST_SUCCESS 232661 231522",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_HEALTH",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--Прошляпанное очко Мурчаля ✔ Верховный маг Ксилем https://www.wowhead.com/ru/npc=115244/верховный-маг-ксилем#abilities
local warnPhase						= mod:NewPhaseChangeAnnounce(1)
local warnPhase2					= mod:NewPrePhaseAnnounce(2, 1)
local warnFrostPhase				= mod:NewSpellAnnounce(242394, 2) --Фаза льда
local warnArcanePhase				= mod:NewSpellAnnounce(242386, 2) --Фаза тайной магии

--Фаза льда
local specWarnRazorIce				= mod:NewSpecialWarningDodge(232661, nil, nil, nil, 2, 2) --Ледяной сталагмит
--Transition
local specWarnArcaneAnnihilation	= mod:NewSpecialWarningInterrupt(234728, nil, nil, nil, 3, 3) --Волшебная аннигиляция
--Фаза тайн.магии
local specWarnShadowBarrage			= mod:NewSpecialWarningDodge(231443, nil, nil, nil, 2, 2) --Залп Тени
local specWarnDrawPower				= mod:NewSpecialWarningInterrupt(231522, nil, nil, nil, 1, 2) --Похищение энергии
--Phase 2
local specWarnSeeds					= mod:NewSpecialWarningYouRun(233248, nil, nil, nil, 4, 3) --Семя Тьмы
local specWarnSeeds2				= mod:NewSpecialWarningSwitch(233248, nil, nil, nil, 1, 3) --Семя Тьмы
local specWarnSeeds3				= mod:NewSpecialWarningTarget(233248, nil, nil, nil, 3, 3) --Семя Тьмы

mod:AddTimerLine(SCENARIO_STAGE:format(1))
local timerRazorIceCD				= mod:NewCDTimer(25.5, 232661, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Ледяной сталагмит 25.5-38.9 (other casts can delay it a lot)
--Transition
local timerArcaneAnnihilationCD		= mod:NewCDTimer(90, 234728, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON..DBM_CORE_DEADLY_ICON) --Волшебная аннигиляция
local timerShadowBarrageCD			= mod:NewCDTimer(40.0, 231443, nil, nil, nil, 2) --Залп Тени Actually used both phases
--Фаза тайн.магии
local timerDrawPowerCD				= mod:NewCDTimer(18.2, 231522, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON) --Похищение энергии

mod:AddTimerLine(SCENARIO_STAGE:format(2))
local timerSeedsCD					= mod:NewCDTimer(50, 233248, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON..DBM_CORE_DEADLY_ICON) --Семя Тьмы

local timerRoleplay					= mod:NewTimer(30, "timerRoleplay", "Interface\\Icons\\ability_warrior_offensivestance", nil, nil, 7)

local yellSeeds2					= mod:NewFadesYell(233248, nil, nil, nil, "YELL") --Семя Тьмы

local countdownPull					= mod:NewCountdown(15, 212702, nil, nil, 5)
local countdownSeeds				= mod:NewCountdown(50, 233248, nil, nil, 5) --Семя Тьмы

mod.vb.phase = 1
mod.vb.razorIceCount = 0
mod.vb.arcaneAnnihilationCount = 0
mod.vb.arcaneBarrageCount = 0
mod.vb.frostboltCount = 0

local warned_preP1 = false
local activeBossGUIDS = {}

function mod:OnCombatStart(delay)
	warned_preP1 = false
	self.vb.phase = 1
	self.vb.razorIceCount = 0
	self.vb.arcaneAnnihilationCount = 0
	self.vb.arcaneBarrageCount = 0
	self.vb.frostboltCount = 0
	timerRazorIceCD:Start(10-delay) --Ледяной сталагмит+++
	timerArcaneAnnihilationCD:Start(90-delay) --Волшебная аннигиляция+++
--	DBM:AddMsg("Данный босс содержит оригинальные таймеры/анонсы и т.д. с офы Легиона за 2018 год, поэтому могут работать на данном сервере плохо. Следите за обновлениями для корректной работы модуля.")
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 234728 then --Волшебная аннигиляция
		self.vb.arcaneAnnihilationCount = self.vb.arcaneAnnihilationCount + 1
		specWarnArcaneAnnihilation:Show()
		specWarnArcaneAnnihilation:Play("kickcast")
		timerRazorIceCD:Stop()
	--	timerArcaneAnnihilationCD:Start(50)
	elseif spellId == 242316 then --Ледяная стрела
		self.vb.frostboltCount = self.vb.frostboltCount + 1
		self.vb.arcaneBarrageCount = 0
		if self.vb.frostboltCount == 1 then
			warnFrostPhase:Show()
			timerShadowBarrageCD:Cancel()
			timerRazorIceCD:Start(10)
		end
	elseif spellId == 232673 then --Чародейский обстрел
		self.vb.arcaneBarrageCount = self.vb.arcaneBarrageCount + 1
		self.vb.frostboltCount = 0
		if self.vb.arcaneBarrageCount == 1 then
			warnArcanePhase:Show()
			timerRazorIceCD:Cancel()
			timerShadowBarrageCD:Start(10)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 232661 then --Ледяной сталагмит
		self.vb.razorIceCount = self.vb.razorIceCount + 1
		specWarnRazorIce:Show()
		specWarnRazorIce:Play("watchstep")
		timerShadowBarrageCD:Cancel()
	--	timerArcaneAnnihilationCD:Stop()
		timerRazorIceCD:Start(30)
	elseif spellId == 231522 then --Похищение энергии
		specWarnDrawPower:Show()
		specWarnDrawPower:Play("kickcast")
		timerDrawPowerCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 231443 then
		specWarnShadowBarrage:Show()
		specWarnShadowBarrage:Play("watchorb")
		if self.vb.phase == 1 then
			timerShadowBarrageCD:Start(30)
		else
			timerShadowBarrageCD:Start()
		end
	elseif spellId == 233248 then --Семя Тьмы
		timerSeedsCD:Start()
		countdownSeeds:Start()
		if args:IsPlayer() then
			specWarnSeeds:Show()
			specWarnSeeds:Play("justrun")
			yellSeeds2:Countdown(8, 3)
		elseif args:IsPet() then
			specWarnSeeds3:Show(args.destName)
			specWarnSeeds3:Play("justrun")
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 233248 then --Семя Тьмы
		if args:IsPlayer() then
			specWarnSeeds2:Show()
			specWarnSeeds2:Play("killmob")
		elseif args:IsPet() then
			specWarnSeeds2:Show()
			specWarnSeeds2:Play("killmob")
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Xylem then
		self.vb.phase = 2
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase))
		timerRazorIceCD:Cancel()
	--	timerArcaneAnnihilationCD:Cancel()
		timerShadowBarrageCD:Cancel()
		timerRoleplay:Start(21)
		countdownPull:Start(21)
		timerSeedsCD:Start(30.5)
		countdownSeeds:Start(30.5)
	end
end

function mod:UNIT_HEALTH(uId)
	if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 115244 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.20 then --Верховный маг Ксилем
		warned_preP1 = true
		warnPhase2:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
	end
end

function mod:UNIT_DIED(args)
	if args.destGUID == UnitGUID("player") then
		DBM:EndCombat(self, true)
	end
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 116839 then --Гибельная тень
		DBM:EndCombat(self)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
--function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
--	local spellId = legacySpellId or bfaSpellId
	if spellId == 242394 then--Frost Phase
		timerDrawPowerCD:Stop()
		warnFrostPhase:Show()
	--	timerArcaneAnnihilationCD:Start()
		timerRazorIceCD:Start(20)--20-33
	elseif spellId == 242386 then--Arcane Phase
		warnArcanePhase:Show()
		timerRazorIceCD:Stop()
	--	timerArcaneAnnihilationCD:Start()
		--timerShadowBarrageCD:Start(11)
		timerDrawPowerCD:Start(27)--27-42
	elseif spellId == 164393 then--Cancel Channeling (Successfully interrupted Arcane Annihilation)
		
	end
end
