local mod	= DBM:NewMod(1837, "DBM-Party-Legion", 11, 860)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
mod:SetCreatureID(114312)
mod:SetEncounterID(1961)
mod:SetZone()
--mod:SetUsedIcons(1)
--mod:SetHotfixNoticeRev(14922)
--mod.respawnTime = 30

mod.noNormal = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 227672 227578 227545 227736 227672",
	"SPELL_CAST_SUCCESS 227872",
	"SPELL_AURA_APPLIED 227832 227616 227742",
	"SPELL_AURA_APPLIED_DOSE 227742",
--	"SPELL_AURA_REMOVED",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
	"UNIT_HEALTH"
)

--Мороуз https://ru.wowhead.com/npc=114312/мороуз/эпохальный-журнал-сражений
local warnGarrote					= mod:NewStackAnnounce(227742, 3, nil, nil, 2) --Гаррота
local warnVanish					= mod:NewTargetAnnounce(227736, 3) --Исчезновение
local warnGhastlyPurge				= mod:NewSpellAnnounce(227872, 4) --Жуткое очищение
local warnGhastlyPurge2				= mod:NewSoonAnnounce(227872, 1) --Жуткое очищение
--Baroness Dorothea Millstipe
local warnManaDrain					= mod:NewCastAnnounce(227545, 3) --Похищение маны
--Lady Lady Catriona Von'Indi
local warnHealingStream				= mod:NewCastAnnounce(227578, 4) --Исцеляющий поток
--Lady Keira Berrybuck
local warnEmpoweredArms				= mod:NewTargetAnnounce(227616, 4) --Усиление оружия
--Мороуз
local specWarnGarrote				= mod:NewSpecialWarningStack(227742, nil, 2, nil, nil, 1, 3) --Гаррота
local specWarnVanish				= mod:NewSpecialWarningYou(227736, nil, nil, nil, 1, 2) --Исчезновение
local specWarnCoatCheck				= mod:NewSpecialWarningYouDefensive(227832, nil, nil, nil, 3, 6) --Дресс-код
local specWarnCoatCheckHealer2		= mod:NewSpecialWarningYouDispel(227832, "MagicDispeller2", nil, nil, 3, 6) --Дресс-код
local specWarnCoatCheckHealer		= mod:NewSpecialWarningDispel(227832, "MagicDispeller2", nil, nil, 3, 6) --Дресс-код
--Лорд Криспин Ференс
local specWarnWillBreaker			= mod:NewSpecialWarningDodge(227672, "Tank", nil, nil, 1, 2) --Сокрушитель воли
--Lady Lady Catriona Von'Indi
local specWarnHealingStream			= mod:NewSpecialWarningInterrupt(227578, "HasInterrupt", nil, nil, 1, 2) --Исцеляющий поток
--Baroness Dorothea Millstipe
local specWarnManaDrain				= mod:NewSpecialWarningInterrupt(227545, "HasInterrupt", nil, nil, 1, 2) --Похищение маны
--Lady Keira Berrybuck
local specWarnEmpoweredArms			= mod:NewSpecialWarningDispel(227616, "MagicDispeller", nil, nil, 3, 6) --Усиление оружия
local specWarnEmpoweredArms2		= mod:NewSpecialWarningDefensive(227616, "Tank", nil, nil, 3, 6) --Усиление оружия
--Moroes
local timerCoatCheckCD				= mod:NewNextTimer(27.3, 227832, nil, "Tank|MagicDispeller2", nil, 5, nil, DBM_CORE_TANK_ICON..DBM_CORE_MAGIC_ICON) --Дресс-код
local timerVanishCD					= mod:NewNextTimer(19, 227736, nil, nil, nil, 3) --Исчезновение
--Lady Lady Catriona Von'Indi
local timerHealingStreamCD			= mod:NewCDTimer(40, 227578, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON) --Исцеляющий поток
--Lord Crispin Ference
local timerWillBreakerCD			= mod:NewCDTimer(40, 227672, nil, "Tank", nil, 5) --Сокрушитель воли

local yellVanish					= mod:NewYell(227736, nil, nil, nil, "YELL") --Исчезновение
--local berserkTimer					= mod:NewBerserkTimer(300)

--local countdownFocusedGazeCD		= mod:NewCountdown(40, 198006)

--mod:AddSetIconOption("SetIconOnCharge", 198006, true)
mod:AddInfoFrameOption(227909, true)

mod.vb.phase = 1
local warned_preP1 = false
local warned_preP2 = false

local updateInfoFrame
do
	local ccList = {
		[1] = DBM:GetSpellInfo(227909),--Trap included with fight
		[2] = DBM:GetSpellInfo(6770),--Rogue Sap
		[3] = DBM:GetSpellInfo(9484),--Priest Shackle
		[4] = DBM:GetSpellInfo(20066),--Paladin Repentance
		[5] = DBM:GetSpellInfo(118),--Mage Polymorph
		[6] = DBM:GetSpellInfo(51514),--Shaman Hex
		[7] = DBM:GetSpellInfo(3355),--Hunter Freezing Trap
	}
	local lines = {}
	local UnitDebuff, floor = UnitDebuff, math.floor
	updateInfoFrame = function()
		table.wipe(lines)
		for i = 1, 5 do
			local uId = "boss"..i
			if UnitExists(uId) then
				for s = 1, #ccList do
					local spellName = ccList[s]
					local _, _, _, _, _, _, expires = DBM:UnitDebuff(uId, spellName)
					if expires then
						local debuffTime = expires - GetTime()
						lines[UnitName(uId)] = floor(debuffTime)
						break
					end
				end
			end
		end
		return lines
	end
end

function mod:VanishTarget(targetname, uId) --Исчезновение ✔
	if not targetname then return end
	warnVanish:Show(targetname)
	if targetname == UnitName("player") then
		specWarnVanish:Show()
		specWarnVanish:Play("targetyou")
		yellVanish:Yell()
	end
end

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	warned_preP1 = false
	warned_preP2 = false
	if not self:IsNormal() then
		timerVanishCD:Start(7.2-delay) --Исчезновение+++
		timerCoatCheckCD:Start(30-delay) --Дресс-код+++
	else
		timerVanishCD:Start(8.2-delay) --Исчезновение
		timerCoatCheckCD:Start(33-delay) --Дресс-код
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(227909))
		DBM.InfoFrame:Show(5, "function", updateInfoFrame, false, true)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 227672 then
		specWarnWillBreaker:Show()
		specWarnWillBreaker:Play("shockwave")
		timerWillBreakerCD:Start()
	elseif spellId == 227578 then --Исцеляющий поток
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnHealingStream:Show()
			specWarnHealingStream:Play("kickcast")
		else
			warnHealingStream:Show()
			warnHealingStream:Play("kickcast")
		end
		timerHealingStreamCD:Start()
	elseif spellId == 227545 then --Похищение маны
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnManaDrain:Show()
			specWarnManaDrain:Play("kickcast")
		else
			warnManaDrain:Show()
			warnManaDrain:Play("kickcast")
		end
	elseif spellId == 227736 then --Исчезновение
		self:BossTargetScanner(args.sourceGUID, "VanishTarget", 0.1, 2)
		timerVanishCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 227872 then --Жуткое очищение на 51%
		warned_preP2 = true
		self.vb.phase = 2
		warnGhastlyPurge:Show()
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 227832 then --Дресс-код
		timerCoatCheckCD:Start()
		if args:IsPlayer() and not self:IsMagicDispeller2() then
			specWarnCoatCheck:Show()
			specWarnCoatCheck:Play("defensive")
		elseif args:IsPlayer() and self:IsMagicDispeller2() then
			specWarnCoatCheckHealer2:Show()
			specWarnCoatCheckHealer2:Play("dispelnow")
		elseif self:IsMagicDispeller2() then
			if not UnitIsDeadOrGhost("player") then
				specWarnCoatCheckHealer:Show(args.destName)
				specWarnCoatCheckHealer:Play("dispelnow")
			end
		end
	elseif spellId == 227616 then --Усиление оружия
		warnEmpoweredArms:Show(args.destName)
		if args:IsPlayer() and self:IsTank() then
			specWarnEmpoweredArms2:Show()
			specWarnEmpoweredArms2:Play("defensive")
		elseif self:IsMagicDispeller() then
			if not UnitIsDeadOrGhost("player") then
				specWarnEmpoweredArms:Show(args.destName)
				specWarnEmpoweredArms:Play("dispelnow")
			end
		end
	elseif spellId == 227742 then --Гаррота
		local amount = args.amount or 1
		if args:IsPlayer() then
			if amount >= 2 then
				specWarnGarrote:Show(amount)
				specWarnGarrote:Play("stackhigh")
			end
		else
			warnGarrote:Show(args.destName, amount)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 115440 then--baroness-dorothea-millstipe

	elseif cid == 114317 then--lady-catriona-vonindi
		timerHealingStreamCD:Stop()
	elseif cid == 115439 then--baron-rafe-dreuger
	
	elseif cid == 114319 then--lady-keira-berrybuck
		
	elseif cid == 114320 then--lord-robin-daris
			
	elseif cid == 115441 then--lord-crispin-ference
		timerWillBreakerCD:Stop()
	end
end

function mod:UNIT_HEALTH(uId)
	if not self:IsNormal() then
		if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 114312 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.61 then
			warned_preP1 = true
			warnGhastlyPurge2:Show()
		end
	end
end
