local mod	= DBM:NewMod(1905, "DBM-Party-Legion", 12, 900)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17745 $"):sub(12, -3))
mod:SetCreatureID(117193)
mod:SetEncounterID(2055)
mod:SetZone()
mod:SetUsedIcons(7)
mod:SetMinSyncRevision(17745)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 235751",
	"SPELL_CAST_SUCCESS 236527 236639 236524",
	"SPELL_AURA_APPLIED 238598",
	"SPELL_AURA_REMOVED 238598",
	"SPELL_PERIODIC_DAMAGE 240065",
	"SPELL_PERIODIC_MISSED 240065",
	"RAID_BOSS_WHISPER",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--Агронокс https://ru.wowhead.com/npc=117193/агронокс/эпохальный-журнал-сражений
local warnSpores					= mod:NewCountAnnounce(236524, 3) --Ядовитые споры
local warnChokingVine				= mod:NewTargetAnnounce(238598, 4) --Удушающие лозы

local specWarnTimberSmash			= mod:NewSpecialWarningDefensive(235751, "Tank", nil, nil, 1, 2) --Удар бревном
local specWarnChokingVine			= mod:NewSpecialWarningYouRun(238598, nil, nil, nil, 4, 6) --Удушающие лозы
local specWarnSucculentSecretion	= mod:NewSpecialWarningYouMove(240065, nil, nil, nil, 1, 2) --Выброс сока
local specWarnFulminatingLashers	= mod:NewSpecialWarningSwitch(236527, "Dps", nil, nil, 1, 2) --Гремучие плеточники
local specWarnSucculentLashers		= mod:NewSpecialWarningSwitch(236639, "Dps", nil, nil, 1, 2) --Сочные плеточники
local specWarnFixate				= mod:NewSpecialWarningRun(238674, nil, nil, nil, 4, 6) --Сосредоточение внимания

local timerTimberSmashCD			= mod:NewCDTimer(21.7, 235751, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON) --Удар бревном
local timerChokingVinesCD			= mod:NewCDTimer(30, 238598, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Удушающие лозы
local timerFulminatingLashersCD		= mod:NewCDTimer(30, 236527, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON) --Гремучие плеточники
local timerSucculentLashersCD		= mod:NewCDTimer(16.5, 236639, nil, nil, nil, 1, nil, DBM_CORE_TANK_ICON..DBM_CORE_DAMAGE_ICON) --Сочные плеточники
local timerSporesCD					= mod:NewCDTimer(20.5, 236524, nil, nil, nil, 2) --Ядовитые споры

local yellFixate					= mod:NewYell(238674, nil, nil, nil, "YELL") --Сосредоточение внимания

local countdownTimberSmash			= mod:NewCountdown("Alt21.7", 235751, "Tank", nil, 5) --Удар бревном

mod:AddSetIconOption("SetIconOnChokingVines", 238598, true, false, {7}) --Удушающие лозы

mod.vb.sporesCount = 0

function mod:OnCombatStart(delay)
	self.vb.sporesCount = 0
	if self:IsHard() then
		timerTimberSmashCD:Start(6-delay) --Удар бревном
		countdownTimberSmash:Start(6-delay) --Удар бревном
		timerSporesCD:Start(12-delay) --Ядовитые споры++
		timerFulminatingLashersCD:Start(11-delay) --Гремучие плеточники+++
		timerChokingVinesCD:Start(25-delay) --Удушающие лозы+++
		timerSucculentLashersCD:Start(18-delay) --Сочные плеточники+++
	else
		timerTimberSmashCD:Start(6-delay) --Удар бревном
		countdownTimberSmash:Start(6-delay) --Удар бревном
		timerSporesCD:Start(12-delay) --Ядовитые споры
		timerFulminatingLashersCD:Start(17.5-delay) --Гремучие плеточники
		timerChokingVinesCD:Start(24.2-delay) --Удушающие лозы
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 235751 then --Удар бревном
		specWarnTimberSmash:Show()
	--	specWarnTimberSmash:Play("carefly")
		timerTimberSmashCD:Start()
		countdownTimberSmash:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 236527 then --Гремучие плеточники
		if not UnitIsDeadOrGhost("player") then
			specWarnFulminatingLashers:Show()
		--	specWarnFulminatingLashers:Play("mobkill")
		end
		if self:IsHard() then
			timerFulminatingLashersCD:Start(40)
		else
			timerFulminatingLashersCD:Start()
		end
	elseif spellId == 236639 then --Сочные плеточники
		if not UnitIsDeadOrGhost("player") then
			specWarnSucculentLashers:Show()
		--	specWarnSucculentLashers:Play("mobkill")
		end
		if self:IsHard() then
			timerSucculentLashersCD:Start(40)
		else
			timerSucculentLashersCD:Start()
		end
	elseif spellId == 236524 then --Ядовитые споры
		self.vb.sporesCount = self.vb.sporesCount + 1
		warnSpores:Show(self.vb.sporesCount)
		timerSporesCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 238598 and args:IsDestTypePlayer() then --Удушающие лозы
		if args:IsPlayer() then
			specWarnChokingVine:Show()
		--	specWarnChokingVine:Play("runaway")
		else
			warnChokingVine:Show(args.destName)
		end
		if self.Options.SetIconOnChokingVines then
			self:SetIcon(args.destName, 7)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 238598 then --Удушающие лозы
		if self.Options.SetIconOnChokingVines then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 240065 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		if not self:IsNormal() then
			specWarnSucculentSecretion:Show()
		--	specWarnSucculentSecretion:Play("runaway")
		end
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:RAID_BOSS_WHISPER(msg)
	if msg:find("spell:238674") then
		specWarnFixate:Show()
	--	specWarnFixate:Play("justrun")
	--	specWarnFixate:ScheduleVoice(1, "keepmove")
		yellFixate:Yell()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 236650 then --Удушающие лозы кд
		if self:IsHard() then
			timerChokingVinesCD:Start(35)
		else
			timerChokingVinesCD:Start()
		end
	end
end
