local SpamgolorShop, super = Class(Shop,  "spamgolor")

function SpamgolorShop:init()
    super.init(self)

    self.encounter_text = "[voice:spamgolor][emote:grin]* WELCOME TO MY SHOP!"
    self.shop_text = "[voice:spamgolor][emote:grin]* DEALS SO LOW EVERYONE I KNOW IS [[Dead]]!"
    self.leaving_text = "[voice:spamgolor][emote:glitch]* COME BACK [[Coming Soon]] !!"
    -- Shown when you're in the BUY menu
    self.buy_menu_text = "[voice:spamgolor][emote:grin]BUY MY PRODUCTS!"
    -- Shown when you're about to buy something.
    self.buy_confirmation_text = "THAT'LL BE\n%s !"
    -- Shown when you refuse to buy something
    self.buy_refuse_text = "[voice:spamgolor][emote:neutral]DO I [[Entertainment]] YOU?!"
    -- Shown when you buy something
    self.buy_text = "[voice:spamgolor][emote:manic]PLEASURE DOING BUSINESS!"
    -- Shown when you buy something and it goes in your storage
    self.buy_storage_text = "[voice:spamgolor][emote:manic]PLEASURE DOING BUSINESS!"
    -- Shown when you don't have enough money to buy something
    self.buy_too_expensive_text = "[voice:spamgolor][emote:smile][[Money]] NO."
    -- Shown when you don't have enough space to buy something.
    self.buy_no_space_text = "[voice:spamgolor][emote:smile]YOU'VE GOT [[Not enough storage]]!"
    -- Shown when something doesn't have a sell price
    self.sell_no_price_text = "[voice:spamgolor][emote:neutral]NO."
    -- Shown when you're in the SELL menu
    self.sell_menu_text = "[voice:spamgolor][emote:grin]I'LL TAKE YOUR [[Junk]]!"
    -- Shown when you try to sell an empty spot
    self.sell_nothing_text = "[voice:spamgolor][emote:glitch]DELICIUS [[Air]]!"
    -- Shown when you're about to sell something.
    self.sell_confirmation_text = "I'LL TAKE\nTHAT FOR\n%s !"
    -- Shown when you refuse to sell something
    self.sell_refuse_text = "[voice:spamgolor][emote:neutral]I DIDN'T NEED THAT ANYWAY."
    -- Shown when you sell something
    self.sell_text = "[voice:spamgolor][emote:manic]THANKS FOR THE [[Junk]]!"
    -- Shown when you have nothing in a storage
    self.sell_no_storage_text = "[voice:spamgolor][emote:neutral][[404 Storage items not found]]."
    -- Shown when you enter the talk menu.
    self.talk_text = "[voice:spamgolor][emote:smile]SURE,[wait:5] I CAN [Dialogue]."

    self.sell_options_text["items"]   = "[emote:grin]I'LL TAKE YOUR [[Junk]]!"
    self.sell_options_text["weapons"] = "[emote:grin]I'LL TAKE YOUR [[Junk]]!"
    self.sell_options_text["armors"]  = "[emote:grin]I'LL TAKE YOUR [[Junk]]!"
    self.sell_options_text["storage"] = "[emote:grin]I'LL TAKE YOUR [[Junk]]!"

    self:registerItem("strangekey", {stock = 1, color = {1, 1, 1, 1}, price = 500, description = "FOR OPENING A\n[[Specil]] DOOR", name="[[Key Item]]"})
    self:registerItem("gemapple", {description = "YOU NEED THIS!"})
    self:registerItem("discarded_robe", {stock = 1, price = 700, description = "LIMITED STOCK\nBUY NOW!", name = "POWER CLOAK", bonuses = {defense = math.huge}})
    self:registerItem("old_tome", {price = 500, description = "THE     BOOK OF\nALL TIME!", name = "POWER BOOK", bonuses = {attack = math.huge, magic = math.huge}})

    self:registerTalk("Spamton")
    self:registerTalk("Key")
    self:registerTalk("Magolor")
    self:registerTalk("This World")

    self:registerTalkAfter("Our Deal", 2)

    self.shopkeeper:setActor("spamgolor_shop")
    self.shopkeeper.sprite:setPosition(0, 15)
    self.shopkeeper.slide = true

    self.background = "ui/shop/spamtonshop_bg"
    self.shop_music = "spamgolor_shop"
end

function SpamgolorShop:startTalk(talk)
    if talk == "Spamton" then
        self:startDialogue({
            "[voice:spamgolor][emote:neutral]* WHY DO YOU BRING UP THAT [[Copyright Infringement]]?!",
            "[voice:spamgolor][emote:glitch]* HE STOLE MY ENTIRE [[Gimmick]] I TELL YOU!",
            "[voice:spamgolor]* BEFORE HE CAME ALONG,[wait:5] I WAS A [[Number1RatedSalesman2011]]!",
            "[voice:spamgolor]* AND NOW?[wait:10] I'M...",
            "[voice:spamgolor][emote:static]* ... A nobody...",
            "[voice:spamgolor][emote:glitch]* HE STOLE MY SPOTLIGHT!",
        })
    elseif talk == "Key" then
        self:startDialogue({
            "[voice:spamgolor][emote:grin]* WHAT DOES MY [[Key Item]] DO?",
            "[voice:spamgolor][emote:manic]* WELL,[wait:5] IT UNLOCKS A DOOR TO AN ARTIFACT OF [[Unlimited power]]!",
            "[voice:spamgolor]* A [[Heaven piercing]] [[Workout-ready body]]!",
            "[voice:spamgolor][emote:grin]* I KNOW THAT [[Salesman]] USED IT ONCE,[wait:5] SO I'M PLANNING TO TAKE IT FOR MYSELF.",
            "[voice:spamgolor][emote:smile]* HEY...[wait:10] WHAT DO YOU SAY WE MAKE A DEAL?",
        })
    elseif talk == "Magolor" then
        self:startDialogue({
            "[voice:spamgolor][emote:neutral]* WHO'S THAT?",
            "[voice:spamgolor]* YOU TELLING ME THERE'S SOMEONE WHO LOOKS ALMOST [[Perfect Match]] TO ME?",
            "[voice:spamgolor][emote:smile]* WELL,[wait:5] I'LL BE SURE TO PAY THEM A VISIT.",
            "[voice:spamgolor][emote:manic]* NOT!",
            "[voice:spamgolor][emote:grin]* WHY WOULD I WANT TO MEET A [[Faker]]?!",
        })
    elseif talk == "This World" then
        if self:getFlag("hell") ~= true then
            self:setFlag("hell", true)
            self:startDialogue({
                "[voice:spamgolor][emote:grin]* KID,[wait:5] I KNOW EXACTLY WHAT'S GOING ON HERE,[wait:5] YOU SEE-",
                "[voice:spamgolor][emote:static]* N-no,[wait:5] I'm sorry,[wait:5] I-I didn't mean to-",
                "[voice:spamgolor][emote:glitch]* TOO MANY EXCESS VACATION DAYS?[wait:10] TAKE A GODDAMN VACATION STRAIGHT TO [[Another Dimension]] !!"
            })
        else
            self:startDialogue({
                "[voice:spamgolor][emote:neutral]* ... I'LL REFRAIN FROM TALKING ABOUT THAT."
            })
        end
    elseif talk == "Our Deal" then
        self:startDialogue({
            "[voice:spamgolor][emote:smile]* ALRIGHT,[wait:5] LISTEN UP.",
            "[voice:spamgolor]* I DON'T KNOW EXACTLY WHERE,[wait:5] BUT SOMEWHERE,[wait:5] THERE IS A LOCKED DOOR.",
            "[voice:spamgolor]* AND I JUST SO HAPPEN TO HAVE THE KEY TO OPEN IT.",
            "[voice:spamgolor][emote:grin]* ALL I KNOW IS THAT SAID [[Workout-ready body]] IS BEHIND THAT DOOR.",
            "[voice:spamgolor][emote:smile]* I'M TRYING TO STAY AWAY FROM THAT [[Big Shot]],[wait:5] SO I NEED YOU TO OPEN IT FOR ME.",
            "[voice:spamgolor][emote:manic]* IF YOU FIND THAT DOOR,[wait:5] I WILL OFFER YOU MY [[Life savings]]!",
        })
    end
end

return SpamgolorShop