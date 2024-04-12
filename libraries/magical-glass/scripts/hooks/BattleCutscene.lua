local BattleCutscene, super = Class("BattleCutscene", true)

local function _true() return true end
local function waitForTextChoicer(self) return not Game.battle.battle_ui.text_choice_box or Game.battle.battle_ui.text_choice_box:isDone(), Game.battle.battle_ui.text_choice_box.selected_choice end
function BattleCutscene:textChoicer(text, choices, portrait, actor, options)
    if type(actor) == "table" and not isClass(actor) then
        options = actor
        actor = nil
    end
    if type(portrait) == "table" then
        options = portrait
        portrait = nil
    end

    options = options or {}

    local box = Game.battle.battle_ui.text_choice_box

    local width, height = 530, 104

    for _,choice in ipairs(choices) do
        box:addChoice(choice)
    end

    local speaker = self.textbox_speaker
    if not speaker and isClass(actor) and actor:includes(Character) then
        speaker = actor.sprite
    end

    if options["talk"] ~= false then
        box.text.talk_sprite = speaker
    end

    actor = actor or self.textbox_actor
    if isClass(actor) and actor:includes(Character) then
        actor = actor.actor
    end
    if actor then
        box:setActor(actor)
    end

    box.active = true
    box.visible = true
    box:setFace(portrait, options["x"], options["y"])

    if options["reactions"] then
        for id,react in pairs(options["reactions"]) do
            box:addReaction(id, react[1], react[2], react[3], react[4], react[5])
        end
    end

    if options["functions"] then
        for id,func in pairs(options["functions"]) do
            box.textchoicebox:addFunction(id, func)
        end
    end

    if options["font"] then
        if type(options["font"]) == "table" then
            -- {font, size}
            box:setFont(options["font"][1], options["font"][2])
        else
            box:setFont(options["font"])
        end
    end

    if options["align"] then
        box:setAlign(options["align"])
    end

    box:setSkippable(options["skip"] or options["skip"] == nil)

    box:setText(text, function()
        box:remove()
        self:tryResume()
    end)

    if options["wait"] or options["wait"] == nil then
        return self:wait(waitForTextChoicer)
    else
        return waitForTextChoicer, box
    end
end

function BattleCutscene:closeText()
    local choice_box = Game.battle.battle_ui.choice_box
    local text = Game.battle.battle_ui.encounter_text
    if choice_box.active then
        choice_box:clearChoices()
        choice_box.active = false
        choice_box.visible = false
        text.active = true
        text.visible = true
    end

    if self.textchoicebox then
        self.textchoicebox:remove()
        self.textchoicebox = nil
    end

    for _,battler in ipairs(Utils.mergeMultiple(Game.battle.party, Game.battle:getActiveEnemies())) do
        if battler.bubble then
            battler:onBubbleRemove(battler.bubble)
            battler.bubble:remove()
            battler.bubble = nil
        end
    end
    Game.battle.battle_ui:clearEncounterText()
end

return BattleCutscene