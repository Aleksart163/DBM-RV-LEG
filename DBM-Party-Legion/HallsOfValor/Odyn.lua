local mod	= DBM:NewMod(1489, "DBM-Party-Legion", 4, 721)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(95676)
mod:SetEncounterID(1809)
mod:SetZone()
mod:SetUsedIcons(8, 6, 4, 3, 2, 1)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 198263 198077 198750",
	"SPELL_CAST_SUCCESS 197961",
	"SPELL_AURA_APPLIED 197963 197964 197965 197966 197967 198190",
	"SPELL_AURA_REMOVED 197963 197964 197965 197966 197967",
	"CHAT_MSG_MONSTER_SAY",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--Один https://ru.wowhead.com/npc=114263/один/эпохальный-журнал-сражений#abilities;mode:
local warnUnworthy					= mod:NewTargetAnnounce(198190, 3) --Недостойность
local warnSpear						= mod:NewSpellAnnounce(198072, 2) --Копье света

local specWarnTempest				= mod:NewSpecialWarningRun(198263, nil, nil, nil, 4, 5) --Светозарная буря
local specWarnShatterSpears			= mod:NewSpecialWarningDodge(198077, nil, nil, nil, 2, 2) --Расколотые копья
local specWarnSpear					= mod:NewSpecialWarningDodge(198072, nil, nil, nil, 2, 2) --Копье света
local specWarnRunicBrand			= mod:NewSpecialWarningYouMoveToPos(197963, nil, nil, nil, 4, 5) --Руническое клеймо фиолетовая
local specWarnRunicBrand2			= mod:NewSpecialWarningYouMoveToPos(197964, nil, nil, nil, 4, 5) --Руническое клеймо оранжевая
local specWarnRunicBrand3			= mod:NewSpecialWarningYouMoveToPos(197965, nil, nil, nil, 4, 5) --Руническое клеймо желтая
local specWarnRunicBrand4			= mod:NewSpecialWarningYouMoveToPos(197966, nil, nil, nil, 4, 5) --Руническое клеймо синяя
local specWarnRunicBrand5			= mod:NewSpecialWarningYouMoveToPos(197967, nil, nil, nil, 4, 5) --Руническое клеймо зеленая
local specWarnAdd					= mod:NewSpecialWarningSwitch(201221, "-Healer", nil, nil, 1, 2) --Призыв закаленного бурей воина
local specWarnSurge					= mod:NewSpecialWarningInterrupt(198750, "HasInterrupt", nil, nil, 1, 3) --Импульс
local specWarnUnworthy				= mod:NewSpecialWarningYou(198190, nil, nil, nil, 1, 2) --Недостойность

--local timerSpearCD					= mod:NewCDTimer(8, 198077, nil, nil, nil, 3)--More data needed
local timerTempestCD				= mod:NewCDCountTimer(56, 198263, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Светозарная буря
local timerTempestCast				= mod:NewCastTimer(7, 198263, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Светозарная буря
local timerShatterSpearsCD			= mod:NewCDTimer(56, 198077, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Расколотые копья
local timerRunicBrandCD				= mod:NewCDCountTimer(54, 197961, nil, nil, nil, 7) --Руническое клеймо
local timerRunicBrand				= mod:NewTargetTimer(12, 197961, nil, nil, nil, 7) --Руническое клеймо
local timerAddCD					= mod:NewCDTimer(54, 201221, nil, nil, nil, 1, 201215, DBM_CORE_DAMAGE_ICON) --Призыв закаленного бурей воина 54-58

local countdownTempest				= mod:NewCountdown(56, 198263, nil, nil, 5) --Светозарная буря
local countdownTempest2				= mod:NewCountdownFades("Alt7", 198263, nil, nil, 5) --Светозарная буря
local countdownRunicBrand			= mod:NewCountdown("Alt54", 197961, nil, nil, 5) --Руническое клеймо

mod:AddSetIconOption("SetIconOnSurge", 198750, true, true, {8})
mod:AddSetIconOption("SetIconOnRunicBrand", 197961, true, false, {6, 4, 3, 2, 1}) --Руническое клеймо

mod.vb.temptestMode = 1
mod.vb.tempestCount = 0
mod.vb.brandCount = 0

function mod:OnCombatStart(delay) --Прошляпанное очко мурчаля ✔
	self.vb.temptestMode = 1
	self.vb.tempestCount = 0
	self.vb.brandCount = 0
	if not self:IsNormal() then
		timerTempestCD:Start(24-delay, 1) --Светозарная буря+++
		countdownTempest:Start(24-delay) --Светозарная буря+++
		timerShatterSpearsCD:Start(40-delay) --Расколотые копья+++
		timerRunicBrandCD:Start(44.5-delay, 1) --Руническое клеймо+++
		countdownRunicBrand:Start(44.5-delay) --Руническое клеймо+++
		timerAddCD:Start(18-delay) --Призыв закаленного бурей воина+++
		specWarnSpear:Schedule(8-delay) --Копье света+++
		specWarnSpear:ScheduleVoice(8-delay, "watchstep") --Копье света+++
		specWarnSpear:Schedule(16-delay) --Копье света+++
		specWarnSpear:ScheduleVoice(16-delay, "watchstep") --Копье света+++
		specWarnAdd:Schedule(19-delay) --Призыв закаленного бурей воина+++
		specWarnAdd:ScheduleVoice(19-delay, "mobkill") --Призыв закаленного бурей воина+++
	else
		timerTempestCD:Start(24-delay, 1) --Светозарная буря+++
		countdownTempest:Start(24-delay) --Светозарная буря+++
		timerShatterSpearsCD:Start(40-delay) --Расколотые копья+++
		timerRunicBrandCD:Start(44.5-delay, 1) --Руническое клеймо+++
		countdownRunicBrand:Start(44.5-delay) --Руническое клеймо+++
		specWarnSpear:Schedule(8-delay) --Копье света+++
		specWarnSpear:ScheduleVoice(8-delay, "watchstep") --Копье света+++
		specWarnSpear:Schedule(16-delay) --Копье света+++
		specWarnSpear:ScheduleVoice(16-delay, "watchstep") --Копье света+++
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 198263 then --Светозарная буря
		self.vb.tempestCount = self.vb.tempestCount + 1
		if not UnitIsDeadOrGhost("player") then
			specWarnTempest:Show(self.vb.tempestCount)
			specWarnTempest:Play("runout")
		end
		timerTempestCast:Start()
		countdownTempest2:Start()
		timerTempestCD:Start(nil, self.vb.tempestCount+1)
		countdownTempest:Start()
		specWarnSpear:Schedule(10) -- 1
		specWarnSpear:ScheduleVoice(10, "watchstep")
		specWarnSpear:Schedule(41) -- 2
		specWarnSpear:ScheduleVoice(41, "watchstep")
		specWarnSpear:Schedule(49) -- 3
		specWarnSpear:ScheduleVoice(49, "watchstep")
		if not self:IsNormal() then
			timerAddCD:Start(50)
			specWarnAdd:Schedule(51)
			specWarnAdd:ScheduleVoice(51, "mobkill")
		end
	elseif spellId == 198077 then
		if not UnitIsDeadOrGhost("player") then
			specWarnShatterSpears:Show()
			specWarnShatterSpears:Play("watchorb")
		end
		timerShatterSpearsCD:Start()
	elseif spellId == 198750 then --Импульс
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnSurge:Show()
			specWarnSurge:Play("kickcast")
		else
			specWarnSurge:Show()
			specWarnSurge:Play("kickcast")
		end
		if self.Options.SetIconOnSurge then
			self:SetIcon(args.sourceGUID, 8, 15)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 197961 then
		self.vb.brandCount = self.vb.brandCount + 1
		timerRunicBrandCD:Start(nil, self.vb.tempestCount+1)
		countdownRunicBrand:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 197963 and args:IsPlayer() then--Purple K (NE)
		specWarnRunicBrand:Show("|TInterface\\Icons\\Boss_OdunRunes_Purple.blp:12:12|t")
		specWarnRunicBrand:Play("frontright")
		timerRunicBrand:Start(args.destName)
		if self.Options.SetIconOnRunicBrand then
			self:SetIcon(args.destName, 3, 12)
		end
	elseif spellId == 197964 and args:IsPlayer() then--Orange N (SE)
		specWarnRunicBrand2:Show("|TInterface\\Icons\\Boss_OdunRunes_Orange.blp:12:12|t")
		specWarnRunicBrand:Play("backright")
		timerRunicBrand:Start(args.destName)
		if self.Options.SetIconOnRunicBrand then
			self:SetIcon(args.destName, 2, 12)
		end
	elseif spellId == 197965 and args:IsPlayer() then--Yellow H (SW)
		specWarnRunicBrand3:Show("|TInterface\\Icons\\Boss_OdunRunes_Yellow.blp:12:12|t")
		specWarnRunicBrand:Play("backleft")
		timerRunicBrand:Start(args.destName)
		if self.Options.SetIconOnRunicBrand then
			self:SetIcon(args.destName, 1, 12)
		end
	elseif spellId == 197966 and args:IsPlayer() then--Blue fishies (NW)
		specWarnRunicBrand4:Show("|TInterface\\Icons\\Boss_OdunRunes_Blue.blp:12:12|t")
		specWarnRunicBrand:Play("frontleft")
		timerRunicBrand:Start(args.destName)
		if self.Options.SetIconOnRunicBrand then
			self:SetIcon(args.destName, 6, 12)
		end
	elseif spellId == 197967 and args:IsPlayer() then--Green box (N)
		specWarnRunicBrand5:Show("|TInterface\\Icons\\Boss_OdunRunes_Green.blp:12:12|t")
		specWarnRunicBrand:Play("frontcenter")--Does not exist yet
		timerRunicBrand:Start(args.destName)
		if self.Options.SetIconOnRunicBrand then
			self:SetIcon(args.destName, 4, 12)
		end
	elseif spellId == 198190 then --Недостойность
		warnUnworthy:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnUnworthy:Show()
			specWarnUnworthy:Play("targetyou")
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 197963 and args:IsPlayer() then--Purple K (NE)
		timerRunicBrand:Cancel(args.destName)
		if self.Options.SetIconOnRunicBrand then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 197964 and args:IsPlayer() then--Orange N (SE)
		timerRunicBrand:Cancel(args.destName)
		if self.Options.SetIconOnRunicBrand then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 197965 and args:IsPlayer() then--Yellow H (SW)
		timerRunicBrand:Cancel(args.destName)
		if self.Options.SetIconOnRunicBrand then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 197966 and args:IsPlayer() then--Blue fishies (NW)
		timerRunicBrand:Cancel(args.destName)
		if self.Options.SetIconOnRunicBrand then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 197967 and args:IsPlayer() then--Green box (N)
		timerRunicBrand:Cancel(args.destName)
		if self.Options.SetIconOnRunicBrand then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:CHAT_MSG_MONSTER_SAY(msg)
	if msg == L.Proshlyapen then
		DBM:EndCombat(self)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 198396 then
		warnSpear:Show()
	end
end
