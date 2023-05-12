local WorldCutscene, super = Class("WorldCutscene", true)

function WorldCutscene:showNametag(text, options)
    options = options or {}

    if self.nametag then self.nametag:remove() end

    self.nametag = Nametag(text, options)
    self.nametag.layer = WORLD_LAYERS["textbox"]
    self.nametag:setParallax(0, 0)
    if options["top"] == nil and self.textbox_top == nil then
        local _, player_y = Game.world.player:localToScreenPos()
        options["top"] = player_y > 260
    end
    if options["top"] or (options["top"] == nil and self.textbox_top) then
       local bx, by = self.textbox:getBorder()
       self.nametag.y = by + 2
    end
    Game.world:addChild(self.nametag)
end

function WorldCutscene:changeNametag(text)
    self.nametag:changeText(text)
end

function WorldCutscene:hideNametag()
    if self.nametag then
        self.nametag:remove()
        self.nametag = nil
    end
end

return WorldCutscene
