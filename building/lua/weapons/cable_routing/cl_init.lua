include('shared.lua')
include('config.lua')

function SWEP:Initialize()
    self.isActive = false
    hook.Add("HUDShouldDraw", "WeaponSwitchDetection", function()
        local activeWeapon = LocalPlayer():GetActiveWeapon()
        if (not IsValid(activeWeapon) or not activeWeapon:GetClass() == self:GetClass()) then
        end
    end)
end

function SWEP:PrimaryAttack()
    if (not IsFirstTimePredicted()) then return end

    net.Start("TraceShare")
    net.SendToServer()
end

function SWEP:OnRemove()
    hook.Remove("HUDPaint", "DrawInstructions")
end

function SWEP:Think()
    local ply = LocalPlayer()
    if (self.stage == nil) then
        self.stage = CONFIG.Stage[1]
    end
    if (ply:GetActiveWeapon() != self) then 
        hook.Remove("HUDPaint", "DrawInstructions")
        return 
    end
    hook.Add("HUDPaint", "DrawInstructions", function()
        self:DrawInstructions()
    end)
end

function SWEP:DrawInstructions()
    local scrw = ScrW()
    local scrh = ScrH()
    local width = 270
    local height = 50
    //draw.RoundedBox(0, scrw - (scrw / 2) - (width / 2), height, Color(0, 0, 0))
    draw.RoundedBox(0, scrw - (scrw / 2) - (width / 2), scrh - (height * 2), width, height, Color(253, 154, 57, 200))
    draw.SimpleText("Select an energy source", "HDRDemoText", scrw / 2, scrh - (height * 1.5), Color(255, 255, 255), 1, 1)
end
