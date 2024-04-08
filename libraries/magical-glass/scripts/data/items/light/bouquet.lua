local item, super = Class("light/bouquet", true)

function item:init()
    super.init(self)

    self.price = 80
end

function item:onBattleSelect(user, target)
    return false
end

return item