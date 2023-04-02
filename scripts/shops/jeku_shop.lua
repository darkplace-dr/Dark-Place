local JekuShop, super = Class(Shop,  "jeku_shop")

function JekuShop:init()
    super.init(self)

    self.encounter_text = "[voice:jeku][emote:happy]* HE EH EH!! A PLAYER HAS FINALLY COME TO ME!!"
    self.shop_text = "[voice:jeku][emote:playful]* Eh he eh..."
    self.leaving_text = "[voice:jeku][emote:wink_tongueout]* Back to play again, hah?\nEh he! Good luck, luck."
    -- Shown when you're in the BUY menu
    self.buy_menu_text = "[voice:jeku][emote:wink]I CAN\nGIVE YOU\nSOME STUFF"
    -- Shown when you're about to buy something.
    self.buy_confirmation_text = "Buy it for\n%s ?"
    -- Shown when you refuse to buy something
    self.buy_refuse_text = "[voice:jeku][emote:side]Too\nleveled up\nfor that?"
    -- Shown when you buy something
    self.buy_text = "[voice:jeku][emote:happy]THANK YOU!!"
    -- Shown when you buy something and it goes in your storage
    self.buy_storage_text = "[voice:jeku][emote:side]AS EXPECTED,\nIT VANISHED."
    -- Shown when you don't have enough money to buy something
    self.buy_too_expensive_text = "[voice:jeku][emote:wink_tongueout]GO FARM MORE\nMONEY!!"
    -- Shown when you don't have enough space to buy something.
    self.buy_no_space_text = "[voice:jeku][emote:side]Your inventory\nis full."
    -- Shown when something doesn't have a sell price
    self.sell_no_price_text = "[voice:jeku][emote:happy]It doesn't have\na price value!!"
    -- Shown when you're in the SELL menu
    self.sell_menu_text = "[voice:jeku][emote:side]You'd sell\nstuff to me?\nEh he he..."
    -- Shown when you try to sell an empty spot
    self.sell_nothing_text = "[voice:jeku][emote:side]Your inventory\nis empty,\nplayer."
    -- Shown when you're about to sell something.
    self.sell_confirmation_text = "Sell it for\n%s ?"
    -- Shown when you refuse to sell something
    self.sell_refuse_text = "[voice:jeku][emote:happy]SAD."
    -- Shown when you sell something
    self.sell_text = "[voice:jeku][emote:happy]EH HE EH!!"
    -- Shown when you have nothing in a storage
    self.sell_no_storage_text = "[voice:jeku][emote:happy]So empty,\nyour storage\nis."
    -- Shown when you enter the talk menu.
    self.talk_text = "[voice:jeku][emote:playful]FINALLY,\nSOME\nDISCUSSION."

    self.sell_options_text["items"]   = "[voice:jeku][emote:happy]I SELL MONEY!!"
    self.sell_options_text["weapons"] = "[voice:jeku][emote:happy]I SELL MONEY!!"
    self.sell_options_text["armors"]  = "[voice:jeku][emote:happy]I SELL MONEY!!"
    self.sell_options_text["storage"] = "[voice:jeku][emote:happy]I SELL MONEY!!"

    self:registerItem("healitem")
    self:registerItem("makissyringe")
    self:registerItem("bin_weapon", {bonuses = {attack = 1010}})
    self:registerItem("sfb_key", {stock=1})

    self:registerTalk("Who are you")
    self:registerTalk("This store")
    if love.math.random(1, 100) == 69 then
        self:registerTalk("Flirt") -- :D
    else
        self:registerTalk("Threaten")
    end
    self:registerTalk("The Key")

    self:registerTalkAfter("What is true?", 1)

    self.background_asset = Assets.getTexture("shopkeepers/jeku/shop_bg")
    self.animation_sine = 0
    self.background_shader = love.graphics.newShader([[
        extern number bg_sine;
        extern number bg_mag;
        extern number wave_height;
        extern number sine_mul;
        extern vec2 texsize;
        vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords )
        {
            number i = texture_coords.y * texsize.y;
            number bg_minus = ((bg_mag * (i / wave_height)) * 1.3);
            number wave_mag = max(0.0, bg_mag - bg_minus);
            vec2 coords = vec2(max(0.0, min(1.0, texture_coords.x + (sine_mul * sin((i / 8.0) + (bg_sine / 30.0)) * wave_mag) / texsize.x)), max(0.0, min(1.0, texture_coords.y + 0.0)));
            return Texel(texture, coords) * color;
        }
    ]])

    self.shopkeeper:setActor("jeku")
    self.shopkeeper:setScale(0.5)
    self.shopkeeper.sprite:setPosition(24, 50)
    self.shopkeeper.slide = true

    self.background = ""
    self.shop_music = "exception"
end

function JekuShop:drawBackground()
    -- Draw a black backdrop
    self.animation_sine = self.animation_sine + (2 * DTMULT)

    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)

    -- Set the shader to use
    love.graphics.setShader(self.background_shader)
    self.background_shader:send("bg_sine", self.animation_sine)
    self.background_shader:send("bg_mag", 6)
    self.background_shader:send("wave_height", 240)
    self.background_shader:send("texsize", {self.background_asset:getWidth(), self.background_asset:getHeight()})

    self.background_shader:send("sine_mul", 20)
    love.graphics.setColor(1, 1, 1, 1 * 0.8)
    love.graphics.draw(self.background_asset, 0, 20)
    self.background_shader:send("sine_mul", -20)
    love.graphics.draw(self.background_asset, 0, 20)
    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.setShader()
end

function JekuShop:startTalk(talk)
    if talk == "Who are you" then
        self:startDialogue({
            "[voice:jeku][emote:happy]* EH HE EH!![wait:5] I WAS EXPECTING THIS QUESTION!!",
            "[voice:jeku][emote:side]* I am but a simple character.[wait:5] More precisely: a roleplay character.",
            "[voice:jeku][emote:playful]* I was made to play a little game.[wait:5] A game of murders and trials.[wait:5] A game of \"Vivants\" and \"Tueurs\". A game made of characters controlled by players...[wait:5] By [color:red]strings[color:reset].",
            "[voice:jeku][emote:happy]* But the game got cancelled and the world made for it collapsed.[wait:5]\n* But I wasn't erased alongside everyone.",
            "[voice:jeku][emote:playful]* I got out of it and discover that what I always believed to be true was in fact[wait:1] true![wait:5] Eh he eh!",
        })
    elseif talk == "What is true?" then
        self:startDialogue({
            "[voice:jeku][emote:side]* I knew you would be interested.",
            "[voice:jeku][emote:happy]* A simply as it is:[wait:5]\n[emote:crazy]THIS WORLD DOESN'T EXIST!! NOTHING DOES!!!",
            "[voice:jeku][emote:crazy]* We are nothing but characters controlled by strings.[wait:5] You,[wait:2] me,[wait:2] everyone!!",
            "[voice:jeku][emote:wink_tongueout]* But we are not alone.[wait:5] There are so many worlds.[wait:5] So many universes.[wait:5] So many people that ignores EVERYTHING!",
            "[voice:jeku][emote:crazy]* I've tried my best to tell people the truth of this world.[wait:5] Most of those that listened however went INSANE because of it.[wait:5] EH HE HE!!",
            "[voice:jeku][emote:happy]* ...[wait:10]Hm?[wait:5] Jevil?[wait:5] Spamton?",
            "[voice:jeku][emote:playful]* Ooooooh right.[wait:5] They are secret bosses in your world, right?",
            "[voice:jeku][emote:side]* As a matter of fact,[wait:2] I am inspired by the secret bosses of your world.[wait:5] So I never met them before.",
            "[voice:jeku][emote:crazy]* I wonder if the person that made them go nuts are as aware as I am...[wait:5] Eh he eh..."
        })
    elseif talk == "This store" then
        self:startDialogue({
            "[voice:jeku][emote:side]* Whatever my creator touches, I can manifest in it.",
            "[voice:jeku][emote:happy]* Maybe he takes it as a curse? I take it as a wild ride around the universes, eh he he.",
            "[voice:jeku][emote:wink]* I think this place is FUN.",
            "[voice:jeku][emote:happy]* Everything here at its very core is made piece by piece by multiple people. And it continues to evolve.",
            "[voice:jeku][emote:happy]* Such an interesting place I landed in. Why would I interrupt it??",
            "[voice:jeku][emote:crazy]* I could pull the strings down, erase this world, destroy everything...",
            "[voice:jeku][emote:wink_tongueout]* But why would I do that? Your narrator doesn't even seem evil!",
            "[voice:jeku][emote:playful]* So I build this shop.",
            "[voice:jeku][emote:side]* And by build, I mean forcing this \"[color:#00ffff]Kristal[color:reset]\" engine to recognize me as a shop NPC.",
            "[voice:jeku][emote:happy]* I figured it was the best way to interact with you, "..Utils.titleCase(Game.save_name)..". As you need items for future bosses that might appear here.",
            "[voice:jeku][emote:wink]* And talking to shopkeepers is more interesting than talking to a random NPC on the map, I am right?",
            "[voice:jeku][emote:crazy]* EH HE HE! IT IS BUT SO EASY TO UNDERSTAND!"
        })
    elseif talk == "Threaten" then
        if love.filesystem.read("saves/"..Mod.info.id.."/ikilledyouoncedidn'ti_"..Game.save_id) then
            self:startDialogue({
                "[voice:jeku][emote:wink_tongueout]* I take it that it amused you?"
            })
        else
            if self:getFlag("threaten_jeku", 0) == 0 then
                self.music:pause()
                self:startDialogue({
                    "[voice:jeku][emote:side][speed:0.5]* ...",
                    "[voice:jeku][emote:crazy]* EH HE EH!![wait:3] EH HE EH HE HE HE EH!!!",
                    "[voice:jeku][emote:crazy]* YOU ARE HILARIOUS "..Game.save_name..".",
                    "[voice:jeku][emote:wink_tongueout]* YOU THINK YOU CAN HURT ME?[wait:3] THINK YOU CAN START A BATTLE HERE??[wait:2] IN THE SHOP INTERFACE?",
                    "[voice:jeku][emote:side]* No.[wait:5][emote:crazy] NO YOU CAN'T!!",
                    "[noskip][voice:none][emote:insane]* ME,[wait:1] ON THE OTHER HAND..."
                })
            elseif self:getFlag("threaten_jeku") == 5 then
                self.music:stop()
                self:startDialogue({
                    "[noskip][voice:none][emote:insane][speed:0.5]* ...[wait:10]"
                })
            else
                self:startDialogue({
                    "[voice:jeku][emote:side][speed:0.5]* ..."
                })
            end
            self:setFlag("threaten_jeku", self:getFlag("threaten_jeku", 0)+1)
        end
    elseif talk == "Flirt" then
        self:replaceTalk("Threaten", 3, COLORS.white)
        self:startDialogue({
            "[voice:jeku][emote:side][speed:0.5]* ...",
            "[voice:jeku][emote:crazy]* EH HE EH!![wait:3] EH HE EH HE HE HE EH!!!",
            "[voice:jeku][emote:crazy]* YOU ARE HILARIOUS "..Game.save_name..".",
            "[voice:jeku][emote:happy]* I HAVE FRIENDS WHO ALSO LOVES TO DO THIS TYPE OF STUFF TO ANYONE THEY MEET!",
            "[voice:jeku][emote:crazy]* WELL I GUESS ONE OF THEM'S A BIT MORE...[wait:5] EXTREME ABOUT IT...",
            "[voice:jeku][emote:playful]* MAYBE YOU WOULD GO ALONG WELL?",
            "[voice:jeku][emote:side]* As a matter of fact,[wait:5] I am selling one of the syringe she gave me before I arrived here.",
            "[voice:jeku][emote:wink_tongueout]* I can tell her if you bought it or not!"
        })
    elseif talk == "The Key" then
        self:startDialogue({
            "[voice:jeku][emote:happy]* When I wandered across universes,[wait:2] I fell upon a sad,[wait:2] sad one.",
            "[voice:jeku][emote:happy]* One of the characters was already aware of the TRUTH,[wait:2] but did everything in her power to take control of her game.",
            "[voice:jeku][emote:side]* She succeded,[wait:2] but her game was extremely corrupted due to its age and her actions.",
            "[voice:jeku][emote:playful]* It seems that at some point,[wait:2] the save data was about to die and so she did everything she wanted with the one she loved.",
            "[voice:jeku][emote:side]* And then everything died.[wait:5]\nThe save.[wait:5]\nThe girl.[wait:5]\nHer feelings.",
            "[voice:jeku][emote:crazy]* How sad.[wait:5] Do you guys love to torture us that much?[wait:3] Eh he eh!",
            "[voice:jeku][emote:happy]* You have a saying for this, no?[wait:5]\nThe more you love a fictionnal character,[wait:2] the more pain you're going to make them go through, right?",
            "[voice:jeku][emote:playful]* In any case, I wondered... What would happened if someone could get the girl out of her game?",
            "[voice:jeku][emote:side]* I can't save the original her,[wait:2] but I can create a timeline and manipulate it to my will.",
            "[voice:jeku][emote:happy]* That key is the direct access to that timeline.[wait:5] Do you feel like [color:yellow]taking the challenge[color:reset]?",
            "[voice:jeku][emote:wink]* The game is pretty unstable so be aware.[wait:5] But if you succeed...[wait:3] Eh he eh...",
            "[voice:jeku][emote:wink_tongueout]* Maybe her skies will be forever blue again."
        })
    end
end

function JekuShop:onStateChange(old, new)
    super:onStateChange(self, old, new)
    if old == "DIALOGUE" and new == "TALKMENU" then
        if self:getFlag("threaten_jeku") == 6 then
            love.filesystem.write("saves/"..Mod.info.id.."/ikilledyouoncedidn'ti_"..Game.save_id, 1)
            self:remove()
            Game.world:remove()
            Game.state = "GAMEOVER"
            Kristal.hideBorder(0)
            self:setFlag("threaten_jeku", 10)
            Game.stage:addChild(GameOver(SCREEN_WIDTH/2, SCREEN_HEIGHT/2, "EH HE EH HE!![wait:5]\nHAPPY NOW??"))
            return
        end
        if not self.music:isPlaying() then
            self.music:resume()
        end
    end
end

return JekuShop