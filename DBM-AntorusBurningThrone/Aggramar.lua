local mod	= DBM:NewMod(1984, "DBM-AntorusBurningThrone", nil, 946)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(121975)
mod:SetEncounterID(2063)
mod:SetZone()
mod:SetUsedIcons(5, 4, 3, 2, 1)
mod:SetHotfixNoticeRev(16964)
mod.respawnTime = 30
mod:DisableIEEUCombatDetection()

mod:RegisterCombat("combat")
--mod:RegisterCombat("combat_yell", L.YellPullAggramar)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 244693 245458 245463 245301 255058 255061 255059",
	"SPELL_CAST_SUCCESS 247079 244033",
	"SPELL_AURA_APPLIED 245990 245994 244894 244903 247091 254452 247079 244912",
	"SPELL_AURA_APPLIED_DOSE 245990 244912",
	"SPELL_AURA_REMOVED 244894 244903 247091 254452 247079",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1",
	"UNIT_HEALTH boss1"
)

--Прошляпанное очко мурчаля
local warnPhase							= mod:NewPhaseChangeAnnounce(1, nil, nil, nil, nil, nil, 2)
--local warnPhase2						= mod:NewAnnounce("Phase1", 1, "Interface\\Icons\\Spell_Nature_WispSplode") --Скоро фаза 2
--local warnPhase3						= mod:NewAnnounce("Phase3", 1, "Interface\\Icons\\Spell_Nature_WispSplode") --Скоро фаза 3
local warnPrePhase2						= mod:NewPrePhaseAnnounce(2, 1)
local warnPrePhase3						= mod:NewPrePhaseAnnounce(3, 1)

--local warnFlameRend1					= mod:NewAnnounce("FlameRend1", 1, 245463) --1ая группа
--local warnFlameRend2					= mod:NewAnnounce("FlameRend2", 1, 245463) --2ая группа
--Stage One: Wrath of Aggramar
local warnTaeshalachReach				= mod:NewStackAnnounce(245990, 2, nil, "Tank") --Гигантский клинок
local warnScorchingBlaze				= mod:NewTargetAnnounce(245994, 2) --Обжигающее пламя
local warnRavenousBlaze					= mod:NewTargetAnnounce(254452, 2) --Хищное пламя
local warnRavenousBlazeCount			= mod:NewCountAnnounce(254452, 4) --Хищное пламя
local warnTaeshalachTech				= mod:NewCountAnnounce(244688, 3) --Искусный прием

local specWarnFlameRend2				= mod:NewSpecialWarning("FlameRend3", nil, nil, nil, 1, 2) --другая пати

local specWarnBlazingEruption			= mod:NewSpecialWarningStack(244912, nil, 2, nil, nil, 1, 5) --Извержение пламени
--Stage One: Wrath of Aggramar
local specWarnTaeshalachReach			= mod:NewSpecialWarningStack(245990, nil, 8, nil, nil, 1, 3) --Гигантский клинок
local specWarnTaeshalachReachOther		= mod:NewSpecialWarningTaunt(245990, nil, nil, nil, 1, 3) --Гигантский клинок
local specWarnScorchingBlaze			= mod:NewSpecialWarningYouMoveAway(245994, nil, nil, nil, 1, 5) --Обжигающее пламя
local specWarnScorchingBlazeNear		= mod:NewSpecialWarningCloseMoveAway(245994, nil, nil, nil, 1, 5) --Обжигающее пламя
local specWarnRavenousBlaze				= mod:NewSpecialWarningYouMoveAway(254452, nil, nil, nil, 4, 5) --Хищное пламя
local specWarnRavenousBlazeNear			= mod:NewSpecialWarningCloseMoveAway(254452, nil, nil, nil, 2, 5) --Хищное пламя
local specWarnWakeofFlame				= mod:NewSpecialWarningDodge(244693, nil, nil, nil, 2, 2) --Огненная волна
local specWarnFoeBreakerTaunt			= mod:NewSpecialWarningTaunt(245458, nil, nil, nil, 3, 3) --Сокрушитель
local specWarnFoeBreakerDefensive		= mod:NewSpecialWarningDefensive(245458, nil, nil, nil, 3, 3) --Сокрушитель
local specWarnFoeBreaker				= mod:NewSpecialWarningDodge(245458, "MeleeDps", nil, nil, 2, 3) --Сокрушитель
local specWarnFlameRend					= mod:NewSpecialWarningRunningCount(245463, nil, nil, nil, 4, 5) --Разрывающее пламя
local specWarnFlameRendTaunt			= mod:NewSpecialWarningTaunt(245463, nil, nil, nil, 1, 2) --Разрывающее пламя
local specWarnSearingTempest			= mod:NewSpecialWarningRun(245301, nil, nil, nil, 4, 3) --Опаляющая буря
--Stage Two: Champion of Sargeras
local specWarnFlare						= mod:NewSpecialWarningDodge(245983, "-Tank", nil, 2, 2, 2) --Вспышка

--Stage One: Wrath of Aggramar
local timerTaeshalachTechCD				= mod:NewNextCountTimer(59, 244688, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON..DBM_CORE_MYTHIC_ICON) --Искусный прием было 61 (если смотреть по героику)
local timerFoeBreakerCD					= mod:NewNextCountTimer(6.1, 245458, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON..DBM_CORE_DEADLY_ICON) --Сокрушитель
local timerFlameRendCD					= mod:NewNextCountTimer(6.1, 245463, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON..DBM_CORE_DEADLY_ICON) --Разрывающее пламя
local timerTempestCD					= mod:NewNextTimer(6.1, 245301, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Опаляющая буря
local timerScorchingBlazeCD				= mod:NewCDTimer(6.5, 245994, nil, nil, nil, 3, nil, DBM_CORE_HEALER_ICON..DBM_CORE_DEADLY_ICON) --Обжигающее пламя 6.5-8
local timerRavenousBlazeCD				= mod:NewCDTimer(22.2, 254452, nil, nil, nil, 3, nil, DBM_CORE_MYTHIC_ICON..DBM_CORE_DEADLY_ICON) --Хищное пламя
local timerWakeofFlameCD				= mod:NewCDTimer(24, 244693, nil, nil, nil, 3) --Огненная волна
--Stage Two: Champion of Sargeras
local timerFlareCD						= mod:NewCDTimer(15, 245983, nil, "Ranged", 2, 3, nil, DBM_CORE_DEADLY_ICON) --Вспышка

local yellScorchingBlaze				= mod:NewYell(245994, nil, nil, nil, "YELL") --Обжигающее пламя
local yellRavenousBlaze					= mod:NewPosYell(254452, nil, nil, nil, "YELL") --Хищное пламя
local yellWakeofFlame					= mod:NewYell(244693, nil, nil, nil, "YELL") --Огненная волна

local berserkTimer						= mod:NewBerserkTimer(600)

--Stages One: Wrath of Aggramar
local countdownTaeshalachTech			= mod:NewCountdown(59, 244688, nil, nil, 5) --Искусный прием
local countdownFlare					= mod:NewCountdown("Alt15", 245983, "Ranged", nil, 5) --Вспышка
--local countdownWakeofFlame				= mod:NewCountdown("AltTwo24", 244693, "-Tank") --Огненная волна

mod:AddSetIconOption("SetIconOnBlaze2", 254452, true, false, {5, 4, 3, 2, 1}) --Хищное пламя Both off by default, both conflit with one another
--mod:AddSetIconOption("SetIconOnAdds", 244903, false, true) --Катализирующее присутствие Both off by default, both conflit with one another
mod:AddInfoFrameOption(244688, true) --Искусный прием
mod:AddRangeFrameOption("6", nil, "Ranged")
mod:AddNamePlateOption("NPAuraOnPresence", 244903) --Катализирующее присутствие
mod:AddBoolOption("ignoreThreeTank", true)

mod.vb.phase = 1
mod.vb.techCount = 0
mod.vb.foeCount = 0
mod.vb.rendCount = 0
mod.vb.wakeOfFlameCount = 0
mod.vb.blazeIcon = 1
mod.vb.techActive = false
mod.vb.firstCombo = nil
mod.vb.secondCombo = nil
mod.vb.comboCount = 0
--mod.vb.incompleteCombo = false
local warned_preP1 = false
local warned_preP2 = false
local warned_preP3 = false
local warned_preP4 = false
local FlameRend = false
local comboDebug = {}
local comboDebugCounter = 0
local unitTracked = {}

local comboUsed = {
	[1] = false,--L.Foe, L.Tempest, L.Rend, L.Foe, L.Rend
	[2] = false,--L.Foe, L.Rend, L.Tempest, L.Foe, L.Rend
	[3] = false,--L.Rend, L.Tempest, L.Foe, L.Foe, L.Rend
	[4] = false--L.Rend, L.Foe, L.Foe, L.Tempest, L.Rend
}

local updateInfoFrame
do
	local lines = {}
	local sortedLines = {}
	local function addLine(key, value)
		-- sort by insertion order
		lines[key] = value
		sortedLines[#sortedLines + 1] = key
	end
	updateInfoFrame = function()
		table.wipe(lines)
		table.wipe(sortedLines)
		if mod:IsMythic() then
			if mod.vb.comboCount == 0 then
				--Filler
			elseif mod.vb.comboCount == 1 and mod.vb.firstCombo then
				if mod.vb.firstCombo == "Foe" then--L.Foe, L.Tempest, L.Rend, L.Foe, L.Rend or L.Foe, L.Rend, L.Tempest, L.Foe, L.Rend
					addLine(L.Current, DBM_CORE_TANK_ICON_SMALL..L.Foe)
					--[[if comboUsed[1] then--It's L.Foe, L.Rend, L.Tempest, L.Foe, L.Rend (combo 2) for sure
						addLine(mod.vb.comboCount+1, DBM_CORE_IMPORTANT_ICON_SMALL..L.Rend)
						addLine(mod.vb.comboCount+2, DBM_CORE_DEADLY_ICON_SMALL..L.Tempest)
					elseif comboUsed[2] then--It's L.Foe, L.Tempest, L.Rend, L.Foe, L.Rend (Combo 1) for sure
						addLine(mod.vb.comboCount+1, DBM_CORE_DEADLY_ICON_SMALL..L.Tempest)
						addLine(mod.vb.comboCount+2, DBM_CORE_IMPORTANT_ICON_SMALL..L.Rend)--]]
					--else--Could be either one
						addLine(mod.vb.comboCount+1, DBM_CORE_IMPORTANT_ICON_SMALL..L.Rend.."/"..DBM_CORE_DEADLY_ICON_SMALL..L.Tempest)
						addLine(mod.vb.comboCount+2, DBM_CORE_IMPORTANT_ICON_SMALL..L.Rend.."/"..DBM_CORE_DEADLY_ICON_SMALL..L.Tempest)
					--end
					addLine(mod.vb.comboCount+3, DBM_CORE_TANK_ICON_SMALL..L.Foe.."(2)")
				elseif mod.vb.firstCombo == "Rend" then----L.Rend, L.Tempest, L.Foe, L.Foe, L.Rend or L.Rend, L.Foe, L.Foe, L.Tempest, L.Rend
					addLine(L.Current, DBM_CORE_IMPORTANT_ICON_SMALL..L.Rend)
					--[[if comboUsed[3] then--It's L.Rend, L.Foe, L.Foe, L.Tempest, L.Rend (combo 4) for sure
						addLine(mod.vb.comboCount+1, DBM_CORE_TANK_ICON_SMALL..L.Foe)
						addLine(mod.vb.comboCount+2, DBM_CORE_TANK_ICON_SMALL..L.Foe.."(2)")
						addLine(mod.vb.comboCount+3, DBM_CORE_DEADLY_ICON_SMALL..L.Tempest)
					elseif comboUsed[4] then--It's L.Rend, L.Tempest, L.Foe, L.Foe, L.Rend (combo 3) for sure
						addLine(mod.vb.comboCount+1, DBM_CORE_DEADLY_ICON_SMALL..L.Tempest)
						addLine(mod.vb.comboCount+2, DBM_CORE_TANK_ICON_SMALL..L.Foe)
						addLine(mod.vb.comboCount+3, DBM_CORE_TANK_ICON_SMALL..L.Foe.."(2)")--]]
					--else
						addLine(mod.vb.comboCount+1, DBM_CORE_TANK_ICON_SMALL..L.Foe.."/"..DBM_CORE_DEADLY_ICON_SMALL..L.Tempest)
						addLine(mod.vb.comboCount+2, DBM_CORE_TANK_ICON_SMALL..L.Foe.."/"..DBM_CORE_TANK_ICON_SMALL..L.Foe.."(2)")
						addLine(mod.vb.comboCount+3, DBM_CORE_TANK_ICON_SMALL..L.Foe.."(2)/"..DBM_CORE_DEADLY_ICON_SMALL..L.Tempest)
					--end
				end
				addLine(mod.vb.comboCount+4, DBM_CORE_IMPORTANT_ICON_SMALL..L.Rend.."(2)")
			elseif mod.vb.comboCount == 2 and mod.vb.secondCombo then
				if mod.vb.secondCombo == "Tempest" then
					addLine(L.Current, DBM_CORE_DEADLY_ICON_SMALL..L.Tempest)
					if mod.vb.firstCombo == "Foe" then--L.Foe, L.Tempest, L.Rend, L.Foe, L.Rend
						addLine(mod.vb.comboCount+1, DBM_CORE_IMPORTANT_ICON_SMALL..L.Rend)
						comboUsed[1] = true
						comboDebugCounter = comboDebugCounter + 1
						comboDebug[comboDebugCounter] = L.Foe..", "..L.Tempest..", "..L.Rend..", "..L.Foe..", "..L.Rend
					elseif mod.vb.firstCombo == "Rend" then--L.Rend, L.Tempest, L.Foe, L.Foe, L.Rend
						addLine(mod.vb.comboCount+1, DBM_CORE_TANK_ICON_SMALL..L.Foe)
						comboUsed[3] = true
						comboDebugCounter = comboDebugCounter + 1
						comboDebug[comboDebugCounter] = L.Rend..", "..L.Tempest..", "..L.Foe..", "..L.Foe..", "..L.Rend
					end
					--Same in both combos
					addLine(mod.vb.comboCount+2, DBM_CORE_TANK_ICON_SMALL..L.Foe.."(2)")
				elseif mod.vb.secondCombo == "Foe" then--L.Rend, L.Foe, L.Foe, L.Tempest, L.Rend
					addLine(L.Current, DBM_CORE_TANK_ICON_SMALL..L.Foe)
					addLine(mod.vb.comboCount+1, DBM_CORE_TANK_ICON_SMALL..L.Foe.."(2)")
					addLine(mod.vb.comboCount+2, DBM_CORE_DEADLY_ICON_SMALL..L.Tempest)
					comboUsed[4] = true
					comboDebugCounter = comboDebugCounter + 1
					comboDebug[comboDebugCounter] = L.Rend..", "..L.Foe..", "..L.Foe..", "..L.Tempest..", "..L.Rend
				elseif mod.vb.secondCombo == "Rend" then--L.Foe, L.Rend, L.Tempest, L.Foe, L.Rend
					addLine(L.Current, DBM_CORE_IMPORTANT_ICON_SMALL..L.Rend)
					addLine(mod.vb.comboCount+1, DBM_CORE_DEADLY_ICON_SMALL..L.Tempest)
					addLine(mod.vb.comboCount+2, DBM_CORE_TANK_ICON_SMALL..L.Foe.."(2)")
					comboUsed[2] = true
					comboDebugCounter = comboDebugCounter + 1
					comboDebug[comboDebugCounter] = L.Foe..", "..L.Rend..", "..L.Tempest..", "..L.Foe..", "..L.Rend
				end
				--Rend always last
				addLine(mod.vb.comboCount+3, DBM_CORE_IMPORTANT_ICON_SMALL..L.Rend.."(2)")
			elseif mod.vb.comboCount == 3 and mod.vb.secondCombo then
				if mod.vb.secondCombo == "Tempest" then
					if mod.vb.firstCombo == "Foe" then--L.Foe, L.Tempest, L.Rend, L.Foe, L.Rend
						addLine(L.Current, DBM_CORE_IMPORTANT_ICON_SMALL..L.Rend)
					else--L.Rend, L.Tempest, L.Foe, L.Foe, L.Rend
						addLine(L.Current, DBM_CORE_TANK_ICON_SMALL..L.Foe)
					end
					--Same in both combos
					addLine(mod.vb.comboCount+1, DBM_CORE_TANK_ICON_SMALL..L.Foe.."(2)")
					addLine(mod.vb.comboCount+2, DBM_CORE_IMPORTANT_ICON_SMALL..L.Rend.."(2)")
				elseif mod.vb.secondCombo == "Foe" then--L.Rend, L.Foe, L.Foe, L.Tempest, L.Rend
					addLine(L.Current, DBM_CORE_TANK_ICON_SMALL..L.Foe.."(2)")
					addLine(mod.vb.comboCount+1, DBM_CORE_DEADLY_ICON_SMALL..L.Tempest)
					addLine(mod.vb.comboCount+2, DBM_CORE_IMPORTANT_ICON_SMALL..L.Rend.."(2)")
				elseif mod.vb.secondCombo == "Rend" then--L.Foe, L.Rend, L.Tempest, L.Foe, L.Rend
					addLine(L.Current, DBM_CORE_DEADLY_ICON_SMALL..L.Tempest)
					addLine(mod.vb.comboCount+1, DBM_CORE_TANK_ICON_SMALL..L.Foe.."(2)")
					addLine(mod.vb.comboCount+2, DBM_CORE_IMPORTANT_ICON_SMALL..L.Rend.."(2)")
				end
			elseif mod.vb.comboCount == 4 then
				if mod.vb.secondCombo == "Tempest" then
					--Same in both combos
					addLine(L.Current, DBM_CORE_TANK_ICON_SMALL..L.Foe.."(2)")
				elseif mod.vb.secondCombo == "Foe" then--L.Rend, L.Foe, L.Foe, L.Tempest, L.Rend
					addLine(L.Current, DBM_CORE_DEADLY_ICON_SMALL..L.Tempest)
				elseif mod.vb.secondCombo == "Rend" then--L.Foe, L.Rend, L.Tempest, L.Foe, L.Rend
					addLine(L.Current, DBM_CORE_TANK_ICON_SMALL..L.Foe.."(2)")
				end
				--rend always last
				addLine(mod.vb.comboCount+1, DBM_CORE_IMPORTANT_ICON_SMALL..L.Rend.."(2)")
			else
				addLine(L.Current, DBM_CORE_IMPORTANT_ICON_SMALL..L.Rend.."(2)")
			end
		else--Not Mythic
			if mod:IsLFR() then
				if mod.vb.comboCount == 0 then
					--Filler
				elseif mod.vb.comboCount == 1 then
					addLine(L.Current,  DBM_CORE_IMPORTANT_ICON_SMALL..L.Rend.."(1)")
					addLine(mod.vb.comboCount+1, DBM_CORE_IMPORTANT_ICON_SMALL..L.Rend.."(2)")
					addLine(mod.vb.comboCount+2, DBM_CORE_IMPORTANT_ICON_SMALL..L.Rend.."(3)")
					addLine(mod.vb.comboCount+3, DBM_CORE_IMPORTANT_ICON_SMALL..L.Rend.."(4)")
					addLine(mod.vb.comboCount+4, DBM_CORE_DEADLY_ICON_SMALL..L.Tempest)
				elseif mod.vb.comboCount == 2 then
					addLine(L.Current, DBM_CORE_IMPORTANT_ICON_SMALL..L.Rend.."(2)")
					addLine(mod.vb.comboCount+1, DBM_CORE_IMPORTANT_ICON_SMALL..L.Rend.."(3)")
					addLine(mod.vb.comboCount+2, DBM_CORE_IMPORTANT_ICON_SMALL..L.Rend.."(4)")
					addLine(mod.vb.comboCount+3, DBM_CORE_DEADLY_ICON_SMALL..L.Tempest)
				elseif mod.vb.comboCount == 3 then
					addLine(L.Current, DBM_CORE_IMPORTANT_ICON_SMALL..L.Rend.."(3)")
					addLine(mod.vb.comboCount+1, DBM_CORE_IMPORTANT_ICON_SMALL..L.Rend.."(4)")
					addLine(mod.vb.comboCount+2, DBM_CORE_DEADLY_ICON_SMALL..L.Tempest)
				elseif mod.vb.comboCount == 4 then
					addLine(L.Current, DBM_CORE_IMPORTANT_ICON_SMALL..L.Rend.."(4)")
					addLine(mod.vb.comboCount+1, DBM_CORE_DEADLY_ICON_SMALL..L.Tempest)
				else
					addLine(L.Current, DBM_CORE_DEADLY_ICON_SMALL..L.Tempest)
				end
			else
				if mod.vb.comboCount == 0 then
					--Filler
				elseif mod.vb.comboCount == 1 then
					addLine(L.Current,  DBM_CORE_TANK_ICON_SMALL..L.Foe.."(1)")
					addLine(mod.vb.comboCount+1, DBM_CORE_IMPORTANT_ICON_SMALL..L.Rend)
					addLine(mod.vb.comboCount+2, DBM_CORE_TANK_ICON_SMALL..L.Foe.."(2)")
					addLine(mod.vb.comboCount+3, DBM_CORE_IMPORTANT_ICON_SMALL..L.Rend.."(2)")
					addLine(mod.vb.comboCount+4, DBM_CORE_DEADLY_ICON_SMALL..L.Tempest)
				elseif mod.vb.comboCount == 2 then
					addLine(L.Current, DBM_CORE_IMPORTANT_ICON_SMALL..L.Rend)
					addLine(mod.vb.comboCount+1, DBM_CORE_TANK_ICON_SMALL..L.Foe.."(2)")
					addLine(mod.vb.comboCount+2, DBM_CORE_IMPORTANT_ICON_SMALL..L.Rend.."(2)")
					addLine(mod.vb.comboCount+3, DBM_CORE_DEADLY_ICON_SMALL..L.Tempest)
				elseif mod.vb.comboCount == 3 then
					addLine(L.Current, DBM_CORE_TANK_ICON_SMALL..L.Foe.."(2)")
					addLine(mod.vb.comboCount+1, DBM_CORE_IMPORTANT_ICON_SMALL..L.Rend.."(2)")
					addLine(mod.vb.comboCount+2, DBM_CORE_DEADLY_ICON_SMALL..L.Tempest)
				elseif mod.vb.comboCount == 4 then
					addLine(L.Current, DBM_CORE_IMPORTANT_ICON_SMALL..L.Rend.."(2)")
					addLine(mod.vb.comboCount+1, DBM_CORE_DEADLY_ICON_SMALL..L.Tempest)
				else
					addLine(L.Current, DBM_CORE_DEADLY_ICON_SMALL..L.Tempest)
				end
			end
		end
		return lines, sortedLines
	end
end

function mod:WakeTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		yellWakeofFlame:Yell()
	end
end

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.techCount = 0
	self.vb.foeCount = 0
	self.vb.rendCount = 0
	self.vb.wakeOfFlameCount = 0
	self.vb.blazeIcon = 1
	warned_preP1 = false
	warned_preP2 = false
	warned_preP3 = false
	warned_preP4 = false
	FlameRend = false
	self.vb.techActive = false
	table.wipe(unitTracked)
	if self:IsMythic() then
		comboUsed[1] = false
		comboUsed[2] = false
		comboUsed[3] = false
		comboUsed[4] = false
		timerRavenousBlazeCD:Start(4-delay) --Хищное пламя+++
		timerWakeofFlameCD:Start(11-delay) --Огненная волна+++
		timerTaeshalachTechCD:Start(15-delay, 1) --Искусный прием+++
		countdownTaeshalachTech:Start(15-delay) --Искусный прием+++
		berserkTimer:Start(540-delay)
		table.wipe(comboDebug)
		comboDebugCounter = 0
	elseif self:IsHeroic() then
		timerScorchingBlazeCD:Start(5.5-delay) --Обжигающее пламя+++
		timerWakeofFlameCD:Start(5.8-delay) --Огненная волна+++
		timerTaeshalachTechCD:Start(36-delay, 1) --Искусный прием+++
		countdownTaeshalachTech:Start(36-delay) --Искусный прием+++
		berserkTimer:Start(-delay)
	else
		timerScorchingBlazeCD:Start(5.5-delay) --Обжигающее пламя+++
		timerWakeofFlameCD:Start(5.8-delay) --Огненная волна+++
		timerTaeshalachTechCD:Start(36-delay, 1) --Искусный прием+++
		countdownTaeshalachTech:Start(36-delay) --Искусный прием+++
		berserkTimer:Start(-delay)
	end
	--Everyone should lose spread except tanks which should stay stacked. Maybe melee are safe too?
	if self.Options.RangeFrame and not self:IsTank() then
		DBM.RangeCheck:Show(6)
	end
	if self.Options.NPAuraOnPresence then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
		self:RegisterOnUpdateHandler(function(self)
			for i = 1, 40 do
				local UnitID = "nameplate"..i
				local GUID = UnitGUID(UnitID)
				local cid = self:GetCIDFromGUID(GUID)
				if cid == 122532 then
					local unitPower = UnitPower(UnitID)
					if not unitTracked[GUID] then unitTracked[GUID] = "None" end
					if (unitPower < 35) then
						if unitTracked[GUID] ~= "Green" then
							unitTracked[GUID] = "Green"
							DBM.Nameplate:Show(true, GUID, 244912, 463281)
						end
					elseif (unitPower < 70) then
						if unitTracked[GUID] ~= "Yellow" then
							unitTracked[GUID] = "Yellow"
							DBM.Nameplate:Hide(true, GUID, 244912, 463281)
							DBM.Nameplate:Show(true, GUID, 244912, 460954)
						end
					elseif (unitPower < 90) then
						if unitTracked[GUID] ~= "Red" then
							unitTracked[GUID] = "Red"
							DBM.Nameplate:Hide(true, GUID, 244912, 460954)
							DBM.Nameplate:Show(true, GUID, 244912, 463282)
						end
					elseif (unitPower < 100) then
						if unitTracked[GUID] ~= "Critical" then
							unitTracked[GUID] = "Critical"
							DBM.Nameplate:Hide(true, GUID, 244912, 463282)
							DBM.Nameplate:Show(true, GUID, 244912, 1029718)
						end
					end
				end
			end
		end, 1)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.NPAuraOnPresence then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
	if DBM.Options.DebugMode then
		for i, v in ipairs(comboDebug) do
			DBM:AddMsg(v)
		end
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 244693 and self:AntiSpam(4, 1) then--Antispam because boss recasts itif target dies while casting
		self.vb.wakeOfFlameCount = self.vb.wakeOfFlameCount + 1
		specWarnWakeofFlame:Show()
		specWarnWakeofFlame:Play("watchwave")
		local techTimer = timerTaeshalachTechCD:GetRemaining(self.vb.techCount+1)
		if techTimer == 0 or techTimer > 24 then
			timerWakeofFlameCD:Start()
		--	countdownWakeofFlame:Start(24.3)
		end
		self:BossTargetScanner(args.sourceGUID, "WakeTarget", 0.1, 12, true, nil, nil, nil, true)
	elseif spellId == 245458 or spellId == 255059 then --Сокрушитель
		self.vb.comboCount = self.vb.comboCount + 1
		specWarnFoeBreaker:Show()
		specWarnFoeBreaker:Play("watchstep")
		if self:IsMythic() then
			if not self.vb.firstCombo then
				self.vb.firstCombo = "Foe"
			elseif not self.vb.secondCombo then
				self.vb.secondCombo = "Foe"
			end
		end
		self.vb.foeCount = self.vb.foeCount + 1
		if self:IsTank() then
			if self:IsTanking("player", "boss1", nil, true) then
				specWarnFoeBreakerDefensive:Show()
				specWarnFoeBreakerDefensive:Play("defensive")
			elseif (self.vb.foeCount == 2) and not DBM:UnitDebuff("player", 245458, 255059) then
				if self.Options.ignoreThreeTank and self:GetNumAliveTanks() >= 3 then return end
				if self:AntiSpam(2, 6) then--Second cast and you didn't take first and didn't get a flame rend taunt warning in last 2 seconds
					specWarnFoeBreakerTaunt:Show(BOSS)
					specWarnFoeBreakerTaunt:Play("tauntboss")
				end
			end
		end
		if self.vb.foeCount == 1 and not self:IsMythic() then
			if self:IsEasy() then
				timerFoeBreakerCD:Start(7.5, 2) --Сокрушитель (на офе было 10)
			else
				timerFoeBreakerCD:Start(7.5, 2)
			end
		end
		if self.Options.InfoFrame then
			DBM.InfoFrame:Update()
		end
	elseif spellId == 245463 or spellId == 255058 then
		self.vb.comboCount = self.vb.comboCount + 1
		if self:IsMythic() then
			if not self.vb.firstCombo then
				self.vb.firstCombo = "Rend"
			elseif not self.vb.secondCombo then
				self.vb.secondCombo = "Rend"
			end
		end
		self.vb.rendCount = self.vb.rendCount + 1
		if not FlameRend then --анонс когда делить урон
			specWarnFlameRend:Show(self.vb.rendCount)
		else
			specWarnFlameRend2:Show()
		end
		if spellId == 255058 then--Empowered/Mythic Version
			if self.vb.rendCount == 1 then
			--	warnFlameRend1:Show()
				specWarnFlameRend:Play("shareone")
			else
			--	warnFlameRend2:Show()
				specWarnFlameRend:Play("sharetwo")
			end
		else
			specWarnFlameRend:Play("gathershare")
		end
		if self.vb.rendCount == 1 and not self:IsMythic() and not self:IsLFR() then
			if self:IsNormal() then
				timerFlameRendCD:Start(7.5, 2) --Разрывающее пламя (на офе в обычке было 10)
			else
				timerFlameRendCD:Start(7.5, 2)
			end
		end
		if self.Options.InfoFrame then
			DBM.InfoFrame:Update()
		end
	elseif spellId == 245301 or spellId == 255061 then
		self.vb.comboCount = self.vb.comboCount + 1
		if self:IsMythic() then
			if not self.vb.secondCombo then
				self.vb.secondCombo = "Tempest"
			end
		end
		specWarnSearingTempest:Show()
		specWarnSearingTempest:Play("runout")
		if self.Options.InfoFrame then
			DBM.InfoFrame:Update()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 247079 or spellId == 244033 then--Special cast Ids that show the primary target of the flame rend, not all the people hit by it
		if self.Options.ignoreThreeTank and self:GetNumAliveTanks() >= 3 then return end
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then--For good measure, filter non tanks on wipes or LFR trolls
			if not args:IsPlayer() and (self:IsMythic() and self.vb.rendCount == 2 or not DBM:UnitDebuff("player", 245458, 255059)) then
				--Will warn if Rend count 2 and mythic, combo has ended and tank that didn't get hit should taunt boss to keep him still
				--Will warn if Flame did not hit you and you do NOT have foebreaker debuff yet, should taunt to keep boss from moving, you're the next foe soaker in this case.
				--Will NOT warn if Using 3+ tank strat and 3 tank filter enabled. If using 3+ tank strat, none of the two above can be safely assumed who should taunt boss, so we do nothing
				if self:AntiSpam(2, 6) then--Antispam to prevent double taunt warnings with foebreaker code that warns you to taunt on cast start if other tank has debuff
					specWarnFlameRendTaunt:Show(args.destName)
					specWarnFlameRendTaunt:Play("tauntboss")
				end
			end
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 245990 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 8 and self:AntiSpam(3, 2) then--Lasts 12 seconds, asuming 1.5sec swing timer makes 8 stack swap
				if args:IsPlayer() then--At this point the other tank SHOULD be clear.
					specWarnTaeshalachReach:Show(amount)
					specWarnTaeshalachReach:Play("stackhigh")
				else--Taunt as soon as stacks are clear, regardless of stack count.
					local techTimer = timerTaeshalachTechCD:GetRemaining(self.vb.techCount+1)
					if not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", args.spellName) and (techTimer == 0 or techTimer >= 4) then
						specWarnTaeshalachReachOther:Show(args.destName)
						specWarnTaeshalachReachOther:Play("tauntboss")
					else
						warnTaeshalachReach:Show(args.destName, amount)
					end
				end
			else
				if amount % 4 == 0 then
					warnTaeshalachReach:Show(args.destName, amount)
				end
			end
		end
	elseif spellId == 245994 then
		warnScorchingBlaze:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnScorchingBlaze:Show()
			specWarnScorchingBlaze:Play("scatter")
			yellScorchingBlaze:Yell()
		elseif self:CheckNearby(5, args.destName) then
			specWarnScorchingBlazeNear:CombinedShow(0.2, args.destName)
			specWarnScorchingBlazeNear:Play("runaway")
		end
	elseif spellId == 254452 then
		self.vb.blazeIcon = self.vb.blazeIcon + 1
		warnRavenousBlaze:CombinedShow(0.3, args.destName)
		local icon = self.vb.blazeIcon
		if args:IsPlayer() then
			specWarnRavenousBlaze:Show(self:IconNumToTexture(icon))
			specWarnRavenousBlaze:Play("scatter")
			yellRavenousBlaze:Yell(self.vb.blazeIcon, icon, icon)
			warnRavenousBlazeCount:Schedule(2, 5)
			warnRavenousBlazeCount:Schedule(4, 10)
			warnRavenousBlazeCount:Schedule(6, 15)
			warnRavenousBlazeCount:Schedule(8, 20)
		elseif self:CheckNearby(10, args.destName) then
			specWarnRavenousBlazeNear:CombinedShow(0.2, args.destName)
			specWarnRavenousBlazeNear:Play("runaway")
		end
		if self.Options.SetIconOnBlaze2 then
			self:SetIcon(args.destName, icon)
		end
	elseif spellId == 244894 then --Оскверненная эгида
		if self.vb.comboCount > 0 and self.vb.comboCount < 5 then
			--self.vb.incompleteCombo = true
			comboDebugCounter = comboDebugCounter + 1
			comboDebug[comboDebugCounter] = "Phase changed aborted a combo before it finished"
		end
	--	warnPhase:Play("phasechange")
		self.vb.wakeOfFlameCount = 0
		self.vb.techActive = false
		timerScorchingBlazeCD:Stop()
		timerRavenousBlazeCD:Stop()
		timerWakeofFlameCD:Stop()
		timerFlareCD:Stop()
		countdownFlare:Cancel()
	--	countdownWakeofFlame:Cancel()
		timerTaeshalachTechCD:Stop()
		countdownTaeshalachTech:Cancel()
		timerFoeBreakerCD:Stop()
		timerFlameRendCD:Stop()
		timerTempestCD:Stop()
	--[[	if self.Options.SetIconOnAdds then
			self:ScheduleMethod(2, "ScanForMobs", 122532, 1, 1, 5, 0.1, 12, "SetIconOnAdds", nil, nil, true)
		end]]
		if self.Options.RangeFrame and not self:IsTank() then
			DBM.RangeCheck:Hide()
		end
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
	elseif spellId == 244903 or spellId == 247091 then--Purification/Catalyzed
		if self.Options.NPAuraOnPresence then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 247079 then --Усиленное разрывающее пламя (от делёжки)
		if args:IsPlayer() then
			FlameRend = true
		end
	elseif spellId == 244912 then --Извержение пламени
		local amount = args.amount or 1
		if args:IsPlayer() then
			if amount >= 2 and self:AntiSpam(2, 1) then
				specWarnBlazingEruption:Show(args.amount)
				specWarnBlazingEruption:Play("stackhigh")
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 244894 then --Оскверненная эгида
		self.vb.phase = self.vb.phase + 1
		comboDebugCounter = comboDebugCounter + 1
		comboDebug[comboDebugCounter] = "Phase: "..self.vb.phase
		self.vb.wakeOfFlameCount = 0
		self.vb.comboCount = 0
		self.vb.firstCombo = nil
		self.vb.secondCombo = nil
		self.vb.foeCount = 0
		self.vb.rendCount = 0
		--timerScorchingBlazeCD:Start(3)--Unknown
		if self:IsHeroic() then
			timerTaeshalachTechCD:Start(36, self.vb.techCount+1)
			countdownTaeshalachTech:Start(36)
		else
			timerTaeshalachTechCD:Start(36, self.vb.techCount+1) --под мифик отлично
			countdownTaeshalachTech:Start(36)
		end
		if self:IsMythic() then
			timerRavenousBlazeCD:Start(23)
		else
			timerScorchingBlazeCD:Start(5.9)
		end
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase))
		if self.vb.phase == 2 then
			warnPhase:Play("ptwo")
			warned_preP2 = true
			timerFlareCD:Start(10) --and 8 or 10
			if self:IsMythic() then
				countdownFlare:Start(10)
			end
		elseif self.vb.phase == 3 then
			warnPhase:Play("pthree")
			warned_preP4 = true
			timerFlareCD:Start(10) --and 8 or 10
			if self:IsMythic() then
				countdownFlare:Start(10)
			end
		end
		if self.Options.RangeFrame and not self:IsTank() then
			DBM.RangeCheck:Show(6)
		end
	elseif spellId == 244903 or spellId == 247091 then--Purification/Catalyzed
		if self.Options.NPAuraOnPresence then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 254452 then
		if args:IsPlayer() then
			warnRavenousBlazeCount:Cancel()
		end
		if self.Options.SetIconOnBlaze2 then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 247079 then --Усиленное разрывающее пламя (от делёжки)
		if args:IsPlayer() then
			FlameRend = false
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 122532 then
		DBM.Nameplate:Hide(true, args.destGUID)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 245993 then--Scorching Blaze
		timerScorchingBlazeCD:Start()
	elseif spellId == 254451 then--Ravenous Blaze (mythic replacement for Scorching Blaze)
		self.vb.blazeIcon = 1
		timerRavenousBlazeCD:Start()--Unknown at this time
	elseif spellId == 244688 then --Искусный прием
		self.vb.comboCount = 0
		self.vb.firstCombo = nil
		self.vb.secondCombo = nil
		self.vb.techActive = true
		self.vb.foeCount = 0
		self.vb.rendCount = 0
		self.vb.techCount = self.vb.techCount + 1
		timerScorchingBlazeCD:Stop()
		timerRavenousBlazeCD:Stop()
		timerWakeofFlameCD:Stop()
		timerFlareCD:Stop()
		countdownFlare:Cancel()
	--	countdownWakeofFlame:Cancel()
		if self:IsMythic() then
			timerRavenousBlazeCD:Start(26)
			if self.vb.techCount == 5 then
				self.vb.techCount = 1
				comboUsed[1] = false
				comboUsed[2] = false
				comboUsed[3] = false
				comboUsed[4] = false
			end
		else
			--Set sequence
			--Foebreaker instantly so no need for timer
			if self:IsEasy() then--Check in LFR
				timerFlameRendCD:Start(3.5, 1) --Разрывающее пламя (на офе в обычке было 5)
				timerTempestCD:Start(15) --Опаляющая буря (на офе в обычке было 20 сек)
			else
				timerFlameRendCD:Start(4, 1)
				timerTempestCD:Start(15)
			end
		end
		warnTaeshalachTech:Show(self.vb.techCount)
		timerTaeshalachTechCD:Start(nil, self.vb.techCount+1)
		countdownTaeshalachTech:Start()
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(spellId))
			DBM.InfoFrame:Show(5, "function", updateInfoFrame, false, false, true)
		end
	elseif spellId == 244792 and self.vb.techActive then--Burning Will of Taeshalach (technique ended)
		self.vb.techActive = false
		if self:IsMythic() then
			timerRavenousBlazeCD:Start(self.vb.phase == 1 and 4.2 or 21.3)
		else
			timerScorchingBlazeCD:Start(4.2)
		end
		if self.vb.phase == 1 then
			if self:IsMythic() then
				timerWakeofFlameCD:Start(10.3)
			--	countdownWakeofFlame:Start(10.3)
			else
				timerWakeofFlameCD:Start(7)
			--	countdownWakeofFlame:Start(7)
			end
		elseif self.vb.phase == 2 then
			timerFlareCD:Start(self:IsMythic() and 6.6 or 8.6)
			if self:IsMythic() then
				countdownFlare:Start(6.6)
			end
		else--Stage 3
			timerFlareCD:Start(self:IsMythic() and 8 or 10)
			if self:IsMythic() then
				countdownFlare:Start(8)
			end
		end
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
	elseif spellId == 245983 or spellId == 246037 then--Flare
		specWarnFlare:Show()
		specWarnFlare:Play("watchstep")
		if not self:IsMythic() then
			timerFlareCD:Start()
			--No countdown on non mythic on purpose
		end
	end
end

function mod:UNIT_HEALTH(uId)
	if self:IsLFR() then
		if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 121975 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.66 then
			warned_preP1 = true
			warnPrePhase2:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
		end
	elseif self:IsMythic() then
		if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 121975 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.86 then
			warned_preP1 = true
			warnPrePhase2:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
		elseif self.vb.phase == 2 and warned_preP2 and not warned_preP3 and self:GetUnitCreatureId(uId) == 121975 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.41 then
			warned_preP3 = true
			warnPrePhase3:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
		end
	else --героик и обычка
		if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 121975 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.86 then
			warned_preP1 = true
			warnPrePhase2:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
		elseif self.vb.phase == 2 and warned_preP2 and not warned_preP3 and self:GetUnitCreatureId(uId) == 121975 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.46 then
			warned_preP3 = true
			warnPrePhase3:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
		end
	end
end
