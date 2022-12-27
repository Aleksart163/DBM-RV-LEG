local mod	= DBM:NewMod(1827, "DBM-Party-Legion", 11, 860)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(114329, 114522, 114330, 114328)
mod:SetEncounterID(1957)--Shared (so not used for encounter START since it'd fire 3 mods)
mod:DisableESCombatDetection()--However, with ES disabled, EncounterID can be used for BOSS_KILL/ENCOUNTER_END
mod:DisableIEEUCombatDetection()
mod:SetZone()
mod:SetUsedIcons(8, 7)
--mod:SetHotfixNoticeRev(14922)
mod:SetBossHPInfoToHighest()
mod.noNormal = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 228025 228019 227987 232153",
	"SPELL_AURA_APPLIED 228013 228221 228225 227985 227987",
	"SPELL_AURA_REMOVED 232156 228221 227987 227985",
	"SPELL_PERIODIC_DAMAGE 228200",
	"SPELL_PERIODIC_MISSED 228200",
	"UNIT_HEALTH boss1 boss2 boss3 boss4",
	"UNIT_DIED"
)

--"Красавица и Зверь" https://ru.wowhead.com/npc=114328/коглстон/эпохальный-журнал-сражений
local warnPhase						= mod:NewPhaseChangeAnnounce(1)
local warnPhase2					= mod:NewPrePhaseAnnounce(2, 1, 232153)
--Метелка
local warnSevereDusting				= mod:NewTargetAnnounce(228221, 3) --Жесткая уборка
--Коглстон
local warnKaraKazham				= mod:NewSpellAnnounce(232153, 2) --Сим-каражим!
local warnDentArmor					= mod:NewTargetAnnounce(227985, 4) --Сминание доспеха
local warnDinnerBell				= mod:NewCastAnnounce(227987, 2) --Звонок к обеду!
local warnDinnerBell2				= mod:NewTargetAnnounce(227987, 4) --Звонок к обеду!

--Люминор
local specWarnBurningBlaze			= mod:NewSpecialWarningYouMove(228193, nil, nil, nil, 1, 2) --Жаркое пламя
local specWarnHeatWave				= mod:NewSpecialWarningInterrupt(228025, "HasInterrupt", nil, nil, 3, 6) --Волна жара
--Мадам Чугунок
local specWarnDrenched				= mod:NewSpecialWarningYou(228013, nil, nil, nil, 1, 2) --Брызги супа
--local specWarnDrenched				= mod:NewSpecialWarningMoveTo(228013, nil, nil, nil, 1, 2) --Брызги супа
local specWarnLeftovers				= mod:NewSpecialWarningInterrupt(228019, "HasInterrupt", nil, nil, 2, 3) --Объедки
--Метелка
local specWarnSevereDusting			= mod:NewSpecialWarningYouRun(228221, nil, nil, nil, 4, 2) --Жесткая уборка
local specWarnSultryheat			= mod:NewSpecialWarningDispel(228225, "MagicDispeller", nil, nil, 1, 2) --Распаляющий жар
--Коглстон
local specWarnDentArmor				= mod:NewSpecialWarningYouDefensive(227985, nil, nil, nil, 3, 6) --Сминание доспеха
local specWarnDinnerBell			= mod:NewSpecialWarningInterrupt(227987, "HasInterrupt", nil, nil, 1, 2) --Звонок к обеду!
local specWarnDinnerBell2			= mod:NewSpecialWarningDispel(227987, "MagicDispeller", nil, nil, 3, 3) --Звонок к обеду!

--Люминор
local timerHeatWaveCD				= mod:NewCDTimer(26, 228025, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON..DBM_CORE_DEADLY_ICON) --Волна жара
--Мадам Чугунок
local timerLeftoversCD				= mod:NewCDTimer(17, 228019, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON..DBM_CORE_DEADLY_ICON) --Объедки
--Метелка
local timerSevereDustingCD			= mod:NewCDTimer(12, 228221, nil, nil, nil, 3) --Жесткая уборка
--Коглстон
local timerDentArmor				= mod:NewTargetTimer(8, 227985, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Сминание доспеха
local timerDinnerBellCD				= mod:NewCDTimer(10.9, 227987, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON..DBM_CORE_DEADLY_ICON) --Звонок к обеду!
local timerKaraKazhamCD				= mod:NewCDTimer(20, 232153, nil, nil, nil, 1, nil, DBM_CORE_TANK_ICON..DBM_CORE_DAMAGE_ICON) --Сим-каражим!

local countdownHeatWave				= mod:NewCountdown(26, 228025, nil, nil, 5) --Волна жара
local countdownKaraKazham			= mod:NewCountdown(20, 232153, nil, nil, 5) --Сим-каражим!

mod:AddSetIconOption("SetIconOnDentArmor", 227985, true, false, {8})
mod:AddSetIconOption("SetIconOnDusting", 228221, true, false, {7})

mod.vb.phase = 1
mod.vb.proshlyap = 0

local burningBlaze = DBM:GetSpellInfo(228193)
local warned_preP2 = false

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.proshlyap = 0
	warned_preP2 = false
	timerLeftoversCD:Start(9-delay) --Объедки+++
	timerHeatWaveCD:Start(30-delay) --Волна жара+++
	countdownHeatWave:Start(30-delay) --Волна жара+++
end

function mod:OnCombatEnd()

end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 228025 then --Волна жара
		if not UnitIsDeadOrGhost("player") then
			specWarnHeatWave:Show()
			specWarnHeatWave:Play("kickcast")
		end
		if self:IsHard() then
			timerHeatWaveCD:Start(30)
			countdownHeatWave:Start(30)
		else
			timerHeatWaveCD:Start()
			countdownHeatWave:Start()
		end
	elseif spellId == 228019 then --Объедки
		if not UnitIsDeadOrGhost("player") then
			specWarnLeftovers:Show()
			specWarnLeftovers:Play("kickcast")
		end
		if self:IsHard() then
			timerLeftoversCD:Start(18)
		else
			timerLeftoversCD:Start()
		end
	elseif spellId == 227987 then --Звонок к обеду!
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnDinnerBell:Show()
			specWarnDinnerBell:Play("kickcast")
		else
			warnDinnerBell:Show()
			warnDinnerBell:Play("kickcast")
		end
		if self:IsHard() then
			timerDinnerBellCD:Start(20)
		else
			timerDinnerBellCD:Start()
		end
	elseif spellId == 232153 then --Сим-каражим
		warnKaraKazham:Show()
		timerKaraKazhamCD:Start()
		countdownKaraKazham:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 228013 then --Брызги супа
		if args:IsPlayer() then
			specWarnDrenched:Show()
			specWarnDrenched:Play("targetyou")
		end
	elseif spellId == 228221 then --Жесткая уборка
		timerSevereDustingCD:Start()
		if args:IsPlayer() then
			specWarnSevereDusting:Show()
			specWarnSevereDusting:Play("justrun")
			specWarnSevereDusting:ScheduleVoice(1, "keepmove")
		else
			warnSevereDusting:Show(args.destName)
		end
		if self.Options.SetIconOnDusting then
			self:SetIcon(args.destName, 7)
		end
	elseif spellId == 228225 and not args:IsDestTypePlayer() then
		if not UnitIsDeadOrGhost("player") then
			specWarnSultryheat:Show(args.destName)
			specWarnSultryheat:Play("dispelnow")
		end
	elseif spellId == 227985 then --Сминание доспеха
		timerDentArmor:Start(args.destName)
		if args:IsPlayer() then
			specWarnDentArmor:Show()
			specWarnDentArmor:Play("defensive")
		else
			warnDentArmor:Show(args.destName)
		end
		if self.Options.SetIconOnDentArmor then
			self:SetIcon(args.destName, 8)
		end
	elseif spellId == 227987 then --Звонок к обеду!
		local cid = self:GetCIDFromGUID(args.destGUID)
		if cid == 114328 then --Карлсон и прошляпанное очко Мурчаля Прошляпенко
			warnDinnerBell2:Show(args.destName)
			if not UnitIsDeadOrGhost("player") then
				specWarnDinnerBell2:Show(args.destName)
				specWarnDinnerBell2:Play("dispelnow")
			end
		end
	end
end

	
function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 232156 then --Призрачные слуги
		self.vb.phase = 2
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase))
		timerKaraKazhamCD:Start(2)
		countdownKaraKazham:Start(2)
		timerDinnerBellCD:Start(12)
	elseif spellId == 228221 and self.Options.SetIconOnDusting then --Жесткая уборка
		self:SetIcon(args.destName, 0)
	elseif spellId == 227985 and self.Options.SetIconOnDentArmor then --Сминание доспеха
		self:SetIcon(args.destName, 0)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228200 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnBurningBlaze:Show()
		specWarnBurningBlaze:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 114329 then --Люминор
		self.vb.proshlyap = self.vb.proshlyap + 1
		timerHeatWaveCD:Stop()
		countdownHeatWave:Cancel()
	elseif cid == 114522 then --Мадам Чугунок
		self.vb.proshlyap = self.vb.proshlyap + 1
		timerLeftoversCD:Stop()
	elseif cid == 114330 then --Метелка
		self.vb.proshlyap = self.vb.proshlyap + 1
		timerSevereDustingCD:Stop()
	end
end

function mod:UNIT_HEALTH(uId)
	if not self:IsNormal() then --гер, миф и миф+
		if self.vb.phase == 1 and not warned_preP2 and self.vb.proshlyap == 2 and self:GetUnitCreatureId(uId) == 114522 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.20 then --Мадам Чугунок
			warned_preP2 = true
			warnPhase2:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
		elseif self.vb.phase == 1 and not warned_preP2 and self.vb.proshlyap == 2 and self:GetUnitCreatureId(uId) == 114329 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.20 then --Люминор
			warned_preP2 = true
			warnPhase2:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
		elseif self.vb.phase == 1 and not warned_preP2 and self.vb.proshlyap == 2 and self:GetUnitCreatureId(uId) == 114330 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.20 then --Метелка
			warned_preP2 = true
			warnPhase2:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
		end
	end
end
