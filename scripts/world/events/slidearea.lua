local SlideArea, super = Class(Event)

function SlideArea:init(x, y, w, h, properties)
    super.init(self, x, y, w, h)
    local properties = properties or {}
    self.lock_movement = properties["lock"] or false
end

function SlideArea:onCollide(chara)
    if (chara.last_y or chara.y) < self.y + self.height and chara.is_player or chara.is_player2 then
        if chara.state ~= "SLIDE" then
            if self:checkAgainstWall(chara) then return end

            Assets.stopAndPlaySound("noise")
        end

        chara:setState("SLIDE", false, self.lock_movement)

        chara.current_slide_area = self
    end
end


function SlideArea:update()
    if not Game.world.player then return end

    local stopped = false

    Object.startCache()

    if Game.world.player.y > self.y + self.height and not Game.world.player:collidesWith(self.collider) then
        self.solid = true

        if Game.world.player.state == "SLIDE" and Game.world.player.current_slide_area == self then
            stopped = true
        end
    else
        self.solid = false
    end

    if not stopped and Game.world.player.state == "SLIDE" and Game.world.player.current_slide_area == self then
        stopped = self:checkAgainstWall(Game.world.player)
    end

    Object.endCache()

    if stopped then
        Game.world.player:setState("WALK")
        
        Game.world.player.current_slide_area = nil
    end

    if Game.world.player2 then
        local stopped2 = false
        
        Object.startCache()
        
        if Game.world.player2.y > self.y + self.height and Game.world.player.y > self.y + self.height and not Game.world.player2:collidesWith(self.collider) then
            --self.solid = true
        
            if Game.world.player2.state == "SLIDE" and Game.world.player2.current_slide_area == self then
                stopped2 = true
            end
        else
            self.solid = false
        end
        
        if not stopped2 and Game.world.player2.state == "SLIDE" and Game.world.player2.current_slide_area == self then
            stopped2 = self:checkAgainstWall(Game.world.player2)
        end
        
        Object.endCache()
        
        if stopped2 then
            Game.world.player2:setState("WALK")
        
            Game.world.player2.current_slide_area = nil
        end
    end

    super.update(self)
end

function SlideArea:checkAgainstWall(chara)
    local hb = chara.collider

    if hb and hb:includes(Hitbox) then
        local extended_hitbox = Hitbox(chara, hb.x + 0.25, hb.y + 0.25, hb.width - 0.5, (hb.height - 0.5) * 1.5)

        if self.world:checkCollision(extended_hitbox) then
            return true
        end
    end

    return false
end

return SlideArea