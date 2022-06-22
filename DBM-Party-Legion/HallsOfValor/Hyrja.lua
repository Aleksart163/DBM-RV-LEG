local mod	= DBM:NewMod(1486, "DBM-Party-Legion", 4, 721)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(95833)
mod:SetEncounterID(1806)
mod:SetZone()
mod:SetUsedIcons(8, 7)
mod:RegisterCombat("combat")
mod:SetWipeTime(120)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 192048 192133 192132",
	"SPELL_AURA_APPLIED_DOSE 192048 192133 192132",
	"SPELL_AURA_REMOVED 192048 192133 192132",
	"SPELL_CAST_START 192158 192018 192307 200901 191976",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)
--Хирья https://ru.wowhead.com/npc=95833/хирья/эпохальный-журнал-сражений
local warnMysticEmpowermentHoly		= mod:NewStackAnnounce(192133, 4, nil, nil, 2) --Мистическое усиление: Свет
local warnMysticEmpowermentThunder	= mod:NewStackAnnounce(192132, 4, nil, nil, 2) --Мистическое усиление: гром
local warnExpelLight				= mod:NewTargetAnnounce(192048, 4) --Световое излучение
local warnArcingBolt				= mod:NewTargetAnnounce(191976, 3) --Дуговая молния
local warnPhase2					= mod:NewPhaseAnnounce(2, 2, nil, nil, nil, nil, nil, 2) --фаза

local specWarnShieldOfLight			= mod:NewSpecialWarningYouDefensive(192018, "Tank", nil, nil, 3, 2) --Щит Света
local specWarnSanctify				= mod:NewSpecialWarningDodge(192158, "Ranged", nil, nil, 2, 5) --Освящение
local specWarnSanctify2				= mod:NewSpecialWarningRun(192158, "Melee", nil, nil, 4, 5) --Освящение
local specWarnEyeofStorm			= mod:NewSpecialWarningMoveTo(200901, nil, nil, nil, 4, 3) --Око шторма
local specWarnEyeofStorm2			= mod:NewSpecialWarningDefensive(200901, nil, nil, nil, 3, 3) --Око шторма
local specWarnExpelLight			= mod:NewSpecialWarningYouMoveAway(192048, nil, nil, nil, 3, 3) --Световое излучение
--local specWarnExpelLight2			= mod:NewSpecialWarningYouDefensive(192048, nil, nil, nil, 3, 3) --Световое излучение
local specWarnArcingBolt			= mod:NewSpecialWarningYouMoveAway(191976, nil, nil, nil, 3, 3) --Дуговая молния

local timerArcingBoltCD				= mod:NewCDTimer(28, 191976, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Дуговая молния+++
local timerShieldOfLightCD			= mod:NewCDTimer(28, 192018, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON..DBM_CORE_DEADLY_ICON) --Щит Света 28-34
local timerSpecialCD				= mod:NewNextTimer(30, 200736, nil, nil, nil, 2, 200901, DBM_CORE_DEADLY_ICON) --Особый спелл
local timerExpelLightCD				= mod:NewCDTimer(24.5, 192048, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Световое излучение+++

local yellExpelLight				= mod:NewYell(192048, nil, nil, nil, "YELL") --Световое излучение
local yellExpelLight2				= mod:NewShortFadesYell(192048, nil, nil, nil, "YELL") --Световое излучение
local yellArcingBolt				= mod:NewYell(191976, nil, nil, nil, "YELL") --Дуговая молния

local countdownSpecial				= mod:NewCountdown(30, 200736, nil, nil, 5) --Особый спелл
local countdownShieldOfLight		= mod:NewCountdown("Alt27.5", 192018, "Tank", nil, 5) --Щит Света

mod:AddSetIconOption("SetIconOnExpelLight", 192048, true, false, {8}) --Световое излучение
mod:AddSetIconOption("SetIconOnArcingBolt", 191976, true, false, {7}) --Дуговая молния
mod:AddBoolOption("AnnounceArcingBolt", false)
mod:AddRangeFrameOption(8, 192048) --Световое излучение

local eyeShortName = DBM:GetSpellInfo(91320)--Inner Eye

mod.vb.phase = 1
local warned_MEH = false
local warned_MET = false
local firstpull = false

function mod:ArcingBoltTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnArcingBolt:Show()
		specWarnArcingBolt:Play("runout")
		yellArcingBolt:Yell()
	else
		warnArcingBolt:Show(targetname)
	end
	if self.Options.SetIconOnArcingBolt then
		self:SetIcon(targetname, 7, 5)
	end
	if mod.Options.AnnounceArcingBolt then
		if IsInRaid() then
			SendChatMessage(L.ArcingBolt:format(targetname), "RAID")
		elseif IsInGroup() then
			SendChatMessage(L.ArcingBolt:format(targetname), "PARTY")
		end
	end
end

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	warned_MEH = false
	warned_MET = false
	firstpull = false
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 192048 then --Световое излучение
		warnExpelLight:Show(args.destName)
		if not self:IsNormal() then
			if args:IsPlayer() then
				specWarnExpelLight:Show()
				specWarnExpelLight:Play("runout")
			--	specWarnExpelLight2:Schedule(1.5)
			--	specWarnExpelLight2:ScheduleVoice(1.5, "defensive")
				yellExpelLight:Yell()
				yellExpelLight2:Countdown(3)
			end
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(8)
		end
		if self.Options.SetIconOnArcingBolt then
			self:SetIcon(args.destName, 8, 5)
		end
		timerExpelLightCD:Start()
	elseif spellId == 192133 then --Мистическое усиление: Свет
		local amount = args.amount or 1
		warned_MEH = true
		if not firstpull then
			firstpull = true
			timerShieldOfLightCD:Start(25.5)
			countdownShieldOfLight:Start(25.5)
		end
		if not self:IsNormal() then
			if amount == 1 then
				timerExpelLightCD:Start(2)
			elseif amount >= 5 and amount % 5 == 0 then
				warnMysticEmpowermentHoly:Show(args.destName, amount)
			end
		end
	elseif spellId == 192132 then --Мистическое усиление: гром
		local amount = args.amount or 1
		warned_MET = true
		if not firstpull then
			firstpull = true
			timerShieldOfLightCD:Start(22.5)
			countdownShieldOfLight:Start(22.5)
		end
		if not self:IsNormal() then
			if amount == 1 then
				timerArcingBoltCD:Start(3)
			elseif amount >= 5 and amount % 5 == 0 then
				warnMysticEmpowermentThunder:Show(args.destName, amount)
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 192048 then --Световое излучение
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif spellId == 192133 then --Мистическое усиление: Свет
		timerExpelLightCD:Stop()
		warned_MEH = false
	elseif spellId == 192132 then --Мистическое усиление: гром
		timerArcingBoltCD:Stop()
		warned_MET = false
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 192158 or spellId == 192307 then
		specWarnSanctify:Show()
		specWarnSanctify:Play("watchorb")
		specWarnSanctify2:Show()
		specWarnSanctify2:Play("watchorb")
		if spellId == 192307 then
			timerSpecialCD:Start()
			countdownSpecial:Cancel()
			countdownSpecial:Start()
		end
	elseif spellId == 192018 then --Щит Света
		specWarnShieldOfLight:Show()
		specWarnShieldOfLight:Play("defensive")
		timerShieldOfLightCD:Start()
		countdownShieldOfLight:Start()
	elseif spellId == 200901 then
		specWarnEyeofStorm:Show(eyeShortName)
		specWarnEyeofStorm:Play("findshelter")
		specWarnEyeofStorm2:Schedule(4)
		specWarnEyeofStorm2:ScheduleVoice(4, "defensive")
		if self.vb.phase == 2 then
			timerSpecialCD:Start()
			countdownSpecial:Cancel()
			countdownSpecial:Start()
		end
	elseif spellId == 191976 then --Дуговая молния
		self:BossTargetScanner(args.sourceGUID, "ArcingBoltTarget", 0.1)
		timerArcingBoltCD:Start(15)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 192130 then
		self.vb.phase = 2
		warnPhase2:Show()
		warnPhase2:Play("ptwo")
		timerSpecialCD:Start(9.5) --спец.способность верно
		countdownSpecial:Start(9.5) --спец.способность верно
	--	timerShieldOfLightCD:Start(27) --Щит Света верно
	--	countdownShieldOfLight:Start(27) --Щит Света верно
	end
end
