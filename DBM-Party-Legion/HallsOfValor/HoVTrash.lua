local mod	= DBM:NewMod("HoVTrash", "DBM-Party-Legion", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()
mod.isTrashMod = true


mod:RegisterEvents(
	"SPELL_CAST_START 199805 192563 199726 199382 200901 192158 192288 210875 199652 200969 198888 198931 191401 198892",
	"SPELL_CAST_SUCCESS 199382 200901",
	"SPELL_AURA_APPLIED 215430 199652",
	"SPELL_AURA_APPLIED_DOSE 199652",
	"SPELL_AURA_REMOVED 215430 199652",
	"SPELL_PERIODIC_DAMAGE 198959 199818 198903",
	"SPELL_PERIODIC_MISSED 198959 199818 198903",
	"GOSSIP_SHOW",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_DIED"
)

--Чертоги доблести трэш
local warnThunderstrike				= mod:NewTargetAnnounce(215430, 4) --Громовой удар
local warnCrackle					= mod:NewTargetAnnounce(199805, 3) --Разряд
local warnChargedPulse				= mod:NewCastAnnounce(210875, 4) --Пульсирующий заряд
local warnHealingLight				= mod:NewCastAnnounce(198931, 3) --Исцеляющий свет
local warnCracklingStorm			= mod:NewTargetAnnounce(198892, 3) --Грохочущая буря

--local warnPenetratingShot			= mod:NewCastAnnounce(199210, 3) --Пробивающий выстрел

--local specWarnPenetratingShot		= mod:NewSpecialWarningDodge(199210, nil, nil, nil, 2, 3) --Пробивающий выстрел

local specWarnThunderstrike			= mod:NewSpecialWarningYouMoveAway(215430, nil, nil, nil, 3, 5) --Громовой удар
local specWarnThunderstrike2		= mod:NewSpecialWarningCloseMoveAway(215430, nil, nil, nil, 2, 3) --Громовой удар
local specWarnCracklingStorm		= mod:NewSpecialWarningYouRun(198892, nil, nil, nil, 4, 3) --Грохочущая буря
local specWarnCracklingStorm2		= mod:NewSpecialWarningCloseMoveAway(198892, nil, nil, nil, 2, 3) --Грохочущая буря
local specWarnCracklingStorm3		= mod:NewSpecialWarningYouMove(198903, nil, nil, nil, 1, 2) --Грохочущая буря
local specWarnShoot					= mod:NewSpecialWarningYou(191401, nil, nil, nil, 1, 2) --Стремительный выстрел
local specWarnHealingLight			= mod:NewSpecialWarningInterrupt(198931, "HasInterrupt", nil, nil, 1, 2) --Исцеляющий свет
local specWarnLightningBreath		= mod:NewSpecialWarningDodge(198888, nil, nil, nil, 2, 3) --Грозовое дыхание
local specWarnCrackle2				= mod:NewSpecialWarningYouMove(199818, nil, nil, nil, 1, 2) --Разряд
local specWarnEtch					= mod:NewSpecialWarningYouMove(198959, nil, nil, nil, 1, 2) --Гравировка
local specWarnCallAncestor			= mod:NewSpecialWarningSwitch(200969, "Dps", nil, nil, 1, 2) --Зов предков
local specWarnSever					= mod:NewSpecialWarningYouDefensive(199652, "Tank", nil, nil, 3, 5) --Рассечение
local specWarnSever2				= mod:NewSpecialWarningStack(199652, nil, 2, nil, nil, 2, 2) --Рассечение
local specWarnEyeofStorm			= mod:NewSpecialWarningMoveTo(200901, nil, nil, nil, 4, 3) --Око шторма
local specWarnEyeofStorm2			= mod:NewSpecialWarningDefensive(200901, nil, nil, nil, 3, 3) --Око шторма
local specWarnSanctify				= mod:NewSpecialWarningDodge(192158, "Ranged", nil, nil, 2, 5) --Освящение
local specWarnSanctify2				= mod:NewSpecialWarningRun(192158, "Melee", nil, nil, 4, 5) --Освящение
local specWarnChargedPulse			= mod:NewSpecialWarningRun(210875, "Melee", nil, nil, 4, 5) --Пульсирующий заряд
local specWarnChargedPulse2			= mod:NewSpecialWarningDodge(210875, "Ranged", nil, nil, 2, 5) --Пульсирующий заряд

local specWarnEnragingRoar			= mod:NewSpecialWarningDefensive(199382, "Tank", nil, nil, 3, 2) --Яростный рев
local specWarnCrackle				= mod:NewSpecialWarningDodge(199805, nil, nil, nil, 1, 2) --Разряд
local specWarnCleansingFlame		= mod:NewSpecialWarningInterrupt(192563, "HasInterrupt", nil, nil, 1, 2) --Очищающие языки пламени
local specWarnUnrulyYell			= mod:NewSpecialWarningInterrupt(199726, "HasInterrupt", nil, nil, 1, 2) --Буйный вопль
local specWarnSearingLight			= mod:NewSpecialWarningInterrupt(192288, "HasInterrupt", nil, nil, 1, 2) --Опаляющий свет

local timerSever					= mod:NewTargetTimer(12, 199652, nil, "Tank|Healer", nil, 3, nil, DBM_CORE_TANK_ICON) --Рассечение
local timerEnragingRoarCD			= mod:NewCDTimer(25, 199382, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON) --Яростный рев
local timerThunderstrike			= mod:NewTargetTimer(3, 215430, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Громовой удар
--Олмир
local timerSanctifyCD				= mod:NewCDTimer(26.5, 192158, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Освящение
local timerSearingLightCD			= mod:NewCDTimer(13, 192288, nil, "HasInterrupt", nil, 4, nil, DBM_CORE_INTERRUPT_ICON) --Опаляющий свет
--Солстен
local timerEyeofStormCD				= mod:NewCDTimer(31.5, 200901, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Око шторма

local timerRoleplay					= mod:NewTimer(30, "timerRoleplay", "Interface\\Icons\\ability_warrior_offensivestance", nil, nil, 7) --Ролевая игра

local countdownEyeofStorm			= mod:NewCountdown(31.5, 200901, nil, nil, 3) --Око шторма
local countdownSanctify				= mod:NewCountdown("Alt26.5", 192158, nil, nil, 3) --Освящение

local yellCrackle					= mod:NewYell(199805, nil, nil, nil, "YELL") --Разряд
local yellThunderstrike				= mod:NewYell(215430, nil, nil, nil, "YELL") --Громовой удар
local yellThunderstrike2			= mod:NewShortFadesYell(215430, nil, nil, nil, "YELL") --Громовой удар
local yellCracklingStorm			= mod:NewYell(198892, nil, nil, nil, "YELL") --Грохочущая буря

local eyeShortName = DBM:GetSpellInfo(91320)--Inner Eye

mod:AddBoolOption("BossActivation", true)
mod:AddRangeFrameOption(8, 215430) --Громовой удар

function mod:CracklingStormTarget(targetname, uId) --Грохочущая буря ✔
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnCracklingStorm:Show()
		specWarnCracklingStorm:Play("runaway")
		yellCracklingStorm:Yell()
	elseif self:CheckNearby(10, targetname) then
		specWarnCracklingStorm2:Show(targetname)
		specWarnCracklingStorm2:Play("runout")
	else
		warnCracklingStorm:Show(targetname)
	end
end

function mod:ShootTarget(targetname, uId) --Выстрел ✔
	if not targetname then return end
	if self:AntiSpam(2, targetname) then
		if targetname == UnitName("player") then
			if self:IsHard() then
				specWarnShoot:Show()
				specWarnShoot:Play("watchstep")
			end
		end
	end
end

function mod:CrackleTarget(targetname, uId)
	if not targetname then
		warnCrackle:Show(DBM_CORE_UNKNOWN)
		return
	end
	if targetname == UnitName("player") then
		specWarnCrackle:Show()
		specWarnCrackle:Play("watchstep")
		yellCrackle:Yell()
	else
		warnCrackle:Show(targetname)
	end
end

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 199805 then
		self:BossTargetScanner(args.sourceGUID, "CrackleTarget", 0.1, 9)
	elseif spellId == 192563 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnCleansingFlame:Show()
		specWarnCleansingFlame:Play("kickcast")
	elseif spellId == 199726 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnUnrulyYell:Show()
		specWarnUnrulyYell:Play("kickcast")
	elseif spellId == 192288 then --Опаляющий свет
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnSearingLight:Show()
			specWarnSearingLight:Play("kickcast")
		end
		timerSearingLightCD:Start()
	elseif spellId == 199382 then
		timerEnragingRoarCD:Start()
	elseif spellId == 200901 then --Око шторма
		if not UnitIsDeadOrGhost("player") then
			specWarnEyeofStorm:Show(eyeShortName)
			specWarnEyeofStorm:Play("findshelter")
		end
		timerEyeofStormCD:Start()
		countdownEyeofStorm:Start()
	elseif spellId == 192158 then --Освящение
		if not UnitIsDeadOrGhost("player") then
			specWarnSanctify2:Show()
			specWarnSanctify2:Play("watchorb")
			specWarnSanctify:Show()
			specWarnSanctify:Play("watchorb")
		end
		timerSanctifyCD:Start()
		countdownSanctify:Start()
	elseif spellId == 210875 and self:AntiSpam(2, 1) then --Пульсирующий заряд
		warnChargedPulse:Show()
		specWarnChargedPulse:Show()
		specWarnChargedPulse:Play("justrun")
		specWarnChargedPulse2:Show()
		specWarnChargedPulse2:Play("watchstep")
	elseif spellId == 199652 and self:AntiSpam(2, 2) then --Рассечение
		specWarnSever:Show()
		specWarnSever:Play("defensive")
	elseif spellId == 200969 and self:AntiSpam(3, 3) then --Зов предков
		if not UnitIsDeadOrGhost("player") then
			specWarnCallAncestor:Show()
			specWarnCallAncestor:Play("mobkill")
		end
	elseif spellId == 198888 then --Грозовое дыхание
		specWarnLightningBreath:Show()
		specWarnLightningBreath:Play("watchstep")
	elseif spellId == 198931 and self:AntiSpam(2, 4) then --Исцеляющий свет
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnHealingLight:Show()
			specWarnHealingLight:Play("kickcast")
		else
			warnHealingLight:Show()
			warnHealingLight:Play("kickcast")
		end
	elseif spellId == 191401 then --Стремительный выстрел
		self:BossTargetScanner(args.sourceGUID, "ShootTarget", 0.1, 2)
	elseif spellId == 198892 then --Грохочущая буря
		self:BossTargetScanner(args.sourceGUID, "CracklingStormTarget", 0.1, 2)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 199382 then --Яростный рев
		specWarnEnragingRoar:Show()
		specWarnEnragingRoar:Play("defensive")
	elseif spellId == 200901 then --Око шторма
		if not UnitIsDeadOrGhost("player") then
			specWarnEyeofStorm2:Show()
			specWarnEyeofStorm2:Play("defensive")
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if args.spellId == 215430 then --Громовой удар
		warnThunderstrike:CombinedShow(0.5, args.destName)
		timerThunderstrike:Start(args.destName)
		if not self:IsNormal() then
			if args:IsPlayer() then
				specWarnThunderstrike:Show()
				specWarnThunderstrike:Play("runout")
				yellThunderstrike:Yell()
				yellThunderstrike2:Countdown(3, 2)
			elseif self:CheckNearby(10, args.destName) then
				specWarnThunderstrike2:CombinedShow(0.3, args.destName)
				specWarnThunderstrike2:Play("watchstep")
			end
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(8)
		end
	elseif spellId == 199652 then --Рассечение
		local amount = args.amount or 1
		if args:IsPlayer() then
			if amount >= 2 then
				specWarnSever2:Show(amount)
				specWarnSever2:Play("stackhigh")
			end
		end
		timerSever:Start(args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 215430 then --Громовой удар
		timerThunderstrike:Cancel(args.destName)
		if args:IsPlayer() then
			yellThunderstrike2:Cancel()
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif spellId == 199652 then --Рассечение
		timerSever:Cancel(args.destName)
	end
end

function mod:GOSSIP_SHOW()
	local guid = UnitGUID("npc")
	if not guid then return end
	local cid = self:GetCIDFromGUID(guid)
	if mod.Options.BossActivation then --Прошляпанное очко Мурчаля Прошляпенко ✔
		if cid == 97081 or cid == 95843 or cid == 97083 or cid == 97084 then --Король Бьорн, Король Галдор, Король Ранульф, Король Тор
			if select('#', GetGossipOptions()) > 0 then
				SelectGossipOption(1)
				CloseGossip()
			end
		elseif cid == 95676 then --Один
			if select('#', GetGossipOptions()) > 0 then
				SelectGossipOption(1, "", true)
				self:SendSync("RPOdyn2")
			end
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.RPSkovald then
		timerRoleplay:Start(33.5)
	elseif msg == L.RPOdyn then
		timerRoleplay:Start(25.5)
	elseif msg == L.RPSolsten then
		timerEyeofStormCD:Start(9)
		countdownEyeofStorm:Start(9)
	elseif msg == L.RPSolsten2 then
		timerEyeofStormCD:Cancel()
		countdownEyeofStorm:Cancel()
	elseif msg == L.RPOlmyr then
		timerSanctifyCD:Start(9.5)
		countdownSanctify:Start(9.5)
		timerSearingLightCD:Start(5.5)
	elseif msg == L.RPOlmyr2 then
		timerSanctifyCD:Cancel()
		countdownSanctify:Cancel()
		timerSearingLightCD:Cancel()
	end
end

function mod:OnSync(msg)
	if msg == "RPOdyn2" then
		timerRoleplay:Start(2.8)
		countdownEyeofStorm:Start(2.8)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 198959 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then --Гравировка
		if self:IsHard() then
			specWarnEtch:Show()
			specWarnEtch:Play("runaway")
		end
	elseif spellId == 199818 and destGUID == UnitGUID("player") and self:AntiSpam(3, 1) then --Разряд
		if self:IsHard() then
			specWarnCrackle2:Show()
			specWarnCrackle2:Play("runaway")
		end
	elseif spellId == 198903 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then --Грохочущая буря
		if self:IsHard() then
			specWarnCracklingStorm3:Show()
			specWarnCracklingStorm3:Play("runaway")
		end
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 99802 then --Артфаэль
		timerEnragingRoarCD:Cancel()
	end
end
