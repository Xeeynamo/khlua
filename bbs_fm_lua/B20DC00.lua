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
        Entity.GetWorldPos(_UPVALUE3_, _ARG_0_.myHandle)
        _UPVALUE1_:setx(0)
        _UPVALUE2_:setx(-6.5)
        _UPVALUE3_:setx(6.5)
        if 0 < _UPVALUE0_:getz() then
          _ARG_0_.Court = _UPVALUE4_
        else
          _ARG_0_.Court = _UPVALUE5_
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
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          _ARG_0_.WaitTimer = _ARG_0_.WaitTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 >= _ARG_0_.WaitTimer then
            Entity.GetWorldPos(_UPVALUE0_, Player.GetHandle())
            if Script.Random() < 0.2 then
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
        end
        _ARG_0_.ballHandle = FruitBall.GetEnemyChance(_ARG_0_.myHandle, _ARG_0_.Court)
        if _ARG_0_.ballHandle ~= NULL_HANDLE then
          if _ARG_0_.ballHandle ~= FruitBall.GetSmashBallHand() then
            return
          end
          _ARG_0_.chanceBallFrame = FruitBall.GetChanceBallParam(_ARG_0_.ballHandle, _UPVALUE8_)
          if 60 <= _ARG_0_.chanceBallFrame then
            _ARG_0_:GotoState("JumpSmash")
            return
          end
        end
        _ARG_0_.ballHandle = FruitBall.SearchNearBall(_ARG_0_.myHandle, _ARG_0_.Court, (FruitBall.GetSmashBallHand()))
        if _ARG_0_.ballHandle ~= NULL_HANDLE then
          FruitBall.GetFallPosition(_ARG_0_.ballHandle, _UPVALUE8_)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE8_, 10)
          if _ARG_0_.ballHandle == FruitBall.GetSmashBallHand() then
            FruitBall.SetSmashBallHand(NULL_HANDLE)
          end
          _ARG_0_:GotoState("Chases")
        end
      end
    },
    Chases = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        if _ARG_0_.ballHandle == FruitBall.GetSmashBallHand() then
          FruitBall.SetSmashBallHand(NULL_HANDLE)
        end
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
            if _UPVALUE4_ == true then
              _ARG_0_:GotoState("Toss")
            else
              if FruitBall.GetBallSpeed(_ARG_0_.ballHandle) < 0.05 then
                Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE0_)
                Entity.SetOldLocalPos(_ARG_0_.myHandle, _UPVALUE0_)
              end
              if EntityManager:GetEntity(_ARG_0_.partnerHandle):GetState() == "Idling" or EntityManager:GetEntity(_ARG_0_.partnerHandle):GetState() == "Chases" or EntityManager:GetEntity(_ARG_0_.partnerHandle):GetState() == "BallBeatting" then
                if Script.Random() < 0.07 then
                  _ARG_0_:GotoState("Idling")
                elseif Script.Random() < 0.18 then
                  _ARG_0_:GotoState("BallBeatting")
                else
                  _ARG_0_:GotoState("Toss")
                end
              else
                _ARG_0_:GotoState("BallBeatting")
              end
            end
          end
        end
      end
    },
    BallBeatting = {
      OnBeginState = function(_ARG_0_)
        if _ARG_0_.Court == _UPVALUE0_ then
          _UPVALUE1_ = _UPVALUE2_
        else
          _UPVALUE1_ = _UPVALUE3_
        end
        if _ARG_0_.ballHandle == FruitBall.GetSmashBallHand() then
          FruitBall.SetSmashBallHand(NULL_HANDLE)
        end
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if FruitBall.CheckHandle(_ARG_0_.ballHandle) == false then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_:GotoState("Idling")
          else
            FruitBall.GetFallPosition(_ARG_0_.ballHandle, _UPVALUE0_)
            if _UPVALUE0_:getx() == _UPVALUE1_:getx() and _UPVALUE0_:getz() == _UPVALUE1_:getz() then
              Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE2_, 10)
              if FruitBall.GetAttainmentTime(_ARG_0_.ballHandle, _UPVALUE1_) <= 50 then
                Entity.ClearSpeed(_ARG_0_.myHandle)
                Entity.EnableGravity(_ARG_0_.myHandle, 0)
                Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
                _UPVALUE1_:sety(1)
                Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE1_)
                Entity.SetOldLocalPos(_ARG_0_.myHandle, _UPVALUE1_)
                Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
                _ARG_0_.attackKind = 0
                _ARG_0_.step = 1
              end
            else
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE4_)
              _ARG_0_:GotoState("Chases")
            end
          end
        elseif _ARG_0_.step == 1 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Entity.EnableGravity(_ARG_0_.myHandle, 1)
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    Toss = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        if _ARG_0_.ballHandle == FruitBall.GetSmashBallHand() then
          FruitBall.SetSmashBallHand(NULL_HANDLE)
        end
        _ARG_0_.attackKind = 3
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if FruitBall.CheckHandle(_ARG_0_.ballHandle) == false and _UPVALUE0_ == false then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_:GotoState("Idling")
          else
            Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
            if FruitBall.GetChanceBallParam(_ARG_0_.ballHandle, _UPVALUE1_) < 10 then
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
              _ARG_0_.step = 1
            end
          end
        elseif _ARG_0_.step == 1 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE4_)
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    JumpSmash = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.selfSpeed = _UPVALUE1_
        _ARG_0_.OldDist = 100
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
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
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE1_, 10)
          Entity.CalcVelocity(_ARG_0_.myHandle, _ARG_0_.selfSpeed)
          if Entity.CalcDistance(_ARG_0_.myHandle, _UPVALUE1_) <= 1 then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.step = 1
          end
          if Entity.CalcDistance(_ARG_0_.myHandle, _UPVALUE1_) > _ARG_0_.OldDist then
            _ARG_0_.selfSpeed = _ARG_0_.selfSpeed - 0.05
            if _ARG_0_.selfSpeed <= 0.05 then
              Entity.ClearSpeed(_ARG_0_.myHandle)
              _ARG_0_:GotoState("Idling")
              return
            end
          end
          if Entity.CalcDistance(_ARG_0_.myHandle, _UPVALUE1_) < _ARG_0_.OldDist then
            _ARG_0_.OldDist = Entity.CalcDistance(_ARG_0_.myHandle, _UPVALUE1_)
          end
        elseif _ARG_0_.step == 1 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          if FruitBall.GetChanceBallParam(_ARG_0_.ballHandle, _UPVALUE1_) < 40 then
            Enemy.EnableInvincible(_ARG_0_.myHandle, 1)
            Entity.GetWorldPos(_UPVALUE3_, _ARG_0_.myHandle)
            _UPVALUE3_:sety(0)
            _UPVALUE1_:sety(0)
            FVECTOR3.Sub(_UPVALUE4_, _UPVALUE1_, _UPVALUE3_)
            FVECTOR3.normalize(_UPVALUE4_)
            if Entity.CalcDistanceXZ(_ARG_0_.myHandle, _UPVALUE1_) > 3.5 then
              Entity.ClearSpeed(_ARG_0_.myHandle)
              _ARG_0_:GotoState("Idling")
              return
            end
            FVECTOR3.Scale(_UPVALUE4_, _UPVALUE4_, Entity.CalcDistanceXZ(_ARG_0_.myHandle, _UPVALUE1_) / 14)
            _UPVALUE1_:set(_UPVALUE4_:getx(), 0.35, _UPVALUE4_:getz())
            Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE1_)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE5_)
            _ARG_0_.attackKind = 2
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE6_)
            _ARG_0_.step = 3
          end
        elseif _ARG_0_.step == 3 then
          Entity.GetVelocity(_UPVALUE3_, _ARG_0_.myHandle)
          if _UPVALUE3_:gety() < 0.01 then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Entity.EnableGravity(_ARG_0_.myHandle, 0)
            Entity.GetWorldPos(FVECTOR3.new(0, 0, 0), _ARG_0_.ballHandle)
            FVECTOR3.new(0, 0, 0):sety(FVECTOR3.new(0, 0, 0):gety() - 0.5)
            FruitBall.CharCheckCollision(_UPVALUE3_, FVECTOR3.new(0, 0, 0), (FVECTOR3.new(0, 0, 0)))
            if FruitBall.CharCheckCollision(_UPVALUE3_, FVECTOR3.new(0, 0, 0), (FVECTOR3.new(0, 0, 0))) == -1 then
              Entity.EnableGravity(_ARG_0_.myHandle, 1)
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE6_)
              _ARG_0_.step = 5
              return
            end
            Entity.SetLocalPos(_ARG_0_.myHandle, (FVECTOR3.new(0, 0, 0)))
            Entity.SetOldLocalPos(_ARG_0_.myHandle, (FVECTOR3.new(0, 0, 0)))
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE7_)
            _ARG_0_.step = 4
          end
        elseif _ARG_0_.step == 4 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 27 then
            Entity.SetVelocity(_UPVALUE3_, _ARG_0_.myHandle)
            Entity.EnableGravity(_ARG_0_.myHandle, 1)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE6_)
            _ARG_0_.step = 5
          end
        elseif _ARG_0_.step == 5 then
          if Entity.IsGround(_ARG_0_.myHandle) == true then
            Enemy.EnableInvincible(_ARG_0_.myHandle, 0)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE8_)
            _ARG_0_.step = 6
          end
        elseif _ARG_0_.step == 6 and Entity.IsMotionEnd(_ARG_0_.myHandle) and Entity.IsGround(_ARG_0_.myHandle) then
          if _UPVALUE0_ == true then
            Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE9_)
            Entity.SetOldLocalPos(_ARG_0_.myHandle, _UPVALUE9_)
          end
          Entity.ClearSpeed(_ARG_0_.myHandle)
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    Faint = {
      OnBeginState = function(_ARG_0_)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
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
  setTossBall = function(_ARG_0_, _ARG_1_)
    Entity.GetWorldPos(FVECTOR3.new(0, 0, 0), _ARG_0_.partnerHandle)
    FruitBall.SetBallTargetPosition(_ARG_1_, FVECTOR3.new(0, 0, 0), _UPVALUE0_)
    FruitBall.SetSmashBallHand(_ARG_1_)
    Entity.GetWorldPos(FVECTOR3.new(0, 0, 0), _ARG_0_.myHandle, 5)
    Entity.SetEffect(_ARG_0_.myHandle, "b10dc00", "B10DC_TOS_0_0", FVECTOR3.new(0, 0, 0), (FVECTOR3.new(0, 0, 0)))
  end,
  setBallKnid = function(_ARG_0_, _ARG_1_, _ARG_2_)
    if _ARG_2_ == 0 then
      FruitBall.SetBallDamage(_ARG_1_, _UPVALUE0_)
    elseif _ARG_2_ == 1 then
      FruitBall.SetBallDamage(_ARG_1_, _UPVALUE1_)
    elseif _ARG_2_ == 2 then
      FruitBall.SetBallDamage(_ARG_1_, _UPVALUE2_)
    elseif _ARG_2_ == 3 then
      _ARG_0_:setTossBall(_ARG_1_)
    end
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    print("\131f\129[\131\139/\131t\131\139\129[\131c\131{\129[\131\139 ... \143\137\138\250\137\187\n")
    _UPVALUE0_ = Entity.GetMotionIndex(_ARG_1_, "010")
    _UPVALUE1_ = Entity.GetMotionIndex(_ARG_1_, "020")
    _UPVALUE2_ = Entity.GetMotionIndex(_ARG_1_, "040")
    _UPVALUE3_ = Entity.GetMotionIndex(_ARG_1_, "060")
    _UPVALUE4_ = Entity.GetMotionIndex(_ARG_1_, "061")
    _UPVALUE5_ = Entity.GetMotionIndex(_ARG_1_, "062")
    _UPVALUE6_ = Entity.GetMotionIndex(_ARG_1_, "222")
    _UPVALUE7_ = Entity.GetMotionIndex(_ARG_1_, "223")
    _UPVALUE8_ = Entity.GetMotionIndex(_ARG_1_, "230")
    _UPVALUE9_ = Entity.GetMotionIndex(_ARG_1_, "231")
    _UPVALUE10_ = Entity.GetMotionIndex(_ARG_1_, "300")
    _UPVALUE11_ = Entity.GetMotionIndex(_ARG_1_, "310")
    _UPVALUE12_ = Entity.GetMotionIndex(_ARG_1_, "320")
    _ARG_0_.partnerHandle = 0
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.parentHandle = EntityManager:GetEntity(Entity.GetParent(_ARG_0_.myHandle))
    _ARG_0_.targetHandle = 0
    _ARG_0_.ballHandle = 0
    _ARG_0_.step = 0
    _ARG_0_.Court = _UPVALUE13_
    _ARG_0_.debug_frame = 0
    _ARG_0_.attackKind = 0
    _ARG_0_.endstep = 0
    _ARG_0_.selfSpeed = _UPVALUE14_
    Entity.ClearSpeed(_ARG_0_.myHandle)
    Entity.EnableGravity(_ARG_0_.myHandle, 1)
    Entity.EnableBgColl(_ARG_0_.myHandle, 1)
    Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
    Entity.EnableBarrier(_ARG_0_.myHandle, 1)
    Entity.SetDamageCollKindForBodyColl(_ARG_0_.myHandle, COLL_KIND_PLAYER)
    _ARG_0_:GotoState("Appear")
  end,
  OnDamageBefore = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    if _ARG_0_.endstep == 1 then
      return 1
    end
    Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
    if _ARG_1_ == ATK_KIND_STUMBLE then
      _ARG_0_:GotoState("Slipping")
      return 1
    elseif _ARG_1_ == ATK_KIND_FAINT then
      _ARG_0_:GotoState("Faint")
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
      Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.myHandle)
      if _ARG_0_.Court == _UPVALUE3_ and 0 > _UPVALUE2_:getz() then
        Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE4_)
        Entity.SetOldLocalPos(_ARG_0_.myHandle, _UPVALUE4_)
      elseif _ARG_0_.Court == _UPVALUE5_ and 0 < _UPVALUE2_:getz() then
        Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE6_)
        Entity.SetOldLocalPos(_ARG_0_.myHandle, _UPVALUE6_)
      end
      _ARG_0_:Update()
      _ARG_0_:Debug()
    end
  end,
  OnDestroy = function(_ARG_0_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
    print("\131f\129[\131\139\130\204\141\192\149W[x=", _UPVALUE0_:getx(), " y=", _UPVALUE0_:gety(), " z=", _UPVALUE0_:getz(), " ", "]")
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
EntityFactory:Add("b20dc00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
