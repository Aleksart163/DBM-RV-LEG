local mod	= DBM:NewMod(1884, "DBM-BrokenIsles", nil, 822)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17745 $"):sub(12, -3))
mod:SetCreatureID(117303)
--mod:SetEncounterID(1880)
mod:SetReCombatTime(20)
mod:SetZone()
mod:SetMinSyncRevision(17745)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 233614 234452",
	"SPELL_CAST_SUCCESS 233570",
	"SPELL_AURA_APPLIED 233570 233568",
	"SPELL_PERIODIC_DAMAGE 233850",
	"SPELL_PERIODIC_MISSED 233850"
)


local warnIncitePanic				= mod:NewSpellAnnounce(233568, 2, nil, false)--Off cause fuckups may result in heavy spam
local warnShadowBarrage				= mod:NewSpellAnnounce(234452, 2) --Залп Тени

local specWarnIncitePanic			= mod:NewSpecialWarningYou(233568, nil, nil, nil, 1, 2) --Вызвать панику
local specWarnIncitePanicNear		= mod:NewSpecialWarningClose(233568, nil, nil, nil, 1, 2) --Вызвать панику
local specWarnVirulentInfection		= mod:NewSpecialWarningMove(233850, nil, nil, nil, 1, 2) --Смертоносная инфекция

local timerIncitePanicCD			= mod:NewCDTimer(14.6, 233568, nil, nil, nil, 3) --Вызвать панику
local timerPestilenceCD				= mod:NewCDTimer(14.2, 233614, nil, nil, nil, 3) --Мор
local timerShadowBarrageCD			= mod:NewCDTimer(16.7, 234452, nil, nil, nil, 2) --Залп Тени

local yellIncitePanic				= mod:NewYellMoveAway(233568, nil, nil, nil, "YELL") --Вызвать панику

--mod:AddReadyCheckOption(37460, false)
mod:AddRangeFrameOption(8, 233568)
local PanicDebuff = DBM:GetSpellInfo(233568)

local debuffFilter
do
	debuffFilter = function(uId)
		if DBM:UnitDebuff(uId, PanicDebuff) then
			return true
		end
	end
end

function mod:OnCombatStart(delay, yellTriggered)
	PanicDebuff = DBM:GetSpellInfo(233568)
	if yellTriggered then

	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(8, debuffFilter)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 233614 then
		timerPestilenceCD:Start()
	elseif spellId == 234452 then
		warnShadowBarrage:Show()
		timerShadowBarrageCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 233570 and self:AntiSpam(4, 3) then
		timerIncitePanicCD:Start()
	end
end


function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 233568 or spellId == 233570 then
		warnIncitePanic:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnIncitePanic:Show()
		--	specWarnIncitePanic:Play("scatter")
			yellIncitePanic:Yell()
		elseif self:CheckNearby(10, args.destName) and not DBM:UnitDebuff("player", args.spellName) then
			specWarnIncitePanicNear:CombinedShow(0.5, args.destName)
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 233850 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnVirulentInfection:Show()
	--	specWarnVirulentInfection:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
