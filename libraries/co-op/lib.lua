local Lib, super = Class()

local scriptPath = debug.getinfo(1).source:match("@(.*)$")
local folderPath = scriptPath:match("(.*[/\\])")
folderPath = folderPath:gsub("[/\\]", ".")

Player2 = require(folderPath ..'scripts.objects.player2')
Soul2 = require(folderPath .."scripts.objects.soul2")
OverworldSoul2 = require(folderPath ..'scripts.objects.overworldsoul2')


function Lib:init()

    Utils.hook(Transition, "onEnter", function(orig, self, chara)
        if chara.is_player2 or chara.is_player then
            local x, y = self.target.x, self.target.y
            local facing = self.target.facing
            local marker = self.target.marker
    
            if self.stairs then
                Assets.playSound("escaped")
            end
            if self.target.shop then
                self.world:shopTransition(self.target.shop, {x=x, y=y, marker=marker, facing=facing, map=self.target.map})
            elseif self.target.map then
                if marker then
                    self.world:mapTransition(self.target.map, marker, facing)
                else
                    self.world:mapTransition(self.target.map, x, y, facing)
                end
            end
        end
    end)

    Utils.hook(World, 'spawnParty', function(orig, self, marker, party, extra, facing)
        if Game.world then
            party = party or Game.party or {"kris"}
            if #party > 0 then
                for i,chara in ipairs(party) do
                    if type(chara) == "string" then
                        party[i] = Game:getPartyMember(chara)
                    end
                end
                if type(marker) == "table" then
                    self:spawnPlayer(marker[1], marker[2], party[1]:getActor())
                else
                    self:spawnPlayer(marker or "spawn", party[1]:getActor())
                end
                if facing then
                    self.player:setFacing(facing)
                end

                if Game:getFlag("2_player") and Game.party[2] then
                    if type(marker) == "table" then
                        self:spawnPlayer2(marker[1], marker[2], party[2]:getActor())
                    else
                        self:spawnPlayer2(marker or "spawn", party[2]:getActor())
                    end
                    if facing then
                        self.player2:setFacing(facing)
                    end
                    for i = 3, #party do
                        local follower = self:spawnFollower(party[i]:getActor())
                        follower:setFacing(facing or self.player.facing)
                    end
                else
                    for i = 2, #party do
                        local follower = self:spawnFollower(party[i]:getActor())
                        follower:setFacing(facing or self.player.facing)
                    end
                end
                for _,actor in ipairs(extra or Game.temp_followers or {}) do
                    if type(actor) == "table" then
                        local follower = self:spawnFollower(actor[1], {index = actor[3]})
                        follower:setFacing(facing or self.player.facing)
                    else
                        local follower = self:spawnFollower(actor)
                        follower:setFacing(facing or self.player.facing)
                    end
                end
            end
        end         
    end)

    --stuff for player 2
    Utils.hook(World, 'spawnPlayer2', function(orig, self, ...)
        local args = {...}

        local x, y = 0, 0
        local chara = self.player2 and self.player2.actor
        if #args > 0 then
            if type(args[1]) == "number" then
                x, y = args[1], args[2]
                chara = args[3] or chara
            elseif type(args[1]) == "string" then
                x, y = self.map:getMarker(args[1])
                chara = args[2] or chara
            end
        end

        if type(chara) == "string" then
            chara = Registry.createActor(chara)
        end

        local facing = "down"

        if self.player2 then
            facing = self.player2.facing
            self:removeChild(self.player2)
        end
        if self.soul2 then
            self:removeChild(self.soul2)
        end

        self.player2 = Player2(chara, x, y)
        self.player2.layer = self.map.object_layer
        self.player2:setFacing(facing)
        self:addChild(self.player2)

        self.soul2 = OverworldSoul2(x + 10, y + 24) -- TODO: unhardcode
        self.soul2:setColor(0, 1, 2)
        self.soul2.layer = WORLD_LAYERS["soul"]
        self:addChild(self.soul2)

        if self.camera.attached_x then
            self.camera:setPosition(self.player2.x, self.camera.y)
        end
        if self.camera.attached_y then
            self.camera:setPosition(self.camera.x, self.player2.y - (self.player2.height * 2)/2)
        end
    end)

    Utils.hook(Battle, 'spawnSoul2', function(orig, self, x, y, other, extra)
        local bx, by = self:getSoulLocation()
        --local color = {0, 1, 2}

        self:addChild(HeartBurst(bx, by, color, sprite))
        if not self.soul2 then
            self.soul2 = self.encounter:createSoul2(bx, by, color, sprite)
            self.soul2:transitionTo(x or SCREEN_WIDTH/2, y or SCREEN_HEIGHT/2)
            self.soul2.target_alpha = self.soul2.alpha
            self.soul2.alpha = 0
            self:addChild(self.soul2)
            self.soul2:setScale(1, -1)
            --soul2.sprite = ("player/heart2_dodge")
            self.soul2.speed = 4

        end
    end)

    Utils.hook(Battle, 'returnSoul2', function(orig, self, dont_destroy)
        if dont_destroy == nil then dont_destroy = false end
        local bx, by = self:getSoul2Location(true)
        if self.soul2 then
            self.soul2:transitionTo(bx, by, not dont_destroy)
        end
    end)

    Utils.hook(Battle, 'swapSoul2', function(orig, self, object)
        if self.soul2 then
            self.soul2:remove()
        end
        object:setPosition(self.soul2:getPosition())
        object.layer = self.soul2.layer
        self.soul2 = object
        self:addChild(object)
    end)

    Utils.hook(Battle, 'getSoul2Location', function(orig, self, always_player)
        if self.soul2 and (not always_player) then
            return self.soul2:getPosition()
        else
            local main_chara = Game:getSoulPartyMember()
    
            if main_chara and main_chara:getSoulPriority() >= 0 then
                local battler = self.party[self:getPartyIndex(main_chara.id)]
    
                if battler then
                    if main_chara.soul_offset then
                        return battler:localToScreenPos(main_chara.soul_offset[1], main_chara.soul_offset[2])
                    else
                        return battler:localToScreenPos((battler.sprite.width/2) - 4.5, battler.sprite.height/2)
                    end
                end
            end
            return -9, -9
        end
    end)

    Utils.hook(Encounter, 'createSoul2', function(orig, self, x, y, color)
        return Soul2(x, y, color)
    end)

    Utils.hook(Wave, 'setSoul2Position', function(orig, self, x, y)
        self.soul2_start_x = x
        self.soul2_start_y = y
    
        if Game.battle.soul2 then
            Game.battle.soul2:setExactPosition(x, y)
        end
    end)

    Utils.hook(Wave, 'setSoul2Offset', function(orig, self, x, y)
        self.soul2_offset_x = x
        self.soul2_offset_y = y
    
        if Game.battle.soul2 then
            Game.battle.soul2:move(x or 0, y or 0)
        end
    end)

    Utils.hook(Character, "convertToPlayer2", function(orig, self)
        self.world:spawnPlayer2(self.x, self.y, self.actor)
        local player2 = self.world.player2
        player2:setLayer(self.layer)
        player2:setFacing(self.facing)
        self:remove()
        return player2
    end)


    print("Loaded Dark Place Multiplayer")
end

return Lib