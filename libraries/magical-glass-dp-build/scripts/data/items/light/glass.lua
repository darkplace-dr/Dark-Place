local item, super = Class("light/glass", true)

function item:init()
    super.init(self)

    self.can_sell = false
end

function item:onBattleSelect(user, target)
    return false
end

return item