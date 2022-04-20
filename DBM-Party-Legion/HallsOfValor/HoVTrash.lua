local mod	= DBM:NewMod("HoVTrash", "DBM-Party-Legion", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 199805 192563 199726 199382 200901 192158 192288",
	"SPELL_AURA_APPLIED 198599",
	"SPELL_AURA_REMOVED 198599",
	"SPELL_CAST_SUCCESS 199382"
)

local warnCrackle					= mod:NewTargetAnnounce(199805, 2)

local specWarnThunderstrike			= mod:NewSpecialWarningYouMoveAway(199382, nil, nil, nil, 3, 2) --Громовой удар
local specWarnThunderstrike2		= mod:NewSpecialWarningCloseMoveAway(199382, nil, nil, nil, 2, 2) --Громовой удар
local specWarnEyeofStorm			= mod:NewSpecialWarningMoveTo(200901, nil, nil, nil, 3, 2) --Око шторма
local specWarnSanctify				= mod:NewSpecialWarningDodge(192158, "Ranged", nil, nil, 2, 5) --Освящение
local specWarnSanctify2				= mod:NewSpecialWarningRun(192158, "Melee", nil, nil, 3, 5) --Освящение

local specWarnEnragingRoar			= mod:NewSpecialWarningDefensive(199382, "Tank", nil, nil, 3, 2) --Яростный рев
local specWarnCrackle				= mod:NewSpecialWarningDodge(199805, nil, nil, nil, 1, 2)
local specWarnCleansingFlame		= mod:NewSpecialWarningInterrupt(192563, "HasInterrupt", nil, nil, 1, 2)
local specWarnUnrulyYell			= mod:NewSpecialWarningInterrupt(199726, "HasInterrupt", nil, nil, 1, 2)
local specWarnSearingLight			= mod:NewSpecialWarningInterrupt(192288, "HasInterrupt", nil, nil, 1, 2) --Опаляющий свет

local timerEnragingRoarCD			= mod:NewCDTimer(25, 199382, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON) --Яростный рев
local timerThunderstrike			= mod:NewTargetTimer(3, 198599, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Громовой удар

local yellCrackle					= mod:NewYell(199805, nil, nil, nil, "YELL")
local yellThunderstrike				= mod:NewYell(198599, nil, nil, nil, "YELL") --Громовой удар
local yellThunderstrike2			= mod:NewShortFadesYell(198599, nil, nil, nil, "YELL") --Громовой удар

local eyeShortName = DBM:GetSpellInfo(91320)--Inner Eye

function mod:CrackleTarget(targetname, uId)
	if not targetname then
		warnCrackle:Show(DBM_CORE_UNKNOWN)
		return
	end
	if targetname == UnitName("player") then
		specWarnCrackle:Show()
		specWarnCrackle:Play("watchstep")
		yellCrackle:Yell()
	else
		warnCrackle:Show(targetname)
	end
end

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 199805 then
		self:BossTargetScanner(args.sourceGUID, "CrackleTarget", 0.1, 9)
	elseif spellId == 192563 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnCleansingFlame:Show(args.sourceName)
		specWarnCleansingFlame:Play("kickcast")
	elseif spellId == 199726 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnUnrulyYell:Show(args.sourceName)
		specWarnUnrulyYell:Play("kickcast")
	elseif spellId == 192288 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Опаляющий свет
		specWarnSearingLight:Show()
		specWarnSearingLight:Play("kickcast")
	elseif spellId == 199382 then
		timerEnragingRoarCD:Start()
	elseif spellId == 200901 then --Око шторма
		specWarnEyeofStorm:Show(eyeShortName)
		specWarnEyeofStorm:Play("findshelter")
	elseif spellId == 192158 then
		specWarnSanctify:Show()
		specWarnSanctify:Play("watchorb")
		specWarnSanctify2:Show()
		specWarnSanctify2:Play("watchorb")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 199382 then --Яростный рев
		specWarnEnragingRoar:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if args.spellId == 198599 then --Громовой удар
		timerThunderstrike:Start(args.destName)
		if args:IsPlayer() then
			specWarnThunderstrike:Show()
			specWarnThunderstrike:Play("runout")
			yellThunderstrike:Yell()
			yellThunderstrike2:Countdown(3)
		elseif self:CheckNearby(10, args.destName) then
			specWarnThunderstrike2:Show()
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 198599 then --Громовой удар
		timerThunderstrike:Cancel(args.destName)
		if args:IsPlayer() then
			yellThunderstrike2:Cancel()
		end
	end
end
