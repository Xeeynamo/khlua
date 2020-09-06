b10cd00 = {}
b10cd00_base_mt = {__index = __StateMachine}
setmetatable(b10cd00, b10cd00_base_mt)
b10cd00_mt = {__index = b10cd00}
function b10cd00.new(_ARG_0_)
  return setmetatable(__StateMachine:new(), b10cd00_mt)
end
b10cd00.states = {
  Appear = {
    OnBeginState = function(_ARG_0_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      _ARG_0_.SonebyteDelay = _UPVALUE2_
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
        return
      end
      _ARG_0_:GotoState("RandomMove")
    end
  },
  RandomMove = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.step = 0
      _ARG_0_.count = 0
      _ARG_0_.MoveFlag = 0
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.stack:clear()
      _ARG_0_.stack:push("Idling")
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.RandomMoveAng = 0
      _ARG_0_.notCheckWallTime = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.HasNetGameHandle(_ARG_0_.myHandle) and Enemy.IsNetworkMaster(_ARG_0_.myHandle) == false then
        return
      end
      _ARG_0_.notCheckTime = _ARG_0_.notCheckTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      if _ARG_0_.step == 0 then
        Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
        _ARG_0_.targetPos:setx(_ARG_0_.targetPos:getx() + (3 * Script.Random() + 3) * 2 * Math.Cos((RoundPI(Script.Random() * 2 * PI))))
        _ARG_0_.targetPos:setz(_ARG_0_.targetPos:getz() + (3 * Script.Random() + 3) * 2 * Math.Sin((RoundPI(Script.Random() * 2 * PI))))
        _ARG_0_.step = 1
        _ARG_0_.RandomMoveAng = 3.5 - Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) / 100
        _ARG_0_.notCheckTime = 60
      elseif _ARG_0_.step == 11 then
        _ARG_0_.targetPos:set(0, 0, 0)
        _ARG_0_.targetPos:setx(_ARG_0_.targetPos:getx() + (3 * Script.Random() + 3) * 2 * Math.Cos((RoundPI(Script.Random() * 2 * PI))))
        _ARG_0_.targetPos:setz(_ARG_0_.targetPos:getz() + (3 * Script.Random() + 3) * 2 * Math.Sin((RoundPI(Script.Random() * 2 * PI))))
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        _ARG_0_.step = 2
      elseif _ARG_0_.step == 1 then
        Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
        _ARG_0_.workVec0:set(1, 0, 0)
        Math.RotateVectorXYZ(_ARG_0_.workVec0, _ARG_0_.rot)
        Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
        FVECTOR3.Sub(_ARG_0_.workVec1, _ARG_0_.myPos, _ARG_0_.targetPos)
        _ARG_0_.workVec1:normalize()
        if _ARG_0_.workVec0:dot(_ARG_0_.workVec1) < -0.1 then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE2_)
          _ARG_0_:Rotation(1)
        elseif _ARG_0_.workVec0:dot(_ARG_0_.workVec1) > 0.1 then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE3_)
          _ARG_0_:Rotation(-1)
        elseif Script.Random() < 0.5 then
          if Script.Random() < 0.5 then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE4_)
            Entity.SetTimer(_ARG_0_.myHandle, Script.Random() * _UPVALUE5_ + _UPVALUE6_)
            _ARG_0_.step = 5
            _ARG_0_.MoveFlag = 0
          else
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE7_)
            Entity.SetTimer(_ARG_0_.myHandle, Script.Random() * _UPVALUE5_ + _UPVALUE6_)
            _ARG_0_.step = 5
            _ARG_0_.MoveFlag = 1
          end
        else
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
          _ARG_0_.step = 2
        end
      elseif _ARG_0_.step == 2 then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 1)
        _ARG_0_:Advancement(_UPVALUE8_)
        if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetPos) < 4 or 1 > Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) then
          _ARG_0_.notCheckTime = -999
        end
        if _ARG_0_.notCheckTime < 0 and (Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.IsWall(_ARG_0_.myHandle) or Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetPos) < 4 or Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 16) then
          _ARG_0_.count = _ARG_0_.count + 1
          if _ARG_0_.count > _UPVALUE9_ then
            if _ARG_0_:RestHpRate() < _UPVALUE10_ then
              if Script.Random() < _UPVALUE11_ then
                _ARG_0_:GotoState("PlayerApproach")
              else
                _ARG_0_:GotoState("PlayerOpened")
              end
            else
              _ARG_0_:GotoState("Idling")
            end
          else
            _ARG_0_.notCheckTime = 120
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE12_)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            if Entity.IsWall(_ARG_0_.myHandle) then
              _ARG_0_.step = 11
            else
              _ARG_0_.step = 0
            end
          end
        end
      elseif _ARG_0_.step == 3 then
        Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
        _ARG_0_.step = 4
      elseif _ARG_0_.step == 4 then
        Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
        _ARG_0_.workVec0:set(1, 0, 0)
        Math.RotateVectorXYZ(_ARG_0_.workVec0, _ARG_0_.rot)
        Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
        FVECTOR3.Sub(_ARG_0_.workVec1, _ARG_0_.myPos, _ARG_0_.targetPos)
        _ARG_0_.workVec1:normalize()
        if _ARG_0_.workVec0:dot(_ARG_0_.workVec1) < -0.1 then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE2_)
          _ARG_0_:Rotation(1)
        elseif _ARG_0_.workVec0:dot(_ARG_0_.workVec1) > 0.1 then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE3_)
          _ARG_0_:Rotation(-1)
        elseif Script.Random() < 0.5 then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE4_)
          Entity.SetTimer(_ARG_0_.myHandle, Script.Random() * _UPVALUE5_ + _UPVALUE6_)
          _ARG_0_.step = 5
          _ARG_0_.MoveFlag = 0
        else
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE7_)
          Entity.SetTimer(_ARG_0_.myHandle, Script.Random() * _UPVALUE5_ + _UPVALUE6_)
          _ARG_0_.step = 5
          _ARG_0_.MoveFlag = 1
        end
      elseif _ARG_0_.step == 5 then
        if _ARG_0_.MoveFlag == 0 then
          _ARG_0_:LeftTurn(_UPVALUE13_)
          _ARG_0_:RotationSet(DegToRad(_ARG_0_.RandomMoveAng))
        else
          _ARG_0_:RightTurn(_UPVALUE13_)
          _ARG_0_:RotationSet(DegToRad(-_ARG_0_.RandomMoveAng))
        end
        if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetPos) < 4 or 1 > Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) then
          _ARG_0_.notCheckTime = -999
        end
        if _ARG_0_.notCheckTime < 0 and (Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.IsWall(_ARG_0_.myHandle) or Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 4 or Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetPos) < 4) then
          _ARG_0_.count = _ARG_0_.count + 1
          if _ARG_0_.count > _UPVALUE9_ then
            if _ARG_0_:RestHpRate() < _UPVALUE10_ then
              if Script.Random() < 0.5 then
                _ARG_0_:GotoState("PlayerApproach")
              else
                _ARG_0_:GotoState("PlayerOpened")
              end
            else
              _ARG_0_:GotoState("Idling")
            end
          else
            _ARG_0_.notCheckTime = 120
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE12_)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            if Entity.IsWall(_ARG_0_.myHandle) then
              _ARG_0_.step = 11
            else
              _ARG_0_.step = 0
            end
          end
        end
      end
    end
  },
  Idling = {
    OnBeginState = function(_ARG_0_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
      Player.SetExCounter(_UPVALUE2_)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
        return
      end
      if Entity.IsPlayer(_ARG_0_.targetHandle) and _ARG_0_:RestHpRate() < _UPVALUE0_ then
        _ARG_0_:GotoState("TargetRotation")
        return
      end
      if _ARG_0_:IsSonebyteAlive() == true and _ARG_0_.SonebyteDelay < 0 then
        _ARG_0_:GotoState("SoneByteBom")
        return
      end
      if _ARG_0_.step == 0 then
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE1_ then
          _ARG_0_:GotoState("Tentacle_Attack")
          return
        elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _UPVALUE1_ and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE2_ then
          if Script.Random() < _UPVALUE3_ then
            _ARG_0_:GotoState("SpringPress")
          elseif not Entity.IsWall(_ARG_0_.myHandle) then
            _ARG_0_:GotoState("Retreat")
          else
            _ARG_0_:GotoState("SpringPress")
          end
          return
        elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _UPVALUE2_ then
          _ARG_0_:GotoState("SpinrushEx")
          return
        end
      end
    end
  },
  SoneByteBom = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
      _ARG_0_.SonebyteDelay = _UPVALUE1_
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 20 then
          Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle, 70)
          Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
          _ARG_0_.rot:sety(DegToRad(Script.Random() * 360))
          _ARG_0_.sonebyte[0].handle = Entity.CreateEntity("m06ex00", _ARG_0_.myPos, _ARG_0_.rot)
          _ARG_0_.WorkVec:set(0, Script.Random() * 0.3 + 0.1, Script.Random() * 0.4 - 0.2)
          Entity.SetVelocity(_ARG_0_.sonebyte[0].handle, _ARG_0_.WorkVec)
          Entity.EnableGravity(_ARG_0_.sonebyte[0].handle, 1)
          _ARG_0_.sonebyte[0].Groundflag = 0
          EntityManager:GetEntity(_ARG_0_.sonebyte[0].handle):GotoState("Fly")
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 30 then
          Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle, 58)
          Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
          _ARG_0_.rot:sety(DegToRad(Script.Random() * 360))
          _ARG_0_.sonebyte[1].handle = Entity.CreateEntity("m06ex00", _ARG_0_.myPos, _ARG_0_.rot)
          _ARG_0_.WorkVec:set(0, Script.Random() * 0.3 + 0.1, Script.Random() * 0.4 - 0.2)
          Entity.SetVelocity(_ARG_0_.sonebyte[1].handle, _ARG_0_.WorkVec)
          Entity.EnableGravity(_ARG_0_.sonebyte[1].handle, 1)
          _ARG_0_.sonebyte[1].Groundflag = 0
          EntityManager:GetEntity(_ARG_0_.sonebyte[1].handle):GotoState("Fly")
          _ARG_0_.step = 2
        end
      elseif _ARG_0_.step == 2 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 40 then
          Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle, 70)
          Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
          _ARG_0_.rot:sety(DegToRad(Script.Random() * 360))
          _ARG_0_.sonebyte[2].handle = Entity.CreateEntity("m06ex00", _ARG_0_.myPos, _ARG_0_.rot)
          _ARG_0_.WorkVec:set(0, Script.Random() * 0.1 + 0.1, Script.Random() * 0.4 - 0.2)
          Entity.SetVelocity(_ARG_0_.sonebyte[2].handle, _ARG_0_.WorkVec)
          Entity.EnableGravity(_ARG_0_.sonebyte[2].handle, 1)
          _ARG_0_.sonebyte[2].Groundflag = 0
          EntityManager:GetEntity(_ARG_0_.sonebyte[2].handle):GotoState("Fly")
          _ARG_0_.step = 3
        end
      elseif _ARG_0_.step == 3 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("RandomMove")
      end
    end
  },
  RandomMove2 = {
    OnBeginState = function(_ARG_0_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 3
      _ARG_0_.count = 0
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.stack:clear()
      _ARG_0_.stack:push("Idling")
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.HasNetGameHandle(_ARG_0_.myHandle) and Enemy.IsNetworkMaster(_ARG_0_.myHandle) == false then
        return
      end
      if _ARG_0_.step == 0 then
        _ARG_0_.targetPos:setx(9 * Script.Random() * 2 * Math.Cos((RoundPI(Script.Random() * 3 * PI))))
        _ARG_0_.targetPos:setz(9 * Script.Random() * 2 * Math.Sin((RoundPI(Script.Random() * 3 * PI))))
        _ARG_0_.step = 1
      elseif _ARG_0_.step == 1 then
        Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
        _ARG_0_.workVec0:set(1, 0, 0)
        Math.RotateVectorXYZ(_ARG_0_.workVec0, _ARG_0_.rot)
        Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
        FVECTOR3.Sub(_ARG_0_.workVec1, _ARG_0_.myPos, _ARG_0_.targetPos)
        _ARG_0_.workVec1:normalize()
        if _ARG_0_.workVec0:dot(_ARG_0_.workVec1) < -0.1 then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
          _ARG_0_:Rotation(1)
        elseif _ARG_0_.workVec0:dot(_ARG_0_.workVec1) > 0.1 then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE1_)
          _ARG_0_:Rotation(-1)
        else
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE3_)
          _ARG_0_.step = 2
        end
      elseif _ARG_0_.step == 2 then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 10)
        _ARG_0_:Advancement(_UPVALUE4_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.IsWall(_ARG_0_.myHandle) or 1 > Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetPos) then
          _ARG_0_.count = _ARG_0_.count + 1
          if 1 < _ARG_0_.count then
            if Script.Random() < 0.5 then
              _ARG_0_:GotoState("PlayerApproach")
            else
              _ARG_0_:GotoState("PlayerOpened")
            end
          else
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE5_)
            _ARG_0_.step = 0
            Entity.ClearSpeed(_ARG_0_.myHandle)
          end
        end
      elseif _ARG_0_.step == 3 then
        Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
        _ARG_0_.step = 4
      elseif _ARG_0_.step == 4 then
        Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
        _ARG_0_.workVec0:set(1, 0, 0)
        Math.RotateVectorXYZ(_ARG_0_.workVec0, _ARG_0_.rot)
        Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
        FVECTOR3.Sub(_ARG_0_.workVec1, _ARG_0_.myPos, _ARG_0_.targetPos)
        _ARG_0_.workVec1:normalize()
        if _ARG_0_.workVec0:dot(_ARG_0_.workVec1) < -0.1 then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
          _ARG_0_:Rotation(1)
        elseif _ARG_0_.workVec0:dot(_ARG_0_.workVec1) > 0.1 then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE1_)
          _ARG_0_:Rotation(-1)
        else
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE3_)
          _ARG_0_.step = 2
        end
      elseif _ARG_0_.step == 4 then
      end
    end
  },
  PlayerApproach = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetTimer(_ARG_0_.myHandle, 480)
      _ARG_0_.AttackCnt = Script.Random() * _UPVALUE1_ + _UPVALUE2_
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      _ARG_0_.Speed = 0
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.HasNetGameHandle(_ARG_0_.myHandle) and Enemy.IsNetworkMaster(_ARG_0_.myHandle) == false then
        return
      end
      if _ARG_0_.step == 0 then
        Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
        _ARG_0_.workVec0:set(1, 0, 0)
        Math.RotateVectorXYZ(_ARG_0_.workVec0, _ARG_0_.rot)
        Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
        Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
        FVECTOR3.Sub(_ARG_0_.workVec1, _ARG_0_.myPos, _ARG_0_.targetPos)
        _ARG_0_.workVec1:normalize()
        if _ARG_0_.workVec0:dot(_ARG_0_.workVec1) < -0.1 then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
          _ARG_0_:Rotation(1)
        elseif _ARG_0_.workVec0:dot(_ARG_0_.workVec1) > 0.1 then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE1_)
          _ARG_0_:Rotation(-1)
        else
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 then
        if Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE3_ or Entity.IsWall(_ARG_0_.myHandle) then
          Entity.ClearSpeed(_ARG_0_.myHandle)
          _ARG_0_:GotoState("Tentacle_Attack_TypeB")
          return
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 1)
        _ARG_0_:Advancement(_UPVALUE4_)
      end
    end
  },
  PlayerOpened = {
    OnBeginState = function(_ARG_0_)
      if Script.Random() < 0.5 then
        _ARG_0_.step = 0
        Entity.SetTimer(_ARG_0_.myHandle, 180)
      else
        if Script.Random() < 0.5 then
          _ARG_0_.step = 1
        else
          _ARG_0_.step = 2
        end
        Entity.SetTimer(_ARG_0_.myHandle, Script.Random() * _UPVALUE0_ + _UPVALUE1_)
      end
      _ARG_0_.RandomMoveAng = 3.5 - Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) / 100
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _UPVALUE0_ or Entity.IsWall(_ARG_0_.myHandle) then
        Entity.ClearSpeed(_ARG_0_.myHandle)
        if Script.Random() < _UPVALUE1_ then
          _ARG_0_:GotoState("HurricaneBomb")
        else
          _ARG_0_:GotoState("SpringPress")
        end
        return
      end
      if _ARG_0_.step == 0 then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 1)
        _ARG_0_:Retreat(_UPVALUE2_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE3_)
      elseif _ARG_0_.step == 1 then
        _ARG_0_:RightTurn(_UPVALUE4_)
        _ARG_0_:RotationSet(DegToRad(-_ARG_0_.RandomMoveAng))
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE5_)
      elseif _ARG_0_.step == 2 then
        _ARG_0_:LeftTurn(_UPVALUE4_)
        _ARG_0_:RotationSet(DegToRad(_ARG_0_.RandomMoveAng))
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE6_)
      end
    end
  },
  Move = {
    OnBeginState = function(_ARG_0_)
      Entity.SetTimer(_ARG_0_.myHandle, 0)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
    end
  },
  Retreat = {
    OnBeginState = function(_ARG_0_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.Speed = 0
      Entity.ClearSpeed(_ARG_0_.myHandle)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.IsWall(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
        return
      end
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 2)
      _ARG_0_:Retreat(_UPVALUE0_)
    end
  },
  Tentacle_Attack = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.AttackCnt = Script.Random() * _UPVALUE0_ + _UPVALUE1_
      _ARG_0_.AttackFlag = 0
      _ARG_0_.step = 1
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      _ARG_0_.AttackFlag = 0
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
          Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 then
        Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
        _ARG_0_.workVec0:set(1, 0, 0)
        Math.RotateVectorXYZ(_ARG_0_.workVec0, _ARG_0_.rot)
        Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
        Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
        FVECTOR3.Sub(_ARG_0_.workVec1, _ARG_0_.myPos, _ARG_0_.targetPos)
        _ARG_0_.workVec1:normalize()
        if _ARG_0_.workVec0:dot(_ARG_0_.workVec1) < -0.1 then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
          _ARG_0_:Rotation(1)
        elseif _ARG_0_.workVec0:dot(_ARG_0_.workVec1) > 0.1 then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE1_)
          _ARG_0_:Rotation(-1)
        else
          _ARG_0_:GotoState("Tentacle_Attack_Motion")
          return
        end
      elseif _ARG_0_.step == 2 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE3_ + Script.Random() * 1)
          _ARG_0_.step = 3
        end
      elseif _ARG_0_.step == 3 and Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_.AttackCnt = _ARG_0_.AttackCnt - 1
        if _ARG_0_.AttackFlag == 1 or 0 > _ARG_0_.AttackCnt then
          _ARG_0_:GotoState("Retreat")
          return
        else
          _ARG_0_.step = 1
        end
      end
    end
  },
  Tentacle_Attack_TypeB = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.AttackFlag = 0
      _ARG_0_.step = 1
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      _ARG_0_.AttackFlag = 0
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
          Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 then
        Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
        _ARG_0_.workVec0:set(1, 0, 0)
        Math.RotateVectorXYZ(_ARG_0_.workVec0, _ARG_0_.rot)
        Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
        Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
        FVECTOR3.Sub(_ARG_0_.workVec1, _ARG_0_.myPos, _ARG_0_.targetPos)
        _ARG_0_.workVec1:normalize()
        if _ARG_0_.workVec0:dot(_ARG_0_.workVec1) < -0.1 then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
          _ARG_0_:Rotation(1)
        elseif _ARG_0_.workVec0:dot(_ARG_0_.workVec1) > 0.1 then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE1_)
          _ARG_0_:Rotation(-1)
        else
          _ARG_0_:GotoState("Tentacle_Attack_Motion")
          return
        end
      elseif _ARG_0_.step == 2 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE3_ + Script.Random() * 1)
          _ARG_0_.step = 3
        end
      elseif _ARG_0_.step == 3 and Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_.AttackCnt = _ARG_0_.AttackCnt - 1
        if _ARG_0_.AttackFlag == 1 or 0 > _ARG_0_.AttackCnt then
          _ARG_0_:GotoState("Retreat")
          return
        else
          _ARG_0_:GotoState("PlayerApproach")
          return
        end
      end
    end
  },
  Tentacle_Attack_Counter = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.AttackFlag = 0
      _ARG_0_.step = 1
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      _ARG_0_.AttackFlag = 0
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
          Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 then
        Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
        _ARG_0_.workVec0:set(1, 0, 0)
        Math.RotateVectorXYZ(_ARG_0_.workVec0, _ARG_0_.rot)
        Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
        Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
        FVECTOR3.Sub(_ARG_0_.workVec1, _ARG_0_.myPos, _ARG_0_.targetPos)
        _ARG_0_.workVec1:normalize()
        if _ARG_0_.workVec0:dot(_ARG_0_.workVec1) < -0.1 then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
          _ARG_0_:Rotation(1)
        elseif _ARG_0_.workVec0:dot(_ARG_0_.workVec1) > 0.1 then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE1_)
          _ARG_0_:Rotation(-1)
        else
          _ARG_0_:GotoState("Tentacle_Attack_Motion")
          return
        end
      elseif _ARG_0_.step == 2 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE3_ + Script.Random() * 1)
          _ARG_0_.step = 3
        end
      elseif _ARG_0_.step == 3 and Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Tentacle_Attack_Motion = {
    OnBeginState = function(_ARG_0_)
      print("b10cd00:Tentacle_Attack_Motion\n")
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      _ARG_0_.AttackFlag = 0
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_ + Script.Random() * 1)
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 and Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  SpringPress = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.step = 4
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      _ARG_0_.AttackCnt = 0
      _ARG_0_.WorkNum = 0
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 50)
      if Player.GetPlayerID(_ARG_0_.targetHandle, 1) == PLAYER_ID_AQUA then
        print("\131^\129[\131\147\131I\129[\131o\129[\131Z\131b\131g\n")
        Player.SetExCounter(COMMAND_KIND_TurnOver)
      else
        Player.SetExCounter(_UPVALUE1_)
      end
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.IsWall(_ARG_0_.myHandle) then
        elseif not _ARG_0_.AttackCnt ^ 2 then
          _ARG_0_:Rotation(Script.Random() * 45 + 35)
        else
          _ARG_0_:Rotation(-(Script.Random() * 45 + 35))
        end
        _ARG_0_.workVec0:set(0, 0, 0)
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.workVec0) > 400 then
          _ARG_0_.targetPos:set(0, 0, 0)
        else
          Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
        end
        _ARG_0_.targetPos:setx(_ARG_0_.targetPos:getx() + 10 * Script.Random() * 2 * Math.Cos((RoundPI(Script.Random() * 2 * PI))))
        _ARG_0_.targetPos:setz(_ARG_0_.targetPos:getz() + 10 * Script.Random() * 2 * Math.Sin((RoundPI(Script.Random() * 2 * PI))))
        if _ARG_0_.AttackCnt > _UPVALUE0_ - 1 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 300)
        elseif _ARG_0_.AttackCnt > _UPVALUE1_ then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 30)
        else
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 169 then
            Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, Script.Random() * 30 + 20)
          end
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.workVec0) > 400 then
            Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 360)
          end
        end
        if _ARG_0_.WorkNum == 0 then
          _ARG_0_.WorkNum = 1
          Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle, 0)
          Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
          _ARG_0_.myPos:sety(_ARG_0_.myPos:gety() - Entity.GetFloorDistance(_ARG_0_.myHandle))
          Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
          Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
          SetBulletAttackParam(Bullet.CreateBullet("b10cd00b", _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), _ARG_0_.myHandle, 2)
          Bullet.SetAttacker(Bullet.CreateBullet("b10cd00b", _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), _ARG_0_.myHandle)
          EntityManager:GetEntity((Bullet.CreateBullet("b10cd00b", _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle))).masterHandle = _ARG_0_.myHandle
        end
        _ARG_0_.step = 1
      elseif _ARG_0_.step == 1 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= _UPVALUE2_ then
          _ARG_0_:Advancement(_UPVALUE3_)
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.AttackCnt = _ARG_0_.AttackCnt + 1
          if _ARG_0_.AttackCnt > _UPVALUE0_ then
            _ARG_0_.step = 2
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE4_)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle, 0)
            Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
            _ARG_0_.myPos:sety(_ARG_0_.myPos:gety() - Entity.GetFloorDistance(_ARG_0_.myHandle))
            Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
            Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
            SetBulletAttackParam(Bullet.CreateBullet("b10cd00b", _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), _ARG_0_.myHandle, 2)
          else
            _ARG_0_.WorkNum = 0
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE5_)
            _ARG_0_.step = 0
            Entity.ClearSpeed(_ARG_0_.myHandle)
          end
        end
      elseif _ARG_0_.step == 2 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE6_)
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE7_ + Script.Random() * 1)
          _ARG_0_.step = 3
        end
      elseif _ARG_0_.step == 3 then
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
      elseif _ARG_0_.step == 4 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= _UPVALUE2_ then
          _ARG_0_:Advancement(_UPVALUE3_)
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.WorkNum = 0
          _ARG_0_.AttackCnt = _ARG_0_.AttackCnt + 1
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE5_)
          _ARG_0_.step = 0
          Entity.ClearSpeed(_ARG_0_.myHandle)
        end
      end
    end
  },
  SpinrushEx = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.step = 0
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.stack:clear()
      _ARG_0_.stack:push(_UPVALUE1_)
      _ARG_0_.stack:push(_UPVALUE2_)
      _ARG_0_.stack:push(_UPVALUE3_)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      _ARG_0_.AttackFlag = 0
      _ARG_0_.Speed = 0
      _ARG_0_.SpinEffectFlag = 0
      _ARG_0_.SpinEffectCnt = 0
      _ARG_0_.HomingAng = 0.2
      _ARG_0_.WorkNum = 0
      _ARG_0_.WorkTime = 0
      _ARG_0_.count = 0
      _ARG_0_.SpinStopFlag = 0
      _ARG_0_.SpinNoStopTime = 60
      print("PlayerID = " .. Player.GetPlayerID(_ARG_0_.targetHandle) .. "\n")
      if Player.GetPlayerID(_ARG_0_.targetHandle, 1) == PLAYER_ID_AQUA then
        print("\131^\129[\131\147\131I\129[\131o\129[\131Z\131b\131g\n")
        Player.SetExCounter(COMMAND_KIND_TurnOver)
      else
        print("\146\202\143\237\131J\131E\131\147\131^\129[\n")
        Player.SetExCounter(_UPVALUE4_)
      end
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
    end,
    OnEndState = function(_ARG_0_)
      Effect.LoopEnd(_ARG_0_.SpinEffectHandle)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      _ARG_0_.AttackFlag = 0
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.SpinEffectFlag == 0 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 13 then
          Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.myHandle, 2)
          _ARG_0_.SpinEffectHandle = Entity.AttachEffect(_ARG_0_.myHandle, "b10cd00", "B004_SPN_00_0", "atama")
          Effect.SetAttachNoRot(_ARG_0_.SpinEffectHandle, true)
          _ARG_0_.SpinEffectFlag = 1
        end
      elseif _ARG_0_.SpinEffectFlag == 1 then
        Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
        _ARG_0_.WorkVec:set(0, 0, 0)
        _ARG_0_.SpinEffectCnt = _ARG_0_.SpinEffectCnt + 10 * Entity.GetFrameRate(_ARG_0_.myHandle)
        _ARG_0_.workVec:set(0, 0, -1)
        Entity.GetWorldPos2(_ARG_0_.WorkVec, _ARG_0_.myHandle, _ARG_0_.workVec, 0)
        _ARG_0_.workVec:set(0, 0, 1)
        Entity.GetWorldPos2(_ARG_0_.WorkVec1, _ARG_0_.myHandle, _ARG_0_.workVec, 0)
        FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.WorkVec, _ARG_0_.WorkVec1)
        FVECTOR3.normalize(_ARG_0_.workVec)
        _ARG_0_.rot:sety(RoundPI((Math.Atan2(_ARG_0_.workVec:getx(), _ARG_0_.workVec:getz()))) * -1)
        _ARG_0_.workVec:set(0, -1, 0)
        Entity.GetWorldPos2(_ARG_0_.WorkVec, _ARG_0_.myHandle, _ARG_0_.workVec, 50)
        _ARG_0_.workVec:set(0, 0, 0)
        Entity.GetWorldPos2(_ARG_0_.WorkVec1, _ARG_0_.myHandle, _ARG_0_.workVec, 50)
        FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.WorkVec, _ARG_0_.WorkVec1)
        FVECTOR3.normalize(_ARG_0_.workVec)
        _ARG_0_.rot:setz(RoundPI(-Math.Atan2(_ARG_0_.workVec:getx(), Math.Sqrt(_ARG_0_.workVec:getz() * _ARG_0_.workVec:getz() + _ARG_0_.workVec:gety() * _ARG_0_.workVec:gety()))))
        _ARG_0_.WorkVec:set(0, 0, 0)
        Effect.UpdateCoord(_ARG_0_.SpinEffectHandle, _ARG_0_.WorkVec, _ARG_0_.rot)
      end
      if _ARG_0_.step == 0 then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 3)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Entity.SetMotion(_ARG_0_.myHandle, _ARG_0_.stack:pop(1))
          Entity.SetTimer(_ARG_0_.myHandle, Script.Random() * _UPVALUE0_ + _UPVALUE1_)
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 then
        _ARG_0_:SpinMove(_UPVALUE2_, 0.05)
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _UPVALUE3_ then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, _ARG_0_.HomingAng)
        else
          _ARG_0_.HomingAng = 0.5
        end
        if _ARG_0_:RestHpRate() < _UPVALUE4_ then
        elseif _ARG_0_.AttackFlag == 1 then
          Effect.LoopEnd(_ARG_0_.SpinEffectHandle)
          Entity.SetMotion(_ARG_0_.myHandle, _ARG_0_.stack:pop(1), 3)
          Entity.ClearSpeed(_ARG_0_.myHandle)
          _ARG_0_.step = 2
          return
        end
        if _ARG_0_.SpinStopFlag == 1 then
          _ARG_0_.workVec0:set(0, 0, 0)
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.workVec0) > 324 and Entity.IsTimeOver(_ARG_0_.myHandle) then
            Effect.LoopEnd(_ARG_0_.SpinEffectHandle)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Entity.SetMotion(_ARG_0_.myHandle, _ARG_0_.stack:pop(1))
            _ARG_0_.step = 3
          end
        end
        if 0 > _ARG_0_.SpinNoStopTime then
          _ARG_0_.SpinStopFlag = 1
        end
        _ARG_0_.SpinNoStopTime = _ARG_0_.SpinNoStopTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      elseif _ARG_0_.step == 2 then
        _ARG_0_:GotoState("SpinNext_Tentacle_Attack_Motion")
      elseif _ARG_0_.step == 3 then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 2)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          if _ARG_0_:RestHpRate() < _UPVALUE4_ then
            _ARG_0_:GotoState("RandomMove2")
          else
            _ARG_0_:GotoState("Idling")
          end
        end
      end
      _ARG_0_.WorkTime = _ARG_0_.WorkTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
    end
  },
  SpinNext_Tentacle_Attack_Motion = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 2.5)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Effect.LoopEnd(_ARG_0_.SpinEffectHandle)
          Entity.SetMotion(_ARG_0_.myHandle, _ARG_0_.stack:pop(1))
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 2)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          if _ARG_0_:RestHpRate() < _UPVALUE0_ then
            _ARG_0_:GotoState("RandomMove2")
          else
            _ARG_0_:GotoState("Idling")
          end
        end
      end
    end
  },
  HurricaneBomb = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.step = 0
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.stack:clear()
      _ARG_0_.stack:push(_UPVALUE1_)
      _ARG_0_.stack:push(_UPVALUE2_)
      _ARG_0_.stack:push(_UPVALUE3_)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      _ARG_0_.AttackCnt = 0
      _ARG_0_.Bombflag = 0
      _ARG_0_.WorkNum = 0
      _ARG_0_.workstep = 0
      _ARG_0_.JumpPow = 0.44
      _ARG_0_.Gravity = 0.02
      _ARG_0_.DivDist = 2600
    end,
    OnEndState = function(_ARG_0_)
      Entity.EnableLockon(_ARG_0_.myHandle, 1)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      Entity.EnableGravity(_ARG_0_.myHandle, 1)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == _UPVALUE0_ then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 12 then
          _ARG_0_.step = _UPVALUE1_
          _ARG_0_.WorkVec:set(0, 0, 0)
          Entity.EnableGravity(_ARG_0_.myHandle, 0)
        end
      elseif _ARG_0_.step == _UPVALUE1_ then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 3)
        _ARG_0_.JumpPow = _ARG_0_.JumpPow - _ARG_0_.Gravity * Entity.GetFrameRate(_ARG_0_.myHandle)
        _ARG_0_.WorkVec:sety(_ARG_0_.JumpPow)
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.WorkVec)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Entity.ClearSpeed(_ARG_0_.myHandle)
          Entity.SetMotion(_ARG_0_.myHandle, _ARG_0_.stack:pop(1))
          _ARG_0_.step = _UPVALUE2_
          _ARG_0_.workstep = 1
        end
      elseif _ARG_0_.step == _UPVALUE2_ then
        if _ARG_0_.workstep == 0 then
        elseif _ARG_0_.workstep == 1 then
          if _ARG_0_.Bombflag == 0 then
            if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 19 then
              _ARG_0_.workstep = 2
            end
          elseif _ARG_0_.Bombflag == 1 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 44 then
            _ARG_0_.workstep = 2
          end
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_.Bombflag = 0
            _ARG_0_.AttackCnt = _ARG_0_.AttackCnt + 1
          end
          if Script.Random() < 0.25 then
            _ARG_0_.DivDist = _ARG_0_.DivDist * 2.5
          else
            _ARG_0_.DivDist = 2600
          end
          if _ARG_0_.AttackCnt >= _UPVALUE3_ and Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _ARG_0_.stack:pop(1))
            _ARG_0_.step = _UPVALUE4_
            Entity.EnableGravity(_ARG_0_.myHandle, 1)
          end
        elseif _ARG_0_.workstep == 2 then
          Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle, 60)
          Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
          Bullet.CreateEffectBullet(Bullet.CreateBullet("b11cd00", _ARG_0_.myPos, _ARG_0_.rot), "b10cd00", "B004_BOM_01_0")
          if Enemy.IsConfuse(_ARG_0_.myHandle) then
            Bullet.SetCollision(Bullet.CreateBullet("b11cd00", _ARG_0_.myPos, _ARG_0_.rot), COLL_KIND_NO_CHECK, COLL_SHAPE_SPHERE, 0.3, 0, _ARG_0_.myHandle)
          else
            Bullet.SetCollision(Bullet.CreateBullet("b11cd00", _ARG_0_.myPos, _ARG_0_.rot), COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, 0.3, 0, _ARG_0_.myHandle)
          end
          SetBulletAttackParam(Bullet.CreateBullet("b11cd00", _ARG_0_.myPos, _ARG_0_.rot), _ARG_0_.myHandle, 3)
          Bullet.SetHitAttackEffectName(Bullet.CreateBullet("b11cd00", _ARG_0_.myPos, _ARG_0_.rot), "b10cd00", "B004_HIT_02_0")
          Bullet.SetMaxMoveDist(Bullet.CreateBullet("b11cd00", _ARG_0_.myPos, _ARG_0_.rot), 100000000)
          _ARG_0_.WorkVec:set(0, 0.2 / 2, Script.Random() * 0.05 - 0.05 / 2)
          Entity.GetRot(_ARG_0_.rot, (Bullet.CreateBullet("b11cd00", _ARG_0_.myPos, _ARG_0_.rot)))
          _ARG_0_.rot:setx(RoundPI(_ARG_0_.rot:getx() + DegToRad(Script.Random() * -10 - 5 - 45)))
          _ARG_0_.rot:sety(RoundPI(_ARG_0_.rot:gety() + DegToRad(Script.Random() * 50 - 50 / 2)))
          Entity.SetRot(Bullet.CreateBullet("b11cd00", _ARG_0_.myPos, _ARG_0_.rot), _ARG_0_.rot)
          Math.Sqrt((Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle)))
          Entity.CalcVelocity(Bullet.CreateBullet("b11cd00", _ARG_0_.myPos, _ARG_0_.rot), 0.2 / 2 + Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) / _ARG_0_.DivDist)
          Entity.EnableGravity(Bullet.CreateBullet("b11cd00", _ARG_0_.myPos, _ARG_0_.rot), 1)
          EntityManager:GetEntity((Bullet.CreateBullet("b11cd00", _ARG_0_.myPos, _ARG_0_.rot))).MasterHandle = _ARG_0_.myHandle
          _ARG_0_.WorkNum = _ARG_0_.WorkNum + 1
          if _ARG_0_.WorkNum >= _UPVALUE5_ then
            _ARG_0_.workstep = 1
            _ARG_0_.WorkNum = 0
            _ARG_0_.Bombflag = _ARG_0_.Bombflag + 1
          end
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 1)
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 144 then
          _ARG_0_:Retreat(_UPVALUE6_)
        elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > 196 then
          _ARG_0_:Advancement(_UPVALUE6_)
        else
          Entity.ClearSpeed(_ARG_0_.myHandle)
        end
      elseif _ARG_0_.step == _UPVALUE4_ then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 1)
        _ARG_0_:Advancement(_UPVALUE6_)
        if Entity.IsGround(_ARG_0_.myHandle) then
          Entity.ClearSpeed(_ARG_0_.myHandle)
          Entity.SetMotion(_ARG_0_.myHandle, _ARG_0_.stack:pop(1))
          _ARG_0_.step = _UPVALUE7_
        end
      elseif _ARG_0_.step == _UPVALUE7_ and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  TargetRotation = {
    OnBeginState = function(_ARG_0_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
      _ARG_0_.workVec0:set(1, 0, 0)
      Math.RotateVectorXYZ(_ARG_0_.workVec0, _ARG_0_.rot)
      Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
      Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
      FVECTOR3.Sub(_ARG_0_.workVec1, _ARG_0_.myPos, _ARG_0_.targetPos)
      _ARG_0_.workVec1:normalize()
      if _ARG_0_.workVec0:dot(_ARG_0_.workVec1) < -0.1 then
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_:Rotation(1)
      elseif _ARG_0_.workVec0:dot(_ARG_0_.workVec1) > 0.1 then
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE1_)
        _ARG_0_:Rotation(-1)
      else
        _ARG_0_:ChangeState("MealRotation")
        return
      end
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:ChangeState("MealRotation")
      end
    end
  },
  MealGabuGabu = {
    OnBeginState = function(_ARG_0_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
    end
  },
  MealStart = {
    OnBeginState = function(_ARG_0_)
      print("b10cd00:MealStart\n")
      Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.Speed = 0
      Entity.ClearSpeed(_ARG_0_.myHandle)
      _ARG_0_.AttackFlag = 0
      _ARG_0_.WorkNum = 0
      _ARG_0_.WorkTime = 0
      _ARG_0_.step = _UPVALUE2_
      _ARG_0_.InhalingStartFlag = 0
      _ARG_0_.InhalingTime = 0
      _ARG_0_.captureFlag = 0
      if Entity.IsPlayer(_ARG_0_.targetHandle) == false then
        _ARG_0_:GotoState("SpinrushEx")
        _ARG_0_.MealCount = 0
        return
      end
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
    end,
    OnEndState = function(_ARG_0_)
      Entity.EnableLockon(_ARG_0_.myHandle, 1)
      _ARG_0_.Speed = 0
      Entity.ClearSpeed(_ARG_0_.myHandle)
      Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      if _ARG_0_.step == _UPVALUE0_ then
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        if _ARG_0_.InhalingStartFlag == 0 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 26 then
          _ARG_0_.InhalingStartFlag = 1
          _ARG_0_.InhalingTime = _UPVALUE1_
          _ARG_0_.step = _UPVALUE2_
          print("Next B10CD_MEAL_INHALING\n")
        end
      elseif _ARG_0_.step == _UPVALUE2_ then
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        if _ARG_0_.InhalingStartFlag == 1 then
          _ARG_0_.InhalingTime = _ARG_0_.InhalingTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
          _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
          if 0 > _ARG_0_.InhalingTime or Entity.IsPlayer(_ARG_0_.targetHandle) == false then
            Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
            _ARG_0_.step = _UPVALUE3_
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE4_)
          end
          if _ARG_0_.AttackFlag == 1 then
            print("\144H\142\150 \139z\130\162\141\158\130\221\144\172\140\247\n")
            _ARG_0_.step = _UPVALUE5_
            _ARG_0_:ChangeState("MealGabuGabuMaster")
            return
          end
          _ARG_0_.workVec0:set(0, 1, 0)
          if Entity.IsTargetWithinFOV(_ARG_0_.myHandle, _ARG_0_.targetHandle, DegToRad(_UPVALUE6_), 2, _ARG_0_.workVec0) then
            return
          end
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE7_ then
            _ARG_0_:InhaleForPlayer(Player.GetHandleForNet(), _UPVALUE7_, 100, _UPVALUE8_, "center")
          end
        end
      elseif _ARG_0_.step == _UPVALUE9_ then
      elseif _ARG_0_.step == _UPVALUE3_ and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_.MealCount = _ARG_0_.MealCount + 1
        if _ARG_0_.MealCount >= _UPVALUE10_ or Entity.IsPlayer(_ARG_0_.targetHandle) == false then
          _ARG_0_:GotoState("SpinrushEx")
          _ARG_0_.MealCount = 0
          return
        end
        _ARG_0_:GotoState("TargetRotation")
      end
    end
  },
  MealStart_ForNet = {
    OnBeginState = function(_ARG_0_)
      print("b10cd00:MealStart_ForNet\n")
      Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, -1, 8)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.Speed = 0
      Entity.ClearSpeed(_ARG_0_.myHandle)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      _ARG_0_.AttackFlag = 0
      _ARG_0_.WorkNum = 0
      _ARG_0_.WorkTime = 0
      _ARG_0_.step = _UPVALUE2_
      _ARG_0_.InhalingStartFlag = 0
      _ARG_0_.InhalingTime = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.EnableLockon(_ARG_0_.myHandle, 1)
      _ARG_0_.Speed = 0
      Entity.ClearSpeed(_ARG_0_.myHandle)
      Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == _UPVALUE0_ then
        if _ARG_0_.InhalingStartFlag == 0 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 26 then
          _ARG_0_.InhalingStartFlag = 1
          _ARG_0_.InhalingTime = _UPVALUE1_
          _ARG_0_.step = _UPVALUE2_
        end
      elseif _ARG_0_.step == _UPVALUE2_ then
        if _ARG_0_.InhalingStartFlag == 1 then
          _ARG_0_.InhalingTime = _ARG_0_.InhalingTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 > _ARG_0_.InhalingTime or Entity.IsPlayer(Player.GetHandle()) == false then
            Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
            _ARG_0_.step = _UPVALUE3_
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE4_)
          end
          _ARG_0_.workVec0:set(0, 1, 0)
          if Entity.IsTargetWithinFOV(_ARG_0_.myHandle, Player.GetHandle(), DegToRad(_UPVALUE5_), 2, _ARG_0_.workVec0) then
            return
          end
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE6_ then
            _ARG_0_:InhaleForPlayer(Player.GetHandle(), _UPVALUE6_, 100, _UPVALUE7_, "center")
          end
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 16 then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE8_, -1)
            _ARG_0_.step = _UPVALUE3_
            Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
          end
        end
      elseif _ARG_0_.step == _UPVALUE9_ then
      elseif _ARG_0_.step == _UPVALUE3_ and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE10_)
        print("B10CD_MEAL_INHALING_FAILURE\n")
        _ARG_0_.MealCount = _ARG_0_.MealCount + 1
        if _ARG_0_.MealCount >= _UPVALUE11_ then
          _ARG_0_:GotoState("SpinrushEx")
          _ARG_0_.MealCount = 0
          return
        end
        _ARG_0_:GotoState("TargetRotation")
      end
    end
  },
  MealGabuGabu = {
    OnBeginState = function(_ARG_0_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
    end
  },
  MealGabuGabuMaster = {
    OnBeginState = function(_ARG_0_)
      print("b10cd00:MealGabuGabuMaster\n")
      Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 8, 8)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.MealCount = 0
      Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
      _ARG_0_.WorkTime = _UPVALUE2_
      Player.SetDamage(_ARG_0_.meaHandle, 0, ATK_KIND_CAPTURE)
      Entity.EnableBodyColl(_ARG_0_.meaHandle, 0)
      _ARG_0_.workVec0:set(0, 0, 0)
      Entity.SetOldLocalPos(_ARG_0_.meaHandle, _ARG_0_.workVec0)
      Entity.SetLocalPos(_ARG_0_.meaHandle, _ARG_0_.workVec0)
      Entity.SetRot(_ARG_0_.meaHandle, _ARG_0_.workVec0)
      _ARG_0_.workVec0:set(0.001, 0.001, 0.001)
      Entity.SetScale(_ARG_0_.meaHandle, _ARG_0_.workVec0)
      Entity.AttachCoord(_ARG_0_.myHandle, "center", _ARG_0_.meaHandle, "Root")
      Player.DispOff(_ARG_0_.meaHandle)
      Entity.SetupModelFade(_ARG_0_.meaHandle, 0, 0, 1)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.HasNetGameHandle(_ARG_0_.myHandle) == true and Player.GetHandleForNet() ~= _ARG_0_.meaHandle then
        return
      end
      if _ARG_0_.step == 0 then
        Entity.EnableBodyColl(_ARG_0_.meaHandle, 0)
        _ARG_0_.workVec0:set(0, 0, 0)
        Entity.SetOldLocalPos(_ARG_0_.meaHandle, _ARG_0_.workVec0)
        Entity.SetLocalPos(_ARG_0_.meaHandle, _ARG_0_.workVec0)
        Entity.SetRot(_ARG_0_.meaHandle, _ARG_0_.workVec0)
        _ARG_0_.workVec0:set(0.001, 0.001, 0.001)
        Entity.SetScale(_ARG_0_.meaHandle, _ARG_0_.workVec0)
        Entity.AttachCoord(_ARG_0_.myHandle, "center", _ARG_0_.meaHandle, "Root")
        Player.DispOff(_ARG_0_.meaHandle)
        Entity.SetupModelFade(_ARG_0_.meaHandle, 0, 0, 1)
        if 0 > _ARG_0_.WorkTime then
          Player.SetDamage(_ARG_0_.meaHandle, (Player.CalcDamagePoint(_ARG_0_.meaHandle, Enemy.GetAttackPoint(_ARG_0_.myHandle, 7), Enemy.GetAttackPowerCorrection(_ARG_0_.myHandle, 7))))
          Entity.AttachEffect(_ARG_0_.myHandle, "b10cd00", "B004_EAT_01_0", "center")
          _ARG_0_.workVec0:set(0.5, 0, 0, 0)
          Entity.GetWorldPos2(_ARG_0_.workVec0, _ARG_0_.myHandle, _ARG_0_.workVec0, 3)
          _ARG_0_.WorkTime = _UPVALUE0_
        end
        if _ARG_0_:IsTargetCapture(_ARG_0_.targetHandle) == false or Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:ChangeState("MealOut")
          return
        end
        _ARG_0_.WorkTime = _ARG_0_.WorkTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      elseif _ARG_0_.step == 1 then
      end
    end
  },
  MealOut = {
    OnBeginState = function(_ARG_0_)
      print("b10cd00:MealOut\n")
      Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.myHandle, 0)
      _ARG_0_.workVec1:sety(_ARG_0_.workVec0:gety() - 0.1)
      Player.SetDamage(_ARG_0_.meaHandle, 0, ATK_KIND_EAT)
      Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.WorkNum = 0
      _ARG_0_.captureFlag = 0
    end,
    OnEndState = function(_ARG_0_)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.HasNetGameHandle(_ARG_0_.myHandle) == true and Player.GetHandleForNet() ~= _ARG_0_.meaHandle then
        return
      end
      if Entity.GetName(_ARG_0_.myHandle) == "b40vs00" then
        if _ARG_0_.WorkNum == 0 and Player.IsDamageFlagDead(_ARG_0_.meaHandle) then
          _ARG_0_.WorkNum = 3
          _ARG_0_:setPlDropEnd(_ARG_0_.meaHandle)
          return
        end
      elseif _ARG_0_.WorkNum == 0 and Player.IsDamageFlagDead(_ARG_0_.meaHandle) and Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 18 then
        _ARG_0_.WorkNum = 2
        _ARG_0_:setPlDropEx(_ARG_0_.meaHandle)
        return
      end
      if _ARG_0_.WorkNum == 0 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 20 then
          _ARG_0_.WorkNum = 1
        end
      elseif _ARG_0_.WorkNum == 1 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 21 then
          _ARG_0_.WorkNum = 2
          print("\144H\142\150 \147f\130\171\143o\130\181\n")
          _ARG_0_:setPlDropEx(_ARG_0_.meaHandle)
        end
      elseif _ARG_0_.WorkNum == 2 then
        Player.SetTrgFlagCancel(_ARG_0_.meaHandle, 1)
        _ARG_0_.WorkNum = 3
      end
      Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.targetHandle)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
        _ARG_0_:GotoState("RandomMove")
        _ARG_0_.MealCount = 0
      end
    end
  },
  MealRotation = {
    OnBeginState = function(_ARG_0_)
      print("MealRotation\n")
      _ARG_0_.step = _UPVALUE0_
      Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.Speed = 0
      Entity.ClearSpeed(_ARG_0_.myHandle)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      _ARG_0_.AttackFlag = 0
      _ARG_0_.WorkNum = 0
      _ARG_0_.WorkTime = 0
      _ARG_0_.InhalingStartFlag = 0
      _ARG_0_.InhalingTime = 0
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == _UPVALUE0_ then
        if Entity.IsWall(_ARG_0_.myHandle) then
          if Entity.HasNetGameHandle(_ARG_0_.myHandle) == true then
            _ARG_0_:ChangeState("MealStart_ForNet")
          else
            _ARG_0_:ChangeState("MealStart")
          end
          Entity.SetTimer(_ARG_0_.myHandle, 300)
          _ARG_0_.Speed = 0
          Entity.ClearSpeed(_ARG_0_.myHandle)
          return
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          if Entity.HasNetGameHandle(_ARG_0_.myHandle) == true then
            _ARG_0_:ChangeState("MealStart_ForNet")
          else
            _ARG_0_:ChangeState("MealStart")
          end
          Entity.SetTimer(_ARG_0_.myHandle, 300)
          _ARG_0_.Speed = 0
          Entity.ClearSpeed(_ARG_0_.myHandle)
          return
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 2)
        _ARG_0_:Retreat(_UPVALUE1_)
      elseif _ARG_0_.step == _UPVALUE2_ then
        _ARG_0_.workVec0:set(0, 1, 0)
        if Entity.IsWall(_ARG_0_.myHandle) then
          if Entity.HasNetGameHandle(_ARG_0_.myHandle) == true then
            _ARG_0_:ChangeState("MealStart_ForNet")
          else
            _ARG_0_:ChangeState("MealStart")
          end
          Entity.SetTimer(_ARG_0_.myHandle, 300)
          _ARG_0_.Speed = 0
          Entity.ClearSpeed(_ARG_0_.myHandle)
          return
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          if Entity.HasNetGameHandle(_ARG_0_.myHandle) == true then
            _ARG_0_:ChangeState("MealStart_ForNet")
          else
            _ARG_0_:ChangeState("MealStart")
          end
          Entity.SetTimer(_ARG_0_.myHandle, 300)
          _ARG_0_.Speed = 0
          Entity.ClearSpeed(_ARG_0_.myHandle)
          return
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 2)
        _ARG_0_:Advancement(_UPVALUE1_)
      elseif _ARG_0_.step == _UPVALUE3_ then
        Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
        _ARG_0_.workVec0:set(1, 0, 0)
        Math.RotateVectorXYZ(_ARG_0_.workVec0, _ARG_0_.rot)
        Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
        FVECTOR3.Sub(_ARG_0_.workVec1, _ARG_0_.myPos, _ARG_0_.targetPos)
        _ARG_0_.workVec1:normalize()
        if _ARG_0_.workVec0:dot(_ARG_0_.workVec1) < -0.1 then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE4_)
          _ARG_0_:Rotation(1)
        elseif _ARG_0_.workVec0:dot(_ARG_0_.workVec1) > 0.1 then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE5_)
          _ARG_0_:Rotation(-1)
        elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) >= _UPVALUE6_ then
          _ARG_0_.step = _UPVALUE2_
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE7_)
        elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE6_ then
          _ARG_0_.step = _UPVALUE0_
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE8_)
        end
      end
    end
  },
  Meal = {
    OnBeginState = function(_ARG_0_)
      print("b10cd00:Meal\n")
      Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.Speed = 0
      Entity.ClearSpeed(_ARG_0_.myHandle)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      _ARG_0_.AttackFlag = 0
      _ARG_0_.WorkNum = 0
      _ARG_0_.WorkTime = 0
      _ARG_0_.step = _UPVALUE1_
      _ARG_0_.InhalingStartFlag = 0
      _ARG_0_.InhalingTime = 0
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
    end,
    OnEndState = function(_ARG_0_)
      Entity.EnableLockon(_ARG_0_.myHandle, 1)
      _ARG_0_.Speed = 0
      Entity.ClearSpeed(_ARG_0_.myHandle)
      Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == _UPVALUE0_ then
        _ARG_0_.step = _UPVALUE1_
      elseif _ARG_0_.step == _UPVALUE1_ then
        if _ARG_0_.InhalingStartFlag == 0 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 26 then
          _ARG_0_.InhalingStartFlag = 1
          _ARG_0_.InhalingTime = _UPVALUE2_
        end
        if _ARG_0_.InhalingStartFlag == 1 then
          _ARG_0_.InhalingTime = _ARG_0_.InhalingTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 > _ARG_0_.InhalingTime then
            Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
            _ARG_0_.step = _UPVALUE3_
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE4_)
          end
          _ARG_0_.workVec0:set(0, 1, 0)
          if Entity.IsTargetWithinFOV(_ARG_0_.myHandle, _ARG_0_.targetHandle, DegToRad(_UPVALUE5_), 2, _ARG_0_.workVec0) then
            return
          end
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE6_ then
            Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.myHandle, 3)
            Entity.GetWorldPos(_ARG_0_.workVec1, _ARG_0_.targetHandle, 2)
            FVECTOR3.Sub(_ARG_0_.workVec0, _ARG_0_.workVec0, _ARG_0_.workVec1)
            _ARG_0_.workVec0:sety(0)
            _ARG_0_.workVec0:normalize()
            _ARG_0_.workVec0:scale(_UPVALUE7_ * Entity.GetFrameRate(_ARG_0_.myHandle))
            Entity.GetWorldPos(_ARG_0_.workVec1, _ARG_0_.targetHandle, 0)
            FVECTOR3.Add(_ARG_0_.workVec1, _ARG_0_.workVec1, _ARG_0_.workVec0)
            Entity.SetLocalPos(_ARG_0_.targetHandle, _ARG_0_.workVec1)
          end
          if _ARG_0_.AttackFlag == 1 then
            print("\144H\142\150 \139z\130\162\141\158\130\221\144\172\140\247\n")
            Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
            _ARG_0_.step = _UPVALUE8_
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE9_, 7, 7)
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE10_)
            _ARG_0_.MealCount = 0
            Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
            _ARG_0_.WorkTime = _UPVALUE11_
            Entity.EnableBodyColl(_ARG_0_.meaHandle, 0)
            _ARG_0_.workVec0:set(0, 0, 0)
            Entity.SetOldLocalPos(_ARG_0_.meaHandle, _ARG_0_.workVec0)
            Entity.SetLocalPos(_ARG_0_.meaHandle, _ARG_0_.workVec0)
            Entity.SetRot(_ARG_0_.meaHandle, _ARG_0_.workVec0)
            _ARG_0_.workVec0:set(0.001, 0.001, 0.001)
            Entity.SetScale(_ARG_0_.meaHandle, _ARG_0_.workVec0)
            Entity.AttachCoord(_ARG_0_.myHandle, "center", _ARG_0_.meaHandle, "Root")
          end
        end
      elseif _ARG_0_.step == _UPVALUE12_ then
      elseif _ARG_0_.step == _UPVALUE3_ then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.MealCount = _ARG_0_.MealCount + 1
          if _ARG_0_.MealCount >= _UPVALUE13_ then
            _ARG_0_:GotoState("SpinrushEx")
            _ARG_0_.MealCount = 0
            return
          end
          _ARG_0_:GotoState("TargetRotation")
        end
      elseif _ARG_0_.step == _UPVALUE8_ then
        if 0 > _ARG_0_.WorkTime then
          Entity.AttachEffect(_ARG_0_.meaHandle, "b10cd00", "B004_EAT_01_0", "center")
          _ARG_0_.workVec0:set(0.5, 0, 0, 0)
          Entity.GetWorldPos2(_ARG_0_.workVec0, _ARG_0_.myHandle, _ARG_0_.workVec0, 3)
          _ARG_0_.WorkTime = _UPVALUE11_
        end
        Entity.EnableBodyColl(_ARG_0_.meaHandle, 0)
        _ARG_0_.workVec0:set(0, 0, 0)
        Entity.SetOldLocalPos(_ARG_0_.meaHandle, _ARG_0_.workVec0)
        Entity.SetLocalPos(_ARG_0_.meaHandle, _ARG_0_.workVec0)
        Entity.SetRot(_ARG_0_.meaHandle, _ARG_0_.workVec0)
        _ARG_0_.workVec0:set(0.001, 0.001, 0.001)
        Entity.SetScale(_ARG_0_.meaHandle, _ARG_0_.workVec0)
        Entity.AttachCoord(_ARG_0_.myHandle, "center", _ARG_0_.meaHandle, "Root")
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) <= 30 and _ARG_0_:IsTargetCapture(_ARG_0_.meaHandle) == false then
          print("\130\220\130\190\149\223\138l\143o\151\136\130\196\130\200\130\162\130\204\130\197\149\223\138l\131_\131\129\129[\131W\130\240\147\252\130\234\130\233\n")
          Player.SetDamage(_ARG_0_.meaHandle, 0, ATK_KIND_CAPTURE)
          return
        end
        if _ARG_0_:IsTargetCapture(_ARG_0_.meaHandle) == false or Entity.IsTimeOver(_ARG_0_.myHandle) then
          print("self.step = B10CD_MEAL_VOMIT\n")
          Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
          Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.myHandle, 0)
          _ARG_0_.workVec1:sety(_ARG_0_.workVec0:gety() - 0.1)
          Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE14_)
          Player.SetDamage(_ARG_0_.meaHandle, 0, ATK_KIND_EAT)
          _ARG_0_.step = _UPVALUE15_
          _ARG_0_.WorkNum = 0
          return
        end
        if Player.IsBattleFlagPlayerDead() == true or 0 >= Enemy.GetHp(_ARG_0_.meaHandle) then
          print("B10CD_MEAL_VOMIT\n")
          Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE14_)
          _ARG_0_.step = _UPVALUE15_
          _ARG_0_:setPlDrop()
          return
        end
        _ARG_0_.WorkTime = _ARG_0_.WorkTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      elseif _ARG_0_.step == _UPVALUE15_ then
        if _ARG_0_.WorkNum == 0 and Player.IsDamageFlagDead(_ARG_0_.meaHandle) and Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 18 then
          _ARG_0_.WorkNum = 2
          print("\144H\142\150 \147f\130\171\143o\130\181\n")
          _ARG_0_:setPlDrop()
          return
        end
        if _ARG_0_.WorkNum == 0 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 20 then
            _ARG_0_.WorkNum = 1
            Player.SetDamage(_ARG_0_.meaHandle, Player.CalcDamagePoint(_ARG_0_.meaHandle, Enemy.GetAttackPoint(_ARG_0_.myHandle, 8), Enemy.GetAttackPowerCorrection(_ARG_0_.myHandle, 8)), ATK_KIND_DMG_BLOW)
          end
        elseif _ARG_0_.WorkNum == 1 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 21 then
          _ARG_0_.WorkNum = 2
          print("\144H\142\150 \147f\130\171\143o\130\181\n")
          _ARG_0_:setPlDrop()
        end
        Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.targetHandle)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
          _ARG_0_:GotoState("RandomMove")
          _ARG_0_.MealCount = 0
        end
      elseif _ARG_0_.step == _UPVALUE16_ then
        if Entity.IsWall(_ARG_0_.myHandle) then
          _ARG_0_.step = _UPVALUE0_
          Entity.SetTimer(_ARG_0_.myHandle, 300)
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE17_)
          _ARG_0_.Speed = 0
          Entity.ClearSpeed(_ARG_0_.myHandle)
          return
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_.step = _UPVALUE0_
          Entity.SetTimer(_ARG_0_.myHandle, 300)
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE17_)
          _ARG_0_.Speed = 0
          Entity.ClearSpeed(_ARG_0_.myHandle)
          return
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 2)
        _ARG_0_:Retreat(_UPVALUE18_)
      elseif _ARG_0_.step == _UPVALUE19_ then
        _ARG_0_.workVec0:set(0, 1, 0)
        if Entity.IsWall(_ARG_0_.myHandle) then
          _ARG_0_.step = _UPVALUE0_
          Entity.SetTimer(_ARG_0_.myHandle, 300)
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE17_)
          _ARG_0_.Speed = 0
          Entity.ClearSpeed(_ARG_0_.myHandle)
          return
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_.step = _UPVALUE0_
          Entity.SetTimer(_ARG_0_.myHandle, 300)
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE17_)
          _ARG_0_.Speed = 0
          Entity.ClearSpeed(_ARG_0_.myHandle)
          return
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 2)
        _ARG_0_:Advancement(_UPVALUE18_)
      else
        if _ARG_0_.step == _UPVALUE20_ then
          Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
          _ARG_0_.workVec0:set(1, 0, 0)
          Math.RotateVectorXYZ(_ARG_0_.workVec0, _ARG_0_.rot)
          Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
          FVECTOR3.Sub(_ARG_0_.workVec1, _ARG_0_.myPos, _ARG_0_.targetPos)
          _ARG_0_.workVec1:normalize()
          if _ARG_0_.workVec0:dot(_ARG_0_.workVec1) < -0.1 then
            Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE21_)
            _ARG_0_:Rotation(1)
          elseif 0.1 < _ARG_0_.workVec0:dot(_ARG_0_.workVec1) then
            Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE22_)
            _ARG_0_:Rotation(-1)
          elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) >= _UPVALUE6_ then
            _ARG_0_.step = _UPVALUE19_
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE23_)
          elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE6_ then
            _ARG_0_.step = _UPVALUE16_
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE24_)
          end
        else
        end
      end
    end
  },
  FallAttack = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.step = 0
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      Player.SetExCounter(_UPVALUE2_)
    end,
    OnEndState = function(_ARG_0_)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_.step = 1
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
          return
        end
      else
        if _ARG_0_.step == 1 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:ChangeState()
        else
        end
      end
    end
  },
  FallAttackAirTest = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
      _ARG_0_.stack:clear()
      _ARG_0_.stack:push(_UPVALUE1_)
      _ARG_0_.stack:push(_UPVALUE2_)
      _ARG_0_.stack:push(_UPVALUE3_)
      _ARG_0_.stack:push(_UPVALUE4_)
      _ARG_0_.stack:push(_UPVALUE5_)
      _ARG_0_.JumpPow = 0.47
      _ARG_0_.Gravity = 0.02
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      _ARG_0_.OnDamageFlagTest = 0
      Entity.EnableGravity(_ARG_0_.myHandle, 0)
    end,
    OnEndState = function(_ARG_0_)
      Entity.EnableGravity(_ARG_0_.myHandle, 1)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 12 then
          _ARG_0_.step = 1
          _ARG_0_.WorkVec:set(0, 0, 0)
          Entity.EnableGravity(_ARG_0_.myHandle, 0)
        end
      elseif _ARG_0_.step == 1 then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 3)
        _ARG_0_.JumpPow = _ARG_0_.JumpPow - _ARG_0_.Gravity * Entity.GetFrameRate(_ARG_0_.myHandle)
        _ARG_0_.WorkVec:sety(_ARG_0_.JumpPow)
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.WorkVec)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Entity.ClearSpeed(_ARG_0_.myHandle)
          Entity.SetMotion(_ARG_0_.myHandle, _ARG_0_.stack:pop(1))
          _ARG_0_.step = 2
        end
      elseif _ARG_0_.step == 2 then
        if _ARG_0_.OnDamageFlagTest == 1 then
          _ARG_0_.step = 4
          Entity.SetMotion(_ARG_0_.myHandle, _ARG_0_.stack:pop(1))
        end
      elseif _ARG_0_.step == 4 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Entity.EnableGravity(_ARG_0_.myHandle, 1)
          Entity.SetMotion(_ARG_0_.myHandle, _ARG_0_.stack:pop(1))
          _ARG_0_.step = 5
        end
      elseif _ARG_0_.step == 5 then
        if Entity.IsGround(_ARG_0_.myHandle) then
          Entity.ClearSpeed(_ARG_0_.myHandle)
          Entity.SetMotion(_ARG_0_.myHandle, _ARG_0_.stack:pop(1), _UPVALUE0_)
          Entity.SetAnimNowFrame(_ARG_0_.myHandle, 1)
          _ARG_0_.step = 6
          Entity.SetTimer(_ARG_0_.myHandle, 180)
        end
      elseif _ARG_0_.step == 6 then
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          Entity.SetMotion(_ARG_0_.myHandle, _ARG_0_.stack:pop(1))
          _ARG_0_.step = 7
        end
      else
        if _ARG_0_.step == 7 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:ChangeState()
        else
        end
      end
    end
  },
  CounterDamgage = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.stack:clear()
      if Enemy.IsAttackerFront(_ARG_0_.myHandle) == 1 then
        _ARG_0_.stack:push(_UPVALUE0_)
        _ARG_0_.stack:push(_UPVALUE1_)
        Entity.SetMotion(_ARG_0_.myHandle, _ARG_0_.stack:pop(1))
      else
        _ARG_0_.stack:push(_UPVALUE2_)
        _ARG_0_.stack:push(_UPVALUE3_)
        Entity.SetMotion(_ARG_0_.myHandle, _ARG_0_.stack:pop(1))
      end
      Entity.SetTimer(_ARG_0_.myHandle, 180)
      _ARG_0_.step = 0
      Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.targetHandle, 2)
      Enemy.MakePrize(_ARG_0_.myHandle, _ARG_0_.myPos)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          Entity.SetMotion(_ARG_0_.myHandle, _ARG_0_.stack:pop(1))
          _ARG_0_.step = 1
        end
      elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:ChangeState()
      end
    end
  },
  Deadarena = {
    OnBeginState = function(_ARG_0_)
      print("Deadarena\n")
      Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 120)
      Entity.SetupModelFade(_ARG_0_.sonebyte[0].handle, 1, 0, 120)
      Entity.SetupModelFade(_ARG_0_.sonebyte[1].handle, 1, 0, 120)
      Entity.SetupModelFade(_ARG_0_.sonebyte[2].handle, 1, 0, 120)
      Enemy.Dead(_ARG_0_.sonebyte[0].handle)
      Enemy.Dead(_ARG_0_.sonebyte[1].handle)
      Enemy.Dead(_ARG_0_.sonebyte[2].handle)
      if Enemy.IsAttackerFront(_ARG_0_.myHandle) then
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      else
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
      end
      Entity.SetTimer(_ARG_0_.myHandle, 20)
      SetupBossDead(_ARG_0_.myHandle)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsTimeOver(_ARG_0_.myHandle) and _ARG_0_.captureFlag == 1 then
        _ARG_0_:setPlDropEnd(_ARG_0_.targetHandle)
        _ARG_0_.captureFlag = 0
      end
      if Entity.IsModelFade(_ARG_0_.myHandle) == false then
        Enemy.Dead(_ARG_0_.myHandle)
        Enemy.Dead(_ARG_0_.sonebyte[0].handle)
        Enemy.Dead(_ARG_0_.sonebyte[1].handle)
        Enemy.Dead(_ARG_0_.sonebyte[2].handle)
      end
    end
  },
  Standby = {
    OnBeginState = function(_ARG_0_)
      print("Standby\n")
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
    end,
    OnEndState = function(_ARG_0_)
      Entity.EnableLockon(_ARG_0_.myHandle, 1)
    end,
    OnUpdate = function(_ARG_0_)
      if Enemy.IsAllEnemyWaiting() == false then
        _ARG_0_:GotoState("Appear")
        Entity.EnableLockon(_ARG_0_.myHandle, 1)
      end
    end
  },
  StandbyArena = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
      Entity.SetAlpha(_ARG_0_.myHandle, 0)
      if Mission.IsFlagFinalRound() == 1 then
        _ARG_0_.step = 0
      else
        SetupAppearBegin(_ARG_0_.myHandle, -1, _UPVALUE0_, 1)
        _ARG_0_.step = 1
      end
    end,
    OnEndState = function(_ARG_0_)
      Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
      SetupAppearEnd(_ARG_0_.myHandle)
      Entity.SetAlpha(_ARG_0_.myHandle, 1)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
      if Entity.HasNetGameHandle(_ARG_0_.myHandle) and Enemy.IsNetworkMaster(_ARG_0_.myHandle) == false then
        return
      end
      if _ARG_0_.step == 0 then
        if Exusia.IsExistenceSchedule() then
          SetupAppearBegin(_ARG_0_.myHandle, -1, _UPVALUE0_, 1)
          _ARG_0_.step = 1
        end
      elseif Enemy.IsAllEnemyWaiting() == false then
        _ARG_0_:GotoState("Appear")
      end
    end
  },
  Dead = {
    OnBeginState = function(_ARG_0_)
      Entity.EnableLockon(_ARG_0_.myHandle, 0)
      Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 120)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsModelFade(_ARG_0_.myHandle) == false then
        Enemy.Dead(_ARG_0_.myHandle)
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
function b10cd00.IsTargetCapture(_ARG_0_, _ARG_1_)
  if Player.GetNetworkID(_ARG_1_) > 0 then
    Enemy.SetNetworkMaster(_ARG_0_.myHandle, 0)
    return true
  end
  Enemy.SetNetworkMaster(_ARG_0_.myHandle, 1)
  return Player.IsDamageFlagCapture(_ARG_1_)
end
function b10cd00.Move(_ARG_0_, _ARG_1_)
  _ARG_0_.Speed = _ARG_0_.Speed + _ARG_1_ * 0.1 / 2 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_1_ < _ARG_0_.Speed then
    _ARG_0_.Speed = _ARG_1_
  end
  FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Speed)
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function b10cd00.SpinMove(_ARG_0_, _ARG_1_, _ARG_2_)
  _ARG_0_.Speed = _ARG_0_.Speed + _ARG_1_ * _ARG_2_ * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_1_ < _ARG_0_.Speed then
    _ARG_0_.Speed = _ARG_1_
  end
  FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Speed)
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function b10cd00.Advancement(_ARG_0_, _ARG_1_)
  _ARG_0_.Speed = _ARG_0_.Speed + _ARG_1_ * 0.1 / 2 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_1_ < _ARG_0_.Speed then
    _ARG_0_.Speed = _ARG_1_
  end
  FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Speed)
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function b10cd00.Retreat(_ARG_0_, _ARG_1_)
  _ARG_0_.Speed = _ARG_0_.Speed + _ARG_1_ * 0.1 / 2 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_1_ < _ARG_0_.Speed then
    _ARG_0_.Speed = _ARG_1_
  end
  FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, -_ARG_0_.Speed)
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function b10cd00.RightTurn(_ARG_0_, _ARG_1_)
  _ARG_0_.Speed = _ARG_0_.Speed + _ARG_1_ * 0.1 / 2 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_1_ < _ARG_0_.Speed then
    _ARG_0_.Speed = _ARG_1_
  end
  FVECTOR3.set(_ARG_0_.WorkVec, _ARG_0_.Speed, 0, 0)
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function b10cd00.LeftTurn(_ARG_0_, _ARG_1_)
  _ARG_0_.Speed = _ARG_0_.Speed + _ARG_1_ * 0.1 / 2 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_1_ < _ARG_0_.Speed then
    _ARG_0_.Speed = _ARG_1_
  end
  FVECTOR3.set(_ARG_0_.WorkVec, -_ARG_0_.Speed, 0, 0)
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function b10cd00.Rotation(_ARG_0_, _ARG_1_)
  if Entity.GetMotionNowFrame(_ARG_0_.myHandle) - Entity.GetMotionOldFrame(_ARG_0_.myHandle) < 0 then
  else
  end
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  _ARG_0_.rot:sety(RoundPI(_ARG_0_.rot:gety() + DegToRad((Entity.GetMotionNowFrame(_ARG_0_.myHandle) - Entity.GetMotionOldFrame(_ARG_0_.myHandle)) * (90 / Entity.GetMotionTotalFrame(_ARG_0_.myHandle))) * _ARG_1_))
  Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
  return DegToRad((Entity.GetMotionNowFrame(_ARG_0_.myHandle) - Entity.GetMotionOldFrame(_ARG_0_.myHandle)) * (90 / Entity.GetMotionTotalFrame(_ARG_0_.myHandle))) * _ARG_1_
end
function b10cd00.RotationEx(_ARG_0_, _ARG_1_, _ARG_2_)
  if Entity.GetMotionNowFrame(_ARG_2_) - Entity.GetMotionOldFrame(_ARG_2_) < 0 then
  else
  end
  Entity.GetRot(_ARG_0_.rot, handlee)
  _ARG_0_.rot:sety(RoundPI(_ARG_0_.rot:gety() + DegToRad((Entity.GetMotionNowFrame(_ARG_2_) - Entity.GetMotionOldFrame(_ARG_2_)) * (90 / Entity.GetMotionTotalFrame(_ARG_2_))) * _ARG_1_))
  Entity.SetRot(_ARG_2_, _ARG_0_.rot)
  return DegToRad((Entity.GetMotionNowFrame(_ARG_2_) - Entity.GetMotionOldFrame(_ARG_2_)) * (90 / Entity.GetMotionTotalFrame(_ARG_2_))) * _ARG_1_
end
function b10cd00.RotationSet(_ARG_0_, _ARG_1_)
  Entity.GetRot(_ARG_0_.WorkVec, _ARG_0_.myHandle)
  _ARG_0_.WorkVec:set(0, _ARG_0_.WorkVec:gety() + _ARG_1_, 0)
  Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function b10cd00.setPlDrop(_ARG_0_)
  Player.DispOn(_ARG_0_.meaHandle)
  Player.SetDamage(_ARG_0_.meaHandle, Player.CalcDamagePoint(_ARG_0_.meaHandle, Enemy.GetAttackPoint(_ARG_0_.myHandle, 8), Enemy.GetAttackPowerCorrection(_ARG_0_.myHandle, 8)), ATK_KIND_DMG_BLOW)
  Entity.SetupModelFade(_ARG_0_.meaHandle, 1, 1, 1)
  Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
  Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.myHandle, 0)
  _ARG_0_.workVec1:sety(_ARG_0_.workVec0:gety() - 0.1)
  Entity.GetWorldPos(_ARG_0_.workVec1, _ARG_0_.meaHandle)
  Entity.SetOldLocalPos(_ARG_0_.meaHandle, _ARG_0_.workVec0)
  Entity.SetLocalPos(_ARG_0_.meaHandle, _ARG_0_.workVec1)
  _ARG_0_.workVec0:set(1, 1, 1)
  Entity.SetScale(_ARG_0_.meaHandle, _ARG_0_.workVec0)
  Entity.AttachCoord(NULL_HANDLE, "", _ARG_0_.meaHandle, "Root")
  Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle, 3)
  Entity.SetLocalPos(_ARG_0_.meaHandle, _ARG_0_.myPos)
  Entity.SetOldLocalPos(_ARG_0_.meaHandle, _ARG_0_.myPos)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  _ARG_0_.rot:sety(RoundPI(_ARG_0_.rot:gety() + DegToRad(180)))
  Entity.SetRot(handle, _ARG_0_.rot)
end
function b10cd00.setPlDropEnd(_ARG_0_)
  Player.DispOn(_ARG_0_.meaHandle)
  Player.SetDamage(_ARG_0_.meaHandle, Player.CalcDamagePoint(_ARG_0_.meaHandle, Enemy.GetAttackPoint(_ARG_0_.myHandle, 8), Enemy.GetAttackPowerCorrection(_ARG_0_.myHandle, 8)), ATK_KIND_DMG_BLOW)
  Entity.SetupModelFade(_ARG_0_.meaHandle, 1, 1, 1)
  Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
  Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.myHandle, 0)
  _ARG_0_.workVec1:sety(_ARG_0_.workVec0:gety() - 0.1)
  Entity.GetWorldPos(_ARG_0_.workVec1, _ARG_0_.meaHandle)
  Entity.SetOldLocalPos(_ARG_0_.meaHandle, _ARG_0_.workVec0)
  Entity.SetLocalPos(_ARG_0_.meaHandle, _ARG_0_.workVec1)
  _ARG_0_.workVec0:set(1, 1, 1)
  Entity.SetScale(_ARG_0_.meaHandle, _ARG_0_.workVec0)
  Entity.AttachCoord(NULL_HANDLE, "", _ARG_0_.meaHandle, "Root")
  _ARG_0_.workVec0:set(0, 0, 3)
  Entity.GetWorldPos2(_ARG_0_.myPos, _ARG_0_.myHandle, _ARG_0_.workVec0, 0)
  Entity.SetLocalPos(_ARG_0_.meaHandle, _ARG_0_.myPos)
  Entity.SetOldLocalPos(_ARG_0_.meaHandle, _ARG_0_.myPos)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  _ARG_0_.rot:sety(_ARG_0_.rot:gety() + DegToRad(180))
  Entity.SetRot(handle, _ARG_0_.rot)
end
function b10cd00.setPlDropEx(_ARG_0_, _ARG_1_)
  Player.SetDamage(_ARG_0_.meaHandle, Player.CalcDamagePoint(_ARG_0_.meaHandle, Enemy.GetAttackPoint(_ARG_0_.myHandle, 8), Enemy.GetAttackPowerCorrection(_ARG_0_.myHandle, 8)), ATK_KIND_DMG_BLOW)
  Player.DispOn(_ARG_0_.meaHandle)
  Entity.SetupModelFade(_ARG_0_.meaHandle, 1, 1, 1)
  Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
  Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.myHandle, 0)
  _ARG_0_.workVec1:sety(_ARG_0_.workVec0:gety() - 0.1)
  Entity.GetWorldPos(_ARG_0_.workVec1, _ARG_0_.meaHandle)
  Entity.SetOldLocalPos(_ARG_1_, _ARG_0_.workVec0)
  Entity.SetLocalPos(_ARG_1_, _ARG_0_.workVec1)
  _ARG_0_.workVec0:set(1, 1, 1)
  Entity.SetScale(_ARG_1_, _ARG_0_.workVec0)
  Entity.AttachCoord(NULL_HANDLE, "", _ARG_1_, "Root")
  Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle, 3)
  Entity.SetLocalPos(_ARG_0_.meaHandle, _ARG_0_.myPos)
  Entity.SetOldLocalPos(_ARG_0_.meaHandle, _ARG_0_.myPos)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  _ARG_0_.rot:sety(_ARG_0_.rot:gety() + DegToRad(180))
  Entity.SetRot(_ARG_0_.meaHandle, _ARG_0_.rot)
end
function b10cd00.ChangeState(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_0_:GotoState(_ARG_1_)
  else
    _ARG_0_:GotoState("Idling")
  end
end
function b10cd00.RestHpRate(_ARG_0_)
  return Enemy.GetHp(_ARG_0_.myHandle) / Enemy.GetHpMax(_ARG_0_.myHandle)
end
function b10cd00.IsSonebyteAlive(_ARG_0_)
  for _FORV_5_ = 0, 2 do
  end
  if 2 < 0 + 1 then
    return true
  end
  return false
end
function b10cd00.GetTargetHandle(_ARG_0_)
  return _ARG_0_.targetHandle
end
function b10cd00.InhaleForPlayer(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_)
  for _FORV_11_, _FORV_12_ in pairs(EntityManager.entities) do
    if (Entity.GetName(_FORV_11_) == "m91ex00" or Entity.GetName(_FORV_11_) == "m92ex00" or Entity.GetName(_FORV_11_) == "m93ex00" or Entity.GetName(_FORV_11_) == "m94ex00" or Entity.GetName(_FORV_11_) == "m95ex00") and Player.GetNetworkID(Entity.GetParent(_FORV_11_)) == 0 and Enemy.IsIllusionGroundIn(_FORV_11_) == false then
      print("\131C\131\138\131\133\129[\131W\131\135\131\147\146\134\129H")
      break
    end
  end
  if _FORV_11_ == NULL_HANDLE then
    if Player.IsMuteki(_ARG_1_) then
      _UPVALUE0_:set(0, 0, 0)
      Entity.SetForce(_ARG_1_, _UPVALUE0_)
      return false
    end
  else
    _ARG_1_ = _FORV_11_
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
function b10cd00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.sonehandle = NULL_HANDLE
  _ARG_0_.step = 0
  _ARG_0_.targetHandle = NULL_HANDLE
  _ARG_0_.soneHandle = NULL_HANDLE
  _ARG_0_.meaHandle = NULL_HANDLE
  _ARG_0_.MoveFlag = 0
  _ARG_0_.Speed = 0
  _ARG_0_.count = 0
  _ARG_0_.sonebyteLoadFlag = 0
  _ARG_0_.DamageCnt = 0
  _ARG_0_.GuardFlag = 0
  _ARG_0_.RushFlag = 0
  _ARG_0_.AttackFlag = 0
  _ARG_0_.AttackCnt = 0
  _ARG_0_.JumpPow = 0
  _ARG_0_.Gravityq = 0
  _ARG_0_.Bombflag = 0
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkTime = 0
  _ARG_0_.InhalingTime = 0
  _ARG_0_.InhalingStartFlag = 0
  _ARG_0_.SpinStopFlag = 0
  _ARG_0_.SpinNoStopTime = 0
  _ARG_0_.MealCount = 0
  _ARG_0_.DamagePoint = 0
  _ARG_0_.BlowCounterFlag = 0
  _ARG_0_.HomingAng = 0
  _ARG_0_.DivDist = 0
  _ARG_0_.JumpPow = 0
  _ARG_0_.Gravity = 0
  _ARG_0_.workstep = 0
  _ARG_0_.captureFlag = 0
  _ARG_0_.SpinEffectHandle = NULL_HANDLE
  _ARG_0_.SpinEffectFlag = 0
  _ARG_0_.SpinEffectCnt = 0
  _ARG_0_.RandomMoveAng = 0
  _ARG_0_.notCheckTime = 0
  _ARG_0_.OnDamageFlagTest = 0
  _ARG_0_.SonebyteDelay = 0
  _ARG_0_.WorkNum = 0
  _ARG_0_.WorkNum1 = 0
  _ARG_0_.WorkTime = 0
  _ARG_0_.WorkVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec0 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
  _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.cameraPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.stack = Stack:Create()
  _ARG_0_.stackState = Stack:Create()
  _ARG_0_.sonebyte = {}
  _ARG_0_.sonebyte[0] = {handle = NULL_HANDLE, Groundflag = 0}
  _ARG_0_.sonebyte[1] = {handle = NULL_HANDLE, Groundflag = 0}
  _ARG_0_.sonebyte[2] = {handle = NULL_HANDLE, Groundflag = 0}
  if _UPVALUE0_ == false then
    _UPVALUE1_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "Action1Dist") * Enemy.GetExtraParam(_ARG_0_.myHandle, "Action1Dist")
    _UPVALUE2_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "Action2Dist") * Enemy.GetExtraParam(_ARG_0_.myHandle, "Action2Dist")
    _UPVALUE3_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "DamageCnt")
    _UPVALUE4_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "MealCount")
    _UPVALUE5_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "IdlingTime")
    _UPVALUE6_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "FallTime") * 60
    _UPVALUE7_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "BombNum")
    _UPVALUE8_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "MealTime") * 60
    _UPVALUE9_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "DownPoint")
    _UPVALUE10_ = 0.32534245 * Enemy.GetExtraParam(_ARG_0_.myHandle, "SpringMag")
    _UPVALUE11_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "MealAngle")
    _UPVALUE12_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "GabuDF")
    _UPVALUE13_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "SpinHDist") * Enemy.GetExtraParam(_ARG_0_.myHandle, "SpinHDist")
    _UPVALUE14_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "SpinHDist") * Enemy.GetExtraParam(_ARG_0_.myHandle, "SpinHDist")
    _UPVALUE14_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "MealDist") * Enemy.GetExtraParam(_ARG_0_.myHandle, "MealDist")
    _UPVALUE15_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "MealPower")
    _UPVALUE16_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "SoneBomD") * 60
    _UPVALUE17_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "SpringNum")
    _UPVALUE18_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "SpringHNum")
    _UPVALUE19_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "ActionR_A") * 0.01
    _UPVALUE20_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "ActionR_B") * 0.01
    _UPVALUE21_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "BombMotCnt")
    _UPVALUE22_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "ChangeHP") * 0.01
    _UPVALUE23_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "SpringDleay")
    _UPVALUE24_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "SAttackDle")
    _UPVALUE25_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "InhalingT") * 60
    _UPVALUE26_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "FastSBTime") * 60
    _UPVALUE27_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "CounterRate") * 0.01
    _UPVALUE0_ = true
  end
  Entity.SetMovementCollRadius(_ARG_0_.myHandle, 2.5)
  Entity.SetLowerHalf(_ARG_0_.myHandle, 3.7)
  Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
  Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
  Entity.EnableLockon(_ARG_0_.myHandle, 0)
  Entity.EnableGravity(_ARG_0_.myHandle, 1)
  Player.SetBossCamera("b10cd")
  Enemy.IsAllEnemyWaiting()
  Entity.SetDropShadowDistance(_ARG_0_.myHandle, 80)
  Entity.SetDropShadowTextureSize(_ARG_0_.myHandle, 256)
  if Enemy.IsAllEnemyWaiting() == true then
    if Entity.GetName(_ARG_0_.myHandle) == "b40vs00" then
      _ARG_0_:GotoStateSub("StandbyArena")
    else
      _ARG_0_:GotoState("Standby")
    end
  else
    _ARG_0_:GotoState("Appear")
    Entity.EnableLockon(_ARG_0_.myHandle, 1)
  end
end
function b10cd00.OnDamage(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if _ARG_0_:GetState() == "CounterDamgage" and _ARG_2_ == 6 then
    _ARG_0_:GotoState("FallAttack")
    return
  end
  if _ARG_0_:GetState() == "FallAttackAirTest" then
    _ARG_0_.OnDamageFlagTest = 1
  end
end
function b10cd00.OnReturnDamage(_ARG_0_)
  if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 49 then
    if _ARG_0_.BlowCounterFlag == 1 then
      _ARG_0_:GotoState("Tentacle_Attack_Counter")
      _ARG_0_.BlowCounterFlag = 0
    else
      _ARG_0_:GotoState("Idling")
    end
    return
  end
  _ARG_0_:GotoState("Idling")
end
function b10cd00.OnHitAttack(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if _ARG_0_:GetState() == "SpringPress" or _ARG_0_:GetState() == "SpinrushEx" then
  end
  _ARG_0_.meaHandle = _ARG_1_
  _ARG_0_.AttackFlag = 1
  if _ARG_3_ == ATK_KIND_CAPTURE then
    _ARG_0_.captureFlag = 1
  end
  print("b10cd00:OnHitAttack()\n")
end
function b10cd00.OnReflect(_ARG_0_)
  if _ARG_0_:GetState() == "SpinrushEx" then
    _ARG_0_:GotoState("CounterDamgage")
  end
end
function b10cd00.OnSetupBlow(_ARG_0_)
  _ARG_0_.BlowCounterFlag = 0
  if Script.Random() < _UPVALUE0_ then
    _ARG_0_.BlowCounterFlag = 1
  else
    _ARG_0_.BlowCounterFlag = 0
  end
  Effect.KillEffect(_ARG_0_.SpinEffectHandle)
  Entity.EnableGravity(_ARG_0_.myHandle, 1)
  Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
end
function b10cd00.OnDestroy(_ARG_0_)
  print("b10cd00:OnDestroy()\n")
  print("self.captureFlag = " .. _ARG_0_.captureFlag .. "\n")
  if _ARG_0_.captureFlag == 1 then
    _ARG_0_:setPlDropEnd(_ARG_0_.targetHandle)
    _ARG_0_.captureFlag = 0
  end
end
function b10cd00.OnDead(_ARG_0_)
  if _ARG_0_:GetState() == "MealGabuGabuMaster" then
    _ARG_0_:setPlDropEnd(_ARG_0_.targetHandle)
  end
  if Enemy.IsAttackerFront(_ARG_0_.myHandle) then
    Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
  else
    Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
  end
  Player.SetExCounter(_UPVALUE2_)
  if Entity.GetName(_ARG_0_.myHandle) == "b40vs00" then
    if Mission.IsFlagFinalRound() == 1 then
      print("\131t\131@\131C\131i\131\139\131\137\131E\131\147\131h\130\197\130\183\129B\129I\129I")
      if _ARG_0_.captureFlag == 1 then
        _ARG_0_:setPlDropEnd(_ARG_0_.targetHandle)
        _ARG_0_.captureFlag = 0
      end
      SetupBossDead(_ARG_0_.myHandle)
    else
      print("\131t\131@\131C\131i\131\139\131\137\131E\131\147\131h\130\182\130\225\130\200\130\162\130\169\130\231\146\202\143\237\143\136\151\157\129I\129I")
      _ARG_0_:GotoStateSub("Deadarena")
    end
    return 1
  else
    _ARG_0_:GotoState("Dead")
    SetupBossDead(_ARG_0_.myHandle)
  end
  return 1
end
function b10cd00.Debug(_ARG_0_)
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
function b10cd00.OnUpdate(_ARG_0_)
  _ARG_0_:Update()
  _ARG_0_:Debug()
  if _ARG_0_:IsSonebyteAlive() == true then
    _ARG_0_.SonebyteDelay = _ARG_0_.SonebyteDelay - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
  end
  if _ARG_0_.DamagePoint < 0 then
    _ARG_0_.DamagePoint = 0
  else
    _ARG_0_.DamagePoint = _ARG_0_.DamagePoint - _UPVALUE0_ / 60 * Entity.GetFrameRate(_ARG_0_.myHandle)
  end
end
EntityFactory:Add("b10cd00", function(_ARG_0_)
  EntityManager:Add(b10cd00:new(), _ARG_0_)
  return (b10cd00:new())
end)
EntityFactory:Add("b40vs00", function(_ARG_0_)
  EntityManager:Add(b10cd00:new(), _ARG_0_)
  return (b10cd00:new())
end)
b10cd00b = {}
b10cd00b_mt = {__index = b10cd00b}
function b10cd00b.new(_ARG_0_)
  return setmetatable({}, b10cd00b_mt)
end
function b10cd00b.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.masterHandle = NULL_HANDLE
  _ARG_0_.step = 0
  Bullet.CreateEffectBullet(_ARG_1_, "b10cd00", "B004_PLS_00_0")
  Bullet.SetHitAttackEffectName(_ARG_1_, "b10cd00", "B004_HIT_00_0")
  Bullet.EnableNoCheckHitBg(_ARG_1_, 0)
  Bullet.SetCollision(_ARG_1_, COLL_KIND_ENEMY, COLL_SHAPE_CYLINDER, 1, 1)
  Bullet.SetAddCollRadius(_ARG_1_, 0.2)
end
function b10cd00b.OnHitAttack(_ARG_0_)
end
function b10cd00b.OnReflect(_ARG_0_)
  if _ARG_0_.masterHandle ~= 0 then
    EntityManager:GetEntity(_ARG_0_.masterHandle):GotoState("CounterDamgage")
  end
end
function b10cd00b.OnUpdate(_ARG_0_)
  if _ARG_0_.step == 0 then
    if Effect.GetNowFrame((Bullet.GetEffectHandle(_ARG_0_.myHandle))) >= 20 then
      Bullet.SetAddCollRadius(_ARG_0_.myHandle, 0)
      _ARG_0_.step = _ARG_0_.step + 1
    end
  elseif _ARG_0_.step == 1 and Effect.GetNowFrame((Bullet.GetEffectHandle(_ARG_0_.myHandle))) >= 45 then
    Bullet.EnableAttackCollision(_ARG_0_.myHandle, 0)
    _ARG_0_.step = _ARG_0_.step + 1
  end
end
EntityFactory:Add("b10cd00b", function(_ARG_0_)
  return (b10cd00b:new())
end)
