local mod	= DBM:NewMod("IronCouncil", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
--mod:SetCreatureID(32927)
mod:SetCreatureID(32927, 32867, 32857)
mod:SetUsedIcons(8, 7, 6, 5, 4, 3, 2, 1)
mod:SetBossHPInfoToHighest()

mod:RegisterCombat("combat")
--mod:RegisterCombat("combat", 32867, 32927, 32857)

mod:RegisterEvents(
	"SPELL_CAST_START 61920 63479 61879 63483 61915 61903 63493 62274 63489 62273",
	"SPELL_CAST_SUCCESS 63490 62269 64321 61974 61869 63481",
	"SPELL_AURA_APPLIED 61903 63493 62269 63490 62277 63967 64637 61888 63486 61887 61912 63494"
)

--mod:AddBoolOption("HealthFrame", true)

--[[
mod:SetBossHealthInfo(
	32867, L.Steelbreaker,
	32927, L.RunemasterMolgeim,
	32857, L.StormcallerBrundir
)]]

local warnSupercharge			= mod:NewSpellAnnounce(61920, 3)

--Буревестник Брундир
local warnChainlight			= mod:NewSpellAnnounce(64215, 1)
local timerOverload				= mod:NewCastTimer(6, 63481)
local timerLightningWhirl		= mod:NewCastTimer(5, 63483)
local specwarnLightningTendrils	= mod:NewSpecialWarningRun(63486)
local timerLightningTendrils	= mod:NewBuffActiveTimer(27, 63486)
local specwarnOverload			= mod:NewSpecialWarningRun(63481) 
--Сталелом
local warnFusionPunch			= mod:NewSpellAnnounce(61903, 4)
local timerFusionPunchCast		= mod:NewCastTimer(3, 61903)
local timerFusionPunchActive	= mod:NewTargetTimer(4, 61903)
local warnOverwhelmingPower		= mod:NewTargetAnnounce(61888, 2)
local timerOverwhelmingPower	= mod:NewTargetTimer(25, 61888)
local warnStaticDisruption		= mod:NewTargetAnnounce(61912, 3)
--Мастер рун Молгейм
local timerShieldofRunes		= mod:NewBuffActiveTimer(15, 63967)
local warnRuneofPower			= mod:NewTargetAnnounce(64320, 2)
local warnRuneofDeath			= mod:NewSpellAnnounce(63490, 2)
local warnShieldofRunes			= mod:NewSpellAnnounce(63489, 2)
local warnRuneofSummoning		= mod:NewSpellAnnounce(62273, 3)
local specwarnRuneofDeath		= mod:NewSpecialWarningMove(63490)
local timerRuneofDeathDura		= mod:NewNextTimer(30, 63490)
local timerRuneofPower			= mod:NewCDTimer(30, 61974)
local timerRuneofDeath			= mod:NewCDTimer(30, 63490)
local enrageTimer				= mod:NewBerserkTimer(900)

mod:AddBoolOption("PlaySoundDeathRune", true, "announce")
mod:AddSetIconOption("SetIconOnOverwhelmingPower", 64637, true, false, {8})
mod:AddSetIconOption("SetIconOnStaticDisruption", 61912, true, false, {7, 6, 5, 4, 3, 2, 1})
mod:AddBoolOption("AlwaysWarnOnOverload", false, "announce")
mod:AddBoolOption("PlaySoundOnOverload", true)
mod:AddBoolOption("PlaySoundLightningTendrils", true)

local disruptTargets = {}
local disruptIcon = 7

function mod:OnCombatStart(delay)
	enrageTimer:Start(-delay)
	table.wipe(disruptTargets)
	disruptIcon = 7
end

function mod:RuneTarget()
	local targetname = self:GetBossTarget(32927)
	if not targetname then return end
	warnRuneofPower:Show(targetname)
end

local function warnStaticDisruptionTargets()
	warnStaticDisruption:Show(table.concat(disruptTargets, "<, >"))
	table.wipe(disruptTargets)
	disruptIcon = 7
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if args.spellId == 61920 then --Суперзаряд
		warnSupercharge:Show()
	elseif spellId == 63479 or spellId == 61879 then --Цепная молния
		warnChainlight:Show()
	elseif spellId == 63483 or spellId == 61915 then --Вихрь молний
		timerLightningWhirl:Start()
	elseif spellId == 61903 or spellId == 63493 then --Энергетический удар
		warnFusionPunch:Show()
		timerFusionPunchCast:Start()
	elseif spellId == 62274 or spellId == 63489 then --Рунический щит
		warnShieldofRunes:Show()
	elseif spellId == 62273 then --Руна призыва
		warnRuneofSummoning:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 63490 or spellId == 62269 then --Руна смерти
		warnRuneofDeath:Show()
		timerRuneofDeathDura:Start()
	elseif spellId == 64321 or spellId == 61974 then --Руна мощи
		self:ScheduleMethod(0.1, "RuneTarget")
		timerRuneofPower:Start()
	elseif spellId == 61869 or spellId == 63481 then --Перегрузка
		timerOverload:Start()
	--	if self.Options.AlwaysWarnOnOverload or UnitName("target") == L.StormcallerBrundir then
		if self.Options.AlwaysWarnOnOverload then
			specwarnOverload:Show()
			if self.Options.PlaySoundOnOverload then
				PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
			end
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 61903 or spellId == 63493 then --Энергетический удар
		timerFusionPunchActive:Start(args.destName)
	elseif spellId == 62269 or spellId == 63490 then --Руна смерти
		if args:IsPlayer() then
			specwarnRuneofDeath:Show()
			if self.Options.PlaySoundDeathRune then
				PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
			end
		end
	elseif spellId == 62277 or spellId == 63967 and not args:IsDestTypePlayer() then --Рунический щит
		timerShieldofRunes:Start()
	elseif spellId == 64637 or spellId == 61888 then --Переполняющая энергия
		warnOverwhelmingPower:Show(args.destName)
--[[		if mod:IsDifficulty("heroic10") then
			timerOverwhelmingPower:Start(60, args.destName)
		else]]
		timerOverwhelmingPower:Start(35, args.destName)
--		end
		if self.Options.SetIconOnOverwhelmingPower then
--[[			if mod:IsDifficulty("heroic10") then
				self:SetIcon(args.destName, 8, 60) -- skull for 60 seconds (until meltdown)
			else]]
			self:SetIcon(args.destName, 8, 35) -- skull for 35 seconds (until meltdown)
--			end
		end
	elseif spellId == 63486 or spellId == 61887 then --Живые молнии
		timerLightningTendrils:Start()
		specwarnLightningTendrils:Show()
		if self.Options.PlaySoundLightningTendrils then
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
		end
	elseif spellId == 61912 or spellId == 63494 then --Статический сбой
		disruptTargets[#disruptTargets + 1] = args.destName
		if self.Options.SetIconOnStaticDisruption then 
			self:SetIcon(args.destName, disruptIcon, 20)
			disruptIcon = disruptIcon - 1
		end
		self:Unschedule(warnStaticDisruptionTargets)
		self:Schedule(0.3, warnStaticDisruptionTargets)
	end
end
