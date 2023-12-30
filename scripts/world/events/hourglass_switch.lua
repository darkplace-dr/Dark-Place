local hourglass_switch, super = Class(Event, "hourglass_switch")

function hourglass_switch:init(data)
    super.init(self, data)

    data.properties = data.properties or {}

    self.group = data.properties["group"]
    self.off_sprite = "world/events/fields/hourglass_switch/off"
    self.on_sprite = "world/events/fields/hourglass_switch/on"
    self.can_interact = true
    self.solid = true

    self:setSprite(self.off_sprite)
    self:setHitbox(0, 40, 40, 40)
    self:setScale(1)
    self:addChild(self.sprite)
end

function hourglass_switch:onLoad()
    self:checkCompletion()
end

function hourglass_switch:onCompleted()
    self:setFlag("solved", true)
    for _,button in ipairs(Game.stage:getObjects(TileButton)) do
        if button.group == self.group then
            button:disable()
        end
    end
    Assets.playSound("break1")
    Assets.playSound("locker")
    self:setSprite(self.off_sprite)
end

function hourglass_switch:onInteract()
    if self:getFlag("solved", false) ~= true then
        if self.can_interact then
            self.can_interact = false
            Assets.playSound("noise")
            self.sprite:set(self.on_sprite)
            self.sprite:play(2, false)
            for _,button in ipairs(Game.stage:getObjects(TileButton)) do
                if button.group == self.group then
                    button:enable()
                end
            end
            Game.world.timer:after(9, function()
                for _,button in ipairs(Game.stage:getObjects(TileButton)) do
                    if button.group == self.group then
                        button:disable()
                    end
                end
                Assets.playSound("noise")
                self:setSprite(self.off_sprite)
                Game.world.timer:after(0.25, function()
                    self.can_interact = true
                end)
            end)
        end
    end

    return true
end

function hourglass_switch:checkCompletion()
    local flag_id = "tile_puzzle#" .. tostring(self.group)

    local was_completed = self.world.map:getFlag(flag_id)

    if self.once and was_completed then
        return
    end

    local all_pressed = true
    for _, button in ipairs(Game.stage:getObjects(TileButton)) do
        if button.group == self.group and not button.pressed then
            all_pressed = false
            break
        end
    end

    if all_pressed ~= was_completed then
        self.world.map:setFlag(flag_id, all_pressed)

        if all_pressed then
            --self:onCompleted()
        end
    end
end

return hourglass_switch