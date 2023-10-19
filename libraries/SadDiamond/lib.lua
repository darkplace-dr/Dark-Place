local Lib, super = Class()


local scriptPath = debug.getinfo(1).source:match("@(.*)$")
local folderPath = scriptPath:match("(.*[/\\])")
folderPath = folderPath:gsub("[/\\]", ".")

Player2 = require(folderPath ..'scripts.objects.player2')
Player_3 = require(folderPath ..'scripts.objects.player_3')
Player_4 = require(folderPath ..'scripts.objects.player_4')


OverworldSoul2 = require(folderPath ..'scripts.objects.overworldsoul2')
Player3 = require(folderPath ..'scripts.objects.player3')

Soul2 = require(folderPath .."scripts.objects.soul2")
Soul3 = require(folderPath .."scripts.objects.soul3")
Soul4 = require(folderPath .."scripts.objects.soul4")

--Game:setFlag("2_player", true)

function Mod:registerDebugOptions(debug)

    debug:registerOption("main", "Party Members", "Spawn / Remove\nParty Members", function() debug:enterMenu("party_members", 1) end)

    debug:registerMenu("party_members", "Party  Members")

    debug:registerOption("party_members", "Spawn Party Members", "Spawn\nParty Members", function() debug:enterMenu("Spawn Party Members", 1) end)
    debug:registerOption("party_members", "Remove Party Members", "Remove\nParty Members", function() debug:enterMenu("Remove Party Members", 1) end)

    debug:registerMenu("Remove Party Members", "Remove  Party  Member", "search")

    for id, party_members_data in pairs(Registry.party_members) do
        local party_members = party_members_data()
        debug:registerOption("Remove Party Members", party_members.name, "party_members.title", function()
            Game.world: removeFollower(party_members.id)
            Game: removePartyMember(party_members.id)
        end)
    end

    debug:registerMenu("Spawn Party Members", "Spawn  Party  Member", "search")

    for id, party_members_data in pairs(Registry.party_members) do
        local party_members = party_members_data()
        debug:registerOption("Spawn Party Members", party_members.name, party_members.title, function()
            Game.world: spawnFollower(party_members.id)
            Game: addPartyMember(party_members.id)
        end)
    end
end

function Lib:init()

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

                if Game.world.player3 or Game:getFlag("4_player") or Game:getFlag("3_player") or Game:getFlag("2_player") then
                    if type(marker) == "table" then
                        self:spawnPlayer3(marker[1], marker[2], party[1]:getActor())
                    else
                        self:spawnPlayer3(marker or "spawn", party[1]:getActor())
                    end
                end
                if Game:getFlag("4_player") then
                    if type(marker) == "table" then
                        self:spawnPlayer2(marker[1], marker[2], party[2]:getActor())
                    else
                        self:spawnPlayer2(marker or "spawn", party[2]:getActor())
                    end
                    if facing then
                        self.player2:setFacing(facing)
                    end
                    if type(marker) == "table" then
                        self:spawnPlayer_3(marker[1], marker[2], party[3]:getActor())
                    else
                        self:spawnPlayer_3(marker or "spawn", party[3]:getActor())
                    end
                    if facing then
                        self.player_3:setFacing(facing)
                    end
                    if type(marker) == "table" then
                        self:spawnPlayer_4(marker[1], marker[2], party[4]:getActor())
                    else
                        self:spawnPlayer_4(marker or "spawn", party[4]:getActor())
                    end
                    if facing then
                        self.player_4:setFacing(facing)
                    end
                    for i = 5, #party do
                        local follower = self:spawnFollower(party[i]:getActor())
                        follower:setFacing(facing or self.player.facing)
                    end
                elseif Game:getFlag("3_player") then
                    if type(marker) == "table" then
                        self:spawnPlayer2(marker[1], marker[2], party[2]:getActor())
                    else
                        self:spawnPlayer2(marker or "spawn", party[2]:getActor())	
                    end
                    if facing then
                        self.player2:setFacing(facing)
                    end
                    if type(marker) == "table" then
                        self:spawnPlayer_3(marker[1], marker[2], party[3]:getActor())
                    else
                        self:spawnPlayer_3(marker or "spawn", party[3]:getActor())
                    end
                    if facing then
                        self.player_3:setFacing(facing)
                    end
                    for i = 4, #party do
                        local follower = self:spawnFollower(party[i]:getActor())
                        follower:setFacing(facing or self.player.facing)
                    end
                elseif Game:getFlag("2_player") then
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

        local facing = "up"

        if self.player2 then
            facing = self.player2.facing
            self:removeChild(self.player2)
        end
        if self.soul then
            self:removeChild(self.soul)
        end

        self.player2 = Player2(chara, x, y)
        self.player2.layer = self.map.object_layer
        self.player2:setFacing(facing)
        self:addChild(self.player2)

        self.soul = OverworldSoul(x + 10, y + 24) -- TODO: unhardcode
        self.soul:setColor(Game:getSoulColor())
        self.soul.layer = WORLD_LAYERS["soul"]
        self:addChild(self.soul)

        if self.camera.attached_x then
            self.camera:setPosition(self.player2.x, self.camera.y)
        end
        if self.camera.attached_y then
            self.camera:setPosition(self.camera.x, self.player2.y - (self.player2.height * 2)/2)
        end
    end)

    Utils.hook(World, 'spawnPlayer_3', function(orig, self, ...)
        local args = {...}

        local x, y = 0, 0
        local chara = self.player_3 and self.player_3.actor
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

        local facing = "up"

        if self.player_3 then
            facing = self.player_3.facing
            self:removeChild(self.player_3)
        end
        if self.soul then
            self:removeChild(self.soul)
        end

        self.player_3 = Player_3(chara, x, y)
        self.player_3.layer = self.map.object_layer
        self.player_3:setFacing(facing)
        self:addChild(self.player_3)

        self.soul = OverworldSoul(x + 10, y + 24) -- TODO: unhardcode
        self.soul:setColor(Game:getSoulColor())
        self.soul.layer = WORLD_LAYERS["soul"]
        self:addChild(self.soul)

        if self.camera.attached_x then
            self.camera:setPosition(self.player_3.x, self.camera.y)
        end
        if self.camera.attached_y then
            self.camera:setPosition(self.camera.x, self.player_3.y - (self.player_3.height * 2)/2)
        end
    end)

    Utils.hook(World, 'spawnPlayer_4', function(orig, self, ...)
        local args = {...}

        local x, y = 0, 0
        local chara = self.player_4 and self.player_4.actor
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

        local facing = "up"

        if self.player_4 then
            facing = self.player_4.facing
            self:removeChild(self.player_4)
        end
        if self.soul then
            self:removeChild(self.soul)
        end

        self.player_4 = Player_4(chara, x, y)
        self.player_4.layer = self.map.object_layer
        self.player_4:setFacing(facing)
        self:addChild(self.player_4)

        self.soul = OverworldSoul(x + 10, y + 24) -- TODO: unhardcode
        self.soul:setColor(Game:getSoulColor())
        self.soul.layer = WORLD_LAYERS["soul"]
        self:addChild(self.soul)

        if self.camera.attached_x then
            self.camera:setPosition(self.player_4.x, self.camera.y)
        end
        if self.camera.attached_y then
            self.camera:setPosition(self.camera.x, self.player_4.y - (self.player_4.height * 2)/2)
        end
    end)

    Utils.hook(World, 'getCameraTarget', function(orig, self, chara, x, y)
        if self.camera.target and self.camera.target.stage then
            return self.camera.target
        else
            return self.player3 or self.player
        end
    end)

    Utils.hook(World, 'spawnPlayer3', function(orig, self, ...)
        local args = {...}

        local x, y = 0, 0
        local chara = self.player3 and self.player3.actor
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

        local facing = "left"

        if self.player3 then
            facing = self.player3.facing
            self:removeChild(self.player3)
        end
        if self.soul then
            self:removeChild(self.soul)
        end

        self.player3 = Player3(chara, x, y)
        self.player3.layer = self.map.object_layer
        self.player3:setFacing(facing)
        self:addChild(self.player3)

        self.soul = OverworldSoul(x + 10, y + 24) -- TODO: unhardcode
        self.soul:setColor(Game:getSoulColor())
        self.soul.layer = WORLD_LAYERS["soul"]
        self:addChild(self.soul)

        if self.camera.attached_x then
            self.camera:setPosition(self.player3.x, self.camera.y)
        end
        if self.camera.attached_y then
            self.camera:setPosition(self.camera.x, self.player3.y - (self.player3.height * 2)/2)
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

    Utils.hook(Character, "convertToPlayer_3", function(orig, self)
        self.world:spawnPlayer_3(self.x, self.y, self.actor)
        local player_3 = self.world.player_3
        player_3:setLayer(self.layer)
        player_3:setFacing(self.facing)
        self:remove()
        return player_3
    end)

    Utils.hook(Character, "convertToPlayer_4", function(orig, self)
        self.world:spawnPlayer_4(self.x, self.y, self.actor)
        local player_4 = self.world.player_4
        player_4:setLayer(self.layer)
        player_4:setFacing(self.facing)
        self:remove()
        return player_3
    end)

end

return Lib    