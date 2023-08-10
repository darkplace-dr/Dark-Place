local Lib = {}

function Lib:init()
    if Kristal.getLibConfig("bluesoul", "print_console_intro") then
         print("the blue soul loaded!")
    end
end

return Lib