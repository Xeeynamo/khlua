ms_deadall = {}
ms_deadall_mt = {__index = ms_deadall}
function ms_deadall.new(_ARG_0_)
  return setmetatable({}, ms_deadall_mt)
end
function ms_deadall.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
end
function ms_deadall.OnUpdate(_ARG_0_)
end
function Create_ms_deadall(_ARG_0_)
  return (ms_deadall:new())
end
