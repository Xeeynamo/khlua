g52rg00 = {}
g52rg00_base_mt = {__index = __StateMachine}
setmetatable(g52rg00, g52rg00_base_mt)
g52rg00_mt = {__index = g52rg00}
function g52rg00.new(_ARG_0_)
  return setmetatable(__StateMachine:new(), g52rg00_mt)
end
function g52rg00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  Entity.SetMotion(_ARG_0_.myHandle, 0)
end
function g52rg00.OnUpdate(_ARG_0_)
end
EntityFactory:Add("g52rg00", function(_ARG_0_)
  return (g52rg00:new())
end)
