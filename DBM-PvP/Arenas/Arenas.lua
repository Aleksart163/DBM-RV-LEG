local mod		= DBM:NewMod("Arenas", "DBM-PvP", 1)
local L			= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED 34709",
	"CHAT_MSG_BG_SYSTEM_NEUTRAL"
)

-- Прошляпанное очко Мурчаля Прошляпенко [✔] --

local warnShadowSight		= mod:NewTargetAnnounce(34709, 2) --Сумеречное зрение

local specWarnShadowSight	= mod:NewSpecialWarningYou(34709, nil, nil, nil, 1, 2) --Сумеречное зрение

local timerShadow			= mod:NewTimer(59.5, "TimerShadow", 34709, nil, nil, 7) --Сумеречное зрение
local timerCombatStart		= mod:NewTimer(30, "timerCombatStart", "Interface\\Icons\\Spell_Holy_BorrowedTime", nil, nil, 7) --начало боя

local countdownMatchStart	= mod:NewCountdown(15, 91344, nil, nil, 5) --начало боя

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 34709 then --Сумеречное зрение
		if args:IsPlayer() then
			specWarnShadowSight:Show()
			specWarnShadowSight:Play("targetyou")
		else
			warnShadowSight:Show(args.destName)
		end
	end
end

function mod:CHAT_MSG_BG_SYSTEM_NEUTRAL(msg)
	if msg == L.Start then
		timerShadow:Start(60)
		timerCombatStart:Cancel()
		countdownMatchStart:Cancel()
	elseif msg == L.Start30 then
		timerCombatStart:Start(30)
		countdownMatchStart:Start(30)
	elseif IsActiveBattlefieldArena() and msg == L.Start15 then
		timerCombatStart:Cancel()
		countdownMatchStart:Cancel()
		timerCombatStart:Start(15)
		countdownMatchStart:Start(15)
	end
end
