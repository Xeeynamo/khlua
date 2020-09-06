setmetatable({
  new = function(_ARG_0_)
    return setmetatable(__StateMachine:new(), _UPVALUE0_)
  end,
  states = {
    TreasureBoxAppear = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        Entity.SetRot(_ARG_0_.myHandle, 0, Entity.CalcDirection(_ARG_0_.myHandle, (Player.GetHandle())), 0)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 2)
        Player.NotifyEventEnd((Player.GetHandle()))
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Eat")
        end
      end
    },
    Waiting = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Enemy.IsAllEnemyWaiting() == false then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
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
    Idling = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, Script.RandomInRange(_UPVALUE1_, _UPVALUE1_ * 2))
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
          return
        end
        if CanDisappear(_ARG_0_.myHandle, _ARG_0_.targetHandle) then
          _ARG_0_:GotoState("Disappear")
          return
        end
        if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) == false then
          Enemy.GetTargetLastRecordedPos(_ARG_0_.targetPos, _ARG_0_.myHandle, _ARG_0_.targetHandle)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 1.5)
          return
        end
        if _ARG_0_.dmgCount >= _UPVALUE0_ then
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE1_ then
            _ARG_0_:GotoState("PoisonMarshLandMine")
          else
            _ARG_0_:GotoState("Passion")
          end
          return
        end
        if _ARG_0_.modeChangeTimer <= 0 then
          if Script.Random() < 0.7 then
            if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE1_ then
              _ARG_0_:GotoState("PoisonMarshLandMine")
            else
              _ARG_0_:GotoState("Passion")
            end
            return
          end
          _ARG_0_.modeChangeTimer = _UPVALUE2_ + (Script.Random() - Script.Random()) * (Script.Random() * _UPVALUE2_)
        end
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE3_ then
          _ARG_0_.nextState = 1
          _ARG_0_:GotoState("Eat")
        elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) >= _UPVALUE3_ and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < ENEMY_COMMON_DISAPPEAR_DIST then
          _ARG_0_:GotoState("Wander")
        end
      end
    },
    Wander = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_ * 0.5 + Script.Random() * (_UPVALUE1_ * 0.5))
        _ARG_0_.moveTimer = 0
        Entity.EnableAvoidPlayer(_ARG_0_.myHandle, 1)
        Entity.EnableAvoidEnemy(_ARG_0_.myHandle, 1)
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableAvoidPlayer(_ARG_0_.myHandle, 0)
        Entity.EnableAvoidEnemy(_ARG_0_.myHandle, 0)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.HasNetGameHandle(_ARG_0_.myHandle) and Enemy.IsNetworkMaster(_ARG_0_.myHandle) == false then
          return
        end
        _ARG_0_.moveTimer = _ARG_0_.moveTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.moveTimer <= 0 then
          _ARG_0_.theta = RoundPI(DegToRad(Script.Random() * 360))
          _ARG_0_.moveTimer = 30
          _ARG_0_.radius = 5 + Script.Random() * 8
          Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
          _ARG_0_.targetPos:setx(_ARG_0_.targetPos:getx() + _ARG_0_.radius * Math.Cos(_ARG_0_.theta))
          _ARG_0_.targetPos:setz(_ARG_0_.targetPos:getz() + _ARG_0_.radius * Math.Sin(_ARG_0_.theta))
        end
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) <= 1 then
          _ARG_0_.moveTimer = 0
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 10)
        _ARG_0_.velocity:set(0, 0, _UPVALUE0_)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    Eat = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        _ARG_0_.step = 0
        _ARG_0_.eat = false
        _ARG_0_.eatHandle = NULL_HANDLE
        _ARG_0_.targetDispOff = false
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
        _ARG_0_:DamageEatCancel()
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 20)
          if _ARG_0_.eat and _ARG_0_.dmgKind == ATK_KIND_EAT then
            if Entity.GetAttacker(_ARG_0_.eatHandle) == _ARG_0_.myHandle then
              if Player.IsDamageFlagEat(_ARG_0_.eatHandle) then
                Player.DispOff(_ARG_0_.eatHandle)
                _ARG_0_.targetDispOff = true
                print("\144H\130\215\130\189\129I\n")
              else
                print("\144H\130\215\130\231\130\234\130\196\130\162\130\200\130\162\129I\n")
              end
            else
              print("\136\225\130\164\131L\131\131\131\137\130\170\144H\130\215\130\196\130\162\130\233\n")
            end
          end
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            if _ARG_0_.targetDispOff then
              if _ARG_0_.dmgKind == ATK_KIND_EAT then
                if Entity.GetAttacker(_ARG_0_.eatHandle) == _ARG_0_.myHandle then
                  Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
                  _ARG_0_.step = 1
                  return
                end
              else
                if _ARG_0_.nextState == 0 then
                  _ARG_0_:GotoState("Idling")
                else
                  _ARG_0_:GotoState("Stiff")
                end
                return
              end
              _ARG_0_.eat = false
            end
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
            _ARG_0_.step = 2
          end
          return
        elseif _ARG_0_.step == 1 then
          Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle, 7)
          Entity.SetLocalPos(_ARG_0_.eatHandle, _ARG_0_.myPos)
          Entity.SetOldLocalPos(_ARG_0_.eatHandle, _ARG_0_.myPos)
          Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
          _ARG_0_.rot:sety(RoundPI(_ARG_0_.rot:gety() + PI))
          Entity.SetRot(_ARG_0_.eatHandle, _ARG_0_.rot)
          if 20 <= Entity.GetMotionNowFrame(_ARG_0_.myHandle) then
            _ARG_0_.targetDispOff = false
            Player.DispOn(_ARG_0_.eatHandle)
            Player.SetDamage(_ARG_0_.eatHandle, 0, ATK_KIND_DMG_BLOW)
            print("\147f\130\162\130\189\129I\n")
            _ARG_0_.step = 2
          end
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          if _ARG_0_.nextState == 0 then
            _ARG_0_:GotoState("Idling")
          else
            _ARG_0_:GotoState("Stiff")
          end
        end
      end
    },
    PoisonMarshLandMine = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        _ARG_0_.step = 0
        _ARG_0_.aim = Script.RandomInteger(3)
        _ARG_0_:CalcPursuitPos(_ARG_0_.workVec0, 22)
        if _ARG_0_.aim ~= 0 then
          _ARG_0_:RandomPos(_ARG_0_.workVec0, Entity.CalcDistance(_ARG_0_.myHandle, _ARG_0_.workVec0) * (0.35 + Script.Random() * 0.35))
        end
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.workVec0, 20)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 22 then
            _ARG_0_:CreatePoisonBullet(_ARG_0_.workVec0)
            _ARG_0_:CalcPursuitPos(_ARG_0_.workVec0, 12)
            if _ARG_0_.aim ~= 1 then
              _ARG_0_:RandomPos(_ARG_0_.workVec0, Entity.CalcDistance(_ARG_0_.myHandle, _ARG_0_.workVec0) * (0.35 + Script.Random() * 0.35))
            end
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.workVec0, 20)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 34 then
            _ARG_0_:CreatePoisonBullet(_ARG_0_.workVec0)
            _ARG_0_:CalcPursuitPos(_ARG_0_.workVec0, 16)
            if _ARG_0_.aim ~= 2 then
              _ARG_0_:RandomPos(_ARG_0_.workVec0, Entity.CalcDistance(_ARG_0_.myHandle, _ARG_0_.workVec0) * (0.35 + Script.Random() * 0.35))
            end
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.workVec0, 20)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 50 then
            _ARG_0_:CreatePoisonBullet(_ARG_0_.workVec0)
            _ARG_0_.step = 3
          end
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Passion")
        end
      end
    },
    UndergroundMovement = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
        Entity.EnableLockon(_ARG_0_.myHandle, 0)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
        Entity.EnableLockon(_ARG_0_.myHandle, 1)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.SetAlpha(_ARG_0_.myHandle, 1)
        _ARG_0_:ResetModeChange()
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
            Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 1)
            Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
            _ARG_0_.theta = 0
            if Script.Random() < 0.5 then
              _ARG_0_.rotDir = 1
            else
              _ARG_0_.rotDir = -1
            end
            _ARG_0_.baseTheta = Entity.CalcDirection(_ARG_0_.targetHandle, _ARG_0_.myHandle)
            _ARG_0_.moveTimer = 30
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          _ARG_0_.moveTimer = _ARG_0_.moveTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 >= _ARG_0_.moveTimer then
            _ARG_0_.theta = 0
            _ARG_0_.moveTimer = 30
            _ARG_0_.baseTheta = RoundPI(_ARG_0_.baseTheta + DegToRad(Script.Random() * 15))
          end
          _ARG_0_.theta = _ARG_0_.theta + _ARG_0_.rotDir * (3 + Script.Random() * 3)
          if _ARG_0_.theta > 45 then
            _ARG_0_.rotDir = -1
          elseif _ARG_0_.theta < -45 then
            _ARG_0_.rotDir = 1
          end
          Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
          _ARG_0_.targetPos:setx(_ARG_0_.targetPos:getx() + _UPVALUE2_ * Math.Cos((RoundPI(_ARG_0_.baseTheta + DegToRad(_ARG_0_.theta)))))
          _ARG_0_.targetPos:setz(_ARG_0_.targetPos:getz() + _UPVALUE2_ * Math.Sin((RoundPI(_ARG_0_.baseTheta + DegToRad(_ARG_0_.theta)))))
          Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.myHandle)
          Collision.IntersectRayBg(_ARG_0_.targetPos, COLL_KIND_ENEMY, _ARG_0_.workVec0, _ARG_0_.targetPos)
          _ARG_0_.workVec0:copy(_ARG_0_.targetPos)
          _ARG_0_.workVec1:copy(_ARG_0_.targetPos)
          _ARG_0_.workVec0:sety(_ARG_0_.workVec0:gety() + 0.1)
          _ARG_0_.workVec1:sety(_ARG_0_.workVec1:gety() - 0.1)
          if Collision.IntersectRayBg(_ARG_0_.workVec0, COLL_KIND_ENEMY, _ARG_0_.workVec0, _ARG_0_.workVec1) == false then
            Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
          end
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 10)
          _ARG_0_.velocity:set(0, 0, _UPVALUE3_)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
          if Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.IsGround(_ARG_0_.myHandle) == false then
            if Entity.GetName(_ARG_0_.myHandle) == "m08ex00" and _ARG_0_.currentTime > _UPVALUE4_ then
              Entity.GetVelocity(_ARG_0_.velocity, _ARG_0_.myHandle)
              _ARG_0_.velocity:set(0, -0.01, 0)
              Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
              Entity.EnableGravity(_ARG_0_.myHandle, 0)
              Entity.SetTimer(_ARG_0_.myHandle, 60)
              Entity.EnableBgColl(_ARG_0_.myHandle, 0)
              _ARG_0_.step = 3
              return
            end
            _ARG_0_.workVec0:set(0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle), 0)
            Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.workVec0)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE5_)
            Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, 1)
            Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_:GotoState("Passion2")
          end
        elseif _ARG_0_.step == 3 and Entity.IsTimeOver(_ARG_0_.myHandle) then
          Enemy.Disappear(_ARG_0_.myHandle)
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
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    Passion = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("UndergroundMovement")
        end
      end
    },
    Passion2 = {
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
    PathMove = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        Enemy.SetupTargetMove(_ARG_0_.myHandle, 2.5, 2.5)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
        if Enemy.TargetMove(_ARG_0_.myHandle, _ARG_0_.targetPos, 0.1, 20) == 4 then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
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
  IsTargetWithinFOV = function(_ARG_0_)
    _ARG_0_.workVec0:set(0, 0, 1)
    if Entity.IsTargetWithinFOV(_ARG_0_.myHandle, _ARG_0_.targetHandle, DegToRad(180), 7, _ARG_0_.workVec0) == false then
      return false
    end
    return true
  end,
  CreatePoisonBullet = function(_ARG_0_, _ARG_1_)
    Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle, 7)
    Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
    if Enemy.IsConfuse(_ARG_0_.myHandle) then
      Bullet.SetCollision(Bullet.CreateBullet("m08ex00b", _ARG_0_.myPos, _ARG_0_.rot), COLL_KIND_NO_CHECK, COLL_SHAPE_SPHERE, 0.4, 0, _ARG_0_.myHandle)
    else
      Bullet.SetCollision(Bullet.CreateBullet("m08ex00b", _ARG_0_.myPos, _ARG_0_.rot), COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, 0.4, 0, _ARG_0_.myHandle)
    end
    SetBulletAttackParam(Bullet.CreateBullet("m08ex00b", _ARG_0_.myPos, _ARG_0_.rot), _ARG_0_.myHandle, 1)
    Entity.EnableGravity(Bullet.CreateBullet("m08ex00b", _ARG_0_.myPos, _ARG_0_.rot), 1)
    Entity.CalcOrbitVelocityFromSpeedY(Bullet.CreateBullet("m08ex00b", _ARG_0_.myPos, _ARG_0_.rot), 0.25, (Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_1_)))
    if EntityManager:GetEntity((Bullet.CreateBullet("m08ex00b", _ARG_0_.myPos, _ARG_0_.rot))) ~= nil then
      EntityManager:GetEntity((Bullet.CreateBullet("m08ex00b", _ARG_0_.myPos, _ARG_0_.rot))).owner = _ARG_0_.myHandle
      if Enemy.IsConfuse(_ARG_0_.myHandle) then
        EntityManager:GetEntity((Bullet.CreateBullet("m08ex00b", _ARG_0_.myPos, _ARG_0_.rot))).collKind = COLL_KIND_NO_CHECK
      else
        EntityManager:GetEntity((Bullet.CreateBullet("m08ex00b", _ARG_0_.myPos, _ARG_0_.rot))).collKind = COLL_KIND_ENEMY
      end
    end
  end,
  ResetModeChange = function(_ARG_0_)
    _ARG_0_.modeChangeTimer = _UPVALUE0_ + (Script.Random() - Script.Random()) * (Script.Random() * _UPVALUE0_)
    _ARG_0_.dmgCount = 0
  end,
  RandomPos = function(_ARG_0_, _ARG_1_, _ARG_2_)
    _ARG_1_:setx(_ARG_1_:getx() + _ARG_2_ * Math.Cos((RoundPI(DegToRad(Script.Random() * 360)))))
    _ARG_1_:setz(_ARG_1_:getz() + _ARG_2_ * Math.Sin((RoundPI(DegToRad(Script.Random() * 360)))))
  end,
  CalcPursuitPos = function(_ARG_0_, _ARG_1_, _ARG_2_)
    Entity.GetWorldPos(_ARG_0_.workVec2, _ARG_0_.targetHandle)
    Entity.GetVelocity(_ARG_0_.workVec3, _ARG_0_.targetHandle)
    _ARG_0_.workVec3:scale(_ARG_2_ * 2)
    FVECTOR3.Add(_ARG_1_, _ARG_0_.workVec2, _ARG_0_.workVec3)
  end,
  DamageEatCancel = function(_ARG_0_)
    if _ARG_0_.targetDispOff then
      Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle, 7)
      Entity.SetLocalPos(_ARG_0_.eatHandle, _ARG_0_.myPos)
      Entity.SetOldLocalPos(_ARG_0_.eatHandle, _ARG_0_.myPos)
      Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
      _ARG_0_.rot:sety(RoundPI(_ARG_0_.rot:gety() + PI))
      Entity.SetRot(_ARG_0_.eatHandle, _ARG_0_.rot)
      Player.SetTrgFlagCancel(_ARG_0_.eatHandle, 1)
      Player.DispOn(_ARG_0_.eatHandle)
      Player.SetDamage(_ARG_0_.eatHandle, 0, ATK_KIND_DMG_BLOW)
      _ARG_0_.eatHandle = NULL_HANDLE
      _ARG_0_.targetDispOff = false
      print("\147f\130\171\150Y\130\234\129I\n")
    elseif Player.IsDamageFlagEat(_ARG_0_.eatHandle) then
      if Entity.GetAttacker(_ARG_0_.eatHandle) == _ARG_0_.myHandle then
        Player.SetTrgFlagCancel(_ARG_0_.eatHandle, 1)
        _ARG_0_.eatHandle = NULL_HANDLE
        _ARG_0_.targetDispOff = false
        print("\131L\131\131\131\147\131Z\131\139\129I\n")
      else
        print("\146N\130\169\130\170\130\173\130\193\130\198\130\233\n")
      end
    else
      print("\144H\130\237\130\234\130\196\130\214\130\241\129I\n")
    end
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    _ARG_0_.myHandle = _ARG_1_
    Entity.EnableGravity(_ARG_0_.myHandle, 1)
    Entity.SetMovementCollRadius(_ARG_0_.myHandle, 1.5)
    Entity.SetLowerHalf(_ARG_0_.myHandle, 2)
    _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
    _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
    _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.workVec0 = FVECTOR3.new(0, 0, 0)
    _ARG_0_.workVec1 = FVECTOR3.new(0, 0, 0)
    _ARG_0_.workVec2 = FVECTOR3.new(0, 0, 0)
    _ARG_0_.workVec3 = FVECTOR3.new(0, 0, 0)
    _ARG_0_.step = 0
    _ARG_0_.targetHandle = NULL_HANDLE
    _ARG_0_.attackerHandle = NULL_HANDLE
    _ARG_0_.eat = false
    _ARG_0_.targetDispOff = false
    _ARG_0_.rotDir = 1
    _ARG_0_.nextState = 0
    _ARG_0_.currentTime = 0
    _ARG_0_.baseTheta = 0
    _ARG_0_.theta = 0
    _ARG_0_.moveTimer = 0
    _ARG_0_.radius = 0
    _ARG_0_.dmgCount = 0
    _ARG_0_.eatHandle = NULL_HANDLE
    _ARG_0_.dmgKind = 0
    _ARG_0_.aim = 0
    _ARG_0_.flag = 0
    if _UPVALUE0_ == false then
      _UPVALUE0_ = true
      _UPVALUE1_ = Enemy.GetExtraParam(_ARG_1_, "AppearTime") * 60
      _UPVALUE2_ = Enemy.GetExtraParam(_ARG_1_, "PBTime") * 60
      _UPVALUE3_ = Enemy.GetExtraParam(_ARG_1_, "UGMoveTime") * 60
      _UPVALUE4_ = Enemy.GetExtraParam(_ARG_1_, "StiffTime") * 60
      _UPVALUE5_ = Enemy.GetExtraParam(_ARG_1_, "WanderTime") * 60
      _UPVALUE6_ = Enemy.GetExtraParam(_ARG_1_, "Action1Dist")
      _UPVALUE7_ = Enemy.GetExtraParam(_ARG_1_, "Action2Dist")
      _UPVALUE6_ = _UPVALUE6_ * _UPVALUE6_
      _UPVALUE7_ = _UPVALUE7_ * _UPVALUE7_
    end
    _ARG_0_.modeChangeTimer = _UPVALUE8_ + (Script.Random() - Script.Random()) * (Script.Random() * _UPVALUE8_)
    if Entity.HasLayoutData(_ARG_0_.myHandle) then
      if Enemy.IsAllEnemyWaiting() then
        _ARG_0_:GotoState("Waiting")
      else
        _ARG_0_:GotoState("Appear")
      end
    else
      _ARG_0_:GotoState("TreasureBoxAppear")
    end
  end,
  OnDestroy = function(_ARG_0_)
    _ARG_0_:DamageEatCancel()
  end,
  OnHitAttack = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    if Entity.GetCurrentMotion(_ARG_0_.myHandle) == _UPVALUE0_ then
      _ARG_0_.dmgKind = _ARG_3_
      if _ARG_3_ == ATK_KIND_EAT then
        if Entity.IsPlayer(_ARG_1_) then
          _ARG_0_.eat = true
          _ARG_0_.eatHandle = _ARG_1_
          print("\144H\130\215\130\233\141U\140\130\130\170\147\150\130\189\130\193\130\189\129I\129I\n")
        end
      else
        _ARG_0_.eat = true
      end
    end
  end,
  OnDamage = function(_ARG_0_, _ARG_1_, _ARG_2_)
    _ARG_0_:DamageEatCancel()
    _ARG_0_.dmgCount = _ARG_0_.dmgCount + 1
    return 0
  end,
  OnDead = function(_ARG_0_)
    _ARG_0_:DamageEatCancel()
    return 0
  end,
  OnReturnDamage = function(_ARG_0_)
    _ARG_0_:GotoState("Idling")
  end,
  OnReflect = function(_ARG_0_)
    _ARG_0_:DamageEatCancel()
    return 0
  end,
  OnUpdate = function(_ARG_0_)
    if Entity.IsAlive(_ARG_0_.targetHandle) == false then
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
    end
    _ARG_0_:Update()
    _ARG_0_:Debug()
    if _ARG_0_.modeChangeTimer > 0 then
      _ARG_0_.modeChangeTimer = _ARG_0_.modeChangeTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
    end
    _ARG_0_.currentTime = _ARG_0_.currentTime + Entity.GetFrameRate(_ARG_0_.myHandle)
  end,
  OnUpdateDamageReaction = function(_ARG_0_)
    _ARG_0_:DamageEatCancel()
    return 0
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
        Entity.ClearSpeed(_ARG_0_.myHandle)
        _ARG_0_:GotoState(_UPVALUE0_[Script.GetDebugAttackNumber() + 1])
      end
    end
  end
}, {__index = __StateMachine})
EntityFactory:Add("m08ex00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("m08vs00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
m08ex00b = {}
m08ex00b_mt = {__index = m08ex00b}
function m08ex00b.new(_ARG_0_)
  return setmetatable({}, m08ex00b_mt)
end
function m08ex00b.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.scale = FVECTOR3.new(1.5, 1.5, 1.5)
  _ARG_0_.effHandle = NULL_HANDLE
  _ARG_0_.step = 0
  _ARG_0_.collKind = COLL_KIND_ENEMY
  _ARG_0_.owner = NULL_HANDLE
  Entity.EnableGravity(_ARG_1_, 1)
  Entity.SetLowerHalf(_ARG_1_, 0.25)
  Bullet.CreateEffectBullet(_ARG_1_, "e_ex080", "E008_BLT_00_0")
  Bullet.SetHitBgEffectName(_ARG_1_, "e_ex080", "E008_MSH_00_0")
  Bullet.SetMaxMoveDist(_ARG_1_, 100)
  Effect.SetScale(Bullet.GetEffectHandle(_ARG_1_), _ARG_0_.scale)
end
function m08ex00b.OnHitAttack(_ARG_0_)
end
function m08ex00b.OnHitBg(_ARG_0_)
  if Entity.IsWall(_ARG_0_.myHandle) then
    Effect.LoopEnd((Bullet.GetEffectHandle(_ARG_0_.myHandle)))
    Effect.DetachCoord((Bullet.GetEffectHandle(_ARG_0_.myHandle)))
    Entity.Out(_ARG_0_.myHandle)
    return
  end
  Entity.EnableBgColl(_ARG_0_.myHandle, 0)
  Entity.ClearSpeed(_ARG_0_.myHandle)
  Entity.EnableGravity(_ARG_0_.myHandle, 0)
  Effect.LoopEnd((Bullet.GetEffectHandle(_ARG_0_.myHandle)))
  Bullet.SetEffectHandle(_ARG_0_.myHandle, (Bullet.SetHitBgEffect(_ARG_0_.myHandle)))
  Effect.SetScale(Bullet.SetHitBgEffect(_ARG_0_.myHandle), _ARG_0_.scale)
  _ARG_0_.step = 1
  Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
  Bullet.SetCollision(_ARG_0_.myHandle, _ARG_0_.collKind, COLL_SHAPE_SPHERE, 0.75, 0, _ARG_0_.owner)
end
function m08ex00b.OnUpdate(_ARG_0_)
  if Bullet.GetEffectHandle(_ARG_0_.myHandle) == 0 then
    Entity.Out(_ARG_0_.myHandle)
    return
  end
  if _ARG_0_.step == 1 then
    if Entity.IsTimeOver(_ARG_0_.myHandle) then
      Effect.LoopEnd(Bullet.GetEffectHandle(_ARG_0_.myHandle))
      _ARG_0_.step = 2
    end
  elseif _ARG_0_.step == 2 and Effect.IsAlive(Bullet.GetEffectHandle(_ARG_0_.myHandle)) == false then
    Entity.Out(_ARG_0_.myHandle)
  end
end
EntityFactory:Add("m08ex00b", function(_ARG_0_)
  return (m08ex00b:new())
end)
