local mod	= DBM:NewMod("VoWTrash", "DBM-Party-Legion", 10)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 196799 193069 196799 196249 193502 193936 161056 202728 196242 191527 191735 194064",
	"SPELL_AURA_APPLIED 202615 193069 193607 202608 161044 193164 210202 193997",
--	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS 202606",
	"CHAT_MSG_MONSTER_SAY",
	"GOSSIP_SHOW",
	"UNIT_DIED"
)

--Казематы стражей треш
local warnTorment				= mod:NewTargetAnnounce(202615, 3) --Мучение
local warnNightmares			= mod:NewTargetAnnounce(193069, 4) --Кошмары
local warnNightmares2			= mod:NewCastAnnounce(193069, 4) --Кошмары
local warnDoubleStrike			= mod:NewTargetAnnounce(193607, 2) --Двойной удар
local warnMetamorphosis			= mod:NewSpellAnnounce(193502, 4) --Метаморфоза
local warnAMotherLove			= mod:NewTargetAnnounce(194064, 3) --Материнская любовь
local warnPull					= mod:NewTargetAnnounce(193997, 3) --Притяжение

local specWarnPull				= mod:NewSpecialWarningYouRun(193997, nil, nil, nil, 4, 3) --Притяжение
local specWarnAMotherLove		= mod:NewSpecialWarningYouMoveAway(194064, nil, nil, nil, 4, 3) --Материнская любовь
local specWarnAMotherLove2		= mod:NewSpecialWarningTargetDodge(194064, nil, nil, nil, 2, 2) --Материнская любовь
local specWarnDeafeningScreech	= mod:NewSpecialWarningDodge(191735, nil, nil, nil, 1, 2) --Оглушительный визг
local specWarnFoulStench		= mod:NewSpecialWarningYouMove(210202, nil, nil, nil, 3, 3) --Зловонный смрад
local specWarnDeafeningShout	= mod:NewSpecialWarningCast(191527, "SpellCaster", nil, nil, 3, 2) --Оглушающий крик
local specWarnSummonGrimguard	= mod:NewSpecialWarningSwitch(202728, "Tank", nil, nil, 1, 2) --Призыв мрачного стража
local specWarnTemporalAnomaly	= mod:NewSpecialWarningYouMove(161044, nil, nil, nil, 1, 2) --Временная аномалия
local specWarnArcaneSentries	= mod:NewSpecialWarningDodge(193936, nil, nil, nil, 2, 2) --Волшебные часовые
local specWarnTemporalAnomaly2	= mod:NewSpecialWarningDodge(161056, nil, nil, nil, 2, 2) --Временная аномалия (каст)
local specWarnNightmares2		= mod:NewSpecialWarningDispel(193069, "MagicDispeller2", nil, nil, 1, 2) --Кошмары
local specWarnGiftoftheDoomsayer = mod:NewSpecialWarningDispel(193164, "MagicDispeller2", nil, nil, 1, 2) --Дар вестника рока
local specWarnGiftoftheDoomsayer2 = mod:NewSpecialWarningYou(193164, nil, nil, nil, 1, 2) --Дар вестника рока
local specWarnAnguishedSouls	= mod:NewSpecialWarningYouMove(202608, nil, nil, nil, 1, 2) --Страдающие души
local specWarnAnguishedSouls2	= mod:NewSpecialWarningDodge(202606, nil, nil, nil, 2, 2) --Страдающие души
local specWarnTorment			= mod:NewSpecialWarningYouClose(202615, nil, nil, nil, 3, 2) --Мучение
local specWarnTorment2			= mod:NewSpecialWarningYouDefensive(202615, nil, nil, nil, 2, 5) --Мучение
local specWarnDoubleStrike		= mod:NewSpecialWarningYouDefensive(193607, nil, nil, nil, 2, 2) --Двойной удар
local specWarnUnleashedFury		= mod:NewSpecialWarningInterrupt(196799, "HasInterrupt", nil, nil, 2, 2) --Высвобождение ярости
local specWarnNightmares		= mod:NewSpecialWarningInterrupt(193069, "HasInterrupt", nil, nil, 3, 2) --Кошмары
local specWarnMeteor			= mod:NewSpecialWarningShare(196249, nil, nil, nil, 1, 2) --Метеор
--Разъяренный анимус
local timerTemporalAnomalyCD	= mod:NewCDTimer(35, 161056, nil, nil, nil, 3, nil) --Временная аномалия (каст)
local timerArcaneSentriesCD		= mod:NewCDTimer(35, 193936, nil, nil, nil, 1, nil) --Волшебные часовые
--Повелитель ужаса Мендаций
local timerMeteorCD				= mod:NewCDTimer(17, 196249, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Метеор
local timerThunderclapCD		= mod:NewCDTimer(15, 196242, nil, nil, nil, 2, nil) --Удар грома
--Иллиана Танцующая с Клинками
local timerDeafeningShoutCD		= mod:NewCDTimer(18.5, 191527, nil, "SpellCaster", nil, 4, nil, DBM_CORE_INTERRUPT_ICON) --Оглушающий крик
--злобнорог поработитель 
local timerTormentCD			= mod:NewCDTimer(17, 202615, nil, nil, nil, 7, nil) --Мучение
--
local timerDoubleStrikeCD		= mod:NewCDTimer(13, 193607, nil, "Tank", nil, 3, nil, DBM_CORE_TANK_ICON) --Двойной удар
local timerDoubleStrike			= mod:NewTargetTimer(6, 193607, nil, "Healer", nil, 3, nil) --Двойной удар

local timerRoleplay				= mod:NewTimer(23, "timerRoleplay", "Interface\\Icons\\Spell_Holy_BorrowedTime", nil, nil, 7) --Ролевая игра

local countdownRoleplay			= mod:NewCountdown(23, 91344, nil, nil, 5)

local yellNightmares			= mod:NewYell(193069, nil, nil, nil, "YELL") --Кошмары
local yellTorment				= mod:NewYell(202615, nil, nil, nil, "YELL") --Мучение
local yellAMotherLove			= mod:NewYell(194064, nil, nil, nil, "YELL") --Материнская любовь

function mod:AMotherLoveTarget(targetname, uId) --Материнская любовь ✔
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnAMotherLove:Show()
		specWarnAMotherLove:Play("runaway")
		yellAMotherLove:Yell()
	else
		warnAMotherLove:Show(targetname)
		specWarnAMotherLove2:Show(targetname)
		specWarnAMotherLove2:Play("runout")
	end
end

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 196799 and self:AntiSpam(3, 1) then
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnUnleashedFury:Show()
			specWarnUnleashedFury:Play("aesoon")
		else
			specWarnUnleashedFury:Show()
			specWarnUnleashedFury:Play("aesoon")
		end
	elseif spellId == 193069 then --Кошмары
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnNightmares:Show()
			specWarnNightmares:Play("kickcast")
		else
			warnNightmares2:Show()
			warnNightmares2:Play("kickcast")
		end
	elseif spellId == 196249 then
		specWarnMeteor:Show()
		specWarnMeteor:Play("gathershare")
		timerMeteorCD:Start()
	elseif spellId == 193502 then --Метаморфоза
		warnMetamorphosis:Show()
	elseif spellId == 193936 then --Волшебные часовые
		specWarnArcaneSentries:Show()
		timerArcaneSentriesCD:Start()
	elseif spellId == 161056 then --Временная аномалия
		specWarnTemporalAnomaly2:Show()
		timerTemporalAnomalyCD:Start()
	elseif spellId == 202728 then --Временная аномалия
		specWarnSummonGrimguard:Show()
	elseif spellId == 196242 then --Временная аномалия
		timerThunderclapCD:Start()
	elseif spellId == 191527 then --Оглушающий крик
		specWarnDeafeningShout:Show()
		timerDeafeningShoutCD:Start()
	elseif spellId == 191735 then --Оглушительный визг
		specWarnDeafeningScreech:Show()
		specWarnDeafeningScreech:Play("watchstep")
	elseif spellId == 194064 then --Материнская любовь
		self:BossTargetScanner(args.sourceGUID, "AMotherLoveTarget", 0.1, 2)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 202606 and self:AntiSpam(3, 1) then --Страдающие души
		specWarnAnguishedSouls2:Show()
		specWarnAnguishedSouls2:Play("watchstep")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 202615 then
		warnTorment:Show(args.destName)
		timerTormentCD:Start()
		if args:IsPlayer() then
			specWarnTorment2:Show()
			yellTorment:Yell()
		else
			specWarnTorment:Show(args.destName)
		end
	elseif spellId == 193069 then
		warnNightmares:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			yellNightmares:Yell()
		else
			specWarnNightmares2:CombinedShow(0.3, args.destName)
			specWarnNightmares2:Play("dispelnow")
		end
	elseif spellId == 193607 then --Двойной удар
		warnDoubleStrike:Show(args.destName)
		timerDoubleStrike:Start(args.destName)
		timerDoubleStrikeCD:Start()
		if args:IsPlayer() then
			specWarnDoubleStrike:Show()
			specWarnDoubleStrike:Play("defensive")
		end
	elseif spellId == 202608 then --Страдающие души
		if args:IsPlayer() then
			specWarnAnguishedSouls:Show()
			specWarnAnguishedSouls:Play("runout")
		end
	elseif spellId == 161044 and self:AntiSpam(2, 3) then --Временная аномалия
		if args:IsPlayer() then
			specWarnTemporalAnomaly:Show()
			specWarnTemporalAnomaly:Play("runout")
		end
	elseif spellId == 193164 then --Дар вестника рока
		if args:IsPlayer() then
			specWarnGiftoftheDoomsayer2:Show()
			specWarnGiftoftheDoomsayer2:Play("targetyou")
		else
			specWarnGiftoftheDoomsayer:Show(args.destName)
			specWarnGiftoftheDoomsayer:Play("dispelnow")
		end
	elseif spellId == 210202 and self:AntiSpam(2, 2) then --Зловонный смрад
		if self:IsMythic() then
			if args:IsPlayer() then
				specWarnFoulStench:Show()
				specWarnFoulStench:Play("runout")
			end
		end
	elseif spellId == 193997 then --Притяжение
		warnPull:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnPull:Show()
			specWarnPull:Play("justrun")
		end
	end
end

function mod:CHAT_MSG_MONSTER_SAY(msg)
	if msg == L.proshlyapMurchalRP then
		self:SendSync("Roleplay")
	end
end

function mod:OnSync(msg)
	if msg == "Roleplay" then
		timerRoleplay:Start()
		countdownRoleplay:Start()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 102566 then --https://ru.wowhead.com/npc=102566/злобнорог-поработитель 
		timerTormentCD:Cancel()
	elseif cid == 96579 then --https://ru.wowhead.com/npc=96579/разъяренный-анимус
		timerTemporalAnomalyCD:Cancel()
		timerArcaneSentriesCD:Cancel()
	elseif cid == 99649 then --https://ru.wowhead.com/npc=99649/повелитель-ужаса-мендаций
		timerMeteorCD:Cancel()
		timerThunderclapCD:Cancel()
	elseif cid == 96657 then --https://ru.wowhead.com/npc=96657/иллиана-танцующая-с-клинками
		timerDeafeningShoutCD:Cancel()
	end
end

function mod:GOSSIP_SHOW()
	local guid = UnitGUID("target")
	if not guid then return end
	local cid = self:GetCIDFromGUID(guid)
	if cid == 103860 then --Дреланим Шелест Ветра
		if select('#', GetGossipOptions()) > 0 then
			SelectGossipOption(1, "", true)
			CloseGossip()
		end
	end
end
