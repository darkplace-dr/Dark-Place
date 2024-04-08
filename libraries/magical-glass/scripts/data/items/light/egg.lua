local item, super = Class("light/egg", true)

function item:init()
    super.init(self)

    self.can_sell = false
end

function item:onBattleSelect(user, target)
    return false
end

function item:battleUseSound(user, target)
    Assets.playSound("egg")
end

function item:onBattleUse(user, target)
    Assets.playSound("egg")
    return true
end

return item