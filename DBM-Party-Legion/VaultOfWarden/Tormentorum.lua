local mod	= DBM:NewMod(1695, "DBM-Party-Legion", 10, 707)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
mod:SetCreatureID(96015)
mod:SetEncounterID(1850)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 201488 200898",
	"SPELL_CAST_SUCCESS 200905 206303",
	"SPELL_AURA_APPLIED 212564 203685 202455",
	"SPELL_AURA_APPLIED_DOSE 203685",
	"SPELL_AURA_REMOVED 202455",
	"UNIT_SPELLCAST_SUCCEEDED boss1",
	"UNIT_HEALTH"
)

--Инквизитор Истязарий https://ru.wowhead.com/npc=96015/инквизитор-истязарий/эпохальный-журнал-сражений
local warnTeleport				= mod:NewSpellAnnounce(200898, 2) --Телепортация
local warnTeleport2				= mod:NewSoonAnnounce(200898, 1) --Телепортация

local specWarnVoidShield		= mod:NewSpecialWarningReflect(202455, "Dps|Tank", nil, nil, 1, 2) --Щит Бездны
local specWarnVoidShield2		= mod:NewSpecialWarningEnd(202455, nil, nil, nil, 1, 2) --Щит Бездны
local specWarnFleshtoStone		= mod:NewSpecialWarningStack(203685, nil, 7, nil, nil, 1, 3) --Из плоти в камень
local specWarnFleshtoStone2		= mod:NewSpecialWarningDispel(203685, "MagicDispeller2", nil, nil, 3, 3) --Из плоти в камень
local specWarnSapSoul			= mod:NewSpecialWarningInterrupt(200905, "HasInterrupt", nil, nil, 1, 2) --Опустошение души
local specWarnSapSoulHard		= mod:NewSpecialWarningCast(200905, nil, nil, nil, 1, 2) --Опустошение души
local specWarnFear				= mod:NewSpecialWarningSpell(201488, nil, nil, nil, 2, 2) --Пугающий вопль
local specWarnStare				= mod:NewSpecialWarningYouLook(212564, nil, nil, nil, 3, 6) --Пытливый взгляд

local timerSapSoulCD			= mod:NewCDTimer(21.5, 200905, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON) --Опустошение души
local timerTormOrbCD			= mod:NewNextTimer(15, 212567, nil, nil, nil, 7) --Призыв сферы истязания

local countSapSoul				= mod:NewCountdown(21.5, 200905, true, 2, 5) --Опустошение души

mod.vb.phase = 1
local warned_preP1 = false
local warned_preP2 = false
local warned_preP3 = false
local warned_preP4 = false

local function UpdateSapSoulTimer(self)
	countSapSoul:Cancel()
	timerSapSoulCD:Stop()
	countSapSoul:Start(6.5)
	timerSapSoulCD:Start(6.5)
end

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	if not self:IsNormal() then
		timerTormOrbCD:Start(24-delay) --Призыв сферы истязания
		timerSapSoulCD:Start(12-delay) --Опустошение души+++
		countSapSoul:Start(12-delay) --Опустошение души+++
	else
		timerSapSoulCD:Start(13-delay) --Опустошение души
		countSapSoul:Start(13-delay) --Опустошение души
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 201488 then
		if not UnitIsDeadOrGhost("player") then
			specWarnFear:Show()
			specWarnFear:Play("fearsoon")
		end
	elseif spellId == 200898 then --Телепортация
		warnTeleport:Show()
		if timerSapSoulCD:GetTime() < 6 then
			UpdateSapSoulTimer(self)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if args.spellId == 200905 or spellId == 206303 then
		countSapSoul:Cancel()--Just in case
		if self:IsHard() then--Mythic and mythic + only
			if not UnitIsDeadOrGhost("player") then
				specWarnSapSoulHard:Show()
				specWarnSapSoulHard:Play("stopcast")
			end
			timerSapSoulCD:Start(15.4)
			countSapSoul:Start(15.4)
		else--Everything else
			if not UnitIsDeadOrGhost("player") then
				specWarnSapSoul:Show()
				specWarnSapSoul:Play("kickcast")
			end
			timerSapSoulCD:Start()
			countSapSoul:Start()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 212564 then --Пытливый взгляд
		if args:IsPlayer() and self:AntiSpam(2.5, 1) then
			specWarnStare:Show(L.lookSphere)
			specWarnStare:Play("turnaway")
		end
	elseif spellId == 203685 and args:IsDestTypePlayer() then --Из плоти в камень
		local amount = args.amount or 1
		if amount >= 7 then
			if args:IsPlayer() then
				specWarnFleshtoStone:Show(amount)
				specWarnFleshtoStone:Play("stackhigh")
			else
				if not UnitIsDeadOrGhost("player") then
					specWarnFleshtoStone2:CombinedShow(0.5, args.destName)
					specWarnFleshtoStone2:ScheduleVoice(0.5, "dispelnow")
				end
			end
		end
	elseif spellId == 202455 then --Щит Бездны
		specWarnVoidShield:Show(args.destName)
		specWarnVoidShield:Play("stopattack")
	end	
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 202455 then --Щит Бездны
		specWarnVoidShield2:Show()
		specWarnVoidShield2:Play("end")
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 214970 then--Summon Tormenting Orb
		timerTormOrbCD:Start()
	end
end

function mod:UNIT_HEALTH(uId)
	if self:IsHard() then --миф и миф+
		if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 96015 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.81 then
			warned_preP1 = true
			warnTeleport2:Show()
		elseif self.vb.phase == 1 and warned_preP1 and not warned_preP2 and self:GetUnitCreatureId(uId) == 96015 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.71 then
			self.vb.phase = 2
			warned_preP2 = true
		elseif self.vb.phase == 2 and warned_preP2 and not warned_preP3 and self:GetUnitCreatureId(uId) == 96015 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.51 then
			warned_preP3 = true
			warnTeleport2:Show()
		elseif self.vb.phase == 2 and warned_preP3 and not warned_preP4 and self:GetUnitCreatureId(uId) == 96015 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.41 then
			self.vb.phase = 3
			warned_preP4 = true
		end
	else
		if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 96015 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.81 then
			warned_preP1 = true
		elseif self.vb.phase == 1 and warned_preP1 and not warned_preP2 and self:GetUnitCreatureId(uId) == 96015 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.71 then
			self.vb.phase = 2
			warned_preP2 = true
		elseif self.vb.phase == 2 and warned_preP2 and not warned_preP3 and self:GetUnitCreatureId(uId) == 96015 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.51 then
			warned_preP3 = true
		elseif self.vb.phase == 2 and warned_preP3 and not warned_preP4 and self:GetUnitCreatureId(uId) == 96015 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.41 then
			self.vb.phase = 3
			warned_preP4 = true
		end
	end
end
