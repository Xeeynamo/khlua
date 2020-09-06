setmetatable({
  [6] = {
    {
      frame = 3,
      func = function(_ARG_0_)
        _UPVALUE0_:set(0, 0, 0)
        _UPVALUE1_:set(0, 0, 0)
        Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "cap", _UPVALUE0_)
        SetBulletAttackParam(Bullet.CreateBullet("CureSmokeL", _UPVALUE0_, _UPVALUE1_), _ARG_0_.myHandle, 4)
      end
    }
  },
  [15] = {
    {
      frame = 3,
      func = function(_ARG_0_)
        _UPVALUE0_:set(0, 0, 0)
        _UPVALUE1_:set(0, 0, 0)
        Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "cap", _UPVALUE0_)
        SetBulletAttackParam(Bullet.CreateBullet("CureSmokeS", _UPVALUE0_, _UPVALUE1_), _ARG_0_.myHandle, 3)
      end
    }
  },
  [16] = {
    {
      frame = 4,
      func = function(_ARG_0_)
        _UPVALUE0_:set(0, 0, 0)
        _UPVALUE1_:set(0, 0, 0)
        Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "cap", _UPVALUE0_)
        SetBulletAttackParam(Bullet.CreateBullet("CureSmokeS", _UPVALUE0_, _UPVALUE1_), _ARG_0_.myHandle, 3)
      end
    }
  },
  ["new"] = function(_ARG_0_)
    return setmetatable(MotionTrigger:new(), _UPVALUE0_)
  end
}, {__index = MotionTrigger})
setmetatable({
  new = function(_ARG_0_)
    return setmetatable(__StateMachine:new(), _UPVALUE0_)
  end,
  states = {
    Appear = {
      OnBeginState = function(_ARG_0_)
        SetupAppearBegin(_ARG_0_.myHandle, -1, _UPVALUE0_, 1)
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
          _ARG_0_:GotoState("Wander")
        end
      end
    },
    Waiting = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        _UPVALUE2_:set(0, 0, 0)
        _ARG_0_.poisonFilterHandle = Entity.SetEffect(_ARG_0_.myHandle, "e_ex500", "E036_FLT_00_0", _UPVALUE2_, _UPVALUE2_)
        Effect.SetObjType(_ARG_0_.poisonFilterHandle, OBJ_TYPE_CAMERA)
        Effect.SetAlpha(_ARG_0_.poisonFilterHandle, 0)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        _UPVALUE0_:set(0, 0, 0)
        SetBulletAttackParam(Bullet.CreateBullet("Poison", _UPVALUE0_, _UPVALUE0_), _ARG_0_.myHandle, 5)
        _ARG_0_.poisonHandle = Bullet.CreateBullet("Poison", _UPVALUE0_, _UPVALUE0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          Effect.SetAlpha(_ARG_0_.poisonFilterHandle, 1 - Entity.GetTimer(_ARG_0_.myHandle) / _UPVALUE0_)
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_.playerBadStatusHandle = Entity.CreateBadStatusEffect(Player.GetHandle(), BAD_STATUS_POISON)
            _ARG_0_.step = 2
          end
        end
        if Enemy.IsAllEnemyWaiting() == false then
          _ARG_0_:GotoState("Wander")
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
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Wander = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        Entity.EnableAvoidPlayer(_ARG_0_.myHandle, 1)
        Entity.EnableAvoidEnemy(_ARG_0_.myHandle, 1)
        _ARG_0_.rotX = 0
        _ARG_0_.timer = 0
        _ARG_0_.step = 0
        _ARG_0_.stack:clear()
        print("Wander\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.EnableAvoidPlayer(_ARG_0_.myHandle, 0)
        Entity.EnableAvoidEnemy(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.timer <= 0 or Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) <= 1 then
          Entity.GetStartPos(_ARG_0_.targetPos, _ARG_0_.myHandle)
          _UPVALUE0_:set(Math.Cos((Script.RandomInRange(-PI, PI))) * (Script.Random() * 20), Script.Random(), Math.Sin((Script.RandomInRange(-PI, PI))) * (Script.Random() * 20))
          FVECTOR3.Add(_ARG_0_.targetPos, _ARG_0_.targetPos, _UPVALUE0_)
          _ARG_0_.timer = Script.RandomInRange(_UPVALUE1_, _UPVALUE1_ * 2)
        end
        _ARG_0_:CalcTargetVelocity(_ARG_0_.targetPos, 1.5, _UPVALUE2_())
        if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
          return
        end
        if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) == false then
          return
        end
        _ARG_0_.stack:push("Wander")
        if Entity.CalcDistance(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE3_ then
          if Script.Random() < _UPVALUE4_ then
            _ARG_0_.stack:push("TargetBackMove")
          else
            _ARG_0_.stack:push("Disappear")
          end
          if Script.Random() < _ARG_0_.param.M50EX_BEHAVIOR1_RND1 then
            _ARG_0_.stack:push("DrainMist")
          else
            _ARG_0_.stack:push("PoisonRush")
          end
        elseif Entity.CalcDistance(_ARG_0_.myHandle, _ARG_0_.targetHandle) >= _UPVALUE3_ and Entity.CalcDistance(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE5_ then
          if Script.Random() < _UPVALUE6_ then
            _ARG_0_.stack:push("TargetFrontMove")
          elseif Script.Random() >= _UPVALUE6_ and Script.Random() < _UPVALUE6_ + _UPVALUE7_ then
            _ARG_0_.stack:push("TargetBackMove")
          else
            _ARG_0_.stack:push("TargetBackMove")
            _ARG_0_.stack:push("DrainMist")
          end
        elseif Script.Random() < _UPVALUE8_ then
          _ARG_0_.stack:push("Idling")
        else
          _ARG_0_.stack:push("TargetFrontMove")
        end
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      end
    },
    TargetFrontMove = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        _ARG_0_.radius = Script.RandomInRange(4, 8)
        print("TargetFrontMove\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.GetDir(_UPVALUE0_, _ARG_0_.targetHandle)
        _UPVALUE0_:scale(_ARG_0_.radius)
        Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.targetHandle, 2)
        FVECTOR3.Add(_ARG_0_.targetPos, _UPVALUE1_, _UPVALUE0_)
        Entity.GetStartPos(_UPVALUE2_, _ARG_0_.myHandle)
        _ARG_0_.targetPos:sety(_UPVALUE2_:gety())
        _ARG_0_:CalcTargetVelocity(_ARG_0_.targetPos, 1.5, _UPVALUE3_())
        if _ARG_0_:IsEnemyWithinFOV(1) or Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    TargetBackMove = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        _ARG_0_.radius = Script.RandomInRange(4, 8)
        print("TargetBackMove\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.GetDir(_UPVALUE0_, _ARG_0_.targetHandle)
        _UPVALUE0_:scale(-_ARG_0_.radius)
        Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.targetHandle, 2)
        FVECTOR3.Add(_ARG_0_.targetPos, _UPVALUE1_, _UPVALUE0_)
        Entity.GetStartPos(_UPVALUE2_, _ARG_0_.myHandle)
        _ARG_0_.targetPos:sety(_UPVALUE2_:gety())
        _ARG_0_:CalcTargetVelocity(_ARG_0_.targetPos, 1.5, _UPVALUE3_())
        if _ARG_0_:IsEnemyWithinFOV(-1) or Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    PoisonRush = {
      OnBeginState = function(_ARG_0_)
        print("PoisonRush\n")
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.velocity:set(0, 0.2, 0)
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
        Entity.SetTimer(_ARG_0_.myHandle, 60)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
          Entity.GetWorldPos(_ARG_0_.playerPos, _ARG_0_.targetHandle, 2)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.playerPos, 30)
          if Entity.IsTimeOver(_ARG_0_.myHandle) or _ARG_0_.playerPos:gety() - _ARG_0_.myPos:gety() >= 3 or 0 >= _ARG_0_.playerPos:gety() - _ARG_0_.myPos:gety() then
            FVECTOR3.Sub(_ARG_0_.velocity, _ARG_0_.playerPos, _ARG_0_.myPos)
            Entity.SetTimer(_ARG_0_.myHandle, (_ARG_0_.velocity:length() + 2.5) / _UPVALUE0_)
            Entity.SetRot(_ARG_0_.myHandle, 0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle), 0)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.velocity:normalize()
            _ARG_0_.axis:copy(_ARG_0_.velocity)
            _ARG_0_.velocity:scale(_UPVALUE0_)
            _ARG_0_.angle = 0
            _ARG_0_.flag = true
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if Enemy.isBind(_ARG_0_.myHandle) == 0 then
            Entity.RotateAxis(_ARG_0_.myHandle, _ARG_0_.axis, _ARG_0_.angle, _UPVALUE1_, _ARG_0_.myPos)
            _ARG_0_.angle = RoundPI(_ARG_0_.angle + DegToRad(_UPVALUE2_ * Entity.GetFrameRate(_ARG_0_.myHandle)))
            FVECTOR3.Scale(_UPVALUE3_, _ARG_0_.velocity, (Entity.GetFrameRate(_ARG_0_.myHandle)))
            FVECTOR3.Add(_ARG_0_.myPos, _ARG_0_.myPos, _UPVALUE3_)
          end
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_.flag = false
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 and _ARG_0_:TurnX(0, 10) == false then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    DrainMist = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 1)
        Entity.SetAACNoUpdateAttackID(_ARG_0_.myHandle, 1)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        _ARG_0_.step = 0
        _ARG_0_.drainMistSuccess = false
        print("DrainMist\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          if Entity.GetFloorDistance(_ARG_0_.myHandle) > 1.5 then
            Entity.ClearSpeed(_ARG_0_.myHandle)
          else
            _ARG_0_.velocity:set(0, 0.025, 0)
            Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
          end
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 17 then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          if _ARG_0_.drainMistSuccess then
            _ARG_0_.step = 2
            _ARG_0_.count = 0
            Entity.SetTimer(_ARG_0_.myHandle, 0)
          elseif Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
            _ARG_0_.step = 3
          end
        elseif _ARG_0_.step == 2 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_.count = _ARG_0_.count + 1
            Entity.SetTimer(_ARG_0_.myHandle, 10)
            Entity.CreatePrize(_ARG_0_.drainMistHandle, 7, 1, _ARG_0_.myHandle, "hara", 0.05)
            if _ARG_0_.count >= 3 then
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
              _ARG_0_.step = 3
            end
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Runaway = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        print("Runaway\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
        Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.targetHandle)
        FVECTOR3.Sub(_UPVALUE0_, _UPVALUE0_, _UPVALUE1_)
        _UPVALUE0_:normalize()
        _UPVALUE0_:scale(20)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE0_, 10)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE2_())
        if Entity.CalcDistance(_ARG_0_.myHandle, _ARG_0_.targetHandle) >= _UPVALUE3_ or Entity.IsWall(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Evade = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
        Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
        _UPVALUE1_:sety(Math.Atan2(_ARG_0_.velocity:getx(), _ARG_0_.velocity:getz()))
        Entity.SetRot(_ARG_0_.myHandle, _UPVALUE1_)
        Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.myHandle)
        print("Evade\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.CalcDistance(_ARG_0_.myHandle, _ARG_0_.targetPos) >= _UPVALUE0_ * _ARG_0_.param.distance or Entity.IsWall(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Disappear = {
      OnBeginState = function(_ARG_0_)
        SetupDisappear(_ARG_0_.myHandle, 30)
        _ARG_0_.step = 0
        print("Disappear\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsModelFade(_ARG_0_.myHandle) == false then
            Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
            _UPVALUE1_:copy(_UPVALUE0_)
            for _FORV_5_ = 0, 360, 30 do
              _UPVALUE1_:copy(_UPVALUE0_)
              _UPVALUE2_:set(_UPVALUE3_ * Math.Cos((RoundPI(DegToRad(_FORV_5_)))), 0, _UPVALUE3_ * Math.Sin((RoundPI(DegToRad(_FORV_5_)))))
              FVECTOR3.Add(_UPVALUE1_, _UPVALUE1_, _UPVALUE2_)
              Collision.IntersectRayBg(_UPVALUE1_, COLL_KIND_ENEMY, _UPVALUE0_, _UPVALUE1_)
              FVECTOR3.Sub(_UPVALUE2_, _UPVALUE1_, _UPVALUE0_)
              if 0 < _UPVALUE2_:dot(_UPVALUE2_) then
                _UPVALUE4_:copy(_UPVALUE1_)
              end
            end
            _FOR_.SetLocalPos(_ARG_0_.myHandle, _UPVALUE4_)
            Entity.SetTimer(_ARG_0_.myHandle, 2)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            SetupAppearBegin(_ARG_0_.myHandle, -1, _UPVALUE5_, 1)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    }
  },
  TurnX = function(_ARG_0_, _ARG_1_, _ARG_2_)
    Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
    _UPVALUE0_:setx(HomingDegree(_UPVALUE0_:getx(), _ARG_1_, _ARG_2_, Entity.GetFrameRate(_ARG_0_.myHandle)))
    Entity.SetRot(_ARG_0_.myHandle, _UPVALUE0_)
    return HomingDegree(_UPVALUE0_:getx(), _ARG_1_, _ARG_2_, Entity.GetFrameRate(_ARG_0_.myHandle))
  end,
  CalcTargetVelocity = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
    FVECTOR3.Sub(_UPVALUE1_, _ARG_1_, _UPVALUE0_)
    _UPVALUE1_:normalize()
    FVECTOR3.Mul(_UPVALUE2_, _UPVALUE1_, _UPVALUE1_)
    Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
    _UPVALUE0_:sety(HomingDegree(_UPVALUE0_:gety(), Math.Atan2(_UPVALUE1_:getx(), _UPVALUE1_:getz()), _ARG_2_, (Entity.GetFrameRate(_ARG_0_.myHandle))))
    Entity.SetRot(_ARG_0_.myHandle, _UPVALUE0_)
    _ARG_0_.rotX = HomingDegree(_ARG_0_.rotX, -Math.Atan2(_UPVALUE1_:gety(), Math.Sqrt(_UPVALUE2_:getx() + _UPVALUE2_:getz())), _ARG_2_, (Entity.GetFrameRate(_ARG_0_.myHandle)))
    _UPVALUE0_:setx(_ARG_0_.rotX)
    _UPVALUE1_:set(0, 0, _ARG_3_)
    Math.RotateVectorXYZ(_UPVALUE1_, _UPVALUE0_)
    Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE1_)
  end,
  IsEnemyWithinFOV = function(_ARG_0_, _ARG_1_)
    Entity.GetDir(_UPVALUE0_, _ARG_0_.targetHandle)
    _UPVALUE0_:scale(_ARG_1_)
    Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
    Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.targetHandle)
    FVECTOR3.Sub(_UPVALUE3_, _UPVALUE1_, _UPVALUE2_)
    _UPVALUE3_:normalize()
    if _UPVALUE0_:dot(_UPVALUE3_) >= Math.Cos(DegToRad(45)) then
      return true
    end
    return false
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    if _UPVALUE0_ == false then
      _UPVALUE1_ = Enemy.GetExtraParam(_ARG_1_, "PRSpd")
      _UPVALUE2_ = Enemy.GetExtraParam(_ARG_1_, "PRRotSpd")
      _UPVALUE3_ = Enemy.GetExtraParam(_ARG_1_, "PRRadius")
      _UPVALUE4_ = Enemy.GetExtraParam(_ARG_1_, "B_DIST")
      _UPVALUE5_ = Enemy.GetExtraParam(_ARG_1_, "CUR_SMK_LF") * 60
      _UPVALUE6_ = Enemy.GetExtraParam(_ARG_1_, "MvSpd0s")
      _UPVALUE7_[1].MoveSpeed = Enemy.GetExtraParam(_ARG_1_, "MvSpd30s")
      _UPVALUE7_[2].MoveSpeed = Enemy.GetExtraParam(_ARG_1_, "MvSpd60s")
      _UPVALUE7_[3].MoveSpeed = Enemy.GetExtraParam(_ARG_1_, "MvSpd120s")
      _UPVALUE8_ = Enemy.GetExtraParam(_ARG_1_, "RASpd0s")
      _UPVALUE7_[1].RunAwaySpeed = Enemy.GetExtraParam(_ARG_1_, "RASpd30s")
      _UPVALUE7_[2].RunAwaySpeed = Enemy.GetExtraParam(_ARG_1_, "RASpd60s")
      _UPVALUE7_[3].RunAwaySpeed = Enemy.GetExtraParam(_ARG_1_, "RASpd120s")
      _UPVALUE9_ = Enemy.GetExtraParam(_ARG_1_, "StartFrameP")
      _UPVALUE10_ = Enemy.GetExtraParam(_ARG_1_, "FadeTimeP")
      _UPVALUE11_ = Enemy.GetExtraParam(_ARG_1_, "n1")
      _UPVALUE11_ = _UPVALUE11_ * _UPVALUE11_
      _UPVALUE12_ = Enemy.GetExtraParam(_ARG_1_, "n2")
      _UPVALUE12_ = _UPVALUE12_ * _UPVALUE12_
      _UPVALUE13_ = Enemy.GetExtraParam(_ARG_1_, "n3") / 100
      _UPVALUE14_ = Enemy.GetExtraParam(_ARG_1_, "n4") / 100
      _UPVALUE15_ = Enemy.GetExtraParam(_ARG_1_, "n5") / 100
      _UPVALUE16_ = Enemy.GetExtraParam(_ARG_1_, "n6") / 100
      _UPVALUE0_ = true
    end
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.step = 0
    _ARG_0_.playerHpCheckStep = 0
    _ARG_0_.targetHandle = NULL_HANDLE
    _ARG_0_.poisonHandle = NULL_HANDLE
    _ARG_0_.poisonFilterHandle = NULL_HANDLE
    _ARG_0_.drainMistHandle = NULL_HANDLE
    _ARG_0_.drainMistSuccess = false
    _ARG_0_.activeCameraHandle = NULL_HANDLE
    _ARG_0_.playerBadStatusHandle = NULL_HANDLE
    _ARG_0_.flag = false
    _ARG_0_.angle = 0
    _ARG_0_.rotX = 0
    _ARG_0_.timer = 0
    _ARG_0_.dmgKind = 0
    _ARG_0_.radius = _UPVALUE3_
    _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
    _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
    _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.playerPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.axis = FVECTOR3.new(0, 0, 0)
    _ARG_0_.param = _UPVALUE17_()
    _ARG_0_.motTrg = _UPVALUE18_:new()
    _ARG_0_.stack = Stack:Create()
    _UPVALUE19_:set(2, 2, 2)
    Entity.SetScale(_ARG_1_, _UPVALUE19_)
    Entity.SetMovementCollRadius(_ARG_1_, 1)
    Entity.SetLowerHalf(_ARG_1_, 1.5)
    Enemy.EnableNoCalcDamage(_ARG_1_, 1)
    Enemy.SetViewDist(_ARG_1_, 100)
    Player.SetDamageFlagImmortal(Player.GetHandle(), 1)
    if Enemy.IsAllEnemyWaiting() then
      _ARG_0_:GotoState("Waiting")
    else
      _ARG_0_:GotoState("Appear")
    end
  end,
  OnDestroy = function(_ARG_0_)
    Effect.KillEffect(_ARG_0_.poisonFilterHandle)
    Effect.KillEffect(_ARG_0_.playerBadStatusHandle)
  end,
  OnSetMotion = function(_ARG_0_, _ARG_1_)
    _ARG_0_.motTrg.current = 1
  end,
  OnHitAttack = function(_ARG_0_, _ARG_1_, _ARG_2_)
    if _ARG_0_:GetState() == "DrainMist" and _ARG_0_.drainMistSuccess == false then
      _ARG_0_.drainMistSuccess = true
      _ARG_0_.drainMistHandle = _ARG_1_
    end
  end,
  OnDamage = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    _ARG_0_.flag = false
    Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
    _UPVALUE0_:setx(0)
    Entity.SetRot(_ARG_0_.myHandle, _UPVALUE0_)
    if Enemy.IsSpecialDamage(_ARG_0_.myHandle) then
      if Enemy.IsBigDamage(_ARG_0_.myHandle, _ARG_1_) then
      else
      end
      _UPVALUE0_:set(0, 0, 0)
      _UPVALUE1_:set(0, 0, 0)
      Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "cap", _UPVALUE0_)
      SetBulletAttackParam(Bullet.CreateBullet("CureSmokeS", _UPVALUE0_, _UPVALUE1_), _ARG_0_.myHandle, 3)
    end
    return 0
  end,
  OnBeginDamageReaction = function(_ARG_0_)
    _ARG_0_.step = 0
  end,
  OnUpdateDamageReaction = function(_ARG_0_, _ARG_1_)
    if _ARG_0_.step == 0 then
      _ARG_0_.dmgKind = _ARG_1_
      _ARG_0_.step = 1
    end
    return 0
  end,
  OnUpdateBlow = function(_ARG_0_)
    if Entity.IsGround(_ARG_0_.myHandle) then
      Entity.GetVelocity(_ARG_0_.velocity, _ARG_0_.myHandle)
      _ARG_0_.velocity:sety(0)
      return 1
    end
    return 0
  end,
  OnReturnDamage = function(_ARG_0_)
    _ARG_0_.stack:clear()
    _ARG_0_.stack:push("Wander")
    if _ARG_0_.dmgKind == REACTION_KIND_FAINT then
      _ARG_0_.stack:push("Runaway")
    elseif _ARG_0_.dmgKind == REACTION_KIND_BLOW_DAMAGE then
      _ARG_0_.stack:push("Disappear")
      _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      return
    end
    _ARG_0_.stack:push("PoisonRush")
    _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
  end,
  OnUpdatePositionAfter = function(_ARG_0_)
    if _ARG_0_.flag then
      _UPVALUE0_:set(0, _ARG_0_.angle, 0)
      Entity.RotateBoneXYZ(_ARG_0_.myHandle, 2, _UPVALUE0_)
    end
    _ARG_0_.motTrg:Update(_ARG_0_, Entity.GetCurrentMotion(_ARG_0_.myHandle), Entity.GetMotionNowFrame(_ARG_0_.myHandle))
    if _ARG_0_.playerHpCheckStep == 0 and Entity.GetHp(Player.GetHandle()) <= 1 then
      Entity.Out(_ARG_0_.poisonHandle)
      Mission.SendMissonMessage(MES_MEDICINE_HP_OUT)
      _ARG_0_.playerHpCheckStep = 1
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
        _ARG_0_.stack:clear()
        _ARG_0_.stack:push("Wander")
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        _ARG_0_:GotoState(_UPVALUE0_[Script.GetDebugAttackNumber() + 1])
      end
    end
  end
}, {__index = __StateMachine})
EntityFactory:Add("m50ex00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("CureSmokeS", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("CureSmokeL", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("Poison", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
