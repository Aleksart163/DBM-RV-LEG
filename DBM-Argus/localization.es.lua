if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L

----------------
--rare enemies--
----------------
L = DBM:GetModLocalization("RareEnemiesArgus")

L:SetGeneralLocalization({
	name = "Enemigos muy peligrosos en Argus"
})

if GetLocale() == "esES" then --испанский
L:SetMiscLocalization{
	MurchalOchkenProshlyapen = "llegará pronto!",
	MurchalOchkenProshlyapen2 = "ha llegado! ¡A cubierto!"
}
else --мексиканский
L:SetMiscLocalization{
	MurchalOchkenProshlyapen = "llegará pronto!",
	MurchalOchkenProshlyapen2 = "ha llegado! ¡Cúbrete!"
}
end
