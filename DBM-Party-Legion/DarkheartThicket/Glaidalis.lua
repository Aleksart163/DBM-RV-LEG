local mod	= DBM:NewMod(1654, "DBM-Party-Legion", 2, 762)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
mod:SetCreatureID(96512)
mod:SetEncounterID(1836)
mod:SetZone()
mod:SetUsedIcons(8, 7, 6)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 198379",
	"SPELL_CAST_SUCCESS 198401 212464",
	"SPELL_AURA_APPLIED 196376",
	"SPELL_AURA_REMOVED 196376",
	"SPELL_PERIODIC_DAMAGE 198408",
	"SPELL_PERIODIC_MISSED 198408",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--Верховный друид Глайдалис https://ru.wowhead.com/npc=96512/верховный-друид-глайдалис/эпохальный-журнал-сражений
local warnLeap					= mod:NewTargetAnnounce(196346, 4) --Мучительный прыжок

local specWarnGrievousTear		= mod:NewSpecialWarningYou(196376, nil, nil, nil, 2, 5) --Мучительное разрывание
local specWarnGrievousTear2		= mod:NewSpecialWarningEnd(196376, nil, nil, nil, 1, 2) --Мучительное разрывание
local specWarnNightfall			= mod:NewSpecialWarningYouMove(198408, nil, nil, nil, 1, 2) --Сумерки
local specWarnRampage			= mod:NewSpecialWarningDodge(198379, nil, nil, nil, 3, 6) --Первобытная ярость
local specWarnRampage2			= mod:NewSpecialWarningTargetDodge(198379, nil, nil, nil, 2, 2) --Первобытная ярость

local timerLeapCD				= mod:NewCDTimer(14, 196346, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON..DBM_CORE_HEALER_ICON) --Мучительный прыжок
local timerRampageCD			= mod:NewCDTimer(28.7, 198379, nil, "Melee", nil, 3, nil, DBM_CORE_TANK_ICON..DBM_CORE_DEADLY_ICON) --Первобытная ярость
local timerNightfallCD			= mod:NewCDTimer(14.5, 198401, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Сумерки

local yellLeap					= mod:NewYell(196346, nil, nil, nil, "YELL") --Мучительный прыжок
local yellRampage				= mod:NewYellMoveAway(198379, nil, nil, nil, "YELL") --Первобытная ярость

local countdownRampage			= mod:NewCountdown(28.7, 198379, "Melee", nil, 5) --Первобытная ярость

mod:AddSetIconOption("SetIconOnRampage", 198379, true, false, {8}) --Первобытная ярость
mod:AddSetIconOption("SetIconOnGrievousTear", 196376, true, false, {7, 6}) --Мучительное разрывание

mod.vb.rampage = 0
mod.vb.grievousTearIcon = 7

function mod:RampageTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnRampage:Show()
		specWarnRampage:Play("justrun")
		yellRampage:Yell()
	else
		specWarnRampage2:Show(targetname)
		specWarnRampage2:Play("watchstep")
	end
	if self.Options.SetIconOnRampage then
		self:SetIcon(targetname, 8, 5)
	end
end

function mod:OnCombatStart(delay)
	self.vb.rampage = 0
	self.vb.grievousTearIcon = 7
	if not self:IsNormal() then
		timerLeapCD:Start(5.5-delay) --Мучительный прыжок
		timerRampageCD:Start(13.5-delay) --Первобытная ярость
		countdownRampage:Start(13.5-delay) --Первобытная ярость
	else
		timerLeapCD:Start(5.9-delay) --Мучительный прыжок
		timerRampageCD:Start(12.2-delay) --Первобытная ярость
		countdownRampage:Start(12.2-delay) --Первобытная ярость
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 198379 then
		self.vb.rampage = self.vb.rampage + 1
		self:BossTargetScanner(args.sourceGUID, "RampageTarget", 0.1, 2)
		timerRampageCD:Start()
		countdownRampage:Start()
		if self.vb.rampage == 1 then
			timerNightfallCD:Start(12.5)
		elseif self.vb.rampage == 2 then
			timerNightfallCD:Start(12)
		elseif self.vb.rampage == 3 then
			timerNightfallCD:Start(14)
		elseif self.vb.rampage == 4 then
			timerNightfallCD:Start(15)
		elseif self.vb.rampage == 5 then
			timerNightfallCD:Start(16)
		elseif self.vb.rampage == 6 then
			timerNightfallCD:Start(18)
		elseif self.vb.rampage == 7 then
			timerNightfallCD:Start(25)
		elseif self.vb.rampage == 8 then
			timerNightfallCD:Start(26)
		elseif self.vb.rampage == 9 then
			timerNightfallCD:Start(28.5)
		elseif self.vb.rampage == 10 then
			timerNightfallCD:Start(35)
		elseif self.vb.rampage == 11 then
			timerNightfallCD:Start(6)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 196376 then --Мучительное разрывание
		warnLeap:CombinedShow(0.7, args.destName)
		if args:IsPlayer() then
			specWarnGrievousTear:Show()
			specWarnGrievousTear:Play("defensive")
			yellLeap:Yell()
		end
		if self.Options.SetIconOnGrievousTear then
			self:SetIcon(args.destName, self.vb.grievousTearIcon)
		end
		self.vb.grievousTearIcon = self.vb.grievousTearIcon - 1
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 196376 then --Мучительное разрывание
		self.vb.grievousTearIcon = self.vb.grievousTearIcon + 1
		if self:IsHard() then
			if args:IsPlayer() then
				specWarnGrievousTear2:Show()
			end
		end
		if self.Options.SetIconOnGrievousTear then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 198408 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		if not self:IsNormal() then
			specWarnNightfall:Show()
			specWarnNightfall:Play("runaway")
		end
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 196346 then
		timerLeapCD:Start()
	end
end
