local mod	= DBM:NewMod(644, "DBM-Party-WotLK", 5, 286)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(26861)
mod:SetEncounterID(583, 584, 2028)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 48294 59301 51750",
	"SPELL_AURA_REMOVED 48294 59301"
)

local warningBane		= mod:NewSpellAnnounce(48294, 4) --Погибель
local warningScreams	= mod:NewSpellAnnounce(51750, 2) --Крики мертвых

local timerBane			= mod:NewBuffActiveTimer(5, 48294, nil, nil, nil, 5, nil, DBM_CORE_MAGIC_ICON) --Погибель
local timerScreams		= mod:NewBuffActiveTimer(8, 51750, nil, nil, nil, 2) --Крики мертвых

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 48294 or spellId == 59301 then
		warningBane:Show()
		timerBane:Start()
	elseif spellId == 51750 and self:AntiSpam(2, 1) then
		warningScreams:Show()
		timerScreams:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 48294 or spellId == 59301 then
		timerBane:Stop()
	end
end
