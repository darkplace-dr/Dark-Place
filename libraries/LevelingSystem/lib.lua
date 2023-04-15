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

function Lib:getGlobalLevelupRequirementsTable()
    return {
      [ 1] = 0,
      [ 2] = 10,
      [ 3] = 30,
      [ 4] = 70,
      [ 5] = 120,
      [ 6] = 200,
      [ 7] = 300,
      [ 8] = 500,
      [ 9] = 800,
      [10] = 1200,
      [11] = 1700,
      [12] = 2500,
      [13] = 3500,
      [14] = 5000,
      [15] = 7000,
      [16] = 10000,
      [17] = 15000,
      [18] = 25000,
      [19] = 50000,
      [20] = 99999
  }
end

return Lib
