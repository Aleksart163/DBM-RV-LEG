local mod	= DBM:NewMod("EoATrash", "DBM-Party-Legion", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()
mod:SetUsedIcons(8, 7, 6)
mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 196870 195046 195284 197105 196127 195253 196175 195129 196290 196296",
	"SPELL_AURA_APPLIED 196127 192706 197105 196144 195253",
	"SPELL_AURA_REMOVED 197105 192706 195253"
)
--бурлящая буря
--Око Азшары
local warnArcaneBomb			= mod:NewTargetAnnounce(192706, 4) --Чародейская бомба
local warnImprisoningBubble		= mod:NewTargetAnnounce(195253, 4) --Пузырь-тюрьма
local warnPolymorph				= mod:NewTargetAnnounce(197105, 2) --Превращение в рыбу
local warnSandstorm				= mod:NewTargetAnnounce(196144, 2) --Песчаная буря

local specWarnRoilingStorm		= mod:NewSpecialWarningDodge(196296, nil, nil, nil, 2, 3) --Бурлящая буря
local specWarnChaoticTempest	= mod:NewSpecialWarningDodge(196290, nil, nil, nil, 2, 3) --Буря Хаоса
local specWarnThunderingStomp	= mod:NewSpecialWarningInterrupt(195129, "HasInterrupt", nil, nil, 1, 2) --Грохочущий топот
local specWarnArmorshell		= mod:NewSpecialWarningInterrupt(196175, "HasInterrupt", nil, nil, 1, 2) --Бронераковина
local specWarnImprisoningBubble	= mod:NewSpecialWarningInterrupt(195253, "HasInterrupt", nil, nil, 3, 5) --Пузырь-тюрьма
local specWarnImprisoningBubble2 = mod:NewSpecialWarningDispel(195253, "MagicDispeller2", nil, nil, 1, 2) --Пузырь-тюрьма
local specWarnPolymorph			= mod:NewSpecialWarningInterrupt(197105, "HasInterrupt", nil, nil, 3, 5) --Превращение в рыбу
local specWarnPolymorph2		= mod:NewSpecialWarningDispel(197105, "MagicDispeller2", nil, nil, 1, 2) --Превращение в рыбу
local specWarnArcaneBomb		= mod:NewSpecialWarningYouMoveAway(192706, nil, nil, nil, 3, 2) --Чародейская бомба
local specWarnArcaneBomb2		= mod:NewSpecialWarningDispel(192706, "MagicDispeller2", nil, nil, 1, 2) --Чародейская бомба
local specWarnArcaneBomb3		= mod:NewSpecialWarningEnd(192706, nil, nil, nil, 1, 2) --Чародейская бомба
local specWarnStorm				= mod:NewSpecialWarningInterrupt(196870, "HasInterrupt", nil, nil, 1, 2) --Буря
local specWarnRejuvWaters		= mod:NewSpecialWarningInterrupt(195046, "HasInterrupt", nil, nil, 1, 2) --Живительная вода
local specWarnUndertow			= mod:NewSpecialWarningMoveAway(195284, "-Tank", nil, nil, 4, 5) --Водоворот
local specWarnSpraySand			= mod:NewSpecialWarningDodge(196127, "Melee", nil, nil, 1, 2) --Струя песка
local specWarnSandstorm			= mod:NewSpecialWarningYou(196144, nil, nil, nil, 1, 2) --Песчаная буря

local timerUndertow				= mod:NewCastTimer(10, 195284, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Водоворот
local timerImprisoningBubble	= mod:NewTargetTimer(12, 195253, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON..DBM_CORE_DEADLY_ICON) --Пузырь-тюрьма
local timerArcaneBomb			= mod:NewTargetTimer(15, 192706, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON..DBM_CORE_DEADLY_ICON) --Чародейская бомба
local timerPolymorph			= mod:NewTargetTimer(8, 197105, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON) --Превращение в рыбу

local yellImprisoningBubble		= mod:NewYell(195253, nil, nil, nil, "YELL") --Пузырь-тюрьма
local yellImprisoningBubbleFades = mod:NewFadesYell(195253, nil, nil, nil, "YELL") --Пузырь-тюрьма
local yellArcaneBomb			= mod:NewYell(192706, nil, nil, nil, "YELL") --Чародейская бомба
local yellArcaneBombFades		= mod:NewFadesYell(192706, nil, nil, nil, "YELL") --Чародейская бомба
local yellPolymorph				= mod:NewYell(197105, nil, nil, nil, "YELL") --Превращение в рыбу
local yellPolymorphFades		= mod:NewFadesYell(197105, nil, nil, nil, "YELL") --Превращение в рыбу
local yellSandstorm				= mod:NewYell(196144, nil, nil, nil, "YELL") --Песчаная буря

mod:AddSetIconOption("SetIconOnArcaneBomb", 192706, true, false, {8}) --Чародейская бомба
mod:AddSetIconOption("SetIconOnImprisoningBubble", 195253, true, false, {7}) --Пузырь-тюрьма
mod:AddSetIconOption("SetIconOnPolymorph", 197105, true, false, {6}) --Превращение в рыбу
mod:AddRangeFrameOption(10, 192706) --Чародейская бомба

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 196870 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Буря
		specWarnStorm:Show()
		specWarnStorm:Play("kickcast")
	elseif spellId == 195046 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Живительная вода
		specWarnRejuvWaters:Show()
		specWarnRejuvWaters:Play("kickcast")
	elseif spellId == 195284 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Водоворот
		if self:IsHard() then
			specWarnUndertow:Show()
			specWarnUndertow:Play("runout")
			timerUndertow:Start()
		end
	elseif spellId == 197105 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Превращение в рыбу
		specWarnPolymorph:Show()
		specWarnPolymorph:Play("kickcast")
	elseif spellId == 195253 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Пузырь-тюрьма
		specWarnImprisoningBubble:Show()
		specWarnImprisoningBubble:Play("kickcast")
	elseif spellId == 196127 and self:AntiSpam(2, 1) then --Струя песка
		specWarnSpraySand:Show()
		specWarnSpraySand:Play("shockwave")
	elseif spellId == 196175 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Бронераковина
		specWarnArmorshell:Show()
		specWarnArmorshell:Play("kickcast")
	elseif spellId == 195129 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Грохочущий топот
		specWarnThunderingStomp:Show()
		specWarnThunderingStomp:Play("kickcast")
	elseif spellId == 196290 and self:AntiSpam(2, 1) then --Буря Хаоса
		specWarnChaoticTempest:Show()
		specWarnChaoticTempest:Play("watchstep")
	elseif spellId == 196296 and self:AntiSpam(2, 1) then --Бурлящая буря
		specWarnRoilingStorm:Show()
		specWarnRoilingStorm:Play("watchstep")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 192706 then --Чародейская бомба
		timerArcaneBomb:Start(args.destName)
		if args:IsPlayer() then
			specWarnArcaneBomb:Show()
			specWarnArcaneBomb:Play("runout")
			yellArcaneBomb:Yell()
			yellArcaneBombFades:Countdown(15, 3)
		else
			warnArcaneBomb:CombinedShow(0.5, args.destName)
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
			self:SetIcon(args.destName, 6, 8)
		end
	elseif spellId == 196144 then --Песчаная буря
		if args:IsPlayer() then
			specWarnSandstorm:Show()
			specWarnSandstorm:Play("targetyou")
			yellSandstorm:Yell()
		else
			warnSandstorm:CombinedShow(0.5, args.destName)
		end
	elseif spellId == 195253 then --Пузырь-тюрьма
		timerImprisoningBubble:Start(args.destName)
		if args:IsPlayer() then
			yellImprisoningBubble:Yell()
			yellImprisoningBubbleFades:Countdown(12, 3)
		else
			warnImprisoningBubble:CombinedShow(0.5, args.destName)
			specWarnImprisoningBubble2:CombinedShow(0.5, args.destName)
		end
		if self.Options.SetIconOnImprisoningBubble then
			self:SetIcon(args.destName, 7, 12)
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
			specWarnArcaneBomb3:Show()
			yellArcaneBombFades:Cancel()
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
		if self.Options.SetIconOnArcaneBomb then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 195253 then --Пузырь-тюрьма
		timerImprisoningBubble:Cancel(args.destName)
		if args:IsPlayer() then
			yellImprisoningBubbleFades:Cancel()
		end
		if self.Options.SetIconOnImprisoningBubble then
			self:SetIcon(args.destName, 0)
		end
	end
end
