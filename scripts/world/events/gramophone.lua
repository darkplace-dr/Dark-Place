local Gramophone, super = Class(Event)

function Gramophone:init(data)
    super.init(self, data)

    self.sprite = Sprite("world/events/floor2/backrooms/gramophone")
    self.sprite:play(0.2, true)
    self.sprite:setScale(2)
    self:addChild(self.sprite)

    self.solid = true
end

function Gramophone:update()
    super.update(self)

    if not Game.world.map.gramophone_music then return end

    if not Game.world.map.gramophone_music:isPlaying() then
        Game.world.map.gramophone_music:resume()
    end
    local dist = Utils.dist(self.x+self.width/2, self.y+self.height/2, Game.world.player.x+Game.world.player.width, Game.world.player.y+Game.world.player.height)
    local vol = Utils.clamp(Utils.clampMap(dist, -750, 750, 1, 0), 0, 1)
    Game.world.map.gramophone_music:setVolume(vol)
    if Game.world.map.gramophone_music.volume > 0 then
        Game.world.music:setVolume(1 - vol)
    else
        if Game.world.music:getVolume() < 1 then
            Game.world.music:setVolume(1)
        end
    end
    --[[if Game.world.music:isPlaying() ~= Game.world.map.gramophone_music:isPlaying() then
        if not Game.world.music:isPlaying() and Game.world.map.gramophone_music:isPlaying() then
            Game.world.map.gramophone_music:pause()
        end
        if Game.world.music:isPlaying() and not Game.world.map.gramophone_music:isPlaying() then
            Game.world.map.gramophone_music:play()
        end
    end]]
end

return Gramophone