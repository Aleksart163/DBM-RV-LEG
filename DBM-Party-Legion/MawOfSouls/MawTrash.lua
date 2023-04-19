local mod	= DBM:NewMod("MawTrash", "DBM-Party-Legion", 8)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
--mod:SetEncounterID(1823)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 198405 195031 195293 196885 194099 192019 199589 194657 194442",
	"SPELL_CAST_SUCCESS 195279",
	"SPELL_AURA_APPLIED 195279 200208 194657 194640",
	"SPELL_AURA_REMOVED 195279 200208",
	"SPELL_PERIODIC_DAMAGE 194102",
	"SPELL_PERIODIC_MISSED 194102",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_DIED"
)

--Утроба душ трэш
local warnSixPoundBarrel		= mod:NewTargetAnnounce(194442, 4) --Шестифунтовая бочка
local warnCurseofHope			= mod:NewTargetAnnounce(194640, 2) --Проклятая надежда
local warnSoulSiphon			= mod:NewTargetAnnounce(194657, 4) --Вытягивание души
local warnScream				= mod:NewSpellAnnounce(198405, 4) --Леденящий душу вопль
local warnWhirlpoolSouls		= mod:NewSpellAnnounce(199589, 4) --Водоворот душ

local specWarnSixPoundBarrel	= mod:NewSpecialWarningDodge(194442, nil, nil, nil, 2, 3) --Шестифунтовая бочка
local specWarnSixPoundBarrel2	= mod:NewSpecialWarningTargetDodge(194442, nil, nil, nil, 2, 3) --Шестифунтовая бочка
local specWarnCurseofHope		= mod:NewSpecialWarningYou(194640, nil, nil, nil, 1, 2) --Проклятая надежда
local specWarnSoulSiphon		= mod:NewSpecialWarningInterrupt(194657, "HasInterrupt", nil, nil, 1, 2) --Вытягивание души
local specWarnBrackwaterBlast	= mod:NewSpecialWarningYouDefensive(200208, nil, nil, nil, 3, 5) --Взрыв солоноватой воды
local specWarnLanternDarkness	= mod:NewSpecialWarningDefensive(192019, nil, nil, nil, 3, 5) --Фонарь Тьмы
local specWarnPoisonousSludge	= mod:NewSpecialWarningYouMove(194102, nil, nil, nil, 1, 2) --Ядовитая жижа
local specWarnBind				= mod:NewSpecialWarningYouDefensive(195279, nil, nil, nil, 2, 5) --Связывание
local specWarnScream			= mod:NewSpecialWarningInterrupt(198405, "HasInterrupt", nil, nil, 1, 2) --Леденящий душу вопль
local specWarnDebilitatingShout	= mod:NewSpecialWarningInterrupt(195293, "HasInterrupt", nil, nil, 1, 2) --Истощающий крик
local specWarnWhirlpoolSouls	= mod:NewSpecialWarningInterrupt(199589, "HasInterrupt", nil, nil, 3, 2) --Водоворот душ
local specWarnGiveNoQuarter		= mod:NewSpecialWarningDodge(196885, nil, nil, nil, 2, 3) --Не щадить никого
local specWarnBileBreath		= mod:NewSpecialWarningDodge(194099, nil, nil, nil, 2, 3) --Гнусное дыхание
local specWarnDefiantStrike		= mod:NewSpecialWarningDodge(195031, nil, nil, nil, 1, 2) --Дерзкий удар

local timerLanternDarknessCD	= mod:NewCDTimer(14.5, 192019, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Фонарь Тьмы
local timerBindCD				= mod:NewCDTimer(15, 195279, nil, "Tank", nil, 3, nil, DBM_CORE_TANK_ICON) --Связывание
local timerDebilitatingShoutCD	= mod:NewCDTimer(13.5, 195293, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON) --Истощающий крик
local timerGiveNoQuarterCD		= mod:NewCDTimer(9.7, 196885, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Не щадить никого

local timerRoleplay				= mod:NewTimer(29, "timerRoleplay", "Interface\\Icons\\Spell_Holy_BorrowedTime", nil, nil, 7) --Ролевая игра

local yellSixPoundBarrel		= mod:NewYell(194442, nil, nil, nil, "YELL") --Шестифунтовая бочка

function mod:SixPoundBarrelTarget(targetname, uId) --прошляпанное очко Мурчаля Прошляпенко ✔
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnSixPoundBarrel:Show()
		specWarnSixPoundBarrel:Play("targetyou")
		yellSixPoundBarrel:Yell()
	elseif self:CheckNearby(10, targetname) then
		specWarnSixPoundBarrel2:Show(targetname)
		specWarnSixPoundBarrel2:Play("watchstep")
	else
		warnSixPoundBarrel:CombinedShow(0.5, targetname)
	end
end

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 198405 then
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnScream:Show()
			specWarnScream:Play("kickcast")
		elseif self:AntiSpam(2, 1) then
			warnScream:Show()
			warnScream:Play("kickcast")
		end
	elseif spellId == 195031 and self:AntiSpam(2, 1) then
		if not self:IsNormal() then
			specWarnDefiantStrike:Show()
			specWarnDefiantStrike:Play("chargemove")
		end
	elseif spellId == 195293 and self:AntiSpam(2, 1) then --Истощающий крик
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnDebilitatingShout:Show()
			specWarnDebilitatingShout:Play("kickcast")
		end
		timerDebilitatingShoutCD:Start()
	elseif spellId == 196885 and self:AntiSpam(2, 1) then --Не щадить никого
		if not self:IsNormal() then
			specWarnGiveNoQuarter:Show()
			specWarnGiveNoQuarter:Play("stilldanger")
		end
		timerGiveNoQuarterCD:Start()
	elseif spellId == 194099 then --Гнусное дыхание
		if not self:IsNormal() then
			specWarnBileBreath:Show()
			specWarnBileBreath:Play("stilldanger")
		end
	elseif spellId == 192019 and self:AntiSpam(3, 1) then --Фонарь Тьмы
		timerLanternDarknessCD:Start()
		if not self:IsNormal() then
			specWarnLanternDarkness:Show()
			specWarnLanternDarkness:Play("defensive")
		end
	elseif spellId == 199589 and self:AntiSpam(2, 1) then --Водоворот душ
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnWhirlpoolSouls:Show(args.sourceName)
			specWarnWhirlpoolSouls:Play("kickcast")
		elseif self:AntiSpam(2, 1) then
			warnWhirlpoolSouls:Show()
			warnWhirlpoolSouls:Play("kickcast")
		end
	elseif spellId == 194657 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Вытягивание души
		specWarnSoulSiphon:Show()
		specWarnSoulSiphon:Play("kickcast")
	elseif spellId == 194442 then --Шестифунтовая бочка
		self:BossTargetScanner(args.sourceGUID, "SixPoundBarrelTarget", 0.1, 2)
	end
end
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 195279 then --Связывание
		timerBindCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 195279 then --Связывание
		if not self:IsNormal() then
			if args:IsPlayer() then
				specWarnBind:Show()
				specWarnBind:Play("defensive")
			end
		end
	elseif spellId == 200208 then --Взрыв солоноватой воды
		if not self:IsNormal() then
			if args:IsPlayer() and self:AntiSpam(2, 1) then
				specWarnBrackwaterBlast:Show()
				specWarnBrackwaterBlast:Play("defensive")
			end
		end
	elseif spellId == 194657 then --Вытягивание души
		warnSoulSiphon:CombinedShow(0.3, args.destName)
	elseif spellId == 194640 then --Проклятая надежда
		warnCurseofHope:CombinedShow(0.5, args.destName)
		if not self:IsNormal() then
			if args:IsPlayer() then
				specWarnCurseofHope:Show()
				specWarnBind:Play("targetyou")
			end
		end
	end
end

--[[function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 195279 then

end]]

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Helya then
		timerRoleplay:Start(13)
	--	self:SendSync("RPHelya")
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 194102 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		if not self:IsNormal() then
			specWarnPoisonousSludge:Show()
			specWarnPoisonousSludge:Play("runaway")
		end
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 99307 then --Скьял
		timerGiveNoQuarterCD:Cancel()
		timerDebilitatingShoutCD:Cancel()
		timerBindCD:Cancel()
	elseif cid == 97182 then
		timerLanternDarknessCD:Cancel()
	end
end
