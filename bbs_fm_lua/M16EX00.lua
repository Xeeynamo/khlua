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
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    Waiting = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_, -2)
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
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_, -2)
        Entity.SetTimer(_ARG_0_.myHandle, Script.RandomInRange(_UPVALUE1_ * 0.5, _UPVALUE1_))
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        Enemy.GetTargetLastRecordedPos(_UPVALUE0_, _ARG_0_.myHandle, _ARG_0_.targetHandle)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE0_, 2.5)
        if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
          return
        end
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        if CanDisappear(_ARG_0_.myHandle, _ARG_0_.targetHandle) then
          _ARG_0_:GotoState("Disappear")
          return
        end
        if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) == false then
          _ARG_0_:GotoState("Wander")
          return
        end
        _ARG_0_:SelectAction()
      end
    },
    Wander = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.EnableAvoidEnemy(_ARG_0_.myHandle, 1)
        Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.myHandle)
        Entity.SetTimer(_ARG_0_.myHandle, (Script.RandomInRange(_UPVALUE1_, _UPVALUE1_ * 1.5)))
        _ARG_0_.timer = 0
        _ARG_0_.timer2 = Script.RandomInRange(_UPVALUE1_, _UPVALUE1_ * 1.5) * 0.5
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableAvoidEnemy(_ARG_0_.myHandle, 0)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.HasNetGameHandle(_ARG_0_.myHandle) and Enemy.IsNetworkMaster(_ARG_0_.myHandle) == false then
          return
        end
        _ARG_0_.timer2 = _ARG_0_.timer2 - Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.timer2 <= 0 and Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) then
          _ARG_0_:SelectAction()
          return
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
          return
        end
        _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
        if 0 >= _ARG_0_.timer then
          Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
          Entity.GetStartPos(_UPVALUE1_, _ARG_0_.myHandle)
          _ARG_0_.targetPos:set(Math.Cos((Script.RandomInRange(-PI, PI))) * (5 + Script.Random() * 5), 0, Math.Sin((Script.RandomInRange(-PI, PI))) * (5 + Script.Random() * 5))
          FVECTOR3.Add(_ARG_0_.targetPos, _ARG_0_.targetPos, _UPVALUE1_)
          Collision.IntersectRayBg(_ARG_0_.targetPos, COLL_KIND_ENEMY, _UPVALUE0_, _ARG_0_.targetPos)
          _ARG_0_.timer = 120
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 2.5)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE2_)
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= 1 then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    SeekTarget = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        Entity.EnableAvoidEnemy(_ARG_0_.myHandle, 1)
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableAvoidEnemy(_ARG_0_.myHandle, 0)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
          return
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 2.5)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE0_)
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= 6.25 then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    HeavyPunch = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Stiff")
        end
      end
    },
    DrumImpact = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        _ARG_0_.step = 1
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _UPVALUE0_[_ARG_0_.step] ~= nil and _UPVALUE0_[_ARG_0_.step] <= Entity.GetMotionNowFrame(_ARG_0_.myHandle) then
          Camera.QuakeV(20, 0, 6)
          Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle, _UPVALUE2_[_ARG_0_.step])
          Entity.GetWorldPos(_UPVALUE3_, _ARG_0_.myHandle)
          _UPVALUE1_:sety(_UPVALUE3_:gety())
          _UPVALUE4_:set(0, 0, 0)
          SetBulletAttackParam(Bullet.CreateBullet("m16exSW", _UPVALUE1_, _UPVALUE4_), _ARG_0_.myHandle, 1)
          _ARG_0_.step = _ARG_0_.step + 1
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Stiff")
        end
      end
    },
    EarthImpact = {
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
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 30 then
            Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.myHandle)
            Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.targetHandle)
            FVECTOR3.Sub(_ARG_0_.workVec1, _UPVALUE0_, _ARG_0_.workVec0)
            _ARG_0_.workVec1:normalize()
            _ARG_0_.workVec1:scale(_ARG_0_.workVec1:length() / 6)
            Entity.SetTimer(_ARG_0_.myHandle, 7)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 and Entity.IsTimeOver(_ARG_0_.myHandle) then
          FVECTOR3.Add(_ARG_0_.workVec0, _ARG_0_.workVec0, _ARG_0_.workVec1)
          _UPVALUE0_:set(0, 0, 0)
          SetBulletAttackParam(Bullet.CreateBullet("m16exEI", _ARG_0_.workVec0, _UPVALUE0_), _ARG_0_.myHandle, 2)
          Entity.SetTimer(_ARG_0_.myHandle, 7)
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Stiff")
        end
      end
    },
    Rush = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 2.5)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE2_)
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.step = 2
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Stiff")
        end
      end
    },
    Stiff = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, -2)
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
  },
  SelectAction = function(_ARG_0_)
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE0_ then
      if Script.Random() < 0.6 then
        _ARG_0_:GotoState("HeavyPunch")
      else
        _ARG_0_:GotoState("DrumImpact")
      end
    elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _UPVALUE0_ and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE1_ then
      _ARG_0_:GotoState("SeekTarget")
    else
      if _ARG_0_:RestHpRate() > _UPVALUE2_ and Script.Random() < 0.7 then
        _ARG_0_:GotoState("EarthImpact")
        return
      end
      _ARG_0_:GotoState("Rush")
    end
  end,
  RestHpRate = function(_ARG_0_)
    return Enemy.GetHp(_ARG_0_.myHandle) / Enemy.GetHpMax(_ARG_0_.myHandle)
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
    _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
    _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.workVec0 = FVECTOR3.new(0, 0, 0)
    _ARG_0_.workVec1 = FVECTOR3.new(0, 0, 0)
    _ARG_0_.step = 0
    _ARG_0_.targetHandle = NULL_HANDLE
    _ARG_0_.timer = 0
    _ARG_0_.timer2 = 0
    if _UPVALUE0_ == false then
      _UPVALUE1_ = Entity.GetMotionIndex(_ARG_1_, "001")
      _UPVALUE2_ = Entity.GetMotionIndex(_ARG_1_, "001")
      _UPVALUE3_ = Entity.GetMotionIndex(_ARG_1_, "040")
      _UPVALUE4_ = Entity.GetMotionIndex(_ARG_1_, "060")
      _UPVALUE5_ = Entity.GetMotionIndex(_ARG_1_, "061")
      _UPVALUE6_ = Entity.GetMotionIndex(_ARG_1_, "062")
      _UPVALUE7_ = Entity.GetMotionIndex(_ARG_1_, "300")
      _UPVALUE8_ = Entity.GetMotionIndex(_ARG_1_, "310")
      _UPVALUE9_ = Entity.GetMotionIndex(_ARG_1_, "320")
      _UPVALUE10_ = Entity.GetMotionIndex(_ARG_1_, "330")
      _UPVALUE11_ = Entity.GetMotionIndex(_ARG_1_, "331")
      _UPVALUE12_ = Entity.GetMotionIndex(_ARG_1_, "332")
      _UPVALUE0_ = true
    end
    Entity.EnableGravity(_ARG_1_, 1)
    Entity.SetMovementCollRadius(_ARG_1_, 1.5)
    Entity.SetLowerHalf(_ARG_1_, 2)
    if Enemy.IsAllEnemyWaiting() then
      _ARG_0_:GotoState("Waiting")
    else
      _ARG_0_:GotoState("Appear")
    end
  end,
  OnHitAttack = function(_ARG_0_)
  end,
  OnReturnDamage = function(_ARG_0_)
    _ARG_0_:GotoState("Idling")
  end,
  OnDamage = function(_ARG_0_)
    Entity.EnableAvoidPlayer(_ARG_0_.myHandle, 0)
    return 0
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
EntityFactory:Add("m16ex00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("m16vs00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("m16exSW", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("m16exEI", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
