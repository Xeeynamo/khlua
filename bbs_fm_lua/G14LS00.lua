g14ls00 = {}
g14ls00_mt = {__index = g14ls00}
function g14ls00.new(_ARG_0_)
  return setmetatable({}, g14ls00_mt)
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
function g14ls00.OnInit(_ARG_0_, _ARG_1_)
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
  _ARG_0_.boxGroundFlag = 0
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.boxRot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.vRot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.FloPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.StartPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.StartCenterPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
  Entity.GetWorldPos(_ARG_0_.FloPos, _ARG_0_.myHandle)
  Entity.GetWorldPos(_ARG_0_.StartPos, _ARG_0_.myHandle)
  Entity.GetWorldPos(_ARG_0_.StartCenterPos, _ARG_0_.myHandle, 1)
  _ARG_0_.startY = _ARG_0_.FloPos:gety()
  _ARG_0_.boxHandle = NULL_HANDLE
  _ARG_0_.uniqueID = Entity.GetLayoutParam(_ARG_0_.myHandle, 9)
  print("UniqueID = " .. _ARG_0_.uniqueID .. "\n")
  _ARG_0_.subRotX = 0
  _ARG_0_.subRotZ = 0
  _ARG_0_.upSpeed = _UPVALUE0_
  if Entity.GetLayoutParam(_ARG_0_.myHandle, 6) ~= 0 then
    _ARG_0_.upSpeed = _UPVALUE0_ * Entity.GetLayoutParam(_ARG_0_.myHandle, 6)
  end
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
  Entity.EnableLockon(_ARG_0_.myHandle, 0)
  if _UPVALUE1_ == 0 then
    _UPVALUE1_ = 1
  end
  Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.myHandle, 1)
  _UPVALUE2_:set(0, _UPVALUE2_:gety() - _ARG_0_.FloPos:gety(), 0)
  Entity.SetCenterOfGravity(_ARG_0_.myHandle, _UPVALUE2_)
  _ARG_0_.vRot:set(DegToRad(0.2 + Script.Random()), DegToRad(0.5 + Script.Random()), DegToRad(0.5 + Script.Random()))
end
function g14ls00.OnUpdate(_ARG_0_)
  if _ARG_0_.uniqueID == 1 then
    _ARG_0_.boxHandle = Gimmick.SearchGimmick(11)
  elseif _ARG_0_.uniqueID == 2 then
    _ARG_0_.boxHandle = Gimmick.SearchGimmick(12)
  end
  _UPVALUE0_:set(0, 0.3, 0)
  Entity.SetLocalPos(_ARG_0_.boxHandle, _UPVALUE0_)
  Entity.SetOldLocalPos(_ARG_0_.boxHandle, _UPVALUE0_)
  Entity.AttachCoord(_ARG_0_.myHandle, "Root", _ARG_0_.boxHandle, "Root")
  Entity.SetRotateMode(_ARG_0_.boxHandle, 6)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  if Entity.IsGround(_ARG_0_.myHandle) then
    if _ARG_0_.boxGroundFla == 0 then
      Entity.EnableMarkon(_ARG_0_.boxHandle, 1)
      if Item.GetTreasureBoxID(_ARG_0_.boxHandle) == -1 then
        print("\149\243\148\160\130h\130c\130\170\149s\144\179\n")
      elseif Item.IsOpenTreasure((Item.GetTreasureBoxID(_ARG_0_.boxHandle))) == false then
        Entity.EnableMarkon(_ARG_0_.boxHandle, 1)
      else
        Entity.EnableMarkon(_ARG_0_.boxHandle, 0)
      end
      _ARG_0_.boxGroundFla = 1
    end
  else
    _ARG_0_.boxGroundFla = 0
    Entity.EnableMarkon(_ARG_0_.boxHandle, 0)
  end
  if 1 <= Entity.GetGravityCoefficient(_ARG_0_.myHandle) then
    if _ARG_0_.GravityFlag == 0 then
      Entity.GetWorldPos(_ARG_0_.FloPos, _ARG_0_.myHandle, 1)
      FVECTOR3.Sub(_UPVALUE0_, _ARG_0_.FloPos, _ARG_0_.StartCenterPos)
      if _ARG_0_.FloPos:gety() < _ARG_0_.StartCenterPos:gety() + 6 then
        _ARG_0_.subRotX = RadToDeg(RoundPI(_ARG_0_.rot:getx())) / ((_UPVALUE0_:length() + 0.1) / _ARG_0_.upSpeed)
        _ARG_0_.subRotZ = RadToDeg(RoundPI(_ARG_0_.rot:getz())) / ((_UPVALUE0_:length() + 0.1) / _ARG_0_.upSpeed)
      else
        _ARG_0_.GravityFlag = 1
      end
    else
    end
    _ARG_0_.FloY = _ARG_0_.FloY - 0.01
    if _ARG_0_.FloY < -_ARG_0_.upSpeed then
      _ARG_0_.FloY = -_ARG_0_.upSpeed
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
        if _ARG_0_.FloY > _ARG_0_.upSpeed then
          _ARG_0_.FloY = _ARG_0_.upSpeed
        end
        _UPVALUE0_:set(0, _ARG_0_.FloY, 0)
        Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE0_)
      elseif _ARG_0_.FloPos:gety() > _ARG_0_.startY + _ARG_0_.FloupYMax then
        _ARG_0_.FloY = _ARG_0_.FloY - 0.001
        if _ARG_0_.FloY < -_ARG_0_.upSpeed then
          _ARG_0_.FloY = -_ARG_0_.upSpeed
        end
        _UPVALUE0_:set(0, _ARG_0_.FloY, 0)
        Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE0_)
      end
    end
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
  _ARG_0_.rot:set(0, _ARG_0_.rot:gety(), 0)
  Entity.SetRot(_ARG_0_.boxHandle, _ARG_0_.rot)
end
function g14ls00.OnDamageBefore(_ARG_0_, _ARG_1_)
  return 1
end
EntityFactory:Add("g14ls00", function(_ARG_0_)
  return (g14ls00:new())
end)
