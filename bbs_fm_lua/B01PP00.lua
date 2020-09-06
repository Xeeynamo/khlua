setmetatable({
  new = function(_ARG_0_)
    return setmetatable(__StateMachine:new(), _UPVALUE0_)
  end,
  states = {
    Appear = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
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
        Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_.idlingTimer)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        _ARG_0_.defenseFlag = false
        _ARG_0_.stack:clear()
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
        if _ARG_0_:Defense() then
          return
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
          return
        end
        _ARG_0_.idlingTimer = Script.RandomInRange(_UPVALUE0_, _UPVALUE0_ * 2)
        Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.targetHandle)
        if Entity.IsSwim(_ARG_0_.targetHandle) or _UPVALUE1_:gety() < 0 and Entity.IsGround(_ARG_0_.myHandle) then
          _ARG_0_:SetupAttack(4)
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          return
        end
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE2_ then
          _ARG_0_:SelectAttack()
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) >= _UPVALUE3_ then
          _ARG_0_:SetupAttack(4)
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        else
          _ARG_0_.stack:push("Idling")
          _ARG_0_:GotoState("Step")
        end
      end
    },
    TargetMove = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_:CheckFront(1) == false then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          return
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE0_)
        if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _ARG_0_.nearDist or Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    RushStab = {
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
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 24 then
            Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
            _ARG_0_.step = 1
          end
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          if _ARG_0_:CheckUnderfoot() == false and Script.Random() < 0.5 then
            _ARG_0_:SetupAttack(6)
          end
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    DisturbStab = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          if _ARG_0_:CheckUnderfoot() == false and Script.Random() < 0.5 then
            _ARG_0_:SetupAttack(6)
          end
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    RushXCutting = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        _ARG_0_.step = 0
        _ARG_0_.count = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Enemy.SetFaceAnim(_ARG_0_.myHandle, 1, 0)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 26 then
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE0_)
          if _ARG_0_.count >= _UPVALUE1_ or Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.IsSwim(_ARG_0_.targetHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
            Enemy.SetFaceAnim(_ARG_0_.myHandle, 6, 5)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.step = 2
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    JumpCutting = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 15)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 6 then
            Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
            _ARG_0_.velocity:set(0, 0, 0)
            _ARG_0_.step = 1
          end
        else
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 16 then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.step = 2
          end
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    PresentBombSmall = {
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
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 19 then
            Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
            _ARG_0_:CreatePresentBombSmall(_ARG_0_.targetPos)
            for _FORV_7_ = 1, Script.RandomInteger(3) + 1 do
              _ARG_0_.targetPos:setx(_ARG_0_.targetPos:getx() + Math.Cos((Script.RandomInRange(-PI, PI))) * (_FORV_7_ * 2))
              _ARG_0_.targetPos:setz(_ARG_0_.targetPos:getz() + Math.Sin((Script.RandomInRange(-PI, PI))) * (_FORV_7_ * 2))
              _ARG_0_:CreatePresentBombSmall(_ARG_0_.targetPos)
            end
            _FOR_.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
            _ARG_0_.step = 1
          end
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          if _ARG_0_:CheckUnderfoot() == false and Script.Random() < 0.5 then
            _ARG_0_:SetupAttack(6)
          end
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    PresentBombLarge = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        if _ARG_0_.step == 0 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 25 then
          Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
          Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
          _ARG_0_:CreatePresentBombLarge(_ARG_0_.targetPos)
          _ARG_0_.step = 1
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Step = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_.step = 0
        _ARG_0_.defenseFlag = false
        _ARG_0_.stack:push("Idling")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10) == false then
            _ARG_0_.step = 1
            if _ARG_0_:CheckStep() and _ARG_0_.oldStepMotion ~= 1 then
              table.insert({}, 1)
            end
            if _ARG_0_:CheckStep() and _ARG_0_.oldStepMotion ~= 2 then
              table.insert({}, 2)
            end
            if _ARG_0_:CheckStep() and _ARG_0_.oldStepMotion ~= 3 then
              table.insert({}, 3)
            end
            if _ARG_0_:CheckStep() and _ARG_0_.oldStepMotion ~= 4 then
              table.insert({}, 4)
            end
            _ARG_0_.oldStepMotion = {}[Script.RandomInteger(#{}) + 1]
            if {}[Script.RandomInteger(#{}) + 1] == 1 then
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
              Entity.SetTimer(_ARG_0_.myHandle, 120)
              _ARG_0_.step = 2
            elseif {}[Script.RandomInteger(#{}) + 1] == 2 then
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
            elseif {}[Script.RandomInteger(#{}) + 1] == 3 then
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
            elseif {}[Script.RandomInteger(#{}) + 1] == 4 then
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
            else
              _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
            end
          end
        elseif _ARG_0_.step == 1 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 2.5)
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            if _ARG_0_:CheckUnderfoot() == false and Script.Random() < 0.5 then
              _ARG_0_:SetupAttack(6)
            end
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        elseif _ARG_0_.step == 2 then
          if _ARG_0_:Defense() then
            return
          end
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 2.5)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE4_)
          Entity.GetWorldPos(_UPVALUE5_, _ARG_0_.targetHandle)
          if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= 9 or _UPVALUE5_:gety() < -0.5 or Entity.IsTimeOver(_ARG_0_.myHandle) then
            if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE6_ then
              _ARG_0_:SelectAttack()
            end
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        end
      end
    },
    BackStep = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10) == false then
            Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
            Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
            for _FORV_4_ = 0, 9 do
              _UPVALUE2_:set(0, 0, -4 + 0.5 * _FORV_4_)
              Math.RotateVectorXYZ(_UPVALUE2_, _UPVALUE1_)
              FVECTOR3.Add(_UPVALUE2_, _UPVALUE2_, _UPVALUE0_)
              _UPVALUE3_:copy(_UPVALUE2_)
              _UPVALUE3_:sety(_UPVALUE3_:gety() - 0.5)
              _UPVALUE2_:sety(_UPVALUE2_:gety() + 0.1)
              if Collision.IntersectRayBg(_UPVALUE3_, COLL_KIND_ENEMY, _UPVALUE2_, _UPVALUE3_) == true then
                Entity.SetRootMoveScale(_ARG_0_.myHandle, -((-4 + 0.5 * _FORV_4_) / 4), 1, -((-4 + 0.5 * _FORV_4_) / 4))
                Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE4_)
                _ARG_0_.step = 1
                return
              end
            end
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          if _ARG_0_:CheckUnderfoot() == false and 0.5 > Script.Random() then
            _ARG_0_:SetupAttack(6)
          end
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Evade = {
      OnBeginState = function(_ARG_0_)
        Entity.SetRot(_ARG_0_.myHandle, 0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle), 0)
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= 12.25 then
          if _ARG_0_:CheckStep() then
            table.insert({}, 1)
          else
            if _ARG_0_:CheckStep() then
              table.insert({}, 2)
            end
            if _ARG_0_:CheckStep() then
              table.insert({}, 3)
            end
          end
        else
          if _ARG_0_:CheckStep() then
            table.insert({}, 2)
          end
          if _ARG_0_:CheckStep() then
            table.insert({}, 3)
          end
          if #{} <= 0 and _ARG_0_:CheckStep() then
            table.insert({}, 1)
          end
        end
        if #{} > 0 then
          if {}[Script.RandomInteger(#{}) + 1] == 1 then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
          elseif {}[Script.RandomInteger(#{}) + 1] == 2 then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
          elseif {}[Script.RandomInteger(#{}) + 1] == 3 then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
          end
        else
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 2.5)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          if _ARG_0_:CheckUnderfoot() == false and Script.Random() < 0.5 then
            _ARG_0_:SetupAttack(6)
          end
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Angry = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Hurried = {
      OnBeginState = function(_ARG_0_)
        Entity.GetDir(_UPVALUE0_, _ARG_0_.myHandle)
        _UPVALUE0_:scale(1.5)
        Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
        FVECTOR3.Add(_UPVALUE0_, _UPVALUE0_, _UPVALUE1_)
        _UPVALUE2_:copy(_UPVALUE0_)
        _UPVALUE2_:sety(_UPVALUE2_:gety() - 0.5)
        if Collision.IntersectRayBg(_UPVALUE2_, COLL_KIND_ENEMY, _UPVALUE0_, _UPVALUE2_) then
          _UPVALUE0_:set(0, 0, 0)
          Entity.SetRot(_ARG_0_.myHandle, 0, Entity.CalcDirection(_ARG_0_.myHandle, _UPVALUE0_), 0)
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
        else
          _UPVALUE0_:set(0, 0, 0)
          FVECTOR3.Sub(_UPVALUE1_, _UPVALUE1_, _UPVALUE0_)
          Entity.SetRot(_ARG_0_.myHandle, 0, Math.Atan2(_UPVALUE1_:getx(), _UPVALUE1_:getz()), 0)
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE4_)
        end
        Enemy.SetFaceAnim(_ARG_0_.myHandle, 6, 5)
      end,
      OnEndState = function(_ARG_0_)
        Enemy.SetFaceAnim(_ARG_0_.myHandle, 1, 0)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    LosingBreath = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Jump = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.targetPos:set(0, 0, 0)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 10)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 16 then
            Entity.CalcOrbitVelocityFromPos(_ARG_0_.myHandle, _ARG_0_.targetPos, 0.25)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          Entity.GetVelocity(_UPVALUE0_, _ARG_0_.myHandle)
          if 0 > _UPVALUE0_:gety() then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if Entity.IsGround(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.step = 3
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Guard = {
      OnBeginState = function(_ARG_0_)
        Entity.SetRot(_ARG_0_.myHandle, 0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle), 0)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        Entity.EnableGuard(_ARG_0_.myHandle, 1)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableGuard(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            Entity.EnableGuard(_ARG_0_.myHandle, 0)
            _ARG_0_.step = 1
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    FireDamage = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Enemy.SetFaceAnim(_ARG_0_.myHandle, 6, 5)
      end,
      OnEndState = function(_ARG_0_)
        Enemy.SetFaceAnim(_ARG_0_.myHandle, 1, 0)
        _ARG_0_.idlingTimer = 0
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    FlyUp = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.EnableGravity(_ARG_0_.myHandle, 0)
        Entity.GetLocalPos(_UPVALUE1_, _ARG_0_.myHandle)
        _UPVALUE1_:sety(0.05)
        Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE1_)
        Entity.SetOldLocalPos(_ARG_0_.myHandle, _UPVALUE1_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.SetMovementCollKind(_ARG_0_.myHandle, COLL_KIND_PLAYER)
        Enemy.SetFaceAnim(_ARG_0_.myHandle, 6, 5)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Entity.SetMovementCollKind(_ARG_0_.myHandle, COLL_KIND_ENEMY)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.EnableGravity(_ARG_0_.myHandle, 0)
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          _UPVALUE1_:set(0, 0, 0)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE1_, 15)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE2_)
          if 1 >= Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _UPVALUE1_) then
            Enemy.SetFaceAnim(_ARG_0_.myHandle, 1, 0)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.step = 2
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.damageCount = 0
          _ARG_0_:SetupAttack(5)
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Blow = {
      OnBeginState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        if Entity.GetCurrentMotion(_ARG_0_.myHandle) == _UPVALUE0_ then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
        else
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
        end
        _UPVALUE3_:set(0, 0.05, 0)
        Entity.GetWorldPos(_UPVALUE4_, _ARG_0_.myHandle)
        FVECTOR3.Sub(_UPVALUE4_, _UPVALUE4_, _UPVALUE3_)
        Entity.SetRot(_ARG_0_.myHandle, 0, Math.Atan2(_UPVALUE4_:getx(), _UPVALUE4_:getz()), 0)
        Entity.CalcOrbitVelocityFromSpeedY(_ARG_0_.myHandle, 0.2, 5.5)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        Entity.SetMovementCollKind(_ARG_0_.myHandle, COLL_KIND_PLAYER)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Entity.SetMovementCollKind(_ARG_0_.myHandle, COLL_KIND_ENEMY)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.GetVelocity(_UPVALUE0_, _ARG_0_.myHandle)
          if 0 > _UPVALUE0_:gety() and Entity.IsGround(_ARG_0_.myHandle) then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            if Entity.GetCurrentMotion(_ARG_0_.myHandle) == _UPVALUE1_ then
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
            else
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
            end
            _ARG_0_.step = 1
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    SinkSea = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        _ARG_0_.step = 0
        _ARG_0_.myPos:set(0, 0, 0)
      end,
      OnEndState = function(_ARG_0_)
        _UPVALUE0_:set(0, 0, 0)
        Entity.SetDispOffset(_ARG_0_.myHandle, _UPVALUE0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          _UPVALUE0_:set(0, 0, 0)
          Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
          FVECTOR3.Sub(_UPVALUE2_, _UPVALUE1_, _UPVALUE0_)
          Entity.GetRot(_UPVALUE3_, _ARG_0_.myHandle)
          _UPVALUE3_:sety(Math.Atan2(_UPVALUE2_:getx(), _UPVALUE2_:getz()))
          Entity.SetRot(_ARG_0_.myHandle, _UPVALUE3_)
          if _UPVALUE2_:dot(_UPVALUE2_) >= 324 then
            Entity.ClearSpeed(_ARG_0_.myHandle)
          else
            Entity.CalcVelocityXZ(_ARG_0_.myHandle, 0.025)
          end
          if Entity.GetCurrentMotion(_ARG_0_.myHandle) == _UPVALUE4_ then
            FVECTOR3.Sub(_UPVALUE2_, _UPVALUE0_, _UPVALUE1_)
            _UPVALUE3_:sety(Math.Atan2(_UPVALUE2_:getx(), _UPVALUE2_:getz()))
            Entity.SetRot(_ARG_0_.myHandle, _UPVALUE3_)
          end
          _ARG_0_.myPos:sety(_ARG_0_.myPos:gety() - 0.0025 * Entity.GetFrameRate(_ARG_0_.myHandle))
          Entity.SetDispOffset(_ARG_0_.myHandle, _ARG_0_.myPos)
        end
      end
    },
    Dead = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Sound.IsInvalidateSeCall() == 1 then
            _ARG_0_.timer = 60
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          _ARG_0_.timer = _ARG_0_.timer - Script.GetVsyncFrameRate()
          if 0 >= _ARG_0_.timer then
            Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 2)
            Sound.PlayVoice(131, 4, 1, _UPVALUE0_, SE_OPT_ALWAYS)
            _ARG_0_.step = 2
          end
        end
      end
    }
  },
  SelectAttack = function(_ARG_0_)
    _ARG_0_.stack:push("Idling")
    if Script.Random() < 0.45 then
      if _ARG_0_.oldAttackType ~= 1 then
        _ARG_0_:SetupAttack(1)
        return
      end
    elseif Script.Random() >= 0.45 and Script.Random() < 0.8 then
      if _ARG_0_.oldAttackType ~= 2 then
        _ARG_0_:SetupAttack(2)
        return
      end
    elseif _ARG_0_.oldAttackType ~= 3 then
      _ARG_0_:SetupAttack(3)
      return
    end
    _ARG_0_:SetupAttack(_UPVALUE0_[_ARG_0_.oldAttackType][Script.RandomInteger(2) + 1])
  end,
  SetupAttack = function(_ARG_0_, _ARG_1_)
    if _ARG_1_ == 1 then
      if Script.Random() < 0.3 then
        _ARG_0_.stack:push("PresentBombSmall")
      end
      _ARG_0_.stack:push("DisturbStab")
      if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > 4 then
        _ARG_0_.nearDist = 4
        _ARG_0_.stack:push("TargetMove")
      end
    elseif _ARG_1_ == 2 then
      if Script.Random() < 0.5 then
        _ARG_0_.stack:push("BackStep")
      end
      _ARG_0_.stack:push("RushStab")
      if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > 16 then
        _ARG_0_.nearDist = 16
        _ARG_0_.stack:push("TargetMove")
      end
    elseif _ARG_1_ == 3 then
      _ARG_0_.stack:push("PresentBombSmall")
      if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > 16 then
        _ARG_0_.nearDist = 16
        _ARG_0_.stack:push("TargetMove")
      end
    elseif _ARG_1_ == 4 then
      _ARG_0_.stack:push("Idling")
      _ARG_0_.stack:push("PresentBombLarge")
    elseif _ARG_1_ == 5 then
      _ARG_0_.stack:push("Idling")
      _ARG_0_.stack:push("LosingBreath")
      _ARG_0_.stack:push("RushXCutting")
      for _FORV_6_ = 1, Script.RandomInteger(3) + 1 do
        _ARG_0_.stack:push("PresentBombSmall")
      end
      _FOR_:push("RushXCutting")
      _ARG_0_.stack:push("Angry")
    elseif _ARG_1_ == 6 then
      _ARG_0_.stack:push("Idling")
      if Script.Random() < 0.5 then
        _ARG_0_.stack:push("JumpCutting")
      else
        _ARG_0_.stack:push("Jump")
      end
      _ARG_0_.stack:push("Hurried")
    end
    _ARG_0_.oldAttackType = _ARG_1_
  end,
  CheckStep = function(_ARG_0_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
    Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
    _UPVALUE2_:set(0, 0, 5.25)
    Math.RotateVectorXYZ(_UPVALUE2_, _UPVALUE1_)
    FVECTOR3.Add(_UPVALUE2_, _UPVALUE2_, _UPVALUE0_)
    _UPVALUE3_:copy(_UPVALUE2_)
    _UPVALUE3_:sety(_UPVALUE3_:gety() - 0.5)
    _UPVALUE2_:sety(_UPVALUE2_:gety() + 0.1)
    _UPVALUE2_:set(0, 0, -4.25)
    Math.RotateVectorXYZ(_UPVALUE2_, _UPVALUE1_)
    FVECTOR3.Add(_UPVALUE2_, _UPVALUE2_, _UPVALUE0_)
    _UPVALUE3_:copy(_UPVALUE2_)
    _UPVALUE3_:sety(_UPVALUE3_:gety() - 0.5)
    _UPVALUE2_:sety(_UPVALUE2_:gety() + 0.1)
    _UPVALUE2_:set(-4.25, 0, 0)
    Math.RotateVectorXYZ(_UPVALUE2_, _UPVALUE1_)
    FVECTOR3.Add(_UPVALUE2_, _UPVALUE2_, _UPVALUE0_)
    _UPVALUE3_:copy(_UPVALUE2_)
    _UPVALUE3_:sety(_UPVALUE3_:gety() - 0.5)
    _UPVALUE2_:sety(_UPVALUE2_:gety() + 0.1)
    _UPVALUE2_:set(4.25, 0, 0)
    Math.RotateVectorXYZ(_UPVALUE2_, _UPVALUE1_)
    FVECTOR3.Add(_UPVALUE2_, _UPVALUE2_, _UPVALUE0_)
    _UPVALUE3_:copy(_UPVALUE2_)
    _UPVALUE3_:sety(_UPVALUE3_:gety() - 0.5)
    _UPVALUE2_:sety(_UPVALUE2_:gety() + 0.1)
    return Collision.IntersectRayBg(_UPVALUE3_, COLL_KIND_PLAYER, _UPVALUE2_, _UPVALUE3_), Collision.IntersectRayBg(_UPVALUE3_, COLL_KIND_PLAYER, _UPVALUE2_, _UPVALUE3_), Collision.IntersectRayBg(_UPVALUE3_, COLL_KIND_PLAYER, _UPVALUE2_, _UPVALUE3_), (Collision.IntersectRayBg(_UPVALUE3_, COLL_KIND_PLAYER, _UPVALUE2_, _UPVALUE3_))
  end,
  CheckUnderfoot = function(_ARG_0_, _ARG_1_)
    if _ARG_1_ == nil then
    else
    end
    Entity.GetLocalPos(_UPVALUE0_, _ARG_0_.myHandle)
    for _FORV_6_ = 0, 7 do
      _UPVALUE1_:setx(Math.Cos((RoundPI(DegToRad(_FORV_6_ * 45)))) * _ARG_1_)
      _UPVALUE1_:sety(0)
      _UPVALUE1_:setz(Math.Sin((RoundPI(DegToRad(_FORV_6_ * 45)))) * _ARG_1_)
      FVECTOR3.Add(_UPVALUE1_, _UPVALUE1_, _UPVALUE0_)
      _UPVALUE2_:copy(_UPVALUE1_)
      _UPVALUE2_:sety(_UPVALUE2_:gety() - 0.5)
      _UPVALUE1_:sety(_UPVALUE1_:gety() + 0.1)
      if Collision.IntersectRayBg(_UPVALUE1_, COLL_KIND_PLAYER, _UPVALUE1_, _UPVALUE2_) == false or Collision.IntersectRayBg(_UPVALUE1_, COLL_KIND_PLAYER, _UPVALUE1_, _UPVALUE2_) == false then
        return false
      end
    end
    return _FOR_
  end,
  CheckFront = function(_ARG_0_, _ARG_1_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
    Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
    _UPVALUE2_:set(0, 0, _ARG_1_)
    Math.RotateVectorXYZ(_UPVALUE2_, _UPVALUE1_)
    FVECTOR3.Add(_UPVALUE2_, _UPVALUE2_, _UPVALUE0_)
    _UPVALUE3_:copy(_UPVALUE2_)
    _UPVALUE3_:sety(_UPVALUE3_:gety() - 0.5)
    _UPVALUE2_:sety(_UPVALUE2_:gety() + 0.1)
    return Collision.IntersectRayBg(_UPVALUE3_, COLL_KIND_PLAYER, _UPVALUE2_, _UPVALUE3_)
  end,
  CreatePresentBombSmall = function(_ARG_0_, _ARG_1_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 22)
    _UPVALUE1_:set(0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_1_), 0)
    Bullet.SetAttackParam(Bullet.CreateBullet("PresentBombS", _UPVALUE0_, _UPVALUE1_), Enemy.GetAttackKind(_ARG_0_.myHandle, 4), Enemy.GetAttackAttr(_ARG_0_.myHandle, 4), 0, 0, 1)
    Bullet.SetCollision(Bullet.CreateBullet("PresentBombS", _UPVALUE0_, _UPVALUE1_), COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, 0.25, 0, _ARG_0_.myHandle)
    Entity.CalcOrbitVelocityFromPos(Bullet.CreateBullet("PresentBombS", _UPVALUE0_, _UPVALUE1_), _ARG_1_, _UPVALUE2_)
    return (Bullet.CreateBullet("PresentBombS", _UPVALUE0_, _UPVALUE1_))
  end,
  CreatePresentBombLarge = function(_ARG_0_, _ARG_1_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 22)
    _UPVALUE1_:set(0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_1_), 0)
    Bullet.SetAttackParam(Bullet.CreateBullet("PresentBombL", _UPVALUE0_, _UPVALUE1_), Enemy.GetAttackKind(_ARG_0_.myHandle, 5), Enemy.GetAttackAttr(_ARG_0_.myHandle, 5), 0, 0, 1)
    Bullet.SetCollision(Bullet.CreateBullet("PresentBombL", _UPVALUE0_, _UPVALUE1_), COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, 0.4, 0, _ARG_0_.myHandle)
    Entity.CalcOrbitVelocityFromPos(Bullet.CreateBullet("PresentBombL", _UPVALUE0_, _UPVALUE1_), _ARG_1_, _UPVALUE2_)
    return (Bullet.CreateBullet("PresentBombL", _UPVALUE0_, _UPVALUE1_))
  end,
  RestHpRate = function(_ARG_0_)
    return Enemy.GetHp(_ARG_0_.myHandle) / Enemy.GetHpMax(_ARG_0_.myHandle)
  end,
  Defense = function(_ARG_0_)
    if _ARG_0_.defenseTimer > 0 then
      return
    end
    if _ARG_0_.defenseFlag == false then
      if Entity.IsAttacking(_ARG_0_.targetHandle) then
        _ARG_0_.defenseFlag = true
        _ARG_0_.defenseTimer = _UPVALUE0_
      end
    else
      _ARG_0_.stack:push("Idling")
      if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 12.25 then
        _ARG_0_.stack:push("JumpCutting")
        _ARG_0_.stack:push("Guard")
      else
        _ARG_0_.stack:push("Evade")
      end
      _ARG_0_.stack:push("Evade")
      _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      _ARG_0_.defenseTimer = 180
      return true
    end
    return false
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    _UPVALUE0_ = Entity.GetMotionIndex(_ARG_1_, "010")
    _UPVALUE1_ = Entity.GetMotionIndex(_ARG_1_, "020")
    _UPVALUE2_ = Entity.GetMotionIndex(_ARG_1_, "021")
    _UPVALUE3_ = Entity.GetMotionIndex(_ARG_1_, "030")
    _UPVALUE4_ = Entity.GetMotionIndex(_ARG_1_, "040")
    _UPVALUE5_ = Entity.GetMotionIndex(_ARG_1_, "050")
    _UPVALUE6_ = Entity.GetMotionIndex(_ARG_1_, "051")
    _UPVALUE7_ = Entity.GetMotionIndex(_ARG_1_, "052")
    _UPVALUE8_ = Entity.GetMotionIndex(_ARG_1_, "053")
    _UPVALUE9_ = Entity.GetMotionIndex(_ARG_1_, "054")
    _UPVALUE10_ = Entity.GetMotionIndex(_ARG_1_, "055")
    _UPVALUE11_ = Entity.GetMotionIndex(_ARG_1_, "060")
    _UPVALUE12_ = Entity.GetMotionIndex(_ARG_1_, "061")
    _UPVALUE13_ = Entity.GetMotionIndex(_ARG_1_, "062")
    _UPVALUE14_ = Entity.GetMotionIndex(_ARG_1_, "200")
    _UPVALUE15_ = Entity.GetMotionIndex(_ARG_1_, "202")
    _UPVALUE16_ = Entity.GetMotionIndex(_ARG_1_, "220")
    _UPVALUE17_ = Entity.GetMotionIndex(_ARG_1_, "221")
    _UPVALUE18_ = Entity.GetMotionIndex(_ARG_1_, "222")
    _UPVALUE19_ = Entity.GetMotionIndex(_ARG_1_, "223")
    _UPVALUE20_ = Entity.GetMotionIndex(_ARG_1_, "224")
    _UPVALUE21_ = Entity.GetMotionIndex(_ARG_1_, "225")
    _UPVALUE22_ = Entity.GetMotionIndex(_ARG_1_, "226")
    _UPVALUE23_ = Entity.GetMotionIndex(_ARG_1_, "232")
    _UPVALUE24_ = Entity.GetMotionIndex(_ARG_1_, "300")
    _UPVALUE25_ = Entity.GetMotionIndex(_ARG_1_, "310")
    _UPVALUE26_ = Entity.GetMotionIndex(_ARG_1_, "320")
    _UPVALUE27_ = Entity.GetMotionIndex(_ARG_1_, "321")
    _UPVALUE28_ = Entity.GetMotionIndex(_ARG_1_, "330")
    _UPVALUE29_ = Entity.GetMotionIndex(_ARG_1_, "340")
    _UPVALUE30_ = Entity.GetMotionIndex(_ARG_1_, "350")
    _UPVALUE31_ = Entity.GetMotionIndex(_ARG_1_, "360")
    _UPVALUE32_ = Entity.GetMotionIndex(_ARG_1_, "361")
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.targetHandle = NULL_HANDLE
    _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
    _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
    _ARG_0_.step = 0
    _ARG_0_.damageCount = 0
    _ARG_0_.oldAttackType = -1
    _ARG_0_.nearDist = 0
    _ARG_0_.count = 0
    _ARG_0_.oldStepMotion = 0
    _ARG_0_.idlingTimer = Script.RandomInRange(_UPVALUE33_, _UPVALUE33_ * 2)
    _ARG_0_.defenseFlag = false
    _ARG_0_.defenseTimer = 0
    _ARG_0_.stack = Stack:Create()
    Entity.SetMovementCollRadius(_ARG_1_, 0.75)
    Entity.SetLowerHalf(_ARG_1_, 1.25)
    Entity.EnableGravity(_ARG_1_, 1)
    Entity.EnableWaterSurface(_ARG_1_, 1)
    Entity.EnableGuardPhysical(_ARG_1_, 1)
    Entity.EnableGuardFire(_ARG_1_, 1)
    Entity.EnableGuardIce(_ARG_1_, 1)
    Entity.EnableGuardThunder(_ARG_1_, 1)
    Entity.EnableGuardSpecial(_ARG_1_, 1)
    Entity.SetGuardDir(_ARG_1_, 90)
    Entity.SetModelPartsAlpha(_ARG_1_, 1, 0)
    Player.SetBossCamera("b01pp")
    _ARG_0_:GotoState("Appear")
  end,
  OnSetMotion = function(_ARG_0_, _ARG_1_)
  end,
  OnReturnDamage = function(_ARG_0_)
    Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
    Entity.SetMovementCollKind(_ARG_0_.myHandle, COLL_KIND_ENEMY)
    if _ARG_0_.damageCount >= _UPVALUE0_ then
      _ARG_0_.damageCount = 0
      _ARG_0_:SetupAttack(5)
    elseif _ARG_0_:CheckUnderfoot() == false then
      _ARG_0_:SetupAttack(6)
    else
      _ARG_0_.stack:push("Idling")
    end
    _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
  end,
  OnHitAttack = function(_ARG_0_)
    if Entity.GetCurrentMotion(_ARG_0_.myHandle) == _UPVALUE0_ then
      _ARG_0_.count = _ARG_0_.count + 1
    end
  end,
  OnReflect = function(_ARG_0_)
    Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
    return 0
  end,
  OnGuard = function(_ARG_0_)
    Entity.SetTimer(_ARG_0_.myHandle, 0)
    Entity.GetDamageCrossPos(_UPVALUE0_, _ARG_0_.myHandle)
    Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
    Entity.SetEffect(_ARG_0_.myHandle, "b01pp00", "B009_GRD_00_0", _UPVALUE0_, _UPVALUE1_)
  end,
  OnDamageBefore = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    if Entity.GetName((Entity.GetAttacker(_ARG_0_.myHandle))) == "b02pp00" then
      if _ARG_0_:GetState() == "SinkSea" then
        return 0
      end
      Entity.SetMovementCollKind(_ARG_0_.myHandle, COLL_KIND_ENEMY)
      return 1
    end
    if Entity.GetCurrentMotion(_ARG_0_.myHandle) == _UPVALUE0_ or Entity.GetCurrentMotion(_ARG_0_.myHandle) == _UPVALUE1_ then
      return 0
    end
    if Enemy.IsNoDamageReaction(_ARG_0_.myHandle) then
      return 0
    end
    if _ARG_1_ == ATK_KIND_DMG_SMALL or _ARG_1_ == ATK_KIND_DMG_BIG then
    end
    if _UPVALUE4_ > Script.Random() then
      _ARG_0_.stack:push("Idling")
      _ARG_0_.stack:push("JumpCutting")
      _ARG_0_.stack:push("Guard")
      _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
    elseif _UPVALUE4_ <= Script.Random() and _UPVALUE5_ > Script.Random() then
      _ARG_0_.stack:push("Idling")
      _ARG_0_.stack:push("JumpCutting")
      _ARG_0_.stack:push("Evade")
      _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
    else
      return 0
    end
    Entity.SetMovementCollKind(_ARG_0_.myHandle, COLL_KIND_ENEMY)
    return 1
  end,
  CanFireDamage = function(_ARG_0_, _ARG_1_)
    for _FORV_5_, _FORV_6_ in pairs(_UPVALUE0_) do
      if _ARG_1_ == _FORV_6_ then
        return false
      end
    end
    return true
  end,
  OnDamage = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
    Entity.EnableGuard(_ARG_0_.myHandle, 0)
    _ARG_0_.idlingTimer = 0
    if Entity.GetName((Entity.GetAttacker(_ARG_0_.myHandle))) == "b02pp00" then
      _ARG_0_:GotoState("FlyUp")
      return 1
    end
    if (_ARG_1_ == ATK_KIND_DMG_SMALL or _ARG_1_ == ATK_KIND_DMG_BIG) and (Entity.GetCurrentMotion(_ARG_0_.myHandle) == _UPVALUE0_ or Entity.GetCurrentMotion(_ARG_0_.myHandle) == _UPVALUE1_) then
      _ARG_0_:GotoState("Blow")
      return 1
    end
    if _ARG_3_ == ATK_ATTR_FIRE and _ARG_0_:CanFireDamage(_ARG_0_:GetState()) then
      _ARG_0_:GotoState("FireDamage")
      return 1
    end
    if Enemy.IsNoDamageReaction(_ARG_0_.myHandle) then
      if _ARG_0_:GetState() ~= "Blow" then
        Entity.SetMovementCollKind(_ARG_0_.myHandle, COLL_KIND_ENEMY)
      end
      return 0
    end
    _ARG_0_.damageCount = _ARG_0_.damageCount + 1
    return 0
  end,
  OnBeginDamageReaction = function(_ARG_0_)
    Entity.EnableGravity(_ARG_0_.myHandle, 1)
    Entity.EnableGuard(_ARG_0_.myHandle, 0)
    Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
  end,
  OnDead = function(_ARG_0_)
    SetupBossDead(_ARG_0_.myHandle)
    _ARG_0_:GotoState("Dead")
    return 1
  end,
  OnUpdate = function(_ARG_0_)
    if Entity.IsSwim(_ARG_0_.myHandle) then
      if _ARG_0_:GetState() ~= "SinkSea" and _ARG_0_:GetState() ~= "FlyUp" then
        _ARG_0_:GotoState("SinkSea")
      end
    else
      Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
      if _UPVALUE0_:gety() < -0.5 and Entity.IsGround(_ARG_0_.myHandle) and _ARG_0_:GetState() ~= "SinkSea" and _ARG_0_:GetState() ~= "FlyUp" and _ARG_0_:GetState() ~= "Jump" then
        if _ARG_0_.stack:getn() <= 0 then
          _ARG_0_.stack:push("Idling")
        end
        _ARG_0_:GotoState("Jump")
      end
    end
    _ARG_0_:Update()
    _ARG_0_:Debug()
    if 0 < _ARG_0_.defenseTimer then
      _ARG_0_.defenseTimer = _ARG_0_.defenseTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
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
        _ARG_0_.stack:clear()
        _ARG_0_.stack:push("Idling")
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        _ARG_0_:GotoState(_UPVALUE0_[Script.GetDebugAttackNumber() + 1])
      end
    end
  end
}, {__index = __StateMachine})
EntityFactory:Add("b01pp00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("PresentBombS", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("PresentBombL", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
