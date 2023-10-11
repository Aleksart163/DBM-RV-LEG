local mod	= DBM:NewMod("AKTrash", "DBM-Party-WotLK", 1, 271)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 59108",
	"SPELL_AURA_APPLIED 59108"
)

--Ан'кахет: Старое Королевство треш https://www.wowhead.com/ru/zone=4494/анкахет-старое-королевство#npcs

local specWarnGlutinousPoison			= mod:NewSpecialWarningYouDispel(59108, nil, nil, nil, 3, 2) --Клейкий яд
local specWarnGlutinousPoison2			= mod:NewSpecialWarningInterrupt(59108, "HasInterrupt", nil, nil, 1, 2) --Клейкий яд

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 59108 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Клейкий яд
		specWarnGlutinousPoison2:Show()
		specWarnGlutinousPoison2:Play("kickcast")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 59108 then --Клейкий яд
		if args:IsPlayer() and self:IsHealer() and self:IsPoisonDispeller() then
			specWarnGlutinousPoison:Show()
			specWarnGlutinousPoison:Play("dispelnow")
		end
	end
end
