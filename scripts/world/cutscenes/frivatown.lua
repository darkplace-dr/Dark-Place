return {
    board_1 = function(cutscene, event)
		cutscene:text("* Student Council:[wait:5] Festival planning today at 6!")
		cutscene:text("* As a reminder,[wait:5] we still need ideas for our stand at the festival.")
	end,
	
    board_2 = function(cutscene, event)
		cutscene:text("* Deoxynn victim assembly this coming Monday.")
		cutscene:text("* Please be respectful to your current students,[wait:5] even if they're lesser than you.")
	end,
	
    board_3 = function(cutscene, event)
		cutscene:text('* The "paper" on this board is painted on.')
		cutscene:text("* The board is painted directly to the wall.")
		cutscene:text("* Art teachers,[wait:5] right?")
	end,
	
    board_4 = function(cutscene, event)
		cutscene:text("* Free introductory classes at Kai's Dojo this week!")
		cutscene:text("* Learn self-defense and ensure your safety!")
	end,
	
    board_5 = function(cutscene, event)
		cutscene:text("* There seem to be grades on the board.")
		cutscene:text("* Everyone got A's,[wait:5] with the exception of one F.")
	end,
	
    board_6 = function(cutscene, event)
		cutscene:text("* The board seems untouched.")
	end,
	
    board_7 = function(cutscene, event)
		cutscene:text("* Beary the Bear tryouts this Saturday!")
		cutscene:text("* Please arrive before 4.30 to sign up!")
		cutscene:text("* There are also a bunch of sluzball games listed.")
	end,
	
    board_8 = function(cutscene, event)
		cutscene:text("* Today's special: Burgers with fries")
		cutscene:text("* The board seems untouched for a while.")
	end,
	
	bsink = function(cutscene, event)
		cutscene:text("* The sink seems damaged...")
	end,
	
    turlet = function(cutscene, event)
		cutscene:text("* The toilet has mold stains on it.")
	end,
	
    bathtub = function(cutscene, event)
		cutscene:text("* There are two bottles of shampoo and a bottle of body wash.")
	end,
	
	beach = function(cutscene, event)
		cutscene:text("* The beach's water seems unseasonally cold...")
	end,
	
	apartment = function(cutscene, event)
		cutscene:wait(cutscene:playSound("knock"))
		cutscene:text("* (No response.)")
	end,
	
	house_1 = function(cutscene, event)
		cutscene:wait(cutscene:playSound("knock"))
		cutscene:showNametag("???")
		cutscene:text("* Oh?\n[wait:5]* Is someone out there?")
		cutscene:text("* I'd normally open the door,[wait:5] but it's jammed.")
		cutscene:text("* ...")
		cutscene:text("* I guess not.")
		cutscene:hideNametag()
	end,
	
	truck = function(cutscene, event)
		cutscene:text("* The truck seems old...")
	end,
	
	store = function(cutscene, event)
		cutscene:text("* The store is closed.")
	end,
	
    counter = function(cutscene, event)
		cutscene:text("* (Check what?)")
		choice = cutscene:choicer({"Microwave", "Cabinet"})
		if choice == 1 then
			cutscene:text("* The microwave is clean and seems barely-used.")
		else
			cutscene:text("* Inside the cabinet,[wait:5] I see a set of knives.")
			cutscene:text("* The biggest knife is missing from the set.")
		end
	end,
	
	upper_shelf_1 = function(cutscene, event)
		cutscene:text("* Europan Origins[wait:5]\n* By Alex Wolfe")
		cutscene:text("* The first humans landed on Europa in a fleet of ships known as the Doomsday Fleet.")
		cutscene:text("* They went ahead and explored,[wait:5] and even went ahead and set up colonies.")
		cutscene:text("* These colonies were distant from each other and included our very own Frivatown.")
		cutscene:text("* Pretty soon,[wait:5] they were able to recreate a few inventions from Earth.")
		cutscene:text("* These inventions included computers,[wait:5] cars,[wait:5] and even the school bas.")
	end,
	
	upper_shelf_2 = function(cutscene, event)
		cutscene:text("* The bookshelf is full of sandwiches.")
	end,
	
	upper_shelf_3 = function(cutscene, event)
		cutscene:text("* You take a book out of the shelf.")
		cutscene:text("* You rip a page out and eat it.")
		cutscene:text('* This must be what they mean by "flavor text".')
		cutscene:text("* You put the book back on the shelf.")
	end,
	
	upper_shelf_4 = function(cutscene, event)
		cutscene:text("* Birds[wait:5]\n* By Birdman")
		cutscene:text("* BIRDS BIRDS BIRDS BIRDS BIRDS BIRDS BIRDS BIRDS BIRDS BIRDS BIRDS BIRDS BIRDS BIRDS BIRDS")
		cutscene:text("* Well,[wait:5] the book wasn't lying.")
	end,
	
	lower_shelf_1 = function(cutscene, event)
		cutscene:text("* Known Earth History[wait:5]\n* By Doctor Hannah Friedman")
		cutscene:text("* Earth wasn't a planet that I'd want to visit.")
		cutscene:text("* After all,[wait:5] the planet was known for a world war,[wait:5] countries stealing from each other...")
		cutscene:text("* ...and governments being ruled by idiots.")
		cutscene:text("* Thankfully,[wait:5] us Europans learned from the mistakes that Earth dwellers made.")
	end,
	
	lower_shelf_2 = function(cutscene, event)
		cutscene:text("* Unbiased Earth History[wait:5]\n* By Henry Ciders")
		cutscene:text("* We do not have much information from the humans' time on Earth.")
		cutscene:text("* The information we have is inventions,[wait:5] concepts,[wait:5] and conflicts with resolutions.")
		cutscene:text("* Among those wars is the World War,[wait:5] a war against genocide.")
	end,
	
	lower_shelf_3 = function(cutscene, event)
		cutscene:text("* This shelf is full of facts...")
		cutscene:text("* However, it's labeled as the conspiracy shelf.")
	end,
	
	lower_shelf_4 = function(cutscene, event)
		cutscene:text("* Desperation[wait:5]\n* By Jake Xen")
		cutscene:text("* Please,[wait:5] Brittney,[wait:5] please take me back,[wait:5] I had this whole book published just for you.")
	end,
	
	lower_shelf_5 = function(cutscene, event)
		cutscene:text("* The books here seem to be painted on.")
		cutscene:text('* The shelves are fake,[wait:5] too.[wait:5]\n* The "shelf" is just a block of wood.')
	end,
	
	lower_shelf_6 = function(cutscene, event)
		cutscene:text("* This book is a book on leaves.")
		cutscene:text("* Inside,[wait:5] all the pages are made of various leaves.")
		cutscene:text("* The cover is leaves,[wait:5] too.")
	end,
	
	lower_shelf_7 = function(cutscene, event)
		cutscene:text("* Earth Holidays[wait:5]\n* By Nick Nack")
		cutscene:text("* Earth has holidays for every month of their year.")
		cutscene:text("* Though most of these holidays are minor,[wait:5] some of them were carried over to Europa.")
		cutscene:text("* Valentine's Day celebrates the love we have for other people.")
		cutscene:text("* Hallow Teen is a day where we get to scare kids and give them candy.")
		cutscene:text("* Christmas is all about giving gifts to others.")
		cutscene:text("* It may have been misinterpreted in translation,[wait:5] but we celebrate these days anyways.")
	end,
	
	lower_shelf_8 = function(cutscene, event)
		cutscene:text("* Frivatown Festival[wait:5]\n* By Gina Mends")
		cutscene:text("* The festival of Frivatown celebrates the anniversary of this town.")
		cutscene:text("* Every year,[wait:5] we decorate half of Frivatown and celebrate.")
		cutscene:text("* We have various foods to eat and a live concert to enjoy.")
		cutscene:text("* A lot of planning goes into this festival.")
	end,
	
	lower_shelf_9 = function(cutscene, event)
		cutscene:text("* Earth History Part 4")
		cutscene:text("* It's time for part 4!")
		cutscene:text("* Of my Earth History series!")
		cutscene:text("* So here is the fourth part")
		cutscene:text("* To my Earth History series!")
		cutscene:text("* benis")
	end,
	
	lower_shelf_10 = function(cutscene, event)
		cutscene:text("* Fleeing Dystopia[wait:5]\n* By Sergeant Monica Greene")
		cutscene:text("* It is my hope that this diary gets published once we arrive on Europa.")
		cutscene:text("* As I am writing this,[wait:5] my ship,[wait:5] ID 54,[wait:5] had just arrived to the ISS.")
		cutscene:text("* We had just learned that ship 23 went back to Earth.")
		cutscene:text("* Earth was already destroyed by the doomsday event.")
		cutscene:text("* If anyone is remaining on Earth,[wait:5] they must've been lucky to survive.")
		cutscene:text("* And for ship 23,[wait:5] I wish you luck in rebuilding Earth civilization.")
		cutscene:text("* As for us,[wait:5] we are currently preparing to head to Europa.")
		cutscene:text("* It is consensus that none of us will make it to Europa...")
		cutscene:text("* ...but if humans generations in the future can touch Europan soil...")
		cutscene:text("* ...then the mission will be a success.")
	end,
	
	lower_shelf_11 = function(cutscene, event)
		cutscene:text("* The War Between Humans & Beasts[wait:5]\n* By Adam Blight")
		cutscene:text("* Beast and man have been at war ever since we arrived.")
		cutscene:text("* Honestly,[wait:5] we don't know what we did wrong.")
		cutscene:text("* For all I know,[wait:5] we only made some space for ourselves,[wait:5] right?")
		cutscene:text("* So,[wait:5] what went wrong?[wait:5]\n* What caused these creatures to be hostile?")
		cutscene:text("* And why us?[wait:5]\n* Why are they attacking only us?")
		cutscene:text("* From what I understand,[wait:5] the deoxynn were here longer,[wait:5] right?")
		cutscene:text("* There is a lot I still don't understand about the war.")
		cutscene:text("* However,[wait:5] when I understand more,[wait:5] I will make a volume 2.")
	end,
	
	lower_shelf_12 = function(cutscene, event)
		cutscene:text("* This whole shelf is filled with programming guides.")
	end,
	
	lower_shelf_13 = function(cutscene, event)
		cutscene:text("* Weather Hurts[wait:5]\n* By Jet Wethermen")
		cutscene:text("* We all know that weather is a constant on Europa.")
		cutscene:text("* We have sun and rain,[wait:5] sometimes thunder or snow,[wait:5] or maybe just clouds.")
		cutscene:text("* But when it comes to rain,[wait:5] how is it that we get hurt by it?")
		cutscene:text("* How is it that the tiny drops of water hurt us when we stand out in the rain?")
		cutscene:text("* Scientists have recently (year 153) figured out the answer.")
		cutscene:text("* (And then it's a bunch of science stuff...)")
	end,
	
	lower_shelf_14 = function(cutscene, event)
		cutscene:text("* Game review: Hats of Legend")
		cutscene:text("* This game is the story of a little boy who has magic hats.")
		cutscene:text("* These hats would give him different abilities to help him.")
		cutscene:text("* His adventure is all about collecting pieces of energy.")
		cutscene:text("* The story started to build when your friend betrays you.")
		cutscene:text("* I was shocked when I saw him at first.")
		cutscene:text("* I mean,[wait:5] how often is it that you see a kid with a beard?")
		cutscene:text("* It shocked me when the final boss was against him.")
		cutscene:text("* The mechanics are great,[wait:5] too.[wait:5] You have a variety of abilities from the start.")
		cutscene:text("* However,[wait:5] the whole \"friendship is power\" thing they tried...")
		cutscene:text("* It doesn't work when they suddenly turn to your side all at once.")
		cutscene:text("* Overall,[wait:5] 6/10.")
	end,
	
	computer_1 = function(cutscene, event)
		cutscene:text("* The computer is open to a flight simulator game.")
		cutscene:text("* In the game,[wait:5] the plane seems to be flying itself.")
		cutscene:text("* This must be an Auto-Pilot Interface.")
	end,
	
	bz = function(cutscene, event)
		cutscene:text("* The theme for the festival this year has been revealed!")
		cutscene:text("* The theme is:[wait:5] Flowers")
		cutscene:text("* Humans on Europa look to flowers for decoration, as did those on Earth!")
		cutscene:text("* This year, we look forward to your outfits and booths...")
		cutscene:text("* ...decorated with beautiful flower patterns and arrangements!")
	end,
	
	computer_2 = function(cutscene, event)
		cutscene:text("* There are a bunch of ants crawling over the screen.")
		cutscene:text("* The ants seem to only be crawling over a text document.")
		cutscene:text("* Something tells me that this program needs debugging.")
	end,
	
	computer_3 = function(cutscene, event)
		cutscene:text("* This computer seems to be running Windows 11.")
		cutscene:text("* After all,[wait:5] that's the maximum number of windows that fit onscreen.")
	end,
	
	computer_4 = function(cutscene, event)
		cutscene:text("* The background of this computer is a picture with a small cloud.")
		cutscene:text('* Inside the cloud is a single folder named "STORAGE".')
		cutscene:text("* Inside the folder reside a lot of files.")
	end,
	
	computer_5 = function(cutscene, event)
		Game:setFlag("deox_spam", Game:getFlag("deox_spam", 72) + 1)
		if Game:getFlag("deox_spam") > 65535 then
			cutscene:text("* You crashed the computer at the 16-bit integer limit.")
		elseif Game:getFlag("deox_spam") == 1997 then
			cutscene:text("* This computer has [1997] tabs open to an image of canned spam.")
		else
			cutscene:text("* This computer has " ..Game:getFlag("deox_spam").. " tabs open to an image of canned spam.")
		end
	end,
	
	computer_6 = function(cutscene, event)
		cutscene:text("* Ah,[wait:5] this computer has a cool desktop background.")
		cutscene:text("* Oh,[wait:5] wait.[wait:5]\n* Someone just raged when they were playing Geometry Dash.")
	end,
	
    tv = function(cutscene, event)
		cutscene:text("* In the TV cabinet lies a lot of TV remotes.")
	end,
	
    police_door = function(cutscene, event)
		cutscene:text("* The door is locked.")
		cutscene:text("* Through the door,[wait:5] you see a man typing on a laptop.")
		cutscene:text("* His hand is on the charging port,[wait:5] and it's somehow charging?")
		if Game:hasPartyMember("jamm") then
			cutscene:showNametag("Jamm")
			cutscene:text("* The heck...?[wait:5]\n* Is that...[wait:5] Me...?", "stern", "jamm")
		end
		cutscene:hideNametag()
	end,
}