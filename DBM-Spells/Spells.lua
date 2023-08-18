local mod	= DBM:NewMod("Spells", "DBM-Spells")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)

mod:RegisterEvents(
	"SPELL_CAST_START 61994 212040 212056 212036 212048 212051 7720",
	"SPELL_CAST_SUCCESS 161399 157757 80353 32182 230935 90355 2825 160452 10059 11416 11419 32266 49360 11417 11418 11420 32267 49361 33691 53142 88345 88346 132620 132626 176246 176244 224871 29893 83958 21169 97462 205223 31821 15286 62618 47788 64901",
	"SPELL_AURA_APPLIED 20707 33206 116849 1022 29166 64901 102342",
	"SPELL_AURA_REMOVED 47788 29166 64901 197908 102342 1022 116849",
	"SPELL_SUMMON 67826 199109 199115 195782 98008 207399",
	"SPELL_CREATE 698 188036 201352 201351 185709 88304 61031 49844",
	"SPELL_RESURRECT 20484 95750 61999",
	"GOSSIP_SHOW"--[[,
	"UNIT_SPELLCAST_SUCCEEDED"]]
)

--Прошляпанное очко Мурчаля Прошляпенко на рейдовых спеллах [✔]
local warnMassres1					= mod:NewTargetSourceAnnounce(212040, 4) --Возвращение к жизни (друид)
local warnMassres2					= mod:NewTargetSourceAnnounce(212056, 4) --Отпущение (пал)
local warnMassres3					= mod:NewTargetSourceAnnounce(212036, 4) --Массовое воскрешение (прист)
local warnMassres4					= mod:NewTargetSourceAnnounce(212048, 4) --Древнее видение (шаман)
local warnMassres5					= mod:NewTargetSourceAnnounce(212051, 4) --Повторное пробуждение (монк)
--инженерия
local warnPylon						= mod:NewTargetSourceAnnounce(199115, 1) --Пилон
local warnJeeves					= mod:NewTargetSourceAnnounce(67826, 1) --Дживс
local warnAutoHammer				= mod:NewTargetSourceAnnounce(199109, 1) --Автоматический молот
--героизм
local warnTimeWarp					= mod:NewTargetSourceAnnounce(80353, 1) --Искажение времени
local warnHeroism					= mod:NewTargetSourceAnnounce(32182, 1) --Героизм
local warnBloodlust					= mod:NewTargetSourceAnnounce(2825, 1) --Кровожадность
local warnHysteria					= mod:NewTargetSourceAnnounce(90355, 1) --Древняя истерия
local warnNetherwinds				= mod:NewTargetSourceAnnounce(160452, 1) --Ветер пустоты
local warnDrums						= mod:NewTargetSourceAnnounce(230935, 1) --Барабаны гор

local warnRitualofSummoning			= mod:NewTargetSourceAnnounce(698, 1) --Ритуал призыва
local warnLavishSuramar				= mod:NewTargetSourceAnnounce(201352, 1) --Щедрое сурамарское угощение
local warnHearty					= mod:NewTargetSourceAnnounce(201351, 1) --Обильное угощение
local warnSugar						= mod:NewTargetSourceAnnounce(185709, 1) --Угощение из засахаренной рыбы
local warnCauldron					= mod:NewTargetSourceAnnounce(188036, 4) --Котел духов
local warnSoulstone					= mod:NewTargetAnnounce(20707, 1) --Камень души

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

local specWarnSoulstone				= mod:NewSpecialWarningYou(20707, nil, nil, nil, 1, 2) --Камень души

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
mod:AddBoolOption("YellOnMassRes", true) --масс рес
mod:AddBoolOption("YellOnHeroism", true) --героизм
mod:AddBoolOption("YellOnPortal", true) --порталы
mod:AddBoolOption("YellOnSoulwell", true)
mod:AddBoolOption("YellOnSoulstone", true)
mod:AddBoolOption("YellOnRitualofSummoning", true)
mod:AddBoolOption("YellOnSummoning", true)
mod:AddBoolOption("YellOnSpiritCauldron", true) --котел
mod:AddBoolOption("YellOnLavish", true)
mod:AddBoolOption("YellOnBank", true) --банк
mod:AddBoolOption("YellOnRepair", true) --починка
mod:AddBoolOption("YellOnPylon", true) --пилон
mod:AddBoolOption("YellOnToys", true) --игрушки

--[[Массрес
local massres1, massres2, massres3, massres4, massres5 = replaceSpellLinks(212040), replaceSpellLinks(212056), replaceSpellLinks(212036), replaceSpellLinks(212048), replaceSpellLinks(212051)
--Героизм
local timeWarp, heroism, bloodlust, hysteria, winds, drums = replaceSpellLinks(80353), replaceSpellLinks(32182), replaceSpellLinks(2825), replaceSpellLinks(90355), replaceSpellLinks(160452), replaceSpellLinks(230935)
--Порталы Альянса
local stormwind, ironforge, darnassus, exodar, theramore, tolBarad1, valeEternal1, stormshield = replaceSpellLinks(10059), replaceSpellLinks(11416), replaceSpellLinks(11419), replaceSpellLinks(32266), replaceSpellLinks(49360), replaceSpellLinks(88345), replaceSpellLinks(132620), replaceSpellLinks(176246)
--Порталы Орды
local orgrimmar, undercity, thunderBluff, silvermoon, stonard, tolBarad2, valeEternal2, warspear = replaceSpellLinks(11417), replaceSpellLinks(11418), replaceSpellLinks(11420), replaceSpellLinks(32267), replaceSpellLinks(49361), replaceSpellLinks(88346), replaceSpellLinks(132626), replaceSpellLinks(176244)
--Порталы общие
local shattrath, dalaran1, dalaran2 = replaceSpellLinks(33691), replaceSpellLinks(53142), replaceSpellLinks(224871)
--Спеллы лока
local soulwell, soulstone, summoning, summoning2 = replaceSpellLinks(29893), replaceSpellLinks(20707), replaceSpellLinks(698), replaceSpellLinks(7720)
--Котел духов
local cauldron = replaceSpellLinks(188036)
--Еда
local lavishSuramar, hearty, sugar = replaceSpellLinks(201352), replaceSpellLinks(201351), replaceSpellLinks(185709)
--Инженерия
local jeeves, autoHammer, pylon, swap = replaceSpellLinks(67826), replaceSpellLinks(199109), replaceSpellLinks(199115), replaceSpellLinks(161399)
--Мобильный банк
local bank = replaceSpellLinks(88306) --83958
--Игрушки
local toyTrain, moonfeather, highborne, discoball, direbrews = replaceSpellLinks(61031), replaceSpellLinks(195782), replaceSpellLinks(73331), replaceSpellLinks(50317), replaceSpellLinks(49844)
рейд кд
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
	-- spellId,
	-- sourceName,
	-- destName,
	-- localizedName,
	massres1_rw, massres2_rw, massres3_rw, massres4_rw, massres5_rw,
	timeWarp, heroism, bloodlust, hysteria, winds, drums,
	stormwind, ironforge, darnassus, exodar, theramore, tolBarad1, valeEternal1, stormshield,
	orgrimmar, undercity, thunderBluff, silvermoon, stonard, tolBarad2, valeEternal2, warspear,
	shattrath, dalaran1, dalaran2,
	soulwell, soulstone, summoning,
	cauldron_rw,
	lavishSuramar_rw, hearty, sugar,
	jeeves_rw, autoHammer_rw, pylon_rw, swap,
	bank,
	toyTrain, moonfeather, --[[highborne, discoball, ]]direbrews,
	rallyingcry, vampiricaura, auramastery, vampiricembrace, powerwordbarrier, guardianspirit, painsuppression, spirittotem, lifecocoon, blesofprot, ironbark, ancprotectotem,
	hope, innervate,
	rebirth1, rebirth2, rebirth3
}
local playerOnlyName = UnitName("player")

local function sendAnnounce(self, spellId, sourceName, destName)
	local localizedName = nil
	--[[if premsg_values.spellId == nil then
		premsg_values.localizedName = "Unknown"
	else
		premsg_values.localizedName = replaceSpellLinks(premsg_values.spellId)
	end
	if premsg_values.sourceName == nil then premsg_values.sourceName = "Unknown" end]]
	if destName == nil then destName = "Unknown" end
	if spellId == nil then
		localizedName = "Unknown"
	else
		localizedName = replaceSpellLinks(spellId)
	end

	if spellId == nil or sourceName == nil then
		DBM:Debug('problem in sendAnnounce function')
		DBM:Debug('spellId: ' .. tostring(spellId))
		DBM:Debug('sourceName: ' .. tostring(sourceName))
		DBM:Debug('destName: ' .. tostring(destName))

		--[[premsg_values.spellId = nil
		premsg_values.sourceName = nil
		premsg_values.destName = nil
		premsg_values.localizedName = nil]]

		return
	end

	--[[if premsg_values.test == 1 then
		smartChat("Тестовое сообщение.")
		smartChat("sourceName: " .. premsg_values.sourceName)
		smartChat("destName: " .. premsg_values.destName)
		premsg_values.test = 0
	else]]if premsg_values.massres1_rw == 1 then
		smartChat(L.HeroismYell:format(DbmRV, sourceName, localizedName), "rw")
		premsg_values.massres1_rw = 0
	elseif premsg_values.massres2_rw == 1 then
		smartChat(L.HeroismYell:format(DbmRV, sourceName, localizedName), "rw")
		premsg_values.massres2_rw = 0
	elseif premsg_values.massres3_rw == 1 then
		smartChat(L.HeroismYell:format(DbmRV, sourceName, localizedName), "rw")
		premsg_values.massres3_rw = 0
	elseif premsg_values.massres4_rw == 1 then
		smartChat(L.HeroismYell:format(DbmRV, sourceName, localizedName), "rw")
		premsg_values.massres4_rw = 0
	elseif premsg_values.massres5_rw == 1 then
		smartChat(L.HeroismYell:format(DbmRV, sourceName, localizedName), "rw")
		premsg_values.massres5_rw = 0
	elseif premsg_values.timeWarp == 1 then
		smartChat(L.HeroismYell:format(DbmRV, sourceName, localizedName))
		premsg_values.timeWarp = 0
	elseif premsg_values.heroism == 1 then
		smartChat(L.HeroismYell:format(DbmRV, sourceName, localizedName))
		premsg_values.heroism = 0
	elseif premsg_values.bloodlust == 1 then
		smartChat(L.HeroismYell:format(DbmRV, sourceName, localizedName))
		premsg_values.bloodlust = 0
	elseif premsg_values.hysteria == 1 then
		smartChat(L.HeroismYell:format(DbmRV, sourceName, localizedName))
		premsg_values.hysteria = 0
	elseif premsg_values.winds == 1 then
		smartChat(L.HeroismYell:format(DbmRV, sourceName, localizedName))
		premsg_values.winds = 0
	elseif premsg_values.drums == 1 then
		smartChat(L.HeroismYell:format(DbmRV, sourceName, localizedName))
		premsg_values.drums = 0
	elseif premsg_values.stormwind == 1 then
		smartChat(L.PortalYell:format(DbmRV, sourceName, localizedName))
		premsg_values.stormwind = 0
	elseif premsg_values.ironforge == 1 then
		smartChat(L.PortalYell:format(DbmRV, sourceName, localizedName))
		premsg_values.ironforge = 0
	elseif premsg_values.darnassus == 1 then
		smartChat(L.PortalYell:format(DbmRV, sourceName, localizedName))
		premsg_values.darnassus = 0
	elseif premsg_values.exodar == 1 then
		smartChat(L.PortalYell:format(DbmRV, sourceName, localizedName))
		premsg_values.exodar = 0
	elseif premsg_values.theramore == 1 then
		smartChat(L.PortalYell:format(DbmRV, sourceName, localizedName))
		premsg_values.theramore = 0
	elseif premsg_values.tolBarad1 == 1 then
		smartChat(L.PortalYell:format(DbmRV, sourceName, localizedName))
		premsg_values.tolBarad1 = 0
	elseif premsg_values.valeEternal1 == 1 then
		smartChat(L.PortalYell:format(DbmRV, sourceName, localizedName))
		premsg_values.valeEternal1 = 0
	elseif premsg_values.stormshield == 1 then
		smartChat(L.PortalYell:format(DbmRV, sourceName, localizedName))
		premsg_values.stormshield = 0
	elseif premsg_values.orgrimmar == 1 then
		smartChat(L.PortalYell:format(DbmRV, sourceName, localizedName))
		premsg_values.orgrimmar = 0
	elseif premsg_values.undercity == 1 then
		smartChat(L.PortalYell:format(DbmRV, sourceName, localizedName))
		premsg_values.undercity = 0
	elseif premsg_values.thunderBluff == 1 then
		smartChat(L.PortalYell:format(DbmRV, sourceName, localizedName))
		premsg_values.thunderBluff = 0
	elseif premsg_values.silvermoon == 1 then
		smartChat(L.PortalYell:format(DbmRV, sourceName, localizedName))
		premsg_values.silvermoon = 0
	elseif premsg_values.stonard == 1 then
		smartChat(L.PortalYell:format(DbmRV, sourceName, localizedName))
		premsg_values.stonard = 0
	elseif premsg_values.tolBarad2 == 1 then
		smartChat(L.PortalYell:format(DbmRV, sourceName, localizedName))
		premsg_values.tolBarad2 = 0
	elseif premsg_values.valeEternal2 == 1 then
		smartChat(L.PortalYell:format(DbmRV, sourceName, localizedName))
		premsg_values.valeEternal2 = 0
	elseif premsg_values.warspear == 1 then
		smartChat(L.PortalYell:format(DbmRV, sourceName, localizedName))
		premsg_values.warspear = 0
	elseif premsg_values.shattrath == 1 then
		smartChat(L.PortalYell:format(DbmRV, sourceName, localizedName))
		premsg_values.shattrath = 0
	elseif premsg_values.dalaran1 == 1 then
		smartChat(L.PortalYell:format(DbmRV, sourceName, localizedName))
		premsg_values.dalaran1 = 0
	elseif premsg_values.dalaran2 == 1 then
		smartChat(L.PortalYell:format(DbmRV, sourceName, localizedName))
		premsg_values.dalaran2 = 0
	elseif premsg_values.soulwell == 1 then
		smartChat(L.HeroismYell:format(DbmRV, sourceName, localizedName))
		premsg_values.soulwell = 0
	elseif premsg_values.soulstone == 1 then
		smartChat(L.SoulstoneYell:format(DbmRV, sourceName, localizedName, destName))
		premsg_values.soulstone = 0
	elseif premsg_values.summoning == 1 then
		smartChat(L.SummoningYell:format(DbmRV, sourceName, localizedName))
		premsg_values.summoning = 0
	elseif premsg_values.cauldron_rw == 1 then
		smartChat(L.SoulwellYell:format(DbmRV, sourceName, localizedName))
		premsg_values.cauldron_rw = 0
	elseif premsg_values.lavishSuramar_rw == 1 then
		smartChat(L.SoulwellYell:format(DbmRV, sourceName, localizedName))
		premsg_values.lavishSuramar_rw = 0
	elseif premsg_values.hearty == 1 then
		smartChat(L.SoulwellYell:format(DbmRV, sourceName, localizedName))
		premsg_values.hearty = 0
	elseif premsg_values.sugar == 1 then
		smartChat(L.SoulwellYell:format(DbmRV, sourceName, localizedName))
		premsg_values.sugar = 0
	elseif premsg_values.jeeves_rw == 1 then
		smartChat(L.SoulwellYell:format(DbmRV, sourceName, localizedName))
		premsg_values.jeeves_rw = 0
	elseif premsg_values.autoHammer_rw == 1 then
		smartChat(L.SoulwellYell:format(DbmRV, sourceName, localizedName))
		premsg_values.autoHammer_rw = 0
	elseif premsg_values.pylon_rw == 1 then
		smartChat(L.SoulwellYell:format(DbmRV, sourceName, localizedName))
		premsg_values.pylon_rw = 0
	elseif premsg_values.swap == 1 then
		smartChat(L.SoulstoneYell:format(DbmRV, sourceName, localizedName, destName))
		premsg_values.swap = 0
	elseif premsg_values.bank == 1 then
		smartChat(L.SoulwellYell:format(DbmRV, sourceName, localizedName))
		premsg_values.bank = 0
	elseif premsg_values.toyTrain == 1 then
		smartChat(L.SoulwellYell:format(DbmRV, sourceName, localizedName))
		premsg_values.toyTrain = 0
	elseif premsg_values.moonfeather == 1 then
		smartChat(L.HeroismYell:format(DbmRV, sourceName, localizedName))
		premsg_values.moonfeather = 0
	--[[elseif premsg_values.highborne == 1 then
	
		premsg_values.highborne = 0
	elseif premsg_values.discoball == 1 then
	
		premsg_values.discoball = 0]]
	elseif premsg_values.direbrews == 1 then
		smartChat(L.SummoningYell:format(DbmRV, sourceName, localizedName))
		premsg_values.direbrews = 0
	elseif premsg_values.rallyingcry == 1 then --Ободряющий клич
		smartChat(L.HeroismYell:format(DbmRV, sourceName, localizedName))
		premsg_values.rallyingcry = 0
	elseif premsg_values.vampiricaura == 1 then --Вампирская аура
		smartChat(L.HeroismYell:format(DbmRV, sourceName, localizedName))
		premsg_values.vampiricaura = 0
	elseif premsg_values.auramastery == 1 then --Владение аурами
		smartChat(L.HeroismYell:format(DbmRV, sourceName, localizedName))
		premsg_values.auramastery = 0
	elseif premsg_values.vampiricembrace == 1 then --Объятия вампира
		smartChat(L.HeroismYell:format(DbmRV, sourceName, localizedName))
		premsg_values.vampiricembrace = 0
	elseif premsg_values.powerwordbarrier == 1 then --Слово силы: Барьер
		smartChat(L.HeroismYell:format(DbmRV, sourceName, localizedName))
		premsg_values.powerwordbarrier = 0
	elseif premsg_values.guardianspirit == 1 then --Оберегающий дух
		smartChat(L.SoulstoneYell:format(DbmRV, sourceName, localizedName, destName))
		premsg_values.guardianspirit = 0
	elseif premsg_values.painsuppression == 1 then --Подавление боли
		smartChat(L.SoulstoneYell:format(DbmRV, sourceName, localizedName, destName))
		premsg_values.painsuppression = 0
	elseif premsg_values.spirittotem == 1 then --Тотем духовной связи
		smartChat(L.HeroismYell:format(DbmRV, sourceName, localizedName))
		premsg_values.spirittotem = 0
	elseif premsg_values.lifecocoon == 1 then --Исцеляющий кокон
		smartChat(L.SoulstoneYell:format(DbmRV, sourceName, localizedName, destName))
		premsg_values.lifecocoon = 0
	elseif premsg_values.blesofprot == 1 then --Благословение защиты
		smartChat(L.SoulstoneYell:format(DbmRV, sourceName, localizedName, destName))
		premsg_values.blesofprot = 0
	elseif premsg_values.ironbark == 1 then --Железная кора
		smartChat(L.SoulstoneYell:format(DbmRV, sourceName, localizedName, destName))
		premsg_values.ironbark = 0
	elseif premsg_values.ancprotectotem == 1 then --Тотем защиты Предков
		smartChat(L.HeroismYell:format(DbmRV, sourceName, localizedName))
		premsg_values.ancprotectotem = 0
	elseif premsg_values.hope == 1 then --Символ надежды
		smartChat(L.HeroismYell:format(DbmRV, sourceName, localizedName))
		premsg_values.hope = 0
	elseif premsg_values.innervate == 1 then --Озарение
		smartChat(L.SoulstoneYell:format(DbmRV, sourceName, localizedName, destName))
		premsg_values.innervate = 0
	elseif premsg_values.rebirth1 == 1 then --Возрождение
		smartChat(L.SoulstoneYell:format(DbmRV, sourceName, localizedName, destName))
		premsg_values.rebirth1 = 0
	elseif premsg_values.rebirth2 == 1 then --Воскрешение союзника
		smartChat(L.SoulstoneYell:format(DbmRV, sourceName, localizedName, destName))
		premsg_values.rebirth2 = 0
	elseif premsg_values.rebirth3 == 1 then --Воскрешение камнем души
		smartChat(L.SoulstoneYell:format(DbmRV, sourceName, localizedName, destName))
		premsg_values.rebirth3 = 0
	end	

	--[[premsg_values.spellId = nil
	premsg_values.sourceName = nil
	premsg_values.destName = nil
	premsg_values.localizedName = nil]]
end

local function announceList(premsg_announce, value)
	--[[if premsg_announce == "premsg_Spells_test" then
		premsg_values.test = value
	else]]if premsg_announce == "premsg_Spells_massres1_rw" then
		premsg_values.massres1_rw = value
	elseif premsg_announce == "premsg_Spells_massres2_rw" then
		premsg_values.massres2_rw = value
	elseif premsg_announce == "premsg_Spells_massres3_rw" then
		premsg_values.massres3_rw = value
	elseif premsg_announce == "premsg_Spells_massres4_rw" then
		premsg_values.massres4_rw = value
	elseif premsg_announce == "premsg_Spells_massres5_rw" then
		premsg_values.massres5_rw = value
	elseif premsg_announce == "premsg_Spells_timeWarp" then
		premsg_values.timeWarp = value
	elseif premsg_announce == "premsg_Spells_heroism" then
		premsg_values.heroism = value
	elseif premsg_announce == "premsg_Spells_bloodlust" then
		premsg_values.bloodlust = value
	elseif premsg_announce == "premsg_Spells_hysteria" then
		premsg_values.hysteria = value
	elseif premsg_announce == "premsg_Spells_winds" then
		premsg_values.winds = value
	elseif premsg_announce == "premsg_Spells_drums" then
		premsg_values.drums = value
	elseif premsg_announce == "premsg_Spells_stormwind" then
		premsg_values.stormwind = value
	elseif premsg_announce == "premsg_Spells_ironforge" then
		premsg_values.ironforge = value
	elseif premsg_announce == "premsg_Spells_darnassus" then
		premsg_values.darnassus = value
	elseif premsg_announce == "premsg_Spells_exodar" then
		premsg_values.exodar = value
	elseif premsg_announce == "premsg_Spells_theramore" then
		premsg_values.theramore = value
	elseif premsg_announce == "premsg_Spells_tolBarad1" then
		premsg_values.tolBarad1 = value
	elseif premsg_announce == "premsg_Spells_valeEternal1" then
		premsg_values.valeEternal1 = value
	elseif premsg_announce == "premsg_Spells_stormshield" then
		premsg_values.stormshield = value
	elseif premsg_announce == "premsg_Spells_orgrimmar" then
		premsg_values.orgrimmar = value
	elseif premsg_announce == "premsg_Spells_undercity" then
		premsg_values.undercity = value
	elseif premsg_announce == "premsg_Spells_thunderBluff" then
		premsg_values.thunderBluff = value
	elseif premsg_announce == "premsg_Spells_silvermoon" then
		premsg_values.silvermoon = value
	elseif premsg_announce == "premsg_Spells_stonard" then
		premsg_values.stonard = value
	elseif premsg_announce == "premsg_Spells_tolBarad2" then
		premsg_values.tolBarad2 = value
	elseif premsg_announce == "premsg_Spells_valeEternal2" then
		premsg_values.valeEternal2 = value
	elseif premsg_announce == "premsg_Spells_warspear" then
		premsg_values.warspear = value
	elseif premsg_announce == "premsg_Spells_shattrath" then
		premsg_values.shattrath = value
	elseif premsg_announce == "premsg_Spells_dalaran1" then
		premsg_values.dalaran1 = value
	elseif premsg_announce == "premsg_Spells_dalaran2" then
		premsg_values.dalaran2 = value
	elseif premsg_announce == "premsg_Spells_soulwell" then
		premsg_values.soulwell = value
	elseif premsg_announce == "premsg_Spells_soulstone" then
		premsg_values.soulstone = value
	elseif premsg_announce == "premsg_Spells_summoning" then
		premsg_values.summoning = value
	elseif premsg_announce == "premsg_Spells_cauldron_rw" then
		premsg_values.cauldron_rw = value
	elseif premsg_announce == "premsg_Spells_lavishSuramar_rw" then
		premsg_values.lavishSuramar_rw = value
	elseif premsg_announce == "premsg_Spells_hearty" then
		premsg_values.hearty = value
	elseif premsg_announce == "premsg_Spells_sugar" then
		premsg_values.sugar = value
	elseif premsg_announce == "premsg_Spells_jeeves_rw" then
		premsg_values.jeeves_rw = value
	elseif premsg_announce == "premsg_Spells_autoHammer_rw" then
		premsg_values.autoHammer_rw = value
	elseif premsg_announce == "premsg_Spells_pylon_rw" then
		premsg_values.pylon_rw = value
	elseif premsg_announce == "premsg_Spells_swap" then
		premsg_values.swap = value
	elseif premsg_announce == "premsg_Spells_bank" then
		premsg_values.bank = value
	elseif premsg_announce == "premsg_Spells_toyTrain" then
		premsg_values.toyTrain = value
	elseif premsg_announce == "premsg_Spells_moonfeather" then
		premsg_values.moonfeather = value
	--[[elseif premsg_announce == "premsg_Spells_highborne" then
		premsg_values.highborne = value
	elseif premsg_announce == "premsg_Spells_discoball" then
		premsg_values.discoball = value]]
	elseif premsg_announce == "premsg_Spells_direbrews" then
		premsg_values.direbrews = value
	elseif premsg_announce == "premsg_Spells_rallyingcry" then --Ободряющий клич
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
		--[[premsg_values.spellId = spellId
		premsg_values.sourceName = sourceName
		premsg_values.destName = destName]]

		if spellId == nil or sourceName == nil then
			DBM:Debug('problem in prepareMessage function')
			DBM:Debug('spellId: ' .. tostring(spellId))
			DBM:Debug('sourceName: ' .. tostring(sourceName))
			DBM:Debug('destName: ' .. tostring(destName))
	
			--[[premsg_values.spellId = nil
			premsg_values.sourceName = nil
			premsg_values.destName = nil]]
	
			return
		end

		announceList(premsg_announce, 1)
		self:SendSync(premsg_announce, playerOnlyName)
		self:Schedule(1, sendAnnounce, self, spellId, sourceName, destName)
	end
end
-- Синхронизация анонсов ↑

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	local sourceName = args.sourceName
	local destName = args.destName
	if not UnitInYourParty(sourceName) then return end
	if spellId == 212040 and self:AntiSpam(15, "massres") then --Возвращение к жизни (друид)
		warnMassres1:Show(sourceName)
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnMassRes then
			prepareMessage(self, "premsg_Spells_massres1_rw", spellId, sourceName)
		end
	elseif spellId == 212056 and self:AntiSpam(15, "massres") then --Отпущение (пал)
		warnMassres2:Show(sourceName)
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnMassRes then
			prepareMessage(self, "premsg_Spells_massres2_rw", spellId, sourceName)
		end
	elseif spellId == 212036 and self:AntiSpam(15, "massres") then --Массовое воскрешение (прист)
		warnMassres3:Show(sourceName)
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnMassRes then
			prepareMessage(self, "premsg_Spells_massres3_rw", spellId, sourceName)
		end
	elseif spellId == 212048 and self:AntiSpam(15, "massres") then --Древнее видение (шаман)
		warnMassres4:Show(sourceName)
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnMassRes then
			prepareMessage(self, "premsg_Spells_massres4_rw", spellId, sourceName)
		end
	elseif spellId == 212051 and self:AntiSpam(15, "massres") then --Повторное пробуждение (монк)
		warnMassres5:Show(sourceName)
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnMassRes then
			prepareMessage(self, "premsg_Spells_massres5_rw", spellId, sourceName)
		end
	elseif spellId == 7720 then --Ритуал призыва
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnSummoning then
			if args:IsPlayerSource() then
				smartChat(L.SummonYell:format(DbmRV, sourceName, replaceSpellLinks(spellId), UnitName("target")))
			end
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	local sourceName = args.sourceName
	local destName = args.destName
	if not UnitInYourParty(sourceName) then return end
	typeInstance = select(2, IsInInstance())
	if spellId == 80353 then --Искажение времени
		if self:AntiSpam(5, "bloodlust") then
			warnTimeWarp:Show(sourceName)
		end
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnHeroism then
			prepareMessage(self, "premsg_Spells_timeWarp", spellId, sourceName)
		end
	elseif spellId == 32182 then --Героизм
		if self:AntiSpam(5, "bloodlust") then
			warnHeroism:Show(sourceName)
		end
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnHeroism then
			prepareMessage(self, "premsg_Spells_heroism", spellId, sourceName)
		end
	elseif spellId == 2825 then --Кровожадность
		if self:AntiSpam(5, "bloodlust") then
			warnBloodlust:Show(sourceName)
		end
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnHeroism then
			prepareMessage(self, "premsg_Spells_bloodlust", spellId, sourceName)
		end
	elseif spellId == 90355 then --Древняя истерия (пет ханта)
		if self:AntiSpam(5, "bloodlust") then
			warnHysteria:Show(sourceName)
		end
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnHeroism then
			prepareMessage(self, "premsg_Spells_hysteria", spellId, sourceName)
		end
	elseif spellId == 160452 then --Ветер пустоты (пет ханта)
		if self:AntiSpam(5, "bloodlust") then
			warnNetherwinds:Show(sourceName)
		end
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnHeroism then
			prepareMessage(self, "premsg_Spells_winds", spellId, sourceName)
		end
	elseif spellId == 230935 then --Барабаны гор
		if self:AntiSpam(5, "bloodlust") then
			warnDrums:Show(sourceName)
		end
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnHeroism then
			prepareMessage(self, "premsg_Spells_drums", spellId, sourceName)
		end
	elseif spellId == 10059 then --Штормград
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnPortal then
			prepareMessage(self, "premsg_Spells_stormwind", spellId, sourceName)
		end
	elseif spellId == 11416 then --Стальгорн
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnPortal then
			prepareMessage(self, "premsg_Spells_ironforge", spellId, sourceName)
		end
	elseif spellId == 11419 then --Дарнас
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnPortal then
			prepareMessage(self, "premsg_Spells_darnassus", spellId, sourceName)
		end
	elseif spellId == 32266 then --Экзодар
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnPortal then
			prepareMessage(self, "premsg_Spells_exodar", spellId, sourceName)
		end
	elseif spellId == 49360 then --Терамор
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnPortal then
			prepareMessage(self, "premsg_Spells_theramore", spellId, sourceName)
		end
	elseif spellId == 11417 then --Оргриммар
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnPortal then
			prepareMessage(self, "premsg_Spells_orgrimmar", spellId, sourceName)
		end
	elseif spellId == 11418 then --Подгород
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnPortal then
			prepareMessage(self, "premsg_Spells_undercity", spellId, sourceName)
		end
	elseif spellId == 11420 then --Громовой утес
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnPortal then
			prepareMessage(self, "premsg_Spells_thunderBluff", spellId, sourceName)
		end
	elseif spellId == 32267 then --Луносвет
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnPortal then
			prepareMessage(self, "premsg_Spells_silvermoon", spellId, sourceName)
		end
	elseif spellId == 49361 then --Каменор
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnPortal then
			prepareMessage(self, "premsg_Spells_stonard", spellId, sourceName)
		end
	elseif spellId == 33691 then --Шаттрат
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnPortal then
			prepareMessage(self, "premsg_Spells_shattrath", spellId, sourceName)
		end
	elseif spellId == 53142 then --Даларан1
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnPortal then
			prepareMessage(self, "premsg_Spells_dalaran1", spellId, sourceName)
		end
	elseif spellId == 88345 then --Тол Барад (альянс)
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnPortal then
			prepareMessage(self, "premsg_Spells_tolBarad1", spellId, sourceName)
		end
	elseif spellId == 88346 then --Тол Барад (орда)
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnPortal then
			prepareMessage(self, "premsg_Spells_tolBarad2", spellId, sourceName)
		end
	elseif spellId == 132620 then --Вечноцветущий дол (альянс)
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnPortal then
			prepareMessage(self, "premsg_Spells_valeEternal1", spellId, sourceName)
		end
	elseif spellId == 132626 then --Вечноцветущий дол (орда)
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnPortal then
			prepareMessage(self, "premsg_Spells_valeEternal2", spellId, sourceName)
		end
	elseif spellId == 176246 then --Преграда Ветров (альянс)
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnPortal then
			prepareMessage(self, "premsg_Spells_stormshield", spellId, sourceName)
		end
	elseif spellId == 176244 then --Копье Войны (орда)
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnPortal then
			prepareMessage(self, "premsg_Spells_warspear", spellId, sourceName)
		end
	elseif spellId == 224871 then --Даларан2
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnPortal then
			prepareMessage(self, "premsg_Spells_dalaran2", spellId, sourceName)
		end
	elseif spellId == 29893 and self:AntiSpam(10, "soulwell") then --Источник душ
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnSoulwell then
			prepareMessage(self, "premsg_Spells_soulwell", spellId, sourceName)
		end
	elseif spellId == 83958 and self:AntiSpam(5, "bank") then --Мобильный банк
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnBank then
			prepareMessage(self, "premsg_Spells_bank", spellId, sourceName)
		end
	elseif spellId == 161399 then --Поменяться местами
		if typeInstance ~= "party" and typeInstance ~= "raid" then return end
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnToys then
			prepareMessage(self, "premsg_Spells_swap", spellId, sourceName, destName)
		end
	elseif spellId == 64901 then --Символ надежды
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
			yellVampiricAura:Yell(replaceSpellLinks(238698))
		else
			warnVampiricAura:Show(sourceName)
		end
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnRaidCooldown then
			prepareMessage(self, "premsg_Spells_vampiricaura", 238698, sourceName)
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
	if spellId == 20707 then --Камень души
		if typeInstance ~= "party" and typeInstance ~= "raid" then return end
		if DBM:GetNumRealGroupMembers() < 2 then return end
		if args:IsPlayer() then
			specWarnSoulstone:Show()
			specWarnSoulstone:Play("targetyou")
			if not args:IsPlayerSource() and not DBM.Options.IgnoreRaidAnnounce3 then
				smartChat(L.WhisperThanks:format(DbmRV, replaceSpellLinks(spellId)), "whisper", sourceName)
			end
		else
			warnSoulstone:Show(destName)
		end
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnSoulstone then
			prepareMessage(self, "premsg_Spells_soulstone", spellId, sourceName, destName)
		end
	elseif spellId == 29166 then --Озарение
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
	elseif spellId == 1022 then --Благословение защиты
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
	elseif spellId == 1022 then --Благословение защиты
		if args:IsPlayer() then
			timerBlessingofProtection:Stop()
		end
	end
end

function mod:SPELL_CREATE(args)
	local spellId = args.spellId
	local sourceName = args.sourceName
	local destName = args.destName
	if not UnitInYourParty(sourceName) then return end
	if spellId == 698 and self:AntiSpam(10, "summoning") then --Ритуал призыва
		warnRitualofSummoning:Show(sourceName)
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnRitualofSummoning then
			prepareMessage(self, "premsg_Spells_summoning", spellId, sourceName)
		end
	elseif spellId == 188036 and self:AntiSpam(10, "cauldron") then --Котел духов
		warnCauldron:Show(sourceName)
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnSpiritCauldron then
			prepareMessage(self, "premsg_Spells_cauldron_rw", spellId, sourceName)
		end
	elseif spellId == 201352 and self:AntiSpam(10, "lavishSuramar") then --Щедрое сурамарское угощение
		warnLavishSuramar:Show(sourceName)
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnLavish then
			prepareMessage(self, "premsg_Spells_lavishSuramar_rw", spellId, sourceName)
		end
	elseif spellId == 201351 and self:AntiSpam(10, "hearty") then --Обильное угощение
		warnHearty:Show(sourceName)
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnLavish then
			prepareMessage(self, "premsg_Spells_hearty", spellId, sourceName)
		end
	elseif spellId == 185709 and self:AntiSpam(10, "sugar") then --Угощение из засахаренной рыбы
		warnSugar:Show(sourceName)
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnLavish then
			prepareMessage(self, "premsg_Spells_sugar", spellId, sourceName)
		end
	elseif spellId == 61031 and self:AntiSpam(10, "toyTrain") then --Игрушечная железная дорога
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnToys then
			prepareMessage(self, "premsg_Spells_toyTrain", spellId, sourceName)
		end
	elseif spellId == 49844 and self:AntiSpam(10, "direbrews") then --пульт управления Худовара
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnToys then
			prepareMessage(self, "premsg_Spells_direbrews", spellId, sourceName)
		end
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	local sourceName = args.sourceName
	local destName = args.destName
	if not UnitInYourParty(sourceName) then return end
	typeInstance = select(2, IsInInstance())
	if spellId == 67826 and self:AntiSpam(10, "jeeves") then --Дживс
		warnJeeves:Show(sourceName)
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnRepair then
			prepareMessage(self, "premsg_Spells_jeeves_rw", spellId, sourceName)
		end
	elseif spellId == 199109 and self:AntiSpam(10, "hammer") then --Автоматический молот
		warnAutoHammer:Show(sourceName)
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnRepair then
			prepareMessage(self, "premsg_Spells_autoHammer_rw", spellId, sourceName)
		end
	elseif spellId == 199115 and self:AntiSpam(10, "pylon") then --Пилон для обнаружения проблем
		warnPylon:Show(sourceName)
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnPylon then
			prepareMessage(self, "premsg_Spells_pylon_rw", spellId, sourceName)
		end
	elseif spellId == 195782 and self:AntiSpam(5, "moonfeather") then --Призыв статуи лунного совуха
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnToys then
			prepareMessage(self, "premsg_Spells_moonfeather", spellId, sourceName)
		end
	elseif spellId == 98008 then --Тотем духовной связи
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

function mod:GOSSIP_SHOW()
	local guid = UnitGUID("npc")
	if not guid then return end
	local cid = self:GetCIDFromGUID(guid)
	if cid == 113455 or cid == 113457 or cid == 109409 then -- Жалкие ночнорождённые
		if select('#', GetGossipOptions()) > 0 then
			SelectGossipOption(1, "", true)
		end
	end
end
--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 73331 and self:AntiSpam(5, 11) then --Плач высокорожденных
		if self.Options.YellOnToys then
			if IsInRaid() then
				SendChatMessage(L.HeroismYell:format(DbmRV, args.sourceName, highborne), "RAID")
			elseif IsInGroup() then
				SendChatMessage(L.HeroismYell:format(DbmRV, args.sourceName, highborne), "PARTY")
			end
		end
	elseif spellId == 50317 and self:AntiSpam(5, 11) then --Вызов диско-шара
		if self.Options.YellOnToys then
			if IsInRaid() then
				SendChatMessage(L.HeroismYell:format(DbmRV, args.sourceName, discoball), "RAID")
			elseif IsInGroup() then
				SendChatMessage(L.HeroismYell:format(DbmRV, args.sourceName, discoball), "PARTY")
			end
		end
	elseif spellId == 774 then --Вызов диско-шара
		if self.Options.YellOnToys then
			if IsInRaid() then
				SendChatMessage(L.HeroismYell:format(DbmRV, UnitName(uId), discoball), "RAID")
			elseif IsInGroup() then
				SendChatMessage(L.HeroismYell:format(DbmRV, UnitName(uId), discoball), "PARTY")
			end
		end
	elseif spellId == 131347 then --Вызов диско-шара
		if self.Options.YellOnToys then
			if IsInRaid() then
				SendChatMessage(L.HeroismYell:format(DbmRV, UnitName(uId), discoball), "RAID")
			elseif IsInGroup() then
				SendChatMessage(L.HeroismYell:format(DbmRV, UnitName(uId), discoball), "PARTY")
			end
		end
	226241 --Кодекс безмятежного разума
	end
end]]

function mod:OnSync(premsg_announce, sender)
	if sender < playerOnlyName then
		announceList(premsg_announce, 0)
	end
end
