local mod	= DBM:NewMod("Spells2", "DBM-Spells")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
mod:SetZone(1712, 1676, 1648, 1530, 1520, 1753, 1677, 1651, 1571, 1544, 1516, 1501, 1493, 1492, 1477, 1466, 1458, 1456, 1669, 1220, 1116, 1064, 870, 571, 530, 1, 0)
--АПТ, ГС, ИД, ЦН, ИК, ПТ, СВН, Каражан, КЗ, ШАК, Катакомбы, КЧЛ, КС, УД, ЧД, ЧТС, ЛН, ОА, Аргус, Расколотые острова, Дренор, Остров Грома, Пандария, Нордскол, Запределье, Калимдор, Восточные королевства

mod.noStatistics = true

mod:RegisterEvents(
	"SPELL_CAST_START 7720"
--	"SPELL_CAST_FAILED"
)

--Прошляпанное очко Мурчаля Прошляпенко✔✔✔

mod:AddBoolOption("YellOnSummoning", true)

--Спеллы лока
local summoning2 = replaceSpellLinks(7720)

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 7720 then --Ритуал призыва
		if not DBM.Options.IgnoreRaidAnnounce and self.Options.YellOnSummoning then
			if args:IsPlayerSource() then
				smartChat(L.SummonYell:format(DbmRV, args.sourceName, summoning2, UnitName("target")))
			end
		end
	end
end
