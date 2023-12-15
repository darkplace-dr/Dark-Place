local actor, super = Class(Actor, "prunsel")

function actor:init()
    super.init(self)

    self.name = "Prunsel"

    self.width = 64
    self.height = 64

    self.color = {1, 0, 0}

    self.flip = nil

    self.path = "world/npcs/prunsel"
    self.default = ""
	
    self.always_visible = false
end

function actor:onWorldUpdate(chara)
    chara.sprite.y = math.sin(Kristal.getTime()*1)*5
	
    if self.always_visible then
        chara.sprite.alpha = 1
    elseif Game.world and Game.world.player then
        local player = Game.world.player

        local dist_x, dist_y = 0, 0

        if player.x >= chara.x and player.x < chara.x + chara.width then
            dist_x = 0
        else
            dist_x = math.min(math.abs(player.x - chara.x), math.abs(player.x - (chara.x + chara.width)))
        end

        if player.y >= chara.y and player.y < chara.y + chara.height then
            dist_y = 0
        else
            dist_y = math.min(math.abs(player.y - chara.y), math.abs(player.y - (chara.y + chara.height)))
        end

        local fade_dist = Utils.clamp(math.max(dist_x, dist_y), 20, 80)

        chara.sprite.alpha = 1 - (fade_dist - 20) / 60
    end
end

return actor
