local System, super = Class(Object)

function System:init(x, y, w, h, o)
    super:init(self, x, y, w, h)
    self.layer = (type(o.layer) == "number" and o.layer) or self:getLayerValue(o.layer)
    self.timer = Timer()
    self:addChild(self.timer)
    self.particles = {}
end

function System:onAdd(parent)
    super:onAdd(self, parent)
    if self:getValue("every") > 0 then
        local total_time = 0
        self.timer:script(function(wait)
            while true do
                if self:getStage() and self.data.auto and self.parent.visible then
                    self:emit()
                end
                local t = self:getValue("every")
                total_time = total_time + t
                wait(t)
                local time = self:getValue("time")
                if time > 0 and total_time >= time then break end
            end
        end)
    elseif self.data.auto and self.parent.visible then
        self:emit()
    end
end

function System:emit() end

function System:getParent()
    if Game.battle then
        return Game.battle
    elseif Game.shop then
        return Game.shop
    elseif Game.world then
        return Game.world
    elseif Game.stage then
        return Game.stage
    else
        return Kristal.stage
    end
end

function System:getValue(particle, name, tbl)
    if type(particle) == "string" then
        tbl = name
        name = particle
    end
    tbl = tbl or self.data
    local val = tbl[name]
    while type(val) == "table" do
        if type(val[1]) == "number" then
            if #val == 1 then
                val = val[1]
                break
            else
                val = Utils.random(val[1], val[2])
                break
            end
        else
            val = Utils.pick(val)
        end
    end
    if type(val) == "function" then
        val = val(particle)
    end
    if type(val) == "number" then
        local vary = tbl[name.."_var"]
        local min, max = tbl[name.."_min_var"], tbl[name.."max_var"]
        if not min then
            min = tbl[name.."_dist"]
        end
        if min then
            if max then
                val = val + Utils.random(min, max)*Utils.randomSign()
            elseif vary then
                val = val + Utils.random(min, min+vary)*Utils.randomSign()
            else
                val = val + min*Utils.randomSign()
            end
        elseif vary then
            val = val + Utils.random(-vary, vary)
        end
    end
    local round = tbl[name.."_round"] or self.data.round[name]
    if round and type(val) == "number" then
        if type(round) == "number" then
            val = Utils.round(val, round)
        else
            val = Utils.round(val, 1)
        end
    end
    return val
end

function System:getColorValue(particle)
    local color = Utils.copy(self.data.color)
    if type(color[1]) == "table" then
        color = Utils.pick(color)
    end
    if type(color) == "function" then
        color = color(particle)
    end
    local r,g,b,a = unpack(color)
    if not a then
        a = self:getValue(particle, "alpha")
    end
    return r,g,b,a
end

function System:getLayerValue(layer)
    local parent = self:getParent()
    if type(layer) == "number" then
        return layer
    end
    if parent == Game.battle then
        return BATTLE_LAYERS[layer] or 0
    elseif parent == Game.shop then
        return SHOP_LAYERS[layer] or 0
    elseif parent == Game.world then
        return Game.world:parseLayer(layer)
    end
    return 0
end

function System:clear()
    for _,p in ipairs(self.particles) do
        p:remove()
    end
end

return System