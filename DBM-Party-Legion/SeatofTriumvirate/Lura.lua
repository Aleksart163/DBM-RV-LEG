local mod	= DBM:NewMod(1982, "DBM-Party-Legion", 13, 945)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(124870) -- или 124729 --124745 Greater Rift Warden
mod:SetEncounterID(2068)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 247795 245164 249009 247878",
	"SPELL_CAST_SUCCESS 247930",
	"SPELL_AURA_APPLIED 247816 248535 247915",
	"SPELL_AURA_APPLIED_DOSE 247915",
	"SPELL_AURA_REMOVED 247816",
--	"CHAT_MSG_RAID_BOSS_EMOTE",
--	"CHAT_MSG_MONSTER_YELL",
	"SPELL_PERIODIC_DAMAGE 245242",
	"SPELL_PERIODIC_MISSED 245242",
--	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--Л'ура https://ru.wowhead.com/npc=122314/лура/эпохальный-журнал-сражений
local warnBacklash						= mod:NewTargetAnnounce(247816, 1, nil, "Healer") --Отдача
local warnNaarusLamen					= mod:NewTargetAnnounce(248535, 2) --Стенания наару
local warnGrowingDarkness				= mod:NewStackAnnounce(247915, 4, nil, nil, 2) --Разрастающийся мрак

local specWarnRemnantofAnguish			= mod:NewSpecialWarningYouMove(245242, nil, nil, nil, 1, 2) --Отголосок страдания
local specWarnBacklash					= mod:NewSpecialWarningMoreDamage(247816, "-Healer", nil, nil, 3, 2) --Отдача
local specWarnCalltoVoid				= mod:NewSpecialWarningSwitch(247795, "-Healer", nil, nil, 1, 2) --Воззвание к Бездне
local specWarnFragmentOfDespair			= mod:NewSpecialWarningSoak(245164, nil, nil, nil, 2, 3) --Частица отчаяния
local specWarnGrandShift				= mod:NewSpecialWarningDodge(249009, nil, nil, nil, 2, 3) --Масштабный рывок

local timerCalltoVoidCD					= mod:NewCDTimer(14.5, 247795, nil, nil, nil, 1, nil, DBM_CORE_TANK_ICON..DBM_CORE_DAMAGE_ICON) --Воззвание к Бездне
local timerGrandShiftCD					= mod:NewCDTimer(14.5, 249009, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON..DBM_CORE_MYTHIC_ICON) --Масштабный рывок +++
local timerUmbralCadenceCD				= mod:NewCDTimer(10.8, 247930, nil, nil, nil, 2, nil, DBM_CORE_HEALER_ICON) --Каденция Бездны +++
local timerBacklash						= mod:NewBuffActiveTimer(12, 247816, nil, nil, nil, 6, nil, DBM_CORE_DAMAGE_ICON) --Отдача +++
local timerBacklashCD					= mod:NewCDTimer(14, 247816, nil, nil, nil, 3, nil, DBM_CORE_DAMAGE_ICON) --Отдача +++
local timerFragmentOfDespairCD			= mod:NewCDTimer(18.5, 245164, nil, nil, nil, 3, nil, DBM_CORE_DAMAGE_ICON) --Частица отчаяния

local countdownBacklash					= mod:NewCountdown(14, 247816, nil, nil, 5) --Отдача
local countdownBacklash2				= mod:NewCountdownFades("Alt12", 247816, nil, nil, 5) --Отдача
local countdownGrandShift				= mod:NewCountdown(14.5, 249009, nil, nil, 5) --Масштабный рывок

mod.vb.phase = 1
mod.vb.wardens = 0
mod.vb.backlash = 0

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.wardens = 0
	self.vb.backlash = 0
	if not self:IsNormal() then
		timerFragmentOfDespairCD:Start(11)
	else
		timerFragmentOfDespairCD:Start(11)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 247795 then
		specWarnCalltoVoid:Schedule(1.5)
		specWarnCalltoVoid:Play("killmob")
		--timerCalltoVoidCD:Start()
	elseif spellId == 245164 and self:AntiSpam(3, 1) then
		specWarnFragmentOfDespair:Schedule(1.5)
		specWarnFragmentOfDespair:Play("helpsoak")
		timerFragmentOfDespairCD:Start()
	elseif spellId == 249009 then
		specWarnGrandShift:Show()
		specWarnGrandShift:Play("watchstep")
		timerGrandShiftCD:Start()
		countdownGrandShift:Start()
	elseif spellId == 247878 then --Вытягивание Бездны
		self.vb.wardens = self.vb.wardens + 1
		if self.vb.wardens == 1 then
			countdownBacklash:Start()
			timerBacklashCD:Start()
		elseif self.vb.wardens == 3 then
			countdownBacklash:Start()
			timerBacklashCD:Start()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 247930 then
		timerUmbralCadenceCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 247816 then --Отдача
		self.vb.backlash = self.vb.backlash + 1
		warnBacklash:Show(args.destName)
		specWarnBacklash:Show()
		timerBacklash:Start()
		countdownBacklash2:Start()
		if self.vb.backlash == 1 then
			timerCalltoVoidCD:Start(13) --Воззвание к Бездне
			timerFragmentOfDespairCD:Start(23) --Частица отчаяния
		elseif self.vb.backlash == 2 then
			timerUmbralCadenceCD:Start(23)
			if self:IsHard() then
				timerGrandShiftCD:Start(21) --Масштабный рывок
				countdownGrandShift:Start(21) --Масштабный рывок
			end
		end
	elseif spellId == 248535 then
		warnNaarusLamen:Show(args.destName)
	elseif spellId == 247915 then --Разрастающийся мрак
		local amount = args.amount or 1
		if amount >= 10 and amount % 5 == 0 then
			warnGrowingDarkness:Show(args.destName, amount)
		end
--[[	elseif spellId == 245242 then --Отголосок страдания
		if args:IsPlayer() then
			specWarnRemnantofAnguish:Show()
			specWarnRemnantofAnguish:Play("runaway")
		end]]
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 247816 then --Отдача
		timerBacklash:Stop()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 245242 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		if self:IsHard() then
			specWarnRemnantofAnguish:Show()
			specWarnRemnantofAnguish:Play("runaway")
		end
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
