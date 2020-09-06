g18ls00 = {}
g18ls00_mt = {__index = g18ls00}
function g18ls00.new(_ARG_0_)
  return setmetatable({}, g18ls00_mt)
end
function g18ls00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.step2 = 0
  _ARG_0_.FloY = 0
  _ARG_0_.FloupY = 4
  _ARG_0_.SpeedCoef = 1
  _ARG_0_.NowMaxSpeed = 0
  _ARG_0_.WorkCnt = 0
  Entity.EnableRideColl(_ARG_1_, 0, 1)
  _ARG_0_.FloPos = FVECTOR3.new(0, 0, 0)
  Entity.GetWorldPos(_ARG_0_.FloPos, _ARG_0_.myHandle)
  _ARG_0_.startY = _ARG_0_.FloPos:gety()
  Entity.EnableGravity(_ARG_0_.myHandle, 0)
  Entity.EnableBgColl(_ARG_0_.myHandle, 1)
  _ARG_0_.FloupY = Entity.GetLayoutParam(_ARG_1_, 5) - 1
  _ARG_0_.workVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.SpeedCoef = Entity.GetLayoutParam(_ARG_1_, 6)
  if G11SB_PARAM_FLAG == 0 then
    _UPVALUE0_ = Entity.GetLayoutParam(_ARG_1_, 5)
    _UPVALUE1_ = 1
  end
  Entity.SetDropShadowDistance(_ARG_0_.myHandle, 6400)
  Entity.FixDropShadowBgPos(_ARG_0_.myHandle, false)
  Entity.SetDispOffCameraDistance(_ARG_0_.myHandle, -1)
end
function g18ls00.OnUpdate(_ARG_0_)
  Entity.GetWorldPos(_ARG_0_.FloPos, _ARG_0_.myHandle)
  Entity.SetDropShadowDensity(_ARG_0_.myHandle, 1 - 0.025 * _ARG_0_.FloPos:gety())
  if 1 <= Entity.GetGravityCoefficient(_ARG_0_.myHandle) then
    _ARG_0_.step = 0
    if _ARG_0_.FloPos:gety() < 0.2 then
      Entity.EnableRideColl(_ARG_0_.myHandle, 0, 1)
      Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
    elseif _ARG_0_.FloPos:gety() < 6 then
      Entity.EnableRideColl(_ARG_0_.myHandle, 1, 1)
      Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
    end
    if _ARG_0_.step2 == 0 then
      if _ARG_0_.FloPos:gety() >= _ARG_0_.startY + 1 then
        _ARG_0_.FloY = _ARG_0_.FloY - 0.001 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.FloY < -(_UPVALUE0_ * _ARG_0_.SpeedCoef) then
          _ARG_0_.FloY = -(_UPVALUE0_ * _ARG_0_.SpeedCoef)
        else
        end
        _UPVALUE1_:set(0, _ARG_0_.FloY, 0)
        Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE1_)
        _ARG_0_.NowMaxSpeed = _UPVALUE0_ * _ARG_0_.SpeedCoef
      else
        _ARG_0_.step2 = 1
        _ARG_0_.FloY = _ARG_0_.NowMaxSpeed
        _ARG_0_.WorkCnt = 0
      end
    elseif _ARG_0_.step2 == 1 then
      _ARG_0_.WorkCnt = _ARG_0_.WorkCnt + 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      _ARG_0_.FloY = _ARG_0_.NowMaxSpeed * (_ARG_0_.FloPos:gety() - _ARG_0_.startY)
      if 0 < _ARG_0_.FloY then
        _ARG_0_.FloY = -0.01
      end
      _UPVALUE1_:set(0, _ARG_0_.FloY, 0)
      Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE1_)
    end
  elseif _ARG_0_.step == 0 then
    Entity.EnableRideColl(_ARG_0_.myHandle, 0, 1)
    Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
    _ARG_0_.FloY = 0
    _ARG_0_.step = 1
    _ARG_0_.step2 = 0
  else
    if _ARG_0_.step == 1 then
      if _ARG_0_.FloPos:gety() < _ARG_0_.FloupY then
        _ARG_0_.FloY = _ARG_0_.FloY + 0.001 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.FloY > _UPVALUE0_ * _ARG_0_.SpeedCoef then
          _ARG_0_.FloY = _UPVALUE0_ * _ARG_0_.SpeedCoef
        end
        _UPVALUE1_:set(0, _ARG_0_.FloY, 0)
        Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE1_)
      elseif _ARG_0_.FloPos:gety() > _ARG_0_.FloupY then
        _ARG_0_.FloY = _ARG_0_.FloY - 5.0E-4 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if 0 > _ARG_0_.FloY then
          _ARG_0_.FloY = 0
          _ARG_0_.step = 1
          Entity.ClearSpeed(_ARG_0_.myHandle)
        end
        _UPVALUE1_:set(0, _ARG_0_.FloY, 0)
        Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE1_)
      end
    else
    end
  end
end
EntityFactory:Add("g18ls00", function(_ARG_0_)
  return (g18ls00:new())
end)
