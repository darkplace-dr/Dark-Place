local item, super = Class("dogdollar", true)

function item:getLightBattleText(user, target)
    return "* "..user.chara:getNameOrYou().." admired the "..self:getName().."."
end

return item