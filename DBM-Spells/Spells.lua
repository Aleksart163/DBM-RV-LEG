local mod	= DBM:NewMod("Spells", "DBM-Spells")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetZone()
--mod:SetZone(1712, 1676, 1530, 1648, 1520, 1779, 1501, 1466, 1456, 1477, 1458, 1516, 1571, 1492, 1544, 1493, 1651, 1677, 1753)

mod.noStatistics = true

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS 688 691 157757 80353 32182 230935 90355 2825 160452 10059 11416 11419 32266 49360 11417 11418 11420 32267 49361 33691 53142 88345 88346 132620 132626 176246 176244 224871 29893",
	"SPELL_AURA_APPLIED 20707",
	"SPELL_SUMMON 67826 199109 199115",
	"SPELL_CREATE 698 188036 201352 201351",
	"SPELL_RESURRECT 95750 20484 61999"
)

--Прошляпанное очко Мурчаля ✔
local warnTimeWarp					= mod:NewTargetSourceAnnounce(80353, 1) --Искажение времени
local warnHeroism					= mod:NewTargetSourceAnnounce(32182, 1) --Героизм
local warnBloodlust					= mod:NewTargetSourceAnnounce(2825, 1) --Кровожадность
local warnHysteria					= mod:NewTargetSourceAnnounce(90355, 1) --Древняя истерия
local warnNetherwinds				= mod:NewTargetSourceAnnounce(160452, 1) --Ветер пустоты
local warnDrums						= mod:NewTargetSourceAnnounce(230935, 1) --Барабаны гор
local warnRitualofSummoning			= mod:NewTargetSourceAnnounce(698, 1) --Ритуал призыва
local warnSoulstone					= mod:NewTargetAnnounce(20707, 1) --Камень души

local specWarnSoulstone				= mod:NewSpecialWarningYou(20707, nil, nil, nil, 1, 2) --Камень души

mod:AddBoolOption("YellOnHeroism", false)
mod:AddBoolOption("YellOnResurrect", false)
mod:AddBoolOption("YellOnPortal", false)
mod:AddBoolOption("YellOnSoulwell", false)
mod:AddBoolOption("YellOnSoulstone", false)
mod:AddBoolOption("YellOnRitualofSummoning", false)
mod:AddBoolOption("YellOnSpiritCauldron", true)
mod:AddBoolOption("YellOnLavish", false)
mod:AddBoolOption("YellOnRepair", false)
mod:AddBoolOption("YellOnPylon", true)

local DbmRV = "[DBM RV] "
local timeWarp = DBM:GetSpellInfo(80353) --Искажение времени
local heroism = DBM:GetSpellInfo(32182) --Героизм
local bloodlust = DBM:GetSpellInfo(2825) --Кровожадность
local hysteria = DBM:GetSpellInfo(90355) --Древняя истерия
local winds = DBM:GetSpellInfo(160452) --Ветер пустоты
local drums = DBM:GetSpellInfo(230935) --Барабаны гор
--
local rebirth = DBM:GetSpellInfo(20484) --Возрождение
--
local stormwind = DBM:GetSpellInfo(10059) --Штормград
local ironforge = DBM:GetSpellInfo(11416) --Стальгорн
local darnassus = DBM:GetSpellInfo(11419) --Дарнас
local exodar = DBM:GetSpellInfo(32266) --Экзодар
local theramore = DBM:GetSpellInfo(49360) --Терамор
local orgrimmar = DBM:GetSpellInfo(11417) --Оргриммар
local undercity = DBM:GetSpellInfo(11418) --Подгород
local thunderBluff = DBM:GetSpellInfo(11420) --Громовой утес
local silvermoon = DBM:GetSpellInfo(32267) --Луносвет
local stonard = DBM:GetSpellInfo(49361) --Каменор
local shattrath = DBM:GetSpellInfo(33691) --Шаттрат
local dalaran1 = DBM:GetSpellInfo(53142) --Даларан1
local tolBarad1 = DBM:GetSpellInfo(88345) --Тол Барад (альянс)
local tolBarad2 = DBM:GetSpellInfo(88346) --Тол Барад (орда)
local valeEternal1 = DBM:GetSpellInfo(132620) --Вечноцветущий дол (альянс)
local valeEternal2 = DBM:GetSpellInfo(132626) --Вечноцветущий дол (орда)
local stormshield = DBM:GetSpellInfo(176246) --Преграда Ветров (альянс)
local warspear = DBM:GetSpellInfo(176244) --Копье Войны (орда)
local dalaran2 = DBM:GetSpellInfo(224871) --Даларан2
--
local soulwell = DBM:GetSpellInfo(58275) --29893 Источник душ
local soulstone = DBM:GetSpellInfo(20707) --Камень души
local summoning = DBM:GetSpellInfo(698) --Ритуал призыва
--
local cauldron = DBM:GetSpellInfo(188036) --Котел духов
--
local lavishSuramar = DBM:GetSpellInfo(201352) --Щедрое сурамарское угощение
local hearty = DBM:GetSpellInfo(201351) --Обильное угощение
--
local jeeves = DBM:GetSpellInfo(67826) --Дживс
local autoHammer = DBM:GetSpellInfo(199109) --Автоматический молот
local pylon = DBM:GetSpellInfo(199115) --Пилон для обнаружения проблем

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 80353 then --Искажение времени
		if self:AntiSpam(2, 1) then
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
		if self:AntiSpam(2, 1) then
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
		if self:AntiSpam(2, 1) then
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
		if self:AntiSpam(2, 1) then
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
		if self:AntiSpam(2, 1) then
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
		if self:AntiSpam(2, 1) then
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
	elseif spellId == 29893 and self:AntiSpam(2, 1) then --Источник душ
		if self.Options.YellOnSoulwell then
			if IsInRaid() then
				SendChatMessage(L.SoulwellYell:format(DbmRV, args.sourceName, soulwell), "RAID")
			elseif IsInGroup() then
				SendChatMessage(L.SoulwellYell:format(DbmRV, args.sourceName, soulwell), "PARTY")
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
			if IsInRaid() and self:AntiSpam(2.5, 2) then
				SendChatMessage(L.SummoningYell:format(DbmRV, args.sourceName, summoning), "RAID")
			elseif IsInGroup() and self:AntiSpam(2.5, 2) then
				SendChatMessage(L.SummoningYell:format(DbmRV, args.sourceName, summoning), "PARTY")
			end
		end
	elseif spellId == 188036 then --Котел духов
		if self.Options.YellOnSpiritCauldron then
			if IsInRaid() then
				SendChatMessage(L.SoulwellYell:format(DbmRV, args.sourceName, cauldron), "RAID")
			elseif IsInGroup() then
				SendChatMessage(L.SoulwellYell:format(DbmRV, args.sourceName, cauldron), "PARTY")
			end
		end
	elseif spellId == 201352 then --Щедрое сурамарское угощение
		if self.Options.YellOnLavish then
			if IsInRaid() then
				SendChatMessage(L.SoulwellYell:format(DbmRV, args.sourceName, lavishSuramar), "RAID")
			elseif IsInGroup() then
				SendChatMessage(L.SoulwellYell:format(DbmRV, args.sourceName, lavishSuramar), "PARTY")
			end
		end
	elseif spellId == 201351 then --Обильное угощение
		if self.Options.YellOnLavish then
			if IsInRaid() then
				SendChatMessage(L.SoulwellYell:format(DbmRV, args.sourceName, hearty), "RAID")
			elseif IsInGroup() then
				SendChatMessage(L.SoulwellYell:format(DbmRV, args.sourceName, hearty), "PARTY")
			end
		end
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 67826 or spellId == 199109 then --Починка
		if self.Options.YellOnRepair then
			if spellId == 67826 and self:AntiSpam(2.5, 3) then --Дживс
				if IsInRaid() then
					SendChatMessage(L.SoulwellYell:format(DbmRV, args.sourceName, jeeves), "RAID")
				elseif IsInGroup() then
					SendChatMessage(L.SoulwellYell:format(DbmRV, args.sourceName, jeeves), "PARTY")
				end
			elseif spellId == 199109 and self:AntiSpam(2.5, 3) then --Автоматический молот
				if IsInRaid() then
					SendChatMessage(L.SoulwellYell:format(DbmRV, args.sourceName, autoHammer), "RAID")
				elseif IsInGroup() then
					SendChatMessage(L.SoulwellYell:format(DbmRV, args.sourceName, autoHammer), "PARTY")
				end
			end
		end
	elseif spellId == 199115 and self:AntiSpam(2.5, 4) then --Пилон для обнаружения проблем
		if self.Options.YellOnPylon then
			if IsInRaid() then
				SendChatMessage(L.SoulwellYell:format(DbmRV, args.sourceName, pylon), "RAID")
			elseif IsInGroup() then
				SendChatMessage(L.SoulwellYell:format(DbmRV, args.sourceName, pylon), "PARTY")
			end
		end
	end
end

function mod:SPELL_RESURRECT(args)
	local spellId = args.spellId
	if spellId == 95750 then --Воскрешение камнем души
		if self.Options.YellOnResurrect then
			if IsInRaid() then
				SendChatMessage(L.SoulstoneYell:format(DbmRV, args.sourceName, rebirth, args.destName), "RAID")
			elseif IsInGroup() then
				SendChatMessage(L.SoulstoneYell:format(DbmRV, args.sourceName, rebirth, args.destName), "PARTY")
			end
		end
	elseif spellId == 20484 then --Возрождение
		if self.Options.YellOnResurrect then
			if IsInRaid() then
				SendChatMessage(L.SoulstoneYell:format(DbmRV, args.sourceName, rebirth, args.destName), "RAID")
			elseif IsInGroup() then
				SendChatMessage(L.SoulstoneYell:format(DbmRV, args.sourceName, rebirth, args.destName), "PARTY")
			end
		end
	elseif spellId == 61999 then --Воскрешение союзника
		if self.Options.YellOnResurrect then
			if IsInRaid() then
				SendChatMessage(L.SoulstoneYell:format(DbmRV, args.sourceName, rebirth, args.destName), "RAID")
			elseif IsInGroup() then
				SendChatMessage(L.SoulstoneYell:format(DbmRV, args.sourceName, rebirth, args.destName), "PARTY")
			end
		end
	end
end
