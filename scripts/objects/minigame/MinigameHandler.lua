---@class MinigameHandler : Object
---@field music Music|nil
local MinigameHandler, super = Class(Object)

function MinigameHandler:init()
    super.init(self, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)

	self.name = "Minigame"
end

function MinigameHandler:postInit()
	if TARGET_MOD == Mod.info.id then -- temp behavior
		love.window.setTitle(string.format("%s - %s", Mod.info.name, self.name))
	end
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
    if Kristal.Config["debug"] and Input.ctrl() then
        if key == "m" and self.music then
			if self.music:isPlaying() then
				self.music:pause()
			else
				self.music:resume()
			end
        end
	end
end

function MinigameHandler:endMinigame()
	if self.resume_world_music then
		Game.world.music:resume()
		self.music:pause()
	end
	love.window.setTitle(Kristal.getDesiredWindowTitle())
	Game.state = "OVERWORLD"
	self:remove()
	Game.minigame = nil
end

return MinigameHandler
