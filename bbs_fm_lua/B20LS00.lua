setmetatable({
  new = function(_ARG_0_)
    return setmetatable(__StateMachine:new(), _UPVALUE0_)
  end,
  states = {
    Appear = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if Enemy.IsAllEnemyWaiting() == false then
          _ARG_0_.stack:push("AirMove")
          _ARG_0_.stack:push("StartAirMove")
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    AirMove = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        _ARG_0_.stack:clear()
        _ARG_0_.timer = 0
        _ARG_0_.timer2 = Script.RandomInRange(120, 240)
        _ARG_0_.step = 0
        print("AirMove\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        if Entity.IsTimeOver(_ARG_0_.myHandle) == false and _ARG_0_:RestHpRate() < _UPVALUE0_ and _ARG_0_.blasterModeChangeTimer <= 0 then
          _ARG_0_:GotoState("BlasterMode")
          return
        end
        if _ARG_0_.step == 0 then
          _ARG_0_:Wander()
          _ARG_0_.timer2 = _ARG_0_.timer2 - Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 >= _ARG_0_.timer2 then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.timer2 = 120
            _ARG_0_.step = 1
          end
        else
          _ARG_0_.timer2 = _ARG_0_.timer2 - Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 >= _ARG_0_.timer2 then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
            _ARG_0_.timer2 = Script.RandomInRange(120, 240)
            _ARG_0_.step = 0
          end
          return
        end
        if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) == false then
          return
        end
        if _ARG_0_:RestHpRate() < _UPVALUE0_ then
          if _ARG_0_.blasterModeChangeTimer <= 0 then
            _ARG_0_.blasterModeChangeTimer = _UPVALUE3_
          end
          if Script.Random() < 0.3 then
            _ARG_0_.stack:push("AirMove")
            _ARG_0_.stack:push("AirIdling")
            _ARG_0_.stack:push("Lightning")
          elseif Script.Random() >= 0.3 and Script.Random() < 0.6 then
            _ARG_0_.stack:push("AirMove")
            _ARG_0_.stack:push("AirIdling")
            for _FORV_6_ = 1, Script.RandomInteger(3) + 1 do
              _ARG_0_.stack:push("ElectricBall")
            end
          elseif Script.Random() >= 0.6 and Script.Random() < 0.9 then
            _ARG_0_.stack:push("AirMove")
            _ARG_0_.stack:push("StartAirMove")
            for _FORV_6_ = 1, Script.RandomInteger(_UPVALUE4_ - _UPVALUE5_ + 1) + _UPVALUE5_ do
              _ARG_0_.stack:push("ElectricalDischarge")
            end
            _FOR_:push("CenterLanding")
          else
            _ARG_0_.stack:push("AirMove")
            _ARG_0_.stack:push("Flee")
          end
        elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE6_ then
          if Script.Random() < 0.6 then
            _ARG_0_.stack:push("AirMove")
            _ARG_0_.stack:push("Flee")
            _ARG_0_.stack:push("StartAirMove")
            _ARG_0_.stack:push("Idling")
            _ARG_0_.stack:push("Electroshock")
            _ARG_0_.stack:push("Landing")
          else
            _ARG_0_.stack:push("AirMove")
            _ARG_0_.stack:push("Flee")
          end
        elseif Script.Random() < 0.3 then
          _ARG_0_.stack:push("AirMove")
          _ARG_0_.stack:push("StartAirMove")
          _ARG_0_.stack:push("Idling")
          for _FORV_7_ = 1, Script.RandomInteger(_UPVALUE7_ - _UPVALUE8_ + 1) + _UPVALUE8_ do
            _ARG_0_.stack:push("ElectricalDischarge")
          end
          _FOR_:push("CenterLanding")
        elseif Script.Random() >= 0.3 and Script.Random() < 0.8 then
          _ARG_0_.stack:push("AirMove")
          _ARG_0_.stack:push("AirIdling")
          _ARG_0_.stack:push("Lightning")
        else
          _ARG_0_.stack:push("Waiting")
          _ARG_0_.stack:push("Landing")
        end
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      end
    },
    Wander = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        Entity.EnableAvoidPlayer(_ARG_0_.myHandle, 1)
        Entity.EnableAvoidEnemy(_ARG_0_.myHandle, 1)
        _ARG_0_.timer = 0
        print("Wander\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableAvoidPlayer(_ARG_0_.myHandle, 0)
        Entity.EnableAvoidEnemy(_ARG_0_.myHandle, 0)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          return
        end
        _ARG_0_:Wander()
      end
    },
    Landing = {
      OnBeginState = function(_ARG_0_)
        Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.targetHandle)
        Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
        Collision.IntersectRayBg(_UPVALUE0_, COLL_KIND_ENEMY, _UPVALUE1_, _UPVALUE0_)
        _UPVALUE1_:copy(_UPVALUE0_)
        _UPVALUE1_:sety(_UPVALUE0_:gety() - 25)
        _UPVALUE0_:sety(_UPVALUE0_:gety() + 0.01)
        Collision.IntersectRayBg(_UPVALUE2_, COLL_KIND_ENEMY, _UPVALUE0_, _UPVALUE1_)
        _ARG_0_.targetPos:copy(_UPVALUE2_)
        _ARG_0_.step = 0
        print("Landing\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.LoopEndEffectAttach(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 10)
          Entity.CalcVelocity(_ARG_0_.myHandle, _UPVALUE0_)
          if Entity.IsGround(_ARG_0_.myHandle) or Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) <= 0.5625 then
            Entity.EnableGravity(_ARG_0_.myHandle, 1)
            Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
            Entity.LoopEndEffectAttach(_ARG_0_.tailHandle)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
            _UPVALUE1_:setx(0)
            Entity.SetRot(_ARG_0_.myHandle, _UPVALUE1_)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
            _ARG_0_.step = 1
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    CenterLanding = {
      OnBeginState = function(_ARG_0_)
        _UPVALUE0_:set(0, 1.2, 0)
        _ARG_0_.targetPos:copy(_UPVALUE0_)
        _ARG_0_.step = 0
        print("CenterLanding\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
        Entity.EnableHeavy(_ARG_0_.myHandle, 0)
        Entity.LoopEndEffectAttach(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 10)
          Entity.CalcVelocity(_ARG_0_.myHandle, _UPVALUE0_)
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) <= 2.25 then
            Entity.SetRootMoveScale(_ARG_0_.myHandle, Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetPos) / 2, 1, Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetPos) / 2)
            Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
            Entity.LoopEndEffectAttach(_ARG_0_.tailHandle)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
            _UPVALUE1_:setx(0)
            Entity.SetRot(_ARG_0_.myHandle, _UPVALUE1_)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
            Entity.EnableGravity(_ARG_0_.myHandle, 1)
            Entity.EnableHeavy(_ARG_0_.myHandle, 1)
            _ARG_0_.step = 1
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Idling = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        print("Idling\n")
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
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        print("AirIdling\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    AirIdling2 = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 1)
        Entity.SetTimer(_ARG_0_.myHandle, 10)
        print("AirIdling2\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    StartAirMove = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.EnableGravity(_ARG_0_.myHandle, 0)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        print("StartAirMove\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Flee = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.targetHandle)
        _UPVALUE2_:set(0, 0, 0)
        FVECTOR3.Sub(_UPVALUE3_, _UPVALUE2_, _UPVALUE1_)
        _UPVALUE3_:sety(0)
        _UPVALUE3_:normalize()
        _UPVALUE3_:scale(12.5)
        _UPVALUE3_:sety(3)
        _ARG_0_.targetPos:copy(_UPVALUE3_)
        print("Flee\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 10)
        Entity.CalcVelocity(_ARG_0_.myHandle, _UPVALUE0_)
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) <= 1 then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Waiting = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        print("Waiting\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE0_ then
          _ARG_0_.stack:push("AirMove")
          _ARG_0_.stack:push("StartAirMove")
          _ARG_0_.stack:push("Electroshock")
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          return
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_.stack:push("AirMove")
          _ARG_0_.stack:push("Flee")
          _ARG_0_.stack:push("StartAirMove")
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    BlasterMode = {
      OnBeginState = function(_ARG_0_)
        if _ARG_0_.blaster[1]:CalcTargetDistance(_ARG_0_.myHandle) > _ARG_0_.blaster[2]:CalcTargetDistance(_ARG_0_.myHandle) then
          Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.blaster[2].myHandle, 7)
        else
          Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.blaster[1].myHandle, 7)
        end
        _ARG_0_.step = 0
        print("BlasterMode\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 10)
          Entity.CalcVelocity(_ARG_0_.myHandle, _UPVALUE0_)
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) <= 2.25 then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
            Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
            Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE2_)
            _ARG_0_.blaster[1]:Possession()
            _ARG_0_.blaster[2]:Possession()
            _ARG_0_.step = 2
            _ARG_0_.step2 = 0
          end
        elseif _ARG_0_:UpdateBlasterPossession() == 1 then
          _ARG_0_.blasterModeChangeTimer = _UPVALUE3_
          Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
          Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
          Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
          _ARG_0_:GotoState("AirMove")
        elseif _ARG_0_:UpdateBlasterPossession() == 2 then
          Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
          Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
          Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
          _ARG_0_:GotoState("Faint")
        end
      end
    },
    Electroshock = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Enemy.SetFaceAnim(_ARG_0_.myHandle, 6, 5)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        print("Electroshock\n")
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Enemy.SetFaceAnim(_ARG_0_.myHandle, 1, 0)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    ElectricalDischarge = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.EnableHeavy(_ARG_0_.myHandle, 1)
        Enemy.SetFaceAnim(_ARG_0_.myHandle, 6, 5)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        _ARG_0_.step = 0
        print("ElectricalDischarge\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableHeavy(_ARG_0_.myHandle, 0)
        Enemy.SetFaceAnim(_ARG_0_.myHandle, 1, 0)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 10 then
            Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
            for _FORV_5_ = -180, 180, 60 do
              _UPVALUE1_:set(Math.Cos((DegToRad(_FORV_5_))) * 1.5, 0.5, Math.Sin((DegToRad(_FORV_5_))) * 1.5)
              FVECTOR3.Add(_UPVALUE2_, _UPVALUE0_, _UPVALUE1_)
              FVECTOR3.Sub(_UPVALUE3_, _UPVALUE2_, _UPVALUE0_)
              _UPVALUE4_:set(0, Math.Atan2(_UPVALUE3_:getx(), _UPVALUE3_:getz()), 0)
              SetBulletAttackParam(Bullet.CreateBullet("b20lsTBall", _UPVALUE2_, _UPVALUE4_), _ARG_0_.myHandle, 1)
              _ARG_0_.thunderBallHandle[1] = Bullet.CreateBullet("b20lsTBall", _UPVALUE2_, _UPVALUE4_)
            end
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 45 then
          for _FORV_7_, _FORV_8_ in pairs(_ARG_0_.thunderBallHandle) do
            if EntityManager:GetEntity(_FORV_8_) ~= nil then
              EntityManager:GetEntity(_FORV_8_):Fire()
              if 100000000 > Entity.CalcDistanceSq(_FORV_8_, _ARG_0_.targetHandle) then
              end
            end
          end
          if EntityManager:GetEntity(_FORV_8_) ~= nil then
            EntityManager:GetEntity(_FORV_8_):StartHoming(_ARG_0_.targetHandle)
          end
          Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
          _ARG_0_.step = 2
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Lightning = {
      OnBeginState = function(_ARG_0_)
        if _ARG_0_:RestHpRate() < _UPVALUE0_ then
          _ARG_0_.count = _UPVALUE1_
        else
          _ARG_0_.count = _UPVALUE2_
        end
        _ARG_0_.step = 0
        print("Lightning\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 2)
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
          _ARG_0_.step = 1
        elseif _ARG_0_.step == 1 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
          Entity.GetWorldPos(_UPVALUE3_, _ARG_0_.myHandle)
          Entity.GetWorldPos(_UPVALUE4_, _ARG_0_.targetHandle, 2)
          FVECTOR3.Sub(_UPVALUE4_, _UPVALUE4_, _UPVALUE3_)
          _UPVALUE4_:normalize()
          _UPVALUE4_:scale(_UPVALUE4_:length() / 10)
          Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE4_)
          FVECTOR3.Mul(_UPVALUE5_, _UPVALUE4_, _UPVALUE4_)
          _UPVALUE3_:set(-Math.Atan2(_UPVALUE4_:gety(), Math.Sqrt(_UPVALUE5_:getx() + _UPVALUE5_:getz())), Math.Atan2(_UPVALUE4_:getx(), _UPVALUE4_:getz()), 0)
          Entity.SetRot(_ARG_0_.myHandle, _UPVALUE3_)
          Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
          _ARG_0_.step = 3
        elseif _ARG_0_.step == 3 then
          if 10 <= Entity.GetMotionNowFrame(_ARG_0_.myHandle) then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.step = 4
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.count = _ARG_0_.count - 1
          if 0 >= _ARG_0_.count then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          else
            _ARG_0_.step = 2
          end
        end
      end
    },
    ElectricBall = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.EnableHeavy(_ARG_0_.myHandle, 1)
        _ARG_0_.step = 0
        print("ElectricBall\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableHeavy(_ARG_0_.myHandle, 0)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 10 then
            Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
            _UPVALUE0_:sety(_UPVALUE0_:gety() + 2.5)
            _UPVALUE1_:set(0, 0, 0)
            SetBulletAttackParam(Bullet.CreateBullet("b20lsEBall", _UPVALUE0_, _UPVALUE1_), _ARG_0_.myHandle, 3)
            _ARG_0_.thunderBallHandle[1] = Bullet.CreateBullet("b20lsEBall", _UPVALUE0_, _UPVALUE1_)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 40 then
            Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
            if EntityManager:GetEntity(_ARG_0_.thunderBallHandle[1]) ~= nil then
              EntityManager:GetEntity(_ARG_0_.thunderBallHandle[1]):Fire(_ARG_0_.targetHandle)
            end
            _ARG_0_.step = 2
          end
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Faint = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        _UPVALUE1_:set(0, 0.1, 0.15)
        Entity.CalcVelocity(_ARG_0_.myHandle, _UPVALUE1_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        _ARG_0_.stack:push("AirMove")
        _ARG_0_.stack:push("StartAirMove")
        _ARG_0_.step = 0
        print("Faint\n")
      end,
      OnEndState = function(_ARG_0_)
        _ARG_0_.blasterModeChangeTimer = _UPVALUE0_
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsGround(_ARG_0_.myHandle) then
            _ARG_0_:PlayVoice(_UPVALUE0_[Script.RandomInteger(2) + 1])
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE2_)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
            _ARG_0_.step = 2
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Dead = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 and Sound.IsInvalidateSeCall() == 1 then
          Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 2)
          Sound.PlayVoice(142, 17, 1, _UPVALUE0_, SE_OPT_ALWAYS)
          _ARG_0_.step = 1
        end
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
  PlayVoice = function(_ARG_0_, _ARG_1_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
    Sound.SetPosition(Sound.PlayVoice(142, _ARG_1_), _UPVALUE0_)
  end,
  Wander = function(_ARG_0_)
    _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
    if _ARG_0_.timer <= 0 then
      Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
      _ARG_0_.targetPos:set(Math.Cos((Script.RandomInRange(-PI, PI))) * (Script.Random() * 13), Script.RandomInRange(1.5, 4), Math.Sin((Script.RandomInRange(-PI, PI))) * (Script.Random() * 13))
      Collision.IntersectRayBg(_ARG_0_.targetPos, COLL_KIND_ENEMY, _UPVALUE0_, _ARG_0_.targetPos)
      _ARG_0_.timer = 15
    end
    Entity.TurnTargetDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 5)
    Entity.CalcVelocity(_ARG_0_.myHandle, _UPVALUE1_)
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) <= 2.25 then
      _ARG_0_.timer = 0
    end
  end,
  UpdateBlasterPossession = function(_ARG_0_)
    if _ARG_0_.step2 == 0 then
      _ARG_0_.timer = Script.RandomInRange(_UPVALUE0_, _UPVALUE0_ * 2)
      _ARG_0_.step2 = 1
    elseif _ARG_0_.step2 == 1 then
      if 0 >= _ARG_0_.timer then
        if _ARG_0_.blaster[1]:CalcTargetDistance(_ARG_0_.targetHandle) > 25 and _ARG_0_.blaster[2]:CalcTargetDistance(_ARG_0_.targetHandle) > 25 then
          _ARG_0_.step2 = 2
          if _ARG_0_.blaster[1]:CalcTargetDistance(_ARG_0_.targetHandle) < _ARG_0_.blaster[2]:CalcTargetDistance(_ARG_0_.targetHandle) then
            _ARG_0_.ptr = 1
          else
            _ARG_0_.ptr = 2
          end
          _ARG_0_.blaster[_ARG_0_.ptr]:GotoState("TenShot")
          _ARG_0_.count = 0
        elseif Script.Random() < 0.5 then
          _ARG_0_.step2 = 2
          if _ARG_0_.blaster[1]:CalcTargetDistance(_ARG_0_.targetHandle) < _ARG_0_.blaster[2]:CalcTargetDistance(_ARG_0_.targetHandle) then
            _ARG_0_.ptr = 1
          else
            _ARG_0_.ptr = 2
          end
          _ARG_0_.blaster[_ARG_0_.ptr]:GotoState("TenShot")
          _ARG_0_.count = 0
        else
          if _ARG_0_.blaster[1]:CalcTargetDistance(_ARG_0_.targetHandle) > _ARG_0_.blaster[2]:CalcTargetDistance(_ARG_0_.targetHandle) then
            _ARG_0_.blaster[1] = _ARG_0_.blaster[2]
            _ARG_0_.blaster[2] = _ARG_0_.blaster[1]
          end
          _ARG_0_.blaster[1]:GotoState("Attack")
          _ARG_0_.step2 = 3
        end
      end
    elseif _ARG_0_.step2 == 2 then
      if _ARG_0_.blaster[_ARG_0_.ptr]:GetState() == "Idling" then
        _ARG_0_.count = _ARG_0_.count + 1
        if 2 <= _ARG_0_.count then
          _ARG_0_.step2 = 0
          return 0
        else
          if _ARG_0_.ptr == 1 then
            _ARG_0_.ptr = 2
          else
            _ARG_0_.ptr = 1
          end
          _ARG_0_.timer = 60
          _ARG_0_.step2 = 5
        end
      end
    elseif _ARG_0_.step2 == 3 then
      if _ARG_0_.blaster[1]:GetState() == "Idling" then
        _ARG_0_.step2 = 0
      end
    elseif _ARG_0_.step2 == 4 then
      if _ARG_0_.blaster[1].step == 1 or _ARG_0_.blaster[2].step == 1 then
        return 1
      end
    elseif _ARG_0_.step2 == 5 and 0 >= _ARG_0_.timer then
      _ARG_0_.blaster[_ARG_0_.ptr]:GotoState("TenShot")
      _ARG_0_.step2 = 2
    end
    if 0 < _ARG_0_.timer then
      _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
    end
    if _ARG_0_.blaster[1]:GetState() == "Breakdown" or _ARG_0_.blaster[2]:GetState() == "Breakdown" then
      if _ARG_0_.blaster[1]:GetState() ~= "Breakdown" then
        _ARG_0_.blaster[1]:GotoState("Wait")
      end
      if _ARG_0_.blaster[2]:GetState() ~= "Breakdown" then
        _ARG_0_.blaster[2]:GotoState("Wait")
      end
      return 2
    end
    if Entity.IsTimeOver(_ARG_0_.myHandle) and _ARG_0_.step2 == 1 then
      _ARG_0_.blaster[1]:GotoState("Explode")
      _ARG_0_.blaster[2]:GotoState("Explode")
      _ARG_0_.step2 = 4
    end
    return 0
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    _UPVALUE0_ = Entity.GetMotionIndex(_ARG_1_, "010")
    _UPVALUE1_ = Entity.GetMotionIndex(_ARG_1_, "011")
    _UPVALUE2_ = Entity.GetMotionIndex(_ARG_1_, "030")
    _UPVALUE3_ = Entity.GetMotionIndex(_ARG_1_, "031")
    _UPVALUE4_ = Entity.GetMotionIndex(_ARG_1_, "032")
    _UPVALUE5_ = Entity.GetMotionIndex(_ARG_1_, "033")
    _UPVALUE6_ = Entity.GetMotionIndex(_ARG_1_, "300")
    _UPVALUE7_ = Entity.GetMotionIndex(_ARG_1_, "310")
    _UPVALUE8_ = Entity.GetMotionIndex(_ARG_1_, "320")
    _UPVALUE9_ = Entity.GetMotionIndex(_ARG_1_, "330")
    _UPVALUE10_ = Entity.GetMotionIndex(_ARG_1_, "222")
    _UPVALUE11_ = Entity.GetMotionIndex(_ARG_1_, "230")
    _UPVALUE12_ = Entity.GetMotionIndex(_ARG_1_, "231")
    _UPVALUE13_ = Enemy.GetExtraParam(_ARG_1_, "LN_START_TM") * 60
    _UPVALUE14_ = Enemy.GetExtraParam(_ARG_1_, "LN_CNT_FH")
    _UPVALUE15_ = Enemy.GetExtraParam(_ARG_1_, "LN_CNT_LH")
    _UPVALUE16_ = Enemy.GetExtraParam(_ARG_1_, "ED_CNT_FH_1")
    _UPVALUE17_ = Enemy.GetExtraParam(_ARG_1_, "ED_CNT_FH_2")
    _UPVALUE18_ = Enemy.GetExtraParam(_ARG_1_, "ED_CNT_LH_1")
    _UPVALUE19_ = Enemy.GetExtraParam(_ARG_1_, "ED_CNT_LH_2")
    _UPVALUE20_ = Enemy.GetExtraParam(_ARG_1_, "ED_SPEED")
    _UPVALUE21_ = Enemy.GetExtraParam(_ARG_1_, "CHG_HP_RATE") / 100
    _UPVALUE22_ = Enemy.GetExtraParam(_ARG_1_, "FAINT_TIME") * 60
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.targetHandle = NULL_HANDLE
    _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
    _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
    _ARG_0_.step = 0
    _ARG_0_.timer = 0
    _ARG_0_.timer2 = 0
    _ARG_0_.blasterModeChangeTimer = 0
    _ARG_0_.count = 0
    _ARG_0_.dmgCount = 0
    _ARG_0_.ptr = 0
    _ARG_0_.thunderBallHandle = {
      NULL_HANDLE,
      NULL_HANDLE,
      NULL_HANDLE,
      NULL_HANDLE,
      NULL_HANDLE,
      NULL_HANDLE
    }
    _ARG_0_.stack = Stack:Create()
    Entity.SetDropShadowDistance(_ARG_1_, 20)
    _UPVALUE23_:set(0, 0, 0)
    _ARG_0_.tailHandle = Entity.CreateEntity("b21ls00", _UPVALUE23_, _UPVALUE23_, _ARG_1_)
    Entity.AttachCoord(_ARG_1_, "X_longtail", _ARG_0_.tailHandle, "Root")
    _ARG_0_.blaster = {}
    _ARG_0_.blaster[1] = EntityManager:GetEntity((Entity.CreateEntity("b22ls00", _UPVALUE23_, _UPVALUE23_)))
    _ARG_0_.blaster[2] = EntityManager:GetEntity((Entity.CreateEntity("b23ls00", _UPVALUE23_, _UPVALUE23_)))
    _ARG_0_.blaster[1].blasterHandle = Entity.CreateEntity("b23ls00", _UPVALUE23_, _UPVALUE23_)
    _ARG_0_.blaster[2].blasterHandle = Entity.CreateEntity("b22ls00", _UPVALUE23_, _UPVALUE23_)
    Player.SetBossCamera("b20ls")
    _ARG_0_:GotoState("Appear")
  end,
  OnSetMotion = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    Entity.SetMotion(_ARG_0_.tailHandle, _ARG_1_, _ARG_2_, _ARG_3_)
    Entity.SetTimer(_ARG_0_.tailHandle, 10)
  end,
  OnReturnDamage = function(_ARG_0_)
    _ARG_0_:GotoState(_ARG_0_:GetState())
  end,
  OnHitAttack = function(_ARG_0_)
  end,
  OnDamageBefore = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    if Enemy.IsNoDamageReaction(_ARG_0_.myHandle) then
      return 0
    end
    _ARG_0_.dmgCount = _ARG_0_.dmgCount + 1
    if Script.Random() < _ARG_0_.dmgCount * _UPVALUE0_ then
      _ARG_0_.dmgCount = 0
      _ARG_0_.stack:clear()
      _ARG_0_.stack:push("AirMove")
      _ARG_0_.stack:push("Flee")
      _ARG_0_.stack:push("StartAirMove")
      if Script.Random() < 0.5 then
        _ARG_0_.stack:push("Electroshock")
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      end
      _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      return 1
    end
    return 0
  end,
  OnDamage = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    if _ARG_0_:GetState() == "ElectricalDischarge" then
      for _FORV_8_, _FORV_9_ in pairs(_ARG_0_.thunderBallHandle) do
        if _FORV_9_ ~= NULL_HANDLE then
          tb = EntityManager:GetEntity(_FORV_9_)
          if tb ~= nil then
            tb:Fire()
          end
          _ARG_0_.thunderBallHandle[1] = NULL_HANDLE
        end
      end
    end
    return 0
  end,
  OnDead = function(_ARG_0_)
    SetupBossDead(_ARG_0_.myHandle)
    _ARG_0_:GotoState("Dead")
    return 1
  end,
  OnUpdate = function(_ARG_0_)
    _ARG_0_:Update()
    _ARG_0_:Debug()
    if _ARG_0_.blasterModeChangeTimer > 0 then
      _ARG_0_.blasterModeChangeTimer = _ARG_0_.blasterModeChangeTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
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
        _ARG_0_.stack:push("AirMove")
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        _ARG_0_:GotoState(_UPVALUE0_[Script.GetDebugAttackNumber() + 1])
      end
    end
  end
}, {__index = __StateMachine})
EntityFactory:Add("b20ls00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b20lsTBall", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b20lsEBall", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
setmetatable({
  new = function(_ARG_0_)
    return setmetatable(__StateMachine:new(), _UPVALUE0_)
  end,
  states = {
    Wait = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Enemy.EnableInvincible(_ARG_0_.myHandle, 1)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
      end
    },
    Idling = {
      OnBeginState = function(_ARG_0_)
        if _ARG_0_.start then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        else
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 1)
          _ARG_0_.start = true
        end
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      end
    },
    TenShot = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.step = 0
        _ARG_0_.count = _UPVALUE1_
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 4 then
          _UPVALUE0_:set(0, -1.3, 0.3)
          Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "bone_06", _UPVALUE0_)
          _UPVALUE1_:set(0, 0, 0)
          Bullet.SetMaxMoveDist(CreateEnemyBullet(_UPVALUE2_, _ARG_0_.myHandle, _UPVALUE0_, _UPVALUE1_), 100)
          Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.targetHandle, 2)
          FVECTOR3.Sub(_UPVALUE1_, _UPVALUE1_, _UPVALUE0_)
          _UPVALUE1_:normalize()
          _UPVALUE1_:scale(_UPVALUE2_.speed)
          Entity.SetVelocity(CreateEnemyBullet(_UPVALUE2_, _ARG_0_.myHandle, _UPVALUE0_, _UPVALUE1_), _UPVALUE1_)
          _ARG_0_.step = 1
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.count = _ARG_0_.count - 1
          if 0 >= _ARG_0_.count then
            _ARG_0_:GotoState("Idling")
          else
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
            _ARG_0_.step = 0
          end
        end
      end
    },
    Attack = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    Explode = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.GetName(_ARG_0_.myHandle) == "b22ls00" and _ARG_0_.step == 0 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 92 then
          Entity.CameraAttachEffect(_ARG_0_.myHandle, _UPVALUE0_, "B012_BOM_02_0")
          _ARG_0_.step = 1
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Wait")
        end
      end
    },
    Breakdown = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
        Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle, 8)
        Enemy.MakePrize(_ARG_0_.myHandle, _UPVALUE1_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Wait")
        end
      end
    }
  },
  Possession = function(_ARG_0_)
    Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
    Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
    Enemy.EnableInvincible(_ARG_0_.myHandle, 0)
    Enemy.CompleteRecoveryHp(_ARG_0_.myHandle)
    _ARG_0_.start = false
    _ARG_0_:GotoState("Idling")
  end,
  CalcTargetDistance = function(_ARG_0_, _ARG_1_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 8)
    Entity.GetWorldPos(_UPVALUE1_, _ARG_1_)
    FVECTOR3.Sub(_UPVALUE0_, _UPVALUE0_, _UPVALUE1_)
    return _UPVALUE0_:dot(_UPVALUE0_)
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    _UPVALUE0_ = Entity.GetMotionIndex(_ARG_1_, "010")
    _UPVALUE1_ = Entity.GetMotionIndex(_ARG_1_, "011")
    _UPVALUE2_ = Entity.GetMotionIndex(_ARG_1_, "300")
    _UPVALUE3_ = Entity.GetMotionIndex(_ARG_1_, "310")
    _UPVALUE4_ = Entity.GetMotionIndex(_ARG_1_, "320")
    _UPVALUE5_ = Entity.GetMotionIndex(_ARG_1_, "330")
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.targetHandle = NULL_HANDLE
    _ARG_0_.blasterHandle = NULL_HANDLE
    _ARG_0_.step = 0
    _ARG_0_.timer = 0
    _ARG_0_.count = 0
    _ARG_0_.start = false
    Enemy.EnableInvincible(_ARG_1_, 1)
    Entity.FixDropShadowBgPos(_ARG_1_, true)
    Entity.SetLockOnBoneNum(_ARG_1_, 8)
    Entity.EnableBgColl(_ARG_1_, 0)
    Entity.EnableLockonAndShooton(_ARG_1_, 0)
    Enemy.EnableNoDamageReaction(_ARG_1_, 1)
    _ARG_0_:GotoState("Wait")
  end,
  OnReturnDamage = function(_ARG_0_)
  end,
  OnHitAttack = function(_ARG_0_)
  end,
  OnDamage = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    Enemy.SetHP(_ARG_0_.blasterHandle, Enemy.GetHp(_ARG_0_.myHandle))
    return 0
  end,
  OnUpdatePositionAfter = function(_ARG_0_)
  end,
  OnDead = function(_ARG_0_)
    Enemy.SetHP(_ARG_0_.blasterHandle, Enemy.GetHp(_ARG_0_.myHandle))
    if EntityManager:GetEntity(_ARG_0_.blasterHandle) ~= nil then
      EntityManager:GetEntity(_ARG_0_.blasterHandle):GotoState("Breakdown")
    end
    _ARG_0_:GotoState("Breakdown")
    return 1
  end,
  OnGuard = function(_ARG_0_)
    Entity.GetGuardCrossPos(_UPVALUE0_, _ARG_0_.myHandle)
    _UPVALUE1_:set(0, 0, 0)
    Entity.SetEffect(_ARG_0_.myHandle, "p_ex_bas_00", "P_EX_ATC_DIS1_0", _UPVALUE0_, _UPVALUE1_)
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
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        _ARG_0_:GotoState(_UPVALUE0_[Script.GetDebugAttackNumber() + 1])
      end
    end
  end
}, {__index = __StateMachine})
EntityFactory:Add("b22ls00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b23ls00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
