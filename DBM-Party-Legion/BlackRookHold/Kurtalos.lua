local mod	= DBM:NewMod(1672, "DBM-Party-Legion", 1, 740)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(98965, 98970)
mod:SetEncounterID(1835)
mod:SetZone()
mod:SetBossHPInfoToHighest()

mod:RegisterCombat("combat")
mod:SetUsedIcons(7)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 198820 199143 199193 202019",
	"SPELL_CAST_SUCCESS 198635 201733",
	"SPELL_AURA_APPLIED 201733",
	"SPELL_AURA_REMOVED 199193 201733",
	"CHAT_MSG_MONSTER_SAY",
	"UNIT_DIED"
)

--TODO, figure out swarm warnings, how many need to switch and kill?
local warnPhase2					= mod:NewAnnounce("Phase2", 1, "Interface\\Icons\\Spell_Nature_WispSplode") --Фаза 2
local warnCloud						= mod:NewSpellAnnounce(199143, 2) --Гипнотическое облако
local warnSwarm						= mod:NewTargetNoFilterAnnounce(201733, 2) --Жалящий рой

local specWarnDarkblast				= mod:NewSpecialWarningDodge(198820, nil, nil, nil, 3, 5) --Темный взрыв
local specWarnGuile					= mod:NewSpecialWarningDodge(199193, nil, nil, nil, 3, 5) --Хитроумие повелителя ужаса
local specWarnGuileEnded			= mod:NewSpecialWarningEnd(199193, nil, nil, nil, 1, 2) --Хитроумие повелителя ужаса
local specWarnSwarm					= mod:NewSpecialWarningYou(201733, nil, nil, nil, 1, 2) --Жалящий рой
local specWarnSwarm2				= mod:NewSpecialWarningSwitch(201733, "-Healer", nil, nil, 1, 2) --Жалящий рой
local specWarnShadowBolt			= mod:NewSpecialWarningDefensive(202019, nil, nil, nil, 3, 5) --Залп стрел Тьмы

local timerDarkBlastCD				= mod:NewCDTimer(18, 198820, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Темный взрыв
local timerUnerringShearCD			= mod:NewCDTimer(12, 198635, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON) --Неумолимый удар
local timerGuileCD					= mod:NewCDCountTimer(85, 199193, nil, nil, nil, 6, nil, DBM_CORE_DEADLY_ICON..DBM_CORE_MYTHIC_ICON) --Хитроумие повелителя ужаса
local timerGuile					= mod:NewBuffFadesTimer(20, 199193, nil, nil, nil, 6, nil, DBM_CORE_MYTHIC_ICON) --Хитроумие повелителя ужаса
local timerCloudCD					= mod:NewCDTimer(35, 199143, nil, nil, nil, 3) --Гипнотическое облако
local timerSwarmCD					= mod:NewCDTimer(19.8, 201733, nil, nil, nil, 3) --Жалящий рой
local timerShadowBoltVolleyCD		= mod:NewCDTimer(8, 202019, nil, nil, nil, 2) --Залп стрел Тьмы

local yellSwarm						= mod:NewYell(201733, nil, nil, nil, "YELL") --Жалящий рой

local countdownDarkblast			= mod:NewCountdown(18, 198820) --Темный взрыв
local countdownShear				= mod:NewCountdown(12, 198635, "Tank") --Неумолимый удар
local countdownGuile				= mod:NewCountdown(39, 199193) --Хитроумие повелителя ужаса

mod:AddSetIconOption("SetIconOnSwarm", 201733, true, false, {7}) --Жалящий рой

mod.vb.phase = 1
mod.vb.shadowboltCount = 0
mod.vb.guileCount = 0

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.shadowboltCount = 0
	self.vb.guileCount = 0
	timerUnerringShearCD:Start(5.5-delay)
	countdownShear:Start(5.5-delay)
	timerDarkBlastCD:Start(12-delay) --Темный взрыв +2 сек
	countdownDarkblast:Start(12-delay) --Темный взрыв +2 сек
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 198820 then
		if self.vb.phase == 1 then
			specWarnDarkblast:Show()
			specWarnDarkblast:Play("watchstep")
			timerDarkBlastCD:Start()
			countdownDarkblast:Start()
		end
	elseif spellId == 199143 then
		warnCloud:Show()
		timerCloudCD:Start()
	elseif spellId == 199193 then --Хитроумие повелителя ужаса
		self.vb.guileCount = self.vb.guileCount + 1
		timerCloudCD:Stop()
		timerSwarmCD:Stop()
		timerShadowBoltVolleyCD:Stop()
		specWarnGuile:Show()
		specWarnGuile:Play("watchstep")
		specWarnGuile:ScheduleVoice(1.5, "keepmove")
		specWarnGuileEnded:Schedule(20)
		timerGuile:Start()
		timerGuileCD:Start(nil, self.vb.guileCount+1)
		if self.vb.guileCount == 1 then
			timerCloudCD:Start(25)
			timerSwarmCD:Start(27.5)
		elseif self.vb.guileCount == 2 then
			timerSwarmCD:Start(27.5)
			timerCloudCD:Start(32.5)
		end
	elseif spellId == 202019 then
		self.vb.shadowboltCount = self.vb.shadowboltCount + 1
		if self.vb.shadowboltCount == 1 then
			specWarnShadowBolt:Show()
			specWarnShadowBolt:Play("defensive")
		end
		--timerShadowBoltVolleyCD:Start()--Not known, and probably not important
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 198635 then
		timerUnerringShearCD:Start()
		countdownShear:Start()
	elseif spellId == 201733 then
		timerSwarmCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 201733 then
		warnSwarm:Show(args.destName)
		if args:IsPlayer() then
			specWarnSwarm:Show()
			yellSwarm:Yell()
		else
			specWarnSwarm2:Show()
		end
		if self.Options.SetIconOnSwarm then
			self:SetIcon(args.destName, 7)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 199193 then
		specWarnGuileEnded:Show()
		specWarnGuileEnded:Play("safenow")
		timerCloudCD:Start(3)
		if not self:IsNormal() then
			timerSwarmCD:Start(10.5)
		end
	elseif spellId == 201733 then
		if self.Options.SetIconOnSwarm then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 98965 then--Kur'talos Ravencrest
		if not self:IsNormal() then
			timerSwarmCD:Start(24) --+15 сек
		end
		timerCloudCD:Start(30) --+18.5
		countdownDarkblast:Start(19)
		timerShadowBoltVolleyCD:Start(19)--Not confirmed, submitted by requesting user
		timerGuileCD:Start(40, 1)--24-28
		countdownGuile:Start(40)
	end
end

function mod:OnSync(msg)
	if msg == "Latosius" then
		self.vb.phase = 2
		warnPhase2:Show()
		countdownShear:Cancel()
		timerDarkBlastCD:Cancel()
		timerUnerringShearCD:Cancel()
		countdownDarkblast:Cancel()
	end
end

function mod:CHAT_MSG_MONSTER_SAY(msg) --CHAT_MSG_MONSTER_YELL
	if msg == L.Latosius or msg:find(L.Latosius) then
		self:SendSync("Latosius")
	end
end
