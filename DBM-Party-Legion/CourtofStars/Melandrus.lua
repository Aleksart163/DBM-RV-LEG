local mod	= DBM:NewMod(1720, "DBM-Party-Legion", 7, 800)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(104218)
mod:SetEncounterID(1870)
mod:SetZone()

mod.noNormal = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 209602 209676 209628"
)

local warnSurge						= mod:NewTargetNoFilterAnnounce(209602, 4) --Буйство клинков

local specWarnSurge					= mod:NewSpecialWarningDodge(209602, nil, nil, nil, 1, 2) --Буйство клинков
local specWarnSlicingMaelstrom		= mod:NewSpecialWarningSpell(209676, nil, nil, nil, 2, 2) --Кромсающий вихрь
local specWarnGale					= mod:NewSpecialWarningDodge(209628, nil, nil, nil, 2, 2) --Пронзающий ураган

local timerSurgeCD					= mod:NewCDTimer(17, 209602, nil, nil, nil, 3) --Буйство клинков
local timerMaelstromCD				= mod:NewCDTimer(17, 209676, nil, nil, nil, 3) --Кромсающий вихрь
local timerGaleCD					= mod:NewCDTimer(17, 209628, nil, nil, nil, 2) --Пронзающий ураган

local yellSurge						= mod:NewYell(209602, nil, nil, nil, "YELL") --Буйство клинков

local trashmod = DBM:GetModByName("CoSTrash")

function mod:SurgeTarget(targetname, uId)
	if not targetname then
		warnSurge:Show(DBM_CORE_UNKNOWN)
		return
	end
	if targetname == UnitName("player") then
		specWarnSurge:Show()
		specWarnSurge:Play("targetyou")
		yellSurge:Yell()
	else
		warnSurge:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	if self:IsHard() then
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
		timerSurgeCD:Start(12) --подправил
		self:BossTargetScanner(104218, "SurgeTarget", 0.1, 16, true, nil, nil, nil, true)
	elseif spellId == 209676 then
		specWarnSlicingMaelstrom:Show()
		specWarnSlicingMaelstrom:Play("aesoon")
		timerMaelstromCD:Start(24.5) --подправил
	elseif spellId == 209628 and self:AntiSpam(5, 1) then
		specWarnGale:Show()
		specWarnGale:Play("watchstep")
		timerGaleCD:Start(24.5) --подправил
	end
end
