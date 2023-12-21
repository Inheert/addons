AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

local LIGHT_OFFSET = Vector(-80, 0, 100)
local SPOTLIGHT_BRIGHTNESS = 3
local SPOTLIGHT_DISTANCE = 800
local SPOTLIGHT_FOV = 500
// Correspond to the decimal fraction of a watt (1000 is equal to microwatt)
local UNIT = 1000

function ENT:Initialize()
	self:SetModel("models/props_c17/light_floodlight02_off.mdl")
	self:SetUseType(SIMPLE_USE)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:Wake()
		phys:EnableMotion(false)
	end
	
	self:SetLightFOV(SPOTLIGHT_FOV)
	self:SetDistance(SPOTLIGHT_DISTANCE)
	self:SetBrightness(SPOTLIGHT_BRIGHTNESS)
	self.parent = nil
end

function ENT:SpawnFunction(ply,tr,ClassName)
	if not tr.Hit then return end

	local ent = ents.Create(ClassName)
	ent:SetPos(tr.HitPos)
	ent:SetAngles(Angle(0,180+ply:EyeAngles().yaw,0))
	ent:Spawn() 
	ent:Activate()
    ent:SetEnabled(false)

	return ent
end

function ENT:OnRemove()
	if (IsValid(self.spotlight)) then
		self.spotlight:Remove()
	end
end

function ENT:Think()
	if (not self:GetEnabled()) then 
		if (IsValid(self.spotlight)) then
			self.spotlight:Remove()
			self.spotlight = nil
		end
		return 
	end

	local posOffset = Vector(LIGHT_OFFSET.x, LIGHT_OFFSET.y, LIGHT_OFFSET.z)
	posOffset:Rotate(self:GetAngles())
	local spotlightPos = self:GetPos() + posOffset
	local spotlightAng = self:GetAngles() + Angle(0, 0, 0)

	local spotlightColor = Color(255, 255, 255)
	spotlightColor = self:RandomizeColor(spotlightColor, 30, "left")

	self:SpawnSpotlight(spotlightPos, spotlightAng, spotlightColor)
end

function ENT:SpawnSpotlight(pos, ang, color)
	if (not self.spotlight) then
		self.spotlight = ents.Create("env_projectedtexture")
		self.spotlight:Spawn()
	end

	local brightness = self:GetBrightness()
    self.spotlight:SetPos(pos)
    self.spotlight:SetAngles(ang)
    self.spotlight:SetKeyValue("enableshadows", 1)
    self.spotlight:SetKeyValue("farz", self:GetDistance())
    self.spotlight:SetKeyValue("lightfov", self:GetLightFOV())

    self.spotlight:Input("SpotlightTexture", nil, nil, "effects/flashlight001")
	self.spotlight:SetSaveValue("m_LinearFloatLightColor",Vector(brightness * (color.r / 255), brightness * (color.g / 255), brightness * (color.b / 255)))
end

function ENT:RandomizeColor(color, variation, side)
	local newColor = Color(0, 0, 0)
	local min = {r = 0, g = 0, b = 0}
	local max = {r = 0, g = 0, b = 0}
	if (side == "left") then
		min.r = color.r - variation
		min.g = color.g - variation
		min.b = color.b - variation
		if (min.r < 0) then 
			min.r = 0
		elseif (min.g < 0) then 
			min.g = 0
		elseif (min.b < 0) then 
			min.b = 0
		end
		newColor = Color(math.random(min.r, color.r), math.random(min.g, color.g), math.random(min.b, color.b))
	end
	return (newColor)
end

function ENT:GetConsumption()
	local total = ((self:GetLightFOV() + self:GetDistance()) * self:GetBrightness()) / UNIT
	return (total)
end