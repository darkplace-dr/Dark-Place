local RoomFourTransitionC, super = Class(Map)

function RoomFourTransitionC:load()
  super:load(self)
end

function RoomFourTransitionC:onFootstep(chara, num)
  if num == 1 then
    Assets.playSound("step_metal1", 2)
  elseif num == 2 then
    Assets.playSound("step_metal2", 2)
  end
end

return RoomFourTransitionC