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
        Entity.GetWorldPos(_ARG_0_.StartPosVec, _ARG_0_.myHandle)
        if _ARG_0_.StartPosVec:getz() > 0 then
          _ARG_0_.Court = _UPVALUE0_
        else
          _ARG_0_.Court = _UPVALUE1_
        end
        _ARG_0_:GotoState("Idling")
      end
    },
    Idling = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.WaitTimer = Script.RandomInRange(180, 360)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.parentHandle.step == 0 then
          return
        end
        if _ARG_0_.step == 0 then
          _ARG_0_.WaitTimer = _ARG_0_.WaitTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 >= _ARG_0_.WaitTimer then
            if Entity.CalcDistance(_ARG_0_.myHandle, _ARG_0_.StartPosVec) > _UPVALUE0_ then
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
              _ARG_0_.step = 1
            else
              _ARG_0_.WaitTimer = Script.RandomInRange(300, 600)
              _ARG_0_.step = 2
            end
          end
        elseif _ARG_0_.step == 1 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.StartPosVec, 10)
          Entity.CalcVelocity(_ARG_0_.myHandle, _UPVALUE2_)
          if Entity.CalcDistance(_ARG_0_.myHandle, _ARG_0_.StartPosVec) <= _UPVALUE0_ then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
            _ARG_0_.WaitTimer = Script.RandomInRange(300, 600)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          _ARG_0_.WaitTimer = _ARG_0_.WaitTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 >= _ARG_0_.WaitTimer then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
            Entity.GetWorldPos(_ARG_0_.IdolStartVect, _ARG_0_.myHandle)
            _ARG_0_.MoveDist = Script.RandomInRange(2, 3)
            _ARG_0_.step = 3
          end
        elseif _ARG_0_.step == 3 then
          Entity.CalcVelocity(_ARG_0_.myHandle, _UPVALUE2_)
          if Entity.CalcDistance(_ARG_0_.myHandle, _ARG_0_.IdolStartVect) > _ARG_0_.MoveDist then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
            _ARG_0_.WaitTimer = Script.RandomInRange(300, 600)
            _ARG_0_.step = 0
          end
        end
        if _UPVALUE4_ == NULL_HANDLE then
          _UPVALUE4_ = FruitBall.GetEnemyChance(_ARG_0_.myHandle, _ARG_0_.Court)
          if _UPVALUE4_ ~= NULL_HANDLE and FruitBall.GetChanceBallParam(_UPVALUE4_, _ARG_0_.WorkVec0) >= 40 then
            _ARG_0_.ballHandle = _UPVALUE4_
            _ARG_0_:GotoState("Smash")
            return
          end
          _UPVALUE4_ = NULL_HANDLE
        end
        _ARG_0_.ballHandle = FruitBall.SearchNearBall(_ARG_0_.myHandle, _ARG_0_.Court)
        if _ARG_0_.ballHandle ~= NULL_HANDLE then
          if FruitBall.PushKeepBallHand(_ARG_0_.ballHandle) == false then
            return
          end
          FruitBall.GetFallPosition(_ARG_0_.ballHandle, _ARG_0_.WorkVec0)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.WorkVec0, 10)
          _ARG_0_:GotoState("Chases")
        end
      end
    },
    Chases = {
      OnBeginState = function(_ARG_0_)
        if _ARG_0_.Court == _UPVALUE0_ then
          _ARG_0_.WorkVec2 = _UPVALUE1_
        else
          _ARG_0_.WorkVec2 = _UPVALUE2_
        end
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if FruitBall.CheckHandle(_ARG_0_.ballHandle, _ARG_0_.Court) == false then
          FruitBall.PopKeepBallHand(_ARG_0_.ballHandle)
          Entity.ClearSpeed(_ARG_0_.myHandle)
          _ARG_0_:GotoState("Idling")
        else
          FruitBall.GetFallPosition(_ARG_0_.ballHandle, _ARG_0_.WorkVec0)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.WorkVec0, 10)
          Entity.CalcVelocity(_ARG_0_.myHandle, _UPVALUE0_)
          if Entity.CalcDistance(_ARG_0_.myHandle, _ARG_0_.WorkVec0) < 4 and FruitBall.GetBallSpeed(_ARG_0_.ballHandle) < 0.05 then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_:GotoState("HipAttack")
          elseif Entity.CalcDistance(_ARG_0_.myHandle, _ARG_0_.WorkVec0) <= _UPVALUE2_ then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            if Script.Random() < 0.34 then
              _ARG_0_:GotoState("RushAttack")
            else
              _ARG_0_:GotoState("BallBeatting")
            end
          end
        end
      end
    },
    BallBeatting = {
      OnBeginState = function(_ARG_0_)
        if _ARG_0_.Court == _UPVALUE0_ then
          _ARG_0_.WorkVec2 = _UPVALUE1_
        else
          _ARG_0_.WorkVec2 = _UPVALUE2_
        end
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        FruitBall.PopKeepBallHand(_ARG_0_.ballHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if FruitBall.CheckHandle(_ARG_0_.ballHandle) == false then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_:GotoState("Idling")
          else
            FruitBall.GetFallPosition(_ARG_0_.ballHandle, _ARG_0_.WorkVec1)
            if _ARG_0_.WorkVec1:getx() == _ARG_0_.WorkVec0:getx() and _ARG_0_.WorkVec1:getz() == _ARG_0_.WorkVec0:getz() then
              Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.WorkVec2, 10)
              if FruitBall.GetAttainmentTime(_ARG_0_.ballHandle, _ARG_0_.WorkVec0) <= 50 then
                Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
                _ARG_0_.attackKind = 1
                _ARG_0_.step = 1
              end
            else
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
              _ARG_0_:GotoState("Chases")
            end
          end
        elseif _ARG_0_.step == 1 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    HipAttack = {
      OnBeginState = function(_ARG_0_)
        print("HipAttack\n")
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        print("HipAttack end....\n")
        FruitBall.PopKeepBallHand(_ARG_0_.ballHandle)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 52 then
          Entity.ClearSpeed(_ARG_0_.myHandle)
          _ARG_0_:GotoState("Idling")
        elseif FruitBall.CheckHandle(_ARG_0_.ballHandle) == false then
          FruitBall.PopKeepBallHand(_ARG_0_.ballHandle)
          _ARG_0_.ballHandle = FruitBall.SearchNearBall(_ARG_0_.myHandle, _ARG_0_.Court)
          if _ARG_0_.ballHandle ~= NULL_HANDLE and FruitBall.PushKeepBallHand(_ARG_0_.ballHandle) == false then
            _ARG_0_.ballHandle = NULL_HANDLE
          end
        else
          FruitBall.GetFallPosition(_ARG_0_.ballHandle, _ARG_0_.WorkVec0)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.WorkVec0, 10)
          Entity.CalcVelocity(_ARG_0_.myHandle, _UPVALUE0_)
          _ARG_0_.attackKind = 3
          if Entity.CalcDistance(_ARG_0_.myHandle, _ARG_0_.WorkVec0) < 1 then
            FruitBall.PopKeepBallHand(_ARG_0_.ballHandle)
            _ARG_0_.ballHandle = FruitBall.SearchNearBall(_ARG_0_.myHandle, _ARG_0_.Court)
            if _ARG_0_.ballHandle ~= NULL_HANDLE and FruitBall.PushKeepBallHand(_ARG_0_.ballHandle) == false then
              _ARG_0_.ballHandle = NULL_HANDLE
            end
          end
        end
      end
    },
    RushAttack = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetMotionSpeed(_ARG_0_.myHandle, 2)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        FruitBall.PopKeepBallHand(_ARG_0_.ballHandle)
        Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if FruitBall.CheckHandle(_ARG_0_.ballHandle) == false then
          FruitBall.PopKeepBallHand(_ARG_0_.ballHandle)
          _ARG_0_.ballHandle = FruitBall.SearchNearBall(_ARG_0_.myHandle, _ARG_0_.Court)
          if _ARG_0_.ballHandle ~= NULL_HANDLE and FruitBall.PushKeepBallHand(_ARG_0_.ballHandle) == false then
            _ARG_0_.ballHandle = NULL_HANDLE
          end
        end
        if _ARG_0_.step == 0 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
            _ARG_0_.timer = Script.RandomInRange(120, 180)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if _ARG_0_.ballHandle == NULL_HANDLE then
            _ARG_0_.WorkVec0:copy(_ARG_0_.StartPosVec)
          else
            FruitBall.GetFallPosition(_ARG_0_.ballHandle, _ARG_0_.WorkVec0)
          end
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.WorkVec0, 10)
          Entity.CalcVelocity(_ARG_0_.myHandle, _UPVALUE1_)
          _ARG_0_.attackKind = 0
          if Entity.CalcDistance(_ARG_0_.myHandle, _ARG_0_.WorkVec0) < 2 then
            FruitBall.PopKeepBallHand(_ARG_0_.ballHandle)
            _ARG_0_.ballHandle = FruitBall.SearchNearBall(_ARG_0_.myHandle, _ARG_0_.Court)
            if _ARG_0_.ballHandle ~= NULL_HANDLE and FruitBall.PushKeepBallHand(_ARG_0_.ballHandle) == false then
              _ARG_0_.ballHandle = NULL_HANDLE
            end
          end
          _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 >= _ARG_0_.timer then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    Smash = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.selfSpeed = _UPVALUE1_
        _ARG_0_.OldDist = 100
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        FruitBall.PopKeepBallHand(_ARG_0_.ballHandle)
        _UPVALUE0_ = NULL_HANDLE
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step < 2 and FruitBall.CheckHandle(_UPVALUE0_) == false and _UPVALUE1_ == false then
          _UPVALUE0_ = NULL_HANDLE
          Entity.ClearSpeed(_ARG_0_.myHandle)
          _ARG_0_:GotoState("Idling")
        end
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.WorkVec0, 10)
          Entity.CalcVelocity(_ARG_0_.myHandle, _ARG_0_.selfSpeed)
          if Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec0) <= 1 then
            print("\150\218\149W\130\201\147\252\130\193\130\189 = ", Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec0), "\n")
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.step = 1
          end
          if Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec0) > _ARG_0_.OldDist then
            print("\150\218\149W\130\201\147\252\130\234\130\200\130\162 = ", Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec0), " OLD = ", _ARG_0_.OldDist, "\n")
            _ARG_0_.selfSpeed = _ARG_0_.selfSpeed - 0.05
            if _ARG_0_.selfSpeed <= 0.05 then
              _UPVALUE0_ = NULL_HANDLE
              Entity.ClearSpeed(_ARG_0_.myHandle)
              _ARG_0_:GotoState("Idling")
              return
            end
          end
          if Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec0) < _ARG_0_.OldDist then
            _ARG_0_.OldDist = Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec0)
          end
        elseif _ARG_0_.step == 1 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          if FruitBall.GetChanceBallParam(_UPVALUE0_, _ARG_0_.WorkVec0) < 20 then
            Entity.GetWorldPos(_ARG_0_.WorkVec2, _ARG_0_.myHandle)
            _ARG_0_.WorkVec2:sety(0)
            _ARG_0_.WorkVec0:sety(0)
            FVECTOR3.Sub(_ARG_0_.WorkVec1, _ARG_0_.WorkVec0, _ARG_0_.WorkVec2)
            FVECTOR3.normalize(_ARG_0_.WorkVec1)
            if Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec0) > 3.5 then
              _UPVALUE0_ = NULL_HANDLE
              Entity.ClearSpeed(_ARG_0_.myHandle)
              _ARG_0_:GotoState("Idling")
              return
            end
            FVECTOR3.Scale(_ARG_0_.WorkVec1, _ARG_0_.WorkVec1, Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec0) / 14)
            _ARG_0_.WorkVec0:set(_ARG_0_.WorkVec1:getx(), 0.3, _ARG_0_.WorkVec1:getz())
            Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.WorkVec0)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
            _ARG_0_.attackKind = 2
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 and Entity.IsMotionEnd(_ARG_0_.myHandle) and Entity.IsGround(_ARG_0_.myHandle) then
          if _UPVALUE1_ == true then
            Entity.SetLocalPos(_ARG_0_.myHandle, _ARG_0_.StartPosVec)
            Entity.SetOldLocalPos(_ARG_0_.myHandle, _ARG_0_.StartPosVec)
          end
          _UPVALUE0_ = NULL_HANDLE
          Entity.ClearSpeed(_ARG_0_.myHandle)
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    NomalDamage = {
      OnBeginState = function(_ARG_0_)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
        FruitBall.PopKeepBallHand(_ARG_0_.ballHandle)
        print("NomalDamage start...\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        print("NomalDamage end...\n")
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 10 then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
          _ARG_0_.step = 11
        elseif _ARG_0_.step == 11 then
          if Entity.IsMotionLoop(_ARG_0_.myHandle) then
            Entity.SetMotionSpeed(_ARG_0_.myHandle, 1.5)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
            _ARG_0_.step = 12
          end
        elseif _ARG_0_.step == 12 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
            _ARG_0_:GotoState("Idling")
          end
        elseif _ARG_0_.step == 20 then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
          _ARG_0_.step = 21
        elseif _ARG_0_.step == 21 then
          if Entity.IsMotionLoop(_ARG_0_.myHandle) then
            Entity.SetMotionSpeed(_ARG_0_.myHandle, 1.5)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
            _ARG_0_.step = 22
          end
        elseif _ARG_0_.step == 22 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    Faint = {
      OnBeginState = function(_ARG_0_)
        print("Faint\n")
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        FruitBall.PopKeepBallHand(_ARG_0_.ballHandle)
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
        print("Slipping\n")
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        FruitBall.PopKeepBallHand(_ARG_0_.ballHandle)
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
        Entity.SetLocalPos(_ARG_0_.myHandle, _ARG_0_.StartPosVec)
        Entity.SetOldLocalPos(_ARG_0_.myHandle, _ARG_0_.StartPosVec)
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
      FruitBall.SetBallDamage(_ARG_1_, _UPVALUE1_)
      return
    end
    if _ARG_2_ == 0 then
      FruitBall.SetBallDamage(_ARG_1_, _UPVALUE2_)
    elseif _ARG_2_ == 1 then
      FruitBall.SetBallDamage(_ARG_1_, _UPVALUE3_)
    elseif _ARG_2_ == 2 then
      FruitBall.SetBallDamage(_ARG_1_, _UPVALUE4_)
    elseif _ARG_2_ == 3 then
      FruitBall.SetBallDamage(_ARG_1_, _UPVALUE2_)
    end
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    print("\131f\131u\131A\131\147\131o\129[\131X/\131t\131\139\129[\131c\131{\129[\131\139 ... \143\137\138\250\137\187\n")
    _UPVALUE0_ = Entity.GetMotionIndex(_ARG_1_, "010")
    _UPVALUE1_ = Entity.GetMotionIndex(_ARG_1_, "030")
    _UPVALUE2_ = Entity.GetMotionIndex(_ARG_1_, "040")
    _UPVALUE3_ = Entity.GetMotionIndex(_ARG_1_, "050")
    _UPVALUE4_ = Entity.GetMotionIndex(_ARG_1_, "220")
    _UPVALUE5_ = Entity.GetMotionIndex(_ARG_1_, "221")
    _UPVALUE6_ = Entity.GetMotionIndex(_ARG_1_, "222")
    _UPVALUE7_ = Entity.GetMotionIndex(_ARG_1_, "223")
    _UPVALUE8_ = Entity.GetMotionIndex(_ARG_1_, "230")
    _UPVALUE9_ = Entity.GetMotionIndex(_ARG_1_, "231")
    _UPVALUE10_ = Entity.GetMotionIndex(_ARG_1_, "232")
    _UPVALUE11_ = Entity.GetMotionIndex(_ARG_1_, "233")
    _UPVALUE12_ = Entity.GetMotionIndex(_ARG_1_, "300")
    _UPVALUE13_ = Entity.GetMotionIndex(_ARG_1_, "301")
    _UPVALUE14_ = Entity.GetMotionIndex(_ARG_1_, "302")
    _UPVALUE15_ = Entity.GetMotionIndex(_ARG_1_, "303")
    _UPVALUE16_ = Entity.GetMotionIndex(_ARG_1_, "304")
    _UPVALUE17_ = Entity.GetMotionIndex(_ARG_1_, "305")
    _UPVALUE18_ = Entity.GetMotionIndex(_ARG_1_, "315")
    _UPVALUE19_ = Entity.GetMotionIndex(_ARG_1_, "400")
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.parentHandle = EntityManager:GetEntity(Entity.GetParent(_ARG_0_.myHandle))
    _ARG_0_.targetHandle = NULL_HANDLE
    _ARG_0_.ballHandle = NULL_HANDLE
    _ARG_0_.step = 0
    _ARG_0_.Court = _UPVALUE20_
    _ARG_0_.partnerHandle = 0
    _ARG_0_.endstep = 0
    _ARG_0_.WorkVec0 = FVECTOR3.new(0, 0, 0)
    _ARG_0_.WorkVec1 = FVECTOR3.new(0, 0, 0)
    _ARG_0_.WorkVec2 = FVECTOR3.new(0, 0, 0)
    _ARG_0_.StartPosVec = FVECTOR3.new(0, 0, 0)
    _ARG_0_.IdolStartVect = FVECTOR3.new(0, 0, 0)
    _ARG_0_.MoveDist = 0
    _ARG_0_.debug_frame = 0
    Entity.ClearSpeed(_ARG_0_.myHandle)
    Entity.EnableGravity(_ARG_0_.myHandle, 1)
    Entity.EnableBgColl(_ARG_0_.myHandle, 1)
    Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
    Entity.EnableBarrier(_ARG_0_.myHandle, 1)
    Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
    Entity.SetDamageCollKindForBodyColl(_ARG_0_.myHandle, COLL_KIND_PLAYER)
    Entity.SetMovementCollRadius(_ARG_0_.myHandle, 1)
    Entity.SetLowerHalf(_ARG_0_.myHandle, 1.5)
    print("\143\137\138\250\137\187 (\129E\129[\129E)\181\220\175\192\197\165\165\165\n")
    _ARG_0_:GotoState("Appear")
  end,
  OnDamageBefore = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    if _ARG_0_.endstep == 1 then
      return 1
    end
    print("OnDamageBefore kind = ", _ARG_1_, " category = ", _ARG_2_, " attr = ", _ARG_3_, "\n")
    Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
    if _ARG_1_ == ATK_KIND_STUMBLE then
      _ARG_0_:GotoState("Slipping")
      return 1
    elseif _ARG_1_ == ATK_KIND_FAINT then
      _ARG_0_:GotoState("Faint")
      return 1
    else
      if Enemy.IsAttackerFront(_ARG_0_.myHandle) == true then
        _ARG_0_.step = 10
      else
        _ARG_0_.step = 20
      end
      _ARG_0_:GotoState("NomalDamage")
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
EntityFactory:Add("m03dc00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
