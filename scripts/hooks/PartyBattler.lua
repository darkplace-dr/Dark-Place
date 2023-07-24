---@class PartyBattler
local PartyBattler, super = Class("PartyBattler", true)

function PartyBattler:removeHealth(amount)
    amount = amount * (BadgesLib:getBadgeEquipped("double_pain") + 1)
    amount = amount / (BadgesLib:getBadgeEquipped("deal") + 1)
    super.removeHealth(self, amount)
end

function PartyBattler:removeHealthBroken(amount)
    amount = amount * (BadgesLib:getBadgeEquipped("double_pain") + 1)
    amount = amount / (BadgesLib:getBadgeEquipped("deal") + 1)
    super.removeHealth(self, amount)
end

return PartyBattler