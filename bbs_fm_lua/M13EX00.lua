m13ex00 = {}
m13ex00_base_mt = {__index = __StateMachine}
setmetatable(m13ex00, m13ex00_base_mt)
m13ex00_mt = {__index = m13ex00}
function m13ex00.new(_ARG_0_)
  return setmetatable(__StateMachine:new(), m13ex00_mt)
end
m13ex00.states = {
  Appear = {
    OnBeginState = function(_ARG_0_)
      SetupAppearBegin(_ARG_0_.myHandle, -1, _UPVALUE0_, 1)
    end,
    OnEndState = function(_ARG_0_)
      SetupAppearEnd(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 and Entity.IsModelFade(_ARG_0_.myHandle) == false then
        Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
        _ARG_0_.step = 1
      end
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Waiting = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Enemy.IsAllEnemyWaiting() == false then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Idling = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      if CanDisappear(_ARG_0_.myHandle, _ARG_0_.targetHandle) then
        _ARG_0_:GotoState("Disappear")
        return
      end
      if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) == false then
        Enemy.GetTargetLastRecordedPos(_ARG_0_.playerPos, _ARG_0_.myHandle, _ARG_0_.targetHandle)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.playerPos, 1.5)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Move2")
        end
        return
      end
      if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= ENEMY_COMMON_DISAPPEAR_DIST then
        _ARG_0_:GotoState("Move")
      end
    end
  },
  Move = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
      Entity.EnableAvoidPlayer(_ARG_0_.myHandle, 1)
      Entity.EnableAvoidEnemy(_ARG_0_.myHandle, 1)
      _ARG_0_.rotX = 0
      _ARG_0_.timer = 0
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      Entity.EnableAvoidPlayer(_ARG_0_.myHandle, 0)
      Entity.EnableAvoidEnemy(_ARG_0_.myHandle, 0)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
      if _ARG_0_.timer <= 0 or Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) <= 1 then
        Entity.GetStartPos(_ARG_0_.targetPos, _ARG_0_.myHandle)
        Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
        _ARG_0_.targetPos:sety((_ARG_0_.targetPos:gety()))
        _ARG_0_.workVec0:set(Math.Cos((Script.RandomInRange(-PI, PI))) * (Script.Random() * 10), 0, Math.Sin((Script.RandomInRange(-PI, PI))) * (Script.Random() * 10))
        FVECTOR3.Add(_ARG_0_.targetPos, _ARG_0_.targetPos, _ARG_0_.workVec0)
        Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.myHandle)
        _ARG_0_.targetPos:sety(_ARG_0_.targetPos:gety() + Script.Random() * 2)
        _ARG_0_.timer = Script.RandomInRange(_UPVALUE0_, _UPVALUE0_ * 2)
      end
      _ARG_0_:CalcTargetVelocity(_ARG_0_.targetPos, 1.5, _UPVALUE1_)
      if _ARG_0_.step == 0 then
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE2_ then
          if Script.Random() < 0.4 then
            _ARG_0_:GotoState("Passion")
            return
          elseif Script.Random() >= 0.4 and Script.Random() < 0.6 then
            _ARG_0_.step = 1
          elseif _ARG_0_:GetRecoverTarget() ~= NULL_HANDLE then
            _ARG_0_.targetHandle = _ARG_0_:GetRecoverTarget()
            _ARG_0_:GotoState("Aromatherapy")
            return
          end
        elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) >= _UPVALUE2_ and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE3_ then
          if Script.Random() < 0.5 then
            if _ARG_0_:GetRecoverTarget() ~= NULL_HANDLE then
              _ARG_0_.targetHandle = _ARG_0_:GetRecoverTarget()
              _ARG_0_:GotoState("Aromatherapy")
              return
            end
          else
            _ARG_0_.step = 1
          end
        end
      end
      if CanDisappear(_ARG_0_.myHandle, _ARG_0_.targetHandle) then
        _ARG_0_:GotoState("Disappear")
        return
      end
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Move2 = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
      Entity.EnableAvoidPlayer(_ARG_0_.myHandle, 1)
      Entity.EnableAvoidEnemy(_ARG_0_.myHandle, 1)
      _ARG_0_.rotX = 0
      _ARG_0_.timer = 0
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      Entity.EnableAvoidPlayer(_ARG_0_.myHandle, 0)
      Entity.EnableAvoidEnemy(_ARG_0_.myHandle, 0)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
      if _ARG_0_.timer <= 0 or Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) <= 1 then
        Entity.GetStartPos(_ARG_0_.targetPos, _ARG_0_.myHandle)
        _ARG_0_.workVec0:set(Math.Cos((Script.RandomInRange(-PI, PI))) * (Script.Random() * 20), Script.Random() * 2, Math.Sin((Script.RandomInRange(-PI, PI))) * (Script.Random() * 20))
        FVECTOR3.Add(_ARG_0_.targetPos, _ARG_0_.targetPos, _ARG_0_.workVec0)
        _ARG_0_.timer = Script.RandomInRange(_UPVALUE0_, _UPVALUE0_ * 2)
      end
      _ARG_0_:CalcTargetVelocity(_ARG_0_.targetPos, 1.5, _UPVALUE1_)
      if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) and _ARG_0_.step == 0 then
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE2_ then
          if Script.Random() < 0.4 then
            _ARG_0_:GotoState("Passion")
            return
          elseif Script.Random() >= 0.4 and Script.Random() < 0.6 then
            _ARG_0_.step = 1
          elseif _ARG_0_:GetRecoverTarget() ~= NULL_HANDLE then
            _ARG_0_.targetHandle = _ARG_0_:GetRecoverTarget()
            _ARG_0_:GotoState("Aromatherapy")
            return
          end
        elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) >= _UPVALUE2_ and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE3_ then
          if Script.Random() < 0.5 then
            if _ARG_0_:GetRecoverTarget() ~= NULL_HANDLE then
              _ARG_0_.targetHandle = _ARG_0_:GetRecoverTarget()
              _ARG_0_:GotoState("Aromatherapy")
              return
            end
          else
            _ARG_0_.step = 1
          end
        end
      end
      if CanDisappear(_ARG_0_.myHandle, _ARG_0_.targetHandle) then
        _ARG_0_:GotoState("Disappear")
        return
      end
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Aromatherapy = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.rotX = 0
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 0)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        Entity.GetWorldPos(_ARG_0_.workVec3, _ARG_0_.targetHandle)
        _ARG_0_:CalcTargetVelocity(_ARG_0_.workVec3, 5, 0.1)
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.workVec3) <= 4 then
          Entity.ClearSpeed(_ARG_0_.myHandle)
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 35 then
          Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.targetHandle, 2)
          Enemy.SetGeneralPurposeAttackCollPos(_ARG_0_.myHandle, _ARG_0_.workVec0, _ARG_0_.workVec0)
          Enemy.SetGeneralPurposeAttackColl(_ARG_0_.myHandle, COLL_KIND_NO_CHECK, COLL_SHAPE_SPHERE, 0.01)
          Enemy.SetGeneralPurposeAttackCollParam(_ARG_0_.myHandle, Enemy.GetAttackKind(_ARG_0_.myHandle, 0), Enemy.GetAttackAttr(_ARG_0_.myHandle, 0), Enemy.GetAttackPoint(_ARG_0_.myHandle, 0), Enemy.GetAttackPowerCorrection(_ARG_0_.myHandle, 0))
          Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 1)
          _ARG_0_.step = 2
        end
      else
        Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.targetHandle, 2)
        _ARG_0_.workVec1:copy(_ARG_0_.workVec0)
        _ARG_0_.workVec1:sety(_ARG_0_.workVec1:gety() - 0.01)
        Enemy.SetGeneralPurposeAttackCollPos(_ARG_0_.myHandle, _ARG_0_.workVec0, _ARG_0_.workVec1)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Stiff")
        end
      end
    end
  },
  PoisonRush = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      _ARG_0_.workVec0:set(Math.Cos((RoundPI(DegToRad((Script.Random() - Script.Random()) * 360)))) * (Script.Random() * 5), Script.Random() * 2.5, Math.Sin((RoundPI(DegToRad((Script.Random() - Script.Random()) * 360)))) * (Script.Random() * 5))
      FVECTOR3.Add(_ARG_0_.targetPos, _ARG_0_.targetPos, _ARG_0_.workVec0)
      Entity.SetTimer(_ARG_0_.myHandle, 180)
      _ARG_0_.step = 0
      _ARG_0_.angle = 0
      _ARG_0_.flag = false
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        _ARG_0_:CalcTargetVelocity(_ARG_0_.targetPos, 2.5, _UPVALUE0_)
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) <= 1 or Entity.IsTimeOver(_ARG_0_.myHandle) then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
          _ARG_0_.velocity:set(0, 0.2, 0)
          Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
          Entity.SetTimer(_ARG_0_.myHandle, 60)
          Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 then
        Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
        Entity.GetWorldPos(_ARG_0_.playerPos, _ARG_0_.targetHandle, 2)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.playerPos, 30)
        if Entity.IsTimeOver(_ARG_0_.myHandle) or _ARG_0_.playerPos:gety() - _ARG_0_.myPos:gety() >= 3 or 0 >= _ARG_0_.playerPos:gety() - _ARG_0_.myPos:gety() then
          FVECTOR3.Sub(_ARG_0_.velocity, _ARG_0_.playerPos, _ARG_0_.myPos)
          Entity.SetTimer(_ARG_0_.myHandle, (_ARG_0_.velocity:length() + 2.5) / _UPVALUE2_)
          Entity.SetRot(_ARG_0_.myHandle, 0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle), 0)
          Entity.ClearSpeed(_ARG_0_.myHandle)
          _ARG_0_.velocity:normalize()
          _ARG_0_.axis:copy(_ARG_0_.velocity)
          _ARG_0_.velocity:scale(_UPVALUE2_)
          _ARG_0_.angle = 0
          _ARG_0_.flag = true
          _ARG_0_.step = 2
        end
      elseif _ARG_0_.step == 2 then
        if Enemy.isBind(_ARG_0_.myHandle) == 0 then
          Entity.RotateAxis(_ARG_0_.myHandle, _ARG_0_.axis, _ARG_0_.angle, _ARG_0_.radius, _ARG_0_.myPos)
          _ARG_0_.angle = RoundPI(_ARG_0_.angle + DegToRad(_UPVALUE3_ * Entity.GetFrameRate(_ARG_0_.myHandle)))
          FVECTOR3.Scale(_ARG_0_.workVec0, _ARG_0_.velocity, (Entity.GetFrameRate(_ARG_0_.myHandle)))
          FVECTOR3.Add(_ARG_0_.myPos, _ARG_0_.myPos, _ARG_0_.workVec0)
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_.flag = false
          _ARG_0_.step = 3
        end
      elseif _ARG_0_.step == 3 and _ARG_0_:TurnX(0, 10) == false then
        _ARG_0_:GotoState("Stiff")
      end
    end
  },
  DrainMist = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetAACNoUpdateAttackID(_ARG_0_.myHandle, 1)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      _ARG_0_.step = 0
      _ARG_0_.drainMistSuccess = false
    end,
    OnEndState = function(_ARG_0_)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        if Entity.GetFloorDistance(_ARG_0_.myHandle) > 1.5 then
          Entity.ClearSpeed(_ARG_0_.myHandle)
        else
          _ARG_0_.velocity:set(0, 0.025, 0)
          Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
        end
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 17 then
          Entity.ClearSpeed(_ARG_0_.myHandle)
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        if _ARG_0_.drainMistSuccess then
          _ARG_0_.step = 2
          _ARG_0_.count = 0
          Entity.SetTimer(_ARG_0_.myHandle, 0)
        elseif Entity.IsTimeOver(_ARG_0_.myHandle) then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
          _ARG_0_.step = 3
        end
      elseif _ARG_0_.step == 2 then
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_.count = _ARG_0_.count + 1
          Entity.SetTimer(_ARG_0_.myHandle, 10)
          Entity.CreatePrize(_ARG_0_.drainMistHandle, 7, 1, _ARG_0_.myHandle, "hara", 0.05)
          if _ARG_0_.count >= 3 then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
            _ARG_0_.step = 3
          end
        end
      elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Stiff")
      end
    end
  },
  Passion = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 0)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("DrainMist")
      end
    end
  },
  Stiff = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Disappear = {
    OnBeginState = function(_ARG_0_)
      SetupDisappear(_ARG_0_.myHandle, 30)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsModelFade(_ARG_0_.myHandle) == false then
        Enemy.Disappear(_ARG_0_.myHandle)
      end
    end
  }
}
function m13ex00.TurnX(_ARG_0_, _ARG_1_, _ARG_2_)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  _ARG_0_.rot:setx(HomingDegree(_ARG_0_.rot:getx(), _ARG_1_, _ARG_2_, Entity.GetFrameRate(_ARG_0_.myHandle)))
  Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
  return HomingDegree(_ARG_0_.rot:getx(), _ARG_1_, _ARG_2_, Entity.GetFrameRate(_ARG_0_.myHandle))
end
function m13ex00.IsTargetWithinFOV(_ARG_0_)
  _ARG_0_.workVec0:set(0, 1, 0)
  if Entity.IsTargetWithinFOV(_ARG_0_.myHandle, _ARG_0_.targetHandle, DegToRad(180), 2, _ARG_0_.workVec0) == false then
    return false
  end
  return true
end
function m13ex00.CalcTargetVelocity(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.myHandle)
  FVECTOR3.Sub(_ARG_0_.workVec1, _ARG_1_, _ARG_0_.workVec0)
  _ARG_0_.workVec1:normalize()
  FVECTOR3.Mul(_ARG_0_.workVec2, _ARG_0_.workVec1, _ARG_0_.workVec1)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  _ARG_0_.rot:sety(HomingDegree(_ARG_0_.rot:gety(), Math.Atan2(_ARG_0_.workVec1:getx(), _ARG_0_.workVec1:getz()), _ARG_2_, (Entity.GetFrameRate(_ARG_0_.myHandle))))
  Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
  _ARG_0_.rotX = HomingDegree(_ARG_0_.rotX, -Math.Atan2(_ARG_0_.workVec1:gety(), Math.Sqrt(_ARG_0_.workVec2:getx() + _ARG_0_.workVec2:getz())), _ARG_2_, (Entity.GetFrameRate(_ARG_0_.myHandle)))
  _ARG_0_.rot:setx(_ARG_0_.rotX)
  _ARG_0_.velocity:set(0, 0, _ARG_3_)
  Math.RotateVectorXYZ(_ARG_0_.velocity, _ARG_0_.rot)
  Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
end
function m13ex00.GetRecoverTarget(_ARG_0_)
  if Enemy.IsConfuse(_ARG_0_.myHandle) == false then
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, (Enemy.SearchEnemy(_ARG_0_.myHandle, "", SEARCH_TYPE_HP_FEWEST))) <= ENEMY_COMMON_DISAPPEAR_DIST then
      return (Enemy.SearchEnemy(_ARG_0_.myHandle, "", SEARCH_TYPE_HP_FEWEST))
    end
    return NULL_HANDLE
  end
  return Player.GetNearestPlayer()
end
function m13ex00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  if _UPVALUE0_ == false then
    _UPVALUE0_ = true
    _UPVALUE1_ = Enemy.GetExtraParam(_ARG_1_, "MoveSpeed")
    _UPVALUE2_ = Enemy.GetExtraParam(_ARG_1_, "PRSpd")
    _UPVALUE3_ = Enemy.GetExtraParam(_ARG_1_, "PRRotSpd")
    _UPVALUE4_ = Enemy.GetExtraParam(_ARG_1_, "PRRadius")
  end
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
  _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.playerPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.axis = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec0 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec2 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec3 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.step = 0
  _ARG_0_.targetHandle = NULL_HANDLE
  _ARG_0_.rotX = 0
  _ARG_0_.flag = false
  _ARG_0_.angle = 0
  _ARG_0_.radius = _UPVALUE4_
  _ARG_0_.drainMistSuccess = false
  _ARG_0_.rotDir = 1
  _ARG_0_.timer = 0
  _ARG_0_.count = 0
  _ARG_0_.drainMistHandle = NULL_HANDLE
  Entity.SetMovementCollRadius(_ARG_0_.myHandle, 0.75)
  Entity.SetLowerHalf(_ARG_0_.myHandle, 1.25)
  if Enemy.IsAllEnemyWaiting() then
    _ARG_0_:GotoState("Waiting")
  else
    _ARG_0_:GotoState("Appear")
  end
end
function m13ex00.OnHitAttack(_ARG_0_, _ARG_1_, _ARG_2_)
  if _ARG_0_:GetState() == "Aromatherapy" then
    Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 0)
  elseif _ARG_0_:GetState() == "DrainMist" then
    if _ARG_0_.drainMistSuccess == false then
      _ARG_0_.drainMistSuccess = true
      _ARG_0_.drainMistHandle = _ARG_1_
    end
    Enemy.AddHp(_ARG_0_.myHandle, _ARG_2_)
  end
end
function m13ex00.OnDamage(_ARG_0_, _ARG_1_, _ARG_2_)
  _ARG_0_.flag = false
  Entity.GetRot(_ARG_0_.workVec0, _ARG_0_.myHandle)
  _ARG_0_.workVec0:setx(0)
  Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.workVec0)
  return 0
end
function m13ex00.OnReturnDamage(_ARG_0_)
  _ARG_0_:GotoState("PoisonRush")
end
function m13ex00.OnUpdatePositionAfter(_ARG_0_)
  if _ARG_0_.flag then
    _ARG_0_.workVec0:set(0, _ARG_0_.angle, 0)
    Entity.RotateBoneXYZ(_ARG_0_.myHandle, 2, _ARG_0_.workVec0)
  end
end
function m13ex00.OnUpdate(_ARG_0_)
  if Entity.IsAlive(_ARG_0_.targetHandle) == false then
    _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
  end
  _ARG_0_:Update()
  _ARG_0_:Debug()
end
function m13ex00.Debug(_ARG_0_)
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
EntityFactory:Add("m13ex00", function(_ARG_0_)
  return (m13ex00:new())
end)
EntityFactory:Add("m13vs00", function(_ARG_0_)
  return (m13ex00:new())
end)
