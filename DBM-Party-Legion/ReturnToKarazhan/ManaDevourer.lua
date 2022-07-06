local mod	= DBM:NewMod(1818, "DBM-Party-Legion", 11, 860)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
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
	"SPELL_AURA_APPLIED 227297 227524",
	"SPELL_PERIODIC_DAMAGE 227524",
	"SPELL_PERIODIC_MISSED 227524"
)

local warnEnergyVoid				= mod:NewSpellAnnounce(227523, 1) --Энергетическая пустота
local warnArcaneBomb				= mod:NewSpellAnnounce(227618, 3) --Чародейская бомба

local specWarnEnergyVoid			= mod:NewSpecialWarningYouMove(227524, nil, nil, nil, 1, 2) --Энергетическая пустота
local specWarnDecimatingEssence		= mod:NewSpecialWarningDefensive(227507, nil, nil, nil, 3, 5) --Истребляющая сущность
local specWarnCoalescePower			= mod:NewSpecialWarningMoveTo(227297, "Tank", nil, nil, 1, 2) --Слияние энергии
local specWarnCoalescePower2		= mod:NewSpecialWarningDodge(227297, "-Tank", nil, nil, 1, 2) --Слияние энергии
local specWarnArcaneBomb			= mod:NewSpecialWarningDodge(227618, "Melee", nil, nil, 2, 2) --Чародейская бомба
local specWarnEnergyVoid2			= mod:NewSpecialWarningDodge(227523, "SpellCaster", nil, nil, 2, 3) --Энергетическая пустота

local timerEnergyVoidCD				= mod:NewCDTimer(21.7, 227523, nil, nil, nil, 3) --Энергетическая пустота
local timerCoalescePowerCD			= mod:NewNextTimer(30, 227297, nil, nil, nil, 1, nil, DBM_CORE_TANK_ICON) --Слияние энергии

local countdownCoalescePower		= mod:NewCountdown(30, 227297) --Слияние энергии

mod:AddInfoFrameOption(227502, true)

local unstableMana, looseMana = DBM:GetSpellInfo(227502), DBM:GetSpellInfo(227296)

function mod:OnCombatStart(delay)
	timerEnergyVoidCD:Start(14.5-delay)
	timerCoalescePowerCD:Start(30-delay)
	countdownCoalescePower:Start(30-delay)
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
	if spellId == 227507 then
		specWarnDecimatingEssence:Show()
		specWarnDecimatingEssence:Play("aesoon")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 227618 then
		warnArcaneBomb:Show()
		specWarnArcaneBomb:Show()
		specWarnArcaneBomb:Play("watchstep")
	elseif spellId == 227523 then
		warnEnergyVoid:Show()
		specWarnEnergyVoid2:Show()
		timerEnergyVoidCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 227297 then
		specWarnCoalescePower:Show(looseMana)
		specWarnCoalescePower:Play("helpsoak")
		specWarnCoalescePower2:Show()
		specWarnCoalescePower2:Play("watchstep")
		timerCoalescePowerCD:Start()
		countdownCoalescePower:Start()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 227524 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		if not self:IsNormal() then
			specWarnEnergyVoid:Show()
			specWarnEnergyVoid:Play("runaway")
		end
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
