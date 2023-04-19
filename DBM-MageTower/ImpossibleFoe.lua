local mod	= DBM:NewMod("ImpossibleFoe", "DBM-MageTower")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
mod:SetCreatureID(115638) --Агата
mod:SetZone()

mod.soloChallenge = true
mod.onlyNormal = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 243113",
	"SPELL_AURA_REMOVED 243113",
	"SPELL_PERIODIC_DAMAGE 236161",
	"SPELL_PERIODIC_MISSED 236161",
	"UNIT_HEALTH",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

--Прошляпанное очко Мурчаля ✔ Невероятный противник
local warnPhase					= mod:NewPhaseChangeAnnounce(1)
local warnPrePhase2				= mod:NewPrePhaseAnnounce(2, 1)

local specWarnImpServants		= mod:NewSpecialWarningSwitch(235140, nil, nil, nil, 1, 2) --Месть Агаты
local specWarnDarkFury			= mod:NewSpecialWarningMoreDamage(243113, nil, nil, nil, 1, 5) --Темная ярость
local specWarnPlagueZone		= mod:NewSpecialWarningYouMove(236161, nil, nil, nil, 1, 2) --Область чумы

local timerImpServantsCD		= mod:NewCDTimer(45, 235140, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON) --Месть Агаты
local timerDarkFuryCD			= mod:NewCDTimer(51.1, 243113, nil, nil, nil, 6, nil, DBM_CORE_DEADLY_ICON..DBM_CORE_INTERRUPT_ICON) --Темная ярость

local countdownDarkFury			= mod:NewCountdown(51.1, 243113, nil, nil, 5) --Темная ярость
local countdownImpServants		= mod:NewCountdown("Alt45", 235140, nil, nil, 5) --Месть Агаты

mod:AddInfoFrameOption(243113, true)

mod.vb.phase = 1

local warned_preP1 = false
local warned_preP2 = false
local warned_preP3 = false

function mod:OnCombatStart(delay)
	warned_preP1 = false
	warned_preP2 = false
	warned_preP3 = false
	self.vb.phase = 1
	timerImpServantsCD:Start(15-delay) --Месть Агаты+++
	countdownImpServants:Start(15-delay) --Месть Агаты+++
	timerDarkFuryCD:Start(50-delay) --Темная ярость+++
	countdownDarkFury:Start(50-delay) --Темная ярость+++
	DBM:AddMsg("1-ая фаза на боссе выглядит идеально, но другие не проверены. Не забывайте проверять актуальные обновления модулей на сайте.")
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 243113 then --Темная ярость
		specWarnDarkFury:Show(args.destName)
		specWarnDarkFury:Play("attackshield")
		if self.vb.phase == 2 then
			timerDarkFuryCD:Start(68)
			countdownDarkFury:Start(68)
		else
			timerDarkFuryCD:Start()
			countdownDarkFury:Start(51.1)
		end
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(2, "enemyabsorb", args.spellName)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 243113 then --Темная ярость
		specWarnDarkFury:Play("shieldover")
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 236161 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then --Область чумы
		specWarnPlagueZone:Show()
		specWarnPlagueZone:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	if args.destGUID == UnitGUID("player") then
		DBM:EndCombat(self, true)
	end
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 115638 then --Агата
		DBM:EndCombat(self)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 242987 then
		if self.vb.phase == 1 then
			self.vb.phase = 2
			warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase))
		end
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:find(L.impServants) or msg == L.impServants then
		specWarnImpServants:Show()
		specWarnImpServants:Play("bigmob")
		timerImpServantsCD:Start()
		countdownImpServants:Start()
	end
end

function mod:UNIT_HEALTH(uId)
	if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 115638 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.61 then --Агата
		warned_preP1 = true
		warnPrePhase2:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
	end
end
