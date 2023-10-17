---@param cutscene WorldCutscene
return function(cutscene)
    local function textFinish(text)
        return function() return text.done end
    end

    local function showText(obj, tbl, options)
        local _tbl
        if type(tbl) ~= "table" then
            _tbl = {tbl}
        else
            _tbl = Utils.copy(tbl)
        end
        for i, v in ipairs(_tbl) do
            _tbl[i] = "[noskip][speed:0.3][voice:nil]" .. v
        end

        obj.visible = true
        obj:setText(_tbl)
        cutscene:wait(textFinish(obj))
        obj.visible = false
    end

    local fountain = Game.world:getEvent(2)
    local susie = cutscene:getCharacter("susie")

    local used_fountain_once = Game:getFlag("used_fountain_once", false)

    cutscene:wait(cutscene:fadeOut(0)) -- remove fadein
    cutscene:fadeIn(3)

    cutscene:detachFollowers()
    local members = {}
    for _, member in ipairs(Game.party) do
        table.insert(members, cutscene:getCharacter(member.id))
    end
    local leader = members[1]
    local party_poss = {
        { initial = {320, 600}, walk_up = {380, 10} },
        { initial = {250, 640}, walk_up = {420, 10} },
        { initial = {380, 640}, walk_up = {420, 10} },
        { initial = {320, 680}, walk_up = {440, 10} },
        { initial = {250, 720}, walk_up = {460, 10} },
        { initial = {380, 720}, walk_up = {460, 10} },
        { initial = {180, 680}, walk_up = {440, 10} },
        { initial = {450, 680}, walk_up = {440, 10} },
    }
    local party_walk_up_wait = nil
    for i, member in ipairs(members) do
        local pos = party_poss[i]
        member:setPosition(unpack(pos.initial))
        party_walk_up_wait = cutscene:walkTo(member, member.x, unpack(pos.walk_up))
    end
    cutscene:wait(party_walk_up_wait) -- 220/30
    cutscene:wait(used_fountain_once and 1.25 or 2)

    local text = DialogueText({"ass"}, 100, 80, (SCREEN_WIDTH - 100 * 2) + 14, SCREEN_HEIGHT, nil, "dark")
    text:setLayer(WORLD_LAYERS["textbox"])
    text:addFunction("look", function(self, chara, dir)
        cutscene:look(chara, dir)
    end)
    Game.world:addChild(text)

    local v_susie = "[spacing:1.75][voice:susie]"

    if not used_fountain_once then
        local look_str = "[func:look,susie,right]"
        showText(text, {
            v_susie.."So here's the fountain of this place...",
            v_susie.."It feels... so different from the previous ones.",
            v_susie.."Like it's way more powerful... and stable.",
            v_susie.."Is it what [color:blue]PURE DARKNESS[color:reset] is like?",
            v_susie.."...",
            v_susie.."Something tells me we might not be able to seal it.",
            leader.id == "kris"
            and v_susie..look_str.."But I guess we can still try.\nRight, Kris?"
            or v_susie..look_str..string.format("Actually, %s... Can you even seal one?", leader.actor.name)
        })
    else
        showText(text, "[noskip:false][speed:1](Do you want to return to the Light World?)")
    end

    local seal = cutscene:choicer({"Yes", "No"})
    cutscene:look(susie, "up")

    if seal == 1 then
        Game:setFlag("used_fountain_once", true)

        cutscene:wait(cutscene:walkTo(leader, leader.x, leader.y - 80, 2))
        cutscene:wait(1)

        --if not used_fountain_once then
        showText(text, "(It was as if your very SOUL was glowing...)")
        --end

        Game.world.music:stop()

        local soul = UsefountainSoul(leader.x, leader.y - leader.height + 10)
        soul.layer = WORLD_LAYERS["ui"]
        Game.world:addChild(soul)

        cutscene:playSound("great_shine")
        cutscene:wait(1)

        Game.world.music:play("usefountain", 1)
        Game.world.music.source:setLooping(false)

        cutscene:wait(50/30)
        fountain.adjust = 1 -- fade out color
        Game.world.timer:tween(170/30, soul, {y = 160})
        --[[
            -- fade out the depth texture
            Game.world.timer:during(170/30, function()
                fountain.eyebody = fountain.eyebody - (fountain.eyebody * (1 - 0.98) * DTMULT)
            end)
        ]]
        cutscene:wait(170/30)
        -- fountain.adjust = 2 -- freeze in place
        fountain.adjust = 4 -- fade to white
        cutscene:wait(3)

        cutscene:playSound("revival")
        soul:shine()
        local flash_parts = {}
        local flash_partn_o = 12
        local flash_part_rs = 0.5
        for i = 1, flash_partn_o - 1 do
            local part = Rectangle(SCREEN_WIDTH / 2, 0, 1, SCREEN_HEIGHT)
            part:setOrigin(0.5, 0)
            part.layer = soul.layer - i
            part:setColor(1, 1, 1, -(i / flash_partn_o))
            part.graphics.fade = flash_part_rs / 16
            part.graphics.fade_to = math.huge
            part.scale_x = i*i * 2
            part.graphics.grow_x = flash_part_rs*i * 2
            table.insert(flash_parts, part)
            Game.world:addChild(part)
        end
        local function fade(step, color)
            local rect = Rectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
            rect:setParallax(0, 0)
            rect:setColor(color)
            rect.layer = soul.layer + 1
            rect.alpha = 0
            rect.graphics.fade = step
            rect.graphics.fade_to = 1
            Game.world:addChild(rect)
            cutscene:wait(1 / step / 30)
        end
        cutscene:wait(50/30)
        fade(0.02, {1, 1, 1})
        cutscene:wait(20/30)
        cutscene:wait(cutscene:fadeOut(100/30, {color = {0, 0, 0}}))
        cutscene:wait(1)

        cutscene:fadeIn(1, {color = {1, 1, 1}})
        Kristal.showBorder(1)
        cutscene:loadMap("warphub") -- temporary
    else
        cutscene:wait(1)

        if not used_fountain_once then
            cutscene:wait(10/30)
            showText(text, {
                v_susie.."It may be better this way.",
                v_susie.."After all, our adventures here aren't over yet."
            })
        end

        local walk_down_wait = nil
        for _, member in ipairs(members) do
            walk_down_wait = cutscene:walkTo(member, member.x, 600, not used_fountain_once and 10 or 5)
        end
        cutscene:wait(walk_down_wait)
        cutscene:wait(not used_fountain_once and 2 or 0.5)

        cutscene:wait(cutscene:fadeOut(not used_fountain_once and 3 or 2))
        cutscene:loadMap("room_prefountain", "entry_fountain", "down")
        cutscene:fadeIn(0.5)
        Kristal.showBorder(0.5)
    end
end