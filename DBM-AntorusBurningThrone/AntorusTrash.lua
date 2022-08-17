local mod	= DBM:NewMod("AntorusTrash", "DBM-AntorusBurningThrone")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()
mod:SetUsedIcons(8, 7, 6, 5, 4, 3, 2, 1)
mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 246209 245807 246444 254500",
	"SPELL_CAST_SUCCESS 246664",
	"SPELL_AURA_APPLIED 252760 246692 253600 254122 249297 246199 254948 246698 244399 254509 257920 248757 252797 245770 246687",
	"SPELL_AURA_APPLIED_DOSE 257920 248757",
	"SPELL_AURA_REMOVED 252760 246692 254122 249297 253600 252797 245770 244399 254948 246687",
	"SPELL_PERIODIC_DAMAGE 246199",
	"SPELL_PERIODIC_MISSED 246199",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_DIED"
)

--АПТ трэш
local warnDecimation2					= mod:NewTargetAnnounce(246687, 4) --Децимация (доделать)
local warnDemolish						= mod:NewTargetAnnounce(252760, 4) --Разрушение
local warnCloudofConfuse				= mod:NewTargetAnnounce(254122, 4) --Облако растерянности
local warnFlamesofReorig				= mod:NewTargetAnnounce(249297, 4, nil, false, 2) --Пламя пересоздания Can be spammy if handled poorly
local warnSoulburn						= mod:NewTargetAnnounce(253600, 3) --Горящая душа
--Крушитель Кин'гарота
local specWarnDecimation				= mod:NewSpecialWarningYouMoveAway(246687, nil, nil, nil, 4, 3) --Децимация
local specWarnDecimation2				= mod:NewSpecialWarningDodge(246687, "-Tank", nil, nil, 2, 2) --Децимация
--Темный хранитель Эйдис
local specWarnSearingSlash				= mod:NewSpecialWarningDodge(246444, "Melee", nil, nil, 2, 2) --Обжигающий удар
local specWarnPunishingFlame			= mod:NewSpecialWarningRun(246209, "Melee", nil, nil, 4, 3) --Наказующее пламя
local specWarnPunishingFlame2			= mod:NewSpecialWarningDodge(246209, "Ranged", nil, nil, 2, 3) --Наказующее пламя
local specWarnBurningWinds				= mod:NewSpecialWarningYouMove(246199, nil, nil, nil, 1, 2) --Горящие ветра
--Император Деконикс
local specWarnFearsomeLeap				= mod:NewSpecialWarningDodge(254500, nil, nil, nil, 2, 3) --Ужасающий прыжок
local specWarnBladestorm				= mod:NewSpecialWarningDodge(254509, nil, nil, nil, 2, 3) --Вихрь клинков
local specWarnFelTorch					= mod:NewSpecialWarningStack(257920, nil, 15, nil, nil, 1, 2) --Факел Скверны
--Клобекс
local specWarnPyrogenics				= mod:NewSpecialWarningDispel(248757, "MagicDispeller", nil, nil, 1, 3) --Пирогенез
--
local specWarnDemolish					= mod:NewSpecialWarningYouShare(252760, nil, nil, nil, 3, 5) --Разрушение
local specWarnCloudofConfuse			= mod:NewSpecialWarningYouMoveAway(254122, nil, nil, nil, 3, 3) --Облако растерянности
local specWarnCloudofConfuse2			= mod:NewSpecialWarningCloseMoveAway(254122, nil, nil, nil, 2, 3) --Облако растерянности
local specWarnFlamesofReorig			= mod:NewSpecialWarningYouMoveAway(249297, nil, nil, nil, 3, 5) --Пламя пересоздания
local specWarnSoulburn					= mod:NewSpecialWarningYouMoveAway(253600, nil, nil, nil, 3, 5) --Горящая душа
local specWarnSoulburn2					= mod:NewSpecialWarningDispel(253600, "MagicDispeller2", nil, nil, 1, 3) --Горящая душа
local specWarnAnnihilation				= mod:NewSpecialWarningSoak(245807, nil, nil, nil, 2, 2) --Аннигиляция
--local specWarnShadowBoltVolley		= mod:NewSpecialWarningInterrupt(243171, "HasInterrupt", nil, nil, 1, 2)
local timerSearingSlashCD				= mod:NewCDTimer(32, 246444, nil, nil, nil, 3, nil, DBM_CORE_TANK_ICON) --Обжигающий удар
local timerPunishingFlameCD				= mod:NewCDTimer(20, 246209, nil, "Melee", nil, 2, nil, DBM_CORE_DEADLY_ICON) --Наказующее пламя

local timerCloudofConfuse				= mod:NewTargetTimer(10, 254122, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON..DBM_CORE_DEADLY_ICON) --Облако растерянности
local timerRoleplay						= mod:NewTimer(30, "timerRoleplay", "Interface\\Icons\\Spell_Holy_BorrowedTime", nil, nil, 7) --Ролевая игра

local yellDecimation					= mod:NewYell(246687, nil, nil, nil, "YELL") --Децимация
local yellDecimationFades				= mod:NewShortFadesYell(246687, nil, nil, nil, "YELL") --Децимация
local yellDemolish						= mod:NewYell(252760, nil, nil, nil, "YELL") --Разрушение
local yellDemolishFades					= mod:NewFadesYell(252760, nil, nil, nil, "YELL") --Разрушение
local yellCloudofConfuse				= mod:NewYell(254122, nil, nil, nil, "YELL") --Облако растерянности
local yellCloudofConfuseFades			= mod:NewShortFadesYell(254122, nil, nil, nil, "YELL") --Облако растерянности
local yellFlamesofReorig				= mod:NewYell(249297, nil, nil, nil, "YELL") --Пламя пересоздания
local yellFlamesofReorig2				= mod:NewFadesYell(249297, nil, nil, nil, "YELL") --Пламя пересоздания
local yellSoulburn						= mod:NewYell(253600, nil, nil, nil, "YELL") --Горящая душа
local yellSoulburn2						= mod:NewFadesYell(253600, nil, nil, nil, "YELL") --Горящая душа

mod:AddSetIconOption("SetIconOnCloudofConfuse", 254122, true, false, {8}) --Облако растерянности
mod:AddSetIconOption("SetIconOnFlamesofReorig", 249297, true, false, {3}) --Пламя пересоздания
mod:AddSetIconOption("SetIconOnSoulburn", 253600, true, false, {8, 7, 6, 5, 4}) --Горящая душа
mod:AddSetIconOption("SetIconOnDemolish", 252760, true, false, {8, 7, 6}) --Разрушение
mod:AddSetIconOption("SetIconOnDecimation", 246687, true, false, {5, 4, 3, 2, 1}) --Децимация
mod:AddRangeFrameOption(10, 249297) --Пламя пересоздания

mod.vb.demolishIcon = 6
mod.vb.decimationIcon = 1
mod.vb.soulburnIcon = 8

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 246209 then
		specWarnPunishingFlame:Show()
		specWarnPunishingFlame:Play("justrun")
		specWarnPunishingFlame2:Show()
		specWarnPunishingFlame2:Play("justrun")
		if self:IsHeroic() then
			timerPunishingFlameCD:Start()
		else
			timerPunishingFlameCD:Start()
		end
	elseif spellId == 245807 and self:AntiSpam(5, 1) then
		specWarnAnnihilation:Show()
		specWarnAnnihilation:Play("helpsoak")
	elseif spellId == 246444 then --Обжигающий удар
		specWarnSearingSlash:Show()
		if self:IsHeroic() then
			timerSearingSlashCD:Start(33.5)
		else
			timerSearingSlashCD:Start()
		end
	elseif spellId == 254500 then --Ужасающий прыжок
		specWarnFearsomeLeap:Show()
		specWarnFearsomeLeap:Play("watchstep")
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	
	end
end]]

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 252760 or spellId == 246692 or spellId == 246698 then --Разрушение
		self.vb.demolishIcon = self.vb.demolishIcon + 1
		warnDemolish:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnDemolish:Show()
			specWarnDemolish:Play("targetyou")
			yellDemolish:Yell()
			yellDemolishFades:Countdown(6, 3)
		end
		if self.Options.SetIconOnDemolish then
			self:SetIcon(args.destName, self.vb.demolishIcon)
		end
		if self.vb.demolishIcon == 8 then
			self.vb.demolishIcon = 6
		end
	elseif spellId == 254122 then --Облако растерянности
		timerCloudofConfuse:Start(args.destName)
		if args:IsPlayer() then
			specWarnCloudofConfuse:Show()
			specWarnDemolish:Play("runout")
			yellCloudofConfuse:Yell()
			yellCloudofConfuseFades:Countdown(10, 3)
		elseif self:CheckNearby(20, args.destName) then
			warnCloudofConfuse:CombinedShow(0.3, args.destName)
			specWarnCloudofConfuse2:CombinedShow(0.3, args.destName)
		else
			warnCloudofConfuse:CombinedShow(0.3, args.destName)
		end
		if self.Options.SetIconOnCloudofConfuse then
			self:SetIcon(args.destName, 8, 10)
		end
	elseif spellId == 253600 then
		self.vb.soulburnIcon = self.vb.soulburnIcon - 1
		warnSoulburn:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnSoulburn:Show()
			specWarnSoulburn:Play("runout")
			yellSoulburn:Yell()
			yellSoulburn2:Countdown(6, 3)
		else
			specWarnSoulburn2:CombinedShow(0.3, args.destName)
			specWarnSoulburn2:Play("dispelnow")
		end
		if self.Options.SetIconOnSoulburn then
			self:SetIcon(args.destName, self.vb.soulburnIcon)
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(8)
		end
		if self.vb.soulburnIcon == 4 then
			self.vb.soulburnIcon = 8
		end
	elseif spellId == 249297 then
		warnFlamesofReorig:CombinedShow(0.5, args.destName)
		if args:IsPlayer() and self:AntiSpam(5, 2) then
			specWarnFlamesofReorig:Show()
			specWarnFlamesofReorig:Play("runout")
			yellFlamesofReorig:Yell()
			yellFlamesofReorig2:Countdown(6, 3)
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10)
			end
		end
		if self.Options.SetIconOnFlamesofReorig then
			self:SetIcon(args.destName, 3, 6)
		end
	elseif spellId == 245770 or spellId == 252797 or spellId == 244399 or spellId == 254948 or spellId == 246687 then --Децимация
		self.vb.decimationIcon = self.vb.decimationIcon + 1
		warnDecimation2:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnDecimation:Show()
			specWarnDecimation:Play("runout")
			yellDecimation:Yell()
			yellDecimationFades:Countdown(5, 3)
		elseif self:AntiSpam(5, 1) then
			specWarnDecimation2:Schedule(6)
		end
		if self.Options.SetIconOnDecimation then
			self:SetIcon(args.destName, self.vb.decimationIcon)
		end
		if self.vb.decimationIcon == 5 then
			self.vb.decimationIcon = 1
		end
	elseif spellId == 254509 then --Вихрь клинков
		specWarnBladestorm:Show()
		specWarnBladestorm:Play("watchstep")
	elseif spellId == 257920 then --Факел Скверны
		local amount = args.amount or 1
		if args:IsPlayer() and not self:IsTank() then
			if amount >= 15 and amount % 5 == 0 then
				specWarnFelTorch:Show(amount)
				specWarnFelTorch:Play("stackhigh")
			end
		end
	elseif spellId == 248757 then --Пирогенез
		local amount = args.amount or 1
		if amount >= 2 then
			specWarnPyrogenics:Show(args.destName)
			specWarnPyrogenics:Play("dispelnow")
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 252760 or spellId == 246692 or spellId == 246698 then --Разрушение
	--	self.vb.demolishIcon = self.vb.demolishIcon - 1
		if args:IsPlayer() then
			yellDemolishFades:Cancel()
		end
		if self.Options.SetIconOnDemolish then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 254122 then --Облако растерянности
		timerCloudofConfuse:Cancel(args.destName)
		if args:IsPlayer() then
			yellCloudofConfuseFades:Cancel()
		end
		if self.Options.SetIconOnCloudofConfuse then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 249297 then --Пламя пересоздания
		if args:IsPlayer() then
			yellFlamesofReorig2:Cancel()
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
		if self.Options.SetIconOnFlamesofReorig then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 253600 then --Горящая душа
		if args:IsPlayer() then
			yellSoulburn2:Cancel()
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
		if self.Options.SetIconOnSoulburn then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 245770 or spellId == 252797 or spellId == 244399 or spellId == 254948 or spellId == 246687 then --Децимация
	--	self.vb.decimationIcon = self.vb.decimationIcon - 1
		if args:IsPlayer() then
			yellDecimationFades:Cancel()
		end
		if self.Options.SetIconOnDecimation then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 246199 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnBurningWinds:Show()
		specWarnBurningWinds:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:OnSync(msg)
	if msg == "RPImonar" then
		timerRoleplay:Start(24.5)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.RPImonar then
		self:SendSync("RPImonar")
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 123921 then --Крушитель Кин'гарота
		specWarnDecimation2:Cancel(args.sourceGUID)
	elseif cid == 123680 then --Темный хранитель Эйдис
		timerSearingSlashCD:Cancel()
		timerPunishingFlameCD:Cancel()
	end
end
