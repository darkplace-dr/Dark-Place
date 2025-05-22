local krisrom, super = Class(Map)

function krisrom:onEnter()
    super.onEnter(self)

        if not Game:getFlag("frisk_unlock") then
            Game.world:spawnNPC("frisk", 180, 400, { cutscene = "misc.frisk" })
        end
end

return krisrom