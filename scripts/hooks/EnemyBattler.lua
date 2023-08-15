---@class EnemyBattler
local EnemyBattler, super = Class("EnemyBattler", true)

function EnemyBattler:init(...)
    super.init(self, ...)
    self.killable = true
end

function EnemyBattler:hurt(amount, battler, on_defeat, color, show_status_msg)
    show_status_msg = show_status_msg or true

    amount = amount / (BadgesLib:getBadgeEquipped("deal") + 1)

    self.health = self.health - amount
    if show_status_msg then
        self:statusMessage("damage", amount, color or (battler and {battler.chara:getDamageColor()}))
    end

    self.hurt_timer = 1
    self:onHurt(amount, battler)

    self:checkHealth(on_defeat, amount, battler)
end

function EnemyBattler:onDefeat(...)
    if self.killable and Game:getFlag("can_kill") then
        self:onDefeatFatal(...)
    elseif self.exit_on_defeat then
        self:onDefeatRun(...)
    else
        self.sprite:setAnimation("defeat")
    end
end

return EnemyBattler