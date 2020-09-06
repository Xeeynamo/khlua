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
        _ARG_0_:ResetAddGasTimer()
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
          _ARG_0_:CheckGas(false)
        end
      end
    },
    Waiting = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 1)
      end,
      OnEndState = function(_ARG_0_)
        _ARG_0_:ResetAddGasTimer()
      end,
      OnUpdate = function(_ARG_0_)
        if Enemy.IsAllEnemyWaiting() == false then
          _ARG_0_:CheckGas(false)
        end
      end
    },
    Behavior1 = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        print("Behavior1\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        Enemy.GetTargetLastRecordedPos(_UPVALUE0_, _ARG_0_.myHandle, _ARG_0_.targetHandle)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE0_, 2.5)
        if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) == false then
          return
        end
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE1_ then
          _ARG_0_.stack:push({"Behavior1"})
          if Script.Random() < 0.7 then
            _ARG_0_.stack:push({"Idling", 180})
            _ARG_0_.stack:push({
              "SmokeOrdnance"
            })
            _ARG_0_.stack:push({
              "TargetNearMove"
            })
          else
            _ARG_0_.stack:push({
              "TargetReverseMove",
              _UPVALUE2_ + Script.RandomInRange(-_UPVALUE3_, _UPVALUE3_)
            })
            _ARG_0_.stack:push({
              "LookAtTargetMove",
              _UPVALUE4_
            })
          end
          _ARG_0_:ChangeState()
        elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) >= _UPVALUE1_ and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE5_ then
          _ARG_0_.stack:push({"Behavior1"})
          if Script.Random() < 0.4 then
            _ARG_0_.stack:push({"Idling", 180})
            _ARG_0_.stack:push({"JetRush"})
          elseif Script.Random() >= 0.4 and Script.Random() < 0.70000005 then
            _ARG_0_.stack:push({"Idling", 180})
            _ARG_0_.stack:push({"BoundDrop"})
          else
            _ARG_0_.stack:push({
              "TargetReverseMove",
              _UPVALUE4_ + Script.RandomInRange(-_UPVALUE3_, _UPVALUE3_)
            })
          end
          _ARG_0_:ChangeState()
        end
      end
    },
    Behavior2Begin = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        print("Behavior2Begin\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        _ARG_0_.stack:push({"Behavior2", 0})
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE0_ then
          _ARG_0_.stack:push({"Meander", _UPVALUE1_})
        else
          _ARG_0_.stack:push({"Wander", _UPVALUE1_})
        end
        _ARG_0_:ChangeState()
      end
    },
    Behavior2 = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        print("Behavior2 ... " .. Entity.GetTimer(_ARG_0_.myHandle) .. "\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        Enemy.GetTargetLastRecordedPos(_UPVALUE0_, _ARG_0_.myHandle, _ARG_0_.targetHandle)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE0_, 2.5)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_.stack:push({"Behavior2", _UPVALUE1_})
          _ARG_0_.stack:push({"Wander", _UPVALUE2_})
          _ARG_0_:ChangeState()
          return
        end
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) >= _UPVALUE3_ then
          _ARG_0_.stack:push({"Behavior2", _UPVALUE1_})
          _ARG_0_.stack:push({"Meander", _UPVALUE2_})
          if Script.Random() < 0.5 then
            _ARG_0_.stack:push({
              "SmokeOrdnance"
            })
          else
            _ARG_0_.stack:push({"JetRush"})
          end
          _ARG_0_:ChangeState()
        end
      end
    },
    Behavior3 = {
      OnBeginState = function(_ARG_0_)
        print("Behavior3\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.stack:push({"Behavior3"})
        _ARG_0_.stack:push({"Idling", _UPVALUE0_})
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE1_ then
          _ARG_0_.stack:push({
            "TargetReverseMove",
            _UPVALUE2_ + Script.RandomInRange(-_UPVALUE3_, _UPVALUE3_)
          })
        elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) >= _UPVALUE1_ and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE4_ then
          _ARG_0_.stack:push({
            "TargetReverseMove",
            _UPVALUE2_ + Script.RandomInRange(-_UPVALUE3_, _UPVALUE3_)
          })
        elseif Script.Random() < 0.2 then
          _ARG_0_.stack:push({
            "TargetReverseMove",
            _UPVALUE2_ + Script.RandomInRange(-_UPVALUE3_, _UPVALUE3_)
          })
        else
          _ARG_0_.stack:push({
            "SmokeOrdnance"
          })
        end
        _ARG_0_:ChangeState()
      end
    },
    Behavior4Begin = {
      OnBeginState = function(_ARG_0_)
        print("Behavior4Begin\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.stack:push({"Behavior4"})
        _ARG_0_.stack:push({
          "LookAtTargetMove",
          _UPVALUE0_
        })
        _ARG_0_.stack:push({"BoundDrop"})
        _ARG_0_:ChangeState()
      end
    },
    Behavior4 = {
      OnBeginState = function(_ARG_0_)
        print("Behavior4\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.stack:push({"Behavior4"})
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE0_ then
          if Script.Random() < 0.4 then
            _ARG_0_.stack:push({
              "TargetReverseMove",
              _UPVALUE1_ + Script.RandomInRange(-_UPVALUE2_, _UPVALUE2_)
            })
            _ARG_0_.stack:push({
              "LookAtTargetMove",
              _UPVALUE3_
            })
          else
            _ARG_0_.stack:push({"Idling", _UPVALUE1_})
            _ARG_0_.stack:push({"BoundDrop"})
          end
        elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) >= _UPVALUE0_ and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE4_ then
          _ARG_0_.stack:push({
            "TargetReverseMove",
            _UPVALUE1_ + Script.RandomInRange(-_UPVALUE2_, _UPVALUE2_)
          })
          if Script.Random() < 0.7 then
            _ARG_0_.stack:push({"JetRush"})
          else
            _ARG_0_.stack:push({"BoundDrop"})
          end
        else
          _ARG_0_.stack:push({"Idling", _UPVALUE3_})
          _ARG_0_.stack:push({"BoundDrop"})
          _ARG_0_.stack:push({
            "TargetNearMove"
          })
        end
        _ARG_0_:ChangeState()
      end
    },
    TargetNearMove = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        print("TargetNearMove\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.moveSpeed)
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE0_ or Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:ChangeState()
        end
      end
    },
    LookAtTargetMove = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        if Script.Random() < 0.5 then
          _ARG_0_.velocity:set(1, 0, 0)
        else
          _ARG_0_.velocity:set(-1, 0, 0)
        end
        _ARG_0_.velocity:scale(_ARG_0_.moveSpeed)
        print("LookAtTargetMove ... " .. Entity.GetTimer(_ARG_0_.myHandle) .. "\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 1)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:ChangeState()
        end
      end
    },
    TargetReverseMove = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        print("TargetReverseMove ... " .. Entity.GetTimer(_ARG_0_.myHandle) .. "\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.targetHandle)
        Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
        FVECTOR3.Sub(_UPVALUE2_, _UPVALUE1_, _UPVALUE0_)
        _UPVALUE2_:normalize()
        _UPVALUE2_:scale(20)
        FVECTOR3.Add(_UPVALUE1_, _UPVALUE1_, _UPVALUE2_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE1_, 10)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.moveSpeed)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:ChangeState()
        end
      end
    },
    Wander = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.EnableAvoidPlayer(_ARG_0_.myHandle, 1)
        _ARG_0_.moveTimer = 0
        _ARG_0_.step = 0
        print("Wander ... " .. Entity.GetTimer(_ARG_0_.myHandle) .. "\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableAvoidPlayer(_ARG_0_.myHandle, 0)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:ChangeState()
          return
        end
        _ARG_0_.moveTimer = _ARG_0_.moveTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.moveTimer <= 0 then
          _ARG_0_.targetPos:set(Math.Cos((RoundPI(DegToRad((Script.Random() - Script.Random()) * 360)))) * (5 + Script.Random() * 10), 0, Math.Sin((RoundPI(DegToRad((Script.Random() - Script.Random()) * 360)))) * (5 + Script.Random() * 10))
          _ARG_0_.moveTimer = _UPVALUE0_
          _ARG_0_.step = 0
        elseif _ARG_0_.step == 0 and Entity.IsWall(_ARG_0_.myHandle) then
          Entity.GetVelocity(_UPVALUE1_, _ARG_0_.myHandle)
          Entity.GetWallNormal(_UPVALUE2_, _ARG_0_.myHandle)
          _UPVALUE1_:scale(-1)
          _UPVALUE2_:scale(2 * _UPVALUE1_:dot(_UPVALUE2_))
          FVECTOR3.Sub(_ARG_0_.targetPos, _UPVALUE2_, _UPVALUE1_)
          _ARG_0_.targetPos:normalize()
          _ARG_0_.targetPos:scale(5 + Script.Random() * 10)
          _ARG_0_.moveTimer = _UPVALUE0_
          _ARG_0_.step = 1
        end
        Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
        FVECTOR3.Add(_UPVALUE1_, _ARG_0_.targetPos, _UPVALUE1_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE1_, 5)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.moveSpeed)
        if 1 >= Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) then
          _ARG_0_.moveTimer = 0
        end
      end
    },
    Meander = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.meanderTheta = 0
        _ARG_0_.step = 0
        _ARG_0_.timer = 0
        print("Meander ... " .. Entity.GetTimer(_ARG_0_.myHandle) .. "\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
          Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.targetHandle)
          FVECTOR3.Sub(_UPVALUE1_, _UPVALUE0_, _UPVALUE1_)
          _UPVALUE1_:normalize()
          _UPVALUE1_:scale(50)
          FVECTOR3.Add(_UPVALUE2_, _UPVALUE0_, _UPVALUE1_)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE2_, 10)
          if Entity.IsWall(_ARG_0_.myHandle) then
            _ARG_0_:CalcReflectionVector(_ARG_0_.targetPos)
            _ARG_0_.timer = 300
            _ARG_0_.step = 1
          end
        else
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 10)
          if Entity.IsWall(_ARG_0_.myHandle) then
            _ARG_0_:CalcReflectionVector(_ARG_0_.targetPos)
            _ARG_0_.timer = 300
          end
          _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 >= _ARG_0_.timer then
            _ARG_0_.step = 1
          end
        end
        _ARG_0_.meanderTheta = _ARG_0_.meanderTheta + DegToRad(5) * Entity.GetFrameRate(_ARG_0_.myHandle)
        _ARG_0_.meanderTheta = RoundPI(_ARG_0_.meanderTheta)
        _UPVALUE0_:set(Math.Sin(_ARG_0_.meanderTheta), 0, 1)
        _UPVALUE0_:normalize()
        _UPVALUE0_:scale(_ARG_0_.moveSpeed)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:ChangeState()
          return
        end
      end
    },
    SmokeOrdnance = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        _ARG_0_.step = 0
        print("SmokeOrdnance\n")
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
          _ARG_0_:ChangeState()
        end
      end
    },
    JetRush = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        _ARG_0_.step = 0
        print("JetRush\n")
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
          _ARG_0_:ChangeState()
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
        print("BoundDrop\n")
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
          _ARG_0_:ChangeState()
        end
      end
    },
    Idling = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        print("Idling\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:ChangeState()
        end
      end
    },
    Landing = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_.step = 0
        print("Landing\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsGround(_ARG_0_.myHandle) then
            _ARG_0_:ChangeState()
            return
          end
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
          _ARG_0_.step = 1
        elseif _ARG_0_.step == 1 then
          if Entity.IsGround(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
            _ARG_0_.step = 2
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:ChangeState()
        end
      end
    },
    Explode = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
        Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle, 2)
        _UPVALUE2_:set(0, 0, 0)
        _UPVALUE3_:set(_ARG_0_.scale, _ARG_0_.scale, _ARG_0_.scale)
        Effect.SetScale(Entity.SetEffect(_ARG_0_.myHandle, "e_ex120", "E012_EXP_00_0", _UPVALUE1_, _UPVALUE2_), _UPVALUE3_)
        _ARG_0_.effHandle = Entity.SetEffect(_ARG_0_.myHandle, "e_ex120", "E012_EXP_00_0", _UPVALUE1_, _UPVALUE2_)
        Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 10)
        Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
        _ARG_0_.step = 0
        _ARG_0_:DisableAddGasTimer()
        print("\148\154\148\173\138J\142n\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 and Effect.IsAlive(_ARG_0_.effHandle) == false then
          print("\148\154\148\173\143I\151\185\n")
          Mission.SendMissonMessage(MES_GAS_BOMB_END)
          _ARG_0_.step = 1
        end
      end
    },
    Dead = {
      OnBeginState = function(_ARG_0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
        Entity.EnableGravity(_ARG_0_.myHandle, 0)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
        _ARG_0_.step = 0
        _ARG_0_:DisableAddGasTimer()
        print("Dead\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
      end
    }
  },
  ChangeState = function(_ARG_0_)
    if _ARG_0_.stack:pop() == nil then
      print("Warning:" .. _ARG_0_.behavior .. "\n")
      _ARG_0_:GotoState(_ARG_0_.behavior)
      return
    end
    if _ARG_0_.stack:pop()[2] ~= nil then
      Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_.stack:pop()[2])
    end
    _ARG_0_:GotoState(_ARG_0_.stack:pop()[1])
  end,
  CheckGas = function(_ARG_0_, _ARG_1_)
    for _FORV_5_, _FORV_6_ in pairs(_UPVALUE0_) do
      if _FORV_6_[1] <= _ARG_0_.gas and _ARG_0_.gas <= _FORV_6_[2] then
        if _ARG_1_ and _ARG_0_.behavior == _FORV_6_[3] then
          return
        end
        _ARG_0_.stack:clear()
        _ARG_0_.behavior = _FORV_6_[3]
        _ARG_0_.stack:push({
          _FORV_6_[3],
          0
        })
        _ARG_0_:GotoState("Landing")
        break
      end
    end
  end,
  AttachExpandEffect = function(_ARG_0_, _ARG_1_)
    _UPVALUE0_:set(0, 0, 0)
    _ARG_0_.expandEffect = Entity.AttachEffect(_ARG_0_.myHandle, "e_ex530", _ARG_1_, "mune", _UPVALUE0_, _UPVALUE0_)
    Effect.SetAttachNoScale(_ARG_0_.expandEffect, true)
  end,
  Expand = function(_ARG_0_)
    for _FORV_4_, _FORV_5_ in pairs(_UPVALUE0_) do
      if _ARG_0_.gas > _FORV_5_[1] then
        if _ARG_0_.scale < _FORV_5_[2] then
          _ARG_0_.srcScale = _ARG_0_.scale
          _ARG_0_.dstScale = _FORV_5_[2]
          _ARG_0_.scaleTimer = _UPVALUE1_
          _ARG_0_.exec = true
          _ARG_0_:AttachExpandEffect("E053_GRO_00_0")
          print("\150c\130\231\130\241\130\190\n")
          break
        end
      elseif _ARG_0_.scale > _FORV_5_[2] then
        _ARG_0_.srcScale = _ARG_0_.scale
        _ARG_0_.dstScale = _FORV_5_[2]
        _ARG_0_.scaleTimer = _UPVALUE1_
        _ARG_0_:AttachExpandEffect("E053_SMA_00_0")
        print("\143k\130\241\130\190\n")
        break
      end
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
  end,
  UpdateExpansion = function(_ARG_0_)
    if _ARG_0_.scaleTimer > 0 then
      _ARG_0_.scaleTimer = _ARG_0_.scaleTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
      if _ARG_0_.scaleTimer <= 0 then
        _ARG_0_.scaleTimer = 0
      end
      _ARG_0_.scale = _ARG_0_.srcScale + (1 - _ARG_0_.scaleTimer / _UPVALUE0_) * (_ARG_0_.dstScale - _ARG_0_.srcScale)
      print("UpdateExpansion = " .. _ARG_0_.scale .. ", " .. _ARG_0_.scaleTimer .. "\n")
    end
    if _ARG_0_.exec then
      _ARG_0_.theta = RoundPI(_ARG_0_.theta + Entity.GetFrameRate(_ARG_0_.myHandle) * DegToRad(32))
      _ARG_0_.c = _ARG_0_.c - Entity.GetFrameRate(_ARG_0_.myHandle) * 0.0025
      if 0 >= _ARG_0_.c then
        _ARG_0_.c = 0
        _ARG_0_.exec = false
      end
    end
    _UPVALUE1_:set(Math.Cos(_ARG_0_.theta) * _ARG_0_.c + _ARG_0_.scale, Math.Cos(_ARG_0_.theta) * _ARG_0_.c + _ARG_0_.scale, Math.Cos(_ARG_0_.theta) * _ARG_0_.c + _ARG_0_.scale)
    Entity.SetScale(_ARG_0_.myHandle, _UPVALUE1_)
    Effect.SetScale(_ARG_0_.expandEffect, _UPVALUE1_)
    Entity.SetMovementCollRadius(_ARG_0_.myHandle, 1 * _ARG_0_.scale)
    Entity.SetLowerHalf(_ARG_0_.myHandle, 1.5 * _ARG_0_.scale)
  end,
  CalcReflectionVector = function(_ARG_0_, _ARG_1_)
    Entity.GetVelocity(_UPVALUE0_, _ARG_0_.myHandle)
    Entity.GetWallNormal(_UPVALUE1_, _ARG_0_.myHandle)
    _UPVALUE0_:scale(-1)
    _UPVALUE1_:scale(2 * _UPVALUE0_:dot(_UPVALUE1_))
    FVECTOR3.Sub(_ARG_1_, _UPVALUE1_, _UPVALUE0_)
    _ARG_1_:normalize()
    _ARG_1_:scale(50)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
    FVECTOR3.Add(_ARG_1_, _ARG_1_, _UPVALUE0_)
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
  ResetAddGasTimer = function(_ARG_0_)
    _ARG_0_.addGasTimer = _UPVALUE0_
    _ARG_0_.addGasStep = 0
  end,
  DisableAddGasTimer = function(_ARG_0_)
    _ARG_0_.addGasTimer = 0
    _ARG_0_.addGasStep = 0
  end,
  UpdateAddGasTimer = function(_ARG_0_)
    if _ARG_0_.addGasStep == 0 then
      if 0 < _ARG_0_.addGasTimer then
        _ARG_0_.addGasTimer = _ARG_0_.addGasTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
        if 0 >= _ARG_0_.addGasTimer then
          _ARG_0_.addGasTimer = _UPVALUE0_
          _ARG_0_.addGasStep = 1
          _ARG_0_.gasTimer = 0
        end
      end
    else
      _ARG_0_.gasTimer = _ARG_0_.gasTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
      if 0 >= _ARG_0_.gasTimer then
        _ARG_0_.gasTimer = _UPVALUE1_
        _ARG_0_.gas = _ARG_0_.gas + _UPVALUE2_
        print("GAS = " .. _ARG_0_.gas .. "\n")
        if _ARG_0_.gas >= _UPVALUE3_ then
          _ARG_0_:GotoState("Explode")
        else
          _ARG_0_:CheckGas(true)
          _ARG_0_:Expand()
        end
      end
    end
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    if _UPVALUE0_ == false then
      _UPVALUE1_ = Enemy.GetExtraParam(_ARG_1_, "N")
      _UPVALUE1_ = _UPVALUE1_ * _UPVALUE1_
      _UPVALUE2_ = Enemy.GetExtraParam(_ARG_1_, "N2")
      _UPVALUE2_ = _UPVALUE2_ * _UPVALUE2_
      _UPVALUE3_ = Enemy.GetExtraParam(_ARG_1_, "N3")
      _UPVALUE3_ = _UPVALUE3_ * _UPVALUE3_
      _UPVALUE4_ = Enemy.GetExtraParam(_ARG_1_, "N4") * 60
      _UPVALUE5_ = Enemy.GetExtraParam(_ARG_1_, "N5") * 60
      _UPVALUE6_ = Enemy.GetExtraParam(_ARG_1_, "N6")
      _UPVALUE6_ = _UPVALUE6_ * _UPVALUE6_
      _UPVALUE7_ = Enemy.GetExtraParam(_ARG_1_, "N7") * 60
      _UPVALUE8_ = Enemy.GetExtraParam(_ARG_1_, "N8") * 60
      _UPVALUE9_ = Enemy.GetExtraParam(_ARG_1_, "N9") * 60
      _UPVALUE10_ = Enemy.GetExtraParam(_ARG_1_, "N10") * 60
      _UPVALUE11_ = Enemy.GetExtraParam(_ARG_1_, "GAMEOVERGAS")
      _UPVALUE12_ = Enemy.GetExtraParam(_ARG_1_, "MOVE_SPD_S") / 60
      _UPVALUE13_ = Enemy.GetExtraParam(_ARG_1_, "ADD_GAS")
      _UPVALUE14_[1][2] = Enemy.GetExtraParam(_ARG_1_, "S_DMG_F_GAS")
      _UPVALUE14_[2][2] = Enemy.GetExtraParam(_ARG_1_, "S_DMG_B_GAS")
      _UPVALUE14_[3][2] = Enemy.GetExtraParam(_ARG_1_, "B_DMG_F_GAS")
      _UPVALUE14_[4][2] = Enemy.GetExtraParam(_ARG_1_, "B_DMG_B_GAS")
      _UPVALUE15_[1][1] = Enemy.GetExtraParam(_ARG_1_, "GAS1")
      _UPVALUE15_[2][1] = Enemy.GetExtraParam(_ARG_1_, "GAS2")
      _UPVALUE15_[3][1] = Enemy.GetExtraParam(_ARG_1_, "GAS3")
      _UPVALUE15_[4][1] = Enemy.GetExtraParam(_ARG_1_, "GAS4")
      _UPVALUE15_[5][1] = Enemy.GetExtraParam(_ARG_1_, "GAS5")
      _UPVALUE15_[1][2] = Enemy.GetExtraParam(_ARG_1_, "SIZE1")
      _UPVALUE15_[2][2] = Enemy.GetExtraParam(_ARG_1_, "SIZE2")
      _UPVALUE15_[3][2] = Enemy.GetExtraParam(_ARG_1_, "SIZE3")
      _UPVALUE15_[4][2] = Enemy.GetExtraParam(_ARG_1_, "SIZE4")
      _UPVALUE15_[5][2] = Enemy.GetExtraParam(_ARG_1_, "SIZE5")
      _UPVALUE0_ = true
    end
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
    _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
    _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.step = 0
    _ARG_0_.step2 = 0
    _ARG_0_.addGasStep = 0
    _ARG_0_.targetHandle = NULL_HANDLE
    _ARG_0_.effHandle = NULL_HANDLE
    _ARG_0_.timer = 0
    _ARG_0_.speed = 0
    _ARG_0_.moveSpeed = 0
    _ARG_0_.rotDir = 1
    _ARG_0_.moveTimer = 0
    _ARG_0_.effHandle = NULL_HANDLE
    _ARG_0_.height = 0
    _ARG_0_.endBoundDrop = false
    _ARG_0_.expandEffect = NULL_HANDLE
    _ARG_0_.rootMoveScale = 1
    _ARG_0_.meanderTheta = 0
    _ARG_0_.behavior = nil
    _ARG_0_.addGasTimer = 0
    _ARG_0_.gasTimer = 0
    _ARG_0_.shootLockDmgCount = 0
    _ARG_0_.scale = _UPVALUE15_[2][2]
    _ARG_0_.srcScale = 1
    _ARG_0_.dstScale = 1
    _ARG_0_.scaleTimer = 0
    _ARG_0_.c = 0
    _ARG_0_.theta = 0
    _ARG_0_.exec = false
    _ARG_0_.gas = _UPVALUE15_[2][1]
    _ARG_0_.stack = Stack:Create()
    Entity.EnableGravity(_ARG_1_, 1)
    Enemy.EnableNoCalcDamage(_ARG_1_, 1)
    Enemy.EnableNoChangeDamageMotion(_ARG_1_, 1)
    Player.SetBattleFlagTargetHpOff(1)
    if Enemy.IsAllEnemyWaiting() then
      _ARG_0_:GotoState("Waiting")
    else
      _ARG_0_:GotoState("Appear")
    end
  end,
  GetCameraTargetPos = function(_ARG_0_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 1)
    _UPVALUE0_:sety(_UPVALUE0_:gety() + 0.5 * (_ARG_0_.scale - 1))
    return _UPVALUE0_
  end,
  IsScalingDamage = function(_ARG_0_, _ARG_1_)
    if Enemy.IsSpecialDamage(_ARG_0_.myHandle) then
      return false
    end
    return true
  end,
  OnDamage = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    _ARG_0_:ResetAddGasTimer()
    if _ARG_0_:GetState() == "Explode" or _ARG_0_:GetState() == "Dead" then
      return 1
    end
    if 1 > _ARG_0_.gas or _ARG_0_.gas >= _UPVALUE0_ then
      return 1
    end
    if _ARG_2_ == COMMAND_CATEGORY_SHOOTLOCK then
      _ARG_0_.shootLockDmgCount = _ARG_0_.shootLockDmgCount + 1
      if 1 < _ARG_0_.shootLockDmgCount then
        print("\131V\131\133\129[\131g\131\141\131b\131N\150\179\140\248\n")
        return 0
      end
      print("\131V\131\133\129[\131g\131\141\131b\131N\131q\131b\131g\n")
    end
    if _ARG_0_:IsFront() then
      if _ARG_1_ == ATK_KIND_DMG_SMALL or _ARG_1_ == ATK_KIND_DMG_BIG then
      else
      end
    elseif _ARG_1_ == ATK_KIND_DMG_SMALL or _ARG_1_ == ATK_KIND_DMG_BIG then
    else
    end
    _ARG_0_.gas = _ARG_0_.gas + _UPVALUE1_[4][2]
    if _ARG_0_.gas <= _UPVALUE2_ then
      if Enemy.IsNoDamageReaction(_ARG_0_.myHandle) then
        _ARG_0_:CheckGas(true)
      end
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
    else
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
    end
    print("GAS = " .. _ARG_0_.gas .. "\n")
    _ARG_0_:Expand()
    return 0
  end,
  OnReflect = function(_ARG_0_)
    Entity.EnableGravity(_ARG_0_.myHandle, 1)
    for _FORV_4_, _FORV_5_ in pairs(_UPVALUE0_) do
      if _FORV_5_[1] <= _ARG_0_.gas and _ARG_0_.gas <= _FORV_5_[2] then
        _ARG_0_.behavior = _FORV_5_[3]
        _ARG_0_.stack:clear()
        _ARG_0_.stack:push({
          _FORV_5_[3],
          0
        })
        _ARG_0_.stack:push({
          "TargetReverseMove",
          _UPVALUE1_ + Script.RandomInRange(-_UPVALUE2_, _UPVALUE2_)
        })
        _ARG_0_:ChangeState()
        break
      end
    end
    return 1
  end,
  OnBeginDamageReaction = function(_ARG_0_)
    Entity.EnableGravity(_ARG_0_.myHandle, 1)
  end,
  OnEndReaction = function(_ARG_0_)
    Entity.EnableGravity(_ARG_0_.myHandle, 1)
  end,
  OnReturnDamage = function(_ARG_0_)
    _ARG_0_:CheckGas(false)
  end,
  OnUpdatePositionAfter = function(_ARG_0_)
    if Player.GetCommandCategory(Player.GetHandle()) ~= COMMAND_CATEGORY_SHOOTLOCK then
      _ARG_0_.shootLockDmgCount = 0
    end
    _ARG_0_:UpdateExpansion()
    _ARG_0_:UpdateAddGasTimer()
    if _ARG_0_:GetState() ~= "Appear" and _ARG_0_:GetState() ~= "Waiting" and _ARG_0_:GetState() ~= "Explode" and _ARG_0_:GetState() ~= "Dead" and Script.GetDebugTestParam() >= _UPVALUE0_ then
      _ARG_0_.gas = _UPVALUE0_
      _ARG_0_:GotoState("Explode")
    end
    if Player.GetCommandCategory(Player.GetHandle()) ~= COMMAND_CATEGORY_SHOOTLOCK then
      _ARG_0_.shootLockDmgCount = 0
    end
    if _ARG_0_.gas > _UPVALUE1_[5][1] then
      _ARG_0_.moveSpeed = _UPVALUE2_
    else
      _ARG_0_.moveSpeed = _UPVALUE3_
    end
    if _ARG_0_.gas < 1 then
      if _ARG_0_:GetState() ~= "Dead" then
        _ARG_0_:GotoState("Dead")
      end
    elseif _ARG_0_.gas >= _UPVALUE0_ and _ARG_0_:GetState() ~= "Explode" then
      _ARG_0_:GotoState("Explode")
    end
    Mission.SendMissonMessage(MES_GAS_VALUE, _ARG_0_.gas)
  end,
  OnDead = function(_ARG_0_)
    _ARG_0_.gas = 0
    _ARG_0_.srcScale = _ARG_0_.scale
    _ARG_0_.dstScale = _UPVALUE0_[5][2]
    _ARG_0_.scaleTimer = _UPVALUE1_
    _ARG_0_:GotoState("Dead")
    return 1
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
        _ARG_0_.stack:clear()
        _ARG_0_.stack:push({"Idling", 600})
        _ARG_0_.stack:push({
          _UPVALUE0_[Script.GetDebugAttackNumber() + 1],
          600
        })
        _ARG_0_:ChangeState()
      end
    end
  end
}, {__index = __StateMachine})
EntityFactory:Add("m53ex00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
