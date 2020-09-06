g10ls00 = {}
g10ls00_mt = {__index = g10ls00}
function g10ls00.new(_ARG_0_)
  return setmetatable({}, g10ls00_mt)
end
function ROUND_PI(_ARG_0_)
  if _ARG_0_ < -PI then
    return _ARG_0_ + PI * 2
  elseif _ARG_0_ > PI then
    return _ARG_0_ - PI * 2
  else
    return _ARG_0_
  end
end
function g10ls00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.targetHandle = NULL_HANDLE
  _ARG_0_.step = 0
  _ARG_0_.FloY = 0
  _ARG_0_.FloupYMin = 4
  _ARG_0_.FloupYMax = 4.1
  _ARG_0_.workTime = 0
  _ARG_0_.RotForce = 0
  _ARG_0_.speed = 0
  _ARG_0_.GravityFlag = 0
  _ARG_0_.effectFlag = 0
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.vRot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.FloPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.StartPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.StartCenterPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
  Entity.GetWorldPos(_ARG_0_.FloPos, _ARG_0_.myHandle)
  Entity.GetWorldPos(_ARG_0_.StartPos, _ARG_0_.myHandle)
  Entity.GetWorldPos(_ARG_0_.StartCenterPos, _ARG_0_.myHandle, 1)
  _ARG_0_.startY = _ARG_0_.FloPos:gety()
  Entity.SetDispOffCameraDistance(_ARG_0_.myHandle, 30)
  _ARG_0_.subRotX = 0
  _ARG_0_.subRotZ = 0
  _ARG_0_.setparam1 = Entity.GetLayoutParam(_ARG_0_.myHandle, 7)
  _ARG_0_.setparam2 = Entity.GetLayoutParam(_ARG_0_.myHandle, 8)
  if 0 < _ARG_0_.setparam1 then
    _ARG_0_.FloupYMin = _ARG_0_.setparam1
  end
  if 0 < _ARG_0_.setparam2 then
    _ARG_0_.FloupYMax = _ARG_0_.setparam1
  end
  Entity.SetMovementCollRadius(_ARG_0_.myHandle, 0.64)
  Entity.SetLowerHalf(_ARG_0_.myHandle, 0.65)
  Entity.EnableBgColl(_ARG_0_.myHandle, 1)
  Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
  Entity.EnableGravity(_ARG_0_.myHandle, 0)
  Entity.EnableLockon(_ARG_0_.myHandle, 1)
  if _UPVALUE0_ == 0 then
    _UPVALUE0_ = 1
  end
  Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle, 1)
  _UPVALUE1_:set(0, _UPVALUE1_:gety() - _ARG_0_.FloPos:gety(), 0)
  Entity.SetCenterOfGravity(_ARG_0_.myHandle, _UPVALUE1_)
  _ARG_0_.vRot:set(DegToRad(0.2 + Script.Random()), DegToRad(0.5 + Script.Random()), DegToRad(0.5 + Script.Random()))
end
function g10ls00.createEffect(_ARG_0_, _ARG_1_, _ARG_2_)
  Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 1)
  _UPVALUE1_:set(0, 0, 0)
  Entity.SetEffect(_ARG_0_.myHandle, _ARG_1_, _ARG_2_, _UPVALUE0_, _UPVALUE1_)
end
function g10ls00.CanMainSkip(_ARG_0_)
  Entity.GetWorldPos(_UPVALUE0_, Player.GetHandle())
  Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
  if _UPVALUE0_:gety() > _UPVALUE1_:gety() + 10 or _UPVALUE0_:gety() < _UPVALUE1_:gety() - 10 then
    return true
  end
  if Entity.GetGravityCoefficient(_ARG_0_.myHandle) >= 1 then
    if _ARG_0_.GravityFlag == 0 then
      Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
      Entity.GetWorldPos(_ARG_0_.FloPos, _ARG_0_.myHandle, 1)
      FVECTOR3.Sub(_UPVALUE0_, _ARG_0_.FloPos, _ARG_0_.StartCenterPos)
      if _ARG_0_.FloPos:gety() < _ARG_0_.StartCenterPos:gety() + 3 then
        _ARG_0_.subRotX = RadToDeg(RoundPI(_ARG_0_.rot:getx())) / ((_UPVALUE0_:length() + 0.1) / _UPVALUE2_)
        _ARG_0_.subRotZ = RadToDeg(RoundPI(_ARG_0_.rot:getz())) / ((_UPVALUE0_:length() + 0.1) / _UPVALUE2_)
      else
        _ARG_0_.GravityFlag = 1
      end
    else
    end
    _ARG_0_.FloY = _ARG_0_.FloY - 0.001
    if _ARG_0_.FloY < -_UPVALUE2_ then
      _ARG_0_.FloY = -_UPVALUE2_
    end
    _UPVALUE0_:set(0, _ARG_0_.FloY, 0)
    Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE0_)
    _ARG_0_.rot:set(HomingDegree(_ARG_0_.rot:getx(), 0, _ARG_0_.subRotX, Entity.GetFrameRate(_ARG_0_.myHandle)), _ARG_0_.rot:gety(), (HomingDegree(_ARG_0_.rot:getz(), 0, _ARG_0_.subRotZ * 2.5, Entity.GetFrameRate(_ARG_0_.myHandle))))
    Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
  else
    _ARG_0_.GravityFlag = 0
    Entity.EnableGravity(_ARG_0_.myHandle, 0)
    Entity.GetWorldPos(_ARG_0_.FloPos, _ARG_0_.myHandle, 1)
    if _ARG_0_.step == 0 then
      if _ARG_0_.FloPos:gety() < _ARG_0_.startY + _ARG_0_.FloupYMin then
        _ARG_0_.FloY = _ARG_0_.FloY + 0.001
        if _ARG_0_.FloY > _UPVALUE2_ then
          _ARG_0_.FloY = _UPVALUE2_
        end
        _UPVALUE0_:set(0, _ARG_0_.FloY, 0)
        Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE0_)
      elseif _ARG_0_.FloPos:gety() > _ARG_0_.startY + _ARG_0_.FloupYMax then
        _ARG_0_.FloY = _ARG_0_.FloY - 0.001
        if _ARG_0_.FloY < -_UPVALUE2_ then
          _ARG_0_.FloY = -_UPVALUE2_
        end
        _UPVALUE0_:set(0, _ARG_0_.FloY, 0)
        Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE0_)
      end
    elseif _ARG_0_.step == ATK_KIND_DMG_SMALL then
      _ARG_0_.speed = HomingDegree(_ARG_0_.speed, 0, 0.05, Entity.GetFrameRate(_ARG_0_.myHandle))
      _ARG_0_.velocity:scale(_ARG_0_.speed)
      Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
    end
    if 0 < _ARG_0_.speed and Entity.IsWall(_ARG_0_.myHandle) then
      Gimmick.Delete(_ARG_0_.myHandle)
      if _ARG_0_.effectFlag == 0 then
        _ARG_0_:createEffect("g_ls_cnta_0", "G_LS_CNT_CRS0_0")
        _ARG_0_.effectFlag = 1
      end
    end
    if 0.1 < _ARG_0_.speed then
      Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 1)
    else
      Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 0)
    end
    Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
    if 1 < _ARG_0_.RotForce then
      _ARG_0_.RotForce = _ARG_0_.RotForce * Math.Pow(0.99, (Entity.GetFrameRate(_ARG_0_.myHandle)))
      _ARG_0_.rot:setx(_ARG_0_.rot:getx() + DegToRad(5) * _ARG_0_.RotForce * Entity.GetFrameRate(_ARG_0_.myHandle))
      _ARG_0_.rot:setx(ROUND_PI(_ARG_0_.rot:getx()))
      _ARG_0_.workTime = _ARG_0_.workTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      _ARG_0_.FloY = 0
    else
      _ARG_0_.speed = 0
      _ARG_0_.step = 0
      _ARG_0_.RotForce = 1
      _UPVALUE0_:set(0, 0, 0)
      FVECTOR3.Scale(_UPVALUE0_, _ARG_0_.vRot, _ARG_0_.RotForce * Entity.GetFrameRate(_ARG_0_.myHandle))
      FVECTOR3.Add(_ARG_0_.rot, _ARG_0_.rot, _UPVALUE0_)
      _ARG_0_.rot:setx(ROUND_PI(_ARG_0_.rot:getx()))
      _ARG_0_.rot:sety(ROUND_PI(_ARG_0_.rot:gety()))
      _ARG_0_.rot:setz(ROUND_PI(_ARG_0_.rot:getz()))
    end
    Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
  end
  return false
end
function g10ls00.OnUpdate(_ARG_0_)
end
function g10ls00.HitBack(_ARG_0_)
  _ARG_0_.speed = 0.5
  _ARG_0_.gravity = 0.3
  _ARG_0_.coefficient = 0.1
  Entity.GetWorldPos(_UPVALUE0_, (Entity.GetAttacker(_ARG_0_.myHandle)))
  Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle, 1)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  FVECTOR3.Sub(_UPVALUE0_, _UPVALUE0_, _UPVALUE1_)
  FVECTOR3.normalize(_UPVALUE0_)
  _ARG_0_.rot:set(0, ROUND_PI(Math.Atan2(_UPVALUE0_:getx(), _UPVALUE0_:getz()) - DegToRad(180)), 0)
  _ARG_0_.velocity:set(0, 0, 1)
  Math.RotateVectorXYZ(_ARG_0_.velocity, _ARG_0_.rot)
  _ARG_0_.velocity:scale(_ARG_0_.speed)
  Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
  Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 1)
  return 1
end
function g10ls00.OnDamage(_ARG_0_, _ARG_1_)
  Entity.ClearSpeed(_ARG_0_.myHandle)
  if Entity.GetGravityCoefficient(_ARG_0_.myHandle) >= 1 then
    if _ARG_1_ == ATK_KIND_DMG_SMALL then
    else
      if _ARG_1_ == ATK_KIND_DMG_BIG or _ARG_1_ == ATK_KIND_DMG_BLOW or _ARG_1_ == ATK_KIND_DMG_TOSS or _ARG_1_ == ATK_KIND_DMG_BEAT or _ARG_1_ == ATK_KIND_DMG_BEAT or _ARG_1_ == ATK_KIND_DMG_FLICK then
        Gimmick.Delete(_ARG_0_.myHandle)
        if _ARG_0_.effectFlag == 0 then
          _ARG_0_:createEffect("g_ls_cnta_0", "G_LS_CNT_CRS0_0")
          _ARG_0_.effectFlag = 1
          elseif _ARG_1_ == ATK_KIND_DMG_SMALL then
            _ARG_0_.RotForce = _ARG_0_.RotForce + 5
            if _ARG_0_.RotForce > 20 then
              _ARG_0_.RotForce = 20
            end
            _ARG_0_.workTime = 180
            _ARG_0_.FloY = 0
          elseif _ARG_1_ == ATK_KIND_DMG_BIG or _ARG_1_ == ATK_KIND_DMG_BLOW or _ARG_1_ == ATK_KIND_DMG_TOSS or _ARG_1_ == ATK_KIND_DMG_BEAT or _ARG_1_ == ATK_KIND_DMG_BEAT or _ARG_1_ == ATK_KIND_DMG_FLICK then
            _ARG_0_.RotForce = 20
            _ARG_0_:HitBack()
            _ARG_0_.workTime = 180
            _ARG_0_.FloY = 0
          else
            _ARG_0_.RotForce = 20
            _ARG_0_.workTime = 180
            _ARG_0_.FloY = 0
          end
        end
      else
      end
    end
  _ARG_0_.step = _ARG_1_
  return 1
end
function g10ls00.onHitBody(_ARG_0_)
  if _ARG_0_.speed > 0 then
    Gimmick.Delete(_ARG_0_.myHandle)
    if _ARG_0_.effectFlag == 0 then
      print("createEffect\n")
      _ARG_0_:createEffect("g_ls_cnta_0", "G_LS_CNT_CRS0_0")
      _ARG_0_.effectFlag = 1
    end
  end
end
function g10ls00.OnDead(_ARG_0_)
  print("OnDead\n")
end
function g10ls00.OnDamageBefore(_ARG_0_)
  return 1
end
function g10ls00.OnDamageBefore(_ARG_0_, _ARG_1_)
  return 1
end
EntityFactory:Add("g10ls00", function(_ARG_0_)
  return (g10ls00:new())
end)
