local library_computer, super = Class(Map)

function library_computer:load()
  super:load(self)
end

function library_computer:init(world, data)
  super:init(self, world, data)
  if Game:getFlag("POST_SNOWGRAVE") then
    self.music = nil
  end
end

return library_computer