if GetLocale() ~= "koKR" then return end
local L

----------------------------------
--  Ahn'Kahet: The Old Kingdom  --
----------------------------------
--  Prince Taldaram  --
-----------------------
L = DBM:GetModLocalization(581)

-------------------
--  Elder Nadox  --
-------------------
L = DBM:GetModLocalization(580)

---------------------------
--  Jedoga Shadowseeker  --
---------------------------
L = DBM:GetModLocalization(582)

---------------------
--  Herald Volazj  --
---------------------
L = DBM:GetModLocalization(584)

----------------
--  Amanitar  --
----------------
L = DBM:GetModLocalization(583)

---------------
--  Gundrak  --
----------------
--  Slad'ran  --
----------------
L = DBM:GetModLocalization(592)

---------------
--  Moorabi  --
---------------
L = DBM:GetModLocalization(594)

-------------------------
--  Drakkari Colossus  --
-------------------------
L = DBM:GetModLocalization(593)

-----------------
--  Gal'darah  --
-----------------
L = DBM:GetModLocalization(596)

-------------------------
--  Eck the Ferocious  --
-------------------------
L = DBM:GetModLocalization(595)

--------------------------
--  Halls of Lightning  --
--------------------------
--  General Bjarngrim  --
-------------------------
L = DBM:GetModLocalization(597)

-------------
--  Ionar  --
-------------
L = DBM:GetModLocalization(599)

---------------
--  Volkhan  --
---------------
L = DBM:GetModLocalization(598)

-------------
--  Loken  --
-------------
L = DBM:GetModLocalization(600)

-----------------
--  The Nexus  --
-----------------
--  Anomalus  --
----------------
L = DBM:GetModLocalization(619)

-------------------------------
--  Ormorok the Tree-Shaper  --
-------------------------------
L = DBM:GetModLocalization(620)

----------------------------
--  Grand Magus Telestra  --
----------------------------
L = DBM:GetModLocalization(618)

L:SetMiscLocalization({
	SplitTrigger1	= "여기엔 내가 참 많지.",
	SplitTrigger2 	= "과연 나를 감당할 수 있겠느냐!"
})

-------------------
--  Keristrasza  --
-------------------
L = DBM:GetModLocalization(621)

-----------------------------------
--  Commander Kolurg/Stoutbeard  --
-----------------------------------
L = DBM:GetModLocalization("Commander")

local commander = "알 수 없음"
if UnitFactionGroup("player") == "Alliance" then
	commander = "사령관 콜루르그"
elseif UnitFactionGroup("player") == "Horde" then
	commander = "사령관 스타우트비어드"
end

L:SetGeneralLocalization({
	name = commander
})

------------------------
--  Utgarde Pinnacle  --
--------------------------
--  Skadi the Ruthless  --
--------------------------
L = DBM:GetModLocalization(643)

L:SetMiscLocalization({
	CombatStart		= "웬 놈들이 감히 여길? 정신 차려라, 형제들아! 녀석들을 처치하면 거하게 한 상 차려 주마!",
	Phase2			= "피도 눈물도 없는 것들아! 불쌍한 비룡을 괴롭히다니, 가만두지 않겠다!"
})

-------------------
--  King Ymiron  --
-------------------
L = DBM:GetModLocalization(644)

-------------
--Трэш-мобы--
-------------
L = DBM:GetModLocalization("UPTrash")

L:SetGeneralLocalization({
	name = "우트가드 첨탑 일반몹"
})

-------------------------
--  Svala Sorrowgrave  --
-------------------------
L = DBM:GetModLocalization(641)

L:SetTimerLocalization({
	timerRoleplay		= "스발라 소로우그레이브 활성"
})

L:SetOptionLocalization({
	timerRoleplay		= "스발라 소로우그레이브 활성 바 보기"
})

L:SetMiscLocalization({
	SvalaRoleplayStart	= "주인님! 당신께서 주신 일을 행했습니다. 이제, 축복을 내려 주소서!"
})

-----------------------
--  Gortok Palehoof  --
-----------------------
L = DBM:GetModLocalization(642)

--------------------
--  Pit of Saron  --
---------------------
--  Ick and Krick  --
---------------------
L = DBM:GetModLocalization(609)

L:SetMiscLocalization({
	Barrage		= "빠른 속도로 지뢰를 만들어냅니다!"
})

----------------------------
--  Forgemaster Garfrost  --
----------------------------
L = DBM:GetModLocalization(608)

L:SetOptionLocalization({
	AchievementCheck	= "11번은 제발! 업적 실패시 파티 대화로 알리기"
})

L:SetMiscLocalization({
	SaroniteRockThrow	= "거대한 사로나이트 덩어리를 당신에게 던집니다!",
	AchievementWarning	= "경고 - 영구 결빙 중첩 높음: %s (%d 중첩)",
	AchievementFailed	= ">> 11번은 제발 업적 실패 : %s (%d 중첩) <<"
})

----------------------------
--  Scourgelord Tyrannus  --
----------------------------
L = DBM:GetModLocalization(610)

L:SetMiscLocalization({
	CombatStart		= "아아. 용감하고 용감한 모험가들아, 참견도 이제 끝이다. 네놈들 뒤에 있는 굴에서 뼈와 칼이 부딪치는 소리가 들리는가? 네놈들에게 곧 닥칠 죽음의 소리다.", --Cannot promise just yet if this is right emote, it may be the second emote after this, will need to do more testing.
	HoarfrostTarget	= "노려보며 얼음 공격을 준비합니다!",
	YellCombatEnd	= "말도 안 돼... 서릿발송곳니... 경고를..."
})
