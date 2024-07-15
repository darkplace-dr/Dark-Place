local CardCutscene, super = Class(Cutscene)

local function _true() return true end

function CardCutscene:init(group, id, ...)
    local scene, args = self:parseFromGetter(Mod.getCardCutscene, group, id, ...)

    self.textbox = nil
    self.textbox_actor = nil
    self.textbox_speaker = nil
    self.textbox_top = nil

    self.choicebox = nil
    self.choice = 0

    self.shopbox = nil

    self.moving_objects = {}

    Game.lock_movement = true
    Game.cutscene_active = true
	
	self.layer = CARD_LAYERS["textbox"]

    super:init(self, scene, unpack(args))
end

function CardCutscene:canEnd()
    if #self.moving_objects > 0 then
        return false
    end
    return Game.world.camera.pan_target == nil
end

function CardCutscene:update()
    local new_moving = {}
    for _,object in ipairs(self.moving_objects) do
        if object.physics.move_target then
            table.insert(new_moving, object)
        end
    end
    self.moving_objects = new_moving
	
	if self.textbox then
		self.textbox:update()
	end

    super:update(self)
end

function CardCutscene:onEnd()
    Game.lock_movement = false
    Game.cutscene_active = false

    if Game.card_game.cutscene == self then
        Game.card_game.cutscene = nil
    end

    if self.textbox then
        self.textbox:remove()
    end

    if self.choicebox then
        self.choicebox:remove()
    end

    super:onEnd(self)
end

function CardCutscene:getCharacter(id, index)
    return Game.world:getCharacter(id, index)
end

function CardCutscene:getMarker(name)
    return Game.world.map:getMarker(name)
end

function CardCutscene:resetSprites()
    Game.world.player:resetSprite()
    for _,follower in ipairs(Game.world.followers) do
        follower:resetSprite()
    end
end

function CardCutscene:spawnNPC(actor, x, y, properties)
    return Game.world:spawnNPC(actor, x, y, properties)
end

function CardCutscene:look(chara, dir)
    if not dir then
        dir = chara or "down"
        chara = Game.world.player
    elseif type(chara) == "string" then
        chara = self:getCharacter(chara)
    end
    chara:setFacing(dir)
end

function CardCutscene:walkTo(chara, x, y, time, facing, keep_facing, ease)
    if type(chara) == "string" then
        chara = self:getCharacter(chara)
    end
    local walked = false
    if chara:walkTo(x, y, time, facing, keep_facing, ease) then
        chara.physics.move_target.after = Utils.override(chara.physics.move_target.after, function(orig) orig() walked = true end)
        table.insert(self.moving_objects, chara)
        return function() return walked end
    else
        return _true
    end
end

function CardCutscene:walkToSpeed(chara, x, y, speed, facing, keep_facing)
    if type(chara) == "string" then
        chara = self:getCharacter(chara)
    end
    local walked = false
    if chara:walkToSpeed(x, y, speed, facing, keep_facing) then
        chara.physics.move_target.after = Utils.override(chara.physics.move_target.after, function(orig) orig() walked = true end)
        table.insert(self.moving_objects, chara)
        return function() return walked end
    else
        return _true
    end
end

function CardCutscene:walkPath(chara, path, options)
    if type(chara) == "string" then
        chara = self:getCharacter(chara)
    end

    local walked = false

    options = options or {}
    options.after = Utils.override(options.after, function(orig) orig() walked = true end)

    chara:walkPath(path, options)
    table.insert(self.moving_objects, chara)

    return function() return walked end
end

function CardCutscene:setSprite(chara, sprite, speed)
    if type(chara) == "string" then
        chara = self:getCharacter(chara)
    end
    chara:setSprite(sprite)
    if speed then
        chara:play(speed, true)
    end
end

function CardCutscene:setAnimation(chara, anim)
    if type(chara) == "string" then
        chara = self:getCharacter(chara)
    end
    local done = false
    chara:setAnimation(anim, function() done = true end)
    return function() return done end
end

function CardCutscene:resetSprite(chara)
    if type(chara) == "string" then
        chara = self:getCharacter(chara)
    end
    chara:resetSprite()
end

function CardCutscene:spin(chara, speed)
    if type(chara) == "string" then
        chara = self:getCharacter(chara)
    end
    chara:spin(speed)
end

function CardCutscene:slideTo(obj, x, y, time, ease)
    if type(obj) == "string" then
        obj = self:getCharacter(obj)
    end
    if type(x) == "string" then
        ease = time
        time = y
        x, y = Game.world.map:getMarker(x)
    end
    local slided = false
    if obj:slideTo(x, y, time, ease, function() slided = true end) then
        table.insert(self.moving_objects, obj)
        return function() return slided end
    else
        return _true
    end
end

function CardCutscene:slideToSpeed(obj, x, y, speed)
    if type(obj) == "string" then
        obj = self:getCharacter(obj)
    end
    if type(x) == "string" then
        speed = y
        x, y = Game.world.map:getMarker(x)
    end
    local slided = false
    if obj:slideToSpeed(x, y, speed, function() slided = true end) then
        table.insert(self.moving_objects, obj)
        return function() return slided end
    else
        return _true
    end
end

function CardCutscene:slidePath(obj, path, options)
    if type(obj) == "string" then
        obj = self:getCharacter(obj)
    end

    local slided = false

    options = options or {}
    local old_after = options.after
    options.after = function()
        if old_after then
            old_after()
        end
        slided = true
    end

    obj:slidePath(path, options)
    table.insert(self.moving_objects, obj)

    return function() return slided end
end

function CardCutscene:jumpTo(chara, ...)
    if type(chara) == "string" then
        chara = self:getCharacter(chara)
    end
    chara:jumpTo(...)
    return function() return not chara.jumping end
end

function CardCutscene:shakeCharacter(chara, x, y)
    if type(chara) == "string" then
        chara = self:getCharacter(chara)
    end
    chara:shake(x, y)
    return function() return chara.sprite.shake_x == 0 and chara.sprite.shake_y == 0 end
end

function CardCutscene:setSpeaker(actor, talk)
    if isClass(actor) and actor:includes(Character) then
        if talk ~= false then
            self.textbox_speaker = actor.sprite
        end
        self.textbox_actor = actor.actor
    elseif type(actor) == "string" and talk ~= false then
        local chara = self:getCharacter(actor)
        if chara then
            self.textbox_speaker = chara.sprite
            self.textbox_actor = chara.actor
        else
            self.textbox_speaker = nil
            self.textbox_actor = actor
        end
    else
        self.textbox_speaker = nil
        self.textbox_actor = actor
    end
end

function CardCutscene:setTextboxTop(top)
    self.textbox_top = top
end

local function waitForTextbox(self) return not self.textbox or self.textbox:isDone() end
function CardCutscene:text(text, portrait, actor, options)
    if type(actor) == "table" and not isClass(actor) then
        options = actor
        actor = nil
    end
    if type(portrait) == "table" then
        options = portrait
        portrait = nil
    end

    options = options or {}

    if self.textbox then
        self.textbox:remove()
    end

    if self.choicebox then
        self.choicebox:remove()
        self.choicebox = nil
    end

    local width, height = 529, 103
    if Game:isLight() then
        width, height = 530, 104
    end

    self.textbox = Textbox(56, 344, width, height)
    self.textbox.layer = CARD_LAYERS["textbox"]
    Game.card_game:addChild(self.textbox)
    self.textbox:setParallax(0, 0)

    local speaker = self.textbox_speaker
    if not speaker and isClass(actor) and actor:includes(Character) then
        speaker = actor.sprite
    end

    if options["talk"] ~= false then
        self.textbox.text.talk_sprite = speaker
    end

    actor = actor or self.textbox_actor
    if isClass(actor) and actor:includes(Character) then
        actor = actor.actor
    end
    if actor then
        self.textbox:setActor(actor)
    end
    if options["top"] then
       local bx, by = self.textbox:getBorder()
       self.textbox.y = by + 2
    end

    self.textbox.active = true
    self.textbox.visible = true
    self.textbox:setFace(portrait, options["x"], options["y"])

    if options["reactions"] then
        for id,react in pairs(options["reactions"]) do
            self.textbox:addReaction(id, react[1], react[2], react[3], react[4], react[5])
        end
    end

    if options["functions"] then
        for id,func in pairs(options["functions"]) do
            self.textbox:addFunction(id, func)
        end
    end

    if options["font"] then
        if type(options["font"]) == "table" then
            -- {font, size}
            self.textbox:setFont(options["font"][1], options["font"][2])
        else
            self.textbox:setFont(options["font"])
        end
    end

    if options["align"] then
        self.textbox:setAlign(options["align"])
    end

    self.textbox:setSkippable(options["skip"] or options["skip"] == nil)
    self.textbox:setAdvance(options["advance"] or options["advance"] == nil)
    self.textbox:setAuto(options["auto"])

    self.textbox:setText(text, function()
        self.textbox:remove()
        self:tryResume()
    end)

    local wait = options["wait"] or options["wait"] == nil
    if not self.textbox.text.can_advance then
        wait = options["wait"] -- By default, don't wait if the textbox can't advance
    end

    if wait then
        return self:wait(waitForTextbox)
    else
        return waitForTextbox, self.textbox
    end
end

function CardCutscene:closeText()
    if self.textbox then
        self.textbox:remove()
        self.textbox = nil
    end
end

local function waitForChoicer(self) return self.choicebox.done, self.choicebox.selected_choice end
function CardCutscene:choicer(choices, options)
    if self.textbox then
        self.textbox:remove()
        self.textbox = nil
    end

    if self.choicebox then self.choicebox:remove() end

    local width, height = 529, 103
    if Game:isLight() then
        width, height = 530, 104
    end

    self.choicebox = Choicebox(56, 344, width, height, false, options)
    self.choicebox.layer = CARD_LAYERS["textbox"]
    Game.card_game:addChild(self.choicebox)
    self.choicebox:setParallax(0, 0)

    for _,choice in ipairs(choices) do
        self.choicebox:addChoice(choice)
    end

    options = options or {}
    if options["top"] == nil and self.textbox_top == nil then
        local _, player_y = Game.world.player:localToScreenPos()
        options["top"] = player_y > 260
    end
    if options["top"] or (options["top"] == nil and self.textbox_top) then
        local bx, by = self.choicebox:getBorder()
        self.choicebox.y = by + 2
    end

    self.choicebox.active = true
    self.choicebox.visible = true

    if options["wait"] or options["wait"] == nil then
        return self:wait(waitForChoicer)
    else
        return waitForChoicer, self.choicebox
    end
end

function CardCutscene:showNametag(text, top)
	if self.nametag then self.nametag:remove() end

	self.nametag = Nametag(text, top)
	self.nametag.layer = CARD_LAYERS["textbox"]
    Game.card_game:addChild(self.nametag)
    self.nametag:setParallax(0, 0)
end

function CardCutscene:changeNametag(text)
	self.nametag:changeText(text)
end

function CardCutscene:hideNametag()
	if self.nametag then
        self.nametag:remove()
        self.nametag = nil
    end
end

return CardCutscene