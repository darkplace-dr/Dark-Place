local Lib = {}

function Lib:init()
    if Kristal.getLibConfig("CharacterKeyItems", "print_console_intro") then
        print("Loaded CharacterKeyItems library")
    end
end

return Lib