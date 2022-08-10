local mod	= DBM:NewMod(1718, "DBM-Party-Legion", 7, 800)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(104215)
mod:SetEncounterID(1868)
mod:SetZone()
mod:SetUsedIcons(8, 7)

mod.noNormal = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 207261 207815 207806 215204 207278",
	"SPELL_AURA_APPLIED 215204",
	"SPELL_AURA_REMOVED 215204",
	"SPELL_CAST_SUCCESS 207278 219488",
	"UNIT_HEALTH boss1"
)

--Капитан патруля Гердо https://ru.wowhead.com/npc=104215/капитан-патруля-гердо/эпохальный-журнал-сражений
local warnHinder					= mod:NewCastAnnounce(215204, 3) --Помеха
local warnHinder2					= mod:NewTargetAnnounce(215204, 4) --Помеха
local warnFlask						= mod:NewSpellAnnounce(207815, 3) --Настой священной ночи
local warnFlask2					= mod:NewSoonAnnounce(207815, 1) --Настой священной ночи
local warnSignalBeacon				= mod:NewSoonAnnounce(207806, 1) --Сигнальный маяк
local warnStreetsweeper				= mod:NewSpellAnnounce(219488, 4) --Дворник
local warnArcaneLockdown			= mod:NewCastAnnounce(207278, 3) --Чародейская изоляция

local specWarnHinder				= mod:NewSpecialWarningInterrupt(215204, "HasInterrupt", nil, nil, 3, 2) --Помеха
local specWarnHinder2				= mod:NewSpecialWarningDispel(215204, "MagicDispeller2", nil, nil, 1, 5) --Помеха
local specWarnResonantSlash			= mod:NewSpecialWarningDodge(207261, nil, nil, nil, 2, 3) --Резонирующий удар сплеча
local specWarnArcaneLockdown		= mod:NewSpecialWarningJump(207278, nil, nil, nil, 1, 6) --Чародейская изоляция
local specWarnBeacon				= mod:NewSpecialWarningSwitch(207806, "-Healer", nil, nil, 1, 2) --Сигнальный маяк

local timerStreetsweeperCD			= mod:NewCDTimer(7, 219488, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON..DBM_CORE_MYTHIC_ICON) --Дворник
local timerResonantSlashCD			= mod:NewCDTimer(12.1, 207261, nil, nil, nil, 3, nil, DBM_CORE_TANK_ICON..DBM_CORE_DEADLY_ICON) --Резонирующий удар сплеча +++
local timerArcaneLockdownCD			= mod:NewCDTimer(30, 207278, nil, nil, nil, 2, nil, DBM_CORE_MAGIC_ICON..DBM_CORE_DEADLY_ICON) --Чародейская изоляция +++

mod:AddSetIconOption("SetIconOnHinder", 215204, true, false, {8, 7}) --Помеха

mod.vb.phase = 1

mod.vb.hinderIcon = 8

local warned_preP1 = false
local warned_preP2 = false
local warned_preP3 = false	

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.hinderIcon = 8
	warned_preP1 = false
	warned_preP2 = false
	warned_preP3 = false
	if not self:IsNormal() then
		timerStreetsweeperCD:Start(11-delay) --Дворник
		timerResonantSlashCD:Start(7-delay) --Резонирующий удар сплеча +++
		timerArcaneLockdownCD:Start(15.5-delay) --Чародейская изоляция +++
	else
		timerResonantSlashCD:Start(7-delay) --Резонирующий удар сплеча +++
		timerArcaneLockdownCD:Start(15-delay) --Чародейская изоляция +++
	end
end

function mod:OnCombatEnd()
	if self.Options.SetIconOnHinder then
		self:SetIcon(args.destName, 0)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 207261 then
		specWarnResonantSlash:Show()
		specWarnResonantSlash:Play("watchstep")
		if self.vb.phase == 2 then
			timerResonantSlashCD:Start(10)
		else
			timerResonantSlashCD:Start()
		end
	elseif spellId == 207815 then --Настой священной ночи
		self.vb.phase = 2
		warned_preP3 = true
		warnFlask:Show()
		timerStreetsweeperCD:Cancel()
		timerResonantSlashCD:Cancel()
		timerArcaneLockdownCD:Cancel()
		timerArcaneLockdownCD:Start(6)
		timerStreetsweeperCD:Start(9)
		timerResonantSlashCD:Start(13.5)
	elseif spellId == 207806 then
		specWarnBeacon:Show()
		specWarnBeacon:Play("mobsoon")
		timerStreetsweeperCD:Stop()
		timerStreetsweeperCD:Start(9)
	elseif spellId == 215204 and self:AntiSpam(2, 1) then --Помеха
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnHinder:Show()
			specWarnHinder:Play("kickcast")
		else
			warnHinder:Show()
			warnHinder:Play("kickcast")
		end
	elseif spellId == 207278 then --Чародейская изоляция
		warnArcaneLockdown:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 207278 then --Чародейская изоляция
		specWarnArcaneLockdown:Show()
		specWarnArcaneLockdown:Play("keepjump")
		if self:IsHard() then
			timerArcaneLockdownCD:Start(26)
		else
			timerArcaneLockdownCD:Start()
		end
	elseif spellId == 219488 then --Дворник
		warnStreetsweeper:Show()
		warnStreetsweeper:Play("watchstep")
		timerStreetsweeperCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 215204 then --Помеха
		self.vb.hinderIcon = self.vb.hinderIcon - 1
		warnHinder2:CombinedShow(0.3, args.destName)
		specWarnHinder2:Show(args.destName)
		if self.Options.SetIconOnHinder then
			self:SetIcon(args.destName, self.vb.hinderIcon)
		end
		if self.vb.hinderIcon == 7 then
			self.vb.hinderIcon = 8
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 215204 then --Помеха
		if self.Options.SetIconOnHinder then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:UNIT_HEALTH(uId)
	if self:IsHard() then --миф и миф+
		if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 104215 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.81 then
			warned_preP1 = true
			warnSignalBeacon:Show()
		elseif self.vb.phase == 1 and warned_preP1 and not warned_preP2 and self:GetUnitCreatureId(uId) == 104215 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.31 then
			warned_preP2 = true
			warnFlask2:Show()
		end
	else
		if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 104215 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.81 then
			warned_preP1 = true
		elseif self.vb.phase == 1 and warned_preP1 and not warned_preP2 and self:GetUnitCreatureId(uId) == 104215 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.31 then
			warned_preP2 = true
		end
	end
end
