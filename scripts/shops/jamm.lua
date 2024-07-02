local JammShop, super = Class(Shop,  "jamm")

function JammShop:init()
    super.init(self)

    self.encounter_text = "* So, what'll it be?\n* Anything interesting you here?"
    self.shop_text = "* Anything else interest you?"
    self.leaving_text = "* Alright, guess I can lock up for now."
    -- Shown when you're in the BUY menu
    self.buy_menu_text = "Something catch your eye?"
    -- Shown when you're about to buy something.
    self.buy_confirmation_text = "That'll be\n%s ."
    -- Shown when you refuse to buy something
    self.buy_refuse_text = "Alright then."
    -- Shown when you buy something
    self.buy_text = "Appreciate it!"
    -- Shown when you buy something and it goes in your storage
    self.buy_storage_text = "I'll bag it\nup for you."
    -- Shown when you don't have enough money to buy something
    self.buy_too_expensive_text = "Sorry, no way."
    -- Shown when you don't have enough space to buy something.
    self.buy_no_space_text = "You can't hold this right now..."
    -- Shown when something doesn't have a sell price
    self.sell_no_price_text = "I can't buy that..."
    -- Shown when you're in the SELL menu
    self.sell_menu_text = "Sure, what'cha got?"
    -- Shown when you try to sell an empty spot
    self.sell_nothing_text = "There's nothing there."
    -- Shown when you're about to sell something.
    self.sell_confirmation_text = "Probably\nworth about\n%s ."
    -- Shown when you refuse to sell something
    self.sell_refuse_text = "That's fine, really."
    -- Shown when you sell something
    self.sell_text = "A deal's a deal, then."
    -- Shown when you have nothing in a storage
    self.sell_no_storage_text = "We have nothing in there."
    -- Shown when you enter the talk menu.
    self.talk_text = "What'cha want to talk about?"

    self.sell_options_text["items"]   = "So what'cha got?"
    self.sell_options_text["weapons"] = "A weapon? Okay, sure."
    self.sell_options_text["armors"]  = "An armor? Sure, why not?"
    self.sell_options_text["storage"] = "Yeah, let's clear up some space."

    self:registerItem("darkburger")
    self:registerItem("shellnut")
    self:registerItem("hotdog")
    self:registerItem("chickenteriyaki")

    self:registerTalk("Shop")
    self:registerTalk("Money")
    self:registerTalk("Slingshot")
    self:registerTalk("Family")
	
    self:registerTalkAfter("Shop (NEW)", 1)

    self.shopkeeper:setActor("shopkeepers/jamm")
    self.shopkeeper.sprite:setPosition(0, 46)
    self.shopkeeper.slide = true

    self.voice = "jamm"

    self.background = "ui/shop/jamm"
    self.shop_music = "shop_jamm"
end

function JammShop:startTalk(talk)
    if talk == "Shop" then
        self:startDialogue({
            "* How'd I get my shop?[wait:10] Did I hear you right?",
            "* See,[wait:5] this shop is my inheritance from my grandfather.",
            "* Back when I was a kid,[wait:5] my grandpa died,[wait:5] and,[wait:5] well,[wait:5] he gave me this building.",
            "* If I remember correctly,[wait:5] back then,[wait:5] it was a weapons store,[wait:5] but...",
            "* With how many different kinds of weapons there are,[wait:5] it's hard to appease everyone,[wait:5] you know?",
            "* Anyways,[wait:5] I set up this store and Ania even helped with it.",
            "* Marcy comes here after school,[wait:5] and we've been working this place together.",
        })
    elseif talk == "Shop (NEW)" then
        self:startDialogue({
            "* Y'know,[wait:5] this is where I got my first slingshot.",
            "* Back when I was a child, my grandfather had brought me here for the first time.",
            "* After helping out around the shop,[wait:5] he asked me if I would like anything here.",
            "* Grandfather asked me to take any one weapon I wanted, and I chose a dusty slingshot.",
            "* .[wait:2].[wait:2][wait:2].[wait:2]I was 5 at the time.[wait:10]\n* Yeah,[wait:5] he was very irresponsible.",
        })
    elseif talk == "Money" then
        self:startDialogue({
            "* So,[wait:5] you want to know where this money goes?",
            "* Well,[wait:5] some of it goes into my personal fund,[wait:5] so none of our joint earnings.",
            "* The rest of it,[wait:5] believe it or not,[wait:5] I donate to charity.",
            "* The charity I donate to is called \"Paws of the Dark,\"[wait:5] which uses the money to care for abandoned pets in the dark world.",
            "* I'd adopt one myself,[wait:5] but I don't think Marcy is ready for the responsibility.",
            "* Plus,[wait:5] imagine how bad the hotel room would smell.",
        })
    elseif talk == "Slingshot" then
        self:startDialogue({
            "* You're wondering why my weapon is a slingshot,[wait:5] huh...?",
            "* Well,[wait:5] I don't really thing there's an easy answer to that,[wait:5] but I guess I can give it a shot.",
            "* Well,[wait:5] first of all...[wait:10]\n* I'm not really the biggest fan of melee weapons.",
            "* At least with a slingshot,[wait:5] I can dodge attacks easier and from afar,[wait:5] right?",
            "* Bows are kinda tricky to use,[wait:5] as they can get pretty unstable in my hands.",
            "* Guns...[wait:10] No.[wait:10]\n* I have sensitive ears,[wait:5] you know?[wait:10] And guns are loud.",
            "* I could grab a rock from the ground,[wait:5] but I'm not the best thrower.",
            "* So...[wait:10] Slingshot,[wait:5] I guess.",
            "* .[wait:2].[wait:2].[wait:2].[wait:2].[wait:2].[wait:2].[wait:2].[wait:2]Look,[wait:5] if you have a better idea of a weapon I should use,[wait:5] I'd like to hear it.",
        })
    elseif talk == "Family" then
        self:startDialogue({
            "* .[wait:2].[wait:2].[wait:2]My family?[wait:10] You already know about Ania and Marcy.",
            "* I mean,[wait:5] I guess that's not all though,[wait:5] is there?[wait:10] Hmm...",
            "* I have a brother,[wait:5] who I rarely get to see.",
            "* My brother is part of a police force;[wait:10] it's fair that I'd worry about him sometimes,[wait:5] right?",
            "* He visits sometimes,[wait:5] but he can't exactly use his phone that often.",
            "* Then there's my sister,[wait:5] who's really annoying.",
            "* Oh,[wait:5] please;[wait:10] if you thought Dess was annoying,[wait:5] you haven't seen my sister.",
            "* But...[wait:10] Lately, she's been a lot less annoying.[wait:10] I guess it's thanks to her son.",
            "* Everyone else is either dead,[wait:5] I don't remember them,[wait:5] or currently in prison for war crimes.",
            "* .[wait:2].[wait:2].[wait:2]What?",
        })
    end
end

return JammShop