local mod	= DBM:NewMod(1487, "DBM-Party-Legion", 4, 721)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(95674, 99868)
mod:SetEncounterID(1807)
mod:DisableEEKillDetection()
mod:SetZone()

mod:RegisterCombat("combat")
mod:SetUsedIcons(8)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 197556 196838",
	"SPELL_AURA_REMOVED 196838",
	"SPELL_CAST_START 196838 196543 197558",
	"SPELL_CAST_SUCCESS 196567 196512 207707",
	"UNIT_HEALTH",
	"UNIT_DIED"
)

local warnPhase							= mod:NewAnnounce("Phase1", 1, "Interface\\Icons\\Spell_Nature_WispSplode") --Скоро фаза 2
local warnPhase2						= mod:NewAnnounce("Phase2", 1, 196838) --Фаза 2

local warnLeap							= mod:NewTargetAnnounce(197556, 2) --Хищный прыжок
--local warnPhase2						= mod:NewPhaseAnnounce(2, 2, nil, nil, nil, nil, nil, 2)
local warnFixate						= mod:NewTargetAnnounce(196838, 3) --Запах крови
--local warnFixate2						= mod:NewSpellAnnounce(196838, 4) --Запах крови
local warnClawFrenzy					= mod:NewSpellAnnounce(196512, 2, nil, "Tank") --Бешеные когти

local specWarnLeap						= mod:NewSpecialWarningYouMoveAway(197556, nil, nil, nil, 4, 3) --Хищный прыжок
local specWarnHowl						= mod:NewSpecialWarningCast(196543, "SpellCaster", nil, nil, 3, 2) --Пугающий вой
local specWarnFixate					= mod:NewSpecialWarningYouRun(196838, nil, nil, nil, 4, 5) --Запах крови
local specWarnFixateOver				= mod:NewSpecialWarningEnd(196838, nil, nil, nil, 1, 2) --Запах крови
local specWarnWolves					= mod:NewSpecialWarningSwitch("ej12600", "Tank")

local timerLeapCD						= mod:NewCDTimer(32.5, 197556, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)--31-36 --Хищный прыжок
--local timerClawFrenzyCD					= mod:NewCDTimer(9.7, 196512, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)--All over the place
local timerHowlCD						= mod:NewCDTimer(31.5, 196543, nil, "SpellCaster", nil, 4, nil, DBM_CORE_INTERRUPT_ICON) --Пугающий вой Poor data
local timerFixateCD						= mod:NewCDTimer(38.5, 196838, nil, nil, nil, 3) --Запах крови Poor data
local timerWolvesCD						= mod:NewCDTimer(35, "ej12600", nil, nil, nil, 1, 199184)

local yellLeap							= mod:NewYell(197556, nil, nil, nil, "YELL") --Хищный прыжок
local yellFixate						= mod:NewYell(196838, nil, nil, nil, "YELL") --Запах крови
local yellFixate2						= mod:NewFadesYell(196838, nil, nil, nil, "YELL") --Запах крови

mod:AddSetIconOption("SetIconOnFixate", 196838, true, false, {8}) --Запах крови
mod:AddRangeFrameOption(10, 197556)

mod.vb.phase = 1
local warned_preP1 = false
local warned_preP2 = false

function mod:FixateTarget(targetname, uId)
	if not targetname then return end
	if self:AntiSpam(5, targetname) then
		if targetname == UnitName("player") then
			specWarnFixate:Show()
			specWarnFixate:Play("runaway")
			specWarnFixate:ScheduleVoice(1, "keepmove")
			yellFixate:Yell()
			yellFixate2:Countdown(9, 3)
		else
			warnFixate:Show(targetname)
		end
		if self.Options.SetIconOnFixate then
			self:SetIcon(targetname, 8, 10)
		end
	end
end

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	warned_preP1 = false
	warned_preP2 = false
	self:SetWipeTime(5)
--	timerClawFrenzyCD:Start(19-delay)
	timerHowlCD:Start(5-delay) --Пугающий вой было 8
	timerLeapCD:Start(13.5-delay) --Хищный прыжок было 12
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 197556 then
		warnLeap:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnLeap:Show()
			specWarnLeap:Play("runout")
			yellLeap:Yell()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10)
			end
		end
	elseif spellId == 196838 then
		--Backup if target scan failed
		if self:AntiSpam(5, args.destName) then
			if args:IsPlayer() then
				specWarnFixate:Show()
				specWarnFixate:Play("runaway")
				specWarnFixate:ScheduleVoice(1, "keepmove")
			else
				warnFixate:Show(args.destName)
			end
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 197556 and args:IsPlayer() and self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	elseif spellId == 196838 and args:IsPlayer() then
		specWarnFixateOver:Show()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 196838 then
		timerFixateCD:Start()
		self:BossTargetScanner(99868, "FixateTarget", 0.2, 12, true, nil, nil, nil, true)--Target scanning used to grab target 2-3 seconds faster. Doesn't seem to anymore?
	elseif spellId == 196543 then
		specWarnHowl:Show()
		specWarnHowl:Play("stopcast")
		timerHowlCD:Start()
	elseif spellId == 197558 then --Хищный прыжок
		timerLeapCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 196567 then--Stealth (boss retreat)
		--Stop all timers but not combat
		for i, v in ipairs(self.timers) do
			v:Stop()
		end
		--Artificially set no wipe to 10 minutes
		self:SetWipeTime(600)
		--Scan for Boss to be re-enraged
		self:RegisterShortTermEvents(
			"ENCOUNTER_START",
			"ZONE_CHANGED_NEW_AREA"
		)
	elseif spellId == 196512 then
		warnClawFrenzy:Show()
	elseif spellId == 207707 and self:AntiSpam(2, 1) then--Wolves spawning out of stealth
		specWarnWolves:Show()
		timerWolvesCD:Start()
	end
end

function mod:ENCOUNTER_START(encounterID)
	--Re-engaged, kill scans and long wipe time
	if encounterID == 1807 and self:IsInCombat() then
--		self:SetWipeTime(5)
--		self:UnregisterShortTermEvents()
		warnPhase2:Show()
		warnPhase2:Play("ptwo")
		--timerWolvesCD:Start(5)
		--timerHowlCD:Start(5)--2-6, useless timer
		--timerFixateCD:Start(9.3)--7-20, useless timer
		--timerClawFrenzyCD:Start(27)
		--timerLeapCD:Start(9)--9-30, useless timer
	end
end

function mod:UNIT_DIED(args)
	if self:GetCIDFromGUID(args.destGUID) == 99868 then
		DBM:EndCombat(self)
	end
end

function mod:ZONE_CHANGED_NEW_AREA()
	--Left zone
	--Normal wipes respawn you sindie
	self:SetWipeTime(5)
	self:UnregisterShortTermEvents()
end

function mod:UNIT_HEALTH(uId)
	if self:IsHard() then --миф и миф+
		if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 99868 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.65 then
			warned_preP1 = true
			warnPhase:Show()
		elseif self.vb.phase == 1 and warned_preP1 and not warned_preP2 and self:GetUnitCreatureId(uId) == 99868 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.60 then
			self.vb.phase = 2
			warned_preP2 = true
			warnPhase2:Show()
		end
	else
		if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 99868 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.65 then
			warned_preP1 = true
		elseif self.vb.phase == 1 and warned_preP1 and not warned_preP2 and self:GetUnitCreatureId(uId) == 99868 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.60 then
			self.vb.phase = 2
			warned_preP2 = true
			warnPhase2:Show()
		end
	end
end
