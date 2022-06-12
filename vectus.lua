-- Vectus [7487495382]

local Service = setmetatable({}, {
    __index = function(self, ...)
        return game:service(...) or nil
    end
})

local Environment = setmetatable({}, {
    __index, __call = function(self, ...)
        return require(...) or nil
    end
})

local Players = Service.Players
local Player = Players.LocalPlayer

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/wally-rblx/uwuware-ui/main/main.lua"))()
local Combat = Library:CreateWindow("Melee")
local Misc = Library:CreateWindow("Misc")

Combat:AddToggle({
    text = "Enabled", 
    flag = "Enabled", 
    state = false
})

Combat:AddToggle({
    text = "Special Hits", 
    flag = "SpecialHits", 
    state = false
})

Combat:AddSlider({
    text = "Delay", 
    flag = "Delay", 
    value = .5, 
    min = 0, 
    max = 50, 
    float = 0.1
})

Misc:AddToggle({
    text = "No Fall Damage", 
    flag = "NoFallDamage", 
    state = false
})

local old = nil

old = hookmetamethod(game, "__namecall", function(...)
    local args = {...}
    local self = args[1]
    local method = getnamecallmethod()
    
    if tostring(self) == "" then
        if typeof(args) == "table" then
            if typeof(args[2]) == "table" then
                if typeof(args[3] == "table") then
                    if Library.flags.Enabled then
                        args[3].special = Library.flags.Special
                        args[3].delay = Library.flags.Delay
                    end
                end
            end
        end
    end
    
    if tostring(self) == "" then
        if typeof(args[2]) == "number" and Library.flags.NoFallDamage then
            return wait(9e0)
        end
    end

    return old(...)
end)

return Library
