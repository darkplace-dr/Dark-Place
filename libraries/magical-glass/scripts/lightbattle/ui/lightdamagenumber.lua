---@class LightDamageNumber : Object
---@overload fun(...) : LightDamageNumber
local LightDamageNumber, super = Class(Object)

-- Types: "mercy", "damage", "msg"
-- Arg:
--    "mercy"/"damage": amount
--    "msg": message sprite name ("mercy", "miss")
--    (use "_special" for the amalgamate damage popup)

function LightDamageNumber:init(type, arg, x, y, color, enemy)
    super.init(self, x, y)

    self:setOrigin(0.5, 0.5)

    self.color = color or {1, 0, 0}

    self.physics.speed_y = -4
    self.physics.gravity = 0.5
    self.physics.gravity_direction = math.rad(90)
    
    self.enemy = enemy

    -- Halfway between UI and the layer above it
    self.layer = BATTLE_LAYERS["damage_numbers"]

    self.type = type or "msg"

    if self.type == "msg" then
        self.message = arg or "miss"
    elseif self.type == "damage" and string.sub(tostring(arg or 0), 1, 1) == "+" and self.enemy.health + tonumber(arg) >= self.enemy.max_health then
        self.type = "msg"
        self.message = "max"
    else
        self.font = Assets.getFont("lwdmg")
        self.amount = arg or 0
        if self.type == "mercy" then
            if self.amount == 100 then
                self.color = {0, 1, 0}
            else
                self.color = COLORS["yellow"]
            end
            if self.amount >= 0 then
                self.text = "+"..self.amount.."%"
            else
                self.text = self.amount.."%"
            end
        elseif self.type == "miss" then
            self.color = {1, 1, 1}
        else
            self.text = tostring(self.amount)
        end
    end

    if self.message and self.message ~= "_special" then
        self.texture = Assets.getTexture("ui/lightbattle/msg/"..self.message)
        self.width = self.texture:getWidth()
        self.height = self.texture:getHeight()
    elseif self.text then
        self.width = self.font:getWidth(self.text)
        self.height = self.font:getHeight()
    end

    self.timer = 0
    self.delay = 2

    self.start_x = nil
    self.start_y = nil

    self.kill_timer = 0
    self.do_once = false
    self.kill_others = false
end

function LightDamageNumber:onAdd(parent)
    self.parent = parent
    for _,v in ipairs(parent.children) do
        if isClass(v) and (v:includes(LightDamageNumber)) then
            if self.kill_others then
                if (v.timer >= 1) then
                    v.killing = true
                end
            else
                v.kill_timer = 0
            end
        end
    end
    self.killing = false
end

function LightDamageNumber:update()
    if not self.start_x then
        self.start_x = self.x
        self.start_y = self.y
    end

    super.update(self)

    self.timer = self.timer + DTMULT

    if (self.timer >= self.delay) and (not self.do_once) then
        self.do_once = true
        self.start_speed_y = self.physics.speed_y
    end

    if self.timer >= self.delay then

        if self.y - 5 > self.start_y then
            self:resetPhysics()
            self.y = self.start_y
        end

        self.kill_timer = self.kill_timer + DTMULT
        if self.kill_timer > 40 then
            for _,obj in ipairs(self.parent.children) do
                if isClass(obj) and obj:includes(LightGauge) then
                    obj:remove()
                end
            end
            self:remove()
            self.enemy.active_msg = self.enemy.active_msg - 1
            return
        end

    end

    if self.x >= 600 then
        self.x = 600
    end
end

function LightDamageNumber:draw()
   
    if self.type == "msg" and self.message == "_special" then
        self.width = 100
        if self.timer >= self.delay then
            local messages = {
                "Don't worry about it.",
                "Absorbed",
                "I'm lovin' it.",
                "But it didn't work.",
                "nope",
                "FAILURE"
            }
            Draw.setColor(1, 0, 0, 1)
            love.graphics.setFont(Assets.getFont("main"))
            love.graphics.print(Utils.pick(messages))
        end
    elseif self.type == "mercy" then
        if self.timer >= self.delay then
            local r, g, b, a = self:getDrawColor()
            Draw.setColor(r, g, b, a)
    
            if self.texture then
                Draw.draw(self.texture, 0, 0)
            elseif self.text then
                love.graphics.setFont(self.font)
                love.graphics.print(self.text, 0, 0)
            end
        end
    elseif self.type == "damage" or self.type == "msg" then
        if self.timer >= self.delay then
            local r, g, b, a = self:getDrawColor()
            Draw.setColor(r, g, b, a)
    
            if self.texture then
                Draw.draw(self.texture, 0, 0)
            elseif self.text then
                love.graphics.setFont(self.font)
                love.graphics.print(self.text, 0, 0)
            end
        end
    end

    super.draw(self)
end

return LightDamageNumber