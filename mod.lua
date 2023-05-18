function Mod:init()
    Mod:registerShaders()

    -- Accur acy
    MUSIC_PITCHES["deltarune/cybercity_alt"] = 1.2
    MUSIC_PITCHES["deltarune/THE_HOLY"] = 0.9
    MUSIC_VOLUMES["deltarune/queen_car_radio"] = 0.8
	
    MUSIC_PITCHES["ruins_beta"] = 0.8
    
    -- taunt stuff for characters that use "walk" as their default sprite (i.e. party members and Sans)
    self.chars = {}
    self.chars['YOU'] = {"disappointed", "fell", "shoutoutstosimpleflips", "date", "date_flowey_4", "riot"}
    self.chars['susie'] = {"pose", "away_hand", "turn_around", "angry_down", "diagonal_kick_left_5", "shock_right"}
    self.chars['dess'] = {"reddit_gold"}
    self.chars['kris'] = {"pose", "peace", "t_pose", "sit"}
    self.chars['berdly'] = {"fall", "nerd", "drama", "shocked", "fell"}
    self.chars['bor'] = {"pizza", "pizza_b", "kirby"}
    self.chars['sans'] = {"shrug", "sleeping", "eyes", "bike", "wink"}

    -- taunt stuff for characters that use "idle" as their default sprite (i.e. NPCs and such)
    self.chars_npcs = {}
        -- code applies to Velvet!Spam
        local hour = os.date("*t").hour
        if hour >= 21 or hour <= 8 then
            self.chars_npcs['velvetspam'] = {"pissed", "bundled", "pipis"}
        else
            self.chars_npcs['velvetspam'] = {"day_blankie", "box"}
        end
    --self.chars_npcs[''] = {""}

    -- taunt timer
    self.taunt_timer = 0

    self.voice_timer = 0
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

    Game.isOmori = false

end

function Mod:preUpdate(dt)
    self.voice_timer = Utils.approach(self.voice_timer, 0, DTMULT)
end

function Mod:onTextSound(sound, node)
    if sound == "omori" then
        if self.voice_timer == 0 then
            local snd = Assets.playSound("voice/omori")
            snd:setPitch(0.9 + Utils.random(0.18))
            self.voice_timer = 1.1
        end
        return true
    end
end

function Mod:postUpdate()
    local player = Game.party[1]

    if Input.pressed("v", false) and Game.state == "OVERWORLD" and Game.world.menu == nil and not Game.world:hasCutscene() then
        if player:checkArmor("pizza_toque") then
            if self.taunt_timer == 0 then
                self.taunt_timer = 0.40
				
                Assets.playSound("taunt", 0.5, Utils.random(0.9, 1.1))

                for chara_id,sprites in pairs(self.chars) do
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
                        effect:play(0.02, false, onUnlock)
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
                for chara_npc_id,sprites in pairs(self.chars_npcs) do
                    local chara_npc = Game.world:getCharacter(chara_npc_id)
                    if chara_npc then
                        local effect = Sprite("effects/taunteffect", 10, 15)

                        -- unlock player movement after taunt is finished
                        local function onUnlock()
                            effect:remove()
                            Game.lock_movement = false
                            chara_npc:setSprite("idle")
                        end

                        -- the shine effect
                        effect:play(0.02, false, onUnlock)
                        effect:setOrigin(0.5)
                        effect:setScale(0.5)
                        effect.layer = -1
                        chara_npc:addChild(effect)

                        if effect then
                            Game.lock_movement = true
                            chara_npc:setSprite(Utils.pick(sprites))
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

function Mod:getPartyMemberIfInParty(chara)
    return Game:hasPartyMember(chara) and Game:getPartyMember(chara) or nil
end

function Mod:getKris()
    local YOU = Game:getPartyMember("YOU")
    local kris = Game:getPartyMember("kris")
    if Game:hasPartyMember(YOU) then return YOU
    elseif Game:hasPartyMember(kris) then return kris
    else return Game:getPartyMember(Game.party[1].id)
    end
end

function Mod:getKrisCharacter()
    return Game.world:getCharacter(Mod:getKris().id)
end

function Mod:isInRematchMode()
    return Game.world.map.id == "thearena"
end