local Saloon, super = Class(LightShop,  "saloon")

function Saloon:init()
    super.init(self)

    self.shop_music = nil
    self.encounter_text = "* Howdy howdy!\nTake a gander at my\nwares."
    self.shop_text = "* Howdy howdy!\nTake a gander at my\nwares."
    self.leaving_text = "* Have fun out there!"
    -- Shown when you're in the BUY menu
    self.buy_menu_text = "Here's the\nmenu!"
    -- Shown when you're about to buy something.
    self.buy_confirmation_text = "Buy it for\n%s ?"
    -- Shown when you refuse to buy something
    self.buy_refuse_text = "Not\ninterested,\nI take it."
    -- Shown when you buy something
    self.buy_text = "There\nwe go."
    -- Shown when you buy something and it goes in your storage
    self.buy_storage_text = "Much\nappreciated!"
    -- Shown when you don't have enough money to buy something
    self.buy_too_expensive_text = "Your funds'r\ninsufficient"
    -- Shown when you don't have enough space to buy something.
    self.buy_no_space_text = "Quit carryin'\nso much."
    -- Shown when you're about to sell something.
    self.sell_confirmation_text = "Sell %s for %s ?"
    -- Shown when you have nothing in a storage
    self.sell_no_storage_text = "* Nothing in there."
    -- Shown when you enter the talk menu.
    self.talk_text = "What do ya\nwanna know?"
    -- If has a string/table of strings, it will prevent selling and will start a dialogue
    if Game:getFlag("saloon_triedtosell") == true then
        self.sell_no_selling_text = "* I already told ya to ask\nBlackjack about sellin'."
    else
        self.sell_no_selling_text = {"* This is a bar, not a marketplace.", "* Try Blackjack down the road\nif you wanna barter."}
    end

    self:registerItem("uty_items/icewater", {description = "Heals 15HP"})
    self:registerItem("uty_items/adult_soda", {description = "Heals ???\nYou seem\nold enough."})
	self:registerItem("uty_items/root_beer", {description = "Heals 18HP\nIt's family\nfriendly!"})
    self:registerItem("uty_items/feisty_slider", {description = "Heals 30HP\nA lil'\nbaby burger!"})

    self:registerTalk("This place")
    self:registerTalk("Your snakes")
    self:registerTalk("Fox monster")
    self:registerTalk("Warp bin")

    self.shopkeeper:setActor("dina_shop")
    --self.shopkeeper.sprite:setPosition(-24, 12)
    --self.shopkeeper.slide = true

    self.background = "ui/shop/wild_east_saloon"
end

function Saloon:startTalk(talk)
    if talk == "This place" then
        self:startDialogue({
            "* Oh this little place?[wait:5] It's\npretty fun 'round here.",
            "* I heard it was established some\nyears back when the Dunes gained\nits name if you get me.",
            "* I should be polished on its\nhistory but Star don't talk\n'bout those days.",
            "* I was lookin' for a friendly\nenvironment to share my brewin'\nskills,[wait:5] so here I am.",
            "* There ain't terribly much to do\nin this town but that only makes\nit more close-knit.",
            "* Every day has been pretty\npredictable until this bin\nshowed up.",
            "* Since then,[wait:5] it's a little\nmore \"alive\" here, if you get\nwhat I mean."
        })
    elseif talk == "Your snakes" then
        self:startDialogue({
            "* Haha,[wait:5] I get this question a\nlot.",
            "* These fellas are my pets.[wait:5] Real\nreptiles, not monsters.",
            "* Their names are Ann,[wait:5] Sammy,[wait:5]\nand Bert.",
            "* The Underground still houses\nsome critters from the Surface\nlike birds and insects.",
            "* I found these west of here,[wait:5]\nhidin' in a crevasse of sorts.",
            "* Some monsters think keepin'\npets is strange but I think it's\ncute.",
            "* They give me someone to talk to\nwhen business is slow."
        })
    elseif talk == "Fox monster" then
        self:startDialogue({
            "* Oh,[wait:5] you mean Ceroba?",
            "* She comes here pretty often.\n[wait:5]Why you may ask?",
            "* Well,[wait:5] she's not been feelin'\npretty great lately.",
            "* Her husband passed away,[wait:5] and from\nwhat I heard recently,[wait:5] her\ndaughter has fallen down.",
            "* And not only that,[wait:5] but she was the one to blame for it.[wait:5] She wanted to do what would be best for everyone,[wait:5] but ended up losing a daughter.",
            "* Poor thing."
        })
        Game:setFlag("know_ceroba_name", true)
    elseif talk == "Warp bin" then
        self:startDialogue({
            "* Oh,[wait:5] THAT thing?",
            "* Well,[wait:5] it kind of just appeared\nhere one day and some random\nfellas started coming from\nthere.",
            "* But after some time they\neventually leave.",
            "* What do I think about it?",
            "* Well,[wait:5] I don't mind more customers.[wait:5] Although,[wait:5] personally I wouldn't\ntry to use it.",
            "* Who knows where it's gonna take you?"
        })
    end
end

return Saloon