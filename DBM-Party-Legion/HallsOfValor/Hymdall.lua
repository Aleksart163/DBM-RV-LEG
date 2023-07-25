local mod	= DBM:NewMod(1485, "DBM-Party-Legion", 4, 721)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
mod:SetCreatureID(94960)
mod:SetEncounterID(1805)
mod:SetZone()
mod:SetUsedIcons(8, 7)
mod:DisableEEKillDetection()
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 191284 193235 188404 193092",
	"SPELL_AURA_APPLIED 193092",
	"SPELL_PERIODIC_DAMAGE 193234",
	"SPELL_PERIODIC_MISSED 193234",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--Химдалль https://ru.wowhead.com/npc=94960/химдалль/эпохальный-журнал-сражений
local warnBreath					= mod:NewSpellAnnounce(188404, 3, nil, nil, nil, nil, nil, 2) --Дыхание бури
local warnDancingBlade				= mod:NewTargetAnnounce(193235, 4) --Танцующий клинок
local warnSweep						= mod:NewTargetAnnounce(193092, 4) --Кровопролитный круговой удар

local specWarnSweep					= mod:NewSpecialWarningDefensive(193092, nil, nil, nil, 3, 6) --Кровопролитный круговой удар
local specWarnHorn					= mod:NewSpecialWarningDefensive(191284, nil, nil, nil, 3, 6) --Рог доблести
local specWarnHornOfValor			= mod:NewSpecialWarningSoon(188404, nil, nil, nil, 1, 2) --Дыхание бури
local specWarnHornOfValor2			= mod:NewSpecialWarningDodge(188404, nil, nil, nil, 2, 3) --Дыхание бури
local specWarnDancingBlade			= mod:NewSpecialWarningYouMove(193235, nil, nil, nil, 1, 2) --Танцующий клинок
local specWarnDancingBlade2			= mod:NewSpecialWarningYouRun(193235, nil, nil, nil, 3, 6) --Танцующий клинок
local specWarnDancingBlade3			= mod:NewSpecialWarningCloseMoveAway(193235, nil, nil, nil, 2, 3) --Танцующий клинок

local timerDancingBladeCD			= mod:NewCDTimer(12.5, 193235, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Танцующий клинок 10-15 
local timerHornCD					= mod:NewCDCountTimer(45, 191284, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Рог доблести
local timerSweepCD					= mod:NewCDTimer(15.5, 193092, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON..DBM_CORE_DEADLY_ICON) --Кровопролитный круговой удар
--local timerSweep					= mod:NewTargetTimer(4, 193092, nil, nil, nil, 3, nil, DBM_CORE_TANK_ICON..DBM_CORE_HEALER_ICON) --Кровопролитный круговой удар
local timerBreath					= mod:NewCDTimer(5, 188404, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Дыхание бури

local yellDancingBlade				= mod:NewYellMoveAway(193235, nil, nil, nil, "YELL") --Танцующий клинок

local countdownHorn					= mod:NewCountdown(45, 191284, nil, nil, 5) --Рог доблести
local countdownSweep				= mod:NewCountdown("Alt15.5", 193092, "Tank", nil, 3) --Кровопролитный круговой удар

mod:AddSetIconOption("SetIconOnDancingBlade", 193235, true, false, {8}) --Танцующий клинок
mod:AddSetIconOption("SetIconOnSweep", 193092, true, false, {7}) --Кровопролитный круговой удар

mod.vb.hornCount = 0

function mod:DancingBladeTarget(targetname, uId) --Танцующий клинок [✔] прошляпанного очка Мурчаля Прошляпенко
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnDancingBlade2:Show()
		specWarnDancingBlade2:Play("runout")
		yellDancingBlade:Yell()
	elseif self:CheckNearby(10, targetname) then
		specWarnDancingBlade3:Show(targetname)
		specWarnDancingBlade3:Play("runaway")
	else
		warnDancingBlade:Show(targetname)
	end
	if self.Options.SetIconOnDancingBlade then
		self:SetIcon(targetname, 8, 5)
	end
end

function mod:SweepTarget(targetname, uId) --Кровопролитный круговой удар [✔] в прошляпанное очко Мурчаля Прошляпенко
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnSweep:Show()
		specWarnSweep:Play("defensive")
	else
		warnSweep:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	self.vb.hornCount = 0
	if not self:IsNormal() then
		timerSweepCD:Start(16.5-delay) --Кровопролитный круговой удар+++
		countdownSweep:Start(16.5-delay) --Кровопролитный круговой удар+++
		timerHornCD:Start(11.5-delay, 1) --Рог доблести+++
		countdownHorn:Start(11.5-delay) --Рог доблести+++
		timerDancingBladeCD:Start(6-delay) --Танцующий клинок+++
	else
		timerSweepCD:Start(16.5-delay) --Кровопролитный круговой удар+++
		countdownSweep:Start(16.5-delay) --Кровопролитный круговой удар+++
		timerHornCD:Start(11.5-delay, 1) --Рог доблести+++
		countdownHorn:Start(11.5-delay) --Рог доблести+++
		timerDancingBladeCD:Start(6-delay) --Танцующий клинок+++
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 191284 then --Рог доблести
		self.vb.hornCount = self.vb.hornCount + 1
		if not UnitIsDeadOrGhost("player") then
			specWarnHorn:Show()
			specWarnHorn:Play("defensive")
		end
		timerDancingBladeCD:Cancel()
		if not UnitIsDeadOrGhost("player") then
			specWarnHornOfValor:Schedule(2)
			specWarnHornOfValor:ScheduleVoice(2, "breathsoon")
			specWarnHornOfValor2:Schedule(9)
			specWarnHornOfValor2:ScheduleVoice(9, "watchstep")
		end
		timerBreath:Start(9)
		timerBreath:Schedule(9)
		timerBreath:Schedule(14)
		if self.vb.hornCount == 1 then
			timerHornCD:Start(44.5, self.vb.hornCount+1)
			countdownHorn:Start(44.5)
			timerDancingBladeCD:Start(27.2) --2ой клинок
		elseif self.vb.hornCount == 2 then
			timerHornCD:Start(46, self.vb.hornCount+1)
			countdownHorn:Start(46)
			timerDancingBladeCD:Start(28.8) --4ый клинок
		elseif self.vb.hornCount == 3 then
			timerHornCD:Start(45.5, self.vb.hornCount+1)
			countdownHorn:Start(45.5)
			timerDancingBladeCD:Start(28.1) --6й клинок
		elseif self.vb.hornCount == 4 then
			timerHornCD:Start(45.5, self.vb.hornCount+1)
			countdownHorn:Start(45.5)
			timerDancingBladeCD:Start(28.2) --8й клинок
		elseif self.vb.hornCount == 5 then
			timerHornCD:Start(45.5, self.vb.hornCount+1)
			countdownHorn:Start(45.5)
			timerDancingBladeCD:Start(28.2) --10й клинок
		elseif self.vb.hornCount == 6 then
			timerHornCD:Start(45.5, self.vb.hornCount+1)
			countdownHorn:Start(45.5)
			timerDancingBladeCD:Start(28.2) --12й клинок
		else
			timerHornCD:Start(45.5, self.vb.hornCount+1)
			countdownHorn:Start(45.5)
			timerDancingBladeCD:Start(28.2)
		end
	elseif spellId == 193235 then --Танцующий клинок
		self:BossTargetScanner(args.sourceGUID, "DancingBladeTarget", 0.1, 2)
		timerDancingBladeCD:Start()
	elseif spellId == 188404 and self:AntiSpam(5, 2) then --Дыхание бури
		warnBreath:Show()
		warnBreath:Play("watchstep")
	elseif spellId == 193092 then --Кровопролитный круговой удар
		self:BossTargetScanner(args.sourceGUID, "SweepTarget", 0.1, 2)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 193092 then --Кровопролитный круговой удар
		if self.Options.SetIconOnSweep then
			self:SetIcon(args.destName, 7, 4)
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
		timerSweepCD:Start()
		countdownSweep:Start()
	end
end

--[[function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.proshlyapMurchal then
		DBM:EndCombat(self)
	end
end]]
