local mod	= DBM:NewMod("Ravenn", "DBM-WorldEvents", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17741 $"):sub(12, -3))
mod:SetCreatureID(700043)
mod:SetEncounterID(10000)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 183224 67729",
	"SPELL_AURA_APPLIED 28467 154769",
	"SPELL_AURA_APPLIED_DOSE 28467",
	"SPELL_AURA_REMOVED 154769",
	"SPELL_DAMAGE 93691",
	"SPELL_MISSED 93691",
	"SPELL_ABSORBED 93691",
	"UNIT_AURA player",
	"CHAT_MSG_MONSTER_YELL"
)

------------------------------------------
-- Всё прошляпанно Мурчалем Прошляпенко --
------------------------------------------
local warnExplode						= mod:NewCastAnnounce(67729, 4, nil, nil, "Ranged") --Взрыв
local warnMortalWound					= mod:NewStackAnnounce(28467, 2, nil, "Tank|Healer") --Смертельная рана
--local warnFixate						= mod:NewTargetAnnounce(154769, 2) --Сосредоточение внимания

local specWarnFixate					= mod:NewSpecialWarningYouRun(310042, nil, nil, nil, 4, 3) --Сосредоточение внимания
local specWarnFixate2					= mod:NewSpecialWarningEnd(310042, nil, nil, nil, 1, 2) --Сосредоточение внимания
local specWarnMortalWound				= mod:NewSpecialWarningStack(28467, nil, 5, nil, nil, 3, 6) --Смертельная рана
local specWarnMortalWound2				= mod:NewSpecialWarningTaunt(28467, nil, nil, nil, 3, 6) --Рассечение
local specWarnExplode					= mod:NewSpecialWarningDodge(67729, "Melee", nil, nil, 2, 3) --Взрыв
local specWarnDesecration				= mod:NewSpecialWarningYouMove(93691, nil, nil, nil, 1, 2) --Осквернение
local specWarnSummonDrudgeGhouls		= mod:NewSpecialWarningSwitch(70358, "Tank|Dps", nil, nil, 1, 2) --Призыв вурдалаков

local timerShadowBoltVolleyCD			= mod:NewCDTimer(12.1, 183224, nil, nil, nil, 2, nil, DBM_CORE_HEALER_ICON) --Залп стрел Тьмы
local timerSummonDrudgeGhoulsCD			= mod:NewCDTimer(38, 70358, nil, nil, nil, 1, nil, DBM_CORE_TANK_ICON..DBM_CORE_DAMAGE_ICON) --Призыв вурдалаков
local timerPumpkinCD					= mod:NewTimer(32, "MurchalProshlyapTimer", "Interface\\Icons\\Inv_misc_bag_28_halloween", nil, nil, 1, DBM_CORE_DAMAGE_ICON) --Призыв тыкв

local yellFixate						= mod:NewYell(244653, nil, nil, nil, "YELL") --Сосредоточение внимания

local countdownMurchalShlyap			= mod:NewCountdown("Alt32", 70358, nil, nil, 5)

--mod:AddSetIconOption("SetIconOnFixate", 154769, true, false, {4, 3, 2, 1})

mod.vb.MurchalItsOchkenProshlyapation = 0
local proshlyapationOfMurchal = DBM:GetSpellInfo(310042)
local murchalProshlyaping = false

function mod:OnCombatStart(delay)
	self.vb.MurchalItsOchkenProshlyapation = 0
--	timerShadowBoltVolleyCD:Start(12.5)
--	timerSummonDrudgeGhoulsCD:Start(31.5)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 183224 then --Залп стрел Тьмы
		timerShadowBoltVolleyCD:Start()
	elseif spellId == 67729 and self:AntiSpam(2, "Explode") then --Взрыв
		warnExplode:Show()
		specWarnExplode:Show()
		specWarnExplode:Play("watchstep")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 28467 then --Смертельная рана
		local amount = args.amount or 1
		if amount >= 5 then
			if args:IsPlayer() then
				specWarnMortalWound:Show(amount)
				specWarnMortalWound:Play("stackhigh")
			else
				local _, _, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
				local remaining
				if expireTime then
					remaining = expireTime-GetTime()
				end
				if not UnitIsDeadOrGhost("player") and (not remaining or remaining and remaining < 5) then
					specWarnMortalWound2:Show(args.destName)
					specWarnMortalWound2:Play("tauntboss")
				else
					warnMortalWound:Show(args.destName, amount)
				end
			end
		else
			warnMortalWound:Show(args.destName, amount)
		end
--[[	elseif spellId == 154769 then --Сосредоточение внимания
		self.vb.MurchalItsOchkenProshlyapation = self.vb.MurchalItsOchkenProshlyapation + 1
		if args:IsPlayer() then
			specWarnFixate:Show()
			specWarnFixate:Play("justrun")
			specWarnFixate:ScheduleVoice(1, "keepmove")
			yellFixate:Yell()
		else
			warnFixate:CombinedShow(0.5, args.destName)
		end
		if self.Options.SetIconOnFixate then
			self:SetIcon(args.destName, self.vb.MurchalItsOchkenProshlyapation)
		end]]
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

--[[
function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 154769 then --Сосредоточение внимания
		self.vb.MurchalItsOchkenProshlyapation = self.vb.MurchalItsOchkenProshlyapation - 1
		if args:IsPlayer() then
			specWarnFixate2:Show()
			specWarnFixate2:Play("end")
		end
		if self.Options.SetIconOnFixate then
			self:RemoveIcon(args.destName)
		end
	end
end]]

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 93691 and destGUID == UnitGUID("player") and self:AntiSpam(2, "Desecration") then --Осквернение
		specWarnDesecration:Show()
		specWarnDesecration:Play("runout")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE
mod.SPELL_ABSORBED = mod.SPELL_DAMAGE

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.MurchalProshlyap1 or msg == L.MurchalProshlyap2 then
		self:SendSync("MurchalProshlyapation")
	elseif msg == L.MurchalProshlyap3 then
		self:SendSync("MurchalProshlyapation2")
	end
end

do
	function mod:UNIT_AURA(uId)
		local proshlyap = UnitDebuff("player", proshlyapationOfMurchal)
		if proshlyap and not murchalProshlyaping then
			murchalProshlyaping = true
			specWarnFixate:Show()
			specWarnFixate:Play("justrun")
			specWarnFixate:ScheduleVoice(2, "keepmove")
			yellFixate:Yell()
		elseif not proshlyap and murchalProshlyaping then
			murchalProshlyaping = false
			specWarnFixate2:Show()
			specWarnFixate2:Play("end")
		end
	end
end

function mod:OnSync(msg)
	if msg == "MurchalProshlyapation" then
		if not UnitIsDeadOrGhost("player") then
			specWarnSummonDrudgeGhouls:Show()
			specWarnSummonDrudgeGhouls:Play("mobkill")
		end
		timerSummonDrudgeGhoulsCD:Start()
	elseif msg == "MurchalProshlyapation2" then
		timerPumpkinCD:Start()
	end
end
