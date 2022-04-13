local mod	= DBM:NewMod(1663, "DBM-Party-Legion", 8, 727)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(96759)
mod:SetEncounterID(1824)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 227233 202088 198495",
	"SPELL_AURA_APPLIED 196947 197262",
	"SPELL_AURA_REMOVED 196947",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1",
	"UNIT_HEALTH boss1"
)

local warnTaintofSea					= mod:NewTargetAnnounce(197262, 2, nil, false) --Морская порча
local warnSubmerged						= mod:NewSpellAnnounce(196947, 2) --Погружение
local warnSubmerged2					= mod:NewPreWarnAnnounce(196947, 5, 1) --Погружение

local specWarnDestructorTentacle		= mod:NewSpecialWarningSwitch("ej12364", "Tank") --Щупальце разрушения
local specWarnBrackwaterBarrage			= mod:NewSpecialWarningDodge(202088, "-Tank", nil, nil, 3, 3) --Обстрел солоноватой водой Tank stays with destructor tentacle no matter what
local specWarnSubmergedOver				= mod:NewSpecialWarningEnd(196947) --Погружение
local specWarnBreath					= mod:NewSpecialWarningDodge(227233, nil, nil, nil, 3, 5) --Оскверняющий рев
local specWarnTorrent					= mod:NewSpecialWarningInterrupt(198495, "HasInterrupt", nil, nil, 1, 2) --Стремительный поток

local timerBrackwaterBarrageCD			= mod:NewCDTimer(15, 202088, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Обстрел солоноватой водой
local timerTaintofSeaCD					= mod:NewCDTimer(12, 197262, nil, false, nil, 3) --Морская порча
local timerPiercingTentacleCD			= mod:NewNextTimer(9, 197596, nil, nil, nil, 3) --Пронзающее щупальце
--local timerDestructorTentacleCD		= mod:NewCDTimer(26, "ej12364", nil, nil, nil, 1)--More data
local timerSubmerged					= mod:NewBuffFadesTimer(15, 196947, nil, nil, nil, 6) --Погружение
local timerSubmerged2					= mod:NewCDTimer(75, 196947, nil, nil, nil, 6) --Погружение
local timerBreathCD						= mod:NewNextTimer(22, 227233, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Оскверняющий рев
local timerTorrentCD					= mod:NewCDTimer(9.7, 198495, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON) --Стремительный поток often delayed and after breath so often will see 12-14

local countdownBreath					= mod:NewCountdown(22, 227233) --Оскверняющий рев
local countdownSubmerged				= mod:NewCountdown(75, 196947) --Погружение

mod.vb.phase = 1

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	timerPiercingTentacleCD:Start(8.5)
	timerBrackwaterBarrageCD:Start()
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 227233 then --Оскверняющий рев
		specWarnBreath:Show()
		specWarnBreath:Play("breathsoon")
		timerBreathCD:Start()
		countdownBreath:Start()
	elseif spellId == 202088 then --Обстрел солоноватой водой
		specWarnBrackwaterBarrage:Show()
		specWarnBrackwaterBarrage:Play("breathsoon")
		timerBrackwaterBarrageCD:Start(22)
		--timerBreathCD:Start()
		--countdownBreath:Start()
	elseif spellId == 198495 then --Стремительный поток
		timerTorrentCD:Start()
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnTorrent:Show(args.sourceName)
			specWarnTorrent:Play("kickcast")
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 196947 then --Погружение
		timerPiercingTentacleCD:Stop()
		timerTaintofSeaCD:Stop()
		timerBreathCD:Stop()
		timerTorrentCD:Stop()
		countdownBreath:Cancel()
		warnSubmerged:Show()
		timerSubmerged:Start()
		if self.vb.phase == 1 then
			self.vb.phase = 2
		end
	elseif spellId == 197262 then
		warnTaintofSea:Show(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 196947 then --Погружение
		timerTorrentCD:Start(11) --было 5
		timerSubmerged2:Start()
		countdownSubmerged:Start()
		warnSubmerged2:Schedule(70)
		specWarnSubmergedOver:Show()
		timerBreathCD:Start(19)
		countdownBreath:Start(19)
	end
end

--"<50.03 00:13:36> [CHAT_MSG_RAID_BOSS_EMOTE] |TInterface\\Icons\\inv_misc_monsterhorn_03.blp:20|t A %s emerges!#Destructor Tentacle###Destructor Tentacle##0#0##0#257#nil#0#false#false#false#false"
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:find("inv_misc_monsterhorn_03") then
		specWarnDestructorTentacle:Show()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 197596 then--Piercing Tentacle
		if self.vb.phase == 1 then
			timerPiercingTentacleCD:Start()
		else
			timerPiercingTentacleCD:Start(6)
		end
	end
end
