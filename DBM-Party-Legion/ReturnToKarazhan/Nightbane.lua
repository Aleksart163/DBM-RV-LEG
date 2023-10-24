local mod	= DBM:NewMod("Nightbane", "DBM-Party-Legion", 11)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
mod:SetCreatureID(114895)
mod:SetEncounterID(2031)
mod:SetZone()
mod:SetUsedIcons(8)
mod:SetHotfixNoticeRev(17700)
mod.respawnTime = 25

mod.onlyMythic = true--VERIFY how they actually do this

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 228839 228837 228785 229307",
	"SPELL_CAST_SUCCESS 228796 228829",
	"SPELL_AURA_APPLIED 228796",
	"SPELL_AURA_REMOVED 228796",
	"SPELL_PERIODIC_DAMAGE 228808",
	"SPELL_PERIODIC_MISSED 228808",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, Infernal Power http://www.wowhead.com/spell=228792/infernal-power
--TODO, Absorb Vitality? http://www.wowhead.com/spell=228835/absorb-vitality
--TODO, tweak breath warning?
local warnIgniteSoul				= mod:NewTargetAnnounce(228796, 4) --Воспламенение души
local warnBreath					= mod:NewTargetAnnounce(228785, 4) --Испепеляющее дыхание
local warnPhase2					= mod:NewPhaseAnnounce(2, 2)
local warnPhase3					= mod:NewPhaseAnnounce(3, 2)

--local specWarnReverbShadows			= mod:NewSpecialWarningCount(229307, "HasInterrupt", nil, nil, 1, 3) --Рокочущие тени
local specWarnReverbShadows			= mod:NewSpecialWarningSpell(229307, nil, nil, nil, 1, 3) --Рокочущие тени
local specWarnCharredEarth			= mod:NewSpecialWarningYouMove(228808, nil, nil, nil, 1, 2) --Опаленная земля
local specWarnIgniteSoul			= mod:NewSpecialWarningMoveTo(228796, nil, nil, nil, 3, 6) --Воспламенение души
local specWarnFear					= mod:NewSpecialWarningSpell(228837, nil, nil, nil, 2, 2) --Раскатистый рев

local timerReverbShadowsCD			= mod:NewCDTimer(12, 229307, nil, nil, nil, 2, nil) --12-16 Рокочущие тени
local timerBreathCD					= mod:NewCDTimer(23, 228785, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON) --23-35 Испепеляющее дыхание
local timerCharredEarthCD			= mod:NewCDTimer(20, 228806, nil, nil, nil, 3) --20-25 Опаленная земля
local timerBurningBonesCD			= mod:NewCDTimer(18.3, 228829, nil, nil, nil, 3) --20-25 Горящие кости
local timerIgniteSoulCD				= mod:NewCDTimer(25, 228796, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Воспламенение души

local timerFearCD					= mod:NewCDTimer(43, 228837, nil, nil, nil, 2) --43-46 Раскатистый рев

local yellBreath					= mod:NewYell(228785, nil, nil, nil, "YELL") --Испепеляющее дыхание
local yellIgniteSoul				= mod:NewShortFadesYell(228796, nil, nil, nil, "YELL") --Воспламенение души

local countdownIngiteSoul			= mod:NewCountdownFades(9, 228796, nil, nil, 5) --Воспламенение души

mod:AddSetIconOption("SetIconOnIgnite", 228796, true, false, {8}) --Воспламенение души
mod:AddInfoFrameOption(228829, true)

mod.vb.phase = 1
mod.vb.kickCount = 0

local charredEarth, burningBones, filteredDebuff = DBM:GetSpellInfo(228808), DBM:GetSpellInfo(228829), DBM:GetSpellInfo(228796)

function mod:BreathTarget(targetname, uId) --прошляпанное очко Мурчаля Прошляпенко ✔
	if not targetname then return end
	if targetname == UnitName("player") then
		yellBreath:Yell()
	else
		warnBreath:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.kickCount = 0
	timerBreathCD:Start(8.5-delay)
	timerCharredEarthCD:Start(15-delay)
	timerReverbShadowsCD:Start(17-delay)
	timerBurningBonesCD:Start(19.4-delay)
	timerIgniteSoulCD:Start(20-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(burningBones)
		DBM.InfoFrame:Show(5, "playerdebuffstacks", burningBones)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 228839 then--Phase 2 (can be detected earlier with yell, but this is better than localizing)
		self.vb.phase = 2
		warnPhase2:Show()
		timerIgniteSoulCD:Stop()
		timerBurningBonesCD:Stop()
		timerCharredEarthCD:Stop()
		timerReverbShadowsCD:Stop()
		timerBreathCD:Stop()
	elseif spellId == 228837 then
		specWarnFear:Show()
		specWarnFear:Play("fearsoon")
		timerFearCD:Start()
	elseif spellId == 228785 then --Испепеляющее дыхание
		self:BossTargetScanner(args.sourceGUID, "BreathTarget", 0.1, 2)
		timerBreathCD:Start()
	elseif spellId == 229307 then --Рокочущие тени
	--[[	if self.vb.kickCount == 2 then self.vb.kickCount = 0 end
		self.vb.kickCount = self.vb.kickCount + 1
		local kickCount = self.vb.kickCount
		specWarnReverbShadows:Show(kickCount)
		if kickCount == 1 then
			specWarnReverbShadows:Play("kick1r")
		elseif kickCount == 2 then
			specWarnReverbShadows:Play("kick2r")
			self.vb.kickCount = 0
		end]]
		DBM:AddMsg(L.Tip)
		specWarnReverbShadows:Show()
		specWarnReverbShadows:Play("aesoon")
		timerReverbShadowsCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 228796 then
		timerIgniteSoulCD:Start()
	elseif spellId == 228829 then
		timerBurningBonesCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 228796 then
		countdownIngiteSoul:Start()
		if args:IsPlayer() then
			specWarnIgniteSoul:Show(charredEarth)
			specWarnIgniteSoul:Play("targetyou")
			--Yes a 5 count (not typical 3). This debuff is pretty much EVERYTHING
			yellIgniteSoul:Countdown(9, 5)
		else
			warnIgniteSoul:Show(args.destName)
		end
		if self.Options.SetIconOnIgnite then
			self:SetIcon(args.destName, 8)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 228796 then
		if args:IsPlayer() then
			yellIgniteSoul:Cancel()
		end
		countdownIngiteSoul:Cancel()
		if self.Options.SetIconOnIgnite then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228808 and destGUID == UnitGUID("player") and not UnitDebuff("player", filteredDebuff) and self:AntiSpam(2, 1) then
		specWarnCharredEarth:Show()
		specWarnCharredEarth:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 114903 then--Bonecurse
		self.vb.phase = 3
		self.vb.kickCount = 0
		warnPhase3:Show()
		timerBreathCD:Start(12)
		timerFearCD:Start(20)
		timerCharredEarthCD:Start(23)
		timerIgniteSoulCD:Start(24)
		timerBurningBonesCD:Start(25)
		timerReverbShadowsCD:Start(30)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 228806 then--Charred Earth pre cast
		timerCharredEarthCD:Start()
	end
end
