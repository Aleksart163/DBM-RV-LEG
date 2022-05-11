local mod	= DBM:NewMod(1835, "DBM-Party-Legion", 11, 860)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(114262, 114264)--114264 midnight
mod:SetEncounterID(1960)--Verify
mod:SetZone()
mod:SetUsedIcons(8)
--mod:SetHotfixNoticeRev(14922)
--mod.respawnTime = 30

mod.noNormal = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 227404 228895",
	"SPELL_AURA_REMOVED 227404",
	"SPELL_CAST_START 227363 227365 227339 227493 228852 227638",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2",
	"UNIT_DIED",
	"UNIT_HEALTH boss1"
)

--TODO: Intangible Presence doesn't seem possible to support. How to tell right from wrong dispel is obfuscated
--Most of midnights timers are too short to really be worth including. he either spams charge or spams spectral chargers.
local warnPhase						= mod:NewAnnounce("Phase1", 1, "Interface\\Icons\\Spell_Nature_WispSplode") --Скоро фаза 2
local warnPhase2					= mod:NewAnnounce("Phase2", 1, 228852) --Фаза 2
local warnPhase3					= mod:NewAnnounce("Phase3", 1, 227363) --Фаза 3
local warnEnrage					= mod:NewSpellAnnounce(228895, 4) --Исступление

local specWarnMightyStomp			= mod:NewSpecialWarningCast(227363, "SpellCaster", nil, nil, 1, 3) --Могучий топот
local specWarnSpectralCharge		= mod:NewSpecialWarningDodge(227365, nil, nil, nil, 2, 2) --Призрачный рывок
--On Foot
local specWarnMezair				= mod:NewSpecialWarningDodge(227339, nil, nil, nil, 2, 3) --Мезэр
local specWarnMortalStrike			= mod:NewSpecialWarningDefensive(227493, "Tank", nil, nil, 3, 3) --Смертельный удар
local specWarnSharedSuffering		= mod:NewSpecialWarningMoveTo(228852, nil, nil, nil, 3, 5) --Разделенные муки
local specWarnSharedSuffering2		= mod:NewSpecialWarningYouDefensive(228852, nil, nil, nil, 3, 5) --Разделенные муки
local specWarnSharedSuffering3		= mod:NewSpecialWarningRun(228852, "Melee", nil, nil, 3, 5) --Разделенные муки

local timerMightyStompCD			= mod:NewCDTimer(14, 227363, nil, "SpellCaster", nil, 2, nil, DBM_CORE_INTERRUPT_ICON) --Могучий топот +++
local timerPresenceCD				= mod:NewAITimer(11, 227404, nil, "Healer", nil, 5, nil, DBM_CORE_HEALER_ICON..DBM_CORE_MAGIC_ICON) --Незримое присутствие
local timerMortalStrikeCD			= mod:NewNextTimer(16, 227493, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON) --Смертельный удар +++
local timerSharedSufferingCD		= mod:NewNextTimer(18, 228852, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON..DBM_CORE_DEADLY_ICON) --Разделенные муки +++

local yellSharedSuffering			= mod:NewYell(228852, nil, nil, nil, "YELL") --Разделенные муки

local countdownSharedSuffering		= mod:NewCountdown(18, 228852, "Tank") --Разделенные муки

mod:AddSetIconOption("SetIconOnSharedSuffering", 228852, true, false, {8}) --Разделенные муки

mod.vb.phase = 1
local warned_preP1 = false
local warned_preP2 = false
local warned_preP3 = false

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	warned_preP1 = false
	warned_preP2 = false
	warned_preP3 = false
	timerMightyStompCD:Start(14-delay) --Могучий топот
	timerPresenceCD:Start(6-delay) --Незримое присутствие
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 227363 then
		specWarnMightyStomp:Show()
		specWarnMightyStomp:Play("stopcast")
		if self.vb.phase == 1 then
			timerMightyStompCD:Start()
		elseif self.vb.phase == 3 then
			timerMightyStompCD:Start()
		end
	elseif spellId == 227365 then
		specWarnSpectralCharge:Show()
		specWarnSpectralCharge:Play("watchstep")
	elseif spellId == 227339 then
		specWarnMezair:Show()
		specWarnMezair:Play("chargemove")
	elseif spellId == 227493 then
		specWarnMortalStrike:Show()
		specWarnMortalStrike:Play("defensive")
	elseif spellId == 228852 then --Разделенные муки
		local targetName = TANK
		local unitIsPlayer = false
		for uId in DBM:GetGroupMembers() do
			if self:IsTanking(uId) then
				targetName = UnitName(uId)
				if UnitIsUnit("player", uId) then
					unitIsPlayer = true
				end
				if self.Options.SetIconOnSharedSuffering then
					self:SetIcon(args.destName, 8, 4)
				end
				break
			end
		end
		if unitIsPlayer then
			yellSharedSuffering:Yell()
			if self:IsNormal() or self:IsHeroic() then
				specWarnSharedSuffering2:Show()
			elseif self:IsHard() then
				specWarnSharedSuffering3:Show()
			end
		else
			if self:IsNormal() or self:IsHeroic() then
				specWarnSharedSuffering:Show(targetName)
				specWarnSharedSuffering:Play("gathershare")
			elseif self:IsHard() then
				specWarnSharedSuffering3:Show()
			end
		end
		timerSharedSufferingCD:Start()
		countdownSharedSuffering:Start(18)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 228895 then --Исступление
		warnEnrage:Schedule(3)
		self.vb.phase = 3
		warned_preP3 = true
		warnPhase3:Show() --фаза 3
		timerMightyStompCD:Start()
		countdownSharedSuffering:Cancel()
		timerSharedSufferingCD:Cancel()
		timerMortalStrikeCD:Cancel()
		timerPresenceCD:Cancel()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 227338 then--Riderless
		timerPresenceCD:Stop()
		timerMortalStrikeCD:Start()
	--	timerSharedSufferingCD:Start()
		countdownSharedSuffering:Start()
	elseif spellId == 227584 or spellId == 227601 then--Mounted or Intermission
		timerMortalStrikeCD:Stop()
	--	timerSharedSufferingCD:Stop()
		countdownSharedSuffering:Cancel()
		timerPresenceCD:Start(2)
	elseif spellId == 227404 then--Intangible Presence
		timerPresenceCD:Start()
	end
end

function mod:UNIT_HEALTH(uId)
	if self:IsHard() then --миф и миф+
		if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 114264 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.56 then --Полночь
			warned_preP1 = true
			warnPhase:Show()
		elseif self.vb.phase == 1 and warned_preP1 and not warned_preP2 and self:GetUnitCreatureId(uId) == 114264 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.51 then
			self.vb.phase = 2
			warned_preP2 = true
			warnPhase2:Show() --фаза 2
			timerMortalStrikeCD:Start(9.5) --смертельный удар
			timerSharedSufferingCD:Start(18) --Разделенные муки
			countdownSharedSuffering:Start(18) --Разделенные муки
		end
	else
		if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 114264 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.56 then --Полночь
			warned_preP1 = true
		--	warnPhase:Show()
		elseif self.vb.phase == 1 and warned_preP1 and not warned_preP2 and self:GetUnitCreatureId(uId) == 114264 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.51 then
			self.vb.phase = 2
			warned_preP2 = true
			warnPhase2:Show() --фаза 2
			timerMortalStrikeCD:Start(9.5) --смертельный удар
			timerSharedSufferingCD:Start(18) --Разделенные муки
			countdownSharedSuffering:Start(18) --Разделенные муки
		end
	end
end

--[[function mod:UNIT_DIED(args)
	if self:GetCIDFromGUID(args.destGUID) == 114262 then --Ловчий Аттумен
		self.vb.phase = 3
		warned_preP3 = true
		warnPhase3:Show()
		timerMightyStompCD:Start()
		countdownSharedSuffering:Cancel()
		timerSharedSufferingCD:Cancel()
		timerMortalStrikeCD:Cancel()
		timerPresenceCD:Cancel()
	end
end]]
