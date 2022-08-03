local mod	= DBM:NewMod(1518, "DBM-Party-Legion", 1, 740)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(98542)
mod:SetEncounterID(1832)
mod:SetZone()
mod:SetUsedIcons(8, 7)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 194966",
	"SPELL_AURA_REMOVED 194966",
	"SPELL_CAST_START 195254 194966 194956 196078 196587",
	"UNIT_HEALTH boss1"
)

local warnCallSouls2				= mod:NewSoonAnnounce(196078, 1) --Вызов душ
local warnSwirlingScythe			= mod:NewTargetAnnounce(195254, 2) --Вращающаяся коса
local warnSoulEchoes				= mod:NewTargetAnnounce(194966, 2) --Эхо души
local warnCallSouls					= mod:NewSpellAnnounce(196078, 3) --Вызов душ

local specWarnSoulBurst				= mod:NewSpecialWarningDefensive(196587, nil, nil, nil, 3, 5) --Взрыв души
local specWarnCallSouls				= mod:NewSpecialWarningSwitch(196078, "-Healer", nil, nil, 1, 2) --Вызов душ
local specWarnReapSoul				= mod:NewSpecialWarningDodge(194956, "MeleeDps", nil, nil, 2, 2) --Жатва душ
local specWarnReapSoul2				= mod:NewSpecialWarningYouMove(194956, "Tank", nil, nil, 3, 5) --Жатва душ
local specWarnSoulEchos				= mod:NewSpecialWarningYouRun(194966, nil, nil, nil, 4, 5) --Эхо души
local specWarnSwirlingScythe		= mod:NewSpecialWarningDodge(195254, nil, nil, nil, 2, 2) --Вращающаяся коса
local specWarnSwirlingScytheNear	= mod:NewSpecialWarningCloseMoveAway(195254, nil, nil, nil, 1, 2) --Вращающаяся коса
local specWarnSoulEchosNear			= mod:NewSpecialWarningCloseMoveAway(194966, nil, nil, nil, 1, 2) --Эхо души

local timerSoulBurstCD				= mod:NewCDTimer(23, 196587, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON..DBM_CORE_MYTHIC_ICON) --Взрыв души
local timerSwirlingScytheCD			= mod:NewCDTimer(21, 195254, nil, nil, nil, 3) --Вращающаяся коса 20-27
local timerSoulEchoesCD				= mod:NewNextTimer(28, 194966, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Эхо души
local timerReapSoulCD				= mod:NewNextTimer(13, 194956, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON..DBM_CORE_DEADLY_ICON) --Жатва душ

local yellSwirlingScythe			= mod:NewYell(195254, nil, nil, nil, "YELL") --Вращающаяся коса
local yellSoulEchos					= mod:NewYell(194966, nil, nil, nil, "YELL") --Эхо души
local yellSoulEchos2				= mod:NewFadesYell(194966, nil, nil, nil, "YELL") --Эхо души

local countdownReapSoul				= mod:NewCountdown(13, 194956, "Melee", nil, 5) --Жатва душ

mod:AddSetIconOption("SetIconOnSoulEchoes", 194966, true, false, {8}) --Эхо души
mod:AddSetIconOption("SetIconOnSwirlingScythe", 195254, true, false, {7}) --Вращающаяся коса
--mod:AddRangeFrameOption(5, 194966)

mod.vb.phase = 1
local warned_preP1 = false
local warned_preP2 = false

function mod:ScytheTarget(targetname, uId) 
	if not targetname then
		warnSwirlingScythe:Show(DBM_CORE_UNKNOWN)
		return
	end
	if targetname == UnitName("player") then --Вращающаяся коса
		specWarnSwirlingScythe:Show()
		specWarnSwirlingScythe:Play("runaway")
		yellSwirlingScythe:Yell()
	elseif self:CheckNearby(7, targetname) then
		specWarnSwirlingScytheNear:Show(targetname)
		specWarnSwirlingScytheNear:Play("runaway")
	else
		warnSwirlingScythe:Show(targetname)
	end
	if self.Options.SetIconOnSwirlingScythe then
		self:SetIcon(targetname, 7, 5)
	end
end

function mod:SoulTarget(targetname, uId)
	if not targetname then
		return
	end
	if self:AntiSpam(3, targetname) then --Эхо души
		if targetname == UnitName("player") then
			specWarnSoulEchos:Show()
			specWarnSoulEchos:Play("runaway")
			specWarnSoulEchos:ScheduleVoice(1, "keepmove")
			yellSoulEchos:Yell()
			yellSoulEchos2:Countdown(12, 3)
		elseif self:CheckNearby(6, targetname) then
			specWarnSoulEchosNear:Show(targetname)
			specWarnSoulEchosNear:Play("runaway")
		else
			warnSoulEchoes:Show(targetname)
		end
		if self.Options.SetIconOnSoulEchoes then
			self:SetIcon(targetname, 8, 12)
		end
	end
end

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	warned_preP1 = false
	warned_preP2 = false
	timerSwirlingScytheCD:Start(8-delay)
	timerSoulEchoesCD:Start(15.5-delay)
	timerReapSoulCD:Start(20-delay)
	countdownReapSoul:Start(20-delay)
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 194966 and self:AntiSpam(3, args.destName) then--Backup Soul echos warning that's 2 seconds slower than target scan
		if args:IsPlayer() then
			specWarnSoulEchos:Show()
			specWarnSoulEchos:Play("runaway")
			specWarnSoulEchos:ScheduleVoice(1, "keepmove")
		else
			warnSoulEchoes:Show(args.destName)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 194966 then
		if args:IsPlayer() then
			yellSoulEchos2:Cancel()
		end
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 195254 then
		timerSwirlingScytheCD:Start()
		self:BossTargetScanner(98542, "ScytheTarget", 0.05, 12, true)--Can target tank if no one else is left, but if this causes probelm add tank filter back
	elseif spellId == 194966 then
		timerSoulEchoesCD:Start()
		self:BossTargetScanner(98542, "SoulTarget", 0.1, 20, true, nil, nil, nil, true)--Always filter tank, because if scan fails debuff will be used.
	elseif spellId == 194956 then
		specWarnReapSoul2:Show()
		specWarnReapSoul2:Play("shockwave")
		specWarnReapSoul:Show()
		specWarnReapSoul:Play("shockwave")
		timerReapSoulCD:Start()
		countdownReapSoul:Start()
	elseif spellId == 196078 then --Вызов душ
		self.vb.phase = 2
		warned_preP2 = true
		warnCallSouls:Show()
		specWarnCallSouls:Schedule(2.5)
		timerSwirlingScytheCD:Stop()
		timerSoulEchoesCD:Stop()
		timerReapSoulCD:Stop()
		countdownReapSoul:Stop()
		timerSoulBurstCD:Start()
	elseif spellId == 196587 then --Взрыв души
		if not self:IsNormal() then
			specWarnSoulBurst:Show()
			specWarnSoulBurst:Play("defensive")
		end
		timerSwirlingScytheCD:Start(8)
		timerSoulEchoesCD:Start(15.2)
		timerReapSoulCD:Start(20.2)
		countdownReapSoul:Start(20.2)
	end
end

function mod:UNIT_HEALTH(uId)
	if self:IsHard() then --миф и миф+
		if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 98542 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.56 then
			warned_preP1 = true
			warnCallSouls2:Show()
		end
	else
		if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 98542 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.56 then
			warned_preP1 = true
			warnCallSouls2:Show()
		end
	end
end
