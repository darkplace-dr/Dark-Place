local spell, super = Class(Spell, "gammabeam")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "Gamma Beam"
    -- Name displayed when cast (optional)
    self.cast_name = "GAMMA BEAM"

    -- Battle description
    self.effect = "ELEC\nDamage"
    -- Menu description
    self.description = "Deals a large amount of ELEC damage in multiple hits to one foe."

    -- TP cost
    self.cost = 60

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "enemy"

    -- Tags that apply to this spell
    self.tags = { "Damage", "Elec" }
end

function spell:getCastMessage(user, target)
    return "* " .. user.chara:getName() .. " used " .. self:getCastName() .. "!"
end

function spell:onCast(user, target)
    local damage = math.floor(((user.chara:getStat("attack") * 150) / 50 + (user.chara:getStat("magic") * 100) / 50) -
        (target.defense * 3))
    local targetX, targetY = target:getRelativePos(target.width / 2, target.height / 2, Game.battle)
    local userX, userY = user:getRelativePos(user.width, user.height / 2, Game.battle)
    local angle = Utils.angle(userX, userY, targetX, targetY)

    local beam_start = Sprite("effects/spells/brenda/gammabeam_start", userX + 32, userY)
    beam_start:setOrigin(0, 0.5)
    beam_start:setScale(2)
    beam_start.rotation = angle
    Assets.playSound("rainbowbeam")
    Game.battle:addChild(beam_start)
    Game.battle.timer:after(0.6, function()
        beam_start:fadeOutAndRemove(0.5)
    end)

    local newX = beam_start.x + 60
    local newY = beam_start.y + angle * 60
    Game.battle.timer:every(1 / 20, function()
        local beam_section = Sprite("effects/spells/brenda/gammabeam_section", newX, newY)
        beam_section:setOrigin(0, 0.5)
        beam_section:setScale(2)
        beam_section.rotation = angle
        Game.battle:addChild(beam_section)
        newX = beam_section.x + 60
        newY = beam_section.y + angle * 60
        Game.battle.timer:after(0.6, function()
            beam_section:fadeOutAndRemove(0.5)
        end)
    end)

    Game.battle.timer:after(0.3, function()
        Game.battle.timer:script(function(wait)
            for _ = 1, 5 do
                if target.health > 0 then
                    Assets.stopAndPlaySound("damage")
                    target:hurt(damage, user)
                    target:shake(6, 0, 0.5)
                end
                wait(0.1)
                if target.health <= 0 then break end
            end
            Game.battle:finishActionBy(user)
        end)
    end)

    return false
end

return spell