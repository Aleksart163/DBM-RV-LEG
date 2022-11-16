local mod	= DBM:NewMod("SoTTrash", "DBM-Party-Legion", 13)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 248304 245585 245727 248133 248184 248227 248128 245522",
	"SPELL_AURA_APPLIED 249077 249081 245748",
	"SPELL_AURA_APPLIED_DOSE 245748",
	"SPELL_AURA_REMOVED 249081 245748",
	"CHAT_MSG_MONSTER_SAY",
	"GOSSIP_SHOW",
	"UNIT_DIED"
)

--Престол триумвирата трэш
local warnWardenDie					= mod:NewAnnounce("WarningWardensDie", 2, 254727)
local warnCorruptingTouch			= mod:NewStackAnnounce(245748, 4, nil, nil, 2) --Оскверняющее прикосновение
local warnCorruptingVoid			= mod:NewTargetAnnounce(245510, 3) --Оскверняющая Бездна
local warnSupField					= mod:NewTargetAnnounce(249081, 3) --Подавляющее поле
local warnWildSummon				= mod:NewCastAnnounce(248304, 3) --Случайный призыв
local warnStygianBlast				= mod:NewSpellAnnounce(248133, 3) --Стигийский заряд

local specWarnDarkenedRemnant		= mod:NewSpecialWarningDodge(248128, nil, nil, nil, 2, 2) --Потемневший прах
local specWarnCorruptingTouch		= mod:NewSpecialWarningStack(245748, nil, 2, nil, nil, 1, 3) --Оскверняющее прикосновение
local specWarnCorruptingTouch2		= mod:NewSpecialWarningDispel(245748, "MagicDispeller2", nil, nil, 3, 3) --Оскверняющее прикосновение
local specWarnCorruptingVoid		= mod:NewSpecialWarningYouMoveAway(245510, nil, nil, nil, 4, 3) --Оскверняющая Бездна
local specWarnDarkMatter			= mod:NewSpecialWarningSwitch(248227, nil, nil, nil, 1, 2) --Темная сущность
local specWarnSupField				= mod:NewSpecialWarningYouDontMove(249081, nil, nil, nil, 1, 2) --Подавляющее поле
local specWarnVoidDiffusion			= mod:NewSpecialWarningInterrupt(245585, "HasInterrupt", nil, nil, 1, 2) --Распыление Бездны
local specWarnConsumeEssence		= mod:NewSpecialWarningInterrupt(245727, "HasInterrupt", nil, nil, 1, 2) --Поглощение сущности
local specWarnStygianBlast			= mod:NewSpecialWarningInterrupt(248133, "HasInterrupt", nil, nil, 1, 2) --Стигийский заряд
local specWarnDarkFlay				= mod:NewSpecialWarningInterrupt(248184, "HasInterrupt", nil, nil, 1, 2) --Темное свежевание
local specWarnEntropicMist			= mod:NewSpecialWarningInterrupt(245522, "HasInterrupt", nil, nil, 1, 2) --Энтропический туман

local timerCorruptingTouch			= mod:NewTargetTimer(12, 245748, nil, "Tank|MagicDispeller2", nil, 3, nil, DBM_CORE_MAGIC_ICON..DBM_CORE_HEALER_ICON) --Оскверняющее прикосновение

local timerRoleplay					= mod:NewTimer(30, "timerRoleplay", "Interface\\Icons\\Spell_Holy_BorrowedTime", nil, nil, 7) --Ролевая игра
local timerRoleplay2				= mod:NewTimer(30, "timerRoleplay2", "Interface\\Icons\\ability_warrior_offensivestance", nil, nil, 7) --Ролевая игра

local yellCorruptingTouch			= mod:NewYell(245748, nil, nil, nil, "YELL") --Оскверняющее прикосновение
local yellCorruptingVoid			= mod:NewYell(245510, nil, nil, nil, "YELL") --Оскверняющая Бездна
local yellCorruptingVoid2			= mod:NewFadesYell(245510, nil, nil, nil, "YELL") --Оскверняющая Бездна
local yellSupField					= mod:NewYell(249081, nil, nil, nil, "YELL") --Подавляющее поле
local yellSupField2					= mod:NewFadesYell(249081, nil, nil, nil, "YELL") --Подавляющее поле

mod:AddBoolOption("AlleriaActivation", true)

mod.vb.wardens = 3

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
		specWarnDarkFlay:Show()
		specWarnDarkFlay:Play("kickcast")
	elseif spellId == 245522 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Энтропический туман
		specWarnEntropicMist:Show()
		specWarnEntropicMist:Play("kickcast")
	elseif spellId == 248227 then
		specWarnDarkMatter:Show()
		specWarnDarkMatter:Play("killmob")
	elseif spellId == 248128 and self:AntiSpam(3, 1) then --Потемневший прах
		specWarnDarkenedRemnant:Show()
		specWarnDarkenedRemnant:Play("watchstep")
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
			warnCorruptingVoid:CombinedShow(0.5, args.destName)
		end
	elseif spellId == 249081 and self:AntiSpam(3, args.destName) then --Подавляющее поле
		if args:IsPlayer() then
			specWarnSupField:Show()
			specWarnSupField:Play("stopmove")
			yellSupField:Yell()
			yellSupField2:Countdown(10, 3)
		else
			warnSupField:CombinedShow(0.5, args.destName)
		end
	elseif spellId == 245748 then --Оскверняющее прикосновение
		local amount = args.amount or 1
		if self:IsHard() then
			timerCorruptingTouch:Start(args.destName)
			if amount >= 2 and amount % 2 == 0 then
				if args:IsPlayer() then
					specWarnCorruptingTouch:Show(amount)
					specWarnCorruptingTouch:Play("stackhigh")
					yellCorruptingTouch:Yell()
				else
					warnCorruptingTouch:Show(args.destName, amount)
					specWarnCorruptingTouch2:Show(args.destName)
					specWarnCorruptingTouch2:Play("dispelnow")
				end
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 249081 then --Подавляющее поле
		if args:IsPlayer() then
			yellSupField2:Cancel()
		end
	elseif spellId == 245748 then --Оскверняющее прикосновение
		timerCorruptingTouch:Cancel(args.destName)
	end
end

function mod:GOSSIP_SHOW()
	local guid = UnitGUID("npc")
	if not guid then return end
	local cid = self:GetCIDFromGUID(guid)
	if mod.Options.AlleriaActivation then
		if cid == 123743 then --Аллерия Ветрокрылая
			if select('#', GetGossipOptions()) > 0 then
				SelectGossipOption(1)
				CloseGossip()
			end
		end
	end
end

function mod:CHAT_MSG_MONSTER_SAY(msg)
	if msg == L.RP1 then
		self:SendSync("RP1")
	elseif msg == L.RP2 then
		self:SendSync("RP2")
	elseif msg == L.RP3 then
		self:SendSync("RP3")
	end
end

function mod:OnSync(msg, GUID)
	if msg == "RP1" then
		timerRoleplay:Start(22)
	elseif msg == "RP2" then
		timerRoleplay:Start(32.5)
	elseif msg == "RP3" then
		timerRoleplay2:Start(31.7)
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 122571 then
		self.vb.wardens = self.vb.wardens - 1
		warnWardenDie:Show(self.vb.wardens)
		if self.vb.wardens == 0 then
			self.vb.wardens = 3
		end
	end
end
