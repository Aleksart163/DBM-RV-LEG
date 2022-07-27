local mod	= DBM:NewMod(1983, "DBM-AntorusBurningThrone", nil, 946)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(122366)
mod:SetEncounterID(2069)
mod:SetZone()
--mod:SetBossHPInfoToHighest()
mod:SetUsedIcons(8, 4, 3)
mod:SetHotfixNoticeRev(17238)
mod.respawnTime = 29

mod:RegisterCombat("combat")
--mod:RegisterCombat("combat_yell", L.YellPullVarimathras)
--mod:RegisterCombat("combat_yell", L.YellPullVarimathras2)

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 243960 244093 243999 257644 244042",
	"SPELL_AURA_APPLIED 243961 244042 244094 248732 243968 243977 243980 243973",
	"SPELL_AURA_REMOVED 244042 244094",
	"SPELL_PERIODIC_DAMAGE 244005 248740",
	"SPELL_PERIODIC_MISSED 244005 248740"
)

--TODO, on phase changes most ability CDs extended by 2+ seconds, but NOT ALWAYS so difficult to hard code a rule for it right now
--[[
(ability.id = 243960 or ability.id = 244093 or ability.id = 243999 or ability.id = 244042 or ability.id = 257644) and type = "cast"
 or (ability.id = 243968 or ability.id = 243977 or ability.id = 243980 or ability.id = 243973) and type = "applydebuff" and target.name = "Omegal"
 or ability.id = 26662
--]]
--Torments of the Shivarra
local warnTormentofFlames				= mod:NewSpellAnnounce(243967, 2, nil, nil, nil, nil, nil, 2) --Пытка огнем
local warnTormentofFrost				= mod:NewSpellAnnounce(243976, 2, nil, nil, nil, nil, nil, 2) --Пытка холодом
local warnTormentofFel					= mod:NewSpellAnnounce(243979, 2, nil, nil, nil, nil, nil, 2) --Пытка скверной
local warnTormentofShadows				= mod:NewSpellAnnounce(243974, 2, nil, nil, nil, nil, nil, 2) --Пытка тьмой
--The Fallen Nathrezim
local warnShadowStrike					= mod:NewSpellAnnounce(243960, 2, nil, "Tank", 2) --Теневой удар Doesn't need special warning because misery should trigger special warning at same time
local warnMarkedPrey					= mod:NewTargetAnnounce(244042, 3) --Метка жертвы
local warnNecroticEmbrace				= mod:NewTargetAnnounce(244094, 4) --Некротические объятия
local warnEchoesofDoom					= mod:NewTargetAnnounce(248732, 3) --Отголоски гибели

--Torments of the Shivarra
local specWarnGTFO						= mod:NewSpecialWarningYouMove(244005, nil, nil, nil, 1, 2) --Темный разлом
local specWarnGTFO2						= mod:NewSpecialWarningYouMove(248740, nil, nil, nil, 1, 2) --Отголоски гибели
--The Fallen Nathrezim
local specWarnMisery					= mod:NewSpecialWarningYou(243961, nil, nil, nil, 1, 2) --Страдания
local specWarnMiseryTaunt				= mod:NewSpecialWarningTaunt(243961, nil, nil, nil, 1, 2) --Страдания
local specWarnDarkFissure				= mod:NewSpecialWarningDodge(243999, nil, nil, nil, 2, 2) --Темный разлом
local specWarnMarkedPrey				= mod:NewSpecialWarningYou(244042, nil, nil, 2, 1, 2) --Метка жертвы
local specWarnNecroticEmbrace			= mod:NewSpecialWarningYouMoveAway(244094, nil, nil, nil, 3, 5) --Некротические объятия
local specWarnNecroticEmbrace3			= mod:NewSpecialWarningYouMoveAwayPos(244094, nil, nil, 3, 3, 5) --Некротические объятия
local specWarnNecroticEmbrace4			= mod:NewSpecialWarningEnd(244094, nil, nil, nil, 1, 2) --Некротические объятия
--local specWarnNecroticEmbrace2			= mod:NewSpecialWarningCloseMoveAway(244094, nil, nil, nil, 2, 5) --Некротические объятия
local specWarnEchoesOfDoom				= mod:NewSpecialWarningYou(248732, nil, nil, nil, 1, 2) --Отголоски гибели
--Torments of the Shivarra
mod:AddTimerLine(GENERAL)
local timerTormentofFlamesCD			= mod:NewNextTimer(5, 243967, nil, nil, nil, 6, nil, DBM_CORE_HEALER_ICON) --Пытка огнем
local timerTormentofFrostCD				= mod:NewNextTimer(61, 243976, nil, nil, nil, 6, nil, DBM_CORE_HEALER_ICON) --Пытка холодом
local timerTormentofFelCD				= mod:NewNextTimer(61, 243979, nil, nil, nil, 6, nil, DBM_CORE_HEALER_ICON) --Пытка скверной
local timerTormentofShadowsCD			= mod:NewNextTimer(61, 243974, nil, nil, nil, 6, nil, DBM_CORE_HEALER_ICON) --Пытка тьмой
--The Fallen Nathrezim
mod:AddTimerLine(BOSS)
local timerShadowStrikeCD				= mod:NewCDTimer(8.5, 243960, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON) --Теневой удар 8.5-14 (most of time it's 9.7 or more, But lowest has to be used
local timerDarkFissureCD				= mod:NewCDTimer(32, 243999, nil, nil, nil, 2) --Темный разлом 32-33
local timerMarkedPreyCD					= mod:NewNextTimer(30.5, 244042, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Метка жертвы
local timerNecroticEmbraceCD			= mod:NewNextTimer(30, 244093, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON..DBM_CORE_MYTHIC_ICON) --Некротические объятия

local yellMarkedPrey					= mod:NewYell(244042, nil, nil, nil, "YELL") --Метка жертвы
local yellMarkedPreyFades				= mod:NewShortFadesYell(244042, nil, nil, nil, "YELL") --Метка жертвы
local yellNecroticEmbrace2				= mod:NewYell(244094, nil, nil, nil, "YELL") --Некротические объятия
local yellNecroticEmbrace				= mod:NewPosYell(244094, nil, nil, nil, "YELL") --Некротические объятия
local yellNecroticEmbrace3				= mod:NewFadesYell(244094, nil, nil, nil, "YELL") --Некротические объятия
local yellNecroticEmbraceFades			= mod:NewIconFadesYell(244094, nil, nil, nil, "YELL") --Некротические объятия
local yellEchoesOfDoom					= mod:NewYell(248732, nil, nil, nil, "YELL") --Отголоски гибели

local berserkTimer						= mod:NewBerserkTimer(390)

--The Fallen Nathrezim
local countdownShadowStrike				= mod:NewCountdown("Alt9", 243960, "Tank", nil, 3) --Теневой удар
local countdownMarkedPrey				= mod:NewCountdown("AltTwo30", 244042, nil, nil, 5) --Метка жертвы
local countdownNecroticEmbrace			= mod:NewCountdown(30, 244093, nil, nil, 5) --Некротические объятия

mod:AddSetIconOption("SetIconOnMarkedPrey", 244042, true, false, {8}) --Метка жертвы
mod:AddSetIconOption("SetIconEmbrace", 244094, true, false, {4, 3}) --Некротические объятия
--mod:AddInfoFrameOption(239154, true)
mod:AddRangeFrameOption("8/10")

mod.vb.currentTorment = 0--Can't antispam, cause it'll just break if someone dies and gets brezzed
mod.vb.totalEmbrace = 0
local playerAffected = false

function mod:OnCombatStart(delay)
	self.vb.currentTorment = 0
	self.vb.totalEmbrace = 0
	playerAffected = false
	timerTormentofFlamesCD:Start(5-delay)
	timerShadowStrikeCD:Start(9.3-delay)
	countdownShadowStrike:Start(9.3-delay)
	timerMarkedPreyCD:Start(25.2-delay)
	timerDarkFissureCD:Start(15.3-delay)
	if not self:IsEasy() then
		timerNecroticEmbraceCD:Start(35-delay)
		countdownNecroticEmbrace:Start(35-delay)
	else --только в обычке
		countdownMarkedPrey:Start(25.2-delay)
	end
	if not self:IsLFR() then
		berserkTimer:Start(310-delay)--Confirmed normal/heroic/mythic
	else
		berserkTimer:Start(-delay)
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(8)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 243960 or spellId == 257644 then--257644 LFR shadow strike
		warnShadowStrike:Show()
		timerShadowStrikeCD:Show()
		countdownShadowStrike:Start(9)
	elseif spellId == 244093 then--Necrotic Embrace Cast
		if self:IsHeroic() then
			timerNecroticEmbraceCD:Start()
			countdownNecroticEmbrace:Start(30.3)
		else
			timerNecroticEmbraceCD:Start()
			countdownNecroticEmbrace:Start(30.3)
		end
	elseif spellId == 243999 then --Темный разлом
		specWarnDarkFissure:Show()
		specWarnDarkFissure:Play("watchstep")
		if self:IsHeroic() then
			timerDarkFissureCD:Start(30.7)
		elseif self:IsMythic() then
			timerDarkFissureCD:Start(30.7)
		else
			timerDarkFissureCD:Start(32)
		end
	elseif spellId == 244042 then --Метка жертвы
		timerMarkedPreyCD:Start(30.5)
		if self:IsEasy() then
			countdownMarkedPrey:Start(30.5)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 243961 and self.vb.currentTorment ~= 4 then--If current torment is shadow, disable these warnings, Because entire raid now has misery rest of fight
		if args:IsPlayer() then
			if self:AntiSpam(4, 2) then
				specWarnMisery:Show()
				specWarnMisery:Play("defensive")
			end
		else
			local uId = DBM:GetRaidUnitId(args.destName)
			--Applied to a tank that's not you and you don't have it, taunt
			if uId and self:IsTanking(uId) and (self:CheckNearby(8, args.destName) or self:GetNumAliveTanks() < 3) and not DBM:UnitDebuff("player", spellId) then
				specWarnMiseryTaunt:Show(args.destName)
				specWarnMiseryTaunt:Play("tauntboss")
			end
		end
	elseif spellId == 244042 then --Метка жертвы
		if args:IsPlayer() then
			specWarnMarkedPrey:Show()
			specWarnMarkedPrey:Play("targetyou")
			yellMarkedPrey:Yell()
			yellMarkedPreyFades:Countdown(5, 3)
		else
			warnMarkedPrey:Show(args.destName)
		end
		if self.Options.SetIconOnMarkedPrey then
			self:SetIcon(args.destName, 8, 7)
		end
	elseif spellId == 244094 then --Некротические объятия
		self.vb.totalEmbrace = self.vb.totalEmbrace + 1
		if self.vb.totalEmbrace >= 3 then return end--Once it's beyond 2 players, consider it a wipe and throttle messages
		if self.Options.SetIconEmbrace then
			self:SetIcon(args.destName, self.vb.totalEmbrace+2)--Should be BW compatible, for most part.
		end
		if self:IsMythic() then
			if args:IsPlayer() then
				if not playerAffected then
					playerAffected = true
					local icon = self.vb.totalEmbrace+2
					specWarnNecroticEmbrace3:Show(self:IconNumToTexture(icon))
					if not self:IsTank() then
						specWarnNecroticEmbrace3:Play("mm"..icon)
					else
						specWarnNecroticEmbrace3:Play("targetyou")
					end
					yellNecroticEmbrace:Yell(self.vb.totalEmbrace, icon, icon)
					yellNecroticEmbraceFades:Countdown(6, 3, icon)
					if self.Options.RangeFrame then
						DBM.RangeCheck:Show(10)
					end
				end
			else
				warnNecroticEmbrace:CombinedShow(0.5, args.destName)--Combined message because even if it starts on 1, people are gonna fuck it up
			end
		else
			if args:IsPlayer() then
				if not playerAffected then
					playerAffected = true
					specWarnNecroticEmbrace:Show()
					if not self:IsTank() then
						specWarnNecroticEmbrace:Play("targetyou")
					end
					yellNecroticEmbrace2:Yell()
					yellNecroticEmbrace3:Countdown(6, 3)
					if self.Options.RangeFrame then
						DBM.RangeCheck:Show(10)
					end
				end
			else
				warnNecroticEmbrace:CombinedShow(0.5, args.destName)--Combined message because even if it starts on 1, people are gonna fuck it up
			end
		end
	elseif spellId == 248732 and self:AntiSpam(2, 1) then --Отголоски гибели
		warnEchoesofDoom:CombinedShow(0.5, args.destName)--In case multiple shadows up
		if args:IsPlayer() and self:AntiSpam(3, 1) then
			specWarnEchoesOfDoom:Show()
			specWarnEchoesOfDoom:Play("targetyou")
			yellEchoesOfDoom:Yell()
		end
	elseif spellId == 243968 and self.vb.currentTorment ~= 1 then --Пытка огнем
		self.vb.currentTorment = 1
		warnTormentofFlames:Show()
		warnTormentofFlames:Play("phasechange")
		if not self:IsEasy() then
			timerTormentofFrostCD:Start(100)
		else--No frost or fel in normal, LFR assumed
			timerTormentofShadowsCD:Start(290)
		end
	elseif spellId == 243977 and self.vb.currentTorment ~= 2 then --Пытка холодом
		self.vb.currentTorment = 2
		warnTormentofFrost:Show()
		warnTormentofFrost:Play("phasechange")
		timerTormentofFelCD:Start(99)
	elseif spellId == 243980 and self.vb.currentTorment ~= 3 then --Пытка скверной
		self.vb.currentTorment = 3
		warnTormentofFel:Show()
		warnTormentofFel:Play("phasechange")
		timerTormentofShadowsCD:Start(90)
	elseif spellId == 243973 and self.vb.currentTorment ~= 4 then --Пытка тьмой
		self.vb.currentTorment = 4
		warnTormentofShadows:Show()
		warnTormentofShadows:Play("phasechange")
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 244042 then
		if args:IsPlayer() then
			yellMarkedPrey:Cancel()
		end
	elseif spellId == 244094 then
		self.vb.totalEmbrace = self.vb.totalEmbrace - 1
		if args:IsPlayer() then
			playerAffected = false
			specWarnNecroticEmbrace4:Show()
			yellNecroticEmbraceFades:Cancel()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8)
			end
		end
		if self.Options.SetIconEmbrace then
			self:SetIcon(args.destName, 0)
		end
	end
end

--Dark Fissure & Echoes of Doom
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 244005 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show()
		specWarnGTFO:Play("runaway")
	elseif spellId == 248740 and destGUID == UnitGUID("player") and self:AntiSpam(3, 1) then
		specWarnGTFO2:Show()
		specWarnGTFO2:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
