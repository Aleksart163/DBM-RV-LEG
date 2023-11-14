local mod	= DBM:NewMod(1487, "DBM-Party-Legion", 4, 721)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17745 $"):sub(12, -3))
mod:SetCreatureID(95674, 99868)
mod:SetEncounterID(1807)
mod:DisableEEKillDetection()
mod:SetZone()
mod:SetMinSyncRevision(17745)
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 197556 196838 196828",
	"SPELL_AURA_APPLIED_DOSE 196828",
	"SPELL_AURA_REMOVED 196838",
	"SPELL_CAST_START 196838 196543 197558",
	"SPELL_CAST_SUCCESS 196567 196512 207707 196543",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_HEALTH",
	"UNIT_DIED"
)

--Фенрир https://ru.wowhead.com/npc=99868/фенрир/эпохальный-журнал-сражений#abilities;mode:
local warnScentofBlood					= mod:NewStackAnnounce(196828, 4, nil, nil, 2) --Запах крови
local warnPhase							= mod:NewPhaseChangeAnnounce(1)
local warnPhase2						= mod:NewPhaseAnnounce(2, 2, nil, nil, nil, nil, nil, 2)
local warnPrePhase2						= mod:NewPrePhaseAnnounce(2, 1, 196838)
local warnLeap							= mod:NewTargetAnnounce(197556, 3) --Хищный прыжок
local warnFixate						= mod:NewTargetAnnounce(196838, 4) --Запах крови
local warnFixate2						= mod:NewPreWarnAnnounce(196838, 5, 1) --Запах крови
local warnClawFrenzy					= mod:NewSpellAnnounce(196512, 3, nil, "Melee") --Бешеные когти

local specWarnLeap						= mod:NewSpecialWarningYouMoveAway(197556, nil, nil, nil, 4, 3) --Хищный прыжок
local specWarnHowl						= mod:NewSpecialWarningCast(196543, "SpellCaster", nil, nil, 1, 3) --Пугающий вой
local specWarnFixate					= mod:NewSpecialWarningYouRun(196838, nil, nil, nil, 4, 6) --Запах крови
local specWarnFixateOver				= mod:NewSpecialWarningEnd(196838, nil, nil, nil, 1, 2) --Запах крови
local specWarnWolves					= mod:NewSpecialWarningSwitch("ej12600", "Tank|Dps", nil, nil, 1, 2) --Эбеновый ворг

local timerLeapCD						= mod:NewCDTimer(32.5, 197556, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Хищный прыжок
local timerClawFrenzyCD					= mod:NewCDTimer(9.7, 196512, nil, "Melee", nil, 5, nil, DBM_CORE_DEADLY_ICON) --Бешеные когти
local timerHowlCD						= mod:NewCDTimer(31.5, 196543, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON) --Пугающий вой
local timerFixateCD						= mod:NewCDTimer(38.5, 196838, nil, nil, nil, 7) --Запах крови

local yellLeap							= mod:NewYellMoveAway(197556, nil, nil, nil, "YELL") --Хищный прыжок
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
		--	specWarnFixate:Play("runaway")
		--	specWarnFixate:ScheduleVoice(1, "keepmove")
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
	timerClawFrenzyCD:Start(10-delay) --Бешеные когти
	timerHowlCD:Start(5-delay) --Пугающий вой
	timerLeapCD:Start(13.5-delay) --Хищный прыжок
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 197556 then --Хищный прыжок
		warnLeap:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnLeap:Show()
		--	specWarnLeap:Play("runout")
			yellLeap:Yell()
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(10)
		end
	elseif spellId == 196838 then
		--Backup if target scan failed
		if self:AntiSpam(5, args.destName) then
			if args:IsPlayer() then
				specWarnFixate:Show()
			--	specWarnFixate:Play("runaway")
			--	specWarnFixate:ScheduleVoice(1, "keepmove")
			else
				warnFixate:Show(args.destName)
			end
		end
	elseif spellId == 196828 then --Запах крови
		local amount = args.amount or 1
		if amount >= 2 and amount % 2 == 0 then
			warnScentofBlood:Show(args.destName, amount)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 197556 and args:IsPlayer() and self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	elseif spellId == 196838 and args:IsPlayer() then
		specWarnFixateOver:Show()
	--	specWarnFixateOver:Play("end")
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 196838 then --Запах крови
		self:BossTargetScanner(99868, "FixateTarget", 0.2, 12, true, nil, nil, nil, true)--Target scanning used to grab target 2-3 seconds faster. Doesn't seem to anymore?
		timerFixateCD:Start()
		warnFixate2:Schedule(33.5)
		timerHowlCD:Start(20)
		timerLeapCD:Start(25)
		timerClawFrenzyCD:Start(17.7)
	elseif spellId == 196543 then --Пугающий вой
		if not UnitIsDeadOrGhost("player") then
			specWarnHowl:Show()
		--	specWarnHowl:Play("stopcast")
		end
		timerHowlCD:Start()
	elseif spellId == 197558 then --Хищный прыжок
		timerClawFrenzyCD:Cancel()
		timerLeapCD:Start()
		timerClawFrenzyCD:Start(11)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 196512 then --Бешеные когти
		warnClawFrenzy:Show()
		timerClawFrenzyCD:Start()
	elseif spellId == 196543 then --Пугающий вой
		if self.vb.phase == 2 then
			if not UnitIsDeadOrGhost("player") then
				specWarnWolves:Show()
			--	specWarnWolves:Play("mobkill")
			end
		end
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:find(L.MurchalProshlyapOchko) then
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
		--[[timerClawFrenzyCD:Stop()
		timerHowlCD:Stop()
		timerLeapCD:Stop()]]
	end
end

function mod:ENCOUNTER_START(encounterID)
	--Re-engaged, kill scans and long wipe time
	if encounterID == 1807 and self:IsInCombat() then
--		self:SetWipeTime(5)
--		self:UnregisterShortTermEvents()
--		warnPhase2:Show()
--		warnPhase2:Play("ptwo")
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
	if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 95674 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.71 then
		warned_preP1 = true
		warnPrePhase2:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
	elseif self.vb.phase == 1 and not warned_preP2 and self:GetUnitCreatureId(uId) == 99868 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.60 then
		self.vb.phase = 2
		warned_preP2 = true
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase))
		timerHowlCD:Start(5)
		timerLeapCD:Start(15)
		timerFixateCD:Start(28)
		warnFixate2:Schedule(23)
		timerClawFrenzyCD:Start(12.5)
	end
end
