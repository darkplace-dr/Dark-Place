---@class EnemyBattler
---@overload fun(...) : EnemyBattler
local EnemyBattler, super = Class("EnemyBattler", true)

function EnemyBattler:init(actor, use_overlay)
    super.init(self, actor, use_overlay)
	
	self.tiredness = 0
end

function EnemyBattler:addMercy(amount)
    if self.mercy >= 100 and amount > 0 then
        -- We're already at full mercy; do nothing.
        return
    end

    self.mercy = self.mercy + amount
    if self.mercy < 0 then
        self.mercy = 0
    end

    if self.mercy >= 100 then
        self.mercy = 100
    end

    if self:canSpare() then
        self:onSpareable()
        if self.auto_spare then
            self:spare(false)
        end
    end

    if Game:getConfig("mercyMessages") then
        if amount > 0 then
            local pitch = 0.8
            if amount < 99 then pitch = 1 end
            if amount <= 50 then pitch = 1.2 end
            if amount <= 25 then pitch = 1.4 end

            local src = Assets.playSound("mercyadd", 0.8)
            src:setPitch(pitch)
        end
        self:statusMessage("mercy", amount)
    end
end

function EnemyBattler:addTired(amount)
    if self.tiredness >= 100 then
        -- We're already at full tiredness; do nothing.
        return
    end

    self.tiredness = self.tiredness + amount
    if self.tiredness < 0 then
        self.tiredness = 0
    end

    if self.tiredness >= 100 then
        self.tiredness = 100
		self:setTired(true)
	else
		self:setTired(false)
    end

    if Game:getConfig("mercyMessages") then
        if amount > 0 then
            local pitch = 0.8
            if amount < 99 then pitch = 1 end
            if amount <= 50 then pitch = 1.2 end
            if amount <= 25 then pitch = 1.4 end

            local src = Assets.playSound("mercyadd", 0.8)
            src:setPitch(pitch)
        end
		if Kristal.getLibConfig("better_battles", "tiredness_bar") then
			self:statusMessage("tired", amount)
		end
    end
end

function EnemyBattler:canSleep()
    return self.tiredness >= 100
end

function EnemyBattler:onMercy(battler, spare_all)
    if self:canSpare() then
        self:spare()
        return true
    else
        if spare_all then
            local alive = 0
			for _,battler in ipairs(Game.battle.party) do
                if not battler.is_down then
                    alive = alive + 1
                end
            end
            local mercy_points = Utils.round(self.spare_points * alive/#Game.battle:getActiveEnemies())
            self:addMercy(math.min(mercy_points,100))
            -- if mercy_points > 100 and self:canSpare() then
                -- self:spare()
            -- end
            -- return true
        else
            self:addMercy(self.spare_points)
        end
        return false
    end
end

return EnemyBattler