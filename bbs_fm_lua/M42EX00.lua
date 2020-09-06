WorkVec = FVECTOR3.new(0, 0, 0)
WorkVec0 = FVECTOR3.new(0, 0, 0)
WorkVec1 = FVECTOR3.new(0, 0, 0)
WorkVec2 = FVECTOR3.new(0, 0, 0)
WorkVec3 = FVECTOR3.new(0, 0, 0)
WorkVec4 = FVECTOR3.new(0, 0, 0)
WorkRot = FVECTOR3.new(0, 0, 0)
M42EX_INIT_PARAM = false
setmetatable({
  new = function(_ARG_0_)
    return setmetatable(__StateMachine:new(), _UPVALUE0_)
  end,
  states = {
    Fly = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.GetVelocity(WorkVec0, _ARG_0_.myHandle)
          if 0 > WorkVec0:gety() then
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if Entity.IsGround(_ARG_0_.myHandle) then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.step = 2
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    Appear = {
      OnBeginState = function(_ARG_0_)
        SetupAppearBegin(_ARG_0_.myHandle, 40, _UPVALUE0_, 0)
        _ARG_0_.NowScale:set(0, 0, 0)
        _ARG_0_.Count = 0
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        SetupAppearEnd(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          _ARG_0_.Count = _ARG_0_.Count + 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
          if 1 < 1 / (Entity.GetMotionTotalFrame(_ARG_0_.myHandle) * 0.8) * _ARG_0_.Count then
            _ARG_0_.step = 1
            _ARG_0_.Count = 0
          end
          _ARG_0_.NowScale:set(1 / (Entity.GetMotionTotalFrame(_ARG_0_.myHandle) * 0.8) * _ARG_0_.Count, 1, 1)
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    Idling = {
      OnBeginState = function(_ARG_0_)
        print("m42ex00:Idling\n")
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_ + Script.Random() * 60)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
          return
        end
        _ARG_0_:GotoState("BatlleStart")
      end
    },
    Idling2 = {
      OnBeginState = function(_ARG_0_)
        print("m42ex00:Idling2\n")
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
          return
        end
        if _ARG_0_.attackEndCnt >= _UPVALUE0_ then
          _ARG_0_.attackEndCnt = 0
          _ARG_0_:GotoState("Move")
        else
          _ARG_0_:GotoState("AttackSelect")
        end
      end
    },
    BatlleStart = {
      OnBeginState = function(_ARG_0_)
        print("m42ex00:BatlleStart\n")
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Move")
        end
      end
    },
    AttackSelect = {
      OnBeginState = function(_ARG_0_)
        print("m42ex00:AttackSelect\n")
        _ARG_0_.step = 0
        _ARG_0_.attackEndCnt = _ARG_0_.attackEndCnt + 1
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE0_ then
          if Script.Random() < _UPVALUE1_ then
            _ARG_0_:GotoState("Ranbu")
          else
            _ARG_0_:GotoState("Bite")
          end
        elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE2_ then
          if Script.Random() < _UPVALUE3_ then
            _ARG_0_:GotoState("DarkCnage")
          else
            _ARG_0_:GotoState("Bite")
          end
        else
          _ARG_0_:GotoState("Disappear")
          return
        end
      end
    },
    Move = {
      OnBeginState = function(_ARG_0_)
        print("m42ex00:Move\n")
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_ + 60 * (Script.Random() * 5))
        _ARG_0_.step = 0
        _ARG_0_.time = 60 * (Script.Random() * 5 + 10)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE1_)
        _ARG_0_.SpeedY = 0
        _ARG_0_.SpeedX = 0
        _ARG_0_.SpeedY = 0
        _ARG_0_.SpeedZ = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("AttackSelect")
          return
        end
        _ARG_0_.time = _ARG_0_.time - Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.time <= 0 then
          if Script.Random() < 0.5 then
            _ARG_0_.step = _UPVALUE0_
          else
            _ARG_0_.step = _UPVALUE1_
          end
          _ARG_0_.time = 60 * (Script.Random() * 5 + 10)
        end
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE2_ then
          if Script.Random() < 0.5 then
            _ARG_0_.step = _UPVALUE0_
          else
            _ARG_0_.step = _UPVALUE1_
          end
        elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _UPVALUE2_ + 6.25 then
          _ARG_0_.step = _UPVALUE3_
        end
        if 0 >= _ARG_0_.time2 or Entity.GetFloorDistance(_ARG_0_.myHandle) < 0.1 or Entity.GetFloorDistance(_ARG_0_.myHandle) > 1 then
          if 0.5 > Entity.GetFloorDistance(_ARG_0_.myHandle) then
            _ARG_0_.HeightFlag = 0
          elseif Entity.GetFloorDistance(_ARG_0_.myHandle) > 2 then
            _ARG_0_.HeightFlag = 1
          else
            if Script.Random() < 0.5 then
              _ARG_0_.HeightFlag = 0
            else
              _ARG_0_.HeightFlag = 1
            end
            _ARG_0_.time2 = Script.Random() * 120 + 60
          end
        end
        if _ARG_0_.HeightFlag == 0 then
          _ARG_0_.SpeedY = _ARG_0_.SpeedY + 0.1 * Entity.GetFrameRate(_ARG_0_.myHandle)
          if _ARG_0_.SpeedY > _UPVALUE4_ then
            _ARG_0_.SpeedY = _UPVALUE4_
          end
        else
          _ARG_0_.SpeedY = _ARG_0_.SpeedY - 0.1 * Entity.GetFrameRate(_ARG_0_.myHandle)
          if _ARG_0_.SpeedY < -_UPVALUE4_ then
            _ARG_0_.SpeedY = -_UPVALUE4_
          end
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 30)
        if _ARG_0_.step == _UPVALUE0_ then
          _ARG_0_:MoveRight_Left(_UPVALUE5_, 0.05, _UPVALUE0_)
        elseif _ARG_0_.step == _UPVALUE1_ then
          _ARG_0_:MoveRight_Left(_UPVALUE5_, 0.05, _UPVALUE1_)
        elseif _ARG_0_.step == _UPVALUE3_ then
          _ARG_0_:MoveRight_Left(_UPVALUE6_, 0.1, _UPVALUE3_)
        end
      end
    },
    Bite = {
      OnBeginState = function(_ARG_0_)
        print("m42ex00:Bite\n")
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            Entity.SetTimer(_ARG_0_.myHandle, Math.Sqrt((Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle))) / (_UPVALUE1_ * Entity.GetFrameRate(_ARG_0_.myHandle)) + 60)
            _ARG_0_.step = 1
            _ARG_0_.SpeedZ = 0
          end
        elseif _ARG_0_.step == 1 then
          _ARG_0_:MoveAir(_UPVALUE1_, 0.1)
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
            _ARG_0_.step = 2
            Entity.ClearSpeed(_ARG_0_.myHandle)
          end
        elseif _ARG_0_.step == 2 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling2")
        end
      end
    },
    Ranbu = {
      OnBeginState = function(_ARG_0_)
        print("m42ex00:Ranbu\n")
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.SpeedZ = 0
        _ARG_0_.step = 0
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 13 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) < 33 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          _ARG_0_:MoveAir(0.1, 0.1)
        else
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          Entity.ClearSpeed(_ARG_0_.myHandle)
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Entity.ClearSpeed(_ARG_0_.myHandle)
          _ARG_0_:GotoState("Idling2")
        end
      end
    },
    DarkCnage = {
      OnBeginState = function(_ARG_0_)
        print("m42ex00:DarkCnage\n")
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.SpeedZ = 0
        _ARG_0_.step = 0
        _ARG_0_.Count = 0
        _ARG_0_.NowScale:set(1, 1, 1)
        _ARG_0_:crateEffect("E035_PAS_00_0", "atama")
        Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
        Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, Entity.GetMotionTotalFrame(_ARG_0_.myHandle) * 10)
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetupModelFade(_ARG_0_.myHandle, 0, 0, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          _ARG_0_.Count = _ARG_0_.Count + 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
          _ARG_0_.NowScale:set(0.01, 0.01, 0.01)
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Entity.ClearSpeed(_ARG_0_.myHandle)
          _ARG_0_:GotoState("DarkMove")
        end
      end
    },
    DarkMove = {
      OnBeginState = function(_ARG_0_)
        print("m42ex00:DarkMove\n")
        Entity.SetTimer(_ARG_0_.myHandle, 0)
        _ARG_0_.step = 0
        _ARG_0_.DarkEffectHandle = _ARG_0_:crateEffect("E035_YAM_00_0", "atama")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Effect.LoopEnd(_ARG_0_.DarkEffectHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
          _ARG_0_.step = 1
        elseif _ARG_0_.step == 1 then
          _ARG_0_:MoveAirDown(0.1, 0.1)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          _ARG_0_:MoveAir(0.1, 0.05)
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_.step = 0
          end
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 2.5600002 then
            _ARG_0_:GotoState("DarkAttack")
          end
        end
      end
    },
    DarkAttack = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 1)
        _ARG_0_:crateEffect("E035_SIK_00_0", "atama")
        _ARG_0_.SpeedZ = 0
        _ARG_0_.step = 0
        _ARG_0_.Count = 0
        Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
        _ARG_0_.NowScale:set(0.001, 0.001, 0.001)
        Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, Entity.GetMotionTotalFrame(_ARG_0_.myHandle) / 3 / 2)
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        _ARG_0_.NowScale:set(1, 1, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          _ARG_0_.Count = _ARG_0_.Count + 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
          if _UPVALUE0_ < 1 / 13 * _ARG_0_.Count then
            _ARG_0_.step = 1
            _ARG_0_.Count = 0
          end
          _ARG_0_.NowScale:set(_UPVALUE0_, _UPVALUE0_, _UPVALUE0_)
        elseif _ARG_0_.step == 1 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          _ARG_0_.Count = _ARG_0_.Count + 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
          _ARG_0_.NowScale:set(1, 1, 1)
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            print("scale_x = " .. 1 .. "\n")
            print("scale_y = " .. 1 .. "\n")
            print("scale_z = " .. 1 .. "\n")
            _ARG_0_:GotoState("Idling2")
          end
        elseif _ARG_0_.step == 2 then
        end
      end
    },
    Standby = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableLockon(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if Enemy.IsAllEnemyWaiting() == false then
          _ARG_0_:GotoState("Idling")
          Entity.EnableLockon(_ARG_0_.myHandle, 1)
        end
      end
    },
    Dead = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_:crateSetEffect("E035_DTH_00_0", "atama")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
      end
    },
    MissionIdling = {
      OnBeginState = function(_ARG_0_)
        Entity.SetLowerHalf(_ARG_0_.myHandle, 1.1)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        Entity.EnableGravity(_ARG_0_.myHandle, 0)
        Entity.SetupModelFade(_ARG_0_.myHandle, 0, 0, 0)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
      end
    },
    Disappear = {
      OnBeginState = function(_ARG_0_)
        print("m42ex00:Disappear\n")
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.SpeedZ = 0
        _ARG_0_.step = 0
        _ARG_0_.Count = 0
        _ARG_0_.NowScale:set(1, 1, 1)
        _ARG_0_.DarkEffectHandle = _ARG_0_:crateEffect("E035_HOL_00_0", "atama")
        Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        Entity.LoopEndBSEffect(_ARG_0_.myHandle)
      end,
      OnEndState = function(_ARG_0_)
        Entity.MoveStartPos(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          _ARG_0_.Count = _ARG_0_.Count + 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
          _ARG_0_.NowScale:set(0.01, 0.01, 0.01)
        end
        if Effect.IsAlive(_ARG_0_.DarkEffectHandle) == false then
          Entity.ClearSpeed(_ARG_0_.myHandle)
          Enemy.Disappear(_ARG_0_.myHandle)
        end
      end
    }
  },
  MoveAir = function(_ARG_0_, _ARG_1_, _ARG_2_)
    _ARG_0_.SpeedZ = _ARG_0_.SpeedZ + _ARG_1_ * _ARG_2_ * Entity.GetFrameRate(_ARG_0_.myHandle)
    if _ARG_1_ < _ARG_0_.SpeedZ then
      _ARG_0_.SpeedZ = _ARG_1_
    end
    FVECTOR3.set(WorkVec, 0, 0, _ARG_0_.SpeedZ)
    Entity.CalcVelocity(_ARG_0_.myHandle, WorkVec)
  end,
  MoveAirDown = function(_ARG_0_, _ARG_1_, _ARG_2_)
    _ARG_0_.SpeedZ = _ARG_0_.SpeedZ - _ARG_1_ * _ARG_2_ * Entity.GetFrameRate(_ARG_0_.myHandle)
    if _ARG_0_.SpeedZ < 0 then
      _ARG_0_.SpeedZ = 0
    end
    FVECTOR3.set(WorkVec, 0, 0, _ARG_0_.SpeedZ)
    Entity.CalcVelocity(_ARG_0_.myHandle, WorkVec)
  end,
  MoveRight_Left = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    if _ARG_3_ == _UPVALUE0_ then
      _ARG_0_.SpeedX = _ARG_0_.SpeedX + _ARG_1_ * _ARG_2_ * Entity.GetFrameRate(_ARG_0_.myHandle)
      if _ARG_1_ < _ARG_0_.SpeedX then
        _ARG_0_.SpeedX = _ARG_1_
      end
      _ARG_0_.SpeedZ = HomingDegree(_ARG_0_.SpeedZ, 0, 0.1, (Entity.GetFrameRate(_ARG_0_.myHandle)))
    elseif _ARG_3_ == _UPVALUE1_ then
      _ARG_0_.SpeedX = _ARG_0_.SpeedX - _ARG_1_ * _ARG_2_ * Entity.GetFrameRate(_ARG_0_.myHandle)
      if _ARG_0_.SpeedX < -_ARG_1_ then
        _ARG_0_.SpeedX = -_ARG_1_
      end
      _ARG_0_.SpeedZ = HomingDegree(_ARG_0_.SpeedZ, 0, 0.1, (Entity.GetFrameRate(_ARG_0_.myHandle)))
    elseif _ARG_3_ == _UPVALUE2_ then
      _ARG_0_.SpeedZ = _ARG_0_.SpeedZ + _ARG_1_ * _ARG_2_ * Entity.GetFrameRate(_ARG_0_.myHandle)
      if _ARG_1_ < _ARG_0_.SpeedZ then
        _ARG_0_.SpeedZ = _ARG_1_
      end
      _ARG_0_.SpeedX = HomingDegree(_ARG_0_.SpeedX, 0, 0.05, (Entity.GetFrameRate(_ARG_0_.myHandle)))
    end
    Entity.GetRot(WorkRot, _ARG_0_.myHandle)
    WorkVec:set(_ARG_0_.SpeedX, 0, _ARG_0_.SpeedZ)
    Math.RotateVectorXYZ(WorkVec, WorkRot)
    Entity.SetVelocity(_ARG_0_.myHandle, WorkVec)
  end,
  crateEffect = function(_ARG_0_, _ARG_1_, _ARG_2_)
    WorkVec:set(0, 0, 0)
    Effect.SetAttachNoScale(Entity.AttachEffect(_ARG_0_.myHandle, "e_ex420", _ARG_1_, _ARG_2_, WorkVec, WorkVec), true)
    return (Entity.AttachEffect(_ARG_0_.myHandle, "e_ex420", _ARG_1_, _ARG_2_, WorkVec, WorkVec))
  end,
  crateSetEffect = function(_ARG_0_, _ARG_1_, _ARG_2_)
    Entity.GetWorldPos(WorkVec, _ARG_0_.myHandle, 2)
    WorkVec1:set(0, 0, 0)
    Entity.SetEffect(_ARG_0_.myHandle, "e_ex420", _ARG_1_, WorkVec, WorkVec1)
  end,
  CalcTargetVelocity = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    Entity.GetWorldPos(WorkVec0, _ARG_0_.myHandle)
    FVECTOR3.Sub(WorkVec1, _ARG_1_, WorkVec0)
    WorkVec1:normalize()
    FVECTOR3.Mul(WorkVec2, WorkVec1, WorkVec1)
    Entity.GetRot(WorkVec3, _ARG_0_.myHandle)
    WorkVec3:sety(HomingDegree(WorkVec3:gety(), Math.Atan2(WorkVec1:getx(), WorkVec1:getz()), _ARG_2_, (Entity.GetFrameRate(_ARG_0_.myHandle))))
    Entity.SetRot(_ARG_0_.myHandle, WorkVec3)
    WorkVec3:setx(-Math.Atan2(WorkVec1:gety(), Math.Sqrt(WorkVec2:getx() + WorkVec2:getz())))
    WorkVec4:set(0, 0, _ARG_3_)
    Math.RotateVectorXYZ(WorkVec4, WorkVec3)
    Entity.SetVelocity(_ARG_0_.myHandle, WorkVec4)
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    _ARG_0_.myHandle = _ARG_1_
    _UPVALUE0_ = Entity.GetMotionIndex(_ARG_1_, "001")
    _UPVALUE1_ = Entity.GetMotionIndex(_ARG_1_, "002")
    _UPVALUE2_ = Entity.GetMotionIndex(_ARG_1_, "010")
    _UPVALUE3_ = Entity.GetMotionIndex(_ARG_1_, "020")
    _UPVALUE4_ = Entity.GetMotionIndex(_ARG_1_, "300")
    _UPVALUE5_ = Entity.GetMotionIndex(_ARG_1_, "310")
    _UPVALUE6_ = Entity.GetMotionIndex(_ARG_1_, "311")
    _UPVALUE7_ = Entity.GetMotionIndex(_ARG_1_, "320")
    _UPVALUE8_ = Entity.GetMotionIndex(_ARG_1_, "330")
    _ARG_0_.step = 0
    _ARG_0_.targetHandle = NULL_HANDLE
    _ARG_0_.DarkEffectHandle = NULL_HANDLE
    _ARG_0_.SpeedX = 0
    _ARG_0_.SpeedY = 0
    _ARG_0_.SpeedZ = 0
    _ARG_0_.Count = 0
    _ARG_0_.time = 0
    _ARG_0_.time2 = 0
    _ARG_0_.Height = 0
    _ARG_0_.HeightFlag = 0
    _ARG_0_.attackEndCnt = 0
    if M42EX_INIT_PARAM == false then
      _UPVALUE9_ = Enemy.GetExtraParam(_ARG_1_, "RanbuRate") / 100
      _UPVALUE10_ = Enemy.GetExtraParam(_ARG_1_, "DarkChange") / 100
      _UPVALUE11_ = Enemy.GetExtraParam(_ARG_1_, "DistanceN1")
      _UPVALUE11_ = _UPVALUE11_ * _UPVALUE11_
      _UPVALUE12_ = Enemy.GetExtraParam(_ARG_1_, "DistanceN2")
      _UPVALUE12_ = _UPVALUE12_ * _UPVALUE12_
      _UPVALUE13_ = Enemy.GetExtraParam(_ARG_1_, "Delay1")
      _UPVALUE14_ = Enemy.GetExtraParam(_ARG_1_, "Delay2")
      _UPVALUE15_ = Enemy.GetExtraParam(_ARG_1_, "Delay3")
      _UPVALUE16_ = Enemy.GetExtraParam(_ARG_1_, "MoveFrame")
      _UPVALUE17_ = Enemy.GetExtraParam(_ARG_1_, "IdlingT") * 60
      _UPVALUE18_ = Enemy.GetExtraParam(_ARG_1_, "CounterR") * 0.01
      print("M42EX_RATE_RANBU = " .. _UPVALUE9_ .. "\n")
      print("M42EX_RATE_DARKCHANGE = " .. _UPVALUE10_ .. "\n")
      print("M42EX_DIST_ACTION_n1 = " .. _UPVALUE11_ .. "\n")
      print("M42EX_DIST_ACTION_n2 = " .. _UPVALUE12_ .. "\n")
      print("M42EX_TIME_DLEY1 = " .. _UPVALUE14_ .. "\n")
      print("M42EX_TIME_DLEY2 = " .. _UPVALUE14_ .. "\n")
      print("M42EX_TIME_DLEY3 = " .. _UPVALUE15_ .. "\n")
      print("M42EX_TIME_MOVE = " .. _UPVALUE16_ .. "\n")
      M42EX_INIT_PARAM = true
    end
    _ARG_0_.NowScale = FVECTOR3.new(1, 1, 1)
    _ARG_0_.playerPos = FVECTOR3.new(1, 1, 1)
    Entity.SetMovementCollRadius(_ARG_0_.myHandle, 1)
    Entity.SetLowerHalf(_ARG_0_.myHandle, 1.1)
    Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
    Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
    Entity.EnableLockon(_ARG_0_.myHandle, 0)
    Entity.EnableGravity(_ARG_0_.myHandle, 1)
    Enemy.IsAllEnemyWaiting()
    Entity.SetDropShadowDistance(_ARG_0_.myHandle, 80)
    _ARG_0_.uniqueID = Entity.GetLayoutParam(_ARG_1_, 9)
    print("uniqueID = " .. _ARG_0_.uniqueID .. "\n")
    if _ARG_0_.uniqueID == 50 then
      _ARG_0_:GotoState("MissionIdling")
      return
    end
    if Enemy.IsAllEnemyWaiting() == true then
      _ARG_0_:GotoState("Standby")
    else
      _ARG_0_:GotoState("Appear")
      Entity.EnableLockon(_ARG_0_.myHandle, 1)
    end
  end,
  OnDamage = function(_ARG_0_, _ARG_1_)
    print("OnDamage\n")
    if Script.Random() < _UPVALUE0_ then
      _ARG_0_:GotoState("Ranbu")
      return 1
    end
  end,
  OnReturnDamage = function(_ARG_0_)
    _ARG_0_:GotoState("Move")
  end,
  OnHitAttack = function(_ARG_0_)
  end,
  OnUpdatePositionAfter = function(_ARG_0_)
    Entity.ScalingBone(_ARG_0_.myHandle, 2, _ARG_0_.NowScale)
  end,
  OnDead = function(_ARG_0_)
    _ARG_0_:GotoState("Dead")
  end,
  Debug = function(_ARG_0_)
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
  end,
  OnUpdate = function(_ARG_0_)
    _ARG_0_:Update()
    _ARG_0_:Debug()
  end
}, {__index = __StateMachine})
EntityFactory:Add("m42ex00", function(_ARG_0_)
  EntityManager:Add(_UPVALUE0_:new(), _ARG_0_)
  return (_UPVALUE0_:new())
end)
