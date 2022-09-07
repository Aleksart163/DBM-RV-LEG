local mod	= DBM:NewMod(1672, "DBM-Party-Legion", 1, 740)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(98965, 98970) --Кур'талос Гребень Ворона, Латосий
mod:SetEncounterID(1835)
mod:SetZone()
mod:SetUsedIcons(8, 7)
mod:SetBossHPInfoToHighest()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 198820 199143 199193 202019 198641 201733",
	"SPELL_CAST_SUCCESS 198635 201733",
	"SPELL_AURA_APPLIED 201733",
	"SPELL_AURA_REMOVED 199193 201733",
	"CHAT_MSG_MONSTER_SAY",
	"UNIT_HEALTH",
	"UNIT_DIED"
)

--Лорд Кур'талос Гребень Ворона https://ru.wowhead.com/npc=94923/лорд-курталос-гребень-ворона/эпохальный-журнал-сражений
local warnPhase						= mod:NewPhaseChangeAnnounce(1)
local warnPhase2					= mod:NewPrePhaseAnnounce(2, 1)
local warnCloud						= mod:NewSpellAnnounce(199143, 2) --Гипнотическое облако
local warnSwarm						= mod:NewTargetAnnounce(201733, 2) --Жалящий рой
local warnWhirlingBlade				= mod:NewTargetAnnounce(198641, 3) --Крутящийся клинок
local warnGuile						= mod:NewPreWarnAnnounce(199193, 5, 1) --Хитроумие повелителя ужаса
local warnShadowBoltVolley			= mod:NewPreWarnAnnounce(202019, 5, 1) --Залп стрел Тьмы
local warnLegacyRavencrest			= mod:NewPreWarnAnnounce(199368, 5, 1) --Наследие Гребня Ворона

local specWarnWhirlingBlade			= mod:NewSpecialWarningTargetDodge(198641, nil, nil, nil, 2, 3) --Крутящийся клинок
local specWarnWhirlingBlade2		= mod:NewSpecialWarningYouRun(198641, nil, nil, nil, 4, 3) --Крутящийся клинок
local specWarnDarkblast				= mod:NewSpecialWarningDodge(198820, nil, nil, nil, 3, 5) --Темный взрыв
local specWarnGuile					= mod:NewSpecialWarningDodge(199193, nil, nil, nil, 3, 5) --Хитроумие повелителя ужаса
local specWarnGuileEnded			= mod:NewSpecialWarningEnd(199193, nil, nil, nil, 1, 2) --Хитроумие повелителя ужаса
local specWarnSwarm					= mod:NewSpecialWarningYou(201733, nil, nil, nil, 3, 3) --Жалящий рой
local specWarnSwarm2				= mod:NewSpecialWarningSwitch(201733, "-Healer", nil, nil, 1, 2) --Жалящий рой
local specWarnShadowBolt			= mod:NewSpecialWarningDefensive(202019, nil, nil, nil, 3, 5) --Залп стрел Тьмы

local timerDarkBlastCD				= mod:NewCDTimer(18, 198820, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Темный взрыв
local timerUnerringShearCD			= mod:NewCDTimer(12, 198635, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON) --Неумолимый удар
local timerGuileCD					= mod:NewCDCountTimer(85, 199193, nil, nil, nil, 6, nil, DBM_CORE_DEADLY_ICON..DBM_CORE_MYTHIC_ICON) --Хитроумие повелителя ужаса
local timerGuile					= mod:NewBuffFadesTimer(20, 199193, nil, nil, nil, 6, nil, DBM_CORE_MYTHIC_ICON) --Хитроумие повелителя ужаса
local timerCloudCD					= mod:NewCDTimer(35, 199143, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON) --Гипнотическое облако
local timerSwarmCD					= mod:NewCDTimer(19.8, 201733, nil, nil, nil, 3) --Жалящий рой
local timerShadowBoltVolleyCD		= mod:NewCDTimer(8, 202019, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Залп стрел Тьмы
local timerLegacyRavencrestCD		= mod:NewCDTimer(24.5, 199368, nil, nil, nil, 7) --Наследие Гребня Ворона
local timerWhirlingBladeCD			= mod:NewCDTimer(25.5, 198641, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Крутящийся клинок

local yellWhirlingBlade				= mod:NewYell(198641, nil, nil, nil, "YELL") --Крутящийся клинок
local yellSwarm						= mod:NewYellHelp(201733, nil, nil, nil, "YELL") --Жалящий рой

local countdownDarkblast			= mod:NewCountdown(18, 198820, nil, nil, 5) --Темный взрыв
local countdownShear				= mod:NewCountdown("Alt12", 198635, "Tank", nil, 5) --Неумолимый удар
local countdownGuile				= mod:NewCountdown(39, 199193, nil, nil, 5) --Хитроумие повелителя ужаса
local countdownGuile2				= mod:NewCountdownFades("Alt20", 199193, nil, nil, 5) --Хитроумие повелителя ужаса

mod:AddSetIconOption("SetIconOnWhirlingBlade", 198641, true, false, {8}) --Крутящийся клинок
mod:AddSetIconOption("SetIconOnSwarm", 201733, true, false, {7}) --Жалящий рой

mod.vb.phase = 1
mod.vb.shadowboltCount = 0
mod.vb.guileCount = 0

local warned_preP1 = false

function mod:WhirlingBladeTarget(targetname, uId) --Крутящийся клинок и прошляпанное очко Мурчаля✔
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnWhirlingBlade2:Show()
		specWarnWhirlingBlade2:Play("runout")
		yellWhirlingBlade:Yell()
	elseif self:CheckNearby(40, targetname) then
		specWarnWhirlingBlade:Show(targetname)
		specWarnWhirlingBlade:Play("watchstep")
	else
		warnWhirlingBlade:Show(targetname)
	end
	if self.Options.SetIconOnWhirlingBlade then
		self:SetIcon(targetname, 8, 10)
	end
end

function mod:SwarmTarget(targetname, uId) --Жалящий рой ✔
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnSwarm:Show()
		specWarnSwarm:Play("targetyou")
		yellSwarm:Yell()
	elseif self:CheckNearby(20, targetname) then
		specWarnSwarm2:Schedule(1.5)
		specWarnSwarm2:ScheduleVoice(1.5, "killmob")
	else
		warnSwarm:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.shadowboltCount = 0
	self.vb.guileCount = 0
	warned_preP1 = false
	if not self:IsNormal() then
		timerUnerringShearCD:Start(5.5-delay) --Неумолимый удар
		countdownShear:Start(5.5-delay) --Неумолимый удар
		timerDarkBlastCD:Start(12-delay) --Темный взрыв +2 сек
		countdownDarkblast:Start(12-delay) --Темный взрыв +2 сек
		timerWhirlingBladeCD:Start(10.5-delay) --Крутящийся клинок
	else
		timerUnerringShearCD:Start(5.5-delay) --Неумолимый удар
		countdownShear:Start(5.5-delay) --Неумолимый удар
		timerDarkBlastCD:Start(10-delay) --Темный взрыв
	end
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
		countdownGuile2:Start()
		timerGuileCD:Start(nil, self.vb.guileCount+1)
		warnGuile:Schedule(80)
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
	elseif spellId == 198641 then --Крутящийся клинок
		self:BossTargetScanner(args.sourceGUID, "WhirlingBladeTarget", 0.1, 2)
		timerWhirlingBladeCD:Start()
	elseif spellId == 201733 then --Жалящий рой
		self:BossTargetScanner(args.sourceGUID, "SwarmTarget", 0.1, 2)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 198635 then
		timerUnerringShearCD:Start()
		countdownShear:Start()
	elseif spellId == 201733 then --Жалящий рой
		timerSwarmCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 201733 then --Жалящий рой
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
	elseif spellId == 201733 then --Жалящий рой
		if self.Options.SetIconOnSwarm then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 98965 then --Кур'талос Гребень Ворона
		if not self:IsNormal() then
			timerSwarmCD:Start(24) --+15 сек
		end
		warnLegacyRavencrest:Schedule(19.5)
		timerLegacyRavencrestCD:Start()
		timerCloudCD:Start(30) --+18.5
		countdownDarkblast:Start(19)
		timerShadowBoltVolleyCD:Start(19)
		warnShadowBoltVolley:Schedule(14)
		timerGuileCD:Start(40, 1)--24-28
		warnGuile:Schedule(35)
		countdownGuile:Start(40)
	end
end

function mod:CHAT_MSG_MONSTER_SAY(msg)
	if msg == L.Latosius then
		self.vb.phase = 2
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase))
		timerWhirlingBladeCD:Cancel()
		countdownShear:Cancel()
		timerDarkBlastCD:Cancel()
		timerUnerringShearCD:Cancel()
		countdownDarkblast:Cancel()
	end
end

function mod:UNIT_HEALTH(uId)
	if not self:IsNormal() then
		if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 98965 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.31 then --Кур'талос
			warned_preP1 = true
			warnPhase2:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
		end
	else
		if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 98965 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.31 then --Кур'талос
			warned_preP1 = true
		end
	end
end
