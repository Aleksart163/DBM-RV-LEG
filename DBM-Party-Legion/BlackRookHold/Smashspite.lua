local mod	= DBM:NewMod(1664, "DBM-Party-Legion", 1, 740)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(98949)
mod:SetEncounterID(1834)
mod:SetZone()
mod:SetUsedIcons(8, 7, 3, 2, 1)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 198079",
	"SPELL_AURA_APPLIED 198079 224188 198446",
	"SPELL_AURA_APPLIED_DOSE 224188",
	"SPELL_AURA_REMOVED 198079 224188",
	"SPELL_CAST_START 198073 198245",
	"SPELL_PERIODIC_DAMAGE 198501",
	"SPELL_PERIODIC_MISSED 198501",
	"UNIT_POWER_FREQUENT boss1"
)

--TODO, maye GTFO for fire on ground (and timers and other stuff for it too maybe, seems all over place though).
local warnHatefulGaze				= mod:NewTargetAnnounce(198079, 4) --Ненавидящий взгляд
local warnFelVomit					= mod:NewTargetAnnounce(198446, 3) --Сквернорвота
local warnHatefulCharge				= mod:NewStackAnnounce(224188, 4) --Рывок ненависти

local specWarnHatefulCharge			= mod:NewSpecialWarningStack(224188, nil, 1, nil, nil, 2, 5) --Рывок ненависти
local specWarnFelVomitus			= mod:NewSpecialWarningYouMove(198501, nil, nil, nil, 1, 3) --Рвота Скверны
local specWarnFelVomit				= mod:NewSpecialWarningYouMoveAway(198446, nil, nil, nil, 4, 3) --Сквернорвота
local specWarnStomp					= mod:NewSpecialWarningDefensive(198073, nil, nil, nil, 2, 3) --Сотрясающий землю топот
local specWarnHatefulGaze			= mod:NewSpecialWarningYouDefensive(198079, nil, nil, nil, 3, 5) --Ненавидящий взгляд
local specWarnHatefulGaze2			= mod:NewSpecialWarningYouMoveAway(198079, nil, nil, nil, 4, 3) --Ненавидящий взгляд
local specWarnHatefulGaze3			= mod:NewSpecialWarningCloseMoveAway(198079, nil, nil, nil, 2, 3) --Ненавидящий взгляд
local specWarnBrutalHaymakerSoon	= mod:NewSpecialWarningSoon(198245, "Tank|Healer", nil, nil, 1, 2) --Жестокий удар кулаком Face fuck soon
local specWarnBrutalHaymaker		= mod:NewSpecialWarningDefensive(198245, "Tank", nil, nil, 3, 2) --Жестокий удар кулаком Incoming face fuck

local timerStompCD					= mod:NewCDTimer(17, 198073, nil, nil, nil, 2) --Сотрясающий землю топот +++ Next timers but delayed by other casts
local timerHatefulGazeCD			= mod:NewCDTimer(25.5, 198079, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON..DBM_CORE_MYTHIC_ICON) --Ненавидящий взгляд +++ Next timers but delayed by other casts
local timerHatefulGaze				= mod:NewCastTimer(5, 198079, nil, nil, nil, 7) --Ненавидящий взгляд +++
local timerHatefulCharge			= mod:NewTargetTimer(60, 224188, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Рывок ненависти

local yellHatefulGaze				= mod:NewYell(198079, nil, nil, nil, "YELL") --Ненавидящий взгляд
local yellHatefulGaze2				= mod:NewFadesYell(198079, nil, nil, nil, "YELL") --Ненавидящий взгляд
local yellFelVomit					= mod:NewYell(198446, nil, nil, nil, "YELL") --Сквернорвота
local yellFelVomit2					= mod:NewFadesYell(198446, nil, nil, nil, "YELL") --Сквернорвота

mod:AddSetIconOption("SetIconOnHatefulGaze", 198079, true, false, {8}) --Ненавидящий взгляд
mod:AddSetIconOption("SetIconOnFelVomit", 198446, true, false, {7}) --Сквернорвота
mod:AddSetIconOption("SetIconOnHatefulCharge", 224188, true, false, {3, 2, 1}) --Рывок ненависти
mod:AddInfoFrameOption(198080)

mod.vb.hatefulchargeIcon = 1

local superWarned = false

function mod:OnCombatStart(delay)
	self.vb.hatefulchargeIcon = 1
	if not self:IsNormal() then
		timerHatefulGazeCD:Start(6-delay) --Ненавидящий взгляд
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(198080))
			DBM.InfoFrame:Show(5, "reverseplayerbaddebuffbyspellid", 224188)--Must match spellID to filter other debuffs out
		end
	end
	timerStompCD:Start(12-delay) --Сотрясающий землю топот
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 198079 then --Ненавидящий взгляд
		timerHatefulGazeCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 198079 then --Ненавидящий взгляд
		timerHatefulGaze:Start()
		if args:IsPlayer() then
			specWarnHatefulGaze2:Show()
			specWarnHatefulGaze2:Play("runout")
			specWarnHatefulGaze:Schedule(3)
			specWarnHatefulGaze:ScheduleVoice(3, "defensive")
			yellHatefulGaze:Yell()
			yellHatefulGaze2:Countdown(5, 3)
		elseif self:CheckNearby(10, args.destName) then
			warnHatefulGaze:Show(args.destName)
			specWarnHatefulGaze3:Show(args.destName)
		else
			warnHatefulGaze:Show(args.destName)
		end
		if self.Options.SetIconOnHatefulGaze then
			self:SetIcon(args.destName, 8, 5)
		end
	elseif spellId == 224188 then --Рывок ненависти
		self.vb.hatefulchargeIcon = self.vb.hatefulchargeIcon + 1
		local amount = args.amount or 1
		timerHatefulCharge:Start(args.destName)
		if args:IsPlayer() then
			specWarnHatefulCharge:Show(args.amount)
		else
			warnHatefulCharge:Show(args.destName, amount)
		end
		if self.Options.SetIconOnHatefulCharge then
			self:SetIcon(args.destName, self.vb.hatefulchargeIcon)
		end
	elseif spellId == 198446 then --Сквернорвота
		if args:IsPlayer() then
			specWarnFelVomit:Schedule(4)
			yellFelVomit:Yell()
			yellFelVomit2:Countdown(10, 3)
		else
			warnFelVomit:Show(args.destName)
		end
		if self.Options.SetIconOnFelVomit then
			self:SetIcon(args.destName, 7, 10)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 198079 then --Ненавидящий взгляд
		timerHatefulGaze:Cancel(args.destName)
		if args:IsPlayer() then
			specWarnHatefulGaze:Cancel()
			yellHatefulGaze2:Cancel()
		end
	elseif spellId == 224188 then --Рывок ненависти
		self.vb.hatefulchargeIcon = self.vb.hatefulchargeIcon - 1
		timerHatefulCharge:Cancel(args.destName)
		if self.Options.SetIconOnHatefulCharge then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 198073 then
		specWarnStomp:Show()
		specWarnStomp:Play("carefly")
		if self:IsHard() then
			timerStompCD:Start(25.5)
		else
			timerStompCD:Start()
		end
	elseif spellId == 198245 and not superWarned then--fallback, only 0.7 seconds warning vs 1.2 if power 100 works, but better than naught.
		superWarned = true
		specWarnBrutalHaymaker:Show()
		if self:IsTank() then
			specWarnBrutalHaymaker:Play("defensive")
		else
			specWarnBrutalHaymaker:Play("tankheal")
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 198501 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		if self:IsHard() then
			specWarnFelVomitus:Show()
			specWarnFelVomitus:Play("runaway")
		end
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

do
	local warnedSoon = false
	local UnitPower = UnitPower
	function mod:UNIT_POWER_FREQUENT(uId)
		local power = UnitPower(uId)
		if power >= 85 and not warnedSoon then
			warnedSoon = true
			specWarnBrutalHaymakerSoon:Show()
			specWarnBrutalHaymakerSoon:Play("energyhigh")
		elseif power < 50 and warnedSoon then
			warnedSoon = false
			superWarned = false
		elseif power == 100 and not superWarned then--Doing here is about 0.5 seconds faster than SPELL_CAST_START, when it works.
			superWarned = true
			specWarnBrutalHaymaker:Show()
			if self:IsTank() then
				specWarnBrutalHaymaker:Play("defensive")
			else
				specWarnBrutalHaymaker:Play("tankheal")
			end
		end
	end
end
