setmetatable({
  new = function(_ARG_0_)
    return setmetatable(__StateMachine:new(), _UPVALUE0_)
  end,
  states = {
    Appear = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_.step = 0
        _ARG_0_.step2 = 0
        _ARG_0_.timer = 0
        _ARG_0_:SetMotion(_UPVALUE0_)
        Entity.SetModelPartsAlpha(_ARG_0_.myHandle, 0, 0)
        Entity.SetModelPartsAlpha(_ARG_0_.myHandle, 1, 0)
        Entity.SetModelPartsAlpha(_ARG_0_.myHandle, 2, 0)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
        Entity.SetRot(_ARG_0_.myHandle, 0, Entity.CalcDirection(_ARG_0_.myHandle, Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)), 0)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        _ARG_0_.changeCnt = Script.Random() * _UPVALUE1_ + _UPVALUE2_
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        Entity.SetModelPartsAlpha(_ARG_0_.myHandle, 0, 1)
        Entity.SetModelPartsAlpha(_ARG_0_.myHandle, 1, 1)
        Entity.SetModelPartsAlpha(_ARG_0_.myHandle, 2, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if 0 >= _ARG_0_.timer then
            if 0 < _ARG_0_.step2 then
              Entity.SetModelPartsAlpha(_ARG_0_.myHandle, _UPVALUE0_[_ARG_0_.mode][_ARG_0_.step2], 1)
            end
            _ARG_0_.timer = _UPVALUE1_
            _ARG_0_.step2 = _ARG_0_.step2 + 1
            if _ARG_0_.step2 >= 4 then
              _ARG_0_.step = 1
              Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
              Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
              Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
              _ARG_0_:SetLockOnBoneNum()
              return
            else
              Entity.GetWorldPos(_UPVALUE3_, _ARG_0_.myHandle, _UPVALUE2_[_UPVALUE0_[_ARG_0_.mode][_ARG_0_.step2] + 1])
              _UPVALUE3_:sety(_UPVALUE3_:gety() + 0.5)
              _UPVALUE4_:set(0, 0, 0)
              Entity.SetEffect(_ARG_0_.myHandle, "e_ex000", "EXXX_APP_00_0", _UPVALUE3_, _UPVALUE4_)
            end
          end
          Entity.SetModelPartsAlpha(_ARG_0_.myHandle, _UPVALUE0_[_ARG_0_.mode][_ARG_0_.step2], 1)
          _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
        else
          _ARG_0_:GotoState(_UPVALUE5_[_ARG_0_.mode])
        end
      end
    },
    Waiting = {
      OnBeginState = function(_ARG_0_)
        print("Waiting\n")
        _ARG_0_:SetMotion(_UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, 178)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:SetMotion(_UPVALUE0_)
            _ARG_0_.mode = _ARG_0_.mode + 1
            if _ARG_0_.mode > 3 then
              _ARG_0_.mode = 1
            end
            _ARG_0_:ChangeEnemyParam()
            _ARG_0_:SetLockOnBoneNum()
            _ARG_0_.changeCnt = Script.Random() * _UPVALUE1_ + _UPVALUE2_
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          print("\131A\131C\131h\131\138\131\147\131O\130\214")
          _ARG_0_:SetMotion(_UPVALUE3_)
          _ARG_0_.step = 2
        end
        if Enemy.IsAllEnemyWaiting() == false then
          _ARG_0_:GotoState(_UPVALUE4_[_ARG_0_.mode])
        end
      end
    },
    SearchTargeting = {
      OnBeginState = function(_ARG_0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_ + Script.Random() * _UPVALUE0_)
        Entity.EnableAvoidPlayer(_ARG_0_.myHandle, 1)
        Entity.EnableAvoidEnemy(_ARG_0_.myHandle, 1)
        _ARG_0_.timer = 0
        _ARG_0_:SetMotion(_UPVALUE1_)
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableAvoidPlayer(_ARG_0_.myHandle, 0)
        Entity.EnableAvoidEnemy(_ARG_0_.myHandle, 0)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.timer <= 0 then
          _UPVALUE0_:set(Math.Cos((RoundPI(DegToRad((Script.Random() - Script.Random()) * 360)))) * (3 + Script.Random() * 5), 0, Math.Sin((RoundPI(DegToRad((Script.Random() - Script.Random()) * 360)))) * (3 + Script.Random() * 5))
          Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
          FVECTOR3.Add(_ARG_0_.targetPos, _ARG_0_.targetPos, _UPVALUE0_)
          Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
          Collision.IntersectRayBg(_ARG_0_.targetPos, COLL_KIND_ENEMY, _UPVALUE1_, _ARG_0_.targetPos)
          _ARG_0_.timer = 60
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 2.5)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE2_[_ARG_0_.mode])
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) <= 1 then
          _ARG_0_.timer = 0
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
          return
        end
        if _ARG_0_.mode == 1 then
          _ARG_0_:GotoState("Pursuit")
        else
          _ARG_0_:GotoState(_UPVALUE3_[_ARG_0_.mode])
        end
      end
    },
    SearchTargetingUneasiness = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_:SetMotion(_UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
          return
        end
        if _ARG_0_.mode == 1 then
          _ARG_0_:GotoState("Pursuit")
        else
          _ARG_0_:GotoState(_UPVALUE0_[_ARG_0_.mode])
        end
      end
    },
    Pursuit = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_:SetMotion(_UPVALUE0_)
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
        _ARG_0_.velocity:set(0, 0, _UPVALUE0_[_ARG_0_.mode])
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= 6.25 then
          _ARG_0_:GotoState(_UPVALUE1_[_ARG_0_.mode])
        end
      end
    },
    Idling = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_:SetMotion(_UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          print("self.changeCnt = " .. _ARG_0_.changeCnt .. "\n")
          if _ARG_0_.changeCnt < 0 then
            _ARG_0_:GotoState("FormChange")
          else
            _ARG_0_:GotoState(_UPVALUE0_[_ARG_0_.mode])
          end
        end
      end
    },
    FormChange = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_:SetMotion(_UPVALUE0_)
        _ARG_0_.mode = _ARG_0_.mode + 1
        if _ARG_0_.mode > 3 then
          _ARG_0_.mode = 1
        end
        _ARG_0_:ChangeEnemyParam()
        _ARG_0_:SetLockOnBoneNum()
        _ARG_0_.changeCnt = Script.Random() * _UPVALUE1_ + _UPVALUE2_
        print("Next changeCnt = " .. _ARG_0_.changeCnt .. "\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_UPVALUE0_[_ARG_0_.mode])
        end
      end
    },
    RageFlame = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_:SetMotion(_UPVALUE0_)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 15 then
            _ARG_0_.step = 1
          end
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    BlizzagaShoot = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_:SetMotion(_UPVALUE0_)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 29 then
            _ARG_0_:CreateBlizzaga(0)
            _ARG_0_:CreateBlizzaga(30)
            _ARG_0_:CreateBlizzaga(-30)
            _ARG_0_.step = 1
          end
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    Thundaga = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_:SetMotion(_UPVALUE0_)
        _ARG_0_.step = 0
        _ARG_0_.step2 = 0
        _ARG_0_.effHandle = NULL_HANDLE
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 15 then
            Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.targetHandle)
            _UPVALUE1_:copy(_UPVALUE0_)
            _UPVALUE0_:sety(_UPVALUE0_:gety() + 1)
            _UPVALUE1_:sety(_UPVALUE1_:gety() - 20)
            Collision.IntersectRayBg(_UPVALUE0_, COLL_KIND_ENEMY, _UPVALUE0_, _UPVALUE1_)
            _UPVALUE1_:set(0, 0, 0)
            _ARG_0_.effHandle = Entity.SetEffect(_ARG_0_.myHandle, "e_ex150", "E015_THD_00_0", _UPVALUE0_, _UPVALUE1_)
            Enemy.SetGeneralPurposeAttackColl(_ARG_0_.myHandle, COLL_KIND_ENEMY, COLL_SHAPE_CYLINDER, 0.3)
            Enemy.SetGeneralPurposeAttackCollParam(_ARG_0_.myHandle, Enemy.GetAttackKind(_ARG_0_.myHandle, 0), Enemy.GetAttackAttr(_ARG_0_.myHandle, 0), Enemy.GetAttackPoint(_ARG_0_.myHandle, 0), Enemy.GetAttackPowerCorrection(_ARG_0_.myHandle, 0))
            Enemy.SetGeneralPurposeAttackCollHitAttackEffectName(_ARG_0_.myHandle, "e_ex150", "E015_THD_01_0")
            Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 0)
            _UPVALUE1_:copy(_UPVALUE0_)
            _UPVALUE0_:sety(_UPVALUE0_:gety() + 3)
            Enemy.SetGeneralPurposeAttackCollPos(_ARG_0_.myHandle, _UPVALUE0_, _UPVALUE1_)
            _ARG_0_.step = 1
          end
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
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
  SuccessHit = function(_ARG_0_, _ARG_1_)
    print("type = " .. _ARG_1_ .. "\n")
    print("mode = " .. _ARG_0_.mode .. "\n")
    print("M57EX_ATK_ATTR[self.mode] = " .. _UPVALUE0_[_ARG_0_.mode] .. "\n")
    if _ARG_1_ == _UPVALUE0_[_ARG_0_.mode] then
      Entity.GetDamageCrossPos(_UPVALUE1_, _ARG_0_.myHandle)
      Entity.GetRot(_UPVALUE2_, _ARG_0_.myHandle)
      Entity.SetEffect(_ARG_0_.myHandle, "e_ex570", _UPVALUE3_[_ARG_0_.mode], _UPVALUE1_, _UPVALUE2_)
      print("Success = " .. MES_PILEFACE_HIT .. "\n")
      Mission.SendMissonMessage(MES_PILEFACE_HIT)
    end
  end,
  SetMotion = function(_ARG_0_, _ARG_1_)
    Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_[_ARG_0_.mode][_ARG_1_])
  end,
  SetLockOnBoneNum = function(_ARG_0_)
    Entity.SetLockOnBoneNum(_ARG_0_.myHandle, _UPVALUE0_[_ARG_0_.mode])
  end,
  ChangeEnemyParam = function(_ARG_0_)
    if Entity.GetName(_ARG_0_.myHandle) == "m57ex00" then
      Enemy.ChangeEnemyParam(_ARG_0_.myHandle, _UPVALUE0_[_ARG_0_.mode])
    else
      Enemy.ChangeEnemyParam(_ARG_0_.myHandle, _UPVALUE0_[_ARG_0_.mode], false, 0)
      Enemy.ChangeEnemyParam(_ARG_0_.myHandle, _UPVALUE1_[_ARG_0_.mode], false, 1)
    end
  end,
  CreateBlizzaga = function(_ARG_0_, _ARG_1_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 3)
    Entity.GetDir(_UPVALUE1_, _ARG_0_.myHandle)
    FVECTOR3.Add(_UPVALUE0_, _UPVALUE0_, _UPVALUE1_)
    _UPVALUE0_:sety(_UPVALUE0_:gety() + 0.5)
    Entity.GetRot(_UPVALUE2_, _ARG_0_.myHandle)
    _UPVALUE2_:sety(RoundPI(_UPVALUE2_:gety() + DegToRad(_ARG_1_)))
    Entity.GetWorldPos(_UPVALUE3_, _ARG_0_.targetHandle, 2)
    FVECTOR3.Sub(_UPVALUE3_, _UPVALUE3_, _UPVALUE0_)
    _UPVALUE3_:normalize()
    FVECTOR3.Mul(_UPVALUE1_, _UPVALUE3_, _UPVALUE3_)
    _UPVALUE2_:setx(-Math.Atan2(_UPVALUE3_:gety(), Math.Sqrt(_UPVALUE1_:getx() + _UPVALUE1_:getz())))
    return CreateEnemyBullet(_UPVALUE4_, _ARG_0_.myHandle, _UPVALUE0_, _UPVALUE2_)
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    _ARG_0_.myHandle = _ARG_1_
    Entity.EnableGravity(_ARG_0_.myHandle, 1)
    Entity.SetMovementCollRadius(_ARG_0_.myHandle, 1.75)
    Entity.SetLowerHalf(_ARG_0_.myHandle, 2.25)
    _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
    _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
    _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.workVec0 = FVECTOR3.new(0, 0, 0)
    _ARG_0_.step = 0
    _ARG_0_.step2 = 0
    _ARG_0_.targetHandle = NULL_HANDLE
    _ARG_0_.effHandle = NULL_HANDLE
    _ARG_0_.timer = 0
    _ARG_0_.mode = Script.RandomInteger(3) + 1
    print("self.mode = " .. _ARG_0_.mode .. "\n")
    _ARG_0_.mode = Script.RandomInteger(3) + 1
    print("self.mode = " .. _ARG_0_.mode .. "\n")
    _ARG_0_.mode = Script.RandomInteger(3) + 1
    print("self.mode = " .. _ARG_0_.mode .. "\n")
    _ARG_0_.mode = Script.RandomInteger(3) + 1
    print("self.mode = " .. _ARG_0_.mode .. "\n")
    _ARG_0_.mode = Script.RandomInteger(3) + 1
    print("self.mode = " .. _ARG_0_.mode .. "\n")
    _ARG_0_.mode = Script.RandomInteger(3) + 1
    print("self.mode = " .. _ARG_0_.mode .. "\n")
    _ARG_0_.mode = Script.RandomInteger(3) + 1
    print("self.mode = " .. _ARG_0_.mode .. "\n")
    _ARG_0_.mode = Script.RandomInteger(3) + 1
    print("self.mode = " .. _ARG_0_.mode .. "\n")
    Enemy.SetSeFileID(_ARG_1_, 299)
    Player.SetBattleFlagTargetHpOff(1)
    _ARG_0_.changeCnt = 0
    if _UPVALUE0_ == false then
      _UPVALUE1_ = Enemy.GetExtraParam(_ARG_1_, "MinFrame")
      _UPVALUE2_ = Enemy.GetExtraParam(_ARG_1_, "AddFrame")
      _UPVALUE3_ = Enemy.GetExtraParam(_ARG_1_, "IdlingTime") * 60
      _UPVALUE4_ = Enemy.GetExtraParam(_ARG_1_, "MoveTime") * 60
      _UPVALUE0_ = true
    end
    _ARG_0_:ChangeEnemyParam()
    if Enemy.IsAllEnemyWaiting() then
      _ARG_0_:GotoState("Waiting")
    else
      _ARG_0_:GotoState("Appear")
    end
  end,
  OnHitAttack = function(_ARG_0_)
  end,
  OnReturnDamage = function(_ARG_0_)
    _ARG_0_:GotoState(_UPVALUE0_[_ARG_0_.mode])
  end,
  OnDamageBefore = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    Entity.EnableAvoidPlayer(_ARG_0_.myHandle, 0)
    print("OnDamage\n")
    _ARG_0_:SuccessHit(_ARG_3_)
    return 1
  end,
  OnDamage = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    return 0
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
    if _ARG_0_.changeCnt < 0 then
      _ARG_0_.changeCnt = -1
    else
      _ARG_0_.changeCnt = _ARG_0_.changeCnt - Entity.GetFrameRate(_ARG_0_.myHandle)
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
        Entity.SetModelPartsAlpha(_ARG_0_.myHandle, 0, 1)
        Entity.SetModelPartsAlpha(_ARG_0_.myHandle, 1, 1)
        Entity.SetModelPartsAlpha(_ARG_0_.myHandle, 2, 1)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        _ARG_0_:GotoState(_UPVALUE0_[Script.GetDebugAttackNumber() + 1])
      end
    end
  end
}, {__index = __StateMachine})
EntityFactory:Add("m57ex00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
