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
        Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
        Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.myHandle)
        _UPVALUE1_:setx(-6.5)
        _UPVALUE2_:setx(6.5)
        if _UPVALUE0_:getz() > 0 then
          _ARG_0_.Court = _UPVALUE3_
          _ARG_0_.direction = _UPVALUE4_
          print("COURT A\n")
        else
          _ARG_0_.Court = _UPVALUE5_
          _ARG_0_.direction = _UPVALUE6_
          print("COURT B\n")
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
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          _ARG_0_.WaitTimer = _ARG_0_.WaitTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 >= _ARG_0_.WaitTimer then
            Entity.GetWorldPos(_UPVALUE0_, Player.GetHandle())
            if Script.Random() < 0.5 then
              _UPVALUE0_:copy(_UPVALUE1_)
              _ARG_0_.WaitTimer = Script.RandomInRange(30, 60)
            elseif _UPVALUE0_:getx() < -2.5 then
              _UPVALUE0_:copy(_UPVALUE2_)
              _ARG_0_.WaitTimer = Script.RandomInRange(30, 90)
            elseif _UPVALUE0_:getx() > 2.5 then
              _UPVALUE0_:copy(_UPVALUE3_)
              _ARG_0_.WaitTimer = Script.RandomInRange(30, 90)
            else
              _UPVALUE0_:copy(_UPVALUE1_)
              _ARG_0_.WaitTimer = Script.RandomInRange(30, 60)
            end
            if Entity.CalcDistance(_ARG_0_.myHandle, _UPVALUE0_) > _UPVALUE4_ then
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE5_)
              _ARG_0_.step = 1
            end
          end
        elseif _ARG_0_.step == 1 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE0_, 10)
          Entity.CalcVelocity(_ARG_0_.myHandle, _UPVALUE6_)
          if Entity.CalcDistance(_ARG_0_.myHandle, _UPVALUE0_) <= _UPVALUE4_ then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE7_)
            _ARG_0_.step = 0
          end
        elseif _ARG_0_.step == 10 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE7_)
            _ARG_0_.WaitTimer = Script.RandomInRange(30, 90)
            _ARG_0_.step = 0
          end
        end
        if FruitBall.GetPlayerState() == 7 or FruitBall.GetPlayerState() == 2 then
          if _ARG_0_.PlayerStateFlag == false then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE8_)
            _ARG_0_.PlayerStateFlag = true
            _ARG_0_.step = 10
          end
        else
          _ARG_0_.PlayerStateFlag = false
        end
        if _UPVALUE9_ == true then
          return
        end
        if _ARG_0_:checkPlayerSearch() == true then
          return
        end
        _ARG_0_.ballHandle = FruitBall.GetEnemyChance(_ARG_0_.myHandle, _ARG_0_.Court)
        if _ARG_0_.ballHandle ~= NULL_HANDLE then
          _ARG_0_.chanceBallFrame = FruitBall.GetChanceBallParam(_ARG_0_.ballHandle, _ARG_0_.chanceBallPos)
          if 30 <= _ARG_0_.chanceBallFrame then
            _ARG_0_:GotoState("JumpSmash")
            return
          end
        end
        _ARG_0_.ballHandle = FruitBall.SearchNearBall(_ARG_0_.parentHandle.EnemyGoalHand[1], _ARG_0_.Court)
        if _ARG_0_.ballHandle ~= NULL_HANDLE and Entity.CalcDistance(_ARG_0_.parentHandle.EnemyGoalHand[1], _UPVALUE10_) < 4 and 30 < FruitBall.GetAttainmentTime(_ARG_0_.ballHandle, _UPVALUE10_) and Entity.CalcDistance(_ARG_0_.myHandle, _UPVALUE10_) > 6 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.ballHandle, 10)
          _ARG_0_:GotoState("Diving")
          return
        end
        _ARG_0_.ballHandle = FruitBall.SearchNearBall(_ARG_0_.myHandle, _ARG_0_.Court)
        if _ARG_0_.ballHandle ~= NULL_HANDLE then
          FruitBall.GetFallPosition(_ARG_0_.ballHandle, _UPVALUE10_)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE10_, 10)
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
        if _ARG_0_:checkPlayerSearch() == true then
          return
        end
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
          if _ARG_0_:checkPlayerSearch() == true then
            return
          end
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
          if _ARG_0_:checkPlayerSearch() == true then
            return
          end
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
    ReturnDirectShot = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.attackKind = 1
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if FruitBall.SearchDirectShot() == NULL_HANDLE and FruitBall.CheckHandle(_ARG_0_.ballHandle) == false then
          Entity.ClearSpeed(_ARG_0_.myHandle)
          _ARG_0_:GotoState("Idling")
          return
        end
        if _ARG_0_.step == 0 then
          FruitBall.GetFallPosition(_ARG_0_.ballHandle, _UPVALUE0_)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE0_, 10)
          Entity.CalcVelocity(_ARG_0_.myHandle, _UPVALUE1_)
          if Entity.CalcDistance(_ARG_0_.myHandle, _UPVALUE0_) <= _UPVALUE2_ then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.ballHandle, 10)
          if Entity.CalcDistanceXZ(_ARG_0_.ballHandle, _ARG_0_.myHandle) < 4 then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    JumpSmash = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.attackKind = 2
        _ARG_0_.selfSpeed = _UPVALUE1_
        _ARG_0_.OldDist = 100
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        Enemy.EnableInvincible(_ARG_0_.myHandle, 0)
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
          if Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.chanceBallPos) <= 1 then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.step = 1
          end
          if Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.chanceBallPos) > _ARG_0_.OldDist then
            print("\150\218\149W\130\201\147\252\130\234\130\200\130\162 = ", Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.chanceBallPos), " OLD = ", _ARG_0_.OldDist, "\n")
            _ARG_0_.selfSpeed = _ARG_0_.selfSpeed - 0.05
            if _ARG_0_.selfSpeed <= 0.05 then
              Entity.ClearSpeed(_ARG_0_.myHandle)
              _ARG_0_:GotoState("Idling")
              return
            end
          end
          if Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.chanceBallPos) < _ARG_0_.OldDist then
            _ARG_0_.OldDist = Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.chanceBallPos)
          end
        elseif _ARG_0_.step == 1 then
          _ARG_0_.chanceBallFrame = FruitBall.GetChanceBallParam(_ARG_0_.ballHandle, _ARG_0_.chanceBallPos)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          if _ARG_0_.chanceBallFrame < 20 then
            Enemy.EnableInvincible(_ARG_0_.myHandle, 1)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_, 0, -1, 1)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 5 then
            Entity.EnableGravity(_ARG_0_.myHandle, 0)
            Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.chanceBallPos)
            Entity.CalcVelocityY(_ARG_0_.myHandle, 0.3)
            _ARG_0_.step = 3
          end
        elseif _ARG_0_.step == 3 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 12 then
            Entity.SetMotionSpeed(_ARG_0_.myHandle, 0)
            _ARG_0_.WaitTimer = 40
            _ARG_0_.step = 4
          end
        elseif _ARG_0_.step == 4 then
          Entity.GetWorldPos(_UPVALUE4_, _ARG_0_.myHandle)
          if _ARG_0_.chanceBallPos:gety() <= _UPVALUE4_:gety() then
            Entity.EnableGravity(_ARG_0_.myHandle, 1)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Entity.GetWorldPos(FVECTOR3.new(0, 0, 0), _ARG_0_.ballHandle)
            FVECTOR3.new(0, 0, 0):sety(FVECTOR3.new(0, 0, 0):gety() - 0.5)
            if FruitBall.CharCheckCollision(_UPVALUE4_, FVECTOR3.new(0, 0, 0), (FVECTOR3.new(0, 0, 0))) == -1 then
              Entity.ClearSpeed(_ARG_0_.myHandle)
              Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
              Entity.EnableGravity(_ARG_0_.myHandle, 1)
              _ARG_0_.step = 5
              return
            end
            Entity.SetLocalPos(_ARG_0_.myHandle, (FVECTOR3.new(0, 0, 0)))
            Entity.SetOldLocalPos(_ARG_0_.myHandle, (FVECTOR3.new(0, 0, 0)))
            Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
            _ARG_0_.step = 5
          else
            _ARG_0_.WaitTimer = _ARG_0_.WaitTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
            if 0 > _ARG_0_.WaitTimer then
              Entity.ClearSpeed(_ARG_0_.myHandle)
              Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
              Entity.EnableGravity(_ARG_0_.myHandle, 1)
              _ARG_0_.step = 5
            end
          end
        elseif _ARG_0_.step == 5 and Entity.IsMotionEnd(_ARG_0_.myHandle) and Entity.IsGround(_ARG_0_.myHandle) then
          Enemy.EnableInvincible(_ARG_0_.myHandle, 0)
          if _UPVALUE0_ == true then
            Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE5_)
            Entity.SetOldLocalPos(_ARG_0_.myHandle, _UPVALUE5_)
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
        _ARG_0_.attackKind = 3
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if FruitBall.CheckHandle(_ARG_0_.ballHandle) == false then
            _ARG_0_.step = 10
            return
          else
            if _ARG_0_.Court == _UPVALUE0_ and _ARG_0_.DivingPos:getz() < 5 then
              _ARG_0_.step = 10
              return
            end
            if _ARG_0_.Court == _UPVALUE1_ and _ARG_0_.DivingPos:getz() > -5 then
              _ARG_0_.step = 10
              return
            end
            Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.DivingPos, 10)
            if FruitBall.GetAttainmentTime(_ARG_0_.ballHandle, _ARG_0_.DivingPos) < 40 then
              Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
              _ARG_0_.step = 1
            end
          end
        elseif _ARG_0_.step == 1 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.DivingPos, 10)
          if 5 <= Entity.GetMotionNowFrame(_ARG_0_.myHandle) then
            Entity.SetMotionSpeed(_ARG_0_.myHandle, 0)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.DivingPos, 10)
          Entity.CalcVelocity(_ARG_0_.myHandle, _UPVALUE3_)
          if Entity.CalcDistance(_ARG_0_.myHandle, _ARG_0_.DivingPos) <= _UPVALUE4_ or Entity.CalcDistance(_ARG_0_.myHandle, _ARG_0_.DivingPos) > _ARG_0_.OldDist then
            Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.step = 3
          end
          if Entity.CalcDistance(_ARG_0_.myHandle, _ARG_0_.DivingPos) < _ARG_0_.OldDist then
            _ARG_0_.OldDist = Entity.CalcDistance(_ARG_0_.myHandle, _ARG_0_.DivingPos)
          end
        elseif _ARG_0_.step == 3 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_:GotoState("Idling")
          end
        elseif _ARG_0_.step == 10 then
          Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
          Entity.ClearSpeed(_ARG_0_.myHandle)
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    NomalDamage = {
      OnBeginState = function(_ARG_0_)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
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
        print("Faint\n")
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
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
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
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
        print("DebugIdling Start\n")
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      end,
      OnEndState = function(_ARG_0_)
        print("DebugIdling End\n")
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
  checkPlayerSearch = function(_ARG_0_)
    if FruitBall.GetPointDifference() < 2 and FruitBall.SearchDirectShot() ~= NULL_HANDLE then
      FruitBall.GetAttainmentTime(FruitBall.SearchDirectShot(), _ARG_0_.DivingPos)
      if _ARG_0_.Court == _UPVALUE0_ and _ARG_0_.DivingPos:getz() < 5 then
        return false
      end
      if _ARG_0_.Court == _UPVALUE1_ and _ARG_0_.DivingPos:getz() > -5 then
        return false
      end
      _ARG_0_.ballHandle = FruitBall.SearchDirectShot()
      if 2 <= Entity.CalcDistance(_ARG_0_.myHandle, _ARG_0_.DivingPos) then
        _ARG_0_:GotoState("Diving")
      else
        _ARG_0_:GotoState("ReturnDirectShot")
      end
      Entity.ClearSpeed(_ARG_0_.myHandle)
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.DivingPos, 10)
      return true
    end
    return false
  end,
  setBallKnid = function(_ARG_0_, _ARG_1_, _ARG_2_)
    if _UPVALUE0_ == true then
      FruitBall.SetBallDamage(_ARG_1_, _UPVALUE1_)
      return
    end
    if _ARG_2_ == 0 then
      if 0 < FruitBall.GetNetCount() then
        FruitBall.SetBallDamage(_ARG_1_, _UPVALUE2_)
      else
        FruitBall.SetBallDamage(_ARG_1_, _UPVALUE3_)
      end
    elseif _ARG_2_ == 1 then
      if 0 < FruitBall.GetNetCount() then
        FruitBall.SetBallDamage(_ARG_1_, _UPVALUE2_)
      else
        FruitBall.SetBallDamage(_ARG_1_, _UPVALUE3_)
      end
    elseif _ARG_2_ == 2 then
      FruitBall.SetBallDamage(_ARG_1_, _UPVALUE3_)
    elseif _ARG_2_ == 3 then
      if 0 < FruitBall.GetNetCount() then
        FruitBall.SetBallDamage(_ARG_1_, _UPVALUE2_)
      else
        FruitBall.SetBallDamage(_ARG_1_, _UPVALUE1_)
      end
    end
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    print("\131L\131\131\131v\131e\131\147????/\131t\131\139\129[\131c\131{\129[\131\139 ... \143\137\138\250\137\187\n")
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
    _ARG_0_.DivingPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.chanceBallFrame = 0
    _ARG_0_.OldDist = 0
    _ARG_0_.endstep = 0
    _ARG_0_.attackKind = 0
    _ARG_0_.PlayerStateFlag = false
    _ARG_0_.debug_frame = 0
    _ARG_0_.selfSpeed = _UPVALUE14_
    Entity.ClearSpeed(_ARG_0_.myHandle)
    Entity.EnableGravity(_ARG_0_.myHandle, 1)
    Entity.EnableBgColl(_ARG_0_.myHandle, 1)
    Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
    Entity.EnableBarrier(_ARG_0_.myHandle, 1)
    Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
    Entity.SetDamageCollKindForBodyColl(_ARG_0_.myHandle, COLL_KIND_PLAYER)
    print("\143\137\138\250\137\187 (\129E\129[\129E)\181\220\175\192\197\165\165\165\n")
    _ARG_0_:GotoState("Appear")
  end,
  OnDamageBefore = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    if _ARG_0_.endstep == 1 then
      return 1
    end
    Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
    if _ARG_1_ == ATK_KIND_STUMBLE then
      _ARG_0_:GotoState("Slipping")
      return 1
    elseif _ARG_1_ == ATK_KIND_FAINT then
      if _ARG_0_:GetState() ~= "JumpSmash" then
        _ARG_0_:GotoState("Faint")
      end
      return 1
    else
      _ARG_0_:GotoState("Idling")
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
      Entity.ClearSpeed(_ARG_0_.myHandle)
      if _ARG_0_.endstep == 0 then
        if FruitBall.PlayerWinLose() == 1 then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        else
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
        end
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        _ARG_0_.endstep = 1
      elseif _ARG_0_.endstep == 1 then
        if FruitBall.PlayerWinLose() == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        end
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
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
      if _ARG_0_:GetState() == "DebugIdling" then
        _ARG_0_:GotoState("Idling")
      end
    end
  end
}, {__index = __StateMachine})
EntityFactory:Add("b02dc00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b03dc00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
