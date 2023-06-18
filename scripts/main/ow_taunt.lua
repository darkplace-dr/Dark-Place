function Mod:initTaunt()
    self.taunt_cooldown = 0
end

function Mod:updateTaunt()
    if
        (Game.party[1]:checkArmor("pizza_toque") or Game.save_name:upper() == "PEPPINO" or self.let_me_taunt)
        and Input.pressed("v", false)
        and self.taunt_cooldown == 0
        and (Game.state == "OVERWORLD" and not Game.lock_movement and Game.world.state ~= "MENU" and not Game.world:hasCutscene())
    then
        self.taunt_cooldown = 0.4

        Game.lock_movement = true
        Assets.playSound("taunt", 0.5, Utils.random(0.9, 1.1))

        --[[local party_member_charas = {}
        party_member_charas[Game.world.player.actor.id] = Game.world.player
        for _, follower in ipairs(Game.world.followers) do
            party_member_charas[follower.actor.id] = follower
        end]]

        for _,chara in ipairs(Game.stage:getObjects(Character)) do
            if not chara.actor then goto continue end
            --[[if party_member_charas[chara.actor.id] and party_member_charas[chara.actor.id] ~= chara then
                goto continue
            end]]

            -- workaround due of actors being loaded first by registry
            local sprites = chara.actor.getTauntSprites and chara.actor:getTauntSprites() or chara.actor.taunt_sprites
            if not sprites or #sprites <= 0 then goto continue end

            -- the shine effect
            local effect = Sprite("effects/taunteffect", 10, 15)
            effect:setOrigin(0.5)
            effect:setScale(0.5)
            effect.layer = -1
            effect:play(0.02, false, function()
                effect:remove()
                chara:resetSprite()
            end)
            chara:addChild(effect)
            chara.sprite:set(Utils.pick(sprites))

            ::continue::
        end

        Game.world.timer:after(0.2, function()
            Game.lock_movement = false
        end)
    end
    self.taunt_cooldown = Utils.approach(self.taunt_cooldown, 0, DT)
end