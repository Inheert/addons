include("config.lua")

CONFIG.SERVER = CONFIG.SERVER or {}

function InitializeBrush(parent)
    local Brush = ents.Create("base_brush")

    function Brush:Initialize()
        self.parent = parent
        self.lastVectorA = Vector(0, 0, 0)
        self:SetSolid(SOLID_BBOX)
        self:SetCollisionBoundsWS(Vector(0, 0, 0), Vector(0, 0, 0))
    end

    function Brush:Think()

        local brushCollision = self:GetPositions()
        if (self.lastVectorA != brushCollision[1]) then
            parent:SetCollisionA(brushCollision[1])
            parent:SetCollisionB(brushCollision[2])
            self:SetCollisionBoundsWS(brushCollision[1], brushCollision[2])
        end
        self.lastVectorA = brushCollision[1]
    end
    
    function Brush:Touch(ent)
        if (not CONFIG:IsValid(ent)) then return end
    end

    function Brush:StartTouch(ent)
        if (not CONFIG:IsValid(ent)) then return end
        local strEnt = tostring(ent)
        self.parent.consumers[strEnt] = ent
        if (ent.parent == nil) then
            ent.parent = self.parent
        end
        ent:SetEnabled(true)
    end

    function Brush:EndTouch(ent)
        if (not CONFIG:IsValid(ent)) then return end

        local strEnt = tostring(ent)
        if (ent.parent == self.parent) then
            self.parent.consumers[strEnt] = nil
            ent.parent = nil
        end
        
        ent:SetEnabled(false)
    end

    function Brush:GetPositions()
        local pos = self.parent:GetPos()
        local brushSize = parent:GetBrushSize()
        local xMiddle = brushSize.x / 2
        local yMiddle = brushSize.y / 2
        local vectorA = Vector(pos.x - xMiddle, pos.y - yMiddle, pos.z)
        local vectorB = Vector(pos.x + xMiddle, pos.y + yMiddle, pos.z + brushSize.z)

        return ({vectorA, vectorB})
    end

    return (Brush)
end
