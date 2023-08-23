local Lib = {}

function Lib:init()
    if Kristal.getLibConfig("leveling", "print_console_intro") ~= false then
        print("Leveling System library loaded - It's time to get LOVE!")
    end
end

function Lib:postInit(new_file)
    if new_file then
        Game:setFlag("library_love", 1)
        Game:setFlag("library_experience", 0)
        Game:setFlag("library_kills", 0)
    end
end

function Lib:addGlobalEXP(exp)
    Game:setFlag("library_experience", Utils.clamp(Game:getFlag("library_experience", 0) + exp, 0, 99999))

    local max_love = #Kristal.getLibConfig("leveling", "global_xp_requirements")
    local leveled_up = false
    while
        Game:getFlag("library_experience") >= Kristal.callEvent("getGlobalNextLvRequiredEXP")
        and Game:getFlag("library_love", 1) < max_love
    do
        leveled_up = true
        Game:addFlag("library_love", 1)
        for _,party in ipairs(Game.party) do
            party:onLevelUpLVLib(Game:getFlag("library_love"))
        end
    end

    return leveled_up
end

function Lib:getGlobalNextLvRequiredEXP()
    return Kristal.getLibConfig("leveling", "global_xp_requirements")[Game:getFlag("library_love") + 1] or 0
end

function Lib:getGlobalNextLv()
    return Utils.clamp(Kristal.callEvent("getGlobalNextLvRequiredEXP") - Game:getFlag("library_experience"), 0, 99999)
end

return Lib
