local mod	= DBM:NewMod("TVPTrash", "DBM-Party-Cataclysm", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
mod:SetZone()
mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 88186 88010",
	"SPELL_AURA_APPLIED 88010",
	"SPELL_AURA_REMOVED 88010"
)

local warnCyclone						= mod:NewTargetAnnounce(88010, 4) --Смерч
local warnCyclone2						= mod:NewCastAnnounce(88010, 2) --Смерч

local specWarnCyclone					= mod:NewSpecialWarningInterrupt(88010, "HasInterrupt", nil, nil, 1, 2) --Смерч
local specWarnVaporForm					= mod:NewSpecialWarningInterrupt(88186, "HasInterrupt", nil, nil, 1, 2) --Туманный облик

local yellCyclone1						= mod:NewYell(88010, nil, nil, nil, "YELL") --Смерч
local yellCyclone2						= mod:NewFadesYell(88010, nil, nil, nil, "YELL") --Смерч

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 88186 then --Туманный облик
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnVaporForm:Show()
			specWarnVaporForm:Play("kickcast")
		end
	elseif spellId == 88010 then --Смерч
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnCyclone:Show()
			specWarnCyclone:Play("kickcast")
		else
			warnCyclone2:Show()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 88010 then --Смерч
		if args:IsPlayer() then
			yellCyclone1:Yell()
			yellCyclone2:Countdown(6, 3)
		else
			warnCyclone:CombinedShow(0.5, args.destName)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 88010 then --Смерч
		if args:IsPlayer() then
			yellCyclone2:Cancel()
		end
	end
end
