local mod	= DBM:NewMod(1497, "DBM-Party-Legion", 6, 726)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(98203)
mod:SetEncounterID(1827)
mod:SetZone()
mod:SetUsedIcons(8, 7, 6)

mod.noNormal = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 196562 196805",
	"SPELL_AURA_REMOVED 196562",
	"SPELL_CAST_SUCCESS 196562 196804 196392",
	"SPELL_PERIODIC_DAMAGE 196824",
	"SPELL_PERIODIC_MISSED 196824"
)

--TODO, verify some of this is actually timer based and not just mana depletion related.
--TODO, verify first special timers some more
local warnVolatileMagic				= mod:NewTargetAnnounce(196562, 3) --Нестабильная магия
local warnNetherLink				= mod:NewTargetAnnounce(196805, 4) --Оковы Пустоты

local specWarnVolatileMagic			= mod:NewSpecialWarningMoveAway(196562, nil, nil, nil, 3, 5) --Нестабильная магия

local specWarnNetherLink			= mod:NewSpecialWarningYouRunning(196805, nil, nil, nil, 1, 2) --Оковы Пустоты дебаф
local specWarnNetherLinkGTFO		= mod:NewSpecialWarningYouMove(196805, nil, nil, nil, 1, 2) --Оковы Пустоты лужа
local specWarnOverchargeMana		= mod:NewSpecialWarningInterrupt(196392, "HasInterrupt", nil, nil, 1, 2) --Перезарядка маны

local timerVolatileMagicCD			= mod:NewCDTimer(35.5, 196562, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Нестабильная магия Review, Might be health based? or just really variable
local timerNetherLinkCD				= mod:NewCDTimer(38, 196804, nil, nil, nil, 3) --Оковы Пустоты
local timerOverchargeManaCD			= mod:NewCDTimer(41.5, 196392, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON) --Перезарядка маны

local yellVolatileMagic				= mod:NewYell(196562, nil, nil, nil, "YELL") --Нестабильная магия
local yellVolatileMagic2			= mod:NewShortFadesYell(196562, nil, nil, nil, "YELL") --Нестабильная магия
local yellNetherLink				= mod:NewYell(196805, nil, nil, nil, "YELL") --Оковы Пустоты

mod:AddSetIconOption("SetIconOnVolatileMagic", 196562, true, false, {8, 7, 6}) --Нестабильная магия
mod:AddRangeFrameOption(8, 196562) --Нестабильная магия

mod.vb.volatilemagicIcon = 6

function mod:OnCombatStart(delay)--Watch closely, review. He may be able to swap nether link and volatile magic?
	self.vb.volatilemagicIcon = 6
	timerVolatileMagicCD:Start(9.5-delay)--APPLIED
	timerNetherLinkCD:Start(19.5-delay) --Оковы Пустоты +2 сек
	timerOverchargeManaCD:Start(30.5-delay) --Перезарядка маны -1.5сек
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 196562 then --Нестабильная магия
		self.vb.volatilemagicIcon = self.vb.volatilemagicIcon + 1
		warnVolatileMagic:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnVolatileMagic:Show()
			specWarnVolatileMagic:Play("runout")
			yellVolatileMagic:Yell()
			yellVolatileMagic2:Countdown(4)
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(8)
		end
		if self.Options.SetIconOnVolatileMagic then
			self:SetIcon(args.destName, self.vb.volatilemagicIcon)
		end
		if self.vb.volatilemagicIcon == 8 then
			self.vb.volatilemagicIcon = 6
		end
	elseif spellId == 196805 then
		warnNetherLink:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnNetherLink:Show()
			specWarnNetherLink:Play("targetyou")
			yellNetherLink:Yell()
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 196562 then --Нестабильная магия
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
		if self.Options.SetIconOnVolatileMagic then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 196562 then
		timerVolatileMagicCD:Start()
	elseif spellId == 196804 then
		timerNetherLinkCD:Start()
	elseif spellId == 196392 then
		specWarnOverchargeMana:Show(args.sourceName)
		specWarnOverchargeMana:Play("kickcast")
		timerOverchargeManaCD:Start()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 196824 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnNetherLinkGTFO:Show()
		specWarnNetherLinkGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
