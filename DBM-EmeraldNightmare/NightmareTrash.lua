local mod	= DBM:NewMod("EmeraldNightmareTrash", "DBM-EmeraldNightmare")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17745 $"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()
mod:SetMinSyncRevision(17745)
mod.isTrashMod = true

mod:RegisterEvents(
--	"SPELL_CAST_START 222719",
	"SPELL_AURA_APPLIED 221028 222719 223946",
	"SPELL_AURA_REMOVED 221028 222719",
	"UNIT_DIED"
)

local warnUnstableDecay				= mod:NewTargetAnnounce(221028, 3)

local specWarnUnstableDecay			= mod:NewSpecialWarningYouMoveAway(221028, nil, nil, nil, 1, 2)
local specWarnBefoulment			= mod:NewSpecialWarningMoveTo(222719, nil, nil, nil, 1, 2)
local specWarnDarkLightning			= mod:NewSpecialWarningMove(223946, nil, nil, nil, 1, 2)

local timerRoleplay					= mod:NewTimer(10, "timerRoleplay", "Interface\\Icons\\Spell_Holy_BorrowedTime", nil, nil, 7)

local yellUnstableDecay				= mod:NewYell(221028, nil, nil, nil, "YELL")
local yellUnstableDecay2			= mod:NewFadesYell(221028, nil, nil, nil, "YELL")
local yellBefoulment				= mod:NewFadesYell(222719, nil, nil, nil, "YELL")

mod:AddRangeFrameOption(10, 221028)

mod.vb.decay = 5

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 221028 then --Нестабильное разложение
		warnUnstableDecay:CombinedShow(0.5, args.destName)
		if args:IsPlayer() and self:AntiSpam(4, 1) then
			specWarnUnstableDecay:Show()
		--	specWarnUnstableDecay:Play("runout")
			yellUnstableDecay:Yell()
			yellUnstableDecay2:Countdown(9, 3)
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(10)
		end
	elseif spellId == 222719 then --Осквернение (надо сбежаться)
		specWarnBefoulment:Show(args.destName)
	--	specWarnBefoulment:Play("gathershare")
		if args:IsPlayer() then
			yellBefoulment:Yell()
			yellBefoulment:Countdown(15, 3)
		end
	elseif spellId == 223946 and args:IsPlayer() then--No damage events for trash mod, this should be enough
		specWarnDarkLightning:Show()
	--	specWarnDarkLightning:Play("runaway")
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 221028 then
		if args:IsPlayer() then
			yellUnstableDecay2:Cancel()
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif spellId == 222719 and args:IsPlayer() then
		yellBefoulment:Cancel()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 111004 then --Сгустившаяся гниль
		self.vb.decay = self.vb.decay - 1
		if self.vb.decay == 0 then
			timerRoleplay:Start(16)
		end
	end
end
