function Mod:initBattleTaunt()
    self.taunt_cooldown = 0
    self.state_blacklist = {
        "DEFENDINGBEGIN",
        "DEFENDING", -- handled by the soul itself, so this is ignored
        "DEFENDINGEND",
        "ENEMYDIALOGUE",
        "ATTACKING",
        "ACTIONS",
        "ACTIONSDONE",
        "INTRO",
        "TRANSITION",
        "TRANSITIONOUT"
    }
end

function Mod:updateBattleTaunt()
    if
        self:isTauntingAvaliable()
        and Input.pressed("taunt", false)
        and self.taunt_cooldown == 0
        and (Game.state == "BATTLE" and not Game.battle:hasCutscene())
        and not Utils.containsValue(self.state_blacklist, Game.battle.state)
        and not (OVERLAY_OPEN or TextInput.active)
    then
        self.taunt_cooldown = 2.1

        Assets.playSound("taunt", 0.5, Utils.random(0.9, 1.1))

        for _,chara in ipairs(Game.battle.party) do
            if not chara.actor or chara.is_down then goto continue end

            -- workaround due of actors being loaded first by registry
            local sprites = chara.actor.getTauntSprites and chara.actor:getTauntSprites() or chara.actor.taunt_sprites
            if not sprites or #sprites <= 0 then goto continue end

            local shine = Sprite("effects/taunt", chara:getRelativePos(chara.width/2, chara.height/2))
            shine:setOrigin(0.5, 0.5)
            shine:setScale(1)
            shine.layer = chara.layer - 0.1
            Game.battle:addChild(shine)

            chara:toggleOverlay(true)
            chara.overlay_sprite:setSprite(Utils.pick(sprites))
            shine:play(1/30, false, function()
                shine:remove()
                chara:toggleOverlay(false)
            end)

            ::continue::
        end

    end

    self.taunt_cooldown = Utils.approach(self.taunt_cooldown, 0, DT)
end