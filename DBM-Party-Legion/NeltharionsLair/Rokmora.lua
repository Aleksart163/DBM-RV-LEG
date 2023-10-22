local mod	= DBM:NewMod(1662, "DBM-Party-Legion", 5, 767)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
mod:SetCreatureID(91003)
mod:SetEncounterID(1790)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 188169 188114",
	"SPELL_AURA_APPLIED 215898",
	"SPELL_PERIODIC_DAMAGE 192800",
	"SPELL_PERIODIC_MISSED 192800"
)

--Рокмора https://ru.wowhead.com/npc=91003/рокмора/эпохальный-журнал-сражений
local warnShatter					= mod:NewCastAnnounce(188114, 4) --Дробление
local warnShatter2					= mod:NewSoonAnnounce(188114, 3, nil, nil) --Дробление
local warnRazorShards				= mod:NewSpellAnnounce(188169, 4) --Бритвенно-острые осколки
local warnRazorShards2				= mod:NewSoonAnnounce(188169, 3, nil, nil) --Бритвенно-острые осколки

local specWarnShatter				= mod:NewSpecialWarningDefensive(188114, nil, nil, nil, 2, 3) --Дробление
local specWarnRazorShards			= mod:NewSpecialWarningYouMove(188169, "Tank", nil, nil, 3, 6) --Бритвенно-острые осколки
local specWarnRazorShards2			= mod:NewSpecialWarningDodge(188169, "-Tank", nil, nil, 2, 2) --Бритвенно-острые осколки
local specWarnGas					= mod:NewSpecialWarningYouMove(192800, nil, nil, nil, 1, 2) --Удушающая пыль
--local specWarnCrystallineGround		= mod:NewSpecialWarningYouDontMove(215898, nil, nil, nil, 1, 2) --Кристализованная земля

local timerShatterCD				= mod:NewCDTimer(24.2, 188114, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Дробление +++
local timerRazorShardsCD			= mod:NewCDTimer(25, 188169, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON..DBM_CORE_DEADLY_ICON) --Бритвенно-острые осколки +++

local countdownShatter				= mod:NewCountdown(24.2, 188114, nil, nil, 5) --Дробление
local countdownShatter2				= mod:NewCountdownFades(4.3, 188114, nil, nil, 4.3) --Дробление

function mod:OnCombatStart(delay)
	if not self:IsNormal() then
		warnShatter2:Schedule(18-delay) --Дробление+++
		timerShatterCD:Start(23-delay) --Дробление+++
		countdownShatter:Start(23-delay) --Дробление+++
		timerRazorShardsCD:Start(28-delay) --Бритвенно-острые осколки+++
		warnRazorShards2:Schedule(25-delay) --Бритвенно-острые осколки+++
	else
		timerShatterCD:Start(20-delay)
		timerRazorShardsCD:Start(25-delay)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 188169 then --Бритвенно-острые осколки
		warnRazorShards:Show()
		if not UnitIsDeadOrGhost("player") then
			specWarnRazorShards:Show()
			specWarnRazorShards:Play("shockwave")
			specWarnRazorShards2:Show()
			specWarnRazorShards2:Play("shockwave")
		end
		if self:IsHard() then
			timerRazorShardsCD:Start(29)
			warnRazorShards2:Schedule(24)
		else
			timerRazorShardsCD:Start()
			warnRazorShards2:Schedule(20)
		end
	elseif spellId == 188114 then --Дробление
		warnShatter:Show()
		countdownShatter2:Start()
		if not UnitIsDeadOrGhost("player") then
			specWarnShatter:Show()
			specWarnShatter:Play("defensive")
		end
		if self:IsHard() then
			timerShatterCD:Start(24.7)
			countdownShatter:Start(24.7)
			warnShatter2:Schedule(19.7)
		else
			countdownShatter:Start()
			timerShatterCD:Start()
			warnShatter2:Schedule(19.2)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 215898 then --Кристализованная земля
		if args:IsPlayer() then
		--	specWarnCrystallineGround:Show()
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 192800 and destGUID == UnitGUID("player") and self:AntiSpam(3.5, 1) then
		if not self:IsNormal() then
			specWarnGas:Show()
			specWarnGas:Play("runaway")
		end
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
