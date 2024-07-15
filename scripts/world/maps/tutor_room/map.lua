local tutor_room, super = Class(Map)

function tutor_room:onEnter()
    super.onEnter(self)

    for i = 1, 4 do
        if Game.party[i] then
            local id = Game.party[i].id or "test"
            xpcall(function()
                Game.world:spawnNPC(id .. "_master", 180 + 80 * (i - 1), 400, { cutscene = "master." .. id })
            end, function()
                Game.world:spawnNPC("bepis_master", 180 + 80 * (i - 1), 400, { cutscene = "master.bepis" })
            end)
        end
    end
end

return tutor_room