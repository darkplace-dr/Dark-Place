local FloorMirror, super = Class(Event)

function FloorMirror:init(x, y, w, h, properties)
    self.floor_mirror_sprites =  {
        ["walk/down"] = "walk/down",
        ["walk/up"] = "walk/up",
        ["walk/left"] = "walk/left",
        ["walk/right"] = "walk/right",
    }
    super.init(self, x, y, w, h)

    properties = properties or {}

    self.canvas = love.graphics.newCanvas(self.width, self.height)

    self.offset = properties["offset"] or 0
    self.offset = self.offset - 60
    self.opacity = properties["opacity"] or 1

    self.bottom = self.y + self.height
    self.flip_y = true
end

function FloorMirror:drawMirror()
    local to_draw = {}
    for _, obj in ipairs(Game.world.children) do
        if obj:includes(Character) then
            table.insert(to_draw, 1, obj) -- always add to the start of the table, so they render in reverse layer order
        end
    end
    for _, obj in ipairs(to_draw) do
        self:drawCharacter(obj)
    end
end

function FloorMirror:drawCharacter(chara)
    love.graphics.push()

    chara:preDraw()
    local oyd = chara.y - self.bottom
    love.graphics.translate(0, -oyd + self.offset)
    local oldsprite = string.sub(chara.sprite.texture_path, #chara.sprite.path + 2)
    local t = Utils.split(oldsprite, "_")
    local pathless = t[1]
    local frame = t[2]
    local newsprite = oldsprite
    local mirror = chara.actor.floor_mirror_sprites or self.floor_mirror_sprites
    if mirror and mirror[pathless] then
        newsprite = mirror[pathless] .. "_" .. frame
    end
    chara.sprite:setTextureExact(chara.actor.path .. "/" .. newsprite)
    chara:draw()
    chara:postDraw()
    love.graphics.pop()
end

function FloorMirror:draw()
    super.draw(self)

    Draw.pushCanvas(self.canvas)
    love.graphics.clear()
    love.graphics.translate(-self.x, -self.y)
    self:drawMirror()
    Draw.popCanvas()

    Draw.setColor(1, 1, 1, self.opacity)
    Draw.draw(self.canvas)
    Draw.setColor(1, 1, 1, 1)
end

return FloorMirror