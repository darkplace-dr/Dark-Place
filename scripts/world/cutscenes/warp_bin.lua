-- ┌───────────────────────┐ \
-- │     The Warp Bin      │ \
-- └───────────────────────┘ \
-- or: the feature creep bin    - dobby
return function(cutscene, event)
    cutscene:text("* It's the warp bin.")
    cutscene:text("* Would you like to warp?[wait:10]\n* You only need the code.")

    if cutscene:choicer({"Sure", "Nope"}) == 2 then
        return
    end

    local wbi_ok = false
    ---@type WarpBinCodeInfo
    local action
    local action_raw
    local wbi = WarpBinInputMenu()
    wbi.finish_cb = function(_action, _action_raw)
        wbi_ok = true
        action = _action
        action_raw = _action_raw
    end
    Game.world:spawnObject(wbi, "ui")
    cutscene:wait(function() return wbi_ok end)

    if not action_raw then
        -- user changed their mind
        return
    elseif not action then
        if event.foolproof_counter == nil then event.foolproof_counter = 0 end
        event.foolproof_counter = event.foolproof_counter + 1
        if event.foolproof_counter == 10 then
            cutscene:text("* For some reason,[wait:5] the lid opened...")
            action = { result = "backrooms/gramophone" }
        else
            cutscene:text("* That doesn't seem to work.")
            if event.foolproof_counter >= 3 and event.foolproof_counter < 10 then
                cutscene:text("* You're reminded of the fact that you can put in \"00000000\" when you're stuck.")
                if event.foolproof_counter >= 5 then
                    cutscene:text("* Seriously, you're not getting anywhere with this.")
                end
            end
            return
        end
    end

    local warpable = Mod:evaluateCond(action)

    local result = action.result or action[1]
    local marker = action.marker or action[2]
    local silence_system_messages = action.silence_system_messages
    if silence_system_messages == nil then
        silence_system_messages = false
    end

    if type(result) == "function" then
        result = result(cutscene)
        if not result then return end
        if type(result) == "table" then
            marker = result.marker or result[2]
            result = result.result or result[1]
        end
    elseif not warpable then
        if action.on_fail then
            action.on_fail(cutscene)
        elseif not silence_system_messages then
            cutscene:text("* That doesn't seem to work.")
        end
        return
    end

    assert(type(result) == "string", "result should be the id of a map or a function (got a "..type(result)..")")

    local dest_map
    pcall(function() dest_map = Registry.createMap(result, Game.world) end)
    if not dest_map then
        if not silence_system_messages then
            cutscene:text("* Where are you warping to?")
        end
        return
    end
    if Game.world.map.id == dest_map.id then
        if not silence_system_messages then
            cutscene:text("* But you're already there.")
        end
        return
    end

    cutscene:wait(0.2)

    Game.world.music:stop()
    -- Hell naw is this the only way to stop all sounds?
    for key,_ in pairs(Assets.sound_instances) do
        Assets.stopSound(key, true)
    end
    cutscene:fadeOut(0)
    cutscene:playSound("impact")

    cutscene:wait(1)
    cutscene:loadMap(dest_map, marker, "down")
    cutscene:fadeIn(0.25)
end