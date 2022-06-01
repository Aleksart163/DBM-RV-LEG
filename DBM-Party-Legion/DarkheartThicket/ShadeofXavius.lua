local mod	= DBM:NewMod(1657, "DBM-Party-Legion", 2, 762)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(99192)
mod:SetEncounterID(1839)
mod:SetZone()
mod:SetUsedIcons(8, 7, 2, 1)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 200182 200243 200289 200238",
	"SPELL_AURA_REFRESH 200243",
	"SPELL_AURA_REMOVED 200243 200359",
	"SPELL_CAST_SUCCESS 200359 199837 200182 200238",
	"UNIT_SPELLCAST_SUCCEEDED boss1",
	"UNIT_HEALTH boss1"
)

--TOOD, maybe play gathershare for ALL (except tank) for nightmare target.
--TODO, maybe add an arrow group up hud for nightmare target depending on number of players it takes to clear it.
--TODO, feed on the weak have any significance?
local warnApocNightmare				= mod:NewSpellAnnounce(200050, 4) --Апокалиптический Кошмар
local warnApocNightmare2			= mod:NewSoonAnnounce(200050, 1) --Апокалиптический Кошмар
local warnNightmare					= mod:NewTargetAnnounce(200243, 3) --Кошмар наяву
local warnParanoia					= mod:NewTargetAnnounce(200289, 3) --Усугубляющаяся паранойя
local warnFeedontheWeak				= mod:NewTargetAnnounce(200238, 4) --Пожирание слабых

local specWarnApocNightmare2		= mod:NewSpecialWarningDefensive(200050, nil, nil, nil, 3, 5) --Апокалиптический Кошмар
local specWarnFeedontheWeak			= mod:NewSpecialWarningYouDefensive(200238, nil, nil, nil, 3, 5) --Пожирание слабых
local specWarnFesteringRip			= mod:NewSpecialWarningDispel(200182, "MagicDispeller2", nil, nil, 1, 2) --Гноящаяся рана
local specWarnNightmare				= mod:NewSpecialWarningYouShare(200243, nil, nil, nil, 3, 3) --Кошмар наяву
local specWarnParanoia				= mod:NewSpecialWarningMoveAway(200289, nil, nil, nil, 3, 5) --Усугубляющаяся паранойя
local specWarnParanoia2				= mod:NewSpecialWarningCloseMoveAway(200289, nil, nil, nil, 1, 3) --Усугубляющаяся паранойя

local timerFeedontheWeakCD			= mod:NewCDTimer(20, 200238, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Пожирание слабых
local timerFesteringRipCD			= mod:NewCDTimer(17, 200182, nil, "Tank|MagicDispeller2", nil, 5, nil, DBM_CORE_MAGIC_ICON) --Гноящаяся рана 17-21
local timerNightmareCD				= mod:NewCDTimer(17, 200243, nil, nil, nil, 3) --Кошмар наяву 17-25
local timerNightmare				= mod:NewTargetTimer(20, 200243, nil, nil, nil, 7) --Кошмар наяву
local timerParanoiaCD				= mod:NewCDTimer(18, 200359, nil, nil, nil, 3) --Искусственная паранойя 18-28
local timerParanoia					= mod:NewTargetTimer(20, 200359, nil, nil, nil, 7) --Искусственная паранойя

local yellFeedontheWeak				= mod:NewYell(200238, nil, nil, nil, "YELL") --Пожирание слабых
local yellNightmare					= mod:NewYell(200243, nil, nil, nil, "YELL") --Кошмар наяву
local yellParanoia					= mod:NewYell(200289, nil, nil, nil, "YELL") --Усугубляющаяся паранойя

mod:AddSetIconOption("SetIconOnFeedontheWeak", 200238, true, false, {8}) --Пожирание слабых
mod:AddSetIconOption("SetIconOnParanoia", 200289, true, false, {7}) --Усугубляющаяся паранойя
mod:AddSetIconOption("SetIconOnNightmare", 200243, true, false, {2, 1}) --Кошмар наяву

mod.vb.nightmareIcon = 1

mod.vb.phase = 1
local warned_preP1 = false
local warned_preP2 = false

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	warned_preP1 = false
	warned_preP2 = false
	self.vb.nightmareIcon = 1
	timerFesteringRipCD:Start(3.4-delay)
	timerNightmareCD:Start(11-delay)
	timerFeedontheWeakCD:Start(15-delay)
	--Feed on weak, 15
	timerParanoiaCD:Start(26-delay)
	--timerApocNightmareCD:Start(37)--Still needs more data to determine if CD or health based
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 200359 then
		timerParanoiaCD:Start()
	elseif spellId == 200182 then
		timerFesteringRipCD:Start()
	elseif spellId == 200238 then --Пожирание слабых
		timerFeedontheWeakCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 200182 then
		if self:IsHard() then
			specWarnFesteringRip:Show(args.destName)
		end
	elseif spellId == 200243 then
		self.vb.nightmareIcon = self.vb.nightmareIcon + 1
		timerNightmare:Start(args.destName)
		if args:IsPlayer() then
			specWarnNightmare:Show()
			specWarnNightmare:Play("gathershare")
			yellNightmare:Yell()
		else
			warnNightmare:Show(args.destName)
		end
		if self.Options.SetIconOnNightmare then
			self:SetIcon(args.destName, self.vb.nightmareIcon)
		end
		--Alternate Icons
		if self.vb.nightmareIcon == 1 then
			self.vb.nightmareIcon = 2
		else
			self.vb.nightmareIcon = 1
		end
	elseif spellId == 200289 then
		timerParanoia:Start(args.destName)
		if args:IsPlayer() then
			specWarnParanoia:Show()
			specWarnParanoia:Play("runaway")
			yellParanoia:Yell()
		elseif self:CheckNearby(10, args.destName) then
			warnParanoia:Show(args.destName)
			specWarnParanoia2:Show(args.destName)
		else
			warnParanoia:Show(args.destName)
		end
		if self.Options.SetIconOnParanoia then
			self:SetIcon(args.destName, 7)
		end
	elseif spellId == 200238 then
		if args:IsPlayer() then
			specWarnFeedontheWeak:Show()
			specWarnFeedontheWeak:Play("defensive")
			yellFeedontheWeak:Yell()
		else
			warnFeedontheWeak:Show(args.destName)
		end
		if self.Options.SetIconOnFeedontheWeak then
			self:SetIcon(args.destName, 8, 5)
		end
	end
end
mod.SPELL_AURA_REFRESH = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 200243 then
		self.vb.nightmareIcon = self.vb.nightmareIcon - 1
		if self.Options.SetIconOnNightmare then
			self:SetIcon(args.destName, 0)
		end
		timerNightmare:Cancel(args.destName)
	elseif spellId == 200289 then
		timerParanoia:Cancel(args.destName)
		if self.Options.SetIconOnParanoia then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 204808 then--Because cast is hidden from combat log, and debuff may miss (AMS or the like)
		timerNightmareCD:Start()
	elseif spellId == 200050 then--Apocalyptic Nightmare
		warnApocNightmare:Show()
	end
end

function mod:UNIT_HEALTH(uId)
	if self:IsHard() then --миф и миф+
		if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 99192 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.61 then
			warned_preP1 = true
			warnApocNightmare2:Show()
		elseif self.vb.phase == 1 and warned_preP1 and not warned_preP2 and self:GetUnitCreatureId(uId) == 99192 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.51 then
			self.vb.phase = 2
			warned_preP2 = true
			specWarnApocNightmare2:Show()
		end
	else
		if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 99192 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.61 then
			warned_preP1 = true
		elseif self.vb.phase == 1 and warned_preP1 and not warned_preP2 and self:GetUnitCreatureId(uId) == 99192 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.51 then
			self.vb.phase = 2
			warned_preP2 = true
			specWarnApocNightmare2:Show()
		end
	end
end
