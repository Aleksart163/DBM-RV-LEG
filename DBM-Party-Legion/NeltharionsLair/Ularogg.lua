local mod	= DBM:NewMod(1665, "DBM-Party-Legion", 5, 767)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(91004)
mod:SetEncounterID(1791)
mod:SetZone()
mod:SetHotfixNoticeRev(15186)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 198496 216290 193375 198428",
	"SPELL_CAST_SUCCESS 216290 198428",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

local warnBellowofDeeps				= mod:NewSpellAnnounce(193375, 2) --Рев глубин Change to special warning if they become important enough to switch to
local warnStanceofMountain			= mod:NewSpellAnnounce(198564, 2) --Горная стойка
local warnStanceofMountain2			= mod:NewSoonAnnounce(198564, 1) --Горная стойка

local specWarnSunder				= mod:NewSpecialWarningYouDefensive(198496, "Tank", nil, 2, 3, 2) --Раскол
local specWarnStrikeofMountain		= mod:NewSpecialWarningDodge(198428, nil, nil, nil, 2, 2) --Удар горы

local timerSunderCD					= mod:NewCDTimer(8.4, 198496, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON) --Раскол +++
local timerStrikeCD					= mod:NewCDTimer(17.5, 198428, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Удар горы
local timerStanceOfMountainCD		= mod:NewCDTimer(51, 198564, nil, nil, nil, 7) --Горная стойка

local countdownStanceOfMountain		= mod:NewCountdown(51, 198564, nil, nil, 5) --Горная стойка

mod.vb.totemsAlive = 0
mod.vb.stanceofmountainCast = 0

function mod:OnCombatStart(delay)
	self.vb.stanceofmountainCast = 0
	if not self:IsNormal() then
		timerSunderCD:Start(7-delay) --Раскол +++
		timerStrikeCD:Start(20.5-delay) --Удар горы +++
		timerStanceOfMountainCD:Start(31-delay) --Горная стойка +++
		countdownStanceOfMountain:Start(31-delay) --Горная стойка +++
		warnStanceofMountain2:Schedule(26-delay) --Горная стойка +++
	else
		timerSunderCD:Start(7-delay) --Раскол
		timerStrikeCD:Start(20.5-delay) --Удар горы
		timerStanceOfMountainCD:Start(31-delay) --Горная стойка +++
		countdownStanceOfMountain:Start(31-delay) --Горная стойка +++
		warnStanceofMountain2:Schedule(26-delay) --Горная стойка +++
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 198496 then --Раскол
		specWarnSunder:Show()
		specWarnSunder:Play("defensive")
		timerSunderCD:Start()
	elseif spellId == 198428 then --Удар горы
		timerStrikeCD:Start()
	elseif spellId == 193375 then --Рев глубин
		warnBellowofDeeps:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 198428 then --Удар горы
		specWarnStrikeofMountain:Show()
		specWarnStrikeofMountain:Play("targetyou")
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 198509 then --Горная стойка
		self.vb.stanceofmountainCast = self.vb.stanceofmountainCast + 1
		if self:IsNormal() then
			self.vb.totemsAlive = 3
		else
			self.vb.totemsAlive = 5
		end
		warnStanceofMountain:Show()
		timerSunderCD:Stop()
		timerStrikeCD:Stop()
		timerStanceOfMountainCD:Stop()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 100818 then
		self.vb.totemsAlive = self.vb.totemsAlive - 1
		if self.vb.totemsAlive == 0 then
			if self.vb.stanceofmountainCast == 1 then
				if self:IsHard() then
					warnStanceofMountain2:Schedule(46)
					timerStanceOfMountainCD:Start(51)
					countdownStanceOfMountain:Start(51)
					timerStrikeCD:Start(5)
					timerSunderCD:Start(10)
				else
					warnStanceofMountain2:Schedule(46)
					timerStanceOfMountainCD:Start(51)
					countdownStanceOfMountain:Start(51)
					timerStrikeCD:Start(5)
					timerSunderCD:Start(10)
				end
			elseif self.vb.stanceofmountainCast == 2 then
				if self:IsHard() then
					warnStanceofMountain2:Schedule(46)
					timerStanceOfMountainCD:Start(51)
					countdownStanceOfMountain:Start(51)
					timerStrikeCD:Start(11)
					timerSunderCD:Start(6)
				else
					warnStanceofMountain2:Schedule(46)
					timerStanceOfMountainCD:Start(51)
					countdownStanceOfMountain:Start(51)
					timerStrikeCD:Start(11)
					timerSunderCD:Start(6)
				end
			elseif self.vb.stanceofmountainCast == 3 then
				if self:IsHard() then
					warnStanceofMountain2:Schedule(46)
					timerStanceOfMountainCD:Start(51)
					countdownStanceOfMountain:Start(51)
					timerStrikeCD:Start(18.5)
					timerSunderCD:Start(3)
				else
					warnStanceofMountain2:Schedule(46)
					timerStanceOfMountainCD:Start(51)
					countdownStanceOfMountain:Start(51)
					timerStrikeCD:Start(18.5)
					timerSunderCD:Start(3)
				end
			end
		end
	end
end
