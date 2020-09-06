setmetatable({
  new = function(_ARG_0_)
    return setmetatable(__StateMachine:new(), _UPVALUE0_)
  end,
  states = {
    Appear = {
      OnBeginState = function(_ARG_0_)
        SetupAppearBegin(_ARG_0_.myHandle, -1, _UPVALUE0_, 1)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        SetupAppearEnd(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 and Entity.IsModelFade(_ARG_0_.myHandle) == false then
          Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
          Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
          Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
          _ARG_0_.step = 1
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Move")
        end
      end
    },
    Waiting = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Enemy.IsAllEnemyWaiting() == false then
          _ARG_0_:GotoState("Move")
        end
      end
    },
    Move = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        Entity.EnableAvoidPlayer(_ARG_0_.myHandle, 1)
        Entity.EnableAvoidEnemy(_ARG_0_.myHandle, 1)
        _ARG_0_.step = 0
        _ARG_0_.timer = 0
        _ARG_0_.count = 5 + Script.RandomInteger(10)
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.EnableAvoidPlayer(_ARG_0_.myHandle, 0)
        Entity.EnableAvoidEnemy(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.timer <= 0 or Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) <= 1 then
          Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
          _ARG_0_.workVec0:set(Math.Cos((RoundPI(DegToRad(Script.Random() * 360)))) * (Script.Random() * 7.5), 0, Math.Sin((RoundPI(DegToRad(Script.Random() * 360)))) * (Script.Random() * 7.5))
          FVECTOR3.Add(_ARG_0_.targetPos, _ARG_0_.targetPos, _ARG_0_.workVec0)
          Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.myHandle)
          _ARG_0_.targetPos:sety(_ARG_0_.targetPos:gety() - Entity.GetFloorDistance(_ARG_0_.targetHandle) + Script.Random() * 1)
          _ARG_0_.timer = _UPVALUE0_ + _UPVALUE0_ * Script.Random()
          _ARG_0_.count = _ARG_0_.count - 1
          if 0 >= _ARG_0_.count then
            _ARG_0_:GotoState("Stiff")
            return
          end
        end
        _ARG_0_:CalcTargetVelocity(_ARG_0_.targetPos, 10, _UPVALUE1_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        if CanDisappear(_ARG_0_.myHandle, _ARG_0_.targetHandle) then
          _ARG_0_:GotoState("Disappear")
          return
        end
        if _ARG_0_.step == 0 then
          if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) == false then
            return
          end
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE2_ then
            if Script.Random() < 0.4 then
              _ARG_0_.attackKind = 1
              _ARG_0_:GotoState("Sneer")
            elseif Script.Random() >= 0.4 and Script.Random() < 0.7 then
              _ARG_0_.attackKind = 0
              _ARG_0_:GotoState("Sneer")
            else
              Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE3_)
              _ARG_0_.step = 1
            end
          elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) >= _UPVALUE2_ and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE4_ then
            if Script.Random() < 0.3 then
              _ARG_0_.attackKind = 0
              _ARG_0_:GotoState("Sneer")
            elseif Script.Random() >= 0.3 and Script.Random() < 0.7 then
              _ARG_0_.attackKind = 2
              _ARG_0_:GotoState("Sneer")
            else
              Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE3_)
              _ARG_0_.step = 1
            end
          else
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE3_)
            _ARG_0_.step = 1
          end
        elseif Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_.step = 0
        end
      end
    },
    Sneer = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 0)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          if _ARG_0_.attackKind == 0 then
            _ARG_0_:GotoState("Thunder")
          elseif _ARG_0_.attackKind == 1 then
            _ARG_0_:GotoState("Lightning")
          else
            _ARG_0_:GotoState("BoltCharge")
          end
        end
      end
    },
    Thunder = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        _ARG_0_.step = 0
        _ARG_0_.step2 = 0
        _ARG_0_.effHandle = NULL_HANDLE
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          if 10 <= Entity.GetMotionNowFrame(_ARG_0_.myHandle) then
            Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.targetHandle)
            _ARG_0_.workVec1:copy(_ARG_0_.workVec0)
            _ARG_0_.workVec0:sety(_ARG_0_.workVec0:gety() + 1)
            _ARG_0_.workVec1:sety(_ARG_0_.workVec1:gety() - 20)
            Collision.IntersectRayBg(_ARG_0_.workVec0, COLL_KIND_ENEMY, _ARG_0_.workVec0, _ARG_0_.workVec1)
            _ARG_0_.workVec1:set(0, 0, 0)
            _ARG_0_.effHandle = Entity.SetEffect(_ARG_0_.myHandle, "e_ex180", "E018_THD_00_0", _ARG_0_.workVec0, _ARG_0_.workVec1)
            Enemy.SetGeneralPurposeAttackColl(_ARG_0_.myHandle, COLL_KIND_ENEMY, COLL_SHAPE_CYLINDER, 0.3)
            Enemy.SetGeneralPurposeAttackCollParam(_ARG_0_.myHandle, Enemy.GetAttackKind(_ARG_0_.myHandle, 0), Enemy.GetAttackAttr(_ARG_0_.myHandle, 0), Enemy.GetAttackPoint(_ARG_0_.myHandle, 0), Enemy.GetAttackPowerCorrection(_ARG_0_.myHandle, 0))
            Enemy.SetGeneralPurposeAttackCollHitAttackEffectName(_ARG_0_.myHandle, "e_ex180", "E018_THD_01_0")
            Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 0)
            _ARG_0_.workVec1:copy(_ARG_0_.workVec0)
            _ARG_0_.workVec0:sety(_ARG_0_.workVec0:gety() + 3)
            Enemy.SetGeneralPurposeAttackCollPos(_ARG_0_.myHandle, _ARG_0_.workVec0, _ARG_0_.workVec1)
            _ARG_0_.step = 1
          end
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Stiff")
        end
      end
    },
    Lightning = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.velocity:set(0, 0.025, 0)
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
          Entity.TurnTargetDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 30)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 26 then
            Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
            FVECTOR3.Sub(_ARG_0_.velocity, _ARG_0_.targetPos, _ARG_0_.myPos)
            Entity.SetTimer(_ARG_0_.myHandle, (_ARG_0_.velocity:length() + 2.5) / _UPVALUE0_)
            _ARG_0_.velocity:normalize()
            _ARG_0_.velocity:scale(_UPVALUE0_)
            Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.IsWall(_ARG_0_.myHandle) or Entity.IsCeiling(_ARG_0_.myHandle) then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_:TurnX(0, 10) == false then
          _ARG_0_:GotoState("Stiff")
        end
      end
    },
    BoltCharge = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle, 2)
        Entity.SetTimer(_ARG_0_.myHandle, 0)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        _ARG_0_.step = 0
        _ARG_0_.count = 0
        _ARG_0_.timer = _UPVALUE1_
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) < 1 then
          Entity.SetTimer(_ARG_0_.myHandle, 120)
          Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
          Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
          FVECTOR3.Sub(_ARG_0_.workVec0, _ARG_0_.targetPos, _ARG_0_.myPos)
          _ARG_0_.workVec0:normalize()
          _ARG_0_.workVec0:scale(5)
          FVECTOR3.Add(_ARG_0_.targetPos, _ARG_0_.myPos, _ARG_0_.workVec0)
        end
        _ARG_0_:CalcTargetVelocity(_ARG_0_.targetPos, 5, _UPVALUE0_)
        _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.count >= 3 or _ARG_0_.timer <= 0 then
          _ARG_0_:GotoState("Stiff")
        end
      end
    },
    Stiff = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Move")
        end
      end
    },
    Disappear = {
      OnBeginState = function(_ARG_0_)
        SetupDisappear(_ARG_0_.myHandle, 30)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsModelFade(_ARG_0_.myHandle) == false then
          Enemy.Disappear(_ARG_0_.myHandle)
        end
      end
    }
  },
  TurnX = function(_ARG_0_, _ARG_1_, _ARG_2_)
    Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
    _ARG_0_.rot:setx(HomingDegree(_ARG_0_.rot:getx(), _ARG_1_, _ARG_2_, Entity.GetFrameRate(_ARG_0_.myHandle)))
    Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
    return HomingDegree(_ARG_0_.rot:getx(), _ARG_1_, _ARG_2_, Entity.GetFrameRate(_ARG_0_.myHandle))
  end,
  CalcTargetVelocity = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.myHandle)
    FVECTOR3.Sub(_ARG_0_.workVec1, _ARG_1_, _ARG_0_.workVec0)
    _ARG_0_.workVec1:normalize()
    FVECTOR3.Mul(_ARG_0_.workVec2, _ARG_0_.workVec1, _ARG_0_.workVec1)
    Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
    _ARG_0_.rot:sety(HomingDegree(_ARG_0_.rot:gety(), Math.Atan2(_ARG_0_.workVec1:getx(), _ARG_0_.workVec1:getz()), _ARG_2_, (Entity.GetFrameRate(_ARG_0_.myHandle))))
    Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
    _ARG_0_.rot:setx(-Math.Atan2(_ARG_0_.workVec1:gety(), Math.Sqrt(_ARG_0_.workVec2:getx() + _ARG_0_.workVec2:getz())))
    _ARG_0_.velocity:set(0, 0, _ARG_3_)
    Math.RotateVectorXYZ(_ARG_0_.velocity, _ARG_0_.rot)
    Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    _ARG_0_.myHandle = _ARG_1_
    Entity.SetMovementCollRadius(_ARG_0_.myHandle, 0.9)
    Entity.SetLowerHalf(_ARG_0_.myHandle, 1.4)
    _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
    _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
    _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.workVec0 = FVECTOR3.new(0, 0, 0)
    _ARG_0_.workVec1 = FVECTOR3.new(0, 0, 0)
    _ARG_0_.workVec2 = FVECTOR3.new(0, 0, 0)
    _ARG_0_.step = 0
    _ARG_0_.step2 = 0
    _ARG_0_.targetHandle = NULL_HANDLE
    _ARG_0_.effHandle = NULL_HANDLE
    _ARG_0_.timer = 0
    _ARG_0_.attackKind = 0
    _ARG_0_.count = 0
    if Enemy.IsAllEnemyWaiting() then
      _ARG_0_:GotoState("Waiting")
    else
      _ARG_0_:GotoState("Appear")
    end
  end,
  OnHitAttack = function(_ARG_0_)
    if Entity.GetCurrentMotion(_ARG_0_.myHandle) == _UPVALUE0_ then
      _ARG_0_.count = _ARG_0_.count + 1
      _ARG_0_.timer = _UPVALUE1_
    end
  end,
  OnDamage = function(_ARG_0_, _ARG_1_, _ARG_2_)
    Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
    _ARG_0_.rot:setx(0)
    Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
    return 0
  end,
  OnReturnDamage = function(_ARG_0_)
    _ARG_0_:GotoState("Move")
  end,
  OnUpdatePositionAfter = function(_ARG_0_)
    if Effect.IsAlive(_ARG_0_.effHandle) then
      if _ARG_0_.step2 == 0 then
        if Effect.GetNowFrame(_ARG_0_.effHandle) >= 40 then
          Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 1)
          _ARG_0_.step2 = 1
        end
      elseif _ARG_0_.step2 == 1 and Effect.GetNowFrame(_ARG_0_.effHandle) >= 60 then
        Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 0)
        _ARG_0_.step2 = 2
      end
    else
      Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 0)
    end
  end,
  OnUpdate = function(_ARG_0_)
    if Entity.IsAlive(_ARG_0_.targetHandle) == false then
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
    end
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
        _ARG_0_:GotoState(_UPVALUE0_[Script.GetDebugAttackNumber() + 1])
      end
    end
  end
}, {__index = __StateMachine})
EntityFactory:Add("m18ex00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("m18vs00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
