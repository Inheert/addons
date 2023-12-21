ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Generator trailer"
ENT.Category = "Building - Generator"
ENT.Author = "Inheert"
ENT.Spawnable = true
ENT.Editable = true
ENT.Delay = 1

function ENT:SetupDataTables()
    self:NetworkVar("Vector", 0, "BrushSize", {KeyName = "brushsize", Edit = {type = "Vector", order = 1, title = "Brush size"}})
    self:NetworkVar("Float", 0, "Capacity", {KeyName = "capacity", Edit = {type = "Float", order = 2, min = 0, max = 100}})
    self:NetworkVar("Vector", 1, "CollisionA", {KeyName = "collisiona"})
    self:NetworkVar("Vector", 2, "CollisionB", {KeyName = "collisionb"})

    self:NetworkVarNotify("BrushSize", self.OnBrushChange)
end

function ENT:OnBrushChange(name, old, new)
end