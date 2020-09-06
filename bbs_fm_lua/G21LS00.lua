g21ls00 = {}
g21ls00_mt = {__index = g21ls00}
function g21ls00.new(_ARG_0_)
  return setmetatable({}, g21ls00_mt)
end
function g21ls00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.targetHandle = 0
  _ARG_0_.step = 0
  _ARG_0_.catchFlag = 0
  _ARG_0_.RotationSpeed = 0
  _ARG_0_.oldAngly = 0
  _ARG_0_.oldAnglx = 0
  _ARG_0_.flag = _UPVALUE0_
  _ARG_0_.workTime = 80
  _ARG_0_.beamVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec2 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.RotFlag = 0
  _ARG_0_.RotState = 0
  _ARG_0_.addAng = 0
  _ARG_0_.addAng2 = 0
  Entity.SetMotion(_ARG_0_.myHandle, 1)
  if _UPVALUE1_ == 0 then
    _UPVALUE2_ = Gimmick.GetExtraParam(_ARG_1_, "MaxRotNum")
    _UPVALUE3_ = Gimmick.GetExtraParam(_ARG_0_.myHandle, "AddRotNum")
    _UPVALUE4_ = Gimmick.GetExtraParam(_ARG_0_.myHandle, "CatchDist")
    _UPVALUE4_ = _UPVALUE4_ * _UPVALUE4_
    _UPVALUE5_ = Gimmick.GetExtraParam(_ARG_0_.myHandle, "OnCatchD")
    _UPVALUE5_ = _UPVALUE5_ * _UPVALUE5_
    _UPVALUE6_ = Gimmick.GetExtraParam(_ARG_0_.myHandle, "SLowSpeed")
    _UPVALUE7_ = Gimmick.GetExtraParam(_ARG_0_.myHandle, "SInsSpeed")
    _UPVALUE8_ = Gimmick.GetExtraParam(_ARG_0_.myHandle, "SHigSpeed")
    _UPVALUE1_ = 1
  end
end
function g21ls00.RotationInit(_ARG_0_)
  _ARG_0_.RotFlag = 0
  _ARG_0_.RotState = 0
  _ARG_0_.flag = 0
  _ARG_0_.addAng = 0
  _ARG_0_.addAng2 = _UPVALUE0_
end
function g21ls00.OnUpdate(_ARG_0_)
  _ARG_0_.targetHandle = Player.GetRbHandle()
  if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _UPVALUE0_ then
    _ARG_0_.catchFlag = 0
  end
  if _ARG_0_.flag == _UPVALUE1_ then
    _ARG_0_.workTime = _ARG_0_.workTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
    if 0 > _ARG_0_.workTime and _ARG_0_.catchFlag == 0 and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE2_ and Entity.IsGround(_ARG_0_.targetHandle) then
      _ARG_0_:RotationInit()
      _ARG_0_.RotFlag = _ARG_0_:WhichRightandLeft()
      _ARG_0_:setBeamFlag(_UPVALUE3_)
      Entity.GetWorldPos(_ARG_0_.workVec, _ARG_0_.myHandle)
      Player.SetRideStateTB(_ARG_0_.workVec, _ARG_0_.RotFlag)
      _ARG_0_.workTime = 600
    end
  elseif _ARG_0_.flag == _UPVALUE3_ then
    if Player.GetGetMgRbPlayerStateTBNotInit() == 1 then
      _ARG_0_:setBeamFlag(_UPVALUE4_)
      if _ARG_0_.RotFlag == _UPVALUE5_ then
        if Player.GetGetMgRbPlayerStateTBNotInit() == 0 then
          _ARG_0_.addAng = DegToRad(_UPVALUE6_) * _UPVALUE7_
        elseif Player.GetGetMgRbPlayerStateTBNotInit() == 1 then
          _ARG_0_.addAng = DegToRad(_UPVALUE6_) * _UPVALUE8_
        else
          _ARG_0_.addAng = DegToRad(_UPVALUE6_) * _UPVALUE9_
        end
      elseif Player.GetGetMgRbPlayerStateTBNotInit() == 0 then
        _ARG_0_.addAng = -(DegToRad(_UPVALUE6_) * _UPVALUE7_)
      elseif Player.GetGetMgRbPlayerStateTBNotInit() == 1 then
        _ARG_0_.addAng = -(DegToRad(_UPVALUE6_) * _UPVALUE8_)
      else
        _ARG_0_.addAng = -(DegToRad(_UPVALUE6_) * _UPVALUE9_)
      end
    end
    _ARG_0_.workTime = _ARG_0_.workTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
    if 0 > _ARG_0_.workTime then
      _ARG_0_:setBeamFlag(_UPVALUE1_)
    end
  elseif _ARG_0_.flag == _UPVALUE4_ then
    _ARG_0_:setBeamFlag(_UPVALUE10_)
  elseif _ARG_0_.flag == _UPVALUE10_ then
    if Player.GetMgRbPlayerStateTB() == 1 then
      _ARG_0_:setBeamFlag(_UPVALUE11_)
      _ARG_0_.workTime = 10
    end
  elseif _ARG_0_.flag == _UPVALUE11_ then
    _ARG_0_.workTime = _ARG_0_.workTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
    if 0 > _ARG_0_.workTime then
      _ARG_0_:setBeamFlag(_UPVALUE12_)
    end
  elseif _ARG_0_.flag == _UPVALUE12_ then
    _ARG_0_.catchFlag = 1
    _ARG_0_:setBeamFlag(_UPVALUE1_)
  end
end
function g21ls00.ROUND_PI(_ARG_0_, _ARG_1_)
  if _ARG_1_ < -PI then
    return _ARG_1_ + PI * 2
  elseif _ARG_1_ > PI then
    return _ARG_1_ - PI * 2
  else
    return _ARG_1_
  end
end
function g21ls00.WhichRightandLeft(_ARG_0_)
  _ARG_0_.workVec2:set(0, 0, 1)
  Entity.GetWorldPos2(_ARG_0_.workVec, _ARG_0_.myHandle, _ARG_0_.workVec2, 2)
  Entity.GetWorldPos(_ARG_0_.workVec1, _ARG_0_.myHandle, 2)
  FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.workVec, _ARG_0_.workVec1)
  FVECTOR3.normalize(_ARG_0_.workVec)
  _ARG_0_.workVec2:set(0, 0, 3)
  Entity.GetWorldPos2(_ARG_0_.workVec, _ARG_0_.targetHandle, _ARG_0_.workVec2, 1)
  Entity.GetWorldPos(_ARG_0_.workVec1, _ARG_0_.myHandle, 2)
  FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.workVec, _ARG_0_.workVec1)
  FVECTOR3.normalize(_ARG_0_.workVec)
  if 0 > Math.Atan2(_ARG_0_.workVec:getx(), _ARG_0_.workVec:getz()) * -1 - Math.Atan2(_ARG_0_.workVec:getx(), _ARG_0_.workVec:getz()) * -1 then
    return _UPVALUE0_
  else
    return _UPVALUE1_
  end
end
function g21ls00.TurnTarget(_ARG_0_)
  if _ARG_0_.flag == _UPVALUE0_ then
    Entity.GetWorldPos(_ARG_0_.workVec1, _ARG_0_.targetHandle, 1)
    Entity.GetWorldPos(_ARG_0_.workVec2, _ARG_0_.myHandle, 2)
    Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
    FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.workVec1, _ARG_0_.workVec2)
    FVECTOR3.normalize(_ARG_0_.workVec)
    _ARG_0_.oldAngly = _ARG_0_:ROUND_PI(Math.Atan2(_ARG_0_.workVec:getx(), _ARG_0_.workVec:getz()) - _ARG_0_.rot:gety())
  elseif _ARG_0_.flag == _UPVALUE1_ then
  elseif _ARG_0_.flag == _UPVALUE2_ then
  elseif _ARG_0_.flag == _UPVALUE3_ or _ARG_0_.flag == _UPVALUE4_ or _ARG_0_.flag == _UPVALUE5_ then
    if _ARG_0_.RotFlag == _UPVALUE6_ then
      if _ARG_0_.addAng > DegToRad(_UPVALUE7_) then
      else
        _ARG_0_.addAng = _ARG_0_.addAng + _ARG_0_.addAng2
      end
      _ARG_0_.oldAngly = _ARG_0_.oldAngly + DegToRad(_ARG_0_.addAng) * Entity.GetFrameRate(_ARG_0_.myHandle)
    elseif _ARG_0_.RotFlag == _UPVALUE8_ then
      if _ARG_0_.addAng < DegToRad(-_UPVALUE7_) then
      else
        _ARG_0_.addAng = _ARG_0_.addAng - _ARG_0_.addAng2
      end
      _ARG_0_.oldAngly = _ARG_0_.oldAngly + DegToRad(_ARG_0_.addAng) * Entity.GetFrameRate(_ARG_0_.myHandle)
    end
  elseif _ARG_0_.flag == _UPVALUE4_ then
  elseif _ARG_0_.flag == _UPVALUE5_ then
  end
  _ARG_0_.beamVec:set(0, _ARG_0_:ROUND_PI(_ARG_0_.oldAngly), 0)
  Entity.RotateBoneXYZ(_ARG_0_.myHandle, 2, _ARG_0_.beamVec)
end
function g21ls00.setBeamFlag(_ARG_0_, _ARG_1_)
  _ARG_0_.flag = _ARG_1_
end
function g21ls00.GetNumber(_ARG_0_)
  return _ARG_0_.addAng * 100000
end
function g21ls00.OnUpdatePositionAfter(_ARG_0_)
  _ARG_0_:TurnTarget()
end
function g21ls00.SetNumber(_ARG_0_)
  return _ARG_0_.flag
end
EntityFactory:Add("g21ls00", function(_ARG_0_)
  return (g21ls00:new())
end)
