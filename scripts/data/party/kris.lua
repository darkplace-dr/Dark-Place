local character, super = Class("kris", true)

function character:init()
    super.init(self)

    self.has_spells = true

    self.has_xact = false

    self:addSpell("xslash")
end

function character:onAttackHit(enemy, damage)
    if self:checkWeapon("aeonlance") then
        for i, v in ipairs(Game.battle:getActiveEnemies()) do
            if v ~= enemy then
                v:hurt(Utils.round(damage/3), nil, nil, self.dmg_color)
            end
        end
    end
end

return character