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
          _ARG_0_:GotoState("Idling")
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
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    Idling = {
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
    Move = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        Entity.EnableAvoidPlayer(_ARG_0_.myHandle, 1)
        Entity.EnableAvoidEnemy(_ARG_0_.myHandle, 1)
        _ARG_0_.rotX = 0
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
          _ARG_0_.targetPos:sety(_ARG_0_.targetPos:gety() - Entity.GetFloorDistance(_ARG_0_.targetHandle) + Script.Random() * 1.5)
          _ARG_0_.timer = _UPVALUE0_ + _UPVALUE0_ * Script.Random()
          _ARG_0_.count = _ARG_0_.count - 1
          if 0 >= _ARG_0_.count then
            _ARG_0_:GotoState("Idling")
            return
          end
        end
        _ARG_0_:CalcTargetVelocity(_ARG_0_.targetPos, 2.5, _UPVALUE1_)
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
            if Script.Random() < 0.7 then
              if _ARG_0_:RestHpRate() >= 0.5 then
                _ARG_0_:GotoState("LumpOfIce")
              else
                _ARG_0_:GotoState("Freeze")
              end
            else
              Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE3_)
              _ARG_0_.step = 1
            end
          elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) >= _UPVALUE2_ and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE4_ then
            if _ARG_0_:RestHpRate() >= 0.5 then
              if Script.Random() < 0.6 then
                _ARG_0_:GotoState("Blizzard")
              elseif Script.Random() >= 0.6 and Script.Random() < 0.8 then
                _ARG_0_:GotoState("LumpOfIce")
              else
                Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE3_)
                _ARG_0_.step = 1
              end
            elseif Script.Random() < 0.8 then
              _ARG_0_:GotoState("Freeze")
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
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    Blizzard = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle, 0)
          Entity.TurnTargetDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 20)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 28 then
            Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle, 2)
            Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
            CreateEnemyBullet(_UPVALUE0_, _ARG_0_.myHandle, _ARG_0_.myPos, _ARG_0_.rot)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_:TurnX(0, 10) == false then
          _ARG_0_:GotoState("Sneer")
        end
      end
    },
    LumpOfIce = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableGravity(_ARG_0_.bulletHandle, 1)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 35 then
            Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
            Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
            _ARG_0_.targetPos:sety(_ARG_0_.targetPos:gety() + 2.5)
            _ARG_0_.bulletHandle = CreateEnemyBullet(_UPVALUE0_, _ARG_0_.myHandle, _ARG_0_.targetPos, _ARG_0_.rot)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
          _ARG_0_.targetPos:sety(_ARG_0_.targetPos:gety() + 2.5)
          Entity.SetLocalPos(_ARG_0_.bulletHandle, _ARG_0_.targetPos)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 46 then
            Entity.EnableGravity(_ARG_0_.bulletHandle, 1)
            _ARG_0_.step = 2
          end
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Sneer")
        end
      end
    },
    Freeze = {
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
          Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
          _ARG_0_:CalcTargetVelocity(_ARG_0_.targetPos, 2.5, _UPVALUE0_)
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) <= 2.25 then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE2_)
            _ARG_0_.step = 1
          end
        else
          Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
          _ARG_0_:CalcTargetVelocity(_ARG_0_.targetPos, 2.5, _UPVALUE0_ * 0.5)
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:GotoState("Sneer")
          end
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
  RestHpRate = function(_ARG_0_)
    return Enemy.GetHp(_ARG_0_.myHandle) / Enemy.GetHpMax(_ARG_0_.myHandle)
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
    _ARG_0_.workVec3 = FVECTOR3.new(0, 0, 0)
    _ARG_0_.step = 0
    _ARG_0_.step2 = 0
    _ARG_0_.targetHandle = NULL_HANDLE
    _ARG_0_.bulletHandle = NULL_HANDLE
    _ARG_0_.dmgCount = 0
    _ARG_0_.rotX = 0
    if Enemy.IsAllEnemyWaiting() then
      _ARG_0_:GotoState("Waiting")
    else
      _ARG_0_:GotoState("Appear")
    end
  end,
  OnDestroy = function(_ARG_0_)
    Entity.EnableGravity(_ARG_0_.bulletHandle, 1)
  end,
  OnHitAttack = function(_ARG_0_, _ARG_1_)
    if Entity.GetCurrentMotion(_ARG_0_.myHandle) == _UPVALUE0_ then
      Entity.SetTimer(_ARG_0_.myHandle, 0)
    end
  end,
  OnDamage = function(_ARG_0_, _ARG_1_, _ARG_2_)
    _ARG_0_.dmgCount = _ARG_0_.dmgCount + 1
    Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
    _ARG_0_.rot:setx(0)
    Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
    Entity.EnableGravity(_ARG_0_.bulletHandle, 1)
    return 0
  end,
  OnReturnDamage = function(_ARG_0_)
    _ARG_0_:GotoState("Idling")
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
EntityFactory:Add("m17ex00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("m17vs00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
