local mod	= DBM:NewMod("HoLTrash", "DBM-Party-WotLK", 3, 275)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetZone()
mod.isTrashMod = true

mod:RegisterEvents(
--	"SPELL_CAST_START 88186 88010",
	"SPELL_AURA_APPLIED 59165",
	"SPELL_AURA_REMOVED 59165"
)

local warnSleep							= mod:NewTargetAnnounce(59165, 2) --Сон

local timerSleep						= mod:NewTargetTimer(5, 59165, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON) --Сон

local yellSleep							= mod:NewYellDispel(59165, nil, nil, nil, "YELL") --Сон
local yellSleep2						= mod:NewFadesYell(59165, nil, nil, nil, "YELL") --Сон

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 59165 then --Сон
		warnSleep:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			yellSleep:Yell()
			yellSleep2:Countdown(5, 3)
		end
		timerSleep:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 59165 then --Сон
		if args:IsPlayer() then
			yellSleep2:Cancel()
		end
		timerSleep:Cancel(args.destName)
	end
end
