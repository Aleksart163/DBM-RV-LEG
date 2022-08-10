local mod	= DBM:NewMod(1502, "DBM-Party-Legion", 8, 727)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(96756)
mod:SetEncounterID(1822)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 193211 193364 193977 193460 193566"
)

--Имирон, падший король https://ru.wowhead.com/npc=96756/имирон-падший-король/эпохальный-журнал-сражений
local warnBane						= mod:NewSpellAnnounce(193460, 3) --Погибель

local specWarnBane					= mod:NewSpecialWarningDodge(193460, nil, nil, nil, 2, 2) --Погибель
local specWarnDarkSlash				= mod:NewSpecialWarningDefensive(193211, "Tank", nil, nil, 3, 3) --Черная рана
local specWarnScreams				= mod:NewSpecialWarningRun(193364, "Melee", nil, nil, 4, 3) --Крики мертвых
local specWarnWinds					= mod:NewSpecialWarningDefensive(193977, nil, nil, nil, 2, 3) --Ветра Нордскола
local specAriseFallen				= mod:NewSpecialWarningSwitch(193566, "-Healer", nil, nil, 1, 2) --Восстань, павший

local timerDarkSlashCD				= mod:NewCDTimer(14.6, 193211, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON) --Черная рана
local timerScreamsCD				= mod:NewCDTimer(23, 193364, nil, "Melee", nil, 2) --Крики мертвых
local timerWindsCD					= mod:NewCDTimer(24, 193977, nil, nil, nil, 2) --Ветра Нордскола
local timerBaneCD					= mod:NewCDTimer(49.5, 193460, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Погибель
local timerAriseFallenCD			= mod:NewCDTimer(19, 193566, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON) --Восстань, павший +1сек

local countdownDarkSlash			= mod:NewCountdown("AltTwo14.6", 193211, "Tank", nil, 5) --Черная рана
local countdownAriseFallen			= mod:NewCountdown(19, 193566, "-Healer", nil, 5) --Восстань, павший

function mod:OnCombatStart(delay)
	countdownDarkSlash:Start(4-delay) --Черная рана
	timerDarkSlashCD:Start(4-delay) --Черная рана +0.5сек
	timerScreamsCD:Start(7-delay) --Крики мертвых +1сек
	timerWindsCD:Start(16-delay) --Ветра Нордскола +1сек
	timerBaneCD:Start(22-delay) --Погибель +1сек
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 193211 then
		specWarnDarkSlash:Show()
		specWarnDarkSlash:Play("defensive")
		if self:IsHard() then
			timerDarkSlashCD:Start(16)
			countdownDarkSlash:Start(16)
		else
			timerDarkSlashCD:Start()
			countdownDarkSlash:Start()
		end
	elseif spellId == 193364 then
		specWarnScreams:Show()
		specWarnScreams:Play("runout")
		if self:IsHard() then
			timerScreamsCD:Start(31.5)
		else
			timerScreamsCD:Start()
		end
	elseif spellId == 193977 then
		specWarnWinds:Show()
		specWarnWinds:Play("carefly")
		if self:IsHard() then
			timerWindsCD:Start(29.5)
		else
			timerWindsCD:Start()
		end
	elseif spellId == 193460 then
		warnBane:Show()
		specWarnBane:Show()
		if self:IsHard() then
			timerBaneCD:Start(64)
		else
			timerBaneCD:Start()
		end
		if not self:IsNormal() then
			timerAriseFallenCD:Start()
			countdownAriseFallen:Start()
		end
	elseif spellId == 193566 then
		specAriseFallen:Show()
		specAriseFallen:Play("mobkill")
	end
end
