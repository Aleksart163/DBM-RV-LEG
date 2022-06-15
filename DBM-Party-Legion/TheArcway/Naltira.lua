local mod	= DBM:NewMod(1500, "DBM-Party-Legion", 6, 726)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(98207)
mod:SetEncounterID(1826)
mod:SetZone()
mod:SetUsedIcons(8, 7)

mod.noNormal = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 200284",
	"SPELL_AURA_REMOVED 200284",
	"SPELL_CAST_START 200227 200024",
	"SPELL_PERIODIC_DAMAGE 200040",
	"SPELL_PERIODIC_MISSED 200040",
	"UNIT_SPELLCAST_SUCCEEDED boss1",
	"UNIT_SPELLCAST_CHANNEL_START boss1"
)

local warnBlink					= mod:NewTargetAnnounce(199811, 4) --Молниеносные удары
local warnWeb					= mod:NewTargetAnnounce(200284, 3) --Липкие путы

local specWarnWeb				= mod:NewSpecialWarningYouMoveAway(200284, nil, nil, nil, 4, 3) --Липкие путы
local specWarnWeb2				= mod:NewSpecialWarningYouFades(200284, nil, nil, nil, 1, 2) --Липкие путы
local specWarnBlink				= mod:NewSpecialWarningRun(199811, nil, nil, nil, 4, 2) --Молниеносные удары
local specWarnBlinkNear			= mod:NewSpecialWarningClose(199811, nil, nil, nil, 1, 2) --Молниеносные удары
local specWarnVenomGTFO			= mod:NewSpecialWarningYouMove(200040, nil, nil, nil, 1, 2) --Яд Пустоты
--кд спеллов не проверял
local timerBlinkCD				= mod:NewNextTimer(30, 199811, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Молниеносные удары
local timerWebCD				= mod:NewCDTimer(24, 200227, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Липкие путы 21-26
local timerVenomCD				= mod:NewCDTimer(29.8, 200024, nil, nil, nil, 3) --Яд Пустоты 30-33

local yellBlink					= mod:NewYell(199811, nil, false, nil, "YELL") --Молниеносные удары
local yellWeb					= mod:NewYell(200284, nil, nil, nil, "YELL") --Липкие путы

mod:AddSetIconOption("SetIconOnWeb", 200284, true, false, {8, 7}) --Липкие путы

mod.vb.blinkCount = 0
mod.vb.webIcon = 8

function mod:OnCombatStart(delay) --все проверил
	self.vb.blinkCount = 0
	self.vb.webIcon = 8
	timerBlinkCD:Start(15.6-delay) --Молниеносные удары +1сек
	timerVenomCD:Start(25-delay) --Яд Пустоты
	timerWebCD:Start(35-delay) --Липкие путы
end

function mod:SPELL_AURA_APPLIED(args) 
	local spellId = args.spellId
	if spellId == 200284 then --все проверил
		self.vb.webIcon = self.vb.webIcon - 1
		warnWeb:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnWeb:Show()
			yellWeb:Yell()
		end
		if self.Options.SetIconOnWeb then
			self:SetIcon(args.destName, self.vb.webIcon)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 200284 then --все проверил
		self.vb.webIcon = self.vb.webIcon + 1
		if args:IsPlayer() then
			specWarnWeb2:Show()
		end
		if self.Options.SetIconOnWeb then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 200227 then
		timerWebCD:Start()
	elseif spellId == 200024 and self:AntiSpam(5, 3) then
		timerVenomCD:Start()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 200040 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		if not self:IsNormal() then
			specWarnVenomGTFO:Show()
			specWarnVenomGTFO:Play("runaway")
		end
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 199809 then--Blink Strikes begin
		timerBlinkCD:Start()
		self.vb.blinkCount = 0
	end
end

--UNIT_SPELLCAST_CHANNEL_STOP method dropped, not because it wasn't returning a valid target, but because DBMs target scanner methods don't work well with pets and fail to announce all strikes because of it
--This method doesn't require target scanning but is 0.6 seconds slower, but won't have a chance to fail if boss targets stupid things like army or spirit beast.
function mod:UNIT_SPELLCAST_CHANNEL_START(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 199811 then--Blink Strikes Channel ending
		self.vb.blinkCount = self.vb.blinkCount + 1
		local targetname = UnitExists("boss1target") and UnitName("boss1target")
		if not targetname then 
			return
		end
		if UnitIsUnit("boss1target", "player") then
			specWarnBlink:Show()
			specWarnBlink:Play("runaway")
			yellBlink:Yell()
		elseif self:CheckNearby(5, targetname) and self:AntiSpam(2.5, 2) then
			specWarnBlinkNear:Show(targetname)
			specWarnBlinkNear:Play("runaway")
		else
			warnBlink:Show(targetname)
		end
		if self.vb.blinkCount == 2 then
			timerBlinkCD:Start(24.5)
			self.vb.blinkCount = 0
		end
	end
end
