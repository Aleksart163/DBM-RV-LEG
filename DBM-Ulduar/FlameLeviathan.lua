local mod	= DBM:NewMod("FlameLeviathan", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
mod:SetCreatureID(33113)
--mod:SetEncounterID(1132)
--mod:DisableIEEUCombatDetection()
mod:SetZone()

--mod:RegisterCombat("yell", L.YellPull)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED 62396 62475 62374 62297",
	"SPELL_AURA_REMOVED 62396",
	"SPELL_SUMMON 62907",
	"UNIT_SPELLCAST_CHANNEL_STOP"
)

local warnHodirsFury		= mod:NewTargetAnnounce(62297)
local pursueTargetWarn		= mod:NewAnnounce("PursueWarn", 2, 62374)
local warnNextPursueSoon	= mod:NewAnnounce("warnNextPursueSoon", 3, 62374)
local warnFlameVents		= mod:NewSpellAnnounce(62396, 4) --Струя огня

local specWarnSystemOverload = mod:NewSpecialWarningMoreDamage(62475, nil, nil, nil, 3, 6) --Отключение системы
local pursueSpecWarn		= mod:NewSpecialWarning("SpecialPursueWarnYou")
local warnWardofLife		= mod:NewSpecialWarning("warnWardofLife")

local timerSystemOverload	= mod:NewBuffActiveTimer(20, 62475, nil, nil, nil, 7) --Отключение системы
local timerFlameVents		= mod:NewCastTimer(10, 62396, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON..DBM_CORE_DEADLY_ICON)
local timerFlameVentsCD		= mod:NewCDTimer(20, 62396, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)
local timerPursued			= mod:NewTargetTimer(30, 62374, nil, nil, nil, 3)

local guids = {}
--[[
local function buildGuidTable()
	table.wipe(guids)
	for i = 1, GetNumRaidMembers() do
		guids[UnitGUID("raid"..i.."pet") or ""] = UnitName("raid"..i)
	end
end]]

function mod:OnCombatStart(delay)
	timerFlameVentsCD:Start()
--	buildGuidTable()
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 62396 then --Струя огня
		warnFlameVents:Show()
		timerFlameVents:Start()
		timerFlameVentsCD:Start()
	elseif spellId == 62475 then --Отключение системы
		timerFlameVents:Stop()
		timerFlameVentsCD:Stop()
		timerSystemOverload:Start()
		specWarnSystemOverload:Show()
		timerFlameVentsCD:Start(40)
	elseif spellId == 62374 then --Преследование
		local player = guids[args.destGUID]
		warnNextPursueSoon:Schedule(25)
		timerPursued:Start(player)
		pursueTargetWarn:Show(player)
		if player == UnitName("player") then
			pursueSpecWarn:Show()
		end
	elseif spellId == 62297 then --Ярость Ходира
		warnHodirsFury:Show(args.destName)
	end

end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 62396 then --Струя огня
		timerFlameVents:Stop()
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 62907 and self:AntiSpam(2, "wardoflife") then --Оберег Фрейи (спаун больших мобов)
		warnWardofLife:Show()
	end
end
