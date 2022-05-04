local mod	= DBM:NewMod("SoTTrash", "DBM-Party-Legion", 13)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 248304 245585 245727 248133 248184 248227",
	"SPELL_AURA_APPLIED 249077 249081",
	"CHAT_MSG_MONSTER_YELL",
	"CHAT_MSG_MONSTER_SAY"
)
--Престол триумвирата
local warnCorruptingVoid			= mod:NewTargetNoFilterAnnounce(245510, 3) --Оскверняющая Бездна
local warnSupField					= mod:NewTargetNoFilterAnnounce(249081, 3) --Подавляющее поле
local warnWildSummon				= mod:NewCastAnnounce(248304, 3) --Случайный призыв
local warnStygianBlast				= mod:NewSpellAnnounce(248133, 3) --Стигийский заряд

local specWarnCorruptingVoid		= mod:NewSpecialWarningYouMoveAway(245510, nil, nil, nil, 4, 3) --Оскверняющая Бездна
local specWarnDarkMatter			= mod:NewSpecialWarningSwitch(248227, nil, nil, nil, 1, 2) --Темная сущность
local specWarnSupField				= mod:NewSpecialWarningYouDontMove(249081, nil, nil, nil, 1, 2) --Подавляющее поле
local specWarnVoidDiffusion			= mod:NewSpecialWarningInterrupt(245585, "HasInterrupt", nil, nil, 1, 2) --Распыление Бездны
local specWarnConsumeEssence		= mod:NewSpecialWarningInterrupt(245727, "HasInterrupt", nil, nil, 1, 2) --Поглощение сущности
local specWarnStygianBlast			= mod:NewSpecialWarningInterrupt(248133, "HasInterrupt", nil, nil, 1, 2) --Стигийский заряд
local specWarnDarkFlay				= mod:NewSpecialWarningInterrupt(248184, "HasInterrupt", nil, nil, 1, 2) --Темное свежевание

local timerRoleplay					= mod:NewTimer(30, "timerRoleplay", "Interface\\Icons\\Spell_Holy_BorrowedTime", nil, nil, 7) --Ролевая игра
local timerRoleplay2				= mod:NewTimer(30, "timerRoleplay2", "Interface\\Icons\\ability_warrior_offensivestance", nil, nil, 7) --Ролевая игра

local yellCorruptingVoid			= mod:NewYell(245510, nil, nil, nil, "YELL") --Оскверняющая Бездна
local yellCorruptingVoid2			= mod:NewFadesYell(245510, nil, nil, nil, "YELL") --Оскверняющая Бездна
local yellSupField					= mod:NewYell(249081, nil, nil, nil, "YELL") --Подавляющее поле
local yellSupField2					= mod:NewFadesYell(249081, nil, nil, nil, "YELL") --Подавляющее поле

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 248304 then
		warnWildSummon:Show()
	elseif spellId == 245585 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnVoidDiffusion:Show(args.sourceName)
		specWarnVoidDiffusion:Play("kickcast")
	elseif spellId == 245727 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnConsumeEssence:Show(args.sourceName)
		specWarnConsumeEssence:Play("kickcast")
	elseif spellId == 248133 then --Стигийский заряд
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnStygianBlast:Show(args.sourceName)
			specWarnStygianBlast:Play("kickcast")
		else
			warnStygianBlast:Show()
			warnStygianBlast:Play("kickcast")
		end
	elseif spellId == 248184 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnDarkFlay:Show(args.sourceName)
		specWarnDarkFlay:Play("kickcast")
	elseif spellId == 248227 then
		specWarnDarkMatter:Show()
		specWarnDarkMatter:Play("killmob")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 249077 and self:AntiSpam(3, args.destName) then
		if args:IsPlayer() then
			specWarnCorruptingVoid:Show()
			specWarnCorruptingVoid:Play("runout")
			yellCorruptingVoid:Yell()
			yellCorruptingVoid2:Countdown(8, 3)
		else
			warnCorruptingVoid:Show(args.destName)
		end
	elseif spellId == 249081 and self:AntiSpam(3, args.destName) then
		if args:IsPlayer() then
			specWarnSupField:Show()
			specWarnSupField:Play("stopmove")
			yellSupField:Yell()
			yellSupField2:Countdown(10, 3)
		else
			warnSupField:Show(args.destName)
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.RP1 or msg:find(L.RP1) then
		self:SendSync("RP1")
	end
end

function mod:CHAT_MSG_MONSTER_SAY(msg)
	if msg == L.RP2 or msg:find(L.RP2) then
		self:SendSync("RP2")
	elseif msg == L.RP3 or msg:find(L.RP3) then
		self:SendSync("RP3")
	end
end

function mod:OnSync(msg, GUID)
	if msg == "RP1" then
		timerRoleplay:Start(45)
	elseif msg == "RP2" then
		timerRoleplay:Start(33)
	elseif msg == "RP3" then
		timerRoleplay2:Start(32.5)
	end
end
