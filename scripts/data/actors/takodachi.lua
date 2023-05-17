local actor, super = Class(Actor, "tako")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Takodachi"

    -- Width and height for this actor, used to determine its center
    self.width = 26
    self.height = 30

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    --self.hitbox = {5, 35, 20, 15}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {1, 0, 0}

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = "world/npcs/takodachi"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "idle"

    -- Sound to play when this actor speaks (optional)
    self.voice = nil
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = nil
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = {0, 0}

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of talk sprites and their talk speeds (default 0.25)
    self.talk_sprites = {
        ["talk"] = 0.2,
    }

    -- Table of sprite animations
    self.animations = {
        ["idle"] = {"idle", 1, true},
        ["talk"] = {"talk", 0.2, true},
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {
        ["takolyshit"] = {-5, -60}
    }

end

function actor:onWorldUpdate(chara)
    if not Game.world.map.ina then return end
    if Game.world.cutscene and Game.world.cutscene.id ~= "room1.wah" then return end
    if chara.sprite.sprite ~= "takolyshit" then
        if not Game.world.map.ina:isPlaying() then
            Game.world.map.ina:resume()
        end
        local dist = Utils.dist(chara.x+chara.width/2, chara.y+chara.height/2, Game.world.player.x+Game.world.player.width, Game.world.player.y+Game.world.player.height)
        local vol = Utils.clamp(Utils.clampMap(dist, 50, 150, 1, 0), 0, 1)
        Game.world.map.ina:setVolume(vol)
        if Game.world.map.ina.volume > 0 then
            Game.world.music:setVolume(1 - vol)
        else
            if Game.world.music:getVolume() < 1 then
                Game.world.music:setVolume(1)
            end
        end
        if vol > 0 and chara.sprite.sprite == "idle" then
            chara:setAnimation("talk")
        elseif vol == 0 and chara.sprite.anim == "talk" then
            chara:setSprite("idle")
        end
    else
        if Game.world.map.ina:isPlaying() then
            Game.world.map.ina:pause()
        end
    end
end

return actor