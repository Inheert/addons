local width = 500
hook.Add("HUDPaint", "DrawLiveData", function()
    local ply = LocalPlayer()
    local pos = ply:GetPos()
    local angle = ply:GetAngles()
    local trace = ply:GetEyeTrace()
    local scrw = ScrW()
    local scrh = ScrH()
    local height = 10
    draw.RoundedBox(0, scrw - width, 0, width, 250, Color(0,0,0,200))
    
    draw.DrawText("Position", "HDRDemoText", scrw - (width / 2), height, Color(200, 200, 200), 1)
    height = height + 20
    draw.DrawText("Vector(" .. tostring(pos) .. ")", "HudDefault", scrw - (width / 2), height, Color(200, 200, 200), 1)
    height = height + 30
    
    draw.DrawText("Angles", "HDRDemoText", scrw - (width / 2), height, Color(200, 200, 200), 1)
    height = height + 20
    draw.DrawText("Angles(" .. tostring(angle) .. ")", "HudDefault", scrw - (width / 2), height, Color(200, 200, 200), 1)
    height = height + 30
    
    draw.DrawText("Eye trace hit pos", "HDRDemoText", scrw - (width / 2), height, Color(200, 200, 200), 1)
    height = height + 20
    draw.DrawText("Vector(" .. tostring(trace["HitPos"]) .. ")", "HudDefault", scrw - (width / 2), height, Color(200, 200, 200), 1)
    height = height + 30

    draw.DrawText("Entity hit", "HDRDemoText", scrw - (width / 2), height, Color(200, 200, 200), 1)
    height = height + 20
    draw.DrawText(tostring(trace["Entity"]), "HudDefault", scrw - (width / 2), height, Color(200, 200, 200), 1)
    height = height + 30

    draw.DrawText("Entity class", "HDRDemoText", scrw - (width / 2), height, Color(200, 200, 200), 1)
    height = height + 20
    draw.DrawText(tostring(trace["Entity"]:GetClass()), "HudDefault", scrw - (width / 2), height, Color(200, 200, 200), 1)
    height = height + 30
end)