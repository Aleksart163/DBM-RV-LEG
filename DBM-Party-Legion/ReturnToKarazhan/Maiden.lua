local mod	= DBM:NewMod(1825, "DBM-Party-Legion", 11, 860)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17745 $"):sub(12, -3))
mod:SetCreatureID(113971)
mod:SetEncounterID(1954)
mod:SetZone()
mod:SetUsedIcons(7)
mod:SetMinSyncRevision(17745)
--mod:SetUsedIcons(1)
--mod:SetHotfixNoticeRev(14922)
--mod.respawnTime = 30

mod.noNormal = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 227800 227508 227823 227789 227809",
	"SPELL_AURA_APPLIED 227817 227800",
	"SPELL_AURA_REMOVED 227817",
	"SPELL_INTERRUPT",
	"RAID_BOSS_WHISPER"
)

--Благочестивая дева https://ru.wowhead.com/npc=113971/благочестивая-дева/эпохальный-журнал-сражений
local warnSacredGround				= mod:NewTargetAnnounce(227789, 3) --Священная земля
local warnHolyBolt					= mod:NewTargetAnnounce(227809, 3) --Священная молния
local warnHolyWrath					= mod:NewCastAnnounce(227823, 4) --Гнев небес

local specWarnHolyShock2			= mod:NewSpecialWarningStack(227800, nil, 1, nil, nil, 3, 6) --Шок небес
local specWarnHolyBolt				= mod:NewSpecialWarningYouMoveAway(227809, nil, nil, nil, 3, 3) --Священная молния
local specWarnSacredGround			= mod:NewSpecialWarningYouMoveAway(227789, nil, nil, nil, 4, 2) --Священная земля
local specWarnHolyShock				= mod:NewSpecialWarningCount(227800, "HasInterrupt", nil, nil, 1, 3) --Шок небес
local specWarnRepentance			= mod:NewSpecialWarningMoveTo(227508, nil, nil, nil, 4, 6) --Всеобщее покаяние
local specWarnHolyWrath				= mod:NewSpecialWarningInterrupt(227823, "HasInterrupt", nil, nil, 3, 6) --Гнев небес

local timerHolyBoltCD				= mod:NewCDTimer(13.5, 227809, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Священная молния
local timerSacredGroundCD			= mod:NewCDTimer(23, 227789, nil, nil, nil, 3) --Священная земля 19-35 (delayed by bulwarks and what nots) +++
local timerHolyShockCD				= mod:NewCDTimer(13, 227800, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON..DBM_CORE_DEADLY_ICON) --Шок небес +++
local timerRepentanceCD				= mod:NewCDTimer(51, 227508, nil, nil, nil, 7) --Всеобщее покаяние +++
local timerHolyWrath				= mod:NewCastTimer(10, 227823, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON..DBM_CORE_DEADLY_ICON) --Гнев небес ++

local yellHolyBolt					= mod:NewYell(227809, nil, nil, nil, "YELL") --Священная молния
local yellSacredGround				= mod:NewYell(227789, nil, nil, nil, "YELL") --Священная земля
--local berserkTimer				= mod:NewBerserkTimer(300)

local countdownHolyBolt				= mod:NewCountdown(13.5, 227809, nil, nil, 5) --Священная молния
local countdownHolyWrath			= mod:NewCountdown("Alt10", 227823, nil, nil, 5) --Гнев небес

mod:AddSetIconOption("SetIconOnSacredGround", 227789, true, false, {7}) --Священная земля
mod:AddRangeFrameOption(8, 227809)--TODO, keep looking for a VALID 6 yard item/spell
mod:AddInfoFrameOption(227817, true)

local sacredGround = DBM:GetSpellInfo(227789) --Священная земля

mod.vb.kickCount = 0

function mod:SacredGroundTarget(targetname, uId) --Прошляпанное очко Мурчаля [✔]
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnSacredGround:Show()
	--	specWarnSacredGround:Play("runout")
		yellSacredGround:Yell()
	else
		warnSacredGround:Show(targetname)
	end
	if self.Options.SetIconOnSacredGround then
		self:SetIcon(targetname, 7, 5)
	end
end

function mod:HolyBoltTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnHolyBolt:Show()
	--	specWarnHolyBolt:Play("runout")
		yellHolyBolt:Yell()
	else
		warnHolyBolt:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	self.vb.kickCount = 0
	countdownHolyBolt:Start(8.9-delay) --Священная молния +++
	timerHolyBoltCD:Start(8.9-delay) --Священная молния +++
	timerSacredGroundCD:Start(10.9-delay) --Священная земля +++
	timerHolyShockCD:Start(15.8-delay) --Шок небес +++
	timerRepentanceCD:Start(50-delay) --Всеобщее покаяние +++
	countdownHolyWrath:Start(50-delay) --Всеобщее покаяние +++
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(6)--Will open to 6 when supported, else 8
	end
end
	
function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 227800 then
		if self.vb.kickCount == 2 then self.vb.kickCount = 0 end
		self.vb.kickCount = self.vb.kickCount + 1
		local kickCount = self.vb.kickCount
		specWarnHolyShock:Show(kickCount)
--[[		if kickCount == 1 then
			specWarnHolyShock:Play("kick1r")
		elseif kickCount == 2 then
			specWarnHolyShock:Play("kick2r")
		end]]
		timerHolyShockCD:Start()
	elseif spellId == 227508 then --Всеобщее покаяние
		if not UnitIsDeadOrGhost("player") then
			specWarnRepentance:Show(sacredGround)
		--	specWarnRepentance:Play("justrun")
		end
		timerRepentanceCD:Start()
		countdownHolyWrath:Start(51)
		timerHolyBoltCD:Stop()
		countdownHolyBolt:Cancel()
		timerHolyShockCD:Stop()
		timerSacredGroundCD:Stop()
	elseif spellId == 227823 then --Гнев небес
		warnHolyWrath:Show()
		timerHolyWrath:Start()
		countdownHolyWrath:Start()
	elseif spellId == 227789 then --Священная земля
		self:BossTargetScanner(args.sourceGUID, "SacredGroundTarget", 0.1, 2)
		timerSacredGroundCD:Start()
	elseif spellId == 227809 then --Священная молния
		self:BossTargetScanner(args.sourceGUID, "HolyBoltTarget", 0.1, 2)
		timerHolyBoltCD:Start()
		countdownHolyBolt:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 227817 then
		self.vb.kickCount = 0
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(2, "enemyabsorb", nil, 4680000)
		end
	elseif spellId == 227800 then --Шок небес
		local amount = args.amount or 1
		if amount >= 1 then
			if args:IsPlayer() then
				specWarnHolyShock2:Show(amount)
			--	specWarnHolyShock2:Play("stackhigh")
			end
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 227817 then
		if UnitCastingInfo("boss1") then
			if not UnitIsDeadOrGhost("player") then
				specWarnHolyWrath:Show(L.name)
			--	specWarnHolyWrath:Play("kickcast")
			end
		end
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
	end
end

function mod:SPELL_INTERRUPT(args)
	if type(args.extraSpellId) == "number" and args.extraSpellId == 227823 then
		timerHolyWrath:Stop()
		countdownHolyWrath:Cancel()
		timerSacredGroundCD:Start(4)
		timerHolyShockCD:Start(8.5)
	end
end
