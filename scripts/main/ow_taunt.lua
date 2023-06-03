function Mod:initTaunt()
    self.taunt_cooldown = 0
end

function Mod:updateTaunt()
    if
        Game.state == "OVERWORLD" and Game.world.menu == nil and not Game.world:hasCutscene()
        and Input.pressed("v", false)
        and (Game.party[1]:checkArmor("pizza_toque") or Game.save_name:upper() == "PEPPINO" or self.let_me_taunt)
        and self.taunt_cooldown == 0
    then
        self.taunt_cooldown = 0.40

        Game.lock_movement = true
        Assets.playSound("taunt", 0.5, Utils.random(0.9, 1.1))

        for chara_id,sprites in pairs(self.taunt_sprites) do
            local chara = Game.world:getCharacter(chara_id)
            if not chara then
                goto continue
            end

            chara:setSprite(Utils.pick(sprites))

            -- the shine effect
            local effect = Sprite("effects/taunteffect", 10, 15)
            effect:setOrigin(0.5)
            effect:setScale(0.5)
            effect.layer = -1
            effect:play(0.02, false, function()
                effect:remove()
                chara:setSprite(chara.actor.default)
            end)
            chara:addChild(effect)

            ::continue::
        end

        Game.world.timer:after(0.2, function()
            Game.lock_movement = false
        end)
    end
    self.taunt_cooldown = Utils.approach(self.taunt_cooldown, 0, DT)
end