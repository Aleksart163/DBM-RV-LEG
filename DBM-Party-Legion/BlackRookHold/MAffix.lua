local mod	= DBM:NewMod("MAffix", "DBM-Party-Legion", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetZone()

mod:RegisterEvents(
--	"SPELL_CAST_SUCCESS 688 691 157757 80353 32182 230935 90355 2825 160452",
	"SPELL_CAST_SUCCESS 688 691 157757",
	"SPELL_AURA_APPLIED 240447 240559 209858 240443",
	"SPELL_AURA_APPLIED_DOSE 240559 209858 240443",
	"SPELL_AURA_REMOVED 240447 240559 240443",
	"SPELL_PERIODIC_DAMAGE 226512 240559",
	"SPELL_PERIODIC_MISSED 226512 240559"
)

--Прошляпанное очко Мурчаля Прошляпенко ✔✔✔
local warnNecroticWound				= mod:NewStackAnnounce(209858, 3, nil, nil, 2) --Некротическая язва

local specWarnNecroticWound			= mod:NewSpecialWarningStack(209858, nil, 10, nil, nil, 1, 3) --Некротическая язва
local specWarnBurst					= mod:NewSpecialWarningYouDefensive(240443, nil, nil, nil, 3, 3) --Взрыв
local specWarnGrievousWound			= mod:NewSpecialWarningStack(240559, nil, 5, nil, nil, 1, 2) --Тяжкая рана
local specWarnSanguineIchor			= mod:NewSpecialWarningYouMove(226512, nil, nil, nil, 1, 2) --Кровавый гной
local specWarnQuake					= mod:NewSpecialWarningCast(240447, "Ranged", nil, nil, 1, 2) --Землетрясение
local specWarnQuake2				= mod:NewSpecialWarningMoveAway(240447, "Melee", nil, nil, 1, 2) --Землетрясение

local timerQuake					= mod:NewCastTimer(2.5, 240447, nil, nil, nil, 2, nil, DBM_CORE_INTERRUPT_ICON..DBM_CORE_DEADLY_ICON) --Землетрясение
--local timerQuakeCD					= mod:NewCDTimer(20, 240447, nil, nil, nil, 7) --Землетрясение
local timerNecroticWound			= mod:NewTargetTimer(9, 209858, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_TANK_ICON..DBM_CORE_HEALER_ICON) --Некротическая язва
local timerBurst					= mod:NewTargetTimer(4, 240443, nil, nil, nil, 3, nil, DBM_CORE_MYTHIC_ICON..DBM_CORE_DEADLY_ICON) --Взрыв

local dota5s = false

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
				dota5s = true
			end
		end
	elseif spellId == 209858 and args:IsDestTypePlayer() then --Некротическая язва
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
	elseif spellId == 240443 and args:IsDestTypePlayer() then --Взрыв
		local amount = args.amount or 1
		if args:IsPlayer() then
			timerBurst:Start(args.destName)
			if amount >= 10 and amount % 5 == 0 and self:AntiSpam(2, 1) then
				specWarnBurst:Show()
				specWarnBurst:Play("stackhigh")
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
	elseif spellId == 240559 then --Тяжкая рана
		if args:IsPlayer() then
			dota5s = false
		end
	elseif spellId == 240443 then --Взрыв
		if args:IsPlayer() then
			timerBurst:Cancel(args.destName)
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 226512 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnSanguineIchor:Show()
		specWarnSanguineIchor:Play("runaway")
	elseif spellId == 240559 and destGUID == UnitGUID("player") then
		if dota5s and self:AntiSpam(5, 1) then
			specWarnGrievousWound:Show(5)
			specWarnGrievousWound:Play("stackhigh")
		end
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
