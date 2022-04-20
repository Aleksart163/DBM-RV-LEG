local mod	= DBM:NewMod(1817, "DBM-Party-Legion", 11, 860)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(114350)
mod:SetEncounterID(1965)
mod:SetZone()
mod:SetUsedIcons(1, 2)
--mod:SetHotfixNoticeRev(14922)
--mod.respawnTime = 30

mod.noNormal = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 227628 227592 227779 228269 228334",
	"SPELL_AURA_APPLIED 227592 228261 228249 227644",
	"SPELL_AURA_APPLIED_DOSE 227644",
	"SPELL_AURA_REMOVED 227592 228261",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3"
)

local warnArcaneMissiles			= mod:NewStackAnnounce(227644, 1) --Пронзающие стрелы
local warnInfernoBolt				= mod:NewTargetAnnounce(227615, 3) --Инфернальная стрела
local warnFlameWreath				= mod:NewCastAnnounce(228269, 4) --Венец пламени
local warnFlameWreathTargets		= mod:NewTargetAnnounce(228269, 4) --Венец пламени

local specWarnArcaneMissiles		= mod:NewSpecialWarningDefensive(227628, "Tank", nil, nil, 1, 2) --Пронзающие стрелы
local specWarnArcaneMissiles2		= mod:NewSpecialWarningStack(227644, nil, 3, nil, nil, 3, 5) --Пронзающие стрелы
local specWarnFrostbite				= mod:NewSpecialWarningInterrupt(227592, "HasInterrupt", nil, nil, 3, 2) --Обморожение
local specWarnInfernoBoltMoveTo		= mod:NewSpecialWarningMoveTo(227615, nil, nil, nil, 1, 2) --Инфернальная стрела
local specWarnInfernoBoltMoveAway	= mod:NewSpecialWarningMoveAway(227615, nil, nil, nil, 1, 2) --Инфернальная стрела
local specWarnInfernoBoltNear		= mod:NewSpecialWarningClose(227615, nil, nil, nil, 1, 2) --Инфернальная стрела
local specWarnCeaselessWinter		= mod:NewSpecialWarningDontStand(227779, nil, nil, nil, 2, 3) --Бесконечная зима
local specWarnFlameWreath			= mod:NewSpecialWarningYouDontMove(228261, nil, nil, nil, 3, 5) --Венец пламени
local specWarnFlameWreath2			= mod:NewSpecialWarningDontMove(228269, nil, nil, nil, 2, 5) --Венец пламени
local specWarnGuardiansImage		= mod:NewSpecialWarningSwitch(228334, "-Healer", nil, nil, 1, 2) --Проекция Хранителя

local timerSpecialCD				= mod:NewCDSpecialTimer(30)
local timerArcaneMissiles			= mod:NewTargetTimer(20, 227644, nil, nil, nil, 3, nil, DBM_CORE_TANK_ICON) --Пронзающие стрелы

local yellFlameWreath				= mod:NewYell(228261, nil, nil, nil, "YELL") --Венец пламени
local yellFlameWreath2				= mod:NewFadesYell(228261, nil, nil, nil, "YELL") --Венец пламени

local countdownSpecial				= mod:NewCountdown(30, 228582)

mod:AddSetIconOption("SetIconOnWreath", 228261, true) --Венец пламени
--mod:AddInfoFrameOption(198108, false)

mod.vb.playersFrozen = 0
mod.vb.imagesActive = false
local frostBiteName, flameWreathName = DBM:GetSpellInfo(227592), DBM:GetSpellInfo(228261)

function mod:OnCombatStart(delay)
	self.vb.playersFrozen = 0
	self.vb.imagesActive = false
	timerSpecialCD:Start(33.5)
	countdownSpecial:Start(33.5)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 227628 then --Пронзающие стрелы
		specWarnArcaneMissiles:Show()
		specWarnArcaneMissiles:Play("defensive")
	elseif spellId == 227592 then --Обморожение
		specWarnFrostbite:Show(args.sourceName)
		specWarnFrostbite:Play("kickcast")
	elseif spellId == 227779 then --Бесконечная зима
		specWarnCeaselessWinter:Show()
		specWarnCeaselessWinter:Play("keepjump")
		timerSpecialCD:Start(32.5)
		countdownSpecial:Start(32.5)
	elseif spellId == 228269 then --Венец пламени
		warnFlameWreath:Show()
		specWarnFlameWreath2:Show()
		specWarnFlameWreath2:Play("stopmove")
		timerSpecialCD:Start(31.5)
		countdownSpecial:Start(31.5)
	elseif spellId == 228334 then --Проекция Хранителя
		self.vb.imagesActive = true
		specWarnGuardiansImage:Show()
		specWarnGuardiansImage:Play("killmob")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 227592 then
		self.vb.playersFrozen = self.vb.playersFrozen + 1
	elseif spellId == 228261 then
		warnFlameWreathTargets:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnFlameWreath:Show()
			specWarnFlameWreath:Play("stopmove")
			yellFlameWreath:Yell()
			yellFlameWreath2:Countdown(20, 5)
		end
		if self.Options.SetIconOnWreath then
			self:SetAlphaIcon(0.5, args.destName, 2)
		end
	elseif spellId == 228249 then
		if args:IsPlayer() then
			if self.vb.playersFrozen == 0 then
				specWarnInfernoBoltMoveAway:Show()
				specWarnInfernoBoltMoveAway:Play("scatter")
			else
				specWarnInfernoBoltMoveTo:Show(frostBiteName)
				specWarnInfernoBoltMoveTo:Play("gather")
			end
		elseif self:CheckNearby(8, args.destName) and not UnitDebuff("player", frostBiteName) and not UnitDebuff("player", flameWreathName) then
			specWarnInfernoBoltNear:Show(args.destName)
			specWarnInfernoBoltNear:Play("scatter")
		else
			warnInfernoBolt:Show(args.destName)
		end
	elseif spellId == 227644 then --Пронзающие стрелы
		local amount = args.amount or 1
		warnArcaneMissiles:Show(args.destName, amount)
		timerArcaneMissiles:Start(args.destName)
		if self:IsNormal() or self:IsHeroic() then
			if amount >= 3 then
				if args:IsPlayer() then
					specWarnArcaneMissiles2:Show(args.amount)
				end
			end
		elseif self:IsHard() then --миф и миф+
			if amount >= 2 then
				if args:IsPlayer() then
					specWarnArcaneMissiles2:Show(args.amount)
				end
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 227592 then
		self.vb.playersFrozen = self.vb.playersFrozen - 1
	elseif spellId == 228261 then
		if self.Options.SetIconOnWreath then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 227644 then --Пронзающие стрелы
		timerArcaneMissiles:Cancel(args.destName)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 228582 and self.vb.imagesActive then--Mana Regen
		self.vb.imagesActive = false
		timerSpecialCD:Start()
		countdownSpecial:Start()
	end
end
