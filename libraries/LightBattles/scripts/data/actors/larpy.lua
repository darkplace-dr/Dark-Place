local actor, super = Class(Actor, "larpy")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Larpy"

    -- Width and height for this actor, used to determine its center
    self.light_battle_width = 84
    self.light_battle_height = 62

    self.hitbox = {0, 0, 16, 16}

    self.use_light_battler_sprite = true

    self.path = "enemies/larpy"
    self.default = "idle"

    self.animations = {
        ["lightbattle_hurt"] = {"lightbattle/hurt", 1, true},
        ["defeat"] = {"lightbattle/hurt", 1, true}
    }

    self:addLightBattlerPart("legs", {
        ["create_sprite"] = function()
            local sprite = Sprite(self.path.."/lightbattle/legs", 10, 38)
            sprite:play(1, true)
            return sprite
        end,
        ["init"] = function(part)
            part.siner = 0
        end,
        ["update"] = function(part)
            part.siner = part.siner + 0.5 * DTMULT
            local movelegs = ((math.sin((part.siner/4)) * 1.5) * 0.25)
            part.sprite.y = part.sprite.y + movelegs * DTMULT
        end,
    })
    
    self:addLightBattlerPart("body", {
        ["create_sprite"] = function()
            local sprite = Sprite(self.path.."/lightbattle/body", 27, 19)
            sprite:play(1, true)
            sprite.layer = 500
            return sprite
        end
    })
	
    self:addLightBattlerPart("wing_l", {
        ["create_sprite"] = function()
            local sprite = Sprite(self.path.."/lightbattle/wing_l", 34, 17)
            sprite:play(1, true)
            sprite:setOrigin(1, 0)
            return sprite
        end,
        ["init"] = function(part)
            part.siner = 0
        end,
        ["update"] = function(part)
		    
            part.siner = part.siner + 0.5 * DTMULT
            local movewing_l = ((math.sin((part.siner/4)) * 2.5) * 0.5)
            part.sprite.rotation = part.sprite.rotation + math.rad(movewing_l) * DTMULT
        end,
    })
	
    self:addLightBattlerPart("wing_r", {
        ["create_sprite"] = function()
            local sprite = Sprite(self.path.."/lightbattle/wing_r", 50, 16)
            sprite:play(1, true)
            return sprite
        end,
        ["init"] = function(part)
            part.siner = 0
        end,
        ["update"] = function(part)
            part.siner = part.siner + 0.5 * DTMULT
            local movewing_r = ((math.sin((part.siner/4)) * 2.5) * 0.5)
            part.sprite.rotation = part.sprite.rotation - math.rad(movewing_r) * DTMULT
        end,
    })
	
    self:addLightBattlerPart("head", {
        ["create_sprite"] = function()
            local sprite = Sprite(self.path.."/lightbattle/head", 27, -4)
            sprite:play(1, true)
            sprite.layer = 501
            return sprite
        end,
        ["init"] = function(part)
            part.siner = 0
        end,
        ["update"] = function(part)
            part.siner = part.siner + 0.5 * DTMULT
            local movehead = ((math.sin((part.siner/4)) * 2.5) * 0.2)
            part.sprite.y = part.sprite.y + movehead * DTMULT
        end,
    })
end

function actor:onSpriteInit(sprite)
    sprite.siner = 0
end

function actor:onSpriteUpdate(sprite)
    sprite.siner = sprite.siner + 0.5 * DTMULT
	
    local moveself = ((math.sin((sprite.siner/4)) * 2.5) * 0.2)
	
    if sprite.anim == "lightbattle_hurt" then
        sprite.y = sprite.init_y
    else
        sprite.y = sprite.y + moveself * DTMULT
    end
end

return actor