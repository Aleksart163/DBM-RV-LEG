local mod	= DBM:NewMod("Spells2", "DBM-Spells")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS 97462 205223 31821 15286 62618 47788 64901",
	"SPELL_AURA_APPLIED 33206 116849 1022 29166 64901 102342",
	"SPELL_AURA_REMOVED 47788 29166 64901 197908 102342 116849",
	"SPELL_SUMMON 98008 207399",
	"SPELL_RESURRECT 20484 95750 61999"
)

--Прошляпанное очко Мурчаля Прошляпенко [✔]
local warnRallyingCry				= mod:NewTargetSourceAnnounce(97462, 1) --Ободряющий клич
local warnVampiricAura				= mod:NewTargetSourceAnnounce(238698, 1) --Вампирская аура
local warnAuraMastery				= mod:NewTargetSourceAnnounce(31821, 1) --Владение аурами
local warnVampiricEmbrace			= mod:NewTargetSourceAnnounce(15286, 1) --Объятия вампира
local warnPowerWordBarrier			= mod:NewTargetSourceAnnounce(62618, 1) --Слово силы: Барьер
local warnGuardianSpirit			= mod:NewTargetSourceAnnounce2(47788, 1) --Оберегающий дух
local warnPainSuppression			= mod:NewTargetSourceAnnounce2(33206, 1) --Подавление боли
local warnSpiritLinkTotem			= mod:NewTargetSourceAnnounce(98008, 1) --Тотем духовной связи
local warnLifeCocoon				= mod:NewTargetSourceAnnounce2(116849, 1) --Исцеляющий кокон
local warnBlessingofProtection		= mod:NewTargetSourceAnnounce2(1022, 1) --Благословение защиты
local warnIronbark					= mod:NewTargetSourceAnnounce2(102342, 1) --Железная кора
local warnAncestralProtectionTotem	= mod:NewTargetSourceAnnounce(207399, 1) --Тотем защиты Предков
local warnRebirth					= mod:NewTargetSourceAnnounce2(20484, 2) --Возрождение
local warnInnervate					= mod:NewTargetSourceAnnounce2(29166, 1) --Озарение
local warnSymbolHope				= mod:NewTargetSourceAnnounce(64901, 1) --Символ надежды

local specWarnGuardianSpirit		= mod:NewSpecialWarningYou(47788, nil, nil, nil, 1, 2) --Оберегающий дух
local specWarnPainSuppression		= mod:NewSpecialWarningYou(33206, nil, nil, nil, 1, 2) --Подавление боли
local specWarnLifeCocoon			= mod:NewSpecialWarningYou(116849, nil, nil, nil, 1, 2) --Исцеляющий кокон
local specWarnBlessingofProtection	= mod:NewSpecialWarningYou(1022, nil, nil, nil, 1, 2) --Благословение защиты
local specWarnRebirth 				= mod:NewSpecialWarningYou(20484, nil, nil, nil, 1, 2) --Возрождение
local specWarnInnervate 			= mod:NewSpecialWarningYou(29166, nil, nil, nil, 1, 2) --Озарение
local specWarnInnervate2			= mod:NewSpecialWarningEnd(29166, nil, nil, nil, 1, 2) --Озарение
local specWarnIronbark				= mod:NewSpecialWarningYou(102342, nil, nil, nil, 1, 2) --Железная кора
local specWarnSymbolHope 			= mod:NewSpecialWarningYou(64901, nil, nil, nil, 1, 2) --Символ надежды
local specWarnSymbolHope2			= mod:NewSpecialWarningEnd(64901, nil, nil, nil, 1, 2) --Символ надежды
local specWarnManaTea2				= mod:NewSpecialWarningEnd(197908, nil, nil, nil, 1, 2) --Маначай

local timerRallyingCry				= mod:NewBuffActiveTimer(10, 97462, nil, nil, nil, 7) --Ободряющий клич
local timerVampiricAura				= mod:NewBuffActiveTimer(15, 238698, nil, nil, nil, 7) --Вампирская аура
local timerAuraMastery				= mod:NewBuffActiveTimer(6, 31821, nil, nil, nil, 7) --Владение аурами
local timerVampiricEmbrace			= mod:NewBuffActiveTimer(15, 15286, nil, nil, nil, 7) --Объятия вампира
local timerPowerWordBarrier			= mod:NewBuffActiveTimer(10, 62618, nil, nil, nil, 7) --Слово силы: Барьер
local timerGuardianSpirit			= mod:NewBuffActiveTimer(10, 47788, nil, nil, nil, 7) --Оберегающий дух
local timerPainSuppression			= mod:NewBuffActiveTimer(8, 33206, nil, nil, nil, 7) --Подавление боли
local timerLifeCocoon				= mod:NewBuffActiveTimer(12, 116849, nil, nil, nil, 7) --Исцеляющий кокон
local timerBlessingofProtection		= mod:NewBuffActiveTimer(10, 1022, nil, nil, nil, 7) --Благословение защиты
local timerIronbark					= mod:NewBuffActiveTimer(12, 102342, nil, nil, nil, 7) --Железная кора
local timerInnervate				= mod:NewBuffActiveTimer(10, 29166, nil, nil, nil, 7) --Озарение

local yellRallyingCry				= mod:NewYell(97462, L.SpellNameYell, nil, nil, "YELL") --Ободряющий клич
local yellVampiricAura				= mod:NewYell(238698, L.SpellNameYell, nil, nil, "YELL") --Вампирская аура
local yellAuraMastery				= mod:NewYell(31821, L.SpellNameYell, nil, nil, "YELL") --Владение аурами
local yellVampiricEmbrace			= mod:NewYell(15286, L.SpellNameYell, nil, nil, "YELL") --Объятия вампира
local yellPowerWordBarrier			= mod:NewYell(62618, L.SpellNameYell, nil, nil, "YELL") --Слово силы: Барьер
local yellAncestralProtectionTotem	= mod:NewYell(207399, L.SpellNameYell, nil, nil, "YELL") --Тотем защиты Предков
local yellSymbolHope				= mod:NewYell(64901, L.SpellNameYell, nil, nil, "YELL") --Символ надежды

mod:AddBoolOption("YellOnRaidCooldown", true) --рейд кд
mod:AddBoolOption("YellOnResurrect", true) --бр

--[[рейд кд
local rallyingcry, vampiricaura, auramastery, vampiricembrace, powerwordbarrier, guardianspirit, painsuppression, spirittotem, lifecocoon, blesofprot, ironbark, ancprotectotem = replaceSpellLinks(97462), replaceSpellLinks(238698), replaceSpellLinks(31821), replaceSpellLinks(15286), replaceSpellLinks(62618), replaceSpellLinks(47788), replaceSpellLinks(33206), replaceSpellLinks(98008), replaceSpellLinks(116849), replaceSpellLinks(1022), replaceSpellLinks(102342), replaceSpellLinks(207399)
--Реген маны
local hope, innervate, manatea = replaceSpellLinks(64901), replaceSpellLinks(29166), replaceSpellLinks(197908)
--БР
local rebirth1, rebirth2, rebirth3 = replaceSpellLinks(20484), replaceSpellLinks(61999), replaceSpellLinks(95750)]]

local typeInstance = nil

local function UnitInYourParty(sourceName)
	if GetNumGroupMembers() > 0 and (UnitInParty(sourceName) or UnitPlayerOrPetInParty(sourceName) or UnitInRaid(sourceName) or UnitInBattleground(sourceName)) then
		return true
	end
	return false
end

-- Синхронизация анонсов ↓
local premsg_values = {
	-- test,
	spellId,
	sourceName,
	destName,
	localizedName,
	rallyingcry, vampiricaura, auramastery, vampiricembrace, powerwordbarrier, guardianspirit, painsuppression, spirittotem, lifecocoon, blesofprot, ironbark, ancprotectotem,
	hope, innervate,
	rebirth1, rebirth2, rebirth3
}
local playerOnlyName = UnitName("player")

local function sendAnnounce(self)
	if premsg_values.spellId == nil then
		premsg_values.localizedName = "Unknown"
	else
		premsg_values.localizedName = replaceSpellLinks(premsg_values.spellId)
	end
	if premsg_values.sourceName == nil then premsg_values.sourceName = "Unknown" end
	if premsg_values.destName == nil then premsg_values.destName = "Unknown" end

	if premsg_values.rallyingcry == 1 then --Ободряющий клич
		smartChat(L.HeroismYell:format(DbmRV, premsg_values.sourceName, premsg_values.localizedName))
		premsg_values.rallyingcry = 0
	elseif premsg_values.vampiricaura == 1 then --Вампирская аура
		smartChat(L.HeroismYell:format(DbmRV, premsg_values.sourceName, premsg_values.localizedName))
		premsg_values.vampiricaura = 0
	elseif premsg_values.auramastery == 1 then --Владение аурами
		smartChat(L.HeroismYell:format(DbmRV, premsg_values.sourceName, premsg_values.localizedName))
		premsg_values.auramastery = 0
	elseif premsg_values.vampiricembrace == 1 then --Объятия вампира
		smartChat(L.HeroismYell:format(DbmRV, premsg_values.sourceName, premsg_values.localizedName))
		premsg_values.vampiricembrace = 0
	elseif premsg_values.powerwordbarrier == 1 then --Слово силы: Барьер
		smartChat(L.HeroismYell:format(DbmRV, premsg_values.sourceName, premsg_values.localizedName))
		premsg_values.powerwordbarrier = 0
	elseif premsg_values.guardianspirit == 1 then --Оберегающий дух
		smartChat(L.SoulstoneYell:format(DbmRV, premsg_values.sourceName, premsg_values.localizedName, premsg_values.destName))
		premsg_values.guardianspirit = 0
	elseif premsg_values.painsuppression == 1 then --Подавление боли
		smartChat(L.SoulstoneYell:format(DbmRV, premsg_values.sourceName, premsg_values.localizedName, premsg_values.destName))
		premsg_values.painsuppression = 0
	elseif premsg_values.spirittotem == 1 then --Тотем духовной связи
		smartChat(L.HeroismYell:format(DbmRV, premsg_values.sourceName, premsg_values.localizedName))
		premsg_values.spirittotem = 0
	elseif premsg_values.lifecocoon == 1 then --Исцеляющий кокон
		smartChat(L.SoulstoneYell:format(DbmRV, premsg_values.sourceName, premsg_values.localizedName, premsg_values.destName))
		premsg_values.lifecocoon = 0
	elseif premsg_values.blesofprot == 1 then --Благословение защиты
		smartChat(L.SoulstoneYell:format(DbmRV, premsg_values.sourceName, premsg_values.localizedName, premsg_values.destName))
		premsg_values.blesofprot = 0
	elseif premsg_values.ironbark == 1 then --Железная кора
		smartChat(L.SoulstoneYell:format(DbmRV, premsg_values.sourceName, premsg_values.localizedName, premsg_values.destName))
		premsg_values.ironbark = 0
	elseif premsg_values.ancprotectotem == 1 then --Тотем защиты Предков
		smartChat(L.HeroismYell:format(DbmRV, premsg_values.sourceName, premsg_values.localizedName))
		premsg_values.ancprotectotem = 0
	elseif premsg_values.hope == 1 then --Символ надежды
		smartChat(L.HeroismYell:format(DbmRV, premsg_values.sourceName, premsg_values.localizedName))
		premsg_values.hope = 0
	elseif premsg_values.innervate == 1 then --Озарение
		smartChat(L.SoulstoneYell:format(DbmRV, premsg_values.sourceName, premsg_values.localizedName, premsg_values.destName))
		premsg_values.innervate = 0
	elseif premsg_values.rebirth1 == 1 then --Возрождение
		smartChat(L.SoulstoneYell:format(DbmRV, premsg_values.sourceName, premsg_values.localizedName, premsg_values.destName))
		premsg_values.rebirth1 = 0
	elseif premsg_values.rebirth2 == 1 then --Воскрешение союзника
		smartChat(L.SoulstoneYell:format(DbmRV, premsg_values.sourceName, premsg_values.localizedName, premsg_values.destName))
		premsg_values.rebirth2 = 0
	elseif premsg_values.rebirth3 == 1 then --Воскрешение камнем души
		smartChat(L.SoulstoneYell:format(DbmRV, premsg_values.sourceName, premsg_values.localizedName, premsg_values.destName))
		premsg_values.rebirth3 = 0
	end

	premsg_values.spellId = nil
	premsg_values.sourceName = nil
	premsg_values.destName = nil
	premsg_values.localizedName = nil
end

local function announceList(premsg_announce, value)
	if premsg_announce == "premsg_Spells_rallyingcry" then --Ободряющий клич
		premsg_values.rallyingcry = value
	elseif premsg_announce == "premsg_Spells_vampiricaura" then --Вампирская аура
		premsg_values.vampiricaura = value
	elseif premsg_announce == "premsg_Spells_auramastery" then --Владение аурами
		premsg_values.auramastery = value
	elseif premsg_announce == "premsg_Spells_vampiricembrace" then --Объятия вампира
		premsg_values.vampiricembrace = value
	elseif premsg_announce == "premsg_Spells_powerwordbarrier" then --Слово силы: Барьер
		premsg_values.powerwordbarrier = value
	elseif premsg_announce == "premsg_Spells_guardianspirit" then --Оберегающий дух
		premsg_values.guardianspirit = value
	elseif premsg_announce == "premsg_Spells_painsuppression" then --Подавление боли
		premsg_values.painsuppression = value
	elseif premsg_announce == "premsg_Spells_spirittotem" then --Тотем духовной связи
		premsg_values.spirittotem = value
	elseif premsg_announce == "premsg_Spells_lifecocoon" then --Исцеляющий кокон
		premsg_values.lifecocoon = value
	elseif premsg_announce == "premsg_Spells_blesofprot" then --Благословение защиты
		premsg_values.blesofprot = value
	elseif premsg_announce == "premsg_Spells_ironbark" then --Железная кора
		premsg_values.ironbark = value
	elseif premsg_announce == "premsg_Spells_ancprotectotem" then --Тотем защиты Предков
		premsg_values.ancprotectotem = value
	elseif premsg_announce == "premsg_Spells_hope" then --Символ надежды
		premsg_values.hope = value
	elseif premsg_announce == "premsg_Spells_innervate" then --Озарение
		premsg_values.innervate = value
	elseif premsg_announce == "premsg_Spells_rebirth1" then --Возрождение
		premsg_values.rebirth1 = value
	elseif premsg_announce == "premsg_Spells_rebirth2" then --Воскрешение союзника
		premsg_values.rebirth2 = value
	elseif premsg_announce == "premsg_Spells_rebirth3" then --Воскрешение камнем души
		premsg_values.rebirth3 = value
	end
end

local function prepareMessage(self, premsg_announce, spellId, sourceName, destName)
	if self:AntiSpam(1, "prepareMessage") then
		premsg_values.spellId = spellId
		premsg_values.sourceName = sourceName
		premsg_values.destName = destName
		announceList(premsg_announce, 1)
		self:SendSync(premsg_announce, playerOnlyName)
		self:Schedule(1, sendAnnounce, self)
	end
end
-- Синхронизация анонсов ↑

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	local sourceName = args.sourceName
	local destName = args.destName
	if not UnitInYourParty(sourceName) then return end
	typeInstance = select(2, IsInInstance())
	if spellId == 64901 then --Символ надежды
		if typeInstance ~= "party" and typeInstance ~= "raid" then return end
		if DBM:GetNumRealGroupMembers() < 2 then return end
		if args:IsPlayerSource() then
			yellSymbolHope:Yell(replaceSpellLinks(spellId))
		else
			warnSymbolHope:Show(sourceName)
		end
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnRaidCooldown then
			prepareMessage(self, "premsg_Spells_hope", spellId, sourceName)
		end
	elseif spellId == 97462 then --Ободряющий клич
		if typeInstance ~= "party" and typeInstance ~= "raid" then return end
		if DBM:GetNumRealGroupMembers() < 2 then return end
		timerRallyingCry:Start()
		if args:IsPlayerSource() then
			yellRallyingCry:Yell(replaceSpellLinks(spellId))
		else
			warnRallyingCry:Show(sourceName)
		end
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnRaidCooldown then
			prepareMessage(self, "premsg_Spells_rallyingcry", spellId, sourceName)
		end
	elseif spellId == 205223 then --Пожирание
		if typeInstance ~= "party" then return end
		if DBM:GetNumRealGroupMembers() < 2 then return end
		timerVampiricAura:Start()
		if args:IsPlayerSource() then
			yellVampiricAura:Yell(replaceSpellLinks(spellId))
		else
			warnVampiricAura:Show(sourceName)
		end
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnRaidCooldown then
			prepareMessage(self, "premsg_Spells_vampiricaura", spellId, sourceName)
		end
	elseif spellId == 31821 then --Владение аурами
		if typeInstance ~= "party" and typeInstance ~= "raid" then return end
		if DBM:GetNumRealGroupMembers() < 2 then return end
		timerAuraMastery:Start()
		if args:IsPlayerSource() then
			yellAuraMastery:Yell(replaceSpellLinks(spellId))
		else
			warnAuraMastery:Show(sourceName)
		end
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnRaidCooldown then
			prepareMessage(self, "premsg_Spells_auramastery", spellId, sourceName)
		end
	elseif spellId == 15286 then --Объятия вампира
		if typeInstance ~= "party" and typeInstance ~= "raid" then return end
		if DBM:GetNumRealGroupMembers() < 2 then return end
		timerVampiricEmbrace:Start()
		if args:IsPlayerSource() then
			yellVampiricEmbrace:Yell(replaceSpellLinks(spellId))
		else
			warnVampiricEmbrace:Show(sourceName)
		end
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnRaidCooldown then
			prepareMessage(self, "premsg_Spells_vampiricembrace", spellId, sourceName)
		end
	elseif spellId == 62618 then --Слово силы: Барьер
		if typeInstance ~= "party" and typeInstance ~= "raid" then return end
		if DBM:GetNumRealGroupMembers() < 2 then return end
		timerPowerWordBarrier:Start()
		if args:IsPlayerSource() then
			yellPowerWordBarrier:Yell(replaceSpellLinks(spellId))
		else
			warnPowerWordBarrier:Show(sourceName)
		end
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnRaidCooldown then
			prepareMessage(self, "premsg_Spells_powerwordbarrier", spellId, sourceName)
		end
	elseif spellId == 47788 then --Оберегающий дух
		if typeInstance ~= "party" and typeInstance ~= "raid" then return end
		if DBM:GetNumRealGroupMembers() < 2 then return end
		if args:IsPlayer() then
			specWarnGuardianSpirit:Show()
			specWarnGuardianSpirit:Play("targetyou")
			timerGuardianSpirit:Start()
			if not args:IsPlayerSource() and not DBM.Options.IgnoreRaidAnnounce3 then
				smartChat(L.WhisperThanks:format(DbmRV, replaceSpellLinks(spellId)), "whisper", sourceName)
			end
		else
			warnGuardianSpirit:Show(sourceName, destName)
		end
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnRaidCooldown then
			prepareMessage(self, "premsg_Spells_guardianspirit", spellId, sourceName, destName)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	local sourceName = args.sourceName
	local destName = args.destName
	if not UnitInYourParty(sourceName) then return end
	typeInstance = select(2, IsInInstance())
	if spellId == 29166 then --Озарение
		if typeInstance ~= "party" and typeInstance ~= "raid" then return end
		if DBM:GetNumRealGroupMembers() < 2 then return end
		if args:IsPlayer() and self:IsHealer() then
			specWarnInnervate:Show()
			specWarnInnervate:Play("targetyou")
			timerInnervate:Start()
			if not args:IsPlayerSource() and not DBM.Options.IgnoreRaidAnnounce3 then
				smartChat(L.WhisperThanks:format(DbmRV, replaceSpellLinks(spellId)), "whisper", sourceName)
			end
		else
			warnInnervate:Show(sourceName, destName)
		end
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnRaidCooldown then
			prepareMessage(self, "premsg_Spells_innervate", spellId, sourceName, destName)
		end
	elseif spellId == 64901 then --Символ надежды
		if typeInstance ~= "party" and typeInstance ~= "raid" then return end
		if DBM:GetNumRealGroupMembers() < 2 then return end
		if args:IsPlayer() and self:IsHealer() then
			specWarnSymbolHope:Show()
			specWarnSymbolHope:Play("targetyou")
		end
	elseif spellId == 33206 then --Подавление боли
		if typeInstance ~= "party" and typeInstance ~= "raid" then return end
		if DBM:GetNumRealGroupMembers() < 2 then return end
		if args:IsPlayer() then
			specWarnPainSuppression:Show()
			specWarnPainSuppression:Play("targetyou")
			timerPainSuppression:Start()
			if not args:IsPlayerSource() and not DBM.Options.IgnoreRaidAnnounce3 then
				smartChat(L.WhisperThanks:format(DbmRV, replaceSpellLinks(spellId)), "whisper", sourceName)
			end
		else
			warnPainSuppression:Show(sourceName, destName)
		end
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnRaidCooldown then
			prepareMessage(self, "premsg_Spells_painsuppression", spellId, sourceName, destName)
		end
	elseif spellId == 116849 then --Исцеляющий кокон
		if typeInstance ~= "party" and typeInstance ~= "raid" then return end
		if DBM:GetNumRealGroupMembers() < 2 then return end
		if args:IsPlayer() then
			specWarnLifeCocoon:Show()
			specWarnLifeCocoon:Play("targetyou")
			timerLifeCocoon:Start()
			if not args:IsPlayerSource() and not DBM.Options.IgnoreRaidAnnounce3 then
				smartChat(L.WhisperThanks:format(DbmRV, replaceSpellLinks(spellId)), "whisper", sourceName)
			end
		else
			warnLifeCocoon:Show(sourceName, destName)
		end
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnRaidCooldown then
			prepareMessage(self, "premsg_Spells_lifecocoon", spellId, sourceName, destName)
		end
	elseif spellId == 102342 then --Благословение защиты
		if typeInstance ~= "party" and typeInstance ~= "raid" then return end
		if DBM:GetNumRealGroupMembers() < 2 then return end
		if args:IsPlayer() then
			specWarnBlessingofProtection:Show()
			specWarnBlessingofProtection:Play("targetyou")
			timerBlessingofProtection:Start()
			if not args:IsPlayerSource() and not DBM.Options.IgnoreRaidAnnounce3 then
				smartChat(L.WhisperThanks:format(DbmRV, replaceSpellLinks(spellId)), "whisper", sourceName)
			end
		else
			warnBlessingofProtection:Show(sourceName, destName)
		end
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnRaidCooldown then
			prepareMessage(self, "premsg_Spells_blesofprot", spellId, sourceName, destName)
		end
	elseif spellId == 102342 then --Железная кора
		if typeInstance ~= "party" and typeInstance ~= "raid" then return end
		if DBM:GetNumRealGroupMembers() < 2 then return end
		if args:IsPlayer() then
			specWarnIronbark:Show()
			specWarnIronbark:Play("targetyou")
			timerIronbark:Start()
			if not args:IsPlayerSource() and not DBM.Options.IgnoreRaidAnnounce3 then
				smartChat(L.WhisperThanks:format(DbmRV, replaceSpellLinks(spellId)), "whisper", sourceName)
			end
		else
			warnIronbark:Show(sourceName, destName)
		end
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnRaidCooldown then
			prepareMessage(self, "premsg_Spells_ironbark", spellId, sourceName, destName)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	local sourceName = args.sourceName
	local destName = args.destName
	if not UnitInYourParty(sourceName) then return end
	if spellId == 29166 then --Озарение
		if args:IsPlayer() and self:IsHealer() then
			specWarnInnervate2:Show()
			specWarnInnervate2:Play("end")
			timerInnervate:Stop()
		end
	elseif spellId == 64901 then --Символ надежды
		if args:IsPlayer() and self:IsHealer() then
			specWarnSymbolHope2:Show()
			specWarnSymbolHope2:Play("end")
		end
	elseif spellId == 197908 then --Маначай
		if args:IsPlayer() and self:IsHealer() then
			specWarnManaTea2:Show()
			specWarnManaTea2:Play("end")
		end
	elseif spellId == 47788 then --Оберегающий дух
		if args:IsPlayer() then
			timerGuardianSpirit:Stop()
		end
	elseif spellId == 116849 then --Исцеляющий кокон
		if args:IsPlayer() then
			timerLifeCocoon:Stop()
		end
	elseif spellId == 102342 then --Железная кора
		if args:IsPlayer() then
			timerIronbark:Stop()
		end
	elseif spellId == 102342 then --Благословение защиты
		if args:IsPlayer() then
			timerBlessingofProtection:Stop()
		end
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	local sourceName = args.sourceName
	local destName = args.destName
	if not UnitInYourParty(sourceName) then return end
	typeInstance = select(2, IsInInstance())
	if spellId == 98008 then --Тотем духовной связи
		if typeInstance ~= "party" and typeInstance ~= "raid" then return end
		if DBM:GetNumRealGroupMembers() < 2 then return end
		warnSpiritLinkTotem:Show(sourceName)
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnRaidCooldown then
			prepareMessage(self, "premsg_Spells_spirittotem", spellId, sourceName)
		end
	elseif spellId == 207399 then --Тотем защиты Предков
		if typeInstance ~= "party" and typeInstance ~= "raid" then return end
		if DBM:GetNumRealGroupMembers() < 2 then return end
		if args:IsPlayerSource() then
			yellAncestralProtectionTotem:Yell(replaceSpellLinks(spellId))
		else
			warnAncestralProtectionTotem:Show(sourceName)
		end
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnRaidCooldown then
			prepareMessage(self, "premsg_Spells_ancprotectotem", spellId, sourceName)
		end
	end
end

function mod:SPELL_RESURRECT(args)
	local spellId = args.spellId
	local sourceName = args.sourceName
	local destName = args.destName
	if not UnitInYourParty(sourceName) then return end
	if spellId == 95750 then --Воскрешение камнем души
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnResurrect then
			prepareMessage(self, "premsg_Spells_rebirth3", spellId, sourceName, destName)
		end
		if args:IsPlayer() then
			specWarnRebirth:Show()
			specWarnRebirth:Play("targetyou")
			if not DBM.Options.IgnoreRaidAnnounce3 then
				smartChat(L.WhisperThanks:format(DbmRV, replaceSpellLinks(spellId)), "whisper", sourceName)
			end
		else
			warnRebirth:Show(sourceName, destName)
		end
	elseif spellId == 20484 then --Возрождение
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnResurrect then
			prepareMessage(self, "premsg_Spells_rebirth1", spellId, sourceName, destName)
		end
		if args:IsPlayer() then
			specWarnRebirth:Show()
			specWarnRebirth:Play("targetyou")
			if not DBM.Options.IgnoreRaidAnnounce3 then
				smartChat(L.WhisperThanks:format(DbmRV, replaceSpellLinks(spellId)), "whisper", sourceName)
			end
		else
			warnRebirth:Show(sourceName, destName)
		end
	elseif spellId == 61999 and self:AntiSpam(2.5, "rebirth") then --Воскрешение союзника
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnResurrect then
			prepareMessage(self, "premsg_Spells_rebirth2", spellId, sourceName, destName)
		end
		if args:IsPlayer() then
			specWarnRebirth:Show()
			specWarnRebirth:Play("targetyou")
			if not DBM.Options.IgnoreRaidAnnounce3 then
				smartChat(L.WhisperThanks:format(DbmRV, replaceSpellLinks(spellId)), "whisper", sourceName)
			end
		else
			warnRebirth:Show(sourceName, destName)
		end
	end
end

function mod:OnSync(premsg_announce, sender)
	if sender < playerOnlyName then
		announceList(premsg_announce, 0)
	end
end
