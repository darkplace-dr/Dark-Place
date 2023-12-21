local item, super = Class("light/egg", trye)

function item:init()
    super.init(self)

    -- Item this item will get turned into when consumed
    self.result_item = "light/egg"
end

function item:battleUseSound(user, target)
    Assets.playSound("egg")
end

return item