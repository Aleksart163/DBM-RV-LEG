local mod	= DBM:NewMod("DHTTrash", "DBM-Party-Legion", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 198379 201226 200580",
	"SPELL_AURA_APPLIED 204243 225568",
	"SPELL_AURA_REMOVED 225568",
	"SPELL_PERIODIC_DAMAGE 200822",
	"SPELL_PERIODIC_MISSED 200822"
)
--Треш Чащи Темного Сердца
local warnCurseofIsolation				= mod:NewTargetAnnounce(225568, 3) --Проклятие уединения

local specWarnCurseofIsolation			= mod:NewSpecialWarningDispel(225568, "RemoveCurse", nil, nil, 1, 3) --Проклятие уединения
local specWarnCurseofIsolation2			= mod:NewSpecialWarningYou(225568, nil, nil, nil, 2, 3) --Проклятие уединения
local specWarnPrimalRampage				= mod:NewSpecialWarningDodge(198379, "Melee", nil, nil, 1, 2)
local specWarnBloodAssault				= mod:NewSpecialWarningDodge(201226, nil, nil, nil, 2, 2) --Кровавая атака
local specWarnMaddeningRoar				= mod:NewSpecialWarningDefensive(200580, nil, nil, nil, 3, 5) --Безумный рев
local specWarnRottingEarth				= mod:NewSpecialWarningYouMove(200822, nil, nil, nil, 1, 2) --Гниющая земля
local specWarnTormentingEye				= mod:NewSpecialWarningInterrupt(204243, "HasInterrupt", nil, nil, 1, 2) --Истязающий глаз

local yellCurseofIsolation				= mod:NewYell(225568, nil, nil, nil, "YELL") --Проклятие уединения

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 198379 then
		specWarnPrimalRampage:Show()
		specWarnPrimalRampage:Play("chargemove")
	elseif spellId == 201226 then --Кровавая атака
		if not self:IsNormal() then
			specWarnBloodAssault:Show()
			specWarnBloodAssault:Play("chargemove")
		end
	elseif spellId == 200580 and self:AntiSpam(3, 1) then --Безумный рев
		if self:IsHard() then
			specWarnMaddeningRoar:Show()
			specWarnMaddeningRoar:Play("defensive")
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 204243 and self:AntiSpam(3, 1) then --Истязающий глаз
		if not self:IsNormal() then
			specWarnTormentingEye:Show()
			specWarnTormentingEye:Play("kickcast")
		end
	elseif spellId == 225568 then --Проклятие уединения
		warnCurseofIsolation:CombinedShow(0.5, args.destName)
		if self:IsHard() then
			if args:IsPlayer() and self:IsTank() then
				specWarnCurseofIsolation2:Show()
				specWarnCurseofIsolation2:Play("watchstep")
				yellCurseofIsolation:Yell()
			else
				specWarnCurseofIsolation:Show(args.destName)
				specWarnCurseofIsolation:Play("dispelnow")
			end
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 200822 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		if not self:IsNormal() then
			specWarnRottingEarth:Show()
			specWarnRottingEarth:Play("runaway")
		end
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
