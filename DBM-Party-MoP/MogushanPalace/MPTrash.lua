local mod	= DBM:NewMod("MPTrash", "DBM-Party-MoP", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 118940",
	"SPELL_AURA_APPLIED 118903",
	"CHAT_MSG_MONSTER_YELL"
)

local warnCleansingFlame				= mod:NewCastAnnounce(118940, 2) --Очищающее пламя
local warnHexofLethargy					= mod:NewTargetAnnounce(118903, 2) --Проклятие летаргии

local specWarnCleansingFlame			= mod:NewSpecialWarningInterrupt(118940, "HasInterrupt", nil, nil, 1, 2) --Очищающее пламя
local specWarnHexofLethargy				= mod:NewSpecialWarningYouDispel(118903, "MagicDispeller2", nil, nil, 2, 3) --Проклятие летаргии
local specWarnHexofLethargy2			= mod:NewSpecialWarningDispel(118903, "MagicDispeller2", nil, nil, 1, 3) --Проклятие летаргии

local yellHexofLethargy					= mod:NewYellDispel(118903, nil, nil, nil, "YELL") --Проклятие летаргии

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 118940 then --Очищающее пламя
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnCleansingFlame:Show()
			specWarnCleansingFlame:Play("kickcast")
		else
			warnCleansingFlame:Show()
			warnCleansingFlame:Play("kickcast")
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 118903 then --Проклятие летаргии
		if args:IsPlayer() and not self:IsMagicDispeller2()then
			yellHexofLethargy:Yell()
		elseif args:IsPlayer() and self:IsMagicDispeller2() then
			specWarnHexofLethargy:Show()
			specWarnHexofLethargy:Play("dispelnow")
			yellHexofLethargy:Yell()
		elseif not args:IsPlayer() and self:IsMagicDispeller2() then
			if not UnitIsDeadOrGhost("player") then
				specWarnHexofLethargy2:CombinedShow(0.3, args.destName)
				specWarnHexofLethargy2:ScheduleVoice(0.5, "dispelnow")
			end
		else
			warnHexofLethargy:CombinedShow(0.3, args.destName)
		end
	end
end
