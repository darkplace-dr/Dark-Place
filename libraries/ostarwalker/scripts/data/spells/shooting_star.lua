local spell, super = Class(Spell, "shooting_star")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "ShootingStar"
    -- Name displayed when cast (optional)
    self.cast_name = "SHOOTING STAR"

    -- Battle description
    self.effect = "Holy\nDamage"
    -- Menu description
    self.description = "Deals magical HOLY damage to\none enemy."

    -- TP cost
    self.cost = 16

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "enemy"

    -- Tags that apply to this spell
    self.tags = {"holy", "damage"}
end

function spell:onCast(user, target)
    -- Code the cast effect here
    -- If you return false, you can call Game.battle:finishAction() to finish the spell
    local function createParticle(x, y)
        local sprite = Sprite("effects/stars/attack", x, y)
        sprite:setOrigin(0.5, 0.5)
        sprite:setScale(2)
        sprite:play(3/30)
        sprite.layer = BATTLE_LAYERS["above_battlers"]
        Game.battle:addChild(sprite)
        return sprite
    end

    local userx, usery = user:getRelativePos(user.width/2, user.height/2, Game.battle)
    local targetx, targety = target:getRelativePos(target.width/2, target.height/2, Game.battle)


    local particles = {}
    local burst = {}
    local burstangle
    local con = 0
    Game.battle.timer:script(function(wait)
        wait(1/30)
        -- Initial star
        -- FIXME: ???
        Assets.playSound("snd_crow")
        particles = createParticle(userx, -25)

        -- Move star to target
        particles:slideTo(targetx, targety, 1)
        wait(1)

        
        
        -- Hide initial star, turns into smaller ones.
        particles.alpha = 0
        for i = 1, 4 do
            burstangle = (math.rad(45 + ((i - 1) * 90)))
            burst[i] = createParticle(particles.x, particles.y)
            burst[i].rotation = burstangle
            burst[i].physics.speed = 3
            burst[i].physics.match_rotation = true
            burst[i]:setScale(1)
            burst[i]:fadeOutAndRemove()
            burst[i]:play(1/15)
        end
        -- Calculate damage and deal it.
        Assets.playSound("stardrop")
        -- yes it's just the iceshock formula, I'm not a mathemetician
        local min_magic = Utils.clamp(user.chara:getStat("magic") - 10, 1, 999)
        local damage = math.ceil((min_magic * 30) + 90 + Utils.random(10))
        particles:remove()
        target:flash()
        target:hurt(damage, user)
        Game.battle:finishAction()
        
    end)

    return false
end

return spell