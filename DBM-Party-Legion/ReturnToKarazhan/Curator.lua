local mod	= DBM:NewMod(1836, "DBM-Party-Legion", 11, 860)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(114462)
mod:SetEncounterID(1964)
mod:SetZone()
--mod:SetUsedIcons(1)
--mod:SetHotfixNoticeRev(14922)
--mod.respawnTime = 30

mod.noNormal = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 234416",
	"SPELL_AURA_APPLIED 227254 227257",
	"SPELL_AURA_APPLIED_DOSE 227257",
	"SPELL_AURA_REMOVED 227254",
	"SPELL_PERIODIC_DAMAGE 227465",
	"SPELL_PERIODIC_MISSED 227465",
	"SPELL_SUMMON 227267",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--Смотритель https://ru.wowhead.com/npc=114247/смотритель/эпохальный-журнал-сражений
local warnOverload					= mod:NewStackAnnounce(227257, 4, nil, nil, 2) --Перегрузка
local warnAdds						= mod:NewSpellAnnounce(227267, 2, nil, "Healer") --Призыв нестабильной энергии
local warnEvo						= mod:NewSpellAnnounce(227254, 2, nil, "Healer") --Прилив сил
local warnEvo2						= mod:NewPreWarnAnnounce(227254, 3, 4) --Прилив сил

local specWarnAdds					= mod:NewSpecialWarningSwitch(227267, "-Healer", nil, nil, 1, 2) --Призыв нестабильной энергии
local specWarnPowerDischarge		= mod:NewSpecialWarningYouMove(227465, nil, nil, nil, 1, 2) --Разряд энергии
local specWarnEvo					= mod:NewSpecialWarningMoreDamage(227254, "-Healer", nil, nil, 3, 2) --Прилив сил
local specWarnEvo2					= mod:NewSpecialWarningDefensive(227254, nil, nil, nil, 3, 3) --Прилив сил

local timerSummonAddCD				= mod:NewNextTimer(9.5, 227267, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON) --Призыв нестабильной энергии
local timerPowerDischargeCD			= mod:NewCDTimer(12.2, 227279, nil, nil, nil, 3) --Разряд энергии
local timerEvoCD					= mod:NewNextTimer(70, 227254, nil, nil, nil, 6, nil, DBM_CORE_DAMAGE_ICON) --Прилив сил
local timerEvo						= mod:NewBuffActiveTimer(20, 227254, nil, nil, nil, 6, nil, DBM_CORE_DEADLY_ICON) --Прилив сил

local countdownEvo					= mod:NewCountdown(70, 227254, nil, nil, 5) --Прилив сил

function mod:OnCombatStart(delay)
	if not self:IsNormal() then
		timerSummonAddCD:Start(6-delay) --Призыв нестабильной энергии
		timerPowerDischargeCD:Start(13-delay) --Разряд энергии
		timerEvoCD:Start(53-delay) --Прилив сил
		countdownEvo:Start(53) --Прилив сил
	else
		timerSummonAddCD:Start(6-delay)
		timerPowerDischargeCD:Start(13.5)
		timerEvoCD:Start(68-delay)
		countdownEvo:Start(68)
	end
end

function mod:OnCombatEnd()

end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 227267 then --Призыв нестабильной энергии
		warnAdds:Show()
		specWarnAdds:Show()
		specWarnAdds:Play("switch")
		timerSummonAddCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 227254 then --Прилив сил
		timerSummonAddCD:Stop()
		timerPowerDischargeCD:Stop()
		warnEvo:Show()
		specWarnEvo:Show()
		warnEvo2:Schedule(17)
		specWarnEvo2:Schedule(17)
		timerEvo:Start()
		countdownEvo:Start(20)
	elseif spellId == 227257 then --Перегрузка
		local amount = args.amount or 1
		warnOverload:Show(args.destName, amount)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 227254 then --Прилив сил
		timerSummonAddCD:Start(6)
		timerPowerDischargeCD:Start(13)
		timerEvoCD:Start(53.5) --для миф0 норм
		countdownEvo:Start(53.5) --для миф0 норм
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 227465 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		if self:IsHard() then
			specWarnPowerDischarge:Show()
			specWarnPowerDischarge:Play("runaway")
		end
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 227278 then
		timerPowerDischargeCD:Start()
	end
end
