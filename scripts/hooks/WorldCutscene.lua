---@class WorldCutscene
---@field use_light_textbox boolean|nil # Changes UI style to light for `cell_phone` only
local WorldCutscene, super = Class("WorldCutscene", true)

function WorldCutscene:startMinigame(game)
	Mod:startMinigame(game)

	local function waitForGame(self) return (Game.minigame == nil) end

	return self:wait(waitForGame)
end

function WorldCutscene:startEncounter(encounter, transition, enemy, options)
	if Game:isLight() then
		--
	else
		Game:setFlag("current_battle_system#", "deltarune")
	end
	options = options or {}
	transition = transition ~= false
	Game:encounter(encounter, transition, enemy)
	if options.on_start then
		if transition and (type(transition) == "boolean" or transition == "TRANSITION") then
			Game.battle.timer:script(function(wait)
				while Game.battle.state == "TRANSITION" do
					wait()
				end
				options.on_start()
			end)
		else
			options.on_start()
		end
	end

	local battle_encounter = Game.battle.encounter
	local function waitForEncounter(self) return (Game.battle == nil), battle_encounter end

	if options.wait == false then
		return waitForEncounter, battle_encounter
	else
		return self:wait(waitForEncounter)
	end
end

local function waitForTextbox(self) return not self.textbox or self.textbox:isDone() end
function WorldCutscene:doki_text(text, portrait, actor, options)
    if type(actor) == "table" and not isClass(actor) then
        options = actor
        actor = nil
    end
    if type(portrait) == "table" then
        options = portrait
        portrait = nil
    end

    options = options or {}

    self:closeText()

    local width, height = 529, 103
    if Game:isLight() then
        width, height = 530, 104
    end
    if options["name"] then
        self.textbox = Doki_Textbox(15, 365, width, height, nil, nil, nil, options["name"])
        self.textbox.layer = WORLD_LAYERS["textbox"]
    else
        self.textbox = Doki_Textbox(15, 365, width, height)
        self.textbox.layer = WORLD_LAYERS["textbox"]
    end
    self.world:addChild(self.textbox)
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

    if options["top"] == nil and self.textbox_top == nil then
        local _, player_y = self.world.player:localToScreenPos()
        options["top"] = player_y > 260
    end
    if options["top"] or (options["top"] == nil and self.textbox_top) then
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

return WorldCutscene