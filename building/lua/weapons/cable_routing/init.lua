AddCSLuaFile('cl_init.lua')
AddCSLuaFile('shared.lua')
AddCSLuaFile('config.lua')
include('shared.lua')

util.AddNetworkString("TraceShare")
util.AddNetworkString("ClientResponse")

net.Receive("TraceShare", function(len, ply)
    PrintTable(ply:GetEyeTrace())
end)

function SWEP:Initialize()
    self:SetRed(350)
end
