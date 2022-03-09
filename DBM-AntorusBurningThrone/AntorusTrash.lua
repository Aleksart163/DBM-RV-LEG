local mod	= DBM:NewMod("AntorusTrash", "DBM-AntorusBurningThrone")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()
mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 246209 245807",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 252760 253600 254122 249297 246199",
--	"SPELL_AURA_APPLIED_DOSE"
	"SPELL_AURA_REMOVED 252760 254122 249297"
)

--TODO, these
				--"Annihilation-252740-npc:127230 = pull:9.5", -- [1]
				--"Decimation-252793-npc:127231 = pull:10.9, 0.0", -- [2]
local warnDecimation2					= mod:NewTargetAnnounce(246687, 4) --Децимация (доделать)
local warnDemolish						= mod:NewTargetAnnounce(252760, 4) --Разрушение
local warnCloudofConfuse				= mod:NewTargetAnnounce(254122, 4) --Облако растерянности
local warnFlamesofReorig				= mod:NewTargetAnnounce(249297, 4, nil, false, 2) --Пламя пересоздания Can be spammy if handled poorly
local warnSoulburn						= mod:NewTargetAnnounce(253600, 3) --Горящая душа

local specWarnBurningWinds				= mod:NewSpecialWarningYouMove(246199, nil, nil, nil, 1, 2) --Горящие ветра
local specWarnDemolish					= mod:NewSpecialWarningYouShare(252760, nil, nil, nil, 3, 2) --Разрушение
local specWarnCloudofConfuse			= mod:NewSpecialWarningYouMoveAway(254122, nil, nil, nil, 1, 2) --Облако растерянности
local specWarnFlamesofReorig			= mod:NewSpecialWarningYouMoveAway(249297, nil, nil, nil, 3, 5) --Пламя пересоздания
local specWarnSoulburn					= mod:NewSpecialWarningMoveAway(253600, nil, nil, nil, 3, 5) --Горящая душа
local specWarnPunishingFlame			= mod:NewSpecialWarningRun(246209, "Melee", nil, nil, 4, 2) --Наказующее пламя
local specWarnAnnihilation				= mod:NewSpecialWarningSoak(245807, nil, nil, nil, 2, 2) --Аннигиляция
--local specWarnShadowBoltVolley		= mod:NewSpecialWarningInterrupt(243171, "HasInterrupt", nil, nil, 1, 2)
local yellDemolish						= mod:NewYell(252760, nil, nil, nil, "YELL") --Разрушение
local yellDemolishFades					= mod:NewShortFadesYell(252760, nil, nil, nil, "YELL") --Разрушение
local yellCloudofConfuse				= mod:NewYell(254122, nil, nil, nil, "YELL") --Облако растерянности
local yellCloudofConfuseFades			= mod:NewShortFadesYell(254122, nil, nil, nil, "YELL") --Облако растерянности
local yellFlamesofReorig				= mod:NewYell(249297, nil, nil, nil, "YELL") --Пламя пересоздания
local yellSoulburn						= mod:NewYell(253600, nil, nil, nil, "YELL") --Горящая душа

mod:AddRangeFrameOption(10, 249297) --Пламя пересоздания

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 246209 then
		specWarnPunishingFlame:Show()
		specWarnPunishingFlame:Play("justrun")
	elseif spellId == 245807 and self:AntiSpam(5, 1) then
		specWarnAnnihilation:Show()
		specWarnAnnihilation:Play("helpsoak")
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 241360 then

	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 252760 then
		warnDemolish:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnDemolish:Show()
			specWarnDemolish:Play("targetyou")
			yellDemolish:Yell()
			local _, _, _, _, _, _, expires = DBM:UnitDebuff("player", spellId)
			local remaining = expires-GetTime()
			yellDemolishFades:Countdown(remaining)
		end
	elseif spellId == 254122 then
		warnCloudofConfuse:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnCloudofConfuse:Show()
			specWarnDemolish:Play("runout")
			yellCloudofConfuse:Yell()
			local _, _, _, _, _, _, expires = DBM:UnitDebuff("player", spellId)
			local remaining = expires-GetTime()
			yellCloudofConfuseFades:Countdown(remaining)
		end
	elseif spellId == 253600 then
		warnSoulburn:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnSoulburn:Show()
			specWarnSoulburn:Play("runout")
			yellSoulburn:Yell()
		end
	elseif spellId == 249297 then
		warnFlamesofReorig:CombinedShow(0.5, args.destName)
		if args:IsPlayer() and self:AntiSpam(5, 2) then
			specWarnFlamesofReorig:Show()
			specWarnFlamesofReorig:Play("runout")
			yellFlamesofReorig:Yell()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10)
			end
		end
	elseif spellId == 246199 then --Горящие ветра
		if args:IsPlayer() then
			specWarnBurningWinds:Show()
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 252760 then
		if args:IsPlayer() then
			yellDemolishFades:Cancel()
		end
	elseif spellId == 254122 then
		if args:IsPlayer() then
			yellCloudofConfuseFades:Cancel()
		end
	elseif spellId == 249297 then
		if args:IsPlayer() and self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	end
end
