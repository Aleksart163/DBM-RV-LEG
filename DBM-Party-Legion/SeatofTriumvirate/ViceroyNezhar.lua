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

--TODO, power gain rate consistent?
--TODO, special warning to switch to tentacles once know for sure how to tell empowered apart from non empowered?
--TODO, More work on guard timers, with an english log that's actually captured properly (stared and stopped between pulls)
local warnEternalTwilight				= mod:NewCastAnnounce(248736, 4) --Вечные сумерки (после треша)
local warnHowlingDark					= mod:NewCastAnnounce(244751, 4) --Пронизывающая тьма (фир)
local warnAddsLeft						= mod:NewAddsLeftAnnounce("ej16424", 3) --Призыв призрачных стражей (треш)
local warnTentacles						= mod:NewSpellAnnounce(244769, 2) --Теневые щупальца

local specWarnHowlingDark				= mod:NewSpecialWarningInterrupt(244751, "HasInterrupt", nil, nil, 1, 2) --Пронизывающая тьма (фир)
local specWarnEntropicForce				= mod:NewSpecialWarningMoveBoss(246324, nil, nil, nil, 4, 3) --Энтропическая сила
local specWarnAdds						= mod:NewSpecialWarningSwitch(249336, "-Healer", nil, nil, 3, 2) --Призыв призрачных стражей (треш)
local specWarnTentacles					= mod:NewSpecialWarningSwitch(244769, "Dps", nil, nil, 2, 2) --Теневые щупальца

local timerUmbralTentaclesCD			= mod:NewCDTimer(31.5, 244769, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON) --Теневые щупальца +++
local timerHowlingDarkCD				= mod:NewCDTimer(28.0, 244751, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON..DBM_CORE_DEADLY_ICON) --Пронизывающая тьма (фир) +++
local timerEntropicForceCD				= mod:NewCDTimer(28.0, 246324, nil, nil, nil, 7) --Энтропическая сила 28-38 (все норм с момента кика) +++
local timerEntropicForce				= mod:NewCastTimer(5, 246324, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Энтропическая сила +++
local timerEternalTwilight				= mod:NewCastTimer(10, 248736, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Вечные сумерки (после треша) +++
local timerAddsCD						= mod:NewCDTimer(61.9, 248736, nil, "-Healer", nil, 2, nil, DBM_CORE_DAMAGE_ICON..DBM_CORE_MYTHIC_ICON) --Призыв призрачных стражей (все норм с момента кика)

local countdownEternalTwilight			= mod:NewCountdown("AltTwo10", 248736) --Вечные сумерки (после треша)

mod.vb.guardsActive = 0

function mod:OnCombatStart(delay)
	self.vb.guardsActive = 0
	if self:IsHard() then
		timerUmbralTentaclesCD:Start(13-delay) --Теневые щупальца +++
		timerHowlingDarkCD:Start(15-delay) --Пронизывающая тьма (фир) +++
		timerEntropicForceCD:Start(33-delay) --Энтропическая сила +++
		timerAddsCD:Start(51.5-delay) --Призыв призрачных стражей (треш) +++
	else
		timerUmbralTentaclesCD:Start(11.8-delay) --Теневые щупальца
		timerHowlingDarkCD:Start(15.5-delay) --Пронизывающая тьма (фир)
		timerEntropicForceCD:Start(35-delay) --Энтропическая сила
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 244751 then --Пронизывающая тьма (фир)
		timerHowlingDarkCD:Start()
		warnHowlingDark:Show()
		specWarnHowlingDark:Show(args.sourceName)
		specWarnHowlingDark:Play("kickcast")
	elseif spellId == 248736 and self:AntiSpam(3, 1) then --Вечные сумерки начало каста
		warnEternalTwilight:Show()
		timerEternalTwilight:Start()
		countdownEternalTwilight:Start()
		timerUmbralTentaclesCD:Stop()
		timerEntropicForceCD:Stop()
		timerHowlingDarkCD:Stop()
	elseif spellId == 246324 then
		specWarnEntropicForce:Show()
		specWarnEntropicForce:Play("keepmove")
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
		if self.vb.guardsActive >= 1 then
			warnAddsLeft:Show(self.vb.guardsActive)
		--else
			--Start timer for next guard here if more accurate
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 245038 then
		warnTentacles:Show()
		specWarnTentacles:Show()
		timerUmbralTentaclesCD:Start()
	elseif spellId == 249336 then--or 249335
		specWarnAdds:Show()
		specWarnAdds:Play("killmob")
	end
end

function mod:SPELL_INTERRUPT(args)
	if type(args.extraSpellId) == "number" and args.extraSpellId == 248736 then
		timerEternalTwilight:Stop()
		countdownEternalTwilight:Cancel()
		timerUmbralTentaclesCD:Start(12)
		timerEntropicForceCD:Start(35)
		timerHowlingDarkCD:Start(15)
		timerAddsCD:Start(57.5)
		countdownEternalTwilight:Start(57.5)
	end
end
