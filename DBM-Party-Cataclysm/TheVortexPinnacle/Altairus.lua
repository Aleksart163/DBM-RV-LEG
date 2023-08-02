local mod	= DBM:NewMod(115, "DBM-Party-Cataclysm", 5, 68)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
mod:SetCreatureID(43873)
mod:SetEncounterID(1041)
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 88282 88286",
	"SPELL_CAST_START 88308"
)

local warnBreath		= mod:NewTargetNoFilterAnnounce(88308, 2) --Студеное дыхание
local warnUpwind		= mod:NewSpellAnnounce(88282, 1) --Наветренная сторона

local specWarnBreath	= mod:NewSpecialWarningYouMoveAway(88308, "-Tank", nil, 2, 3, 3) --Студеное дыхание
local specWarnBreathNear= mod:NewSpecialWarningCloseMoveAway(88308, nil, nil, nil, 2, 2) --Студеное дыхание
local specWarnDownwind	= mod:NewSpecialWarningMove(88286, nil, nil, nil, 1, 2)

local timerBreathCD		= mod:NewCDTimer(10.5, 88308, nil, nil, nil, 3) --Студеное дыхание

mod:AddSetIconOption("BreathIcon", 88308, true, false, {8}) --Студеное дыхание

mod.vb.activeWind = "none"

function mod:BreathTarget()
	local targetname = self:GetBossTarget(43873)
	if not targetname then return end
	if targetname == UnitName("player") then--Tank doesn't care about this so if your current spec is tank ignore this warning.
		specWarnBreath:Show()
		specWarnBreath:Play("moveaway")
	elseif self:CheckNearby(10, targetname) then
		specWarnBreathNear:Show(targetname)
		specWarnBreathNear:Play("runaway")
	else
		warnBreath:Show(targetname)
	end
	if self.Options.BreathIcon then
		self:SetIcon(targetname, 8, 5)
	end
end

function mod:OnCombatStart(delay)
	self.vb.activeWind = "none"
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 88282 and args:IsPlayer() and self.vb.activeWindactiveWind ~= "up" then
		warnUpwind:Show()
		self.vb.activeWindactiveWind = "up"
	elseif args.spellId == 88286 and args:IsPlayer() and self.vb.activeWindactiveWind ~= "down" then
		specWarnDownwind:Show()
		specWarnDownwind:Play("turnaway")
		self.vb.activeWindactiveWind = "down"
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 88308 then
		self:ScheduleMethod(0.2, "BreathTarget")
		timerBreathCD:Start()
	end
end
