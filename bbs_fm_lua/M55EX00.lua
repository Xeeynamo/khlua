setmetatable({
  new = function(_ARG_0_)
    return setmetatable(__StateMachine:new(), _UPVALUE0_)
  end,
  states = {
    Appear = {
      OnBeginState = function(_ARG_0_)
        if Enemy.IsAllEnemyWaiting() then
          SetupAppearBegin(_ARG_0_.myHandle, -1, _UPVALUE0_, 0)
        else
          SetupAppearBegin(_ARG_0_.myHandle, -1, _UPVALUE0_, 1)
        end
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        Enemy.EnableInvincible(_ARG_0_.myHandle, 1)
        Entity.EnableGuard(_ARG_0_.myHandle, 1)
        _ARG_0_.step = 0
        _ARG_0_.count = 0
      end,
      OnEndState = function(_ARG_0_)
        SetupAppearEnd(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsModelFade(_ARG_0_.myHandle) == false then
            Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
            Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            if Entity.GetName(_ARG_0_.myHandle) == "m58ex00" then
              _ARG_0_.step = 2
            else
              _ARG_0_.step = 3
            end
          end
        elseif _ARG_0_.step == 2 then
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE1_ then
            Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
            _ARG_0_:AppearMissPrizePot()
            _ARG_0_.step = 3
          end
        elseif _ARG_0_:CanShuffle() then
          _ARG_0_:GotoState("Shuffle")
        end
      end
    },
    Waiting = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        Enemy.EnableInvincible(_ARG_0_.myHandle, 1)
        Entity.EnableGuard(_ARG_0_.myHandle, 1)
        _ARG_0_.count = 0
      end,
      OnEndState = function(_ARG_0_)
        _ARG_0_:AppearMissPrizePot()
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if Enemy.IsAllEnemyWaiting() == false then
          _ARG_0_:GotoState("Shuffle")
        end
      end
    },
    Shuffle = {
      OnBeginState = function(_ARG_0_)
        if Entity.GetName(_ARG_0_.myHandle) == "m55ex00" then
          SetupAppearBegin(_ARG_0_.myHandle, -1, _UPVALUE0_, 1)
          _ARG_0_.step = 0
        else
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
          _ARG_0_.step = 1
        end
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        Entity.EnableAvoidPlayer(_ARG_0_.myHandle, 1)
        Entity.EnableAvoidEnemy(_ARG_0_.myHandle, 1)
        _ARG_0_.timer = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.EnableAvoidPlayer(_ARG_0_.myHandle, 0)
        Entity.EnableAvoidEnemy(_ARG_0_.myHandle, 0)
        Enemy.EnableInvincible(_ARG_0_.myHandle, 0)
        Entity.EnableGuard(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 1 and Entity.IsModelFade(_ARG_0_.myHandle) == false then
          Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
          Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
          Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
          _ARG_0_.step = 2
        end
        _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.timer <= 0 or 1 >= Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) then
          if Entity.GetName(_ARG_0_.myHandle) == "m58ex00" then
            Entity.GetStartPos(_ARG_0_.targetPos, _ARG_0_.myHandle)
          else
            Entity.GetStartPos(_ARG_0_.targetPos, _ARG_0_.hitHandle)
          end
          _ARG_0_:CalcTargetPos(_ARG_0_.targetPos, _UPVALUE0_, _UPVALUE1_)
          _ARG_0_.timer = _UPVALUE2_
        end
        _ARG_0_:CalcTargetVelocity(_ARG_0_.targetPos, 7.5, _UPVALUE3_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Wander")
        end
      end
    },
    Wander = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, 0)
        Entity.EnableAvoidPlayer(_ARG_0_.myHandle, 1)
        Entity.EnableAvoidEnemy(_ARG_0_.myHandle, 1)
        Entity.GetStartPos(_ARG_0_.targetPos, _ARG_0_.myHandle)
        _ARG_0_.step = 0
        _ARG_0_.timer = 0
        _ARG_0_.idlingTimer = 0
        _ARG_0_.count = Script.RandomInteger(3) + 3
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.EnableAvoidPlayer(_ARG_0_.myHandle, 0)
        Entity.EnableAvoidEnemy(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
          if _ARG_0_.step == 0 then
            _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
            if 0 >= _ARG_0_.timer or Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) <= 1 then
              _ARG_0_.count = _ARG_0_.count - 1
              if 0 >= _ARG_0_.count then
                Entity.ClearSpeed(_ARG_0_.myHandle)
                _ARG_0_.idlingTimer = _UPVALUE0_
                _ARG_0_.step = 1
                return
              else
                Entity.GetStartPos(_ARG_0_.targetPos, _ARG_0_.myHandle)
                _ARG_0_:CalcTargetPos(_ARG_0_.targetPos, _UPVALUE1_, _UPVALUE2_)
                _ARG_0_.timer = _UPVALUE3_
              end
            end
            _ARG_0_:CalcTargetVelocity(_ARG_0_.targetPos, 7.5, _ARG_0_.speed)
          else
            _ARG_0_.idlingTimer = _ARG_0_.idlingTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
            if 0 >= _ARG_0_.idlingTimer then
              _ARG_0_.step = 0
              _ARG_0_.timer = 0
              _ARG_0_.count = Script.RandomInteger(3) + 3
            end
          end
        else
          if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) then
            if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE4_ then
              _ARG_0_:GotoState("Evade")
              return
            else
              Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE5_)
            end
          end
          _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 >= _ARG_0_.timer then
            Entity.GetStartPos(_ARG_0_.targetPos, _ARG_0_.myHandle)
            _ARG_0_:CalcTargetPos(_ARG_0_.targetPos, _UPVALUE1_, _UPVALUE2_)
            _ARG_0_.timer = _UPVALUE3_
          end
          _ARG_0_:CalcTargetVelocity(_ARG_0_.targetPos, 7.5, _ARG_0_.speed)
        end
      end
    },
    Evade = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        Entity.EnableAvoidEnemy(_ARG_0_.myHandle, 1)
        Entity.GetStartPos(_ARG_0_.targetPos, _ARG_0_.myHandle)
        _ARG_0_.step = 0
        _ARG_0_.timer = 0
        _ARG_0_.count = Script.RandomInteger(3) + 3
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.EnableAvoidEnemy(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 >= _ARG_0_.timer or Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) <= 1 then
            _ARG_0_.count = _ARG_0_.count - 1
            if 0 >= _ARG_0_.count then
              Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
              Entity.ClearSpeed(_ARG_0_.myHandle)
              _ARG_0_.step = 1
              return
            else
              Entity.GetStartPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
              _ARG_0_:CalcTargetPos(_ARG_0_.targetPos, _UPVALUE1_, _UPVALUE2_)
              _ARG_0_.timer = _UPVALUE3_
            end
          end
          _ARG_0_:CalcTargetVelocity(_ARG_0_.targetPos, 7.5, _ARG_0_.speed)
          _ARG_0_:EvadeTarget(10)
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:GotoState("Wander")
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.step = 0
          _ARG_0_.timer = 0
          _ARG_0_.count = Script.RandomInteger(3) + 3
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE4_)
        end
      end
    },
    Disappear = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        SetupDisappear(_ARG_0_.myHandle, 30)
        if EntityManager:GetEntity(_ARG_0_.manager) ~= nil then
          EntityManager:GetEntity(_ARG_0_.manager).missPotCount = EntityManager:GetEntity(_ARG_0_.manager).missPotCount + 1
        end
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsModelFade(_ARG_0_.myHandle) == false then
          Enemy.Dead(_ARG_0_.myHandle)
        end
      end
    }
  },
  AppearMissPrizePot = function(_ARG_0_)
    if Entity.GetName(_ARG_0_.myHandle) ~= "m58ex00" then
      return
    end
    if EntityManager:GetEntity(_ARG_0_.manager) ~= nil then
      EntityManager:GetEntity(_ARG_0_.manager).step = 2
    end
  end,
  CanShuffle = function(_ARG_0_)
    if Enemy.IsAllEnemyWaiting() then
      return false
    end
    if Entity.GetName(_ARG_0_.myHandle) ~= "m58ex00" then
      return false
    end
    if EntityManager:GetEntity(_ARG_0_.manager) ~= nil and EntityManager:GetEntity(_ARG_0_.manager).step ~= 3 then
      return false
    end
    return true
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
    _UPVALUE1_:set(0, 0, _ARG_3_)
    Math.RotateVectorXYZ(_UPVALUE1_, _UPVALUE0_)
    Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE1_)
  end,
  CalcTargetPos = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    _UPVALUE0_:set(Math.Cos((Script.RandomInRange(-PI, PI))) * (Script.Random() * _ARG_2_), 0, Math.Sin((Script.RandomInRange(-PI, PI))) * (Script.Random() * _ARG_2_))
    FVECTOR3.Add(_ARG_1_, _ARG_1_, _UPVALUE0_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
    _UPVALUE1_:copy(_UPVALUE0_)
    _UPVALUE1_:sety(_UPVALUE0_:gety() - 20)
    Collision.IntersectRayBg(_UPVALUE1_, COLL_KIND_ENEMY, _UPVALUE0_, _UPVALUE1_)
    _ARG_0_.targetPos:sety(_UPVALUE1_:gety() + Script.Random() * _ARG_3_)
  end,
  EvadeTarget = function(_ARG_0_, _ARG_1_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
    Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.targetHandle)
    FVECTOR3.Sub(_UPVALUE2_, _UPVALUE0_, _UPVALUE1_)
    if _ARG_1_ > _UPVALUE2_:length() then
      Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
      Entity.GetVelocity(_UPVALUE0_, _ARG_0_.myHandle)
      _UPVALUE2_:set(0, RoundPI(Math.Atan2(_UPVALUE2_:getx(), _UPVALUE2_:getz()) - _UPVALUE1_:gety()) * ((_ARG_1_ - _UPVALUE2_:length()) * 0.1), 0)
      Math.RotateVectorXYZ(_UPVALUE0_, _UPVALUE2_)
      Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE0_)
      _UPVALUE1_:sety(RoundPI(_UPVALUE1_:gety() + RoundPI(Math.Atan2(_UPVALUE2_:getx(), _UPVALUE2_:getz()) - _UPVALUE1_:gety()) * ((_ARG_1_ - _UPVALUE2_:length()) * 0.1)))
      Entity.SetRot(_ARG_0_.myHandle, _UPVALUE1_)
    end
  end,
  IsChangeStateDisappear = function(_ARG_0_)
    if Entity.GetName(_ARG_0_.myHandle) ~= "m55ex00" then
      return false
    end
    if _ARG_0_:GetState() == "Disappear" then
      return false
    end
    if Enemy.GetEnemyFromName(_UPVALUE0_, true) ~= NULL_HANDLE then
      return false
    end
    return true
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    if _UPVALUE0_ == false and Entity.GetName(_ARG_1_) == "m58ex00" then
      _UPVALUE1_ = Enemy.GetExtraParam(_ARG_1_, "AppearDist")
      _UPVALUE1_ = _UPVALUE1_ * _UPVALUE1_
      _UPVALUE2_ = Enemy.GetExtraParam(_ARG_1_, "ShuffleR")
      _UPVALUE3_ = Enemy.GetExtraParam(_ARG_1_, "ShuffleTime") * 60
      _UPVALUE0_ = true
    end
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_1_, SEARCH_TYPE_NEAR)
    _ARG_0_.step = 0
    _ARG_0_.timer = 0
    _ARG_0_.idlingTimer = 0
    _ARG_0_.speedUpTimer = 0
    _ARG_0_.count = 0
    _ARG_0_.round = 0
    _ARG_0_.speed = _UPVALUE4_
    _ARG_0_.effHandle = NULL_HANDLE
    _ARG_0_.hitHandle = NULL_HANDLE
    _ARG_0_.manager = NULL_HANDLE
    _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
    Entity.EnableGuardPhysical(_ARG_1_, 1)
    Entity.EnableGuardFire(_ARG_1_, 1)
    Entity.EnableGuardIce(_ARG_1_, 1)
    Entity.EnableGuardThunder(_ARG_1_, 1)
    Entity.EnableGuardSpecial(_ARG_1_, 1)
    Entity.EnableGuardZeroEx(_ARG_1_, 1)
    Entity.SetGuardDir(_ARG_1_, 360)
    Enemy.InitHP(_ARG_1_, 1, true)
    if Entity.GetName(_ARG_0_.myHandle) == "m55ex00" then
      _ARG_0_:GotoState("Shuffle")
    else
      _ARG_0_:GotoState("Appear")
    end
  end,
  OnDestroy = function(_ARG_0_)
    Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
  end,
  OnSetMotion = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    if Entity.GetName(_ARG_0_.myHandle) == "m55ex00" then
      return
    end
    for _FORV_7_, _FORV_8_ in pairs(_UPVALUE0_) do
      if _FORV_8_[1] == _ARG_1_ then
        Entity.GetDamageCrossPos(_UPVALUE1_, _ARG_0_.myHandle)
        _UPVALUE2_:set(0, 0, 0)
        Entity.SetEffect(_ARG_0_.myHandle, "e_ex580", _FORV_8_[2], _UPVALUE1_, _UPVALUE2_)
        break
      end
    end
  end,
  OnDamage = function(_ARG_0_, _ARG_1_, _ARG_2_)
    if _ARG_0_:IsChangeStateDisappear() then
      _ARG_0_:GotoState("Disappear")
    end
    _ARG_0_.speed = _UPVALUE0_
    _ARG_0_.speedUpTimer = Script.RandomInRange(_UPVALUE1_, _UPVALUE1_ * 2)
    return 0
  end,
  OnDead = function(_ARG_0_)
    if Entity.GetName(_ARG_0_.myHandle) == "m55ex00" then
      Mission.SendMissonMessage(MES_POT_DUMMY_OUT)
      Sound.PlaySe(297, 7)
    else
      Sound.PlaySe(297, 6)
    end
    return 0
  end,
  OnReturnDamage = function(_ARG_0_)
    _ARG_0_:GotoState("Wander")
  end,
  OnUpdate = function(_ARG_0_)
    _ARG_0_:Update()
    if _ARG_0_.speedUpTimer > 0 then
      _ARG_0_.speedUpTimer = _ARG_0_.speedUpTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
      if _ARG_0_.speedUpTimer <= 0 then
        _ARG_0_.speed = _UPVALUE0_
      end
    end
    if _ARG_0_:IsChangeStateDisappear() then
      _ARG_0_:GotoState("Disappear")
    end
  end
}, {__index = __StateMachine})
EntityFactory:Add("m55ex00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("m58ex00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("m59ex00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
