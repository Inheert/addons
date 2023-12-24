include('shared.lua')

function SWEP:Initialize()
end

function SWEP:PrimaryAttack()
    if (not IsFirstTimePredicted()) then return end

    net.Start("TraceShare")
    net.SendToServer()
end

function SWEP:Think()

end

hook.Add("HUDPaint", "DrawInstructions", function()
    local scrw = ScrW()
    local scrh = ScrH()
    local width = 270
    local height = 50
    //draw.RoundedBox(0, scrw - (scrw / 2) - (width / 2), height, Color(0, 0, 0))
    draw.RoundedBox(0, scrw - (scrw / 2) - (width / 2), scrh - (height * 2), width, height, Color(253, 154, 57, 200))
    draw.SimpleText("Select an energy source", "HDRDemoText", scrw / 2, scrh - (height * 1.5), Color(255, 255, 255), 1, 1)
end)
