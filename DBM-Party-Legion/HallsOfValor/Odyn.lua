local mod	= DBM:NewMod(1489, "DBM-Party-Legion", 4, 721)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(95676)
mod:SetEncounterID(1809)
mod:SetZone()
mod:SetUsedIcons(8, 6, 4, 3, 2, 1)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 197963 197964 197965 197966 197967",
	"SPELL_AURA_REMOVED 197963 197964 197965 197966 197967",
	"SPELL_CAST_START 198263 198077 198750",
	"SPELL_CAST_SUCCESS 197961",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--http://legion.wowhead.com/icons/name:boss_odunrunes_
--["198263-Radiant Tempest"] = "pull:8.0, 72.0, 40.0", huh?
local warnSpear						= mod:NewSpellAnnounce(198072, 2) --Копье света
local warnSurge						= mod:NewCastAnnounce(198750, 4) --Импульс

local specWarnTempest				= mod:NewSpecialWarningRun(198263, nil, nil, nil, 4, 5) --Светозарная буря
local specWarnShatterSpears			= mod:NewSpecialWarningDodge(198077, nil, nil, nil, 2, 2) --Расколотые копья
local specWarnSpear					= mod:NewSpecialWarningDodge(198072, nil, nil, nil, 2, 2) --Копье света
local specWarnRunicBrand			= mod:NewSpecialWarningYouMoveToPos(197963, nil, nil, nil, 4, 5) --Руническое клеймо фиолетовая
local specWarnRunicBrand2			= mod:NewSpecialWarningYouMoveToPos(197964, nil, nil, nil, 4, 5) --Руническое клеймо оранжевая
local specWarnRunicBrand3			= mod:NewSpecialWarningYouMoveToPos(197965, nil, nil, nil, 4, 5) --Руническое клеймо желтая
local specWarnRunicBrand4			= mod:NewSpecialWarningYouMoveToPos(197966, nil, nil, nil, 4, 5) --Руническое клеймо синяя
local specWarnRunicBrand5			= mod:NewSpecialWarningYouMoveToPos(197967, nil, nil, nil, 4, 5) --Руническое клеймо зеленая
local specWarnAdd					= mod:NewSpecialWarningSwitch(201221, "-Healer", nil, nil, 1, 2) --Призыв закаленного бурей воина
local specWarnSurge					= mod:NewSpecialWarningInterrupt(198750, "HasInterrupt", nil, nil, 1, 2) --Импульс

--local timerSpearCD					= mod:NewCDTimer(8, 198077, nil, nil, nil, 3)--More data needed
local timerTempestCD				= mod:NewCDCountTimer(56, 198263, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Светозарная буря
local timerShatterSpearsCD			= mod:NewCDTimer(56, 198077, nil, nil, nil, 2) --Расколотые копья
local timerRunicBrandCD				= mod:NewCDCountTimer(56, 197961, nil, nil, nil, 7) --Руническое клеймо
local timerRunicBrand				= mod:NewTargetTimer(12, 197961, nil, nil, nil, 7) --Руническое клеймо
local timerAddCD					= mod:NewCDTimer(54, 201221, nil, nil, nil, 1, 201215) --Призыв закаленного бурей воина 54-58

local countdownTempest				= mod:NewCountdown(56, 198263, nil, nil, 5) --Светозарная буря

mod:AddSetIconOption("SetIconOnSurge", 198750, true, false, {8})
mod:AddSetIconOption("SetIconOnRunicBrand", 197961, true, false, {6, 4, 3, 2, 1}) --Руническое клеймо

--Boss has (at least) three timer modes, cannot determine which one on pull so on fly figuring out is used
local tempestTimers = {
	[1] = {8, 56, 72},
	[2] = {16, 48, 64},--If such a beast exists, it'll look like this based on theory. This sequence is COPMLETE guesswork
	[3] = {24, 56, 56}, --на 2 было 40
	[4] = {32, 32, 48},--32 and 48 are guessed based on theory
}
local brandTimers = {44, 56}
mod.vb.temptestMode = 1
mod.vb.tempestCount = 0
mod.vb.brandCount = 0

--Should run at 10, 18, 26, and 34
local function tempestDelayed(self)
	if self.vb.tempestCount == 0 then
		DBM:AddMsg(L.tempestModeMessage:format(self.vb.temptestMode))
		self.vb.temptestMode = self.vb.temptestMode + 1
		self:Schedule(8, tempestDelayed, self)
		timerTempestCD:Start(6, 1)
	else
		return
	end
end

function mod:OnCombatStart(delay)
	self.vb.temptestMode = 1
	self.vb.tempestCount = 0
	self.vb.brandCount = 0
	if self:IsHard() then
		timerTempestCD:Start(24-delay, 1) --Светозарная буря
		countdownTempest:Start(24-delay) --Светозарная буря
		timerShatterSpearsCD:Start(40-delay) --Расколотые копья
		timerRunicBrandCD:Start(44.5-delay, 1) --Руническое клеймо
		timerAddCD:Start(18-delay) --Призыв закаленного бурей воина
	else
		timerTempestCD:Start(8-delay, 1) --Светозарная буря
		self:Schedule(10, tempestDelayed, self, 1)
		timerShatterSpearsCD:Start(40-delay) --Расколотые копья
		timerRunicBrandCD:Start(44.5-delay, 1) --Руническое клеймо
		timerAddCD:Start(18-delay) --Призыв закаленного бурей воина
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 197963 and args:IsPlayer() then--Purple K (NE)
		specWarnRunicBrand:Show(self:IconNumToTexture(3))
		specWarnRunicBrand:Play("frontright")
		timerRunicBrand:Start(args.destName)
		if self.Options.SetIconOnRunicBrand then
			self:SetIcon(args.destName, 3, 12)
		end
	elseif spellId == 197964 and args:IsPlayer() then--Orange N (SE)
		specWarnRunicBrand2:Show(self:IconNumToTexture(2))
		specWarnRunicBrand:Play("backright")
		timerRunicBrand:Start(args.destName)
		if self.Options.SetIconOnRunicBrand then
			self:SetIcon(args.destName, 2, 12)
		end
	elseif spellId == 197965 and args:IsPlayer() then--Yellow H (SW)
		specWarnRunicBrand3:Show(self:IconNumToTexture(1))
		specWarnRunicBrand:Play("backleft")
		timerRunicBrand:Start(args.destName)
		if self.Options.SetIconOnRunicBrand then
			self:SetIcon(args.destName, 1, 12)
		end
	elseif spellId == 197966 and args:IsPlayer() then--Blue fishies (NW)
		specWarnRunicBrand4:Show(self:IconNumToTexture(6))
		specWarnRunicBrand:Play("frontleft")
		timerRunicBrand:Start(args.destName)
		if self.Options.SetIconOnRunicBrand then
			self:SetIcon(args.destName, 6, 12)
		end
	elseif spellId == 197967 and args:IsPlayer() then--Green box (N)
		specWarnRunicBrand5:Show(self:IconNumToTexture(4))
		specWarnRunicBrand:Play("frontcenter")--Does not exist yet
		timerRunicBrand:Start(args.destName)
		if self.Options.SetIconOnRunicBrand then
			self:SetIcon(args.destName, 4, 12)
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
		timerCrushArmor:Cancel(args.destName)
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

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 198072 then
		warnSpear:Show()
		specWarnSpear:Show()
	elseif spellId == 198263 then
		self.vb.tempestCount = self.vb.tempestCount + 1
		specWarnTempest:Show(self.vb.tempestCount)
		specWarnTempest:Play("runout")
--		timerSpearCD:Start(12)
		local timers = tempestTimers[self.vb.temptestMode]
		if timers then
			local nextCast = self.vb.tempestCount+1
			if timers[nextCast] then
				timerTempestCD:Start(timers[nextCast], nextCast)
				countdownTempest:Start(timers[nextCast], nextCast)
			end
		end
	elseif spellId == 198077 then
		specWarnShatterSpears:Show()
		specWarnShatterSpears:Play("watchorb")
		timerShatterSpearsCD:Start()
	elseif spellId == 198750 then --Импульс
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnSurge:Show()
			specWarnSurge:Play("kickcast")
		else
			warnSurge:Show()
			warnSurge:Play("kickcast")
		end
		if self.Options.SetIconOnSurge then
			self:SetIcon(args.sourceGUID, 8, 15)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 197961 then
		self.vb.brandCount = self.vb.brandCount + 1
--		timerSpearCD:Start(18)
		local nextCount = self.vb.brandCount+1
		local timer = brandTimers[nextCount]
		if timer then
			timerRunicBrandCD:Start(timer, nextCount)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 198396 then
		warnSpear:Show()
	elseif spellId == 201221 then--Summon Stormforged
		specWarnAdd:Show()
		specWarnAdd:Play("killmob")
		timerAddCD:Start()
	end
end
