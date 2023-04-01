local item, super = Class(Item, "cell_phone")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Cell Phone"
    -- Name displayed when used in battle (optional)
    self.use_name = nil

    -- Item type (item, key, weapon, armor)
    self.type = "key"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "It can be used to make calls."

    -- Default shop price (sell price is halved)
    self.price = 0
    -- Whether the item can be sold
    self.can_sell = false

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "none"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "world"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false

    -- Equip bonuses (for weapons and armor)
    self.bonuses = {}
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = nil
    self.bonus_icon = nil

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {}

    -- Character reactions (key = party member id)
    self.reactions = {}
end

function item:onWorldUse()
    Game.world:startCutscene(function(cutscene)
        Assets.playSound("phone", 0.7)
        cutscene:text("* (You tried to call on the Cell\nPhone.)", nil, nil, {advance = false})
        cutscene:wait(40/30)
        local was_playing = Game.world.music:isPlaying()
		if love.math.random(1, 100) <= 10 then
            if was_playing then
                Game.world.music:pause()
            end
            Assets.playSound("mcdonalds")
		    cutscene:wait(200/30)
            if was_playing then
                Game.world.music:resume()
            end
            cutscene:text("* Sounded like an angry customer.")
		elseif love.math.random(1, 100) >= 87 and love.math.random(1, 100) <= 93 then
            if was_playing then
                Game.world.music:pause()
            end
			local fnaf = Assets.playSound("fnafcall")
		    cutscene:wait(function()
			    if fnaf:isPlaying() then
        		    return false
        	    end

        	    return true
            end)
            if was_playing then
                Game.world.music:resume()
            end
            cutscene:text("* It's nothing but useless information.")
		elseif love.math.random(1, 100) == 39 then
            cutscene:text("* Hello!\n* Could I speak to G...")
			cutscene:text("* ...[wait:5]\n* Wait a second.")
			cutscene:text("* Is this the wrong number?")
			local wrongnumber = Assets.playSound("wrongnumbersong")
			wrongnumber:setLooping(true)
			cutscene:text("* Oh it's the wrong number![wait:2]\n* The wrong number song!")
			cutscene:text("* We're very very sorry that\nwe got it wrong!")
			cutscene:text("* Oh it's the wrong number![wait:2]\n* The wrong number song!")
			cutscene:text("* We're very very sorry that\nwe got it wrong!")
			Assets.stopSound("wrongnumbersong")
			cutscene:text("* (Click...)")
            if was_playing then
                Game.world.music:resume()
            end
			cutscene:text("* Must've been a wrong number.")
		elseif love.math.random(1, 100) == 97 then
            if was_playing then
                Game.world.music:pause()
            end
            local spam = Assets.playSound("spamcall")
            cutscene:showNametag("Spamton G. Spamton")
            cutscene:text("[noskip][voice:nil]* FUCK YOU CYBER CITY![wait:10]", nil, nil, {auto = true})
            cutscene:text("[noskip][voice:nil]* IF YOU'RE [[Exploitable]] ENOUGH TO BUY A CAR THIS WEEKEND...[wait:5]", nil, nil, {auto = true})
            cutscene:text("[noskip][voice:nil]* YOU'RE A DESPERATE ENOUGH JOE SHMOE TO COME TO BIG SHOT AUTOS![wait:15]", nil, nil, {auto = true})
            cutscene:text("[noskip][voice:nil]* [[Ant-sized]] DEALS![wait:10]\n* CARS THAT [[Need auto insurance?]]![wait:10]", nil, nil, {auto = true})
            cutscene:text("[noskip][voice:nil]* THIEVES![wait:10]", nil, nil, {auto = true})
            cutscene:text("[noskip][voice:nil]* IF YOU THINK YOU'RE GOING TO FIND [[A free meal!]] AT BIG SHOT AUTOS...[wait:5]", nil, nil, {auto = true})
            cutscene:text("[noskip][voice:nil]* YOU CAN KISS MY [[Beautiful head]]!![wait:15]", nil, nil, {auto = true})
            cutscene:text("[noskip][voice:nil]* IT'S MY BELIEF THAT YOU'RE SUCH A [[Specil]] MOTHERFUCKER...[wait:5]", nil, nil, {auto = true})
            cutscene:text("[noskip][voice:nil]* THAT YOU'LL FALL FOR THIS [[Half-priced salamy]]![wait:10]", nil, nil, {auto = true})
            cutscene:text("[noskip][voice:nil]* GUARANTEED![wait:20]", nil, nil, {auto = true})
            cutscene:text("[noskip][voice:nil]* IF YOU FIND A [[50% off]] DEAL,[wait:20] YOU CAN SHOVE [[1000 KROMER]] UP YOUR UGLY ASS![wait:25]", nil, nil, {auto = true})
            cutscene:text("[noskip][voice:nil]* YOU HEARD ME RIGHT...[wait:5]", nil, nil, {auto = true})
            cutscene:text("[noskip][voice:nil]* SHOVE IT UP YOUR UGLY ASS![wait:15]", nil, nil, {auto = true})
            cutscene:text("[noskip][voice:nil]* BRING YOUR [[100th customer!]]![wait:5]\n* BRING YOUR [[Wild prizes]]![wait:5]\n* BRING YOUR [[Hochi mama]]![wait:5]", nil, nil, {auto = true})
            cutscene:text("[noskip][voice:nil]* I'LL FUCK HER![wait:5]", nil, nil, {auto = true})
            cutscene:text("[noskip][voice:nil]* THAT'S RIGHT![wait:3] I'LL FUCK YOUR [[Hochi mama]]![wait:10]", nil, nil, {auto = true})
            cutscene:text("[noskip][voice:nil]* BECAUSE AT BIG SHOT AUTOS,[wait:3] YOU'RE FUCKED SIX WAYS TO SUNDAY![wait:15]", nil, nil, {auto = true})
            cutscene:text("[noskip][voice:nil]* TAKE A HIKE TO BIG SHOT AUTOS![wait:15]", nil, nil, {auto = true})
            cutscene:text("[noskip][voice:nil]* HOME OF CHALLENGE [[Pipis.]]![wait:10]", nil, nil, {auto = true})
            cutscene:text("[noskip][voice:nil]* THAT'S RIGHT,[wait:3] CHALLENGE [[Pipis.]]![wait:15]", nil, nil, {auto = true})
            cutscene:text("[noskip][voice:nil]* HOW DOES IT WORK?[wait:10]", nil, nil, {auto = true})
            cutscene:text("[noskip][voice:nil]* IF YOU CAN [[Pipis.]] SIX FEET IN THE AIR STRAIGHT AND NOT GET WET...[wait:5]", nil, nil, {auto = true})
            cutscene:text("[noskip][voice:nil]* YOU GET [[No money back guarantee]]![wait:10]", nil, nil, {auto = true})
            cutscene:text("[noskip][voice:nil]* DON'T WAIT,[wait:3] DON'T DELAY...[wait:5]", nil, nil, {auto = true})
            cutscene:text("[noskip][voice:nil]* DON'T FUCK WITH ME OR I'LL RIP YOUR [[Eggs]] OFF![wait:10]", nil, nil, {auto = true})
            cutscene:text("[noskip][voice:nil]* ONLY AT BIG SHOT AUTOS![wait:15]", nil, nil, {auto = true})
            cutscene:text("[noskip][voice:nil]* THE ONLY DEALER THAT TELLS YOU TO FUCK OFF![wait:20]", nil, nil, {auto = true})
            cutscene:text("[noskip][voice:nil]* HURY UP, ASSHOLE![wait:10]", nil, nil, {auto = true})
            cutscene:text("[noskip][voice:nil]* THIS [[Specil deal]] ENDS THE MOMENT YOU WRITE US A CHECK...[wait:5]", nil, nil, {auto = true})
            cutscene:text("[noskip][voice:nil]* AND IT BETTER NOT BOUNCE OR YOU'RE A [[Permanently closed]] MOTHERFUCKER![wait:10]", nil, nil, {auto = true})
            cutscene:text("[noskip][voice:nil]* TAKE A GODDAMN VACATION STRAIGHT TO HELL![wait:40]", nil, nil, {auto = true})
            cutscene:text("[noskip][voice:nil]* ALSO KNOWN AS BIG SHOT AUTOS...[wait:5]", nil, nil, {auto = true})
            cutscene:text("[noskip][voice:nil]* CYBER CITY'S FILTHIEST...[wait:5]", nil, nil, {auto = true})
            cutscene:text("[noskip][voice:nil]* AND EXCLUSIVE HOME OF THE [[Biggest]] SON OF A BITCH IN THE DARK WORLD![wait:40]", nil, nil, {auto = true})
            cutscene:text("[noskip][voice:nil]* GUARANTEED![wait:30]", nil, nil, {auto = true})
            cutscene:hideNametag()
		    cutscene:wait(function()
			    if spam:isPlaying() then
        		    return false
        	    end

        	    return true
            end)
            if was_playing then
                Game.world.music:resume()
            end
            cutscene:text("* ...")
            cutscene:text("* What.")
            if cutscene:getCharacter("susie") then
                cutscene:showNametag("Susie")
                cutscene:text("* The hell was THAT?", "nervous", "susie")
                cutscene:hideNametag()
            end
        -- if anyone wants to add an additional easter egg, feel free to use the template below!

        --[[
        elseif love.math.random(1, 100) == 100 then
            if was_playing then
                Game.world.music:pause()
            end
            Assets.playSound("")
            cutscene:wait(200/30)
            if was_playing then
                Game.world.music:resume()
            end
            cutscene:text("")
        ]]
		
		
        -- [[Char's]] easteregg
        -- based on what I changed the cellphone to in an unreleased mod I made to test out how Kristal works that was called Kris and Susie Gamer Time.
        elseif love.math.random(1, 100) >= 11 and love.math.random(1, 100) <= 25 then
            if was_playing then
                Game.world.music:pause()
            end
            Assets.playSound("bbqbb")
            cutscene:wait(200/30)
            if was_playing then
                Game.world.music:resume()
            end
            cutscene:text("* It's nothing but an old meme.")
        else
            if was_playing then
                Game.world.music:pause()
            end
            Assets.playSound("smile")
            cutscene:wait(200/30)
            if was_playing then
                Game.world.music:resume()
            end
            cutscene:text("* It's nothing but garbage noise.")
        end
    end)
end

return item
