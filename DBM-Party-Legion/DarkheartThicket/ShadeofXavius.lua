local mod	= DBM:NewMod(1657, "DBM-Party-Legion", 2, 762)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
mod:SetCreatureID(99192)
mod:SetEncounterID(1839)
mod:SetZone()
mod:SetUsedIcons(8, 7, 1)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 212834 200185 200289",
	"SPELL_AURA_APPLIED 200182 200243 200289 200238",
	"SPELL_AURA_REFRESH 200243",
	"SPELL_AURA_REMOVED 200243 200289",
	"SPELL_CAST_SUCCESS 200359 199837 200182 200238",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_SPELLCAST_SUCCEEDED boss1",
	"UNIT_HEALTH boss1"
)

--Тень Ксавия https://ru.wowhead.com/npc=99192/тень-ксавия/эпохальный-журнал-сражений
local warnApocNightmare				= mod:NewSpellAnnounce(200050, 4) --Апокалиптический Кошмар
local warnApocNightmare2			= mod:NewSoonAnnounce(200050, 1) --Апокалиптический Кошмар
local warnNightmare					= mod:NewTargetAnnounce(200243, 3) --Кошмар наяву
local warnParanoia					= mod:NewTargetAnnounce(200289, 3) --Усугубляющаяся паранойя
local warnFeedontheWeak				= mod:NewTargetAnnounce(200238, 4) --Пожирание слабых
local warnNightmareBolt				= mod:NewTargetAnnounce(200185, 4) --Кошмарная стрела

local specWarnFesteringRip2			= mod:NewSpecialWarningYou(200182, nil, nil, nil, 2, 3) --Гноящаяся рана
local specWarnFesteringRip3			= mod:NewSpecialWarningYouDispel(200182, "MagicDispeller2", nil, nil, 3, 3) --Гноящаяся рана
local specWarnFesteringRip			= mod:NewSpecialWarningDispel(200182, "MagicDispeller2", nil, nil, 3, 3) --Гноящаяся рана
--
local specWarnNightmareBolt			= mod:NewSpecialWarningYouDefensive(200185, nil, nil, nil, 3, 5) --Кошмарная стрела
local specWarnApocNightmare2		= mod:NewSpecialWarningDefensive(200050, nil, nil, nil, 3, 5) --Апокалиптический Кошмар
local specWarnFeedontheWeak			= mod:NewSpecialWarningYouDefensive(200238, nil, nil, nil, 3, 5) --Пожирание слабых
local specWarnNightmare				= mod:NewSpecialWarningYouShare(200243, nil, nil, nil, 1, 3) --Кошмар наяву
local specWarnParanoia				= mod:NewSpecialWarningYouMoveAway(200289, nil, nil, nil, 3, 5) --Усугубляющаяся паранойя
local specWarnParanoia2				= mod:NewSpecialWarningCloseMoveAway(200289, nil, nil, nil, 1, 5) --Усугубляющаяся паранойя

local timerNightmareBoltCD			= mod:NewCDTimer(20, 200185, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON..DBM_CORE_MYTHIC_ICON) --Кошмарная стрела
local timerFeedontheWeakCD			= mod:NewCDTimer(20, 200238, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Пожирание слабых
local timerFesteringRipCD			= mod:NewCDTimer(16.5, 200182, nil, "MagicDispeller2", nil, 5, nil, DBM_CORE_MAGIC_ICON) --Гноящаяся рана 17-21
local timerNightmareCD				= mod:NewCDTimer(17, 200243, nil, nil, nil, 3) --Кошмар наяву 17-25
local timerNightmare				= mod:NewTargetTimer(20, 200243, nil, nil, nil, 7) --Кошмар наяву
local timerParanoiaCD				= mod:NewCDTimer(18, 200359, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Искусственная паранойя 18-28
local timerParanoia					= mod:NewTargetTimer(20, 200289, nil, nil, nil, 7) --Усугубляющаяся паранойя
local timerApocNightmare			= mod:NewCastTimer(5, 200050, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Апокалиптический Кошмар

local yellFesteringRip				= mod:NewYell(200182, nil, nil, nil, "YELL") --Гноящаяся рана
local yellNightmareBolt				= mod:NewYell(200185, nil, nil, nil, "YELL") --Кошмарная стрела
local yellFeedontheWeak				= mod:NewYell(200238, nil, nil, nil, "YELL") --Пожирание слабых
local yellNightmare					= mod:NewYellHelp(200243, nil, nil, nil, "YELL") --Кошмар наяву
local yellParanoia					= mod:NewYellMoveAway(200289, nil, nil, nil, "YELL") --Усугубляющаяся паранойя
local yellParanoia2					= mod:NewFadesYell(200289, nil, nil, nil, "YELL") --Усугубляющаяся паранойя

local countdownApocNightmare		= mod:NewCountdown(5, 200050, nil, nil, 5) --Апокалиптический Кошмар

local playerName = UnitName("player")

mod:AddSetIconOption("SetIconOnFeedontheWeak", 200238, true, false, {8}) --Пожирание слабых
mod:AddSetIconOption("SetIconOnNightmareBolt", 200185, true, false, {8}) --Кошмарная стрела
mod:AddSetIconOption("SetIconOnParanoia", 200289, true, false, {7}) --Усугубляющаяся паранойя
mod:AddSetIconOption("SetIconOnNightmare", 200243, true, false, {1}) --Кошмар наяву

mod.vb.phase = 1
mod.vb.nightmareBolt = 0
mod.vb.feedOnTheWeak = 0
mod.vb.growingParanoia = 0
mod.vb.lastBoltTime = 0
local warned_preP1 = false
local warned_preP2 = false

function mod:NightmareBoltTarget(targetname, uId) --Прошляпанное очко Мурчаля ✔
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnNightmareBolt:Show()
		specWarnNightmareBolt:Play("defensive")
		yellNightmareBolt:Yell()
	else
		warnNightmareBolt:Show(targetname)
	end
	if self.Options.SetIconOnNightmareBolt then
		self:SetIcon(targetname, 8, 5)
	end
end

function mod:ParanoiaTarget(targetname, uId) --Усугубляющаяся паранойя ✔
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnParanoia:Show()
		specWarnParanoia:Play("runaway")
		yellParanoia:Yell()
	elseif self:CheckNearby(15, targetname) then
		specWarnParanoia2:Show(targetname)
		specWarnParanoia2:Play("runaway")
	else
		warnParanoia:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.nightmareBolt = 0
	self.vb.feedOnTheWeak = 0
	self.vb.growingParanoia = 0
	self.vb.lastBoltTime = 0
	warned_preP1 = false
	warned_preP2 = false
	if not self:IsNormal() then
		timerNightmareBoltCD:Start(8.8-delay)
		timerFesteringRipCD:Start(3.4-delay)
	--	timerNightmareCD:Start(11-delay)
		timerFeedontheWeakCD:Start(14-delay)
		timerParanoiaCD:Start(26-delay)
	else
		timerFesteringRipCD:Start(3.4-delay)
	--	timerNightmareCD:Start(6-delay)
		timerFeedontheWeakCD:Start(15-delay)
		timerParanoiaCD:Start(19-delay)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 212834 or spellId == 200185 then --Кошмарная стрела
		self:BossTargetScanner(args.sourceGUID, "NightmareBoltTarget", 0.1, 2)
		timerNightmareBoltCD:Start(17.8)
		if self.vb.feedOnTheWeak == 1 and self.vb.nightmareBolt == 0 then
			timerParanoiaCD:Start(4.8)
			timerNightmareBoltCD:Start(18.5)
			timerFeedontheWeakCD:Start(18.5)
			self.vb.feedOnTheWeak = 0
		elseif self.vb.nightmareBolt == 1 then
			timerFeedontheWeakCD:Start(5)
			timerParanoiaCD:Start(15)
			timerNightmareBoltCD:Start(21)
		end
		self.vb.nightmareBolt = self.vb.nightmareBolt + 1
		self.vb.lastBoltTime = GetTime() + 19
	elseif spellId == 200289 then --Усугубляющаяся паранойя
		self:BossTargetScanner(args.sourceGUID, "ParanoiaTarget", 0.1, 2)
		if self.vb.feedOnTheWeak == 1 and self.vb.growingParanoia == 0 then
			timerNightmareBoltCD:Start(6)
			timerFeedontheWeakCD:Start(17.5)
			self.vb.feedOnTheWeak = 0
		elseif self.vb.nightmareBolt == 1 and self.vb.growingParanoia == 0 then
			timerNightmareBoltCD:Start(13.5)
			timerFeedontheWeakCD:Start(13.5)
			self.vb.feedOnTheWeak = 0
		end
		self.vb.growingParanoia = self.vb.growingParanoia + 1
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 200359 then --Искусственная паранойя
	--	timerParanoiaCD:Start()
	elseif spellId == 200182 then --Гноящаяся рана
		timerFesteringRipCD:Start()
	elseif spellId == 200238 then --Пожирание слабых
	--	timerFeedontheWeakCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 200182 then --Гноящаяся рана
		if self:IsMythic() then
			if args:IsPlayer() and not self:IsMagicDispeller2() then
				specWarnFesteringRip2:Show()
				specWarnFesteringRip2:Play("targetyou")
				yellFesteringRip:Yell()
			elseif args:IsPlayer() and self:IsMagicDispeller2() then
				specWarnFesteringRip3:Show()
				specWarnFesteringRip3:Play("dispelnow")
				yellFesteringRip:Yell()
			elseif self:IsMagicDispeller2() then
				if not UnitIsDeadOrGhost("player") then
					specWarnFesteringRip:Show(args.destName)
					specWarnFesteringRip:Play("dispelnow")
				end
			end
		else
			if args:IsPlayer() and not self:IsMagicDispeller2() then
				specWarnFesteringRip2:Show()
				specWarnFesteringRip2:Play("targetyou")
				yellFesteringRip:Yell()
			elseif args:IsPlayer() and self:IsMagicDispeller2() then
				specWarnFesteringRip3:Show()
				specWarnFesteringRip3:Play("dispelnow")
				yellFesteringRip:Yell()
			end
		end
	elseif spellId == 200243 then --Кошмар наяву
		timerNightmare:Start(args.destName)
		if args:IsPlayer() then
			specWarnNightmare:Show()
			specWarnNightmare:Play("gathershare")
			yellNightmare:Yell()
		else
			warnNightmare:Show(args.destName)
		end
		if self.Options.SetIconOnNightmare then
			self:SetIcon(args.destName, 1)
		end
	elseif spellId == 200289 then --Усугубляющаяся паранойя
		timerParanoia:Start(args.destName)
		if args:IsPlayer() then
			yellParanoia2:Countdown(20, 3)
		end
		if self.Options.SetIconOnParanoia then
			self:SetIcon(args.destName, 7)
		end
	elseif spellId == 200238 then --Пожирание слабых
		self.vb.nightmareBolt = 0
		self.vb.growingParanoia = 0
		self.vb.feedOnTheWeak = 1
		if not self:IsNormal() then
			if args:IsPlayer() then
				specWarnFeedontheWeak:Show()
				specWarnFeedontheWeak:Play("defensive")
				yellFeedontheWeak:Yell()
			else
				warnFeedontheWeak:Show(args.destName)
			end
		end
		if self.Options.SetIconOnFeedontheWeak then
			self:SetIcon(args.destName, 8, 5)
		end
		if (self.vb.lastBoltTime-GetTime()) > 13 then
			timerParanoiaCD:Start(9)
			timerNightmareBoltCD:Start(16)
		elseif (self.vb.lastBoltTime-GetTime()) < 0.6 then
			timerNightmareBoltCD:Start(8.5)
			timerParanoiaCD:Start(13)
		elseif (self.vb.lastBoltTime-GetTime()) < 13 then
			timerParanoiaCD:Start(8.5)
			timerNightmareBoltCD:Start(8.5)
		end
	end
end
mod.SPELL_AURA_REFRESH = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 200243 then --Кошмар наяву
		timerNightmare:Cancel(args.destName)
		if self.Options.SetIconOnNightmare then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 200289 then --Усугубляющаяся паранойя
		timerParanoia:Cancel(args.destName)
		if args:IsPlayer() then
			yellParanoia2:Cancel()
		end
		if self.Options.SetIconOnParanoia then
			self:SetIcon(args.destName, 0)
		end
	end
end

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 204808 then--Because cast is hidden from combat log, and debuff may miss (AMS or the like)
		timerNightmareCD:Start()
	elseif spellId == 200050 then --Апокалиптический Кошмар
		warnApocNightmare:Show()
	end
end]]

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.XavApoc then
		warnApocNightmare:Show()
		timerApocNightmare:Start()
		countdownApocNightmare:Start()
		if not UnitIsDeadOrGhost("player") then
			specWarnApocNightmare2:Show()
			specWarnApocNightmare2:Play("defensive")
		end
	elseif msg == L.XavApoc2 then
		warnApocNightmare:Show()
		timerApocNightmare:Start()
		countdownApocNightmare:Start()
		if not UnitIsDeadOrGhost("player") then
			specWarnApocNightmare2:Show()
			specWarnApocNightmare2:Play("defensive")
		end
	end
end

function mod:UNIT_HEALTH(uId)
	if not self:IsNormal() then
		if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 99192 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.61 then
			warned_preP1 = true
			warnApocNightmare2:Show()
		elseif self.vb.phase == 1 and warned_preP1 and not warned_preP2 and self:GetUnitCreatureId(uId) == 99192 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.51 then
			self.vb.phase = 2
			warned_preP2 = true
		end
	else
		if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 99192 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.61 then
			warned_preP1 = true
		elseif self.vb.phase == 1 and warned_preP1 and not warned_preP2 and self:GetUnitCreatureId(uId) == 99192 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.51 then
			self.vb.phase = 2
			warned_preP2 = true
		end
	end
end
