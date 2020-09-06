m01sb00 = {}
m01sb00_base_mt = {__index = __StateMachine}
setmetatable(m01sb00, m01sb00_base_mt)
m01sb00_mt = {__index = m01sb00}
function m01sb00.new(_ARG_0_)
  return setmetatable(__StateMachine:new(), m01sb00_mt)
end
m01sb00.states = {
  Appear = {
    OnBeginState = function(_ARG_0_)
      SetupAppearBegin(_ARG_0_.myHandle, 1, _UPVALUE0_, 0)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
    end,
    OnEndState = function(_ARG_0_)
      SetupAppearEnd(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
      if _ARG_0_.step == 0 and Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10) == false then
        _ARG_0_.step = _ARG_0_.step + 1
      end
    end
  },
  Idling = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      Entity.SetTimer(_ARG_0_.myHandle, Script.Random() * _UPVALUE0_ + _UPVALUE1_)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE2_)
      _ARG_0_.step = 0
      Effect.LoopEnd(_ARG_0_.DameEffectHand)
      _ARG_0_.DameEffectHand = NULL_HANDLE
      Enemy.SetAimPersistenceTime(_ARG_0_.myHandle, 2400)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        Enemy.GetTargetLastRecordedPos(_ARG_0_.targetPos, _ARG_0_.myHandle, _ARG_0_.targetHandle)
        if Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 10) == false then
          _ARG_0_.step = _ARG_0_.step + 1
        end
      end
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        if _ARG_0_.Type == _UPVALUE0_ then
        else
        end
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE2_ then
          if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) == true then
            _ARG_0_:GotoState("SpearAttack")
          else
            _ARG_0_:GotoState("Wander")
          end
        elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _UPVALUE2_ then
          if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) == true then
            _ARG_0_:GotoState("Move")
          else
            _ARG_0_:GotoState("Wander")
          end
        end
      end
    end
  },
  Move = {
    OnBeginState = function(_ARG_0_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.step = 0
      Entity.GetWorldPos(_ARG_0_.MoveStartPos, _ARG_0_.myHandle)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        if Entity.IsLOSOkay(_ARG_0_.myHandle, _ARG_0_.targetHandle) == false then
          _ARG_0_:GotoState("OldMove")
          return
        end
        _ARG_0_:GotoState("Idling")
        return
      end
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 3)
      _ARG_0_.WorkVec:set(0, 0, _UPVALUE0_)
      Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
      if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) == true then
        if _ARG_0_.Type == _UPVALUE1_ then
        else
        end
        if _UPVALUE3_ > _ARG_0_.PlayerDist then
          _ARG_0_:GotoState("SpearAttack")
          return
        end
      end
    end
  },
  OldMove = {
    OnBeginState = function(_ARG_0_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.step = 0
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsLOSOkay(_ARG_0_.myHandle, _ARG_0_.targetHandle) == false then
        if _ARG_0_.Type == _UPVALUE0_ then
        else
        end
        if _UPVALUE2_ > _ARG_0_.PlayerDist then
          _ARG_0_:GotoState("SpearAttack")
          return
        end
      end
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
        return
      end
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.MoveStartPos, 10)
      _ARG_0_.WorkVec:set(0, 0, _UPVALUE3_)
      Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
      if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetPos) < 1 then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Wander = {
    OnBeginState = function(_ARG_0_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_ * (Script.Random() * 2))
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
        if Enemy.GetTimeTargetHasBeenVisible(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 2400 then
          Enemy.GetTargetLastRecordedPos(_ARG_0_.targetPos, _ARG_0_.myHandle, _ARG_0_.targetHandle)
        else
          Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.myHandle)
        end
        _ARG_0_.WorkVec:set(0, 0, 0)
        Entity.GetWallNormal(_ARG_0_.WorkVec, _ARG_0_.myHandle)
        _ARG_0_.targetPos:setx(_ARG_0_.targetPos:getx() + (5 * Script.Random() * Math.Cos((RoundPI(Script.Random() * 2 * PI))) + _ARG_0_.WorkVec:getx()))
        _ARG_0_.targetPos:setz(_ARG_0_.targetPos:getz() + (5 * Script.Random() * Math.Sin((RoundPI(Script.Random() * 2 * PI))) + _ARG_0_.WorkVec:getz()))
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_ * (Script.Random() * 2))
        _ARG_0_.noWallHitTime = 120
        _ARG_0_.step = _UPVALUE2_
      elseif _ARG_0_.step == _UPVALUE3_ then
      elseif _ARG_0_.step == _UPVALUE2_ then
        if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) == true then
          if _ARG_0_.Type == _UPVALUE4_ then
          else
          end
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE6_ then
            _ARG_0_:GotoState("SpearAttack")
            return
          else
            _ARG_0_:GotoState("Move")
            return
          end
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 3)
        _ARG_0_.MoveFlag = M01SB_MOVETYPE_HOMING
        if CanDisappear(_ARG_0_.myHandle, _ARG_0_.targetHandle) == true then
          return
        end
        _ARG_0_.WorkVec:set(0, 0, _UPVALUE7_)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
        _ARG_0_.noWallHitTime = _ARG_0_.noWallHitTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if 0 > _ARG_0_.noWallHitTime then
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.IsWall(_ARG_0_.myHandle) == true or 1 > Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetPos) then
          _ARG_0_.count = _ARG_0_.count + 1
          if _ARG_0_.count > 4 then
            _ARG_0_:GotoState("Idling")
          else
            _ARG_0_.step = _UPVALUE0_
          end
        end
      end
    end
  },
  SpearAttack = {
    OnBeginState = function(_ARG_0_)
      if _ARG_0_.Type == _UPVALUE0_ then
        if Script.Random() < _UPVALUE1_ then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
        else
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
        end
      else
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE4_)
      end
      _ARG_0_.AttackFlag = 0
      _ARG_0_.step = 0
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      if _ARG_0_.PlayerDist < _UPVALUE5_ then
        Entity.SetRootMoveScale(_ARG_0_.myHandle, Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) / 4, 1, Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) / 4)
      end
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10) == false then
          _ARG_0_.step = _ARG_0_.step + 1
        end
      elseif _ARG_0_.step == 1 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 32 and Mission.IsMissionNow() == 1 and _ARG_0_.AttackFlag == 1 then
          _ARG_0_.step = 2
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
      elseif _ARG_0_.step == 2 then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 2)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
          _ARG_0_.DanceCnt = _ARG_0_.DanceCnt + 1
          if _ARG_0_.DanceCnt >= _UPVALUE2_ then
            _ARG_0_:GotoState("Idling")
            _ARG_0_.DanceCnt = 0
          end
        end
      end
    end
  },
  Rock_Idling = {
    OnBeginState = function(_ARG_0_)
      if _ARG_0_.Type == _UPVALUE0_ then
      else
        _ARG_0_.WorkVec1:set(0, 0, 0)
        _ARG_0_.RockHandle = Bullet.CreateBullet("m03sb00", _ARG_0_.WorkVec1, _ARG_0_.WorkVec1)
        Bullet.SetCollision(_ARG_0_.RockHandle, COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, 0.6, 0, _ARG_0_.myHandle)
        SetBulletAttackParam(_ARG_0_.RockHandle, _ARG_0_.myHandle, 3)
        Bullet.EnableAttackCollision(_ARG_0_.RockHandle, 0)
        Entity.AttachCoord(_ARG_0_.myHandle, "R_buki", _ARG_0_.RockHandle, "Root")
        Entity.EnableBgColl(_ARG_0_.RockHandle, 0)
        Entity.EnableBodyColl(_ARG_0_.RockHandle, 0)
        Entity.EnableGravity(_ARG_0_.RockHandle, 0)
        Entity.EnableLockon(_ARG_0_.RockHandle, 0)
        Bullet.SetMaxMoveDist(_ARG_0_.RockHandle, 100000000)
        Bullet.SetHitBgEffectName(_ARG_0_.RockHandle, "e_ex300", "E030_ROK_02_0")
        Bullet.SetHitAttackEffectName(_ARG_0_.RockHandle, "e_ex300", "E030_ROK_01_0")
        EntityManager:GetEntity(_ARG_0_.RockHandle).MasterHandle = _ARG_0_.myHandle
        _ARG_0_.WorkTime = 60
      end
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE2_)
      Entity.EnableLockon(_ARG_0_.myHandle, 0)
      Entity.EnableShooton(_ARG_0_.myHandle, 0)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      _ARG_0_.WorkVec1:set(17.56, 7.76, -1.312)
      _ARG_0_.WorkTime = _ARG_0_.WorkTime - 1
      if _ARG_0_.WorkTime > 0 then
        Entity.GetRot(_ARG_0_.StartRot, _ARG_0_.myHandle)
      else
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 2)
      end
      if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
        return
      end
      if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.WorkVec1) < 25 then
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 144 then
          _ARG_0_:GotoState("Rock_Throw")
        end
      elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE0_ then
        _ARG_0_:GotoState("Rock_Throw")
      end
    end
  },
  Rock_Throw = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        Entity.GetWorldPos(_ARG_0_.WorkVec1, _ARG_0_.RockHandle)
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 11 then
          Entity.GetWorldPos(_ARG_0_.WorkVec1, _ARG_0_.RockHandle, 2)
          Entity.SetOldLocalPos(_ARG_0_.RockHandle, _ARG_0_.WorkVec1)
          Entity.SetLocalPos(_ARG_0_.RockHandle, _ARG_0_.WorkVec1)
          Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
          Entity.AttachCoord(NULL_HANDLE, "", _ARG_0_.RockHandle, "Root")
          _ARG_0_.WorkVec0:set(0, 0, 0)
          Entity.GetWorldPos(_ARG_0_.PlayerPos, _ARG_0_.targetHandle, 2)
          Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
          FVECTOR3.Sub(_ARG_0_.WorkVec, _ARG_0_.PlayerPos, _ARG_0_.WorkVec1)
          FVECTOR3.normalize(_ARG_0_.WorkVec)
          _ARG_0_.rot:setx(-Math.Atan2(_ARG_0_.WorkVec:gety(), Math.Sqrt(_ARG_0_.WorkVec:getz() * _ARG_0_.WorkVec:getz() + _ARG_0_.WorkVec:getx() * _ARG_0_.WorkVec:getx())) - _ARG_0_.rot:getx())
          Entity.SetRot(_ARG_0_.RockHandle, _ARG_0_.rot)
          _ARG_0_.WorkVec:set(0, 0.1, 0.3)
          _ARG_0_.velocity:set(0, 0.1, 0.3)
          Math.RotateVectorXYZ(_ARG_0_.velocity, _ARG_0_.rot)
          Entity.SetVelocity(_ARG_0_.RockHandle, _ARG_0_.velocity)
          Entity.EnableGravity(_ARG_0_.RockHandle, 1)
          Entity.EnableBgColl(_ARG_0_.RockHandle, 1)
          Bullet.EnableAttackCollision(_ARG_0_.RockHandle, 1)
          EntityManager:GetEntity(_ARG_0_.RockHandle).LoopEffect = Entity.AttachEffect(_ARG_0_.RockHandle, "e_ex300", "E030_ROK_00_0", "center")
          _ARG_0_.step = 1
        else
          Entity.SetOldLocalPos(_ARG_0_.RockHandle, _ARG_0_.OldWorkVec)
        end
        Entity.GetWorldPos(_ARG_0_.OldWorkVec, _ARG_0_.RockHandle)
      elseif _ARG_0_.step == 1 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        if _ARG_0_:CheckPlayerEnshrining() == 1 then
          _ARG_0_:GotoState("Idling")
        else
          _ARG_0_:GotoState("Jump")
        end
      end
    end
  },
  Jump = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
      FVECTOR3.set(_ARG_0_.WorkVec, 8.31, 5.983, 3.41)
      if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.WorkVec) < 25 then
        _ARG_0_.StartRot:sety(_ARG_0_.StartRot:gety() + DegToRad(-90))
        Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.StartRot)
      else
        Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.StartRot)
      end
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      Entity.EnableLockon(_ARG_0_.myHandle, 1)
      Entity.EnableShooton(_ARG_0_.myHandle, 1)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        FVECTOR3.set(_ARG_0_.WorkVec, 0, 0.06, 0)
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.WorkVec)
        _ARG_0_.WorkVec:set(0, 0, 0.05)
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
  MagicDamage = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 1
      _ARG_0_.MoveMode = 0
      _ARG_0_.MoveFlag = 0
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_ + Script.Random() * _UPVALUE2_)
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
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
            _ARG_0_:Rotation(2)
          elseif _ARG_0_.MoveFlag == 2 then
            _ARG_0_:Rotation(-2)
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
            _ARG_0_.AngY = _ARG_0_.AngY + _UPVALUE4_ * 0.05 * _ARG_0_.FrameRate
            if _ARG_0_.AngY > _UPVALUE4_ then
              _ARG_0_.AngY = _UPVALUE4_
            end
          end
          if _ARG_0_.MoveFlag == 1 then
            _ARG_0_:TurnY(DegToRad(_ARG_0_.AngY))
            _ARG_0_.AngY = _ARG_0_.AngY - _UPVALUE4_ * 0.1 * _ARG_0_.FrameRate
            if _ARG_0_.AngY < -_UPVALUE4_ then
              _ARG_0_.AngY = -_UPVALUE4_
            end
          end
          _ARG_0_:Move(_UPVALUE2_, 0.2)
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
          Effect.LoopEnd(_ARG_0_.DameEffectHand)
          _ARG_0_.DameEffectHand = NULL_HANDLE
          return
        end
      elseif _ARG_0_.step == 2 then
      elseif _ARG_0_.step == 3 then
      end
      _ARG_0_.WorkTime = _ARG_0_.WorkTime - 1 * _ARG_0_.FrameRate
      _ARG_0_.noWallTime = _ARG_0_.noWallTime - 1 * _ARG_0_.FrameRate
    end
  },
  RockDamage = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.RockHandle)
      Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
      Entity.SetEffect(_ARG_0_.myHandle, "e_ex300", "E030_ROK_02_0", _ARG_0_.WorkVec, _ARG_0_.rot)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
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
  Summons = {
    OnBeginState = function(_ARG_0_)
      SetupAppearBegin(_ARG_0_.myHandle, 1, _UPVALUE0_, 0)
      if Script.Random() < 0.5 then
        Entity.EnableModelDisp(_ARG_0_.myHandle, 1, 0)
        Entity.EnableModelDisp(_ARG_0_.myHandle, 2, 1)
        _ARG_0_:SetWeapon(_UPVALUE1_)
        Enemy.InitHP(_ARG_0_.myHandle, _UPVALUE2_)
      else
        Entity.EnableModelDisp(_ARG_0_.myHandle, 1, 1)
        Entity.EnableModelDisp(_ARG_0_.myHandle, 2, 0)
        _ARG_0_:SetWeapon(_UPVALUE3_)
        Enemy.InitHP(_ARG_0_.myHandle, _UPVALUE4_)
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
  TargetPosMove = {
    OnBeginState = function(_ARG_0_)
      SetupAppearBegin(_ARG_0_.myHandle, 30, _UPVALUE0_, 0)
      if Script.Random() < 0.5 then
        Entity.EnableModelDisp(_ARG_0_.myHandle, 1, 0)
        Entity.EnableModelDisp(_ARG_0_.myHandle, 2, 1)
        _ARG_0_:SetWeapon(_UPVALUE1_)
      else
        Entity.EnableModelDisp(_ARG_0_.myHandle, 1, 1)
        Entity.EnableModelDisp(_ARG_0_.myHandle, 2, 0)
        _ARG_0_:SetWeapon(_UPVALUE2_)
      end
      SetupAppearEnd(_ARG_0_.myHandle)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
      _ARG_0_.step = 0
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      Entity.EnableLockon(_ARG_0_.myHandle, 0)
      Entity.EnableShooton(_ARG_0_.myHandle, 0)
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      Entity.EnableLockon(_ARG_0_.myHandle, 1)
      Entity.EnableShooton(_ARG_0_.myHandle, 1)
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
      if Script.Random() < 0.5 then
        Entity.EnableModelDisp(_ARG_0_.myHandle, 1, 0)
        Entity.EnableModelDisp(_ARG_0_.myHandle, 2, 1)
        _ARG_0_:SetWeapon(_UPVALUE1_)
      else
        Entity.EnableModelDisp(_ARG_0_.myHandle, 1, 1)
        Entity.EnableModelDisp(_ARG_0_.myHandle, 2, 0)
        _ARG_0_:SetWeapon(_UPVALUE2_)
      end
      SetupAppearEnd(_ARG_0_.myHandle)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
      _ARG_0_.step = 0
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      Entity.EnableLockon(_ARG_0_.myHandle, 0)
      Entity.EnableShooton(_ARG_0_.myHandle, 0)
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      Entity.EnableLockon(_ARG_0_.myHandle, 1)
      Entity.EnableShooton(_ARG_0_.myHandle, 1)
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
  Standby = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
    end,
    OnEndState = function(_ARG_0_)
      Entity.EnableLockon(_ARG_0_.myHandle, 1)
    end,
    OnUpdate = function(_ARG_0_)
      if Enemy.IsAllEnemyWaiting() == false then
        if _ARG_0_.Type == _UPVALUE0_ then
          _ARG_0_:GotoState("Idling")
          Entity.EnableLockon(_ARG_0_.myHandle, 1)
        elseif _ARG_0_.Type == _UPVALUE1_ then
          _ARG_0_:GotoState("Idling")
          Entity.EnableLockon(_ARG_0_.myHandle, 1)
        else
          _ARG_0_:GotoState("Rock_Idling")
          Entity.EnableLockon(_ARG_0_.myHandle, 1)
        end
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
function m01sb00.Rotation(_ARG_0_, _ARG_1_)
  if Entity.GetMotionNowFrame(_ARG_0_.myHandle) - Entity.GetMotionOldFrame(_ARG_0_.myHandle) < 0 then
  else
  end
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  _ARG_0_.rot:sety(RoundPI(_ARG_0_.rot:gety() + DegToRad((Entity.GetMotionNowFrame(_ARG_0_.myHandle) - Entity.GetMotionOldFrame(_ARG_0_.myHandle)) * (90 / Entity.GetMotionTotalFrame(_ARG_0_.myHandle))) * _ARG_1_))
  Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
  return DegToRad((Entity.GetMotionNowFrame(_ARG_0_.myHandle) - Entity.GetMotionOldFrame(_ARG_0_.myHandle)) * (90 / Entity.GetMotionTotalFrame(_ARG_0_.myHandle))) * _ARG_1_
end
function m01sb00.Move(_ARG_0_, _ARG_1_, _ARG_2_)
  _ARG_0_.Speed = _ARG_0_.Speed + _ARG_1_ * _ARG_2_ * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_1_ < _ARG_0_.Speed then
    _ARG_0_.Speed = _ARG_1_
  end
  FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Speed)
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function m01sb00.CheckPlayerEnshrining(_ARG_0_)
  Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.targetHandle)
  Entity.GetWorldPos(_ARG_0_.WorkVec0, _ARG_0_.myHandle)
  if _ARG_0_.WorkVec:gety() >= _ARG_0_.WorkVec0:gety() - 0.5 and Entity.IsGround((Player.GetHandle())) then
    return 1
  end
  return 0
end
function m01sb00.SetWeapon(_ARG_0_, _ARG_1_)
  _ARG_0_.Type = _ARG_1_
end
function m01sb00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.targetHandle = NULL_HANDLE
  _ARG_0_.RockHandle = NULL_HANDLE
  _ARG_0_.DameEffectHand = NULL_HANDLE
  _ARG_0_.FrameRate = 0
  _ARG_0_.PlayerDist = 0
  _ARG_0_.AttackFlag = 0
  _ARG_0_.AttackAttr = 0
  _ARG_0_.count = 0
  _ARG_0_.MoveMode = 0
  _ARG_0_.MoveFlag = 0
  _ARG_0_.noWallTime = 0
  _ARG_0_.WorkTime = 0
  _ARG_0_.Speed = 0
  _ARG_0_.DanceCnt = 0
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkTime = 0
  _ARG_0_.WorkVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkVec0 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.OldWorkVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
  _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.PlayerPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.MoveStartPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.StartRot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.noWallHitTime = 0
  _ARG_0_.setparam = 0
  _ARG_0_.cameraPos = FVECTOR3.new(0, 0, 0)
  if _UPVALUE0_ == false then
    _UPVALUE1_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "Action0Dist")
    _UPVALUE1_ = _UPVALUE1_ * _UPVALUE1_
    _UPVALUE2_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "Action1Dist")
    _UPVALUE2_ = _UPVALUE2_ * _UPVALUE2_
    _UPVALUE3_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "Action2Dist")
    _UPVALUE3_ = _UPVALUE3_ * _UPVALUE3_
    _UPVALUE4_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "Action3Dist")
    _UPVALUE4_ = _UPVALUE4_ * _UPVALUE4_
    _UPVALUE5_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "TwoAttackR") / 100
    _UPVALUE6_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "MagicDamT") * 60
    _UPVALUE7_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "DanceCount")
    _UPVALUE8_ = Enemy.GetExtraParam(_ARG_1_, "SleepTime") * 60
    _UPVALUE9_ = Enemy.GetExtraParam(_ARG_1_, "SumMaHP")
    _UPVALUE10_ = Enemy.GetExtraParam(_ARG_1_, "SumSpHP")
    _UPVALUE0_ = true
  end
  _ARG_0_.Type = _UPVALUE11_
  _ARG_0_.setparam = Entity.GetLayoutParam(_ARG_0_.myHandle, 1)
  if _ARG_0_.setparam == 1 then
    Entity.EnableModelDisp(_ARG_0_.myHandle, 1, 0)
    Entity.EnableModelDisp(_ARG_0_.myHandle, 2, 1)
    _ARG_0_.Type = _UPVALUE12_
  elseif _ARG_0_.setparam == 2 then
    Entity.EnableModelDisp(_ARG_0_.myHandle, 1, 0)
    Entity.EnableModelDisp(_ARG_0_.myHandle, 2, 1)
    _ARG_0_.Type = _UPVALUE13_
  else
    Entity.EnableModelDisp(_ARG_0_.myHandle, 1, 1)
    Entity.EnableModelDisp(_ARG_0_.myHandle, 2, 0)
    _ARG_0_.Type = _UPVALUE11_
  end
  Entity.SetMovementCollRadius(_ARG_0_.myHandle, 0.5)
  Entity.SetLowerHalf(_ARG_0_.myHandle, 0.6)
  Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
  Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
  Entity.EnableLockon(_ARG_0_.myHandle, 0)
  Entity.EnableGravity(_ARG_0_.myHandle, 1)
  Enemy.IsAllEnemyWaiting()
  Entity.SetDropShadowDistance(_ARG_0_.myHandle, 80)
  Entity.EnableModelDisp(_ARG_0_.myHandle, 0, 1)
  Entity.EnableModelDisp(_ARG_0_.myHandle, 1, 1)
  Entity.EnableModelDisp(_ARG_0_.myHandle, 2, 0)
  if Enemy.IsAllEnemyWaiting() == true then
    if _ARG_0_.Type == _UPVALUE11_ then
      _ARG_0_:GotoState("Standby")
      Entity.EnableLockon(_ARG_0_.myHandle, 1)
    elseif _ARG_0_.Type == _UPVALUE13_ then
      _ARG_0_:GotoState("Standby")
      Entity.EnableLockon(_ARG_0_.myHandle, 1)
    else
      _ARG_0_:GotoState("Rock_Idling")
    end
  elseif _ARG_0_.Type == _UPVALUE11_ then
    _ARG_0_:GotoState("Appear")
    Entity.EnableLockon(_ARG_0_.myHandle, 1)
  elseif _ARG_0_.Type == _UPVALUE13_ then
    _ARG_0_:GotoState("Appear")
    Entity.EnableLockon(_ARG_0_.myHandle, 1)
  else
    _ARG_0_:GotoState("Rock_Idling")
  end
  if Mission.IsMissionNow() == false then
    Entity.SetDispOffCameraDistance(_ARG_0_.myHandle, 22)
  end
end
function m01sb00.OnDamage(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
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
  if _ARG_0_:GetState() == "Rock_Throw" or _ARG_0_:GetState() == "Rock_Idling" then
    _ARG_0_:GotoState("RockDamage")
    if _ARG_0_.RockHandle then
      Entity.Out(_ARG_0_.RockHandle)
    end
    _ARG_0_.RockHandle = NULL_HANDLE
    return 1
  elseif _ARG_2_ == 2 then
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
function m01sb00.OnReturnDamage(_ARG_0_)
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
function m01sb00.OnDead(_ARG_0_)
  if _ARG_0_.RockHandle then
    Entity.Out(_ARG_0_.RockHandle)
  end
  _ARG_0_.RockHandle = NULL_HANDLE
end
function m01sb00.OnHitAttack(_ARG_0_)
  _ARG_0_.AttackFlag = 1
end
function m01sb00.Debug(_ARG_0_)
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
function m01sb00.OnUpdate(_ARG_0_)
  _ARG_0_.PlayerDist = Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle)
  _ARG_0_.FrameRate = Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_0_.Type == _UPVALUE0_ then
    Entity.EnableModelDisp(_ARG_0_.myHandle, 1, 1)
    Entity.EnableModelDisp(_ARG_0_.myHandle, 2, 0)
  else
    Entity.EnableModelDisp(_ARG_0_.myHandle, 1, 0)
    Entity.EnableModelDisp(_ARG_0_.myHandle, 2, 1)
  end
  _ARG_0_:Update()
  _ARG_0_:Debug()
end
EntityFactory:Add("m01sb00", function(_ARG_0_)
  return (m01sb00:new())
end)
EntityFactory:Add("m51vs00", function(_ARG_0_)
  return (m01sb00:new())
end)
