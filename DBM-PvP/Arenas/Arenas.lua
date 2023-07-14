local mod		= DBM:NewMod("Arenas", "DBM-PvP", 1)
local L			= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED 225649",
	"CHAT_MSG_BG_SYSTEM_NEUTRAL"
)

--Прошляпанное очко Мурчаля Прошляпенко [✔]

local warnShadowSight		= mod:NewTargetAnnounce(225649, 2) --Сумеречное зрение

local specWarnShadowSight	= mod:NewSpecialWarningYou(225649, nil, nil, nil, 1, 2) --Сумеречное зрение

local timerShadow			= mod:NewTimer(59.5, "TimerShadow", 34709, nil, nil, 7) --Сумеречное зрение
--local timerDamp				= mod:NewCastTimer(300, 110310, 34709, nil, nil, 3) --Ослабление
local timerCombatStart		= mod:NewTimer(30, "timerCombatStart", "Interface\\Icons\\Spell_Holy_BorrowedTime", nil, nil, 7) --начало боя

local countdownMatchStart	= mod:NewCountdown(15, 91344, nil, nil, 5) --начало боя

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 225649 then --Сумеречное зрение
		if args:IsPlayer() then
			specWarnShadowSight:Show()
			specWarnShadowSight:Play("targetyou")
		else
			warnShadowSight:Show(args.destName)
		end
	end
end

function mod:CHAT_MSG_BG_SYSTEM_NEUTRAL(msg)
	if IsActiveBattlefieldArena() and msg == L.Start15 then
	--	timerShadow:Schedule(16)
	--	timerDamp:Schedule(16)
		timerCombatStart:Start(16)
		countdownMatchStart:Start(16)
	elseif msg == L.highmaulArena then
		timerCombatStart:Start(30)
		countdownMatchStart:Start(30)
	elseif msg == L.Start then
		timerShadow:Start(60)
		timerCombatStart:Cancel()
		countdownMatchStart:Cancel()
	end
end
