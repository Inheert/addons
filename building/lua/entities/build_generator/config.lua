CONFIG = CONFIG or {}

// Size of the area of the generator
CONFIG.areaSize = Vector(800, 800, 500)
// Initial electricity capacity of the entity
CONFIG.capacity = 50
// Max electricity capacity of the entity
CONFIG.maxCapacity = 100
// Time in second between refresh for electricity use
CONFIG.timeConsumption = 2
// Entities that used electricity
CONFIG.allowedEnts = {
    "build_spotlight"
}

function CONFIG:IsValid(ent)
    local classname = ent:GetClass()
    for i = 1, #CONFIG.allowedEnts do
        if (CONFIG.allowedEnts[i] == classname) then
            return (true)
        end
    end
    return (false)
end