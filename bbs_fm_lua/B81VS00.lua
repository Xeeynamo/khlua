setmetatable({
  new = function(_ARG_0_)
    return setmetatable(__StateMachine:new(), _UPVALUE0_)
  end,
  states = {
    Appear = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        if Script.GetDebugTestParam() <= 0 then
          for _FORV_5_, _FORV_6_ in pairs(_UPVALUE1_) do
            if _FORV_6_[1] == Player.GetPlayerID(_ARG_0_.targetHandle, 1) then
              _ARG_0_.style = _FORV_6_[2]
              break
            end
          end
        else
          _ARG_0_.style = _UPVALUE2_
        end
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 20)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 34 then
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
            _ARG_0_.step = 2
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_UPVALUE2_[_ARG_0_.style])
        end
      end
    },
    Waiting = {
      OnBeginState = function(_ARG_0_)
        Entity.SetAlpha(_ARG_0_.myHandle, 0)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        _ARG_0_.style = _ARG_0_:GetStyle(_ARG_0_.targetHandle)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        print("" .. _UPVALUE0_[_ARG_0_.style] .. "\n")
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_, _UPVALUE0_[_ARG_0_.style])
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 and Entity.GetCurrentMotion(_ARG_0_.myHandle) == _UPVALUE0_ and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Entity.FadeoutEffectAttach(_ARG_0_.myHandle, 20)
          _ARG_0_.step = 1
        end
        if Enemy.IsAllEnemyWaiting() == false then
          _ARG_0_:GotoState(_UPVALUE1_[_ARG_0_.style])
        end
      end
    },
    Idling = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_.idlingTime)
        _ARG_0_.rotTimer = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:Turn()
        if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
          return
        end
        _ARG_0_.idlingTime = _UPVALUE0_[_ARG_0_.style]
        _ARG_0_.stack:push("Idling")
        _ARG_0_.stack:push("Consideration")
        _ARG_0_:GotoState(_ARG_0_.stack:pop())
      end
    },
    IdlingV = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_.idlingTime)
        _ARG_0_.rotTimer = 0
        _ARG_0_.stack:clear()
        print("IdlingV\n")
      end,
      OnEndState = function(_ARG_0_)
        _ARG_0_.style = _UPVALUE0_
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:Turn()
        if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
          if _ARG_0_:CanGuard() then
            _ARG_0_:GotoStateGuard()
          elseif _ARG_0_:IsExecShootLock() then
            _ARG_0_:GotoStateAbundantStep()
          end
          return
        end
        _ARG_0_.idlingTime = _UPVALUE0_[_ARG_0_.style]
        if _ARG_0_:ChangeSecrets() then
          return
        end
        if _ARG_0_:CanConsideration() then
          _ARG_0_.stack:push(_UPVALUE1_[_ARG_0_.style][1])
          _ARG_0_.stack:push("Consideration")
          _ARG_0_.stack:push("Consideration")
          _ARG_0_:GotoState("Consideration")
          return
        end
        if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE2_ then
          _ARG_0_:SelectBehavior(_UPVALUE3_)
        else
          _ARG_0_:SelectBehavior(_UPVALUE4_)
        end
        _ARG_0_:GotoState(_ARG_0_.stack:pop())
      end
    },
    SearchV = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        print("SearchV\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:SelectBehavior(_UPVALUE0_)
        _ARG_0_:GotoState(_ARG_0_.stack:pop())
      end
    },
    IdlingT = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_.idlingTime)
        _ARG_0_.rotTimer = 0
        _ARG_0_.stack:clear()
        print("IdlingT\n")
      end,
      OnEndState = function(_ARG_0_)
        _ARG_0_.style = _UPVALUE0_
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:Turn()
        if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
          if _ARG_0_:CanGuard() then
            _ARG_0_:GotoStateGuard()
          elseif _ARG_0_:IsExecShootLock() then
            _ARG_0_:GotoStateAbundantStep()
          end
          return
        end
        _ARG_0_.idlingTime = _UPVALUE0_[_ARG_0_.style]
        if _ARG_0_:ChangeSecrets() then
          return
        end
        if _ARG_0_:CanConsideration() then
          _ARG_0_.stack:push(_UPVALUE1_[_ARG_0_.style][1])
          _ARG_0_.stack:push("Consideration")
          _ARG_0_.stack:push("Consideration")
          _ARG_0_:GotoState("Consideration")
          return
        end
        if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE2_ then
          _ARG_0_:SelectBehavior(_UPVALUE3_)
        else
          _ARG_0_:SelectBehavior(_UPVALUE4_)
        end
        _ARG_0_:GotoState(_ARG_0_.stack:pop())
      end
    },
    SearchT = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.rotTimer = 0
        print("SearchT\n")
      end,
      OnEndState = function(_ARG_0_)
        _ARG_0_.style = _UPVALUE0_
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:Turn()
        if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) == false then
          if _ARG_0_:CanGuard() then
            _ARG_0_:GotoStateGuard()
          elseif _ARG_0_:IsExecShootLock() then
            _ARG_0_:GotoStateAbundantStep()
          end
          return
        end
        _ARG_0_:SelectBehavior(_UPVALUE0_)
        _ARG_0_:GotoState(_ARG_0_.stack:pop())
      end
    },
    IdlingA = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_.idlingTime)
        _ARG_0_.rotTimer = 0
        _ARG_0_.stack:clear()
        print("IdlingA\n")
      end,
      OnEndState = function(_ARG_0_)
        _ARG_0_.style = _UPVALUE0_
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:Turn()
        if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
          if _ARG_0_:CanGuard() then
            _ARG_0_:GotoStateGuard()
          elseif _ARG_0_:IsExecShootLock() then
            _ARG_0_:GotoStateAbundantStep()
          end
          return
        end
        _ARG_0_.idlingTime = _UPVALUE0_[_ARG_0_.style]
        if _ARG_0_:ChangeSecrets() then
          return
        end
        if _ARG_0_:CanConsideration() then
          _ARG_0_.stack:push(_UPVALUE1_[_ARG_0_.style][1])
          _ARG_0_.stack:push("Consideration")
          _ARG_0_.stack:push("Consideration")
          _ARG_0_:GotoState("Consideration")
          return
        end
        if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE2_ then
          _ARG_0_:SelectBehavior(_UPVALUE3_)
        else
          _ARG_0_.stack:push("SearchA")
        end
        _ARG_0_:GotoState(_ARG_0_.stack:pop())
      end
    },
    SearchA = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.rotTimer = 0
        print("SearchA\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:Turn()
        if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) == false then
          if _ARG_0_:CanGuard() then
            _ARG_0_:GotoStateGuard()
          elseif _ARG_0_:IsExecShootLock() then
            _ARG_0_:GotoStateAbundantStep()
          end
          return
        end
        _ARG_0_:SelectBehavior(_UPVALUE0_)
        _ARG_0_:GotoState(_ARG_0_.stack:pop())
      end
    },
    IdlingZ = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_.idlingTime)
        _ARG_0_.rotTimer = 0
        _ARG_0_.stack:clear()
        print("IdlingZ\n")
      end,
      OnEndState = function(_ARG_0_)
        _ARG_0_.style = _UPVALUE0_
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:Turn()
        if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
          if _ARG_0_:CanGuard() then
            _ARG_0_:GotoStateGuard()
          elseif _ARG_0_:IsExecShootLock() then
            _ARG_0_:GotoStateAbundantStep()
          end
          return
        end
        _ARG_0_.idlingTime = _UPVALUE0_[_ARG_0_.style]
        if _ARG_0_:ChangeSecrets() then
          return
        end
        if _ARG_0_:CanConsideration() then
          _ARG_0_.stack:push(_UPVALUE1_[_ARG_0_.style][1])
          _ARG_0_.stack:push("Consideration")
          _ARG_0_.stack:push("Consideration")
          _ARG_0_:GotoState("Consideration")
          return
        end
        if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE2_ then
          _ARG_0_:SelectBehavior(_UPVALUE3_)
        else
          _ARG_0_:SelectBehavior(_UPVALUE4_)
        end
        _ARG_0_:GotoState(_ARG_0_.stack:pop())
      end
    },
    SearchZ = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.rotTimer = 0
        print("SearchZ\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:Turn()
        if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) == false then
          if _ARG_0_:CanGuard() then
            _ARG_0_:GotoStateGuard()
          elseif _ARG_0_:IsExecShootLock() then
            _ARG_0_:GotoStateAbundantStep()
          end
          return
        end
        _ARG_0_:SelectBehavior(_UPVALUE0_)
        _ARG_0_:GotoState(_ARG_0_.stack:pop())
      end
    },
    Pursuit = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        ArmorEraqus.EnableAfterImage(_ARG_0_.myHandle, true)
        ArmorEraqus.SetAfterImageParam(_ARG_0_.myHandle, 1, 10)
        print("Pursuit\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        ArmorEraqus.EnableAfterImage(_ARG_0_.myHandle, false)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.HasNetGameHandle(_ARG_0_.myHandle) and Enemy.IsNetworkMaster(_ARG_0_.myHandle) == false then
          return
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE0_)
        if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE1_ then
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
        end
      end
    },
    Flee = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.myHandle, 2)
        ArmorEraqus.EnableAfterImage(_ARG_0_.myHandle, true)
        ArmorEraqus.SetAfterImageParam(_ARG_0_.myHandle, 1, 10)
        for _FORV_6_ = Entity.CalcDirection(_ARG_0_.targetHandle, _ARG_0_.myHandle), Entity.CalcDirection(_ARG_0_.targetHandle, _ARG_0_.myHandle) + 2 * PI, DegToRad(30) do
          _UPVALUE3_:set(Math.Cos((RoundPI(_FORV_6_))) * 50, 0, Math.Sin((RoundPI(_FORV_6_))) * 50)
          FVECTOR3.Add(_UPVALUE3_, _UPVALUE2_, _UPVALUE3_)
          Collision.IntersectRayBg(_UPVALUE3_, COLL_KIND_ENEMY, _UPVALUE2_, _UPVALUE3_)
          if 0 < Entity.CalcDistanceXZSq(_ARG_0_.targetHandle, _UPVALUE3_) then
            _ARG_0_.targetPos:copy(_UPVALUE3_)
          end
        end
        _ARG_0_.timer = 120
        print("Flee\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        ArmorEraqus.EnableAfterImage(_ARG_0_.myHandle, false)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.HasNetGameHandle(_ARG_0_.myHandle) and Enemy.IsNetworkMaster(_ARG_0_.myHandle) == false then
          return
        end
        if _ARG_0_.timer > 0 then
          _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 5)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE0_)
        if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _UPVALUE1_ or Entity.IsTimeOver(_ARG_0_.myHandle) or _ARG_0_.timer <= 0 and Entity.IsWall(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
        end
      end
    },
    AbundantStepRight = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        Enemy.EnableInvincible(_ARG_0_.myHandle, 1)
        ArmorEraqus.EnableAfterImage(_ARG_0_.myHandle, true)
        ArmorEraqus.SetAfterImageParam(_ARG_0_.myHandle, 1, 10)
        print("AbundantStepRight\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
        ArmorEraqus.EnableAfterImage(_ARG_0_.myHandle, false)
        Enemy.EnableInvincible(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.HasNetGameHandle(_ARG_0_.myHandle) and Enemy.IsNetworkMaster(_ARG_0_.myHandle) == false then
          return
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
        _UPVALUE0_:set(1, 0, 0)
        _UPVALUE0_:scale(_UPVALUE1_)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE0_)
        if _ARG_0_:IsTargetBack() or Entity.IsWall(_ARG_0_.myHandle) or Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
        end
      end
    },
    AbundantStepLeft = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        Enemy.EnableInvincible(_ARG_0_.myHandle, 1)
        ArmorEraqus.EnableAfterImage(_ARG_0_.myHandle, true)
        ArmorEraqus.SetAfterImageParam(_ARG_0_.myHandle, 1, 10)
        print("AbundantStepLeft\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
        ArmorEraqus.EnableAfterImage(_ARG_0_.myHandle, false)
        Enemy.EnableInvincible(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.HasNetGameHandle(_ARG_0_.myHandle) and Enemy.IsNetworkMaster(_ARG_0_.myHandle) == false then
          return
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
        _UPVALUE0_:set(-1, 0, 0)
        _UPVALUE0_:scale(_UPVALUE1_)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE0_)
        if _ARG_0_:IsTargetBack() or Entity.IsWall(_ARG_0_.myHandle) or Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
        end
      end
    },
    MoveToCenter = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, 600)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        ArmorEraqus.EnableAfterImage(_ARG_0_.myHandle, true)
        ArmorEraqus.SetAfterImageParam(_ARG_0_.myHandle, 1, 10)
        print("MoveToCenter\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        ArmorEraqus.EnableAfterImage(_ARG_0_.myHandle, false)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.HasNetGameHandle(_ARG_0_.myHandle) and Enemy.IsNetworkMaster(_ARG_0_.myHandle) == false then
          return
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        Entity.GetStartPos(_UPVALUE0_, _ARG_0_.myHandle)
        Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
        FVECTOR3.Sub(_UPVALUE1_, _UPVALUE0_, _UPVALUE1_)
        _UPVALUE1_:sety(0)
        _UPVALUE1_:normalize()
        _UPVALUE1_:scale(_UPVALUE2_)
        Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE1_)
        if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _UPVALUE0_) <= (_UPVALUE2_ + 0.1) * Entity.GetFrameRate(_ARG_0_.myHandle) * ((_UPVALUE2_ + 0.1) * Entity.GetFrameRate(_ARG_0_.myHandle)) or Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
        end
      end
    },
    Warp = {
      OnBeginState = function(_ARG_0_)
        Entity.GetStartPos(_UPVALUE0_, _ARG_0_.myHandle)
        if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _UPVALUE0_) <= 0.010000001 then
          _ARG_0_.step = 2
        else
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE1_)
          Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.myHandle, 2)
          _UPVALUE3_:set(0, 0, 0)
          Entity.SetEffect(_ARG_0_.myHandle, _UPVALUE4_, "B036_SNK_WRP0_0", _UPVALUE2_, _UPVALUE3_)
          Entity.SetAlpha(_ARG_0_.myHandle, 0)
          Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
          Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
          Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
          Entity.SetTimer(_ARG_0_.myHandle, 10)
          Entity.Warp(_ARG_0_.myHandle, _UPVALUE0_)
          Enemy.EnableInvincible(_ARG_0_.myHandle, 1)
          _ARG_0_.step = 0
        end
        print("Warp\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetAlpha(_ARG_0_.myHandle, 1)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
        Enemy.EnableInvincible(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, 10)
            Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 2)
            _UPVALUE1_:set(0, 0, 0)
            Entity.SetEffect(_ARG_0_.myHandle, _UPVALUE2_, "B036_SNK_WRP0_0", _UPVALUE0_, _UPVALUE1_)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if Entity.IsModelFade(_ARG_0_.myHandle) then
            _ARG_0_:GotoState(_ARG_0_.stack:pop())
          end
        else
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
        end
      end
    },
    Consideration = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        Enemy.EnableHalfDamage(_ARG_0_.myHandle, 1)
        _ARG_0_.step = 0
        Enemy.SetGeneralPurposeAttackColl(_ARG_0_.myHandle, COLL_KIND_ENEMY, COLL_SHAPE_CYLINDER, 1.75)
        Enemy.SetGeneralPurposeAttackCollParam(_ARG_0_.myHandle, Enemy.GetAttackKind(_ARG_0_.myHandle, 0), Enemy.GetAttackAttr(_ARG_0_.myHandle, 0), Enemy.GetAttackPoint(_ARG_0_.myHandle, 0), Enemy.GetAttackPowerCorrection(_ARG_0_.myHandle, 0))
        Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 0)
        _ARG_0_:EnableNoSetTargetHandle(true)
        ArmorEraqus.SetTargetsTrgFlagCancel(0)
        Entity.SetTimer(_ARG_0_.myHandle, 300)
        print("Consideration\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
        Entity.LoopEndEffectAttach(_ARG_0_.myHandle, 10)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 0)
        Enemy.EnableHalfDamage(_ARG_0_.myHandle, 0)
        _ARG_0_:EnableNoSetTargetHandle(false)
      end,
      OnUpdate = function(_ARG_0_)
        if Player.IsDamageFlagEat(_ARG_0_.targetHandle) then
          _ARG_0_:GotoState("ConsiderationSuccess")
          return
        end
        if _ARG_0_.step == 0 then
          if ArmorEraqus.IsSameTargetHandle(_ARG_0_.myHandle) or Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 10)
            Entity.SetMotionSpeed(_ARG_0_.myHandle, 2)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 30 then
            Entity.SetTimer(_ARG_0_.myHandle, 36)
            Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 1)
            Enemy.EnableGeneralPurposeUpdate(_ARG_0_.myHandle)
            _UPVALUE1_:set(0, 0, -1)
            Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "Z_00", _UPVALUE1_)
            _UPVALUE2_:set(0, 0, 0)
            Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "Z_00", _UPVALUE2_)
            Enemy.SetGeneralPurposeAttackCollPos(_ARG_0_.myHandle, _UPVALUE1_, _UPVALUE2_)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          _UPVALUE1_:set(0, 0, -1)
          Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "Z_00", _UPVALUE1_)
          _UPVALUE2_:set(0, 0, 1)
          _UPVALUE3_:set(0, 0, 8)
          Math.VectorLerp(_UPVALUE4_, _UPVALUE2_, _UPVALUE3_, (36 - Entity.GetTimer(_ARG_0_.myHandle)) / 36)
          Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "Z_00", _UPVALUE4_)
          Enemy.SetGeneralPurposeAttackCollPos(_ARG_0_.myHandle, _UPVALUE1_, _UPVALUE4_)
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetTimer(_ARG_0_.myHandle, 16)
            _ARG_0_.step = 3
          end
        elseif _ARG_0_.step == 3 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 0)
            Entity.LoopEndEffectAttach(_ARG_0_.myHandle, 10)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE5_)
            _ARG_0_.step = 4
          end
        elseif _ARG_0_.step == 4 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_:GotoState(_ARG_0_.stack:pop())
          end
        elseif Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
        end
      end
    },
    ConsiderationSuccess = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_.style = _ARG_0_:GetStyle(_ARG_0_.targetHandle)
        Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
        _ARG_0_:LoopEndMandaraEffect(false)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, _UPVALUE1_[_ARG_0_.style])
        Enemy.EnableInvincible(_ARG_0_.myHandle, 1)
        _ARG_0_.step = 0
        _ARG_0_:CreateRestraintEffect(_ARG_0_.targetHandle)
        Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.myHandle, 41)
        Entity.GetWorldPos(_UPVALUE3_, _ARG_0_.targetHandle, 2)
        _ARG_0_.chainHandle = Entity.AttachEffect(_ARG_0_.myHandle, _UPVALUE5_, "B036_SIN_CHN1_0", "Z_00", _UPVALUE6_, _UPVALUE4_)
        Effect.SetAttachNoRot(_ARG_0_.chainHandle, true)
        Effect.SetAttachNoScale(_ARG_0_.chainHandle, true)
        _UPVALUE6_:set(_ARG_0_:CalcChainRot(_UPVALUE4_, _UPVALUE2_, _UPVALUE3_) / 10, 1, 1)
        Effect.SetScale(_ARG_0_.chainHandle, _UPVALUE6_)
        _ARG_0_.chainUpdate = true
        _ARG_0_:EnableNoSetTargetHandle(true)
        print("ConsiderationSuccess\n")
      end,
      OnEndState = function(_ARG_0_)
        _ARG_0_:EnableNoSetTargetHandle(false)
        Enemy.EnableInvincible(_ARG_0_.myHandle, 0)
        ArmorEraqus.SetTargetsTrgFlagCancel(1)
        _ARG_0_.atkCount = 0
        Effect.LoopEnd(_ARG_0_.chainHandle)
        _ARG_0_.chainHandle = NULL_HANDLE
        _ARG_0_:AttachMandaraEffect()
        _ARG_0_.chainUpdate = false
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 87 then
          ArmorEraqus.SetTargetsTrgFlagCancel(1)
          _UPVALUE0_:set(1, 1, 1)
          Effect.SetScale(_ARG_0_.chainHandle, _UPVALUE0_)
          Effect.LoopEnd(_ARG_0_.chainHandle)
          _ARG_0_.chainHandle = NULL_HANDLE
          _ARG_0_:AttachMandaraEffect()
          _ARG_0_.chainUpdate = false
          _ARG_0_.step = 1
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_UPVALUE1_[_ARG_0_.style])
        end
      end
    },
    GodspeedCuttingZ = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        _ARG_0_.oldAttackState = "GodspeedCuttingZ"
        _ARG_0_.atkCount = _ARG_0_.atkCount + 1
        print("GodspeedCuttingZ\n")
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 20)
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 90 then
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
        end
      end
    },
    GodspeedCuttingZFinish = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.EnableGravity(_ARG_0_.myHandle, 0)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        ArmorEraqus.SetTargetsTrgFlagCancel(0)
        _ARG_0_.step = 0
        _ARG_0_.step2 = 0
        _ARG_0_.atkCount = _ARG_0_.atkCount + 1
        _ARG_0_:EnableNoSetTargetHandle(true)
        print("GodspeedCuttingZFinish\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        ArmorEraqus.SetTargetsTrgFlagCancel(1)
        _ARG_0_:EnableNoSetTargetHandle(false)
        Effect.KillEffect(_ARG_0_.plAttachEffHandle)
        _ARG_0_.plAttachEffHandle = NULL_HANDLE
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          if _ARG_0_.step2 == 0 then
            if Player.IsDamageFlagEat(_ARG_0_.targetHandle) and NULL_HANDLE == _ARG_0_.plAttachEffHandle then
              _UPVALUE0_:set(0, 0, 0)
              _ARG_0_.plAttachEffHandle = Entity.AttachEffect(_ARG_0_.targetHandle, _UPVALUE1_, "B036_JIN_ZET2_0", "hara", _UPVALUE0_, _UPVALUE0_)
              Effect.SetAttachNoRot(_ARG_0_.plAttachEffHandle, true)
              Effect.SetModel(_ARG_0_.plAttachEffHandle, _ARG_0_.myHandle)
              Effect.SetAttachAlpha(_ARG_0_.plAttachEffHandle, true)
              Entity.EnableBgColl(_ARG_0_.targetHandle, 1)
            end
            if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 36 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) <= 46 then
              if Player.IsDamageFlagEat(_ARG_0_.targetHandle) then
                Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
                Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.targetHandle)
                FVECTOR3.Sub(_UPVALUE0_, _UPVALUE0_, _UPVALUE2_)
                _UPVALUE0_:sety(0)
                _UPVALUE0_:normalize()
                _UPVALUE0_:scale((Math.Sqrt(_UPVALUE0_:dot(_UPVALUE0_)) - 1) / ((85 - Entity.GetMotionNowFrame(_ARG_0_.myHandle)) * 2))
                _UPVALUE0_:sety(0.4)
                Entity.EnableGravity(_ARG_0_.targetHandle, 1)
                Entity.SetVelocity(_ARG_0_.targetHandle, _UPVALUE0_)
                Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
                _ARG_0_.step2 = 1
              end
            elseif Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 46 then
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
              Entity.EnableGravity(_ARG_0_.myHandle, 1)
              _ARG_0_.step = 2
            end
          elseif _ARG_0_.step2 == 1 then
            Entity.GetVelocity(_UPVALUE0_, _ARG_0_.targetHandle)
            if 0 >= _UPVALUE0_:gety() then
              _UPVALUE0_:set(0, 0, 0)
              Entity.SetVelocity(_ARG_0_.targetHandle, _UPVALUE0_)
              Entity.EnableGravity(_ARG_0_.targetHandle, 0)
              _ARG_0_.step2 = 2
            end
          elseif _ARG_0_.step2 == 2 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 85 then
            Player.SetDamage(_ARG_0_.targetHandle, Player.CalcDamagePoint(_ARG_0_.targetHandle, Enemy.GetAttackPoint(_ARG_0_.myHandle, 2), Enemy.GetAttackPowerCorrection(_ARG_0_.myHandle, 2)), ATK_KIND_DMG_BEAT, _UPVALUE1_, Effect.GetEffectNameToIndex(_UPVALUE1_, "B036_HIT_ZET0_0"))
            Effect.KillEffect(_ARG_0_.plAttachEffHandle)
            _ARG_0_.plAttachEffHandle = NULL_HANDLE
            Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.targetHandle, 2)
            _UPVALUE2_:set(0, 0, 0)
            Entity.SetEffect(_ARG_0_.targetHandle, _UPVALUE1_, "B036_JIN_ZET3_0", _UPVALUE0_, _UPVALUE2_)
            _ARG_0_.step2 = 3
          end
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE4_)
            Entity.EnableGravity(_ARG_0_.myHandle, 1)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if Entity.IsGround(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
            _ARG_0_.step = 2
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
        end
        if _ARG_0_.step2 == 3 and Entity.IsGround(_ARG_0_.targetHandle) then
          Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.targetHandle, 0)
          _UPVALUE2_:set(0, 0, 0)
          Entity.SetEffect(_ARG_0_.targetHandle, _UPVALUE1_, "B036_COM_ZHA1_0", _UPVALUE0_, _UPVALUE2_)
          _ARG_0_:CreateShockwave("b81vsSw", 2, _ARG_0_.targetHandle, 0)
          _ARG_0_.step2 = 4
        end
      end
    },
    GodspeedCuttingV = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        _ARG_0_.oldAttackState = "GodspeedCuttingV"
        _ARG_0_.atkCount = _ARG_0_.atkCount + 1
        print("GodspeedCuttingV\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 20)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
        end
      end
    },
    GodspeedCuttingVFinish = {
      OnBeginState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        Entity.EnableGravity(_ARG_0_.myHandle, 0)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        _ARG_0_.step = 0
        _ARG_0_.count = 0
        _ARG_0_.atkCount = _ARG_0_.atkCount + 1
        print("GodspeedCuttingVFinish\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 0, 0)
          Entity.GetLocalPos(_UPVALUE1_, _ARG_0_.myHandle)
          _UPVALUE2_:copy(_UPVALUE1_)
          _UPVALUE2_:sety(_UPVALUE1_:gety() - 20)
          Collision.IntersectRayBg(_UPVALUE2_, COLL_KIND_ENEMY, _UPVALUE1_, _UPVALUE2_)
          _UPVALUE2_:sety(_UPVALUE2_:gety() + 1)
          Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE2_)
          Entity.SetOldLocalPos(_ARG_0_.myHandle, _UPVALUE2_)
          _ARG_0_.offset:set(0, 0, 0)
          _ARG_0_.timer = 0
          _ARG_0_.step = 1
        elseif _ARG_0_.step == 1 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 45)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 4 then
            Entity.SetTimer(_ARG_0_.myHandle, (Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) + 7.5) / _UPVALUE3_)
            Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE3_)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
          _ARG_0_.timer = _ARG_0_.timer + DegToRad(18) * Entity.GetFrameRate(_ARG_0_.myHandle)
          _ARG_0_.timer = RoundPI(_ARG_0_.timer)
          _UPVALUE2_:set(Math.Sin(_ARG_0_.timer), Math.Cos(_ARG_0_.timer), 0)
          Entity.GetRot(_UPVALUE4_, _ARG_0_.myHandle)
          Math.RotateVectorZYX(_UPVALUE2_, _UPVALUE4_)
          _UPVALUE2_:normalize()
          _UPVALUE2_:scale(0.8)
          FVECTOR3.Sub(_UPVALUE1_, _UPVALUE1_, _ARG_0_.offset)
          _ARG_0_.offset:copy(_UPVALUE2_)
          FVECTOR3.Add(_UPVALUE1_, _UPVALUE1_, _UPVALUE2_)
          Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE1_)
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.count = _ARG_0_.count + 1
            if _ARG_0_.count < _UPVALUE5_ then
              _ARG_0_.step = 0
            else
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE6_)
              Entity.EnableGravity(_ARG_0_.myHandle, 1)
              _ARG_0_.step = 3
            end
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
        end
      end
    },
    GodspeedCuttingT = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        _ARG_0_.step = 0
        _ARG_0_.oldAttackState = "GodspeedCuttingT"
        _ARG_0_.atkCount = _ARG_0_.atkCount + 1
        print("GodspeedCuttingT\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        _ARG_0_.count = _UPVALUE0_ + Script.RandomInteger(_UPVALUE1_ - _UPVALUE0_ + 1)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 139 then
          _ARG_0_:CreateShockwave("b81vsSw", 6, _ARG_0_.myHandle, 41)
          _ARG_0_.step = 1
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 20)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
        end
      end
    },
    GodspeedCuttingTFinish = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetRootMoveScale(_ARG_0_.myHandle, Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) / 4.5, 1, Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) / 4.5)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        _ARG_0_.atkCount = _ARG_0_.atkCount + 1
        _ARG_0_.step = 0
        print("GodspeedCuttingTFinish\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 29 then
            _ARG_0_:CreateShockwave("b81vsSw", 7, _ARG_0_.myHandle, 41)
            _ARG_0_.step = 1
          end
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.count = _ARG_0_.count - 1
          if 0 < _ARG_0_.count then
            _ARG_0_:GotoState("GodspeedCuttingTFinish")
          else
            _ARG_0_:GotoState(_ARG_0_.stack:pop())
          end
        end
      end
    },
    GodspeedCuttingA = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        _ARG_0_.oldAttackState = "GodspeedCuttingA"
        _ARG_0_.atkCount = _ARG_0_.atkCount + 1
        print("GodspeedCuttingA\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 20)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
        end
      end
    },
    GodspeedCuttingAFinish = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        _ARG_0_.step = 0
        _ARG_0_.atkCount = _ARG_0_.atkCount + 1
        print("GodspeedCuttingAFinish\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 25 then
            for _FORV_7_, _FORV_8_ in pairs({
              _ARG_0_.targetHandle,
              ArmorEraqus.GetTargets(_ARG_0_.myHandle, _ARG_0_.targetHandle)
            }) do
              if _FORV_8_ ~= NULL_HANDLE then
                Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 41)
                Entity.GetWorldPos(_UPVALUE1_, _FORV_8_, 2)
                FVECTOR3.Sub(_UPVALUE2_, _UPVALUE1_, _UPVALUE0_)
                _UPVALUE2_:normalize()
                _UPVALUE1_:set(-Math.Atan2(_UPVALUE2_:gety(), Math.Sqrt(_UPVALUE2_:getx() * _UPVALUE2_:getx() + _UPVALUE2_:getz() * _UPVALUE2_:getz())), Math.Atan2(_UPVALUE2_:getx(), _UPVALUE2_:getz()), 0)
                SetBulletAttackParam(Bullet.CreateBullet("b81vsGSCA_F", _UPVALUE0_, _UPVALUE1_), _ARG_0_.myHandle, 9)
              end
            end
            _ARG_0_.step = 1
          end
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
        end
      end
    },
    EnragedCuttingZ = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        Entity.SetTimer(_ARG_0_.myHandle, 300)
        _ARG_0_:GetTargets()
        _ARG_0_.step = 0
        _ARG_0_.count = 1
        _ARG_0_.oldAttackState = "EnragedCuttingZ"
        _ARG_0_.atkCount = _ARG_0_.atkCount + 1
        _ARG_0_:EnableNoSetTargetHandle(true)
        print("EnragedCuttingZ\n")
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        _ARG_0_.targetHandles[1] = NULL_HANDLE
        _ARG_0_.targetHandles[2] = NULL_HANDLE
        _ARG_0_.targetHandles[3] = NULL_HANDLE
        _ARG_0_:EnableNoSetTargetHandle(false)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if ArmorEraqus.IsSameTargetHandle(_ARG_0_.myHandle) or Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 30)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 10 then
            Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
            Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 28 then
            Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
            _ARG_0_.count = _ARG_0_.count + 1
            if _ARG_0_.targetHandles[_ARG_0_.count] ~= NULL_HANDLE then
              Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE1_)
              Entity.SetTimer(_ARG_0_.myHandle, 300)
              _ARG_0_.targetHandle = _ARG_0_.targetHandles[_ARG_0_.count]
              _ARG_0_.step = 0
            else
              _ARG_0_.step = 3
            end
            Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
            Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
        end
      end
    },
    EnragedCuttingV = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_.step = 0
        _ARG_0_.count = 0
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        Entity.SetTimer(_ARG_0_.myHandle, 0)
        _ARG_0_.oldAttackState = "EnragedCuttingV"
        _ARG_0_.atkCount = _ARG_0_.atkCount + 1
        print("EnragedCuttingV\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 1, 1)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 20)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 4 then
            Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
            Entity.SetRot(_ARG_0_.myHandle, 0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle), 0)
            Entity.SetTimer(_ARG_0_.myHandle, (Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) + 7.5) / _UPVALUE1_)
            Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE1_)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.count = _ARG_0_.count + 1
            if _ARG_0_.count < _UPVALUE2_ then
              Entity.SetMotion(_ARG_0_.myHandle, "221")
              Entity.SetTimer(_ARG_0_.myHandle, 50)
              _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
              _ARG_0_.step = 0
            else
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
              _ARG_0_.step = 3
            end
          end
        elseif _ARG_0_.step == 3 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
        end
      end
    },
    EnragedCuttingT = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        _ARG_0_.step = 0
        _ARG_0_.oldAttackState = "EnragedCuttingT"
        _ARG_0_.atkCount = _ARG_0_.atkCount + 1
        print("EnragedCuttingT\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Entity.LoopEndEffectAttach(_ARG_0_.myHandle, 5)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 20)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 4 then
            Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
            Entity.SetRot(_ARG_0_.myHandle, 0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle), 0)
            Entity.SetTimer(_ARG_0_.myHandle, (Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) + 7.5) / _UPVALUE0_)
            Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE0_)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE2_)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.step = 2
          end
        elseif Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
        end
      end
    },
    EnragedCuttingA = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        _ARG_0_.step = 0
        _ARG_0_.oldAttackState = "EnragedCuttingA"
        _ARG_0_.atkCount = _ARG_0_.atkCount + 1
        print("EnragedCuttingA\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 20)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 4 then
            Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
            Entity.SetRot(_ARG_0_.myHandle, 0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle), 0)
            _ARG_0_.timer = (Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) + 7.5) / _UPVALUE0_ / 3
            Entity.SetTimer(_ARG_0_.myHandle, (Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) + 7.5) / _UPVALUE0_)
            Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE0_)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 >= _ARG_0_.timer then
            _ARG_0_:CreateAfterImage(ArmorEraqus.GetTargets(_ARG_0_.myHandle, _ARG_0_.targetHandle))
            _ARG_0_:CreateAfterImage(ArmorEraqus.GetTargets(_ARG_0_.myHandle, _ARG_0_.targetHandle))
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE2_)
            _ARG_0_.step = 3
          end
        else
          Entity.GetVelocity(_UPVALUE3_, _ARG_0_.myHandle)
          _UPVALUE3_:scale(_UPVALUE3_:length() * Math.Pow(0.95, Entity.GetFrameRate(_ARG_0_.myHandle)))
          Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE3_)
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:GotoState(_ARG_0_.stack:pop())
          end
        end
      end
    },
    Flash = {
      OnBeginState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        _ARG_0_:GetTargets()
        _ARG_0_.step = 0
        _ARG_0_.count = 1
        _ARG_0_.oldAttackState = "Flash"
        _ARG_0_.atkCount = _ARG_0_.atkCount + 1
        _ARG_0_:EnableNoSetTargetHandle(true)
        print("Flash\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetAlpha(_ARG_0_.myHandle, 1)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        _ARG_0_.targetHandles[1] = NULL_HANDLE
        _ARG_0_.targetHandles[2] = NULL_HANDLE
        _ARG_0_.targetHandles[3] = NULL_HANDLE
        _ARG_0_:EnableNoSetTargetHandle(false)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.SetTimer(_ARG_0_.myHandle, 300)
          Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
          Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
          Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
          Entity.SetAlpha(_ARG_0_.myHandle, 0)
          Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 2)
          _UPVALUE1_:set(0, 0, 0)
          Entity.SetEffect(_ARG_0_.myHandle, _UPVALUE2_, "B036_SNK_WRP0_0", _UPVALUE0_, _UPVALUE1_)
          _ARG_0_.step = 1
        elseif _ARG_0_.step == 1 then
          if ArmorEraqus.IsSameTargetHandle(_ARG_0_.myHandle) or Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
            Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, 10)
            Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
            Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
            Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
            Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
            _ARG_0_:WarpToTarget(-1, 0)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 2)
          _UPVALUE1_:set(0, 0, 0)
          Entity.SetEffect(_ARG_0_.myHandle, _UPVALUE2_, "B036_SNK_WRP0_0", _UPVALUE0_, _UPVALUE1_)
          _ARG_0_.step = 3
        elseif _ARG_0_.step == 3 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
            _ARG_0_.count = _ARG_0_.count + 1
            if _ARG_0_.targetHandles[_ARG_0_.count] ~= NULL_HANDLE then
              _ARG_0_.targetHandle = _ARG_0_.targetHandles[_ARG_0_.count]
              _ARG_0_.step = 0
            else
              _ARG_0_.step = 4
            end
          end
        else
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
        end
      end
    },
    OboroKiwami = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        _ARG_0_.step = 0
        _ARG_0_.oldAttackState = "OboroKiwami"
        _ARG_0_.atkCount = _ARG_0_.atkCount + 1
        print("OboroKiwami\n")
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
            _ARG_0_.step = 1
          end
        else
          if _UPVALUE1_[_ARG_0_.step] ~= nil then
            Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
            if _UPVALUE1_[_ARG_0_.step] <= Entity.GetMotionNowFrame(_ARG_0_.myHandle) then
              _ARG_0_:CreateLightBall()
              _ARG_0_.step = _ARG_0_.step + 1
            end
          end
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_:GotoState(_ARG_0_.stack:pop())
          end
        end
      end
    },
    ThreeHazeSteps = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        Enemy.EnableInvincible(_ARG_0_.myHandle, 1)
        _ARG_0_.step = 0
        _ARG_0_.count = 0
        _ARG_0_.oldAttackState = "ThreeHazeSteps"
        _ARG_0_.atkCount = _ARG_0_.atkCount + 1
        print("ThreeHazeSteps\n")
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Enemy.EnableInvincible(_ARG_0_.myHandle, 0)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
        _ARG_0_:FireThreeHazeSteps()
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 2.5)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 50 then
            Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
            for _FORV_5_ = 0, 330, 30 do
              _ARG_0_.keyBladeHandle[1] = _ARG_0_:CreateKasumiKeyBlade((RoundPI(DegToRad(_FORV_5_))))
              if EntityManager:GetEntity(_ARG_0_.keyBladeHandle[1]) ~= nil then
                EntityManager:GetEntity(_ARG_0_.keyBladeHandle[1]).plusminus = _UPVALUE0_[1]
              end
            end
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 2.5)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 134 then
            Entity.SetTimer(_ARG_0_.myHandle, 0)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 2.5)
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:FireThreeHazeSteps(1)
            _ARG_0_.count = _ARG_0_.count + 1
            if _ARG_0_.count > #_ARG_0_.keyBladeHandle then
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
              _ARG_0_.step = 3
            else
              Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE2_)
            end
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
        end
      end
    },
    Halo = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        Enemy.EnableHalfDamage(_ARG_0_.myHandle, 1)
        _ARG_0_.step = 0
        _ARG_0_.oldAttackState = "Halo"
        _ARG_0_.atkCount = _ARG_0_.atkCount + 1
        print("Halo\n")
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Enemy.EnableHalfDamage(_ARG_0_.myHandle, 0)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
        _ARG_0_:StopHalo()
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 53 then
            Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
            for _FORV_5_ = 0, 315, 45 do
              _ARG_0_.keyBladeHandle[1] = _ARG_0_:CreateHaloKeyBlade((RoundPI(DegToRad(_FORV_5_))))
            end
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 124 then
            for _FORV_4_, _FORV_5_ in pairs(_ARG_0_.keyBladeHandle) do
              if EntityManager:GetEntity(_FORV_5_) ~= nil then
                if Math.Mod(_FORV_4_, 2) == 0 then
                end
                EntityManager:GetEntity(_FORV_5_):Fire(1, 180 / _UPVALUE0_)
              end
            end
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
            _ARG_0_.step = 3
          end
        elseif _ARG_0_.step == 3 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 12 then
            _ARG_0_:StopHalo()
            _ARG_0_.step = 4
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
        end
      end
    },
    Flame = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        Enemy.EnableHalfDamage(_ARG_0_.myHandle, 1)
        _ARG_0_.step = 0
        _ARG_0_.oldAttackState = "Flame"
        _ARG_0_.atkCount = _ARG_0_.atkCount + 1
        print("Flame\n")
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Enemy.EnableHalfDamage(_ARG_0_.myHandle, 0)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 50 then
            for _FORV_5_ = 1, _UPVALUE0_ do
              _ARG_0_.keyBladeHandle[_FORV_5_] = _ARG_0_:CreateFlameKeyBlade(DegToRad(0))
            end
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 90 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) <= 110 then
            for _FORV_5_ = 1, _UPVALUE0_ do
              Entity.GetRot(_UPVALUE1_, _ARG_0_.keyBladeHandle[_FORV_5_])
              _UPVALUE1_:setx(_UPVALUE1_:getx() + DegToRad(1.125 * Entity.GetFrameRate(_ARG_0_.keyBladeHandle[_FORV_5_])))
              Entity.SetRot(_ARG_0_.keyBladeHandle[_FORV_5_], _UPVALUE1_)
            end
          end
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 117 then
            Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
            for _FORV_5_ = 1, _UPVALUE0_ do
              if EntityManager:GetEntity(_ARG_0_.keyBladeHandle[_FORV_5_]) ~= nil then
                EntityManager:GetEntity(_ARG_0_.keyBladeHandle[_FORV_5_]):Fire(_ARG_0_.targetHandle)
              end
            end
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
        end
      end
    },
    Fetters = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 10)
        Player.SetTrgFlagCancel(Player.GetHandleForNet(), 0)
        Enemy.EnableInvincible(_ARG_0_.myHandle, 1)
        ArmorEraqus.SetTargetsTrgFlagCancel(0)
        _ARG_0_.step = 0
        _ARG_0_.count = 0
        print("Fetters\n")
      end,
      OnEndState = function(_ARG_0_, _ARG_1_)
        Script.StartFadeIn(15, true)
        if _ARG_1_ ~= "FettersSuccess" and Player.IsDamageFlagEat((Player.GetHandleForNet())) then
          Player.SetTrgFlagCancel(Player.GetHandleForNet(), 1)
        end
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 2.5)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 34 then
            Script.StartFadeOut(15, true)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if Script.IsEndFadeOut() then
            Entity.LoopEndEffectAttach(_ARG_0_.myHandle, 10)
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
            Player.SetDamage(Player.GetHandleForNet(), 0, ATK_KIND_EAT)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
            if _ARG_0_:CanExtraordinaryNaturalPhenomena() then
              _ARG_0_:GotoState("FettersSuccess")
            end
          else
            _ARG_0_.count = _ARG_0_.count + 1
            if _ARG_0_.count < _UPVALUE1_ then
              if Player.IsDamageFlagEat((Player.GetHandleForNet())) == false then
                Player.SetDamage(Player.GetHandleForNet(), 0, ATK_KIND_EAT)
              end
              Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
            else
              _ARG_0_:GotoState("IdlingT")
            end
          end
        end
      end
    },
    FettersSuccess = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_:CreateRestraintEffects()
        Entity.GetStartPos(_UPVALUE0_, _ARG_0_.g40vsHandle)
        _UPVALUE0_:setx(_UPVALUE0_:getx() - 11)
        _UPVALUE0_:sety(0)
        Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetOldLocalPos(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        Entity.SetTimer(_ARG_0_.myHandle, 120)
        print("FettersSuccess\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.GetStartPos(_UPVALUE0_, _ARG_0_.g40vsHandle)
        _UPVALUE0_:setx(_UPVALUE0_:getx() - 11)
        _UPVALUE0_:sety(0)
        _UPVALUE0_:setx(_UPVALUE0_:getx() + 22)
        _UPVALUE0_:setz(_UPVALUE0_:getz() + 8 + 2 * (1 - 1))
        Entity.SetLocalPos(Player.GetHandleForNet(), _UPVALUE0_)
        Entity.SetOldLocalPos(Player.GetHandleForNet(), _UPVALUE0_)
        if Player.IsDamageFlagEat((Player.GetHandleForNet())) == false then
          Player.SetDamage(Player.GetHandleForNet(), 0, ATK_KIND_EAT)
        end
        _ARG_0_:CreateRestraintEffects()
        Entity.SetRot(_ARG_0_.myHandle, 0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.g40vsHandle), 0)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
        end
      end
    },
    AllOfCreation = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Enemy.EnableInvincible(_ARG_0_.myHandle, 1)
        Entity.SetTimer(_ARG_0_.myHandle, 10)
        Entity.EnableGravity(_ARG_0_.myHandle, 0)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        _ARG_0_.step = 0
        print("AllOfCreation\n")
      end,
      OnEndState = function(_ARG_0_)
        Sound.PlaySe(289, 58)
        _UPVALUE0_:set(0, 0, 0)
        Entity.SetupMovement(_ARG_0_.myHandle, 0, _UPVALUE0_, 0)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:SetupCamera("430", _ARG_0_.myHandle)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 35 then
            Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
            _UPVALUE0_:sety(6)
            Entity.SetupMovement(_ARG_0_.myHandle, 2, _UPVALUE0_, 0.035)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if Entity.IsArraivalInterpolate(_ARG_0_.myHandle) then
            Entity.SetTimer(_ARG_0_.myHandle, 120)
            Entity.EnableGravity(_ARG_0_.myHandle, 0)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.step = 3
          end
        elseif _ARG_0_.step == 3 and Camera.IsEndExusiaCamera(_ARG_0_.camera) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
        end
      end
    },
    ExtraordinaryNaturalPhenomena = {
      OnBeginState = function(_ARG_0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 10)
        _ARG_0_:SetupCamera("440", nil, true)
        _ARG_0_.step = 0
        _ARG_0_.step2 = 0
        if EntityManager:GetEntity(_ARG_0_.g40vsHandle) ~= nil then
          EntityManager:GetEntity(_ARG_0_.g40vsHandle).targetHandle = _ARG_0_.targetHandle
        end
        print("ExtraordinaryNaturalPhenomena\n")
      end,
      OnEndState = function(_ARG_0_)
        if Player.IsDamageFlagCapture((Player.GetHandleForNet())) then
          Player.SetTrgFlagCancel(Player.GetHandleForNet(), 1)
        end
        Enemy.EnableInvincible(_ARG_0_.myHandle, 0)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
        _ARG_0_:KillCamera()
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step2 == 0 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= _UPVALUE0_ then
          Entity.LoopEndEffectAttach(_ARG_0_.myHandle, 10)
          _ARG_0_.step2 = 1
        end
        if _ARG_0_.step > 3 and Player.IsDamageFlagCapture(Player.GetHandleForNet()) == false then
          _ARG_0_:KillCamera()
          _UPVALUE1_:set(-4.9, 4.4, -19)
          _UPVALUE2_:set(-32, 2, 12.1)
          _ARG_0_.camera = Camera.CameraCreate(_UPVALUE1_, _UPVALUE2_)
        end
        if _ARG_0_.step == 0 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 36 then
            _ARG_0_:CreateENPChain(6)
            Entity.SetTimer(_ARG_0_.myHandle, 120)
            _ARG_0_:GotoStateForGround("Appear")
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:GotoStateForGround("Rise")
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if EntityManager:GetEntity(_ARG_0_.g40vsHandle) ~= nil and EntityManager:GetEntity(_ARG_0_.g40vsHandle):IsEndRise() == false then
            return
          end
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
          _ARG_0_.step = 3
        elseif _ARG_0_.step == 3 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 75 then
            Player.SetDamage(Player.GetHandleForNet(), 0, ATK_KIND_CAPTURE)
            _ARG_0_:GotoStateForGround("Fall")
            _ARG_0_.step = 4
          end
        elseif _ARG_0_.step == 4 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE4_)
            Entity.EnableGravity(_ARG_0_.myHandle, 1)
            _ARG_0_.step = 5
          end
        elseif _ARG_0_.step == 5 then
          if Entity.IsGround(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE5_)
            _ARG_0_.step = 6
          end
        elseif _ARG_0_.step == 6 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE6_)
            _ARG_0_.step = 7
          end
        else
          if EntityManager:GetEntity(_ARG_0_.g40vsHandle) ~= nil and EntityManager:GetEntity(_ARG_0_.g40vsHandle):IsEndExplode() == false then
            return
          end
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
        end
      end
    },
    Starbow = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_:SetupCamera("431", _ARG_0_.myHandle, true)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 10)
        _ARG_0_.step = 0
        _ARG_0_.step2 = 0
        _ARG_0_.count = 0
        print("Starbow\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
        Enemy.EnableInvincible(_ARG_0_.myHandle, 0)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        ArmorEraqus.SetSendPosCompleted(_ARG_0_.myHandle, false)
        Entity.SetAlpha(_ARG_0_.myHandle, 1)
        Script.SetSceneColor(0, 1, 1, 1, 1, 2, OBJ_BIT_MAP, OBJ_BIT_BG)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step2 == 0 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= _UPVALUE0_ then
          Entity.LoopEndEffectAttach(_ARG_0_.myHandle, 10)
          _ARG_0_.step2 = 1
        end
        if _ARG_0_.step2 == 0 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= _UPVALUE0_ then
          Entity.LoopEndEffectAttach(_ARG_0_.myHandle, 10)
          _ARG_0_.step2 = 1
        end
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 36 then
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if Camera.IsEndExusiaCamera(_ARG_0_.camera) then
            _ARG_0_:SetupCamera("400")
            _UPVALUE1_:set(0, 0, 0)
            Entity.SetEffect(_ARG_0_.myHandle, _UPVALUE2_, "B036_SEK_SKY0_0", _UPVALUE1_, _UPVALUE1_)
            Entity.SetAlpha(_ARG_0_.myHandle, 0)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if Camera.IsEndExusiaCamera(_ARG_0_.camera) then
            _ARG_0_:KillCamera()
            Entity.SetAlpha(_ARG_0_.myHandle, 1)
            Script.SetSceneColor(0, 0.5, 0.5, 0.5, 1, 2, OBJ_BIT_MAP, OBJ_BIT_BG)
            _ARG_0_.step = 3
          end
        elseif _ARG_0_.step == 3 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            if Entity.HasNetGameHandle(_ARG_0_.myHandle) then
              if Enemy.IsNetworkMaster(_ARG_0_.myHandle) then
                _ARG_0_:SetStarbowChainPos()
              end
            else
              _ARG_0_:SetStarbowChainPos()
            end
            _ARG_0_.step = 4
          end
        elseif _ARG_0_.step == 4 then
          if ArmorEraqus.IsSendPosCompleted(_ARG_0_.myHandle) then
            _ARG_0_.count = _ARG_0_.count + 1
            _ARG_0_:CreateStarbowChain(_ARG_0_.count)
            if _ARG_0_.count >= 7 then
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
              Entity.EnableGravity(_ARG_0_.myHandle, 1)
              _ARG_0_.step = 5
            else
              Entity.SetTimer(_ARG_0_.myHandle, 180)
              _ARG_0_.step = 3
            end
          end
        elseif _ARG_0_.step == 5 then
          if Entity.IsGround(_ARG_0_.myHandle) then
            Script.SetSceneColor(10, 1, 1, 1, 1, 2, OBJ_BIT_MAP, OBJ_BIT_BG)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE4_)
            _ARG_0_.step = 6
          end
        elseif _ARG_0_.step == 6 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
        end
      end
    },
    Cyclone = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 10)
        _ARG_0_:SetupCamera("431", _ARG_0_.myHandle, true)
        _ARG_0_.step = 0
        _ARG_0_.step2 = 0
        print("Cyclone\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
        Enemy.EnableInvincible(_ARG_0_.myHandle, 0)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        ArmorEraqus.SetSendPosCompleted(_ARG_0_.myHandle, false)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step2 == 0 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= _UPVALUE0_ then
          Entity.LoopEndEffectAttach(_ARG_0_.myHandle, 10)
          _ARG_0_.step2 = 1
        end
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 36 then
            if Entity.HasNetGameHandle(_ARG_0_.myHandle) then
              if Enemy.IsNetworkMaster(_ARG_0_.myHandle) then
                _ARG_0_:SetCycloneChainPos()
              end
            else
              _ARG_0_:SetCycloneChainPos()
            end
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if ArmorEraqus.IsSendPosCompleted(_ARG_0_.myHandle) then
            _ARG_0_:CreateCycloneChain()
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
            Entity.EnableGravity(_ARG_0_.myHandle, 1)
            _ARG_0_.step = 3
          end
        elseif _ARG_0_.step == 3 then
          if Entity.IsGround(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
            _ARG_0_.step = 4
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
        end
      end
    },
    Aurora = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        _ARG_0_.step = 0
        print("Aurora\n")
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 27 then
            _ARG_0_:CreateShockwave("b81vsSw", 22, _ARG_0_.myHandle, 41)
            _ARG_0_.step = 1
          end
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
        end
      end
    },
    MikiriV = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
        _ARG_0_.step = 0
        print("MikiriV\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 5 then
            _ARG_0_.speed = PI * Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) / (9 * Entity.GetFrameRate(_ARG_0_.myHandle))
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          _ARG_0_:CalcRotMoveVelocity(20, _ARG_0_.speed)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 14 then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetRot(_ARG_0_.myHandle, 0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle), 0)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            Entity.SetRootMoveScale(_ARG_0_.myHandle, Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) / 3.5, 1, Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) / 3.5)
            Entity.EnableGravity(_ARG_0_.myHandle, 0)
            _ARG_0_.step = 3
          end
        else
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) <= 25 then
            Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          end
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_:GotoState(_ARG_0_.stack:pop())
          end
        end
      end
    },
    MikiriT = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetRot(_ARG_0_.myHandle, 0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle), 0)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        Entity.EnableGuard(_ARG_0_.myHandle, 1)
        _ARG_0_.step = 0
        print("MikiriT\n")
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Entity.EnableGuard(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          if 10 <= Entity.GetMotionNowFrame(_ARG_0_.myHandle) then
            Entity.EnableGuard(_ARG_0_.myHandle, 0)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 21 then
          Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 41)
          Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
          Bullet.SetMaxMoveDist(CreateEnemyBullet(_UPVALUE2_, _ARG_0_.myHandle, _UPVALUE0_, _UPVALUE1_), 625)
          Entity.EnableCheckUnderFoot(CreateEnemyBullet(_UPVALUE2_, _ARG_0_.myHandle, _UPVALUE0_, _UPVALUE1_), 1)
          Entity.SetLowerHalf(CreateEnemyBullet(_UPVALUE2_, _ARG_0_.myHandle, _UPVALUE0_, _UPVALUE1_), 2)
          _ARG_0_.step = 2
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
        end
      end
    },
    MikiriA = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetRot(_ARG_0_.myHandle, 0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle), 0)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        _ARG_0_.step = 0
        print("MikiriA\n")
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
        end
      end
    },
    MikiriZ = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, "202", 1, 1)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        _ARG_0_:LoopEndMandaraEffect(false)
        _ARG_0_.step = 0
        print("MikiriZ\n")
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 10 then
          _ARG_0_:CreateMikiriZ()
          _ARG_0_.step = 1
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
        end
      end
    },
    Guard = {
      OnBeginState = function(_ARG_0_)
        Entity.SetRot(_ARG_0_.myHandle, 0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle), 0)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.EnableGuard(_ARG_0_.myHandle, 1)
        _ARG_0_.step = 0
        _ARG_0_.defenseFlag = false
        _ARG_0_.defenseTimer = 0
        print("Guard\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableGuard(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 25 then
          Entity.EnableGuard(_ARG_0_.myHandle, 0)
          _ARG_0_.step = 1
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
        end
      end
    },
    Evasion = {
      OnBeginState = function(_ARG_0_)
        Enemy.EnableInvincible(_ARG_0_.myHandle, 1)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        ArmorEraqus.EnableAfterImage(_ARG_0_.myHandle, true)
        ArmorEraqus.SetAfterImageParam(_ARG_0_.myHandle, 1, 10)
        Entity.SetTimer(_ARG_0_.myHandle, 300)
        _ARG_0_.timer = 0
        _ARG_0_.step = 0
        print("Evasion\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Enemy.EnableInvincible(_ARG_0_.myHandle, 0)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        ArmorEraqus.EnableAfterImage(_ARG_0_.myHandle, false)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.HasNetGameHandle(_ARG_0_.myHandle) and Enemy.IsNetworkMaster(_ARG_0_.myHandle) == false then
          return
        end
        _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.timer <= 0 then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
          Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
          _UPVALUE2_:set(Math.Cos((Script.RandomInRange(-PI, PI))) * 20, 0, Math.Sin((Script.RandomInRange(-PI, PI))) * 20)
          FVECTOR3.Add(_ARG_0_.targetPos, _UPVALUE1_, _UPVALUE2_)
          Collision.IntersectRayBg(_ARG_0_.targetPos, COLL_KIND_ENEMY, _UPVALUE1_, _ARG_0_.targetPos)
          _ARG_0_.timer = 60
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 10)
        Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.myHandle)
        FVECTOR3.Sub(_UPVALUE2_, _ARG_0_.targetPos, _UPVALUE2_)
        _UPVALUE2_:sety(0)
        _UPVALUE2_:normalize()
        _UPVALUE2_:scale(_UPVALUE3_)
        Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE2_)
        if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetPos) <= 1 or Entity.IsWall(_ARG_0_.myHandle) then
          Entity.ClearSpeed(_ARG_0_.myHandle)
          _ARG_0_.timer = 0
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) or _ARG_0_:IsUsedTargetRagingCharge() == false then
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
        end
      end
    },
    Dead = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_:StopFlame()
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
      end
    }
  },
  CanConsideration = function(_ARG_0_)
    if _ARG_0_.oldHp - Entity.GetHp(_ARG_0_.myHandle) >= _UPVALUE0_ then
      _ARG_0_.oldHp = Entity.GetHp(_ARG_0_.myHandle)
      return true
    end
    return false
  end,
  CanChangeStyleZ = function(_ARG_0_)
    if Enemy.GetHp(_ARG_0_.myHandle) / Enemy.GetHpMax(_ARG_0_.myHandle) <= _UPVALUE0_ then
      return true
    end
    return false
  end,
  SelectBehavior = function(_ARG_0_, _ARG_1_)
    _ARG_0_.stack2:clear()
    _UPVALUE0_(_ARG_0_, _ARG_1_)
    print("\129\171\129\171\129\171\129\171\129\171\129\171\129\171\129\171\129\171\129\171\129\171\129\171\129\171\129\171\129\171\129\171\129\171\129\171\129\171\n")
    for _FORV_6_ = 1, _ARG_0_.stack2.ptr - 1 do
      _ARG_0_.stack:push((_ARG_0_.stack2:pop()))
      print("" .. _ARG_0_.stack2:pop() .. "\n")
    end
    print("\129\170\129\170\129\170\129\170\129\170\129\170\129\170\129\170\129\170\129\170\129\170\129\170\129\170\129\170\129\170\129\170\129\170\129\170\129\170\n")
  end,
  ChangeSecrets = function(_ARG_0_)
    if _ARG_0_.atkCount < _UPVALUE0_ then
      return false
    end
    _ARG_0_.atkCount = 0
    if _UPVALUE1_[_ARG_0_.style][1] == nil then
      return false
    end
    _ARG_0_.stack:push(_UPVALUE1_[_ARG_0_.style][2])
    _ARG_0_.stack:push(_UPVALUE1_[_ARG_0_.style][1])
    _ARG_0_.stack:push("AllOfCreation")
    if _UPVALUE1_[_ARG_0_.style][3] ~= nil then
      _ARG_0_.stack:push(_UPVALUE1_[_ARG_0_.style][3])
    end
    if _UPVALUE1_[_ARG_0_.style][4] ~= nil then
      _ARG_0_.stack:push(_UPVALUE1_[_ARG_0_.style][4])
    end
    _ARG_0_:GotoState(_ARG_0_.stack:pop())
    return true
  end,
  Turn = function(_ARG_0_)
    _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
    if Entity.HasNetGameHandle(_ARG_0_.myHandle) and Enemy.IsNetworkMaster(_ARG_0_.myHandle) == false then
      return
    end
    Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
    Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 2.5)
    Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
    if _ARG_0_.rotTimer > 0 then
      _ARG_0_.rotTimer = _ARG_0_.rotTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
    end
    if 0 > RoundPI(_UPVALUE1_:gety() - _UPVALUE0_:gety()) then
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE2_)
      _ARG_0_.rotTimer = 10
    elseif 0 < RoundPI(_UPVALUE1_:gety() - _UPVALUE0_:gety()) then
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE3_)
      _ARG_0_.rotTimer = 10
    elseif _ARG_0_.rotTimer <= 0 then
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE4_)
    end
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
  WarpToTarget = function(_ARG_0_, _ARG_1_, _ARG_2_)
    Entity.GetDir(_UPVALUE0_, _ARG_0_.targetHandle)
    _UPVALUE0_:scale(_ARG_1_)
    Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.targetHandle)
    _UPVALUE2_:copy(_UPVALUE1_)
    _UPVALUE1_:sety(_UPVALUE1_:gety() + 1)
    _UPVALUE2_:sety(_UPVALUE2_:gety() - 10)
    if Collision.IntersectRayBg(_UPVALUE3_, COLL_KIND_ENEMY, _UPVALUE1_, _UPVALUE2_) then
      _UPVALUE1_:sety(_UPVALUE3_:gety())
    else
      Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
    end
    FVECTOR3.Add(_UPVALUE0_, _UPVALUE0_, _UPVALUE1_)
    Collision.IntersectRayBg(_UPVALUE0_, COLL_KIND_ENEMY, _UPVALUE1_, _UPVALUE0_)
    _UPVALUE0_:sety(_UPVALUE0_:gety() + _ARG_2_)
    Entity.Warp(_ARG_0_.myHandle, _UPVALUE0_)
    Entity.SetOldLocalPos(_ARG_0_.myHandle, _UPVALUE1_)
    FVECTOR3.Sub(_UPVALUE0_, _UPVALUE1_, _UPVALUE0_)
    Entity.SetRot(_ARG_0_.myHandle, 0, Math.Atan2(_UPVALUE0_:getx(), _UPVALUE0_:getz()), 0)
  end,
  IsTargetBack = function(_ARG_0_)
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
  CreateAfterImage = function(_ARG_0_, _ARG_1_)
    if _ARG_1_ == NULL_HANDLE then
      return NULL_HANDLE
    end
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
    _UPVALUE1_:set(0, 0, 0)
    SetBulletAttackParam(Bullet.CreateBullet("b81vs01", _UPVALUE0_, _UPVALUE1_), _ARG_0_.myHandle, 13)
    if EntityManager:GetEntity((Bullet.CreateBullet("b81vs01", _UPVALUE0_, _UPVALUE1_))) ~= nil then
      EntityManager:GetEntity((Bullet.CreateBullet("b81vs01", _UPVALUE0_, _UPVALUE1_))).targetHandle = _ARG_1_
    end
    return (Bullet.CreateBullet("b81vs01", _UPVALUE0_, _UPVALUE1_))
  end,
  CreateLightBall = function(_ARG_0_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 41)
    _UPVALUE0_:sety(_UPVALUE0_:gety() + 0.3)
    Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
    SetBulletAttackParam(Bullet.CreateBullet("b81vsLB", _UPVALUE0_, _UPVALUE1_), _ARG_0_.myHandle, 15)
    if EntityManager:GetEntity((Bullet.CreateBullet("b81vsLB", _UPVALUE0_, _UPVALUE1_))) ~= nil then
      EntityManager:GetEntity((Bullet.CreateBullet("b81vsLB", _UPVALUE0_, _UPVALUE1_))).targetHandle = _ARG_0_.targetHandle
    end
    return (Bullet.CreateBullet("b81vsLB", _UPVALUE0_, _UPVALUE1_))
  end,
  CreateKasumiKeyBlade = function(_ARG_0_, _ARG_1_)
    _UPVALUE0_:set(0, _UPVALUE1_, _UPVALUE2_)
    _UPVALUE3_:set(0, _ARG_1_, 0)
    Math.RotateVectorXYZ(_UPVALUE0_, _UPVALUE3_)
    Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "Root", _UPVALUE0_)
    Entity.GetRot(_UPVALUE3_, _ARG_0_.myHandle)
    _UPVALUE3_:sety(RoundPI(_UPVALUE3_:gety() + _ARG_1_))
    SetBulletAttackParam(Bullet.CreateBullet("b81vsKKB", _UPVALUE0_, _UPVALUE3_), _ARG_0_.myHandle, 16)
    if EntityManager:GetEntity((Bullet.CreateBullet("b81vsKKB", _UPVALUE0_, _UPVALUE3_))) ~= nil then
      EntityManager:GetEntity((Bullet.CreateBullet("b81vsKKB", _UPVALUE0_, _UPVALUE3_))).theta = _ARG_1_
    end
    return (Bullet.CreateBullet("b81vsKKB", _UPVALUE0_, _UPVALUE3_))
  end,
  CreateHaloKeyBlade = function(_ARG_0_, _ARG_1_)
    _UPVALUE0_:set(0, _UPVALUE1_, _UPVALUE2_)
    _UPVALUE3_:set(0, _ARG_1_, 0)
    Math.RotateVectorXYZ(_UPVALUE0_, _UPVALUE3_)
    Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "Root", _UPVALUE0_)
    Entity.GetRot(_UPVALUE3_, _ARG_0_.myHandle)
    _UPVALUE3_:sety(RoundPI(_UPVALUE3_:gety() + _ARG_1_))
    SetBulletAttackParam(Bullet.CreateBullet("b81vsHKB", _UPVALUE0_, _UPVALUE3_), _ARG_0_.myHandle, 17)
    if EntityManager:GetEntity((Bullet.CreateBullet("b81vsHKB", _UPVALUE0_, _UPVALUE3_))) ~= nil then
      EntityManager:GetEntity((Bullet.CreateBullet("b81vsHKB", _UPVALUE0_, _UPVALUE3_))).theta = _ARG_1_
    end
    return (Bullet.CreateBullet("b81vsHKB", _UPVALUE0_, _UPVALUE3_))
  end,
  CreateFlameKeyBlade = function(_ARG_0_, _ARG_1_)
    _UPVALUE0_:set(Math.Cos((RoundPI(_ARG_1_ + PI * 0.5))) * _UPVALUE1_, _UPVALUE2_, Math.Sin((RoundPI(_ARG_1_ + PI * 0.5))) * _UPVALUE1_)
    Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "Root", _UPVALUE0_)
    Entity.GetRot(_UPVALUE3_, _ARG_0_.myHandle)
    _UPVALUE3_:sety(RoundPI(_UPVALUE3_:gety() - _ARG_1_))
    SetBulletAttackParam(Bullet.CreateBullet("b81vsFKB", _UPVALUE0_, _UPVALUE3_), _ARG_0_.myHandle, 18)
    return (Bullet.CreateBullet("b81vsFKB", _UPVALUE0_, _UPVALUE3_))
  end,
  SetCycloneChainPos = function(_ARG_0_)
    Entity.GetStartPos(_UPVALUE0_, _ARG_0_.myHandle)
    for _FORV_6_ = 0, 2 do
      _UPVALUE1_:set(Math.Sin((Script.RandomInRange(-PI, PI))) * Script.RandomInRange(0, 1), 0, Math.Cos((Script.RandomInRange(-PI, PI))) * Script.RandomInRange(0, 1))
      FVECTOR3.Add(_UPVALUE1_, _UPVALUE0_, _UPVALUE1_)
      ArmorEraqus.SetSendPos(_ARG_0_.myHandle, _UPVALUE1_, _FORV_6_)
    end
    _FOR_.GetRot(_UPVALUE2_, _ARG_0_.myHandle)
    for _FORV_6_ = 3, 5 do
      _UPVALUE1_:set(Math.Sin((RoundPI(_UPVALUE2_:gety() + DegToRad(-45)))) * Script.RandomInRange(2.5, 10), 0, Math.Cos((RoundPI(_UPVALUE2_:gety() + DegToRad(-45)))) * Script.RandomInRange(2.5, 10))
      FVECTOR3.Add(_UPVALUE1_, _UPVALUE0_, _UPVALUE1_)
      ArmorEraqus.SetSendPos(_ARG_0_.myHandle, _UPVALUE1_, _FORV_6_)
    end
    _FOR_.SetSendPosCompleted(_ARG_0_.myHandle, true)
  end,
  CreateCycloneChain = function(_ARG_0_)
    for _FORV_4_ = 0, 2 do
      ArmorEraqus.GetRecvPos(_UPVALUE0_, _ARG_0_.myHandle, _FORV_4_)
      ArmorEraqus.GetRecvPos(_UPVALUE1_, _ARG_0_.myHandle, 3 + _FORV_4_)
      _UPVALUE0_:sety(20)
      _ARG_0_:CalcChainRot(_UPVALUE2_, _UPVALUE0_, _UPVALUE1_)
      SetBulletAttackParam(Bullet.CreateBullet("b81vsCChain", _UPVALUE0_, _UPVALUE2_), _ARG_0_.myHandle, 21)
      if EntityManager:GetEntity((Bullet.CreateBullet("b81vsCChain", _UPVALUE0_, _UPVALUE2_))) ~= nil then
        EntityManager:GetEntity((Bullet.CreateBullet("b81vsCChain", _UPVALUE0_, _UPVALUE2_))).no = _FORV_4_
      end
    end
  end,
  CreateScreenCycloneEffect = function(_ARG_0_)
    if _ARG_0_.screenEffHandle ~= NULL_HANDLE then
      return
    end
    _UPVALUE0_:set(0, 0, 0)
    _ARG_0_.screenEffHandle = Entity.SetEffect(_ARG_0_.myHandle, _UPVALUE1_, "B036_SMP_GMN0_0", _UPVALUE0_, _UPVALUE0_)
  end,
  LoopEndScreenCycloneEffect = function(_ARG_0_)
    if _ARG_0_.screenEffHandle == NULL_HANDLE then
      return
    end
    Effect.LoopEnd(_ARG_0_.screenEffHandle)
    _ARG_0_.screenEffHandle = NULL_HANDLE
  end,
  SetStarbowChainPos = function(_ARG_0_)
    _UPVALUE0_:set(-22, 0, -2)
    _UPVALUE1_:set(Math.Sin((Script.RandomInRange(-PI, PI))) * Script.RandomInRange(0, 7.5), 0, Math.Cos((Script.RandomInRange(-PI, PI))) * Script.RandomInRange(0, 7.5))
    FVECTOR3.Add(_UPVALUE1_, _UPVALUE0_, _UPVALUE1_)
    ArmorEraqus.SetSendPos(_ARG_0_.myHandle, _UPVALUE1_, 0)
    _UPVALUE1_:set(Math.Sin((RoundPI(DegToRad((Script.RandomInRange(_ARG_0_.count * 51.42857, (_ARG_0_.count + 1) * 51.42857)))))) * Script.RandomInRange(5, 12.5), 0, Math.Cos((RoundPI(DegToRad((Script.RandomInRange(_ARG_0_.count * 51.42857, (_ARG_0_.count + 1) * 51.42857)))))) * Script.RandomInRange(5, 12.5))
    FVECTOR3.Add(_UPVALUE1_, _UPVALUE0_, _UPVALUE1_)
    ArmorEraqus.SetSendPos(_ARG_0_.myHandle, _UPVALUE1_, 1)
    ArmorEraqus.SetSendPosCompleted(_ARG_0_.myHandle, true)
  end,
  CreateStarbowChain = function(_ARG_0_, _ARG_1_)
    ArmorEraqus.GetRecvPos(_UPVALUE1_, _ARG_0_.myHandle, 1)
    ArmorEraqus.GetRecvPos(_UPVALUE2_, _ARG_0_.myHandle, 0)
    _UPVALUE2_:sety(20)
    _ARG_0_:CalcChainRot(_UPVALUE3_, _UPVALUE2_, _UPVALUE1_)
    if EntityManager:GetEntity((Bullet.CreateBullet("b81vsSChain", _UPVALUE2_, _UPVALUE3_))) ~= nil then
      EntityManager:GetEntity((Bullet.CreateBullet("b81vsSChain", _UPVALUE2_, _UPVALUE3_))).colorParam = _UPVALUE0_[_ARG_1_]
    end
    SetBulletAttackParam(Bullet.CreateBullet("b81vsSChain", _UPVALUE2_, _UPVALUE3_), _ARG_0_.myHandle, 22)
    _UPVALUE2_:set(_UPVALUE0_[_ARG_1_][1], _UPVALUE0_[_ARG_1_][2], _UPVALUE0_[_ARG_1_][3])
    Effect.SetColor(Bullet.GetEffectHandle((Bullet.CreateBullet("b81vsSChain", _UPVALUE2_, _UPVALUE3_))), _UPVALUE2_)
  end,
  CreateENPChain = function(_ARG_0_, _ARG_1_)
    Entity.GetStartPos(_UPVALUE0_, _ARG_0_.g40vsHandle)
    for _FORV_5_ = 1, _ARG_1_ do
      _UPVALUE1_:set(Math.Sin((RoundPI(DegToRad(360 / _ARG_1_ * _FORV_5_)))) * 1.5, 25, Math.Cos((RoundPI(DegToRad(360 / _ARG_1_ * _FORV_5_)))) * 1.5)
      _UPVALUE2_:set(Math.Sin((RoundPI(DegToRad(360 / _ARG_1_ * _FORV_5_)))) * 8, 0, Math.Cos((RoundPI(DegToRad(360 / _ARG_1_ * _FORV_5_)))) * 8)
      FVECTOR3.Add(_UPVALUE1_, _UPVALUE1_, _UPVALUE0_)
      FVECTOR3.Add(_UPVALUE2_, _UPVALUE2_, _UPVALUE0_)
      _ARG_0_:CalcChainRot(_UPVALUE3_, _UPVALUE1_, _UPVALUE2_)
      if EntityManager:GetEntity((Bullet.CreateBullet("b81vsENPChain", _UPVALUE1_, _UPVALUE3_, _ARG_0_.g40vsHandle))) ~= nil then
        EntityManager:GetEntity((Bullet.CreateBullet("b81vsENPChain", _UPVALUE1_, _UPVALUE3_, _ARG_0_.g40vsHandle))).no = _FORV_5_
      end
    end
  end,
  CreateShockwave = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_3_, _ARG_4_)
    _UPVALUE1_:copy(_UPVALUE0_)
    _UPVALUE0_:sety(_UPVALUE0_:gety() + 10)
    _UPVALUE1_:sety(_UPVALUE1_:gety() - 30)
    if Collision.IntersectRayBg(_UPVALUE0_, COLL_KIND_ENEMY, _UPVALUE0_, _UPVALUE1_) == false then
      Entity.GetWorldPos(_UPVALUE0_, _ARG_3_, _ARG_4_)
    end
    _UPVALUE1_:set(0, 0, 0)
    SetBulletAttackParam(Bullet.CreateBullet(_ARG_1_, _UPVALUE0_, _UPVALUE1_), _ARG_0_.myHandle, _ARG_2_)
    Bullet.SetHitAttackEffectName(Bullet.CreateBullet(_ARG_1_, _UPVALUE0_, _UPVALUE1_), _UPVALUE2_, "B036_HIT_ZET1_0")
    return (Bullet.CreateBullet(_ARG_1_, _UPVALUE0_, _UPVALUE1_))
  end,
  FireThreeHazeSteps = function(_ARG_0_, _ARG_1_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 2)
    Sound.PlaySe(289, 62, SOUND_MAX_VOLUME, _UPVALUE0_)
    for _FORV_6_, _FORV_7_ in pairs(_ARG_0_.keyBladeHandle) do
      if EntityManager:GetEntity(_FORV_7_) ~= nil then
        EntityManager:GetEntity(_FORV_7_):Fire(_ARG_0_.targetHandle)
        _ARG_0_.keyBladeHandle[_FORV_6_] = NULL_HANDLE
        if _ARG_1_ - 1 <= 0 then
          break
        end
      end
    end
  end,
  StopHalo = function(_ARG_0_)
    for _FORV_4_, _FORV_5_ in pairs(_ARG_0_.keyBladeHandle) do
      if EntityManager:GetEntity(_FORV_5_) ~= nil then
        EntityManager:GetEntity(_FORV_5_):Stop()
      end
    end
    for _FORV_4_ = 1, #_ARG_0_.keyBladeHandle do
      _ARG_0_.keyBladeHandle[_FORV_4_] = NULL_HANDLE
    end
  end,
  StopFlame = function(_ARG_0_)
    for _FORV_4_ = 1, _UPVALUE0_ do
      if EntityManager:GetEntity(_ARG_0_.keyBladeHandle[_FORV_4_]) ~= nil then
        EntityManager:GetEntity(_ARG_0_.keyBladeHandle[_FORV_4_]):Stop(_ARG_0_.targetHandle)
      end
    end
    for _FORV_4_ = 1, #_ARG_0_.keyBladeHandle do
      _ARG_0_.keyBladeHandle[_FORV_4_] = NULL_HANDLE
    end
  end,
  Defense = function(_ARG_0_)
    if _ARG_0_.style == _UPVALUE0_ then
      return
    end
    if _ARG_0_.defenseTimer > 0 then
      return
    end
    if Enemy.IsNoDamageReaction(_ARG_0_.myHandle) or Enemy.IsInvincible(_ARG_0_.myHandle) then
      return 0
    end
    if _ARG_0_:GetState() == "Guard" or Enemy.IsNoDamageReaction(_ARG_0_.myHandle) or Enemy.IsInvincible(_ARG_0_.myHandle) then
      _ARG_0_.defenseFlag = false
      return
    end
    if _ARG_0_.defenseFlag == false then
      if Entity.IsAttacking(_ARG_0_.targetHandle) and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE1_ and Entity.IsTargetWithinFOV(_ARG_0_.myHandle, _ARG_0_.targetHandle, DegToRad(180)) then
        _ARG_0_.defenseFlag = true
        _ARG_0_.defenseTimer = 8
      end
    else
      _ARG_0_.defenseFlag = false
      _ARG_0_.idlingTime = 0
      if Script.Random() < _UPVALUE2_ then
        print("\131K\129[\131h\130\181\130\200\130\162\n")
        return
      elseif Script.Random() >= _UPVALUE2_ and Script.Random() < _UPVALUE2_ + _UPVALUE3_ then
        if _UPVALUE4_[_ARG_0_.style] ~= nil then
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE1_ then
            if _ARG_0_:GetState() ~= nil then
              _ARG_0_.stack:push((_ARG_0_:GetState()))
            else
              _ARG_0_.stack:push(_UPVALUE5_[_ARG_0_.style][Script.RandomInteger(2) + 1])
            end
            _ARG_0_:GotoState(_UPVALUE4_[_ARG_0_.style])
            print("\140\169\144\216\130\232\145I\145\240\n")
            return
          else
            _ARG_0_.stack:push(_UPVALUE5_[_ARG_0_.style][Script.RandomInteger(2) + 1])
          end
        else
          _ARG_0_.stack:push(_UPVALUE5_[_ARG_0_.style][Script.RandomInteger(2) + 1])
          if Script.Random() < _UPVALUE6_ then
            _ARG_0_.stack:push("Aurora")
            print("\139\201\140\245\145I\145\240\n")
          end
        end
      else
        _ARG_0_.stack:push(_UPVALUE5_[_ARG_0_.style][Script.RandomInteger(2) + 1])
      end
      _ARG_0_:GotoState("Guard")
      print("\131K\129[\131h\145I\145\240\n")
    end
  end,
  SetupCamera = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    if _ARG_0_.camera ~= NULL_HANDLE then
      Script.OutTask(_ARG_0_.camera)
    end
    _ARG_0_.camera = Camera.CreateExusiaCamera(_ARG_1_)
    if _ARG_2_ ~= nil then
      Camera.SetAttachSetCoord(_ARG_0_.camera, _ARG_2_, 0)
    end
    Camera.StartExusiaCamera(_ARG_0_.camera)
    if _ARG_3_ then
      _ARG_0_.cameraStep = 1
    else
      _ARG_0_.cameraStep = 0
    end
  end,
  KillCamera = function(_ARG_0_)
    Script.OutTask(_ARG_0_.camera)
    _ARG_0_.camera = NULL_HANDLE
  end,
  UpdateCamera = function(_ARG_0_)
    if _ARG_0_.cameraStep == 1 and Camera.IsEndExusiaCamera(_ARG_0_.camera) then
      Script.OutTask(_ARG_0_.camera)
      _ARG_0_.camera = NULL_HANDLE
      _ARG_0_.cameraStep = 0
    end
  end,
  CanExtraordinaryNaturalPhenomena = function(_ARG_0_)
    _ARG_0_.tmpTargetHandles[1] = Player.GetPlayers()
    _ARG_0_.tmpTargetHandles[2] = Player.GetPlayers()
    _ARG_0_.tmpTargetHandles[3] = Player.GetPlayers()
    for _FORV_7_, _FORV_8_ in pairs(_ARG_0_.tmpTargetHandles) do
      if _FORV_8_ ~= NULL_HANDLE and Player.GetPlayerState(_FORV_8_) ~= _UPVALUE0_ and Player.IsDamageFlagEat(_FORV_8_) == false then
        return false
      end
    end
    return true
  end,
  CalcChainRot = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    FVECTOR3.Sub(_UPVALUE0_, _ARG_3_, _ARG_2_)
    _UPVALUE0_:normalize()
    _ARG_1_:set(RoundPI(-(PI * 0.5) - Math.Atan2(_UPVALUE0_:gety(), Math.Sqrt(_UPVALUE0_:getx() * _UPVALUE0_:getx() + _UPVALUE0_:getz() * _UPVALUE0_:getz()))), Math.Atan2(_UPVALUE0_:getx(), _UPVALUE0_:getz()), 0)
    return (_UPVALUE0_:length())
  end,
  CreateRestraintEffects = function(_ARG_0_)
    _ARG_0_:CreateRestraintEffect(Player.GetPlayers())
    _ARG_0_:CreateRestraintEffect(Player.GetPlayers())
    _ARG_0_:CreateRestraintEffect(Player.GetPlayers())
  end,
  CreateRestraintEffect = function(_ARG_0_, _ARG_1_)
    if _ARG_1_ == NULL_HANDLE then
      return NULL_HANDLE
    end
    if Player.GetPlayerState(_ARG_1_) == _UPVALUE0_ then
      return NULL_HANDLE
    end
    if Player.IsDamageFlagEat(_ARG_1_) == false then
      return NULL_HANDLE
    end
    for _FORV_5_, _FORV_6_ in pairs(_ARG_0_.restraintTbl) do
      if _FORV_6_[1] == _ARG_1_ then
        return NULL_HANDLE
      end
    end
    for _FORV_5_, _FORV_6_ in pairs(_ARG_0_.restraintTbl) do
      if Entity.IsAlive(_FORV_6_[1]) == false then
        _UPVALUE1_:set(0, 0, 0)
        Effect.SetAttachNoRot(Entity.AttachEffect(_ARG_1_, _UPVALUE2_, "B036_SIN_KOU0_0", "hara", _UPVALUE1_, _UPVALUE1_), true)
        Effect.SetModel(Entity.AttachEffect(_ARG_1_, _UPVALUE2_, "B036_SIN_KOU0_0", "hara", _UPVALUE1_, _UPVALUE1_), _ARG_1_)
        Effect.SetAttachAlpha(Entity.AttachEffect(_ARG_1_, _UPVALUE2_, "B036_SIN_KOU0_0", "hara", _UPVALUE1_, _UPVALUE1_), true)
        _ARG_0_.restraintTbl[_FORV_5_][1] = _ARG_1_
        _ARG_0_.restraintTbl[_FORV_5_][2] = Entity.AttachEffect(_ARG_1_, _UPVALUE2_, "B036_SIN_KOU0_0", "hara", _UPVALUE1_, _UPVALUE1_)
        _ARG_0_.restraintTbl[_FORV_5_][3] = 180
        return (Entity.AttachEffect(_ARG_1_, _UPVALUE2_, "B036_SIN_KOU0_0", "hara", _UPVALUE1_, _UPVALUE1_))
      end
    end
    return NULL_HANDLE
  end,
  GotoStateForGround = function(_ARG_0_, _ARG_1_)
    if EntityManager:GetEntity(_ARG_0_.g40vsHandle) ~= nil then
      EntityManager:GetEntity(_ARG_0_.g40vsHandle):GotoState(_ARG_1_)
    end
  end,
  UpdateRestraint = function(_ARG_0_)
    for _FORV_5_, _FORV_6_ in pairs(_ARG_0_.restraintTbl) do
      if Entity.IsAlive(_FORV_6_[1]) and Effect.IsAlive(_FORV_6_[2]) then
        _ARG_0_.restraintTbl[_FORV_5_][3] = _ARG_0_.restraintTbl[_FORV_5_][3] - Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.restraintTbl[_FORV_5_][3] <= 0 and Player.IsDamageFlagEat(_FORV_6_[1]) == false and Player.IsDamageFlagCapture(_FORV_6_[1]) == false then
          Effect.KillEffect(_FORV_6_[2])
          _UPVALUE0_:set(0, 0, 0)
          Effect.SetAttachNoRot(Entity.AttachEffect(_FORV_6_[1], _UPVALUE1_, "B036_SIN_KOU1_0", "hara", _UPVALUE0_, _UPVALUE0_), true)
          _ARG_0_.restraintTbl[_FORV_5_][1] = NULL_HANDLE
          _ARG_0_.restraintTbl[_FORV_5_][2] = NULL_HANDLE
        end
      end
    end
  end,
  GetStyle = function(_ARG_0_, _ARG_1_)
    _ARG_0_.styleCount[Player.GetPlayerID(_ARG_1_, 1)] = _ARG_0_.styleCount[Player.GetPlayerID(_ARG_1_, 1)] + 1
    if _ARG_0_.styleCount[Player.GetPlayerID(_ARG_1_, 1)] >= 2 then
      for _FORV_6_, _FORV_7_ in pairs(_ARG_0_.styleCount) do
        _ARG_0_.styleCount[_FORV_6_] = 0
      end
      return _UPVALUE0_
    end
    return _UPVALUE1_[Player.GetPlayerID(_ARG_1_, 1)][2]
  end,
  AttachMandaraEffect = function(_ARG_0_)
    ArmorEraqus.EnableCreateMikiriZ(_ARG_0_.myHandle, false)
    if _ARG_0_.style ~= _UPVALUE0_ then
      return
    end
    if Effect.IsAlive(_ARG_0_.mandaraHandle) then
      return
    end
    _UPVALUE1_:set(-0.01, 0.18, 0)
    _UPVALUE2_:set(-PI * 0.5, PI * 0.5, 0)
    _ARG_0_.mandaraHandle = Entity.AttachEffect(_ARG_0_.myHandle, _UPVALUE3_, "B036_MNE_ORA0_0", "mune", _UPVALUE1_, _UPVALUE2_)
    _UPVALUE1_:set(1.5, 1.5, 1.5)
    Effect.SetScale(_ARG_0_.mandaraHandle, _UPVALUE1_)
    _UPVALUE1_:set(1, 1, 0.8)
    Effect.SetColor(_ARG_0_.mandaraHandle, _UPVALUE1_)
    Effect.SetModel(_ARG_0_.mandaraHandle, _ARG_0_.myHandle)
    Effect.SetAttachAlpha(_ARG_0_.mandaraHandle, true)
  end,
  CreateMikiriZ = function(_ARG_0_)
    if _ARG_0_.style ~= _UPVALUE0_ then
      ArmorEraqus.EnableCreateMikiriZ(_ARG_0_.myHandle, false)
      return
    end
    if Enemy.GetHp(_ARG_0_.myHandle) <= 0 then
      return
    end
    if ArmorEraqus.CanCreateMikiriZ(_ARG_0_.myHandle) == false then
      return
    end
    if Entity.IsAlive(_ARG_0_.mikiriZHandle) then
      return
    end
    if ArmorEraqus.IsSameTargetHandle(_ARG_0_.myHandle) == false then
      return
    end
    _ARG_0_:LoopEndMandaraEffect(false)
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _UPVALUE1_ then
      Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.targetHandle)
      _UPVALUE3_:set(Math.Sin((Script.RandomInRange(-PI, PI))), 1, Math.Cos((Script.RandomInRange(-PI, PI))))
      FVECTOR3.Add(_UPVALUE4_, _UPVALUE2_, _UPVALUE3_)
      FVECTOR3.Sub(_UPVALUE3_, _UPVALUE2_, _UPVALUE4_)
      _UPVALUE5_:set(0, Math.Atan2(_UPVALUE3_:getx(), _UPVALUE3_:getz()), 0)
      SetBulletAttackParam(Bullet.CreateBullet("b81vsMikiriZ", _UPVALUE4_, _UPVALUE5_), _ARG_0_.myHandle, 30)
      _ARG_0_.mikiriZHandle = Bullet.CreateBullet("b81vsMikiriZ", _UPVALUE4_, _UPVALUE5_)
    else
      Entity.GetRot(_UPVALUE4_, _ARG_0_.myHandle)
      _UPVALUE4_:set(0, 1.5, 0)
      _UPVALUE5_:set(0, RoundPI(Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle) - _UPVALUE4_:gety()), 0)
      SetBulletAttackParam(Bullet.CreateBullet("b81vsMikiriZ", _UPVALUE4_, _UPVALUE5_), _ARG_0_.myHandle, 30)
      Entity.AttachCoordNum(_ARG_0_.myHandle, 0, Bullet.CreateBullet("b81vsMikiriZ", _UPVALUE4_, _UPVALUE5_), 0)
      _ARG_0_.mikiriZHandle = Bullet.CreateBullet("b81vsMikiriZ", _UPVALUE4_, _UPVALUE5_)
    end
  end,
  LoopEndMandaraEffect = function(_ARG_0_, _ARG_1_)
    if _ARG_1_ then
      Effect.DetachCoord(_ARG_0_.mandaraHandle)
      Effect.SetModel(_ARG_0_.mandaraHandle, NULL_HANDLE)
    end
    Effect.LoopEnd(_ARG_0_.mandaraHandle)
    _ARG_0_.mandaraHandle = NULL_HANDLE
  end,
  IsExecShootLock = function(_ARG_0_)
    _ARG_0_.tmpTargetHandles[1] = Player.GetPlayers()
    _ARG_0_.tmpTargetHandles[2] = Player.GetPlayers()
    _ARG_0_.tmpTargetHandles[3] = Player.GetPlayers()
    for _FORV_7_, _FORV_8_ in pairs(_ARG_0_.tmpTargetHandles) do
      if Player.GetPlayerState(_FORV_8_) == 24 and Player.GetSubState(_FORV_8_) == 1 then
        return true
      end
    end
    return false
  end,
  CanGuard = function(_ARG_0_)
    if Enemy.IsInvincible(_ARG_0_.myHandle) then
      return false
    end
    if _ARG_0_:GetState() == "Guard" or _ARG_0_:GetState() == "Evasion" then
      return false
    end
    return _ARG_0_:IsUsedTargetRagingCharge()
  end,
  IsUsedTargetRagingCharge = function(_ARG_0_)
    _ARG_0_.tmpTargetHandles[1] = Player.GetPlayers()
    _ARG_0_.tmpTargetHandles[2] = Player.GetPlayers()
    _ARG_0_.tmpTargetHandles[3] = Player.GetPlayers()
    for _FORV_7_, _FORV_8_ in pairs(_ARG_0_.tmpTargetHandles) do
      if Player.GetCommandKind(_FORV_8_) == COMMAND_KIND_RagingCharge and Player.Limit_IsNowEntry() == 0 then
        return true
      end
    end
    return false
  end,
  GotoStateAbundantStep = function(_ARG_0_)
    _ARG_0_.idlingTime = 0
    _ARG_0_.stack:push(_UPVALUE0_[_ARG_0_.style])
    if Script.Random() < 0.5 then
      _ARG_0_.stack:push("AbundantStepRight")
    else
      _ARG_0_.stack:push("AbundantStepLeft")
    end
    _ARG_0_:GotoState(_ARG_0_.stack:pop())
  end,
  GotoStateGuard = function(_ARG_0_)
    _ARG_0_.idlingTime = 0
    _ARG_0_.stack:push(_UPVALUE0_[_ARG_0_.style])
    if Script.Random() < 0.5 then
      _ARG_0_.stack:push("Guard")
    else
      _ARG_0_.stack:push("Evasion")
    end
    _ARG_0_:GotoState(_ARG_0_.stack:pop())
  end,
  GetTargets = function(_ARG_0_)
    if Player.GetPlayers() ~= NULL_HANDLE and Player.GetPlayerState(Player.GetPlayers()) ~= _UPVALUE0_ then
      _ARG_0_.targetHandles[1] = Player.GetPlayers()
    end
    if Player.GetPlayers() ~= NULL_HANDLE and Player.GetPlayerState(Player.GetPlayers()) ~= _UPVALUE0_ then
      _ARG_0_.targetHandles[1 + 1] = Player.GetPlayers()
    end
    if Player.GetPlayers() ~= NULL_HANDLE and Player.GetPlayerState(Player.GetPlayers()) ~= _UPVALUE0_ then
      _ARG_0_.targetHandles[1 + 1 + 1] = Player.GetPlayers()
    end
    _ARG_0_.targetHandle = _ARG_0_.targetHandles[1]
  end,
  InitExtraParam = function(_ARG_0_)
    _UPVALUE0_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "NEAR_DIST")
    _UPVALUE0_ = _UPVALUE0_ * _UPVALUE0_
    _UPVALUE1_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "SECRETS_CNT")
    _UPVALUE2_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "ACC_DMG_PT")
    _UPVALUE3_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "TORNADOTIME") * 60
    _UPVALUE4_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "TORNADOHOM")
    _UPVALUE5_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "TORNADOSPD")
    _UPVALUE6_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "FLAME_SPD")
    _UPVALUE7_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "FLAME_HOM")
    _UPVALUE8_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "HALO_TIME") * 60
    _UPVALUE9_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "HALO_SPD")
    _UPVALUE10_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "HALO_XSPD")
    _UPVALUE11_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "ECV_SPD")
    _UPVALUE12_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "ECT_SPD")
    _UPVALUE13_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "ECA_SPD")
    _UPVALUE14_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "LB_SPD")
    _UPVALUE15_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "LB_HOM")
    _UPVALUE16_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "THS_SPD")
    _UPVALUE17_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "THS_HOM")
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    _ARG_0_.myHandle = _ARG_1_
    _UPVALUE0_ = Entity.GetMotionIndex(_ARG_1_, "010")
    _UPVALUE1_ = Entity.GetMotionIndex(_ARG_1_, "032")
    _UPVALUE2_ = Entity.GetMotionIndex(_ARG_1_, "033")
    _UPVALUE3_ = Entity.GetMotionIndex(_ARG_1_, "040")
    _UPVALUE4_ = Entity.GetMotionIndex(_ARG_1_, "050")
    _UPVALUE5_ = Entity.GetMotionIndex(_ARG_1_, "051")
    _UPVALUE6_ = Entity.GetMotionIndex(_ARG_1_, "052")
    _UPVALUE7_ = Entity.GetMotionIndex(_ARG_1_, "060")
    _UPVALUE8_ = Entity.GetMotionIndex(_ARG_1_, "061")
    _UPVALUE9_ = Entity.GetMotionIndex(_ARG_1_, "300")
    _UPVALUE10_ = Entity.GetMotionIndex(_ARG_1_, "301")
    _UPVALUE11_ = Entity.GetMotionIndex(_ARG_1_, "302")
    _UPVALUE12_ = Entity.GetMotionIndex(_ARG_1_, "303")
    _UPVALUE13_ = Entity.GetMotionIndex(_ARG_1_, "304")
    _UPVALUE14_ = Entity.GetMotionIndex(_ARG_1_, "305")
    _UPVALUE15_ = Entity.GetMotionIndex(_ARG_1_, "306")
    _UPVALUE16_ = Entity.GetMotionIndex(_ARG_1_, "307")
    _UPVALUE17_ = Entity.GetMotionIndex(_ARG_1_, "308")
    _UPVALUE18_ = Entity.GetMotionIndex(_ARG_1_, "310")
    _UPVALUE19_ = Entity.GetMotionIndex(_ARG_1_, "311")
    _UPVALUE20_ = _UPVALUE12_
    _UPVALUE21_ = Entity.GetMotionIndex(_ARG_1_, "312")
    _UPVALUE22_ = Entity.GetMotionIndex(_ARG_1_, "313")
    _UPVALUE23_ = Entity.GetMotionIndex(_ARG_1_, "320")
    _UPVALUE24_ = Entity.GetMotionIndex(_ARG_1_, "330")
    _UPVALUE25_ = Entity.GetMotionIndex(_ARG_1_, "331")
    _UPVALUE26_ = Entity.GetMotionIndex(_ARG_1_, "340")
    _UPVALUE27_ = Entity.GetMotionIndex(_ARG_1_, "341")
    _UPVALUE28_ = Entity.GetMotionIndex(_ARG_1_, "350")
    _UPVALUE29_ = Entity.GetMotionIndex(_ARG_1_, "351")
    _UPVALUE30_ = Entity.GetMotionIndex(_ARG_1_, "360")
    _UPVALUE31_ = Entity.GetMotionIndex(_ARG_1_, "370")
    _UPVALUE32_ = Entity.GetMotionIndex(_ARG_1_, "410")
    _UPVALUE33_ = Entity.GetMotionIndex(_ARG_1_, "420")
    _UPVALUE34_ = Entity.GetMotionIndex(_ARG_1_, "421")
    _UPVALUE35_ = Entity.GetMotionIndex(_ARG_1_, "422")
    _UPVALUE36_ = Entity.GetMotionIndex(_ARG_1_, "430")
    _UPVALUE37_ = Entity.GetMotionIndex(_ARG_1_, "431")
    _UPVALUE38_ = Entity.GetMotionIndex(_ARG_1_, "440")
    _UPVALUE39_ = Entity.GetMotionIndex(_ARG_1_, "500")
    _UPVALUE40_ = Entity.GetMotionIndex(_ARG_1_, "501")
    _UPVALUE41_ = Entity.GetMotionIndex(_ARG_1_, "502")
    _UPVALUE42_ = Entity.GetMotionIndex(_ARG_1_, "503")
    _ARG_0_:InitExtraParam()
    _ARG_0_.targetHandle = NULL_HANDLE
    _ARG_0_.targetHandles = {
      NULL_HANDLE,
      NULL_HANDLE,
      NULL_HANDLE,
      NULL_HANDLE
    }
    _ARG_0_.tmpTargetHandles = {
      NULL_HANDLE,
      NULL_HANDLE,
      NULL_HANDLE
    }
    _ARG_0_.keyBladeHandle = {}
    _ARG_0_.styleCount = {
      0,
      0,
      0
    }
    _ARG_0_.chainHandle = NULL_HANDLE
    _ARG_0_.plAttachEffHandle = NULL_HANDLE
    _ARG_0_.screenEffHandle = NULL_HANDLE
    _ARG_0_.mandaraHandle = NULL_HANDLE
    _ARG_0_.mikiriZHandle = NULL_HANDLE
    _ARG_0_.camera = NULL_HANDLE
    _ARG_0_.step = 0
    _ARG_0_.step2 = 0
    _ARG_0_.cameraStep = 0
    _ARG_0_.count = 0
    _ARG_0_.atkCount = 0
    _ARG_0_.countB = 0
    _ARG_0_.countB2 = 0
    _ARG_0_.timer = 0
    _ARG_0_.rotTimer = 0
    _ARG_0_.reflect = false
    _ARG_0_.hitAttack = false
    _ARG_0_.style = _UPVALUE43_
    _ARG_0_.considerationFlag = false
    _ARG_0_.idlingTime = _UPVALUE44_[_ARG_0_.style]
    _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
    _ARG_0_.offset = FVECTOR3.new(0, 0, 0)
    _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.warpPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.defenseFlag = false
    _ARG_0_.defenseTimer = 0
    _ARG_0_.oldAttackState = nil
    _ARG_0_.mikiriZRndRate = 0.2
    _ARG_0_.chainUpdate = false
    _ARG_0_.stack = Stack:Create()
    _ARG_0_.stack2 = Stack:Create()
    _ARG_0_.restraintTbl = {}
    for _FORV_5_ = 1, 6 do
      table.insert(_ARG_0_.restraintTbl, {
        NULL_HANDLE,
        NULL_HANDLE,
        0
      })
    end
    for _FORV_5_ = 1, 12 do
      table.insert(_ARG_0_.keyBladeHandle, NULL_HANDLE)
    end
    _FOR_.EnableGuardPhysical(_ARG_1_, 1)
    Entity.EnableGuardFire(_ARG_1_, 1)
    Entity.EnableGuardIce(_ARG_1_, 1)
    Entity.EnableGuardThunder(_ARG_1_, 1)
    Entity.EnableGuardDark(_ARG_1_, 1)
    Entity.EnableGuardSpecial(_ARG_1_, 1)
    Entity.SetGuardDir(_ARG_1_, 180)
    Entity.SetMovementCollRadius(_ARG_1_, 1)
    Entity.SetLowerHalf(_ARG_1_, 1.5)
    Entity.SetDropShadowDistance(_ARG_1_, 10)
    Enemy.SetViewDist(_ARG_1_, 50)
    _ARG_0_.oldHp = Entity.GetHp(_ARG_1_)
    _UPVALUE45_:set(-22, -1, -2)
    _UPVALUE46_:set(0, 0, 0)
    _ARG_0_.g40vsHandle = Entity.CreateEntity("g40vs00", _UPVALUE45_, _UPVALUE46_, _ARG_1_)
    Player.SetBossCamera("b81vs")
    if Enemy.IsAllEnemyWaiting() then
      _ARG_0_:GotoState("Waiting")
    else
      _ARG_0_:GotoState("Appear")
    end
  end,
  OnDestroy = function(_ARG_0_)
    if Player.IsDamageFlagEat((Player.GetHandleForNet())) or Player.IsDamageFlagCapture((Player.GetHandleForNet())) then
      Player.SetTrgFlagCancel(Player.GetHandleForNet(), 1)
    end
    Effect.KillEffect(_ARG_0_.mandaraHandle)
    Effect.KillEffect(_ARG_0_.plAttachEffHandle)
  end,
  OnDamageBefore = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    _ARG_0_.idlingTime = 0
    if _ARG_0_.style == _UPVALUE0_ then
      if Entity.IsAlive(_ARG_0_.mikiriZHandle) == false and Script.Random() < 0.4 then
        ArmorEraqus.EnableCreateMikiriZ(_ARG_0_.myHandle, true)
      end
      if Enemy.IsInvincible(_ARG_0_.myHandle) then
        return 0
      end
      if Enemy.IsNoDamageReaction(_ARG_0_.myHandle) then
        return 0
      end
      if _ARG_0_:GetState() == "Aurora" or _ARG_0_:GetState() == "MikiriZ" or _ARG_0_:GetState() == "GodspeedCuttingZFinish" then
        return 0
      end
      if Script.Random() < 0.3 and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE1_ then
        _ARG_0_.stack:push(_UPVALUE2_[_ARG_0_.style][Script.RandomInteger(2) + 1])
        _ARG_0_:GotoState("Aurora")
        return 1
      end
      return 0
    end
    if Enemy.IsInvincible(_ARG_0_.myHandle) then
      return 0
    end
    if Enemy.IsNoDamageReaction(_ARG_0_.myHandle) then
      return 0
    end
    if Script.Random() < _UPVALUE3_ then
      return 0
    elseif Script.Random() >= _UPVALUE3_ and Script.Random() < _UPVALUE3_ + _UPVALUE4_ and _UPVALUE5_[_ARG_0_.style] ~= nil and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE1_ then
      if _ARG_0_:GetState() ~= nil then
        _ARG_0_.stack:push((_ARG_0_:GetState()))
      else
        _ARG_0_.stack:push(_UPVALUE2_[_ARG_0_.style][Script.RandomInteger(2) + 1])
      end
      _ARG_0_:GotoState(_UPVALUE5_[_ARG_0_.style])
      return 1
    end
    _ARG_0_.stack:push(_UPVALUE2_[_ARG_0_.style][Script.RandomInteger(2) + 1])
    _ARG_0_:GotoState("Guard")
    return 1
  end,
  OnUpdateLast = function(_ARG_0_)
    if _ARG_0_.defenseTimer > 0 then
      _ARG_0_.defenseTimer = _ARG_0_.defenseTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
    end
    _ARG_0_:CreateMikiriZ()
    _ARG_0_:UpdateRestraint()
    _ARG_0_:UpdateCamera()
    if _ARG_0_.chainUpdate then
      _UPVALUE0_:set(0, 0, 0)
      Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle, 41)
      Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.targetHandle, 2)
      Effect.UpdateCoord(_ARG_0_.chainHandle, _UPVALUE0_, _UPVALUE3_)
      _UPVALUE0_:set(_ARG_0_:CalcChainRot(_UPVALUE3_, _UPVALUE1_, _UPVALUE2_) / 10, 1, 1)
      Effect.SetScale(_ARG_0_.chainHandle, _UPVALUE0_)
    end
  end,
  OnDamage = function(_ARG_0_, _ARG_1_, _ARG_2_)
    return 0
  end,
  OnGuard = function(_ARG_0_)
    Entity.GetGuardCrossPos(_UPVALUE0_, _ARG_0_.myHandle)
    _UPVALUE1_:set(0, 0, 0)
    Entity.SetEffect(_ARG_0_.myHandle, _UPVALUE2_, "B036_MKR_HJK0_0", _UPVALUE0_, _UPVALUE1_)
    print("OnGuard()\n")
  end,
  OnDead = function(_ARG_0_)
    SetupBossDead(_ARG_0_.myHandle)
    _ARG_0_:GotoStateSub("Dead")
    return 1
  end,
  OnHitAttack = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    if Entity.GetCurrentMotion(_ARG_0_.myHandle) == _UPVALUE0_ or Entity.GetCurrentMotion(_ARG_0_.myHandle) == _UPVALUE1_ then
      Entity.GetWorldPos(_UPVALUE2_, _ARG_1_, 2)
      _UPVALUE3_:set(0, 0, 0)
      SetBulletAttackParam(Bullet.CreateBullet("EC_Z_Hit", _UPVALUE2_, _UPVALUE3_), _ARG_0_.myHandle, 10)
      Bullet.EnableReflect(Bullet.CreateBullet("EC_Z_Hit", _UPVALUE2_, _UPVALUE3_), 0)
      if EntityManager:GetEntity((Bullet.CreateBullet("EC_Z_Hit", _UPVALUE2_, _UPVALUE3_))) ~= nil then
        EntityManager:GetEntity((Bullet.CreateBullet("EC_Z_Hit", _UPVALUE2_, _UPVALUE3_))).targetHandle = _ARG_1_
        Entity.AttachCoordNum(_ARG_1_, 2, Bullet.CreateBullet("EC_Z_Hit", _UPVALUE2_, _UPVALUE3_), 0)
      end
      Entity.GetDamageCrossPos(_UPVALUE2_, _ARG_1_)
      _UPVALUE3_:set(0, 0, 0)
      Entity.SetEffect(_ARG_1_, _UPVALUE4_, "B036_HIT_ZET2_0", _UPVALUE2_, _UPVALUE3_)
    elseif Entity.GetCurrentMotion(_ARG_0_.myHandle) == _UPVALUE5_ then
      if ArmorEraqus.IsSameTargetHandle(_ARG_0_.myHandle) and _ARG_0_.targetHandle == _ARG_1_ then
        Player.SetDamage(_ARG_0_.targetHandle, _ARG_2_, ATK_KIND_EAT)
        Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 0)
        Entity.SetTimer(_ARG_0_.myHandle, 120)
        _ARG_0_.step = 5
      end
    elseif Entity.GetCurrentMotion(_ARG_0_.myHandle) == _UPVALUE6_ and ArmorEraqus.IsSameTargetHandle(_ARG_0_.myHandle) and _ARG_0_.targetHandle == _ARG_1_ then
      Player.SetDamage(_ARG_0_.targetHandle, 0, ATK_KIND_EAT)
    end
  end,
  OnReturnDamage = function(_ARG_0_)
    _ARG_0_.stack:push(_UPVALUE0_[_ARG_0_.style][1])
    _ARG_0_.reflect = false
    _ARG_0_.defenseFlag = false
    _ARG_0_.defenseTimer = 0
    _ARG_0_:GotoState(_ARG_0_.stack:pop())
  end,
  OnReflect = function(_ARG_0_)
    _ARG_0_.reflect = true
    return 0
  end,
  OnUpdate = function(_ARG_0_)
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
        _ARG_0_.stack:push("Idling")
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        _ARG_0_:GotoState(_UPVALUE0_[Script.GetDebugAttackNumber() + 1])
      end
    end
  end
}, {__index = __StateMachine})
EntityFactory:Add("b81vs00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b81vs01", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("EC_Z_Hit", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b81vsLB", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b81vsKKB", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b81vsHKB", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b81vsFKB", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b81vsCChain", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b81vsTornado", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b81vsSChain", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b81vsSbE", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b81vsENPChain", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b81vsSw", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b81vsSw2", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
setmetatable({
  new = function(_ARG_0_)
    return setmetatable({}, _UPVALUE0_)
  end,
  states = {
    Hide = {
      OnBeginState = function(_ARG_0_)
        Entity.SetRot(_ARG_0_.myHandle, 0, 0, 0)
        Entity.GetStartPos(_UPVALUE0_, _ARG_0_.myHandle)
        Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetOldLocalPos(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetAlpha(_ARG_0_.myHandle, 0)
        Entity.SetAlpha(_ARG_0_.g41vsHandle, 0)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
      end
    },
    Appear = {
      OnBeginState = function(_ARG_0_)
        Entity.SetAlpha(_ARG_0_.myHandle, 1)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
        _ARG_0_.explodeHandle = NULL_HANDLE
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
      end
    },
    Rise = {
      OnBeginState = function(_ARG_0_)
        _UPVALUE0_:set(0, _UPVALUE1_, 0)
        Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetAlpha(_ARG_0_.g41vsHandle, 1)
        Camera.QuakeV(150, 0.4, 100)
        _UPVALUE0_:set(0, 0, 0)
        _ARG_0_.effHandle = Entity.AttachEffect(_ARG_0_.myHandle, _UPVALUE2_, "B036_TEM_SNA0_0", "Root", _UPVALUE0_, _UPVALUE0_)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Effect.LoopEnd(_ARG_0_.effHandle)
        _ARG_0_.effHandle = NULL_HANDLE
      end,
      OnUpdate = function(_ARG_0_)
        Entity.GetStartPos(_UPVALUE0_, _ARG_0_.myHandle)
        Entity.GetLocalPos(_UPVALUE1_, _ARG_0_.myHandle)
        if _UPVALUE1_:gety() - _UPVALUE0_:gety() >= 15 then
          _UPVALUE1_:sety(_UPVALUE0_:gety() + 15)
          Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE1_)
          _ARG_0_:GotoState("Wait")
        end
      end
    },
    Wait = {
      OnBeginState = function(_ARG_0_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
      end
    },
    Fall = {
      OnBeginState = function(_ARG_0_)
        Entity.EnableBgColl(_ARG_0_.myHandle, 1)
        Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
        Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.targetHandle)
        FVECTOR3.Sub(_UPVALUE1_, _UPVALUE1_, _UPVALUE0_)
        _UPVALUE1_:normalize()
        _UPVALUE0_:set(-Math.Atan2(_UPVALUE1_:gety(), Math.Sqrt(_UPVALUE1_:getx() * _UPVALUE1_:getx() + _UPVALUE1_:getz() * _UPVALUE1_:getz())), Math.Atan2(_UPVALUE1_:getx(), _UPVALUE1_:getz()), 0)
        Entity.SetRot(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.speed = _UPVALUE2_
        _UPVALUE1_:scale(7)
        Entity.SetMovementOffset(_ARG_0_.myHandle, _UPVALUE1_)
        _UPVALUE0_:set(0, 0, 0)
        _ARG_0_.effHandle = Entity.AttachEffect(_ARG_0_.myHandle, _UPVALUE3_, "B036_TEM_BLT0_0", "Root", _UPVALUE0_, _UPVALUE0_)
        _ARG_0_.effHandle2 = Entity.SetEffect(_ARG_0_.myHandle, _UPVALUE3_, "B036_TEM_GMN0_0", _UPVALUE0_, _UPVALUE0_)
      end,
      OnEndState = function(_ARG_0_)
        _ARG_0_:Explode()
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.EnableBgColl(_ARG_0_.myHandle, 0)
        Effect.LoopEnd(_ARG_0_.effHandle)
        _ARG_0_.effHandle = NULL_HANDLE
        Effect.LoopEnd(_ARG_0_.effHandle2)
        _ARG_0_.effHandle2 = NULL_HANDLE
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.speed = _ARG_0_.speed + _UPVALUE0_ * Entity.GetFrameRate(_ARG_0_.myHandle)
        Entity.CalcVelocity(_ARG_0_.myHandle, _ARG_0_.speed)
        if Entity.IsGround(_ARG_0_.myHandle) or Entity.IsWall(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Explode")
        end
      end
    },
    Explode = {
      OnBeginState = function(_ARG_0_)
        Entity.SetTimer(_ARG_0_.myHandle, 30)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Hide")
        end
      end
    }
  },
  Explode = function(_ARG_0_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
    Entity.GetVelocity(_UPVALUE1_, _ARG_0_.myHandle)
    _UPVALUE1_:normalize()
    _UPVALUE1_:scale(15)
    FVECTOR3.Add(_UPVALUE1_, _UPVALUE1_, _UPVALUE0_)
    Collision.IntersectRayBg(_UPVALUE0_, COLL_KIND_ENEMY, _UPVALUE0_, _UPVALUE1_)
    Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
    _UPVALUE1_:set(0, 0, 0)
    SetBulletAttackParam(Bullet.CreateBullet("b81vsENPExplode", _UPVALUE0_, _UPVALUE1_), Entity.GetParent(_ARG_0_.myHandle), 19)
    _ARG_0_.explodeHandle = Bullet.CreateBullet("b81vsENPExplode", _UPVALUE0_, _UPVALUE1_)
  end,
  IsEndRise = function(_ARG_0_)
    if _ARG_0_:GetState() ~= "Wait" then
      return false
    end
    return true
  end,
  IsEndExplode = function(_ARG_0_)
    if _ARG_0_.explodeHandle == NULL_HANDLE then
      return false
    end
    if Entity.IsAlive(_ARG_0_.explodeHandle) then
      return false
    end
    return true
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.targetHandle = NULL_HANDLE
    _ARG_0_.explodeHandle = NULL_HANDLE
    _ARG_0_.effHandle = NULL_HANDLE
    _ARG_0_.effHandle2 = NULL_HANDLE
    _ARG_0_.step = 0
    _ARG_0_.speed = 0
    Gimmick.EnableNetwork(_ARG_1_, 1)
    Entity.GetStartPos(_UPVALUE0_, _ARG_1_)
    _UPVALUE0_:sety(0)
    Entity.GetRot(_UPVALUE1_, _ARG_1_)
    _ARG_0_.g41vsHandle = Entity.CreateEntity("g41vs00", _UPVALUE0_, _UPVALUE1_, _ARG_1_)
    Entity.EnableBgColl(_ARG_1_, 0)
    Entity.EnableBgColl(_ARG_0_.g41vsHandle, 0)
    Entity.SetMovementCollRadius(_ARG_1_, 1)
    Entity.EnableCheckUnderFoot(_ARG_1_, 0)
    Entity.SetLowerHalf(_ARG_1_, 0)
    Entity.EnableBodyColl(_ARG_1_, 0)
    Gimmick.SetHp(_ARG_1_, 0)
    _ARG_0_:GotoState("Hide")
  end,
  OnUpdate = function(_ARG_0_)
    _ARG_0_:Update()
  end
}, {__index = __StateMachine})
EntityFactory:Add("g40vs00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b81vsENPExplode", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b81vsGSCA_F", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b81vsMikiriZ", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
