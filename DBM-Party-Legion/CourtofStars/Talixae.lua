local mod	= DBM:NewMod(1719, "DBM-Party-Legion", 7, 800)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(104217)
mod:SetEncounterID(1869)
mod:SetZone()

mod.noNormal = true

mod:RegisterCombat("combat")

--Out of combat register, to support the secondary bosses off to sides
mod:RegisterEvents(
	"SPELL_CAST_START 208165 207881 207980 207906"
)
local warnBurningIntensity			= mod:NewSpellAnnounce(207906, 3) --Интенсивное горение

local specWarnWitheringSoul			= mod:NewSpecialWarningInterrupt(208165, "HasInterrupt2", nil, nil, 1, 3) --Иссохшая душа
local specWarnInfernalEruption		= mod:NewSpecialWarningDodge(207881, nil, nil, nil, 2, 3) --Инфернальное извержение
--local specWarnDisintegrationBeam	= mod:NewSpecialWarningSpell(207980, false, nil, 2, 1, 2)

local timerBurningIntensityCD		= mod:NewCDTimer(23.5, 207906, nil, nil, nil, 5, nil, DBM_CORE_HEALER_ICON) --Интенсивное горение
local timerWitheringSoulCD			= mod:NewCDTimer(14.5, 208165, nil, nil, nil, 3, nil, DBM_CORE_INTERRUPT_ICON) --Иссохшая душа
local timerInfernalEruptionCD		= mod:NewCDTimer(32, 207881, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Инфернальное извержение

function mod:OnCombatStart(delay)
	timerWitheringSoulCD:Start(12-delay)
	if self:IsHard() then
		timerInfernalEruptionCD:Start(14-delay)
		timerBurningIntensityCD:Start(8-delay)
	else
		timerInfernalEruptionCD:Start(19.5-delay)
		timerBurningIntensityCD:Start(8-delay)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 208165 then
		specWarnWitheringSoul:Show()
		timerWitheringSoulCD:Start()
	elseif spellId == 207881 then
		specWarnInfernalEruption:Show()
		specWarnInfernalEruption:Play("watchstep")
		if self:IsHard() then
			timerInfernalEruptionCD:Start(20.5)
		else
			timerInfernalEruptionCD:Start()
		end
	elseif spellId == 207906 then
		warnBurningIntensity:Show()
		timerBurningIntensityCD:Start()
	end
end
