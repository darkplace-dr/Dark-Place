local StorageBox, super = Class(Interactable, "storagebox")

function StorageBox:init(x, y, properties)
    super.init(self, x, y)

    properties = properties or {}

    self:setScale(2)

    self.sprite = Sprite("world/events/chestbox")
    self:addChild(self.sprite)

    self:setSize(self.sprite:getSize())
    self:setHitbox(0, 5, self.sprite.width, 12)

    self.inventory = properties["inventory"] or "box_a"

    self.solid = true

    self.cutscene = function(cutscene)
        self.should_open_menu = false
        local choice = cutscene:textChoicer("* Use the box?\n", {"Yes","    No"}, {wait = true})

        if choice == 1 then
            if #Game.inventory:getStorage("items") == 0 and #Game.inventory:getStorage(self.inventory) == 0 then
                local message = {
                    "* You put a little time into\nthe box.",
                    "* You put a little effort\ninto the box.",
                    "* You put a little feeling\ninto the box."
                }
                cutscene:text("* You have no items.\n"..Utils.pick(message))
            else
                self.should_open_menu = true
            end
        end
    end 
end

function StorageBox:onTextEnd()
    if not self.world then return end

    if self.should_open_menu then
        Game.world:closeMenu()
        Game.world:openMenu(LightStorageMenu("items", "box_a"))
    end
end

return StorageBox