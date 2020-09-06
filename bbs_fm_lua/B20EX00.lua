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
          _ARG_0_.stack:push("Wander")
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    Idling = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_.idlingTimer)
        _ARG_0_.rotTimer = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        if _ARG_0_.idlingTimer <= 0 and _ARG_0_:SelectAttack() then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          return
        end
        Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
        Enemy.GetTargetLastRecordedPos(_UPVALUE1_, _ARG_0_.myHandle, _ARG_0_.targetHandle)
        Entity.GetRot(_UPVALUE2_, _ARG_0_.myHandle)
        if 0 < _ARG_0_.rotTimer then
          _ARG_0_.rotTimer = _ARG_0_.rotTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
        end
        if 0 > RoundPI(_UPVALUE2_:gety() - _UPVALUE0_:gety()) then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE3_)
          _ARG_0_.rotTimer = 10
        elseif 0 < RoundPI(_UPVALUE2_:gety() - _UPVALUE0_:gety()) then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE4_)
          _ARG_0_.rotTimer = 10
        elseif 0 >= _ARG_0_.rotTimer then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE5_)
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Wander = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        _ARG_0_.step = 1
        _ARG_0_.walkTimer = 0
        _ARG_0_.timer = 0
        _ARG_0_.defenseFlag = false
        _ARG_0_.defenseTimer = 0
        _ARG_0_.velocity:set(0, 0, 0)
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.walkTimer > 0 then
          _ARG_0_.walkTimer = _ARG_0_.walkTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
        end
        if 0 < _ARG_0_.timer then
          _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
        end
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        Enemy.GetTargetLastRecordedPos(_UPVALUE0_, _ARG_0_.myHandle, _ARG_0_.targetHandle)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE0_, 2.5)
        if _ARG_0_:Defense() then
          return
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          if _ARG_0_:SelectAttack() then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
            return
          else
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
          end
        end
        if _ARG_0_.step == 0 then
          if 0 >= _ARG_0_.timer then
            if Entity.IsWall(_ARG_0_.myHandle) then
              if Entity.GetCurrentMotion(_ARG_0_.myHandle) == _UPVALUE2_ then
                Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
                _ARG_0_.velocity:set(-_UPVALUE4_, 0, 0)
                _ARG_0_.timer = 15
              elseif Entity.GetCurrentMotion(_ARG_0_.myHandle) == _UPVALUE3_ then
                Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
                _ARG_0_.velocity:set(_UPVALUE4_, 0, 0)
                _ARG_0_.timer = 15
              elseif Entity.GetCurrentMotion(_ARG_0_.myHandle) == _UPVALUE5_ then
                Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE6_)
                _ARG_0_.velocity:set(_UPVALUE7_, 0, 0)
                _ARG_0_.timer = 15
              elseif Entity.GetCurrentMotion(_ARG_0_.myHandle) == _UPVALUE6_ then
                Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE5_)
                _ARG_0_.velocity:set(-_UPVALUE7_, 0, 0)
                _ARG_0_.timer = 15
              end
            elseif Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE8_ then
              Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE9_)
              _ARG_0_.velocity:set(0, 0, -_UPVALUE4_)
              _ARG_0_.timer = 15
            elseif Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) >= _UPVALUE8_ and Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE10_ then
              if _ARG_0_:RestHpRate() > _UPVALUE11_ then
                if Entity.GetCurrentMotion(_ARG_0_.myHandle) ~= _UPVALUE2_ and Entity.GetCurrentMotion(_ARG_0_.myHandle) ~= _UPVALUE3_ then
                  if Script.Random() < 0.5 then
                    Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
                    _ARG_0_.velocity:set(_UPVALUE4_, 0, 0)
                  else
                    Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
                    _ARG_0_.velocity:set(-_UPVALUE4_, 0, 0)
                  end
                  _ARG_0_.timer = 15
                end
              elseif Entity.GetCurrentMotion(_ARG_0_.myHandle) ~= _UPVALUE6_ and Entity.GetCurrentMotion(_ARG_0_.myHandle) ~= _UPVALUE5_ then
                if Script.Random() < 0.5 then
                  Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE6_)
                  _ARG_0_.velocity:set(_UPVALUE7_, 0, 0)
                else
                  Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE5_)
                  _ARG_0_.velocity:set(-_UPVALUE7_, 0, 0)
                end
                _ARG_0_.timer = 15
              end
            elseif _ARG_0_:RestHpRate() > _UPVALUE11_ then
              Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE12_)
              _ARG_0_.velocity:set(0, 0, _UPVALUE4_)
              _ARG_0_.timer = 15
            else
              Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE13_)
              _ARG_0_.velocity:set(0, 0, _UPVALUE7_)
              _ARG_0_.timer = 15
            end
          end
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
          if _ARG_0_.walkTimer <= 0 then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            if Script.Random() < 0.25 then
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE14_)
              _ARG_0_.walkTimer = Script.RandomInRange(_UPVALUE15_, _UPVALUE15_ * 2)
              _ARG_0_.step = 1
            else
              _ARG_0_.walkTimer = Script.RandomInRange(_UPVALUE16_, _UPVALUE16_ * 2)
            end
          end
        elseif _ARG_0_.walkTimer <= 0 then
          _ARG_0_.walkTimer = Script.RandomInRange(_UPVALUE16_, _UPVALUE16_ * 2)
          _ARG_0_.step = 0
        end
      end
    },
    Flee = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.myHandle, 2)
        for _FORV_6_ = Entity.CalcDirection(_ARG_0_.targetHandle, _ARG_0_.myHandle) - DegToRad(60), Entity.CalcDirection(_ARG_0_.targetHandle, _ARG_0_.myHandle) - DegToRad(60) + PI, DegToRad(20) do
          _UPVALUE3_:set(Math.Cos((RoundPI(Entity.CalcDirection(_ARG_0_.targetHandle, _ARG_0_.myHandle) - DegToRad(60)))) * 50, 0, Math.Sin((RoundPI(Entity.CalcDirection(_ARG_0_.targetHandle, _ARG_0_.myHandle) - DegToRad(60)))) * 50)
          FVECTOR3.Add(_UPVALUE3_, _UPVALUE2_, _UPVALUE3_)
          Collision.IntersectRayBg(_UPVALUE3_, COLL_KIND_ENEMY, _UPVALUE2_, _UPVALUE3_)
          if 0 < Entity.CalcDistanceXZSq(_ARG_0_.targetHandle, _UPVALUE3_) then
            _ARG_0_.targetPos:copy(_UPVALUE3_)
          end
        end
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 5)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE0_)
        if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _UPVALUE1_ or Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.IsWall(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    TargetKeepDistanceMove = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_:EvadeTarget(_UPVALUE1_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    MoveToCenter = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, 600)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        _UPVALUE0_:set(0, 0, 0)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE0_, 10)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE1_)
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _UPVALUE0_) <= 36 or Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    SuccessionAttack = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    RushAttack = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        _ARG_0_.step = 0
        _ARG_0_.count = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 8 then
            _ARG_0_.step = 1
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.count = _ARG_0_.count + 1
          if _ARG_0_.count < _UPVALUE0_ then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
            _ARG_0_.step = 0
          else
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        end
      end
    },
    Itusen = {
      OnBeginState = function(_ARG_0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
        Entity.SetAlpha(_ARG_0_.myHandle, 0)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle, 2)
        _UPVALUE2_:set(0, 0, 0)
        Entity.SetEffect(_ARG_0_.myHandle, _UPVALUE3_, "B015_ISS_00_0", _UPVALUE1_, _UPVALUE2_)
        _ARG_0_.step = 0
        _ARG_0_.count = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, 10)
            Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
            Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
            Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
            Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
            _ARG_0_:WarpToTargetBack()
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle, 2)
          _UPVALUE2_:set(0, 0, 0)
          Entity.SetEffect(_ARG_0_.myHandle, _UPVALUE3_, "B015_ISS_01_0", _UPVALUE1_, _UPVALUE2_)
          _ARG_0_.step = 2
        else
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        end
      end
    },
    Oboro = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
            _ARG_0_.step = 1
          end
        else
          if _UPVALUE1_[_ARG_0_.step] ~= nil and _UPVALUE1_[_ARG_0_.step] <= Entity.GetMotionNowFrame(_ARG_0_.myHandle) then
            _ARG_0_:CreateLightBall()
            _ARG_0_.step = _ARG_0_.step + 1
          end
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        end
      end
    },
    Kasumi = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 2.5)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 50 then
            Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
            for _FORV_5_ = 0, 315, 45 do
              _ARG_0_.keyBladeHandle[1] = _ARG_0_:CreateKasumiKeyBlade((RoundPI(DegToRad(_FORV_5_))))
              if EntityManager:GetEntity(_ARG_0_.keyBladeHandle[1]) ~= nil then
                EntityManager:GetEntity(_ARG_0_.keyBladeHandle[1]).plusminus = _UPVALUE0_[1]
              end
            end
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 2.5)
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 20 then
            for _FORV_4_, _FORV_5_ in pairs(_ARG_0_.keyBladeHandle) do
              if EntityManager:GetEntity(_FORV_5_) ~= nil then
                EntityManager:GetEntity(_FORV_5_):Fire(_ARG_0_.targetHandle)
              end
            end
            _ARG_0_.step = 3
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Nichirin = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        _UPVALUE1_:set(0.25, 0.25, 0.25)
        Enemy.SetSceneColor(_UPVALUE1_, 30)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        _UPVALUE0_:set(1, 1, 1)
        Enemy.SetSceneColor(_UPVALUE0_, 30)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 53 then
            Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
            for _FORV_5_ = 0, 315, 45 do
              _ARG_0_.keyBladeHandle[1] = _ARG_0_:CreateNichirinKeyBlade((RoundPI(DegToRad(_FORV_5_))))
            end
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 25 then
            for _FORV_5_, _FORV_6_ in pairs(_ARG_0_.keyBladeHandle) do
              if EntityManager:GetEntity(_FORV_6_) ~= nil then
                EntityManager:GetEntity(_FORV_6_):Fire(-1)
              end
            end
            _ARG_0_.step = 3
          end
        elseif _ARG_0_.step == 3 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 160 then
            for _FORV_4_, _FORV_5_ in pairs(_ARG_0_.keyBladeHandle) do
              if EntityManager:GetEntity(_FORV_5_) ~= nil then
                EntityManager:GetEntity(_FORV_5_):Stop()
              end
            end
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
            _ARG_0_.step = 4
          end
        elseif Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Guren = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        _UPVALUE1_:set(0.25, 0.25, 0.25)
        Enemy.SetSceneColor(_UPVALUE1_, 30)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        _UPVALUE0_:set(1, 1, 1)
        Enemy.SetSceneColor(_UPVALUE0_, 30)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 50 then
            _ARG_0_.keyBladeHandle[1] = _ARG_0_:CreateGurenKeyBlade(DegToRad(0))
            _ARG_0_.keyBladeHandle[2] = _ARG_0_:CreateGurenKeyBlade(DegToRad(120))
            _ARG_0_.keyBladeHandle[3] = _ARG_0_:CreateGurenKeyBlade(DegToRad(240))
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 90 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) <= 110 then
            for _FORV_5_ = 1, 3 do
              Entity.GetRot(_UPVALUE0_, _ARG_0_.keyBladeHandle[_FORV_5_])
              _UPVALUE0_:setx(_UPVALUE0_:getx() + DegToRad(1.125 * Entity.GetFrameRate(_ARG_0_.keyBladeHandle[_FORV_5_])))
              Entity.SetRot(_ARG_0_.keyBladeHandle[_FORV_5_], _UPVALUE0_)
            end
          end
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 117 then
            Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
            for _FORV_5_ = 1, 3 do
              if EntityManager:GetEntity(_ARG_0_.keyBladeHandle[_FORV_5_]) ~= nil then
                EntityManager:GetEntity(_ARG_0_.keyBladeHandle[_FORV_5_]):Fire(_ARG_0_.targetHandle)
              end
            end
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE2_)
            _ARG_0_.step = 3
          end
        elseif Entity.IsTimeOver(_ARG_0_.myHandle) then
          for _FORV_4_ = 1, 3 do
            if EntityManager:GetEntity(_ARG_0_.keyBladeHandle[_FORV_4_]) ~= nil then
              EntityManager:GetEntity(_ARG_0_.keyBladeHandle[_FORV_4_]):Stop(_ARG_0_.targetHandle)
            end
          end
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Kagerou = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
        if _ARG_0_.step == 0 then
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) * 0.5)
          _ARG_0_.step = 1
        elseif _ARG_0_.step == 1 then
          Entity.ClearSpeed(_ARG_0_.myHandle)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 20 then
            Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
            _ARG_0_.step = 2
          end
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Guard = {
      OnBeginState = function(_ARG_0_)
        Entity.SetRot(_ARG_0_.myHandle, 0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle), 0)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.EnableGuard(_ARG_0_.myHandle, 1)
        _ARG_0_.dmgCount = 0
        if _ARG_0_.stack:get(1) == "Kagerou" then
          _ARG_0_.step = 0
        else
          _ARG_0_.step = 1
        end
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableGuard(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 9 then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
            return
          end
        elseif _ARG_0_.step == 1 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 25 then
          Entity.EnableGuard(_ARG_0_.myHandle, 0)
          _ARG_0_.step = 2
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
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
            Sound.PlayVoice(107, 16, 1, _UPVALUE0_, SE_OPT_ALWAYS)
            _ARG_0_.step = 2
          end
        end
      end
    }
  },
  RestHpRate = function(_ARG_0_)
    if Script.GetDebugTestParam() <= 0 then
      return Enemy.GetHp(_ARG_0_.myHandle) / Enemy.GetHpMax(_ARG_0_.myHandle)
    else
      return 0
    end
  end,
  SelectAttack = function(_ARG_0_)
    _ARG_0_.idlingTimer = _UPVALUE0_
    if _ARG_0_:RestHpRate() > _UPVALUE1_ then
      if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE2_ then
        _ARG_0_.stack:push("Wander")
        if Script.Random() < 0.6 then
          _ARG_0_.stack:push("Idling")
          _ARG_0_.stack:push("SuccessionAttack")
        elseif Script.Random() >= 0.6 and Script.Random() < 0.8 then
          _ARG_0_.stack:push("Idling")
          _ARG_0_.stack:push("RushAttack")
        else
          _ARG_0_.stack:push("Flee")
        end
      elseif Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) >= _UPVALUE2_ and Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE3_ then
        _ARG_0_.stack:push("Wander")
        if Script.Random() < 0.3 then
          _ARG_0_.stack:push("Idling")
          _ARG_0_.stack:push("RushAttack")
        elseif Script.Random() >= 0.3 and Script.Random() < 0.6 then
          _ARG_0_.stack:push("Idling")
          _ARG_0_.stack:push("Oboro")
        elseif Script.Random() >= 0.6 and Script.Random() < 0.9 then
          _ARG_0_.stack:push("Idling")
          _ARG_0_.stack:push("Kasumi")
          _ARG_0_.stack:push("MoveToCenter")
        else
          _ARG_0_.stack:push("TargetKeepDistanceMove")
        end
      else
        return false
      end
    elseif Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE2_ then
      _ARG_0_.stack:push("Wander")
      if Script.Random() < 0.4 then
        _ARG_0_.stack:push("Idling")
        _ARG_0_.stack:push("SuccessionAttack")
      elseif Script.Random() >= 0.4 and Script.Random() < 0.9 then
        _ARG_0_.stack:push("Idling")
        _ARG_0_.stack:push("RushAttack")
      else
        _ARG_0_.stack:push("Flee")
      end
    elseif Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) >= _UPVALUE2_ and Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE3_ then
      _ARG_0_.stack:push("Wander")
      if Script.Random() < 0.2 then
        _ARG_0_.stack:push("Flee")
        _ARG_0_.stack:push("Idling")
        _ARG_0_.stack:push("Itusen")
        _ARG_0_.stack:push("Oboro")
      elseif Script.Random() >= 0.2 and Script.Random() < 0.55 then
        _ARG_0_.stack:push("Idling")
        _ARG_0_.stack:push("Nichirin")
        _ARG_0_.stack:push("MoveToCenter")
      elseif Script.Random() >= 0.55 and Script.Random() < 0.9 then
        _ARG_0_.stack:push("Idling")
        _ARG_0_.stack:push("Guren")
        _ARG_0_.stack:push("MoveToCenter")
      else
        _ARG_0_.stack:push("TargetKeepDistanceMove")
      end
    elseif Script.Random() < 0.5 then
      _ARG_0_.stack:push("Wander")
      _ARG_0_.stack:push("Flee")
      _ARG_0_.stack:push("Idling")
      _ARG_0_.stack:push("Itusen")
    else
      return false
    end
    return true
  end,
  Defense = function(_ARG_0_)
    if _ARG_0_.defenseTimer > 0 then
      _ARG_0_.defenseTimer = _ARG_0_.defenseTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
      return false
    end
    if _ARG_0_.defenseFlag == false then
      if Entity.IsAttacking(_ARG_0_.targetHandle) then
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE0_ then
          _ARG_0_.defenseFlag = true
          _ARG_0_.defenseTimer = _UPVALUE1_
        else
          Entity.SetTimer(_ARG_0_.myHandle, 0)
          return false
        end
      end
    else
      if Script.Random() < 0.25 and _ARG_0_:SelectAttack() then
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        return true
      end
      _ARG_0_.stack:push("Wander")
      if Script.Random() < 0.5 then
        _ARG_0_.stack:push("Kagerou")
      end
      _ARG_0_:GotoState("Guard")
      return true
    end
    return false
  end,
  WarpToTargetBack = function(_ARG_0_)
    Entity.GetDir(_UPVALUE0_, _ARG_0_.targetHandle)
    _UPVALUE0_:scale(-0.5)
    Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.targetHandle)
    _UPVALUE2_:copy(_UPVALUE1_)
    _UPVALUE1_:sety(_UPVALUE1_:gety() + 0.5)
    _UPVALUE2_:sety(_UPVALUE2_:gety() - 25)
    Collision.IntersectRayBg(_UPVALUE3_, COLL_KIND_ENEMY, _UPVALUE1_, _UPVALUE2_)
    _UPVALUE1_:sety(_UPVALUE3_:gety())
    FVECTOR3.Add(_UPVALUE0_, _UPVALUE0_, _UPVALUE1_)
    Collision.IntersectRayBg(_UPVALUE0_, COLL_KIND_ENEMY, _UPVALUE1_, _UPVALUE0_)
    Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE0_)
    Entity.SetOldLocalPos(_ARG_0_.myHandle, _UPVALUE0_)
    FVECTOR3.Sub(_UPVALUE0_, _UPVALUE1_, _UPVALUE0_)
    Entity.SetRot(_ARG_0_.myHandle, 0, Math.Atan2(_UPVALUE0_:getx(), _UPVALUE0_:getz()), 0)
  end,
  CreateLightBall = function(_ARG_0_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 66)
    Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
    SetBulletAttackParam(Bullet.CreateBullet("b20exLB", _UPVALUE0_, _UPVALUE1_), _ARG_0_.myHandle, 3)
    if EntityManager:GetEntity((Bullet.CreateBullet("b20exLB", _UPVALUE0_, _UPVALUE1_))) ~= nil then
      EntityManager:GetEntity((Bullet.CreateBullet("b20exLB", _UPVALUE0_, _UPVALUE1_))).targetHandle = _ARG_0_.targetHandle
    end
    return (Bullet.CreateBullet("b20exLB", _UPVALUE0_, _UPVALUE1_))
  end,
  CreateKasumiKeyBlade = function(_ARG_0_, _ARG_1_)
    _UPVALUE0_:set(0, _UPVALUE1_, _UPVALUE2_)
    _UPVALUE3_:set(0, _ARG_1_, 0)
    Math.RotateVectorXYZ(_UPVALUE0_, _UPVALUE3_)
    Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "Root", _UPVALUE0_)
    Entity.GetRot(_UPVALUE3_, _ARG_0_.myHandle)
    _UPVALUE3_:sety(RoundPI(_UPVALUE3_:gety() + _ARG_1_))
    SetBulletAttackParam(Bullet.CreateBullet("b20exKKB", _UPVALUE0_, _UPVALUE3_), _ARG_0_.myHandle, 4)
    if EntityManager:GetEntity((Bullet.CreateBullet("b20exKKB", _UPVALUE0_, _UPVALUE3_))) ~= nil then
      EntityManager:GetEntity((Bullet.CreateBullet("b20exKKB", _UPVALUE0_, _UPVALUE3_))).theta = _ARG_1_
    end
    return (Bullet.CreateBullet("b20exKKB", _UPVALUE0_, _UPVALUE3_))
  end,
  CreateNichirinKeyBlade = function(_ARG_0_, _ARG_1_)
    _UPVALUE0_:set(0, _UPVALUE1_, _UPVALUE2_)
    _UPVALUE3_:set(0, _ARG_1_, 0)
    Math.RotateVectorXYZ(_UPVALUE0_, _UPVALUE3_)
    Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "Root", _UPVALUE0_)
    Entity.GetRot(_UPVALUE3_, _ARG_0_.myHandle)
    _UPVALUE3_:sety(RoundPI(_UPVALUE3_:gety() + _ARG_1_))
    SetBulletAttackParam(Bullet.CreateBullet("b20exNKB", _UPVALUE0_, _UPVALUE3_), _ARG_0_.myHandle, 5)
    if EntityManager:GetEntity((Bullet.CreateBullet("b20exNKB", _UPVALUE0_, _UPVALUE3_))) ~= nil then
      EntityManager:GetEntity((Bullet.CreateBullet("b20exNKB", _UPVALUE0_, _UPVALUE3_))).theta = _ARG_1_
    end
    return (Bullet.CreateBullet("b20exNKB", _UPVALUE0_, _UPVALUE3_))
  end,
  CreateGurenKeyBlade = function(_ARG_0_, _ARG_1_)
    _UPVALUE0_:set(Math.Cos((RoundPI(_ARG_1_ + PI * 0.5))) * _UPVALUE1_, _UPVALUE2_, Math.Sin((RoundPI(_ARG_1_ + PI * 0.5))) * _UPVALUE1_)
    Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "Root", _UPVALUE0_)
    Entity.GetRot(_UPVALUE3_, _ARG_0_.myHandle)
    _UPVALUE3_:sety(RoundPI(_UPVALUE3_:gety() - _ARG_1_))
    SetBulletAttackParam(Bullet.CreateBullet("b20exGKB", _UPVALUE0_, _UPVALUE3_), _ARG_0_.myHandle, 6)
    return (Bullet.CreateBullet("b20exGKB", _UPVALUE0_, _UPVALUE3_))
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
  OnInit = function(_ARG_0_, _ARG_1_)
    _UPVALUE0_ = Entity.GetMotionIndex(_ARG_1_, "010")
    _UPVALUE1_ = Entity.GetMotionIndex(_ARG_1_, "030")
    _UPVALUE2_ = Entity.GetMotionIndex(_ARG_1_, "031")
    _UPVALUE3_ = Entity.GetMotionIndex(_ARG_1_, "032")
    _UPVALUE4_ = Entity.GetMotionIndex(_ARG_1_, "033")
    _UPVALUE5_ = Entity.GetMotionIndex(_ARG_1_, "040")
    _UPVALUE6_ = Entity.GetMotionIndex(_ARG_1_, "041")
    _UPVALUE7_ = Entity.GetMotionIndex(_ARG_1_, "042")
    _UPVALUE8_ = Entity.GetMotionIndex(_ARG_1_, "300")
    _UPVALUE9_ = Entity.GetMotionIndex(_ARG_1_, "310")
    _UPVALUE10_ = Entity.GetMotionIndex(_ARG_1_, "320")
    _UPVALUE11_ = Entity.GetMotionIndex(_ARG_1_, "330")
    _UPVALUE12_ = Entity.GetMotionIndex(_ARG_1_, "331")
    _UPVALUE13_ = Entity.GetMotionIndex(_ARG_1_, "340")
    _UPVALUE14_ = Entity.GetMotionIndex(_ARG_1_, "341")
    _UPVALUE15_ = Entity.GetMotionIndex(_ARG_1_, "350")
    _UPVALUE16_ = Entity.GetMotionIndex(_ARG_1_, "351")
    _UPVALUE17_ = Entity.GetMotionIndex(_ARG_1_, "360")
    _UPVALUE18_ = Entity.GetMotionIndex(_ARG_1_, "370")
    _UPVALUE19_ = Entity.GetMotionIndex(_ARG_1_, "410")
    _UPVALUE20_ = Enemy.GetExtraParam(_ARG_1_, "NIC_ROT_SPD")
    _UPVALUE21_ = Enemy.GetExtraParam(_ARG_1_, "OBR_SPD")
    _UPVALUE22_ = Enemy.GetExtraParam(_ARG_1_, "OBR_HOMING")
    _UPVALUE23_ = Enemy.GetExtraParam(_ARG_1_, "COUNTERRATE") / 100
    _UPVALUE24_ = Enemy.GetExtraParam(_ARG_1_, "KSM_SPD")
    _UPVALUE25_ = Enemy.GetExtraParam(_ARG_1_, "KSM_HOMING")
    _UPVALUE26_ = Enemy.GetExtraParam(_ARG_1_, "KSM_HM_TIME") * 60
    _UPVALUE27_ = Enemy.GetExtraParam(_ARG_1_, "GRN_SPD")
    _UPVALUE28_ = Enemy.GetExtraParam(_ARG_1_, "GRN_HOMING")
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.targetHandle = NULL_HANDLE
    _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
    _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
    _ARG_0_.step = 0
    _ARG_0_.oldTargetDist = 0
    _ARG_0_.idlingTimer = _UPVALUE29_
    _ARG_0_.walkTimer = 0
    _ARG_0_.timer = 0
    _ARG_0_.count = 0
    _ARG_0_.dmgCount = 0
    _ARG_0_.keyBladeHandle = {
      NULL_HANDLE,
      NULL_HANDLE,
      NULL_HANDLE,
      NULL_HANDLE,
      NULL_HANDLE,
      NULL_HANDLE,
      NULL_HANDLE,
      NULL_HANDLE
    }
    _ARG_0_.defenseFlag = false
    _ARG_0_.defenseTimer = 0
    _ARG_0_.rotTimer = 0
    _ARG_0_.reflect = false
    _ARG_0_.stack = Stack:Create()
    Entity.EnableGuardPhysical(_ARG_1_, 1)
    Entity.EnableGuardFire(_ARG_1_, 1)
    Entity.EnableGuardIce(_ARG_1_, 1)
    Entity.EnableGuardThunder(_ARG_1_, 1)
    Entity.EnableGuardSpecial(_ARG_1_, 1)
    Entity.SetGuardDir(_ARG_1_, 180)
    Entity.EnableGravity(_ARG_1_, 1)
    Player.SetBossCamera("b20ex")
    _ARG_0_:GotoState("Appear")
  end,
  OnSetMotion = function(_ARG_0_, _ARG_1_)
  end,
  OnReturnDamage = function(_ARG_0_)
    if _ARG_0_.reflect == false then
      if _ARG_0_:GetState() ~= nil then
        _ARG_0_:GotoState((_ARG_0_:GetState()))
        return
      end
    else
      _ARG_0_.reflect = false
    end
    _ARG_0_.stack:push("Wander")
    _ARG_0_:GotoState("Idling")
  end,
  OnHitAttack = function(_ARG_0_)
  end,
  OnDamageBefore = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    _ARG_0_.idlingTimer = 0
    _ARG_0_.dmgCount = _ARG_0_.dmgCount + 1
    if Enemy.IsNoDamageReaction(_ARG_0_.myHandle) then
      return 0
    end
    if COMMAND_CATEGORY_SHOOTLOCK == _ARG_2_ and Script.Random() < 0.5 then
      _ARG_0_.stack:push("Wander")
      _ARG_0_.stack:push("Idling")
      _ARG_0_:GotoState("Guard")
      return 1
    end
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE0_ then
      if Script.Random() < _UPVALUE1_ * _ARG_0_.dmgCount then
        _ARG_0_.stack:push("Wander")
        _ARG_0_.stack:push("Idling")
        _ARG_0_.stack:push("Kagerou")
        _ARG_0_:GotoState("Guard")
        return 1
      end
    elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE2_ then
      if Script.Random() < 0.5 then
        _ARG_0_.stack:push("Wander")
        _ARG_0_.stack:push("Idling")
        _ARG_0_:GotoState("Guard")
        return 1
      end
    elseif Script.Random() < 0.75 then
      _ARG_0_.stack:push("Wander")
      _ARG_0_.stack:push("Idling")
      _ARG_0_:GotoState("Guard")
      return 1
    end
    return 0
  end,
  OnDamage = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    return 0
  end,
  OnGuard = function(_ARG_0_)
    Entity.GetGuardCrossPos(_UPVALUE0_, _ARG_0_.myHandle)
    _UPVALUE1_:set(0, 0, 0)
    Entity.SetEffect(_ARG_0_.myHandle, _UPVALUE2_, "b015_hjk_00_0", _UPVALUE0_, _UPVALUE1_)
  end,
  OnReflect = function(_ARG_0_)
    _ARG_0_.reflect = true
    return 0
  end,
  OnDead = function(_ARG_0_)
    SetupBossDead(_ARG_0_.myHandle)
    _ARG_0_:GotoState("Dead")
    return 1
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
        _ARG_0_.stack:clear()
        _ARG_0_.stack:push("Wander")
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        _ARG_0_:GotoState(_UPVALUE0_[Script.GetDebugAttackNumber() + 1])
      end
    end
  end
}, {__index = __StateMachine})
EntityFactory:Add("b20ex00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b20exLB", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b20exKKB", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b20exNKB", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b20exGKB", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
