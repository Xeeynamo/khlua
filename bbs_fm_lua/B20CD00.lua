B20CD_ROOMCENTER = {
  x = 0,
  y = 0,
  z = 14
}
b20cd00 = {}
b20cd00_base_mt = {__index = __StateMachine}
setmetatable(b20cd00, b20cd00_base_mt)
b20cd00_mt = {__index = b20cd00}
function b20cd00.new(_ARG_0_)
  return setmetatable(__StateMachine:new(), b20cd00_mt)
end
b20cd00.states = {
  Appear = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_:setMotion(_UPVALUE0_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
      _ARG_0_:GotoState("Idling")
    end
  },
  Idling = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_:setMotion(_UPVALUE0_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.step = 0
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      print("b20cd00: Idling\n")
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.PlayerEnshriningFlag == 1 and _ARG_0_.PlayerEnshriningTime > _UPVALUE0_ then
        _ARG_0_:GotoState("Restplace_Move")
        return
      end
      if _ARG_0_.AttackFalg == 1 then
        if _ARG_0_.AttackCnt > _ARG_0_.AttackMax then
          _ARG_0_.AttackFalg = 0
          _ARG_0_.AttackCnt = 0
          _ARG_0_:SelectWorkstand()
          _ARG_0_:GotoState("Workstand_Turn")
        else
          if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _UPVALUE1_ then
            _ARG_0_:SelectWorkstand()
            _ARG_0_:GotoState("Workstand_Turn")
            return
          end
          if Script.Random() < 0.4 then
            _ARG_0_:GotoState("Approach_attack")
            return
          elseif Script.Random() < 0.8 then
            _ARG_0_:GotoState("Approach_attack")
            return
          else
            _ARG_0_:GotoState("SpinAttack")
            return
          end
        end
      end
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        if _UPVALUE2_ == 1 then
          _ARG_0_:SelectWorkstand()
          _ARG_0_:GotoState("Workstand_Turn")
          return
        end
        _ARG_0_:GotoState("Move_Run")
      end
    end
  },
  Idling2 = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_:setMotion(_UPVALUE0_)
      Entity.SetTimer(_ARG_0_.myHandle, 300)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsTimeOver(_ARG_0_.myHandle) and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        if Script.Random() < 0.5 then
          _ARG_0_:GotoState("Move_Walk")
        else
          _ARG_0_:GotoState("Move_Run")
        end
      end
    end
  },
  Idling3 = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_:setMotion(_UPVALUE0_)
      Entity.SetTimer(_ARG_0_.myHandle, 300)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsTimeOver(_ARG_0_.myHandle) and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        if Script.Random() < 0.5 then
          _ARG_0_:GotoState("Move_Walk")
        else
          _ARG_0_:GotoState("Move_Run")
        end
      end
    end
  },
  Threat = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
    end
  },
  Move_Walk = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_:setMotion(_UPVALUE0_)
      _ARG_0_.step = 0
      _ARG_0_.step = 0
      Entity.SetTimer(_ARG_0_.myHandle, 480)
      _ARG_0_.MoveFlag = 1
      if _ARG_0_:IsPlayerWithinFOV(30) == 1 then
      else
        if _ARG_0_:WhichRightandLeft() == 1 then
          _ARG_0_:setMotion(_UPVALUE1_)
        else
          _ARG_0_:setMotion(_UPVALUE2_)
        end
        _ARG_0_.MoveFlag = 2
      end
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE3_)
      _ARG_0_.WorkTime = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:SelectWorkstand()
        _ARG_0_:GotoState("Workstand_Turn")
        return
      end
      if _ARG_0_.step == 0 then
        if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE0_ then
          _ARG_0_.step = 2
        end
      elseif _ARG_0_.step == 1 then
        if _ARG_0_:IsPlayerWithinFOV(10) == 1 then
          _ARG_0_:setMotionWithSameCheck(_UPVALUE1_)
          _ARG_0_.MoveFlag = 1
          _ARG_0_.step = 0
        elseif _ARG_0_:WhichRightandLeft() == 1 then
          _ARG_0_.MoveFlag = 2
        else
          _ARG_0_.MoveFlag = 2
        end
      elseif _ARG_0_.step == 2 then
        _ARG_0_.AttackFalg = 1
        _ARG_0_.AttackMax = Script.Random() * _UPVALUE2_ + 2
        _ARG_0_:GotoState("Approach_attack")
        return
      end
      if _ARG_0_.MoveFlag == 1 then
        _ARG_0_:HomingPlayerMove(_UPVALUE3_)
      elseif _ARG_0_.MoveFlag == 2 then
        if Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.PlayerPos, 0.6328) == false then
          _ARG_0_:setMotion(_UPVALUE1_)
          _ARG_0_.MoveFlag = 1
        end
        _ARG_0_:Move(_UPVALUE4_)
      end
      if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE0_ then
        _ARG_0_.WorkTime = _ARG_0_.WorkTime + 1
        if _ARG_0_.WorkTime > _UPVALUE5_ then
          _ARG_0_:GotoState("SpinAttack")
          return
        end
      end
    end
  },
  Move_Run = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_:setMotion(_UPVALUE0_)
      _ARG_0_.AttackFalg = 0
      _ARG_0_.AttackCnt = 0
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE0_ then
          if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 16 then
            _ARG_0_.AttackFalg = 1
            _ARG_0_.AttackMax = Script.Random() * _UPVALUE1_ + 2
            _ARG_0_:GotoState("Approach_attack")
            return
          end
          _ARG_0_:GotoState("Move_Walk")
          return
        elseif Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE2_ then
          if Script.Random() < _UPVALUE3_ then
            _ARG_0_:GotoState("Rushattack")
            return
          elseif Script.Random() < _UPVALUE3_ + _UPVALUE4_ then
            _ARG_0_:GotoState("Move_Walk")
            return
          else
            _ARG_0_:SelectWorkstand()
            _ARG_0_:GotoState("Workstand_Turn")
            return
          end
        elseif Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE5_ then
          _ARG_0_:SelectWorkstand()
          _ARG_0_:GotoState("Workstand_Turn")
          return
        end
      elseif _ARG_0_.step == 1 then
        if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _UPVALUE6_ and Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE2_ then
          _ARG_0_:GotoState("Rushattack")
          return
        end
      elseif _ARG_0_.step == 2 then
        _ARG_0_.AttackFalg = 1
        _ARG_0_.AttackMax = Script.Random() * _UPVALUE1_ + 2
        _ARG_0_:GotoState("Approach_attack")
        return
      elseif _ARG_0_.step == 3 then
        _ARG_0_:SelectWorkstand()
        _ARG_0_:GotoState("Workstand_Turn")
        return
      end
      _ARG_0_:HomingPlayerMove(_UPVALUE7_)
    end
  },
  Move_Righttrun = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.MotionID = _UPVALUE1_
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
      _ARG_0_.angle = FVECTOR3.gety(_ARG_0_.rot) - _UPVALUE0_ * Entity.GetFrameRate(_ARG_0_.myHandle)
      _ARG_0_.workVec:set(0, _ARG_0_.angle, 0)
      Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.workVec)
      _ARG_0_:Move(_UPVALUE1_)
    end
  },
  Move_Lefttrun = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.MotionID = _UPVALUE0_
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
      _ARG_0_.angle = FVECTOR3.gety(_ARG_0_.rot) + _UPVALUE0_ * Entity.GetFrameRate(_ARG_0_.myHandle)
      _ARG_0_.workVec:set(0, _ARG_0_.angle, 0)
      Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.workVec)
      FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _UPVALUE1_ / 1.5)
      Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
    end
  },
  Workstand_Turn = {
    OnBeginState = function(_ARG_0_)
      if _ARG_0_:WhichRightandLeft_Workstand() == 1 then
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.MotionID = _UPVALUE0_
      else
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
        _ARG_0_.MotionID = _UPVALUE1_
      end
      _ARG_0_.step = 0
      _ARG_0_.AttackFalg = 0
      _ARG_0_.AttackCnt = 0
      _ARG_0_.WarkstandFlag = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.WorkVec:set(_UPVALUE0_[_ARG_0_.Workstand_ID].x, _UPVALUE0_[_ARG_0_.Workstand_ID].y, _UPVALUE0_[_ARG_0_.Workstand_ID].z)
      if _ARG_0_.step == 0 then
        if _ARG_0_:CheckTargetPos(_UPVALUE0_[_ARG_0_.Workstand_ID].x, _UPVALUE0_[_ARG_0_.Workstand_ID].y, _UPVALUE0_[_ARG_0_.Workstand_ID].z, 1.6) == false then
          _ARG_0_.step = _ARG_0_.step + 1
          Entity.ClearSpeed(_ARG_0_.myHandle)
          return
        end
        _ARG_0_:Move(_UPVALUE1_)
      elseif _ARG_0_.step == 1 then
        if Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec) < _ARG_0_.WorkstandDist then
          if _ARG_0_.Workstand_ID == _UPVALUE2_ or _ARG_0_.Workstand_ID == _UPVALUE3_ then
            _ARG_0_:GotoState("Two_step_jump")
            return
          end
          _ARG_0_:GotoState("Workstand_1_Jump")
          return
        end
        _ARG_0_:GotoState("Workstand_1_Move")
      end
    end
  },
  Workstand_1_Move = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_:setMotion(_UPVALUE0_)
      _ARG_0_.step = 0
      Entity.SetTimer(_ARG_0_.myHandle, 540)
      _ARG_0_.WarkstandFlag = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:SelectWorkstand()
      end
      _ARG_0_.WorkVec:set(_UPVALUE0_[_ARG_0_.Workstand_ID].x, _UPVALUE0_[_ARG_0_.Workstand_ID].y, _UPVALUE0_[_ARG_0_.Workstand_ID].z)
      if Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec) < 1 then
        if Script.Random() < 0.35 then
          _ARG_0_:GotoState("Idling")
        elseif Script.Random() < 0.7 then
          _ARG_0_:GotoState("Idling2")
        else
          _ARG_0_:GotoState("Idling3")
        end
      elseif Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec) < _ARG_0_.WorkstandDist then
        if _ARG_0_.Workstand_ID == _UPVALUE1_ or _ARG_0_.Workstand_ID == _UPVALUE2_ then
          _ARG_0_:GotoState("Two_step_jump")
          return
        end
        _ARG_0_:GotoState("Workstand_1_Jump")
        return
      end
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.WorkVec, 2)
      _ARG_0_:Move(_UPVALUE3_)
    end
  },
  Workstand_1_Jump = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_:setMotion(_UPVALUE0_)
      _ARG_0_.step = _UPVALUE1_
      Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.WorkVec:set(_UPVALUE0_[_ARG_0_.Workstand_ID].x, _UPVALUE0_[_ARG_0_.Workstand_ID].y, _UPVALUE0_[_ARG_0_.Workstand_ID].z)
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.WorkVec, 2)
      _ARG_0_.WorkVec2:set(0, 0, 0)
      if _ARG_0_.step == _UPVALUE1_ then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > _UPVALUE2_ then
          _ARG_0_.step = _UPVALUE3_
        end
      elseif _ARG_0_.step == _UPVALUE3_ then
        _ARG_0_.WorkVec2:sety(_ARG_0_.JumpPow)
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.WorkVec2)
        if 0 > _ARG_0_.JumpTime then
          _ARG_0_.step = _UPVALUE4_
        end
      elseif _ARG_0_.step == _UPVALUE4_ then
        if _ARG_0_.JumpPow < 1 then
          _ARG_0_:setMotion(_UPVALUE5_)
        end
        Entity.ClearSpeed(_ARG_0_.myHandle)
        _ARG_0_.JumpPow = _ARG_0_.JumpPow - _ARG_0_.Gravity * Entity.GetFrameRate(_ARG_0_.myHandle)
        _ARG_0_.WorkVec2:sety(_ARG_0_.JumpPow)
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.WorkVec2)
        if Entity.IsGround(_ARG_0_.myHandle) then
          Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
          _ARG_0_.step = _UPVALUE6_
          _ARG_0_:setMotion(_UPVALUE7_)
        end
      elseif _ARG_0_.step == _UPVALUE6_ then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Workstand_1_Rotation")
          return
        end
      elseif _ARG_0_.step == B20CD_AERIAL_STATE_END or _ARG_0_.step == _UPVALUE6_ then
      end
      if _ARG_0_.step == _UPVALUE1_ then
        return
      else
        _ARG_0_.JumpTime = _ARG_0_.JumpTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        _ARG_0_.WorkVec:set(_UPVALUE0_[_ARG_0_.Workstand_ID].x, _UPVALUE0_[_ARG_0_.Workstand_ID].y, _UPVALUE0_[_ARG_0_.Workstand_ID].z)
        _ARG_0_.velocity:set(0, 0, Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec) / _ARG_0_.JumpSpeedRate)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
      end
    end
  },
  Two_step_jump = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_:setMotion(_UPVALUE0_)
      _ARG_0_.step = _UPVALUE1_
      Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.WorkVec:set(_UPVALUE0_[_ARG_0_.Workstand_ID].x, _UPVALUE0_[_ARG_0_.Workstand_ID].y, _UPVALUE0_[_ARG_0_.Workstand_ID].z)
      if _ARG_0_.Workstand_ID == _UPVALUE1_ then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.WorkVec, 9)
      else
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.WorkVec, 2)
      end
      _ARG_0_.WorkVec2:set(0, 0, 0)
      if _ARG_0_.step == _UPVALUE2_ then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > _UPVALUE3_ then
          _ARG_0_.step = _UPVALUE4_
        end
      elseif _ARG_0_.step == _UPVALUE4_ then
        _ARG_0_.WorkVec2:sety(_ARG_0_.JumpPow)
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.WorkVec2)
        if 0 > _ARG_0_.JumpTime then
          _ARG_0_.JumpPow = _ARG_0_.JumpPow - _ARG_0_.Gravity * Entity.GetFrameRate(_ARG_0_.myHandle)
        end
        if _ARG_0_.Workstand_ID == _UPVALUE5_ then
          Entity.GetWorldPos(_ARG_0_.MyPos, _ARG_0_.myHandle)
          if _ARG_0_.MyPos:gety() > _UPVALUE6_ and Entity.IsWall(_ARG_0_.myHandle) then
            Entity.EnableGravity(_ARG_0_.myHandle, 0)
            _ARG_0_.step = _UPVALUE7_
            _ARG_0_:setMotion(_UPVALUE8_)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            return
          end
        elseif _ARG_0_.Workstand_ID == _UPVALUE9_ then
          Entity.GetWorldPos(_ARG_0_.MyPos, _ARG_0_.myHandle)
          if _ARG_0_.MyPos:gety() > _UPVALUE10_ and Entity.IsWall(_ARG_0_.myHandle) then
            Entity.EnableGravity(_ARG_0_.myHandle, 0)
            _ARG_0_.step = _UPVALUE7_
            _ARG_0_:setMotion(_UPVALUE8_)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            return
          end
        end
      elseif _ARG_0_.step == _UPVALUE7_ then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > _UPVALUE11_ then
          if _ARG_0_.Workstand_ID == _UPVALUE5_ then
            _ARG_0_.JumpTime = 2
            _ARG_0_.JumpMax = 5
            _ARG_0_.Gravity = 0.1
            _ARG_0_.JumpPow = 1.6
            _ARG_0_.JumpSpeedRate = 12
            _ARG_0_.Workstand_ID = _UPVALUE12_
          elseif _ARG_0_.Workstand_ID == _UPVALUE9_ then
            _ARG_0_.JumpTime = 2
            _ARG_0_.JumpMax = 5
            _ARG_0_.Gravity = 0.15
            _ARG_0_.JumpPow = 1.6
            _ARG_0_.JumpSpeedRate = 7
            _ARG_0_.Workstand_ID = _UPVALUE1_
          end
          Entity.EnableGravity(_ARG_0_.myHandle, 1)
          _ARG_0_.step = _UPVALUE13_
        end
      elseif _ARG_0_.step == _UPVALUE13_ then
        _ARG_0_.WorkVec2:sety(_ARG_0_.JumpPow)
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.WorkVec2)
        if 0 > _ARG_0_.JumpTime then
          _ARG_0_.step = _UPVALUE14_
        end
      elseif _ARG_0_.step == _UPVALUE14_ then
        if _ARG_0_.JumpPow < 1 then
          _ARG_0_:setMotion(_UPVALUE15_)
        end
        Entity.ClearSpeed(_ARG_0_.myHandle)
        _ARG_0_.JumpPow = _ARG_0_.JumpPow - _ARG_0_.Gravity * Entity.GetFrameRate(_ARG_0_.myHandle)
        _ARG_0_.WorkVec2:sety(_ARG_0_.JumpPow)
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.WorkVec2)
        if Entity.IsGround(_ARG_0_.myHandle) then
          Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
          _ARG_0_.step = _UPVALUE16_
          _ARG_0_:setMotion(_UPVALUE17_)
        end
      elseif _ARG_0_.step == _UPVALUE16_ then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Workstand_1_Rotation")
          return
        end
      elseif _ARG_0_.step == B20CD_AERIAL_STATE_END then
      end
      if _ARG_0_.step == _UPVALUE2_ then
        return
      else
        _ARG_0_.JumpTime = _ARG_0_.JumpTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        _ARG_0_.WorkVec:set(_UPVALUE0_[_ARG_0_.Workstand_ID].x, _UPVALUE0_[_ARG_0_.Workstand_ID].y, _UPVALUE0_[_ARG_0_.Workstand_ID].z)
        _ARG_0_.velocity:set(0, 0, Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec) / _ARG_0_.JumpSpeedRate)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
      end
    end
  },
  Workstand_1_Rotation = {
    OnBeginState = function(_ARG_0_)
      if _ARG_0_:WhichRightandLeft_RoomCenter() == 1 then
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.MotionID = _UPVALUE0_
      else
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
        _ARG_0_.MotionID = _UPVALUE1_
      end
      _ARG_0_.step = 0
      _ARG_0_.WarkstandFlag = 1
      Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_.WarkstandFlag = 0
      _ARG_0_.PlayerEnshriningFlag = 0
      Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if _ARG_0_.RodeoInAttackFlag == 1 then
          _ARG_0_.WorkVec:set(13.5, 0, 7)
        else
          _ARG_0_.WorkVec:set(B20CD_ROOMCENTER.x, B20CD_ROOMCENTER.y, B20CD_ROOMCENTER.z)
        end
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) < _UPVALUE0_ and Entity.GetMotionNowFrame(_ARG_0_.myHandle) > _UPVALUE1_ then
          if _ARG_0_:CheckTargetPos(_ARG_0_.WorkVec:getx(), _ARG_0_.WorkVec:gety(), _ARG_0_.WorkVec:getz(), 11.5) == false then
            _ARG_0_.step = _ARG_0_.step + 1
          end
        elseif Entity.GetMotionNowFrame(_ARG_0_.myHandle) > _UPVALUE0_ then
          _ARG_0_.step = _ARG_0_.step + 1
        end
      elseif _ARG_0_.step == 1 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        if _ARG_0_.RestFlag == 0 then
          _ARG_0_:GotoState("Workstand_Idling")
        else
          _ARG_0_:GotoState("Rest")
          return
        end
      end
    end
  },
  Workstand_Idling = {
    OnBeginState = function(_ARG_0_)
      Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.myHandle)
      if _ARG_0_.Workstand_ID == WORKSTAND_ID_1 or _ARG_0_.Workstand_ID == _UPVALUE0_ then
        _ARG_0_:setMotion(_UPVALUE1_)
      else
        _ARG_0_:setMotion(_UPVALUE2_)
      end
      if Script.Random() < _UPVALUE3_ then
        Sound.PlayVoice(120, 3, _ARG_0_.WorkVec)
      end
      Entity.SetTimer(_ARG_0_.myHandle, Script.Random() * (_UPVALUE4_ - _UPVALUE5_) + _UPVALUE5_)
      _ARG_0_.step = 0
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      _ARG_0_.WarkstandFlag = 1
      Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_.WarkstandFlag = 0
      _ARG_0_.BodyPressOnWorkstand = 0
      Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE0_ then
          if _ARG_0_.Workstand_ID == _UPVALUE1_ or _ARG_0_.Workstand_ID == _UPVALUE2_ then
            _ARG_0_:setMotion(_UPVALUE3_)
            Entity.SetTimer(_ARG_0_.myHandle, 1)
          end
          _ARG_0_.step = 1
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          if _ARG_0_.Workstand_ID == _UPVALUE1_ or _ARG_0_.Workstand_ID == _UPVALUE2_ then
            _ARG_0_:setMotion(_UPVALUE3_)
            Entity.SetTimer(_ARG_0_.myHandle, 1)
          end
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 and Entity.IsTimeOver(_ARG_0_.myHandle) then
        if _ARG_0_:CheckPlayerOnWarkstand() == 1 or _ARG_0_:CheckPlayerEnshrining() == 1 or _ARG_0_.BodyPressOnWorkstand == 1 then
          _ARG_0_:GotoState("Moveunder")
          return
        end
        if _UPVALUE4_ < _ARG_0_.MoveunderCount then
          _ARG_0_:GotoState("BodyPress")
          _ARG_0_.MoveunderCount = 0
          return
        end
        if _UPVALUE5_ == 1 then
          _ARG_0_:GotoState("Moveunder")
          return
        end
        if Script.Random() < _UPVALUE6_ then
          _ARG_0_:GotoState("BodyPress")
          _ARG_0_.MoveunderCount = 0
        else
          _ARG_0_.MoveunderCount = _ARG_0_.MoveunderCount + 1
          if Script.Random() < 0.2 then
            _ARG_0_:GotoState("Moveunder")
          end
        end
      end
    end
  },
  Moveunder = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_:setMotion(_UPVALUE0_)
      if _ARG_0_.Workstand_ID == _UPVALUE1_ or _ARG_0_.Workstand_ID == _UPVALUE2_ then
        _ARG_0_:setMotion(_UPVALUE0_)
      else
        _ARG_0_:setMotion(_UPVALUE0_)
      end
      _ARG_0_.step = _UPVALUE3_
      _ARG_0_:initMoveunder()
      Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      _ARG_0_.WarkstandFlag = 0
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_.WarkstandFlag = 0
      Entity.ClearSpeed(_ARG_0_.myHandle)
      Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == _UPVALUE0_ then
        if _ARG_0_.Workstand_ID == _UPVALUE1_ or _ARG_0_.Workstand_ID == _UPVALUE2_ then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > _UPVALUE3_ then
            _ARG_0_.step = _UPVALUE4_
          end
        elseif Entity.GetMotionNowFrame(_ARG_0_.myHandle) > _UPVALUE3_ then
          _ARG_0_.step = _UPVALUE4_
        end
      elseif _ARG_0_.step == _UPVALUE4_ then
        _ARG_0_.WorkVec2:sety(_ARG_0_.JumpPow)
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.WorkVec2)
        if _ARG_0_.JumpTime < 0 then
          _ARG_0_.step = _UPVALUE5_
        end
        _ARG_0_:Rotation(_ARG_0_.JampAng)
      elseif _ARG_0_.step == _UPVALUE5_ then
        if _ARG_0_.JumpPow < 1 then
          if _ARG_0_.Workstand_ID == _UPVALUE1_ or _ARG_0_.Workstand_ID == _UPVALUE2_ then
            _ARG_0_:setMotion(_UPVALUE6_)
          else
            _ARG_0_:setMotion(_UPVALUE7_)
          end
        end
        Entity.ClearSpeed(_ARG_0_.myHandle)
        _ARG_0_.JumpPow = _ARG_0_.JumpPow - _ARG_0_.Gravity * Entity.GetFrameRate(_ARG_0_.myHandle)
        _ARG_0_.WorkVec2:sety(_ARG_0_.JumpPow)
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.WorkVec2)
        _ARG_0_:Rotation(_ARG_0_.JampAng)
        if Entity.IsGround(_ARG_0_.myHandle) then
          Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
          Camera.QuakeV(25, 0.22, 3)
          _ARG_0_.step = _UPVALUE8_
          if _ARG_0_.Workstand_ID == _UPVALUE1_ or _ARG_0_.Workstand_ID == _UPVALUE2_ then
            _ARG_0_:setMotion(_UPVALUE9_)
          else
            _ARG_0_:setMotion(_UPVALUE10_)
          end
          Entity.ClearSpeed(_ARG_0_.myHandle)
          return
        end
      elseif _ARG_0_.step == _UPVALUE8_ then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Moveunder_Affter")
          return
        end
      elseif _ARG_0_.step == B20CD_AERIAL_STATE_END then
      end
      if _ARG_0_.step == _UPVALUE0_ or _ARG_0_.step == _UPVALUE8_ then
        return
      else
        _ARG_0_.JumpTime = _ARG_0_.JumpTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        _ARG_0_.velocity:set(0, 0, _UPVALUE11_)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
      end
    end
  },
  Moveunder_Affter = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_:setMotion(_UPVALUE0_)
      print("b20cd00::Moveunder_Affter Start\n")
      if Script.Random() < _UPVALUE1_ then
        _ARG_0_.step = 1
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE2_)
      else
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE3_)
        _ARG_0_.step = 0
      end
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
    end,
    OnEndState = function(_ARG_0_)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.PlayerEnshriningFlag == 1 and _ARG_0_.PlayerEnshriningTime > _UPVALUE0_ then
        _ARG_0_:GotoState("Restplace_Move")
        return
      end
      if _ARG_0_.step == 0 then
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          if _ARG_0_:CheckPlayerEnshrining() == 1 then
            _ARG_0_:SelectWorkstand()
            _ARG_0_:GotoState("Workstand_Turn")
          else
            _ARG_0_:GotoState("Idling")
          end
          return
        end
      else
        _ARG_0_:SelectWorkstand()
        _ARG_0_:GotoState("Workstand_Turn")
      end
    end
  },
  Stroll = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
      _ARG_0_.count = 0
      Entity.SetTimer(_ARG_0_.myHandle, 600)
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        _ARG_0_:SelectWorkstand()
        _ARG_0_.targetPos:setx(_UPVALUE0_[_ARG_0_.Workstand_ID].x + 1 * Script.Random() * Math.Cos((RoundPI(Script.Random() * 2 * PI))))
        _ARG_0_.targetPos:setz(_UPVALUE0_[_ARG_0_.Workstand_ID].z + 1 * Script.Random() * Math.Sin((RoundPI(Script.Random() * 2 * PI))))
        _ARG_0_.step = 1
      elseif _ARG_0_.step == 1 then
        Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
        _ARG_0_.workVec0:set(RadToDeg(0.016), 0, 0)
        Math.RotateVectorXYZ(_ARG_0_.workVec0, _ARG_0_.rot)
        Entity.GetWorldPos(_ARG_0_.MyPos, _ARG_0_.myHandle)
        FVECTOR3.Sub(_ARG_0_.workVec1, _ARG_0_.MyPos, _ARG_0_.targetPos)
        _ARG_0_.workVec1:normalize()
        if _ARG_0_.workVec0:dot(_ARG_0_.workVec1) < -0.1 then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE1_)
        elseif _ARG_0_.workVec0:dot(_ARG_0_.workVec1) > 0.1 then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE2_)
        end
        _ARG_0_.workVec1:set(0, 0, _UPVALUE3_)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.workVec1)
        if _ARG_0_:CheckTargetPos(_ARG_0_.targetPos:getx(), 0, _ARG_0_.targetPos:getz(), RadToDeg(0.016)) == false then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE4_)
          Entity.SetTimer(_ARG_0_.myHandle, 480)
          _ARG_0_.step = 2
        end
      elseif _ARG_0_.step == 2 then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 2)
        _ARG_0_.workVec1:set(0, 0, _UPVALUE5_)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.workVec1)
        if Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.IsWall(_ARG_0_.myHandle) or Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetPos) < 9 then
          _ARG_0_.count = _ARG_0_.count + 1
          if 2 < _ARG_0_.count then
            _ARG_0_:SelectWorkstand()
            _ARG_0_:GotoState("Workstand_Turn")
          else
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE6_)
            _ARG_0_.step = 0
            Entity.ClearSpeed(_ARG_0_.myHandle)
          end
        end
      end
    end
  },
  CameraOut = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_:setMotion(_UPVALUE0_)
      _ARG_0_.step = 0
      Entity.SetTimer(_ARG_0_.myHandle, 40)
      if Script.Random() * 3 < 1 then
        _ARG_0_.CamRotFlag = 0
      elseif Script.Random() * 3 < 2 then
        _ARG_0_.CamRotFlag = 1
      else
        _ARG_0_.CamRotFlag = 2
      end
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 or _ARG_0_.step == 1 then
        if not Entity.IsWall(_ARG_0_.myHandle) and Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_.step = 2
        end
      elseif Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_.CamFlag = 0
        _ARG_0_.CamCnt = _ARG_0_.CamCnt + 1
        _ARG_0_:SelectWorkstand()
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        return
      end
      if _ARG_0_.step == 0 then
        if Entity.IsWall(_ARG_0_.myHandle) then
          _ARG_0_.step = 1
          if Script.Random() < 0.5 then
            _ARG_0_.CamRotFlag = 0
          else
            _ARG_0_.CamRotFlag = 1
          end
        end
      elseif _ARG_0_.step == 1 then
      end
      if _ARG_0_.step == 0 or _ARG_0_.step == 1 then
        if _ARG_0_.CamRotFlag == 0 then
          _ARG_0_:Rotation(0.1)
        elseif _ARG_0_.CamRotFlag == 1 then
          _ARG_0_:Rotation(-0.1)
        end
        _ARG_0_:Move(_UPVALUE0_)
      else
        if _ARG_0_.CamRotFlag == 0 then
          _ARG_0_:Rotation(_UPVALUE1_)
        elseif _ARG_0_.CamRotFlag == 1 then
          _ARG_0_:Rotation(-_UPVALUE1_)
        end
        _ARG_0_:Move(_UPVALUE2_)
      end
    end
  },
  Attack = {
    OnBeginState = function(_ARG_0_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
    end
  },
  SpinAttack = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.step = 0
      if _ARG_0_:WhichRightandLeft() == 1 then
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.MotionID = _UPVALUE0_
      else
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
        _ARG_0_.MotionID = _UPVALUE1_
      end
      if _ARG_0_:IsPlayerWithinFOV(45) == 1 then
        if Script.Random() < 0.5 then
          if _ARG_0_:WhichRightandLeft() == 1 then
            _ARG_0_:setMotion(_UPVALUE2_)
          else
            _ARG_0_:setMotion(_UPVALUE3_)
          end
        elseif _ARG_0_:WhichRightandLeft() == 1 then
          _ARG_0_:setMotion(_UPVALUE4_)
        else
          _ARG_0_:setMotion(_UPVALUE5_)
        end
        _ARG_0_.step = 1
      end
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_.AttackCnt = _ARG_0_.AttackCnt + 1
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) < _UPVALUE0_ and Entity.GetMotionNowFrame(_ARG_0_.myHandle) > _UPVALUE1_ then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 6.25)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > _UPVALUE0_ then
            _ARG_0_.step = 1
          end
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.step = 2
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE2_)
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE3_)
        end
      elseif _ARG_0_.step == 2 and Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  SpinAttackEx = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.step = 0
      if _ARG_0_:WhichRightandLeft() == 1 then
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.MotionID = _UPVALUE0_
      else
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
        _ARG_0_.MotionID = _UPVALUE1_
      end
      if _ARG_0_:IsPlayerWithinFOV(45) == 1 then
        if _ARG_0_:WhichRightandLeft() == 1 then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
          _ARG_0_.MotionID = _UPVALUE0_
        else
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
          _ARG_0_.MotionID = _UPVALUE1_
        end
        _ARG_0_.step = 1
      end
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      print("b20cd00 : SpinAttackEx\n")
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_.AttackCnt = _ARG_0_.AttackCnt + 1
      Entity.ClearSpeed(_ARG_0_.myHandle)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) < _UPVALUE0_ and Entity.GetMotionNowFrame(_ARG_0_.myHandle) > _UPVALUE1_ then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 6.25)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > _UPVALUE0_ then
            _ARG_0_.step = 2
          end
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.step = 2
        end
      elseif _ARG_0_.step == 1 then
        if _ARG_0_.MotionID == _UPVALUE2_ then
          _ARG_0_:RotationEx(1)
        else
          _ARG_0_:RotationEx(-1)
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.step = 2
        end
      elseif _ARG_0_.step == 2 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Approach_attack = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.step = 0
      if _ARG_0_:IsPlayerWithinFOV(45) == 0 then
        if _ARG_0_:WhichRightandLeft() == 1 then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
          _ARG_0_.MotionID = _UPVALUE0_
        else
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
          _ARG_0_.MotionID = _UPVALUE1_
        end
      else
        if Script.Random() < 0.5 then
          if _ARG_0_:WhichRightandLeft() == 1 then
            _ARG_0_:setMotion(_UPVALUE2_)
          else
            _ARG_0_:setMotion(_UPVALUE3_)
          end
        elseif _ARG_0_:WhichRightandLeft() == 1 then
          _ARG_0_:setMotion(_UPVALUE4_)
        else
          _ARG_0_:setMotion(_UPVALUE5_)
        end
        _ARG_0_.step = 2
      end
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_.AttackCnt = _ARG_0_.AttackCnt + 1
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) < _UPVALUE0_ and Entity.GetMotionNowFrame(_ARG_0_.myHandle) > _UPVALUE1_ then
          if Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 6.25) == false then
            _ARG_0_.step = 1
          end
        elseif Entity.GetMotionNowFrame(_ARG_0_.myHandle) > _UPVALUE0_ then
          _ARG_0_.step = 1
        end
        _ARG_0_.WorkTime = 60
      elseif _ARG_0_.step == 1 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.step = 2
          if Script.Random() < 0.5 then
            if _ARG_0_:WhichRightandLeft() == 1 then
              _ARG_0_:setMotion(_UPVALUE2_)
            else
              _ARG_0_:setMotion(_UPVALUE3_)
            end
          elseif _ARG_0_:WhichRightandLeft() == 1 then
            _ARG_0_:setMotion(_UPVALUE4_)
          else
            _ARG_0_:setMotion(_UPVALUE5_)
          end
        end
      elseif _ARG_0_.step == 2 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.step = 3
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE6_)
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE7_)
        end
      elseif _ARG_0_.step == 3 and Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
      _ARG_0_.WorkTime = _ARG_0_.WorkTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
    end
  },
  Scratch = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.step = 0
      Entity.SetTimer(_ARG_0_.myHandle, 60)
      if _ARG_0_:IsPlayerWithinFOV(30) == 1 then
        _ARG_0_.step = 1
        if _ARG_0_:WhichRightandLeft() == 1 then
          _ARG_0_:setMotion(_UPVALUE0_)
        else
          _ARG_0_:setMotion(_UPVALUE1_)
        end
      elseif _ARG_0_:WhichRightandLeft() == 1 then
        _ARG_0_:setMotion(_UPVALUE2_)
      else
        _ARG_0_:setMotion(_UPVALUE3_)
      end
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_.AttackCnt = _ARG_0_.AttackCnt + 1
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_.step = 1
          if _ARG_0_:WhichRightandLeft() == 1 then
            _ARG_0_:setMotion(_UPVALUE0_)
          else
            _ARG_0_:setMotion(_UPVALUE1_)
          end
          Entity.ClearSpeed(_ARG_0_.myHandle)
          return
        end
        if Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.PlayerPos, 1.1) == false then
          _ARG_0_.step = 1
          if _ARG_0_:WhichRightandLeft() == 1 then
            _ARG_0_:setMotion(_UPVALUE0_)
          else
            _ARG_0_:setMotion(_UPVALUE1_)
          end
          Entity.ClearSpeed(_ARG_0_.myHandle)
          return
        end
        _ARG_0_:Move(_UPVALUE2_)
      elseif _ARG_0_.step == 1 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.step = 2
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE3_)
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE4_)
        end
      elseif _ARG_0_.step == 2 and Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Nukopunch = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.step = 0
      Entity.SetTimer(_ARG_0_.myHandle, 60)
      if _ARG_0_:IsPlayerWithinFOV(30) == 1 then
        _ARG_0_.step = 1
        if _ARG_0_:WhichRightandLeft() == 1 then
          _ARG_0_:setMotion(_UPVALUE0_)
        else
          _ARG_0_:setMotion(_UPVALUE1_)
        end
      elseif _ARG_0_:WhichRightandLeft() == 1 then
        _ARG_0_:setMotion(_UPVALUE2_)
      else
        _ARG_0_:setMotion(_UPVALUE3_)
      end
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_.AttackCnt = _ARG_0_.AttackCnt + 1
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_.step = 1
          if _ARG_0_:WhichRightandLeft() == 1 then
            _ARG_0_:setMotion(_UPVALUE0_)
          else
            _ARG_0_:setMotion(_UPVALUE1_)
          end
          Entity.ClearSpeed(_ARG_0_.myHandle)
          return
        end
        if Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.PlayerPos, 1.1) == false then
          _ARG_0_.step = 1
          if _ARG_0_:WhichRightandLeft() == 1 then
            _ARG_0_:setMotion(_UPVALUE0_)
          else
            _ARG_0_:setMotion(_UPVALUE1_)
          end
          Entity.ClearSpeed(_ARG_0_.myHandle)
          return
        end
        _ARG_0_:Move(_UPVALUE2_)
      elseif _ARG_0_.step == 1 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.step = 2
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE3_)
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE4_)
        end
      elseif _ARG_0_.step == 2 and Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Rushattack_Start = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_:setMotion(MOTION_IDLING)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Rushattack")
      end
    end
  },
  Rushattack = {
    OnBeginState = function(_ARG_0_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.EnableAttackBgHit(_ARG_0_.myHandle, 0)
      _ARG_0_.AttackBgFlag = 0
      _ARG_0_.WorkTime2 = 240
      _ARG_0_.AttackFlag = 0
      _ARG_0_.WorkTime = 600
      _ARG_0_.RushWallFlag = 0
      if Script.Random() < 0.5 then
        _ARG_0_.RushAng = -1
      else
        _ARG_0_.RushAng = 1
      end
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      if _ARG_0_:IsPlayerWithinFOV(20) == 0 then
        if _ARG_0_:WhichRightandLeft() == 1 then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
          _ARG_0_.MotionID = _UPVALUE1_
        else
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
          _ARG_0_.MotionID = _UPVALUE2_
        end
        _ARG_0_.step = _UPVALUE3_
      else
        _ARG_0_.step = _UPVALUE4_
        _ARG_0_:setMotion(_UPVALUE5_)
      end
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step ~= _UPVALUE0_ and _ARG_0_.step ~= _UPVALUE1_ then
        if _ARG_0_.AttackFlag == 1 then
          _ARG_0_.AttackFlag = 0
          Camera.QuakeV(50, 0.22, 6)
          _ARG_0_.WorkTime2 = 120
          Entity.SetTimer(_ARG_0_.myHandle, 30)
          _ARG_0_.AttackBgFlag = 0
          _ARG_0_.RushWallFlag = 10
          _ARG_0_.step = _UPVALUE2_
          Entity.ClearSpeed(_ARG_0_.myHandle)
          _ARG_0_:setMotion(_UPVALUE3_)
        end
      else
        _ARG_0_.AttackFlag = 0
      end
      if _ARG_0_.AttackFlag == 0 and _ARG_0_.AttackBgFlag == 1 then
        _ARG_0_.AttackBgFlag = 0
        _ARG_0_.RushWallFlag = 0
        _ARG_0_.step = _UPVALUE4_
        Entity.ClearSpeed(_ARG_0_.myHandle)
        _ARG_0_:setMotion(_UPVALUE5_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE6_)
        Camera.QuakeV(20, 0.28, 4)
        _ARG_0_.WorkTime = 10
        return
      end
      if _ARG_0_.RushWallFlag == 1 then
      elseif _ARG_0_.RushWallFlag == 2 then
      elseif _ARG_0_.RushWallFlag == 3 then
      elseif _ARG_0_.RushWallFlag == 0 and 0 > _ARG_0_.WorkTime2 then
        _ARG_0_.RushWallFlag = 1
        Entity.EnableAttackBgHit(_ARG_0_.myHandle, 1)
      end
      if _ARG_0_.step == _UPVALUE4_ or _ARG_0_.step == _UPVALUE7_ or _ARG_0_.step == _UPVALUE8_ or _ARG_0_.step == _UPVALUE0_ or _ARG_0_.step == _UPVALUE1_ then
      elseif Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_.AttackBgFlag = 0
        _ARG_0_.RushWallFlag = 10
        _ARG_0_.step = _UPVALUE2_
        Entity.ClearSpeed(_ARG_0_.myHandle)
        _ARG_0_:setMotion(_UPVALUE3_)
      end
      if _ARG_0_.step == _UPVALUE9_ then
        _ARG_0_:Rotation(DegToRad(2.5) * _ARG_0_.RushAng)
        _ARG_0_:Move(SPEED_RUSH)
        if 0 > _ARG_0_.WorkTime then
          if Script.Random() < 0.5 then
            _ARG_0_.WorkTime = 60
            _ARG_0_.step = _UPVALUE10_
          else
            _ARG_0_.WorkTime = 120
            _ARG_0_.step = _UPVALUE11_
          end
          if Script.Random() < 0.5 then
            _ARG_0_.RushAng = -1
          else
            _ARG_0_.RushAng = 1
          end
          return
        end
      elseif _ARG_0_.step == _UPVALUE11_ then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, _UPVALUE12_)
        _ARG_0_:Move(_UPVALUE13_)
      elseif _ARG_0_.step == _UPVALUE10_ then
        _ARG_0_:Move(SPEED_RUSH)
        if 0 > _ARG_0_.WorkTime then
          if Script.Random() < 0.5 then
            _ARG_0_.WorkTime = 120
            _ARG_0_.step = _UPVALUE11_
          else
            _ARG_0_.WorkTime = 180
            _ARG_0_.step = _UPVALUE9_
          end
          if Script.Random() < 0.5 then
            _ARG_0_.RushAng = -1
          else
            _ARG_0_.RushAng = 1
          end
          return
        end
      elseif _ARG_0_.step == _UPVALUE14_ then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:setMotion(_UPVALUE15_)
          _ARG_0_.WorkTime2 = _UPVALUE16_
          _ARG_0_.step = _UPVALUE11_
        end
      elseif _ARG_0_.step == _UPVALUE0_ then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) < _UPVALUE17_ and Entity.GetMotionNowFrame(_ARG_0_.myHandle) > _UPVALUE18_ then
          if Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 9) == false then
            _ARG_0_.step = _UPVALUE1_
          end
        elseif Entity.GetMotionNowFrame(_ARG_0_.myHandle) > _UPVALUE17_ then
          _ARG_0_.step = _UPVALUE1_
        end
      elseif _ARG_0_.step == _UPVALUE1_ then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.step = _UPVALUE14_
          _ARG_0_:setMotion(_UPVALUE19_)
        end
      elseif _ARG_0_.step == _UPVALUE2_ then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.step = _UPVALUE8_
          _ARG_0_:setMotion(_UPVALUE20_)
          _ARG_0_.WorkTime2 = _UPVALUE21_
          return
        end
      elseif _ARG_0_.step == _UPVALUE8_ then
        if 0 > _ARG_0_.WorkTime2 then
          _ARG_0_:SelectWorkstand()
          _ARG_0_:GotoState("Workstand_Turn")
        end
      elseif _ARG_0_.step == _UPVALUE4_ then
        FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, -0.2)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
        if 0 > _ARG_0_.WorkTime then
          Entity.ClearSpeed(_ARG_0_.myHandle)
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          Entity.ClearSpeed(_ARG_0_.myHandle)
          _ARG_0_:setMotion(_UPVALUE22_)
          _ARG_0_.step = _UPVALUE7_
        end
      elseif _ARG_0_.step == _UPVALUE7_ and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_.step = _UPVALUE8_
        _ARG_0_:setMotion(_UPVALUE20_)
        _ARG_0_.WorkTime2 = _UPVALUE21_
      end
      _ARG_0_.WorkTime = _ARG_0_.WorkTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      _ARG_0_.WorkTime2 = _ARG_0_.WorkTime2 - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
    end
  },
  BodyPress = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_:setMotion(_UPVALUE0_)
      _ARG_0_.step = _UPVALUE1_
      _ARG_0_.WorkNumber = 0
      _ARG_0_.JumpTime = _UPVALUE2_
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      if _ARG_0_.Workstand_ID == _UPVALUE3_ then
        _ARG_0_.JumpTime = _UPVALUE2_
        _ARG_0_.JumpMax = 0
        _ARG_0_.Gravity = 0.1
        _ARG_0_.JumpPow = 0.5
      else
        _ARG_0_.JumpTime = _UPVALUE2_
        _ARG_0_.JumpMax = 0
        _ARG_0_.Gravity = 0.1
        _ARG_0_.JumpPow = 2
      end
      _ARG_0_.HomingFlag = 1
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 360)
      Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.targetHandle)
      _ARG_0_:setMotion(_UPVALUE0_)
      _ARG_0_.step = _UPVALUE1_
      Entity.EnableGravity(_ARG_0_.myHandle, 0)
      _ARG_0_.DamageCnt = 0
      _ARG_0_.RodeoInAttackFlag = 0
      _ARG_0_.PlayerEnshriningFlag = 0
      _ARG_0_.AttackFlag = 0
      _ARG_0_.AttackCnt = 0
      _ARG_0_.WarkstandFlag = 0
      _ARG_0_.BodyPressOnWorkstand = 0
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_.AttackFlag = 0
      Entity.ClearSpeed(_ARG_0_.myHandle)
      Entity.EnableGravity(_ARG_0_.myHandle, 1)
      Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
      Entity.SetMovementCollRadius(_ARG_0_.myHandle, 1.7)
      Entity.SetLowerHalf(_ARG_0_.myHandle, 2)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == _UPVALUE0_ then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > _UPVALUE1_ then
          _ARG_0_.step = _UPVALUE2_
        end
      elseif _ARG_0_.step == _UPVALUE2_ then
        if _ARG_0_.JumpTime < 0 then
          Entity.SetMovementCollRadius(_ARG_0_.myHandle, 6.7)
          Entity.SetLowerHalf(_ARG_0_.myHandle, 7)
          _ARG_0_.step = _UPVALUE3_
          _ARG_0_:setMotion(_UPVALUE4_)
          _ARG_0_.workVec1:set(19.5, 3.91, 26.2)
          if Entity.CalcDistanceXZSq(_ARG_0_.targetHandle, _ARG_0_.workVec1) < 49 then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE4_, 0, 0)
          else
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE4_, 0, 1)
          end
          if _ARG_0_.AttackCnt == 0 and _ARG_0_.AttackFlag == 1 then
            _ARG_0_.AttackCnt = _ARG_0_.AttackCnt + 1
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE4_, 0, 1)
          end
        end
        if 0 > _ARG_0_.JumpPow then
        else
          _ARG_0_.JumpPow = _ARG_0_.JumpPow - _ARG_0_.Gravity * Entity.GetFrameRate(_ARG_0_.myHandle)
        end
      elseif _ARG_0_.step == _UPVALUE3_ then
        Entity.SetMovementCollRadius(_ARG_0_.myHandle, 1.7)
        Entity.SetLowerHalf(_ARG_0_.myHandle, 2)
        _ARG_0_.JumpPow = _ARG_0_.JumpPow - _ARG_0_.Gravity * Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.AttackCnt == 0 and _ARG_0_.AttackFlag == 1 then
          _ARG_0_.AttackCnt = _ARG_0_.AttackCnt + 1
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE4_, 0, 1)
        end
        if Entity.IsGround(_ARG_0_.myHandle) then
          if _ARG_0_:CheckMyOnWorkstand() then
            _ARG_0_.BodyPressOnWorkstand = 1
          end
          if _ARG_0_.WarkstandFlag == 0 then
            if _ARG_0_.AttackFlag == 0 then
              _ARG_0_.RodeoInAttackFlag = 1
            elseif _ARG_0_.AttackFlag == 1 then
              _ARG_0_.RodeoInAttackFlag = 0
            end
          end
          Camera.QuakeV(80, 0.32, 8)
          _ARG_0_.step = _UPVALUE5_
          if _ARG_0_.AttackCnt == 0 then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE6_, 0, 0)
          else
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE6_, 0, 1)
          end
        end
      elseif _ARG_0_.step == _UPVALUE5_ then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          if _ARG_0_.WarkstandFlag == 0 then
            _ARG_0_.step = _UPVALUE7_
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE8_)
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE9_)
            return
          else
            _ARG_0_:GotoState("Workstand_1_Rotation")
          end
        end
      elseif _ARG_0_.step == _UPVALUE7_ and Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
        _ARG_0_.RodeoInAttackFlag = 0
        _ARG_0_.DamageCnt = 0
        return
      end
      if (_ARG_0_.step == _UPVALUE5_ or _ARG_0_.step == _UPVALUE7_) and _ARG_0_.WarkstandFlag == 0 then
        if _ARG_0_.AttackFlag == 0 then
          _ARG_0_.RodeoInAttackFlag = 1
        elseif _ARG_0_.AttackFlag == 1 then
          _ARG_0_.RodeoInAttackFlag = 0
        end
      end
      _ARG_0_.JumpTime = _ARG_0_.JumpTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      if _ARG_0_.step == _UPVALUE0_ then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= _UPVALUE1_ then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 30)
          Entity.GetWorldPos(_ARG_0_.MyPos, _ARG_0_.myHandle)
          Entity.GetVelocity(_ARG_0_.WorkVec2, _ARG_0_.targetHandle)
          _ARG_0_.WorkVec2:scale(16)
          Entity.GetWorldPos2(_ARG_0_.PlayerPos, _ARG_0_.targetHandle, _ARG_0_.WorkVec2)
          _ARG_0_.WorkNumber = Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) / _UPVALUE10_
          FVECTOR3.Sub(_ARG_0_.velocity, _ARG_0_.PlayerPos, _ARG_0_.MyPos)
          _ARG_0_.velocity:normalize()
          _ARG_0_.velocity:scale(_ARG_0_.WorkNumber)
          _ARG_0_.velocity:sety(_ARG_0_.JumpPow)
          Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
          Entity.EnableLockon(_ARG_0_.myHandle, 0)
        end
      elseif _ARG_0_.step == _UPVALUE2_ then
        Entity.GetWorldPos(_ARG_0_.MyPos, _ARG_0_.myHandle)
        Entity.GetVelocity(_ARG_0_.WorkVec2, _ARG_0_.targetHandle)
        _ARG_0_.WorkVec2:scale(2)
        Entity.GetWorldPos2(_ARG_0_.PlayerPos, _ARG_0_.targetHandle, _ARG_0_.WorkVec2)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.PlayerPos, 0.2)
        FVECTOR3.Sub(_ARG_0_.velocity, _ARG_0_.PlayerPos, _ARG_0_.MyPos)
        _ARG_0_.velocity:normalize()
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 9 then
          _ARG_0_.WorkNumber = Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) / 25
        else
          _ARG_0_.WorkNumber = Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) / 35
        end
        _ARG_0_.velocity:scale(_ARG_0_.WorkNumber)
        _ARG_0_.velocity:sety(_ARG_0_.JumpPow)
        Entity.GetWorldPos(_ARG_0_.workVec1, _ARG_0_.myHandle)
        if _ARG_0_.workVec1:gety() > 17 then
          _ARG_0_.velocity:sety(0)
        end
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
        Entity.EnableLockon(_ARG_0_.myHandle, 0)
      elseif _ARG_0_.step == _UPVALUE3_ then
        Entity.GetWorldPos(_ARG_0_.MyPos, _ARG_0_.myHandle)
        Entity.GetVelocity(_ARG_0_.WorkVec2, _ARG_0_.targetHandle)
        _ARG_0_.WorkVec2:scale(6)
        Entity.GetWorldPos2(_ARG_0_.PlayerPos, _ARG_0_.targetHandle, _ARG_0_.WorkVec2)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.PlayerPos, 0.2)
        FVECTOR3.Sub(_ARG_0_.velocity, _ARG_0_.PlayerPos, _ARG_0_.MyPos)
        _ARG_0_.velocity:normalize()
        _ARG_0_.WorkNumber = Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) / 45
        _ARG_0_.velocity:scale(_ARG_0_.WorkNumber)
        _ARG_0_.velocity:sety(_ARG_0_.JumpPow)
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
        _ARG_0_.velocity:setz(0)
        _ARG_0_.velocity:setx(0)
        Entity.EnableLockon(_ARG_0_.myHandle, 0)
      elseif _ARG_0_.step == _UPVALUE5_ then
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end
    end
  },
  NecoRodeo = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.step = 0
      _ARG_0_.DamageCnt = 0
      _ARG_0_.RodeoInAttackFlag = 0
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Player.NotifyReaction(_ARG_0_.targetHandle, COMMAND_KIND_HangOn, _ARG_0_.myHandle)
      Entity.SetLockOnBoneNum(_ARG_0_.myHandle, 18)
      Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_.DamageCnt = 0
      _ARG_0_.RodeoInAttackFlag = 0
      _ARG_0_.AttackFlag = 0
      Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
      Entity.SetLockOnBoneNum(_ARG_0_.myHandle, _UPVALUE0_)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if 0 < Player.CheckReaction(_ARG_0_.targetHandle, 0) then
          _ARG_0_.step = 1
        elseif 0 > Player.CheckReaction(_ARG_0_.targetHandle, 0) then
        elseif Player.CheckReaction(_ARG_0_.targetHandle, 0) == 0 then
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.step = 21
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
          return
        end
        return
      elseif _ARG_0_.step == 1 then
        _ARG_0_:GotoState("Rage_running")
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
        Entity.EnableBodyColl(_ARG_0_.targetHandle, 0)
        _ARG_0_.workVec0:set(0, 0, 0)
        Entity.SetOldLocalPos(_ARG_0_.targetHandle, _ARG_0_.workVec0)
        Entity.SetLocalPos(_ARG_0_.targetHandle, _ARG_0_.workVec0)
        Entity.SetRot(_ARG_0_.targetHandle, _ARG_0_.workVec0)
        Entity.AttachCoord(_ARG_0_.myHandle, "hara", _ARG_0_.targetHandle, "Root")
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        end
        return
      elseif _ARG_0_.step == 20 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.step = 21
        end
        return
      else
        if _ARG_0_.step == 21 then
          if 0 < Player.CheckReaction(_ARG_0_.targetHandle, 0) then
            _ARG_0_.step = 1
            return
          elseif 0 > Player.CheckReaction(_ARG_0_.targetHandle, 0) then
          elseif Player.CheckReaction(_ARG_0_.targetHandle, 0) == 0 then
          end
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Player.NotifyReaction(_ARG_0_.targetHandle, 0)
            Entity.SetLockOnBoneNum(_ARG_0_.myHandle, _UPVALUE2_)
            _ARG_0_:GotoState("Idling")
            return
          end
          return
        else
        end
      end
    end
  },
  Rage_running = {
    OnBeginState = function(_ARG_0_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.EnableAttackBgHit(_ARG_0_.myHandle, 0)
      _ARG_0_.AttackBgFlag = 0
      _ARG_0_.AttackFlag = 0
      _ARG_0_.RushWallFlag = 0
      _ARG_0_.step = _UPVALUE1_
      _ARG_0_.WorkTime2 = _UPVALUE0_
      _ARG_0_.WorkTime3 = 0
      _ARG_0_.WorkNumber = 0
      _ARG_0_.OldWorkStandNum = 0
      _ARG_0_.Gravity = 0.04
      _ARG_0_.JumpPow = 0
      _ARG_0_.RodeoPushCnt = 0
      _ARG_0_.RodeoPushFlag = 1
      _ARG_0_.RodeoPushCntF = 0
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE2_)
      Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
    end,
    OnEndState = function(_ARG_0_)
      Entity.SetLockOnBoneNum(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      Player.NotifyReaction(_ARG_0_.targetHandle, 0)
      _ARG_0_.RodeoPushFlag = 0
      Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
      Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.AttackBgFlag == 1 then
        _ARG_0_:Rodeo_relPC()
        return
      end
      if _ARG_0_.step ~= _UPVALUE0_ and _ARG_0_.step ~= _UPVALUE1_ and _ARG_0_.step ~= _UPVALUE2_ and _ARG_0_.step ~= _UPVALUE3_ and _ARG_0_.step ~= _UPVALUE4_ then
        if Player.CheckReaction(_ARG_0_.targetHandle, 1) < 0 then
          if _ARG_0_.step == _UPVALUE5_ then
            _ARG_0_.step = _UPVALUE3_
            _ARG_0_.AttackBgFlag = 0
            _ARG_0_.RushWallFlag = 10
            Player.NotifyReaction(_ARG_0_.targetHandle, 0)
            Entity.GetWorldPos(_ARG_0_.workVec1, _ARG_0_.targetHandle)
            Entity.SetOldLocalPos(_ARG_0_.targetHandle, _ARG_0_.workVec0)
            Entity.SetLocalPos(_ARG_0_.targetHandle, _ARG_0_.workVec1)
            Entity.AttachCoord(NULL_HANDLE, "", _ARG_0_.targetHandle, "Root")
            Entity.SetLockOnBoneNum(_ARG_0_.myHandle, _UPVALUE6_)
          elseif _ARG_0_.step == _UPVALUE7_ then
            _ARG_0_.step = _UPVALUE4_
            _ARG_0_.AttackBgFlag = 0
            _ARG_0_.RushWallFlag = 10
            Player.NotifyReaction(_ARG_0_.targetHandle, 0)
            Entity.GetWorldPos(_ARG_0_.workVec1, _ARG_0_.targetHandle)
            Entity.SetOldLocalPos(_ARG_0_.targetHandle, _ARG_0_.workVec0)
            Entity.SetLocalPos(_ARG_0_.targetHandle, _ARG_0_.workVec1)
            Entity.AttachCoord(NULL_HANDLE, "", _ARG_0_.targetHandle, "Root")
            Entity.SetLockOnBoneNum(_ARG_0_.myHandle, _UPVALUE6_)
          else
            _ARG_0_.AttackBgFlag = 0
            _ARG_0_.RushWallFlag = 10
            _ARG_0_.step = _UPVALUE2_
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_:setMotion(_UPVALUE8_)
            Player.NotifyReaction(_ARG_0_.targetHandle, 0)
            Entity.GetWorldPos(_ARG_0_.workVec1, _ARG_0_.targetHandle)
            Entity.SetOldLocalPos(_ARG_0_.targetHandle, _ARG_0_.workVec0)
            Entity.SetLocalPos(_ARG_0_.targetHandle, _ARG_0_.workVec1)
            Entity.AttachCoord(NULL_HANDLE, "", _ARG_0_.targetHandle, "Root")
            Entity.SetLockOnBoneNum(_ARG_0_.myHandle, _UPVALUE6_)
          end
        elseif Player.CheckReaction(_ARG_0_.targetHandle, 1) > 0 then
          _ARG_0_.step = _UPVALUE9_
          _ARG_0_.RushWallFlag = 1
          Entity.EnableAttackBgHit(_ARG_0_.myHandle, 1)
        elseif Player.CheckReaction(_ARG_0_.targetHandle, 1) == 0 then
        end
        Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.targetHandle)
      elseif Player.CheckReaction(_ARG_0_.targetHandle, 2) == 0 then
        _ARG_0_.RodeoPushFlag = 0
      end
      if _ARG_0_.step == _UPVALUE10_ then
        _ARG_0_:Rotation(DegToRad(_ARG_0_.RushAng))
        _ARG_0_:Move(_UPVALUE11_)
        if not Entity.IsGround(_ARG_0_.myHandle) then
          _ARG_0_.WorkVec2:set(0, 0, 0)
          _ARG_0_.JumpPow = _ARG_0_.JumpPow - _ARG_0_.Gravity * Entity.GetFrameRate(_ARG_0_.myHandle)
          _ARG_0_.WorkVec2:sety(_ARG_0_.JumpPow)
          Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.WorkVec2)
        end
        _ARG_0_.WorkVec1:set(B20CD_ROOMCENTER.x, B20CD_ROOMCENTER.y, B20CD_ROOMCENTER.z)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.WorkVec1, 1.4)
        if Entity.IsWall(_ARG_0_.myHandle) then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.WorkVec1, 3.4)
        end
        Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.targetHandle)
        if 0 > _ARG_0_.WorkTime then
          _ARG_0_.WorkTime = 30
          _ARG_0_.RushAng = Script.Random() * _UPVALUE12_ - _UPVALUE12_ / 2
        end
        if 0 <= Player.IsNowPushOn(_ARG_0_.targetHandle) then
          if _ARG_0_.RodeoPushCnt <= 3 then
            if Script.Random() < 0.5 then
              _ARG_0_.step = _UPVALUE13_
              _ARG_0_.WorkNumber = 1
              _ARG_0_:CheckWorkstand()
              if 0 < _ARG_0_.RushAng then
                _ARG_0_.RushAng = Script.Random() * (_UPVALUE12_ / 4) + _UPVALUE12_ / 4
              else
                _ARG_0_.RushAng = -(Script.Random() * (_UPVALUE12_ / 4)) - _UPVALUE12_ / 4
              end
              Entity.ClearSpeed(_ARG_0_.myHandle)
            else
              _ARG_0_.step = _UPVALUE14_
              if 0 < _ARG_0_.RushAng then
                _ARG_0_.RushAng = Script.Random() * (_UPVALUE12_ / 3) + _UPVALUE12_ / 3
              else
                _ARG_0_.RushAng = -(Script.Random() * (_UPVALUE12_ / 3)) - _UPVALUE12_ / 3
              end
              Entity.ClearSpeed(_ARG_0_.myHandle)
            end
          else
            _ARG_0_.step = _UPVALUE14_
            if 0 < _ARG_0_.RushAng then
              _ARG_0_.RushAng = Script.Random() * (_UPVALUE12_ / 3) + _UPVALUE12_ / 3
            else
              _ARG_0_.RushAng = -(Script.Random() * (_UPVALUE12_ / 3)) - _UPVALUE12_ / 3
            end
            Entity.ClearSpeed(_ARG_0_.myHandle)
          end
        end
      elseif _ARG_0_.step == _UPVALUE14_ then
        if 0 < Entity.GetMotionNowFrame(_ARG_0_.myHandle) and Entity.GetMotionNowFrame(_ARG_0_.myHandle) < 22 then
          _ARG_0_.WorkVec2:set(0, 0, 0)
          _ARG_0_.JumpPow = _ARG_0_.JumpPow - _ARG_0_.Gravity * Entity.GetFrameRate(_ARG_0_.myHandle)
          _ARG_0_.WorkVec2:sety(_ARG_0_.JumpPow)
          Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.WorkVec2)
          _ARG_0_:Move(_UPVALUE11_)
          _ARG_0_:Rotation(DegToRad(_ARG_0_.RushAng))
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.WorkVec1, 1.4)
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) and Entity.IsGround(_ARG_0_.myHandle) then
          _ARG_0_.Gravity = 0.04
          _ARG_0_.JumpPow = 0.4
        end
        Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.targetHandle)
        if Player.IsNowPushOn(_ARG_0_.targetHandle) == -1 then
          _ARG_0_.step = _UPVALUE10_
        end
      elseif _ARG_0_.step == _UPVALUE9_ then
        Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.targetHandle)
        _ARG_0_:Move(_UPVALUE11_ * 1.1)
        if _ARG_0_.WorkTime3 > _UPVALUE15_ * 1.1 and Entity.IsWall(_ARG_0_.myHandle) then
          _ARG_0_:Rodeo_relPC()
          return
        end
        if not Entity.IsGround(_ARG_0_.myHandle) then
          _ARG_0_.WorkVec2:set(0, 0, 0)
          _ARG_0_.JumpPow = _ARG_0_.JumpPow - _ARG_0_.Gravity * Entity.GetFrameRate(_ARG_0_.myHandle)
          _ARG_0_.WorkVec2:sety(_ARG_0_.JumpPow)
          Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.WorkVec2)
        end
      elseif _ARG_0_.step == _UPVALUE13_ then
        _ARG_0_.WorkVec:set(_UPVALUE16_[_ARG_0_.Workstand_ID].x, _UPVALUE16_[_ARG_0_.Workstand_ID].y, _UPVALUE16_[_ARG_0_.Workstand_ID].z)
        if _ARG_0_:CheckTargetPos(_UPVALUE16_[_ARG_0_.Workstand_ID].x, _UPVALUE16_[_ARG_0_.Workstand_ID].y, _UPVALUE16_[_ARG_0_.Workstand_ID].z, 1.6) == false then
          _ARG_0_.step = _UPVALUE17_
        end
        _ARG_0_:Move(_UPVALUE11_)
      elseif _ARG_0_.step == _UPVALUE17_ then
        _ARG_0_.WorkVec:set(_UPVALUE16_[_ARG_0_.Workstand_ID].x, _UPVALUE16_[_ARG_0_.Workstand_ID].y, _UPVALUE16_[_ARG_0_.Workstand_ID].z)
        _ARG_0_:Move(_UPVALUE11_)
        if Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec) < _ARG_0_.WorkstandDist then
          _ARG_0_:Rotation(DegToRad(_ARG_0_.RushAng))
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_.step = _UPVALUE5_
          end
          return
        end
        _ARG_0_:CheckTargetPos(_UPVALUE16_[_ARG_0_.Workstand_ID].x, _UPVALUE16_[_ARG_0_.Workstand_ID].y, _UPVALUE16_[_ARG_0_.Workstand_ID].z, 5)
      elseif _ARG_0_.step == _UPVALUE5_ then
        _ARG_0_.WorkVec:set(_UPVALUE16_[_ARG_0_.Workstand_ID].x, _UPVALUE16_[_ARG_0_.Workstand_ID].y, _UPVALUE16_[_ARG_0_.Workstand_ID].z)
        if 0 < Entity.GetMotionNowFrame(_ARG_0_.myHandle) and Entity.GetMotionNowFrame(_ARG_0_.myHandle) < 22 then
          Entity.SetMotionSpeed(_ARG_0_.myHandle, 0.8)
          _ARG_0_.WorkVec2:set(0, 0, 0)
          _ARG_0_.JumpPow = _ARG_0_.JumpPow - _ARG_0_.Gravity * Entity.GetFrameRate(_ARG_0_.myHandle)
          _ARG_0_.WorkVec2:sety(_ARG_0_.JumpPow)
          Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.WorkVec2)
          _ARG_0_.WorkVec:set(_UPVALUE16_[_ARG_0_.Workstand_ID].x, _UPVALUE16_[_ARG_0_.Workstand_ID].y, _UPVALUE16_[_ARG_0_.Workstand_ID].z)
          _ARG_0_.velocity:set(0, 0, Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec) / _ARG_0_.JumpSpeedRate)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.WorkVec, 20)
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) and Entity.IsGround(_ARG_0_.myHandle) then
          _ARG_0_.step = _UPVALUE7_
          _ARG_0_.Gravity = 0.04
          _ARG_0_.JumpPow = 0.4
          _ARG_0_:Rotation(DegToRad(180))
        end
        Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.targetHandle)
      elseif _ARG_0_.step == _UPVALUE7_ then
        _ARG_0_.WorkVec:set(_UPVALUE16_[_ARG_0_.Workstand_ID].x, _UPVALUE16_[_ARG_0_.Workstand_ID].y, _UPVALUE16_[_ARG_0_.Workstand_ID].z)
        if 0 < Entity.GetMotionNowFrame(_ARG_0_.myHandle) and Entity.GetMotionNowFrame(_ARG_0_.myHandle) < 22 then
          _ARG_0_.WorkVec2:set(0, 0, 0)
          _ARG_0_.JumpPow = _ARG_0_.JumpPow - _ARG_0_.Gravity * Entity.GetFrameRate(_ARG_0_.myHandle)
          _ARG_0_.WorkVec2:sety(_ARG_0_.JumpPow)
          Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.WorkVec2)
        end
        _ARG_0_:Move(_UPVALUE11_ * 2)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) and Entity.IsGround(_ARG_0_.myHandle) then
          _ARG_0_.step = _UPVALUE10_
          Entity.ClearSpeed(_ARG_0_.myHandle)
          Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
        end
      elseif _ARG_0_.step == _UPVALUE18_ then
        _ARG_0_.WorkTime2 = _UPVALUE15_
        _ARG_0_.step = _UPVALUE10_
      elseif _ARG_0_.step == _UPVALUE0_ then
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        if not Entity.IsGround(_ARG_0_.myHandle) then
          _ARG_0_.WorkVec2:set(0, 0, 0)
          _ARG_0_.JumpPow = _ARG_0_.JumpPow - _ARG_0_.Gravity * Entity.GetFrameRate(_ARG_0_.myHandle)
          _ARG_0_.WorkVec2:sety(_ARG_0_.JumpPow)
          Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.WorkVec2)
        end
        if 0 > _ARG_0_.WorkTime and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE19_)
          _ARG_0_.step = _UPVALUE1_
        end
        FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, -0.12)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
        if 0 > _ARG_0_.WorkTime2 then
          Entity.ClearSpeed(_ARG_0_.myHandle)
        end
      elseif _ARG_0_.step == _UPVALUE1_ then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:SelectWorkstand()
          _ARG_0_:GotoState("Workstand_Turn")
          Player.NotifyReaction(_ARG_0_.targetHandle, 0)
          return
        end
      elseif _ARG_0_.step == _UPVALUE2_ then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:SelectWorkstand()
          _ARG_0_:GotoState("Workstand_Turn")
          Player.NotifyReaction(_ARG_0_.targetHandle, 0)
          return
        end
      elseif _ARG_0_.step == _UPVALUE3_ then
        _ARG_0_.WorkVec:set(_UPVALUE16_[_ARG_0_.Workstand_ID].x, _UPVALUE16_[_ARG_0_.Workstand_ID].y, _UPVALUE16_[_ARG_0_.Workstand_ID].z)
        if 0 < Entity.GetMotionNowFrame(_ARG_0_.myHandle) and Entity.GetMotionNowFrame(_ARG_0_.myHandle) < 22 then
          _ARG_0_.WorkVec2:set(0, 0, 0)
          _ARG_0_.JumpPow = _ARG_0_.JumpPow - _ARG_0_.Gravity * Entity.GetFrameRate(_ARG_0_.myHandle)
          _ARG_0_.WorkVec2:sety(_ARG_0_.JumpPow)
          Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.WorkVec2)
          _ARG_0_.WorkVec:set(_UPVALUE16_[_ARG_0_.Workstand_ID].x, _UPVALUE16_[_ARG_0_.Workstand_ID].y, _UPVALUE16_[_ARG_0_.Workstand_ID].z)
          _ARG_0_.velocity:set(0, 0, Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec) / _ARG_0_.JumpSpeedRate)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.WorkVec, 20)
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) and Entity.IsGround(_ARG_0_.myHandle) then
          _ARG_0_.step = _UPVALUE4_
          _ARG_0_.Gravity = 0.04
          _ARG_0_.JumpPow = 0.4
          _ARG_0_:Rotation(DegToRad(180))
        end
        Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.targetHandle)
      elseif _ARG_0_.step == _UPVALUE4_ then
        _ARG_0_.WorkVec:set(_UPVALUE16_[_ARG_0_.Workstand_ID].x, _UPVALUE16_[_ARG_0_.Workstand_ID].y, _UPVALUE16_[_ARG_0_.Workstand_ID].z)
        if 0 < Entity.GetMotionNowFrame(_ARG_0_.myHandle) and Entity.GetMotionNowFrame(_ARG_0_.myHandle) < 22 then
          _ARG_0_.WorkVec2:set(0, 0, 0)
          _ARG_0_.JumpPow = _ARG_0_.JumpPow - _ARG_0_.Gravity * Entity.GetFrameRate(_ARG_0_.myHandle)
          _ARG_0_.WorkVec2:sety(_ARG_0_.JumpPow)
          Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.WorkVec2)
        end
        _ARG_0_:Move(_UPVALUE11_ * 2)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) and Entity.IsGround(_ARG_0_.myHandle) then
          _ARG_0_.step = _UPVALUE2_
          _ARG_0_.AttackBgFlag = 0
          _ARG_0_.RushWallFlag = 10
          Entity.ClearSpeed(_ARG_0_.myHandle)
          _ARG_0_:setMotion(_UPVALUE8_)
        end
      elseif _ARG_0_.step == _UPVALUE20_ and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:SelectWorkstand()
        _ARG_0_:GotoState("Workstand_Turn")
        Player.NotifyReaction(_ARG_0_.targetHandle, 0)
        return
      end
      if _ARG_0_.RodeoPushCntF == 0 then
        if 0 <= Player.IsNowPushOn(_ARG_0_.targetHandle) then
          _ARG_0_.RodeoPushCntF = 1
          _ARG_0_.RodeoPushCnt = _ARG_0_.RodeoPushCnt + 1
        end
      elseif Player.IsNowPushOn(_ARG_0_.targetHandle) == -1 then
        _ARG_0_.RodeoPushCntF = 0
      end
      _ARG_0_.WorkTime = _ARG_0_.WorkTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      _ARG_0_.WorkTime2 = _ARG_0_.WorkTime2 - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      _ARG_0_.WorkTime3 = _ARG_0_.WorkTime3 + 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
    end
  },
  Damage = {
    OnBeginState = function(_ARG_0_)
      if Enemy.IsAttackerFront(_ARG_0_.myHandle) then
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      else
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
      end
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:SelectWorkstand()
        _ARG_0_:GotoState("Workstand_Turn")
        _ARG_0_.DamageFlag = 0
        _ARG_0_.DamagePoint = 0
        _ARG_0_.DamageCnt = 0
        _ARG_0_.AttackFalg = 0
      end
    end
  },
  BigDamage = {
    OnBeginState = function(_ARG_0_)
      if Enemy.IsAttackerFront(_ARG_0_.myHandle) then
        _ARG_0_.stack:push(_UPVALUE0_)
        _ARG_0_.stack:push(_UPVALUE1_)
      else
        _ARG_0_.stack:push(_UPVALUE2_)
        _ARG_0_.stack:push(_UPVALUE3_)
      end
      _ARG_0_:setMotion(_ARG_0_.stack:pop(1))
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE4_)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_.DamageFlag = 0
      _ARG_0_.DamagePoint = 0
      _ARG_0_.DamageCnt = 0
      _ARG_0_.AttackFalg = 0
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:setMotion(_ARG_0_.stack:pop(1))
          _ARG_0_.step = 1
        end
      elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:SelectWorkstand()
        _ARG_0_:GotoState("Workstand_Turn")
      end
    end
  },
  Faint = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_:setMotion(MOTION_FAINT)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:setMotion(_UPVALUE0_)
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Moveunder_Affter")
      end
    end
  },
  RodeoFinish = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.stack:push(_UPVALUE0_)
      _ARG_0_.stack:push(_UPVALUE1_)
      _ARG_0_:setMotion(_ARG_0_.stack:pop(1))
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE2_)
      _ARG_0_.step = 0
      _ARG_0_.WorkTime = 10
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, 0.2)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
        if 0 > _ARG_0_.WorkTime then
          Entity.ClearSpeed(_ARG_0_.myHandle)
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:setMotion(_ARG_0_.stack:pop(1))
          _ARG_0_.step = 1
        end
        _ARG_0_.WorkTime = _ARG_0_.WorkTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:SelectWorkstand()
        _ARG_0_:GotoState("Workstand_Turn")
        Player.NotifyReaction(_ARG_0_.targetHandle, 0)
      end
    end
  },
  Restplace_Move = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_:setMotion(_UPVALUE0_)
      print("b20cd00::Restplace_Move Start\n")
      _ARG_0_.step = 0
      _ARG_0_:CheckWorkstand_Rest()
      _ARG_0_.RestFlag = 1
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_:GotoState("Workstand_Turn")
    end
  },
  Rest = {
    OnBeginState = function(_ARG_0_)
      print("b20cd00::Rest Start\n")
      _ARG_0_:setMotion(_UPVALUE0_)
      _ARG_0_.RestFlag = 1
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      _ARG_0_.RestFlag = 0
      _ARG_0_.PlayerEnshriningTime = 0
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE0_ then
        _ARG_0_:GotoState("Moveunder")
        return
      end
      if _ARG_0_:CheckPlayerEnshrining() == 1 or _ARG_0_:CheckPlayerOnWarkstand() == 1 then
        return
      end
      print("\139x\140e\143I\151\185!\n")
      if Script.Random() < _UPVALUE1_ then
        _ARG_0_:GotoState("BodyPress")
      elseif Script.Random() < 0.2 then
        _ARG_0_:GotoState("Moveunder")
      end
    end
  },
  Standby = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
    end,
    OnEndState = function(_ARG_0_)
      Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
    end,
    OnUpdate = function(_ARG_0_)
      if Enemy.IsAllEnemyWaiting() == false then
        _ARG_0_:GotoState("Idling")
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
      end
    end
  },
  Dead = {
    OnBeginState = function(_ARG_0_)
      Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
    end
  },
  Disappear = {
    OnBeginState = function(_ARG_0_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
    end
  }
}
function b20cd00.SelectWorkstand(_ARG_0_)
  if _ARG_0_.Workstand_ID == _UPVALUE0_ then
  else
  end
  for _FORV_5_ = 0, 100 do
    if _UPVALUE4_ == 1 then
    end
    if 1 > Script.GetDebugAttackNumber() then
      _ARG_0_.JumpTime = 0
      _ARG_0_.JumpMax = 5
      _ARG_0_.Gravity = 0.075
      _ARG_0_.JumpPow = 1.2
      _ARG_0_.JumpSpeedRate = 15
      _ARG_0_.WorkstandDist = 11
      _ARG_0_.Workstand_ID = _UPVALUE5_
    elseif Script.GetDebugAttackNumber() < 2 then
      _ARG_0_.JumpTime = 0
      _ARG_0_.JumpMax = 5
      _ARG_0_.Gravity = 0.1
      _ARG_0_.JumpPow = 1.2
      _ARG_0_.JumpSpeedRate = 10
      _ARG_0_.WorkstandDist = 12
      _ARG_0_.Workstand_ID = _UPVALUE3_
    elseif Script.GetDebugAttackNumber() < 3 then
      _ARG_0_.JumpTime = 0
      _ARG_0_.JumpMax = 5
      _ARG_0_.Gravity = 0.075
      _ARG_0_.JumpPow = 1.2
      _ARG_0_.JumpSpeedRate = 10
      _ARG_0_.WorkstandDist = 9
      _ARG_0_.Workstand_ID = _UPVALUE1_
    elseif Script.GetDebugAttackNumber() < 4 then
      _ARG_0_.JumpTime = 0
      _ARG_0_.JumpMax = 5
      _ARG_0_.Gravity = 0.075
      _ARG_0_.JumpPow = 1.3
      _ARG_0_.JumpSpeedRate = 15
      _ARG_0_.WorkstandDist = 9
      _ARG_0_.Workstand_ID = _UPVALUE6_
    elseif Script.GetDebugAttackNumber() < 5 then
      _ARG_0_.JumpTime = 0
      _ARG_0_.JumpMax = 5
      _ARG_0_.Gravity = 0.075
      _ARG_0_.JumpPow = 1.3
      _ARG_0_.JumpSpeedRate = 15
      _ARG_0_.WorkstandDist = 12
      _ARG_0_.Workstand_ID = _UPVALUE7_
    elseif 6 > Script.GetDebugAttackNumber() then
      _ARG_0_.JumpTime = 0
      _ARG_0_.JumpMax = 5
      _ARG_0_.Gravity = 0.075
      _ARG_0_.JumpPow = 1.3
      _ARG_0_.JumpSpeedRate = 15
      _ARG_0_.WorkstandDist = 12
      _ARG_0_.Workstand_ID = _UPVALUE8_
    else
      _ARG_0_.JumpTime = 0
      _ARG_0_.JumpMax = 5
      _ARG_0_.Gravity = 0.075
      _ARG_0_.JumpPow = 1.2
      _ARG_0_.JumpSpeedRate = 15
      _ARG_0_.WorkstandDist = 12
      _ARG_0_.Workstand_ID = _UPVALUE7_
    end
    if _UPVALUE3_ == _ARG_0_.Workstand_ID then
    else
      Entity.GetWorldPos(_ARG_0_.workVec1, _ARG_0_.myHandle)
      _ARG_0_.WorkVec2:set(_UPVALUE9_[_ARG_0_.Workstand_ID].x, _UPVALUE9_[_ARG_0_.Workstand_ID].y, _UPVALUE9_[_ARG_0_.Workstand_ID].z)
      if _ARG_0_.workVec1:getx() < -13.61 then
      end
      _ARG_0_.WorkVec:set(20.2706, 0, -2.1142)
      if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.WorkVec) < 16 then
      end
      _ARG_0_.WorkVec:set(-20.2706, 0, -2.1142)
      if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.WorkVec) < 16 then
      end
      if _ARG_0_.workVec1:getz() > 13 then
      end
      if 0 == 1 then
        return
      end
    end
  end
end
function b20cd00.CheckWorkstand(_ARG_0_)
  Entity.GetWorldPos(_ARG_0_.workVec1, _ARG_0_.myHandle)
  for _FORV_7_ = 0, 100 do
    for _FORV_12_ = 1, 6 do
      if _FORV_12_ == 7 then
        return
      end
      if _FORV_12_ ~= 2 and _FORV_12_ ~= 3 and _ARG_0_.OldWorkStandNum ~= _FORV_12_ then
        _ARG_0_.WorkVec2:set(_UPVALUE0_[_FORV_12_].x, _UPVALUE0_[_FORV_12_].y, _UPVALUE0_[_FORV_12_].z)
        if 1.0E10 > Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.WorkVec2) then
        end
      end
    end
    if _FORV_12_ <= 1 then
      _ARG_0_.Gravity = 0.031999998
      _ARG_0_.JumpPow = 0.6
      _ARG_0_.JumpSpeedRate = 12
      _ARG_0_.WorkstandDist = 9
      _ARG_0_.Workstand_ID = _UPVALUE1_
    elseif _FORV_12_ <= 4 then
      _ARG_0_.Gravity = 0.031999998
      _ARG_0_.JumpPow = 0.6
      _ARG_0_.JumpSpeedRate = 15
      _ARG_0_.WorkstandDist = 9
      _ARG_0_.Workstand_ID = _UPVALUE2_
    elseif _FORV_12_ <= 5 then
      _ARG_0_.Gravity = 0.026666665
      _ARG_0_.JumpPow = 0.6
      _ARG_0_.JumpSpeedRate = 12
      _ARG_0_.WorkstandDist = 9
      _ARG_0_.Workstand_ID = _UPVALUE3_
    elseif _FORV_12_ <= 6 then
      _ARG_0_.Gravity = 0.031999998
      _ARG_0_.JumpPow = 0.6
      _ARG_0_.JumpSpeedRate = 15
      _ARG_0_.WorkstandDist = 9
      _ARG_0_.Workstand_ID = _UPVALUE4_
    end
    if 0 == 1 then
      _ARG_0_.OldWorkStandNum = _ARG_0_.Workstand_ID
      return
    end
  end
end
function b20cd00.CheckWorkstand_Rest(_ARG_0_)
  Entity.GetWorldPos(_ARG_0_.workVec1, _ARG_0_.myHandle)
  for _FORV_9_ = 1, 6 do
    if _FORV_9_ == 7 then
      return
    end
    _ARG_0_.WorkVec2:set(_UPVALUE0_[_FORV_9_].x, _UPVALUE0_[_FORV_9_].y, _UPVALUE0_[_FORV_9_].z)
    if 0 < Entity.CalcDistanceSq(Player.GetHandle(), _ARG_0_.WorkVec2) then
    end
  end
  if _FORV_9_ <= 1.5 then
    _ARG_0_.JumpTime = 0
    _ARG_0_.JumpMax = 5
    _ARG_0_.Gravity = 0.075
    _ARG_0_.JumpPow = 1.2
    _ARG_0_.JumpSpeedRate = 15
    _ARG_0_.WorkstandDist = 11
    _ARG_0_.Workstand_ID = _UPVALUE1_
  elseif _FORV_9_ <= 2.5 then
    _ARG_0_.JumpTime = 0
    _ARG_0_.JumpMax = 5
    _ARG_0_.Gravity = 0.1
    _ARG_0_.JumpPow = 1.2
    _ARG_0_.JumpSpeedRate = 10
    _ARG_0_.WorkstandDist = 12
    _ARG_0_.Workstand_ID = _UPVALUE2_
  elseif _FORV_9_ <= 3.5 then
    _ARG_0_.JumpTime = 0
    _ARG_0_.JumpMax = 5
    _ARG_0_.Gravity = 0.075
    _ARG_0_.JumpPow = 1.2
    _ARG_0_.JumpSpeedRate = 10
    _ARG_0_.WorkstandDist = 9
    _ARG_0_.Workstand_ID = _UPVALUE3_
  elseif _FORV_9_ <= 4.5 then
    _ARG_0_.JumpTime = 0
    _ARG_0_.JumpMax = 5
    _ARG_0_.Gravity = 0.075
    _ARG_0_.JumpPow = 1.3
    _ARG_0_.JumpSpeedRate = 15
    _ARG_0_.WorkstandDist = 9
    _ARG_0_.Workstand_ID = _UPVALUE4_
  elseif _FORV_9_ <= 5.5 then
    _ARG_0_.JumpTime = 0
    _ARG_0_.JumpMax = 5
    _ARG_0_.Gravity = 0.075
    _ARG_0_.JumpPow = 1.3
    _ARG_0_.JumpSpeedRate = 15
    _ARG_0_.WorkstandDist = 12
    _ARG_0_.Workstand_ID = _UPVALUE5_
  elseif _FORV_9_ <= 6.5 then
    _ARG_0_.JumpTime = 0
    _ARG_0_.JumpMax = 5
    _ARG_0_.Gravity = 0.075
    _ARG_0_.JumpPow = 1.3
    _ARG_0_.JumpSpeedRate = 15
    _ARG_0_.WorkstandDist = 12
    _ARG_0_.Workstand_ID = _UPVALUE6_
  else
    _ARG_0_.JumpTime = 0
    _ARG_0_.JumpMax = 5
    _ARG_0_.Gravity = 0.1
    _ARG_0_.JumpPow = 1.2
    _ARG_0_.JumpSpeedRate = 10
    _ARG_0_.WorkstandDist = 12
    _ARG_0_.Workstand_ID = _UPVALUE2_
  end
end
function b20cd00.initMoveunder(_ARG_0_)
  _UPVALUE0_ = 0.6
  if Script.Random() < 0.3333 then
    _ARG_0_.JampAng = -Script.Random() * 0.08
  else
    if Script.Random() < 0.666 then
      _ARG_0_.JampAng = Script.Random() * 0.08
    else
    end
  end
  _ARG_0_.JampAng = 0
  if _ARG_0_.Workstand_ID == 1 then
    _ARG_0_.JumpTime = 0
    _ARG_0_.JumpMax = 5
    _ARG_0_.Gravity = 0.05
    _ARG_0_.JumpPow = 0.14
  elseif _ARG_0_.Workstand_ID == 2 then
    _ARG_0_.JumpTime = 0
    _ARG_0_.JumpMax = 5
    _ARG_0_.Gravity = 0.065
    _ARG_0_.JumpPow = 0.6
    _UPVALUE0_ = 0.35
  elseif _ARG_0_.Workstand_ID == 3 then
    _ARG_0_.JumpTime = 0
    _ARG_0_.JumpMax = 5
    _ARG_0_.Gravity = 0.065
    _ARG_0_.JumpPow = 0.6
    _UPVALUE0_ = 0.3
  elseif _ARG_0_.Workstand_ID == 4 then
    _ARG_0_.JumpTime = 0
    _ARG_0_.JumpMax = 5
    _ARG_0_.Gravity = 0.05
    _ARG_0_.JumpPow = 0.14
  elseif _ARG_0_.Workstand_ID == 5 then
    _ARG_0_.JumpTime = 0
    _ARG_0_.JumpMax = 5
    _ARG_0_.Gravity = 0.05
    _ARG_0_.JumpPow = 0.14
  elseif _ARG_0_.Workstand_ID == 6 then
    _ARG_0_.JumpTime = 0
    _ARG_0_.JumpMax = 5
    _ARG_0_.Gravity = 0.05
    _ARG_0_.JumpPow = 0.14
  else
    _ARG_0_.JumpTime = 0
    _ARG_0_.JumpMax = 5
    _ARG_0_.Gravity = 0.05
    _ARG_0_.JumpPow = 0.14
  end
end
function b20cd00.Rotation(_ARG_0_, _ARG_1_)
  Entity.GetRot(_ARG_0_.WorkVec, _ARG_0_.myHandle)
  _ARG_0_.WorkVec:set(0, _ARG_0_.WorkVec:gety() + _ARG_1_, 0)
  Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function b20cd00.RotationBone(_ARG_0_, _ARG_1_, _ARG_2_)
end
function b20cd00.RotationEx(_ARG_0_, _ARG_1_)
  if Entity.GetMotionNowFrame(_ARG_0_.myHandle) - Entity.GetMotionOldFrame(_ARG_0_.myHandle) < 0 then
  else
  end
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  _ARG_0_.rot:sety(RoundPI(_ARG_0_.rot:gety() + DegToRad((Entity.GetMotionNowFrame(_ARG_0_.myHandle) - Entity.GetMotionOldFrame(_ARG_0_.myHandle)) * (90 / Entity.GetMotionTotalFrame(_ARG_0_.myHandle))) * _ARG_1_))
  Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
  return DegToRad((Entity.GetMotionNowFrame(_ARG_0_.myHandle) - Entity.GetMotionOldFrame(_ARG_0_.myHandle)) * (90 / Entity.GetMotionTotalFrame(_ARG_0_.myHandle))) * _ARG_1_
end
function b20cd00.Neck(_ARG_0_)
  if Entity.GetCurrentMotion(_ARG_0_.myHandle) == _UPVALUE0_ or Entity.GetCurrentMotion(_ARG_0_.myHandle) == _UPVALUE1_ or Entity.GetCurrentMotion(_ARG_0_.myHandle) == _UPVALUE2_ then
    Entity.GetWorldPos(_ARG_0_.PlayerPos, _ARG_0_.targetHandle, _UPVALUE3_)
    Entity.GetWorldPos(_ARG_0_.NeckPos, _ARG_0_.myHandle, _UPVALUE4_)
    Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
    FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.PlayerPos, _ARG_0_.NeckPos)
    FVECTOR3.normalize(_ARG_0_.workVec)
    _ARG_0_.oldAngly, _ARG_0_.oldAnglx = HomingDegree(_ARG_0_.oldAngly, Math.Atan2(_ARG_0_.workVec:getx(), _ARG_0_.workVec:getz()) - _ARG_0_.rot:gety(), 2, (Entity.GetFrameRate(_ARG_0_.myHandle))), HomingDegree(_ARG_0_.oldAnglx, -Math.Atan2(_ARG_0_.workVec:gety(), Math.Sqrt(_ARG_0_.workVec:getz() * _ARG_0_.workVec:getz() + _ARG_0_.workVec:getx() * _ARG_0_.workVec:getx())), 2, (Entity.GetFrameRate(_ARG_0_.myHandle)))
    _ARG_0_.NeckAngle:set(0, ROUND_PI(HomingDegree(_ARG_0_.oldAngly, Math.Atan2(_ARG_0_.workVec:getx(), _ARG_0_.workVec:getz()) - _ARG_0_.rot:gety(), 2, (Entity.GetFrameRate(_ARG_0_.myHandle))) * -1), ROUND_PI((HomingDegree(_ARG_0_.oldAnglx, -Math.Atan2(_ARG_0_.workVec:gety(), Math.Sqrt(_ARG_0_.workVec:getz() * _ARG_0_.workVec:getz() + _ARG_0_.workVec:getx() * _ARG_0_.workVec:getx())), 2, (Entity.GetFrameRate(_ARG_0_.myHandle))))))
    if _ARG_0_.NeckAngle:gety() > _ARG_0_.LookMaxMin[0].Max then
      _ARG_0_.NeckAngle:sety(_ARG_0_.LookMaxMin[0].Max)
    end
    if _ARG_0_.NeckAngle:gety() < _ARG_0_.LookMaxMin[0].Min then
      _ARG_0_.NeckAngle:sety(_ARG_0_.LookMaxMin[0].Min)
    end
    if _ARG_0_.NeckAngle:getz() > _ARG_0_.LookMaxMin[1].Max then
      _ARG_0_.NeckAngle:setz(_ARG_0_.LookMaxMin[1].Max)
    end
    if _ARG_0_.NeckAngle:getz() < _ARG_0_.LookMaxMin[1].Min then
      _ARG_0_.NeckAngle:setz(_ARG_0_.LookMaxMin[1].Min)
    end
    Entity.RotateBoneZYX(_ARG_0_.myHandle, _UPVALUE4_, _ARG_0_.NeckAngle)
  else
    _ARG_0_.oldAnglx = 0
    _ARG_0_.oldAngly = 0
  end
end
function b20cd00.WhichRightandLeft(_ARG_0_)
  Entity.GetWorldPos(_ARG_0_.PlayerPos, _ARG_0_.targetHandle, _UPVALUE0_)
  Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.myHandle)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.PlayerPos, _ARG_0_.WorkVec)
  FVECTOR3.normalize(_ARG_0_.workVec)
  if ROUND_PI((Math.Atan2(_ARG_0_.workVec:getx(), _ARG_0_.workVec:getz()) - _ARG_0_.rot:gety()) * -1) < 0 then
    return 1
  else
    return 0
  end
end
function b20cd00.IsPlayerWithinFOV(_ARG_0_, _ARG_1_)
  Entity.GetWorldPos(_ARG_0_.PlayerPos, _ARG_0_.targetHandle)
  Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.myHandle)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.PlayerPos, _ARG_0_.WorkVec)
  FVECTOR3.normalize(_ARG_0_.workVec)
  if ROUND_PI((Math.Atan2(_ARG_0_.workVec:getx(), _ARG_0_.workVec:getz()) - _ARG_0_.rot:gety()) * -1) < DegToRad(_ARG_1_) and ROUND_PI((Math.Atan2(_ARG_0_.workVec:getx(), _ARG_0_.workVec:getz()) - _ARG_0_.rot:gety()) * -1) > DegToRad(-_ARG_1_) then
    return 1
  else
    return 0
  end
end
function b20cd00.WhichRightandLeft_RoomCenter(_ARG_0_)
  _ARG_0_.WorkVec1:set(B20CD_ROOMCENTER.x, B20CD_ROOMCENTER.y, B20CD_ROOMCENTER.z)
  Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.myHandle)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.WorkVec1, _ARG_0_.WorkVec)
  FVECTOR3.normalize(_ARG_0_.workVec)
  if ROUND_PI((Math.Atan2(_ARG_0_.workVec:getx(), _ARG_0_.workVec:getz()) - _ARG_0_.rot:gety()) * -1) < 0 then
    return 1
  else
    return 0
  end
end
function b20cd00.WhichRightandLeft_Workstand(_ARG_0_)
  _ARG_0_.WorkVec1:set(_UPVALUE0_[_ARG_0_.Workstand_ID].x, _UPVALUE0_[_ARG_0_.Workstand_ID].y, _UPVALUE0_[_ARG_0_.Workstand_ID].z)
  Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.myHandle)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.WorkVec1, _ARG_0_.WorkVec)
  FVECTOR3.normalize(_ARG_0_.workVec)
  if ROUND_PI((Math.Atan2(_ARG_0_.workVec:getx(), _ARG_0_.workVec:getz()) - _ARG_0_.rot:gety()) * -1) < 0 then
    return 1
  else
    return 0
  end
end
function b20cd00.WhichTargetPos(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  _ARG_0_.WorkVec1:set(_ARG_1_, _ARG_2_, _ARG_3_)
  Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.myHandle)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.WorkVec1, _ARG_0_.WorkVec)
  FVECTOR3.normalize(_ARG_0_.workVec)
  if ROUND_PI((Math.Atan2(_ARG_0_.workVec:getx(), _ARG_0_.workVec:getz()) - _ARG_0_.rot:gety()) * -1) < 0 then
    return 1
  else
    return 0
  end
end
function b20cd00.CheckTargetPos(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  _ARG_0_.WorkVec:set(_ARG_1_, _ARG_2_, _ARG_3_)
  if Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.WorkVec, _ARG_4_) == false then
    return false
  end
  return true
end
function b20cd00.setMotion(_ARG_0_, _ARG_1_)
  if _ARG_1_ == _ARG_0_.MotionID then
  else
    Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_1_)
    _ARG_0_.MotionID = _ARG_1_
  end
end
function b20cd00.HomingPlayerMove(_ARG_0_, _ARG_1_)
  _ARG_0_.Speed = _ARG_0_.Speed + _ARG_1_ * 0.1 / 2 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_1_ < _ARG_0_.Speed then
    _ARG_0_.Speed = _ARG_1_
  end
  Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, _UPVALUE0_)
  FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Speed)
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function b20cd00.Move(_ARG_0_, _ARG_1_)
  _ARG_0_.Speed = _ARG_0_.Speed + _ARG_1_ * 0.1 / 2 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_1_ < _ARG_0_.Speed then
    _ARG_0_.Speed = _ARG_1_
  end
  FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Speed)
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function b20cd00.HitBack(_ARG_0_, _ARG_1_)
  _ARG_0_.Speed = _ARG_0_.Speed - _ARG_1_ * 0.1 / 2 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_0_.Speed < -_ARG_1_ then
    _ARG_0_.Speed = _ARG_1_
  end
  FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Speed)
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function b20cd00.Stop(_ARG_0_)
  _ARG_0_.Speed = _ARG_0_.Speed - _UPVALUE0_ * 0.1 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_0_.Speed < 0 then
    _ARG_0_.Speed = 0
  end
  FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Speed)
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function b20cd00.isSpeed(_ARG_0_)
  if _ARG_0_.Speed <= 0 then
    return 1
  end
  return 0
end
function b20cd00.CheckPlayerOnWarkstand(_ARG_0_)
  for _FORV_4_ = 1, 6 do
    _ARG_0_.WorkVec:set(_UPVALUE0_[_FORV_4_].x, _UPVALUE0_[_FORV_4_].y, _UPVALUE0_[_FORV_4_].z)
    if _ARG_0_.Workstand_ID == _UPVALUE1_ or _ARG_0_.Workstand_ID == _UPVALUE2_ then
    else
    end
    if Entity.CalcDistanceSq(_ARG_0_.targetHandle, _ARG_0_.WorkVec) < _UPVALUE0_[_FORV_4_].DangerDist then
      _ARG_0_.PlayerEnshriningFlag = 1
      return 1
    end
    if 0 == 0 then
      return
    end
  end
  return _FOR_
end
function b20cd00.CheckPlayerEnshrining(_ARG_0_)
  Entity.GetWorldPos(_ARG_0_.PlayerPos, _ARG_0_.targetHandle)
  if _ARG_0_.PlayerPos:gety() > 1.7 then
    if _ARG_0_.PlayerPos:gety() > 4.8 then
      _ARG_0_.PlayerEnshriningFlag = 1
      return 1
    end
    if Entity.IsGround((Player.GetHandle())) then
      _ARG_0_.PlayerEnshriningFlag = 1
      return 1
    end
  end
  return 0
end
function b20cd00.CheckMyOnWorkstand(_ARG_0_)
  Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.myHandle)
  if _ARG_0_.WorkVec:gety() > 1.6 and Entity.IsGround(_ARG_0_.myHandle) then
    _ARG_0_.WarkstandFlag = 1
    _ARG_0_.PlayerEnshriningFlag = 1
    return 1
  end
  return 0
end
function b20cd00.CheckCameraIn(_ARG_0_)
  if _ARG_0_.CamFlag == 0 and _ARG_0_:GetState() ~= "BodyPress" and _ARG_0_:GetState() ~= "Rushattack" and _ARG_0_:GetState() ~= "Moveunder" and _ARG_0_:GetState() ~= "Workstand_1_Rotation" and _ARG_0_:GetState() ~= "Two_step_jump" and _ARG_0_:GetState() ~= "Workstand_1_Jump" and _ARG_0_:GetState() ~= "Workstand_1_Move" then
    Camera.GetPlayerCameraPos(_ARG_0_.workVec)
    Camera.GetPlayerCameraDir(_ARG_0_.workVec1)
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.workVec) < 9 then
      _ARG_0_.stack:push(_ARG_0_:GetState())
      _ARG_0_.CamFlag = 1
      _ARG_0_:GotoState("CameraOut")
    end
    _ARG_0_.WorkVec:set(0, 0, 2)
    Entity.GetWorldPos2(_ARG_0_.WorkVec, _ARG_0_.myHandle, _ARG_0_.WorkVec)
    if Entity.CalcDistanceSq(_ARG_0_.WorkVec, _ARG_0_.workVec) < 4 then
      _ARG_0_.stack:push(_ARG_0_:GetState())
      _ARG_0_.CamFlag = 1
      _ARG_0_:GotoState("CameraOut")
    end
  end
end
function b20cd00.Rodeo_relPC(_ARG_0_)
  _ARG_0_.AttackBgFlag = 0
  _ARG_0_.RushWallFlag = 0
  _ARG_0_.step = _UPVALUE0_
  Entity.ClearSpeed(_ARG_0_.myHandle)
  _ARG_0_:setMotion(_UPVALUE1_)
  _ARG_0_.WorkTime = _UPVALUE2_
  _ARG_0_.WorkTime2 = 9
  Camera.QuakeV(20, 0.28, 4)
  Player.NotifyReaction(_ARG_0_.targetHandle, COMMAND_KIND_PunishKitty, _ARG_0_.myHandle)
  Entity.GetWorldPos(_ARG_0_.workVec1, _ARG_0_.targetHandle)
  Entity.SetOldLocalPos(_ARG_0_.targetHandle, _ARG_0_.workVec0)
  Entity.SetLocalPos(_ARG_0_.targetHandle, _ARG_0_.workVec1)
  Entity.AttachCoord(NULL_HANDLE, "", _ARG_0_.targetHandle, "Root")
  Entity.SetLockOnBoneNum(_ARG_0_.myHandle, _UPVALUE3_)
end
function b20cd00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.targetHandle = 0
  _ARG_0_.EffectHndle = 0
  _ARG_0_.AttackFlag = 0
  _ARG_0_.AttackBgFlag = 0
  _ARG_0_.step = 0
  _ARG_0_.angle = 0
  _ARG_0_.TargetAngle = 0
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.Speed = 0
  _ARG_0_.JumpPow = 0
  _ARG_0_.JumpMax = 0
  _ARG_0_.JumpTime = 0
  _ARG_0_.JumpSpeedRate = 0
  _ARG_0_.JampAng = 0
  _ARG_0_.Gravity = 0
  _ARG_0_.Workstand_ID = 0
  _ARG_0_.Workstand_Cnt = 0
  _ARG_0_.WorkstandDist = 0
  _ARG_0_.WarkstandFlag = 0
  _ARG_0_.MotionID = 0
  _ARG_0_.AttackFalg = 0
  _ARG_0_.AttackCnt = 0
  _ARG_0_.AttackMax = 0
  _ARG_0_.RushWallFlag = 0
  _ARG_0_.RushAng = 0
  _ARG_0_.MoveFlag = 0
  _ARG_0_.HomingFlag = 0
  _ARG_0_.RodeoInAttackFlag = 0
  _ARG_0_.RodeoPushCnt = 0
  _ARG_0_.RodeoPushCntF = 0
  _ARG_0_.DamageCnt = 0
  _ARG_0_.DamageFlag = 0
  _ARG_0_.DamagePoint = 0
  _ARG_0_.CounterPoint = 0
  _ARG_0_.CounterMaxPoint = 0
  _ARG_0_.CamFlag = 0
  _ARG_0_.CamRotFlag = 0
  _ARG_0_.CamCnt = 0
  _ARG_0_.oldHP = 0
  _ARG_0_.PlayerNoHitTime = 0
  _ARG_0_.PlayerEnshriningTime = 0
  _ARG_0_.PlayerEnshriningFlag = 0
  _ARG_0_.OldWorkStandNum = 0
  _ARG_0_.RestFlag = 0
  _ARG_0_.BodyPressOnWorkstand = 0
  _ARG_0_.stack = Stack:Create()
  _ARG_0_.RodeoPushFlag = 0
  _ARG_0_.RodeoPushFlag = 0
  _ARG_0_.MoveunderCount = 0
  _ARG_0_.WorkNumber = 0
  _ARG_0_.WorkTime = 0
  _ARG_0_.WorkTime2 = 0
  _ARG_0_.WorkTime3 = 0
  _ARG_0_.WorkTime4 = 0
  _ARG_0_.NeckPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.NeckAngle = FVECTOR3.new(0, 0, 0)
  _ARG_0_.oldAnglx = 0
  _ARG_0_.oldAngly = 0
  _ARG_0_.LookMaxMin = {}
  _ARG_0_.LookMaxMin[0] = {
    Max = DegToRad(26),
    Min = DegToRad(-26)
  }
  _ARG_0_.LookMaxMin[1] = {
    Max = DegToRad(50),
    Min = DegToRad(-50)
  }
  _ARG_0_.PlayerPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.MyPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkVec2 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec0 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
  _ARG_0_.TargetVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.cameraPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.cameraTargetPos = FVECTOR3.new(0, 0, 0)
  if _UPVALUE0_ == false then
    _UPVALUE1_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "Action1Dist") * Enemy.GetExtraParam(_ARG_0_.myHandle, "Action1Dist")
    _UPVALUE2_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "Action2Dist") * Enemy.GetExtraParam(_ARG_0_.myHandle, "Action2Dist")
    B20CD_WORKSTAND_DISTANC = Enemy.GetExtraParam(_ARG_0_.myHandle, "Action3Dist") * Enemy.GetExtraParam(_ARG_0_.myHandle, "Action3Dist")
    _UPVALUE3_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "WIdlingFMin")
    _UPVALUE4_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "WIdlingFMax")
    _UPVALUE5_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "IdlingTime") * 60
    _UPVALUE6_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "RodeoCnt")
    _UPVALUE7_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "AttackFreqMin")
    _UPVALUE8_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "AttackFreqAdd")
    _UPVALUE9_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "AttackDelay")
    _UPVALUE10_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "SpinAttackDelay")
    _UPVALUE11_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "RodeoDownTime")
    _UPVALUE12_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "PlaySEIdling") * 0.01
    _UPVALUE13_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "BodypressRate") * 0.01
    _UPVALUE14_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "RodeoPushTime")
    _UPVALUE15_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "RodeoWait")
    _UPVALUE16_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "RestInTime") * 60
    _UPVALUE17_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "UnderARate") * 0.01
    _UPVALUE18_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "Action1Rate") * 0.01
    _UPVALUE19_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "Action2Rate") * 0.01
    _UPVALUE20_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "CouPoint")
    _UPVALUE0_ = true
  end
  Entity.SetMovementCollRadius(_ARG_0_.myHandle, 1.7)
  Entity.SetLowerHalf(_ARG_0_.myHandle, 2)
  Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
  Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
  Entity.EnableLockon(_ARG_0_.myHandle, 0)
  Entity.EnableGravity(_ARG_0_.myHandle, 1)
  Enemy.SetHitBgEffectParam(_ARG_0_.myHandle, "b20cd00", "B002_HIT_03_0")
  Player.SetBossCamera("b20cd")
  Enemy.IsAllEnemyWaiting()
  Entity.SetDropShadowDistance(_ARG_0_.myHandle, 6400)
  Entity.EnableCameraBodyColl(_ARG_0_.myHandle, 1)
  Entity.SetLockOnBoneNum(_ARG_0_.myHandle, _UPVALUE21_)
  Entity.SetDropShadowTextureSize(_ARG_0_.myHandle, 256)
  if Enemy.IsAllEnemyWaiting() == true then
    _ARG_0_:GotoState("Standby")
  else
    _ARG_0_:GotoState("Appear")
    Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
  end
end
function b20cd00.OnSetupBlow(_ARG_0_)
  if Enemy.IsAttackerFront(_ARG_0_.myHandle) then
    _ARG_0_.WorkVec1:set(0, 4, 0)
    Entity.GetWorldPos2(_ARG_0_.cameraTargetPos, _ARG_0_.myHandle, _ARG_0_.WorkVec1)
  else
    _ARG_0_.WorkVec1:set(0, 2, 3)
    Entity.GetWorldPos2(_ARG_0_.cameraTargetPos, _ARG_0_.myHandle, _ARG_0_.WorkVec1)
  end
  _ARG_0_.DamageCnt = 0
  _ARG_0_.DamagePoint = 0
  _ARG_0_.DamageFlag = 0
  _ARG_0_.AttackFalg = 0
  _ARG_0_.CounterPoint = 0
  if _ARG_0_:GetState() == "NecoRodeo" then
    Player.NotifyReaction(_ARG_0_.targetHandle, 0)
    Entity.GetWorldPos(_ARG_0_.workVec1, _ARG_0_.targetHandle)
    Entity.SetOldLocalPos(_ARG_0_.targetHandle, _ARG_0_.workVec0)
    Entity.SetLocalPos(_ARG_0_.targetHandle, _ARG_0_.workVec1)
    Entity.AttachCoord(NULL_HANDLE, "", _ARG_0_.targetHandle, "Root")
    Entity.SetLockOnBoneNum(_ARG_0_.myHandle, _UPVALUE0_)
  elseif _ARG_0_:GetState() == "Rage_running" then
  end
end
function b20cd00.OnUpdateDamageReaction(_ARG_0_)
  _ARG_0_.CounterPoint = 0
end
function b20cd00.OnDamage(_ARG_0_, _ARG_1_, _ARG_2_)
  if _ARG_0_:GetState() == "RodeoFinish" or _ARG_0_:GetState() == "NecoRodeo" or _ARG_0_:GetState() == "Rage_running" or _ARG_0_:GetState() == "BigDamage" or _ARG_0_:GetState() == "Damage" then
    return 1
  end
  if _ARG_0_.AttackFalg == 1 then
    if _ARG_1_ == ATK_KIND_DMG_SMALL then
      _ARG_0_.DamagePoint = _ARG_0_.DamagePoint + 3
    elseif _ARG_1_ == ATK_KIND_DMG_BIG then
      _ARG_0_.DamagePoint = _ARG_0_.DamagePoint + 5
    elseif _ARG_1_ == ATK_KIND_DMG_BLOW or _ARG_1_ == ATK_KIND_DMG_TOSS or _ARG_1_ == ATK_KIND_DMG_BEAT or _ARG_1_ == ATK_KIND_DMG_FLICK then
      _ARG_0_.DamagePoint = _ARG_0_.DamagePoint + 10
    end
    _ARG_0_.DamageCnt = _ARG_0_.DamageCnt + 1
  else
    _ARG_0_.DamageCnt = 0
    _ARG_0_.DamagePoint = 0
  end
  if _ARG_1_ == ATK_KIND_DMG_SMALL then
    _ARG_0_.CounterPoint = _ARG_0_.CounterPoint + 3
    print("\n")
    print("b20cd00:: ATK_KIND_DMG_SMALL\n")
    print("b20cd00:: \131_\131\129\129[\131W " .. _ARG_0_.CounterPoint .. "\n")
    print("\n")
  elseif _ARG_1_ == ATK_KIND_DMG_BIG then
    _ARG_0_.CounterPoint = _ARG_0_.CounterPoint + 5
    print("\n")
    print("b20cd00:: ATK_KIND_DMG_BIG\n")
    print("b20cd00:: \131_\131\129\129[\131W " .. _ARG_0_.CounterPoint .. "\n")
    print("\n")
  elseif _ARG_1_ == ATK_KIND_DMG_BLOW or _ARG_1_ == ATK_KIND_DMG_TOSS or _ARG_1_ == ATK_KIND_DMG_BEAT or _ARG_1_ == ATK_KIND_DMG_FLICK then
    _ARG_0_.CounterPoint = _ARG_0_.CounterPoint + 10
    print("\n")
    print("b20cd00:: ATK_KIND_DMG_BLOW\n")
    print("b20cd00:: \131_\131\129\129[\131W " .. _ARG_0_.CounterPoint .. "\n")
    print("\n")
  else
    _ARG_0_.CounterPoint = _ARG_0_.CounterPoint + 8
    print("\n")
    print("b20cd00:: else\n")
    print("b20cd00:: \131_\131\129\129[\131W " .. _ARG_0_.CounterPoint .. "\n")
    print("\n")
  end
  if _ARG_0_:GetState() ~= "BodyPress" and _ARG_0_.CounterPoint > _UPVALUE0_ then
    _ARG_0_.CounterPoint = 0
    if _ARG_0_.WarkstandFlag == 0 then
      _ARG_0_.AttackFalg = 1
      _ARG_0_.AttackMax = Script.Random() * _UPVALUE1_ + 2
      _ARG_0_:GotoState("SpinAttackEx")
      return
    end
  end
  if _ARG_0_.AttackFalg == 1 then
    if _ARG_0_.DamagePoint > 50 then
      _ARG_0_.DamageFlag = 0
      _ARG_0_.AttackFalg = 0
    elseif _ARG_0_.DamagePoint > 40 then
      _ARG_0_.DamageFlag = 1
    end
  end
  if (_ARG_0_:GetState() ~= "BigDamage" or _ARG_0_:GetState() ~= "Damage") and _ARG_0_.DamageFlag == 1 then
    if _ARG_1_ == ATK_KIND_DMG_SMALL then
      _ARG_0_:GotoState("Damage")
      return true
    elseif _ARG_1_ == ATK_KIND_DMG_BIG then
      _ARG_0_:GotoState("Damage")
      return true
    elseif _ARG_1_ == ATK_KIND_DMG_BLOW or _ARG_1_ == ATK_KIND_DMG_TOSS or _ARG_1_ == ATK_KIND_DMG_BEAT or _ARG_1_ == ATK_KIND_DMG_FLICK or _ARG_1_ == ATK_KIND_DMG_BIG then
      return true
    end
  end
  if _ARG_0_:GetState() == "Rage_running" and (_ARG_1_ == ATK_KIND_DMG_BLOW or _ARG_1_ == ATK_KIND_DMG_TOSS or _ARG_1_ == ATK_KIND_DMG_BEAT or _ARG_1_ == ATK_KIND_DMG_FLICK or _ARG_1_ == ATK_KIND_DMG_BIG) then
    _ARG_0_:GotoState("RodeoFinish")
    return 1
  end
  if _ARG_0_.RodeoInAttackFlag == 1 and _ARG_0_.oldHp ~= Enemy.GetHp(_ARG_0_.myHandle) then
    _ARG_0_.DamageCnt = _ARG_0_.DamageCnt + 1
    if _ARG_0_.DamageCnt >= _UPVALUE2_ then
      _ARG_0_:GotoState("NecoRodeo")
      _ARG_0_.RodeoInAttackFlag = 0
    end
  end
  _ARG_0_.oldHp = Enemy.GetHp(_ARG_0_.myHandle)
end
function b20cd00.OnHitAttack(_ARG_0_)
  _ARG_0_.AttackFlag = 1
end
function b20cd00.OnHitAttackBg(_ARG_0_)
  _ARG_0_.AttackBgFlag = 1
end
function b20cd00.OnDead(_ARG_0_)
  _ARG_0_:GotoState("Dead")
  SetupBossDead(_ARG_0_.myHandle)
  if Enemy.IsAttackerFront(_ARG_0_.myHandle) then
    _ARG_0_:setMotion(_UPVALUE0_)
  else
    _ARG_0_:setMotion(_UPVALUE1_)
  end
  return 1
end
function b20cd00.OnReturnDamage(_ARG_0_)
  _ARG_0_.MotionID = 0
  _ARG_0_.DamageFlag = 0
  _ARG_0_.DamagePoint = 0
  _ARG_0_.DamageCnt = 0
  _ARG_0_.AttackFalg = 0
  if _ARG_0_.WarkstandFlag == 1 then
    _ARG_0_:GotoState("Workstand_1_Rotation")
  else
    _ARG_0_:SelectWorkstand()
    _ARG_0_:GotoState("Workstand_Turn")
  end
  Entity.EnableGravity(_ARG_0_.myHandle, 1)
  return 1
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
function b20cd00.OnUpdatePositionAfter(_ARG_0_)
  _ARG_0_:Neck()
  if _ARG_0_.flag then
    _ARG_0_.rot:set(0, _ARG_0_.angle, 0)
    Entity.RotateBoneXYZ(_ARG_0_.myHandle, 2, _ARG_0_.rot)
  end
end
function b20cd00.GetCameraTargetPos(_ARG_0_)
  return _ARG_0_.cameraTargetPos
end
function b20cd00.Debug(_ARG_0_)
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
function b20cd00.OnUpdate(_ARG_0_)
  _ARG_0_:Update()
  _ARG_0_:Debug()
  if _ARG_0_:CheckPlayerEnshrining() or _ARG_0_:CheckPlayerOnWarkstand() == 1 then
    _ARG_0_.PlayerEnshriningTime = _ARG_0_.PlayerEnshriningTime + 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
  end
  _ARG_0_.CounterPoint = _ARG_0_.CounterPoint - 0.005 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_0_.CounterPoint < 0 then
    _ARG_0_.CounterPoint = 0
  end
  if Entity.GetCurrentMotion(_ARG_0_.myHandle) == 26 or Entity.GetCurrentMotion(_ARG_0_.myHandle) == 27 then
    _ARG_0_.WorkVec1:set(0, 4, 0)
    Entity.GetWorldPos2(_ARG_0_.cameraTargetPos, _ARG_0_.myHandle, _ARG_0_.WorkVec1)
  else
    _ARG_0_.WorkVec1:set(0, 2, 3)
    Entity.GetWorldPos2(_ARG_0_.cameraTargetPos, _ARG_0_.myHandle, _ARG_0_.WorkVec1)
  end
end
EntityFactory:Add("b20cd00", function(_ARG_0_)
  return (b20cd00:new())
end)
