---@class TreasureChest : Event
---@overload fun(...) : TreasureChest
local CardChest, super = Class(Event, "cardchest")

function CardChest:init(data)
    super.init(self, data.x, data.y)

    properties = data.properties or {}

    self:setOrigin(0.5, 0.5)
    self:setScale(2)

    self.sprite = Sprite("world/events/treasure_chest")
    self:addChild(self.sprite)

    self:setSize(self.sprite:getSize())
    self:setHitbox(0, 8, 20, 12)

    self.card = properties["card"]
	self.name = Mod:createCard(self.card).name

    self.set_flag = properties["setflag"]
    self.set_value = properties["setvalue"]

    self.solid = true
end

function CardChest:getDebugInfo()
    local info = super.getDebugInfo(self)
    table.insert(info, "Card: " .. self.name)
    table.insert(info, "Opened: " .. (self:getFlag("opened") and "True" or "False"))
    return info
end

function CardChest:onAdd(parent)
    super.onAdd(self, parent)

    if self:getFlag("opened") then
        self.sprite:setFrame(2)
    end
end

function CardChest:onInteract(player, dir)
    if self:getFlag("opened") then
        self.world:showText("* (The chest is empty.)")
    else
        Assets.playSound("locker")
        self.sprite:setFrame(2)
        self:setFlag("opened", true)

		Mod:addCard(self.card)
        self.world:showText({
            "* (You opened the treasure\nchest.)[wait:5]\n* (Inside was [color:yellow]"..self.name.."[color:reset].)",
            "* ([color:yellow]"..self.name.."[color:reset] was put into your [color:yellow]CARDs[color:reset].)"
        })

        if self.set_flag then
            Game:setFlag(self.set_flag, (self.set_value == nil and true) or self.set_value)
        end
    end

    return true
end

return CardChest