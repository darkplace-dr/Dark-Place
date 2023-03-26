local Lib = {}

function Lib:init()
  print("Leveling System library loaded - It's time to get LOVE!")
end

function Lib:postInit(new_file)
    if new_file then
        Game:setFlag("library_love", 1)
        Game:setFlag("library_experience", 0)
        Game:setFlag("library_nextlv", 10)
        Game:setFlag("library_reqexp", 10)
        Game:setFlag("library_kills", 0)
        Game:setFlag("library_maxlove", 20)
    end
end

return Lib
