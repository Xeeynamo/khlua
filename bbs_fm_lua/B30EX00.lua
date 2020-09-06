setmetatable({
  new = function(_ARG_0_)
    return setmetatable(__StateMachine:new(), _UPVALUE0_)
  end,
  states = {
    Appear = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        Entity.SetLocalPos(_ARG_0_.myHandle, _ARG_0_.CenterVecter)
        Entity.SetOldLocalPos(_ARG_0_.myHandle, _ARG_0_.CenterVecter)
        Entity.SetRot(_ARG_0_.myHandle, 0, -4, 0)
        Enemy.SetFaceAnim(_ARG_0_.myHandle, _UPVALUE1_, _UPVALUE2_)
        _ARG_0_.timer = 300
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.EnemyType == true then
          if _ARG_0_.timer > 0 then
            _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
            if _ARG_0_.timer <= 0 then
              Script.SetObjStop(OBJ_BIT_PLAYER)
              _ARG_0_.timer = 0
            end
          end
          if Enemy.IsAllEnemyWaiting() == false and _ARG_0_.EnemyType == true then
            _ARG_0_:GotoState("Sniper")
            _ARG_0_.RoundShoot = false
            _ARG_0_.WarpShoot = false
            _ARG_0_.InvertedShoot = false
            _ARG_0_.ChargeShoot = false
          end
        elseif Enemy.IsAllEnemyWaiting() == false then
          Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
          Script.SetObjStart(OBJ_BIT_PLAYER)
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    Idling = {
      OnBeginState = function(_ARG_0_)
        print("Idling\n")
        _ARG_0_.WarpStep = 0
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        print("Idling\129@end\n")
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.EnableAttack == true then
          if _ARG_0_.WarpShoot == true and _ARG_0_.InvertedShoot == true then
            if _ARG_0_.EnemyType == true then
              if _ARG_0_.RoundShoot == false then
                _ARG_0_:GotoState("RoundShoot")
                _ARG_0_.RoundShoot = true
              else
                _ARG_0_:GotoState("Sniper")
                _ARG_0_.RoundShoot = false
                _ARG_0_.WarpShoot = false
                _ARG_0_.InvertedShoot = false
                _ARG_0_.ChargeShoot = false
              end
            elseif _ARG_0_.RoundShoot == false then
              _ARG_0_:GotoState("RoundShoot")
              _ARG_0_.RoundShoot = true
            elseif _ARG_0_.ArutemaShoot == false then
              _ARG_0_:GotoState("ArutemaShoot")
              _ARG_0_.ArutemaShoot = true
            else
              _ARG_0_:GotoState("DashShoot")
              _ARG_0_.RoundShoot = true
              _ARG_0_.ArutemaShoot = false
              _ARG_0_.WarpShoot = false
              _ARG_0_.InvertedShoot = false
              _ARG_0_.ChargeShoot = false
            end
          elseif _ARG_0_.EnemyType == false and _ARG_0_.RoundShoot == false then
            _ARG_0_:GotoState("RoundShoot")
            _ARG_0_.RoundShoot = true
          elseif _ARG_0_.ChargeShoot == true then
            _ARG_0_:GotoState("ChargeShoot")
            _ARG_0_.ChargeShoot = false
          else
            if _ARG_0_.InvertedShoot == false and _ARG_0_.WarpShoot == false then
              if Script.Random() < 0.5 then
                _ARG_0_:GotoState("WarpShoot")
                _ARG_0_.WarpShoot = true
              else
                _ARG_0_:GotoState("InvertedShoot")
                _ARG_0_.InvertedShoot = true
              end
            elseif _ARG_0_.InvertedShoot == false and _ARG_0_.WarpShoot == true then
              _ARG_0_:GotoState("InvertedShoot")
              _ARG_0_.InvertedShoot = true
            elseif _ARG_0_.InvertedShoot == true and _ARG_0_.WarpShoot == false then
              _ARG_0_:GotoState("WarpShoot")
              _ARG_0_.WarpShoot = true
            end
            _ARG_0_.RoundShoot = false
            _ARG_0_.ChargeShoot = true
          end
        else
        end
      end
    },
    WaitIdling = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.timer = Script.RandomInRange(_ARG_0_.WaitIdlingLowTime, _ARG_0_.WaitIdlingHeightTime)
        _ARG_0_.WarpStep = 0
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.WaitIdlingPattern == false then
          if _ARG_0_.step == 0 then
            _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
            if 0 >= _ARG_0_.timer then
              _ARG_0_.WarpStep = 0
              _ARG_0_.step = 1
            end
          elseif _ARG_0_.step == 1 and _ARG_0_:Warp(_UPVALUE0_) == true then
            _ARG_0_:GotoState("Idling")
          end
        elseif _ARG_0_.step == 0 then
          if _ARG_0_:Warp(_UPVALUE0_) == true then
            _ARG_0_.WarpStep = 0
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 >= _ARG_0_.timer then
            _ARG_0_:GotoState("Idling")
          end
        end
      end
    },
    Sniper = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_.AttackReleaseHP = Enemy.GetHp(_ARG_0_.myHandle) - _ARG_0_.SniperReleaseHP
        Player.SetBattleFlagBraigSnipeOn(1)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        _ARG_0_.cancelDam = 0
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        if _ARG_0_.SniperInit == 1 then
          _ARG_0_.step = 20
        else
          _ARG_0_.step = 0
        end
        _ARG_0_.WarpStep = 0
        _ARG_0_.voiceTimer = 60
        _ARG_0_.timer = _ARG_0_.SniperTime * 60
        Sound.PlayVoice(109, 4)
        _ARG_0_.LargeArrowtimer = Script.RandomInRange(60, 180)
        _ARG_0_.SmallArrowtimer = Script.RandomInRange(60, 180)
        _ARG_0_.fLargeRotZ = 0
        _ARG_0_.fSmallRotZ = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        if Player.GetPlayerHP() <= 0 then
          Camera.CameraDestroy(_ARG_0_.cameraHandle)
          Sprite2D.Destroy(_ARG_0_.TargetLargeHandle)
          Sprite2D.Destroy(_ARG_0_.TargetSmallHandle)
          _ARG_0_.TargetLargeHandle = NULL_HANDLE
          _ARG_0_.TargetSmallHandle = NULL_HANDLE
          return
        end
        _ARG_0_:RotArrow()
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.playerHandle, 10)
        if _ARG_0_.step == 0 then
          Entity.ClearSpeed(_ARG_0_.myHandle)
          _ARG_0_:Warp(_UPVALUE0_)
          if _ARG_0_.WarpStep == 2 then
            Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
            _ARG_0_.cameraHandle = Camera.CameraCreate(_UPVALUE1_, _UPVALUE2_)
            Camera.SetCameraViewAngle(_ARG_0_.cameraHandle, DegToRad(30))
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if _ARG_0_:Warp(_UPVALUE0_) == true then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
            Entity.EnableGravity(_ARG_0_.myHandle, 0)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 33 then
            Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
            _ARG_0_.step = 3
          end
        elseif _ARG_0_.step == 3 then
          Sprite2D.SetDispDefault(true)
          _ARG_0_.CamTimeer = 10
          _ARG_0_.CamPosSpeed = 0.008
          _ARG_0_.CamViewSpeed = 0.004
          _ARG_0_.cursolFrame = 0
          _ARG_0_.TargetLargeHandle = Sprite2D.CreateLay("brig_00", 1, CTRL_IN_2D)
          print("self.TargetLargeHandle \141\236\144\172\129I\n")
          _ARG_0_.TargetSmallHandle = Sprite2D.CreateLay("brig_00", 0, CTRL_IN_2D)
          print("self.TargetSmallHandle \141\236\144\172\n")
          _ARG_0_.SniperShootTime = 0
          _ARG_0_.sprFlag = false
          _ARG_0_.ShootTimer = Script.RandomInRange(_ARG_0_.SniperShootLowTime, _ARG_0_.SniperShootHeightTime)
          _ARG_0_.shotCount = 0
          _ARG_0_.step = 4
        elseif _ARG_0_.step == 4 then
          _ARG_0_:SniperVoice((Entity.GetFrameRate(_ARG_0_.myHandle)))
          Entity.GetWorldPos(_UPVALUE4_, _ARG_0_.playerHandle, 5)
          Camera.CameraMovePos(_ARG_0_.cameraHandle, _UPVALUE5_, _ARG_0_.CamPosSpeed)
          Camera.CameraMoveView(_ARG_0_.cameraHandle, _UPVALUE4_, _ARG_0_.CamViewSpeed)
          _ARG_0_.CamPosSpeed = _ARG_0_.CamPosSpeed + 0.002
          if _ARG_0_.CamPosSpeed >= 0.2 then
            _ARG_0_.CamPosSpeed = 0.2
          end
          _ARG_0_.CamViewSpeed = _ARG_0_.CamViewSpeed + 0.004
          if _ARG_0_.CamViewSpeed >= 0.1 then
            _ARG_0_.CamViewSpeed = 0.1
          end
          Camera.CameraGetCameraPos(_UPVALUE6_, _ARG_0_.cameraHandle)
          if 0.2 >= Entity.CalcDistanceSq(_UPVALUE6_, _UPVALUE5_) then
            Entity.SetupModelFade(_ARG_0_.myHandle, 0, 0, 0.1)
            Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE5_)
            Entity.SetOldLocalPos(_ARG_0_.myHandle, _UPVALUE5_)
            for _FORV_6_ = 1, 4 do
              EntityManager:GetEntity(_UPVALUE7_[1][_FORV_6_]):DispOff(0.1)
              EntityManager:GetEntity(_UPVALUE7_[2][_FORV_6_]):DispOff(0.1)
            end
            _FOR_.SetCtrlIDX(_ARG_0_.TargetLargeHandle, CTRL_LOOP_2D)
            Sprite2D.SetCtrlIDX(_ARG_0_.TargetSmallHandle, CTRL_LOOP_2D)
            _ARG_0_.step = 5
            print("\145_\140\130\138J\142n\129I\129I\n")
          end
        elseif _ARG_0_.step == 5 then
          _ARG_0_:SniperVoice((Entity.GetFrameRate(_ARG_0_.myHandle)))
          Entity.GetWorldPos(_UPVALUE4_, _ARG_0_.targetHandle, 5)
          Camera.CameraMovePos(_ARG_0_.cameraHandle, _UPVALUE5_, 0.2)
          Camera.CameraMoveView(_ARG_0_.cameraHandle, _UPVALUE4_, 0.1)
          _ARG_0_.SniperShootTime = _ARG_0_.SniperShootTime - Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 >= _ARG_0_.SniperShootTime then
            _ARG_0_.SniperShootTime = 0
          end
          Camera.CameraGetLookPos(_UPVALUE6_, _ARG_0_.cameraHandle)
          if Entity.CalcDistanceSq(_UPVALUE6_, _UPVALUE4_) <= _ARG_0_.SniperDist then
            if 0 >= _ARG_0_.SniperShootTime then
              Camera.CameraSetView(_ARG_0_.cameraHandle, _UPVALUE4_)
              _ARG_0_:SniperFier(_UPVALUE8_, true)
              _ARG_0_.SniperShootTime = _ARG_0_.SniperShootIntervalTime * 60
            end
          else
            _ARG_0_.ShootTimer = _ARG_0_.ShootTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
            if 0 >= _ARG_0_.ShootTimer then
              _ARG_0_.shotCount = _ARG_0_.shotCount + 1
              if _ARG_0_.shotCount >= 5 then
                _ARG_0_.shotCount = 0
                _ARG_0_.ShootTimer = Script.RandomInRange(_ARG_0_.SniperShootLowTime, _ARG_0_.SniperShootHeightTime)
              else
                _ARG_0_:SniperFier(_UPVALUE8_, false)
                _ARG_0_.ShootTimer = Script.RandomInRange(_ARG_0_.SniperShootLowTime, _ARG_0_.SniperShootHeightTime)
                _ARG_0_.ShootTimer = Script.RandomInRange(10, 20)
              end
            end
          end
          _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
          if 20 >= _ARG_0_.timer and _ARG_0_.sprFlag == false then
            Sprite2D.SetCtrlIDX(_ARG_0_.TargetLargeHandle, CTRL_OUT_2D)
            Sprite2D.SetCtrlIDX(_ARG_0_.TargetSmallHandle, CTRL_OUT_2D)
            _ARG_0_.sprFlag = true
          end
          if 0 >= _ARG_0_.timer then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE9_)
            Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
            Camera.CameraSetPos(_ARG_0_.cameraHandle, _UPVALUE1_)
            Camera.CameraSetView(_ARG_0_.cameraHandle, _UPVALUE2_)
            Entity.SetupModelFade(_ARG_0_.myHandle, 1, 1, 0.1)
            for _FORV_6_ = 1, 4 do
              EntityManager:GetEntity(_UPVALUE7_[1][_FORV_6_]):DispOn(0.1)
              EntityManager:GetEntity(_UPVALUE7_[2][_FORV_6_]):DispOn(0.1)
            end
            _FOR_.SetLocalPos(_ARG_0_.myHandle, _UPVALUE10_)
            Entity.SetOldLocalPos(_ARG_0_.myHandle, _UPVALUE10_)
            Entity.SetRot(_ARG_0_.myHandle, 0, -4, 0)
            Sprite2D.Destroy(_ARG_0_.TargetLargeHandle)
            Sprite2D.Destroy(_ARG_0_.TargetSmallHandle)
            _ARG_0_.TargetLargeHandle = NULL_HANDLE
            _ARG_0_.TargetSmallHandle = NULL_HANDLE
            _ARG_0_.step = 6
          end
        elseif _ARG_0_.step == 6 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 20 then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE9_)
            _ARG_0_.WarpStep = 0
            _ARG_0_.step = 7
          end
        elseif _ARG_0_.step == 7 then
          if _ARG_0_:Warp(_UPVALUE11_) == true then
            Camera.CameraDestroy(_ARG_0_.cameraHandle)
            _ARG_0_.cameraHandle = NULL_HANDLE
            Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
            Player.SetBattleFlagBraigSnipeOn(0)
            _ARG_0_.WaitIdlingPattern = true
            _ARG_0_:GotoState("WaitIdling")
          end
        elseif _ARG_0_.step == 10 then
          Camera.CameraSetPos(_ARG_0_.cameraHandle, _UPVALUE1_)
          Camera.CameraSetView(_ARG_0_.cameraHandle, _UPVALUE2_)
          Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE10_)
          Entity.SetOldLocalPos(_ARG_0_.myHandle, _UPVALUE10_)
          Entity.SetRot(_ARG_0_.myHandle, 0, -4, 0)
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE12_)
          Sprite2D.Destroy(_ARG_0_.TargetLargeHandle)
          Sprite2D.Destroy(_ARG_0_.TargetSmallHandle)
          _ARG_0_.TargetLargeHandle = NULL_HANDLE
          _ARG_0_.TargetSmallHandle = NULL_HANDLE
          Entity.SetupModelFade(_ARG_0_.myHandle, 1, 1, 0.1)
          _ARG_0_.step = 11
        elseif _ARG_0_.step == 11 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_.step = 6
          end
        elseif _ARG_0_.step == 20 then
          Entity.GetWorldPos(_UPVALUE4_, _ARG_0_.myHandle, 1)
          _ARG_0_.cameraHandle = Camera.CameraCreate(_UPVALUE13_, _UPVALUE4_)
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
          _ARG_0_.step = 21
        elseif _ARG_0_.step == 21 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 20 then
            Entity.SetMotionSpeed(_ARG_0_.myHandle, 0)
            _ARG_0_.step = 22
          end
        elseif _ARG_0_.step == 22 then
          _ARG_0_:Warp(_UPVALUE0_)
          if _ARG_0_.WarpStep == 2 then
            Camera.CameraSetPos(_ARG_0_.cameraHandle, _UPVALUE1_)
            Camera.CameraSetView(_ARG_0_.cameraHandle, _UPVALUE2_)
            Camera.SetCameraViewAngle(_ARG_0_.cameraHandle, DegToRad(30))
            _ARG_0_.step = 23
          end
        elseif _ARG_0_.step == 23 and _ARG_0_:Warp(_UPVALUE0_) == true then
          Entity.ClearSpeed(_ARG_0_.myHandle)
          Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
          Entity.EnableGravity(_ARG_0_.myHandle, 0)
          Script.SetObjStart(OBJ_BIT_PLAYER)
          _ARG_0_.SniperInit = -1
          _ARG_0_.step = 2
        end
      end
    },
    DashShoot = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_.YPos = 0
        _ARG_0_.step = 0
        _ARG_0_.pattern = 0
      end,
      OnEndState = function(_ARG_0_)
        _ARG_0_.Afterimage = 0
        Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        if _ARG_0_.step == 0 then
          _ARG_0_.WarpStep = 0
          _ARG_0_.step = 1
        elseif _ARG_0_.step == 1 then
          if _ARG_0_:Warp(_UPVALUE0_) == true then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE1_)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 2)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 13 then
            _ARG_0_.velocity:set(0, 0, 0.2)
            _ARG_0_.timer = 30
            _ARG_0_.ShootTimer = Script.RandomInRange(5, 10)
            _ARG_0_.step = 3
            _ARG_0_.Afterimage = 1
          end
        elseif _ARG_0_.step == 3 then
          _ARG_0_.Afterimage = 2
          _ARG_0_.ShootTimer = _ARG_0_.ShootTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 >= _ARG_0_.ShootTimer then
            _ARG_0_.ShootTimer = Script.RandomInRange(5, 10)
            _ARG_0_:Arrow(_UPVALUE2_)
            _ARG_0_:Arrow(_UPVALUE3_)
          end
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
          _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 26 then
            Entity.SetMotionSpeed(_ARG_0_.myHandle, 0)
            _ARG_0_.step = 4
          end
        elseif _ARG_0_.step == 4 then
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
          _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
          if _ARG_0_.timer <= 20 then
            Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
          end
          if 0 >= _ARG_0_.timer and Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 38 then
            _ARG_0_.velocity:set(0, 0, 0)
            Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
            _ARG_0_.step = 5
            _ARG_0_.Afterimage = 0
          end
        elseif _ARG_0_.step == 5 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.pattern = _ARG_0_.pattern + 1
          if _ARG_0_.pattern == 5 then
            _ARG_0_:GotoState("Idling")
          else
            _ARG_0_.step = 0
          end
        end
      end
    },
    ChargeShoot = {
      OnBeginState = function(_ARG_0_)
        print("\131`\131\131\129[\131W\131V\131\135\131b\131g\138J\142n\n")
        _ARG_0_.AttackReleaseHP = Enemy.GetHp(_ARG_0_.myHandle) - _ARG_0_.ChargeReleaseHP
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        _ARG_0_.InvincibilTime = 10800
        _ARG_0_.YPos = 0
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableInvincible(_ARG_0_.myHandle, 0)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        _ARG_0_.InvincibilTime = _ARG_0_.InvincibilTime - Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.InvincibilTime < 0 then
          _ARG_0_.InvincibilTime = 0
          Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
        end
        if _ARG_0_.step == 0 then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
          _ARG_0_.step = 1
        elseif _ARG_0_.step == 1 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_.step = 2
            _ARG_0_.timer = Script.RandomInRange(_ARG_0_.ChargeShootLowTime, _ARG_0_.ChargeShootHeightTime)
          end
        elseif _ARG_0_.step == 2 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 >= _ARG_0_.timer then
            _ARG_0_:ChargeShootFier(true)
            _ARG_0_.InvincibilTime = 0
            _ARG_0_.timer = 20
            _ARG_0_.step = 3
          end
        elseif _ARG_0_.step == 3 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 >= _ARG_0_.timer then
            _ARG_0_:ChargeShootFier(false)
            Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
            _ARG_0_.step = 4
          end
        elseif _ARG_0_.step == 4 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Enemy.EnableInvincible(_ARG_0_.myHandle, 0)
          _ARG_0_.WaitIdlingPattern = true
          _ARG_0_:GotoState("WaitIdling")
        end
      end
    },
    WarpShoot = {
      OnBeginState = function(_ARG_0_)
        print("\131\143\129[\131v\131V\131\135\131b\131g start\n")
        _ARG_0_.YPos = 0
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        print("\131\143\129[\131v\131V\131\135\131b\131g end\n")
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        if _ARG_0_.step >= 3 then
          _ARG_0_:ReloadArrow(2)
          _ARG_0_:ReloadArrow(1)
        end
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
          _ARG_0_.WarpStep = 0
          _ARG_0_.step = 1
        elseif _ARG_0_.step == 1 then
          if _ARG_0_:Warp(_UPVALUE1_) == true then
            _ARG_0_.step = 2
            _ARG_0_.timer = _ARG_0_.WarpShootIdlingWait1
          end
        elseif _ARG_0_.step == 2 then
          _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 >= _ARG_0_.timer then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
            _ARG_0_.shotCount = 1
            _ARG_0_.step = 3
          end
        elseif _ARG_0_.step == 3 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 13 and _ARG_0_.shotCount == 1 then
            _ARG_0_:Arrow(_UPVALUE3_)
            _ARG_0_:UsedArrow(2, _ARG_0_.shotCount)
            _ARG_0_.shotCount = 2
          elseif Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 16 and _ARG_0_.shotCount == 2 then
            _ARG_0_:Arrow(_UPVALUE3_)
            _ARG_0_:UsedArrow(2, _ARG_0_.shotCount)
            _ARG_0_.shotCount = 3
          elseif Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 19 and _ARG_0_.shotCount == 3 then
            _ARG_0_:Arrow(_UPVALUE3_)
            _ARG_0_:UsedArrow(2, _ARG_0_.shotCount)
            _ARG_0_.shotCount = 4
          elseif Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 21 and _ARG_0_.shotCount == 4 then
            _ARG_0_:Arrow(_UPVALUE3_)
            _ARG_0_:UsedArrow(2, _ARG_0_.shotCount)
            _ARG_0_.shotCount = 5
          end
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            _ARG_0_.WarpStep = 0
            _ARG_0_.effectFlag = 0
            _ARG_0_.step = 4
          end
        elseif _ARG_0_.step == 4 then
          if _ARG_0_:Warp(_UPVALUE1_) == true then
            _ARG_0_.step = 5
            _ARG_0_.timer = _ARG_0_.WarpShootIdlingWait2
          end
        elseif _ARG_0_.step == 5 then
          _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 >= _ARG_0_.timer then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE4_)
            _ARG_0_.step = 6
          end
        elseif _ARG_0_.step == 6 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 13 and _ARG_0_.shotCount == 5 then
            _ARG_0_:Arrow(_UPVALUE5_)
            _ARG_0_:UsedArrow(1, _ARG_0_.shotCount - 4)
            _ARG_0_.shotCount = 6
          elseif Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 16 and _ARG_0_.shotCount == 6 then
            _ARG_0_:Arrow(_UPVALUE5_)
            _ARG_0_:UsedArrow(1, _ARG_0_.shotCount - 4)
            _ARG_0_.shotCount = 7
          elseif Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 19 and _ARG_0_.shotCount == 7 then
            _ARG_0_:Arrow(_UPVALUE5_)
            _ARG_0_:UsedArrow(1, _ARG_0_.shotCount - 4)
            _ARG_0_.shotCount = 8
          elseif Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 21 and _ARG_0_.shotCount == 8 then
            _ARG_0_:Arrow(_UPVALUE5_)
            _ARG_0_:UsedArrow(1, _ARG_0_.shotCount - 4)
            _ARG_0_.shotCount = 9
          end
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            _ARG_0_.step = 7
            _ARG_0_.timer = _ARG_0_.WarpShootIdlingWait3
          end
        elseif _ARG_0_.step == 7 then
          _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 >= _ARG_0_.timer then
            _ARG_0_.shotCount = 1
            _ARG_0_.ReloadStep = 0
            _ARG_0_.step = 8
          end
        elseif _ARG_0_.step == 8 and _ARG_0_:Reload(false) == true then
          _ARG_0_.WaitIdlingPattern = false
          _ARG_0_:GotoState("WaitIdling")
        end
      end
    },
    InvertedShoot = {
      OnBeginState = function(_ARG_0_)
        print("\139t\130\179\131V\131\135\131b\131g start\n")
        Entity.EnableGravity(_ARG_0_.myHandle, 0)
        _ARG_0_.YPos = 0
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        print("\139t\130\179\131V\131\135\131b\131g end\n")
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 2)
        if _ARG_0_.step == 0 then
          Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
          _ARG_0_.InvertedCount = Script.RandomInRange(2, 5)
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
          _ARG_0_.step = 1
        elseif _ARG_0_.step == 1 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_.timer = 20
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.velocity:set(0, _UPVALUE1_, 0)
            Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
            _ARG_0_.jamp_motion = false
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
          if _ARG_0_.timer <= 8 and _ARG_0_.jamp_motion == false then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
            _ARG_0_.jamp_motion = true
          end
          if 0 >= _ARG_0_.timer then
            Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
            _ARG_0_.velocity:set(0, 0, 0)
            Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
            Entity.GetWorldPos(_UPVALUE3_, _ARG_0_.myHandle, 0)
            _ARG_0_.YPos = 2
            _ARG_0_.step = 3
          end
        elseif _ARG_0_.step == 3 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) or _ARG_0_.InvertedReturnDamage == true then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE4_)
            _ARG_0_.InvertedReturnDamage = false
            _ARG_0_.timer = _ARG_0_.InvertedShootIdlingWait1
            _ARG_0_.step = 4
          end
        elseif _ARG_0_.step == 4 then
          _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 >= _ARG_0_.timer then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE5_)
            _ARG_0_.shotCount = 1
            _ARG_0_.step = 5
          end
        elseif _ARG_0_.step == 5 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 10 and _ARG_0_.shotCount == 1 then
            _ARG_0_:Arrow(_UPVALUE6_)
            _ARG_0_:UsedArrow(2, _ARG_0_.shotCount)
            _ARG_0_.shotCount = 2
          elseif Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 13 and _ARG_0_.shotCount == 2 then
            _ARG_0_:Arrow(_UPVALUE6_)
            _ARG_0_:UsedArrow(2, _ARG_0_.shotCount)
            _ARG_0_.shotCount = 3
          elseif Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 16 and _ARG_0_.shotCount == 3 then
            _ARG_0_:Arrow(_UPVALUE6_)
            _ARG_0_:UsedArrow(2, _ARG_0_.shotCount)
            _ARG_0_.shotCount = 4
          elseif Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 19 and _ARG_0_.shotCount == 4 then
            _ARG_0_:Arrow(_UPVALUE6_)
            _ARG_0_:UsedArrow(2, _ARG_0_.shotCount)
            _ARG_0_.shotCount = 5
          elseif Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 35 and _ARG_0_.shotCount == 5 then
            _ARG_0_:Arrow(_UPVALUE7_)
            _ARG_0_:UsedArrow(1, _ARG_0_.shotCount - 4)
            _ARG_0_.shotCount = 6
          elseif Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 38 and _ARG_0_.shotCount == 6 then
            _ARG_0_:Arrow(_UPVALUE7_)
            _ARG_0_:UsedArrow(1, _ARG_0_.shotCount - 4)
            _ARG_0_.shotCount = 7
          elseif Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 41 and _ARG_0_.shotCount == 7 then
            _ARG_0_:Arrow(_UPVALUE7_)
            _ARG_0_:UsedArrow(1, _ARG_0_.shotCount - 4)
            _ARG_0_.shotCount = 8
          elseif Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 44 and _ARG_0_.shotCount == 8 then
            _ARG_0_:Arrow(_UPVALUE7_)
            _ARG_0_:UsedArrow(1, _ARG_0_.shotCount - 4)
            _ARG_0_.shotCount = 9
          end
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_.ReloadStep = 0
            _ARG_0_.step = 6
          end
        elseif _ARG_0_.step == 6 then
          if _ARG_0_:Reload(true) == true then
            _ARG_0_.shotCount = 1
            _ARG_0_.WarpStep = 0
            _ARG_0_.step = 7
          end
        elseif _ARG_0_.step == 7 then
          if _ARG_0_:Warp(_UPVALUE8_) == true then
            _ARG_0_.InvertedCount = _ARG_0_.InvertedCount - 1
            if 1 > _ARG_0_.InvertedCount then
              Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE4_)
              _ARG_0_.timer = _ARG_0_.InvertedShootIdlingWait2
              _ARG_0_.step = 8
            else
              _ARG_0_.step = 3
            end
          end
        elseif _ARG_0_.step == 8 then
          _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 >= _ARG_0_.timer then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE9_)
            _ARG_0_.step = 9
          end
        elseif _ARG_0_.step == 9 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_.timer = 20
            _ARG_0_.velocity:set(0, _UPVALUE10_, 0)
            Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
            _ARG_0_.jamp_motion = false
            _ARG_0_.step = 10
          end
        elseif _ARG_0_.step == 10 then
          _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
          if _ARG_0_.timer <= 8 and _ARG_0_.jamp_motion == false then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE11_)
            _ARG_0_.jamp_motion = true
          end
          if 0 >= _ARG_0_.timer then
            _ARG_0_.velocity:set(0, 0, 0)
            Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
            Entity.GetWorldPos(_UPVALUE3_, _ARG_0_.myHandle, 0)
            _ARG_0_.YPos = 0
            _ARG_0_.step = 11
          end
        elseif _ARG_0_.step == 11 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
          _ARG_0_.WaitIdlingPattern = false
          _ARG_0_:GotoState("WaitIdling")
        end
      end
    },
    ArutemaShoot = {
      OnBeginState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        _ARG_0_.YPos = 0
        _ARG_0_.ShootTimer = 0
        _ARG_0_.WarpStep = 0
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if _ARG_0_:Warp(_UPVALUE0_) == true then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 39 then
            _ARG_0_.ShootTimer = Script.RandomInRange(5, 10)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          _ARG_0_.ShootTimer = _ARG_0_.ShootTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 >= _ARG_0_.ShootTimer then
            _ARG_0_.ShootTimer = Script.RandomInRange(8, 10)
            _ARG_0_:Arrow(_UPVALUE2_)
            _ARG_0_:Arrow(_UPVALUE3_)
          end
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE4_)
            _ARG_0_:WarpToTarget(4, 6)
            _ARG_0_.ShootTimer = Script.RandomInRange(3, 8)
            _ARG_0_.timer = Script.RandomInRange(5, 20)
            _ARG_0_.WarpStep = 0
            _ARG_0_.step = 3
          end
        elseif _ARG_0_.step == 3 then
          _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 >= _ARG_0_.timer and _ARG_0_:Warp(_UPVALUE5_) == true then
            _ARG_0_.WarpStep = 0
            _ARG_0_.timer = Script.RandomInRange(5, 20)
            _ARG_0_.ShootTimer = _ARG_0_.ShootTimer - 1
            if 1 > _ARG_0_.ShootTimer then
              Entity.ClearSpeed(_ARG_0_.myHandle)
              Entity.EnableGravity(_ARG_0_.myHandle, 0)
              _ARG_0_.step = 31
            end
          end
        elseif _ARG_0_.step == 31 then
          if _ARG_0_:Warp(_UPVALUE6_) == true then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE7_)
            _ARG_0_.timer = Script.RandomInRange(300, 600)
            _ARG_0_.ShootTimer = Script.RandomInRange(3, 8)
            _ARG_0_.step = 4
            _ARG_0_.shotCount = 1
            _ARG_0_.WarpStep = 0
            _ARG_0_.ShootDeg = 1
          end
        elseif _ARG_0_.step == 4 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 38 then
            _ARG_0_.ShootTimer = _ARG_0_.ShootTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
            if 0 >= _ARG_0_.ShootTimer then
              _ARG_0_.ShootTimer = Script.RandomInRange(3, 8)
              if 8 >= _ARG_0_.shotCount then
                _ARG_0_.shotCount = _ARG_0_.shotCount + 1
                if 5 <= _ARG_0_.shotCount then
                  _ARG_0_:UsedArrow(1, _ARG_0_.shotCount - 4)
                else
                  _ARG_0_:UsedArrow(2, _ARG_0_.shotCount)
                end
              end
              _ARG_0_:ArutemaShootFier(_ARG_0_.ShootDeg)
              _ARG_0_.ShootDeg = _ARG_0_.ShootDeg + 10
              if _ARG_0_.ShootDeg >= 360 then
                _ARG_0_.ShootDeg = 10
              end
            end
            _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
            if 0 >= _ARG_0_.timer then
              _ARG_0_.step = 51
            end
          end
        elseif _ARG_0_.step == 51 then
          if _ARG_0_:Warp(_UPVALUE5_) == true then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE8_)
            _ARG_0_.step = 5
          end
        elseif _ARG_0_.step == 5 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE4_)
            _ARG_0_.WarpStep = 0
            _ARG_0_.step = 6
          end
        elseif _ARG_0_.step == 6 then
          if _ARG_0_:Warp(_UPVALUE0_) == true then
            Entity.EnableGravity(_ARG_0_.myHandle, 1)
            _ARG_0_.ReloadStep = 0
            _ARG_0_.step = 7
          end
        elseif _ARG_0_.step == 7 and _ARG_0_:Reload(false) == true then
          _ARG_0_.shotCount = 1
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE4_)
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    RoundShoot = {
      OnBeginState = function(_ARG_0_)
        print("RoundShoot Start \n")
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.GetWorldPos(_ARG_0_.CenterCircleVect, _ARG_0_.targetHandle)
        if Script.Random() > 0.5 then
          _ARG_0_.RoundShootType = true
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
        else
          _ARG_0_.RoundShootType = false
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
        end
        _ARG_0_.YPos = 0
        _ARG_0_.WarpStep = 0
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
        _ARG_0_.Afterimage = 0
        print("RoundShoot End\n")
      end,
      OnUpdate = function(_ARG_0_)
        if Enemy.isBind(_ARG_0_.myHandle) > 0 then
          Entity.SetMotionSpeed(_ARG_0_.myHandle, 0)
          return
        end
        Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          if _ARG_0_:Warp(_UPVALUE0_) == true then
            Entity.GetWorldPos(FVECTOR3.new(0, 0, 0), _ARG_0_.targetHandle)
            FVECTOR3.Sub(FVECTOR3.new(0, 0, 0), _ARG_0_.CenterVecter, (FVECTOR3.new(0, 0, 0)))
            _ARG_0_.CircleRot = Math.Atan2(FVECTOR3.new(0, 0, 0):getx(), FVECTOR3.new(0, 0, 0):getz())
            _ARG_0_.RoundShootDegCnt = 0
            _ARG_0_.RoundShootDeg = 0
            _ARG_0_.DebugCount = 0
            _ARG_0_.Afterimage = 1
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          _ARG_0_.Afterimage = 2
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          if _ARG_0_.RoundShootType == 1 then
            Entity.GetWorldPos(_ARG_0_.CenterCircleVect, _ARG_0_.targetHandle)
          end
          FVECTOR3.Add(FVECTOR3.new(5 * Math.Sin(_ARG_0_.CircleRot), 0, 5 * Math.Cos(_ARG_0_.CircleRot)), _ARG_0_.CenterCircleVect, (FVECTOR3.new(5 * Math.Sin(_ARG_0_.CircleRot), 0, 5 * Math.Cos(_ARG_0_.CircleRot))))
          Entity.GetWorldPos(FVECTOR3.new(0, 0, 0), _ARG_0_.myHandle)
          if Collision.IntersectRayBg(FVECTOR3.new(0, 0, 0), COLL_KIND_ENEMY, FVECTOR3.new(0, 0, 0), (FVECTOR3.new(5 * Math.Sin(_ARG_0_.CircleRot), 0, 5 * Math.Cos(_ARG_0_.CircleRot)))) == true then
            Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle, 2)
            _UPVALUE1_:sety(_UPVALUE1_:gety() + 0.13)
            Entity.SetEffect(_ARG_0_.myHandle, _UPVALUE2_, "B30_WRP_IN00_0", _UPVALUE1_, (FVECTOR3.new(0, 0, 0)))
            _ARG_0_.timer = 10
            _ARG_0_.step = 2
          else
            Entity.SetLocalPos(_ARG_0_.myHandle, (FVECTOR3.new(5 * Math.Sin(_ARG_0_.CircleRot), 0, 5 * Math.Cos(_ARG_0_.CircleRot))))
            Entity.SetOldLocalPos(_ARG_0_.myHandle, (FVECTOR3.new(5 * Math.Sin(_ARG_0_.CircleRot), 0, 5 * Math.Cos(_ARG_0_.CircleRot))))
            _ARG_0_.RoundShootDeg = _ARG_0_.RoundShootDeg + _ARG_0_.RoundShootFrameDeg * Entity.GetFrameRate(_ARG_0_.myHandle)
            _ARG_0_.RoundShootDegCnt = _ARG_0_.RoundShootDegCnt + _ARG_0_.RoundShootFrameDeg * Entity.GetFrameRate(_ARG_0_.myHandle)
            if _ARG_0_.RoundShootDegCnt >= 20 then
              if _ARG_0_.RoundShootType == true then
                _ARG_0_:Arrow(_UPVALUE3_)
              else
                _ARG_0_:Arrow(_UPVALUE4_)
              end
              _ARG_0_.DebugCount = _ARG_0_.DebugCount + 1
              _ARG_0_.RoundShootDegCnt = 0
            end
            if _ARG_0_.RoundShootDeg >= 360 then
              if _ARG_0_.RoundShootType == true then
                Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE5_)
              else
                Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE6_)
              end
              _ARG_0_.step = 5
            else
              if _ARG_0_.RoundShootType == true then
                _ARG_0_.CircleRot = _ARG_0_.CircleRot - DegToRad(_ARG_0_.RoundShootFrameDeg * Entity.GetFrameRate(_ARG_0_.myHandle))
              else
                _ARG_0_.CircleRot = _ARG_0_.CircleRot + DegToRad(_ARG_0_.RoundShootFrameDeg * Entity.GetFrameRate(_ARG_0_.myHandle))
              end
              RoundPI(_ARG_0_.CircleRot)
            end
          end
        elseif _ARG_0_.step == 2 then
          _ARG_0_.Afterimage = 2
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 >= _ARG_0_.timer then
            print("\131_\131b\131V\131\133\131V\131\135\131b\131g\130\224\130\199\130\171\130\201\141s\130\171\130\220\129[\130\183\129I\129I\129B\n")
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE7_)
            Entity.SetAnimNowFrame(_ARG_0_.myHandle, 13)
            _ARG_0_.velocity:set(0, 0, 0.2)
            _ARG_0_.timer = 30
            _ARG_0_.step = 3
          end
        elseif _ARG_0_.step == 3 then
          _ARG_0_.Afterimage = 2
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 26 then
            Entity.SetMotionSpeed(_ARG_0_.myHandle, 0)
            _ARG_0_.step = 4
          end
        elseif _ARG_0_.step == 4 then
          _ARG_0_.Afterimage = 2
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
          _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
          if _ARG_0_.timer <= 20 then
            Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
            if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 38 then
              _ARG_0_.velocity:set(0, 0, 0)
              Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
              _ARG_0_.Afterimage = 0
              _ARG_0_.step = 5
            end
          end
        elseif _ARG_0_.step == 5 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.WaitIdlingPattern = true
          _ARG_0_:GotoState("WaitIdling")
        end
      end
    },
    Dead = {
      OnBeginState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.EnableGravity(_ARG_0_.myHandle, 0)
        _ARG_0_.timer = 60
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 and Sound.IsInvalidateSeCall() == 1 then
          Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.targetHandle, 2)
          if _ARG_0_.EnemyType == true then
            Sound.PlayVoice(109, 22, 1, _UPVALUE0_, SE_OPT_ALWAYS)
            _ARG_0_.step = 1
          else
            _ARG_0_.timer = _ARG_0_.timer - Script.GetVsyncFrameRate()
            if 0 >= _ARG_0_.timer then
              Sound.PlayVoice(109, 23, 1, _UPVALUE0_, SE_OPT_ALWAYS)
              _ARG_0_.step = 1
            end
          end
        end
      end
    },
    WarpCenter = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_.YPos = 0
        _ARG_0_.WarpStep = 0
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
        Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        if _ARG_0_.cameraHandle ~= NULL_HANDLE then
          Camera.CameraDestroy(_ARG_0_.cameraHandle)
        end
        if _ARG_0_.TargetLargeHandle ~= NULL_HANDLE then
          Sprite2D.Destroy(_ARG_0_.TargetLargeHandle)
          Sprite2D.Destroy(_ARG_0_.TargetSmallHandle)
          _ARG_0_.TargetLargeHandle = NULL_HANDLE
          _ARG_0_.TargetSmallHandle = NULL_HANDLE
        end
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_:Warp(_UPVALUE0_) == true then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Escape = {
      OnBeginState = function(_ARG_0_)
        print("Escape\n")
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
        _ARG_0_.InvertedReturnDamage = true
        _ARG_0_.WarpStep = 0
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        print("Escape End\n")
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_:Warp(_UPVALUE0_) == true then
          _ARG_0_.InvertedReturnDamage = false
          Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    }
  },
  WarpToTarget = function(_ARG_0_, _ARG_1_, _ARG_2_)
    _ARG_0_:CheckPlayerPos()
    if _ARG_0_.EnableAttack == false then
      return
    end
    while true do
      Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.playerHandle)
      if Script.Random() > 0.5 then
        _UPVALUE0_:setx(_UPVALUE0_:getx() + Script.RandomInRange(_ARG_1_, _ARG_2_))
      else
        _UPVALUE0_:setx(_UPVALUE0_:getx() + Script.RandomInRange(-_ARG_1_, -_ARG_2_))
      end
      if Script.Random() > 0.5 then
        _UPVALUE0_:setz(_UPVALUE0_:getz() + Script.RandomInRange(_ARG_1_, _ARG_2_))
      else
        _UPVALUE0_:setz(_UPVALUE0_:getz() + Script.RandomInRange(-_ARG_1_, -_ARG_2_))
      end
      Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.playerHandle)
      Collision.IntersectRayBg(_UPVALUE0_, COLL_KIND_ENEMY, _UPVALUE1_, _UPVALUE0_)
      if _ARG_0_:CenterDistance(_UPVALUE0_) <= _ARG_0_.MaxDist then
        if _ARG_0_:CheckGround() == true then
          break
        end
      else
        Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.playerHandle)
        FVECTOR3.Sub(FVECTOR3.new(0, 0, 0), _UPVALUE0_, _ARG_0_.CenterVecter)
        _UPVALUE0_:set(_ARG_0_.MaxDist * Math.Sin(Math.Atan2(FVECTOR3.new(0, 0, 0):getx(), FVECTOR3.new(0, 0, 0):getz()) + Script.RandomInRange(-0.5, 0.5)), 0, _ARG_0_.MaxDist * Math.Cos(Math.Atan2(FVECTOR3.new(0, 0, 0):getx(), FVECTOR3.new(0, 0, 0):getz()) + Script.RandomInRange(-0.5, 0.5)))
        FVECTOR3.Add(_UPVALUE0_, _ARG_0_.CenterVecter, _UPVALUE0_)
        if _ARG_0_:CheckGround() == true then
          break
        end
      end
    end
    _UPVALUE0_:sety(_UPVALUE0_:gety() + _ARG_0_.YPos)
    Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE0_)
    Entity.SetOldLocalPos(_ARG_0_.myHandle, _UPVALUE0_)
    FVECTOR3.Sub(_UPVALUE0_, _UPVALUE1_, _UPVALUE0_)
    Entity.SetRot(_ARG_0_.myHandle, 0, Math.Atan2(_UPVALUE0_:getx(), _UPVALUE0_:getz()), 0)
  end,
  CheckGround = function(_ARG_0_)
    _UPVALUE0_:copy(_UPVALUE1_)
    _UPVALUE0_:sety(20)
    _UPVALUE1_:sety(-20)
    Collision.IntersectRayBg(_UPVALUE1_, COLL_KIND_ENEMY, _UPVALUE0_, _UPVALUE1_)
    if -20 < _UPVALUE1_:gety() then
      return true
    end
    return false
  end,
  Warp = function(_ARG_0_, _ARG_1_)
    if Enemy.isBind(_ARG_0_.myHandle) > 0 then
      return true
    end
    if _ARG_0_.WarpStep == 0 then
      Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
      if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > _UPVALUE0_ or _ARG_0_.InvertedReturnDamage == true then
        _UPVALUE1_:set(0, 0, 0)
        Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.myHandle, 2)
        _UPVALUE2_:sety(_UPVALUE2_:gety() + 0.13)
        Entity.SetEffect(_ARG_0_.myHandle, _UPVALUE3_, "B30_WRP_IN00_0", _UPVALUE2_, _UPVALUE1_)
        _ARG_0_.effect_timer = 10
        Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, _ARG_0_.effect_timer)
        for _FORV_8_ = 1, 4 do
          EntityManager:GetEntity(_UPVALUE4_[1][_FORV_8_]):DispOff(_ARG_0_.effect_timer)
          EntityManager:GetEntity(_UPVALUE4_[2][_FORV_8_]):DispOff(_ARG_0_.effect_timer)
        end
        _ARG_0_.WarpStep = 1
      end
    elseif _ARG_0_.WarpStep == 1 then
      _ARG_0_.effect_timer = _ARG_0_.effect_timer - Entity.GetFrameRate(_ARG_0_.myHandle)
      if 0 >= _ARG_0_.effect_timer then
        if _ARG_1_ == _UPVALUE5_ then
          _ARG_0_:WarpToTarget(4, 6)
        elseif _ARG_1_ == _UPVALUE6_ then
          _ARG_0_:WarpToTarget(2, 3.5)
        elseif _ARG_1_ == _UPVALUE7_ then
          Entity.SetLocalPos(_ARG_0_.myHandle, _ARG_0_.CenterVecter)
          Entity.SetOldLocalPos(_ARG_0_.myHandle, _ARG_0_.CenterVecter)
          Entity.SetRot(_ARG_0_.myHandle, 0, -4, 0)
        elseif _ARG_1_ == _UPVALUE8_ then
          Entity.Warp(_ARG_0_.myHandle, _UPVALUE9_)
          Entity.SetRot(_ARG_0_.myHandle, 0, -4, 0)
        elseif _ARG_1_ == _UPVALUE10_ then
          Entity.SetLocalPos(_ARG_0_.myHandle, _ARG_0_.CenterArutemaVecter)
          Entity.SetOldLocalPos(_ARG_0_.myHandle, _ARG_0_.CenterArutemaVecter)
          Entity.SetRot(_ARG_0_.myHandle, 0, -4, 0)
        elseif _ARG_1_ == _UPVALUE11_ then
          Entity.GetWorldPos(_UPVALUE12_, _ARG_0_.playerHandle)
          FVECTOR3.Sub(FVECTOR3.new(0, 0, 0), _ARG_0_.CenterVecter, _UPVALUE12_)
          FVECTOR3.normalize((FVECTOR3.new(0, 0, 0)))
          FVECTOR3.Scale(FVECTOR3.new(0, 0, 0), FVECTOR3.new(0, 0, 0), 5)
          FVECTOR3.Add(FVECTOR3.new(0, 0, 0), FVECTOR3.new(0, 0, 0), _UPVALUE12_)
          Entity.SetLocalPos(_ARG_0_.myHandle, (FVECTOR3.new(0, 0, 0)))
          Entity.SetOldLocalPos(_ARG_0_.myHandle, (FVECTOR3.new(0, 0, 0)))
          Entity.SetRot(_ARG_0_.myHandle, 0, -4, 0)
        end
        _ARG_0_.WarpStep = 2
      end
    elseif _ARG_0_.WarpStep == 2 then
      _UPVALUE1_:set(0, 0, 0)
      Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.myHandle, 2)
      _UPVALUE2_:sety(_UPVALUE2_:gety() + 0.13)
      Entity.SetEffect(_ARG_0_.myHandle, _UPVALUE3_, "B30_WRP_OUT0_0", _UPVALUE2_, _UPVALUE1_)
      _ARG_0_.effect_timer = 10
      Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, _ARG_0_.effect_timer)
      for _FORV_8_ = 1, 4 do
        EntityManager:GetEntity(_UPVALUE4_[1][_FORV_8_]):DispOn(_ARG_0_.effect_timer)
        EntityManager:GetEntity(_UPVALUE4_[2][_FORV_8_]):DispOn(_ARG_0_.effect_timer)
      end
      _ARG_0_.WarpStep = 3
    elseif _ARG_0_.WarpStep == 3 then
      _ARG_0_.effect_timer = _ARG_0_.effect_timer - Entity.GetFrameRate(_ARG_0_.myHandle)
      if 0 >= _ARG_0_.effect_timer then
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        _ARG_0_.WarpStep = 0
      end
    end
    return true
  end,
  CenterDistance = function(_ARG_0_, _ARG_1_)
    FVECTOR3.Sub(FVECTOR3.new(0, 0, 0), _ARG_0_.CenterVecter, _ARG_1_)
    FVECTOR3.new(0, 0, 0):sety(0)
    return FVECTOR3.new(0, 0, 0):length()
  end,
  CheckPlayerPos = function(_ARG_0_)
    Entity.GetWorldPos(FVECTOR3.new(0, 0, 0), _ARG_0_.playerHandle)
    if _ARG_0_:CenterDistance((FVECTOR3.new(0, 0, 0))) <= 20 then
      _ARG_0_.EnableAttack = true
    elseif _ARG_0_.EnableAttack == true then
      _ARG_0_.stack:clear()
      _ARG_0_.stack:push("Idling")
      _ARG_0_:GotoState("WarpCenter")
      _ARG_0_.EnableAttack = false
    end
  end,
  Reload = function(_ARG_0_, _ARG_1_)
    if _ARG_0_.ReloadStep == 0 then
      if _ARG_1_ == true then
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      else
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
      end
      _ARG_0_.ReloadStep = 1
    elseif _ARG_0_.ReloadStep == 1 then
      if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > _UPVALUE2_ then
        _ARG_0_:ReloadArrow(2)
        _ARG_0_.ReloadStep = 2
      end
    elseif _ARG_0_.ReloadStep == 2 then
      if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > _UPVALUE3_ then
        _ARG_0_:ReloadArrow(1)
        _ARG_0_.ReloadStep = 3
      end
    elseif _ARG_0_.ReloadStep == 3 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
      _ARG_0_.ReloadStep = 0
    end
    return true
  end,
  ReloadArrow = function(_ARG_0_, _ARG_1_)
    for _FORV_5_ = 1, 4 do
      if EntityManager:GetEntity(_UPVALUE0_[_ARG_1_][_FORV_5_]) ~= nil then
        EntityManager:GetEntity(_UPVALUE0_[_ARG_1_][_FORV_5_]):Replenishment()
      end
    end
  end,
  Arrow = function(_ARG_0_, _ARG_1_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, _ARG_1_)
    Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
    if _ARG_0_:GetState() == "ArutemaShoot" or _ARG_0_:GetState() == "DashShoot" then
      if _ARG_0_:GetState() == "ArutemaShoot" then
        _UPVALUE0_:sety(_UPVALUE0_:gety() - 0.8)
      end
      if _ARG_1_ == _UPVALUE2_ then
        Entity.GetWorldPos(_UPVALUE3_, _ARG_0_.myHandle)
        FVECTOR3.Sub(_UPVALUE3_, _UPVALUE0_, _UPVALUE3_)
        _UPVALUE1_:set(0, Math.Atan2(_UPVALUE3_:getx(), _UPVALUE3_:getz()), 0)
      elseif _ARG_1_ == _UPVALUE4_ then
        Entity.GetWorldPos(_UPVALUE3_, _ARG_0_.myHandle)
        FVECTOR3.Sub(_UPVALUE3_, _UPVALUE0_, _UPVALUE3_)
        _UPVALUE1_:set(0, Math.Atan2(_UPVALUE3_:getx(), _UPVALUE3_:getz()), 0)
      end
    end
    if _ARG_0_:GetState() == "InvertedShoot" then
      SetBulletAttackParam(Bullet.CreateBullet("b30exAR", _UPVALUE0_, _UPVALUE1_), _ARG_0_.myHandle, 4)
      Entity.SetEffect(_ARG_0_.myHandle, _UPVALUE5_, "B30_DST_FIR0_0", _UPVALUE0_, _UPVALUE1_)
    elseif _ARG_0_:GetState() == "WarpShoot" then
      SetBulletAttackParam(Bullet.CreateBullet("b30exAR", _UPVALUE0_, _UPVALUE1_), _ARG_0_.myHandle, 3)
      Entity.SetEffect(_ARG_0_.myHandle, _UPVALUE5_, "B30_DST_FIR0_0", _UPVALUE0_, _UPVALUE1_)
    elseif _ARG_0_:GetState() == "ArutemaShoot" then
      SetBulletAttackParam(Bullet.CreateBullet("b30exAR", _UPVALUE0_, _UPVALUE1_), _ARG_0_.myHandle, 3)
      Entity.SetEffect(_ARG_0_.myHandle, _UPVALUE5_, "B30_AST_FIR0_0", _UPVALUE0_, _UPVALUE1_)
    elseif _ARG_0_:GetState() == "DashShoot" then
      SetBulletAttackParam(Bullet.CreateBullet("b30exAR", _UPVALUE0_, _UPVALUE1_), _ARG_0_.myHandle, 3)
      Entity.SetEffect(_ARG_0_.myHandle, _UPVALUE5_, "B30_DST_FIR0_0", _UPVALUE0_, _UPVALUE1_)
    elseif _ARG_0_:GetState() == "RoundShoot" then
      SetBulletAttackParam(Bullet.CreateBullet("b30exAR", _UPVALUE0_, _UPVALUE1_), _ARG_0_.myHandle, 7)
      Entity.SetEffect(_ARG_0_.myHandle, _UPVALUE5_, "B30_DST_FIR0_0", _UPVALUE0_, _UPVALUE1_)
    end
    if false == true and EntityManager:GetEntity((Bullet.CreateBullet("b30exAR", _UPVALUE0_, _UPVALUE1_))) ~= nil then
      EntityManager:GetEntity((Bullet.CreateBullet("b30exAR", _UPVALUE0_, _UPVALUE1_))).targetHandle = _ARG_0_.targetHandle
    end
    return (Bullet.CreateBullet("b30exAR", _UPVALUE0_, _UPVALUE1_))
  end,
  SniperFier = function(_ARG_0_, _ARG_1_, _ARG_2_)
    Entity.TurnTargetDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
    Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
    Entity.SetEffect(_ARG_0_.myHandle, _UPVALUE1_, "B30_SNI_FIR0_0", _ARG_1_, _UPVALUE0_)
    SetBulletAttackParam(Bullet.CreateBullet("b30exSN", _ARG_1_, _UPVALUE0_), _ARG_0_.myHandle, 6)
    if EntityManager:GetEntity((Bullet.CreateBullet("b30exSN", _ARG_1_, _UPVALUE0_))) ~= nil then
      EntityManager:GetEntity((Bullet.CreateBullet("b30exSN", _ARG_1_, _UPVALUE0_))).targetHandle = _ARG_0_.targetHandle
      if _ARG_2_ == true then
        EntityManager:GetEntity((Bullet.CreateBullet("b30exSN", _ARG_1_, _UPVALUE0_))).SnipTimer = 10
      else
        EntityManager:GetEntity((Bullet.CreateBullet("b30exSN", _ARG_1_, _UPVALUE0_))).SnipTimer = 5
      end
    end
    _ARG_0_.SiteWaitTimer = 30
  end,
  SniperVoice = function(_ARG_0_, _ARG_1_)
    if _ARG_0_.timer > 60 then
      _ARG_0_.voiceTimer = _ARG_0_.voiceTimer - _ARG_1_
      if _ARG_0_.voiceTimer <= 0 then
        if Script.Random() < 0.2 then
          Sound.PlayVoice(109, 16)
        elseif Script.Random() < 0.6 then
          Sound.PlayVoice(109, 15)
        else
          Sound.PlayVoice(109, 17)
        end
        _ARG_0_.voiceTimer = 300
      end
    end
  end,
  ChargeShootFier = function(_ARG_0_, _ARG_1_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, _UPVALUE1_)
    Entity.GetRot(_UPVALUE2_, _ARG_0_.myHandle)
    if _ARG_1_ == true then
      Entity.SetEffect(_ARG_0_.myHandle, _UPVALUE3_, "B30_CST_FIR0_0", _UPVALUE0_, _UPVALUE2_)
    else
      SetBulletAttackParam(Bullet.CreateBullet("b30exCS", _UPVALUE0_, _UPVALUE2_), _ARG_0_.myHandle, 2)
      if EntityManager:GetEntity((Bullet.CreateBullet("b30exCS", _UPVALUE0_, _UPVALUE2_))) ~= nil then
        EntityManager:GetEntity((Bullet.CreateBullet("b30exCS", _UPVALUE0_, _UPVALUE2_))).targetHandle = _ARG_0_.targetHandle
        EntityManager:GetEntity((Bullet.CreateBullet("b30exCS", _UPVALUE0_, _UPVALUE2_))).shotSpeed = _ARG_0_.ChargeShotSpeed
        EntityManager:GetEntity((Bullet.CreateBullet("b30exCS", _UPVALUE0_, _UPVALUE2_))).HomingTime = _ARG_0_.ChargeShotHomingTime
      end
    end
  end,
  ArutemaShootFier = function(_ARG_0_, _ARG_1_)
    _UPVALUE0_:set(0, 0, 5)
    Math.RotateVectorXYZ(_UPVALUE0_, (FVECTOR3.new(0, _ARG_1_, 0)))
    FVECTOR3.Add(_UPVALUE1_, _ARG_0_.CenterVecter, _UPVALUE0_)
    _UPVALUE1_:sety(4)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.targetHandle)
    FVECTOR3.Sub(_UPVALUE2_, _UPVALUE0_, _UPVALUE1_)
    _UPVALUE0_:set(-Math.Atan2(_UPVALUE2_:gety(), Math.Sqrt(_UPVALUE2_:getx() * _UPVALUE2_:getx() + _UPVALUE2_:getz() * _UPVALUE2_:getz())), Math.Atan2(_UPVALUE2_:getx(), _UPVALUE2_:getz()), 0)
    SetBulletAttackParam(Bullet.CreateBullet("b30exAS", _UPVALUE1_, _UPVALUE0_), _ARG_0_.myHandle, 5)
    if EntityManager:GetEntity((Bullet.CreateBullet("b30exAS", _UPVALUE1_, _UPVALUE0_))) ~= nil then
      EntityManager:GetEntity((Bullet.CreateBullet("b30exAS", _UPVALUE1_, _UPVALUE0_))).targetHandle = _ARG_0_.targetHandle
      EntityManager:GetEntity((Bullet.CreateBullet("b30exAS", _UPVALUE1_, _UPVALUE0_))).ArutemaShotEnableTime = _ARG_0_.ArutemaShotEnableTime
    end
    return (Bullet.CreateBullet("b30exAS", _UPVALUE1_, _UPVALUE0_))
  end,
  UsedArrow = function(_ARG_0_, _ARG_1_, _ARG_2_)
    if EntityManager:GetEntity(_UPVALUE0_[_ARG_1_][_ARG_2_]) ~= nil then
      EntityManager:GetEntity(_UPVALUE0_[_ARG_1_][_ARG_2_]):Consumption()
    end
  end,
  RotArrow = function(_ARG_0_)
    _ARG_0_.SiteWaitTimer = _ARG_0_.SiteWaitTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
    if _ARG_0_.SiteWaitTimer <= 0 then
      _ARG_0_.SiteWaitTimer = 0
      if _ARG_0_.TargetLargeHandle ~= NULL_HANDLE then
        _ARG_0_.fLargeRotZ = _ARG_0_.fLargeRotZ + _ARG_0_.fLargeAddRot
        Sprite2D.SetCtrlRotZ(_ARG_0_.TargetLargeHandle, DegToRad(_ARG_0_.fLargeRotZ))
        _ARG_0_.LargeArrowtimer = _ARG_0_.LargeArrowtimer - Entity.GetFrameRate(_ARG_0_.myHandle)
        if 0 >= _ARG_0_.LargeArrowtimer then
          _ARG_0_.fLargeAddRot = Script.RandomInRange(1, 3)
          if Script.Random() < 0.5 then
            _ARG_0_.fLargeAddRot = _ARG_0_.fLargeAddRot * -1
          end
          _ARG_0_.LargeArrowtimer = Script.RandomInRange(60, 180)
        end
        _ARG_0_.fSmallRotZ = _ARG_0_.fSmallRotZ - _ARG_0_.fSmallAddRot
        Sprite2D.SetCtrlRotZ(_ARG_0_.TargetSmallHandle, DegToRad(_ARG_0_.fSmallRotZ))
        _ARG_0_.SmallArrowtimer = _ARG_0_.SmallArrowtimer - Entity.GetFrameRate(_ARG_0_.myHandle)
        if 0 >= _ARG_0_.SmallArrowtimer then
          _ARG_0_.fSmallAddRot = Script.RandomInRange(3, 8)
          if Script.Random() < 0.5 then
            _ARG_0_.fSmallAddRot = _ARG_0_.fSmallAddRot * -1
          end
          _ARG_0_.SmallArrowtimer = Script.RandomInRange(60, 180)
        end
      end
    end
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    print("\131u\131\137\131C\131O ... \143\137\138\250\137\187\n")
    _UPVALUE0_ = Entity.GetMotionIndex(_ARG_1_, "010")
    _UPVALUE1_ = Entity.GetMotionIndex(_ARG_1_, "011")
    _UPVALUE2_ = Entity.GetMotionIndex(_ARG_1_, "060")
    _UPVALUE3_ = Entity.GetMotionIndex(_ARG_1_, "061")
    _UPVALUE4_ = Entity.GetMotionIndex(_ARG_1_, "062")
    _UPVALUE5_ = Entity.GetMotionIndex(_ARG_1_, "063")
    _UPVALUE6_ = Entity.GetMotionIndex(_ARG_1_, "080")
    _UPVALUE7_ = Entity.GetMotionIndex(_ARG_1_, "081")
    _UPVALUE8_ = Entity.GetMotionIndex(_ARG_1_, "082")
    _UPVALUE9_ = Entity.GetMotionIndex(_ARG_1_, "200")
    _UPVALUE10_ = Entity.GetMotionIndex(_ARG_1_, "202")
    _UPVALUE11_ = Entity.GetMotionIndex(_ARG_1_, "203")
    _UPVALUE12_ = Entity.GetMotionIndex(_ARG_1_, "204")
    _UPVALUE13_ = Entity.GetMotionIndex(_ARG_1_, "205")
    _UPVALUE14_ = Entity.GetMotionIndex(_ARG_1_, "230")
    _UPVALUE15_ = Entity.GetMotionIndex(_ARG_1_, "231")
    _UPVALUE16_ = Entity.GetMotionIndex(_ARG_1_, "300")
    _UPVALUE17_ = Entity.GetMotionIndex(_ARG_1_, "301")
    _UPVALUE18_ = Entity.GetMotionIndex(_ARG_1_, "310")
    _UPVALUE19_ = Entity.GetMotionIndex(_ARG_1_, "320")
    _UPVALUE20_ = Entity.GetMotionIndex(_ARG_1_, "321")
    _UPVALUE21_ = Entity.GetMotionIndex(_ARG_1_, "330")
    _UPVALUE22_ = Entity.GetMotionIndex(_ARG_1_, "331")
    _UPVALUE23_ = Entity.GetMotionIndex(_ARG_1_, "340")
    _UPVALUE24_ = Entity.GetMotionIndex(_ARG_1_, "350")
    _UPVALUE25_ = Entity.GetMotionIndex(_ARG_1_, "351")
    _UPVALUE26_ = Entity.GetMotionIndex(_ARG_1_, "352")
    _UPVALUE27_ = Entity.GetMotionIndex(_ARG_1_, "360")
    _UPVALUE28_ = Entity.GetMotionIndex(_ARG_1_, "361")
    _UPVALUE29_ = Entity.GetMotionIndex(_ARG_1_, "362")
    _UPVALUE30_ = Entity.GetMotionIndex(_ARG_1_, "363")
    _UPVALUE31_[1][1] = _UPVALUE9_
    _UPVALUE31_[1][2] = _UPVALUE9_
    _UPVALUE31_[1][3] = _UPVALUE10_
    _UPVALUE31_[1][4] = _UPVALUE10_
    _UPVALUE31_[1][5] = _UPVALUE9_
    _UPVALUE31_[1][6] = _UPVALUE10_
    _UPVALUE31_[1][7] = _UPVALUE9_
    _UPVALUE31_[1][8] = _UPVALUE10_
    _UPVALUE31_[1][9] = _UPVALUE9_
    _UPVALUE31_[1][10] = _UPVALUE10_
    _UPVALUE31_[1][11] = _UPVALUE10_
    _UPVALUE31_[1][12] = _UPVALUE10_
    _UPVALUE31_[1][13] = _UPVALUE9_
    _UPVALUE31_[1][14] = _UPVALUE14_
    _UPVALUE31_[1][15] = _UPVALUE15_
    _UPVALUE31_[1][16] = _UPVALUE10_
    _UPVALUE31_[1][17] = _UPVALUE10_
    _UPVALUE31_[2][1] = _UPVALUE11_
    _UPVALUE31_[2][2] = _UPVALUE11_
    _UPVALUE31_[2][3] = _UPVALUE12_
    _UPVALUE31_[2][4] = _UPVALUE12_
    _UPVALUE31_[2][5] = _UPVALUE11_
    _UPVALUE31_[2][6] = _UPVALUE12_
    _UPVALUE31_[2][7] = _UPVALUE11_
    _UPVALUE31_[2][8] = _UPVALUE12_
    _UPVALUE31_[2][9] = _UPVALUE11_
    _UPVALUE31_[2][10] = _UPVALUE12_
    _UPVALUE31_[2][11] = _UPVALUE12_
    _UPVALUE31_[2][12] = _UPVALUE12_
    _UPVALUE31_[2][13] = _UPVALUE11_
    _UPVALUE31_[2][14] = _UPVALUE1_
    _UPVALUE31_[2][15] = 0
    _UPVALUE31_[2][16] = _UPVALUE12_
    _UPVALUE31_[2][17] = _UPVALUE12_
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.playerHandle = Player.GetHandle()
    _ARG_0_.targetHandle = Player.GetHandle()
    _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
    _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
    _ARG_0_.step = 0
    _ARG_0_.debugCount = 1
    _ARG_0_.YPos = 0
    _ARG_0_.pattern = 0
    _ARG_0_.cameraHandle = NULL_HANDLE
    _ARG_0_.TargetLargeHandle = NULL_HANDLE
    _ARG_0_.WorkVec = FVECTOR3.new(0, 0, 0)
    _ARG_0_.stack = Stack:Create()
    _ARG_0_.AttackReleaseHP = 0
    _ARG_0_.Afterimage = 0
    _ARG_0_.EnableAttack = true
    _ARG_0_.CamTimeer = 0
    _ARG_0_.SniperInit = 1
    _ARG_0_.voiceTimer = 0
    _ARG_0_.CenterCircleVect = FVECTOR3.new(0, 0, 0)
    _ARG_0_.RoundShootDeg = 0
    _ARG_0_.InvertedReturnDamage = false
    _ARG_0_.fLargeAddRot = 5
    _ARG_0_.fSmallAddRot = 10
    _ARG_0_.LargeArrowtimer = Script.RandomInRange(60, 180)
    _ARG_0_.SmallArrowtimer = Script.RandomInRange(60, 180)
    _ARG_0_.fLargeRotZ = 0
    _ARG_0_.fSmallRotZ = 0
    _ARG_0_.SiteWaitTimer = 0
    _ARG_0_.sprFlag = false
    _ARG_0_.WarpShootIdlingWait1 = Enemy.GetExtraParam(_ARG_0_.myHandle, "WSIdling1")
    _ARG_0_.WarpShootIdlingWait2 = Enemy.GetExtraParam(_ARG_0_.myHandle, "WSIdling2")
    _ARG_0_.WarpShootIdlingWait3 = Enemy.GetExtraParam(_ARG_0_.myHandle, "WSIdling3")
    _ARG_0_.InvertedShootIdlingWait1 = Enemy.GetExtraParam(_ARG_0_.myHandle, "ISIdling1")
    _ARG_0_.InvertedShootIdlingWait2 = Enemy.GetExtraParam(_ARG_0_.myHandle, "ISIdling2")
    _ARG_0_.ChargeShotSpeed = Enemy.GetExtraParam(_ARG_0_.myHandle, "CSSpeed")
    _ARG_0_.ChargeShotHomingTime = Enemy.GetExtraParam(_ARG_0_.myHandle, "CSHomTim")
    _ARG_0_.ChargeShootInvincibility = Enemy.GetExtraParam(_ARG_0_.myHandle, "CSInvin")
    _ARG_0_.ChargeShootLowTime = Enemy.GetExtraParam(_ARG_0_.myHandle, "CSLowTime")
    _ARG_0_.ChargeShootHeightTime = Enemy.GetExtraParam(_ARG_0_.myHandle, "CSHiTime")
    _ARG_0_.WaitIdlingLowTime = Enemy.GetExtraParam(_ARG_0_.myHandle, "IdlLowTime")
    _ARG_0_.WaitIdlingHeightTime = Enemy.GetExtraParam(_ARG_0_.myHandle, "IdlHiTime")
    _ARG_0_.SniperTime = Enemy.GetExtraParam(_ARG_0_.myHandle, "SniperTime")
    _ARG_0_.SniperShootLowTime = Enemy.GetExtraParam(_ARG_0_.myHandle, "SSLowTime")
    _ARG_0_.SniperShootHeightTime = Enemy.GetExtraParam(_ARG_0_.myHandle, "SSHiTime")
    _ARG_0_.SniperShootIntervalTime = Enemy.GetExtraParam(_ARG_0_.myHandle, "SSInterval")
    _ARG_0_.ArutemaShotEnableTime = Enemy.GetExtraParam(_ARG_0_.myHandle, "ASEnableTim")
    _ARG_0_.SniperReleaseHP = Enemy.GetExtraParam(_ARG_0_.myHandle, "SniperRele")
    _ARG_0_.ChargeReleaseHP = Enemy.GetExtraParam(_ARG_0_.myHandle, "ChargeRele")
    _ARG_0_.SniperDist = Enemy.GetExtraParam(_ARG_0_.myHandle, "SniperDist")
    _ARG_0_.RoundShootFrameDeg = Enemy.GetExtraParam(_ARG_0_.myHandle, "RSFrameDeg")
    _ARG_0_.RoundShootType = Enemy.GetExtraParam(_ARG_0_.myHandle, "RSType")
    _ARG_0_.WarpShoot = true
    _ARG_0_.InvertedShoot = true
    _ARG_0_.ChargeShoot = false
    _ARG_0_.ArutemaShoot = true
    _ARG_0_.RoundShoot = true
    _ARG_0_.debugTimer = 1200
    for _FORV_5_ = 1, 4 do
      _UPVALUE32_[1][_FORV_5_] = Entity.CreateEntity("b31ex00", _ARG_0_.WorkVec, _ARG_0_.WorkVec)
      Entity.AttachCoord(_ARG_1_, _UPVALUE33_[1][_FORV_5_], _UPVALUE32_[1][_FORV_5_], "Root")
      Entity.EnableLockonAndShooton(_UPVALUE32_[1][_FORV_5_], 0)
    end
    for _FORV_5_ = 1, 4 do
      _UPVALUE32_[2][_FORV_5_] = Entity.CreateEntity("b31ex00", _ARG_0_.WorkVec, _ARG_0_.WorkVec)
      Entity.AttachCoord(_ARG_1_, _UPVALUE33_[2][_FORV_5_], _UPVALUE32_[2][_FORV_5_], "Root")
      Entity.EnableLockonAndShooton(_UPVALUE32_[2][_FORV_5_], 0)
    end
    _FOR_.ClearSpeed(_ARG_0_.myHandle)
    Entity.EnableGravity(_ARG_0_.myHandle, 1)
    Entity.EnableBgColl(_ARG_0_.myHandle, 1)
    Player.SetBossCamera("b30ex")
    if Entity.GetName(_ARG_0_.myHandle) == "b30ex00" then
      _ARG_0_.CenterVecter = _UPVALUE34_
      _ARG_0_.CenterArutemaVecter = _UPVALUE35_
      _ARG_0_.MaxDist = _UPVALUE36_
      _ARG_0_.EnemyType = false
    else
      _ARG_0_.CenterVecter = _UPVALUE37_
      _ARG_0_.CenterArutemaVecter = _UPVALUE38_
      _ARG_0_.MaxDist = _UPVALUE39_
      _ARG_0_.EnemyType = true
    end
    _ARG_0_:GotoState("Appear")
  end,
  OnHitAttack = function(_ARG_0_)
    if _ARG_0_:GetState() == "ChargeShoot" and _ARG_0_.InvincibilTime <= 0 then
      _ARG_0_.InvincibilTime = 80
    end
  end,
  GetNumber = function(_ARG_0_)
    return _ARG_0_.Afterimage
  end,
  OnDamageBefore = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    Entity.SetupModelFade(_ARG_0_.myHandle, 1, 1, 1)
    _ARG_0_.idlingTimer = 0
    if _ARG_0_:GetState() == "InvertedShoot" then
      _ARG_0_:ReloadArrow(2)
      _ARG_0_:ReloadArrow(1)
      if _ARG_0_.step >= 3 and _ARG_0_.step <= 7 and Script.Random() < 0.3 then
        print("\147\166\130\176!\n")
        _ARG_0_.shotCount = 1
        _ARG_0_.WarpStep = 0
        _ARG_0_.step = 7
        return 1
      end
    elseif _ARG_0_:GetState() == "Sniper" and 1 <= _ARG_0_.step then
      if _ARG_0_.AttackReleaseHP > Enemy.GetHp(_ARG_0_.myHandle) then
        Sprite2D.Destroy(_ARG_0_.TargetLargeHandle)
        Sprite2D.Destroy(_ARG_0_.TargetSmallHandle)
        _ARG_0_.TargetLargeHandle = NULL_HANDLE
        _ARG_0_.TargetSmallHandle = NULL_HANDLE
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
        Camera.CameraDestroy(_ARG_0_.cameraHandle)
        _ARG_0_.cameraHandle = NULL_HANDLE
        _ARG_0_.WarpStep = 0
        _ARG_0_.step = 7
      elseif Script.Random() < 0.5 then
        Sound.PlayVoice(109, 0)
      else
        Sound.PlayVoice(109, 1)
      end
      Script.SetDispleyFlash(2, 255, 255, 255)
      Camera.QuakeV(20, 0.3, 6)
    elseif _ARG_0_:GetState() == "ChargeShoot" then
      if _ARG_0_.step >= 4 then
        _ARG_0_:GotoState("Idling")
      elseif _ARG_0_.AttackReleaseHP > Enemy.GetHp(_ARG_0_.myHandle) then
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        _ARG_0_:GotoState("Idling")
      end
    elseif _ARG_0_:GetState() == "ArutemaShoot" then
    else
      Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
      if Script.Random() < 0.3 then
        _ARG_0_.stack:clear()
        _ARG_0_.stack:push("Idling")
        _ARG_0_:GotoState("Escape")
        return 1
      else
        _ARG_0_:GotoState("Idling")
      end
    end
    return 0
  end,
  OnReturnDamage = function(_ARG_0_)
    if _ARG_0_:GetState() == "InvertedShoot" and _ARG_0_.step >= 3 and _ARG_0_.step <= 7 then
      print("\149\156\139A\130\181\130\220\130\181\130\189\129B\n")
      _ARG_0_.InvertedReturnDamage = true
      _ARG_0_.shotCount = 1
      _ARG_0_.WarpStep = 0
      _ARG_0_.step = 7
    end
  end,
  OnGuard = function(_ARG_0_)
    Entity.GetWorldPos(FVECTOR3.new(0, 0, 0), _ARG_0_.myHandle)
    Entity.SetEffect(_ARG_0_.myHandle, "p_gu_rel_00", "P_GU_REL_REL0_0", FVECTOR3.new(0, 0, 0), (FVECTOR3.new(0, 0, 0)))
  end,
  GetDamageMotionNum = function(_ARG_0_, _ARG_1_)
    if _ARG_0_:GetState() == "InvertedShoot" and _ARG_0_.step >= 1 then
    else
    end
    return _UPVALUE0_[1][_ARG_1_ + 1]
  end,
  OnDead = function(_ARG_0_)
    SetupBossDead(_ARG_0_.myHandle)
    if _ARG_0_:GetState() == "Sniper" then
      Camera.CameraDestroy(_ARG_0_.cameraHandle)
      Sprite2D.Destroy(_ARG_0_.TargetLargeHandle)
      Sprite2D.Destroy(_ARG_0_.TargetSmallHandle)
      _ARG_0_.TargetLargeHandle = NULL_HANDLE
      _ARG_0_.TargetSmallHandle = NULL_HANDLE
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
    elseif _ARG_0_:GetState() == "InvertedShoot" then
      if Enemy.IsAttackerFront(_ARG_0_.myHandle) == true then
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
      else
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
      end
    elseif Enemy.IsAttackerFront(_ARG_0_.myHandle) == true then
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
    else
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE4_)
    end
    _ARG_0_:GotoState("Dead")
    return 1
  end,
  OnUpdate = function(_ARG_0_)
    if _UPVALUE0_ == 0 then
      _UPVALUE1_ = _UPVALUE1_ - Entity.GetFrameRate(_ARG_0_.myHandle)
      if _UPVALUE1_ < 0 then
        _UPVALUE1_ = 0
        _UPVALUE0_ = 1
      end
    end
    _ARG_0_.debugTimer = _ARG_0_.debugTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
    if 0 > _ARG_0_.debugTimer then
      print("Now state = ", _ARG_0_:GetState(), " NowStep = ", _ARG_0_.step, " WarpStep = ", _ARG_0_.WarpStep, "\n")
      _ARG_0_.debugTimer = 1200
    end
    _ARG_0_:CheckPlayerPos()
    _ARG_0_:Update()
    _ARG_0_:Debug()
  end,
  Debug = function(_ARG_0_)
    if Script.IsDebugCheckAttack() then
      if "Escape" == _ARG_0_:GetState() or "WaitIdling" == _ARG_0_:GetState() then
        return
      end
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
EntityFactory:Add("b30ex00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b32ex00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b30exAR", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b30exSN", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b30exCS", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b30exAS", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
b31ex00_mt = {
  __index = {
    new = function(_ARG_0_)
      return setmetatable({}, b31ex00_mt)
    end,
    Consumption = function(_ARG_0_)
      Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 0.1)
      _ARG_0_.Used = false
    end,
    Replenishment = function(_ARG_0_)
      if _ARG_0_.Used == true then
        return
      end
      Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, 0.1)
      _ARG_0_.Used = true
    end,
    DispOn = function(_ARG_0_, _ARG_1_)
      if _ARG_0_.Used == true then
        Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, _ARG_1_)
      end
    end,
    DispOff = function(_ARG_0_, _ARG_1_)
      if _ARG_0_.Used == true then
        Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, _ARG_1_)
      end
    end,
    OnInit = function(_ARG_0_, _ARG_1_)
      _ARG_0_.myHandle = _ARG_1_
      _ARG_0_.ownerHandle = 0
      _ARG_0_.Used = true
    end,
    OnUpdate = function(_ARG_0_)
    end
  }
}
EntityFactory:Add("b31ex00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
