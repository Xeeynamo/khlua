g99 = {}
g99_mt = {__index = g99}
function g99.new(_ARG_0_)
  return setmetatable({}, g99_mt)
end
function g99.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.onDeadFlag = 0
  _ARG_0_.Time = 10
  Entity.EnableBgColl(_ARG_1_, 1)
  Entity.EnableLockon(_ARG_1_, 1)
  Entity.EnableShooton(_ARG_1_, 1)
  Entity.EnableDamageColl(_ARG_1_, 0)
end
function g99.OnDead(_ARG_0_)
end
function g99.OnUpdate(_ARG_0_)
end
function CreateEffect(_ARG_0_, _ARG_1_, _ARG_2_)
  Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
  Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
  Entity.SetEffect(_ARG_0_.myHandle, _ARG_1_, _ARG_2_, _UPVALUE0_, _UPVALUE1_)
end
EntityFactory:Add("g99he00", function(_ARG_0_)
  return (g99:new())
end)
