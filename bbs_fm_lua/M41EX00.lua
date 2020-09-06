setmetatable({
  new = function(_ARG_0_)
    return setmetatable(__StateMachine:new(), _UPVALUE0_)
  end,
  states = {
    Fly = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.GetVelocity(_UPVALUE0_, _ARG_0_.myHandle)
          if 0 > _UPVALUE0_:gety() then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if Entity.IsGround(_ARG_0_.myHandle) then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
            _ARG_0_.step = 2
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    Appear = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        _ARG_0_:SetupShadow(0.1, 1, Entity.GetMotionTotalFrame(_ARG_0_.myHandle))
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
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
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.atkState = "Idling"
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        if CanDisappear(_ARG_0_.myHandle, _ARG_0_.targetHandle) then
          _ARG_0_:GotoState("Disappear")
          return
        end
        if _ARG_0_.step == 0 then
          Enemy.GetTargetLastRecordedPos(_UPVALUE0_, _ARG_0_.myHandle, _ARG_0_.targetHandle)
          if Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE0_, 10) == false then
            _ARG_0_.step = 1
          end
        else
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        end
        if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) == false then
          return
        end
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE1_ then
          if Script.Random() < _UPVALUE2_ then
            if Script.Random() < _UPVALUE3_ then
              _ARG_0_:GotoState("Scratch")
            elseif Script.Random() >= _UPVALUE3_ and Script.Random() < _UPVALUE3_ + _UPVALUE4_ then
              _ARG_0_:GotoState("ShadowOut")
            else
              _ARG_0_:GotoState("FallScratch")
            end
          else
            if Script.Random() < _UPVALUE5_ then
              _ARG_0_.atkState = "AirRush"
            else
              _ARG_0_.atkState = "FallScratch"
            end
            if Script.Random() < 0.5 then
              _ARG_0_.shadowMoveKind = _UPVALUE6_
            else
              _ARG_0_.shadowMoveKind = _UPVALUE7_
            end
            _ARG_0_:GotoState("ShadowMove")
          end
        elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) >= _UPVALUE1_ and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE8_ then
          if Script.Random() < _UPVALUE9_ then
            if Script.Random() < _UPVALUE10_ then
              _ARG_0_:GotoState("AirRush")
            else
              _ARG_0_:GotoState("FallScratch")
            end
          elseif Script.Random() < _UPVALUE11_ then
            _ARG_0_:GotoState("Running")
          elseif Script.Random() >= _UPVALUE11_ and Script.Random() < _UPVALUE11_ + _UPVALUE12_ then
            _ARG_0_.shadowMoveKind = _UPVALUE13_
            _ARG_0_:GotoState("ShadowMove")
          elseif Script.Random() >= _UPVALUE11_ + _UPVALUE12_ and Script.Random() < _UPVALUE11_ + _UPVALUE12_ + _UPVALUE14_ then
            _ARG_0_:GotoState("SideMove")
          else
            _ARG_0_:GotoState("ZigzagStep")
          end
        elseif Script.Random() < _UPVALUE15_ then
          _ARG_0_:GotoState("Running")
        elseif Script.Random() >= _UPVALUE15_ and Script.Random() < _UPVALUE15_ + _UPVALUE16_ then
          _ARG_0_.shadowMoveKind = _UPVALUE13_
          _ARG_0_:GotoState("ShadowMove")
        else
          _ARG_0_:GotoState("ZigzagStep")
        end
      end
    },
    Running = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        print("Running\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE0_)
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE1_ then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    SideMove = {
      OnBeginState = function(_ARG_0_)
        if Script.Random() < 0.5 then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
          _ARG_0_.velocity:set(1, 0, 0)
        else
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
          _ARG_0_.velocity:set(-1, 0, 0)
        end
        _ARG_0_.velocity:scale(_UPVALUE2_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE3_)
        print("SideMove\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
        Entity.CalcVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
        if Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE0_ then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    ZigzagStep = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.step = 0
        _ARG_0_.timer = 0
        print("ZigzagStep\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.timer <= 0 then
          _ARG_0_.timer = _UPVALUE0_
          _ARG_0_.step = _ARG_0_.step + 1
          if _ARG_0_.step > 1 then
            _ARG_0_.step = 0
          end
          if _ARG_0_.step == 0 then
            _ARG_0_.velocity:set(Math.Cos((DegToRad(90 + _UPVALUE1_))), 0, Math.Sin((DegToRad(90 + _UPVALUE1_))))
          else
            _ARG_0_.velocity:set(Math.Cos((DegToRad(90 - _UPVALUE1_))), 0, Math.Sin((DegToRad(90 - _UPVALUE1_))))
          end
          _ARG_0_.velocity:scale(_UPVALUE2_)
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
        Entity.CalcVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE3_ then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    ShadowMove = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
        _ARG_0_:SetupShadow(1, 0.1, Entity.GetMotionTotalFrame(_ARG_0_.myHandle))
        _ARG_0_.step = 0
        if Script.Random() < 0.5 then
          _ARG_0_.rotSpeed = 1
        else
          _ARG_0_.rotSpeed = -1
        end
        print("ZigzagStep\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if _ARG_0_:UpdateShadowMove() == false or Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
            _ARG_0_:SetupShadow(0.1, 1, Entity.GetMotionTotalFrame(_ARG_0_.myHandle))
            _ARG_0_.step = 2
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.atkState)
        end
      end
    },
    Scratch = {
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
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 12 then
            _ARG_0_.step = 1
          end
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Stiff")
        end
      end
    },
    ShadowOut = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetTimer(_ARG_0_.myHandle, 30)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.targetHandle)
            _UPVALUE2_:copy(_UPVALUE1_)
            _UPVALUE2_:sety(_UPVALUE2_:gety() - 10)
            Collision.IntersectRayBg(_UPVALUE2_, COLL_KIND_ENEMY, _UPVALUE1_, _UPVALUE2_)
            Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE2_)
            Entity.SetOldLocalPos(_ARG_0_.myHandle, _UPVALUE1_)
            FVECTOR3.Sub(_UPVALUE3_, _UPVALUE1_, _UPVALUE2_)
            Entity.SetRot(_ARG_0_.myHandle, 0, Math.Atan2(_UPVALUE3_:getx(), _UPVALUE3_:getz()), 0)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 20 then
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE4_)
            Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
            Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
            Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
            Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
            _ARG_0_.step = 3
          end
        elseif _ARG_0_.step == 3 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE5_)
            _ARG_0_.step = 4
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Stiff")
        end
      end
    },
    AirRush = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
        Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 20)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 50 then
            Entity.SetTimer(_ARG_0_.myHandle, (Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) + 3) / _UPVALUE0_)
            Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE0_)
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.step = 2
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Stiff")
        end
      end
    },
    FallScratch = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          if 10 <= Entity.GetMotionNowFrame(_ARG_0_.myHandle) then
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) * 0.05)
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
            _ARG_0_.step = 2
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
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
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    Disappear = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
        _ARG_0_:SetupShadow(1, 0.1, Entity.GetMotionTotalFrame(_ARG_0_.myHandle))
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, 5)
            Entity.SetMotionSpeed(_ARG_0_.myHandle, 0)
            _ARG_0_.step = 1
          end
        elseif Entity.IsModelFade(_ARG_0_.myHandle) == false then
          Enemy.Disappear(_ARG_0_.myHandle)
        end
      end
    }
  },
  SetupShadow = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    _ARG_0_.scaleTime = _ARG_3_
    _ARG_0_.scaleTimer = _ARG_3_
    _ARG_0_.srcScale:sety(_ARG_1_)
    _ARG_0_.dstScale:sety(_ARG_2_)
  end,
  UpdateShadowMove = function(_ARG_0_)
    if _ARG_0_.shadowMoveKind == _UPVALUE0_ then
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
      Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE1_)
      if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE2_ then
        return false
      end
    elseif _ARG_0_.shadowMoveKind == _UPVALUE3_ then
      Entity.GetWorldPos(_UPVALUE4_, _ARG_0_.myHandle)
      Entity.GetWorldPos(_UPVALUE5_, _ARG_0_.targetHandle)
      FVECTOR3.Sub(_UPVALUE4_, _UPVALUE4_, _UPVALUE5_)
      _UPVALUE4_:normalize()
      _UPVALUE4_:scale(10)
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE4_, 5)
      Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE1_)
      if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) >= _UPVALUE6_ then
        return false
      end
    elseif _ARG_0_.shadowMoveKind == _UPVALUE7_ then
      _ARG_0_:CalcRotMoveVelocity(_ARG_0_.rotSpeed, _UPVALUE1_)
      if _ARG_0_:IsPlayerBack() then
        return false
      end
    end
    return true
  end,
  CalcRotMoveVelocity = function(_ARG_0_, _ARG_1_, _ARG_2_)
    _UPVALUE0_:set(Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) * Math.Sin((Entity.CalcDirection(_ARG_0_.targetHandle, _ARG_0_.myHandle))), 0, Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) * Math.Cos((Entity.CalcDirection(_ARG_0_.targetHandle, _ARG_0_.myHandle))))
    _UPVALUE1_:set(Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) * Math.Sin((RoundPI(DegToRad(_ARG_1_) + Entity.CalcDirection(_ARG_0_.targetHandle, _ARG_0_.myHandle)))), 0, Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) * Math.Cos((RoundPI(DegToRad(_ARG_1_) + Entity.CalcDirection(_ARG_0_.targetHandle, _ARG_0_.myHandle)))))
    FVECTOR3.Sub(_UPVALUE0_, _UPVALUE1_, _UPVALUE0_)
    _UPVALUE0_:normalize()
    _UPVALUE0_:scale(_ARG_2_)
    Entity.GetVelocity(_UPVALUE1_, _ARG_0_.myHandle)
    _UPVALUE1_:setx(_UPVALUE0_:getx())
    _UPVALUE1_:setz(_UPVALUE0_:getz())
    Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE1_)
    Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
    _UPVALUE1_:sety((Math.Atan2(_UPVALUE0_:getx(), _UPVALUE0_:getz())))
    Entity.SetRot(_ARG_0_.myHandle, _UPVALUE1_)
  end,
  IsPlayerBack = function(_ARG_0_)
    Entity.GetDir(_UPVALUE0_, _ARG_0_.targetHandle)
    _UPVALUE0_:scale(-1)
    Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
    Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.targetHandle)
    FVECTOR3.Sub(_UPVALUE3_, _UPVALUE1_, _UPVALUE2_)
    _UPVALUE3_:normalize()
    if _UPVALUE0_:dot(_UPVALUE3_) >= Math.Cos(DegToRad(30)) then
      return true
    end
    return false
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.step = 0
    _ARG_0_.targetHandle = NULL_HANDLE
    _ARG_0_.timer = 0
    _ARG_0_.scaleTime = 0
    _ARG_0_.scaleTimer = 0
    _ARG_0_.rotSpeed = 1
    _ARG_0_.atkState = "Idling"
    _ARG_0_.shadowMoveKind = _UPVALUE0_
    _ARG_0_.srcScale = FVECTOR3.new(1, 1, 1)
    _ARG_0_.dstScale = FVECTOR3.new(1, 1, 1)
    _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
    Entity.EnableGravity(_ARG_1_, 1)
    if _UPVALUE1_ == false then
      _UPVALUE2_ = Enemy.GetExtraParam(_ARG_1_, "RND_ATK1") / 100
      _UPVALUE3_ = Enemy.GetExtraParam(_ARG_1_, "RND_ATK1_1") / 100
      _UPVALUE4_ = Enemy.GetExtraParam(_ARG_1_, "RND_ATK1_2") / 100
      M41EX_BEHAVIOR2_ATK1_RND2 = Enemy.GetExtraParam(_ARG_1_, "RND_MATK1_1") / 100
      _UPVALUE5_ = Enemy.GetExtraParam(_ARG_1_, "RND_ATK2") / 100
      _UPVALUE6_ = Enemy.GetExtraParam(_ARG_1_, "RND_ATK2_1") / 100
      _UPVALUE7_ = Enemy.GetExtraParam(_ARG_1_, "RND_MV1_1") / 100
      _UPVALUE8_ = Enemy.GetExtraParam(_ARG_1_, "RND_MV1_2") / 100
      _UPVALUE9_ = Enemy.GetExtraParam(_ARG_1_, "RND_MV1_3") / 100
      _UPVALUE10_ = Enemy.GetExtraParam(_ARG_1_, "RND_MV2_1") / 100
      _UPVALUE11_ = Enemy.GetExtraParam(_ARG_1_, "RND_MV2_2") / 100
      _UPVALUE12_ = Enemy.GetExtraParam(_ARG_1_, "STIFF_TIME") * 60
      _UPVALUE13_ = Enemy.GetExtraParam(_ARG_1_, "N_DIST")
      _UPVALUE13_ = _UPVALUE13_ * _UPVALUE13_
      _UPVALUE14_ = Enemy.GetExtraParam(_ARG_1_, "N2_DIST")
      _UPVALUE14_ = _UPVALUE14_ * _UPVALUE14_
      _UPVALUE1_ = true
    end
    if Enemy.IsAllEnemyWaiting() then
      _ARG_0_:GotoState("Waiting")
    else
      _ARG_0_:GotoState("Appear")
    end
  end,
  OnUpdate = function(_ARG_0_)
    if Entity.IsAlive(_ARG_0_.targetHandle) == false then
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
    end
    _ARG_0_:Update()
    _ARG_0_:Debug()
  end,
  OnHitAttack = function(_ARG_0_, _ARG_1_, _ARG_2_)
  end,
  CanCounterAttack = function(_ARG_0_, _ARG_1_)
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
    if Script.Random() < _UPVALUE0_ and _ARG_0_:CanCounterAttack(_ARG_1_) then
      if Script.Random() < _UPVALUE1_ then
        _ARG_0_:GotoState("Scratch")
      elseif Script.Random() >= _UPVALUE1_ and Script.Random() < _UPVALUE1_ + _UPVALUE2_ then
        _ARG_0_:GotoState("FallScratch")
      else
        _ARG_0_:GotoState("AirRush")
      end
      return 1
    end
    return 0
  end,
  OnBeginDamageReaction = function(_ARG_0_)
    Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
  end,
  OnReturnDamage = function(_ARG_0_)
    _ARG_0_:GotoState("Idling")
  end,
  OnUpdatePositionAfter = function(_ARG_0_)
    if _ARG_0_.scaleTimer > 0 then
      _ARG_0_.scaleTimer = _ARG_0_.scaleTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
      if _ARG_0_.scaleTimer <= 0 then
        _ARG_0_.scaleTimer = 0
      end
      Math.VectorLerp(_UPVALUE0_, _ARG_0_.srcScale, _ARG_0_.dstScale, 1 - _ARG_0_.scaleTimer / _ARG_0_.scaleTime)
      Entity.SetScale(_ARG_0_.myHandle, _UPVALUE0_)
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
EntityFactory:Add("m41ex00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
