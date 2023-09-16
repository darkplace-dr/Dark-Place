local actor, super = Class("YOU", true)

function actor:init()
    super.init(self)

    self.taunt_sprites = {"disappointed", "fell", "shoutoutstosimpleflips", "date", "date_flowey_4", "riot"}

    self.cursed_song = Music("cursed")
    self.cursed_song:stop()

    table.insert(self.offsets, {["hold_key"] = {-7, -12}})
end

function actor:onWorldUpdate()
    super.onWorldUpdate(self)

    if self.cursed_song:isPlaying() and self.battle_music and not Game.battle then
        if Game.world.player and Game.world.player.walk_speed == 0 then
            Game.world.player.walk_speed = self.old_speed
            self.old_speed = nil
        end
        if self.world_music then
            Game.world.music:resume()
            self.world_music = nil
        end
        self.battle_music = nil
        self.cursed_song:stop()
    end
end

function actor:onSetSprite(sprite, texture, callback)
    super.onSetSprite(self, sprite, texture, callback)
    if texture == "cursed" then
        self.old_speed = Game.world.player.walk_speed
        Game.world.player.walk_speed = 0
        if Game.world.music:isPlaying() then
            self.world_music = true
            Game.world.music:pause()
        end
        if Game.battle and Game.battle.music:isPlaying() then
            self.battle_music = true
            Game.battle.music:pause()
        end
        self.cursed_song:play()
    else
        if Game.world.player and Game.world.player.walk_speed==0 then
            Game.world.player.walk_speed = self.old_speed
            self.old_speed = nil
        end
        if self.world_music then
            Game.world.music:resume()
            self.world_music = nil
        end
        if self.battle_music then
            if Game.battle then
                Game.battle.music:resume()
            end
            self.battle_music = nil
        end
        if self.cursed_song:isPlaying() then
            self.cursed_song:stop()
        end
    end
end

return actor