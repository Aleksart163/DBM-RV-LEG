local mod	= DBM:NewMod("Spells", "DBM-Spells")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)

mod:RegisterEvents(
	"SPELL_CAST_START 61994 212040 212056 212036 212048 212051 7720",
	"SPELL_CAST_SUCCESS 161399 157757 80353 32182 230935 90355 2825 160452 10059 11416 11419 32266 49360 11417 11418 11420 32267 49361 33691 53142 88345 88346 132620 132626 176246 176244 224871 29893 83958 21169 97462 205223 31821 15286 62618 47788 64901",
	"SPELL_AURA_APPLIED 20707 33206 116849 1022 29166 64901 102342 238698",
	"SPELL_AURA_REMOVED 47788 29166 64901 197908 102342 1022 116849 238698",
	"SPELL_SUMMON 67826 199109 199115 195782 98008 207399",
	"SPELL_CREATE 698 188036 201352 201351 185709 88304 61031 49844",
	"SPELL_RESURRECT 20484 95750 61999",
	"PLAYER_DEAD",
	"GOSSIP_SHOW"--[[,
	"UNIT_SPELLCAST_SUCCEEDED"]]
)

--Прошляпанное очко Мурчаля Прошляпенко на рейдовых спеллах [✔]
local warnMassres1					= mod:NewTargetSourceAnnounce(212040, 3) --Возвращение к жизни (друид)
local warnMassres2					= mod:NewTargetSourceAnnounce(212056, 3) --Отпущение (пал)
local warnMassres3					= mod:NewTargetSourceAnnounce(212036, 3) --Массовое воскрешение (прист)
local warnMassres4					= mod:NewTargetSourceAnnounce(212048, 3) --Древнее видение (шаман)
local warnMassres5					= mod:NewTargetSourceAnnounce(212051, 3) --Повторное пробуждение (монк)
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
local warnInnervate					= mod:NewTargetSourceAnnounce2(29166, 1, nil, "Healer") --Озарение
local warnSymbolHope				= mod:NewTargetSourceAnnounce(64901, 1, nil, "Healer") --Символ надежды

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
local timerSymbolHope				= mod:NewBuffActiveTimer(12, 64901, nil, nil, nil, 7) --Символ надежды

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
mod:AddBoolOption("AutoSpirit", true)

local typeInstance = nil

local function UnitInYourParty(sourceName)
	if GetNumGroupMembers() > 0 and (UnitInParty(sourceName) or UnitPlayerOrPetInParty(sourceName) or UnitInRaid(sourceName) or UnitInBattleground(sourceName)) then
		return true
	end
	return false
end

-- Синхронизация анонсов ↓
local premsg_values = {
	-- ["premsg_Spells_test"] = {0, L.HeroismYell}, -- test (Needs to be commented out before release) 8690
	-- ["premsg_Spells_test2"] = {0, L.HeroismYell}, -- test2 (Needs to be commented out before release) 222695
	["premsg_Spells_massres1_rw"] = {0, L.HeroismYell, nil, "rw"},
	["premsg_Spells_massres2_rw"] = {0, L.HeroismYell, nil, "rw"},
	["premsg_Spells_massres3_rw"] = {0, L.HeroismYell, nil, "rw"},
	["premsg_Spells_massres4_rw"] = {0, L.HeroismYell, nil, "rw"},
	["premsg_Spells_massres5_rw"] = {0, L.HeroismYell, nil, "rw"},
	["premsg_Spells_timeWarp"] = {0, L.HeroismYell},
	["premsg_Spells_heroism"] = {0, L.HeroismYell},
	["premsg_Spells_bloodlust"] = {0, L.HeroismYell},
	["premsg_Spells_hysteria"] = {0, L.HeroismYell},
	["premsg_Spells_winds"] = {0, L.HeroismYell},
	["premsg_Spells_drums"] = {0, L.HeroismYell},
	["premsg_Spells_stormwind"] = {0, L.PortalYell},
	["premsg_Spells_ironforge"] = {0, L.PortalYell},
	["premsg_Spells_darnassus"] = {0, L.PortalYell},
	["premsg_Spells_exodar"] = {0, L.PortalYell},
	["premsg_Spells_theramore"] = {0, L.PortalYell},
	["premsg_Spells_tolBarad1"] = {0, L.PortalYell},
	["premsg_Spells_valeEternal1"] = {0, L.PortalYell},
	["premsg_Spells_stormshield"] = {0, L.PortalYell},
	["premsg_Spells_orgrimmar"] = {0, L.PortalYell},
	["premsg_Spells_undercity"] = {0, L.PortalYell},
	["premsg_Spells_thunderBluff"] = {0, L.PortalYell},
	["premsg_Spells_silvermoon"] = {0, L.PortalYell},
	["premsg_Spells_stonard"] = {0, L.PortalYell},
	["premsg_Spells_tolBarad2"] = {0, L.PortalYell},
	["premsg_Spells_valeEternal2"] = {0, L.PortalYell},
	["premsg_Spells_warspear"] = {0, L.PortalYell},
	["premsg_Spells_shattrath"] = {0, L.PortalYell},
	["premsg_Spells_dalaran1"] = {0, L.PortalYell},
	["premsg_Spells_dalaran2"] = {0, L.PortalYell},
	["premsg_Spells_soulwell"] = {0, L.HeroismYell},
	["premsg_Spells_soulstone"] = {0, L.SoulstoneYell, true},
	["premsg_Spells_summoning"] = {0, L.SummoningYell},
	["premsg_Spells_cauldron_rw"] = {0, L.SoulwellYell},
	["premsg_Spells_lavishSuramar_rw"] = {0, L.SoulwellYell},
	["premsg_Spells_hearty"] = {0, L.SoulwellYell},
	["premsg_Spells_sugar"] = {0, L.SoulwellYell},
	["premsg_Spells_jeeves_rw"] = {0, L.SoulwellYell},
	["premsg_Spells_autoHammer_rw"] = {0, L.SoulwellYell},
	["premsg_Spells_pylon_rw"] = {0, L.SoulwellYell},
	["premsg_Spells_swap"] = {0, L.SoulstoneYell, true},
	["premsg_Spells_bank"] = {0, L.SoulwellYell},
	["premsg_Spells_toyTrain"] = {0, L.SoulwellYell},
	["premsg_Spells_moonfeather"] = {0, L.HeroismYell},
	["premsg_Spells_direbrews"] = {0, L.SummoningYell},
	["premsg_Spells_rallyingcry"] = {0, L.HeroismYell}, --Ободряющий клич
	["premsg_Spells_vampiricaura"] = {0, L.HeroismYell}, --Вампирская аура
	["premsg_Spells_auramastery"] = {0, L.HeroismYell}, --Владение аурами
	["premsg_Spells_vampiricembrace"] = {0, L.HeroismYell}, --Объятия вампира
	["premsg_Spells_powerwordbarrier"] = {0, L.HeroismYell}, --Слово силы: Барьер
	["premsg_Spells_guardianspirit"] = {0, L.SoulstoneYell, true}, --Оберегающий дух
	["premsg_Spells_painsuppression"] = {0, L.SoulstoneYell, true}, --Подавление боли
	["premsg_Spells_spirittotem"] = {0, L.HeroismYell}, --Тотем духовной связи
	["premsg_Spells_lifecocoon"] = {0, L.SoulstoneYell, true}, --Исцеляющий кокон
	["premsg_Spells_blesofprot"] = {0, L.SoulstoneYell, true}, --Благословение защиты
	["premsg_Spells_ironbark"] = {0, L.SoulstoneYell, true}, --Железная кора
	["premsg_Spells_ancprotectotem"] = {0, L.HeroismYell}, --Тотем защиты Предков
	["premsg_Spells_hope"] = {0, L.HeroismYell}, --Символ надежды
--	["premsg_Spells_innervate"] = {0, L.SoulstoneYell, true}, --Озарение
	["premsg_Spells_rebirth1"] = {0, L.SoulstoneYell, true}, --Возрождение
	["premsg_Spells_rebirth2"] = {0, L.SoulstoneYell, true}, --Воскрешение союзника
	["premsg_Spells_rebirth3"] = {0, L.SoulstoneYell, true} --Воскрешение камнем души
}
local playerOnlyName = UnitName("player")

local function sendAnnounce(self, spellId, sourceName, destName)
	for k, v in pairs(premsg_values) do
		if type(v) == "table" and v[1] == 1 then
			v[1] = 0
			if (not spellId) or (not sourceName) or (v[3] and not destName) then
				DBM:Debug('[sendAnnounce] spellId: ' .. tostring(spellId) .. ', sourceName: ' .. tostring(sourceName) .. ', destName: ' .. tostring(destName))
				return
			end
			smartChat(v[2]:format(DbmRV, sourceName, replaceSpellLinks(spellId), destName), v[4])
		end
	end
end

local function announceList(premsg_announce, value)
	for k, v in pairs(premsg_values) do
		if type(v) == "table" and k == premsg_announce then
			v[1] = value
		end
	end
end

local function prepareMessage(self, premsg_announce, spellId, sourceName, destName)
	if self:AntiSpam(1, "prepareMessage") then
		for k, v in pairs(premsg_values) do
			if type(v) == "table" and k == premsg_announce then
				if (not spellId) or (not sourceName) or (v[3] and not destName) then
					DBM:Debug('[prepareMessage] spellId: ' .. tostring(spellId) .. ', sourceName: ' .. tostring(sourceName) .. ', destName: ' .. tostring(destName))
					return
				end
			end
		end

		announceList(premsg_announce, 1)
		self:SendSync(premsg_announce, playerOnlyName)
		self:Schedule(1, sendAnnounce, self, spellId, sourceName, destName)
	end
end
-- Синхронизация анонсов ↑

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	local sourceName = args.sourceName
	local destName = args.destName
	if not UnitInYourParty(sourceName) then return end
	--[[if spellId == 8690 then -- test (Needs to be commented out before release)
		prepareMessage(self, "premsg_Spells_test", spellId, sourceName)
	elseif spellId == 222695 then -- test2 (Needs to be commented out before release)
		prepareMessage(self, "premsg_Spells_test2", spellId, sourceName)
	else]]if spellId == 212040 and self:AntiSpam(15, "massres") then --Возвращение к жизни (друид)
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
	if not self.Options.Enabled then return end
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
		--[[	if not args:IsPlayerSource() and not DBM.Options.IgnoreRaidAnnounce3 then
				smartChat(L.WhisperThanks:format(DbmRV, replaceSpellLinks(spellId)), "whisper", sourceName)
			end]]
		else
			warnGuardianSpirit:Show(sourceName, destName)
		end
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnRaidCooldown then
			prepareMessage(self, "premsg_Spells_guardianspirit", spellId, sourceName, destName)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
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
		--[[	if not args:IsPlayerSource() and not DBM.Options.IgnoreRaidAnnounce3 then
				smartChat(L.WhisperThanks:format(DbmRV, replaceSpellLinks(spellId)), "whisper", sourceName)
			end]]
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
		--[[	if not args:IsPlayerSource() and not DBM.Options.IgnoreRaidAnnounce3 then
				smartChat(L.WhisperThanks:format(DbmRV, replaceSpellLinks(spellId)), "whisper", sourceName)
			end]]
		else
			warnInnervate:Show(sourceName, destName)
		end
	elseif spellId == 64901 then --Символ надежды
		if typeInstance ~= "party" and typeInstance ~= "raid" then return end
		if DBM:GetNumRealGroupMembers() < 2 then return end
		if args:IsPlayer() and self:IsHealer() then
			specWarnSymbolHope:Show()
			specWarnSymbolHope:Play("targetyou")
			timerSymbolHope:Start()
		end
	elseif spellId == 33206 then --Подавление боли
		if typeInstance ~= "party" and typeInstance ~= "raid" then return end
		if DBM:GetNumRealGroupMembers() < 2 then return end
		if args:IsPlayer() then
			specWarnPainSuppression:Show()
			specWarnPainSuppression:Play("targetyou")
			timerPainSuppression:Start()
		--[[	if not args:IsPlayerSource() and not DBM.Options.IgnoreRaidAnnounce3 then
				smartChat(L.WhisperThanks:format(DbmRV, replaceSpellLinks(spellId)), "whisper", sourceName)
			end]]
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
		--[[	if not args:IsPlayerSource() and not DBM.Options.IgnoreRaidAnnounce3 then
				smartChat(L.WhisperThanks:format(DbmRV, replaceSpellLinks(spellId)), "whisper", sourceName)
			end]]
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
		--[[	if not args:IsPlayerSource() and not DBM.Options.IgnoreRaidAnnounce3 then
				smartChat(L.WhisperThanks:format(DbmRV, replaceSpellLinks(spellId)), "whisper", sourceName)
			end]]
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
		--[[	if not args:IsPlayerSource() and not DBM.Options.IgnoreRaidAnnounce3 then
				smartChat(L.WhisperThanks:format(DbmRV, replaceSpellLinks(spellId)), "whisper", sourceName)
			end]]
		else
			warnIronbark:Show(sourceName, destName)
		end
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnRaidCooldown then
			prepareMessage(self, "premsg_Spells_ironbark", spellId, sourceName, destName)
		end
	elseif spellId == 238698 then --Вампирская аура
		if typeInstance ~= "party" and typeInstance ~= "raid" then return end
		if DBM:GetNumRealGroupMembers() < 2 then return end
		if args:IsPlayer() then
			timerVampiricAura:Start()
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if not self.Options.Enabled then return end
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
	elseif spellId == 238698 then --Вампирская аура
		if args:IsPlayer() then
			timerVampiricAura:Stop()
		end
	end
end

function mod:SPELL_CREATE(args)
	if not self.Options.Enabled then return end
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
	if not self.Options.Enabled then return end
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
	if not self.Options.Enabled then return end
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
		--[[	if not DBM.Options.IgnoreRaidAnnounce3 then
				smartChat(L.WhisperThanks:format(DbmRV, replaceSpellLinks(spellId)), "whisper", sourceName)
			end]]
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
		--[[	if not DBM.Options.IgnoreRaidAnnounce3 then
				smartChat(L.WhisperThanks:format(DbmRV, replaceSpellLinks(spellId)), "whisper", sourceName)
			end]]
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
		--[[	if not DBM.Options.IgnoreRaidAnnounce3 then
				smartChat(L.WhisperThanks:format(DbmRV, replaceSpellLinks(spellId)), "whisper", sourceName)
			end]]
		else
			warnRebirth:Show(sourceName, destName)
		end
	end
end

function mod:GOSSIP_SHOW()
	if not self.Options.Enabled then return end
	local guid = UnitGUID("npc")
	if not guid then return end
	local cid = self:GetCIDFromGUID(guid)
	if cid == 113455 or cid == 113457 or cid == 109409 then -- Жалкие ночнорождённые
		if select('#', GetGossipOptions()) > 0 then
			SelectGossipOption(1, "", true)
		end
	end
end

function mod:PLAYER_DEAD()
	if not self.Options.Enabled then return end
	if not IsInInstance() and not HasSoulstone() and self.Options.AutoSpirit then
		RepopMe()
	end
end

function mod:OnSync(premsg_announce, sender)
	if not self.Options.Enabled then return end
	if sender < playerOnlyName then
		announceList(premsg_announce, 0)
	end
end
