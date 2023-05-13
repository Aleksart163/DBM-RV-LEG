local mod	= DBM:NewMod(1835, "DBM-Party-Legion", 11, 860)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
mod:SetCreatureID(114262, 114264)--114264 midnight
mod:SetEncounterID(1960)--Verify
mod:SetZone()
mod:SetUsedIcons(8, 7)
mod:SetReCombatTime(120, 5)
mod:EnableIEEUWipeDetection()
--mod:SetHotfixNoticeRev(14922)
-- mod.respawnTime = 30

mod.noNormal = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 227404 228895",
	"SPELL_AURA_REMOVED 227404",
	"SPELL_CAST_START 227363 227365 227339 227493 228852 227638",
	"SPELL_CAST_SUCCESS 227636",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_HEALTH",
	"VEHICLE_ANGLE_UPDATE"
)

--Ловчий Аттумен https://ru.wowhead.com/npc=114262/ловчий-аттумен/эпохальный-журнал-сражений
local warnPhase						= mod:NewPhaseChangeAnnounce(1)
local warnPhase2					= mod:NewPrePhaseAnnounce(2, 1)

local specWarnMightyStomp			= mod:NewSpecialWarningCast(227363, "SpellCaster", nil, nil, 1, 3) --Могучий топот
local specWarnSpectralCharge		= mod:NewSpecialWarningDodge(227365, nil, nil, nil, 2, 2) --Призрачный рывок
--On Foot
local specWarnMezair				= mod:NewSpecialWarningDodge(227339, nil, nil, nil, 1, 3) --Мезэр
local specWarnMortalStrike			= mod:NewSpecialWarningDefensive(227493, "Tank", nil, nil, 3, 3) --Смертельный удар
local specWarnSharedSuffering		= mod:NewSpecialWarningMoveTo(228852, nil, nil, nil, 3, 5) --Разделенные муки
local specWarnSharedSuffering2		= mod:NewSpecialWarningYouDefensive(228852, nil, nil, nil, 3, 5) --Разделенные муки
local specWarnSharedSuffering3		= mod:NewSpecialWarningRun(228852, "Melee", nil, nil, 3, 5) --Разделенные муки
local specWarnPresence				= mod:NewSpecialWarningYou(227404, nil, nil, nil, 3, 6) --Незримое присутствие
local specWarnPresence2				= mod:NewSpecialWarningYouDispel(227404, nil, nil, nil, 3, 6) --Незримое присутствие
local specWarnPresence3				= mod:NewSpecialWarningDispel(227404, nil, nil, nil, 3, 6) --Незримое присутствие
local specWarnPresence4				= mod:NewSpecialWarningEnd(227404, nil, nil, nil, 1, 2) --Незримое присутствие
local specWarnPresence5				= mod:NewSpecialWarning("Presence", nil, nil, nil, 3, 6) --Незримое присутствие
local specWarnPresence6				= mod:NewSpecialWarningSpell(227404, nil, nil, nil, 1, 2) --Незримое присутствие
local specWarnPresence7				= mod:NewSpecialWarningTarget(227404, nil, nil, nil, 1, 2) --Незримое присутствие
--local specWarnRagnarok				= mod:NewSpecialWarningDefensive(193826, nil, nil, nil, 3, 5) 

local timerSpectralChargeCD			= mod:NewCDTimer(7.5, 227365, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Призрачный рывок
local timerMightyStompCD			= mod:NewCDTimer(14, 227363, nil, nil, nil, 2, nil, DBM_CORE_INTERRUPT_ICON) --Могучий топот +++
local timerPresenceCD				= mod:NewCDTimer(55, 227404, nil, nil, nil, 5, nil, DBM_CORE_HEALER_ICON..DBM_CORE_MAGIC_ICON) --Незримое присутствие
local timerMortalStrikeCD			= mod:NewNextTimer(16, 227493, nil, "Melee", nil, 5, nil, DBM_CORE_TANK_ICON..DBM_CORE_DEADLY_ICON) --Смертельный удар +++
local timerSharedSufferingCD		= mod:NewNextTimer(18, 228852, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON..DBM_CORE_DEADLY_ICON) --Разделенные муки +++

local yellSharedSuffering			= mod:NewYell(228852, L.SharedSufferingYell, nil, nil, "YELL") --Разделенные муки
local yellPresence					= mod:NewYellDispel(227404, nil, nil, nil, "YELL") --Незримое присутствие

local countdownSharedSuffering		= mod:NewCountdown(18, 228852, nil, nil, 5) --Разделенные муки
local countdownSharedSuffering2		= mod:NewCountdownFades("Alt3.8", 228852, nil, nil, 3) --Разделенные муки

mod:AddSetIconOption("SetIconOnPresence", 227404, true, false, {7}) --Незримое присутствие
mod:AddSetIconOption("SetIconOnSharedSuffering", 228852, true, false, {8}) --Разделенные муки

mod.vb.phase = 1
mod.vb.murchalproshlyap = 0
mod.vb.spectralchargeCast = 0
mod.vb.mezairCast = 0
mod.vb.mountedstrikeCast = 0

local sharedSuffering = replaceSpellLinks(228852)
local playerName = UnitName("player")
local perephase = false
local firsttwophase = false
local firstperephase = false
local warned_preP1 = false
local warned_preP2 = false
local warned_preP3 = false
local warned_preP4 = false
local phase2 = false
local intangiblePresenceOnMe = true
local syncEvent = false

--[[
local function UpdateTimers(self)
	timerPresenceCD:Stop() --Незримое присутствие
	timerMightyStompCD:Stop() --Могучий топот
	timerMortalStrikeCD:Start(9.5) --смертельный удар
	timerSharedSufferingCD:Start(18) --Разделенные муки
	countdownSharedSuffering:Start(18) --Разделенные муки
end]]

local function checkSyncEvent(self)
	if not syncEvent then
		if self:IsMagicDispeller2() then
			specWarnPresence5:Show()
			specWarnPresence5:Play("dispelnow")
		elseif not self:IsMagicDispeller2() then
			specWarnPresence6:Show()
		end
	end
end

function mod:OnCombatStart(delay)
	intangiblePresenceOnMe = true
	syncEvent = false
	self.vb.phase = 1
	self.vb.murchalproshlyap = 0
	self.vb.spectralchargeCast = 0
	self.vb.mezairCast = 0
	self.vb.mountedstrikeCast = 0
	perephase = false
	firsttwophase = false
	firstperephase = false
	warned_preP1 = false
	warned_preP2 = false
	warned_preP3 = false
	warned_preP4 = false
	phase2 = false
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
	elseif spellId == 227339 and self:AntiSpam(2, 1) then --Мезэр
		self.vb.mezairCast = self.vb.mezairCast + 1
		if not UnitIsDeadOrGhost("player") then
			specWarnMezair:Show()
			specWarnMezair:Play("chargemove")
		end
--[[		if self.vb.mezairCast == 1 and warned_preP2 and perephase and firstperephase then -- через 3.5 сек как Ловчий спустился
			perephase = false
			self.vb.mountedstrikeCast = 0
			specWarnSpectralCharge:Cancel() --Призрачный рывок
			timerPresenceCD:Stop() --Незримое присутствие
			timerSpectralChargeCD:Stop() --Призрачный рывок
			timerMortalStrikeCD:Start(6) --Смертельный удар
			timerSharedSufferingCD:Start(14.5) --Разделенные муки
			countdownSharedSuffering:Start(14.5) --Разделенные муки
		end]]
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
					self:SetIcon(args.destName, 8, 5)
				end
				break
			end
		end
		if unitIsPlayer then
			yellSharedSuffering:Yell(sharedSuffering, playerName)
			if self:IsNormal() or self:IsHeroic() then
				specWarnSharedSuffering2:Show()
			elseif self:IsHard() then
				specWarnSharedSuffering3:Show()
				specWarnSharedSuffering3:Play("runaway")
			end
		else
			if self:IsNormal() or self:IsHeroic() then
				if not UnitIsDeadOrGhost("player") then
					specWarnSharedSuffering:Show(targetName)
					specWarnSharedSuffering:Play("gathershare")
				end
			elseif self:IsHard() then
				specWarnSharedSuffering3:Show()
				specWarnSharedSuffering3:Play("runaway")
			end
		end
		timerSharedSufferingCD:Start()
		countdownSharedSuffering:Start(18)
		countdownSharedSuffering2:Start()
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 227636 then --Удар всадника (перефаза наступила)
		self.vb.mountedstrikeCast = self.vb.mountedstrikeCast + 1
		if self.vb.mountedstrikeCast == 1 and warned_preP2 and firstperephase and not perephase then
			perephase = true
			self.vb.mezairCast = 0
			timerMortalStrikeCD:Stop() --Смертельный удар
			timerSharedSufferingCD:Stop() --Разделенные муки
			countdownSharedSuffering:Cancel() --Разделенные муки
			specWarnSpectralCharge:Schedule(1) --Призрачный рывок
			specWarnSpectralCharge:ScheduleVoice(1, "watchstep") --Призрачный рывок
			timerPresenceCD:Start(3) --Незримое присутствие
			timerSpectralChargeCD:Schedule(13) --Призрачный рывок
			specWarnSpectralCharge:Schedule(20.5) --Призрачный рывок
			specWarnSpectralCharge:ScheduleVoice(20.5, "watchstep") --Призрачный рывок
		end
	end
end]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 228895 then --Исступление
		self.vb.phase = 3
		warned_preP3 = true
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase))
		timerMightyStompCD:Start()
		countdownSharedSuffering:Cancel()
		timerSharedSufferingCD:Cancel()
		timerMortalStrikeCD:Cancel()
		timerPresenceCD:Cancel()
		if phase2 then
			phase2 = false
		end
	elseif spellId == 227404 then --Незримое присутствие
		if self:AntiSpam(2, "intangiblePresence") then
			self:Schedule(1.5, checkSyncEvent, self)
		end
		timerMortalStrikeCD:Stop() --Смертельный удар
		timerSharedSufferingCD:Stop() --Разделенные муки
		countdownSharedSuffering:Cancel() --Разделенные муки
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 227404 then --Незримое присутствие
		if args:IsPlayer() then
			intangiblePresenceOnMe = true
			specWarnPresence4:Show()
			specWarnPresence4:Play("end")
		end
		if self.Options.SetIconOnPresence then
			self:SetIcon(args.destName, 0)
		end
	end
end

--[[
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
end]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 227404 then --Незримое присутствие
		if self.vb.phase == 1 then
			timerPresenceCD:Start(58)
		else
			timerPresenceCD:Start()
		end
	elseif spellId == 227338 then --Слез с коня (Неоседланная)
	--	timerPresenceCD:Stop()
	--	timerMortalStrikeCD:Start()
	--	timerSharedSufferingCD:Start()
	--	countdownSharedSuffering:Start()
	elseif spellId == 227584 or spellId == 227601 then --Сел на коня (Используется транспорт или Смена фазы)
		timerMortalStrikeCD:Stop()
		timerSharedSufferingCD:Stop()
		countdownSharedSuffering:Cancel()
		timerPresenceCD:Start(2)
	end
end

function mod:UNIT_HEALTH(uId)
	if self:IsHard() then --миф и миф+
		if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 114264 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.61 then --Полночь
			warned_preP1 = true
			warnPhase2:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
		elseif self.vb.phase == 1 and warned_preP1 and not warned_preP2 and self:GetUnitCreatureId(uId) == 114264 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.51 then --Полночь Фаза 2
			self.vb.phase = 2
			warned_preP2 = true
--			firsttwophase = true
			warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase))
			self:NextProshlyap()
		elseif self.vb.phase == 2 and warned_preP2 and not warned_preP3 and self:GetUnitCreatureId(uId) == 114264 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.51 then
			if phase2 then
				self:NextProshlyap()
			end
		end
	else
		if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 114264 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.61 then --Полночь
			warned_preP1 = true
		elseif self.vb.phase == 1 and warned_preP1 and not warned_preP2 and self:GetUnitCreatureId(uId) == 114264 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.51 then --Полночь Фаза 2
			self.vb.phase = 2
			warned_preP2 = true
			warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase))
			self:NextProshlyap()
		elseif self.vb.phase == 2 and warned_preP2 and not warned_preP3 and self:GetUnitCreatureId(uId) == 114264 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.51 then --Полночь Фаза 2
			if phase2 then
				self:NextProshlyap()
			end
		end
	end
end

function mod:NextProshlyap()
--	self.vb.murchalproshlyap = self.vb.murchalproshlyap + 1
--	if self.vb.murchalproshlyap >= 1 then
	timerPresenceCD:Stop() --Незримое присутствие
	timerMightyStompCD:Stop() --Могучий топот
	timerMortalStrikeCD:Start(9.5) --смертельный удар
	timerSharedSufferingCD:Start(18) --Разделенные муки
--	countdownSharedSuffering:Start(18) --Разделенные муки
end


function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Perephase1 then --Спустился с коня (Что ж, сразимся лицом к лицу!)
		if not phase2 then
		--	specWarnRagnarok:Show()
			phase2 = true
		end
--		firsttwophase = true
	elseif msg == L.Perephase2 then --Сел на коня (Вперед, Полночь, к победе!)
		timerMortalStrikeCD:Stop()
		timerSharedSufferingCD:Stop()
		countdownSharedSuffering:Cancel()
	--	specWarnRagnarok:Show()
	--	perephase = false
	--	timerSpectralChargeCD:Stop() --Призрачный рывок
	--	specWarnSpectralCharge:Cancel() --Призрачный рывок
	--	timerPresenceCD:Stop() --Незримое присутствие
	--	timerMortalStrikeCD:Start(9.5) --Смертельный удар
	--	timerSharedSufferingCD:Start(18) --Разделенные муки
	--	countdownSharedSuffering:Start(18) --Разделенные муки
	end
--	if perephase and firstperephase then
--		timerSpectralChargeCD:Start(2) --Призрачный рывок
--		specWarnSpectralCharge:Schedule(2) --Призрачный рывок
--		timerPresenceCD:Start(4) --Незримое присутствие
--		timerSpectralChargeCD:Schedule(14) --Призрачный рывок
--		specWarnSpectralCharge:Schedule(21.5) --Призрачный рывок
--	end
end

function mod:VEHICLE_ANGLE_UPDATE()
	if DBM:UnitDebuff("player", 227404) and intangiblePresenceOnMe then
		intangiblePresenceOnMe = false
		syncEvent = true
		if self.Options.SetIconOnPresence then
			self:SetIcon(playerName, 7)
		end
		self:SendSync("intangiblePresenceOnMe", playerName)
		if self:IsMagicDispeller2() then
			specWarnPresence2:Show()
			specWarnPresence2:Play("dispelnow")
			yellPresence:Yell()
		elseif not self:IsMagicDispeller2() then
			specWarnPresence:Show()
			specWarnPresence:Play("targetyou")
			yellPresence:Yell()
		end
	end
end

function mod:OnSync(msg, sender)
	if msg == "intangiblePresenceOnMe" and sender ~= playerName then
		syncEvent = true
		if self.Options.SetIconOnPresence then
			self:SetIcon(sender, 7)
		end
		if self:IsMagicDispeller2() then
			specWarnPresence3:Show(sender)
			specWarnPresence3:Play("dispelnow")
		elseif not self:IsMagicDispeller2() then
			specWarnPresence7:Show(sender)
		end
	end
end
