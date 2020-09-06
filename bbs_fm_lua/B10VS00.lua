setmetatable({
  new = function(_ARG_0_)
    return setmetatable(__StateMachine:new(), _UPVALUE0_)
  end,
  states = {
    Appear = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, -2)
        Entity.SetAlpha(_ARG_0_.myHandle, 0)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
        if Entity.GetLayoutParam(_ARG_0_.myHandle, 1) == 1 then
          Entity.SetTimer(_ARG_0_.myHandle, 0)
          _ARG_0_.step = 1
        else
          _ARG_0_.step = 0
        end
      end,
      OnEndState = function(_ARG_0_)
        SetupAppearEnd(_ARG_0_.myHandle)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        Entity.SetAlpha(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Exusia.IsExistenceSchedule() then
            Entity.SetTimer(_ARG_0_.myHandle, 328)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            SetupAppearBegin(_ARG_0_.myHandle, -1, _UPVALUE0_, _UPVALUE1_[_ARG_0_.kind])
            _ARG_0_.step = 2
          end
        else
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          if Enemy.IsAllEnemyWaiting() == false then
            _ARG_0_:GotoState(_UPVALUE2_[_ARG_0_.kind])
          end
        end
      end
    },
    IronPrisoner4Setup = {
      OnBeginState = function(_ARG_0_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.stack:push("Idling4")
        _ARG_0_.stack:push("ResetAttackCount")
        _ARG_0_.stack:push("FireImprisonment")
        _ARG_0_.stack:push("BerserkCharge")
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
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
      end
    },
    Idling1 = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, Script.RandomInRange(_ARG_0_.idlingTime0, _ARG_0_.idlingTime1))
        _ARG_0_.stack:clear()
        print("Idling1\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.dmgCount >= _UPVALUE0_ then
          _ARG_0_.stack:push("Idling1")
          _ARG_0_.stack:push("ResetDmgCount")
          if Script.Random() < 0.5 then
            if _ARG_0_:SelectAttackState("Volcano", _UPVALUE1_) ~= "Volcano" then
              _ARG_0_.stack:push("Flee")
            end
            _ARG_0_.stack:push((_ARG_0_:SelectAttackState("Volcano", _UPVALUE1_)))
          else
            if _ARG_0_:SelectAttackState("Imprisonment", _UPVALUE1_) == "Imprisonment" then
              _ARG_0_.stack:push("Flee")
            end
            _ARG_0_.stack:push((_ARG_0_:SelectAttackState("Imprisonment", _UPVALUE1_)))
          end
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          return
        end
        if _ARG_0_.attackCount >= _UPVALUE2_ then
          _ARG_0_.stack:push("Idling1")
          _ARG_0_.stack:push("ResetAttackCount")
          _ARG_0_:GotoState("Imprisonment")
          return
        end
        Enemy.GetTargetLastRecordedPos(_UPVALUE3_, _ARG_0_.myHandle, _ARG_0_.targetHandle)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE3_, 2.5)
        if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
          return
        end
        if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) == false then
          return
        end
        _ARG_0_.stack:push("Idling1")
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE4_ then
          if Script.Random() < 0.25 then
            _ARG_0_.stack:push("Flee")
          elseif Script.Random() >= 0.25 and Script.Random() < 0.5 and _ARG_0_:SelectAttackState("SpiralRage1", _UPVALUE5_) ~= "Idling" then
            _ARG_0_.stack:push((_ARG_0_:SelectAttackState("SpiralRage1", _UPVALUE5_)))
          end
          if _ARG_0_:RestHpRate() > 0.66 then
          elseif _ARG_0_:RestHpRate() > 0.33 and _ARG_0_:RestHpRate() <= 0.66 then
          else
          end
          for _FORV_7_ = 1, 3 do
            _ARG_0_.stack:push("Charge")
          end
          _ARG_0_.idlingTime0 = _FOR_
          _ARG_0_.idlingTime1 = _UPVALUE7_
        else
          if Script.Random() < 0.33 then
          elseif Script.Random() >= 0.33 and Script.Random() < 0.66 then
          else
          end
          _ARG_0_.stack:push((_ARG_0_:SelectAttackState("BeamTrigger", _UPVALUE8_)))
          _ARG_0_.idlingTime0 = _UPVALUE9_
          _ARG_0_.idlingTime1 = _UPVALUE10_
        end
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      end
    },
    Idling2 = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, Script.RandomInRange(_ARG_0_.idlingTime0, _ARG_0_.idlingTime1))
        _ARG_0_.stack:clear()
        print("Idling2\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.dmgCount >= _UPVALUE0_ then
          _ARG_0_.stack:push("Idling2")
          _ARG_0_.stack:push("ResetDmgCount")
          if Script.Random() < 0.5 then
            if _ARG_0_:SelectAttackState("Volcano", _UPVALUE1_) ~= "Volcano" then
              _ARG_0_.stack:push("Flee")
            end
            _ARG_0_.stack:push((_ARG_0_:SelectAttackState("Volcano", _UPVALUE1_)))
          else
            if _ARG_0_:SelectAttackState("Imprisonment", _UPVALUE1_) == "Imprisonment" then
              _ARG_0_.stack:push("Flee")
            end
            _ARG_0_.stack:push((_ARG_0_:SelectAttackState("Imprisonment", _UPVALUE1_)))
          end
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          return
        end
        if _ARG_0_.attackCount >= _UPVALUE2_ then
          _ARG_0_.stack:push("Idling2")
          _ARG_0_.stack:push("ResetAttackCount")
          _ARG_0_:GotoState("Imprisonment")
          return
        end
        Enemy.GetTargetLastRecordedPos(_UPVALUE3_, _ARG_0_.myHandle, _ARG_0_.targetHandle)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE3_, 2.5)
        if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
          return
        end
        if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) == false then
          return
        end
        _ARG_0_.stack:push("Idling2")
        if Script.Random() < 0.5 then
          if Script.Random() < 0.5 then
            _ARG_0_.stack:push("Flee")
          elseif Script.Random() >= 0.5 and Script.Random() < 0.75 and _ARG_0_:SelectAttackState("SpiralRage1", _UPVALUE4_) ~= "Idling" then
            _ARG_0_.stack:push((_ARG_0_:SelectAttackState("SpiralRage1", _UPVALUE4_)))
          end
          if 0.5 > _ARG_0_:RestHpRate() then
          else
          end
          for _FORV_7_ = 1, 1 + (Script.RandomInteger(3) + 1) + Script.RandomInteger(2) do
            _ARG_0_.stack:push("SwingCharge2")
          end
          _ARG_0_.idlingTime0 = _FOR_
          _ARG_0_.idlingTime1 = _UPVALUE6_
        elseif Script.Random() >= 0.5 and Script.Random() < 0.675 then
          state = _ARG_0_:SelectAttackState("Volcano", _UPVALUE7_)
          _ARG_0_.stack:push(state)
          _ARG_0_.idlingTime0 = _UPVALUE8_
          _ARG_0_.idlingTime1 = _UPVALUE9_
        elseif Script.Random() >= 0.675 and Script.Random() < 0.825 then
          state = _ARG_0_:SelectAttackState("SpiralRage1", _UPVALUE7_)
          _ARG_0_.stack:push(state)
          _ARG_0_.idlingTime0 = _UPVALUE8_
          _ARG_0_.idlingTime1 = _UPVALUE9_
        else
          state = _ARG_0_:SelectAttackState("BeamTrigger", _UPVALUE7_)
          _ARG_0_.stack:push(state)
          _ARG_0_.idlingTime0 = _UPVALUE8_
          _ARG_0_.idlingTime1 = _UPVALUE9_
        end
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      end
    },
    Idling3 = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, Script.RandomInRange(_ARG_0_.idlingTime0, _ARG_0_.idlingTime1))
        _ARG_0_.stack:clear()
        print("Idling3\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.dmgCount >= _UPVALUE0_ then
          _ARG_0_.stack:push("Idling3")
          _ARG_0_.stack:push("ResetDmgCount")
          if Script.Random() < 0.5 then
            if _ARG_0_:SelectAttackState("BerserkCharge", _UPVALUE1_) ~= "Volcano" then
              _ARG_0_.stack:push("Flee")
            end
            _ARG_0_.stack:push((_ARG_0_:SelectAttackState("BerserkCharge", _UPVALUE1_)))
          else
            if _ARG_0_:SelectAttackState("Imprisonment", _UPVALUE1_) == "Imprisonment" then
              _ARG_0_.stack:push("Flee")
            end
            _ARG_0_.stack:push((_ARG_0_:SelectAttackState("Imprisonment", _UPVALUE1_)))
          end
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          return
        end
        if _ARG_0_.attackCount >= _UPVALUE2_ then
          _ARG_0_.stack:push("Idling3")
          _ARG_0_.stack:push("ResetAttackCount")
          _ARG_0_:GotoState("Imprisonment")
          return
        end
        Enemy.GetTargetLastRecordedPos(_UPVALUE3_, _ARG_0_.myHandle, _ARG_0_.targetHandle)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE3_, 2.5)
        if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
          return
        end
        if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) == false then
          return
        end
        _ARG_0_.stack:push("Idling3")
        if Script.Random() < 0.33 then
          if Script.Random() < 0.25 then
            _ARG_0_.stack:push("SpiralRage2")
          elseif Script.Random() >= 0.25 and Script.Random() < 0.75 then
            _ARG_0_.stack:push("Flee")
          end
          if 0.5 > _ARG_0_:RestHpRate() then
            _ARG_0_.stack:push("BerserkCharge")
          else
            for _FORV_7_ = 1, Script.RandomInteger(3) + 1 do
              _ARG_0_.stack:push("SwingCharge3")
            end
          end
          _ARG_0_.idlingTime0 = _UPVALUE4_
          _ARG_0_.idlingTime1 = _UPVALUE5_
        elseif Script.Random() >= 0.33 and Script.Random() < 0.66 then
          state = _ARG_0_:SelectAttackState("Volcano", _UPVALUE6_)
          _ARG_0_.stack:push(state)
          _ARG_0_.idlingTime0 = _UPVALUE7_
          _ARG_0_.idlingTime1 = _UPVALUE8_
        else
          state = _ARG_0_:SelectAttackState("SpiralRage2", _UPVALUE6_)
          _ARG_0_.stack:push(state)
          _ARG_0_.idlingTime0 = _UPVALUE7_
          _ARG_0_.idlingTime1 = _UPVALUE8_
        end
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      end
    },
    Idling4 = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, Script.RandomInRange(_UPVALUE1_, _UPVALUE1_ * 2))
        _ARG_0_.stack:clear()
        print("Idling4\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.dmgCount >= _UPVALUE0_ then
          _ARG_0_.stack:push("Idling4")
          _ARG_0_.stack:push("ResetDmgCount")
          if _ARG_0_.oldAttackState2 == "BakuenRetsuka" then
            _ARG_0_.oldAttackState2 = "SekihekiHisyouDan"
            if Script.Random() < 0.5 then
              _ARG_0_.stack:push("BakuenRetsuka")
            end
            _ARG_0_.stack:push("SekihekiHisyouDan")
          elseif _ARG_0_.oldAttackState2 == "SekihekiHisyouDan" then
            _ARG_0_.oldAttackState2 = "BakuenRetsuka"
            if Script.Random() < 0.5 then
              _ARG_0_.stack:push("SekihekiHisyouDan")
            end
            _ARG_0_.stack:push("BakuenRetsuka")
          elseif Script.Random() < 0.5 then
            _ARG_0_.oldAttackState2 = "SekihekiHisyouDan"
            if Script.Random() < 0.5 then
              _ARG_0_.stack:push("BakuenRetsuka")
            end
            _ARG_0_.stack:push("SekihekiHisyouDan")
          else
            _ARG_0_.oldAttackState2 = "BakuenRetsuka"
            if Script.Random() < 0.5 then
              _ARG_0_.stack:push("SekihekiHisyouDan")
            end
            _ARG_0_.stack:push("BakuenRetsuka")
          end
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          return
        end
        if _ARG_0_.attackCount >= _UPVALUE1_ then
          _ARG_0_.stack:push("Idling4")
          _ARG_0_.stack:push("ResetAttackCount")
          _ARG_0_:GotoState("FireImprisonment")
          return
        end
        Enemy.GetTargetLastRecordedPos(_UPVALUE2_, _ARG_0_.myHandle, _ARG_0_.targetHandle)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE2_, 2.5)
        if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
          return
        end
        if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) == false then
          return
        end
        _ARG_0_.stack:push("Idling4")
        if Script.Random() < 0.33 then
          if Script.Random() < 0.5 and _ARG_0_:SelectAttackState("BerserkCharge", _UPVALUE3_) ~= "SpiralRage2" then
            _ARG_0_.stack:push("SpiralRage2")
          end
          _ARG_0_.stack:push((_ARG_0_:SelectAttackState("BerserkCharge", _UPVALUE3_)))
        elseif Script.Random() >= 0.33 and Script.Random() < 0.66 then
          if Script.Random() < 0.5 and _ARG_0_:SelectAttackState("SpiralRage2", _UPVALUE3_) ~= "BerserkCharge" then
            _ARG_0_.stack:push("BerserkCharge")
          end
          _ARG_0_.stack:push((_ARG_0_:SelectAttackState("SpiralRage2", _UPVALUE3_)))
        else
          _ARG_0_.stack:push((_ARG_0_:SelectAttackState("Volcano", _UPVALUE3_)))
        end
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      end
    },
    Landing = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _UPVALUE1_:set(0, -0.1, 0)
        Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE1_)
        print("Landing\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsGround(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_UPVALUE0_[_ARG_0_.kind])
        end
      end
    },
    Flee = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        print("Flee\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, -_UPVALUE0_)
        if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _UPVALUE1_ or Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.IsWall(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Charge = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        _ARG_0_.attackCount = _ARG_0_.attackCount + 1
        _ARG_0_.oldAttackState = "Charge"
        _ARG_0_.step = 0
        print("Charge\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableGravity(_ARG_0_.myHandle, 0)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) <= 10 then
            Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          end
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            _ARG_0_.step = 1
          end
        else
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) <= 10 then
            Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          end
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        end
      end
    },
    SwingCharge2 = {
      OnBeginState = function(_ARG_0_)
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE0_ then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
          Entity.SetTimer(_ARG_0_.myHandle, 300)
        else
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
        end
        if _ARG_0_.kind == 2 then
          _ARG_0_.attackCount = _ARG_0_.attackCount + 1
          _ARG_0_.oldAttackState = "SwingCharge2"
        end
        _ARG_0_.step = 0
        print("SwingCharge2\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE0_)
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE1_ then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
            Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 1 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, -_UPVALUE0_)
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) >= _UPVALUE1_ or Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
            Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 15)
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
            _ARG_0_.step = 3
          end
        elseif _ARG_0_.step == 3 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 15)
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetAttackUseGroup(_ARG_0_.myHandle, 0)
            Entity.SetAttackUseGroup(_ARG_0_.myHandle, 1)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE4_, 1)
            _ARG_0_.step = 4
          end
        elseif _ARG_0_.step == 4 then
          if 15 >= Entity.GetMotionNowFrame(_ARG_0_.myHandle) then
            Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 15)
            Entity.CalcVelocityXZ(_ARG_0_.myHandle, -_UPVALUE0_)
          else
            Entity.ClearSpeed(_ARG_0_.myHandle)
          end
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 20 then
            Camera.QuakeV(50, 0.5, 12)
            _ARG_0_.step = 5
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    SwingCharge3 = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.attackCount = _ARG_0_.attackCount + 1
        _ARG_0_.oldAttackState = "SwingCharge3"
        _ARG_0_.step = 0
        print("SwingCharge3\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE0_)
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE1_ then
            Entity.SetAttackUseGroup(_ARG_0_.myHandle, 0)
            Entity.SetAttackUseGroup(_ARG_0_.myHandle, 1)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_, 1)
            Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) <= 15 then
            Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 15)
            Entity.CalcVelocityXZ(_ARG_0_.myHandle, -_UPVALUE0_)
          else
            Entity.ClearSpeed(_ARG_0_.myHandle)
          end
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 20 then
            Camera.QuakeV(50, 0.5, 12)
            _ARG_0_.step = 2
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("SwingCharge2")
        end
      end
    },
    BerserkCharge = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, 300)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        _ARG_0_.count = 0
        _ARG_0_.attackCount = _ARG_0_.attackCount + 1
        _ARG_0_.oldAttackState = "BerserkCharge"
        _ARG_0_.step = 0
        print("BerserkCharge\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, -_UPVALUE0_)
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) >= 64 or Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
            Enemy.SendMessage(30, _ARG_0_.myHandle, _ARG_0_.myHandle, _UPVALUE2_)
            Enemy.SendMessage(44, _ARG_0_.myHandle, _ARG_0_.myHandle, _UPVALUE2_)
            Enemy.SendMessage(58, _ARG_0_.myHandle, _ARG_0_.myHandle, _UPVALUE2_)
            Enemy.SendMessage(72, _ARG_0_.myHandle, _ARG_0_.myHandle, _UPVALUE2_)
            Enemy.SendMessage(86, _ARG_0_.myHandle, _ARG_0_.myHandle, _UPVALUE2_)
            Enemy.SendMessage(100, _ARG_0_.myHandle, _ARG_0_.myHandle, _UPVALUE2_)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
            Enemy.SendMessage(6, _ARG_0_.myHandle, _ARG_0_.myHandle, _UPVALUE4_)
            Enemy.SendMessage(14, _ARG_0_.myHandle, _ARG_0_.myHandle, _UPVALUE4_)
            Enemy.SendMessage(22, _ARG_0_.myHandle, _ARG_0_.myHandle, _UPVALUE4_)
            Entity.SetRootMoveScale(_ARG_0_.myHandle, 0 / 20, 1, 0 / 20)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) <= 7 then
            Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          end
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
            _ARG_0_.count = _ARG_0_.count + 1
            if _ARG_0_.count < _UPVALUE5_ then
              _ARG_0_.step = 1
            else
              Entity.SetAttackUseGroup(_ARG_0_.myHandle, 2)
              Entity.SetAttackUseGroup(_ARG_0_.myHandle, 3)
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE6_, 2)
              Entity.SetMotionSpeed(_ARG_0_.myHandle, 1.5)
              _ARG_0_.count = 0
              _ARG_0_.step = 3
            end
          end
        elseif _ARG_0_.step == 3 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) <= 15 then
            Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          end
          if 20 <= Entity.GetMotionNowFrame(_ARG_0_.myHandle) then
            Camera.QuakeV(50, 0.5, 12)
            _ARG_0_.step = 4
          end
        elseif _ARG_0_.step == 4 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.count = _ARG_0_.count + 1
          if _ARG_0_.count < _UPVALUE7_ then
            Entity.SetAttackUseGroup(_ARG_0_.myHandle, 2)
            Entity.SetAttackUseGroup(_ARG_0_.myHandle, 3)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE6_, 2)
            _ARG_0_.step = 3
          else
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        end
      end
    },
    SpiralRage1 = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 0, 0)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        _ARG_0_.count = 0
        _ARG_0_.hitCount = 0
        _ARG_0_.attackCount = _ARG_0_.attackCount + 1
        _ARG_0_.oldAttackState = "SpiralRage1"
        _ARG_0_.step = 0
        print("SpiralRage1\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.EnableGravity(_ARG_0_.myHandle, 0)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
        if _ARG_0_.step ~= 5 then
          Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
        end
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          _ARG_0_:TargetHoming(_UPVALUE0_, _UPVALUE0_ * 0.1, _UPVALUE0_ * 0.05)
          if Entity.IsTimeOver(_ARG_0_.myHandle) or _ARG_0_.hitCount >= _UPVALUE1_ then
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if 0 >= _ARG_0_.count then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
          else
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_, 1)
          end
          _ARG_0_.step = 2
        elseif _ARG_0_.step == 2 then
          Entity.CalcTargetPos(_UPVALUE3_, _ARG_0_.myHandle, _ARG_0_.targetHandle)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE3_, 10)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 7 then
            Entity.CalcOrbitVelocityFromSpeedY(_ARG_0_.myHandle, 0.35, (Entity.CalcDistanceXZ(_ARG_0_.myHandle, _UPVALUE3_)))
            Entity.EnableGravity(_ARG_0_.myHandle, 1)
            _ARG_0_.step = 3
          end
        elseif _ARG_0_.step == 3 then
          Entity.GetVelocity(_UPVALUE3_, _ARG_0_.myHandle)
          if 0 > _UPVALUE3_:gety() then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE4_)
            _ARG_0_.step = 4
          end
        elseif _ARG_0_.step == 4 then
          if Entity.IsGround(_ARG_0_.myHandle) then
            Camera.QuakeV(50, 0.5, 12)
            Entity.GetWorldPos(_UPVALUE3_, _ARG_0_.myHandle)
            _UPVALUE5_:set(0, 0, 0)
            SetBulletAttackParam(Bullet.CreateBullet("Shockwave", _UPVALUE3_, _UPVALUE5_), _ARG_0_.myHandle, 8)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.count = _ARG_0_.count + 1
            if _ARG_0_.count < _UPVALUE6_ then
              _ARG_0_.step = 1
            else
              Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE7_)
              _ARG_0_.step = 5
            end
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    SpiralRage2 = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        _ARG_0_.step = 0
        _ARG_0_.timer = 0
        _ARG_0_.attackCount = _ARG_0_.attackCount + 1
        _ARG_0_.oldAttackState = "SpiralRage2"
        print("SpiralRage2\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.EnableGravity(_ARG_0_.myHandle, 0)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 >= _ARG_0_.timer then
            Entity.SetRot(_ARG_0_.myHandle, 0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle), 0)
            _ARG_0_.timer = 120
          end
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE0_)
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.step = 1
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    BeamTrigger = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        _ARG_0_.attackCount = _ARG_0_.attackCount + 1
        _ARG_0_.oldAttackState = "BeamTrigger"
        _ARG_0_.fireEffectHandle = NULL_HANDLE
        _ARG_0_.step = 0
        print("BeamTrigger\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        for _FORV_4_, _FORV_5_ in pairs(_ARG_0_.thinLaserHandle) do
          Entity.Out(_FORV_5_)
        end
        Effect.LoopEnd(_ARG_0_.fireEffectHandle)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 1)
          _ARG_0_.laserCount = 0
          _ARG_0_.thinLaserHandle[1] = _ARG_0_:CreateLaser(1, 0, 0)
          _ARG_0_.thinLaserHandle[2] = _ARG_0_:CreateLaser(0, 1, 0)
          _ARG_0_.thinLaserHandle[3] = _ARG_0_:CreateLaser(1, _UPVALUE1_, DegToRad(90))
          _ARG_0_.thinLaserHandle[4] = _ARG_0_:CreateLaser(1, -_UPVALUE1_, DegToRad(270))
          _ARG_0_.thinLaserHandle[5] = _ARG_0_:CreateLaser(_UPVALUE1_, 1, DegToRad(270))
          _ARG_0_.thinLaserHandle[6] = _ARG_0_:CreateLaser(-_UPVALUE1_, 1, DegToRad(90))
          _UPVALUE2_:set(2.4, 0, 0)
          _UPVALUE3_:set(0, 0, 0)
          _ARG_0_.fireEffectHandle = Entity.AttachEffect(_ARG_0_.myHandle, _UPVALUE4_, "B023_BMT_FIR0_0", "koshi", _UPVALUE2_, _UPVALUE3_)
          Effect.SetAttachNoRot(_ARG_0_.fireEffectHandle, true)
          Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
          _ARG_0_.step = 2
        elseif _ARG_0_.step == 2 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE5_)
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            for _FORV_4_, _FORV_5_ in pairs(_ARG_0_.thinLaserHandle) do
              Entity.Out(_FORV_5_)
            end
            _ARG_0_.step = 6
          end
        elseif _ARG_0_.step == 3 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 5)
        elseif _ARG_0_.step == 4 then
          _UPVALUE2_:set(2.4, 0, 0)
          _UPVALUE3_:set(0, 0, 0)
          _ARG_0_.fireEffectHandle = Entity.AttachEffect(_ARG_0_.myHandle, _UPVALUE4_, "B023_BMT_FIR1_0", "koshi", _UPVALUE2_, _UPVALUE3_)
          Effect.SetAttachNoRot(_ARG_0_.fireEffectHandle, true)
          Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "koshi", _UPVALUE2_)
          SetBulletAttackParam(Bullet.CreateBullet("ThickLaser", _UPVALUE2_, _UPVALUE3_), _ARG_0_.myHandle, 12)
          if EntityManager:GetEntity((Bullet.CreateBullet("ThickLaser", _UPVALUE2_, _UPVALUE3_))) ~= nil then
            EntityManager:GetEntity((Bullet.CreateBullet("ThickLaser", _UPVALUE2_, _UPVALUE3_))).parentHandle = _ARG_0_.myHandle
            _UPVALUE2_:copy(_ARG_0_.targetPos)
            _UPVALUE3_:copy(_UPVALUE2_)
            _UPVALUE2_:sety(_UPVALUE2_:gety() + 1)
            _UPVALUE3_:sety(_UPVALUE3_:gety() - 50)
            Collision.IntersectRayBg(_ARG_0_.targetPos, COLL_KIND_ENEMY, _UPVALUE2_, _UPVALUE3_)
            EntityManager:GetEntity((Bullet.CreateBullet("ThickLaser", _UPVALUE2_, _UPVALUE3_))).targetPos:copy(_ARG_0_.targetPos)
          end
          for _FORV_6_, _FORV_7_ in pairs(_ARG_0_.thinLaserHandle) do
            Entity.Out(_FORV_7_)
          end
          _ARG_0_.thickLaserHandle = Bullet.CreateBullet("ThickLaser", _UPVALUE2_, _UPVALUE3_)
          _ARG_0_.step = 5
        elseif _ARG_0_.step == 5 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 5)
          if Entity.IsAlive(_ARG_0_.thickLaserHandle) == false then
            if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
              _ARG_0_.step = 1
            else
              _ARG_0_.step = 6
            end
          end
        elseif _ARG_0_.step == 6 then
          _UPVALUE2_:set(0, -0.1, 0)
          Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE2_)
          _ARG_0_.step = 7
        elseif Entity.IsGround(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Volcano = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        _ARG_0_.attackCount = _ARG_0_.attackCount + 1
        _ARG_0_.oldAttackState = "Volcano"
        _ARG_0_.step = 0
        _ARG_0_.step2 = 0
        print("Volcano\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
        Entity.SetAlpha(_ARG_0_.myHandle, 1)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
            Entity.SetAlpha(_ARG_0_.myHandle, 1)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if _ARG_0_.step2 == 0 then
            if Entity.GetTimer(_ARG_0_.myHandle) <= _UPVALUE0_ * 0.3 then
              Camera.QuakeV(30, 0.2, 10)
              Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
              Sound.PlaySe(264, 33, 1, _UPVALUE1_)
              _ARG_0_.step2 = 2
            end
          else
            Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.targetHandle)
            _UPVALUE1_:sety(0)
            Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE1_)
          end
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Camera.QuakeV(120, 0.5, 30)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
            Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
            Entity.SetAlpha(_ARG_0_.myHandle, 1)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 5 then
            Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
            _UPVALUE3_:set(0, 0, 0)
            SetBulletAttackParam(Bullet.CreateBullet("Eruption", _UPVALUE1_, _UPVALUE3_), _ARG_0_.myHandle, 14)
            _ARG_0_.step = 3
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Imprisonment = {
      OnBeginState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        if Entity.IsAlive(_ARG_0_.prisonHandle) then
          _ARG_0_.step = 3
        else
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
          _ARG_0_.attackCount = _ARG_0_.attackCount + 1
          _ARG_0_.step = 0
        end
        _ARG_0_.oldAttackState = "Imprisonment"
        print("Imprisonment\n")
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 32 then
            _ARG_0_.prisonHandle = _ARG_0_:CreatePrison()
            if EntityManager:GetEntity(_ARG_0_.prisonHandle) ~= nil then
              EntityManager:GetEntity(_ARG_0_.prisonHandle).prisonerHandle = _ARG_0_.myHandle
            end
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
            Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        else
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    FireImprisonment = {
      OnBeginState = function(_ARG_0_)
        if Entity.IsAlive(_ARG_0_.prisonHandle) then
          _ARG_0_.step = 3
        else
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
          _ARG_0_.attackCount = _ARG_0_.attackCount + 1
          _ARG_0_.step = 0
        end
        _ARG_0_.oldAttackState = "FireImprisonment"
        print("FireImprisonment\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 32 then
            _ARG_0_.prisonHandle = _ARG_0_:CreatePrison()
            if EntityManager:GetEntity(_ARG_0_.prisonHandle) ~= nil then
              Entity.SetMotion(_ARG_0_.prisonHandle, 1, 1)
              EntityManager:GetEntity(_ARG_0_.prisonHandle).fire = true
              EntityManager:GetEntity(_ARG_0_.prisonHandle).prisonerHandle = _ARG_0_.myHandle
            end
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        else
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    SekihekiHisyouDan = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 1)
        _ARG_0_.attackCount = _ARG_0_.attackCount + 1
        _ARG_0_.oldAttackState2 = "SekihekiHisyouDan"
        _ARG_0_.count = 1
        _ARG_0_.step = 0
        print("SekihekiHisyouDan\n")
      end,
      OnEndState = function(_ARG_0_)
        Effect.KillEffect(_ARG_0_.shdEffectHandle)
        if Script.IsEndFadeOut() then
          Script.StartFadeIn(0, true)
        end
        _UPVALUE0_:set(1, 1, 1)
        Gimmick.SetSceneColoer(_UPVALUE0_, 0)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsMotionLoop(_ARG_0_.myHandle) then
            Entity.SetTimer(_ARG_0_.myHandle, 15)
            print("SekihekiHisyouDan1\n")
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 1, 0)
            Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, (Entity.GetMotionTotalFrame(_ARG_0_.myHandle)))
            Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
            Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
            Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
            print("SekihekiHisyouDan2\n")
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if Entity.IsModelFade(_ARG_0_.myHandle) == false then
            Script.StartFadeOut(5, true)
            print("SekihekiHisyouDan3\n")
            _ARG_0_.step = 3
          end
        elseif _ARG_0_.step == 3 then
          if Script.IsEndFadeOut() then
            for _FORV_4_ = #_ARG_0_.panelHandleArray, 1, -1 do
              _ARG_0_.panelHandleArray[_FORV_4_] = _ARG_0_.panelHandleArray[Math.integer(_FORV_4_ * Script.Random() + 1)]
              _ARG_0_.panelHandleArray[Math.integer(_FORV_4_ * Script.Random() + 1)] = _ARG_0_.panelHandleArray[_FORV_4_]
            end
            for _FORV_4_, _FORV_5_ in pairs(_ARG_0_.panelHandleArray) do
              if EntityManager:GetEntity(_FORV_5_) ~= nil then
                EntityManager:GetEntity(_FORV_5_):GotoState("Appear")
              else
                print("panel == nil\n")
              end
            end
            _UPVALUE1_:set(0, 0, 0)
            _ARG_0_.shdEffectHandle = Entity.SetEffect(_ARG_0_.myHandle, _UPVALUE2_, "B023_SHD_FIR0_0", _UPVALUE1_, _UPVALUE1_)
            _UPVALUE1_:set(1, 0.5, 0.5)
            Gimmick.SetSceneColoer(_UPVALUE1_, 5)
            _ARG_0_:CtrlGimmickPanel(0, 0)
            Script.StartFadeIn(5, true)
            print("SekihekiHisyouDan4\n")
            _ARG_0_.step = 4
          end
        elseif _ARG_0_.step == 4 then
          if Script.IsEndFadeIn() then
            Entity.SetTimer(_ARG_0_.myHandle, 0)
            print("SekihekiHisyouDan5\n")
            _ARG_0_.step = 5
          end
        elseif _ARG_0_.step == 5 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            if 4 < _ARG_0_.count then
              for _FORV_4_ = 1, 4 do
                if EntityManager:GetEntity(_ARG_0_.panelHandleArray[_FORV_4_]) ~= nil and EntityManager:GetEntity(_ARG_0_.panelHandleArray[_FORV_4_]):GetState() ~= "Wait" then
                  return
                end
              end
              for _FORV_4_ = 5, 8 do
                if EntityManager:GetEntity(_ARG_0_.panelHandleArray[_FORV_4_]) ~= nil then
                  EntityManager:GetEntity(_ARG_0_.panelHandleArray[_FORV_4_]):GotoState("Rush2")
                end
              end
              _FOR_.SetTimer(_ARG_0_.myHandle, _UPVALUE3_)
              print("SekihekiHisyouDan6\n")
              _ARG_0_.step = 6
            else
              if EntityManager:GetEntity(_ARG_0_.panelHandleArray[_ARG_0_.count]) ~= nil then
                EntityManager:GetEntity(_ARG_0_.panelHandleArray[_ARG_0_.count]):GotoState("Rotate")
              end
              _ARG_0_.count = _ARG_0_.count + 1
              Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE4_ * 4)
            end
          end
        elseif _ARG_0_.step == 6 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Enemy.SendMessage(0, _ARG_0_.myHandle, _ARG_0_.myHandle, _UPVALUE5_)
            Script.StartFadeOut(5, true)
            print("SekihekiHisyouDan7\n")
            _ARG_0_.step = 7
          end
        elseif _ARG_0_.step == 7 then
          if Script.IsEndFadeOut() then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE6_)
            Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, 10)
            Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
            Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
            Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
            _UPVALUE1_:set(0, 0, 0)
            Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE1_)
            Effect.KillEffect(_ARG_0_.shdEffectHandle)
            Script.StartFadeIn(5, true)
            _UPVALUE1_:set(1, 1, 1)
            Gimmick.SetSceneColoer(_UPVALUE1_, 5)
            _ARG_0_:CtrlGimmickPanel(1, 1)
            print("SekihekiHisyouDan8\n")
            _ARG_0_.step = 8
          end
        elseif _ARG_0_.step == 8 then
          if Script.IsEndFadeIn() then
            Entity.SetTimer(_ARG_0_.myHandle, 60)
            print("SekihekiHisyouDan9\n")
            _ARG_0_.step = 9
          end
        elseif Entity.IsTimeOver(_ARG_0_.myHandle) then
          print("SekihekiHisyouDan10\n")
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    BakuenRetsuka = {
      OnBeginState = function(_ARG_0_)
        Entity.SetTimer(_ARG_0_.myHandle, 0)
        Enemy.SetGeneralPurposeAttackColl(_ARG_0_.myHandle, COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, _UPVALUE0_)
        Enemy.SetGeneralPurposeAttackCollParam(_ARG_0_.myHandle, Enemy.GetAttackKind(_ARG_0_.myHandle, 17), Enemy.GetAttackAttr(_ARG_0_.myHandle, 17), _UPVALUE1_, 100, _UPVALUE2_)
        _ARG_0_.attackCount = _ARG_0_.attackCount + 1
        _ARG_0_.count = 0
        _ARG_0_.step = 1
        print("BakuenRetsuka\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetAlpha(_ARG_0_.myHandle, 1)
        Effect.LoopEnd(_ARG_0_.effHandle)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
        Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 0)
        _UPVALUE0_:set(0, 0, 0)
        Entity.SetupMovement(_ARG_0_.myHandle, 0, _UPVALUE0_, 0)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 2)
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
          Enemy.SetGeneralPurposeAttackColl(_ARG_0_.myHandle, COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, _UPVALUE2_)
          Enemy.SetGeneralPurposeAttackCollParam(_ARG_0_.myHandle, Enemy.GetAttackKind(_ARG_0_.myHandle, 17), Enemy.GetAttackAttr(_ARG_0_.myHandle, 17), _UPVALUE3_, 100, _UPVALUE1_)
          Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 1)
          Entity.GetWorldPos(_UPVALUE4_, _ARG_0_.myHandle)
          Enemy.SetGeneralPurposeAttackCollPos(_ARG_0_.myHandle, _UPVALUE4_, _UPVALUE4_)
          _ARG_0_.step = 1
        elseif _ARG_0_.step == 1 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE5_, 2, 1)
            Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, (Entity.GetMotionTotalFrame(_ARG_0_.myHandle)))
            Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
            Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
            Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
            Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 0)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE6_)
            Entity.GetWorldPos(_UPVALUE4_, _ARG_0_.targetHandle)
            Entity.GetStartPos(_UPVALUE7_, _ARG_0_.myHandle)
            _UPVALUE4_:set(0, _UPVALUE7_:gety(), 20)
            _UPVALUE7_:set(0, RoundPI((Script.RandomInRange(Math.Atan2(-_UPVALUE4_:getx(), -_UPVALUE4_:getz()) - PI * 0.5, Math.Atan2(-_UPVALUE4_:getx(), -_UPVALUE4_:getz()) + PI * 0.5))), 0)
            Math.RotateVectorXYZ(_UPVALUE4_, _UPVALUE7_)
            Entity.SetupMovement(_ARG_0_.myHandle, 1, _UPVALUE4_, _UPVALUE8_)
            _UPVALUE4_:set(0, 0, 0)
            _ARG_0_.effHandle = Entity.AttachEffect(_ARG_0_.myHandle, _UPVALUE9_, "B023_BAK_KAZ0_0", "hara", _UPVALUE4_, _UPVALUE4_)
            _ARG_0_.step = 3
          end
        elseif _ARG_0_.step == 3 then
          if Entity.IsArraivalInterpolate(_ARG_0_.myHandle) then
            Effect.LoopEnd(_ARG_0_.effHandle)
            Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
            Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
            Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
            Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, 30)
            Entity.GetWorldPos(_UPVALUE4_, _ARG_0_.myHandle)
            _UPVALUE7_:set(0, 0, 0)
            Entity.SetEffect(_ARG_0_.myHandle, _UPVALUE9_, "B023_BAK_APP0_0", _UPVALUE4_, _UPVALUE7_)
            _ARG_0_.step = 4
          end
        elseif _ARG_0_.step == 4 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          if Entity.IsModelFade(_ARG_0_.myHandle) == false then
            _ARG_0_.count = _ARG_0_.count + 1
            if _ARG_0_.count < _UPVALUE10_ then
              _ARG_0_.step = 0
            else
              _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
            end
          end
        end
      end
    },
    ResetAttackCount = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_.attackCount = 0
        print("ResetAttackCount\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      end
    },
    ResetDmgCount = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_.dmgCount = 0
        print("ResetDmgCount\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      end
    },
    Dead = {
      OnBeginState = function(_ARG_0_)
        Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 180)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 and Entity.IsModelFade(_ARG_0_.myHandle) == false then
          Enemy.Dead(_ARG_0_.myHandle)
          _ARG_0_.step = 1
        end
      end
    }
  },
  RestHpRate = function(_ARG_0_)
    return Enemy.GetHp(_ARG_0_.myHandle) / Enemy.GetHpMax(_ARG_0_.myHandle)
  end,
  SelectAttackState = function(_ARG_0_, _ARG_1_, _ARG_2_)
    for _FORV_6_, _FORV_7_ in pairs(_ARG_2_) do
      if _FORV_6_ == _ARG_0_.oldAttackState then
        return _FORV_7_[Script.RandomInteger(#_FORV_7_) + 1]
      end
    end
    return _ARG_1_
  end,
  CreateLaser = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    _UPVALUE0_:set(2.4, 0, 0)
    Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "koshi", _UPVALUE0_)
    _UPVALUE1_:set(0, 0, 0)
    SetBulletAttackParam(Bullet.CreateBullet("ThinLaser", _UPVALUE0_, _UPVALUE1_), _ARG_0_.myHandle, 11)
    if EntityManager:GetEntity((Bullet.CreateBullet("ThinLaser", _UPVALUE0_, _UPVALUE1_))) ~= nil then
      EntityManager:GetEntity((Bullet.CreateBullet("ThinLaser", _UPVALUE0_, _UPVALUE1_))).parentHandle = _ARG_0_.myHandle
      EntityManager:GetEntity((Bullet.CreateBullet("ThinLaser", _UPVALUE0_, _UPVALUE1_))).basePos:set(_ARG_1_, 0, _ARG_2_)
      EntityManager:GetEntity((Bullet.CreateBullet("ThinLaser", _UPVALUE0_, _UPVALUE1_))).theta = _ARG_3_
      _ARG_0_.laserCount = _ARG_0_.laserCount + 1
      Effect.SetModel(Bullet.GetEffectHandle((Bullet.CreateBullet("ThinLaser", _UPVALUE0_, _UPVALUE1_))), _ARG_0_.myHandle)
    end
    return (Bullet.CreateBullet("ThinLaser", _UPVALUE0_, _UPVALUE1_))
  end,
  TargetHoming = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
    Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.targetHandle)
    FVECTOR3.Sub(_UPVALUE1_, _UPVALUE1_, _UPVALUE0_)
    _UPVALUE1_:scale(_ARG_1_)
    Entity.GetVelocity(_UPVALUE2_, _ARG_0_.myHandle)
    FVECTOR3.Sub(_UPVALUE1_, _UPVALUE1_, _UPVALUE2_)
    _UPVALUE1_:scale(_ARG_3_)
    if _ARG_2_ <= _UPVALUE1_:length() then
      _UPVALUE1_:normalize()
      _UPVALUE1_:scale(_ARG_2_)
    end
    FVECTOR3.Add(_UPVALUE2_, _UPVALUE2_, _UPVALUE1_)
    if _ARG_1_ < _UPVALUE2_:length() then
      _UPVALUE2_:normalize()
      _UPVALUE2_:scale(_ARG_1_)
    end
    Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE2_)
  end,
  CreatePrison = function(_ARG_0_)
    _UPVALUE0_:set(0, 0, 4)
    Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "Root", _UPVALUE0_)
    Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
    return Entity.CreateEntity("b14vs00", _UPVALUE0_, _UPVALUE1_)
  end,
  CtrlGimmickPanel = function(_ARG_0_, _ARG_1_, _ARG_2_)
    if Gimmick.SearchGimmick("g52vs00") ~= NULL_HANDLE then
      Entity.SetMotion(Gimmick.SearchGimmick("g52vs00"), _ARG_1_)
      Entity.SetModelPartsAlpha(Gimmick.SearchGimmick("g52vs00"), 1, _ARG_2_)
    end
  end,
  CleanupLaser = function(_ARG_0_)
    if _ARG_0_.thinLaserHandle == nil then
      return
    end
    for _FORV_4_, _FORV_5_ in pairs(_ARG_0_.thinLaserHandle) do
      Entity.Out(_FORV_5_)
      _ARG_0_.thinLaserHandle[_FORV_4_] = NULL_HANDLE
    end
    Entity.Out(_ARG_0_.thickLaserHandle)
    _ARG_0_.thickLaserHandle = NULL_HANDLE
    Effect.LoopEnd(_ARG_0_.fireEffectHandle)
    _ARG_0_.fireEffectHandle = NULL_HANDLE
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    _UPVALUE0_ = Entity.GetMotionIndex(_ARG_1_, "010")
    _UPVALUE1_ = Entity.GetMotionIndex(_ARG_1_, "030")
    _UPVALUE2_ = Entity.GetMotionIndex(_ARG_1_, "031")
    _UPVALUE3_ = Entity.GetMotionIndex(_ARG_1_, "032")
    _UPVALUE4_ = Entity.GetMotionIndex(_ARG_1_, "033")
    _UPVALUE5_ = Entity.GetMotionIndex(_ARG_1_, "220")
    _UPVALUE6_ = Entity.GetMotionIndex(_ARG_1_, "221")
    _UPVALUE7_ = Entity.GetMotionIndex(_ARG_1_, "222")
    _UPVALUE8_ = Entity.GetMotionIndex(_ARG_1_, "223")
    _UPVALUE9_ = Entity.GetMotionIndex(_ARG_1_, "300")
    _UPVALUE10_ = Entity.GetMotionIndex(_ARG_1_, "301")
    _UPVALUE11_ = Entity.GetMotionIndex(_ARG_1_, "302")
    _UPVALUE12_ = Entity.GetMotionIndex(_ARG_1_, "303")
    _UPVALUE13_ = Entity.GetMotionIndex(_ARG_1_, "304")
    _UPVALUE14_ = Entity.GetMotionIndex(_ARG_1_, "305")
    _UPVALUE15_ = Entity.GetMotionIndex(_ARG_1_, "306")
    _UPVALUE16_ = Entity.GetMotionIndex(_ARG_1_, "307")
    _UPVALUE17_ = Entity.GetMotionIndex(_ARG_1_, "308")
    _UPVALUE18_ = Entity.GetMotionIndex(_ARG_1_, "309")
    _UPVALUE19_ = Entity.GetMotionIndex(_ARG_1_, "310")
    _UPVALUE20_ = Entity.GetMotionIndex(_ARG_1_, "311")
    _UPVALUE21_ = Entity.GetMotionIndex(_ARG_1_, "312")
    _UPVALUE22_ = Entity.GetMotionIndex(_ARG_1_, "313")
    _UPVALUE23_ = Entity.GetMotionIndex(_ARG_1_, "314")
    _UPVALUE24_ = Entity.GetMotionIndex(_ARG_1_, "315")
    _UPVALUE25_ = Entity.GetMotionIndex(_ARG_1_, "316")
    _UPVALUE26_ = Entity.GetMotionIndex(_ARG_1_, "317")
    _UPVALUE27_ = Enemy.GetExtraParam(_ARG_1_, "IdlingN0") * 60
    _UPVALUE28_ = Enemy.GetExtraParam(_ARG_1_, "IdlingN1") * 60
    _UPVALUE29_ = Enemy.GetExtraParam(_ARG_1_, "IdlingF0") * 60
    _UPVALUE30_ = Enemy.GetExtraParam(_ARG_1_, "IdlingF1") * 60
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.targetHandle = NULL_HANDLE
    _ARG_0_.effHandle = NULL_HANDLE
    _ARG_0_.prisonHandle = NULL_HANDLE
    _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
    _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
    _ARG_0_.warpPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.step = 0
    _ARG_0_.step2 = 0
    _ARG_0_.dmgCount = 0
    _ARG_0_.count = 0
    _ARG_0_.attackCount = 0
    _ARG_0_.hitCount = 0
    _ARG_0_.timer = 0
    _ARG_0_.fireEffectHandle = NULL_HANDLE
    _ARG_0_.oldAttackState = ""
    _ARG_0_.oldAttackState2 = ""
    _ARG_0_.shdEffectHandle = NULL_HANDLE
    _ARG_0_.stack = Stack:Create()
    if Entity.GetName(_ARG_1_) == "b10vs00" then
      _ARG_0_.kind = 1
      _ARG_0_.thinLaserHandle = {}
      for _FORV_6_ = 1, 6 do
        _ARG_0_.thinLaserHandle[_FORV_6_] = NULL_HANDLE
      end
      _ARG_0_.thickLaserHandle = _FOR_
      _ARG_0_.idlingTime0 = _UPVALUE27_
      _ARG_0_.idlingTime1 = _UPVALUE28_
    elseif Entity.GetName(_ARG_1_) == "b11vs00" then
      _ARG_0_.kind = 2
      _ARG_0_.thinLaserHandle = {}
      for _FORV_6_ = 1, 6 do
        _ARG_0_.thinLaserHandle[_FORV_6_] = NULL_HANDLE
      end
      _ARG_0_.thickLaserHandle = _FOR_
      _ARG_0_.idlingTime0 = _UPVALUE27_
      _ARG_0_.idlingTime1 = _UPVALUE28_
    elseif Entity.GetName(_ARG_1_) == "b12vs00" then
      _ARG_0_.kind = 3
      _ARG_0_.idlingTime0 = _UPVALUE27_
      _ARG_0_.idlingTime1 = _UPVALUE28_
    else
      _ARG_0_.kind = 4
      _ARG_0_.panelHandleArray = {
        NULL_HANDLE,
        NULL_HANDLE,
        NULL_HANDLE,
        NULL_HANDLE,
        NULL_HANDLE,
        NULL_HANDLE,
        NULL_HANDLE,
        NULL_HANDLE
      }
      for _FORV_6_, _FORV_7_ in pairs(_UPVALUE31_) do
        _UPVALUE32_:set(0, 0, 0)
        Entity.SetAttackKindForBodyColl(Entity.CreateEntity(_FORV_7_, _UPVALUE32_, _UPVALUE32_), Enemy.GetAttackKind(_ARG_0_.myHandle, 20))
        Entity.SetAttackPointForBodyColl(Entity.CreateEntity(_FORV_7_, _UPVALUE32_, _UPVALUE32_), Enemy.GetAttackPoint(_ARG_0_.myHandle, 20))
        Entity.SetAttackAttrForBodyColl(Entity.CreateEntity(_FORV_7_, _UPVALUE32_, _UPVALUE32_), Enemy.GetAttackAttr(_ARG_0_.myHandle, 20))
        Entity.SetTechniquePowerCorrectionForBodyColl(Entity.CreateEntity(_FORV_7_, _UPVALUE32_, _UPVALUE32_), Enemy.GetAttackPowerCorrection(_ARG_0_.myHandle, 20))
        _ARG_0_.panelHandleArray[_FORV_6_] = Entity.CreateEntity(_FORV_7_, _UPVALUE32_, _UPVALUE32_)
      end
      Enemy.EnableNoDamageReaction(_ARG_1_, 1)
    end
    Player.SetBossCamera("b10vs")
    Entity.SetMovementCollRadius(_ARG_1_, 3)
    Entity.SetLowerHalf(_ARG_1_, 3.5)
    Enemy.SetViewDist(_ARG_1_, 50)
    _ARG_0_:GotoState("Appear")
  end,
  OnDestroy = function(_ARG_0_)
    _ARG_0_:CleanupLaser()
  end,
  OnMessage = function(_ARG_0_, _ARG_1_, _ARG_2_)
    if _ARG_1_ == _UPVALUE0_ then
      if EntityManager:GetEntity(_ARG_2_) ~= nil then
        _ARG_0_.targetPos:copy(EntityManager:GetEntity(_ARG_2_).targetPos)
        for _FORV_7_, _FORV_8_ in pairs(_ARG_0_.thinLaserHandle) do
          if EntityManager:GetEntity(_FORV_8_) ~= nil then
            Entity.SetTimer(_FORV_8_, _UPVALUE1_)
            EntityManager:GetEntity(_FORV_8_).startPos:copy(EntityManager:GetEntity(_FORV_8_).targetPos)
            EntityManager:GetEntity(_FORV_8_).endPos:copy(EntityManager:GetEntity(_ARG_2_).targetPos)
            EntityManager:GetEntity(_FORV_8_).step = 2
            EntityManager:GetEntity(_FORV_8_).hitLaser = true
          end
        end
        _ARG_0_.step = 3
      end
    elseif _ARG_1_ == _UPVALUE2_ then
      _ARG_0_.laserCount = _ARG_0_.laserCount - 1
      if _ARG_0_.laserCount <= 0 then
        Effect.LoopEnd(_ARG_0_.fireEffectHandle)
        _ARG_0_.step = 4
      end
    elseif _ARG_1_ == _UPVALUE3_ then
      Entity.GetWorldPos(_UPVALUE4_, _ARG_0_.myHandle, 2)
      _UPVALUE4_:setx(_UPVALUE4_:getx() + Math.Cos((Script.RandomInRange(-PI, PI))) * (1 + Script.Random() * 3))
      _UPVALUE4_:setz(_UPVALUE4_:getz() + Math.Sin((Script.RandomInRange(-PI, PI))) * (1 + Script.Random() * 3))
      _UPVALUE4_:sety(_UPVALUE4_:gety() + Script.RandomInRange(-1, 1))
      _UPVALUE5_:set(0, 0, 0)
      SetBulletAttackParam(Bullet.CreateBullet("ExplosionS", _UPVALUE4_, _UPVALUE5_), _ARG_0_.myHandle, 4)
    elseif _ARG_1_ == _UPVALUE6_ then
      Entity.GetWorldPos(_UPVALUE4_, _ARG_0_.myHandle)
      _UPVALUE5_:set(0, 0, 0)
      SetBulletAttackParam(Bullet.CreateBullet("ExplosionL", _UPVALUE4_, _UPVALUE5_), _ARG_0_.myHandle, 5)
    elseif _ARG_1_ == _UPVALUE7_ then
      Entity.GetWorldPos(_UPVALUE4_, _ARG_0_.myHandle, 2)
      _UPVALUE5_:set(0, 0, 0)
      SetBulletAttackParam(Bullet.CreateBullet("ExplodeSHD0", _UPVALUE4_, _UPVALUE5_), _ARG_0_.myHandle, 15)
    elseif _ARG_1_ == _UPVALUE8_ then
      _UPVALUE4_:set(0, 3, 0)
      _UPVALUE5_:set(0, 0, 0)
      SetBulletAttackParam(Bullet.CreateBullet("ExplodeSHD1", _UPVALUE4_, _UPVALUE5_), _ARG_0_.myHandle, 16)
    end
  end,
  OnSetMotion = function(_ARG_0_, _ARG_1_)
  end,
  OnReturnDamage = function(_ARG_0_)
    _ARG_0_:GotoState("Landing")
  end,
  OnHitAttack = function(_ARG_0_)
    _ARG_0_.hitCount = _ARG_0_.hitCount + 1
  end,
  OnDamage = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    _ARG_0_.dmgCount = _ARG_0_.dmgCount + 1
    return 0
  end,
  OnBeginDamageReaction = function(_ARG_0_)
    _ARG_0_:CleanupLaser()
    Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, 1)
    if _ARG_0_:GetState() == "SpiralRage1" and _ARG_0_.step ~= 5 then
      Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
    end
  end,
  OnDead = function(_ARG_0_)
    if _ARG_0_.thinLaserHandle ~= nil then
      _ARG_0_:CleanupLaser()
    end
    SetupBossDead(_ARG_0_.myHandle)
    _ARG_0_:GotoState("Dead")
    return 1
  end,
  OnUpdate = function(_ARG_0_)
    _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
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
        _ARG_0_.stack:clear()
        if Entity.GetName(_ARG_0_.myHandle) == "b10vs00" then
          _ARG_0_.stack:push("Idling1")
        elseif Entity.GetName(_ARG_0_.myHandle) == "b11vs00" then
          _ARG_0_.stack:push("Idling2")
        elseif Entity.GetName(_ARG_0_.myHandle) == "b12vs00" then
          _ARG_0_.stack:push("Idling3")
        elseif Entity.GetName(_ARG_0_.myHandle) == "b13vs00" then
          _ARG_0_.stack:push("Idling4")
        end
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        _ARG_0_:GotoState(_UPVALUE0_[Script.GetDebugAttackNumber() + 1])
      end
    end
  end
}, {__index = __StateMachine})
EntityFactory:Add("b10vs00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b11vs00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b12vs00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b13vs00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("ThinLaser", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("ThickLaser", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("PillarOfFire", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("Eruption", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("Shockwave", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("ExplosionS", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("ExplosionL", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("ExplodeSHD0", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("ExplodeSHD1", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
setmetatable({
  new = function(_ARG_0_)
    return setmetatable(__StateMachine:new(), _UPVALUE0_)
  end,
  states = {
    Appear = {
      OnBeginState = function(_ARG_0_)
        Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
        _UPVALUE1_:set(0, 0, 0)
        Entity.SetEffect(_ARG_0_.myHandle, _UPVALUE2_, "B023_PSN_APP0_0", _UPVALUE0_, _UPVALUE1_)
        Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, 60)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE3_)
        print("b14vs00 ... Appear\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Rotation")
        end
      end
    },
    Rotation = {
      OnBeginState = function(_ARG_0_)
        _UPVALUE0_:set(0, 0.15, 0)
        Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE0_)
        Enemy.SetNoNetworkRecvPos(_ARG_0_.myHandle, 1)
        _ARG_0_.step = 0
        print("b14vs00 ... Rotation\n")
      end,
      OnEndState = function(_ARG_0_)
        Enemy.SetNoNetworkRecvPos(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.prisonerHandle)
          Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
          if _UPVALUE1_:gety() >= _UPVALUE0_:gety() + 2 then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE2_)
            _ARG_0_.step = 1
          end
        else
          Entity.GetLocalPos(_UPVALUE1_, _ARG_0_.myHandle)
          _ARG_0_.theta = RoundPI(_ARG_0_.theta + DegToRad(_UPVALUE3_ * Entity.GetFrameRate(_ARG_0_.myHandle)))
          _UPVALUE0_:set(Math.Cos(_ARG_0_.theta) * _UPVALUE4_, 0, Math.Sin(_ARG_0_.theta) * _UPVALUE4_)
          Entity.ApplyBoneMatrix(_ARG_0_.prisonerHandle, "Root", _UPVALUE0_)
          _UPVALUE0_:sety(_UPVALUE1_:gety())
          Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE0_)
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:GotoState("Dive")
          end
        end
      end
    },
    Dive = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_.step = 0
        Enemy.SetNoNetworkRecvPos(_ARG_0_.myHandle, 1)
        print("b14vs00 ... Dive\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Enemy.SetNoNetworkRecvPos(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        _UPVALUE0_:set(0, -0.1, 0)
        Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE0_)
        if _ARG_0_.step == 0 then
          if Entity.IsGround(_ARG_0_.myHandle) then
            Entity.EnableBgColl(_ARG_0_.myHandle, 0)
            Entity.GetLocalPos(_UPVALUE0_, _ARG_0_.myHandle)
            _UPVALUE0_:sety(0)
            _UPVALUE1_:set(0, 0, 0)
            Entity.SetEffect(_ARG_0_.myHandle, _UPVALUE2_, "B023_PSN_ZMN0_0", _UPVALUE0_, _UPVALUE1_)
            Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
            _ARG_0_.step = 1
          end
        else
          Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
          if _UPVALUE0_:gety() < -_UPVALUE3_ then
            _UPVALUE0_:sety(-_UPVALUE3_)
            Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE0_)
            _ARG_0_:GotoState("Pursuit")
          end
        end
      end
    },
    Pursuit = {
      OnBeginState = function(_ARG_0_)
        _UPVALUE0_:set(0, _UPVALUE1_, 0)
        _UPVALUE2_:set(0, 0, 0)
        _ARG_0_.effHandle = Entity.AttachEffect(_ARG_0_.myHandle, _UPVALUE3_, "B023_PSN_RUN0_0", "Root", _UPVALUE0_, _UPVALUE2_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE4_)
        print("b14vs00 ... Pursuit\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Effect.DetachCoord(_ARG_0_.effHandle)
        Effect.LoopEnd(_ARG_0_.effHandle)
        _ARG_0_:SetupImprisonmentCollision()
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoStateSub("Dead")
          return
        end
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE0_)
        Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 0)
        if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= 1 then
          _ARG_0_:GotoState("Capture")
        end
      end
    },
    Capture = {
      OnBeginState = function(_ARG_0_)
        _UPVALUE0_:set(0, _UPVALUE1_, 0)
        Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.GetLocalPos(_UPVALUE0_, _ARG_0_.myHandle)
        _UPVALUE0_:sety(0)
        _UPVALUE2_:set(0, 0, 0)
        Entity.SetEffect(_ARG_0_.myHandle, _UPVALUE3_, "B023_PSN_ZMN0_0", _UPVALUE0_, _UPVALUE2_)
        _ARG_0_.step = 0
        print("b14vs00 ... Capture\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.EnableBgColl(_ARG_0_.myHandle, 1)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
        Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        _UPVALUE0_:set(0, _UPVALUE1_, 0)
        Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 4)
        Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.myHandle)
        Enemy.SetGeneralPurposeAttackCollPos(_ARG_0_.myHandle, _UPVALUE0_, _UPVALUE2_)
        Entity.GetLocalPos(_UPVALUE0_, _ARG_0_.myHandle)
        if 0 <= _UPVALUE0_:gety() then
          _UPVALUE0_:sety(0)
          Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE0_)
          Sound.PlaySe(264, 34, 1, _UPVALUE0_)
          if _ARG_0_.fire then
            _ARG_0_:GotoState("IdlingFireDamage")
          else
            _ARG_0_:GotoState("Idling")
          end
        end
      end
    },
    Idling = {
      OnBeginState = function(_ARG_0_)
        Entity.SetTimer(_ARG_0_.myHandle, 300)
        print("b14vs00 ... Idling\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) and _ARG_0_:IsTargetImprisonment() == false then
          _ARG_0_:GotoStateSub("Dead")
        end
      end
    },
    IdlingFireDamage = {
      OnBeginState = function(_ARG_0_)
        Entity.SetTimer(_ARG_0_.myHandle, 300)
        Enemy.SetGeneralPurposeAttackColl(_ARG_0_.myHandle, COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, 0.01)
        Enemy.SetGeneralPurposeAttackCollParam(_ARG_0_.myHandle, Enemy.GetAttackKind(_ARG_0_.myHandle, 1), Enemy.GetAttackAttr(_ARG_0_.myHandle, 1), Enemy.GetAttackPoint(_ARG_0_.myHandle, 1), Enemy.GetAttackPowerCorrection(_ARG_0_.myHandle, 1))
        _ARG_0_.timer = _UPVALUE0_
        print("b14vs00 ... IdlingFireDamage\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.timer <= 0 and _ARG_0_.captureHandle ~= NULL_HANDLE then
          Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.captureHandle, 2)
          Enemy.SetGeneralPurposeAttackCollPos(_ARG_0_.myHandle, _UPVALUE0_, _UPVALUE0_)
          Enemy.EnableGeneralPurposeUpdate(_ARG_0_.myHandle)
          Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 1)
          _ARG_0_.timer = _UPVALUE1_
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) and _ARG_0_:IsTargetImprisonment() == false then
          _ARG_0_:GotoStateSub("Dead")
        end
      end
    },
    Dead = {
      OnBeginState = function(_ARG_0_)
        Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
        _UPVALUE1_:set(0, 0, 0)
        Entity.SetEffect(_ARG_0_.myHandle, _UPVALUE2_, "B023_PSN_LOS0_0", _UPVALUE0_, _UPVALUE1_)
        Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 30)
        Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
        Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 0)
        _ARG_0_.step = 0
        print("b14vs00 ... Dead\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 and Entity.IsModelFade(_ARG_0_.myHandle) then
          Enemy.Dead(_ARG_0_.myHandle)
          _ARG_0_.step = 1
        end
      end
    }
  },
  IsTargetImprisonment = function(_ARG_0_)
    _ARG_0_.targetHandleTbl[1] = Player.GetPlayers()
    _ARG_0_.targetHandleTbl[2] = Player.GetPlayers()
    _ARG_0_.targetHandleTbl[3] = Player.GetPlayers()
    for _FORV_7_, _FORV_8_ in pairs(_ARG_0_.targetHandleTbl) do
      if _FORV_8_ ~= NULL_HANDLE and Player.GetPlayerState(_FORV_8_) ~= 15 and Player.IsDamageFlagImprisonment(_FORV_8_) then
        return true
      end
    end
    return false
  end,
  GetLockOnPos = function(_ARG_0_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
    _UPVALUE0_:sety(_UPVALUE0_:gety() + 0.4)
    return _UPVALUE0_
  end,
  SetupImprisonmentCollision = function(_ARG_0_)
    Enemy.SetGeneralPurposeAttackColl(_ARG_0_.myHandle, COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, 1)
    Enemy.SetGeneralPurposeAttackCollParam(_ARG_0_.myHandle, Enemy.GetAttackKind(_ARG_0_.myHandle, 0), Enemy.GetAttackAttr(_ARG_0_.myHandle, 0), Enemy.GetAttackPoint(_ARG_0_.myHandle, 0), Enemy.GetAttackPowerCorrection(_ARG_0_.myHandle, 0))
    Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 1)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 4)
    Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
    Enemy.SetGeneralPurposeAttackCollPos(_ARG_0_.myHandle, _UPVALUE0_, _UPVALUE1_)
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.targetHandle = NULL_HANDLE
    _ARG_0_.captureHandle = NULL_HANDLE
    _ARG_0_.effHandle = NULL_HANDLE
    _ARG_0_.prisonerHandle = NULL_HANDLE
    _ARG_0_.targetHandleTbl = {
      NULL_HANDLE,
      NULL_HANDLE,
      NULL_HANDLE
    }
    _ARG_0_.fire = false
    _ARG_0_.capture = false
    _ARG_0_.theta = PI * 0.5
    _ARG_0_.timer = 0
    Enemy.EnableHitback(_ARG_1_, 0)
    Enemy.EnableNoDamageReaction(_ARG_1_, 1)
    _ARG_0_:GotoState("Appear")
  end,
  OnReturnDamage = function(_ARG_0_)
    _ARG_0_:GotoState("Idling")
  end,
  OnDamage = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    return 0
  end,
  OnDead = function(_ARG_0_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
    _UPVALUE1_:set(0, 0, 0)
    Entity.SetEffect(_ARG_0_.myHandle, _UPVALUE2_, "B023_PSN_LOS0_0", _UPVALUE0_, _UPVALUE1_)
    Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
    Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
    Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
    Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 0)
    return 0
  end,
  OnUpdate = function(_ARG_0_)
    _ARG_0_:Update()
    if _ARG_0_:GetState() ~= "Dead" and Entity.GetHp(_ARG_0_.prisonerHandle) <= 0 then
      _ARG_0_:GotoStateSub("Dead")
    end
  end
}, {__index = __StateMachine})
EntityFactory:Add("b14vs00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
setmetatable({
  new = function(_ARG_0_)
    return setmetatable(__StateMachine:new(), _UPVALUE0_)
  end,
  states = {
    Appear = {
      OnBeginState = function(_ARG_0_)
        Entity.SetAlpha(_ARG_0_.myHandle, 1)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
        print("Panel ... Appear\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetAlpha(_ARG_0_.myHandle, 1)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
      end
    },
    Rotate = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_.roty = DegToRad(10)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
        print("Panel ... Rotate\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Rush")
        end
      end
    },
    Rush = {
      OnBeginState = function(_ARG_0_)
        Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 2)
        _UPVALUE1_:set(0, 0, 0)
        FVECTOR3.Sub(_UPVALUE1_, _UPVALUE1_, _UPVALUE0_)
        _UPVALUE1_:sety(0)
        Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 3)
        _ARG_0_.height = _UPVALUE0_:gety() + 0.5
        _UPVALUE1_:normalize()
        _UPVALUE1_:scale(_UPVALUE1_:length() * 2 / _UPVALUE2_)
        Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE1_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE2_)
        Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 1)
        _ARG_0_.step = 0
        _UPVALUE0_:set(0, 0, 0)
        _ARG_0_.effHandle = Entity.AttachEffect(_ARG_0_.myHandle, _UPVALUE3_, "B023_SHD_LOC0_0", "kaiten", _UPVALUE0_, _UPVALUE0_)
        Enemy.SetNoNetworkRecvPos(_ARG_0_.myHandle, 1)
        print("Panel ... Rush\n")
      end,
      OnEndState = function(_ARG_0_)
        Enemy.SetNoNetworkRecvPos(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        if 0 <= _ARG_0_.step and _ARG_0_.step <= 3 then
          Entity.GetLocalPos(_UPVALUE1_, _ARG_0_.myHandle)
          _UPVALUE1_:sety(-_ARG_0_.height * Math.Sin(DegToRad(180 * (Entity.GetTimer(_ARG_0_.myHandle) / _UPVALUE0_))))
          Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE1_)
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_.step = _ARG_0_.step + 1
            if _ARG_0_.step > 3 then
              _ARG_0_.roty = 0
              _UPVALUE1_:set(0, 0, 0)
              Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE1_)
              Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 15)
              Entity.ClearSpeed(_ARG_0_.myHandle)
              Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.myHandle, 2)
              Entity.SetEffect(_ARG_0_.myHandle, _UPVALUE3_, "B023_SHD_LOS0_0", _UPVALUE2_, _UPVALUE1_)
            else
              Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 1)
              Entity.GetVelocity(_UPVALUE1_, _ARG_0_.myHandle)
              _UPVALUE1_:scale(-1)
              Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE1_)
              Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
            end
          end
        elseif Entity.IsModelFade(_ARG_0_.myHandle) == false then
          _ARG_0_:GotoState("Wait")
        end
      end
    },
    Rush2 = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_.roty = DegToRad(10)
        Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 2)
        _UPVALUE1_:set(0, 0, 0)
        FVECTOR3.Sub(_UPVALUE1_, _UPVALUE1_, _UPVALUE0_)
        _UPVALUE1_:sety(0)
        Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 3)
        _ARG_0_.height = _UPVALUE0_:gety() + 0.5
        _UPVALUE1_:normalize()
        _UPVALUE1_:scale(_UPVALUE1_:length() / _UPVALUE2_)
        Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE1_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE2_)
        Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 1)
        _ARG_0_.step = 0
        _UPVALUE0_:set(0, 0, 0)
        _ARG_0_.effHandle = Entity.AttachEffect(_ARG_0_.myHandle, _UPVALUE3_, "B023_SHD_LOC0_0", "kaiten", _UPVALUE0_, _UPVALUE0_)
        Enemy.SetNoNetworkRecvPos(_ARG_0_.myHandle, 1)
        print("Panel ... Rush2\n")
      end,
      OnEndState = function(_ARG_0_)
        Enemy.SetNoNetworkRecvPos(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.GetLocalPos(_UPVALUE1_, _ARG_0_.myHandle)
          _UPVALUE1_:sety(-_ARG_0_.height * Math.Sin(DegToRad(90 - 90 * (Entity.GetTimer(_ARG_0_.myHandle) / _UPVALUE0_))))
          Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE1_)
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 5)
            Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
            Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 0)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.step = 1
          end
        elseif Entity.IsModelFade(_ARG_0_.myHandle) == false then
          _ARG_0_:GotoState("Wait")
        end
      end
    },
    Wait = {
      OnBeginState = function(_ARG_0_)
        Entity.SetAlpha(_ARG_0_.myHandle, 0)
        _UPVALUE0_:set(0, 0, 0)
        Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.ResetModelMatrix(_ARG_0_.myHandle)
        Effect.DetachCoord(_ARG_0_.effHandle)
        Effect.LoopEnd(_ARG_0_.effHandle)
        _ARG_0_.effHandle = NULL_HANDLE
        _ARG_0_.roty = 0
        print("Panel ... Wait\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
      end
    }
  },
  OnInit = function(_ARG_0_, _ARG_1_)
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.targetHandle = NULL_HANDLE
    _ARG_0_.height = 0
    _ARG_0_.roty = 0
    _ARG_0_.step = 0
    _ARG_0_.effHandle = NULL_HANDLE
    Enemy.SetHP(_ARG_1_, 1000)
    Entity.EnableBgColl(_ARG_1_, 0)
    Entity.EnableLockonAndShooton(_ARG_1_, 0)
    Entity.EnableDamageColl(_ARG_1_, 0)
    Enemy.SetNoNetworkRecvRot(_ARG_1_, 1)
    Enemy.SetNoNetworkHpCheck(_ARG_1_, 1)
    Enemy.EnableUpdateVision(_ARG_1_, 0)
    _ARG_0_:GotoState("Wait")
  end,
  OnHitAttack = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  end,
  OnReflect = function(_ARG_0_, _ARG_1_, _ARG_2_)
    return 1
  end,
  OnUpdate = function(_ARG_0_)
    _ARG_0_:Update()
    _UPVALUE0_:set(0, _ARG_0_.roty * Entity.GetFrameRate(_ARG_0_.myHandle), 0)
    Entity.RotateBoneZYX(_ARG_0_.myHandle, 2, _UPVALUE0_)
  end
}, {__index = __StateMachine})
EntityFactory:Add("b61vs00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b62vs00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b63vs00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b64vs00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b65vs00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b66vs00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b67vs00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b68vs00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
