m02sb00 = {}
m02sb00_base_mt = {__index = __StateMachine}
setmetatable(m02sb00, m02sb00_base_mt)
m02sb00_mt = {__index = m02sb00}
function m02sb00.new(_ARG_0_)
  return setmetatable(__StateMachine:new(), m02sb00_mt)
end
m02sb00.states = {
  Appear = {
    OnBeginState = function(_ARG_0_)
      SetupAppearBegin(_ARG_0_.myHandle, 1, _UPVALUE0_, 0)
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
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_ + Script.Random() * 80)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.BodyFlag = _UPVALUE2_
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 20)
      if _ARG_0_.Type == _UPVALUE0_ then
        if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
          return
        end
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE1_ then
          _ARG_0_:GotoState("Move")
        elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _UPVALUE1_ and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE2_ then
          _ARG_0_:GotoState("Shooting")
        else
        end
      elseif (Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > ENEMY_COMMON_DISAPPEAR_DIST or Entity.CalcStartPosDistanceSq(_ARG_0_.myHandle) > ENEMY_COMMON_DISAPPEAR_DIST) and _ARG_0_.Type == _UPVALUE3_ then
        if _ARG_0_.JumpFlag == 1 then
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
          return
        end
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE1_ then
          _ARG_0_:GotoState("Back")
        elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _UPVALUE1_ and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE2_ then
          _ARG_0_:GotoState("Shooting")
        elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > ENEMY_COMMON_DISAPPEAR_DIST or Entity.CalcStartPosDistanceSq(_ARG_0_.myHandle) > ENEMY_COMMON_DISAPPEAR_DIST then
        end
      end
    end
  },
  Move = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.step = _UPVALUE0_
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == _UPVALUE0_ then
        _ARG_0_.workVec:set(0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle) + DegToRad(180), 0)
        Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.workVec)
        _ARG_0_.step = _UPVALUE1_
      elseif _ARG_0_.step == _UPVALUE1_ then
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _UPVALUE2_ then
          _ARG_0_:GotoState("Shooting")
          return
        end
        _ARG_0_:Move(_UPVALUE3_, 0.2)
      end
      if Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.IsWall(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Shooting")
        return
      end
    end
  },
  Wander = {
    OnBeginState = function(_ARG_0_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.step = M01SB_MOVE_INIT
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.HasNetGameHandle(_ARG_0_.myHandle) and Enemy.IsNetworkMaster(_ARG_0_.myHandle) == false then
        return
      end
      if _ARG_0_.step == M01SB_MOVE_INIT then
        Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
        _ARG_0_.targetPos:setx(_ARG_0_.targetPos:getx() + 5 * Script.Random() * Math.Cos((RoundPI(Script.Random() * 2 * PI))))
        _ARG_0_.targetPos:setz(_ARG_0_.targetPos:getz() + 5 * Script.Random() * Math.Sin((RoundPI(Script.Random() * 2 * PI))))
        _ARG_0_.step = M01SB_MOVE_INIT2
      elseif _ARG_0_.step == M01SB_MOVE_INIT2 then
        Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
        _ARG_0_.workVec0:set(1, 0, 0)
        Math.RotateVectorXYZ(_ARG_0_.workVec0, _ARG_0_.rot)
        Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
        FVECTOR3.Sub(_ARG_0_.workVec1, _ARG_0_.myPos, _ARG_0_.targetPos)
        _ARG_0_.workVec1:normalize()
        if _ARG_0_.workVec0:dot(_ARG_0_.workVec1) < -0.1 then
          _ARG_0_:Rotation(1)
        elseif _ARG_0_.workVec0:dot(_ARG_0_.workVec1) > 0.1 then
          _ARG_0_:Rotation(-1)
        else
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
          _ARG_0_.step = M01SB_MOVE_INIT3
        end
      elseif _ARG_0_.step == M01SB_MOVE_INIT3 then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 10)
        _ARG_0_.WorkVec:set(0, 0, M01SB_SPEED)
        if Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.IsWall(_ARG_0_.myHandle) or 1 > Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetPos) then
          _ARG_0_.count = _ARG_0_.count + 1
          if _ARG_0_.count > 4 then
            _ARG_0_:GotoState("Idling")
          else
            _ARG_0_.step = M01SB_MOVE_INIT
            Entity.ClearSpeed(_ARG_0_.myHandle)
          end
        end
      end
    end
  },
  Back = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.step = _UPVALUE0_
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
      _ARG_0_.Speed = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == _UPVALUE0_ then
        _ARG_0_.step = _UPVALUE1_
      elseif _ARG_0_.step == _UPVALUE1_ then
        _ARG_0_:BackMove(_UPVALUE2_, 0.2)
      end
      if Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.IsWall(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Jump = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
      _ARG_0_.JumpFlag = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        FVECTOR3.set(_ARG_0_.WorkVec, 0, 0.06, 0)
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.WorkVec)
        _ARG_0_.WorkVec:set(0, 0, 0.04)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 then
        if Entity.IsGround(_ARG_0_.myHandle) then
          Entity.ClearSpeed(_ARG_0_.myHandle)
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
          _ARG_0_.step = 2
        end
      elseif _ARG_0_.step == 2 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
        return
      end
    end
  },
  Shooting = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.AttackFlag = 0
      _ARG_0_.step = 99
      _ARG_0_.BodyFlag = _UPVALUE0_
      _ARG_0_.ShootFlag = _UPVALUE1_
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_.AttackFlag = 0
      _ARG_0_.BodyFlag = _UPVALUE0_
    end,
    OnUpdate = function(_ARG_0_)
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 20)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      if _ARG_0_.step == _UPVALUE0_ or _ARG_0_.step == _UPVALUE1_ then
        _ARG_0_.Hitrate = Script.Random()
        if _ARG_0_.ShootFlag == _UPVALUE2_ then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= _UPVALUE3_ then
            _ARG_0_:CreateArrow(0, 0)
            _ARG_0_.ShootFlag = _UPVALUE4_
          end
        elseif _ARG_0_.ShootFlag == _UPVALUE5_ and Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= _UPVALUE3_ then
          _ARG_0_:CreateArrow(1, _UPVALUE6_)
          _ARG_0_:CreateArrow(2, _UPVALUE7_)
          _ARG_0_:CreateArrow(3, _UPVALUE8_)
          _ARG_0_.ShootFlag = _UPVALUE4_
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.step = _UPVALUE9_
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE10_)
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE11_)
          _ARG_0_.BodyFlag = _UPVALUE12_
        end
      elseif _ARG_0_.step == _UPVALUE9_ then
        if _ARG_0_.AttackFlag == 1 then
          _ARG_0_.step = _UPVALUE13_
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE14_)
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE15_)
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
      elseif _ARG_0_.step == _UPVALUE13_ then
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
      elseif _ARG_0_.step == 99 and Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10) == false then
        if Script.Random() < _UPVALUE16_ then
          _ARG_0_.step = _UPVALUE0_
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE17_)
          _ARG_0_.ShootFlag = _UPVALUE2_
        else
          _ARG_0_.step = _UPVALUE1_
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE17_)
          _ARG_0_.ShootFlag = _UPVALUE5_
        end
      end
    end
  },
  MagicDamage = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 1
      _ARG_0_.MoveMode = 0
      _ARG_0_.MoveFlag = 0
      _ARG_0_.Speed = 0
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_ + Script.Random() * _UPVALUE2_)
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      Effect.LoopEnd(_ARG_0_.DameEffectHand)
      _ARG_0_.DameEffectHand = NULL_HANDLE
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Script.Random() < 0.5 then
          _ARG_0_.MoveFlag = 0
        elseif Script.Random() < 0.5 then
          _ARG_0_.MoveFlag = 1
        else
          _ARG_0_.MoveFlag = 2
        end
        _ARG_0_.step = 1
        _ARG_0_.WorkTime = _UPVALUE0_ + Script.Random() * _UPVALUE1_
      elseif _ARG_0_.step == 1 then
        if _ARG_0_.MoveMode == 0 then
          if _ARG_0_.MoveFlag == 1 then
            _ARG_0_:Rotation(1)
          elseif _ARG_0_.MoveFlag == 2 then
            _ARG_0_:Rotation(-1)
          end
          if 0 > _ARG_0_.noWallTime and Entity.IsWall(_ARG_0_.myHandle) then
            if Script.Random() < 0.5 then
              _ARG_0_.MoveFlag = 1
            else
              _ARG_0_.MoveFlag = 2
            end
            _ARG_0_.noWallTime = 120
            _ARG_0_.WorkTime = 60
          end
          if 0 > _ARG_0_.WorkTime then
            _ARG_0_.step = 0
          end
          _ARG_0_:Move(_UPVALUE2_, 0.2)
        elseif _ARG_0_.MoveMode == 1 then
          if 0 > _ARG_0_.WorkTime then
            _ARG_0_.MoveFlag = _ARG_0_.MoveFlag + 1
            if _ARG_0_.MoveFlag >= 2 then
              _ARG_0_.MoveFlag = 0
            end
            _ARG_0_.WorkTime = _UPVALUE3_
            if Script.Random() < 0.2 then
              _ARG_0_.MoveMode = 0
            elseif Script.Random() < 0.4 then
              _ARG_0_.MoveMode = 1
            end
          else
          end
          if _ARG_0_.MoveFlag == 0 then
            _ARG_0_:TurnY(DegToRad(_ARG_0_.AngY))
            _ARG_0_.AngY = _ARG_0_.AngY + _UPVALUE4_ * 0.05 * Entity.GetFrameRate(_ARG_0_.myHandle)
            if _ARG_0_.AngY > _UPVALUE4_ then
              _ARG_0_.AngY = _UPVALUE4_
            end
          end
          if _ARG_0_.MoveFlag == 1 then
            _ARG_0_:TurnY(DegToRad(_ARG_0_.AngY))
            _ARG_0_.AngY = _ARG_0_.AngY - _UPVALUE4_ * 0.1 * Entity.GetFrameRate(_ARG_0_.myHandle)
            if _ARG_0_.AngY < -_UPVALUE4_ then
              _ARG_0_.AngY = -_UPVALUE4_
            end
          end
          _ARG_0_:Move(_UPVALUE2_, 0.2)
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
          return
        end
      elseif _ARG_0_.step == 2 then
      elseif _ARG_0_.step == 3 then
      end
      _ARG_0_.WorkTime = _ARG_0_.WorkTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      _ARG_0_.noWallTime = _ARG_0_.noWallTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
    end
  },
  Summons = {
    OnBeginState = function(_ARG_0_)
      SetupAppearBegin(_ARG_0_.myHandle, 1, _UPVALUE0_, 0)
      if Script.Random() < 0.5 then
        Enemy.InitHP(_ARG_0_.myHandle, 0.5)
      else
        Enemy.InitHP(_ARG_0_.myHandle, 0.5)
      end
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
  Standby = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.EnableLockon(_ARG_0_.myHandle, 1)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Enemy.IsAllEnemyWaiting() == false then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Sleep = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.step = 0
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
          _ARG_0_.step = 1
        end
      elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  TargetPosMove = {
    OnBeginState = function(_ARG_0_)
      SetupAppearBegin(_ARG_0_.myHandle, 1, _UPVALUE0_, 0)
      SetupAppearEnd(_ARG_0_.myHandle)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.step = 0
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      Entity.EnableLockon(_ARG_0_.myHandle, 0)
      Entity.EnableShooton(_ARG_0_.myHandle, 0)
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        _ARG_0_.WorkVec1:set(-11.911, 0, 3.8308)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.WorkVec, 1.5)
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.WorkVec) < 9 then
          _ARG_0_.step = 1
          _ARG_0_.targetPos:set(0, 0, 0)
          _ARG_0_.targetPos:setx(_ARG_0_.WorkVec:getx() + Script.Random() * 5 * Math.Cos((RoundPI(Script.Random() * 2 * PI))))
          _ARG_0_.targetPos:setz(_ARG_0_.WorkVec:getz() + Script.Random() * 5 * Math.Sin((RoundPI(Script.Random() * 2 * PI))))
          Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
          Entity.EnableLockon(_ARG_0_.myHandle, 1)
          Entity.EnableShooton(_ARG_0_.myHandle, 1)
        end
      elseif _ARG_0_.step == 1 then
        _ARG_0_.WorkVec:set(0, 0, 0)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 1.5)
        if 9 > Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) or Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 4 then
          _ARG_0_:GotoState("Move")
        end
      end
      _ARG_0_.WorkVec:set(0, 0, _UPVALUE0_)
      Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
    end
  },
  TargetPosLeftMove = {
    OnBeginState = function(_ARG_0_)
      SetupAppearBegin(_ARG_0_.myHandle, 30, _UPVALUE0_, 0)
      SetupAppearEnd(_ARG_0_.myHandle)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.step = 0
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      Entity.EnableLockon(_ARG_0_.myHandle, 0)
      Entity.EnableShooton(_ARG_0_.myHandle, 0)
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        _ARG_0_.WorkVec:set(30.787, 1, 8.765)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.WorkVec, 15)
        if 1 > Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.WorkVec) then
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 then
        _ARG_0_.WorkVec:set(11.911, 0, 2.8308)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.WorkVec, 1.5)
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.WorkVec) < 9 then
          _ARG_0_.step = 2
          _ARG_0_.targetPos:set(0, 0, 0)
          _ARG_0_.targetPos:setx(_ARG_0_.WorkVec:getx() + Script.Random() * 5 * Math.Cos((RoundPI(Script.Random() * 2 * PI))))
          _ARG_0_.targetPos:setz(_ARG_0_.WorkVec:getz() + Script.Random() * 5 * Math.Sin((RoundPI(Script.Random() * 2 * PI))))
          Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
          Entity.EnableLockon(_ARG_0_.myHandle, 1)
          Entity.EnableShooton(_ARG_0_.myHandle, 1)
        end
      elseif _ARG_0_.step == 2 then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 1.5)
        if 9 > Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) or Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 4 then
          _ARG_0_:GotoState("Move")
        end
      end
      _ARG_0_.WorkVec:set(0, 0, _UPVALUE0_)
      Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
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
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
    end
  }
}
function m02sb00.Rotation(_ARG_0_, _ARG_1_)
  if Entity.GetMotionNowFrame(_ARG_0_.myHandle) - Entity.GetMotionOldFrame(_ARG_0_.myHandle) < 0 then
  else
  end
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  _ARG_0_.rot:sety(RoundPI(_ARG_0_.rot:gety() + DegToRad((Entity.GetMotionNowFrame(_ARG_0_.myHandle) - Entity.GetMotionOldFrame(_ARG_0_.myHandle)) * (90 / Entity.GetMotionTotalFrame(_ARG_0_.myHandle))) * _ARG_1_))
  Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
  return DegToRad((Entity.GetMotionNowFrame(_ARG_0_.myHandle) - Entity.GetMotionOldFrame(_ARG_0_.myHandle)) * (90 / Entity.GetMotionTotalFrame(_ARG_0_.myHandle))) * _ARG_1_
end
function m02sb00.Move(_ARG_0_, _ARG_1_, _ARG_2_)
  _ARG_0_.Speed = _ARG_0_.Speed + _ARG_1_ * _ARG_2_ * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_1_ < _ARG_0_.Speed then
    _ARG_0_.Speed = _ARG_1_
  end
  FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Speed)
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function m02sb00.CreateArrow(_ARG_0_, _ARG_1_, _ARG_2_)
  Entity.GetWorldPos(_ARG_0_.WorkVec1, _ARG_0_.targetHandle, 2)
  Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.myHandle, 18)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.WorkVec1, _ARG_0_.WorkVec)
  FVECTOR3.normalize(_ARG_0_.workVec)
  _ARG_0_.rot:setx(-Math.Atan2(_ARG_0_.workVec:gety(), Math.Sqrt(_ARG_0_.workVec:getz() * _ARG_0_.workVec:getz() + _ARG_0_.workVec:getx() * _ARG_0_.workVec:getx())))
  if Entity.IsPlayer(_ARG_0_.targetHandle) then
    _ARG_0_.rot:sety((Math.Atan2(_ARG_0_.workVec:getx(), _ARG_0_.workVec:getz())))
  end
  _ARG_0_.SubRot = _UPVALUE1_ - (_ARG_0_.WorkVec:gety() - _ARG_0_.WorkVec1:gety()) * (0.01 * _UPVALUE2_)
  _ARG_0_.rot:setx(_ARG_0_.rot:getx() - DegToRad(45))
  if _ARG_0_.Hitrate < 0 then
    _ARG_0_.rot:setx(_ARG_0_.rot:getx() + Script.Random() * 0.01 * Math.Cos((RoundPI(Script.Random() * 2 * PI))))
    _ARG_0_.rot:sety(_ARG_0_.rot:gety() + 0.2 * Script.Random() * Math.Sin((RoundPI(Script.Random() * 2 * PI))))
  end
  _ARG_0_.rot:sety(_ARG_0_.rot:gety() + _ARG_2_)
  Bullet.CreateEffectBullet(Bullet.CreateBullet("m02sb00b", _ARG_0_.WorkVec, _ARG_0_.rot, _ARG_0_.myHandle), "e_ex310", "E031_ARW_00_0")
  if Enemy.IsConfuse(_ARG_0_.myHandle) then
    Bullet.SetCollision(Bullet.CreateBullet("m02sb00b", _ARG_0_.WorkVec, _ARG_0_.rot, _ARG_0_.myHandle), COLL_KIND_NO_CHECK, COLL_SHAPE_SPHERE, 0.1, 0, _ARG_0_.myHandle)
  else
    Bullet.SetCollision(Bullet.CreateBullet("m02sb00b", _ARG_0_.WorkVec, _ARG_0_.rot, _ARG_0_.myHandle), COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, 0.1, 0, _ARG_0_.myHandle)
  end
  SetBulletAttackParam(Bullet.CreateBullet("m02sb00b", _ARG_0_.WorkVec, _ARG_0_.rot, _ARG_0_.myHandle), _ARG_0_.myHandle, _ARG_1_)
  Bullet.SetMaxMoveDist(Bullet.CreateBullet("m02sb00b", _ARG_0_.WorkVec, _ARG_0_.rot, _ARG_0_.myHandle), 100)
  Bullet.SetHitAttackEffectName(Bullet.CreateBullet("m02sb00b", _ARG_0_.WorkVec, _ARG_0_.rot, _ARG_0_.myHandle), "e_ex310", "E031_ARW_01_0")
  Bullet.SetHitBgEffectName(Bullet.CreateBullet("m02sb00b", _ARG_0_.WorkVec, _ARG_0_.rot, _ARG_0_.myHandle), "e_ex310", "E031_ARW_02_0")
  _ARG_0_.ArrowHandle, EntityManager:GetEntity((Bullet.CreateBullet("m02sb00b", _ARG_0_.WorkVec, _ARG_0_.rot, _ARG_0_.myHandle))).SubRot = Bullet.CreateBullet("m02sb00b", _ARG_0_.WorkVec, _ARG_0_.rot, _ARG_0_.myHandle), _ARG_0_.SubRot
end
function m02sb00.BackMove(_ARG_0_, _ARG_1_, _ARG_2_)
  _ARG_0_.Speed = _ARG_0_.Speed - _ARG_1_ * _ARG_2_ * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_0_.Speed < -_ARG_1_ then
    _ARG_0_.Speed = -_ARG_1_
  end
  FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Speed)
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
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
function m02sb00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.targetHandle = NULL_HANDLE
  _ARG_0_.DameEffectHand = NULL_HANDLE
  _ARG_0_.ArrowHandle = NULL_HANDLE
  _ARG_0_.MoveMode = 0
  _ARG_0_.MoveFlag = 0
  _ARG_0_.noWallTime = 0
  _ARG_0_.WorkTime = 0
  _ARG_0_.Speed = 0
  _ARG_0_.DanceCnt = 0
  _ARG_0_.AttackFlag = 0
  _ARG_0_.BodyFlag = 0
  _ARG_0_.AttackAtt = 0
  _ARG_0_.Hitrate = 0
  _ARG_0_.SubRot = 0
  _ARG_0_.underLockOnflag = 0
  _ARG_0_.ShootFlag = 0
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkTime = 0
  _ARG_0_.WorkVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
  _ARG_0_.BodyVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.cameraPos = FVECTOR3.new(0, 0, 0)
  if _UPVALUE0_ == false then
    _UPVALUE1_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "Action1DisA")
    _UPVALUE1_ = _UPVALUE1_ * _UPVALUE1_
    _UPVALUE2_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "Action2DisA")
    _UPVALUE2_ = _UPVALUE2_ * _UPVALUE2_
    _UPVALUE3_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "AttackRate") / 100
    _UPVALUE4_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "MagicDamT") * 60
    _UPVALUE5_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "DanceCount")
    _UPVALUE6_ = Enemy.GetExtraParam(_ARG_1_, "SleepTime") * 60
    _UPVALUE7_ = Enemy.GetExtraParam(_ARG_1_, "ArrowAng")
    _UPVALUE8_ = Enemy.GetExtraParam(_ARG_1_, "ArrowSMag")
    _UPVALUE9_ = _UPVALUE9_ * _UPVALUE8_
    _UPVALUE10_ = 1 * _UPVALUE7_
    _UPVALUE11_ = Enemy.GetExtraParam(_ARG_1_, "Shoot3Ang1")
    _UPVALUE12_ = Enemy.GetExtraParam(_ARG_1_, "Shoot3Ang2")
    _UPVALUE13_ = Enemy.GetExtraParam(_ARG_1_, "Shoot3Ang3")
    _UPVALUE14_ = _UPVALUE9_ * 2 * (_UPVALUE7_ + (1 - _UPVALUE7_) * -1 * 0.05)
    _UPVALUE0_ = true
  end
  _ARG_0_.Type = 0
  _ARG_0_.setparam = Entity.GetLayoutParam(_ARG_0_.myHandle, 1)
  _ARG_0_.JumpTime = 0
  _ARG_0_.JumpFlag = 0
  if _ARG_0_.setparam == 1 then
    _ARG_0_.JumpTime = Entity.GetLayoutParam(_ARG_0_.myHandle, 2)
    _ARG_0_.JumpFlag = 1
    _ARG_0_.Type = _UPVALUE15_
  else
    _ARG_0_.Type = _UPVALUE16_
  end
  Entity.SetMovementCollRadius(_ARG_0_.myHandle, 0.6)
  Entity.SetLowerHalf(_ARG_0_.myHandle, 0.7)
  Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
  Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
  Entity.EnableLockon(_ARG_0_.myHandle, 0)
  Entity.EnableGravity(_ARG_0_.myHandle, 1)
  Enemy.IsAllEnemyWaiting()
  Entity.SetDropShadowDistance(_ARG_0_.myHandle, 80)
  if Enemy.IsAllEnemyWaiting() == true then
    _ARG_0_:GotoState("Standby")
  else
    _ARG_0_:GotoState("Appear")
    Entity.EnableLockon(_ARG_0_.myHandle, 1)
  end
  if Mission.IsMissionNow() == false then
    Entity.SetDispOffCameraDistance(_ARG_0_.myHandle, 22)
  end
end
function m02sb00.BodyAngle(_ARG_0_)
  if _ARG_0_.BodyFlag == _UPVALUE0_ then
    _ARG_0_.BodyVec:set(0, 0, 0)
    Entity.RotateBoneXYZ(_ARG_0_.myHandle, 11, _ARG_0_.BodyVec)
  elseif _ARG_0_.BodyFlag == _UPVALUE1_ then
    Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.targetHandle, 2)
    Entity.GetWorldPos(_ARG_0_.WorkVec1, _ARG_0_.myHandle, 11)
    Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
    FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.WorkVec, _ARG_0_.WorkVec1)
    FVECTOR3.normalize(_ARG_0_.workVec)
    _ARG_0_.SubRot = _UPVALUE3_
    _ARG_0_.rot:setx(_ARG_0_.rot:getx() - DegToRad(45))
    _ARG_0_.oldAnglx = -Math.Atan2(_ARG_0_.workVec:gety(), Math.Sqrt(_ARG_0_.workVec:getz() * _ARG_0_.workVec:getz() + _ARG_0_.workVec:getx() * _ARG_0_.workVec:getx())) - _ARG_0_.rot:getx()
    _ARG_0_.BodyVec:set(0, 0, ROUND_PI(-Math.Atan2(_ARG_0_.workVec:gety(), Math.Sqrt(_ARG_0_.workVec:getz() * _ARG_0_.workVec:getz() + _ARG_0_.workVec:getx() * _ARG_0_.workVec:getx())) - _ARG_0_.rot:getx()))
    Entity.RotateBoneXYZ(_ARG_0_.myHandle, 11, _ARG_0_.BodyVec)
  end
end
function m02sb00.OnDamage(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if _ARG_1_ == ATK_KIND_FREEZE then
    return 0
  end
  _ARG_0_.AttackAttr = _ARG_3_
  if _ARG_0_:GetState() == "Sleep" or _ARG_0_:GetState() == "TargetPosLeftMove" or _ARG_0_:GetState() == "TargetPosMove" then
    return 1
  end
  if _ARG_1_ == ATK_KIND_SLEEPINGDEATH then
    _ARG_0_:GotoState("Sleep")
    return 1
  end
  if _ARG_0_:GetState() == "MagicDamage" then
    Effect.LoopEnd(_ARG_0_.DameEffectHand)
    _ARG_0_.DameEffectHand = NULL_HANDLE
  end
  if _ARG_2_ == 2 and _ARG_0_:GetState() == "MagicDamage" then
    return 0
  end
  if _ARG_2_ == 2 then
    if _ARG_3_ == ATK_ATTR_FIRE then
      if _ARG_0_:GetState() ~= "MagicDamage" then
        _ARG_0_.WorkVec:set(0, 0.2, 0.2)
        Entity.GetWorldPos2(_ARG_0_.WorkVec1, _ARG_0_.myHandle, _ARG_0_.WorkVec)
        Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
        _ARG_0_.DameEffectHand = Entity.AttachEffect(_ARG_0_.myHandle, "e_ex300", "E030_MGC_00_0", "Root", _ARG_0_.WorkVec, _ARG_0_.rot)
        Effect.SetAttachReverseTrs(_ARG_0_.DameEffectHand, true)
        _ARG_0_:GotoState("MagicDamage")
      end
      return 1
    elseif _ARG_3_ == ATK_ATTR_ICE then
      if _ARG_0_:GetState() ~= "MagicDamage" then
        _ARG_0_.WorkVec:set(0, 0.2, 0.2)
        Entity.GetWorldPos2(_ARG_0_.WorkVec1, _ARG_0_.myHandle, _ARG_0_.WorkVec)
        Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
        _ARG_0_.DameEffectHand = Entity.AttachEffect(_ARG_0_.myHandle, "e_ex300", "E030_MGC_01_0", "Root", _ARG_0_.WorkVec, _ARG_0_.rot)
        Effect.SetAttachReverseTrs(_ARG_0_.DameEffectHand, true)
        _ARG_0_:GotoState("MagicDamage")
      end
      return 1
    elseif _ARG_3_ == ATK_ATTR_THUNDER then
      if _ARG_0_:GetState() ~= "MagicDamage" then
        _ARG_0_.WorkVec:set(0, 0.2, 0.2)
        Entity.GetWorldPos2(_ARG_0_.WorkVec1, _ARG_0_.myHandle, _ARG_0_.WorkVec)
        Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
        _ARG_0_.DameEffectHand = Entity.AttachEffect(_ARG_0_.myHandle, "e_ex300", "E030_MGC_02_0", "Root", _ARG_0_.WorkVec, _ARG_0_.rot)
        Effect.SetAttachReverseTrs(_ARG_0_.DameEffectHand, true)
        _ARG_0_:GotoState("MagicDamage")
      end
      return 1
    end
  end
end
function m02sb00.OnReturnDamage(_ARG_0_)
  if _ARG_0_.AttackAttr == ATK_ATTR_FIRE then
    _ARG_0_:GotoState("MagicDamage")
    _ARG_0_.WorkVec:set(0, 0.2, 0.2)
    Entity.GetWorldPos2(_ARG_0_.WorkVec1, _ARG_0_.myHandle, _ARG_0_.WorkVec)
    Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
    _ARG_0_.DameEffectHand = Entity.AttachEffect(_ARG_0_.myHandle, "e_ex300", "E030_MGC_00_0", "Root", _ARG_0_.WorkVec, _ARG_0_.rot)
    Effect.SetAttachReverseTrs(_ARG_0_.DameEffectHand, true)
    return
  elseif _ARG_0_.AttackAttr == ATK_ATTR_ICE then
    _ARG_0_:GotoState("MagicDamage")
    _ARG_0_.WorkVec:set(0, 0.2, 0.2)
    Entity.GetWorldPos2(_ARG_0_.WorkVec1, _ARG_0_.myHandle, _ARG_0_.WorkVec)
    Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
    _ARG_0_.DameEffectHand = Entity.AttachEffect(_ARG_0_.myHandle, "e_ex300", "E030_MGC_01_0", "Root", _ARG_0_.WorkVec, _ARG_0_.rot)
    Effect.SetAttachReverseTrs(_ARG_0_.DameEffectHand, true)
    return
  elseif _ARG_0_.AttackAttr == ATK_ATTR_THUNDER then
    _ARG_0_:GotoState("MagicDamage")
    _ARG_0_.WorkVec:set(0, 0.2, 0.2)
    Entity.GetWorldPos2(_ARG_0_.WorkVec1, _ARG_0_.myHandle, _ARG_0_.WorkVec)
    Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
    _ARG_0_.DameEffectHand = Entity.AttachEffect(_ARG_0_.myHandle, "e_ex300", "E030_MGC_02_0", "Root", _ARG_0_.WorkVec, _ARG_0_.rot)
    Effect.SetAttachReverseTrs(_ARG_0_.DameEffectHand, true)
    return
  end
  _ARG_0_:GotoState("Idling")
end
function m02sb00.OnHitAttack(_ARG_0_)
  _ARG_0_.AttackFlag = 1
end
function m02sb00.OnUpdatePositionAfter(_ARG_0_)
  _ARG_0_:BodyAngle()
end
function m02sb00.Debug(_ARG_0_)
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
function m02sb00.OnUpdate(_ARG_0_)
  _ARG_0_:Update()
  _ARG_0_:Debug()
  if _ARG_0_.underLockOnflag == 0 and Mission.GetMissionKind() == JOINT_STRUGGLE_PHILLIP_1 then
    Entity.GetWorldPos(_ARG_0_.WorkVec1, _ARG_0_.myHandle)
    if _ARG_0_.WorkVec1:gety() < 2 then
      Entity.EnableLockon(_ARG_0_.myHandle, 1)
      Entity.EnableShooton(_ARG_0_.myHandle, 1)
      _ARG_0_.underLockOnflag = 1
    end
  end
end
EntityFactory:Add("m02sb00", function(_ARG_0_)
  return (m02sb00:new())
end)
EntityFactory:Add("m52vs00", function(_ARG_0_)
  return (m02sb00:new())
end)
EntityFactory:Add("m02sb00b", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
