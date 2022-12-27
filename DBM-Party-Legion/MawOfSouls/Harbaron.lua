local mod	= DBM:NewMod(1512, "DBM-Party-Legion", 8, 727)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(96754)
mod:SetEncounterID(1823)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 194327",
--	"SPELL_AURA_REMOVED 194327",
	"SPELL_CAST_START 194231 194266 194216 194325",
	"SPELL_CAST_SUCCESS 194325",
	"SPELL_PERIODIC_DAMAGE 194235",
	"SPELL_PERIODIC_MISSED 194235"
)

--Харбарон https://ru.wowhead.com/npc=96754/харбарон/эпохальный-журнал-сражений
local warnFragment				= mod:NewTargetAnnounce(194327, 3) --Разделение
local warnVoidSnap				= mod:NewCastAnnounce(194266, 4) --Хватка Бездны

local specWarnNetherRip			= mod:NewSpecialWarningYouMove(194235, nil, nil, nil, 1, 2) --Разрыв пустоты
local specWarnFragment			= mod:NewSpecialWarningSwitch(194327, "-Healer", nil, nil, 1, 2) --Разделение
local specWarnFragment2			= mod:NewSpecialWarningYouDefensive(194327, nil, nil, nil, 3, 5) --Разделение
local specWarnServitor			= mod:NewSpecialWarningSwitch(194231, "-Healer", nil, nil, 1, 2) --Призыв скованного прислужника
local specWarnVoidSnap			= mod:NewSpecialWarningInterrupt(194266, "HasInterrupt", nil, nil, 1, 2) --Хватка Бездны
local specWarnScythe			= mod:NewSpecialWarningDodge(194216, nil, nil, nil, 2, 3) --Космическая коса

local timerFragmentCD			= mod:NewCDTimer(30, 194327, nil, nil, nil, 7) --Разделение
local timerServitorCD			= mod:NewCDTimer(23, 194231, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON) --Призыв скованного прислужника 23-30 

local yellFragment				= mod:NewYell(194327, nil, nil, nil, "YELL") --Разделение

function mod:FragmentTarget(targetname, uId) --Прошляпанное очко Прошляпенко (Мурчаля) (✔✔✔)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnFragment2:Show()
		specWarnFragment2:Play("targetyou")
		yellFragment:Yell()
	else
		warnFragment:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	timerServitorCD:Start(7-delay)
	timerFragmentCD:Start(19-delay)
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 194327 then --Разделение
		if not UnitIsDeadOrGhost("player") then
			specWarnFragment:Show()
			specWarnFragment:Play("mobkill")
		end
	end
end

--[[
function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 194327 then

	end
end
--]]

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 194231 then --Призыв скованного прислужника
		if not UnitIsDeadOrGhost("player") then
			specWarnServitor:Show()
			specWarnServitor:Play("bigmob")
		end
		if self:IsHard() then
			timerServitorCD:Start(28)
		else
			timerServitorCD:Start()
		end
	elseif spellId == 194266 then --Хватка Бездны
		warnVoidSnap:Show()
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnVoidSnap:Show()
			specWarnVoidSnap:Play("kickcast")
		else
			specWarnVoidSnap:Show()
			specWarnVoidSnap:Play("kickcast")
		end
	elseif spellId == 194216 then --Космическая коса
		if not UnitIsDeadOrGhost("player") then
			specWarnScythe:Show()
			specWarnScythe:Play("shockwave")
		end
	elseif spellId == 194325 then --Разделение
		self:BossTargetScanner(args.sourceGUID, "FragmentTarget", 0.1, 2)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 194325 then
		if self:IsHard() then
			timerFragmentCD:Start(37.5)
		else
			timerFragmentCD:Start()
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 194235 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		if not self:IsNormal() then
			specWarnNetherRip:Show()
			specWarnNetherRip:Play("runaway")
		end
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
