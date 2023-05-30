local PastaShop, super = Class(Shop, "pastashop")

function PastaShop:init()
    super.init(self)

    self.encounter_text = "[emote:neutral]* Yip Yip!"
    self.shop_text = "[emote:neutral]* Yip!"
    self.leaving_text = "[emote:wink_blep]* Yip! Yip! Yip!\n * (The dog waves goodbye)"
    -- Shown when you're in the BUY menu
    self.buy_menu_text = "[emote:wink]* Yip!"
    -- Shown when you're about to buy something.
    self.buy_confirmation_text = "* Yip?"
    -- Shown when you refuse to buy something
    self.buy_refuse_text = "[emote:frown]* Yip...?"
    -- Shown when you buy something
    self.buy_text = "[emote:blep]* Yip!"
    -- Shown when you buy something and it goes in your storage
    self.buy_storage_text = "[emote:blep]* Yip!"
    -- Shown when you don't have enough money to buy something
    self.buy_too_expensive_text = "[emote:angy]* Yip..."
    -- Shown when you don't have enough space to buy something.
    self.buy_no_space_text = "[emote:angy_blep]* ..."
    -- Shown when something doesn't have a sell price
    self.sell_no_price_text = "[emote:angy_blep]* ..."
    -- Shown when you're in the SELL menu
    self.sell_menu_text = "[emote:blep]* Yip!"
    -- Shown when you try to sell an empty spot
    self.sell_nothing_text = "*[emote:frown] * .... Yip?"
    -- Shown when you're about to sell something.
    self.sell_confirmation_text = "* Yip?"
    -- Shown when you refuse to sell something
    self.sell_refuse_text = "[emote:frown]* Yip?"
    -- Shown when you sell something
    self.sell_text = "[emote:happy]* Yip!"
    -- Shown when you have nothing in a storage
    self.sell_no_storage_text = "[emote:frown]* ....."
    -- Shown when you enter the talk menu.
    self.talk_text = "[emote:happy]* Yip!"


    self:registerItem("calizonia special")
    self:registerItem("chevelour_donut")
    self:registerItem("farfalle_bowtie", {bonuses = {defense = 2}})
    self:registerItem("corgi_plush")

    self:registerTalk("About You")
    self:registerTalk("About Owners")
    self:registerTalk("Pasta or Pizza?")
    self:registerTalk("Rat Invasion?")

    self:registerTalkAfter("About Dog", 1)
    self:registerTalkAfter("About Velvet and Chev", 2)

    self.shopkeeper:setActor("strawberry_corgi")
    self.shopkeeper.sprite:setPosition(-24, 12)
    self.shopkeeper.slide = true

    self.background = "ui/shop/pasta_shop_bg"

    self.background = "ui/shop/pasta_shop_bg"
    self.shop_music = "pasta_pack_shop"
end

function PastaShop:startTalk(talk)
    if talk == "About You" then
        self:startDialogue({
        "* Yip!",
        "* (It seems that you already know the dog...)",
        "* (Dogs can't talk so no need for an introduction!)",
        "[emote:wink_blep]* Yip yip!"
    })
    elseif talk == "About Owners" then
        if not self:getFlag("About Owners", false) then
            self:setFlag("About Owners", true)
            self:startDialogue({
            "* (The dog pressed a button on a recorder)",
            "[voice:velvet]* This is a prerecorded message...",
            "[voice:velvet]* Hi! I'm Velvet, I own the Pasta Pack...",
            "[voice:chevelour]* And I'm Chevelour! I also own this place!\n  *Squeak*\n* Call me Chev for short!",
            "[voice:chevelour]* We also sell some delicious donuts!\n  *Squeak* *Squeak*",
            "* ...",
            "[voice:velvet]* Anyways I made this place since I wanted to cook food more.\n * Place got big and bam! Tada!",
            "[voice:velvet]* People's pick? The Calizonia!\n * All Italian, Filipino-made, and from California baby!",
            "[voice:chevelour]* Whadya say? Go order some food!",
            "[voice:chevelour]* Don't forget to try our donuts!\n  *Squeak*",
            "* (The recording stopped)",
        })
        end
    elseif talk == "Pasta or Pizza?" then
        self:startDialogue({
            "[emote:frown]* ...",
            "[emote:angy]* ...",
            "[emote:angy_blep]* (The answer is already obvious, given the name of this shop...)"
        })
    elseif talk == "Rat Invasion?" then
        self:startDialogue({
            "* (The dog pressed a button on a recorder)",
            "[voice:velvet]* This is a prerecorded message...",
            "[voice:velvet]* That's... that's a long story\n* But I can give ya a quick summary...",
            "[voice:velvet]* So apparantly a bunch of rats infested my pasta shop\n* Then some big giant rat threatened to destroy my resturant!",
            "[voice:chevelour]* What's kinda funny is that we are mice, and they are rats...\n  *Squeak*",
            "[voice:velvet]* Anyways... I had to climb up the pasta tower. Like an Italian man running to check the stove.",
            "[voice:chevelour]* You should've seen Velvet kick the giant rat's butt!\n  *Squeak* She was amazing!",
            "[voice:velvet]* They're gone for now. Hopefully no more rats want some Calizonia again...",
            "* (The recording stopped)",
        })
    elseif talk == "About Dog" then self:startDialogue({"[emote:happy]* Bork"})
    elseif talk == "About Velvet and Chev" then
        self:startDialogue({
            "[emote:angy]* (Looks like the dog doesn't want to repeat the message...)"
        })
    end
end

return PastaShop