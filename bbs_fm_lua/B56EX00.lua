setmetatable({
  new = function(_ARG_0_)
    print("b56ex00:new()\n")
    return setmetatable(__StateMachine:new(), _UPVALUE0_)
  end,
  states = {
    Appear = {
      OnBeginState = function(_ARG_0_)
        print("b56ex00:Appear\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_0_.MOT_IDLING, 29)
      end,
      OnUpdate = function(_ARG_0_)
      end
    },
    Idling = {
      OnBeginState = function(_ARG_0_)
        print("b56ex00:Idling\n")
        Entity.SetTimer(_ARG_0_.myHandle, 0)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_0_.MOT_IDLING, 29)
        Entity.EnableCameraBodyColl(_ARG_0_.myHandle, 1)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
      end,
      OnEndState = function(_ARG_0_)
        _ARG_0_.SubDelay = 0
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.GetCurrentMotion(_ARG_0_.myHandle) ~= _ARG_0_.MOT_IDLING and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Entity.SetMotion(_ARG_0_.myHandle, _ARG_0_.MOT_IDLING, 29)
        end
      end
    },
    Move = {
      OnBeginState = function(_ARG_0_)
        print("b56ex00:Move\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
      end
    },
    Attack0 = {
      OnBeginState = function(_ARG_0_)
        print("b56ex00:Attack0\n")
        _ARG_0_.nAttackCount = Script.RandomInteger(3) + 1
        _ARG_0_.nStep = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.nStep == 0 then
          Entity.SetMotion(_ARG_0_.myHandle, _ARG_0_.MOT_ATK0, 29)
          _ARG_0_.nStep = 1
        elseif _ARG_0_.nStep == 1 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.nAttackCount = _ARG_0_.nAttackCount - 1
          if 0 >= _ARG_0_.nAttackCount then
            _ARG_0_:GotoState("Idling")
          else
            _ARG_0_.nStep = 0
          end
        end
      end
    },
    Attack1 = {
      OnBeginState = function(_ARG_0_)
        print("b56ex00:Attack1\n")
        _ARG_0_.nAttackCount = Script.RandomInteger(3) + 1
        _ARG_0_.nStep = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.FadeoutEffectAttach(_ARG_0_.myHandle, 0, 29)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.nStep == 0 then
          Entity.SetMotion(_ARG_0_.myHandle, _ARG_0_.MOT_ATK1, 29)
          _ARG_0_.nStep = 1
        elseif _ARG_0_.nStep == 1 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 26 then
            _ARG_0_:ShootGroundWave()
            _ARG_0_.nStep = 2
          end
        elseif _ARG_0_.nStep == 2 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.nAttackCount = _ARG_0_.nAttackCount - 1
          if 0 >= _ARG_0_.nAttackCount then
            _ARG_0_:GotoState("Idling")
          else
            _ARG_0_.nStep = 0
          end
        end
      end
    },
    Attack2 = {
      OnBeginState = function(_ARG_0_)
        print("b56ex00:Attack2\n")
        _ARG_0_.nAttackCount = 8
        _ARG_0_.bCapture = false
        _ARG_0_.nStep = 0
        Player.SetTrgFlagCancel(_ARG_0_.playerHandle, 0)
      end,
      OnEndState = function(_ARG_0_)
        _ARG_0_.bulletHandle = NULL_HANDLE
        _ARG_0_.bCapture = false
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.nStep == 0 then
          Entity.SetMotion(_ARG_0_.myHandle, _ARG_0_.MOT_ATK2_IN, 29)
          FVECTOR3.set(_ARG_0_.vWork0, 0.5, 0.5, 0.5)
          Enemy.SetSceneColor(_ARG_0_.vWork0, 30)
          _ARG_0_.nStep = 100
        elseif _ARG_0_.nStep == 100 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 108 then
            Entity.SetupModelFade(_ARG_0_.myHandle, Entity.GetAlpha(_ARG_0_.myHandle), 0, 8)
            Entity.SetTimer(_ARG_0_.myHandle, 16)
            _ARG_0_.nStep = 1
          end
        elseif _ARG_0_.nStep == 1 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetupModelFade(_ARG_0_.myHandle, Entity.GetAlpha(_ARG_0_.myHandle), 1, 1)
            _ARG_0_:Attach(false)
            FVECTOR3.set(_ARG_0_.vWork0, 0, -10, 0)
            Entity.SetLocalPos(_ARG_0_.myHandle, _ARG_0_.vWork0)
            Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
            Entity.EnableCameraBodyColl(_ARG_0_.myHandle, 0)
            _ARG_0_.nStep = 2
          end
        elseif _ARG_0_.nStep == 2 then
          FVECTOR3.copy(_ARG_0_.vPlayerPos, _UPVALUE2_[(_ARG_0_.nVIdx - _UPVALUE0_) % _UPVALUE1_])
          Entity.SetLocalPos(_ARG_0_.myHandle, _ARG_0_.vPlayerPos)
          Entity.GetRot(_ARG_0_.vWork0, _ARG_0_.playerHandle)
          Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.vWork0)
          Entity.SetMotion(_ARG_0_.myHandle, _ARG_0_.MOT_ATK2, 29)
          _ARG_0_.bulletHandle = _ARG_0_:ShootDarkAerial(_ARG_0_.vPlayerPos)
          _ARG_0_.nStep = 3
        elseif _ARG_0_.nStep == 3 then
          Entity.GetLocalPos(_ARG_0_.vWork0, _ARG_0_.myHandle)
          Entity.GetWorldPos(_ARG_0_.vWork0, _ARG_0_.playerHandle, 0)
          FVECTOR3.sety(_ARG_0_.vWork0, (FVECTOR3.gety(_ARG_0_.vWork0)))
          Entity.SetLocalPos(_ARG_0_.myHandle, _ARG_0_.vWork0)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= _UPVALUE3_ then
            _ARG_0_.nStep = 4
          end
        elseif _ARG_0_.nStep == 4 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= _UPVALUE4_ then
            if Player.IsDamageFlagEat(_ARG_0_.playerHandle) then
              FVECTOR3.copy(_ARG_0_.vPlayerPos, _UPVALUE2_[_ARG_0_.nVIdx % _UPVALUE1_])
              Entity.SetLocalPos(_ARG_0_.myHandle, _ARG_0_.vPlayerPos)
              Entity.EnableLockon(_ARG_0_.terraHandle, 0)
              Camera.SetPlayerCameraSuspend(1)
              Camera.GetPlayerCameraPos(_ARG_0_.vWork0)
              Camera.GetPlayerCameraView(_ARG_0_.vWork1)
              _ARG_0_.camHandle = Camera.CameraCreate(_ARG_0_.vWork0, _ARG_0_.vWork1)
              fCamLookY = FVECTOR3.gety(_ARG_0_.vPlayerPos) + _UPVALUE5_
              Entity.SetLocalPos(_ARG_0_.playerHandle, _ARG_0_.vZero)
              Entity.GetRot(_ARG_0_.vWork0, _ARG_0_.playerHandle)
              Entity.GetRot(_ARG_0_.vWork1, _ARG_0_.myHandle)
              FVECTOR3.Sub(_ARG_0_.vWork1, _ARG_0_.vWork0, _ARG_0_.vWork1)
              FVECTOR3.sety(_ARG_0_.vWork0, (RoundPI((FVECTOR3.gety(_ARG_0_.vWork1)))))
              Entity.SetRot(_ARG_0_.playerHandle, _ARG_0_.vWork0)
              Entity.AttachCoord(_ARG_0_.myHandle, "Root", _ARG_0_.playerHandle, "Root")
              _ARG_0_.effHandle = Entity.AttachEffect(_ARG_0_.myHandle, "b56ex00", "B029_DAA_RIS0_0", "Root")
              _ARG_0_.bCapture = true
            end
            Bullet.EnableAttackCollision(_ARG_0_.bulletHandle, 0)
            FVECTOR3.set(_ARG_0_.vWork0, 0, 0.5, 0)
            Entity.CalcVelocity(_ARG_0_.myHandle, _ARG_0_.vWork0)
            _ARG_0_.nStep = 5
          end
        elseif _ARG_0_.nStep == 5 then
          Entity.GetLocalPos(_ARG_0_.vWork0, _ARG_0_.myHandle)
          if _ARG_0_.bCapture then
            Entity.GetWorldPos(_ARG_0_.vWork1, _ARG_0_.playerHandle, 1)
            if FVECTOR3.gety(_ARG_0_.vWork1) >= fCamLookY then
              FVECTOR3.sety(_ARG_0_.vWork1, fCamLookY)
            end
            Camera.CameraSetView(_ARG_0_.camHandle, _ARG_0_.vWork1)
          elseif Player.IsDamageFlagEat(_ARG_0_.playerHandle) then
          end
          if _UPVALUE7_ <= FVECTOR3.gety(_ARG_0_.vWork0) then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.nAttackCount = _ARG_0_.nAttackCount - 1
            if _ARG_0_.bCapture then
              FVECTOR3.set(_ARG_0_.vWork0, 0, -0.5, 0)
              Entity.CalcVelocity(_ARG_0_.myHandle, _ARG_0_.vWork0)
              Entity.GetRot(_ARG_0_.vWork0, _ARG_0_.myHandle)
              FVECTOR3.setx(_ARG_0_.vWork0, PI)
              Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.vWork0)
              _ARG_0_.nStep = 10
            elseif 0 >= _ARG_0_.nAttackCount then
              _ARG_0_.nStep = 20
            else
              _ARG_0_.nStep = 2
            end
          end
        elseif _ARG_0_.nStep == 10 then
          Entity.GetWorldPos(_ARG_0_.vWork1, _ARG_0_.playerHandle, 1)
          if FVECTOR3.gety(_ARG_0_.vWork1) >= fCamLookY then
            FVECTOR3.sety(_ARG_0_.vWork1, fCamLookY)
          end
          Camera.CameraSetView(_ARG_0_.camHandle, _ARG_0_.vWork1)
          Entity.GetLocalPos(_ARG_0_.vWork0, _ARG_0_.myHandle)
          if FVECTOR3.gety(_ARG_0_.vWork0) <= FVECTOR3.gety(_ARG_0_.vPlayerPos) + 2 then
            Entity.EnableLockon(_ARG_0_.terraHandle, 1)
            Camera.SetPlayerCameraSuspend(0)
            Camera.CameraDestroy(_ARG_0_.camHandle)
            _ARG_0_.camHandle = NULL_HANDLE
            Entity.AttachCoord(NULL_HANDLE, "Root", _ARG_0_.playerHandle, "Root")
            Entity.SetLocalPos(_ARG_0_.playerHandle, _ARG_0_.vPlayerPos)
            Player.SetTrgFlagCancel(_ARG_0_.playerHandle, 1)
            _ARG_0_:ShootDarkAerialDmg(_ARG_0_.vPlayerPos)
            _ARG_0_.nStep = 11
          end
        elseif _ARG_0_.nStep == 11 then
          Camera.QuakeV(50, 0.5, 12)
          _ARG_0_.nStep = 12
        elseif _ARG_0_.nStep == 12 then
          Entity.GetLocalPos(_ARG_0_.vWork0, _ARG_0_.myHandle)
          if FVECTOR3.gety(_ARG_0_.vWork0) <= FVECTOR3.gety(_ARG_0_.vPlayerPos) - 5 then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Effect.Fadeout(_ARG_0_.effHandle, 0)
            _ARG_0_.effHandle = NULL_HANDLE
            _ARG_0_.nStep = 20
          end
        elseif _ARG_0_.nStep == 20 then
          _ARG_0_:Attach(true)
          Entity.SetMotion(_ARG_0_.myHandle, _ARG_0_.MOT_ATK2_OUT, 29)
          Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
          Entity.EnableCameraBodyColl(_ARG_0_.myHandle, 1)
          _ARG_0_.nStep = 21
        elseif _ARG_0_.nStep == 21 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          FVECTOR3.set(_ARG_0_.vWork0, 1, 1, 1)
          Enemy.SetSceneColor(_ARG_0_.vWork0, 30)
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    Attack3 = {
      OnBeginState = function(_ARG_0_)
        print("b56ex00:Attack3\n")
        _ARG_0_.nAttackCount = Script.RandomInteger(3) + 1
        _ARG_0_.nAttacked = 0
        _ARG_0_.nStep = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.FadeoutEffectAttach(_ARG_0_.myHandle, 0, 30)
        Entity.FadeoutEffectAttach(_ARG_0_.myHandle, 0, 31)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.nStep == 0 then
          Entity.SetMotion(_ARG_0_.myHandle, _ARG_0_.MOT_ATK3_IN, -1)
          _ARG_0_.nStep = 1
        elseif _ARG_0_.nStep == 1 then
          if 0 < _ARG_0_.nAttacked then
            if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 30 then
              _ARG_0_.nStep = 2
            end
          elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_.nStep = 2
          end
        elseif _ARG_0_.nStep == 2 then
          Entity.SetMotion(_ARG_0_.myHandle, _ARG_0_.MOT_ATK3_OUT, -1)
          _ARG_0_.nStep = 3
        elseif _ARG_0_.nStep == 3 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 19 then
            Entity.FadeoutEffectAttach(_ARG_0_.myHandle, 0, 30)
            _ARG_0_:ShootDarkSoul(_UPVALUE0_)
            _ARG_0_.nStep = 4
          end
        elseif _ARG_0_.nStep == 4 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 38 then
            Entity.FadeoutEffectAttach(_ARG_0_.myHandle, 0, 31)
            _ARG_0_:ShootDarkSoul(_UPVALUE1_)
            _ARG_0_.nStep = 5
          end
        elseif _ARG_0_.nStep == 5 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.nAttacked = _ARG_0_.nAttacked + 1
          _ARG_0_.nAttackCount = _ARG_0_.nAttackCount - 1
          if 0 >= _ARG_0_.nAttackCount then
            _ARG_0_:GotoState("Idling")
          else
            _ARG_0_.nStep = 0
          end
        end
      end
    },
    Attack4 = {
      OnBeginState = function(_ARG_0_)
        print("b56ex00:Attack4\n")
        _ARG_0_.nStep = 0
        _ARG_0_.bCapture4 = false
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetupModelFade(_ARG_0_.myHandle, Entity.GetAlpha(_ARG_0_.myHandle), 1, 16)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        _ARG_0_.bCapture4 = false
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.nStep == 0 then
          Entity.SetMotion(_ARG_0_.myHandle, _ARG_0_.MOT_ATK4, 29)
          _ARG_0_.nStep = 1
        elseif _ARG_0_.nStep == 1 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 23 then
            _ARG_0_:Attach(false)
            Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
            _ARG_0_.nStep = 2
          end
        elseif _ARG_0_.nStep == 2 then
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, 0.2)
          Entity.TurnTargetYRate(_ARG_0_.myHandle, _ARG_0_.targetHandle, _UPVALUE0_)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 43 then
            Entity.SetupModelFade(_ARG_0_.myHandle, Entity.GetAlpha(_ARG_0_.myHandle), 0, 16)
            Entity.SetTimer(_ARG_0_.myHandle, 16)
            _ARG_0_.nStep = 3
          elseif Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 40 then
            Entity.AACStop(_ARG_0_.myHandle)
          end
          if _ARG_0_.bCapture4 == ture and Player.IsDamageFlagCapture(_ARG_0_.playerHandle) == true then
            _ARG_0_:GotoState("Capture")
          end
        elseif _ARG_0_.nStep == 3 then
          Player.SetTrgFlagCancel(_ARG_0_.playerHandle, 1)
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:Attach(true)
            Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
            _ARG_0_:GotoState("Idling")
          end
        end
      end
    },
    Capture = {
      OnBeginState = function(_ARG_0_)
        print("b56ex00:Capture\n")
        _ARG_0_:Attach(false)
        Entity.GetWorldPos(_ARG_0_.vWork0, _ARG_0_.playerHandle, 0)
        FVECTOR3.copy(_ARG_0_.vWork1, _ARG_0_.vWork0)
        FVECTOR3.set(_ARG_0_.vWork2, 0, 0.5, 0)
        FVECTOR3.Add(_ARG_0_.vWork0, _ARG_0_.vWork0, _ARG_0_.vWork2)
        FVECTOR3.set(_ARG_0_.vWork2, 0, -10, 0)
        FVECTOR3.Add(_ARG_0_.vWork1, _ARG_0_.vWork1, _ARG_0_.vWork2)
        Collision.IntersectRayBg(_ARG_0_.vWork0, COLL_KIND_PLAYER, _ARG_0_.vWork0, _ARG_0_.vWork1)
        Entity.SetLocalPos(_ARG_0_.playerHandle, _ARG_0_.vWork0)
        Entity.SetLocalPos(_ARG_0_.myHandle, _ARG_0_.vWork0)
        Entity.GetRot(_ARG_0_.vWork0, _ARG_0_.playerHandle)
        Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.vWork0)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
        _ARG_0_.nStep = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
        Entity.EnableHeavy(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.nStep == 0 then
          Entity.SetMotion(_ARG_0_.myHandle, _ARG_0_.MOT_ATK5_IN, 29)
          _ARG_0_.nStep = 1
        elseif _ARG_0_.nStep == 1 then
          if Player.IsDamageFlagCapture(_ARG_0_.playerHandle) == false then
            if _ARG_0_.insTerra:GetState() == "Attack5" then
            else
              _ARG_0_.insTerra:GotoState("Attack7")
            end
            _ARG_0_.nStep = 2
          end
        elseif _ARG_0_.nStep == 2 then
          Player.SetTrgFlagCancel(_ARG_0_.playerHandle, 1)
          Entity.SetMotion(_ARG_0_.myHandle, _ARG_0_.MOT_ATK5_OUT, 29)
          _ARG_0_.nStep = 3
        elseif _ARG_0_.nStep == 3 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _ARG_0_.MOT_IDLING, 29)
            Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
            Entity.EnableHeavy(_ARG_0_.myHandle, 0)
            _ARG_0_.nStep = 4
          end
        elseif _ARG_0_.nStep == 4 then
          Entity.TurnTargetYRate(_ARG_0_.myHandle, _ARG_0_.targetHandle, _UPVALUE0_)
        end
      end
    },
    DualLimit = {
      OnBeginState = function(_ARG_0_)
        print("b56ex00:DualLimit\n")
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_0_.MOT_IDLING, 29)
        Entity.GetRot(_ARG_0_.vRot, _ARG_0_.myHandle)
        FVECTOR3.sety(_ARG_0_.vRot, (RoundPI(FVECTOR3.gety(_ARG_0_.vRot) + PI / 4)))
        Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.vRot)
        FVECTOR3.set(_ARG_0_.vWork0, 0, 0, -0.5)
        Math.RotateVectorXYZ(_ARG_0_.vWork0, _ARG_0_.vRot)
        Entity.GetLocalPos(_ARG_0_.vWork1, _ARG_0_.myHandle)
        FVECTOR3.Add(_ARG_0_.vWork0, _ARG_0_.vWork0, _ARG_0_.vWork1)
        Entity.SetLocalPos(_ARG_0_.myHandle, _ARG_0_.vWork0)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
      end
    },
    DualLimitAtkIdling = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_0_.MOT_IDLING, 29)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.targetHandle = _ARG_0_.playerHandle
        _ARG_0_:UpdateDLAttackPos()
        FVECTOR3.set(_ARG_0_.vWork0, 0, 0, -_UPVALUE0_)
        if Entity.CalcDistanceXZ(_ARG_0_.targetHandle, _ARG_0_.vWork0) <= _UPVALUE1_ + 3 then
          _ARG_0_:GotoState("Attack7")
        elseif Entity.CalcDistanceXZ(_ARG_0_.targetHandle, _ARG_0_.vWork0) <= _UPVALUE1_ + 3 + 4 then
        else
          _ARG_0_:GotoState("Attack6")
        end
      end
    },
    DualLimitWait = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_0_.MOT_IDLING, 29)
        Entity.SetupModelFade(_ARG_0_.myHandle, Entity.GetAlpha(_ARG_0_.myHandle), 0, 30)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYRate(_ARG_0_.myHandle, _ARG_0_.targetHandle, _UPVALUE0_)
      end
    },
    DualLimitDamagePos = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_0_.MOT_IDLING, 29)
        FVECTOR3.set(_ARG_0_.vWork0, 0, 0, -_UPVALUE0_)
        Entity.SetLocalPos(_ARG_0_.myHandle, _ARG_0_.vWork0)
        Entity.SetOldLocalPos(_ARG_0_.myHandle, _ARG_0_.vWork0)
        Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.vZero)
        Entity.SetupModelFade(_ARG_0_.myHandle, Entity.GetAlpha(_ARG_0_.myHandle), 1, 60)
        Entity.GetRot(_ARG_0_.vRot, _ARG_0_.myHandle)
        FVECTOR3.sety(_ARG_0_.vRot, (RoundPI(FVECTOR3.gety(_ARG_0_.vRot) + PI / 4)))
        Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.vRot)
        FVECTOR3.set(_ARG_0_.vWork0, 0, 0, -0.5)
        Math.RotateVectorXYZ(_ARG_0_.vWork0, _ARG_0_.vRot)
        Entity.GetLocalPos(_ARG_0_.vWork1, _ARG_0_.myHandle)
        FVECTOR3.Add(_ARG_0_.vWork0, _ARG_0_.vWork0, _ARG_0_.vWork1)
        Entity.SetLocalPos(_ARG_0_.myHandle, _ARG_0_.vWork0)
        Entity.SetOldLocalPos(_ARG_0_.myHandle, _ARG_0_.vWork0)
        Entity.GetRot(_ARG_0_.vRot, _ARG_0_.myHandle)
        FVECTOR3.sety(_ARG_0_.vRot, (RoundPI(FVECTOR3.gety(_ARG_0_.vRot) + PI / 4)))
        Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.vRot)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.bDamage and Entity.GetCurrentMotion(_ARG_0_.myHandle) ~= _ARG_0_.MOT_IDLING and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Entity.SetMotion(_ARG_0_.myHandle, _ARG_0_.MOT_IDLING, 29)
          _ARG_0_.bDamage = false
        end
      end
    },
    DualLimitEnd = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_:Attach(true)
        Entity.SetupModelFade(_ARG_0_.myHandle, Entity.GetAlpha(_ARG_0_.myHandle), 1, 1)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
        Entity.EnableBgColl(_ARG_0_.myHandle, 0)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:GotoState("Idling")
      end
    },
    Attack6 = {
      OnBeginState = function(_ARG_0_)
        print("b56ex00:Attack6\n")
        _ARG_0_.nAttackCount = 1
        _ARG_0_.nAttacked = 0
        _ARG_0_.nStep = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.FadeoutEffectAttach(_ARG_0_.myHandle, 0, 30)
        Entity.FadeoutEffectAttach(_ARG_0_.myHandle, 0, 31)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:UpdateDLAttackPos()
        if _ARG_0_.nStep == 0 then
          Entity.SetMotion(_ARG_0_.myHandle, _ARG_0_.MOT_ATK6, -1)
          _ARG_0_.nStep = 3
        elseif _ARG_0_.nStep == 3 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 19 then
            Entity.FadeoutEffectAttach(_ARG_0_.myHandle, 0, 30)
            _ARG_0_:ShootDarkBlast(_UPVALUE0_)
            _ARG_0_.nStep = 4
          end
        elseif _ARG_0_.nStep == 4 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 38 then
            Entity.FadeoutEffectAttach(_ARG_0_.myHandle, 0, 31)
            _ARG_0_:ShootDarkBlast(_UPVALUE1_)
            _ARG_0_.nStep = 5
          end
        elseif _ARG_0_.nStep == 5 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.nAttacked = _ARG_0_.nAttacked + 1
          _ARG_0_.nAttackCount = _ARG_0_.nAttackCount - 1
          if 0 >= _ARG_0_.nAttackCount then
            _ARG_0_:GotoState("DualLimitAtkIdling")
          else
            _ARG_0_.nStep = 0
          end
        end
      end
    },
    Attack7 = {
      OnBeginState = function(_ARG_0_)
        print("b56ex00:Attack7\n")
        _ARG_0_.nAttackCount = 1
        _ARG_0_.nStep = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:UpdateDLAttackPos()
        if _ARG_0_.nStep == 0 then
          Entity.SetMotion(_ARG_0_.myHandle, _ARG_0_.MOT_ATK0, 29)
          _ARG_0_.nStep = 1
        elseif _ARG_0_.nStep == 1 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.nAttackCount = _ARG_0_.nAttackCount - 1
          if 0 >= _ARG_0_.nAttackCount then
            _ARG_0_:GotoState("DualLimitAtkIdling")
          else
            _ARG_0_.nStep = 0
          end
        end
      end
    },
    Standby = {
      OnBeginState = function(_ARG_0_)
        print("b56ex00:Standby\n")
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_0_.MOT_IDLING, 29)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Enemy.IsAllEnemyWaiting() == false then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    Dead = {
      OnBeginState = function(_ARG_0_)
        print("b56ex00:Dead\n")
        Entity.EnableLockon(_ARG_0_.myHandle, 0)
        if _ARG_0_:isDead() == true then
          Entity.SetMotion(_ARG_0_.myHandle, _ARG_0_.MOT_DMG, 29)
        end
        SetupBossDead(_ARG_0_.myHandle)
        _ARG_0_.nStep = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.GetCurrentMotion(_ARG_0_.myHandle) ~= _ARG_0_.MOT_IDLING and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Entity.SetMotion(_ARG_0_.myHandle, _ARG_0_.MOT_IDLING, 29)
        end
      end
    },
    Disappear = {
      OnBeginState = function(_ARG_0_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
      end
    }
  },
  OnInit = function(_ARG_0_, _ARG_1_)
    print("b56ex00:: OnInit\n")
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.targetHandle = NULL_HANDLE
    _ARG_0_.step = 0
    _ARG_0_.WorkTime = 0
    _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
    _ARG_0_.WorkVec = FVECTOR3.new(0, 0, 0)
    _ARG_0_.WorkVec1 = FVECTOR3.new(0, 0, 0)
    _ARG_0_.GuardFlag = 0
    _ARG_0_.nStep = 0
    _ARG_0_.vRot = FVECTOR3.new(0, 0, 0)
    _ARG_0_.vZero = FVECTOR3.new(0, 0, 0)
    _ARG_0_.vWork0 = FVECTOR3.new(0, 0, 0)
    _ARG_0_.vWork1 = FVECTOR3.new(0, 0, 0)
    _ARG_0_.vWork2 = FVECTOR3.new(0, 0, 0)
    _ARG_0_.vWork3 = FVECTOR3.new(0, 0, 0)
    _ARG_0_.terraHandle = NULL_HANDLE
    _ARG_0_.insTerra = 0
    _ARG_0_.playerHandle = Player.GetHandle()
    _ARG_0_.camHandle = NULL_HANDLE
    _ARG_0_.bulletHandle = NULL_HANDLE
    _ARG_0_.effHandle = NULL_HANDLE
    _ARG_0_.nAttackCount = 0
    _ARG_0_.nAttacked = 0
    _ARG_0_.bCapture = false
    _ARG_0_.bCapture4 = false
    _ARG_0_.bDamage = false
    _ARG_0_.nDLResult = 0
    _ARG_0_.bDead = false
    _ARG_0_.bEndDead = false
    _ARG_0_.fTargetDir = 0
    _UPVALUE0_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "DSoulSpd")
    _UPVALUE1_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "DBlastSpd")
    _UPVALUE2_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "DLDamage")
    _UPVALUE3_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "DLDmgRate")
    _ARG_0_.stack = Stack:Create()
    _ARG_0_.MOT_APPEAR = Entity.GetMotionIndex(_ARG_1_, "011")
    _ARG_0_.MOT_IDLING = Entity.GetMotionIndex(_ARG_1_, "010")
    _ARG_0_.MOT_MOVEF = Entity.GetMotionIndex(_ARG_1_, "030")
    _ARG_0_.MOT_MOVEB = Entity.GetMotionIndex(_ARG_1_, "031")
    _ARG_0_.MOT_MOVER = Entity.GetMotionIndex(_ARG_1_, "032")
    _ARG_0_.MOT_MOVEL = Entity.GetMotionIndex(_ARG_1_, "033")
    _ARG_0_.MOT_DMG = Entity.GetMotionIndex(_ARG_1_, "220")
    _ARG_0_.MOT_ATK0 = Entity.GetMotionIndex(_ARG_1_, "300")
    _ARG_0_.MOT_ATK1 = Entity.GetMotionIndex(_ARG_1_, "310")
    _ARG_0_.MOT_ATK2_IN = Entity.GetMotionIndex(_ARG_1_, "320")
    _ARG_0_.MOT_ATK2 = Entity.GetMotionIndex(_ARG_1_, "321")
    _ARG_0_.MOT_ATK2_OUT = Entity.GetMotionIndex(_ARG_1_, "322")
    _ARG_0_.MOT_ATK3_IN = Entity.GetMotionIndex(_ARG_1_, "330")
    _ARG_0_.MOT_ATK3_OUT = Entity.GetMotionIndex(_ARG_1_, "331")
    _ARG_0_.MOT_ATK4 = Entity.GetMotionIndex(_ARG_1_, "340")
    _ARG_0_.MOT_ATK5_IN = Entity.GetMotionIndex(_ARG_1_, "350")
    _ARG_0_.MOT_ATK5_OUT = Entity.GetMotionIndex(_ARG_1_, "351")
    _ARG_0_.MOT_ATK6 = Entity.GetMotionIndex(_ARG_1_, "360")
    _ARG_0_.nVIdx = 0
    _UPVALUE4_[0] = FVECTOR3.new(0, 0, 0)
    _UPVALUE4_[1] = FVECTOR3.new(0, 0, 0)
    _UPVALUE4_[2] = FVECTOR3.new(0, 0, 0)
    _UPVALUE4_[3] = FVECTOR3.new(0, 0, 0)
    _UPVALUE4_[4] = FVECTOR3.new(0, 0, 0)
    _UPVALUE4_[5] = FVECTOR3.new(0, 0, 0)
    _UPVALUE4_[6] = FVECTOR3.new(0, 0, 0)
    _UPVALUE4_[7] = FVECTOR3.new(0, 0, 0)
    _UPVALUE4_[8] = FVECTOR3.new(0, 0, 0)
    _UPVALUE4_[9] = FVECTOR3.new(0, 0, 0)
    _UPVALUE4_[10] = FVECTOR3.new(0, 0, 0)
    _UPVALUE4_[11] = FVECTOR3.new(0, 0, 0)
    _UPVALUE4_[12] = FVECTOR3.new(0, 0, 0)
    _UPVALUE4_[13] = FVECTOR3.new(0, 0, 0)
    _UPVALUE4_[14] = FVECTOR3.new(0, 0, 0)
    _UPVALUE4_[15] = FVECTOR3.new(0, 0, 0)
    _ARG_0_.vPlayerPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.fCamLookY = 0
    Entity.SetMovementCollRadius(_ARG_0_.myHandle, 1)
    Entity.SetLowerHalf(_ARG_0_.myHandle, 1.5)
    Entity.EnableBgColl(_ARG_0_.myHandle, 0)
    Entity.EnableCameraBodyColl(_ARG_0_.myHandle, 0)
    Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
    Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
    Entity.EnableLockon(_ARG_0_.myHandle, 0)
    Entity.EnableGravity(_ARG_0_.myHandle, 0)
    Entity.EnableHeavy(_ARG_0_.myHandle, 1)
    Entity.EnableShooton(_ARG_0_.myHandle, 0)
    if Enemy.IsAllEnemyWaiting() == true then
      _ARG_0_:GotoState("Standby")
    else
      _ARG_0_:GotoState("Appear")
    end
    print("b56ex00:: OnInitEnd\n")
  end,
  OnDamage = function(_ARG_0_, _ARG_1_)
    print("b56ex00:OnDamage\n")
    return (_ARG_0_:__OnDamage())
  end,
  __OnDamage = function(_ARG_0_)
    _ARG_0_.bDamage = true
    if _ARG_0_.nDLResult == 2 then
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
    else
      _ARG_0_.bDamage = false
    end
    if 0 >= Enemy.GetHp(_ARG_0_.terraHandle) - 0 then
      _ARG_0_.bDead = true
      _ARG_0_:GotoState("Dead")
    end
    Enemy.SetHP(_ARG_0_.myHandle, Enemy.GetHp(_ARG_0_.terraHandle) - 0)
    print(" ", _ARG_0_.nDLResult, " ", 0, " ", Enemy.GetHp(_ARG_0_.terraHandle) - 0)
    print("\n")
    return 1
  end,
  OnDamageBefore = function(_ARG_0_, _ARG_1_)
  end,
  OnReturnDamage = function(_ARG_0_)
    print("b56ex00:OnReturnDamage\n")
    _ARG_0_.bDamage = false
    Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_0_.MOT_IDLING, 29)
    Entity.EnableBgColl(_ARG_0_.myHandle, 0)
  end,
  OnHitAttack = function(_ARG_0_)
    if _ARG_0_:GetState() == "Attack4" then
      _ARG_0_.bCapture4 = ture
    end
  end,
  OnDead = function(_ARG_0_)
    print("b56ex00:OnDead\n")
    if _ARG_0_:__OnDamage() == 0 then
      Entity.SetMotion(_ARG_0_.myHandle, _ARG_0_.MOT_DMG, 29)
    end
    return 1
  end,
  OnUpdate = function(_ARG_0_)
    _ARG_0_:Update()
    _ARG_0_.nVIdx = _ARG_0_.nVIdx + 1
    Entity.GetWorldPos(_UPVALUE1_[_ARG_0_.nVIdx % _UPVALUE0_], _ARG_0_.playerHandle, 0)
    FVECTOR3.copy(_ARG_0_.vWork0, _UPVALUE1_[_ARG_0_.nVIdx % _UPVALUE0_])
    FVECTOR3.copy(_ARG_0_.vWork1, _UPVALUE1_[_ARG_0_.nVIdx % _UPVALUE0_])
    FVECTOR3.set(_ARG_0_.vWork2, 0, 0.5, 0)
    FVECTOR3.Add(_ARG_0_.vWork0, _ARG_0_.vWork0, _ARG_0_.vWork2)
    FVECTOR3.set(_ARG_0_.vWork2, 0, -10, 0)
    FVECTOR3.Add(_ARG_0_.vWork1, _ARG_0_.vWork1, _ARG_0_.vWork2)
    Collision.IntersectRayBg(_UPVALUE1_[_ARG_0_.nVIdx % _UPVALUE0_], COLL_KIND_PLAYER, _ARG_0_.vWork0, _ARG_0_.vWork1)
  end,
  SetingGuard = function(_ARG_0_)
    Entity.EnableGuard(_ARG_0_.myHandle, 1)
    Entity.EnableGuardPhysical(_ARG_0_.myHandle, 1)
    Entity.EnableGuardZero(_ARG_0_.myHandle, 1)
    Entity.EnableGuardFire(_ARG_0_.myHandle, 1)
    Entity.EnableGuardIce(_ARG_0_.myHandle, 1)
    Entity.EnableGuardThunder(_ARG_0_.myHandle, 1)
    Entity.SetGuardDir(_ARG_0_.myHandle, 360)
    Entity.EnableGuardSpecial(_ARG_0_.myHandle, 1)
  end,
  EndGuard = function(_ARG_0_)
    Entity.EnableGuard(_ARG_0_.myHandle, 0)
    Entity.EnableGuardPhysical(_ARG_0_.myHandle, 0)
    Entity.EnableGuardZero(_ARG_0_.myHandle, 0)
    Entity.EnableGuardFire(_ARG_0_.myHandle, 0)
    Entity.EnableGuardIce(_ARG_0_.myHandle, 0)
    Entity.EnableGuardThunder(_ARG_0_.myHandle, 0)
    Entity.SetGuardDir(_ARG_0_.myHandle, 0)
    Entity.EnableGuardSpecial(_ARG_0_.myHandle, 0)
  end,
  Attach = function(_ARG_0_, _ARG_1_)
    if _ARG_1_ == true then
      Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.vZero)
      Entity.SetLocalPos(_ARG_0_.myHandle, _ARG_0_.vZero)
      Entity.AttachCoord(_ARG_0_.terraHandle, "Root", _ARG_0_.myHandle, "Root")
    else
      Entity.AttachCoord(NULL_HANDLE, "Root", _ARG_0_.myHandle, "Root")
      Entity.GetLocalPos(_ARG_0_.vWork0, _ARG_0_.terraHandle)
      Entity.SetLocalPos(_ARG_0_.myHandle, _ARG_0_.vWork0)
      Entity.GetRot(_ARG_0_.vWork0, _ARG_0_.terraHandle)
      Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.vWork0)
    end
  end,
  EnableDamage = function(_ARG_0_, _ARG_1_)
    if _ARG_1_ == true then
      Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
      Entity.EnableLockon(_ARG_0_.myHandle, 1)
      Entity.EnableBgColl(_ARG_0_.myHandle, 1)
    else
      Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
      Entity.EnableLockon(_ARG_0_.myHandle, 0)
    end
  end,
  SyncHp = function(_ARG_0_, _ARG_1_)
    if _ARG_1_ == true then
      Enemy.SetHP(_ARG_0_.myHandle, (Enemy.GetHp(_ARG_0_.terraHandle)))
    else
      Enemy.SetHP(_ARG_0_.terraHandle, 1)
    end
  end,
  AlphaFade = function(_ARG_0_, _ARG_1_, _ARG_2_)
    Entity.SetupModelFade(_ARG_0_.myHandle, Entity.GetAlpha(_ARG_0_.myHandle), _ARG_1_, _ARG_2_)
  end,
  isDamage = function(_ARG_0_)
    return _ARG_0_.bDamage
  end,
  isDead = function(_ARG_0_)
    return _ARG_0_.bDead
  end,
  endDead = function(_ARG_0_)
    _ARG_0_.bEndDead = true
  end,
  getDLDamage = function(_ARG_0_)
    return (Math.integer(_UPVALUE1_))
  end,
  setDLResult = function(_ARG_0_, _ARG_1_)
    _ARG_0_.nDLResult = _ARG_1_
  end,
  UpdateDLAttackPos = function(_ARG_0_)
    Entity.TurnTargetYRate(_ARG_0_.myHandle, _ARG_0_.targetHandle, _UPVALUE0_)
    FVECTOR3.set(_ARG_0_.vWork0, 0, 0, -_UPVALUE1_)
    Entity.GetWorldPos(_ARG_0_.vWork2, _ARG_0_.playerHandle, 0)
    FVECTOR3.Sub(_ARG_0_.vWork2, _ARG_0_.vWork0, _ARG_0_.vWork2)
    _ARG_0_.fTargetDir = -Math.Atan2(FVECTOR3.getz(_ARG_0_.vWork2), (FVECTOR3.getx(_ARG_0_.vWork2))) + PI
    _ARG_0_.fTargetDir = RoundPI(_ARG_0_.fTargetDir)
    FVECTOR3.set(_ARG_0_.vWork1, 0, 1, 0)
    Entity.RotateAxis(_ARG_0_.myHandle, _ARG_0_.vWork1, _ARG_0_.fTargetDir, _UPVALUE2_, _ARG_0_.vWork0)
  end,
  ShootGroundWave = function(_ARG_0_)
    Entity.GetWorldPos(_ARG_0_.vWork0, _ARG_0_.myHandle, 0)
    Entity.GetRot(_ARG_0_.vRot, _ARG_0_.terraHandle)
    FVECTOR3.set(_ARG_0_.vWork3, 0, 0.1, -1)
    Math.RotateVectorXYZ(_ARG_0_.vWork3, _ARG_0_.vRot)
    FVECTOR3.Add(_ARG_0_.vWork0, _ARG_0_.vWork0, _ARG_0_.vWork3)
    SetBulletAttackParam(Bullet.CreateBullet("b56ex00_GroundWave", _ARG_0_.vWork0, _ARG_0_.vRot), _ARG_0_.myHandle, 1)
    EntityManager:GetEntity((Bullet.CreateBullet("b56ex00_GroundWave", _ARG_0_.vWork0, _ARG_0_.vRot))).targetHandle = _ARG_0_.targetHandle
    return (Bullet.CreateBullet("b56ex00_GroundWave", _ARG_0_.vWork0, _ARG_0_.vRot))
  end,
  ShootDarkSoul = function(_ARG_0_, _ARG_1_)
    Entity.GetWorldPos(_ARG_0_.vWork0, _ARG_0_.myHandle, _ARG_1_)
    Entity.GetRot(_ARG_0_.vRot, _ARG_0_.terraHandle)
    SetBulletAttackParam(Bullet.CreateBullet("b56ex00_DarkSoul", _ARG_0_.vWork0, _ARG_0_.vRot), _ARG_0_.myHandle, 3)
    EntityManager:GetEntity((Bullet.CreateBullet("b56ex00_DarkSoul", _ARG_0_.vWork0, _ARG_0_.vRot))).targetHandle = _ARG_0_.targetHandle
    return (Bullet.CreateBullet("b56ex00_DarkSoul", _ARG_0_.vWork0, _ARG_0_.vRot))
  end,
  ShootDarkAerial = function(_ARG_0_, _ARG_1_)
    FVECTOR3.set(_ARG_0_.vRot, 0, 0, 0)
    FVECTOR3.sety(_ARG_1_, FVECTOR3.gety(_ARG_1_) + 0.1)
    SetBulletAttackParam(Bullet.CreateBullet("b56ex00_DarkAerial", _ARG_1_, _ARG_0_.vRot), _ARG_0_.myHandle, 2)
    EntityManager:GetEntity((Bullet.CreateBullet("b56ex00_DarkAerial", _ARG_1_, _ARG_0_.vRot))).targetHandle = _ARG_0_.targetHandle
    return (Bullet.CreateBullet("b56ex00_DarkAerial", _ARG_1_, _ARG_0_.vRot))
  end,
  ShootDarkAerialDmg = function(_ARG_0_, _ARG_1_)
    FVECTOR3.set(_ARG_0_.vRot, 0, 0, 0)
    FVECTOR3.sety(_ARG_1_, FVECTOR3.gety(_ARG_1_) + 0.1)
    SetBulletAttackParam(Bullet.CreateBullet("b56ex00_DarkAerialDmg", _ARG_1_, _ARG_0_.vRot), _ARG_0_.myHandle, 12)
    EntityManager:GetEntity((Bullet.CreateBullet("b56ex00_DarkAerialDmg", _ARG_1_, _ARG_0_.vRot))).targetHandle = _ARG_0_.targetHandle
    return (Bullet.CreateBullet("b56ex00_DarkAerialDmg", _ARG_1_, _ARG_0_.vRot))
  end,
  ShootDarkBlast = function(_ARG_0_, _ARG_1_)
    Entity.GetWorldPos(_ARG_0_.vWork0, _ARG_0_.myHandle, _ARG_1_)
    Entity.GetRot(_ARG_0_.vRot, _ARG_0_.myHandle)
    SetBulletAttackParam(Bullet.CreateBullet("b56ex00_DarkBlast", _ARG_0_.vWork0, _ARG_0_.vRot), _ARG_0_.myHandle, 6)
    EntityManager:GetEntity((Bullet.CreateBullet("b56ex00_DarkBlast", _ARG_0_.vWork0, _ARG_0_.vRot))).targetHandle = _ARG_0_.targetHandle
    return (Bullet.CreateBullet("b56ex00_DarkBlast", _ARG_0_.vWork0, _ARG_0_.vRot))
  end
}, {__index = __StateMachine})
EntityFactory:Add("b56ex00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b56ex00_GroundWave", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b56ex00_DarkSoul", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b56ex00_DarkAerial", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b56ex00_DarkAerialDmg", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b56ex00_DarkBlast", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
