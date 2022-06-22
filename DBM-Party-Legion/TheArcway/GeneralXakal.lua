local mod	= DBM:NewMod(1499, "DBM-Party-Legion", 6, 726)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(98206)
mod:SetEncounterID(1828)
mod:SetZone()

mod.noNormal = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 197776 212030 197810",
--	"SPELL_CAST_SUCCESS 197788",
	"SPELL_PERIODIC_DAMAGE 220443",
	"SPELL_PERIODIC_MISSED 220443"
)

--Генерал Ксакал https://ru.wowhead.com/npc=98206/генерал-ксакал/эпохальный-журнал-сражений
local warnSlam						= mod:NewPreWarnAnnounce(197810, 5, 1) --Злодейский мощный удар

local specWarnWakeofShadows			= mod:NewSpecialWarningYouMove(220443, nil, nil, nil, 1, 2) --Темный след
local specWarnBat					= mod:NewSpecialWarningSwitch("ej12489", "-Healer", nil, nil, 1, 2) --Треш
local specWarnFissure				= mod:NewSpecialWarningDodge(197776, nil, nil, nil, 2, 2) --Разлом Скверны
local specWarnSlash					= mod:NewSpecialWarningDodge(212030, nil, nil, nil, 2, 2) --Темное рассечение
local specWarnSlam					= mod:NewSpecialWarningDefensive(197810, nil, nil, nil, 3, 2) --Злодейский мощный удар

local timerBatCD					= mod:NewNextTimer(31, "ej12489", nil, nil, nil, 1, 183219, DBM_CORE_DAMAGE_ICON) --Треш 31.1
--Both 13 unless delayed by other interactions. Seems similar to archimondes timer code with a hard ICD mechanic.
local timerFissureCD				= mod:NewCDTimer(23, 197776, nil, nil, nil, 7) --Разлом Скверны +++
local timerSlashCD					= mod:NewCDTimer(25, 212030, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON..DBM_CORE_MYTHIC_ICON) --Темное рассечение 25-30 +++
local timerSlamCD					= mod:NewCDTimer(47, 197810, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Злодейский мощный удар Possibly 40 but delayed by ICD triggering

local countdownSlam					= mod:NewCountdown(47, 197810, nil, nil, 5) --Злодейский мощный удар
--Ураганный обстрел 197788 12 залпов
mod.vb.batCount = 0

local function blizzardHatesBossMods(self)
	specWarnBat:Show()
	specWarnBat:Play("mobsoon")
	if not self:IsNormal() then
		timerBatCD:Start(30.7)
		self:Schedule(30.7, blizzardHatesBossMods, self)
	else
		timerBatCD:Start()
		self:Schedule(31, blizzardHatesBossMods, self)
	end
end

function mod:OnCombatStart(delay)
	self.vb.batCount = 0
	if not self:IsNormal() then
		timerFissureCD:Start(6.2-delay) --Разлом Скверны+++
		timerSlashCD:Start(13.5-delay) --Темное рассечение+++
		timerBatCD:Start(26.5-delay) --Треш+++
		self:Schedule(26.5, blizzardHatesBossMods, self)
		timerSlamCD:Start(36.8-delay) --Злодейский мощный удар+++
		countdownSlam:Start(36.8-delay) --Злодейский мощный удар+++
		warnSlam:Schedule(31.8-delay) --Злодейский мощный удар+++
	else
		timerFissureCD:Start(5-delay)
		timerSlashCD:Start(13-delay)
		timerBatCD:Start(20-delay)
		self:Schedule(20, blizzardHatesBossMods, self)
		timerSlamCD:Start(35.8-delay)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 197776 then
		specWarnFissure:Show()
		specWarnFissure:Play("watchstep")
		timerFissureCD:Start()
		--updateAlltimers(6)
	elseif spellId == 212030 then
		specWarnSlash:Show()
		specWarnSlash:Play("watchwave")
		timerSlashCD:Start()
		--updateAlltimers(6)
	elseif spellId == 197810 then
		specWarnSlam:Show()
		specWarnSlam:Play("carefly")
		timerSlamCD:Start()
		countdownSlam:Start()
		warnSlam:Schedule(42)
		--updateAlltimers(7)--Verify is actually 7 and not 6 like others
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 197788 then --Ураганный обстрел
	self.vb.batCount = self.vb.batCount + 1
		if self.vb.batCount == 1 then
			timerBatCD:Start(9)
		elseif self.vb.batCount == 12 then
			self.vb.batCount = 0
		end
	end
end
]]
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 220443 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		if not self:IsNormal() then
			specWarnWakeofShadows:Show()
			specWarnWakeofShadows:Play("runaway")
		end
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
