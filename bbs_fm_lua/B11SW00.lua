b11sw00 = {}
b11sw00_base_mt = {__index = __StateMachine}
setmetatable(b11sw00, b11sw00_base_mt)
b11sw00_mt = {__index = b11sw00}
function b11sw00.new(_ARG_0_)
  return setmetatable(__StateMachine:new(), b11sw00_mt)
end
b11sw00.states = {
  Facial_serge_other_self = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.angle = _ARG_0_.id
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      Entity.EnableGravity(_ARG_0_.myHandle, 1)
      Entity.EnableBgColl(_ARG_0_.myHandle, 1)
      Entity.EnableLockon(_ARG_0_.myHandle, 0)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.GetCurrentMotion(_ARG_0_.myHandle) == _UPVALUE0_ then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Entity.Out(_ARG_0_.myHandle)
        end
      elseif Entity.GetCurrentMotion(_ARG_0_.myHandle) == _UPVALUE0_ then
      end
    end
  }
}
function ROUND_PI(_ARG_0_)
  if _ARG_0_ < -PI then
    return _ARG_0_ + PI * 2
  elseif _ARG_0_ > PI then
    return _ARG_0_ - PI * 2
  else
    return _ARG_0_
  end
end
function b11sw00.AllResetFacial(_ARG_0_)
  _ARG_0_.oldAnglx = 0
  _ARG_0_.oldAngly = 0
end
function b11sw00.ResetFacial(_ARG_0_)
  _ARG_0_.oldAnglx = HomingDegree(_ARG_0_.oldAnglx, 0, 2, (Entity.GetFrameRate(_ARG_0_.myHandle)))
end
function b11sw00.ResetFacial_X(_ARG_0_)
  _ARG_0_.oldAnglx = HomingDegree(_ARG_0_.oldAnglx, 0, 1, (Entity.GetFrameRate(_ARG_0_.myHandle)))
end
function b11sw00.Facial(_ARG_0_)
  if _ARG_0_.FacialFlag == B11SW_FACIAL_DIR_TYPE_NOMAL then
  elseif _ARG_0_.FacialFlag == B11SW_FACIAL_DIR_TYPE_PLAYER then
    Entity.GetWorldPos(_ARG_0_.PlayerPos, _ARG_0_.targetHandle, 5)
    Entity.GetWorldPos(_ARG_0_.NeckPos, _ARG_0_.myHandle, 2)
    Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
    FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.PlayerPos, _ARG_0_.NeckPos)
    FVECTOR3.normalize(_ARG_0_.workVec)
    _ARG_0_.oldAngly, _ARG_0_.oldAnglx = HomingDegree(_ARG_0_.oldAngly, Math.Atan2(_ARG_0_.workVec:getx(), _ARG_0_.workVec:getz()) - _ARG_0_.rot:gety(), 5, (Entity.GetFrameRate(_ARG_0_.myHandle))), HomingDegree(_ARG_0_.oldAnglx, -Math.Atan2(_ARG_0_.workVec:gety(), Math.Sqrt(_ARG_0_.workVec:getz() * _ARG_0_.workVec:getz() + _ARG_0_.workVec:getx() * _ARG_0_.workVec:getx())) - _ARG_0_.rot:getx(), 5, (Entity.GetFrameRate(_ARG_0_.myHandle)))
    _ARG_0_.NeckAngle:set(ROUND_PI((HomingDegree(_ARG_0_.oldAnglx, -Math.Atan2(_ARG_0_.workVec:gety(), Math.Sqrt(_ARG_0_.workVec:getz() * _ARG_0_.workVec:getz() + _ARG_0_.workVec:getx() * _ARG_0_.workVec:getx())) - _ARG_0_.rot:getx(), 5, (Entity.GetFrameRate(_ARG_0_.myHandle))))), ROUND_PI((HomingDegree(_ARG_0_.oldAngly, Math.Atan2(_ARG_0_.workVec:getx(), _ARG_0_.workVec:getz()) - _ARG_0_.rot:gety(), 5, (Entity.GetFrameRate(_ARG_0_.myHandle))))), ROUND_PI(_ARG_0_.FalceRotZ))
    Entity.RotateBoneXYZ(_ARG_0_.myHandle, 2, _ARG_0_.NeckAngle)
  elseif _ARG_0_.FacialFlag == B11SW_FACIAL_DIR_TYPE_RESET then
    _ARG_0_.oldAnglx = 0
    _ARG_0_.oldAngly = 0
  elseif _ARG_0_.FacialFlag == B11SW_FACIAL_DIR_TYPE_STOP then
    _ARG_0_.NeckAngle:set(ROUND_PI(_ARG_0_.oldAnglx), 0, ROUND_PI(_ARG_0_.FalceRotZ))
    Entity.RotateBoneXYZ(_ARG_0_.myHandle, 2, _ARG_0_.NeckAngle)
  elseif _ARG_0_.FacialFlag == B11SW_FACIAL_DIR_TYPE_LONGTIME_PLAYER then
    Entity.GetWorldPos(_ARG_0_.PlayerPos, _ARG_0_.targetHandle, 5)
    Entity.GetWorldPos(_ARG_0_.NeckPos, _ARG_0_.myHandle, 2)
    Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
    FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.PlayerPos, _ARG_0_.NeckPos)
    FVECTOR3.normalize(_ARG_0_.workVec)
    _ARG_0_.oldAngly, _ARG_0_.oldAnglx = _ARG_0_.rot:gety(), -Math.Atan2(_ARG_0_.workVec:gety(), Math.Sqrt(_ARG_0_.workVec:getz() * _ARG_0_.workVec:getz() + _ARG_0_.workVec:getx() * _ARG_0_.workVec:getx())) - _ARG_0_.rot:getx()
    _ARG_0_.NeckAngle:set(ROUND_PI(-Math.Atan2(_ARG_0_.workVec:gety(), Math.Sqrt(_ARG_0_.workVec:getz() * _ARG_0_.workVec:getz() + _ARG_0_.workVec:getx() * _ARG_0_.workVec:getx())) - _ARG_0_.rot:getx()), 0, ROUND_PI(_ARG_0_.FalceRotZ))
    if _ARG_0_.NeckAngle:getx() > _ARG_0_.LookMaxMin[1].Max then
      _ARG_0_.NeckAngle:setx(_ARG_0_.LookMaxMin[1].Max)
    end
    if _ARG_0_.NeckAngle:getx() < _ARG_0_.LookMaxMin[1].Min then
      _ARG_0_.NeckAngle:setx(_ARG_0_.LookMaxMin[1].Min)
    end
    Entity.RotateBoneXYZ(_ARG_0_.myHandle, 2, _ARG_0_.NeckAngle)
  elseif _ARG_0_.FacialFlag == B11SW_FACIAL_DIR_TYPE_GIGANTICC then
    Entity.GetWorldPos(_ARG_0_.PlayerPos, _ARG_0_.targetHandle, 5)
    Entity.GetWorldPos(_ARG_0_.NeckPos, _ARG_0_.myHandle, 2)
    Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
    FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.PlayerPos, _ARG_0_.NeckPos)
    FVECTOR3.normalize(_ARG_0_.workVec)
    _ARG_0_.oldAngly, _ARG_0_.oldAnglx = Math.Atan2(_ARG_0_.workVec:getx(), _ARG_0_.workVec:getz()) - _ARG_0_.rot:gety(), -Math.Atan2(_ARG_0_.workVec:gety(), Math.Sqrt(_ARG_0_.workVec:getz() * _ARG_0_.workVec:getz() + _ARG_0_.workVec:getx() * _ARG_0_.workVec:getx())) - _ARG_0_.rot:getx()
    _ARG_0_.NeckAngle:set(ROUND_PI(-Math.Atan2(_ARG_0_.workVec:gety(), Math.Sqrt(_ARG_0_.workVec:getz() * _ARG_0_.workVec:getz() + _ARG_0_.workVec:getx() * _ARG_0_.workVec:getx())) - _ARG_0_.rot:getx()), ROUND_PI(Math.Atan2(_ARG_0_.workVec:getx(), _ARG_0_.workVec:getz()) - _ARG_0_.rot:gety()), ROUND_PI(_ARG_0_.FalceRotZ))
    if _ARG_0_.NeckAngle:getx() > _ARG_0_.LookMaxMin[1].Max then
      _ARG_0_.NeckAngle:setx(_ARG_0_.LookMaxMin[1].Max)
    end
    if _ARG_0_.NeckAngle:getx() < _ARG_0_.LookMaxMin[1].Min then
      _ARG_0_.NeckAngle:setx(_ARG_0_.LookMaxMin[1].Min)
    end
    Entity.RotateBoneXYZ(_ARG_0_.myHandle, 2, _ARG_0_.NeckAngle)
  end
end
function b11sw00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.targetHandle = NULL_HANDLE
  _ARG_0_.AuraEffectHandle = NULL_HANDLE
  _ARG_0_.GridHandle1 = 0
  _ARG_0_.GridHandle2 = 0
  _ARG_0_.InfEffectHndle1 = 0
  _ARG_0_.InfEffectHndle2 = 0
  _ARG_0_.BigEffectHandle = NULL_HANDLE
  _ARG_0_.OldState = 0
  _ARG_0_.angle = 2
  _ARG_0_.targetAngle = 0
  _ARG_0_.cont = 0
  _ARG_0_.ProliferationHandle = {}
  _ARG_0_.Speed = 0
  _ARG_0_.RotationSpeed = 0
  _ARG_0_.targetSpeed = 0
  _ARG_0_.PopFlag = 0
  _ARG_0_.PushFlag = 0
  _ARG_0_.FlowType = 0
  _ARG_0_.ScaleStep = 0
  _ARG_0_.id = 0
  _ARG_0_.MotCangeCnt = 0
  _ARG_0_.FlameRate = 0
  _ARG_0_.PlayerDist = 0
  _ARG_0_.AttackFlag = 0
  _ARG_0_.theta = 0
  _ARG_0_.c = 0
  _ARG_0_.scale = 1
  _ARG_0_.scaleTimer = 0
  _ARG_0_.dstScale = 0
  _ARG_0_.srcScale = 0
  _ARG_0_.ScaleCount = 0
  _ARG_0_.exec = 0
  _ARG_0_.AngY = 0
  _ARG_0_.Gravity = 0
  _ARG_0_.JumpPow = 0
  _ARG_0_.FacialID = 0
  _ARG_0_.MyFacialID = 0
  _ARG_0_.FalceRotZ = 0
  _ARG_0_.FacialFlag = 0
  _ARG_0_.WallFlag = 0
  _ARG_0_.CamFlag = 0
  _ARG_0_.RotationTime = 0
  _ARG_0_.RotationFlag = 0
  _ARG_0_.MoveFlag = 0
  _ARG_0_.Rising_Cnt = 0
  _ARG_0_.Rising_ang_X = Script.Random() * 360 - 180
  _ARG_0_.Rising_ang_Y = Script.Random() * 100 - 50
  _ARG_0_.Rising_ang_Z = Script.Random() * 360 - 180
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkTime = 0
  _ARG_0_.WorkTime2 = 0
  _ARG_0_.work0 = 0
  _ARG_0_.WorkVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkVec2 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
  _ARG_0_.NowScale = FVECTOR3.new(0, 0, 0)
  _ARG_0_.cameraPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.targetRot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.PlayerPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.NeckPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.NeckAngle = FVECTOR3.new(0, 0, 0)
  _ARG_0_.oldAnglx = 0
  _ARG_0_.oldAngly = 0
  _ARG_0_.LookMaxMin = {}
  _ARG_0_.LookMaxMin[0] = {
    Max = DegToRad(90),
    Min = DegToRad(-90)
  }
  _ARG_0_.LookMaxMin[1] = {
    Max = DegToRad(90),
    Min = DegToRad(-90)
  }
  _ARG_0_.stack = Stack:Create()
  if _UPVALUE0_ == false then
    _UPVALUE0_ = true
  end
  Entity.SetMovementCollRadius(_ARG_0_.myHandle, 2)
  Entity.SetLowerHalf(_ARG_0_.myHandle, 2.5)
  Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
  Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
  Entity.EnableLockon(_ARG_0_.myHandle, 0)
  Entity.EnableGravity(_ARG_0_.myHandle, 1)
  Entity.EnableHeavy(_ARG_0_.myHandle, 1)
  Enemy.IsAllEnemyWaiting()
  Entity.SetDropShadowDistance(_ARG_0_.myHandle, 80)
end
function b11sw00.OnDamage(_ARG_0_, _ARG_1_)
  print("OnDamage\n")
  if _ARG_0_:GetState() == "Facial_serge" or _ARG_0_:GetState() == "Facial_serge_other_self" then
    Entity.EnableLockon(_ARG_0_.myHandle, 1)
    return 1
  end
  return 1
end
function b11sw00.OnUpdatePositionAfter(_ARG_0_)
  _ARG_0_:Facial()
end
function b11sw00.OnDead(_ARG_0_)
  return 1
end
function b11sw00.Debug(_ARG_0_)
  if Script.IsDebugCheckAttack() then
    for _FORV_5_, _FORV_6_ in pairs(_UPVALUE0_) do
      if _FORV_6_ == _ARG_0_:GetState() then
        return
      end
    end
    if _UPVALUE0_[Script.GetDebugAttackNumber() + 1] ~= nil then
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      _ARG_0_:GotoState(_UPVALUE0_[Script.GetDebugAttackNumber() + 1])
    end
  end
end
function b11sw00.OnUpdate(_ARG_0_)
  _ARG_0_:Update()
end
EntityFactory:Add("b11sw00", function(_ARG_0_)
  EntityManager:Add(b11sw00:new(), _ARG_0_)
  return (b11sw00:new())
end)
