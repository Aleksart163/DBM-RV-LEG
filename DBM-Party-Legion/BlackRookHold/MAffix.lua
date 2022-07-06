local mod	= DBM:NewMod("MAffix", "DBM-Party-Legion", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod:RegisterEvents(
--	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED 240447 240559 209858",
	"SPELL_AURA_APPLIED_DOSE 240559 209858",
	"SPELL_AURA_REMOVED 240447",
--	"SPELL_CAST_SUCCESS",
	"SPELL_PERIODIC_DAMAGE 226512",
	"SPELL_PERIODIC_MISSED 226512"
)

--Ключи
local warnNecroticWound				= mod:NewStackAnnounce(209858, 4, nil, nil, 2) --Некротическая язва

local specWarnNecroticWound			= mod:NewSpecialWarningStack(209858, nil, 10, nil, nil, 1, 3) --Некротическая язва
local specWarnGrievousWound			= mod:NewSpecialWarningStack(240559, nil, 5, nil, nil, 1, 2) --Тяжкая рана
local specWarnSanguineIchor			= mod:NewSpecialWarningYouMove(226512, nil, nil, nil, 1, 2) --Кровавый гной
local specWarnQuake					= mod:NewSpecialWarningCast(240447, "Ranged", nil, nil, 1, 2) --Землетрясение
local specWarnQuake2				= mod:NewSpecialWarningMoveAway(240447, "Melee", nil, nil, 1, 2) --Землетрясение

local timerQuake					= mod:NewCastTimer(2.5, 240447, nil, nil, nil, 2, nil, DBM_CORE_INTERRUPT_ICON..DBM_CORE_DEADLY_ICON) --Землетрясение
local timerNecroticWound			= mod:NewTargetTimer(9, 209858, nil, "Tank|Healer", nil, 3, nil, DBM_CORE_TANK_ICON..DBM_CORE_HEALER_ICON) --Некротическая язва

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 240447 then --Землетрясение
		if args:IsPlayer() then
			specWarnQuake:Show()
			specWarnQuake:Play("runaway")
			specWarnQuake2:Show()
			specWarnQuake2:Play("runaway")
			timerQuake:Start()
		end
	elseif spellId == 240559 then --Тяжкая рана
		local amount = args.amount or 1
		if args:IsPlayer() then
			if amount >= 5 then
				specWarnGrievousWound:Show(amount)
				specWarnGrievousWound:Play("stackhigh")
			end
		end
	elseif spellId == 209858 then --Некротическая язва
		local amount = args.amount or 1
		timerNecroticWound:Start(args.destName)
		if amount >= 10 and amount % 5 == 0 then
			if args:IsPlayer() then
				specWarnNecroticWound:Show(amount)
				specWarnNecroticWound:Play("stackhigh")
			else
				warnNecroticWound:Show(args.destName, amount)
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 240447 then --Землетрясение
		timerQuake:Stop()
	elseif spellId == 209858 then --Некротическая язва
		timerNecroticWound:Cancel(args.destName)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 226512 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		if not self:IsNormal() then
			specWarnSanguineIchor:Show()
			specWarnSanguineIchor:Play("runaway")
		end
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
