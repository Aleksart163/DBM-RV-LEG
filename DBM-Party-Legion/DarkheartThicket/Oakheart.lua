local mod	= DBM:NewMod(1655, "DBM-Party-Legion", 2, 762)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(103344)
mod:SetEncounterID(1837)
mod:SetZone()
mod:SetUsedIcons(8)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 204666 204646 204574 204667 212786",
	"SPELL_AURA_APPLIED 204611"
)
--https://ru.wowhead.com/npc=103344/дубосерд/эпохальный-журнал-сражений
local warnShatteredEarth			= mod:NewSpellAnnounce(204666, 3) --Расколовшаяся земля
local warnThrowTarget				= mod:NewTargetNoFilterAnnounce(204658, 2) --Сокрушительная хватка

local specWarnUproot				= mod:NewSpecialWarningSwitch(212786, "-Healer", nil, nil, 1, 2) --Пересадка
local specWarnThrow2				= mod:NewSpecialWarningYouDefensive(204611, "Tank", nil, nil, 3, 5) --Сокрушительная хватка
local specWarnThrow					= mod:NewSpecialWarningYouMoveAway(204658, nil, nil, nil, 4, 5) --Сокрушительная хватка
local specWarnThrow3				= mod:NewSpecialWarningCloseMoveAway(204658, "-Tank", nil, nil, 2, 2) --Сокрушительная хватка
local specWarnShatteredEarth		= mod:NewSpecialWarningDefensive(204666, "-Tank", nil, nil, 2, 2) --Расколовшаяся земля
local specWarnRoots					= mod:NewSpecialWarningDodge(204574, nil, nil, nil, 2, 2) --Корни-душители
local specWarnBreath				= mod:NewSpecialWarningYouDefensive(204667, "Tank", nil, nil, 3, 5) --Дыхание Кошмара
local specWarnBreath2				= mod:NewSpecialWarningDodge(204667, "-Tank", nil, nil, 2, 2) --Дыхание Кошмара
--Доделать кд спеллов + добавить пересадку
local timerUprootCD					= mod:NewCDTimer(36, 212786, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON) --Пересадка
local timerShatteredEarthCD			= mod:NewCDTimer(35, 204666, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Расколовшаяся земля 35-62 +++
local timerThrowCD					= mod:NewCDTimer(28, 204658, nil, nil, nil, 3, nil, DBM_CORE_TANK_ICON..DBM_CORE_DEADLY_ICON) --Сокрушительная хватка 29-32
local timerRootsCD					= mod:NewCDTimer(23, 204574, nil, nil, nil, 3) --Корни-душители 23-31 +++
local timerBreathCD					= mod:NewCDTimer(26.5, 204667, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON..DBM_CORE_DEADLY_ICON) --Дыхание Кошмара 26--35

local yellThrow						= mod:NewYell(204658, L.ThrowYell, nil, nil, "YELL") --Сокрушительная хватка 

local countdownThrow				= mod:NewCountdown("Alt28", 204658, "Tank") --Сокрушительная хватка

mod:AddSetIconOption("SetIconOnThrow", 204658, true, false, {8}) --Сокрушительная хватка (бросок)

local playerName = UnitName("player")
--AKA Crushing Grip
function mod:ThrowTarget(targetname, uId)
	if not targetname then
		return
	end
	if targetname == UnitName("player") then
		--Can this be dodged? personal warning?
		specWarnThrow:Show()
		yellThrow:Yell(playerName)
	elseif self:CheckNearby(10, targetname) then
		specWarnThrow3:Show(targetname)
		warnThrowTarget:Show(targetname)
	else
		warnThrowTarget:Show(targetname)
	end
	if self.Options.SetIconOnThrow then
		self:SetIcon(targetname, 8, 10)
	end
end

function mod:OnCombatStart(delay)
	if self:IsHard() then
		timerShatteredEarthCD:Start(7-delay) --Расколовшаяся земля ++
		timerRootsCD:Start(15-delay) --Корни-душители ++
		timerBreathCD:Start(21-delay) --Дыхание Кошмара ++
		timerThrowCD:Start(30-delay) --Сокрушительная хватка ++
		countdownThrow:Start(30-delay) --Сокрушительная хватка ++
		timerUprootCD:Start(36.5-delay) --Пересадка
	else
		timerShatteredEarthCD:Start(6-delay) --Расколовшаяся земля
		timerRootsCD:Start(12-delay) --Корни-душители
		timerBreathCD:Start(18-delay) --Дыхание Кошмара
		timerThrowCD:Start(29-delay) --Сокрушительная хватка
		countdownThrow:Start(29-delay) --Сокрушительная хватка
		timerUprootCD:Start(36.5-delay) --Пересадка
	end
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 204646 then
		timerThrowCD:Start()
		countdownThrow:Start()
		self:BossTargetScanner(103344, "ThrowTarget", 0.1, 12, true, nil, nil, nil, true)
	elseif spellId == 204666 then
		warnShatteredEarth:Show()
		specWarnShatteredEarth:Show()
		timerShatteredEarthCD:Start()
	elseif spellId == 204574 then
		specWarnRoots:Show()
		specWarnRoots:Play("watchstep")
		if self:IsHard() then
			timerRootsCD:Start(25)
		else
			timerRootsCD:Start()
		end
	elseif spellId == 204667 then
		specWarnBreath:Show()
		specWarnBreath:Play("defensive")
		specWarnBreath2:Show()
		specWarnBreath2:Play("defensive")
		timerBreathCD:Start()
	elseif spellId == 212786 then --Пересадка
		specWarnUproot:Show()
		timerUprootCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 204611 then ----Сокрушительная хватка
		if args:IsPlayer() then
			specWarnThrow2:Show()
			specWarnThrow2:Play("defensive")
		end
	end
end
