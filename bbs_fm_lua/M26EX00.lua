setmetatable({
  new = function(_ARG_0_)
    return setmetatable(__StateMachine:new(), _UPVALUE0_)
  end,
  states = {
    Appear = {
      OnBeginState = function(_ARG_0_)
        SetupAppearBegin(_ARG_0_.myHandle, -1, _UPVALUE0_, 1)
        Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
        _UPVALUE2_:set(0, 0, 0)
        Entity.SetEffect(_ARG_0_.myHandle, _UPVALUE3_, "E026_APP_00_0", _UPVALUE1_, _UPVALUE2_)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        SetupAppearEnd(_ARG_0_.myHandle)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
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
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 1)
        Entity.SetTimer(_ARG_0_.myHandle, 10)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Enemy.IsAllEnemyWaiting() == false and Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Move")
        end
      end
    },
    Move = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, Script.RandomInRange(_UPVALUE1_, _UPVALUE1_ * 2))
        _ARG_0_.timer = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.timer <= 0 then
          if EntityManager:GetEntity((Enemy.GetLeader(_ARG_0_.myHandle))) ~= nil and EntityManager:GetEntity((Enemy.GetLeader(_ARG_0_.myHandle))):GetState() == "Move" then
            Entity.GetWorldPos(_ARG_0_.targetPos, (Enemy.GetLeader(_ARG_0_.myHandle)))
          else
            Entity.GetStartPos(_UPVALUE0_, _ARG_0_.myHandle)
            _UPVALUE1_:set(Math.Cos((Script.RandomInRange(-PI, PI))) * (15 * Script.Random()), 2 * Script.Random(), Math.Sin((Script.RandomInRange(-PI, PI))))
            FVECTOR3.Add(_ARG_0_.targetPos, _UPVALUE0_, _UPVALUE1_)
            Collision.IntersectRayBg(_ARG_0_.targetPos, COLL_KIND_ENEMY, _ARG_0_.targetPos, _UPVALUE0_)
          end
          _ARG_0_.timer = 120
        end
        _ARG_0_:CalcTargetVelocity(_ARG_0_.targetPos, 2.5, _UPVALUE2_)
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) <= 1 then
          _ARG_0_.timer = 0
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
          return
        end
        if Enemy.IsLeader(_ARG_0_.myHandle) then
          Enemy.SendGroupMessage(_ARG_0_.myHandle, 0, _UPVALUE3_)
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    Idling = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        if Enemy.IsLeader(_ARG_0_.myHandle) then
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        else
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE2_)
        end
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
            return
          end
          if Enemy.IsLeader(_ARG_0_.myHandle) then
            if Script.Random() < _UPVALUE0_ then
              Enemy.SendMessage(Enemy.SendGroupMessage(_ARG_0_.myHandle, _UPVALUE1_ * 0.5, _UPVALUE2_) * (_UPVALUE1_ * 0.5), _ARG_0_.myHandle, _ARG_0_.myHandle, _UPVALUE2_)
            else
              Enemy.SendMessage(Enemy.SendGroupMessage(_ARG_0_.myHandle, _UPVALUE3_, _UPVALUE4_) * _UPVALUE3_, _ARG_0_.myHandle, _ARG_0_.myHandle, _UPVALUE4_)
            end
            _ARG_0_.step = 1
          else
            _ARG_0_:GotoState("Move")
          end
        end
      end
    },
    Rush = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _UPVALUE1_:set(0, 0, 0)
        _ARG_0_.effHandle = Entity.AttachEffect(_ARG_0_.myHandle, _UPVALUE2_, "E026_SPA_00_0", "Root", _UPVALUE1_, _UPVALUE1_)
        _UPVALUE1_:set(0, 0.025, 0)
        Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE1_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
        _UPVALUE0_:setx(0)
        Entity.SetRot(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.LoopEndEffectAttach(_ARG_0_.myHandle, 0)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
          Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.targetHandle, 2)
          if Effect.IsAlive(_ARG_0_.effHandle) == false then
            Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
            FVECTOR3.Sub(_ARG_0_.velocity, _UPVALUE0_, _ARG_0_.myPos)
            Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_.velocity:length() / _UPVALUE1_ * 1.5)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.velocity:normalize()
            _ARG_0_.axis:copy(_ARG_0_.velocity)
            _ARG_0_.velocity:scale(_UPVALUE1_)
            _ARG_0_.angle = 0
            _ARG_0_.step = 1
          end
        else
          Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.targetHandle, 2)
          Entity.TurnTargetDegree(_ARG_0_.myHandle, _UPVALUE0_, 15)
          Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
          _ARG_0_.velocity:set(0, 0, 1)
          Math.RotateVectorXYZ(_ARG_0_.velocity, _UPVALUE0_)
          _ARG_0_.velocity:normalize()
          _ARG_0_.axis:copy(_ARG_0_.velocity)
          _ARG_0_.velocity:scale(_UPVALUE1_)
          FVECTOR3.Scale(_UPVALUE0_, _ARG_0_.velocity, (Entity.GetFrameRate(_ARG_0_.myHandle)))
          FVECTOR3.Add(_ARG_0_.myPos, _ARG_0_.myPos, _UPVALUE0_)
          Entity.RotateAxis(_ARG_0_.myHandle, _ARG_0_.axis, _ARG_0_.angle, _UPVALUE2_, _ARG_0_.myPos)
          _ARG_0_.angle = RoundPI(_ARG_0_.angle + DegToRad(_UPVALUE3_ * Entity.GetFrameRate(_ARG_0_.myHandle)))
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:GotoState("Move")
          end
        end
      end
    },
    Laser = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _UPVALUE1_:set(0, 0, 0)
        _ARG_0_.effHandle = Entity.AttachEffect(_ARG_0_.myHandle, _UPVALUE2_, "E026_SPA_00_0", "Root", _UPVALUE1_, _UPVALUE1_)
        _ARG_0_.rotSpeedX = _UPVALUE3_[Script.RandomInteger(#_UPVALUE3_) + 1]
        if _ARG_0_.rotSpeedX == 0 then
          _ARG_0_.rotSpeedY = _UPVALUE4_[Script.RandomInteger(#_UPVALUE5_) + 1]
        else
          _ARG_0_.rotSpeedY = _UPVALUE4_[Script.RandomInteger(#_UPVALUE4_) + 1]
        end
        _ARG_0_.step = 0
        _ARG_0_.count = 1
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      end,
      OnEndState = function(_ARG_0_)
        for _FORV_4_, _FORV_5_ in pairs(_ARG_0_.laserHandle) do
          if EntityManager:GetEntity(_FORV_5_) ~= nil then
            EntityManager:GetEntity(_FORV_5_):End()
          end
        end
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Effect.IsAlive(_ARG_0_.effHandle) == false then
            Entity.SetTimer(_ARG_0_.myHandle, 0)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _UPVALUE0_:set(0, 0, 0)
            _UPVALUE2_:set(_UPVALUE1_[_ARG_0_.count][1], _UPVALUE1_[_ARG_0_.count][2], _UPVALUE1_[_ARG_0_.count][3])
            _ARG_0_.laserHandle[_ARG_0_.count] = _ARG_0_:CreateLaser(_UPVALUE0_, _UPVALUE2_)
            _ARG_0_.count = _ARG_0_.count + 1
            if _ARG_0_.count > #_ARG_0_.laserHandle then
              Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE3_)
              _ARG_0_.step = 2
            else
              Entity.SetTimer(_ARG_0_.myHandle, 4)
            end
          end
        else
          Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
          _UPVALUE0_:setx(RoundPI(_UPVALUE0_:getx() + DegToRad(_ARG_0_.rotSpeedX * Entity.GetFrameRate(_ARG_0_.myHandle))))
          _UPVALUE0_:sety(RoundPI(_UPVALUE0_:gety() + DegToRad(_ARG_0_.rotSpeedY * Entity.GetFrameRate(_ARG_0_.myHandle))))
          Entity.SetRot(_ARG_0_.myHandle, _UPVALUE0_)
          Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle, 2)
          _ARG_0_:CalcTargetVelocity(_ARG_0_.targetPos, 2.5, _UPVALUE4_)
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:GotoState("Move")
          end
        end
      end
    },
    Reflect = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
        Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.reflectHandle)
        FVECTOR3.Sub(_UPVALUE1_, _UPVALUE1_, _UPVALUE2_)
        _UPVALUE1_:sety(0)
        _UPVALUE1_:normalize()
        _UPVALUE1_:scale(_UPVALUE3_)
        Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE1_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        _ARG_0_.count = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.GetVelocity(_UPVALUE0_, _ARG_0_.myHandle)
        if Entity.IsGround(_ARG_0_.myHandle) or Entity.IsWall(_ARG_0_.myHandle) then
          Entity.CalcReflectionVector(_UPVALUE0_, _ARG_0_.myHandle)
          _UPVALUE0_:sety(0)
        end
        _UPVALUE0_:normalize()
        _UPVALUE0_:scale(_UPVALUE0_:length() * Math.Pow(0.99, Entity.GetFrameRate(_ARG_0_.myHandle)))
        Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE0_)
        if _UPVALUE0_:length() * Math.Pow(0.99, Entity.GetFrameRate(_ARG_0_.myHandle)) < 0.05 then
          _ARG_0_:GotoState("Move")
          return
        end
      end
    },
    Explosion = {
      OnBeginState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        Enemy.AddHp(_ARG_0_.myHandle, -Entity.GetHpMax(_ARG_0_.myHandle))
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 20)
        Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
        Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
        _UPVALUE2_:set(0, 0, 0)
        Entity.SetEffect(_ARG_0_.myHandle, _UPVALUE3_, "E026_HIT_00_0", _UPVALUE1_, _UPVALUE2_)
        for _FORV_4_, _FORV_5_ in pairs(_ARG_0_.laserHandle) do
          Entity.Out(_FORV_5_)
        end
      end,
      OnEndState = function(_ARG_0_)
        Enemy.Dead(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsModelFade(_ARG_0_.myHandle) == false then
          Enemy.Dead(_ARG_0_.myHandle)
        end
      end
    }
  },
  CreateLaser = function(_ARG_0_, _ARG_1_, _ARG_2_)
    SetBulletAttackParam(Bullet.CreateBullet("LBLaser", _ARG_1_, _ARG_2_), _ARG_0_.myHandle, 1)
    Entity.AttachCoordNum(_ARG_0_.myHandle, 0, Bullet.CreateBullet("LBLaser", _ARG_1_, _ARG_2_), 0)
    return (Bullet.CreateBullet("LBLaser", _ARG_1_, _ARG_2_))
  end,
  CalcTargetVelocity = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
    FVECTOR3.Sub(_UPVALUE1_, _ARG_1_, _UPVALUE0_)
    _UPVALUE1_:normalize()
    FVECTOR3.Mul(_UPVALUE2_, _UPVALUE1_, _UPVALUE1_)
    _ARG_0_.rot:setx((HomingDegree(_ARG_0_.rot:getx(), -Math.Atan2(_UPVALUE1_:gety(), Math.Sqrt(_UPVALUE2_:getx() + _UPVALUE2_:getz())), _ARG_2_, (Entity.GetFrameRate(_ARG_0_.myHandle)))))
    _ARG_0_.rot:sety((HomingDegree(_ARG_0_.rot:gety(), Math.Atan2(_UPVALUE1_:getx(), _UPVALUE1_:getz()), _ARG_2_, (Entity.GetFrameRate(_ARG_0_.myHandle)))))
    _UPVALUE2_:set(0, 0, _ARG_3_)
    Math.RotateVectorXYZ(_UPVALUE2_, _ARG_0_.rot)
    Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE2_)
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    if _UPVALUE0_ == false then
      _UPVALUE1_ = Entity.GetMotionIndex(_ARG_1_, "010")
      _UPVALUE2_ = Entity.GetMotionIndex(_ARG_1_, "300")
      _UPVALUE0_ = true
    end
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.targetHandle = NULL_HANDLE
    _ARG_0_.effHandle = NULL_HANDLE
    _ARG_0_.laserHandle = {
      NULL_HANDLE,
      NULL_HANDLE,
      NULL_HANDLE,
      NULL_HANDLE
    }
    _ARG_0_.reflectHandle = NULL_HANDLE
    _ARG_0_.step = 0
    _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
    _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
    _ARG_0_.axis = FVECTOR3.new(0, 0, 0)
    _ARG_0_.timer = 0
    _ARG_0_.rotSpeedX = 0
    _ARG_0_.rotSpeedY = 0
    _ARG_0_.count = 0
    _ARG_0_.angle = 0
    Entity.SetMovementCollRadius(_ARG_1_, 0.6)
    Entity.SetLowerHalf(_ARG_1_, 0)
    Entity.EnableCheckUnderFoot(_ARG_1_, 0)
    Entity.GetLocalPos(_UPVALUE3_, _ARG_0_.myHandle)
    _UPVALUE3_:sety(_UPVALUE3_:gety() + 0.5)
    Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE3_)
    if Enemy.ExistLeader(Entity.GetGroupID(_ARG_1_), _ARG_1_) == false then
      Enemy.EnableLeader(_ARG_1_, 1)
    end
    if Enemy.IsAllEnemyWaiting() then
      _ARG_0_:GotoState("Waiting")
    else
      _ARG_0_:GotoState("Appear")
    end
  end,
  OnDestroy = function(_ARG_0_)
    Effect.LoopEnd(_ARG_0_.effHandle)
    Effect.DetachCoord(_ARG_0_.effHandle)
    if Enemy.IsLeader(_ARG_0_.myHandle) then
      Enemy.DecideLeader(Entity.GetGroupID(_ARG_0_.myHandle), _ARG_0_.myHandle)
    end
  end,
  OnMessage = function(_ARG_0_, _ARG_1_, _ARG_2_)
    if Entity.GetGroupID(_ARG_2_) ~= Entity.GetGroupID(_ARG_0_.myHandle) then
      return
    end
    if _ARG_1_ == _UPVALUE0_ then
      _ARG_0_:GotoState("Idling")
    elseif _ARG_1_ == _UPVALUE1_ then
      _ARG_0_:GotoState("Rush")
    elseif _ARG_1_ == _UPVALUE2_ then
      _ARG_0_:GotoState("Laser")
    end
  end,
  OnDamage = function(_ARG_0_, _ARG_1_, _ARG_2_)
    if _ARG_0_:GetState() == "Explosion" or _ARG_0_:GetState() == "Reflect" then
      return 1
    end
    for _FORV_7_, _FORV_8_ in pairs(_ARG_0_.laserHandle) do
      if EntityManager:GetEntity(_FORV_8_) ~= nil then
        EntityManager:GetEntity(_FORV_8_):End()
      end
    end
    Entity.LoopEndEffectAttach(_ARG_0_.myHandle, 0)
    if _ARG_1_ == ATK_KIND_DMG_BLOW or _ARG_1_ == ATK_KIND_DMG_BIG then
      _ARG_0_.reflectHandle = Entity.GetAttacker(_ARG_0_.myHandle)
      _ARG_0_:GotoState("Reflect")
      return 1
    end
    return 0
  end,
  OnDead = function(_ARG_0_)
    if _ARG_0_:GetState() == "Explosion" then
      return 1
    end
    for _FORV_4_, _FORV_5_ in pairs(_ARG_0_.laserHandle) do
      Entity.Out(_FORV_5_)
    end
    Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
    return 0
  end,
  OnReturnDamage = function(_ARG_0_)
    if _ARG_0_:GetState() ~= "Explosion" then
      _ARG_0_:GotoState("Move")
    end
  end,
  OnReflect = function(_ARG_0_, _ARG_1_, _ARG_2_)
    if _ARG_0_:GetState() ~= "Explosion" then
      _ARG_0_.reflectHandle = _ARG_2_
      _ARG_0_:GotoState("Reflect")
    end
    return 1
  end,
  OnHitBody = function(_ARG_0_, _ARG_1_)
    if _ARG_0_:GetState() == "Reflect" then
      Entity.GetVelocity(_UPVALUE0_, _ARG_0_.myHandle)
      if _UPVALUE0_:length() >= _UPVALUE1_ * 0.2 and Entity.IsEnemy(_ARG_1_) and Entity.GetName(_ARG_1_) == "m26ex00" then
        if EntityManager:GetEntity(_ARG_1_) ~= nil then
          EntityManager:GetEntity(_ARG_1_):GotoState("Explosion")
        end
        _ARG_0_:GotoState("Explosion")
        return 1
      end
    end
    return 0
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
EntityFactory:Add("m26ex00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("LBLaser", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
