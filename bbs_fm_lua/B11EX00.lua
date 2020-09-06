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
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_.idlingTimer)
        Enemy.SetFaceAnim(_ARG_0_.myHandle, 6, 0)
        _ARG_0_.stack:clear()
        _ARG_0_.step = 0
        _ARG_0_.rotTimer = 0
        _ARG_0_.defenseTimer = 0
        _ARG_0_.defenseFlag = false
      end,
      OnEndState = function(_ARG_0_)
        Enemy.SetFaceAnim(_ARG_0_.myHandle, 1, 0)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        Enemy.GetTargetLastRecordedPos(_UPVALUE0_, _ARG_0_.myHandle, _ARG_0_.targetHandle)
        Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE0_, 2.5)
        Entity.GetRot(_UPVALUE2_, _ARG_0_.myHandle)
        if _ARG_0_.rotTimer > 0 then
          _ARG_0_.rotTimer = _ARG_0_.rotTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
        end
        if 0 > RoundPI(_UPVALUE2_:gety() - _UPVALUE1_:gety()) then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE3_)
          _ARG_0_.rotTimer = 10
        elseif 0 < RoundPI(_UPVALUE2_:gety() - _UPVALUE1_:gety()) then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE4_)
          _ARG_0_.rotTimer = 10
        elseif _ARG_0_.rotTimer <= 0 then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE5_)
        end
        if 0 >= _ARG_0_.defenseTimer then
          if _ARG_0_.defenseFlag == false then
            if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) and Entity.IsAttacking(_ARG_0_.targetHandle) then
              _ARG_0_.defenseFlag = true
              _ARG_0_.defenseTimer = _UPVALUE6_
            end
          else
            _ARG_0_.idlingTimer = 0
            _ARG_0_.stack:push("Idling")
            if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE7_ then
              if Script.Random() < 0.5 then
                _ARG_0_:GotoState("BackhandsSpringJump")
              else
                _ARG_0_:GotoState("Cartwheel")
              end
            else
              _ARG_0_:GotoState("Cartwheel")
            end
            return
          end
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
          return
        end
        if 0 < _ARG_0_.attackCount then
          if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) == false then
            return
          end
          _ARG_0_.stack:push("Idling")
          _ARG_0_:SelectAttackGroundBattle()
        else
          _ARG_0_.stack:push("Idling")
          _ARG_0_:SetupAttack(_UPVALUE8_)
        end
        _ARG_0_.attackCount = _ARG_0_.attackCount + 1
        _ARG_0_.idlingTimer = Script.RandomInRange(_UPVALUE9_, _UPVALUE9_ * 2)
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      end
    },
    Hovering = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, Script.RandomInRange(_UPVALUE1_, _UPVALUE1_ * 2))
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        _ARG_0_.step = 0
        _ARG_0_.timer = 0
        _ARG_0_.stack:clear()
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableGravity(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        Enemy.GetTargetLastRecordedPos(_UPVALUE0_, _ARG_0_.myHandle, _ARG_0_.targetHandle)
        Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE0_, 2.5)
        Entity.GetRot(_UPVALUE2_, _ARG_0_.myHandle)
        if Player.GetCommandKind(Player.GetHandle()) == COMMAND_KIND_DLink17 then
          return
        end
        if _ARG_0_.step == 0 then
          if _ARG_0_:CheckCounter() == 1 then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
            return
          elseif _ARG_0_:CheckCounter() == 0 then
            _ARG_0_.step = 1
            _ARG_0_.timer = _UPVALUE3_
          end
        else
          _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 >= _ARG_0_.timer then
            _ARG_0_.step = 0
          end
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
          return
        end
        if 0 < _ARG_0_.attackCount then
          if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) == false then
            return
          end
          _ARG_0_.stack:push("Hovering")
          _ARG_0_:SelectAttackAirBattle()
        else
          _ARG_0_.stack:push("Hovering")
          _ARG_0_:SetupAttack(_UPVALUE4_)
        end
        _ARG_0_.attackCount = _ARG_0_.attackCount + 1
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      end
    },
    BackhandsSpringJump = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10) == false then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            _UPVALUE1_:set(0, 0.2, -0.15)
            Entity.CalcVelocity(_ARG_0_.myHandle, _UPVALUE1_)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          Entity.GetVelocity(_UPVALUE1_, _ARG_0_.myHandle)
          if 0 > _UPVALUE1_:gety() then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if Entity.IsGround(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.step = 3
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Landing = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsGround(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.step = 1
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Cartwheel = {
      OnBeginState = function(_ARG_0_)
        Entity.SetRot(_ARG_0_.myHandle, 0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle), 0)
        if Script.Random() > 0.5 then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        else
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
        end
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        print("Cartwheel\n")
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 2.5)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Warp = {
      OnBeginState = function(_ARG_0_)
        AddCopyModelVanitusF(_ARG_0_.myHandle, _UPVALUE0_, "B019_WAP_LST0_0", 60)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
        Entity.SetAlpha(_ARG_0_.myHandle, 0)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        _ARG_0_.step = 0
        print("Warp\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
        Entity.SetAlpha(_ARG_0_.myHandle, 1)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    SuccessionAttack = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        _ARG_0_.step = 0
        print("SuccessionAttack\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 5 then
            Entity.SetRootMoveScale(_ARG_0_.myHandle, (Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) + 0.5) / 2, 1, (Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) + 0.5) / 2)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
            Entity.SetRot(_ARG_0_.myHandle, 0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle), 0)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 4 then
            Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
            Entity.GetRot(_UPVALUE2_, _ARG_0_.myHandle)
            _UPVALUE1_:sety(_UPVALUE1_:gety() + 3)
            SetBulletAttackParam(Bullet.CreateBullet("b11exHB", _UPVALUE1_, _UPVALUE2_), _ARG_0_.myHandle, 2)
            if EntityManager:GetEntity((Bullet.CreateBullet("b11exHB", _UPVALUE1_, _UPVALUE2_))) ~= nil then
              EntityManager:GetEntity((Bullet.CreateBullet("b11exHB", _UPVALUE1_, _UPVALUE2_))).targetHandle = _ARG_0_.targetHandle
            end
            _ARG_0_.step = 3
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    XDisCharge = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        _ARG_0_.step = 0
        _ARG_0_.step2 = 0
        print("XDisCharge\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
        Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetRot(_ARG_0_.myHandle, 0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle), 0)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            Entity.SetRootMoveScale(_ARG_0_.myHandle, (Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) + 2) / 6, 1, (Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) + 2) / 6)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetRot(_ARG_0_.myHandle, 0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle), 0)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
            Entity.SetRootMoveScale(_ARG_0_.myHandle, Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) / 3, 1, Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) / 3)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if _ARG_0_.step2 == 0 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 18 then
            Entity.GetRot(_UPVALUE2_, _ARG_0_.myHandle)
            _UPVALUE3_:set(0, 0, 2)
            Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "Root", _UPVALUE3_)
            _UPVALUE4_:set(0, RoundPI(DegToRad(45) + _UPVALUE2_:gety()), 0)
            SetBulletAttackParam(Bullet.CreateBullet("b11exSWC", _UPVALUE3_, _UPVALUE4_), _ARG_0_.myHandle, 8)
            _UPVALUE3_:set(0, 0, 2)
            Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "Root", _UPVALUE3_)
            _UPVALUE4_:set(0, RoundPI(DegToRad(-45) + _UPVALUE2_:gety()), 0)
            SetBulletAttackParam(Bullet.CreateBullet("b11exSWC", _UPVALUE3_, _UPVALUE4_), _ARG_0_.myHandle, 8)
            _UPVALUE3_:set(0, 0, 2)
            Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "Root", _UPVALUE3_)
            _UPVALUE4_:set(0, RoundPI(DegToRad(135) + _UPVALUE2_:gety()), 0)
            SetBulletAttackParam(Bullet.CreateBullet("b11exSWC", _UPVALUE3_, _UPVALUE4_), _ARG_0_.myHandle, 8)
            _UPVALUE3_:set(0, 0, 2)
            Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "Root", _UPVALUE3_)
            _UPVALUE4_:set(0, RoundPI(DegToRad(-135) + _UPVALUE2_:gety()), 0)
            SetBulletAttackParam(Bullet.CreateBullet("b11exSWC", _UPVALUE3_, _UPVALUE4_), _ARG_0_.myHandle, 8)
            _ARG_0_.step2 = 1
          end
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetRot(_ARG_0_.myHandle, 0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle), 0)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE5_)
            Entity.SetRootMoveScale(_ARG_0_.myHandle, (Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) + 2) / 6.5, 1, (Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) + 2) / 6.5)
            _ARG_0_.step = 3
            _ARG_0_.step2 = 0
          end
        elseif _ARG_0_.step == 3 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetRot(_ARG_0_.myHandle, 0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle), 0)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE6_)
            Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
            _UPVALUE3_:set(0, 0.2, -0.25)
            Entity.CalcVelocity(_ARG_0_.myHandle, _UPVALUE3_)
            _ARG_0_.step = 4
          end
        elseif _ARG_0_.step == 4 then
          Entity.GetVelocity(_UPVALUE3_, _ARG_0_.myHandle)
          if 0 >= _UPVALUE3_:gety() then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Entity.SetAttackUseGroup(_ARG_0_.myHandle, 0)
            Entity.SetAttackUseGroup(_ARG_0_.myHandle, 1)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE7_, 1, -1, 1)
            Entity.EnableGravity(_ARG_0_.myHandle, 0)
            _ARG_0_.step = 5
          end
        elseif _ARG_0_.step == 5 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) <= 20 then
            Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          end
          if _ARG_0_.step2 == 0 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 34 then
            _UPVALUE3_:set(0, 0, 2.5)
            Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "center", _UPVALUE3_)
            Entity.GetRot(_UPVALUE4_, _ARG_0_.myHandle)
            SetBulletAttackParam(Bullet.CreateBullet("b11exHXB", _UPVALUE3_, _UPVALUE4_), _ARG_0_.myHandle, 7)
            if EntityManager:GetEntity((Bullet.CreateBullet("b11exHXB", _UPVALUE3_, _UPVALUE4_))) ~= nil then
              EntityManager:GetEntity((Bullet.CreateBullet("b11exHXB", _UPVALUE3_, _UPVALUE4_))).targetHandle = _ARG_0_.targetHandle
            end
            _ARG_0_.step2 = 1
          end
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.EnableGravity(_ARG_0_.myHandle, 1)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE8_)
            Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
            _ARG_0_.step = 6
          end
        elseif _ARG_0_.step == 6 then
          if Entity.IsGround(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE9_)
            _ARG_0_.step = 7
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    DarkThundaga = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.EnableGravity(_ARG_0_.myHandle, 0)
        Entity.SetRot(_ARG_0_.myHandle, 0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle), 0)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        _ARG_0_.velocity:set(0, 0, 0)
        _ARG_0_.step = 0
        print("DarkThundaga\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 14 then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.EnableGravity(_ARG_0_.myHandle, 1)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if Entity.IsGround(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
            _ARG_0_.step = 3
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    DarkSplicer1GroundBattle = {
      OnBeginState = function(_ARG_0_)
        AddCopyModelVanitusF(_ARG_0_.myHandle, _UPVALUE0_, "B019_WAP_LST0_0", 60)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        Entity.SetTimer(_ARG_0_.myHandle, 2)
        Entity.SetAlpha(_ARG_0_.myHandle, 0)
        Entity.EnableGravity(_ARG_0_.myHandle, 0)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        _ARG_0_:SetWarpEffect("B019_WAP_LST0_0")
        _ARG_0_:WarpToTarget(0.75, 0.5)
        _ARG_0_.step = 0
        print("DarkSplicer1GroundBattle\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        Entity.SetAlpha(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:SetWarpEffect("B019_WAP_APP0_0")
            Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
            Entity.SetAlpha(_ARG_0_.myHandle, 1)
            Entity.SetAttackUseGroup(_ARG_0_.myHandle, 2)
            Entity.SetAttackUseGroup(_ARG_0_.myHandle, 3)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            _ARG_0_.step = 1
          end
        else
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            if _ARG_0_.warp == true then
              if Script.Random() < 0.66 then
                Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
                _ARG_0_.warp = false
                _ARG_0_.stack:push("Idling")
                _ARG_0_:GotoState("Landing")
              else
                _ARG_0_:GotoState("DarkSplicer2GroundBattle")
              end
            else
              if _ARG_0_.stack:pop(1) ~= "DarkSplicer2GroundBattle" then
                Entity.EnableGravity(_ARG_0_.myHandle, 1)
                Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
              end
              _ARG_0_:GotoState((_ARG_0_.stack:pop(1)))
            end
          end
        end
      end
    },
    DarkSplicer2GroundBattle = {
      OnBeginState = function(_ARG_0_)
        AddCopyModelVanitusF(_ARG_0_.myHandle, _UPVALUE0_, "B019_WAP_LST0_0", 60)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        Entity.SetTimer(_ARG_0_.myHandle, 2)
        Entity.SetAlpha(_ARG_0_.myHandle, 0)
        Entity.EnableGravity(_ARG_0_.myHandle, 0)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        _ARG_0_:SetWarpEffect("B019_WAP_LST0_0")
        _ARG_0_:WarpToTarget(-0.75, 0.5)
        _ARG_0_.step = 0
        print("DarkSplicer2GroundBattle\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        Entity.SetAlpha(_ARG_0_.myHandle, 1)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:SetWarpEffect("B019_WAP_APP0_0")
            Entity.SetAlpha(_ARG_0_.myHandle, 1)
            if _ARG_0_.warp then
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 0, -1, 1)
            else
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            end
            Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
            _ARG_0_.step = 1
          end
        else
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            if _ARG_0_.warp == true then
              if Script.Random() < 0.66 then
                Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
                _ARG_0_.warp = false
                _ARG_0_.stack:push("Idling")
                _ARG_0_:GotoState("Landing")
              else
                _ARG_0_:GotoState("DarkSplicer1GroundBattle")
              end
            else
              _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
            end
          end
        end
      end
    },
    DarkAxisGroundBattle = {
      OnBeginState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        Entity.SetRot(_ARG_0_.myHandle, 0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle), 0)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _UPVALUE1_:set(0, 0.125, -0.05)
        Entity.CalcVelocity(_ARG_0_.myHandle, _UPVALUE1_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        _ARG_0_.step = 0
        _ARG_0_.count = 0
        print("DarkAxisGroundBattle\n")
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.GetVelocity(_UPVALUE0_, _ARG_0_.myHandle)
          if 0 >= _UPVALUE0_:gety() then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
            Entity.EnableGravity(_ARG_0_.myHandle, 0)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 15 then
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE2_ / _UPVALUE3_)
            Entity.CalcVelocity(_ARG_0_.myHandle, _UPVALUE3_)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE4_)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.step = 3
          end
        elseif _ARG_0_.step == 3 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_.count = _ARG_0_.count + 1
            if _ARG_0_.count >= _UPVALUE5_ then
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE6_)
              Entity.EnableGravity(_ARG_0_.myHandle, 1)
              _ARG_0_.step = 4
            else
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_, 0, -1, 10)
              _ARG_0_.step = 1
            end
          end
        elseif _ARG_0_.step == 4 then
          if Entity.IsGround(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE7_)
            _ARG_0_.step = 5
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    DarkBreaker = {
      OnBeginState = function(_ARG_0_)
        Entity.SetRot(_ARG_0_.myHandle, 0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle), 0)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _UPVALUE1_:set(0, 0.2, 0)
        Entity.CalcVelocity(_ARG_0_.myHandle, _UPVALUE1_)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        _ARG_0_.step = 0
        print("DarkBreaker\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Enemy.EnableInvincible(_ARG_0_.myHandle, 0)
        Entity.EnableBgColl(_ARG_0_.myHandle, 1)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
        _ARG_0_.airBattle = true
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.GetVelocity(_UPVALUE0_, _ARG_0_.myHandle)
          if 0 >= _UPVALUE0_:gety() then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_, 1)
            Entity.EnableGravity(_ARG_0_.myHandle, 0)
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE2_)
            _ARG_0_.step = 1
            _ARG_0_.cameraStep = 1
            print("DarkBreaker1\n")
          end
        elseif _ARG_0_.step == 1 then
          _UPVALUE0_:set(0, 0, 0)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE0_, 10)
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
            _ARG_0_.step = 2
            print("DarkBreaker2\n")
          end
        elseif _ARG_0_.step == 2 then
          _UPVALUE0_:set(0, 0, 0)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE0_, 10)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 15 then
            Entity.GetWorldPos(_UPVALUE4_, _ARG_0_.myHandle)
            FVECTOR3.Sub(_UPVALUE0_, _UPVALUE0_, _UPVALUE4_)
            Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, Math.Abs(_UPVALUE0_:gety()) / 3, 1)
            _UPVALUE0_:sety(0)
            _UPVALUE0_:normalize()
            _UPVALUE0_:scale(_UPVALUE0_:length() / 14)
            Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE0_)
            _ARG_0_.step = 3
            print("DarkBreaker3\n")
          end
        elseif _ARG_0_.step == 3 then
          if Entity.IsGround(_ARG_0_.myHandle) or Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.EnableBgColl(_ARG_0_.myHandle, 0)
            _UPVALUE0_:set(0, 0, 0)
            _ARG_0_.effHandle = Entity.SetEffect(_ARG_0_.myHandle, _UPVALUE5_, "B019_DBR_SHO0_0", _UPVALUE0_, _UPVALUE0_)
            _ARG_0_.step = 4
            print("DarkBreaker4\n")
          end
        elseif _ARG_0_.step == 4 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.step = 5
            print("DarkBreaker5\n")
          end
        elseif _ARG_0_.step == 5 then
          if Effect.GetNowFrame(_ARG_0_.effHandle) >= 200 then
            NotifyStartDLinkVanitusF()
            Entity.Out(_ARG_0_.stainedGlassHandle)
            _UPVALUE0_:set(0, 0, 0)
            _ARG_0_.stainedGlassHandle = Entity.CreateEntity("g52kg00", _UPVALUE0_, _UPVALUE0_)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
            Entity.SetTimer(_ARG_0_.myHandle, 60)
            _UPVALUE0_:set(0, 0, 0)
            Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE0_)
            _ARG_0_.step = 6
            print("DarkBreaker6\n")
          end
        elseif _ARG_0_.step == 6 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetRot(_ARG_0_.myHandle, 0, Entity.CalcDirection(_ARG_0_.myHandle, Player.GetHandle()), 0)
            Entity.SetRot(Player.GetHandle(), 0, Entity.CalcDirection(Player.GetHandle(), _ARG_0_.myHandle), 0)
            Entity.GetLocalPos(_UPVALUE0_, _ARG_0_.myHandle)
            Entity.GetLocalPos(_UPVALUE4_, Player.GetHandle())
            _UPVALUE4_:sety(_UPVALUE0_:gety())
            Entity.SetLocalPos(Player.GetHandle(), _UPVALUE4_)
            Entity.SetTimer(_ARG_0_.myHandle, 60)
            _ARG_0_.step = 7
          end
        elseif _ARG_0_.step == 7 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetTimer(_ARG_0_.myHandle, 120)
            Player.ResetCamera()
            _ARG_0_.step = 8
          end
        elseif Entity.IsTimeOver(_ARG_0_.myHandle) then
          Player.NotifyEventEnd(Player.GetHandle())
          Effect.LoopEnd(_ARG_0_.effHandle)
          Wnd.CreateInfoWnd("kg60020")
          Mission.SetMissionPauseCTDID("kg60021")
          print("DarkBreaker end\n")
          _ARG_0_:GotoState("Hovering")
        end
      end
    },
    DarkSplicer1AirBattle = {
      OnBeginState = function(_ARG_0_)
        AddCopyModelVanitusF(_ARG_0_.myHandle, _UPVALUE0_, "B019_WAP_LST0_0", 60)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        Entity.SetTimer(_ARG_0_.myHandle, 2)
        Entity.SetAlpha(_ARG_0_.myHandle, 0)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        _ARG_0_:SetWarpEffect("B019_WAP_LST0_0")
        _ARG_0_:WarpToTarget(0.75, 0.5)
        _ARG_0_.step = 0
        print("DarkSplicer1AirBattle\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
        Entity.SetAlpha(_ARG_0_.myHandle, 1)
        Player.SetEnemyCommand(COMMAND_KIND_None)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:SetWarpEffect("B019_WAP_APP0_0")
            Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
            Entity.SetAlpha(_ARG_0_.myHandle, 1)
            Entity.SetAttackUseGroup(_ARG_0_.myHandle, 2)
            Entity.SetAttackUseGroup(_ARG_0_.myHandle, 3)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            _ARG_0_.step = 1
          end
        else
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            if _ARG_0_.warp == true then
              if Script.Random() < 0.66 then
                Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
                _ARG_0_.warp = false
                _ARG_0_:GotoState("Hovering")
              else
                _ARG_0_:GotoState("DarkSplicer2AirBattle")
              end
            else
              if _ARG_0_.stack:pop(1) ~= "DarkSplicer2AirBattle" then
                Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
              end
              _ARG_0_:GotoState((_ARG_0_.stack:pop(1)))
            end
          end
        end
      end
    },
    DarkSplicer2AirBattle = {
      OnBeginState = function(_ARG_0_)
        AddCopyModelVanitusF(_ARG_0_.myHandle, _UPVALUE0_, "B019_WAP_LST0_0", 60)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        Entity.SetTimer(_ARG_0_.myHandle, 2)
        Entity.SetAlpha(_ARG_0_.myHandle, 0)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        _ARG_0_:SetWarpEffect("B019_WAP_LST0_0")
        _ARG_0_:WarpToTarget(-0.75, 0.5)
        _ARG_0_.step = 0
        print("DarkSplicer2AirBattle\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
        Entity.SetAlpha(_ARG_0_.myHandle, 1)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Player.SetEnemyCommand(COMMAND_KIND_None)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:SetWarpEffect("B019_WAP_APP0_0")
            Entity.SetAlpha(_ARG_0_.myHandle, 1)
            if _ARG_0_.warp then
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 0, -1, 1)
            else
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            end
            Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
            _ARG_0_.step = 1
          end
        else
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            if _ARG_0_.warp == true then
              if Script.Random() < 0.66 then
                Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
                _ARG_0_.warp = false
                _ARG_0_:GotoState("Hovering")
              else
                _ARG_0_:GotoState("DarkSplicer1AirBattle")
              end
            else
              _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
            end
          end
        end
      end
    },
    DarkSplicerDuel = {
      OnBeginState = function(_ARG_0_)
        Player.SetEnemyCommand(COMMAND_KIND_DarkSplicer)
        _ARG_0_.step = 0
        print("DarkSplicerDuel\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
        Entity.SetAlpha(_ARG_0_.myHandle, 1)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Player.SetEnemyCommand(COMMAND_KIND_None)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          AddCopyModelVanitusF(_ARG_0_.myHandle, _UPVALUE0_, "B019_WAP_LST0_0", 60)
          Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
          Entity.SetTimer(_ARG_0_.myHandle, 2)
          Entity.SetAlpha(_ARG_0_.myHandle, 0)
          Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
          _ARG_0_:SetWarpEffect("B019_WAP_LST0_0")
          _ARG_0_:WarpToTarget(-0.75, 0.5)
          _ARG_0_.step = 1
        elseif _ARG_0_.step == 1 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:SetWarpEffect("B019_WAP_APP0_0")
            Entity.SetAlpha(_ARG_0_.myHandle, 1)
            Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE1_)
            Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if _ARG_0_:CheckDuelDarkSplicer() == _UPVALUE2_ then
            Entity.SetTimer(_ARG_0_.myHandle, 180)
            _ARG_0_.step = 3
          elseif _ARG_0_:CheckDuelDarkSplicer() == _UPVALUE3_ then
            Player.SetEnemyCommand(COMMAND_KIND_None)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE4_)
            Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE5_)
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE6_)
            Enemy.SetFaceAnim(_ARG_0_.myHandle, 2, 1)
            _ARG_0_.timer = 60
            _ARG_0_.step = 4
          elseif _ARG_0_:CheckDuelDarkSplicer() == _UPVALUE7_ then
            if 0.5 > Script.Random() then
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE8_)
            else
              Entity.SetAttackUseGroup(_ARG_0_.myHandle, 2)
              Entity.SetAttackUseGroup(_ARG_0_.myHandle, 3)
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE9_)
            end
            _ARG_0_.step = 6
          end
        elseif _ARG_0_.step == 3 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_.step = 0
          end
        elseif _ARG_0_.step == 4 then
          if 0 < _ARG_0_.timer then
            _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
            if 0 >= _ARG_0_.timer then
              Entity.GetWorldPos(_UPVALUE10_, _ARG_0_.myHandle, 2)
              _UPVALUE11_:set(0, 0, 0)
              Entity.SetEffect(_ARG_0_.myHandle, _UPVALUE0_, "B019_WIN_FLS0_0", _UPVALUE10_, _UPVALUE11_)
            end
          end
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE12_)
            _ARG_0_.step = 5
          end
        elseif _ARG_0_.step == 5 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_:GotoState("Hovering")
          end
        elseif _ARG_0_.step == 6 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_:GotoState("Hovering")
          end
        elseif _ARG_0_.step == 7 and Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_.step = 0
        end
      end
    },
    DarkAxisAirBattle = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Player.SetEnemyCommand(COMMAND_KIND_DarkAxis)
        _ARG_0_.count = 0
        _ARG_0_.step = 0
        print("DarkAxisAirBattle\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Player.SetEnemyCommand(COMMAND_KIND_None)
        Enemy.SetFaceAnim(_ARG_0_.myHandle, 3, 2)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 15 then
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_ / _UPVALUE1_)
            Entity.CalcVelocity(_ARG_0_.myHandle, _UPVALUE1_)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_.count = _ARG_0_.count + 1
            if _ARG_0_.count >= _UPVALUE3_ then
              _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
            else
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE4_, 0, -1, 10)
              _ARG_0_.step = 0
            end
          end
        elseif _ARG_0_.step == 3 then
          if Player.GetDuelResult(_ARG_0_.targetHandle) == _UPVALUE5_ then
            print("\131_\129[\131N\131A\131N\131V\131X\129F\131v\131\140\131C\131\132\129[\130\204\143\159\130\191\n")
            Player.SetEnemyCommand(COMMAND_KIND_None)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE6_)
            Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE7_)
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE8_)
            Enemy.SetFaceAnim(_ARG_0_.myHandle, 2, 1)
            _ARG_0_.timer = 60
            _ARG_0_.step = 4
          elseif Player.GetDuelResult(_ARG_0_.targetHandle) == _UPVALUE9_ then
            print("\131_\129[\131N\131A\131N\131V\131X\129F\131\148\131@\131j\131^\131XF\130\204\143\159\130\191\n")
            Player.SetEnemyCommand(COMMAND_KIND_None)
            Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
            _ARG_0_.step = 0
          end
        elseif _ARG_0_.step == 4 then
          if 0 < _ARG_0_.timer then
            _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
            if 0 >= _ARG_0_.timer then
              Entity.GetWorldPos(_UPVALUE10_, _ARG_0_.myHandle, 2)
              _UPVALUE11_:set(0, 0, 0)
              Entity.SetEffect(_ARG_0_.myHandle, _UPVALUE12_, "B019_WIN_FLS0_0", _UPVALUE10_, _UPVALUE11_)
            end
          end
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE13_)
            _ARG_0_.step = 5
          end
        elseif _ARG_0_.step == 5 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    DarkCannon = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        _ARG_0_.step = 0
        _ARG_0_.count = 0
        print("DarkCannon\n")
      end,
      OnEndState = function(_ARG_0_)
        Player.SetLockOnMakert(_ARG_0_.myHandle, 0)
        if EntityManager:GetEntity(_ARG_0_.laserHandle) ~= nil then
          EntityManager:GetEntity(_ARG_0_.laserHandle):Destroy()
        end
        Player.SetEnemyCommand(COMMAND_KIND_None)
        Entity.EnableGravity(_ARG_0_.myHandle, 0)
        Enemy.SetFaceAnim(_ARG_0_.myHandle, 3, 2)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, _UPVALUE0_ / _UPVALUE0_ * _UPVALUE1_ + (1 - _UPVALUE0_ / _UPVALUE0_) * _UPVALUE2_)
        if _ARG_0_.step == 0 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE3_)
            Player.SetLockOnMakert(_ARG_0_.myHandle, 1)
            _ARG_0_.count = _ARG_0_.count + 1
            if _ARG_0_.count >= _UPVALUE4_ then
              Player.SetEnemyLockOne(_ARG_0_.myHandle)
              Entity.SetTimer(_ARG_0_.myHandle, 60)
              _ARG_0_.step = 1
            end
          end
        elseif _ARG_0_.step == 1 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE5_)
            Player.SetLockOnMakert(_ARG_0_.myHandle, 0)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 13 then
            _UPVALUE6_:set(0, 1.2, 2)
            _UPVALUE7_:set(-PI * 0.5, 0, 0)
            _ARG_0_.laserHandle = Bullet.CreateBullet("DCNLaser", _UPVALUE6_, _UPVALUE7_)
            SetBulletAttackParam(_ARG_0_.laserHandle, _ARG_0_.myHandle, 13)
            Entity.AttachCoord(_ARG_0_.myHandle, "Root", _ARG_0_.laserHandle, "Root")
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE8_)
            Player.SetEnemyCommand(COMMAND_KIND_DarkCannon)
            _ARG_0_.step = 3
          end
        elseif _ARG_0_.step == 3 then
          if Entity.GetTimer(_ARG_0_.myHandle) <= 10 then
            Player.SetEnemyCommand(COMMAND_KIND_None)
          end
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            if EntityManager:GetEntity(_ARG_0_.laserHandle) ~= nil then
              EntityManager:GetEntity(_ARG_0_.laserHandle):Destroy()
            end
            _ARG_0_.laserHandle = NULL_HANDLE
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE9_)
            _ARG_0_.step = 4
          end
        elseif _ARG_0_.step == 4 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        elseif _ARG_0_.step == 5 then
          if Player.GetDuelResult(_ARG_0_.targetHandle) == _UPVALUE10_ then
            print("\131_\129[\131N\131L\131\131\131m\131\147\129F\131v\131\140\131C\131\132\129[\130\204\143\159\130\191\n")
            Player.SetEnemyCommand(COMMAND_KIND_None)
            if EntityManager:GetEntity(_ARG_0_.laserHandle) ~= nil then
              EntityManager:GetEntity(_ARG_0_.laserHandle).step = 1
              EntityManager:GetEntity(_ARG_0_.laserHandle):Destroy()
            end
            _ARG_0_.laserHandle = NULL_HANDLE
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE11_)
            Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE12_)
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE13_)
            Enemy.SetFaceAnim(_ARG_0_.myHandle, 2, 1)
            _ARG_0_.timer = 60
            _ARG_0_.step = 6
          elseif Player.GetDuelResult(_ARG_0_.targetHandle) == _UPVALUE14_ then
            print("\131_\129[\131N\131L\131\131\131m\131\147\129F\131\148\131@\131j\131^\131XF\130\204\143\159\130\191\n")
            Player.SetEnemyCommand(COMMAND_KIND_None)
            Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE8_)
            _ARG_0_.step = 3
          end
        elseif _ARG_0_.step == 6 then
          if 0 < _ARG_0_.timer then
            _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
            if 0 >= _ARG_0_.timer then
              Entity.GetWorldPos(_UPVALUE6_, _ARG_0_.myHandle, 2)
              _UPVALUE7_:set(0, 0, 0)
              Entity.SetEffect(_ARG_0_.myHandle, _UPVALUE15_, "B019_WIN_FLS0_0", _UPVALUE6_, _UPVALUE7_)
            end
          end
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE16_)
            _ARG_0_.step = 7
          end
        elseif _ARG_0_.step == 7 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Dead = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_.step = 0
        Entity.SetRot(_ARG_0_.myHandle, 0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle), 0)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE1_)
        Enemy.SetFaceAnim(_ARG_0_.myHandle, 2, 1)
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
            Sound.PlayVoice(105, 32, 1, _UPVALUE0_, SE_OPT_ALWAYS)
            _ARG_0_.step = 2
          end
        end
      end
    }
  },
  RestHpRate = function(_ARG_0_)
    return Enemy.GetHp(_ARG_0_.myHandle) / Enemy.GetHpMax(_ARG_0_.myHandle)
  end,
  SetWarpEffect = function(_ARG_0_, _ARG_1_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 2)
    _UPVALUE1_:set(0, 0, 0)
    Entity.SetEffect(_ARG_0_.myHandle, _UPVALUE2_, _ARG_1_, _UPVALUE0_, _UPVALUE1_)
  end,
  WarpToTarget = function(_ARG_0_, _ARG_1_, _ARG_2_)
    Entity.GetDir(_UPVALUE0_, _ARG_0_.targetHandle)
    _UPVALUE0_:scale(_ARG_1_)
    Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
    Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.targetHandle)
    if Collision.IntersectRayBg(_UPVALUE2_, COLL_KIND_ENEMY, _UPVALUE1_, _UPVALUE2_) then
      Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
    else
      Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.targetHandle)
      _UPVALUE2_:copy(_UPVALUE1_)
      _UPVALUE1_:sety(_UPVALUE1_:gety() + 1)
      _UPVALUE2_:sety(_UPVALUE2_:gety() - 10)
      if Collision.IntersectRayBg(_UPVALUE3_, COLL_KIND_ENEMY, _UPVALUE1_, _UPVALUE2_) then
        _UPVALUE1_:sety(_UPVALUE3_:gety())
      else
        Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
      end
    end
    FVECTOR3.Add(_UPVALUE0_, _UPVALUE0_, _UPVALUE1_)
    Collision.IntersectRayBg(_UPVALUE0_, COLL_KIND_ENEMY, _UPVALUE1_, _UPVALUE0_)
    _UPVALUE0_:sety(_UPVALUE0_:gety() + _ARG_2_)
    Entity.Warp(_ARG_0_.myHandle, _UPVALUE0_)
    Entity.SetOldLocalPos(_ARG_0_.myHandle, _UPVALUE1_)
    FVECTOR3.Sub(_UPVALUE0_, _UPVALUE1_, _UPVALUE0_)
    Entity.SetRot(_ARG_0_.myHandle, 0, Math.Atan2(_UPVALUE0_:getx(), _UPVALUE0_:getz()), 0)
  end,
  SelectAttackGroundBattle = function(_ARG_0_)
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE0_ then
      if Script.Random() < _UPVALUE1_ then
        if _ARG_0_.oldAtkKind ~= _UPVALUE2_ then
          _ARG_0_:SetupAttack(_UPVALUE2_)
        else
          _ARG_0_:SetupAttack(_UPVALUE3_)
        end
      elseif _ARG_0_.oldAtkKind ~= _UPVALUE3_ then
        _ARG_0_:SetupAttack(_UPVALUE3_)
      else
        _ARG_0_:SetupAttack(_UPVALUE2_)
      end
    elseif Script.Random() < _UPVALUE1_ then
      if _ARG_0_.oldAtkKind ~= _UPVALUE4_ then
        _ARG_0_:SetupAttack(_UPVALUE4_)
      elseif Script.Random() < 0.5 then
        _ARG_0_:SetupAttack(_UPVALUE5_)
      else
        _ARG_0_:SetupAttack(_UPVALUE6_)
      end
    elseif Script.Random() >= _UPVALUE1_ and Script.Random() < _UPVALUE1_ + _UPVALUE7_ then
      if _ARG_0_.oldAtkKind ~= _UPVALUE5_ then
        _ARG_0_:SetupAttack(_UPVALUE5_)
      elseif Script.Random() < 0.5 then
        _ARG_0_:SetupAttack(_UPVALUE4_)
      else
        _ARG_0_:SetupAttack(_UPVALUE6_)
      end
    elseif _ARG_0_.oldAtkKind ~= _UPVALUE6_ then
      _ARG_0_:SetupAttack(_UPVALUE6_)
    elseif Script.Random() < 0.5 then
      _ARG_0_:SetupAttack(_UPVALUE4_)
    else
      _ARG_0_:SetupAttack(_UPVALUE5_)
    end
  end,
  SelectAttackAirBattle = function(_ARG_0_)
    if Script.Random() < _UPVALUE0_ then
      if _ARG_0_.oldAtkKind ~= _UPVALUE1_ then
        _ARG_0_:SetupAttack(_UPVALUE1_)
      elseif Script.Random() < 0.5 then
        _ARG_0_:SetupAttack(_UPVALUE2_)
      else
        _ARG_0_:SetupAttack(_UPVALUE3_)
      end
    elseif Script.Random() >= _UPVALUE0_ and Script.Random() < _UPVALUE0_ + _UPVALUE4_ then
      if _ARG_0_.oldAtkKind ~= _UPVALUE2_ then
        _ARG_0_:SetupAttack(_UPVALUE2_)
      elseif Script.Random() < 0.5 then
        _ARG_0_:SetupAttack(_UPVALUE1_)
      else
        _ARG_0_:SetupAttack(_UPVALUE3_)
      end
    elseif _ARG_0_.oldAtkKind ~= _UPVALUE3_ then
      _ARG_0_:SetupAttack(_UPVALUE3_)
    elseif Script.Random() < 0.5 then
      _ARG_0_:SetupAttack(_UPVALUE1_)
    else
      _ARG_0_:SetupAttack(_UPVALUE2_)
    end
  end,
  SetupAttack = function(_ARG_0_, _ARG_1_)
    if _ARG_1_ == _UPVALUE0_ then
      _ARG_0_.stack:push("SuccessionAttack")
    elseif _ARG_1_ == _UPVALUE1_ then
      _ARG_0_.stack:push("XDisCharge")
    elseif _ARG_1_ == _UPVALUE2_ then
      _ARG_0_.stack:push("Landing")
      if Script.Random() < 0.1 then
      elseif Script.Random() >= 0.1 and Script.Random() < 0.6 then
      elseif Script.Random() >= 0.6 and Script.Random() < 0.85 then
      else
      end
      for _FORV_7_ = 1, 4 do
        _ARG_0_.stack:push("DarkSplicer2GroundBattle")
        _ARG_0_.stack:push("DarkSplicer1GroundBattle")
      end
    elseif _ARG_1_ == _UPVALUE3_ then
      _ARG_0_.stack:push("DarkThundaga")
    elseif _ARG_1_ == _UPVALUE4_ then
      _ARG_0_.stack:push("DarkAxisGroundBattle")
    elseif _ARG_1_ == _UPVALUE5_ then
      if Script.Random() < 0.1 then
      elseif Script.Random() >= 0.1 and Script.Random() < 0.6 then
      elseif Script.Random() >= 0.6 and Script.Random() < 0.85 then
      else
      end
      for _FORV_7_ = 1, 4 do
        _ARG_0_.stack:push("DarkSplicer2AirBattle")
        _ARG_0_.stack:push("DarkSplicer1AirBattle")
      end
    elseif _ARG_1_ == _UPVALUE6_ then
      _ARG_0_.stack:push("DarkCannon")
    elseif _ARG_1_ == _UPVALUE7_ then
      _ARG_0_.stack:push("DarkAxisAirBattle")
    end
    _ARG_0_.oldAtkKind = _ARG_1_
  end,
  CheckCounter = function(_ARG_0_)
    if Player.GetCommandKind(_ARG_0_.targetHandle) == COMMAND_KIND_DarkAxis then
      if Script.Random() < 0.5 then
        _ARG_0_.stack:push("Hovering")
        _ARG_0_:SetupAttack(_UPVALUE0_)
        return 1
      else
        return 0
      end
    elseif Player.GetCommandKind(_ARG_0_.targetHandle) == COMMAND_KIND_DarkSplicer then
      if Script.Random() < 0.5 then
        _ARG_0_.stack:push("Hovering")
        _ARG_0_:SetupAttack(_UPVALUE1_)
        Player.SetEnemyCommand(COMMAND_KIND_DarkSplicer)
        return 1
      else
        return 0
      end
    elseif Player.GetCommandKind(_ARG_0_.targetHandle) == COMMAND_KIND_DarkCannon then
      if Script.Random() < 0.5 then
        _ARG_0_.stack:push("Hovering")
        _ARG_0_:SetupAttack(_UPVALUE0_)
        return 1
      else
        return 0
      end
    end
    return -1
  end,
  IsDuel = function(_ARG_0_)
    if _ARG_0_:GetState() == "DarkAxisAirBattle" then
      if _ARG_0_.step == 3 then
        return true
      end
    elseif _ARG_0_:GetState() == "DarkCannon" and _ARG_0_.step == 5 then
      return true
    end
    return false
  end,
  DarkBreakerCamera = function(_ARG_0_)
    if _ARG_0_.cameraStep == 1 and Camera.IsEndExusiaCamera(_ARG_0_.camera) then
      Script.OutTask(_ARG_0_.camera)
      _ARG_0_.camera = NULL_HANDLE
      _ARG_0_.cameraCount = _ARG_0_.cameraCount + 1
      if _ARG_0_.cameraCount <= #_UPVALUE0_ then
        _ARG_0_.camera = Camera.CreateExusiaCamera(_UPVALUE0_[_ARG_0_.cameraCount])
        Camera.SetExusiaBaseCoord(_ARG_0_.camera, _ARG_0_.myHandle, 0)
        Camera.StartExusiaCamera(_ARG_0_.camera)
      else
        _ARG_0_.cameraStep = 2
      end
    end
  end,
  CheckDuelDarkSplicer = function(_ARG_0_)
    if Player.GetDuelResult(_ARG_0_.targetHandle) >= _UPVALUE0_ and Player.GetDuelResult(_ARG_0_.targetHandle) <= _UPVALUE1_ then
      print("\131_\129[\131N\131X\131v\131\137\131C\131T\129[\130\194\130\206\130\186\130\232\130\160\130\162\131\130\129[\131h ... \144\172\140\247\n")
      return _UPVALUE2_
    elseif Player.GetDuelResult(_ARG_0_.targetHandle) == _UPVALUE3_ then
      print("\131_\129[\131N\131X\131v\131\137\131C\131T\129[\130\194\130\206\130\186\130\232\130\160\130\162\131\130\129[\131h ... \131t\131B\131j\131b\131V\131\133\n")
      return _UPVALUE4_
    elseif Player.GetDuelResult(_ARG_0_.targetHandle) == _UPVALUE5_ then
      print("\131_\129[\131N\131X\131v\131\137\131C\131T\129[\130\194\130\206\130\186\130\232\130\160\130\162\131\130\129[\131h ... \142\184\148s\n")
      return _UPVALUE6_
    end
    return _UPVALUE7_
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    _UPVALUE0_ = Entity.GetMotionIndex(_ARG_1_, "010")
    _UPVALUE1_ = Entity.GetMotionIndex(_ARG_1_, "011")
    _UPVALUE2_ = Entity.GetMotionIndex(_ARG_1_, "030")
    _UPVALUE3_ = Entity.GetMotionIndex(_ARG_1_, "031")
    _UPVALUE4_ = Entity.GetMotionIndex(_ARG_1_, "032")
    _UPVALUE5_ = Entity.GetMotionIndex(_ARG_1_, "033")
    _UPVALUE6_ = Entity.GetMotionIndex(_ARG_1_, "040")
    _UPVALUE7_ = Entity.GetMotionIndex(_ARG_1_, "050")
    _UPVALUE8_ = Entity.GetMotionIndex(_ARG_1_, "051")
    _UPVALUE9_ = Entity.GetMotionIndex(_ARG_1_, "052")
    _UPVALUE10_ = Entity.GetMotionIndex(_ARG_1_, "053")
    _UPVALUE11_ = Entity.GetMotionIndex(_ARG_1_, "054")
    _UPVALUE12_ = Entity.GetMotionIndex(_ARG_1_, "061")
    _UPVALUE13_ = Entity.GetMotionIndex(_ARG_1_, "062")
    _UPVALUE14_ = Entity.GetMotionIndex(_ARG_1_, "300")
    _UPVALUE15_ = Entity.GetMotionIndex(_ARG_1_, "301")
    _UPVALUE16_ = Entity.GetMotionIndex(_ARG_1_, "302")
    _UPVALUE17_ = Entity.GetMotionIndex(_ARG_1_, "303")
    _UPVALUE18_ = Entity.GetMotionIndex(_ARG_1_, "306")
    _UPVALUE19_ = Entity.GetMotionIndex(_ARG_1_, "308")
    _UPVALUE20_ = Entity.GetMotionIndex(_ARG_1_, "309")
    _UPVALUE21_ = Entity.GetMotionIndex(_ARG_1_, "310")
    _UPVALUE22_ = Entity.GetMotionIndex(_ARG_1_, "311")
    _UPVALUE23_ = Entity.GetMotionIndex(_ARG_1_, "312")
    _UPVALUE24_ = Entity.GetMotionIndex(_ARG_1_, "313")
    _UPVALUE25_ = Entity.GetMotionIndex(_ARG_1_, "314")
    _UPVALUE26_ = Entity.GetMotionIndex(_ARG_1_, "315")
    _UPVALUE27_ = Entity.GetMotionIndex(_ARG_1_, "316")
    _UPVALUE28_ = Entity.GetMotionIndex(_ARG_1_, "317")
    _UPVALUE29_ = Entity.GetMotionIndex(_ARG_1_, "400")
    _UPVALUE30_ = Entity.GetMotionIndex(_ARG_1_, "210")
    _UPVALUE31_ = Entity.GetMotionIndex(_ARG_1_, "211")
    _UPVALUE32_ = Entity.GetMotionIndex(_ARG_1_, "220")
    _UPVALUE33_ = Entity.GetMotionIndex(_ARG_1_, "221")
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.targetHandle = NULL_HANDLE
    _ARG_0_.effHandle = NULL_HANDLE
    _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
    _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
    _ARG_0_.step = 0
    _ARG_0_.step2 = 0
    _ARG_0_.count = 0
    _ARG_0_.attackCount = 0
    _ARG_0_.dmgCount = 0
    _ARG_0_.idlingTimer = _UPVALUE34_
    _ARG_0_.rotTimer = 0
    _ARG_0_.oldAtkKind = -1
    _ARG_0_.airBattle = false
    _ARG_0_.warp = false
    _ARG_0_.defenseTimer = 0
    _ARG_0_.defenseFlag = false
    _ARG_0_.laserScale = 1
    _ARG_0_.laserHandle = NULL_HANDLE
    _ARG_0_.camera = NULL_HANDLE
    _ARG_0_.cameraStep = 0
    _ARG_0_.cameraCount = 0
    _ARG_0_.stack = Stack:Create()
    _UPVALUE35_:set(0, 0, 0)
    _ARG_0_.stainedGlassHandle = Entity.CreateEntity("g53kg00", _UPVALUE35_, _UPVALUE35_)
    Entity.EnableGravity(_ARG_1_, 1)
    Enemy.SetViewDist(_ARG_1_, 50)
    Player.SetBossCamera("b11ex")
    _ARG_0_:GotoState("Appear")
  end,
  GetDamageMotionNum = function(_ARG_0_, _ARG_1_)
    if _ARG_0_.airBattle then
      if _ARG_1_ == MOT_GROUND_FRONT_UPPER or tyep == MOT_GROUND_FRONT_LOWER then
        return _UPVALUE0_
      elseif _ARG_1_ == MOT_GROUND_BACK_UPPER or tyep == MOT_GROUND_BACK_LOWER then
        return _UPVALUE1_
      end
    end
    return -1
  end,
  OnMessage = function(_ARG_0_, _ARG_1_, _ARG_2_)
    print("OnMessage: msg = " .. _ARG_1_ .. "\n")
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 2)
    Sound.PlayVoice(105, _UPVALUE1_[Script.RandomInteger(#_UPVALUE1_) + 1], 1, _UPVALUE0_)
    if _ARG_1_ == _UPVALUE2_ or _ARG_1_ == _UPVALUE3_ then
      if _ARG_0_:GetState() == "DarkAxisAirBattle" then
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE4_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        _ARG_0_.step = 3
        print("\131_\129[\131N\131A\131N\131V\131X\130\194\130\206\130\186\130\232\130\160\130\162\131\130\129[\131h\n")
      elseif _ARG_0_:GetState() == "DarkCannon" and _ARG_0_.step == 3 then
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        _ARG_0_.step = 5
        print("\131_\129[\131N\131L\131\131\131m\131\147\130\194\130\206\130\186\130\232\130\160\130\162\131\130\129[\131h\n")
      end
    elseif _ARG_1_ == _UPVALUE5_ then
      _ARG_0_:GotoState("DarkSplicerDuel")
      print("\131_\129[\131N\131X\131v\131\137\131C\131T\129[\130\194\130\206\130\186\130\232\130\160\130\162\131\130\129[\131h\n")
    end
  end,
  OnReturnDamage = function(_ARG_0_)
    Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
    if _ARG_0_.airBattle then
      _ARG_0_:GotoState("Hovering")
    else
      _ARG_0_:GotoState("Idling")
    end
  end,
  OnEndReaction = function(_ARG_0_)
    if _ARG_0_.airBattle == false then
      Entity.EnableGravity(_ARG_0_.myHandle, 1)
    end
  end,
  OnDamageBefore = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    _ARG_0_.idlingTimer = 0
    if _ARG_0_:GetState() == "DarkSplicerDuel" then
      return 0
    end
    if Enemy.IsNoDamageReaction(_ARG_0_.myHandle) then
      return 0
    end
    if _ARG_2_ == COMMAND_CATEGORY_FINISH then
      return 0
    end
    if _ARG_0_:IsDuel() then
      return 0
    end
    if _ARG_0_.airBattle and Player.GetCommandKind(Player.GetHandle()) == COMMAND_KIND_DLink17 then
      return 0
    end
    _ARG_0_.dmgCount = _ARG_0_.dmgCount + 1
    if _ARG_1_ == ATK_KIND_DMG_SMALL or _ARG_1_ == ATK_KIND_DMG_BIG then
      if Script.Random() >= _UPVALUE0_ * _ARG_0_.dmgCount then
        return 0
      end
    elseif Script.Random() >= _UPVALUE1_ * _ARG_0_.dmgCount then
      return 0
    end
    _ARG_0_.dmgCount = 0
    _ARG_0_.warp = true
    if _ARG_0_.airBattle then
      _ARG_0_.stack:push("DarkSplicer2AirBattle")
    else
      _ARG_0_.stack:push("DarkSplicer2GroundBattle")
    end
    _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
    return 1
  end,
  OnDamage = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    if _ARG_0_:GetState() == "DarkSplicerDuel" and _ARG_0_.step == 3 then
      print("DarkSplicerDuel ... damage\n")
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetTimer(_ARG_0_.myHandle, Entity.GetMotionTotalFrame(_ARG_0_.myHandle) * 0.5)
      _ARG_0_.step = 7
    end
    Entity.EnableGravity(_ARG_0_.myHandle, 1)
    Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
    if _ARG_0_.airBattle and _ARG_1_ == ATK_KIND_KILL then
      Enemy.SetHP(_ARG_0_.myHandle, 0)
      SetupBossDead(_ARG_0_.myHandle)
      _ARG_0_:GotoState("Dead")
      return 1
    end
    return 0
  end,
  OnReflect = function(_ARG_0_)
    Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
    return 0
  end,
  OnDead = function(_ARG_0_)
    if _ARG_0_.airBattle == false then
      Enemy.SetFaceAnim(_ARG_0_.myHandle, 3, 2)
      Enemy.SetHP(_ARG_0_.myHandle, 1)
      Enemy.EnableInvincible(_ARG_0_.myHandle, 1)
      Enemy.EnableNoCalcDamage(_ARG_0_.myHandle, 1)
      _ARG_0_.attackCount = 0
      _ARG_0_:GotoState("DarkBreaker")
    else
      SetupBossDead(_ARG_0_.myHandle)
      _ARG_0_:GotoState("Dead")
    end
    return 1
  end,
  OnUpdate = function(_ARG_0_)
    if _ARG_0_.airBattle and Player.GetCommandKind(Player.GetHandle()) == COMMAND_KIND_DLink17 and _ARG_0_:GetState() ~= "Hovering" and _ARG_0_:GetState() ~= "Dead" then
      _ARG_0_:GotoState("Hovering")
    end
    _ARG_0_:Update()
    _ARG_0_:Debug()
    _ARG_0_:DarkBreakerCamera()
    if _ARG_0_.defenseTimer > 0 then
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
EntityFactory:Add("b11ex00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b11exHB", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b11exHXB", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b11exSWC", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("DCNLaser", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
