g50dp = {}
g50dp_mt = {__index = g50dp}
function g50dp.new(_ARG_0_)
  return setmetatable({}, g50dp_mt)
end
function g50dp.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  Entity.SetMotion(_ARG_0_.myHandle, 0)
  Entity.SetAnimNowFrame(_ARG_0_.myHandle, Script.Random() * Entity.GetMotionTotalFrame(_ARG_0_.myHandle))
end
function g50dp.OnUpdate(_ARG_0_)
end
EntityFactory:Add("g50dp00", function(_ARG_0_)
  return (g50dp:new())
end)
EntityFactory:Add("g51dp00", function(_ARG_0_)
  return (g50dp:new())
end)
