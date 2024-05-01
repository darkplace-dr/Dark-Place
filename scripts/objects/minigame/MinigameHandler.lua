---@class MinigameHandler : Object
---@field music Music|nil
local MinigameHandler, super = Class(Object)

function MinigameHandler:init()
    super.init(self, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)

    self.name = "Minigame"
end

function MinigameHandler:postInit()
    self:pauseWorldMusic()
    self:changeWindowTitle()
end
-- Part of postInit 1, don't use unless you have to
function MinigameHandler:pauseWorldMusic()
    if Game.world.music:isPlaying() and self.music then
        self.resume_world_music = true
        Game.world.music:pause()
    end
end
-- Part of postInit 2, don't use unless you have to
function MinigameHandler:changeWindowTitle()
    love.window.setIcon(Kristal.icon)
    love.window.setTitle(string.format("%s - %s", Mod.info.name, self.name))
    Mod:setPresenceState(string.format("In a minigame: %s", self.name))
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

-- Convenience function that does a bit of cleanup that is usually done
-- as we transition to the overworld \
-- You don't *have* to use this, though
function MinigameHandler:preEndCleanup()
    if self.resume_world_music then
        Game.world.music:resume()
        self.resume_world_music = false
    end
    Mod:funnytitle()
    Mod:setPresenceState(nil)
end

function MinigameHandler:endMinigame()
    self:preEndCleanup()
    if self.music then
        self.music:remove()
    end
    Game.state = "OVERWORLD"
    self:remove()
    Game.minigame = nil
end

return MinigameHandler