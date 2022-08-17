local mod	= DBM:NewMod("BRHTrash", "DBM-Party-Legion", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 200261 221634 221688 225573 214003 221132 220918 200248 221363 221380 200343 193633 200291",
	"SPELL_AURA_APPLIED 194966 221132 221363 225909",
	"SPELL_AURA_APPLIED_DOSE 225909",
	"SPELL_AURA_REMOVED 194966 221132 221363",
	"SPELL_CAST_SUCCESS 200343 200345 220918",
--	"SPELL_PERIODIC_DAMAGE 226512",
--	"SPELL_PERIODIC_MISSED 226512",
	"UNIT_DIED",
	"CHAT_MSG_MONSTER_SAY"
)

--Крепость Черной Ладьи треш
--local warnShoot						= mod:NewTargetAnnounce(193633, 3) --Выстрел
local warnSoulEchoes				= mod:NewTargetAnnounce(194966, 3) --Эхо души
local warnArcaneOvercharge			= mod:NewTargetAnnounce(221132, 4) --Чародейская перезарядка
local warnOverwhelmingRelease		= mod:NewSpellAnnounce(220918, 4) --Высвобождение мощи
local warnRupturingPoison			= mod:NewTargetAnnounce(221363, 4) --Раздирающий яд
local warnMandibleStrike			= mod:NewTargetAnnounce(221380, 4) --Удар жвалами
local warnSoulVenom					= mod:NewStackAnnounce(225909, 4, nil, nil, 2) --Отравленная душа
local warnDarkMending				= mod:NewCastAnnounce(225573, 3) --Исцеление тьмой
local warnArcaneBlitz				= mod:NewCastAnnounce(200248, 3) --Чародейская бомбардировка
local warnKnifeDance				= mod:NewSpellAnnounce(200291, 4) --Танец с кинжалами
--
local specWarnShoot					= mod:NewSpecialWarningYou(193633, nil, nil, nil, 1, 2) --Выстрел
local specWarnSoulVenom				= mod:NewSpecialWarningStack(225909, nil, 5, nil, nil, 1, 2) --Отравленная душа
local specWarnSoulVenom2			= mod:NewSpecialWarningDispel(225909, "MagicDispeller2", nil, nil, 1, 3) --Отравленная душа
local specWarnMandibleStrike		= mod:NewSpecialWarningYouDefensive(221380, nil, nil, nil, 2, 2) --Удар жвалами
local specWarnRupturingPoison		= mod:NewSpecialWarningYouMoveAway(221363, nil, nil, nil, 3, 2) --Раздирающий яд
local specWarnRupturingPoison2		= mod:NewSpecialWarningCloseMoveAway(221363, nil, nil, nil, 2, 2) --Раздирающий яд
local specWarnArcaneBlitz			= mod:NewSpecialWarningInterrupt(200248, "HasInterrupt", nil, nil, 1, 2) --Чародейская бомбардировка
local specWarnOverwhelmingRelease	= mod:NewSpecialWarningDodge(220918, nil, nil, nil, 2, 2) --Высвобождение мощи
local specWarnArcaneOvercharge		= mod:NewSpecialWarningYouMoveAway(221132, nil, nil, nil, 3, 2) --Чародейская перезарядка
local specWarnArcaneOvercharge2		= mod:NewSpecialWarningCloseMoveAway(221132, nil, nil, nil, 2, 2) --Чародейская перезарядка
local specWarnSoulEchoes			= mod:NewSpecialWarningCloseMoveAway(194966, nil, nil, nil, 2, 2) --Эхо души
local specWarnCoupdeGrace			= mod:NewSpecialWarningDefensive(214003, "Tank", nil, nil, 1, 2) --Удар Милосердия
local specWarnBonebreakingStrike	= mod:NewSpecialWarningDodge(200261, "Melee", nil, nil, 2, 2) --Костедробильный удар
local specWarnSoulEchos				= mod:NewSpecialWarningYouMoveAway(194966, nil, nil, nil, 3, 2) --Эхо души
local specWarnArrowBarrage			= mod:NewSpecialWarningDodge(200343, nil, nil, nil, 2, 2) --Залп стрел
--Braxas the Fleshcarver
local specWarnWhirlOfFlame			= mod:NewSpecialWarningDodge(221634, nil, nil, nil, 2, 2) --Вихрь пламени
local specWarnOverDetonation		= mod:NewSpecialWarningRun(221688, nil, nil, nil, 4, 2) --Мощная детонация
local specWarnDarkMending			= mod:NewSpecialWarningInterrupt(225573, "HasInterrupt", nil, nil, 1, 2) --Исцеление тьмой
--Вдова
local timerMandibleStrikeCD			= mod:NewCDTimer(16, 221380, nil, nil, nil, 3, nil) --Удар жвалами
local timerRupturingPoisonCD		= mod:NewCDTimer(10, 221363, nil, nil, nil, 3, nil) --Раздирающий яд
local timerRupturingPoison			= mod:NewTargetTimer(6, 221363, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Раздирающий яд
--Верховный маг
--local timerArcaneBlitzCD			= mod:NewCDTimer(30, 200248, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Чародейская бомбардировка
local timerOverwhelmingReleaseCD	= mod:NewCDTimer(25, 221132, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Высвобождение мощи
local timerArcaneOverchargeCD		= mod:NewCDTimer(20, 221132, nil, nil, nil, 3, nil) --Чародейская перезарядка
local timerArcaneOvercharge			= mod:NewTargetTimer(6, 221132, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Чародейская перезарядка

local timerRoleplay					= mod:NewTimer(25, "timerRoleplay", "Interface\\Icons\\Spell_Holy_BorrowedTime", nil, nil, 7) --Ролевая игра

local yellRupturingPoison			= mod:NewYell(221363, nil, nil, nil, "YELL") --Раздирающий яд
local yellRupturingPoisonFades		= mod:NewFadesYell(221363, nil, nil, nil, "YELL") --Раздирающий яд
local yellSoulEchoes				= mod:NewYell(194966, nil, nil, nil, "YELL") --Эхо души
local yellArcaneOvercharge			= mod:NewYell(221132, nil, nil, nil, "YELL") --Чародейская перезарядка
local yellArcaneOverchargeFades		= mod:NewFadesYell(221132, nil, nil, nil, "YELL") --Чародейская перезарядка
local yellArrowBarrage				= mod:NewYell(200343, nil, nil, nil, "YELL") --Залп стрел

mod:AddRangeFrameOption(6)

function mod:ShootTarget(targetname, uId) --Выстрел ✔
	if not targetname then return end
	if self:AntiSpam(2, targetname) then
		if targetname == UnitName("player") then
			specWarnShoot:Show()
			specWarnShoot:Play("watchstep")
		end
	end
end

function mod:MandibleStrikeTarget(targetname, uId) --Удар жвалами ✔
	if not targetname then return end
	warnMandibleStrike:Show(targetname)
	if targetname == UnitName("player") then
		specWarnMandibleStrike:Show()
		specWarnMandibleStrike:Play("defensive")
	end
end

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 200261 and self:AntiSpam(2, 1) then
		specWarnBonebreakingStrike:Show()
		specWarnBonebreakingStrike:Play("shockwave")
	elseif spellId == 221634 then
		specWarnWhirlOfFlame:Show()
		specWarnWhirlOfFlame:Play("watchstep")
	elseif spellId == 221688 then
		specWarnOverDetonation:Show()
		specWarnOverDetonation:Play("runout")
	elseif spellId == 225573 and self:AntiSpam(3, 1) then --Исцеление тьмой
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnDarkMending:Show()
			specWarnDarkMending:Play("kickcast")
		else
			warnDarkMending:Show()
			warnDarkMending:Play("kickcast")
		end
	elseif spellId == 214003 and self:AntiSpam(3, 4) then
		specWarnCoupdeGrace:Show()
		specWarnCoupdeGrace:Play("defensive")
	elseif spellId == 221132 then --Чародейская перезарядка
		timerArcaneOverchargeCD:Start()
	elseif spellId == 220918 then --Высвобождение мощи
		warnOverwhelmingRelease:Show()
		specWarnOverwhelmingRelease:Show()
		timerOverwhelmingReleaseCD:Start()
	elseif spellId == 200248 and self:AntiSpam(3, 1) then --Чародейская бомбардировка
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnArcaneBlitz:Show()
			specWarnArcaneBlitz:Play("kickcast")
		else
			warnArcaneBlitz:Show()
			warnArcaneBlitz:Play("kickcast")
		end
	elseif spellId == 221363 then --Раздирающий яд
		timerRupturingPoisonCD:Start()
	elseif spellId == 221380 then --Удар жвалами
		self:BossTargetScanner(args.sourceGUID, "MandibleStrikeTarget", 0.1, 2)
		timerMandibleStrikeCD:Start()
	elseif spellId == 200343 then --Залп стрел
		if self:AntiSpam(3, 2) then
			specWarnArrowBarrage:Show(args.destName)
			specWarnArrowBarrage:Play("stilldanger")
		end
		if args:IsPlayer() and self:AntiSpam(3, 3) then
			yellArrowBarrage:Yell()
		end
	elseif spellId == 193633 then --Выстрел
		self:BossTargetScanner(args.sourceGUID, "ShootTarget", 0.1, 2)
	elseif spellId == 200291 and self:AntiSpam(2, 1) then --Танец с кинжалами
		warnKnifeDance:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 194966 then
		if args:IsPlayer() then
			yellSoulEchoes:Yell()
			specWarnSoulEchos:Show()
			specWarnSoulEchos:Play("runaway")
			specWarnSoulEchos:ScheduleVoice(1, "keepmove")
		else
			warnSoulEchoes:Show(args.destName)
			specWarnSoulEchoes:Show(args.destName)
		end
	elseif spellId == 221132 then --Чародейская перезарядка
		warnArcaneOvercharge:Show(args.destName)
		timerArcaneOvercharge:Start(args.destName)
		if args:IsPlayer() then
			specWarnArcaneOvercharge:Show()
			specWarnArcaneOvercharge:Play("runaway")
			yellArcaneOvercharge:Yell()
			yellArcaneOverchargeFades:Countdown(6, 3)
		elseif self:CheckNearby(6, args.destName) then
			specWarnArcaneOvercharge2:Show(args.destName)
			specWarnArcaneOvercharge2:Play("runaway")
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(6)
		end
	elseif spellId == 221363 then --Раздирающий яд
		warnRupturingPoison:CombinedShow(0.5, args.destName)
		timerRupturingPoison:Start(args.destName)
		if args:IsPlayer() then
			specWarnRupturingPoison:Show()
			specWarnRupturingPoison:Play("runaway")
			yellRupturingPoison:Yell()
			yellRupturingPoisonFades:Countdown(6, 3)
		elseif self:CheckNearby(6, args.destName) then
			specWarnRupturingPoison2:Show(args.destName)
			specWarnRupturingPoison2:Play("runaway")
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(6)
		end
	elseif spellId == 225909 then --Отравленная душа
		local amount = args.amount or 1
		if self:IsHard() then
			if args:IsPlayer() and self:IsTank() then
				if amount >= 10 and amount % 5 == 0 then
					specWarnSoulVenom:Show(amount)
					specWarnSoulVenom:Play("stackhigh")
				end
			elseif args:IsPlayer() and not self:IsTank() then
				if amount >= 5 and amount % 5 == 0 then
					specWarnSoulVenom:Show(amount)
					specWarnSoulVenom:Play("stackhigh")
				end
			elseif not args:IsPlayer() then
				if amount >= 5 and amount % 5 == 0 then
					warnSoulVenom:Show(args.destName, amount)
					specWarnSoulVenom2:CombinedShow(0.5, args.destName)
					specWarnSoulVenom2:Play("dispelnow")
				end
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 221132 then --Чародейская перезарядка
		timerArcaneOvercharge:Cancel(args.destName)
		if args:IsPlayer() then
			yellArcaneOverchargeFades:Cancel(args.destName)
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif spellId == 221363 then --Раздирающий яд
		timerRupturingPoison:Cancel(args.destName)
		if args:IsPlayer() then
			yellRupturingPoisonFades:Cancel(args.destName)
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 111068 then --Верховный маг Галеорн https://ru.wowhead.com/npc=111068/верховный-маг-галеорн
		timerOverwhelmingReleaseCD:Cancel()
		timerArcaneOverchargeCD:Cancel()
	elseif cid == 98637 then --Древняя вдова https://ru.wowhead.com/npc=98637/древняя-вдова
		timerRupturingPoisonCD:Cancel()
		timerMandibleStrikeCD:Cancel()
	end
end

function mod:OnSync(msg)
	if msg == "RP1" then
		timerRoleplay:Start()
	end
end

function mod:CHAT_MSG_MONSTER_SAY(msg)
	if msg == L.RP1 then
		self:SendSync("RP1")
	end
end
