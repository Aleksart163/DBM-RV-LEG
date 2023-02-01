local mod	= DBM:NewMod("InvasionPointsTrash", "DBM-InvasionPoints")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetZone()

mod:RegisterEvents(
	"SPELL_AURA_APPLIED 251709",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

--прошляпанное очко Мурчаля Прошляпенко ✔

local warnFrozen						= mod:NewTargetAnnounce(251709, 2) --Заморозка

local specWarnFlashFreeze				= mod:NewSpecialWarningMoveTo(64175, nil, nil, nil, 2, 3) --Ледяная вспышка
local specWarnFrozen					= mod:NewSpecialWarningYou(251709, nil, nil, nil, 1, 3) --Заморозка

local timerFlashFreezeCD				= mod:NewCDTimer(39, 64175, nil, nil, nil, 7) --Ледяная вспышка
local timerFrozen						= mod:NewTargetTimer(5, 251709, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON) --Заморозка

local countdownFlashFreeze				= mod:NewCountdown("AltTwo39", 64175, nil, nil, 3) --Ледяная вспышка

local yellFrozen						= mod:NewYell(251709, nil, nil, nil, "YELL") --Заморозка

local warmth = DBM:GetSpellInfo(251547) --Тепло жаровни

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 251709 then --Заморозка
		if args:IsPlayer() then
			specWarnFrozen:Show()
			specWarnFrozen:Play("targetyou")
			timerFrozen:Start(args.destName)
			yellFrozen:Yell()
		else
			warnFrozen:CombinedShow(0.3, args.destName)
		end
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if strmatch(msg, L.MurchalOchkenProshlyapen) then
		specWarnFlashFreeze:Show(warmth)
		specWarnFlashFreeze:Play("justrun")
		timerFlashFreezeCD:Start()
		countdownFlashFreeze:Start()
	end
end
