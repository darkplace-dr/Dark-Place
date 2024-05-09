local RoomFourC, super = Class(Map)

function RoomFourC:load()
  super:load(self)
end

function RoomFourC:onFootstep(chara, num)
  if num == 1 then
    Assets.playSound("step_metal1", 2)
  elseif num == 2 then
    Assets.playSound("step_metal2", 2)
  end
end

return RoomFourC