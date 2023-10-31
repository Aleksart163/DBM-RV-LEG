local mod	= DBM:NewMod("Ravenn", "DBM-WorldEvents", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17740 $"):sub(12, -3))
mod:SetCreatureID(700043)
--mod:SetModelID(23447)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 183224 67729",
	"SPELL_DAMAGE 67781",
	"SPELL_MISSED 67781",
	"SPELL_ABSORBED 67781",
	"CHAT_MSG_MONSTER_YELL"
)

local warnExplode						= mod:NewCastAnnounce(67729, 4, nil, nil, "Ranged") --Взрыв
local warnShadowBoltVolley				= mod:NewCastAnnounce(183224, 2) --Залп стрел Тьмы

local specWarnExplode					= mod:NewSpecialWarningDodge(67729, "Melee", nil, nil, 2, 3) --Взрыв
local specWarnDesecration				= mod:NewSpecialWarningYouMove(67781, nil, nil, nil, 1, 2) --Осквернение
local specWarnSummonDrudgeGhouls		= mod:NewSpecialWarningSwitch(70358, "Tank|Dps", nil, nil, 1, 2) --Призыв вурдалаков

local timerShadowBoltVolleyCD			= mod:NewCDTimer(12.3, 183224, nil, nil, nil, 2, nil, DBM_CORE_HEALER_ICON) --Залп стрел Тьмы
local timerSummonDrudgeGhoulsCD			= mod:NewCDTimer(30, 70358, nil, nil, nil, 1, nil, DBM_CORE_TANK_ICON..DBM_CORE_DAMAGE_ICON) --Призыв вурдалаков
local timerPumpkinCD					= mod:NewTimer(35, "MurchalProshlyapTimer", "Interface\\Icons\\Inv_misc_bag_28_halloween", nil, nil, 1, DBM_CORE_DAMAGE_ICON)

function mod:OnCombatStart(delay)
--	timerShadowBoltVolleyCD:Start(12.5)
--	timerSummonDrudgeGhoulsCD:Start(31.5)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 183224 then --Залп стрел Тьмы
		warnShadowBoltVolley:Show()
		timerShadowBoltVolleyCD:Start()
	elseif spellId == 67729 and self:AntiSpam(2, "Explode") then --Взрыв
		warnExplode:Show()
		specWarnExplode:Show()
		specWarnExplode:Play("watchstep")
	end
end
function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 67781 and destGUID == UnitGUID("player") and self:AntiSpam(3, "Desecration") then --Осквернение
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

function mod:OnSync(msg)
	if msg == "MurchalProshlyapation" then
		if not UnitIsDeadOrGhost("player") then
			specWarnSummonDrudgeGhouls:Show()
			specWarnSummonDrudgeGhouls:Play("mobkill")
		end
		timerSummonDrudgeGhoulsCD:Start(42)
	elseif msg == "MurchalProshlyapation2" then
		timerPumpkinCD:Start()
	end
end
