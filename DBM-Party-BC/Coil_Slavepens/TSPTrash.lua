local mod	= DBM:NewMod("TSPTrash", "DBM-Party-BC", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 34984",
	"SPELL_AURA_APPLIED 34984 30923",
	"SPELL_AURA_REMOVED 30923"
)

--- Прошляпанное очко Мурчаля Прошляпенко ---
local warnPsychicHorror				= mod:NewTargetAnnounce(34984, 4) --Глубинный ужас
local warnDomination				= mod:NewTargetAnnounce(30923, 4) --Власть

--local specWarnTerrify				= mod:NewSpecialWarningInterrupt(49106, "HasInterrupt", nil, nil, 3, 2) --Запугивание
local specWarnPsychicHorror			= mod:NewSpecialWarningDispel(34984, "MagicDispeller", nil, nil, 1, 3) --Глубинный ужас
local specWarnPsychicHorror2		= mod:NewSpecialWarningInterrupt(34984, "HasInterrupt", nil, nil, 3, 2) --Глубинный ужас

local yellPsychicHorror				= mod:NewYellDispel(34984, nil, nil, nil, "YELL") --Глубинный ужас
local yellDomination				= mod:NewYell(30923, nil, nil, nil, "YELL") --Власть
local yellDomination2				= mod:NewFadesYell(30923, nil, nil, nil, "YELL") --Власть


function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 34984 then --Глубинный ужас
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnPsychicHorror2:Show()
			specWarnPsychicHorror2:Play("kickcast")
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 34984 then --Глубинный ужас
		if args:IsPlayer() and not self:IsMagicDispeller() then
			yellPsychicHorror:Yell()
		elseif args:IsPlayer() and self:IsMagicDispeller() then
			yellPsychicHorror:Yell()
		elseif self:IsMagicDispeller() then
			specWarnPsychicHorror:Show(args.destName)
			specWarnPsychicHorror:Play("dispelnow")
		else
			warnPsychicHorror:Show(args.destName)
		end
	elseif spellId == 30923 then --Власть
		if args:IsPlayer() then
			yellDomination:Yell()
			yellDomination2:Countdown(10, 3)
		else
			warnDomination:Show(args.destName)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 30923 then --Власть
		if args:IsPlayer() then
			yellDomination2:Cancel()
		end
	end
end
