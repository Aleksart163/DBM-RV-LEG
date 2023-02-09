local mod	= DBM:NewMod(673, "DBM-Party-MoP", 3, 312)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(56747)--56747 (Gu Cloudstrike), 56754 (Azure Serpent)
mod:SetEncounterID(1303)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 110945 110852",
	"SPELL_AURA_REMOVED 110945",
	"SPELL_CAST_START 106923 106984 102573 107140",
	"UNIT_DIED"
)


local warnStaticField			= mod:NewAnnounce("warnStaticField", 3, 106923)--Target scanning verified working
local warnChargingSoul			= mod:NewSpellAnnounce(110945, 3)--Phase 2
local warnLightningBreath		= mod:NewSpellAnnounce(102573, 3)
local warnMagneticShroud		= mod:NewSpellAnnounce(107140, 4)
local warnOverchargedSoul		= mod:NewSpellAnnounce(110852, 3)--Phase 3

local specWarnInvokeLightning	= mod:NewSpecialWarningKeepDist(106984, nil, nil, nil, 2, 2) --Вызов молнии
local specWarnChargingSoul		= mod:NewSpecialWarningSwitch(110945, "-Healer", nil, nil, 1, 2) --Укрепленная душа
local specWarnStaticField		= mod:NewSpecialWarningMove(106923, nil, nil, nil, 1, 2) --Статическое поле
local specWarnStaticFieldNear	= mod:NewSpecialWarningCloseMoveAway(106923, nil, nil, nil, 2, 2) --Статическое поле
local specWarnMagneticShroud	= mod:NewSpecialWarningRunning(107140, nil, nil, nil, 4, 3) --Магнитный покров

local timerInvokeLightningCD	= mod:NewNextTimer(6, 106984)--Phase 1 ability
local timerStaticFieldCD		= mod:NewNextTimer(8, 106923, nil, nil, nil, 3)--^^
local timerLightningBreathCD	= mod:NewCDTimer(6.8, 102573, nil, nil, nil, 5)--6.8-10 ish Phase 2 ability
local timerMagneticShroudCD		= mod:NewCDTimer(12.5, 107140)--^^

local yellStaticField			= mod:NewYell(106923, nil, nil, nil, "YELL") --Статическое поле

local staticFieldText = DBM:GetSpellInfo(106923)
-- very poor code. not clean. (to replace %%s -> %s)
local targetFormatText
do
	local originalText = DBM_CORE_AUTO_ANNOUNCE_TEXTS.target
	local startIndex = string.find(originalText, "%%%%")
	local tmp1 = string.sub(originalText, 1, startIndex)
	local tmp2 = string.sub(originalText, startIndex+2)
	targetFormatText = tmp1..tmp2
end

function mod:StaticFieldTarget(targetname, uId)
	if not targetname then--No one is targeting/focusing the cloud serpent, so just use generic warning
		staticFieldText = DBM:GetSpellInfo(106923)
		warnStaticField:Show(staticFieldText)
	else--We have a valid target, so use target warnings.
		staticFieldText = targetFormatText:format(DBM:GetSpellInfo(106923), targetname)
		warnStaticField:Show(staticFieldText)
		if targetname == UnitName("player") then
			specWarnStaticField:Show()
			yellStaticField:Yell()
		else
			if uId then
				local inRange = DBM.RangeCheck:GetDistance("player", uId)
				if inRange and inRange < 6 then
					specWarnStaticFieldNear:Show(targetname)
				end
			end
		end
	end
end

function mod:OnCombatStart(delay)
	timerInvokeLightningCD:Start(-delay)
	timerStaticFieldCD:Start(18-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 110945 then
		warnChargingSoul:Show()
		specWarnInvokeLightning:Cancel()
		specWarnChargingSoul:Show()
		specWarnChargingSoul:Play("mobkill")
		timerStaticFieldCD:Cancel()
		timerLightningBreathCD:Start()
		timerMagneticShroudCD:Start(20)
	elseif args.spellId == 110852 then
		warnOverchargedSoul:Show()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 110945 then
		specWarnInvokeLightning:Cancel()
		timerStaticFieldCD:Cancel()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 106923 then
		self:BossTargetScanner(56754, "StaticFieldTarget", 0.05, 20)
		timerStaticFieldCD:Start()
	elseif args.spellId == 106984 then
		specWarnInvokeLightning:Show(8)
		specWarnInvokeLightning:Play("watchstep")
		timerInvokeLightningCD:Start()
	elseif args.spellId == 102573 then
		warnLightningBreath:Show()
		timerLightningBreathCD:Start()
	elseif args.spellId == 107140 then
		warnMagneticShroud:Show()
		specWarnMagneticShroud:Show()
		specWarnMagneticShroud:Play("justrun")
		timerMagneticShroudCD:Start()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 56754 then
		timerMagneticShroudCD:Cancel()
		timerStaticFieldCD:Cancel()
		timerLightningBreathCD:Cancel()
	end
end
