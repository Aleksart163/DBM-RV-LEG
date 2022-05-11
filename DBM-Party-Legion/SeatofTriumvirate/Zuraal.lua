local mod	= DBM:NewMod(1979, "DBM-Party-Legion", 13, 945)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(124871) --возможно ещё 122313
mod:SetEncounterID(2065)
mod:SetZone()
mod:SetUsedIcons(7)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 246134 244579 244653",
	"SPELL_CAST_SUCCESS 244433 246139",
	"SPELL_AURA_APPLIED 244657 244621 244653",
	"SPELL_AURA_REMOVED 244657 244621 244653",
	"SPELL_DAMAGE 244433",
--	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, more timer updates, warning tweaks, countdowns
--TODO, personal alternate power and warn when extra action is ready to leave Umbra Shift
--Void Brute
--local warnNullPalm						= mod:NewSpellAnnounce(246134, 2, nil, "Tank")
local warnPhase2						= mod:NewAnnounce("Phase2", 1, 244621) --Прорыв Бездны
local warnUmbraShift					= mod:NewTargetNoFilterAnnounce(244433, 4) --Теневой рывок
local warnFixate						= mod:NewTargetNoFilterAnnounce(244657, 3) --Сосредоточение внимания
local warnVoidTear						= mod:NewTargetNoFilterAnnounce(244621, 2) --Прорыв Бездны
local warnVoidTear2						= mod:NewPreWarnAnnounce(244621, 5, 1) --Прорыв Бездны

local specWarnNullPalm					= mod:NewSpecialWarningDodge(246134, nil, nil, 2, 2, 2) --Длань обнуления
local specWarnCoalescedVoid				= mod:NewSpecialWarningSwitch(244602, "Dps", nil, nil, 1, 2) --Сгустившаяся Бездна
local specWarnUmbraShift				= mod:NewSpecialWarning("UmbraShift", nil, nil, nil, 1, 2) --Теневой рывок
local specWarnFixate					= mod:NewSpecialWarningYouRun(244657, nil, nil, nil, 4, 5) --Сосредоточение внимания
local specWarnFixate2					= mod:NewSpecialWarningDodge(244653, nil, nil, nil, 2, 2) --Сосредоточение внимания
local specWarnVoidTear					= mod:NewSpecialWarningMoreDamage(244621, "-Healer", nil, nil, 3, 2) --Прорыв Бездны
local specWarnVoidTear2					= mod:NewSpecialWarningEnd(244621, nil, nil, nil, 1, 2) --Прорыв Бездны

local timerNullPalmCD					= mod:NewCDTimer(10.9, 246134, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Длань обнуления
local timerDeciminateCD					= mod:NewCDTimer(12.1, 244579, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON) --Истребление
local timerCoalescedVoidCD				= mod:NewCDTimer(12.1, 244602, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON) --Сгустившаяся Бездна
local timerUmbraShiftCD					= mod:NewCDTimer(12, 244433, nil, nil, nil, 6, nil, DBM_CORE_DAMAGE_ICON..DBM_CORE_MYTHIC_ICON) --Теневой рывок
local timerVoidTear						= mod:NewBuffActiveTimer(20, 244621, nil, nil, nil, 3, nil, DBM_CORE_DAMAGE_ICON) --Прорыв Бездны
local timerFixate						= mod:NewTargetTimer(10, 244653, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Сосредоточение внимания

local yellFixate						= mod:NewYell(244653, nil, nil, nil, "YELL") --Сосредоточение внимания
local yellFixate2						= mod:NewFadesYell(244653, nil, nil, nil, "YELL") --Сосредоточение внимания

local countdownUmbraShift				= mod:NewCountdown(14, 244433) --Теневой рывок

mod:AddSetIconOption("SetIconOnFixate", 244653, true, false, {7}) --Сосредоточение внимания

local UmbraShift = false
mod.vb.aberrations = 0

function mod:OnCombatStart(delay)
	UmbraShift = false
	self.vb.aberrations = 0
	if self:IsHard() then
		timerNullPalmCD:Start(11-delay) --Длань обнуления
		timerDeciminateCD:Start(16-delay) --Истребление
		timerCoalescedVoidCD:Start(18-delay) --Сгустившаяся Бездна
		timerUmbraShiftCD:Start(40-delay) --Теневой рывок
		countdownUmbraShift:Start(40-delay) --Теневой рывок
		warnVoidTear2:Schedule(35-delay) --Теневой рывок
	else
		timerNullPalmCD:Start(10-delay) --Длань обнуления
		timerDeciminateCD:Start(17.5-delay) --Истребление
		timerCoalescedVoidCD:Start(19.5-delay) --Сгустившаяся Бездна
		timerUmbraShiftCD:Start(40.5-delay) --Теневой рывок
		countdownUmbraShift:Start(40.5-delay) --Теневой рывок
		warnVoidTear2:Schedule(35-delay) --Теневой рывок
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 246134 then
		specWarnNullPalm:Show()
		specWarnNullPalm:Play("shockwave")
	--	timerNullPalmCD:Start()
	elseif spellId == 244579 then
		timerDeciminateCD:Start()
	elseif spellId == 244653 then --Сосредоточение внимания
		if not UmbraShift then
			specWarnFixate2:Show()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 246139 then --Сгустившаяся Бездна 244602
		specWarnCoalescedVoid:Show()
		specWarnCoalescedVoid:Play("killmob")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 244653 then --Сосредоточение внимания старый id 244657
		timerFixate:Start(args.destName)
		if args:IsPlayer() then
			specWarnFixate:Show()
			specWarnFixate:Play("justrun")
			yellFixate:Yell()
			yellFixate2:Countdown(10, 3)
		else
			warnFixate:Show(args.destName)
		end
		if self.Options.SetIconOnFixate then
			self:SetIcon(args.destName, 7)
		end
	elseif spellId == 244621 then --Прорыв Бездны
		UmbraShift = false
		self.vb.aberrations = 0
		warnVoidTear:Show(args.destName)
		specWarnVoidTear:Show()
		timerVoidTear:Start()
		timerNullPalmCD:Stop()
		timerDeciminateCD:Stop()
		timerCoalescedVoidCD:Stop()
		timerUmbraShiftCD:Stop()
		timerNullPalmCD:Start(31) --Длань обнуления
		timerDeciminateCD:Start(38) --Истребление
		timerCoalescedVoidCD:Start(40) --Сгустившаяся Бездна
		timerUmbraShiftCD:Start(60) --Теневой рывок
		countdownUmbraShift:Start(60) --Теневой рывок
		warnVoidTear2:Schedule(55) --Теневой рывок
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 244653 then --Сосредоточение внимания старый id 244657
		timerFixate:Cancel(args.destName)
		if self.Options.SetIconOnFixate then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 244621 then --Прорыв Бездны
		specWarnVoidTear2:Show()
	end
end

function mod:SPELL_DAMAGE(_, _, _, destName, destGUID, _, _, _, spellId)
	if spellId == 244433 then
		if destGUID == UnitGUID("player") then
			specWarnUmbraShift:Show()
			specWarnUmbraShift:Play("teleyou")
			UmbraShift = true
		else
			warnUmbraShift:Show(destName)
		end
	end
end

--[[
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:find("inv_misc_monsterhorn_03") then

	end
end
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 247576 then--Umbra Shift
		--timerUmbraShiftCD:Start()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 122482 then
		self.vb.aberrations = self.vb.aberrations + 1
		if self.vb.aberrations == 10 then
			warnPhase2:Show()
		end
	end
end
