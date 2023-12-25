include("autorun/sh_commands.lua")

concommand.Add("remove", function(ply, cmd, args)
    local weapon = nil
    for i = 1, #args do
        weapon = ply:GetWeapon(args[i])
        if (IsValid(weapon)) then
            weapon:Remove()
        end
    end
end)