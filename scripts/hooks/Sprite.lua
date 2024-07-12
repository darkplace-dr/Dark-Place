-- Yep
Utils.hook(Sprite, "setTextureExact", function(_, self, texture)
    if type(texture) == "string" then
        self.texture = Assets.getTexture(texture)
    else
        self.texture = texture
    end

    if not self.texture then
        if texture ~= nil then
            Kristal.Console:warn("Texture not found: " .. Utils.dump(texture))
        end

        self.texture = Assets.getTexture("ui/missing_texture")
        self.texture_path = Assets.getTextureID(self.texture)
        if self.width > 0 and self.height > 0 then
            local resized_texture_canvas = Draw.pushCanvas(self.width, self.height)
            Draw.draw(self.texture, 0, 0, 0, self.width/self.texture:getWidth(), self.height/self.texture:getHeight())
            Draw.popCanvas()
            self.texture = love.graphics.newImage(resized_texture_canvas:newImageData())
        else
            self.width = self.texture:getWidth()
            self.height = self.texture:getHeight()
        end
    else
        self.texture_path = Assets.getTextureID(texture)

        if self.use_texture_size then
            self.width = self.texture:getWidth()
            self.height = self.texture:getHeight()
        end
    end
end)

return Sprite