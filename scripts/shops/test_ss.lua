local TestShop, super = Class(Shop,  "test")

function TestShop:init()
    super.init(self)

    
    self:registerItem("ultimate_candy")
    self:registerItem("ultimate_candy")
    self:registerItem("ultimate_candy")
    self:registerItem("ultimate_candy")
	
	self.haggle_marks = {
		{90, 0.5},
		{60, 0.75}
	}

    self.background = "ui/shop/bg_seam"
	
	self.deny_text = {}
	
	self.can_haggle = true
	self.bonus_game = true
end

return TestShop