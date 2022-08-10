local mod	= DBM:NewMod("DHTTrash", "DBM-Party-Legion", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 201226 200580 200630",
	"SPELL_CAST_SUCCESS 201272",
	"SPELL_SUMMON 198910",
	"SPELL_AURA_APPLIED 204243 225568 198904",
	"SPELL_AURA_REMOVED 225568 198904",
	"SPELL_PERIODIC_DAMAGE 200822",
	"SPELL_PERIODIC_MISSED 200822"
)

--Треш Чащи Темного Сердца
local warnCurseofIsolation				= mod:NewTargetAnnounce(225568, 3) --Проклятие уединения
local warnPoisonSpear					= mod:NewTargetAnnounce(198904, 3) --Отравленное копье
local warnUnnervingScreech				= mod:NewCastAnnounce(200630, 4) --Ошеломляющий визг

local specWarnVileMushroom				= mod:NewSpecialWarningDodge(198910, nil, nil, nil, 2, 2) --Злогриб
local specWarnBloodBomb					= mod:NewSpecialWarningDodge(201272, nil, nil, nil, 2, 2) --Кровавая бомба
local specWarnCurseofIsolation			= mod:NewSpecialWarningDispel(225568, "RemoveCurse", nil, nil, 1, 3) --Проклятие уединения
local specWarnPoisonSpear				= mod:NewSpecialWarningDispel(198904, "RemovePoison", nil, nil, 1, 3) --Отравленное копье
local specWarnCurseofIsolation2			= mod:NewSpecialWarningYou(225568, nil, nil, nil, 2, 3) --Проклятие уединения
local specWarnPoisonSpear2				= mod:NewSpecialWarningYou(198904, nil, nil, nil, 2, 3) --Отравленное копье
local specWarnBloodAssault				= mod:NewSpecialWarningDodge(201226, nil, nil, nil, 2, 2) --Кровавая атака
local specWarnMaddeningRoar				= mod:NewSpecialWarningDefensive(200580, nil, nil, nil, 3, 5) --Безумный рев
local specWarnRottingEarth				= mod:NewSpecialWarningYouMove(200822, nil, nil, nil, 1, 2) --Гниющая земля
local specWarnTormentingEye				= mod:NewSpecialWarningInterrupt(204243, "HasInterrupt", nil, nil, 1, 2) --Истязающий глаз
local specWarnUnnervingScreech			= mod:NewSpecialWarningInterrupt(200630, "HasInterrupt", nil, nil, 1, 2) --Ошеломляющий визг

local timerVileMushroomCD				= mod:NewCDTimer(14, 198910, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Злогриб

local yellCurseofIsolation				= mod:NewYell(225568, nil, nil, nil, "YELL") --Проклятие уединения

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 201226 then --Кровавая атака
		if not self:IsNormal() then
			specWarnBloodAssault:Show()
			specWarnBloodAssault:Play("chargemove")
		end
	elseif spellId == 200580 then --Безумный рев
		if not self:IsNormal() and self:AntiSpam(2, 1) then
			specWarnMaddeningRoar:Show()
			specWarnMaddeningRoar:Play("defensive")
		end
	elseif spellId == 200630 and self:AntiSpam(2, 1) then --Ошеломляющий визг
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnUnnervingScreech:Show()
			specWarnUnnervingScreech:Play("kickcast")
		else
			warnUnnervingScreech:Show()
			warnUnnervingScreech:Play("kickcast")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 201272 then --Кровавая бомба
		if not self:IsNormal() then
			specWarnBloodBomb:Show()
			specWarnBloodBomb:Play("watchstep")
		end
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 198910 and self:AntiSpam(5, 1) then --Злогриб
		if not self:IsNormal() then
			specWarnVileMushroom:Show()
			specWarnVileMushroom:Play("watchstep")
			timerVileMushroomCD:Start()
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
	elseif spellId == 198904 then --Отравленное копье
		warnPoisonSpear:CombinedShow(0.5, args.destName)
		if self:IsHard() then
			if args:IsPlayer() then
				specWarnPoisonSpear2:Show()
				specWarnPoisonSpear2:Play("defensive")
			else
				specWarnPoisonSpear:CombinedShow(0.5, args.destName)
				specWarnPoisonSpear:Play("dispelnow")
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
