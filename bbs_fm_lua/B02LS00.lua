setmetatable({
  new = function(_ARG_0_)
    return setmetatable(__StateMachine:new(), _UPVALUE0_)
  end,
  states = {
    Appear = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if Enemy.IsAllEnemyWaiting() == false then
          _ARG_0_:GotoState("Think")
        end
      end
    },
    Think = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_.stack:clear()
        _ARG_0_.count = _ARG_0_.count + 1
        print("State Think\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.stack:push("Think")
        _ARG_0_.stack:push("GroundWander")
        _ARG_0_.stack:push("Idling")
        _ARG_0_.stack:push("Landing")
        _ARG_0_.stack:push("SpiralDiving")
        _ARG_0_.stack:push("AirWander")
        _ARG_0_.stack:push("TakeOff")
        _ARG_0_.stack:push("Idling")
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      end
    },
    Idling = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        print("State Idling\n")
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
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        print("State TakeOff\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Landing = {
      OnBeginState = function(_ARG_0_)
        Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
        _UPVALUE0_:setx(0)
        Entity.SetRot(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
        print("State Landing\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    GroundWander = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.myHandle)
        _ARG_0_.timer = 0
        _ARG_0_.avoidPos:set(0, 0, 0)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        print("State GroundWander\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          return
        end
        _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.timer <= 0 then
          if _ARG_0_:IsSpinAttackOK() then
            _ARG_0_.stack:push("SpinAttack")
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
            return
          end
          Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 2)
          _ARG_0_.targetPos:set(Math.Cos((Script.RandomInRange(-PI, PI))) * (8 + Script.Random() * 12), _UPVALUE0_:gety(), Math.Sin((Script.RandomInRange(-PI, PI))) * (8 + Script.Random() * 12))
          _ARG_0_.timer = _UPVALUE1_
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 2.5)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE2_)
        _ARG_0_:EvadeTarget(_ARG_0_.avoidPos, 8)
        if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetPos) <= 9 then
          _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
          _ARG_0_.timer = 0
        end
      end
    },
    AirWander = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.timer = 0
        _ARG_0_.avoidPos:set(0, 0, 0)
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          return
        end
        _ARG_0_:AirWander()
      end
    },
    AirWander = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        _ARG_0_.timer = 0
        _ARG_0_.avoidPos:set(0, 0, 0)
        print("State AirWander\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          return
        end
        _ARG_0_:AirWander()
      end
    },
    SpinAttack = {
      OnBeginState = function(_ARG_0_)
        if _ARG_0_:IsTargetRight() then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        else
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
        end
        _UPVALUE2_:set(0, _UPVALUE3_, 0)
        Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE2_)
        Entity.EnableGravity(_ARG_0_.myHandle, 0)
        _ARG_0_.step = 0
        print("State SpinAttack\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 16 then
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE1_)
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            if Entity.GetCurrentMotion(_ARG_0_.myHandle) == _UPVALUE2_ then
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
            else
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE4_)
            end
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Entity.EnableGravity(_ARG_0_.myHandle, 1)
            _ARG_0_.step = 2
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    SpiralDiving = {
      OnBeginState = function(_ARG_0_)
        if _ARG_0_:IsTargetRight() then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        else
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
        end
        _ARG_0_.step = 0
        print("State SpiralDiving\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
        _UPVALUE0_:setx(0)
        Entity.SetRot(_ARG_0_.myHandle, _UPVALUE0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.targetHandle, 0)
          _UPVALUE0_:sety(_UPVALUE0_:gety() - 8)
          Entity.TurnTargetDegree(_ARG_0_.myHandle, _UPVALUE0_, 10)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 40 then
            Entity.CalcVelocity(_ARG_0_.myHandle, _UPVALUE1_)
            Entity.SetTimer(_ARG_0_.myHandle, (Entity.CalcDistance(_ARG_0_.myHandle, _ARG_0_.targetHandle) + 5) / _UPVALUE1_)
            _ARG_0_.step = 1
          end
        elseif Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    BigDamage = {
      OnBeginState = function(_ARG_0_)
        Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
        _UPVALUE0_:setx(0)
        Entity.SetRot(_ARG_0_.myHandle, _UPVALUE0_)
        if Enemy.IsAttackerFront(_ARG_0_.myHandle) then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
        else
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
        end
        _ARG_0_.dmgCount = 0
        _ARG_0_.step = 0
        print("State BigDamage\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            if Entity.GetCurrentMotion(_ARG_0_.myHandle) == _UPVALUE0_ then
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
            else
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
            end
            _ARG_0_.step = 1
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.dmgReturnState)
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
  IsSpinAttackOK = function(_ARG_0_)
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE0_ and Script.Random() < 0.5 then
      return true
    end
    return false
  end,
  IsTargetRight = function(_ARG_0_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
    Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.targetHandle)
    FVECTOR3.Sub(_UPVALUE2_, _UPVALUE1_, _UPVALUE0_)
    _UPVALUE2_:normalize()
    _UPVALUE3_:set(-1, 0, 0)
    Entity.ApplyBoneMatrix33(_ARG_0_.myHandle, "Root", _UPVALUE3_)
    if 0 <= _UPVALUE3_:dot(_UPVALUE2_) then
      return true
    end
    return false
  end,
  CalcTargetVelocity = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
    FVECTOR3.Sub(_UPVALUE1_, _ARG_1_, _UPVALUE0_)
    _UPVALUE1_:normalize()
    FVECTOR3.Mul(_UPVALUE2_, _UPVALUE1_, _UPVALUE1_)
    Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
    _UPVALUE0_:sety(HomingDegree(_UPVALUE0_:gety(), Math.Atan2(_UPVALUE1_:getx(), _UPVALUE1_:getz()), _ARG_2_, (Entity.GetFrameRate(_ARG_0_.myHandle))))
    Entity.SetRot(_ARG_0_.myHandle, _UPVALUE0_)
    _UPVALUE0_:setx(-Math.Atan2(_UPVALUE1_:gety(), Math.Sqrt(_UPVALUE2_:getx() + _UPVALUE2_:getz())))
    _UPVALUE3_:set(0, 0, _ARG_3_)
    Math.RotateVectorXYZ(_UPVALUE3_, _UPVALUE0_)
    Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE3_)
  end,
  AirWander = function(_ARG_0_)
    _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
    if _ARG_0_.timer <= 0 then
      Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 46)
      Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.targetHandle)
      _ARG_0_.targetPos:set(Math.Cos((Script.RandomInRange(-PI, PI))) * (8 + Script.Random() * 12), 0, Math.Sin((Script.RandomInRange(-PI, PI))) * (8 + Script.Random() * 12))
      _ARG_0_.timer = _UPVALUE2_
    end
    Entity.TurnTargetDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 2.5)
    Entity.CalcVelocity(_ARG_0_.myHandle, _UPVALUE3_)
    _ARG_0_:EvadeTarget(_ARG_0_.avoidPos, 8)
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) <= 9 then
      _ARG_0_.timer = 0
    end
  end,
  EvadeTarget = function(_ARG_0_, _ARG_1_, _ARG_2_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
    FVECTOR3.Sub(_UPVALUE1_, _UPVALUE0_, _ARG_1_)
    _UPVALUE1_:sety(0)
    if _ARG_2_ > _UPVALUE1_:length() then
      Entity.GetRot(_UPVALUE2_, _ARG_0_.myHandle)
      Entity.GetVelocity(_UPVALUE0_, _ARG_0_.myHandle)
      _UPVALUE1_:set(0, RoundPI(Math.Atan2(_UPVALUE1_:getx(), _UPVALUE1_:getz()) - _UPVALUE2_:gety()) * ((_ARG_2_ - _UPVALUE1_:length()) * 0.1), 0)
      Math.RotateVectorXYZ(_UPVALUE0_, _UPVALUE1_)
      Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE0_)
      _UPVALUE2_:sety(RoundPI(_UPVALUE2_:gety() + RoundPI(Math.Atan2(_UPVALUE1_:getx(), _UPVALUE1_:getz()) - _UPVALUE2_:gety()) * ((_ARG_2_ - _UPVALUE1_:length()) * 0.1)))
      Entity.SetRot(_ARG_0_.myHandle, _UPVALUE2_)
    end
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    _UPVALUE0_ = Entity.GetMotionIndex(_ARG_1_, "010")
    _UPVALUE1_ = Entity.GetMotionIndex(_ARG_1_, "011")
    _UPVALUE2_ = Entity.GetMotionIndex(_ARG_1_, "030")
    _UPVALUE3_ = Entity.GetMotionIndex(_ARG_1_, "031")
    _UPVALUE4_ = Entity.GetMotionIndex(_ARG_1_, "032")
    _UPVALUE5_ = Entity.GetMotionIndex(_ARG_1_, "033")
    _UPVALUE6_ = Entity.GetMotionIndex(_ARG_1_, "220")
    _UPVALUE7_ = Entity.GetMotionIndex(_ARG_1_, "221")
    _UPVALUE8_ = Entity.GetMotionIndex(_ARG_1_, "222")
    _UPVALUE9_ = Entity.GetMotionIndex(_ARG_1_, "223")
    _UPVALUE10_ = Entity.GetMotionIndex(_ARG_1_, "310")
    _UPVALUE11_ = Entity.GetMotionIndex(_ARG_1_, "311")
    _UPVALUE12_ = Entity.GetMotionIndex(_ARG_1_, "312")
    _UPVALUE13_ = Entity.GetMotionIndex(_ARG_1_, "313")
    _UPVALUE14_ = Entity.GetMotionIndex(_ARG_1_, "340")
    _UPVALUE15_ = Entity.GetMotionIndex(_ARG_1_, "341")
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.targetHandle = 0
    _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
    _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.avoidPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
    _ARG_0_.step = 0
    _ARG_0_.timer = 0
    _ARG_0_.dmgCount = 0
    _ARG_0_.count = 0
    _ARG_0_.stickFastToWarpCoreDmgCount = 0
    _ARG_0_.dmgReturnState = nil
    _ARG_0_.predator = false
    _ARG_0_.predatorTimer = 0
    _ARG_0_.predatorStep = 0
    _ARG_0_.visibleTimer = 0
    _ARG_0_.stack = Stack:Create()
    Entity.EnableCheckUnderFoot(_ARG_1_, 0)
    Entity.EnableGravity(_ARG_1_, 1)
    Entity.SetMovementCollRadius(_ARG_1_, 1)
    Entity.SetLowerHalf(_ARG_1_, 8)
    Enemy.SetViewDist(_ARG_1_, 20)
    Player.SetBossCamera("b01ls")
    _ARG_0_:GotoState("Appear")
  end,
  OnSetMotion = function(_ARG_0_, _ARG_1_)
  end,
  OnReturnDamage = function(_ARG_0_)
  end,
  OnHitAttack = function(_ARG_0_)
  end,
  OnDamage = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    if _ARG_0_:GetState() ~= "BigDamage" then
      _ARG_0_.dmgCount = _ARG_0_.dmgCount + 1
      if _ARG_0_.dmgCount >= _UPVALUE0_ then
        _ARG_0_.dmgReturnState = _ARG_0_:GetState()
        _ARG_0_:GotoState("BigDamage")
        return 1
      end
    end
    return 0
  end,
  OnDead = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    Mission.CompleteMission()
    return 1
  end,
  OnUpdatePositionAfter = function(_ARG_0_)
  end,
  OnUpdate = function(_ARG_0_)
    _ARG_0_:Update()
  end
}, {__index = __StateMachine})
EntityFactory:Add("b02ls00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
