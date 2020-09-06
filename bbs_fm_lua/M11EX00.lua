setmetatable({
  new = function(_ARG_0_)
    return setmetatable(__StateMachine:new(), _UPVALUE0_)
  end,
  states = {
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
        Entity.SetTimer(_ARG_0_.myHandle, Script.RandomInRange(_UPVALUE1_, _UPVALUE1_ * 1.5))
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        if CanDisappear(_ARG_0_.myHandle, _ARG_0_.targetHandle) then
          _ARG_0_:GotoState("Disappear")
          return
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
          return
        end
        if Script.Random() < 0.3 then
          _ARG_0_:GotoState("Uneasiness")
          return
        end
        if Enemy.IsLeader(_ARG_0_.myHandle) and Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) then
          _ARG_0_:SelectAttack()
        end
        _ARG_0_:GotoState("Wander")
      end
    },
    MoveLastRecordedPos = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Enemy.GetTargetLastRecordedPos(_ARG_0_.targetPos, _ARG_0_.myHandle, _ARG_0_.targetHandle)
        Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
        FVECTOR3.Sub(_UPVALUE1_, _UPVALUE1_, _ARG_0_.targetPos)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_:length() / _UPVALUE2_ + 30)
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) then
          Entity.SetTimer(_ARG_0_.myHandle, 0)
          _ARG_0_:GotoState("Idling")
          return
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 5)
        _ARG_0_.velocity:set(0, 0, _UPVALUE0_)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
        if Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) <= 1 then
          Entity.SetTimer(_ARG_0_.myHandle, 0)
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    Wander = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, -2, -2)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        Entity.EnableAvoidPlayer(_ARG_0_.myHandle, 1)
        Entity.EnableAvoidEnemy(_ARG_0_.myHandle, 1)
        Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.myHandle)
        _ARG_0_.timer = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableAvoidPlayer(_ARG_0_.myHandle, 0)
        Entity.EnableAvoidEnemy(_ARG_0_.myHandle, 0)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if Enemy.IsLeader(_ARG_0_.myHandle) and Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) then
          _ARG_0_:SelectAttack()
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
          return
        end
        if _ARG_0_.timer <= 0 then
          if Enemy.IsLeader(_ARG_0_.myHandle) then
            Entity.GetStartPos(_UPVALUE0_, _ARG_0_.myHandle)
          else
            Entity.GetWorldPos(_UPVALUE0_, (Enemy.GetGroupLeader(_ARG_0_.myHandle)))
          end
          _ARG_0_.timer = 120
          _UPVALUE1_:set(Math.Cos((Script.RandomInRange(-PI, PI))) * (2.5 + Script.Random() * 2.5), Script.RandomInRange(-1, 1), Math.Sin((Script.RandomInRange(-PI, PI))) * (2.5 + Script.Random() * 2.5))
          FVECTOR3.Add(_ARG_0_.targetPos, _UPVALUE0_, _UPVALUE1_)
          Collision.IntersectRayBg(_ARG_0_.targetPos, COLL_KIND_ENEMY, _UPVALUE0_, _ARG_0_.targetPos)
        end
        _ARG_0_:TargetMove(_ARG_0_.targetPos, _UPVALUE2_, 2.5)
        if 1 >= Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) then
          _ARG_0_.timer = 0
        end
      end
    },
    Hurling = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 1)
        Entity.SetTimer(_ARG_0_.myHandle, 300)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Enemy.SendMessage(0, _ARG_0_.myHandle, Enemy.GetGroupLeader(_ARG_0_.myHandle), _UPVALUE0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle, 2)
        _ARG_0_:TargetMove(_ARG_0_.targetPos, _UPVALUE0_, 10)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
          _ARG_0_:GotoState("Stiff")
        end
      end
    },
    SpinningWave = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      end,
      OnEndState = function(_ARG_0_)
        Enemy.SendMessage(0, _ARG_0_.myHandle, Enemy.GetGroupLeader(_ARG_0_.myHandle), _UPVALUE0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Stiff")
        end
      end
    },
    PoisonPowder = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      end,
      OnEndState = function(_ARG_0_)
        Enemy.SendMessage(0, _ARG_0_.myHandle, Enemy.GetGroupLeader(_ARG_0_.myHandle), _UPVALUE0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Stiff")
        end
      end
    },
    Stiff = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
      end,
      OnEndState = function(_ARG_0_)
        _ARG_0_.findTarget = false
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    AttackWaiting = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, -2, -2)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        Entity.EnableAvoidPlayer(_ARG_0_.myHandle, 1)
        Entity.EnableAvoidEnemy(_ARG_0_.myHandle, 1)
        Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.myHandle)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.timer <= 0 then
          if _UPVALUE0_(_ARG_0_.myHandle) then
            _UPVALUE1_(_UPVALUE2_, _ARG_0_.myHandle)
          else
            _UPVALUE5_(_UPVALUE2_, (_UPVALUE4_(_ARG_0_.myHandle)))
          end
          _ARG_0_.timer = 120
          _UPVALUE7_:set(_UPVALUE8_((_UPVALUE6_(-PI, PI))) * (2.5 + _UPVALUE3_() * 2.5), _UPVALUE2_:gety() + _UPVALUE6_(-0.5, 0.5), _UPVALUE9_((_UPVALUE6_(-PI, PI))) * (2.5 + _UPVALUE3_() * 2.5))
          FVECTOR3.Add(_ARG_0_.targetPos, _UPVALUE2_, _UPVALUE7_)
          _UPVALUE10_(_ARG_0_.targetPos, COLL_KIND_ENEMY, _UPVALUE2_, _ARG_0_.targetPos)
        end
        _ARG_0_:TargetMove(_ARG_0_.targetPos, _UPVALUE11_, 2.5)
        if 1 >= _UPVALUE12_(_ARG_0_.myHandle, _ARG_0_.targetPos) then
          _ARG_0_.timer = 0
        end
      end
    },
    Uneasiness = {
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
  SelectAttack = function(_ARG_0_)
    if _ARG_0_.attackCount > 0 and 0 < _ARG_0_.attackTimer then
      return
    end
    if 0 >= Script.GetDebugTestParam() then
      if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE0_ then
        if Script.Random() < 0.3 then
          Enemy.SendMessage(Enemy.SendGroupMessage(_ARG_0_.myHandle, _UPVALUE1_, _UPVALUE2_) * _UPVALUE1_, _ARG_0_.myHandle, _ARG_0_.myHandle, _UPVALUE2_)
        elseif Script.Random() >= 0.3 and Script.Random() < 0.6 then
          Enemy.SendMessage(Enemy.SendGroupMessage(_ARG_0_.myHandle, _UPVALUE1_, _UPVALUE3_) * _UPVALUE1_, _ARG_0_.myHandle, _ARG_0_.myHandle, _UPVALUE3_)
        else
          return
        end
      elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) >= _UPVALUE0_ and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE4_ then
        Enemy.SendMessage(Enemy.SendGroupMessage(_ARG_0_.myHandle, _UPVALUE1_, _UPVALUE5_) * _UPVALUE1_, _ARG_0_.myHandle, _ARG_0_.myHandle, _UPVALUE5_)
      else
        return
      end
    else
      Enemy.SendMessage(Enemy.SendGroupMessage(_ARG_0_.myHandle, _UPVALUE1_, _UPVALUE6_) * _UPVALUE1_, _ARG_0_.myHandle, _ARG_0_.myHandle, _UPVALUE6_)
    end
    _ARG_0_.attackCount = Enemy.SendGroupMessage(_ARG_0_.myHandle, _UPVALUE1_, _UPVALUE6_) + 1
    _ARG_0_.attackTimer = _ARG_0_.attackCount * (_UPVALUE1_ + 240)
  end,
  TargetMove = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    _UPVALUE0_(_UPVALUE1_, _ARG_0_.myHandle)
    _UPVALUE2_(_UPVALUE3_, _ARG_1_, _UPVALUE1_)
    _UPVALUE3_:normalize()
    _UPVALUE4_(_UPVALUE5_, _UPVALUE3_, _UPVALUE3_)
    _UPVALUE8_(_UPVALUE5_, _ARG_0_.myHandle)
    _UPVALUE5_:sety(_UPVALUE9_(_UPVALUE5_:gety(), _UPVALUE6_(_UPVALUE3_:getx(), _UPVALUE3_:getz()), _ARG_3_, _UPVALUE10_(_ARG_0_.myHandle)))
    _UPVALUE11_(_ARG_0_.myHandle, _UPVALUE5_)
    _UPVALUE5_:setx(-_UPVALUE6_(_UPVALUE3_:gety(), _UPVALUE7_(_UPVALUE5_:getx() + _UPVALUE5_:getz())))
    _UPVALUE12_:set(0, 0, _ARG_2_)
    _UPVALUE13_(_UPVALUE12_, _UPVALUE5_)
    _UPVALUE14_(_ARG_0_.myHandle, _UPVALUE12_)
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    _ARG_0_.myHandle = _ARG_1_
    if _UPVALUE0_ == false then
      _UPVALUE0_ = true
      _UPVALUE1_ = Entity.GetMotionIndex(_ARG_1_, "001")
      _UPVALUE2_ = Entity.GetMotionIndex(_ARG_1_, "010")
      _UPVALUE3_ = Entity.GetMotionIndex(_ARG_1_, "040")
      _UPVALUE4_ = Entity.GetMotionIndex(_ARG_1_, "001")
      _UPVALUE5_ = Entity.GetMotionIndex(_ARG_1_, "040")
      _UPVALUE6_ = Entity.GetMotionIndex(_ARG_1_, "310")
      _UPVALUE7_ = Entity.GetMotionIndex(_ARG_1_, "320")
    end
    _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
    _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
    _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.step = 0
    _ARG_0_.targetHandle = NULL_HANDLE
    _ARG_0_.uneasinessFlag = false
    _ARG_0_.timer = 0
    _ARG_0_.timer2 = 0
    _ARG_0_.attackTimer = 0
    _ARG_0_.angleX = 0
    _ARG_0_.findTarget = false
    _ARG_0_.attackCount = 0
    if Enemy.ExistLeader(Entity.GetGroupID(_ARG_1_), _ARG_0_.myHandle) == false then
      Enemy.EnableLeader(_ARG_1_, 1)
    end
    if Enemy.IsAllEnemyWaiting() then
      _ARG_0_:GotoState("Waiting")
    else
      _ARG_0_:GotoState("Appear")
    end
  end,
  OnHitAttack = function(_ARG_0_, _ARG_1_, _ARG_2_)
    if Entity.GetCurrentMotion(_ARG_0_.myHandle) == _UPVALUE0_ then
      Entity.SetTimer(_ARG_0_.myHandle, 0)
    end
  end,
  OnDamage = function(_ARG_0_, _ARG_1_, _ARG_2_)
    Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
    return 0
  end,
  OnReturnDamage = function(_ARG_0_)
    _ARG_0_.findTarget = false
    _ARG_0_:GotoState("Idling")
  end,
  OnMessage = function(_ARG_0_, _ARG_1_, _ARG_2_)
    if Enemy.IsDamageReaction(_ARG_0_.myHandle) then
      return
    end
    if Entity.GetGroupID(_ARG_2_) ~= Entity.GetGroupID(_ARG_0_.myHandle) then
      return
    end
    if EntityManager:GetEntity(_ARG_2_) ~= nil then
      _ARG_0_.targetHandle = EntityManager:GetEntity(_ARG_2_).targetHandle
    end
    if _ARG_1_ == _UPVALUE0_ then
      _ARG_0_:GotoState("Hurling")
    elseif _ARG_1_ == _UPVALUE1_ then
      _ARG_0_:GotoState("SpinningWave")
    elseif _ARG_1_ == _UPVALUE2_ then
      _ARG_0_:GotoState("PoisonPowder")
    elseif _ARG_1_ == _UPVALUE3_ then
      if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE4_ then
        if Script.Random() < 0.3 then
          _ARG_0_:GotoState("SpinningWave")
        elseif Script.Random() >= 0.3 and Script.Random() < 0.6 then
          _ARG_0_:GotoState("PoisonPowder")
        else
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE5_)
          _ARG_0_:GotoState("Idling")
        end
      elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) >= _UPVALUE4_ and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE6_ then
        _ARG_0_:GotoState("Hurling")
      else
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE5_)
        _ARG_0_:GotoState("Idling")
      end
    elseif _ARG_1_ == _UPVALUE7_ then
      _ARG_0_:SelectAttack()
    elseif _ARG_1_ == _UPVALUE8_ then
      _ARG_0_:GotoState("Idling")
    elseif _ARG_1_ == _UPVALUE9_ then
      _ARG_0_.attackCount = _ARG_0_.attackCount - 1
    end
  end,
  OnDestroy = function(_ARG_0_)
    if Enemy.IsLeader(_ARG_0_.myHandle) then
      Enemy.DecideLeader(Entity.GetGroupID(_ARG_0_.myHandle), _ARG_0_.myHandle)
    end
  end,
  OnUpdate = function(_ARG_0_)
    if Entity.IsAlive(_ARG_0_.targetHandle) == false then
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
    end
    _ARG_0_:Update()
    _ARG_0_:Debug()
    if _ARG_0_.timer > 0 then
      _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
    end
    if 0 < _ARG_0_.timer2 then
      _ARG_0_.timer2 = _ARG_0_.timer2 - Entity.GetFrameRate(_ARG_0_.myHandle)
    end
    if 0 < _ARG_0_.attackTimer then
      _ARG_0_.attackTimer = _ARG_0_.attackTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
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
EntityFactory:Add("m11ex00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
