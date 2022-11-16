if GetLocale() ~= "koKR" then return end

local L

-----------------------
-- <<<Black Rook Hold>>> --
-----------------------

-----------------------
-- The Amalgam of Souls --
-----------------------
L= DBM:GetModLocalization(1518)

-----------------------
-- Illysanna Ravencrest --
-----------------------
L= DBM:GetModLocalization(1653)

-----------------------
-- Smashspite the Hateful --
-----------------------
L= DBM:GetModLocalization(1664)

-----------------------
-- Lord Kur'talos Ravencrest --
-----------------------
L= DBM:GetModLocalization(1672)

L:SetMiscLocalization({
	proshlyapMurchal = "됐다! 슬슬 싫증이 나는군."
})

-----------------------
--Black Rook Hold Trash
-----------------------
L = DBM:GetModLocalization("BRHTrash")

L:SetGeneralLocalization({
	name =	"검은 떼까마귀 요새 일반몹"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_DOOR_OPENING
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_DOOR_OPENING
})

L:SetMiscLocalization({
	RP1 = "이제... 이제 알겠군..."
})

-----------------------
-- <<<Darkheart Thicket>>> --
-----------------------

-----------------------
-- Arch-Druid Glaidalis --
-----------------------
L= DBM:GetModLocalization(1654)

-----------------------
-- Oakheart --
-----------------------
L= DBM:GetModLocalization(1655)

-----------------------
-- Dresaron --
-----------------------
L= DBM:GetModLocalization(1656)

-----------------------
-- Shade of Xavius --
-----------------------
L= DBM:GetModLocalization(1657)

L:SetMiscLocalization{
	ParanoiaYell = "%s 에 %s. 내게서 도망쳐!"
}

L:SetMiscLocalization({
	XavApoc = "고통스럽게, 천천히 죽여주마.",
	XavApoc2 = "네 나약한 정신을 조각내주마!"
})

-----------------------
--Darkheart Thicket Trash
-----------------------
L = DBM:GetModLocalization("DHTTrash")

L:SetGeneralLocalization({
	name =	"어둠심장 숲 일반몹"
})

-----------------------
-- <<<Eye of Azshara>>> --
-----------------------

-----------------------
-- Warlord Parjesh --
-----------------------
L= DBM:GetModLocalization(1480)

-----------------------
-- Lady Hatecoil --
-----------------------
L= DBM:GetModLocalization(1490)

-----------------------
-- King Deepbeard --
-----------------------
L= DBM:GetModLocalization(1491)

-----------------------
-- Serpentrix --
-----------------------
L= DBM:GetModLocalization(1479)

-----------------------
-- Wrath of Azshara --
-----------------------
L= DBM:GetModLocalization(1492)

-----------------------
--Eye of Azshara Trash
-----------------------
L = DBM:GetModLocalization("EoATrash")

L:SetGeneralLocalization({
	name =	"아즈샤라의 눈 일반몹"
})

-----------------------
-- <<<Halls of Valor>>> --
-----------------------

-----------------------
-- Hymdall --
-----------------------
L= DBM:GetModLocalization(1485)

L:SetMiscLocalization({
	proshlyapMurchal = "훌륭한 전투였다! 이제 길이 열렸다."
})

-----------------------
-- Hyrja --
-----------------------
L= DBM:GetModLocalization(1486)

-----------------------
-- Fenryr --
-----------------------
L= DBM:GetModLocalization(1487)

L:SetMiscLocalization({
	MurchalProshlyapOchko = "부상당한 펜리르가 은신처로 후퇴합니다."
})

-----------------------
-- God-King Skovald --
-----------------------
L= DBM:GetModLocalization(1488)

-----------------------
-- Odyn --
-----------------------
L= DBM:GetModLocalization(1489)

L:SetMiscLocalization({
	Proshlyapen = "그만! 항복하겠다! 너희는 진정으로 놀라운 생물이구나. 약속한 대로 합당한 보상을 내리겠다." --
})

-----------------------
--Halls of Valor Trash
-----------------------
L = DBM:GetModLocalization("HoVTrash")

L:SetGeneralLocalization({
	name =	"용맹의 전당 일반몹"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT,
	BossActivation = DBM_CORE_GENERIC_TIMER_ROLE_PLAY
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetMiscLocalization({
	RPSolsten = "의식에 방해만 되는 것들 같으니라고!",
	RPSolsten2 = "히리아... 이제 폭풍의 격노를 부릴 수 있게 되었다!",
	RPOlmyr = "히리아의 승천을 막을 순 없다!",
	RPOlmyr2 = "히리아, 빛이 네 안에서 영원히 빛나리라!",
	RPSkovald = "안 돼! 나도 내 가치를 증명했다, 오딘. 나는 신왕 스코발드다! 나의 아이기스에 어찌 감히 필멸자가 손을 댄단 말이냐!",
	RPOdyn = "정말 놀랍군! 발라리아르의 힘에 견줄 만큼 강력한 자를 보게 될 줄은 몰랐거늘, 이렇게 너희가 나타나다니."
})

-----------------------
-- <<<Neltharion's Lair>>> --
-----------------------

-----------------------
-- Rokmora --
-----------------------
L= DBM:GetModLocalization(1662)

-----------------------
-- Ularogg Cragshaper --
-----------------------
L= DBM:GetModLocalization(1665)

-----------------------
-- Naraxas --
-----------------------
L= DBM:GetModLocalization(1673)

-----------------------
-- Dargrul the Underking --
-----------------------
L= DBM:GetModLocalization(1687)

-----------------------
--Neltharion's Lair Trash
-----------------------
L = DBM:GetModLocalization("NLTrash")

L:SetGeneralLocalization({
	name =	"넬타리온의 둥지 일반몹"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetMiscLocalization({
	RoleP1 = "나바로그? 이 배신자! 감히 침입자들을 끌고 여기 오다니!"
})

-----------------------
-- <<<The Arcway>>> --
-----------------------

-----------------------
-- Ivanyr --
-----------------------
L= DBM:GetModLocalization(1497)

-----------------------
-- Nightwell Sentry --
-----------------------
L= DBM:GetModLocalization(1498)

-----------------------
-- General Xakal --
-----------------------
L= DBM:GetModLocalization(1499)

-----------------------
-- Nal'tira --
-----------------------
L= DBM:GetModLocalization(1500)

-----------------------
-- Advisor Vandros --
-----------------------
L= DBM:GetModLocalization(1501)

L:SetMiscLocalization({
	RPVandros = "그만! 짐승 같은 놈들이 너무 날뛰는구나!"
})

-----------------------
--The Arcway Trash
-----------------------
L = DBM:GetModLocalization("ArcwayTrash")

L:SetGeneralLocalization({
	name =	"비전로 일반몹"
})

-----------------------
-- <<<Court of Stars>>> --
-----------------------

-----------------------
-- Patrol Captain Gerdo --
-----------------------
L= DBM:GetModLocalization(1718)

-----------------------
-- Talixae Flamewreath --
-----------------------
L= DBM:GetModLocalization(1719)

-----------------------
-- Advisor Melandrus --
-----------------------
L= DBM:GetModLocalization(1720)

-----------------------
--Court of Stars Trash
-----------------------
L = DBM:GetModLocalization("CoSTrash")

L:SetGeneralLocalization({
	name =	"별의 궁정 일반몹"
})

L:SetOptionLocalization({
	SpyHelper	= "첩자 색출 도우미",
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetMiscLocalization({
	--
	proshlyapMurchal = "벌써 떠나셔야 합니까, 대마법학자님?",
	Gloves1		= "그 첩자는 항상 장갑을 낀다고 하더군요.",
	Gloves2		= "제가 듣기로는, 그 첩자는 항상 신경 써서 손을 가린다고 합니다.",
	Gloves3		= "그 첩자는 항상 장갑을 낀다고 들었습니다.",
	Gloves4		= "그 첩자는 손에 있는 선명한 흉터를 가리려고 장갑을 낀다고 합니다.",
	Gloves5		= false,
	Gloves6		= false,
	NoGloves1	= "그 첩자는 장갑을 끼는 일이 없다고 하더군요.",
	NoGloves2	= "안쪽 방에서 장갑 한 켤레를 발견했습니다. 첩자는 분명히 이 주변에 장갑을 끼지 않은 사람중 하나일 거에요.",
	NoGloves3	= "그 첩자는 장갑을 끼는 걸 싫어한다고 들었습니다.",
	NoGloves4	= "그 첩자는 장갑을 끼지 않는답니다. 위급한 순간에 걸리적거려서 그렇겠지요.",
	NoGloves5	= false,
	NoGloves6	= false,
	NoGloves7	= false,
	Cape1		= "그 첩자가 망토를 걸친 모습을 봤다는 사람이 있었습니다.",
	Cape2		= "그 첩자는 망토를 즐겨 입는다고 들었습니다.",
	NoCape1		= "그 첩자는 망토를 싫어해서 절대로 입지 않는다고 합니다.",
	NoCape2		= "제가 듣기로는 그 첩자가 궁전에 망토를 벗어두고 여기 왔다고 합니다.",
	LightVest1	= "그자는 첩자인데도 밝은색 조끼를 즐겨 입는다고 합니다.",
	LightVest2	= "오늘 밤 파티에 그 첩자는 밝은색 조끼를 입고 올 거라는 말을 들었습니다.",
	LightVest3	= "사람들이 그러는데, 오늘 밤 그 첩자는 어두운 색 조끼를 입지 않았다고 합니다.",
	DarkVest1	= "그 첩자는 분명 어두운 옷을 선호합니다.",
	DarkVest2	= "오늘 밤 그 첩자는 어둡고 짙은 색의 조끼를 입었다고 합니다.",
	DarkVest3	= "그 첩자는 어두운 색 조끼를 즐겨 입어요... 밤과 같은 색이죠.",
	DarkVest4	= "소문에 그 첩자는 눈에 띄지 않으려고 밝은색 옷은 피한다더군요.",
	Female1		= "첩자가 나타났다고 합니다. 그 여자는 아주 미인이라고도 하더군요.",
	Female2		= "어떤 여자가 귀족 지구에 관해 계속 묻고 다닌다고 하던데...",
	Female3		= "그 불청객은 남자가 아니라는 말을 들었습니다.",
	Female4		= "아까 한 방문객이 그녀와 엘리산드가 함께 도착하는 걸 보았답니다.",
	Female5		= false,
	Male1		= "첩자가 여성이 아니라는 얘기를 들었습니다.",
	Male2		= "첩자가 나타났다고 합니다. 그 남자는 대단히 호감형이라고도 하더군요.",
	Male3		= "한 남자가 대마법학자와 나란히 저택에 들어오는 걸 봤다는 얘기가 있더군요.",
	Male4		= "한 연주자가 말하길, 그 남자가 끊임없이 그 지구에 관한 질문을 늘어놨다고 합니다.",
	Male5		= false,
	Male6		= false,
	ShortSleeve1= "그 첩자는 팔을 빠르게 움직이려고 짧은 소매 옷만 고집한다고 합니다.",
	ShortSleeve2= "그 첩자는 소매가 긴 옷을 입는 걸 정말 싫어한다고 합니다.",
	ShortSleeve3= "제 친구가 그 첩자가 입은 옷을 봤는데, 긴 소매는 아니었다는군요!",
	ShortSleeve4= "그 첩자는 시원한 걸 좋아해서 오늘 밤 짧은 소매를 입고 왔다고 들었습니다.",
	ShortSleeve5= false,
	LongSleeve1 = "오늘 밤 첩자는 긴 소매 옷을 입었다고 하더군요.",
	LongSleeve2 = "오늘 밤 그 첩자는 소매가 긴 옷을 입었다고 들었어요.",
	LongSleeve3 = "초저녁에 첩자를 언뜻 보았는데... 긴 소매 옷을 입었던 것 같습니다.",
	LongSleeve4 = "제 친구 말로는, 첩자가 긴 소매 옷을 입었다고 합니다.",
	LongSleeve5 = false,
	Potions1	= "그 첩자는 물약을 가지고 다닌데요. 이유가 뭘까요?",
	Potions2	= "이 얘기를 깜빡할 뻔했네요... 그 첩자는 연금술사로 가장해 허리띠에 물약을 달고 다닌다고 합니다.",
	Potions3	= "그 첩자는 허리띠에 물약을 매달고 있을 게 분명합니다. 있는 게 분명해요.",
	Potions4	= "그 첩자는 만약을 대비해... 물약 몇 개를 가져왔다고 합니다.",
	Potions5	= false,
	Potions6	= false,
	NoPotions1	= "그 첩자는 물약을 가지고 다니지 않는다고 합니다.",
	NoPotions2	= "한 연주자가 그 첩자가 마지막 물약을 버리는 걸 봤다고 합니다. 그러니 더는 물약이 없겠죠.",
	Book1		= "그 첩자의 허리띠 주머니에는 비밀이 잔뜩 적힌 책이 담겨 있다고 합니다.",
	Book2		= "소문을 들어 보니, 그 첩자는 독서를 좋아해서 항상 책을 가지고 다닌다고 합니다.",
	Book3		= false,
	Pouch1		= "그 첩자는 마법의 주머니를 항상 가지고 다닌다고 들었습니다.",
	Pouch2		= "제 친구가 말하길, 그 첩자는 금을 너무 좋아해서 허리띠 주머니에도 금이 가득 들어 있다고 합니다.",
	Pouch3		= "그 첩자는 어찌나 사치스러운지 허리띠에 달린 주머니에 금화를 잔뜩 넣어서 다닌다고 합니다.",
	Pouch4		= "그 첩자는 허리띠 주머니도 휘황찬란한 자수로 꾸며져 있다고 합니다.",
	Pouch5		= false,
	Pouch6		= false,
	Pouch7		= false,
	Found		= "자, 너무 그렇게 다그치지 마십시오", -- 자, 너무 그렇게 다그치지 마십시오, Tielle 님. 어디 조용한 곳으로 가서 다시 얘기해 보는 게 어떻겠습니까? 따라오시죠...
	--
	Gloves		= "장갑/Носит перчатки",
	NoGloves	= "장갑 없음/Без перчаток",
	Cape		= "망토/Носит плащ",
	Nocape		= "망토 없음/Без плаща",
	LightVest	= "밝은색 조끼/Светлый жилет",
	DarkVest	= "어두운색 조끼/Темный жилет",
	Female		= "여자/Женщина",
	Male		= "남자/Мужчина",
	ShortSleeve = "짧은 소매/Короткие рукава",
	LongSleeve	= "긴 소매/Длинные рукава",
	Potions		= "물약/Зелья",
	NoPotions	= "물약 없음/Нет зелий",
	Book		= "책/Книга",
	Pouch		= "주머니/Кошель"
})


-----------------------
-- <<<The Maw of Souls>>> --
-----------------------

-----------------------
-- Ymiron, the Fallen King --
-----------------------
L= DBM:GetModLocalization(1502)

-----------------------
-- Harbaron --
-----------------------
L= DBM:GetModLocalization(1512)

-----------------------
-- Helya --
-----------------------
L= DBM:GetModLocalization(1663)

L:SetMiscLocalization({
	Proshlyaping = "너희가 승리했다고 생각하느냐? 폭풍에서 살아남은 것일 뿐... 바다는 막을 수 없다.", --
	TaintofSeaYell = "%s disappears with %s. 조심해!"
})

-----------------------
--Maw of Souls Trash
-----------------------
L = DBM:GetModLocalization("MawTrash")

L:SetGeneralLocalization({
	name =	"영혼의 아귀 일반몹"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetMiscLocalization({
	Helya = "내 영역에 침범한 걸 후회하게 해주마."
})

-----------------------
-- <<<Assault Violet Hold>>> --
-----------------------

-----------------------
-- Mindflayer Kaahrj --
-----------------------
L= DBM:GetModLocalization(1686)

-----------------------
-- Millificent Manastorm --
-----------------------
L= DBM:GetModLocalization(1688)

-----------------------
-- Festerface --
-----------------------
L= DBM:GetModLocalization(1693)

-----------------------
-- Shivermaw --
-----------------------
L= DBM:GetModLocalization(1694)

-----------------------
-- Blood-Princess Thal'ena --
-----------------------
L= DBM:GetModLocalization(1702)

-----------------------
-- Anub'esset --
-----------------------
L= DBM:GetModLocalization(1696)

-----------------------
-- Sael'orn --
-----------------------
L= DBM:GetModLocalization(1697)

-----------------------
-- Fel Lord Betrug --
-----------------------
L= DBM:GetModLocalization(1711)

-----------------------
--Assault Violet Hold Trash
-----------------------
L = DBM:GetModLocalization("AVHTrash")

L:SetGeneralLocalization({
	name =	"보랏빛 요새 침공 일반몹"
})

L:SetWarningLocalization({
	WarningPortalSoon	= "곧 새 차원문 열림",
	WarningPortalNow	= "차원문 #%d",
	WarningBossNow		= "보스 등장"
})

L:SetTimerLocalization({
	TimerPortal			= "차원문 가능"
})

L:SetOptionLocalization({
	WarningPortalNow		= "새 차원문 등장시 경고 표시",
	WarningPortalSoon		= "새 차원문 사전 경고 표시",
	WarningBossNow			= "보스 등장 경고 표시",
	TimerPortal				= "다음 차원문 타이머 표시 (보스 처치 이후)"
})

L:SetMiscLocalization({
	Malgath		=	"군주 말가스"
})

-----------------------
-- <<<Vault of the Wardens>>> --
-----------------------

-----------------------
-- Tirathon Saltheril --
-----------------------
L= DBM:GetModLocalization(1467)

-----------------------
-- Inquisitor Tormentorum --
-----------------------
L= DBM:GetModLocalization(1695)

-----------------------
-- Ash'golm --
-----------------------
L= DBM:GetModLocalization(1468)

L:SetMiscLocalization({
	MurchalProshlyapOchko = "석실 방어 장치가 활성화 되었습니다."
})

-----------------------
-- Glazer --
-----------------------
L= DBM:GetModLocalization(1469)

-----------------------
-- Cordana --
-----------------------
L= DBM:GetModLocalization(1470)

-----------------------
--Vault of Wardens Trash
-----------------------
L = DBM:GetModLocalization("VoWTrash")

L:SetGeneralLocalization({
	name =	"감시관의 금고 일반몹"
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

L:SetMiscLocalization({
	proshlyapMurchalRP = "역시 예상대로군! 너희가 올 줄 알았다." --Прошляпанное очко Мурчаля Прошляпенко
})

-----------------------
-- <<<Return To Karazhan>>> --
-----------------------

-----------------------
-- Maiden of Virtue --
-----------------------
L= DBM:GetModLocalization(1825)

-----------------------
-- Opera Hall: Wikket  --
-----------------------
L= DBM:GetModLocalization(1820)

-----------------------
-- Opera Hall: Westfall Story --
-----------------------
L= DBM:GetModLocalization(1826)

L:SetMiscLocalization({
	Tonny = "한 바퀴 돌아 볼까?",
	Phase3 = "너와 내가 이 세상에 맞서는 거야!"
})

-----------------------
-- Opera Hall: Beautiful Beast  --
-----------------------
L= DBM:GetModLocalization(1827)

-----------------------
-- Attumen the Huntsman --
-----------------------
L= DBM:GetModLocalization(1835)

L:SetMiscLocalization({
	SharedSufferingYell = "%s on %s. RUN AWAY from me!",
	Perephase1 = "이제 사냥감을 정면으로 상대해야겠군!",
	Perephase2 = "천둥아, 우리는 승리를 향해 나아간다!"
})

-----------------------
-- Moroes --
-----------------------
L= DBM:GetModLocalization(1837)

-----------------------
-- The Curator --
-----------------------
L= DBM:GetModLocalization(1836)

-----------------------
-- Shade of Medivh --
-----------------------
L= DBM:GetModLocalization(1817)

-----------------------
-- Mana Devourer --
-----------------------
L= DBM:GetModLocalization(1818)

-----------------------
-- Viz'aduum the Watcher --
-----------------------
L= DBM:GetModLocalization(1838)

-----------------------
--Nightbane
-----------------------
L = DBM:GetModLocalization("Nightbane")

L:SetGeneralLocalization({
	name =	"파멸의 어둠"
})

-----------------------
--Return To Karazhan Trash
-----------------------
L = DBM:GetModLocalization("RTKTrash")

L:SetGeneralLocalization({
	name =	"다시 찾은 카라잔 일반몹"
})

L:SetOptionLocalization({
	timerRoleplay3 = "Отсчет времени до начала представления \"우끼드\"",
	timerRoleplay2 = "Отсчет времени до начала представления \"서부 몰락지대 이야기\"",
	timerRoleplay = "Отсчет времени до начала представления \"미녀와 짐승\"",
	timerRoleplay4 = DBM_CORE_OPTION_TIMER_DOOR_OPENING,
	OperaActivation = "Активировать представление в Опере в 1 нажатие"
})

L:SetTimerLocalization({
	timerRoleplay3 = "\"우끼드\"",
	timerRoleplay2 = "\"서부 몰락지대 이야기\"",
	timerRoleplay = "\"미녀와 짐승\"",
	timerRoleplay4 = DBM_CORE_GENERIC_TIMER_DOOR_OPENING
})

L:SetMiscLocalization({
	Beauty = "신사 숙녀 여러분, 안녕하십니까. 오늘 저녁의 특집 공연에 오신 것을 환영합니다!",
	Westfall = "신사 숙녀 여러분, 오늘 저녁의 특집 공연에 오신 것을 환영합니다!",
	Wikket = "신사 숙녀 여러분, 우리 공연에 잘-- 우욱!",
	Medivh1 = "나는 이 탑에 나의 파편들을 많이도 남겼었지...",
	speedRun = "어둠의 존재를 알리는 기묘한 한기가 주위에 퍼져나갑니다..."
})

-----------------------
-- <<<Cathedral of Eternal Night >>> --
-----------------------

-----------------------
-- Agronox --
-----------------------
L= DBM:GetModLocalization(1905)

-----------------------
-- Trashbite the Scornful  --
-----------------------
L= DBM:GetModLocalization(1906)

L:SetMiscLocalization({
	bookCase	=	"책장 뒤"
})

-----------------------
-- Domatrax --
-----------------------
L= DBM:GetModLocalization(1904)

-----------------------
-- Mephistroth  --
-----------------------
L= DBM:GetModLocalization(1878)

-----------------------
--Cathedral of Eternal Night Trash
-----------------------
L = DBM:GetModLocalization("CoENTrash")

L:SetGeneralLocalization({
	name =	"영원한 밤의 대성당 일반몹"
})

-----------------------
-- <<<Seat of Triumvirate >>> --
-----------------------

-----------------------
-- Zuraal --
-----------------------
L= DBM:GetModLocalization(1979)

-----------------------
-- Saprish  --
-----------------------
L= DBM:GetModLocalization(1980)

-----------------------
-- Viceroy Nezhar --
-----------------------
L= DBM:GetModLocalization(1981)

-----------------------
-- L'ura  --
-----------------------
L= DBM:GetModLocalization(1982)

-----------------------
--Seat of Triumvirate Trash
-----------------------
L = DBM:GetModLocalization("SoTTrash")

L:SetGeneralLocalization({
	name =	"삼두정의 권좌 일반몹"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_DOOR_OPENING,
	timerRoleplay2 = DBM_CORE_OPTION_TIMER_COMBAT,
	AlleriaActivation = DBM_CORE_GENERIC_TIMER_ROLE_PLAY
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_DOOR_OPENING,
	timerRoleplay2 = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetMiscLocalization({
	RP1 = "어둠수호병들이 사원 근처에서 세를 키우고 있어요.",
	RP2 = "안에서 크나큰 절망이 솟아나는 게 느껴지는군. 르우라야...",
	RP3 = "이 혼돈... 이 고통. 이런 건 느낀 적이 없어."
})

----------
--Мифик+--
----------
L = DBM:GetModLocalization("MAffix")

L:SetGeneralLocalization({
	name = "신화+ 어픽스"
})
