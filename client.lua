local x, y = guiGetScreenSize()
local sx, sy = (x / 1280), (y / 720)

local ElementData_EstadoLogin = "EstadoLoginPLayer" --Element Data del estado login, osea si un jugador tiene el login abierto/cerrado (true/false)

local components = {
    "health", "breath", "armour", "wanted",
    "ammo", "weapon", "vehicle_name",
    "area_name", "clock", "money"
}

function formatMoney(amount)
    local formatted = tostring(math.abs(math.floor(amount)))
    local result = ""
    local count = 0
    for i = #formatted, 1, -1 do
        if count > 0 and count % 3 == 0 then
            result = "," ..result
        end
        result = formatted:sub(i, i) ..result
        count = count + 1
    end
    return (amount < 0 and "-" or "") ..result
end

function hud()
    if getElementData(localPlayer, ElementData_EstadoLogin) == true then return end
    
    local weapon = getPedWeapon(localPlayer)
    local weaponFile = (weapon == 44 and "JP") or (weapon == 45 and "PH") or tostring(weapon)
    local weaponPath = "weapons/" ..weaponFile..".png"
    dxDrawImage(1166*sx, 28*sy, 104*sx, 101*sy, weaponPath, 0, 0, 0, tocolor(255, 255, 255, 255), false)

    local slot = getPedWeaponSlot(localPlayer)
    local ammoClip = getPedAmmoInClip(localPlayer)
    local ammoTotal = getPedTotalAmmo(localPlayer)
    local ammoStr = ammoClip .."/"..(ammoTotal-ammoClip)
    if slot > 1 and slot < 10 then
        -- if ammoStr ~= "1/0" then
            dxDrawText(ammoStr, (1179-1)*sx, (119-1)*sy, (1260-1)*sx, (134-1)*sy, tocolor(0,0,0,255), 1.00, "default-bold", "center", "top", false, false, false, false, false)
            dxDrawText(ammoStr, (1179+1)*sx, (119-1)*sy, (1260+1)*sx, (134-1)*sy, tocolor(0,0,0,255), 1.00, "default-bold", "center", "top", false, false, false, false, false)
            dxDrawText(ammoStr, (1179-1)*sx, (119+1)*sy, (1260-1)*sx, (134+1)*sy, tocolor(0,0,0,255), 1.00, "default-bold", "center", "top", false, false, false, false, false)
            dxDrawText(ammoStr, (1179+1)*sx, (119+1)*sy, (1260+1)*sx, (134+1)*sy, tocolor(0,0,0,255), 1.00, "default-bold", "center", "top", false, false, false, false, false)
            dxDrawText(ammoStr, 1179*sx, 119*sy, 1260*sx, 134*sy, tocolor(255,255,255,255), 1.00, "default-bold", "center", "top", false, false, false, false, false)
        -- end
    end

    local armor = getPedArmor(localPlayer)
    local armorFill = math.floor((armor / 100) * 136*sx)
    dxDrawLine((1025-1)*sx, (73-1)*sy, (1025-1)*sx, 89*sy, tocolor(0,0,0,255), 1, false)
    dxDrawLine(1161*sx, (73-1)*sy, (1025-1)*sx, (73-1)*sy, tocolor(0,0,0,255), 1, false)
    dxDrawLine((1025-1)*sx, 89*sy, 1161*sx, 89*sy, tocolor(0,0,0,255), 1, false)
    dxDrawLine(1161*sx, 89*sy, 1161*sx, (73-1)*sy, tocolor(0,0,0,255), 1, false)
    dxDrawRectangle(1025*sx, 73*sy, 136*sx, 16*sy, tocolor(180,180,180,150), false)
    dxDrawRectangle(1025*sx, 73*sy, armorFill, 16*sy, tocolor(255,255,255,255), false)

    local health = getElementHealth(localPlayer)
    local healthFill = math.floor((health / 100) * 136*sx)
    dxDrawLine((1025-1)*sx, (99-1)*sy,  (1025-1)*sx, 115*sy, tocolor(0,0,0,255), 1, false)
    dxDrawLine(1161*sx, (99-1)*sy, (1025-1)*sx, (99-1)*sy, tocolor(0,0,0,255), 1, false)
    dxDrawLine((1025-1)*sx, 115*sy, 1161*sx, 115*sy, tocolor(0,0,0,255), 1, false)
    dxDrawLine(1161*sx, 115*sy, 1161*sx, (99-1)*sy, tocolor(0,0,0,255), 1, false)
    dxDrawRectangle(1025*sx, 99*sy, 136*sx, 16*sy, tocolor(180,180,180,150), false)
    dxDrawRectangle(1025*sx, 99*sy, healthFill, 16*sy, tocolor(200,0,0,255), false)

    local hour, min = getTime()
    local timeStr = string.format("%02d:%02d", hour, min)
    dxDrawText(timeStr, (1026-1)*sx, (40-1)*sy, (1156-1)*sx, (68-1)*sy, tocolor(0,0,0,255), 1.5, "pricedown", "center", "center", false, false, false, false, false)
    dxDrawText(timeStr, (1026+1)*sx, (40-1)*sy, (1156+1)*sx, (68-1)*sy, tocolor(0,0,0,255), 1.5, "pricedown", "center", "center", false, false, false, false, false)
    dxDrawText(timeStr, (1026-1)*sx, (40+1)*sy, (1156-1)*sx, (68+1)*sy, tocolor(0,0,0,255), 1.5, "pricedown", "center", "center", false, false, false, false, false)
    dxDrawText(timeStr, (1026+1)*sx, (40+1)*sy, (1156+1)*sx, (68+1)*sy, tocolor(0,0,0,255), 1.5, "pricedown", "center", "center", false, false, false, false, false)
    dxDrawText(timeStr, 1026*sx, 40*sy, 1156*sx, 68*sy, tocolor(255,255,255,255), 1.5, "pricedown", "center", "center", false, false, false, false, false)

    local money_mano = getPlayerMoney(localPlayer) or 0
    dxDrawText("$"..formatMoney(money_mano), (829-1)*sx, (139-1)*sy, (1260-1)*sx, (175-1)*sy, tocolor(0,0,0,255), 1.50, "pricedown", "right", "center", false, false, false, false, false)
    dxDrawText("$"..formatMoney(money_mano), (829+1)*sx, (139-1)*sy, (1260+1)*sx, (175-1)*sy, tocolor(0,0,0,255), 1.50, "pricedown", "right", "center", false, false, false, false, false)
    dxDrawText("$"..formatMoney(money_mano), (829-1)*sx, (139+1)*sy, (1260-1)*sx, (175+1)*sy, tocolor(0,0,0,255), 1.50, "pricedown", "right", "center", false, false, false, false, false)
    dxDrawText("$"..formatMoney(money_mano), (829+1)*sx, (139+1)*sy, (1260+1)*sx, (175+1)*sy, tocolor(0,0,0,255), 1.50, "pricedown", "right", "center", false, false, false, false, false)
    dxDrawText("$"..formatMoney(money_mano), 829*sx, 139*sy, 1260*sx, 175*sy, tocolor(82,168,86,255), 1.50, "pricedown", "right", "center", false, false, false, false, false)

    local money_bank = getElementData(localPlayer, Config.ElementDatas.Dinero_Banco) or 0
    dxDrawText("$"..formatMoney(money_bank), (829-1)*sx, (175-1)*sy, (1260-1)*sx, (211-1)*sy, tocolor(0,0,0,255), 1.50, "pricedown", "right", "center", false, false, false, false, false)
    dxDrawText("$"..formatMoney(money_bank), (829+1)*sx, (175-1)*sy, (1260+1)*sx, (211-1)*sy, tocolor(0,0,0,255), 1.50, "pricedown", "right", "center", false, false, false, false, false)
    dxDrawText("$"..formatMoney(money_bank), (829-1)*sx, (175+1)*sy, (1260-1)*sx, (211+1)*sy, tocolor(0,0,0,255), 1.50, "pricedown", "right", "center", false, false, false, false, false)
    dxDrawText("$"..formatMoney(money_bank), (829+1)*sx, (175+1)*sy, (1260+1)*sx, (211+1)*sy, tocolor(0,0,0,255), 1.50, "pricedown", "right", "center", false, false, false, false, false)
    dxDrawText("$"..formatMoney(money_bank), 829*sx, 175*sy, 1260*sx, 211*sy, tocolor(194,232,195,255), 1.50, "pricedown", "right", "center", false, false, false, false, false)

    --Desde aqui:
    local wanted_level = getPlayerWantedLevel(localPlayer)
    if wanted_level == 1 then
        dxDrawImage(1222*sx, 210*sy, 48*sx, 47*sy, "weapons/Star1.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(1190*sx, 210*sy, 48*sx, 47*sy, "weapons/Star2.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(1158*sx, 210*sy, 48*sx, 47*sy, "weapons/Star2.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(1126*sx, 210*sy, 48*sx, 47*sy, "weapons/Star2.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(1094*sx, 210*sy, 48*sx, 47*sy, "weapons/Star2.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(1062*sx, 210*sy, 48*sx, 47*sy, "weapons/Star2.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    elseif wanted_level == 2 then
        dxDrawImage(1222*sx, 210*sy, 48*sx, 47*sy, "weapons/Star1.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(1190*sx, 210*sy, 48*sx, 47*sy, "weapons/Star1.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(1158*sx, 210*sy, 48*sx, 47*sy, "weapons/Star2.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(1126*sx, 210*sy, 48*sx, 47*sy, "weapons/Star2.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(1094*sx, 210*sy, 48*sx, 47*sy, "weapons/Star2.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(1062*sx, 210*sy, 48*sx, 47*sy, "weapons/Star2.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    elseif wanted_level == 3 then
        dxDrawImage(1222*sx, 210*sy, 48*sx, 47*sy, "weapons/Star1.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(1190*sx, 210*sy, 48*sx, 47*sy, "weapons/Star1.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(1158*sx, 210*sy, 48*sx, 47*sy, "weapons/Star1.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(1126*sx, 210*sy, 48*sx, 47*sy, "weapons/Star2.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(1094*sx, 210*sy, 48*sx, 47*sy, "weapons/Star2.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(1062*sx, 210*sy, 48*sx, 47*sy, "weapons/Star2.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    elseif wanted_level == 4 then
        dxDrawImage(1222*sx, 210*sy, 48*sx, 47*sy, "weapons/Star1.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(1190*sx, 210*sy, 48*sx, 47*sy, "weapons/Star1.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(1158*sx, 210*sy, 48*sx, 47*sy, "weapons/Star1.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(1126*sx, 210*sy, 48*sx, 47*sy, "weapons/Star1.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(1094*sx, 210*sy, 48*sx, 47*sy, "weapons/Star2.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(1062*sx, 210*sy, 48*sx, 47*sy, "weapons/Star2.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    elseif wanted_level == 5 then
        dxDrawImage(1222*sx, 210*sy, 48*sx, 47*sy, "weapons/Star1.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(1190*sx, 210*sy, 48*sx, 47*sy, "weapons/Star1.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(1158*sx, 210*sy, 48*sx, 47*sy, "weapons/Star1.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(1126*sx, 210*sy, 48*sx, 47*sy, "weapons/Star1.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(1094*sx, 210*sy, 48*sx, 47*sy, "weapons/Star1.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(1062*sx, 210*sy, 48*sx, 47*sy, "weapons/Star2.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    elseif wanted_level == 6 then
        dxDrawImage(1222*sx, 210*sy, 48*sx, 47*sy, "weapons/Star1.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(1190*sx, 210*sy, 48*sx, 47*sy, "weapons/Star1.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(1158*sx, 210*sy, 48*sx, 47*sy, "weapons/Star1.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(1126*sx, 210*sy, 48*sx, 47*sy, "weapons/Star1.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(1094*sx, 210*sy, 48*sx, 47*sy, "weapons/Star1.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(1062*sx, 210*sy, 48*sx, 47*sy, "weapons/Star1.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    end
    
    --Hambre y sed:
    dxDrawImage(1229*sx, 602*sy, 41*sx, 38*sy, "weapons/sed.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawImage(1229*sx, 650*sy, 41*sx, 38*sy, "weapons/hambre.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)

    local hambre = getElementData(localPlayer, Config.ElementDatas.Hambre) or 0
    dxDrawText(hambre.."%", (1172-1)*sx, (653-1)*sy, (1229-1)*sx, (688-1)*sy, tocolor(0, 0, 0, 255), 1.30, "default-bold", "right", "center", false, false, false, false, false)
    dxDrawText(hambre.."%", (1172+1)*sx, (653-1)*sy, (1229+1)*sx, (688-1)*sy, tocolor(0, 0, 0, 255), 1.30, "default-bold", "right", "center", false, false, false, false, false)
    dxDrawText(hambre.."%", (1172-1)*sx, (653+1)*sy, (1229-1)*sx, (688+1)*sy, tocolor(0, 0, 0, 255), 1.30, "default-bold", "right", "center", false, false, false, false, false)
    dxDrawText(hambre.."%", (1172+1)*sx, (653+1)*sy, (1229+1)*sx, (688+1)*sy, tocolor(0, 0, 0, 255), 1.30, "default-bold", "right", "center", false, false, false, false, false)
    dxDrawText(hambre.."%", 1172*sx, 653*sy, 1229*sx, 688*sy, tocolor(255, 255, 255, 255), 1.30, "default-bold", "right", "center", false, false, false, false, false)
    
    local sed = getElementData(localPlayer, Config.ElementDatas.Sed) or 0
    dxDrawText(sed.."%", (1172-1)*sx, (610-1)*sy, (1229-1)*sx, (637-1)*sy, tocolor(0, 0, 0, 255), 1.30, "default-bold", "right", "center", false, false, false, false, false)
    dxDrawText(sed.."%", (1172+1)*sx, (610-1)*sy, (1229+1)*sx, (637-1)*sy, tocolor(0, 0, 0, 255), 1.30, "default-bold", "right", "center", false, false, false, false, false)
    dxDrawText(sed.."%", (1172-1)*sx, (610+1)*sy, (1229-1)*sx, (637+1)*sy, tocolor(0, 0, 0, 255), 1.30, "default-bold", "right", "center", false, false, false, false, false)
    dxDrawText(sed.."%", (1172+1)*sx, (610+1)*sy, (1229+1)*sx, (637+1)*sy, tocolor(0, 0, 0, 255), 1.30, "default-bold", "right", "center", false, false, false, false, false)
    dxDrawText(sed.."%", 1172*sx, 610*sy, 1229*sx, 637*sy, tocolor(255, 255, 255, 255), 1.30, "default-bold", "right", "center", false, false, false, false, false)
end

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), function()
    for _, component in ipairs(components) do
        setPlayerHudComponentVisible(component, false)
    end
    addEventHandler("onClientRender", root, hud)
end)

addEventHandler("onClientResourceStop", getResourceRootElement(getThisResource()), function()
    for _, component in ipairs(components) do
        setPlayerHudComponentVisible(component, true)
    end
end)
