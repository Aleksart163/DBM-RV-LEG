local mod	= DBM:NewMod("CoSTrash", "DBM-Party-Legion", 7)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()
mod:SetOOCBWComms()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 209027 212031 209485 209410 209413 211470 211464 209404 209495 225100 211299 209378 207980 207979 214692 214688 214690 208334",
	"SPELL_CAST_SUCCESS 214688",
	"SPELL_AURA_APPLIED 209033 209512 207981 214690",
	"SPELL_AURA_REMOVED 214690",
	"CHAT_MSG_MONSTER_SAY",
	"GOSSIP_SHOW",
	"UNIT_DIED"
)
--208334 Иссушение... (баф на крит от сферы)
--209767 Очищение... (баф на снижение урона от фолиата)
--Квартал звезд
local warnPhase2					= mod:NewAnnounce("warnSpy", 1, 248732) --Шпион обнаружен , nil, nil, true
local warnDrainMagic				= mod:NewCastAnnounce(209485, 4) --Похищение магии
local warnCripple					= mod:NewTargetAnnounce(214690, 3) --Увечье
local warnCarrionSwarm				= mod:NewTargetAnnounce(214688, 4) --Темная стая
local warnShadowBoltVolley			= mod:NewCastAnnounce(214692, 4) --Залп стрел Тьмы
local warnFelDetonation				= mod:NewCastAnnounce(211464, 4) --Взрыв Скверны

local specWarnShadowBoltVolley		= mod:NewSpecialWarningDodge(214692, "-Tank", nil, nil, 2, 3) --Залп стрел Тьмы
local specWarnCarrionSwarm			= mod:NewSpecialWarningDodge(214688, nil, nil, nil, 2, 2) --Темная стая
local specWarnCripple				= mod:NewSpecialWarningDispel(214690, "MagicDispeller2", nil, nil, 1, 2) --Увечье
local specWarnCripple2				= mod:NewSpecialWarningYou(214690, nil, nil, nil, 1, 2) --Увечье
local specWarnFelDetonation			= mod:NewSpecialWarningDodge(211464, nil, nil, nil, 2, 3) --Взрыв Скверны
local specWarnDisintegrationBeam	= mod:NewSpecialWarningYouDefensive(207981, nil, nil, nil, 3, 6) --Луч дезинтеграции
local specWarnShockwave				= mod:NewSpecialWarningDodge(207979, "Melee", nil, nil, 2, 3) --Ударная волна
local specWarnFortification			= mod:NewSpecialWarningDispel(209033, "MagicDispeller", nil, nil, 1, 2) --Укрепление
local specWarnQuellingStrike		= mod:NewSpecialWarningDodge(209027, "Melee", nil, nil, 2, 2) --Подавляющий удар
local specWarnChargedBlast			= mod:NewSpecialWarningDodge(212031, "Melee", nil, nil, 2, 2) --Заряженный взрыв
local specWarnChargedSmash			= mod:NewSpecialWarningDodge(209495, "Melee", nil, nil, 2, 2) --Удар с размаху
local specWarnDrainMagic			= mod:NewSpecialWarningInterrupt(209485, "HasInterrupt", nil, nil, 3, 5) --Похищение магии
local specWarnNightfallOrb			= mod:NewSpecialWarningInterrupt(209410, "HasInterrupt", nil, nil, 1, 2)
local specWarnSuppress				= mod:NewSpecialWarningInterrupt(209413, "HasInterrupt", nil, nil, 1, 2)
local specWarnBewitch				= mod:NewSpecialWarningInterrupt(211470, "HasInterrupt", nil, nil, 1, 2)
local specWarnChargingStation		= mod:NewSpecialWarningInterrupt(225100, "HasInterrupt", nil, nil, 1, 2)
local specWarnSearingGlare			= mod:NewSpecialWarningInterrupt(211299, "HasInterrupt", nil, nil, 1, 2)
--local specWarnFelDetonation			= mod:NewSpecialWarningSpell(211464, false, nil, 2, 2, 2)
local specWarnSealMagic				= mod:NewSpecialWarningRun(209404, false, nil, 2, 4, 2)
local specWarnDisruptingEnergy		= mod:NewSpecialWarningMove(209512, nil, nil, nil, 1, 2)
local specWarnWhirlingBlades		= mod:NewSpecialWarningRun(209378, "Melee", nil, nil, 4, 3) --Крутящиеся клинки
--Герент Зловещий
local timerCripple					= mod:NewTargetTimer(8, 214690, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON) --Увечье
local timerCrippleCD				= mod:NewCDTimer(20.5, 214690, nil, "MagicDispeller2", nil, 3, nil, DBM_CORE_HEALER_ICON..DBM_CORE_MAGIC_ICON) --Увечье
local timerShadowBoltVolleyCD		= mod:NewCDTimer(20.5, 214692, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Залп стрел Тьмы
local timerCarrionSwarmCD			= mod:NewCDTimer(18, 214688, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Темная стая
--
local timerDisintegrationBeamCD		= mod:NewCDTimer(14, 207980, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Луч дезинтеграции
local timerFelDetonationCD			= mod:NewCDTimer(12, 211464, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Взрыв Скверны
local timerWhirlingBladesCD			= mod:NewCDTimer(18, 209378, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Крутящиеся клинки
local timerShockwaveCD				= mod:NewCDTimer(8.5, 207979, nil, nil, nil, 3, nil, DBM_CORE_TANK_ICON..DBM_CORE_DEADLY_ICON) --Ударная волна

local timerRoleplay					= mod:NewTimer(29, "timerRoleplay", "Interface\\Icons\\Spell_Holy_BorrowedTime", nil, nil, 7) --Ролевая игра

local yellDisintegrationBeam		= mod:NewYell(207981, nil, nil, nil, "YELL") --Луч дезинтеграции
local yellCripple					= mod:NewYell(214690, nil, nil, nil, "YELL") --Увечье
local yellCarrionSwarm				= mod:NewYell(214688, nil, nil, nil, "YELL") --Темная стая

mod:AddBoolOption("SpyHelper", true)

function mod:CarrionSwarmTarget(targetname, uId)
	if not targetname then
		warnCarrionSwarm:Show(DBM_CORE_UNKNOWN)
		return
	end
	if targetname == UnitName("player") then
		specWarnCarrionSwarm:Show()
		specWarnCarrionSwarm:Play("watchstep")
		yellCarrionSwarm:Yell()
	else
		warnCarrionSwarm:Show(targetname)
	end
end

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 209027 and self:AntiSpam(2, 1) then
		specWarnQuellingStrike:Show()
		specWarnQuellingStrike:Play("shockwave")
	elseif spellId == 212031 and self:AntiSpam(2, 2) then
		specWarnChargedBlast:Show()
		specWarnChargedBlast:Play("shockwave")
	elseif spellId == 209485 then --Похищение магии
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnDrainMagic:Show(args.sourceName)
			specWarnDrainMagic:Play("kickcast")
		else
			warnDrainMagic:Show()
			warnDrainMagic:Play("kickcast")
		end
	elseif spellId == 209410 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnNightfallOrb:Show(args.sourceName)
		specWarnNightfallOrb:Play("kickcast")
	elseif spellId == 209413 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnSuppress:Show(args.sourceName)
		specWarnSuppress:Play("kickcast")
	elseif spellId == 211470 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnBewitch:Show(args.sourceName)
		specWarnBewitch:Play("kickcast")
	elseif spellId == 225100 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnChargingStation:Show(args.sourceName)
		specWarnChargingStation:Play("kickcast")
	elseif spellId == 211299 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnSearingGlare:Show(args.sourceName)
		specWarnSearingGlare:Play("kickcast")
	elseif spellId == 211464 then
		warnFelDetonation:Show()
		specWarnFelDetonation:Show()
		specWarnFelDetonation:Play("aesoon")
		timerFelDetonationCD:Start()
	elseif spellId == 209404 then
		specWarnSealMagic:Show()
		specWarnSealMagic:Play("runout")
	elseif spellId == 209495 then
		--Don't want to move too early, just be moving already as cast is finishing
		specWarnChargedSmash:Schedule(1.2)
		specWarnChargedSmash:ScheduleVoice(1.2, "chargemove")
	elseif spellId == 209378 then
		specWarnWhirlingBlades:Show()
		specWarnWhirlingBlades:Play("runout")
		timerWhirlingBladesCD:Start()
	elseif spellId == 207980 then
		timerDisintegrationBeamCD:Start()
	elseif spellId == 207979 then --Ударная волна
		specWarnShockwave:Show()
		timerShockwaveCD:Start()
	elseif spellId == 214692 then --Залп стрел Тьмы
		warnShadowBoltVolley:Show()
		timerShadowBoltVolleyCD:Start()
		if self:IsHard() then
			specWarnShadowBoltVolley:Show()
			specWarnShadowBoltVolley:Play("watchstep")
		end
	elseif spellId == 214688 then --Темная стая
		self:BossTargetScanner(args.sourceGUID, "CarrionSwarmTarget", 0.1, 9)
	elseif spellId == 214690 then --Увечье
		timerCrippleCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 214688 then --Темная стая
		timerCarrionSwarmCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 209033 and not args:IsDestTypePlayer() then
		specWarnFortification:Show(args.destName)
		specWarnFortification:Play("dispelnow")
	elseif spellId == 209512 and args:IsPlayer() then
		specWarnDisruptingEnergy:Show()
		specWarnDisruptingEnergy:Play("runaway")
	elseif spellId == 207981 then
		if args:IsPlayer() then
			specWarnDisintegrationBeam:Show()
			yellDisintegrationBeam:Yell()
		end
	elseif spellId == 214690 then --Увечье
		warnCripple:Show(args.destName)
		timerCripple:Start(args.destName)
		if self:IsHard() then
			if args:IsPlayer() then
				specWarnCripple2:Show()
				yellCripple:Yell()
			else
				specWarnCripple:Show(args.destName)
				specWarnFortification:Play("dispelnow")
			end
		else
			if args:IsPlayer() then
				specWarnCripple2:Show()
				yellCripple:Yell()
			end
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 214690 then --Увечье
		timerCripple:Cancel(args.destName)
	end
end

do
	local hintTranslations = {
		["gloves"] = L.Gloves,
		["no gloves"] = L.NoGloves,
		["cape"] = L.Cape,
		["no cape"] = L.Nocape,
		["light vest"] = L.LightVest,
		["dark vest"] = L.DarkVest,
		["female"] = L.Female,
		["male"] = L.Male,
		["short sleeves"] = L.ShortSleeve,
		["long sleeves"] = L.LongSleeve,
		["potions"] = L.Potions,
		["no potion"] = L.NoPotions,
		["book"] = L.Book,
		["pouch"] = L.Pouch
	}
	local hints = {}
	local clues = {
		[L.Gloves1] = "gloves",
		[L.Gloves2] = "gloves",
		[L.Gloves3] = "gloves",
		[L.Gloves4] = "gloves",
		
		[L.NoGloves1] = "no gloves",
		[L.NoGloves2] = "no gloves",
		[L.NoGloves3] = "no gloves",
		[L.NoGloves4] = "no gloves",
		
		[L.Cape1] = "cape",
		[L.Cape2] = "cape",
		
		[L.NoCape1] = "no cape",
		[L.NoCape2] = "no cape",
		
		[L.LightVest1] = "light vest",
		[L.LightVest2] = "light vest",
		[L.LightVest3] = "light vest",
		
		[L.DarkVest1] = "dark vest",
		[L.DarkVest2] = "dark vest",
		[L.DarkVest3] = "dark vest",
		[L.DarkVest4] = "dark vest",
		
		[L.Female1] = "female",
		[L.Female2] = "female",
		[L.Female3] = "female",
		[L.Female4] = "female",
		
		[L.Male1] = "male",
		[L.Male2] = "male",
		[L.Male3] = "male",
		[L.Male4] = "male",
		
		[L.ShortSleeve1] = "short sleeves",
		[L.ShortSleeve2] = "short sleeves",
		[L.ShortSleeve3] = "short sleeves",
		[L.ShortSleeve4] = "short sleeves",
		
		[L.LongSleeve1] = "long sleeves",
		[L.LongSleeve2] = "long sleeves",
		[L.LongSleeve3] = "long sleeves",
		[L.LongSleeve4] = "long sleeves",
		
		[L.Potions1] = "potions",
		[L.Potions2] = "potions",
		[L.Potions3] = "potions",
		[L.Potions4] = "potions",
		
		[L.NoPotions1] = "no potion",
		[L.NoPotions2] = "no potion",
		
		[L.Book1] = "book",
		[L.Book2] = "book",
		
		[L.Pouch1] = "pouch",
		[L.Pouch2] = "pouch",
		[L.Pouch3] = "pouch",
		[L.Pouch4] = "pouch"
	}
	local bwClues = {
		[1] = "cape",
		[2] = "no cape",
		[3] = "pouch",
		[4] = "potions",
		[5] = "long sleeves",
 		[6] = "short sleeves",
 		[7] = "gloves",
 		[8] = "no gloves",
 		[9] = "male",
 		[10] = "female",
 		[11] = "light vest",
 		[12] = "dark vest",
 		[13] = "no potion",
		[14] = "book"
	}

	local function updateInfoFrame()
		local lines = {}
		for hint, j in pairs(hints) do
			local text = hintTranslations[hint] or hint
			lines[text] = ""
		end
		
		return lines
	end
	
	--/run DBM:GetModByName("CoSTrash"):ResetGossipState()
	function mod:ResetGossipState()
		table.wipe(hints)
		DBM.InfoFrame:Hide()
	end
	
	function mod:CHAT_MSG_MONSTER_SAY(msg)
		if msg:find(L.Found) or msg:find(L.Found) then
			self:SendSync("Finished")
		elseif msg == L.RolePlayMelan or msg:find(L.RolePlayMelan) then
			self:SendSync("RolePlayMel")
		end
	end

	function mod:GOSSIP_SHOW()
		if not self.Options.SpyHelper then return end
		local guid = UnitGUID("target")
		if not guid then return end
		local cid = self:GetCIDFromGUID(guid)
	
		-- Disguise NPC
		if cid == 106468 then
			if select('#', GetGossipOptions()) > 0 then
				SelectGossipOption(1)
				CloseGossip()
			end
		end
	
		-- Suspicious noble
		if cid == 107486 then 
			if select('#', GetGossipOptions()) > 0 then
				SelectGossipOption(1)
			else
				local clue = clues[GetGossipText()]
				if clue and not hints[clue] then
					CloseGossip()
					if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
						SendChatMessage(hintTranslations[clue], "INSTANCE_CHAT")
					elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
						SendChatMessage(hintTranslations[clue], "PARTY")
					end
					hints[clue] = true
					self:SendSync("CoS", clue)
					DBM.InfoFrame:Show(5, "function", updateInfoFrame)
				end
			end
		end
	end
	
	function mod:OnSync(msg, clue)
		if not self.Options.SpyHelper then return end
		if msg == "CoS" and clue then
			hints[clue] = true
			DBM.InfoFrame:Show(5, "function", updateInfoFrame)
		elseif msg == "Finished" then
			warnPhase2:Show()
			self:ResetGossipState()
		--	self:Finish()
		elseif msg == "RolePlayMel" then
			timerRoleplay:Start()
		end
	end
	function mod:OnBWSync(msg, extra)
		if msg ~= "clue" then return end
		extra = tonumber(extra)
		if extra and extra > 0 and extra < 15 then
			DBM:Debug("Recieved BigWigs Comm:"..extra)
			local bwClue = bwClues[extra]
			hints[bwClue] = true
			DBM.InfoFrame:Show(5, "function", updateInfoFrame)
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 104278 then --Порабощенная Скверной карательница
		timerFelDetonationCD:Stop()
	elseif cid == 104275 then --Имаку'туя
		timerWhirlingBladesCD:Cancel()
	elseif cid == 104274 then --Баалгар Бдительный
		timerDisintegrationBeamCD:Cancel()
	elseif cid == 104273 then --Джазшариу
		timerShockwaveCD:Cancel()
	elseif cid == 104273 then --Герент Зловещий
		timerCrippleCD:Stop()
		timerShadowBoltVolleyCD:Stop()
		timerCarrionSwarmCD:Stop()
	end
end
