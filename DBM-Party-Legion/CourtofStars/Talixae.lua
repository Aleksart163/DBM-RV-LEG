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
	"SPELL_CAST_START 208165 207881 207980 207906",
	"SPELL_AURA_APPLIED 207906",
	"SPELL_AURA_APPLIED_DOSE 207906"
)
local warnBurningIntensity			= mod:NewStackAnnounce(207906, 3) --Интенсивное горение

local specWarnWitheringSoul			= mod:NewSpecialWarningInterrupt(208165, "HasInterrupt", nil, nil, 1, 3) --Иссохшая душа
local specWarnInfernalEruption		= mod:NewSpecialWarningDodge(207881, nil, nil, nil, 2, 3) --Инфернальное извержение

local timerBurningIntensityCD		= mod:NewCDTimer(23.5, 207906, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_HEALER_ICON) --Интенсивное горение +++
local timerWitheringSoulCD			= mod:NewCDTimer(14.5, 208165, nil, "HasInterrupt", nil, 3, nil, DBM_CORE_INTERRUPT_ICON) --Иссохшая душа +++
local timerInfernalEruptionCD		= mod:NewCDTimer(32, 207881, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON..DBM_CORE_MYTHIC_ICON) --Инфернальное извержение +++

local countdownInfernalEruption		= mod:NewCountdown(32, 207881, nil, nil, 5) --Инфернальное извержение

function mod:OnCombatStart(delay)
	timerWitheringSoulCD:Start(12-delay)
	if self:IsHard() then
		timerInfernalEruptionCD:Start(14-delay) --Инфернальное извержение +++
		countdownInfernalEruption:Start(14-delay)
		timerBurningIntensityCD:Start(6-delay) --Интенсивное горение +++
	else
		timerInfernalEruptionCD:Start(19.5-delay) --Инфернальное извержение
		countdownInfernalEruption:Start(19.5-delay) --Инфернальное извержение
		timerBurningIntensityCD:Start(8-delay) --Интенсивное горение
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 208165 then --Иссохшая душа
		specWarnWitheringSoul:Show()
		timerWitheringSoulCD:Start()
	elseif spellId == 207881 then --Инфернальное извержение
		specWarnInfernalEruption:Show()
		specWarnInfernalEruption:Play("watchstep")
		if self:IsHard() then
			timerInfernalEruptionCD:Start(20.5)
			countdownInfernalEruption:Start(20.5)
		else
			timerInfernalEruptionCD:Start()
		end
	elseif spellId == 207906 then --Интенсивное горение
		if self:IsHard() then
			timerBurningIntensityCD:Start(23)
		else
			timerBurningIntensityCD:Start()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 207906 then --Интенсивное горение
		local amount = args.amount or 1
		warnBurningIntensity:Show(args.destName, amount)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
