local Diamond_Store, super = Class(Shop)

local talktext_rand = love.math.random(1, 11)
local talktext = ({
    "[emote:talk]* I am a big person.[emote:idle]",
    "[emote:talk]* You are a little people.[emote:idle]",
    "[emote:talk]* I hate people.[emote:idle]",
    "[emote:talk]* Why are you here?[emote:idle]",
    "[emote:talk]* Why are you a person?[emote:idle]",
    "[emote:talk]* Do you do crime?[emote:idle]",
    "[emote:talk]* I hate super mario.[emote:idle]",
    "[emote:talk]* This is a story.[emote:idle]",
    "[emote:talk]* I am full of SQUAG.[emote:idle]",
    "[emote:talk]* You make me look like pain.[emote:idle]",
    "[emote:talk]* My crown is too epicness.[emote:idle]"
})[talktext_rand]  -- fallback: "Depa Runts"

function Diamond_Store:init()
  local talktext_rand = love.math.random(1, 11)
  super.init(self)
  
  self.shop_music = nil
  
  self.shopkeeper:setActor("diamond_giant_shop")
  self.shopkeeper.talk_sprite = true
  self.shopkeeper.slide = true
  self.background = ("shopkeepers/diamond_giant/blink_1")
  
  self.encounter_text = "[emote:talk]* What'a ya buyin?[emote:idle]"
  self.shop_text = "[emote:talk]* Take your time.[emote:idle]"
  self.leaving_text = "[emote:talk]* Merry Christmas!!![emote:idle]"
  self.shop_text = "[emote:idle]* I have all day."
  self.buy_menu_text = "[emote:talk]* Picking?[emote:idle]"
  self.buy_confirmation_text = "* You want\nthis?"
  self.buy_refuse_text = "* Well alrighty then."
  self.buy_text = "[emote:talk]* Take care of that.[emote:idle]"
  self.buy_storage_text = "* Empty your pockets for once."
  self.buy_too_expensive_text = "[emote:talk]* I sadly can't give it away.[emote:idle]"
  self.buy_no_space_text = "[emote:talk]* You don't have any room![emote:idle]"
  self.sell_menu_text = "[emote:talk]* I am ready to spend.[emote:idle]"
  self.sell_no_price_text = "* I don't know the value of that..."
  self.sell_nothing_text = "[emote:talk]* Is that a PLACEBO?.[emote:idle]"
  self.sell_confirmation_text = "* You get %s\nin DARK cash."
  self.sell_refuse_text = "* Why won't you sell?."
  self.sell_text = "[emote:talk]* I might consume this in the future.[emote:idle]"
  self.sell_no_storage_text = "*Impossible"
  self.talk_text = talktext

  self.sell_options_text["items"]   = "[emote:talk]* I am gonna buy.[emote:idle]"
  self.sell_options_text["weapons"] = "[emote:talk]* I am gonna buy.[emote:idle]"
  self.sell_options_text["armors"]  = "[emote:talk]* I am gonna buy.[emote:idle]"
  self.sell_options_text["storage"] = "[emote:talk]* I am gonna buy.[emote:idle]"

  self:registerItem("tension_storage", {stock = 1})
  self:registerItem("friend_buster", {stock = 1})

  
  self:registerTalk("Yourself")
  --self:registerTalk("...")
  --self:registerTalk("...")
  --self:registerTalk("...")
end

function Diamond_Store:postInit()
    -- Mutate talks

    self:processReplacements()

    -- Make a sprite for the background
    if self.background and self.background ~= "" then
        self.background_sprite = SpaceBG()
        self.background_sprite.layer = SHOP_LAYERS["background"]
        self:addChild(self.background_sprite)
    end

    -- Construct the UI
    self.large_box = UIBox()
    local left, top = self.large_box:getBorder()
    self.large_box:setOrigin(0, 1)
    self.large_box.x = left
    self.large_box.y = SCREEN_HEIGHT - top + 1
    self.large_box.width = SCREEN_WIDTH - (top * 2) + 1
    self.large_box.height = 213 - 37 + 1
    self.large_box:setLayer(SHOP_LAYERS["large_box"])

    self.large_box.visible = false

    self:addChild(self.large_box)

    self.left_box = UIBox()
    local left, top = self.left_box:getBorder()
    self.left_box:setOrigin(0, 1)
    self.left_box.x = left
    self.left_box.y = SCREEN_HEIGHT - top + 1
    self.left_box.width = 338 + 14
    self.left_box.height = 213 - 37 + 1
    self.left_box:setLayer(SHOP_LAYERS["left_box"])

    self:addChild(self.left_box)

    self.right_box = UIBox()
    local left, top = self.right_box:getBorder()
    self.right_box:setOrigin(1, 1)
    self.right_box.x = SCREEN_WIDTH - left + 1
    self.right_box.y = SCREEN_HEIGHT - top + 1
    self.right_box.width = 20 + 156 + 1
    self.right_box.height = 213 - 37 + 1
    self.right_box:setLayer(SHOP_LAYERS["right_box"])

    self:addChild(self.right_box)

    self.info_box = UIBox()
    local left, top = self.info_box:getBorder()
    local right_left, right_top = self.right_box:getBorder()
    self.info_box:setOrigin(1, 1)
    self.info_box.x = SCREEN_WIDTH - left + 1
    -- find a more elegant way to do this...
    self.info_box.y = SCREEN_HEIGHT - top - self.right_box.height - (right_top * 2) + 16 + 1
    self.info_box.width = 20 + 156 + 1
    self.info_box.height = 213 - 37
    self.info_box:setLayer(SHOP_LAYERS["info_box"])

    self.info_box.visible = false

    self:addChild(self.info_box)

    local emoteCommand = function(text, node)
        self:onEmote(node.arguments[1])
    end

    self.dialogue_text = DialogueText(nil, 30, 270, 372, 194)

    self.dialogue_text:registerCommand("emote", emoteCommand)

    self.dialogue_text:setLayer(SHOP_LAYERS["dialogue"])
    self:addChild(self.dialogue_text)
    self:setDialogueText(self.encounter_text)

    self.right_text = DialogueText("", 30 + 420, 260, 176, 206)

    self.right_text:registerCommand("emote", emoteCommand)

    self.right_text:setLayer(SHOP_LAYERS["dialogue"])
    self:addChild(self.right_text)
    self:setRightText("")

    self.talk_dialogue = {self.dialogue_text, self.right_text}

    self.large_box:remove()
    self.left_box:remove()
    self.right_box:remove()
    self.info_box:remove()
    self.bg_cover:remove()

end

function Diamond_Store:startTalk(talk)
	if talk == "Yourself" then
        self:startDialogue({
            "[emote:talk]* So uh...[emote:idle]",
            "[emote:talk]* I am big...[emote:idle]",
            "[emote:talk]* There's not much to say. :/[emote:idle]"
        })
	elseif talk == "..." then
        self:startDialogue({
            "* ...",
        })
	end
end

return Diamond_Store