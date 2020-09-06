g21sb00 = {}
g21sb00_mt = {__index = g21sb00}
function g21sb00.new(_ARG_0_)
  return setmetatable({}, g21sb00_mt)
end
function g21sb00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.isRide = false
  if _UPVALUE0_ == 0 then
    _UPVALUE1_ = Gimmick.GetExtraParam(_ARG_0_.myHandle, "OpenDist") * Gimmick.GetExtraParam(_ARG_0_.myHandle, "OpenDist")
    print("g21sb_UP_DIST = " .. _UPVALUE1_ .. "\n")
    _UPVALUE2_ = Gimmick.GetExtraParam(_ARG_0_.myHandle, "ShutsDist") * Gimmick.GetExtraParam(_ARG_0_.myHandle, "ShutsDist")
    print("g21sb_DOWN_DIST = " .. _UPVALUE2_ .. "\n")
    _UPVALUE0_ = 1
  end
  Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
end
function g21sb00.OnUpdate(_ARG_0_)
end
function g21sb00.CanMainSkip(_ARG_0_)
  Entity.EnableModelAllDisp(_ARG_0_.myHandle, 1)
  if _ARG_0_.step == 0 then
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, Player.GetHandle()) < _UPVALUE0_ then
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.step = 1
      return false
    end
    Entity.EnableModelAllDisp(_ARG_0_.myHandle, 0)
  elseif _ARG_0_.step == 1 then
    if Entity.IsMotionEnd(_ARG_0_.myHandle) then
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
      _ARG_0_.step = 2
    end
    return false
  elseif _ARG_0_.step == 2 then
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, Player.GetHandle()) > _UPVALUE0_ then
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
      _ARG_0_.step = 3
      return false
    end
  elseif _ARG_0_.step == 3 then
    if Entity.IsMotionEnd(_ARG_0_.myHandle) then
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE4_)
      _ARG_0_.step = 0
    end
    return false
  end
  return true
end
EntityFactory:Add("g21sb00", function(_ARG_0_)
  EntityManager:Add(g21sb00:new(), _ARG_0_)
  return (g21sb00:new())
end)
