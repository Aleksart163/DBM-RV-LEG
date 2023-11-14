local mod	= DBM:NewMod(1720, "DBM-Party-Legion", 7, 800)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17745 $"):sub(12, -3))
mod:SetCreatureID(104218)
mod:SetEncounterID(1870)
mod:SetZone()
mod:SetMinSyncRevision(17745)
mod.noNormal = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 209602 209676 209628",
	"SPELL_AURA_APPLIED 224333"
)

--Советник Меландр https://ru.wowhead.com/npc=101831/советник-меландр/эпохальный-журнал-сражений
local warnSurge						= mod:NewTargetAnnounce(209602, 4) --Буйство клинков
local warnEnvelopingWinds			= mod:NewTargetAnnounce(224333, 3) --Вихрь

local specWarnEnvelopingWinds		= mod:NewSpecialWarningDispel(224333, "MagicDispeller2", nil, nil, 3, 3) --Вихрь
local specWarnEnvelopingWinds2		= mod:NewSpecialWarningYou(224333, nil, nil, nil, 3, 3) --Вихрь
local specWarnSurge					= mod:NewSpecialWarningDodge(209602, nil, nil, nil, 1, 2) --Буйство клинков
local specWarnSlicingMaelstrom		= mod:NewSpecialWarningDefensive(209676, nil, nil, nil, 2, 2) --Кромсающий вихрь
local specWarnGale					= mod:NewSpecialWarningDodge(209628, nil, nil, nil, 2, 2) --Пронзающий ураган

local timerSurgeCD					= mod:NewCDTimer(17, 209602, nil, nil, nil, 7) --Буйство клинков
local timerMaelstromCD				= mod:NewCDTimer(17, 209676, nil, nil, nil, 2, nil, DBM_CORE_HEALER_ICON) --Кромсающий вихрь
local timerGaleCD					= mod:NewCDTimer(17, 209628, nil, nil, nil, 2) --Пронзающий ураган

local yellSurge						= mod:NewYell(209602, nil, nil, nil, "YELL") --Буйство клинков
local yellEnvelopingWinds			= mod:NewYellHelp(224333, nil, nil, nil, "YELL") --Вихрь

local trashmod = DBM:GetModByName("CoSTrash")

function mod:SurgeTarget(targetname, uId)
	if not targetname then
		warnSurge:Show(DBM_CORE_UNKNOWN)
		return
	end
	if targetname == UnitName("player") then
		specWarnSurge:Show()
	--	specWarnSurge:Play("targetyou")
		yellSurge:Yell()
	else
		warnSurge:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	if not self:IsNormal() then
		timerGaleCD:Start(10.5-delay) 
		timerMaelstromCD:Start(22-delay)
		timerSurgeCD:Start(6-delay)
	else
		timerGaleCD:Start(5.7-delay) 
		timerMaelstromCD:Start(10.9-delay)
		timerSurgeCD:Start(17-delay)
	end
	--Not ideal to do every pull, but cleanest way to ensure it's done
	if not trashmod then
		trashmod = DBM:GetModByName("CoSTrash")
	end
	if trashmod and trashmod.Options.SpyHelper then
		trashmod:ResetGossipState()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 209602 then
		timerSurgeCD:Start(12)
		self:BossTargetScanner(104218, "SurgeTarget", 0.1, 16, true, nil, nil, nil, true)
	elseif spellId == 209676 then
		if not UnitIsDeadOrGhost("player") then
			specWarnSlicingMaelstrom:Show()
		--	specWarnSlicingMaelstrom:Play("aesoon")
		end
		timerMaelstromCD:Start(24.5)
	elseif spellId == 209628 and self:AntiSpam(5, 1) then
		if not UnitIsDeadOrGhost("player") then
			specWarnGale:Show()
		--	specWarnGale:Play("watchstep")
		end
		timerGaleCD:Start(24.5)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 224333 then --Вихрь
		if args:IsPlayer() and not self:IsMagicDispeller2() then
			specWarnEnvelopingWinds2:Show()
		--	specWarnEnvelopingWinds2:Play("targetyou")
			yellEnvelopingWinds:Yell()
		elseif self:IsMagicDispeller2() and not UnitIsDeadOrGhost("player") then
			specWarnEnvelopingWinds:CombinedShow(0.5, args.destName)
		--	specWarnEnvelopingWinds:ScheduleVoice(0.5, "dispelnow")
		else
			warnEnvelopingWinds:CombinedShow(0.5, args.destName)
		end
	end
end
