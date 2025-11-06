local map, super = Class(Map)

function map:load()
    super.load(self)
end

function map:onEnter()
    super.onEnter(self)
end

return map
