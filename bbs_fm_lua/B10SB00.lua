b10sb00 = {}
b10sb00_base_mt = {__index = __StateMachine}
setmetatable(b10sb00, b10sb00_base_mt)
b10sb00_mt = {__index = b10sb00}
function b10sb00.new(_ARG_0_)
  return setmetatable(__StateMachine:new(), b10sb00_mt)
end
b10sb00.states = {
  Appear = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
      Entity.EnableLockonAndShooton(_ARG_0_.spoolHandle, 0)
      Entity.EnableLockonAndShooton(_ARG_0_.wheelHandle, 0)
    end,
    OnEndState = function(_ARG_0_)
      Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
      Entity.EnableLockonAndShooton(_ARG_0_.spoolHandle, 1)
      Entity.EnableLockonAndShooton(_ARG_0_.wheelHandle, 1)
    end,
    OnUpdate = function(_ARG_0_)
      if Enemy.IsAllEnemyWaiting() == false then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  AppearArena = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
      Entity.EnableLockonAndShooton(_ARG_0_.spoolHandle, 0)
      Entity.EnableLockonAndShooton(_ARG_0_.wheelHandle, 0)
      Entity.SetAlpha(_ARG_0_.myHandle, 0)
      if Mission.IsFlagFinalRound() == 1 then
        _ARG_0_.step = 0
      else
        SetupAppearBegin(_ARG_0_.myHandle, -1, _UPVALUE0_, 1)
        _ARG_0_.step = 1
      end
    end,
    OnEndState = function(_ARG_0_)
      Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
      Entity.EnableLockonAndShooton(_ARG_0_.spoolHandle, 1)
      Entity.EnableLockonAndShooton(_ARG_0_.wheelHandle, 1)
      SetupAppearEnd(_ARG_0_.myHandle)
      Entity.SetAlpha(_ARG_0_.myHandle, 1)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Exusia.IsExistenceSchedule() then
          SetupAppearBegin(_ARG_0_.myHandle, -1, _UPVALUE0_, 1)
          _ARG_0_.step = 1
        end
      else
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
        if Enemy.IsAllEnemyWaiting() == false then
          _ARG_0_:GotoState("Idling")
        end
      end
    end
  },
  Idling = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.step = 0
      _ARG_0_.stack:clear()
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
    end,
    OnEndState = function(_ARG_0_)
      Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      if _ARG_0_.step == 0 then
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          if _ARG_0_:IsAliveArms() == false or _ARG_0_:RestHpRate() < _UPVALUE0_ then
            _ARG_0_.stack:push("Idling2")
            _ARG_0_.stack:push("KeepDistance")
            if Script.Random() < 0.5 then
              _ARG_0_.stack:push("JumpAttack")
              _ARG_0_.stack:push("JumpAttack")
              _ARG_0_.stack:push("JumpAttack")
              _ARG_0_.stack:push("Gallop2")
            else
              _ARG_0_.stack:push("SwingArm")
              _ARG_0_.stack:push("Gallop")
              _ARG_0_.stack:push("Gallop2")
              _ARG_0_.stack:push("SwingArm")
              _ARG_0_.stack:push("Gallop")
              _ARG_0_.stack:push("Gallop2")
              _ARG_0_.stack:push("SwingArm")
              _ARG_0_.stack:push("Gallop")
            end
            _ARG_0_:ChangeState(_ARG_0_.stack:pop(1))
            return
          end
          if Script.Random() < 0.5 then
            _ARG_0_.flag = 0
          else
            _ARG_0_.flag = 1
          end
          Entity.SetTimer(_ARG_0_.myHandle, 300)
          _ARG_0_.step = 1
        end
      else
        if _ARG_0_:IsAliveArms() == false then
          _ARG_0_.step = 0
          return
        end
        if Entity.HasNetGameHandle(_ARG_0_.myHandle) and Enemy.IsNetworkMaster(_ARG_0_.myHandle) == false then
          Entity.SetMotionSpeed(_ARG_0_.myHandle, 2)
          return
        end
        if _ARG_0_.flag == 0 then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE1_)
          Entity.SetMotionSpeed(_ARG_0_.myHandle, 2)
          _ARG_0_:Rotation(1)
        else
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE2_)
          Entity.SetMotionSpeed(_ARG_0_.myHandle, 2)
          _ARG_0_:Rotation(-1)
        end
        if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) == false then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_.stack:push("Idling")
            _ARG_0_.stack:push("JumpAttack")
            _ARG_0_.stack:push("Wander")
            _ARG_0_:ChangeState(_ARG_0_.stack:pop(1))
          end
          return
        end
        if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE3_ then
          _ARG_0_.stack:push("Idling")
          _ARG_0_.stack:push("KeepDistance")
          _ARG_0_.stack:push("TargetRotation")
          _ARG_0_.stack:push("SwingArm")
          _ARG_0_:ChangeState(_ARG_0_.stack:pop(1))
        else
          _ARG_0_.stack:push("Idling")
          if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) >= _UPVALUE3_ and Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE4_ then
            if Script.Random() < _UPVALUE5_ then
              if Entity.IsAlive(_ARG_0_.wheelHandle) then
                _ARG_0_.stack:push("JumpAttack2")
                _ARG_0_.stack:push("JumpAttack")
                _ARG_0_.stack:push("JumpAttack")
                _ARG_0_.stack:push("WheelShoot")
              else
                _ARG_0_.stack:push("JumpAttack")
                _ARG_0_.stack:push("JumpAttack")
                _ARG_0_.stack:push("StringOfDeath")
              end
            elseif Entity.IsAlive(_ARG_0_.spoolHandle) then
              _ARG_0_.stack:push("JumpAttack")
              _ARG_0_.stack:push("JumpAttack")
              _ARG_0_.stack:push("StringOfDeath")
            else
              _ARG_0_.stack:push("JumpAttack2")
              _ARG_0_.stack:push("JumpAttack")
              _ARG_0_.stack:push("JumpAttack")
              _ARG_0_.stack:push("WheelShoot")
            end
          else
            _ARG_0_.stack:push("JumpAttack")
            _ARG_0_.stack:push("Wander")
          end
          _ARG_0_:ChangeState(_ARG_0_.stack:pop(1))
        end
      end
    end
  },
  Idling2 = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_.stack:push("Idling")
        if Entity.IsAlive(_ARG_0_.wheelHandle) then
          _ARG_0_.stack:push("JumpAttack2")
          _ARG_0_.stack:push("WheelShoot")
        elseif Entity.IsAlive(_ARG_0_.spoolHandle) then
          _ARG_0_.stack:push("StringOfDeath")
        else
          _ARG_0_.stack:push("JumpAttack")
        end
        _ARG_0_:ChangeState(_ARG_0_.stack:pop(1))
      end
    end
  },
  TargetRotation = {
    OnBeginState = function(_ARG_0_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
    end,
    OnEndState = function(_ARG_0_)
      Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      if Entity.HasNetGameHandle(_ARG_0_.myHandle) and Enemy.IsNetworkMaster(_ARG_0_.myHandle) == false then
        Entity.SetMotionSpeed(_ARG_0_.myHandle, 2)
        return
      end
      Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
      _ARG_0_.workVec0:set(1, 0, 0)
      Math.RotateVectorXYZ(_ARG_0_.workVec0, _ARG_0_.rot)
      Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
      Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
      FVECTOR3.Sub(_ARG_0_.workVec1, _ARG_0_.myPos, _ARG_0_.targetPos)
      _ARG_0_.workVec1:normalize()
      if _ARG_0_.workVec0:dot(_ARG_0_.workVec1) < -0.1 then
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetMotionSpeed(_ARG_0_.myHandle, 2)
        _ARG_0_:Rotation(1)
      elseif _ARG_0_.workVec0:dot(_ARG_0_.workVec1) > 0.1 then
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE1_)
        Entity.SetMotionSpeed(_ARG_0_.myHandle, 2)
        _ARG_0_:Rotation(-1)
      else
        _ARG_0_:ChangeState(_ARG_0_.stack:pop(1))
        return
      end
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:ChangeState(_ARG_0_.stack:pop(1))
      end
    end
  },
  KeepDistance = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
      _ARG_0_.workVec0:set(0, 0, -_UPVALUE0_)
      Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.workVec0)
      if Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) >= 36 then
        _ARG_0_:ChangeState(_ARG_0_.stack:pop(1))
      end
    end
  },
  Wander = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
      _ARG_0_.count = 0
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      if Entity.HasNetGameHandle(_ARG_0_.myHandle) and Enemy.IsNetworkMaster(_ARG_0_.myHandle) == false then
        return
      end
      if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE0_ then
        _ARG_0_:ChangeState(_ARG_0_.stack:pop(1))
        return
      end
      if _ARG_0_.step == 0 then
        Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
        _ARG_0_.targetPos:setx(_ARG_0_.targetPos:getx() + 5 * Script.Random() * Math.Cos((RoundPI(Script.Random() * 2 * PI))))
        _ARG_0_.targetPos:setz(_ARG_0_.targetPos:getz() + 5 * Script.Random() * Math.Sin((RoundPI(Script.Random() * 2 * PI))))
        _ARG_0_.step = 1
      elseif _ARG_0_.step == 1 then
        Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
        _ARG_0_.workVec0:set(1, 0, 0)
        Math.RotateVectorXYZ(_ARG_0_.workVec0, _ARG_0_.rot)
        Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
        FVECTOR3.Sub(_ARG_0_.workVec1, _ARG_0_.myPos, _ARG_0_.targetPos)
        _ARG_0_.workVec1:normalize()
        if _ARG_0_.workVec0:dot(_ARG_0_.workVec1) < -0.1 then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE1_)
          _ARG_0_:Rotation(1)
        elseif _ARG_0_.workVec0:dot(_ARG_0_.workVec1) > 0.1 then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE2_)
          _ARG_0_:Rotation(-1)
        else
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE4_)
          _ARG_0_.step = 2
        end
      elseif _ARG_0_.step == 2 then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 10)
        _ARG_0_.workVec0:set(0, 0, _UPVALUE5_)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.workVec0)
        if Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.IsWall(_ARG_0_.myHandle) or 1 > Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetPos) then
          _ARG_0_.count = _ARG_0_.count + 1
          if _ARG_0_.count > 4 then
            _ARG_0_:ChangeState(_ARG_0_.stack:pop(1))
          else
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE6_)
            _ARG_0_.step = 0
            Entity.ClearSpeed(_ARG_0_.myHandle)
          end
        end
      end
    end
  },
  Gallop = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, -1, 0)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      _ARG_0_.step = 0
      _ARG_0_.flag = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      if _ARG_0_.step == 0 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 70 then
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 then
        _ARG_0_.workVec0:set(-1, 0, 0)
        Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
        Math.RotateVectorXYZ(_ARG_0_.workVec0, _ARG_0_.rot)
        Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
        Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
        Entity.FindPosition(_ARG_0_.targetPos, _ARG_0_.myHandle, _ARG_0_.targetPos, 5)
        FVECTOR3.Sub(_ARG_0_.workVec1, _ARG_0_.targetPos, _ARG_0_.myPos)
        _ARG_0_.rot:set(0, HomingDegree(Math.Atan2(_ARG_0_.workVec0:getx(), _ARG_0_.workVec0:getz()), Math.Atan2(_ARG_0_.workVec1:getx(), _ARG_0_.workVec1:getz()), _UPVALUE1_, Entity.GetFrameRate(_ARG_0_.myHandle)))
        _ARG_0_.workVec1:set(0, 0, _UPVALUE2_)
        Math.RotateVectorXYZ(_ARG_0_.workVec1, _ARG_0_.rot)
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.workVec1)
        _ARG_0_.rot:sety((RoundPI(HomingDegree(Math.Atan2(_ARG_0_.workVec0:getx(), _ARG_0_.workVec0:getz()), Math.Atan2(_ARG_0_.workVec1:getx(), _ARG_0_.workVec1:getz()), _UPVALUE1_, Entity.GetFrameRate(_ARG_0_.myHandle)) + PI * 0.5)))
        Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
        if _ARG_0_.flag ~= 0 or Entity.IsTimeOver(_ARG_0_.myHandle) then
          Entity.ClearSpeed(_ARG_0_.myHandle)
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
          _ARG_0_.step = 2
        end
      elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:ChangeState(_ARG_0_.stack:pop(1))
      end
    end
  },
  Gallop2 = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, -1, 0)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      if _ARG_0_.step == 0 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 70 then
          Entity.SetTimer(_ARG_0_.myHandle, 90 + 1.5 * Script.Random() * 60)
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 25 then
          _ARG_0_.workVec0:set(-1, 0, -1)
        elseif Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > 49 then
          _ARG_0_.workVec0:set(-1, 0, 1)
        else
          _ARG_0_.workVec0:set(-1, 0, 0)
        end
        _ARG_0_.workVec0:normalize()
        _ARG_0_.workVec0:scale(_UPVALUE0_)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.workVec0)
        if Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.IsWall(_ARG_0_.myHandle) then
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
          _ARG_0_.step = 2
        end
      elseif _ARG_0_.step == 2 then
        _ARG_0_.workVec0:set(-1, 0, 0)
        Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
        Math.RotateVectorXYZ(_ARG_0_.workVec0, _ARG_0_.rot)
        Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
        Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
        Entity.FindPosition(_ARG_0_.targetPos, _ARG_0_.myHandle, _ARG_0_.targetPos, 5)
        FVECTOR3.Sub(_ARG_0_.workVec1, _ARG_0_.targetPos, _ARG_0_.myPos)
        _ARG_0_.rot:set(0, HomingDegree(Math.Atan2(_ARG_0_.workVec0:getx(), _ARG_0_.workVec0:getz()), Math.Atan2(_ARG_0_.workVec1:getx(), _ARG_0_.workVec1:getz()), _UPVALUE2_ * 3, Entity.GetFrameRate(_ARG_0_.myHandle)))
        _ARG_0_.workVec1:set(0, 0, _UPVALUE0_)
        Math.RotateVectorXYZ(_ARG_0_.workVec1, _ARG_0_.rot)
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.workVec1)
        _ARG_0_.rot:sety((RoundPI(HomingDegree(Math.Atan2(_ARG_0_.workVec0:getx(), _ARG_0_.workVec0:getz()), Math.Atan2(_ARG_0_.workVec1:getx(), _ARG_0_.workVec1:getz()), _UPVALUE2_ * 3, Entity.GetFrameRate(_ARG_0_.myHandle)) + PI * 0.5)))
        Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
        if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= 12.25 or Entity.IsTimeOver(_ARG_0_.myHandle) then
          Entity.ClearSpeed(_ARG_0_.myHandle)
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
          _ARG_0_.step = 3
        end
      elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:ChangeState(_ARG_0_.stack:pop(1))
      end
    end
  },
  SwingArm = {
    OnBeginState = function(_ARG_0_)
      if Entity.IsAlive(_ARG_0_.spoolHandle) == false then
        Entity.SetAttackUseGroup(_ARG_0_.myHandle, 0)
        Entity.SetAttackUseGroup(_ARG_0_.myHandle, 1)
      end
      if Entity.IsAlive(_ARG_0_.wheelHandle) == false then
        Entity.SetAttackUseGroup(_ARG_0_.myHandle, 2)
        Entity.SetAttackUseGroup(_ARG_0_.myHandle, 3)
      end
      if true == false and true == false then
      elseif true == false and true then
      elseif true and true == false then
      else
      end
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 3, 5)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
    end,
    OnEndState = function(_ARG_0_)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:ChangeState(_ARG_0_.stack:pop(1))
      end
    end
  },
  WheelShoot = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.count = 0
      _ARG_0_.step = 0
      Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.myHandle, 2)
      _ARG_0_.workVec3:copy(_ARG_0_.workVec0)
      for _FORV_5_ = 0, 360, 30 do
        _ARG_0_.workVec1:set(Math.Sin((RoundPI(DegToRad(_FORV_5_)))), 0, Math.Cos((RoundPI(DegToRad(_FORV_5_)))))
        _ARG_0_.workVec1:scale(25)
        FVECTOR3.Add(_ARG_0_.workVec1, _ARG_0_.workVec1, _ARG_0_.workVec0)
        Collision.IntersectRayBg(_ARG_0_.workVec1, COLL_KIND_ENEMY, _ARG_0_.workVec0, _ARG_0_.workVec1)
        FVECTOR3.Sub(_ARG_0_.workVec2, _ARG_0_.workVec1, _ARG_0_.workVec0)
        if 0 < _ARG_0_.workVec2:dot(_ARG_0_.workVec2) then
          _ARG_0_.workVec3:copy(_ARG_0_.workVec1)
        end
      end
    end,
    OnEndState = function(_ARG_0_)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.workVec3, 10)
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 15 then
          Entity.CalcOrbitVelocityFromSpeedY(_ARG_0_.myHandle, 0.4, (Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.workVec3)))
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 then
        Entity.GetVelocity(_ARG_0_.workVec0, _ARG_0_.myHandle)
        if 0 > _ARG_0_.workVec0:gety() then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
          _ARG_0_.step = 2
        end
      elseif _ARG_0_.step == 2 then
        if Entity.IsGround(_ARG_0_.myHandle) then
          Entity.ClearSpeed(_ARG_0_.myHandle)
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
          Camera.QuakeV(50, 0.5, 12)
          _ARG_0_.step = 3
        end
      elseif _ARG_0_.step == 3 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
          Entity.EnableLockon(_ARG_0_.wheelHandle, 0)
          _ARG_0_.step = 4
        end
      elseif _ARG_0_.step == 4 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 81 then
          _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
          if EntityManager:GetEntity(_ARG_0_.wheelHandle) ~= nil then
            Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
            EntityManager:GetEntity(_ARG_0_.wheelHandle):GotoState("CutOff")
          end
          _ARG_0_.step = 5
        end
      elseif _ARG_0_.step == 5 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
          _ARG_0_.step = 6
        end
      elseif EntityManager:GetEntity(_ARG_0_.wheelHandle) ~= nil then
        if EntityManager:GetEntity(_ARG_0_.wheelHandle):GetState() == "Wait" then
          _ARG_0_:ChangeState(_ARG_0_.stack:pop(1))
        end
      else
        _ARG_0_:ChangeState(_ARG_0_.stack:pop(1))
      end
    end
  },
  WheelWait = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if EntityManager:GetEntity(_ARG_0_.wheelHandle) ~= nil then
        if EntityManager:GetEntity(_ARG_0_.wheelHandle):GetState() == "Wait" then
          _ARG_0_.stack:push("Idling")
          _ARG_0_:ChangeState("JumpAttack2")
        end
      else
        _ARG_0_:ChangeState("Idling")
      end
    end
  },
  JumpAttack = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 15 then
          Entity.CalcOrbitVelocityFromSpeedY(_ARG_0_.myHandle, 0.35, (Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle)))
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 then
        Entity.GetVelocity(_ARG_0_.workVec0, _ARG_0_.myHandle)
        if 0 > _ARG_0_.workVec0:gety() then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
          _ARG_0_.step = 2
        end
      elseif _ARG_0_.step == 2 then
        if Entity.IsGround(_ARG_0_.myHandle) then
          Entity.ClearSpeed(_ARG_0_.myHandle)
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
          Camera.QuakeV(50, 0.5, 12)
          _ARG_0_.step = 3
        end
      elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:ChangeState(_ARG_0_.stack:pop(1))
      end
    end
  },
  JumpAttack2 = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.EnableHeavy(_ARG_0_.wheelHandle, 1)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      _ARG_0_.workVec0:set(0, 0, 0)
      Entity.SetOldLocalPos(_ARG_0_.wheelHandle, _ARG_0_.workVec0)
      Entity.SetLocalPos(_ARG_0_.wheelHandle, _ARG_0_.workVec0)
      Entity.SetRot(_ARG_0_.wheelHandle, _ARG_0_.workVec0)
      Entity.AttachCoord(_ARG_0_.myHandle, "X_ctl_wheel", _ARG_0_.wheelHandle, "Root")
      Entity.EnableBgColl(_ARG_0_.wheelHandle, 0)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.IsAlive(_ARG_0_.wheelHandle) == false then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        else
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.wheelHandle, 10)
        end
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 15 then
          if Entity.IsAlive(_ARG_0_.wheelHandle) == false then
            Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
            Entity.CalcOrbitVelocityFromSpeedY(_ARG_0_.myHandle, 0.4, (Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle)))
          else
            Entity.GetRot(_ARG_0_.rot, _ARG_0_.wheelHandle)
            _ARG_0_.workVec0:set(0, 0, -2)
            _ARG_0_.rot:setx(0)
            Math.RotateVectorXYZ(_ARG_0_.workVec0, _ARG_0_.rot)
            Entity.GetWorldPos(_ARG_0_.workVec1, _ARG_0_.wheelHandle)
            FVECTOR3.Add(_ARG_0_.workVec0, _ARG_0_.workVec0, _ARG_0_.workVec1)
            Entity.GetWorldPos(_ARG_0_.workVec1, _ARG_0_.myHandle)
            FVECTOR3.Sub(_ARG_0_.workVec0, _ARG_0_.workVec0, _ARG_0_.workVec1)
            _ARG_0_.rot:sety(Math.Atan2(_ARG_0_.workVec0:getx(), _ARG_0_.workVec0:getz()))
            Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
            Entity.CalcOrbitVelocityFromSpeedY(_ARG_0_.myHandle, 0.4, (Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.workVec0)))
          end
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 then
        Entity.GetVelocity(_ARG_0_.workVec0, _ARG_0_.myHandle)
        if 0 > _ARG_0_.workVec0:gety() then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
          _ARG_0_.step = 2
        end
      elseif _ARG_0_.step == 2 then
        if Entity.IsGround(_ARG_0_.myHandle) then
          Entity.ClearSpeed(_ARG_0_.myHandle)
          if Entity.IsAlive(_ARG_0_.wheelHandle) == false then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
          else
            Entity.GetRot(_ARG_0_.rot, _ARG_0_.wheelHandle)
            _ARG_0_.rot:setx(0)
            Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
          end
          Camera.QuakeV(50, 0.5, 12)
          _ARG_0_.step = 3
        end
      elseif _ARG_0_.step == 3 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 4 then
          _ARG_0_.workVec0:set(0, 0, 0)
          Entity.SetOldLocalPos(_ARG_0_.wheelHandle, _ARG_0_.workVec0)
          Entity.SetLocalPos(_ARG_0_.wheelHandle, _ARG_0_.workVec0)
          Entity.SetRot(_ARG_0_.wheelHandle, _ARG_0_.workVec0)
          Entity.SetMotion(_ARG_0_.wheelHandle, _UPVALUE1_)
          Entity.AttachCoord(_ARG_0_.myHandle, "X_ctl_wheel", _ARG_0_.wheelHandle, "Root")
          Entity.EnableBgColl(_ARG_0_.wheelHandle, 0)
          _ARG_0_.step = 4
        end
      elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:ChangeState(_ARG_0_.stack:pop(1))
      end
    end
  },
  StringOfDeath = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Enemy.SetGeneralPurposeAttackColl(_ARG_0_.spoolHandle, COLL_KIND_ENEMY, COLL_SHAPE_CYLINDER, 0.5)
      Enemy.SetGeneralPurposeAttackCollParam(_ARG_0_.spoolHandle, Enemy.GetAttackKind(_ARG_0_.spoolHandle, 1), Enemy.GetAttackAttr(_ARG_0_.spoolHandle, 1), Enemy.GetAttackPoint(_ARG_0_.spoolHandle, 1), Enemy.GetAttackPowerCorrection(_ARG_0_.spoolHandle, 1))
      Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.spoolHandle, 0)
      _ARG_0_.targetHandle2 = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      _ARG_0_.step = 0
      _ARG_0_.step2 = 0
    end,
    OnEndState = function(_ARG_0_)
      if Entity.GetName(_ARG_0_.myHandle) == "b50vs00" then
        _ARG_0_:ReleaseStringOfDeath()
      end
      Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.spoolHandle, 0)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle2, NULL_HANDLE)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.GetCurrentMotion(_ARG_0_.myHandle) == _UPVALUE0_ and Entity.GetMotionNowFrame(_ARG_0_.myHandle) <= 105 then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle2, 10)
      end
      if _ARG_0_.step == 0 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 56 then
          Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.spoolHandle, 5)
          Entity.GetWorldPos(_ARG_0_.workVec1, _ARG_0_.targetHandle2, 2)
          FVECTOR3.Sub(_ARG_0_.workVec1, _ARG_0_.workVec1, _ARG_0_.workVec0)
          _ARG_0_.workVec1:normalize()
          _ARG_0_.workVec0:set(0, 0, 0)
          _ARG_0_.rot:set(-Math.Atan2(_ARG_0_.workVec1:gety(), Math.Sqrt(_ARG_0_.workVec1:getx() * _ARG_0_.workVec1:getx() + _ARG_0_.workVec1:getz() * _ARG_0_.workVec1:getz())), Math.Atan2(_ARG_0_.workVec1:getx(), _ARG_0_.workVec1:getz()), 0)
          _ARG_0_.stringHandle = Entity.AttachEffect(_ARG_0_.spoolHandle, "b10sb00", "B003_SOD_00_0", "R_ude2_scl", _ARG_0_.workVec0, _ARG_0_.rot)
          Effect.SetAttachNoRot(_ARG_0_.stringHandle, true)
          Enemy.SetGeneralPurposeAttackCollPos(_ARG_0_.spoolHandle, _ARG_0_.workVec0, _ARG_0_.workVec0)
          Entity.SetAttackerHandle(_ARG_0_.targetHandle2, _ARG_0_.myHandle)
          _ARG_0_.stringScale = 0
          print("StringOfDeath_0\n")
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 or _ARG_0_.step == 2 then
        if Effect.IsAlive(_ARG_0_.stringHandle) then
          Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.spoolHandle, 5)
          Entity.GetWorldPos(_ARG_0_.workVec1, _ARG_0_.targetHandle2, 2)
          FVECTOR3.Sub(_ARG_0_.workVec1, _ARG_0_.workVec1, _ARG_0_.workVec0)
          _ARG_0_.workVec1:normalize()
          _ARG_0_.workVec2:set(0, 0, 0)
          _ARG_0_.rot:set(-Math.Atan2(_ARG_0_.workVec1:gety(), Math.Sqrt(_ARG_0_.workVec1:getx() * _ARG_0_.workVec1:getx() + _ARG_0_.workVec1:getz() * _ARG_0_.workVec1:getz())), Math.Atan2(_ARG_0_.workVec1:getx(), _ARG_0_.workVec1:getz()), 0)
          Effect.UpdateCoord(_ARG_0_.stringHandle, _ARG_0_.workVec2, _ARG_0_.rot)
          _ARG_0_.workVec1:set(0, 0, 15)
          Math.RotateVectorXYZ(_ARG_0_.workVec1, _ARG_0_.rot)
          FVECTOR3.Add(_ARG_0_.workVec1, _ARG_0_.workVec1, _ARG_0_.workVec0)
          _ARG_0_.workVec3:set(0, 0, -2)
          Math.RotateVectorXYZ(_ARG_0_.workVec3, _ARG_0_.rot)
          FVECTOR3.Add(_ARG_0_.workVec3, _ARG_0_.workVec3, _ARG_0_.workVec0)
          Collision.IntersectRayBg(_ARG_0_.workVec1, COLL_KIND_ENEMY, _ARG_0_.workVec3, _ARG_0_.workVec1)
          FVECTOR3.Sub(_ARG_0_.workVec2, _ARG_0_.workVec1, _ARG_0_.workVec0)
          _ARG_0_.workVec3:set(1, 1, _ARG_0_.workVec2:length() / 15)
          Effect.SetScale(_ARG_0_.stringHandle, _ARG_0_.workVec3)
          if Effect.GetNowFrame(_ARG_0_.stringHandle) >= 12 and Effect.GetNowFrame(_ARG_0_.stringHandle) <= 30 then
            _ARG_0_.stringScale = _ARG_0_.stringScale + _ARG_0_.workVec2:length() / 18 * Entity.GetFrameRate(_ARG_0_.myHandle)
          end
          if _ARG_0_.workVec2:length() < _ARG_0_.stringScale then
            _ARG_0_.stringScale = _ARG_0_.workVec2:length()
          end
          _ARG_0_.workVec2:normalize()
          _ARG_0_.workVec2:scale(_ARG_0_.stringScale)
          FVECTOR3.Add(_ARG_0_.workVec1, _ARG_0_.workVec2, _ARG_0_.workVec0)
          _ARG_0_.workVec2:normalize()
          _ARG_0_.workVec2:scale(_ARG_0_.stringScale)
          FVECTOR3.Add(_ARG_0_.workVec1, _ARG_0_.workVec2, _ARG_0_.workVec0)
          Enemy.SetGeneralPurposeAttackCollPos(_ARG_0_.spoolHandle, _ARG_0_.workVec0, _ARG_0_.workVec1)
          if _ARG_0_.step2 == 0 then
            if Effect.GetNowFrame(_ARG_0_.stringHandle) >= 12 then
              Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.spoolHandle, 1)
              _ARG_0_.step2 = 1
              print("StringOfDeath_1\n")
            end
          elseif _ARG_0_.step2 == 1 and Effect.GetNowFrame(_ARG_0_.stringHandle) >= 55 then
            Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.spoolHandle, 0)
            _ARG_0_.step2 = 2
            print("StringOfDeath_2\n")
          end
          if Effect.GetNowFrame(_ARG_0_.stringHandle) > 55 and _ARG_0_.step == 1 then
            Entity.LoopEndEffectAttach(_ARG_0_.spoolHandle)
            _ARG_0_.step = 2
            print("StringOfDeath_3\n")
          end
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
          _ARG_0_.step = 3
          print("StringOfDeath_4\n")
        end
      elseif _ARG_0_.step == 3 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          print("StringOfDeath_5\n")
          _ARG_0_:ChangeState(_ARG_0_.stack:pop(1))
        end
      elseif _ARG_0_.step == 4 then
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
        Effect.KillEffect(_ARG_0_.stringHandle)
        _ARG_0_.workVec0:set(1, 0, 0)
        Entity.ApplyBoneMatrix(_ARG_0_.spoolHandle, "R_ude2_scl", _ARG_0_.workVec0)
        _ARG_0_.workVec1:set(0, 0, 0)
        _ARG_0_.string2Handle = Entity.SetEffect(_ARG_0_.spoolHandle, "b10sb00", "B003_SOD_03_0", _ARG_0_.workVec0, _ARG_0_.workVec1)
        _ARG_0_.captureHandle = Entity.AttachEffect(_ARG_0_.hitHandle, "b10sb00", "B003_SOD_01_0", "koshi")
        Effect.SetAttachNoRot(_ARG_0_.captureHandle, true)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE3_)
        print("StringOfDeath_6\n")
        _ARG_0_.step = 5
      elseif Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:ChangeState(_ARG_0_.stack:pop(1))
      end
    end
  },
  StringOfDeathSuccess = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Effect.KillEffect(_ARG_0_.stringHandle)
      _ARG_0_.workVec0:set(1, 0, 0)
      Entity.ApplyBoneMatrix(_ARG_0_.spoolHandle, "R_ude2_scl", _ARG_0_.workVec0)
      _ARG_0_.workVec1:set(0, 0, 0)
      _ARG_0_.string2Handle = Entity.SetEffect(_ARG_0_.spoolHandle, "b10sb00", "B003_SOD_03_0", _ARG_0_.workVec0, _ARG_0_.workVec1)
      _ARG_0_.captureHandle = Entity.AttachEffect(_ARG_0_.hitHandle, "b10sb00", "B003_SOD_01_0", "koshi")
      Effect.SetAttachNoRot(_ARG_0_.captureHandle, true)
      Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.myHandle, 0)
      Entity.GetWorldPos(_ARG_0_.workVec1, _ARG_0_.hitHandle, 0)
      _ARG_0_.workVec1:sety(_ARG_0_.workVec0:gety())
      Entity.SetLocalPos(_ARG_0_.hitHandle, _ARG_0_.workVec1)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.sodTimer = _UPVALUE2_
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_:IsTargetCapture(_ARG_0_.hitHandle) == false then
        _ARG_0_:ChangeState("ReleaseStringOfDeath")
        return
      end
      Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.myHandle)
      Entity.GetWorldPos(_ARG_0_.workVec1, _ARG_0_.hitHandle)
      FVECTOR3.Sub(_ARG_0_.workVec1, _ARG_0_.workVec1, _ARG_0_.workVec0)
      if _ARG_0_.workVec1:dot(_ARG_0_.workVec1) <= 25 then
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:ChangeState("MonsterScissors")
        end
        return
      end
      _ARG_0_.sodTimer = _ARG_0_.sodTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
      if _ARG_0_.sodTimer <= 0 then
        _ARG_0_.sodTimer = _UPVALUE0_
        Player.SetDamage(_ARG_0_.hitHandle, (Player.CalcDamagePoint(_ARG_0_.hitHandle, Enemy.GetAttackPoint(_ARG_0_.spoolHandle, 3), (Enemy.GetAttackPowerCorrection(_ARG_0_.spoolHandle, 3)))))
      end
      Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.spoolHandle, 5)
      Entity.GetWorldPos(_ARG_0_.workVec1, _ARG_0_.hitHandle, 2)
      FVECTOR3.Sub(_ARG_0_.workVec0, _ARG_0_.workVec0, _ARG_0_.workVec1)
      _ARG_0_.workVec0:sety(0)
      _ARG_0_.workVec0:normalize()
      _ARG_0_.workVec0:scale(_UPVALUE1_ * Entity.GetFrameRate(_ARG_0_.myHandle))
      Entity.GetWorldPos(_ARG_0_.workVec1, _ARG_0_.hitHandle, 0)
      FVECTOR3.Add(_ARG_0_.workVec1, _ARG_0_.workVec1, _ARG_0_.workVec0)
      _ARG_0_.workVec0:copy(_ARG_0_.workVec1)
      _ARG_0_.workVec0:sety(_ARG_0_.workVec0:gety() + 0.5)
      _ARG_0_.workVec1:sety(_ARG_0_.workVec1:gety() - 1)
      Collision.IntersectRayBg(_ARG_0_.workVec1, COLL_KIND_PLAYER, _ARG_0_.workVec0, _ARG_0_.workVec1)
      Entity.SetLocalPos(_ARG_0_.hitHandle, _ARG_0_.workVec1)
    end
  },
  StringOfDeathSuccess2 = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Effect.KillEffect(_ARG_0_.stringHandle)
      _ARG_0_.workVec0:set(1, 0, 0)
      Entity.ApplyBoneMatrix(_ARG_0_.spoolHandle, "R_ude2_scl", _ARG_0_.workVec0)
      _ARG_0_.workVec1:set(0, 0, 0)
      _ARG_0_.string2Handle = Entity.SetEffect(_ARG_0_.spoolHandle, "b10sb00", "B003_SOD_03_0", _ARG_0_.workVec0, _ARG_0_.workVec1)
      _ARG_0_.captureHandle = Entity.AttachEffect(_ARG_0_.hitHandle, "b10sb00", "B003_SOD_01_0", "koshi")
      Effect.SetAttachNoRot(_ARG_0_.captureHandle, true)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_:ReleaseStringOfDeath()
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:ChangeState(_ARG_0_.stack:pop(1))
      end
    end
  },
  ReleaseStringOfDeath = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_:ReleaseStringOfDeath()
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:ChangeState(_ARG_0_.stack:pop(1))
      end
    end
  },
  MonsterScissors = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_:EndStringOfDeath()
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 and _ARG_0_:IsTargetCapture(_ARG_0_.hitHandle) == false then
        _ARG_0_:ReleaseStringOfDeath()
        _ARG_0_.step = 1
      end
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:ChangeState(_ARG_0_.stack:pop(1))
      end
    end
  },
  Hysteria = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
    end,
    OnEndState = function(_ARG_0_)
      Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        if Entity.IsAttachCoord(_ARG_0_.wheelHandle) == false then
          _ARG_0_.stack:clear()
          _ARG_0_:ChangeState("WheelWait")
        else
          _ARG_0_:ChangeState("Idling")
        end
      end
    end
  },
  Damage = {
    OnBeginState = function(_ARG_0_)
      if Enemy.IsAttackerFront(_ARG_0_.myHandle) then
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      else
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
      end
      Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.myHandle, 2)
      Enemy.MakePrize(_ARG_0_.myHandle, _ARG_0_.workVec0)
      _ARG_0_.damageCount = 0
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 then
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          if Entity.GetCurrentMotion(_ARG_0_.myHandle) == _UPVALUE1_ then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
          else
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
          end
          _ARG_0_.step = 2
        end
      elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:OnReturnDamage()
      end
    end
  },
  Dead = {
    OnBeginState = function(_ARG_0_)
      if Entity.GetName(_ARG_0_.myHandle) == "b50vs00" then
        Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 60)
        Entity.SetupModelFade(_ARG_0_.wheelHandle, 1, 0, 60)
        Entity.SetupModelFade(_ARG_0_.spoolHandle, 1, 0, 60)
        _ARG_0_:EndStringOfDeath()
        _ARG_0_.step = 0
      else
        _ARG_0_.step = 100
      end
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 and Entity.IsModelFade(_ARG_0_.myHandle) == false then
        Enemy.Dead(_ARG_0_.myHandle)
      end
    end
  }
}
function b10sb00.Rotation(_ARG_0_, _ARG_1_)
  if Entity.GetMotionNowFrame(_ARG_0_.myHandle) - Entity.GetMotionOldFrame(_ARG_0_.myHandle) < 0 then
  else
  end
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  _ARG_0_.rot:sety(RoundPI(_ARG_0_.rot:gety() + DegToRad((Entity.GetMotionNowFrame(_ARG_0_.myHandle) - Entity.GetMotionOldFrame(_ARG_0_.myHandle)) * (90 / Entity.GetMotionTotalFrame(_ARG_0_.myHandle))) * _ARG_1_))
  Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
  return DegToRad((Entity.GetMotionNowFrame(_ARG_0_.myHandle) - Entity.GetMotionOldFrame(_ARG_0_.myHandle)) * (90 / Entity.GetMotionTotalFrame(_ARG_0_.myHandle))) * _ARG_1_
end
function b10sb00.IsAliveArms(_ARG_0_)
  if Entity.IsAlive(_ARG_0_.wheelHandle) == false and Entity.IsAlive(_ARG_0_.spoolHandle) == false then
    return false
  end
  return true
end
function b10sb00.IsDestroyArms(_ARG_0_)
  if _ARG_0_.wheelHandle ~= NULL_HANDLE and Entity.IsAlive(_ARG_0_.wheelHandle) == false then
    _ARG_0_.wheelHandle = NULL_HANDLE
    return true
  end
  if _ARG_0_.spoolHandle ~= NULL_HANDLE and Entity.IsAlive(_ARG_0_.spoolHandle) == false then
    _ARG_0_.spoolHandle = NULL_HANDLE
    return true
  end
  if _ARG_0_.restHpRateCheck == false and _ARG_0_:RestHpRate() < _UPVALUE0_ then
    _ARG_0_.restHpRateCheck = true
    return true
  end
  return false
end
function b10sb00.RestHpRate(_ARG_0_)
  return Enemy.GetHp(_ARG_0_.myHandle) / Enemy.GetHpMax(_ARG_0_.myHandle)
end
function b10sb00.ChangeState(_ARG_0_, _ARG_1_)
  if _ARG_1_ == "JumpAttack2" and Entity.IsAlive(_ARG_0_.wheelHandle) == false then
    _ARG_0_:GotoState("JumpAttack")
    return
  end
  if _ARG_1_ ~= nil then
    _ARG_0_:GotoState(_ARG_1_)
  else
    _ARG_0_:GotoState("Idling")
  end
end
function b10sb00.IsTargetCapture(_ARG_0_, _ARG_1_)
  return Player.IsDamageFlagCapture(_ARG_1_)
end
function b10sb00.EndStringOfDeath(_ARG_0_)
  if Player.GetNetworkID(_ARG_0_.hitHandle) <= 0 and Player.IsDamageFlagCapture(_ARG_0_.hitHandle) then
    Player.SetTrgFlagCancel(_ARG_0_.hitHandle, 1)
  end
  Effect.KillEffect(_ARG_0_.string2Handle)
  Effect.KillEffect(_ARG_0_.captureHandle)
  Entity.LoopEndEffectAttach(_ARG_0_.spoolHandle)
  _ARG_0_.string2Handle = NULL_HANDLE
  _ARG_0_.captureHandle = NULL_HANDLE
  _ARG_0_.hitHandle = NULL_HANDLE
end
function b10sb00.ReleaseStringOfDeath(_ARG_0_)
  Effect.KillEffect(_ARG_0_.string2Handle)
  Effect.KillEffect(_ARG_0_.captureHandle)
  Entity.LoopEndEffectAttach(_ARG_0_.spoolHandle)
  Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.hitHandle, 2)
  _ARG_0_.workVec0:sety(_ARG_0_.workVec0:gety() - 0.25)
  Entity.SetEffect(_ARG_0_.hitHandle, "b10sb00", "B003_SOD_02_0", _ARG_0_.workVec0)
  _ARG_0_.string2Handle = NULL_HANDLE
  _ARG_0_.captureHandle = NULL_HANDLE
  _ARG_0_.hitHandle = NULL_HANDLE
end
function b10sb00.SetNetworkMaster(_ARG_0_, _ARG_1_)
  Enemy.SetNetworkMaster(_ARG_0_.myHandle, _ARG_1_)
  Enemy.SetNetworkMaster(_ARG_0_.spoolHandle, _ARG_1_)
  Enemy.SetNetworkMaster(_ARG_0_.wheelHandle, _ARG_1_)
end
function b10sb00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  Entity.EnableGravity(_ARG_0_.myHandle, 1)
  Entity.SetMovementCollRadius(_ARG_0_.myHandle, 3)
  Entity.SetLowerHalf(_ARG_0_.myHandle, 3.5)
  Entity.SetDropShadowDistance(_ARG_0_.myHandle, 15)
  _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec0 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec2 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec3 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.cameraTargetPos = FVECTOR3.new(0, 0, 0)
  if Entity.GetName(_ARG_1_) == "b10sb00" then
    _ARG_0_.spoolHandle = Entity.CreateEntity("b11sb00", _ARG_0_.workVec0, _ARG_0_.workVec0, _ARG_1_)
    Entity.AttachCoord(_ARG_1_, "X_ctl_ude2", _ARG_0_.spoolHandle, "Root")
    _ARG_0_.wheelHandle = Entity.CreateEntity("b12sb00", _ARG_0_.workVec0, _ARG_0_.workVec0, _ARG_1_)
    Entity.AttachCoord(_ARG_1_, "X_ctl_wheel", _ARG_0_.wheelHandle, "Root")
  else
    _ARG_0_.spoolHandle = Entity.CreateEntity("b51vs00", _ARG_0_.workVec0, _ARG_0_.workVec0, _ARG_1_)
    Entity.AttachCoord(_ARG_1_, "X_ctl_ude2", _ARG_0_.spoolHandle, "Root")
    _ARG_0_.wheelHandle = Entity.CreateEntity("b52vs00", _ARG_0_.workVec0, _ARG_0_.workVec0, _ARG_1_)
    Entity.AttachCoord(_ARG_1_, "X_ctl_wheel", _ARG_0_.wheelHandle, "Root")
  end
  _ARG_0_.step = 0
  _ARG_0_.step2 = 0
  _ARG_0_.targetHandle = NULL_HANDLE
  _ARG_0_.targetHandle2 = NULL_HANDLE
  _ARG_0_.count = 0
  _ARG_0_.flag = 0
  _ARG_0_.restHpRateCheck = false
  _ARG_0_.stringHandle = NULL_HANDLE
  _ARG_0_.string2Handle = NULL_HANDLE
  _ARG_0_.captureHandle = NULL_HANDLE
  _ARG_0_.stringScale = 0
  _ARG_0_.damageCount = 0
  _ARG_0_.sodTimer = 0
  _ARG_0_.hitHandle = NULL_HANDLE
  _ARG_0_.stack = Stack:Create()
  Enemy.SetViewDist(_ARG_1_, 50)
  Player.SetBossCamera("b10sb")
  _UPVALUE0_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "Action1Dist")
  _UPVALUE1_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "Action2Dist")
  _UPVALUE2_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "RndAtk2") / 100
  _UPVALUE3_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "SODDSpeed")
  _UPVALUE4_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "RestHp") / 100
  _UPVALUE5_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "WheelSpeed")
  _UPVALUE6_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "MSWaitTime") * 60
  _UPVALUE7_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "DmgCnt")
  _UPVALUE0_ = _UPVALUE0_ * _UPVALUE0_
  _UPVALUE1_ = _UPVALUE1_ * _UPVALUE1_
  _UPVALUE8_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "DmgTime") * 60
  if Enemy.IsAllEnemyWaiting() == true then
    if Entity.GetName(_ARG_1_) == "b50vs00" then
      _ARG_0_:GotoState("AppearArena")
    else
      _ARG_0_:GotoState("Appear")
    end
  else
    _ARG_0_:GotoState("Idling")
  end
end
function b10sb00.OnDestroy(_ARG_0_)
  _ARG_0_:EndStringOfDeath()
end
function b10sb00.OnSetMotion(_ARG_0_, _ARG_1_)
  Entity.SetMotion(_ARG_0_.spoolHandle, _ARG_1_)
  if Effect.IsAlive(_ARG_0_.string2Handle) and (_ARG_1_ == _UPVALUE0_ or _ARG_1_ == _UPVALUE1_) then
    Effect.KillEffect(_ARG_0_.string2Handle)
    Effect.KillEffect(_ARG_0_.captureHandle)
    Entity.LoopEndEffectAttach(_ARG_0_.spoolHandle)
  end
end
function b10sb00.OnReturnDamage(_ARG_0_)
  _ARG_0_.stack:clear()
  _ARG_0_:EndStringOfDeath()
  if Entity.IsAttachCoord(_ARG_0_.wheelHandle) == false then
    _ARG_0_:ChangeState("WheelWait")
  else
    _ARG_0_:ChangeState("Idling")
  end
end
function b10sb00.OnHitAttack(_ARG_0_, _ARG_1_, _ARG_2_)
  if Entity.GetCurrentMotion(_ARG_0_.myHandle) == _UPVALUE0_ then
    _ARG_0_.flag = 1
  end
end
function b10sb00.CanDamageCount(_ARG_0_, _ARG_1_)
  if Entity.GetDamagePoint(_ARG_0_.myHandle) <= 0 then
    return false
  end
  if _ARG_1_ == ATK_KIND_MAGNET_MUNNY or _ARG_1_ == ATK_KIND_MAGNET_HP or _ARG_1_ == ATK_KIND_MAGNET_FOCUS or _ARG_1_ == ATK_KIND_MAGNESPIRAL then
    return false
  end
  return true
end
function b10sb00.OnDamage(_ARG_0_, _ARG_1_, _ARG_2_)
  if _ARG_0_:GetState() ~= "Damage" and _ARG_0_:GetState() ~= "StringOfDeath" and _ARG_0_:GetState() ~= "StringOfDeathSuccess" and _ARG_0_:CanDamageCount(_ARG_1_) then
    _ARG_0_.damageCount = _ARG_0_.damageCount + 1
    if _ARG_0_.damageCount >= _UPVALUE0_ then
      _ARG_0_:GotoState("Damage")
    end
  end
  return 1
end
function b10sb00.OnDead(_ARG_0_)
  SetupBossDead(_ARG_0_.myHandle)
  Entity.EnableDamageColl(_ARG_0_.spoolHandle, 0)
  Entity.EnableDamageColl(_ARG_0_.wheelHandle, 0)
  Entity.EnableLockonAndShooton(_ARG_0_.spoolHandle, 0)
  Entity.EnableLockonAndShooton(_ARG_0_.wheelHandle, 0)
  if Enemy.IsAttackerFront(_ARG_0_.myHandle) then
    Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
  else
    Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
  end
  _ARG_0_:ChangeState("Dead")
  return 1
end
function b10sb00.OnUpdate(_ARG_0_)
  _ARG_0_:Update()
  _ARG_0_:Debug()
  if _ARG_0_:GetState() ~= "Hysteria" and _ARG_0_:GetState() ~= "Dead" and Entity.IsGround(_ARG_0_.myHandle) and _ARG_0_:IsDestroyArms() then
    _ARG_0_:EndStringOfDeath()
    _ARG_0_:ChangeState("Hysteria")
  end
  Entity.GetWorldPos(_ARG_0_.cameraTargetPos, _ARG_0_.myHandle)
  _ARG_0_.cameraTargetPos:sety(2)
end
function b10sb00.GetCameraTargetPos(_ARG_0_)
  return _ARG_0_.cameraTargetPos
end
function b10sb00.Debug(_ARG_0_)
  if Script.IsDebugCheckAttack() then
    for _FORV_5_, _FORV_6_ in pairs(_UPVALUE0_) do
      if _FORV_6_ == _ARG_0_:GetState() then
        return
      end
    end
    if _UPVALUE0_[Script.GetDebugAttackNumber() + 1] ~= nil then
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      _ARG_0_:ChangeState(_UPVALUE0_[Script.GetDebugAttackNumber() + 1])
    end
  end
end
EntityFactory:Add("b10sb00", function(_ARG_0_)
  return (b10sb00:new())
end)
EntityFactory:Add("b50vs00", function(_ARG_0_)
  return (b10sb00:new())
end)
