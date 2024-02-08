local actor, super = Class(Actor, "froggit")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Froggit"

    -- Width and height for this actor, used to determine its center
    self.light_battle_width = 55
    self.light_battle_height = 55

    self.hitbox = {0, 0, 16, 16}

    self.use_light_battler_sprite = true

    self.path = "enemies/froggit"
    self.default = "idle"

    self.animations = {
        ["lightbattle_hurt"] = {"lightbattle/hurt", 1, true},
        ["defeat"] = {"lightbattle/hurt", 1, true}
    }

    self:addLightBattlerPart("legs", {
        ["create_sprite"] = function()
            local sprite = Sprite(self.path.."/lightbattle/legs")
            sprite:play(1, true)
            return sprite
        end
    })
    
    self:addLightBattlerPart("head", {
        ["create_sprite"] = function()
            local sprite = Sprite(self.path.."/lightbattle/head", -2, 3)
            sprite.layer = 500
            sprite:play(2, true)
            -- local path = {{264, 300}, {272, 296}, {280, 300}, {272, 304}, {272, 292}}
            local path =    {{0, 0},     {2, -2},    {4, -1},    {2, 0},    {1, -3},   {0, 0}} -- still not accurate
            sprite:slidePath(path, {speed = 0.25, loop = true, relative = true})
            return sprite
        end
    })

end

return actor