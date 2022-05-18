local mod	= DBM:NewMod("HoVTrash", "DBM-Party-Legion", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()
--mod:SetUsedIcons(2, 1)
mod.isTrashMod = true


mod:RegisterEvents(
	"SPELL_CAST_START 199805 192563 199726 199382 200901 192158 192288 210875 199652 200969",
	"SPELL_AURA_APPLIED 215430 199652",
	"SPELL_AURA_REMOVED 215430 199652",
	"SPELL_CAST_SUCCESS 199382",
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_PERIODIC_DAMAGE 198959",
	"SPELL_PERIODIC_MISSED 198959",
	"UNIT_DIED"
)
--Чертоги доблести
local warnCrackle					= mod:NewTargetNoFilterAnnounce(199805, 3) --Разряд

local specWarnEtch					= mod:NewSpecialWarningYouMove(198959, nil, nil, nil, 1, 2) --Гравировка
local specWarnCallAncestor			= mod:NewSpecialWarningSwitch(200969, "Dps", nil, nil, 1, 2) --Зов предков
local specWarnSever					= mod:NewSpecialWarningYouDefensive(199652, "Tank", nil, nil, 3, 5) --Рассечение
local specWarnThunderstrike			= mod:NewSpecialWarningYouMoveAway(215430, nil, nil, nil, 3, 5) --Громовой удар
local specWarnThunderstrike2		= mod:NewSpecialWarningCloseMoveAway(215430, nil, nil, nil, 2, 2) --Громовой удар
local specWarnEyeofStorm			= mod:NewSpecialWarningMoveTo(200901, nil, nil, nil, 3, 2) --Око шторма
local specWarnSanctify				= mod:NewSpecialWarningDodge(192158, "Ranged", nil, nil, 2, 5) --Освящение
local specWarnSanctify2				= mod:NewSpecialWarningRun(192158, "Melee", nil, nil, 4, 5) --Освящение
local specWarnChargedPulse			= mod:NewSpecialWarningRun(210875, "Melee", nil, nil, 4, 5) --Пульсирующий заряд
local specWarnChargedPulse2			= mod:NewSpecialWarningDodge(210875, "Ranged", nil, nil, 2, 5) --Пульсирующий заряд

local specWarnEnragingRoar			= mod:NewSpecialWarningDefensive(199382, "Tank", nil, nil, 3, 2) --Яростный рев
local specWarnCrackle				= mod:NewSpecialWarningDodge(199805, nil, nil, nil, 1, 2) --Разряд
local specWarnCleansingFlame		= mod:NewSpecialWarningInterrupt(192563, "HasInterrupt", nil, nil, 1, 2) --Очищающие языки пламени
local specWarnUnrulyYell			= mod:NewSpecialWarningInterrupt(199726, "HasInterrupt", nil, nil, 1, 2) --Буйный вопль
local specWarnSearingLight			= mod:NewSpecialWarningInterrupt(192288, "HasInterrupt", nil, nil, 1, 2) --Опаляющий свет

local timerSever					= mod:NewTargetTimer(12, 199652, nil, "Tank|Healer", nil, 3, nil, DBM_CORE_TANK_ICON) --Громовой удар
local timerEyeofStormCD				= mod:NewCDTimer(31.5, 200901, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Око шторма
local timerSanctifyCD				= mod:NewCDTimer(26.5, 192158, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Освящение
local timerEnragingRoarCD			= mod:NewCDTimer(25, 199382, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON) --Яростный рев
local timerThunderstrike			= mod:NewTargetTimer(3, 215430, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Громовой удар

local timerRoleplay					= mod:NewTimer(30, "timerRoleplay", "Interface\\Icons\\Spell_Holy_BorrowedTime", nil, nil, 7) --Ролевая игра

local yellCrackle					= mod:NewYell(199805, nil, nil, nil, "YELL") --Разряд
local yellThunderstrike				= mod:NewYell(215430, nil, nil, nil, "YELL") --Громовой удар
local yellThunderstrike2			= mod:NewShortFadesYell(215430, nil, nil, nil, "YELL") --Громовой удар

local eyeShortName = DBM:GetSpellInfo(91320)--Inner Eye

mod:AddRangeFrameOption(8, 215430) --Громовой удар
--mod:AddSetIconOption("SetIconOnThunderStrike", 215430, true, false, {2, 1}) --Громовой удар

mod.vb.ThunderstrikeIcon = 1

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
		timerEyeofStormCD:Start()
	elseif spellId == 192158 then --Освящение
		specWarnSanctify:Show()
		specWarnSanctify:Play("watchorb")
		specWarnSanctify2:Show()
		specWarnSanctify2:Play("watchorb")
		timerSanctifyCD:Start()
	elseif spellId == 210875 and self:AntiSpam(2, 1) then --Пульсирующий заряд
		specWarnChargedPulse:Show()
		specWarnChargedPulse2:Show()
	elseif spellId == 199652 then --Рассечение
		specWarnSever:Show()
	elseif spellId == 199652 then --Зов предков
		specWarnCallAncestor:Show()
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
	if args.spellId == 215430 then --Громовой удар
		timerThunderstrike:Start(args.destName)
		if args:IsPlayer() then
			specWarnThunderstrike:Show()
			specWarnThunderstrike:Play("runout")
			yellThunderstrike:Yell()
			yellThunderstrike2:Countdown(3)
		elseif self:CheckNearby(10, args.destName) then
			specWarnThunderstrike2:Show(args.destName)
			specWarnThunderstrike2:Play("watchstep")
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(8)
		end
	elseif spellId == 199652 then --Рассечение
		timerSever:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 215430 then --Громовой удар
		timerThunderstrike:Cancel(args.destName)
		if args:IsPlayer() then
			yellThunderstrike2:Cancel()
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif spellId == 199652 then --Рассечение
		timerSever:Cancel(args.destName)
	end
end

--[[function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 97219 then --Солстен
		timerEyeofStormCD:Cancel()
	elseif cid == 97202 then --Олмир Просвещенный
		timerSanctifyCD:Cancel()
	end
end]]

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.RPSkovald or msg:find(L.RPSkovald) then
		self:SendSync("RPSkovald")
	elseif msg == L.RPSolsten or msg:find(L.RPSolsten) then
		self:SendSync("RPSolsten")
	elseif msg == L.RPOlmyr or msg:find(L.RPOlmyr) then
		self:SendSync("RPOlmyr")
	elseif msg == L.RPOdyn or msg:find(L.RPOdyn) then
		self:SendSync("RPOdyn")
	end
end

function mod:OnSync(msg, GUID)
	if msg == "RPSkovald" then
		timerRoleplay:Start(33.5)
	elseif msg == "RPOdyn" then
		timerRoleplay:Start(25.5)
	elseif msg == "RPSolsten" then
		timerEyeofStormCD:Cancel()
	elseif msg == "RPOlmyr" then
		timerSanctifyCD:Cancel()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 198959 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnEtch:Show()
		specWarnEtch:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
