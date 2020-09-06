MES_START = 1000
B40EX_MES_B40EX_ATTACK_REQUEST = MES_START + 0
B10EX_MES_B40EX_ATTACK_ACCEPT = MES_START + 1
B10EX_MES_B40EX_ATTACK_DENY = MES_START + 2
B40EX_MES_B40EX_ATTACK_END = MES_START + 4
B10EX_MES_B10EX_BLADETORNADO_START = MES_START + 5
B10EX_MES_B10EX_BLADETORNADO_END = MES_START + 6
setmetatable({
  new = function(_ARG_0_)
    return setmetatable(__StateMachine:new(), _UPVALUE0_)
  end,
  states = {
    Appear = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_:SetMotion(_UPVALUE0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        _ARG_0_.Step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.Step == 0 then
          if Entity.HasLayoutData(_ARG_0_.myHandle) then
            print("GAME\n")
          else
            print("ENEMY_TEST\n")
            if nandle ~= NULL_HANDLE then
              Entity.Out((Enemy.SearchEnemy(_ARG_0_.myHandle, "b10ex01", SEARCH_TYPE_NEAR)))
            end
          end
          if 1 == 1 then
            print(" with Vanitus!\n")
            _ARG_0_.Step = 2
          else
            print(" without Vanitus\n")
            _ARG_0_.Vanitus = NULL_HANDLE
            _ARG_0_:CreateKeyBlades()
            EnableVanitusKeyBladeLeaderDispOn(_ARG_0_.keybladeHandle[1], false)
            _ARG_0_.Step = 10
          end
        elseif _ARG_0_.Step == 2 then
          _ARG_0_.Vanitus = Enemy.SearchEnemy(_ARG_0_.myHandle, "b10ex01", SEARCH_TYPE_NEAR)
          if _ARG_0_.Vanitus == NULL_HANDLE then
            _ARG_0_.Vanitus = Enemy.SearchEnemy(_ARG_0_.myHandle, "b10ex00", SEARCH_TYPE_NEAR)
          end
          if _ARG_0_.Vanitus ~= NULL_HANDLE then
            _ARG_0_.phase = 100
            _ARG_0_.DamageWarpParam = 102
            _ARG_0_.Step = 10
          else
            print("search Vanitus\n")
          end
        elseif Enemy.IsAllEnemyWaiting() == false then
          if _ARG_0_.phase == 100 then
            _ARG_0_.StateParam = 101
            _ARG_0_:GotoState("Warp")
          else
            _ARG_0_.StateParam = 0
            _ARG_0_:GotoState("Move")
          end
        end
      end
    },
    Idling = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_.IsYoin = true
        _ARG_0_:SetReturnState("Idling", 0)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE0_ then
          if _ARG_0_.StateParam == 1 or _ARG_0_.StateParam == 3 or _ARG_0_.StateParam == 4 then
            Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE1_)
            print("Battle Idling " .. _ARG_0_.StateParam .. "\n")
          else
            Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE2_)
            print("Idling " .. _ARG_0_.StateParam .. "\n")
          end
          _ARG_0_.SubStep = 0
        else
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE3_)
          _ARG_0_.SubStep = 1
        end
        if _ARG_0_.StateParam == 0 then
        else
        end
        if 0 < _ARG_0_.IdlingTimer then
          _ARG_0_.IdlingTimer = 0
        end
        Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_.IdlingTimer)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        if Script.Random() <= 0.1 then
          _ARG_0_:PlayVoice(27)
        elseif Script.Random() <= 0.2 then
          _ARG_0_:PlayVoice(28)
        end
        _ARG_0_.Step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        Enemy.GetTargetLastRecordedPos(_UPVALUE0_, _ARG_0_.myHandle, _ARG_0_.targetHandle)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE0_, _UPVALUE1_)
        if _ARG_0_.phase < 100 then
          if _ARG_0_.SubStep == 0 then
            if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) >= _UPVALUE2_ then
              _ARG_0_:SetMotion(_UPVALUE3_)
              _ARG_0_.SubStep = 1
            end
          else
            Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE4_)
            if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE5_ then
              if _ARG_0_.StateParam == 1 or _ARG_0_.StateParam == 3 or _ARG_0_.StateParam == 4 then
                Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE6_)
              else
                Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE7_)
              end
              Entity.ClearSpeed(_ARG_0_.myHandle)
              _ARG_0_.SubStep = 0
            end
          end
        end
        if _ARG_0_.Step == 0 then
          if _ARG_0_.StateParam == 101 and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE8_ then
            if Script.Random() <= 0.5 then
              _ARG_0_.StateParam = 101
              _ARG_0_:GotoState("Warp")
            else
              _ARG_0_:StartAttackPattern(1, 101)
            end
          end
          if Entity.IsTimeOver(_ARG_0_.myHandle) == true then
            if _ARG_0_.StateParam == 0 or _ARG_0_.StateParam == 4 then
              if _ARG_0_.phase == 0 then
                print("HP racio = " .. Enemy.GetHp(_ARG_0_.myHandle) / Enemy.GetHpMax(_ARG_0_.myHandle) .. "\n")
                if Enemy.GetHp(_ARG_0_.myHandle) / Enemy.GetHpMax(_ARG_0_.myHandle) < _UPVALUE9_ then
                  _ARG_0_.phase = 1
                end
              end
              _ARG_0_.StateParam = 0
              _ARG_0_:GotoState("Move")
            elseif _ARG_0_.StateParam == 1 then
              if Script.Random() <= _UPVALUE10_ then
                _ARG_0_.StateParam = 2
                _ARG_0_:GotoState("Warp")
              else
                _ARG_0_.StateParam = 3
                _ARG_0_:GotoState("Warp")
              end
            elseif _ARG_0_.StateParam == 2 then
              if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE11_ then
                if _ARG_0_.phase == 0 then
                  _ARG_0_:StartAttackPattern(1, 1)
                else
                  _ARG_0_:StartAttackPattern(5, 0)
                end
              else
                _ARG_0_.StateParam = 5
                _ARG_0_:GotoState("Warp")
              end
            elseif _ARG_0_.StateParam == 3 then
              if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE8_ then
                _ARG_0_.StateParam = 4
                _ARG_0_:GotoState("Warp")
              else
                _ARG_0_.StateParam = 0
                _ARG_0_:GotoState("Idling")
              end
            elseif _ARG_0_.StateParam == 101 then
              if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE8_ then
                if Script.Random() <= 0.5 then
                  _ARG_0_.StateParam = 101
                  _ARG_0_:GotoState("Warp")
                else
                  _ARG_0_:StartAttackPattern(1, 101)
                end
              else
                _ARG_0_.AttackAccept = false
                print("Attack Request \n")
                Enemy.SendMessage(0, _ARG_0_.myHandle, _ARG_0_.Vanitus, B40EX_MES_B40EX_ATTACK_REQUEST)
                _ARG_0_.Step = 10
              end
            elseif _ARG_0_.StateParam == 102 then
              _ARG_0_.StateParam = 101
              _ARG_0_:GotoState("Warp")
            else
              _ARG_0_:DbgResetState()
            end
          end
        elseif _ARG_0_.AttackAccept then
          if Script.Random() <= 0.6 then
            Enemy.SendMessage(0, _ARG_0_.myHandle, _ARG_0_.Vanitus, B40EX_MES_B40EX_ATTACK_END)
            print("->No ATTACK accept!!\n")
            _ARG_0_.StateParam = 101
            _ARG_0_:GotoState("Idling")
          elseif Script.Random() <= 0.8 then
            _ARG_0_.StateParam = 102
            _ARG_0_:GotoState("Warp")
          else
            _ARG_0_:StartAttackPattern(2, 101)
          end
        else
          _ARG_0_.StateParam = 101
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    Move = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_:SetReturnState()
        _ARG_0_.IsYoin = true
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, Script.Random() * _UPVALUE1_ + _UPVALUE2_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        print("Move\n")
      end,
      OnEndState = function(_ARG_0_)
        print("Move end\n")
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        Enemy.GetTargetLastRecordedPos(_UPVALUE0_, _ARG_0_.myHandle, _ARG_0_.targetHandle)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE0_, _UPVALUE1_)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE2_)
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE3_ or Entity.IsTimeOver(_ARG_0_.myHandle) then
          print("rnd " .. Script.Random() .. "\n")
          if _ARG_0_.phase == 1 then
            if Script.Random() <= 0.5 then
              if true then
                _ARG_0_:StartAttackPattern(4, 0)
              else
                _ARG_0_.StateParam = 1
                _ARG_0_:GotoState("Warp")
              end
            elseif Script.Random() <= 0.875 or _ARG_0_.isBladeTornadoBusy then
              if true then
                _ARG_0_.StateParam = 8
                _ARG_0_:GotoState("Warp")
              else
                _ARG_0_:StartAttackPattern(2, 2)
              end
            else
              _ARG_0_.StateParam = 6
              _ARG_0_:GotoState("Warp")
            end
          elseif Script.Random() <= _UPVALUE4_ then
            if true then
              _ARG_0_:StartAttackPattern(1, 0)
            else
              _ARG_0_.StateParam = 1
              _ARG_0_:GotoState("Warp")
            end
          elseif Script.Random() <= _UPVALUE5_ or _ARG_0_.isBladeTornadoBusy then
            if true then
              _ARG_0_.StateParam = 8
              _ARG_0_:GotoState("Warp")
            else
              _ARG_0_:StartAttackPattern(2, 0)
            end
          else
            _ARG_0_.StateParam = 6
            _ARG_0_:GotoState("Warp")
          end
        end
      end
    },
    Warp = {
      OnBeginState = function(_ARG_0_)
        print("Warp " .. _ARG_0_.StateParam .. "\n")
        _ARG_0_.IsYoin = true
        _ARG_0_.Step = 0
        if _ARG_0_.StateParam == 1 then
          _ARG_0_.WarpTarget = 0
        elseif _ARG_0_.StateParam == 2 then
          _ARG_0_.WarpTarget = 1
        elseif _ARG_0_.StateParam == 3 then
          _ARG_0_.WarpTarget = 2
        elseif _ARG_0_.StateParam == 4 then
          _ARG_0_.WarpTarget = 1
        elseif _ARG_0_.StateParam == 5 then
          _ARG_0_.WarpTarget = 5
        elseif _ARG_0_.StateParam == 6 then
          _ARG_0_.WarpTarget = 2
        elseif _ARG_0_.StateParam == 7 then
          _ARG_0_.WarpTarget = 1
        elseif _ARG_0_.StateParam == 8 then
          _ARG_0_.WarpTarget = 1
        elseif _ARG_0_.StateParam == 101 then
          _ARG_0_.WarpTarget = 1
        else
          if _ARG_0_.StateParam == 102 then
            _ARG_0_.WarpTarget = 0
          else
          end
        end
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
        if not _ARG_0_:IsQuickWarping() then
          _ARG_0_:Hide()
          Entity.AttachEffect(_ARG_0_.myHandle, _UPVALUE1_, "B25_WRP_LST0_0", "hara", _UPVALUE2_, _UPVALUE2_)
        end
      end,
      OnEndState = function(_ARG_0_)
        if not _ARG_0_:IsQuickWarping() then
          _ARG_0_:Show()
        end
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.Step == 0 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:WarpToTarget()
            if not _ARG_0_:IsQuickWarping() then
              Entity.AttachEffect(_ARG_0_.myHandle, _UPVALUE0_, "B25_WRP_APP0_0", "hara", _UPVALUE1_, _UPVALUE1_)
            end
            Entity.SetTimer(_ARG_0_.myHandle, 10)
            _ARG_0_.Step = 10
          end
        elseif Entity.IsTimeOver(_ARG_0_.myHandle) then
          if _ARG_0_.StateParam == 1 then
            if _ARG_0_.phase == 0 then
              _ARG_0_:StartAttackPattern(1, 0)
            else
              _ARG_0_:StartAttackPattern(4, 0)
            end
          elseif _ARG_0_.StateParam == 2 then
            _ARG_0_:StartAttackPattern(2, 1)
          elseif _ARG_0_.StateParam == 3 then
            _ARG_0_:StartAttackPattern(3, 1)
          elseif _ARG_0_.StateParam == 4 then
            _ARG_0_.StateParam = 4
            _ARG_0_:GotoState("Idling")
          elseif _ARG_0_.StateParam == 5 then
            if _ARG_0_.phase == 0 then
              _ARG_0_:StartAttackPattern(1, 1)
            else
              _ARG_0_:StartAttackPattern(5, 0)
            end
          elseif _ARG_0_.StateParam == 6 then
            _ARG_0_:StartAttackPattern(3, 0)
          elseif _ARG_0_.StateParam == 7 then
            _ARG_0_.StateParam = 1
            _ARG_0_:GotoState("BladeTornado")
          elseif _ARG_0_.StateParam == 8 then
            if _ARG_0_.phase == 0 then
              _ARG_0_:StartAttackPattern(2, 0)
            else
              _ARG_0_:StartAttackPattern(2, 2)
            end
          elseif _ARG_0_.StateParam == 101 then
            _ARG_0_.StateParam = 101
            _ARG_0_:GotoState("Idling")
          elseif _ARG_0_.StateParam == 102 then
            _ARG_0_:StartAttackPattern(1, 102)
          elseif _ARG_0_.StateParam == 100 then
            _ARG_0_:ReturnState()
          else
            _ARG_0_:DbgResetState()
          end
        end
      end
    },
    Attack0 = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_:SetMotion(_UPVALUE0_)
        print("Attack0\n")
        if _ARG_0_.AttackPattern == 4 then
          _ARG_0_.IsYoin = false
        else
          _ARG_0_.IsYoin = false
        end
        _ARG_0_.lastDamageKind = -1
        _ARG_0_.Step = 0
        _ARG_0_.SubStep = 0
      end,
      OnEndState = function(_ARG_0_)
        print("End--Attack0\n")
        if not _ARG_0_:IsQuickWarping() then
          _ARG_0_:Show()
        end
        Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:WarpAttackSub()
        Enemy.GetTargetLastRecordedPos(_UPVALUE0_, _ARG_0_.myHandle, _ARG_0_.targetHandle)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE0_, 5)
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 55 or Entity.IsMotionEnd(_ARG_0_.myHandle) then
          if _ARG_0_.AttackPattern ~= 5 then
            _ARG_0_.IsYoin = true
            _ARG_0_:EndAttackPattern()
          elseif _ARG_0_.lastDamageKind == 3 and Player.IsBanishOn(_ARG_0_.targetHandle) == false then
            _ARG_0_.StateParam = 0
            _ARG_0_:GotoState("UltimateFreeze")
          else
            _ARG_0_:EndAttackPattern()
          end
        end
      end
    },
    Attack1 = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_:SetMotion(_UPVALUE0_)
        print("Attack1\n")
        if _ARG_0_.AttackPattern == 4 then
          _ARG_0_.IsYoin = false
        else
          _ARG_0_.IsYoin = false
        end
        _ARG_0_.Step = 0
        _ARG_0_.SubStep = 0
      end,
      OnEndState = function(_ARG_0_)
        print("End--Attack1\n")
        if not _ARG_0_:IsQuickWarping() then
          _ARG_0_:Show()
        end
        Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:WarpAttackSub()
        Enemy.GetTargetLastRecordedPos(_UPVALUE0_, _ARG_0_.myHandle, _ARG_0_.targetHandle)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE0_, 5)
        if _ARG_0_.Step == 0 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 34 then
          Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 51)
          Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
          _ARG_0_.bltHandle0 = Bullet.CreateBullet("freeze", _UPVALUE0_, _UPVALUE1_)
          if EntityManager:GetEntity(_ARG_0_.bltHandle0) ~= nil then
            EntityManager:GetEntity(_ARG_0_.bltHandle0).targetHandle = _ARG_0_.targetHandle
          end
          SetBulletAttackParam(_ARG_0_.bltHandle0, _ARG_0_.myHandle, 2)
          _ARG_0_.Step = 10
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.IsYoin = true
          _ARG_0_:EndAttackPattern()
        end
      end
    },
    RisingGround = {
      OnBeginState = function(_ARG_0_)
        print("RisingGround\n")
        _ARG_0_.IsYoin = false
        _ARG_0_:SetMotion(_UPVALUE0_)
        _ARG_0_.nextMotionCheck = true
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        CalcWarpPosition(_ARG_0_.targetHandle, nil, 1.5, (-0.5 + Script.Random()) * 3.14, 3, _ARG_0_.myHandle)
        if EntityManager:GetEntity((Bullet.CreateBullet("risingGround", _UPVALUE2_, _UPVALUE3_))) ~= nil then
          EntityManager:GetEntity((Bullet.CreateBullet("risingGround", _UPVALUE2_, _UPVALUE3_))).targetHandle = _ARG_0_.targetHandle
        end
        SetBulletAttackParam(Bullet.CreateBullet("risingGround", _UPVALUE2_, _UPVALUE3_), _ARG_0_.myHandle, 4)
        _ARG_0_.Step = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          if _ARG_0_.Step == 0 then
            _ARG_0_.IsYoin = true
            Entity.SetTimer(_ARG_0_.myHandle, 200 - _UPVALUE0_)
            _ARG_0_.Step = 10
          else
            _ARG_0_:EndAttackPattern()
          end
        end
        if _ARG_0_.nextMotionCheck then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            if _ARG_0_.AttackParam == 0 then
              _ARG_0_:SetMotion(_UPVALUE1_)
            else
              _ARG_0_:SetMotion(_UPVALUE2_)
            end
            _ARG_0_.nextMotionCheck = false
          end
        else
          _ARG_0_:SearchPlayer()
        end
      end
    },
    BladeTornado = {
      OnBeginState = function(_ARG_0_)
        if _ARG_0_.StateParam == 0 then
          print("BladeTornado\n")
          _ARG_0_.IsYoin = false
          if Script.IsDebugCheckAttack() then
            _ARG_0_.WarpTarget = 2
            _ARG_0_:WarpToTarget()
          end
          if _ARG_0_.keybladeHandle[1] == NULL_HANDLE then
            _ARG_0_.Step = 100
          else
            _ARG_0_.Step = 0
          end
          Entity.SetTimer(_ARG_0_.myHandle, 150)
          _ARG_0_.SubStep = 0
        else
          _ARG_0_.SubStep = 0
          _ARG_0_.nextMotionCheck = false
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
          print("BladeTornado Wait " .. _ARG_0_.SubStep .. "\n")
          if _ARG_0_.nextMotionCheck then
            print("--nextMotionCheck on\n")
          end
          _ARG_0_.Step = 100
        end
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.Step == 0 then
          if _ARG_0_.isBladeTornadoBusy then
            print("BladeTornado Waiting -----\n")
            _ARG_0_.bladeTornadoTimer = 10
            Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
            if Entity.IsTimeOver(_ARG_0_.myHandle) then
              print("timeount\n")
              _ARG_0_.Step = 100
            end
          else
            _ARG_0_:SetMotion(_UPVALUE1_)
            _ARG_0_.nextMotionCheck = true
            Entity.GetLocalPos(_UPVALUE2_, _ARG_0_.myHandle)
            Entity.GetRot(_UPVALUE3_, _ARG_0_.myHandle)
            Entity.GetDir(_UPVALUE4_, _ARG_0_.myHandle)
            _UPVALUE4_:scale(-15)
            FVECTOR3.Add(_UPVALUE2_, _UPVALUE2_, _UPVALUE4_)
            _UPVALUE3_:setx(_UPVALUE3_:getx() + 3.14 * -(0.4 - Script.Random() * 0.15))
            _UPVALUE3_:sety(_UPVALUE3_:gety() + -1.57)
            print("vec0 " .. _UPVALUE2_:getx() .. "," .. _UPVALUE2_:gety() .. "," .. _UPVALUE2_:getz() .. "\n")
            print("vec1 " .. _UPVALUE3_:getx() .. "," .. _UPVALUE3_:gety() .. "," .. _UPVALUE3_:getz() .. "\n")
            if EntityManager:GetEntity((Bullet.CreateBullet("bladeTornado", _UPVALUE2_, _UPVALUE3_))) ~= nil then
              EntityManager:GetEntity((Bullet.CreateBullet("bladeTornado", _UPVALUE2_, _UPVALUE3_))).targetHandle = _ARG_0_.targetHandle
              EntityManager:GetEntity((Bullet.CreateBullet("bladeTornado", _UPVALUE2_, _UPVALUE3_))).topHandle = _ARG_0_.keybladeHandle[1]
              EntityManager:GetEntity((Bullet.CreateBullet("bladeTornado", _UPVALUE2_, _UPVALUE3_))).parentHandle = _ARG_0_
              _ARG_0_.isBladeTornadoBusy = true
              _ARG_0_.bladeTornadoTimer = _UPVALUE5_ + _UPVALUE6_ + 30 - _UPVALUE7_
              Entity.SetLocalPos(_ARG_0_.keybladeHandle[1], _UPVALUE2_)
              Entity.SetRot(_ARG_0_.keybladeHandle[1], _UPVALUE3_)
              Entity.SetLocalPos(Bullet.CreateBullet("bladeTornado", _UPVALUE2_, _UPVALUE3_), _UPVALUE2_)
              Entity.SetRot(Bullet.CreateBullet("bladeTornado", _UPVALUE2_, _UPVALUE3_), _UPVALUE3_)
            end
            _ARG_0_.IsYoin = true
            _ARG_0_.Step = 1
          end
        end
        if 0 >= _ARG_0_.bladeTornadoTimer then
          print("bladeTornadoTimer " .. _ARG_0_.bladeTornadoTimer .. "\n")
          _ARG_0_:EndAttackPattern()
        end
        if _ARG_0_.nextMotionCheck then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE8_ then
              if _ARG_0_.AttackParam == 0 then
                _ARG_0_:SetMotion(_UPVALUE0_)
              else
                _ARG_0_:SetMotion(_UPVALUE9_)
              end
              _ARG_0_.SubStep = 0
            else
              _ARG_0_:SetMotion(_UPVALUE10_)
              _ARG_0_.SubStep = 1
            end
            _ARG_0_.nextMotionCheck = false
          end
        elseif _ARG_0_.SubStep == 0 then
          _ARG_0_:SearchPlayer()
        else
          Enemy.GetTargetLastRecordedPos(_UPVALUE2_, _ARG_0_.myHandle, _ARG_0_.targetHandle)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE2_, _UPVALUE11_)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE12_)
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE13_ then
            if _ARG_0_.AttackParam == 0 then
              _ARG_0_:SetMotion(_UPVALUE0_)
            else
              _ARG_0_:SetMotion(_UPVALUE9_)
            end
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.SubStep = 0
          end
        end
      end
    },
    Thundaga = {
      OnBeginState = function(_ARG_0_)
        print("Thundaga\n")
        _ARG_0_.IsYoin = false
        _ARG_0_:SetMotion(_UPVALUE0_)
        _ARG_0_.nextMotionCheck = true
        _ARG_0_.Step = 0
        Entity.SetTimer(_ARG_0_.myHandle, 1)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.Step < 5 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.GetLocalPos(_UPVALUE0_, _ARG_0_.targetHandle)
            if _ARG_0_.Step == 0 then
              CalcWarpPosition(_ARG_0_.targetHandle, nil, 0, nil, 1, _ARG_0_.myHandle)
            else
              CalcWarpPosition(_ARG_0_.targetHandle, nil, 2 + Script.Random(), (Script.Random() - 0.5 + _ARG_0_.Step) * 3.14 * 2 / 4, 1, _ARG_0_.myHandle)
            end
            SetBulletAttackParam(Bullet.CreateBullet("thundaga", _UPVALUE0_, _UPVALUE1_), _ARG_0_.myHandle, 6)
            _ARG_0_.Step = _ARG_0_.Step + 1
            if _ARG_0_.Step == 5 then
              _ARG_0_.IsYoin = true
              Entity.SetTimer(_ARG_0_.myHandle, 120 + _UPVALUE2_)
            else
              Entity.SetTimer(_ARG_0_.myHandle, 5)
            end
          end
        elseif Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:EndAttackPattern()
        end
        if _ARG_0_.nextMotionCheck then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            if _ARG_0_.AttackParam == 0 then
              _ARG_0_:SetMotion(_UPVALUE3_)
            else
              _ARG_0_:SetMotion(_UPVALUE4_)
            end
            _ARG_0_.nextMotionCheck = false
          end
        else
          _ARG_0_:SearchPlayer()
        end
      end
    },
    Blizzaga = {
      OnBeginState = function(_ARG_0_)
        print("Blizzaga\n")
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE1_)
        _ARG_0_.Step = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.Step == 0 then
          Enemy.GetTargetLastRecordedPos(_UPVALUE0_, _ARG_0_.myHandle, _ARG_0_.targetHandle)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE0_, _UPVALUE1_)
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_.IsYoin = false
            _ARG_0_:SetMotion(_UPVALUE2_)
            _ARG_0_.nextMotionCheck = true
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE3_)
            _ARG_0_.Step = 5
          end
        elseif _ARG_0_.Step == 5 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 13 then
            CalcWarpPosition(_ARG_0_.myHandle, nil, 10, -4.71, nil, _ARG_0_.myHandle)
            Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 51)
            _ARG_0_.bltHandle0 = Bullet.CreateBullet("blizzaga", _UPVALUE0_, _UPVALUE4_)
            if EntityManager:GetEntity(_ARG_0_.bltHandle0) ~= nil then
              EntityManager:GetEntity(_ARG_0_.bltHandle0).targetHandle = _ARG_0_.targetHandle
            end
            SetBulletAttackParam(_ARG_0_.bltHandle0, _ARG_0_.myHandle, 7)
            CalcWarpPosition(_ARG_0_.myHandle, nil, 10, 4.71, nil, _ARG_0_.myHandle)
            Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 51)
            _ARG_0_.bltHandle1 = Bullet.CreateBullet("blizzaga", _UPVALUE0_, _UPVALUE4_)
            if EntityManager:GetEntity(_ARG_0_.bltHandle1) ~= nil then
              EntityManager:GetEntity(_ARG_0_.bltHandle1).targetHandle = _ARG_0_.targetHandle
            end
            SetBulletAttackParam(_ARG_0_.bltHandle1, _ARG_0_.myHandle, 7)
            Entity.GetRot(_UPVALUE4_, _ARG_0_.myHandle)
            Entity.GetLocalPos(_UPVALUE0_, _ARG_0_.myHandle)
            _ARG_0_.bltHandle2 = Bullet.CreateBullet("blizzaga", _UPVALUE0_, _UPVALUE4_)
            if EntityManager:GetEntity(_ARG_0_.bltHandle2) ~= nil then
              EntityManager:GetEntity(_ARG_0_.bltHandle2).targetHandle = _ARG_0_.targetHandle
            end
            SetBulletAttackParam(_ARG_0_.bltHandle2, _ARG_0_.myHandle, 7)
            _ARG_0_.Step = 10
          end
        elseif _ARG_0_.Step == 10 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetTimer(_ARG_0_.myHandle, 400 - _UPVALUE3_)
            _ARG_0_.IsYoin = true
            _ARG_0_.Step = 20
          end
        elseif _ARG_0_.Step == 20 then
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE3_)
          if EntityManager:GetEntity(_ARG_0_.bltHandle0) == nil and EntityManager:GetEntity(_ARG_0_.bltHandle1) == nil and EntityManager:GetEntity(_ARG_0_.bltHandle2) == nil then
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE5_)
            print("\146e\144\216\130\234\n")
            _ARG_0_.Step = 30
          end
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:EndAttackPattern()
          end
        elseif _ARG_0_.Step == 30 and Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:EndAttackPattern()
        end
        if _ARG_0_.nextMotionCheck then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            if _ARG_0_.AttackParam == 0 then
              _ARG_0_:SetMotion(_UPVALUE6_)
            else
              _ARG_0_:SetMotion(_UPVALUE7_)
            end
            _ARG_0_.nextMotionCheck = false
          end
        else
          _ARG_0_:SearchPlayer()
        end
      end
    },
    UltimateFreeze = {
      OnBeginState = function(_ARG_0_)
        print("UltimateFreeze\n")
        _ARG_0_.IsYoin = false
        _ARG_0_:SetMotion(_UPVALUE0_)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
        Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 0)
        CalcWarpPosition(_ARG_0_.targetHandle, nil, 0.1, 0, nil, _ARG_0_.myHandle)
        Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE1_)
        Entity.SetOldLocalPos(_ARG_0_.myHandle, _UPVALUE1_)
        Entity.SetRot(_ARG_0_.myHandle, _UPVALUE2_)
        Entity.AttachEffect(_ARG_0_.myHandle, _UPVALUE3_, "B25_WRP_APP0_0", "hara", _UPVALUE4_, _UPVALUE4_)
        _ARG_0_:StopVoice(15)
        if _ARG_0_.cameraHandle ~= NULL_HANDLE then
          Script.OutTask(_ARG_0_.cameraHandle)
        end
        _ARG_0_.cameraHandle = Camera.CreateExusiaCamera("b40ex_af0")
        Camera.SetExusiaBaseCoord(_ARG_0_.cameraHandle, _ARG_0_.targetHandle, 0)
        Camera.StartExusiaCamera(_ARG_0_.cameraHandle)
        _ARG_0_.Step = 0
        _ARG_0_.SubStep = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
        Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 1)
        if _ARG_0_.cameraHandle ~= NULL_HANDLE then
          Script.OutTask(_ARG_0_.cameraHandle)
        end
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.Step == 0 then
          CalcWarpPosition(_ARG_0_.targetHandle, nil, 0.1, 3.14, nil, _ARG_0_.myHandle)
          Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE0_)
          Entity.SetOldLocalPos(_ARG_0_.myHandle, _UPVALUE0_)
          Entity.SetRot(_ARG_0_.myHandle, _UPVALUE1_)
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
            if Player.IsDamageFlagMount(_ARG_0_.targetHandle) ~= true then
              _ARG_0_:EndAttackPattern()
            else
              _ARG_0_:SetMotion(_UPVALUE2_)
              print("timer" .. _UPVALUE3_ + _UPVALUE4_ * Script.Random() .. "\n")
              Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE3_ + _UPVALUE4_ * Script.Random())
              _ARG_0_.Step = 1
            end
          end
        elseif _ARG_0_.Step == 1 then
          CalcWarpPosition(_ARG_0_.targetHandle, nil, 0.1, 3.14, nil, _ARG_0_.myHandle)
          Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE0_)
          Entity.SetOldLocalPos(_ARG_0_.myHandle, _UPVALUE0_)
          Entity.SetRot(_ARG_0_.myHandle, _UPVALUE1_)
          if Player.IsDamageFlagMount(_ARG_0_.targetHandle) ~= true then
            print("Success! " .. Entity.GetTimer(_ARG_0_.myHandle) .. " 1\n")
            _ARG_0_.Step = 100
            _ARG_0_.SubStep = 100
            Entity.SetTimer(_ARG_0_.myHandle, 120)
            _ARG_0_.forceBlow = _ARG_0_.AttackPattern
            CalcWarpPosition(_ARG_0_.targetHandle, nil, 0.5, 0, nil, _ARG_0_.myHandle)
            Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE0_)
            Entity.SetOldLocalPos(_ARG_0_.myHandle, _UPVALUE0_)
            Entity.SetRot(_ARG_0_.myHandle, _UPVALUE1_)
          elseif Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:SetMotion(_UPVALUE5_)
            _ARG_0_.Step = 2
            print("SubStep " .. _ARG_0_.SubStep .. "\n")
            _ARG_0_.SubStep = 10
          end
        elseif _ARG_0_.Step == 2 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 24 then
            _ARG_0_.Step = 200
          elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_.Step = 200
          elseif Player.IsDamageFlagMount(_ARG_0_.targetHandle) ~= true then
            print("Success! " .. Entity.GetTimer(_ARG_0_.myHandle) .. " 2\n")
            _ARG_0_.Step = 100
            _ARG_0_.SubStep = 100
            Entity.SetTimer(_ARG_0_.myHandle, 120)
            _ARG_0_.forceBlow = _ARG_0_.AttackPattern
            CalcWarpPosition(_ARG_0_.targetHandle, nil, 0.5, 0, nil, _ARG_0_.myHandle)
            Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE0_)
            Entity.SetOldLocalPos(_ARG_0_.myHandle, _UPVALUE0_)
            Entity.SetRot(_ARG_0_.myHandle, _UPVALUE1_)
          end
        elseif _ARG_0_.Step == 100 then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE6_)
          print("no damaging!!\n")
          Entity.GetLocalPos(_UPVALUE0_, _ARG_0_.myHandle)
          Entity.GetDir(_UPVALUE7_, _ARG_0_.myHandle)
          Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
          _ARG_0_.forceBlow = _ARG_0_.AttackPattern
          SetBulletAttackParam(Bullet.CreateBullet("dummybullet", _UPVALUE0_, _UPVALUE1_), Bullet.CreateBullet("dummybullet", _UPVALUE0_, _UPVALUE1_), 100, 1)
          if EntityManager:GetEntity((Bullet.CreateBullet("dummybullet", _UPVALUE0_, _UPVALUE1_))) ~= nil then
            EntityManager:GetEntity((Bullet.CreateBullet("dummybullet", _UPVALUE0_, _UPVALUE1_))).targetHandle = _ARG_0_.myHandle
          end
          _ARG_0_.Step = 101
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:EndAttackPattern()
          end
        elseif _ARG_0_.Step == 101 then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE6_)
          Enemy.GetTargetLastRecordedPos(_UPVALUE0_, _ARG_0_.myHandle, _ARG_0_.targetHandle)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE0_, 180)
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:EndAttackPattern()
          end
        elseif _ARG_0_.Step == 200 then
          _ARG_0_:EndAttackPattern()
        end
        if _ARG_0_.SubStep == 0 then
          if Camera.IsEndExusiaCamera(_ARG_0_.cameraHandle) then
            Script.OutTask(_ARG_0_.cameraHandle)
            _ARG_0_.cameraHandle = Camera.CreateExusiaCamera("b40ex_af1")
            Camera.SetExusiaBaseCoord(_ARG_0_.cameraHandle, _ARG_0_.targetHandle, 0)
            Camera.StartExusiaCamera(_ARG_0_.cameraHandle)
            _ARG_0_.SubStep = 5
          end
        elseif _ARG_0_.SubStep == 10 then
          if _ARG_0_.cameraHandle ~= NULL_HANDLE then
            Script.OutTask(_ARG_0_.cameraHandle)
          end
          _ARG_0_.cameraHandle = Camera.CreateExusiaCamera("b40ex_af2")
          Camera.SetExusiaBaseCoord(_ARG_0_.cameraHandle, _ARG_0_.targetHandle, 0)
          Camera.StartExusiaCamera(_ARG_0_.cameraHandle)
          _ARG_0_.SubStep = 20
        elseif _ARG_0_.SubStep == 20 then
          if Camera.IsEndExusiaCamera(_ARG_0_.cameraHandle) then
            print("camera wait ---done\n")
            Script.OutTask(_ARG_0_.cameraHandle)
            _ARG_0_.cameraHandle = NULL_HANDLE
            _ARG_0_.SubStep = 200
          end
        elseif _ARG_0_.SubStep == 100 and _ARG_0_.cameraHandle ~= NULL_HANDLE then
          Script.OutTask(_ARG_0_.cameraHandle)
          _ARG_0_.cameraHandle = NULL_HANDLE
          _ARG_0_.SubStep = 200
        end
      end
    },
    Dead = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_.Step = 0
        _ARG_0_.Timer = 60
        print("Dead\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.Step == 0 then
          _ARG_0_.Timer = _ARG_0_.Timer - Script.GetVsyncFrameRate()
          if 0 >= _ARG_0_.Timer then
            _ARG_0_.Step = 10
          end
        elseif _ARG_0_.Step == 10 and Sound.IsInvalidateSeCall() == 1 then
          print("DEAD VOICE----------------------\n")
          Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 2)
          Sound.PlayVoice(103, 33, 1, _UPVALUE0_, SE_OPT_ALWAYS)
          _ARG_0_.Step = 100
        end
      end
    }
  },
  SetMotion = function(_ARG_0_, _ARG_1_)
    Entity.SetMotion(_ARG_0_.myHandle, _ARG_1_)
    Entity.SetMotion(_ARG_0_.keyHandle, _ARG_1_)
  end,
  WarpAttackSub = function(_ARG_0_)
    if _ARG_0_.AttackPattern == 4 then
      if _ARG_0_.SubStep == 0 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 14 then
          print("hide 0\n")
          Entity.AttachEffect(_ARG_0_.myHandle, _UPVALUE0_, "B25_WRP_LST0_0", "hara", _UPVALUE1_, _UPVALUE1_)
          Entity.SetMotionSpeed(_ARG_0_.myHandle, 0.1)
          _ARG_0_:Hide()
          _ARG_0_.SubStep = 1
        end
      elseif _ARG_0_.SubStep == 1 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 15 then
          print("show 0\n")
          Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
          _ARG_0_.WarpTarget = 4
          _ARG_0_:WarpToTarget()
          _ARG_0_:Show()
          Entity.AttachEffect(_ARG_0_.myHandle, _UPVALUE0_, "B25_WRP_APP0_0", "hara", _UPVALUE1_, _UPVALUE1_)
          _ARG_0_.SubStep = 2
        end
      elseif _ARG_0_.SubStep == 2 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 19 then
          print("hide 1\n")
          Entity.AttachEffect(_ARG_0_.myHandle, _UPVALUE0_, "B25_WRP_LST0_0", "hara", _UPVALUE1_, _UPVALUE1_)
          Entity.SetMotionSpeed(_ARG_0_.myHandle, 0.1)
          _ARG_0_:Hide()
          _ARG_0_.SubStep = 3
        end
      elseif _ARG_0_.SubStep == 3 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 20 then
          Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
          print("show 1\n")
          _ARG_0_.WarpTarget = 4
          _ARG_0_:WarpToTarget()
          _ARG_0_:Show()
          Entity.AttachEffect(_ARG_0_.myHandle, _UPVALUE0_, "B25_WRP_APP0_0", "hara", _UPVALUE1_, _UPVALUE1_)
          _ARG_0_.SubStep = 4
        end
      elseif _ARG_0_.SubStep == 4 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 29 then
          print("hide 2\n")
          Entity.AttachEffect(_ARG_0_.myHandle, _UPVALUE0_, "B25_WRP_LST0_0", "hara", _UPVALUE1_, _UPVALUE1_)
          Entity.SetMotionSpeed(_ARG_0_.myHandle, 0.1)
          _ARG_0_:Hide()
          _ARG_0_.SubStep = 5
        end
      elseif _ARG_0_.SubStep == 5 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 30 then
        print("show 2\n")
        Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
        _ARG_0_.WarpTarget = 4
        _ARG_0_:WarpToTarget()
        _ARG_0_:Show()
        Entity.AttachEffect(_ARG_0_.myHandle, _UPVALUE0_, "B25_WRP_APP0_0", "hara", _UPVALUE1_, _UPVALUE1_)
        _ARG_0_.SubStep = 10
      end
    end
  end,
  DbgResetState = function(_ARG_0_)
    print("-----------------------------------------DEBUGResetState!!\n")
    _ARG_0_.StateParam = 0
    _ARG_0_:GotoState("Idling")
  end,
  SearchPlayer = function(_ARG_0_)
    Enemy.GetTargetLastRecordedPos(_UPVALUE0_, _ARG_0_.myHandle, _ARG_0_.targetHandle)
    Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE0_, 2.5)
  end,
  ReturnState = function(_ARG_0_)
    print("Return State!! " .. _ARG_0_.ReturnStateName .. ":" .. _ARG_0_.ReturnStateParam .. "\n")
    _ARG_0_.StateParam = _ARG_0_.ReturnStateParam
    _ARG_0_:GotoState(_ARG_0_.ReturnStateName)
    _ARG_0_.IdlingTimer = _ARG_0_.ReturnIdlingTimer
  end,
  SetReturnState = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    if _ARG_1_ == nil then
      _ARG_0_.ReturnStateName = _ARG_0_:GetState()
    else
      _ARG_0_.ReturnStateName = _ARG_1_
    end
    if _ARG_2_ == nil then
      _ARG_0_.ReturnStateParam = _ARG_0_.StateParam
    else
      _ARG_0_.ReturnStateParam = _ARG_2_
    end
    if _ARG_3_ == nil then
      _ARG_0_.ReturnIdlingTimer = 0
    else
      _ARG_0_.ReturnIdlingTimer = _ARG_3_
    end
  end,
  PlayVoice = function(_ARG_0_, _ARG_1_)
    if _ARG_0_.voiceHandle ~= NULL_HANDLE then
      Sound.Stop(_ARG_0_.voiceHandle, 0)
    end
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 2)
    _ARG_0_.voiceHandle = Sound.PlayVoice(103, _ARG_1_, 1, _UPVALUE0_, 1)
  end,
  StopVoice = function(_ARG_0_, _ARG_1_)
    if _ARG_0_.voiceHandle ~= NULL_HANDLE then
      Sound.Stop(_ARG_0_.voiceHandle, _ARG_1_)
      _ARG_0_.voiceHandle = NULL_HANDLE
    end
  end,
  StartAttackPattern = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    print("---------------AttackPattern " .. _ARG_1_ .. " " .. _ARG_2_ .. "\n")
    _ARG_0_.AttackPattern = _ARG_1_
    _ARG_0_.AttackParam = _ARG_2_
    if _ARG_3_ then
      _ARG_0_.AttackPatternLoop = _ARG_0_.AttackPatternLoop + 1
    else
      _ARG_0_.AttackPatternLoop = 0
    end
    print("loop " .. _ARG_0_.AttackPatternLoop .. "\n")
    if _ARG_0_.AttackPattern == 1 then
      if _ARG_0_.AttackParam == 101 then
        _ARG_0_.DamageWarpParam = 102
        if Script.Random() <= 0.6 then
          _ARG_0_.StateParam = 0
          _ARG_0_:GotoState("Attack0")
        else
          _ARG_0_.StateParam = 0
          _ARG_0_:GotoState("Attack1")
        end
      elseif _ARG_0_.AttackParam == 102 then
        _ARG_0_.DamageWarpParam = 101
        if Script.Random() <= 0.5 then
          _ARG_0_.StateParam = 0
          _ARG_0_:GotoState("Attack0")
        else
          _ARG_0_.StateParam = 0
          _ARG_0_:GotoState("Attack1")
        end
      elseif _ARG_0_.AttackParam == 0 then
        if Script.Random() < _UPVALUE0_ then
          _ARG_0_.DamageWarpParam = 2
        else
          _ARG_0_.DamageWarpParam = 3
        end
        if Script.Random() <= 0.7 then
          _ARG_0_.StateParam = 0
          _ARG_0_:GotoState("Attack0")
        else
          _ARG_0_.StateParam = 0
          _ARG_0_:GotoState("Attack1")
        end
      else
        if Script.Random() < _UPVALUE0_ then
          _ARG_0_.DamageWarpParam = 2
        else
          _ARG_0_.DamageWarpParam = 6
        end
        if Script.Random() <= 0.3 then
          _ARG_0_.StateParam = 0
          _ARG_0_:GotoState("Attack0")
        else
          _ARG_0_.StateParam = 0
          _ARG_0_:GotoState("Attack1")
        end
      end
    elseif _ARG_0_.AttackPattern == 2 then
      if _ARG_0_.AttackParam == 101 then
        _ARG_0_.DamageWarpParam = 102
        if Script.Random() <= 0.5 then
          _ARG_0_.StateParam = 0
          _ARG_0_:GotoState("Thundaga")
        else
          _ARG_0_.StateParam = 0
          _ARG_0_:GotoState("Blizzaga")
        end
      else
        if _ARG_0_.AttackParam == 0 then
          _ARG_0_.DamageWrapParm = 5
        elseif _ARG_0_.AttackParam == 1 then
          if Script.Random() < _UPVALUE0_ then
            _ARG_0_.DamageWarpParam = 8
          else
            _ARG_0_.DamageWarpParam = 6
          end
        else
          _ARG_0_.DamageWarpParam = 5
        end
        if _ARG_0_.AttackParam == 0 then
          if Script.Random() <= 0.36363637 then
            _ARG_0_.StateParam = 0
            _ARG_0_:GotoState("RisingGround")
          elseif Script.Random() <= 0.6909091 then
            _ARG_0_.StateParam = 0
            _ARG_0_:GotoState("Blizzaga")
          else
            _ARG_0_.StateParam = 0
            _ARG_0_:GotoState("Thundaga")
          end
        elseif Script.Random() <= 0.34 then
          _ARG_0_.StateParam = 0
          _ARG_0_:GotoState("RisingGround")
        elseif Script.Random() <= 0.67 then
          _ARG_0_.StateParam = 0
          _ARG_0_:GotoState("Blizzaga")
        else
          _ARG_0_.StateParam = 0
          _ARG_0_:GotoState("Thundaga")
        end
      end
    elseif _ARG_0_.AttackPattern == 3 then
      if _ARG_0_.AttackParam == 0 then
        if Script.Random() < _UPVALUE0_ then
          _ARG_0_.DamageWarpParam = 2
        else
          _ARG_0_.DamageWarpParam = 6
        end
      else
        _ARG_0_.DamageWarpParam = 2
      end
      if _ARG_0_.isBladeTornadoBusy then
        if Script.Random() <= 0.3 then
          _ARG_0_:GotoState("Thundaga")
        else
          _ARG_0_:GotoState("Blizzaga")
        end
      else
        _ARG_0_.DamageWarpParam = 7
        _ARG_0_.StateParam = 0
        _ARG_0_:GotoState("BladeTornado")
      end
    elseif _ARG_0_.AttackPattern == 4 then
      if Script.Random() < 0.5 then
        _ARG_0_.DamageWarpParam = 2
      else
        _ARG_0_.DamageWarpParam = 3
      end
      if Script.Random() <= 0.3 then
        _ARG_0_.StateParam = 0
        _ARG_0_:GotoState("Attack0")
      else
        _ARG_0_.StateParam = 0
        _ARG_0_:GotoState("Attack1")
      end
    elseif _ARG_0_.AttackPattern == 5 then
      if Script.Random() < _UPVALUE0_ then
        _ARG_0_.DamageWarpParam = 2
      else
        _ARG_0_.DamageWarpParam = 6
      end
      _ARG_0_.StateParam = 0
      _ARG_0_:GotoState("Attack0")
    end
  end,
  EndAttackPattern = function(_ARG_0_, _ARG_1_)
    if _ARG_1_ == nil then
      _ARG_1_ = 0
    end
    print("---------------------------------AttackPattern END\n")
    if _ARG_0_.AttackPattern == 1 then
      if _ARG_0_.AttackParam == 101 or _ARG_0_.AttackParam == 102 then
        _ARG_0_.StateParam = 102
        _ARG_0_:GotoState("Idling")
        Enemy.SendMessage(0, _ARG_0_.myHandle, _ARG_0_.Vanitus, B40EX_MES_B40EX_ATTACK_END)
        print("ATTACK accept!! ->END\n")
      elseif _ARG_0_.AttackPatternLoop < 2 and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE0_ and _ARG_0_.damageCombo == 0 and _ARG_1_ == 0 and Script.Random() < 0.5 then
        _ARG_0_:StartAttackPattern(_ARG_0_.AttackPattern, _ARG_0_.AttackParam, true)
      elseif _ARG_0_.AttackParam == 0 then
        print("AttackParam = 0\n")
        _ARG_0_.StateParam = 1
        _ARG_0_:GotoState("Idling")
      else
        print("AttackParam = 1\n")
        _ARG_0_.StateParam = 3
        _ARG_0_:GotoState("Idling")
      end
    elseif _ARG_0_.AttackPattern == 2 then
      if _ARG_0_.AttackParam == 101 then
        _ARG_0_.StateParam = 101
        _ARG_0_:GotoState("Idling")
        Enemy.SendMessage(0, _ARG_0_.myHandle, _ARG_0_.Vanitus, B40EX_MES_B40EX_ATTACK_END)
        print("ATTACK accept!! ->END\n")
      elseif _ARG_0_.AttackParam == 0 or _ARG_0_.AttackParam == 2 then
        _ARG_0_.StateParam = 2
        _ARG_0_:GotoState("Idling")
      else
        _ARG_0_.StateParam = 3
        _ARG_0_:GotoState("Idling")
      end
    elseif _ARG_0_.AttackPattern == 3 then
      if _ARG_0_.AttackParam == 0 then
        _ARG_0_.StateParam = 2
        _ARG_0_:GotoState("Idling")
      else
        _ARG_0_.StateParam = 3
        _ARG_0_:GotoState("Idling")
      end
    elseif _ARG_0_.AttackPattern == 4 then
      if Script.Random() < 0.5 then
        _ARG_0_.StateParam = 2
      else
        _ARG_0_.StateParam = 3
      end
      _ARG_0_:GotoState("Warp")
    elseif _ARG_0_.AttackPattern == 5 then
      _ARG_0_.StateParam = 4
      _ARG_0_:GotoState("Warp")
    else
      _ARG_0_:DbgResetState()
    end
  end,
  WarpToTarget = function(_ARG_0_)
    Camera.GetPlayerCameraDir(_UPVALUE0_)
    _UPVALUE1_:set(Math.Sin(_UPVALUE0_:gety()), 0, Math.Cos(_UPVALUE0_:gety()))
    if _ARG_0_.WarpTarget == 5 then
      CalcWarpPosition(_ARG_0_.targetHandle, _UPVALUE1_, _UPVALUE2_, -((-0.5 + Script.Random()) * 3.14 / 6), 1.5, _ARG_0_.myHandle)
    elseif _ARG_0_.WarpTarget == 4 then
      CalcWarpPosition(_ARG_0_.targetHandle, _UPVALUE1_, _UPVALUE2_, (-0.5 + Script.Random()) * 3.14 * 1.5, 1.5, _ARG_0_.myHandle)
    elseif _ARG_0_.WarpTarget == 3 then
      Entity.GetLocalPos(_UPVALUE3_, _ARG_0_.myHandle)
      Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
    elseif _ARG_0_.WarpTarget == 2 then
      CalcWarpPosition(_ARG_0_.targetHandle, _UPVALUE1_, _UPVALUE4_, (-0.5 + Script.Random()) * 3.14 * 1.5, 10, _ARG_0_.myHandle)
    elseif _ARG_0_.WarpTarget == 1 then
      for _FORV_5_ = 1, 4 do
        if CalcWarpPosition(_ARG_0_.targetHandle, _UPVALUE1_, _UPVALUE5_, (-0.5 + Script.Random()) * 3.14 * 1.5, 1.5, _ARG_0_.myHandle) then
          break
        end
        if _FORV_5_ == 1 then
        elseif _FORV_5_ == 2 then
        else
        end
      end
    else
      CalcWarpPosition(_ARG_0_.targetHandle, _UPVALUE1_, _UPVALUE2_, (-0.5 + Script.Random()) * 3.14 / 6 + 1.57 - 1.57 + 3.14, 1.5, _ARG_0_.myHandle)
    end
    Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE3_)
    Entity.SetOldLocalPos(_ARG_0_.myHandle, _UPVALUE3_)
    Entity.SetRot(_ARG_0_.myHandle, _UPVALUE0_)
  end,
  SetDefenseTimer = function(_ARG_0_, _ARG_1_)
    _ARG_0_.defenseTimer = _ARG_1_
  end,
  IsDefenseTimeOver = function(_ARG_0_)
    return _ARG_0_.defenseTimer <= 0
  end,
  IsDefensing = function(_ARG_0_)
    return _ARG_0_.defenseTimer > 0
  end,
  IsQuickWarping = function(_ARG_0_)
    return _ARG_0_:IsDefensing()
  end,
  Hide = function(_ARG_0_)
    Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
    Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
    Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
    Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 0)
    Entity.SetAlpha(_ARG_0_.myHandle, 0)
    Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
    Entity.SetAlpha(_ARG_0_.keyHandle, 0)
    print("---Hide\n")
  end,
  Show = function(_ARG_0_)
    Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
    Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
    Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
    Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 1)
    Entity.SetAlpha(_ARG_0_.myHandle, 1)
    Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
    Entity.SetAlpha(_ARG_0_.keyHandle, 1)
    print("---Show\n")
  end,
  QuickWarpStart = function(_ARG_0_)
    if _ARG_0_:GetState() == "Warp" then
      return
    elseif _ARG_0_:GetState() == "Idling" or _ARG_0_:GetState() == "Move" or _ARG_0_.IsYoin then
      print("QuickWarp->Warp " .. _ARG_0_.DamageWarpParam .. "\n")
      _ARG_0_.StateParam = _ARG_0_.DamageWarpParam
      _ARG_0_:GotoState("Warp")
    end
    print("QuickWarp ---start\n")
    _ARG_0_:SetDefenseTimer(_UPVALUE0_)
    _ARG_0_:Hide()
    Entity.AttachEffect(_ARG_0_.myHandle, _UPVALUE1_, "B25_WRP_LST0_0", "hara", _UPVALUE2_, _UPVALUE2_)
    Entity.GetWorldPos(_UPVALUE3_, _ARG_0_.myHandle, 2)
    if Script.Random() <= 0.13 then
      _ARG_0_:PlayVoice(8)
    elseif Script.Random() <= 0.26 then
      _ARG_0_:PlayVoice(9)
    elseif Script.Random() <= 0.39 then
      _ARG_0_:PlayVoice(10)
    else
      _ARG_0_:PlayVoice(11)
    end
  end,
  Defense = function(_ARG_0_)
    if _ARG_0_.defenseTimer > 0 then
      _ARG_0_.defenseTimer = _ARG_0_.defenseTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
      if _ARG_0_:IsDefenseTimeOver() and _ARG_0_:GetState() ~= "Warp" then
        print("QuickWarp ---end\n")
        Entity.AttachEffect(_ARG_0_.myHandle, _UPVALUE0_, "B25_WRP_APP0_0", "hara", _UPVALUE1_, _UPVALUE1_)
        _ARG_0_:Show()
      end
    end
  end,
  CreateKeyBlades = function(_ARG_0_)
    _UPVALUE0_:set(0, -10, 0)
    _UPVALUE1_:set(0, 0, 0)
    _ARG_0_.keybladeHandle[1] = Entity.CreateEntity({
      "b90ex00",
      "b91ex00",
      "b92ex00",
      "b93ex00",
      "b94ex00",
      "b95ex00",
      "b96ex00",
      "b97ex00",
      "b98ex00",
      "b99ex00"
    }[Script.RandomInteger(#{
      "b90ex00",
      "b91ex00",
      "b92ex00",
      "b93ex00",
      "b94ex00",
      "b95ex00",
      "b96ex00",
      "b97ex00",
      "b98ex00",
      "b99ex00"
    }) + 1], _UPVALUE0_, _UPVALUE1_)
    EnableVanitusKeyBladeLeaderAutoCtrl(_ARG_0_.keybladeHandle[1], false)
    for _FORV_5_ = 2, _UPVALUE2_ do
      _ARG_0_.keybladeHandle[_FORV_5_] = Entity.CreateEntity({
        "b90ex00",
        "b91ex00",
        "b92ex00",
        "b93ex00",
        "b94ex00",
        "b95ex00",
        "b96ex00",
        "b97ex00",
        "b98ex00",
        "b99ex00"
      }[Script.RandomInteger(#{
        "b90ex00",
        "b91ex00",
        "b92ex00",
        "b93ex00",
        "b94ex00",
        "b95ex00",
        "b96ex00",
        "b97ex00",
        "b98ex00",
        "b99ex00"
      }) + 1], _UPVALUE0_, _UPVALUE1_, _ARG_0_.keybladeHandle[_FORV_5_ - 1])
    end
    SetVanitusKeyBladeAttackParam(_ARG_0_.keybladeHandle[1], _ARG_0_.myHandle, 5)
  end,
  DestroyKeyBlades = function(_ARG_0_)
    for _FORV_4_ = 1, _UPVALUE0_ do
      Entity.Out(_ARG_0_.keybladeHandle[_FORV_4_])
      _ARG_0_.keybladeHandle[_FORV_4_] = NULL_HANDLE
    end
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    _UPVALUE0_ = Entity.GetMotionIndex(_ARG_1_, "010")
    _UPVALUE1_ = Entity.GetMotionIndex(_ARG_1_, "011")
    _UPVALUE2_ = Entity.GetMotionIndex(_ARG_1_, "030")
    _UPVALUE3_ = Entity.GetMotionIndex(_ARG_1_, "200")
    _UPVALUE4_ = Entity.GetMotionIndex(_ARG_1_, "202")
    _UPVALUE5_ = Entity.GetMotionIndex(_ARG_1_, "220")
    _UPVALUE6_ = Entity.GetMotionIndex(_ARG_1_, "221")
    _UPVALUE7_ = Entity.GetMotionIndex(_ARG_1_, "222")
    _UPVALUE8_ = Entity.GetMotionIndex(_ARG_1_, "223")
    _UPVALUE9_ = Entity.GetMotionIndex(_ARG_1_, "230")
    _UPVALUE10_ = Entity.GetMotionIndex(_ARG_1_, "231")
    _UPVALUE11_ = Entity.GetMotionIndex(_ARG_1_, "300")
    _UPVALUE12_ = Entity.GetMotionIndex(_ARG_1_, "301")
    _UPVALUE13_ = Entity.GetMotionIndex(_ARG_1_, "310")
    _UPVALUE14_ = Entity.GetMotionIndex(_ARG_1_, "320")
    _UPVALUE15_ = Entity.GetMotionIndex(_ARG_1_, "330")
    _UPVALUE16_ = Entity.GetMotionIndex(_ARG_1_, "340")
    _UPVALUE17_ = Entity.GetMotionIndex(_ARG_1_, "350")
    _UPVALUE18_ = Entity.GetMotionIndex(_ARG_1_, "351")
    _UPVALUE19_ = Entity.GetMotionIndex(_ARG_1_, "352")
    _UPVALUE20_ = Entity.GetMotionIndex(_ARG_1_, "400")
    _ARG_0_.CounterHit = Enemy.GetExtraParam(_ARG_1_, "CounterHit")
    _UPVALUE21_ = Enemy.GetExtraParam(_ARG_1_, "BTSpeed")
    _UPVALUE22_ = Enemy.GetExtraParam(_ARG_1_, "BTSchAngle")
    _UPVALUE23_ = Enemy.GetExtraParam(_ARG_1_, "BTRiseTime")
    _UPVALUE24_ = Enemy.GetExtraParam(_ARG_1_, "BTSchTime")
    _UPVALUE25_ = Enemy.GetExtraParam(_ARG_1_, "BTFwdTime")
    _UPVALUE26_ = Enemy.GetExtraParam(_ARG_1_, "BZIntroTime")
    _UPVALUE27_ = Enemy.GetExtraParam(_ARG_1_, "BZSpeed")
    _UPVALUE28_ = Enemy.GetExtraParam(_ARG_1_, "BZSchAngle")
    _UPVALUE29_ = Enemy.GetExtraParam(_ARG_1_, "BZSchTime")
    _UPVALUE30_ = Enemy.GetExtraParam(_ARG_1_, "BZFwdTime")
    _UPVALUE31_ = Enemy.GetExtraParam(_ARG_1_, "TZIntroTime")
    _UPVALUE32_ = Enemy.GetExtraParam(_ARG_1_, "RGIntroTime")
    _UPVALUE33_ = Enemy.GetExtraParam(_ARG_1_, "IDRndBase")
    _UPVALUE34_ = Enemy.GetExtraParam(_ARG_1_, "IDRndTime")
    _UPVALUE35_ = Enemy.GetExtraParam(_ARG_1_, "IDHldTime")
    _UPVALUE36_ = Enemy.GetExtraParam(_ARG_1_, "WKRndBase")
    _UPVALUE37_ = Enemy.GetExtraParam(_ARG_1_, "WKRndTime")
    _UPVALUE38_ = Enemy.GetExtraParam(_ARG_1_, "QWarpNear")
    _UPVALUE39_ = Enemy.GetExtraParam(_ARG_1_, "QWarpFar")
    _UPVALUE40_ = Enemy.GetExtraParam(_ARG_1_, "UFMntBase")
    _UPVALUE41_ = Enemy.GetExtraParam(_ARG_1_, "UFMntRnd")
    _UPVALUE42_ = Enemy.GetExtraParam(_ARG_1_, "NextPhase")
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.targetHandle = NULL_HANDLE
    _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
    _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
    _ARG_0_.phase = 0
    _ARG_0_.Step = 0
    _ARG_0_.SubStep = 0
    _ARG_0_.Timer = 0
    _ARG_0_.WarpTarget = 0
    _ARG_0_.AttackPattern = 0
    _ARG_0_.AttackPatternLoop = 0
    _ARG_0_.AttackParam = 0
    _ARG_0_.StateParam = 0
    _ARG_0_.lastDamageKind = -1
    _ARG_0_.ReturnStateParam = 0
    _ARG_0_.ReturnStateName = "Idling"
    _ARG_0_.isDamaging = false
    _ARG_0_.ReturnIdlingTimer = 0
    _ARG_0_.IdlingTimer = 0
    _ARG_0_.defenseTimer = 0
    _ARG_0_.damageTimer = 0
    _ARG_0_.damageCombo = 0
    _ARG_0_.stack = Stack:Create()
    _ARG_0_.keybladeHandle = {}
    for _FORV_5_ = 1, _UPVALUE43_ do
      _ARG_0_.keybladeHandle[_FORV_5_] = NULL_HANDLE
    end
    _ARG_0_.isBladeTornadoBusy = false
    _ARG_0_.bladeTornadoTimer = 0
    _ARG_0_.bltHandle0 = NULL_HANDLE
    _ARG_0_.bltHandle1 = NULL_HANDLE
    _ARG_0_.bltHandle2 = NULL_HANDLE
    _ARG_0_.cameraHandle = NULL_HANDLE
    _ARG_0_.nextMotionCheck = false
    _ARG_0_.isPlayerAlive = true
    _ARG_0_.forceBlow = -1
    _ARG_0_.voiceHandle = NULL_HANDLE
    print("\131[\131A\131m\129[\131g OnInit\n")
    Player.SetBossCamera("b40ex")
    Entity.EnableGravity(_ARG_0_.myHandle, 1)
    Entity.EnableBgColl(_ARG_0_.myHandle, 1)
    Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
    _ARG_0_.keyHandle = Entity.CreateEntity("b41ex00", _UPVALUE44_, _UPVALUE44_, _ARG_0_.myHandle)
    Entity.AttachCoord(_ARG_0_.myHandle, "R_buki", _ARG_0_.keyHandle, "Root")
    Entity.EnableLockonAndShooton(_ARG_0_.keyHandle, 0)
    if _ARG_0_.phase == 101 then
      _ARG_0_.DamageWarpParam = 102
    else
      _ARG_0_.DamageWarpParam = 1
    end
    _ARG_0_.AttackAccept = false
    _ARG_0_.IsYoin = false
    _ARG_0_:GotoState("Appear")
  end,
  OnMessage = function(_ARG_0_, _ARG_1_, _ARG_2_)
    if _ARG_1_ == B10EX_MES_B40EX_ATTACK_ACCEPT then
      print("ATTACK accept!!\n")
      _ARG_0_.AttackAccept = true
    elseif _ARG_1_ == B10EX_MES_B40EX_ATTACK_DENY then
      _ARG_0_.AttackAccept = false
    elseif _ARG_1_ == B10EX_MES_B10EX_BLADETORNADO_START then
    elseif _ARG_1_ == B10EX_MES_B10EX_BLADETORNADO_END then
    end
  end,
  OnReturnDamage = function(_ARG_0_)
    print("---Return Damage\n")
    _ARG_0_.isDamaging = false
    _ARG_0_.lastDamageKind = -1
    if _ARG_0_:GetState() == "UltimateFreeze" then
      _ARG_0_:EndAttackPattern()
      return 0
    end
  end,
  OnHitAttack = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    print("---HitAttack\n")
    _ARG_0_.lastDamageKind = _ARG_3_
  end,
  OnDamage = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    print("Damage " .. _ARG_0_.damageTimer .. "," .. _ARG_1_ .. "\n")
    if _ARG_0_.forceBlow == _ARG_0_.AttackPattern then
      Entity.SetDamageKind(_ARG_0_.myHandle, ATK_KIND_DMG_BLOW)
    end
    _ARG_0_.forceBlow = -1
    if _ARG_0_:GetState() == "UltimateFreeze" and _ARG_0_.cameraHandle ~= NULL_HANDLE then
      print("camera out \n")
      Script.OutTask(_ARG_0_.cameraHandle)
      _ARG_0_.cameraHandle = NULL_HANDLE
    end
    Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
    _ARG_0_:Show()
    return 0
  end,
  OnReflect = function(_ARG_0_)
    print("refrect\n")
    Entity.SetMotionSpeed(_ARG_0_.myHandle, 1)
    _ARG_0_:Show()
    return 0
  end,
  OnDamageBefore = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    print("---Damage before " .. _ARG_0_.damageCombo .. "," .. _ARG_1_ .. "," .. _ARG_2_ .. "," .. _ARG_3_ .. "\n")
    do return 0 end
    if Enemy.IsNoDamageReaction(_ARG_0_.myHandle) then
      return 1
    end
    if _ARG_0_.phase == 1 and (_ARG_0_:GetState() == "Attack0" or _ARG_0_:GetState() == "Attack1") then
      if _ARG_2_ ~= COMMAND_CATEGORY_COUNTER then
        print("--------MUTEKI!!!\n")
        return 1
      else
        print("--------MUTEKI But COUNTER\n")
        _ARG_0_.StateParam = _ARG_0_.DamageWarpParam
        _ARG_0_:GotoState("Warp")
        return 1
      end
    end
    if _ARG_0_.damageTimer >= 30 then
      _ARG_0_.damageCombo = 0
    end
    _ARG_0_.damageTimer = 0
    if _ARG_0_.AttackPattern == 1 then
      if _ARG_0_.isDamaging and _ARG_0_:GetState() ~= "Idling" and _ARG_0_:GetState() ~= "UltimateFreeze" and _ARG_0_:GetState() ~= "Warp" then
        print("attackPattern1 Canceled!!!!!!!\n")
        _ARG_0_:EndAttackPattern(1)
      end
      _ARG_0_.damageCombo = _ARG_0_.damageCombo + 1
      _ARG_0_.isDamaging = true
      return 0
    end
    if _ARG_0_.forceBlow == _ARG_0_.AttackPattern then
      _ARG_0_.damageCombo = _ARG_0_.damageCombo + 1
      _ARG_0_.isDamaging = true
      return 0
    end
    if _ARG_2_ == COMMAND_CATEGORY_COUNTER then
      print("Counter!!\n")
      if Script.Random() > _ARG_0_.CounterHit then
        _ARG_0_:QuickWarpStart()
        _ARG_0_.damageCombo = 0
        return 1
      else
        _ARG_0_.damageCombo = _ARG_0_.damageCombo + 1
        _ARG_0_.isDamaging = true
        return 0
      end
    end
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE0_ then
    else
    end
    if _ARG_0_.damageTimer < 30 then
      for _FORV_10_ = 1, _ARG_0_.damageCombo do
      end
    end
    if Script.Random() > 0.7 * 0.7 then
      _ARG_0_:QuickWarpStart()
      _ARG_0_.damageCombo = 0
      return 1
    end
    _ARG_0_.damageCombo = _ARG_0_.damageCombo + 1
    _ARG_0_.isDamaging = true
    return 0
  end,
  OnUpdateDamageReaction = function(_ARG_0_, _ARG_1_)
    if _ARG_1_ == REACTION_KIND_BLOW_DAMAGE or _ARG_1_ == REACTION_KIND_TOSS_DAMAGE or _ARG_1_ == REACTION_KIND_FLICK_DAMAGE then
      print("OnUpdateDamageReaction " .. _ARG_1_ .. " " .. Entity.GetMotionNowFrame(_ARG_0_.myHandle) .. "\n")
      if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 9 then
        print("OnUpdateBlow " .. _ARG_0_.DamageWarpParam .. "\n")
        _ARG_0_.StateParam = _ARG_0_.DamageWarpParam
        _ARG_0_:GotoState("Warp")
        return 1
      end
    else
      if _ARG_1_ == REACTION_KIND_SMALL_DAMAGE then
      else
      end
    end
    return 0
  end,
  OnDead = function(_ARG_0_)
    print("---Dead\n")
    SetupBossDead(_ARG_0_.myHandle)
    _ARG_0_:DestroyKeyBlades()
    _ARG_0_:GotoState("Dead")
    return 1
  end,
  OnUpdate = function(_ARG_0_)
    _ARG_0_:Update()
    _ARG_0_:Defense()
    _ARG_0_:Debug()
    if _ARG_0_.isPlayerAlive and Player.GetPlayerHP() <= 0 and Sound.IsInvalidateSeCall() == 1 then
      if _ARG_0_.phase ~= 100 then
        print("PLAYER DEAD VOICE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 2)
        if Script.Random() <= 0.5 then
          _ARG_0_:PlayVoice(29)
        else
          _ARG_0_:PlayVoice(30)
        end
      end
      _ARG_0_.isPlayerAlive = false
    end
    _ARG_0_.damageTimer = _ARG_0_.damageTimer + Entity.GetFrameRate(_ARG_0_.myHandle)
    if 0 < _ARG_0_.bladeTornadoTimer then
      _ARG_0_.bladeTornadoTimer = _ARG_0_.bladeTornadoTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
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
        print(_UPVALUE0_[Script.GetDebugAttackNumber() + 1])
        print(" debug\n")
        _ARG_0_.stack:clear()
        _ARG_0_.stack:push("Idling")
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        _ARG_0_.StateParam = 0
        _ARG_0_:GotoState(_UPVALUE0_[Script.GetDebugAttackNumber() + 1])
      end
    end
  end
}, {__index = __StateMachine})
function CalcWarpPosition(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_)
  if _ARG_1_ == nil then
    Entity.GetDir(_UPVALUE0_, _ARG_0_)
  else
    _UPVALUE0_:copy(_ARG_1_)
  end
  _UPVALUE1_:copy(_UPVALUE0_)
  _UPVALUE0_:scale(_ARG_2_)
  if _ARG_3_ ~= nil then
    _UPVALUE0_:setz(_UPVALUE0_:getz() * Math.Cos(_ARG_3_) - _UPVALUE0_:getx() * Math.Sin(_ARG_3_))
    _UPVALUE0_:setx(_UPVALUE0_:getz() * Math.Sin(_ARG_3_) + _UPVALUE0_:getx() * Math.Cos(_ARG_3_))
  end
  Entity.GetWorldPos(_UPVALUE2_, _ARG_5_)
  Entity.GetWorldPos(_UPVALUE3_, _ARG_0_)
  if Collision.IntersectRayBg(_UPVALUE3_, COLL_KIND_ENEMY, _UPVALUE2_, _UPVALUE3_) then
    Entity.GetWorldPos(_UPVALUE2_, _ARG_5_)
  else
    Entity.GetWorldPos(_UPVALUE2_, _ARG_0_)
    _UPVALUE3_:copy(_UPVALUE2_)
    _UPVALUE2_:sety(_UPVALUE2_:gety() + 0.5)
    _UPVALUE3_:sety(_UPVALUE3_:gety() - 25)
    Collision.IntersectRayBg(_UPVALUE3_, COLL_KIND_ENEMY, _UPVALUE2_, _UPVALUE3_)
    _UPVALUE2_:sety(_UPVALUE3_:gety())
  end
  FVECTOR3.Add(_UPVALUE0_, _UPVALUE0_, _UPVALUE2_)
  if _ARG_4_ ~= nil then
    _UPVALUE1_:scale(_ARG_4_)
    _UPVALUE4_:set(_UPVALUE1_:getz(), _UPVALUE1_:gety(), -_UPVALUE1_:getx())
    FVECTOR3.Add(_UPVALUE0_, _UPVALUE0_, _UPVALUE4_)
    if Collision.IntersectRayBg(_UPVALUE0_, COLL_KIND_ENEMY, _UPVALUE2_, _UPVALUE0_) then
    end
    FVECTOR3.Sub(_UPVALUE0_, _UPVALUE0_, _UPVALUE4_)
    FVECTOR3.Sub(_UPVALUE0_, _UPVALUE0_, _UPVALUE4_)
    if Collision.IntersectRayBg(_UPVALUE0_, COLL_KIND_ENEMY, _UPVALUE2_, _UPVALUE0_) then
    end
    FVECTOR3.Add(_UPVALUE0_, _UPVALUE0_, _UPVALUE4_)
    FVECTOR3.Add(_UPVALUE0_, _UPVALUE0_, _UPVALUE1_)
    if Collision.IntersectRayBg(_UPVALUE0_, COLL_KIND_ENEMY, _UPVALUE2_, _UPVALUE0_) then
    end
    FVECTOR3.Sub(_UPVALUE0_, _UPVALUE0_, _UPVALUE1_)
    FVECTOR3.Sub(_UPVALUE0_, _UPVALUE0_, _UPVALUE1_)
    if Collision.IntersectRayBg(_UPVALUE0_, COLL_KIND_ENEMY, _UPVALUE2_, _UPVALUE0_) then
    end
    FVECTOR3.Add(_UPVALUE0_, _UPVALUE0_, _UPVALUE1_)
  else
  end
  FVECTOR3.Sub(_UPVALUE3_, _UPVALUE2_, _UPVALUE0_)
  _UPVALUE2_:set(0, Math.Atan2(_UPVALUE3_:getx(), _UPVALUE3_:getz()), 0)
  return (Collision.IntersectRayBg(_UPVALUE0_, COLL_KIND_ENEMY, _UPVALUE2_, _UPVALUE0_))
end
EntityFactory:Add("b40ex00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("thundaga", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("blizzaga", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("risingGround", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("freeze", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("bladeTornado", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("dummybullet", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
b41ex00 = {}
b41ex00_base_mt = {__index = __StateMachine}
setmetatable(b41ex00, b41ex00_base_mt)
b41ex00_mt = {__index = b41ex00}
function b41ex00.new(_ARG_0_)
  print("b41ex00:new()\n")
  return setmetatable(__StateMachine:new(), b41ex00_mt)
end
function b41ex00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.Master = 0
  _ARG_0_.HitAttackFlag = 0
end
function b41ex00.OnHitAttack(_ARG_0_)
  _ARG_0_.HitAttackFlag = 1
end
function b41ex00.OnUpdate(_ARG_0_)
end
EntityFactory:Add("b41ex00", function(_ARG_0_)
  return (b41ex00:new())
end)
