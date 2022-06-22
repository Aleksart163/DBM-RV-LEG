local mod	= DBM:NewMod(1820, "DBM-Party-Legion", 11, 860)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(114284, 114251)
mod:SetEncounterID(1957)--Shared (so not used for encounter START since it'd fire 3 mods)
mod:DisableESCombatDetection()--However, with ES disabled, EncounterID can be used for BOSS_KILL/ENCOUNTER_END
mod:SetZone()
--mod:SetUsedIcons(1)
--mod:SetHotfixNoticeRev(14922)
--mod.respawnTime = 30

mod.noNormal = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 227776 227477 227447",
	"SPELL_CAST_SUCCESS 227410"
)

--TODO, info frame tracking players who do not have gravity when aoe cast starts?
--Злюкер
local warnMagicMagnificent2			= mod:NewSoonAnnounce(227776, 1) --Несравненная магия
local warnMagicMagnificent			= mod:NewCastAnnounce(227776, 4) --Несравненная магия
local warnSummonAdds				= mod:NewSpellAnnounce(227477, 2) --Вызов помощников
local warnDefyGravity				= mod:NewSpellAnnounce(227447, 2) --Неподвластность притяжению
local warnWondrousRadiance			= mod:NewSpellAnnounce(227410, 4, nil, "-Melee") --Дивное сияние

local specWarnSummonAdds			= mod:NewSpecialWarningSwitch(227477, "Tank|Dps", nil, nil, 1, 2) --Вызов помощников
local specWarnMagicMagnificent		= mod:NewSpecialWarningMoveTo(227776, nil, nil, nil, 3, 5) --Несравненная магия
--local specWarnWondrousRadiance		= mod:NewSpecialWarningMove(227416, nil, nil, nil, 1, 2) --Дивное сияние
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
	if not self:IsNormal() then
		timerDefyGravityCD:Start(10.5-delay) --Неподвластность притяжению +++
		timerWondrousRadianceCD:Start(7.8-delay) --Дивное сияние +++
		timerSummonAddsCD:Start(31-delay) --Вызов помощников +++
		timerMagicMagnificentCD:Start(48-delay) --Несравненная магия +++
		countdownMagicMagnificent:Start(48-delay) --Несравненная магия +++
		warnMagicMagnificent2:Schedule(43-delay) --Несравненная магия
	else
		timerWondrousRadianceCD:Start(8.3-delay) --Дивное сияние
		timerSummonAddsCD:Start(30-delay) --Вызов помощников
		timerMagicMagnificentCD:Start(47-delay) --Несравненная магия
		countdownMagicMagnificent:Start(47-delay) --Несравненная магия
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 227776 then --Несравненная магия
		warnMagicMagnificent:Show()
		specWarnMagicMagnificent:Show(defyGravity)
		specWarnMagicMagnificent:Play("findshelter")
		timerMagicMagnificent:Start()
		countdownMagicMagnificent2:Start()
		if self:IsHard() then
			timerMagicMagnificentCD:Start(48)
			countdownMagicMagnificent:Start(48)
			warnMagicMagnificent2:Schedule(43)
		else
			timerMagicMagnificentCD:Start()
			countdownMagicMagnificent:Start()
			warnMagicMagnificent2:Schedule(41.1)
		end
	elseif spellId == 227477 then --Вызов помощников
		warnSummonAdds:Show()
		specWarnSummonAdds:Schedule(1)
		specWarnSummonAdds:ScheduleVoice(1, "switch")
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
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 227410 then --Дивное сияние
		warnWondrousRadiance:Show()
		specWarnWondrousRadiance:Show()
		specWarnWondrousRadiance:Play("watchstep")
		timerWondrousRadianceCD:Start()
	end
end
