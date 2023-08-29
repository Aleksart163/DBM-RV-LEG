local mod	= DBM:NewMod(1468, "DBM-Party-Legion", 10, 707)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
mod:SetCreatureID(95886)
mod:SetEncounterID(1816)
mod:SetZone()
mod:SetUsedIcons(8, 7, 6, 5, 4)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 192522 192631 192621 195187",
	"SPELL_AURA_APPLIED 192517 192519 215478",
	"SPELL_AURA_APPLIED_DOSE 192519",
	"SPELL_AURA_REMOVED 192517 192519",
	"CHAT_MSG_MONSTER_EMOTE"
)

--Вулкан https://ru.wowhead.com/npc=95886/вулкан/эпохальный-журнал-сражений
local warnFiredUp2					= mod:NewTargetAnnounce(215478, 4) --Обгорание
local warnVolcano					= mod:NewSpellAnnounce(192621, 3, nil, nil, nil, nil, nil, 2) --Пирокласт
local warnFiredUp					= mod:NewCastAnnounce(195187, 4) --Взрыв
local warnCountermeasure			= mod:NewSoonAnnounce(195189, 2, 235297) --Система безопасности
--local warnCountermeasure2			= mod:NewAnnounce("Countermeasure", 2, 235297) --Система безопасности

local specWarnProshlyap				= mod:NewSpecialWarningReady(195189, nil, nil, nil, 1, 3) --Система безопасности
local specWarnFiredUp2				= mod:NewSpecialWarningYou(215478, nil, nil, nil, 3, 5) --Обгорание
local specWarnFiredUp				= mod:NewSpecialWarningDefensive(195187, nil, nil, nil, 3, 6) --Взрыв
local specWarnLava					= mod:NewSpecialWarningStack(192519, nil, 2, nil, nil, 1, 2) --Лава
local specWarnBrittle				= mod:NewSpecialWarningMoreDamage(192517, "-Healer", nil, nil, 3, 2) --Ломкость
local specWarnLavaWreath			= mod:NewSpecialWarningDodge(192631, nil, nil, nil, 2, 2) --Лавовое кольцо
local specWarnFissure				= mod:NewSpecialWarningSpell(192522, "Tank", nil, nil, 1, 2) --Разлом Not dogable, just so we aim it correctly

local timerFiredUp					= mod:NewCastTimer(5, 195187, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Взрыв
local timerBrittle					= mod:NewBuffActiveTimer(20, 192517, nil, nil, nil, 6, nil, DBM_CORE_DAMAGE_ICON) --Ломкость +++
local timerVolcanoCD				= mod:NewCDTimer(20, 192621, nil, nil, nil, 1) --Пирокласт 20-22 unless delayed by brittle
local timerLavaWreathCD				= mod:NewCDTimer(42.5, 192631, nil, nil, nil, 2) --Лавовое кольцо+++ 42 unless delayed by brittle
local timerFissureCD				= mod:NewCDTimer(42.5, 192522, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON) --Разлом 42 unless delayed by brittle
local timerCountermeasureCD			= mod:NewCDTimer(60, 195189, nil, nil, nil, 7, 235297) --Система безопасности

local countdownCountermeasure		= mod:NewCountdown(60, 195189, nil, nil, 5) --Система безопасности
local countdownBrittle				= mod:NewCountdownFades("Alt20", 192517, nil, nil, 5) --Ломкость

local yellFiredUp					= mod:NewYell(215478, nil, nil, nil, "YELL") --Обгорание

mod:AddSetIconOption("SetIconOnFiredUp", 215478, true, false, {8, 7, 6, 5, 4}) --Обгорание

mod.vb.countermeasure = 0
mod.vb.firedupIcon = 8

function mod:OnCombatStart(delay)
	self.vb.countermeasure = 0
	self.vb.firedupIcon = 8
	if not self:IsNormal() then
		timerVolcanoCD:Start(10.5-delay) --Пирокласт+++
		timerLavaWreathCD:Start(25-delay) --Лавовое кольцо+++
		timerFissureCD:Start(40.5-delay) --Разлом+++
		timerCountermeasureCD:Start(6.5-delay) --Система безопасности+++
		warnCountermeasure:Schedule(1.5-delay) --Система безопасности+++
		countdownCountermeasure:Start(6.5-delay) --Система безопасности+++
	else
		timerVolcanoCD:Start(10.5-delay) --Пирокласт
		timerLavaWreathCD:Start(25-delay) --Лавовое кольцо
		timerFissureCD:Start(40.5-delay) --Разлом
		timerCountermeasureCD:Start(6.5-delay) --Система безопасности
		warnCountermeasure:Schedule(1.5-delay) --Система безопасности
		countdownCountermeasure:Start(6.5-delay) --Система безопасности
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 192522 then --Разлом
		specWarnFissure:Show()
		specWarnFissure:Play("shockwave")
		timerFissureCD:Start()
	elseif spellId == 192631 then --Лавовое кольцо
		if not UnitIsDeadOrGhost("player") then
			specWarnLavaWreath:Show()
			specWarnLavaWreath:Play("watchstep")
		end
		timerLavaWreathCD:Start()
	elseif spellId == 192621 then --Пирокласт
		warnVolcano:Show()
		warnVolcano:Play("mobsoon")
		if self:IsHard() then
			timerVolcanoCD:Start(20.5)
		else
			timerVolcanoCD:Start()
		end
	elseif spellId == 195187 and self:AntiSpam(3, 1) then --Взрыв
		warnFiredUp:Show()
		if not UnitIsDeadOrGhost("player") then
			specWarnFiredUp:Schedule(2)
			specWarnFiredUp:ScheduleVoice(2, "defensive")
		end
		timerFiredUp:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 192517 and args:GetSrcCreatureID() == 95886 then --Ломкость
		self.vb.countermeasure = self.vb.countermeasure + 1
		if not UnitIsDeadOrGhost("player") then
			specWarnBrittle:Show()
		end
		timerBrittle:Start()
		countdownBrittle:Start()
		if not self:IsNormal() then
			if self.vb.countermeasure >= 1 then --
				warnCountermeasure:Schedule(60)
				timerCountermeasureCD:Start(65)
				countdownCountermeasure:Start(65)
			end
		end
	elseif spellId == 192519 then --Лава
		local amount = args.amount or 1
		if not self:IsNormal() then
			if args:IsPlayer() then
				if amount >= 2 then
					specWarnLava:Show(amount)
					specWarnLava:Play("stackhigh")
				end
			end
		end
	elseif spellId == 215478 then --Обгорание
		self.vb.firedupIcon = self.vb.firedupIcon - 1
		warnFiredUp2:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			specWarnFiredUp2:Show()
			specWarnFiredUp2:Play("defensive")
			yellFiredUp:Yell()
		end
		if self.Options.SetIconOnFiredUp then
			self:SetIcon(args.destName, self.vb.firedupIcon)
		end
		if self.vb.firedupIcon == 4 then
			self.vb.firedupIcon = 8
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:CHAT_MSG_MONSTER_EMOTE(msg)
	if msg:find(L.MurchalProshlyapOchko) or msg == L.MurchalProshlyapOchko then
	--	warnCountermeasure2:Show()
		specWarnProshlyap:Show()
		timerCountermeasureCD:Cancel()
		countdownCountermeasure:Cancel()
	end
end
