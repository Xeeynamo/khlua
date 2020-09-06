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
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_:RestHpRate() < 0.5 then
          _ARG_0_.stack:push("SelectAttack")
          _ARG_0_.stack:push("GroundWander")
          _ARG_0_.stack:push("Idling")
          _ARG_0_.stack:push("Landing")
          _ARG_0_.stack:push("SpiralDiving")
          _ARG_0_.stack:push("AirWander")
          _ARG_0_.stack:push("Trybaster")
          _ARG_0_.stack:push("AirWander")
          _ARG_0_.stack:push("StickFastToWarpCore")
          _ARG_0_.stack:push("AirWander2")
          _ARG_0_.stack:push("TakeOff")
          _ARG_0_.stack:push("Idling")
          _ARG_0_.predatorTimer = _UPVALUE0_
          _ARG_0_.predatorStep = 0
        else
          _ARG_0_.stack:push("SelectAttack")
          _ARG_0_.stack:push("GroundWander")
          _ARG_0_.stack:push("Idling")
          _ARG_0_.stack:push("Landing")
          if 0.5 > Script.Random() then
            _ARG_0_.stack:push("SpiralDiving")
          else
            _ARG_0_.stack:push("SpiralGiantSlalom")
          end
          _ARG_0_.stack:push("AirWander")
          _ARG_0_.stack:push("StickFastToWarpCore")
          _ARG_0_.stack:push("AirWander2")
          _ARG_0_.stack:push("TakeOff")
          _ARG_0_.stack:push("Idling")
        end
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      end
    },
    SelectAttack = {
      OnBeginState = function(_ARG_0_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.stack:push("Think")
        if _ARG_0_:RestHpRate() < 0.5 then
          _ARG_0_.stack:push("Flee")
          _ARG_0_.stack:push("Idling")
        end
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE0_ then
          if Script.Random() < 0.75 then
            _ARG_0_.stack:push("Punch")
          else
            _ARG_0_.stack:push("SpinAttack")
          end
        elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) >= _UPVALUE0_ and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE1_ then
          if 0.5 > Script.Random() then
            _ARG_0_.stack:push("SpinAttack")
          else
            _ARG_0_.stack:push("ThundagaShower")
          end
        end
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      end
    },
    Idling = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    AirIdling = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        Entity.EnableGravity(_ARG_0_.myHandle, 0)
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
        Entity.EnableGravity(_ARG_0_.myHandle, 0)
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
        for _FORV_5_, _FORV_6_ in pairs(_UPVALUE1_) do
          _UPVALUE2_:set(0, 0, _UPVALUE3_)
          _UPVALUE0_:set(0, RoundPI(DegToRad(_FORV_6_)), 0)
          Math.RotateVectorXYZ(_UPVALUE2_, _UPVALUE0_)
          if 100000000 > Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _UPVALUE2_) then
            _ARG_0_.targetPos:copy(_UPVALUE2_)
          end
        end
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE4_)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
          _UPVALUE1_:copy(_UPVALUE0_)
          _UPVALUE1_:sety(_UPVALUE1_:gety() - 100)
          Collision.IntersectRayBg(_UPVALUE1_, COLL_KIND_ENEMY, _UPVALUE0_, _UPVALUE1_)
          if _UPVALUE1_:gety() < 1 then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
            _UPVALUE0_:set(0, (_UPVALUE0_:gety() - _UPVALUE1_:gety()) / (Entity.GetMotionTotalFrame(_ARG_0_.myHandle) * 2), 0)
            Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE0_)
            _ARG_0_.step = 1
          else
            Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 5)
            Entity.CalcVelocity(_ARG_0_.myHandle, _UPVALUE3_)
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    GroundWander = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.myHandle)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
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
        _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.timer <= 0 then
          Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 2)
          _ARG_0_.targetPos:set(Math.Cos((Script.RandomInRange(-PI, PI))) * (8 + Script.Random() * 12), _UPVALUE0_:gety(), Math.Sin((Script.RandomInRange(-PI, PI))) * (8 + Script.Random() * 12))
          _ARG_0_.timer = _UPVALUE1_
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, _UPVALUE2_)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE3_)
        _ARG_0_:EvadeTarget(_ARG_0_.avoidPos, 8)
        if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetPos) <= 9 then
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
    AirWander2 = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        _ARG_0_.timer = 0
        _ARG_0_.avoidPos:set(0, 0, 0)
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
    StickFastToWarpCore = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        for _FORV_5_, _FORV_6_ in pairs(_UPVALUE1_) do
          _UPVALUE2_:set(0, 0, _UPVALUE3_)
          _UPVALUE4_:set(0, RoundPI(DegToRad(_FORV_6_)), 0)
          Math.RotateVectorXYZ(_UPVALUE2_, _UPVALUE4_)
          if 100000000 > Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _UPVALUE2_) then
            _ARG_0_.targetPos:copy(_UPVALUE2_)
            _ARG_0_.place = _FORV_5_ - 1
          end
        end
        Entity.GetWorldPos(_UPVALUE4_, _ARG_0_.targetHandle)
        if 1 >= _ARG_0_.count then
          _ARG_0_.targetPos:sety(0)
        elseif _UPVALUE4_:gety() > 10 then
          _ARG_0_.targetPos:sety(0)
        else
          _ARG_0_.targetPos:sety(12.5)
        end
        _ARG_0_.stickFastToWarpCoreDmgCount = 0
        _ARG_0_.timer = 0
        _ARG_0_.step = 0
        if EntityManager:GetEntity(_ARG_0_.warpCore) ~= nil then
          _ARG_0_.startWarpCoreGauge = EntityManager:GetEntity(_ARG_0_.warpCore).gauge
        end
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        _ARG_0_.predatorTimer = 1
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 5)
          Entity.CalcVelocity(_ARG_0_.myHandle, _UPVALUE0_)
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) <= 1 then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Entity.SetLocalPos(_ARG_0_.myHandle, _ARG_0_.targetPos)
            Entity.SetOldLocalPos(_ARG_0_.myHandle, _ARG_0_.targetPos)
            _UPVALUE1_:set(0, 0, 0)
            FVECTOR3.Sub(_UPVALUE1_, _UPVALUE1_, _ARG_0_.targetPos)
            Entity.SetRot(_ARG_0_.myHandle, 0, Math.Atan2(_UPVALUE1_:getx(), _UPVALUE1_:getz()), 0)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 30 then
            _ARG_0_.timer = Script.RandomInRange(_UPVALUE3_, _UPVALUE4_)
            Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_.timer)
            Mission.SendMissonMessage(MES_BTL_METAMOL_EN_ABSORPTION_START, _ARG_0_.place)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if EntityManager:GetEntity(_ARG_0_.warpCore) ~= nil then
            EntityManager:GetEntity(_ARG_0_.warpCore).gauge = (1 - 1) * _ARG_0_.startWarpCoreGauge + 1 * (_ARG_0_.startWarpCoreGauge + _UPVALUE5_)
          end
          if Entity.IsTimeOver(_ARG_0_.myHandle) or _ARG_0_.stickFastToWarpCoreDmgCount >= _UPVALUE6_ then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE7_)
            Mission.SendMissonMessage(MES_BTL_METAMOL_EN_ABSORPTION_END)
            if _ARG_0_.stickFastToWarpCoreDmgCount >= _UPVALUE6_ then
              Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle, 2)
              Enemy.MakePrize(_ARG_0_.myHandle, _UPVALUE1_)
            end
            _ARG_0_.step = 3
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Flee = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
        _UPVALUE0_:sety(HomingDegree(_UPVALUE0_:gety(), Entity.CalcDirection(_ARG_0_.targetHandle, _ARG_0_.myHandle), 5, Entity.GetFrameRate(_ARG_0_.myHandle)))
        Entity.SetRot(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE1_)
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _UPVALUE2_ or Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Punch = {
      OnBeginState = function(_ARG_0_)
        if _ARG_0_:IsTargetRight() then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        else
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
        end
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    SpinAttack = {
      OnBeginState = function(_ARG_0_)
        if _ARG_0_:IsTargetRight() then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        else
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
        end
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 16 then
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
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
            _ARG_0_.step = 2
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Trybaster = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
        _UPVALUE0_:setx(0)
        Entity.SetRot(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          _ARG_0_:TurnTarget(10, 45)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 56 then
            _UPVALUE0_:set(3.5, 0, 0)
            Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "koshi1", _UPVALUE0_)
            _UPVALUE1_:set(1, 0, 0)
            Entity.ApplyBoneMatrix33(_ARG_0_.myHandle, "koshi1", _UPVALUE1_)
            FVECTOR3.Mul(_UPVALUE2_, _UPVALUE1_, _UPVALUE1_)
            _UPVALUE1_:set(-Math.Atan2(_UPVALUE1_:gety(), Math.Sqrt(_UPVALUE2_:getx() + _UPVALUE2_:getz())), Math.Atan2(_UPVALUE1_:getx(), _UPVALUE1_:getz()), 0)
            SetBulletAttackParam(Bullet.CreateBullet("b01lsTB", _UPVALUE0_, _UPVALUE1_), _ARG_0_.myHandle, 2)
            _ARG_0_.step = 1
          end
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    ThundagaShower = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 35 then
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
            _ARG_0_.timer = 10
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE1_)
          _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 >= _ARG_0_.timer then
            for _FORV_5_, _FORV_6_ in pairs(_UPVALUE2_) do
              Entity.GetWorldPos(_UPVALUE3_, _ARG_0_.myHandle, _FORV_6_[Script.RandomInteger(#_FORV_6_) + 1])
              _UPVALUE4_:copy(_UPVALUE3_)
              _UPVALUE3_:sety(_UPVALUE3_:gety() + 0.1)
              _UPVALUE4_:sety(_UPVALUE4_:gety() - 100)
              Collision.IntersectRayBg(_UPVALUE3_, COLL_KIND_ENEMY, _UPVALUE3_, _UPVALUE4_)
              _UPVALUE4_:set(0, 0, 0)
              SetBulletAttackParam(Bullet.CreateBullet("ThundagaShower", _UPVALUE3_, _UPVALUE4_), _ARG_0_.myHandle, 3)
              Entity.SetTimer(Bullet.CreateBullet("ThundagaShower", _UPVALUE3_, _UPVALUE4_), 0)
            end
            _ARG_0_.timer = 15
          end
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE5_)
            Entity.ClearSpeed(_ARG_0_.myHandle)
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
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 0, 0)
        else
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_, 0, 0)
        end
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
        _UPVALUE0_:setx(0)
        Entity.SetRot(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          _ARG_0_:TurnTarget(10, 45)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 40 then
            Entity.CalcVelocity(_ARG_0_.myHandle, _UPVALUE0_)
            Entity.SetTimer(_ARG_0_.myHandle, (Entity.CalcDistance(_ARG_0_.myHandle, _ARG_0_.targetHandle) + 5) / _UPVALUE0_)
            _ARG_0_.step = 1
          end
        elseif Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    SpiralGiantSlalom = {
      OnBeginState = function(_ARG_0_)
        if Script.Random() < 0.5 then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 1, 1)
          _ARG_0_.rotSpeed = -_UPVALUE1_
        else
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_, 1, 1)
          _ARG_0_.rotSpeed = _UPVALUE1_
        end
        _UPVALUE3_:set(0, 0, 0)
        Entity.GetWorldPos(_UPVALUE4_, _ARG_0_.myHandle)
        FVECTOR3.Sub(_UPVALUE4_, _UPVALUE4_, _UPVALUE3_)
        _UPVALUE4_:sety(0)
        _ARG_0_.radius = _UPVALUE4_:length()
        _ARG_0_.theta = Math.Atan2(_UPVALUE4_:getz(), _UPVALUE4_:getx())
        if _ARG_0_.radius > 18 then
          _ARG_0_.radius = 18
        elseif _ARG_0_.radius < 6 then
          _ARG_0_.radius = 6
        end
        _ARG_0_.theta2 = Math.Acos((_ARG_0_.radius - 12) / 6)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE5_)
        _UPVALUE3_:set(0, -0.1, 0)
        Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE3_)
        Entity.GetRot(_UPVALUE3_, _ARG_0_.myHandle)
        _UPVALUE3_:setx(0)
        Entity.SetRot(_ARG_0_.myHandle, _UPVALUE3_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
        _UPVALUE0_:setx(0)
        Entity.SetRot(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.GetLocalPos(_UPVALUE0_, _ARG_0_.myHandle)
        _UPVALUE1_:copy(_UPVALUE0_)
        _UPVALUE0_:setx((6 + 12 * ((Math.Cos(_ARG_0_.theta2) + 1) / 2)) * Math.Cos(_ARG_0_.theta))
        _UPVALUE0_:setz((6 + 12 * ((Math.Cos(_ARG_0_.theta2) + 1) / 2)) * Math.Sin(_ARG_0_.theta))
        Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE0_)
        FVECTOR3.Sub(_UPVALUE0_, _UPVALUE0_, _UPVALUE1_)
        Entity.GetRot(_UPVALUE2_, _ARG_0_.myHandle)
        _UPVALUE2_:sety(HomingDegree(_UPVALUE2_:gety(), Math.Atan2(_UPVALUE0_:getx(), _UPVALUE0_:getz()), 5, (Entity.GetFrameRate(_ARG_0_.myHandle))))
        Entity.SetRot(_ARG_0_.myHandle, _UPVALUE2_)
        _ARG_0_.theta = RoundPI(_ARG_0_.theta + DegToRad(_ARG_0_.rotSpeed * Entity.GetFrameRate(_ARG_0_.myHandle)))
        _ARG_0_.theta2 = RoundPI(_ARG_0_.theta2 + DegToRad(5 * Entity.GetFrameRate(_ARG_0_.myHandle)))
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
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
  EnablePredator = function(_ARG_0_, _ARG_1_)
    _ARG_0_.predator = _ARG_1_
    Entity.SetAlpha(_ARG_0_.myHandle, 1)
    Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
    if _ARG_1_ then
      Entity.EnableModelInvisible(_ARG_0_.myHandle, 1)
      Entity.SetDropShadowDensity(_ARG_0_.myHandle, 0.25)
    else
      Entity.EnableModelInvisible(_ARG_0_.myHandle, 0)
      Entity.SetDropShadowDensity(_ARG_0_.myHandle, -1)
    end
  end,
  EnableTransparency = function(_ARG_0_, _ARG_1_)
    _ARG_0_.predator = false
    if _ARG_1_ then
      Entity.SetAlpha(_ARG_0_.myHandle, 0)
      Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
    else
      Entity.SetAlpha(_ARG_0_.myHandle, 1)
      Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
    end
  end,
  RestHpRate = function(_ARG_0_)
    if Script.GetDebugTestParam() <= 0 then
      return Enemy.GetHp(_ARG_0_.myHandle) / Enemy.GetHpMax(_ARG_0_.myHandle)
    else
      return 0
    end
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
    Entity.TurnTargetDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, _UPVALUE3_)
    Entity.CalcVelocity(_ARG_0_.myHandle, _UPVALUE4_)
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
  TurnTarget = function(_ARG_0_, _ARG_1_, _ARG_2_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
    Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.targetHandle)
    _UPVALUE0_:sety(_UPVALUE0_:gety() + 2)
    FVECTOR3.Sub(_UPVALUE2_, _UPVALUE1_, _UPVALUE0_)
    _UPVALUE2_:normalize()
    FVECTOR3.Mul(_UPVALUE3_, _UPVALUE2_, _UPVALUE2_)
    Entity.GetRot(_UPVALUE4_, _ARG_0_.myHandle)
    if HomingDegree(_UPVALUE4_:getx(), -Math.Atan2(_UPVALUE2_:gety(), Math.Sqrt(_UPVALUE3_:getx() + _UPVALUE3_:getz())), _ARG_1_, (Entity.GetFrameRate(_ARG_0_.myHandle))) > DegToRad(_ARG_2_) then
    end
    _UPVALUE4_:setx((DegToRad(_ARG_2_)))
    _UPVALUE4_:sety(HomingDegree(_UPVALUE4_:gety(), Math.Atan2(_UPVALUE2_:getx(), _UPVALUE2_:getz()), _ARG_1_, (Entity.GetFrameRate(_ARG_0_.myHandle))))
    Entity.SetRot(_ARG_0_.myHandle, _UPVALUE4_)
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    _UPVALUE0_ = Entity.GetMotionIndex(_ARG_1_, "010")
    _UPVALUE1_ = Entity.GetMotionIndex(_ARG_1_, "011")
    _UPVALUE2_ = Entity.GetMotionIndex(_ARG_1_, "020")
    _UPVALUE3_ = Entity.GetMotionIndex(_ARG_1_, "021")
    _UPVALUE4_ = Entity.GetMotionIndex(_ARG_1_, "030")
    _UPVALUE5_ = Entity.GetMotionIndex(_ARG_1_, "031")
    _UPVALUE6_ = Entity.GetMotionIndex(_ARG_1_, "032")
    _UPVALUE7_ = Entity.GetMotionIndex(_ARG_1_, "033")
    _UPVALUE8_ = Entity.GetMotionIndex(_ARG_1_, "220")
    _UPVALUE9_ = Entity.GetMotionIndex(_ARG_1_, "221")
    _UPVALUE10_ = Entity.GetMotionIndex(_ARG_1_, "222")
    _UPVALUE11_ = Entity.GetMotionIndex(_ARG_1_, "223")
    _UPVALUE12_ = Entity.GetMotionIndex(_ARG_1_, "300")
    _UPVALUE13_ = Entity.GetMotionIndex(_ARG_1_, "301")
    _UPVALUE14_ = Entity.GetMotionIndex(_ARG_1_, "310")
    _UPVALUE15_ = Entity.GetMotionIndex(_ARG_1_, "311")
    _UPVALUE16_ = Entity.GetMotionIndex(_ARG_1_, "312")
    _UPVALUE17_ = Entity.GetMotionIndex(_ARG_1_, "313")
    _UPVALUE18_ = Entity.GetMotionIndex(_ARG_1_, "320")
    _UPVALUE19_ = Entity.GetMotionIndex(_ARG_1_, "321")
    _UPVALUE20_ = Entity.GetMotionIndex(_ARG_1_, "330")
    _UPVALUE21_ = Entity.GetMotionIndex(_ARG_1_, "331")
    _UPVALUE22_ = Entity.GetMotionIndex(_ARG_1_, "340")
    _UPVALUE23_ = Entity.GetMotionIndex(_ARG_1_, "341")
    _UPVALUE24_ = Enemy.GetExtraParam(_ARG_1_, "wc_time0") * 60
    _UPVALUE25_ = Enemy.GetExtraParam(_ARG_1_, "wc_time1") * 60
    _UPVALUE26_ = Enemy.GetExtraParam(_ARG_1_, "wc_up_rate")
    _UPVALUE27_ = Enemy.GetExtraParam(_ARG_1_, "wcsf_cancel")
    _UPVALUE28_ = Enemy.GetExtraParam(_ARG_1_, "move_spd")
    _UPVALUE29_ = Enemy.GetExtraParam(_ARG_1_, "atk_dist1")
    _UPVALUE29_ = _UPVALUE29_ * _UPVALUE29_
    _UPVALUE30_ = Enemy.GetExtraParam(_ARG_1_, "atk_dist2")
    _UPVALUE30_ = _UPVALUE30_ * _UPVALUE30_
    _UPVALUE31_ = Enemy.GetExtraParam(_ARG_1_, "s_atk_spd")
    _UPVALUE32_ = Enemy.GetExtraParam(_ARG_1_, "tds_spd")
    _UPVALUE33_ = Enemy.GetExtraParam(_ARG_1_, "sgs_spd")
    _UPVALUE34_ = Enemy.GetExtraParam(_ARG_1_, "sgs_time") * 60
    _UPVALUE35_ = Enemy.GetExtraParam(_ARG_1_, "jump_power")
    _UPVALUE36_ = Enemy.GetExtraParam(_ARG_1_, "gravity")
    _UPVALUE37_ = Enemy.GetExtraParam(_ARG_1_, "a_wander_tm") * 60
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.targetHandle = NULL_HANDLE
    _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
    _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.avoidPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
    _ARG_0_.oldPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.newPos = FVECTOR3.new(0, 0, 0)
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
    _ARG_0_.visibleStep = 0
    _ARG_0_.timer = 0
    _ARG_0_.radius = 0
    _ARG_0_.theta = 0
    _ARG_0_.theta2 = 0
    _ARG_0_.rotSpeed = 0
    _ARG_0_.place = 0
    _ARG_0_.stack = Stack:Create()
    Entity.EnableGravity(_ARG_1_, 0)
    Entity.SetMovementCollRadius(_ARG_1_, 3.5)
    Entity.SetLowerHalf(_ARG_1_, 4)
    Enemy.SetViewDist(_ARG_1_, 40)
    _UPVALUE38_:set(0, 0, 0)
    _ARG_0_.warpCore = Bullet.CreateBullet("WarpCore", _UPVALUE38_, _UPVALUE38_)
    _ARG_0_.startWarpCoreGauge = 0
    Player.SetBossCamera("b01ls")
    _ARG_0_:GotoState("Appear")
  end,
  OnDestroy = function(_ARG_0_, _ARG_1_)
    Entity.Out(_ARG_0_.warpCore)
  end,
  OnSetMotion = function(_ARG_0_, _ARG_1_)
  end,
  OnReturnDamage = function(_ARG_0_)
  end,
  OnHitAttack = function(_ARG_0_)
  end,
  OnDamage = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    if _ARG_0_.predator and _ARG_0_.visibleTimer <= 0 then
      _ARG_0_.visibleTimer = _UPVALUE0_
      Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, 15)
      Entity.EnableModelInvisible(_ARG_0_.myHandle, 0)
      Entity.SetDropShadowDensity(_ARG_0_.myHandle, -1)
      _ARG_0_.visibleStep = 1
    end
    if _ARG_0_:GetState() ~= "BigDamage" then
      if _ARG_0_:GetState() == "StickFastToWarpCore" then
        if Entity.GetName(Entity.GetAttackOwnerHandle(_ARG_0_.myHandle)) == "n01ls00" then
          _ARG_0_.stickFastToWarpCoreDmgCount = _UPVALUE1_
        else
          _ARG_0_.stickFastToWarpCoreDmgCount = _ARG_0_.stickFastToWarpCoreDmgCount + 1
        end
      else
        _ARG_0_.dmgCount = _ARG_0_.dmgCount + 1
        if _ARG_0_.dmgCount >= _UPVALUE2_ then
          _ARG_0_.dmgReturnState = _ARG_0_:GetState()
          _ARG_0_:GotoState("BigDamage")
          return 1
        end
      end
    end
    return 1
  end,
  OnDead = function(_ARG_0_)
    SetupBossDead(_ARG_0_.myHandle)
    _ARG_0_:GotoState("Dead")
    return 1
  end,
  OnUpdatePositionAfter = function(_ARG_0_)
    if _ARG_0_.predatorTimer > 0 then
      _ARG_0_.predatorTimer = _ARG_0_.predatorTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
      if _ARG_0_.predatorStep == 0 then
        print("\131v\131\140\131f\131^\129[\138J\142n\n")
        Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 30)
        _ARG_0_.predatorStep = 1
      elseif _ARG_0_.predatorStep == 1 then
        if Entity.IsModelFade(_ARG_0_.myHandle) == false then
          _ARG_0_:EnablePredator(true)
          _ARG_0_.predatorStep = 2
        end
      elseif _ARG_0_.predatorStep == 2 then
        if _ARG_0_.predatorTimer <= _UPVALUE0_ then
          print("\147\167\150\190\137\187\n")
          _ARG_0_:EnableTransparency(true)
          _ARG_0_.predatorStep = 3
        end
      elseif _ARG_0_.predatorStep == 3 and _ARG_0_.predatorTimer <= _UPVALUE1_ then
        print("\131v\131\140\131f\131^\129[\137\187\n")
        _ARG_0_:EnableTransparency(false)
        _ARG_0_:EnablePredator(true)
        _ARG_0_.predatorStep = 4
      end
      if _ARG_0_.predatorTimer <= 0 then
        print("\131v\131\140\131f\131^\129[\143I\151\185\n")
        _ARG_0_:EnablePredator(false)
        Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, 30)
      end
    end
    if _ARG_0_.visibleStep == 1 then
      _ARG_0_.visibleTimer = _ARG_0_.visibleTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
      if 0 >= _ARG_0_.visibleTimer and _ARG_0_.predator then
        Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 15)
        _ARG_0_.visibleStep = 2
      end
    elseif _ARG_0_.visibleStep == 2 and Entity.IsModelFade(_ARG_0_.myHandle) == false then
      _ARG_0_:EnablePredator(true)
      _ARG_0_.visibleStep = 0
    end
  end,
  OnUpdate = function(_ARG_0_)
    _ARG_0_:Update()
    _ARG_0_:Debug()
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
EntityFactory:Add("b01ls00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("ThundagaShower", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("WarpCore", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b01lsTB", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
