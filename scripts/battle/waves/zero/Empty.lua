local Empty, super = Class(Wave)

function Empty:init()
    super.init(self)
    self.time = -1

end

function Empty:onStart()

end

function Empty:update()
    -- Code here gets called every frame
    super.update(self)
end

function Empty:draw()

end

return Empty