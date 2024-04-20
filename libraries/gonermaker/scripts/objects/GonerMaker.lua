---@class GonerMaker
local GonerMaker, super = Class(Object)

local function addPart(self, frames, y)
    table.insert(self.parts, {
        x = 0,
        y = y,
        ideal_x = 0,
        selected = 1,

        lock = false,
        spr = Assets.getFrames(frames)
    })
end

function GonerMaker:init(x, y)
    super.init(self, x, y)
    self.layer = 1000
    self:setScale(2)

    self.step = 1
    self.parts = {}

    self.siner = 0

    addPart(self, "IMAGE_GONERHEAD", 0)
    addPart(self, "IMAGE_GONERBODY", 17)
    addPart(self, "IMAGE_GONERLEGS", 30)

    for _, part in ipairs(self.parts) do
        part.ideal_x = part.x * -25
        part.x = part.ideal_x
    end
end

function GonerMaker:update()
    self.siner = self.siner + DTMULT

    if Input.pressed("left") then self.parts[self.step].selected = self.parts[self.step].selected - 1 end
    if Input.pressed("right") then self.parts[self.step].selected = self.parts[self.step].selected + 1 end

    for _, part in ipairs(self.parts) do
        part.selected = Utils.clamp(part.selected, 1, #part.spr)
        part.ideal_x = (part.selected - 1) * -25

        if part.x < part.ideal_x then
            if math.abs(part.ideal_x - part.x) >= 0   then part.x = part.x + 5 end
            if math.abs(part.ideal_x - part.x) > 50   then part.x = part.x + 5 end
            if math.abs(part.ideal_x - part.x) > 100  then part.x = part.x + 5 end
            if math.abs(part.ideal_x - part.x) > 150  then part.x = part.x + 5 end
        end

        if part.x > part.ideal_x then
            if math.abs(part.ideal_x - part.x) >= 0   then part.x = part.x - 5 end
            if math.abs(part.ideal_x - part.x) > 50   then part.x = part.x - 5 end
            if math.abs(part.ideal_x - part.x) > 100  then part.x = part.x - 5 end
            if math.abs(part.ideal_x - part.x) > 150  then part.x = part.x - 5 end
        end

        if part.x == part.ideal_x then
            part.lock = true
        else
            part.lock = false
        end
    end

    super.update(self)
end

function GonerMaker:draw()
    local offset_x, offset_y = math.sin(self.siner / 24) * 2, math.sin(self.siner / 30) * 2


    -- so it doesnt overlap
    for step = 1, self.step do
        local part = self.parts[step]
        local x, y = part.x + offset_x, part.y + offset_y

        if part.lock then
            Draw.setColor({}, 0.4)

            local width, height = part.spr[part.selected]:getWidth(), part.spr[part.selected]:getHeight()

            local s_size = math.abs(math.sin(self.siner / 16) / 2) / 2
            Draw.draw(part.spr[part.selected], offset_x - (s_size * width) / 2, y - (s_size * height) / 2, 0, 1 + s_size, 1 + s_size)
            s_size = math.abs(math.sin(self.siner / 21) / 2) / 2
            Draw.draw(part.spr[part.selected], offset_x - (s_size * width) / 2, y - (s_size * height) / 2, 0, 1 + s_size, 1 + s_size)

            Draw.setColor()
        end
    end

    for step = 1, self.step do
        local part = self.parts[step]
        local x, y = part.x + offset_x, part.y + offset_y

        if step == self.step then
            for i, frame in ipairs(part.spr) do
                Draw.setColor({}, 1 - (math.abs(x + (i - 1) * 25)) / 120)
                Draw.draw(frame, x + ((i - 1) * 25), y)
                Draw.setColor()
            end
        else
            Draw.draw(part.spr[part.selected], x, y)
        end
    end

    super.draw(self)
end

return GonerMaker