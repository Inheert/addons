AddCSLuaFile('cl_init.lua')
AddCSLuaFile('shared.lua')
include('shared.lua')
include('brush.lua')
include("config.lua")

function ENT:Initialize()
    self:SetModel("models/props_vehicles/generatortrailer01.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    local phys = self:GetPhysicsObject()

    if (IsValid(phys)) then
        phys:Wake()
        phys:EnableMotion(false)
    end

    self.consumers = {}
    self.lastUpdate = CurTime()
    self:SetCapacity(CONFIG.capacity)
    self:SetBrushSize(CONFIG.areaSize)
    self.Brush = InitializeBrush(self)
    self.Brush:Spawn()
end

function ENT:Think()

    local now = CurTime()
    local consumption = 0
    local capacity = self:GetCapacity()
    if (self.lastUpdate + CONFIG.timeConsumption <= now) then
        print("Capacity (Watt):", capacity)
        for k, v in pairs(self.consumers) do
            if (v.parent == nil) then
                v.parent = self
            end
            print(IsValid(v) and v.parent == self and capacity > 0)
            if (IsValid(v) and v.parent == self and capacity > 0) then
                consumption = v:GetConsumption()
                capacity = math.Clamp(capacity - consumption, 0, capacity)
                if (v:GetEnabled() == false) then
                    v:SetEnabled(true)
                end
            elseif (IsValid(v) and v.parent == self and capacity <= 0) then
                v:SetEnabled(false)
                v.parent = nil
            end
        end
        print("Consommation (Watt):", consumption)
        print("")
        self:SetCapacity(capacity)
        self.lastUpdate = now
    end
    //self:EmitSound("ambient/atmosphere/thunder1.wav", 75, 100, 1, CHAN_AUTO)
end

// When entity remove also remove brush (action area)
function ENT:OnRemove()
    if (self.Brush != nil) then
        self.Brush:Remove()
    end
end
