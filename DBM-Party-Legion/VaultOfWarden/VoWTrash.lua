local mod	= DBM:NewMod("VoWTrash", "DBM-Party-Legion", 10)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 196799 193069 196799 196249 193502",
	"SPELL_AURA_APPLIED 202615 193069 193607 202608",
	"SPELL_CAST_SUCCESS 202606",
	"CHAT_MSG_MONSTER_SAY"
)

local warnTorment				= mod:NewTargetAnnounce(202615, 3) --Мучение
local warnNightmares			= mod:NewTargetAnnounce(193069, 4) --Кошмары
local warnDoubleStrike			= mod:NewTargetAnnounce(193607, 2) --Двойной удар
local warnMetamorphosis			= mod:NewSpellAnnounce(193502, 4) --Метаморфоза

local specWarnNightmares2		= mod:NewSpecialWarningDispel(193069, "MagicDispeller", nil, nil, 1, 2) --Кошмары
local specWarnAnguishedSouls	= mod:NewSpecialWarningYouMove(202608, nil, nil, nil, 1, 2) --Страдающие души
local specWarnAnguishedSouls2	= mod:NewSpecialWarningDodge(202606, nil, nil, nil, 2, 2) --Страдающие души
local specWarnTorment			= mod:NewSpecialWarningYouClose(202615, nil, nil, nil, 3, 2) --Мучение
local specWarnTorment2			= mod:NewSpecialWarningYouDefensive(202615, nil, nil, nil, 2, 5) --Мучение
local specWarnDoubleStrike		= mod:NewSpecialWarningDefensive(193607, nil, nil, nil, 2, 2) --Двойной удар
local specWarnUnleashedFury		= mod:NewSpecialWarningInterrupt(196799, "-Healer", nil, nil, 2, 2) --Высвобождение ярости
local specWarnNightmares		= mod:NewSpecialWarningInterrupt(193069, "HasInterrupt", nil, nil, 3, 2) --Кошмары
local specWarnMeteor			= mod:NewSpecialWarningDodge(196249, nil, nil, nil, 1, 2) --Метеор

local timerTormentCD			= mod:NewCDTimer(17, 202615, nil, nil, nil, 7, nil) --Мучение
local timerDoubleStrikeCD		= mod:NewCDTimer(13, 193607, nil, "Tank", nil, 3, nil, DBM_CORE_TANK_ICON) --Двойной удар
local timerDoubleStrike			= mod:NewTargetTimer(6, 193607, nil, "Healer", nil, 3, nil) --Двойной удар
local timerRoleplay				= mod:NewTimer(23, "timerRoleplay", "Interface\\Icons\\Spell_Holy_BorrowedTime", nil, nil, 7) --Ролевая игра

local yellNightmares			= mod:NewYell(193069, nil, nil, nil, "YELL") --Кошмары
local yellTorment				= mod:NewYell(202615, nil, nil, nil, "YELL") --Мучение

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 196799 and self:AntiSpam(4, 1) then
		specWarnUnleashedFury:Show()
		specWarnUnleashedFury:Play("aesoon")
	elseif spellId == 193069 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnNightmares:Show(args.sourceName)
		specWarnNightmares:Play("kickcast")
	elseif spellId == 196249 then
		specWarnMeteor:Show()
		specWarnMeteor:Play("gathershare")
	elseif spellId == 193502 then --Метаморфоза
		warnMetamorphosis:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 202606 and self:AntiSpam(3, 1) then --Страдающие души
		specWarnAnguishedSouls2:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 202615 then
		warnTorment:Show(args.destName)
		timerTormentCD:Start()
		if args:IsPlayer() then
			specWarnTorment2:Show()
			yellTorment:Yell()
		else
			specWarnTorment:Show()
		end
	elseif spellId == 193069 then
		warnNightmares:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			yellNightmares:Yell()
		else
			specWarnNightmares2:Show(args.destName)
		end
	elseif spellId == 193607 then --Двойной удар
		warnDoubleStrike:Show(args.destName)
		timerDoubleStrike:Start(args.destName)
		timerDoubleStrikeCD:Start()
		if args:IsPlayer() then
			specWarnDoubleStrike:Show()
		end
	elseif spellId == 202608 then --Страдающие души
		if args:IsPlayer() then
			specWarnAnguishedSouls:Show()
		end
	end
end

function mod:CHAT_MSG_MONSTER_SAY(msg)
	if msg == L.RoleRP or msg:find(L.RoleRP) then
		self:SendSync("Roleplay")
	end
end

function mod:OnSync(msg, GUID)
	if msg == "Roleplay" then
		timerRoleplay:Start()
	end
end
