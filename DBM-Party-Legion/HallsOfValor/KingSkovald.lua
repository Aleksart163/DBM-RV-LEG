local mod	= DBM:NewMod(1488, "DBM-Party-Legion", 4, 721)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(95675)
mod:SetEncounterID(1808)
mod:SetZone()
mod:SetUsedIcons(8, 1)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 202711",
	"SPELL_AURA_REMOVED 193826 202711",
	"SPELL_CAST_START 193659 193668 193826 194112",
	"SPELL_CAST_SUCCESS 193659",
	"SPELL_PERIODIC_DAMAGE 193702",
	"SPELL_PERIODIC_MISSED 193702"
)

--Король-бог Сковальд https://ru.wowhead.com/npc=95675/король-бог-сковальд/эпохальный-журнал-сражений
local warnAegis						= mod:NewTargetAnnounce(202711, 2) --Эгида Агграмара
local warnFelblazeRush				= mod:NewTargetAnnounce(193659, 3) --Рывок пламени Скверны
local warnClaimAegis				= mod:NewSpellAnnounce(194112, 2) --Захватить Эгиду Агграмара!

local specWarnFelblazeRush			= mod:NewSpecialWarningYouMoveAway(193659, nil, nil, nil, 3, 5) --Рывок пламени Скверны
local specWarnSavageBlade			= mod:NewSpecialWarningDefensive(193668, "Tank", nil, nil, 1, 2) --Свирепый клинок
local specWarnRagnarok				= mod:NewSpecialWarningMoveTo(193826, nil, nil, nil, 3, 5) --Рагнарек
local specWarnFlames				= mod:NewSpecialWarningYouMove(193702, nil, nil, nil, 1, 2) --Инфернальное пламя

local timerClaimAegisCD				= mod:NewCDTimer(11, 194112, nil, nil, nil, 0) --Захватить Эгиду Агграмара!
local timerRushCD					= mod:NewCDTimer(11, 193659, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Рывок пламени Скверны 11-13
local timerSavageBladeCD			= mod:NewCDTimer(22, 193668, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON) --Свирепый клинок 23
local timerRagnarokCD				= mod:NewCDTimer(53, 193826, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Рагнарек 60

local yellFelblazeRush				= mod:NewYell(193659, nil, nil, nil, "YELL") --Рывок пламени Скверны

local countdownRagnarok				= mod:NewCountdown("Alt53", 193826, nil, nil, 5) --Рагнарек
local countdownRush					= mod:NewCountdown(11, 193659, nil, nil, 5) --Рывок пламени Скверны

mod:AddSetIconOption("SetIconOnRush", 193659, true, false, {8}) --Рывок пламени Скверны
mod:AddSetIconOption("SetIconOnAegis", 202711, true, false, {1}) --Эгида Агграмара

local shield2 = DBM:GetSpellInfo(193983)

function mod:FelblazeRushTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnFelblazeRush:Show()
		specWarnFelblazeRush:Play("runout")
		yellFelblazeRush:Yell()
	else
		warnFelblazeRush:Show(targetname)
	end
	if self.Options.SetIconOnRush then
		self:SetIcon(targetname, 8, 5)
	end
end

function mod:OnCombatStart(delay)
	if not self:IsNormal() then
		timerRushCD:Start(6-delay) --Рывок пламени Скверны
		countdownRush:Start(6-delay) --Рывок пламени Скверны
		timerRagnarokCD:Start(13-delay) --Рагнарек
		countdownRagnarok:Start(13-delay) --Рагнарек
	else
		timerRushCD:Start(6-delay) --Рывок пламени Скверны
		countdownRush:Start(6-delay) --Рывок пламени Скверны
		timerRagnarokCD:Start(13-delay) --Рагнарек
		countdownRagnarok:Start(13-delay) --Рагнарек
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 202711 and args:IsDestTypePlayer() then --Эгида Агграмара
		warnAegis:Show(args.destName)
		if self.Options.SetIconOnAegis then
			self:SetIcon(args.destName, 1)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 193826 then --Рагнарек
		timerRagnarokCD:Start()
		countdownRagnarok:Start()
	elseif spellId == 202711 then --Эгида Агграмара
		if self.Options.SetIconOnAegis then
			self:SetIcon(args.destName, 0)
		end
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 193659 then --Рывок пламени Скверны
		self:BossUnitTargetScannerAbort()
	end
end]]

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 193659 then --Рывок пламени Скверны
		self:BossTargetScanner(args.sourceGUID, "FelblazeRushTarget", 0.1)
		timerRushCD:Start()
		countdownRush:Start()
	elseif spellId == 193668 then
		specWarnSavageBlade:Show()
		specWarnSavageBlade:Play("defensive")
		local elapsed, total = timerRagnarokCD:GetTime()
		local remaining = total - elapsed
		if remaining < 20 then
			--Do nothing, ragnaros will reset it
		else
			timerSavageBladeCD:Start()
		end
	elseif spellId == 193826 then --Рагнарек
		specWarnRagnarok:Show(shield2)
		specWarnRagnarok:Play("findshield")
		timerRushCD:Cancel()
		countdownRush:Cancel()
		timerRushCD:Start(12)
		countdownRush:Start(12)
		timerClaimAegisCD:Start(17)
		timerSavageBladeCD:Stop()
	elseif spellId == 194112 then --Захватить Эгида Агграмара!
		warnClaimAegis:Show()
		timerSavageBladeCD:Start(13)
		timerRushCD:Cancel()
		countdownRush:Cancel()
		timerRushCD:Start(19)
		countdownRush:Start(19)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 193702 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		if not self:IsNormal() then
			specWarnFlames:Show()
			specWarnFlames:Play("runaway")
		end
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
