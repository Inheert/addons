include('shared.lua')

function ENT:Initialize()
	self.hookID = "CollisionsBoudWS" .. tostring(self:EntIndex())
end

function ENT:Draw()
	self:DrawModel()
	self:DrawShadow(true)
end

// Used to show brush area, tick are delayed
function ENT:Think()

	local collisions = {self:GetCollisionA(), self:GetCollisionB()}
	local brushSize = self:GetBrushSize()
	local x = Vector(10, 10, 10)
	hook.Add( "PostDrawTranslucentRenderables", self.hookID, function()
		local pos = self:GetPos()

		render.SetColorMaterial()

		cam.IgnoreZ( true )
		render.DrawLine(collisions[1], collisions[1] + Vector(brushSize.x, 0, 0), Color(255, 0, 0) )
		render.DrawLine(collisions[1], collisions[1] + Vector(0, brushSize.y, 0), Color(255, 0, 0) )
		render.DrawLine(collisions[1], collisions[1] + Vector(0, 0, brushSize.z), Color(255, 0, 0) )
		render.DrawLine(collisions[1] + Vector(brushSize.x, 0, 0), collisions[1] + Vector(brushSize.x, 0, brushSize.z), Color(255, 0, 0) )
		render.DrawLine(collisions[1] + Vector(0, 0, brushSize.z), collisions[1] + Vector(brushSize.x, 0, brushSize.z), Color(255, 0, 0) )
		render.DrawLine(collisions[1] + Vector(0, 0, brushSize.z), collisions[1] + Vector(0, brushSize.y, brushSize.z), Color(255, 0, 0) )
		
		render.DrawLine(collisions[2], collisions[2] - Vector(brushSize.x, 0, 0), Color(255, 0, 0) )
		render.DrawLine(collisions[2], collisions[2] - Vector(0, brushSize.y, 0), Color(255, 0, 0) )
		render.DrawLine(collisions[2], collisions[2] - Vector(0, 0, brushSize.z), Color(255, 0, 0) )
		render.DrawLine(collisions[2] - Vector(brushSize.x, 0, 0), collisions[2] - Vector(brushSize.x, 0, brushSize.z), Color(255, 0, 0) )
		render.DrawLine(collisions[2] - Vector(0, 0, brushSize.z), collisions[2] - Vector(brushSize.x, 0, brushSize.z), Color(255, 0, 0) )
		render.DrawLine(collisions[2] - Vector(0, 0, brushSize.z), collisions[2] - Vector(0, brushSize.y, brushSize.z), Color(255, 0, 0) )
		cam.IgnoreZ( false )
	end)

    self:NextThink(CurTime() + self.Delay)
    return (true)
end

function ENT:OnRemove()
	hook.Remove("PostDrawTranslucentRenderables", self.hookID)
end


