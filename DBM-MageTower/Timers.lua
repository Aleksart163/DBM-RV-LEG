local mod	= DBM:NewMod("Timers", "DBM-MageTower", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17745 $"):sub(12, -3))
mod:SetZone()

mod.isTrashMod = true
mod.noStatistics = true

mod:RegisterEvents(
--	"SPELL_CAST_START 235823",
	"SPELL_AURA_APPLIED 235984",
	"CHAT_MSG_MONSTER_YELL",
	"CHAT_MSG_MONSTER_SAY"
)

--Башня магов на Расколотом берегу, ролевые игры и треш
local warnHatefulGaze				= mod:NewTargetAnnounce(235984, 3) --Жалящая мана

local specWarnKnifeDance			= mod:NewSpecialWarningDodge(235823, nil, nil, nil, 2, 2) --Танец с кинжалами

local timerRoleplay					= mod:NewTimer(30, "timerRoleplay", "Interface\\Icons\\ability_warrior_offensivestance", nil, nil, 7)

local countdownPull					= mod:NewCountdown(15, 212702, nil, nil, 5)

local pull = false

--[[
function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 235823 and self:AntiSpam(2, 1) then --Танец с кинжалами
		specWarnKnifeDance:Show()
		specWarnKnifeDance:Play("watchstep")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 235984 then --Жалящая мана
		warnHatefulGaze:Show(args.destName)
	end
end]]

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Twins then --Разделить близнецов
		timerRoleplay:Start(22)
		countdownPull:Start(22)
	elseif msg == L.Agatha then --Невероятный противник
		timerRoleplay:Start(17)
		countdownPull:Start(17)
	elseif msg == L.Sigryn then --Ярость королевы-богини
		timerRoleplay:Start(20)
		countdownPull:Start(20)
	elseif msg:find(L.Xylem) then --Око Бури
		timerRoleplay:Start(22)
		countdownPull:Start(22)
	end
end

function mod:CHAT_MSG_MONSTER_SAY(msg)
	if msg == L.Kruul then --Верховный лорд Круул
		timerRoleplay:Start(29.2)
		countdownPull:Start(29.2)
	elseif msg == L.ErdrisThorn then --Последнее восстание
		timerRoleplay:Start(22.5) --34 при начале фулл флуда
		countdownPull:Start(22.5)
	end
end
