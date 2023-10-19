local Goner, super = Class(Actor, "goner")

function Goner:init()

    love.window.setTitle("Spamton Sweepstakes")
    super:init(self)
    self.width = 19
    self.height = 37
    self.hitbox = {0, 25, 19, 14}
    --self.flip = "right"
    --self.anim = "walk"
    self.default = "party/goner/torsos/body_0/light/walk"
    self.walk_speed = 44
    self.walk_frame = 22
    self.name = "goner"
    self.color = {1, 1, 1}

    self.offsets = {
        -- Movement offsets
        ["walk/left"] = {0, 0},
        ["walk/right"] = {0, 0},
        ["walk/up"] = {0, 0},
        ["walk/down"] = {0, 0},
    
        ["slide"] = {0, 0},
    
        -- Battle offsets
        --["battle/idle"] = {-5, -1},
        -- -20, -24
        ["battle/idle"] = {0, -24},
    
    } 
end

function Goner:onSetAnimation(sprite, anim, ...)
    local args = {...}
    if anim == "slide" then
        --sprite:resetParts()
        sprite:setPartSprite("body_0", "party/goner/torsos/body_0/light/slide")
        sprite:setPartSprite("leg_0", "party/goner/legs/0_leg/light/slide")
    elseif anim == "battle/idle" then
        sprite:setPartSprite("body_0", "party/goner/torsos/body_0/light/battle/idle")
        sprite:setPartSprite("leg_0", "party/goner/legs/0_leg/light/battle/sword/idle")
    elseif anim == "walk" then
        sprite:setPartSprite("body_0", "party/goner/torsos/body_0/light/walk")
        sprite:setPartSprite("leg_0", "party/goner/legs/0_leg/light/walk")
    end
end

function Goner:createSprite()
    return GonerActor(self)
end



return Goner