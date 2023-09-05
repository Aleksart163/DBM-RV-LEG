local mod	= DBM:NewMod("Auriaya", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
mod:SetCreatureID(33515)
mod:SetUsedIcons(8, 7)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START 64678 64389 64386 64688 64422",
	"SPELL_AURA_APPLIED 64396 64455 64386",
	"SPELL_AURA_REMOVED 64386",
	"SPELL_DAMAGE 64459 64675",
	"SPELL_MISSED 64459 64675",
	"SPELL_ABSORBED 64459 64675",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

local warnSwarm 				= mod:NewTargetAnnounce(64396, 2)
local warnFear 					= mod:NewSpellAnnounce(64386, 3) --Ужасающий визг
local warnFearSoon	 			= mod:NewSoonAnnounce(64386, 1) --Ужасающий визг
local warnCatDied 				= mod:NewAnnounce("WarnCatDied", 3, 64455)
local warnCatDiedOne			= mod:NewAnnounce("WarnCatDiedOne", 3, 64455)

local specWarnFeralDefender		= mod:NewSpecialWarningSwitch("ej17358", "-Healer", nil, nil, 2, 5) --Активация дикого защитника
local specWarnSwarm				= mod:NewSpecialWarningYou(64396, nil, nil, nil, 2, 2) --Крадущиеся стражи
local specWarnSentinelBlast		= mod:NewSpecialWarningInterrupt(64678, "HasInterrupt", nil, nil, 3, 5) --Удар часового
local specWarnVoid 				= mod:NewSpecialWarningYouMove(64675, nil, nil, nil, 1, 3) --Сочащаяся дикая сущность
local specWarnSonic				= mod:NewSpecialWarningYouDefensive(64688, nil, nil, nil, 5, 6) --Ультразвуковой визг
local specWarnSonic2			= mod:NewSpecialWarningMoveTo(64688, nil, nil, nil, 3, 5) --Ультразвуковой визг

local timerDefender 			= mod:NewTimer(35, "timerDefender")
local timerNextFear 			= mod:NewNextTimer(35.5, 64386, nil, nil, nil, 7) --Ужасающий визг
local timerFear					= mod:NewCastTimer(2, 64386, nil, nil, nil, 7) --Ужасающий визг
local timerNextSwarm 			= mod:NewNextTimer(36, 64396)
local timerNextSonic 			= mod:NewNextTimer(27, 64688, nil, nil, nil, 3, nil, DBM_CORE_TANK_ICON..DBM_CORE_DEADLY_ICON) --Ультразвуковой визг
local timerSonic				= mod:NewCastTimer(2.5, 64688, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Ультразвуковой визг
local enrageTimer				= mod:NewBerserkTimer(600)

local yellSwarm					= mod:NewYellHelp(64396, nil, nil, nil, "YELL") --Крадущиеся стражи

mod:AddSetIconOption("SetIconOnSonicTarget", 64688, true, false, {8}) --Ультразвуковой визг
mod:AddSetIconOption("SetIconOnSwarmTarget", 64396, true, false, {7}) --Крадущиеся стражи

local isFeared = false
local catLives = 9

function mod:MurchalProshlyapTarget(targetname, uId) --Прошляпанное очко Мурчаля [✔]
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnSonic:Show()
		specWarnSonic:Play("defensive")
	else
		specWarnSonic2:Show(targetname)
		specWarnSonic2:Play("runin")
	end
	if self.Options.SetIconOnSonicTarget then
		self:SetIcon(targetname, 8, 5) 
	end
end

function mod:OnCombatStart(delay)
	catLives = 9
	enrageTimer:Start(-delay)
	warnFearSoon:Schedule(33-delay) --Ужасающий визг
	timerNextFear:Start(38-delay) --Ужасающий визг
	timerNextSonic:Start(50.5-delay)
	timerDefender:Start(64.5-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 64678 or spellId == 64389 then --Удар часового
		specWarnSentinelBlast:Show()
		specWarnSentinelBlast:Play("kickcast")
	elseif spellId == 64386 then --Ужасающий визг
		warnFear:Show()
		timerFear:Start()
		timerNextFear:Schedule(2)
		warnFearSoon:Schedule(34)
	elseif spellId == 64688 or spellId == 64422 then --Ультразвуковой визг
		self:BossTargetScanner(args.sourceGUID, "MurchalProshlyapTarget", 0.1, 2)
		timerSonic:Start()
		timerNextSonic:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 64396 then --Крадущиеся стражи
		if args:IsPlayer() then
			specWarnSwarm:Show()
			specWarnSwarm:Play("targetyou")
			yellSwarm:Yell()
		else
			warnSwarm:Show(args.destName)
		end
		if self.Options.SetIconOnSwarmTarget then
			self:SetIcon(args.destName, 7, 5) 
		end
		timerNextSwarm:Start()
	elseif spellId == 64455 then --Дикая сущность
	--	DBM.BossHealth:AddBoss(34035, L.Defender:format(9))
	elseif spellId == 64386 and args:IsPlayer() then --Ужасающий визг
		isFeared = true		
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 64386 and args:IsPlayer() then --Ужасающий визг
		isFeared = false	
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 34035 then
		catLives = catLives - 1
		if catLives > 0 then
			if catLives == 1 then
				warnCatDiedOne:Show()
				timerDefender:Start()
			else
				warnCatDied:Show(catLives)
				timerDefender:Start()
         	end
		end
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 64459 or spellId == 64675 and destGUID == UnitGUID("player") and self:AntiSpam(1, "proshlyapation") then
		specWarnVoid:Show()
		specWarnVoid:Play("runout")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE
mod.SPELL_ABSORBED = mod.SPELL_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 64449 then --Активация дикого защитника
		if not UnitIsDeadOrGhost("player") then
			specWarnFeralDefender:Schedule(3)
			specWarnFeralDefender:ScheduleVoice(3, "mobkill")
		end
	end
end
