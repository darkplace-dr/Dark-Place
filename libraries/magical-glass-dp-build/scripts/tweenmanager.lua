local TweenManager = {}

TweenManager.__TWEENS = {}
TweenManager.__TWEENS_TO_REMOVE = {}

function TweenManager.tween(obj, prop, time, ease)
    local tween = {}
    tween.object = obj
    tween.properties = prop
    tween.init_properties = Utils.copy(tween.object)
    tween.time = time
    tween.easing = ease or "linear"
    if not Ease[tween.easing] then error(tween.easing.." is not a valid ease curve") end
    tween.callback = callback

    tween.progress = 0
    tween.props_to_remove = {}

    for _,itween in ipairs(TweenManager.__TWEENS) do
        if itween.object == tween.object then
            for iprop in pairs(tween.properties) do
                if itween.properties[iprop] then
                    table.insert(itween.props_to_remove, iprop)
                end
            end
        end
    end

    table.insert(TweenManager.__TWEENS, tween)
end

function TweenManager.updateTweens()
    for _,tween in ipairs(TweenManager.__TWEENS) do
        tween.progress = tween.progress + DTMULT
        for prop, value in pairs(tween.properties) do
            if tween.progress >= tween.time then
                table.insert(tween.props_to_remove, prop)
            else
                local t = (tween.progress) / (tween.time)
                tween.object[prop] = Utils.ease(tween.init_properties[prop], value, t, tween.easing)
            end

        end
    end
end

function TweenManager.updateTweensToRemove()
    for _,tween in ipairs(TweenManager.__TWEENS) do

        for _,prop in ipairs(tween.props_to_remove) do
            tween.properties[prop] = nil
        end

        local i = 0
        for prop, value in pairs(tween.properties) do
            if prop then
                i = i + 1
            end
        end

        if i == 0 then
            table.insert(TweenManager.__TWEENS_TO_REMOVE, tween)
        end
    end

    for _,tween in ipairs(TweenManager.__TWEENS_TO_REMOVE) do
        if tween.callback then
            tween.callback()
            tween.callback = nil
        end
        Utils.removeFromTable(TweenManager.__TWEENS, tween)
    end
end

Utils.hook(Game, "update", function(orig, self)
    orig(self)
    TweenManager.updateTweens()
    TweenManager.updateTweensToRemove()
end)

return TweenManager