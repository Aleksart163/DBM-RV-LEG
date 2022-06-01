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
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_DIED",
	"UNIT_HEALTH boss1"
)

--TODO: Intangible Presence doesn't seem possible to support. How to tell right from wrong dispel is obfuscated
--Most of midnights timers are too short to really be worth including. he either spams charge or spams spectral chargers.
local warnPhase						= mod:NewAnnounce("Phase", 1, "Interface\\Icons\\Spell_Nature_WispSplode") --Скоро фаза 2
local warnPhase1					= mod:NewAnnounce("Phase1", 1, 228852) --Фаза 2
local warnPhase2					= mod:NewAnnounce("Phase2", 1, "Interface\\Icons\\Spell_Nature_WispSplode") --Скоро фаза 3
local warnPhase3					= mod:NewAnnounce("Phase3", 1, 227363) --Фаза 3
local warnEnrage					= mod:NewTargetAnnounce(228895, 4) --Исступление

local specWarnMightyStomp			= mod:NewSpecialWarningCast(227363, "SpellCaster", nil, nil, 1, 3) --Могучий топот
local specWarnSpectralCharge		= mod:NewSpecialWarningDodge(227365, nil, nil, nil, 2, 2) --Призрачный рывок
--On Foot
local specWarnMezair				= mod:NewSpecialWarningDodge(227339, nil, nil, nil, 2, 3) --Мезэр
local specWarnMortalStrike			= mod:NewSpecialWarningDefensive(227493, "Tank", nil, nil, 3, 3) --Смертельный удар
local specWarnSharedSuffering		= mod:NewSpecialWarningMoveTo(228852, nil, nil, nil, 3, 5) --Разделенные муки
local specWarnSharedSuffering2		= mod:NewSpecialWarningYouDefensive(228852, nil, nil, nil, 3, 5) --Разделенные муки
local specWarnSharedSuffering3		= mod:NewSpecialWarningRun(228852, "Melee", nil, nil, 3, 5) --Разделенные муки

local timerSpectralChargeCD			= mod:NewCDTimer(7.5, 227365, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Призрачный рывок
local timerMightyStompCD			= mod:NewCDTimer(14, 227363, nil, nil, nil, 2, nil, DBM_CORE_INTERRUPT_ICON) --Могучий топот +++
local timerPresenceCD				= mod:NewCDTimer(55, 227404, nil, "MagicDispeller2", nil, 5, nil, DBM_CORE_HEALER_ICON..DBM_CORE_MAGIC_ICON) --Незримое присутствие
local timerMortalStrikeCD			= mod:NewNextTimer(16, 227493, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON) --Смертельный удар +++
local timerSharedSufferingCD		= mod:NewNextTimer(18, 228852, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON..DBM_CORE_DEADLY_ICON) --Разделенные муки +++

local yellSharedSuffering			= mod:NewYell(228852, nil, nil, nil, "YELL") --Разделенные муки

local countdownSharedSuffering		= mod:NewCountdown(18, 228852, "Melee", nil, 5) --Разделенные муки

mod:AddSetIconOption("SetIconOnSharedSuffering", 228852, true, false, {8}) --Разделенные муки

mod.vb.phase = 1
mod.vb.spectralchargeCast = 0

local perephase = false
local firstperephase = false
local warned_preP1 = false
local warned_preP2 = false
local warned_preP3 = false
local warned_preP4 = false

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.spectralchargeCast = 0
	perephase = false
	firstperephase = false
	warned_preP1 = false
	warned_preP2 = false
	warned_preP3 = false
	warned_preP4 = false
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
	elseif spellId == 227365 then --Призрачный рывок
		self.vb.spectralchargeCast = self.vb.spectralchargeCast + 1
		specWarnSpectralCharge:Show()
		specWarnSpectralCharge:Play("watchstep")
--[[		if self.vb.spectralchargeCast == 1 then
			timerSpectralChargeCD:Start(7.5)
		elseif self.vb.spectralchargeCast == 2 then
			timerSpectralChargeCD:Start(13)
		elseif self.vb.spectralchargeCast == 3 then
			self.vb.spectralchargeCast = 0
		end]]
	elseif spellId == 227339 and self:AntiSpam(2, 1) then
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
		warnEnrage:Show(args.destName)
		self.vb.phase = 3
		warned_preP4 = true
		warnPhase3:Schedule(3) --фаза 3
		timerMightyStompCD:Start()
		countdownSharedSuffering:Cancel()
		timerSharedSufferingCD:Cancel()
		timerMortalStrikeCD:Cancel()
		timerPresenceCD:Cancel()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 227338 then --Слез с коня (Неоседланная)
		timerPresenceCD:Stop()
		timerMortalStrikeCD:Start(9.5)
		timerSharedSufferingCD:Start(18)
		countdownSharedSuffering:Start(18)
	elseif spellId == 227584 or spellId == 227601 then --Сел на коня (Используется транспорт или Смена фазы)
		timerMortalStrikeCD:Stop()
		timerSharedSufferingCD:Stop()
		countdownSharedSuffering:Cancel()
		timerPresenceCD:Start(2)
		specWarnSpectralCharge:Schedule(2)
		timerSpectralChargeCD:Start(2)
		timerSpectralChargeCD:Schedule(14.5)
	elseif spellId == 227404 then --Незримое присутствие
		if self.vb.phase == 1 then
			timerPresenceCD:Start(58)
		else
			timerPresenceCD:Start()
		end
	end
end

function mod:UNIT_HEALTH(uId)
	if self:IsHard() then --миф и миф+
		if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 114264 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.61 then --Полночь
			warned_preP1 = true
			warnPhase:Show()
		elseif self.vb.phase == 1 and warned_preP1 and not warned_preP2 and self:GetUnitCreatureId(uId) == 114264 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.51 then --Полночь Фаза 2
			self.vb.phase = 2
			warned_preP2 = true
			warnPhase1:Show() --фаза 2
			timerMortalStrikeCD:Start(9.5) --смертельный удар
			timerSharedSufferingCD:Start(18) --Разделенные муки
			countdownSharedSuffering:Start(18) --Разделенные муки
		elseif self.vb.phase == 2 and warned_preP2 and not warned_preP3 and self:GetUnitCreatureId(uId) == 114262 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.10 then --Ловчий Начало фазы 3
			warned_preP3 = true
			warnPhase2:Show()
		end
	else
		if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 114264 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.61 then --Полночь
			warned_preP1 = true
		elseif self.vb.phase == 1 and warned_preP1 and not warned_preP2 and self:GetUnitCreatureId(uId) == 114264 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.51 then --Полночь Фаза 2
			self.vb.phase = 2
			warned_preP2 = true
			warnPhase1:Show() --фаза 2
			timerMortalStrikeCD:Start(9.5) --смертельный удар
			timerSharedSufferingCD:Start(18) --Разделенные муки
			countdownSharedSuffering:Start(18) --Разделенные муки
		elseif self.vb.phase == 2 and warned_preP2 and not warned_preP3 and self:GetUnitCreatureId(uId) == 114262 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.10 then --Ловчий Начало фазы 3
			warned_preP3 = true
		end
	end
end
--[[
function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Perephase1 or msg:find(L.Perephase1) then --Сел на коня (Вперед, Полночь, к победе!)
		perephase = true
		if not firstperephase then
			firstperephase = true
		end
		timerMortalStrikeCD:Cancel()
		timerSharedSufferingCD:Cancel()
	elseif msg == L.Perephase2 or msg:find(L.Perephase2) then --Спустился с коня (Что ж, сразимся лицом к лицу!)
		perephase = false
		timerMortalStrikeCD:Start(9.5)
		timerSharedSufferingCD:Start(18)
		countdownSharedSuffering:Start(18)
	end
	if perephase and firstperephase then
		timerSpectralChargeCD:Start(4.5)
		timerPresenceCD:Start(15.5) --отличное кд
	end
end
]]
