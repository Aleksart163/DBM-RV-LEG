local mod	= DBM:NewMod(1981, "DBM-Party-Legion", 13, 945)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(124874) -- ну или 124309
mod:SetEncounterID(2067)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 244751 248736 246324",
	"SPELL_CAST_SUCCESS 246324",
	"SPELL_AURA_APPLIED 248804",
	"SPELL_AURA_REMOVED 248804",
	"SPELL_INTERRUPT",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--Наместник Незжар https://ru.wowhead.com/npc=124309/наместник-незжар/эпохальный-журнал-сражений
local warnEternalTwilight				= mod:NewCastAnnounce(248736, 4) --Вечные сумерки (после треша)
local warnHowlingDark					= mod:NewCastAnnounce(244751, 4) --Пронизывающая тьма (фир)
local warnTentacles						= mod:NewSpellAnnounce(244769, 3) --Теневые щупальца
local warnDarkBulwark					= mod:NewFadesAnnounce(248804, 2) --Темная защита спадает

local specWarnHowlingDark				= mod:NewSpecialWarningInterrupt(244751, "HasInterrupt", nil, nil, 1, 2) --Пронизывающая тьма (фир)
local specWarnEntropicForce				= mod:NewSpecialWarningMoveBoss(246324, nil, nil, nil, 4, 3) --Энтропическая сила
local specWarnAdds						= mod:NewSpecialWarningSwitch(249336, "-Healer", nil, nil, 3, 2) --Призыв призрачных стражей (треш)
local specWarnTentacles					= mod:NewSpecialWarningSwitch(244769, "Dps", nil, nil, 2, 2) --Теневые щупальца
local specWarnEternalTwilight			= mod:NewSpecialWarningInterrupt(248736, "HasInterrupt", nil, nil, 3, 2) --Вечные сумерки (после треша)

local timerUmbralTentaclesCD			= mod:NewCDTimer(31.5, 244769, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON) --Теневые щупальца +++
local timerHowlingDarkCD				= mod:NewCDTimer(28.0, 244751, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON..DBM_CORE_DEADLY_ICON) --Пронизывающая тьма (фир) +++
local timerEntropicForceCD				= mod:NewCDTimer(28.0, 246324, nil, nil, nil, 7) --Энтропическая сила 28-38 (все норм с момента кика) +++
local timerEntropicForce				= mod:NewCastTimer(5, 246324, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Энтропическая сила +++
local timerEternalTwilight				= mod:NewCastTimer(10, 248736, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Вечные сумерки (после треша) +++
local timerAddsCD						= mod:NewCDTimer(57.5, 248736, nil, "-Healer", nil, 2, nil, DBM_CORE_DAMAGE_ICON..DBM_CORE_MYTHIC_ICON) --Призыв призрачных стражей (все норм с момента кика)

local countdownEternalTwilight			= mod:NewCountdown(57.5, 248736, nil, nil, 5) --Вечные сумерки (после треша)
local countdownEternalTwilight2			= mod:NewCountdownFades("Alt10", 248736, nil, nil, 5) --Вечные сумерки (после треша)

mod.vb.guardsActive = 0

function mod:OnCombatStart(delay)
	self.vb.guardsActive = 0
	if self:IsHard() then
		timerUmbralTentaclesCD:Start(12-delay) --Теневые щупальца +++
		timerHowlingDarkCD:Start(15-delay) --Пронизывающая тьма (фир) +++
		timerEntropicForceCD:Start(33-delay) --Энтропическая сила +++
		timerAddsCD:Start(51.5-delay) --Призыв призрачных стражей (треш) +++
		countdownEternalTwilight:Start(51.5-delay) --Призыв призрачных стражей (треш) +++
	else
		timerUmbralTentaclesCD:Start(11.8-delay) --Теневые щупальца
		timerHowlingDarkCD:Start(15.5-delay) --Пронизывающая тьма (фир)
		timerEntropicForceCD:Start(35-delay) --Энтропическая сила
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 244751 then --Пронизывающая тьма (фир)
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnHowlingDark:Show()
			specWarnHowlingDark:Play("kickcast")
		else
			warnHowlingDark:Show()
			specWarnHowlingDark:Show()
			specWarnHowlingDark:Play("kickcast")
		end
		timerHowlingDarkCD:Start()
	elseif spellId == 248736 and self:AntiSpam(3, 1) then --Вечные сумерки начало каста
		timerUmbralTentaclesCD:Stop()
		timerEntropicForceCD:Stop()
		timerHowlingDarkCD:Stop()
		warnEternalTwilight:Show()
		timerEternalTwilight:Start()
		countdownEternalTwilight2:Start()
		timerAddsCD:Start()
		countdownEternalTwilight:Start()
	elseif spellId == 246324 then
		if not UnitIsDeadOrGhost("player") then
			specWarnEntropicForce:Show()
			specWarnEntropicForce:Play("keepmove")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 246324 then
		timerEntropicForceCD:Start()
		timerEntropicForce:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 248804 then
		self.vb.guardsActive = self.vb.guardsActive + 1
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 248804 then
		self.vb.guardsActive = self.vb.guardsActive - 1
		if self.vb.guardsActive == 0 then
			warnDarkBulwark:Show()
			if not UnitIsDeadOrGhost("player") then
				specWarnEternalTwilight:Show()
				specWarnEternalTwilight:Play("kickcast")
			end
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 245038 then
		warnTentacles:Show()
		if not UnitIsDeadOrGhost("player") then
			specWarnTentacles:Show()
			specWarnTentacles:Play("mobkill")
		end
		timerUmbralTentaclesCD:Start()
	elseif spellId == 249336 then--or 249335
		if not UnitIsDeadOrGhost("player") then
			specWarnAdds:Show()
			specWarnAdds:Play("mobkill")
		end
	end
end

function mod:SPELL_INTERRUPT(args)
	if type(args.extraSpellId) == "number" and args.extraSpellId == 248736 then
		timerEternalTwilight:Stop()
		countdownEternalTwilight2:Cancel()
		timerUmbralTentaclesCD:Start(12)
		timerEntropicForceCD:Start(35)
		timerHowlingDarkCD:Start(15)
	end
end
