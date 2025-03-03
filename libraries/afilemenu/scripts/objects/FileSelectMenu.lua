---@class FileSelectMenu: Object
---@overload fun(): FileSelectMenu
local FileSelectMenu, super = Class(Object)

function FileSelectMenu:init()
    super.init(self)
    self.heart_target_x, self.heart_target_y = 0,0
    self.state_manager = StateManager("", self, true)
    self.file_select = ModlandFileSelect(self)
    self.completion_select = ModlandCompletionSelect(self)
    self.file_namer = ModlandFileNamer(self)
    self.options = ModlandOptions(self)
    self.state_manager:addState("FILESELECT", self.file_select)
    self.state_manager:addState("FILENAME", self.file_namer)
    self.state_manager:addState("COMPLETION", self.completion_select)
    self.state_manager:addState("OPTIONS", self.options)

    -- OPTIONS substates
    self.state_manager:addState("CONTROLS", MainMenuControls(self--[[@as MainMenu]]))
    self.state_manager:addState("DEFAULTNAME", MainMenuDefaultName(self--[[@as MainMenu]]))

    self.font = Assets.getFont("main")
    
    self.heart = Sprite("player/heart_menu")
    self.heart.visible = true
    self.heart:setOrigin(0.5, 0.5)
    self.heart:setScale(2, 2)
    self.heart:setColor(Kristal.getSoulColor())
    self.heart.layer = 100
    self:addChild(self.heart)
    self.chapter_name = Kristal.callEvent("afmGetChapterName") or {
        cancel = "Don't Use Chapter 7 FILE",
        select = "Ch 7 Files",
        title = "Start Chapter 1 from Chapter 7's FILE",
        title_DEVICE = "",
    }
end

function FileSelectMenu:onAddToStage()
    -- self.state_manager:setState("FILESELECT")
    self.state_manager:setState("FILESELECT")
    if not Kristal.hasAnySaves(Mod.info.id) and self.file_select.previous_chapter then
        self:pushState("COMPLETION")
    end
end

function FileSelectMenu:setState(state, ...)
    self.state_manager:setState(state, ...)
end

function FileSelectMenu:pushState(state, ...)
    self.state_manager:pushState(state, ...)
end

function FileSelectMenu:popState(...)
    self.state_manager:popState(...)
end

function FileSelectMenu:draw()
    love.graphics.setFont(self.font)
    super.draw(self)
    self.file_select.mod = self.file_select.mod or Mod.info
    self.completion_select.mod = self.completion_select.mod or Mod.info
    self.state_manager:draw()
end

function FileSelectMenu:update()
    super.update(self)
    self.state_manager:update()
    if self.heart.visible then
        if (math.abs((self.heart_target_x - self.heart.x)) <= 2) then
            self.heart.x = self.heart_target_x
        end
        if (math.abs((self.heart_target_y - self.heart.y)) <= 2) then
            self.heart.y = self.heart_target_y
        end
        self.heart.x = self.heart.x + ((self.heart_target_x - self.heart.x) / 2) * DTMULT
        self.heart.y = self.heart.y + ((self.heart_target_y - self.heart.y) / 2) * DTMULT
    end
end

function FileSelectMenu:loadGame(id)
    local path = "saves/" .. Mod.info.id .. "/file_" .. id .. ".json"
    local fade = true
    if love.filesystem.getInfo(path) then
        local data = JSON.decode(love.filesystem.read(path))
        Game:load(data, id, fade)
    else
        Game:load(nil, id, fade)
    end
end

function FileSelectMenu:onKeyPressed(key, is_repeat)
    self.state_manager:call("keypressed", key, is_repeat)
end

function FileSelectMenu:onKeyReleased(key)
    self.state_manager:call("keyreleased", key)
end

return FileSelectMenu