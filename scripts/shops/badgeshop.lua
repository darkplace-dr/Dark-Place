local BadgeShop, super = Class(Shop)

function BadgeShop:init()
    super.init(self)

    self.shop_music = "shop1" -- Placeholder for now

    self.shopkeeper:setActor("badgeseller")
    self.voice = "hat_badge"

    self.background = "ui/shop/bg_seam"
    
end

return BadgeShop