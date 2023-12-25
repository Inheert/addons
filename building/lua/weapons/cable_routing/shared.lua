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

function SWEP:SetupDataTables()
    self:NetworkVar("String", 0, "ContextMessage")
    self:NetworkVar("Int", 1, "Red")
    self:NetworkVar("Int", 2, "Green")
    self:NetworkVar("Int", 3, "Blue")

    if (SERVER) then
        self:NetworkVarNotify("Red", self.OnColorChange)
        self:NetworkVarNotify("Green", self.OnColorChange)
        self:NetworkVarNotify("Blue", self.OnColorChange)
    end
end

function SWEP:OnColorChange(name, old, new)
    if (type(new) == "number" and new >= 0 and new <= 255) then return end
    if (name == "Red") then
        self:SetRed(old)
    elseif (name == "Green") then
        self:SetGreen(old)
    elseif (name == "Blue") then
        self:SetBlue(old)
    end
end
