local actor, super = Class(Actor, "brenda_master")


function actor:init(chara)
    super.init(self)
    self.name = "brenda_master"
    self.width = 34
    self.height = 34
    self.hitbox = {0, 24.5, 34, 9.5}
    self.color = {1, 1, 1}
    self.path = "tutorial_masters/brenda_master"
    self.default = "idle"
    self.voice = nil

    self.portrait_path = nil

    self.portrait_offset = nil

    self.can_blush = false

    self.animations = {
        ["idle"] = {"idle", 0.25, true},
        ["bop"] = {"bop", 0.25, true},
        ["shocked"] = {"shocked", 0.25, true},
    }

    self.offsets = {
    }
end

function actor:onSpriteInit(sprite)
    sprite:setScaleOrigin(0, 1)

    sprite.top_bop = 1.055
    sprite.low_bop = 0.95
    sprite.speed = 0.43

    sprite.left_bop = 0.5
    sprite.right_bop = -0.5

    sprite.active = 0
    sprite.stween = 1
    sprite.bean = 0
    sprite.rightside = 0

    sprite.body = Sprite(self.path.."/body")
    sprite:addChild(sprite.body)
    sprite.body:setScaleOrigin(0, 1)

    sprite.face = Sprite(self.path.."/face")
    sprite:addChild(sprite.face)

    sprite.hat = Sprite(self.path.."/hat")
    sprite:addChild(sprite.hat)
    sprite.hat:setOrigin(0, 0)
end

function actor:ResetMaster(sprite)
    sprite.upside = 0
    sprite.downside = 0
    sprite.leftside = 0
    sprite.rightside = 0
    sprite.stween = 1
    sprite.body:setScale(1, 1)
    sprite.hat:setPosition(0, 0)
    sprite.face:setPosition(0, 0)
end

function actor:MasterBOP(sprite)
    sprite.active = 1
    sprite.rightside = 1
end

function actor:bopUP(sprite)
    sprite.upside = 1
end

function actor:bopDOWN(sprite)
    sprite.downside = 1
end

function actor:bopRIGHT(sprite)
    sprite.rightside = 1
end

function actor:bopLEFT(sprite)
    sprite.leftside = 1
end

function actor:onSetSprite(sprite, new_texture)
    if new_texture == "bop" then
        sprite.stween = 1
        sprite.bean = 1
        sprite.active = 1
        sprite.upside = 1
        sprite.rightside = 1
    elseif new_texture == "idle" then
        sprite.face:setSprite(self.path.."/face")
        sprite.stween = 1
        sprite.active = 0
        sprite.bean = 1
        sprite.body:setScale(1, 1)
        sprite.hat:setPosition(0, 0)
        sprite.face:setPosition(0, 0)

        sprite.upside = 0
        sprite.rightside = 0
        sprite.downside = 0
        sprite.leftside = 0
    elseif new_texture == "shocked" then
        sprite.active = 2
        sprite.rightside = 1
        sprite.leftside = 0

        sprite.face:setSprite(self.path.."/face_shocked")
    end
end

function actor:onSpriteUpdate(sprite)
    if sprite.active == 1 then
        if sprite.rightside == 1 then
            sprite.rightside = 0
            Game.world.timer:tween(sprite.speed*2, sprite, {bean = sprite.left_bop}, "out-quad", function() actor:bopLEFT(sprite) end)
        elseif sprite.leftside == 1 then
            sprite.leftside = 0
            Game.world.timer:tween(sprite.speed*2, sprite, {bean = sprite.right_bop}, "out-quad", function() actor:bopRIGHT(sprite) end)
        end
        if sprite.upside == 1 then
            sprite.upside = 0
            Game.world.timer:tween(sprite.speed, sprite, {stween = sprite.low_bop}, "out-quad", function() actor:bopDOWN(sprite) end)
            sprite.beret = 1
        elseif sprite.downside == 1 then
            sprite.downside = 0
            Game.world.timer:tween(sprite.speed, sprite, {stween = sprite.top_bop}, "out-quad", function() actor:bopUP(sprite) end)
            sprite.beret = 1
        end
            sprite.body:setScale(1, sprite.stween)
            sprite.hat:setPosition(sprite.bean*2 + 0.5, -sprite.stween*35 + 35.5)
            sprite.face:setPosition(sprite.bean*4, sprite.stween*20 - 20)
    elseif sprite.active == 2 then

        if sprite.rightside == 1 then
            sprite.rightside = 0
            Game.world.timer:tween(0.1, sprite, {bean = sprite.left_bop*1.5}, "out-quad", function() actor:bopLEFT(sprite) end)
        elseif sprite.leftside == 1 then
            sprite.leftside = 0
            Game.world.timer:tween(0.1, sprite, {bean = sprite.right_bop*1.5}, "out-quad", function() actor:bopRIGHT(sprite) end)
        end
        sprite.face:setPosition(-sprite.bean, 0)
        sprite.hat:setPosition(0, -sprite.bean - 5)
    else
        sprite.stween = 1
        sprite.bean = 1
    end
end

return actor