g15ls00 = {}
g15ls00_mt = {__index = g15ls00}
function g15ls00.new(_ARG_0_)
  return setmetatable({}, g15ls00_mt)
end
function g15ls00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.targetHandle = 0
  _ARG_0_.step = 0
  _ARG_0_.AddY = 0
  _ARG_0_.AddPow = 0
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
  Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
  _ARG_0_.startY = _UPVALUE0_:gety()
  _ARG_0_.setparam1 = Entity.GetLayoutParam(_ARG_0_.myHandle, 1)
  _ARG_0_.setparam2 = Entity.GetLayoutParam(_ARG_0_.myHandle, 2)
  if _ARG_0_.setparam2 == 0 then
    _ARG_0_.setparam2 = 1
  end
  _ARG_0_.setparam3 = Entity.GetLayoutParam(_ARG_0_.myHandle, 3)
  if _ARG_0_.setparam3 == 1 then
    _ARG_0_.step = 2
    Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
    _UPVALUE1_:sety(_ARG_0_.startY + _UPVALUE2_ * _ARG_0_.setparam2)
    Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE1_)
  else
    _ARG_0_.step = 5
  end
  Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE3_)
  _ARG_0_.setparam5 = Entity.GetLayoutParam(_ARG_0_.myHandle, 5)
  if _ARG_0_.setparam5 == 0 then
    _ARG_0_.setparam5 = _UPVALUE4_
  else
    _UPVALUE5_ = _UPVALUE5_ * (_ARG_0_.setparam5 / _UPVALUE4_)
  end
  Entity.SetMovementCollRadius(_ARG_0_.myHandle, 0.64)
  Entity.SetLowerHalf(_ARG_0_.myHandle, 0.65)
  Entity.EnableBgColl(_ARG_0_.myHandle, 0)
  Entity.EnableGravity(_ARG_0_.myHandle, 0)
  if _UPVALUE6_ == 0 then
    _UPVALUE3_ = Gimmick.GetExtraParam(_ARG_0_.myHandle, "StandbyT") * 60
    _UPVALUE6_ = 1
  end
end
function g15ls00.UpInit(_ARG_0_)
  _ARG_0_.AddPow = 0
  _ARG_0_.AddY = 0
end
function g15ls00.DownInit(_ARG_0_)
  _ARG_0_.AddPow = 0
  _ARG_0_.AddY = 0
end
function g15ls00.OnUpdate(_ARG_0_)
  if _ARG_0_.step == 0 then
    _ARG_0_.AddPow = _ARG_0_.AddPow + _UPVALUE0_ * Entity.GetFrameRate(_ARG_0_.myHandle)
    if _ARG_0_.AddPow > _ARG_0_.setparam5 then
      _ARG_0_.AddPow = _ARG_0_.setparam5
    end
    _UPVALUE1_:set(0, _ARG_0_.AddPow, 0)
    Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE1_)
    _ARG_0_.AddY = _ARG_0_.AddY + _ARG_0_.AddPow
    Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.myHandle)
    if _UPVALUE2_:gety() > _ARG_0_.startY + (_UPVALUE3_ * _ARG_0_.setparam2 - 0.5) then
      _ARG_0_.step = 1
    end
  elseif _ARG_0_.step == 1 then
    _ARG_0_.AddPow = _ARG_0_.AddPow - _UPVALUE0_ * Entity.GetFrameRate(_ARG_0_.myHandle)
    if _ARG_0_.AddPow > _ARG_0_.setparam5 then
      _ARG_0_.AddPow = _ARG_0_.setparam5
    end
    _UPVALUE1_:set(0, _ARG_0_.AddPow, 0)
    Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE1_)
    Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.myHandle)
    if _UPVALUE2_:gety() >= _ARG_0_.startY + _UPVALUE3_ * _ARG_0_.setparam2 then
      _ARG_0_.step = 2
      _UPVALUE2_:sety(_ARG_0_.startY + _UPVALUE3_ * _ARG_0_.setparam2)
      Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE2_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE4_)
    end
  elseif _ARG_0_.step == 2 then
    Entity.ClearSpeed(_ARG_0_.myHandle)
    if Entity.IsTimeOver(_ARG_0_.myHandle) then
      _ARG_0_:DownInit()
      _ARG_0_.step = 3
    end
  elseif _ARG_0_.step == 3 then
    _ARG_0_.AddPow = _ARG_0_.AddPow - _UPVALUE0_ * Entity.GetFrameRate(_ARG_0_.myHandle)
    if _ARG_0_.AddPow < -_ARG_0_.setparam5 then
      _ARG_0_.AddPow = -_ARG_0_.setparam5
    end
    _UPVALUE1_:set(0, _ARG_0_.AddPow, 0)
    Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE1_)
    _ARG_0_.AddY = _ARG_0_.AddY + _ARG_0_.AddPow
    Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.myHandle)
    if _UPVALUE2_:gety() < _ARG_0_.startY + 0.5 then
      _ARG_0_.step = 4
    end
  elseif _ARG_0_.step == 4 then
    _ARG_0_.AddPow = _ARG_0_.AddPow + _UPVALUE0_ * Entity.GetFrameRate(_ARG_0_.myHandle)
    if _ARG_0_.AddPow < -_ARG_0_.setparam5 then
      _ARG_0_.AddPow = -_ARG_0_.setparam5
    end
    _UPVALUE1_:set(0, _ARG_0_.AddPow, 0)
    Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE1_)
    Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.myHandle)
    if _UPVALUE2_:gety() <= _ARG_0_.startY or Entity.IsGround(_ARG_0_.myHandle) then
      _ARG_0_.step = 5
      _UPVALUE2_:sety(_ARG_0_.startY)
      Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE2_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE4_)
    end
  elseif _ARG_0_.step == 5 then
    Entity.ClearSpeed(_ARG_0_.myHandle)
    if Entity.IsTimeOver(_ARG_0_.myHandle) then
      _ARG_0_:UpInit()
      _ARG_0_.step = 0
    end
  end
end
function g15ls00.CanMainSkip(_ARG_0_)
  if _ARG_0_.setparam1 == 1 then
    return false
  end
  return true
end
EntityFactory:Add("g15ls00", function(_ARG_0_)
  return (g15ls00:new())
end)
