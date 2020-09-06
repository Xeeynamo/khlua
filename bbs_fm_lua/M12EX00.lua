setmetatable({
  new = function(_ARG_0_)
    return setmetatable(__StateMachine:new(), _UPVALUE0_)
  end,
  states = {
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
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 1)
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    Waiting = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 1)
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
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
          return
        end
        if CanDisappear(_ARG_0_.myHandle, _ARG_0_.targetHandle) then
          _ARG_0_:GotoState("Disappear")
          return
        end
        Enemy.GetTargetLastRecordedPos(_UPVALUE0_, _ARG_0_.myHandle, _ARG_0_.targetHandle)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE0_, 2.5)
        if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) == false then
          return
        end
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE1_ then
          if Script.Random() < 0.7 then
            _ARG_0_:GotoState("SmokeOrdnance")
          else
            _ARG_0_:GotoState("Wander")
          end
        elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) >= _UPVALUE1_ and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < ENEMY_COMMON_DISAPPEAR_DIST then
          if Script.Random() < 0.4 then
            _ARG_0_:GotoState("JetRush")
          elseif Script.Random() >= 0.4 and Script.Random() < 0.7 then
            _ARG_0_:GotoState("BoundDrop")
          else
            _ARG_0_:GotoState("Wander")
          end
        end
      end
    },
    Wander = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_ * 0.5 + Script.Random() * (_UPVALUE1_ * 0.5))
        _ARG_0_.moveTimer = 0
        Entity.EnableAvoidPlayer(_ARG_0_.myHandle, 1)
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableAvoidPlayer(_ARG_0_.myHandle, 0)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.HasNetGameHandle(_ARG_0_.myHandle) and Enemy.IsNetworkMaster(_ARG_0_.myHandle) == false then
          return
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
          return
        end
        _ARG_0_.moveTimer = _ARG_0_.moveTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.moveTimer <= 0 then
          _UPVALUE0_:set(Math.Cos((RoundPI(DegToRad((Script.Random() - Script.Random()) * 360)))) * (3 + Script.Random() * 5), 0, Math.Sin((RoundPI(DegToRad((Script.Random() - Script.Random()) * 360)))) * (3 + Script.Random() * 5))
          _ARG_0_.moveTimer = _UPVALUE1_
        end
        Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
        FVECTOR3.Add(_ARG_0_.targetPos, _ARG_0_.targetPos, _UPVALUE0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 2.5)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE2_)
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) <= 1 then
          _ARG_0_.moveTimer = 0
        end
      end
    },
    SmokeOrdnance = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 20 then
            _ARG_0_.step = 1
          end
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Stiff")
        end
      end
    },
    JetRush = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 20 then
            _ARG_0_.step = 1
          end
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Stiff")
        end
      end
    },
    BoundDrop = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.EnableGravity(_ARG_0_.myHandle, 0)
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        _ARG_0_.step = 0
        _ARG_0_.step2 = 0
        _ARG_0_.endBoundDrop = false
        _ARG_0_.rootMoveScale = 1
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
        if _ARG_0_.step == 1 then
          if _ARG_0_.step2 == 0 then
            if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 15 then
              Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, _ARG_0_.rootMoveScale, 1)
              _ARG_0_.step2 = 1
            end
          elseif _ARG_0_.step2 == 1 then
            if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 42 then
              Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, _ARG_0_.rootMoveScale, 1)
              _ARG_0_.step2 = 2
            end
          elseif Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 72 then
            Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, _ARG_0_.rootMoveScale, 1)
            _ARG_0_.step2 = 3
          end
        end
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            _ARG_0_.speed = _ARG_0_:CalcSpeed(_ARG_0_.targetPos, 26)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          _ARG_0_.velocity:set(0, 0, _ARG_0_.speed)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 26 then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
            _ARG_0_.speed = _ARG_0_:CalcSpeed(_ARG_0_.targetPos, 28)
            _ARG_0_:SetShockWaveEffect()
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          _ARG_0_.velocity:set(0, 0, _ARG_0_.speed)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 54 then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
            _ARG_0_.speed = _ARG_0_:CalcSpeed(_ARG_0_.targetPos, 30)
            _ARG_0_:SetShockWaveEffect()
            _ARG_0_.step = 3
          end
        elseif _ARG_0_.step == 3 then
          _ARG_0_.velocity:set(0, 0, _ARG_0_.speed)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
            Entity.EnableGravity(_ARG_0_.myHandle, 1)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
            _ARG_0_.step = 4
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Entity.ClearSpeed(_ARG_0_.myHandle)
          Entity.EnableGravity(_ARG_0_.myHandle, 1)
          Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
          _ARG_0_:GotoState("Stiff")
        end
      end
    },
    SelfDestruction = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _UPVALUE1_:set(0, 0, 0)
        if _ARG_0_.effHandle == NULL_HANDLE then
          _ARG_0_.effHandle = Entity.AttachEffect(_ARG_0_.myHandle, "e_ex120", "E012_EXP_01_0", "ctl_hara", _UPVALUE1_, _UPVALUE1_)
        end
        _UPVALUE1_:set(_ARG_0_.scale, _ARG_0_.scale, _ARG_0_.scale)
        Effect.SetScale(_ARG_0_.effHandle, _UPVALUE1_)
        Enemy.EnableInvincible(_ARG_0_.myHandle, 1)
        Enemy.AddHp(_ARG_0_.myHandle, 1)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 59 then
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
            _ARG_0_.timer = 60
            _ARG_0_.step = 1
          end
        else
          _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 < _ARG_0_.timer then
            Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 1)
          else
            Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 15)
            _ARG_0_.timer = 60
          end
          _ARG_0_.velocity:set(0, 0, 0.075 * _ARG_0_.scale)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:Explosion()
          end
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
    TurnLastRecordedPos = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        Enemy.GetTargetLastRecordedPos(_ARG_0_.targetPos, _ARG_0_.myHandle, _ARG_0_.targetHandle)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_:SelectedBehavior() then
          return
        end
        if Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 5) == false then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    MoveLastRecordedPos = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Enemy.GetTargetLastRecordedPos(_ARG_0_.targetPos, _ARG_0_.myHandle, _ARG_0_.targetHandle)
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_:SelectedBehavior() then
          return
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 10)
        _ARG_0_.velocity:set(0, 0, _UPVALUE0_)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) <= 1 then
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
  },
  CanGotoState = function(_ARG_0_)
    if _ARG_0_:GetState() == "SelfDestruction" then
      return false
    end
    return true
  end,
  IsTargetWithinFOV = function(_ARG_0_)
    _UPVALUE0_:set(0, 1, 0)
    if Entity.IsTargetWithinFOV(_ARG_0_.myHandle, _ARG_0_.targetHandle, DegToRad(180), 7, _UPVALUE0_) == false then
      return false
    end
    return true
  end,
  UpdateExpansion = function(_ARG_0_)
    if _ARG_0_.scaleTimer > 0 then
      _ARG_0_.scaleTimer = _ARG_0_.scaleTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
      if _ARG_0_.scaleTimer <= 0 then
        _ARG_0_.scaleTimer = 0
      end
      _ARG_0_.scale = _ARG_0_.srcScale + (1 - _ARG_0_.scaleTimer / _UPVALUE0_) * (_ARG_0_.dstScale - _ARG_0_.srcScale)
    end
    if _ARG_0_.exec then
      _ARG_0_.theta = RoundPI(_ARG_0_.theta + Entity.GetFrameRate(_ARG_0_.myHandle) * DegToRad(32))
      _ARG_0_.c = _ARG_0_.c - Entity.GetFrameRate(_ARG_0_.myHandle) * 0.0025
      if 0 >= _ARG_0_.c then
        _ARG_0_.c = 0
        _ARG_0_.exec = false
      end
    end
  end,
  SelectedBehavior = function(_ARG_0_)
    _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
    if CanDisappear(_ARG_0_.myHandle, _ARG_0_.targetHandle) then
      _ARG_0_:GotoState("Disappear")
      return true
    end
    if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) == false then
      return false
    end
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE0_ then
      _ARG_0_:GotoState("SmokeOrdnance")
    elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) >= _UPVALUE0_ and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < ENEMY_COMMON_DISAPPEAR_DIST then
      if Script.Random() < 0.6 then
        _ARG_0_:GotoState("JetRush")
      else
        _ARG_0_:GotoState("BoundDrop")
      end
    end
    return true
  end,
  SelectAttack = function(_ARG_0_, _ARG_1_)
    _ARG_0_.targetHandle = _ARG_1_
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE0_ then
      _ARG_0_:GotoState("SmokeOrdnance")
    elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) >= _UPVALUE0_ and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < ENEMY_COMMON_DISAPPEAR_DIST then
      if Script.Random() < 0.7 then
        _ARG_0_:GotoState("JetRush")
      else
        _ARG_0_:GotoState("BoundDrop")
      end
    else
      Script.SendMessage(0, _ARG_0_.myHandle, _ARG_0_.myHandle, MSG_ATTACK_END)
    end
  end,
  CalcSpeed = function(_ARG_0_, _ARG_1_, _ARG_2_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
    Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.targetHandle)
    Entity.GetVelocity(_UPVALUE2_, _ARG_0_.targetHandle)
    _UPVALUE2_:scale(_ARG_2_ * 2)
    FVECTOR3.Add(_ARG_1_, _UPVALUE1_, _UPVALUE2_)
    Collision.IntersectRayBg(_ARG_1_, COLL_KIND_ENEMY, _UPVALUE1_, _ARG_1_)
    _UPVALUE1_:copy(_ARG_1_)
    _UPVALUE1_:sety(_UPVALUE1_:gety() + 0.1)
    _UPVALUE2_:copy(_ARG_1_)
    _UPVALUE2_:sety(_UPVALUE2_:gety() - 100)
    Collision.IntersectRayBg(_UPVALUE1_, COLL_KIND_ENEMY, _UPVALUE1_, _UPVALUE2_)
    _ARG_0_.rootMoveScale = (4 + (_UPVALUE0_:gety() - _UPVALUE1_:gety())) / 4
    if _ARG_0_.rootMoveScale < 1 then
      _ARG_0_.rootMoveScale = 1
    end
    Entity.SetRot(_ARG_0_.myHandle, 0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_1_), 0)
    return Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_1_) / (_ARG_2_ * 2)
  end,
  SetShockWaveEffect = function(_ARG_0_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
    _UPVALUE0_:sety(_UPVALUE0_:gety() + 0.1)
    _UPVALUE1_:copy(_UPVALUE0_)
    _UPVALUE1_:sety(_UPVALUE1_:gety() - 5)
    if Collision.IntersectRayBg(_UPVALUE0_, COLL_KIND_ENEMY, _UPVALUE0_, _UPVALUE1_) == false then
      return
    end
    _UPVALUE1_:set(0, 0, 0)
    Entity.SetEffect(_ARG_0_.myHandle, "e_ex120", "E012_BND_00_0", _UPVALUE0_, _UPVALUE1_)
  end,
  IsFront = function(_ARG_0_)
    Entity.GetAttackerPos(_UPVALUE0_, _ARG_0_.myHandle)
    Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
    FVECTOR3.Sub(_UPVALUE0_, _UPVALUE0_, _UPVALUE1_)
    Entity.GetDir(_UPVALUE1_, _ARG_0_.myHandle)
    if FVECTOR3.dot(_UPVALUE0_, _UPVALUE1_) >= Math.Cos(DegToRad(_UPVALUE2_) * 0.5) then
      return true
    end
    return false
  end,
  Explosion = function(_ARG_0_)
    if _ARG_0_.explosion then
      return
    end
    Entity.ClearSpeed(_ARG_0_.myHandle)
    Effect.KillEffect(_ARG_0_.effHandle)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 2)
    _UPVALUE1_:set(0, 0, 0)
    SetBulletAttackParam(Bullet.CreateBullet("m12exExplode", _UPVALUE0_, _UPVALUE1_), _ARG_0_.myHandle, 3)
    Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
    Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
    Enemy.Dead(_ARG_0_.myHandle)
    _ARG_0_.explosion = true
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
    _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
    _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.step = 0
    _ARG_0_.step2 = 0
    _ARG_0_.targetHandle = NULL_HANDLE
    _ARG_0_.timer = 0
    _ARG_0_.scale = 1
    _ARG_0_.speed = 0
    _ARG_0_.rotDir = 1
    _ARG_0_.moveTimer = 0
    _ARG_0_.srcScale = 1
    _ARG_0_.dstScale = 1
    _ARG_0_.scaleTimer = 0
    _ARG_0_.c = 0
    _ARG_0_.theta = 0
    _ARG_0_.exec = false
    _ARG_0_.expansionCount = 0
    _ARG_0_.effHandle = NULL_HANDLE
    _ARG_0_.height = 0
    _ARG_0_.endBoundDrop = false
    _ARG_0_.expandEffect = NULL_HANDLE
    _ARG_0_.rootMoveScale = 1
    _ARG_0_.explosion = false
    Entity.EnableGravity(_ARG_1_, 1)
    Entity.SetMovementCollRadius(_ARG_1_, 1)
    Entity.SetLowerHalf(_ARG_1_, 1.5)
    Enemy.SetMoveSpeed(_ARG_1_, _UPVALUE0_)
    Enemy.EnableNoChangeDamageMotion(_ARG_1_, 1)
    if _UPVALUE1_ == false then
      _UPVALUE2_ = Enemy.GetExtraParam(_ARG_1_, "WanderTime") * 60
      _UPVALUE3_ = Enemy.GetExtraParam(_ARG_1_, "StiffTime") * 60
      _UPVALUE4_ = Enemy.GetExtraParam(_ARG_1_, "SDTime") * 60
      _UPVALUE5_ = Enemy.GetExtraParam(_ARG_1_, "MaxExpand")
      _UPVALUE6_ = Enemy.GetExtraParam(_ARG_1_, "ExpandCount")
      _UPVALUE7_ = Enemy.GetExtraParam(_ARG_1_, "ActionDist")
      _UPVALUE7_ = _UPVALUE7_ * _UPVALUE7_
      _UPVALUE1_ = true
    end
    if Enemy.IsAllEnemyWaiting() then
      _ARG_0_:GotoState("Waiting")
    else
      _ARG_0_:GotoState("Appear")
    end
  end,
  OnDestroy = function(_ARG_0_)
    Effect.KillEffect(_ARG_0_.effHandle)
    Effect.KillEffect(_ARG_0_.expandEffect)
  end,
  IsScalingDamage = function(_ARG_0_, _ARG_1_)
    if Enemy.IsSpecialDamage(_ARG_0_.myHandle) then
      return false
    end
    for _FORV_5_, _FORV_6_ in pairs(_UPVALUE0_) do
      if _ARG_1_ == _FORV_6_ then
        return true
      end
    end
    return false
  end,
  OnDamage = function(_ARG_0_, _ARG_1_, _ARG_2_)
    if _ARG_0_:GetState() == "SelfDestruction" then
      return 1
    end
    if _ARG_0_:IsScalingDamage(_ARG_1_) == false then
      return 0
    end
    if _ARG_0_:IsFront() then
      if _ARG_0_.expansionCount < _UPVALUE0_ then
        _ARG_0_.expansionCount = _ARG_0_.expansionCount + 1
        _UPVALUE1_:set(0, 0, 0)
        _ARG_0_.expandEffect = Entity.AttachEffect(_ARG_0_.myHandle, "e_ex120", "E012_GRW_00_0", "ctl_hara", _UPVALUE1_, _UPVALUE1_)
        Effect.SetAttachNoScale(_ARG_0_.expandEffect, true)
        _ARG_0_.c = 0.25
        _ARG_0_.theta = 0
        _ARG_0_.exec = true
      end
    else
      _ARG_0_.expansionCount = _ARG_0_.expansionCount - 1
      if 0 > _ARG_0_.expansionCount then
        _ARG_0_.expansionCount = 0
      end
    end
    _ARG_0_.srcScale = _ARG_0_.scale
    _ARG_0_.dstScale = 1 + (_UPVALUE2_ - 1) / _UPVALUE0_ * _ARG_0_.expansionCount
    _ARG_0_.scaleTimer = _UPVALUE3_
    if _ARG_0_.expansionCount >= _UPVALUE0_ then
      _ARG_0_:GotoState("SelfDestruction")
      return 1
    end
    return 0
  end,
  OnReturnDamage = function(_ARG_0_)
    if _ARG_0_.expansionCount < _UPVALUE0_ then
      _ARG_0_:GotoState("Idling")
    else
      _ARG_0_:GotoState("SelfDestruction")
    end
  end,
  OnReflect = function(_ARG_0_)
    Entity.EnableGravity(_ARG_0_.myHandle, 1)
    return 0
  end,
  OnBeginDamageReaction = function(_ARG_0_)
    Entity.EnableGravity(_ARG_0_.myHandle, 1)
  end,
  OnEndReaction = function(_ARG_0_)
    Entity.EnableGravity(_ARG_0_.myHandle, 1)
  end,
  OnDead = function(_ARG_0_)
    if Entity.HasNetGameHandle(_ARG_0_.myHandle) then
      if _ARG_0_:GetState() == "SelfDestruction" then
        _ARG_0_:Explosion()
      end
      return 0
    end
    if _ARG_0_:GetState() == "SelfDestruction" then
      return 1
    end
    if _ARG_0_:IsFront() then
      _ARG_0_.expansionCount = _ARG_0_.expansionCount + 1
    end
    if _ARG_0_.expansionCount >= _UPVALUE0_ and Enemy.IsSpecialDamage(_ARG_0_.myHandle) == false then
      _ARG_0_:GotoState("SelfDestruction")
      return 1
    end
    return 0
  end,
  OnUpdatePositionAfter = function(_ARG_0_)
    _ARG_0_:UpdateExpansion()
    _UPVALUE0_:set(Math.Cos(_ARG_0_.theta) * _ARG_0_.c + _ARG_0_.scale, Math.Cos(_ARG_0_.theta) * _ARG_0_.c + _ARG_0_.scale, Math.Cos(_ARG_0_.theta) * _ARG_0_.c + _ARG_0_.scale)
    Entity.ScalingBone(_ARG_0_.myHandle, 2, _UPVALUE0_)
    Entity.ScalingBone(_ARG_0_.myHandle, 5, _UPVALUE0_)
    Entity.ScalingBone(_ARG_0_.myHandle, 15, _UPVALUE0_)
    _UPVALUE0_:set(Math.Cos(_ARG_0_.theta) * _ARG_0_.c + _ARG_0_.scale, Math.Cos(_ARG_0_.theta) * _ARG_0_.c + _ARG_0_.scale, Math.Cos(_ARG_0_.theta) * _ARG_0_.c + _ARG_0_.scale)
    Effect.SetScale(_ARG_0_.expandEffect, _UPVALUE0_)
    Entity.SetMovementCollRadius(_ARG_0_.myHandle, 1 * _ARG_0_.scale)
    Entity.SetLowerHalf(_ARG_0_.myHandle, 1.5 * _ARG_0_.scale)
    Entity.GetScale(_UPVALUE1_, _ARG_0_.myHandle)
    _UPVALUE0_:set(0, (_ARG_0_.scale - 1) * 1.25 * _UPVALUE1_:getx(), 0)
    Entity.SetDispOffset(_ARG_0_.myHandle, _UPVALUE0_)
  end,
  OnUpdate = function(_ARG_0_)
    if Entity.IsAlive(_ARG_0_.targetHandle) == false then
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
    end
    _ARG_0_:Update()
    _ARG_0_:Debug()
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
EntityFactory:Add("m12ex00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("m12vs00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
m12exExplode = {}
m12exExplode.__index = m12exExplode
function m12exExplode.new(_ARG_0_)
  return setmetatable({}, m12exExplode)
end
function m12exExplode.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  Bullet.CreateEffectBullet(_ARG_1_, "e_ex120", "E012_EXP_00_0")
  Bullet.SetHitAttackEffectName(_ARG_1_, "e_ex120", "E012_EXP_02_0")
  Bullet.SetCollision(_ARG_1_, COLL_KIND_NO_CHECK, COLL_SHAPE_SPHERE, 3)
  Entity.EnableBgColl(_ARG_1_, 0)
end
function m12exExplode.OnHitAttack(_ARG_0_)
end
function m12exExplode.OnHitBg(_ARG_0_)
end
function m12exExplode.OnUpdate(_ARG_0_)
  if _ARG_0_.step == 0 and Effect.GetNowFrame(Bullet.GetEffectHandle(_ARG_0_.myHandle)) > 45 then
    Bullet.EnableAttackCollision(_ARG_0_.myHandle, 0)
    _ARG_0_.step = 1
  end
end
EntityFactory:Add("m12exExplode", function(_ARG_0_)
  return (m12exExplode:new())
end)
