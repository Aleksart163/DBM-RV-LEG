local mod	= DBM:NewMod("Spells", "DBM-Spells")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
--mod:SetZone()
mod:SetZone(1712, 1676, 1530, 1648, 1520, 1779, 1501, 1466, 1456, 1477, 1458, 1516, 1571, 1492, 1544, 1493, 1651, 1677, 1753)

mod.noStatistics = true

mod:RegisterEvents(
	"SPELL_CAST_START 61994 212040 212056 212036 212048 212051",
	"SPELL_CAST_SUCCESS 688 691 157757 80353 32182 230935 90355 2825 160452 10059 11416 11419 32266 49360 11417 11418 11420 32267 49361 33691 53142 88345 88346 132620 132626 176246 176244 224871 29893 83958",
	"SPELL_AURA_APPLIED 20707",
	"SPELL_SUMMON 67826 199109 199115 195782",
	"SPELL_CREATE 698 188036 201352 201351 185709 88304 61031 49844",
	"SPELL_RESURRECT 95750 20484 61999"
--	"UNIT_SPELLCAST_SUCCEEDED"
)

--Прошляпанное очко Мурчаля Прошляпенко✔✔✔
local warnMassres1					= mod:NewTargetSourceAnnounce(212040, 1) --Возвращение к жизни (друид)
local warnMassres2					= mod:NewTargetSourceAnnounce(212056, 1) --Отпущение (пал)
local warnMassres3					= mod:NewTargetSourceAnnounce(212036, 1) --Массовое воскрешение (прист)
local warnMassres4					= mod:NewTargetSourceAnnounce(212048, 1) --Древнее видение (шаман)
local warnMassres5					= mod:NewTargetSourceAnnounce(212051, 1) --Повторное пробуждение (монк)

local warnPylon						= mod:NewTargetSourceAnnounce(199115, 1) --Пилон
local warnJeeves					= mod:NewTargetSourceAnnounce(67826, 1) --Дживс
local warnAutoHammer				= mod:NewTargetSourceAnnounce(199109, 1) --Автоматический молот

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
local warnCauldron					= mod:NewTargetSourceAnnounce(188036, 1) --Котел духов
local warnSoulstone					= mod:NewTargetAnnounce(20707, 1) --Камень души
local warnRebirth					= mod:NewTargetSourceAnnounce2(20484, 1) --Возрождение

local specWarnSoulstone				= mod:NewSpecialWarningYou(20707, nil, nil, nil, 1, 2) --Камень души

local yellSoulstone					= mod:NewYell(20707, nil, nil, nil, "YELL") --Камень души

mod:AddBoolOption("YellOnMassRes", true) --масс рес
mod:AddBoolOption("YellOnHeroism", false) --героизм
mod:AddBoolOption("YellOnResurrect", false) --бр
mod:AddBoolOption("YellOnPortal", false) --порталы
mod:AddBoolOption("YellOnSoulwell", false)
mod:AddBoolOption("YellOnSoulstone", false)
mod:AddBoolOption("YellOnRitualofSummoning", false)
mod:AddBoolOption("YellOnSpiritCauldron", true) --котел
mod:AddBoolOption("YellOnLavish", false)
mod:AddBoolOption("YellOnBank", true) --банк
mod:AddBoolOption("YellOnRepair", false) --починка
mod:AddBoolOption("YellOnPylon", true) --пилон
mod:AddBoolOption("YellOnToys", true) --игрушки
--
local function replaceSpellLinks(id)
    local spellId = tonumber(id)
    local spellName = DBM:GetSpellInfo(spellId)
    if not spellName then
        spellName = DBM_CORE_UNKNOWN
        DBM:Debug("Spell ID does not exist: "..spellId)
    end
    return ("|cff71d5ff|Hspell:%d:0|h[%s]|h|r"):format(spellId, spellName)
end

local DbmRV = "[DBM RV] "
--Массрес
local massres1, massres2, massres3, massres4, massres5 = replaceSpellLinks(212040), replaceSpellLinks(212056), replaceSpellLinks(212036), replaceSpellLinks(212048), replaceSpellLinks(212051)
--Героизм
local timeWarp, heroism, bloodlust, hysteria, winds, drums = replaceSpellLinks(80353), replaceSpellLinks(32182), replaceSpellLinks(2825), replaceSpellLinks(90355), replaceSpellLinks(160452), replaceSpellLinks(230935)
--БР
local rebirth1, rebirth2, rebirth3 = replaceSpellLinks(20484), replaceSpellLinks(61999), replaceSpellLinks(95750)
--Порталы Альянса
local stormwind, ironforge, darnassus, exodar, theramore, tolBarad1, valeEternal1, stormshield = replaceSpellLinks(10059), replaceSpellLinks(11416), replaceSpellLinks(11419), replaceSpellLinks(32266), replaceSpellLinks(49360), replaceSpellLinks(88345), replaceSpellLinks(132620), replaceSpellLinks(176246)
--Порталы Орды
local orgrimmar, undercity, thunderBluff, silvermoon, stonard, tolBarad2, valeEternal2, warspear = replaceSpellLinks(11417), replaceSpellLinks(11418), replaceSpellLinks(11420), replaceSpellLinks(32267), replaceSpellLinks(49361), replaceSpellLinks(88346), replaceSpellLinks(132626), replaceSpellLinks(176244)
--Порталы общие
local shattrath, dalaran1, dalaran2 = replaceSpellLinks(33691), replaceSpellLinks(53142), replaceSpellLinks(224871)
--Спеллы лока
local soulwell, soulstone, summoning = replaceSpellLinks(29893), replaceSpellLinks(20707), replaceSpellLinks(698)
--Котел духов
local cauldron = replaceSpellLinks(188036)
--Еда
local lavishSuramar, hearty, sugar = replaceSpellLinks(201352), replaceSpellLinks(201351), replaceSpellLinks(185709)
--Инженерия
local jeeves, autoHammer, pylon = replaceSpellLinks(67826), replaceSpellLinks(199109), replaceSpellLinks(199115)
--Мобильный банк
local bank = replaceSpellLinks(88306) --83958
--Игрушки
local toyTrain, moonfeather, highborne, discoball, direbrews = replaceSpellLinks(61031), replaceSpellLinks(195782), replaceSpellLinks(73331), replaceSpellLinks(50317), replaceSpellLinks(49844)

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 212040 or spellId == 212056 or spellId == 212036 or spellId == 212048 or spellId == 212051 then
		if self.Options.YellOnMassRes then
			if spellId == 212040 and self:AntiSpam(10, 12) then --Возвращение к жизни (друид)
				if IsInRaid() and DBM:GetRaidRank() > 0 then
					SendChatMessage(L.HeroismYell:format(DbmRV, args.sourceName, massres1), "RAID_WARNING")
				else
					warnMassres1:Show(args.sourceName)
				end
			elseif spellId == 212056 and self:AntiSpam(10, 12) then --Отпущение (пал)
				if IsInRaid() and DBM:GetRaidRank() > 0 then
					SendChatMessage(L.HeroismYell:format(DbmRV, args.sourceName, massres2), "RAID_WARNING")
				else
					warnMassres2:Show(args.sourceName)
				end
			elseif spellId == 212036 and self:AntiSpam(10, 12) then --Массовое воскрешение (прист)
				if IsInRaid() and DBM:GetRaidRank() > 0 then
					SendChatMessage(L.HeroismYell:format(DbmRV, args.sourceName, massres3), "RAID_WARNING")
				else
					warnMassres3:Show(args.sourceName)
				end
			elseif spellId == 212048 and self:AntiSpam(10, 12) then --Древнее видение (шаман)
				if IsInRaid() and DBM:GetRaidRank() > 0 then
					SendChatMessage(L.HeroismYell:format(DbmRV, args.sourceName, massres4), "RAID_WARNING")
				else
					warnMassres4:Show(args.sourceName)
				end
			elseif spellId == 212051 and self:AntiSpam(10, 12) then --Повторное пробуждение (монк)
				if IsInRaid() and DBM:GetRaidRank() > 0 then
					SendChatMessage(L.HeroismYell:format(DbmRV, args.sourceName, massres5), "RAID_WARNING")
				else
					warnMassres5:Show(args.sourceName)
				end
			end
		end
	end
end
	
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 80353 then --Искажение времени
		if self:AntiSpam(7, 1) then
			warnTimeWarp:Show(args.sourceName)
		end
		if self.Options.YellOnHeroism then
			if IsInRaid() then
				SendChatMessage(L.HeroismYell:format(DbmRV, args.sourceName, timeWarp), "RAID")
			elseif IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
				SendChatMessage(L.HeroismYell:format(DbmRV, args.sourceName, timeWarp), "INSTANCE_CHAT")
			elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
				SendChatMessage(L.HeroismYell:format(DbmRV, args.sourceName, timeWarp), "PARTY")
			end
		end
	elseif spellId == 32182 then --Героизм
		if self:AntiSpam(5, 1) then
			warnHeroism:Show(args.sourceName)
		end
		if self.Options.YellOnHeroism then
			if IsInRaid() then
				SendChatMessage(L.HeroismYell:format(DbmRV, args.sourceName, heroism), "RAID")
			elseif IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
				SendChatMessage(L.HeroismYell:format(DbmRV, args.sourceName, heroism), "INSTANCE_CHAT")
			elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
				SendChatMessage(L.HeroismYell:format(DbmRV, args.sourceName, heroism), "PARTY")
			end
		end
	elseif spellId == 2825 then --Кровожадность
		if self:AntiSpam(5, 1) then
			warnBloodlust:Show(args.sourceName)
		end
		if self.Options.YellOnHeroism then
			if IsInRaid() then
				SendChatMessage(L.HeroismYell:format(DbmRV, args.sourceName, bloodlust), "RAID")
			elseif IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
				SendChatMessage(L.HeroismYell:format(DbmRV, args.sourceName, bloodlust), "INSTANCE_CHAT")
			elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
				SendChatMessage(L.HeroismYell:format(DbmRV, args.sourceName, bloodlust), "PARTY")
			end
		end
	elseif spellId == 90355 then --Древняя истерия (пет ханта)
		if self:AntiSpam(5, 1) then
			warnHysteria:Show(args.sourceName)
		end
		if self.Options.YellOnHeroism then
			if IsInRaid() then
				SendChatMessage(L.HeroismYell:format(DbmRV, args.sourceName, hysteria), "RAID")
			elseif IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
				SendChatMessage(L.HeroismYell:format(DbmRV, args.sourceName, hysteria), "INSTANCE_CHAT")
			elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
				SendChatMessage(L.HeroismYell:format(DbmRV, args.sourceName, hysteria), "PARTY")
			end
		end
	elseif spellId == 160452 then --Ветер пустоты (пет ханта)
		if self:AntiSpam(5, 1) then
			warnNetherwinds:Show(args.sourceName)
		end
		if self.Options.YellOnHeroism then
			if IsInRaid() then
				SendChatMessage(L.HeroismYell:format(DbmRV, args.sourceName, winds), "RAID")
			elseif IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
				SendChatMessage(L.HeroismYell:format(DbmRV, args.sourceName, winds), "INSTANCE_CHAT")
			elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
				SendChatMessage(L.HeroismYell:format(DbmRV, args.sourceName, winds), "PARTY")
			end
		end
	elseif spellId == 230935 then --Барабаны гор
		if self:AntiSpam(5, 1) then
			warnDrums:Show(args.sourceName)
		end
		if self.Options.YellOnHeroism then
			if IsInRaid() then
				SendChatMessage(L.HeroismYell:format(DbmRV, args.sourceName, drums), "RAID")
			elseif IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
				SendChatMessage(L.HeroismYell:format(DbmRV, args.sourceName, drums), "INSTANCE_CHAT")
			elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
				SendChatMessage(L.HeroismYell:format(DbmRV, args.sourceName, drums), "PARTY")
			end
		end
	elseif spellId == 10059 then --Штормград
		if self.Options.YellOnPortal then
			if IsInRaid() then
				SendChatMessage(L.PortalYell:format(DbmRV, args.sourceName, stormwind), "RAID")
			elseif IsInGroup() then
				SendChatMessage(L.PortalYell:format(DbmRV, args.sourceName, stormwind), "PARTY")
			end
		end
	elseif spellId == 11416 then --Стальгорн
		if self.Options.YellOnPortal then
			if IsInRaid() then
				SendChatMessage(L.PortalYell:format(DbmRV, args.sourceName, ironforge), "RAID")
			elseif IsInGroup() then
				SendChatMessage(L.PortalYell:format(DbmRV, args.sourceName, ironforge), "PARTY")
			end
		end
	elseif spellId == 11419 then --Дарнас
		if self.Options.YellOnPortal then
			if IsInRaid() then
				SendChatMessage(L.PortalYell:format(DbmRV, args.sourceName, darnassus), "RAID")
			elseif IsInGroup() then
				SendChatMessage(L.PortalYell:format(DbmRV, args.sourceName, darnassus), "PARTY")
			end
		end
	elseif spellId == 32266 then --Экзодар
		if self.Options.YellOnPortal then
			if IsInRaid() then
				SendChatMessage(L.PortalYell:format(DbmRV, args.sourceName, exodar), "RAID")
			elseif IsInGroup() then
				SendChatMessage(L.PortalYell:format(DbmRV, args.sourceName, exodar), "PARTY")
			end
		end
	elseif spellId == 49360 then --Терамор
		if self.Options.YellOnPortal then
			if IsInRaid() then
				SendChatMessage(L.PortalYell:format(DbmRV, args.sourceName, theramore), "RAID")
			elseif IsInGroup() then
				SendChatMessage(L.PortalYell:format(DbmRV, args.sourceName, theramore), "PARTY")
			end
		end
	elseif spellId == 11417 then --Оргриммар
		if self.Options.YellOnPortal then
			if IsInRaid() then
				SendChatMessage(L.PortalYell:format(DbmRV, args.sourceName, orgrimmar), "RAID")
			elseif IsInGroup() then
				SendChatMessage(L.PortalYell:format(DbmRV, args.sourceName, orgrimmar), "PARTY")
			end
		end
	elseif spellId == 11418 then --Подгород
		if self.Options.YellOnPortal then
			if IsInRaid() then
				SendChatMessage(L.PortalYell:format(DbmRV, args.sourceName, undercity), "RAID")
			elseif IsInGroup() then
				SendChatMessage(L.PortalYell:format(DbmRV, args.sourceName, undercity), "PARTY")
			end
		end
	elseif spellId == 11420 then --Громовой утес
		if self.Options.YellOnPortal then
			if IsInRaid() then
				SendChatMessage(L.PortalYell:format(DbmRV, args.sourceName, thunderBluff), "RAID")
			elseif IsInGroup() then
				SendChatMessage(L.PortalYell:format(DbmRV, args.sourceName, thunderBluff), "PARTY")
			end
		end
	elseif spellId == 32267 then --Луносвет
		if self.Options.YellOnPortal then
			if IsInRaid() then
				SendChatMessage(L.PortalYell:format(DbmRV, args.sourceName, silvermoon), "RAID")
			elseif IsInGroup() then
				SendChatMessage(L.PortalYell:format(DbmRV, args.sourceName, silvermoon), "PARTY")
			end
		end
	elseif spellId == 49361 then --Каменор
		if self.Options.YellOnPortal then
			if IsInRaid() then
				SendChatMessage(L.PortalYell:format(DbmRV, args.sourceName, stonard), "RAID")
			elseif IsInGroup() then
				SendChatMessage(L.PortalYell:format(DbmRV, args.sourceName, stonard), "PARTY")
			end
		end
	elseif spellId == 33691 then --Шаттрат
		if self.Options.YellOnPortal then
			if IsInRaid() then
				SendChatMessage(L.PortalYell:format(DbmRV, args.sourceName, shattrath), "RAID")
			elseif IsInGroup() then
				SendChatMessage(L.PortalYell:format(DbmRV, args.sourceName, shattrath), "PARTY")
			end
		end
	elseif spellId == 53142 then --Даларан1
		if self.Options.YellOnPortal then
			if IsInRaid() then
				SendChatMessage(L.PortalYell:format(DbmRV, args.sourceName, dalaran1), "RAID")
			elseif IsInGroup() then
				SendChatMessage(L.PortalYell:format(DbmRV, args.sourceName, dalaran1), "PARTY")
			end
		end
	elseif spellId == 88345 then --Тол Барад (альянс)
		if self.Options.YellOnPortal then
			if IsInRaid() then
				SendChatMessage(L.PortalYell:format(DbmRV, args.sourceName, tolBarad1), "RAID")
			elseif IsInGroup() then
				SendChatMessage(L.PortalYell:format(DbmRV, args.sourceName, tolBarad1), "PARTY")
			end
		end
	elseif spellId == 88346 then --Тол Барад (орда)
		if self.Options.YellOnPortal then
			if IsInRaid() then
				SendChatMessage(L.PortalYell:format(DbmRV, args.sourceName, tolBarad2), "RAID")
			elseif IsInGroup() then
				SendChatMessage(L.PortalYell:format(DbmRV, args.sourceName, tolBarad2), "PARTY")
			end
		end
	elseif spellId == 132620 then --Вечноцветущий дол (альянс)
		if self.Options.YellOnPortal then
			if IsInRaid() then
				SendChatMessage(L.PortalYell:format(DbmRV, args.sourceName, valeEternal1), "RAID")
			elseif IsInGroup() then
				SendChatMessage(L.PortalYell:format(DbmRV, args.sourceName, valeEternal1), "PARTY")
			end
		end
	elseif spellId == 132626 then --Вечноцветущий дол (орда)
		if self.Options.YellOnPortal then
			if IsInRaid() then
				SendChatMessage(L.PortalYell:format(DbmRV, args.sourceName, valeEternal2), "RAID")
			elseif IsInGroup() then
				SendChatMessage(L.PortalYell:format(DbmRV, args.sourceName, valeEternal2), "PARTY")
			end
		end
	elseif spellId == 176246 then --Преграда Ветров (альянс)
		if self.Options.YellOnPortal then
			if IsInRaid() then
				SendChatMessage(L.PortalYell:format(DbmRV, args.sourceName, stormshield), "RAID")
			elseif IsInGroup() then
				SendChatMessage(L.PortalYell:format(DbmRV, args.sourceName, stormshield), "PARTY")
			end
		end
	elseif spellId == 176244 then --Копье Войны (орда)
		if self.Options.YellOnPortal then
			if IsInRaid() then
				SendChatMessage(L.PortalYell:format(DbmRV, args.sourceName, warspear), "RAID")
			elseif IsInGroup() then
				SendChatMessage(L.PortalYell:format(DbmRV, args.sourceName, warspear), "PARTY")
			end
		end
	elseif spellId == 224871 then --Даларан2
		if self.Options.YellOnPortal then
			if IsInRaid() then
				SendChatMessage(L.PortalYell:format(DbmRV, args.sourceName, dalaran2), "RAID")
			elseif IsInGroup() then
				SendChatMessage(L.PortalYell:format(DbmRV, args.sourceName, dalaran2), "PARTY")
			end
		end
	elseif spellId == 29893 and self:AntiSpam(3, 1) then --Источник душ
		if self.Options.YellOnSoulwell then
			if IsInRaid() then
				SendChatMessage(L.HeroismYell:format(DbmRV, args.sourceName, soulwell), "RAID")
			elseif IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
				SendChatMessage(L.HeroismYell:format(DbmRV, args.sourceName, soulwell), "INSTANCE_CHAT")
			elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
				SendChatMessage(L.HeroismYell:format(DbmRV, args.sourceName, soulwell), "PARTY")
			end
		end
	elseif spellId == 83958 and self:AntiSpam(3, 8) then --Мобильный банк
		if self.Options.YellOnBank then
			if IsInRaid() then
				SendChatMessage(L.SoulwellYell:format(DbmRV, args.sourceName, bank), "RAID")
			elseif IsInGroup() then
				SendChatMessage(L.SoulwellYell:format(DbmRV, args.sourceName, bank), "PARTY")
			end
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 20707 then --Камень души
		warnSoulstone:Show(args.destName)
		if args:IsPlayer() then
			specWarnSoulstone:Show()
			specWarnSoulstone:Play("targetyou")
			yellSoulstone:Yell()
		end
		if self.Options.YellOnSoulstone then
			if IsInRaid() then
				SendChatMessage(L.SoulstoneYell:format(DbmRV, args.sourceName, soulstone, args.destName), "RAID")
			elseif IsInGroup() then
				SendChatMessage(L.SoulstoneYell:format(DbmRV, args.sourceName, soulstone, args.destName), "PARTY")
			end
		end
	end
end

function mod:SPELL_CREATE(args)
	local spellId = args.spellId
	if spellId == 698 then --Ритуал призыва
		warnRitualofSummoning:Show(args.sourceName)
		if self.Options.YellOnRitualofSummoning then
			if IsInRaid() and self:AntiSpam(5, 2) then
				SendChatMessage(L.SummoningYell:format(DbmRV, args.sourceName, summoning), "RAID")
			elseif IsInGroup() and self:AntiSpam(5, 2) then
				SendChatMessage(L.SummoningYell:format(DbmRV, args.sourceName, summoning), "PARTY")
			end
		end
	elseif spellId == 188036 and self:AntiSpam(10, 5) then --Котел духов
		if self.Options.YellOnSpiritCauldron then
			if IsInRaid() and DBM:GetRaidRank() > 0 then
				SendChatMessage(L.SoulwellYell:format(DbmRV, args.sourceName, cauldron), "RAID_WARNING")
			elseif IsInRaid() then
				warnCauldron:Show(args.sourceName)
				SendChatMessage(L.SoulwellYell:format(DbmRV, args.sourceName, cauldron), "RAID")
			elseif IsInGroup() then
				warnCauldron:Show(args.sourceName)
				SendChatMessage(L.SoulwellYell:format(DbmRV, args.sourceName, cauldron), "PARTY")
			end
		end
	elseif spellId == 201352 and self:AntiSpam(10, 6) then --Щедрое сурамарское угощение
		if self.Options.YellOnLavish then
			if IsInRaid() and DBM:GetRaidRank() > 0 then
				SendChatMessage(L.SoulwellYell:format(DbmRV, args.sourceName, lavishSuramar), "RAID_WARNING")
			elseif IsInRaid() then
				warnLavishSuramar:Show(args.sourceName)
				SendChatMessage(L.SoulwellYell:format(DbmRV, args.sourceName, lavishSuramar), "RAID")
			elseif IsInGroup() then
				warnLavishSuramar:Show(args.sourceName)
				SendChatMessage(L.SoulwellYell:format(DbmRV, args.sourceName, lavishSuramar), "PARTY")
			end
		end
	elseif spellId == 201351 and self:AntiSpam(10, 7) then --Обильное угощение
		warnHearty:Show(args.sourceName)
		if self.Options.YellOnLavish then
			if IsInRaid() then
				SendChatMessage(L.SoulwellYell:format(DbmRV, args.sourceName, hearty), "RAID")
			elseif IsInGroup() then
				SendChatMessage(L.SoulwellYell:format(DbmRV, args.sourceName, hearty), "PARTY")
			end
		end
	elseif spellId == 185709 and self:AntiSpam(10, 9) then --Угощение из засахаренной рыбы
		warnSugar:Show(args.sourceName)
		if self.Options.YellOnLavish then
			if IsInRaid() then
				SendChatMessage(L.SoulwellYell:format(DbmRV, args.sourceName, sugar), "RAID")
			elseif IsInGroup() then
				SendChatMessage(L.SoulwellYell:format(DbmRV, args.sourceName, sugar), "PARTY")
			end
		end
	elseif spellId == 61031 and self:AntiSpam(10, 10) then --Игрушечная железная дорога
		if self.Options.YellOnToys then
			if IsInRaid() then
				SendChatMessage(L.SoulwellYell:format(DbmRV, args.sourceName, toyTrain), "RAID")
			elseif IsInGroup() then
				SendChatMessage(L.SoulwellYell:format(DbmRV, args.sourceName, toyTrain), "PARTY")
			end
		end
	elseif spellId == 49844 and self:AntiSpam(10, 12) then --пульт управления Худовара
		if self.Options.YellOnToys then
			if IsInRaid() then
				SendChatMessage(L.SummoningYell:format(DbmRV, args.sourceName, direbrews), "RAID")
			elseif IsInGroup() then
				SendChatMessage(L.SummoningYell:format(DbmRV, args.sourceName, direbrews), "PARTY")
			end
		end
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 67826 or spellId == 199109 then --Починка
		if self.Options.YellOnRepair then
			if spellId == 67826 and self:AntiSpam(10, 3) then --Дживс 
				if IsInRaid() and DBM:GetRaidRank() > 0 then
					SendChatMessage(L.SoulwellYell:format(DbmRV, args.sourceName, jeeves), "RAID_WARNING")
				else
					warnJeeves:Show(args.sourceName)
				end
			elseif spellId == 199109 and self:AntiSpam(10, 3) then --Автоматический молот
				if IsInRaid() and DBM:GetRaidRank() > 0 then
					SendChatMessage(L.SoulwellYell:format(DbmRV, args.sourceName, autoHammer), "RAID_WARNING")
				else
					warnAutoHammer:Show(args.sourceName)
				end
			end
		end
	elseif spellId == 199115 and self:AntiSpam(10, 4) then --Пилон для обнаружения проблем
		if self.Options.YellOnPylon then
			if IsInRaid() and DBM:GetRaidRank() > 0 then
				SendChatMessage(L.SoulwellYell:format(DbmRV, args.sourceName, pylon), "RAID_WARNING")
			else
				warnPylon:Show(args.sourceName)
			end
		end
	elseif spellId == 195782 and self:AntiSpam(5, 11) then --Призыв статуи лунного совуха
		if self.Options.YellOnToys then
			if IsInRaid() then
				SendChatMessage(L.HeroismYell:format(DbmRV, args.sourceName, moonfeather), "RAID")
			elseif IsInGroup() then
				SendChatMessage(L.HeroismYell:format(DbmRV, args.sourceName, moonfeather), "PARTY")
			end
		end
	end
end

function mod:SPELL_RESURRECT(args)
	local spellId = args.spellId
	if spellId == 95750 then --Воскрешение камнем души
		warnRebirth:Show(args.sourceName, args.destName)
		if self.Options.YellOnResurrect then
			if IsInRaid() then
				SendChatMessage(L.SoulstoneYell:format(DbmRV, args.sourceName, rebirth3, args.destName), "RAID")
			elseif IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
				SendChatMessage(L.SoulstoneYell:format(DbmRV, args.sourceName, rebirth3, args.destName), "INSTANCE_CHAT")
			elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
				SendChatMessage(L.SoulstoneYell:format(DbmRV, args.sourceName, rebirth3, args.destName), "PARTY")
			end
		end
	elseif spellId == 20484 then --Возрождение
		warnRebirth:Show(args.sourceName, args.destName)
		if self.Options.YellOnResurrect then
			if IsInRaid() then
				SendChatMessage(L.SoulstoneYell:format(DbmRV, args.sourceName, rebirth1, args.destName), "RAID")
			elseif IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
				SendChatMessage(L.SoulstoneYell:format(DbmRV, args.sourceName, rebirth1, args.destName), "INSTANCE_CHAT")
			elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
				SendChatMessage(L.SoulstoneYell:format(DbmRV, args.sourceName, rebirth1, args.destName), "PARTY")
			end
		end
	elseif spellId == 61999 then --Воскрешение союзника
		warnRebirth:Show(args.sourceName, args.destName)
		if self.Options.YellOnResurrect then
			if IsInRaid() then
				SendChatMessage(L.SoulstoneYell:format(DbmRV, args.sourceName, rebirth2, args.destName), "RAID")
			elseif IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
				SendChatMessage(L.SoulstoneYell:format(DbmRV, args.sourceName, rebirth2, args.destName), "INSTANCE_CHAT")
			elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
				SendChatMessage(L.SoulstoneYell:format(DbmRV, args.sourceName, rebirth2, args.destName), "PARTY")
			end
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
	end
end]]
