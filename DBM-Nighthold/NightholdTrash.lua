local mod	= DBM:NewMod("NightholdTrash", "DBM-Nighthold")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17522 $"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()
mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 221164 224510 224246 231005 143807 231737 224440",
	"SPELL_CAST_SUCCESS 225389",
	"SPELL_AURA_APPLIED 221344 222111 224572 225390 224632 224560 204744 224978 225856 223655 224982 225105 222079 225845",
	"SPELL_AURA_APPLIED_DOSE 222079",
	"GOSSIP_SHOW",
	"CHAT_MSG_MONSTER_YELL"
)

--TODO, add arcane blast when i remember to log/get spellID
local warnCelestialBrand			= mod:NewTargetAnnounce(224560, 2) --Небесное клеймо
local warnArcaneRelease				= mod:NewTargetAnnounce(225105, 2)
local warnChosenFate				= mod:NewTargetAnnounce(225845, 2, nil, false, 2)
local warnOozingRush				= mod:NewTargetAnnounce(223655, 2)
local warnFelGlare					= mod:NewTargetAnnounce(224982, 2)

local specWarnCrushingStomp			= mod:NewSpecialWarningRun(224440, nil, nil, nil, 4, 2)
local specWarnAnnihilatingOrb		= mod:NewSpecialWarningYouMoveAway(221344, nil, nil, nil, 4, 3) --Сфера аннигиляции
local specWarnAnnihilatingOrb2		= mod:NewSpecialWarningTargetDodge(221344, nil, nil, nil, 2, 2) --Сфера аннигиляции
local specWarnFulminate				= mod:NewSpecialWarningRun(221164, "Melee", nil, nil, 4, 2)
local specWarnCracklingSlice		= mod:NewSpecialWarningDodge(224510, "Tank", nil, nil, 1, 2)
local specWarnArcaneEmanations		= mod:NewSpecialWarningDodge(231005, "Tank", nil, nil, 1, 2)
local specWarnProtectiveShield		= mod:NewSpecialWarningMove(224510, "Tank", nil, nil, 1, 2)
local specWarnRoilingFlame			= mod:NewSpecialWarningMove(222111, nil, nil, nil, 1, 2)
local specWarnDisruptingEnergy		= mod:NewSpecialWarningMove(224572, nil, nil, nil, 1, 2)
local specWarnStellarDust			= mod:NewSpecialWarningMove(225390, nil, nil, nil, 1, 2)
local specWarnToxicChit				= mod:NewSpecialWarningMove(204744, nil, nil, nil, 1, 2)
local specWarnInfiniteAbyss			= mod:NewSpecialWarningYouMove(224978, nil, nil, nil, 1, 2)
local specWarnPoisonBrambles		= mod:NewSpecialWarningYouMove(225856, nil, nil, nil, 1, 2)
local specWarnArcWell				= mod:NewSpecialWarningSwitch(224246, "Dps", nil, nil, 1, 6)
local specWarnCelestialBrand		= mod:NewSpecialWarningYouMoveAway(224560, nil, nil, nil, 5, 2) --Небесное клеймо
local specWarnArcaneRelease			= mod:NewSpecialWarningMoveAway(225105, nil, nil, nil, 1, 2)
local specWarnArcaneBlast			= mod:NewSpecialWarningInterrupt(143807, "HasInterrupt", nil, 2, 3, 2)
local specWarnHeavenlyCrash			= mod:NewSpecialWarningMoveTo(224632, nil, nil, nil, 1, 2) --Небесное сокрушение
local specWarnChosenFate			= mod:NewSpecialWarningReflect(225845, nil, nil, nil, 1, 2)
local specWarnOozingRush			= mod:NewSpecialWarningRun(223655, nil, nil, nil, 4, 2)
local specWarnFelGlare				= mod:NewSpecialWarningMoveAway(224982, nil, nil, nil, 1, 2)
local specWarnSearingWounds			= mod:NewSpecialWarningStack(222079, nil, 4, nil, 2, 1, 6)--Lets go with 4 for now
local specWarnSearingWoundsOther	= mod:NewSpecialWarningTaunt(222079, nil, nil, nil, 1, 2)
local specWarnNightwellDischarge	= mod:NewSpecialWarningDodge(231737, nil, nil, nil, 1, 2)

local timerSearingWounds			= mod:NewTargetTimer(20, 222079, nil, "Tank", nil, 5)
local timerRP						= mod:NewRPTimer(68)

local yellAnnihilatingOrb			= mod:NewYellMoveAway(221344, nil, nil, nil, "YELL") --Сфера аннигиляции
local yellCelestialBrand			= mod:NewYell(224560, nil, nil, nil, "YELL") --Небесное клеймо
local yellArcaneRelease				= mod:NewYell(225105, nil, nil, nil, "YELL")
local yellOozingRush				= mod:NewYell(223655, nil, nil, nil, "YELL")
local yellFelGlareh					= mod:NewYell(224982, nil, nil, nil, "YELL")
local yellHeavenlyCrash				= mod:NewYellHelp(224632, nil, nil, nil, "YELL") --Небесное сокрушение
local yellHeavenlyCrash2			= mod:NewFadesYell(224632, nil, nil, nil, "YELL") --Небесное сокрушение

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 221164 and self:AntiSpam(5, 1) then
		specWarnFulminate:Show()
		specWarnFulminate:Play("runout")
	elseif spellId == 224510 and self:AntiSpam(3, 2) then
		specWarnCracklingSlice:Show()
		specWarnCracklingSlice:Play("shockwave")
	elseif spellId == 231005 then
		specWarnArcaneEmanations:Show()
		specWarnArcaneEmanations:Play("shockwave")
	elseif spellId == 143807 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnArcaneBlast:Show(args.sourceName)
		specWarnArcaneBlast:Play("kickcast")
	elseif spellId == 231737 and self:AntiSpam(4, 4) then
		specWarnNightwellDischarge:Show()
		specWarnNightwellDischarge:Play("watchorb")
	elseif spellId == 224440 then
		specWarnCrushingStomp:Show()
		specWarnCrushingStomp:Play("justrun")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 225389 and self:AntiSpam(3, 3) then
		specWarnProtectiveShield:Show()
		specWarnProtectiveShield:Play("runout")
	elseif spellId == 224246 then
		specWarnArcWell:Show()
		specWarnArcWell:Play("killtotem")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 221344 then --Сфера аннигиляции
		if args:IsPlayer() then
			specWarnAnnihilatingOrb:Show()
			specWarnAnnihilatingOrb:Play("runout")
			yellAnnihilatingOrb:Yell()
		else
			specWarnAnnihilatingOrb2:Show(args.destName)
		end
	elseif spellId == 222111 and args:IsPlayer() then
		specWarnRoilingFlame:Show()
		specWarnRoilingFlame:Play("runaway")
	elseif spellId == 224572 and args:IsPlayer() then
		specWarnDisruptingEnergy:Show()
		specWarnDisruptingEnergy:Play("runaway")
	elseif spellId == 225390 and args:IsPlayer() then
		specWarnStellarDust:Show()
		specWarnStellarDust:Play("runaway")
	elseif spellId == 204744 and args:IsPlayer() then
		specWarnToxicChit:Show()
		specWarnToxicChit:Play("runaway")
	elseif spellId == 224978 and args:IsPlayer() then
		specWarnInfiniteAbyss:Show()
		specWarnInfiniteAbyss:Play("runaway")
	elseif spellId == 225856 and args:IsPlayer() then
		specWarnPoisonBrambles:Show()
		specWarnPoisonBrambles:Play("runaway")
	elseif spellId == 224632 then --Небесное сокрушение
		if args:IsPlayer() then
			yellHeavenlyCrash:Yell()
			yellHeavenlyCrash2:Countdown(5, 3)
		else
			specWarnHeavenlyCrash:Show(args.destName)
			specWarnHeavenlyCrash:Play("gathershare")
		end
	elseif spellId == 224560 then --Небесное клеймо
		warnCelestialBrand:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnCelestialBrand:Show()
			specWarnCelestialBrand:Play("runaway")
			yellCelestialBrand:Yell()
		end
	elseif spellId == 225105 then
		warnArcaneRelease:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnArcaneRelease:Show()
			specWarnArcaneRelease:Play("runout")
			yellArcaneRelease:Yell()
		end
	elseif spellId == 223655 then
		if args:IsPlayer() then
			specWarnOozingRush:Show()
			specWarnOozingRush:Play("runaway")
			specWarnOozingRush:ScheduleVoice(1, "keepmove")
			yellOozingRush:Yell()
		else
			warnOozingRush:Show(args.destName)
		end
	elseif spellId == 224982 then
		if args:IsPlayer() then
			specWarnFelGlare:Show()
			specWarnFelGlare:Play("runout")
			specWarnFelGlare:ScheduleVoice(1, "keepmove")
			yellFelGlareh:Yell()
		else
			warnFelGlare:Show(args.destName)
		end
	elseif spellId == 225845 then
		warnChosenFate:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			specWarnChosenFate:Show()
			specWarnChosenFate:Play("stopattack")
		end
	elseif spellId == 222079 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			timerSearingWounds:Start(args.destName)
			if amount >= 2 then
				if args:IsPlayer() then
					if amount >= 4 then
						specWarnSearingWounds:Show(amount)
						specWarnSearingWounds:Play("stackhigh")
					end
				else
					if not DBM:UnitDebuff("player", args.spellName) and not UnitIsDeadOrGhost("player") then
						specWarnSearingWoundsOther:Show(args.destName)
						specWarnSearingWoundsOther:Play("changemt")
					end
				end
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:GOSSIP_SHOW()
	local guid = UnitGUID("npc")
	if not guid then return end
	local cid = self:GetCIDFromGUID(guid)
	--110677 Проекция Кадгара, 116662 Сурамарский портал, 116670 Сурамарский портал, 116820 Сурамарский портал, 116667 Сурамарский портал, 116819 Сурамарский портал
	if cid == 110677 or cid == 116662 or cid == 116670 or cid == 116820 or cid == 116667 or cid == 116819 then
		if GetNumGossipOptions() == 1 then
			SelectGossipOption(1)
			CloseGossip()
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.prePullRP1 or msg:find(L.prePullRP1) then --Элисанда
		self:SendSync("ElisandeRP")
	elseif msg == L.prePullRP2 or msg:find(L.prePullRP2) then --Гулдан
		self:SendSync("GuldanRP")
	end
end

function mod:OnSync(msg)
	if msg == "ElisandeRP" then
		timerRP:Start()
	elseif msg == "GuldanRP" then
		timerRP:Start(77) -- точно как минимум под обычку
	end
end
