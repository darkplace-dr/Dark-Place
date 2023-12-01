local Spamgolor, super = Class(ActorSprite)

function Spamgolor:init(actor)
    super.init(self, actor)

    self.body = SpamgolorPart("battle/enemies/spamgolor_neo/body", 13, 17, 0, 0.33)
    self.body.id = "body"
    self.body.layer = 2
    self.body.swing_range = {math.rad(-4.5),math.rad(4.5)}
    self:addChild(self.body)

    self.arm_l = SpamgolorPart("battle/enemies/spamgolor_neo/arm_l", 16, 17, 0, 0.5, math.pi/2)
    self.arm_l.id = "arm_l"
    self.arm_l.layer = -12
    self:addChild(self.arm_l)

    self.arm_r = SpamgolorPart("battle/enemies/spamgolor_neo/arm_r", 35, 13, 0, 1, math.pi/2)
    self.arm_r.id = "arm_r"
    self.arm_r.layer = 3
    self:addChild(self.arm_r)

    self.wing_l = SpamgolorPart("battle/enemies/spamgolor_neo/wing_l", -4, 2, 1, 0.5)
    self.wing_l.id = "wing_l"
    self.wing_l.layer = -15
    self:addChild(self.wing_l)

    self.wing_r = SpamgolorPart("battle/enemies/spamgolor_neo/wing_r", 32, 4, 0, 0.5)
    self.wing_r.id = "wing_r"
    self.wing_r.layer = 1
    self:addChild(self.wing_r)

    self.head = SpamgolorHead(12, 1)
    self.head.id = "head"
    self.head.layer = 0
    self:addChild(self.head)

    -- deltarune adds these parts in a very specific order which apparently influences swing speed
    self.parts = {
        self.wing_l,
        self.arm_l,
        self.body,
        self.head,
        self.arm_r,
        self.wing_r,
    }

    self.swing_speed = 2
    self.swing_range = {math.rad(-10), math.rad(10)}
    for i,part in ipairs(self.parts) do
        if part ~= self.head then
            part.swing_speed = 1 + (i-1)/5
        end
    end

    self.strings = {}
    self.bg_strings = {}
    local sprite = self.wing_l.sprite
    local ox, oy = sprite:getRotationOriginExact()
    local bg_sx, bg_sy = sprite:getRelativePos(ox, oy, self)
    for i=1,18 do
        local str = SpamgolorString(bg_sx * (0.9 + (i-1)/18) - ox/4, bg_sy, false)
        self:addChild(str)
        self.bg_strings[i] = str
        table.insert(self.strings, str)
    end
    self.fg_strings = {}
    for i=1,6 do
        local sprite = self.parts[i].sprite
        local ox, oy = sprite:getRotationOriginExact()
        local fg_sx, fg_sy = sprite:getRelativePos(ox, oy, self)
        local str = SpamgolorString((fg_sx / 1.2) + ((i-1)*2.5), fg_sy, true, (fg_sx / 1.5) + ((i-1)*4))
        self:addChild(str)
        self.fg_strings[i] = str
        table.insert(self.strings, str)
    end

    self.timer = Timer()
    self:addChild(self.timer)
end

-- heck it, custom version
function Spamgolor:setAnimation(anim, ...)
    if not ignore_actor then
        self.actor:onSetAnimation(self, anim, ...)
    end
end

function Spamgolor:getPart(name)
    if isClass(name) then
        return name
    elseif self[name] then
        return self[name]
    else
        error("Part does not exist: "..name)
    end
end

function Spamgolor:getPartIndex(part)
    if type(part) == "string" then
        part = self:getPart(part)
    end
    for i,other in ipairs(self.parts) do
        if other == part then
            return i
        end
    end
end

function Spamgolor:setPartSprite(name, path)
    local part = self:getPart(name)
    part:setSprite(path)
end

function Spamgolor:setPartRotation(name, rotation)
    local part = self:getPart(name)
    part.swing_rotation = rotation
end

function Spamgolor:tweenPartRotation(name, rotation, time, ease)
    local part = self:getPart(name)
    self.timer:tween(time or 0.5, part, {swing_rotation = rotation}, ease or "linear")
end

function Spamgolor:setPartScale(name, scale_x, scale_y)
    local part = self:getPart(name)
    part:setScale(scale_x, scale_y or scale_x)
end

function Spamgolor:tweenPartScale(name, scale_x, scale_y, time, ease)
    local part = self:getPart(name)
    self.timer:tween(time or 0.5, part, {scale_x = scale_x, scale_y = scale_y or scale_x}, ease or "linear")
end

function Spamgolor:setPartShaking(name, shake)
    local part = self:getPart(name)
    if type(shake) == "number" then
        part.shake = shake
    elseif shake then
        part.shake = 0.5
    else
        part.shake = 0
    end
end

function Spamgolor:setPartSwingShaking(name, shake)
    local part = self:getPart(name)
    if type(shake) == "number" then
        part.swing_shake = shake
    elseif shake then
        part.swing_shake = math.rad(2)
    else
        part.swing_shake = 0
    end
end

function Spamgolor:setPartSwingSpeed(name, speed, keep_spin)
    local part = self:getPart(name)
    part.swing_speed = speed
    if speed == 0 then
        part.siner = 0
    end
    if keep_spin then
        part.swing_rotation = part.sprite.rotation
    end
end

function Spamgolor:setPartSwingRange(name, min, max)
    local part = self:getPart(name)
    if not max then
        part.swing_range = {-min, min}
    elseif min then
        part.swing_range = {min, max}
    else
        part.swing_range = nil
    end
end

function Spamgolor:tweenPartSwingRange(name, min, max, time, ease)
    local part = self:getPart(name)
    if not max then
        min, max = -min, min
    end
    if not part.swing_range then
        part.swing_range = Utils.copy(self.swing_range)
    end
    self.timer:tween(time or 0.5, part.swing_range, {min, max}, ease or "linear")
end

function Spamgolor:setPartSine(name, value)
    local part = self:getPart(name)
    part.siner = value or 0
end

function Spamgolor:setHeadFrame(num)
    self.head.animating = false
    self.head:setFrame(num)
end

function Spamgolor:setHeadAnimating(state)
    self.head.animating = state ~= false
end

function Spamgolor:setAllPartsShaking(shake)
    for _,part in ipairs(self.parts) do
        if type(shake) == "number" then
            part.shake = shake
        elseif shake then
            part.shake = 0.5
        else
            part.shake = 0
        end
    end
end

function Spamgolor:setSwingSpeed(speed)
    self.swing_speed = speed
end

function Spamgolor:setSwingRange(min, max)
    if not max then
        self.swing_range = {-min, min}
    else
        self.swing_range = {min, max}
    end
end

function Spamgolor:setStringCount(num)
    if num < 4 then
        for i,str in ipairs(self.bg_strings) do
            if num == 0 then
                str.visible = false
            else
                str.visible = i == 9
            end
        end
    else
        for _,str in ipairs(self.bg_strings) do
            str.visible = true
        end
    end
    local keep = Utils.pickMultiple(self.fg_strings, num)
    for i=1,6 do
        local str = self.fg_strings[i]
        if Utils.containsValue(keep, str) then
            str.visible = true
        else
            str.visible = false
        end
    end
end

function Spamgolor:snapString(index, remove)
    local str
    if index then
        str = self.fg_strings[index]
    else
        str = Utils.pick(self.fg_strings, function(v) return v.visible and v.alpha == 1 end)
    end
    if remove then
        str:remove()
        Utils.removeFromTable(self.fg_strings, str)
    else
        str.alpha = 0
        self.timer:after(1, function()
            str:fadeTo(1, 0.05)
        end)
    end
    local snap = self:addChild(SpamgolorSnap(str.x + math.sin(str.siner/30)*2, str.y, str.top_x))
    self.timer:after(2, function()
        snap:remove()
    end)
end

function Spamgolor:snapStrings(count, remove)
    for i=1,count do
        self:snapString(nil, remove)
    end
end

function Spamgolor:resetPart(name, full)
    local part = self:getPart(name)
    part:reset(full, self:getPartIndex(part))
end

function Spamgolor:resetParts(full)
    self.swing_speed = 1
    for i,part in ipairs(self.parts) do
        part:reset(full, i)
    end
end

return Spamgolor