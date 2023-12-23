local DogShop, super = Class(Shop)

function DogShop:init()
  super.init(self)
  
  self.shop_music = "investigation"
  
  
  self.shopkeeper:setActor("badlydrawndog")
  self.shopkeeper.talk_sprite = true
  self.shopkeeper.slide = true
  self.background = "ui/shop/bg_seam"
  
  self.encounter_text = "* Welcome to the poorly drawn dog shop."
  self.shop_text = "* Anything else?"
  self.leaving_text = "* See ya 'round sometime, capiche?"
  self.shop_text = "* Anything else?"
  self.buy_menu_text = "* Whatch'ya want?"
  self.buy_confirmation_text = "* So that's\nwhat you want?\n* %s."
  self.buy_refuse_text = "* Well alrighty then."
  self.buy_text = "* Sounds good to me!"
  self.buy_storage_text = "* I'll send it over to your storage."
  self.buy_too_expensive_text = "* You ain't got the cash."
  self.buy_no_space_text = "* You don't have any room!"
  self.sell_menu_text = "* Let's see what junk you got."
  self.sell_no_price_text = "* ...not that junk."
  self.sell_nothing_text = "* You think I'm stupid or somethin'?"
  self.sell_confirmation_text = "* So I'll\ntake this\nfor %s?"
  self.sell_refuse_text = "* Guess not."
  self.sell_text = "* Pleasure doing business."
  self.sell_no_storage_text = "* You don't got nothin'."
  self.talk_text = "* Let's chew the fat."

  self:registerItem("gamerblood", {stock = 1})
  self:registerItem("berry")
  self:registerItem("suitofarmor")
  self:registerItem("springwater")
  
  self:registerTalk("Yourself")
  self:registerTalk("Bombs")
  self:registerTalk("Lore")
  self:registerTalk("The Stars")
  
  self:registerTalkAfter("Dumbfuck Turnabout?", 1, "dumbfuckShilling", false)
  self:registerTalkAfter("After Playing", 1, "dumbfuckShilled", false)
  
  self:registerTalkAfter("", 4)
  
  
  
end

function DogShop:startTalk(talk)
	if talk == "Yourself" then
        self:setFlag("dumbfuckShilling", true)
        self:startDialogue({
            "* Me?[wait:10]\n* Hahaha...",
			"* Oh I'm just a poorly drawn dog.",
			"* Heck I don't even got any other sprites.",
			"* But hey,[wait:5] what's an indie game without a 4th wall breaking shopkeeper,[wait:5] right?!",
			"* Am I from anywhere you ask?",
			"* Well...",
        })
	elseif talk == "Dumbfuck Turnabout?" then	
		self:setFlag("dumbfuckShilled", true)
		self:startDialogue({
            "* Yep.[wait:10]\n* I'm from the Dumbfuck Turnabout.[wait:10]\n* ...What's that you ask?",
			"* Well ya see,[wait:5] the Dumbfuck Turnabout was this funny little series of Ace Attorney joke fan cases made by Charbomber.",
			"* Kind of like this exact thing you're playing now,[wait:5] actually!",
			"* I can give you a link if you want.",
			"* (To the first Dumbfuck Turnabout)\nhttps://objection.lol/case/fdsp9k1i/the-dumbfuck-turnabout",
			"* (To the sequel, the Dumberfuck Turnabout)\nhttps://objection.lol/case/8mufxagy/the-dumberfuck-turnabout \n* (That's the one I show up in!!)",
			"* There was a third one being made but Charbomber stopped making it as soon as he realized he put too much effort into it.",
			"* Isn't that funny?[wait:10] I bet if you DM him asking for it he can send you the files for it.",
			"* Oh yeah,[wait:5] and...[wait:10]\n* Only select the option that will replace this after having played each one.",
        })
	elseif talk == "After Playing" then
		self:startDialogue({
            "* What's that?[wait:10]\n* You want to know why Markiplier and Inscryption are important parts of the plot to The Dumbfuck Turnabout trilogy?",
			"* ...don't ask questions like that.",
        })
	elseif talk == "Bombs" then
		self:startDialogue({
            "* You want it?[wait:10]\n* It's yours my friend,[wait:5] as long as you have enough Dark Dollars!",
			"* Haha,[wait:5] that's just a little shopkeeper joke for you.",
			"* Yeah,[wait:5] people come here all the time since you can find Bombs around that old building out-front.",
			"* I guess that's why you're here too?",
        })
    elseif talk == "Lore" then
		self:startDialogue({
            "* Do I have any lore?[wait:10]\n* What kind of silly question is that?",
			"* No,[wait:5] I don't have anything terribly important to say.",
			"* Oh you know what?[wait:5]\n* You can have this super helpful tip instead:",
			"* If you want to grind to the max level (level 20),[wait:5] keep saving and reloading.",
			"* Every time you reload,[wait:5] both your XP and the XP needed for the next level will reset.",
			"* It's like starting back at level 1,[wait:5] except you'll be whatever level you loaded your save at.",
			"* Hope that helps.",
            "* Wait this isn't Kris and Susie Gamer Time.",
            "* Uhhhh ignore everything I just said haha.",
        })
	elseif talk == "The Stars" then
		self:startDialogue({
            "* 'The Stars'?[wait:10] What about em'?",
			"* Sorry,[wait:5] I wouldn't have any information on that.",
			"* But I suppose...",
			"* Maybe while you've been looking for them,[wait:10] they've been looking for YOU.",
			--"* The time in which this will make sense is soon approaching.",
        })
	elseif talk == "" then
		self:startDialogue({
            "* ...",
        })
	end
end

return DogShop