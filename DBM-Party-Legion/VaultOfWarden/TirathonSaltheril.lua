local mod	= DBM:NewMod(1467, "DBM-Party-Legion", 10, 707)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17745 $"):sub(12, -3))
mod:SetCreatureID(95885)
mod:SetEncounterID(1815)
mod:DisableESCombatDetection()--Remove if blizz fixes trash firing ENCOUNTER_START
mod:SetZone()
mod:SetMinSyncRevision(17745)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 191941 192504 202740 204151",
	"SPELL_AURA_REMOVED 191941 192504 202740 204151",
	"SPELL_CAST_START 204151 191823 191941 202913",
	"SPELL_PERIODIC_DAMAGE 202919 191853",
	"SPELL_PERIODIC_MISSED 202919 191853",
	"UNIT_SPELLCAST_SUCCEEDED boss1",
	"UNIT_HEALTH boss1"
)

--Тиратон Салтерил https://ru.wowhead.com/npc=95885/тиратон-салтерил/эпохальный-журнал-сражений
local warnMetamorphosis				= mod:NewSoonAnnounce(192504, 1) --Метаморфоза
local warnMetamorphosis2			= mod:NewTargetAnnounce(192504, 4) --Метаморфоза
local warnMetamorphosis3			= mod:NewPreWarnAnnounce(192504, 5, 1) --Метаморфоза
local warnFuriousBlast				= mod:NewCastAnnounce(191823, 4) --Яростный взрыв

local specWarnHatred				= mod:NewSpecialWarningDodge(190830, nil, nil, nil, 2, 2) --Ненависть
local specWarnDarkStrikes			= mod:NewSpecialWarningYouDefensive(204151, "Tank", nil, nil, 3, 6) --Удары Тьмы
local specWarnFuriousBlast			= mod:NewSpecialWarningInterrupt(191823, "HasInterrupt", nil, nil, 3, 6) --Яростный взрыв
local specWarnFelMortar				= mod:NewSpecialWarningDodge(202913, nil, nil, nil, 2, 2) --Залп Скверны
local specWarnFelMortarGTFO			= mod:NewSpecialWarningYouMove(191853, nil, nil, nil, 1, 2) --Яростное пламя

local timerSpecialCD				= mod:NewNextSpecialTimer(13.5)
local timerDarkStrikes				= mod:NewBuffActiveTimer(10, 191941, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON..DBM_CORE_DEADLY_ICON) --Удары Тьмы
local timerDarkStrikesCD			= mod:NewCDTimer(31, 191941, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON..DBM_CORE_DEADLY_ICON) --Удары Тьмы
local timerHatredCD					= mod:NewCDTimer(29, 190830, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Ненависть
local timerFelMortarCD				= mod:NewCDTimer(15.5, 202913, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON..DBM_CORE_DEADLY_ICON) --Залп Скверны+++
local timerMetamorphosisCD			= mod:NewCDTimer(30, 192504, nil, nil, nil, 6, nil, DBM_CORE_DEADLY_ICON) --Метаморфоза
local timerFuriousBlastCD			= mod:NewCDTimer(31, 191823, nil, nil, nil, 2, nil, DBM_CORE_INTERRUPT_ICON..DBM_CORE_DEADLY_ICON) --Яростный взрыв

local countdownFuriousBlast			= mod:NewCountdown(31, 191823, nil, nil, 5) --Яростный взрыв

mod.vb.phase = 1
local warned_preP1 = false

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	warned_preP1 = false
	if not self:IsNormal() then
		timerDarkStrikesCD:Start(6-delay) --Удары Тьмы+++
		timerSpecialCD:Start(13-delay) --Яростный взрыв+++
		countdownFuriousBlast:Start(13-delay) --Яростный взрыв
		timerMetamorphosisCD:Start(20-delay) --Метаморфоза+++
		warnMetamorphosis3:Schedule(15-delay) --Метаморфоза+++
	else
		timerDarkStrikesCD:Start(6-delay) --Удары Тьмы
		timerSpecialCD:Start(13.5-delay) --Яростный взрыв+++
		countdownFuriousBlast:Start(13.5-delay) --Яростный взрыв
		timerMetamorphosisCD:Start(20-delay) --Метаморфоза
		warnMetamorphosis3:Schedule(15-delay) --Метаморфоза
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if (spellId == 204151 or spellId == 191941) then --Удары Тьмы
		timerDarkStrikes:Start()
	elseif spellId == 202740 then --Метаморфоза танк
		self.vb.phase = 2
		warnMetamorphosis2:Show(args.destName) --Метаморфоза
		timerDarkStrikesCD:Stop() --Удары Тьмы
		timerFelMortarCD:Start(13) --Залп Скверны (точно, если при пуле заюзал Яростный взрыв, иначе 14)
		timerDarkStrikesCD:Start(24) --Удары Тьмы (точно, если при пуле заюзал Яростный взрыв, иначе 25.5)
	elseif spellId == 192504 then --Метаморфоза дд
		self.vb.phase = 3
		warnMetamorphosis2:Show(args.destName) --Метаморфоза
		timerDarkStrikesCD:Stop() --Удары Тьмы
		timerFelMortarCD:Stop() --Залп Скверны
		timerDarkStrikesCD:Start(27.5) --Удары Тьмы (точно, если сперва была Ненависть, иначе 15)
		timerHatredCD:Start(15) --Ненависть
		timerFuriousBlastCD:Start(35) --Яростный взрыв
		countdownFuriousBlast:Start(35) --Яростный взрыв
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if (spellId == 204151 or spellId == 191941) then --Удары Тьмы
		timerDarkStrikes:Cancel()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if (spellId == 204151 or spellId == 191941) and self:AntiSpam(2.5, 1) then --Удары Тьмы
		specWarnDarkStrikes:Show()
	--	specWarnDarkStrikes:Play("defensive")
		if self:IsHard() then
			timerDarkStrikesCD:Start(30.5)
		else
			timerDarkStrikesCD:Start()
		end
	elseif spellId == 191823 then --Яростный взрыв
		warnFuriousBlast:Show()
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnFuriousBlast:Show()
		--	specWarnFuriousBlast:Play("kickcast")
		else
			specWarnFuriousBlast:Show()
		--	specWarnFuriousBlast:Play("kickcast")
		end
		if self:IsHard() then
			if self.vb.phase == 3 then
				timerFuriousBlastCD:Start(30.5)
				countdownFuriousBlast:Start(30.5)
			end
		else
			if self.vb.phase == 3 then
				timerFuriousBlastCD:Start()
				countdownFuriousBlast:Start()
			end
		end
	elseif spellId == 202913 then --Залп Скверны
		if not UnitIsDeadOrGhost("player") then
			specWarnFelMortar:Show()
		--	specWarnFelMortar:Play("watchstep")
		end
		timerFelMortarCD:Start()
	end
end


function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 191853 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		if not self:IsNormal() then
			specWarnFelMortarGTFO:Show()
		--	specWarnFelMortarGTFO:Play("runaway")
		end
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 190830 then --Ненависть
		if not UnitIsDeadOrGhost("player") then
			specWarnHatred:Show()
		--	specWarnHatred:Play("watchstep")
		end
		timerHatredCD:Start()
	end
end

function mod:UNIT_HEALTH(uId)
	if not self:IsNormal() then --миф и миф+
		if self.vb.phase == 2 and not warned_preP1 and self:GetUnitCreatureId(uId) == 95885 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.51 then --Тиратон Салтерил
			warned_preP1 = true
			warnMetamorphosis:Show()
		end
	end
end
