local mod	= DBM:NewMod(1490, "DBM-Party-Legion", 3, 716)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
mod:SetCreatureID(91789)
mod:SetEncounterID(1811)
mod:SetZone()
mod:SetUsedIcons(8, 7, 6, 5, 4)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 193698",
	"SPELL_AURA_REMOVED 193698",
	"SPELL_CAST_START 193682 193597 193611",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--Леди Кольцо Ненависти https://ru.wowhead.com/npc=91789/леди-кольцо-ненависти/эпохальный-журнал-сражений
local warnCurseofWitch				= mod:NewTargetAnnounce(193698, 4) --Проклятие ведьмы
local warnStaticNova				= mod:NewPreWarnAnnounce(193597, 5, 1) --Кольцо молний
local warnFocusedLightning			= mod:NewSoonAnnounce(193611, 1) --Средоточие молний

local specWarnStaticNova			= mod:NewSpecialWarningStandSand(193597, nil, nil, nil, 3, 6) --Кольцо молний
--local specWarnFocusedLightning		= mod:NewSpecialWarningMoveTo(193611, nil, nil, nil, 4, 5) --Средоточие молний
local specWarnFocusedLightning2		= mod:NewSpecialWarningMoveAway(193611, nil, nil, nil, 3, 6) --Средоточие молний
local specWarnAdds					= mod:NewSpecialWarningSwitch(193682, "-Healer", nil, nil, 2, 2) --Призыв шторма
local specWarnCurseofWitch			= mod:NewSpecialWarningYouLookAway2(193698, nil, nil, nil, 1, 2) --Проклятие ведьмы

local timerAddsCD					= mod:NewCDTimer(50, 193682, nil, nil, nil, 1, nil, DBM_CORE_TANK_ICON..DBM_CORE_DAMAGE_ICON) --Призыв шторма 47-51 +++
local timerStaticNovaCD				= mod:NewCDTimer(35, 193597, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Кольцо молний +++
local timerStaticNova				= mod:NewCastTimer(4, 193597, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Кольцо молний +++
local timerFocusedLightningCD		= mod:NewNextTimer(10, 193611, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Средоточие молний +++
local timerFocusedLightning			= mod:NewCastTimer(4, 193611, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Средоточие молний +++
local timerCurseofWitch				= mod:NewCastTimer(6, 193698, nil, nil, nil, 3, nil, DBM_CORE_CURSE_ICON) --Проклятие ведьмы +++
local timerMonsoonCD				= mod:NewCDTimer(20, 196610, nil, nil, nil, 7) --Муссон

local countdownStaticNova			= mod:NewCountdown(34, 193597, nil, nil, 5) --Кольцо молний
local countdownStaticNova2			= mod:NewCountdownFades("Alt4", 193597, nil, nil, 4) --Кольцо молний
local countdownFocusedLightning		= mod:NewCountdown(10, 193611, nil, nil, 3) --Средоточие молний
local countdownFocusedLightning2	= mod:NewCountdownFades("Alt4", 193611, nil, nil, 4) --Средоточие молний

local yellCurseofWitch				= mod:NewYell(193698, nil, nil, nil, "YELL") --Проклятие ведьмы
local yellCurseofWitch2				= mod:NewShortFadesYell(193698, nil, nil, nil, "YELL") --Проклятие ведьмы

mod:AddSetIconOption("SetIconOnCurseofWitch", 193698, true, false, {8, 7, 6, 5, 4}) --Проклятие ведьмы

mod.vb.curseofwitchIcon = 8
mod.vb.focusedlightningCount = 0

local monsoon = DBM:GetSpellInfo(196610)

function mod:OnCombatStart(delay)
	self.vb.curseofwitchIcon = 8
	self.vb.focusedlightningCount = 0
	if not self:IsNormal() then
		warnStaticNova:Schedule(6-delay) --Кольцо молний +++
		timerStaticNovaCD:Start(11-delay) --Кольцо молний +++
		countdownStaticNova:Start(11-delay) --Кольцо молний +++
		timerAddsCD:Start(19.5-delay) --Призыв шторма +++
		timerMonsoonCD:Start(32-delay) --Муссон
	else
		warnStaticNova:Schedule(6-delay)
		timerStaticNovaCD:Start(10.5-delay) --Кольцо молний
		countdownStaticNova:Start(10.5-delay) --Кольцо молний
		timerAddsCD:Start(19-delay) --Призыв шторма
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 193682 then --Призыв шторма
		if not UnitIsDeadOrGhost("player") then
			specWarnAdds:Show()
			specWarnAdds:Play("mobsoon")
		end
		timerAddsCD:Start()
	elseif spellId == 193597 then --Кольцо молний
		if not UnitIsDeadOrGhost("player") then
			specWarnStaticNova:Show()
			specWarnStaticNova:Play("findshelter")
		end
		warnStaticNova:Schedule(30)
		warnFocusedLightning:Schedule(8)
		timerStaticNovaCD:Start()
		timerStaticNova:Start()
		countdownStaticNova:Start()
		countdownStaticNova2:Start()
		--Средоточие молний
		timerFocusedLightningCD:Start()
		countdownFocusedLightning:Start()
	elseif spellId == 193611 then --Средоточие молний
		self.vb.focusedlightningCount = self.vb.focusedlightningCount + 1
		if not UnitIsDeadOrGhost("player") then
			specWarnFocusedLightning2:Show()
			specWarnFocusedLightning2:Play("defensive")
		end
--[[		if self.vb.focusedlightningCount == 1 then
			specWarnFocusedLightning2:Show()
			specWarnFocusedLightning2:Play("defensive")
		else
			specWarnFocusedLightning:Show(monsoon)
			specWarnFocusedLightning:Play("defensive")
		end]]
		timerFocusedLightning:Start()
		countdownFocusedLightning2:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 193698 then --Проклятие ведьмы
		self.vb.curseofwitchIcon = self.vb.curseofwitchIcon - 1
		warnCurseofWitch:CombinedShow(0.3, args.destName)
		timerCurseofWitch:Start()
		if args:IsPlayer() then
			specWarnCurseofWitch:Schedule(3.5)
			specWarnCurseofWitch:ScheduleVoice(3.5, "turnaway")
			yellCurseofWitch:Yell()
			yellCurseofWitch2:Countdown(6, 3)
		end
		if self.Options.SetIconOnCurseofWitch then
			self:SetIcon(args.destName, self.vb.curseofwitchIcon)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 193698 then --Проклятие ведьмы
		self.vb.curseofwitchIcon = self.vb.curseofwitchIcon + 1
		if args:IsPlayer() then
			specWarnCurseofWitch:Cancel()
			yellCurseofWitch2:Cancel()
		end
		if self.Options.SetIconOnCurseofWitch then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 196634 or spellId == 196629 then --Муссон
		timerMonsoonCD:Start()
	end
end
