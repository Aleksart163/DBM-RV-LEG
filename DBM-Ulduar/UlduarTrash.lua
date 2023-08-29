local mod	= DBM:NewMod("UlduarTrash", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 62344 62325 62932",
	"SPELL_AURA_APPLIED 62310 62928",
	"GOSSIP_SHOW",
	"CHAT_MSG_MONSTER_SAY",
	"UNIT_DIED"
)

local warnImpale				= mod:NewSpellAnnounce(62928)

local timerImpale				= mod:NewTargetTimer(5, 62928)
local timerRoleplay				= mod:NewTimer(30, "timerRoleplay", "Interface\\Icons\\Spell_Holy_BorrowedTime", nil, nil, 7) --Ролевая игра

local countdownRoleplay			= mod:NewCountdown(30, 91344, nil, nil, 5)

local specWarnFistofStone		= mod:NewSpecialWarningSpell(62344, "Tank", nil, nil, 1, 2)
local specWarnGroundTremor		= mod:NewSpecialWarningCast(62932, true)

mod:AddBoolOption("PlaySoundOnFistOfStone", false)
mod:AddBoolOption("TrashRespawnTimer", true, "timer")

mod.vb.ProshlyapationCount = 2
--
-- Trash: 33430 Guardian Lasher (flower)
-- 33355 (nymph)
-- 33354 (tree)
--
-- Elder Stonebark (ground tremor / fist of stone)
-- Elder Brightleaf (unstable sunbeam)
--
--Mob IDs:
-- Elder Ironbranch: 32913
-- Elder Brightleaf: 32915
-- Elder Stonebark: 32914
--

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 62344 then --Каменные кулаки
		specWarnFistofStone:Show()
		if self.Options.PlaySoundOnFistOfStone then
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
		end
	elseif spellId == 62325 or spellId == 62932 then --Дрожание земли
		specWarnGroundTremor:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 62310 or spellId == 62928 then --Прокалывание
		warnImpale:Show(args.destName)
		timerImpale:Start(args.destName)
	end
end

function mod:GOSSIP_SHOW()
	local guid = UnitGUID("npc")
	if not guid then return end
	local cid = self:GetCIDFromGUID(guid)
	if cid == 33210 then --Начальник экспедиции
		if GetNumGossipOptions() == 1 then
			SelectGossipOption(1)
		--	self:SendSync("MurchalOchenProshlyapen")
		end
	end
end

function mod:UNIT_DIED(args)
	if self.Options.TrashRespawnTimer and not DBM.Bars:GetBar(L.TrashRespawnTimer) then
		local guid = tonumber(args.destGUID:sub(9, 12), 16)
		if guid == 33430 or guid == 33355 or guid == 33354 then		-- guardian lasher / nymph / tree
			DBM.Bars:CreateBar(7200, L.TrashRespawnTimer)
		end
	end
end

function mod:CHAT_MSG_MONSTER_SAY(msg)
	if msg == L.MurchalProshlyapation then
		self:SendSync("MurchalOchkenProshlyapation1")
	end
end

function mod:OnSync(msg)
	if msg == "MurchalOchkenProshlyapation1" then
		timerRoleplay:Start(19.2)
		countdownRoleplay:Start(19.2)
	end
end
