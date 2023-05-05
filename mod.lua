function Mod:init()
    Mod:registerShaders()

    -- Accur acy
    MUSIC_PITCHES["deltarune/cybercity_alt"] = 1.2
    MUSIC_PITCHES["deltarune/THE_HOLY"] = 0.9
    
    -- taunt stuff
    chars = {}
    chars['YOU'] = {"disappointed", "fell", "shoutoutstosimpleflips", "date", "date_flowey_4", "riot"}
    chars['susie'] = {"pose", "away_hand", "turn_around", "angry_down", "diagonal_kick_left_5", "shock_right"}
    chars['dess'] = {"reddit_gold"}
    chars['kris'] = {"pose", "peace", "t_pose", "sit"}

    -- taunt timer
    self.taunt_timer = 0
end

function Mod:registerShaders()
    Mod.shaders = {}
    for _,path,shader in Registry.iterScripts("shaders/") do
        assert(shader ~= nil, '"shaders/'..path..'.lua" does not return value')
        Mod.shaders[path] = shader
    end
end

function Mod:postInit(new_file)
    if new_file then
        -- FUN Value
        Game:setFlag("fun", love.math.random(1, 100))
        Game:setFlag("party", {"YOU", "susie"})

        if Game:hasPartyMember("YOU") then
            Game.world:startCutscene("room1", "react_to_YOU")
        end
    end
end

function Mod:postUpdate()
    local player = Game.party[1]

    if Input.pressed("v", false) and Game.state == "OVERWORLD" and Game.world.menu == nil then
        if player:checkArmor("pizza_toque") then
            if self.taunt_timer == 0 then
                self.taunt_timer = 0.40
				
                Assets.playSound("taunt", 0.5, Utils.random(0.9, 1.1))

                for chara_id,sprites in pairs(chars) do
                    local chara = Game.world:getCharacter(chara_id)
                    if chara then
                        local effect = Sprite("effects/taunteffect", 10, 15)

                        -- unlock player movement after taunt is finished
                        local function onUnlock()
                            effect:remove()
                            Game.lock_movement = false
                            chara:setSprite("walk")
                        end

                        -- the shine effect
                        effect:play(0.01, false, onUnlock)
                        effect:setOrigin(0.5)
                        effect:setScale(0.5)
                        effect.layer = -1
                        chara:addChild(effect)

                        if effect then
                            Game.lock_movement = true
                            chara:setSprite(Utils.pick(sprites))
                        end
                    end
                end
            end
        end
    end
    self.taunt_timer = Utils.approach(self.taunt_timer, 0, DT)
end

modRequire("scripts/main/warp_bin")
modRequire("scripts/main/debugsystem")

function Mod:isInRematchMode()
    return Game.world.map.id == "thearena"
end
