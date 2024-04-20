local ShadowShop, super = Class(Shop, "shadowsalesman")

function ShadowShop:init()
    super.init(self)

    self.encounter_text = "[emote:idle]* Welcome to the Dev Diner...[wait:5]\n* How can I help ya?"
    self.shop_text = "[emote:idle]* C'mon kid,[wait:5] I don't have all day, y'know..."
    self.leaving_text = "[emote:idle]* Feel free to come back, if ya want..."
    -- Shown when you're in the BUY menu
    self.buy_menu_text = "[emote:eyebrow_raise]What'll it be?"
    -- Shown when you're about to buy something.
    self.buy_confirmation_text = "That'll be\n%s ..."
    -- Shown when you refuse to buy something
    self.buy_refuse_text = "[emote:annoyed]Then why'd ya ask for it, ya schmuck?!"
    -- Shown when you buy something
    self.buy_text = "Much obliged, kiddo."
    -- Shown when you buy something and it goes in your storage
    self.buy_storage_text = "Much obliged, kiddo."
    -- Shown when you don't have enough money to buy something
    self.buy_too_expensive_text = "[emote:annoyed]What do I look like, a bank?"
    -- Shown when you don't have enough space to buy something.
    self.buy_no_space_text = "[emote:idle]"
    -- Shown when something doesn't have a sell price
    self.sell_no_price_text = "[emote:idle]"
    -- Shown when you're in the SELL menu
    self.sell_menu_text = "[emote:idle]Sure, you can sell me your crap."
    -- Shown when you try to sell an empty spot
    self.sell_nothing_text = "[emote:annoyed]I don't have time for magic acts, kid."
    -- Shown when you're about to sell something.
    self.sell_confirmation_text = "I'll take that\noffa ya for \n%s ."
    -- Shown when you refuse to sell something
    self.sell_refuse_text = "[emote:annoyed]I don't want whatever the hell that is."
    -- Shown when you sell something
    self.sell_text = "[emote:idle]Much obliged, kiddo."
    -- Shown when you have nothing in a storage
    self.sell_no_storage_text = "[emote:annoyed]I don't have time for magic acts, kid."
    -- Shown when you enter the talk menu.
    self.talk_text = "[emote:idle]Got nothin' better to do anyways..."

    self.sell_options_text["items"]   = "Sure, you can sell me your crap."
    self.sell_options_text["weapons"] = "Sure, you can sell me your crap."
    self.sell_options_text["armors"]  = "Sure, you can sell me your crap."
    self.sell_options_text["storage"] = "Sure, you can sell me your crap."

	-- Base Items
    self:registerItem("everybodyweapon", {description = "WEAPON\nA weapon for\neveryone."})
    self:registerItem("favwich")
    self:registerItem("synthsoda")
    self:registerItem("synthsoda") -- placeholder for now. gonna replace with a new healing item at some point

	
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
	

    self:registerTalk("Who are you?")
    self:registerTalk("Cards")
    self:registerTalk("Party Members")
    self:registerTalk("Other Universes")
	
    self:registerTalkAfter("The Diner", 1)
    self:registerTalkAfter("What Place?", 4)

    self.shopkeeper:setActor("shadowsalesman_shop")
    self.shopkeeper.sprite:setPosition(0, 15)
    self.shopkeeper.slide = true

    self.voice = "shadowsalesman"

    self.background = "ui/shop/devdiner_bg"
    self.shop_music = nil
	
    if self:getFlag("vhs_obtain", 0) == 0 then
        self.vapor_vhs = Sprite("ui/shop/devdiner_vhs_item", 514, 180)
        self.vapor_vhs:setScale(2)
        self:addChild(self.vapor_vhs)
	end
end

function ShadowShop:startTalk(talk)
    if talk == "Who are you?" then
		self:startDialogue({
			"[emote:eyebrow_raise]* You wanna know about me, eh?",
			"[emote:annoyed]* (Tsk,[wait:5] typical shopkeeper question...)",
			"[emote:idle]* Well to be morally honest with you,[wait:5] I ain't really anybody that important...",
			"* I'm known as the Shadow Salesman, kid. [wait:10]However, the folks here call me \"[color:yellow]JARU[color:reset]\".",
			"[emote:annoyed]* And before you ask, no.[wait:5] I ain't THAT Jaru.",
			"* I mean,[wait:5][emote:eyebrow_raise] come on.[wait:10]\n* Do I look like the kinda guy that would yammer on and on about piles of dust on cliffs or some jerk named \"Oberon Smog\"?",
			"[emote:annoyed]* Yeah,[wait:5] didn't think so, bub.",
		})
    elseif talk == "The Diner" then
		self:startDialogue({
			"* You're in the Dev Diner, kid.[wait:5]\n* It's a place where [color:yellow]DEVS[color:reset] can eat, drink, or just lounge around.[wait:10]\n* It also doubles as a hotel of sorts.",
			"* I set this whole place up here mainly so all my pals could have a place to stay.",
			"[emote:happy]* Thought I'd do somethin' nice for all the folks that brought this world to life,[wait:5] y'know?",
			"[emote:annoyed]* Anyways,[wait:5] are ya gonna buy something or are ya gonna continue starin' at me with that deadpan look of yours?",
			"[emote:annoyed]* I ain't some sorta art museum exhibit,[wait:5] buster.",
		})
    elseif talk == "Cards" then
		if Game.inventory:hasItem("mistcard") and not Game:getFlag("talkedAboutMistCard") then
			self:startDialogue({
				"* [emote:eyebrow_raise]Alright,[wait:10] where the hell did you get that?[wait:10]\n* Did'jya steal it while I wasn't looking?",
				"* ...",
				"[emote:idle]* Oh,[wait:5] you got it from him,[wait:5] didn't you?",
				"* I feel kinda bad about it honestly.",
				"* [emote:annoyed]...",
				"* [emote:eyebrow_raise]Actually,[wait:5] nevermind,[wait:5] I don't feel bad at all.",
				"[emote:idle]* I think I speak for everyone when I say everyone hates [color:red]HER[color:reset].",
			})
			Game:setFlag("talkedAboutMistCard", true)
		else
			self:startDialogue({
				"* Yep,[wait:10] cards are sort of a system put in-place for 'special' customers.",
				"* And by that I mean I give em' out to folks I know or folks I like.",
				"[emote:annoyed]* No,[wait:5] I don't know ya.[wait:10][emote:eyebrow_raise]\n* And I sure as heck don't like ya.",
				"[emote:idle]* Point is,[wait:5] these cards grant you special access to more expensive parts of our inventory.[wait:10]\n* That's about all you need to know.",
			})
		end
    elseif talk == "Party Members" then
        self:startDialogue({
            "[emote:idle]* If you're lookin' for the party members, they have their own area down the hall.",
            "[emote:eyebrow_raise]* Why is this the case?[wait:5]\n[emote:idle]* Well, to put it lightly...",
            "* When a certain [color:red]deer in red clothing[color:reset] visited the diner one day, and consumed our entire supply of soda,[wait:5][emote:eyebrow_raise] you wanna know what she did afterwards?",
            "[emote:annoyed]* She took out her baseball bat, and started swingin' it all over the place.",
            "[emote:annoyed]* Breakin' all the pottery,[wait:5] and SMASHIN' all the windows...",
            "[emote:pissed][shake:1]* [color:red]AND THEN SHE PROCEEDS TO DESECRATE THIS DINER'S VERY EXISTENCE,[wait:5] AND-[color:reset]",
            "[emote:oops]* ...",
            "[emote:idle]* Er...[wait:5]Sorry.\n* Guess I got a bit carried away there.",
            "[emote:annoyed]* But long story short,[wait:5] [color:red]SHE[color:reset] is the exact reason why we had to give the party members their own room to hangout in.",
            "[emote:idle]* (Well,[wait:5] save for a couple exceptions, of course.)",
        })
    elseif talk == "Other Universes" then
        self:startDialogue({
            "* Yeah,[wait:5] I've seen PLENTY of universes, kid.",
            "* In fact,[wait:5] We [color:yellow]DEVS[color:reset] know a lot more about the multiverse than your tiny lil' pea-brain can handle.",
            "[emote:eyebrow_raise]* Example?\n[wait:10][emote:annoyed]* I'll give ya [color:yellow]THREE[color:reset] examples, Einstein.",
            "[emote:idle]* First, there's a universe where every character's role is swapped.[wait:5]\n* Like the clown and the salesman takin' each other's place, to name a couple.",
            "[emote:eyebrow_raise]* Next,[wait:5] there's a universe where a pizzeria owner has to prevent a giant floatin' pizza from destroying his restaurant...",
            "[emote:annoyed]* ...by destroying a 5-story tower that the pizza built.",
            "[emote:eyebrow_raise]* And if ya think THAT'S weird,[wait:5] there's this one world that I frequently visit that-",
            "[emote:idle]* ...",
            "* Actually,[wait:5] y'know what?[wait:10]\n[emote:annoyed]* You don't need to know about that place.",
            "[emote:idle]* Besides,[wait:10] the only people that can only know about that dimension are me,[wait:5] myself[wait:5], and I."
        })
    elseif talk == "What Place?" then
        if self:getFlag("vhs_obtain", 0) == 0 then
            self:startDialogue({
                -- dialogue is kinda shit, but I'll try to retweak it in the future.
                "[emote:annoyed]* Kid,[wait:5] I already told ya I ain't tellin' a damn soul about it.",
                "* Besides,[wait:5] I doubt someone of YOUR standards could even handle the dangers of-",
                "[emote:idle]* ...",
                "[emote:eyebrow_raise]* Hmmm...",
                "[emote:idle]* Alright fine, buster.[wait:10] You wanna learn about that place so badly?",
                "[emote:annoyed]* Then you can have the damn key to it!",
                "[emote:eyebrow_raise]* Don't be fooled by its blocky appearance.[wait:10][emote:idle] Just pop this bad boy into a VCR somewhere, and you're off!",
                "[sound:shadowsalesman_laugh][emote:happy][wait:50][noskip]* Who knows?[wait:10] Maybe you'll find somethin' interestin' there.",
            })
        else
            self:startDialogue({
                "[emote:annoyed]* Well?[wait:5] Are ya goin' or what, kid?",
            })
        end
        self:setFlag("vhs_obtain", self:getFlag("vhs_obtain", 0)+1)
    end
end

function ShadowShop:onStateChange(old, new)
    super.onStateChange(self, old, new)
    if old == "DIALOGUE" and new == "TALKMENU" then
        if self:getFlag("vhs_obtain") == 1 then
            Game:setFlag("vaporland_sidestory", 1)
            Assets.playSound("item")
            Assets.playSound("creepyjingle")
            Game.inventory:tryGiveItem("retrotape")
            Game.inventory:tryGiveItem("walkie_talkie")
            self.vapor_vhs:remove()
            Kristal.callEvent("createQuest", "Aesthetic Adventure", "vap", "After pestering the Shadow Salesman enough times, he gives you a bizarre-looking artifact from the glorious 80's. Apparently, he says that putting that thing into a VCR somewhere will unlock a gateway to another strange world...but where is the question? Time to go investigate!")
        end
    end
end

return ShadowShop
