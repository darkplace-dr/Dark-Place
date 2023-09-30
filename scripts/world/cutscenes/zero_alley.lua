return{

    choice = function (cutscene)
        if Game.zero_quick
        or Input.down("kp0") or Input.down("0") -- You're welcome, speedrunners.
        then
            cutscene:gotoCutscene("zero_alley", "start_quick")
        else
            cutscene:gotoCutscene("zero_alley", "start")
        end
    end,

    -- very much wip
    start = function (cutscene, event)
        -- Play the faster cutscene after a failed attempt.
        Game.zero_quick = true

        --Game.lock_movement = false
        local zero = cutscene:getEvent(5) -- ID for the Zero NPC.
        local player = Game.world.player
        local susie = cutscene:getCharacter("susie")

        -- Zero charges at the player (or Susie if she's in the party), wait until he reaches them
        zero.layer = WORLD_LAYERS["ui"] - 1
        zero:setAnimation("run")
        if susie then
            cutscene:slideToSpeed(zero, susie.x+50, player.y, 20)
            susie.layer_old = susie.layer
            susie.layer = WORLD_LAYERS["ui"] - 2
        else
            cutscene:slideToSpeed(zero, player.x+60, player.y, 20)
        end
        Assets.playSound("escaped")
        cutscene:wait(0.5)
        if Game.party[1].name == "YOU" then player:setSprite("fightorflight") player:shake() end
        cutscene:wait(function () return zero.x <= player.x+60 end)

        -- Pause, Timeslow FX go here once I can figure it out. Pressing UP continues the cutscene, with YOU stepping out of the way.
        zero.x = player.x+60
        zero.active = false
        cutscene:text("* Timeslow FX will go here,[wait:5] press [UP] to continue.")
        cutscene:wait(function () return Input.down("up") and not Kristal.Console.is_open end)
        player.y = player.y - 34
        player.facing = "down"
        player:setSprite("seentoomuch")

        -- Resume. if Susie is in the party, wait until Zero reaches her, then the two will clash.
        zero.active = true
        if susie then
            cutscene:wait(function () return zero.x <= susie.x+50 end)
            zero.x = susie.x + 50
            zero.y = susie.y
            Assets.playSound("zero/normal_slash_" .. math.ceil(Utils.random(3)))
            zero:setAnimation("struggle")
            cutscene:detachFollowers()
            cutscene:setSprite(susie, "hold_axe")
            susie.graphics.shake_x = 1
            Assets.playSound("wing")
            local sword_struggle = Assets.playSound("sword_struggle")
            sword_struggle:setLooping(true)
            sword_struggle:play()
            cutscene:wait(0.5)
            cutscene:text("[facec:susie_bangs/nervous_annoyed]* W-Woah![wait:5] The hell's your problem!?", "angry_b", "susie")
            sword_struggle:stop()

            -- Susie knocks Zero away.
            zero:setAnimation("hurt_fly")
            zero.physics.speed = 20
            zero.physics.direction = math.rad(-70)
            zero.physics.gravity = 1
            -- offsets are weird so we need to fake an attack animation with this
            susie.alpha = 0
            local battleanims = Sprite("party/susie/dark/battle/attack")
            battleanims.x = -26 battleanims.y = -25
            battleanims:play(1/15, false)
            susie:addChild(battleanims)
            susie.graphics.shake_x = 0
            Assets.playSound("laz_c")
            Assets.playSound("bigcut")
            cutscene:wait(1/30)

            -- After a moment, Zero hits the ground.
            cutscene:wait(function () return zero.y >= 310 end)
            zero.physics.speed = 0
            zero.physics.direction = 0
            zero.physics.gravity = 0
            zero.y = 310
            zero:setAnimation("hurt_ground")
            Assets.playSound("impact")

            --Susie steps forward, in attackready pose
            cutscene:wait(0.5)
            Assets.playSound("weaponpull_fast")
            susie.physics.speed = 5
            susie.physics.friction = 0.5
            battleanims:setSprite("party/susie/dark/battle/attackready")
        

            -- Zero gets up and draws his sword, beginning the fight.
            zero:setAnimation("hurt_recover")
            cutscene:wait(1)
            Assets.playSound("sword_draw")
            zero:setAnimation("threaten")
            cutscene:wait(0.5)
            cutscene:startEncounter("zero", true, {{"zero", zero}})
        

        -- If Susie is NOT in the party...
        else
            -- Zero attacks and slides forward a bit.
            zero:setAnimation("attack")
            local slashfx = Sprite("effects/KatanaSlash")
            zero:addChild(slashfx)
            Assets.playSound("zero/normal_slash_" .. math.ceil(Utils.random(3)))
            slashfx.x = slashfx.x - 45
            slashfx:play(1/25, false, function ()
                slashfx:remove()
            end)
            if Game.party[2] then
            zero.physics.speed = -20
            else
            zero.physics.speed = -15
            end
            zero.physics.friction = 0.7
            cutscene:wait(1)

            -- Zero turns around and draws his sword, beginning the fight.
            zero.flip_x = true
            zero.x = zero.x - 50
            Assets.playSound("sword_draw")
            zero:setAnimation("threaten")
            cutscene:wait(0.5)
            cutscene:startEncounter("zero", true, {{"zero", zero}})

        end

        if player.y < 263 then cutscene:slideTo(player, player.x, player.y + 34, 0.5) end

        
        --cutscene:attachFollowers()
        
    end,

    start_quick = function (cutscene, event)
        local zero = cutscene:getEvent(5) -- ID for the Zero NPC.
        local player = Game.world.player
        local susie = cutscene:getCharacter("susie")

        -- Zero charges at the player (or Susie if she's in the party), wait until he reaches them
        zero.layer = WORLD_LAYERS["ui"] - 1
        zero:setAnimation("run")
        if susie then
            cutscene:slideToSpeed(zero, susie.x+50, player.y, 20)
            susie.layer_old = susie.layer
            susie.layer = WORLD_LAYERS["ui"] - 2
        else
            cutscene:slideToSpeed(zero, player.x+60, player.y, 20)
        end
        Assets.playSound("escaped")


        cutscene:wait(function () return zero.x <= player.x+60 end)
        cutscene:slideTo(player, player.x, player.y - 34, 0.5, "out-expo")
        player:setSprite("walk/down")
        if susie then
            cutscene:wait(function () return zero.x <= susie.x+50 end)
            zero.x = susie.x + 50
            zero.y = susie.y
            Assets.playSound("zero/normal_slash_" .. math.ceil(Utils.random(3)))
            zero:setAnimation("struggle")
            cutscene:detachFollowers()
            cutscene:setSprite(susie, "hold_axe")
            susie.graphics.shake_x = 1
            Assets.playSound("wing")
            local sword_struggle = Assets.playSound("sword_struggle")
            sword_struggle:setLooping(true)
            sword_struggle:play()
            cutscene:wait(0.5)
            sword_struggle:stop()

            -- offsets are weird so we need to fake an attack animation with this
            susie.alpha = 0
            local battleanims = Sprite("party/susie/dark/battle/attack")
            battleanims.x = -26 battleanims.y = -25
            battleanims:play(1/15, false)
            susie:addChild(battleanims)
            susie.graphics.shake_x = 0
            Assets.playSound("laz_c")
            Assets.playSound("bigcut")
            --cutscene:wait(1/30)

            cutscene:wait(function () return zero.y >= 310 end)
            zero.physics.speed = 0
            zero.physics.direction = 0
            zero.physics.gravity = 0
            zero.y = 310
            zero:setAnimation("hurt_ground")
            Assets.playSound("impact")

            cutscene:wait(0.5)
            Assets.playSound("weaponpull_fast")
            susie.physics.speed = -10
            susie.physics.friction = 0.5
            battleanims:setSprite("party/susie/dark/battle/attackready")

            -- Zero gets up and draws his sword, beginning the fight.
            zero:setAnimation("hurt_recover")
            cutscene:wait(1)
            Assets.playSound("sword_draw")
            zero:setAnimation("threaten")
            cutscene:wait(0.5)
            cutscene:startEncounter("zero", true, {{"zero", zero}})
        -- If Susie is NOT in the party...
        else
            -- Zero attacks and slides forward a bit.
            zero:setAnimation("attack")
            local slashfx = Sprite("effects/KatanaSlash")
            zero:addChild(slashfx)
            Assets.playSound("zero/normal_slash_" .. math.ceil(Utils.random(3)))
            slashfx.x = slashfx.x - 45
            slashfx:play(1/25, false, function ()
                slashfx:remove()
            end)
            if Game.party[2] then
            zero.physics.speed = -20
            else
            zero.physics.speed = -15
            end
            zero.physics.friction = 0.7
            cutscene:wait(1)

            -- Zero turns around and draws his sword, beginning the fight.
            zero.flip_x = true
            zero.x = zero.x - 50
            Assets.playSound("sword_draw")
            zero:setAnimation("threaten")
            cutscene:wait(0.5)
            cutscene:startEncounter("zero", true, {{"zero", zero}})

        end
    end
}