g23cd00 = {}
g23cd00_mt = {__index = g23cd00}
function g23cd00.new(_ARG_0_)
  return setmetatable({}, g23cd00_mt)
end
function g23cd00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  Entity.SetMotion(_ARG_0_.myHandle, 0)
end
function g23cd00.OnUpdate(_ARG_0_)
end
EntityFactory:Add("g23cd00", function(_ARG_0_)
  return (g23cd00:new())
end)
EntityFactory:Add("g24cd00", function(_ARG_0_)
  return (g23cd00:new())
end)
