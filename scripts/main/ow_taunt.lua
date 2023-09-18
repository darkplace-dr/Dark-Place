function Mod:initTaunt()
    self.taunt_cooldown = 0
    self.taunt_lock_movement = false

    Utils.hook(Player, "isMovementEnabled",
        ---@return boolean
        ---@diagnostic disable-next-line: redefined-local
        function(orig, self)
            ---@diagnostic disable-next-line: redundant-return-value
            return orig(self)
                and not Mod.taunt_lock_movement
        end
    )
end

function Mod:updateTaunt()
    if
        (Game.party[1]:checkArmor("pizza_toque") or Game.save_name:upper() == "PEPPINO" or self.let_me_taunt)
        and Input.pressed("v", false)
        and self.taunt_cooldown == 0
        and (Game.state == "OVERWORLD" and Game.world.state == "GAMEPLAY" and not Game.world:hasCutscene() and not Game.lock_movement and not Kristal.Console.is_open and not Kristal.DebugSystem:isMenuOpen())
    then
        self.taunt_cooldown = 0.4
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
            shine:play(0.02, false, function()
                shine:remove()
                chara:resetSprite()
            end)

            ::continue::
        end

        Game.world.timer:after(0.2, function()
            self.taunt_lock_movement = false
        end)
    end

    self.taunt_cooldown = Utils.approach(self.taunt_cooldown, 0, DT)
end
