local actor, super = Class(Actor, "rodenteerenemy")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Rodenteer"

    -- Width and height for this actor, used to determine its center
    self.light_battle_width = 41
    self.light_battle_height = 62

    self.hitbox = {0, 0, 16, 16}

    self.use_light_battler_sprite = true

    self.path = "battle/lightenemies/rodenteer"
    self.default = "idle"

    self.animations = {
        ["lightbattle_hurt"] = {"hurt", 1, true},
        ["defeat"] = {"hurt", 1, true}
    }
    
    self:addLightBattlerPart("tail", {
        ["create_sprite"] = function()
            local sprite = Sprite(self.path.."/tail", 25, 7)
            sprite:play(2, true)
            -- local path = {{264, 300}, {272, 296}, {280, 300}, {272, 304}, {272, 292}}
            local path =    {{0, 0},     {2, -2},    {4, -1},    {2, 0},    {1, -3},   {0, 0}} -- still not accurate
            sprite:slidePath(path, {speed = 0.25, loop = true, relative = true})
            return sprite
        end
    })

    self:addLightBattlerPart("body", {
        ["create_sprite"] = function()
            local sprite = Sprite(self.path.."/body", 0, 29)
            sprite.layer = 500
            sprite:play(1, true)
            return sprite
        end
    })

end

return actor