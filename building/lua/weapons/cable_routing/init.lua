AddCSLuaFile('cl_init.lua')
AddCSLuaFile('shared.lua')
include('shared.lua')

util.AddNetworkString("TraceShare")
util.AddNetworkString("ClientResponse")

hook.Run("DEBUG", "WEAPON SERVER OK")

net.Receive("TraceShare", function(len, ply)
    PrintTable(ply:GetEyeTrace())
end)

