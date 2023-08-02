local mod	= DBM:NewMod(116, "DBM-Party-Cataclysm", 5, 68)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
mod:SetCreatureID(43875)
mod:SetEncounterID(1042)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START 87618 87622",
--	"SPELL_AURA_APPLIED 86911",
	"CHAT_MSG_MONSTER_YELL"
)

local warnChainLightning		= mod:NewTargetAnnounce(87622, 4) --Цепная молния
local warnStaticCling			= mod:NewSpellAnnounce(87618, 3)

local specWarnSupremacyStorm	= mod:NewSpecialWarningMoveTo(86715, nil, nil, nil, 3, 6) --Великая сила бури
local specWarnChainLightning	= mod:NewSpecialWarningYouMoveAway(87622, nil, nil, nil, 3, 3) --Цепная молния
local specWarnStaticCling		= mod:NewSpecialWarningJump(87618, nil, nil, nil, 1, 2)

local timerGroundingField		= mod:NewCDTimer(72, 86911, nil, nil, nil, 7) --Нестабильное заземляющее поле
local timerSupremacyStormCD		= mod:NewCDTimer(20, 86715, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Великая сила бури

local countdownSupremacyStorm	= mod:NewCountdown(20, 86715, nil, nil, 5) --Великая сила бури
local countdownGroundingField	= mod:NewCountdown(72, 86911, nil, nil, 5) --Нестабильное заземляющее поле

local yellChainLightning		= mod:NewYell(87622, nil, nil, nil, "YELL") --Цепная молния

local field = DBM:GetSpellInfo(86911) --Нестабильное заземляющее поле

function mod:ChainLightningTarget(targetname, uId) --Прошляпанное очко Мурчаля [✔]
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnChainLightning:Show()
		specWarnChainLightning:Play("runout")
		yellChainLightning:Yell()
	else
		warnChainLightning:Show(targetname)
	end
end

--[[function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 86911 then
		timerGroundingField:Start()
	end
end]]

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 87618 then
		warnStaticCling:Show(args.spellName)
		specWarnStaticCling:Schedule(0.625)--delay message since jumping at start of cast is no longer correct in 4.0.6+
		specWarnStaticCling:ScheduleVoice(0.625, "jumpnow")
	elseif spellId == 87622 then --Цепная молния
		self:BossTargetScanner(args.sourceGUID, "ChainLightningTarget", 0.1, 2)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellProshlyapMurchal then
		specWarnSupremacyStorm:Schedule(5, field)
		specWarnSupremacyStorm:ScheduleVoice(5, "justrun")
		timerSupremacyStormCD:Start()
		timerGroundingField:Start()
		countdownSupremacyStorm:Start()
		countdownGroundingField:Start()
	end
end
