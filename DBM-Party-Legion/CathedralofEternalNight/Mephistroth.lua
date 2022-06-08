local mod	= DBM:NewMod(1878, "DBM-Party-Legion", 12, 900)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(120793)
mod:SetEncounterID(2039)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 233155 233206 234817 233963 233196",
	"SPELL_AURA_REMOVED 233206",
	"UNIT_AURA_UNFILTERED",
	"SPELL_PERIODIC_DAMAGE 233177",
	"SPELL_PERIODIC_MISSED 233177",
	"UNIT_SPELLCAST_SUCCEEDED"--All available unitIDs, no bossN for shadows
)

local warnDarkSolitude				= mod:NewSpellAnnounce(234817, 2) --Темное одиночество
local warnShadowFade				= mod:NewSpellAnnounce(233206, 2) --Уход во тьму
local warnDemonicUpheaval			= mod:NewTargetAnnounce(233963, 3) --Демоническое извержение
local warnShadowAdd					= mod:NewSpellAnnounce("ej14965", 2, 233206) --Уход во тьму треш
local warnShadowFade2				= mod:NewPreWarnAnnounce(233206, 5, 1) --Уход во тьму

local specWarnShadowFadeEnded		= mod:NewSpecialWarningEnd(233206, nil, nil, nil, 1, 2) --Уход во тьму
local specWarnCarrionSwarm2			= mod:NewSpecialWarningYouMove(233177, nil, nil, nil, 1, 2) --Темная стая
local specWarnShadowFade			= mod:NewSpecialWarningSwitch(233206, "Dps", nil, nil, 1, 2) --Уход во тьму
local specWarnCarrionSwarm			= mod:NewSpecialWarningYouDefensive(233155, "Tank", nil, nil, 3, 5) --Темная стая
local specWarnDemonicUpheaval		= mod:NewSpecialWarningYouMoveAway(233963, nil, nil, nil, 4, 5) --Демоническое извержение
local specWarnDemonicUpheaval2		= mod:NewSpecialWarningEnd(233963, nil, nil, nil, 1, 2) --Демоническое извержение

local timerDarkSolitudeCD			= mod:NewCDTimer(8.5, 234817, nil, nil, nil, 3, nil, DBM_CORE_HEALER_ICON..DBM_CORE_DEADLY_ICON) --Темное одиночество
local timerCarrionSwarmCD			= mod:NewCDTimer(18, 233155, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON..DBM_CORE_DEADLY_ICON) --Темная стая
local timerDemonicUpheavalCD		= mod:NewCDTimer(26.5, 233196, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Демоническое извержение 32-35
local timerShadowFadeCD				= mod:NewCDTimer(80, 233206, nil, nil, nil, 6) --Уход во тьму

local yellDemonicUpheaval			= mod:NewYell(233963, nil, nil, nil, "YELL") --Демоническое извержение
local yellDemonicUpheaval2			= mod:NewFadesYell(233963, nil, nil, nil, "YELL") --Демоническое извержение

local countdownShadowFade			= mod:NewCountdown(80, 233206, nil, nil, 5) --Уход во тьму
local countdownDemonicUpheaval		= mod:NewCountdownFades("Alt26.5", 233196, nil, nil, 5) --Демоническое извержение

mod:AddRangeFrameOption(8, 234817) --Темное одиночество 5 yards probably too small, next lowest range on crap api is 8
mod:AddInfoFrameOption(234217, true)

local demonicUpheaval, darkSolitude = DBM:GetSpellInfo(233963), DBM:GetSpellInfo(234217)
local demonicUpheavalTable = {}
local addsTable = {}

function mod:OnCombatStart(delay)
	table.wipe(addsTable)
	timerDemonicUpheavalCD:Start(3.7-delay)--Cast Start
	timerDarkSolitudeCD:Start(7.1-delay)
	timerCarrionSwarmCD:Start(18.5-delay)
	timerShadowFadeCD:Start(40-delay)--Cast Start
	countdownShadowFade:Start(40-delay)
	warnShadowFade2:Schedule(35-delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(8)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 233155 then
		specWarnCarrionSwarm:Show()
		specWarnCarrionSwarm:Play("shockwave")
		timerCarrionSwarmCD:Start()
	elseif spellId == 233206 then--Shadow Fade
		warnShadowFade:Show()
		specWarnShadowFade:Schedule(9)
		specWarnShadowFade:ScheduleVoice(9, "switch")
		timerCarrionSwarmCD:Stop()
		timerDarkSolitudeCD:Stop()
		timerDemonicUpheavalCD:Stop()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif spellId == 234817 then
		warnDarkSolitude:Show()
		timerDarkSolitudeCD:Start()
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(darkSolitude)
			DBM.InfoFrame:Show(2, "enemypower", 2, ALTERNATE_POWER_INDEX)
		end
	elseif spellId == 233963 or spellId == 233196 then --Демоническое извержение
		timerDemonicUpheavalCD:Start()
		countdownDemonicUpheaval:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 233206 then --Уход во тьму заканчивается
		specWarnShadowFadeEnded:Show()
		timerDemonicUpheavalCD:Start(3.5)--3 for cast start 6 for cast finish, decide which one want to use still
		timerDarkSolitudeCD:Start(7.5)
		timerCarrionSwarmCD:Start(18.5)
		timerShadowFadeCD:Start()
		warnShadowFade2:Schedule(75)
		countdownShadowFade:Start()
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(8)
		end
	end
end

function mod:UNIT_AURA_UNFILTERED(uId)
	local hasDebuff = UnitDebuff(uId, demonicUpheaval)
	local name = DBM:GetUnitFullName(uId)
	if not hasDebuff and demonicUpheavalTable[name] then
		demonicUpheavalTable[name] = nil
	elseif hasDebuff and not demonicUpheavalTable[name] then
		demonicUpheavalTable[name] = true
		warnDemonicUpheaval:CombinedShow(1, name)--Multiple targets in mythic
		if UnitIsUnit(uId, "player") then
			specWarnDemonicUpheaval:Show()
			specWarnDemonicUpheaval:Play("runout")
			yellDemonicUpheaval:Yell()
			yellDemonicUpheaval2:Countdown(5, 3)
			specWarnDemonicUpheaval2:Schedule(5)
		end
	end
end

--TODO, syncing maybe do to size and spread in room, not all nameplates will be caught by one person
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	--"<51.81 19:21:30> [UNIT_SPELLCAST_SUCCEEDED] Unknown(??) [[nameplate1:Shadow of Mephistroth Cosmetic::3-3020-1677-21626-234034-00025D92FA:234034]]", -- [308]
	if spellId == 234034 then--Only will trigger if nameplate is in range
		local guid = UnitGUID(uId)
		if not addsTable[guid] then
			addsTable[guid] = true
			warnShadowAdd:Show()
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 233177 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		if self:IsHard() then
			specWarnCarrionSwarm2:Show()
			specWarnCarrionSwarm2:Play("runaway")
		end
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--TODO: Can tank dodge swarm once cast starts?
--TODO, shadowfade ending and initial timers post shadow phase
--TODO, verify if more debuff spellids for Demonic Upheavel than one. determine if best place to do timer
--TODO, shadow of mephistro spawn warnings, probably 234034
--TODO, phases for mephisto
--TODO, announce who grabs shield on mephisto
--TODO, announce circles spawning on ground (watch step) on mephisto
