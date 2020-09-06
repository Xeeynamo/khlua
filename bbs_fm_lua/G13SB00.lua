g13sb00 = {}
g13sb00_mt = {__index = g13sb00}
function g13sb00.new(_ARG_0_)
  return setmetatable({}, g13sb00_mt)
end
function g13sb00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.isRide = false
  if _UPVALUE0_ == 0 then
    _UPVALUE0_ = 1
  end
end
function g13sb00.OnUpdate(_ARG_0_)
end
EntityFactory:Add("g13sb00", function(_ARG_0_)
  EntityManager:Add(g13sb00:new(), _ARG_0_)
  return (g13sb00:new())
end)
