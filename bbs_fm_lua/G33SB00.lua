g33sb00 = {}
g33sb00_mt = {__index = g33sb00}
function g33sb00.new(_ARG_0_)
  return setmetatable({}, g33sb00_mt)
end
function g33sb00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.warpframe = 0
  _ARG_0_.param = Entity.GetLayoutParam(_ARG_0_.myHandle, 1)
  print("self.param = " .. _ARG_0_.param .. "\n")
  _ARG_0_.frame = 0
  if _ARG_0_.param == 1 then
  end
  if _ARG_0_.param == 7 then
    for _FORV_6_ = 0, 23 do
      if _FORV_6_ >= 0 and _FORV_6_ < 4 then
        Entity.EnableModelDisp(_ARG_0_.myHandle, _FORV_6_, 1)
      else
        Entity.EnableModelDisp(_ARG_0_.myHandle, _FORV_6_, 0)
      end
    end
    _FOR_.EnableModelDisp(_ARG_0_.myHandle, 24, 0)
    Entity.EnableModelDisp(_ARG_0_.myHandle, 25, 0)
    Entity.EnableModelDisp(_ARG_0_.myHandle, 26, 0)
    Entity.EnableModelDisp(_ARG_0_.myHandle, 27, 0)
    Entity.EnableModelDisp(_ARG_0_.myHandle, 28, 0)
    Entity.EnableModelDisp(_ARG_0_.myHandle, 29, 0)
  elseif _ARG_0_.param == 8 then
    for _FORV_6_ = 0, 23 do
      Entity.EnableModelDisp(_ARG_0_.myHandle, _FORV_6_, 0)
    end
    _FOR_.EnableModelDisp(_ARG_0_.myHandle, 24, 1)
    Entity.EnableModelDisp(_ARG_0_.myHandle, 25, 1)
    Entity.EnableModelDisp(_ARG_0_.myHandle, 26, 1)
    Entity.EnableModelDisp(_ARG_0_.myHandle, 27, 1)
    Entity.EnableModelDisp(_ARG_0_.myHandle, 28, 1)
    Entity.EnableModelDisp(_ARG_0_.myHandle, 29, 1)
  else
    for _FORV_6_ = 0, 23 do
      if _FORV_6_ == (_ARG_0_.param - 1) * 4 or _FORV_6_ == (_ARG_0_.param - 1) * 4 + 1 or _FORV_6_ == (_ARG_0_.param - 1) * 4 + 2 or _FORV_6_ == (_ARG_0_.param - 1) * 4 + 3 then
        Entity.EnableModelDisp(_ARG_0_.myHandle, _FORV_6_, 1)
      else
        Entity.EnableModelDisp(_ARG_0_.myHandle, _FORV_6_, 0)
      end
    end
    _FOR_.EnableModelDisp(_ARG_0_.myHandle, 24, 0)
    Entity.EnableModelDisp(_ARG_0_.myHandle, 25, 0)
    Entity.EnableModelDisp(_ARG_0_.myHandle, 26, 0)
    Entity.EnableModelDisp(_ARG_0_.myHandle, 27, 0)
    Entity.EnableModelDisp(_ARG_0_.myHandle, 28, 0)
    Entity.EnableModelDisp(_ARG_0_.myHandle, 29, 0)
  end
  Entity.EnableMarkon(_ARG_1_, 0)
  if _UPVALUE0_ == 0 then
    _UPVALUE0_ = 1
  end
end
function g33sb00.OnUpdate(_ARG_0_)
  if _ARG_0_.param == 7 then
    _ARG_0_.warpframe = _ARG_0_.warpframe + 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
    if Math.Mod(_ARG_0_.warpframe, 480) >= 0 and Math.Mod(_ARG_0_.warpframe, 480) < 240 then
      Entity.EnableModelDisp(_ARG_0_.myHandle, 20, 1)
      Entity.EnableModelDisp(_ARG_0_.myHandle, 21, 1)
      Entity.EnableModelDisp(_ARG_0_.myHandle, 22, 1)
      Entity.EnableModelDisp(_ARG_0_.myHandle, 23, 1)
      Entity.EnableModelDisp(_ARG_0_.myHandle, 12, 0)
      Entity.EnableModelDisp(_ARG_0_.myHandle, 13, 0)
      Entity.EnableModelDisp(_ARG_0_.myHandle, 14, 0)
      Entity.EnableModelDisp(_ARG_0_.myHandle, 15, 0)
    else
      Entity.EnableModelDisp(_ARG_0_.myHandle, 20, 0)
      Entity.EnableModelDisp(_ARG_0_.myHandle, 21, 0)
      Entity.EnableModelDisp(_ARG_0_.myHandle, 22, 0)
      Entity.EnableModelDisp(_ARG_0_.myHandle, 23, 0)
      Entity.EnableModelDisp(_ARG_0_.myHandle, 12, 1)
      Entity.EnableModelDisp(_ARG_0_.myHandle, 13, 1)
      Entity.EnableModelDisp(_ARG_0_.myHandle, 14, 1)
      Entity.EnableModelDisp(_ARG_0_.myHandle, 15, 1)
    end
  end
end
function g33sb00.OnUpdatePositionAfter(_ARG_0_)
  _UPVALUE0_:set(0, DegToRad(-0.8), 0)
  Entity.RotateBoneXYZ(_ARG_0_.myHandle, 3, _UPVALUE0_)
  _UPVALUE0_:set(0, DegToRad(3.6), 0)
  Entity.RotateBoneXYZ(_ARG_0_.myHandle, 2, _UPVALUE0_)
end
EntityFactory:Add("g33sb00", function(_ARG_0_)
  return (g33sb00:new())
end)
