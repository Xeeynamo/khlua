setmetatable({
  new = function(_ARG_0_)
    return setmetatable(__StateMachine:new(), _UPVALUE0_)
  end,
  states = {
    Appear = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 3)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        Entity.SetTimer(_ARG_0_.myHandle, 10)
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if Enemy.IsAllEnemyWaiting() == false and Entity.IsTimeOver(_ARG_0_.myHandle) then
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
        _ARG_0_.defenseTimer = 0
        _ARG_0_.defenseFlag = false
        _ARG_0_.rotTimer = 0
        print("Idling\n")
      end,
      OnEndState = function(_ARG_0_)
        Enemy.SetFaceAnim(_ARG_0_.myHandle, 1, 0)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        Enemy.GetTargetLastRecordedPos(_UPVALUE0_, _ARG_0_.myHandle, _ARG_0_.targetHandle)
        Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
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
        if _ARG_0_:SearchTarget() == false then
          return
        end
        _ARG_0_.idlingTimer = _UPVALUE8_
        _ARG_0_:SelectedAttack()
      end
    },
    BackhandsSpringJump = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.step = 0
        print("BackhandsSpringJump\n")
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
    TargetWalk = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        print("TargetWalk\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE0_)
        if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= 4 or Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_.idlingTimer = 0
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
    Warp2 = {
      OnBeginState = function(_ARG_0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
        Entity.SetAlpha(_ARG_0_.myHandle, 0)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        SetCopyModelVanitus(_ARG_0_.myHandle)
        print("Warp2\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, 10)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:WarpToTargetBack()
          _ARG_0_:GotoState("WarpAttack2")
        end
      end
    },
    SuccessionAttack2 = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 1, 1)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        _ARG_0_.step = 0
        _ARG_0_.attackCount = _ARG_0_.attackCount + 1
        print("SuccessionAttack2\n")
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
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 1, 1)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 4 then
            Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
            Entity.GetRot(_UPVALUE2_, _ARG_0_.myHandle)
            _UPVALUE1_:sety(_UPVALUE1_:gety() + 1.75)
            SetBulletAttackParam(Bullet.CreateBullet("B63EXHSW", _UPVALUE1_, _UPVALUE2_), _ARG_0_.myHandle, _UPVALUE3_)
            if EntityManager:GetEntity((Bullet.CreateBullet("B63EXHSW", _UPVALUE1_, _UPVALUE2_))) ~= nil then
              EntityManager:GetEntity((Bullet.CreateBullet("B63EXHSW", _UPVALUE1_, _UPVALUE2_))).targetHandle = _ARG_0_.targetHandle
            end
            _ARG_0_.step = 3
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    WarpAttack2 = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 0, 1)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        _ARG_0_.step = 0
        print("WarpAttack2\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetAlpha(_ARG_0_.myHandle, 1)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 1 then
            Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 2)
            _UPVALUE1_:set(0, 0, 0)
            Entity.SetEffect(_ARG_0_.myHandle, _UPVALUE2_, "B016_WAP_APP0_0", _UPVALUE0_, _UPVALUE1_)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 10 then
            Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
            Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 18 then
          Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 18)
          Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
          SetBulletAttackParam(Bullet.CreateBullet("IceCrystal", _UPVALUE0_, _UPVALUE1_), _ARG_0_.myHandle, _UPVALUE3_)
          _ARG_0_.step = 3
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    ShadowDiving = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _UPVALUE1_:set(0, 0.2, 0)
        Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE1_)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        _ARG_0_.step = 0
        _ARG_0_.count = 0
        _ARG_0_.attackCount = 0
        print("ShadowDiving\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        Entity.EnableBgColl(_ARG_0_.myHandle, 1)
        Effect.LoopEnd(_ARG_0_.shadow)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        _ARG_0_.shadow = NULL_HANDLE
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.GetVelocity(_UPVALUE0_, _ARG_0_.myHandle)
          if 0 >= _UPVALUE0_:gety() then
            Entity.EnableGravity(_ARG_0_.myHandle, 0)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5) == false then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 15 then
            Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.targetHandle)
            Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.myHandle)
            FVECTOR3.Sub(_UPVALUE0_, _UPVALUE0_, _UPVALUE2_)
            _UPVALUE0_:sety(0)
            _UPVALUE0_:normalize()
            _UPVALUE0_:scale(_UPVALUE0_:length() / 20)
            Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE0_)
            _ARG_0_.flag = false
            _ARG_0_.step = 3
          end
        elseif _ARG_0_.step == 3 then
          if _ARG_0_.flag == false then
            Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
            _UPVALUE2_:copy(_UPVALUE0_)
            _UPVALUE2_:sety(_UPVALUE0_:gety() - 1.5)
            if Collision.IntersectRayBg(_UPVALUE0_, COLL_KIND_ENEMY, _UPVALUE0_, _UPVALUE2_) then
              _ARG_0_:CreateShadowDivingShockwave("B016_SDD_SHO0_0", 1, 4, _UPVALUE0_)
              _ARG_0_.flag = true
            end
          end
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE3_)
            Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
            _UPVALUE0_:set(0, 0, 0)
            _ARG_0_.shadow = Entity.AttachEffect(_ARG_0_.myHandle, _UPVALUE4_, "B016_SDD_SDW0_0", "Root", _UPVALUE0_, _UPVALUE0_)
            Effect.SetAttachNoRot(_ARG_0_.shadow, true)
            _ARG_0_.step = 4
          end
        elseif _ARG_0_.step == 4 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE5_)
          if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= 0.5625 or Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE6_, 0, -1, _UPVALUE7_[_ARG_0_.count + 1])
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Effect.LoopEnd(_ARG_0_.shadow)
            Effect.DetachCoord(_ARG_0_.shadow)
            Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
            _ARG_0_.shadow = NULL_HANDLE
            _ARG_0_.step = 5
          end
        elseif _ARG_0_.step == 5 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 4 then
            _ARG_0_.count = _ARG_0_.count + 1
            if _ARG_0_.count < _UPVALUE8_ then
              _ARG_0_:CreateShadowDivingShockwave("B016_SDD_SHO1_0", 1.5, 4)
            elseif EntityManager:GetEntity((_ARG_0_:CreateShadowDivingShockwave("B016_SDD_SHO2_0", 3, 4))) ~= nil then
              EntityManager:GetEntity((_ARG_0_:CreateShadowDivingShockwave("B016_SDD_SHO2_0", 3, 4))).splinter = true
            end
            _ARG_0_.step = 6
          end
        elseif _ARG_0_.step == 6 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            if _ARG_0_.count >= _UPVALUE8_ then
              Entity.EnableBgColl(_ARG_0_.myHandle, 1)
              Entity.EnableGravity(_ARG_0_.myHandle, 1)
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE9_)
              _ARG_0_.step = 7
            else
              _ARG_0_.step = 1
            end
          end
        elseif _ARG_0_.step == 7 then
          if Entity.IsGround(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE10_)
            _ARG_0_.step = 8
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    DarkThundaga = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.EnableGravity(_ARG_0_.myHandle, 0)
        Entity.SetRot(_ARG_0_.myHandle, 0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle), 0)
        _ARG_0_.velocity:set(0, 0, 0)
        _ARG_0_.step = 0
        _ARG_0_.attackCount = _ARG_0_.attackCount + 1
        _ARG_0_.oldAttackState = "DarkThundaga"
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
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
    GrandCross = {
      OnBeginState = function(_ARG_0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
        Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 5)
        Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 2)
        _UPVALUE1_:set(0, 0, 0)
        Entity.SetEffect(_ARG_0_.myHandle, _UPVALUE2_, "B028_GRX_WAP0_0", _UPVALUE0_, _UPVALUE1_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        _ARG_0_.step = 0
        _ARG_0_.holyFloodDmg = 0
        print("GrandCross\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        _ARG_0_.grandCrossTimer = Script.RandomInRange(_UPVALUE0_, _UPVALUE1_)
        _ARG_0_.holyFloodDmg = 0
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsModelFade(_ARG_0_.myHandle) == false then
            Entity.SetTimer(_ARG_0_.myHandle, 5)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _UPVALUE0_:set(0, 0, 0)
            Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE0_)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 2)
          _UPVALUE1_:set(0, 0, 0)
          Entity.SetEffect(_ARG_0_.myHandle, _UPVALUE2_, "B016_WAP_APP0_0", _UPVALUE0_, _UPVALUE1_)
          Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, 10)
          _ARG_0_.step = 3
        elseif _ARG_0_.step == 3 then
          if Entity.IsModelFade(_ARG_0_.myHandle) then
            Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
            Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
            Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE4_)
            Mission.SendMissonMessage(MES_START_WAIT_HOLY_FLOOD)
            _ARG_0_.step = 4
          end
        elseif _ARG_0_.step == 4 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_.holyFloodDmg = 0
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE5_)
            _ARG_0_.step = 5
          end
        elseif _ARG_0_.step == 5 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE6_)
            Entity.SetTimer(_ARG_0_.myHandle, 60)
            _ARG_0_.step = 6
          end
        elseif Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    UltimateCharge = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.EnableGravity(_ARG_0_.myHandle, 0)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        _ARG_0_.oldAttackState = "UltimateCharge"
        _ARG_0_.attackCount = _ARG_0_.attackCount + 1
        _ARG_0_.count = 0
        _ARG_0_.step = 0
        print("UltimateCharge\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.LoopEndEffectAttach(_ARG_0_.myHandle, 0)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
          Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.targetHandle)
          FVECTOR3.Sub(_UPVALUE1_, _UPVALUE1_, _UPVALUE0_)
          _UPVALUE1_:normalize()
          _UPVALUE1_:scale((_UPVALUE1_:length() + 3) / _UPVALUE2_)
          Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE1_)
          FVECTOR3.Mul(_UPVALUE3_, _UPVALUE1_, _UPVALUE1_)
          _UPVALUE0_:set(-Math.Atan2(_UPVALUE1_:gety(), Math.Sqrt(_UPVALUE3_:getx() + _UPVALUE3_:getz())), Math.Atan2(_UPVALUE1_:getx(), _UPVALUE1_:getz()), 0)
          Entity.SetRot(_ARG_0_.myHandle, _UPVALUE0_)
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE2_)
          _ARG_0_.step = 1
        elseif _ARG_0_.step == 1 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
            _UPVALUE0_:setx(0)
            Entity.SetRot(_ARG_0_.myHandle, _UPVALUE0_)
            _ARG_0_.count = _ARG_0_.count + 1
            if _ARG_0_.count < _UPVALUE4_ then
              _ARG_0_.step = 2
            else
              Entity.LoopEndEffectAttach(_ARG_0_.myHandle, 0)
              Entity.EnableGravity(_ARG_0_.myHandle, 1)
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE5_)
              _ARG_0_.step = 3
            end
          end
        elseif _ARG_0_.step == 2 then
          if Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 20) == false then
            _ARG_0_.step = 0
          end
        elseif _ARG_0_.step == 3 then
          if Entity.IsGround(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE6_)
            _ARG_0_.step = 4
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
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
  RestHpRate = function(_ARG_0_)
    return Enemy.GetHp(_ARG_0_.myHandle) / Enemy.GetHpMax(_ARG_0_.myHandle)
  end,
  CheckTargetPos = function(_ARG_0_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
    Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.targetHandle)
    FVECTOR3.Sub(_UPVALUE2_, _UPVALUE1_, _UPVALUE0_)
    _UPVALUE2_:normalize()
    _UPVALUE3_:set(0, 0, 1)
    Entity.ApplyBoneMatrix33(_ARG_0_.myHandle, "Root", _UPVALUE3_)
    if _UPVALUE3_:dot(_UPVALUE2_) >= Math.Cos(DegToRad(15)) then
      return _UPVALUE4_
    end
    _UPVALUE3_:set(-1, 0, 0)
    Entity.ApplyBoneMatrix33(_ARG_0_.myHandle, "Root", _UPVALUE3_)
    if 0 <= _UPVALUE3_:dot(_UPVALUE2_) then
      return _UPVALUE5_
    end
    return _UPVALUE6_
  end,
  SearchTarget = function(_ARG_0_)
    if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) then
      return true
    end
    return false
  end,
  SelectedAttack = function(_ARG_0_)
    if _ARG_0_.grandCrossTimer <= 0 then
      _ARG_0_.stack:push("Idling")
      _ARG_0_.stack:push("GrandCross")
      _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      return
    end
    if _ARG_0_.attackCount < _UPVALUE0_ then
      _ARG_0_.stack:push("Idling")
      if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE1_ then
        if Script.Random() < 0.33 then
          _ARG_0_.stack:push("BackhandsSpringJump")
        end
        _ARG_0_.stack:push("SuccessionAttack2")
      else
        if Script.Random() < 0.33 then
          _ARG_0_.stack:push("TargetWalk")
        end
        if Script.Random() < 0.7 then
          if _ARG_0_.oldAttackState == "UltimateCharge" then
            _ARG_0_.stack:push("DarkThundaga")
          else
            _ARG_0_.stack:push("UltimateCharge")
          end
        elseif _ARG_0_.oldAttackState == "DarkThundaga" then
          _ARG_0_.stack:push("UltimateCharge")
        else
          _ARG_0_.stack:push("DarkThundaga")
        end
      end
    else
      _ARG_0_.stack:push("ShadowDiving")
    end
    _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
  end,
  WarpToTargetBack = function(_ARG_0_)
    Entity.GetDir(_UPVALUE0_, _ARG_0_.targetHandle)
    _UPVALUE0_:scale(-0.5)
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
    Entity.Warp(_ARG_0_.myHandle, _UPVALUE0_)
    FVECTOR3.Sub(_UPVALUE0_, _UPVALUE1_, _UPVALUE0_)
    Entity.SetRot(_ARG_0_.myHandle, 0, Math.Atan2(_UPVALUE0_:getx(), _UPVALUE0_:getz()), 0)
  end,
  CreateShadowDivingShockwave = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
    if _ARG_4_ == nil then
      Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
      _UPVALUE1_:copy(_UPVALUE0_)
      _UPVALUE0_:sety(_UPVALUE0_:gety() + 5)
      _UPVALUE1_:sety(_UPVALUE1_:gety() - 20)
      Collision.IntersectRayBg(_UPVALUE0_, COLL_KIND_ENEMY, _UPVALUE0_, _UPVALUE1_)
    else
      _UPVALUE0_:copy(_ARG_4_)
    end
    _UPVALUE1_:set(0, 0, 0)
    Bullet.SetCollision(Bullet.CreateBullet("B63EXSDSW", _UPVALUE0_, _UPVALUE1_), COLL_KIND_ENEMY, COLL_SHAPE_CYLINDER, _ARG_2_, _ARG_3_, (Bullet.CreateBullet("B63EXSDSW", _UPVALUE0_, _UPVALUE1_)))
    Bullet.CreateEffectBullet(Bullet.CreateBullet("B63EXSDSW", _UPVALUE0_, _UPVALUE1_), _UPVALUE2_, _ARG_1_)
    SetBulletAttackParam(Bullet.CreateBullet("B63EXSDSW", _UPVALUE0_, _UPVALUE1_), _ARG_0_.myHandle, _UPVALUE3_)
    return (Bullet.CreateBullet("B63EXSDSW", _UPVALUE0_, _UPVALUE1_))
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    _UPVALUE0_ = Entity.GetMotionIndex(_ARG_1_, "010")
    _UPVALUE1_ = Entity.GetMotionIndex(_ARG_1_, "030")
    _UPVALUE2_ = Entity.GetMotionIndex(_ARG_1_, "050")
    _UPVALUE3_ = Entity.GetMotionIndex(_ARG_1_, "051")
    _UPVALUE4_ = Entity.GetMotionIndex(_ARG_1_, "052")
    _UPVALUE5_ = Entity.GetMotionIndex(_ARG_1_, "053")
    _UPVALUE6_ = Entity.GetMotionIndex(_ARG_1_, "054")
    _UPVALUE7_ = Entity.GetMotionIndex(_ARG_1_, "061")
    _UPVALUE8_ = Entity.GetMotionIndex(_ARG_1_, "062")
    _UPVALUE9_ = Entity.GetMotionIndex(_ARG_1_, "300")
    _UPVALUE10_ = Entity.GetMotionIndex(_ARG_1_, "301")
    _UPVALUE11_ = Entity.GetMotionIndex(_ARG_1_, "302")
    _UPVALUE12_ = Entity.GetMotionIndex(_ARG_1_, "303")
    _UPVALUE13_ = Entity.GetMotionIndex(_ARG_1_, "304")
    _UPVALUE14_ = Entity.GetMotionIndex(_ARG_1_, "305")
    _UPVALUE15_ = Entity.GetMotionIndex(_ARG_1_, "306")
    _UPVALUE16_ = Entity.GetMotionIndex(_ARG_1_, "307")
    _UPVALUE17_ = Entity.GetMotionIndex(_ARG_1_, "308")
    _UPVALUE18_ = Enemy.GetExtraParam(_ARG_1_, "HF_DAMAGE")
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.targetHandle = NULL_HANDLE
    _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
    _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
    _ARG_0_.warpPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.step = 0
    _ARG_0_.step2 = 0
    _ARG_0_.count = 0
    _ARG_0_.oldAttackState = ""
    _ARG_0_.shadow = NULL_HANDLE
    _ARG_0_.idlingTimer = _UPVALUE19_
    _ARG_0_.grandCrossTimer = Script.RandomInRange(_UPVALUE20_, _UPVALUE21_)
    _ARG_0_.dmgCount = 0
    _ARG_0_.attackCount = 0
    _ARG_0_.defenseTimer = 0
    _ARG_0_.defenseFlag = false
    _ARG_0_.rotTimer = 0
    _ARG_0_.holyFloodDmg = 0
    _ARG_0_.flag = false
    _ARG_0_.stack = Stack:Create()
    Entity.EnableGravity(_ARG_1_, 1)
    Enemy.SetViewDist(_ARG_1_, 50)
    Player.SetBossCamera("b63ex")
    _ARG_0_:GotoState("Appear")
  end,
  OnSetMotion = function(_ARG_0_, _ARG_1_)
  end,
  OnReturnDamage = function(_ARG_0_)
    if _ARG_0_:GetState() == "Warp2" or _ARG_0_:GetState() == "Warp2Attack" then
      return
    end
    Entity.SetRot(_ARG_0_.myHandle, 0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle), 0)
    _ARG_0_.dmgCount = 0
    _ARG_0_:GotoState("Idling")
  end,
  OnEndReaction = function(_ARG_0_)
    Entity.EnableGravity(_ARG_0_.myHandle, 1)
  end,
  OnHitAttack = function(_ARG_0_)
  end,
  OnDamageBefore = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    _ARG_0_.idlingTimer = 0
    if Entity.GetDamageCommandKind(_ARG_0_.myHandle) == COMMAND_KIND_HolyFlood then
      return 0
    end
    if Enemy.IsNoDamageReaction(_ARG_0_.myHandle) then
      return 0
    end
    _ARG_0_.dmgCount = _ARG_0_.dmgCount + 1
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE0_ then
      if Script.Random() < 0.15 then
        _ARG_0_.stack:push("Idling")
        _ARG_0_:GotoState("Cartwheel")
        return 1
      elseif Script.Random() < _ARG_0_.dmgCount * _UPVALUE1_ then
        _ARG_0_.dmgCount = 0
        _ARG_0_.stack:push("Idling")
        _ARG_0_:GotoState("Warp2")
        return 1
      end
    elseif Script.Random() < 0.33 then
      _ARG_0_.stack:push("Idling")
      _ARG_0_:GotoState("Cartwheel")
      return 1
    end
    return 0
  end,
  OnDamage = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    if Entity.GetDamageCommandKind(_ARG_0_.myHandle) == COMMAND_KIND_HolyFlood then
      _ARG_0_.holyFloodDmg = _ARG_0_.holyFloodDmg + Entity.GetDamagePoint(_ARG_0_.myHandle)
    end
    if _ARG_0_.holyFloodDmg >= _UPVALUE0_ then
      _ARG_0_.holyFloodDmg = 0
      Entity.SetDamageKind(_ARG_0_.myHandle, ATK_KIND_DMG_BLOW)
    end
    return 0
  end,
  OnReflect = function(_ARG_0_)
    Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
    Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
    Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
    Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
    Entity.EnableGravity(_ARG_0_.myHandle, 1)
    Entity.EnableBgColl(_ARG_0_.myHandle, 1)
    return 0
  end,
  OnDead = function(_ARG_0_)
    SetupBossDead(_ARG_0_.myHandle)
    _ARG_0_:GotoState("Dead")
    return 1
  end,
  OnUpdate = function(_ARG_0_)
    _ARG_0_:Update()
    _ARG_0_:Debug()
    if _ARG_0_.grandCrossTimer > 0 then
      _ARG_0_.grandCrossTimer = _ARG_0_.grandCrossTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
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
EntityFactory:Add("b63ex00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("B63EXHSW", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("B63EXSDSW", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("B63EXSDS", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("IceCrystal", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
