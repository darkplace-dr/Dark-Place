local Vendy, super = Class(LightShop,  "vendy")

function Vendy:init()
    super.init(self)

    self.shop_music = nil
    self.encounter_text = "* Unauthorized person\ndetected.[wait:5] Go away."
    self.shop_text = "* Unauthorized person\ndetected.[wait:5] Go away."
    self.leaving_text = "* Yes,[wait:5] bye,[wait:5] thanks for nothing."
    -- Shown when you're in the BUY menu
    self.buy_menu_text = "Go away."
    -- Shown when you're about to buy something.
    self.buy_confirmation_text = "Buy it for\n%s ?"
    -- Shown when you refuse to buy something
    self.buy_refuse_text = "Thank you\nfor backing\nout."
    -- Shown when you buy something
    self.buy_text = "Item\ndispensed!"
    -- Shown when you buy something and it goes in your storage
    self.buy_storage_text = "Much\nappreciated!"
    -- Shown when you don't have enough money to buy something
    self.buy_too_expensive_text = "You are\nbroke.[wait:5] lol."
    -- Shown when you don't have enough space to buy something.
    self.buy_no_space_text = "You can't\ncarry any\nmore. Too\nbad."
    -- Shown when you're about to sell something.
    self.sell_confirmation_text = "Sell %s for %s ?"
    -- Shown when you have nothing in a storage
    self.sell_no_storage_text = "* Nothing in there."
    -- Shown when you enter the talk menu.
    self.talk_text = "* Why why\nwhy why-"
    -- If has a string/table of strings, it will prevent selling and will start a dialogue
    self.sell_no_selling_text = {"* Oh yes![wait:5] I will gladly dispense\nyour garbage![wait:5] Hand it over!", "* Please stop."}

    self:registerItem("uty_items/gravity_granola", {description = "Heals 30HP\nThis will\nkill you."})
    self:registerItem("uty_items/dihydrogen_monoxide", {name = "Dihydrogen Monoxide", description = "Heals 20HP\nUnfiltered.\nDirt. Bad."})
	self:registerItem("uty_items/popato_chisps", {description = "Heals 13HP\nTastes like\nplastic."})
    self:registerItem("uty_items/safety_goggles", {description = "Armor: 9DF\nWill blind\nyou.", dont_show_change = true})

    self:registerTalk("Your attitude")
    self:registerTalk("The Steamworks")
    self:registerTalk("Axis")
    self:registerTalk("Snacks")

    self.shopkeeper:setActor("vendy")
    --self.shopkeeper.sprite:setPosition(-24, 12)
    --self.shopkeeper.slide = true

    self.background = "ui/shop/vendy"
end

function Vendy:startTalk(talk)
    if talk == "Your attitude" then
        self:startDialogue({
            "* Code line 327:[wait:5] \"If a customer is\ndetermined 'unauthorized',[wait:5] treat\nthem with utmost disrespect so\nthey will not buy up the\ncompany's snacks.\"",
            "* My disrespectful state was\ninitiated when I scanned your\ndull face.",
            "* Bring a Steamworks employee ID\nnext time to experience\n\"Hospitable Mode.\"",
            "* Until then,[wait:5] you may still\npurchase items,[wait:5] but I will tear\napart your self-esteem while\nyou do so...",
            "* ...",
            "* Loser."
        })
    elseif talk == "The Steamworks" then
        self:startDialogue({
            "* What about it?",
            "* The Steamworks are only the\nfinest in monster science and\nengineering,[wait:5] no big deal or\nanything.",
            "* Structures built from the\ntoughest steel and the greatest\nminds,[wait:5] sure to stand the test\nof several millennia!",
            "* Searching for a more advanced\nfacility would be like searching\nfor the corner of a circle.",
            "* With quality machines such as\nmyself at every turn,[wait:5] lives are\nimproved every day!",
            "* The Steamworks:[wait:5] Tomorrow means\nthe Surface!",
            "* ...I am not a propaganda machine.[wait:5]\nMy creator made sure I specify\nthat."
        })
    elseif talk == "Axis" then
        self:startDialogue({
            "* Searching for \"Axis\" in the\ndatabase...",
            "* Axis -[wait:5] Latest Model:[wait:5] 014,[wait:5] is a\nrobot built to act as a Royal\nGuard.",
            "* Production goal:[wait:5] Create an army\nof Axis guard-bots to protect\nmonsterkind from humanity.",
            "* Production status...[wait:10]\nDiscontinued.",
            "* That is all of the information\nI have on this robot.",
            "* If I were to be helpful,[wait:5] which I\nwill not be,[wait:5] I would tell you to\nask an engineer in the Factory\nWing for more information.",
            "* Where is the Factory Wing?[wait:5]\nI cannot tell you.[wait:5]\nYou are unauthorized. ",
            "* Not that I trust you to find it\non your own since you are,[wait:5]\nin fact,[wait:5] an idiot."
        })
    elseif talk == "Snacks" then
        self:startDialogue({
            "* My snacks are up to the\nHIGHEST Steamworks standards.",
            "* I ensure the employees'\ndesignated meal times are as\nenjoyable as possible.",
            "* Because of my popularity,[wait:5] I often\nrun out of inventory to which\nmy creator restocks every Monday\nat 8:00.",
            "* That reminds me...[wait:10] My last boot\nup -[wait:5] yesterday -[wait:5] was a Sunday.\nDr. R.O. should be stopping by\nany minute now.[wait:5] I simply cannot\nwait.",
            "* But none of that is your\nbusiness,[wait:5] now is it?"
        })
    end
end

return Vendy