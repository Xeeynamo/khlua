g24sb00 = {}
g24sb00_mt = {__index = g24sb00}
function g24sb00.new(_ARG_0_)
  return setmetatable({}, g24sb00_mt)
end
function g24sb00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.isRide = false
  Entity.AttachRideCollision(_ARG_0_.myHandle, 0, 2)
  if _UPVALUE0_ == 0 then
    _UPVALUE0_ = 1
  end
end
function g24sb00.OnUpdate(_ARG_0_)
end
EntityFactory:Add("g24sb00", function(_ARG_0_)
  EntityManager:Add(g24sb00:new(), _ARG_0_)
  return (g24sb00:new())
end)
