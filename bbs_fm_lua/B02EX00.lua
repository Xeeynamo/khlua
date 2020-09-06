B02EX_INIT_PARAM = false
for _FORV_128_ = 0, 11 do
end
setmetatable({
  new = function(_ARG_0_)
    return setmetatable(__StateMachine:new(), _UPVALUE0_)
  end,
  states = {
    Appear = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_.targetHandle = Player.GetHandle()
        _ARG_0_.cameraStep = _UPVALUE0_
        _ARG_0_:setMotion(_UPVALUE1_, 1, 1)
        if _ARG_0_:isFastBoss() == 0 then
          return
        end
        _UPVALUE2_:set(0, 0, 0)
        Script.SettingFog(_UPVALUE2_, _UPVALUE3_, _UPVALUE4_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.targetHandle = Player.GetHandle()
        _ARG_0_:GotoState("Idling1")
      end
    },
    Idling1 = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_:OutEyeLight()
        print(Entity.GetName(_ARG_0_.myHandle) .. ":Idling1\n")
        _ARG_0_.step = 0
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_ + Script.Random() * _UPVALUE0_)
        if 0 >= _ARG_0_.AttackTimer and _ARG_0_.AttackFlag == 2 then
          if Script.Random() < 0.5 then
            _ARG_0_.AttackTimer = _UPVALUE1_ * 60
          elseif Script.Random() < 0.85 then
            _ARG_0_.AttackTimer = 0
          else
            _ARG_0_.AttackTimer = _UPVALUE2_ * 60
          end
          _ARG_0_.AttackFlag = 0
        end
        _UPVALUE3_:set(0, 0, 0)
        _UPVALUE3_:sety(Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle))
        Entity.SetRot(_ARG_0_.myHandle, _UPVALUE3_)
        _ARG_0_:setMotion(_UPVALUE4_)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
        Entity.LoopEndEffectAttach(_ARG_0_.myHandle, -1)
        Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 1)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _UPVALUE0_ == 0 then
          _ARG_0_:GotoState("NextBattleSetup")
          return
        end
        Entity.GetRot(_UPVALUE1_, _ARG_0_.targetHandle)
        Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
        _UPVALUE1_:sety(Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle))
        Entity.SetRot(_ARG_0_.myHandle, _UPVALUE1_)
        if _ARG_0_.AttackFlag == 1 then
          _ARG_0_:SettingsStateToBattole1Attack()
          _ARG_0_:GotoState((_ARG_0_.stack:pop(1)))
          _ARG_0_.AttackFlag = 2
          return
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
        end
        if _ARG_0_.step == 0 then
        elseif _ARG_0_.step == 1 then
        elseif _ARG_0_.step == 2 then
        end
      end
    },
    AttackAfterIdling = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":AttackAfterIdling\n")
        _ARG_0_.step = 0
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_:setMotion(_UPVALUE1_)
        _ARG_0_.AttackTimer = _UPVALUE0_
        _ARG_0_.HitAttackFlag = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if 0 > _ARG_0_.AttackTimer then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        elseif _ARG_0_.step == 1 then
        end
      end
    },
    CameraState = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":CameraState\n")
        _ARG_0_.step = 0
        Entity.SetTimer(_ARG_0_.myHandle, 60)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        elseif _ARG_0_.step == 1 then
        end
      end
    },
    BackStep1 = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":BackStep1\n")
        _ARG_0_:setMotion(_UPVALUE0_)
        _ARG_0_.step = 0
        Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 30)
        _ARG_0_:OutEyeLight()
        Entity.EnableLockon(_ARG_0_.myHandle, 0)
        _ARG_0_.BadEffectHandle = Enemy.GetBadStatusEffect(_ARG_0_.myHandle)
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.FadeoutEffectAttach(_ARG_0_.myHandle, 1, 1)
        Effect.SetAlpha(_ARG_0_.BadEffectHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if _ARG_0_.trunAngle > _UPVALUE0_ then
            _ARG_0_.trunAngle = _UPVALUE0_
          else
            _ARG_0_.trunAngle = _ARG_0_.trunAngle + 5.5
          end
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, _ARG_0_.trunAngle)
          _UPVALUE1_:set(0, 0, _UPVALUE2_)
          Entity.CalcVelocity(_ARG_0_.myHandle, _UPVALUE1_)
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        end
      end
    },
    RightAndLeftStep1 = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":RightAndLeftStep1\n")
        if _ARG_0_:WhichRightandLeft() == 0 then
          _ARG_0_:setMotion(_UPVALUE0_)
          _ARG_0_.step = 1
        else
          _ARG_0_:setMotion(_UPVALUE1_)
          _ARG_0_.step = 0
        end
        _ARG_0_.trunAngle = 0
        _ARG_0_.Speed = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          _ARG_0_:MoveLeftOrRight(_UPVALUE0_, 0.1)
        elseif _ARG_0_.step == 1 then
          _ARG_0_:MoveLeftOrRight(-_UPVALUE0_, 0.1)
        end
        Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
        _UPVALUE1_:sety(Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle))
        Entity.SetRot(_ARG_0_.myHandle, _UPVALUE1_)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    RightAndLeftMove1 = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":RightAndLeftStep1\n")
        if _ARG_0_:PleryrBackWhichRightandLeft() == 0 then
          _ARG_0_:setMotion(_UPVALUE0_)
          _ARG_0_.step = 0
        else
          _ARG_0_:setMotion(_UPVALUE1_)
          _ARG_0_.step = 1
        end
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE2_ + Script.Random() * _UPVALUE2_)
        _ARG_0_.Speed = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          _ARG_0_:MoveLeftOrRight(0.02, 0.1)
        elseif _ARG_0_.step == 1 then
          _ARG_0_:MoveLeftOrRight(-0.02, 0.1)
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
        Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
        _UPVALUE0_:sety(Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle))
        Entity.SetRot(_ARG_0_.myHandle, _UPVALUE0_)
      end
    },
    RushAttack1 = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":RushAttack1\n")
        _ARG_0_.step = 0
        Entity.SetEffectAttach(_ARG_0_.myHandle, 1, "010", 1)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        _ARG_0_:SetEyeLight()
        Entity.EnableLockon(_ARG_0_.myHandle, 1)
        _UPVALUE0_:set(0, 0, 0)
        Script.SettingFog(_UPVALUE0_, _UPVALUE1_, _UPVALUE2_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.SetupModelFade(_ARG_0_.myHandle, 0, 0, -1)
          Script.SetPlaySpeed(0.2)
          _ARG_0_.Speed = 0
          _UPVALUE0_:set(0, 0, 0)
          Script.SettingFog(_UPVALUE0_, _UPVALUE1_ * 5, _UPVALUE2_ * 9)
          _ARG_0_:CreateAttackCamera(0)
          _ARG_0_.step = 1
          _ARG_0_.cameraStep = _UPVALUE3_
          _ARG_0_.cameraEndTimer = 1000
        elseif _ARG_0_.step == 1 then
          Entity.GetRot(_UPVALUE4_, _ARG_0_.myHandle)
          _UPVALUE4_:sety(Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle))
          Entity.SetRot(_ARG_0_.myHandle, _UPVALUE4_)
          if Camera.IsEndExusiaCamera(_ARG_0_.camera) then
            _ARG_0_.step = 2
            _ARG_0_:setMotion(_UPVALUE5_)
            _ARG_0_:DeleteAttackCamera()
            _ARG_0_.cameraEndTimer = -1
            _UPVALUE0_:set(0, 0, 0)
            Script.SettingFog(_UPVALUE0_, _UPVALUE1_, _UPVALUE2_)
          end
        elseif _ARG_0_.step == 2 then
          _UPVALUE0_:set(0, 0, 0)
          Script.SettingFog(_UPVALUE0_, _UPVALUE1_, _UPVALUE2_)
          _UPVALUE0_:set(0, 0, 1)
          Entity.GetWorldPos2(_UPVALUE0_, _ARG_0_.myHandle, _UPVALUE0_)
          Entity.GetRot(_UPVALUE4_, _ARG_0_.myHandle)
          _UPVALUE4_:sety(Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle))
          Entity.SetRot(_ARG_0_.myHandle, _UPVALUE4_)
          _ARG_0_:MoveEx(Entity.CalcDistance(_ARG_0_.targetHandle, _UPVALUE0_) / (Entity.GetMotionTotalFrame(_ARG_0_.myHandle) * 2), 1)
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_.step = 3
            _ARG_0_:setMotion(_UPVALUE6_)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Script.SetPlaySpeed(1)
          end
        elseif _ARG_0_.step == 3 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _UPVALUE0_:set(0, 0, 0)
          Script.SettingFog(_UPVALUE0_, _UPVALUE1_, _UPVALUE2_)
          Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, -1)
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    FormerStep = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":FormerStep\n")
        _ARG_0_.step = -1
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
        _ARG_0_.gameSpeed = 0.2
        if _ARG_0_.cameraTyep == 0 then
          _ARG_0_:SetCameraStartPos(-30)
        elseif _ARG_0_.cameraTyep == 1 then
          _ARG_0_:SetCameraStartPos(-9)
        elseif _ARG_0_.cameraTyep == 2 then
          _ARG_0_:SetCameraStartPos(-9)
        end
        Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
        _UPVALUE0_:sety(Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle))
        Entity.SetRot(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.FadeoutEffectAttach(_ARG_0_.myHandle, 1, -1)
        Entity.SetupModelFade(_ARG_0_.myHandle, 0, 0, -1)
        _ARG_0_.workTimer = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        _ARG_0_:SetEyeLight()
        Entity.EnableLockon(_ARG_0_.myHandle, 1)
        Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, 3)
        _UPVALUE0_:set(0, 0, 0)
        Script.SettingFog(_UPVALUE0_, _UPVALUE1_, _UPVALUE2_)
        Entity.SetEffectAttach(_ARG_0_.myHandle, 1, "010", 1)
        Entity.EnableBgColl(_ARG_0_.myHandle, 1)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == -1 then
          _ARG_0_.step = 0
        elseif _ARG_0_.step == 0 then
          Entity.SetupModelFade(_ARG_0_.myHandle, 0, 0, -1)
          Script.SetPlaySpeed(_ARG_0_.gameSpeed)
          _ARG_0_.Speed = 0
          _UPVALUE0_:set(0, 0, 0)
          Script.SettingFog(_UPVALUE0_, _UPVALUE1_ * 5, _UPVALUE2_ * 9)
          _ARG_0_:CreateAttackCamera(_ARG_0_.cameraTyep)
          _ARG_0_.step = 1
          _ARG_0_.cameraStep = _UPVALUE3_
          _ARG_0_.cameraEndTimer = 1000
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE4_[_ARG_0_.cameraTyep].endtime - 4)
          _ARG_0_.workTimer = _UPVALUE4_[_ARG_0_.cameraTyep].endtime - 8
          Entity.EnableBgColl(_ARG_0_.myHandle, 0)
          Entity.EnableGravity(_ARG_0_.myHandle, 0)
        elseif _ARG_0_.step == 1 then
          Entity.GetRot(_UPVALUE5_, _ARG_0_.myHandle)
          _UPVALUE5_:sety(Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle))
          Entity.SetRot(_ARG_0_.myHandle, _UPVALUE5_)
          _ARG_0_.workTimer = _ARG_0_.workTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 > _ARG_0_.workTimer then
            _ARG_0_.workTimer = 100
            _ARG_0_.nextState = _ARG_0_.stack:pop(1)
            if _ARG_0_.nextState == "Battole1Rush" then
              _ARG_0_:setMotionNoCheck(_UPVALUE6_)
            elseif _ARG_0_.nextState == "Scratich1" then
              _ARG_0_:setMotionNoCheck(_UPVALUE7_, 1, -1)
            elseif _ARG_0_.nextState == "Scratich11" then
              _ARG_0_:setMotionNoCheck(_UPVALUE8_, 1, -1)
            end
          end
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_.cameraEndTimer = 4
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if Camera.IsEndExusiaCamera(_ARG_0_.camera) then
            _ARG_0_:DeleteAttackCamera()
            _ARG_0_.cameraEndTimer = -1
            _UPVALUE0_:set(0, 0, 0)
            Script.SettingFog(_UPVALUE0_, _UPVALUE1_, _UPVALUE2_)
            _ARG_0_:GotoState(_ARG_0_.nextState)
            DeleteFisheyeLens(_ARG_0_.myHandle)
            Effect.KillEffect(_UPVALUE9_)
            Effect.KillEffect(_UPVALUE10_)
          end
        elseif _ARG_0_.step == 3 then
        end
      end
    },
    TopBackWorp = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":TopBackWorp\n")
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
        _UPVALUE0_:sety(Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle))
        Entity.SetRot(_ARG_0_.myHandle, _UPVALUE0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Script.Random() < 0.5 then
            _UPVALUE0_:set(0, 0, 100)
          else
            _UPVALUE0_:set(0, 0, -100)
          end
          Entity.GetWorldPos2(_UPVALUE1_, _ARG_0_.targetHandle, _UPVALUE0_)
          _UPVALUE0_:set(0, 0, 0)
          _UPVALUE2_:set(0, 0, 0)
          FVECTOR3.Sub(_UPVALUE3_, _UPVALUE2_, _UPVALUE1_)
          FVECTOR3.normalize(_UPVALUE3_)
          _ARG_0_:SetMapOutDist(4, RadToDeg(Script.Random() * 360))
          _ARG_0_.step = 1
        elseif _ARG_0_.step == 1 then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Battole1Rush = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":Battole1Rush\n")
        Entity.SetAnimNowFrame(_ARG_0_.myHandle, 34)
        _ARG_0_.step = 0
        _ARG_0_.Speed = 0
        _ARG_0_.nowMoveDist = 0
        _ARG_0_.HitAttackFlag = 0
        Entity.EnableBgColl(_ARG_0_.myHandle, 0)
        Entity.EnableGravity(_ARG_0_.myHandle, 0)
        _ARG_0_.workStep = 0
        Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
        _UPVALUE0_:sety(0)
        Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetOldLocalPos(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.StartPos:set(_UPVALUE1_:getx(), _UPVALUE1_:gety(), _UPVALUE1_:getz())
        _ARG_0_.workTimer = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.EnableLockon(_ARG_0_.myHandle, 0)
        _ARG_0_.gameSpeed = 1
        Script.SetPlaySpeed(_ARG_0_.gameSpeed)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.gameSpeed = _ARG_0_.gameSpeed + 0.1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.gameSpeed > 1 then
          _ARG_0_.gameSpeed = 1
        end
        Script.SetPlaySpeed(_ARG_0_.gameSpeed)
        if _ARG_0_.workStep < 3 then
          _ARG_0_.workStep = _ARG_0_.workStep + 1
          Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
          _UPVALUE0_:sety(Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle))
          Entity.SetRot(_ARG_0_.myHandle, _UPVALUE0_)
        end
        if _ARG_0_.step == 0 or _ARG_0_.step == 1 then
          _ARG_0_.workTimer = _ARG_0_.workTimer - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 > _ARG_0_.workTimer then
            _ARG_0_:CreateRushAttackColl(3)
            _ARG_0_:CreateRushAttackColl(-3)
            _ARG_0_.workTimer = 12
          end
        end
        if _ARG_0_.step == 0 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 10 then
            _ARG_0_:MoveEx(_UPVALUE1_, 0.1)
            _ARG_0_.nowMoveDist = _ARG_0_.nowMoveDist + _ARG_0_.Speed
          end
          if Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.StartPos) > 40 then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        end
      end
    },
    ScratichFast1 = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":Scratich1\n")
        _ARG_0_.step = 1
        Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
        _UPVALUE0_:sety(0)
        Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.workStep = 0
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.gameSpeed = _ARG_0_.gameSpeed + 0.1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.gameSpeed > 1 then
          _ARG_0_.gameSpeed = 1
        end
        Script.SetPlaySpeed(_ARG_0_.gameSpeed)
        if _ARG_0_.workStep < 3 then
          _ARG_0_.workStep = _ARG_0_.workStep + 1
          Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
          _UPVALUE0_:sety(Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle))
          Entity.SetRot(_ARG_0_.myHandle, _UPVALUE0_)
        end
        _ARG_0_:setRootMove(2)
        print("nowframe = " .. Entity.GetMotionNowFrame(_ARG_0_.myHandle) .. "\n")
        if Entity.IsMotionEnd(_ARG_0_.myHandle) or Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 20 then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    ScratichFast11 = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":Scratich1\n")
        _ARG_0_.step = 1
        _ARG_0_:setMotionNoCheck(_UPVALUE0_, 1, -1)
        Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
        _UPVALUE1_:sety(0)
        Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE1_)
        _ARG_0_.workStep = 0
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.gameSpeed = _ARG_0_.gameSpeed + 0.1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.gameSpeed > 1 then
          _ARG_0_.gameSpeed = 1
        end
        Script.SetPlaySpeed(_ARG_0_.gameSpeed)
        if _ARG_0_.workStep < 3 then
          _ARG_0_.workStep = _ARG_0_.workStep + 1
          Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
          _UPVALUE0_:sety(Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle))
          Entity.SetRot(_ARG_0_.myHandle, _UPVALUE0_)
        end
        _ARG_0_:setRootMove(2)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) or Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 20 then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Scratich1 = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":Scratich1\n")
        _ARG_0_.step = 1
        _ARG_0_:setMotionNoCheck(_UPVALUE0_, 1, -1)
        Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
        _UPVALUE1_:sety(0)
        Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE1_)
        _ARG_0_.workStep = 0
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.gameSpeed = _ARG_0_.gameSpeed + 0.1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.gameSpeed > 1 then
          _ARG_0_.gameSpeed = 1
        end
        Script.SetPlaySpeed(_ARG_0_.gameSpeed)
        if _ARG_0_.workStep < 3 then
          _ARG_0_.workStep = _ARG_0_.workStep + 1
          Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
          _UPVALUE0_:sety(Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle))
          Entity.SetRot(_ARG_0_.myHandle, _UPVALUE0_)
        end
        if _ARG_0_.HitAttackFlag == 0 then
          _ARG_0_:setRootMove(3)
        else
          _ARG_0_:setRootMove(2)
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) or Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 20 then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Scratich11 = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":Scratich11\n")
        _ARG_0_.step = 0
        _ARG_0_:setMotionNoCheck(_UPVALUE0_, 1, -1)
        Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
        _UPVALUE1_:sety(0)
        Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE1_)
        _ARG_0_.workStep = 0
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.gameSpeed = _ARG_0_.gameSpeed + 0.1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.gameSpeed > 1 then
          _ARG_0_.gameSpeed = 1
        end
        Script.SetPlaySpeed(_ARG_0_.gameSpeed)
        if _ARG_0_.workStep < 3 then
          _ARG_0_.workStep = _ARG_0_.workStep + 1
          Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
          _UPVALUE0_:sety(Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle))
          Entity.SetRot(_ARG_0_.myHandle, _UPVALUE0_)
        end
        _ARG_0_:setRootMove(3)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) or Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 20 then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    TailAttack1 = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":TailAttack1\n")
        Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
        _UPVALUE0_:sety(0)
        Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_:setMotionNoCheck(_UPVALUE1_)
        if Entity.IsTargetFront(_ARG_0_.myHandle, _ARG_0_.targetHandle) then
          _ARG_0_.step = 0
        else
          _ARG_0_.step = 1
        end
        if _ARG_0_:WhichRightandLeft() == 0 then
          _ARG_0_.workStep = 0
        else
          _ARG_0_.workStep = 1
        end
        _ARG_0_:setMotion(_UPVALUE2_, 1, -1)
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.gameSpeed = _ARG_0_.gameSpeed + 0.1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.gameSpeed > 1 then
          _ARG_0_.gameSpeed = 1
        end
        Script.SetPlaySpeed(_ARG_0_.gameSpeed)
        if _ARG_0_.step == 0 or _ARG_0_.step == 1 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 3 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) < 22 then
            if _ARG_0_.step == 0 then
              _ARG_0_:Rotation2(0)
            else
              _ARG_0_:Rotation2(1)
            end
          end
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 22 then
            Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          end
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        end
      end
    },
    Battole1SparNova = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":Battole1SparNova\n")
        _ARG_0_:setMotion(_UPVALUE0_)
        _ARG_0_.step = 0
        _ARG_0_.shootStep = Script.RandomInteger(3)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 0 then
            _ARG_0_.step = 1
            if _ARG_0_.shootStep == 2 then
              _ARG_0_.neckAngle = 10
            elseif _ARG_0_.shootStep == 1 then
              _ARG_0_.neckAngle = 0
            else
              _ARG_0_.neckAngle = -10
            end
            _ARG_0_:CreateNovaGiant(_ARG_0_.myHandle, _ARG_0_.neckAngle)
            _ARG_0_:cameraEnd()
          end
        elseif _ARG_0_.step == 1 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        elseif _ARG_0_.step == 2 then
        end
      end
    },
    Battole1SparNovaDwarf = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":Battole1SparNova\n")
        _ARG_0_:setMotion(_UPVALUE0_)
        _ARG_0_.step = 0
        _ARG_0_.shootStep = Script.RandomInteger(3)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 0 then
            _ARG_0_.step = 1
            if _ARG_0_.shootStep == 2 then
              _ARG_0_.neckAngle = 10
            elseif _ARG_0_.shootStep == 1 then
              _ARG_0_.neckAngle = 0
            else
              _ARG_0_.neckAngle = -10
            end
            _ARG_0_:CreateNovaGiantDwarf(_ARG_0_.myHandle, _ARG_0_.neckAngle)
            _ARG_0_:cameraEnd()
          end
        elseif _ARG_0_.step == 1 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        elseif _ARG_0_.step == 2 then
        end
      end
    },
    NextBattleSetup = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":NextBattleSetup\n")
        Script.StartFadeOut(20, false)
        _ARG_0_.step = -2
        Entity.EnableBgColl(_ARG_0_.myHandle, 1)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        _ARG_0_:OutEyeLight()
        _ARG_0_:SetEyeLight2()
        Player.NotifyEventStart(_ARG_0_.targetHandle)
        Entity.SetupModelFade(_ARG_0_.myHandle, 1, 1, 1)
        _ARG_0_:setMotionNoCheck(_UPVALUE0_, 1, 1)
        _ARG_0_.fogOnFlag = 0
        Script.SetPlaySpeed(1)
        Script.DisablePauseChecker()
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
        Entity.EnableBgColl(_ARG_0_.myHandle, 1)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        Player.NotifyEventEnd(_ARG_0_.targetHandle)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
        _ARG_0_:OutEyeLight()
        _ARG_0_.AttackFlag = 0
        Script.EnablePauseChecker()
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.cameraTimer = _ARG_0_.cameraTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
        if Entity.GetCurrentMotion(_ARG_0_.myHandle) == Entity.GetMotionIndex(_ARG_0_.myHandle, "012") then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 28 and _ARG_0_.fogOnFlag == 0 then
            _ARG_0_.fogOnFlag = 1
          end
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 27 and _ARG_0_.FadeOutFlag == 0 then
            print("\131A\131^\131b\131`\130\179\130\234\130\196\130\162\130\233\131G\131t\131F\131N\131g\130\240\131t\131F\129[\131h\131A\131E\131g\n")
            Entity.FadeoutEffectAttach(_ARG_0_.myHandle, 10, -1)
            Entity.SetEffectAttach(_ARG_0_.myHandle, 1, "012", 2)
            _ARG_0_.FadeOutFlag = 1
          end
        end
        if _ARG_0_.fogOnFlag == 1 then
          _UPVALUE0_ = _UPVALUE0_ + 1
          if _UPVALUE0_ > _UPVALUE1_ then
            _UPVALUE0_ = _UPVALUE1_
          end
          _UPVALUE2_ = _UPVALUE2_ + 8
          if _UPVALUE2_ > _UPVALUE3_ then
            _UPVALUE2_ = _UPVALUE3_
          end
          _UPVALUE4_:set(0, 0, 0)
          Script.SettingFog(_UPVALUE4_, _UPVALUE0_, _UPVALUE2_)
          Script.SetFogAlpha(0)
        end
        if -1 <= _ARG_0_.step then
          Entity.GetWorldPos(_UPVALUE5_, Player.GetHandle())
          _UPVALUE6_:set(1.999, _UPVALUE5_:gety(), 7.418)
          _UPVALUE7_:set(0, 0, 0)
          Entity.SetLocalPos(Player.GetHandle(), _UPVALUE6_)
          Entity.SetOldLocalPos(Player.GetHandle(), _UPVALUE6_)
          _UPVALUE7_:sety(RoundPI(DegToRad(230)))
          Entity.SetRot(Player.GetHandle(), _UPVALUE7_)
          _UPVALUE6_:set(-4.192, 0, -3.894)
          Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE6_)
          Entity.SetOldLocalPos(_ARG_0_.myHandle, _UPVALUE6_)
          _UPVALUE7_:set(0, DegToRad(370), 0)
          Entity.SetRot(_ARG_0_.myHandle, _UPVALUE7_)
        end
        if _ARG_0_.step == -2 then
          if Script.IsEndFadeOut() then
            _ARG_0_:DeleteCamera()
            Player.ResetCamera()
            _ARG_0_.cameraStep = _UPVALUE8_
            Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_.cameraTimer)
            DeleteFisheyeLens(_ARG_0_.myHandle)
            Script.StartFadeIn(20, false)
            _ARG_0_.step = -1
            _ARG_0_.camera = Camera.CreateExusiaCamera(_UPVALUE9_[1].name)
            Camera.StartExusiaCamera(_ARG_0_.camera)
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE9_[1].endtime)
          end
        elseif _ARG_0_.step == -1 then
          if Script.IsEndFadeIn() then
            _ARG_0_.step = 0
            _ARG_0_.cameraTimer = 15
            _ARG_0_.cameraFlag = 0
          end
        elseif _ARG_0_.step == 0 then
          if _ARG_0_.cameraTimer < 0 and _ARG_0_.cameraFlag == 0 then
            _ARG_0_.cameraFlag = 1
          end
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_.step = 1
            Script.OutTask(_ARG_0_.camera)
            _ARG_0_.camera = Camera.CreateExusiaCamera(_UPVALUE9_[_ARG_0_.step + 1].name)
            Camera.StartExusiaCamera(_ARG_0_.camera)
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE9_[_ARG_0_.step + 1].endtime)
            _ARG_0_.cameraFlag = 0
            _ARG_0_:setMotion(_UPVALUE10_, 1, 1)
          end
        elseif _ARG_0_.step == 1 then
          if not Entity.IsMotionEnd(_ARG_0_.myHandle) or _ARG_0_.cameraFlag == 0 then
          end
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_.step = 2
            Script.OutTask(_ARG_0_.camera)
            _ARG_0_.camera = Camera.CreateExusiaCamera(_UPVALUE9_[_ARG_0_.step + 1].name)
            Camera.StartExusiaCamera(_ARG_0_.camera)
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE9_[_ARG_0_.step + 1].endtime)
            _ARG_0_.cameraFlag = 0
          end
        elseif _ARG_0_.step == 2 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_.step = 4
            Script.StartFadeOut(20, false)
            _ARG_0_.cameraFlag = 1
          end
          if Entity.IsMotionEnd(_ARG_0_.myHandle) and _ARG_0_.cameraFlag == 0 then
            Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE11_, 0, 0, -1, 8)
            _ARG_0_:changeTexAnim()
          end
        elseif _ARG_0_.step == 3 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_.step = 4
            Script.OutTask(_ARG_0_.camera)
          end
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE11_, 0, 0, -1, 8)
            _ARG_0_:changeTexAnim()
          end
        elseif _ARG_0_.step == 4 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE11_, 0, 0, -1, 8)
            _ARG_0_:changeTexAnim()
          end
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_.step = 5
          end
        elseif _ARG_0_.step == 5 then
          if Script.IsEndFadeOut() then
            Script.StartFadeIn(20, false)
            _ARG_0_.step = 6
            Script.OutTask(_ARG_0_.camera)
            _UPVALUE4_:set(0, 0, 0)
            Script.SettingFog(_UPVALUE4_, _UPVALUE1_, _UPVALUE3_)
            Script.SetFogAlpha(0)
            _ARG_0_.fogOnFlag = 0
            Entity.SetupModelFade(_ARG_0_.targetHandle, 0, 1, 1)
          end
        elseif _ARG_0_.step == 6 and Script.IsEndFadeIn() then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    Idling = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":Idling\n")
        _ARG_0_:setMotion(_UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_ + Script.Random() * _UPVALUE1_)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        Entity.EnableBgColl(_ARG_0_.myHandle, 1)
        if _ARG_0_.AttackTimer <= 0 and _ARG_0_.AttackFlag == 1 then
          _ARG_0_.AttackTimer = 60 * Script.RandomInRange(_UPVALUE2_, _UPVALUE3_)
        end
        _ARG_0_.isDamageAfter = 0
        Entity.EnableBgColl(_ARG_0_.myHandle, 1)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        Entity.SetupModelFade(_ARG_0_.myHandle, 1, 1, 1)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _UPVALUE0_ == 1 then
          _ARG_0_:GotoState("Idling1")
          return
        end
        if _ARG_0_.AttackFlag == 1 then
          if _UPVALUE1_ == 1 then
            _ARG_0_:SettingsStateToBattole2Attack50Under()
          else
            _ARG_0_:SettingsStateToBattole2Attack()
          end
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          _ARG_0_.AttackFlag = 0
          return
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:SettingsStateToBattole2Move()
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Idling2 = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":Idling2\n")
        _ARG_0_:setMotion(_UPVALUE0_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
      end
    },
    BattleIdlingC = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":BattleIdlingC\n")
        _ARG_0_:setMotion(_UPVALUE0_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _UPVALUE0_ == 1 and _UPVALUE1_ == 1 then
          _ARG_0_:SettingsStateToBattole2Attack50Under()
        else
          _ARG_0_:SettingsStateToBattole2Attack()
        end
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      end
    },
    RightAndLeftMove2 = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":RightAndLeftMove2\n")
        if _ARG_0_:WhichRightandLeft() == 0 then
          _ARG_0_:setMotion(_UPVALUE0_)
          _ARG_0_.step = 1
        else
          _ARG_0_:setMotion(_UPVALUE1_)
          _ARG_0_.step = 0
        end
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE2_ + Script.Random() * _UPVALUE2_)
        _ARG_0_.trunAngle = 0
        _ARG_0_:CreaeVisions()
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        _ARG_0_:DeleteVisions()
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          _ARG_0_:MoveLeftOrRight(-_UPVALUE0_, 0.1)
        elseif _ARG_0_.step == 1 then
          _ARG_0_:MoveLeftOrRight(_UPVALUE0_, 0.1)
        end
        if _ARG_0_.trunAngle > _UPVALUE1_ then
          _ARG_0_.trunAngle = _UPVALUE1_
        else
          _ARG_0_.trunAngle = _ARG_0_.trunAngle + 0.5
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, _ARG_0_.trunAngle)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    RightAndLeftStep2 = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":RightAndLeftStep2\n")
        if _ARG_0_:WhichRightandLeft() == 0 then
          _ARG_0_:setMotion(_UPVALUE0_)
          _ARG_0_.step = 1
        else
          _ARG_0_:setMotion(_UPVALUE1_)
          _ARG_0_.step = 0
        end
        _ARG_0_.trunAngle = 0
        _ARG_0_:CreaeVisions()
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        _ARG_0_:DeleteVisions()
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          _ARG_0_:MoveLeftOrRight(_UPVALUE0_, 0.1)
        elseif _ARG_0_.step == 1 then
          _ARG_0_:MoveLeftOrRight(-_UPVALUE0_, 0.1)
        end
        if _ARG_0_.trunAngle > _UPVALUE1_ then
          _ARG_0_.trunAngle = _UPVALUE1_
        else
          _ARG_0_.trunAngle = _ARG_0_.trunAngle + 5.5
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, _ARG_0_.trunAngle)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > 289 then
            print("\131X\131b\131e\131v\130\204\130\160\130\198\130\197\139\151\151\163\130\240\138m\148F\130\181\130\189\130\231\130\191\130\229\130\193\130\198\137\147\130\162\130\193\130\219\130\162.\n")
            _ARG_0_.nextState = _ARG_0_.stack:pop(1)
            if _ARG_0_.nextState == "TailAttack" then
              print("\142\159\130\205\144K\148\246\141U\140\130\130\190\130\169\130\231\n")
              _ARG_0_.stack:push(_ARG_0_.nextState)
              if Script.Random() < 0.5 then
                _ARG_0_.stack:push("JumpBite")
                print("\130\169\130\221\130\194\130\171\130\197\n")
              else
                _ARG_0_.stack:push("ChainRoll")
                print("\131`\131F\131C\131\147\131\141\129[\131\139\130\197\n")
              end
              _ARG_0_.stack:push("RightAndLeftStep2")
              _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
            elseif _ARG_0_.nextState == "Scratich" or _ARG_0_.nextState == "Scratich_Left" or _ARG_0_.nextState == "Scratich_Right" then
              print("\136\248\130\193\145~\130\171\140n\130\190\130\169\130\231\131W\131\131\131\147\131v\138\154\130\221\130\194\130\171\130\240\130\181\130\196\130\169\130\231\129`\n")
              _ARG_0_.stack:push(_ARG_0_.nextState)
              _ARG_0_.stack:push("JumpBite")
              _ARG_0_.stack:push("RightAndLeftStep2")
              _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
              return
            else
              _ARG_0_:GotoState(_ARG_0_.nextState)
            end
          else
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        end
      end
    },
    BackStepInCenter = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":BackStepInCenter\n")
        _ARG_0_:setMotion(_UPVALUE0_)
        _ARG_0_.step = 0
        _ARG_0_:CreaeVisions()
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        _ARG_0_:DeleteVisions()
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if _ARG_0_.trunAngle > _UPVALUE0_ then
            _ARG_0_.trunAngle = _UPVALUE0_
          else
            _ARG_0_.trunAngle = _ARG_0_.trunAngle + 5.5
          end
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, _ARG_0_.trunAngle)
          _UPVALUE1_:set(0, 0, _UPVALUE2_)
          Entity.CalcVelocity(_ARG_0_.myHandle, _UPVALUE1_)
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        end
      end
    },
    BackStep = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":BackStep\n")
        _ARG_0_:setMotion(_UPVALUE0_)
        _ARG_0_.step = 0
        _ARG_0_:CreaeVisions()
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        _ARG_0_:DeleteVisions()
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if _ARG_0_.trunAngle > _UPVALUE0_ then
            _ARG_0_.trunAngle = _UPVALUE0_
          else
            _ARG_0_.trunAngle = _ARG_0_.trunAngle + 5.5
          end
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, _ARG_0_.trunAngle)
          _UPVALUE1_:set(0, 0, _UPVALUE2_)
          Entity.CalcVelocity(_ARG_0_.myHandle, _UPVALUE1_)
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        end
      end
    },
    Move = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":Move\n")
        _ARG_0_:setMotion(_UPVALUE0_)
        _ARG_0_.step = 0
        _ARG_0_.trunAngle = 0
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_ + Script.Random() * _UPVALUE1_)
        _ARG_0_:CreaeVisions()
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        _ARG_0_:DeleteVisions()
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:MoveEx(_UPVALUE0_, 1.1)
        if _ARG_0_.trunAngle > _UPVALUE1_ then
          _ARG_0_.trunAngle = _UPVALUE1_
        else
          _ARG_0_.trunAngle = _ARG_0_.trunAngle + 5.5
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, _ARG_0_.trunAngle)
        if Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE2_ then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    FeintJump = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":FeintJump\n")
        _ARG_0_:setMotion(_UPVALUE0_)
        _ARG_0_.step = _UPVALUE1_
        _ARG_0_.trunAngle = 0
        Entity.SetTimer(_ARG_0_.myHandle, 10)
        _ARG_0_:CreaeVisions()
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        _ARG_0_:DeleteVisions()
      end,
      OnUpdate = function(_ARG_0_)
        _UPVALUE0_:set(0, 0, 0)
        if _ARG_0_.step == _UPVALUE1_ then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 1 then
            _UPVALUE2_:set(0, 0, 15)
            Entity.GetWorldPos2(_UPVALUE2_, _ARG_0_.myHandle, _UPVALUE2_)
            _ARG_0_.step = _UPVALUE3_
            _ARG_0_.jumpYPow = 0.7
          end
        elseif _ARG_0_.step == _UPVALUE3_ then
          _UPVALUE0_:sety(_ARG_0_.jumpYPow)
          Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE0_)
          _ARG_0_.step = _UPVALUE4_
        elseif _ARG_0_.step == _UPVALUE4_ then
          _ARG_0_.jumpYPow = _ARG_0_.jumpYPow - 0.12 * Entity.GetFrameRate(_ARG_0_.myHandle)
          _UPVALUE0_:sety(_ARG_0_.jumpYPow)
          Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE0_)
          _UPVALUE5_:set(0, 0, _UPVALUE6_ * 3)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE5_)
          if Entity.IsGround(_ARG_0_.myHandle) then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE7_, 1)
            _ARG_0_.step = _UPVALUE8_
          end
        elseif _ARG_0_.step == _UPVALUE9_ then
          if Entity.IsGround(_ARG_0_.myHandle) then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE7_, 1)
            _ARG_0_.step = _UPVALUE8_
          end
        elseif _ARG_0_.step == _UPVALUE8_ and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    TrunPleyr = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":TrunPleyr\n")
        if _ARG_0_:WhichRightandLeft() == 0 then
          _ARG_0_:setMotion(_UPVALUE0_)
          _ARG_0_.step = 0
        else
          _ARG_0_:setMotion(_UPVALUE1_)
          _ARG_0_.step = 1
        end
        Entity.SetLOSBoneNum(_ARG_0_.myHandle, 28)
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
        _UPVALUE1_:set(0, 0, 1)
        Math.RotateVectorXYZ(_UPVALUE1_, _UPVALUE0_)
        Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.myHandle)
        Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.targetHandle)
        FVECTOR3.Sub(_UPVALUE2_, _UPVALUE2_, _UPVALUE3_)
        _UPVALUE2_:normalize()
        if _ARG_0_.step == 0 then
          _ARG_0_:MoveLeftOrRight(_UPVALUE4_, 0.1)
          _ARG_0_:Rotation(-1.1)
        else
          _ARG_0_:MoveLeftOrRight(-_UPVALUE4_, 0.1)
          _ARG_0_:Rotation(1.1)
        end
        _UPVALUE1_:set(0, 0, 1)
        if _ARG_0_:isFOV(DegToRad(20)) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Threat = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":Threat\n")
        _ARG_0_:setMotion(_UPVALUE0_)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        elseif _ARG_0_.step == 1 then
        elseif _ARG_0_.step == 2 then
        end
      end
    },
    JumpBite = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":JumpBite\n")
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 1)
        _ARG_0_.step = 0
        Entity.SetTimer(_ARG_0_.myHandle, 40)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:setRootMove(1)
        if _ARG_0_.step == 0 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            print("timeOver\n")
            if _ARG_0_:checkJumpBiteCancel() == 1 then
              return
            end
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_:setMotionNoCheck(_UPVALUE0_, 1, -1)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if Entity.GetMotionTotalFrame(_ARG_0_.myHandle) < 15 then
            Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          end
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            if _ARG_0_:isFOV(DegToRad(70)) then
              _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
            else
              _ARG_0_.stack:push("RightAndLeftStep2")
              _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
            end
          end
        end
      end
    },
    JumpBiteCancel = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":JumpBite\n")
        _ARG_0_.step = 0
        Entity.SetTimer(_ARG_0_.myHandle, 15)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        _UPVALUE0_:set(0, 0, 0)
        if _ARG_0_.step == _UPVALUE1_ then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 1 then
            _UPVALUE2_:set(0, 0, 15)
            Entity.GetWorldPos2(_UPVALUE2_, _ARG_0_.myHandle, _UPVALUE2_)
            _ARG_0_.step = _UPVALUE3_
            _ARG_0_.jumpYPow = 0.7
          end
        elseif _ARG_0_.step == _UPVALUE3_ then
          _UPVALUE0_:sety(_ARG_0_.jumpYPow)
          Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE0_)
          _ARG_0_.step = _UPVALUE4_
        elseif _ARG_0_.step == _UPVALUE4_ then
          _ARG_0_.jumpYPow = _ARG_0_.jumpYPow - 0.1 * Entity.GetFrameRate(_ARG_0_.myHandle)
          _UPVALUE0_:sety(_ARG_0_.jumpYPow)
          Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE0_)
          _UPVALUE5_:set(0, 0, _UPVALUE6_ * 3)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE5_)
          if Entity.IsGround(_ARG_0_.myHandle) then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE7_, 1)
            _ARG_0_.step = _UPVALUE8_
          end
        elseif _ARG_0_.step == _UPVALUE9_ then
          if Entity.IsGround(_ARG_0_.myHandle) then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE7_, 1)
            _ARG_0_.step = _UPVALUE8_
          end
        elseif _ARG_0_.step == _UPVALUE8_ and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Rush = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":Rush\n")
        _ARG_0_:setMotion(_UPVALUE0_)
        _ARG_0_.step = 0
        Entity.SetTimer(_ARG_0_.myHandle, 60)
        _ARG_0_.Speed = 0
        Entity.GetWorldPos(_ARG_0_.StartPos, _ARG_0_.myHandle)
        _ARG_0_.nowMoveDist = 0
        _ARG_0_.HitAttackFlag = 0
        _ARG_0_.workStep = _ARG_0_.workStep - 1
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 or _ARG_0_.step == 1 then
          _ARG_0_.workTimer = _ARG_0_.workTimer - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 > _ARG_0_.workTimer then
            _ARG_0_:CreateRushAttackColl(2)
            _ARG_0_:CreateRushAttackColl(-2)
            _ARG_0_.workTimer = 6
          end
        end
        if _ARG_0_.step == 0 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 33 then
            _ARG_0_:MoveEx(_UPVALUE0_, 0.1)
            _ARG_0_.nowMoveDist = _ARG_0_.nowMoveDist + _ARG_0_.Speed
          end
          if _ARG_0_.nowMoveDist > 10 or Entity.IsWall(_ARG_0_.myHandle) and _ARG_0_.nowMoveDist > 4 then
            Entity.GetWorldPos(_ARG_0_.StartPos, _ARG_0_.myHandle)
            _ARG_0_.step = 1
            _ARG_0_.nowMoveDist = 0
          end
        elseif _ARG_0_.step == 1 then
          _ARG_0_.nowMoveDist = _ARG_0_.nowMoveDist + _ARG_0_.Speed
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          _ARG_0_:MoveEx(_UPVALUE0_, 0.1)
          _ARG_0_.nowMoveDist = _ARG_0_.nowMoveDist + _ARG_0_.Speed
          if _ARG_0_.nowMoveDist > 35 or _ARG_0_.HitAttackFlag == 1 or Entity.IsWall(_ARG_0_.myHandle) then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.nextState = _ARG_0_.stack:pop(1)
            if Script.Random() <= _UPVALUE1_ then
              _ARG_0_.stack:push("BattleIdlingC")
              _ARG_0_.stack:push("ChainRoll")
              _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
              return
            end
            if 1 <= _ARG_0_.workStep then
              _ARG_0_:GotoState(_ARG_0_.nextState)
              return
            end
            _ARG_0_.nowMoveDist = 0
            _ARG_0_:setMotion(_UPVALUE2_)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            if Script.IsDebugCheckAttack() then
              _ARG_0_.stack:push("Idling")
              _ARG_0_:GotoState("RightAndLeftStep2")
              return
            end
            if _ARG_0_:isFOV(DegToRad(70)) then
              _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
            else
              _ARG_0_.stack:push("RightAndLeftStep2")
              _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
            end
          end
        elseif _ARG_0_.step == 3 then
        end
      end
    },
    Scratich = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":Scratich\n")
        if _ARG_0_:WhichRightandLeft() == 0 then
          _ARG_0_:setMotion(_UPVALUE0_, 1, -1)
          _ARG_0_.step = 0
        else
          _ARG_0_:setMotion(_UPVALUE1_, 1, -1)
          _ARG_0_.step = 1
        end
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 2)
        _ARG_0_:setRootMove(1)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Scratich_Left = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":Scratich_Left\n")
        _ARG_0_:setMotion(_UPVALUE0_, 1, -1)
        _UPVALUE1_[0].attack = Scratich_Left
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 4)
        _ARG_0_:setRootMove(1)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          if Script.Random() < _UPVALUE0_ then
            _ARG_0_.stack:push("Idling")
            if Script.Random() < 0.4 or Entity.IsFrontWall(_ARG_0_.myHandle, 12, 1) == false then
              print("\136\248\130\193\145~\130\171\140\227\130\204\141s\147\174\130\240\131t\131F\131C\131\147\131g\131W\131\131\131\147\131v\130\169\130\231\130\181\130\193\130\219\141U\140\130\130\201\130\183\130\233.\n")
              _ARG_0_.stack:push("TailAttack")
              _ARG_0_.stack:push("FeintJump")
            elseif Script.Random() < 0.5 then
              print("\136\248\130\193\145~\130\171\140\227\130\204\141s\147\174\130\240BackStepFromChainRoll\130\201\130\183\130\233.\n")
              _ARG_0_.stack:push("BackStepFromChainRoll")
            else
              print("\136\248\130\193\145~\130\171\140\227\130\204\141s\147\174\130\240\131m\131\148\131@\130\201\130\183\130\233.\n")
              if _ARG_0_:checkRate(12, 0) == 1 then
              elseif _ARG_0_:checkRate(12, 0) == 2 then
              else
              end
              print("\131m\131\148\131@\131W\131\131\131C\131A\131\147\131g\130\240" .. 2 + 1 .. "\137\241\130\183\130\233.\n")
              for _FORV_6_ = 0, 2 do
                _ARG_0_:checkChainRollOnly()
                if Script.Random() < 0.3 then
                  _ARG_0_.stack:push("SparNova")
                else
                  _ARG_0_.stack:push("SparNovaDwarf")
                end
              end
              _ARG_0_.shootStep = 0
              _ARG_0_.stack:push("BackStep")
            end
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          else
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        end
      end
    },
    Scratich_Right = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":Scratich_Right\n")
        _ARG_0_:setMotion(_UPVALUE0_, 1, -1)
        _ARG_0_.step = 0
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 4)
        _ARG_0_:setRootMove(1)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          if Script.Random() < _UPVALUE0_ then
            _ARG_0_.stack:push("Idling")
            if Script.Random() < 0.4 or Entity.IsFrontWall(_ARG_0_.myHandle, 12, 1) == false then
              _ARG_0_.stack:push("TailAttack")
              _ARG_0_.stack:push("FeintJump")
            elseif Script.Random() < 0.5 then
              _ARG_0_.stack:push("BackStepFromChainRoll")
            else
              if _ARG_0_:checkRate(12, 0) == 1 then
              elseif _ARG_0_:checkRate(12, 0) == 2 then
              else
              end
              print("\131m\131\148\131@\131W\131\131\131C\131A\131\147\131g\130\240" .. 2 + 1 .. "\137\241\130\183\130\233.\n")
              for _FORV_6_ = 0, 2 do
                _ARG_0_:checkChainRollOnly()
                if Script.Random() < 0.3 then
                  _ARG_0_.stack:push("SparNova")
                else
                  _ARG_0_.stack:push("SparNovaDwarf")
                end
              end
              _ARG_0_.shootStep = 0
              _ARG_0_.stack:push("BackStep")
            end
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          else
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        end
      end
    },
    TailAttack = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":TailAttack\n")
        if Entity.IsTargetFront(_ARG_0_.myHandle, _ARG_0_.targetHandle) then
          _ARG_0_.step = 0
        else
          _ARG_0_.step = 1
        end
        if _ARG_0_:WhichRightandLeft() == 0 then
          _ARG_0_.workStep = 0
        else
          _ARG_0_.workStep = 1
        end
        _ARG_0_:setMotion(_UPVALUE0_, 1, -1)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 or _ARG_0_.step == 1 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 3 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) < 22 then
            if _ARG_0_.step == 0 then
              _ARG_0_:Rotation2(0)
            else
              _ARG_0_:Rotation2(1)
            end
          end
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            if _ARG_0_:isFOV(DegToRad(70)) then
              _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
            else
              _ARG_0_.stack:push("RightAndLeftStep2")
              _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
            end
          end
        end
      end
    },
    ChainRoll = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":ChainRoll\n")
        _ARG_0_.step = 0
        _UPVALUE0_:set(0, 0, 0)
        if Script.Random() < 0.25 then
          print("if rnd < 0.25 then\n")
          _ARG_0_:setMotion(_UPVALUE1_)
          Entity.SetTimer(_ARG_0_.myHandle, 20)
          _UPVALUE0_:setx(0.3)
        elseif Script.Random() < 0.5 then
          print("elseif rnd < 0.5 then\n")
          _ARG_0_:setMotion(_UPVALUE2_)
          Entity.SetTimer(_ARG_0_.myHandle, 20)
          _UPVALUE0_:setx(-0.3)
        elseif Script.Random() < 0.75 then
          print("elseif rnd < 0.75 then\n")
          _ARG_0_:setMotion(_UPVALUE3_)
          Entity.SetTimer(_ARG_0_.myHandle, 20)
          _UPVALUE0_:setz(0.3)
        else
          print("else\n")
          _ARG_0_:setMotion(_UPVALUE4_)
          Entity.SetTimer(_ARG_0_.myHandle, 20)
          _UPVALUE0_:setz(-0.3)
        end
        Entity.SetMotionSpeed(_ARG_0_.myHandle, 0.8)
        _UPVALUE5_:set(0, 0, 5)
        Entity.GetWorldPos2(_UPVALUE5_, _ARG_0_.myHandle, _UPVALUE5_)
        Entity.GetRot(_UPVALUE6_, _ARG_0_.myHandle)
        _UPVALUE0_:sety(0.1)
        Math.RotateVectorXYZ(_UPVALUE0_, _UPVALUE6_)
        Entity.CalcVelocity(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
        _ARG_0_.chainGrand1 = NULL_HANDLE
        _ARG_0_.chainGrand2 = NULL_HANDLE
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_.step = 1
            _ARG_0_:setMotion(_UPVALUE0_, 1, -1)
            Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
            _ARG_0_.targetPos:sety(_ARG_0_.targetPos:gety() + 3)
            Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
            Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
          end
        elseif _ARG_0_.step == 1 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 5 then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("RightAndLeftStep2")
        end
      end
    },
    BackStepFromChainRoll = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":ChainRoll\n")
        _ARG_0_.step = 0
        _UPVALUE0_:set(0, 0, 0)
        _ARG_0_:setMotion(_UPVALUE1_)
        Entity.SetTimer(_ARG_0_.myHandle, 20)
        _UPVALUE0_:setz(-0.35)
        Entity.SetMotionSpeed(_ARG_0_.myHandle, 0.8)
        _UPVALUE2_:set(0, 0, 5)
        Entity.GetWorldPos2(_UPVALUE2_, _ARG_0_.myHandle, _UPVALUE2_)
        Entity.GetRot(_UPVALUE3_, _ARG_0_.myHandle)
        _UPVALUE0_:sety(0.1)
        Math.RotateVectorXYZ(_UPVALUE0_, _UPVALUE3_)
        Entity.CalcVelocity(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
        _ARG_0_.chainGrand1 = NULL_HANDLE
        _ARG_0_.chainGrand2 = NULL_HANDLE
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_.step = 1
            _ARG_0_:setMotion(_UPVALUE0_, 1, -1)
            Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
            _ARG_0_.targetPos:sety(_ARG_0_.targetPos:gety() + 3)
            Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
            Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
          end
        elseif _ARG_0_.step == 1 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 5 then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("RightAndLeftStep2")
        end
      end
    },
    SparNova = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":SparNova\n")
        _ARG_0_:setMotion(_UPVALUE0_, 1, 1)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        _ARG_0_.shootStep = _ARG_0_.shootStep + 1
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 10 then
            _ARG_0_.step = 1
            print("self.shootStep = " .. _ARG_0_.shootStep .. "\n")
            if _ARG_0_.shootStep == 2 then
              if Script.Random() < 0.5 then
                _ARG_0_.neckAngle = 30
              else
                _ARG_0_.neckAngle = -30
              end
            elseif _ARG_0_.shootStep == 1 then
              _ARG_0_.neckAngle = 0
            elseif Script.Random() < 0.5 then
              _ARG_0_.neckAngle = 30
            else
              _ARG_0_.neckAngle = -30
            end
            _ARG_0_:CreateNovaGiant(_ARG_0_.myHandle, _ARG_0_.neckAngle)
          end
        elseif _ARG_0_.step == 1 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        elseif _ARG_0_.step == 2 then
        end
      end
    },
    SparNovaDwarf = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":SparNova\n")
        _ARG_0_:setMotion(_UPVALUE0_, 2, 2)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 10 then
            _ARG_0_.step = 1
            print("self.shootStep = " .. _ARG_0_.shootStep .. "\n")
            if _ARG_0_.shootStep == 2 then
              if Script.Random() < 0.5 then
                _ARG_0_.neckAngle = 30
              else
                _ARG_0_.neckAngle = -30
              end
            elseif _ARG_0_.shootStep == 1 then
              _ARG_0_.neckAngle = 0
            elseif Script.Random() < 0.5 then
              _ARG_0_.neckAngle = 30
            else
              _ARG_0_.neckAngle = -30
            end
            _ARG_0_:CreateNovaGiantDwarf(_ARG_0_.myHandle, _ARG_0_.neckAngle)
          end
        elseif _ARG_0_.step == 1 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        elseif _ARG_0_.step == 2 then
        end
      end
    },
    ToPhantom = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":NextBattleSetup\n")
        Script.StartFadeOut(20, false)
        _ARG_0_.step = -2
        Entity.EnableBgColl(_ARG_0_.myHandle, 1)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
        Entity.EnableLockon(_ARG_0_.myHandle, 0)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        _ARG_0_:SetEyeLight()
        Player.NotifyEventStart(_ARG_0_.targetHandle)
        Entity.SetupModelFade(_ARG_0_.myHandle, 1, 1, 1)
        _ARG_0_:setMotionNoCheck(_UPVALUE0_)
        Entity.SetAnimNowFrame(_ARG_0_.myHandle, 90)
        _ARG_0_.fogOnFlag = 0
        _UPVALUE1_ = 1
        Script.DisablePauseChecker()
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableBgColl(_ARG_0_.myHandle, 1)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        Entity.EnableLockon(_ARG_0_.myHandle, 1)
        Player.NotifyEventEnd(_ARG_0_.targetHandle)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
        _ARG_0_.AttackFlag = 0
        Script.EnablePauseChecker()
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.cameraTimer = _ARG_0_.cameraTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.step >= -1 then
          _UPVALUE0_:set(0, 0, 0)
          Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE0_)
          Entity.SetOldLocalPos(_ARG_0_.myHandle, _UPVALUE0_)
          _UPVALUE1_:set(0, DegToRad(370), 0)
          Entity.SetRot(_ARG_0_.myHandle, _UPVALUE1_)
        end
        if _ARG_0_.step == -2 then
          if Script.IsEndFadeOut() then
            _ARG_0_:DeleteCamera()
            Player.ResetCamera()
            _ARG_0_.cameraStep = _UPVALUE2_
            Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_.cameraTimer)
            DeleteFisheyeLens(_ARG_0_.myHandle)
            Script.StartFadeIn(20, false)
            _ARG_0_.step = -1
            _ARG_0_.camera = Camera.CreateExusiaCamera(_UPVALUE3_[1].name)
            Camera.StartExusiaCamera(_ARG_0_.camera)
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE3_[1].endtime)
            Script.SetSceneColor(1, 1, 1, 1, 0, 1, OBJ_BIT_PLAYER)
          end
        elseif _ARG_0_.step == -1 then
          if Script.IsEndFadeIn() then
            _ARG_0_.step = 0
            _ARG_0_.cameraTimer = 15
            _ARG_0_.cameraFlag = 0
          end
        elseif _ARG_0_.step == 0 then
          if _ARG_0_.cameraTimer < 0 and _ARG_0_.cameraFlag == 0 then
            _ARG_0_.cameraFlag = 1
          end
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_.step = 1
            Script.OutTask(_ARG_0_.camera)
            _ARG_0_.camera = Camera.CreateExusiaCamera(_UPVALUE3_[_ARG_0_.step + 1].name)
            Camera.StartExusiaCamera(_ARG_0_.camera)
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE3_[_ARG_0_.step + 1].endtime)
            _ARG_0_.cameraFlag = 0
            _ARG_0_:setMotion(_UPVALUE4_)
            _UPVALUE5_ = 1
            _UPVALUE6_:set(0, 0, 0)
            if _ARG_0_.fantomFilter == NULL_HANDLE then
              _ARG_0_.fantomFilter = Entity.SetEffect(_ARG_0_.myHandle, "b02ex00", "B039_FTM_FLT0_0", _UPVALUE6_, _UPVALUE6_)
            end
            print("\131J\131\129\131\137\130\201\131G\131t\131F\131N\131g\131A\131^\131b\131`\n")
            _UPVALUE7_:set(0, 0, 0)
            _UPVALUE6_:set(0, 0, 0)
            Entity.SetEffect(_ARG_0_.myHandle, "b02ex00", "B039_FTM_FOG1_0", _UPVALUE7_, _UPVALUE6_)
            _ARG_0_.cameraFlag = 0
          end
        elseif _ARG_0_.step == 1 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_.cameraFlag = 1
            _ARG_0_:setMotion(_UPVALUE8_)
          end
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_.step = 2
            Script.StartFadeOut(20, false)
            _ARG_0_.cameraFlag = 1
          end
        elseif _ARG_0_.step == 2 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_.cameraFlag = 1
            _ARG_0_:setMotion(_UPVALUE8_)
          end
          if Script.IsEndFadeOut() then
            Script.StartFadeIn(20, false)
            _ARG_0_.step = 6
            Script.OutTask(_ARG_0_.camera)
            Script.SetSceneColor(1, 1, 1, 1, 1, 1, OBJ_BIT_PLAYER)
          end
        elseif _ARG_0_.step == 3 then
        elseif _ARG_0_.step == 4 then
        elseif _ARG_0_.step == 5 then
        elseif _ARG_0_.step == 6 and Script.IsEndFadeIn() then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    Fantom = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":Fantom\n")
        _ARG_0_:setMotion(_UPVALUE0_)
        _ARG_0_.step = 0
        _UPVALUE1_ = 1
        _UPVALUE2_:set(0, 0, 0)
        if _ARG_0_.fantomFilter == NULL_HANDLE then
          _ARG_0_.fantomFilter = Entity.SetEffect(_ARG_0_.myHandle, "b02ex00", "B039_FTM_FLT0_0", _UPVALUE2_, _UPVALUE2_)
        end
        print("\131J\131\129\131\137\130\201\131G\131t\131F\131N\131g\131A\131^\131b\131`\n")
        _UPVALUE3_:set(0, 0, 0)
        _UPVALUE2_:set(0, 0, 0)
        Entity.SetEffect(_ARG_0_.myHandle, "b02ex00", "B039_FTM_FOG1_0", _UPVALUE3_, _UPVALUE2_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        elseif _ARG_0_.step == 1 then
        elseif _ARG_0_.step == 2 then
        end
      end
    },
    FantomAttack = {
      OnBeginState = function(_ARG_0_)
        print("fantomID = " .. _ARG_0_.fantomID .. " " .. Entity.GetName(_ARG_0_.myHandle) .. ":FantomAttack\n")
        _ARG_0_.step = 0
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
        _ARG_0_.FantomHandleList[0].handle = _ARG_0_.myHandle
        _ARG_0_:CreateFantom(1)
        if _ARG_0_:checkRate(21, 0) == 1 then
        elseif _ARG_0_:checkRate(21, 0) == 2 then
        else
        end
        _ARG_0_.workStep = 2
        _ARG_0_.workStep = 2
        _ARG_0_.motionEndFlag = 0
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
        Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:setRootMove(0)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) and _ARG_0_.motionEndFlag == 0 then
          _ARG_0_:setMotion(_UPVALUE0_)
          _ARG_0_.motionEndFlag = 1
        end
        if _ARG_0_.step == 0 then
          _ARG_0_.step = 1
          _ARG_0_.workStep = _ARG_0_.workStep - 1
          if 0 > _ARG_0_.workStep then
            _ARG_0_.step = 3
            Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
          end
        elseif _ARG_0_.step == 1 then
          if _UPVALUE1_[1].endFlag == 1 then
            _ARG_0_:CreateFantom(2)
            _ARG_0_.step = 2
            _ARG_0_.workStep = _ARG_0_.workStep - 1
            if 0 > _ARG_0_.workStep then
              _ARG_0_.step = 3
              Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
            end
          end
        elseif _ARG_0_.step == 2 then
          if _UPVALUE1_[2].endFlag == 1 then
            _ARG_0_:CreateFantom(3)
            _ARG_0_.step = 3
            Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
          end
        elseif _ARG_0_.step == 3 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    FantomAttack_RFing_toFantom = {
      OnBeginState = function(_ARG_0_)
        print("fantomID = " .. _ARG_0_.fantomID .. " " .. Entity.GetName(_ARG_0_.myHandle) .. ":FantomAttack_RFing_toFantom\n")
        _ARG_0_:setMotion(_UPVALUE0_, 2, -1)
        _ARG_0_.step = 0
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
        _UPVALUE1_[_ARG_0_.fantomID].attack = "FantomAttack_RFing_toFantom"
        Entity.SetTimer(_ARG_0_.myHandle, 15)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
        Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.fantomID == 0 then
          _ARG_0_:setRootMove(0)
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:GotoState("FantomAttack")
          end
        else
          _ARG_0_:setRootMove(2)
          if _ARG_0_.step == 0 then
            if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 10 then
              _ARG_0_.nextState = _ARG_0_.stack:pop(1)
              if _ARG_0_.nextState == "FantomEnd" then
              else
                _UPVALUE0_[_ARG_0_.fantomID].attack = _ARG_0_.nextState
              end
              _UPVALUE0_[_ARG_0_.fantomID].endFlag = 1
              _ARG_0_.step = 2
            end
          elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_:GotoState(_ARG_0_.nextState)
          end
        end
      end
    },
    FantomAttack_LFing_toFantom = {
      OnBeginState = function(_ARG_0_)
        print("fantomID = " .. _ARG_0_.fantomID .. " " .. Entity.GetName(_ARG_0_.myHandle) .. ":FantomAttack_LFing_toFantom\n")
        _ARG_0_:setMotion(_UPVALUE0_, 2, -1)
        _ARG_0_.step = 0
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
        _UPVALUE1_[_ARG_0_.fantomID].attack = "FantomAttack_LFing_toFantom"
        Entity.SetTimer(_ARG_0_.myHandle, 12)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
        Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.fantomID == 0 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:GotoState("FantomAttack")
          end
          _ARG_0_:setRootMove(0)
        else
          _ARG_0_:setRootMove(2)
          if _ARG_0_.step == 0 then
            if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 10 then
              _ARG_0_.nextState = _ARG_0_.stack:pop(1)
              if _ARG_0_.nextState == "FantomEnd" then
              else
                _UPVALUE0_[_ARG_0_.fantomID].attack = _ARG_0_.nextState
              end
              _UPVALUE0_[_ARG_0_.fantomID].endFlag = 1
              _ARG_0_.step = 2
            end
          elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_:GotoState(_ARG_0_.nextState)
          end
        end
      end
    },
    FantomAttack_Tail_toFantom = {
      OnBeginState = function(_ARG_0_)
        print("fantomID = " .. _ARG_0_.fantomID .. " " .. Entity.GetName(_ARG_0_.myHandle) .. ":FantomAttack_Tail_toFantom\n")
        _ARG_0_.step = 0
        _ARG_0_:setMotion(_UPVALUE0_, 2, -1)
        _UPVALUE1_[_ARG_0_.fantomID].attack = "FantomAttack_Tail_toFantom"
        Entity.SetTimer(_ARG_0_.myHandle, 12)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 or _ARG_0_.step == 1 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 3 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) < 22 then
            _ARG_0_:Rotation2(0)
          end
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 10 then
            if _ARG_0_.fantomID ~= 0 then
              _ARG_0_.nextState = _ARG_0_.stack:pop(1)
              if _ARG_0_.nextState == "FantomEnd" then
              else
                _UPVALUE0_[_ARG_0_.fantomID].attack = _ARG_0_.nextState
              end
              _UPVALUE0_[_ARG_0_.fantomID].endFlag = 1
            end
            _ARG_0_.step = 2
          end
        else
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 3 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) < 22 then
            _ARG_0_:Rotation2(0)
          end
          if _ARG_0_.fantomID == 0 then
            if Entity.IsMotionEnd(_ARG_0_.myHandle) then
              _ARG_0_:GotoState("FantomAttack")
            end
          elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_:GotoState(_ARG_0_.nextState)
          end
        end
      end
    },
    FantomAttack_JumpBite_toFantom = {
      OnBeginState = function(_ARG_0_)
        print("fantomID = " .. _ARG_0_.fantomID .. " " .. Entity.GetName(_ARG_0_.myHandle) .. ":FantomAttack_JumpBite_toFantom\n")
        _ARG_0_:setMotion(_UPVALUE0_)
        _ARG_0_.step = 0
        Entity.SetTimer(_ARG_0_.myHandle, 7)
        _UPVALUE1_[_ARG_0_.fantomID].attack = "FantomAttack_JumpBite_toFantom"
        Entity.SetMotionSpeed(_ARG_0_.myHandle, 1.5)
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
      end,
      OnUpdate = function(_ARG_0_)
        _UPVALUE0_:set(0, 0, 2)
        Entity.GetWorldPos2(_UPVALUE0_, _ARG_0_.myHandle, _UPVALUE0_)
        if 2 < 30 then
        end
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 30 / (Entity.GetMotionTotalFrame(_ARG_0_.myHandle) * 2), 1, 30 / (Entity.GetMotionTotalFrame(_ARG_0_.myHandle) * 2))
        if _ARG_0_.fantomID == 0 then
          if _ARG_0_.step == 0 then
            if Entity.IsTimeOver(_ARG_0_.myHandle) then
              _ARG_0_:setMotion(_UPVALUE1_)
              _ARG_0_.step = 1
            end
          elseif _ARG_0_.step == 1 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_:GotoState("FantomAttack")
          end
        elseif _ARG_0_.step == 0 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:setMotion(_UPVALUE1_)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    FantomAttack_Rush_toFantom = {
      OnBeginState = function(_ARG_0_)
        print("fantomID = " .. _ARG_0_.fantomID .. " " .. Entity.GetName(_ARG_0_.myHandle) .. ":FantomAttack_Rush_toFantom\n")
        if _ARG_0_:isFastBoss() == 1 then
          _UPVALUE0_[_ARG_0_.fantomID].attack = "FantomAttack_Rush_toFantom"
          _ARG_0_.step = 0
          Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
          _ARG_0_.FantomHandleList[0].handle = _ARG_0_.myHandle
          _ARG_0_:CreateFantom(1)
          if _ARG_0_:checkRate(21, 0) == 1 then
          elseif _ARG_0_:checkRate(21, 0) == 2 then
          else
          end
          _ARG_0_.workStep = 2
          _ARG_0_.workStep = 2
          _ARG_0_.motionEndFlag = 0
        else
          if _ARG_0_.fantomID == 1 then
            Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE1_)
          else
            Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE1_, -2)
          end
          _ARG_0_.step = 0
          Entity.SetTimer(_ARG_0_.myHandle, 60)
          _ARG_0_.Speed = 0
          Entity.GetWorldPos(_ARG_0_.StartPos, _ARG_0_.myHandle)
          _ARG_0_.nowMoveDist = 0
          _ARG_0_.HitAttackFlag = 0
          _UPVALUE0_[_ARG_0_.fantomID].attack = "FantomAttack_Rush_toFantom"
        end
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.fantomID == 0 then
          _ARG_0_:setRootMove(0)
          if Entity.IsMotionEnd(_ARG_0_.myHandle) and _ARG_0_.motionEndFlag == 0 then
            _ARG_0_:setMotion(_UPVALUE0_)
            _ARG_0_.motionEndFlag = 1
          end
          if _ARG_0_.step == 0 then
            _ARG_0_.step = 1
          elseif _ARG_0_.step == 1 then
            if _UPVALUE1_[1].endFlag == 1 then
              _ARG_0_:CreateFantom(2)
              _ARG_0_.step = 2
            end
          elseif _ARG_0_.step == 2 then
            if _UPVALUE1_[2].endFlag == 1 then
              _ARG_0_:CreateFantom(3)
              Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
              Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE2_, -2)
              _ARG_0_.step = 3
              Entity.SetTimer(_ARG_0_.myHandle, 60)
              _ARG_0_.Speed = 0
              Entity.GetWorldPos(_ARG_0_.StartPos, _ARG_0_.myHandle)
              _ARG_0_.nowMoveDist = 0
              _ARG_0_.HitAttackFlag = 0
              _UPVALUE1_[_ARG_0_.fantomID].attack = "FantomAttack_Rush_toFantom"
            end
          elseif _ARG_0_.step == 3 then
            if _ARG_0_.step == 0 or _ARG_0_.step == 1 then
              _ARG_0_.workTimer = _ARG_0_.workTimer - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
              if 0 > _ARG_0_.workTimer then
                _ARG_0_:CreateRushAttackColl(3)
                _ARG_0_:CreateRushAttackColl(-3)
                _ARG_0_.workTimer = 12
              end
            end
            if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 33 then
              _ARG_0_:MoveEx(_UPVALUE3_ * 1.5, 0.1)
              _ARG_0_.nowMoveDist = _ARG_0_.nowMoveDist + _ARG_0_.Speed
              _UPVALUE1_[_ARG_0_.fantomID].endFlag = 1
            end
            if Entity.IsWall(_ARG_0_.myHandle) then
              _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
            end
          elseif _ARG_0_.step == 4 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        elseif _ARG_0_.step == 0 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 10 then
            _UPVALUE1_[_ARG_0_.fantomID].endFlag = 1
          end
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 33 then
            _ARG_0_:MoveEx(_UPVALUE3_ * 1.5, 0.1)
            _ARG_0_.nowMoveDist = _ARG_0_.nowMoveDist + _ARG_0_.Speed
            _UPVALUE1_[_ARG_0_.fantomID].endFlag = 1
          end
          if Entity.IsWall(_ARG_0_.myHandle) then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
            _ARG_0_:setMotion(_UPVALUE4_)
          end
        elseif _ARG_0_.step == 1 then
          _ARG_0_.nowMoveDist = _ARG_0_.nowMoveDist + _ARG_0_.Speed
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          _ARG_0_:MoveEx(_UPVALUE3_, 0.1)
          _ARG_0_.nowMoveDist = _ARG_0_.nowMoveDist + _ARG_0_.Speed
          if _ARG_0_.nowMoveDist > 35 or _ARG_0_.HitAttackFlag == 1 or Entity.IsWall(_ARG_0_.myHandle) then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            if _ARG_0_.fantomID == 0 then
              _ARG_0_.stack:push("RightAndLeftStep2")
              _ARG_0_:GotoState("FantomAttack")
            else
              _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
              _ARG_0_:setMotion(_UPVALUE4_)
              _ARG_0_.step = 3
              _ARG_0_.nowMoveDist = 0
            end
          end
        elseif _ARG_0_.step == 2 then
          if _ARG_0_.fantomID == 0 then
            if Entity.IsMotionEnd(_ARG_0_.myHandle) then
              _ARG_0_.stack:push("TrunPleyr")
              _ARG_0_:GotoState("FantomAttack")
            end
          elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        elseif _ARG_0_.step == 3 then
        end
      end
    },
    FantomAttack_RotRush_toFantom = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":FantomAttack_RotRush_toFantom\n")
        _ARG_0_:setMotion(_UPVALUE0_, _ARG_0_.fantomID, -1)
        _ARG_0_.step = 0
        Entity.SetTimer(_ARG_0_.myHandle, 300)
        _ARG_0_.Speed = 0
        Entity.EnableBgColl(_ARG_0_.myHandle, 0)
        Entity.EnableGravity(_ARG_0_.myHandle, 0)
        Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
        _UPVALUE1_:sety(Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle))
        Entity.SetRot(_ARG_0_.myHandle, _UPVALUE1_)
        _ARG_0_:CreateRushSpeedOfSound()
        _ARG_0_.HitAttackFlag = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
        _ARG_0_:CreateRushOut_FastBattle()
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.HitAttackFlag == 1 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:setMotion(_UPVALUE0_, 99, 99)
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
        _ARG_0_:MoveEx(_UPVALUE1_, 0.1)
        if _ARG_0_.step == 0 and Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    FantomEnd = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":FantomEnd\n")
        _ARG_0_:setMotion(_UPVALUE0_)
        Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 20)
        print("self.fantomID = " .. _ARG_0_.fantomID .. "\n")
        _UPVALUE1_[_ARG_0_.fantomID].endFlag = 1
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 and Entity.IsModelFade(_ARG_0_.myHandle) == false then
          Entity.Out(_ARG_0_.myHandle)
        end
      end
    },
    WallIn = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":WallIn\n")
        _ARG_0_:setMotion(_UPVALUE0_)
        _ARG_0_.step = 0
        Entity.SetTimer(_ARG_0_.myHandle, 60)
        _ARG_0_.Speed = 0
        Entity.EnableBgColl(_ARG_0_.myHandle, 1)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        _ARG_0_.workTimer = 0
        _ARG_0_.workTimer = 63
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 30)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 33 then
            _ARG_0_.workTimer = _ARG_0_.workTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
            _ARG_0_:MoveEx(_UPVALUE0_, 0.1)
            if Entity.IsWall(_ARG_0_.myHandle) or 0 > _ARG_0_.workTimer then
              Entity.EnableBgColl(_ARG_0_.myHandle, 0)
              Entity.EnableGravity(_ARG_0_.myHandle, 0)
              _ARG_0_:setMotion(_UPVALUE1_)
              _ARG_0_.step = 1
              Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
            end
          end
        elseif _ARG_0_.step == 1 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_:GotoState("WallNow")
          end
        elseif _ARG_0_.step == 2 then
        end
      end
    },
    WallNow = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":WallNow\n")
        _ARG_0_:setMotion(_UPVALUE0_)
        _ARG_0_.step = 0
        _ARG_0_.Speed = 0
        Entity.EnableBgColl(_ARG_0_.myHandle, 0)
        Entity.EnableGravity(_ARG_0_.myHandle, 0)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
        _ARG_0_.WallAngle = RadToDeg(_UPVALUE1_:gety())
        _UPVALUE2_:set(0, 0, 0)
        _ARG_0_.CenterDist = Entity.CalcDistance(_ARG_0_.myHandle, _UPVALUE2_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE3_)
        _ARG_0_:WallRushEffect()
        _ARG_0_.workTimer = 900
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.ClearSpeed(_ARG_0_.myHandle)
          _UPVALUE0_:set(0, 0, 0)
          _UPVALUE1_:set(0, 0, 0)
          _ARG_0_.Speed = _ARG_0_.Speed + 3
          if _ARG_0_.Speed > 30 then
            _ARG_0_.Speed = 30
          end
          _ARG_0_.WallAngle = _ARG_0_.WallAngle + _ARG_0_.Speed
          _ARG_0_:SetMapOutDist(_ARG_0_.CenterDist, _ARG_0_.WallAngle)
          _UPVALUE0_:set(0, 0, 0)
          Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.myHandle)
          Math.VectorLerp(_UPVALUE0_, _UPVALUE0_, _UPVALUE3_, 2)
          Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
          _UPVALUE1_:sety(Entity.CalcDirection(_ARG_0_.myHandle, _UPVALUE0_))
          Entity.SetRot(_ARG_0_.myHandle, _UPVALUE1_)
          if 0 > _ARG_0_.timer then
            for _FORV_5_ = 0, 4 do
              _UPVALUE4_[_FORV_5_].attack = "WallNow"
              _ARG_0_.FantomHandleList[_FORV_5_].handle = _ARG_0_.myHandle
            end
            if Script.Random() < 0.33 then
            elseif Script.Random() < 0.666 then
            else
            end
            print("endn = " .. 2 .. "\n")
            for _FORV_7_ = 0, 2 do
            end
            _ARG_0_:CreateFantom(_FOR_.RandomInteger(3) + 1)
            if _ARG_0_.workTimer < 300 then
              _ARG_0_.timer = 20 + Script.Random() * 45 + 20
            elseif _ARG_0_.workTimer < 480 then
              _ARG_0_.timer = 25 + Script.Random() * 45 + 20
            elseif _ARG_0_.workTimer < 600 then
              _ARG_0_.timer = 45 + Script.Random() * 45 + 30
            elseif _ARG_0_.workTimer < 960 then
              _ARG_0_.timer = 45 + Script.Random() * 45 + 60
            end
          end
          _ARG_0_.workTimer = _ARG_0_.workTimer - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
          _ARG_0_.timer = _ARG_0_.timer - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:GotoState("WallEnd")
          end
        elseif _ARG_0_.step == 1 then
        elseif _ARG_0_.step == 2 then
        end
      end
    },
    WallEnd = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_.targetHandle = Player.GetHandle()
        print(Entity.GetName(_ARG_0_.myHandle) .. ":Fantom\n")
        _ARG_0_:setMotion(_UPVALUE0_)
        _ARG_0_.step = 0
        Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
        _UPVALUE2_:set(0, 0, 0)
        _UPVALUE1_:sety(Entity.CalcDirection(_ARG_0_.myHandle, _UPVALUE2_))
        Entity.SetRot(_ARG_0_.myHandle, _UPVALUE1_)
        Entity.EnableBgColl(_ARG_0_.myHandle, 1)
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 0, 1, 0)
        Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, 30)
        Effect.LoopEnd(_ARG_0_.wallRushHandle)
      end,
      OnEndState = function(_ARG_0_)
        Effect.LoopEnd(_ARG_0_.wallRushHandle)
        _ARG_0_.wallRushHandle = NULL_HANDLE
        Entity.EnableBgColl(_ARG_0_.myHandle, 1)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        _ARG_0_.wallAttackFlag = 2
      end,
      OnUpdate = function(_ARG_0_)
        Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
        _UPVALUE0_:set(0, 0.01, 0)
        Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
        _UPVALUE1_:sety(Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle))
        Entity.SetRot(_ARG_0_.myHandle, _UPVALUE1_)
        if _ARG_0_.step == 0 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 14 then
            _ARG_0_:CreateWallInpact()
            Entity.EnableGravity(_ARG_0_.myHandle, 1)
            Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        elseif _ARG_0_.step == 2 then
        end
      end
    },
    FrontBigDamage = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":FrontBigDamage\n")
        _ARG_0_:setMotion(_UPVALUE0_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    LeftOrRightBigDamage = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":FrontBigDamage\n")
        _ARG_0_:setMotion(_UPVALUE0_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Standby = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":Standby\n")
        _ARG_0_.targetHandle = Player.GetHandle()
        _ARG_0_.cameraStep = _UPVALUE0_
        _ARG_0_:setMotion(_UPVALUE1_)
        _ARG_0_:SetEyeLight2()
        Entity.EnableGravity(_ARG_0_.myHandle, 0)
        Entity.SetAlpha(_ARG_0_.myHandle, 0)
        Entity.SetEffectAttach(_ARG_0_.myHandle, 1, "010", 2)
        Entity.SetTimer(_ARG_0_.myHandle, 420)
        _ARG_0_.AttackTimer = 0
      end,
      OnEndState = function(_ARG_0_)
        if _ARG_0_:isFastBoss() == 0 then
          return
        end
        _ARG_0_:OutEyeLight()
        _UPVALUE0_:set(0, 0, 0)
        Script.SettingFog(_UPVALUE0_, _UPVALUE1_, _UPVALUE2_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _UPVALUE0_:set(0, 0, 0)
          Script.SettingFog(_UPVALUE0_, _UPVALUE1_, _UPVALUE2_)
        end
        if Enemy.IsAllEnemyWaiting() == false then
          _ARG_0_.stack:push("Idling1")
          _ARG_0_:GotoState("BackStep1")
        end
      end
    },
    Dead = {
      OnBeginState = function(_ARG_0_)
        Entity.EnableLockon(_ARG_0_.myHandle, 0)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
      end
    }
  },
  CreateAttackCamera = function(_ARG_0_, _ARG_1_)
    if _ARG_1_ == 0 then
      _ARG_0_.camera = Camera.CreateExusiaCamera("rush1_dp")
      print("\131J\131\129\131\137\130\240\129@rush1_dp\130\197\139N\147\174")
    elseif _ARG_1_ == 1 then
      _ARG_0_.camera = Camera.CreateExusiaCamera("jump1_dp")
      print("\131J\131\129\131\137\130\240\129@jump1_dp\130\197\139N\147\174")
    elseif _ARG_1_ == 2 then
      _ARG_0_.camera = Camera.CreateExusiaCamera("jump2_dp")
      print("\131J\131\129\131\137\130\240\129@jump2_dp\130\197\139N\147\174")
    end
    Camera.SetAttachSetCoord(_ARG_0_.camera, _ARG_0_:CreateCameraAttachb(), 0)
    Camera.StartExusiaCamera(_ARG_0_.camera)
    _ARG_0_.cameraFlag = 1
    Script.DisablePauseChecker()
    _ARG_0_.BadEffectHandle = Enemy.GetBadStatusEffect(_ARG_0_.myHandle)
    Effect.SetAlpha(_ARG_0_.BadEffectHandle, 0)
  end,
  DeleteAttackCamera = function(_ARG_0_, _ARG_1_)
    Script.OutTask(_ARG_0_.camera)
    Script.EnablePauseChecker()
    Effect.SetAlpha(_ARG_0_.BadEffectHandle, 1)
  end,
  DeleteCamera = function(_ARG_0_)
    DeleteFisheyeLens(_ARG_0_.myHandle)
    Camera.CameraDestroy(_UPVALUE0_)
    _UPVALUE0_ = NULL_HANDLE
    Effect.KillEffect(_UPVALUE1_)
  end,
  SetCameraStartPos = function(_ARG_0_, _ARG_1_)
    _UPVALUE0_:set(0, 0, _ARG_1_)
    Entity.GetWorldPos2(_UPVALUE0_, _ARG_0_.targetHandle, _UPVALUE0_)
    Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.targetHandle)
    Collision.IntersectRayBg(_UPVALUE0_, COLL_KIND_ENEMY, _UPVALUE1_, _UPVALUE0_)
    _UPVALUE2_:set(0, 0, _ARG_1_)
    Entity.GetWorldPos2(_UPVALUE2_, _ARG_0_.targetHandle, _UPVALUE2_)
    if _UPVALUE0_:getx() == _UPVALUE2_:getx() and _UPVALUE0_:getz() == _UPVALUE2_:getz() then
      Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE0_)
    else
      _UPVALUE3_:set(0, 0, 0)
      print("rnd = " .. 40 - Script.Random() * 80 .. "\n")
      _UPVALUE3_:sety(Entity.CalcDirection(_ARG_0_.targetHandle, _UPVALUE3_))
      _UPVALUE2_:set(0, 0, _ARG_1_ * -1)
      Math.RotateVectorXYZ(_UPVALUE2_, _UPVALUE3_)
      Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.targetHandle)
      FVECTOR3.Add(_UPVALUE2_, _UPVALUE2_, _UPVALUE0_)
      Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE2_)
    end
    Entity.GetRot(_UPVALUE3_, _ARG_0_.myHandle)
    _UPVALUE3_:sety(Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle))
    Entity.SetRot(_ARG_0_.myHandle, _UPVALUE3_)
  end,
  SetMapOutDist = function(_ARG_0_, _ARG_1_, _ARG_2_)
    _UPVALUE0_:set(0, 0, 0)
    _UPVALUE1_:set(0, 0, 0)
    _UPVALUE1_:sety(RoundPI(DegToRad(_ARG_2_)))
    _UPVALUE2_:set(0, 0, _ARG_1_)
    Math.RotateVectorXYZ(_UPVALUE2_, _UPVALUE1_)
    Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE2_)
    Entity.SetOldLocalPos(_ARG_0_.myHandle, _UPVALUE2_)
  end,
  SetMapNearPoint = function(_ARG_0_)
    _UPVALUE0_:set(0, 0, 0)
    Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
    FVECTOR3.Sub(_UPVALUE2_, _UPVALUE1_, _UPVALUE3_)
    FVECTOR3.normalize(_UPVALUE2_)
    _ARG_0_.WallAngle = RadToDeg((Math.Atan2(_UPVALUE2_:getx(), _UPVALUE2_:getz())))
    _ARG_0_:SetMapOutDist(_UPVALUE4_, _ARG_0_.WallAngle)
    Entity.GetRot(_UPVALUE5_, _ARG_0_.myHandle)
    _UPVALUE5_:sety(Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle))
    Entity.SetRot(_ARG_0_.myHandle, _UPVALUE5_)
  end,
  CreateFantom = function(_ARG_0_, _ARG_1_)
    _UPVALUE0_:set(0, 0, 0.1)
    if _UPVALUE1_[_ARG_1_ - 1].attack ~= "FantomAttack_Rush_toFantom" then
      Entity.GetWorldPos2(_UPVALUE0_, _ARG_0_.FantomHandleList[_ARG_1_ - 1].handle, _UPVALUE0_)
    else
      Entity.GetWorldPos2(_UPVALUE0_, _ARG_0_.FantomHandleList[0].handle, _UPVALUE0_)
    end
    if _ARG_0_:GetState() == "WallNow" then
      Camera.GetPlayerCameraPos(_UPVALUE2_)
      Camera.GetPlayerCameraDir(_UPVALUE3_)
      _UPVALUE4_:set(0, 0, 25)
      _UPVALUE3_:set(0, _UPVALUE3_:gety(), 0)
      _UPVALUE3_:sety(_UPVALUE3_:gety() + DegToRad(Script.Random() * 120 - 60))
      Math.RotateVectorXYZ(_UPVALUE4_, _UPVALUE3_)
      _UPVALUE0_:set(_UPVALUE4_:getx(), _UPVALUE4_:gety(), _UPVALUE4_:getz())
      Entity.GetWorldPos(_UPVALUE5_, _ARG_0_.FantomHandleList[0].handle, 2)
      Entity.SetEffect(_ARG_0_.myHandle, "b02ex00", "B039_FTM_APP0_0", _UPVALUE5_, _UPVALUE6_)
    else
      Entity.GetWorldPos(_UPVALUE5_, _ARG_0_.FantomHandleList[0].handle, 2)
      Entity.SetEffect(_ARG_0_.myHandle, "b02ex00", "B039_FTM_APP0_0", _UPVALUE5_, _UPVALUE6_)
    end
    Entity.GetRot(_UPVALUE6_, _ARG_0_.FantomHandleList[0].handle)
    _ARG_0_.FantomHandleList[_ARG_1_].handle = Entity.CreateEntity("b02ex00", _UPVALUE0_, _UPVALUE6_)
    Entity.EnableBodyColl(_ARG_0_.FantomHandleList[_ARG_1_].handle, 0)
    Entity.EnableDamageColl(_ARG_0_.FantomHandleList[_ARG_1_].handle, 0)
    Entity.EnableLockonAndShooton(_ARG_0_.FantomHandleList[_ARG_1_].handle, 0)
    Entity.SetupModelFade(_ARG_0_.FantomHandleList[_ARG_1_].handle, 0, 1, 10)
    Entity.SetModelOfsZ(_ARG_0_.FantomHandleList[_ARG_1_].handle, 10 + _ARG_1_ * 10)
    if _ARG_0_:GetState() == "WallNow" then
      Entity.EnableBodyColl(_ARG_0_.FantomHandleList[_ARG_1_].handle, 0)
    end
    _UPVALUE1_[_ARG_1_].endFlag = 0
    EntityManager:GetEntity(_ARG_0_.FantomHandleList[_ARG_1_].handle).fantomID = _ARG_1_
    if _ARG_1_ == 1 then
      _UPVALUE0_:set(1, 0, 0)
      Entity.SetColor(_ARG_0_.FantomHandleList[_ARG_1_].handle, _UPVALUE0_)
    elseif _ARG_1_ == 2 then
      _UPVALUE0_:set(0, 2, 0.2)
      Entity.SetColor(_ARG_0_.FantomHandleList[_ARG_1_].handle, _UPVALUE0_)
    elseif _ARG_1_ == 3 then
      _UPVALUE0_:set(1, 0.2, 2)
      Entity.SetColor(_ARG_0_.FantomHandleList[_ARG_1_].handle, _UPVALUE0_)
    elseif _ARG_1_ == 3 then
      _UPVALUE0_:set(1, 0.2, 2)
      Entity.SetColor(_ARG_0_.FantomHandleList[_ARG_1_].handle, _UPVALUE0_)
    end
    _UPVALUE7_:set(0.8, 0.8, 0.8)
    Entity.SetScale(_ARG_0_.FantomHandleList[_ARG_1_].handle, _UPVALUE7_)
    _ARG_0_:GetFantomState(_ARG_1_, (EntityManager:GetEntity(_ARG_0_.FantomHandleList[_ARG_1_].handle)))
    EntityManager:GetEntity(_ARG_0_.FantomHandleList[_ARG_1_].handle):GotoState(EntityManager:GetEntity(_ARG_0_.FantomHandleList[_ARG_1_].handle).stack:pop(1))
  end,
  GetFantomState = function(_ARG_0_, _ARG_1_, _ARG_2_)
    _ARG_2_.stack:clear()
    _ARG_2_.stack:push("FantomEnd")
    if _UPVALUE0_[_ARG_1_ - 1].attack == "FantomAttack_Rush_toFantom" then
      _ARG_2_.stack:push("FantomAttack_Rush_toFantom")
    elseif _UPVALUE0_[_ARG_1_ - 1].attack == "WallNow" then
      _ARG_2_.stack:push("FantomAttack_RotRush_toFantom")
    else
      if _UPVALUE0_[_ARG_1_ - 1].attack == "FantomAttack_RFing_toFantom" then
        if Script.Random() < 0.2 then
          _ARG_2_.stack:push("FantomAttack_LFing_toFantom")
        elseif Script.Random() < 0.4 then
          _ARG_2_.stack:push("FantomAttack_LFing_toFantom")
        elseif Script.Random() < 0.6 then
          _ARG_2_.stack:push("FantomAttack_Tail_toFantom")
        elseif Script.Random() < 0.8 then
          _ARG_2_.stack:push("FantomAttack_LFing_toFantom")
        else
          _ARG_2_.stack:push("FantomAttack_LFing_toFantom")
        end
      elseif _UPVALUE0_[_ARG_1_ - 1].attack == "FantomAttack_LFing_toFantom" then
        if Script.Random() < 0.2 then
          _ARG_2_.stack:push("FantomAttack_RFing_toFantom")
        elseif Script.Random() < 0.4 then
          _ARG_2_.stack:push("FantomAttack_RFing_toFantom")
        elseif Script.Random() < 0.6 then
          _ARG_2_.stack:push("FantomAttack_Tail_toFantom")
        elseif Script.Random() < 0.8 then
          _ARG_2_.stack:push("FantomAttack_RFing_toFantom")
        else
          _ARG_2_.stack:push("FantomAttack_RFing_toFantom")
        end
      elseif _UPVALUE0_[_ARG_1_ - 1].attack == "FantomAttack_Tail_toFantom" then
        if Script.Random() < 0.2 then
          _ARG_2_.stack:push("FantomAttack_LFing_toFantom")
        elseif Script.Random() < 0.4 then
          _ARG_2_.stack:push("FantomAttack_RFing_toFantom")
        elseif Script.Random() < 0.8 then
          _ARG_2_.stack:push("FantomAttack_LFing_toFantom")
        else
          _ARG_2_.stack:push("FantomAttack_RFing_toFantom")
        end
      elseif _UPVALUE0_[_ARG_1_ - 1].attack == "FantomAttack_JumpBite_toFantom" then
        if Script.Random() < 0.2 then
          _ARG_2_.stack:push("FantomAttack_LFing_toFantom")
        elseif Script.Random() < 0.4 then
          _ARG_2_.stack:push("FantomAttack_RFing_toFantom")
        elseif Script.Random() < 0.8 then
          _ARG_2_.stack:push("FantomAttack_LFing_toFantom")
        else
          _ARG_2_.stack:push("FantomAttack_RFing_toFantom")
        end
      elseif Script.Random() < 0.2 then
        _ARG_2_.stack:push("FantomAttack_LFing_toFantom")
      elseif Script.Random() < 0.4 then
        _ARG_2_.stack:push("FantomAttack_RFing_toFantom")
      elseif Script.Random() < 0.8 then
        _ARG_2_.stack:push("FantomAttack_LFing_toFantom")
      else
        _ARG_2_.stack:push("FantomAttack_RFing_toFantom")
      end
      if _ARG_1_ == 1 then
        _ARG_2_.stack:push(_UPVALUE0_[0].attack)
      elseif _ARG_1_ == 2 then
        _ARG_2_.stack:push(_UPVALUE0_[1].attack)
      elseif _ARG_1_ == 3 then
        _ARG_2_.stack:push(_UPVALUE0_[2].attack)
      else
        _ARG_2_.stack:push(_UPVALUE0_[3].attack)
      end
    end
  end,
  GetFantomState_ToRush = function(_ARG_0_, _ARG_1_, _ARG_2_)
    _ARG_2_.stack:push("FantomEnd")
    _ARG_2_.stack:push("FantomAttack_Rush_toFantom")
  end,
  SetEyeLight = function(_ARG_0_, _ARG_1_)
    if _ARG_0_.eyeLight == NULL_HANDLE then
      print("\138\225\140\245\131Z\131b\131g\n")
      if _ARG_1_ == 1 then
        _UPVALUE0_:set(0.8, -2.2, 0)
      else
        _UPVALUE0_:set(0.8, -0.2, 0)
      end
      _UPVALUE1_:set(0, DegToRad(90), 0)
      _ARG_0_.eyeLight = Entity.AttachEffect(_ARG_0_.myHandle, "b02ex00", "B039_EYE_LOC0_0", "atama", _UPVALUE0_, _UPVALUE1_)
    end
  end,
  SetEyeLight2 = function(_ARG_0_, _ARG_1_)
    if _ARG_0_.eyeLight == NULL_HANDLE then
      print("\138\225\140\245\131Z\131b\131g2\n")
      if _ARG_1_ == 1 then
        _UPVALUE0_:set(0.8, -2.2, 0)
      else
        _UPVALUE0_:set(0.8, -0.2, 0)
      end
      _UPVALUE1_:set(0, DegToRad(90), 0)
      _ARG_0_.eyeLight = Entity.AttachEffect(_ARG_0_.myHandle, "b02ex00", "B039_EYE_LOC1_0", "atama", _UPVALUE0_, _UPVALUE1_)
    end
  end,
  OutEyeLight = function(_ARG_0_)
    print("\138\225\140\245\143I\151\185\n")
    Effect.LoopEnd(_ARG_0_.eyeLight)
    _ARG_0_.eyeLight = NULL_HANDLE
  end,
  SetRushEffect = function(_ARG_0_)
    if _ARG_0_.rushEffHandle1 == NULL_HANDLE then
    end
  end,
  OutRushEffect = function(_ARG_0_)
    Effect.LoopEnd(_ARG_0_.rushEffHandle1)
    _ARG_0_.rushEffHandle1 = NULL_HANDLE
  end,
  CreateRushAttackColl = function(_ARG_0_, _ARG_1_)
    _UPVALUE0_:set(_ARG_1_, 0, 0)
    Entity.GetWorldPos2(_UPVALUE0_, _ARG_0_.myHandle, _UPVALUE0_)
    _UPVALUE1_:set(0, 0, 0)
    Bullet.SetCollision(Bullet.CreateBullet("RushFootImpact", _UPVALUE0_, _UPVALUE1_), COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, 1.5, 0)
    SetBulletAttackParam(Bullet.CreateBullet("RushFootImpact", _UPVALUE0_, _UPVALUE1_), _ARG_0_.myHandle, 10)
    Bullet.SetHitAttackEffectName(Bullet.CreateBullet("RushFootImpact", _UPVALUE0_, _UPVALUE1_), "b02ex00", "B039_HIT_SHO0_0")
    Bullet.SetMaxMoveDist(Bullet.CreateBullet("RushFootImpact", _UPVALUE0_, _UPVALUE1_), 14400)
  end,
  CreateRushIn_FastBattle = function(_ARG_0_)
    _UPVALUE0_:set(0, 0, 0)
    Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
    _UPVALUE2_:set(0, 0, 0)
    FVECTOR3.Sub(_UPVALUE3_, _UPVALUE1_, _UPVALUE2_)
    FVECTOR3.normalize(_UPVALUE3_)
    _UPVALUE0_:sety(RoundPI((Math.Atan2(_UPVALUE3_:getx(), _UPVALUE3_:getz()))))
    _UPVALUE3_:set(0, 4, 20)
    Math.RotateVectorXYZ(_UPVALUE3_, _UPVALUE0_)
    Entity.SetEffect(_ARG_0_.myHandle, "b02ex00", "B039_TSN_APP0_0", _UPVALUE3_, _UPVALUE0_)
  end,
  CreateRushOut_FastBattle = function(_ARG_0_)
    _UPVALUE0_:set(0, 4, -4)
    Entity.GetWorldPos2(_UPVALUE0_, _ARG_0_.myHandle, _UPVALUE0_)
    Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
    Entity.SetEffect(_ARG_0_.myHandle, "b02ex00", "B039_TSN_LST0_0", _UPVALUE0_, _UPVALUE1_)
  end,
  WallRushEffect = function(_ARG_0_)
    if _ARG_0_.wallRushHandle ~= NULL_HANDLE then
      return
    end
    _UPVALUE0_:set(0, 0, 0)
    _UPVALUE1_:set(0, 0, 0)
    _ARG_0_.wallRushHandle = Entity.SetEffect(_ARG_0_.myHandle, "b02ex00", "B039_FSP_LOC0_0", _UPVALUE0_, _UPVALUE1_)
  end,
  CreateRushSpeedOfSound = function(_ARG_0_)
    _UPVALUE0_:set(0, 0, 5)
    Entity.GetWorldPos2(_UPVALUE0_, _ARG_0_.myHandle, _UPVALUE0_, 1)
    Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
    Entity.SetEffect(_ARG_0_.myHandle, "b02ex00", "B039_TSN_APP0_0", _UPVALUE0_, _UPVALUE1_)
  end,
  CreateWallInpact = function(_ARG_0_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
    _UPVALUE1_:set(0, 0, 0)
    Bullet.CreateEffectBullet(Bullet.CreateBullet("FantomSprintImpact", _UPVALUE0_, _UPVALUE1_), "b02ex00", "B039_FSP_SHO0_0")
    Bullet.SetCollision(Bullet.CreateBullet("FantomSprintImpact", _UPVALUE0_, _UPVALUE1_), COLL_KIND_ENEMY, COLL_SHAPE_CYLINDER, 1, 1.2)
    SetBulletAttackParam(Bullet.CreateBullet("FantomSprintImpact", _UPVALUE0_, _UPVALUE1_), _ARG_0_.myHandle, 11)
    Bullet.SetHitAttackEffectName(Bullet.CreateBullet("FantomSprintImpact", _UPVALUE0_, _UPVALUE1_), "b02ex00", "B039_HIT_SHO1_0")
    Bullet.SetMaxMoveDist(Bullet.CreateBullet("FantomSprintImpact", _UPVALUE0_, _UPVALUE1_), 14400)
  end,
  CreateCameraAttachb = function(_ARG_0_)
    Entity.Out(_ARG_0_.cameraAttach)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.targetHandle)
    _UPVALUE1_:set(0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle), 0)
    Bullet.SetCollision(Bullet.CreateBullet("cameraAttachb", _UPVALUE0_, _UPVALUE1_), COLL_KIND_PLAYER, COLL_SHAPE_SPHERE, 0, 0)
    Bullet.SetHitAttackEffectName(Bullet.CreateBullet("cameraAttachb", _UPVALUE0_, _UPVALUE1_), "b02ex00", "B039_HIT_SHO0_0")
    Bullet.SetMaxMoveDist(Bullet.CreateBullet("cameraAttachb", _UPVALUE0_, _UPVALUE1_), 14400)
    Bullet.EnableNoCheckHitBg(Bullet.CreateBullet("cameraAttachb", _UPVALUE0_, _UPVALUE1_), 1)
    Entity.EnableBgColl(Bullet.CreateBullet("cameraAttachb", _UPVALUE0_, _UPVALUE1_), 0)
    Entity.EnableDamageColl(Bullet.CreateBullet("cameraAttachb", _UPVALUE0_, _UPVALUE1_), 0)
    Bullet.EnableDamageCollision(Bullet.CreateBullet("cameraAttachb", _UPVALUE0_, _UPVALUE1_), 0)
    _ARG_0_.cameraAttach, EntityManager:GetEntity((Bullet.CreateBullet("cameraAttachb", _UPVALUE0_, _UPVALUE1_))).targetHandle = Bullet.CreateBullet("cameraAttachb", _UPVALUE0_, _UPVALUE1_), _ARG_0_.targetHandle
    return (Bullet.CreateBullet("cameraAttachb", _UPVALUE0_, _UPVALUE1_))
  end,
  CreateNovaGiant = function(_ARG_0_, _ARG_1_, _ARG_2_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_1_, 28)
    _UPVALUE0_:sety(2.3)
    Entity.GetRot(_UPVALUE1_, _ARG_1_)
    if _ARG_2_ == 0 then
      _UPVALUE1_:sety(Entity.CalcDirection(_ARG_1_, _ARG_0_.targetHandle))
    else
      _UPVALUE1_:sety(_UPVALUE1_:gety() + DegToRad(_ARG_2_))
    end
    Bullet.CreateEffectBullet(Bullet.CreateBullet("SparNovaJ", _UPVALUE0_, _UPVALUE1_), "b02ex00", "B039_NVL_BLT0_0")
    Bullet.SetCollision(Bullet.CreateBullet("SparNovaJ", _UPVALUE0_, _UPVALUE1_), COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, 0.5, 0, _ARG_1_)
    SetBulletAttackParam(Bullet.CreateBullet("SparNovaJ", _UPVALUE0_, _UPVALUE1_), _ARG_0_.myHandle, 6)
    Bullet.SetHitAttackEffectName(Bullet.CreateBullet("SparNovaJ", _UPVALUE0_, _UPVALUE1_), "b02ex00", "B039_HIT_BLT0_0")
    Bullet.SetMaxMoveDist(Bullet.CreateBullet("SparNovaJ", _UPVALUE0_, _UPVALUE1_), 14400)
    Entity.SetTimer(Bullet.CreateBullet("SparNovaJ", _UPVALUE0_, _UPVALUE1_), 600)
    EntityManager:GetEntity((Bullet.CreateBullet("SparNovaJ", _UPVALUE0_, _UPVALUE1_))).owner = _ARG_0_.myHandle
    _ARG_0_.megaHandle, EntityManager:GetEntity((Bullet.CreateBullet("SparNovaJ", _UPVALUE0_, _UPVALUE1_))).speed = Bullet.CreateBullet("SparNovaJ", _UPVALUE0_, _UPVALUE1_), 0.06
  end,
  CreateNovaGiantDwarf = function(_ARG_0_, _ARG_1_, _ARG_2_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_1_, 28)
    _UPVALUE0_:sety(1.2)
    Entity.GetRot(_UPVALUE1_, _ARG_1_)
    if _ARG_2_ == 0 then
      _UPVALUE1_:sety(Entity.CalcDirection(_ARG_1_, _ARG_0_.targetHandle))
    else
      _UPVALUE1_:sety(_UPVALUE1_:gety() + DegToRad(_ARG_2_))
    end
    Bullet.CreateEffectBullet(Bullet.CreateBullet("SparNovaD", _UPVALUE0_, _UPVALUE1_), "b02ex00", "B039_NVD_BLT0_0")
    Bullet.SetCollision(Bullet.CreateBullet("SparNovaD", _UPVALUE0_, _UPVALUE1_), COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, 0.5, 0, _ARG_1_)
    SetBulletAttackParam(Bullet.CreateBullet("SparNovaD", _UPVALUE0_, _UPVALUE1_), _ARG_0_.myHandle, 7)
    Bullet.SetHitAttackEffectName(Bullet.CreateBullet("SparNovaD", _UPVALUE0_, _UPVALUE1_), "b02ex00", "B039_HIT_BLT1_0")
    Bullet.SetMaxMoveDist(Bullet.CreateBullet("SparNovaD", _UPVALUE0_, _UPVALUE1_), 14400)
    Entity.SetTimer(Bullet.CreateBullet("SparNovaD", _UPVALUE0_, _UPVALUE1_), 180)
    EntityManager:GetEntity((Bullet.CreateBullet("SparNovaD", _UPVALUE0_, _UPVALUE1_))).owner = _ARG_0_.myHandle
    EntityManager:GetEntity((Bullet.CreateBullet("SparNovaD", _UPVALUE0_, _UPVALUE1_))).speed = 0.06
    _ARG_0_.megaHandle, EntityManager:GetEntity((Bullet.CreateBullet("SparNovaD", _UPVALUE0_, _UPVALUE1_))).targetHandle = Bullet.CreateBullet("SparNovaD", _UPVALUE0_, _UPVALUE1_), _ARG_0_.targetHandle
  end,
  CreateBreath = function(_ARG_0_, _ARG_1_)
    _UPVALUE0_:set(2, 0, 0)
    Entity.GetWorldPos2(_UPVALUE0_, _ARG_1_, _UPVALUE0_, _UPVALUE1_)
    Entity.GetWorldPos(_UPVALUE2_, _ARG_1_, _UPVALUE1_)
    Entity.GetRot(_ARG_0_.rot, _ARG_1_)
    FVECTOR3.Sub(_UPVALUE0_, _UPVALUE0_, _UPVALUE2_)
    FVECTOR3.normalize(_UPVALUE0_)
    _ARG_0_.rot:setx(-Math.Atan2(_UPVALUE0_:gety(), Math.Sqrt(_UPVALUE0_:getz() * _UPVALUE0_:getz() + _UPVALUE0_:getx() * _UPVALUE0_:getx())))
    _ARG_0_.rot:sety((Math.Atan2(_UPVALUE0_:getx(), _UPVALUE0_:getz())))
    _UPVALUE0_:set(0.3, -0.7, 0)
    Entity.GetWorldPos2(_UPVALUE0_, _ARG_1_, _UPVALUE0_, _UPVALUE1_)
    Bullet.SetCollision(Bullet.CreateBullet("", _UPVALUE0_, _ARG_0_.rot, _ARG_1_), COLL_KIND_NO_CHECK, COLL_SHAPE_SPHERE, 2.5, 0, _ARG_1_)
    SetBulletAttackParam(Bullet.CreateBullet("", _UPVALUE0_, _ARG_0_.rot, _ARG_1_), _ARG_0_.myHandle, 8)
    Bullet.SetHitAttackEffectName(Bullet.CreateBullet("", _UPVALUE0_, _ARG_0_.rot, _ARG_1_), "b10he00", "B011_HIT_00_0")
    Entity.CalcVelocity(Bullet.CreateBullet("", _UPVALUE0_, _ARG_0_.rot, _ARG_1_), 0.2)
    Bullet.SetMaxMoveDist(Bullet.CreateBullet("", _UPVALUE0_, _ARG_0_.rot, _ARG_1_), 25)
    Entity.EnableAttackBgHit(Bullet.CreateBullet("", _UPVALUE0_, _ARG_0_.rot, _ARG_1_), 0)
    Entity.EnableBgColl(Bullet.CreateBullet("", _UPVALUE0_, _ARG_0_.rot, _ARG_1_), 0)
  end,
  isFOV = function(_ARG_0_, _ARG_1_)
    _UPVALUE0_:set(0, 0, 1)
    Entity.ApplyBoneMatrix33(_ARG_0_.myHandle, "Root", _UPVALUE1_)
    Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.targetHandle)
    _UPVALUE2_:sety(0)
    Entity.GetWorldPos(_UPVALUE3_, _ARG_0_.myHandle)
    _UPVALUE3_:sety(0)
    FVECTOR3.Sub(_UPVALUE0_, _UPVALUE2_, _UPVALUE3_)
    FVECTOR3.normalize(_UPVALUE0_)
    if FVECTOR3.dot(_UPVALUE1_, _UPVALUE0_) >= Math.Cos(RoundPI(_ARG_1_ * 0.5)) then
      return true
    end
    return false
  end,
  WhichRightandLeft = function(_ARG_0_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.targetHandle)
    Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
    Entity.GetRot(_UPVALUE2_, _ARG_0_.myHandle)
    FVECTOR3.Sub(_UPVALUE1_, _UPVALUE0_, _UPVALUE1_)
    FVECTOR3.normalize(_UPVALUE1_)
    if RoundPI((Math.Atan2(_UPVALUE1_:getx(), _UPVALUE1_:getz()) - _UPVALUE2_:gety()) * -1) < 0 then
      return 1
    else
      return 0
    end
  end,
  PleryrBackWhichRightandLeft = function(_ARG_0_)
    _UPVALUE0_:set(0, 0, -1000)
    Entity.GetWorldPos2(_UPVALUE0_, _ARG_0_.targetHandle, _UPVALUE0_)
    Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
    Entity.GetRot(_UPVALUE2_, _ARG_0_.myHandle)
    FVECTOR3.Sub(_UPVALUE1_, _UPVALUE0_, _UPVALUE1_)
    FVECTOR3.normalize(_UPVALUE1_)
    if 0 > RoundPI((Math.Atan2(_UPVALUE1_:getx(), _UPVALUE1_:getz()) - _UPVALUE2_:gety()) * -1) then
      return 1
    else
      return 0
    end
  end,
  Rotation = function(_ARG_0_, _ARG_1_)
    if Entity.GetMotionNowFrame(_ARG_0_.myHandle) - Entity.GetMotionOldFrame(_ARG_0_.myHandle) < 0 then
    else
    end
    Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
    _UPVALUE0_:sety(RoundPI(_UPVALUE0_:gety() + DegToRad((Entity.GetMotionNowFrame(_ARG_0_.myHandle) - Entity.GetMotionOldFrame(_ARG_0_.myHandle)) * (90 / Entity.GetMotionTotalFrame(_ARG_0_.myHandle))) * _ARG_1_))
    Entity.SetRot(_ARG_0_.myHandle, _UPVALUE0_)
    return DegToRad((Entity.GetMotionNowFrame(_ARG_0_.myHandle) - Entity.GetMotionOldFrame(_ARG_0_.myHandle)) * (90 / Entity.GetMotionTotalFrame(_ARG_0_.myHandle))) * _ARG_1_
  end,
  setRootMove = function(_ARG_0_, _ARG_1_)
    if _ARG_1_ == nil then
      _UPVALUE0_:set(0, 0, 2)
      Entity.GetWorldPos2(_UPVALUE0_, _ARG_0_.myHandle, _UPVALUE0_)
      if 2 < 30 then
      end
      Entity.SetRootMoveScale(_ARG_0_.myHandle, 30 / (Entity.GetMotionTotalFrame(_ARG_0_.myHandle) * 1.8), 1, 30 / (Entity.GetMotionTotalFrame(_ARG_0_.myHandle) * 1.8))
    elseif _ARG_1_ == 0 then
      Entity.SetRootMoveScale(_ARG_0_.myHandle, 0, 0, 0)
    elseif _ARG_1_ == 1 then
      _UPVALUE0_:set(0, 0, 2)
      Entity.GetWorldPos2(_UPVALUE0_, _ARG_0_.myHandle, _UPVALUE0_)
      if 2 < 30 then
      end
      Entity.SetRootMoveScale(_ARG_0_.myHandle, 30 / (Entity.GetMotionTotalFrame(_ARG_0_.myHandle) * 1) * 2.4, 1, 30 / (Entity.GetMotionTotalFrame(_ARG_0_.myHandle) * 1) * 2.4)
    elseif _ARG_1_ == 2 then
      _UPVALUE0_:set(0, 0, 2)
      Entity.GetWorldPos2(_UPVALUE0_, _ARG_0_.myHandle, _UPVALUE0_)
      if 2 < 30 then
      end
      if 30 / (Entity.GetMotionTotalFrame(_ARG_0_.myHandle) * 1) > 10 then
      end
      if 30 / (Entity.GetMotionTotalFrame(_ARG_0_.myHandle) * 1) / (Entity.GetMotionTotalFrame(_ARG_0_.myHandle) * 0.1) < 8 then
      else
      end
      Entity.SetRootMoveScale(_ARG_0_.myHandle, 30 / (Entity.GetMotionTotalFrame(_ARG_0_.myHandle) * 1) / (Entity.GetMotionTotalFrame(_ARG_0_.myHandle) * 0.1) * 1.8, 1, 30 / (Entity.GetMotionTotalFrame(_ARG_0_.myHandle) * 1) / (Entity.GetMotionTotalFrame(_ARG_0_.myHandle) * 0.1) * 1.8)
    elseif _ARG_1_ == 3 then
      Entity.SetRootMoveScale(_ARG_0_.myHandle, 0.1, 1, 0.1)
    end
  end,
  Rotation2 = function(_ARG_0_, _ARG_1_)
    if _ARG_1_ == 0 then
    else
    end
    Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
    _UPVALUE0_:sety(RoundPI(_UPVALUE0_:gety() - DegToRad(90 / (18 / Entity.GetFrameRate(_ARG_0_.myHandle)))))
    Entity.SetRot(_ARG_0_.myHandle, _UPVALUE0_)
  end,
  MoveEx = function(_ARG_0_, _ARG_1_, _ARG_2_)
    _ARG_0_.Speed = _ARG_0_.Speed + _ARG_1_ * _ARG_2_ * Entity.GetFrameRate(_ARG_0_.myHandle)
    if _ARG_1_ < _ARG_0_.Speed then
      _ARG_0_.Speed = _ARG_1_
    end
    FVECTOR3.set(_UPVALUE0_, 0, 0, _ARG_0_.Speed)
    Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE0_)
  end,
  MoveLeftOrRight = function(_ARG_0_, _ARG_1_, _ARG_2_)
    _ARG_0_.Speed = _ARG_0_.Speed + _ARG_1_ * _ARG_2_ * Entity.GetFrameRate(_ARG_0_.myHandle)
    if _ARG_1_ < _ARG_0_.Speed then
      _ARG_0_.Speed = _ARG_1_
    end
    FVECTOR3.set(_UPVALUE0_, _ARG_1_, 0, 0)
    Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE0_)
  end,
  setMotion = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    if _ARG_2_ == nil or _ARG_3_ == nil then
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_1_)
    elseif _ARG_3_ == nil then
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_1_, _ARG_2_)
    else
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_1_, _ARG_2_, _ARG_3_)
    end
    _ARG_0_:changeTexAnim()
  end,
  changeTexAnim = function(_ARG_0_)
    if Entity.GetCurrentMotion(_ARG_0_.myHandle) == Entity.GetMotionIndex(_ARG_0_.myHandle, "012") then
      Entity.SetTexAnim(_ARG_0_.myHandle, "EYE", "EYE_ANGRY")
    else
      Entity.SetTexAnim(_ARG_0_.myHandle, "EYE", "EYE_DEFAULT")
    end
  end,
  setMotionNoCheck = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    if _ARG_2_ == nil or _ARG_3_ == nil then
      Entity.SetMotion(_ARG_0_.myHandle, _ARG_1_)
    elseif _ARG_3_ == nil then
      Entity.SetMotion(_ARG_0_.myHandle, _ARG_1_, _ARG_2_)
    else
      Entity.SetMotion(_ARG_0_.myHandle, _ARG_1_, _ARG_2_, _ARG_3_)
    end
    _ARG_0_:changeTexAnim()
  end,
  getRate_p1 = function(_ARG_0_, _ARG_1_, _ARG_2_)
    if _ARG_2_ == 0 then
    elseif _ARG_2_ == 1 then
    elseif _ARG_2_ == 1 then
    end
    return _UPVALUE0_[_ARG_1_].ppp1
  end,
  getRate_p2 = function(_ARG_0_, _ARG_1_, _ARG_2_)
    if _ARG_2_ == 0 then
    elseif _ARG_2_ == 1 then
    elseif _ARG_2_ == 1 then
    end
    return _UPVALUE0_[_ARG_1_].ppp2
  end,
  getRate_p3 = function(_ARG_0_, _ARG_1_, _ARG_2_)
    if _ARG_2_ == 0 then
    elseif _ARG_2_ == 1 then
    elseif _ARG_2_ == 1 then
    end
    return _UPVALUE0_[_ARG_1_].ppp3
  end,
  getRate_p4 = function(_ARG_0_, _ARG_1_, _ARG_2_)
    if _ARG_2_ == 0 then
    elseif _ARG_2_ == 1 then
    elseif _ARG_2_ == 1 then
    end
    return _UPVALUE0_[_ARG_1_].ppp4
  end,
  getRate_p5 = function(_ARG_0_, _ARG_1_, _ARG_2_)
    if _ARG_2_ == 0 then
    elseif _ARG_2_ == 1 then
    elseif _ARG_2_ == 1 then
    end
    return _UPVALUE0_[_ARG_1_].ppp5
  end,
  checkRate = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    if _UPVALUE0_[_ARG_1_].rateType == 2 then
    elseif _UPVALUE0_[_ARG_1_].rateType == 3 then
    elseif _UPVALUE0_[_ARG_1_].rateType == 4 then
    elseif _UPVALUE0_[_ARG_1_].rateType == 5 then
    end
    if _ARG_3_ == 1 then
      print("index = " .. _ARG_1_ .. "\n")
      print("type = " .. _UPVALUE0_[_ARG_1_].rateType .. "\n")
      print("p1 = " .. _ARG_0_:getRate_p1(_ARG_1_, _ARG_2_) .. "\n")
      print("p2 = " .. _ARG_0_:getRate_p2(_ARG_1_, _ARG_2_) + _ARG_0_:getRate_p1(_ARG_1_, _ARG_2_) .. "\n")
      print("p3 = " .. _ARG_0_:getRate_p3(_ARG_1_, _ARG_2_) + (_ARG_0_:getRate_p2(_ARG_1_, _ARG_2_) + _ARG_0_:getRate_p1(_ARG_1_, _ARG_2_)) .. "\n")
      print("p4 = " .. _ARG_0_:getRate_p4(_ARG_1_, _ARG_2_) + (_ARG_0_:getRate_p3(_ARG_1_, _ARG_2_) + (_ARG_0_:getRate_p2(_ARG_1_, _ARG_2_) + _ARG_0_:getRate_p1(_ARG_1_, _ARG_2_))) .. "\n")
      print("p5 = " .. _ARG_0_:getRate_p5(_ARG_1_, _ARG_2_) + (_ARG_0_:getRate_p4(_ARG_1_, _ARG_2_) + (_ARG_0_:getRate_p3(_ARG_1_, _ARG_2_) + (_ARG_0_:getRate_p2(_ARG_1_, _ARG_2_) + _ARG_0_:getRate_p1(_ARG_1_, _ARG_2_)))) .. "\n")
      print("rnd = " .. Script.Random() .. "\n")
    end
    if _ARG_0_:getRate_p1(_ARG_1_, _ARG_2_) > Script.Random() then
      return 1
    elseif _ARG_0_:getRate_p2(_ARG_1_, _ARG_2_) + _ARG_0_:getRate_p1(_ARG_1_, _ARG_2_) > Script.Random() then
      return 2
    elseif _ARG_0_:getRate_p3(_ARG_1_, _ARG_2_) + (_ARG_0_:getRate_p2(_ARG_1_, _ARG_2_) + _ARG_0_:getRate_p1(_ARG_1_, _ARG_2_)) > Script.Random() then
      return 3
    elseif _ARG_0_:getRate_p4(_ARG_1_, _ARG_2_) + (_ARG_0_:getRate_p3(_ARG_1_, _ARG_2_) + (_ARG_0_:getRate_p2(_ARG_1_, _ARG_2_) + _ARG_0_:getRate_p1(_ARG_1_, _ARG_2_))) > Script.Random() then
      return 4
    elseif _ARG_0_:getRate_p5(_ARG_1_, _ARG_2_) + (_ARG_0_:getRate_p4(_ARG_1_, _ARG_2_) + (_ARG_0_:getRate_p3(_ARG_1_, _ARG_2_) + (_ARG_0_:getRate_p2(_ARG_1_, _ARG_2_) + _ARG_0_:getRate_p1(_ARG_1_, _ARG_2_)))) > Script.Random() then
      return 5
    end
  end,
  SettingsStateToBattole1 = function(_ARG_0_)
    print("\131X\131e\129[\131g\130\204\131Z\131b\131e\131B\131\147\131O 1\144\237\150\218\n")
    _ARG_0_.stack:clear()
    _ARG_0_.stack:push("Idling1")
    if _ARG_0_:checkRate(1, 0) == 1 then
      _ARG_0_.stack:push("RightAndLeftStep1")
    elseif _ARG_0_:checkRate(1, 0) == 2 then
      _ARG_0_.stack:push("RightAndLeftMove1")
    elseif _ARG_0_:checkRate(1, 0) == 3 then
      if _UPVALUE0_ == NULL_HANDLE then
        _ARG_0_.stack:push("TopBackWorp")
      else
        _ARG_0_.stack:push("RightAndLeftStep1")
      end
    end
  end,
  SettingsStateToBattole1Attack = function(_ARG_0_)
    print("\131X\131e\129[\131g\130\204\131Z\131b\131e\131B\131\147\131O 1\144\237\150\218\141U\140\130\145I\145\240\n")
    _ARG_0_.stack:clear()
    _ARG_0_.stack:push("Idling1")
    if Script.IsDebugCheckAttack() then
      if _ARG_0_.cameraTyep == 0 then
        _ARG_0_.stack:push("BackStep1")
        _ARG_0_.stack:push("Battole1Rush")
      elseif _ARG_0_.cameraTyep == 1 then
        _ARG_0_.stack:push("BackStep1")
        _ARG_0_.stack:push("AttackAfterIdling")
        _ARG_0_.stack:push("Scratich11")
        _ARG_0_.stack:push("Scratich1")
      else
        _ARG_0_.stack:push("BackStep1")
        _ARG_0_.stack:push("AttackAfterIdling")
        _ARG_0_.stack:push("Scratich1")
        _ARG_0_.stack:push("Scratich11")
      end
      _ARG_0_.stack:push("FormerStep")
      return
    end
    if Script.Random() < _UPVALUE0_ then
      _ARG_0_.stack:push("Battole1Rush")
      _ARG_0_.cameraTyep = 0
    elseif Script.Random() < _UPVALUE1_ then
      _ARG_0_.stack:push("BackStep1")
      _ARG_0_.stack:push("AttackAfterIdling")
      if Script.Random() < 0.333 then
      elseif Script.Random() < 0.666 then
      else
      end
      if Script.Random() < 0.5 then
      else
      end
      print("\141U\140\130\130\205" .. 2 + 1 .. "\130\183\130\233\130\230\n")
      for _FORV_9_ = 0, 2 do
        if "Scratich11" == "Scratich11" then
          _ARG_0_.stack:push("Scratich1")
        else
          _ARG_0_.stack:push("Scratich11")
        end
        if Script.Random() < _UPVALUE2_ then
          _ARG_0_.stack:push("TailAttack1")
        end
      end
      if "Scratich11" == "Scratich11" then
        _ARG_0_.stack:push("ScratichFast1")
      else
        _ARG_0_.stack:push("ScratichFast11")
      end
      if Script.Random() < _UPVALUE3_ then
      end
      _ARG_0_.cameraTyep = 1
    else
      _ARG_0_.stack:push("BackStep1")
      _ARG_0_.stack:push("AttackAfterIdling")
      if Script.Random() < 0.333 then
      elseif Script.Random() < 0.666 then
      else
      end
      if Script.Random() < 0.5 then
      else
      end
      print("\141U\140\130\130\205" .. 2 + 1 .. "\130\183\130\233\130\230\n")
      for _FORV_9_ = 0, 2 do
        if "Scratich11" == "Scratich11" then
          _ARG_0_.stack:push("Scratich1")
        else
          _ARG_0_.stack:push("Scratich11")
        end
        if Script.Random() < _UPVALUE2_ then
          _ARG_0_.stack:push("TailAttack1")
        end
      end
      if "Scratich11" == "Scratich11" then
        _ARG_0_.stack:push("ScratichFast1")
      else
        _ARG_0_.stack:push("ScratichFast11")
      end
      if Script.Random() < _UPVALUE3_ then
      end
      _ARG_0_.cameraTyep = 2
    end
    if Script.Random() < 0.5 then
    end
    _ARG_0_.stack:push("FormerStep")
  end,
  GetContiAttackState = function(_ARG_0_, _ARG_1_, _ARG_2_)
    print("GetContiAttackState\n")
    if _UPVALUE0_[_ARG_1_ - 1].attack == "Rush" then
      _ARG_2_.stack:push("Rush")
    elseif _UPVALUE0_[_ARG_1_ - 1].attack == "Scratich_Right" then
      if Script.Random() < 0.2 then
        _UPVALUE0_[_ARG_1_].attack = "Scratich_Left"
      elseif Script.Random() < 0.4 then
        _UPVALUE0_[_ARG_1_].attack = "Scratich_Left"
      elseif Script.Random() < 0.6 then
        _UPVALUE0_[_ARG_1_].attack = "TailAttack"
      elseif Script.Random() < 0.8 then
        _UPVALUE0_[_ARG_1_].attack = "Scratich_Left"
      else
        _UPVALUE0_[_ARG_1_].attack = "JumpBite"
      end
      if Script.Random() < _UPVALUE1_ then
      end
    elseif _UPVALUE0_[_ARG_1_ - 1].attack == "Scratich_Left" then
      if Script.Random() < 0.2 then
        _UPVALUE0_[_ARG_1_].attack = "Scratich_Right"
      elseif Script.Random() < 0.4 then
        _UPVALUE0_[_ARG_1_].attack = "Scratich_Right"
      elseif Script.Random() < 0.6 then
        _UPVALUE0_[_ARG_1_].attack = "TailAttack"
      elseif Script.Random() < 0.8 then
        _UPVALUE0_[_ARG_1_].attack = "Scratich_Right"
      else
        _UPVALUE0_[_ARG_1_].attack = "JumpBite"
      end
    elseif _UPVALUE0_[_ARG_1_ - 1].attack == "TailAttack" then
      if Script.Random() < 0.3 then
        _UPVALUE0_[_ARG_1_].attack = "Scratich_Right"
      elseif Script.Random() < 0.6 then
        _UPVALUE0_[_ARG_1_].attack = "Scratich_Left"
      else
        _UPVALUE0_[_ARG_1_].attack = "JumpBite"
      end
    elseif _UPVALUE0_[_ARG_1_ - 1].attack == "JumpBite" then
      if Script.Random() < 0.3 then
        _UPVALUE0_[_ARG_1_].attack = "Scratich_Right"
      elseif Script.Random() < 0.6 then
        _UPVALUE0_[_ARG_1_].attack = "Scratich_Left"
      else
        _UPVALUE0_[_ARG_1_].attack = "TailAttack"
      end
    end
  end,
  SettingsStateToBattole2Move = function(_ARG_0_)
    print("\131X\131e\129[\131g\130\204\131Z\131b\131e\131B\131\147\131O 2\144\237\150\218\136\218\147\174\145I\145\240\n")
    _ARG_0_.stack:clear()
    _ARG_0_.stack:push("Idling")
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE0_ then
      if _ARG_0_:checkRate(5, 0) == 1 then
        if _ARG_0_:checkRate(7, 0) == 1 then
        elseif _ARG_0_:checkRate(7, 0) == 2 then
        else
        end
        for _FORV_8_ = 0, 2 do
          _ARG_0_:checkChainRoll()
        end
      elseif _ARG_0_:checkRate(5, 0) == 2 then
        _ARG_0_.stack:push("RightAndLeftMove2")
      end
    elseif _ARG_0_:checkRate(6, 0) == 1 then
      print("\129I\129I\129I\129I\129I\129I\129I\137\189\130\224\130\181\130\200\130\162\129I\129I\129I\129I\n")
    elseif _ARG_0_:checkRate(6, 0) == 2 then
      if _ARG_0_:checkRate(7, 0) == 1 then
      elseif _ARG_0_:checkRate(7, 0) == 2 then
      else
      end
      for _FORV_8_ = 0, 2 do
        _ARG_0_:checkChainRoll()
      end
      print("\129I\129I\129I\129I\129I\129I\129I\136\218\147\174\130\183\130\233\130\230\129I\129I\129I\129I\n")
      _ARG_0_.stack:push("Move")
    elseif _ARG_0_:checkRate(6, 0) == 3 then
      if _ARG_0_:checkRate(8, 0) == 1 then
        print("\129I\129I\129I\129I\129I\129I\129I\131t\131F\131C\131\147\131g\131W\131\131\131\147\131v\130\183\130\233\130\230\129I\129I\129I\129I\n")
        _ARG_0_.stack:push("FeintJump")
        _ARG_0_.stack:push("RightAndLeftStep2")
      elseif _ARG_0_:checkRate(8, 0) == 2 then
        _ARG_0_.stack:push("ChainRoll")
      end
    end
  end,
  SettingsStateToBattole2Attack = function(_ARG_0_)
    print("SettingsStateToBattole2Attack\n")
    _ARG_0_.stack:clear()
    _ARG_0_.stack:push("Idling")
    if _ARG_0_:IsDetone() then
      _ARG_0_.stack:push("Rush")
      return
    end
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE0_ then
      if _ARG_0_:checkRate(14, 0) == 1 then
        _ARG_0_.stack:push("BattleIdlingC")
        _ARG_0_.stack:push("BackStep")
      elseif _ARG_0_:checkRate(14, 0) == 2 then
        if _ARG_0_:checkRate(16, 0) == 1 then
          _ARG_0_.stack:push("Idling")
        else
          _ARG_0_.stack:push("BattleIdlingC")
        end
        _ARG_0_.stack:push("TailAttack")
        _ARG_0_.stack:push("FeintJump")
        _ARG_0_.stack:push("RightAndLeftStep2")
      elseif _ARG_0_:checkRate(14, 0) == 3 then
        _ARG_0_.stack:push("Idling")
      end
      if _ARG_0_:checkRate(9, 0) == 1 then
        _UPVALUE1_[0].attack = "JumpBite"
      elseif _ARG_0_:checkRate(9, 0) == 2 then
        if Script.Random() < 0.5 then
          _UPVALUE1_[0].attack = "Scratich_Right"
        else
          _UPVALUE1_[0].attack = "Scratich_Left"
        end
      elseif _ARG_0_:checkRate(9, 0) == 3 then
        _UPVALUE1_[0].attack = "TailAttack"
      end
      if _ARG_0_:checkRate(11, 0) == 1 then
      elseif _ARG_0_:checkRate(11, 0) == 2 then
      elseif _ARG_0_:checkRate(11, 0) == 3 then
      else
      end
      print("\152A\145\177\141U\140\130\130\240" .. 3 + 1 .. "\130\183\130\233.\n")
      for _FORV_9_ = 1, 3 do
        _ARG_0_:GetContiAttackState(_FORV_9_, _ARG_0_)
      end
      for _FORV_9_ = 3, 1, -1 do
        _ARG_0_.stack:push(_UPVALUE1_[_FORV_9_].attack)
      end
      for _FORV_9_ = 0, 3, -1 do
        print(_FORV_9_ .. "\137\241\150\218\129@" .. _UPVALUE1_[_FORV_9_].attack .. "\130\183\130\233.\n")
      end
      _FOR_:push(_UPVALUE1_[0].attack)
      _ARG_0_.stack:push("RightAndLeftStep2")
      if _ARG_0_:checkRate(17, 0) == 1 then
        print("HP50\136\200\143\227\130\204\136\208\138d\130\183\130\233\129I\129I\129I")
        _ARG_0_.stack:push("Threat")
        if Entity.IsTargetFront(_ARG_0_.myHandle, _ARG_0_.targetHandle) then
        else
          _ARG_0_.stack:push("RightAndLeftStep2")
        end
      elseif _ARG_0_:checkRate(17, 0) == 2 then
      end
    else
      if _ARG_0_:checkRate(15, 0) == 1 then
        _ARG_0_.stack:push("Idling")
      elseif _ARG_0_:checkRate(15, 0) == 2 then
        _ARG_0_.stack:push("BattleIdlingC")
      end
      if _ARG_0_:checkRate(10, 0) == 1 then
        if _ARG_0_:checkRate(12, 0) == 1 then
        elseif _ARG_0_:checkRate(12, 0) == 2 then
        else
        end
        print("\147\203\144i\130\240" .. 2 + 1 .. "\137\241\130\183\130\233.\n")
        for _FORV_9_ = 0, 2 do
          _ARG_0_:checkChainRoll()
          _ARG_0_.stack:push("Rush")
          _ARG_0_.workStep = _ARG_0_.workStep + 1
        end
        _FOR_:push("RightAndLeftStep2")
      elseif _ARG_0_:checkRate(10, 0) == 2 then
        if _ARG_0_:checkRate(12, 0) == 1 then
        elseif _ARG_0_:checkRate(12, 0) == 2 then
        else
        end
        print("\131m\131\148\131@\131W\131\131\131C\131A\131\147\131g\130\240" .. 2 + 1 .. "\137\241\130\183\130\233.\n")
        for _FORV_9_ = 0, 2 do
          if Script.Random() < 0.5 then
            _ARG_0_:checkChainRoll()
          end
          if Script.Random() < 0.3 then
            _ARG_0_.stack:push("SparNova")
          else
            _ARG_0_.stack:push("SparNovaDwarf")
          end
        end
        _FOR_:push("BackStep")
      elseif _ARG_0_:checkRate(10, 0) == 3 then
        if _ARG_0_:checkRate(13, 0) == 1 then
        elseif _ARG_0_:checkRate(13, 0) == 2 then
        else
        end
        print("\131m\131\148\131@\131h\131\143\129[\131t\130\240" .. 2 + 1 .. "\137\241\130\183\130\233.\n")
        for _FORV_9_ = 0, 2 do
          if Script.Random() < 0.5 then
            _ARG_0_:checkChainRoll()
          end
          if Script.Random() < 0.3 then
            _ARG_0_.stack:push("SparNova")
          else
            _ARG_0_.stack:push("SparNovaDwarf")
          end
        end
        _FOR_:push("BackStep")
      end
    end
    _ARG_0_:checkChainRoll()
  end,
  SettingsStateToBattole2Attack50Under = function(_ARG_0_)
    print("SettingsStateToBattole2Attack50Under\n")
    _ARG_0_.stack:clear()
    _ARG_0_.stack:push("Idling")
    if _UPVALUE0_ == 0 then
      _ARG_0_.stack:push("ToPhantom")
      return
    end
    if _ARG_0_.wallAttackFlag == 0 then
      _ARG_0_.wallAttackFlag = 1
      _ARG_0_.stack:push("WallIn")
      return
    end
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE1_ then
      if _ARG_0_:checkRate(24, 0) == 1 then
        _ARG_0_.stack:push("BattleIdlingC")
        _ARG_0_.stack:push("BackStep")
      elseif _ARG_0_:checkRate(24, 0) == 2 then
        if _ARG_0_:checkRate(27, 0) == 1 then
          _ARG_0_.stack:push("Idling")
          if _ARG_0_:checkRate(29, 0) == 1 then
            _ARG_0_.stack:push("WallIn")
          end
        else
          _ARG_0_.stack:push("BattleIdlingC")
        end
        _ARG_0_.stack:push("TailAttack")
        _ARG_0_.stack:push("FeintJump")
        _ARG_0_.stack:push("RightAndLeftStep2")
      elseif _ARG_0_:checkRate(24, 0) == 3 then
        _ARG_0_.stack:push("Idling")
        if _ARG_0_:checkRate(14, 0) == 1 then
          _ARG_0_.stack:push("WallIn")
        else
          _ARG_0_.stack:push("Idling")
        end
      end
      if _ARG_0_:checkRate(19, 0) == 1 then
        if Script.Random() < 0.5 then
          _ARG_0_.stack:push("FantomAttack_RFing_toFantom")
        else
          _ARG_0_.stack:push("FantomAttack_LFing_toFantom")
        end
      elseif _ARG_0_:checkRate(19, 0) == 2 then
        if Script.Random() < 0.5 then
          _ARG_0_.stack:push("FantomAttack_RFing_toFantom")
        else
          _ARG_0_.stack:push("FantomAttack_LFing_toFantom")
        end
      elseif _ARG_0_:checkRate(19, 0) == 3 then
        _ARG_0_.stack:push("FantomAttack_Tail_toFantom")
      end
      _ARG_0_.stack:push("BackStep")
      if _ARG_0_:checkRate(18, 0) == 1 then
        print("50%\136\200\137\186\130\204\136\208\138d\130\183\130\233\129I\129I\129I")
        _ARG_0_.stack:push("Threat")
        if Entity.IsTargetFront(_ARG_0_.myHandle, _ARG_0_.targetHandle) then
        else
          _ARG_0_.stack:push("RightAndLeftStep2")
        end
      elseif _ARG_0_:checkRate(18, 0) == 2 then
      end
    else
      if _ARG_0_:checkRate(26, 0) == 1 then
        _ARG_0_.stack:push("Idling")
        if _ARG_0_:checkRate(28, 0) == 1 then
          _ARG_0_.stack:push("WallIn")
        end
      else
        _ARG_0_.stack:push("BattleIdlingC")
      end
      if _ARG_0_:checkRate(20, 0) == 1 then
        _ARG_0_.stack:push("Idling")
      elseif _ARG_0_:checkRate(20, 0) == 2 then
        _ARG_0_.stack:push("BattleIdlingC")
      end
      if _ARG_0_:checkRate(10, 0) == 1 then
        if _ARG_0_:checkRate(22, 0) == 1 then
        elseif _ARG_0_:checkRate(22, 0) == 2 then
        else
        end
        print("\147\203\144i\130\240" .. 2 + 1 .. "\137\241\130\183\130\233.\n")
        _ARG_0_.stack:push("RightAndLeftStep2")
        for _FORV_9_ = 0, 2 do
          _ARG_0_:checkChainRoll()
          _ARG_0_.workStep = _ARG_0_.workStep + 1
        end
        _FOR_:push("FantomAttack_Rush_toFantom")
        _ARG_0_.stack:push("BackStep")
      elseif _ARG_0_:checkRate(10, 0) == 2 then
        if _ARG_0_:checkRate(12, 0) == 1 then
        elseif _ARG_0_:checkRate(12, 0) == 2 then
        else
        end
        print("\131m\131\148\131@\131W\131\131\131C\131A\131\147\131g\130\240" .. 2 + 1 .. "\137\241\130\183\130\233.\n")
        for _FORV_9_ = 0, 2 do
          _ARG_0_:checkChainRoll()
          if Script.Random() < 0.3 then
            _ARG_0_.stack:push("SparNova")
          else
            _ARG_0_.stack:push("SparNovaDwarf")
          end
        end
        _ARG_0_.shootStep = 0
        _ARG_0_.stack:push("BackStep")
      elseif _ARG_0_:checkRate(10, 0) == 3 then
        if _ARG_0_:checkRate(13, 0) == 1 then
        elseif _ARG_0_:checkRate(13, 0) == 2 then
        else
        end
        print("\131m\131\148\131@\131h\131\143\129[\131t\130\240" .. 2 + 1 .. "\137\241\130\183\130\233.\n")
        for _FORV_9_ = 0, 2 do
          _ARG_0_:checkChainRoll()
          if Script.Random() < 0.3 then
            _ARG_0_.stack:push("SparNova")
          else
            _ARG_0_.stack:push("SparNovaDwarf")
          end
        end
        _ARG_0_.shootStep = 0
        _ARG_0_.stack:push("BackStep")
      end
    end
    _ARG_0_.stack:push("RightAndLeftStep2")
  end,
  SettingsStateToBattole2DamageStep = function(_ARG_0_, _ARG_1_)
    if _UPVALUE0_ == 1 or _ARG_0_:GetState() == "NextBattleSetup" then
      return 0
    end
    if _ARG_0_.isDamageAfter == 1 then
      print("\130\183\130\197\130\201\131_\131\129\129[\131W\140\227\130\204\143\136\151\157\130\240\130\181\130\196\130\233\n")
      return 0
    end
    if _ARG_0_.stack:pop(1) == nil then
      print("\142\159\130\204\131X\131e\129[\131g\130\170\137\189\130\224\130\160\130\232\130\220\130\185\130\241\130\197\130\181\130\189\129B\n")
      _ARG_0_.stack:push("Idling")
    else
      _ARG_0_.stack:push("Idling")
      _ARG_0_.stack:push(nextsate)
    end
    if Entity.IsTargetFront(_ARG_0_.myHandle, _ARG_0_.targetHandle) then
      print("+-+-+-+-+-+-+-+-+\145O\149\251\131q\131b\131g+-+-+-+-+-+-+-+-\n")
      if _ARG_0_:checkRate(30, 0) == 1 then
        _ARG_0_:checkChainRoll()
        print("\131_\131\129\129[\131W\140\227\131X\131e\131b\131v\n")
      elseif _ARG_0_:checkRate(30, 0) == 2 then
        _ARG_0_.stack:push("TailAttack")
        _ARG_0_.stack:push("FeintJump")
        _ARG_0_.stack:push("RightAndLeftStep2")
        print("\131_\131\129\129[\131W\140\227\131t\131F\131C\131\147\131g\131W\131\131\131\147\131v\130\197\144K\148\246\141U\140\130\n")
      elseif _ARG_0_:checkRate(30, 0) == 3 then
        if _ARG_0_:checkRate(31, 0) == 1 then
          _ARG_0_.stack:push("Threat")
          if Entity.IsTargetFront(_ARG_0_.myHandle, _ARG_0_.targetHandle) then
          else
            _ARG_0_:checkChainRoll()
          end
          print("\131_\131\129\129[\131W\140\227\136\208\138d\n")
        elseif _ARG_0_:checkRate(31, 0) == 2 then
          _ARG_0_:checkChainRoll()
          print("\131_\131\129\129[\131W\140\227\131X\131e\131b\131v\n")
        elseif _ARG_0_:checkRate(31, 0) == 3 then
          _ARG_0_.stack:push("TailAttack")
          _ARG_0_.stack:push("FeintJump")
          _ARG_0_.stack:push("RightAndLeftStep2")
          print("\131_\131\129\129[\131W\140\227\131t\131F\131C\131\147\131g\131W\131\131\131\147\131v\130\197\144K\148\246\141U\140\130\n")
        else
        end
        if _ARG_1_ == ATK_KIND_DMG_BLOW then
          _ARG_0_.stack:push("FrontBigDamage")
          print("\145\229\131_\131\129\129[\131W\n")
        end
      end
    else
      if _ARG_0_:checkRate(32, 0) == 1 then
        _ARG_0_.stack:push("TailAttack")
        print("\131_\131\129\129[\131W\140\227 \144K\148\246\141U\140\130\n")
      else
      end
      if _ARG_1_ == ATK_KIND_DMG_BLOW then
        _ARG_0_.stack:push("FrontBigDamage")
        print("\145\229\131_\131\129\129[\131W\n")
      end
    end
    if 0 == 1 then
      print("\131_\131\129\129[\131W\130\240\142\243\130\175\130\200\130\162\129I\129I\n")
    else
      print("\131_\131\129\129[\131W\142\243\130\175\130\233\129\171\129\171\129\171\n")
    end
    if 0 == 1 then
      _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      print("\137\189\130\169\141s\147\174\130\183\130\233\n")
      _ARG_0_.isDamageAfter = 1
    else
      print("\130\200\130\241\130\224\141s\147\174\130\240\130\181\130\200\130\162\n")
    end
    return 0
  end,
  SettingsTargetCounter = function(_ARG_0_, _ARG_1_)
  end,
  checkChainRoll = function(_ARG_0_)
    print("\131X\131e\131b\131v\130\169\131`\131F\129[\131\139\131\147\131\141\129[\131\139\130\169\130\204\131`\131F\131b\131N\n")
    if _ARG_0_:checkRate(33, 0) == 1 and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) >= _UPVALUE0_ then
      if Script.Random() < 0.5 then
        _ARG_0_.stack:push("BattleIdlingC")
        _ARG_0_.stack:push("ChainRoll")
        print("\140\139\137\202 \131`\131F\129[\131\147\131\141\129[\131\139\n")
      else
        if _ARG_0_:checkRate(12, 0) == 1 then
        elseif _ARG_0_:checkRate(12, 0) == 2 then
        else
        end
        print("\131m\131\148\131@\131W\131\131\131C\131A\131\147\131g\130\240" .. 2 + 1 .. "\137\241\130\183\130\233.\n")
        for _FORV_7_ = 0, 2 do
          _ARG_0_:checkChainRollOnly()
          if Script.Random() < 0.3 then
            _ARG_0_.stack:push("SparNova")
          else
            _ARG_0_.stack:push("SparNovaDwarf")
          end
        end
        _ARG_0_.shootStep = 0
        _ARG_0_.stack:push("BackStep")
        print("\140\139\137\202 \131m\131\148\131@\n")
      end
      return 1
    else
      print("\140\139\137\202\131X\131e\131b\131v\n")
      _ARG_0_.stack:push("RightAndLeftStep2")
      return 0
    end
    return 0
  end,
  checkChainRollOnly = function(_ARG_0_)
    if _ARG_0_:checkRate(33, 0) == 1 and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) >= _UPVALUE0_ then
      _ARG_0_.stack:push("BattleIdlingC")
      _ARG_0_.stack:push("ChainRoll")
      return 1
    else
      _ARG_0_.stack:push("RightAndLeftStep2")
      return 0
    end
    return 0
  end,
  checkJumpBiteCancel = function(_ARG_0_)
    if _ARG_0_:checkRate(34, 0) == 1 then
      _ARG_0_.stack:push("BattleIdlingC")
      _ARG_0_.stack:push("TailAttack")
      _ARG_0_.stack:push("JumpBiteCancel")
      _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      return 1
    end
    return 0
  end,
  CreaeVisions = function(_ARG_0_)
    if _UPVALUE0_ == 1 and _UPVALUE1_ == 1 then
      _UPVALUE2_:set(1, 1, 1)
      CreateVision(_ARG_0_.myHandle, _UPVALUE2_, 3)
    end
  end,
  DeleteVisions = function(_ARG_0_)
    if _UPVALUE0_ == 1 and _UPVALUE1_ == 1 then
      DeleteVision(_ARG_0_.myHandle)
    end
  end,
  RestHpRate = function(_ARG_0_)
    return Enemy.GetHp(_ARG_0_.myHandle) / Enemy.GetHpMax(_ARG_0_.myHandle)
  end,
  isFastBoss = function(_ARG_0_)
    return 1
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    _UPVALUE0_ = Entity.GetMotionIndex(_ARG_1_, "010")
    _UPVALUE1_ = Entity.GetMotionIndex(_ARG_1_, "011")
    _UPVALUE2_ = Entity.GetMotionIndex(_ARG_1_, "012")
    _UPVALUE3_ = Entity.GetMotionIndex(_ARG_1_, "030")
    _UPVALUE4_ = Entity.GetMotionIndex(_ARG_1_, "031")
    _UPVALUE5_ = Entity.GetMotionIndex(_ARG_1_, "032")
    _UPVALUE6_ = Entity.GetMotionIndex(_ARG_1_, "033")
    _UPVALUE7_ = Entity.GetMotionIndex(_ARG_1_, "034")
    _UPVALUE8_ = Entity.GetMotionIndex(_ARG_1_, "035")
    _UPVALUE9_ = Entity.GetMotionIndex(_ARG_1_, "036")
    _UPVALUE10_ = Entity.GetMotionIndex(_ARG_1_, "037")
    _UPVALUE11_ = Entity.GetMotionIndex(_ARG_1_, "038")
    _UPVALUE12_ = Entity.GetMotionIndex(_ARG_1_, "220")
    _UPVALUE13_ = Entity.GetMotionIndex(_ARG_1_, "221")
    _UPVALUE14_ = Entity.GetMotionIndex(_ARG_1_, "222")
    _UPVALUE15_ = Entity.GetMotionIndex(_ARG_1_, "230")
    _UPVALUE16_ = Entity.GetMotionIndex(_ARG_1_, "231")
    _UPVALUE17_ = Entity.GetMotionIndex(_ARG_1_, "300")
    _UPVALUE18_ = Entity.GetMotionIndex(_ARG_1_, "301")
    _UPVALUE19_ = Entity.GetMotionIndex(_ARG_1_, "302")
    _UPVALUE20_ = Entity.GetMotionIndex(_ARG_1_, "303")
    _UPVALUE21_ = Entity.GetMotionIndex(_ARG_1_, "304")
    _UPVALUE22_ = Entity.GetMotionIndex(_ARG_1_, "305")
    _UPVALUE23_ = Entity.GetMotionIndex(_ARG_1_, "306")
    _UPVALUE24_ = Entity.GetMotionIndex(_ARG_1_, "307")
    _UPVALUE25_ = Entity.GetMotionIndex(_ARG_1_, "308")
    _UPVALUE26_ = Entity.GetMotionIndex(_ARG_1_, "309")
    _UPVALUE27_ = Entity.GetMotionIndex(_ARG_1_, "310")
    _UPVALUE28_ = Entity.GetMotionIndex(_ARG_1_, "311")
    _UPVALUE29_ = Entity.GetMotionIndex(_ARG_1_, "312")
    _UPVALUE30_ = Entity.GetMotionIndex(_ARG_1_, "313")
    _ARG_0_.stack = Stack:Create()
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.targetHandle = NULL_HANDLE
    _UPVALUE31_ = NULL_HANDLE
    _ARG_0_.megaHandle = NULL_HANDLE
    _UPVALUE32_ = NULL_HANDLE
    _UPVALUE33_ = NULL_HANDLE
    _ARG_0_.eyeLight = NULL_HANDLE
    _ARG_0_.rushEffHandle1 = NULL_HANDLE
    _ARG_0_.rushEffHandle2 = NULL_HANDLE
    _ARG_0_.fantomFilter = NULL_HANDLE
    _ARG_0_.wallRushHandle = NULL_HANDLE
    _ARG_0_.chainGrand1 = NULL_HANDLE
    _ARG_0_.chainGrand2 = NULL_HANDLE
    _ARG_0_.camera = NULL_HANDLE
    _ARG_0_.cameraAttach = NULL_HANDLE
    _ARG_0_.cameraTyep = 0
    _ARG_0_.step = 0
    _ARG_0_.nextState = 0
    _ARG_0_.workStep = 0
    _ARG_0_.shootStep = 0
    _ARG_0_.fantomID = 0
    _ARG_0_.trunAngle = 0
    _ARG_0_.isDamageAfter = 0
    _ARG_0_.motionEndFlag = 0
    _ARG_0_.workTimer = 0
    _ARG_0_.timer = 0
    _ARG_0_.cameraStep = 0
    _ARG_0_.HitAttackFlag = 0
    _ARG_0_.jumpYPow = 0
    _ARG_0_.gameSpeed = 0
    _ARG_0_.Speed = 0
    _ARG_0_.WallAngle = 0
    _ARG_0_.WallAnglePow = 0
    _ARG_0_.CenterDist = 0
    _ARG_0_.AttackTimer = 0
    _ARG_0_.AttackFlag = 0
    _ARG_0_.battleMode = 0
    _ARG_0_.cameraTimer = 0
    _ARG_0_.cameraEndTimer = 0
    _ARG_0_.cameraFlag = 0
    _ARG_0_.camera = NULL_HANDLE
    _ARG_0_.cameraType = 0
    _ARG_0_.damageCount = 0
    _ARG_0_.nowMoveDist = 0
    _ARG_0_.NextFlag = 0
    _ARG_0_.fogOnFlag = 0
    _ARG_0_.FadeOutFlag = 0
    _ARG_0_.neckAngle = 0
    _ARG_0_.StartPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.wallAttackFlag = 0
    _ARG_0_.FantomHandleList = {}
    for _FORV_5_ = 0, 5 do
      _ARG_0_.FantomHandleList[_FORV_5_] = {handle = NULL_HANDLE}
    end
    _ARG_0_.LookMaxMin = _FOR_
    _ARG_0_.LookMaxMin[0] = {
      Max = DegToRad(45),
      Min = DegToRad(-45)
    }
    _ARG_0_.LookMaxMin[1] = {
      Max = DegToRad(50),
      Min = DegToRad(-50)
    }
    _ARG_0_.NeckPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.oldAnglx = 0
    _ARG_0_.oldAngly = 0
    _ARG_0_.oldCameraAnglx = 0
    _ARG_0_.oldCameraAngly = 0
    _ARG_0_.oldCameraAnglz = 0
    _UPVALUE34_ = NULL_HANDLE
    if B02EX_INIT_PARAM == false then
      _UPVALUE35_ = 1
      _UPVALUE36_ = _ARG_1_
      _UPVALUE37_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "B1IdlingF")
      _UPVALUE38_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "B1AttackTS")
      _UPVALUE39_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "B1AttackTM")
      _UPVALUE40_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "NextBHpR") * 0.01
      _UPVALUE41_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "AttAfetTim") * 60
      _UPVALUE42_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "WRTimer") * 60
      _UPVALUE43_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "PhaBHpR") * 0.01
      B02EX_INIT_PARAM = true
    end
    print("B02EX_FOG2_DIST_1 = " .. _UPVALUE44_ .. "\n")
    print("B02EX_FOG2_DIST_2 = " .. _UPVALUE45_ .. "\n")
    _UPVALUE44_ = Script.GetFogNear()
    _UPVALUE45_ = Script.GetFogFar()
    print("GetFog B02EX_FOG2_DIST_1 = " .. _UPVALUE44_ .. "\n")
    print("GetFog B02EX_FOG2_DIST_2 = " .. _UPVALUE45_ .. "\n")
    _ARG_0_.FogColor_r = 0
    _ARG_0_.FogColor_g = 0
    _ARG_0_.FogColor_b = 0
    _ARG_0_.FogColor_a = 0
    _ARG_0_.FogColor_a, _ARG_0_.FogColor_b, _ARG_0_.FogColor_g, _ARG_0_.FogColor_r = Script.GetFogColor()
    print("Fog Color r = " .. _ARG_0_.FogColor_r .. "\n")
    print("Fog Color r = " .. _ARG_0_.FogColor_g .. "\n")
    print("Fog Color r = " .. _ARG_0_.FogColor_b .. "\n")
    print("Fog Color r = " .. _ARG_0_.FogColor_a .. "\n")
    Entity.SetMovementCollRadius(_ARG_0_.myHandle, 4.2)
    Entity.SetLowerHalf(_ARG_0_.myHandle, 4.3)
    Player.SetBossCamera("b02ex")
    Entity.EnableCameraBodyColl(_ARG_0_.myHandle, 1)
    Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
    Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
    Entity.EnableLockon(_ARG_0_.myHandle, 0)
    Entity.EnableGravity(_ARG_0_.myHandle, 1)
    Entity.SetLockOnBoneNum(_ARG_1_, _UPVALUE46_)
    if Enemy.IsAllEnemyWaiting() then
      _ARG_0_:GotoState("Standby")
    else
      _ARG_0_:GotoState("Appear")
    end
  end,
  OnDamage = function(_ARG_0_, _ARG_1_, _ARG_2_)
    return 1
  end,
  OnDamageBefore = function(_ARG_0_, _ARG_1_, _ARG_2_)
    print("kind = " .. _ARG_1_ .. "\n")
    if _ARG_0_:GetState() == "NextBattleSetup" or _ARG_0_:GetState() == "WallIn" or _ARG_0_:GetState() == "WallNow" or _ARG_0_:GetState() == "WallEnd" then
      return
    end
    if _ARG_1_ == ATK_KIND_DETONE then
      return 1
    end
    _ARG_0_.damageCount = _ARG_0_.damageCount + 1
    if _UPVALUE0_ == 1 then
      _ARG_0_.AttackTimer = _ARG_0_.AttackTimer - 40
    end
    if _ARG_0_.fantomID ~= 0 then
      return 1
    end
    if _ARG_0_.wallAttackFlag == 1 then
      return 0
    end
    if _UPVALUE0_ == 1 then
    else
      if Player.GetPlayerState(_ARG_0_.targetHandle) == 23 then
        print("\131J\131E\131\147\131^\129[\130\197\130\204\141U\140\130\130\197\130\183\130\230\130\193\n")
        if _ARG_0_:GetState() == "BattleIdlingC" or _ARG_0_:GetState() == "TailAttack" or _ARG_0_:GetState() == "FeintJump" or _ARG_0_:GetState() == "JumpBiteCancel" then
        elseif Script.Random() < _UPVALUE1_ then
          print("\148\189\140\130\129I\129I\n")
          _ARG_0_.stack:push("BattleIdlingC")
          _ARG_0_.stack:push("TailAttack")
          _ARG_0_.stack:push("FeintJump")
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          _ARG_0_.isDamageAfter = 1
          return 1
        end
      else
      end
    end
    return _ARG_0_:SettingsStateToBattole2DamageStep(_ARG_1_)
  end,
  IsDetone = function(_ARG_0_)
    Entity.GetLocalPos(_UPVALUE0_, _ARG_0_.myHandle)
    _ARG_0_.plShootBulletHandle = Player.GetNearBullet(_ARG_0_.targetHandle, _UPVALUE0_)
    if _ARG_0_.plShootBulletHandle ~= NULL_HANDLE then
      Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.plShootBulletHandle)
      if _UPVALUE0_:gety() < 0.01 then
        print("\131f\131g\131l\130\160\130\233\130\230\129B\n")
      end
    end
    return true
  end,
  OnDead = function(_ARG_0_)
    print("\142\128\150S.")
    SetupBossDead(_ARG_0_.myHandle)
    _ARG_0_:GotoState("Dead")
    return 1
  end,
  OnHitAttack = function(_ARG_0_, _ARG_1_)
    if _ARG_0_:GetState() == "FantomAttack_RotRush_toFantom" then
      Entity.SetAACNoUpdateAttackID(_ARG_0_.myHandle, 1)
    end
    if _ARG_1_ == _ARG_0_.targetHandle then
      _ARG_0_.HitAttackFlag = 1
    end
    return 1
  end,
  OnReflect = function(_ARG_0_)
    if _UPVALUE0_ == 1 then
      _ARG_0_.stack:push("Idling1")
      _ARG_0_.stack:push("BackStep1")
      _ARG_0_.stack:push("AttackAfterIdling")
      _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
    end
  end,
  OnReturnDamage = function(_ARG_0_)
  end,
  OnUpdatePositionAfter = function(_ARG_0_)
    _ARG_0_:Neck()
    _ARG_0_:Chain()
  end,
  Chain = function(_ARG_0_)
    if _ARG_0_:GetState() ~= "ChainRoll" then
      return
    end
    if Entity.GetMotionNowFrame(_ARG_0_.myHandle) < 6 or Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 25 then
      _UPVALUE0_:set(0, 0, 0)
      Entity.RotateBoneXYZ(_ARG_0_.myHandle, _UPVALUE1_, _UPVALUE0_)
      Entity.RotateBoneXYZ(_ARG_0_.myHandle, _UPVALUE2_, _UPVALUE0_)
      for _FORV_7_ = _UPVALUE2_ + 1, _UPVALUE3_ - 1 do
        _UPVALUE4_:set(0, 0, 0)
        Entity.GetRot(_UPVALUE5_, _ARG_0_.myHandle)
        Entity.SetLocalBoneTrans(_ARG_0_.myHandle, _UPVALUE4_, _FORV_7_)
      end
      for _FORV_7_ = _FOR_ + 1, _UPVALUE6_ - 1 do
        _UPVALUE4_:set(0, 0, 0)
        Entity.GetRot(_UPVALUE5_, _ARG_0_.myHandle)
        Entity.SetLocalBoneTrans(_ARG_0_.myHandle, _UPVALUE4_, _FORV_7_)
      end
      return
    end
    if 1 == 1 then
      Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle, 2)
      Entity.GetWorldPos(_UPVALUE7_, _ARG_0_.myHandle, _UPVALUE1_)
      FVECTOR3.Sub(_UPVALUE7_, _ARG_0_.targetPos, _UPVALUE7_)
      FVECTOR3.normalize(_UPVALUE7_)
      _UPVALUE0_:set(0, 0, RoundPI(-Math.Atan2(_UPVALUE7_:gety(), Math.Sqrt(_UPVALUE7_:getz() * _UPVALUE7_:getz() + _UPVALUE7_:getx() * _UPVALUE7_:getx())) * -1))
      Entity.RotateBoneXYZ(_ARG_0_.myHandle, _UPVALUE1_ + 1, _UPVALUE0_)
    end
    Entity.GetWorldPos(_UPVALUE7_, _ARG_0_.myHandle, _UPVALUE1_)
    for _FORV_7_ = _UPVALUE1_ + 1, _UPVALUE6_ - 1 do
      _UPVALUE4_:set(Entity.CalcDistance(_ARG_0_.targetHandle, _UPVALUE7_) / 13, 0, 0)
      Entity.GetRot(_UPVALUE5_, _ARG_0_.myHandle)
      Entity.SetLocalBoneTrans(_ARG_0_.myHandle, _UPVALUE4_, _FORV_7_)
    end
    if 1 == 1 then
      Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle, 2)
      Entity.GetWorldPos(_UPVALUE7_, _ARG_0_.myHandle, _UPVALUE1_)
      FVECTOR3.Sub(_UPVALUE7_, _ARG_0_.targetPos, _UPVALUE7_)
      FVECTOR3.normalize(_UPVALUE7_)
      _UPVALUE0_:set(0, 0, RoundPI(-Math.Atan2(_UPVALUE7_:gety(), Math.Sqrt(_UPVALUE7_:getz() * _UPVALUE7_:getz() + _UPVALUE7_:getx() * _UPVALUE7_:getx())) * -1))
      Entity.RotateBoneXYZ(_ARG_0_.myHandle, _UPVALUE2_ + 1, _UPVALUE0_)
    end
    Entity.GetWorldPos(_UPVALUE7_, _ARG_0_.myHandle, _UPVALUE1_)
    for _FORV_7_ = _UPVALUE2_ + 1, _UPVALUE3_ - 1 do
      _UPVALUE4_:set(Entity.CalcDistance(_ARG_0_.targetHandle, _UPVALUE7_) / 13, 0, 0)
      Entity.GetRot(_UPVALUE5_, _ARG_0_.myHandle)
      Entity.SetLocalBoneTrans(_ARG_0_.myHandle, _UPVALUE4_, _FORV_7_)
    end
    if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 9 then
      if _ARG_0_.chainGrand1 == NULL_HANDLE then
        Entity.GetWorldPos(_UPVALUE7_, _ARG_0_.myHandle, _UPVALUE3_ - 1)
        _UPVALUE5_:set(0, 0, 0)
        _UPVALUE7_:sety(0.001)
        _ARG_0_.chainGrand1 = Entity.SetEffect(_ARG_0_.myHandle, "b02ex00", "B039_CHN_SMK0_0", _UPVALUE7_, _UPVALUE5_)
      else
      end
      if _ARG_0_.chainGrand2 == NULL_HANDLE then
        Entity.GetWorldPos(_UPVALUE7_, _ARG_0_.myHandle, _UPVALUE6_ - 1)
        _UPVALUE7_:sety(0.001)
        _UPVALUE5_:set(0, 0, 0)
        _ARG_0_.chainGrand2 = Entity.SetEffect(_ARG_0_.myHandle, "b02ex00", "B039_CHN_SMK0_0", _UPVALUE7_, _UPVALUE5_)
      end
    else
    end
  end,
  Neck = function(_ARG_0_)
    if _ARG_0_:GetState() == "TrunPleyr" or _ARG_0_:GetState() == "TailAttack" or _ARG_0_:GetState() == "FantomAttack" or _ARG_0_:GetState() == "FantomAttack_RFing_toFantom" or _ARG_0_:GetState() == "FantomAttack_LFing_toFantom" or _ARG_0_:GetState() == "FantomAttack_Tail_toFantom" or _ARG_0_:GetState() == "TrunPleyr" or _ARG_0_:GetState() == "NextBattleSetup" or _ARG_0_:GetState() == "ToPhantom" or _ARG_0_:GetState() == "Threat" then
      _ARG_0_.oldAnglx = 0
      _ARG_0_.oldAngly = 0
      _UPVALUE0_:set(0, 0, 0)
      Entity.RotateBoneZYX(_ARG_0_.myHandle, _UPVALUE1_, _UPVALUE0_)
    elseif _ARG_0_:GetState() == "SparNova" or _ARG_0_:GetState() == "SparNovaDwarf" or _ARG_0_:GetState() == "Battole1SparNova" then
      Entity.GetRot(_UPVALUE2_, _ARG_0_.myHandle)
      _UPVALUE0_:set(0, RoundPI(DegToRad((_UPVALUE2_:gety() + RoundPI(_ARG_0_.neckAngle)) * -1)), 0)
      Entity.RotateBoneZYX(_ARG_0_.myHandle, _UPVALUE1_, _UPVALUE0_)
    else
      _UPVALUE3_:set(0, 1, 0)
      if Entity.IsTargetWithinFOV(_ARG_0_.myHandle, _ARG_0_.targetHandle, DegToRad(240), 0) then
        Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.targetHandle, 0)
        _UPVALUE0_:sety(_UPVALUE0_:gety() + 2)
        Entity.GetWorldPos(_UPVALUE4_, _ARG_0_.myHandle, _UPVALUE1_)
        Entity.GetRot(_UPVALUE2_, _ARG_0_.myHandle)
        FVECTOR3.Sub(_UPVALUE4_, _UPVALUE0_, _UPVALUE4_)
        FVECTOR3.normalize(_UPVALUE4_)
        _ARG_0_.oldAngly, _ARG_0_.oldAnglx = HomingDegree(_ARG_0_.oldAngly, Math.Atan2(_UPVALUE4_:getx(), _UPVALUE4_:getz()) - _UPVALUE2_:gety(), 5, (Entity.GetFrameRate(_ARG_0_.myHandle))), HomingDegree(_ARG_0_.oldAnglx, -Math.Atan2(_UPVALUE4_:gety(), Math.Sqrt(_UPVALUE4_:getz() * _UPVALUE4_:getz() + _UPVALUE4_:getx() * _UPVALUE4_:getx())), 5, (Entity.GetFrameRate(_ARG_0_.myHandle)))
        _UPVALUE0_:set(0, RoundPI(HomingDegree(_ARG_0_.oldAngly, Math.Atan2(_UPVALUE4_:getx(), _UPVALUE4_:getz()) - _UPVALUE2_:gety(), 5, (Entity.GetFrameRate(_ARG_0_.myHandle))) * -1), RoundPI((HomingDegree(_ARG_0_.oldAnglx, -Math.Atan2(_UPVALUE4_:gety(), Math.Sqrt(_UPVALUE4_:getz() * _UPVALUE4_:getz() + _UPVALUE4_:getx() * _UPVALUE4_:getx())), 5, (Entity.GetFrameRate(_ARG_0_.myHandle))))))
        if _UPVALUE0_:gety() > _ARG_0_.LookMaxMin[0].Max then
          _UPVALUE0_:sety(_ARG_0_.LookMaxMin[0].Max)
        end
        if _UPVALUE0_:gety() < _ARG_0_.LookMaxMin[0].Min then
          _UPVALUE0_:sety(_ARG_0_.LookMaxMin[0].Min)
        end
        if _UPVALUE0_:getz() > _ARG_0_.LookMaxMin[1].Max then
          _UPVALUE0_:setz(_ARG_0_.LookMaxMin[1].Max)
        end
        if _UPVALUE0_:getz() < _ARG_0_.LookMaxMin[1].Min then
          _UPVALUE0_:setz(_ARG_0_.LookMaxMin[1].Min)
        end
        Entity.RotateBoneZYX(_ARG_0_.myHandle, _UPVALUE1_, _UPVALUE0_)
      else
        Angy, Angx = HomingDegree(_ARG_0_.oldAngly, 0, 2, (Entity.GetFrameRate(_ARG_0_.myHandle))), HomingDegree(_ARG_0_.oldAnglx, 0, 2, (Entity.GetFrameRate(_ARG_0_.myHandle)))
        _ARG_0_.oldAnglx = Angx
        _ARG_0_.oldAngly = Angy
        _UPVALUE0_:set(0, RoundPI(Angy * -1), RoundPI(Angx))
        if _UPVALUE0_:gety() > _ARG_0_.LookMaxMin[0].Max then
          _UPVALUE0_:sety(_ARG_0_.LookMaxMin[0].Max)
        end
        if _UPVALUE0_:gety() < _ARG_0_.LookMaxMin[0].Min then
          _UPVALUE0_:sety(_ARG_0_.LookMaxMin[0].Min)
        end
        if _UPVALUE0_:getz() > _ARG_0_.LookMaxMin[1].Max then
          _UPVALUE0_:setz(_ARG_0_.LookMaxMin[1].Max)
        end
        if _UPVALUE0_:getz() < _ARG_0_.LookMaxMin[1].Min then
          _UPVALUE0_:setz(_ARG_0_.LookMaxMin[1].Min)
        end
        Entity.RotateBoneZYX(_ARG_0_.myHandle, _UPVALUE1_, _UPVALUE0_)
      end
    end
  end,
  CreateCamera = function(_ARG_0_)
    if _UPVALUE0_ == NULL_HANDLE then
      Entity.GetWorldPos(_UPVALUE1_, Player.GetHandle(), 2)
      Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.myHandle, 28)
      _UPVALUE3_:set(_UPVALUE1_:getx(), _UPVALUE1_:gety(), _UPVALUE1_:getz())
      _UPVALUE4_:set(_UPVALUE2_:getx(), _UPVALUE2_:gety(), _UPVALUE2_:getz())
      _UPVALUE0_ = Camera.CameraCreate(_UPVALUE4_, _UPVALUE3_)
      Camera.SetCameraViewAngle(_UPVALUE0_, DegToRad(_UPVALUE5_))
      Camera.SetViewCollision(_UPVALUE0_, true)
    end
  end,
  updateCamera = function(_ARG_0_)
    Entity.GetWorldPos(_UPVALUE0_, Player.GetHandle())
  end,
  cameraEnd = function(_ARG_0_)
    _ARG_0_.cameraEndTimer = -1
  end,
  cameraJob = function(_ARG_0_)
    if _ARG_0_:GetState() == "Standby" then
      return
    end
    _ARG_0_.AttackTimer = _ARG_0_.AttackTimer - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
    if _ARG_0_.AttackTimer < 0 and _ARG_0_.AttackFlag == 0 then
      _ARG_0_.AttackFlag = 1
    end
    if _UPVALUE0_ ~= 1 or _ARG_0_.cameraStep == _UPVALUE1_ then
    elseif _ARG_0_.cameraStep == _UPVALUE2_ then
      _ARG_0_.cameraStep = _UPVALUE3_
      SetupFisheyeLens(_ARG_0_.myHandle, 80, 2, 3)
      _UPVALUE4_:set(0, 0, 0)
      if _UPVALUE5_ == NULL_HANDLE then
        _UPVALUE5_ = Entity.SetEffect(_ARG_0_.myHandle, "b02ex00", "B039_VIS_FLT0_0", _UPVALUE4_, _UPVALUE4_)
      end
    elseif _ARG_0_.cameraStep == _UPVALUE3_ then
      if _ARG_0_.cameraEndTimer < 5 and _UPVALUE6_ == NULL_HANDLE then
        print("\136\234\137\158\130\198\130\193\130\196\130\233\130\230\129B\n")
        _UPVALUE4_:set(0, 0, 0)
        _UPVALUE6_ = Entity.SetEffect(_ARG_0_.myHandle, "b02ex00", "B039_VIS_FLT1_0", _UPVALUE4_, _UPVALUE4_)
        Effect.Fadeout(_UPVALUE5_, 2)
        _UPVALUE5_ = NULL_HANDLE
      end
      if 0 > _ARG_0_.cameraEndTimer then
        _ARG_0_.cameraStep = _UPVALUE1_
        _UPVALUE5_ = NULL_HANDLE
        _UPVALUE6_ = NULL_HANDLE
        if _ARG_0_.cameraType == _UPVALUE7_ then
        end
      else
      end
      _ARG_0_.cameraEndTimer = _ARG_0_.cameraEndTimer - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
    end
    Entity.GetWorldPos(_UPVALUE8_, _ARG_0_.myHandle, 28)
    _UPVALUE9_:set(_UPVALUE8_:getx(), _UPVALUE8_:gety(), _UPVALUE8_:getz())
  end,
  OnUpdate = function(_ARG_0_)
    _ARG_0_:Update()
    _ARG_0_:Debug()
    if _ARG_0_:isFastBoss() == 0 then
      return
    end
    if Script.GetDebugTestParam() == 0 then
      if _UPVALUE0_ == 1 and _ARG_0_:RestHpRate() < _UPVALUE1_ and _ARG_0_.NextFlag == 0 then
        _UPVALUE0_ = 0
        _ARG_0_.NextFlag = 1
        _ARG_0_.stack:push("NextBattleSetup")
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      end
      if _UPVALUE2_ == 0 and _ARG_0_:RestHpRate() < _UPVALUE3_ then
        _ARG_0_.stack:push("ToPhantom")
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        _UPVALUE2_ = 1
      end
    elseif Script.GetDebugTestParam() < 1 then
      if _UPVALUE0_ == 1 then
        _UPVALUE0_ = 0
        _UPVALUE4_:set(0, 0.1, 0)
        _UPVALUE5_:set(0, 0, 0)
        Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE4_)
        Entity.SetOldLocalPos(_ARG_0_.myHandle, _UPVALUE4_)
        Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, 1)
        Entity.EnableBgColl(_ARG_0_.myHandle, 1)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
      elseif _UPVALUE2_ == 1 then
        _UPVALUE2_ = 0
      end
    elseif Script.GetDebugTestParam() < 2 then
      if _UPVALUE0_ == 1 then
        _UPVALUE4_:set(0, 0.1, 0)
        _UPVALUE5_:set(0, 0, 0)
        Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE4_)
        Entity.SetOldLocalPos(_ARG_0_.myHandle, _UPVALUE4_)
        Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, 1)
        Entity.EnableBgColl(_ARG_0_.myHandle, 1)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        _UPVALUE0_ = 0
      elseif _UPVALUE2_ == 0 then
        _UPVALUE2_ = 1
      end
    else
      _UPVALUE0_ = 1
      _UPVALUE2_ = 0
    end
    if _ARG_0_.fantomID == 0 then
      debugPrint(0, 20, "AT = " .. _ARG_0_.AttackTimer / 60 .. "\n")
      _ARG_0_:cameraJob()
    end
  end,
  OnDestroy = function(_ARG_0_)
    Camera.CameraDestroy(_UPVALUE0_)
    _UPVALUE0_ = NULL_HANDLE
    _ARG_0_:OutEyeLight()
    Effect.KillEffect(_UPVALUE1_)
    Effect.KillEffect(_ARG_0_.fantomFilter)
    Effect.KillEffect(_ARG_0_.wallRushHandle)
    Script.SetPlaySpeed(1)
    Script.OutTask(_ARG_0_.camera)
    _UPVALUE2_:set(0, 0, 0)
    Script.SettingFog(_UPVALUE2_, _UPVALUE3_, _UPVALUE4_)
    Script.EnablePauseChecker()
  end,
  Debug = function(_ARG_0_)
    if Script.IsDebugCheckAttack() then
      for _FORV_5_, _FORV_6_ in pairs(_UPVALUE0_) do
        if _FORV_6_ == _ARG_0_:GetState() then
          return
        end
      end
      if Script.GetDebugAttackNumber() + 1 == 21 then
        _ARG_0_.cameraTyep = 0
        debugPrint(0, 30, "CameraName     = " .. "rush1_dp" .. "\n")
        return
      elseif Script.GetDebugAttackNumber() + 1 == 22 then
        _ARG_0_.cameraTyep = 1
        debugPrint(0, 30, "CameraName     = " .. "jump1_dp" .. "\n")
        return
      elseif Script.GetDebugAttackNumber() + 1 == 23 then
        _ARG_0_.cameraTyep = 2
        debugPrint(0, 30, "CameraName     = " .. "jump2_dp" .. "\n")
        return
      end
      if _UPVALUE0_[Script.GetDebugAttackNumber() + 1] ~= nil then
        _ARG_0_.stack:clear()
        if _UPVALUE1_ == 1 then
          _ARG_0_.stack:push("Idling1")
        else
          _ARG_0_.stack:push("Idling")
        end
        _ARG_0_.targetHandle = Player.GetHandle()
        _ARG_0_:GotoState(_UPVALUE0_[Script.GetDebugAttackNumber() + 1])
      end
    end
  end
}, {__index = __StateMachine})
EntityFactory:Add("b02ex00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("SparNovaJ", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("SparNovaD", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("SparNovaDBomb", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("RushFootImpact", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("FantomSprintImpact", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("cameraAttachb", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
