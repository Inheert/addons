ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Spotlight"
ENT.Author = "Inheert"
ENT.Spawnable = true
ENT.Category = "Building - Lights"
ENT.Editable = true

function ENT:SetupDataTables() 	-- Based on gmod_lamp lol
	self:NetworkVar("Bool",0,"Enabled",{ KeyName = "m_bEnabled", Edit = {type = "Boolean",order = 1,title = "Enabled"}})

	self:NetworkVar( "Float", 0, "LightFOV", { KeyName = "fov", Edit = { type = "Float", order = 3, min = 10, max = 170, title = "Light FOV" } } )
	self:NetworkVar( "Float", 1, "Distance", { KeyName = "dist", Edit = { type = "Float", order = 4, min = 64, max = 2048, title = "Light Distance" } } )
	self:NetworkVar( "Float", 2, "Brightness", { KeyName = "bright", Edit = { type = "Float", order = 5, min = 0, max = 8, title = "Light Brightness" } } )

	if (not SERVER) then return end
	self:NetworkVarNotify( "Enabled", self.OnUpdateLight )
	self:NetworkVarNotify( "LightFOV", self.OnUpdateLight )
	self:NetworkVarNotify( "Brightness", self.OnUpdateLight )
	self:NetworkVarNotify( "Distance", self.OnUpdateLight )
end


function ENT:GetLightPos()
	return self:GetPos() + self:GetUp()*79
end
