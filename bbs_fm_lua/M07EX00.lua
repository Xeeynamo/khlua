m07ex00 = {}
m07ex00_base_mt = {__index = __StateMachine}
setmetatable(m07ex00, m07ex00_base_mt)
m07ex00_mt = {__index = m07ex00}
function m07ex00.new(_ARG_0_)
  return setmetatable(__StateMachine:new(), m07ex00_mt)
end
m07ex00.states = {
  Appear = {
    OnBeginState = function(_ARG_0_)
      SetupAppearBegin(_ARG_0_.myHandle, 1, _UPVALUE0_, 0)
      _ARG_0_.step = 0
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
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetTimer(_ARG_0_.myHandle, Entity.GetMotionTotalFrame(_ARG_0_.myHandle) * 2 + Script.Random() * 80)
      _ARG_0_.step = 0
      Entity.EnableGravity(_ARG_0_.myHandle, 0)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      _ARG_0_.targetStompar = NULL_HANDLE
      _ARG_0_.TowsteppeFlag = 1
    end,
    OnEndState = function(_ARG_0_)
      Entity.EnableGravity(_ARG_0_.myHandle, 1)
      _ARG_0_.TowsteppeFlag = 0
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.CanUserTarget(_ARG_0_.targetHandle) == true then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 20)
        if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE0_ and _ARG_0_.AttackCnt > 0 then
          if Script.Random() < _UPVALUE1_ then
            _ARG_0_:GotoState("Kick")
            return
          else
            _ARG_0_:GotoState("Trampling")
            return
          end
        end
      else
        _ARG_0_.AttackCnt = 0
      end
      if Entity.IsTimeOver(_ARG_0_.myHandle) and _ARG_0_.step == 0 then
        if Script.Random() < _UPVALUE2_ then
          _ARG_0_:GotoState("Guard")
          return
        end
        if Entity.CanUserTarget(_ARG_0_.targetHandle) == false then
          _ARG_0_:GotoState("Wander")
          return
        end
        _ARG_0_:GotoState("Move")
      end
    end
  },
  Move = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_ + Script.Random() * _UPVALUE1_)
      _ARG_0_.step = 0
      _ARG_0_.TowsteppeFlag = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      _ARG_0_.TowsteppeFlag = 0
      Entity.EnableGravity(_ARG_0_.myHandle, 1)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsTimeOver(_ARG_0_.myHandle) and Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
        return
      end
      if _ARG_0_.step == 0 then
        if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE0_ then
          _ARG_0_.AttackCnt = Script.Random() * (_UPVALUE1_ - 1) + 1
          if Script.Random() < _UPVALUE2_ then
            _ARG_0_:GotoState("Kick")
            return
          else
            _ARG_0_:GotoState("Trampling")
            return
          end
        elseif Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE3_ then
          if Script.Random() < _UPVALUE4_ then
            _ARG_0_.step = 1
          else
            _ARG_0_.step = 2
            Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 360)
            _ARG_0_:Rotation(DegToRad(180))
            _ARG_0_.WorkTime = _UPVALUE5_
            return
          end
        elseif Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE6_ then
          _ARG_0_:GotoState("RushAttack")
          return
        elseif CanDisappear(_ARG_0_.myHandle, _ARG_0_.targetHandle) == true then
          _ARG_0_:GotoState("Disappear")
          return
        end
      elseif _ARG_0_.step == 1 then
        if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE0_ then
          _ARG_0_.AttackCnt = Script.Random() * (_UPVALUE1_ - 1) + 1
          if Script.Random() < _UPVALUE2_ then
            _ARG_0_:GotoState("Kick")
            return
          else
            _ARG_0_:GotoState("Trampling")
            return
          end
        end
      elseif _ARG_0_.step == 2 then
        if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _UPVALUE3_ then
          _ARG_0_:GotoState("RushAttack")
          return
        end
        if 0 > _ARG_0_.WorkTime then
          _ARG_0_:GotoState("RushAttack")
          return
        end
        _ARG_0_.velocity:set(0, 0, _UPVALUE7_)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
        _ARG_0_.WorkTime = _ARG_0_.WorkTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        return
      end
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, _UPVALUE8_)
      _ARG_0_.velocity:set(0, 0, _UPVALUE7_)
      Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
    end
  },
  Wander = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = _UPVALUE1_
      _ARG_0_.count = 0
      _ARG_0_.WanderCnt = Script.Random() * 3 + 3
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.HasNetGameHandle(_ARG_0_.myHandle) and Enemy.IsNetworkMaster(_ARG_0_.myHandle) == false then
        return
      end
      if _ARG_0_.step == _UPVALUE0_ then
        if Enemy.GetTimeTargetHasBeenVisible(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 180 then
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
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 5)
        _ARG_0_.MoveFlag = M02EX_MOVETYPE_HOMING
        if CanDisappear(_ARG_0_.myHandle, _ARG_0_.targetHandle) == true then
          _ARG_0_:GotoState("Disappear")
          return
        end
        _ARG_0_.velocity:set(0, 0, _UPVALUE4_)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
        _ARG_0_.noWallHitTime = _ARG_0_.noWallHitTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.noWallHitTime < 0 then
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.IsWall(_ARG_0_.myHandle) == true or 1 > Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetPos) then
          _ARG_0_.count = _ARG_0_.count + 1
          if _ARG_0_.count > _ARG_0_.WanderCnt then
            _ARG_0_:GotoState("Idling")
          else
            _ARG_0_.step = _UPVALUE0_
          end
        end
      end
    end
  },
  Guard = {
    OnBeginState = function(_ARG_0_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
      _ARG_0_.GuardFlag = 1
      Entity.EnableGuard(_ARG_0_.myHandle, 1)
      Entity.EnableGuardPhysical(_ARG_0_.myHandle, 1)
      Entity.EnableGuardZero(_ARG_0_.myHandle, 1)
      Entity.EnableGuardFire(_ARG_0_.myHandle, 1)
      Entity.EnableGuardIce(_ARG_0_.myHandle, 1)
      Entity.EnableGuardDark(_ARG_0_.myHandle, 1)
      Entity.EnableGuardThunder(_ARG_0_.myHandle, 1)
      Entity.SetGuardDir(_ARG_0_.myHandle, 360)
      Entity.EnableGuardSpecial(_ARG_0_.myHandle, 1)
      _ARG_0_.AttackCnt = 0
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.TowsteppeFlag = 0
      Entity.ClearSpeed(_ARG_0_.myHandle)
      Entity.EnableGravity(_ARG_0_.myHandle, 1)
    end,
    OnEndState = function(_ARG_0_)
      Entity.EnableGuard(_ARG_0_.myHandle, 0)
      Entity.EnableGuardPhysical(_ARG_0_.myHandle, 0)
      Entity.EnableGuardZero(_ARG_0_.myHandle, 0)
      Entity.EnableGuardZeroEx(_ARG_0_.myHandle, 0)
      Entity.EnableGuardFire(_ARG_0_.myHandle, 0)
      Entity.EnableGuardIce(_ARG_0_.myHandle, 0)
      Entity.EnableGuardDark(_ARG_0_.myHandle, 0)
      Entity.EnableGuardThunder(_ARG_0_.myHandle, 0)
      Entity.SetGuardDir(_ARG_0_.myHandle, 0)
      Entity.EnableGuardSpecial(_ARG_0_.myHandle, 0)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_.step = 1
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        end
      elseif _ARG_0_.step == 1 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= _UPVALUE1_ / 2 then
          Entity.EnableGuard(_ARG_0_.myHandle, 0)
          Entity.EnableGuardPhysical(_ARG_0_.myHandle, 0)
          Entity.EnableGuardZero(_ARG_0_.myHandle, 0)
          Entity.EnableGuardZeroEx(_ARG_0_.myHandle, 0)
          Entity.EnableGuardFire(_ARG_0_.myHandle, 0)
          Entity.EnableGuardIce(_ARG_0_.myHandle, 0)
          Entity.EnableGuardDark(_ARG_0_.myHandle, 0)
          Entity.EnableGuardThunder(_ARG_0_.myHandle, 0)
          Entity.SetGuardDir(_ARG_0_.myHandle, 0)
          Entity.EnableGuardSpecial(_ARG_0_.myHandle, 0)
          _ARG_0_.GuardFlag = 0
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.step = 2
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE2_)
          _ARG_0_.TowsteppeFlag = 1
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE3_ + Script.Random() * 25)
        end
      elseif _ARG_0_.step == 2 then
        if Entity.CanUserTarget(_ARG_0_.targetHandle) == false then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 20)
        end
        Entity.EnableGravity(_ARG_0_.myHandle, 0)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
      end
    end
  },
  Kick = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.step = 0
      _ARG_0_.AttackCnt = _ARG_0_.AttackCnt - 1
      _ARG_0_.TowsteppeFlag = 0
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      Entity.SetTimer(_ARG_0_.myHandle, 60)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 1 then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
          _ARG_0_.step = 1
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, _UPVALUE1_)
        _ARG_0_.velocity:set(0, 0, _UPVALUE2_)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_.step = 1
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        end
      elseif _ARG_0_.step == 1 then
        Entity.ClearSpeed(_ARG_0_.myHandle)
        if Entity.CanUserTarget(_ARG_0_.targetHandle) == false then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
      end
    end
  },
  Trampling = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.JumpPow = _UPVALUE1_
      _ARG_0_.Gravity = _UPVALUE2_
      _ARG_0_.step = 0
      _ARG_0_.TramplingFlag = 1
      _ARG_0_.TramplingCnt = 0
      _ARG_0_.AttackFlag = 0
      _ARG_0_.AttackCnt = _ARG_0_.AttackCnt - 1
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      _ARG_0_.TowsteppeFlag = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      _ARG_0_.TramplingFlag = 0
      _ARG_0_.AttackFlag = 0
      Entity.EnableGravity(_ARG_0_.myHandle, 1)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) < _UPVALUE0_ then
          return
        end
        _ARG_0_.velocity:sety(_ARG_0_.JumpPow)
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
        _ARG_0_.JumpPow = _ARG_0_.JumpPow - _ARG_0_.Gravity * Entity.GetFrameRate(_ARG_0_.myHandle)
        if 0 > _ARG_0_.JumpPow then
          _ARG_0_.step = 1
          _ARG_0_.WorkTime = 13
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE1_)
          Entity.ClearSpeed(_ARG_0_.myHandle)
          Entity.EnableGravity(_ARG_0_.myHandle, 0)
          return
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 30)
        _ARG_0_.velocity:set(0, 0, Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) / 64)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
      elseif _ARG_0_.step == 1 then
        if 0 > _ARG_0_.WorkTime then
          Entity.EnableGravity(_ARG_0_.myHandle, 1)
          _ARG_0_.velocity:sety(_ARG_0_.JumpPow)
          Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
          _ARG_0_.JumpPow = _ARG_0_.JumpPow - _ARG_0_.Gravity * Entity.GetFrameRate(_ARG_0_.myHandle)
        end
        _ARG_0_.WorkTime = _ARG_0_.WorkTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if Entity.IsGround(_ARG_0_.myHandle) then
          if _ARG_0_.TramplingCnt == 0 then
            _ARG_0_.TramplingCnt = _ARG_0_.TramplingCnt + 1
            _ARG_0_.JumpPow = _UPVALUE2_
            _ARG_0_.step = 5
            Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE3_)
            return
          else
            _ARG_0_.step = 2
            _ARG_0_.TramplingCnt = _ARG_0_.TramplingCnt + 1
            Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE4_)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            return
          end
        end
        if _ARG_0_.AttackFlag == 1 then
          _ARG_0_.JumpPow = _UPVALUE5_
          _ARG_0_.step = 4
          _ARG_0_.TramplingCnt = _ARG_0_.TramplingCnt + 1
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE3_)
          Entity.ClearSpeed(_ARG_0_.myHandle)
          return
        end
        if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 1 then
          _ARG_0_.velocity:set(0, 0, 0.02)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
        else
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 30)
          _ARG_0_.velocity:set(0, 0, Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) / 64)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
        end
      elseif _ARG_0_.step == 2 then
        if _ARG_0_.TramplingCnt >= 2 then
          _ARG_0_.step = 3
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.JumpPow = _UPVALUE2_
          _ARG_0_.step = 0
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        end
      elseif _ARG_0_.step == 3 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
      elseif _ARG_0_.step == 4 then
        _ARG_0_.velocity:sety(_ARG_0_.JumpPow)
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
        _ARG_0_.JumpPow = _ARG_0_.JumpPow - _ARG_0_.Gravity * Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.TramplingCnt >= 2 then
          _ARG_0_.AttackFlag = 0
          _ARG_0_.velocity:set(0, 0.02, 0.02)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
          if Entity.IsGround(_ARG_0_.myHandle) then
            _ARG_0_.step = 3
            _ARG_0_.TramplingCnt = _ARG_0_.TramplingCnt + 1
            Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE4_)
          end
        else
          if 0 > _ARG_0_.JumpPow then
            _ARG_0_.step = 1
            _ARG_0_.WorkTime = 13
            Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE1_)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Entity.EnableGravity(_ARG_0_.myHandle, 0)
            _ARG_0_.AttackFlag = 0
            return
          end
          if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 1 then
            _ARG_0_.velocity:set(0, 0, 0.02)
            Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
          else
            Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 30)
            _ARG_0_.velocity:set(0, 0, Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) / 64)
            Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
          end
        end
      elseif _ARG_0_.step == 5 then
        _ARG_0_.step = 6
      elseif _ARG_0_.step == 6 then
        _ARG_0_.velocity:sety(_ARG_0_.JumpPow)
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
        _ARG_0_.JumpPow = _ARG_0_.JumpPow - _ARG_0_.Gravity * Entity.GetFrameRate(_ARG_0_.myHandle)
        if 0 > _ARG_0_.JumpPow then
          _ARG_0_.step = 1
          _ARG_0_.WorkTime = 13
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE1_)
          Entity.ClearSpeed(_ARG_0_.myHandle)
          Entity.EnableGravity(_ARG_0_.myHandle, 0)
          _ARG_0_.AttackFlag = 0
          return
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 30)
        _ARG_0_.velocity:set(0, 0, Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) / 364)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
      end
    end
  },
  RushAttack = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.targetStompar = NULL_HANDLE
      _ARG_0_.targetStompar = Enemy.SearchEnemy(_ARG_0_.myHandle, "m07ex00", SEARCH_TYPE_NEAR)
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 360)
      if _ARG_0_.targetStompar == NULL_HANDLE then
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        _ARG_0_.step = 3
        _ARG_0_.RushFlag = 0
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        _ARG_0_.TowsteppeFlag = 0
      else
        if Entity.IsAlive(_ARG_0_.targetStompar) == false then
          _ARG_0_:GotoState("Idling")
          _ARG_0_.targetStompar = NULL_HANDLE
          return true
        end
        if EntityManager:GetEntity(_ARG_0_.targetStompar).TowsteppeFlag == 1 then
          EntityManager:GetEntity(_ARG_0_.targetStompar).targetStompar = _ARG_0_.myHandle
          EntityManager:GetEntity(_ARG_0_.targetStompar):GotoState("ItGathers")
          Entity.SetTimer(_ARG_0_.myHandle, 240)
          _ARG_0_.step = 0
          _ARG_0_.RushFlag = 1
          if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetStompar) < _UPVALUE2_ then
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_ * 50)
            Entity.EnableGravity(_ARG_0_.myHandle, 1)
            Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE3_)
            _ARG_0_.step = 1
          end
        else
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
          _ARG_0_.step = 3
          _ARG_0_.RushFlag = 0
        end
      end
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      Entity.EnableGravity(_ARG_0_.myHandle, 1)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.IsAlive(_ARG_0_.targetStompar) == false then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
          _ARG_0_.step = 1
          return
        end
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 6)
        if EntityManager:GetEntity(_ARG_0_.targetStompar).step == 1 then
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
          Entity.EnableGravity(_ARG_0_.myHandle, 1)
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE2_)
          _ARG_0_.step = 1
        end
        if EntityManager:GetEntity(_ARG_0_.targetStompar).step == 99 then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
          _ARG_0_.step = 1
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
          _ARG_0_.step = 1
          _ARG_0_.RushFlag = 0
        end
      elseif _ARG_0_.step == 1 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.step = 2
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_ + Script.Random() * 25)
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE3_)
          _ARG_0_.TowsteppeFlag = 1
          _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        end
      elseif _ARG_0_.step == 2 then
        Entity.EnableGravity(_ARG_0_.myHandle, 0)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        if Entity.CanUserTarget(_ARG_0_.targetHandle) == false then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 20)
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          if _ARG_0_.RushFlag == 1 then
            EntityManager:GetEntity(_ARG_0_.targetStompar):GotoState("Idling")
          end
          _ARG_0_:GotoState("Idling")
        end
        return
      elseif _ARG_0_.step == 3 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE3_)
        _ARG_0_.TowsteppeFlag = 1
        _ARG_0_.step = 2
      end
    end
  },
  ItGathers = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
      _ARG_0_.Standstill = 0
      Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 0.5)
      Entity.EnableGravity(_ARG_0_.myHandle, 1)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      _ARG_0_.TowsteppeFlag = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      Entity.EnableGravity(_ARG_0_.myHandle, 1)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsAlive(_ARG_0_.targetStompar) == false then
        _ARG_0_:GotoState("Idling")
        _ARG_0_.targetStompar = NULL_HANDLE
        return true
      end
      if _ARG_0_.step == 0 then
        if _ARG_0_:WhichRightandLeft() == 1 then
          _ARG_0_.WorkVec:set(1, 0, 0)
        else
          _ARG_0_.WorkVec:set(-1, 0, 0)
        end
        Entity.GetWorldPos2(_ARG_0_.WorkVec1, _ARG_0_.targetStompar, _ARG_0_.WorkVec)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.WorkVec1, 6)
        if 1 > Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.WorkVec1) then
          _ARG_0_.velocity:set(0, 0, Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.WorkVec1) / 20)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
        else
          _ARG_0_.velocity:set(0, 0, _UPVALUE0_)
        end
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
        if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.WorkVec1) < _UPVALUE1_ then
          _ARG_0_.step = 5
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE2_)
          Entity.ClearSpeed(_ARG_0_.myHandle)
        end
      elseif _ARG_0_.step == 1 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > _UPVALUE3_ then
          Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE4_ + 10)
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE5_)
          _ARG_0_.TowsteppeFlag = 1
          _ARG_0_.step = 4
        end
      elseif _ARG_0_.step == 2 then
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_.WorkVec:set(1, 0, 0)
          Entity.GetWorldPos2(_ARG_0_.WorkVec1, _ARG_0_.targetStompar, _ARG_0_.WorkVec)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.WorkVec1, 360)
          _ARG_0_.step = 1
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE6_)
        end
      elseif _ARG_0_.step == 3 then
        _ARG_0_.step = 2
        Entity.SetTimer(_ARG_0_.myHandle, 17)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      elseif _ARG_0_.step == 4 then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 20)
        Entity.EnableGravity(_ARG_0_.myHandle, 0)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      elseif _ARG_0_.step == 5 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 40 then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE6_)
          _ARG_0_.step = 6
        end
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) == 20 then
          Entity.SetMotionWithSameCheck(_ARG_0_.targetStompar, _UPVALUE2_)
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 6)
      elseif _ARG_0_.step == 6 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) > _UPVALUE7_ then
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 0.5)
        _ARG_0_.step = 1
      end
    end
  },
  Standby = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.EnableGravity(_ARG_0_.myHandle, 0)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Enemy.IsAllEnemyWaiting() == false then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Disappear = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.EnableGravity(_ARG_0_.myHandle, 0)
      SetupDisappear(_ARG_0_.myHandle, 20)
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
function m07ex00.WhichRightandLeft(_ARG_0_)
  Entity.GetWorldPos(_ARG_0_.WorkVec1, _ARG_0_.targetHandle)
  Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.myHandle)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.WorkVec1, _ARG_0_.WorkVec)
  FVECTOR3.normalize(_ARG_0_.workVec)
  if RoundPI((Math.Atan2(_ARG_0_.workVec:getx(), _ARG_0_.workVec:getz()) - _ARG_0_.rot:gety()) * -1) < 0 then
    return 1
  else
    return 0
  end
end
function m07ex00.Rotation(_ARG_0_, _ARG_1_)
  Entity.GetRot(_ARG_0_.WorkVec, _ARG_0_.myHandle)
  _ARG_0_.WorkVec:set(0, _ARG_0_.WorkVec:gety() + _ARG_1_, 0)
  Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function m07ex00.OnItGathers(_ARG_0_, _ARG_1_)
end
function m07ex00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.targetHandle = NULL_HANDLE
  _ARG_0_.targetStompar = NULL_HANDLE
  _ARG_0_.MoveFlag = 0
  _ARG_0_.DamageCnt = 0
  _ARG_0_.GuardFlag = 0
  _ARG_0_.RushFlag = 0
  _ARG_0_.TramplingFlag = 0
  _ARG_0_.TramplingCnt = 0
  _ARG_0_.AttackFlag = 0
  _ARG_0_.AttackCnt = 0
  _ARG_0_.JumpPow = 0
  _ARG_0_.Gravity = 0
  _ARG_0_.Standstill = 0
  _ARG_0_.TowsteppeFlag = 0
  _ARG_0_.noWallHitTim = 0
  _ARG_0_.WanderCnt = 0
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkTime = 0
  _ARG_0_.WorkVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
  _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.cameraPos = FVECTOR3.new(0, 0, 0)
  if _UPVALUE0_ == false then
    _UPVALUE1_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "GuardRate") * 0.01
    _UPVALUE2_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "IGuradRate") * 0.01
    _UPVALUE3_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "GuardCnt")
    _UPVALUE4_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "GuardTime") * 60
    _UPVALUE5_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "GuardWait") * 60
    _UPVALUE6_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "Attack1Wait") * 60
    _UPVALUE7_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "RushWait") * 60
    _UPVALUE8_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "GuardFlag")
    _UPVALUE9_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "GuardHP") * 0.01
    _UPVALUE10_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "Action1Dist") * Enemy.GetExtraParam(_ARG_0_.myHandle, "Action1Dist")
    _UPVALUE11_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "Action2Dist") * Enemy.GetExtraParam(_ARG_0_.myHandle, "Action2Dist")
    _UPVALUE12_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "Action3Dist") * Enemy.GetExtraParam(_ARG_0_.myHandle, "Action3Dist")
    _UPVALUE13_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "MaxAttack")
    _UPVALUE14_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "ApproachR")
    _UPVALUE0_ = true
  end
  Entity.SetMovementCollRadius(_ARG_0_.myHandle, 0.6)
  Entity.SetLowerHalf(_ARG_0_.myHandle, 1)
  Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
  Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
  Entity.EnableLockon(_ARG_0_.myHandle, 1)
  Entity.EnableGravity(_ARG_0_.myHandle, 1)
  Entity.SetLockOnBoneNum(_ARG_0_.myHandle, 4)
  if Enemy.IsAllEnemyWaiting() == true then
    _ARG_0_:GotoState("Standby")
  else
    _ARG_0_:GotoState("Appear")
  end
end
function m07ex00.OnMessage(_ARG_0_, _ARG_1_)
  if _ARG_1_ == 1 then
    _ARG_0_:GotoState("ItGathers")
  end
end
function m07ex00.OnDamage(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  print("kind = " .. _ARG_1_ .. "\n")
  print("category = " .. _ARG_2_ .. "\n")
  print("att = " .. _ARG_3_ .. "\n")
  if _ARG_1_ == ATK_KIND_SLEEP or _ARG_3_ == ATK_ATTR_ZERO or _ARG_1_ == ATK_KIND_FAINT or _ARG_1_ == ATK_KIND_MAGNET or _ARG_1_ == ATK_KIND_ZEROGRAVITY or _ARG_1_ == ATK_KIND_MINIMUM or _ARG_1_ == ATK_KIND_MAGNEBREAKER then
    Entity.EnableGuard(_ARG_0_.myHandle, 0)
    Entity.EnableGuardPhysical(_ARG_0_.myHandle, 0)
    Entity.EnableGuardZero(_ARG_0_.myHandle, 0)
    Entity.EnableGuardZeroEx(_ARG_0_.myHandle, 0)
    Entity.EnableGuardFire(_ARG_0_.myHandle, 0)
    Entity.EnableGuardIce(_ARG_0_.myHandle, 0)
    Entity.EnableGuardThunder(_ARG_0_.myHandle, 0)
    Entity.SetGuardDir(_ARG_0_.myHandle, 0)
    Entity.EnableGuardSpecial(_ARG_0_.myHandle, 0)
  end
  if Enemy.IsSpecialDamage(_ARG_0_.myHandle) == false then
    Entity.EnableGravity(_ARG_0_.myHandle, 1)
  end
  if Enemy.IsSpecialDamage(_ARG_0_.myHandle) or _ARG_1_ == ATK_KIND_SLEEP or _ARG_1_ == ATK_KIND_FAINT or _ARG_1_ == ATK_KIND_MINIMUM or _ARG_1_ == ATK_KIND_SLEEP then
    Entity.EnableGuard(_ARG_0_.myHandle, 0)
    Entity.EnableGuardPhysical(_ARG_0_.myHandle, 0)
    Entity.EnableGuardZero(_ARG_0_.myHandle, 0)
    Entity.EnableGuardZeroEx(_ARG_0_.myHandle, 0)
    Entity.EnableGuardFire(_ARG_0_.myHandle, 0)
    Entity.EnableGuardIce(_ARG_0_.myHandle, 0)
    Entity.EnableGuardThunder(_ARG_0_.myHandle, 0)
    Entity.SetGuardDir(_ARG_0_.myHandle, 0)
    Entity.EnableGuardSpecial(_ARG_0_.myHandle, 0)
    return
  end
  if _UPVALUE0_ == _UPVALUE1_ then
    _ARG_0_.DamageCnt = _ARG_0_.DamageCnt + 1
    if _ARG_0_.DamageCnt >= _UPVALUE2_ then
      _ARG_0_.DamageCnt = 0
      if Script.Random() < _UPVALUE3_ then
        _ARG_0_:GotoState("Guard")
        return 1
      end
    end
  elseif _UPVALUE0_ == _UPVALUE4_ then
    if Enemy.GetHp(_ARG_0_.myHandle) <= Enemy.GetHpMax(_ARG_0_.myHandle) * _UPVALUE5_ + 0.001 and Script.Random() <= _UPVALUE3_ then
      _ARG_0_:GotoState("Guard")
      return 1
    end
  else
    _ARG_0_.DamageCnt = _ARG_0_.DamageCnt + 1
    if _ARG_0_.DamageCnt >= _UPVALUE2_ then
      _ARG_0_.DamageCnt = 0
      if Script.Random() < _UPVALUE3_ then
        _ARG_0_:GotoState("Guard")
        return 1
      end
    end
    if Enemy.GetHp(_ARG_0_.myHandle) <= Enemy.GetHpMax(_ARG_0_.myHandle) * _UPVALUE5_ + 0.001 and Script.Random() <= _UPVALUE3_ then
      _ARG_0_:GotoState("Guard")
      return 1
    end
  end
end
function m07ex00.OnReturnDamage(_ARG_0_)
  if Enemy.IsSpecialDamage(_ARG_0_.myHandle) == false then
    Entity.EnableGravity(_ARG_0_.myHandle, 1)
    _ARG_0_:GotoState("Idling")
  end
  _ARG_0_.targetStompar = NULL_HANDLE
end
function m07ex00.OnHitAttack(_ARG_0_)
  if _ARG_0_.TramplingFlag == 1 then
    _ARG_0_.AttackFlag = 1
  end
end
function m07ex00.OnUpdatePositionAfter(_ARG_0_)
  if _ARG_0_.flag then
    _ARG_0_.rot:set(0, _ARG_0_.angle, 0)
    Entity.RotateBoneXYZ(_ARG_0_.myHandle, 2, _ARG_0_.rot)
  end
end
function m07ex00.OnDead(_ARG_0_)
  _ARG_0_.step = 99
end
function m07ex00.OnDestroy(_ARG_0_)
  _ARG_0_.step = 99
end
function m07ex00.OnGuard(_ARG_0_)
  Entity.GetDamageCrossPos(_ARG_0_.WorkVec, _ARG_0_.myHandle)
  _ARG_0_.WorkVec1:set(0, 0, 0)
  Entity.SetEffect(_ARG_0_.myHandle, "p_ex_bas_00", "P_EX_ATC_DIS0_0", _ARG_0_.WorkVec, _ARG_0_.WorkVec1)
end
function m07ex00.GetCameraTargetPos(_ARG_0_)
  Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.myHandle)
  _ARG_0_.cameraPos:set(_ARG_0_.WorkVec:getx(), _ARG_0_.WorkVec:gety() - Entity.GetFloorDistance(_ARG_0_.myHandle) + 1, _ARG_0_.WorkVec:getz())
  return _ARG_0_.cameraPos
end
function m07ex00.Debug(_ARG_0_)
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
function m07ex00.OnUpdate(_ARG_0_)
  if Entity.IsAlive(_ARG_0_.targetHandle) == false then
    _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
  end
  _ARG_0_:Update()
  _ARG_0_:Debug()
end
EntityFactory:Add("m07ex00", function(_ARG_0_)
  return (m07ex00:new())
end)
EntityFactory:Add("m07vs00", function(_ARG_0_)
  return (m07ex00:new())
end)
