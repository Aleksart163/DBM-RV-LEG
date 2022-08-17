local mod	= DBM:NewMod(1997, "DBM-AntorusBurningThrone", nil, 946)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(122369, 122333, 122367)--Chief Engineer Ishkar, General Erodus, Admiral Svirax
mod:SetEncounterID(2070)
mod:SetZone()
mod:SetBossHPInfoToHighest()
mod:SetUsedIcons(8, 7, 6, 2, 1)
mod:SetHotfixNoticeRev(16939)
mod.respawnTime = 30

mod:RegisterCombat("combat")
--mod:RegisterCombat("combat_say", L.YellPullCouncil)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 244625 246505 253040 245227",
	"SPELL_CAST_SUCCESS 244722 244892 245227 253037 245174",
	"SPELL_AURA_APPLIED 244737 244892 253015 244172",
	"SPELL_AURA_APPLIED_DOSE 244892 244172",
	"SPELL_AURA_REMOVED 244737 253015",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3"
)

local Svirax = DBM:EJ_GetSectionInfo(16126)
local Ishkar = DBM:EJ_GetSectionInfo(16128)
local Erodus = DBM:EJ_GetSectionInfo(16130)
--TODO, boss health was reporting unknown in streams, verify/fix boss CIDs
--[[
(ability.id = 244625 or ability.id = 253040 or ability.id = 245227 or ability.id = 125012 or ability.id = 125014 or ability.id = 126258) and type = "begincast"
 or (ability.id = 244722 or ability.id = 244892) and type = "cast" or (ability.id = 245174 or ability.id = 244947) and type = "summon"
 or ability.id = 253015
--]]
--General
local warnOutofPod						= mod:NewTargetAnnounce("ej16098", 2, 244141) --Вне капсулы
local warnExploitWeakness				= mod:NewStackAnnounce(244892, 2, nil, "Tank") --Обнаружить слабое место
local warnPsychicAssault				= mod:NewStackAnnounce(244172, 3, nil, "-Tank", 2) --Псионная атака
--In Pod
----Chief Engineer Ishkar
local warnEntropicMine					= mod:NewSpellAnnounce(245161, 2) --Энтропическая мина
----General Erodus
--local warnSummonReinforcements			= mod:NewSpellAnnounce(245546, 2, nil, false, 2)
local warnDemonicCharge					= mod:NewTargetAnnounce(253040, 2, nil, "Ranged", 2) --Демонический рывок
--Out of Pod
----Admiral Svirax
local warnShockGrenade					= mod:NewTargetAnnounce(244737, 4, nil, true, 2) --Шоковая граната
----Chief Engineer Ishkar

--General
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)
local specWarnExploitWeakness			= mod:NewSpecialWarningStack(244892, nil, 3, nil, nil, 3, 5) --Обнаружить слабое место
local specWarnExploitWeaknesslf			= mod:NewSpecialWarningTaunt(244892, "Tank", nil, nil, 3, 5) --Обнаружить слабое место
local specWarnPsychicAssaultStack		= mod:NewSpecialWarningStack(244172, nil, 10, nil, nil, 1, 6) --Псионная атака
local specWarnPsychicAssault			= mod:NewSpecialWarningMove(244172, nil, nil, nil, 3, 2) --Псионная атака Two diff warnings cause we want to upgrade to high priority at 19+ stacks
local specWarnAssumeCommand				= mod:NewSpecialWarningSwitch(245227, "Dps|Tank", nil, nil, 1, 2) --Принять командование
--In Pod
----Admiral Svirax
local specWarnFusillade					= mod:NewSpecialWarningMoveTo(244625, nil, nil, nil, 1, 5) --Шквальный огонь
----Chief Engineer Ishkar
--local specWarnEntropicMine				= mod:NewSpecialWarningDodge(245161, nil, nil, nil, 1, 2)
----General Erodus
local specWarnSummonReinforcements		= mod:NewSpecialWarningSwitch(245546, "Dps|Tank", nil, nil, 1, 2) --Вызов подкрепления
-------Adds
local specWarnPyroblast					= mod:NewSpecialWarningInterrupt(246505, "HasInterrupt", nil, nil, 1, 2)
local specWarnDemonicChargeYou			= mod:NewSpecialWarningYou(253040, nil, nil, nil, 1, 2) --Демонический рывок
local specWarnDemonicCharge				= mod:NewSpecialWarningClose(253040, nil, nil, nil, 1, 2) --Демонический рывок
--Out of Pod
--Admiral Svirax
local specWarnShockGrenade				= mod:NewSpecialWarningYouMoveAway(244737, nil, nil, nil, 3, 5) --Шоковая граната
--General
mod:AddTimerLine(GENERAL)
local timerExploitWeaknessCD			= mod:NewCDTimer(8.5, 244892, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON) --Обнаружить слабое место
local timerShockGrenadeCD				= mod:NewCDTimer(12, 244722, nil, nil, nil, 3, nil, DBM_CORE_MYTHIC_ICON..DBM_CORE_DEADLY_ICON) --Шоковая граната
local timerAssumeCommandCD				= mod:NewNextTimer(90, 245227, nil, nil, nil, 6) --Принять командование
--In Pod
--Admiral Svirax
mod:AddTimerLine(Svirax)
local timerFusilladeCD					= mod:NewNextCountTimer(29.3, 244625, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Шквальный огонь
----Chief Engineer Ishkar
mod:AddTimerLine(Ishkar)
local timerEntropicMineCD				= mod:NewCDTimer(10, 245161, nil, nil, nil, 3) --Энтропическая мина
--General Erodus
mod:AddTimerLine(Erodus)
local timerSummonReinforcementsCD		= mod:NewNextTimer(8.4, 245546, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON) --Вызов подкрепления

local yellDemonicCharge					= mod:NewYell(253040, nil, nil, nil, "YELL") --Демонический рывок
local yellShockGrenade					= mod:NewYell(244737, nil, nil, nil, "YELL") --Шоковая граната
local yellShockGrenadeFades				= mod:NewShortFadesYell(244737, nil, nil, nil, "YELL") --Шоковая граната

--local berserkTimer						= mod:NewBerserkTimer(600)

--General
local countdownAssumeCommand			= mod:NewCountdown(50, 245227, nil, nil, 5) --Принять командование
local countdownExploitWeakness			= mod:NewCountdown("Alt8", 244892, "Tank", nil, 5) --Обнаружить слабое место
--In Pod
----Admiral Svirax
local countdownFusillade				= mod:NewCountdown("AltTwo30", 244625, nil, nil, 3) --Шквальный огонь
----General Erodus
--local countdownReinforcements			= mod:NewCountdown(25, 245546) --Вызов подкрепления

mod:AddSetIconOption("SetIconOnShockGrenade", 244737, true, false, {8, 7, 6}) --Шоковая граната
mod:AddSetIconOption("SetIconOnAdds", 245546, true, true, {2, 1}) --Вызов подкрепления
mod:AddRangeFrameOption("8")

local felShield = DBM:GetSpellInfo(244910)
mod.vb.FusilladeCount = 0
mod.vb.lastIcon = 1
mod.vb.ShockGrenadeIcon = 8

function mod:DemonicChargeTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		if self:AntiSpam(3, 5) then
			specWarnDemonicChargeYou:Show()
			specWarnDemonicChargeYou:Play("runaway")
			yellDemonicCharge:Yell()
		end
	elseif self:AntiSpam(3.5, 2) and self:CheckNearby(10, targetname) then --AntiSpam(3.5, 2)
		specWarnDemonicCharge:Show(targetname)
		specWarnDemonicCharge:Play("watchstep")
	else
		warnDemonicCharge:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	self.vb.FusilladeCount = 0
	self.vb.lastIcon = 1
	self.vb.ShockGrenadeIcon = 8
	--In pod
--	berserkTimer:Start(-delay)
	--Out of Pod
	timerSummonReinforcementsCD:Start(8-delay)
--	countdownReinforcements:Start(8-delay)
	timerAssumeCommandCD:Start(90-delay) --Принять командование
--	countdownAssumeCommand:Start(90-delay)
	if self:IsMythic() then
		timerShockGrenadeCD:Start(14-delay) --Шоковая граната -1сек 
		timerEntropicMineCD:Start(15-delay) --Энтропическая мина
		timerExploitWeaknessCD:Start(9-delay) --Обнаружить слабое место
	elseif self:IsHeroic() then
		timerEntropicMineCD:Start(15-delay) --Энтропическая мина+++
		timerExploitWeaknessCD:Start(9-delay) --Обнаружить слабое место +1
	else
		timerEntropicMineCD:Start(5.1-delay)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 244625 then
		self.vb.FusilladeCount = self.vb.FusilladeCount + 1
		specWarnFusillade:Show(felShield)
		specWarnFusillade:Play("findshield")
		timerFusilladeCD:Start(nil, self.vb.FusilladeCount+1)
		if not self:IsLFR() then
			countdownFusillade:Start(29.3)
		end
	elseif spellId == 246505 then
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnPyroblast:Show(args.sourceName)
			specWarnPyroblast:Play("kickcast")
		end
	elseif spellId == 253040 then
		self:BossTargetScanner(args.sourceGUID, "DemonicChargeTarget", 0.2, 9)
	elseif spellId == 245227 then --Принять командование (начало каста)
		specWarnAssumeCommand:Show()
		specWarnAssumeCommand:Play("targetchange")
		timerExploitWeaknessCD:Stop()
		countdownExploitWeakness:Cancel()
		timerExploitWeaknessCD:Start(8)--8-14 (basically depends how fast you get there) If you heroic leap and are super fast. it's cast pretty much instantly on mob activation
		countdownExploitWeakness:Start(8)
		local cid = self:GetCIDFromGUID(args.sourceGUID) --тот, кто кастует
		if cid == 122369 then --Главный инженер Ишкар Фаза 3
			timerShockGrenadeCD:Stop() --Шоковая граната
			timerSummonReinforcementsCD:Stop() --Вызов подкрепления
			timerFusilladeCD:Stop() --Шквальный огонь
			countdownFusillade:Cancel() --Шквальный огонь
			timerEntropicMineCD:Stop() --Энтропическая мина
			timerFusilladeCD:Start(19, 1) --Шквальный огонь
			countdownFusillade:Start(19) --Шквальный огонь
			if self:IsMythic() then
				timerShockGrenadeCD:Start(17) --Шоковая граната
				timerEntropicMineCD:Start(18) --Энтропическая мина
			else
				timerEntropicMineCD:Start(18) --Энтропическая мина
			end
		elseif cid == 122333 then --Генерал Эрод (фаза 4 Адмирал Свиракс)
		--	timerSummonReinforcementsCD:Start(20) --Вызов подкрепления
		--	countdownReinforcements:Start(11)
			timerShockGrenadeCD:Stop() --Шоковая граната
			timerSummonReinforcementsCD:Stop() --Вызов подкрепления
			timerEntropicMineCD:Stop() --Энтропическая мина
			timerFusilladeCD:Stop() --Шквальный огонь
			if self:IsMythic() then
				timerShockGrenadeCD:Start(17) --Шоковая граната
				timerEntropicMineCD:Start(18) --Энтропическая мина
				timerSummonReinforcementsCD:Start(20) --Вызов подкрепления
			else
				timerEntropicMineCD:Start(18) --Энтропическая мина
				timerSummonReinforcementsCD:Start(19) --Вызов подкрепления
			end
		elseif cid == 122367 then --Адмирал Свиракс Фаза 2
			self.vb.FusilladeCount = 0
			timerShockGrenadeCD:Stop() --Шоковая граната
			timerSummonReinforcementsCD:Stop() --Вызов подкрепления
			timerEntropicMineCD:Stop() --Энтропическая мина
			timerFusilladeCD:Start(19, 1) --Шквальный огонь
			countdownFusillade:Start(19) --Шквальный огонь
			if self:IsMythic() then
				timerShockGrenadeCD:Start(17) --Шоковая граната
				timerSummonReinforcementsCD:Start(20) --Вызов подкрепления
			else
				timerSummonReinforcementsCD:Start(19) --Вызов подкрепления
			end
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 244722 then
		timerShockGrenadeCD:Start()--21
	elseif spellId == 244892 then
		timerExploitWeaknessCD:Start()
		countdownExploitWeakness:Start(8.5)
	elseif spellId == 245227 then--Assume Command
		timerAssumeCommandCD:Start(90)
		countdownAssumeCommand:Start(90)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 244737 then
		warnShockGrenade:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			specWarnShockGrenade:Show()
			specWarnShockGrenade:Play("runout")
			yellShockGrenade:Yell()
			yellShockGrenadeFades:Countdown(5, 3)
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8)
			end
		end
		if self.Options.SetIconOnShockGrenade then
			self:SetIcon(args.destName, self.vb.ShockGrenadeIcon)
		end
		self.vb.ShockGrenadeIcon = self.vb.ShockGrenadeIcon - 1
	elseif spellId == 244892 then
		local uId = DBM:GetRaidUnitId(args.destName)
	--	if self:IsTanking(uId) then
		local amount = args.amount or 1
		if amount >= 3 then
			if args:IsPlayer() and self:IsTanking(uId) then
				specWarnExploitWeakness:Show(amount)
				specWarnExploitWeakness:Play("stackhigh")
			else
				local _, _, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
				local remaining
				if expireTime then
					remaining = expireTime-GetTime()
				end
				if not UnitIsDeadOrGhost("player") and (not remaining or remaining and remaining < 8) then
					specWarnExploitWeaknesslf:Show(args.destName)
					specWarnExploitWeaknesslf:Play("tauntboss")
				else
					warnExploitWeakness:Show(args.destName, amount)
				end
			end
		else
			warnExploitWeakness:Show(args.destName, amount)
		end
	--	end
	elseif spellId == 244172 then
		local amount = args.amount or 1
		if args:IsPlayer() then
			if amount == 10 or amount == 15 then
				if amount >= 19 then--High priority
					specWarnPsychicAssault:Show()
					specWarnPsychicAssault:Play("otherout")
				else--Just a basic stack warning
					specWarnPsychicAssaultStack:Show(amount)
					specWarnPsychicAssaultStack:Play("stackhigh")
				end
			end
		else
			if amount >= 10 and amount % 5 == 0 then
				warnPsychicAssault:Show(args.destName, amount)
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 244737 then
		self.vb.ShockGrenadeIcon = self.vb.ShockGrenadeIcon + 1
		if args:IsPlayer() then
			yellShockGrenadeFades:Cancel()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
		if self.Options.SetIconOnShockGrenade then
			self:SetIcon(args.destName, 0)
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show()
		specWarnGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

--"<14.68 23:07:26> [UNIT_SPELLCAST_SUCCEEDED] General Erodus(??) [[boss3:Summon Reinforcements::3-2083-1712-2166-245546-00015E79FE:245546]]", -- [121]
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if (spellId == 245161 or spellId == 245304) and self:AntiSpam(5, 1) then
		warnEntropicMine:Show()
		--warnEntropicMine:Play("watchstep")
		timerEntropicMineCD:Start()
	elseif spellId == 245785 then--Pod Spawn Transition Cosmetic Missile
		local name = UnitName(uId)
		local GUID = UnitGUID(uId)
		warnOutofPod:Show(name)
		local cid = self:GetCIDFromGUID(GUID)
		if cid == 122369 then--Chief Engineer Ishkar
			timerEntropicMineCD:Stop()
		elseif cid == 122333 then--General Erodus
			timerSummonReinforcementsCD:Stop()--Elite ones
		--	countdownReinforcements:Cancel()
		elseif cid == 122367 then--Admiral Svirax
			timerFusilladeCD:Stop()
			countdownFusillade:Cancel()
		end
	elseif spellId == 245546 then--Summon Reinforcements (major adds)
		specWarnSummonReinforcements:Show()
		specWarnSummonReinforcements:Play("killmob")
		timerSummonReinforcementsCD:Start(35)
	--	countdownReinforcements:Start(35)
		if self.Options.SetIconOnAdds then
			self:ScanForMobs(122890, 0, self.vb.lastIcon, 1, 0.1, 12, "SetIconOnAdds")
		end
		if self.vb.lastIcon == 1 then
			self.vb.lastIcon = 2
		else
			self.vb.lastIcon = 1
		end
	end
end
