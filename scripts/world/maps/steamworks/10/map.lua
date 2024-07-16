local RoomTen, super = Class(Map)

function RoomTen:load()
  super:load(self)
end

function RoomTen:onFootstep(chara, num)
  if num == 1 then
    Assets.playSound("step_metal1", 2)
  elseif num == 2 then
    Assets.playSound("step_metal2", 2)
  end
end

return RoomTen