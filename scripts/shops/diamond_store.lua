local Diamond_Store, super = Class(Shop)

function Diamond_Store:init()
  super.init(self)
  
  self.shop_music = "shop1"
  
  self.shopkeeper:setActor("diamond_giant_shop")
  self.shopkeeper.talk_sprite = true
  self.shopkeeper.slide = true
  self.background = "ui/shop/bg_seam"
  
  self.encounter_text = "* What'a ya buyin?"
  self.encounter_text = "* Welcome."
  self.encounter_text = "* Wassup."
  self.encounter_text = "* Well are you shop?"
  self.encounter_text = "* Wheeeeeee!"
  self.encounter_text = "* Whippiee!"
  self.encounter_text = "* Whippiee!"
  self.shop_text = "* Take your time."
  self.leaving_text = "* Adios"
  self.leaving_text = "* Bye Bye!"
  self.leaving_text = "* Merry Christmas!!!"
  self.shop_text = "* I'm getting somewhat hungry."
  self.shop_text = "* Religion amirite?"
  self.shop_text = "* I have all day."
  self.buy_menu_text = "* Picking?"
  self.buy_menu_text = "* Look around!"
  self.buy_menu_text = "* Raid the shop."
  self.buy_menu_text = "go apeshit"
  self.buy_confirmation_text = "* This?"
  self.buy_confirmation_text = "* That?"
  self.buy_confirmation_text = "* Want?"
  self.buy_refuse_text = "* Well alrighty then."
  self.buy_text = "* SOLD!"
  self.buy_storage_text = "* Empty your pockets for once."
  self.buy_too_expensive_text = "* I sadly can't give it away."
  self.buy_too_expensive_text = "* I sadly can't give it away."
  self.buy_no_space_text = "* You don't have any room!"
  self.sell_menu_text = "* Show me what you got."
  self.sell_menu_text = "* I am ready to spend."
  self.sell_no_price_text = "* That... Has.. no, PRICE?"
  self.sell_no_price_text = "* I don't know the value of that..."
  self.sell_no_price_text = "* How did you get this???"
  self.sell_nothing_text = "* How do I obtain that???"
  self.sell_nothing_text = "* There is nothing there."
  self.sell_nothing_text = "* Is that a PLACBO?."
  self.sell_confirmation_text = "* %s Dark Dollars."
  self.sell_confirmation_text = "* %s Rupees."
  self.sell_confirmation_text = "* %s Coins."
  self.sell_confirmation_text = "* %s coupons."
  self.sell_confirmation_text = "* %s"
  self.sell_refuse_text = "* Nuh uh."
  self.sell_refuse_text = "* Can't."
  self.sell_refuse_text = "* Impossible."
  self.sell_text = "* I might consume this in the future."
  self.sell_no_storage_text = "* I can't put this anywhere."
  self.sell_no_storage_text = "* Where could I put that?"
  self.sell_no_storage_text = "* Empty your storage first."
  self.talk_text = "* I am a big person."
  self.talk_text = "* You are a little people."
  self.talk_text = "* I hate people."
  self.talk_text = "* Why are you here?"
  self.talk_text = "* Why are you a people?"
  self.talk_text = "* Do you do crime?"
  self.talk_text = "* I hate super mario."
  self.talk_text = "* This is a story."
  self.talk_text = "* I am full of SQUAG."
  self.talk_text = "* You make me look like pain."
--                                 THIS IS NOT A TYPO AND I MEAN IT!!!
  self.talk_text = "* My crown is too epicness."

  self:registerItem("tension_storage", {stock = 1})
  --self:registerItem("berry")
  --self:registerItem("suitofarmor")
  --self:registerItem("springwater")
  
  self:registerTalk("Yourself")
  self:registerTalk("...")
  self:registerTalk("...")
  self:registerTalk("...")
    
end

function Diamond_Store:startTalk(talk)
	if talk == "Yourself" then
        self:startDialogue({
            "* ...",
            "* ...",
            "* ...",
            "* Ok I got it.",
            "* *cough*.",
            "* So, you're probably wondering how I got here.",
            "* ...",
            "* I don't actually know.",
            "* All I do know is that I do not fit in the warp bin.",
        })
	elseif talk == "..." then
        self:startDialogue({
            "* ...",
        })
	end
end

return Diamond_Store