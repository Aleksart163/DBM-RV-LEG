local mod	= DBM:NewMod(1673, "DBM-Party-Legion", 5, 767)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
mod:SetCreatureID(91005)
mod:SetEncounterID(1792)
mod:SetZone()
mod:SetUsedIcons(8)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 209906 199246 199775",
	"SPELL_AURA_APPLIED_DOSE 199246",
--	"SPELL_AURA_REMOVED 209906",
	"SPELL_CAST_START 199176 210150 205549 198963",
--	"SPELL_PERIODIC_DAMAGE 188494",
--	"SPELL_PERIODIC_MISSED 188494",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

-- Нараксас https://ru.wowhead.com/npc=91005/нараксас/эпохальный-журнал-сражений
local warnPutridSkies				= mod:NewCastAnnounce(198963, 4) --Омерзительные небеса
local warnFixate					= mod:NewTargetAnnounce(209906, 2, nil, false) --Самопожертвование фанатика Could be spammy, optional
local warnSpikedTongue				= mod:NewTargetAnnounce(199176, 4) --Шипастый язык
local warnFrenzy					= mod:NewTargetAnnounce(199775, 4) --Бешенство
local warnRavenous					= mod:NewStackAnnounce(199246, 4) --Хищность

local specWarnAdds					= mod:NewSpecialWarningSwitch(199817, "Dps", nil, nil, 1, 2) --Призыв прислужников
local specWarnFixate				= mod:NewSpecialWarningYou(209906) --Самопожертвование фанатика
local specWarnSpikedTongue			= mod:NewSpecialWarningYouRun(199176, nil, nil, nil, 4, 6) --Шипастый язык
--local specWarnRancidMaw			= mod:NewSpecialWarningMove(188494)--Needs confirmation this is pool damage and not constant fight aoe damage

local timerSpikedTongueCD			= mod:NewNextTimer(55, 199176, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_TANK_ICON..DBM_CORE_DEADLY_ICON) --Шипастый язык
local timerAddsCD					= mod:NewCDTimer(65, 199817, nil, "Tank|Dps", nil, 1, 226361, DBM_CORE_DAMAGE_ICON) --Призыв прислужников (последние цифры это картинка на спелл)
local timerRancidMawCD				= mod:NewCDTimer(18.5, 205549, nil, nil, nil, 3) --Зловонная пасть +++
local timerToxicRetchCD				= mod:NewCDTimer(14.5, 210150, nil, nil, nil, 3) --Токсичная желчь +++

local yellSpikedTongue				= mod:NewYell(199176, nil, nil, nil, "YELL") --Шипастый язык

local countdownSpikedTongue			= mod:NewCountdown(55, 199176, "Tank|Healer", nil, 5) --Шипастый язык
--local countdownAdds					= mod:NewCountdown(65, 199817, "Dps") --Призыв прислужников

mod:AddSetIconOption("SetIconOnSpikedTongue", 199176, true, false, {8}) --Шипастый язык

function mod:SpikedTongueTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnSpikedTongue:Show()
		specWarnSpikedTongue:Play("runout")
		specWarnSpikedTongue:ScheduleVoice(1.5, "keepmove")
		yellSpikedTongue:Yell()
	else
		warnSpikedTongue:Show(targetname)
	end
	if self.Options.SetIconOnSpikedTongue then
		self:SetIcon(targetname, 8, 15)
	end
end

function mod:OnCombatStart(delay)
	if self:IsHard() then
		timerAddsCD:Start(6-delay) --Призыв прислужников +++
	--	countdownAdds:Start(6-delay) --Призыв прислужников +++
		timerRancidMawCD:Start(7.3-delay) --Зловонная пасть +++
		timerToxicRetchCD:Start(12.5-delay) --Токсичная желчь +++
		timerSpikedTongueCD:Start(55-delay) --Шипастый язык +++
		countdownSpikedTongue:Start(55-delay) --Шипастый язык +++
	else
		timerAddsCD:Start(5.5-delay) --Призыв прислужников
	--	countdownAdds:Start(5.5-delay) --Призыв прислужников
		timerRancidMawCD:Start(7.3-delay) --Зловонная пасть
		timerToxicRetchCD:Start(12.4-delay) --Токсичная желчь
		timerSpikedTongueCD:Start(50.5-delay) --Шипастый язык
		countdownSpikedTongue:Start(50.5-delay) --Шипастый язык
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 209906 then --Самопожертвование фанатика
		warnFixate:Show(args.destName)
		if args:IsPlayer() and self:AntiSpam(4, 1) then
			specWarnFixate:Show()
		end
	elseif spellId == 199246 then --Хищность
		local amount = args.amount or 1
		warnRavenous:Show(args.destName, amount)
	elseif spellId == 199775 then --Бешенство
		warnFrenzy:Show(args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 199176 then
		self:BossTargetScanner(args.sourceGUID, "SpikedTongueTarget", 0.1, 2)
		if self:IsHard() then
			timerSpikedTongueCD:Start(57)
			countdownSpikedTongue:Start(57)
		else
			timerSpikedTongueCD:Start()
			countdownSpikedTongue:Start()
		end
	elseif spellId == 205549 then
		timerRancidMawCD:Start()
	elseif spellId == 210150 then
		timerToxicRetchCD:Start()
	elseif spellId == 198963 then
		warnPutridSkies:Show()
	end
end
--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 188494 and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) then
		specWarnRancidMaw:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 199817 then --Призыв прислужников
		if not UnitIsDeadOrGhost("player") then
			specWarnAdds:Schedule(1)
			specWarnAdds:ScheduleVoice(1, "mobsoon")
		end
		if self:IsHard() then
			timerAddsCD:Start(75)
		else
			timerAddsCD:Start()
		end
	end
end
