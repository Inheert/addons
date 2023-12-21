AddCSLuaFile('cl_init.lua')
AddCSLuaFile('shared.lua')
include('shared.lua')

util.AddNetworkString("WEAPON_WORKBENCH_GHOST")

-- Fonction d'initialisation de l'entité
function ENT:Initialize()
    if SERVER then
        self:SetModel("models/mosi/fallout4/furniture/workstations/weaponworkbench01.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        local phys = self:GetPhysicsObject()

        if IsValid(phys) then
            phys:Wake()
            phys:EnableMotion(false)
        end
    end
end

-- Fonction appelée lors de la suppression de l'entité principale
function ENT:OnRemove()
    if IsValid(self.GeneratedEntity) then
        self.GeneratedEntity:Remove() -- Supprimer l'entité générée
    end
end
