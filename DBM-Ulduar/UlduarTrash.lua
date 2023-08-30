local mod	= DBM:NewMod("UlduarTrash", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 62344 62325 62932",
	"SPELL_AURA_APPLIED 62310 62928 63713 63710",
	"SPELL_AURA_REMOVED 63710",
	"GOSSIP_SHOW",
	"CHAT_MSG_MONSTER_SAY",
	"UNIT_DIED"
)

local warnImpale				= mod:NewTargetAnnounce(62928, 4)

local specWarnVoidBarrier		= mod:NewSpecialWarningReflect(63710, "-Healer", nil, nil, 1, 2) --Ограда Бездны
local specWarnVoidBarrier2		= mod:NewSpecialWarningEnd(63710, nil, nil, nil, 1, 2) --Ограда Бездны
local specWarnDominateMind		= mod:NewSpecialWarningYou(63713, nil, nil, nil, 1, 2) --Господство над разумом
local specWarnDominateMind2		= mod:NewSpecialWarningTarget(63713, nil, nil, nil, 1, 2) --Господство над разумом
local specWarnFistofStone		= mod:NewSpecialWarningSpell(62344, "Tank", nil, nil, 4, 6) --Каменные кулаки
local specWarnGroundTremor		= mod:NewSpecialWarningCast(62932, "SpellCaster", nil, nil, 2, 5) --Дрожание земли
local specWarnGroundTremor2		= mod:NewSpecialWarningSpell(62932, nil, nil, nil, 2, 3) --Дрожание земли

local timerDominateMind			= mod:NewTargetTimer(20, 63713, nil, nil, nil, 7) --Господство над разумом
local timerImpale				= mod:NewTargetTimer(5, 62928, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
local timerRoleplay				= mod:NewTimer(30, "timerRoleplay", "Interface\\Icons\\Spell_Holy_BorrowedTime", nil, nil, 7) --Ролевая игра

local countdownRoleplay			= mod:NewCountdown(30, 91344, nil, nil, 5)

local yellImpale				= mod:NewYellHelp(62928, nil, nil, nil, "YELL") --Прокалывание
local yellDominateMind			= mod:NewYellHelp(63713, nil, nil, nil, "YELL") --Господство над разумом

mod:AddSetIconOption("SetIconOnDominateMind", 63713, true, false, {1}) --Господство над разумом
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
		specWarnFistofStone:Play("justrun")
	elseif spellId == 62325 or spellId == 62932 then --Дрожание земли
		if self:IsSpellCaster() then
			specWarnGroundTremor:Show()
			specWarnGroundTremor:Play("stopcast")
		else
			specWarnGroundTremor2:Show()
			specWarnGroundTremor2:Play("specialsoon")
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 62310 or spellId == 62928 then --Прокалывание
		if args:IsPlayer() then
			yellImpale:Yell()
		else
			warnImpale:Show(args.destName)
		end
		timerImpale:Start(args.destName)
	elseif spellId == 63713 then --Господство над разумом
		if args:IsPlayer() then
			specWarnDominateMind:Show()
			specWarnDominateMind:Play("targetyou")
			yellDominateMind:Yell()
			PlaySoundFile("Sound\\Creature\\Yoggsaron\\UR_YoggSaron_Insanity01.wav")
		else
			specWarnDominateMind2:Show(args.destName)
			specWarnDominateMind:Play("stopattack")
		end
		if self.Options.SetIconOnDominateMind then
			self:SetIcon(args.destName, 1, 20) 
		end
		timerDominateMind:Start(args.destName)
	elseif spellId == 63710 then --Ограда Бездны
		specWarnVoidBarrier:Show(args.destName)
		specWarnVoidBarrier:Play("stopattack")
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 63710 then --Ограда Бездны
		specWarnVoidBarrier2:Show()
		specWarnVoidBarrier2:Play("end")
	elseif spellId == 63713 then --Господство над разумом
		timerDominateMind:Stop(args.destName)
		if self.Options.SetIconOnDominateMind then
			self:RemoveIcon(args.destName)
		end
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
