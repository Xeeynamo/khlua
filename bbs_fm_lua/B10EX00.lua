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
        if Enemy.SearchEnemy(_ARG_0_.myHandle, "b40ex00", SEARCH_TYPE_NEAR) then
          _ARG_0_.xehanort = true
        end
      end,
      OnUpdate = function(_ARG_0_)
        if Enemy.IsAllEnemyWaiting() == false then
          if _ARG_0_.type == 3 then
            _ARG_0_:GotoState("RideWaiting")
          else
            _ARG_0_:GotoState("Idling")
          end
        end
      end
    },
    Idling = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_.idlingTimer)
        _ARG_0_.stack:clear()
        _ARG_0_.defenseTimer = 0
        _ARG_0_.defenseFlag = false
        _ARG_0_.rotTimer = 0
        _ARG_0_.attackPermission = false
      end,
      OnEndState = function(_ARG_0_)
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
        if _ARG_0_:Defense() then
          return
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
          return
        end
        if _ARG_0_:SearchTarget() == false then
          return
        end
        if _ARG_0_.darkMode == false then
          _ARG_0_.idlingTimer = _UPVALUE6_
        else
          _ARG_0_.idlingTimer = _UPVALUE6_ * 0.5
        end
        _ARG_0_:SelectedAttack()
      end
    },
    RideMode = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 0, -2)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        Enemy.SendMessage(0, _ARG_0_.myHandle, _ARG_0_.keybladeHandle[1], _UPVALUE2_)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        if _ARG_0_.attackCount >= _UPVALUE0_ then
          Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
          _UPVALUE1_:sety(0)
          if _UPVALUE1_:dot(_UPVALUE1_) <= 100 then
            _ARG_0_:EndRideMode()
            _ARG_0_.stack:push("StyleChange")
            _ARG_0_:GotoState("BackhandsSpringJump")
          end
          return
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
          return
        end
        if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) then
          return
        end
        if Script.Random() < 0.7 then
          _ARG_0_:GotoState("KeyBladeDarkBlizzaga")
        else
          _ARG_0_:GotoState("KeyBladeRush")
        end
      end
    },
    RideWaiting = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        _ARG_0_:CreateKeyBlade()
        _ARG_0_.attackCount = 0
        Enemy.SendMessage(0, _ARG_0_.myHandle, _ARG_0_.keybladeHandle[1], _UPVALUE1_)
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.keybladeHandle[1], 5)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE0_)
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.keybladeHandle[1]) <= 25 then
          Enemy.SendMessage(0, _ARG_0_.myHandle, _ARG_0_.keybladeHandle[1], _UPVALUE1_)
          _ARG_0_:GotoState("RideKeyBlade")
        end
      end
    },
    CheckDarkModeAttackCount = {
      OnBeginState = function(_ARG_0_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.attackCount >= _UPVALUE0_ then
          _ARG_0_:GotoState("ShadowDiving")
        else
          _ARG_0_:GotoState("Idling")
        end
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
    TargetMove = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
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
    StyleChange = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("ShadowDiving")
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
    RideKeyBlade = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _UPVALUE1_:set(0, 0.3, 0)
        Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE1_)
        _ARG_0_.step = 0
        _ARG_0_.step2 = 0
      end,
      OnEndState = function(_ARG_0_)
        _ARG_0_.rideMode = true
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
          Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.keybladeHandle[1])
          Entity.GetVelocity(_UPVALUE2_, _ARG_0_.myHandle)
          Entity.GetVelocity(_UPVALUE3_, _ARG_0_.keybladeHandle[1])
          _UPVALUE3_:scale(5)
          FVECTOR3.Add(_UPVALUE4_, _UPVALUE1_, _UPVALUE3_)
          FVECTOR3.Sub(_UPVALUE5_, _UPVALUE4_, _UPVALUE0_)
          if _ARG_0_.step2 == 0 then
            if 0 > _UPVALUE2_:gety() then
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE6_)
              _ARG_0_.step2 = 1
            end
          else
            Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE4_, 5)
            if _UPVALUE5_:gety() >= -0.25 then
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE7_)
              Entity.ClearSpeed(_ARG_0_.myHandle)
              Entity.AttachCoord(_ARG_0_.keybladeHandle[1], "center", _ARG_0_.myHandle, "Root")
              _UPVALUE5_:set(0, 0, 0.25)
              Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE5_)
              Entity.SetOldLocalPos(_ARG_0_.myHandle, _UPVALUE5_)
              _UPVALUE5_:set(0, 0, 0)
              Entity.SetRot(_ARG_0_.myHandle, _UPVALUE5_)
              Entity.EnableGravity(_ARG_0_.myHandle, 0)
              Entity.EnableBgColl(_ARG_0_.myHandle, 0)
              Entity.EnableCrdsSysFix(_ARG_0_.myHandle, 1)
              _ARG_0_.step = 1
              return
            end
          end
          _UPVALUE5_:sety(0)
          if 0 < _UPVALUE5_:length() then
            _UPVALUE5_:scale(_UPVALUE8_ / _UPVALUE5_:length())
            _UPVALUE2_:setx(_UPVALUE5_:getx())
            _UPVALUE2_:setz(_UPVALUE5_:getz())
            Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE2_)
          else
            _UPVALUE2_:setx(0)
            _UPVALUE2_:setz(0)
            Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE2_)
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("RideMode")
        end
      end
    },
    Warp1 = {
      OnBeginState = function(_ARG_0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
        Entity.SetAlpha(_ARG_0_.myHandle, 0)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        SetCopyModelVanitus(_ARG_0_.myHandle)
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, 10)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:WarpToTargetBack()
          _ARG_0_:GotoState("WarpAttack1")
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
    SuccessionAttack1 = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 0, 0)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        _ARG_0_.step = 0
        _ARG_0_.attackCount = _ARG_0_.attackCount + 1
      end,
      OnEndState = function(_ARG_0_)
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
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 0, 0)
            _ARG_0_.step = 2
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    SuccessionAttack2 = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 1, 1)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        _ARG_0_.step = 0
        _ARG_0_.attackCount = _ARG_0_.attackCount + 1
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
            SetBulletAttackParam(Bullet.CreateBullet("b10exHSW", _UPVALUE1_, _UPVALUE2_), _ARG_0_.myHandle, _UPVALUE3_)
            if EntityManager:GetEntity((Bullet.CreateBullet("b10exHSW", _UPVALUE1_, _UPVALUE2_))) ~= nil then
              EntityManager:GetEntity((Bullet.CreateBullet("b10exHSW", _UPVALUE1_, _UPVALUE2_))).targetHandle = _ARG_0_.targetHandle
            end
            _ARG_0_.step = 3
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    WarpAttack1 = {
      OnBeginState = function(_ARG_0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
        Entity.SetAlpha(_ARG_0_.myHandle, 0)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        SetCopyModelVanitus(_ARG_0_.myHandle)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
        Entity.SetAlpha(_ARG_0_.myHandle, 1)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:WarpToTargetBack()
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 0, 0)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if 1 <= Entity.GetMotionNowFrame(_ARG_0_.myHandle) then
            Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle, 2)
            _UPVALUE2_:set(0, 0, 0)
            Entity.SetEffect(_ARG_0_.myHandle, _UPVALUE3_, "B016_WAP_APP0_0", _UPVALUE1_, _UPVALUE2_)
            Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, 10)
            Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 10 then
            Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
            Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
            _ARG_0_.step = 3
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    WarpAttack2 = {
      OnBeginState = function(_ARG_0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
        Entity.SetAlpha(_ARG_0_.myHandle, 0)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        SetCopyModelVanitus(_ARG_0_.myHandle)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
        Entity.SetAlpha(_ARG_0_.myHandle, 1)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:WarpToTargetBack()
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 0, 1)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if 1 <= Entity.GetMotionNowFrame(_ARG_0_.myHandle) then
            Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle, 2)
            _UPVALUE2_:set(0, 0, 0)
            Entity.SetEffect(_ARG_0_.myHandle, _UPVALUE3_, "B016_WAP_APP0_0", _UPVALUE1_, _UPVALUE2_)
            Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, 10)
            Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 10 then
            Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
            Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
            _ARG_0_.step = 3
          end
        elseif _ARG_0_.step == 3 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 18 then
            Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle, 18)
            Entity.GetRot(_UPVALUE2_, _ARG_0_.myHandle)
            SetBulletAttackParam(Bullet.CreateBullet("IceCrystal", _UPVALUE1_, _UPVALUE2_), _ARG_0_.myHandle, _UPVALUE4_)
            _ARG_0_.step = 4
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    ShadowDiving = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _UPVALUE1_:set(0, 0.2, 0)
        Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE1_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        _ARG_0_.step = 0
        _ARG_0_.count = Script.RandomInteger(_UPVALUE2_) + 1
        _ARG_0_.attackCount = 0
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
          _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE5_)
          if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= 0.5625 or Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE6_, 0, -1, _UPVALUE7_[_ARG_0_.count])
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Effect.LoopEnd(_ARG_0_.shadow)
            Effect.DetachCoord(_ARG_0_.shadow)
            Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
            _ARG_0_.shadow = NULL_HANDLE
            _ARG_0_.step = 5
          end
        elseif _ARG_0_.step == 5 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 4 then
            _ARG_0_.count = _ARG_0_.count - 1
            if 0 < _ARG_0_.count then
              _ARG_0_:CreateShadowDivingShockwave("B016_SDD_SHO1_0", 1.5, 4)
            elseif EntityManager:GetEntity((_ARG_0_:CreateShadowDivingShockwave("B016_SDD_SHO2_0", 3, 4))) ~= nil then
              EntityManager:GetEntity((_ARG_0_:CreateShadowDivingShockwave("B016_SDD_SHO2_0", 3, 4))).splinter = true
            end
            _ARG_0_.step = 6
          end
        elseif _ARG_0_.step == 6 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            if 0 >= _ARG_0_.count then
              Entity.EnableBgColl(_ARG_0_.myHandle, 1)
              Entity.EnableGravity(_ARG_0_.myHandle, 1)
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE8_)
              _ARG_0_.step = 7
            else
              _ARG_0_.step = 1
            end
          end
        elseif _ARG_0_.step == 7 then
          if Entity.IsGround(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE9_)
            _ARG_0_.step = 8
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.shadowDivingCount = _ARG_0_.shadowDivingCount + 1
          if _ARG_0_.type == 2 then
            if _ARG_0_.shadowDivingCount >= _UPVALUE10_ then
              _ARG_0_:EndDarkMode()
            end
          elseif _ARG_0_.type == 3 and _ARG_0_.shadowDivingCount >= _UPVALUE10_ then
            _ARG_0_:StartRideMode()
            return
          end
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    DarkFiraga = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        _ARG_0_.step = 0
        _ARG_0_.attackCount = _ARG_0_.attackCount + 1
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 21 then
            Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 18)
            Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
            SetBulletAttackParam(Bullet.CreateBullet("DarkFiragaL", _UPVALUE0_, _UPVALUE1_), _ARG_0_.myHandle, _UPVALUE2_)
            if EntityManager:GetEntity((Bullet.CreateBullet("DarkFiragaL", _UPVALUE0_, _UPVALUE1_))) ~= nil then
              EntityManager:GetEntity((Bullet.CreateBullet("DarkFiragaL", _UPVALUE0_, _UPVALUE1_))).targetHandle = _ARG_0_.targetHandle
            end
            _ARG_0_.step = 1
          end
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
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
        _ARG_0_.attackCount = _ARG_0_.attackCount + 1
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
    KeyBladeRush = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 0, 0)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        Enemy.SendMessage(0, _ARG_0_.myHandle, _ARG_0_.keybladeHandle[1], _UPVALUE2_)
        _ARG_0_.attackCount = _ARG_0_.attackCount + 1
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("RideMode")
        end
      end
    },
    KeyBladeDarkBlizzaga = {
      OnBeginState = function(_ARG_0_)
        Entity.SetTimer(_ARG_0_.myHandle, 0)
        Enemy.SendMessage(0, _ARG_0_.myHandle, _ARG_0_.keybladeHandle[1], _UPVALUE0_)
        _ARG_0_.step = 0
        _ARG_0_.timer = Script.RandomInRange(_UPVALUE1_, _UPVALUE1_ * 2)
        _ARG_0_.attackCount = _ARG_0_.attackCount + 1
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.step == 0 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 14 then
            _ARG_0_:CreateDarkBlizzaga(DegToRad(45))
            _ARG_0_:CreateDarkBlizzaga(0)
            _ARG_0_:CreateDarkBlizzaga(DegToRad(-45))
            _ARG_0_.step = 2
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          if _ARG_0_.timer <= 0 or _ARG_0_:CheckTargetPos() == _UPVALUE1_ then
            _ARG_0_:GotoState("RideMode")
          else
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_, 0, -2)
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE3_)
            _ARG_0_.step = 0
          end
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
        if _ARG_0_.step == 0 and Sound.IsInvalidateSeCall() == 1 then
          Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 2)
          Sound.PlayVoice(104, 31, 1, _UPVALUE0_, SE_OPT_ALWAYS)
          _ARG_0_.step = 1
        end
      end
    }
  },
  RestHpRate = function(_ARG_0_)
    return Enemy.GetHp(_ARG_0_.myHandle) / Enemy.GetHpMax(_ARG_0_.myHandle)
  end,
  IsWarp = function(_ARG_0_)
    return _ARG_0_.warpFlag
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
    if Enemy.SearchEnemy(_ARG_0_.myHandle, "b40ex00", SEARCH_TYPE_NEAR) ~= NULL_HANDLE and _ARG_0_.attackPermission == false then
      return false
    end
    if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) then
      return true
    end
    return false
  end,
  StartDarkMode = function(_ARG_0_)
    _ARG_0_.shadowDivingCount = 0
    _ARG_0_.darkMode = true
    _ARG_0_:GotoState("StyleChange")
  end,
  EndDarkMode = function(_ARG_0_)
    _ARG_0_.darkMode = false
    _ARG_0_.darkModeCount = 0
    Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
  end,
  StartRideMode = function(_ARG_0_)
    _ARG_0_:EndDarkMode()
    _ARG_0_.accDmg = 0
    _ARG_0_:GotoState("RideWaiting")
  end,
  EndRideMode = function(_ARG_0_)
    _ARG_0_.shadowDivingCount = 0
    _ARG_0_.rideMode = false
    _ARG_0_.darkMode = true
    Entity.AttachCoord(NULL_HANDLE, "Root", _ARG_0_.myHandle, "Root")
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
    Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE0_)
    Entity.SetOldLocalPos(_ARG_0_.myHandle, _UPVALUE0_)
    Entity.EnableCrdsSysFix(_ARG_0_.myHandle, 0)
    Entity.EnableGravity(_ARG_0_.myHandle, 1)
    Entity.EnableBgColl(_ARG_0_.myHandle, 1)
    for _FORV_4_, _FORV_5_ in pairs(_ARG_0_.keybladeHandle) do
      Enemy.SendMessage(0, _ARG_0_.myHandle, _FORV_5_, _UPVALUE1_)
    end
  end,
  SelectedAttack = function(_ARG_0_)
    if _ARG_0_.type == 1 then
      _ARG_0_:SelectedAttackForNormalMode()
    elseif _ARG_0_.type == 2 then
      if _ARG_0_.darkMode == false then
        _ARG_0_:SelectedAttackForNormalMode()
      else
        _ARG_0_:SelectedAttackForDarkMode()
      end
    elseif _ARG_0_.darkMode == false then
      _ARG_0_:GotoState("RideWaiting")
      return
    else
      _ARG_0_:SelectedAttackForDarkMode()
    end
    _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
  end,
  SelectedAttackForNormalMode = function(_ARG_0_)
    _ARG_0_.stack:push("Idling")
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE0_ then
      if Script.Random() >= 0.66 then
        _ARG_0_.stack:push("BackhandsSpringJump")
      end
      _ARG_0_.stack:push("SuccessionAttack1")
    else
      if Script.Random() < 0.33 then
        _ARG_0_.stack:push("TargetMove")
      end
      if Script.Random() > 0.5 then
        _ARG_0_.stack:push("DarkFiraga")
      else
        _ARG_0_.stack:push("DarkThundaga")
      end
    end
  end,
  SelectedAttackForDarkMode = function(_ARG_0_)
    _ARG_0_.stack:push("CheckDarkModeAttackCount")
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE0_ then
      if Script.Random() >= 0.66 then
        _ARG_0_.stack:push("BackhandsSpringJump")
      end
      _ARG_0_.stack:push("SuccessionAttack2")
    else
      if Script.Random() < 0.33 then
        _ARG_0_.stack:push("TargetMove")
      end
      if Script.Random() > 0.5 then
        _ARG_0_.stack:push("DarkFiraga")
      else
        _ARG_0_.stack:push("DarkThundaga")
      end
    end
  end,
  WarpToTargetBack = function(_ARG_0_)
    Entity.GetDir(_UPVALUE0_, _ARG_0_.targetHandle)
    _UPVALUE0_:scale(-0.5)
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
    Entity.Warp(_ARG_0_.myHandle, _UPVALUE0_)
    Entity.SetOldLocalPos(_ARG_0_.myHandle, _UPVALUE1_)
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
    Bullet.SetCollision(Bullet.CreateBullet("b10exSDSW", _UPVALUE0_, _UPVALUE1_), COLL_KIND_ENEMY, COLL_SHAPE_CYLINDER, _ARG_2_, _ARG_3_, (Bullet.CreateBullet("b10exSDSW", _UPVALUE0_, _UPVALUE1_)))
    Bullet.CreateEffectBullet(Bullet.CreateBullet("b10exSDSW", _UPVALUE0_, _UPVALUE1_), _UPVALUE2_, _ARG_1_)
    SetBulletAttackParam(Bullet.CreateBullet("b10exSDSW", _UPVALUE0_, _UPVALUE1_), _ARG_0_.myHandle, _UPVALUE3_)
    return (Bullet.CreateBullet("b10exSDSW", _UPVALUE0_, _UPVALUE1_))
  end,
  CreateDarkBlizzaga = function(_ARG_0_, _ARG_1_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 18)
    Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
    _UPVALUE1_:sety(RoundPI(_UPVALUE1_:gety() + _ARG_1_))
    SetBulletAttackParam(Bullet.CreateBullet("DarkBlizzaga", _UPVALUE0_, _UPVALUE1_), _ARG_0_.myHandle, _UPVALUE2_)
    if EntityManager:GetEntity((Bullet.CreateBullet("DarkBlizzaga", _UPVALUE0_, _UPVALUE1_))) ~= nil then
      EntityManager:GetEntity((Bullet.CreateBullet("DarkBlizzaga", _UPVALUE0_, _UPVALUE1_))).targetHandle = _ARG_0_.targetHandle
    end
    return (Bullet.CreateBullet("DarkBlizzaga", _UPVALUE0_, _UPVALUE1_))
  end,
  CreateKeyBlade = function(_ARG_0_)
    _UPVALUE0_:set(40, 5, 50)
    _UPVALUE1_:set(0, 0, 0)
    _ARG_0_.keybladeHandle[1] = Entity.CreateEntity(_UPVALUE2_[Script.RandomInteger(#_UPVALUE2_) + 1], _UPVALUE0_, _UPVALUE1_)
    for _FORV_4_ = 2, _UPVALUE3_ do
      _ARG_0_.keybladeHandle[_FORV_4_] = Entity.CreateEntity(_UPVALUE2_[Script.RandomInteger(#_UPVALUE2_) + 1], _UPVALUE0_, _UPVALUE1_, _ARG_0_.keybladeHandle[_FORV_4_ - 1])
    end
  end,
  Defense = function(_ARG_0_)
    if _ARG_0_.xehanort and _ARG_0_.myHandle ~= Player.IsNowTarget(_ARG_0_.targetHandle) then
      return false
    end
    if _ARG_0_.defenseTimer <= 0 then
      if _ARG_0_.defenseFlag == false then
        if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) and Entity.IsAttacking(_ARG_0_.targetHandle) then
          _ARG_0_.defenseFlag = true
          _ARG_0_.defenseTimer = _UPVALUE0_
        end
      else
        _ARG_0_.idlingTimer = 0
        _ARG_0_.stack:push("Idling")
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE1_ then
          if Script.Random() < 0.5 then
            _ARG_0_:GotoState("BackhandsSpringJump")
          else
            _ARG_0_:GotoState("Cartwheel")
          end
        else
          _ARG_0_:GotoState("Cartwheel")
        end
        return true
      end
    end
    return false
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    _UPVALUE0_ = Entity.GetMotionIndex(_ARG_1_, "010")
    _UPVALUE1_ = Entity.GetMotionIndex(_ARG_1_, "020")
    _UPVALUE2_ = Entity.GetMotionIndex(_ARG_1_, "040")
    _UPVALUE3_ = Entity.GetMotionIndex(_ARG_1_, "050")
    _UPVALUE4_ = Entity.GetMotionIndex(_ARG_1_, "051")
    _UPVALUE5_ = Entity.GetMotionIndex(_ARG_1_, "052")
    _UPVALUE6_ = Entity.GetMotionIndex(_ARG_1_, "053")
    _UPVALUE7_ = Entity.GetMotionIndex(_ARG_1_, "054")
    _UPVALUE8_ = Entity.GetMotionIndex(_ARG_1_, "055")
    _UPVALUE9_ = Entity.GetMotionIndex(_ARG_1_, "056")
    _UPVALUE10_ = Entity.GetMotionIndex(_ARG_1_, "061")
    _UPVALUE11_ = Entity.GetMotionIndex(_ARG_1_, "062")
    _UPVALUE12_ = Entity.GetMotionIndex(_ARG_1_, "300")
    _UPVALUE13_ = Entity.GetMotionIndex(_ARG_1_, "301")
    _UPVALUE14_ = Entity.GetMotionIndex(_ARG_1_, "302")
    _UPVALUE15_ = Entity.GetMotionIndex(_ARG_1_, "303")
    _UPVALUE16_ = Entity.GetMotionIndex(_ARG_1_, "304")
    _UPVALUE17_ = Entity.GetMotionIndex(_ARG_1_, "305")
    _UPVALUE18_ = Entity.GetMotionIndex(_ARG_1_, "306")
    _UPVALUE19_ = Entity.GetMotionIndex(_ARG_1_, "307")
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
    _ARG_0_.shadow = NULL_HANDLE
    _ARG_0_.idlingTimer = _UPVALUE20_
    _ARG_0_.dmgCount = 0
    _ARG_0_.shadowDivingCount = 0
    _ARG_0_.darkModeCount = 0
    _ARG_0_.attackCount = 0
    _ARG_0_.defenseTimer = 0
    _ARG_0_.defenseFlag = false
    _ARG_0_.darkMode = false
    _ARG_0_.rideMode = false
    _ARG_0_.accDmg = 0
    _ARG_0_.flag = false
    _ARG_0_.warpFlag = false
    _ARG_0_.rotTimer = 0
    _ARG_0_.timer = 0
    _ARG_0_.attackPermission = true
    _ARG_0_.xehanort = false
    _ARG_0_.stack = Stack:Create()
    Enemy.SetViewDist(_ARG_1_, 125)
    Entity.EnableGravity(_ARG_1_, 1)
    if Entity.GetName(_ARG_1_) == "b10ex00" then
      _ARG_0_.type = 1
    elseif Entity.GetName(_ARG_1_) == "b10ex01" then
      _ARG_0_.type = 2
    else
      _ARG_0_.type = 3
      _ARG_0_.keybladeHandle = {}
      for _FORV_6_ = 1, _UPVALUE21_ do
        _ARG_0_.keybladeHandle[_FORV_6_] = NULL_HANDLE
      end
    end
    _FOR_.SetBossCamera("b10ex")
    _ARG_0_:GotoState("Appear")
  end,
  OnReturnDamage = function(_ARG_0_)
    if _ARG_0_:GetState() == "RideMode" or _ARG_0_:GetState() == "KeyBladeRush" or _ARG_0_:GetState() == "KeyBladeDarkBlizzaga" then
      _ARG_0_:GotoState("StyleChange")
      return
    end
    _ARG_0_:GotoState("Idling")
  end,
  OnEndReaction = function(_ARG_0_)
    if _ARG_0_.rideMode == false then
      Entity.EnableGravity(_ARG_0_.myHandle, 1)
    end
  end,
  OnHitAttack = function(_ARG_0_)
  end,
  OnDamageBefore = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    _ARG_0_.idlingTimer = 0
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
        _ARG_0_:GotoState(_UPVALUE2_[_ARG_0_.type])
        return 1
      end
    elseif Script.Random() < 0.33 then
      _ARG_0_.stack:push("Idling")
      _ARG_0_:GotoState("Cartwheel")
      return 1
    elseif Script.Random() < _ARG_0_.dmgCount * _UPVALUE1_ then
      _ARG_0_.dmgCount = 0
      _ARG_0_.stack:push("Idling")
      _ARG_0_:GotoState(_UPVALUE2_[_ARG_0_.type])
      return 1
    end
    return 0
  end,
  OnDamage = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    if _ARG_0_.type >= 2 and _ARG_0_.darkMode == false then
      if _ARG_0_.type == 2 then
        _ARG_0_.darkModeCount = _ARG_0_.darkModeCount + 1
        if _ARG_0_.darkModeCount >= _UPVALUE0_ then
          _ARG_0_:StartDarkMode()
          return 1
        end
      elseif _ARG_0_.rideMode then
        _ARG_0_.accDmg = _ARG_0_.accDmg + Entity.GetDamagePoint(_ARG_0_.myHandle)
        if _ARG_0_.accDmg >= _UPVALUE1_ then
          Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.myHandle)
          _UPVALUE2_:sety(0)
          if _UPVALUE2_:dot(_UPVALUE2_) <= 100 then
            _ARG_0_:EndRideMode()
            Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
            Entity.SetDamageKind(_ARG_0_.myHandle, ATK_KIND_DMG_BLOW)
          end
        end
      end
    end
    return 0
  end,
  OnReflect = function(_ARG_0_)
    if Entity.IsAttachCoord(_ARG_0_.myHandle) then
      return 1
    end
    Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
    Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
    Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
    Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
    Entity.EnableGravity(_ARG_0_.myHandle, 1)
    Entity.EnableBgColl(_ARG_0_.myHandle, 1)
    return 0
  end,
  OnMessage = function(_ARG_0_, _ARG_1_, _ARG_2_)
    if _ARG_1_ == B40EX_MES_B40EX_ATTACK_REQUEST then
      if _ARG_0_.attackPermission == false then
        print("Send Vanitus ... B10EX_MES_B40EX_ATTACK_ACCEPT\n")
        Enemy.SendMessage(0, _ARG_0_.myHandle, _ARG_2_, B10EX_MES_B40EX_ATTACK_ACCEPT)
      else
        print("Send Vanitus ... B10EX_MES_B40EX_ATTACK_DENY\n")
        Enemy.SendMessage(0, _ARG_0_.myHandle, _ARG_2_, B10EX_MES_B40EX_ATTACK_DENY)
      end
    elseif _ARG_1_ == B40EX_MES_B40EX_ATTACK_END then
      print("Recv Vanitus ... B40EX_MES_B40EX_ATTACK_END\n")
      _ARG_0_.attackPermission = true
    end
  end,
  OnDead = function(_ARG_0_)
    SetupBossDead(_ARG_0_.myHandle)
    _ARG_0_:GotoState("Dead")
    print("\131\148\131@\131j\131^\131X\142\128\150S\n")
    return 1
  end,
  OnUpdate = function(_ARG_0_)
    _ARG_0_:Update()
    _ARG_0_:Debug()
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
EntityFactory:Add("b10ex00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b10ex01", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b10ex02", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b10exHSW", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b10exSDSW", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b10exSDS", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("DarkFiragaL", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("DarkFiragaS", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("DarkThundaga", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("DarkBlizzaga", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("IceCrystal", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
