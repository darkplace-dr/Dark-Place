local ____Shop, super = Class(Shop,  "jeku_shop")

local function generateBS(len)
    local str = ""
    for i=1,(len or love.math.random(3,15)) do
        str = str .. string.char(love.math.random(0, 127))
    end
    return str
end

function ____Shop:init()
    super.init(self)
    self.background = ""

    self.og_options = {}
    for i=1,#self.menu_options do
        table.insert(self.og_options, self.menu_options[i][1])
    end

    self.timer:everyInstant(1, function()
        for i=1,#self.menu_options do
            if Utils.random()>0.8 then
                self.menu_options[i][1] = generateBS()
            else
                self.menu_options[i][1] = self.og_options[i]
            end
        end
    end)

    self:registerItem("healitem")
    self:registerItem("makissyringe")
    self:registerItem("bin_weapon", {bonuses = {attack = 1010}})
    self:registerItem("sfb_key", {stock=1})
end

function ____Shop:postInit()
    super.postInit(self)
    local function offsetChildren(obj)
        for i,child in ipairs(obj.children) do
            child.x = child.x + Utils.random(-5, 5)
            child.y = child.y + Utils.random(-5, 5)
            if child.children then
                offsetChildren(child)
            end
        end
    end
    offsetChildren(self)
end

function ____Shop:startTalk(talk)
    if talk == "Who are you" then
    elseif talk == "What is true?" then
    elseif talk == "This store" then
    elseif talk == "post_console" then
    elseif talk == "Threaten" then
    elseif talk == "Flirt" then
    elseif talk == "The Key" then
    elseif talk == "The fight" then
    elseif talk == "Where were you" then
    end
end

return ____Shop