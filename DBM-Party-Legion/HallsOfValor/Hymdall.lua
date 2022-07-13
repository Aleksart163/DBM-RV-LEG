local mod	= DBM:NewMod(1485, "DBM-Party-Legion", 4, 721)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(94960)
mod:SetEncounterID(1805)
mod:SetZone()
mod:SetUsedIcons(8)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 191284 193235 188404",
	"SPELL_CAST_SUCCESS 193235",
	"SPELL_AURA_APPLIED 193092",
	"SPELL_PERIODIC_DAMAGE 193234",
	"SPELL_PERIODIC_MISSED 193234",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--Химдалль https://ru.wowhead.com/npc=94960/химдалль/эпохальный-журнал-сражений
local warnBreath					= mod:NewSpellAnnounce(188404, 3, nil, nil, nil, nil, nil, 2) --Дыхание бури
local warnDancingBlade				= mod:NewTargetAnnounce(193235, 3) --Танцующий клинок
local warnSweep						= mod:NewSpellAnnounce(193092, 2, nil, nil) --Кровопролитный круговой удар
--local warnHorn						= mod:NewPreWarnAnnounce(191284, 5, 1) --Рог доблести

local specWarnSweep					= mod:NewSpecialWarningDefensive(193092, "Tank", nil, nil, 3, 3) --Кровопролитный круговой удар
local specWarnHorn					= mod:NewSpecialWarningDefensive(191284, nil, nil, nil, 3, 3) --Рог доблести
local specWarnHornOfValor			= mod:NewSpecialWarningSoon(188404, nil, nil, nil, 1, 2) --Дыхание бури
local specWarnHornOfValor2			= mod:NewSpecialWarningDodge(188404, nil, nil, nil, 2, 5) --Дыхание бури
local specWarnDancingBlade			= mod:NewSpecialWarningYouMove(193235, nil, nil, nil, 1, 2) --Танцующий клинок
local specWarnDancingBlade2			= mod:NewSpecialWarningYouRun(193235, nil, nil, nil, 3, 3) --Танцующий клинок
local specWarnDancingBlade3			= mod:NewSpecialWarningCloseMoveAway(193235, nil, nil, nil, 2, 3) --Танцующий клинок

local timerDancingBladeCD			= mod:NewCDTimer(13, 193235, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Танцующий клинок 10-15 
local timerHornCD					= mod:NewCDTimer(45, 191284, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Рог доблести 31-36, Very confident it's health based.
local timerSweepCD					= mod:NewCDTimer(15.5, 193092, nil, "Melee", nil, 5, nil, DBM_CORE_TANK_ICON..DBM_CORE_DEADLY_ICON) --Кровопролитный круговой удар
local timerSweep					= mod:NewTargetTimer(4, 193092, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_HEALER_ICON..DBM_CORE_TANK_ICON) --Кровопролитный круговой удар
local timerBreath					= mod:NewCDTimer(5, 188404, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Дыхание бури

local yellDancingBlade				= mod:NewYell(193235, nil, nil, nil, "YELL") --Танцующий клинок

local countdownHorn					= mod:NewCountdown(45, 191284, nil, nil, 5) --Рог доблести
local countdownSweep				= mod:NewCountdown("Alt15.5", 193092, "Tank", nil, 3) --Кровопролитный круговой удар
--local countdownSweep				= mod:NewCountdownFades("Alt15.5", 193092, "Tank", nil, 3) --Кровопролитный круговой удар
mod:AddSetIconOption("SetIconOnSweep", 193092, true, false, {8}) --Кровопролитный круговой удар

function mod:DancingBladeTarget(targetname, uId) --Танцующий клинок (✔)
	if not targetname then return end
	warnDancingBlade:Show(targetname)
	if targetname == UnitName("player") then
		specWarnDancingBlade2:Show()
		specWarnDancingBlade2:Play("runout")
		yellDancingBlade:Yell()
	elseif self:CheckNearby(10, targetname) then
		specWarnDancingBlade3:Show(targetname)
		specWarnDancingBlade3:Play("runaway")
	end
end

function mod:OnCombatStart(delay)
	if not self:IsNormal() then
		specWarnSweep:Schedule(16.5-delay) --Кровопролитный круговой удар+++
		timerSweepCD:Start(16.5-delay) --Кровопролитный круговой удар+++
		countdownSweep:Start(16.5-delay) --Кровопролитный круговой удар+++
		timerHornCD:Start(11.5-delay) --Рог доблести+++
		countdownHorn:Start(11.5-delay) --Рог доблести+++
	--	warnHorn:Schedule(6.5-delay) --Рог доблести+++
		timerDancingBladeCD:Start(6-delay) --Танцующий клинок+++
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 191284 then --Рог доблести
		specWarnHorn:Show()
		specWarnHorn:Play("defensive")
		timerDancingBladeCD:Cancel()
		specWarnHornOfValor:Schedule(2)
		specWarnHornOfValor:ScheduleVoice(2, "breathsoon")
		specWarnHornOfValor2:Schedule(9)
		specWarnHornOfValor2:ScheduleVoice(9, "watchstep")
		timerHornCD:Start()
	--	warnHorn:Schedule(40)
		countdownHorn:Start()
		timerDancingBladeCD:Start(27)
		timerBreath:Start(9)
		timerBreath:Schedule(9)
		timerBreath:Schedule(14)
	elseif spellId == 193235 then --Танцующий клинок
		self:BossTargetScanner(args.sourceGUID, "DancingBladeTarget", 0.1, 2)
		timerDancingBladeCD:Start()
	elseif spellId == 188404 and self:AntiSpam(5, 2) then --Дыхание бури
		warnBreath:Show()
		warnBreath:Play("watchstep")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 193092 then --Кровопролитный круговой удар
		timerSweep:Start(args.destName)
		if self.Options.SetIconOnSweep then
			self:SetIcon(args.destName, 8, 4)
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 193234 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		if not self:IsNormal() then
			specWarnDancingBlade:Show()
			specWarnDancingBlade:Play("runaway")
		end
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 193092 then --Кровопролитный круговой удар
		warnSweep:Show()
		specWarnSweep:Schedule(15.5)
		timerSweepCD:Start()
		countdownSweep:Start()
	end
end
