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
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    Idling = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_.idlingTimer)
        _ARG_0_.stack:clear()
        _ARG_0_.step = 0
        _ARG_0_.rotTimer = 0
        _ARG_0_.defenseTimer = 0
        _ARG_0_.defenseFlag = false
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        _ARG_0_:Turn()
        if _ARG_0_.defenseTimer <= 0 then
          if _ARG_0_.defenseFlag == false then
            if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) and Entity.IsAttacking(_ARG_0_.targetHandle) then
              _ARG_0_.defenseFlag = true
              _ARG_0_.defenseTimer = _UPVALUE0_
            end
          else
            _ARG_0_.idlingTimer = 0
            _ARG_0_.stack:push("Search1")
            if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE1_ then
              if Script.Random() < 0.5 then
                _ARG_0_:GotoState("BackhandsSpringJump")
              else
                _ARG_0_:GotoState("Cartwheel")
              end
            else
              _ARG_0_:GotoState("Cartwheel")
            end
            return
          end
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
          return
        end
        _ARG_0_.idlingTimer = _UPVALUE2_
        if 0 >= _ARG_0_.attackCount then
          _ARG_0_.stack:push("Idling")
          _ARG_0_.stack:push("CloneBurst")
        else
          _ARG_0_.stack:push("Search1")
        end
        if _ARG_0_.cureFlag == true then
          _ARG_0_.cureFlag = false
          _ARG_0_.stack:push("Recover")
        end
        _ARG_0_.attackCount = _ARG_0_.attackCount + 1
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      end
    },
    Search1 = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        _ARG_0_.stack:clear()
        _ARG_0_.rotTimer = 0
        _ARG_0_.search = 1
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:Turn()
        if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) then
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE0_ then
            if Script.Random() < 0.66 then
              if _ARG_0_.oldAttackStateNear ~= "SuccessionAttack" then
                _ARG_0_:GotoState("SuccessionAttack")
              else
                _ARG_0_:GotoState("DisCharge")
              end
            elseif _ARG_0_.oldAttackStateNear ~= "DisCharge_1" then
              _ARG_0_:GotoState("DisCharge")
            else
              _ARG_0_:GotoState("SuccessionAttack")
            end
          else
            _ARG_0_.stack:push("Search2")
            if Script.Random() < 0.75 then
              _ARG_0_.stack:push("TargetMove")
            end
            if Script.Random() < 0.5 then
              if _ARG_0_.oldAttackStateFar1 ~= "DarkFang" then
                _ARG_0_.stack:push("DarkFang")
              elseif Script.Random() < 0.5 then
                if Script.Random() < 0.1 then
                elseif Script.Random() >= 0.1 and Script.Random() < 0.6 then
                elseif Script.Random() >= 0.6 and Script.Random() < 0.85 then
                else
                end
                for _FORV_7_ = 0, 4 do
                  _ARG_0_.stack:push("DarkSplicer1")
                  _ARG_0_.stack:push("DarkSplicer2")
                end
              else
                _ARG_0_.stack:push("ShadowDiving")
              end
            elseif Script.Random() >= 0.5 and Script.Random() < 0.75 then
              if _ARG_0_.oldAttackStateFar1 ~= "DarkSplicer2" then
                if Script.Random() < 0.1 then
                elseif Script.Random() >= 0.1 and Script.Random() < 0.6 then
                elseif Script.Random() >= 0.6 and Script.Random() < 0.85 then
                else
                end
                for _FORV_7_ = 0, 4 do
                  _ARG_0_.stack:push("DarkSplicer1")
                  _ARG_0_.stack:push("DarkSplicer2")
                end
              elseif Script.Random() < 0.66 then
                _ARG_0_.stack:push("DarkFang")
              else
                _ARG_0_.stack:push("ShadowDiving")
              end
            elseif _ARG_0_.oldAttackStateFar1 ~= "ShadowDiving" then
              _ARG_0_.stack:push("ShadowDiving")
            elseif Script.Random() < 0.66 then
              _ARG_0_.stack:push("DarkFang")
            else
              if Script.Random() < 0.1 then
              elseif Script.Random() >= 0.1 and Script.Random() < 0.6 then
              elseif Script.Random() >= 0.6 and Script.Random() < 0.85 then
              else
              end
              for _FORV_7_ = 0, 4 do
                _ARG_0_.stack:push("DarkSplicer1")
                _ARG_0_.stack:push("DarkSplicer2")
              end
            end
            if _ARG_0_.cureFlag == true then
              _ARG_0_.cureFlag = false
              _ARG_0_.stack:push("Recover")
            end
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        elseif Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_.stack:push("Search1")
          _ARG_0_:GotoState("TargetLastRecordedPosMove")
        end
      end
    },
    Search2 = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        _ARG_0_.stack:clear()
        _ARG_0_.rotTimer = 0
        _ARG_0_.search = 2
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:Turn()
        if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) then
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE0_ then
            if Script.Random() < 0.66 then
              if _ARG_0_.oldAttackStateNear ~= "SuccessionAttack" then
                _ARG_0_:GotoState("SuccessionAttack")
              else
                _ARG_0_:GotoState("DisCharge")
              end
            elseif _ARG_0_.oldAttackStateNear ~= "DisCharge_1" then
              _ARG_0_:GotoState("DisCharge")
            else
              _ARG_0_:GotoState("SuccessionAttack")
            end
          else
            _ARG_0_.stack:push("Search2")
            if Script.Random() < 0.75 then
              _ARG_0_.stack:push("TargetMove")
            end
            if Script.Random() < 0.5 then
              if _ARG_0_.oldAttackStateFar2 ~= "CloneBurst" then
                _ARG_0_.stack:push("CloneBurst")
              elseif Script.Random() < 0.5 then
                _ARG_0_.stack:push("DarkCannon")
              else
                _ARG_0_.stack:push("DarkAxis")
              end
            elseif Script.Random() >= 0.5 and Script.Random() < 0.75 then
              if _ARG_0_.oldAttackStateFar2 ~= "DarkCannon" then
                _ARG_0_.stack:push("DarkCannon")
              elseif Script.Random() < 0.66 then
                _ARG_0_.stack:push("CloneBurst")
              else
                _ARG_0_.stack:push("DarkAxis")
              end
            elseif _ARG_0_.oldAttackStateFar2 ~= "DarkAxis" then
              _ARG_0_.stack:push("DarkAxis")
            elseif Script.Random() < 0.66 then
              _ARG_0_.stack:push("CloneBurst")
            else
              _ARG_0_.stack:push("DarkCannon")
            end
            if _ARG_0_.cureFlag == true then
              _ARG_0_.cureFlag = false
              _ARG_0_.stack:push("Recover")
            end
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        elseif Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_.stack:push("Search2")
          _ARG_0_:GotoState("TargetLastRecordedPosMove")
        end
      end
    },
    TargetMove = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        _ARG_0_.defenseTimer = 0
        _ARG_0_.defenseFlag = false
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.defenseTimer <= 0 then
          if _ARG_0_.defenseFlag == false then
            if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) and Entity.IsAttacking(_ARG_0_.targetHandle) then
              _ARG_0_.defenseFlag = true
              _ARG_0_.defenseTimer = _UPVALUE0_
            end
          else
            _ARG_0_.idlingTimer = 0
            _ARG_0_.stack:push("Search1")
            if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE1_ then
              if Script.Random() < 0.5 then
                _ARG_0_:GotoState("BackhandsSpringJump")
              else
                _ARG_0_:GotoState("Cartwheel")
              end
            else
              _ARG_0_:GotoState("Cartwheel")
            end
            return
          end
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE2_)
        if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= 4 or Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    TargetLastRecordedPosMove = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          return
        end
        Enemy.GetTargetLastRecordedPos(_UPVALUE0_, _ARG_0_.myHandle, _ARG_0_.targetHandle)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE0_, 5)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE1_)
        if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _UPVALUE0_) <= 4 or Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.IsWall(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Wander")
        end
      end
    },
    Wander = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        _ARG_0_.timer = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          return
        end
        _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.timer <= 0 then
          Enemy.GetTargetLastRecordedPos(_UPVALUE0_, _ARG_0_.myHandle, _ARG_0_.targetHandle)
          _UPVALUE1_:set(Math.Cos((Script.RandomInRange(-PI, PI))) * Script.RandomInRange(5, 50), 0.25, Math.Sin((Script.RandomInRange(-PI, PI))) * Script.RandomInRange(5, 50))
          FVECTOR3.Add(_ARG_0_.targetPos, _UPVALUE0_, _UPVALUE1_)
          Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
          Collision.IntersectRayBg(_ARG_0_.targetPos, COLL_KIND_ENEMY, _UPVALUE0_, _ARG_0_.targetPos)
          _ARG_0_.timer = 90
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 5)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE2_)
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) <= 4 or Entity.IsWall(_ARG_0_.myHandle) then
          _ARG_0_.timer = 0
        end
      end
    },
    BackhandsSpringJump = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10) == false then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            _UPVALUE1_:set(0, 0.2, -0.15)
            Entity.CalcVelocity(_ARG_0_.myHandle, _UPVALUE1_)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          Entity.GetVelocity(_UPVALUE1_, _ARG_0_.myHandle)
          if 0 > _UPVALUE1_:gety() then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if Entity.IsGround(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.step = 3
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Landing = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsGround(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.step = 1
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Cartwheel = {
      OnBeginState = function(_ARG_0_)
        Entity.SetRot(_ARG_0_.myHandle, 0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle), 0)
        if Script.Random() > 0.5 then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        else
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
        end
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        print("Cartwheel\n")
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 2.5)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    SuccessionAttack = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.step = 0
        print("SuccessionAttack\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
        _ARG_0_.oldAttackStateNear = "SuccessionAttack"
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 7 then
            if _ARG_0_:SelectFeint() then
              _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
              return
            end
            Entity.SetRootMoveScale(_ARG_0_.myHandle, (Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) + 0.5) / 2, 1, (Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) + 0.5) / 2)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
            Entity.SetRot(_ARG_0_.myHandle, 0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle), 0)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 0, 0)
            Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 4 then
            Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
            Entity.GetRot(_UPVALUE2_, _ARG_0_.myHandle)
            _UPVALUE1_:sety(_UPVALUE1_:gety() + 3)
            SetBulletAttackParam(Bullet.CreateBullet("b12exHB", _UPVALUE1_, _UPVALUE2_), _ARG_0_.myHandle, 2)
            if EntityManager:GetEntity((Bullet.CreateBullet("b12exHB", _UPVALUE1_, _UPVALUE2_))) ~= nil then
              EntityManager:GetEntity((Bullet.CreateBullet("b12exHB", _UPVALUE1_, _UPVALUE2_))).targetHandle = _ARG_0_.targetHandle
            end
            _ARG_0_.step = 3
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          if _ARG_0_.search == 2 then
            if Script.Random() < 0.33 then
              _ARG_0_.stack:push("Search1")
            else
              _ARG_0_.stack:push("Idling")
            end
          else
            _ARG_0_.stack:push("Search2")
          end
          if Script.Random() < 0.33 then
            _ARG_0_.stack:push("BackhandsSpringJump")
          end
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    DisCharge = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        print("DisCharge\n")
      end,
      OnEndState = function(_ARG_0_)
        _ARG_0_.oldAttackStateNear = "DisCharge_1"
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("DisCharge_1")
        end
      end
    },
    DisCharge_1 = {
      OnBeginState = function(_ARG_0_)
        Entity.SetRot(_ARG_0_.myHandle, 0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle), 0)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetRootMoveScale(_ARG_0_.myHandle, (Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) + 2) / 6, 1, (Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) + 2) / 6)
        _ARG_0_.step = 0
        print("DisCharge_1\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
        _ARG_0_.oldAttackStateNear = "DisCharge_1"
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 6 then
          if _ARG_0_:SelectFeint() then
            Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
            return
          end
          _ARG_0_.step = 1
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("DisCharge_2")
        end
      end
    },
    DisCharge_2 = {
      OnBeginState = function(_ARG_0_)
        Entity.SetRot(_ARG_0_.myHandle, 0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle), 0)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetRootMoveScale(_ARG_0_.myHandle, Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) / 3, 1, Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) / 3)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        _ARG_0_.step = 0
        _ARG_0_.step2 = 0
        print("DisCharge_2\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
        _ARG_0_.oldAttackStateNear = "DisCharge_1"
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step2 == 0 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 14 then
          if _ARG_0_:SelectFeint() then
            Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
            return
          end
          _ARG_0_.step2 = 1
        end
        if _ARG_0_.step == 0 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 18 then
          Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
          _UPVALUE1_:set(0, 0, 2)
          Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "Root", _UPVALUE1_)
          _UPVALUE2_:set(0, RoundPI(DegToRad(45) + _UPVALUE0_:gety()), 0)
          SetBulletAttackParam(Bullet.CreateBullet("b12exSWC", _UPVALUE1_, _UPVALUE2_), _ARG_0_.myHandle, 8)
          _UPVALUE1_:set(0, 0, 2)
          Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "Root", _UPVALUE1_)
          _UPVALUE2_:set(0, RoundPI(DegToRad(-45) + _UPVALUE0_:gety()), 0)
          SetBulletAttackParam(Bullet.CreateBullet("b12exSWC", _UPVALUE1_, _UPVALUE2_), _ARG_0_.myHandle, 8)
          _UPVALUE1_:set(0, 0, 2)
          Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "Root", _UPVALUE1_)
          _UPVALUE2_:set(0, RoundPI(DegToRad(135) + _UPVALUE0_:gety()), 0)
          SetBulletAttackParam(Bullet.CreateBullet("b12exSWC", _UPVALUE1_, _UPVALUE2_), _ARG_0_.myHandle, 8)
          _UPVALUE1_:set(0, 0, 2)
          Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "Root", _UPVALUE1_)
          _UPVALUE2_:set(0, RoundPI(DegToRad(-135) + _UPVALUE0_:gety()), 0)
          SetBulletAttackParam(Bullet.CreateBullet("b12exSWC", _UPVALUE1_, _UPVALUE2_), _ARG_0_.myHandle, 8)
          _ARG_0_.step = 1
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("DisCharge_3")
        end
      end
    },
    DisCharge_3 = {
      OnBeginState = function(_ARG_0_)
        Entity.SetRot(_ARG_0_.myHandle, 0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle), 0)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetRootMoveScale(_ARG_0_.myHandle, (Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) + 2) / 6.5, 1, (Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) + 2) / 6.5)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        print("DisCharge_3\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
        _ARG_0_.oldAttackStateNear = "DisCharge_1"
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 5 then
          if _ARG_0_:SelectFeint() then
            Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
            return
          end
          _ARG_0_.step = 1
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("DisCharge_4")
        end
      end
    },
    DisCharge_4 = {
      OnBeginState = function(_ARG_0_)
        Entity.SetRot(_ARG_0_.myHandle, 0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle), 0)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        _UPVALUE1_:set(0, 0.2, -0.25)
        Entity.CalcVelocity(_ARG_0_.myHandle, _UPVALUE1_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        print("DisCharge_4\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
        _ARG_0_.oldAttackStateNear = "DisCharge_1"
      end,
      OnUpdate = function(_ARG_0_)
        Entity.GetVelocity(_UPVALUE0_, _ARG_0_.myHandle)
        if _UPVALUE0_:gety() <= 0 then
          _ARG_0_:GotoState("DisCharge_5")
        end
      end
    },
    DisCharge_5 = {
      OnBeginState = function(_ARG_0_)
        Entity.SetAttackUseGroup(_ARG_0_.myHandle, 0)
        Entity.SetAttackUseGroup(_ARG_0_.myHandle, 1)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 0, -1, 1)
        Entity.EnableGravity(_ARG_0_.myHandle, 0)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        _ARG_0_.step = 0
        print("DisCharge_5\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
        _ARG_0_.oldAttackStateNear = "DisCharge_1"
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) <= 20 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        end
        if _ARG_0_.step == 0 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 34 then
          _UPVALUE0_:set(0, 0, 2.5)
          Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "center", _UPVALUE0_)
          Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
          SetBulletAttackParam(Bullet.CreateBullet("b12exHXB", _UPVALUE0_, _UPVALUE1_), _ARG_0_.myHandle, 7)
          if EntityManager:GetEntity((Bullet.CreateBullet("b12exHXB", _UPVALUE0_, _UPVALUE1_))) ~= nil then
            EntityManager:GetEntity((Bullet.CreateBullet("b12exHXB", _UPVALUE0_, _UPVALUE1_))).targetHandle = _ARG_0_.targetHandle
          end
          _ARG_0_.step = 1
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("DisCharge_6")
        end
      end
    },
    DisCharge_6 = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
        print("DisCharge_6\n")
      end,
      OnEndState = function(_ARG_0_)
        _ARG_0_.oldAttackStateNear = "DisCharge_1"
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsGround(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("DisCharge_7")
        end
      end
    },
    DisCharge_7 = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        print("DisCharge_7\n")
      end,
      OnEndState = function(_ARG_0_)
        _ARG_0_.oldAttackStateNear = "DisCharge_1"
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          if _ARG_0_.search == 2 then
            if Script.Random() < 0.33 then
              _ARG_0_.stack:push("Search1")
            else
              _ARG_0_.stack:push("Idling")
            end
          else
            _ARG_0_.stack:push("Search2")
          end
          if Script.Random() < 0.33 then
            _ARG_0_.stack:push("BackhandsSpringJump")
          end
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    DarkFiraga = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.step = 0
        _ARG_0_.attackCount = _ARG_0_.attackCount + 1
        print("DarkFiraga\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
        _ARG_0_.oldAttackStateFeint = "DarkFiraga"
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 21 then
            Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
            Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 18)
            Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
            SetBulletAttackParam(Bullet.CreateBullet("DarkFiragaL", _UPVALUE0_, _UPVALUE1_), _ARG_0_.myHandle, 10)
            if EntityManager:GetEntity((Bullet.CreateBullet("DarkFiragaL", _UPVALUE0_, _UPVALUE1_))) ~= nil then
              EntityManager:GetEntity((Bullet.CreateBullet("DarkFiragaL", _UPVALUE0_, _UPVALUE1_))).targetHandle = _ARG_0_.targetHandle
            end
            _ARG_0_.step = 1
          end
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    DarkThundaga = {
      OnBeginState = function(_ARG_0_)
        Entity.SetTimer(_ARG_0_.myHandle, 2)
        _ARG_0_.step = 0
        print("DarkThundaga\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
        _ARG_0_.oldAttackStateFeint = "DarkThundaga"
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            Entity.EnableGravity(_ARG_0_.myHandle, 0)
            Entity.SetRot(_ARG_0_.myHandle, 0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle), 0)
            _ARG_0_.velocity:set(0, 0, 0)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 14 then
            Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.EnableGravity(_ARG_0_.myHandle, 1)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
            _ARG_0_.step = 3
          end
        elseif _ARG_0_.step == 3 then
          if Entity.IsGround(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
            _ARG_0_.step = 4
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    DarkSplicer1 = {
      OnBeginState = function(_ARG_0_)
        AddCopyModelVanitusF(_ARG_0_.myHandle, _UPVALUE0_, "b032_WAP_LST0_0", 60)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        Entity.SetTimer(_ARG_0_.myHandle, 2)
        Entity.SetAlpha(_ARG_0_.myHandle, 0)
        Entity.EnableGravity(_ARG_0_.myHandle, 0)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        _ARG_0_:SetWarpEffect("b032_WAP_LST0_0")
        _ARG_0_:WarpToTarget(0.75, 0.5)
        _ARG_0_.step = 0
        print("DarkSplicer1\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
        Entity.SetAlpha(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:SetWarpEffect("b032_WAP_APP0_0")
            Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
            Entity.SetAlpha(_ARG_0_.myHandle, 1)
            Entity.SetAttackUseGroup(_ARG_0_.myHandle, 2)
            Entity.SetAttackUseGroup(_ARG_0_.myHandle, 3)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            _ARG_0_.step = 1
          end
        else
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            if _ARG_0_.warp == true then
              if Script.Random() < 0.66 then
                Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
                _ARG_0_.warp = false
                _ARG_0_.stack:push("Idling")
                _ARG_0_:GotoState("Landing")
              else
                _ARG_0_:GotoState("DarkSplicer2")
              end
            else
              if _ARG_0_.stack:pop(1) ~= "DarkSplicer2" then
                Entity.EnableGravity(_ARG_0_.myHandle, 1)
                Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
              end
              _ARG_0_:GotoState((_ARG_0_.stack:pop(1)))
            end
          end
        end
      end
    },
    DarkSplicer2 = {
      OnBeginState = function(_ARG_0_)
        AddCopyModelVanitusF(_ARG_0_.myHandle, _UPVALUE0_, "b032_WAP_LST0_0", 60)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        Entity.SetTimer(_ARG_0_.myHandle, 2)
        Entity.SetAlpha(_ARG_0_.myHandle, 0)
        Entity.EnableGravity(_ARG_0_.myHandle, 0)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        _ARG_0_:SetWarpEffect("b032_WAP_LST0_0")
        _ARG_0_:WarpToTarget(-0.75, 0.5)
        _ARG_0_.step = 0
        print("DarkSplicer2\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        Entity.SetAlpha(_ARG_0_.myHandle, 1)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        _ARG_0_.oldAttackStateFar1 = "DarkSplicer2"
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:SetWarpEffect("b032_WAP_APP0_0")
            Entity.SetAlpha(_ARG_0_.myHandle, 1)
            Entity.SetAttackUseGroup(_ARG_0_.myHandle, 0)
            Entity.SetAttackUseGroup(_ARG_0_.myHandle, 1)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
            _ARG_0_.step = 1
          end
        else
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            if _ARG_0_.warp == true then
              if Script.Random() < 0.66 then
                Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
                _ARG_0_.warp = false
                _ARG_0_.stack:push("Idling")
                _ARG_0_:GotoState("Landing")
              else
                _ARG_0_:GotoState("DarkSplicer1")
              end
            else
              _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
            end
          end
        end
      end
    },
    DarkAxis = {
      OnBeginState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        Entity.SetRot(_ARG_0_.myHandle, 0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle), 0)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        _UPVALUE1_:set(0, 0.125, -0.05)
        Entity.CalcVelocity(_ARG_0_.myHandle, _UPVALUE1_)
        _ARG_0_.step = 0
        _ARG_0_.count = Script.RandomInteger(_UPVALUE2_) + 1
        print("DarkAxis\n")
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
        _ARG_0_.oldAttackStateFar2 = "DarkAxis"
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.GetVelocity(_UPVALUE0_, _ARG_0_.myHandle)
          if 0 >= _UPVALUE0_:gety() then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
            Entity.EnableGravity(_ARG_0_.myHandle, 0)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 15 then
            Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE2_ / _UPVALUE3_)
            Entity.CalcVelocity(_ARG_0_.myHandle, _UPVALUE3_)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE4_)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.step = 3
          end
        elseif _ARG_0_.step == 3 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
            _ARG_0_.count = _ARG_0_.count - 1
            if 0 >= _ARG_0_.count then
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE5_)
              Entity.EnableGravity(_ARG_0_.myHandle, 1)
              _ARG_0_.step = 4
            else
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_, 0, -1, 10)
              _ARG_0_.step = 1
            end
          end
        elseif _ARG_0_.step == 4 then
          if Entity.IsGround(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE6_)
            _ARG_0_.step = 5
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    DarkCannon = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        _ARG_0_.step = 0
        _ARG_0_.count = 0
        print("DarkCannon\n")
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Player.SetLockOnMakert(_ARG_0_.myHandle, 0)
        if EntityManager:GetEntity(_ARG_0_.laserHandle) ~= nil then
          EntityManager:GetEntity(_ARG_0_.laserHandle):Destroy()
        end
        _ARG_0_.oldAttackStateFar2 = "DarkCannon"
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, _UPVALUE0_ / _UPVALUE0_ * _UPVALUE1_ + (1 - _UPVALUE0_ / _UPVALUE0_) * _UPVALUE2_)
        if _ARG_0_.step == 0 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE3_)
            Player.SetLockOnMakert(_ARG_0_.myHandle, 1)
            _ARG_0_.count = _ARG_0_.count + 1
            if _ARG_0_.count >= _UPVALUE4_ then
              Player.SetEnemyLockOne(_ARG_0_.myHandle)
              Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE3_)
              _ARG_0_.step = 1
            end
          end
        elseif _ARG_0_.step == 1 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE5_, 0)
            Player.SetLockOnMakert(_ARG_0_.myHandle, 0)
            Entity.EnableGravity(_ARG_0_.myHandle, 0)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          _UPVALUE6_:set(0, 0.012, 0)
          Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE6_)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 13 then
            _UPVALUE6_:set(0, 1.2, 2)
            _UPVALUE7_:set(-PI * 0.5, 0, 0)
            _ARG_0_.laserHandle = Bullet.CreateBullet("DCNLaser", _UPVALUE6_, _UPVALUE7_)
            SetBulletAttackParam(_ARG_0_.laserHandle, _ARG_0_.myHandle, 15)
            Entity.AttachCoord(_ARG_0_.myHandle, "Root", _ARG_0_.laserHandle, "Root")
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE8_)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
            Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
            _ARG_0_.step = 3
          end
        elseif _ARG_0_.step == 3 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            if EntityManager:GetEntity(_ARG_0_.laserHandle) ~= nil then
              EntityManager:GetEntity(_ARG_0_.laserHandle):Destroy()
            end
            _ARG_0_.laserHandle = NULL_HANDLE
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE9_)
            _ARG_0_.step = 4
          end
        elseif _ARG_0_.step == 4 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE10_)
            Entity.EnableGravity(_ARG_0_.myHandle, 1)
            _ARG_0_.step = 5
          end
        elseif _ARG_0_.step == 5 then
          if Entity.IsGround(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE11_)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.step = 6
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    WarpAttack2 = {
      OnBeginState = function(_ARG_0_)
        AddCopyModelVanitusF(_ARG_0_.myHandle, _UPVALUE0_, "b032_WAP_LST0_0", 60)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
        Entity.SetAlpha(_ARG_0_.myHandle, 0)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        _ARG_0_.step = 0
        print("WarpAttack2\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
        Entity.SetAlpha(_ARG_0_.myHandle, 1)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:WarpToTarget(-0.75, 1)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 0, 0)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if 1 <= Entity.GetMotionNowFrame(_ARG_0_.myHandle) then
            Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle, 2)
            _UPVALUE2_:set(0, 0, 0)
            Entity.SetEffect(_ARG_0_.myHandle, _UPVALUE3_, "b032_WAP_APP0_0", _UPVALUE1_, _UPVALUE2_)
            Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, 10)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 10 then
            Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
            Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
            Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
            _ARG_0_.step = 3
          end
        elseif _ARG_0_.step == 3 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 18 then
            Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle, 18)
            Entity.GetRot(_UPVALUE2_, _ARG_0_.myHandle)
            SetBulletAttackParam(Bullet.CreateBullet("IceCrystal", _UPVALUE1_, _UPVALUE2_), _ARG_0_.myHandle, 17)
            _ARG_0_.step = 4
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    ShadowDiving = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _UPVALUE1_:set(0, 0.2, 0)
        Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE1_)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        _ARG_0_.step = 0
        print("ShadowDiving\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        Entity.EnableBgColl(_ARG_0_.myHandle, 1)
        Effect.LoopEnd(_ARG_0_.shadow)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        _ARG_0_.shadow = NULL_HANDLE
        _ARG_0_.oldAttackStateFar1 = "ShadowDiving"
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.GetVelocity(_UPVALUE0_, _ARG_0_.myHandle)
          if 0 >= _UPVALUE0_:gety() then
            Entity.EnableGravity(_ARG_0_.myHandle, 0)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5) == false then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 15 then
            Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.targetHandle)
            Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.myHandle)
            FVECTOR3.Sub(_UPVALUE0_, _UPVALUE0_, _UPVALUE2_)
            _UPVALUE0_:sety(0)
            _UPVALUE0_:normalize()
            _UPVALUE0_:scale(_UPVALUE0_:length() / 20)
            Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE0_)
            _ARG_0_.flag = false
            _ARG_0_.step = 3
          end
        elseif _ARG_0_.step == 3 then
          if _ARG_0_.flag == false then
            Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
            _UPVALUE2_:copy(_UPVALUE0_)
            _UPVALUE2_:sety(_UPVALUE0_:gety() - 1.5)
            if Collision.IntersectRayBg(_UPVALUE0_, COLL_KIND_ENEMY, _UPVALUE0_, _UPVALUE2_) then
              _ARG_0_:CreateShadowDivingShockwave("b032_SDD_SHO0_0", 1, 4, _UPVALUE0_)
              _ARG_0_.flag = true
            end
          end
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE3_)
            Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
            _UPVALUE0_:set(0, 0, 0)
            _ARG_0_.shadow = Entity.AttachEffect(_ARG_0_.myHandle, _UPVALUE4_, "b032_SDD_SDW0_0", "Root", _UPVALUE0_, _UPVALUE0_)
            Effect.SetAttachNoRot(_ARG_0_.shadow, true)
            _ARG_0_.step = 4
          end
        elseif _ARG_0_.step == 4 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE5_)
          if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= 0.5625 or Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE6_)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Effect.LoopEnd(_ARG_0_.shadow)
            Effect.DetachCoord(_ARG_0_.shadow)
            Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
            _ARG_0_.shadow = NULL_HANDLE
            _ARG_0_.step = 5
          end
        elseif _ARG_0_.step == 5 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 4 then
            if EntityManager:GetEntity((_ARG_0_:CreateShadowDivingShockwave("b032_SDD_SHO2_0", 3, 4))) ~= nil then
              EntityManager:GetEntity((_ARG_0_:CreateShadowDivingShockwave("b032_SDD_SHO2_0", 3, 4))).splinter = true
            end
            _ARG_0_.step = 6
          end
        elseif _ARG_0_.step == 6 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.EnableBgColl(_ARG_0_.myHandle, 1)
            Entity.EnableGravity(_ARG_0_.myHandle, 1)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE7_)
            _ARG_0_.step = 7
          end
        elseif _ARG_0_.step == 7 then
          if Entity.IsGround(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE8_)
            _ARG_0_.step = 8
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    CloneBurst = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 1)
        _ARG_0_.step = 0
        _ARG_0_.count = 0
        print("CloneBurst\n")
      end,
      OnEndState = function(_ARG_0_)
        _ARG_0_.oldAttackStateFar2 = "CloneBurst"
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 16 then
            _ARG_0_.cloneBurstEffHandle = Entity.AttachEffect(_ARG_0_.myHandle, _UPVALUE0_, "B032_CLB_DOM0_0", "Root")
            Effect.SetAttachNoRot(_ARG_0_.cloneBurstEffHandle, true)
            Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
            Entity.SetTimer(_ARG_0_.myHandle, 50)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 10)
            Entity.SetTimer(_ARG_0_.myHandle, 90)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_.count = _ARG_0_.count + 1
            if _ARG_0_.count < _UPVALUE1_ then
              Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE2_)
              _ARG_0_:CreateCloneBurstBullet(Script.RandomInRange(-60, -30), Script.RandomInRange(-45, 45), _ARG_0_.CloneBurstMotionTbl[_ARG_0_.count])
            else
              Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE3_)
              _ARG_0_.step = 3
            end
          end
        elseif _ARG_0_.step == 3 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetRot(_ARG_0_.myHandle, 0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle), 0)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE4_, 0, 1)
            Entity.SetRootMoveScale(_ARG_0_.myHandle, (Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) + 5) / 9, 1, (Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) + 5) / 9)
            Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
            Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, 10)
            Effect.LoopEnd(_ARG_0_.cloneBurstEffHandle)
            _ARG_0_.step = 4
          end
        else
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        end
      end
    },
    DarkFang = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 10)
        _ARG_0_:SetWarpEffect("b032_WAP_LST0_0")
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        _ARG_0_.step = 0
        _ARG_0_.flag = false
        _ARG_0_.velocity:set(0, 0, 0)
        print("DarkFang\n")
      end,
      OnEndState = function(_ARG_0_)
        _ARG_0_.oldAttackStateFar1 = "DarkFang"
        _ARG_0_.flag = true
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step > 0 then
          Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.targetHandle)
          FVECTOR3.Sub(_ARG_0_.velocity, _UPVALUE0_, _ARG_0_.myPos)
          _ARG_0_.velocity:sety(0)
          _ARG_0_.velocity:normalize()
          _ARG_0_.velocity:scale(0.15)
          _UPVALUE1_:copy(_ARG_0_.velocity)
          _UPVALUE1_:scale(Entity.GetFrameRate(_ARG_0_.myHandle))
          FVECTOR3.Add(_ARG_0_.myPos, _ARG_0_.myPos, _UPVALUE1_)
        end
        if _ARG_0_.step == 0 then
          if Entity.IsModelFade(_ARG_0_.myHandle) == false then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
            Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
            Entity.GetWorldPos(_UPVALUE3_, _ARG_0_.targetHandle)
            if Collision.IntersectRayBg(_UPVALUE3_, COLL_KIND_ENEMY, _UPVALUE0_, _UPVALUE3_) then
              Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
            else
              Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.targetHandle)
              _UPVALUE3_:copy(_UPVALUE0_)
              _UPVALUE0_:sety(_UPVALUE0_:gety() + 1)
              _UPVALUE3_:sety(_UPVALUE3_:gety() - 10)
              if Collision.IntersectRayBg(_UPVALUE4_, COLL_KIND_ENEMY, _UPVALUE0_, _UPVALUE3_) then
                _UPVALUE0_:sety(_UPVALUE4_:gety())
              else
                Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
              end
            end
            Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE0_)
            Entity.SetOldLocalPos(_ARG_0_.myHandle, _UPVALUE0_)
            _ARG_0_.targetPos:copy(_UPVALUE0_)
            Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, 10)
            _ARG_0_.myPos:copy(_UPVALUE4_)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          _ARG_0_:SetWarpEffect("b032_WAP_APP0_0")
          _ARG_0_.step = 2
        elseif _ARG_0_.step == 2 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 30 then
            for _FORV_4_, _FORV_5_ in pairs(_UPVALUE5_) do
              _ARG_0_:CreateDarkFong(_FORV_5_)
            end
            Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
            _UPVALUE0_:set(0, 0, 0)
            Entity.SetEffect(_ARG_0_.myHandle, _UPVALUE6_, "B032_DAF_DRK0_0", _UPVALUE1_, _UPVALUE0_)
            _ARG_0_.step = 3
          end
        elseif _ARG_0_.step == 3 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle, 2)
            Entity.SetOldLocalPos(_ARG_0_.myHandle, _ARG_0_.targetPos)
            Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE1_)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE7_, 0, -1, 0, 0)
            Entity.SetTimer(_ARG_0_.myHandle, 30)
            _ARG_0_.flag = true
            _ARG_0_.step = 4
          end
        elseif Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    SpinRushAttack = {
      OnBeginState = function(_ARG_0_)
        Entity.SetTimer(_ARG_0_.myHandle, 2)
        _ARG_0_.step = 0
        print("SpinRushAttack\n")
      end,
      OnEndState = function(_ARG_0_)
        _ARG_0_.oldAttackStateFeint = "SpinRushAttack"
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetRot(_ARG_0_.myHandle, 0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle), 0)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 0, 0)
            Entity.SetRootMoveScale(_ARG_0_.myHandle, (Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) + 5) / 9, 1, (Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) + 5) / 9)
            Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
            _ARG_0_.step = 1
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Feint = {
      OnBeginState = function(_ARG_0_)
        AddCopyModelVanitusF(_ARG_0_.myHandle, _UPVALUE0_, "b032_WAP_LST0_0", _UPVALUE1_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE2_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
        Entity.SetAlpha(_ARG_0_.myHandle, 0)
        _ARG_0_.step = 0
        print("Feint\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
        Entity.SetAlpha(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
          return
        end
        if _ARG_0_.step == 0 then
          if Player.IsTrgFlagGuard(_ARG_0_.targetHandle) and Script.Random() < 0.5 then
            _ARG_0_.step = 1
            return
          end
          _ARG_0_.step = 2
        elseif _ARG_0_.step == 1 then
          if Player.IsTrgFlagGuard(_ARG_0_.targetHandle) == false then
            _ARG_0_.step = 2
          end
        else
          _ARG_0_:Warp(5)
          _ARG_0_:GotoState((_ARG_0_.stack:pop(1)))
        end
      end
    },
    Recover = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 1, -2)
        Enemy.EnableInvincible(_ARG_0_.myHandle, 1)
        _ARG_0_.step = 0
        print("Recover\n")
      end,
      OnEndState = function(_ARG_0_)
        _ARG_0_.recoverHp = 0
        Enemy.EnableInvincible(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 13 then
            print("\137\241\149\156\151\202 = " .. _ARG_0_.recoverHp .. "\n")
            Enemy.AddHp(_ARG_0_.myHandle, _ARG_0_.recoverHp)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            _ARG_0_.step = 1
          end
        elseif Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 17 then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Defense = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.cloneBurstEffHandle = Entity.AttachEffect(_ARG_0_.myHandle, _UPVALUE1_, "B032_CLB_DOM0_0", "Root")
        Effect.SetAttachNoRot(_ARG_0_.cloneBurstEffHandle, true)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
        Entity.SetTimer(_ARG_0_.myHandle, 50)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, 10)
        Effect.LoopEnd(_ARG_0_.cloneBurstEffHandle)
        Entity.SetRot(_ARG_0_.myHandle, 0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle), 0)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 10)
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 and Player.GetCommandKind(_ARG_0_.targetHandle) ~= COMMAND_KIND_RagingCharge then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Dead = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Sound.IsInvalidateSeCall() == 1 then
            _ARG_0_.timer = 60
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          _ARG_0_.timer = _ARG_0_.timer - Script.GetVsyncFrameRate()
          if 0 >= _ARG_0_.timer then
            Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 2)
            Sound.PlayVoice(105, 32, 1, _UPVALUE0_, SE_OPT_ALWAYS)
            _ARG_0_.step = 2
          end
        end
      end
    }
  },
  RestHpRate = function(_ARG_0_)
    return Enemy.GetHp(_ARG_0_.myHandle) / Enemy.GetHpMax(_ARG_0_.myHandle)
  end,
  Turn = function(_ARG_0_)
    _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
    Enemy.GetTargetLastRecordedPos(_UPVALUE0_, _ARG_0_.myHandle, _ARG_0_.targetHandle)
    Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
    Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE0_, 2.5)
    Entity.GetRot(_UPVALUE2_, _ARG_0_.myHandle)
    if _ARG_0_.rotTimer > 0 then
      _ARG_0_.rotTimer = _ARG_0_.rotTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
    end
    if 0 > RoundPI(_UPVALUE2_:gety() - _UPVALUE1_:gety()) then
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE3_)
      _ARG_0_.rotTimer = 10
    elseif 0 < RoundPI(_UPVALUE2_:gety() - _UPVALUE1_:gety()) then
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE4_)
      _ARG_0_.rotTimer = 10
    elseif _ARG_0_.rotTimer <= 0 then
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE5_)
    end
  end,
  SetWarpEffect = function(_ARG_0_, _ARG_1_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 2)
    _UPVALUE1_:set(0, 0, 0)
    Entity.SetEffect(_ARG_0_.myHandle, _UPVALUE2_, _ARG_1_, _UPVALUE0_, _UPVALUE1_)
  end,
  WarpToTarget = function(_ARG_0_, _ARG_1_, _ARG_2_)
    Entity.GetDir(_UPVALUE0_, _ARG_0_.targetHandle)
    _UPVALUE0_:scale(_ARG_1_)
    Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
    Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.targetHandle)
    if Collision.IntersectRayBg(_UPVALUE2_, COLL_KIND_ENEMY, _UPVALUE1_, _UPVALUE2_) then
      Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
    else
      Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.targetHandle)
      _UPVALUE2_:copy(_UPVALUE1_)
      _UPVALUE1_:sety(_UPVALUE1_:gety() + 1)
      _UPVALUE2_:sety(_UPVALUE2_:gety() - 10)
      if Collision.IntersectRayBg(_UPVALUE3_, COLL_KIND_ENEMY, _UPVALUE1_, _UPVALUE2_) then
        _UPVALUE1_:sety(_UPVALUE3_:gety())
      else
        Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
      end
    end
    FVECTOR3.Add(_UPVALUE0_, _UPVALUE0_, _UPVALUE1_)
    Collision.IntersectRayBg(_UPVALUE0_, COLL_KIND_ENEMY, _UPVALUE1_, _UPVALUE0_)
    _UPVALUE0_:sety(_UPVALUE0_:gety() + _ARG_2_)
    Entity.Warp(_ARG_0_.myHandle, _UPVALUE0_)
    FVECTOR3.Sub(_UPVALUE0_, _UPVALUE1_, _UPVALUE0_)
    Entity.SetRot(_ARG_0_.myHandle, 0, Math.Atan2(_UPVALUE0_:getx(), _UPVALUE0_:getz()), 0)
  end,
  Warp = function(_ARG_0_, _ARG_1_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
    Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.targetHandle)
    if Collision.IntersectRayBg(_UPVALUE1_, COLL_KIND_ENEMY, _UPVALUE0_, _UPVALUE1_) then
      Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
    else
      Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.targetHandle)
      _UPVALUE1_:copy(_UPVALUE0_)
      _UPVALUE0_:sety(_UPVALUE0_:gety() + 1)
      _UPVALUE1_:sety(_UPVALUE1_:gety() - 10)
      if Collision.IntersectRayBg(_UPVALUE2_, COLL_KIND_ENEMY, _UPVALUE0_, _UPVALUE1_) then
        _UPVALUE0_:sety(_UPVALUE2_:gety())
      else
        Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
      end
    end
    Entity.GetWorldPos(_UPVALUE3_, _ARG_0_.myHandle)
    FVECTOR3.Sub(_UPVALUE3_, _UPVALUE0_, _UPVALUE3_)
    _UPVALUE3_:set(0, _UPVALUE2_:gety(), _ARG_1_)
    _UPVALUE1_:set(0, RoundPI((Script.RandomInRange(Math.Atan2(_UPVALUE3_:getx(), _UPVALUE3_:getz()) - PI * 0.5, Math.Atan2(_UPVALUE3_:getx(), _UPVALUE3_:getz()) + PI * 0.5))), 0)
    Math.RotateVectorXYZ(_UPVALUE3_, _UPVALUE1_)
    FVECTOR3.Add(_UPVALUE3_, _UPVALUE3_, _UPVALUE0_)
    Collision.IntersectRayBg(_UPVALUE3_, COLL_KIND_ENEMY, _UPVALUE0_, _UPVALUE3_)
    Entity.Warp(_ARG_0_.myHandle, _UPVALUE3_)
    FVECTOR3.Sub(_UPVALUE3_, _UPVALUE0_, _UPVALUE3_)
    Entity.SetRot(_ARG_0_.myHandle, 0, Math.Atan2(_UPVALUE3_:getx(), _UPVALUE3_:getz()), 0)
  end,
  SelectFeint = function(_ARG_0_)
    if _UPVALUE0_[_ARG_0_:GetState()] == nil then
      return false
    end
    if _UPVALUE0_[_ARG_0_:GetState()][_ARG_0_.search] == nil then
      return false
    end
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _UPVALUE1_ then
      return false
    end
    if _ARG_0_.oldAttackStateNear == _UPVALUE0_[_ARG_0_:GetState()][_ARG_0_.search][1] then
      if Script.Random() < 0.5 then
        if Script.Random() < 0.66 then
          _ARG_0_.stack:push(_UPVALUE0_[_ARG_0_:GetState()][_ARG_0_.search][4])
        else
          _ARG_0_.stack:push(_UPVALUE0_[_ARG_0_:GetState()][_ARG_0_.search][5])
        end
        if Script.Random() < 0.66 then
          _ARG_0_.stack:push(_UPVALUE0_[_ARG_0_:GetState()][_ARG_0_.search][2])
        else
          _ARG_0_.stack:push(_UPVALUE0_[_ARG_0_:GetState()][_ARG_0_.search][3])
        end
        _ARG_0_.stack:push("Feint")
        return true
      end
    elseif _ARG_0_.oldAttackStateFeint == _UPVALUE0_[_ARG_0_:GetState()][_ARG_0_.search][2] then
      if Script.Random() < _UPVALUE2_ then
        if Script.Random() < 0.66 then
          _ARG_0_.stack:push(_UPVALUE0_[_ARG_0_:GetState()][_ARG_0_.search][4])
        else
          _ARG_0_.stack:push(_UPVALUE0_[_ARG_0_:GetState()][_ARG_0_.search][5])
        end
        _ARG_0_.stack:push(_UPVALUE0_[_ARG_0_:GetState()][_ARG_0_.search][1])
        _ARG_0_.stack:push("Feint")
        return true
      elseif Script.Random() >= _UPVALUE2_ and Script.Random() < _UPVALUE2_ * 2 then
        if Script.Random() < 0.66 then
          _ARG_0_.stack:push(_UPVALUE0_[_ARG_0_:GetState()][_ARG_0_.search][4])
        else
          _ARG_0_.stack:push(_UPVALUE0_[_ARG_0_:GetState()][_ARG_0_.search][5])
        end
        _ARG_0_.stack:push(_UPVALUE0_[_ARG_0_:GetState()][_ARG_0_.search][3])
        _ARG_0_.stack:push("Feint")
        return true
      end
    elseif _ARG_0_.oldAttackStateFeint == _UPVALUE0_[_ARG_0_:GetState()][_ARG_0_.search][3] then
      if Script.Random() < _UPVALUE2_ then
        if Script.Random() < 0.66 then
          _ARG_0_.stack:push(_UPVALUE0_[_ARG_0_:GetState()][_ARG_0_.search][4])
        else
          _ARG_0_.stack:push(_UPVALUE0_[_ARG_0_:GetState()][_ARG_0_.search][5])
        end
        _ARG_0_.stack:push(_UPVALUE0_[_ARG_0_:GetState()][_ARG_0_.search][1])
        _ARG_0_.stack:push("Feint")
        return true
      elseif Script.Random() >= _UPVALUE2_ and Script.Random() < _UPVALUE2_ * 2 then
        if Script.Random() < 0.66 then
          _ARG_0_.stack:push(_UPVALUE0_[_ARG_0_:GetState()][_ARG_0_.search][4])
        else
          _ARG_0_.stack:push(_UPVALUE0_[_ARG_0_:GetState()][_ARG_0_.search][5])
        end
        _ARG_0_.stack:push(_UPVALUE0_[_ARG_0_:GetState()][_ARG_0_.search][2])
        _ARG_0_.stack:push("Feint")
        return true
      end
    elseif Script.Random() < _UPVALUE2_ then
      if Script.Random() < 0.66 then
        _ARG_0_.stack:push(_UPVALUE0_[_ARG_0_:GetState()][_ARG_0_.search][4])
      else
        _ARG_0_.stack:push(_UPVALUE0_[_ARG_0_:GetState()][_ARG_0_.search][5])
      end
      _ARG_0_.stack:push(_UPVALUE0_[_ARG_0_:GetState()][_ARG_0_.search][1])
      _ARG_0_.stack:push("Feint")
      return true
    elseif Script.Random() >= _UPVALUE2_ and Script.Random() < _UPVALUE2_ * 2 then
      if Script.Random() < 0.66 then
        _ARG_0_.stack:push(_UPVALUE0_[_ARG_0_:GetState()][_ARG_0_.search][4])
      else
        _ARG_0_.stack:push(_UPVALUE0_[_ARG_0_:GetState()][_ARG_0_.search][5])
      end
      if Script.Random() < 0.66 then
        _ARG_0_.stack:push(_UPVALUE0_[_ARG_0_:GetState()][_ARG_0_.search][2])
      else
        _ARG_0_.stack:push(_UPVALUE0_[_ARG_0_:GetState()][_ARG_0_.search][3])
      end
      _ARG_0_.stack:push("Feint")
      return true
    end
    return false
  end,
  CreateShadowDivingShockwave = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
    if _ARG_4_ == nil then
      Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
      _UPVALUE1_:copy(_UPVALUE0_)
      _UPVALUE0_:sety(_UPVALUE0_:gety() + 5)
      _UPVALUE1_:sety(_UPVALUE1_:gety() - 20)
      Collision.IntersectRayBg(_UPVALUE0_, COLL_KIND_ENEMY, _UPVALUE0_, _UPVALUE1_)
    else
      _UPVALUE0_:copy(_ARG_4_)
    end
    _UPVALUE1_:set(0, 0, 0)
    Bullet.SetCollision(Bullet.CreateBullet("b12exSDSW", _UPVALUE0_, _UPVALUE1_), COLL_KIND_ENEMY, COLL_SHAPE_CYLINDER, _ARG_2_, _ARG_3_, (Bullet.CreateBullet("b12exSDSW", _UPVALUE0_, _UPVALUE1_)))
    Bullet.CreateEffectBullet(Bullet.CreateBullet("b12exSDSW", _UPVALUE0_, _UPVALUE1_), _UPVALUE2_, _ARG_1_)
    SetBulletAttackParam(Bullet.CreateBullet("b12exSDSW", _UPVALUE0_, _UPVALUE1_), _ARG_0_.myHandle, 20)
    return (Bullet.CreateBullet("b12exSDSW", _UPVALUE0_, _UPVALUE1_))
  end,
  CreateCloneBurstBullet = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 2)
    Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
    _UPVALUE1_:setx(RoundPI(_UPVALUE1_:getx() + DegToRad(_ARG_1_)))
    _UPVALUE1_:sety(RoundPI(_UPVALUE1_:gety() + DegToRad(_ARG_2_)))
    if EntityManager:GetEntity((Entity.CreateEntity("b12ex01", _UPVALUE0_, _UPVALUE1_, _ARG_0_.myHandle))) ~= nil then
      EntityManager:GetEntity((Entity.CreateEntity("b12ex01", _UPVALUE0_, _UPVALUE1_, _ARG_0_.myHandle))).targetHandle = _ARG_0_.targetHandle
      EntityManager:GetEntity((Entity.CreateEntity("b12ex01", _UPVALUE0_, _UPVALUE1_, _ARG_0_.myHandle))).attackInfo = _ARG_3_
    end
    return (Entity.CreateEntity("b12ex01", _UPVALUE0_, _UPVALUE1_, _ARG_0_.myHandle))
  end,
  CreateDarkFong = function(_ARG_0_, _ARG_1_)
    _UPVALUE0_:set(_ARG_1_.x, _ARG_1_.y, _ARG_1_.z)
    Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "Root", _UPVALUE0_)
    Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
    _UPVALUE1_:setx(DegToRad(-20))
    _UPVALUE1_:sety(RoundPI(_UPVALUE1_:gety() + DegToRad(_ARG_1_.roty)))
    SetBulletAttackParam(Bullet.CreateBullet("DarkFang", _UPVALUE0_, _UPVALUE1_), _ARG_0_.myHandle, 24)
    return (Bullet.CreateBullet("DarkFang", _UPVALUE0_, _UPVALUE1_))
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    _UPVALUE0_ = Entity.GetMotionIndex(_ARG_1_, "010")
    _UPVALUE1_ = Entity.GetMotionIndex(_ARG_1_, "040")
    _UPVALUE2_ = Entity.GetMotionIndex(_ARG_1_, "050")
    _UPVALUE3_ = Entity.GetMotionIndex(_ARG_1_, "051")
    _UPVALUE4_ = Entity.GetMotionIndex(_ARG_1_, "052")
    _UPVALUE5_ = Entity.GetMotionIndex(_ARG_1_, "053")
    _UPVALUE6_ = Entity.GetMotionIndex(_ARG_1_, "054")
    _UPVALUE7_ = Entity.GetMotionIndex(_ARG_1_, "061")
    _UPVALUE8_ = Entity.GetMotionIndex(_ARG_1_, "062")
    _UPVALUE9_ = Entity.GetMotionIndex(_ARG_1_, "300")
    _UPVALUE10_ = Entity.GetMotionIndex(_ARG_1_, "301")
    _UPVALUE11_ = Entity.GetMotionIndex(_ARG_1_, "302")
    _UPVALUE12_ = Entity.GetMotionIndex(_ARG_1_, "303")
    _UPVALUE13_ = Entity.GetMotionIndex(_ARG_1_, "304")
    _UPVALUE14_ = Entity.GetMotionIndex(_ARG_1_, "305")
    _UPVALUE15_ = Entity.GetMotionIndex(_ARG_1_, "306")
    _UPVALUE16_ = Entity.GetMotionIndex(_ARG_1_, "308")
    _UPVALUE17_ = Entity.GetMotionIndex(_ARG_1_, "309")
    _UPVALUE18_ = Entity.GetMotionIndex(_ARG_1_, "310")
    _UPVALUE19_ = Entity.GetMotionIndex(_ARG_1_, "311")
    _UPVALUE20_ = Entity.GetMotionIndex(_ARG_1_, "312")
    _UPVALUE21_ = Entity.GetMotionIndex(_ARG_1_, "313")
    _UPVALUE22_ = Entity.GetMotionIndex(_ARG_1_, "314")
    _UPVALUE23_ = Entity.GetMotionIndex(_ARG_1_, "315")
    _UPVALUE24_ = Entity.GetMotionIndex(_ARG_1_, "316")
    _UPVALUE25_ = Entity.GetMotionIndex(_ARG_1_, "317")
    _UPVALUE26_ = Entity.GetMotionIndex(_ARG_1_, "318")
    _UPVALUE27_ = Entity.GetMotionIndex(_ARG_1_, "319")
    _ARG_0_.CloneBurstMotionTbl = {}
    _ARG_0_.CloneBurstMotionTbl[1] = {
      _UPVALUE11_,
      26,
      {1}
    }
    _ARG_0_.CloneBurstMotionTbl[2] = {
      _UPVALUE10_,
      14,
      {1}
    }
    _ARG_0_.CloneBurstMotionTbl[3] = {
      _UPVALUE16_,
      -1,
      {4, 5}
    }
    _ARG_0_.CloneBurstMotionTbl[4] = {
      _UPVALUE17_,
      -1,
      {2, 3}
    }
    _ARG_0_.CloneBurstMotionTbl[5] = {
      _UPVALUE11_,
      26,
      {1}
    }
    _ARG_0_.CloneBurstMotionTbl[6] = {
      _UPVALUE10_,
      14,
      {1}
    }
    _ARG_0_.CloneBurstMotionTbl[7] = {
      _UPVALUE17_,
      -1,
      {2, 3}
    }
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.targetHandle = NULL_HANDLE
    _ARG_0_.effHandle = NULL_HANDLE
    _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
    _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
    _ARG_0_.step = 0
    _ARG_0_.step2 = 0
    _ARG_0_.count = 0
    _ARG_0_.attackCount = 0
    _ARG_0_.dmgCount = 0
    _ARG_0_.ragingChargeDmgCount = 0
    _ARG_0_.idlingTimer = _UPVALUE28_
    _ARG_0_.rotTimer = 0
    _ARG_0_.oldAtkKind = -1
    _ARG_0_.airBattle = false
    _ARG_0_.warp = false
    _ARG_0_.defenseTimer = 0
    _ARG_0_.defenseFlag = false
    _ARG_0_.laserScale = 1
    _ARG_0_.flag = false
    _ARG_0_.oldAttackStateFar1 = ""
    _ARG_0_.oldAttackStateFar2 = ""
    _ARG_0_.oldAttackStateNear = ""
    _ARG_0_.oldAttackStateFeint = ""
    _ARG_0_.feint = false
    _ARG_0_.laserHandle = NULL_HANDLE
    _ARG_0_.cloneBurstEffHandle = NULL_HANDLE
    _ARG_0_.search = 1
    _ARG_0_.oldCmdSubcate = 0
    _ARG_0_.recoverHp = 0
    _ARG_0_.cureFlag = false
    _ARG_0_.timer = 0
    _ARG_0_.stack = Stack:Create()
    Entity.EnableGravity(_ARG_1_, 1)
    Enemy.SetViewDist(_ARG_1_, 110)
    Player.SetBossCamera("b12ex")
    _ARG_0_:GotoState("Appear")
  end,
  OnDestroy = function(_ARG_0_)
  end,
  OnSetMotion = function(_ARG_0_, _ARG_1_)
    Entity.SetMotionSpeed(_ARG_0_.myHandle, _UPVALUE0_[Entity.GetMotionName(_ARG_0_.myHandle, _ARG_1_)][1])
    Entity.SetMovementCoefficient(_ARG_0_.myHandle, _UPVALUE0_[Entity.GetMotionName(_ARG_0_.myHandle, _ARG_1_)][2] and _UPVALUE0_[Entity.GetMotionName(_ARG_0_.myHandle, _ARG_1_)][1])
  end,
  OnReturnDamage = function(_ARG_0_)
    Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
    _ARG_0_:GotoState("Idling")
  end,
  OnEndReaction = function(_ARG_0_)
    Entity.EnableGravity(_ARG_0_.myHandle, 1)
  end,
  OnDamageBefore = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    _ARG_0_.idlingTimer = 0
    if _ARG_2_ == COMMAND_CATEGORY_SHOOTLOCK then
      Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
      _ARG_0_.stack:push("Idling")
      _ARG_0_.dmgCount = 0
      _ARG_0_.warp = true
      if Script.Random() > 0.66 then
        _ARG_0_.stack:push("DarkSplicer2")
      else
        _ARG_0_.stack:push("WarpAttack2")
      end
      _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      return 1
    end
    if Enemy.IsNoDamageReaction(_ARG_0_.myHandle) then
      return 0
    end
    _ARG_0_.dmgCount = _ARG_0_.dmgCount + 1
    if _ARG_1_ == ATK_KIND_DMG_SMALL or _ARG_1_ == ATK_KIND_DMG_BIG then
      if Script.Random() >= _UPVALUE0_ * _ARG_0_.dmgCount then
        return 0
      end
    elseif Script.Random() >= _UPVALUE1_ * _ARG_0_.dmgCount then
      return 0
    end
    Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
    _ARG_0_.stack:push("Idling")
    _ARG_0_.dmgCount = 0
    _ARG_0_.warp = true
    if Script.Random() > 0.66 then
      _ARG_0_.stack:push("DarkSplicer2")
    else
      _ARG_0_.stack:push("WarpAttack2")
    end
    _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
    return 1
  end,
  OnDamage = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    if Player.GetCommandKind(_ARG_0_.targetHandle) == COMMAND_KIND_RagingCharge then
      _ARG_0_.ragingChargeDmgCount = _ARG_0_.ragingChargeDmgCount + 1
      if _ARG_0_.ragingChargeDmgCount >= _UPVALUE0_ then
        _ARG_0_.ragingChargeDmgCount = 0
        _ARG_0_.stack:push("Idling")
        _ARG_0_:GotoState("Defense")
        return 1
      end
    end
    return 0
  end,
  OnReflect = function(_ARG_0_)
    Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
    Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
    Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
    Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
    Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
    Entity.EnableGravity(_ARG_0_.myHandle, 1)
    Entity.EnableBgColl(_ARG_0_.myHandle, 1)
    Entity.SetAlpha(_ARG_0_.myHandle, 1)
    return 0
  end,
  OnDead = function(_ARG_0_)
    SetupBossDead(_ARG_0_.myHandle)
    _ARG_0_:GotoState("Dead")
    return 1
  end,
  OnUpdatePositionAfter = function(_ARG_0_)
    if _ARG_0_.oldCmdSubcate ~= Player.GetCommandSubcate((Player.GetHandle())) and Player.GetCommandSubcate((Player.GetHandle())) == COMMAND_SUB_CURE then
      _ARG_0_.recoverHp = _UPVALUE0_
      _ARG_0_.cureFlag = true
    end
    _ARG_0_.oldCmdSubcate = Player.GetCommandSubcate((Player.GetHandle()))
  end,
  OnBeginDamageReaction = function(_ARG_0_)
    Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
    Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
    Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
    Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
    Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
    Entity.EnableGravity(_ARG_0_.myHandle, 1)
    Entity.EnableBgColl(_ARG_0_.myHandle, 1)
    Entity.SetAlpha(_ARG_0_.myHandle, 1)
  end,
  OnUpdate = function(_ARG_0_)
    _ARG_0_:Update()
    _ARG_0_:Debug()
    if _ARG_0_.defenseTimer > 0 then
      _ARG_0_.defenseTimer = _ARG_0_.defenseTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
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
        _ARG_0_.stack:clear()
        _ARG_0_.stack:push("Idling")
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        _ARG_0_:GotoState(_UPVALUE0_[Script.GetDebugAttackNumber() + 1])
      end
    end
  end
}, {__index = __StateMachine})
EntityFactory:Add("b12ex00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b12ex01", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b12exHB", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b12exHXB", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b12exSWC", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("DCNLaser", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("IceCrystal", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b12exSDSW", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b12exSDS", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("DarkFiragaL", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("DarkFiragaS", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("DarkFang", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
