setmetatable({
  [18] = {
    {
      frame = 18,
      func = function(_ARG_0_)
        Camera.QuakeV(20, 0.3, 6)
        _UPVALUE0_:set(1.25, 0, 4.25)
        Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "Root", _UPVALUE0_)
        _UPVALUE1_:set(0, 0, 0)
        SetBulletAttackParam(Bullet.CreateBullet("b03sbSW", _UPVALUE0_, _UPVALUE1_), _ARG_0_.myHandle, 1)
      end
    },
    {
      frame = 43,
      func = function(_ARG_0_)
        Camera.QuakeV(20, 0.3, 6)
        _UPVALUE0_:set(-2.25, 0, 4.5)
        Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "Root", _UPVALUE0_)
        _UPVALUE1_:set(0, 0, 0)
        SetBulletAttackParam(Bullet.CreateBullet("b03sbSW", _UPVALUE0_, _UPVALUE1_), _ARG_0_.myHandle, 1)
      end
    }
  },
  [21] = {
    {
      frame = 18,
      func = function(_ARG_0_)
        Camera.QuakeV(20, 0.3, 6)
        _UPVALUE0_:set(-0.08, 0, 5.25)
        Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "Root", _UPVALUE0_)
        _UPVALUE1_:set(0, 0, 0)
        SetBulletAttackParam(Bullet.CreateBullet("b03sbSW", _UPVALUE0_, _UPVALUE1_), _ARG_0_.myHandle, 1)
      end
    },
    {
      frame = 43,
      func = function(_ARG_0_)
        Camera.QuakeV(20, 0.3, 6)
        _UPVALUE0_:set(2.4, 0, 3.75)
        Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "Root", _UPVALUE0_)
        _UPVALUE1_:set(0, 0, 0)
        SetBulletAttackParam(Bullet.CreateBullet("b03sbSW", _UPVALUE0_, _UPVALUE1_), _ARG_0_.myHandle, 1)
      end
    }
  },
  [24] = {
    {
      frame = 65,
      func = function(_ARG_0_)
        Camera.QuakeV(50, 0.5, 12)
      end
    }
  },
  [23] = {
    {
      frame = 38,
      func = function(_ARG_0_)
        _ARG_0_.enableStayFire = true
        _ARG_0_.stayFireName = "StayFire"
        _ARG_0_.stayFireTimer = 0
        _ARG_0_.stayFireAtkNo = 2
        _ARG_0_.stayFireLimit = 100
      end
    }
  },
  [25] = {
    {
      frame = 67,
      func = function(_ARG_0_)
        Camera.QuakeV(50, 0.5, 12)
      end
    },
    {
      frame = 98,
      func = function(_ARG_0_)
        _ARG_0_.enableStayFire = true
        _ARG_0_.stayFireName = "StayFire2"
        _ARG_0_.stayFireTimer = 5
        _ARG_0_.stayFireAtkNo = 7
        _ARG_0_.stayFireLimit = 50
        Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
        _UPVALUE1_:set(1, 0, 2.5)
        Math.RotateVectorXYZ(_UPVALUE1_, _UPVALUE0_)
        Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.myHandle)
        FVECTOR3.Add(_UPVALUE1_, _UPVALUE1_, _UPVALUE2_)
        _ARG_0_:CreateStayFire(_UPVALUE1_, _UPVALUE0_)
        Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
        _UPVALUE1_:set(-1, 0, 7.5)
        Math.RotateVectorXYZ(_UPVALUE1_, _UPVALUE0_)
        FVECTOR3.Add(_UPVALUE1_, _UPVALUE1_, _UPVALUE2_)
        _ARG_0_:CreateStayFire(_UPVALUE1_, _UPVALUE0_)
        Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
        _UPVALUE1_:set(4, 0, 14)
        Math.RotateVectorXYZ(_UPVALUE1_, _UPVALUE0_)
        Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.myHandle)
        FVECTOR3.Add(_UPVALUE1_, _UPVALUE1_, _UPVALUE2_)
        SetBulletAttackParam(Bullet.CreateBullet("StayFire3", _UPVALUE1_, _UPVALUE0_), _ARG_0_.myHandle, _ARG_0_.stayFireAtkNo)
        Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
        _UPVALUE1_:set(-4, 0, 14)
        Math.RotateVectorXYZ(_UPVALUE1_, _UPVALUE0_)
        Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.myHandle)
        FVECTOR3.Add(_UPVALUE1_, _UPVALUE1_, _UPVALUE2_)
        SetBulletAttackParam(Bullet.CreateBullet("StayFire3", _UPVALUE1_, _UPVALUE0_), _ARG_0_.myHandle, _ARG_0_.stayFireAtkNo)
        Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
        _UPVALUE1_:set(0, 0, 10.5)
        Math.RotateVectorXYZ(_UPVALUE1_, _UPVALUE0_)
        Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.myHandle)
        FVECTOR3.Add(_UPVALUE1_, _UPVALUE1_, _UPVALUE2_)
        _ARG_0_.flareStormEffHandle = Entity.SetEffect(_ARG_0_.myHandle, _UPVALUE3_, "B007_FST_00_0", _UPVALUE1_, _UPVALUE0_)
      end
    }
  },
  ["new"] = function(_ARG_0_)
    return setmetatable(MotionTrigger:new(), _UPVALUE0_)
  end
}, {__index = MotionTrigger})
setmetatable({
  new = function(_ARG_0_)
    return setmetatable(__StateMachine:new(), _UPVALUE0_)
  end,
  states = {
    Appear = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      end,
      OnEndState = function(_ARG_0_)
        _ARG_0_.flareStormTimer = _UPVALUE0_
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
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Entity.SetRot(_ARG_0_.myHandle, 0, Entity.CalcDirection(_ARG_0_.myHandle, _UPVALUE2_), 0)
        print("Idling\n")
      end,
      OnEndState = function(_ARG_0_)
        _ARG_0_.firagaBreathWaitTimer = 0
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR, SEARCH_OPTION_NO_CHECK_NPC)
        if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) >= _UPVALUE0_ then
          _ARG_0_.firagaBreathWaitTimer = _ARG_0_.firagaBreathWaitTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
          if _ARG_0_.firagaBreathWaitTimer <= 0 then
            _ARG_0_.stack:push("Idling")
            _ARG_0_.stack:push("FiragaBreath")
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
          return
        end
        if _ARG_0_:RestHpRate() < 0.5 and _ARG_0_.groundAttackCount >= _UPVALUE1_ then
          _ARG_0_.hurlingCount = 0
          Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
          Mission.SendMissonMessage(MES_BTL_MDRAGON_WAIT_TO_PHILLIP)
          _ARG_0_.stack:push("Hurling")
          _ARG_0_.stack:push("Idling2")
          _ARG_0_.stack:push("SpecificPosMove")
          _ARG_0_.stack:push("TakeOff")
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          return
        end
        if 0 >= _ARG_0_.flareStormTimer then
          Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
          _ARG_0_.stack:push("Idling")
          _ARG_0_.stack:push("FlareStorm")
          _ARG_0_.stack:push("EarthShake2")
          _ARG_0_.stack:push("EarthShake")
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          return
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
          return
        end
        _ARG_0_.stack:push("Idling")
        if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE2_ then
          if Script.Random() < _UPVALUE3_ then
            _ARG_0_.stack:push("Bite")
          elseif Script.Random() >= _UPVALUE3_ and Script.Random() < _UPVALUE3_ + _UPVALUE4_ then
            _ARG_0_.stack:push("Throwing")
          elseif Script.Random() >= _UPVALUE3_ + _UPVALUE4_ and Script.Random() < _UPVALUE3_ + _UPVALUE4_ + _UPVALUE5_ then
            _ARG_0_.stack:push("FiragaBreath")
          else
            _ARG_0_.stack:push("EarthShake")
          end
        else
          _ARG_0_.firagaBreathWaitTimer = _ARG_0_.firagaBreathWaitTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
          if _ARG_0_.firagaBreathWaitTimer > 0 then
            return
          end
          _ARG_0_.stack:push("FiragaBreath")
        end
        _ARG_0_.groundAttackCount = _ARG_0_.groundAttackCount + 1
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      end
    },
    Idling2 = {
      OnBeginState = function(_ARG_0_)
        if Entity.IsGround(_ARG_0_.myHandle) then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        else
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
        end
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE2_)
        print("Idling2\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    TakeOff = {
      OnBeginState = function(_ARG_0_)
        Mission.SendMissonMessage(MES_BTL_MDRAGON_WAIT_TO_PHILLIP)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.EnableGravity(_ARG_0_.myHandle, 0)
        Entity.SetTimer(_ARG_0_.myHandle, 80)
        _ARG_0_.step = 0
        print("TakeOff\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            _ARG_0_.step = 1
          end
        else
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 40 then
            _ARG_0_.workVec0:set(0, _UPVALUE1_, 0)
            Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.workVec0)
          end
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        end
      end
    },
    SpecificPosMove = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        if _ARG_0_.currentPath == 1 then
          Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
          if _UPVALUE1_:getz() < _UPVALUE2_:getz() then
            _ARG_0_:SetupPathMove(_UPVALUE3_)
          else
            _ARG_0_:SetupPathMove(_UPVALUE4_)
          end
        end
        _ARG_0_.step = 0
        print("SpecificPosMove\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.GetRot(_ARG_0_.workVec0, _ARG_0_.myHandle)
        if _ARG_0_:PathMove(_ARG_0_.pathData, _UPVALUE0_, true, 0.15) == false then
          _ARG_0_:EndPathMove()
          Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
          if _UPVALUE1_:getz() < _UPVALUE2_:getz() then
            Mission.SendMissonMessage(MES_BTL_MDRAGON_MOVE_TO_BOULDER_POS_0)
          else
            Mission.SendMissonMessage(MES_BTL_MDRAGON_MOVE_TO_BOULDER_POS_1)
          end
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    SpecificPosMove2 = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        if _ARG_0_.currentPath == 1 then
          Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
          if _UPVALUE1_:getz() < _UPVALUE2_:getz() then
            _ARG_0_:SetupPathMove(_UPVALUE3_)
          else
            _ARG_0_:SetupPathMove(_UPVALUE4_)
          end
        end
        _ARG_0_.step = 0
        print("SpecificPosMove2\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.GetRot(_ARG_0_.workVec0, _ARG_0_.myHandle)
        if _ARG_0_:PathMove(_ARG_0_.pathData, _UPVALUE0_, true, 0.15) == false then
          _ARG_0_:EndPathMove()
          Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
          if _UPVALUE1_:getz() < _UPVALUE2_:getz() then
            Mission.SendMissonMessage(MES_BTL_MDRAGON_MOVE_TO_BOULDER_POS_0)
          else
            Mission.SendMissonMessage(MES_BTL_MDRAGON_MOVE_TO_BOULDER_POS_1)
          end
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Flight = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetLockOnBoneNum(_ARG_0_.myHandle, _UPVALUE1_)
        if _ARG_0_.currentPath == 1 then
          Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.myHandle)
          if _UPVALUE2_:getz() < _UPVALUE3_:getz() then
            _ARG_0_:SetupPathMove(_UPVALUE4_)
          else
            _ARG_0_:SetupPathMove(_UPVALUE5_)
          end
        end
        print("Flight\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_:PathMove(_ARG_0_.pathData, _UPVALUE0_, false, 0.02) == false then
          _ARG_0_:EndPathMove()
          Entity.SetLockOnBoneNum(_ARG_0_.myHandle, _UPVALUE1_)
          if _ARG_0_.airDmgCount >= _UPVALUE2_ then
            _ARG_0_:GotoState("BodyLanding")
          else
            Entity.EnableRideColl(_ARG_0_.myHandle, 0, 0)
            _ARG_0_:GotoState("Landing")
          end
        end
      end
    },
    BodyLanding = {
      OnBeginState = function(_ARG_0_)
        Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
        if _UPVALUE0_:getz() < _UPVALUE1_:getz() then
          Entity.GetStartPos(_ARG_0_.targetPos, _ARG_0_.myHandle)
          _UPVALUE2_:copy(_ARG_0_.targetPos)
          _ARG_0_.targetPos:setz(_ARG_0_.targetPos:getz())
        else
          _ARG_0_.targetPos:copy(_UPVALUE3_)
          _UPVALUE2_:copy(_UPVALUE3_)
          _ARG_0_.targetPos:setz(_ARG_0_.targetPos:getz())
        end
        FVECTOR3.Sub(_UPVALUE2_, _UPVALUE2_, _UPVALUE0_)
        _UPVALUE2_:normalize()
        _UPVALUE2_:scale(_UPVALUE4_)
        Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE2_)
        Mission.SendMissonMessage(MES_BTL_MDRAGON_WARP_TO_ENEMY)
        _ARG_0_.step = 0
        _ARG_0_.step2 = 0
        Entity.SetTimer(_ARG_0_.myHandle, 60)
        print("BodyLanding\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step2 == 0 and Entity.IsTimeOver(_ARG_0_.myHandle) then
          Entity.EnableRideColl(_ARG_0_.myHandle, 0, 0)
          _ARG_0_.step2 = 1
        end
        Entity.TurnTargetYRate(_ARG_0_.myHandle, _ARG_0_.targetPos, 0.025)
        if _ARG_0_.step == 0 then
          if Entity.IsGround(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_:CameraQuakeV(50, 0.5, 12)
            _ARG_0_.step = 1
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Mission.SendMissonMessage(MES_BTL_MDRAGON_MOVE_TO_BOULDER_POS_2)
          _ARG_0_.stack:clear()
          _ARG_0_.stack:push("Hurling")
          _ARG_0_.stack:push("Idling2")
          _ARG_0_.stack:push("SpecificPosMove")
          _ARG_0_.stack:push("TakeOff")
          _ARG_0_.stack:push("Faint")
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Landing = {
      OnBeginState = function(_ARG_0_)
        if _ARG_0_.currentPath == 1 then
          Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
          if _UPVALUE0_:getz() < _UPVALUE1_:getz() then
            _ARG_0_:SetupPathMove(_UPVALUE2_)
            Entity.GetStartPos(_ARG_0_.targetPos, _ARG_0_.myHandle)
          else
            _ARG_0_:SetupPathMove(_UPVALUE3_)
            _ARG_0_.targetPos:copy(_UPVALUE4_)
          end
        end
        _ARG_0_.step = 0
        print("Landing\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if _ARG_0_:PathMove(_ARG_0_.pathData, _UPVALUE0_, true, 0.15) == false then
            _ARG_0_:EndPathMove()
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          Entity.TurnTargetYRate(_ARG_0_.myHandle, _ARG_0_.targetPos, 0.025)
          _ARG_0_.velocity:set(0, 0, _UPVALUE0_)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
          if 1 > Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetPos) then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
            Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.myHandle)
            _ARG_0_.workVec0:set(0, -(_UPVALUE2_:gety() / _UPVALUE3_), 0)
            Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.workVec0)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if Entity.IsGround(_ARG_0_.myHandle) then
            _ARG_0_:CameraQuakeV(50, 0.5, 12)
            _ARG_0_.step = 3
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Mission.SendMissonMessage(MES_BTL_MDRAGON_WARP_TO_ENEMY)
          if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) >= _UPVALUE4_ then
            _ARG_0_:GotoState("Idling")
          else
            _ARG_0_.stack:clear()
            _ARG_0_.stack:push("Hurling")
            _ARG_0_.stack:push("Idling2")
            _ARG_0_.stack:push("SpecificPosMove")
            _ARG_0_.stack:push("TakeOff")
            _ARG_0_.stack:push("EarthShake")
            _ARG_0_.stack:push("Idling2")
            if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _UPVALUE5_ then
              _ARG_0_.stack:push("FiragaBreath")
            end
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        end
      end
    },
    Landing2 = {
      OnBeginState = function(_ARG_0_)
        if _ARG_0_.currentPath == 1 then
          Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
          if _UPVALUE0_:getz() < _UPVALUE1_:getz() then
            _ARG_0_:SetupPathMove(_UPVALUE2_)
            Entity.GetStartPos(_ARG_0_.targetPos, _ARG_0_.myHandle)
          else
            _ARG_0_:SetupPathMove(_UPVALUE3_)
            _ARG_0_.targetPos:copy(_UPVALUE4_)
          end
        end
        _ARG_0_.step = 0
        print("Landing2\n")
      end,
      OnEndState = function(_ARG_0_)
        _ARG_0_.groundAttackCount = 0
        _ARG_0_.flareStormTimer = _UPVALUE0_
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
          if _ARG_0_:PathMove(_ARG_0_.pathData, _UPVALUE1_, true, 0.15) == false then
            _ARG_0_:EndPathMove()
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          Entity.TurnTargetYRate(_ARG_0_.myHandle, _ARG_0_.targetPos, 0.025)
          _ARG_0_.velocity:set(0, 0, _UPVALUE1_)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
          if 1 > Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetPos) then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
            Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
            _ARG_0_.workVec0:set(0, -(_UPVALUE0_:gety() / _UPVALUE3_), 0)
            Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.workVec0)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if Entity.IsGround(_ARG_0_.myHandle) then
            Mission.SendMissonMessage(MES_BTL_MDRAGON_CANCEL_TO_FLY)
            _ARG_0_:CameraQuakeV(50, 0.5, 12)
            _ARG_0_.step = 3
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.stack:clear()
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    Bite = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        print("Bite\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Throwing = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_.step = 0
        _ARG_0_.count = 2 + Script.RandomInteger(3)
        _ARG_0_.roty = 0
        Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
        _ARG_0_.bakRoty = _ARG_0_.rot:gety()
        print("Throwing\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
        _ARG_0_.rot:sety(_ARG_0_.bakRoty)
        Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if _ARG_0_.count > 1 then
            Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
          else
            _ARG_0_.targetPos:copy(_UPVALUE0_)
          end
          Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
          FVECTOR3.Sub(_ARG_0_.workVec0, _ARG_0_.targetPos, _ARG_0_.myPos)
          _ARG_0_.workVec0:normalize()
          Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
          _ARG_0_.workVec1:set(1, 0, 0)
          Math.RotateVectorXYZ(_ARG_0_.workVec1, _ARG_0_.rot)
          if 0 <= _ARG_0_.workVec1:dot(_ARG_0_.workVec0) then
            _ARG_0_.turnTbl = _UPVALUE1_
            _ARG_0_.turnValue = 0.01
          else
            _ARG_0_.turnTbl = _UPVALUE2_
            _ARG_0_.turnValue = -0.01
          end
          Entity.SetMotion(_ARG_0_.myHandle, _ARG_0_.turnTbl[1])
          _ARG_0_.step = 1
        elseif _ARG_0_.step == 1 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _ARG_0_.turnTbl[2], -2, -2)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if _ARG_0_.count > 1 then
            Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
          else
            _ARG_0_.targetPos:copy(_UPVALUE0_)
          end
          Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
          FVECTOR3.Sub(_ARG_0_.workVec0, _ARG_0_.targetPos, _ARG_0_.myPos)
          _ARG_0_.workVec0:normalize()
          Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
          _ARG_0_.workVec1:set(1, 0, 0)
          Math.RotateVectorXYZ(_ARG_0_.workVec1, _ARG_0_.rot)
          if 0 > _ARG_0_.turnValue then
            if 0 <= _ARG_0_.workVec1:dot(_ARG_0_.workVec0) then
              _ARG_0_.turnValue = 0
            end
          elseif 0 > _ARG_0_.workVec1:dot(_ARG_0_.workVec0) then
            _ARG_0_.turnValue = 0
          end
          _ARG_0_.roty = _ARG_0_.roty + _ARG_0_.turnValue * Entity.GetFrameRate(_ARG_0_.myHandle)
          _ARG_0_:TurnY()
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _ARG_0_.turnTbl[3])
            _ARG_0_.step = 3
          end
        elseif _ARG_0_.step == 3 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_.count = _ARG_0_.count - 1
            if 0 < _ARG_0_.count then
              _ARG_0_.step = 0
            else
              _ARG_0_.step = 4
            end
          end
        elseif Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE0_, 10) == false then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    FiragaBreath = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.enableStayFire = false
        print("FiragaBreath\n")
      end,
      OnEndState = function(_ARG_0_)
        _ARG_0_.firagaBreathWaitTimer = _UPVALUE0_
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    EarthShake = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        print("EarthShake\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    EarthShake2 = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Mission.SendMissonMessage(MES_BTL_MDRAGON_MOVE_TO_FLARE_POS)
        print("EarthShake2\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    FlareStorm = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.enableStayFire = false
        _ARG_0_.step = 0
        print("FlareStorm\n")
      end,
      OnEndState = function(_ARG_0_)
        _ARG_0_.flareStormTimer = _UPVALUE0_
        Effect.LoopEnd(_ARG_0_.flareStormEffHandle)
        _ARG_0_.flareStormEffHandle = NULL_HANDLE
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 60 then
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
            Mission.SendMissonMessage(MES_BTL_MDRAGON_FLARE_START)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Effect.LoopEnd(_ARG_0_.flareStormEffHandle)
            _ARG_0_.flareStormEffHandle = NULL_HANDLE
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
            Mission.SendMissonMessage(MES_BTL_MDRAGON_FLARE_END)
            _ARG_0_.step = 2
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Hurling = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Mission.SendMissonMessage(MES_BTL_MDRAGON_ACT_BOULDER_BREAKER)
        _ARG_0_.step = 0
        _ARG_0_.isPlayerRide = false
        Entity.SetLockOnBoneNum(_ARG_0_.myHandle, _UPVALUE1_)
        Entity.EnableRideColl(_ARG_0_.myHandle, 1, 0)
        Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.myHandle)
        print("Hurling\n")
      end,
      OnEndState = function(_ARG_0_)
        _ARG_0_.airDmgCount = 0
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.SetLockOnBoneNum(_ARG_0_.myHandle, _UPVALUE0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 28 then
            Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
            if _UPVALUE0_:getz() < _UPVALUE1_:getz() then
              _UPVALUE2_:copy(_UPVALUE3_)
            else
              _UPVALUE2_:copy(_UPVALUE4_)
            end
            FVECTOR3.Sub(_UPVALUE2_, _UPVALUE2_, _UPVALUE0_)
            _UPVALUE2_:normalize()
            _UPVALUE2_:scale(_UPVALUE5_)
            Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE2_)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if Entity.IsGround(_ARG_0_.myHandle) then
            Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
            _UPVALUE2_:copy(_UPVALUE0_)
            _UPVALUE2_:sety(_UPVALUE2_:gety() - 10)
            Collision.IntersectRayBg(_UPVALUE2_, COLL_KIND_ENEMY, _UPVALUE0_, _UPVALUE2_)
            Entity.GetRot(_UPVALUE6_, _ARG_0_.myHandle)
            Entity.SetEffect(_ARG_0_.myHandle, _UPVALUE7_, "B007_KEM_02_0", _UPVALUE2_, _UPVALUE6_)
            Entity.GetVelocity(_UPVALUE0_, _ARG_0_.myHandle)
            _UPVALUE0_:sety(0)
            Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE0_)
            Entity.SetTimer(_ARG_0_.myHandle, 60)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE8_)
            Entity.GetVelocity(_UPVALUE0_, _ARG_0_.myHandle)
            _UPVALUE0_:sety(0.1)
            Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE0_)
            Entity.SetTimer(_ARG_0_.myHandle, 60)
            Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 22)
            _UPVALUE2_:copy(_UPVALUE0_)
            _UPVALUE2_:sety(_UPVALUE2_:gety() - 20)
            Collision.IntersectRayBg(_UPVALUE2_, COLL_KIND_ENEMY, _UPVALUE0_, _UPVALUE2_)
            _UPVALUE6_:set(0, 0, 0)
            SetBulletAttackParam(Bullet.CreateBullet("WindPressure", _UPVALUE2_, _UPVALUE6_), _ARG_0_.myHandle, 6)
            _ARG_0_.step = 3
          end
        elseif Entity.IsTimeOver(_ARG_0_.myHandle) then
          Mission.SendMissonMessage(MES_BTL_MDRAGON_WAIT_TO_PHILLIP)
          if _ARG_0_.isPlayerRide then
            _ARG_0_.stack:push("Flight")
          elseif Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) >= _UPVALUE9_ then
            _ARG_0_.stack:push("Landing2")
          else
            _ARG_0_.hurlingCount = _ARG_0_.hurlingCount + 1
            if _ARG_0_.hurlingCount < _UPVALUE10_ then
              _ARG_0_.stack:push("Hurling")
              _ARG_0_.stack:push("Idling2")
              _ARG_0_.stack:push("SpecificPosMove")
            else
              _ARG_0_.stack:push("Landing2")
            end
          end
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Damage = {
      OnBeginState = function(_ARG_0_)
        if Entity.IsGround(_ARG_0_.myHandle) then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        else
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
        end
        print("Damage\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.oldState)
        end
      end
    },
    Faint = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, 60)
        _ARG_0_.step = 0
        print("Faint\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
            Mission.SendMissonMessage(MES_BTL_MDRAGON_ACT_BOULDER_BREAKER)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
            _ARG_0_.step = 2
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
    if Script.GetDebugTestParam() <= 0 then
      return Enemy.GetHp(_ARG_0_.myHandle) / Enemy.GetHpMax(_ARG_0_.myHandle)
    else
      return 0
    end
  end,
  TurnY = function(_ARG_0_)
    if _ARG_0_.roty < -DegToRad(20) then
      _ARG_0_.roty = -DegToRad(20)
    elseif DegToRad(20) < _ARG_0_.roty then
      _ARG_0_.roty = DegToRad(20)
    end
    Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
    _ARG_0_.rot:sety(RoundPI(_ARG_0_.roty + _ARG_0_.bakRoty))
    Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
  end,
  CameraQuakeV = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    Camera.QuakeV(_ARG_1_, _ARG_2_, _ARG_3_)
  end,
  ExecCreateStayFire = function(_ARG_0_)
    if _ARG_0_.enableStayFire == false then
      return
    end
    if 10 + _ARG_0_.stayFireTimer * 2.5 > _ARG_0_.stayFireLimit then
      return
    end
    Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
    _UPVALUE1_:set(0, (Script.Random() - Script.Random()) * PI, 0)
    if _ARG_0_.flag == 0 then
      _UPVALUE2_:set(1, 0, 10 + _ARG_0_.stayFireTimer * 2.5)
    else
      _UPVALUE2_:set(-1, 0, 10 + _ARG_0_.stayFireTimer * 2.5)
    end
    Math.RotateVectorXYZ(_UPVALUE2_, _UPVALUE0_)
    Entity.GetWorldPos(_UPVALUE3_, _ARG_0_.myHandle)
    FVECTOR3.Add(_UPVALUE2_, _UPVALUE2_, _UPVALUE3_)
    _ARG_0_:CreateStayFire(_UPVALUE2_, _UPVALUE0_)
    _ARG_0_.flag = 1 - _ARG_0_.flag
    _ARG_0_.stayFireTimer = _ARG_0_.stayFireTimer + Entity.GetFrameRate(_ARG_0_.myHandle)
  end,
  CreateStayFire = function(_ARG_0_, _ARG_1_, _ARG_2_)
    SetBulletAttackParam(Bullet.CreateBullet(_ARG_0_.stayFireName, _ARG_1_, _ARG_2_), _ARG_0_.myHandle, _ARG_0_.stayFireAtkNo)
    return (Bullet.CreateBullet(_ARG_0_.stayFireName, _ARG_1_, _ARG_2_))
  end,
  SetupPathMove = function(_ARG_0_, _ARG_1_)
    _ARG_0_.currentPath = 1
    _ARG_0_.progress = 0
    _ARG_0_.pathData = _ARG_1_
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
    _UPVALUE0_:sety(0)
    _ARG_0_.pathData[1][1]:copy(_UPVALUE0_)
    _ARG_0_.oldPos:copy(_UPVALUE0_)
    Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
    _ARG_0_.roty = _UPVALUE0_:gety()
  end,
  EndPathMove = function(_ARG_0_)
    _ARG_0_.currentPath = 1
    _ARG_0_.progress = 0
    Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
    _UPVALUE0_:sety(_ARG_0_.roty)
    Entity.SetRot(_ARG_0_.myHandle, _UPVALUE0_)
  end,
  PathMove = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
    _ARG_0_.progress = _ARG_0_.progress + _ARG_2_ * Entity.GetFrameRate(_ARG_0_.myHandle)
    if _ARG_0_.currentPath - 1 > 0 then
    end
    if _ARG_0_.currentPath + 2 <= #_ARG_1_ then
    end
    if _ARG_1_[_ARG_0_.currentPath][2] ~= -1 then
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_1_[_ARG_0_.currentPath][2])
    end
    FVECTOR3.Sub(_UPVALUE0_, _ARG_1_[_ARG_0_.currentPath][1], _ARG_1_[_ARG_0_.currentPath + 1][1])
    if 1 <= _ARG_0_.progress / _UPVALUE0_:length() then
      _ARG_0_.progress = 0
      _ARG_0_.currentPath = _ARG_0_.currentPath + 1
      if #_ARG_1_ - 1 < _ARG_0_.currentPath then
        _ARG_0_:CatmullRomMove(_ARG_1_[_ARG_0_.currentPath - 1][1], _ARG_1_[_ARG_0_.currentPath][1], _ARG_1_[_ARG_0_.currentPath + 1][1], _ARG_1_[_ARG_0_.currentPath + 2][1], 1, _ARG_3_, _ARG_4_)
        return false
      end
    end
    _ARG_0_:CatmullRomMove(_ARG_1_[_ARG_0_.currentPath - 1][1], _ARG_1_[_ARG_0_.currentPath][1], _ARG_1_[_ARG_0_.currentPath + 1][1], _ARG_1_[_ARG_0_.currentPath + 2][1], 1, false, _ARG_4_)
    return true
  end,
  HermiteMove = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_)
    _UPVALUE0_:copy(_ARG_2_)
    _UPVALUE1_:copy(_ARG_3_)
    if _ARG_1_ == nil then
      FVECTOR3.Sub(_UPVALUE2_, _ARG_2_, _ARG_3_)
      FVECTOR3.Add(_UPVALUE2_, _UPVALUE2_, _ARG_2_)
    else
      _UPVALUE2_:copy(_ARG_1_)
    end
    if _ARG_4_ == nil then
      FVECTOR3.Sub(_UPVALUE3_, _ARG_3_, _ARG_2_)
      FVECTOR3.Add(_UPVALUE3_, _UPVALUE3_, _ARG_3_)
    else
      _UPVALUE3_:copy(_ARG_4_)
    end
    FVECTOR3.Sub(_UPVALUE4_, _UPVALUE0_, _UPVALUE2_)
    FVECTOR3.Sub(_UPVALUE5_, _UPVALUE1_, _UPVALUE0_)
    FVECTOR3.Sub(_UPVALUE6_, _UPVALUE3_, _UPVALUE1_)
    FVECTOR3.Add(_UPVALUE0_, _UPVALUE4_, _UPVALUE5_)
    _UPVALUE0_:scale(0.5)
    FVECTOR3.Add(_UPVALUE1_, _UPVALUE5_, _UPVALUE6_)
    _UPVALUE1_:scale(0.5)
    FVECTOR3.Hermite(_UPVALUE2_, _ARG_2_, _UPVALUE0_, _ARG_3_, _UPVALUE1_, _ARG_5_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
    _UPVALUE2_:sety(_UPVALUE0_:gety())
    Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE2_)
    FVECTOR3.Sub(_UPVALUE3_, _UPVALUE2_, _ARG_0_.oldPos)
    if _UPVALUE3_:dot(_UPVALUE3_) > 1.0E-4 then
      Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
      _UPVALUE1_:sety(Math.Atan2(_UPVALUE3_:getx(), _UPVALUE3_:getz()))
      Entity.SetRot(_ARG_0_.myHandle, _UPVALUE1_)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE7_)
    else
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE8_)
    end
    _ARG_0_.oldPos:copy(_UPVALUE2_)
  end,
  CatmullRomMove = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_, _ARG_6_, _ARG_7_)
    _UPVALUE0_:copy(_ARG_2_)
    _UPVALUE1_:copy(_ARG_3_)
    if _ARG_1_ == nil then
      FVECTOR3.Sub(_UPVALUE2_, _UPVALUE0_, _UPVALUE1_)
      FVECTOR3.Add(_UPVALUE2_, _UPVALUE2_, _UPVALUE0_)
    else
      _UPVALUE2_:copy(_ARG_1_)
    end
    if _ARG_4_ == nil then
      FVECTOR3.Sub(_UPVALUE3_, _UPVALUE1_, _UPVALUE0_)
      FVECTOR3.Add(_UPVALUE3_, _UPVALUE3_, _UPVALUE1_)
    else
      _UPVALUE3_:copy(_ARG_4_)
    end
    _ARG_0_.targetIK:copy(_UPVALUE3_)
    _UPVALUE2_:scale(-0.5 * (_ARG_5_ * _ARG_5_ * _ARG_5_) + _ARG_5_ * _ARG_5_ - 0.5 * _ARG_5_)
    _UPVALUE0_:scale(1.5 * (_ARG_5_ * _ARG_5_ * _ARG_5_) + -2.5 * (_ARG_5_ * _ARG_5_) + 1)
    _UPVALUE1_:scale(-1.5 * (_ARG_5_ * _ARG_5_ * _ARG_5_) + 2 * (_ARG_5_ * _ARG_5_) + 0.5 * _ARG_5_)
    _UPVALUE3_:scale(0.5 * (_ARG_5_ * _ARG_5_ * _ARG_5_) - 0.5 * (_ARG_5_ * _ARG_5_))
    FVECTOR3.Add(_UPVALUE2_, _UPVALUE2_, _UPVALUE0_)
    FVECTOR3.Add(_UPVALUE2_, _UPVALUE2_, _UPVALUE1_)
    FVECTOR3.Add(_UPVALUE2_, _UPVALUE2_, _UPVALUE3_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
    _UPVALUE2_:sety(_UPVALUE0_:gety())
    Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE2_)
    FVECTOR3.Sub(_UPVALUE3_, _UPVALUE2_, _ARG_0_.oldPos)
    if _UPVALUE3_:dot(_UPVALUE3_) > 1.0000001E-6 then
      _ARG_0_.roty = Math.Atan2(_UPVALUE3_:getx(), _UPVALUE3_:getz())
    end
    Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
    if _ARG_6_ then
      if -0.5 > RadToDeg(RoundPI(_ARG_0_.roty - _UPVALUE1_:gety())) then
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE4_)
      elseif 0.5 < RadToDeg(RoundPI(_ARG_0_.roty - _UPVALUE1_:gety())) then
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE5_)
      elseif Entity.GetCurrentMotion(_ARG_0_.myHandle) == _UPVALUE4_ then
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE6_)
      elseif Entity.GetCurrentMotion(_ARG_0_.myHandle) == _UPVALUE6_ then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE5_)
        end
      else
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE5_)
      end
    end
    _UPVALUE1_:sety(TurnRadianRate(_UPVALUE1_:gety(), _ARG_0_.roty, _ARG_7_, Entity.GetFrameRate(_ARG_0_.myHandle)))
    Entity.SetRot(_ARG_0_.myHandle, _UPVALUE1_)
    _ARG_0_.oldPos:copy(_UPVALUE2_)
  end,
  GetTargetIK = function(_ARG_0_)
    return _ARG_0_.targetIK
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    Player.SetBossCamera("b03sb")
    _UPVALUE0_ = Enemy.GetExtraParam(_ARG_1_, "flight_spd")
    _UPVALUE1_ = Enemy.GetExtraParam(_ARG_1_, "rnd_bite") * 0.01
    _UPVALUE2_ = Enemy.GetExtraParam(_ARG_1_, "rnd_throw") * 0.01
    _UPVALUE3_ = Enemy.GetExtraParam(_ARG_1_, "rnd_fb") * 0.01
    _UPVALUE4_ = Enemy.GetExtraParam(_ARG_1_, "rnd_es") * 0.01
    _UPVALUE5_ = Enemy.GetExtraParam(_ARG_1_, "atk_dist")
    _UPVALUE5_ = _UPVALUE5_ * _UPVALUE5_
    _UPVALUE6_ = Enemy.GetExtraParam(_ARG_1_, "air_dmg")
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.targetHandle = NULL_HANDLE
    _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.oldPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
    _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
    _ARG_0_.workVec0 = FVECTOR3.new(0, 0, 0)
    _ARG_0_.workVec1 = FVECTOR3.new(0, 0, 0)
    _ARG_0_.workVec2 = FVECTOR3.new(0, 0, 0)
    _ARG_0_.workVec3 = FVECTOR3.new(0, 0, 0)
    _ARG_0_.workVec4 = FVECTOR3.new(0, 0, 0)
    _ARG_0_.targetIK = FVECTOR3.new(0, 0, 0)
    _ARG_0_.step = 0
    _ARG_0_.step2 = 0
    _ARG_0_.stack = Stack:Create()
    _ARG_0_.turnTbl = 0
    _ARG_0_.turnValue = 0
    _ARG_0_.roty = 0
    _ARG_0_.count = 0
    _ARG_0_.currentPath = 1
    _ARG_0_.progress = 0
    _ARG_0_.pathData = nil
    _ARG_0_.dmgCount = 0
    _ARG_0_.airDmgCount = 0
    _ARG_0_.hurlingCount = 0
    _ARG_0_.groundAttackCount = _UPVALUE7_
    _ARG_0_.stayFireTimer = 0
    _ARG_0_.stayFireName = ""
    _ARG_0_.stayFireAtkNo = 2
    _ARG_0_.stayFireLength = 100
    _ARG_0_.flareStormEffHandle = NULL_HANDLE
    _ARG_0_.firagaBreathWaitTimer = 0
    _ARG_0_.flareStormTimer = _UPVALUE8_
    _ARG_0_.flag = 0
    _ARG_0_.enableStayFire = false
    _ARG_0_.oldState = nil
    _ARG_0_.isPlayerRide = false
    _ARG_0_.roty = 0
    _ARG_0_.bakRoty = 0
    _ARG_0_.height = 0
    _ARG_0_.time = 0
    _ARG_0_.motTrg = _UPVALUE9_:new()
    Entity.SetMovementCollRadius(_ARG_1_, 2)
    Entity.SetLowerHalf(_ARG_1_, 2.5)
    Entity.SetDropShadowDistance(_ARG_1_, 20)
    Entity.SetLockOnBoneNum(_ARG_1_, _UPVALUE10_)
    Entity.EnableCameraBodyColl(_ARG_1_, 1)
    Entity.InitRideCollision(_ARG_1_, "b03sb0a", 22)
    Entity.EnableRideColl(_ARG_1_, 0, 0)
    _ARG_0_:GotoState("Appear")
  end,
  OnReturnDamage = function(_ARG_0_)
    _ARG_0_:GotoState("Idling")
  end,
  OnHitAttack = function(_ARG_0_)
  end,
  IsDmgCountState = function(_ARG_0_, _ARG_1_)
    for _FORV_5_, _FORV_6_ in pairs(_UPVALUE0_) do
      if _ARG_1_ == _FORV_6_ then
        return true
      end
    end
    return false
  end,
  OnDamage = function(_ARG_0_, _ARG_1_, _ARG_2_)
    if Entity.GetDamageCommandKind(_ARG_0_.myHandle) == COMMAND_KIND_BoulderBreaker then
      Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
      Sound.PlaySe(244, 14, 1, _UPVALUE0_)
    end
    if _ARG_0_:GetState() == "FlareStorm" and Entity.GetDamageCommandKind(_ARG_0_.myHandle) == COMMAND_KIND_BoulderBreaker then
      Entity.SetTimer(_ARG_0_.myHandle, 0)
      Mission.SendMissonMessage(MES_BTL_MDRAGON_FLARE_END)
      _ARG_0_.oldState = _ARG_0_.stack:pop(1)
      _ARG_0_:GotoState("Damage")
      return 1
    end
    if _ARG_0_:IsDmgCountState((_ARG_0_:GetState())) then
      _ARG_0_.dmgCount = _ARG_0_.dmgCount + 1
      if _ARG_0_.dmgCount >= _UPVALUE1_ then
        _ARG_0_.oldState, _ARG_0_.dmgCount = _ARG_0_:GetState(), 0
        _ARG_0_:GotoState("Damage")
        return 1
      end
    end
    if _ARG_0_:GetState() == "Flight" then
      _ARG_0_.airDmgCount = _ARG_0_.airDmgCount + Entity.GetDamagePoint(_ARG_0_.myHandle)
    end
    return 1
  end,
  OnDead = function(_ARG_0_)
    SetupBossDead(_ARG_0_.myHandle)
    _ARG_0_:GotoState("Dead")
    return 1
  end,
  OnRide = function(_ARG_0_, _ARG_1_, _ARG_2_)
    if Entity.IsPlayer(_ARG_1_) then
      _ARG_0_.isPlayerRide = true
    end
  end,
  OnUpdate = function(_ARG_0_)
    _ARG_0_:Update()
    _ARG_0_:Debug()
    _ARG_0_.motTrg:Update(_ARG_0_, Entity.GetCurrentMotion(_ARG_0_.myHandle), Entity.GetMotionNowFrame(_ARG_0_.myHandle))
    _ARG_0_:ExecCreateStayFire()
    if _ARG_0_.flareStormTimer > 0 then
      _ARG_0_.flareStormTimer = _ARG_0_.flareStormTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
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
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR, SEARCH_OPTION_NO_CHECK_NPC)
        _ARG_0_:GotoState(_UPVALUE0_[Script.GetDebugAttackNumber() + 1])
      end
    end
  end
}, {__index = __StateMachine})
EntityFactory:Add("b03sb00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("StayFire", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("StayFire2", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("StayFire3", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("WindPressure", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b03sbSW", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
