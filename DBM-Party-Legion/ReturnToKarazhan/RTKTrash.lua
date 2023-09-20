local mod	= DBM:NewMod("RTKTrash", "DBM-Party-Legion", 11)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 228255 228239 227917 227925 228625 228606 229714 227966 228254 228280 230094 229429 229608 228700 36247 233981 229622 241828 228603",
	"SPELL_CAST_SUCCESS 227529",
	"SPELL_AURA_APPLIED 228331 229706 229716 228610 229074 230083 230050 228280 230087 228241 229468 230297 228576",
	"SPELL_AURA_APPLIED_DOSE 229074 228610 228576",
	"SPELL_AURA_REFRESH 229074 228610",
	"SPELL_AURA_REMOVED 229489 230083 228280 230087 230297",
--	"SPELL_DAMAGE 204762",
--	"SPELL_MISSED 204762",
	"GOSSIP_SHOW",
	"CHAT_MSG_MONSTER_SAY",
	"CHAT_MSG_MONSTER_YELL",
	"CHAT_MSG_MONSTER_EMOTE",
	"UNIT_DIED",
	"UNIT_AURA player",
	"UNIT_SPELLCAST_SUCCEEDED mouseover target focus" .. nameplates
)

--Каражан треш
local warnTakeKeys					= mod:NewTargetSourceAnnounce(233981, 1) --Взять ключи
local warnMovePiece					= mod:NewTargetAnnounce(229468, 3)
local warnVolatileCharge			= mod:NewTargetAnnounce(228331, 4) --Нестабильный заряд
local warnOathofFealty				= mod:NewCastAnnounce(228280, 3) --Клятва верности
local warnOathofFealty2				= mod:NewTargetAnnounce(228280, 2) --Клятва верности
local warnNullification				= mod:NewTargetAnnounce(230083, 2) --Полная нейтрализация
local warnReinvigorated				= mod:NewTargetAnnounce(230087, 1) --Восполнение сил
local warnCursedTouch				= mod:NewTargetAnnounce(228241, 2) --Проклятое прикосновение
local warnArcaneBarrage				= mod:NewCastAnnounce(228700, 3) --Чародейский обстрел
local warnBrittleBones				= mod:NewTargetAnnounce(230297, 3) --Ослабление костей
local warnBansheeWail				= mod:NewCastAnnounce(228625, 3) --Вой банши
local warnAllured					= mod:NewStackAnnounce(228576, 3, nil, nil, 2) --Соблазнение
local warnTramplingStomp			= mod:NewCastAnnounce(241828, 4) --Растаптывающая поступь
--Поврежденный голем
local specWarnUnstableEnergy		= mod:NewSpecialWarningDodge(227529, nil, nil, nil, 2, 2) --Нестабильная энергия
--Наполненный силой пиромант
local specWarnFelBomb				= mod:NewSpecialWarningRun(229620, nil, nil, nil, 4, 6) --Бомба Скверны 
local specWarnFelFireball			= mod:NewSpecialWarningInterrupt(36247, "HasInterrupt", nil, nil, 1, 2) --Огненный шар Скверны
--
local specWarnFelBreath				= mod:NewSpecialWarningInterrupt2(229622, "OchkenProshlyapen", nil, nil, 2, 2) --Дыхание Скверны
--
local specWarnRoyalSlash			= mod:NewSpecialWarningDodge(229429, "Melee", nil, nil, 2, 2) --Удар короля сплеча

local specWarnBrittleBones2			= mod:NewSpecialWarningYouDefensive(230297, nil, nil, nil, 3, 6) --Ослабление костей
local specWarnBrittleBones3			= mod:NewSpecialWarningYouDispel(230297, "CurseDispeller", nil, nil, 3, 6) --Ослабление костей
local specWarnBrittleBones			= mod:NewSpecialWarningDispel(230297, "CurseDispeller", nil, nil, 3, 6) --Ослабление костей
--
local specWarnCursedTouch			= mod:NewSpecialWarningYou(228241, nil, nil, nil, 2, 2) --Проклятое прикосновение
local specWarnCursedTouch3			= mod:NewSpecialWarningYouDispel(228241, "CurseDispeller", nil, nil, 3, 2) --Проклятое прикосновение
local specWarnCursedTouch2			= mod:NewSpecialWarningDispel(228241, "CurseDispeller", nil, nil, 3, 2) --Проклятое прикосновение
--
local specWarnAllured				= mod:NewSpecialWarningStack(228576, nil, 80, nil, nil, 1, 3) --Соблазнение
local specWarnMightySwing			= mod:NewSpecialWarningDodge(229608, "Melee", nil, nil, 2, 2) --Могучий удар
local specWarnReinvigorated			= mod:NewSpecialWarningYouMoreDamage(230087, nil, nil, nil, 1, 2) --Восполнение сил
local specWarnReinvigorated2		= mod:NewSpecialWarningEnd(230087, nil, nil, nil, 1, 2) --Восполнение сил
local specWarnForceBlade			= mod:NewSpecialWarningYouDefensive(230050, nil, nil, nil, 3, 5) --Силовой клинок
local specWarnNullification			= mod:NewSpecialWarningYouFind(230083, nil, nil, nil, 1, 2) --Полная нейтрализация
local specWarnSoulLeech2			= mod:NewSpecialWarningInterrupt(228254, "HasInterrupt", nil, nil, 1, 2) --Поглощение души
local specWarnSoulLeech				= mod:NewSpecialWarningInterrupt(228255, "HasInterrupt", nil, nil, 1, 2)
local specWarnTerrifyingWail		= mod:NewSpecialWarningInterrupt(228239, "HasInterrupt", nil, nil, 1, 2) --Ужасающий стон
local specWarnPoetrySlam			= mod:NewSpecialWarningInterrupt(227917, "HasInterrupt", nil, nil, 1, 2)
local specWarnBansheeWail			= mod:NewSpecialWarningInterrupt(228625, "HasInterrupt", nil, nil, 1, 2) --Вой банши
local specWarnHealingTouch			= mod:NewSpecialWarningInterrupt(228606, "HasInterrupt", nil, nil, 1, 2)
local specWarnConsumeMagic			= mod:NewSpecialWarningInterrupt(229714, "HasInterrupt", nil, nil, 1, 2)
local specWarnArcaneBarrage			= mod:NewSpecialWarningInterrupt(228700, "HasInterrupt", nil, nil, 1, 2) --Чародейский обстрел
local specWarnFinalCurtain			= mod:NewSpecialWarningDodge(227925, "Melee", nil, nil, 1, 2) --Последний занавес
local specWarnOathofFealty			= mod:NewSpecialWarningInterrupt(228280, "HasInterrupt", nil, nil, 3, 3) --Клятва верности
local specWarnOathofFealty2			= mod:NewSpecialWarningDispel(228280, "MagicDispeller2", nil, nil, 1, 2) --Клятва верности
local specWarnVolatileCharge		= mod:NewSpecialWarningYouMoveAway(228331, nil, nil, nil, 3, 3) --Нестабильный заряд
local specWarnTramplingStomp		= mod:NewSpecialWarningInterrupt(241828, "HasInterrupt", nil, nil, 1, 2) --Растаптывающая поступь
local specWarnCharge				= mod:NewSpecialWarningDodge(228603, nil, nil, nil, 2, 2) --Рывок

local specWarnBurningBrand			= mod:NewSpecialWarningYouMoveAway(228610, nil, nil, nil, 3, 3) --Горящее клеймо
local specWarnLeechLife				= mod:NewSpecialWarningDispel(229706, "MagicDispeller2", nil, nil, 1, 2) --Высасывание жизни
local specWarnCurseofDoom			= mod:NewSpecialWarningDispel(229716, "MagicDispeller2", nil, nil, 1, 2) --Проклятие рока
local specWarnVulnerable			= mod:NewSpecialWarningMoreDamage(229495, "-Healer", nil, nil, 3, 2) --Уязвимость
local specWarnFlashlight			= mod:NewSpecialWarningLookAway(227966, nil, nil, nil, 3, 3) --Фонарь

local timerFelBomb					= mod:NewCastTimer(17, 196034, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Бомба Скверны
local timerNullificationCD			= mod:NewCDTimer(14, 230094, nil, nil, nil, 7, nil) --Полная нейтрализация
local timerReinvigorated			= mod:NewTargetTimer(20, 230087, nil, nil, nil, 7) --Восполнение сил
local timerOathofFealty				= mod:NewTargetTimer(15, 228280, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON) --Клятва верности
--local timerRoyalty					= mod:NewCDTimer(20, 229489, nil, nil, nil, 3, nil, DBM_CORE_DAMAGE_ICON) --Царственность
local timerMovePieceCD				= mod:NewCDTimer(5.5, 229468, nil, nil, nil, 7)

local yellCursedTouch				= mod:NewYellDispel(228241, nil, nil, nil, "YELL") --Проклятое прикосновение
local yellTakeKeys					= mod:NewYell(233981, L.TakeKeysYell, nil, nil, "YELL") --Взять ключи
local yellBrittleBones				= mod:NewYellDispel(230297, nil, nil, nil, "YELL") --Ослабление костей
local yellNullification				= mod:NewYell(230083, nil, nil, nil, "YELL") --Полная нейтрализация
local yellVolatileCharge			= mod:NewYell(228331, nil, nil, nil, "YELL") --Нестабильный заряд
local yellVolatileCharge2			= mod:NewFadesYellMoveAway(228331, nil, nil, nil, "YELL") --Нестабильный заряд
local yellBurningBrand				= mod:NewYell(228610, nil, nil, nil, "YELL") --Горящее клеймо
local yellBurningBrand2				= mod:NewFadesYell(228610, nil, nil, nil, "YELL") --Горящее клеймо
--local yellReinvigorated				= mod:NewYell(230087, L.ReinvigoratedYell, nil, nil, "YELL") --Восполнение сил
local yellReinvigorated2			= mod:NewFadesYell(230087, nil, nil, nil, "YELL") --Восполнение сил

local timerAchieve					= mod:NewBuffActiveTimer(480, 229074)

local timerRoleplay					= mod:NewTimer(30, "timerRoleplay", "Interface\\Icons\\Spell_Holy_BorrowedTime", nil, nil, 7)
local timerRoleplay2				= mod:NewTimer(30, "timerRoleplay2", "Interface\\Icons\\Spell_Holy_BorrowedTime", nil, nil, 7)
local timerRoleplay3				= mod:NewTimer(30, "timerRoleplay3", "Interface\\Icons\\Spell_Holy_BorrowedTime", nil, nil, 7)
local timerRoleplay4				= mod:NewTimer(30, "timerRoleplay4", "Interface\\Icons\\Spell_Holy_BorrowedTime", nil, nil, 7)
local timerRoleplay5				= mod:NewTimer(30, "timerRoleplay5", "Interface\\Icons\\Spell_Holy_BorrowedTime", nil, nil, 7)

local countdownRoleplay				= mod:NewCountdownFades(30, 229620, nil, nil, 5) --Бомба Скверны (и т.д.)

mod:AddBoolOption("OperaActivation", true)

local key = replaceSpellLinks(233981) --Взять ключи
local playerName = UnitName("player")
local proshlyapationOfMurchal = DBM:GetSpellInfo(228331)
local murchalProshlyaping = false
--local king = false

function mod:FelBreathTarget(targetname, uId) --Дыхание Скверны ✔
	if not targetname then return end
	if self:AntiSpam(2, targetname) then
		if targetname == UnitName("player") then
			specWarnFelBreath:Show()
			specWarnFelBreath:Play("kickcast")
		elseif self:CheckNearby(15, targetname) then
			specWarnFelBreath:Show()
			specWarnFelBreath:Play("kickcast")
		end
	end
end

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 228255 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnSoulLeech:Show(args.sourceName)
		specWarnSoulLeech:Play("kickcast")
	elseif spellId == 228239 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Ужасающий стон
		specWarnTerrifyingWail:Show(args.sourceName)
		specWarnTerrifyingWail:Play("kickcast")
	elseif spellId == 227917 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnPoetrySlam:Show(args.sourceName)
		specWarnPoetrySlam:Play("kickcast")
	elseif spellId == 228625 then --Вой банши
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnBansheeWail:Show()
			specWarnBansheeWail:Play("kickcast")
		else
			warnBansheeWail:Show()
			warnBansheeWail:Play("kickcast")
		end
	elseif spellId == 228606 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnHealingTouch:Show(args.sourceName)
		specWarnHealingTouch:Play("kickcast")
	elseif spellId == 229714 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnConsumeMagic:Show(args.destName)
		specWarnConsumeMagic:Play("kickcast")
	elseif spellId == 227925 and self:AntiSpam(3, 1) then
		specWarnFinalCurtain:Show()
		specWarnFinalCurtain:Play("runout")
	elseif spellId == 227966 and self:AntiSpam(3, 2) then
		if not UnitIsDeadOrGhost("player") then
			specWarnFlashlight:Show()
			specWarnFlashlight:Play("turnaway")
		end
	elseif spellId == 228254 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Поглощение души
		specWarnSoulLeech2:Show()
		specWarnSoulLeech2:Play("kickcast")
	elseif spellId == 228280 then --Клятва верности
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnOathofFealty:Show()
			specWarnOathofFealty:Play("kickcast")
		else
			warnOathofFealty:Show()
			warnOathofFealty:Play("kickcast")
		end
	elseif spellId == 230094 then --Полная нейтрализация
		timerNullificationCD:Start()
	elseif spellId == 229429 then --Удар короля сплеча
		specWarnRoyalSlash:Show()
		specWarnRoyalSlash:Play("watchstep")
	elseif spellId == 229608 then --Могучий удар
		specWarnMightySwing:Show()
		specWarnMightySwing:Play("watchstep")
	elseif spellId == 228700 and self:AntiSpam(3, 1) then --Чародейский обстрел
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnArcaneBarrage:Show()
			specWarnArcaneBarrage:Play("kickcast")
		else
			warnArcaneBarrage:Show()
			warnArcaneBarrage:Play("kickcast")
		end
	elseif spellId == 36247 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Огненный шар Скверны
		specWarnFelFireball:Show()
		specWarnFelFireball:Play("kickcast")
	elseif spellId == 233981 then --Взять ключи
		if args:IsPlayerSource() then
			yellTakeKeys:Yell(key)
		else
			warnTakeKeys:Show(args.sourceName)
		end
	elseif spellId == 229622 then --Дыхание Скверны
		self:BossTargetScanner(args.sourceGUID, "FelBreathTarget", 0.1, 2)
	elseif spellId == 241828 then --Растаптывающая поступь
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnTramplingStomp:Show()
			specWarnTramplingStomp:Play("kickcast")
		elseif self:AntiSpam(2, "tramplingstomp") then
			warnTramplingStomp:Show()
			warnTramplingStomp:Play("kickcast")
		end
	elseif spellId == 228603 and self:AntiSpam(3, "charge") then --Рывок
		specWarnCharge:Show()
		specWarnCharge:Play("watchstep")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 227529 and self:AntiSpam(2, "unstable") then --Нестабильная энергия
		specWarnUnstableEnergy:Show()
		specWarnUnstableEnergy:Play("watchstep")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 228241 then --Проклятое прикосновение
		warnCursedTouch:CombinedShow(0.3, args.destName)
		if not self:IsNormal() then
			if args:IsPlayer() and not self:IsCurseDispeller() then
				specWarnCursedTouch:Show()
				specWarnCursedTouch:Play("targetyou")
				yellCursedTouch:Yell()
			elseif args:IsPlayer() and self:IsCurseDispeller() then
				specWarnCursedTouch3:Show()
				specWarnCursedTouch3:Play("dispelnow")
				yellCursedTouch:Yell()
			else
				if not UnitIsDeadOrGhost("player") then
					specWarnCursedTouch2:CombinedShow(0.3, args.destName)
					specWarnCursedTouch2:ScheduleVoice(0.3, "dispelnow")
				end
			end
		end
	elseif spellId == 228610 and self:AntiSpam(3, 1) then --Горящее клеймо
		if args:IsPlayer() then
			specWarnBurningBrand:Show()
			specWarnBurningBrand:Play("runout")
			yellBurningBrand:Yell()
			yellBurningBrand2:Cancel()
			yellBurningBrand2:Countdown(6, 3)
		end
	elseif spellId == 229706 then
		specWarnLeechLife:Show(args.destName)
		specWarnLeechLife:Play("dispelnow")
	elseif spellId == 229716 then
		specWarnCurseofDoom:Show(args.destName)
		specWarnCurseofDoom:Play("dispelnow")
	elseif spellId == 229074 and self:AntiSpam(3, 3) then
		local uId = DBM:GetRaidUnitId(args.destName)
		local _, _, _, _, _, _, expires = DBM:UnitBuff(uId, args.spellName)
		if expires then
			local debuffTime = expires - GetTime()
			timerAchieve:Stop()
			timerAchieve:Start(debuffTime)
		end
	elseif spellId == 230083 then --Полная нейтрализация
		if args:IsPlayer() then
			specWarnNullification:Show()
			specWarnNullification:Play("findshadow")
			yellReinvigorated2:Cancel()
			timerReinvigorated:Cancel()
			yellNullification:Yell()
		else
			warnNullification:Show(args.destName)
		end
	elseif spellId == 230050 then --Силовой клинок
		if args:IsPlayer() then
			specWarnForceBlade:Show()
			specWarnForceBlade:Play("defensive")
		end
	elseif spellId == 228280 then --Клятва верности
		warnOathofFealty2:CombinedShow(0.5, args.destName)
		timerOathofFealty:Start(args.destName)
		if not UnitIsDeadOrGhost("player") then
			specWarnOathofFealty2:Show(args.destName)
			specWarnOathofFealty2:Play("dispelnow")
		end
	elseif spellId == 230087 then --Восполнение сил
		warnReinvigorated:Show(args.destName)
	elseif spellId == 229468 then
		warnMovePiece:Show(args.destName)
		timerMovePieceCD:Start()
	elseif spellId == 230297 then --Ослабление костей
		warnBrittleBones:CombinedShow(0.5, args.destName)
		if self:IsMythic() then
			if args:IsPlayer() and not self:IsCurseDispeller() then
				specWarnBrittleBones2:Show()
				specWarnBrittleBones2:Play("defensive")
				yellBrittleBones:Yell()
			elseif args:IsPlayer() and self:IsCurseDispeller() then
				specWarnBrittleBones3:Show()
				specWarnBrittleBones3:Play("defensive")
				yellBrittleBones:Yell()
			elseif self:IsCurseDispeller() then
				if not UnitIsDeadOrGhost("player") then
					specWarnBrittleBones:CombinedShow(0.5, args.destName)
					specWarnBrittleBones:ScheduleVoice(0.5, "dispelnow")
				end
			end
		else
			if args:IsPlayer() and not self:IsCurseDispeller() then
				specWarnBrittleBones2:Show()
				specWarnBrittleBones2:Play("defensive")
				yellBrittleBones:Yell()
			elseif args:IsPlayer() and self:IsCurseDispeller() then
				specWarnBrittleBones3:Show()
				specWarnBrittleBones3:Play("defensive")
				yellBrittleBones:Yell()
			end
		end
	elseif spellId == 228576 and args:IsDestTypePlayer() then --Соблазнение
		local amount = args.amount or 1
		if amount >= 80 and amount % 5 == 0 then
			if args:IsPlayer() then
				specWarnAllured:Show(amount)
				specWarnAllured:Play("stackhigh")
			else
				warnAllured:Show(args.destName, amount)
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 229489 and self:AntiSpam(5, "vulnerable") then --Царственность
		if not UnitIsDeadOrGhost("player") then
			specWarnVulnerable:Show()
			specWarnVulnerable:Play("killbigmob")
		end
	elseif spellId == 228280 then --Клятва верности
		timerOathofFealty:Cancel(args.destName)
	elseif spellId == 230087 then --Восполнение сил
		timerReinvigorated:Cancel(args.destName)
		if args:IsPlayer() then
			specWarnReinvigorated2:Show()
			yellReinvigorated2:Cancel()
		end
	elseif spellId == 228610 then --Горящее клеймо
		if args:IsPlayer() then
			yellBurningBrand2:Cancel()
		end
	elseif spellId == 230083 then --Полная нейтрализация
		if args:IsPlayer() then
			timerReinvigorated:Start(args.destName)
			specWarnReinvigorated:Show()
			yellReinvigorated2:Countdown(20, 3)
		end
	end
end

function mod:CHAT_MSG_MONSTER_EMOTE(msg)
	if msg == L.speedRun then
		self:SendSync("KaraSpeed")
	end
end

function mod:CHAT_MSG_MONSTER_SAY(msg)
	if msg == L.Medivh1 then
		self:SendSync("RPMedivh1")
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Beauty then
		self:SendSync("RPBeauty")
	elseif msg == L.Westfall then
		self:SendSync("RPWestfall")
	elseif msg == L.Wikket then
		self:SendSync("RPWikket")
	elseif msg == L.Medivh2 then
		self:SendSync("RPMedivh2")
	end
end

function mod:GOSSIP_SHOW()
	local guid = UnitGUID("npc")
	if not guid then return end
	local cid = self:GetCIDFromGUID(guid)
	if mod.Options.OperaActivation then
		if cid == 114339 or cid == 115038 then --Барнс, Проекция Медива
			if select('#', GetGossipOptions()) > 0 then
				SelectGossipOption(1)
			--	CloseGossip()
			end
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 115765 then --Абстрактный нейтрализатор
		timerNullificationCD:Cancel()
--[[	elseif cid == 115395 or cid == 115406 or cid == 115401 or cid == 115402 or cid == 115407 then --Ферзь, Конь, Слон, Слон, Ладья
		--за Ладью +20 сек, если все живы
		--за Ферзя +30 сек если все живы, +22 сек, если мертва Ладья
		--слишком дохуя вариантов
		if not king then
			if timerRoyalty:GetTime() < 10 then
				timerRoyalty:AddTime(20)
			elseif timerRoyalty:GetTime() > 10 then
				timerRoyalty:Start(30)
			end
		end]]
	elseif cid == 115388 then --Король
	--	if not king then
	--		king = true
	--		timerRoyalty:Cancel()
		timerMovePieceCD:Cancel()
	--	end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, _, spellId)
	if spellId == 229620 and self:AntiSpam(2, "felbombs") then
		self:SendSync("felbomb")
	elseif spellId == 229678 and self:AntiSpam(2, "felbombsend") then
		self:SendSync("felbombend")
	end
end

do
	function mod:UNIT_AURA(uId)
		local proshlyap = UnitDebuff("player", proshlyapationOfMurchal)
		if proshlyap and not murchalProshlyaping then
			murchalProshlyaping = true
			specWarnVolatileCharge:Show()
			specWarnVolatileCharge:Play("runaway")
			yellVolatileCharge:Yell()
			yellVolatileCharge2:Countdown(5, 3)
		elseif not proshlyap and murchalProshlyaping then
			murchalProshlyaping = false
		end
	end
end

function mod:OnSync(msg)
	if msg == "KaraSpeed" then
		timerAchieve:Start()
	elseif msg == "RPBeauty" then
		timerRoleplay:Start(52.5)
		countdownRoleplay:Start(52.5)
	elseif msg == "RPWestfall" then
		timerRoleplay2:Start(46.5)
		countdownRoleplay:Start(46.5)
	elseif msg == "RPWikket" then
		timerRoleplay3:Start(70)
		countdownRoleplay:Start(70)
	elseif msg == "RPMedivh1" then
		timerRoleplay4:Start(14.7)
	elseif msg == "RPMedivh2" then
		timerRoleplay5:Start(79.2)
		countdownRoleplay:Start(79.2)
	elseif msg == "felbomb" then
		specWarnFelBomb:Show()
		specWarnFelBomb:Play("bombsoon")
	--	DBM:PlaySoundFile("Interface\\AddOns\\DBM-Core\\Sounds\\Custom\\Kuplinov_Sebae.ogg")
		timerFelBomb:Start()
		countdownRoleplay:Start(17)
	elseif msg == "felbombend" then
		timerFelBomb:Cancel()
		countdownRoleplay:Cancel()
	end
end
