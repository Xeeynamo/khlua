g18sb00 = {}
g18sb00_mt = {__index = g18sb00}
function g18sb00.new(_ARG_0_)
  return setmetatable({}, g18sb00_mt)
end
function g18sb00.GetLockOnPos(_ARG_0_)
  _ARG_0_.lockOnPos:set(0, 0, 0.2)
  Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "center", _ARG_0_.lockOnPos)
  return _ARG_0_.lockOnPos
end
function g18sb00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.destTime = 0
  _ARG_0_.lockOnPos = FVECTOR3.new(0, 0, 0)
  Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
  Entity.EnableRideColl(_ARG_0_.myHandle, 0, 1)
  if _UPVALUE0_ == 0 then
    _UPVALUE0_ = 1
  end
  Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
  print("param = " .. Entity.GetLayoutParam(_ARG_0_.myHandle, 1) .. "\n")
  if Entity.GetLayoutParam(_ARG_0_.myHandle, 1) ~= 0 then
    _ARG_0_.step = 3
    Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
    Entity.EnableRideColl(_ARG_0_.myHandle, 1, 1)
    Entity.EnableLockon(_ARG_0_.myHandle, 0)
    Entity.EnableRideColl(_ARG_0_.myHandle, 0, 0)
    _ARG_0_:DispSet2()
    Entity.SetMotion(_ARG_0_.myHandle, 0)
  end
end
function g18sb00.OnDamage(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if COMMAND_KIND_BoulderBreake == Entity.GetDamageCommandKind(_ARG_0_.myHandle) then
  end
end
function g18sb00.OnUpdate(_ARG_0_)
  Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
  if _ARG_0_.step == 0 then
    _ARG_0_:DispSet1()
  elseif _ARG_0_.step == 1 then
    if Mission.IsMissionNow() == true and Entity.IsMotionEnd(_ARG_0_.myHandle) then
      _ARG_0_.step = 2
    end
  elseif _ARG_0_.step == 2 then
    _ARG_0_.destTime = _ARG_0_.destTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
    if 0 > _ARG_0_.destTime then
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, "001")
      Entity.EnableLockon(_ARG_0_.myHandle, 0)
      Entity.EnableRideColl(_ARG_0_.myHandle, 0, 0)
      Entity.EnableRideColl(_ARG_0_.myHandle, 1, 1)
      _ARG_0_.step = 3
    end
  elseif _ARG_0_.step == 3 then
    _ARG_0_:DispSet2()
  end
end
function g18sb00.OnDestruction(_ARG_0_, _ARG_1_)
  _ARG_0_.step = 2
  _ARG_0_.destTime = 50
  OPENDAMGE_ON_FLAG_A = 1
end
function g18sb00.OnDead(_ARG_0_)
  return 1
end
function g18sb00.DispSet1(_ARG_0_)
  Entity.EnableModelDisp(_ARG_0_.myHandle, 0, 1)
  Entity.EnableModelDisp(_ARG_0_.myHandle, 1, 1)
  Entity.EnableModelDisp(_ARG_0_.myHandle, 2, 0)
  Entity.EnableModelDisp(_ARG_0_.myHandle, 3, 1)
  Entity.EnableModelDisp(_ARG_0_.myHandle, 4, 0)
  Entity.EnableModelDisp(_ARG_0_.myHandle, 5, 1)
  Entity.EnableModelDisp(_ARG_0_.myHandle, 6, 0)
end
function g18sb00.DispSet2(_ARG_0_)
  Entity.EnableModelDisp(_ARG_0_.myHandle, 0, 0)
  Entity.EnableModelDisp(_ARG_0_.myHandle, 1, 0)
  Entity.EnableModelDisp(_ARG_0_.myHandle, 2, 1)
  Entity.EnableModelDisp(_ARG_0_.myHandle, 3, 0)
  Entity.EnableModelDisp(_ARG_0_.myHandle, 4, 1)
  Entity.EnableModelDisp(_ARG_0_.myHandle, 5, 0)
  Entity.EnableModelDisp(_ARG_0_.myHandle, 6, 1)
end
EntityFactory:Add("g18sb00", function(_ARG_0_)
  return (g18sb00:new())
end)
