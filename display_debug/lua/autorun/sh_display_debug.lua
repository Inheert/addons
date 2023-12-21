include("autorun/config.lua")

-- Si côté client
if (CLIENT) then
    -- Fonction pour ajouter un message à la liste côté client
    function DEBUG:AddMessage(message)
        -- Obtient le timestamp actuel
        local timestamp = os.time()
        -- Formatte la date
        local timeString = os.date( "%H:%M:%S" , timestamp )
        -- Ajoute la date au message
        message.date = timeString
        -- Ajoute le message à la liste
        table.insert(DEBUG.msgList, message)

        -- Supprime les messages dépassant la limite
        while (#DEBUG.msgList > DEBUG.messagesLimit) do
            table.remove(DEBUG.msgList, 1)
        end
    end
end

-- Fonction pour afficher un message, côté serveur ou client
function DEBUG:DisplayMessage(message)
    -- Détermine le côté (SERVER ou CLIENT)
    local side = SERVER and "SERVER" or "CLIENT"
    
    -- Vérifie si le message est valide
    if (message == nil) then return end

    -- Crée une table de données contenant le côté et le message
    local data = {side = side, message = message}
    
    -- Si côté serveur
    if (SERVER) then
        -- Envoie le message à tous les clients
        net.Start("ClientDisplayMessage")
        net.WriteTable(data)
        net.Broadcast()
    -- Si côté client
    elseif (CLIENT) then
        -- Ajoute le message à la liste côté client
        DEBUG:AddMessage(data)
    end
end

-- Ajoute un hook pour afficher un message lorsque l'événement "DisplayDebug" est déclenché
hook.Add("DEBUG", "DisplayMessage", function(message)
    DEBUG:DisplayMessage(message)
end)
