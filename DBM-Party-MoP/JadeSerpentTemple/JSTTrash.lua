local mod	= DBM:NewMod("JSTTrash", "DBM-Party-MoP", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 114826",
	"SPELL_CAST_SUCCESS 118714",
	"SPELL_AURA_APPLIED 114826",
	"CHAT_MSG_MONSTER_YELL"
)

local warnSongbirdSerenade				= mod:NewTargetAnnounce(114826, 2) --Серенада певчей птицы

local specWarnSongbirdSerenade			= mod:NewSpecialWarningInterrupt(114826, "HasInterrupt", nil, nil, 1, 2) --Серенада певчей птицы
local specWarnSongbirdSerenade2			= mod:NewSpecialWarningDispel(114826, "MagicDispeller2", nil, nil, 1, 3) --Серенада певчей птицы

local timerAchieve						= mod:NewAchievementTimer(300, 6475, "TimerSpeedKill")

local yellSongbirdSerenade				= mod:NewYellDispel(114826, nil, nil, nil, "YELL") --Серенада певчей птицы

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 114826 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Серенада певчей птицы
		specWarnSongbirdSerenade:Show()
		specWarnSongbirdSerenade:Play("kickcast")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 118714 then --Чистая вода
		timerAchieve:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 114826 then --Серенада певчей птицы
		if args:IsPlayer() then
			yellSongbirdSerenade:Yell()
		elseif not args:IsPlayer() and self:IsMagicDispeller2() then
			if not UnitIsDeadOrGhost("player") then
				specWarnSongbirdSerenade2:CombinedShow(0.3, args.destName)
				specWarnSongbirdSerenade2:ScheduleVoice(0.3, "dispelnow")
			end
		else
			warnSongbirdSerenade:CombinedShow(0.3, args.destName)
		end
	end
end
