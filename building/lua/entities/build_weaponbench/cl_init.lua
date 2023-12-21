include('shared.lua')

function ENT:Initialize()
	self.ghostUpMax = 3
	self.ghostRotate = 0
	self.ghostUp = 0
	self.ghostUpIncrement = 1
end

function ENT:Draw()
	self:DrawModel()
	self:DrawShadow(true)
end

function ENT:OnRemove()
    if IsValid(self.GeneratedEntity) then
        self.GeneratedEntity:Remove() -- Supprimer l'entité générée
    end
end

function ENT:SpawnGhostModel()
	util.PrecacheModel("models/w_weapons/w_hellsing.mdl")
    local spawnEnt = ents.CreateClientProp("models/w_weapons/w_hellsing.mdl") -- Remplacez "prop_physics" par le nom de l'entité que vous souhaitez créer
    spawnEnt:SetPos(self:GetPos())
	spawnEnt:SetAngles(self:GetAngles())
    spawnEnt:SetMaterial("models/wireframe")
	spawnEnt:SetColor(Color(255, 255, 255, 2))
	spawnEnt:SetRenderMode( RENDERMODE_TRANSCOLOR )
	spawnEnt:Spawn()
	local phys = spawnEnt:GetPhysicsObject()

	if IsValid(phys) then
		phys:Wake()
		phys:EnableMotion(false)
	end
	spawnEnt:SetCollisionGroup(COLLISION_GROUP_WORLD)
    
    if (not IsValid(spawnEnt)) then return end
	
    self.GeneratedEntity = spawnEnt
    hook.Run("DisplayDebug", tostring(spawnEnt) .. " Created!")
end

function ENT:Think()
    if (self.GeneratedEntity == nil) then
		self:SpawnGhostModel()
        return 
    end

    local posOffset = Vector(-35, 10, 55 + self.ghostUp) -- Ajustez le vecteur offset comme vous le souhaitez

    -- Récupérer l'angle de l'entité d'origine
    local angle = self:GetAngles()
    local sumAngles = angle.x + angle.y + angle.z
	local ghostAngle = Angle(self.ghostRotate * (angle.x / sumAngles), self.ghostRotate * (angle.y / sumAngles), self.ghostRotate * (angle.z / sumAngles))
	//hook.Run("DisplayDebug", tostring(angle) .. " " .. tostring(ghostAngle))

    local ghostAngles = Angle(0, self.ghostRotate, 0)
    -- Calculer la nouvelle position en ajoutant le décalage à la position actuelle
    local newPosition = self:GetPos()

    posOffset:Rotate(angle)
    -- Définir la nouvelle position de l'entité générée
    self.GeneratedEntity:SetPos(newPosition + posOffset)
    self.GeneratedEntity:SetAngles(angle + ghostAngle)
    self.ghostRotate = self.ghostRotate + 2
    if (self.ghostRotate >= 360) then
        self.ghostRotate = self.ghostRotate - 360
    end
	if (self.ghostUp >= self.ghostUpMax) then
		self.ghostUpIncrement = -0.05
	elseif (self.ghostUp <= 0) then
		self.ghostUpIncrement = 0.05
	end
	self.ghostUp = self.ghostUp + self.ghostUpIncrement
    //self.GeneratedEntity:Rotate(angle)
end