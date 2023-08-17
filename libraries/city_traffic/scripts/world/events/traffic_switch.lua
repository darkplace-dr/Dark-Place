local TrafficSwitch, super = Class(Event)

function TrafficSwitch:init(data)
    super.init(self, data)

    local pr = data["properties"]

    do
        self.group          = pr["group"]           or 0
        self.type           = pr["type"]            or 0
        self.default_time   = pr["default_time"]    or 5

        self.timefactor     = 30
        self._active        = false
        self.timer          = (self.default_time * self.timefactor)
        self.numberdisplay  = true

        self.path           = "world/events/traffic/"
    end

    self.solid = true
    self:setHitbox(0, 0, 38, 102)

    self:setSprite(self.path.."traffic_switch")
    self.sprite:setScale(2)
    self.sprite:setFrame(1)

    Kristal.callEvent("onTrafficSwitchInit", self)

    if self.numberdisplay then
        self.text = Text("0", 10, 14, 26, 20, "bignumbers")
        self:addChild(self.text)
    end
end

function TrafficSwitch:update()
    super.update(self)
    if Kristal.callEvent("beforeTrafficSwitchUpdate", self) then
        return
    end

    if self._active and not Game.world.cutscene and not Game.world.menu and not Game.world.car_collision then
        self.timer = self.timer - DTMULT
        if self.timer <= 0 then
            if not self._deactivated_by_interact then
                if Kristal.callEvent("beforeTrafficSwitchDeactivate", self, "timerExpire") then
                    goto numberupdate
                end
            end

            self.timer = self.default_time * self.timefactor
            self._active = false
            Assets.playSound("noise")
            self.sprite:setFrame(1)
            for _, child in ipairs(Game.world.children) do
                if (child.id == "traffic_car" or child.id == "traffic_car_generator") and child.group == self.group then
                    child.walking = false
                    child._active = true
                end
                if child.id == "traffic_light" and child.group == self.group then
                    child.stop = 0
                end
            end

            local reason = self._deactivated_by_interact and "fromInteract" or "timerExpire"
            Kristal.callEvent("onTrafficSwitchDeactivate", self, reason)
            self._deactivated_by_interact = nil
        end
    end

    ::numberupdate::

    if self.numberdisplay then
        local timernumber = math.ceil(self.timer / self.timefactor)
        timernumber = Utils.clamp(timernumber, 0, 9)
        if timernumber == 1 then
            self.text.x = 10
        else
            self.text.x = 10
        end
        self.text:setText(tostring(timernumber))
        self.text.font = "bignumbers"
    end

    Kristal.callEvent("onTrafficSwitchUpdate", self)
end

function TrafficSwitch:onInteract()
    if Kristal.callEvent("beforeTrafficSwitchInteract", self) then
        return
    end

    if self._active then
        if Kristal.callEvent("beforeTrafficSwitchDeactivate", self, "fromInteract") then
            return
        end
        self._deactivated_by_interact = true

        self.timer = 0
    end

    if not self._active then
        for _, child in ipairs(Game.world.children) do
            if child.id == "traffic_switch" and child.group == self.group and child ~= self and child._active == true then
                if Kristal.callEvent("beforeTrafficSwitchDeactivate", child, "fromOther") then
                    return
                end
                child.timer = child.default_time * child.timefactor
                child._active = false
                Kristal.callEvent("onTrafficSwitchDeactivate", child, "fromOther")
            end

            if child.id == "traffic_light" and child.group == self.group then
                child.stop = 1
            end
        end

        Assets.playSound("noise")
        if self.type == 0 then
            self.sprite:setFrame(2)
        end
        self.timer = self.default_time * self.timefactor
        self._active = true

        if self.type == 0 then
            for _, child in ipairs(Game.world.children) do
                if (child.id == "traffic_car" or child.id == "traffic_car_generator") and child.group == self.group then
                    child._active = false
                end
            end
        elseif self.type == 1 then
            for _, child in ipairs(Game.world.children) do
                if (child.id == "traffic_car" or child.id == "traffic_car_generator") and child.group == self.group then
                    child.walking = true
                    child._active = true
                end
            end
        end

        Kristal.callEvent("onTrafficSwitchInteract", self)
    end

    return true
end

function TrafficSwitch:draw()
    if Kristal.callEvent("beforeTrafficSwitchDraw", self) then
        return
    end

    local color = self:getDisplayColor()

    if type(color) == "string" then
        color = COLORS[color]
    end

    if self.numberdisplay then
        self.text.color = color
    end

    super.draw(self)

    local x, y = self:getSymbolOffset()
    love.graphics.setColor(color)
    love.graphics.draw(Assets.getTexture(self.path.."trafficswitch_symbol_"..tostring(self:getSymbol())), x*2, y*2, 0, 2, 2)

    Kristal.callEvent("onTrafficSwitchDraw", self)
end

function TrafficSwitch:getSymbolOffset()
    local x, y = Kristal.callEvent("getTrafficSwitchSymbolOffset", self)

    return x or 2, y or 19
end

function TrafficSwitch:getDisplayColor()
    local color = "gray"

    if self._active and self.type == 1 then
        color = "lime"
    elseif self._active and self.type == 0 then
        color = "red"
    end

    color = Kristal.callEvent("getTrafficSwitchColor", self, color) or color

    return color
end

function TrafficSwitch:getSymbol()
    local sym = Kristal.callEvent("getTrafficSwitchSymbol", self)

    return sym or self.type + 1
end

return TrafficSwitch