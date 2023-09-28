local mod	= DBM:NewMod(1502, "DBM-Party-Legion", 8, 727)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
mod:SetCreatureID(96756)
mod:SetEncounterID(1822)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 193211 193364 193977 193460 193566",
	"SPELL_CAST_SUCCESS 193460",
	"SPELL_AURA_APPLIED 193364"
)

--Имирон, падший король https://ru.wowhead.com/npc=96756/имирон-падший-король/эпохальный-журнал-сражений
local warnBane						= mod:NewSpellAnnounce(193460, 3) --Погибель
local warnScreams					= mod:NewTargetAnnounce(193364, 2) --Крики мертвых
local warnDarkSlash					= mod:NewTargetAnnounce(193211, 4) --Черная рана

local specWarnBane					= mod:NewSpecialWarningDodge(193460, nil, nil, nil, 2, 2) --Погибель
local specWarnDarkSlash				= mod:NewSpecialWarningDefensive(193211, nil, nil, nil, 3, 6) --Черная рана
local specWarnScreams				= mod:NewSpecialWarningRun(193364, "Melee", nil, nil, 4, 3) --Крики мертвых
local specWarnScreams2				= mod:NewSpecialWarningDodge(193364, "-Melee", nil, nil, 2, 3) --Крики мертвых
local specWarnWinds					= mod:NewSpecialWarningDefensive(193977, nil, nil, nil, 2, 3) --Ветра Нордскола
local specAriseFallen				= mod:NewSpecialWarningSwitch(193566, "-Healer", nil, nil, 1, 2) --Восстань, павший

local timerDarkSlashCD				= mod:NewCDTimer(14.6, 193211, nil, nil, nil, 3, nil, DBM_CORE_TANK_ICON..DBM_CORE_DEADLY_ICON) --Черная рана
local timerScreamsCD				= mod:NewCDTimer(23, 193364, nil, nil, nil, 2) --Крики мертвых
local timerWindsCD					= mod:NewCDTimer(24, 193977, nil, nil, nil, 2) --Ветра Нордскола
local timerBaneCD					= mod:NewCDTimer(49.5, 193460, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Погибель
local timerAriseFallenCD			= mod:NewCDTimer(19, 193566, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON) --Восстань, павший +1сек

local countdownDarkSlash			= mod:NewCountdown("AltTwo14.6", 193211, "Tank", nil, 5) --Черная рана
local countdownAriseFallen			= mod:NewCountdown(19, 193566, "-Healer", nil, 5) --Восстань, павший

local yellDarkSlash					= mod:NewYell(193211, nil, nil, nil, "YELL") --Черная рана

function mod:DarkSlashTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnDarkSlash:Show()
		specWarnDarkSlash:Play("defensive")
		yellDarkSlash:Yell()
	else
		warnDarkSlash:Show(targetname)
	end
end

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
		self:BossTargetScanner(args.sourceGUID, "DarkSlashTarget", 0.1, 2)
		if self:IsHard() then
			timerDarkSlashCD:Start(16)
			countdownDarkSlash:Start(16)
		else
			timerDarkSlashCD:Start()
			countdownDarkSlash:Start()
		end
	elseif spellId == 193364 then
		if not UnitIsDeadOrGhost("player") then
			specWarnScreams:Show()
			specWarnScreams:Play("runout")
			specWarnScreams2:Show()
			specWarnScreams2:Play("watchstep")
		end
		if self:IsHard() then
			timerScreamsCD:Start(31.5)
		else
			timerScreamsCD:Start()
		end
	elseif spellId == 193977 then
		if not UnitIsDeadOrGhost("player") then
			specWarnWinds:Show()
			specWarnWinds:Play("carefly")
		end
		if self:IsHard() then
			timerWindsCD:Start(29.5)
		else
			timerWindsCD:Start()
		end
	elseif spellId == 193460 then --Погибель
		warnBane:Show()
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
		if not UnitIsDeadOrGhost("player") then
			specAriseFallen:Show()
			specAriseFallen:Play("mobkill")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 193460 then --Погибель
		if not UnitIsDeadOrGhost("player") then
			specWarnBane:Show()
			specWarnBane:Play("watchstep")
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 193364 then --Крики мертвых
		warnScreams:CombinedShow(0.3, args.destName)
	end
end
		