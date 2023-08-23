---
---@class PartyBattler
---
---@overload fun(...) : PartyBattler
local PartyBattler, super = Class("PartyBattler")

function PartyBattler:hurt(amount, exact, color, options)
    options = options or {}
    local _amount = amount

    -- Calculating amount
    if not exact then
        amount = self:calculateDamage(amount)
        if options["all"] then
            if self.defending then
                amount = math.ceil((2 * amount) / 3)
            end
        else
            if self.defending then
                amount = math.ceil((3 * amount) / 4)
            end
        end
    end

    -- Default to ignoring the callback if the damage is exact.
    -- It can still be enabled if necessary but in most cases
    -- this should be the ideal handling anyway.
    if exact and options["ignore_callback"] == nil then
        options["ignore_callback"] = true
    end

    -- Check whether damage has specified to ignore callback.
    if not options["ignore_callback"] then
        for _, item in ipairs(self.chara:getEquipment()) do
            if not item:includes(Item) then
                goto continue
            end
            -- If beforeHolderHurt() returns true, then the battler is not hurt.
            if item:beforeHolderHurt(self, amount, self.defending) then
                return
            end
            ::continue::
        end
    end

    -- The actual hurting of the battler happens here.
    super:hurt(self, _amount, exact, color, options)

    -- Once again, check whether to do the callback.
    if not options["ignore_callback"] then
        for _, item in ipairs(self.chara:getEquipment()) do
            if item:includes(Item) then
                item:onHolderHurt(self, amount, self.defending)
            end
        end
    end
end

function PartyBattler:down()
    for _, item in ipairs(self.chara:getEquipment()) do
        if not item:includes(Item) then
            goto continue
        end
        -- The party member will not be downed if beforeHolderDowned() returns true.
        if item:beforeHolderDowned(self) then
            return
        end 
        ::continue::
    end
    
    -- The battler is actually downed here.
    super:down(self)

    -- A new callback that fires on items when their holder is down.
    for _, item in ipairs(self.chara:getEquipment()) do
        if item:includes(Item) then
            item:onHolderDowned(self)
        end
    end
end

return PartyBattler