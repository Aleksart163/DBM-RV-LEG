local mod	= DBM:NewMod(1818, "DBM-Party-Legion", 11, 860)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
mod:SetCreatureID(114252)
mod:SetEncounterID(1959)
mod:SetZone()
--mod:SetUsedIcons(1)
--mod:SetHotfixNoticeRev(14922)
--mod.respawnTime = 30

mod.noNormal = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 227507",
	"SPELL_CAST_SUCCESS 227618 227523",
	"SPELL_AURA_APPLIED 227297 227524 227502",
	"SPELL_AURA_APPLIED_DOSE 227502",
	"SPELL_AURA_REMOVED 227297",
	"SPELL_PERIODIC_DAMAGE 227524",
	"SPELL_PERIODIC_MISSED 227524",
	"UNIT_POWER_FREQUENT boss1",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--Пожиратель маны https://ru.wowhead.com/npc=116494/пожиратель-маны/эпохальный-журнал-сражений
local warnEnergyDischarge2			= mod:NewSpellAnnounce(227457, 4) --Энергетический разряд
local warnEnergyVoid				= mod:NewSpellAnnounce(227523, 1) --Энергетическая пустота

local specWarnFelGlaive				= mod:NewSpecialWarningDodge(197333, nil, nil, nil, 1, 2)
local specWarnEnergyDischarge		= mod:NewSpecialWarningSoon(227457, nil, nil, nil, 1, 5) --Энергетический разряд
local specWarnUnstableMana			= mod:NewSpecialWarningStack(227502, nil, 1, nil, nil, 1, 3) --Нестабильная мана
local specWarnEnergyVoid			= mod:NewSpecialWarningYouMove(227524, nil, nil, nil, 1, 2) --Энергетическая пустота
local specWarnDecimatingEssence		= mod:NewSpecialWarningDefensive(227507, nil, nil, nil, 3, 6) --Истребляющая сущность
local specWarnDecimatingEssence2	= mod:NewSpecialWarningRun(227507, "-Tank", nil, nil, 4, 6) --Истребляющая сущность
local specWarnCoalescePower			= mod:NewSpecialWarningDodgeCount(227297, nil, nil, nil, 1, 2) --Слияние энергии
local specWarnArcaneBomb			= mod:NewSpecialWarningDodge(227618, nil, nil, nil, 2, 2) --Чародейская бомба
local specWarnEnergyVoid2			= mod:NewSpecialWarningDodge(227523, "SpellCaster", nil, nil, 2, 3) --Энергетическая пустота

local timerEnergyDischargeCD		= mod:NewCDTimer(27, 227457, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Энергетический разряд
local timerEnergyVoidCD				= mod:NewCDTimer(21.7, 227523, nil, nil, nil, 3) --Энергетическая пустота
local timerCoalescePowerCD			= mod:NewCDCountTimer(25, 227297, nil, nil, nil, 7) --Слияние энергии

local countdownEnergyDischarge		= mod:NewCountdown(27, 227457, nil, nil, 5) --Слияние энергии
local countdownCoalescePower		= mod:NewCountdown("Alt25", 227297, nil, nil, 5) --Слияние энергии

mod:AddInfoFrameOption(227502, true)

local unstableMana, looseMana = DBM:GetSpellInfo(227502), DBM:GetSpellInfo(227296)
mod.vb.MurchalProshlyapenCount = 0
local ProshlyapMurchalyaSoon = false

function mod:OnCombatStart(delay)
	self.vb.MurchalProshlyapenCount = 0
	ProshlyapMurchalyaSoon = false
	timerEnergyVoidCD:Start(14.5-delay)
	timerCoalescePowerCD:Start(30-delay, 1)
	countdownCoalescePower:Start(30-delay)
	specWarnEnergyDischarge:Schedule(17-delay) --Энергетический разряд
	specWarnEnergyDischarge:ScheduleVoice(17-delay, "aesoon")
	timerEnergyDischargeCD:Start(22-delay) --Энергетический разряд
	countdownEnergyDischarge:Start(22-delay) --Энергетический разряд
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(unstableMana)
		DBM.InfoFrame:Show(5, "playerdebuffstacks", unstableMana)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 227507 then --Истребляющая сущность
		self.vb.MurchalProshlyapenCount = 0
		ProshlyapMurchalyaSoon = false
		if not UnitIsDeadOrGhost("player") then
			specWarnDecimatingEssence:Show()
			specWarnDecimatingEssence:Play("aesoon")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 227618 then --Чародейская бомба
		if not UnitIsDeadOrGhost("player") then
			specWarnArcaneBomb:Show()
			specWarnArcaneBomb:Play("watchstep")
		end
	elseif spellId == 227523 then --Энергетическая пустота
		warnEnergyVoid:Show()
		if not UnitIsDeadOrGhost("player") then
			specWarnEnergyVoid2:Show()
			specWarnEnergyVoid2:Play("watchstep")
		end
		timerEnergyVoidCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 227297 then --Слияние энергии
		if not UnitIsDeadOrGhost("player") then
			specWarnCoalescePower:Show(self.vb.MurchalProshlyapenCount+1)
			specWarnCoalescePower:Play("watchstep")
		end
	elseif spellId == 227502 then --Нестабильная мана
		local amount = args.amount or 1
		if self:IsMythic() then
			if args:IsPlayer() and not self:IsTank() then
				if amount >= 1 then
					specWarnUnstableMana:Show(amount)
					specWarnUnstableMana:Play("stackhigh")
				end
			end
		else
			if args:IsPlayer() then
				if amount >= 2 then
					specWarnUnstableMana:Show(amount)
					specWarnUnstableMana:Play("stackhigh")
				end
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 227297 then --Слияние энергии
		self.vb.MurchalProshlyapenCount = self.vb.MurchalProshlyapenCount + 1
		if self.vb.MurchalProshlyapenCount == 2 then
			ProshlyapMurchalyaSoon = true
			timerCoalescePowerCD:Start(nil, 1)
			countdownCoalescePower:Start()
		else
			timerCoalescePowerCD:Start(nil, self.vb.MurchalProshlyapenCount+1)
			countdownCoalescePower:Start()
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 227524 and destGUID == UnitGUID("player") and self:AntiSpam(3, "EnergyVoid") then --Энергетическая пустота
		specWarnEnergyVoid:Show()
		specWarnEnergyVoid:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 227457 then --Энергетический разряд
		warnEnergyDischarge2:Show()
		specWarnEnergyDischarge:Schedule(22)
		specWarnEnergyDischarge:ScheduleVoice(22, "aesoon")
		timerEnergyDischargeCD:Start()
		countdownEnergyDischarge:Start()
	end
end

do
	local UnitPower = UnitPower
	function mod:UNIT_POWER_FREQUENT(uId)
		local power = UnitPower(uId)
		if power == 15000 and ProshlyapMurchalyaSoon then
			if timerCoalescePowerCD:GetTime() < 20 and self:AntiSpam(1.5, "DecimatingEssence") then
				specWarnDecimatingEssence2:Show()
				specWarnDecimatingEssence2:Play("justrun")
			end
		end
	end
end
