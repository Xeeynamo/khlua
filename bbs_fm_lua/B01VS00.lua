b01vs00 = {}
b01vs00_base_mt = {__index = __StateMachine}
setmetatable(b01vs00, b01vs00_base_mt)
b01vs00_mt = {__index = b01vs00}
function b01vs00.new(_ARG_0_)
  print("b01vs00:new()\n")
  return setmetatable(__StateMachine:new(), b01vs00_mt)
end
b01vs00.states = {
  Appear = {
    OnBeginState = function(_ARG_0_)
      SetupAppearBegin2(_ARG_0_.myHandle, 1, _UPVALUE0_, 0)
    end,
    OnEndState = function(_ARG_0_)
      SetupAppearEnd(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_:GotoState("Idling")
    end
  },
  Idling = {
    OnBeginState = function(_ARG_0_)
      print("b01vs00:Idling\n")
      Entity.SetTimer(_ARG_0_.myHandle, Script.Random() * _UPVALUE0_ + _UPVALUE0_ / 2)
      _ARG_0_:SetMotionWithSameCheck(_UPVALUE1_)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      _ARG_0_.step = 0
      _ARG_0_.ImitNum = Script.Random() * 2 + 3
      _ARG_0_.stack:clear()
      Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
      Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
      Entity.EnableLockon(_ARG_0_.myHandle, 1)
      _ARG_0_:controlBody(1)
      _ARG_0_.NoReactionDamage = 0
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 3)
      if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
        return
      end
      _ARG_0_.stack:push("Search")
      _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
    end
  },
  Search = {
    OnBeginState = function(_ARG_0_)
      print("b01vs00:Search\n")
      _ARG_0_.stack:clear()
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.stack:push("Idling")
      if _ARG_0_.ImitCnt > _ARG_0_.ImitNum and Entity.IsPlayer(_ARG_0_.targetHandle) then
        if _ARG_0_:RestHpRate() < _UPVALUE0_ then
          _ARG_0_.stack:push("Imitation2_Start")
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        else
          _ARG_0_.stack:push("Imitation1_Start")
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
        return
      end
      if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE1_ then
        if Script.Random() < _UPVALUE2_ then
          _ARG_0_.stack:push("Search")
          if Script.Random() < 0.5 then
            _ARG_0_.stack:push("Escape")
          else
            _ARG_0_.stack:push("Move")
          end
        end
        _ARG_0_.stack:push("Attack1")
      else
        if _ARG_0_.MagicGyroFlag == 1 then
          _ARG_0_.stack:push("Attack2")
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          return
        end
        if _ARG_0_.Attack2Flag == 1 then
          _ARG_0_.stack:push("MagicGyro")
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          return
        end
        if Script.Random() < _UPVALUE3_ then
          _ARG_0_.stack:push("Attack2")
        else
          _ARG_0_.stack:push("MagicGyro")
        end
      end
      _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
    end
  },
  Move = {
    OnBeginState = function(_ARG_0_)
      print("b01vs00:Move\n")
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_:SetMotion(_UPVALUE1_)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, -1.5)
      _ARG_0_:Retreat(_UPVALUE0_)
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      end
    end
  },
  Escape = {
    OnBeginState = function(_ARG_0_)
      print("b01vs00:Escape\n")
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_:SetMotion(_UPVALUE1_)
      _ARG_0_.step = 0
      Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      _ARG_0_:controlBody(1)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.noEndTime = _ARG_0_.noEndTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      if _ARG_0_.step == 0 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 12 then
          _ARG_0_:controlBody(0)
          Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:SetMotion(_UPVALUE0_)
          _ARG_0_.step = 1
          _ARG_0_.noEndTime = _UPVALUE1_
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 3600 then
            _ARG_0_.step = 1
          else
            _ARG_0_.step = 3
          end
        end
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE2_ then
          _ARG_0_.away = 9
          _ARG_0_.WorkVec:set(0, 0, 0)
          Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
          _ARG_0_.targetPos:setx(_ARG_0_.targetPos:getx() + ((_ARG_0_.away * Script.Random() + _ARG_0_.away) * Math.Cos((RoundPI(Script.Random() * 5 * PI))) + _ARG_0_.WorkVec:getx()))
          _ARG_0_.targetPos:setz(_ARG_0_.targetPos:getz() + ((_ARG_0_.away * Script.Random() + _ARG_0_.away) * Math.Sin((RoundPI(Script.Random() * 5 * PI))) + _ARG_0_.WorkVec:getz()))
        else
          _ARG_0_.away = 9
          _ARG_0_.WorkVec:set(0, 0, 0)
          _ARG_0_.targetPos:set(0, 0, 0)
          _ARG_0_.targetPos:setx(_ARG_0_.targetPos:getx() + ((_ARG_0_.away * Script.Random() + _ARG_0_.away) * Math.Cos((RoundPI(Script.Random() * 5 * PI))) + _ARG_0_.WorkVec:getx()))
          _ARG_0_.targetPos:setz(_ARG_0_.targetPos:getz() + ((_ARG_0_.away * Script.Random() + _ARG_0_.away) * Math.Sin((RoundPI(Script.Random() * 5 * PI))) + _ARG_0_.WorkVec:getz()))
        end
      elseif _ARG_0_.step == 1 then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, -2)
        _ARG_0_.velocity:set(0, 0, 1)
        _ARG_0_.velocity:scale(_UPVALUE3_)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
        if _ARG_0_.noEndTime < 0 then
          _UPVALUE4_:set(0, 0, 0)
          if 3600 > Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _UPVALUE4_) then
            _ARG_0_:SetMotion(_UPVALUE5_)
            _ARG_0_.step = 2
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
          end
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:SetMotion(_UPVALUE5_)
          _ARG_0_.step = 2
          Entity.ClearSpeed(_ARG_0_.myHandle)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
        end
      elseif _ARG_0_.step == 3 then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 2)
        _ARG_0_.velocity:set(0, 0, 1)
        _ARG_0_.velocity:scale(_UPVALUE3_)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
        if Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetPos) < 4 then
          _ARG_0_:SetMotion(_UPVALUE5_)
          _ARG_0_.step = 2
          Entity.ClearSpeed(_ARG_0_.myHandle)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
        end
      elseif _ARG_0_.step == 2 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 22 then
          _ARG_0_:controlBody(1)
          _ARG_0_.step = 2
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
          Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    end
  },
  Attack1 = {
    OnBeginState = function(_ARG_0_)
      print("b01vs00:Attack1\n")
      _ARG_0_:SetMotion(_UPVALUE0_)
      _ARG_0_.step = 0
      _ARG_0_.ImitCnt = _ARG_0_.ImitCnt + 1
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 2)
      if _ARG_0_.step == 0 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 16 then
          _ARG_0_:CreateShockwave(0)
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 32 then
          _ARG_0_:CreateShockwave(1)
          _ARG_0_.step = 2
        end
      elseif _ARG_0_.step == 2 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 48 then
          _ARG_0_:CreateShockwave(2)
          _ARG_0_.step = 3
        end
      elseif _ARG_0_.step == 3 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      end
    end
  },
  Attack2 = {
    OnBeginState = function(_ARG_0_)
      print("b01vs00:Attack2\n")
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_:SetMotion(_UPVALUE1_)
      _ARG_0_.step = _UPVALUE2_
      _ARG_0_.SinTimer = 0
      _ARG_0_.count = 0
      Entity.GetWorldPos(_ARG_0_.workVec, _ARG_0_.myHandle, 38)
      _ARG_0_.workVec:set(0, 0, 1)
      Entity.SetCenterOfGravity(_ARG_0_.myHandle, _ARG_0_.workVec)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      _ARG_0_.ImitCnt = _ARG_0_.ImitCnt + 1
      _ARG_0_.MagicGyroFlag = 0
      _ARG_0_.Attack2Flag = 1
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      _ARG_0_.wait = _UPVALUE3_
      Entity.SetTimer(_ARG_0_.myHandle, 21)
      _ARG_0_.NoReactionDamage = 1
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_.workVec:set(0, 0, 0)
      Entity.SetCenterOfGravity(_ARG_0_.myHandle, _ARG_0_.workVec)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      _ARG_0_:TurnX(0, 180)
      Entity.EnableGravity(_ARG_0_.myHandle, 1)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
    end,
    OnUpdate = function(_ARG_0_)
      Entity.EnableGravity(_ARG_0_.myHandle, 0)
      _ARG_0_.wait = _ARG_0_.wait - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      if _ARG_0_.step == _UPVALUE0_ then
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_.step = _UPVALUE1_
        end
      elseif _ARG_0_.step == _UPVALUE1_ then
        _ARG_0_.WorkVec:set(0, 0, 0)
        Entity.GetWorldPos2(_ARG_0_.targetPos, _ARG_0_.targetHandle, _ARG_0_.WorkVec)
        _ARG_0_.targetY = Script.Random() * 2 + 0.5
        _ARG_0_.targetPos:setx(_ARG_0_.targetPos:getx() + 5 * Script.Random() * Math.Cos((RoundPI(Script.Random() * 2 * PI))))
        _ARG_0_.targetPos:sety(_ARG_0_.targetY + _ARG_0_.targetPos:gety() + 5 * Script.Random() * Math.Sin((RoundPI(Script.Random() * 2 * PI))))
        _ARG_0_.step = _UPVALUE2_
        Entity.SetTimer(_ARG_0_.myHandle, 15)
      elseif _ARG_0_.step == _UPVALUE2_ then
        _ARG_0_.SinCurve_PowerNow = HomingDegree(_ARG_0_.SinCurve_PowerNow, _ARG_0_.SinCurve_Power, 0.005, (Entity.GetFrameRate(_ARG_0_.myHandle)))
        Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
        _ARG_0_.velocity:set(0, 0, 1)
        Math.RotateVectorXYZ(_ARG_0_.velocity, _ARG_0_.rot)
        _ARG_0_.velocity:scale(_UPVALUE3_)
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
        Entity.TurnTargetDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 1.5)
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 9 then
          Entity.TurnTargetDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 2)
        end
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 36 then
          Entity.TurnTargetDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 2)
        else
          Entity.TurnTargetDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 5)
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_.count = _ARG_0_.count + 1
          end
          _ARG_0_.step = _UPVALUE1_
          if _ARG_0_.count > 30 then
            _ARG_0_:SetMotion(_UPVALUE4_)
            _ARG_0_.step = _UPVALUE5_
            Entity.ClearSpeed(_ARG_0_.myHandle)
          end
        end
      elseif _ARG_0_.step == _UPVALUE6_ then
        Entity.TurnTargetDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 2.5)
        Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
        _ARG_0_.velocity:set(0, 0, 1)
        Math.RotateVectorXYZ(_ARG_0_.velocity, _ARG_0_.rot)
        _ARG_0_.velocity:scale(_UPVALUE3_)
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
        if 0 > _ARG_0_.wait then
          _ARG_0_:SetMotion(_UPVALUE4_)
          _ARG_0_.step = _UPVALUE5_
          Entity.ClearSpeed(_ARG_0_.myHandle)
        end
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 9 then
          _ARG_0_.step = _UPVALUE7_
        end
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > 36 then
          _ARG_0_.step = _UPVALUE1_
        end
      elseif _ARG_0_.step == _UPVALUE7_ then
        _ARG_0_.velocity:set(0, 0, 1)
        _ARG_0_.velocity:scale(_UPVALUE3_)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
        if 0 > _ARG_0_.wait then
          _ARG_0_:SetMotion(_UPVALUE4_)
          _ARG_0_.step = _UPVALUE5_
          Entity.ClearSpeed(_ARG_0_.myHandle)
        end
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > 36 or Entity.IsWall(_ARG_0_.myHandle) then
          _ARG_0_.step = _UPVALUE1_
        end
      elseif _ARG_0_.step == _UPVALUE5_ then
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        _ARG_0_:TurnX(0, 10)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    end
  },
  MagicGyro = {
    OnBeginState = function(_ARG_0_)
      print("b01vs00:MagicGyro\n")
      Entity.SetTimer(_ARG_0_.myHandle, 0)
      _ARG_0_.step = _UPVALUE0_
      _ARG_0_:SetMotion(_UPVALUE1_)
      _ARG_0_.rotationCnt = 0
      _ARG_0_.rotationTime = 0
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      _ARG_0_.ImitCnt = _ARG_0_.ImitCnt + 1
      _ARG_0_.MagicGyroFlag = 1
      _ARG_0_.Attack2Flag = 0
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      _ARG_0_.NoReactionDamage = 1
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_:pageMove()
      if _ARG_0_.step == _UPVALUE0_ then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.step = _UPVALUE1_
          _ARG_0_:fadeInPage()
          _ARG_0_:changeLaserState("Idling", 4, _UPVALUE2_)
          _ARG_0_:changeLaserState("Idling", 6, _UPVALUE2_)
        end
      elseif _ARG_0_.step == _UPVALUE1_ then
        if Entity.HasNetGameHandle(_ARG_0_.myHandle) == false then
          _ARG_0_.step = _UPVALUE3_
          return
        end
        if Enemy.IsNetworkMasterinteger(_ARG_0_.myHandle) == 0 then
          return
        end
        if 1 <= _ARG_0_.rotationCnt then
          print("NetworkMaster\n")
          _ARG_0_:GotoState("MagicGyro1")
        end
      elseif _ARG_0_.step == _UPVALUE3_ then
        if 1 <= _ARG_0_.rotationCnt then
          _ARG_0_.rotationCnt = 0
          _ARG_0_.step = _UPVALUE4_
          _ARG_0_:changeLaserState("Idling", 0, _UPVALUE5_)
          _ARG_0_:changeLaserState("Idling", 2, _UPVALUE5_)
          _ARG_0_:changeLaserState("Shoot", 4, _UPVALUE2_)
          _ARG_0_:changeLaserState("Shoot", 6, _UPVALUE2_)
        end
      elseif _ARG_0_.step == _UPVALUE4_ then
        if 1 <= _ARG_0_.rotationCnt then
          _ARG_0_.rotationCnt = 0
          _ARG_0_.step = _UPVALUE6_
          _ARG_0_:changeLaserState("Shoot", 0, _UPVALUE5_)
          _ARG_0_:changeLaserState("Shoot", 2, _UPVALUE5_)
          _ARG_0_:changeLaserState("Idling", 5, _UPVALUE2_)
          _ARG_0_:changeLaserState("Idling", 7, _UPVALUE2_)
          _ARG_0_:changeLaserState("EndShoot", 4, _UPVALUE2_)
          _ARG_0_:changeLaserState("EndShoot", 6, _UPVALUE2_)
        end
      elseif _ARG_0_.step == _UPVALUE6_ then
        if 1 <= _ARG_0_.rotationCnt then
          _ARG_0_.rotationCnt = 0
          _ARG_0_.step = _UPVALUE7_
          _ARG_0_:changeLaserState("Idling", 1, _UPVALUE5_)
          _ARG_0_:changeLaserState("Idling", 3, _UPVALUE5_)
          _ARG_0_:changeLaserState("Idling", 4, _UPVALUE5_)
          _ARG_0_:changeLaserState("Idling", 6, _UPVALUE5_)
          _ARG_0_:changeLaserState("Shoot", 5, _UPVALUE2_)
          _ARG_0_:changeLaserState("Shoot", 7, _UPVALUE2_)
          _ARG_0_:changeLaserState("EndShoot", 0, _UPVALUE2_)
          _ARG_0_:changeLaserState("EndShoot", 2, _UPVALUE2_)
        end
      elseif _ARG_0_.step == _UPVALUE7_ then
        if 1 <= _ARG_0_.rotationCnt then
          _ARG_0_.rotationCnt = 0
          _ARG_0_.step = _UPVALUE8_
          _ARG_0_:changeLaserState("Shoot", 1, _UPVALUE5_)
          _ARG_0_:changeLaserState("Shoot", 3, _UPVALUE5_)
          _ARG_0_:changeLaserState("Shoot", 4, _UPVALUE2_)
          _ARG_0_:changeLaserState("Shoot", 6, _UPVALUE2_)
          _ARG_0_:changeLaserState("EndShoot", 5, _UPVALUE2_)
          _ARG_0_:changeLaserState("EndShoot", 7, _UPVALUE2_)
        end
      elseif _ARG_0_.step == _UPVALUE8_ then
        if _ARG_0_.rotationCnt >= 2 + 1 then
          _ARG_0_.rotationCnt = 0
          _ARG_0_.step = _UPVALUE9_
          _ARG_0_:changeLaserState("EndShoot", 0, _UPVALUE5_)
          _ARG_0_:changeLaserState("EndShoot", 1, _UPVALUE5_)
          _ARG_0_:changeLaserState("EndShoot", 2, _UPVALUE5_)
          _ARG_0_:changeLaserState("EndShoot", 3, _UPVALUE5_)
          _ARG_0_:changeLaserState("EndShoot", 4, _UPVALUE2_)
          _ARG_0_:changeLaserState("EndShoot", 5, _UPVALUE2_)
          _ARG_0_:changeLaserState("EndShoot", 6, _UPVALUE2_)
          _ARG_0_:changeLaserState("EndShoot", 7, _UPVALUE2_)
          _ARG_0_:fadeOutPage()
          _ARG_0_:SetMotion(_UPVALUE10_)
        end
      elseif _ARG_0_.step == _UPVALUE9_ then
        Entity.ClearSpeed(_ARG_0_.myHandle)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    end
  },
  MagicGyro1 = {
    OnBeginState = function(_ARG_0_)
      print("b01vs00:MagicGyro1\n")
      _ARG_0_.rotationCnt = 0
      _ARG_0_:changeLaserState("Idling", 0, _UPVALUE0_)
      _ARG_0_:changeLaserState("Idling", 2, _UPVALUE0_)
      _ARG_0_:changeLaserState("Shoot", 4, _UPVALUE1_)
      _ARG_0_:changeLaserState("Shoot", 6, _UPVALUE1_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_:pageMove()
      if Enemy.IsNetworkMasterinteger(_ARG_0_.myHandle) == 0 then
        return
      end
      if 1 <= _ARG_0_.rotationCnt then
        _ARG_0_.rotationCnt = 0
        _ARG_0_:GotoState("MagicGyro2")
      end
    end
  },
  MagicGyro2 = {
    OnBeginState = function(_ARG_0_)
      print("b01vs00:MagicGyro2\n")
      _ARG_0_.rotationCnt = 0
      _ARG_0_:changeLaserState("Shoot", 0, _UPVALUE0_)
      _ARG_0_:changeLaserState("Shoot", 2, _UPVALUE0_)
      _ARG_0_:changeLaserState("Idling", 5, _UPVALUE1_)
      _ARG_0_:changeLaserState("Idling", 7, _UPVALUE1_)
      _ARG_0_:changeLaserState("EndShoot", 4, _UPVALUE1_)
      _ARG_0_:changeLaserState("EndShoot", 6, _UPVALUE1_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_:pageMove()
      if Enemy.IsNetworkMasterinteger(_ARG_0_.myHandle) == 0 then
        return
      end
      if 1 <= _ARG_0_.rotationCnt then
        _ARG_0_.rotationCnt = 0
        _ARG_0_:GotoState("MagicGyro3")
      end
    end
  },
  MagicGyro3 = {
    OnBeginState = function(_ARG_0_)
      print("b01vs00:MagicGyro3\n")
      _ARG_0_.rotationCnt = 0
      _ARG_0_:changeLaserState("Idling", 1, _UPVALUE0_)
      _ARG_0_:changeLaserState("Idling", 3, _UPVALUE0_)
      _ARG_0_:changeLaserState("Idling", 4, _UPVALUE0_)
      _ARG_0_:changeLaserState("Idling", 6, _UPVALUE0_)
      _ARG_0_:changeLaserState("Shoot", 5, _UPVALUE1_)
      _ARG_0_:changeLaserState("Shoot", 7, _UPVALUE1_)
      _ARG_0_:changeLaserState("EndShoot", 0, _UPVALUE1_)
      _ARG_0_:changeLaserState("EndShoot", 2, _UPVALUE1_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_:pageMove()
      if Enemy.IsNetworkMasterinteger(_ARG_0_.myHandle) == 0 then
        return
      end
      if 1 <= _ARG_0_.rotationCnt then
        _ARG_0_.rotationCnt = 0
        _ARG_0_:GotoState("MagicGyro4")
      end
    end
  },
  MagicGyro4 = {
    OnBeginState = function(_ARG_0_)
      print("b01vs00:MagicGyro4\n")
      _ARG_0_.rotationCnt = 0
      _ARG_0_:changeLaserState("Shoot", 1, _UPVALUE0_)
      _ARG_0_:changeLaserState("Shoot", 3, _UPVALUE0_)
      _ARG_0_:changeLaserState("Shoot", 4, _UPVALUE1_)
      _ARG_0_:changeLaserState("Shoot", 6, _UPVALUE1_)
      _ARG_0_:changeLaserState("EndShoot", 5, _UPVALUE1_)
      _ARG_0_:changeLaserState("EndShoot", 7, _UPVALUE1_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_:pageMove()
      if Enemy.IsNetworkMasterinteger(_ARG_0_.myHandle) == 0 then
        return
      end
      if 2 <= _ARG_0_.rotationCnt then
        _ARG_0_.rotationCnt = 0
        _ARG_0_:GotoState("MagicGyro5")
      end
    end
  },
  MagicGyro5 = {
    OnBeginState = function(_ARG_0_)
      print("b01vs00:MagicGyro5\n")
      _ARG_0_.rotationCnt = 0
      _ARG_0_:changeLaserState("EndShoot", 0, _UPVALUE0_)
      _ARG_0_:changeLaserState("EndShoot", 1, _UPVALUE0_)
      _ARG_0_:changeLaserState("EndShoot", 2, _UPVALUE0_)
      _ARG_0_:changeLaserState("EndShoot", 3, _UPVALUE0_)
      _ARG_0_:changeLaserState("EndShoot", 4, _UPVALUE1_)
      _ARG_0_:changeLaserState("EndShoot", 5, _UPVALUE1_)
      _ARG_0_:changeLaserState("EndShoot", 6, _UPVALUE1_)
      _ARG_0_:changeLaserState("EndShoot", 7, _UPVALUE1_)
      _ARG_0_:SetMotion(_UPVALUE2_)
      _ARG_0_:fadeOutPage()
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
    end,
    OnUpdate = function(_ARG_0_)
      if Enemy.IsNetworkMasterinteger(_ARG_0_.myHandle) == 0 then
        return
      end
      Entity.ClearSpeed(_ARG_0_.myHandle)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      end
    end
  },
  MagicGyroEnd = {
    OnBeginState = function(_ARG_0_)
      print("b01vs00:MagicGyroEnd\n")
      _ARG_0_:SetMotion(_UPVALUE0_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.rotationTime = _ARG_0_.rotationTime + 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      if _ARG_0_.rotationTime > 360 then
        _ARG_0_.rotationCnt = _ARG_0_.rotationCnt + 1
        print("rotationCnt = " .. _ARG_0_.rotationCnt .. "\n")
        _ARG_0_.rotationTime = 0
      end
      if _ARG_0_.step == _UPVALUE0_ or _ARG_0_.step == _UPVALUE1_ or _ARG_0_.step == _UPVALUE2_ or _ARG_0_.step == _UPVALUE3_ or _ARG_0_.step == _UPVALUE4_ or _ARG_0_.step == _UPVALUE5_ or _ARG_0_.step == _UPVALUE6_ then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 2.1)
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 25 then
          _ARG_0_:Retreat(_UPVALUE7_)
        elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > 81 then
          _ARG_0_:Advancement(_UPVALUE8_)
        else
          Entity.ClearSpeed(_ARG_0_.myHandle)
        end
        for _FORV_7_ = 0, 3 do
          _ARG_0_:SetCirclePosition(_FORV_7_, _ARG_0_.pageData[_FORV_7_].handle, 0)
        end
        for _FORV_7_ = 4, 7 do
          _ARG_0_:SetCirclePosition(_FORV_7_, _ARG_0_.pageData[_FORV_7_].handle, 1)
        end
      else
      end
      if 2 <= _ARG_0_.rotationCnt then
        _ARG_0_.rotationCnt = 0
        _ARG_0_:GotoState("MagicGyroEnd")
      end
    end
  },
  Imitation1_Start = {
    OnBeginState = function(_ARG_0_)
      print("b01vs00:Imitation1_Start\n")
      _ARG_0_.AttackFlag = 0
      _ARG_0_.step = _UPVALUE0_
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_, 0, 0)
      _ARG_0_.ImitCnt = 0
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      Entity.SetTimer(_ARG_0_.myHandle, 30)
      _ARG_0_.meaHandle = NULL_HANDLE
      _ARG_0_.NoReactionDamage = 1
    end,
    OnEndState = function(_ARG_0_)
      Entity.LoopEndEffectAttach(_ARG_0_.myHandle, 0)
      if _ARG_0_.meaHandle == NULL_HANDLE then
      end
      _ARG_0_.meaHandle = _ARG_0_.targetHandle
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == _UPVALUE0_ then
        if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
          return
        end
        Entity.SetTimer(_ARG_0_.myHandle, 480)
        _ARG_0_.step = _UPVALUE1_
      elseif _ARG_0_.step == _UPVALUE1_ then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
        _ARG_0_.workVec0:set(0, 1, 0)
        if Entity.IsPlayer(_ARG_0_.targetHandle) then
        else
          _ARG_0_:GotoState("Imitation1_Failure")
          return
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Imitation1_Failure")
          return
        end
        if Entity.IsTargetWithinFOV(_ARG_0_.myHandle, _ARG_0_.targetHandle, DegToRad(190), 2, _ARG_0_.workVec0) then
          return
        end
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > 4 then
          _ARG_0_:InhaleForPlayer(_ARG_0_.targetHandle, 4, 100, _UPVALUE2_, "F_book2")
        end
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 9 then
          _ARG_0_.meaHandle = _ARG_0_.targetHandle
          _ARG_0_.step = _UPVALUE3_
          Entity.SetTimer(_ARG_0_.myHandle, 60)
          Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
          Entity.LoopEndEffectAttach(_ARG_0_.myHandle, 0)
        end
      elseif _ARG_0_.step == _UPVALUE3_ then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.meaHandle, 5)
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > 4 then
          _ARG_0_:InhaleForPlayer(_ARG_0_.meaHandle, 4, 100, _UPVALUE2_, "F_book2")
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Imitation1_Roop")
        end
      end
    end
  },
  Imitation1_Failure = {
    OnBeginState = function(_ARG_0_)
      print("b01vs00:Imitation1_Failure\n")
      _ARG_0_:SetMotion(_UPVALUE0_)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Imitation2_Failure = {
    OnBeginState = function(_ARG_0_)
      print("b01vs00:Imitation2_Failure\n")
      _ARG_0_:SetMotion(_UPVALUE0_)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Imitation1_Roop = {
    OnBeginState = function(_ARG_0_)
      print("b01vs00:Imitation1_Roop\n")
      Entity.SetEffectAttach(_ARG_0_.myHandle, 1, "305", 1)
      Entity.AttachEffect(_ARG_0_.meaHandle, "b01vs00", "B022_IMI_HIT0_0", "center")
      _ARG_0_:SetMotion(_UPVALUE0_)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:SetMotion(_UPVALUE0_)
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Imitation1_Out")
        end
      elseif _ARG_0_.step == 2 then
      end
    end
  },
  Imitation1_Out = {
    OnBeginState = function(_ARG_0_)
      print("b01vs00:Imitation1_Out\n")
      _ARG_0_:SetMotion(_UPVALUE0_)
      _ARG_0_.step = 0
      _ARG_0_.buruburuCnt = 0
      _ARG_0_.roadFlag = 0
    end,
    OnEndState = function(_ARG_0_)
      if Entity.GetName(_ARG_0_.meaHandle) == "p11ex00" then
        _ARG_0_.copyNmae = "b62ex00"
      elseif Entity.GetName(_ARG_0_.meaHandle) == "p13ex00" then
        _ARG_0_.copyNmae = "b72ex00"
      elseif Entity.GetName(_ARG_0_.meaHandle) == "p12ex00" then
        _ARG_0_.copyNmae = "b82ex00"
      end
      _ARG_0_.workVec1:set(0, 0, 1)
      Entity.GetWorldPos2(_ARG_0_.myPos, _ARG_0_.myHandle, _ARG_0_.workVec1, 1)
      Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
      _ARG_0_.pcEnemy[0].handle = Entity.CreateEntity(_ARG_0_.copyNmae, _ARG_0_.myPos, _ARG_0_.rot)
      SetOriginalHandle(_ARG_0_.pcEnemy[0].handle, _ARG_0_.meaHandle)
      CreateGauge(_ARG_0_.pcEnemy[0].handle)
      _ARG_0_.WorkVec:set(0, Script.Random() * 0.3 + 0.1, Script.Random() * 0.4 - 0.2)
      Entity.EnableGravity(_ARG_0_.pcEnemy[0].handle, 1)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 12 then
          _ARG_0_:controlBody(0)
          Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:SetMotion(_UPVALUE0_)
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:SetMotion(_UPVALUE0_)
          if Entity.IsPlayer(_ARG_0_.meaHandle) then
          else
            _ARG_0_.step = 3
            Entity.SetTimer(_ARG_0_.myHandle, 80)
            return
          end
          _ARG_0_.buruburuCnt = _ARG_0_.buruburuCnt + 1
          if Entity.GetName(_ARG_0_.meaHandle) == "p11ex00" then
            _ARG_0_.copyNmae = "b62ex00"
          elseif Entity.GetName(_ARG_0_.meaHandle) == "p13ex00" then
            _ARG_0_.copyNmae = "b72ex00"
          elseif Entity.GetName(_ARG_0_.meaHandle) == "p12ex00" then
            _ARG_0_.copyNmae = "b82ex00"
          end
          if 0 < _ARG_0_.buruburuCnt then
            _ARG_0_:SetMotion(_UPVALUE1_)
            _ARG_0_.step = 2
          end
        end
      elseif _ARG_0_.step == 2 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 8 then
          _ARG_0_.step = 3
          Entity.SetTimer(_ARG_0_.myHandle, 80)
          SetSummonsFlag(_ARG_0_.myHandle, 1, 1)
          if Entity.HasNetGameHandle(_ARG_0_.myHandle) == false then
            return
          end
          if Enemy.IsNetworkMaster(_ARG_0_.myHandle) == true then
          end
        end
      elseif _ARG_0_.step == 3 then
        _ARG_0_:GotoState("Imitation1_Idling")
      elseif _ARG_0_.step == 4 then
      end
    end
  },
  Imitation1_Idling = {
    OnBeginState = function(_ARG_0_)
      print("b01vs00:Imitation1_Idling\n")
      Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
      Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
      Entity.EnableLockon(_ARG_0_.myHandle, 0)
      Entity.EnableShooton(_ARG_0_.myHandle, 0)
      _ARG_0_:createEffect("b01vs00", "B022_IMI_SMK0_0")
      Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 30)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      SetSummonsFlag(_ARG_0_.myHandle, 0, 1)
      _ARG_0_.createCopyFlag = 0
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.IsAlive(_ARG_0_.pcEnemy[0].handle) == false then
          if Entity.HasNetGameHandle(_ARG_0_.myHandle) == false then
            _ARG_0_:GotoState("Imitation1_End")
            return
          end
          if Enemy.IsNetworkMasterinteger(_ARG_0_.myHandle) == 0 then
            return
          end
          _ARG_0_:GotoState("Imitation1_End")
        else
          Entity.GetWorldPos(_ARG_0_.pcEnemy[0].pos, _ARG_0_.pcEnemy[0].handle)
          Entity.GetRot(_ARG_0_.pcEnemy[0].rot, _ARG_0_.pcEnemy[0].handle)
        end
      elseif _ARG_0_.step == 1 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 22 then
          _ARG_0_:controlBody(1)
          _ARG_0_.step = 2
        end
      elseif _ARG_0_.step == 2 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:SetMotion(_UPVALUE0_)
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          _ARG_0_.step = 3
        end
      elseif _ARG_0_.step == 3 then
      end
    end
  },
  Imitation1_End = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_:controlBody(1)
      print("b01vs00:Imitation1_End\n")
      Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, 30)
      _ARG_0_:SetMotion(_UPVALUE0_)
      _ARG_0_.step = 1
      Entity.SetLocalPos(_ARG_0_.myHandle, _ARG_0_.pcEnemy[0].pos)
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.meaHandle, 180)
    end,
    OnEndState = function(_ARG_0_)
      Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
      Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
      Entity.EnableLockon(_ARG_0_.myHandle, 1)
      Entity.EnableShooton(_ARG_0_.myHandle, 1)
      _ARG_0_:controlBody(1)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 1 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 22 then
          Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
          Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
          Entity.EnableLockon(_ARG_0_.myHandle, 1)
          _ARG_0_:controlBody(1)
          _ARG_0_.step = 2
        end
      elseif _ARG_0_.step == 2 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:SetMotion(_UPVALUE0_)
          _ARG_0_.step = 3
          Entity.SetTimer(_ARG_0_.myHandle, 80)
        end
      elseif _ARG_0_.step == 3 and Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      end
    end
  },
  Imitation2_Start = {
    OnBeginState = function(_ARG_0_)
      print("b01vs00:Imitation2_Start\n")
      _ARG_0_:SetMotion(_UPVALUE0_)
      _ARG_0_.AttackFlag = 0
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      _ARG_0_.step = _UPVALUE1_
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      Entity.SetTimer(_ARG_0_.myHandle, 30)
      _ARG_0_.ImitCnt = 0
      _ARG_0_.meaHandle = NULL_HANDLE
      _ARG_0_:allPLPageStateIdling()
      _ARG_0_.NoReactionDamage = 1
    end,
    OnEndState = function(_ARG_0_)
      if _ARG_0_.meaHandle == NULL_HANDLE then
        _ARG_0_.meaHandle = _ARG_0_.targetHandle
      end
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == _UPVALUE0_ then
        if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
          return
        end
        Entity.SetTimer(_ARG_0_.myHandle, 480)
        _ARG_0_.step = _UPVALUE1_
      elseif _ARG_0_.step == _UPVALUE1_ then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
        _ARG_0_.workVec0:set(0, 1, 0)
        if Entity.IsPlayer(_ARG_0_.targetHandle) then
        else
          _ARG_0_:GotoState("Imitation1_Failure")
          return
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Imitation1_Failure")
          return
        end
        if Entity.IsTargetWithinFOV(_ARG_0_.myHandle, _ARG_0_.targetHandle, DegToRad(190), 2, _ARG_0_.workVec0) then
          return
        end
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > 4 then
          _ARG_0_:InhaleForPlayer(_ARG_0_.targetHandle, 4, 100, _UPVALUE2_, "F_book2")
        end
        if Enemy.IsNetworkMasterinteger(_ARG_0_.myHandle) == 0 then
        end
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 9 then
          _ARG_0_.meaHandle = _ARG_0_.targetHandle
          Entity.FadeoutAllEffectAttach(_ARG_0_.myHandle, 20, 0)
          Entity.SetTimer(_ARG_0_.myHandle, 20)
          _ARG_0_.step = _UPVALUE3_
        end
      elseif _ARG_0_.step == _UPVALUE3_ then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.meaHandle, 5)
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > 4 then
          _ARG_0_:InhaleForPlayer(_ARG_0_.meaHandle, 4, 100, _UPVALUE2_, "F_book2")
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Imitation2_Roop")
        end
      end
    end
  },
  Imitation2_Roop = {
    OnBeginState = function(_ARG_0_)
      print("b01vs00:Imitation2_Roop\n")
      Entity.SetEffectAttach(_ARG_0_.myHandle, 1, "305", 1)
      Entity.AttachEffect(_ARG_0_.meaHandle, "b01vs00", "B022_IMI_HIT0_0", "center")
      _ARG_0_:SetMotion(_UPVALUE0_)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:SetMotion(_UPVALUE0_)
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Imitation2_Out")
        end
      elseif _ARG_0_.step == 2 then
      end
    end
  },
  Imitation2_Out = {
    OnBeginState = function(_ARG_0_)
      print("b01vs00:Imitation2_Out\n")
      _ARG_0_:SetMotion(_UPVALUE0_)
      _ARG_0_.step = 0
      _ARG_0_.buruburuCnt = 0
      Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
    end,
    OnEndState = function(_ARG_0_)
      print("b01vs00:Imitation2_Out\n")
      _ARG_0_:controlBody(0)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 12 then
          _ARG_0_:controlBody(0)
          Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:SetMotion(_UPVALUE0_)
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:SetMotion(_UPVALUE0_)
          _ARG_0_.buruburuCnt = _ARG_0_.buruburuCnt + 1
          if 0 < _ARG_0_.buruburuCnt then
            _ARG_0_:SetMotion(_UPVALUE1_)
            _ARG_0_.step = 2
          end
        end
      elseif _ARG_0_.step == 2 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 8 then
          _ARG_0_:GotoState("Imitation2_Idling")
        end
      elseif _ARG_0_.step == 3 then
      elseif _ARG_0_.step == 4 then
      end
    end
  },
  Imitation2_PageState = {
    OnBeginState = function(_ARG_0_)
      Entity.SetTimer(_ARG_0_.myHandle, 80)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Imitation2_Idling")
      end
    end
  },
  Imitation2_Idling = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_:createEffect("b01vs00", "B022_IMI_SMK0_0")
      Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
      Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
      Entity.EnableShooton(_ARG_0_.myHandle, 0)
      Entity.EnableLockon(_ARG_0_.myHandle, 0)
      Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 30)
      _ARG_0_:initPLPage()
      _ARG_0_:pagePLModelDisp()
      _ARG_0_:fadeInAllPLPage()
      print("b01vs00:Imitation2_Idling\n")
      _ARG_0_.step = 0
      Entity.SetTimer(_ARG_0_.myHandle, 120)
    end,
    OnEndState = function(_ARG_0_)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      _ARG_0_:controlBody(1)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsTimeOver(_ARG_0_.myHandle) and _ARG_0_.step == 0 then
        if _ARG_0_:pageAliveChake() == 0 and _ARG_0_:PLEnemyAliveChakeAll() == 0 then
          _ARG_0_:GotoState("Imitation2_Summons")
        else
          Entity.GetWorldPos(_ARG_0_.pcEnemy[0].pos, _ARG_0_.pcEnemy[0].handle)
          Entity.GetRot(_ARG_0_.pcEnemy[0].rot, _ARG_0_.pcEnemy[0].handle)
          if _ARG_0_:PLEnemyAliveChake() == 1 then
            _ARG_0_:GotoState("Imitation2_Summons_Second")
          end
        end
      end
    end
  },
  Imitation2_Summons_Second = {
    OnBeginState = function(_ARG_0_)
      Entity.SetTimer(_ARG_0_.myHandle, 120)
      print("b01vs00:Imitation2_Summons_Second\n")
      _ARG_0_:Imit2Summons_Second()
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_:OnSummonEnemyDamageColl()
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
        return
      end
      _ARG_0_:GotoState("Imitation2_Summons_Second2")
    end
  },
  Imitation2_Summons_Second2 = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.step = 0
      print("b01vs00:Imitation2_Summons_Second2\n")
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_:controlBody(1)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if _ARG_0_:pageAliveChake() == 0 and _ARG_0_:PLEnemyAliveChakeAll() == 0 then
          _ARG_0_:GotoState("Imitation2_Summons")
        else
          Entity.GetWorldPos(_ARG_0_.pcEnemy[0].pos, _ARG_0_.pcEnemy[0].handle)
          Entity.GetRot(_ARG_0_.pcEnemy[0].rot, _ARG_0_.pcEnemy[0].handle)
          if _ARG_0_:PLEnemyAliveChake() == 1 then
            _ARG_0_:GotoState("Imitation2_Summons_Second3")
          end
        end
      end
    end
  },
  Imitation2_Summons_Second3 = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.step = 0
      print("b01vs00:Imitation2_Summons_Second3\n")
      Entity.SetTimer(_ARG_0_.myHandle, 30)
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_:controlBody(1)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
        return
      end
      if _ARG_0_.step == 0 then
        _ARG_0_:GotoState("Imitation2_Summons_Second")
      end
    end
  },
  Imitation2_Summons = {
    OnBeginState = function(_ARG_0_)
      Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, 30)
      Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
      Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
      Entity.EnableShooton(_ARG_0_.myHandle, 1)
      Entity.EnableLockon(_ARG_0_.myHandle, 1)
      _ARG_0_:SetMotion(_UPVALUE0_)
      _ARG_0_.step = 1
      Entity.SetLocalPos(_ARG_0_.myHandle, _ARG_0_.pcEnemy[0].pos)
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.meaHandle, 180)
      _ARG_0_:allPLPageStateIdling()
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_:controlBody(1)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 1 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 22 then
          _ARG_0_:controlBody(1)
          _ARG_0_.step = 2
        end
      elseif _ARG_0_.step == 2 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:SetMotion(_UPVALUE0_)
          _ARG_0_.step = 3
          Entity.SetTimer(_ARG_0_.myHandle, 80)
        end
      elseif _ARG_0_.step == 3 and Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      end
    end
  },
  Imitation2_END = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_:SetMotion(_UPVALUE0_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
    end
  },
  Standby = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 1)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.EnableLockon(_ARG_0_.myHandle, 1)
      Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, 1)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Exusia.IsExistenceSchedule() == true then
          _ARG_0_.step = 1
          Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, 1)
        else
        end
      elseif _ARG_0_.step == 1 then
      end
      if Enemy.IsAllEnemyWaiting() == false then
        _ARG_0_:GotoState("Idling")
        Entity.EnableLockon(_ARG_0_.myHandle, 1)
      end
    end
  },
  Dead = {
    OnBeginState = function(_ARG_0_)
      Entity.EnableLockon(_ARG_0_.myHandle, 0)
      _ARG_0_:changeLaserState("EndShoot", 0, _UPVALUE0_)
      _ARG_0_:changeLaserState("EndShoot", 1, _UPVALUE0_)
      _ARG_0_:changeLaserState("EndShoot", 2, _UPVALUE0_)
      _ARG_0_:changeLaserState("EndShoot", 3, _UPVALUE0_)
      _ARG_0_:changeLaserState("EndShoot", 4, _UPVALUE1_)
      _ARG_0_:changeLaserState("EndShoot", 5, _UPVALUE1_)
      _ARG_0_:changeLaserState("EndShoot", 6, _UPVALUE1_)
      _ARG_0_:changeLaserState("EndShoot", 7, _UPVALUE1_)
      _ARG_0_:fadeOutPage()
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
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
}
function b01vs00.pageMove(_ARG_0_)
  _ARG_0_.rotationTime = _ARG_0_.rotationTime + 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_0_.rotationTime > 180 then
    _ARG_0_.rotationCnt = _ARG_0_.rotationCnt + 1
    print("rotationCnt = " .. _ARG_0_.rotationCnt .. "\n")
    _ARG_0_.rotationTime = 0
  end
  if _ARG_0_.step == _UPVALUE0_ or _ARG_0_.step == _UPVALUE1_ or _ARG_0_.step == _UPVALUE2_ or _ARG_0_.step == _UPVALUE3_ or _ARG_0_.step == _UPVALUE4_ or _ARG_0_.step == _UPVALUE5_ or _ARG_0_.step == _UPVALUE6_ then
    Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 2.1)
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 25 then
      _ARG_0_:Retreat(_UPVALUE7_)
    elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > 81 then
      _ARG_0_:Advancement(_UPVALUE8_)
    else
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end
    for _FORV_6_ = 0, 3 do
      _ARG_0_:SetCirclePosition(_FORV_6_, _ARG_0_.pageData[_FORV_6_].handle, 0)
    end
    for _FORV_6_ = 4, 7 do
      _ARG_0_:SetCirclePosition(_FORV_6_, _ARG_0_.pageData[_FORV_6_].handle, 1)
    end
  else
  end
end
function b01vs00.Move(_ARG_0_, _ARG_1_, _ARG_2_)
  FVECTOR3.set(_ARG_0_.WorkVec, _ARG_0_.velocity:getx(), _ARG_0_.velocity:gety(), _ARG_0_.velocity:getz())
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function b01vs00.setVeloctiy(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  _ARG_0_.velocity:set(_ARG_1_, _ARG_2_, _ARG_3_)
end
function b01vs00.SetMotionWithSameCheck(_ARG_0_, _ARG_1_)
  Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_1_)
end
function b01vs00.SetMotion(_ARG_0_, _ARG_1_)
  Entity.SetMotion(_ARG_0_.myHandle, _ARG_1_)
end
function b01vs00.TurnX(_ARG_0_, _ARG_1_, _ARG_2_)
  Entity.EnableAvoidPlayer(_ARG_0_.myHandle, 0)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  _ARG_0_.rot:setx(HomingDegree(_ARG_0_.rot:getx(), _ARG_1_, _ARG_2_, Entity.GetFrameRate(_ARG_0_.myHandle)))
  Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
  return HomingDegree(_ARG_0_.rot:getx(), _ARG_1_, _ARG_2_, Entity.GetFrameRate(_ARG_0_.myHandle))
end
function b01vs00.deletePage(_ARG_0_, _ARG_1_)
  Entity.Out(_ARG_0_.pageData[_ARG_1_].handle)
end
function b01vs00.fadeOutPage(_ARG_0_)
  for _FORV_4_ = 0, 7 do
    Entity.SetupModelFade(_ARG_0_.pageData[_FORV_4_].handle, 1, 0, 30)
    Effect.LoopEnd(_ARG_0_.pageData[_FORV_4_].effecthandle)
  end
end
function b01vs00.fadeInPage(_ARG_0_)
  for _FORV_4_ = 0, 7 do
    Entity.SetupModelFade(_ARG_0_.pageData[_FORV_4_].handle, 0, 1, 30)
  end
end
function b01vs00.deletePagePL(_ARG_0_, _ARG_1_)
  Entity.Out(_ARG_0_.pageDataPL[_ARG_1_].handle)
end
function b01vs00.SetCirclePosition(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  Entity.GetWorldPos(_ARG_0_.WorkVec1, _ARG_2_)
  if _ARG_3_ == 1 then
  end
  Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.myHandle)
  _ARG_0_.WorkVec:setx(_ARG_0_.WorkVec:getx() + 2 * Math.Cos(DegToRad(_ARG_0_.pageData[_ARG_1_].Angle)))
  _ARG_0_.WorkVec:sety(_ARG_0_.WorkVec1:gety())
  _ARG_0_.WorkVec:setz(_ARG_0_.WorkVec:getz() + 2 * Math.Sin(DegToRad(_ARG_0_.pageData[_ARG_1_].Angle)))
  Entity.SetLocalPos(_ARG_2_, _ARG_0_.WorkVec)
  Entity.TurnTargetYDegree(_ARG_2_, _ARG_0_.myHandle, 180)
  Entity.GetRot(_ARG_0_.rot, _ARG_2_)
  _ARG_0_.rot:sety(_ARG_0_.rot:gety() + DegToRad(180))
  Entity.SetRot(_ARG_2_, _ARG_0_.rot)
  _ARG_0_.pageData[_ARG_1_].Angle = _ARG_0_.pageData[_ARG_1_].Angle + -1 * Entity.GetFrameRate(_ARG_0_.myHandle)
end
function b01vs00.createEightPage(_ARG_0_)
  Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
  for _FORV_5_ = 0, 3 do
    _ARG_0_.WorkVec:setx(_ARG_0_.myPos:getx() + 2 * Math.Cos(DegToRad(90 * _FORV_5_)))
    _ARG_0_.WorkVec:sety(_ARG_0_.myPos:gety())
    _ARG_0_.WorkVec:setz(_ARG_0_.myPos:getz() + 2 * Math.Sin(DegToRad(90 * _FORV_5_)))
    _ARG_0_.rot:set(0, 0, 0)
    FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.myPos, _ARG_0_.WorkVec)
    FVECTOR3.normalize(_ARG_0_.workVec)
    _ARG_0_.pageData[0].handle = Entity.CreateEntity("b02vs00", _ARG_0_.WorkVec, _ARG_0_.rot, _ARG_0_.myHandle)
    Entity.SetupModelFade(_ARG_0_.pageData[0].handle, 1, 0, 1)
    createEightPage = _FORV_5_
    _ARG_0_.pageData[0].Angle = 90 * _FORV_5_
    _ARG_0_.pageData[0].Type = 0
  end
  _FOR_.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
  _ARG_0_.myPos:sety(_ARG_0_.myPos:gety() + 0.9)
  for _FORV_5_ = 0, 3 do
    _ARG_0_.WorkVec:setx(_ARG_0_.myPos:getx() + 2 * Math.Cos(DegToRad(90 * _FORV_5_)))
    _ARG_0_.WorkVec:sety(_ARG_0_.myPos:gety())
    _ARG_0_.WorkVec:setz(_ARG_0_.myPos:getz() + 2 * Math.Sin(DegToRad(90 * _FORV_5_)))
    _ARG_0_.rot:set(0, 0, 0)
    FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.myPos, _ARG_0_.WorkVec)
    FVECTOR3.normalize(_ARG_0_.workVec)
    Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
    _ARG_0_.rot:sety(DegToRad(90 * _FORV_5_) + DegToRad(90))
    _ARG_0_.pageData[0 + 1].handle = Entity.CreateEntity("b02vs00", _ARG_0_.WorkVec, _ARG_0_.rot, _ARG_0_.myHandle)
    Entity.SetupModelFade(_ARG_0_.pageData[0 + 1].handle, 1, 0, 1)
    _ARG_0_.pageData[0 + 1].Angle = 90 * _FORV_5_
    _ARG_0_.pageData[0 + 1].Index = _FORV_5_
    _ARG_0_.pageData[0 + 1].Type = 1
  end
end
function b01vs00.fadeOutAllPLPage(_ARG_0_)
  for _FORV_4_ = 0, _UPVALUE0_ do
    Entity.SetupModelFade(_ARG_0_.pageDataPL[_FORV_4_].handle, 1, 0, 30)
    Entity.EnableLockon(_ARG_0_.pageDataPL[_FORV_4_].handle, 0)
  end
end
function b01vs00.fadeInAllPLPage(_ARG_0_)
  for _FORV_4_ = 0, _UPVALUE0_ do
    Entity.SetupModelFade(_ARG_0_.pageDataPL[_FORV_4_].handle, 0, 1, 30)
    Entity.EnableLockon(_ARG_0_.pageDataPL[_FORV_4_].handle, 1)
  end
end
function b01vs00.fadeOutPLPage(_ARG_0_, _ARG_1_)
  Entity.SetupModelFade(_ARG_0_.pageDataPL[_ARG_1_].handle, 1, 0, 30)
  Entity.EnableLockon(_ARG_0_.pageDataPL[_ARG_1_].handle, 0)
  Entity.EnableShooton(_ARG_0_.pageDataPL[_ARG_1_].handle, 0)
  Entity.EnableBodyColl(_ARG_0_.pageDataPL[_ARG_1_].handle, 0)
  Entity.EnableDamageColl(_ARG_0_.pageDataPL[_ARG_1_].handle, 0)
end
function b01vs00.createPLPage(_ARG_0_)
  for _FORV_4_ = 0, _UPVALUE0_ do
    Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
    _ARG_0_.rot:set(0, 0, 0)
    print("areaid = " .. Script.GetCurrentArea() .. "\n")
    if Script.GetCurrentArea() == 13 then
    else
    end
    _UPVALUE1_:set(_UPVALUE2_[0].x, _UPVALUE2_[0].y, _UPVALUE2_[0].z)
    _ARG_0_.pageDataPL[_FORV_4_].handle = Entity.CreateEntity("b03vs00", _UPVALUE1_, _ARG_0_.rot, _ARG_0_.myHandle)
    Entity.SetupModelFade(_ARG_0_.pageDataPL[_FORV_4_].handle, 1, 0, 1)
    Entity.EnableLockon(_ARG_0_.pageDataPL[_FORV_4_].handle, 0)
    _ARG_0_.pageDataPL[_FORV_4_].Index = _FORV_4_
    _ARG_0_.pageDataPL[_FORV_4_].MobFlag = 0
    Entity.EnableModelDisp(_ARG_0_.pageDataPL[_FORV_4_].handle, 0, 0)
    Entity.EnableModelDisp(_ARG_0_.pageDataPL[_FORV_4_].handle, 1, 0)
    Entity.EnableModelDisp(_ARG_0_.pageDataPL[_FORV_4_].handle, 2, 0)
    Entity.EnableModelDisp(_ARG_0_.pageDataPL[_FORV_4_].handle, 3, 0)
    EntityManager:GetEntity(_ARG_0_.pageDataPL[_FORV_4_].handle).index = _FORV_4_
  end
end
function b01vs00.initPLPage(_ARG_0_)
  for _FORV_4_ = 0, _UPVALUE0_ do
    print("areaid = " .. Script.GetCurrentArea() .. "\n")
    if Script.GetCurrentArea() == 13 then
    else
    end
    _UPVALUE1_:set(_UPVALUE2_[0].x, _UPVALUE2_[0].y, _UPVALUE2_[0].z)
    _ARG_0_.targetPos:set(0, 0.2, 0)
    _ARG_0_.targetPos:setx(_UPVALUE2_[0].x + (10 * Script.Random() + 2) * Math.Cos((RoundPI(Script.Random() * 2 * PI))))
    _ARG_0_.targetPos:setz(_UPVALUE2_[0].z + (10 * Script.Random() + 2) * Math.Sin((RoundPI(Script.Random() * 2 * PI))))
    Collision.IntersectRayBg(_ARG_0_.targetPos, COLL_KIND_ENEMY, _UPVALUE1_, _ARG_0_.targetPos)
    Entity.SetLocalPos(_ARG_0_.pageDataPL[_FORV_4_].handle, _ARG_0_.targetPos)
    _ARG_0_.pageDataPL[_FORV_4_].Index = _FORV_4_
    _ARG_0_.pageDataPL[_FORV_4_].MobFlag = 0
    Entity.EnableModelDisp(_ARG_0_.pageDataPL[_FORV_4_].handle, 0, 0)
    Entity.EnableModelDisp(_ARG_0_.pageDataPL[_FORV_4_].handle, 1, 0)
    Entity.EnableModelDisp(_ARG_0_.pageDataPL[_FORV_4_].handle, 2, 0)
    Entity.EnableModelDisp(_ARG_0_.pageDataPL[_FORV_4_].handle, 3, 0)
    EntityManager:GetEntity(_ARG_0_.pageDataPL[_FORV_4_].handle):GotoStateSub("Waiting")
  end
end
function b01vs00.allPLPageStateIdling(_ARG_0_)
  for _FORV_4_ = 0, _UPVALUE0_ do
    EntityManager:GetEntity(_ARG_0_.pageDataPL[_FORV_4_].handle):GotoStateSub("Idling")
  end
end
function b01vs00.pagePLModelDisp(_ARG_0_)
  print("targetname = " .. Entity.GetName(_ARG_0_.meaHandle) .. "\n")
  for _FORV_5_ = 0, _UPVALUE0_ do
    Entity.EnableModelDisp(_ARG_0_.pageDataPL[_FORV_5_].handle, 0, 0)
    Entity.EnableModelDisp(_ARG_0_.pageDataPL[_FORV_5_].handle, 1, 0)
    Entity.EnableModelDisp(_ARG_0_.pageDataPL[_FORV_5_].handle, 2, 0)
    Entity.EnableModelDisp(_ARG_0_.pageDataPL[_FORV_5_].handle, 3, 0)
    if Entity.GetName(_ARG_0_.meaHandle) == "p11ex00" then
      Entity.EnableModelDisp(_ARG_0_.pageDataPL[_FORV_5_].handle, 1, 1)
    elseif Entity.GetName(_ARG_0_.meaHandle) == "p13ex00" then
      Entity.EnableModelDisp(_ARG_0_.pageDataPL[_FORV_5_].handle, 3, 1)
    elseif Entity.GetName(_ARG_0_.meaHandle) == "p12ex00" then
      Entity.EnableModelDisp(_ARG_0_.pageDataPL[_FORV_5_].handle, 2, 1)
    end
    if Entity.GetName(_ARG_0_.meaHandle) == "p11ex00" then
      _ARG_0_.copyNmae = "b62ex00"
    elseif Entity.GetName(_ARG_0_.meaHandle) == "p13ex00" then
      _ARG_0_.copyNmae = "b72ex00"
    elseif Entity.GetName(_ARG_0_.meaHandle) == "p12ex00" then
      _ARG_0_.copyNmae = "b82ex00"
    end
  end
end
function b01vs00.CreateShockwave(_ARG_0_, _ARG_1_)
  _ARG_0_.workVec:set(0, 0, 2)
  Entity.GetWorldPos2(_ARG_0_.workVec, _ARG_0_.myHandle, _ARG_0_.workVec)
  _ARG_0_.workVec:sety(0)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  Bullet.SetCollision(Bullet.CreateBullet("waveb", _ARG_0_.workVec, _ARG_0_.rot, _ARG_0_.myHandle), COLL_KIND_ENEMY, COLL_SHAPE_CYLINDER, 1, 1, _ARG_0_.myHandle)
  Bullet.SetAttackParam(Bullet.CreateBullet("waveb", _ARG_0_.workVec, _ARG_0_.rot, _ARG_0_.myHandle), Enemy.GetAttackKind(_ARG_0_.myHandle, 0), Enemy.GetAttackAttr(_ARG_0_.myHandle, 0), Enemy.GetAttackPoint(_ARG_0_.myHandle, 0), Enemy.GetAttackPowerCorrection(_ARG_0_.myHandle, 0))
  Bullet.SetAttacker(Bullet.CreateBullet("waveb", _ARG_0_.workVec, _ARG_0_.rot, _ARG_0_.myHandle), _ARG_0_.myHandle)
  if _ARG_1_ == 0 then
    Bullet.SetAddCollRadius(Bullet.CreateBullet("waveb", _ARG_0_.workVec, _ARG_0_.rot, _ARG_0_.myHandle), 0.12)
  elseif _ARG_1_ == 1 then
    Bullet.SetAddCollRadius(Bullet.CreateBullet("waveb", _ARG_0_.workVec, _ARG_0_.rot, _ARG_0_.myHandle), 0.2)
  else
    Bullet.SetAddCollRadius(Bullet.CreateBullet("waveb", _ARG_0_.workVec, _ARG_0_.rot, _ARG_0_.myHandle), 0.28)
  end
  EntityManager:GetEntity((Bullet.CreateBullet("waveb", _ARG_0_.workVec, _ARG_0_.rot, _ARG_0_.myHandle))).changeTime = _ARG_1_
end
function b01vs00.createEffect(_ARG_0_, _ARG_1_, _ARG_2_)
  Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
  Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
  Entity.SetEffect(_ARG_0_.myHandle, _ARG_1_, _ARG_2_, _UPVALUE0_, _UPVALUE1_)
end
function b01vs00.createEffectDleteCopyPL(_ARG_0_, _ARG_1_, _ARG_2_)
  Entity.GetWorldPos(_ARG_0_.pcEnemy[0].pos, _ARG_0_.pcEnemy[0].handle)
  Entity.GetRot(_ARG_0_.pcEnemy[0].rot, _ARG_0_.pcEnemy[0].handle)
  Entity.SetEffect(_ARG_0_.myHandle, _ARG_1_, _ARG_2_, _UPVALUE0_, _UPVALUE1_)
end
function b01vs00.Advancement(_ARG_0_, _ARG_1_)
  _ARG_0_.Speed = _ARG_0_.Speed + _ARG_1_ * 0.1 / 2 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_1_ < _ARG_0_.Speed then
    _ARG_0_.Speed = _ARG_1_
  end
  FVECTOR3.set(_ARG_0_.workVec, 0, 0, _ARG_0_.Speed)
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.workVec)
end
function b01vs00.Retreat(_ARG_0_, _ARG_1_)
  _ARG_0_.Speed = _ARG_0_.Speed + _ARG_1_ * 0.1 / 2 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_1_ < _ARG_0_.Speed then
    _ARG_0_.Speed = _ARG_1_
  end
  FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, -_ARG_0_.Speed)
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function b01vs00.AdvancementEx(_ARG_0_, _ARG_1_)
  _ARG_0_.Speed = _ARG_0_.Speed + _ARG_1_ * 0.1 / 2 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_1_ < _ARG_0_.Speed then
    _ARG_0_.Speed = _ARG_1_
  end
  FVECTOR3.set(_ARG_0_.workVec, 0, 0, _ARG_0_.Speed)
  Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.workVec)
end
function b01vs00.changeLaserState(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  EntityManager:GetEntity(_ARG_0_.pageData[_ARG_2_].handle).effId = _ARG_3_
  EntityManager:GetEntity(_ARG_0_.pageData[_ARG_2_].handle):GotoStateSub(_ARG_1_)
  if _ARG_1_ == "Idling" then
    if Entity.IsAlive(_ARG_0_.pageData[_ARG_2_].effecthandle) then
    elseif _ARG_0_.pageData[_ARG_2_].Type == 0 then
      _ARG_0_.pageData[_ARG_2_].effecthandle = Entity.AttachEffect(_ARG_0_.pageData[_ARG_2_].handle, "b01vs00", "B022_MGG_CAL0_0", "center")
    else
      _ARG_0_.pageData[_ARG_2_].effecthandle = Entity.AttachEffect(_ARG_0_.pageData[_ARG_2_].handle, "b01vs00", "B022_MGG_CAL1_0", "center")
    end
  elseif _ARG_1_ == "Shoot" then
    Effect.LoopEnd(_ARG_0_.pageData[_ARG_2_].effecthandle)
  end
end
function b01vs00.controlBody(_ARG_0_, _ARG_1_)
  Entity.EnableModelDisp(_ARG_0_.myHandle, 0, _ARG_1_)
end
function b01vs00.checkAttackCnt(_ARG_0_, _ARG_1_)
end
function b01vs00.pageAliveChake(_ARG_0_)
  for _FORV_4_ = 0, _UPVALUE0_ do
    if _ARG_0_.pageDataPL[_FORV_4_].MobFlag == 0 then
      return 1
    end
  end
  return _FOR_
end
function b01vs00.PLEnemyAliveChakeAll(_ARG_0_)
  for _FORV_4_ = 0, 1 do
    if Entity.IsAlive(_ARG_0_.pcEnemy[_FORV_4_].handle) then
      return 1
    end
  end
  return _FOR_
end
function b01vs00.PLEnemyAliveChake(_ARG_0_)
  for _FORV_4_ = 0, 1 do
    if Entity.IsAlive(_ARG_0_.pcEnemy[_FORV_4_].handle) == false then
      return 1
    end
  end
  return _FOR_
end
function b01vs00.Imit2Summons_Fast(_ARG_0_)
  for _FORV_5_ = 0, _UPVALUE0_ do
    if _ARG_0_.pageDataPL[_FORV_5_].MobFlag == 0 then
      _ARG_0_.pageDataPL[_FORV_5_].MobFlag = 1
      if 0 >= 1 then
        return
      end
      Entity.GetWorldPos(_ARG_0_.workVec, _ARG_0_.pageDataPL[_FORV_5_].Handle)
      Entity.GetRot(_ARG_0_.rot, _ARG_0_.pageDataPL[_FORV_5_].handle)
      if Entity.GetName(_ARG_0_.meaHandle) == "p11ex00" then
        _ARG_0_.copyNmae = "b62ex00"
      elseif Entity.GetName(_ARG_0_.meaHandle) == "p13ex00" then
        _ARG_0_.copyNmae = "b72ex00"
      elseif Entity.GetName(_ARG_0_.meaHandle) == "p12ex00" then
        _ARG_0_.copyNmae = "b82ex00"
      end
      _ARG_0_.pcEnemy[0].handle = Entity.CreateEntity(_ARG_0_.copyNmae, _ARG_0_.workVec, _ARG_0_.rot)
      SetOriginalHandle(_ARG_0_.pcEnemy[0].handle, _ARG_0_.meaHandle)
      CreateGauge(_ARG_0_.pcEnemy[0].handle)
    end
  end
end
function b01vs00.Imit2Summons_Second(_ARG_0_)
  for _FORV_4_ = 0, _UPVALUE0_ do
    if _ARG_0_.pageDataPL[_FORV_4_].MobFlag == 0 then
      _ARG_0_.pageDataPL[_FORV_4_].MobFlag = 1
      for _FORV_8_ = 0, 1 do
        if Entity.IsAlive(_ARG_0_.pcEnemy[_FORV_8_].handle) == false then
          Entity.GetWorldPos(_ARG_0_.workVec, _ARG_0_.pageDataPL[_FORV_4_].handle)
          Entity.GetRot(_ARG_0_.rot, _ARG_0_.pageDataPL[_FORV_4_].handle)
          if Entity.GetName(_ARG_0_.meaHandle) == "p11ex00" then
            _ARG_0_.copyNmae = "b62ex00"
          elseif Entity.GetName(_ARG_0_.meaHandle) == "p13ex00" then
            _ARG_0_.copyNmae = "b72ex00"
          elseif Entity.GetName(_ARG_0_.meaHandle) == "p12ex00" then
            _ARG_0_.copyNmae = "b82ex00"
          end
          _ARG_0_.pcEnemy[_FORV_8_].handle = Entity.CreateEntity(_ARG_0_.copyNmae, _ARG_0_.workVec, _ARG_0_.rot)
          SetOriginalHandle(_ARG_0_.pcEnemy[_FORV_8_].handle, _ARG_0_.meaHandle)
          CreateGauge(_ARG_0_.pcEnemy[_FORV_8_].handle)
          _ARG_0_:fadeOutPLPage(_FORV_4_)
          _ARG_0_.summonCopyPCID = _FORV_8_
          print(Entity.GetName(_ARG_0_.pcEnemy[_ARG_0_.summonCopyPCID].handle) .. ":: Imit2Summons_Second\n")
          Entity.EnableDamageColl(_ARG_0_.pcEnemy[_ARG_0_.summonCopyPCID].handle, 0)
          Enemy.SetNoNetworkHpCheck(_ARG_0_.pcEnemy[_ARG_0_.summonCopyPCID].handle, 1)
          return 1
        end
      end
    end
  end
end
function b01vs00.OnSummonEnemyDamageColl(_ARG_0_)
  Enemy.SetNoNetworkHpCheck(_ARG_0_.pcEnemy[_ARG_0_.summonCopyPCID].handle, 0)
  Entity.EnableDamageColl(_ARG_0_.pcEnemy[_ARG_0_.summonCopyPCID].handle, 1)
end
function b01vs00.RestHpRate(_ARG_0_)
  return Enemy.GetHp(_ARG_0_.myHandle) / Enemy.GetHpMax(_ARG_0_.myHandle)
end
function b01vs00.InhaleForPlayer(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_)
  for _FORV_12_, _FORV_13_ in pairs(EntityManager.entities) do
    if (Entity.GetName(_FORV_12_) == "m91ex00" or Entity.GetName(_FORV_12_) == "m92ex00" or Entity.GetName(_FORV_12_) == "m93ex00" or Entity.GetName(_FORV_12_) == "m94ex00" or Entity.GetName(_FORV_12_) == "m95ex00") and Player.GetNetworkID(Entity.GetParent(_FORV_12_)) == 0 and Enemy.IsIllusionGroundIn(_FORV_12_) == false then
      break
    end
  end
  if _FORV_12_ == NULL_HANDLE then
    if Player.IsMuteki(_ARG_1_) then
      _UPVALUE0_:set(0, 0, 0)
      Entity.SetForce(_ARG_1_, _UPVALUE0_)
      return false
    end
  else
    if Entity.GetParent(_FORV_12_) ~= _ARG_0_.targetHandle then
      return false
    end
    _ARG_1_ = _FORV_12_
  end
  Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 3)
  if Entity.CalcDistanceSq(_ARG_1_, _UPVALUE0_) <= Entity.CalcDistanceSq(_ARG_1_, _UPVALUE0_) then
    Entity.GetWorldPos(_UPVALUE1_, _ARG_1_)
    _UPVALUE2_:set(0, 0, 1)
    Entity.ApplyBoneMatrix33(_ARG_0_.myHandle, _ARG_5_, _UPVALUE2_)
    FVECTOR3.Sub(_UPVALUE3_, _UPVALUE1_, _UPVALUE0_)
    _UPVALUE3_:normalize()
    if _UPVALUE3_:dot(_UPVALUE2_) >= Math.Cos(DegToRad(_ARG_3_)) then
      Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.myHandle, 3)
      FVECTOR3.Sub(_UPVALUE0_, _UPVALUE0_, _UPVALUE1_)
      _UPVALUE0_:sety(0)
      _UPVALUE0_:normalize()
      _UPVALUE0_:scale(Entity.GetFrameRate(_ARG_0_.myHandle) * _ARG_4_)
      Entity.SetForce(_ARG_1_, _UPVALUE0_)
      return true
    end
  end
  return false
end
function b01vs00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.targetHandle = NULL_HANDLE
  _ARG_0_.meaHandle = NULL_HANDLE
  _ARG_0_.Speed = 0
  _ARG_0_.SinTimer = 0
  _ARG_0_.angle = 0
  _ARG_0_.WorkTime = 0
  _ARG_0_.Anglx = 0
  _ARG_0_.Angly = 0
  _ARG_0_.oldAnglx = 0
  _ARG_0_.oldAngly = 0
  _ARG_0_.SinCurve_Power = 0
  _ARG_0_.CosCurve_Power = 0
  _ARG_0_.SinCurve_PowerNow = 0
  _ARG_0_.CosCurve_PowerNow = 0
  _ARG_0_.targetY = 0
  _ARG_0_.SinTimer = 0
  _ARG_0_.CosTimer = 0
  _ARG_0_.count = 0
  _ARG_0_.rotationCnt = 0
  _ARG_0_.rotationTime = 0
  _ARG_0_.AttackFlag = 0
  _ARG_0_.buruburuCnt = 0
  _ARG_0_.ImitCnt = 0
  _ARG_0_.escapeHitCnt = 0
  _ARG_0_.ImitNum = 0
  _ARG_0_.Attack1Cnt = 0
  _ARG_0_.Attack2Flag = 0
  _ARG_0_.MagicGyroFlag = 0
  _ARG_0_.roadFlag = 0
  _ARG_0_.createChara = 0
  _ARG_0_.copyNmae = 0
  _ARG_0_.noEndTime = 0
  _ARG_0_.createCopyFlag = 0
  _ARG_0_.summonCopyPCID = 0
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
  _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec0 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
  _ARG_0_.NoReactionDamage = 0
  _ARG_0_.pcEnemy = {}
  _ARG_0_.pcEnemy[0] = {
    handle = NULL_HANDLE,
    Groundflag = 0,
    pos = FVECTOR3.new(0, 0, 0),
    rot = FVECTOR3.new(0, 0, 0)
  }
  _ARG_0_.pcEnemy[1] = {
    handle = NULL_HANDLE,
    Groundflag = 0,
    pos = FVECTOR3.new(0, 0, 0),
    rot = FVECTOR3.new(0, 0, 0)
  }
  _ARG_0_.pcEnemy[2] = {
    handle = NULL_HANDLE,
    Groundflag = 0,
    pos = FVECTOR3.new(0, 0, 0),
    rot = FVECTOR3.new(0, 0, 0)
  }
  _ARG_0_.pageData = {}
  for _FORV_5_ = 0, 10 do
    _ARG_0_.pageData[_FORV_5_] = {
      handle = NULL_HANDLE,
      effecthandle = NULL_HANDLE,
      Index = 0,
      Angle = 0,
      Type = 0,
      AttackFlag = 0,
      AttackDelay = 0,
      MotRandFlag = 0
    }
  end
  _FOR_(_FOR_)
  _ARG_0_.pageDataPL = {}
  for _FORV_5_ = 0, _UPVALUE0_ do
    _ARG_0_.pageDataPL[_FORV_5_] = {
      handle = NULL_HANDLE,
      Index = 0,
      PLID = 0,
      MobFlag = 0
    }
  end
  _FOR_(_FOR_)
  _ARG_0_.stack = Stack:Create()
  _ARG_0_.cameraPos = FVECTOR3.new(0, 0, 0)
  if _UPVALUE1_ == false then
    if Script.GetCurrentArea() == 13 then
      Enemy.InitHP(_ARG_0_.myHandle, Enemy.GetHpMax(_ARG_0_.myHandle) * Enemy.GetExtraParam(_ARG_1_, "EachAreaHP"))
    end
    _UPVALUE1_ = true
  end
  Entity.SetMovementCollRadius(_ARG_0_.myHandle, 2)
  Entity.SetLowerHalf(_ARG_0_.myHandle, 2.2)
  Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
  Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
  Entity.EnableLockon(_ARG_0_.myHandle, 0)
  Entity.EnableGravity(_ARG_0_.myHandle, 1)
  Entity.SetDropShadowDistance(_ARG_0_.myHandle, 80)
  Player.SetBossCamera("b01vs00")
  Enemy.IsAllEnemyWaiting()
  if Enemy.IsAllEnemyWaiting() == true then
    _ARG_0_:GotoStateSub("Standby")
  else
    _ARG_0_:GotoState("Appear")
    Entity.EnableLockon(_ARG_0_.myHandle, 1)
  end
end
function b01vs00.OnDamage(_ARG_0_, _ARG_1_)
  _ARG_0_.escapeHitCnt = _ARG_0_.escapeHitCnt + 1
  if _ARG_0_.NoReactionDamage == 1 then
    return 1
  end
  if _ARG_1_ == ATK_KIND_DMG_BLOW or _ARG_1_ == ATK_KIND_DMG_TOSS then
    _ARG_0_.NoReactionDamage = 1
    _ARG_0_.stack:clear()
    _ARG_0_.stack:push("Search")
    _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
  end
  if _ARG_0_.escapeHitCnt > _UPVALUE0_ then
    _ARG_0_.escapeHitCnt = 0
    _ARG_0_.stack:clear()
    _ARG_0_.stack:push("Search")
    _ARG_0_.stack:push("Escape")
    _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
    return 1
  end
  return 1
end
function b01vs00.OnReturnDamage(_ARG_0_)
  if _ARG_0_.NoReactionDamage == 1 then
    return
  end
  if _ARG_0_.escapeHitCnt > _UPVALUE0_ then
    _ARG_0_.escapeHitCnt = 0
    _ARG_0_.stack:clear()
    _ARG_0_.stack:push("Search")
    _ARG_0_.stack:push("Escape")
    _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
    return 1
  else
    _ARG_0_:GotoState("Idling")
  end
end
function b01vs00.OnHitAttack(_ARG_0_, _ARG_1_)
  _ARG_0_.AttackFlag = 1
end
function b01vs00.setPlDrop(_ARG_0_)
  Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
  _ARG_0_.workVec1:set(0, 0, 1)
  Entity.GetWorldPos2(_ARG_0_.workVec1, _ARG_0_.myHandle, _ARG_0_.workVec1, 1)
  Entity.SetOldLocalPos(_ARG_0_.meaHandle, _ARG_0_.workVec1)
  Entity.SetLocalPos(_ARG_0_.meaHandle, _ARG_0_.workVec1)
  _ARG_0_.workVec0:set(1, 1, 1)
  Entity.SetScale(_ARG_0_.meaHandle, _ARG_0_.workVec0)
  Entity.AttachCoord(NULL_HANDLE, "", _ARG_0_.meaHandle, "Root")
end
function b01vs00.OnDead(_ARG_0_)
  _ARG_0_:GotoStateSub("Dead")
  SetupBossDead(_ARG_0_.myHandle)
  return 1
end
function b01vs00.Debug(_ARG_0_)
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
function b01vs00.OnUpdate(_ARG_0_)
  _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
  _ARG_0_:Update()
  _ARG_0_:Debug()
end
EntityFactory:Add("b01vs00", function(_ARG_0_)
  return (b01vs00:new())
end)
b02vs00 = {}
b02vs00_base_mt = {__index = __StateMachine}
setmetatable(b02vs00, b02vs00_base_mt)
b02vs00_mt = {__index = b02vs00}
function b02vs00.new(_ARG_0_)
  print("b02vs00:new()\n")
  return setmetatable(__StateMachine:new(), b02vs00_mt)
end
b02vs00.states = {
  Idling = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.step = _UPVALUE0_
      print("b02vs00:Idling\n")
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
    end
  },
  EndShoot = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.step = _UPVALUE0_
      print("b02vs00:EndShoot\n")
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
    end
  },
  Shoot = {
    OnBeginState = function(_ARG_0_)
      print("b02vs00:Shoot\n")
      _ARG_0_.step = _UPVALUE0_
      _ARG_0_.workVec0:set(0, 0, 0)
      _ARG_0_.rot:set(0, 0, 0)
      if _ARG_0_.effId == _UPVALUE1_ then
      else
      end
      _ARG_0_.LightHandle = Entity.AttachEffect(_ARG_0_.myHandle, "b01vs00", "B022_MGG_LSR1_0", "page", _ARG_0_.workVec0, _ARG_0_.rot)
      _ARG_0_.workVec1:set(0, 0, 10)
      Entity.GetWorldPos2(_ARG_0_.workVec1, _ARG_0_.myHandle, _ARG_0_.workVec1, 2)
      _ARG_0_.rot:set(0, 0, 0)
      Enemy.SetGeneralPurposeAttackColl(_ARG_0_.myHandle, COLL_KIND_ENEMY, COLL_SHAPE_CYLINDER, 0.3)
      if _ARG_0_.effId == _UPVALUE1_ then
      else
      end
      Enemy.SetGeneralPurposeAttackCollParam(_ARG_0_.myHandle, Enemy.GetAttackKind(Entity.GetParent(_ARG_0_.myHandle), 2), Enemy.GetAttackAttr(Entity.GetParent(_ARG_0_.myHandle), 2), Enemy.GetAttackPoint(Entity.GetParent(_ARG_0_.myHandle), 2), Enemy.GetAttackPowerCorrection(Entity.GetParent(_ARG_0_.myHandle), 2))
      Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 0)
      Enemy.SetGeneralPurposeAttackCollHitAttackEffectName(_ARG_0_.myHandle, "b01vs00", "B022_MGG_HIT1_0")
    end,
    OnEndState = function(_ARG_0_)
      Effect.LoopEnd(_ARG_0_.LightHandle)
      _ARG_0_.LightHandle = NULL_HANDLE
      Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 0)
    end,
    OnUpdate = function(_ARG_0_)
      if Effect.IsAlive(_ARG_0_.LightHandle) then
        Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.myHandle, 2)
        _ARG_0_.workVec1:set(0, 0, 10)
        Entity.GetWorldPos2(_ARG_0_.workVec1, _ARG_0_.myHandle, _ARG_0_.workVec1, 2)
        _ARG_0_.rot:set(0, 0, 0)
        Enemy.SetGeneralPurposeAttackCollPos(_ARG_0_.myHandle, _ARG_0_.workVec0, _ARG_0_.workVec1)
        FVECTOR3.Sub(_ARG_0_.workVec2, _ARG_0_.workVec1, _ARG_0_.workVec0)
        _ARG_0_.workVec3:set(1, 1, _ARG_0_.workVec2:length() / 10)
        Effect.SetScale(_ARG_0_.LightHandle, _ARG_0_.workVec3)
        Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 1)
        _ARG_0_.wait = _ARG_0_.wait - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if 0 > _ARG_0_.wait then
          Enemy.EnableGeneralPurposeUpdate(_ARG_0_.myHandle)
          _ARG_0_.wait = 120
        end
      end
    end
  }
}
function b02vs00.OnInit(_ARG_0_, _ARG_1_)
  print("\150\179\146n\131y\129[\131W\144\182\144\172\n")
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.LightHandle = 0
  _ARG_0_.wait = 0
  _ARG_0_.effId = 0
  _ARG_0_.targetHandle = NULL_HANDLE
  _ARG_0_.workVec0 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec2 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec3 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
  _ARG_0_:GotoState("Idling")
  Enemy.SetNoNetwork(_ARG_1_, 1)
  Entity.EnableBgColl(_ARG_1_, 0)
  Entity.EnableLockon(_ARG_1_, 0)
  Entity.EnableShooton(_ARG_1_, 0)
  Entity.EnableDamageColl(_ARG_1_, 0)
end
function b02vs00.OnUpdate(_ARG_0_)
  _ARG_0_:Update()
end
function b02vs00.GotoStateIndex(_ARG_0_, _ARG_1_)
end
EntityFactory:Add("b02vs00", function(_ARG_0_)
  return (b02vs00:new())
end)
b03vs00 = {}
b03vs00_base_mt = {__index = __StateMachine}
setmetatable(b03vs00, b03vs00_base_mt)
b03vs00_mt = {__index = b03vs00}
function b03vs00.new(_ARG_0_)
  print("b03vs00:new()\n")
  return setmetatable(__StateMachine:new(), b03vs00_mt)
end
b03vs00.states = {
  Idling = {
    OnBeginState = function(_ARG_0_)
      Enemy.SetNoNetwork(_ARG_0_.myHandle, 1)
      Enemy.CompleteRecoveryHp(_ARG_0_.myHandle)
      print("Idling\n")
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
    end
  },
  Waiting = {
    OnBeginState = function(_ARG_0_)
      Enemy.SetNoNetwork(_ARG_0_.myHandle, 0)
      print("Waiting\n")
      Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
      Enemy.CompleteRecoveryHp(_ARG_0_.myHandle)
      Entity.SetTimer(_ARG_0_.myHandle, 300)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 then
      end
    end
  },
  Disappear = {
    OnBeginState = function(_ARG_0_)
      print("Disappear\n")
      Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
      Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
      Entity.EnableLockon(_ARG_0_.myHandle, 0)
      Entity.EnableShooton(_ARG_0_.myHandle, 0)
      EntityManager:GetEntity((Entity.GetParent(_ARG_0_.myHandle))).pageDataPL[_ARG_0_.index].MobFlag = 1
      Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 20)
      Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
      _UPVALUE1_:set(0, 0, 0)
      Entity.SetEffect(_ARG_0_.myHandle, "b01vs00", "B022_IMI_SMK1_0", _UPVALUE0_, _UPVALUE1_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
    end
  }
}
function b03vs00.OnInit(_ARG_0_, _ARG_1_)
  print("\150\179\146n\131y\129[\131W\144\182\144\172\n")
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.positionstep = 0
  _ARG_0_.index = 0
  _ARG_0_.rotationY = Script.Random() * 360
  _ARG_0_.targetHandle = NULL_HANDLE
  Entity.SetMovementCollRadius(_ARG_0_.myHandle, 1)
  Entity.SetLowerHalf(_ARG_0_.myHandle, 1.5)
  Entity.EnableBgColl(_ARG_0_.myHandle, 1)
  Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
  Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
  Entity.EnableLockon(_ARG_1_, 0)
  Entity.EnableShooton(_ARG_1_, 0)
  _ARG_0_.pos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
  Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
  _ARG_0_:GotoStateSub("Idling")
end
function b03vs00.OnDead(_ARG_0_)
  print("b03vs00:OnDead()\n")
  _ARG_0_:GotoStateSub("Disappear")
  return 1
end
function b03vs00.OnUpdatePositionAfter(_ARG_0_)
  if _ARG_0_.positionstep == 0 then
    _ARG_0_.rot:set(0, 0, DegToRad(45))
    Entity.RotateBoneXYZ(_ARG_0_.myHandle, 2, _ARG_0_.rot)
    _ARG_0_.positionstep = 1
  elseif _ARG_0_.positionstep == 1 then
    _ARG_0_.rot:set(0, DegToRad(_ARG_0_.rotationY), 0)
    _ARG_0_.rotationY = _ARG_0_.rotationY + 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
    Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
  end
end
function b03vs00.OnUpdate(_ARG_0_)
  _ARG_0_:Update()
end
EntityFactory:Add("b03vs00", function(_ARG_0_)
  return (b03vs00:new())
end)
waveb = {}
waveb_mt = {__index = waveb}
function waveb.new(_ARG_0_)
  return setmetatable({}, waveb_mt)
end
function waveb.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.masterHandle = NULL_HANDLE
  _ARG_0_.step = 0
  Bullet.EnableNoCheckHitBg(_ARG_1_, 0)
  Bullet.SetHitAttackEffectName(_ARG_1_, "b01vs00", "B022_SLP_HIT0_0")
  _ARG_0_.Time = 0
  _ARG_0_.changeTime = 0
end
function waveb.OnUpdate(_ARG_0_)
  _ARG_0_.Time = _ARG_0_.Time + 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_0_.step == 0 then
    if _ARG_0_.Time >= 20 then
      Bullet.SetAddCollRadius(_ARG_0_.myHandle, 0)
      _ARG_0_.step = _ARG_0_.step + 1
    end
  elseif _ARG_0_.step == 1 and _ARG_0_.Time >= 45 then
    Bullet.EnableAttackCollision(_ARG_0_.myHandle, 0)
    _ARG_0_.step = _ARG_0_.step + 1
    if Entity.IsTimeOver(_ARG_0_.myHandle) then
      Bullet.DeleteBullet(_ARG_0_.myHandle)
    end
  end
end
EntityFactory:Add("waveb", function(_ARG_0_)
  return (waveb:new())
end)
