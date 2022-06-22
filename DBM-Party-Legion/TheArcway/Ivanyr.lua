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
	"SPELL_AURA_APPLIED 196562 196805 196396",
	"SPELL_AURA_APPLIED_DOSE 196396",
	"SPELL_AURA_REMOVED 196562",
	"SPELL_CAST_SUCCESS 196562 196804 196392",
	"SPELL_PERIODIC_DAMAGE 196824",
	"SPELL_PERIODIC_MISSED 196824"
)

--Иванир https://ru.wowhead.com/npc=98203/иванир/эпохальный-журнал-сражений
local warnOvercharge				= mod:NewStackAnnounce(196396, 4, nil, nil, 2) --Перезарядка
local warnOverchargeMana			= mod:NewSoonAnnounce(196392, 1) --Перезарядка маны
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

local countdownOverchargeMana		= mod:NewCountdown(41.5, 196392, nil, nil, 5) --Перезарядка маны

mod:AddSetIconOption("SetIconOnVolatileMagic", 196562, true, false, {8, 7, 6}) --Нестабильная магия
mod:AddRangeFrameOption(8, 196562) --Нестабильная магия

mod.vb.volatilemagicIcon = 8

function mod:OnCombatStart(delay)--Watch closely, review. He may be able to swap nether link and volatile magic?
	self.vb.volatilemagicIcon = 8
	if not self:IsNormal() then
		timerVolatileMagicCD:Start(9.5-delay) --Нестабильная магия+++
		timerNetherLinkCD:Start(19.5-delay) --Оковы Пустоты+++
		warnOverchargeMana:Schedule(25.5-delay) --Перезарядка маны
		timerOverchargeManaCD:Start(30.5-delay) --Перезарядка маны
		countdownOverchargeMana:Start(30.5-delay) --Перезарядка маны
	else
		timerVolatileMagicCD:Start(7.7-delay) --Нестабильная магия
		timerNetherLinkCD:Start(17.5-delay) --Оковы Пустоты
		timerOverchargeManaCD:Start(30-delay) --Перезарядка маны
		countdownOverchargeMana:Start(30-delay) --Перезарядка маны
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 196562 then --Нестабильная магия
		self.vb.volatilemagicIcon = self.vb.volatilemagicIcon - 1
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
	elseif spellId == 196805 then
		warnNetherLink:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnNetherLink:Show()
			specWarnNetherLink:Play("targetyou")
			yellNetherLink:Yell()
		end
	elseif spellId == 196396 then --Перезарядка
		local amount = args.amount or 1
		if amount >= 5 and amount % 5 == 0 then
			warnOvercharge:Show(args.destName, amount)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 196562 then --Нестабильная магия
		self.vb.volatilemagicIcon = self.vb.volatilemagicIcon + 1
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
	if spellId == 196562 then --Нестабильная магия
		timerVolatileMagicCD:Start()
	elseif spellId == 196804 then
		timerNetherLinkCD:Start()
	elseif spellId == 196392 then --Перезарядка маны
		specWarnOverchargeMana:Show()
		specWarnOverchargeMana:Play("kickcast")
		timerOverchargeManaCD:Start()
		countdownOverchargeMana:Start()
		warnOverchargeMana:Schedule(36.5)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 196824 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		if not self:IsNormal() then
			specWarnNetherLinkGTFO:Show()
			specWarnNetherLinkGTFO:Play("runaway")
		end
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
