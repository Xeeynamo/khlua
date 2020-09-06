setmetatable({
  new = function(_ARG_0_)
    return setmetatable(__StateMachine:new(), _UPVALUE0_)
  end,
  states = {
    Fly = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.GetVelocity(_ARG_0_.velocity, _ARG_0_.myHandle)
          if 0 > _ARG_0_.velocity:gety() then
            Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if Entity.IsGround(_ARG_0_.myHandle) then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE1_)
            _ARG_0_.step = 2
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    Appear = {
      OnBeginState = function(_ARG_0_)
        SetupAppearBegin(_ARG_0_.myHandle, -1, _UPVALUE0_, 1)
        _ARG_0_.step = 0
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
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, Script.RandomInRange(_UPVALUE1_, _UPVALUE1_ * 2))
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
          return
        end
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        if CanDisappear(_ARG_0_.myHandle, _ARG_0_.targetHandle) then
          _ARG_0_:GotoState("Disappear")
          return
        end
        if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) == false then
          Enemy.GetTargetLastRecordedPos(_ARG_0_.playerPos, _ARG_0_.myHandle, _ARG_0_.targetHandle)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.playerPos, 2.5)
          return
        end
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE0_ then
          if Script.Random() < _UPVALUE1_ then
            _ARG_0_:GotoState("Whip")
          else
            _ARG_0_:GotoState("SpinDisorderAttack")
          end
        elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _UPVALUE0_ and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE2_ then
          if Script.Random() < _UPVALUE3_ then
            _ARG_0_.attack = 0
          elseif Script.Random() > _UPVALUE3_ and Script.Random() < _UPVALUE4_ then
            _ARG_0_.attack = 1
          else
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE5_)
            return
          end
          _ARG_0_:GotoState("Move")
        elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _UPVALUE2_ and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE6_ then
          _ARG_0_:GotoState("SpinRush")
        end
      end
    },
    FastIdling = {
      OnBeginState = function(_ARG_0_)
        if _ARG_0_.aura then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_, -2)
        else
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
          _ARG_0_.aura = true
        end
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        if Script.Random() < 0.5 then
          _ARG_0_.rotDir = 1
        else
          _ARG_0_.rotDir = -1
        end
      end,
      OnEndState = function(_ARG_0_)
        Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.fastModeTimer <= 0 then
          _ARG_0_.mode = _UPVALUE0_
          _ARG_0_.aura = false
          _ARG_0_:GotoState("Dizzy")
          return
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
          return
        end
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        if CanDisappear(_ARG_0_.myHandle, _ARG_0_.targetHandle) then
          _ARG_0_:GotoState("Disappear")
          return
        end
        if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) == false then
          Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
          _ARG_0_.rot:sety(RoundPI(_ARG_0_.rot:gety() + DegToRad(_ARG_0_.rotDir * 2) * Entity.GetFrameRate(_ARG_0_.myHandle)))
          Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
          return
        end
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE1_ then
          _ARG_0_:GotoState("SpinDisorderAttack")
        elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _UPVALUE1_ and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE2_ then
          if Script.Random() < _UPVALUE3_ then
            _ARG_0_.attack = 0
          else
            _ARG_0_.attack = 1
          end
          _ARG_0_:GotoState("FastMove")
        elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _UPVALUE2_ and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE4_ then
          _ARG_0_:GotoState("SpinRush")
        end
      end
    },
    Move = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:ChangeIdlingState()
          return
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        if _ARG_0_.attack == 0 then
          _ARG_0_.velocity:set(0, 0, _UPVALUE0_)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE1_ then
            if Script.Random() < _UPVALUE2_ then
              _ARG_0_:GotoState("Whip")
            else
              _ARG_0_:GotoState("SpinDisorderAttack")
            end
          end
        else
          _ARG_0_.velocity:set(0, 0, -_UPVALUE0_)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _UPVALUE3_ then
            _ARG_0_:GotoState("SpinRush")
          end
        end
      end
    },
    FastMove = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:ChangeIdlingState()
          return
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        if _ARG_0_.attack == 0 then
          _ARG_0_.velocity:set(0, 0, _UPVALUE0_)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE1_ then
            _ARG_0_:GotoState("SpinDisorderAttack")
          end
        else
          _ARG_0_.velocity:set(0, 0, -_UPVALUE0_)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _UPVALUE2_ then
            _ARG_0_:GotoState("SpinRush")
          end
        end
      end
    },
    Whip = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Stiff")
        end
      end
    },
    SpinDisorderAttack = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          if _ARG_0_.mode == _UPVALUE0_ then
            _ARG_0_:GotoState("Dizzy")
          else
            _ARG_0_:GotoState("Stiff")
          end
        end
      end
    },
    SpinRush = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        _ARG_0_.hitAttack = false
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, _UPVALUE1_)
          _ARG_0_.velocity:set(0, 0, _UPVALUE2_)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
          if Entity.IsTimeOver(_ARG_0_.myHandle) or _ARG_0_.hitAttack then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.step = 2
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          if _ARG_0_.hitAttack then
            _ARG_0_:GotoState("Stiff")
          else
            _ARG_0_:GotoState("Dizzy")
          end
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
          _ARG_0_:GotoState("FastIdling")
        end
      end
    },
    Dizzy = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        _ARG_0_.dizzy = false
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:ChangeIdlingState()
        end
      end
    },
    Stiff = {
      OnBeginState = function(_ARG_0_)
        if _ARG_0_.mode == _UPVALUE0_ then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE1_)
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE2_)
        else
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE3_, -2)
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE4_)
        end
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:ChangeIdlingState()
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
  },
  IsTargetWithinFOV = function(_ARG_0_)
    _ARG_0_.workVec0:set(0, 0, 1)
    if Entity.IsTargetWithinFOV(_ARG_0_.myHandle, _ARG_0_.targetHandle, DegToRad(200), 1, _ARG_0_.workVec0) == false then
      return false
    end
    return true
  end,
  ChangeIdlingState = function(_ARG_0_)
    if _ARG_0_.mode == _UPVALUE0_ then
      _ARG_0_:GotoState("Idling")
    else
      _ARG_0_:GotoState("FastIdling")
    end
  end,
  GetTargetHandle = function(_ARG_0_)
    return _ARG_0_.targetHandle
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    _ARG_0_.myHandle = _ARG_1_
    Entity.EnableGravity(_ARG_1_, 1)
    _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
    _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
    _ARG_0_.playerPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.workVec0 = FVECTOR3.new(0, 0, 0)
    _ARG_0_.step = 0
    _ARG_0_.targetHandle = NULL_HANDLE
    _ARG_0_.mode = _UPVALUE0_
    _ARG_0_.damageCount = 0
    _ARG_0_.dizzy = false
    _ARG_0_.attack = 0
    _ARG_0_.hitAttack = false
    _ARG_0_.fastModeTimer = 0
    _ARG_0_.rotDir = 1
    _ARG_0_.aura = false
    if _UPVALUE1_ == false then
      _UPVALUE2_ = Enemy.GetExtraParam(_ARG_1_, "Act1Dist")
      _UPVALUE3_ = Enemy.GetExtraParam(_ARG_1_, "Act2Dist")
      _UPVALUE4_ = Enemy.GetExtraParam(_ARG_1_, "Act3Dist")
      _UPVALUE5_ = Enemy.GetExtraParam(_ARG_1_, "Act1DistF")
      _UPVALUE6_ = Enemy.GetExtraParam(_ARG_1_, "Act2DistF")
      _UPVALUE7_ = Enemy.GetExtraParam(_ARG_1_, "Act3DistF")
      _UPVALUE8_ = Enemy.GetExtraParam(_ARG_1_, "NModeSpeed")
      _UPVALUE9_ = Enemy.GetExtraParam(_ARG_1_, "FModeSpeed")
      _UPVALUE10_ = Enemy.GetExtraParam(_ARG_1_, "SRSpeed")
      _UPVALUE11_ = Enemy.GetExtraParam(_ARG_1_, "StiffTime") * 60
      _UPVALUE12_ = Enemy.GetExtraParam(_ARG_1_, "StiffTimeF") * 60
      _UPVALUE13_ = Enemy.GetExtraParam(_ARG_1_, "DizzyTime") * 60
      _UPVALUE14_ = Enemy.GetExtraParam(_ARG_1_, "FModeTime") * 60
      _UPVALUE15_ = Enemy.GetExtraParam(_ARG_1_, "DmgCnt")
      _UPVALUE16_ = Enemy.GetExtraParam(_ARG_1_, "SRHoming")
      _UPVALUE17_ = Enemy.GetExtraParam(_ARG_1_, "RndWhipN") / 100
      _UPVALUE18_ = Enemy.GetExtraParam(_ARG_1_, "RndAtk1N") / 100
      _UPVALUE19_ = Enemy.GetExtraParam(_ARG_1_, "RndAtk2N") / 100
      _UPVALUE20_ = Enemy.GetExtraParam(_ARG_1_, "RndAtk1F") / 100
      _UPVALUE21_ = Enemy.GetExtraParam(_ARG_1_, "SrAtkDist")
      _UPVALUE2_ = _UPVALUE2_ * _UPVALUE2_
      _UPVALUE3_ = _UPVALUE3_ * _UPVALUE3_
      _UPVALUE4_ = _UPVALUE4_ * _UPVALUE4_
      _UPVALUE5_ = _UPVALUE5_ * _UPVALUE5_
      _UPVALUE6_ = _UPVALUE6_ * _UPVALUE6_
      _UPVALUE7_ = _UPVALUE7_ * _UPVALUE7_
      _UPVALUE21_ = _UPVALUE21_ * _UPVALUE21_
      _UPVALUE1_ = true
    end
    if Enemy.IsAllEnemyWaiting() then
      _ARG_0_:GotoState("Waiting")
    else
      _ARG_0_:GotoState("Appear")
    end
  end,
  OnHitAttack = function(_ARG_0_)
    if Entity.GetCurrentMotion(_ARG_0_.myHandle) == _UPVALUE0_ then
      _ARG_0_.hitAttack = true
    end
  end,
  OnDamage = function(_ARG_0_, _ARG_1_, _ARG_2_)
    if _ARG_2_ == COMMAND_CATEGORY_ATTACK and _ARG_0_.mode == _UPVALUE0_ then
      _ARG_0_.damageCount = _ARG_0_.damageCount + 1
    end
    return 0
  end,
  OnReturnDamage = function(_ARG_0_)
    if _ARG_0_.damageCount >= _UPVALUE0_ then
      _ARG_0_.damageCount = 0
      if _ARG_0_.mode == _UPVALUE1_ then
        _ARG_0_.mode = _UPVALUE2_
        _ARG_0_.fastModeTimer = _UPVALUE3_
        _ARG_0_:GotoState("Passion")
      end
    else
      _ARG_0_:ChangeIdlingState()
    end
  end,
  OnDead = function(_ARG_0_)
    if _ARG_0_.mode == _UPVALUE0_ then
      Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
    end
    return 0
  end,
  OnUpdate = function(_ARG_0_)
    if Entity.IsAlive(_ARG_0_.targetHandle) == false then
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
    end
    _ARG_0_:Update()
    _ARG_0_:Debug()
    if _ARG_0_.fastModeTimer > 0 then
      _ARG_0_.fastModeTimer = _ARG_0_.fastModeTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
    end
  end,
  Debug = function(_ARG_0_)
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
}, {__index = __StateMachine})
EntityFactory:Add("m06ex00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("m06vs00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
