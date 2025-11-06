local Lib = {}

function Lib:init()
    -- init new values for encounter
    HookSystem.hook(Encounter, "init", function(orig, en, ...)
        orig(en, ...)
        en.funnycheat = 0
    end)
end

return Lib