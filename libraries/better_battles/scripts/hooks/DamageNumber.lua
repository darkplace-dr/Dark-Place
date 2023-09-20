---@class DamageNumber : DamageNumber
---@overload fun(...) : DamageNumber
local DamageNumber, super = Class(DamageNumber)

function DamageNumber:init(type, arg, x, y, color)
    super:init(self, type, arg, x, y, color)

    self:setOrigin(1, 0)

    self.color = color or {1, 1, 1}

    -- Halfway between UI and the layer above it
    self.layer = BATTLE_LAYERS["damage_numbers"]

    self.type = type or "msg"
    if self.type == "msg" then
        self.message = arg or "miss"
    else
        self.amount = arg or 0
        if self.type == "mercy" then
            self.font = Assets.getFont("goldnumbers")
            if self.amount == 100 then
                self.type = "msg"
                self.message = "mercy"
            elseif self.amount < 0 then
                self.text = self.amount.."%"
                self.color = {self.color[1] * 0.75, self.color[2] * 0.75, self.color[3] * 0.75}
            else
                self.text = "+"..self.amount.."%"
            end
        elseif self.type == "tired" then
            self.font = Assets.getFont("bluenumbers")
            if self.amount == 100 then
                self.type = "msg"
                self.message = "tired"
            elseif self.amount < 0 then
                self.text = self.amount.."%"
                self.color = {self.color[1] * 0.75, self.color[2] * 0.75, self.color[3] * 0.75}
            else
                self.text = "+"..self.amount.."%"
            end
        else
            self.text = tostring(self.amount)
            self.font = Assets.getFont("bignumbers")
        end
    end

    if self.message then
        self.texture = Assets.getTexture("ui/battle/msg/"..self.message)
        self.width = self.texture:getWidth()
        self.height = self.texture:getHeight()
    elseif self.text then
        self.width = self.font:getWidth(self.text)
        self.height = self.font:getHeight()
    end

    self.timer = 0
    self.delay = 2

    self.bounces = 0

    self.stretch = 0.2
    self.stretch_done = false

    self.start_x = nil
    self.start_y = nil

    self.physics.speed_x = 0
    self.physics.speed_y = 0
    self.start_speed_y = 0

    self.kill_timer = 0
    self.killing = false
    self.kill = 0

    self.do_once = false

    self.kill_others = false
end

return DamageNumber