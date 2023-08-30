local mod	= DBM:NewMod("GeneralVezax", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
mod:SetCreatureID(33271)
mod:SetUsedIcons(8, 7)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START 62661 62662",
	"SPELL_AURA_APPLIED 62662",
	"SPELL_AURA_REMOVED 62662 63276",
	"SPELL_CAST_SUCCESS 62660 63276",
	"SPELL_INTERRUPT",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

local warnShadowCrash			= mod:NewTargetAnnounce(62660, 3)
local warnLeechLife				= mod:NewTargetAnnounce(63276, 4)

local specWarnShadowCrash2		= mod:NewSpecialWarningCloseMoveAway(62660, nil, nil, nil, 2, 3) --Темное сокрушение
local specWarnShadowCrash		= mod:NewSpecialWarning("SpecialWarningShadowCrash")
--local specWarnShadowCrashNear	= mod:NewSpecialWarning("SpecialWarningShadowCrashNear")
local specWarnSurgeDarkness		= mod:NewSpecialWarningSpell(62662, "-Tank", nil, nil, 1, 2) --Наступление Тьмы
local specWarnSurgeDarkness2	= mod:NewSpecialWarningDefensive(62662, "Tank", nil, nil, 5, 6) --Наступление Тьмы
local specWarnLifeLeechYou		= mod:NewSpecialWarningYouMoveAway(63276, nil, nil, nil, 3, 6) --Метка безликого
local specWarnLifeLeech			= mod:NewSpecialWarningEnd(63276, nil, nil, nil, 1, 2) --Метка безликого

local timerSearingFlamesCast	= mod:NewCastTimer(2, 62661)
local timerNextSurgeofDarkness	= mod:NewCDTimer(62, 62662, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON..DBM_CORE_DEADLY_ICON) --Наступление Тьмы
local timerSurgeofDarkness		= mod:NewBuffActiveTimer(10, 62662, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Наступление Тьмы
local timerSaroniteVapors		= mod:NewNextTimer(30, 63322)
local timerLifeLeech			= mod:NewTargetTimer(10, 63276)
local timerHardmode				= mod:NewAchievementTimer(189, 12373, "TimerSpeedKill", nil, nil, 7)
local timerEnrage				= mod:NewBerserkTimer(600)

local countdownSurgeDarkness	= mod:NewCountdown(62, 62662, nil, nil, 5) --Наступление Тьмы
local countdownSurgeDarkness2	= mod:NewCountdownFades("Alt10", 62662, nil, nil, 3) --Наступление Тьмы

local yellMarkFaceless			= mod:NewYellMoveAway(63276, nil, nil, nil, "YELL") --Метка безликого
local yellShadowCrash			= mod:NewYellMoveAway(62660, nil, nil, nil, "YELL") --Темное сокрушение

mod:AddSetIconOption("SetIconOnMarkFacelessTarget", 63276, true, false, {8}) --Метка безликого
mod:AddSetIconOption("SetIconOnShadowCrashTarget", 62660, true, false, {7}) --Темное сокрушение
mod:AddBoolOption("BypassLatencyCheck", false)--Use old scan method without syncing or latency check (less reliable but not dependant on other DBM users in raid)


function mod:OnCombatStart(delay)
	timerEnrage:Start(-delay)
	timerHardmode:Start(-delay)
	timerNextSurgeofDarkness:Start(-delay)
	countdownSurgeDarkness:Start(-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 62661 then --Жгучее пламя
		timerSearingFlamesCast:Start()
	elseif spellId == 62662 then --Наступление Тьмы
		if self:IsTank() then
			specWarnSurgeDarkness2:Show()
			specWarnSurgeDarkness2:Play("defensive")
		else
			specWarnSurgeDarkness:Show()
			specWarnSurgeDarkness:Play("specialsoon")
		end
		timerNextSurgeofDarkness:Start()
		countdownSurgeDarkness:Start()
	end
end

function mod:SPELL_INTERRUPT(args)
	local spellId = args.spellId
	if spellId == 62661 then --Жгучее пламя
		timerSearingFlamesCast:Stop()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 62662 then --Наступление Тьмы
		timerSurgeofDarkness:Start()
		countdownSurgeDarkness2:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 62662 then --Наступление Тьмы
		timerSurgeofDarkness:Stop()
		countdownSurgeDarkness2:Cancel()
	elseif spellId == 63276 then --Метка безликого
		if args:IsPlayer() then
			specWarnLifeLeech:Show()
			specWarnLifeLeech:Play("end")
		end
	end
end

function mod:ShadowCrashTarget()
	local target = self:GetBossTarget(33271)
	if not target then return end
	if mod:LatencyCheck() then--Only send sync if you have low latency.
		self:SendSync("CrashOn", target)
	end
end

function mod:OldShadowCrashTarget()
	local targetname = self:GetBossTarget()
	if not targetname then return end
	if self.Options.SetIconOnShadowCrashTarget then
		self:SetIcon(targetname, 7, 10)
	end
	warnShadowCrash:Show(targetname)
	if targetname == UnitName("player") then
		specWarnShadowCrash:Show(targetname)
		specWarnShadowCrash:Play("runout")
		yellShadowCrash:Yell()
	elseif self:CheckNearby(11, args.destName) then
		specWarnShadowCrash2:Show(args.destName)
		specWarnShadowCrash2:Play("runout")
--[[	elseif targetname then
		local uId = DBM:GetRaidUnitId(targetname)
		if uId then
			local inRange = CheckInteractDistance(uId, 2)
			local x, y = GetPlayerMapPosition(uId)
			if x == 0 and y == 0 then
				SetMapToCurrentZone()
				x, y = GetPlayerMapPosition(uId)
			end
			if inRange then
				specWarnShadowCrashNear:Show()
			end
		end]]
	end
end


function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 62660 then --Темное сокрушение
		if self.Options.BypassLatencyCheck then
			self:ScheduleMethod(0.1, "OldShadowCrashTarget")
		else
			self:ScheduleMethod(0.1, "ShadowCrashTarget")
		end
	elseif spellId == 63276 then --Метка безликого
		if args:IsPlayer() then
			specWarnLifeLeechYou:Show()
			specWarnLifeLeechYou:Play("runaway")
			yellMarkFaceless:Yell()
		else
			warnLeechLife:Show(args.destName)
		end
		if self.Options.SetIconOnMarkFacelessTarget then
			self:SetIcon(args.destName, 8, 10)
		end
		timerLifeLeech:Start(args.destName)
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(emote)
	if emote == L.EmoteSaroniteVapors or emote:find(L.EmoteSaroniteVapors) then
		timerSaroniteVapors:Start()
	end
end

function mod:OnSync(msg, target)
	if msg == "CrashOn" then
		if not self.Options.BypassLatencyCheck then
			warnShadowCrash:Show(target)
			if self.Options.SetIconOnShadowCrashTarget then
				self:SetIcon(target, 7, 10)
			end
			if target == UnitName("player") then
				specWarnShadowCrash:Show()
				specWarnShadowCrash:Play("runout")
				yellShadowCrash:Yell()
			elseif self:CheckNearby(11, args.destName) then
				specWarnShadowCrash2:Show(args.destName)
				specWarnShadowCrash2:Play("runout")
--[[			elseif target then
				local uId = DBM:GetRaidUnitId(target)
				if uId then
					local inRange = CheckInteractDistance(uId, 2)
					local x, y = GetPlayerMapPosition(uId)
					if x == 0 and y == 0 then
						SetMapToCurrentZone()
						x, y = GetPlayerMapPosition(uId)
					end
					if inRange then
						specWarnShadowCrashNear:Show()
					end
				end]]
			end
		end
	end
end
