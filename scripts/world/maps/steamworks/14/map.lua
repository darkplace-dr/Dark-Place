local RoomFourteen, super = Class(Map)

function RoomFourteen:load()
  super:load(self)
end

function RoomFourteen:onFootstep(chara, num)
  if num == 1 then
    Assets.playSound("step_metal1", 2)
  elseif num == 2 then
    Assets.playSound("step_metal2", 2)
  end
end

return RoomFourteen