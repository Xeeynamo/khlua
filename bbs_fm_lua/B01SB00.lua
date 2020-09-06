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
          _ARG_0_:GotoState("IdlingA")
        end
      end
    },
    IdlingA = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        _ARG_0_.stack:clear()
        print("IdlingA\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        if _ARG_0_.actionTimer <= 0 then
          _ARG_0_:PushMoveState(_UPVALUE0_, true, true)
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          return
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
          return
        end
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE1_ then
          _ARG_0_.stack:push("IdlingA")
          _ARG_0_.stack:push("StaffAttack")
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        else
          _ARG_0_:PushMoveState(_UPVALUE0_, true, true)
          _ARG_0_.stack:push("Idling")
          _ARG_0_.stack:push("Thundaga")
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    IdlingB = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.stack:clear()
        _ARG_0_.step = 0
        print("IdlingB\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        if _ARG_0_.actionTimer <= 0 then
          _ARG_0_:PushMoveState(_UPVALUE0_, true, true)
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          return
        end
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE1_ then
          _ARG_0_:PushMoveState(_UPVALUE2_, false, false)
          _ARG_0_.stack:push("StaffAttack")
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) >= _UPVALUE1_ and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE3_ then
          _ARG_0_.stack:push("CheckCharmFlashSuccess")
          if Script.Random() < 0.4 then
            _ARG_0_.stack:push("SoldierSummons")
          elseif Script.Random() >= 0.4 and Script.Random() < 0.7 then
            _ARG_0_.warpPosUpdate = true
            _ARG_0_.count = _UPVALUE4_
            _ARG_0_.stack:push("StaffAttack")
            _ARG_0_.stack:push("Teleport")
          else
            _ARG_0_.count = _UPVALUE5_
            _ARG_0_.stack:push("Thunder")
          end
          _ARG_0_.stack:push("CharmFlash")
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        elseif _ARG_0_.step == 0 then
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE6_)
          _ARG_0_.step = 1
        elseif Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:PushMoveState(_UPVALUE7_, false, true)
          _ARG_0_.stack:push("Meteor")
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    IdlingC = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.stack:clear()
        _ARG_0_.step = 0
        print("IdlingC\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        if _ARG_0_.actionTimer <= 0 then
          _ARG_0_:PushMoveState(_UPVALUE0_, true, true)
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          return
        end
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE1_ then
          _ARG_0_.stack:push("IdlingC")
          _ARG_0_.stack:push("StaffAttack")
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) >= _UPVALUE1_ and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE2_ then
          _ARG_0_.count = _UPVALUE3_
          _ARG_0_.stack:push("IdlingC")
          _ARG_0_.stack:push("Idling")
          _ARG_0_.stack:push("Thunder")
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        elseif _ARG_0_.step == 0 then
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE4_)
          _ARG_0_.step = 1
        elseif Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:PushMoveState(_UPVALUE0_, false, true)
          _ARG_0_.stack:push("Meteor")
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Idling = {
      OnBeginState = function(_ARG_0_)
        if Script.Random() < 0.5 then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
          _ARG_0_.step = 0
        else
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
          _ARG_0_.step = 1
        end
        print("Idling\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    CheckCharmFlashSuccess = {
      OnBeginState = function(_ARG_0_)
        print("CheckCharmFlashSuccess\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.charmFlashSuccess then
          _ARG_0_:PushMoveState(_UPVALUE0_, true, true)
        else
          Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.myHandle)
          if _ARG_0_.workVec0:dot(_ARG_0_.workVec0) < 1 then
            _ARG_0_.stack:push("IdlingB")
          else
            _ARG_0_:PushMoveState(_UPVALUE1_, false, false)
          end
        end
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      end
    },
    Move = {
      OnBeginState = function(_ARG_0_)
        print("Move\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:Move(_ARG_0_.warpPointTable, _ARG_0_.checkHP, _ARG_0_.enableTimer)
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      end
    },
    Teleport = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        _ARG_0_.step = 0
        print("Teleport\n")
      end,
      OnEndState = function(_ARG_0_)
        _ARG_0_.warpPosUpdate = false
        if _ARG_0_.isSetActionTimer then
          _ARG_0_.actionTimer = _UPVALUE0_
          _ARG_0_.isSetActionTimer = false
        end
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 35 then
            Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 50)
            Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
            Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
            Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_.workVec0:copy(_ARG_0_.warpPos)
            _ARG_0_.workVec1:copy(_ARG_0_.warpPos)
            _ARG_0_.workVec0:sety(_ARG_0_.workVec0:gety() + 0.1)
            _ARG_0_.workVec1:sety(_ARG_0_.workVec1:gety() + 10)
            if Collision.IntersectRayBg(_ARG_0_.workVec1, COLL_KIND_ENEMY, _ARG_0_.workVec0, _ARG_0_.workVec1) == true then
              _ARG_0_.warpPos:copy(_ARG_0_.workVec1)
            end
            Entity.SetLocalPos(_ARG_0_.myHandle, _ARG_0_.warpPos)
            Entity.SetOldLocalPos(_ARG_0_.myHandle, _ARG_0_.warpPos)
            Entity.SetTimer(_ARG_0_.myHandle, 10)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_.rot:set(0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle), 0)
            Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, 10)
            _ARG_0_.step = 3
          end
        elseif _ARG_0_.step == 3 then
          if Entity.IsModelFade(_ARG_0_.myHandle) == false then
            Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
            Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
            _ARG_0_.step = 4
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    StaffAttack = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        print("StaffAttack\n")
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
        _ARG_0_.count = 1
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.count = _ARG_0_.count - 1
          if _ARG_0_.count > 0 and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE0_ then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
            _ARG_0_.step = 0
            return
          end
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Thunder = {
      OnBeginState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.step = 0
        print("Thunder\n")
      end,
      OnEndState = function(_ARG_0_)
        _ARG_0_.count = 1
        Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 0)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 70 then
            Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
            Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.myHandle, 10)
            Entity.GetWorldPos(_ARG_0_.workVec1, _ARG_0_.targetHandle)
            FVECTOR3.Sub(_ARG_0_.workVec2, _ARG_0_.workVec1, _ARG_0_.workVec0)
            if _ARG_0_.workVec2:dot(_ARG_0_.workVec2) > _UPVALUE0_ * _UPVALUE0_ then
              _ARG_0_.workVec2:normalize()
              _ARG_0_.workVec2:scale(_UPVALUE0_)
              FVECTOR3.Add(_ARG_0_.workVec1, _ARG_0_.workVec0, _ARG_0_.workVec2)
            end
            Collision.IntersectRayBg(_ARG_0_.workVec1, COLL_KIND_ENEMY, _ARG_0_.workVec0, _ARG_0_.workVec1)
            _ARG_0_.workVec2:copy(_ARG_0_.workVec1)
            _ARG_0_.workVec2:sety(_ARG_0_.workVec2:gety() - 10)
            _ARG_0_.workVec1:sety(_ARG_0_.workVec1:gety() + 0.5)
            Collision.IntersectRayBg(_ARG_0_.workVec1, COLL_KIND_ENEMY, _ARG_0_.workVec1, _ARG_0_.workVec2)
            FVECTOR3.Sub(_ARG_0_.workVec2, _ARG_0_.workVec1, _ARG_0_.workVec0)
            _ARG_0_.workVec3:set(1, 1, _ARG_0_.workVec2:length() / 10)
            _ARG_0_.workVec4:set(-Math.Atan2(_ARG_0_.workVec2:gety(), Math.Sqrt(_ARG_0_.workVec2:getx() * _ARG_0_.workVec2:getx() + _ARG_0_.workVec2:getz() * _ARG_0_.workVec2:getz())), Math.Atan2(_ARG_0_.workVec2:getx(), _ARG_0_.workVec2:getz()), 0)
            _ARG_0_.effHandle = Entity.SetEffect(_ARG_0_.myHandle, "b01sb00", "b005_tnd_00_0", _ARG_0_.workVec0, _ARG_0_.workVec4)
            Effect.SetScale(_ARG_0_.effHandle, _ARG_0_.workVec3)
            Enemy.SetGeneralPurposeAttackColl(_ARG_0_.myHandle, COLL_KIND_ENEMY, COLL_SHAPE_CYLINDER, 0.3)
            Enemy.SetGeneralPurposeAttackCollParam(_ARG_0_.myHandle, Enemy.GetAttackKind(_ARG_0_.myHandle, 1), Enemy.GetAttackAttr(_ARG_0_.myHandle, 1), Enemy.GetAttackPoint(_ARG_0_.myHandle, 1), Enemy.GetAttackPowerCorrection(_ARG_0_.myHandle, 1))
            Enemy.SetGeneralPurposeAttackCollHitAttackEffectName(_ARG_0_.myHandle, "b01sb00", "b005_tnd_01_0")
            Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 0)
            _ARG_0_.step = 1
            _ARG_0_.step2 = 0
          end
        else
          if Effect.IsAlive(_ARG_0_.effHandle) and Effect.GetNowFrame(_ARG_0_.effHandle) < 30 then
            Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.myHandle, 10)
            FVECTOR3.Sub(_ARG_0_.workVec2, _ARG_0_.workVec1, _ARG_0_.workVec0)
            _ARG_0_.workVec3:set(1, 1, _ARG_0_.workVec2:length() / 10)
            Effect.SetScale(_ARG_0_.effHandle, _ARG_0_.workVec3)
            _ARG_0_.workVec4:set(-Math.Atan2(_ARG_0_.workVec2:gety(), Math.Sqrt(_ARG_0_.workVec2:getx() * _ARG_0_.workVec2:getx() + _ARG_0_.workVec2:getz() * _ARG_0_.workVec2:getz())), Math.Atan2(_ARG_0_.workVec2:getx(), _ARG_0_.workVec2:getz()), 0)
            Effect.UpdateCoord(_ARG_0_.effHandle, _ARG_0_.workVec0, _ARG_0_.workVec4)
            Enemy.SetGeneralPurposeAttackCollPos(_ARG_0_.myHandle, _ARG_0_.workVec0, _ARG_0_.workVec1)
          end
          if Effect.GetNowFrame(_ARG_0_.effHandle) >= 4 and Effect.GetNowFrame(_ARG_0_.effHandle) < 30 then
            Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 1)
            if _ARG_0_.step2 == 0 then
              _ARG_0_.workVec4:set(0, 0, 0)
              Entity.SetEffect(_ARG_0_.myHandle, "b01sb00", "B005_TND_02_0", _ARG_0_.workVec1, _ARG_0_.workVec4)
              _ARG_0_.step2 = 1
            end
          else
            Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 0)
          end
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.count = _ARG_0_.count - 1
          if 0 < _ARG_0_.count and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE1_ then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_, 0, -1, 1)
            _ARG_0_.step = 0
            return
          end
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Thundaga = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        _ARG_0_.step = 0
        print("Thundaga\n")
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 95 then
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
            Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
            _ARG_0_:SetTimer(0)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if _ARG_0_:IsTimeOver() then
            Entity.GetWorldPos(_ARG_0_.workVec2, _ARG_0_.myHandle)
            while true do
              if Script.Random() > 0.2 then
                Camera.GetPlayerCameraDir(_ARG_0_.workVec3)
                _ARG_0_.workVec3:sety((RoundPI(_ARG_0_.workVec3:gety() + (Script.Random() - Script.Random()) * PI * 0.5)))
                _ARG_0_.workVec0:set(0, 0, Script.Random() * 7.5)
                Math.RotateVectorXYZ(_ARG_0_.workVec0, _ARG_0_.workVec3)
                Entity.GetWorldPos(_ARG_0_.workVec3, _ARG_0_.targetHandle)
                FVECTOR3.Add(_ARG_0_.workVec0, _ARG_0_.workVec0, _ARG_0_.workVec3)
              else
                Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.targetHandle)
                Entity.GetVelocity(_ARG_0_.workVec3, _ARG_0_.targetHandle)
                _ARG_0_.workVec3:scale(42)
                FVECTOR3.Add(_ARG_0_.workVec0, _ARG_0_.workVec0, _ARG_0_.workVec3)
                _ARG_0_.workVec3:setx(Script.Random() * 1.5 * Math.Cos((RoundPI(DegToRad(Script.Random() * 360)))))
                _ARG_0_.workVec3:sety(0)
                _ARG_0_.workVec3:setz(Script.Random() * 1.5 * Math.Sin((RoundPI(DegToRad(Script.Random() * 360)))))
                FVECTOR3.Add(_ARG_0_.workVec0, _ARG_0_.workVec0, _ARG_0_.workVec3)
              end
              FVECTOR3.Sub(_ARG_0_.workVec3, _ARG_0_.workVec2, _ARG_0_.workVec0)
              if _ARG_0_.workVec3:dot(_ARG_0_.workVec3) > 4 then
                _ARG_0_.workVec1:copy(_ARG_0_.workVec0)
                _ARG_0_.workVec0:sety(_ARG_0_.workVec0:gety() + 10)
                _ARG_0_.workVec1:sety(_ARG_0_.workVec1:gety() - 10)
                if Collision.IntersectRayBg(_ARG_0_.workVec0, COLL_KIND_ENEMY, _ARG_0_.workVec0, _ARG_0_.workVec1) == true then
                  _ARG_0_.workVec1:set(0, 0, 0)
                  Bullet.SetCollision(Bullet.CreateBullet("Thundaga", _ARG_0_.workVec0, _ARG_0_.workVec1), COLL_KIND_ENEMY, COLL_SHAPE_CYLINDER, 0.25, 8, _ARG_0_.myHandle)
                  Bullet.EnableAttackCollision(Bullet.CreateBullet("Thundaga", _ARG_0_.workVec0, _ARG_0_.workVec1), 0)
                  SetBulletAttackParam(Bullet.CreateBullet("Thundaga", _ARG_0_.workVec0, _ARG_0_.workVec1), _ARG_0_.myHandle, 2)
                  _ARG_0_:SetTimer(_UPVALUE2_)
                  if 0 >= _UPVALUE1_ - 1 then
                    break
                  end
                end
              end
            end
          end
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
            _ARG_0_.step = 2
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Meteor = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 0, -2)
        _ARG_0_:SetTimer(0)
        _ARG_0_.timer2 = 60
        _ARG_0_.step = 0
        _ARG_0_.step2 = 0
        print("Meteor\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 10)
            _ARG_0_.workVec0:set(1, 0, 0)
            _ARG_0_.workVec1:set(0, 0, PI * 0.5)
            _ARG_0_.effHandle = Entity.AttachEffect(_ARG_0_.myHandle, "b01sb00", "b005_mto_00_0", "hara", _ARG_0_.workVec0, _ARG_0_.workVec1)
            Effect.SetAttachNoRot(_ARG_0_.effHandle, true)
            Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
            Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
            Entity.SetMovementCollRadius(_ARG_0_.myHandle, 2)
            Entity.SetLowerHalf(_ARG_0_.myHandle, 2.5)
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
            Entity.EnableGravity(_ARG_0_.myHandle, 0)
            Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle, 2)
            Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          _ARG_0_.timer2 = _ARG_0_.timer2 - Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 > _ARG_0_.timer2 then
            Entity.AACUpdateAttackID(_ARG_0_.myHandle)
            _ARG_0_.timer2 = 60
          end
          if _ARG_0_:IsTimeOver() then
            Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle, 2)
            _ARG_0_.targetPos:setx(_ARG_0_.targetPos:getx() + Script.Random() * 7.5 * Math.Cos((Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle))))
            _ARG_0_.targetPos:sety(_ARG_0_.targetPos:gety() + (Script.Random() - Script.Random()) * 0.75)
            _ARG_0_.targetPos:setz(_ARG_0_.targetPos:getz() + Script.Random() * 7.5 * Math.Sin((Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle))))
            _ARG_0_:SetTimer(_UPVALUE2_)
          end
          Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.myHandle)
          FVECTOR3.Sub(_ARG_0_.workVec1, _ARG_0_.targetPos, _ARG_0_.workVec0)
          if 0 < _ARG_0_.workVec1:length() then
            _ARG_0_.workVec1:scale(_UPVALUE3_ / _ARG_0_.workVec1:length())
            Entity.GetVelocity(_ARG_0_.workVec0, _ARG_0_.myHandle)
            FVECTOR3.Sub(_ARG_0_.workVec1, _ARG_0_.workVec1, _ARG_0_.workVec0)
          else
            _ARG_0_.workVec1:set(0, 0, 0)
          end
          _ARG_0_.workVec1:scale(_UPVALUE4_)
          if _ARG_0_.workVec1:length() > _UPVALUE5_ then
            _ARG_0_.workVec1:normalize()
            _ARG_0_.workVec1:scale(_UPVALUE5_)
          end
          FVECTOR3.Add(_ARG_0_.workVec1, _ARG_0_.workVec1, _ARG_0_.workVec0)
          if _ARG_0_.workVec1:length() > _UPVALUE3_ then
            _ARG_0_.workVec1:normalize()
            _ARG_0_.workVec1:scale(_UPVALUE3_)
          end
          Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.workVec1)
          Entity.SetRot(_ARG_0_.myHandle, 0, Math.Atan2(_ARG_0_.workVec1:getx(), _ARG_0_.workVec1:getz()), 0)
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_.workVec0:set(0, -_UPVALUE3_, 0)
            Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.workVec0)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if Entity.IsGround(_ARG_0_.myHandle) then
            Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, 10)
            _ARG_0_.rot:set(0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle), 0)
            Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
            Effect.LoopEnd(_ARG_0_.effHandle)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE6_)
            Entity.SetMovementCollRadius(_ARG_0_.myHandle, 0.5)
            Entity.SetLowerHalf(_ARG_0_.myHandle, 0.75)
            Entity.EnableGravity(_ARG_0_.myHandle, 1)
            _ARG_0_.step = 3
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    CharmFlash = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        _ARG_0_.step = 0
        _ARG_0_.step2 = 0
        _ARG_0_.bulletFireCount = 0
        _ARG_0_:SetTimer(0)
        for _FORV_4_ = 1, _UPVALUE1_ do
          _ARG_0_.charmFlash[_FORV_4_] = NULL_HANDLE
        end
        _ARG_0_.count = 1
        _ARG_0_.stop = false
        _ARG_0_.charmFlashSuccess = false
        if EntityManager:GetEntity(_ARG_0_.fairy) ~= nil then
          EntityManager:GetEntity(_ARG_0_.fairy):SetupBarrier()
        end
        print("CharmFlash\n")
      end,
      OnEndState = function(_ARG_0_)
        if EntityManager:GetEntity(_ARG_0_.fairy) ~= nil then
          EntityManager:GetEntity(_ARG_0_.fairy):EndBarrier()
        end
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step ~= 0 then
          _ARG_0_:CharmFlashHomingBullet()
        end
        if _ARG_0_.step == 0 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 110 then
            _ARG_0_.charmFlash[_ARG_0_.count] = _ARG_0_:CreateCharmFlash()
            _ARG_0_.count = _ARG_0_.count + 1
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if _ARG_0_.stop == false and _ARG_0_.charmFlashSuccess then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
            _ARG_0_.step = 2
            return
          end
          if _ARG_0_.count > _UPVALUE2_ then
            if _ARG_0_.stop == false and _ARG_0_:IsAliveCharmFlash() then
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
              _ARG_0_.step = 2
            end
          elseif Entity.IsTimeOver(_ARG_0_.myHandle) and _ARG_0_.stop == false then
            _ARG_0_.charmFlash[_ARG_0_.count] = _ARG_0_:CreateCharmFlash()
            _ARG_0_.count = _ARG_0_.count + 1
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
          end
        elseif _ARG_0_.step == 2 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    SoldierSummons = {
      OnBeginState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.step = 0
        print("SoldierSummons\n")
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 45 then
          for _FORV_4_, _FORV_5_ in pairs(_ARG_0_.soilder) do
            if Entity.IsAlive(_FORV_5_) == false then
              _ARG_0_.workVec0:setx(Script.Random() * 10 * Math.Cos((RoundPI(DegToRad(Script.Random() * 360)))))
              _ARG_0_.workVec0:sety(0)
              _ARG_0_.workVec0:setz(Script.Random() * 10 * Math.Sin((RoundPI(DegToRad(Script.Random() * 360)))))
              _ARG_0_.workVec1:set(0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle), 0)
              if Script.Random() < 0.5 then
                _ARG_0_.soilder[_FORV_4_] = Entity.CreateEntity("m01sb00", _ARG_0_.workVec0, _ARG_0_.workVec1)
              else
                _ARG_0_.soilder[_FORV_4_] = Entity.CreateEntity("m02sb00", _ARG_0_.workVec0, _ARG_0_.workVec1)
              end
              Enemy.EnableNoGetExp(_ARG_0_.soilder[_FORV_4_], 1)
              if EntityManager:GetEntity(_ARG_0_.soilder[_FORV_4_]) ~= nil then
                EntityManager:GetEntity(_ARG_0_.soilder[_FORV_4_]):GotoState("Summons")
              end
            end
          end
          _ARG_0_.step = 1
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Sleep = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 1)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        _ARG_0_.step = 0
        Enemy.SetFaceAnim(_ARG_0_.myHandle, 2, 1)
        print("Sleep\n")
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Enemy.SetFaceAnim(_ARG_0_.myHandle, 3, 2)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            _ARG_0_.step = 1
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("IdlingA")
        end
      end
    },
    Dead = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_.step = 0
        print("Dead\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 and Sound.IsInvalidateSeCall() == 1 then
          Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 2)
          Sound.PlayVoice(114, 5, 1, _UPVALUE0_, SE_OPT_ALWAYS)
          _ARG_0_.step = 1
        end
      end
    }
  },
  PushMoveState = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    _ARG_0_.warpPointTable = _ARG_1_
    _ARG_0_.checkHP = _ARG_2_
    _ARG_0_.enableTimer = _ARG_3_
    _ARG_0_.stack:push("Move")
  end,
  Move = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    while 6 > 0 do
      _ARG_0_.wp1 = _ARG_1_[Script.RandomInteger(2) + 1]
      _ARG_0_.wp2 = Script.RandomInteger(3) + 1
      _ARG_0_.warpPos:set(_UPVALUE0_[_ARG_0_.wp1][_ARG_0_.wp2].x, _UPVALUE0_[_ARG_0_.wp1][_ARG_0_.wp2].y, _UPVALUE0_[_ARG_0_.wp1][_ARG_0_.wp2].z)
      if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.warpPos) > 56.25 then
        break
      end
    end
    if _ARG_0_.wp1 == 1 then
      _ARG_0_.stack:push("IdlingA")
    elseif _ARG_0_.wp1 == 2 then
      _ARG_0_.stack:push("IdlingB")
    else
      _ARG_0_.stack:push("IdlingC")
    end
    if _ARG_2_ == true then
      _ARG_0_.stack:push("Teleport")
      if _ARG_0_:RestHpRate() < 0.4 and Script.Random() <= 0.6 then
        _ARG_0_.stack:push("Meteor")
      end
    else
      _ARG_0_.stack:push("Teleport")
    end
    _ARG_0_.isSetActionTimer = _ARG_3_
  end,
  RestHpRate = function(_ARG_0_)
    return Enemy.GetHp(_ARG_0_.myHandle) / Enemy.GetHpMax(_ARG_0_.myHandle)
  end,
  SetTimer = function(_ARG_0_, _ARG_1_)
    _ARG_0_.timer = _ARG_1_
  end,
  IsTimeOver = function(_ARG_0_)
    if _ARG_0_.timer <= 0 then
      return true
    end
    return false
  end,
  CreateCharmFlash = function(_ARG_0_)
    Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.myHandle)
    _ARG_0_.workVec1:set(0, 0, 0)
    if EntityManager:GetEntity((Bullet.CreateBullet("CharmFlash", _ARG_0_.workVec0, _ARG_0_.workVec1))) ~= nil then
      EntityManager:GetEntity((Bullet.CreateBullet("CharmFlash", _ARG_0_.workVec0, _ARG_0_.workVec1))).owner = _ARG_0_.myHandle
    end
    SetBulletAttackParam(Bullet.CreateBullet("CharmFlash", _ARG_0_.workVec0, _ARG_0_.workVec1), _ARG_0_.myHandle, 4)
    return (Bullet.CreateBullet("CharmFlash", _ARG_0_.workVec0, _ARG_0_.workVec1))
  end,
  IsAliveCharmFlash = function(_ARG_0_)
    for _FORV_4_, _FORV_5_ in pairs(_ARG_0_.charmFlash) do
      if Entity.IsAlive(_FORV_5_) then
        return false
      end
    end
    return true
  end,
  CharmFlashHomingBullet = function(_ARG_0_)
    if _ARG_0_.step2 == 0 then
      Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.targetHandle)
      if _ARG_0_.workVec0:dot(_ARG_0_.workVec0) > 210.25 then
        Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle, 5)
        _ARG_0_.step2 = 1
      end
    elseif _ARG_0_.step2 == 1 then
      if _ARG_0_:IsTimeOver() then
        _ARG_0_.workVec0:copy(_ARG_0_.targetPos)
        _ARG_0_.workVec0:setx(5 * Math.Cos((RoundPI(DegToRad(_ARG_0_.bulletFireCount * 120)))) + _ARG_0_.workVec0:getx())
        _ARG_0_.workVec0:setz(5 * Math.Sin((RoundPI(DegToRad(_ARG_0_.bulletFireCount * 120)))) + _ARG_0_.workVec0:getz())
        if Collision.IntersectRayBg(_ARG_0_.workVec0, COLL_KIND_ENEMY, _ARG_0_.targetPos, _ARG_0_.workVec0) then
          FVECTOR3.Sub(_ARG_0_.workVec2, _ARG_0_.workVec0, _ARG_0_.targetPos)
          _ARG_0_.workVec2:normalize()
          _ARG_0_.workVec2:scale(_ARG_0_.workVec2:length() - 1)
          FVECTOR3.Add(_ARG_0_.workVec0, _ARG_0_.targetPos, _ARG_0_.workVec2)
        end
        _ARG_0_.workVec1:set(0, RoundPI(RoundPI(DegToRad(_ARG_0_.bulletFireCount * 120)) + PI), 0)
        if EntityManager:GetEntity((Bullet.CreateBullet("CFBullet", _ARG_0_.workVec0, _ARG_0_.workVec1))) ~= nil then
          EntityManager:GetEntity((Bullet.CreateBullet("CFBullet", _ARG_0_.workVec0, _ARG_0_.workVec1))).targetHandle = _ARG_0_.targetHandle
        end
        SetBulletAttackParam(Bullet.CreateBullet("CFBullet", _ARG_0_.workVec0, _ARG_0_.workVec1), _ARG_0_.myHandle, 5)
        _ARG_0_:SetTimer(30)
        _ARG_0_.bulletFireCount = _ARG_0_.bulletFireCount + 1
        if _ARG_0_.bulletFireCount >= 3 then
          _ARG_0_.step2 = 2
          _ARG_0_.bulletFireCount = 0
          _ARG_0_:SetTimer(_UPVALUE0_)
        end
      end
    elseif _ARG_0_:IsTimeOver() then
      _ARG_0_.step2 = 0
    end
  end,
  ChangeWarpState = function(_ARG_0_)
    for _FORV_5_, _FORV_6_ in pairs(_UPVALUE0_) do
      _ARG_0_.workVec0:set(_FORV_6_.x, _FORV_6_.y, _FORV_6_.z)
      if 0 < Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.workVec0) then
        _ARG_0_.warpPos:copy(_ARG_0_.workVec0)
      end
    end
    _ARG_0_:GotoState("Teleport")
  end,
  PlayVoice = function(_ARG_0_, _ARG_1_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
    Sound.SetPosition(Sound.PlayVoice(114, _ARG_1_), _UPVALUE0_)
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    _UPVALUE0_ = Entity.GetMotionIndex(_ARG_1_, "001")
    _UPVALUE1_ = Entity.GetMotionIndex(_ARG_1_, "010")
    _UPVALUE2_ = Entity.GetMotionIndex(_ARG_1_, "030")
    _UPVALUE3_ = Entity.GetMotionIndex(_ARG_1_, "040")
    _UPVALUE4_ = Entity.GetMotionIndex(_ARG_1_, "070")
    _UPVALUE5_ = Entity.GetMotionIndex(_ARG_1_, "071")
    _UPVALUE6_ = Entity.GetMotionIndex(_ARG_1_, "232")
    _UPVALUE7_ = Entity.GetMotionIndex(_ARG_1_, "233")
    _UPVALUE8_ = Entity.GetMotionIndex(_ARG_1_, "300")
    _UPVALUE9_ = Entity.GetMotionIndex(_ARG_1_, "310")
    _UPVALUE10_ = Entity.GetMotionIndex(_ARG_1_, "320")
    _UPVALUE11_ = Entity.GetMotionIndex(_ARG_1_, "321")
    _UPVALUE12_ = Entity.GetMotionIndex(_ARG_1_, "330")
    _UPVALUE13_ = Entity.GetMotionIndex(_ARG_1_, "331")
    _UPVALUE14_ = Entity.GetMotionIndex(_ARG_1_, "340")
    _UPVALUE15_ = Entity.GetMotionIndex(_ARG_1_, "341")
    _UPVALUE16_ = Entity.GetMotionIndex(_ARG_1_, "350")
    _UPVALUE17_ = Enemy.GetExtraParam(_ARG_1_, "ActionTime") * 60
    _UPVALUE18_ = Enemy.GetExtraParam(_ARG_1_, "SleepTime") * 60
    _UPVALUE19_ = Enemy.GetExtraParam(_ARG_1_, "MeteorSpd")
    _UPVALUE20_ = Enemy.GetExtraParam(_ARG_1_, "MeteorTime") * 60
    _UPVALUE21_ = Enemy.GetExtraParam(_ARG_1_, "CFSpd")
    _UPVALUE22_ = 13 / _UPVALUE21_
    _UPVALUE23_ = _UPVALUE21_ / 5
    _UPVALUE24_ = Enemy.GetExtraParam(_ARG_1_, "CFBSpd")
    _UPVALUE25_ = Enemy.GetExtraParam(_ARG_1_, "CFBHoming")
    _UPVALUE26_ = Enemy.GetExtraParam(_ARG_1_, "CFBNextTime") * 60
    _UPVALUE27_ = Enemy.GetExtraParam(_ARG_1_, "CFBHomTime") * 60
    _UPVALUE28_ = Enemy.GetExtraParam(_ARG_1_, "StaffAtkCnt")
    _UPVALUE29_ = Enemy.GetExtraParam(_ARG_1_, "ThunderCnt")
    _UPVALUE30_ = Enemy.GetExtraParam(_ARG_1_, "ThunderRan")
    _UPVALUE31_ = Enemy.GetExtraParam(_ARG_1_, "ThdTime") * 60
    _UPVALUE32_ = Enemy.GetExtraParam(_ARG_1_, "ThdSTime") * 60
    _UPVALUE33_ = Enemy.GetExtraParam(_ARG_1_, "ThdInterval") * 60
    _UPVALUE34_ = Enemy.GetExtraParam(_ARG_1_, "ThdCount")
    _UPVALUE35_ = Enemy.GetExtraParam(_ARG_1_, "CFInterval") * 60
    _UPVALUE36_ = Enemy.GetExtraParam(_ARG_1_, "CFNum")
    _UPVALUE37_ = Enemy.GetExtraParam(_ARG_1_, "DmgCount")
    _UPVALUE38_ = Enemy.GetExtraParam(_ARG_1_, "ButtonDist")
    _UPVALUE38_ = _UPVALUE38_ * _UPVALUE38_
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.targetHandle = NULL_HANDLE
    _ARG_0_.warpPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
    _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
    _ARG_0_.workVec0 = FVECTOR3.new(0, 0, 0)
    _ARG_0_.workVec1 = FVECTOR3.new(0, 0, 0)
    _ARG_0_.workVec2 = FVECTOR3.new(0, 0, 0)
    _ARG_0_.workVec3 = FVECTOR3.new(0, 0, 0)
    _ARG_0_.workVec4 = FVECTOR3.new(0, 0, 0)
    _ARG_0_.cameraTargetPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.timer = 0
    _ARG_0_.timer2 = 0
    _ARG_0_.timer3 = 0
    _ARG_0_.actionTimer = _UPVALUE17_
    _ARG_0_.isSetActionTimer = false
    _ARG_0_.step = 0
    _ARG_0_.step2 = 0
    _ARG_0_.wp1 = 1
    _ARG_0_.wp2 = 1
    _ARG_0_.effHandle = NULL_HANDLE
    _ARG_0_.warpPosUpdate = false
    _ARG_0_.charmFlashSuccess = false
    _ARG_0_.count = 1
    _ARG_0_.dmgCount = 0
    _ARG_0_.bulletFireCount = 0
    _ARG_0_.soilder = {
      NULL_HANDLE,
      NULL_HANDLE,
      NULL_HANDLE
    }
    _ARG_0_.stop = false
    _ARG_0_.warpPointTable = nil
    _ARG_0_.checkHP = false
    _ARG_0_.enableTimer = false
    _ARG_0_.stack = Stack:Create()
    _ARG_0_.charmFlash = {}
    for _FORV_5_ = 1, _UPVALUE36_ do
      _ARG_0_.charmFlash[_FORV_5_] = NULL_HANDLE
    end
    _FOR_.EnableGravity(_ARG_1_, 1)
    Player.SetBossCamera("b01sb")
    _ARG_0_.workVec0:sety(1)
    _ARG_0_.fairy = Bullet.CreateBullet("fairy", _ARG_0_.workVec0, _ARG_0_.workVec1)
    if EntityManager:GetEntity(_ARG_0_.fairy) ~= nil then
      EntityManager:GetEntity(_ARG_0_.fairy).maleficent = _ARG_1_
    end
    _ARG_0_:GotoState("Appear")
  end,
  OnReturnDamage = function(_ARG_0_)
    if _ARG_0_:GetState() ~= nil and _ARG_0_:GetState() ~= "CharmFlash" then
      _ARG_0_:GotoState((_ARG_0_:GetState()))
    else
      _ARG_0_:GotoState("IdlingA")
    end
  end,
  OnHitAttack = function(_ARG_0_)
  end,
  OnDamage = function(_ARG_0_, _ARG_1_, _ARG_2_)
    if Entity.GetDamageCommandKind(_ARG_0_.myHandle) == COMMAND_KIND_FairyMagic and _ARG_1_ == ATK_KIND_SLEEP then
      _ARG_0_:GotoState("Sleep")
      return 1
    end
    if Enemy.IsNoDamageReaction(_ARG_0_.myHandle) == false then
      Entity.ClearSpeed(_ARG_0_.myHandle)
      Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.myHandle)
      if 1 < _ARG_0_.workVec0:gety() then
        if _ARG_0_.stack:getn() <= 0 then
          if _ARG_0_:GetState() ~= nil then
            _ARG_0_.stack:push((_ARG_0_:GetState()))
          else
            _ARG_0_.stack:push("IdlingA")
          end
        end
        _ARG_0_:ChangeWarpState()
        Enemy.SetFaceAnim(_ARG_0_.myHandle, 3, 2)
        return 1
      else
        _ARG_0_.dmgCount = _ARG_0_.dmgCount + 1
        if _ARG_0_.dmgCount >= _UPVALUE0_ then
          _ARG_0_.dmgCount = 0
          if _ARG_0_.stack:getn() <= 0 then
            if _ARG_0_:GetState() ~= nil then
              _ARG_0_.stack:push((_ARG_0_:GetState()))
            else
              _ARG_0_.stack:push("IdlingA")
            end
          end
          if _ARG_0_.stack:isExist("CharmFlash") then
            _ARG_0_:GotoState("StaffAttack")
          elseif Script.Random() < 0.5 then
            _ARG_0_:ChangeWarpState()
          else
            _ARG_0_:GotoState("StaffAttack")
          end
          Enemy.SetFaceAnim(_ARG_0_.myHandle, 3, 2)
          return 1
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
    if _ARG_0_.warpPosUpdate then
      Entity.GetWorldPos(_ARG_0_.warpPos, _ARG_0_.targetHandle)
    end
    _ARG_0_:Update()
    _ARG_0_:Debug()
    if _ARG_0_.actionTimer > 0 then
      _ARG_0_.actionTimer = _ARG_0_.actionTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
    end
    if 0 < _ARG_0_.timer then
      _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
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
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        _ARG_0_.stack:push("IdlingA")
        _ARG_0_:GotoState(_UPVALUE0_[Script.GetDebugAttackNumber() + 1])
      end
    end
  end
}, {__index = __StateMachine})
EntityFactory:Add("b01sb00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("Thundaga", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("CharmFlash", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("CFBullet", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
setmetatable({
  new = function(_ARG_0_)
    return setmetatable({}, _UPVALUE0_)
  end,
  states = {
    Wander = {
      OnBeginState = function(_ARG_0_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:RotateFairy()
        if Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) <= 1 then
          _ARG_0_.targetPos:setx(Math.Cos((RoundPI(DegToRad(Script.Random() * 360)))) * (Script.Random() * 13))
          _ARG_0_.targetPos:setz(Math.Sin((RoundPI(DegToRad(Script.Random() * 360)))) * (Script.Random() * 13))
          _ARG_0_.targetPos:sety(7.5 + (Script.Random() - Script.Random()) * 2.5)
          Entity.SetTimer(_ARG_0_.myHandle, 300)
        end
        Entity.TurnTargetDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 5)
        Entity.CalcVelocity(_ARG_0_.myHandle, 0.075)
      end
    },
    BeginBarrier = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_.workVec0:setx(9 * Math.Cos((RoundPI(DegToRad(Script.Random() * 360)))))
        _ARG_0_.workVec0:sety(3)
        _ARG_0_.workVec0:setz(9 * Math.Sin((RoundPI(DegToRad(Script.Random() * 360)))))
        Entity.SetupMovement(_ARG_0_.myHandle, 4, _ARG_0_.workVec0, 0.2)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:RotateFairy()
        if Entity.IsArraivalInterpolate(_ARG_0_.myHandle) then
          Entity.ClearSpeed(_ARG_0_.myHandle)
          Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.myHandle)
          _ARG_0_.workVec1:copy(_ARG_0_.workVec0)
          _ARG_0_.workVec1:sety(_ARG_0_.workVec1:gety() - 10)
          Collision.IntersectRayBg(_ARG_0_.workVec1, COLL_KIND_PLAYER, _ARG_0_.workVec0, _ARG_0_.workVec1)
          _ARG_0_.workVec0:set(0, 0, 0)
          _ARG_0_.barrierEffect = Entity.SetEffect(_ARG_0_.myHandle, "b01sb00", "B005_WAL_00_0", _ARG_0_.workVec1, _ARG_0_.workVec0)
          _ARG_0_.barrierHandle = Bullet.CreateBullet("Barrier", _ARG_0_.workVec1, _ARG_0_.workVec0)
          Entity.SetupMovement(_ARG_0_.myHandle, 0, _ARG_0_.workVec0, 0)
          _ARG_0_:GotoState("BuildingBarrier")
        end
      end
    },
    BuildingBarrier = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_.step = 0
        Entity.SetTimer(_ARG_0_.myHandle, 120)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 and Entity.IsTimeOver(_ARG_0_.myHandle) then
          Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.myHandle)
          Sound.SetPosition(Sound.PlayVoice(110, Script.RandomInteger(3)), _ARG_0_.workVec0)
          _ARG_0_.step = 1
        end
        _ARG_0_.myRot:setx(HomingDegree(_ARG_0_.myRot:getx(), PI * 0.5, 2.5, Entity.GetFrameRate(_ARG_0_.myHandle)))
        _ARG_0_:RotateYFairy()
        _ARG_0_.targetPlayer = Player.GetNearestPlayer()
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPlayer) < _UPVALUE0_ then
          if Player.NotifyReaction(_ARG_0_.targetPlayer, COMMAND_KIND_FairyMagic, _ARG_0_.maleficent, _ARG_0_.myHandle) then
            _ARG_0_:GotoState("CheckBarrierComplete")
          else
            _ARG_0_:EndBarrier()
          end
        end
      end
    },
    CheckBarrierComplete = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_:StopMaleficent(true)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:RotateYFairy()
        if _ARG_0_:IsCharmFlashSuccess() then
          _ARG_0_:EndBarrier()
          return
        end
        if 0 < Player.CheckReaction(_ARG_0_.targetPlayer, 0) then
          _ARG_0_:GotoState("InputKey")
        elseif Player.CheckReaction(_ARG_0_.targetPlayer, 0) < 0 then
          _ARG_0_:EndBarrier()
        end
      end
    },
    InputKey = {
      OnBeginState = function(_ARG_0_)
        Entity.SetLocalPos(_ARG_0_.targetPlayer, _ARG_0_.workVec1)
        Entity.SetRot(_ARG_0_.targetPlayer, 0, Entity.CalcDirection(_ARG_0_.targetPlayer, _ARG_0_.maleficent), 0)
        Effect.LoopEnd(_ARG_0_.barrierEffect)
        _ARG_0_.workVec0:set(0, 0, 0)
        _ARG_0_.barrierEffect = Entity.SetEffect(_ARG_0_.myHandle, "b01sb00", "B005_WAL_01_0", _ARG_0_.workVec1, _ARG_0_.workVec0)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:RotateYFairy()
        if Player.CheckReaction(_ARG_0_.targetPlayer, 2) > 0 then
          _ARG_0_:GotoState("FairyMagic")
        elseif 0 > Player.CheckReaction(_ARG_0_.targetPlayer, 1) then
          _ARG_0_:EndBarrier()
        end
      end
    },
    FairyMagic = {
      OnBeginState = function(_ARG_0_)
        Entity.EnableDamageColl(_ARG_0_.maleficent, 1)
        if EntityManager:GetEntity(_ARG_0_.maleficent) ~= nil then
          Entity.Out(EntityManager:GetEntity(_ARG_0_.maleficent).charmFlash[1])
          Entity.Out(EntityManager:GetEntity(_ARG_0_.maleficent).charmFlash[2])
          EntityManager:GetEntity(_ARG_0_.maleficent).step = 4
        end
        Entity.Out(_ARG_0_.barrierHandle)
        Effect.Fadeout(_ARG_0_.barrierEffect, 10)
        _ARG_0_.barrierEffect = NULL_HANDLE
        _ARG_0_.workVec0:set(0, 0.1, 0)
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.workVec0)
        Entity.SetTimer(_ARG_0_.myHandle, 20)
        Entity.SetRot(_ARG_0_.targetPlayer, 0, Entity.CalcDirection(_ARG_0_.targetPlayer, _ARG_0_.maleficent), 0)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 and Entity.IsTimeOver(_ARG_0_.myHandle) then
          Entity.ClearSpeed(_ARG_0_.myHandle)
          _ARG_0_.step = 1
        end
      end
    }
  },
  OnInit = function(_ARG_0_, _ARG_1_)
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.maleficent = NULL_HANDLE
    _ARG_0_.step = 0
    _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.myRot = FVECTOR3.new(0, 0, 0)
    _ARG_0_.workVec0 = FVECTOR3.new(0, 0, 0)
    _ARG_0_.workVec1 = FVECTOR3.new(0, 0, 0)
    _ARG_0_.barrierEffect = NULL_HANDLE
    _ARG_0_.barrierHandle = NULL_HANDLE
    _ARG_0_.targetPlayer = NULL_HANDLE
    Entity.SetMovementCollRadius(_ARG_1_, 0.8)
    Entity.SetLowerHalf(_ARG_1_, 0)
    Bullet.CreateEffectBullet(_ARG_1_, "b01sb00", "b005_3fy_0R_0")
    Bullet.SetBodyCollision(_ARG_1_, COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, 0.8, 0, false)
    Bullet.EnableAttackCollision(_ARG_1_, 0)
    Bullet.SetMaxMoveDist(_ARG_1_, 100)
    Effect.SetAttachNoRot(Bullet.GetEffectHandle(_ARG_1_), true)
    _ARG_0_:GotoState("Wander")
  end,
  OnHitAttack = function(_ARG_0_)
  end,
  OnHitBg = function(_ARG_0_)
  end,
  OnUpdate = function(_ARG_0_)
    _ARG_0_.workVec0:set(2, 2, 1)
    Effect.SetScale(Bullet.GetEffectHandle(_ARG_0_.myHandle), _ARG_0_.workVec0)
    _ARG_0_:Update()
  end,
  RotateFairy = function(_ARG_0_)
    _ARG_0_.myRot:setx(RoundPI(_ARG_0_.myRot:getx() + DegToRad(1 * Entity.GetFrameRate(_ARG_0_.myHandle))))
    _ARG_0_.myRot:sety(RoundPI(_ARG_0_.myRot:gety() + DegToRad(1 * Entity.GetFrameRate(_ARG_0_.myHandle))))
    Effect.UpdateCoord(Bullet.GetEffectHandle(_ARG_0_.myHandle), _ARG_0_.myPos, _ARG_0_.myRot)
  end,
  RotateYFairy = function(_ARG_0_)
    _ARG_0_.myRot:sety(RoundPI(_ARG_0_.myRot:gety() + DegToRad(2.5 * Entity.GetFrameRate(_ARG_0_.myHandle))))
    Effect.UpdateCoord(Bullet.GetEffectHandle(_ARG_0_.myHandle), _ARG_0_.myPos, _ARG_0_.myRot)
  end,
  SetupBarrier = function(_ARG_0_)
    _ARG_0_:GotoState("BeginBarrier")
  end,
  EndBarrier = function(_ARG_0_)
    Effect.LoopEnd(_ARG_0_.barrierEffect)
    Entity.Out(_ARG_0_.barrierHandle)
    _ARG_0_.barrierEffect = NULL_HANDLE
    _ARG_0_.barrierHandle = NULL_HANDLE
    _ARG_0_:StopMaleficent(false)
    Player.NotifyReaction(_ARG_0_.targetPlayer, 0)
    _ARG_0_:GotoState("Wander")
  end,
  StopMaleficent = function(_ARG_0_, _ARG_1_)
    if EntityManager:GetEntity(_ARG_0_.maleficent) ~= nil then
      EntityManager:GetEntity(_ARG_0_.maleficent).stop = _ARG_1_
    end
  end,
  IsCharmFlashSuccess = function(_ARG_0_)
    if EntityManager:GetEntity(_ARG_0_.maleficent) ~= nil then
      return EntityManager:GetEntity(_ARG_0_.maleficent).charmFlashSuccess
    end
    return false
  end
}, {__index = __StateMachine})
EntityFactory:Add("fairy", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("Barrier", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
