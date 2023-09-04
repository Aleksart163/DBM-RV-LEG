local mod	= DBM:NewMod("Kologarn", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
mod:SetCreatureID(32930, 32933, 32934)
--mod:SetCreatureID(32930)
mod:SetUsedIcons(5, 6, 7, 8)
mod:SetBossHPInfoToHighest()

mod:RegisterCombat("combat")
--mod:RegisterCombat("combat", 32930, 32933, 32934)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED 64290 64292 64002 63355",
	"SPELL_AURA_APPLIED_DOSE 64002",
	"SPELL_AURA_REMOVED 64290 64292",
	"SPELL_DAMAGE 63346 63976 63783 63982",
	"SPELL_MISSED 63346 63976 63783 63982",
	"SPELL_ABSORBED 63346 63976 63783 63982",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3"
)

--[[
mod:SetBossHealthInfo(
	32930, L.Health_Body,
	32934, L.Health_Right_Arm,
	32933, L.Health_Left_Arm
)]]

local warnFocusedEyebeam		= mod:NewTargetAnnounce(63346, 3)
local warnGrip					= mod:NewTargetAnnounce(64292, 2) --Каменная хватка
local warnCrunchArmor		    = mod:NewStackAnnounce(64002, 2, nil, "Tank|Healer") --Разламывание доспеха
local warnCrunchArmor2			= mod:NewTargetAnnounce(63355, 2, nil, "Tank|Healer") --Разламывание доспеха

local specWarnCrunchArmor		= mod:NewSpecialWarningStack(64002, nil, 2, nil, nil, 3, 6) --Разламывание доспеха
local specWarnCrunchArmor2		= mod:NewSpecialWarningTaunt(64002, "Tank", nil, nil, 3, 6) --Разламывание доспеха
local specWarnCrunchArmor3		= mod:NewSpecialWarningYouDefensive(63355, nil, nil, nil, 5, 6) --Разламывание доспеха
local specWarnEyebeam			= mod:NewSpecialWarningYouMoveAway(63346, nil, nil, nil, 4, 6) --Сосредоточенный взгляд
local specWarnEyebeam2			= mod:NewSpecialWarningYouMove(63346, nil, nil, nil, 1, 3) --Сосредоточенный взгляд

local timerCrunch10             = mod:NewTargetTimer(6, 63355, nil, nil, nil, 3, nil, DBM_CORE_TANK_ICON..DBM_CORE_DEADLY_ICON) --Разламывание доспеха
local timerCrunch25             = mod:NewTargetTimer(45, 64002, nil, nil, nil, 3, nil, DBM_CORE_TANK_ICON..DBM_CORE_DEADLY_ICON) --Разламывание доспеха
local timerOverheadSmash		= mod:NewCDTimer(15, 64003, nil, nil, nil, 3, nil, DBM_CORE_TANK_ICON) --Удар с размаха
local timerNextShockwave		= mod:NewCDTimer(18, 63982, nil, nil, nil, 2) --Ударная волна
local timerRespawnLeftArm		= mod:NewTimer(48, "timerLeftArm")
local timerRespawnRightArm		= mod:NewTimer(48, "timerRightArm")
local timerTimeForDisarmed		= mod:NewAchievementTimer(12, 12338, "TimerSpeedKill", nil, nil, 7)

local yellGrip					= mod:NewYellHelp(64292, nil, nil, nil, "YELL") --Каменная хватка
local yellEyebeam				= mod:NewYellMoveAway(63976, nil, nil, nil, "YELL") --Сосредоточенный взгляд

--mod:AddBoolOption("HealthFrame", true)
mod:AddSetIconOption("SetIconOnGripTarget", 64290, true, false, {7, 6, 5})
mod:AddSetIconOption("SetIconOnEyebeamTarget", 63976, true, false, {8})

function mod:OnCombatStart(delay)
	timerOverheadSmash:Start(5-delay)
	timerNextShockwave:Start(18-delay)
end

function mod:OnCombatEnd()
	timerRespawnRightArm:Stop()
	timerRespawnLeftArm:Stop()
	timerTimeForDisarmed:Stop()
	self:UnscheduleMethod("GripAnnounce")
end

local gripTargets = {}
function mod:GripAnnounce()
	warnGrip:Show(table.concat(gripTargets, "<, >"))
	table.wipe(gripTargets)
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 64290 or spellId == 64292 then --Каменная хватка
		if self.Options.SetIconOnGripTarget then
			self:SetIcon(args.destName, 7 - #gripTargets, 10)
		end
		table.insert(gripTargets, args.destName)
		self:UnscheduleMethod("GripAnnounce")
		if #gripTargets >= 3 then
			self:GripAnnounce()
		else
			self:ScheduleMethod(0.2, "GripAnnounce")
		end
		if args:IsPlayer() then
			yellGrip:Yell()
		end
	elseif spellId == 64002 then --Разламывание доспеха
		local amount = args.amount or 1
        if amount >= 2 then
            if args:IsPlayer() then
                specWarnCrunchArmor:Show(args.amount)
				specWarnCrunchArmor:Play("stackhigh")
            else
				local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", args.spellName)
				local remaining
				if expireTime then
					remaining = expireTime-GetTime()
				end
				if not UnitIsDeadOrGhost("player") and (not remaining or remaining and remaining < 30) then
					specWarnCrunchArmor2:Show(args.destName)
					specWarnCrunchArmor2:Play("tauntboss")
				else
					warnCrunchArmor:Show(args.destName, amount)
				end
			end
			timerCrunch25:Start(args.destName)
		else	
			warnCrunchArmor:Show(args.destName, amount)
		end
	elseif spellId == 63355 then --Разламывание доспеха
	--	if mod:IsDifficulty("heroic10") then
		if args:IsPlayer() then
			specWarnCrunchArmor3:Show()
			specWarnCrunchArmor3:Play("defensive")
		else
			warnCrunchArmor2:Show(args.destName)
		end
		timerCrunch10:Start(args.destName)  -- We track duration timer only in 10-man since it's only 6sec and tanks don't switch.
    end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 64290 or spellId == 64292 then --Каменная хватка
		self:RemoveIcon(args.destName)
    end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 63346 or spellId == 63976 and destGUID == UnitGUID("player") and self:AntiSpam(1, "proshlyapation") then
		specWarnEyebeam2:Show()
		specWarnEyebeam2:Play("runout")
	elseif spellId == 63783 or spellId == 63982 and destGUID == UnitGUID("player") then
		timerNextShockwave:Start()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE
mod.SPELL_ABSORBED = mod.SPELL_DAMAGE

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg) --Прошляпано Мурчалем Прошляпенко
	if msg == L.FocusedEyebeam or msg:find(L.FocusedEyebeam) then
		self:SendSync("EyeBeamOn", UnitName("player"))
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 32934 then --Правая рука
		timerRespawnRightArm:Start(40)
		timerTimeForDisarmed:Start()
	elseif cid == 32933 then --Левая рука
		timerRespawnLeftArm:Start(40)
		timerTimeForDisarmed:Start()
		timerNextShockwave:Stop()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 64003 then --Удар с размаха
		timerOverheadSmash:Start()
	end
end

function mod:OnSync(msg, target)
	if msg == "EyeBeamOn" then
		warnFocusedEyebeam:Show(target)
		if target == UnitName("player") then
			specWarnEyebeam:Show()
			specWarnEyebeam:Play("runaway")
			yellEyebeam:Yell()
		end 
		if self.Options.SetIconOnEyebeamTarget then
			self:SetIcon(target, 8, 11) 
		end
	end
end
