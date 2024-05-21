local RoomFiveD, super = Class(Map)

function RoomFiveD:load()
  super:load(self)
end

function RoomFiveD:onFootstep(chara, num)
  if num == 1 then
    Assets.playSound("step_metal1", 2)
  elseif num == 2 then
    Assets.playSound("step_metal2", 2)
  end
end

return RoomFiveD