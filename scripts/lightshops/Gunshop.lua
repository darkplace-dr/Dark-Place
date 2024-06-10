local Gunshop, super = Class(LightShop,  "gunshop")

function Gunshop:init()
    super.init(self)

    self.shop_music = "undertale_yellow/gunshop"
    self.encounter_text = "* Greetings!\n* Take a gander! Just\ndon't touch anything."
    self.shop_text = "* Greetings!\n* Take a gander! Just\ndon't touch anything."
    self.leaving_text = "* I wish you good travels!"
    -- Shown when you're in the BUY menu
    self.buy_menu_text = "Interested\nin anything?"
    -- Shown when you're about to buy something.
    self.buy_confirmation_text = "Buy it for\n%s ?"
    -- Shown when you refuse to buy something
    self.buy_refuse_text = "Change your\nmind?"
    -- Shown when you buy something
    self.buy_text = "I thank\nyou!"
    -- Shown when you buy something and it goes in your storage
    self.buy_storage_text = "I thank\nyou!"
    -- Shown when you don't have enough money to buy something
    self.buy_too_expensive_text = "I need\nthe proper\nsum."
    -- Shown when you don't have enough space to buy something.
    self.buy_no_space_text = "You have\nyour hands\nfull."
    -- Shown when you're about to sell something.
    self.sell_confirmation_text = "Sell %s for %s ?"
    -- Shown when you have nothing in a storage
    self.sell_no_storage_text = "* Nothing in there."
    -- Shown when you enter the talk menu.
    self.talk_text = "Ask away!"

    self:registerItem("uty_items/gunpowder", {stock = 1, description = "Heals ???\nIt may be\nedible."})
	self:registerItem("uty_items/fancy_holster", {description = "Armor: 8DF\nMade from\nleather!", dont_show_change = true})

    self:registerTalk("Why So Few Items?")
    self:registerTalk("Your Wares")
    self:registerTalk("Visitors")
    self:registerTalk("History")

    self.shopkeeper:setActor("blackjack")
    self.shopkeeper.sprite:setPosition(0, 240)
    --self.shopkeeper.slide = true

    self.background = "ui/shop/wild_east_gunshop"

    self.leave_options = {map = "dunes/38", marker = "gunshop", facing = "down"}
end

function Gunshop:startTalk(talk)
    if talk == "Why So Few Items?" then
        self:startDialogue({
            "* Ah, yes, about this.",
            "* You see, with monsters moving to\nthe surface, there's been fewer\nand fewer visitors here.",
            "* I'm currently selling the rest of\nthe stuff I have left.",
            "* When it runs out, I'm gonna move\nmy shop to the surface, like\nmany other shopkeepers did.",
            "* So I would really appreciate it\nif you would purchase something\nfrom my catalogue.",
            "* I know there isn't much, but maybe\nthis will come in handy for you."
        })
    elseif talk == "Your Wares" then
        self:startDialogue({
            "* Ah yes, my gallery of babies!",
            "* Uh... That sounded strange...\nAhem!",
            "* These beauties are all crafted\nfrom the highest quality\nmaterials!",
            "* I forge them myself in my\npersonal gunsmithing room!",
            "* Not only do I make them with\ncare, but I also care FOR them.",
            "* I start my mornings by\npolishing the whole stock until\nI see my reflection in them!",
            "* I also know how to handle these\nbad boys. I'm a way better shot\nthan North Star, that's for\nsure.",
            --"* I... I saw a bandit in my\nrafters."
        })
    elseif talk == "Visitors" then
        self:startDialogue({
            "* The Wild East was getting many\nvisitors back in the day.",
            "* There's something about the\naura here that some monsters\ncouldn't get enough of.",
            "* Now, don't worry. I'm not\nselling ultra-deadly weapons to\nany passerby with enough G.",
            "* I make sure my wares are tame\nenough to not be lethal. I\nmyself am not one for violence!",
            "* Well... used enough times\nconsecutively, they COULD be\nlethal. But then again, a ballet\nshoe could also be lethal used\nenough times.",
            "* Look, don't question my\nmorality too much! I am not\nprepared to speak about it!"
        })
    elseif talk == "History" then
        self:startDialogue({
            "* I heard about this town some\nyears back.",
            "* I had mastered my smithing\ncapabilities and was looking to\nopen up shop.",
            "* As it turns out, there was an\nempty building here so I thought\n\"why not?\" Seemed like quite the\nperfect town for such a shop.",
            "* Do I regret settling down here,\nresulting in endless torment\nfrom five demonic youngsters?\nEvery day.",
            "* But everyone else I've met is\nquite pleasant, so it balances\nout."
        })
    end
end

return Gunshop