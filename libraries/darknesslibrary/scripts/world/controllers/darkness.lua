local Darkness, super = Class(Event)

function Darkness:init(data)
    super.init(self, data)
    self.darkness = Game.world:spawnObject(DarknessOverlay(data.properties["alpha"] or 1), WORLD_LAYERS["below_ui"])
end

function Darkness:postLoad()
    local characters = {}
    if self.data.properties["characters"] then
        if self.data.properties["characters"] == "all" then
            characters = Game.stage:getObjects(Character)
        elseif self.data.properties["characters"] == "party" then
            characters = Utils.mergeMultiple({Game.world.player}, Game.stage:getObjects(Follower))
        elseif self.data.properties["characters"] == "player" then
            characters = {Game.world.player}
        else
            for _,chara in ipairs(Game.stage:getObjects(Character)) do
                if self.data.properties["characters"]:find(chara.actor.id) then
                    table.insert(characters, chara)
                end
            end
        end
    end

    local radius = self.data.properties["light_radius"] or 80
    local color = Utils.parseColorProperty(self.data.properties["light_color"] or "#ffffffff")
    if self.data.properties["light_alpha"] then
        color[4] = self.data.properties["light_alpha"]
    end
    for _,chara in ipairs(characters) do
        local light = LightSource(chara.width/2, chara.height/2, radius)
        light.color = color
        chara:addChild(light)
    end
end

return Darkness