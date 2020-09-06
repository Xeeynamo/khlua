b01he00 = {}
b01he00_base_mt = {__index = __StateMachine}
setmetatable(b01he00, b01he00_base_mt)
b01he00_mt = {__index = b01he00}
function b01he00.new(_ARG_0_)
  return setmetatable(__StateMachine:new(), b01he00_mt)
end
b01he00.states = {
  Appear = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.IceTianHandle = Enemy.SearchEnemy(_ARG_0_.myHandle, "b10he00", SEARCH_TYPE_NEAR)
      SetupAppearBegin(_ARG_0_.myHandle, 1, _UPVALUE0_, 0)
    end,
    OnEndState = function(_ARG_0_)
      SetupAppearEnd(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
        _ARG_0_:FireControler(_UPVALUE0_)
      end
    end
  },
  Idling = {
    OnBeginState = function(_ARG_0_)
      Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_.AttackDelay - (_ARG_0_.SubDelay + Script.Random() * _UPVALUE0_))
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      _ARG_0_.IceTianHandle = Enemy.SearchEnemy(_ARG_0_.myHandle, "b10he00", SEARCH_TYPE_NEAR)
      _ARG_0_.ModeTyp = _UPVALUE2_
      _ARG_0_:FireControler(_ARG_0_.ModeTyp)
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_.SubDelay = 0
    end,
    OnUpdate = function(_ARG_0_)
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
      if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
        return
      end
      if _ARG_0_.AttackFlag == 0 then
        _ARG_0_:GotoState("Goes_away")
        return
      end
      if _ARG_0_:IsIcetitanAlive() == 1 and _ARG_0_:CheckHP() == 0 then
        _ARG_0_:GotoState("Goes_away")
      else
        _ARG_0_:GotoState("Move")
      end
    end
  },
  Goes_away = {
    OnBeginState = function(_ARG_0_)
      print("b01he00:Goes_away\n")
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
      Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.targetHandle)
      if 0 > _ARG_0_.WorkVec:getx() then
        if Script.Random() < 0.5 then
          _ARG_0_.watchingNum = 0
        else
          _ARG_0_.watchingNum = 1
        end
      elseif Script.Random() < 0.5 then
        _ARG_0_.watchingNum = 2
      else
        _ARG_0_.watchingNum = 3
      end
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        _ARG_0_.WorkVec:set(_UPVALUE0_[_ARG_0_.watchingNum].x, _UPVALUE0_[_ARG_0_.watchingNum].y, _UPVALUE0_[_ARG_0_.watchingNum].z)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 16)
        Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
        _ARG_0_.rot:sety(Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.WorkVec))
        _ARG_0_.WorkVec:set(0, 0, 1)
        Math.RotateVectorXYZ(_ARG_0_.WorkVec, _ARG_0_.rot)
        _ARG_0_.WorkVec:scale(_UPVALUE1_)
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.WorkVec)
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.WorkVec) < 1 then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
          _ARG_0_.step = 1
          Entity.ClearSpeed(_ARG_0_.myHandle)
        end
        if _ARG_0_:CheckHP() == 1 and _ARG_0_.AttackFlag == 1 then
          _ARG_0_:GotoState("Move")
        end
      elseif _ARG_0_.step == 1 then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 2)
        if Entity.IsAlive(_ARG_0_.IceTianHandle) == false or 0 >= Enemy.GetHp(_ARG_0_.IceTianHandle) then
          _ARG_0_.ModeType = _UPVALUE3_
          _ARG_0_.AttackFlag = 1
          _ARG_0_:GotoState("Move")
          return
        end
        if Entity.IsAlive(_ARG_0_.IceTianHandle) == false then
          _ARG_0_.AttackFlag = 1
        else
          EntityManager:GetEntity(_ARG_0_.IceTianHandle).AttackFlag = 1
        end
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 9 then
          _ARG_0_:GotoState("FingernailofFire")
        end
        if _ARG_0_:CheckHP() == 1 and _ARG_0_.AttackFlag == 1 then
          _ARG_0_:GotoState("Move")
        end
      end
    end
  },
  Move = {
    OnBeginState = function(_ARG_0_)
      print("b01he00:Move\n")
      if _ARG_0_.AttackFlag == 0 then
        Entity.SetTimer(_ARG_0_.myHandle, Script.Random() * _UPVALUE0_ + 30 + 1200)
      else
        Entity.SetTimer(_ARG_0_.myHandle, Script.Random() * _UPVALUE0_ + 30 - (Script.Random() * _UPVALUE1_ - _UPVALUE2_))
      end
      if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE3_ then
        if Script.Random() < 0.3 then
          _ARG_0_.step = _UPVALUE4_
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE5_)
        elseif Script.Random() < 0.6 then
          _ARG_0_.step = _UPVALUE4_
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE6_)
        else
          _ARG_0_.step = _UPVALUE7_
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE8_)
        end
      else
        _ARG_0_.step = _UPVALUE9_
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE10_)
      end
      _ARG_0_.wanderAng = 90
      if Script.Random() < 0.5 then
        _ARG_0_.wanderAng = 270
      end
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == _UPVALUE0_ then
        _ARG_0_.WorkVec:set(0, 0, _UPVALUE1_)
      elseif _ARG_0_.step == _UPVALUE2_ then
        _ARG_0_.WorkVec:set(0, 0, -_UPVALUE1_)
      elseif _ARG_0_.step == _UPVALUE3_ then
        _ARG_0_.WorkVec:set(_UPVALUE4_, 0, 0)
      elseif _ARG_0_.step == _UPVALUE5_ then
        _ARG_0_.WorkVec:set(-_UPVALUE4_, 0, 0)
      end
      if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.IceTianHandle) < 25 then
        print("\138\230\146\163\130\193\130\196\130\230\130\175\130\196\130\221\130\220\130\183\129B\n")
        if _ARG_0_:WhichRightandLeft() == 1 then
          _ARG_0_.wanderAng = -10
        else
          _ARG_0_.wanderAng = 10
        end
        Entity.GetRot(_ARG_0_.WorkVec1, _ARG_0_.myHandle)
        _ARG_0_.WorkVec:sety(_ARG_0_.WorkVec1:gety() + DegToRad(_ARG_0_.wanderAng))
        Entity.SetRot(_ARG_0_.WorkVec1, _ARG_0_.WorkVec)
      else
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
      end
      if _ARG_0_.AttackFlag == 0 then
        _ARG_0_:GotoState("Idling")
        return
      end
      Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
      if (Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 4) and _ARG_0_.AttackFlag == 1 then
        _ARG_0_:GotoState("Search")
      end
    end
  },
  Search = {
    OnBeginState = function(_ARG_0_)
      print("b01he00:Search\n")
      Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_.AttackDelay - (_ARG_0_.SubDelay + Script.Random() * _UPVALUE0_))
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      _ARG_0_.step = 0
      Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.myHandle)
      if Script.Random() < 0.5 then
        Sound.PlayVoice(116, 4, 1, _ARG_0_.WorkVec)
      else
        Sound.PlayVoice(116, 5, 1, _ARG_0_.WorkVec)
      end
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
      if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
        return
      end
      if _ARG_0_.AttackFlag == 0 then
        _ARG_0_:GotoState("Idling")
        return
      end
      if _ARG_0_:CheckPlayerEnshrining() == 1 then
        _ARG_0_:GotoState("MegaFire")
        return
      end
      if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE0_ then
        _ARG_0_:GotoState("FingernailofFire")
      elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE1_ then
        if _UPVALUE2_ > Script.Random() then
          if _ARG_0_.ModeType == _UPVALUE3_ then
            if Effect.IsAlive(_ARG_0_.FireEffectHandleRed) then
              _ARG_0_:GotoState("MegaFire")
            else
              _ARG_0_:GotoState("BladesCrossing")
            end
          else
            _ARG_0_:GotoState("Move")
          end
        else
          _ARG_0_:GotoState("MegaFire")
        end
      else
        _ARG_0_:GotoState("Move")
      end
    end
  },
  FingernailofFire = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.cnboNum = Script.Random() * (_UPVALUE1_ - 2) + 2
      _ARG_0_.step = 0
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > 2.25 then
        _ARG_0_.WorkVec:set(0, 0, _UPVALUE0_ / 6)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
      end
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
      if _ARG_0_.step == 0 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_.cnboNum = _ARG_0_.cnboNum - 1
        if 0 > _ARG_0_.cnboNum then
          if _ARG_0_:IsIcetitanAlive() == 1 and _ARG_0_:CheckHP() == 0 then
            _ARG_0_:GotoState("Goes_away")
          else
            _ARG_0_:GotoState("Move")
          end
          _ARG_0_.AttackDelay = Script.Random() * _UPVALUE1_
        else
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
        end
      else
      end
    end
  },
  NoRiaFingernailofFire = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.cnboNum = Script.Random() * (_UPVALUE1_ - 2) + 2
      _ARG_0_.step = 0
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
    end,
    OnEndState = function(_ARG_0_)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > 2.25 then
        _ARG_0_.WorkVec:set(0, 0, _UPVALUE0_ / 6)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
      end
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
      if _ARG_0_.step == 0 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_.cnboNum = _ARG_0_.cnboNum - 1
        if 0 > _ARG_0_.cnboNum then
          if _ARG_0_:IsIcetitanAlive() == 1 and _ARG_0_:CheckHP() == 0 then
            _ARG_0_:GotoState("Goes_away")
          else
            _ARG_0_:GotoState("Move")
          end
          _ARG_0_.AttackDelay = Script.Random() * _UPVALUE1_
        else
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
        end
      else
      end
    end
  },
  MegaFire = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
      _ARG_0_.shotFlag = 0
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10) == false then
          _ARG_0_.step = 1
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Move")
        end
      elseif _ARG_0_.step == 1 then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 30 and _ARG_0_.shotFlag == 0 then
          _ARG_0_.shotFlag = 1
          _ARG_0_:CreateShot(_ARG_0_.myHandle)
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Move")
          _ARG_0_.AttackDelay = Script.Random() * _UPVALUE0_
        end
      end
    end
  },
  BladesCrossing = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.RotY = 0
      if _ARG_0_:WhichRightandLeft() == 1 then
        _ARG_0_.step = 0
      else
        _ARG_0_.step = 2
      end
      _ARG_0_.ModeTyp = _UPVALUE2_
      _ARG_0_:FireControler(_ARG_0_.ModeTyp)
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_.ModeTyp = _UPVALUE0_
      _ARG_0_:FireControler(_ARG_0_.ModeTyp)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 or _ARG_0_.step == 2 then
        Entity.GetRot(_ARG_0_.workVec, _ARG_0_.myHandle)
        if _ARG_0_.step == 0 then
          _ARG_0_.workVec:sety(_ARG_0_.workVec:gety() + DegToRad(_UPVALUE0_) * Entity.GetFrameRate(_ARG_0_.myHandle))
          _ARG_0_.RotY = _ARG_0_.RotY + DegToRad(_UPVALUE0_) * Entity.GetFrameRate(_ARG_0_.myHandle)
        elseif _ARG_0_.step == 2 then
          _ARG_0_.workVec:sety(_ARG_0_.workVec:gety() - DegToRad(_UPVALUE0_) * Entity.GetFrameRate(_ARG_0_.myHandle))
          _ARG_0_.RotY = _ARG_0_.RotY - DegToRad(_UPVALUE0_) * Entity.GetFrameRate(_ARG_0_.myHandle)
        end
        Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.workVec)
        if (_ARG_0_.RotY > DegToRad(720) or _ARG_0_.RotY < DegToRad(-720)) and (Entity.IsTargetWithinFOV(_ARG_0_.myHandle, _ARG_0_.targetHandle, DegToRad(45)) == true or Entity.IsTimeOver(_ARG_0_.myHandle)) then
          _ARG_0_.step = 1
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
          Entity.ClearSpeed(_ARG_0_.myHandle)
          return
        end
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 90 then
          Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.targetHandle)
          Entity.GetWorldPos(_ARG_0_.WorkVec1, _ARG_0_.myHandle)
          Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
          FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.WorkVec, _ARG_0_.WorkVec1)
          FVECTOR3.normalize(_ARG_0_.workVec)
          _ARG_0_.rot:set(0, RoundPI((Math.Atan2(_ARG_0_.workVec:getx(), _ARG_0_.workVec:getz()))), 0)
          _ARG_0_.velocity:set(0, 0, 1)
          Math.RotateVectorXYZ(_ARG_0_.velocity, _ARG_0_.rot)
          _ARG_0_.velocity:scale(0.02)
          Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
          _ARG_0_.velocity:sety(0)
        end
      elseif _ARG_0_.step == 1 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 100 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Move")
          _ARG_0_.AttackDelay = Script.Random() * _UPVALUE2_
        end
      end
    end
  },
  Watching = {
    OnBeginState = function(_ARG_0_)
      print("b01he00:Watching\n")
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
      Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.targetHandle)
      if 0 > _ARG_0_.WorkVec:getx() then
        if Script.Random() < 0.5 then
          _ARG_0_.watchingNum = 0
        else
          _ARG_0_.watchingNum = 1
        end
      elseif Script.Random() < 0.5 then
        _ARG_0_.watchingNum = 2
      else
        _ARG_0_.watchingNum = 3
      end
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        _ARG_0_.WorkVec:set(_UPVALUE0_[_ARG_0_.watchingNum].x, _UPVALUE0_[_ARG_0_.watchingNum].y, _UPVALUE0_[_ARG_0_.watchingNum].z)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 2)
        Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
        _ARG_0_.rot:sety(Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.WorkVec))
        _ARG_0_.WorkVec:set(0, 0, 1)
        Math.RotateVectorXYZ(_ARG_0_.WorkVec, _ARG_0_.rot)
        _ARG_0_.WorkVec:scale(_UPVALUE1_)
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.WorkVec)
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.WorkVec) < 1 then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
          _ARG_0_.step = 1
          Entity.ClearSpeed(_ARG_0_.myHandle)
        end
        if _ARG_0_:CheckPlayerEnshrining() == 0 and _ARG_0_:CheckMyEnshrining() == 0 then
          _ARG_0_:GotoState("Idling")
          return
        end
      elseif _ARG_0_.step == 1 then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 2)
        if Entity.IsAlive(_ARG_0_.IceTianHandle) == false then
          _ARG_0_.AttackFlag = 1
        else
          EntityManager:GetEntity(_ARG_0_.IceTianHandle).AttackFlag = 1
        end
        if _ARG_0_:CheckPlayerEnshrining() == 0 then
          _ARG_0_:GotoState("Idling")
          return
        end
      end
    end
  },
  FailureAttack = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.cnboNum = 2
      _ARG_0_.step = 0
      if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.WorkVec) < _UPVALUE0_ then
        _ARG_0_.step = 0
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_, 8, 8)
      else
        _ARG_0_.step = 1
        _ARG_0_.shotFlag = 1
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_, 8, 8)
      end
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.WorkVec) > 2.25 then
          _ARG_0_.WorkVec:set(0, 0, _UPVALUE0_ / 6)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          if 0 >= _ARG_0_.cnboNum then
            _ARG_0_:GotoState("Move")
            _ARG_0_.AttackDelay = Script.Random() * _UPVALUE1_
          elseif _ARG_0_.cnboNum == 1 then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
          else
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_, 8, 8)
          end
          _ARG_0_.cnboNum = _ARG_0_.cnboNum - 1
        end
      elseif _ARG_0_.step == 1 then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 30 and _ARG_0_.shotFlag == 0 then
          _ARG_0_:CreateShot(_ARG_0_.myHandle)
          _ARG_0_.shotFlag = 1
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          if 0 >= _ARG_0_.cnboNum then
            _ARG_0_:GotoState("Move")
            _ARG_0_.AttackDelay = Script.Random() * _UPVALUE1_
          elseif _ARG_0_.cnboNum == 1 then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
            _ARG_0_.shotFlag = 0
          else
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_, 8, 8)
          end
          _ARG_0_.cnboNum = _ARG_0_.cnboNum - 1
        end
      elseif _ARG_0_.step == 2 then
      elseif _ARG_0_.step == 3 then
      end
    end
  },
  Freeze = {
    OnBeginState = function(_ARG_0_)
      if _ARG_0_.BsdHandle == NULL_HANDLE then
        _ARG_0_.BsdHandle = Entity.CreateBadStatusEffect(_ARG_0_.myHandle, BAD_STATUS_FREEZE)
      end
      Entity.ClearSpeed(_ARG_0_.myHandle)
      Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
      Entity.SetMotion(_ARG_0_.myHandle, Entity.GetCurrentMotion(_ARG_0_.myHandle), 8, 8, 0, 0)
      Entity.SetAnimNowFrame(_ARG_0_.myHandle, (Entity.GetMotionNowFrame(_ARG_0_.myHandle)))
      Entity.SetTimer(_ARG_0_.myHandle, FREEZE_TIME)
      Entity.SetMotionSpeed(_ARG_0_.myHandle, 0)
      Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.myHandle)
      if Script.Random() < 0.5 then
        Sound.PlayVoice(116, 18, 1, _ARG_0_.WorkVec)
      else
        Sound.PlayVoice(116, 19, 1, _ARG_0_.WorkVec)
      end
    end,
    OnEndState = function(_ARG_0_)
      if _ARG_0_.BsdHandle ~= 0 then
        Entity.LoopEndBSEffect(_ARG_0_.myHandle)
        _ARG_0_.BsdHandle = NULL_HANDLE
      end
      Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
        Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
        if _ARG_0_.BsdHandle ~= 0 then
          Entity.LoopEndBSEffect(_ARG_0_.myHandle)
          _ARG_0_.BsdHandle = NULL_HANDLE
        end
        _ARG_0_:GotoState("FailureAttack")
      end
    end
  },
  Faing = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, B10HE_MOTION_FAINT)
      Entity.EnableLockon(_ARG_0_.myHandle, 0)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
    end
  },
  StandbyArena = {
    OnBeginState = function(_ARG_0_)
      print("StandbyArena\n")
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 1)
      Script.StartFadeOut(10, false)
      _ARG_0_.IceTianHandle = Enemy.SearchEnemy(_ARG_0_.myHandle, "b60vs00", SEARCH_TYPE_NEAR)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.EnableLockon(_ARG_0_.myHandle, 1)
      print("StandbyArena OnEndState\n")
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Script.IsEndFadeOut() == true then
          Script.StartFadeIn(10, false)
          Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, 1)
          Entity.SetupModelFade(_ARG_0_.IceTianHandle, 0, 1, 1)
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 then
        if Script.IsEndFadeIn() == true and Enemy.IsAllEnemyWaiting() == false then
          Entity.SetTimer(_ARG_0_.myHandle, 20)
          _ARG_0_.step = 2
        end
      elseif _ARG_0_.step == 2 and Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
        Entity.EnableLockon(_ARG_0_.myHandle, 1)
      end
    end
  },
  Standby = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.timer = 325
      _ARG_0_.step = 0
      _ARG_0_:FireControler(_UPVALUE1_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.timer = _ARG_0_.timer - Script.GetVsyncFrameRate()
      if _ARG_0_.step == 0 and _ARG_0_.timer <= 0 then
        _ARG_0_.step = 1
        _ARG_0_:FireControler(_UPVALUE0_)
      end
      if Enemy.IsAllEnemyWaiting() == false then
        Sound.PlayVoice(116, 14, 1, _ARG_0_.WorkVec)
        _ARG_0_:GotoState("Idling")
        Entity.EnableLockon(_ARG_0_.myHandle, 1)
      end
    end
  },
  Standby2 = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.timer = 200
    end,
    OnEndState = function(_ARG_0_)
      Entity.EnableLockon(_ARG_0_.myHandle, 1)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.timer = _ARG_0_.timer - Script.GetVsyncFrameRate()
      if _ARG_0_.timer <= 0 then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Dead = {
    OnBeginState = function(_ARG_0_)
      print("Dead\n")
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 2)
      Entity.EnableLockon(_ARG_0_.myHandle, 0)
      Entity.EnableShooton(_ARG_0_.myHandle, 0)
      if Entity.GetName(_ARG_0_.myHandle) == "b01he00" then
        EntityManager:GetEntity(_ARG_0_.IceTianHandle).AttackFlag = 1
      end
      _ARG_0_.step = 0
      Entity.ClearSpeed(_ARG_0_.myHandle)
      if 0 < Enemy.GetHp(_ARG_0_.IceTianHandle) then
        _ARG_0_:PlayVoice(20)
        _ARG_0_.step = 1
      end
      _ARG_0_.timer = 60
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      if Entity.GetName(_ARG_0_.myHandle) == "b01he00" then
        EntityManager:GetEntity(_ARG_0_.IceTianHandle).AttackFlag = 1
        EntityManager:GetEntity(_ARG_0_.IceTianHandle).ModeType = 1
      end
      if _ARG_0_.step == 0 and Sound.IsInvalidateSeCall() == 1 then
        _ARG_0_.timer = _ARG_0_.timer - Script.GetVsyncFrameRate()
        if 0 >= _ARG_0_.timer then
          _ARG_0_:PlayVoice(20)
          print("\141\196\144\182\n")
          _ARG_0_.step = 1
        end
      end
    end
  },
  DeadArena = {
    OnBeginState = function(_ARG_0_)
      print("b80vs00:DeadArena\n")
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 2)
      Entity.EnableLockon(_ARG_0_.myHandle, 0)
      Entity.EnableShooton(_ARG_0_.myHandle, 0)
      Entity.EnableUserTarget(_ARG_0_.myHandle, 0)
      Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
      _ARG_0_.step = 0
      Entity.ClearSpeed(_ARG_0_.myHandle)
      if 0 < Enemy.GetHp(_ARG_0_.IceTianHandle) then
        _ARG_0_:PlayVoice(20)
        _ARG_0_.step = 1
      end
      _ARG_0_.timer = 60
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.IceTianHandle = Enemy.SearchEnemy(_ARG_0_.myHandle, "b60vs00", SEARCH_TYPE_NEAR)
      if Enemy.GetHp(_ARG_0_.IceTianHandle) <= 0 and Enemy.GetHp(_ARG_0_.myHandle) <= 0 and _ARG_0_.deadFlag == 0 then
        _ARG_0_.deadFlag = 1
        Effect.LoopEnd(_ARG_0_.FireEffectHandleRed)
        Effect.LoopEnd(_ARG_0_.FireEffectHandleBule)
        SetupBossDead(_ARG_0_.myHandle)
        return
      end
      if _ARG_0_.step == 0 and Sound.IsInvalidateSeCall() == 1 then
        _ARG_0_.timer = _ARG_0_.timer - Script.GetVsyncFrameRate()
        if 0 >= _ARG_0_.timer then
          _ARG_0_:PlayVoice(20)
          print("\141\196\144\182\n")
          _ARG_0_.step = 1
        end
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
}
function b01he00.WhichRightandLeft(_ARG_0_)
  Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.myHandle)
  Entity.GetWorldPos(_ARG_0_.WorkVec1, _ARG_0_.targetHandle)
  Entity.GetRot(_ARG_0_.workVec1, _ARG_0_.myHandle)
  FVECTOR3.Sub(_ARG_0_.WorkVec1, _ARG_0_.WorkVec, _ARG_0_.WorkVec1)
  FVECTOR3.normalize(_ARG_0_.WorkVec1)
  if RoundPI(Math.Atan2(_ARG_0_.WorkVec1:getx(), _ARG_0_.WorkVec1:getz()) - _ARG_0_.workVec1:gety()) < DegToRad(1) and RoundPI(Math.Atan2(_ARG_0_.WorkVec1:getx(), _ARG_0_.WorkVec1:getz()) - _ARG_0_.workVec1:gety()) > DegToRad(-1) then
    return 2
  end
  if RoundPI((Math.Atan2(_ARG_0_.WorkVec1:getx(), _ARG_0_.WorkVec1:getz()) - _ARG_0_.workVec1:gety()) * -1) < 0 then
    return 1
  else
    return 0
  end
end
function b01he00.SetingGuard(_ARG_0_)
  Entity.EnableGuard(_ARG_0_.myHandle, 1)
  Entity.EnableGuardPhysical(_ARG_0_.myHandle, 1)
  Entity.EnableGuardZero(_ARG_0_.myHandle, 1)
  Entity.EnableGuardFire(_ARG_0_.myHandle, 1)
  Entity.EnableGuardIce(_ARG_0_.myHandle, 1)
  Entity.EnableGuardThunder(_ARG_0_.myHandle, 1)
  Entity.SetGuardDir(_ARG_0_.myHandle, 360)
  Entity.EnableGuardSpecial(_ARG_0_.myHandle, 1)
end
function b01he00.EndGuard(_ARG_0_)
  Entity.EnableGuard(_ARG_0_.myHandle, 0)
  Entity.EnableGuardPhysical(_ARG_0_.myHandle, 0)
  Entity.EnableGuardZero(_ARG_0_.myHandle, 0)
  Entity.EnableGuardFire(_ARG_0_.myHandle, 0)
  Entity.EnableGuardIce(_ARG_0_.myHandle, 0)
  Entity.EnableGuardThunder(_ARG_0_.myHandle, 0)
  Entity.SetGuardDir(_ARG_0_.myHandle, 0)
  Entity.EnableGuardSpecial(_ARG_0_.myHandle, 0)
end
function b01he00.FireControler(_ARG_0_, _ARG_1_)
  if Effect.IsAlive(_ARG_0_.FireEffectHandleRed) or Effect.IsAlive(_ARG_0_.FireEffectHandleBule) then
    if _ARG_1_ == _UPVALUE0_ then
      if Effect.IsAlive(_ARG_0_.FireEffectHandleBule) then
        return
      end
      _ARG_0_.FireEffectHandleBule = Entity.AttachEffect(_ARG_0_.myHandle, "b01he01", "B100_HED_00_0", "atama")
      Effect.SetAttachColor(_ARG_0_.FireEffectHandleBule, true, _ARG_0_.myHandle)
      Effect.LoopEnd(_ARG_0_.FireEffectHandleRed)
    else
      if Effect.IsAlive(_ARG_0_.FireEffectHandleRed) then
        return
      end
      _ARG_0_.FireEffectHandleRed = Entity.AttachEffect(_ARG_0_.myHandle, "b01he01", "B100_HED_01_0", "atama")
      Effect.SetAttachColor(_ARG_0_.FireEffectHandleRed, true, _ARG_0_.myHandle)
      Effect.LoopEnd(_ARG_0_.FireEffectHandleBule)
    end
  elseif _ARG_1_ == _UPVALUE0_ then
    _ARG_0_.FireEffectHandleBule = Entity.AttachEffect(_ARG_0_.myHandle, "b01he01", "B100_HED_00_0", "atama")
    Effect.SetAttachColor(_ARG_0_.FireEffectHandleBule, true, _ARG_0_.myHandle)
    Effect.LoopEnd(_ARG_0_.FireEffectHandleRed)
  else
    _ARG_0_.FireEffectHandleRed = Entity.AttachEffect(_ARG_0_.myHandle, "b01he01", "B100_HED_01_0", "atama")
    Effect.SetAttachColor(_ARG_0_.FireEffectHandleRed, true, _ARG_0_.myHandle)
    Effect.LoopEnd(_ARG_0_.FireEffectHandleBule)
  end
  _ARG_0_:BodyControler(_ARG_1_)
end
function b01he00.AttackControl(_ARG_0_)
  if Entity.GetName(_ARG_0_.myHandle) == "b80vs00" then
    _ARG_0_.ModeType = _UPVALUE0_
    _ARG_0_.AttackFlag = 1
    return
  end
  if Enemy.GetHp(_ARG_0_.IceTianHandle) <= 0 and Enemy.GetHp(_ARG_0_.myHandle) <= 0 then
    if _ARG_0_.deadFlag == 0 then
      SetupBossDead(_ARG_0_.myHandle)
      _ARG_0_.deadFlag = 1
    end
    return
  end
  if _ARG_0_:CheckPlayerEnshrining() == 1 and _ARG_0_:GetState() ~= "Watching" and _ARG_0_:GetState() ~= "Dead" and _ARG_0_:GetState() ~= "Freeze" and _ARG_0_:GetState() ~= "BladesCrossing" and _ARG_0_:GetState() ~= "MegaFire" and _ARG_0_:GetState() ~= "FingernailofFire" or _ARG_0_:CheckMyEnshrining() == 1 and _ARG_0_:GetState() ~= "Watching" and _ARG_0_:GetState() ~= "Dead" and _ARG_0_:GetState() ~= "Freeze" and _ARG_0_:GetState() ~= "BladesCrossing" and _ARG_0_:GetState() ~= "MegaFire" and _ARG_0_:GetState() ~= "FingernailofFire" then
    _ARG_0_:GotoState("Watching")
    return
  end
  _ARG_0_.ControTime = _ARG_0_.ControTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if Entity.IsAlive(_ARG_0_.IceTianHandle) == false or Enemy.GetHp(_ARG_0_.IceTianHandle) <= 0 then
    _ARG_0_.ModeType = _UPVALUE0_
    _ARG_0_.AttackFlag = 1
    return
  elseif _ARG_0_:CheckHP() == 1 then
    _ARG_0_.ModeType = _UPVALUE0_
  else
    _ARG_0_.ModeType = _UPVALUE1_
  end
  if 0 > _ARG_0_.ControTime and _ARG_0_:GetState() ~= "Dead" then
    if Script.Random() < 0.3 then
      if _ARG_0_.AttackFlag == 0 and EntityManager:GetEntity(_ARG_0_.IceTianHandle).AttackFlag == 1 then
        Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.myHandle)
        if Script.Random() < 0.5 then
          Sound.PlayVoice(116, 16, 1, _ARG_0_.WorkVec)
        else
          Sound.PlayVoice(116, 17, 1, _ARG_0_.WorkVec)
        end
      end
      _ARG_0_.AttackFlag = 1
      EntityManager:GetEntity(_ARG_0_.IceTianHandle).AttackFlag = 0
    elseif Script.Random() < 0.6 then
      _ARG_0_.AttackFlag = 0
      EntityManager:GetEntity(_ARG_0_.IceTianHandle).AttackFlag = 1
      if _ARG_0_.AttackFlag == 1 and EntityManager:GetEntity(_ARG_0_.IceTianHandle).AttackFlag == 0 then
        Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.myHandle)
        Sound.PlayVoice(116, 15, 1, _ARG_0_.WorkVec)
      end
    elseif 1 > Script.Random() then
      _ARG_0_.AttackFlag = 1
      EntityManager:GetEntity(_ARG_0_.IceTianHandle).AttackFlag = 1
    end
    print("\141U\140\130\144\167\140\228==================================\n")
    print("\131A\131C\131X\131^\131C\131^\131\147 AttackFlag = " .. EntityManager:GetEntity(_ARG_0_.IceTianHandle).AttackFlag .. "\n")
    print("\131n\131f\131X         AttackFlag = " .. _ARG_0_.AttackFlag .. "\n")
    _ARG_0_.ControTime = 720 + Script.Random() * 180
    print("the next change time = " .. _ARG_0_.ControTime .. "\n")
  else
  end
end
function b01he00.IsIcetitanAlive(_ARG_0_)
  if Entity.IsAlive(_ARG_0_.IceTianHandle) == true and Enemy.GetHp(_ARG_0_.IceTianHandle) > 0 then
    return 1
  end
  return 0
end
function b01he00.CheckPlayerEnshrining(_ARG_0_)
  Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.targetHandle)
  if _ARG_0_.WorkVec:gety() > 1.1 then
    if _ARG_0_.WorkVec:gety() > 3 then
      return 1
    end
    if Entity.IsGround(_ARG_0_.targetHandle) then
      return 1
    end
  end
  return 0
end
function b01he00.WhichRightandLeft(_ARG_0_)
  Entity.GetWorldPos(_ARG_0_.workVec1, _ARG_0_.IceTianHandle)
  Entity.GetWorldPos(_ARG_0_.workVec, _ARG_0_.myHandle)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.workVec1, _ARG_0_.workVec)
  FVECTOR3.normalize(_ARG_0_.workVec)
  if RoundPI((Math.Atan2(_ARG_0_.workVec:getx(), _ARG_0_.workVec:getz()) - _ARG_0_.rot:gety()) * -1) < 0 then
    return 1
  else
    return 0
  end
end
function b01he00.CheckMyEnshrining(_ARG_0_)
  Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.myHandle)
  if _ARG_0_.WorkVec:gety() > 0.1 then
    if _ARG_0_.WorkVec:gety() > 3 then
      return 1
    end
    if Entity.IsGround(_ARG_0_.myHandle) then
      return 1
    end
  end
  return 0
end
function b01he00.CheckHP(_ARG_0_)
  if Enemy.GetHp(_ARG_0_.myHandle) < Enemy.GetHpMax(_ARG_0_.myHandle) * _UPVALUE0_ then
    return 1
  end
  return 0
end
function b01he00.BodyControler(_ARG_0_, _ARG_1_)
  if _ARG_0_.CollarFlag == _UPVALUE0_ then
    if _ARG_1_ == _UPVALUE0_ then
      return
    end
    _ARG_0_.CollarFlag = _UPVALUE1_
  else
    if _ARG_1_ == _UPVALUE1_ then
      return
    end
    _ARG_0_.CollarFlag = _UPVALUE0_
  end
  _ARG_0_.ControCollarTime = 0
end
function b01he00.AlphaControler(_ARG_0_)
  _ARG_0_.ControCollarTime = _ARG_0_.ControCollarTime + 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_0_.CollarFlag == _UPVALUE0_ then
    _ARG_0_.DispAlpha1 = 1
    _ARG_0_.DispAlpha2 = 1 - 0.033333335 * _ARG_0_.ControCollarTime
    if _ARG_0_.DispAlpha2 < 0 then
      _ARG_0_.DispAlpha2 = 0
    end
    _ARG_0_.DispHeadAlpha2 = 1 - 0.025 * _ARG_0_.ControCollarTime
    if 0 > _ARG_0_.DispHeadAlpha2 then
      _ARG_0_.DispHeadAlpha2 = 0
    end
    _ARG_0_.DispHeadAlpha1 = 0.05 * _ARG_0_.ControCollarTime
    if 1 < _ARG_0_.DispHeadAlpha1 then
      _ARG_0_.DispHeadAlpha1 = 1
    end
  else
    _ARG_0_.DispAlpha2 = 0.0125 * _ARG_0_.ControCollarTime
    if 1 < _ARG_0_.DispAlpha2 then
      _ARG_0_.DispAlpha2 = 1
    end
    _ARG_0_.DispAlpha1 = 1
    _ARG_0_.DispHeadAlpha2 = 0.05 * _ARG_0_.ControCollarTime
    if 1 < _ARG_0_.DispHeadAlpha2 then
      _ARG_0_.DispHeadAlpha2 = 1
    end
    _ARG_0_.DispHeadAlpha1 = 1 - 0.025 * _ARG_0_.ControCollarTime
    if 0 > _ARG_0_.DispHeadAlpha1 then
      _ARG_0_.DispHeadAlpha1 = 0
    end
  end
end
function b01he00.ChangeDisp(_ARG_0_)
  _ARG_0_:AlphaControler()
  Entity.SetModelPartsAlpha(_ARG_0_.myHandle, 0, _ARG_0_.DispAlpha1)
  Entity.SetModelPartsAlpha(_ARG_0_.myHandle, 1, _ARG_0_.DispAlpha1)
  Entity.SetModelPartsAlpha(_ARG_0_.myHandle, 2, _ARG_0_.DispAlpha1)
  Entity.SetModelPartsAlpha(_ARG_0_.myHandle, 3, _ARG_0_.DispHeadAlpha1)
  Entity.SetModelPartsAlpha(_ARG_0_.myHandle, 4, _ARG_0_.DispAlpha2)
  Entity.SetModelPartsAlpha(_ARG_0_.myHandle, 5, _ARG_0_.DispAlpha2)
  Entity.SetModelPartsAlpha(_ARG_0_.myHandle, 6, _ARG_0_.DispAlpha2)
  Entity.SetModelPartsAlpha(_ARG_0_.myHandle, 7, _ARG_0_.DispHeadAlpha2)
end
function b01he00.OnDestroy(_ARG_0_)
  Effect.KillEffect(_ARG_0_.FireEffectHandleBule)
  Effect.KillEffect(_ARG_0_.FireEffectHandleRed)
end
function b01he00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.targetHandle = NULL_HANDLE
  _ARG_0_.IceTianHandle = NULL_HANDLE
  _ARG_0_.BsdHandle = NULL_HANDLE
  _ARG_0_.step = 0
  _ARG_0_.shotFlag = 0
  _ARG_0_.ModeType = 0
  _ARG_0_.SubDelay = 0
  _ARG_0_.FireEffectHandleBule = NULL_HANDLE
  _ARG_0_.FireEffectHandleRed = NULL_HANDLE
  _ARG_0_.RotY = 0
  _ARG_0_.AttackFlag = 0
  _ARG_0_.AttackDelay = 0
  _ARG_0_.watchingNum = 0
  _ARG_0_.cnboNum = 0
  _ARG_0_.deadFlag = 0
  _ARG_0_.CollarFlag = _UPVALUE0_
  _ARG_0_.DispAlpha1 = 1
  _ARG_0_.DispAlpha2 = 0
  _ARG_0_.DispHeadAlpha1 = 1
  _ARG_0_.DispHeadAlpha2 = 0
  _ARG_0_.sameDamageCont = 0
  _ARG_0_.diffDamageCont = 0
  _ARG_0_.oldDamagePoint = 0
  _ARG_0_.wanderAng = 0
  _ARG_0_.ControTime = 0
  _ARG_0_.ControCollarTime = 0
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkTime = 0
  _ARG_0_.WorkVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
  _ARG_0_.cameraPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
  if _UPVALUE1_ == false then
    _UPVALUE2_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "Action1Dis")
    _UPVALUE2_ = _UPVALUE2_ * _UPVALUE2_
    _UPVALUE3_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "Action2Dis")
    _UPVALUE3_ = _UPVALUE3_ * _UPVALUE3_
    _UPVALUE4_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "BladTime") * 60
    _UPVALUE5_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "BladRot")
    _UPVALUE6_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "FingerNum")
    _UPVALUE7_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "IdlingTime") * 60
    _UPVALUE8_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "MoveTime") * 60
    _UPVALUE9_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "DisAttRat") * 0.01
    _UPVALUE10_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "DisAttRat1") * 0.01
    _UPVALUE11_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "ChaHpRate") * 0.01
    print("B01HE_CHANGEHPRATE = " .. _UPVALUE11_ .. "\n")
    B10S_INIT_PARAM = true
  end
  Entity.SetMovementCollRadius(_ARG_0_.myHandle, 1)
  Entity.SetLowerHalf(_ARG_0_.myHandle, 1.5)
  Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
  Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
  Entity.EnableLockon(_ARG_0_.myHandle, 0)
  Entity.EnableGravity(_ARG_0_.myHandle, 1)
  Enemy.IsAllEnemyWaiting()
  Player.SetBossCamera("b01he")
  if Enemy.IsAllEnemyWaiting() == true then
    if Entity.GetName(_ARG_0_.myHandle) == "b80vs00" then
      _ARG_0_:GotoState("StandbyArena")
    else
      _ARG_0_:GotoState("Standby")
    end
  else
    if Entity.GetName(_ARG_0_.myHandle) == "b80vs00" then
      _ARG_0_:GotoState("StandbyArena")
    else
      _ARG_0_:GotoState("Appear")
    end
    Entity.EnableLockon(_ARG_0_.myHandle, 1)
  end
end
function b01he00.CreateShot(_ARG_0_, _ARG_1_)
  Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.targetHandle, 2)
  Entity.GetWorldPos(_ARG_0_.WorkVec1, _ARG_1_, 57)
  Entity.GetRot(_ARG_0_.rot, _ARG_1_)
  FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.WorkVec, _ARG_0_.WorkVec1)
  FVECTOR3.normalize(_ARG_0_.workVec)
  _ARG_0_.rot:setx(-Math.Atan2(_ARG_0_.workVec:gety(), Math.Sqrt(_ARG_0_.workVec:getz() * _ARG_0_.workVec:getz() + _ARG_0_.workVec:getx() * _ARG_0_.workVec:getx())))
  Bullet.CreateEffectBullet(Bullet.CreateBullet("", _ARG_0_.WorkVec1, _ARG_0_.rot), "b01he00", "B010_FGB_02_0")
  if Enemy.IsConfuse(_ARG_0_.myHandle) then
    Bullet.SetCollision(Bullet.CreateBullet("", _ARG_0_.WorkVec1, _ARG_0_.rot), COLL_KIND_NO_CHECK, COLL_SHAPE_SPHERE, 0.5, 0, _ARG_1_)
  else
    Bullet.SetCollision(Bullet.CreateBullet("", _ARG_0_.WorkVec1, _ARG_0_.rot), COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, 0.5, 0, _ARG_1_)
  end
  SetBulletAttackParam(Bullet.CreateBullet("", _ARG_0_.WorkVec1, _ARG_0_.rot), _ARG_0_.myHandle, 1)
  Bullet.SetHitAttackEffectName(Bullet.CreateBullet("", _ARG_0_.WorkVec1, _ARG_0_.rot), "b01he00", "B010_HIT_01_0")
  Bullet.SetHitBgEffectName(Bullet.CreateBullet("", _ARG_0_.WorkVec1, _ARG_0_.rot), "b01he00", "B010_HIT_01_0")
  Bullet.EnableReflect(Bullet.CreateBullet("", _ARG_0_.WorkVec1, _ARG_0_.rot), Enemy.GetAttackReflect(_ARG_0_.myHandle, 0))
  Entity.CalcVelocity(Bullet.CreateBullet("", _ARG_0_.WorkVec1, _ARG_0_.rot), 0.25)
end
function b01he00.OnDamage(_ARG_0_, _ARG_1_)
  print("OnDamage\n")
  if Entity.GetDamagePoint(_ARG_0_.myHandle) == _ARG_0_.oldDamagePoint then
    print("\147\175\130\182\131_\131\129\129[\131W\151\205\130\197\130\171\130\189\130\230\130\179\130\241\129B\n")
    _ARG_0_.sameDamageCont = _ARG_0_.sameDamageCont + 1
    print("sameDamageCont = " .. _ARG_0_.sameDamageCont .. "\n")
    if _ARG_0_.sameDamageCont > 6 then
      if Script.Random() < 0.5 then
        _ARG_0_:GotoState("BladesCrossing")
      else
        _ARG_0_:GotoState("NoRiaFingernailofFire")
      end
      _ARG_0_.sameDamageCont = 0
      return 1
    end
    _ARG_0_.diffDamageCont = 0
  else
    _ARG_0_.diffDamageCont = _ARG_0_.diffDamageCont + 1
    if _ARG_0_.diffDamageCont > 4 then
      _ARG_0_.sameDamageCont = 0
      _ARG_0_.diffDamageCont = 0
    end
  end
  _ARG_0_.oldDamagePoint = Entity.GetDamagePoint(_ARG_0_.myHandle)
  _ARG_0_.SubDelay = _ARG_0_.SubDelay + 3
  _ARG_0_.AttackFlag = 1
  _ARG_0_.OldState = _ARG_0_:GetState()
  if _ARG_0_:CheckHP() == 1 then
    _ARG_0_.ModeType = _UPVALUE0_
  end
  if Entity.GetName((Entity.GetAttacker(_ARG_0_.myHandle))) == "b10he00" then
    _ARG_0_:GotoState("Freeze")
    return 1
  end
  if _ARG_0_.OldState == "Freeze" then
    Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
    _ARG_0_:GotoState("Idling")
    return 1
  end
end
function b01he00.OnDamageBefore(_ARG_0_, _ARG_1_)
  if Effect.IsAlive(_ARG_0_.FireEffectHandleRed) then
    return 1
  end
end
function b01he00.OnReturnDamage(_ARG_0_)
  _ARG_0_:GotoState(_ARG_0_.OldState)
end
function b01he00.OnHitAttack(_ARG_0_, _ARG_1_)
  nowstate = _ARG_0_:GetState()
  if nowstate == "BladesCrossing" then
    Entity.AttachEffect(_ARG_1_, "b01he00", "B010_HIT_02_0", "center")
  end
end
function b01he00.PlayVoice(_ARG_0_, _ARG_1_)
  Entity.GetWorldPos(_ARG_0_.workVec, _ARG_0_.myHandle)
  Sound.PlayVoice(116, _ARG_1_, 1, _ARG_0_.workVec, SE_OPT_ALWAYS)
end
function b01he00.OnDead(_ARG_0_)
  if Entity.GetName(_ARG_0_.myHandle) == "b80vs00" then
    _ARG_0_:GotoStateSub("DeadArena")
  else
    _ARG_0_:GotoState("Dead")
  end
  return 1
end
function b01he00.Debug(_ARG_0_)
  if Script.IsDebugCheckAttack() then
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
function b01he00.OnUpdate(_ARG_0_)
  _ARG_0_:AttackControl()
  _ARG_0_:ChangeDisp()
  _ARG_0_:Update()
  _ARG_0_:Debug()
end
EntityFactory:Add("b01he00", function(_ARG_0_)
  return (b01he00:new())
end)
EntityFactory:Add("b80vs00", function(_ARG_0_)
  return (b01he00:new())
end)
