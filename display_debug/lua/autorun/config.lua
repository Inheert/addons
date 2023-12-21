DEBUG = DEBUG or {}

if (SERVER) then
    
elseif (CLIENT) then
    -- Nombre maximum de message stocké dans DEBUG.msgList
    DEBUG.messagesLimit = 500
    -- Hauteur maximum de l'HUD
    DEBUG.boxMaxHeight = ScrH() / 2
    -- Position X de l'HUD
    DEBUG.boxX = 0
    -- Position Y de l'HUD
    DEBUG.boxY = 0
    -- Largeur maximum de l'HUD
    DEBUG.boxMaxWidth = 80
    -- Liste des messages stockés par l'utilisateur
    DEBUG.msgList = DEBUG.msgList or {}
end