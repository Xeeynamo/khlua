setmetatable({
  new = function(_ARG_0_)
    return setmetatable(__StateMachine:new(), _UPVALUE0_)
  end,
  states = {
    Appear = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
        if _UPVALUE0_:getz() > 0 then
          _ARG_0_.Court = _UPVALUE1_
        else
          _ARG_0_.Court = _UPVALUE2_
        end
        _ARG_0_:GotoState("Idling")
      end
    },
    Idling = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.WaitTimer = 0
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          _ARG_0_.WaitTimer = _ARG_0_.WaitTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 >= _ARG_0_.WaitTimer then
            if Entity.CalcDistance(_ARG_0_.myHandle, _UPVALUE0_) > _UPVALUE1_ then
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
              _ARG_0_.WaitTimer = Script.RandomInRange(180, 360)
              _ARG_0_.step = 1
            else
              _ARG_0_.WaitTimer = Script.RandomInRange(180, 360)
              _ARG_0_.step = 2
            end
          end
        elseif _ARG_0_.step == 1 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE0_, 10)
          Entity.CalcVelocity(_ARG_0_.myHandle, _UPVALUE3_)
          if Entity.CalcDistance(_ARG_0_.myHandle, _UPVALUE0_) <= _UPVALUE1_ then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE4_)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          _ARG_0_.WaitTimer = _ARG_0_.WaitTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 >= _ARG_0_.WaitTimer then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE5_)
            _ARG_0_.step = 3
          end
        elseif _ARG_0_.step == 3 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE4_)
          _ARG_0_.WaitTimer = Script.RandomInRange(180, 360)
          _ARG_0_.step = 2
        end
        if _UPVALUE6_ == true then
          return
        end
        _ARG_0_.ballHandle = FruitBall.GetEnemyChance(_ARG_0_.myHandle, _ARG_0_.Court)
        if _ARG_0_.ballHandle ~= NULL_HANDLE then
          _ARG_0_.chanceBallFrame = FruitBall.GetChanceBallParam(_ARG_0_.ballHandle, _ARG_0_.chanceBallPos)
          if _ARG_0_.chanceBallFrame >= 30 then
            _ARG_0_:GotoState("JumpSmash")
            return
          end
        end
        for _FORV_5_ = 1, _ARG_0_.parentHandle.GoalCount do
          _ARG_0_.ballHandle = FruitBall.SearchNearBall(_ARG_0_.parentHandle.EnemyGoalHand[_FORV_5_], _ARG_0_.Court)
          if _ARG_0_.ballHandle ~= NULL_HANDLE and Entity.CalcDistance(_ARG_0_.parentHandle.EnemyGoalHand[_FORV_5_], _UPVALUE7_) < 4 and 30 < FruitBall.GetAttainmentTime(_ARG_0_.ballHandle, _UPVALUE7_) and Entity.CalcDistance(_ARG_0_.myHandle, _UPVALUE7_) > 6 then
            Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.ballHandle, 10)
            _ARG_0_:GotoState("Diving")
            return
          end
        end
        _ARG_0_.ballHandle = _FOR_.SearchNearBall(_ARG_0_.myHandle, _ARG_0_.Court)
        if _ARG_0_.ballHandle ~= NULL_HANDLE then
          FruitBall.GetFallPosition(_ARG_0_.ballHandle, _UPVALUE7_)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE7_, 10)
          _ARG_0_:GotoState("Chases")
        end
      end
    },
    Chases = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if FruitBall.CheckHandle(_ARG_0_.ballHandle, _ARG_0_.Court) == false then
          Entity.ClearSpeed(_ARG_0_.myHandle)
          _ARG_0_:GotoState("Idling")
        else
          FruitBall.GetFallPosition(_ARG_0_.ballHandle, _UPVALUE0_)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE0_, 10)
          Entity.CalcVelocity(_ARG_0_.myHandle, _UPVALUE1_)
          if Entity.CalcDistance(_ARG_0_.myHandle, _UPVALUE0_) <= _UPVALUE2_ then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Entity.GetWorldPos(_UPVALUE4_, _ARG_0_.ballHandle)
            if _UPVALUE4_:gety() >= 2 then
              _ARG_0_:GotoState("Smash")
            elseif Script.Random() < 0.33 then
              _ARG_0_:GotoState("Smash")
            else
              _ARG_0_:GotoState("BallBeatting")
            end
          end
        end
      end
    },
    BallBeatting = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.attackKind = 0
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if FruitBall.CheckHandle(_ARG_0_.ballHandle) == false then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_:GotoState("Idling")
          else
            Entity.GetWorldPos(FVECTOR3.new(0, 0, 0), _ARG_0_.ballHandle)
            if Entity.CalcDistance(_ARG_0_.myHandle, (FVECTOR3.new(0, 0, 0))) <= 2 then
              Entity.SetMotionSpeed(_ARG_0_.myHandle, 2)
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
              _ARG_0_.step = 1
              return
            end
            FruitBall.GetFallPosition(_ARG_0_.ballHandle, _UPVALUE1_)
            if _UPVALUE1_:getx() == _UPVALUE2_:getx() and _UPVALUE1_:getz() == _UPVALUE2_:getz() then
              Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.direction, 10)
              if FruitBall.GetAttainmentTime(_ARG_0_.ballHandle, _UPVALUE2_) <= 40 then
                Entity.SetMotionSpeed(_ARG_0_.myHandle, 2)
                Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
                _ARG_0_.step = 1
              end
            else
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
              _ARG_0_:GotoState("Chases")
            end
          end
        elseif _ARG_0_.step == 1 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    Smash = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.attackKind = 1
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if FruitBall.CheckHandle(_ARG_0_.ballHandle) == false then
            _ARG_0_:GotoState("Idling")
          else
            FruitBall.GetFallPosition(_ARG_0_.ballHandle, _UPVALUE0_)
            if _UPVALUE0_:getx() == _UPVALUE1_:getx() and _UPVALUE0_:getz() == _UPVALUE1_:getz() then
              Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.direction, 10)
              if FruitBall.GetAttainmentTime(_ARG_0_.ballHandle, _UPVALUE1_) <= 40 then
                Entity.SetMotionSpeed(_ARG_0_.myHandle, 2)
                Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
                _ARG_0_.step = 1
              end
            else
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
              _ARG_0_:GotoState("Chases")
            end
          end
        elseif _ARG_0_.step == 1 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    JumpSmash = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.OldDist = 100
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step < 2 and FruitBall.CheckHandle(_ARG_0_.ballHandle) == false and _UPVALUE0_ == false then
          Entity.ClearSpeed(_ARG_0_.myHandle)
          _ARG_0_:GotoState("Idling")
          return
        end
        if _ARG_0_.step == 0 then
          _ARG_0_.chanceBallFrame = FruitBall.GetChanceBallParam(_ARG_0_.ballHandle, _ARG_0_.chanceBallPos)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.chanceBallPos, 10)
          Entity.CalcVelocity(_ARG_0_.myHandle, _UPVALUE1_)
          if Entity.CalcDistance(_ARG_0_.myHandle, _ARG_0_.chanceBallPos) <= 3.5 or Entity.CalcDistance(_ARG_0_.myHandle, _ARG_0_.chanceBallPos) > _ARG_0_.OldDist then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.step = 1
          end
          if Entity.CalcDistance(_ARG_0_.myHandle, _ARG_0_.chanceBallPos) < _ARG_0_.OldDist then
            _ARG_0_.OldDist = Entity.CalcDistance(_ARG_0_.myHandle, _ARG_0_.chanceBallPos)
          end
        elseif _ARG_0_.step == 1 then
          _ARG_0_.chanceBallFrame = FruitBall.GetChanceBallParam(_ARG_0_.ballHandle, _ARG_0_.chanceBallPos)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          if _ARG_0_.chanceBallFrame < 15 then
            Entity.GetWorldPos(_UPVALUE3_, _ARG_0_.myHandle)
            _UPVALUE3_:sety(0)
            _ARG_0_.chanceBallPos:sety(0)
            FVECTOR3.Sub(_UPVALUE4_, _ARG_0_.chanceBallPos, _UPVALUE3_)
            FVECTOR3.normalize(_UPVALUE4_)
            if 3.5 < Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.chanceBallPos) then
              Entity.ClearSpeed(_ARG_0_.myHandle)
              _ARG_0_:GotoState("Idling")
              return
            end
            FVECTOR3.Scale(_UPVALUE4_, _UPVALUE4_, Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.chanceBallPos) / 14)
            _UPVALUE5_:set(_UPVALUE4_:getx(), 0.3, _UPVALUE4_:getz())
            Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE5_)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE6_, 0, -1, 1)
            _ARG_0_.attackKind = 2
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          if _UPVALUE0_ == true then
            Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE7_)
            Entity.SetOldLocalPos(_ARG_0_.myHandle, _UPVALUE7_)
          end
          Entity.ClearSpeed(_ARG_0_.myHandle)
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    Diving = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.OldDist = 400
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if FruitBall.CheckHandle(_ARG_0_.ballHandle) == false then
            Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
            _ARG_0_:GotoState("Idling")
          else
            Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.ballHandle, 10)
            if FruitBall.GetAttainmentTime(_ARG_0_.ballHandle, _UPVALUE0_) < 40 then
              _ARG_0_.attackKind = 3
              Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE0_, 10)
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
              _ARG_0_.step = 1
            end
          end
        elseif _ARG_0_.step == 1 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE0_, 10)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 5 then
            _ARG_0_.attackKind = 3
            Entity.SetMotionSpeed(_ARG_0_.myHandle, 0)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE0_, 10)
          Entity.CalcVelocity(_ARG_0_.myHandle, _UPVALUE2_)
          if Entity.CalcDistance(_ARG_0_.myHandle, _UPVALUE0_) <= _UPVALUE3_ or Entity.CalcDistance(_ARG_0_.myHandle, _UPVALUE0_) > _ARG_0_.OldDist then
            Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.attackKind = 3
            _ARG_0_.step = 3
          end
          if Entity.CalcDistance(_ARG_0_.myHandle, _UPVALUE0_) < _ARG_0_.OldDist then
            _ARG_0_.OldDist = Entity.CalcDistance(_ARG_0_.myHandle, _UPVALUE0_)
          end
        elseif _ARG_0_.step == 3 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    NomalDamage = {
      OnBeginState = function(_ARG_0_)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 10 then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
          _ARG_0_.step = 11
        elseif _ARG_0_.step == 11 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
            _ARG_0_:GotoState("Idling")
          end
        elseif _ARG_0_.step == 20 then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
          _ARG_0_.step = 21
        elseif _ARG_0_.step == 21 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    Faint = {
      OnBeginState = function(_ARG_0_)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.WaitTimer = Script.RandomInRange(120, 240)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsMotionLoop(_ARG_0_.myHandle) then
            _ARG_0_.WaitTimer = _ARG_0_.WaitTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
            if 0 > _ARG_0_.WaitTimer then
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
              _ARG_0_.step = 1
            end
          end
        elseif _ARG_0_.step == 1 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    Slipping = {
      OnBeginState = function(_ARG_0_)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.WaitTimer = Script.RandomInRange(360, 480)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsMotionLoop(_ARG_0_.myHandle) then
            _ARG_0_.WaitTimer = _ARG_0_.WaitTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
            if 0 > _ARG_0_.WaitTimer then
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
              _ARG_0_.step = 1
            end
          end
        elseif _ARG_0_.step == 1 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    DebugIdling = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
      end
    },
    Dead = {
      OnBeginState = function(_ARG_0_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
      end
    }
  },
  setTossBall = function(_ARG_0_, _ARG_1_)
    FVECTOR3.new(0, 0, 0):setx(Script.RandomInRange(-3, 3))
    if _ARG_0_.Court == _UPVALUE0_ then
      FVECTOR3.new(0, 0, 0):setz(-10)
    else
      FVECTOR3.new(0, 0, 0):setz(10)
    end
    FruitBall.SetBallTargetPosition(_ARG_1_, (FVECTOR3.new(0, 0, 0)))
    FruitBall.SetChanceBall(_ARG_1_)
  end,
  setBallKnid = function(_ARG_0_, _ARG_1_, _ARG_2_)
    if _UPVALUE0_ == true then
      _ARG_0_:setTossBall(_ARG_1_)
      return
    end
    if _ARG_2_ == 0 then
      if Script.Random() < 0.15 then
        _ARG_0_:setTossBall(_ARG_1_)
      else
        FruitBall.SetBallDamage(_ARG_1_, _UPVALUE1_)
      end
    elseif _ARG_2_ == 1 then
      if Script.Random() < 0.5 then
        _ARG_0_:setTossBall(_ARG_1_)
      else
        FruitBall.SetBallDamage(_ARG_1_, _UPVALUE2_)
      end
    elseif _ARG_2_ == 2 then
      FruitBall.SetBallDamage(_ARG_1_, _UPVALUE3_)
    elseif _ARG_2_ == 3 then
      _ARG_0_:setTossBall(_ARG_1_)
    end
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    print("\131L\131\131\131v\131e\131\147\131W\131\131\131X\131e\131B\131X/\131t\131\139\129[\131c\131{\129[\131\139 ... \143\137\138\250\137\187\n")
    _UPVALUE0_ = Entity.GetMotionIndex(_ARG_1_, "010")
    _UPVALUE1_ = Entity.GetMotionIndex(_ARG_1_, "020")
    _UPVALUE2_ = Entity.GetMotionIndex(_ARG_1_, "021")
    _UPVALUE3_ = Entity.GetMotionIndex(_ARG_1_, "040")
    _UPVALUE4_ = Entity.GetMotionIndex(_ARG_1_, "200")
    _UPVALUE5_ = Entity.GetMotionIndex(_ARG_1_, "202")
    _UPVALUE6_ = Entity.GetMotionIndex(_ARG_1_, "222")
    _UPVALUE7_ = Entity.GetMotionIndex(_ARG_1_, "223")
    _UPVALUE8_ = Entity.GetMotionIndex(_ARG_1_, "230")
    _UPVALUE9_ = Entity.GetMotionIndex(_ARG_1_, "231")
    _UPVALUE10_ = Entity.GetMotionIndex(_ARG_1_, "300")
    _UPVALUE11_ = Entity.GetMotionIndex(_ARG_1_, "310")
    _UPVALUE12_ = Entity.GetMotionIndex(_ARG_1_, "320")
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.parentHandle = EntityManager:GetEntity(Entity.GetParent(_ARG_0_.myHandle))
    _ARG_0_.targetHandle = 0
    _ARG_0_.ballHandle = 0
    _ARG_0_.step = 0
    _ARG_0_.Court = _UPVALUE13_
    _ARG_0_.chanceBallPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.chanceBallFrame = 0
    _ARG_0_.OldDist = 0
    _ARG_0_.endstep = 0
    _ARG_0_.attackKind = 0
    if _ARG_0_.Court == _UPVALUE13_ then
      _ARG_0_.direction = _UPVALUE14_
    else
      _ARG_0_.direction = _UPVALUE15_
    end
    _ARG_0_.debug_frame = 0
    Entity.ClearSpeed(_ARG_0_.myHandle)
    Entity.EnableGravity(_ARG_0_.myHandle, 1)
    Entity.EnableBgColl(_ARG_0_.myHandle, 1)
    Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
    Entity.EnableBarrier(_ARG_0_.myHandle, 1)
    Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
    print("\143\137\138\250\137\187 (\129E\129[\129E)\181\220\175\192\197\165\165\165\n")
    _ARG_0_:GotoState("Appear")
  end,
  OnDamageBefore = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
    if _ARG_1_ == ATK_KIND_STUMBLE then
      _ARG_0_:GotoState("Slipping")
      return 1
    elseif _ARG_1_ == ATK_KIND_FAINT then
      _ARG_0_:GotoState("Faint")
      return 1
    end
    return 0
  end,
  OnHitAttack = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    if Player.GetHandle() == _ARG_1_ then
      return
    end
    _ARG_0_:setBallKnid(_ARG_1_, _ARG_0_.attackKind)
  end,
  OnUpdate = function(_ARG_0_)
    if FruitBall.PlayerWinLose() >= 0 and _ARG_0_:GetState() == "Idling" then
      if _ARG_0_.endstep == 0 then
        if FruitBall.PlayerWinLose() == 1 then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        else
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
        end
        _ARG_0_.endstep = 1
      elseif _ARG_0_.endstep == 1 then
      end
    else
      _ARG_0_:Update()
      _ARG_0_:Debug()
    end
  end,
  Debug = function(_ARG_0_)
    if Script.IsDebugCheckAttack() then
      _UPVALUE0_ = false
      _UPVALUE1_ = false
      if Script.GetDebugAttackNumber() >= 10 then
        if Script.GetDebugAttackNumber() == 10 then
          if _ARG_0_:GetState() ~= "DebugIdling" then
            _ARG_0_:GotoState("DebugIdling")
          end
        elseif Script.GetDebugAttackNumber() == 11 then
          _UPVALUE0_ = true
        elseif Script.GetDebugAttackNumber() == 12 then
          _UPVALUE1_ = true
        end
      end
    else
      _UPVALUE0_ = false
      _UPVALUE1_ = false
      if state == "DebugIdling" then
        _ARG_0_:GotoState("Idling")
      end
    end
  end
}, {__index = __StateMachine})
EntityFactory:Add("b03dc00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
