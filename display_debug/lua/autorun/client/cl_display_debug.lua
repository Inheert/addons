-- Inclut le fichier contenant les fonctions DEBUG (sh_display_debug.lua)
include("autorun/sh_display_debug.lua")

-- Réception des messages côté client
net.Receive("ClientDisplayMessage", function()
    local serverMessage = net.ReadTable()
    DEBUG:AddMessage(serverMessage)
end)

-- Commande console pour effacer tous les messages DEBUG
concommand.Add("dd_clear", function(ply, cmd, args)
    DEBUG.msgList = {}
end)

concommand.Add("dd_height", function(ply, cmd, args)
    DEBUG.boxMaxHeight = args[1]
end)

-- Local variable utilisé pour définir la hauteur de la box,
local boxHeight = 0

-- Ajout d'un hook pour dessiner les données sur l'écran
hook.Add("HUDPaint", "DrawData", function()
    local ply = LocalPlayer()
    if not IsValid(ply) then return end

    local height = DEBUG.boxY + 15
    local x = 0
    local i = #DEBUG.msgList

    -- Dessine une boîte noire semi-transparente pour le fond des messages
    draw.RoundedBox(0, DEBUG.boxX, DEBUG.boxY, DEBUG.boxMaxWidth * 6, boxHeight - DEBUG.boxY, Color(0, 0, 0, 240))

    while (i > 1) do
        if (height + 10 >= DEBUG.boxMaxHeight + DEBUG.boxY) then
            boxHeight = height
            return
        end

        local msg = DEBUG.msgList[i]
        local color = Color(73, 175, 253)
        local letterCount = 0
        local line = ""

        -- Change la couleur si le message provient du côté CLIENT
        if (msg.side == "CLIENT") then
            color = Color(253, 202, 63)
        end

        -- Formatage du message
        msg = "[" .. tostring(msg.side) .. "]" .. " " .. tostring(msg.message) .. " (" .. tostring(msg.date) .. ")"

        for l = 1, #msg do
            line = line .. msg[l]
            if (l % DEBUG.boxMaxWidth == 0) then
                draw.SimpleText(line, "Default", DEBUG.boxX + 15, height, color, 0, 0)
                line = ""
                height = height + 12
            end
        end

        if (line != "") then
            draw.SimpleText(line, "Default", DEBUG.boxX + 15, height, color, 0, 0)
        end

        height = height + 15
        i = i - 1
    end
    boxHeight = height
end)

local x = Vector( 5, 5, 5 )
