if GetLocale() ~= "ptBR" then return end

local L

--Прошляпанное очко Мурчаля [✔]

-------------------
-- Feitiços Raid --
-------------------
L= DBM:GetModLocalization("Spells")

L:SetGeneralLocalization({
	name = "Feitiços Raid"
})

L:SetOptionLocalization({
	YellOnNapull	 		= "Relatar quando alguém usa o feitiço $spell:57934 ou similar",
	YellOnRaidCooldown		= "Relatar quando alguém usa o feitiço $spell:97462 ou similar",
	YellOnResurrect			= "Relatar quando um feitiço foi usado em alguém $spell:20484 ou similar",
	YellOnMassRes 			= "Relatar quando alguém usa o feitiço $spell:212036 ou similar",
	YellOnHeroism 			= "Relatar quando alguém usa o feitiço $spell:32182 ou similar",
	YellOnPortal 			= "Relatar quando alguém abrir $spell:224871 oder ein ähnliches",
	YellOnSoulwell 			= "Relatar quando alguém usa o feitiço $spell:29893",
	YellOnSoulstone 		= "Relatar quando um feitiço foi usado em alguém $spell:20707",
	YellOnRitualofSummoning = "Relatar quando alguém usa o feitiço $spell:698",
	YellOnSummoning 		= "Relatar quando se está a lançar um feitiço $spell:7720",
	YellOnSpiritCauldron 	= "Relatar quando alguém coloca $spell:188036",
	YellOnLavish 			= "Relatar quando alguém coloca $spell:201352 ou similar",
	YellOnRepair 			= "Relatar quando alguém coloca $spell:199109 ou similar",
	YellOnPylon 			= "Relatar quando alguém coloca $spell:199115",
	YellOnBank 				= "Relatar quando alguém coloca $spell:83958",
	YellOnToys 				= "Relatar quando alguém colocar brinquedos como $spell:61031",
	AutoSpirit 				= "Libertar espírito automaticamente"
})

L:SetMiscLocalization{
--	WhisperThanks 	= "%s Obrigado por %s!",
	SpellNameYell 	= "Usando %s!",
	HeroismYell 	= "%s %s usa um %s!",
	PortalYell 		= "%s %s abre %s!",
	SoulwellYell 	= "%s %s puts %s!",
	SoulstoneYell 	= "%s %s aplica %s on %s!",
	SummoningYell 	= "%s %s começa %s!"
}
