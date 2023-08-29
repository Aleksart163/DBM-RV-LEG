local mod	= DBM:NewMod("Hodir", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
mod:SetCreatureID(32845)
mod:SetUsedIcons(2, 1)

mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.YellKill)

mod:RegisterEvents(
	"SPELL_CAST_START 61968",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 62478 63512 65123 65133",
--	"SPELL_AURA_APPLIED_DOSE 62478 63512 65123 65133",
	"SPELL_AURA_REMOVED 65123 65133",
	"SPELL_DAMAGE 62038 62188",
	"SPELL_MISSED 62038 62188",
	"SPELL_ABSORBED 62038 62188"
)

---Proshlyapation---
local warnStormCloud		= mod:NewTargetAnnounce(65123) --Грозовая туча

local specWarnBitingCold	= mod:NewSpecialWarningYouMove(62188, nil, nil, nil, 1, 2) --Трескучий мороз
local specWarnFlashFreeze	= mod:NewSpecialWarningDodge(61968, nil, nil, nil, 2, 3) --Ледяная вспышка
local specWarnFlashFreeze2	= mod:NewSpecialWarningMoveTo(61968, nil, nil, nil, 3, 6) --Ледяная вспышка
local specWarnStormCloud	= mod:NewSpecialWarningYou(65123, nil, nil, nil, 1, 2) --Грозовая туча
local specWarnFrozenBlows	= mod:NewSpecialWarningSpell(62478, nil, nil, nil, 2, 3) --Ледяные дуновения
local specWarnFrozenBlows2	= mod:NewSpecialWarningDefensive(62478, nil, nil, nil, 5, 6) --Ледяные дуновения

local timerFrozenBlows		= mod:NewBuffActiveTimer(20, 63512, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON..DBM_CORE_DEADLY_ICON) --Ледяные дуновения
local timerFlashFreeze		= mod:NewCastTimer(9, 61968, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Ледяная вспышка
local timerFlashFrCD		= mod:NewCDTimer(50, 61968, nil, nil, nil, 7) --Ледяная вспышка
local timerAchieve			= mod:NewAchievementTimer(179, 12347, "TimerSpeedKill", nil, nil, 7)
local enrageTimer			= mod:NewBerserkTimer(475)

local yellStormCloud		= mod:NewYell(65123, nil, nil, nil, "YELL") --Грозовая туча

local countdownFlashFreeze	= mod:NewCountdown(50, 61968, nil, nil, 5) --Ледяная вспышка
local countdownFlashFreeze2	= mod:NewCountdownFades(9, 61968, nil, nil, 5) --Ледяная вспышка

mod:AddSetIconOption("SetIconOnStormCloud", 65123, true, false, {2, 1})

mod.vb.stormCloudIcon = 1

local snowdrift = DBM:GetSpellInfo(62463) --Сугроб

function mod:MurchalProshlyapationTarget(targetname, uId) --очко Прошляпенко
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnFrozenBlows2:Show()
		specWarnFrozenBlows2:Play("defensive")
	else
		specWarnFrozenBlows:Show()
		specWarnFrozenBlows:Play("aesoon")
	end
end

function mod:OnCombatStart(delay)
	self.vb.stormCloudIcon = 1
	enrageTimer:Start(-delay)
	timerAchieve:Start()
	timerFlashFrCD:Start(-delay)
	countdownFlashFreeze:Start(-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 61968 then --Ледяная вспышка
		specWarnFlashFreeze:Show()
		specWarnFlashFreeze:Play("watchstep")
		timerFlashFreeze:Start()
		countdownFlashFreeze2:Start()
		timerFlashFrCD:Start()
		countdownFlashFreeze:Start()
		specWarnFlashFreeze2:Schedule(5, snowdrift)
		specWarnFlashFreeze2:ScheduleVoice(5, "justrun")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 62478 or spellId == 63512 then --Ледяные дуновения
		self:BossTargetScanner(args.sourceGUID, "MurchalProshlyapationTarget", 0.1, 2)
		timerFrozenBlows:Start()
	elseif spellId == 65123 or spellId == 65133 then --Грозовая туча
		if args:IsPlayer() then
			specWarnStormCloud:Show()
			specWarnStormCloud:Play("gathershare")
			yellStormCloud:Yell()
		else
			warnStormCloud:Show(args.destName)
		end
		if self.Options.SetIconOnStormCloud then 
			self:SetIcon(args.destName, self.vb.stormCloudIcon)
		end
		if self.vb.stormCloudIcon == 1 then
			self.vb.stormCloudIcon = 2
		else
			self.vb.stormCloudIcon = 1
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 65123 or spellId == 65133 then --Грозовая туча
		if self.Options.SetIconOnStormCloud then
			self:RemoveIcon(args.destName)
		end
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 62038 or spellId == 62188 and destGUID == UnitGUID("player") and self:AntiSpam(2.5, "bitingcold") then
		specWarnBitingCold:Show()
		specWarnBitingCold:Play("runout")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE
mod.SPELL_ABSORBED = mod.SPELL_DAMAGE
