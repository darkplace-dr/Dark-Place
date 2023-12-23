function Mod:initTaunt()
    self.taunt_lock_movement = false

    Utils.hook(Player, "isMovementEnabled",
        ---@overload fun(orig:function, self:Player) : boolean
        function(orig, self)
            return orig(self)
                and not Mod.taunt_lock_movement
        end
    )
end

function Mod:updateTaunt()
    local toque_equipped = false
    for _,party in ipairs(Game.party) do
        if party:checkArmor("pizza_toque") then toque_equipped = true end
    end
    if
        (toque_equipped or Game.save_name:upper() == "PEPPINO" or self.let_me_taunt)
        and Input.pressed("v", false)
        and not self.taunt_lock_movement
        and (Game.state == "OVERWORLD" and Game.world.state == "GAMEPLAY" and not Game.world:hasCutscene() and not Game.lock_movement)
        and not (OVERLAY_OPEN or TextInput.active)
    then
        self.taunt_lock_movement = true

        Assets.playSound("taunt", 0.5, Utils.random(0.9, 1.1))

        for _,chara in ipairs(Game.stage:getObjects(Character)) do
            if not chara.actor or not chara.visible then goto continue end

            -- workaround due of actors being loaded first by registry
            local sprites = chara.actor.getTauntSprites
                and chara.actor:getTauntSprites()
                or chara.actor.taunt_sprites
            if not sprites or #sprites <= 0 then goto continue end

            local shine = Sprite("effects/taunt", chara:getRelativePos(chara.width/2, chara.height/2))
            shine:setOrigin(0.5, 0.5)
            shine:setScale(1)
            shine.layer = chara.layer - 0.1
            Game.world:addChild(shine)

            chara.sprite:set(Utils.pick(sprites))
            shine:play(1/30, false, function()
                shine:remove()
                chara:resetSprite()
            end)

            ::continue::
        end

        Game.world.timer:after(1/3, function()
            self.taunt_lock_movement = false
        end)
    end
end
