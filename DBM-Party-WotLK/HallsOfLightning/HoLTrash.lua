local mod	= DBM:NewMod("HoLTrash", "DBM-Party-WotLK", 3, 275)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetZone()
mod.isTrashMod = true

mod:RegisterEvents(
--	"SPELL_CAST_START 88186 88010",
	"SPELL_AURA_APPLIED 59165 60236",
	"SPELL_AURA_REMOVED 59165 60236",
	"CHAT_MSG_MONSTER_YELL"
)

local warnSleep							= mod:NewTargetAnnounce(59165, 2) --Сон
local warnCyclone						= mod:NewTargetAnnounce(60236, 2) --Смерч

local timerSleep						= mod:NewTargetTimer(5, 59165, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON) --Сон
local timerRoleplay						= mod:NewTimer(41.4, "timerRoleplay", "Interface\\Icons\\Spell_Holy_BorrowedTime", nil, nil, 7)

local yellSleep							= mod:NewYellDispel(59165, nil, nil, nil, "YELL") --Сон
local yellSleep2						= mod:NewFadesYell(59165, nil, nil, nil, "YELL") --Сон
local yellCyclone						= mod:NewYell(60236, nil, nil, nil, "YELL") --Смерч
local yellCyclone2						= mod:NewFadesYell(60236, nil, nil, nil, "YELL") --Смерч

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 59165 then --Сон
		if args:IsPlayer() then
			yellSleep:Yell()
			yellSleep2:Countdown(5, 3)
		else
			warnSleep:CombinedShow(0.3, args.destName)
		end
		timerSleep:Start(args.destName)
	elseif spellId == 60236 then --Смерч
		if args:IsPlayer() then
			yellCyclone:Yell()
			yellCyclone2:Countdown(4, 3)
		else
			warnCyclone:CombinedShow(0.3, args.destName)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 59165 then --Сон
		if args:IsPlayer() then
			yellSleep2:Cancel()
		end
		timerSleep:Cancel(args.destName)
	elseif spellId == 60236 then --Смерч
		if args:IsPlayer() then
			yellCyclone2:Cancel()
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.RPLoken then
		self:SendSync("ProshlyapMurchal1")
	end
end

function mod:OnSync(msg)
	if msg == "ProshlyapMurchal1" then
		timerRoleplay:Start()
	end
end
