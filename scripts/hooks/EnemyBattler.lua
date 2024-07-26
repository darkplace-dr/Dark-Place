---@class EnemyBattler
local EnemyBattler, super = Class("EnemyBattler", true)

function EnemyBattler:init(...)
    super.init(self, ...)
    self.killable = true
	
	self.service_mercy = 50
	self.tiredness = 0
	
	self.back_attack = nil
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
		self:statusMessage("tired", amount)
    end
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

function EnemyBattler:canSleep()
    return self.tiredness >= 100
end

function EnemyBattler:setTired(bool)
    self.tired = bool
    if self.tired then
		self.tiredness = 100
        self.comment = "(Tired)"
    else
        self.comment = ""
    end
end

function EnemyBattler:defeat(reason, violent)
    self.done_state = reason or "DEFEATED"

    if violent then
        Game.battle.used_violence = true
        if self:isRecruitable() and self:getRecruitStatus() ~= false then
            if Game:getConfig("enableRecruits") and self.done_state ~= "FROZEN" then
                self:recruitMessage("lost")
            end
            self:setRecruitStatus(false)
        end
    end

    Game.battle.money = Game.battle.money + self.money

    if self.done_state == "KILLED" or self.done_state == "FROZEN" then
        Game.battle.killed = true
        Game:addFlag("library_kills", 1)
        if self.done_state == "FROZEN" and Kristal.getLibConfig("leveling", "local_freezing") then
            Game.battle.freeze_xp = Game.battle.freeze_xp + self.experience
        else
            Game.battle.xp = Game.battle.xp + self.experience
        end
    end
    
    if self:isRecruitable() and type(self:getRecruitStatus()) == "number" and (self.done_state == "PACIFIED" or self.done_state == "SPARED") then
        self:setRecruitStatus(self:getRecruitStatus() + 1)
        if Game:getConfig("enableRecruits") then
            local counter = self:recruitMessage("recruit")
            counter.first_number = self:getRecruitStatus()
            counter.second_number = Game:getRecruit(self.id):getRecruitAmount()
            Assets.playSound("sparkle_gem")
        end
        if self:getRecruitStatus() >= Game:getRecruit(self.id):getRecruitAmount() then
            self:setRecruitStatus(true)
        end
    end

    Game.battle:removeEnemy(self, true)
end

function EnemyBattler:selectWave()
    if not self.wii_grab then
		return super:selectWave(self)
	end
end

function EnemyBattler:spare(pacify)
    if self.exit_on_defeat then
        Game.battle.spare_sound:stop()
        Game.battle.spare_sound:play()

        local spare_flash = self:addFX(ColorMaskFX())
        spare_flash.amount = 0

        local sparkle_timer = 0
        local parent = self.parent

        Game.battle.timer:during(5/30, function()
            spare_flash.amount = spare_flash.amount + 0.2 * DTMULT
            sparkle_timer = sparkle_timer + DTMULT
            if sparkle_timer >= 0.5 then
                local x, y = Utils.random(0, self.width), Utils.random(0, self.height)
                local sparkle = SpareSparkle(self:getRelativePos(x, y))
                sparkle.layer = self.layer + 0.001
                parent:addChild(sparkle)
                sparkle_timer = sparkle_timer - 0.5
            end
        end, function()
            spare_flash.amount = 1
            local img1 = AfterImage(self, 0.7, (1/25) * 0.7)
            local img2 = AfterImage(self, 0.4, (1/30) * 0.4)
            img1:addFX(ColorMaskFX())
            img2:addFX(ColorMaskFX())
            img1.physics.speed_x = 4
            img2.physics.speed_x = 8
			if self.left then
				img1.physics.speed_x = -4
				img2.physics.speed_x = -8
			end
            parent:addChild(img1)
            parent:addChild(img2)
            self:remove()
        end)
    end

    self:defeat(pacify and "PACIFIED" or "SPARED", false)
    self:onSpared()
end

return EnemyBattler
