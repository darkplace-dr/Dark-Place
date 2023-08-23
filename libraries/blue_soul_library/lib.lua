local Lib = {}

function Lib:init()
    if Kristal.getLibConfig("bluesoul", "print_console_intro") ~= false then
        print("the blue soul loaded!")
    end
end

return Lib