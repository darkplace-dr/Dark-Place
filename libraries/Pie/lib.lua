local Lib = {}

function Lib:init()
    if Kristal.getLibConfig("pie", "print_console_intro") ~= false then
        print("Thank you for using the Pie Library by Mr_Oinky!")
        print("(Pie v1.2.1 for Kristal v0.8.0)")
    end
end

return Lib