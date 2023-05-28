local Spamton, super = Class(Actor, "spamtonneo")

function Spamton:init()
    super:init(self)
    self.width, self.height = 50, 84
    self.hitbox = {12,41, 30,40}
    self.path = "npcs/spamton"
    self.voice = "sneo"
    self.flip = "right"
end

function Spamton:createSprite()
    return SpamtonActor(self)
end

function Spamton:onSetAnimation(sprite, anim, ...)
    local args = {...}
    if anim == "idle" then
        sprite:resetParts()
    elseif anim == "down" then
        sprite:resetParts()
        sprite:setHeadFrame(1)
        sprite:setSwingSpeed(0.5)
    elseif anim == "shaking" then
        sprite:setHeadFrame(3)
        sprite:setAllPartsShaking(true)
        for _,part in ipairs(sprite.parts) do
            sprite:setSwingSpeed(0)
        end
    elseif anim == "walk" then
        sprite:setPartSine("arm_l", 0)
        sprite:setPartSine("leg_l", 0)
        sprite:setPartSine("arm_r", math.pi*27)
        sprite:setPartSine("leg_r", math.pi*27)
        for _,part in ipairs{"arm_l", "leg_l", "arm_r", "leg_r"} do
            sprite:setPartSwingSpeed(part, 3)
            sprite:setPartSwingRange(part, math.rad(50))
        end

        sprite:setHeadFrame(2)
        sprite:tweenPartRotation("head", math.rad(-10), 0.1, "out-quad")
    elseif anim == "aim" then
        sprite:resetParts()
        sprite:setHeadFrame(1)
        sprite:setPartSprite("arm_l", "npcs/spamton/arm_cannon")
        sprite:setPartSwingSpeed("arm_l", 0)
        local angle = args[1] or math.rad(170)
        sprite:tweenPartRotation("arm_l", angle, 0.3, "out-cubic")
    elseif anim == "death" then
        sprite:resetParts(true)
        sprite:setSwingSpeed(0)
        sprite:setPartSprite("head", "npcs/spamton/head_death")
    end
end

return Spamton