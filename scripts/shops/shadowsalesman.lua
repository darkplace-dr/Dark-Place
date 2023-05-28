local ShadowShop, super = Class(Shop, "shadowsalesman")

function ShadowShop:init()
    super.init(self)

    self.encounter_text = "[voice:shadowsalesman][emote:idle]* Welcome to the Dev Diner...[wait:5]\n* How can I help ya?"
    self.shop_text = "[voice:shadowsalesman][emote:idle]* C'mon kid,[wait:5] I don't have all day, y'know..."
    self.leaving_text = "[voice:shadowsalesman][emote:idle]* Feel free to come back, if ya want..."
    -- Shown when you're in the BUY menu
    self.buy_menu_text = "[voice:shadowsalesman][emote:eyebrow_raise]What'll it be?"
    -- Shown when you're about to buy something.
    self.buy_confirmation_text = "That'll be\n%s ..."
    -- Shown when you refuse to buy something
    self.buy_refuse_text = "[voice:shadowsalesman][emote:annoyed]Then why'd ya ask for it, ya schmuck?!"
    -- Shown when you buy something
    self.buy_text = "[voice:shadowsalesman]Much obliged, kiddo."
    -- Shown when you buy something and it goes in your storage
    self.buy_storage_text = "[voice:shadowsalesman]Much obliged, kiddo."
    -- Shown when you don't have enough money to buy something
    self.buy_too_expensive_text = "[voice:shadowsalesman][emote:annoyed]What do I look like, a bank?"
    -- Shown when you don't have enough space to buy something.
    self.buy_no_space_text = "[voice:shadowsalesman][emote:idle]"
    -- Shown when something doesn't have a sell price
    self.sell_no_price_text = "[voice:shadowsalesman][emote:idle]"
    -- Shown when you're in the SELL menu
    self.sell_menu_text = "[voice:shadowsalesman][emote:idle]Sure, you can sell me your crap."
    -- Shown when you try to sell an empty spot
    self.sell_nothing_text = "[voice:shadowsalesman][emote:idle]I don't have time for magic acts, kid."
    -- Shown when you're about to sell something.
    self.sell_confirmation_text = "[emote:idle]I'll take that\noffa ya for \n%s ."
    -- Shown when you refuse to sell something
    self.sell_refuse_text = "[voice:shadowsalesman][emote:annoyed]I don't want whatever the hell that is."
    -- Shown when you sell something
    self.sell_text = "[voice:shadowsalesman][emote:idle]Thanks...\nI guess."
    -- Shown when you have nothing in a storage
    self.sell_no_storage_text = "[voice:shadowsalesman][emote:idle]."
    -- Shown when you enter the talk menu.
    self.talk_text = "[voice:shadowsalesman][emote:idle]Got nothin' better to do anyways..."

    self.sell_options_text["items"]   = "Sure, you can sell me your crap."
    self.sell_options_text["weapons"] = "Sure, you can sell me your crap."
    self.sell_options_text["armors"]  = "Sure, you can sell me your crap."
    self.sell_options_text["storage"] = "Sure, you can sell me your crap."

	-- Base Items
    self:registerItem("pizza_toque", {stock = 1, color = {1, 1, 1, 1}})
    self:registerItem("everybodyweapon", {description = "WEAPON\nA weapon for\neveryone."})
    self:registerItem("favwich")
    self:registerItem("gigasalad")

	
	-- MistCard Items
	if Game.inventory:hasItem("mistcard") then
		self:registerItem("program_socks")
		self:registerItem("riot_shield")
		self:registerItem("lightaxe")
		self:registerItem("demonscarf")
	end
	
	-- DorsalCard Items
	if Game.inventory:hasItem("dorsalcard") then
		self:registerItem("widecannon")
		self:registerItem("excalibat")
		self:registerItem("caledfwlch")
		self:registerItem("special_snack")
	end
	

    self:registerTalk("What Is This Place?")
    self:registerTalk("Cards")
    self:registerTalk("Party Members")
    self:registerTalk("Other Universes")

    self.shopkeeper:setActor("shadowsalesman_shop")
    self.shopkeeper.sprite:setPosition(0, 15)
    self.shopkeeper.slide = true

    self.background = "ui/shop/devdiner_bg"
    self.shop_music = "none"
end

function ShadowShop:startTalk(talk)
    if talk == "What Is This Place?" then
		self:startDialogue({
			"[voice:shadowsalesman]* This is the Dev Diner, kid.[wait:5]\n* It's a place where [color:yellow]DEVS[color:reset] can eat, drink, or just lounge around...",
			"[voice:shadowsalesman]* I set up shop here in this dimension, so the [color:yellow]DEVS[color:reset] of this mod could have a place to stay.",
			"[voice:shadowsalesman][emote:happy]* Thought it'd be a nice thing to do for all the folks that brought this world to life,[wait:5] y'know?",
			"[voice:shadowsalesman][emote:annoyed]* Speaking of which,[wait:5] are ya here to buy somethin', or are ya just gonna stand there and keep yakkin' away at me?",
			"[voice:shadowsalesman][emote:annoyed]* I ain't some sorta art museum exhibit,[wait:5] bub.",
		})
    elseif talk == "Cards" then
		if Game.inventory:hasItem("mistcard") and not Game:getFlag("talkedAboutMistCard") then
			self:startDialogue({
				"[voice:shadowsalesman]* [emote:eyebrow_raise]Alright,[wait:10] where the heck did you get that?[wait:10]\n* Did'jya steal it while I wasn't looking?",
				"[voice:shadowsalesman]* ...",
				"[voice:shadowsalesman][emote:idle]* Oh,[wait:5] you got it from him,[wait:5] didn't you?",
				"[voice:shadowsalesman]* I feel kinda bad about it honestly.",
				"[voice:shadowsalesman]* [emote:annoyed]...",
				"[voice:shadowsalesman]* [emote:eyebrow_raise]Actually,[wait:5] nevermind,[wait:5] I don't feel bad at all.",
				"[voice:shadowsalesman][emote:idle]* I think I speak for everyone when I say everyone hates [color:red]HER[color:reset].",
			})
			Game:setFlag("talkedAboutMistCard")
		else
			self:startDialogue({
				"[voice:shadowsalesman]* Yep,[wait:10] cards are sort of a system put in-place for 'special' customers.",
				"[voice:shadowsalesman]* And by that I mean I give em' out to folks I know or folks I like.",
				"[voice:shadowsalesman][emote:annoyed]* No,[wait:5] I don't know you.[wait:10][emote:eyebrow_raise]\n* And I sure as heck don't like you.",
				"[voice:shadowsalesman][emote:idle]* Point is,[wait:5] these cards grant you special access to more expensive parts of our inventory.[wait:10]\n* That's about all you need to know.",
			})
		end
    elseif talk == "Party Members" then
        self:startDialogue({
            "[voice:shadowsalesman][emote:idle]* If you're lookin' for the party members, they have their own area down the hall.",
            "[voice:shadowsalesman][emote:eyebrow_raise]* Why is this the case?[wait:5]\n[emote:idle]* Well, to put it lightly...",
            "[voice:shadowsalesman]* When a certain [color:red]deer in red clothing[color:reset] visited the diner one day, and consumed our entire supply of soda,[wait:5][emote:eyebrow_raise] you wanna know what she did afterwards?",
            "[voice:shadowsalesman][emote:annoyed]* She took out her baseball bat, and started swingin' it all over the place.",
            "[voice:shadowsalesman][emote:annoyed]* Breakin' all the pottery,[wait:5] and SMASHIN' all the windows...",
            "[voice:shadowsalesman][emote:pissed][shake:1]* [color:red]AND THEN SHE PROCEEDS TO DESECRATE THIS DINER'S VERY EXISTENCE,[wait:5] AND-[color:reset]",
            "[voice:shadowsalesman][emote:oops]* ...",
            "[voice:shadowsalesman][emote:idle]* Er...[wait:5]Sorry.\n* Guess I got a bit carried away there.",
            "[voice:shadowsalesman][emote:annoyed]* But long story short,[wait:5] [color:red]SHE[color:reset] is the exact reason why we had to give the party members their own room to hangout in.",
            "[voice:shadowsalesman][emote:idle]* (Well,[wait:5] save for a couple exceptions, of course.)",
        })
    elseif talk == "Other Universes" then
        self:startDialogue({
            "[voice:shadowsalesman]* Yeah,[wait:5] I've seen PLENTY of universes, kid.",
            "[voice:shadowsalesman]* In fact,[wait:5] We [color:yellow]DEVS[color:reset] know a lot more about the multiverse than your tiny lil' pea-brain can handle.",
            "[voice:shadowsalesman][emote:eyebrow_raise]* Example?\n[wait:10][emote:annoyed]* I'll give ya [color:yellow]FIVE[color:reset] examples, Einstein.",
            "[voice:shadowsalesman][emote:idle]* First, there's a universe where every character's role is swapped.[wait:5]\n* Like the clown and the salesman takin' each other's place, to name a couple.",
            "[voice:shadowsalesman][emote:eyebrow_raise]* Next,[wait:5] there's a universe where a pizzeria owner has to prevent a giant floatin' pizza from destroying his restaurant...",
            "[voice:shadowsalesman][emote:annoyed]* ...by destroying a 5-story tower that the pizza built.",
            "[voice:shadowsalesman][emote:eyebrow_raise]* And if ya think THAT'S weird, wait till ya what these next three have in store!",
        })
    end
end

return ShadowShop