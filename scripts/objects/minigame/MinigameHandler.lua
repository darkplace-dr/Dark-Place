local MinigameHandler, super = Class(Object)

function MinigameHandler:init()
    super.init(self, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
end

function MinigameHandler:postInit()
	if Game.world.music:isPlaying() and self.music then
        self.resume_world_music = true
        Game.world.music:pause()
    end
end

function MinigameHandler:update()
    super.update(self)
end

function MinigameHandler:draw()
    super.draw(self)
end

function MinigameHandler:onKeyPressed(key)
	
end

function MinigameHandler:endMinigame()
	if self.resume_world_music then
		Game.world.music:resume()
		self.music:pause()
	end
	Game.state = "OVERWORLD"
	self:remove()
	Game.minigame = nil
end

return MinigameHandler
