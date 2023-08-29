local mod	= DBM:NewMod("Freya", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))

mod:SetCreatureID(32906)
mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.YellKill)
mod:SetUsedIcons(8, 7, 6, 5, 4)

mod:RegisterEvents(
	"SPELL_CAST_START 62437 62859",
	"SPELL_CAST_SUCCESS 62678 63571 62589",
	"SPELL_AURA_APPLIED 62861 62438 62451 62865",
	"SPELL_AURA_REMOVED 62519 62861 62438",
	"UNIT_DIED",
	"CHAT_MSG_MONSTER_YELL"
)

local warnPhase2			= mod:NewPhaseAnnounce(2, 3)
local warnSimulKill			= mod:NewAnnounce("WarnSimulKill", 1)
local warnFury				= mod:NewTargetAnnounce(63571, 2)
local warnRoots				= mod:NewTargetAnnounce(62438, 2)
local warnGiftEonar			= mod:NewSoonAnnounce("ej17405", 1) --Дар Эонар

local specWarnGiftEonar		= mod:NewSpecialWarningSwitch("ej17405", "-Healer", nil, nil, 3, 5) --Дар Эонар
local specWarnFury			= mod:NewSpecialWarningYouMoveAway(63571, nil, nil, nil, 4, 6) --Гнев природы
local specWarnTremor		= mod:NewSpecialWarningCast(62859, "SpellCaster", nil, nil, 2, 3)	--Дрожание земли
local specWarnTremor2		= mod:NewSpecialWarningSpell(62859, nil, nil, nil, 2, 3) --Дрожание земли
local specWarnBeam			= mod:NewSpecialWarningYouMove(62865)	-- Hard mode

local timerAlliesOfNature	= mod:NewNextTimer(60, 62678)
local timerSimulKill		= mod:NewTimer(12, "TimerSimulKill")
local timerFury				= mod:NewTargetTimer(10, 63571)
local timerTremorCD 		= mod:NewCDTimer(28, 62859)
local timerEonarsGiftCD		= mod:NewCDTimer(45, "ej17405", nil, nil, nil, 7)
local enrage 				= mod:NewBerserkTimer(600)

local countdownGiftEonar	= mod:NewCountdown(45, "ej17405", nil, nil, 5) --Дар Эонар

local yellFury				= mod:NewYellMoveAway(63571, nil, nil, nil, "YELL") --Гнев природы
local yellFury2				= mod:NewFadesYell(63571, nil, nil, nil, "YELL") --Гнев природы

mod:AddSetIconOption("SetIconOnNaturesFury", 63571, true, false, {8, 7})
mod:AddSetIconOption("SetIconOnIronRoots", 62861, true, false, {6, 5, 4})

--mod:AddBoolOption("HealthFrame", true)

local adds		= {}
local rootedPlayers 	= {}
local killTime		= 0

mod.vb.naturesFuryIcon = 8
mod.vb.ironRootsIcon = 6

function mod:OnCombatStart(delay)
	self.vb.naturesFuryIcon = 8
	self.vb.ironRootsIcon = 6
	enrage:Start()
	table.wipe(adds)
	warnGiftEonar:Schedule(20-delay)
	warnGiftEonar:ScheduleVoice(20-delay, "specialsoon")
	countdownGiftEonar:Start(25-delay)
	timerEonarsGiftCD:Start(25-delay)	
end

function mod:OnCombatEnd(wipe)
	self:Unschedule(showRootWarning)
--	DBM.BossHealth:Hide()
	if not wipe then
		if DBM.Bars:GetBar(L.TrashRespawnTimer) then
			DBM.Bars:CancelBar(L.TrashRespawnTimer) 
		end	
	end
end

local function showRootWarning()
	warnRoots:Show(table.concat(rootedPlayers, "< >"))
	table.wipe(rootedPlayers)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 62437 or spellId == 62859 then --Дрожание земли
		if self:IsSpellCaster() then
			specWarnTremor:Show()
			specWarnTremor:Play("stopcast")
		else
			specWarnTremor2:Show()
			specWarnTremor2:Play("specialsoon")
		end
		timerTremorCD:Start()
	end
end 

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 62678 then --Призыв союзников природы
		timerAlliesOfNature:Start()
	elseif spellId == 63571 or spellId == 62589 then --Гнев природы
		if args:IsPlayer() then -- only cast on players; no need to check destFlags
			specWarnFury:Show()
			specWarnFury:Play("runaway")
			yellFury:Yell()
			yellFury2:Countdown(10, 3)
		else
			warnFury:Show(args.destName)
		end
		if self.Options.SetIconOnNaturesFury then 
			self:SetIcon(args.destName, self.vb.naturesFuryIcon, 10)
		end
		if self.vb.naturesFuryIcon == 8 then
			self.vb.naturesFuryIcon = 7
		else
			self.vb.naturesFuryIcon = 8
		end
		timerFury:Start(args.destName)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 62861 or spellId == 62438 then --Железные корни
		self.vb.ironRootsIcon = self.vb.ironRootsIcon - 1
		if self.Options.SetIconOnIronRoots then 
			self:SetIcon(args.destName, self.vb.ironRootsIcon, 15)
		end
		table.insert(rootedPlayers, args.destName)
		self:Unschedule(showRootWarning)
		if #rootedPlayers >= 3 then
			showRootWarning()
		else
			self:Schedule(0.5, showRootWarning)
		end
	elseif spellId == 62451 or spellId == 62865 and args:IsPlayer() then
		specWarnBeam:Show()
	end 
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 62519 then
		warnPhase2:Show()
	elseif spellId == 62861 or spellId == 62438 then
		if self.Options.SetIconOnIronRoots then
			self:RemoveIcon(args.destName)
		end
		self.vb.ironRootsIcon = self.vb.ironRootsIcon + 1
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.SpawnYell then
--[[		if self.Options.HealthFrame then
			if not adds[33202] then DBM.BossHealth:AddBoss(33202, L.WaterSpirit) end -- ancient water spirit
			if not adds[32916] then DBM.BossHealth:AddBoss(32916, L.Snaplasher) end  -- snaplasher
			if not adds[32919] then DBM.BossHealth:AddBoss(32919, L.StormLasher) end -- storm lasher
		end]]
		adds[33202] = true
		adds[32916] = true
		adds[32919] = true
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 33202 or cid == 32916 or cid == 32919 then
--[[		if self.Options.HealthFrame then
			DBM.BossHealth:RemoveBoss(cid)
		end]]
		if (GetTime() - killTime) > 20 then
			killTime = GetTime()
			timerSimulKill:Start()
			warnSimulKill:Show()
		end
		adds[cid] = nil
		local counter = 0
		for i, v in pairs(adds) do
			counter = counter + 1
		end
		if counter == 0 then
			timerSimulKill:Stop()
		end
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, mob)
	if strmatch(msg, L.Gift) then
		specWarnGiftEonar:Show()
		specWarnGiftEonar:Play("mobkill")
		timerEonarsGiftCD:Start()
		countdownGiftEonar:Start()
		warnGiftEonar:Schedule(40)
		warnGiftEonar:ScheduleVoice(40, "specialsoon")
	end
end
