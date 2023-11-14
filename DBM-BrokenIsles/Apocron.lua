local mod	= DBM:NewMod(1956, "DBM-BrokenIsles", nil, 822)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17745 $"):sub(12, -3))
mod:SetCreatureID(121124)
--mod:SetEncounterID(1880)
mod:SetReCombatTime(20)
mod:SetZone()
mod:SetUsedIcons(8)
mod:SetMinSyncRevision(17745)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 241458 241498 241518"
)

local warnFelfireMissiles				= mod:NewTargetAnnounce(241498, 3) --Заряды огня Скверны

local specWarnQuake						= mod:NewSpecialWarningRun(241458, "Melee", nil, nil, 4, 3) --Землетрясение
local specWarnQuake2					= mod:NewSpecialWarningDodge(241458, "Ranged", nil, nil, 2, 3) --Землетрясение
local specWarnFelfireMissiles			= mod:NewSpecialWarningYouMoveAway(241498, nil, nil, nil, 1, 2) --Заряды огня Скверны
local specWarnFelfireMissilesNear		= mod:NewSpecialWarningCloseMoveAway(241498, nil, nil, nil, 1, 2) --Заряды огня Скверны
local specWarnSear						= mod:NewSpecialWarningYouDefensive(241518, "Tank", nil, nil, 1, 2) --Выжигание

local timerQuakeCD						= mod:NewCDTimer(30, 241458, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Землетрясение 22.1-25.6
local timerQuakeCast					= mod:NewCastTimer(4, 241458, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Землетрясение
local timerFelfireMissilesCD			= mod:NewCDTimer(13.5, 241498, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Заряды огня Скверны 9.7-14.6
local timerSearCD						= mod:NewCDTimer(9.7, 241518, nil, "Melee", nil, 5, nil, DBM_CORE_TANK_ICON) --Выжигание

local yellFelfireMissiles				= mod:NewYell(241498, nil, nil, nil, "YELL") --Заряды огня Скверны

mod:AddSetIconOption("SetIconOnFelfireMissiles", 241498, true, false, {8}) --Заряды огня Скверны

--mod:AddReadyCheckOption(37460, false)

function mod:MissilesTarget(targetname, uId)
	if not targetname then return end
	warnFelfireMissiles:Show(targetname)
	if targetname == UnitName("player") then
		specWarnFelfireMissiles:Show()
	--	specWarnFelfireMissiles:Play("runout")
		yellFelfireMissiles:Yell()
	elseif self:CheckNearby(15, targetname) then
		specWarnFelfireMissilesNear:Show(targetname)
	--	specWarnFelfireMissilesNear:Play("watchstep")
	end
	if self.Options.SetIconOnFelfireMissiles then
		self:SetIcon(targetname, 8, 7)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 241458 then --Землетрясение
		specWarnQuake:Show()
	--	specWarnQuake:Play("carefly")
		specWarnQuake2:Show()
	--	specWarnQuake2:Play("carefly")
		timerQuakeCD:Start()
		timerQuakeCast:Start()
	elseif spellId == 241498 then --Заряды огня Скверны
		timerFelfireMissilesCD:Start()
		self:BossTargetScanner(args.sourceGUID, "MissilesTarget", 0.2, 5)
	elseif spellId == 241518 then --Выжигание
		specWarnSear:Show()
	--	specWarnSear:Play("defensive")
		timerSearCD:Start()
	end
end
