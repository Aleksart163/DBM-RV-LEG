local mod	= DBM:NewMod("ETTrash", "DBM-Party-Cataclysm", 6)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17700 $"):sub(12, -3))
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

local timerRoleplay					= mod:NewTimer(30, "timerRoleplay", "Interface\\Icons\\Spell_Holy_BorrowedTime", nil, nil, 7)

local countdownRoleplay				= mod:NewCountdown(30, 91344, nil, nil, 5)

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.ProshlyapM then
		timerRoleplay:Start(45.5) --19.3 если М2
		countdownRoleplay:Start(45.5) --19.3 если М2
	end
end

--ProshlyapM2 = "Вы как слепые черви ползете к безумию и безысходности. Я видел истинный Конец Времен. Этот исход? О, это - счастье, непостижимое для вас."
