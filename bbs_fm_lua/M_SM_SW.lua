setmetatable({
  new = function(_ARG_0_)
    return setmetatable(__StateMachine:new(), _UPVALUE0_)
  end,
  states = {
    Wait = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_:SetMotion(_UPVALUE0_, 0, -1)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
      end
    },
    EscapeWait = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_:SetMotion(_UPVALUE0_, 0, -1)
        Entity.SetModelPartsAlpha(_ARG_0_.myHandle, _UPVALUE1_[_ARG_0_.kind][1], 0)
        Entity.SetModelPartsAlpha(_ARG_0_.myHandle, _UPVALUE1_[_ARG_0_.kind][2], 0)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE0_ then
          _ARG_0_:GotoState("Escpae")
        end
      end
    },
    Escpae = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_:SetMotion(_UPVALUE0_, 0, -1)
        Entity.EnableHeavy(_ARG_0_.myHandle, 0)
        Entity.SetModelPartsAlpha(_ARG_0_.myHandle, _UPVALUE1_[_ARG_0_.kind][1], 1)
        Entity.SetModelPartsAlpha(_ARG_0_.myHandle, _UPVALUE1_[_ARG_0_.kind][2], 1)
        _UPVALUE2_:set(0, 0, 100)
        _UPVALUE3_:set(0, Entity.CalcDirection(_ARG_0_.targetHandle, _ARG_0_.myHandle), 0)
        Math.RotateVectorXYZ(_UPVALUE2_, _UPVALUE3_)
        Entity.GetWorldPos(_UPVALUE4_, _ARG_0_.targetHandle)
        FVECTOR3.Add(_ARG_0_.targetPos, _UPVALUE4_, _UPVALUE2_)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.EnableHeavy(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsWall(_ARG_0_.myHandle) then
            Entity.GetVelocity(_UPVALUE0_, _ARG_0_.myHandle)
            Entity.GetWallNormal(_UPVALUE1_, _ARG_0_.myHandle)
            _UPVALUE0_:scale(-1)
            _UPVALUE1_:scale(2 * _UPVALUE0_:dot(_UPVALUE1_))
            FVECTOR3.Sub(_UPVALUE1_, _UPVALUE1_, _UPVALUE0_)
            _UPVALUE1_:sety(0)
            _UPVALUE1_:normalize()
            _UPVALUE1_:scale(100)
            Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.myHandle)
            FVECTOR3.Add(_ARG_0_.targetPos, _UPVALUE2_, _UPVALUE1_)
            Entity.SetTimer(_ARG_0_.myHandle, 60)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 and Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_.step = 0
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 10)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.speed)
        if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _UPVALUE3_ then
          _ARG_0_:GotoState("EscapeWait")
        end
      end
    },
    Truck = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_:SetMotion(_UPVALUE0_, 0, -1)
        _ARG_0_.step = 0
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.GetTimer(_ARG_0_.myHandle) >= _UPVALUE0_ - 120 or Entity.GetTimer(_ARG_0_.myHandle) <= 120 then
          Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        else
          Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
        end
        Entity.UpdateExusiaPath(_ARG_0_.myHandle, _ARG_0_.step, 1 - Entity.GetTimer(_ARG_0_.myHandle) / _UPVALUE0_, true)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
          _ARG_0_.step = _ARG_0_.step + 1
          if 1 < _ARG_0_.step then
            _ARG_0_.step = 0
          end
        end
      end
    },
    Sneeze = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_:SetMotion(_UPVALUE0_, 0, -1)
        Entity.SetTimer(_ARG_0_.myHandle, Script.RandomInRange(_UPVALUE1_, _UPVALUE1_ * 2))
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
            Entity.SetRot(_ARG_0_.myHandle, 0, RoundPI(Entity.CalcDirection(_ARG_0_.targetHandle, _ARG_0_.myHandle) + Script.RandomInRange(-PI * 0.5, PI * 0.5)), 0)
            _ARG_0_:SetMotion(_UPVALUE1_, 0, -1)
            _UPVALUE2_:set(0, _UPVALUE3_ * 30 / 2, _UPVALUE4_)
            Entity.CalcVelocity(_ARG_0_.myHandle, _UPVALUE2_)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 15 then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.count = _ARG_0_.count + 1
          if _ARG_0_.count >= _UPVALUE5_ then
            _ARG_0_:SetMotion(_UPVALUE6_, 0, -1)
            Entity.SetTimer(_ARG_0_.myHandle, Script.RandomInRange(_UPVALUE7_, _UPVALUE7_ * 2))
            _ARG_0_.count = 0
            _ARG_0_.step = 0
          else
            Entity.SetRot(_ARG_0_.myHandle, 0, RoundPI(Entity.CalcDirection(_ARG_0_.targetHandle, _ARG_0_.myHandle) + Script.RandomInRange(-PI * 0.5, PI * 0.5)), 0)
            _ARG_0_:SetMotion(_UPVALUE1_, 0, -1)
            _UPVALUE2_:set(0, _UPVALUE3_ * 30 / 2, _UPVALUE4_)
            Entity.CalcVelocity(_ARG_0_.myHandle, _UPVALUE2_)
            _ARG_0_.step = 1
          end
        end
        if _ARG_0_.isGround == false and Entity.IsGround(_ARG_0_.myHandle) then
          Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.myHandle)
          _UPVALUE8_:set(0, 0, 0)
          Entity.SetEffect(_ARG_0_.myHandle, "g_sw_018_00", "G_SW_BOX_SMK1_0", _UPVALUE2_, _UPVALUE8_)
        end
        _ARG_0_.isGround = Entity.IsGround(_ARG_0_.myHandle)
      end
    },
    SearchTarget = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_:SetMotion(_UPVALUE0_, 0, -1)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        Entity.SetModelPartsAlpha(_ARG_0_.myHandle, _UPVALUE2_[_ARG_0_.kind][1], 0)
        Entity.SetModelPartsAlpha(_ARG_0_.myHandle, _UPVALUE2_[_ARG_0_.kind][2], 0)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
          return
        end
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE0_ then
          _ARG_0_:GotoState("Attack")
        end
      end
    },
    Attack = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_:SetMotion(_UPVALUE0_, 0, -1)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        Entity.EnableHeavy(_ARG_0_.myHandle, 0)
        Entity.SetModelPartsAlpha(_ARG_0_.myHandle, _UPVALUE2_[_ARG_0_.kind][1], 1)
        Entity.SetModelPartsAlpha(_ARG_0_.myHandle, _UPVALUE2_[_ARG_0_.kind][2], 1)
        _ARG_0_.count = 0
        _ARG_0_.step = 0
        print("\141U\140\130\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE0_)
        if _ARG_0_.step == 0 then
          if Entity.IsWall(_ARG_0_.myHandle) then
            _ARG_0_.timer = 60
            _ARG_0_.step = 1
          end
        else
          _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 >= _ARG_0_.timer then
            Entity.SetTimer(_ARG_0_.myHandle, 0)
          elseif Entity.IsWall(_ARG_0_.myHandle) == false then
            _ARG_0_.step = 0
          end
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("AttackEnd")
        end
      end
    },
    AttackEnd = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_:SetMotion(_UPVALUE0_, 0, -2)
        Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
        Entity.SetTimer(_ARG_0_.myHandle, 300)
        for _FORV_5_ = 0, 360, 30 do
          _UPVALUE2_:set(Math.Cos((RoundPI(DegToRad(_FORV_5_)))) * 10, 0, Math.Sin((RoundPI(DegToRad(_FORV_5_)))) * 10)
          FVECTOR3.Add(_UPVALUE2_, _UPVALUE1_, _UPVALUE2_)
          Collision.IntersectRayBg(_UPVALUE2_, COLL_KIND_ENEMY, _UPVALUE1_, _UPVALUE2_)
          if 0 < Entity.CalcDistanceSq(_ARG_0_.myHandle, _UPVALUE2_) then
            _ARG_0_.targetPos:copy(_UPVALUE2_)
          end
        end
        _FOR_:copy(_ARG_0_.targetPos)
        _UPVALUE2_:copy(_ARG_0_.targetPos)
        _UPVALUE1_:sety(_UPVALUE1_:gety() + 1)
        _UPVALUE2_:sety(_UPVALUE2_:gety() - 10)
        Collision.IntersectRayBg(_ARG_0_.targetPos, COLL_KIND_ENEMY, _UPVALUE1_, _UPVALUE2_)
        print("\141U\140\130\143I\151\185\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.EnableHeavy(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 10)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE0_)
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) <= 2.25 or Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("SearchTarget")
        end
      end
    },
    Appear = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_:SetMotion(_UPVALUE0_, 0, -1)
        _ARG_0_.step = 0
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        Entity.SetModelPartsAlpha(_ARG_0_.myHandle, _UPVALUE1_[_ARG_0_.kind][1], 1)
        Entity.SetModelPartsAlpha(_ARG_0_.myHandle, _UPVALUE1_[_ARG_0_.kind][2], 1)
        Player.NotifyEventStart(Player.GetHandle())
        Player.SetPadFlagCtrlOn(0)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        Player.SetPlayerFlagInvincible(Player.GetHandle(), 1)
        if _ARG_0_.step == 0 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 and Mission.SetSearchedMidgetFlag(_ARG_0_.id) then
          _ARG_0_.step = 2
        end
      end
    }
  },
  SetMotion = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_[_ARG_0_.kind][_ARG_1_], _ARG_2_, _ARG_3_)
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.step = 0
    _ARG_0_.targetHandle = NULL_HANDLE
    _ARG_0_.id = 0
    _ARG_0_.kind = 1
    _ARG_0_.count = 0
    _ARG_0_.timer = 0
    _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
    Enemy.EnableNoDamageReaction(_ARG_1_, 1)
    Enemy.EnableUpdateVision(_ARG_1_, 0)
    Entity.EnableBgColl(_ARG_1_, 0)
    Entity.SetModelPartsAlpha(_ARG_1_, 0, 0)
    Entity.SetModelPartsAlpha(_ARG_1_, 1, 0)
    Enemy.EnableNoFaceAnim(_ARG_1_, 1)
    if Entity.GetName(_ARG_1_) == "m02sw00" then
      _ARG_0_.id = MIDGET_ID_DOC
      _ARG_0_.kind = 1
      _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
      _ARG_0_.speed = _UPVALUE0_
      Entity.EnableGravity(_ARG_1_, 1)
      Entity.EnableBgColl(_ARG_1_, 1)
      Enemy.EnableUpdateVision(_ARG_1_, 1)
    elseif Entity.GetName(_ARG_1_) == "m03sw00" then
      _ARG_0_.id = MIDGET_ID_GRUMPY
      _ARG_0_.kind = 2
      Entity.EnableGravity(_ARG_1_, 1)
      Entity.EnableBgColl(_ARG_1_, 1)
      Enemy.EnableUpdateVision(_ARG_1_, 1)
    elseif Entity.GetName(_ARG_1_) == "m04sw00" then
      _ARG_0_.id = MIDGET_ID_SLEEPY
      _ARG_0_.kind = 3
    elseif Entity.GetName(_ARG_1_) == "m05sw00" then
      _ARG_0_.id = MIDGET_ID_BASHFUL
      _ARG_0_.kind = 4
      Entity.InitExusiaPath(_ARG_1_, "m05sw01", 0)
      Entity.InitExusiaPath(_ARG_1_, "m05sw02", 1)
      Entity.SetModelPartsAlpha(_ARG_1_, 0, 1)
      Entity.SetModelPartsAlpha(_ARG_1_, 1, 1)
    elseif Entity.GetName(_ARG_1_) == "m06sw00" then
      _ARG_0_.id = MIDGET_ID_SNEEZY
      _ARG_0_.kind = 5
      _ARG_0_.isGround = true
      Entity.EnableGravity(_ARG_1_, 1)
      Entity.EnableBgColl(_ARG_1_, 1)
      Entity.SetGravity(_ARG_1_, -_UPVALUE1_)
    elseif Entity.GetName(_ARG_1_) == "m07sw00" then
      _ARG_0_.id = MIDGET_ID_HAPPY
      _ARG_0_.kind = 6
      _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
      _ARG_0_.speed = _UPVALUE2_
      Entity.EnableGravity(_ARG_1_, 1)
      Entity.EnableBgColl(_ARG_1_, 1)
      Enemy.EnableUpdateVision(_ARG_1_, 1)
      Entity.SetModelPartsAlpha(_ARG_1_, 0, 1)
    end
    if Mission.IsSearchedMidgetFromUniqueID(Entity.GetLayoutParam(_ARG_1_, 9)) then
      Enemy.Dead(_ARG_1_)
    else
      if _ARG_0_.kind ~= 4 then
        Entity.SetDispOffCameraDistance(_ARG_1_, 20)
      end
      _ARG_0_:GotoState(_UPVALUE3_[_ARG_0_.kind])
    end
  end,
  OnReturnDamage = function(_ARG_0_)
    _ARG_0_:GotoState("Idling")
  end,
  OnHitAttack = function(_ARG_0_)
    if _ARG_0_.id == MIDGET_ID_GRUMPY then
      _ARG_0_:GotoState("AttackEnd")
    end
  end,
  OnDamage = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    if Script.Random() < 0.34 then
      Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle, 2)
      Sound.PlayVoice(_UPVALUE0_[_ARG_0_.kind][1], _UPVALUE0_[_ARG_0_.kind][2], 1, _UPVALUE1_)
    end
    if _ARG_0_.id == MIDGET_UNIQUE_GRUMPY and Script.Random() >= 0.3 then
      _ARG_0_:GotoState("AttackEnd")
      return 1
    end
    return 0
  end,
  OnDead = function(_ARG_0_)
    _ARG_0_:GotoState("Appear")
    return 1
  end,
  OnStartModelClipFar = function(_ARG_0_)
    Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
  end,
  OnEndModelClipFar = function(_ARG_0_)
    Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
  end,
  OnUpdate = function(_ARG_0_)
    if Entity.IsAlive(_ARG_0_.targetHandle) == false then
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
    end
    _ARG_0_:Update()
  end
}, {__index = __StateMachine})
EntityFactory:Add("m02sw00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("m03sw00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("m04sw00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("m05sw00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("m06sw00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("m07sw00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
