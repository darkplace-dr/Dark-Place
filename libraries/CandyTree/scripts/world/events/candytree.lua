local CandyTree, super = Class(Event)

function CandyTree:init(x, y, properties)
    super.init(self, x, y)

    properties = properties or {}

    self:setScale(2)

    self.candyamount = properties["candies"] or 2

    self.sprite = Sprite("world/events/candy_tree")
    self:addChild(self.sprite)
end

function CandyTree:onLoad()
    if not self:getFlag("candies") then
        self:setFlag("candies", self.candyamount)
    end

    if self:getFlag("candies", 0) == 1 then
        self.sprite:setFrame(2)
    elseif self:getFlag("candies", 0) == 0 then
        self.sprite:setFrame(3)
    end
end

function CandyTree:onInteract(player, dir)
    if self:getFlag("candies", 0) == 0 then
        self.world:showText("* (There's nothing hanging low enough to take.)")
    else
        Game.world:startCutscene(function(cutscene)
            if self:getFlag("candies", 0) == 2 then
                cutscene:text("* (There are two objects hanging from the tree.)")
                cutscene:text("* (Take one?)")
            else
                cutscene:text("* (There's a candy hanging from the tree.)")
                cutscene:text("* (Take one?)")
            end
            local choices = {}
            table.insert(choices, "Yes")
            table.insert(choices, "No")
            local choice_i = cutscene:choicer(choices)
            if choice_i == 1 then
                local success
                success = Game.inventory:tryGiveItem("dark_candy")
                if not success then
                    cutscene:text("* (Your inventory is too full.)")
                else
                    if self:getFlag("candies", 0) == 2 then
                        self:setFlag("candies", 1)
                      self.sprite:setFrame(2)
                    else
                     self:setFlag("candies", 0)
                        self.sprite:setFrame(3)
                    end
                    cutscene:text("* (You got the Dark Candy.)")
                end
            end
        end)
    end
    return true
end

return CandyTree