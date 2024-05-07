return{

    choice = function (cutscene, event)
        event:remove()
        if Game:getFlag("zero_defeated") == true then return end
        if Game.zero_quick
        or Input.down("kp0") or Input.down("0") -- You're welcome, speedrunners.
        then
            cutscene:gotoCutscene("zero_alley", "start_quick")
        else
            cutscene:gotoCutscene("zero_alley", "start")
        end
    end,

    -- very much wip
    start = function (cutscene)
        -- Temporary flag to cause a faster cutscene to play the next time the trigger is approached. Does not reset on a Game Over, but DOES reset if the mod is reloaded.
        Game.zero_quick = true

        Game:saveQuick(Game.world.map:getMarker("spawn"))

        --Game.lock_movement = false
        local zero = cutscene:getEvent(5) -- ID for the Zero NPC.
        local player = Game.world.player
        local susie = cutscene:getCharacter("susie")
        local ceroba = cutscene:getCharacter("ceroba")
        cutscene:detachFollowers()

        -- Zero charges at the player (or Susie and Ceroba if any of them in the party), wait until he reaches them
        zero:setAnimation("run")
        if susie then
            cutscene:slideToSpeed(zero, susie.x+50, player.y, 20)
        elseif ceroba then
            cutscene:slideToSpeed(zero, ceroba.x+50, ceroba.y, 20)
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
        --cutscene:text("* Timeslow FX will go here,[wait:5] press [UP] to continue.")

        Game.stage:addFX(ShaderFX(Mod.shaders["wave"], {
            ["wave_sine"] = function() return Kristal.getTime() * 400 end,
            ["wave_mag"] = 1,
            ["wave_height"] = 3,
            ["texsize"] = {SCREEN_WIDTH, SCREEN_HEIGHT}
        }), "funky_mode")
        Game.stage:addFX(VHSFilter(), "introvhs")
        Assets.playSound("zero/casette_pause")
        local casettenoise = Assets.getSound("zero/casette_noise")
        casettenoise:setLooping(true)
        casettenoise:play()


        cutscene:wait(2)
        player:resetSprite()
        player:setFacing("left")
        cutscene:wait(0.5)
        player:setFacing("right")
        cutscene:wait(0.5)
        player:setFacing("left")
        cutscene:wait(0.5)
        player:setFacing("right")
        cutscene:wait(0.5)
        cutscene.inputplease = Text("[UP]/[DOWN]", -15, 40, SCREEN_WIDTH, SCREEN_HEIGHT,
        {
            --align = "center",
            --font = "plain"
            font_size = 16,
            style = "dark"
        }
        )
        cutscene.inputplease.color = COLORS.silver
        cutscene.inputplease.alpha = 0
        player:addChild(cutscene.inputplease)

        Game.world.timer:after(5, function ()
            if cutscene.inputplease then
                cutscene.inputplease.alpha = 0.8
            end
            
        end)



        cutscene:wait(function () return (Input.down("up") or Input.down("down")) and not Kristal.Console.is_open end)
        cutscene.inputplease:remove()
        if Input.down("up") then
            cutscene:walkTo(player, player.x, player.y - 34, 1)
            cutscene:wait(1)
            player:setFacing("down")
            if Game.party[1].name == "YOU" then player:setSprite("seentoomuch") end
        elseif Input.down("down") then
            cutscene:walkTo(player, player.x, player.y + 34, 1)
            cutscene:wait(1)
            player:setFacing("up")
            player.layer = 1.5
        end
        zero.layer = 1.4
        if susie and Game.party[1].name ~= "Susie" then susie.layer = 1.3 end
        Assets.playSound("item")
        cutscene:text("* (You got [color:yellow]FOCUS[color:reset].[wait:10]\nHold [color:yellow]" .. "[F]" .."[color:reset] to slow time.)")

        casettenoise:stop()
        Assets.playSound("zero/casette_pause")
        Game.stage:removeFX("funky_mode")
        Game.stage:removeFX("introvhs")



        -- Resume. if Susie is in the party, wait until Zero reaches her, then the two will clash.
        zero.active = true
        if susie and Game.party[1].name ~= "Susie" then
            cutscene:wait(function () return zero.x <= susie.x+50 end)
            zero.x = susie.x + 50
            zero.y = susie.y
            Assets.playSound("zero/normal_slash_" .. math.ceil(Utils.random(3)))
            zero:setAnimation("struggle")
            cutscene:setSprite(susie, "hold_axe")
            susie.graphics.shake_x = 1
            Assets.playSound("wing")
            local sword_struggle = Assets.playSound("sword_struggle")
            sword_struggle:setLooping(true)
            sword_struggle:play()
            cutscene:wait(0.5)
            cutscene:showNametag("Susie")
            cutscene:text("[facec:susie_bangs/nervous_annoyed]* W-Woah![wait:5] The hell's your problem!?", "angry_b", "susie")
            cutscene:hideNametag()
            sword_struggle:stop()

            -- Susie knocks Zero away.
            zero:setAnimation("hurt_fly")
            zero.physics.speed = 20
            zero.physics.direction = math.rad(-70)
            zero.physics.gravity = 1
            -- offsets are weird so we need to fake an attack animation with this
            susie.alpha = 0
            cutscene.battleanims = Sprite("party/susie/dark/battle/attack")
            cutscene.battleanims.x = -26 cutscene.battleanims.y = -25
            cutscene.battleanims:play(1/15, false)
            susie:addChild(cutscene.battleanims)
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
            cutscene.battleanims:setSprite("party/susie/dark/battle/attackready")
        

            -- Zero gets up and draws his sword, beginning the fight.
            zero:setAnimation("hurt_recover")
            cutscene:wait(1)
            Assets.playSound("sword_draw")
            zero:setAnimation("threaten")
            cutscene:wait(0.5)
        
            -- Else, if Susie is not in party, but Ceroba is...
        elseif ceroba and Game.party[1].name ~= "Ceroba" then
            cutscene:wait(function () return zero.x <= ceroba.x+50 end)
            -- Ceroba knocks Zero away.
            zero:setAnimation("hurt_fly")
            zero.physics.speed = 20
            zero.physics.direction = math.rad(-70)
            zero.physics.gravity = 1
            ceroba.alpha = 0
            cutscene.battleanims = Sprite("party/ceroba/dark/battle/attack")
            cutscene.battleanims.x = -14
            cutscene.battleanims.y = -6
            cutscene.battleanims:play(1/15, false)
            ceroba:addChild(cutscene.battleanims)
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
    
            --Ceroba steps forward, in attackready pose
            cutscene:text("* ...", "angry", "ceroba")
            cutscene:wait(0.5)
            Assets.playSound("weaponpull_fast")
            ceroba.physics.speed = 5
            ceroba.physics.friction = 0.5
            cutscene.battleanims:setSprite("party/ceroba/dark/battle/attackready")
            
            -- Zero gets up and draws his sword, beginning the fight.
            zero:setAnimation("hurt_recover")
            cutscene:wait(1)
            Assets.playSound("sword_draw")
            zero:setAnimation("threaten")
            cutscene:wait(0.5)
            
            -- If Susie AND Ceroba is NOT in the party...
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

        end

        -- Cleanup
        player:resetSprite()
        player.x = 386 player.y = 310
        player.layer = 0.4
        cutscene:interpolateFollowers()
        cutscene:attachFollowers()
        if susie and Game.party[1].name ~= "Susie" then
            cutscene.battleanims:remove()
            susie.alpha = 1
            susie:resetSprite()
            susie.layer = 0.4
        elseif ceroba and Game.party[1].name ~= "Ceroba" then
            cutscene.battleanims:remove()
            ceroba.alpha = 1
            ceroba:resetSprite()
            ceroba.layer = 0.4
        end

        cutscene:startEncounter("zero", true, {{"zero", zero}})

        cutscene:gotoCutscene("zero_alley", "endscene")

    end,

    start_quick = function (cutscene, event)
        local zero = cutscene:getEvent(5) -- ID for the Zero NPC.
        local player = Game.world.player
        local susie = cutscene:getCharacter("susie")
        local ceroba = cutscene:getCharacter("ceroba")

        -- Zero charges at the player (or Susie and Ceroba if any of them in the party), wait until he reaches them

        zero:setAnimation("run")
        if susie then
            cutscene:slideToSpeed(zero, susie.x+50, player.y, 20)
            susie.layer_old = susie.layer
        elseif ceroba then
            cutscene:slideToSpeed(zero, ceroba.x+50, player.y, 20)
            ceroba.layer_old = ceroba.layer
        else
            cutscene:slideToSpeed(zero, player.x+60, player.y, 20)
        end
        zero.layer = 1.4
        if susie then
            susie.layer = 1.3
        elseif ceroba then
            ceroba.layer = 1.3
        end
        Assets.playSound("escaped")


        cutscene:wait(function () return zero.x <= player.x+60 end)
        cutscene:slideTo(player, player.x, player.y - 34, 0.5, "out-expo")
        player:setFacing("down")
        if susie and Game.party[1].name ~= "Susie" then
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
            cutscene.battleanims = Sprite("party/susie/dark/battle/attack")
            cutscene.battleanims.x = -26 cutscene.battleanims.y = -25
            cutscene.battleanims:play(1/15, false)
            susie:addChild(cutscene.battleanims)
            susie.graphics.shake_x = 0
            Assets.playSound("laz_c")
            Assets.playSound("bigcut")
            --cutscene:wait(1/30)

            zero.physics.speed = 0
            zero.physics.direction = 0
            zero.physics.gravity = 0
            zero:setAnimation("hurt_ground")
            Assets.playSound("impact")

            cutscene:wait(0.5)
            Assets.playSound("weaponpull_fast")
            susie.physics.speed = -10
            susie.physics.friction = 0.5
            cutscene.battleanims:setSprite("party/susie/dark/battle/attackready")

            -- Zero gets up and draws his sword, beginning the fight.
            zero:setAnimation("hurt_recover")
            cutscene:wait(1)
            Assets.playSound("sword_draw")
            zero:setAnimation("threaten")
            cutscene:wait(0.5)

        elseif ceroba and Game.party[1].name ~= "Ceroba" then
            cutscene:wait(function () return zero.x <= ceroba.x+50 end)
            cutscene:detachFollowers()

            zero:setAnimation("hurt_fly")
            zero.physics.speed = 20
            zero.physics.direction = math.rad(-70)
            zero.physics.gravity = 1
            ceroba.alpha = 0
            cutscene.battleanims = Sprite("party/ceroba/dark/battle/attack")
            cutscene.battleanims.x = -14
            cutscene.battleanims.y = -6
            cutscene.battleanims:play(1/15, false)
            ceroba:addChild(cutscene.battleanims)
            Assets.playSound("laz_c")
            Assets.playSound("bigcut")
            cutscene:wait(1/30)

            zero.physics.speed = 0
            zero.physics.direction = 0
            zero.physics.gravity = 0
            zero:setAnimation("hurt_ground")
            Assets.playSound("impact")

            cutscene:wait(0.5)
            Assets.playSound("weaponpull_fast")
            ceroba.physics.speed = -10
            ceroba.physics.friction = 0.5
            cutscene.battleanims:setSprite("party/ceroba/dark/battle/attackready")

            -- Zero gets up and draws his sword, beginning the fight.
            zero:setAnimation("hurt_recover")
            cutscene:wait(1)
            Assets.playSound("sword_draw")
            zero:setAnimation("threaten")
            cutscene:wait(0.5)
    
        -- If Ceroba is ALSO NOT in the party...
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

        end

        -- Cleanup
        player:resetSprite()
        player.x = 386 player.y = 310
        player.layer = 0.4
        cutscene:interpolateFollowers()
        cutscene:attachFollowers()
        if susie and Game.party[1].name ~= "Susie" then
            cutscene.battleanims:remove()
            susie.alpha = 1
            susie:resetSprite()
            susie.layer = 0.4
        elseif ceroba and Game.party[1].name ~= "Ceroba" then
            cutscene.battleanims:remove()
            ceroba.alpha = 1
            ceroba:resetSprite()
            ceroba.layer = 0.4
        end

        cutscene:startEncounter("zero", true, {{"zero", zero}})

        cutscene:gotoCutscene("zero_alley", "endscene")

    end,

    endscene = function (cutscene)
        Game.world.map:getEvent(5):remove()
        if Game.inventory:isFull("armors") then
            cutscene:text("* You BITCH.[wait:10] I put that forcefield there for a reason.")
            cutscene:text("* Y'know what?[wait:5] Fuck you.")
            Game.world:loadMap("misc/dogcheck")
            cutscene:text("* Get Dogchecked,[wait:5] [style:GONER]idiot[style:reset].")
        else
            if Game:getFlag("fun") == 12 then
                local susie = cutscene:getCharacter("susie")
                if susie then
                    cutscene:showNametag("Susie")
                    cutscene:text("* ...[wait:10] [facec:susie_bangs/nervous_smile]What.", "shock", "susie")
                end
            end
        Game.inventory:tryGiveItem("focus")
        cutscene:hideNametag()
        cutscene:text("* ([color:yellow]FOCUS[color:reset] was added to your [color:yellow]ARMORS[color:reset].)")
        Game:setFlag("zero_defeated", true)
        end
    end
}