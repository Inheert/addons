include("shared.lua")

function ENT:Initialize()
    self.PixVis1 = util.GetPixelVisibleHandle()
    self.PixVis2 = util.GetPixelVisibleHandle()
end

function ENT:GetSpritePos()
    local center = self:GetLightPos() + self:GetForward()
    local right = center - self:GetRight() * 15
    local left = center + self:GetRight() * 15
    return right, left
end

local matGlow = Material("sprites/light_ignorez")

function ENT:Draw()
    self:DrawModel()

    if (not self:GetEnabled()) then return end

    local color = Color(155, 156, 157)
    local randomizeColor = self:RandomizeColor(color, 15, "left")
    local right, left = self:GetSpritePos()
    local visR = util.PixelVisible(right, 12, self.PixVis1)
    local visL = util.PixelVisible(left, 12, self.PixVis2)

    render.SetMaterial(matGlow)

    if (visR > 0) then
        render.DrawSprite(right, 64 * visR, 64 * visR, randomizeColor)
    end

    if (visL > 0) then
        render.DrawSprite(left, 64 * visL, 64 * visL, randomizeColor)
    end
end

function ENT:RandomizeColor(color, variation, side)
    local newColor = Color(0, 0, 0)
    local min = { r = 0, g = 0, b = 0 }
    if side == "left" then
        min.r = color.r - variation
        min.g = color.g - variation
        min.b = color.b - variation
        if min.r < 0 then
            min.r = 0
        elseif min.g < 0 then
            min.g = 0
        elseif min.b < 0 then
            min.b = 0
        end
        newColor = Color(math.random(min.r, color.r), math.random(min.g, color.g), math.random(min.b, color.b))
    end
    return newColor
end
