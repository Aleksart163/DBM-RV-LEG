if GetLocale() ~= "ptBR" then return end

local L

--Прошляпанное очко Мурчаля ✔

------------------------
-- Mage Tower: TANK --
------------------------
L= DBM:GetModLocalization("Kruul")

L:SetGeneralLocalization({
	name = "O retorno do grão-lorde" --
})

------------------------
-- Mage Tower: Healer --
------------------------
L= DBM:GetModLocalization("ErdrisThorn")

L:SetGeneralLocalization({
	name = "O fim do perigo reanimado" --
-- "Ergam-se, meus soldados!" (активация босса)
-- Seu espírito forte resiste à magia vil! (эмоция когда окружили)
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("FelTotem")

L:SetGeneralLocalization({
	name = "Queda do Totem Vil" --
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("ImpossibleFoe")

L:SetGeneralLocalization({
	name = "Inimigo impossível" --
})

L:SetMiscLocalization({
	impServants = "Mate os Diabretes Serviçais antes que eles energizem Ágata!" --
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("Queen")

L:SetGeneralLocalization({
	name = "A fúria da Deusa-Rainha"
})

L:SetMiscLocalization({
	MurchalProshlyapRP = "O quê? O que eu estou fazendo? Isso não pode estar certo." --
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("Twins")

L:SetGeneralLocalization({
	name = "Dando jeito nos gêmeos" --
})

L:SetMiscLocalization({
	TwinsRP1 = "Imprestável! Afaste-se para eu fazer o que você não foi capaz.", --
	TwinsRP2 = "Mais uma vez sou eu que resolvo suas encrencas, irmão!" --
})

------------------------
-- Mage Tower: DPS --
------------------------
L= DBM:GetModLocalization("Xylem")

L:SetGeneralLocalization({
	name =	"Fechando o olho"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetMiscLocalization({
	Xylem = "Não... não é possível!" --
})

------------------------
-- Mage Tower: Timers --
------------------------
L= DBM:GetModLocalization("Timers")

L:SetGeneralLocalization({
	name = "Cronômetros de início de batalha"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetMiscLocalization({
	Kruul = "Tolos arrogantes! Eu me fortaleci com as almas de mil mundos conquistados!", --
	Twins = "Não permitirei que você use seu poder contra Azeroth, Raest. Se você não se render, serei obrigado a destruí-lo!", --
	ErdrisThorn = "Eu não fico para trás de jeito nenhum! Os ataques à minha cidade têm que acabar!", --
	Agatha = "Neste exato momento, meus sayaads estão seduzindo os seus magos patéticos. Seus aliados vão se render à Legião!", --
	Sigryn = "Você não pode se esconder atrás dessas muralhas para sempre, Odyn!", --
	Xylem = "Com a Íris Focalizadora, mandarei a energia arcana das linhas de meridiano de Azeroth para dentro do meu corpo!" -- Tarde demais, caçadora!
})
