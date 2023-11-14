local mod	= DBM:NewMod(1820, "DBM-Party-Legion", 11, 860)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17745 $"):sub(12, -3))
mod:SetCreatureID(114284, 114251)
mod:SetEncounterID(1957)--Shared (so not used for encounter START since it'd fire 3 mods)
mod:DisableESCombatDetection()--However, with ES disabled, EncounterID can be used for BOSS_KILL/ENCOUNTER_END
mod:DisableIEEUCombatDetection()
mod:SetZone()
mod:SetMinSyncRevision(17745)
--mod:SetUsedIcons(1)
--mod:SetHotfixNoticeRev(14922)
--mod.respawnTime = 30

mod.noNormal = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 227776 227477 227447 227543 227341",
	"SPELL_CAST_SUCCESS 227410"
)

--"Злюкер" 
local warnMagicMagnificent			= mod:NewCastAnnounce(227776, 4) --Несравненная магия
local warnSummonAdds				= mod:NewSpellAnnounce(227477, 2) --Вызов помощников
local warnDefyGravity				= mod:NewSpellAnnounce(227447, 2) --Неподвластность притяжению
local warnWondrousRadiance			= mod:NewSpellAnnounce(227410, 4, nil, "-Melee") --Дивное сияние

local specWarnMagicMagnificent2		= mod:NewSpecialWarningSoon(227776, nil, nil, nil, 1, 3) --Несравненная магия
local specWarnDrearyBolt			= mod:NewSpecialWarningInterrupt(227543, "HasInterrupt", nil, nil, 1, 2) --Стрела безотрадности
local specWarnFlashyBolt			= mod:NewSpecialWarningInterrupt(227341, "HasInterrupt", nil, nil, 1, 2) --Слепящая стрела
local specWarnSummonAdds			= mod:NewSpecialWarningSwitch(227477, "Tank|Dps", nil, nil, 1, 2) --Вызов помощников
local specWarnMagicMagnificent		= mod:NewSpecialWarningMoveTo(227776, nil, nil, nil, 3, 6) --Несравненная магия
local specWarnWondrousRadiance		= mod:NewSpecialWarningDodge(227410, "Melee", nil, nil, 2, 3) --Дивное сияние

local timerSummonAddsCD				= mod:NewCDTimer(32.7, 227477, nil, "Tank|Dps", nil, 1, nil, DBM_CORE_TANK_ICON..DBM_CORE_DAMAGE_ICON) --Вызов помощников +++
local timerMagicMagnificentCD		= mod:NewCDTimer(46.1, 227776, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Несравненная магия +++
local timerMagicMagnificent			= mod:NewCastTimer(5, 227776, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Несравненная магия +++
local timerWondrousRadianceCD		= mod:NewCDTimer(10, 227410, nil, "Melee", nil, 5, nil, DBM_CORE_DEADLY_ICON) --Дивное сияние +++
local timerDefyGravityCD			= mod:NewCDTimer(18.5, 227447, nil, nil, nil, 7) --Неподвластность притяжению +++

local countdownMagicMagnificent		= mod:NewCountdown(46.1, 227776) --Несравненная магия
local countdownMagicMagnificent2	= mod:NewCountdownFades("AltTwo5", 227776) --Несравненная магия

local defyGravity = DBM:GetSpellInfo(227405)

function mod:OnCombatStart(delay)
	if self:IsMythic() then
		timerDefyGravityCD:Start(10.5-delay) --Неподвластность притяжению +++
		timerWondrousRadianceCD:Start(7.8-delay) --Дивное сияние +++
		timerSummonAddsCD:Start(31-delay) --Вызов помощников +++
		timerMagicMagnificentCD:Start(48-delay) --Несравненная магия +++
		countdownMagicMagnificent:Start(48-delay) --Несравненная магия +++
		specWarnMagicMagnificent2:Schedule(43-delay) --Несравненная магия
	--	specWarnMagicMagnificent2:ScheduleVoice(43-delay, "aesoon") --Несравненная магия
	else
		timerWondrousRadianceCD:Start(8.3-delay) --Дивное сияние
		timerSummonAddsCD:Start(30-delay) --Вызов помощников
		timerMagicMagnificentCD:Start(47-delay) --Несравненная магия
		countdownMagicMagnificent:Start(47-delay) --Несравненная магия
		specWarnMagicMagnificent2:Schedule(42-delay) --Несравненная магия
	--	specWarnMagicMagnificent2:ScheduleVoice(42-delay, "aesoon") --Несравненная магия
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 227776 then --Несравненная магия
		warnMagicMagnificent:Show()
		if not UnitIsDeadOrGhost("player") then
			specWarnMagicMagnificent:Show(defyGravity)
		--	specWarnMagicMagnificent:Play("findshelter")
		end
		timerMagicMagnificent:Start()
		countdownMagicMagnificent2:Start()
		if self:IsMythic() then
			timerMagicMagnificentCD:Start(48)
			countdownMagicMagnificent:Start(48)
			specWarnMagicMagnificent2:Schedule(43)
		--	specWarnMagicMagnificent2:ScheduleVoice(43, "aesoon")
		else
			timerMagicMagnificentCD:Start()
			countdownMagicMagnificent:Start()
			specWarnMagicMagnificent2:Schedule(41.1)
		--	specWarnMagicMagnificent2:ScheduleVoice(41.1, "aesoon")
		end
	elseif spellId == 227477 then --Вызов помощников
		warnSummonAdds:Show()
		if not UnitIsDeadOrGhost("player") then
			specWarnSummonAdds:Schedule(1)
		--	specWarnSummonAdds:ScheduleVoice(1, "mobkill")
		end
		if self:IsHard() then
			timerSummonAddsCD:Start(32.2)
		else
			timerSummonAddsCD:Start()
		end
	elseif spellId == 227447 then --Неподвластность притяжению
		warnDefyGravity:Show()
		if self:IsHard() then
			timerDefyGravityCD:Start()
		else
			timerDefyGravityCD:Start()
		end
	elseif spellId == 227543 then --Стрела безотрадности
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnDrearyBolt:Show()
		--	specWarnDrearyBolt:Play("kickcast")
		end
	elseif spellId == 227341 then --Слепящая стрела
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnFlashyBolt:Show()
		--	specWarnFlashyBolt:Play("kickcast")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 227410 then --Дивное сияние
		warnWondrousRadiance:Show()
		if not UnitIsDeadOrGhost("player") then
			specWarnWondrousRadiance:Show()
		--	specWarnWondrousRadiance:Play("watchstep")
		end
		timerWondrousRadianceCD:Start()
	end
end
