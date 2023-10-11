local mod	= DBM:NewMod("UPTrash", "DBM-Party-WotLK", 5, 286)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 49106 49204 48140 48700",
	"SPELL_AURA_APPLIED 49106"
)

--Вершина Утгард треш https://www.wowhead.com/ru/zone=1196/вершина-утгард#npcs
local warnTerrify					= mod:NewTargetAnnounce(49106, 3) --Запугивание

local specWarnTerrify				= mod:NewSpecialWarningInterrupt(49106, "HasInterrupt", nil, nil, 3, 2) --Запугивание
local specWarnDarkMending			= mod:NewSpecialWarningInterrupt(49204, "HasInterrupt", nil, nil, 1, 2) --Исцеление тьмой
local specWarnChainLightning		= mod:NewSpecialWarningInterrupt(48140, "HasInterrupt", nil, nil, 1, 2) --Цепная молния
local specWarnHealingWave			= mod:NewSpecialWarningInterrupt(48700, "HasInterrupt", nil, nil, 1, 2) --Волна исцеления

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 49106 then --Запугивание
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnTerrify:Show()
			specWarnTerrify:Play("kickcast")
		end
	elseif spellId == 49204 then --Исцеление тьмой
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnDarkMending:Show()
			specWarnDarkMending:Play("kickcast")
		end
	elseif spellId == 48140 then --Цепная молния
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnChainLightning:Show()
			specWarnChainLightning:Play("kickcast")
		end
	elseif spellId == 48700 then --Волна исцеления
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnHealingWave:Show()
			specWarnHealingWave:Play("kickcast")
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 49106 then --Запугивание
		warnTerrify:CombinedShow(0.3, args.destName)
	end
end
