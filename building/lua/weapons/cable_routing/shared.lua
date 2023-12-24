-- Exemple de SWEP exécutant les fonctionnalités d'un outil existant

SWEP.PrintName = "Cable routing"
SWEP.Author = "Inheert"
SWEP.Category = "Building - Electricity"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.Primary.ClipSize = -1      -- Size of a clip
SWEP.Primary.DefaultClip = 0        -- Default number of bullets in a clip
SWEP.Primary.Automatic = false      -- Automatic/Semi Auto
SWEP.Primary.Ammo = ""

SWEP.Secondary.ClipSize = -1        -- Size of a clip
SWEP.Secondary.DefaultClip = -1     -- Default number of bullets in a clip
SWEP.Secondary.Automatic = false        -- Automatic/Semi Auto
SWEP.Secondary.Ammo = ""    

-- Assurez-vous que cela est côté serveur (dans le fichier shared.lua ou init.lua)
if SERVER then
    util.AddNetworkString("RopeCreation") -- Ajoutez le message réseau pour synchroniser la création de la corde

    net.Receive("RopeCreation", function(len, ply)
        local startPos = net.ReadVector()
        local endPos = net.ReadVector()

        -- Créer la corde
        local rope = constraint.Rope(
            game.GetWorld(),
            nil,
            0,
            0,
            startPos,
            Vector(0, 0, 0),
            endPos,
            Vector(0, 0, 0),
            128, -- Longueur de la corde
            0, -- Force de pause (set to 0 for no break force)
            0, -- Rayon
            "cable/cable2", -- Matériel de la corde (vous pouvez ajuster cela)
            false -- Ne pas créer automatiquement la corde
        )

        undo.Create("Rope")
        undo.AddEntity(rope)
        undo.SetPlayer(ply)
        undo.Finish()
    end)
end

-- Côté client (dans le fichier cl_init.lua ou shared.lua)

function SWEP:PrimaryAttack()
        if (not CLIENT) then return end
        local startPos = self.Owner:EyePos()
        local endPos = startPos + self.Owner:GetAimVector() * 500

        -- Envoyer les positions au serveur pour créer la corde
        net.Start("RopeCreation")
        net.WriteVector(startPos)
        net.WriteVector(endPos)
        net.SendToServer()

    self:SetNextPrimaryFire(CurTime() + 1)
end

function SWEP:SecondaryAttack()
    -- Ajoutez ici la logique pour votre attaque secondaire si nécessaire
    self:SetNextSecondaryFire(CurTime() + 1)
end

