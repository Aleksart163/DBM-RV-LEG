local mod	= DBM:NewMod("EoATrash", "DBM-Party-Legion", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()
mod:SetUsedIcons(8, 7)
mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 196870 195046 195284 197105",
	"SPELL_AURA_APPLIED 196127 192706 197105 196144",
	"SPELL_AURA_REMOVED 197105 192706"
)

--TODO, still missing some GTFOs for this. Possibly other important spells.
--Око Азшары
local warnArcaneBomb			= mod:NewTargetAnnounce(192706, 4) --Чародейская бомба
local warnPolymorph				= mod:NewTargetAnnounce(197105, 1) --Превращение в рыбу
local warnSandstorm				= mod:NewTargetAnnounce(196144, 2) --Песчаная буря

local specWarnPolymorph			= mod:NewSpecialWarningInterrupt(197105, "HasInterrupt", nil, nil, 3, 5) --Превращение в рыбу
local specWarnPolymorph2		= mod:NewSpecialWarningDispel(197105, "Healer", nil, nil, 1, 2) --Превращение в рыбу
local specWarnStorm				= mod:NewSpecialWarningInterrupt(196870, "HasInterrupt", nil, nil, 1, 2) --Буря
local specWarnRejuvWaters		= mod:NewSpecialWarningInterrupt(195046, "HasInterrupt", nil, nil, 1, 2) --Живительная вода
local specWarnUndertow			= mod:NewSpecialWarningInterrupt(195284, "HasInterrupt", nil, nil, 1, 2) --Водоворот Might only be interruptable by stuns, if so change option default?
local specWarnSpraySand			= mod:NewSpecialWarningDodge(196127, "Melee", nil, nil, 1, 2) --Струя песка
local specWarnArcaneBomb		= mod:NewSpecialWarningYouMoveAway(192706, nil, nil, nil, 3, 2) --Чародейская бомба
local specWarnArcaneBomb2		= mod:NewSpecialWarningDispel(192706, "MagicDispeller2", nil, nil, 1, 2) --Чародейская бомба
local specWarnSandstorm			= mod:NewSpecialWarningYou(196144, nil, nil, nil, 1, 2) --Песчаная буря

local timerArcaneBomb			= mod:NewTargetTimer(15, 192706, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON..DBM_CORE_DEADLY_ICON) --Чародейская бомба
local timerPolymorph			= mod:NewTargetTimer(8, 197105, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON) --Превращение в рыбу

local yellArcaneBomb			= mod:NewYell(192706, nil, nil, nil, "YELL") --Чародейская бомба
local yellArcaneBombFades		= mod:NewFadesYell(192706, nil, nil, nil, "YELL") --Чародейская бомба
local yellPolymorph				= mod:NewYell(197105, nil, nil, nil, "YELL") --Превращение в рыбу
local yellPolymorphFades		= mod:NewFadesYell(197105, nil, nil, nil, "YELL") --Превращение в рыбу
local yellSandstorm				= mod:NewYell(196144, nil, nil, nil, "YELL") --Песчаная буря

mod:AddSetIconOption("SetIconOnArcaneBomb", 192706, true, false, {8}) --Чародейская бомба
mod:AddSetIconOption("SetIconOnPolymorph", 197105, true, false, {7}) --Превращение в рыбу
mod:AddRangeFrameOption(10, 192706) --Чародейская бомба

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 196870 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnStorm:Show(args.sourceName)
		specWarnStorm:Play("kickcast")
	elseif spellId == 195046 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnRejuvWaters:Show(args.sourceName)
		specWarnRejuvWaters:Play("kickcast")
	elseif spellId == 195284 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnUndertow:Show(args.sourceName)
		specWarnUndertow:Play("kickcast")
	elseif spellId == 197105 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Превращение в рыбу
		specWarnPolymorph:Show(args.sourceName)
		specWarnPolymorph:Play("kickcast")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 196127 then
		specWarnSpraySand:Show()
		specWarnSpraySand:Play("shockwave")
	elseif spellId == 192706 then --Чародейская бомба
		timerArcaneBomb:Start(args.destName)
		if args:IsPlayer() then
			specWarnArcaneBomb:Show()
			specWarnArcaneBomb:Play("runout")
			yellArcaneBomb:Yell()
			yellArcaneBombFades:Countdown(15, 3)
		else
			warnArcaneBomb:Show(args.destName)
			specWarnArcaneBomb2:Show(args.destName)
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(10)
		end
		if self.Options.SetIconOnArcaneBomb then
			self:SetIcon(args.destName, 8, 15)
		end
	elseif spellId == 197105 then --Превращение
		timerPolymorph:Start(args.destName)
		if args:IsPlayer() then
			yellPolymorph:Yell()
			yellPolymorphFades:Countdown(8, 3)
		else
			warnPolymorph:Show(args.destName)
			specWarnPolymorph2:Show(args.destName)
		end
		if self.Options.SetIconOnPolymorph then
			self:SetIcon(args.destName, 7, 8)
		end
	elseif spellId == 196144 then --Песчаная буря
		if args:IsPlayer() then
			specWarnSandstorm:Show()
			specWarnSandstorm:Play("targetyou")
			yellSandstorm:Yell()
		else
			warnSandstorm:CombinedShow(0.5, args.destName)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 197105 then --Превращение
		timerPolymorph:Cancel(args.destName)
		if args:IsPlayer() then
			yellPolymorphFades:Cancel()
		end
		if self.Options.SetIconOnPolymorph then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 192706 then --Чародейская бомба
		timerArcaneBomb:Cancel(args.destName)
		if args:IsPlayer() then
			yellArcaneBombFades:Cancel()
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
		if self.Options.SetIconOnArcaneBomb then
			self:SetIcon(args.destName, 0)
		end
	end
end
