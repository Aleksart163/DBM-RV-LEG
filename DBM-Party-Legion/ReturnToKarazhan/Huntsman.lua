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
	"SPELL_AURA_APPLIED 227404 228895 227493",
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
local specWarnMortalStrike			= mod:NewSpecialWarningDodge(227493, "Tank", nil, nil, 3, 6) --Смертельный удар
local specWarnMortalStrike2			= mod:NewSpecialWarningYouDefensive(227493, nil, nil, nil, 5, 6) --Смертельный удар
local specWarnSharedSuffering		= mod:NewSpecialWarningMoveTo(228852, nil, nil, nil, 3, 6) --Разделенные муки
local specWarnSharedSuffering2		= mod:NewSpecialWarningYouDefensive(228852, nil, nil, nil, 5, 6) --Разделенные муки
local specWarnSharedSuffering3		= mod:NewSpecialWarningRun(228852, nil, nil, nil, 3, 6) --Разделенные муки
local specWarnSharedSuffering4		= mod:NewSpecialWarningTargetDodge(228852, nil, nil, nil, 2, 5) --Разделенные муки
local specWarnPresence				= mod:NewSpecialWarningYou(227404, nil, nil, nil, 3, 6) --Незримое присутствие
local specWarnPresence2				= mod:NewSpecialWarningYouDispel(227404, nil, nil, nil, 3, 6) --Незримое присутствие
local specWarnPresence3				= mod:NewSpecialWarningDispel(227404, nil, nil, nil, 3, 6) --Незримое присутствие
local specWarnPresence4				= mod:NewSpecialWarningEnd(227404, nil, nil, nil, 1, 2) --Незримое присутствие
local specWarnPresence5				= mod:NewSpecialWarning("Presence", nil, nil, nil, 3, 6) --Незримое присутствие
local specWarnPresence6				= mod:NewSpecialWarningSpell(227404, nil, nil, nil, 1, 2) --Незримое присутствие
local specWarnPresence7				= mod:NewSpecialWarningTarget(227404, nil, nil, nil, 1, 2) --Незримое присутствие
--local specWarnRagnarok				= mod:NewSpecialWarningDefensive(193826, nil, nil, nil, 3, 5) 

local timerHorsefightingCD			= mod:NewCDTimer(26, "ej14300", nil, nil, nil, 6, 227339) --Бой верхом
local timerSpectralChargeCD			= mod:NewCDTimer(7.5, 227365, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Призрачный рывок
local timerMightyStompCD			= mod:NewCDTimer(14, 227363, nil, nil, nil, 2, nil, DBM_CORE_INTERRUPT_ICON) --Могучий топот +++
local timerPresenceCD				= mod:NewCDTimer(55, 227404, nil, nil, nil, 5, nil, DBM_CORE_HEALER_ICON..DBM_CORE_MAGIC_ICON) --Незримое присутствие
local timerMortalStrikeCD			= mod:NewNextTimer(16, 227493, nil, "Melee", nil, 5, nil, DBM_CORE_TANK_ICON..DBM_CORE_DEADLY_ICON) --Смертельный удар +++
local timerSharedSufferingCD		= mod:NewNextTimer(18, 228852, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON..DBM_CORE_DEADLY_ICON) --Разделенные муки +++
local timerMortalStrike				= mod:NewBuffActiveTimer(10, 227493, nil, nil, nil, 7) --Смертельный удар

local yellSharedSuffering			= mod:NewYellMoveAway(228852, nil, nil, nil, "YELL") --Разделенные муки
local yellMortalStrike				= mod:NewYell(227493, nil, nil, nil, "YELL") --Смертельный удар
--local yellPresence					= mod:NewYellDispel(227404, nil, nil, nil, "YELL") --Незримое присутствие

local countdownSharedSuffering		= mod:NewCountdown(18, 228852, nil, nil, 5) --Разделенные муки
local countdownSharedSuffering2		= mod:NewCountdownFades("Alt3.8", 228852, nil, nil, 3) --Разделенные муки
local countdownHorsefighting		= mod:NewCountdown("Alt26.5", "ej14300", nil, nil, 5) --Бой верхом

mod:AddSetIconOption("SetIconOnSharedSuffering", 228852, true, false, {8}) --Разделенные муки
mod:AddSetIconOption("SetIconOnPresence", 227404, true, false, {7}) --Незримое присутствие

mod.vb.phase = 1
mod.vb.murchalproshlyap = 0
mod.vb.spectralchargeCast = 0
mod.vb.mezairCast = 0
mod.vb.mountedstrikeCast = 0

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
local syncEvent = true
-- local runtime = 0 -- debug
--[[
local proshlyap = DBM:GetSpellInfo(227404)

local function startAnalProshlyapation(self)
	smartChat(L.ProshlyapAnala:format(proshlyap), "say")
end]]

function mod:SharedSufferingTarget(targetname, uId) --прошляпанное очко Мурчаля Прошляпенко [✔]
	if not targetname then return end
	if targetname == UnitName("player") then --для танка
		if self:IsHeroic() then
			specWarnSharedSuffering2:Show()
			specWarnSharedSuffering2:Play("defensive")
			yellSharedSuffering:Yell()
		else
			specWarnSharedSuffering3:Show()
			specWarnSharedSuffering3:Play("runaway")
			yellSharedSuffering:Yell()
		end
	else --для очка Мурчаля
		if self:IsHeroic() then
			specWarnSharedSuffering:Show(targetName)
			specWarnSharedSuffering:Play("gathershare")
		else
			if not UnitIsDeadOrGhost("player") then
				specWarnSharedSuffering4:Show(targetname)
				specWarnSharedSuffering4:Play("stilldanger")
			end
		end
	end
	if self.Options.SetIconOnSharedSuffering then
		self:SetIcon(targetname, 8, 5)
	end
end

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
		syncEvent = true
		--[[local currenttime = GetTime()
		DBM:Debug("checkSyncEvent: syncEvent = true, GetTime(): " .. currenttime .. ", spenttime: " .. currenttime - runtime)]]
		DBM:AddMsg(L.Tip1)
		if self:IsMagicDispeller2() then
			specWarnPresence5:Show()
			specWarnPresence5:Play("dispelnow")
		elseif not self:IsMagicDispeller2() then
			specWarnPresence6:Show()
			specWarnPresence6:Play("ghostsoon")
		end
	end
end

function mod:OnCombatStart(delay)
	intangiblePresenceOnMe = true
	syncEvent = true
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

function mod:OnCombatEnd()
	DBM:AddMsg(L.Tip2)
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
		specWarnMortalStrike:Play("stilldanger")
	elseif spellId == 228852 then --Разделенные муки
		self:BossTargetScanner(args.sourceGUID, "SharedSufferingTarget", 0.1, 2)
		timerSharedSufferingCD:Start()
		countdownSharedSuffering:Start(18)
		countdownSharedSuffering2:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 228895 then --Исступление
		self.vb.phase = 3
		warned_preP3 = true
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase))
		timerMightyStompCD:Start()
		countdownSharedSuffering:Cancel()
		timerSharedSufferingCD:Stop()
		timerMortalStrikeCD:Stop()
		timerPresenceCD:Stop()
		timerHorsefightingCD:Stop()
		countdownHorsefighting:Cancel()
		if phase2 then
			phase2 = false
		end
	elseif spellId == 227404 then --Незримое присутствие
	--	startAnalProshlyapation(self)
		if self:AntiSpam(2, "intangiblePresence") then
			syncEvent = false
			--[[runtime = GetTime()
			DBM:Debug("SPELL_AURA_APPLIED: syncEvent = false, runtime: " .. runtime)]]
			self:Schedule(1.5, checkSyncEvent, self)
			timerMortalStrikeCD:Stop() --Смертельный удар
			timerSharedSufferingCD:Stop() --Разделенные муки
			countdownSharedSuffering:Cancel() --Разделенные муки
		end
	elseif spellId == 227493 then --Смертельный удар
		if args:IsPlayer() then
			specWarnMortalStrike2:Show()
			specWarnMortalStrike2:Play("defensive")
			yellMortalStrike:Yell()
		end
		timerMortalStrike:Start()
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
		if self:IsMagicDispeller2() then
			specWarnPresence3:Cancel()
			specWarnPresence3:CancelVoice()
		end
		if self.Options.SetIconOnPresence then
			self:RemoveIcon(args.destName)
		end
	end
end

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
	elseif spellId == 227584 then --Сел на коня (Используется транспорт или Смена фазы)
		timerMortalStrikeCD:Stop()
		timerSharedSufferingCD:Stop()
		countdownSharedSuffering:Cancel()
		timerPresenceCD:Start(2)
	end
end

function mod:UNIT_HEALTH(uId)
	if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 114264 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.61 then --Полночь
		warned_preP1 = true
		warnPhase2:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
	elseif self.vb.phase == 1 and warned_preP1 and not warned_preP2 and self:GetUnitCreatureId(uId) == 114264 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.51 then --Полночь Фаза 2
		self.vb.phase = 2
		warned_preP2 = true
--		firsttwophase = true
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase))
	--	self:NextProshlyap()
		if not phase2 then
			phase2 = true
		end
	elseif self.vb.phase == 2 and warned_preP2 and not warned_preP3 and self:GetUnitCreatureId(uId) == 114264 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.51 then --Полночь
		if phase2 then
			self:NextProshlyap()
		end
	end
end

function mod:NextProshlyap()
	timerPresenceCD:Stop() --Незримое присутствие
	timerMightyStompCD:Stop() --Могучий топот
	countdownSharedSuffering:Cancel()
	timerMortalStrikeCD:Stop()
	timerSharedSufferingCD:Stop()
	timerHorsefightingCD:Stop()
	countdownHorsefighting:Cancel()
	timerMortalStrikeCD:Start(9.5) --смертельный удар
	timerSharedSufferingCD:Start(18) --Разделенные муки
	timerHorsefightingCD:Start() --Бой верхом
	countdownHorsefighting:Start()
	countdownSharedSuffering:Start() --Разделенные муки
	specWarnSpectralCharge:Schedule(29)
	specWarnSpectralCharge:ScheduleVoice(29, "watchstep")
end


function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Perephase1 then --Спустился с коня (Что ж, сразимся лицом к лицу!)
	--	if not phase2 then
	--		phase2 = true
	--	end
--		firsttwophase = true
	elseif msg == L.Perephase2 then --Сел на коня (Вперед, Полночь, к победе!)
		timerMortalStrikeCD:Stop()
		timerSharedSufferingCD:Stop()
		countdownSharedSuffering:Cancel()
	--	specWarnSpectralCharge:Schedule(2)
	--	specWarnSpectralCharge:ScheduleVoice(2, "watchstep")
		timerMightyStompCD:Start(12)
	--	perephase = false
	--	timerSpectralChargeCD:Stop() --Призрачный рывок
	--	specWarnSpectralCharge:Cancel() --Призрачный рывок
	--	timerPresenceCD:Stop() --Незримое присутствие
	--	timerMortalStrikeCD:Start(9.5) --Смертельный удар
	--	timerSharedSufferingCD:Start(18) --Разделенные муки
	--	countdownSharedSuffering:Start(18) --Разделенные муки
	end
end

function mod:VEHICLE_ANGLE_UPDATE()
	if DBM:UnitDebuff("player", 227404) and intangiblePresenceOnMe then
		intangiblePresenceOnMe = false
		syncEvent = true
		--[[local currenttime = GetTime()
		DBM:Debug("VEHICLE_ANGLE_UPDATE: syncEvent = true, GetTime(): " .. currenttime .. ", spenttime: " .. currenttime - runtime)]]
		if self.Options.SetIconOnPresence then
			self:SetIcon(playerName, 7)
		end
		self:SendSync("intangiblePresenceOnMe", playerName)
		if self:IsMagicDispeller2() then
			specWarnPresence2:Show()
			specWarnPresence2:Play("dispelnow")
		elseif not self:IsMagicDispeller2() then
			specWarnPresence:Show()
			specWarnPresence:Play("targetyou")
		end
	end
end

function mod:OnSync(msg, sender)
	if msg == "intangiblePresenceOnMe" and sender ~= playerName and not syncEvent then
		syncEvent = true
		--[[local currenttime = GetTime()
		DBM:Debug("OnSync: syncEvent = true, GetTime(): " .. currenttime .. ", spenttime: " .. currenttime - runtime)]]
		if self.Options.SetIconOnPresence then
			self:SetIcon(sender, 7)
		end
		if self:IsMagicDispeller2() then
			specWarnPresence3:Show(sender)
			specWarnPresence3:Play("dispelnow")
			specWarnPresence3:Schedule(3, sender)
			specWarnPresence3:ScheduleVoice(3, "dispelnow")
		elseif not self:IsMagicDispeller2() then
			specWarnPresence7:Show(sender)
		end
	end
end
