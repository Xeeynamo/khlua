setmetatable({
  new = function(_ARG_0_)
    print("b52ex00:new()\n")
    return setmetatable(__StateMachine:new(), _UPVALUE0_)
  end,
  states = {
    Appear = {
      OnBeginState = function(_ARG_0_)
        print("b52ex00:Appear\n")
        _ARG_0_:EnableDamage(false)
        Entity.SetMotion(_ARG_0_.myHandle, _ARG_0_.MOT_BTLIDLING)
        _ARG_0_.nStep = 0
      end,
      OnEndState = function(_ARG_0_)
        _ARG_0_:EnableDamage(true)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_0_.MOT_IDLING)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.ushiroHandle == NULL_HANDLE then
          if Enemy.SearchEnemy(_ARG_0_.myHandle, "b56ex00", SEARCH_TYPE_NEAR) ~= NULL_HANDLE then
            Entity.Out((Enemy.SearchEnemy(_ARG_0_.myHandle, "b56ex00", SEARCH_TYPE_NEAR)))
          end
          _ARG_0_:setupUshiro((Entity.CreateEntity("b56ex00", _ARG_0_.vZero, _ARG_0_.vZero, _ARG_0_.myHandle)))
        end
        _ARG_0_:GetTargetHandle(true)
        _ARG_0_.insUshiro:AlphaFade(1, 1)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_0_.MOT_IDLING)
        _ARG_0_.insUshiro:GotoState("Idling")
        _ARG_0_:GotoState("Idling")
      end
    },
    Idling = {
      OnBeginState = function(_ARG_0_)
        print("b52ex00:Idling\n")
        if _ARG_0_.AttackTimer <= 0 then
          _ARG_0_.AttackTimer = Script.RandomInRange(_UPVALUE0_, _UPVALUE1_)
        end
        if _ARG_0_.bFar then
          _ARG_0_.MoveMinDist = _UPVALUE2_ + _UPVALUE3_
          _ARG_0_.MoveMaxDist = _UPVALUE4_ + _UPVALUE3_
        else
          _ARG_0_.MoveMinDist = _UPVALUE2_
          _ARG_0_.MoveMaxDist = _UPVALUE4_
        end
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_0_.MOT_IDLING)
        _ARG_0_.insUshiro:GotoState("Idling")
      end,
      OnEndState = function(_ARG_0_)
        fRand = Script.Random()
        if fRand < _UPVALUE0_[_ARG_0_.nHarf] then
          _ARG_0_.bFar = true
        else
          _ARG_0_.bFar = false
        end
        _ARG_0_.SubDelay = 0
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:GetTargetHandle(false)
        if _ARG_0_.targetHandle == NULL_HANDLE then
          return
        end
        Entity.TurnTargetYRate(_ARG_0_.myHandle, _ARG_0_.targetHandle, _UPVALUE0_)
        _ARG_0_:GotoState("MoveIdling")
      end
    },
    MoveIdling = {
      OnBeginState = function(_ARG_0_)
        print("b52ex00:MoveIdling\n")
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_0_.MOT_IDLING)
        _ARG_0_.insUshiro:GotoState("Idling")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:GetTargetHandle(false)
        if _ARG_0_.targetHandle == NULL_HANDLE then
          return
        end
        Entity.TurnTargetYRate(_ARG_0_.myHandle, _ARG_0_.targetHandle, _UPVALUE0_)
        if Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _ARG_0_.MoveMinDist then
          _ARG_0_.nDir = _UPVALUE1_
        elseif Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _ARG_0_.MoveMaxDist then
          _ARG_0_.nDir = _UPVALUE2_
        else
          _ARG_0_.nDir = _UPVALUE3_
        end
        if _ARG_0_.nDir ~= _UPVALUE3_ then
          _ARG_0_:GotoState("Move")
        else
          if _ARG_0_:IsDanger() then
            _ARG_0_:GotoState("LRMove")
          end
          if false then
            _ARG_0_:thinkAttack((Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle)))
          end
        end
      end
    },
    Move = {
      OnBeginState = function(_ARG_0_)
        print("b52ex00:Move\n")
        _ARG_0_.insUshiro:GotoState("Move")
        _ARG_0_.Speed = 0
      end,
      OnEndState = function(_ARG_0_)
        _ARG_0_.Speed = 0
        _ARG_0_.bDmgBack = false
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:GetTargetHandle(false)
        if _ARG_0_.targetHandle ~= NULL_HANDLE then
          Entity.TurnTargetYRate(_ARG_0_.myHandle, _ARG_0_.targetHandle, _UPVALUE1_)
        end
        if Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _ARG_0_.MoveMinDist then
          _ARG_0_.nDir = _UPVALUE2_
          _ARG_0_.Acc = _UPVALUE3_
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_0_.MOT_MOVEB, 0, -1, 0, 16)
          Entity.SetMotionWithSameCheck(_ARG_0_.ushiroHandle, _ARG_0_.insUshiro.MOT_MOVEB, 29, -1, 0, 16)
          if _ARG_0_.bDmgBack then
          end
        elseif Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _ARG_0_.MoveMaxDist then
          _ARG_0_.nDir = _UPVALUE4_
          _ARG_0_.Acc = _UPVALUE3_
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_0_.MOT_MOVEF, 0, -1, 0, 16)
          Entity.SetMotionWithSameCheck(_ARG_0_.ushiroHandle, _ARG_0_.insUshiro.MOT_MOVEF, 29, -1, 0, 16)
          if _ARG_0_.bDmgBack then
            Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
            _ARG_0_.bDmgBack = false
          end
        else
          _ARG_0_.Acc = -_UPVALUE3_
          if _ARG_0_.bDmgBack then
            Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
            _ARG_0_.bDmgBack = false
          end
        end
        _ARG_0_:Move(_UPVALUE0_ * 1.5, _ARG_0_.Acc, _ARG_0_.nDir)
        if 0 >= _ARG_0_.Speed then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_0_.MOT_IDLING, 0, -1, 0, 30)
          Entity.SetMotionWithSameCheck(_ARG_0_.ushiroHandle, _ARG_0_.insUshiro.MOT_IDLING, 29, -1, 0, 30)
          _ARG_0_:GotoState("MoveIdling")
          _ARG_0_.insUshiro:GotoState("Idling")
        else
          if _ARG_0_.bDmgBack == false and (_ARG_0_:IsDanger() or Entity.IsDirWall(_ARG_0_.myHandle, 4, 1.8, _UPVALUE2_)) then
            if Entity.IsDirWall(_ARG_0_.myHandle, 4, 1.8, _UPVALUE2_) then
              if Entity.IsDirWall(_ARG_0_.myHandle, 4, 1.8, _UPVALUE5_) then
                _ARG_0_.nDir = _UPVALUE5_
              else
                _ARG_0_.nDir = _UPVALUE6_
              end
            end
            _ARG_0_:GotoState("LRMove")
          end
          if false then
            _ARG_0_:thinkAttack((Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle)))
          end
        end
      end
    },
    LRMove = {
      OnBeginState = function(_ARG_0_)
        print("b52ex00:LRMove\n")
        _ARG_0_.insUshiro:GotoState("Move")
        if _ARG_0_.nDir == _UPVALUE0_ then
          _ARG_0_.nDir = _UPVALUE1_
        elseif _ARG_0_.nDir == _UPVALUE1_ then
          _ARG_0_.nDir = _UPVALUE0_
        elseif Entity.IsTargetRight(_ARG_0_.myHandle, _ARG_0_.dangerBulletHandle) then
          _ARG_0_.nDir = _UPVALUE1_
        else
          _ARG_0_.nDir = _UPVALUE0_
        end
        if _ARG_0_.nDir == _UPVALUE1_ then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_0_.MOT_MOVEL, 0, -1, 0, -1)
          Entity.SetMotionWithSameCheck(_ARG_0_.ushiroHandle, _ARG_0_.insUshiro.MOT_MOVEL, 29, -1, 0, -1)
        else
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_0_.MOT_MOVER, 0, -1, 0, -1)
          Entity.SetMotionWithSameCheck(_ARG_0_.ushiroHandle, _ARG_0_.insUshiro.MOT_MOVER, 29, -1, 0, -1)
        end
        _ARG_0_.EvasionTimer = 16
        _ARG_0_.Acc = _UPVALUE2_ * 2
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
      end,
      OnEndState = function(_ARG_0_)
        _ARG_0_.Speed = 0
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.targetHandle ~= NULL_HANDLE then
          Entity.TurnTargetYRate(_ARG_0_.myHandle, _ARG_0_.targetHandle, _UPVALUE0_)
        end
        if _ARG_0_.EvasionTimer > 0 then
          _ARG_0_.EvasionTimer = _ARG_0_.EvasionTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
        else
          _ARG_0_.Acc = -(_UPVALUE1_ * 2) / 8
        end
        _ARG_0_:Move(_UPVALUE1_ * 2, _ARG_0_.Acc, _ARG_0_.nDir)
        if 0 >= _ARG_0_.Speed then
          if _ARG_0_:IsDanger() then
            _ARG_0_:GotoState("LRMove")
          else
            Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_0_.MOT_IDLING, 0, -1, 0, 16)
            Entity.SetMotionWithSameCheck(_ARG_0_.ushiroHandle, _ARG_0_.insUshiro.MOT_IDLING, 29, -1, 0, 16)
            _ARG_0_:GotoState("MoveIdling")
            _ARG_0_.insUshiro:GotoState("Idling")
          end
        end
      end
    },
    Attack0 = {
      OnBeginState = function(_ARG_0_)
        print("b52ex00:Attack0\n")
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        _ARG_0_.insUshiro:GotoState("Attack0")
        _ARG_0_:SetDmgFarCount()
        _ARG_0_.nStep = 0
      end,
      OnEndState = function(_ARG_0_)
        if _ARG_0_.bDmgBack == false then
          Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        end
        _ARG_0_.Speed = 0
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _UPVALUE0_ then
          _ARG_0_.nDir = _UPVALUE1_
          _ARG_0_.Acc = _UPVALUE2_
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_0_.MOT_MOVEF, 0, -1, 0, 30)
        else
          _ARG_0_.Acc = -_UPVALUE2_
        end
        _ARG_0_:Move(_UPVALUE3_, _ARG_0_.Acc, _ARG_0_.nDir)
        if 0 >= _ARG_0_.Speed then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_0_.MOT_IDLING, 0, -1, 0, 30)
        end
        Entity.TurnTargetYRate(_ARG_0_.myHandle, _ARG_0_.targetHandle, _UPVALUE4_)
        if _ARG_0_.insUshiro:GetState() == "Idling" then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    Attack1 = {
      OnBeginState = function(_ARG_0_)
        print("b52ex00:Attack1\n")
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_0_.MOT_IDLING)
        _ARG_0_.insUshiro:GotoState("Attack1")
        _ARG_0_.nStep = 0
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.insUshiro:GetState() == "Idling" then
          _ARG_0_:GotoState("Idling")
        elseif _ARG_0_.insUshiro.nStep < 2 then
          Entity.TurnTargetYRate(_ARG_0_.myHandle, _ARG_0_.targetHandle, _UPVALUE0_)
        end
      end
    },
    Attack2 = {
      OnBeginState = function(_ARG_0_)
        print("b52ex00:Attack2\n")
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_0_.MOT_IDLING)
        _ARG_0_.insUshiro:GotoState("Attack2")
        _ARG_0_.nStep = 0
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYRate(_ARG_0_.myHandle, _ARG_0_.targetHandle, _UPVALUE0_)
        if _ARG_0_.insUshiro:GetState() == "Idling" then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    Attack3 = {
      OnBeginState = function(_ARG_0_)
        print("b52ex00:Attack3\n")
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_0_.MOT_IDLING)
        _ARG_0_.insUshiro:GotoState("Attack3")
        _ARG_0_.nStep = 0
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYRate(_ARG_0_.myHandle, _ARG_0_.targetHandle, _UPVALUE0_)
        if _ARG_0_.insUshiro:GetState() == "Idling" then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    Attack4 = {
      OnBeginState = function(_ARG_0_)
        print("b52ex00:Attack4\n")
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_0_.MOT_IDLING)
        _ARG_0_.insUshiro:GotoState("Attack4")
        _ARG_0_.nStep = 0
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYRate(_ARG_0_.myHandle, _ARG_0_.targetHandle, _UPVALUE0_)
        if _ARG_0_.insUshiro:GetState() == "Idling" then
          _ARG_0_:GotoState("Idling")
        elseif _ARG_0_.insUshiro:GetState() == "Capture" then
          _ARG_0_:GotoState("Capture")
        end
      end
    },
    Capture = {
      OnBeginState = function(_ARG_0_)
        print("b52ex00:Capture\n")
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        Entity.SetMotion(_ARG_0_.myHandle, _ARG_0_.MOT_BTLMOVE)
        _ARG_0_.insKeyBlade:AlphaFade(1, 16)
        _ARG_0_:GetTargetHandle(true)
        _ARG_0_.nStep = 0
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        _ARG_0_.Speed = 0
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYRate(_ARG_0_.myHandle, _ARG_0_.targetHandle, _UPVALUE0_)
        if Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE1_ then
          _ARG_0_.bDualLimit = true
          _ARG_0_:GotoState("Attack5")
        else
          _ARG_0_.nDir = _UPVALUE2_
          _ARG_0_.Acc = 0
          _ARG_0_.Speed = _UPVALUE3_
          _ARG_0_:Move(_ARG_0_.Speed, _ARG_0_.Acc, _ARG_0_.nDir)
        end
      end
    },
    Attack5 = {
      OnBeginState = function(_ARG_0_)
        print("b52ex00:Attack5\n")
        _ARG_0_.bStatusAir = false
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        if _ARG_0_.bDualLimit == false then
          _ARG_0_.stack:push("Idling")
          _ARG_0_.insUshiro:AlphaFade(0, 16)
          _ARG_0_.insKeyBlade:AlphaFade(1, 16)
          _ARG_0_.nStep = 0
        else
          _ARG_0_.stack:push("Attack7")
          _ARG_0_.nStep = 10
        end
      end,
      OnEndState = function(_ARG_0_)
        if _ARG_0_.bDualLimit == false then
          _ARG_0_.bStatusAir = true
          _ARG_0_.insUshiro:AlphaFade(1, 16)
          _ARG_0_.insKeyBlade:AlphaFade(0, 16)
        end
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Midareuti.EndState(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.nStep == 0 then
          Entity.TurnTargetYRate(_ARG_0_.myHandle, _ARG_0_.targetHandle, _UPVALUE0_)
          if Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE1_ then
            _ARG_0_.nStep = 10
          else
            Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_0_.MOT_ATK_DASH)
            _ARG_0_.nStep = 1
          end
        elseif _ARG_0_.nStep == 1 then
          Entity.TurnTargetYRate(_ARG_0_.myHandle, _ARG_0_.targetHandle, _UPVALUE0_)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 6 then
            Entity.CalcVelocityXZ(_ARG_0_.myHandle, 0.5)
            _ARG_0_.nStep = 2
          end
        elseif _ARG_0_.nStep == 2 then
          Entity.TurnTargetYRate(_ARG_0_.myHandle, _ARG_0_.targetHandle, 1)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, 0.4)
          if Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE1_ then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.nStep = 10
          elseif Entity.IsDirWall(_ARG_0_.myHandle, 2, 1.8, _UPVALUE2_) then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        elseif _ARG_0_.nStep == 10 then
          Midareuti.BeginState(_ARG_0_)
          _ARG_0_.nStep = 11
        elseif _ARG_0_.nStep == 11 then
          Midareuti.Update(_ARG_0_)
        end
      end
    },
    Attack6 = {
      OnBeginState = function(_ARG_0_)
        print("b52ex00:Attack6\n")
        _ARG_0_.bStatusAir = false
        _ARG_0_.insUshiro:AlphaFade(0, 16)
        _ARG_0_.insKeyBlade:AlphaFade(1, 16)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        _ARG_0_.stack:push("Idling")
        Sonicimpact.BeginState(_ARG_0_)
      end,
      OnEndState = function(_ARG_0_)
        _ARG_0_.bStatusAir = true
        _ARG_0_.insUshiro:AlphaFade(1, 16)
        _ARG_0_.insKeyBlade:AlphaFade(0, 16)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Sonicimpact.EndState(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        Sonicimpact.Update(_ARG_0_)
      end
    },
    Attack7 = {
      OnBeginState = function(_ARG_0_)
        print("b52ex00:Attack7\n")
        Player.SetTrgFlagCancel(_ARG_0_.playerHandle, 1)
        _ARG_0_:EnableDamage(false)
        Entity.EnableHeavy(_ARG_0_.myHandle, 1)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_0_.MOT_BTLIDLING)
        _ARG_0_.insUshiro:SyncHp(true)
        _ARG_0_.nStep = 0
      end,
      OnEndState = function(_ARG_0_)
        _ARG_0_:EnableDamage(true)
        Entity.EnableHeavy(_ARG_0_.myHandle, 0)
        _ARG_0_.bStatusAir = true
        _ARG_0_.bDualLimit = false
        _ARG_0_.insKeyBlade:AlphaFade(0, 16)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.nStep == 0 then
          if Player.GetLimitCommand() == 0 then
            _ARG_0_.nStep = 1
          else
            _ARG_0_:GotoState("Idling")
            _ARG_0_.insUshiro:GotoState("DualLimit")
            _ARG_0_.insUshiro:GotoState("DualLimitEnd")
          end
        elseif _ARG_0_.nStep == 1 then
          Enemy.TX3StartDualLimitBg()
          _ARG_0_.nStep = 2
        elseif _ARG_0_.nStep == 2 then
          if Enemy.TX3IsStartDualLimitBg() == 1 then
            _ARG_0_.nStep = 9
            if Player.GetLimitCommand() == 0 then
              FVECTOR3.set(_ARG_0_.vWork0, 0, 0, -_UPVALUE0_)
              FVECTOR3.set(_ARG_0_.vWork1, 0, 0, 0)
              if Player.SetLimitCommand(COMMAND_KIND_DualLimit, _ARG_0_.myHandle, _ARG_0_.vWork0, FVECTOR3.gety(_ARG_0_.vWork1) + PI) == 1 then
                Entity.EnableHeavy(_ARG_0_.ushiroHandle, 1)
                Entity.EnableHeavy(_ARG_0_.myHandle, 1)
                Entity.Warp(_ARG_0_.ushiroHandle, _ARG_0_.vWork0)
                Entity.SetRot(_ARG_0_.ushiroHandle, _ARG_0_.vWork1)
                Player.Limit_WarpStartPosRot(0, _ARG_0_.myHandle)
                Entity.SetMotion(_ARG_0_.myHandle, _ARG_0_.MOT_FAINT_IN, 0, -1, 0, 0)
                FVECTOR3.set(_ARG_0_.vWork0, 0, 0, _UPVALUE0_)
                Entity.Warp(_ARG_0_.playerHandle, _ARG_0_.vWork0)
                FVECTOR3.set(_ARG_0_.vWork0, 0, PI, 0)
                Entity.SetRot(_ARG_0_.playerHandle, _ARG_0_.vWork0)
                _ARG_0_.nStep = 3
              end
            end
            if _ARG_0_.nStep == 9 then
              Entity.EnableModelAllDisp(_ARG_0_.myHandle, 0)
              _ARG_0_.insKeyBlade:AlphaFade(0, 1)
              Entity.EnableModelAllDisp(_ARG_0_.ushiroHandle, 0)
            end
          end
        elseif _ARG_0_.nStep == 3 then
          Player.ResetCamera()
          _ARG_0_.insUshiro:GotoState("DualLimit")
          Entity.ChangeModel(_ARG_0_.myHandle, "p03ex00")
          _ARG_0_.nStep = 4
        elseif _ARG_0_.nStep == 4 then
          if 1 < Enemy.TX3IsStartDualLimitBg() then
            _ARG_0_:EnableDamage(true)
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
            _ARG_0_.insUshiro:GotoState("DualLimitAtkIdling")
            _ARG_0_.nStep = 5
          end
        elseif _ARG_0_.nStep == 5 then
          FVECTOR3.set(_ARG_0_.vWork0, 0, 0, -_UPVALUE0_)
          if Entity.CalcDistanceXZ(_ARG_0_.targetHandle, _ARG_0_.vWork0) <= _UPVALUE2_ then
            _ARG_0_.insUshiro:GotoState("DualLimitWait")
            Player.Limit_SetEntry(COMMAND_KIND_DualLimit, 120)
            _ARG_0_.nStep = 10
          elseif Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_.nStep = 100
          end
        elseif _ARG_0_.nStep == 9 then
          if 1 < Enemy.TX3IsStartDualLimitBg() then
            _ARG_0_.nStep = 100
          end
        elseif _ARG_0_.nStep == 10 then
          if Player.Limit_IsNowEntry() == 0 then
            if 2 <= Player.Limit_GetMember() then
              _ARG_0_.insUshiro:GotoState("DualLimitDamagePos")
              Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_0_.MOT_DLINK)
              _ARG_0_.nStep = 11
            else
              Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_0_.MOT_FAINT_OUT)
              _ARG_0_.nStep = 100
            end
          end
        elseif _ARG_0_.nStep == 11 then
          _ARG_0_:EnableDamage(false)
          _ARG_0_.insUshiro:EnableDamage(true)
          Player.Limit_SetReady(COMMAND_KIND_DualLimit, 120)
          Player.Limit_SetMemberState(COMMAND_KIND_DualLimit, 0, 1)
          _ARG_0_.nStep = 12
        elseif _ARG_0_.nStep == 12 then
          _ARG_0_.insUshiro:setDLResult((Player.Limit_GetResult(COMMAND_KIND_DualLimit)))
          if 0 < Player.Limit_GetResult(COMMAND_KIND_DualLimit) then
            Player.Limit_SetAction(COMMAND_KIND_DualLimit, (Player.Limit_GetResult(COMMAND_KIND_DualLimit)))
            Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_0_.MOT_ATK_TLIMIT)
            _ARG_0_.nStep = 13
          end
        elseif _ARG_0_.nStep == 13 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_.nStep = 100
            if _ARG_0_.insUshiro:isDead() then
              _ARG_0_.nStep = 1000
            end
          end
        elseif _ARG_0_.nStep == 100 then
          Entity.EnableHeavy(_ARG_0_.myHandle, 0)
          _ARG_0_:EnableDamage(false)
          _ARG_0_.insUshiro:EnableDamage(false)
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_0_.MOT_BTLIDLING)
          end
          _ARG_0_.nStep = 101
        elseif _ARG_0_.nStep == 101 then
          if _ARG_0_.insUshiro:isDead() then
            _ARG_0_.nStep = 1000
          elseif _ARG_0_.insUshiro:isDamage() == false then
            Enemy.TX3EndDualLimitBg()
            _ARG_0_.nStep = 102
          end
        elseif _ARG_0_.nStep == 102 then
          if Enemy.TX3IsEndDualLimitBg() == 1 then
            Entity.EnableModelAllDisp(_ARG_0_.myHandle, 1)
            Entity.EnableModelAllDisp(_ARG_0_.ushiroHandle, 1)
            Player.SetLimitCommand(0, _ARG_0_.myHandle, _ARG_0_.vZero, 0)
            Entity.ChangeModel(_ARG_0_.myHandle, "b52ex00")
            Entity.SetMotion(_ARG_0_.myHandle, _ARG_0_.MOT_IDLING, 0, -1, 0, 0)
            Entity.SetLocalPos(_ARG_0_.myHandle, _ARG_0_.vZero)
            Entity.TurnTargetYRate(_ARG_0_.myHandle, _ARG_0_.targetHandle, 1)
            _ARG_0_.insKeyBlade:AlphaFade(0, 1)
            _ARG_0_.insUshiro:SyncHp(false)
            _ARG_0_.insUshiro:GotoState("DualLimitEnd")
            _ARG_0_.nStep = 103
          end
        elseif _ARG_0_.nStep == 103 then
          Entity.TurnTargetYRate(_ARG_0_.myHandle, _ARG_0_.targetHandle, _UPVALUE3_)
          if 1 < Enemy.TX3IsEndDualLimitBg() then
            _ARG_0_:GotoState("Idling")
          end
        elseif _ARG_0_.nStep == 1000 then
          Player.SetLimitCommand(0, _ARG_0_.myHandle, _ARG_0_.vZero, 0)
          _ARG_0_.insUshiro:endDead()
          _ARG_0_.nStep = 1001
        elseif _ARG_0_.nStep == 1001 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_0_.MOT_BTLIDLING)
        end
      end
    },
    Standby = {
      OnBeginState = function(_ARG_0_)
        print("b52ex00:Standby\n")
        _ARG_0_.stack:push(_ARG_0_:GetState())
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_0_.MOT_IDLING)
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableLockon(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if Enemy.IsAllEnemyWaiting() == false then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Dead = {
      OnBeginState = function(_ARG_0_)
        Entity.EnableLockon(_ARG_0_.myHandle, 0)
        SetupBossDead(_ARG_0_.myHandle)
        _ARG_0_.nStep = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.nStep == 0 then
          if Sound.IsInvalidateSeCall() == 1 then
            _ARG_0_.deadTimer = 60
            _ARG_0_.nStep = 1
          end
        elseif _ARG_0_.nStep == 1 then
          _ARG_0_.deadTimer = _ARG_0_.deadTimer - Script.GetVsyncFrameRate()
          if 0 >= _ARG_0_.deadTimer then
            Entity.GetWorldPos(_ARG_0_.vWork0, _ARG_0_.myHandle, 2)
            Sound.PlayVoice(108, 30, 1, _ARG_0_.vWork0, SE_OPT_ALWAYS)
            _ARG_0_.nStep = 2
          end
        end
      end
    },
    StateReflect = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":StateReflect\n")
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_0_.MOT_FLICK)
        Entity.SetMotionWithSameCheck(_ARG_0_.keyHandle, _ARG_0_.MOT_FLICK)
        _ARG_0_.insKeyBlade:AlphaFade(1, 0)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          if _ARG_0_.bDualLimit == false then
            _ARG_0_.insKeyBlade:AlphaFade(0, 16)
            _ARG_0_:GotoState("Idling")
          else
            _ARG_0_.stack:push("Attack7")
          end
        end
      end
    },
    Disappear = {
      OnBeginState = function(_ARG_0_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
      end
    }
  },
  OnInit = function(_ARG_0_, _ARG_1_)
    print("b52ex00:: OnInit\n")
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.targetHandle = NULL_HANDLE
    _ARG_0_.step = 0
    _ARG_0_.WorkTime = 0
    _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
    _ARG_0_.WorkVec = FVECTOR3.new(0, 0, 0)
    _ARG_0_.WorkVec1 = FVECTOR3.new(0, 0, 0)
    _ARG_0_.GuardFlag = 0
    _ARG_0_.nStep = 0
    _ARG_0_.Time = 0
    _ARG_0_.vRot = FVECTOR3.new(0, 0, 0)
    _ARG_0_.vZero = FVECTOR3.new(0, 0, 0)
    _ARG_0_.vWork0 = FVECTOR3.new(0, 0, 0)
    _ARG_0_.vWork1 = FVECTOR3.new(0, 0, 0)
    _ARG_0_.vWork2 = FVECTOR3.new(0, 0, 0)
    _ARG_0_.vWork3 = FVECTOR3.new(0, 0, 0)
    _ARG_0_.dangerBulletHandle = NULL_HANDLE
    _ARG_0_.playerHandle = NULL_HANDLE
    _ARG_0_.nHarf = 1
    _UPVALUE0_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "MoveSpeed")
    _UPVALUE1_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "MoveAcc")
    _UPVALUE2_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "WalkSpeed")
    _UPVALUE3_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "IdlFrameMin")
    _UPVALUE4_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "IdlFrameMax")
    _UPVALUE5_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "MoveMinDist")
    _UPVALUE6_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "MoveMaxDist")
    _UPVALUE7_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "MoveFarDist")
    _UPVALUE8_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "AtkMinDist")
    _UPVALUE9_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "AtkMaxDist")
    _UPVALUE10_[1] = Enemy.GetExtraParam(_ARG_0_.myHandle, "FarRate_1")
    _UPVALUE10_[2] = Enemy.GetExtraParam(_ARG_0_.myHandle, "FarRate_2")
    _UPVALUE11_[1] = Enemy.GetExtraParam(_ARG_0_.myHandle, "AtkRate0")
    _UPVALUE11_[2] = Enemy.GetExtraParam(_ARG_0_.myHandle, "AtkRate0")
    _UPVALUE12_[1] = Enemy.GetExtraParam(_ARG_0_.myHandle, "AtkRate2_1")
    _UPVALUE12_[2] = Enemy.GetExtraParam(_ARG_0_.myHandle, "AtkRate2_2")
    _UPVALUE13_[1] = Enemy.GetExtraParam(_ARG_0_.myHandle, "AtkRate4_1")
    _UPVALUE13_[2] = Enemy.GetExtraParam(_ARG_0_.myHandle, "AtkRate4_2")
    _UPVALUE14_[1] = Enemy.GetExtraParam(_ARG_0_.myHandle, "AtkRate5_1")
    _UPVALUE14_[2] = Enemy.GetExtraParam(_ARG_0_.myHandle, "AtkRate5_2")
    _UPVALUE15_[1] = Enemy.GetExtraParam(_ARG_0_.myHandle, "AtkRate6_1")
    _UPVALUE15_[2] = Enemy.GetExtraParam(_ARG_0_.myHandle, "AtkRate6_2")
    _UPVALUE16_[1] = Enemy.GetExtraParam(_ARG_0_.myHandle, "AtkRate1_1")
    _UPVALUE16_[2] = Enemy.GetExtraParam(_ARG_0_.myHandle, "AtkRate1_2")
    _UPVALUE17_[1] = Enemy.GetExtraParam(_ARG_0_.myHandle, "AtkRate3_1")
    _UPVALUE17_[2] = Enemy.GetExtraParam(_ARG_0_.myHandle, "AtkRate3_2")
    _ARG_0_.nDir = _UPVALUE18_
    _ARG_0_.Speed = 0
    _ARG_0_.AttackTimer = 0
    _ARG_0_.EvasionTimer = 0
    _ARG_0_.bStatusAir = true
    _ARG_0_.bDualLimit = false
    _ARG_0_.bFar = false
    _ARG_0_.bDmgBack = false
    _ARG_0_.MoveMinDist = _UPVALUE5_
    _ARG_0_.MoveMaxDist = _UPVALUE6_
    _ARG_0_.bPlayerDead = false
    _ARG_0_.deadTimer = 0
    _ARG_0_.nDmgHamariCount = 0
    _ARG_0_:SetDmgCount()
    _ARG_0_:SetDmgFarCount()
    _ARG_0_:CreateKeyBlade(_ARG_1_)
    _ARG_0_.ushiroHandle = NULL_HANDLE
    _ARG_0_.insUshiro = NULL_HANDLE
    _ARG_0_.stack = Stack:Create()
    _ARG_0_.MOT_APPEAR = Entity.GetMotionIndex(_ARG_1_, "414")
    _ARG_0_.MOT_BTLIDLING = Entity.GetMotionIndex(_ARG_1_, "002")
    _ARG_0_.MOT_BTLMOVE = Entity.GetMotionIndex(_ARG_1_, "003")
    _ARG_0_.MOT_BTLRUN = Entity.GetMotionIndex(_ARG_1_, "004")
    _ARG_0_.MOT_IDLING = Entity.GetMotionIndex(_ARG_1_, "010")
    _ARG_0_.MOT_MOVEF = Entity.GetMotionIndex(_ARG_1_, "030")
    _ARG_0_.MOT_MOVEB = Entity.GetMotionIndex(_ARG_1_, "031")
    _ARG_0_.MOT_MOVER = Entity.GetMotionIndex(_ARG_1_, "032")
    _ARG_0_.MOT_MOVEL = Entity.GetMotionIndex(_ARG_1_, "033")
    _ARG_0_.MOT_ATK_DASH = Entity.GetMotionIndex(_ARG_1_, "008")
    _ARG_0_.MOT_ATK_SONICIMPACT = Entity.GetMotionIndex(_ARG_1_, "015")
    _ARG_0_.MOT_ATK_STRIKE0 = Entity.GetMotionIndex(_ARG_1_, "377")
    _ARG_0_.MOT_ATK_STRIKE1 = Entity.GetMotionIndex(_ARG_1_, "378")
    _ARG_0_.MOT_ATK_STRIKE2 = Entity.GetMotionIndex(_ARG_1_, "379")
    _ARG_0_.MOT_ATK_STRIKE3 = Entity.GetMotionIndex(_ARG_1_, "380")
    _ARG_0_.MOT_ATK_TLIMIT = Entity.GetMotionIndex(_ARG_1_, "557")
    _ARG_0_.MOT_DLINK = Entity.GetMotionIndex(_ARG_1_, "600")
    _ARG_0_.MOT_DMG_S_SMALLF = Entity.GetMotionIndex(_ARG_1_, "200")
    _ARG_0_.MOT_DMG_S_SMALLB = Entity.GetMotionIndex(_ARG_1_, "202")
    _ARG_0_.MOT_DMG_S_BIGF_IN = Entity.GetMotionIndex(_ARG_1_, "204")
    _ARG_0_.MOT_DMG_S_BIGF_OUT = Entity.GetMotionIndex(_ARG_1_, "205")
    _ARG_0_.MOT_DMG_S_BIGB_INT = Entity.GetMotionIndex(_ARG_1_, "206")
    _ARG_0_.MOT_DMG_S_BIGB_OUT = Entity.GetMotionIndex(_ARG_1_, "207")
    _ARG_0_.MOT_DMG_S_SMALLAIRF = Entity.GetMotionIndex(_ARG_1_, "214")
    _ARG_0_.MOT_DMG_S_SMALLAIRB = Entity.GetMotionIndex(_ARG_1_, "215")
    _ARG_0_.MOT_FLICK = Entity.GetMotionIndex(_ARG_1_, "208")
    _ARG_0_.MOT_FLICKAIR = Entity.GetMotionIndex(_ARG_1_, "209")
    _ARG_0_.MOT_FAINT_IN = Entity.GetMotionIndex(_ARG_1_, "212")
    _ARG_0_.MOT_FAINT_OUT = Entity.GetMotionIndex(_ARG_1_, "213")
    _ARG_0_.MOT_DMG_SMALLF = Entity.GetMotionIndex(_ARG_1_, "220")
    _ARG_0_.MOT_DMG_SMALLB = Entity.GetMotionIndex(_ARG_1_, "221")
    _ARG_0_.MOT_DMG_BIGF_IN = Entity.GetMotionIndex(_ARG_1_, "222")
    _ARG_0_.MOT_DMG_BIGF_OUT = Entity.GetMotionIndex(_ARG_1_, "223")
    _ARG_0_.MOT_DMG_BIGB_INT = Entity.GetMotionIndex(_ARG_1_, "224")
    _ARG_0_.MOT_DMG_BIGB_OUT = Entity.GetMotionIndex(_ARG_1_, "225")
    _UPVALUE19_[1][1] = _ARG_0_.MOT_DMG_SMALLF
    _UPVALUE19_[1][2] = _ARG_0_.MOT_DMG_SMALLF
    _UPVALUE19_[1][3] = _ARG_0_.MOT_DMG_SMALLB
    _UPVALUE19_[1][4] = _ARG_0_.MOT_DMG_SMALLB
    _UPVALUE19_[1][5] = _ARG_0_.MOT_DMG_SMALLF
    _UPVALUE19_[1][6] = _ARG_0_.MOT_DMG_SMALLB
    _UPVALUE19_[1][7] = _ARG_0_.MOT_DMG_BIGF_IN
    _UPVALUE19_[1][8] = _ARG_0_.MOT_DMG_BIGB_IN
    _UPVALUE19_[1][9] = _ARG_0_.MOT_DMG_BIGF_OUT
    _UPVALUE19_[1][10] = _ARG_0_.MOT_DMG_BIGB_OUT
    _UPVALUE19_[1][11] = -1
    _UPVALUE19_[1][12] = -1
    _UPVALUE19_[1][13] = _ARG_0_.MOT_FLICK
    _UPVALUE19_[1][14] = _ARG_0_.MOT_FAINT_IN
    _UPVALUE19_[1][15] = _ARG_0_.MOT_FAINT_OUT
    _UPVALUE19_[1][16] = _ARG_0_.MOT_FLICKAIR
    _UPVALUE19_[1][17] = -1
    _UPVALUE19_[2][1] = _ARG_0_.MOT_DMG_S_SMALLF
    _UPVALUE19_[2][2] = _ARG_0_.MOT_DMG_S_SMALLF
    _UPVALUE19_[2][3] = _ARG_0_.MOT_DMG_S_SMALLB
    _UPVALUE19_[2][4] = _ARG_0_.MOT_DMG_S_SMALLB
    _UPVALUE19_[2][5] = _ARG_0_.MOT_DMG_S_SMALLAIRF
    _UPVALUE19_[2][6] = _ARG_0_.MOT_DMG_S_SMALLAIRB
    _UPVALUE19_[2][7] = _ARG_0_.MOT_DMG_S_BIGF_IN
    _UPVALUE19_[2][8] = _ARG_0_.MOT_DMG_S_BIGB_IN
    _UPVALUE19_[2][9] = _ARG_0_.MOT_DMG_S_BIGF_OUT
    _UPVALUE19_[2][10] = _ARG_0_.MOT_DMG_S_BIGB_OUT
    _UPVALUE19_[2][11] = -1
    _UPVALUE19_[2][12] = -1
    _UPVALUE19_[2][13] = _ARG_0_.MOT_FLICK
    _UPVALUE19_[2][14] = _ARG_0_.MOT_FAINT_IN
    _UPVALUE19_[2][15] = _ARG_0_.MOT_FAINT_OUT
    _UPVALUE19_[2][16] = _ARG_0_.MOT_FLICKAIR
    _UPVALUE19_[2][17] = -1
    Entity.SetMovementCollRadius(_ARG_0_.myHandle, 1.5)
    Entity.SetLowerHalf(_ARG_0_.myHandle, 1.8)
    _ARG_0_:UpdateBGColl()
    Entity.EnableCameraBodyColl(_ARG_0_.myHandle, 1)
    Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
    Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
    Entity.EnableLockon(_ARG_0_.myHandle, 0)
    Entity.EnableGravity(_ARG_0_.myHandle, 1)
    _ARG_0_:GotoState("Appear")
    if Enemy.IsAllEnemyWaiting() == true then
      _ARG_0_:GotoState("Standby")
      Entity.EnableLockon(_ARG_0_.myHandle, 0)
    end
    print("b52ex00:: OnInitEnd\n")
  end,
  OnDamage = function(_ARG_0_, _ARG_1_)
    print("b52ex00:OnDamage\n")
    _ARG_0_.nDmgHamariCount = 0
    if _ARG_0_:GetState() == "Attack7" then
      print("Damage b52ex00:Attack7Faild\n")
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_0_.MOT_DMG_S_SMALLF)
      Player.SetLimitCommand(0, _ARG_0_.myHandle, _ARG_0_.vZero, 0)
      Enemy.SetHP(_ARG_0_.myHandle, (Enemy.GetHp(_ARG_0_.ushiroHandle)))
      _ARG_0_.nStep = 100
    else
    end
    return (_ARG_0_:EscapeDamege())
  end,
  EscapeDamege = function(_ARG_0_)
    if Enemy.GetHp(_ARG_0_.myHandle) < Enemy.GetHpMax(_ARG_0_.myHandle) / 2 then
      _ARG_0_.nHarf = 2
    end
    if Enemy.IsNoDamageReaction(_ARG_0_.myHandle) == false then
      _ARG_0_.nDmgCount = _ARG_0_.nDmgCount - 1
      if 0 >= _ARG_0_.nDmgCount then
        _ARG_0_:GetTargetHandle(true)
        _ARG_0_:SetDmgCount()
        if Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE0_ then
          _ARG_0_:GotoState("Attack0")
          _ARG_0_.bDmgBack = true
          _ARG_0_.bFar = true
          _ARG_0_.AttackTimer = 60
        else
          _ARG_0_.AttackTimer = 0
          _ARG_0_:thinkAttack((Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle)))
        end
      end
    end
    if 1 == 0 and (_ARG_0_:GetState() == "Attack1" or _ARG_0_:GetState() == "Attack3") and Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.playerHandle) >= _UPVALUE1_ then
      _ARG_0_.nDmgFarCount = _ARG_0_.nDmgFarCount - 1
      if 0 >= _ARG_0_.nDmgFarCount then
        _ARG_0_:GetTargetHandle(true)
        _ARG_0_:SetDmgFarCount()
        _ARG_0_.insUshiro:GotoState("Idling")
        _ARG_0_:GotoState("Attack5")
      end
    end
    return 1
  end,
  GetDamageMotionNum = function(_ARG_0_, _ARG_1_)
    if _ARG_0_.bStatusAir then
      if _UPVALUE0_[1][_ARG_1_ + 1] >= 0 then
        Entity.SetMotion(_ARG_0_.ushiroHandle, _UPVALUE0_[1][_ARG_1_ + 1], 29)
      end
    else
    end
    return _UPVALUE0_[2][_ARG_1_ + 1]
  end,
  OnDamageBefore = function(_ARG_0_, _ARG_1_)
    if _ARG_0_.nDmgHamariCount >= 1 then
    end
    _ARG_0_.nDmgHamariCount = _ARG_0_.nDmgHamariCount + 1
    return (_ARG_0_:EscapeDamege())
  end,
  OnReturnDamage = function(_ARG_0_)
    print("b52ex00:OnReturnDamage\n")
    _ARG_0_:SetDmgCount()
    _ARG_0_:GotoState("MoveIdling")
  end,
  OnHitAttack = function(_ARG_0_)
  end,
  OnReflect = function(_ARG_0_)
    print("b52ex00 : OnReflect\n")
    return 1
  end,
  OnDead = function(_ARG_0_)
    print("b52ex00:OnDead\n")
    if _ARG_0_:GetState() == "Attack7" then
      print("Dead   b52ex00:Attack7Faild\n")
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_0_.MOT_DMG_S_SMALLF)
      Player.SetLimitCommand(0, _ARG_0_.myHandle, _ARG_0_.vZero, 0)
      Enemy.SetHP(_ARG_0_.myHandle, (Enemy.GetHp(_ARG_0_.ushiroHandle)))
      _ARG_0_.nStep = 100
    else
      _ARG_0_:GotoState("Dead")
      _ARG_0_.insUshiro:GotoState("Dead")
    end
    return 1
  end,
  Debug = function(_ARG_0_)
    if Script.IsDebugCheckAttack() then
      if _ARG_0_:GetState() ~= "Idling" then
        return
      end
      print("b52ex00:Debug Attack\n")
      if _UPVALUE0_[Script.GetDebugAttackNumber() + 1] ~= nil then
        _ARG_0_:GotoState(_UPVALUE0_[Script.GetDebugAttackNumber() + 1])
      end
    end
  end,
  OnUpdate = function(_ARG_0_)
    _ARG_0_:Update()
    _ARG_0_:Debug()
    _ARG_0_:UpdateBGColl()
    if _ARG_0_.bPlayerDead == false and Player.IsBattleFlagPlayerDead() then
      print("b52ex00:PlayerDead!!\n")
      Entity.GetWorldPos(_ARG_0_.vWork0, _ARG_0_.myHandle, 2)
      Sound.PlayVoice(108, 26, 1, _ARG_0_.vWork0, SE_OPT_ALWAYS)
      _ARG_0_.bPlayerDead = true
    end
  end,
  SetingGuard = function(_ARG_0_)
    Entity.EnableGuard(_ARG_0_.myHandle, 1)
    Entity.EnableGuardPhysical(_ARG_0_.myHandle, 1)
    Entity.EnableGuardZero(_ARG_0_.myHandle, 1)
    Entity.EnableGuardFire(_ARG_0_.myHandle, 1)
    Entity.EnableGuardIce(_ARG_0_.myHandle, 1)
    Entity.EnableGuardThunder(_ARG_0_.myHandle, 1)
    Entity.SetGuardDir(_ARG_0_.myHandle, 360)
    Entity.EnableGuardSpecial(_ARG_0_.myHandle, 1)
  end,
  EndGuard = function(_ARG_0_)
    Entity.EnableGuard(_ARG_0_.myHandle, 0)
    Entity.EnableGuardPhysical(_ARG_0_.myHandle, 0)
    Entity.EnableGuardZero(_ARG_0_.myHandle, 0)
    Entity.EnableGuardFire(_ARG_0_.myHandle, 0)
    Entity.EnableGuardIce(_ARG_0_.myHandle, 0)
    Entity.EnableGuardThunder(_ARG_0_.myHandle, 0)
    Entity.SetGuardDir(_ARG_0_.myHandle, 0)
    Entity.EnableGuardSpecial(_ARG_0_.myHandle, 0)
  end,
  Move = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    _ARG_0_.Speed = _ARG_0_.Speed + _ARG_2_ * Entity.GetFrameRate(_ARG_0_.myHandle)
    if _ARG_1_ < _ARG_0_.Speed then
      _ARG_0_.Speed = _ARG_1_
    elseif _ARG_0_.Speed < 0 then
      _ARG_0_.Speed = 0
    end
    if _ARG_3_ == _UPVALUE0_ then
      FVECTOR3.set(_ARG_0_.vWork0, 0, 0, _ARG_0_.Speed)
    elseif _ARG_3_ == _UPVALUE1_ then
      FVECTOR3.set(_ARG_0_.vWork0, 0, 0, -_ARG_0_.Speed)
    elseif _ARG_3_ == _UPVALUE2_ then
      FVECTOR3.set(_ARG_0_.vWork0, _ARG_0_.Speed, 0, 0)
    elseif _ARG_3_ == _UPVALUE3_ then
      FVECTOR3.set(_ARG_0_.vWork0, -_ARG_0_.Speed, 0, 0)
    else
      FVECTOR3.set(_ARG_0_.vWork0, 0, 0, 0)
    end
    Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.vWork0)
  end,
  thinkAttack = function(_ARG_0_, _ARG_1_)
    if _ARG_0_.targetHandle == NULL_HANDLE then
      return
    end
    _ARG_0_.AttackTimer = _ARG_0_.AttackTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
    if _ARG_0_.AttackTimer <= 0 then
      print("b52ex00:Go to Attack\n")
      if _ARG_1_ < _UPVALUE0_ then
        _ARG_0_:GotoState("Attack0")
      elseif _ARG_1_ < _UPVALUE1_ then
        if Enemy.GetHp(_ARG_0_.myHandle) <= _ARG_0_.insUshiro:getDLDamage() then
          _ARG_0_:GotoState("Attack4")
        elseif 0 > Script.Random() * (_UPVALUE2_[_ARG_0_.nHarf] + _UPVALUE3_[_ARG_0_.nHarf] + _UPVALUE4_[_ARG_0_.nHarf] + _UPVALUE5_[_ARG_0_.nHarf]) - _UPVALUE2_[_ARG_0_.nHarf] then
          _ARG_0_:GotoState("Attack2")
        elseif 0 > Script.Random() * (_UPVALUE2_[_ARG_0_.nHarf] + _UPVALUE3_[_ARG_0_.nHarf] + _UPVALUE4_[_ARG_0_.nHarf] + _UPVALUE5_[_ARG_0_.nHarf]) - (_UPVALUE2_[_ARG_0_.nHarf] + _UPVALUE4_[_ARG_0_.nHarf]) then
          _ARG_0_:GotoState("Attack5")
        elseif 0 > Script.Random() * (_UPVALUE2_[_ARG_0_.nHarf] + _UPVALUE3_[_ARG_0_.nHarf] + _UPVALUE4_[_ARG_0_.nHarf] + _UPVALUE5_[_ARG_0_.nHarf]) - (_UPVALUE2_[_ARG_0_.nHarf] + _UPVALUE4_[_ARG_0_.nHarf] + _UPVALUE5_[_ARG_0_.nHarf]) then
          _ARG_0_:GotoState("Attack6")
        else
          _ARG_0_:GotoState("Attack4")
        end
      elseif 0 > Script.Random() * (_UPVALUE2_[_ARG_0_.nHarf] + _UPVALUE3_[_ARG_0_.nHarf] + _UPVALUE4_[_ARG_0_.nHarf] + _UPVALUE5_[_ARG_0_.nHarf]) * (_UPVALUE6_[_ARG_0_.nHarf] + _UPVALUE7_[_ARG_0_.nHarf]) - _UPVALUE6_[_ARG_0_.nHarf] then
        _ARG_0_:GotoState("Attack1")
      else
        _ARG_0_:GotoState("Attack3")
      end
    end
  end,
  UpdateBGColl = function(_ARG_0_)
    FVECTOR3.set(_ARG_0_.vWork0, 0, 0, -0.7)
    Entity.GetRot(_ARG_0_.vRot, _ARG_0_.myHandle)
    Math.RotateVectorXYZ(_ARG_0_.vWork0, _ARG_0_.vRot)
    Entity.SetMovementOffset(_ARG_0_.myHandle, _ARG_0_.vWork0)
  end,
  EnableDamage = function(_ARG_0_, _ARG_1_)
    if _ARG_1_ == true then
      Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
      Entity.EnableLockon(_ARG_0_.myHandle, 1)
    else
      Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
      Entity.EnableLockon(_ARG_0_.myHandle, 0)
    end
  end,
  SetDmgCount = function(_ARG_0_)
    _ARG_0_.nDmgCount = Script.RandomInteger(4) + 2
  end,
  SetDmgFarCount = function(_ARG_0_)
    _ARG_0_.nDmgFarCount = Script.RandomInteger(3) + 2
  end,
  GetTargetHandle = function(_ARG_0_, _ARG_1_)
    _ARG_0_.playerHandle = Player.GetHandle()
    if _ARG_1_ then
      _ARG_0_.targetHandle = _ARG_0_.playerHandle
    else
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
    end
    _ARG_0_.insUshiro.targetHandle = _ARG_0_.targetHandle
  end,
  IsDanger = function(_ARG_0_)
    Entity.GetLocalPos(_ARG_0_.vWork0, _ARG_0_.myHandle)
    _ARG_0_.dangerBulletHandle = Player.GetNearBullet(_ARG_0_.playerHandle, _ARG_0_.vWork0)
    return true
  end,
  setupUshiro = function(_ARG_0_, _ARG_1_)
    _ARG_0_.ushiroHandle = _ARG_1_
    Entity.SetLocalPos(_ARG_0_.ushiroHandle, _ARG_0_.vZero)
    Entity.SetRot(_ARG_0_.ushiroHandle, _ARG_0_.vZero)
    Entity.AttachCoord(_ARG_0_.myHandle, "Root", _ARG_0_.ushiroHandle, "Root")
    _ARG_0_.insUshiro = EntityManager:GetEntity(_ARG_0_.ushiroHandle)
    _ARG_0_.insUshiro.terraHandle = _ARG_0_.myHandle
    _ARG_0_.insUshiro.insTerra = EntityManager:GetEntity(_ARG_0_.myHandle)
    Enemy.InitHP(_ARG_0_.ushiroHandle, (Enemy.GetHpMax(_ARG_0_.myHandle)))
  end,
  CreateKeyBlade = function(_ARG_0_, _ARG_1_)
    _ARG_0_.keyHandle = Entity.CreateEntity("b53ex00", _ARG_0_.vZero, _ARG_0_.vZero, _ARG_1_)
    Entity.AttachCoord(_ARG_1_, "R_buki", _ARG_0_.keyHandle, "Root")
    Entity.EnableLockonAndShooton(_ARG_0_.keyHandle, 0)
    _ARG_0_.insKeyBlade = EntityManager:GetEntity(_ARG_0_.keyHandle)
    _ARG_0_.insKeyBlade.Master = _ARG_1_
    _ARG_0_.insKeyBlade:AlphaFade(0, 1)
  end,
  GetSpeed = function(_ARG_0_, _ARG_1_)
    return _UPVALUE0_[_ARG_1_].Speed
  end,
  GetSpeed2 = function(_ARG_0_, _ARG_1_)
    return _UPVALUE0_[_ARG_1_].Speed2
  end,
  GetCancelTime = function(_ARG_0_, _ARG_1_)
    return _UPVALUE0_[_ARG_1_].CancelTime
  end,
  GetGroupNum = function(_ARG_0_, _ARG_1_)
    return _UPVALUE0_[_ARG_1_].GroupNum
  end,
  SetMotionEx = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_[_ARG_1_].MotionName, _ARG_2_, _ARG_3_)
    Entity.SetMotionWithSameCheck(_ARG_0_.keyHandle, _UPVALUE0_[_ARG_1_].MotionName, _ARG_2_, _ARG_3_)
    _ARG_0_.GuardFlag = 0
  end,
  SetMotionEx_1 = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_[_ARG_1_].MotionName1, _ARG_2_, _ARG_3_)
    Entity.SetMotionWithSameCheck(_ARG_0_.keyHandle, _UPVALUE0_[_ARG_1_].MotionName1, _ARG_2_, _ARG_3_)
    _ARG_0_.GuardFlag = 0
  end,
  SetMotionEx_2 = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_[_ARG_1_].MotionName2, _ARG_2_, _ARG_3_)
    Entity.SetMotionWithSameCheck(_ARG_0_.keyHandle, _UPVALUE0_[_ARG_1_].MotionName2, _ARG_2_, _ARG_3_)
    _ARG_0_.GuardFlag = 0
  end,
  SetMotionEx_3 = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_[_ARG_1_].MotionName3, _ARG_2_, _ARG_3_)
    Entity.SetMotionWithSameCheck(_ARG_0_.keyHandle, _UPVALUE0_[_ARG_1_].MotionName3, _ARG_2_, _ARG_3_)
    _ARG_0_.GuardFlag = 0
  end
}, {__index = __StateMachine})
EntityFactory:Add("b52ex00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
PLBBASE_COMMAND_SPECIAL1 = 1
PLBBASE_COMMAND_ATTACKCOM2 = 2
b53ex00 = {}
b53ex00_base_mt = {__index = __StateMachine}
setmetatable(b53ex00, b53ex00_base_mt)
b53ex00_mt = {__index = b53ex00}
function b53ex00.new(_ARG_0_)
  print("b53ex00:new()\n")
  return setmetatable(__StateMachine:new(), b53ex00_mt)
end
function b53ex00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.Master = 0
  _ARG_0_.HitAttackFlag = 0
  _ARG_0_.friendFlag = 0
end
function b53ex00.OnHitAttack(_ARG_0_)
  _ARG_0_.HitAttackFlag = 1
end
function b53ex00.OnReflect(_ARG_0_)
  print("b53ex00 : OnReflect\n")
  if EntityManager:GetEntity(_ARG_0_.Master).bDualLimit == false then
    EntityManager:GetEntity(_ARG_0_.Master):GotoState("StateReflect")
  end
  return 1
end
function b53ex00.OnUpdate(_ARG_0_)
  Entity.SetAttacker(_ARG_0_.myHandle, _ARG_0_.Master)
  if _ARG_0_.friendFlag == 1 then
    Entity.SetCollKindForAAC(_ARG_0_.myHandle, COLL_KIND_PLAYER)
    Enemy.EnableTargetEnemy(_ARG_0_.myHandle, 1)
  end
end
EntityFactory:Add("b53ex00", function(_ARG_0_)
  return (b53ex00:new())
end)
function b53ex00.AlphaFade(_ARG_0_, _ARG_1_, _ARG_2_)
  Entity.SetupModelFade(_ARG_0_.myHandle, Entity.GetAlpha(_ARG_0_.myHandle), _ARG_1_, _ARG_2_)
end
