local PastaShop, super = Class(Shop, "pastashop")

function PastaShop:init()
    super.init(self)

    self.encounter_text = "* Yip Yip!"
    self.shop_text = "* Yip!"
    self.leaving_text = "* Yip! Yip! Yip!"
    -- Shown when you're in the BUY menu
    self.buy_menu_text = "* Yip!"
    -- Shown when you're about to buy something.
    self.buy_confirmation_text = "* Yip?"
    -- Shown when you refuse to buy something
    self.buy_refuse_text = "* Yip!"
    -- Shown when you buy something
    self.buy_text = "* Yip!"
    -- Shown when you buy something and it goes in your storage
    self.buy_storage_text = "* Yip!"
    -- Shown when you don't have enough money to buy something
    self.buy_too_expensive_text = "* Yip..."
    -- Shown when you don't have enough space to buy something.
    self.buy_no_space_text = "* ..."
    -- Shown when something doesn't have a sell price
    self.sell_no_price_text = "* ..."
    -- Shown when you're in the SELL menu
    self.sell_menu_text = "* Yip!"
    -- Shown when you try to sell an empty spot
    self.sell_nothing_text = "* .... Yip?"
    -- Shown when you're about to sell something.
    self.sell_confirmation_text = "* Yip?"
    -- Shown when you refuse to sell something
    self.sell_refuse_text = "* Yip!"
    -- Shown when you sell something
    self.sell_text = "* Yip!"
    -- Shown when you have nothing in a storage
    self.sell_no_storage_text = "* Yip!"
    -- Shown when you enter the talk menu.
    self.talk_text = "* Yip!"


    self:registerItem("calizonia special")
    self:registerItem("chevelour_donut")
    self:registerItem("special_snack")
    self:registerItem("bin_weapon", {bonuses = {defense = math.huge}})

    self:registerTalk("About You")
    self:registerTalk("About Owners")
    self:registerTalk("Pasta or Pizza?")
    self:registerTalk("Rat Invasion?")

    self:registerTalkAfter("About Dog", 1)
    self:registerTalkAfter("About Velvet and Chev", 2)

    --[[self.shopkeeper:setActor("shopkeepers/seam")
    self.shopkeeper.sprite:setPosition(-24, 12)
    self.shopkeeper.slide = true

    self.background = "ui/shop/bg_seam"]]

    self.background = nil
    self.shop_music = "pasta_pack_shop"
end

function PastaShop:startTalk(talk)
    if talk == "About You" then
        self:startDialogue({"* Yip!"})
    elseif talk == "About Owners" then
        if not self:getFlag("About Owners", false) then
            self:setFlag("About Owners", true)
            self:startDialogue({"* Yip!"})
        else
            self:startDialogue({"* Yip! Yip!"})
        end
    elseif talk == "About Owners" then self:startDialogue({"* Two mice!"})
    elseif talk == "Pasta or Pizza?" then self:startDialogue({"* Pasta!"})
    elseif talk == "Rat Invasion?" then self:startDialogue({"* Squeak Squeak!"})
    elseif talk == "About Dog" then self:startDialogue({"* Bork"})
    elseif talk == "About Velvet and Chev" then self:startDialogue({"* Squeak!"})
    end
end

return PastaShop