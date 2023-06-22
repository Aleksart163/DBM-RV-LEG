local mod	= DBM:NewMod("CoSTrash", "DBM-Party-Legion", 7)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
mod:SetZone()
mod:SetOOCBWComms()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 209027 212031 209485 209410 209413 211470 211464 209404 209495 225100 211299 209378 207980 207979 214692 214688 214690 212773 210253 214697",
	"SPELL_CAST_SUCCESS 214688 208585 208427 209767 208334 210872 210307 208939 208370 210925 210217 210922 210330",
	"SPELL_AURA_APPLIED 209033 209512 207981 214690 212773 209404",
	"SPELL_AURA_REMOVED 214690",
	"CHAT_MSG_MONSTER_SAY",
	"GOSSIP_SHOW",
	"UNIT_DIED"
)

--Квартал звезд трэш
local warnMinionDie					= mod:NewAnnounce("WarningMinionDie", 2, 245910)
local warnPhase2					= mod:NewAnnounce("warnSpy", 1, 248732) --Шпион обнаружен , nil, nil, true
local warnPickingUp					= mod:NewTargetSourceAnnounce(214697, 1) --Поднять ключ
local warnDrainMagic				= mod:NewCastAnnounce(209485, 4) --Похищение магии
local warnCripple					= mod:NewTargetAnnounce(214690, 3) --Увечье
local warnCarrionSwarm				= mod:NewTargetAnnounce(214688, 4) --Темная стая
local warnShadowBoltVolley			= mod:NewCastAnnounce(214692, 4) --Залп стрел Тьмы
local warnFelDetonation				= mod:NewCastAnnounce(211464, 4) --Взрыв Скверны
local warnSubdue					= mod:NewTargetAnnounce(212773, 4) --Подчинение
local warnSuppress					= mod:NewTargetAnnounce(209413, 4) --Подавление
local warnDisintegrationBeam		= mod:NewTargetAnnounce(207980, 4) --Луч дезинтеграции
local warnSealMagic					= mod:NewTargetAnnounce(209404, 4) --Подавление магии
local warnSubdue2					= mod:NewCastAnnounce(212773, 3) --Подчинение
local warnDisableBeacon				= mod:NewTargetSourceAnnounce(210253, 1) --Отключение маяка
local warnEating					= mod:NewTargetSourceAnnounce(208585, 1) --Поглощение пищи (баф на хп от еды)
local warnSiphoningMagic			= mod:NewTargetSourceAnnounce(208427, 1) --Похищение магии (Магический светильник)
local warnPurifying					= mod:NewTargetSourceAnnounce(209767, 1) --Очищение (фолиант скверны)
local warnDraining					= mod:NewTargetSourceAnnounce(208334, 1) --Иссушение (сфера скверны)
local warnInvokingText				= mod:NewTargetSourceAnnounce(210872, 1) --Текст пробуждения (промокший свиток)
local warnDrinking					= mod:NewTargetSourceAnnounce(210307, 1) --Выпивание (отвар из звездной розы)
local warnReleaseSpores				= mod:NewTargetSourceAnnounce(208939, 1) --Высвобождение спор (теневой цветок)
local warnShuttingDown				= mod:NewTargetSourceAnnounce(208370, 1) --Отключение (сфера инженерии)
local warnTreating					= mod:NewTargetSourceAnnounce(210925, 1) --Лечение (ночнорожденный)
local warnPilfering					= mod:NewTargetSourceAnnounce(210217, 1) --Воровство (рыночные товары)
local warnDefacing					= mod:NewTargetSourceAnnounce(210330, 1) --Осквернение (Статуя ночнорожденного в натуральную величину)
local warnTinkering					= mod:NewTargetSourceAnnounce(210922, 1) --Конструирование (выброшенный хлам)

--local specWarnSuppress2				= mod:NewSpecialWarningYou(209413, nil, nil, nil, 1, 2) --Подавление
local specWarnCripple2				= mod:NewSpecialWarningYou(214690, nil, nil, nil, 1, 3) --Увечье
local specWarnCripple3				= mod:NewSpecialWarningYouDispel(214690, "MagicDispeller2", nil, nil, 1, 3) --Увечье
local specWarnCripple				= mod:NewSpecialWarningDispel(214690, "MagicDispeller2", nil, nil, 1, 2) --Увечье
local specWarnShadowBoltVolley		= mod:NewSpecialWarningDodge(214692, "-Tank", nil, nil, 2, 3) --Залп стрел Тьмы
local specWarnCarrionSwarm			= mod:NewSpecialWarningDodge(214688, nil, nil, nil, 2, 2) --Темная стая
local specWarnFelDetonation			= mod:NewSpecialWarningDodge(211464, nil, nil, nil, 2, 3) --Взрыв Скверны
local specWarnDisintegrationBeam	= mod:NewSpecialWarningYouDefensive(207980, nil, nil, nil, 3, 6) --Луч дезинтеграции
local specWarnShockwave				= mod:NewSpecialWarningDodge(207979, "Melee", nil, nil, 2, 3) --Ударная волна
local specWarnFortification			= mod:NewSpecialWarningDispel(209033, "MagicDispeller", nil, nil, 1, 2) --Укрепление
local specWarnQuellingStrike		= mod:NewSpecialWarningDodge(209027, "Melee", nil, nil, 2, 2) --Подавляющий удар
local specWarnChargedBlast			= mod:NewSpecialWarningDodge(212031, "Melee", nil, nil, 2, 2) --Заряженный взрыв
local specWarnChargedSmash			= mod:NewSpecialWarningDodge(209495, "Melee", nil, nil, 2, 2) --Удар с размаху
local specWarnDrainMagic			= mod:NewSpecialWarningInterrupt(209485, "HasInterrupt", nil, nil, 3, 5) --Похищение магии
local specWarnSubdue				= mod:NewSpecialWarningInterrupt(212773, "HasInterrupt", nil, nil, 1, 3) --Подчинение
local specWarnSubdue2				= mod:NewSpecialWarningDispel(212773, "MagicDispeller2", nil, nil, 1, 2) --Подчинение
local specWarnNightfallOrb			= mod:NewSpecialWarningInterrupt(209410, "HasInterrupt", nil, nil, 1, 2)
local specWarnSuppress				= mod:NewSpecialWarningInterrupt(209413, "HasInterrupt", nil, nil, 1, 2) --Подавление
local specWarnBewitch				= mod:NewSpecialWarningInterrupt(211470, "HasInterrupt", nil, nil, 1, 2)
local specWarnChargingStation		= mod:NewSpecialWarningInterrupt(225100, "HasInterrupt", nil, nil, 1, 2)
local specWarnSearingGlare			= mod:NewSpecialWarningInterrupt(211299, "HasInterrupt", nil, nil, 1, 2)
local specWarnSealMagic				= mod:NewSpecialWarningInterrupt(209404, "HasInterrupt", nil, nil, 1, 2) --Подавление магии
local specWarnDisruptingEnergy		= mod:NewSpecialWarningMove(209512, nil, nil, nil, 1, 2)
local specWarnWhirlingBlades		= mod:NewSpecialWarningRun(209378, "Melee", nil, nil, 4, 3) --Крутящиеся клинки
--Герент Зловещий
local timerCripple					= mod:NewTargetTimer(8, 214690, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON) --Увечье
local timerCrippleCD				= mod:NewCDTimer(20.5, 214690, nil, "MagicDispeller2", nil, 3, nil, DBM_CORE_HEALER_ICON..DBM_CORE_MAGIC_ICON) --Увечье
local timerShadowBoltVolleyCD		= mod:NewCDTimer(20.5, 214692, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Залп стрел Тьмы
local timerCarrionSwarmCD			= mod:NewCDTimer(18, 214688, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Темная стая
--
local timerDisintegrationBeamCD		= mod:NewCDTimer(14, 207980, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Луч дезинтеграции
local timerFelDetonationCD			= mod:NewCDTimer(12, 211464, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Взрыв Скверны
local timerWhirlingBladesCD			= mod:NewCDTimer(18, 209378, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Крутящиеся клинки
local timerShockwaveCD				= mod:NewCDTimer(8.5, 207979, nil, nil, nil, 3, nil, DBM_CORE_TANK_ICON..DBM_CORE_DEADLY_ICON) --Ударная волна

local timerRoleplay					= mod:NewTimer(28, "timerRoleplay", "Interface\\Icons\\Spell_Holy_BorrowedTime", nil, nil, 7) --Ролевая игра

local countdownFelDetonation		= mod:NewCountdown(12, 211464, nil, nil, 5) --Взрыв Скверны

local yellPickingUp					= mod:NewYell(244910, L.PickingUpYell, nil, nil, "YELL") --Поднять ключ
local yellSealMagic					= mod:NewYell(209404, nil, nil, nil, "YELL") --Подавление магии
local yellSuppress					= mod:NewYell(209413, nil, nil, nil, "YELL") --Подавление
local yellSubdue					= mod:NewYell(212773, nil, nil, nil, "YELL") --Подчинение
local yellDisintegrationBeam		= mod:NewYell(207980, nil, nil, nil, "YELL") --Луч дезинтеграции
local yellCripple					= mod:NewYell(214690, nil, nil, nil, "YELL") --Увечье
local yellCarrionSwarm				= mod:NewYell(214688, nil, nil, nil, "YELL") --Темная стая

mod:AddBoolOption("YellOnEating", true) --Поглощение пищи (хп)
mod:AddBoolOption("YellOnSiphoningMagic", true) --Похищение магии (урон)
mod:AddBoolOption("YellOnPurifying", true) --Очищение (защита)
mod:AddBoolOption("YellOnDraining", true) --Иссушение (крит)
mod:AddBoolOption("YellOnInvokingText", true) --Текст пробуждения (скорость бега)
mod:AddBoolOption("YellOnDrinking", true) --Выпивание (хп и мана реген)
mod:AddBoolOption("YellOnReleaseSpores", true) --Высвобождение спор (скорость боя)
mod:AddBoolOption("YellOnShuttingDown", true) --Отключение (големы)
mod:AddBoolOption("YellOnTreating", true) --Лечение (отвлечение)
mod:AddBoolOption("YellOnPilfering", true) --Воровство (отвлечение)
mod:AddBoolOption("YellOnTinkering", true) --Конструирование (отвлечение)
mod:AddBoolOption("YellOnDefacing", true) --Осквернение (отвлечение)
mod:AddBoolOption("SpyHelper", true)

local key = replaceSpellLinks(214697) --Поднять ключ

local eating = replaceSpellLinks(208585) --Поглощение пищи
local siphoningMagic = replaceSpellLinks(208427) --Похищение магии
local purifying = replaceSpellLinks(209767) --Очищение
local draining = replaceSpellLinks(208334) --Иссушение
local invokingText = replaceSpellLinks(210872) --Текст пробуждения
local drinking = replaceSpellLinks(210307) --Выпивание
local releaseSpores = replaceSpellLinks(208939) --Высвобождение спор
local shuttingDown = replaceSpellLinks(208370) --Отключение
local treating = replaceSpellLinks(210925) --Лечение
local pilfering = replaceSpellLinks(210217) --Воровство
local tinkering = replaceSpellLinks(210922) --Конструирование
local defacing = replaceSpellLinks(210330) --Осквернение

mod.vb.wardens = 3

-- Синхронизация анонсов ↓
local premsg_values = {
	-- test,
	args_sourceName,
	args_destName,
	hintTranslations_clue,
	eating, siphoningMagic, purifying, draining, invokingText, drinking,
	releaseSpores, shuttingDown, treating, pilfering, tinkering, defacing,
	clues
}
local playerOnlyName = UnitName("player")

local function sendAnnounce(self)
	if premsg_values.args_sourceName == nil then
		premsg_values.args_sourceName = "Unknown"
	end
	if premsg_values.args_destName == nil then
		premsg_values.args_destName = "Unknown"
	end
	if premsg_values.hintTranslations_clue == nil then
		premsg_values.hintTranslations_clue = "Unknown"
	end

	--[[if premsg_values.test == 1 then
		smartChat("Тестовое сообщение.")
		smartChat("args_sourceName: " .. premsg_values.args_sourceName)
		smartChat("args_destName: " .. premsg_values.args_destName)
		smartChat("hintTranslations_clue: " .. premsg_values.hintTranslations_clue)
		premsg_values.test = 0
	else]]if premsg_values.eating == 1 then
		smartChat(L.SpellUseYell:format(DbmRV, premsg_values.args_sourceName, eating))
		premsg_values.eating = 0
	elseif premsg_values.siphoningMagic == 1 then
		smartChat(L.SpellUseYell:format(DbmRV, premsg_values.args_sourceName, siphoningMagic))
		premsg_values.siphoningMagic = 0
	elseif premsg_values.purifying == 1 then
		smartChat(L.SpellUseYell:format(DbmRV, premsg_values.args_sourceName, purifying))
		premsg_values.purifying = 0
	elseif premsg_values.draining == 1 then
		smartChat(L.SpellUseYell:format(DbmRV, premsg_values.args_sourceName, draining))
		premsg_values.draining = 0
	elseif premsg_values.invokingText == 1 then
		smartChat(L.SpellUseYell:format(DbmRV, premsg_values.args_sourceName, invokingText))
		premsg_values.invokingText = 0
	elseif premsg_values.drinking == 1 then
		smartChat(L.SpellUseYell:format(DbmRV, premsg_values.args_sourceName, drinking))
		premsg_values.drinking = 0
	elseif premsg_values.releaseSpores == 1 then
		smartChat(L.SpellUseYell:format(DbmRV, premsg_values.args_sourceName, releaseSpores))
		premsg_values.releaseSpores = 0
	elseif premsg_values.shuttingDown == 1 then
		smartChat(L.SpellUseYell:format(DbmRV, premsg_values.args_sourceName, shuttingDown))
		premsg_values.shuttingDown = 0
	elseif premsg_values.treating == 1 then
		smartChat(L.SpellUseYell:format(DbmRV, premsg_values.args_sourceName, treating))
		premsg_values.treating = 0
	elseif premsg_values.pilfering == 1 then
		smartChat(L.SpellUseYell:format(DbmRV, premsg_values.args_sourceName, pilfering))
		premsg_values.pilfering = 0
	elseif premsg_values.tinkering == 1 then
		smartChat(L.SpellUseYell:format(DbmRV, premsg_values.args_sourceName, tinkering))
		premsg_values.tinkering = 0
	elseif premsg_values.defacing == 1 then
		smartChat(L.SpellUseYell:format(DbmRV, premsg_values.args_sourceName, defacing))
		premsg_values.defacing = 0
	elseif premsg_values.clues == 1 then
		smartChat(premsg_values.hintTranslations_clue)
		premsg_values.clues = 0
	end

	premsg_values.args_sourceName = nil
	premsg_values.args_destName = nil
	premsg_values.hintTranslations_clue = nil
end

local function announceList(premsg_announce, value)
	--[[if premsg_announce == "premsg_CoSTrash_test" then
		premsg_values.test = value
	else]]if premsg_announce == "premsg_CoSTrash_eating" then
		premsg_values.eating = value
	elseif premsg_announce == "premsg_CoSTrash_siphoningMagic" then
		premsg_values.siphoningMagic = value
	elseif premsg_announce == "premsg_CoSTrash_purifying" then
		premsg_values.purifying = value
	elseif premsg_announce == "premsg_CoSTrash_draining" then
		premsg_values.draining = value
	elseif premsg_announce == "premsg_CoSTrash_invokingText" then
		premsg_values.invokingText = value
	elseif premsg_announce == "premsg_CoSTrash_drinking" then
		premsg_values.drinking = value
	elseif premsg_announce == "premsg_CoSTrash_releaseSpores" then
		premsg_values.releaseSpores = value
	elseif premsg_announce == "premsg_CoSTrash_shuttingDown" then
		premsg_values.shuttingDown = value
	elseif premsg_announce == "premsg_CoSTrash_treating" then
		premsg_values.treating = value
	elseif premsg_announce == "premsg_CoSTrash_pilfering" then
		premsg_values.pilfering = value
	elseif premsg_announce == "premsg_CoSTrash_tinkering" then
		premsg_values.tinkering = value
	elseif premsg_announce == "premsg_CoSTrash_defacing" then
		premsg_values.defacing = value
	elseif premsg_announce == "premsg_CoSTrash_clues" then
		premsg_values.clues = value
	end
end

local function prepareMessage(self, premsg_announce, args_sourceName, args_destName, hintTranslations_clue)
	if self:AntiSpam(1, "prepareMessage") then
		premsg_values.args_sourceName = args_sourceName
		premsg_values.args_destName = args_destName
		premsg_values.hintTranslations_clue = hintTranslations_clue
		announceList(premsg_announce, 1)
		self:SendSync(premsg_announce, playerOnlyName)
		self:Schedule(1, sendAnnounce, self)
	end
end
-- Синхронизация анонсов ↑

function mod:CarrionSwarmTarget(targetname, uId) --Темная стая ✔
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnCarrionSwarm:Show()
		specWarnCarrionSwarm:Play("watchstep")
		yellCarrionSwarm:Yell()
	else
		warnCarrionSwarm:Show(targetname)
	end
end

function mod:SuppressTarget(targetname, uId) --Подавление ✔
	if not targetname then return end
	if targetname == UnitName("player") then
	--	specWarnSuppress2:Show()
	--	specWarnSuppress2:Play("targetyou")
		yellSuppress:Yell()
	else
		warnSuppress:Show(targetname)
	end
end

function mod:DisintegrationBeamTarget(targetname, uId) --Луч дезинтеграции ✔
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnDisintegrationBeam:Show()
		specWarnDisintegrationBeam:Play("defensive")
		yellDisintegrationBeam:Yell()
	else
		warnDisintegrationBeam:Show(targetname)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	--[[if spellId == 8690 then
		prepareMessage(self, "premsg_CoSTrash_test", args.sourceName, args.destName)
	end]]
	if not self.Options.Enabled then return end
	if spellId == 209027 and self:AntiSpam(3, 5) then
		specWarnQuellingStrike:Show()
		specWarnQuellingStrike:Play("shockwave")
	elseif spellId == 212031 and self:AntiSpam(3, 6) then
		specWarnChargedBlast:Show()
		specWarnChargedBlast:Play("shockwave")
	elseif spellId == 209485 then --Похищение магии
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnDrainMagic:Show()
			specWarnDrainMagic:Play("kickcast")
		else
			warnDrainMagic:Show()
			warnDrainMagic:Play("kickcast")
		end
	elseif spellId == 209410 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnNightfallOrb:Show(args.sourceName)
		specWarnNightfallOrb:Play("kickcast")
	elseif spellId == 209413 then --Подавление
		self:BossTargetScanner(args.sourceGUID, "SuppressTarget", 0.1, 2)
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnSuppress:Show()
			specWarnSuppress:Play("kickcast")
		end
	elseif spellId == 211470 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnBewitch:Show()
		specWarnBewitch:Play("kickcast")
	elseif spellId == 225100 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnChargingStation:Show()
		specWarnChargingStation:Play("kickcast")
	elseif spellId == 211299 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnSearingGlare:Show()
		specWarnSearingGlare:Play("kickcast")
	elseif spellId == 211464 then
		warnFelDetonation:Show()
		if not UnitIsDeadOrGhost("player") then
			specWarnFelDetonation:Show()
			specWarnFelDetonation:Play("aesoon")
		end
		timerFelDetonationCD:Start()
		countdownFelDetonation:Start()
	elseif spellId == 209404 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Подавление магии
		specWarnSealMagic:Show()
		specWarnSealMagic:Play("kickcast")
	elseif spellId == 209495 and self:AntiSpam(2, 7) then --Удар с размаху
		--Don't want to move too early, just be moving already as cast is finishing
		specWarnChargedSmash:Schedule(1.2)
		specWarnChargedSmash:ScheduleVoice(1.2, "chargemove")
	elseif spellId == 209378 then
		if not UnitIsDeadOrGhost("player") then
			specWarnWhirlingBlades:Show()
			specWarnWhirlingBlades:Play("runout")
		end
		timerWhirlingBladesCD:Start()
	elseif spellId == 207980 then --Луч дезинтеграции
		self:BossTargetScanner(args.sourceGUID, "DisintegrationBeamTarget", 0.1, 2)
		timerDisintegrationBeamCD:Start()
	elseif spellId == 207979 then --Ударная волна
		if not UnitIsDeadOrGhost("player") then
			specWarnShockwave:Show()
			specWarnShockwave:Play("watchstep")
		end
		timerShockwaveCD:Start()
	elseif spellId == 214692 then --Залп стрел Тьмы
		warnShadowBoltVolley:Show()
		timerShadowBoltVolleyCD:Start()
		if self:IsHard() then
			if not UnitIsDeadOrGhost("player") then
				specWarnShadowBoltVolley:Show()
				specWarnShadowBoltVolley:Play("watchstep")
			end
		end
		self:ResetGossipState()
	elseif spellId == 214688 then --Темная стая
		self:BossTargetScanner(args.sourceGUID, "CarrionSwarmTarget", 0.1, 2)
	elseif spellId == 214690 then --Увечье
		timerCrippleCD:Start()
	elseif spellId == 212773 and self:AntiSpam(2, 8) then --Подчинение
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnSubdue:Show(args.sourceName)
			specWarnSubdue:Play("kickcast")
		else
			warnSubdue2:Show()
			warnSubdue2:Play("kickcast")
		end
	elseif spellId == 210253 then --Отключение маяка
		warnDisableBeacon:Show(args.sourceName)
	elseif spellId == 214697 then --Поднять ключ
		warnPickingUp:Show(args.sourceName)
		if args:IsPlayerSource() then
			yellPickingUp:Yell(key)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 214688 then --Темная стая
		timerCarrionSwarmCD:Start()
	elseif spellId == 208585 then --Поглощение пищи
		warnEating:Show(args.sourceName)
		if self.Options.YellOnEating then
			prepareMessage(self, "premsg_CoSTrash_eating", args.sourceName)
		end
	elseif spellId == 208427 then --Похищение магии
		warnSiphoningMagic:Show(args.sourceName)
		if self.Options.YellOnSiphoningMagic then
			prepareMessage(self, "premsg_CoSTrash_siphoningMagic", args.sourceName)
		end
	elseif spellId == 209767 then --Очищение
		warnPurifying:Show(args.sourceName)
		if self.Options.YellOnPurifying then
			prepareMessage(self, "premsg_CoSTrash_purifying", args.sourceName)
		end
	elseif spellId == 208334 then --Иссушение
		warnDraining:Show(args.sourceName)
		if self.Options.YellOnDraining then
			prepareMessage(self, "premsg_CoSTrash_draining", args.sourceName)
		end
	elseif spellId == 210872 then --Текст пробуждения
		warnInvokingText:Show(args.sourceName)
		if self.Options.YellOnInvokingText then
			prepareMessage(self, "premsg_CoSTrash_invokingText", args.sourceName)
		end
	elseif spellId == 210307 then --Выпивание
		warnDrinking:Show(args.sourceName)
		if self.Options.YellOnDrinking then
			prepareMessage(self, "premsg_CoSTrash_drinking", args.sourceName)
		end
	elseif spellId == 208939 then --Высвобождение спор
		warnReleaseSpores:Show(args.sourceName)
		if self.Options.YellOnReleaseSpores then
			prepareMessage(self, "premsg_CoSTrash_releaseSpores", args.sourceName)
		end
	elseif spellId == 208370 then --Отключение
		warnShuttingDown:Show(args.sourceName)
		if self.Options.YellOnShuttingDown then
			prepareMessage(self, "premsg_CoSTrash_shuttingDown", args.sourceName)
		end
	elseif spellId == 210925 then --Лечение
		warnTreating:Show(args.sourceName)
		if self.Options.YellOnTreating then
			prepareMessage(self, "premsg_CoSTrash_treating", args.sourceName)
		end
	elseif spellId == 210217 then --Воровство
		warnPilfering:Show(args.sourceName)
		if self.Options.YellOnPilfering then
			prepareMessage(self, "premsg_CoSTrash_pilfering", args.sourceName)
		end
	elseif spellId == 210922 then --Конструирование
		warnTinkering:Show(args.sourceName)
		if self.Options.YellOnTinkering then
			prepareMessage(self, "premsg_CoSTrash_tinkering", args.sourceName)
		end
	elseif spellId == 210330 then --Осквернение
		warnDefacing:Show(args.sourceName)
		if self.Options.YellOnDefacing then
			prepareMessage(self, "premsg_CoSTrash_defacing", args.sourceName)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 209033 and not args:IsDestTypePlayer() then --Укрепление
		specWarnFortification:Show(args.destName)
		specWarnFortification:Play("dispelnow")
	elseif spellId == 209512 and args:IsPlayer() then
		specWarnDisruptingEnergy:Show()
		specWarnDisruptingEnergy:Play("runaway")
	elseif spellId == 214690 then --Увечье
		warnCripple:Show(args.destName)
		timerCripple:Start(args.destName)
		if self:IsMythic() then
			if args:IsPlayer() and not self:IsMagicDispeller2() then
				specWarnCripple2:Show()
				specWarnCripple2:Play("targetyou")
				yellCripple:Yell()
			elseif args:IsPlayer() and self:IsMagicDispeller2() then
				specWarnCripple3:Show()
				specWarnCripple3:Play("dispelnow")
				yellCripple:Yell()
			elseif self:IsMagicDispeller2() then
				if not UnitIsDeadOrGhost("player") then
					specWarnCripple:Show(args.destName)
					specWarnCripple:Play("dispelnow")
				end
			end
		else
			if args:IsPlayer() and not self:IsMagicDispeller2() then
				specWarnCripple2:Show()
				specWarnCripple2:Play("targetyou")
				yellCripple:Yell()
			elseif args:IsPlayer() and self:IsMagicDispeller2() then
				specWarnCripple3:Show()
				specWarnCripple3:Play("dispelnow")
				yellCripple:Yell()
			end
		end
	elseif spellId == 212773 then --Подчинение
		if args:IsPlayer() then
			yellSubdue:Yell()
		elseif self:IsMagicDispeller2() then
			if not UnitIsDeadOrGhost("player") then
				specWarnSubdue2:CombinedShow(0.3, args.destName)
				specWarnSubdue2:Play("dispelnow")
			end
		else
			warnSubdue:CombinedShow(0.3, args.destName)
		end
	elseif spellId == 209404 then --Подавление магии
		warnSealMagic:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			yellSealMagic:Yell()
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 214690 then --Увечье
		timerCripple:Cancel(args.destName)
	end
end

local hintTranslations = {
	["gloves"] = L.Gloves,
	["no gloves"] = L.NoGloves,
	["cape"] = L.Cape,
	["no cape"] = L.Nocape,
	["light vest"] = L.LightVest,
	["dark vest"] = L.DarkVest,
	["female"] = L.Female,
	["male"] = L.Male,
	["short sleeves"] = L.ShortSleeve,
	["long sleeves"] = L.LongSleeve,
	["potions"] = L.Potions,
	["no potion"] = L.NoPotions,
	["book"] = L.Book,
	["pouch"] = L.Pouch
}
local hints = {}
local clues = {
	[L.Gloves1] = "gloves",
	[L.Gloves2] = "gloves",
	[L.Gloves3] = "gloves",
	[L.Gloves4] = "gloves",
	[L.Gloves5] = "gloves",
	[L.Gloves6] = "gloves",
	
	[L.NoGloves1] = "no gloves",
	[L.NoGloves2] = "no gloves",
	[L.NoGloves3] = "no gloves",
	[L.NoGloves4] = "no gloves",
	[L.NoGloves5] = "no gloves",
	[L.NoGloves6] = "no gloves",
	[L.NoGloves7] = "no gloves",
	
	[L.Cape1] = "cape",
	[L.Cape2] = "cape",
	
	[L.NoCape1] = "no cape",
	[L.NoCape2] = "no cape",
	
	[L.LightVest1] = "light vest",
	[L.LightVest2] = "light vest",
	[L.LightVest3] = "light vest",
	
	[L.DarkVest1] = "dark vest",
	[L.DarkVest2] = "dark vest",
	[L.DarkVest3] = "dark vest",
	[L.DarkVest4] = "dark vest",
	
	[L.Female1] = "female",
	[L.Female2] = "female",
	[L.Female3] = "female",
	[L.Female4] = "female",
	[L.Female5] = "female",
	
	[L.Male1] = "male",
	[L.Male2] = "male",
	[L.Male3] = "male",
	[L.Male4] = "male",
	[L.Male5] = "male",
	[L.Male6] = "male",
	
	[L.ShortSleeve1] = "short sleeves",
	[L.ShortSleeve2] = "short sleeves",
	[L.ShortSleeve3] = "short sleeves",
	[L.ShortSleeve4] = "short sleeves",
	[L.ShortSleeve5] = "short sleeves",
	
	[L.LongSleeve1] = "long sleeves",
	[L.LongSleeve2] = "long sleeves",
	[L.LongSleeve3] = "long sleeves",
	[L.LongSleeve4] = "long sleeves",
	[L.LongSleeve5] = "long sleeves",
	
	[L.Potions1] = "potions",
	[L.Potions2] = "potions",
	[L.Potions3] = "potions",
	[L.Potions4] = "potions",
	[L.Potions5] = "potions",
	[L.Potions6] = "potions",
	
	[L.NoPotions1] = "no potion",
	[L.NoPotions2] = "no potion",
	
	[L.Book1] = "book",
	[L.Book2] = "book",
	[L.Book3] = "book",
	
	[L.Pouch1] = "pouch",
	[L.Pouch2] = "pouch",
	[L.Pouch3] = "pouch",
	[L.Pouch4] = "pouch",
	[L.Pouch5] = "pouch",
	[L.Pouch6] = "pouch",
	[L.Pouch7] = "pouch"
}
local bwClues = {
	[1] = "cape",
	[2] = "no cape",
	[3] = "pouch",
	[4] = "potions",
	[5] = "long sleeves",
	[6] = "short sleeves",
	[7] = "gloves",
	[8] = "no gloves",
	[9] = "male",
	[10] = "female",
	[11] = "light vest",
	[12] = "dark vest",
	[13] = "no potion",
	[14] = "book"
}

local function updateInfoFrame()
	local lines = {}
	for hint, j in pairs(hints) do
		local text = hintTranslations[hint] or hint
		lines[text] = ""
	end
	
	return lines
end

--/run DBM:GetModByName("CoSTrash"):ResetGossipState()
function mod:ResetGossipState()
	table.wipe(hints)
	DBM.InfoFrame:Hide()
end

function mod:CHAT_MSG_MONSTER_SAY(msg)
	if msg:find(L.Found) then
		self:SendSync("Finished")
	elseif msg == L.proshlyapMurchal then
		self:SendSync("RolePlayMel")
	end
end

function mod:GOSSIP_SHOW()
	if not self.Options.SpyHelper then return end
	local guid = UnitGUID("npc")
	if not guid then return end
	local cid = self:GetCIDFromGUID(guid)
	--105729 Сигнальный фонарь, 106468 Ли'лет Лунарх
	--105249 Закуски ночной тени (Расы - панды, профы - кулинарка 800), 105340 Теневой цветок (классы - друиды, профы - травничество 800), 105117 Настой священной ночи (классы - роги, профы - алхимка 100+)
	--106110 Промокший свиток (классы - шаман, профы - кожевничество, начертание по 100+), 106024 Магический светильник (расы - эльфы, классы - маг, профы - наложение чар 100+)
	--106018 Рыночные товары (классы - воин, разбойник, профы - кожевничество 100+), 106113 Статуя ночнорожденного в натуральную величину (профы - горное дело и ювелирное 100+), 105831 Инфернальный фолиант (классы - дх, жрец, паладин)
	--105157 Проводник магической энергии (расы - гном, гоблин, профы - инженерия 100+), 105160 Сфера Скверны, 106108 Отвар из звездной розы, 105215 Выброшенный хлам, 106112 Раненый ночнорожденный
	if cid == 106024 or cid == 105729 or cid == 106468 or cid == 105249 or cid == 105340 or cid == 105117 or cid == 106110 or cid == 106018 or cid == 106113 or cid == 105831 or cid == 105157 or cid == 105160 or cid == 106108 or cid == 105215 or cid == 106112 then
		if select('#', GetGossipOptions()) > 0 then
			SelectGossipOption(1)
			CloseGossip()
		end
	end		
	-- Suspicious noble
	if cid == 107486 then --Болтливый сплетник
		if select('#', GetGossipOptions()) > 0 then
			SelectGossipOption(1)
		else
			local clue = clues[GetGossipText()]
			if clue and not hints[clue] then
				CloseGossip()
				prepareMessage(self, "premsg_CoSTrash_clues", nil, nil, hintTranslations[clue])
				hints[clue] = true
				self:SendSync("CoS", clue)
				DBM.InfoFrame:Show(5, "function", updateInfoFrame)
			end
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 104278 then --Порабощенная Скверной карательница
		timerFelDetonationCD:Cancel()
		countdownFelDetonation:Cancel()
	elseif cid == 104275 then --Имаку'туя
		self.vb.wardens = 2
		warnMinionDie:Show(self.vb.wardens)
		timerWhirlingBladesCD:Cancel()
	elseif cid == 104274 then --Баалгар Бдительный
		self.vb.wardens = 1
		warnMinionDie:Show(self.vb.wardens)
		timerDisintegrationBeamCD:Cancel()
	elseif cid == 104273 then --Джазшариу
		self.vb.wardens = 0
		warnMinionDie:Show(self.vb.wardens)
		timerShockwaveCD:Cancel()
	elseif cid == 108151 or cid == 107435 then --Герент Зловещий
		timerCrippleCD:Cancel()
		timerShadowBoltVolleyCD:Cancel()
		timerCarrionSwarmCD:Cancel()
	end
end

function mod:OnSync(msg, clue)
	local premsg_announce = msg
	local sender = clue
	if sender < playerOnlyName then
		announceList(premsg_announce, 0)
	end
	if not self.Options.SpyHelper then return end
	if msg == "CoS" and clue then
		hints[clue] = true
		DBM.InfoFrame:Show(5, "function", updateInfoFrame)
	elseif msg == "Finished" then
		warnPhase2:Show()
		self:ResetGossipState()
	--	self:Finish()
	elseif msg == "RolePlayMel" then
		timerRoleplay:Start()
	end
end

function mod:OnBWSync(msg, extra)
	if msg ~= "clue" then return end
	extra = tonumber(extra)
	if extra and extra > 0 and extra < 15 then
		DBM:Debug("Recieved BigWigs Comm:"..extra)
		local bwClue = bwClues[extra]
		hints[bwClue] = true
		DBM.InfoFrame:Show(5, "function", updateInfoFrame)
	end
end
