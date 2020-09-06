m22ex00 = {}
m22ex00_base_mt = {__index = __StateMachine}
setmetatable(m22ex00, m22ex00_base_mt)
m22ex00_mt = {__index = m22ex00}
function m22ex00.new(_ARG_0_)
  return setmetatable(__StateMachine:new(), m22ex00_mt)
end
m22ex00.states = {
  Appear = {
    OnBeginState = function(_ARG_0_)
      SetupAppearBegin2(_ARG_0_.myHandle, 1, _UPVALUE0_, 0)
    end,
    OnEndState = function(_ARG_0_)
      SetupAppearEnd(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Idling = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
      if _ARG_0_.step == 99 then
        Entity.SetAnimNowFrame(_ARG_0_.myHandle, Script.Random() * Entity.GetMotionTotalFrame(_ARG_0_.myHandle))
      end
      Entity.SetTimer(_ARG_0_.myHandle, Entity.GetMotionTotalFrame(_ARG_0_.myHandle) + Script.Random() * Entity.GetMotionTotalFrame(_ARG_0_.myHandle))
      _ARG_0_.step = 0
      _ARG_0_.Wait = Entity.GetMotionTotalFrame(_ARG_0_.myHandle) / 3
      _ARG_0_.step = 0
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.Wait = _ARG_0_.Wait - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      if _ARG_0_.step == 0 and (Entity.IsTimeOver(_ARG_0_.myHandle) or _ARG_0_.Wait < 0) then
        _ARG_0_:GotoState("Move")
        return
      end
    end
  },
  Move = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.step = 0
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_ + Script.Random() * _UPVALUE0_)
      _ARG_0_.MoveTime = _UPVALUE0_ + Script.Random() * _UPVALUE0_
      if Entity.IsTargetWithinFOV(_ARG_0_.targetHandle, _ARG_0_.myHandle, DegToRad(30)) and Entity.CanUserTarget(_ARG_0_.targetHandle) == true then
        _ARG_0_.MoveMode = _UPVALUE1_
      else
        _ARG_0_.MoveMode = _UPVALUE2_
        _ARG_0_.RandomMoveTime = Script.Random() * 30 + 30
        if Script.Random() < 0.5 then
          _ARG_0_.LeftAndRightFla = 0
        else
          _ARG_0_.LeftAndRightFla = 1
        end
        _ARG_0_.step = 2
        _ARG_0_.changeTime = 120
      end
      _ARG_0_.Speed = 0
      Entity.EnableGravity(_ARG_0_.myHandle, 0)
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.HasNetGameHandle(_ARG_0_.myHandle) and Enemy.IsNetworkMaster(_ARG_0_.myHandle) == false then
        return
      end
      if Entity.CanUserTarget(_ARG_0_.targetHandle) == true then
      end
      if CanDisappear(_ARG_0_.myHandle, _ARG_0_.targetHandle) == true then
        _ARG_0_:GotoState("Disappear")
        return
      end
      if Entity.IsTargetWithinFOV(_ARG_0_.targetHandle, _ARG_0_.myHandle, DegToRad(120)) then
        _ARG_0_.MoveTime = _ARG_0_.MoveTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.MoveTime < 0 then
          _ARG_0_:GotoState("BeforeAttackIdling")
          return
        end
      end
      if _ARG_0_.step == 0 then
        if Entity.IsTargetWithinFOV(_ARG_0_.targetHandle, _ARG_0_.myHandle, DegToRad(120)) then
          _ARG_0_.MoveMode = _UPVALUE0_
        else
          _ARG_0_.MoveMode = _UPVALUE1_
          _ARG_0_.step = 1
          _ARG_0_.RandomMoveTime = 280
        end
      elseif _ARG_0_.step == 1 then
        if _ARG_0_:WhichTargetRightandLeft() == 2 then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE2_)
        elseif _ARG_0_:WhichTargetRightandLeft() == 1 then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE2_)
        else
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE2_)
        end
      elseif _ARG_0_.step == 2 then
      end
      if _ARG_0_.MoveMode == _UPVALUE0_ or _ARG_0_.MoveMode == _UPVALUE3_ or _ARG_0_.MoveMode == MOVEMODE_FORMOVE then
        _ARG_0_.WorkTime = _ARG_0_.WorkTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if 0 >= _ARG_0_.WorkTime or Entity.GetFloorDistance(_ARG_0_.myHandle) < 0.5 or Entity.GetFloorDistance(_ARG_0_.myHandle) > 1.5 then
          if Entity.GetFloorDistance(_ARG_0_.myHandle) < 0.5 then
            _ARG_0_.HeightFlag = 0
          elseif 2 < Entity.GetFloorDistance(_ARG_0_.myHandle) then
            _ARG_0_.HeightFlag = 1
          else
            if 0.5 > Script.Random() then
              _ARG_0_.HeightFlag = 0
            else
              _ARG_0_.HeightFlag = 1
            end
            _ARG_0_.WorkTime = Script.Random() * 120 + 60
          end
          _ARG_0_.HeightPow = Script.Random() * 0.25 + 0.3
        end
        if _ARG_0_.HeightFlag == 0 then
          _ARG_0_.SpeedY = HomingDegree(_ARG_0_.SpeedY, _ARG_0_.HeightPow, 0.05, (Entity.GetFrameRate(_ARG_0_.myHandle)))
        elseif _ARG_0_.HeightFlag == 1 then
          _ARG_0_.SpeedY = HomingDegree(_ARG_0_.SpeedY, -_ARG_0_.HeightPow, 0.05, (Entity.GetFrameRate(_ARG_0_.myHandle)))
        end
      end
      if _ARG_0_.MoveMode == _UPVALUE0_ then
        _ARG_0_.RandomMoveTime = _ARG_0_.RandomMoveTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if not (0 > _ARG_0_.RandomMoveTime) or Script.Random() < 0.2 then
        elseif Script.Random() < 0.8 then
          _ARG_0_.MoveMode = _UPVALUE3_
          _ARG_0_.RandomMoveTime = Script.Random() * 30 + 30
          if 0.5 > Script.Random() then
            _ARG_0_.LeftAndRightFla = 0
          else
            _ARG_0_.LeftAndRightFla = 1
          end
          _ARG_0_.step = 2
          _ARG_0_.changeTime = 120
        else
          _ARG_0_.RandomMoveTime = Script.Random() * 180 + 60
        end
        if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE4_ then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE5_)
          _ARG_0_.Speed = HomingDegree(_ARG_0_.Speed, -_UPVALUE6_, 0.05, Entity.GetFrameRate(_ARG_0_.myHandle))
        elseif Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _UPVALUE7_ then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE2_)
          _ARG_0_.Speed = HomingDegree(_ARG_0_.Speed, _UPVALUE6_, 0.05, Entity.GetFrameRate(_ARG_0_.myHandle))
        else
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE8_)
          _ARG_0_.Speed = HomingDegree(_ARG_0_.Speed, 0, 0.05, Entity.GetFrameRate(_ARG_0_.myHandle))
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 1)
        _ARG_0_.SpeedX = HomingDegree(_ARG_0_.SpeedX, 0, 0.1, Entity.GetFrameRate(_ARG_0_.myHandle))
        Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
        _ARG_0_.velocity:set(_ARG_0_.SpeedX, _ARG_0_.SpeedY, _ARG_0_.Speed)
        Math.RotateVectorXYZ(_ARG_0_.velocity, _ARG_0_.rot)
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
      elseif _ARG_0_.MoveMode == _UPVALUE3_ then
        _ARG_0_.RandomMoveTime = _ARG_0_.RandomMoveTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        _ARG_0_.changeTime = _ARG_0_.changeTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        _ARG_0_.Speed = HomingDegree(_ARG_0_.Speed, 0, 0.1, Entity.GetFrameRate(_ARG_0_.myHandle))
        if Entity.IsTargetWithinFOV(_ARG_0_.targetHandle, _ARG_0_.myHandle, DegToRad(100)) == false then
          if _ARG_0_:WhichRightandLeft2() == 1 then
            Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE9_)
            _ARG_0_.SpeedX = HomingDegree(_ARG_0_.SpeedX, _UPVALUE6_, 0.1, Entity.GetFrameRate(_ARG_0_.myHandle))
            _ARG_0_.LeftAndRightFla = 0
          else
            Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE10_)
            _ARG_0_.SpeedX = HomingDegree(_ARG_0_.SpeedX, -_UPVALUE6_, 0.1, Entity.GetFrameRate(_ARG_0_.myHandle))
            _ARG_0_.LeftAndRightFla = 1
          end
          _ARG_0_.RandomMoveTime = Script.Random() * 60 + 120
        elseif _ARG_0_.LeftAndRightFla == 1 then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE10_)
          _ARG_0_.SpeedX = HomingDegree(_ARG_0_.SpeedX, -_UPVALUE6_, 0.1, Entity.GetFrameRate(_ARG_0_.myHandle))
        else
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE9_)
          _ARG_0_.SpeedX = HomingDegree(_ARG_0_.SpeedX, _UPVALUE6_, 0.1, Entity.GetFrameRate(_ARG_0_.myHandle))
        end
        if 0 > _ARG_0_.RandomMoveTime then
          _ARG_0_.RandomMoveTime = Script.Random() * 60 + 30
          if 0.5 > Script.Random() then
            _ARG_0_.LeftAndRightFla = 0
          else
            _ARG_0_.LeftAndRightFla = 1
          end
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 1)
        Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
        _ARG_0_.velocity:set(_ARG_0_.SpeedX, _ARG_0_.SpeedY, _ARG_0_.Speed)
        Math.RotateVectorXYZ(_ARG_0_.velocity, _ARG_0_.rot)
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE4_ then
          _ARG_0_.step = 0
          _ARG_0_.MoveMode = _UPVALUE0_
          _ARG_0_.RandomMoveTime = Script.Random() * 180 + 60
        elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _UPVALUE7_ then
          _ARG_0_.step = 0
          _ARG_0_.MoveMode = _UPVALUE0_
          _ARG_0_.RandomMoveTime = Script.Random() * 180 + 60
        elseif 0 > _ARG_0_.changeTime then
          if 0.5 > Script.Random() then
            _ARG_0_.step = 0
            _ARG_0_.MoveMode = _UPVALUE0_
            _ARG_0_.RandomMoveTime = Script.Random() * 180 + 60
          else
            _ARG_0_.changeTime = 180
          end
        end
      elseif _ARG_0_.MoveMode == MOVEMODE_FORMOVE then
        _ARG_0_.SpeedX = HomingDegree(_ARG_0_.SpeedX, 0, 0.1, Entity.GetFrameRate(_ARG_0_.myHandle))
        _ARG_0_.RotAng = _ARG_0_.RotAng + 0.08 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.RotAng > 5 then
          _ARG_0_.RotAng = 5
        end
        _ARG_0_.Speed = HomingDegree(_ARG_0_.Speed, _UPVALUE6_, 0.05, Entity.GetFrameRate(_ARG_0_.myHandle))
        Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
        _ARG_0_.velocity:set(_ARG_0_.SpeedX, _ARG_0_.SpeedY, _ARG_0_.Speed)
        Math.RotateVectorXYZ(_ARG_0_.velocity, _ARG_0_.rot)
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
        _ARG_0_.RandomMoveTime = _ARG_0_.RandomMoveTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if 0 > _ARG_0_.RandomMoveTime and Entity.IsTargetWithinFOV(_ARG_0_.targetHandle, _ARG_0_.myHandle, DegToRad(120)) then
          _ARG_0_.step = 0
          _ARG_0_.MoveMode = _UPVALUE0_
        end
        _ARG_0_.noWallHitTime = _ARG_0_.noWallHitTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > 4 then
          _ARG_0_.wanderAng = 0
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, _ARG_0_.RotAng)
        end
        if 0 > _ARG_0_.noWallHitTime then
          if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 4 then
            if _ARG_0_:WhichRightandLeft() == 1 then
              _ARG_0_.wanderAng = -10
            else
              _ARG_0_.wanderAng = 10
            end
          end
        end
        Entity.GetRot(_ARG_0_.WorkVec, _ARG_0_.myHandle)
        _ARG_0_.WorkVec:sety(_ARG_0_.WorkVec:gety() + DegToRad(_ARG_0_.wanderAng))
        Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.WorkVec)
        _ARG_0_.noWallHitTime = 40
        if Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.IsWall(_ARG_0_.myHandle) == true or 1 > Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetPos) then
          _ARG_0_.MoveMode = _UPVALUE1_
        end
      elseif _ARG_0_.MoveMode == _UPVALUE1_ then
        if Enemy.GetTimeTargetHasBeenVisible(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 2400 then
          Enemy.GetTargetLastRecordedPos(_ARG_0_.targetPos, _ARG_0_.myHandle, _ARG_0_.targetHandle)
        else
          Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.myHandle)
        end
        _UPVALUE11_:set(0, 0, 0)
        _ARG_0_.targetPos:setx(_ARG_0_.targetPos:getx() + ((2 * Script.Random() + 3) * Math.Cos((RoundPI(Script.Random() * 2 * PI))) + _UPVALUE11_:getx()))
        _ARG_0_.targetPos:setz(_ARG_0_.targetPos:getz() + ((2 * Script.Random() + 3) * Math.Sin((RoundPI(Script.Random() * 2 * PI))) + _UPVALUE11_:getz()))
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE12_ + (_UPVALUE12_ / (Script.Random() * 1) + 3))
        _ARG_0_.noWallHitTime = 120
        _ARG_0_.RotAng = 0
        _ARG_0_.MoveMode = MOVEMODE_FORMOVE
      end
    end
  },
  BeforeAttackIdling = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
      if _ARG_0_.step == 99 then
        Entity.SetAnimNowFrame(_ARG_0_.myHandle, Script.Random() * Entity.GetMotionTotalFrame(_ARG_0_.myHandle))
      end
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_ + Script.Random() * _UPVALUE1_)
      _ARG_0_.step = 0
      _ARG_0_.NowHeight = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.Wait = _ARG_0_.Wait - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 2)
      _ARG_0_.Speed = HomingDegree(_ARG_0_.Speed, 0, 0.05, Entity.GetFrameRate(_ARG_0_.myHandle))
      _ARG_0_.SpeedY = HomingDegree(_ARG_0_.SpeedY, 0, 0.05, Entity.GetFrameRate(_ARG_0_.myHandle))
      _ARG_0_.SpeedX = HomingDegree(_ARG_0_.SpeedX, 0, 0.05, Entity.GetFrameRate(_ARG_0_.myHandle))
      Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
      _ARG_0_.velocity:set(_ARG_0_.SpeedX, _ARG_0_.SpeedY, _ARG_0_.Speed)
      Math.RotateVectorXYZ(_ARG_0_.velocity, _ARG_0_.rot)
      Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
      if _ARG_0_.step == 0 and Entity.IsTimeOver(_ARG_0_.myHandle) then
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE0_ then
          if Script.Random() < _UPVALUE1_ then
            _ARG_0_:GotoState("Attack1")
          else
            _ARG_0_:GotoState("Move")
          end
        elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _UPVALUE0_ then
          if Script.Random() < _UPVALUE2_ then
            _ARG_0_:GotoState("Attack3")
          else
            _ARG_0_:GotoState("Move")
          end
        end
        return
      end
    end
  },
  Attack1 = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 and Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10) == false then
        _ARG_0_.step = 1
      end
      if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 23 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) < 44 then
        Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
        _ARG_0_.velocity:set(0, 0.04, 0.02)
        Math.RotateVectorXYZ(_ARG_0_.velocity, _ARG_0_.rot)
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
      else
        Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
        _ARG_0_.velocity:set(0, -0.04, 0)
        Math.RotateVectorXYZ(_ARG_0_.velocity, _ARG_0_.rot)
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
      end
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        Entity.ClearSpeed(_ARG_0_.myHandle)
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Attack2 = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 and Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10) == false then
        _ARG_0_.step = 1
      end
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Attack3 = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 10 then
          _ARG_0_.step = 1
          _ARG_0_:CreateShot(_ARG_0_.myHandle, _UPVALUE0_, 0, 2)
        end
      elseif _ARG_0_.step == 1 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 20 then
          _ARG_0_.step = 2
          _ARG_0_:CreateShot(_ARG_0_.myHandle, _UPVALUE1_, 1, 2)
        end
      elseif _ARG_0_.step == 2 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 35 then
        _ARG_0_.step = 3
        _ARG_0_:CreateShot(_ARG_0_.myHandle, _UPVALUE1_, 3, 2)
        _ARG_0_:CreateShot(_ARG_0_.myHandle, _UPVALUE0_, 2, 2)
      end
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Blow = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
      if Enemy.IsAttackerFront(_ARG_0_.myHandle) then
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.workNum = Entity.GetMotionIndex(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.rot:sety(Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle))
        _ARG_0_.WorkVec:set(0, Math.Sin(DegToRad(BLOW_DEGREE)), -Math.Cos(DegToRad(BLOW_DEGREE)))
      else
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE1_)
        _ARG_0_.workNum = Entity.GetMotionIndex(_ARG_0_.myHandle, _UPVALUE1_)
        _ARG_0_.rot:sety(Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.myHandle))
        _ARG_0_.WorkVec:set(0, Math.Sin(DegToRad(BLOW_DEGREE)), Math.Cos(DegToRad(BLOW_DEGREE)))
      end
      Math.RotateVectorXYZ(_ARG_0_.WorkVec, _ARG_0_.rot)
      _ARG_0_.WorkVec:scale(Entity.CalcOrbitSpeedFromDistance(_ARG_0_.myHandle, DegToRad(BLOW_DEGREE), BLOW_DISTANCE))
      Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
      Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.WorkVec)
      Entity.EnableGravity(_ARG_0_.myHandle, 1)
      Entity.SetTimer(_ARG_0_.myHandle, 180)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      Entity.EnableGravity(_ARG_0_.myHandle, 1)
      if _ARG_0_.step == 0 then
        if Entity.IsGround(_ARG_0_.myHandle) then
          _ARG_0_.step = 1
          Entity.ClearSpeed(_ARG_0_.myHandle)
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
      elseif _ARG_0_.step == 1 then
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE1_ then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 40 then
            _ARG_0_:GotoState("Attack2")
          end
        elseif Entity.IsTimeOver(_ARG_0_.myHandle) then
          if Entity.GetMotionIndex(_ARG_0_.myHandle, _UPVALUE2_) == _ARG_0_.workNum then
            Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE3_)
          else
            Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE4_)
          end
          _ARG_0_.step = 2
        end
      elseif _ARG_0_.step == 2 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Standby = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
    end,
    OnEndState = function(_ARG_0_)
      Entity.EnableLockon(_ARG_0_.myHandle, 1)
    end,
    OnUpdate = function(_ARG_0_)
      if Enemy.IsAllEnemyWaiting() == false then
        _ARG_0_:GotoState("Idling")
        Entity.EnableLockon(_ARG_0_.myHandle, 1)
      end
    end
  },
  Dead = {
    OnBeginState = function(_ARG_0_)
      Entity.EnableLockon(_ARG_0_.myHandle, 0)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
    end
  },
  Disappear = {
    OnBeginState = function(_ARG_0_)
      SetupDisappear(_ARG_0_.myHandle, 20)
    end,
    OnEndState = function(_ARG_0_)
      Entity.MoveStartPos(_ARG_0_.myHandle)
      Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsModelFade(_ARG_0_.myHandle) then
        Enemy.Disappear(_ARG_0_.myHandle)
      end
    end
  }
}
function m22ex00.WhichRightandLeft(_ARG_0_)
  Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.targetHandle)
  Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  FVECTOR3.Sub(_UPVALUE1_, _UPVALUE0_, _UPVALUE1_)
  FVECTOR3.normalize(_UPVALUE1_)
  if RoundPI((Math.Atan2(_UPVALUE1_:getx(), _UPVALUE1_:getz()) - _ARG_0_.rot:gety()) * -1) < 0 then
    return 1
  else
    return 0
  end
end
function m22ex00.WhichRightandLeft2(_ARG_0_)
  _UPVALUE0_:set(0, 0, 2)
  Entity.GetWorldPos2(_UPVALUE0_, _ARG_0_.targetHandle, _UPVALUE0_)
  Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  FVECTOR3.Sub(_UPVALUE1_, _UPVALUE0_, _UPVALUE1_)
  FVECTOR3.normalize(_UPVALUE1_)
  if 0 > RoundPI((Math.Atan2(_UPVALUE1_:getx(), _UPVALUE1_:getz()) - _ARG_0_.rot:gety()) * -1) then
    return 1
  else
    return 0
  end
end
function m22ex00.WhichTargetRightandLeft(_ARG_0_)
  Entity.GetOldLocalPos(_UPVALUE0_, _ARG_0_.myHandle)
  Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  FVECTOR3.Sub(_UPVALUE1_, _UPVALUE0_, _UPVALUE1_)
  FVECTOR3.normalize(_UPVALUE1_)
  if RoundPI((Math.Atan2(_UPVALUE1_:getx(), _UPVALUE1_:getz()) - (_ARG_0_.rot:gety() + DegToRad(180))) * -1) < DegToRad(1) and RoundPI((Math.Atan2(_UPVALUE1_:getx(), _UPVALUE1_:getz()) - (_ARG_0_.rot:gety() + DegToRad(180))) * -1) > DegToRad(-1) then
    return 2
  elseif RoundPI((Math.Atan2(_UPVALUE1_:getx(), _UPVALUE1_:getz()) - (_ARG_0_.rot:gety() + DegToRad(180))) * -1) < 0 then
    return 1
  else
    return 0
  end
end
function m22ex00.Advancement(_ARG_0_, _ARG_1_)
  _ARG_0_.Speed = _ARG_0_.Speed + _ARG_1_ * 0.1 / 2 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_1_ < _ARG_0_.Speed then
    _ARG_0_.Speed = _ARG_1_
  end
  FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Speed)
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function m22ex00.Retreat(_ARG_0_, _ARG_1_)
  _ARG_0_.Speed = _ARG_0_.Speed + _ARG_1_ * 0.1 / 2 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_1_ < _ARG_0_.Speed then
    _ARG_0_.Speed = _ARG_1_
  end
  FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, -_ARG_0_.Speed)
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function m22ex00.CreateShot(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.targetHandle, 2)
  Entity.GetWorldPos(_ARG_0_.WorkVec1, _ARG_1_)
  Entity.GetRot(_ARG_0_.rot, _ARG_1_)
  FVECTOR3.Sub(_ARG_0_.WorkVec, _ARG_0_.WorkVec, _ARG_0_.WorkVec1)
  FVECTOR3.normalize(_ARG_0_.WorkVec)
  if _ARG_3_ == 0 then
    _ARG_0_.rot:setx(DegToRad(-10) + -Math.Atan2(_ARG_0_.WorkVec:gety(), Math.Sqrt(_ARG_0_.WorkVec:getz() * _ARG_0_.WorkVec:getz() + _ARG_0_.WorkVec:getx() * _ARG_0_.WorkVec:getx())))
    _ARG_0_.rot:sety(_ARG_0_.rot:gety() + DegToRad(15))
  elseif _ARG_3_ == 1 then
    _ARG_0_.rot:setx(DegToRad(-10) + -Math.Atan2(_ARG_0_.WorkVec:gety(), Math.Sqrt(_ARG_0_.WorkVec:getz() * _ARG_0_.WorkVec:getz() + _ARG_0_.WorkVec:getx() * _ARG_0_.WorkVec:getx())))
    _ARG_0_.rot:sety(_ARG_0_.rot:gety() - DegToRad(15))
  elseif _ARG_3_ == 2 then
    _ARG_0_.rot:setx(DegToRad(-20) + -Math.Atan2(_ARG_0_.WorkVec:gety(), Math.Sqrt(_ARG_0_.WorkVec:getz() * _ARG_0_.WorkVec:getz() + _ARG_0_.WorkVec:getx() * _ARG_0_.WorkVec:getx())))
    _ARG_0_.rot:sety(_ARG_0_.rot:gety() + DegToRad(35))
  elseif _ARG_3_ == 3 then
    _ARG_0_.rot:setx(DegToRad(-20) + -Math.Atan2(_ARG_0_.WorkVec:gety(), Math.Sqrt(_ARG_0_.WorkVec:getz() * _ARG_0_.WorkVec:getz() + _ARG_0_.WorkVec:getx() * _ARG_0_.WorkVec:getx())))
    _ARG_0_.rot:sety(_ARG_0_.rot:gety() - DegToRad(35))
  end
  _ARG_0_.WorkVec1:set(0, 0, 0)
  Entity.GetWorldPos2(_ARG_0_.WorkVec1, _ARG_1_, _ARG_0_.WorkVec1, _ARG_2_)
  Bullet.CreateEffectBullet(Bullet.CreateBullet("m22ex00s", _ARG_0_.WorkVec1, _ARG_0_.rot), "e_ex220", "E022_CUT_00_0")
  if Enemy.IsConfuse(_ARG_0_.myHandle) then
    Bullet.SetCollision(Bullet.CreateBullet("m22ex00s", _ARG_0_.WorkVec1, _ARG_0_.rot), COLL_KIND_ENEMY, COLL_SHAPE_CYLINDER, 1, 0.2, _ARG_1_, -1)
  else
    Bullet.SetCollision(Bullet.CreateBullet("m22ex00s", _ARG_0_.WorkVec1, _ARG_0_.rot), COLL_KIND_ENEMY, COLL_SHAPE_CYLINDER, 1, 0.2, _ARG_1_, -1)
  end
  SetBulletAttackParam(Bullet.CreateBullet("m22ex00s", _ARG_0_.WorkVec1, _ARG_0_.rot), _ARG_1_, 2)
  Bullet.SetHitAttackEffectName(Bullet.CreateBullet("m22ex00s", _ARG_0_.WorkVec1, _ARG_0_.rot), "e_ex220", "E022_CHT_00_0")
  Bullet.SetHitBgEffectName(Bullet.CreateBullet("m22ex00s", _ARG_0_.WorkVec1, _ARG_0_.rot), "e_ex220", "E022_CHT_00_0")
  Entity.SetMovementCollRadius(Bullet.CreateBullet("m22ex00s", _ARG_0_.WorkVec1, _ARG_0_.rot), 0.1)
  Entity.CalcVelocity(Bullet.CreateBullet("m22ex00s", _ARG_0_.WorkVec1, _ARG_0_.rot), 0.5)
  Bullet.SetMaxMoveDist(Bullet.CreateBullet("m22ex00s", _ARG_0_.WorkVec1, _ARG_0_.rot), 225)
  Bullet.EnableReflect(Bullet.CreateBullet("m22ex00s", _ARG_0_.WorkVec1, _ARG_0_.rot), Enemy.GetAttackReflect(_ARG_0_.myHandle, 2))
  EntityManager:GetEntity((Bullet.CreateBullet("m22ex00s", _ARG_0_.WorkVec1, _ARG_0_.rot))).masterHandle = _ARG_1_
  EntityManager:GetEntity((Bullet.CreateBullet("m22ex00s", _ARG_0_.WorkVec1, _ARG_0_.rot))).targetHandle = _ARG_0_.targetHandle
  EntityManager:GetEntity((Bullet.CreateBullet("m22ex00s", _ARG_0_.WorkVec1, _ARG_0_.rot))).homingRot = _ARG_4_
end
function m22ex00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.targetHandle = NULL_HANDLE
  _ARG_0_.NowHeight = 0
  _ARG_0_.MoveMode = 0
  _ARG_0_.Speed = 0
  _ARG_0_.SpeedX = 0
  _ARG_0_.SpeedY = 0
  _ARG_0_.noWallHitTime = 0
  _ARG_0_.RandomMoveTime = 0
  _ARG_0_.MoveTime = 0
  _ARG_0_.wanderAng = 0
  _ARG_0_.RotAng = 0
  _ARG_0_.changeTime = 0
  _ARG_0_.angle = 0
  _ARG_0_.HeightFlag = 0
  _ARG_0_.HeightPow = 0
  _ARG_0_.Wait = 0
  _ARG_0_.LeftAndRightFlag = 0
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkTime = 0
  _ARG_0_.workNum = 0
  _ARG_0_.WorkVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
  _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
  if M22EX_INIT_PARAM == false then
    M22EX_INIT_PARAM = true
  end
  Entity.SetMovementCollRadius(_ARG_0_.myHandle, 1.7)
  Entity.SetLowerHalf(_ARG_0_.myHandle, 2)
  Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
  Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
  Entity.EnableLockon(_ARG_0_.myHandle, 0)
  Entity.EnableGravity(_ARG_0_.myHandle, 0)
  Enemy.IsAllEnemyWaiting()
  Entity.SetDropShadowDistance(_ARG_0_.myHandle, 80)
  if Enemy.IsAllEnemyWaiting() == true then
    _ARG_0_:GotoState("Standby")
  else
    _ARG_0_:GotoState("Appear")
    Entity.EnableLockon(_ARG_0_.myHandle, 1)
  end
end
function m22ex00.OnDamage(_ARG_0_, _ARG_1_)
  print("Attack Kind = " .. _ARG_1_ .. "\n")
  if _ARG_1_ == ATK_KIND_DMG_BLOW or _ARG_1_ == ATK_KIND_DMG_BIG then
    _ARG_0_:GotoState("Blow")
    return 1
  end
  print("OnDamage\n")
end
function m22ex00.OnReturnDamage(_ARG_0_)
  _ARG_0_:GotoState("Idling")
end
function m22ex00.OnHitAttack(_ARG_0_)
end
function m22ex00.Debug(_ARG_0_)
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
function m22ex00.OnUpdate(_ARG_0_)
  _ARG_0_:Update()
  _ARG_0_:Debug()
end
EntityFactory:Add("m22ex00", function(_ARG_0_)
  return (m22ex00:new())
end)
EntityFactory:Add("m22vs00", function(_ARG_0_)
  return (m22ex00:new())
end)
m22ex00s = {}
m22ex00s_mt = {__index = m22ex00s}
function m22ex00s.new(_ARG_0_)
  return setmetatable({}, m22ex00s_mt)
end
function m22ex00s.OnReflect(_ARG_0_)
  _ARG_0_.step = 2
  Entity.SetTimer(_ARG_0_.myHandle, 1980)
end
function m22ex00s.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.masterHandle = NULL_HANDLE
  _ARG_0_.step = 0
  _ARG_0_.homing = 1
  _ARG_0_.targetHandle = NULL_HANDLE
  _ARG_0_.WorkTime = 60
  _ARG_0_.speed = 0.5
  _ARG_0_.nowHomingRot = 1
  _ARG_0_.homingRot = 0
  Entity.SetTimer(_ARG_0_.myHandle, 0)
  _ARG_0_.WorkVec = FVECTOR3.new(0, 0, 0)
end
function m22ex00s.OnUpdate(_ARG_0_)
  _ARG_0_.WorkTime = _ARG_0_.WorkTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_0_.step == 0 then
    if Entity.IsTimeOver(_ARG_0_.myHandle) then
      _ARG_0_.step = 1
    end
  elseif _ARG_0_.step == 1 then
    _ARG_0_.speed = _ARG_0_.speed - 0.05 * Entity.GetFrameRate(_ARG_0_.myHandle)
    if _ARG_0_.speed < 0.25 then
      _ARG_0_.speed = 0.25
    end
    _ARG_0_.nowHomingRot = _ARG_0_.nowHomingRot + 0.05 * Entity.GetFrameRate(_ARG_0_.myHandle)
    if _ARG_0_.nowHomingRot > _ARG_0_.homingRot then
      _ARG_0_.nowHomingRot = _ARG_0_.homingRot
    end
    Entity.CalcVelocity(_ARG_0_.myHandle, _ARG_0_.speed)
    Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.targetHandle, 5)
    Entity.TurnTargetDegree(_ARG_0_.myHandle, _ARG_0_.WorkVec, _ARG_0_.homingRot)
    if _ARG_0_.WorkTime < 0 then
      _ARG_0_.step = 2
      Entity.SetTimer(_ARG_0_.myHandle, 1980)
    end
  elseif _ARG_0_.step == 2 and Entity.IsTimeOver(_ARG_0_.myHandle) then
    Bullet.DeleteBullet(_ARG_0_.myHandle)
  end
end
EntityFactory:Add("m22ex00s", function(_ARG_0_)
  return (m22ex00s:new())
end)
