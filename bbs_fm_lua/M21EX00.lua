setmetatable({
  new = function(_ARG_0_)
    return setmetatable(__StateMachine:new(), _UPVALUE0_)
  end,
  states = {
    Appear = {
      OnBeginState = function(_ARG_0_)
        SetupAppearBegin(_ARG_0_.myHandle, -1, _UPVALUE0_[_ARG_0_.mode][_UPVALUE1_], 1)
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
        _ARG_0_:SetMotion(_UPVALUE0_, -2)
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
        _ARG_0_:SetMotion(_UPVALUE0_, -2)
        _ARG_0_.stack:clear()
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        Enemy.GetTargetLastRecordedPos(_UPVALUE0_, _ARG_0_.myHandle, _ARG_0_.targetHandle)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE0_, 2.5)
        if CanDisappear(_ARG_0_.myHandle, _ARG_0_.targetHandle) then
          _ARG_0_:GotoState("Disappear")
          return
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
          return
        end
        if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) == false then
          return
        end
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE1_ then
          _ARG_0_.stack:push("Idling")
          _ARG_0_.stack:push("Stiff")
          if Script.Random() < 0.6 then
            _ARG_0_.stack:push("Kick")
            _ARG_0_.stack:push("TargetMove")
          elseif _ARG_0_:IsTimebombExist() then
            Entity.SetTimer(_ARG_0_.myHandle, Script.RandomInRange(_UPVALUE2_, _UPVALUE2_ * 2))
            return
          else
            _ARG_0_.stack:push("TimeBomb")
            _ARG_0_.stack:push("Warp")
            _ARG_0_:CalcWarpPos(5)
          end
        elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) >= _UPVALUE1_ and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE3_ then
          if Script.Random() < 0.3 then
            if _ARG_0_:IsTimebombExist() then
              Entity.SetTimer(_ARG_0_.myHandle, Script.RandomInRange(_UPVALUE2_, _UPVALUE2_ * 2))
              return
            else
              _ARG_0_.stack:push("Idling")
              _ARG_0_.stack:push("Stiff")
              _ARG_0_.stack:push("TimeBomb")
            end
          elseif Script.Random() >= 0.3 and Script.Random() < 0.5 then
            _ARG_0_.stack:push("Idling")
            _ARG_0_.stack:push("Stiff")
            _ARG_0_.stack:push("Kick")
            _ARG_0_.stack:push("Warp")
            _ARG_0_:CalcWarpPos(2.5)
          else
            Entity.SetTimer(_ARG_0_.myHandle, Script.RandomInRange(_UPVALUE2_, _UPVALUE2_ * 2))
            return
          end
        else
          _ARG_0_.stack:push("Idling")
          _ARG_0_.stack:push("TargetMove")
        end
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      end
    },
    TargetMove = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_:SetMotion(_UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, 600)
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
        _ARG_0_:CalcTargetVelocity(_ARG_0_.targetPos, 5, _UPVALUE0_)
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= 6.25 or Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Warp = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_:SetMotion(_UPVALUE0_, -2)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
        Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.myHandle, 2)
        _UPVALUE3_:set(0, 0, 0)
        Entity.SetEffect(_ARG_0_.myHandle, _UPVALUE4_, "E021_WAR_00_0", _UPVALUE2_, _UPVALUE3_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        Enemy.EnableNoBadStatus(_ARG_0_.myHandle, 1)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        Entity.SetScale(_ARG_0_.myHandle, _ARG_0_.baseScale)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Enemy.EnableNoBadStatus(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          _UPVALUE1_:set(0, _ARG_0_.baseScale:gety() * 2, 0)
          Math.VectorLerp(_UPVALUE2_, _ARG_0_.baseScale, _UPVALUE1_, 1 - Entity.GetTimer(_ARG_0_.myHandle) / _UPVALUE0_)
          Entity.SetScale(_ARG_0_.myHandle, _UPVALUE2_)
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            if Enemy.isBind(_ARG_0_.myHandle) == 0 then
              Entity.Warp(_ARG_0_.myHandle, _ARG_0_.warpPos)
              Entity.GetWorldPos(_UPVALUE3_, _ARG_0_.targetHandle)
              Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE3_)
            end
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
            Entity.SetRot(_ARG_0_.myHandle, 0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle), 0)
            _ARG_0_.step = 1
          end
        else
          if _ARG_0_.step == 1 then
            Entity.GetWorldPos(_UPVALUE3_, _ARG_0_.myHandle, 2)
            _UPVALUE1_:set(0, 0, 0)
            Entity.SetEffect(_ARG_0_.myHandle, _UPVALUE4_, "E021_WAR_01_0", _UPVALUE3_, _UPVALUE1_)
            _ARG_0_.step = 2
          end
          _UPVALUE3_:set(0, _ARG_0_.baseScale:gety() * 2, 0)
          Math.VectorLerp(_UPVALUE2_, _UPVALUE3_, _ARG_0_.baseScale, 1 - Entity.GetTimer(_ARG_0_.myHandle) / _UPVALUE0_)
          Entity.SetScale(_ARG_0_.myHandle, _UPVALUE2_)
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        end
      end
    },
    Kick = {
      OnBeginState = function(_ARG_0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        _ARG_0_:SetMotion(_UPVALUE0_)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 12 then
            _ARG_0_.step = 1
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    TimeBomb = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_:SetMotion(_UPVALUE0_)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 45 then
            Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
            Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.targetHandle, 2)
            for _FORV_4_ = 0, 288, 72 do
              _UPVALUE1_:set(Math.Cos((RoundPI(DegToRad(_FORV_4_)))) * _UPVALUE2_, 0, Math.Sin((RoundPI(DegToRad(_FORV_4_)))) * _UPVALUE2_)
              FVECTOR3.Add(_UPVALUE3_, _UPVALUE0_, _UPVALUE1_)
              _UPVALUE4_:set(0, 0, 0)
              SetBulletAttackParam(Bullet.CreateBullet("timebomb", _UPVALUE3_, _UPVALUE4_), _ARG_0_.myHandle, 1)
              if EntityManager:GetEntity((Bullet.CreateBullet("timebomb", _UPVALUE3_, _UPVALUE4_))) ~= nil then
                EntityManager:GetEntity((Bullet.CreateBullet("timebomb", _UPVALUE3_, _UPVALUE4_))).theta, EntityManager:GetEntity((Bullet.CreateBullet("timebomb", _UPVALUE3_, _UPVALUE4_))).targetHandle = RoundPI(DegToRad(_FORV_4_)), _ARG_0_.targetHandle
              end
            end
            _ARG_0_.step = 1
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Stopga = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_:SetMotion(_UPVALUE0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        Enemy.EnableNoBadStatus(_ARG_0_.myHandle, 1)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        _ARG_0_:ChangeMode()
        _ARG_0_:SetSandMotion()
        _ARG_0_:RemoveStopgaEffect()
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Enemy.EnableNoBadStatus(_ARG_0_.myHandle, 0)
        Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 45 then
            Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.targetHandle, 2)
            Enemy.SetGeneralPurposeAttackColl(_ARG_0_.myHandle, COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, 0.01)
            Enemy.SetGeneralPurposeAttackCollParam(_ARG_0_.myHandle, ATK_KIND_STOP, Enemy.GetAttackAttr(_ARG_0_.myHandle, 2), Enemy.GetAttackPoint(_ARG_0_.myHandle, 2), Enemy.GetAttackPowerCorrection(_ARG_0_.myHandle, 2), _UPVALUE1_)
            Enemy.SetGeneralPurposeAttackCollHitAttackEffectName(_ARG_0_.myHandle, _UPVALUE2_, "E021_STP_01_0")
            Enemy.SetGeneralPurposeAttackCollPos(_ARG_0_.myHandle, _UPVALUE0_, _UPVALUE3_)
            if Entity.IsPlayer(_ARG_0_.targetHandle) then
              if Enemy.IsConfuse(_ARG_0_.myHandle) or Enemy.IsBlind(_ARG_0_.myHandle) then
                Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 0)
              else
                Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 1)
              end
            else
              Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 0)
            end
            Entity.SetTimer(_ARG_0_.myHandle, 2)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.targetHandle, 2)
          Enemy.SetGeneralPurposeAttackCollPos(_ARG_0_.myHandle, _UPVALUE0_, _UPVALUE3_)
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 0)
            _ARG_0_.step = 2
          end
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.stack:push("Idling")
          _ARG_0_.stack:push("Kick")
          _ARG_0_.stack:push("TargetMove")
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE4_ then
            _ARG_0_.stack:push("Warp")
            _ARG_0_:CalcWarpPos(5)
          end
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Passion = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_:SetMotion(_UPVALUE0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        Enemy.EnableNoBadStatus(_ARG_0_.myHandle, 1)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 and Entity.IsPlayer(_ARG_0_.targetHandle) == false then
          _ARG_0_:RemoveStopgaEffect()
          _ARG_0_.step = 1
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
        if Entity.IsMotionEnd(_ARG_0_.sandHandle) then
          _ARG_0_:GotoState("Stopga")
        end
      end
    },
    Stiff = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_:SetMotion(_UPVALUE0_, -2)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
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
  IsTimebombExist = function(_ARG_0_)
    if EntityManager:GetEntity("timebomb") ~= nil then
      return true
    end
    return false
  end,
  SetMotion = function(_ARG_0_, _ARG_1_, _ARG_2_)
    Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_[_ARG_0_.mode][_ARG_1_], 0)
  end,
  SetSandMotion = function(_ARG_0_)
    Entity.SetMotion(_ARG_0_.sandHandle, _UPVALUE0_[_ARG_0_.mode])
  end,
  ChangeMode = function(_ARG_0_)
    if _ARG_0_.mode == 1 then
      _ARG_0_.mode = 2
    else
      _ARG_0_.mode = 1
    end
  end,
  CalcTargetVelocity = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
    FVECTOR3.Sub(_UPVALUE1_, _ARG_1_, _UPVALUE0_)
    _UPVALUE1_:normalize()
    FVECTOR3.Mul(_UPVALUE2_, _UPVALUE1_, _UPVALUE1_)
    Entity.GetRot(_UPVALUE3_, _ARG_0_.myHandle)
    _UPVALUE3_:sety(HomingDegree(_UPVALUE3_:gety(), Math.Atan2(_UPVALUE1_:getx(), _UPVALUE1_:getz()), _ARG_2_, (Entity.GetFrameRate(_ARG_0_.myHandle))))
    Entity.SetRot(_ARG_0_.myHandle, _UPVALUE3_)
    _UPVALUE3_:setx(-Math.Atan2(_UPVALUE1_:gety(), Math.Sqrt(_UPVALUE2_:getx() + _UPVALUE2_:getz())))
    _UPVALUE4_:set(0, 0, _ARG_3_)
    Math.RotateVectorXYZ(_UPVALUE4_, _UPVALUE3_)
    Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE4_)
  end,
  CalcWarpPos = function(_ARG_0_, _ARG_1_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.targetHandle)
    _UPVALUE1_:set(Math.Cos((Script.RandomInRange(-PI, PI))) * _ARG_1_, 0, Math.Sin((Script.RandomInRange(-PI, PI))) * _ARG_1_)
    FVECTOR3.Add(_UPVALUE1_, _UPVALUE1_, _UPVALUE0_)
    Collision.IntersectRayBg(_UPVALUE1_, COLL_KIND_ENEMY, _UPVALUE0_, _UPVALUE1_)
    _ARG_0_.warpPos:copy(_UPVALUE1_)
  end,
  GetDamageMotionNum = function(_ARG_0_, _ARG_1_)
    return _UPVALUE0_[_ARG_0_.mode][_UPVALUE1_[_ARG_1_ + 1]]
  end,
  IsCreateStopgaEffect = function(_ARG_0_)
    for _FORV_4_, _FORV_5_ in pairs(_UPVALUE0_) do
      if _FORV_5_ == _ARG_0_.myHandle then
        return true, _FORV_4_
      end
    end
    return false, -1
  end,
  RemoveStopgaEffect = function(_ARG_0_)
    if _ARG_0_:IsCreateStopgaEffect() then
      if #_UPVALUE0_ <= 1 then
        Effect.LoopEnd(_UPVALUE1_)
        _UPVALUE1_ = NULL_HANDLE
      end
      table.remove(_UPVALUE0_, _ARG_0_:IsCreateStopgaEffect())
    end
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
    _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
    _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.warpPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.baseScale = FVECTOR3.new(0, 0, 0)
    _ARG_0_.step = 0
    _ARG_0_.mode = Script.RandomInteger(2) + 1
    _ARG_0_.dmgCount = 0
    _ARG_0_.targetHandle = NULL_HANDLE
    _ARG_0_.stopTarget = NULL_HANDLE
    _ARG_0_.stack = Stack:Create()
    if _UPVALUE0_ == false then
      for _FORV_5_, _FORV_6_ in pairs(_UPVALUE1_) do
        _UPVALUE2_[_FORV_5_] = Entity.GetMotionIndex(_ARG_1_, _FORV_6_)
      end
      for _FORV_5_, _FORV_6_ in pairs(_UPVALUE3_) do
        _UPVALUE4_[_FORV_5_] = Entity.GetMotionIndex(_ARG_1_, _FORV_6_)
      end
      _UPVALUE0_ = true
    end
    _UPVALUE5_:set(0, 0, 0)
    Entity.AttachCoord(_ARG_1_, "hara", Entity.CreateEntity("m29ex00", _UPVALUE5_, _UPVALUE5_, _ARG_1_), "Root")
    Entity.EnableBgColl(Entity.CreateEntity("m29ex00", _UPVALUE5_, _UPVALUE5_, _ARG_1_), 0)
    Entity.EnableLockonAndShooton(Entity.CreateEntity("m29ex00", _UPVALUE5_, _UPVALUE5_, _ARG_1_), 0)
    Entity.SetModelOfsZ(Entity.CreateEntity("m29ex00", _UPVALUE5_, _UPVALUE5_, _ARG_1_), -1)
    Entity.SetUserGroundColor(Entity.CreateEntity("m29ex00", _UPVALUE5_, _UPVALUE5_, _ARG_1_), 0)
    Enemy.SetNoNetwork(Entity.CreateEntity("m29ex00", _UPVALUE5_, _UPVALUE5_, _ARG_1_), 1)
    _ARG_0_.sandHandle = Entity.CreateEntity("m29ex00", _UPVALUE5_, _UPVALUE5_, _ARG_1_)
    _ARG_0_:SetSandMotion()
    Entity.GetScale(_ARG_0_.baseScale, _ARG_1_)
    if Enemy.IsAllEnemyWaiting() then
      _ARG_0_:GotoState("Waiting")
    else
      _ARG_0_:GotoState("Appear")
    end
  end,
  OnHitAttack = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    if _ARG_3_ == ATK_KIND_STOP then
      Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 0)
      if _ARG_0_.stopTarget == _ARG_1_ then
        _ARG_0_:RemoveStopgaEffect()
      end
    end
  end,
  OnReturnDamage = function(_ARG_0_)
    Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
    if Entity.GetCurrentMotion(_ARG_0_.myHandle) == _UPVALUE0_[_ARG_0_.mode][_UPVALUE1_] then
      _ARG_0_:ChangeMode()
      _ARG_0_:SetSandMotion()
    end
    _ARG_0_:GotoState("Idling")
  end,
  OnDamage = function(_ARG_0_)
    _ARG_0_.dmgCount = _ARG_0_.dmgCount + 1
    if Enemy.IsNoDamageReaction(_ARG_0_.myHandle) == false and Enemy.IsMinimum(_ARG_0_.myHandle) == false and _ARG_0_.dmgCount >= _UPVALUE0_ then
      _ARG_0_.dmgCount = 0
      _ARG_0_:CalcWarpPos(5)
      _ARG_0_.stack:push("Idling")
      _ARG_0_:GotoState("Warp")
      return 1
    end
    return 0
  end,
  OnReflect = function(_ARG_0_)
    _ARG_0_:RemoveStopgaEffect()
    return 0
  end,
  OnDestroy = function(_ARG_0_)
    _ARG_0_:RemoveStopgaEffect()
  end,
  OnUpdateLast = function(_ARG_0_)
    Entity.SetAlpha(_ARG_0_.sandHandle, Entity.GetAlpha(_ARG_0_.myHandle))
  end,
  CanStopga = function(_ARG_0_)
    for _FORV_5_, _FORV_6_ in pairs(_UPVALUE0_) do
      if _ARG_0_:GetState() == _FORV_6_ then
        return false
      end
    end
    if Entity.GetMotionNowFrame(_ARG_0_.sandHandle) >= 450 then
      _ARG_0_.stopTarget = _ARG_0_.targetHandle
      if Effect.IsAlive(_UPVALUE1_) == false and Entity.IsPlayer(_ARG_0_.targetHandle) then
        _UPVALUE2_:set(0, 2.5, 0)
        _UPVALUE3_:set(0, 0, 0)
        _UPVALUE1_ = Entity.AttachEffect(_ARG_0_.targetHandle, _UPVALUE4_, "E021_STP_00_0", "Root", _UPVALUE2_, _UPVALUE3_)
        table.insert(_UPVALUE5_, _ARG_0_.myHandle)
      end
      return true
    end
    return false
  end,
  OnUpdate = function(_ARG_0_)
    if Entity.IsAlive(_ARG_0_.targetHandle) == false then
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
    end
    if _ARG_0_:CanStopga() then
      _ARG_0_.stack:push("Stopga")
      _ARG_0_.stack:push("Passion")
      _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
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
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        _ARG_0_.stack:clear()
        _ARG_0_.stack:push("Idling")
        _ARG_0_:GotoState(_UPVALUE0_[Script.GetDebugAttackNumber() + 1])
      end
    end
  end
}, {__index = __StateMachine})
EntityFactory:Add("m21ex00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("m21vs00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("timebomb", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
