g16ls00 = {}
g16ls00_mt = {__index = g16ls00}
function g16ls00.new(_ARG_0_)
  return setmetatable({}, g16ls00_mt)
end
function g16ls00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.targetHandle = 0
  _ARG_0_.step = 0
  Entity.AttachRideCollision(_ARG_1_, 0, 2)
end
function g16ls00.OnUpdate(_ARG_0_)
end
EntityFactory:Add("g16ls00", function(_ARG_0_)
  return (g16ls00:new())
end)
