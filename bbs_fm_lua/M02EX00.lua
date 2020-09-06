m02ex00 = {}
m02ex00_base_mt = {__index = __StateMachine}
setmetatable(m02ex00, m02ex00_base_mt)
m02ex00_mt = {__index = m02ex00}
function m02ex00.new(_ARG_0_)
  return setmetatable(__StateMachine:new(), m02ex00_mt)
end
m02ex00.states = {
  Appear = {
    OnBeginState = function(_ARG_0_)
      SetupAppearBegin(_ARG_0_.myHandle, 1, _UPVALUE0_, 0)
      _ARG_0_.NowMotionID = _UPVALUE0_
    end,
    OnEndState = function(_ARG_0_)
      SetupAppearEnd(_ARG_0_.myHandle)
      _ARG_0_.step = 99
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 35 then
        _ARG_0_.step = 99
      end
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        if Script.Random() < _UPVALUE0_ / _ARG_0_.GameLevel then
          _ARG_0_:GotoState("Uneasiness")
          return
        end
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Idling = {
    OnBeginState = function(_ARG_0_)
      if _ARG_0_.NowMotionID == _UPVALUE0_ then
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      else
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.NowMotionID = _UPVALUE0_
      end
      if _ARG_0_.step == 99 then
        Entity.SetAnimNowFrame(_ARG_0_.myHandle, Script.Random() * Entity.GetMotionTotalFrame(_ARG_0_.myHandle))
      end
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_ + Script.Random() * 1)
      _ARG_0_.step = 0
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      Enemy.SetAimPersistenceTime(_ARG_0_.myHandle, 600)
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      _ARG_0_.step = 0
      if _ARG_0_.UneasinessCnt > _UPVALUE0_ then
        _ARG_0_.UneasinessCnt = 0
      end
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > _UPVALUE0_ and Entity.GetMotionNowFrame(_ARG_0_.myHandle) < _UPVALUE0_ + 6 then
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        Enemy.GetTargetLastRecordedPos(_ARG_0_.targetPos, _ARG_0_.myHandle, _ARG_0_.targetHandle)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 30)
      end
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        if _ARG_0_.UneasinessCnt < _UPVALUE1_ and Script.Random() < _UPVALUE2_ / _ARG_0_.GameLevel then
          _ARG_0_:GotoState("Uneasiness")
          return
        end
        if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) == false then
          _ARG_0_:GotoState("Wander")
          return
        end
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE3_ or Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE4_ then
          _ARG_0_.Movetime = _UPVALUE5_ + Script.Random() * _UPVALUE5_
          _ARG_0_.TargetVec:set(Script.Random() * 8 * 2 - 8, 0, 8)
          Entity.GetWorldPos2(_ARG_0_.TargetVec, _ARG_0_.myHandle, _ARG_0_.TargetVec)
          _ARG_0_.Angle = 3
          _ARG_0_.StrollCnt = Script.Random() * 2 + 1
          _ARG_0_.step = 1
          _ARG_0_.MoveFlag = _UPVALUE6_
          _ARG_0_:GotoState("Move")
          return
        elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE7_ then
          _ARG_0_:GotoState("Move")
          return
        elseif CanDisappear(_ARG_0_.myHandle, _ARG_0_.targetHandle) == true then
          _ARG_0_:GotoState("Disappear")
          return
        end
      end
    end
  },
  Search = {
    OnBeginState = function(_ARG_0_)
      if _ARG_0_.NowMotionID == _UPVALUE0_ then
      else
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.NowMotionID = _UPVALUE0_
      end
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_ / _ARG_0_.GameLevel)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        if _ARG_0_.step == 0 then
        end
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Uneasiness = {
    OnBeginState = function(_ARG_0_)
      if _ARG_0_.NowMotionID == _UPVALUE0_ then
      else
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.NowMotionID = _UPVALUE0_
      end
      _ARG_0_.UneasinessCnt = _ARG_0_.UneasinessCnt + 1
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Uneasiness_End")
      end
    end
  },
  Uneasiness_End = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Back = {
    OnBeginState = function(_ARG_0_)
      if _ARG_0_.NowMotionID == _UPVALUE0_ then
      else
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.NowMotionID = _UPVALUE0_
      end
      Entity.SetTimer(_ARG_0_.myHandle, Entity.GetMotionTotalFrame(_ARG_0_.myHandle))
      _ARG_0_.MoveFlag = _UPVALUE1_
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      _ARG_0_.MoveFlag = _UPVALUE0_
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsTimeOver(_ARG_0_.myHandle) and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_.step = _ARG_0_.step + 1
        if Script.Random() < _UPVALUE0_ * _ARG_0_.GameLevel and _ARG_0_.step <= 1 then
          if Script.Random() < _UPVALUE1_ then
            _ARG_0_:GotoState("Attack1")
          elseif Script.Random() < _UPVALUE2_ * 2 then
            _ARG_0_:GotoState("Attack2")
          else
            _ARG_0_:GotoState("Back")
          end
        else
          _ARG_0_:GotoState("Attack3")
        end
        return
      end
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
      FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _UPVALUE3_)
      Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
    end
  },
  Move = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.NowMotionID = MOTION_MOVE
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_.MoveFlag = _UPVALUE0_
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.HasNetGameHandle(_ARG_0_.myHandle) and Enemy.IsNetworkMaster(_ARG_0_.myHandle) == false then
        return
      end
      if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE0_ or Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE1_ then
        if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) == true and _ARG_0_.step == 0 then
          if Script.Random() < _UPVALUE2_ * _ARG_0_.GameLevel then
            _ARG_0_:GotoState("Back")
            return
          end
          if Script.Random() < _UPVALUE3_ then
            _ARG_0_:GotoState("Attack1")
          elseif Script.Random() < _UPVALUE4_ * 2 then
            _ARG_0_:GotoState("Attack2")
          else
            _ARG_0_:GotoState("Attack3")
          end
          _ARG_0_.MoveFlag = _UPVALUE5_
          return
        end
      elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE6_ then
        if _ARG_0_.step == 0 then
          if _UPVALUE7_ > 1 then
            _ARG_0_.step = 1
            _ARG_0_.MoveFlag = _UPVALUE8_
            _ARG_0_.Movetime = _UPVALUE9_ + Script.Random() * _UPVALUE9_
          else
            _ARG_0_.Movetime = _UPVALUE10_ + Script.Random() * _UPVALUE10_
            _ARG_0_.TargetVec:set(Script.Random() * 8 * 2 - 8, 0, 8)
            Entity.GetWorldPos2(_ARG_0_.TargetVec, _ARG_0_.myHandle, _ARG_0_.TargetVec)
            _ARG_0_.Angle = 3
            _ARG_0_.StrollCnt = Script.Random() * 2 + 1
            _ARG_0_.step = 1
            _ARG_0_.MoveFlag = _UPVALUE11_
          end
        end
      elseif CanDisappear(_ARG_0_.myHandle, _ARG_0_.targetHandle) == true then
        _ARG_0_:GotoState("Disappear")
        return
      end
      if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE12_ and _ARG_0_.step == 0 and 0 > _ARG_0_.Wait then
        if Script.Random() < _UPVALUE13_ then
          _ARG_0_:GotoState("Attack3")
          _ARG_0_.step = 1
          _ARG_0_.MoveFlag = _UPVALUE5_
          return
        end
        _ARG_0_.Wait = _UPVALUE14_
      end
      if 0 >= _ARG_0_.Movetime and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_.RotationFlag = 1
        _ARG_0_:GotoState("Idling")
        return
      end
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
      end
      _ARG_0_.Movetime = _ARG_0_.Movetime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      _ARG_0_.Wait = _ARG_0_.Wait - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      if _ARG_0_.MoveFlag == _UPVALUE8_ then
        _ARG_0_:HomingPlayerMove()
        if 0 >= _ARG_0_.Movetime or Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE0_ then
          _ARG_0_:GotoState("Move")
          _ARG_0_.step = 0
        end
        return
      else
        if 0 >= _ARG_0_.StrollCnt then
          _ARG_0_.RotationFlag = 1
          _ARG_0_:GotoState("Idling")
          return
        end
        _ARG_0_:HomingTargetMove()
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.TargetVec:set(0, 0, Script.Random() * 6 - 3)
          Entity.GetWorldPos2(_ARG_0_.TargetVec, _ARG_0_.myHandle, _ARG_0_.TargetVec)
          _ARG_0_.Angle = 2
          _ARG_0_.StrollCnt = _ARG_0_.StrollCnt - 1
        end
      end
    end
  },
  Wander = {
    OnBeginState = function(_ARG_0_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_ + Script.Random() * _UPVALUE0_)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.step = _UPVALUE2_
      _ARG_0_.count = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.HasNetGameHandle(_ARG_0_.myHandle) and Enemy.IsNetworkMaster(_ARG_0_.myHandle) == false then
        return
      end
      if _ARG_0_.step == _UPVALUE0_ then
        if Enemy.GetTimeTargetHasBeenVisible(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 600 then
          Enemy.GetTargetLastRecordedPos(_ARG_0_.targetPos, _ARG_0_.myHandle, _ARG_0_.targetHandle)
        else
          Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.myHandle)
        end
        _ARG_0_.targetPos:setx(_ARG_0_.targetPos:getx() + 5 * Script.Random() * Math.Cos((RoundPI(Script.Random() * 2 * PI))))
        _ARG_0_.targetPos:setz(_ARG_0_.targetPos:getz() + 5 * Script.Random() * Math.Sin((RoundPI(Script.Random() * 2 * PI))))
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_ + Script.Random() * _UPVALUE1_)
        _ARG_0_.noWallHitTime = 120
        _ARG_0_.step = _UPVALUE2_
      elseif _ARG_0_.step == _UPVALUE3_ then
      elseif _ARG_0_.step == _UPVALUE2_ then
        if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) == true then
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE4_ or Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE5_ then
            if Script.Random() < _UPVALUE6_ * _ARG_0_.GameLevel then
              _ARG_0_:GotoState("Back")
              return
            end
            if Script.Random() < _UPVALUE7_ then
              _ARG_0_:GotoState("Attack1")
            elseif Script.Random() < _UPVALUE8_ * 2 then
              _ARG_0_:GotoState("Attack2")
            else
              _ARG_0_:GotoState("Attack3")
            end
            _ARG_0_.MoveFlag = _UPVALUE9_
            return
          elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _UPVALUE4_ then
            _ARG_0_:GotoState("Move")
            return
          end
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 3)
        _ARG_0_.MoveFlag = _UPVALUE10_
        if CanDisappear(_ARG_0_.myHandle, _ARG_0_.targetHandle) == true then
          _ARG_0_:GotoState("Disappear")
          return
        end
        _ARG_0_:Move()
        _ARG_0_.noWallHitTime = _ARG_0_.noWallHitTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.noWallHitTime < 0 then
        end
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
        if Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.IsWall(_ARG_0_.myHandle) == true or 1 > Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetPos) then
          _ARG_0_.count = _ARG_0_.count + 1
          if _ARG_0_.count > 4 then
            _ARG_0_.MoveFlag = _UPVALUE9_
            _ARG_0_:GotoState("Idling")
          else
            _ARG_0_.step = _UPVALUE0_
          end
        end
      end
    end
  },
  Attack1 = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.NowMotionID = _UPVALUE0_
      _ARG_0_.step = 0
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 and Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10) == false then
        _ARG_0_.step = _ARG_0_.step + 1
      end
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Attack2 = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.NowMotionID = _UPVALUE0_
      _ARG_0_.step = 0
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 and Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10) == false then
        _ARG_0_.step = _ARG_0_.step + 1
      end
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
        return
      end
    end
  },
  Attack3 = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      _ARG_0_.NowMotionID = _UPVALUE0_
      _ARG_0_.time = Entity.GetMotionTotalFrame(_ARG_0_.myHandle)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.time = _ARG_0_.time - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      if _ARG_0_.time >= Entity.GetMotionTotalFrame(_ARG_0_.myHandle) / _UPVALUE0_ then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
      elseif _ARG_0_.time >= 2 * Entity.GetFrameRate(_ARG_0_.myHandle) or _ARG_0_.time <= 8 * Entity.GetFrameRate(_ARG_0_.myHandle) then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
      end
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Stiffening = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.NowMotionID = MOTION_IDLING
      _ARG_0_.step = 0
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Standby = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Enemy.IsAllEnemyWaiting() == false then
        _ARG_0_:GotoState("Move")
      end
    end
  },
  Disappear = {
    OnBeginState = function(_ARG_0_)
      SetupDisappear(_ARG_0_.myHandle, 20)
    end,
    OnEndState = function(_ARG_0_)
      Entity.MoveStartPos(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsModelFade(_ARG_0_.myHandle) then
        Enemy.Disappear(_ARG_0_.myHandle)
      end
    end
  }
}
function m02ex00.HomingPlayerMove(_ARG_0_)
  _ARG_0_.Speed = _ARG_0_.Speed + _UPVALUE0_ * 0.1 / 2 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_0_.Speed > _UPVALUE0_ then
    _ARG_0_.Speed = _UPVALUE0_
  end
  Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, _UPVALUE1_)
  FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Speed)
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function m02ex00.HomingTargetMove(_ARG_0_)
  _ARG_0_.Speed = _ARG_0_.Speed + _UPVALUE0_ * 0.1 / 2 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_0_.Speed > _UPVALUE0_ then
    _ARG_0_.Speed = _UPVALUE0_
  end
  Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.TargetVec, _ARG_0_.Angle)
  FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Speed)
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function m02ex00.Move(_ARG_0_)
  _ARG_0_.Speed = _ARG_0_.Speed + _UPVALUE0_ * 0.1 / 2 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_0_.Speed > _UPVALUE0_ then
    _ARG_0_.Speed = _UPVALUE0_
  end
  FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Speed)
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function m02ex00.Stop(_ARG_0_)
  _ARG_0_.Speed = _ARG_0_.Speed - _UPVALUE0_ * 0.1 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_0_.Speed < 0 then
    _ARG_0_.Speed = 0
  end
  FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Speed)
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function m02ex00.ArrackisSelect(_ARG_0_)
end
function m02ex00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.targetHandle = NULL_HANDLE
  _ARG_0_.step = 0
  _ARG_0_.Wait = 0
  _ARG_0_.time = 0
  _ARG_0_.Frame = 0
  _ARG_0_.GameLevel = _UPVALUE0_
  _ARG_0_.UneasinessCnt = 0
  _ARG_0_.StrollCnt = 0
  _ARG_0_.MoveFlag = 0
  _ARG_0_.Speed = 0
  _ARG_0_.AttackDeLay = 0
  _ARG_0_.Movetime = 0
  _ARG_0_.NowMotionID = 0
  _ARG_0_.RotationFlag = 0
  _ARG_0_.noWallHitTime = 0
  _ARG_0_.TargetVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.TargetVec2 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkVec = FVECTOR3.new(0, 0, 0)
  Entity.EnableGravity(_ARG_0_.myHandle, 1)
  if Enemy.IsAllEnemyWaiting() == true then
    _ARG_0_:GotoState("Standby")
  else
    _ARG_0_:GotoState("Appear")
  end
end
function m02ex00.Debug(_ARG_0_)
  if Script.IsDebugCheckAttack() then
    for _FORV_5_, _FORV_6_ in pairs(_UPVALUE0_) do
      if _FORV_6_ == _ARG_0_:GetState() then
        return
      end
    end
    if Script.GetDebugAttackNumber() == 0 then
      _ARG_0_:GotoState("Attack1")
    elseif Script.GetDebugAttackNumber() == 1 then
      _ARG_0_:GotoState("Attack2")
    elseif Script.GetDebugAttackNumber() == 2 then
      _ARG_0_:GotoState("Attack3")
    end
  end
end
function m02ex00.OnReturnDamage(_ARG_0_)
  _ARG_0_:GotoState("Idling")
  _ARG_0_.NowMotionID = 0
end
function m02ex00.UpdatePositionAfter(_ARG_0_)
  if _ARG_0_.flag then
    _ARG_0_.rot:set(0, _ARG_0_.angle, 0)
    Entity.RotateBoneXYZ(_ARG_0_.myHandle, 2, _ARG_0_.rot)
  end
end
function m02ex00.OnUpdate(_ARG_0_)
  _ARG_0_:Update()
  _ARG_0_:Debug()
  if _ARG_0_.MoveFlag == 0 then
    _ARG_0_:Stop()
  end
end
EntityFactory:Add("m02ex00", function(_ARG_0_)
  return (m02ex00:new())
end)
EntityFactory:Add("m02vs00", function(_ARG_0_)
  return (m02ex00:new())
end)
