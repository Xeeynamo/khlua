b10he00 = {}
b10he00_base_mt = {__index = __StateMachine}
setmetatable(b10he00, b10he00_base_mt)
b10he00_mt = {__index = b10he00}
function b10he00.new(_ARG_0_)
  return setmetatable(__StateMachine:new(), b10he00_mt)
end
b10he00.states = {
  Appear = {
    OnBeginState = function(_ARG_0_)
      SetupAppearBegin2(_ARG_0_.myHandle, 1, _UPVALUE0_, 0)
    end,
    OnEndState = function(_ARG_0_)
      SetupAppearEnd(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Idling = {
    OnBeginState = function(_ARG_0_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_ - _ARG_0_.SubDelay)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_FAR)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
        return
      end
      if Enemy.SearchEnemy(_ARG_0_.myHandle, "b01he00", SEARCH_TYPE_NEAR) == NULL_HANDLE then
        _ARG_0_.AttackFlag = 1
        _ARG_0_.ModeType = _UPVALUE0_
      else
        _ARG_0_.AttackFlag = 0
      end
      _ARG_0_:GotoState("Move")
    end
  },
  Move = {
    OnBeginState = function(_ARG_0_)
      print("b10he00:Move\n")
      if _ARG_0_:WhichRightandLeft() == 1 then
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.step = 0
      else
        _ARG_0_.step = 1
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
      end
      Entity.SetTimer(_ARG_0_.myHandle, 80)
      print("self.AttackFlag" .. _ARG_0_.AttackFlag .. "\n")
      _ARG_0_.waveFlag = 0
      _ARG_0_.footFlag = 0
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_FAR)
      _ARG_0_.shootMaxFrame = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        if Entity.IsTargetWithinFOV(_ARG_0_.myHandle, _ARG_0_.targetHandle, DegToRad(130)) == true then
          _ARG_0_:GotoState("Search")
          return
        end
        if _ARG_0_:WhichRightandLeft() == 1 then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
          _ARG_0_.step = 0
        else
          _ARG_0_.step = 1
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
        end
        _ARG_0_.waveFlag = 0
        _ARG_0_.footFlag = 0
        if Entity.IsTargetWithinFOV(_ARG_0_.myHandle, _ARG_0_.targetHandle, DegToRad(160)) ~= true or _ARG_0_:CheckPlayerEnshrining() == 0 then
        else
          _ARG_0_:GotoState("IceSpeirMaxMode")
          return
        end
      end
      if Entity.IsTargetWithinFOV(_ARG_0_.myHandle, _ARG_0_.targetHandle, DegToRad(40)) == true then
      else
      end
      if _ARG_0_.step == 0 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 20 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) < 76 then
          Entity.GetRot(_ARG_0_.workVec, _ARG_0_.myHandle)
          _ARG_0_.workVec:sety(_ARG_0_.workVec:gety() + DegToRad(0.4) * Entity.GetFrameRate(_ARG_0_.myHandle))
          Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.workVec)
          if _ARG_0_.waveFlag == 0 then
            if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > _UPVALUE2_ then
              _ARG_0_:CreateShockwave(_ARG_0_.myHandle, _UPVALUE3_, 0, 0)
              _ARG_0_.waveFlag = 1
              _ARG_0_.footFlag = 1
            end
            if _ARG_0_.footFlag == 0 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 20 then
              SetFootModel(_ARG_0_.myHandle, 3)
              _ARG_0_.footFlag = 1
            end
          elseif _ARG_0_.waveFlag == 1 then
            if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > _UPVALUE4_ then
              _ARG_0_:CreateShockwave(_ARG_0_.myHandle, _UPVALUE5_, 0, 0)
              _ARG_0_.waveFlag = 2
              _ARG_0_.footFlag = 2
            end
            if _ARG_0_.footFlag == 1 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 48 then
              SetFootModel(_ARG_0_.myHandle, 2)
              _ARG_0_.footFlag = 2
            end
          end
        else
          Entity.ClearSpeed(_ARG_0_.myHandle)
        end
      elseif _ARG_0_.step == 1 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 20 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) < 76 then
          Entity.GetRot(_ARG_0_.workVec, _ARG_0_.myHandle)
          _ARG_0_.workVec:sety(_ARG_0_.workVec:gety() - DegToRad(0.4) * Entity.GetFrameRate(_ARG_0_.myHandle))
          Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.workVec)
          if _ARG_0_.waveFlag == 0 then
            if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > _UPVALUE6_ then
              _ARG_0_:CreateShockwave(_ARG_0_.myHandle, _UPVALUE5_, 0, 0)
              _ARG_0_.waveFlag = 1
            end
          elseif _ARG_0_.waveFlag == 1 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) > _UPVALUE7_ then
            _ARG_0_:CreateShockwave(_ARG_0_.myHandle, _UPVALUE3_, 0, 0)
            _ARG_0_.waveFlag = 2
          end
          if _ARG_0_.footFlag == 0 then
            if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 20 then
              SetFootModel(_ARG_0_.myHandle, 0)
              _ARG_0_.footFlag = 1
            end
          elseif _ARG_0_.footFlag == 1 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 48 then
            SetFootModel(_ARG_0_.myHandle, 1)
            _ARG_0_.footFlag = 2
          end
        else
          Entity.ClearSpeed(_ARG_0_.myHandle)
        end
      end
    end
  },
  Search = {
    OnBeginState = function(_ARG_0_)
      print("b10he00:Search\n")
      Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_.AttackDelay)
      print("self.AttackFlag" .. _ARG_0_.AttackFlag .. "\n")
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
        return
      end
      if _ARG_0_.AttackFlag == 0 then
        _ARG_0_:GotoState("Move")
        return
      end
      if Entity.IsTargetWithinFOV(_ARG_0_.myHandle, _ARG_0_.targetHandle, DegToRad(160)) ~= true or _ARG_0_:CheckPlayerEnshrining() == 0 then
      else
        _ARG_0_:GotoState("IceSpeirMaxMode")
        return
      end
      if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE0_ then
        if _UPVALUE1_ > Script.Random() then
          _ARG_0_:GotoState("IceBreath")
        elseif _ARG_0_.ModeType == _UPVALUE2_ then
          _ARG_0_:GotoState("IceImpactBig")
        else
          _ARG_0_:GotoState("IceImpact")
        end
      elseif _ARG_0_.ModeType == _UPVALUE2_ then
        _ARG_0_:GotoState("IceSpeirMaxMode")
      else
        _ARG_0_:GotoState("IceSpeir")
      end
    end
  },
  IceBreath = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_.AttackFlag = 2
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 35 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) < 70 then
        _ARG_0_.nextShotFrame = _ARG_0_.nextShotFrame - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.nextShotFrame < 0 then
          _ARG_0_:CreateBreath(_ARG_0_.myHandle)
          _ARG_0_.nextShotFrame = 6
        end
      end
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
        _ARG_0_.AttackDelay = Script.Random() * _UPVALUE0_
      end
    end
  },
  IceImpact = {
    OnBeginState = function(_ARG_0_)
      print("b10he00:IceImpact\n")
      if _ARG_0_.ModeType == _UPVALUE0_ then
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_, 1, 1)
      else
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
      end
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE2_)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_.AttackFlag = 2
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 24 then
          _ARG_0_:CreateShockwave(_ARG_0_.myHandle, _UPVALUE0_, 2, 0)
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 then
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
          _ARG_0_.step = 2
        end
      elseif _ARG_0_.step == 2 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
        _ARG_0_.AttackDelay = Script.Random() * _UPVALUE2_
      end
    end
  },
  IceImpactBig = {
    OnBeginState = function(_ARG_0_)
      print("b10he00:IceImpactBig\n")
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 1)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_.AttackFlag = 2
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 24 then
          _ARG_0_:CreateShockwave(_ARG_0_.myHandle, _UPVALUE0_, 3, 1)
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 then
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
          _ARG_0_.step = 2
        end
      elseif _ARG_0_.step == 2 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
        _ARG_0_.AttackDelay = Script.Random() * _UPVALUE2_
      end
    end
  },
  IceSpeir = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
      _ARG_0_.nextShotFrame = 0
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_.AttackFlag = 2
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 33 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) < 50 then
        _ARG_0_.nextShotFrame = _ARG_0_.nextShotFrame - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.nextShotFrame < 0 then
          if _ARG_0_.ModeType == _UPVALUE0_ then
            _ARG_0_:CreateBullet(_ARG_0_.myHandle, "b10he00", "B011_SPA_03_0", "B011_HIT_04_0", "B011_SPA_01_0", 5, _ARG_0_.step)
          else
            _ARG_0_:CreateBullet(_ARG_0_.myHandle, "b10he00", "B011_SPA_02_0", "B011_HIT_03_0", "B011_SPA_00_0", 4, _ARG_0_.step)
          end
          _ARG_0_.nextShotFrame = 6
          if _ARG_0_.step == 0 then
            _ARG_0_.step = 1
          end
        end
      end
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
        _ARG_0_.AttackDelay = Script.Random() * _UPVALUE1_
      end
    end
  },
  IceSpeirBig = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
      _ARG_0_.nextShotFrame = 0
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_.AttackFlag = 2
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 33 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) < 44 then
        _ARG_0_.nextShotFrame = _ARG_0_.nextShotFrame - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.nextShotFrame < 0 then
          _ARG_0_:CreateBullet(_ARG_0_.myHandle, "b10he00", "B011_SPA_03_0", "B011_HIT_04_0", "B011_SPA_01_0", 5, _ARG_0_.step)
          _ARG_0_.nextShotFrame = 6
          if _ARG_0_.step == 0 then
            _ARG_0_.step = 1
          end
        end
      end
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
        _ARG_0_.AttackDelay = Script.Random() * _UPVALUE0_
      end
    end
  },
  IceSpeirMaxMode = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
      _ARG_0_.nextShotFrame = 0
      _ARG_0_.shootMaxFrame = _ARG_0_.shootMaxFrame + 1
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_.AttackFlag = 2
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.shootMaxFrame < 2 then
      elseif _ARG_0_.shootMaxFrame < 4 then
      else
      end
      if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 22 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) < 88 then
        _ARG_0_.nextShotFrame = _ARG_0_.nextShotFrame - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.nextShotFrame < 0 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) < 35 then
            if _ARG_0_.shootMaxFrame < 2 then
              if _ARG_0_.ModeType == _UPVALUE0_ then
                _ARG_0_:CreateBulletEx(_ARG_0_.myHandle, "b10he00", "B011_SPA_03_0", "B011_HIT_04_0", "B011_SPA_01_0", 5, 0)
              else
                _ARG_0_:CreateBulletEx(_ARG_0_.myHandle, "b10he00", "B011_SPA_02_0", "B011_HIT_03_0", "B011_SPA_00_0", 4, 0)
              end
              _ARG_0_.nextShotFrame = 6
            elseif _ARG_0_.shootMaxFrame < 4 then
              if _ARG_0_.ModeType == _UPVALUE0_ then
                _ARG_0_:CreateBulletEx(_ARG_0_.myHandle, "b10he00", "B011_SPA_03_0", "B011_HIT_04_0", "B011_SPA_01_0", 5, 0)
              else
                _ARG_0_:CreateBulletEx(_ARG_0_.myHandle, "b10he00", "B011_SPA_02_0", "B011_HIT_03_0", "B011_SPA_00_0", 4, 0)
              end
              _ARG_0_.nextShotFrame = 6
            else
              if _ARG_0_.ModeType == _UPVALUE0_ then
                _ARG_0_:CreateBulletEx(_ARG_0_.myHandle, "b10he00", "B011_SPA_03_0", "B011_HIT_04_0", "B011_SPA_01_0", 5, 0)
              else
                _ARG_0_:CreateBulletEx(_ARG_0_.myHandle, "b10he00", "B011_SPA_02_0", "B011_HIT_03_0", "B011_SPA_00_0", 4, 0)
              end
              _ARG_0_.nextShotFrame = 2
            end
          elseif _ARG_0_.shootMaxFrame < 2 then
            if _ARG_0_.ModeType == _UPVALUE0_ then
              _ARG_0_:CreateBulletEx(_ARG_0_.myHandle, "b10he00", "B011_SPA_03_0", "B011_HIT_04_0", "B011_SPA_01_0", 5, 0)
            else
              _ARG_0_:CreateBulletEx(_ARG_0_.myHandle, "b10he00", "B011_SPA_02_0", "B011_HIT_03_0", "B011_SPA_00_0", 4, 0)
            end
            _ARG_0_.nextShotFrame = 6
          elseif _ARG_0_.shootMaxFrame < 4 then
            if _ARG_0_.ModeType == _UPVALUE0_ then
              _ARG_0_:CreateBulletEx(_ARG_0_.myHandle, "b10he00", "B011_SPA_03_0", "B011_HIT_04_0", "B011_SPA_01_0", 5, 0)
            else
              _ARG_0_:CreateBulletEx(_ARG_0_.myHandle, "b10he00", "B011_SPA_02_0", "B011_HIT_03_0", "B011_SPA_00_0", 4, 0)
            end
            _ARG_0_.nextShotFrame = 6
          else
            _ARG_0_.nextShotFrame = 10
            if _ARG_0_.ModeType == _UPVALUE0_ then
              _ARG_0_:CreateBulletEx(_ARG_0_.myHandle, "b10he00", "B011_SPA_03_0", "B011_HIT_04_0", "B011_SPA_01_0", 5, 1)
            else
              _ARG_0_:CreateBulletEx(_ARG_0_.myHandle, "b10he00", "B011_SPA_02_0", "B011_HIT_03_0", "B011_SPA_00_0", 4, 1)
            end
          end
          _ARG_0_.step = _ARG_0_.step + 1
        end
      end
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        if _ARG_0_:CheckPlayerEnshrining() == 0 then
          _ARG_0_:GotoState("Idling")
          _ARG_0_.AttackDelay = Script.Random() * _UPVALUE1_
        else
          _ARG_0_:GotoState("IceSpeirMaxMode")
        end
      end
    end
  },
  Watching = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Move")
      end
    end
  },
  Damage = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.SavingsDamage = 0
      _ARG_0_.step = 0
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_.step = 1
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        end
      elseif _ARG_0_.step == 1 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Standby = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
    end,
    OnEndState = function(_ARG_0_)
      Entity.EnableLockon(_ARG_0_.myHandle, 1)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
      if Enemy.IsAllEnemyWaiting() == false then
        _ARG_0_:GotoState("Idling")
        Entity.EnableLockon(_ARG_0_.myHandle, 1)
      end
    end
  },
  StandbyArena = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
      Entity.SetAlpha(_ARG_0_.myHandle, 0)
      if Mission.IsFlagFinalRound() == 1 then
        _ARG_0_.step = 0
      else
        SetupAppearBegin2(_ARG_0_.myHandle, -1, _UPVALUE0_, 1)
        _ARG_0_.step = 1
      end
    end,
    OnEndState = function(_ARG_0_)
      Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
      SetupAppearEnd(_ARG_0_.myHandle)
      Entity.SetAlpha(_ARG_0_.myHandle, 1)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
      if _ARG_0_.step == 0 then
        if Exusia.IsExistenceSchedule() then
          SetupAppearBegin2(_ARG_0_.myHandle, -1, _UPVALUE0_, 1)
          _ARG_0_.step = 1
        end
      elseif Enemy.IsAllEnemyWaiting() == false then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Dead = {
    OnBeginState = function(_ARG_0_)
      print("Dead\n")
      Entity.EnableLockon(_ARG_0_.myHandle, 0)
      Entity.EnableShooton(_ARG_0_.myHandle, 0)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 2)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
    end
  },
  Deadarena = {
    OnBeginState = function(_ARG_0_)
      print("Deadarena\n")
      Entity.EnableLockon(_ARG_0_.myHandle, 0)
      Entity.EnableShooton(_ARG_0_.myHandle, 0)
      Entity.EnableUserTarget(_ARG_0_.myHandle, 0)
      Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
      Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 120)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsModelFade(_ARG_0_.myHandle) == false then
        Enemy.Dead(_ARG_0_.myHandle)
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
}
function ROUND_PI(_ARG_0_)
  if _ARG_0_ < -PI then
    return _ARG_0_ + PI * 2
  elseif _ARG_0_ > PI then
    return _ARG_0_ - PI * 2
  else
    return _ARG_0_
  end
end
function b10he00.CheckPlayerEnshrining(_ARG_0_)
  Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.targetHandle)
  if _ARG_0_.WorkVec:gety() > 0.8 or Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _UPVALUE0_ then
    if _ARG_0_.WorkVec:gety() > 3 then
      return 1
    end
    if Entity.IsGround(_ARG_0_.targetHandle) then
      return 1
    end
  end
  return 0
end
function b10he00.WhichRightandLeft(_ARG_0_)
  Entity.GetWorldPos(_ARG_0_.WorkVec1, _ARG_0_.targetHandle)
  Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.myHandle)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.WorkVec1, _ARG_0_.WorkVec)
  FVECTOR3.normalize(_ARG_0_.workVec)
  if ROUND_PI((Math.Atan2(_ARG_0_.workVec:getx(), _ARG_0_.workVec:getz()) - _ARG_0_.rot:gety()) * -1) < 0 then
    return 1
  else
    return 0
  end
end
function b10he00.CheckHP(_ARG_0_)
  if Enemy.GetHp(_ARG_0_.myHandle) < Enemy.GetHpMax(_ARG_0_.myHandle) * _UPVALUE0_ then
    return 1
  end
  return 0
end
function b10he00.FootDisp(_ARG_0_)
  if Entity.GetMotionIndex(_ARG_0_.myHandle, _UPVALUE0_) == Entity.GetCurrentMotion(_ARG_0_.myHandle) then
    if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 23 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) < 42 then
      _ARG_0_.footDispFlagR = 0
      _ARG_0_.footDispFlagL = 1
    elseif Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 54 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) < 68 then
      _ARG_0_.footDispFlagR = 1
      _ARG_0_.footDispFlagL = 0
    else
      _ARG_0_.footDispFlagR = 1
      _ARG_0_.footDispFlagL = 1
    end
  elseif Entity.GetMotionIndex(_ARG_0_.myHandle, _UPVALUE1_) == Entity.GetCurrentMotion(_ARG_0_.myHandle) then
    if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 22 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) < 42 then
      _ARG_0_.footDispFlagR = 1
      _ARG_0_.footDispFlagL = 0
    elseif Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 54 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) < 68 then
      _ARG_0_.footDispFlagR = 0
      _ARG_0_.footDispFlagL = 1
    else
      _ARG_0_.footDispFlagR = 1
      _ARG_0_.footDispFlagL = 1
    end
  else
    _ARG_0_.footDispFlagR = 1
    _ARG_0_.footDispFlagL = 1
  end
end
function b10he00.changeLockon(_ARG_0_)
  _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_FAR)
  if Player.GetHandleForNet() == NULL_HANDLE then
    return
  end
  Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.myHandle, _UPVALUE0_)
  Entity.GetWorldPos(_ARG_0_.WorkVec1, _ARG_0_.myHandle, _UPVALUE1_)
  if Entity.CalcDistanceSq(_ARG_0_.myHandle, (Player.GetHandleForNet())) < 144 then
    if Entity.CalcDistanceSq(Player.GetHandleForNet(), _ARG_0_.WorkVec) < Entity.CalcDistanceSq(Player.GetHandleForNet(), _ARG_0_.WorkVec1) then
      Entity.SetLockOnBoneNum(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.GetWorldPos(_ARG_0_.lockonPos, _ARG_0_.myHandle, _UPVALUE0_)
    else
      Entity.SetLockOnBoneNum(_ARG_0_.myHandle, _UPVALUE1_)
      Entity.GetWorldPos(_ARG_0_.lockonPos, _ARG_0_.myHandle, _UPVALUE1_)
    end
  else
    _ARG_0_.lockonPos:set(0, 5.7, 0)
    Entity.GetWorldPos2(_ARG_0_.lockonPos, _ARG_0_.myHandle, _ARG_0_.lockonPos)
    Entity.SetLockOnBoneNum(_ARG_0_.myHandle, _UPVALUE2_)
  end
end
function b10he00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.targetHandle = NULL_HANDLE
  _ARG_0_.SubDelay = 0
  _ARG_0_.AttackFlag = 1
  _ARG_0_.AttackDelay = 0
  _ARG_0_.ModeType = 0
  _ARG_0_.SavingsDamage = 0
  _ARG_0_.waveFlag = 0
  _ARG_0_.nextShotFrame = 0
  _ARG_0_.shootMaxFrame = 0
  _ARG_0_.footDispFlagR = 0
  _ARG_0_.footDispFlagL = 1
  _ARG_0_.footFlag = 0
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkTime = 0
  _ARG_0_.WorkVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
  _ARG_0_.ShootPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.ShootPosSub = FVECTOR3.new(0, 0, 0)
  _ARG_0_.lockonPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
  if _UPVALUE0_ == false then
    _UPVALUE1_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "Action1Dis")
    _UPVALUE1_ = _UPVALUE1_ * _UPVALUE1_
    _UPVALUE2_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "Action2Dis")
    _UPVALUE2_ = _UPVALUE2_ * _UPVALUE2_
    _UPVALUE3_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "IdlingT") * 60
    _UPVALUE4_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "ImpactF")
    _UPVALUE5_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "FaintF")
    _UPVALUE6_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "Action1R") * 0.01
    _UPVALUE7_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "Action1AR") * 0.01
    _UPVALUE8_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "ChaHpRate") * 0.01
    print("B10HE_CHANGEHPRATE = " .. _UPVALUE8_ .. "\n")
    _UPVALUE0_ = true
  end
  Entity.SetMovementCollRadius(_ARG_0_.myHandle, 1.7)
  Entity.SetLowerHalf(_ARG_0_.myHandle, 2)
  Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
  Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
  Entity.EnableLockon(_ARG_0_.myHandle, 0)
  Entity.EnableGravity(_ARG_0_.myHandle, 1)
  Enemy.IsAllEnemyWaiting()
  Entity.SetDropShadowDistance(_ARG_0_.myHandle, 80)
  Entity.SetLockOnBoneNum(_ARG_0_.myHandle, _UPVALUE9_)
  Entity.SetUserGroundColor(_ARG_0_.myHandle, 0)
  Player.SetBossCamera("b10he")
  Entity.EnableCameraBodyColl(_ARG_0_.myHandle, 1)
  if Enemy.IsAllEnemyWaiting() == true then
    if Entity.GetName(_ARG_0_.myHandle) == "b90vs00" then
      _ARG_0_:GotoStateSub("StandbyArena")
    else
      _ARG_0_:GotoState("Standby")
    end
  else
    _ARG_0_:GotoState("Appear")
    Entity.EnableLockon(_ARG_0_.myHandle, 1)
  end
end
function b10he00.GetCameraTargetPos(_ARG_0_)
  return _ARG_0_.lockonPos
end
function b10he00.OnDamage(_ARG_0_, _ARG_1_)
  _ARG_0_.AttackFlag = 1
  _ARG_0_.SubDelay = _ARG_0_.SubDelay + 3
  if _ARG_0_:CheckHP() == 1 then
    _ARG_0_.ModeType = _UPVALUE0_
  end
  _ARG_0_.SavingsDamage = _ARG_0_.SavingsDamage + Entity.GetDamagePoint(_ARG_0_.myHandle)
  if _ARG_0_.SavingsDamage < _UPVALUE1_ then
    return 1
  end
  _ARG_0_:GotoState("Damage")
  return 1
end
function b10he00.OnReturnDamage(_ARG_0_)
  _ARG_0_:GotoState("Idling")
end
function b10he00.OnHitAttack(_ARG_0_)
end
function b10he00.OnDead(_ARG_0_)
  Entity.EnableLockon(_ARG_0_.myHandle, 0)
  if Entity.GetName(_ARG_0_.myHandle) == "b90vs00" then
    if Mission.IsFlagFinalRound() == 1 then
      SetupBossDead(_ARG_0_.myHandle)
    else
      SetupBossDead(_ARG_0_.myHandle)
      _ARG_0_:GotoStateSub("Deadarena")
    end
  else
    _ARG_0_:GotoState("Dead")
  end
  return 1
end
function b10he00.Debug(_ARG_0_)
  if Script.IsDebugCheckAttack() then
    for _FORV_5_, _FORV_6_ in pairs(_UPVALUE0_) do
      if _FORV_6_ == _ARG_0_:GetState() then
        return
      end
    end
    if _UPVALUE0_[Script.GetDebugAttackNumber() + 1] ~= nil then
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_FAR)
      _ARG_0_:GotoState(_UPVALUE0_[Script.GetDebugAttackNumber() + 1])
    end
  end
end
function b10he00.CreateShockwave(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_1_, _ARG_2_)
  Entity.GetRot(_ARG_0_.rot, _ARG_1_)
  SetBulletAttackParam(Bullet.CreateBullet("b10he00b", _ARG_0_.WorkVec, _ARG_0_.rot, _ARG_1_), _ARG_0_.myHandle, _ARG_3_)
  Bullet.SetAttacker(Bullet.CreateBullet("b10he00b", _ARG_0_.WorkVec, _ARG_0_.rot, _ARG_1_), _ARG_1_)
  if _ARG_4_ == 0 then
    Bullet.SetHitAttackEffectName(Bullet.CreateBullet("b10he00b", _ARG_0_.WorkVec, _ARG_0_.rot, _ARG_1_), "b10he00", "B011_HIT_01_0")
    Bullet.SetAddCollRadius(Bullet.CreateBullet("b10he00b", _ARG_0_.WorkVec, _ARG_0_.rot, _ARG_1_), 0.15)
  else
    Bullet.SetHitAttackEffectName(Bullet.CreateBullet("b10he00b", _ARG_0_.WorkVec, _ARG_0_.rot, _ARG_1_), "b10he00", "B011_HIT_02_0")
    Bullet.SetAddCollRadius(Bullet.CreateBullet("b10he00b", _ARG_0_.WorkVec, _ARG_0_.rot, _ARG_1_), 0.15)
  end
  EntityManager:GetEntity((Bullet.CreateBullet("b10he00b", _ARG_0_.WorkVec, _ARG_0_.rot, _ARG_1_))).step = _ARG_4_
end
function b10he00.CreateBullet(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_, _ARG_6_, _ARG_7_)
  if _ARG_7_ == 0 then
    _ARG_0_.WorkVec:set(0, -0.7, 0)
    Entity.GetWorldPos2(_ARG_0_.WorkVec, _ARG_1_, _ARG_0_.WorkVec, _UPVALUE0_)
    Entity.GetWorldPos(_ARG_0_.ShootPos, _ARG_1_, _UPVALUE0_)
    FVECTOR3.Sub(_ARG_0_.ShootPosSub, _ARG_0_.WorkVec, _ARG_0_.ShootPos)
    FVECTOR3.normalize(_ARG_0_.ShootPosSub)
    _ARG_0_.WorkVec:set(-0.5, -0.7, 0)
    Entity.GetWorldPos2(_ARG_0_.ShootPos, _ARG_1_, _ARG_0_.WorkVec, _UPVALUE0_)
  end
  Entity.GetRot(_ARG_0_.rot, _ARG_1_)
  _ARG_0_.rot:sety((Math.Atan2(_ARG_0_.ShootPosSub:getx(), _ARG_0_.ShootPosSub:getz())))
  Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.targetHandle, 2)
  Entity.GetRot(_ARG_0_.rot, _ARG_1_)
  FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.WorkVec, _ARG_0_.ShootPos)
  FVECTOR3.normalize(_ARG_0_.workVec)
  _ARG_0_.rot:setx(-Math.Atan2(_ARG_0_.workVec:gety(), Math.Sqrt(_ARG_0_.workVec:getz() * _ARG_0_.workVec:getz() + _ARG_0_.workVec:getx() * _ARG_0_.workVec:getx())))
  _ARG_0_.rot:sety((Math.Atan2(_ARG_0_.workVec:getx(), _ARG_0_.workVec:getz())))
  _ARG_0_.rot:sety(_ARG_0_.rot:gety() + DegToRad(Script.Random() * 4 - 2))
  _ARG_0_.rot:setx(_ARG_0_.rot:getx() + DegToRad(Script.Random() * 4 - 2))
  Bullet.CreateEffectBullet(Bullet.CreateBullet("b10he00s", _ARG_0_.ShootPos, _ARG_0_.rot), _ARG_2_, _ARG_3_)
  if Enemy.IsConfuse(_ARG_0_.myHandle) then
    Bullet.SetCollision(Bullet.CreateBullet("b10he00s", _ARG_0_.ShootPos, _ARG_0_.rot), COLL_KIND_NO_CHECK, COLL_SHAPE_SPHERE, 0.5, 0, _ARG_1_)
  else
    Bullet.SetCollision(Bullet.CreateBullet("b10he00s", _ARG_0_.ShootPos, _ARG_0_.rot), COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, 0.5, 0, _ARG_1_)
  end
  SetBulletAttackParam(Bullet.CreateBullet("b10he00s", _ARG_0_.ShootPos, _ARG_0_.rot), _ARG_0_.myHandle, _ARG_6_)
  Bullet.SetHitAttackEffectName(Bullet.CreateBullet("b10he00s", _ARG_0_.ShootPos, _ARG_0_.rot), _ARG_2_, _ARG_4_)
  Bullet.SetHitBgEffectName(Bullet.CreateBullet("b10he00s", _ARG_0_.ShootPos, _ARG_0_.rot), _ARG_2_, _ARG_4_)
  Entity.CalcVelocity(Bullet.CreateBullet("b10he00s", _ARG_0_.ShootPos, _ARG_0_.rot), 0.15)
  Bullet.SetMaxMoveDist(Bullet.CreateBullet("b10he00s", _ARG_0_.ShootPos, _ARG_0_.rot), 100)
  Bullet.EnableReflect(Bullet.CreateBullet("b10he00s", _ARG_0_.ShootPos, _ARG_0_.rot), Enemy.GetAttackReflect(_ARG_0_.myHandle, 0))
  Entity.SetEffect(_ARG_1_, _ARG_2_, _ARG_5_, _ARG_0_.ShootPos, _ARG_0_.rot)
  EntityManager:GetEntity((Bullet.CreateBullet("b10he00s", _ARG_0_.ShootPos, _ARG_0_.rot))).masterHandle = _ARG_1_
  EntityManager:GetEntity((Bullet.CreateBullet("b10he00s", _ARG_0_.ShootPos, _ARG_0_.rot))).targetHandle = _ARG_0_.targetHandle
end
function b10he00.CreateBulletEx(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_, _ARG_6_, _ARG_7_)
  if _ARG_7_ == 0 then
    _ARG_0_.WorkVec:set(0, -0.7, 0)
    Entity.GetWorldPos2(_ARG_0_.WorkVec, _ARG_1_, _ARG_0_.WorkVec, _UPVALUE0_)
    Entity.GetWorldPos(_ARG_0_.ShootPos, _ARG_1_, _UPVALUE0_)
    FVECTOR3.Sub(_ARG_0_.ShootPosSub, _ARG_0_.WorkVec, _ARG_0_.ShootPos)
    FVECTOR3.normalize(_ARG_0_.ShootPosSub)
    _ARG_0_.WorkVec:set(-0.5, -0.7, 0)
    Entity.GetWorldPos2(_ARG_0_.ShootPos, _ARG_1_, _ARG_0_.WorkVec, _UPVALUE0_)
  end
  Entity.GetRot(_ARG_0_.rot, _ARG_1_)
  _ARG_0_.rot:sety((Math.Atan2(_ARG_0_.ShootPosSub:getx(), _ARG_0_.ShootPosSub:getz())))
  Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.targetHandle, 2)
  Entity.GetRot(_ARG_0_.rot, _ARG_1_)
  FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.WorkVec, _ARG_0_.ShootPos)
  FVECTOR3.normalize(_ARG_0_.workVec)
  _ARG_0_.rot:setx(-Math.Atan2(_ARG_0_.workVec:gety(), Math.Sqrt(_ARG_0_.workVec:getz() * _ARG_0_.workVec:getz() + _ARG_0_.workVec:getx() * _ARG_0_.workVec:getx())))
  _ARG_0_.rot:sety((Math.Atan2(_ARG_0_.workVec:getx(), _ARG_0_.workVec:getz())))
  _ARG_0_.rot:sety(_ARG_0_.rot:gety() + DegToRad(Script.Random() * 4 - 2))
  _ARG_0_.rot:setx(_ARG_0_.rot:getx() + DegToRad(Script.Random() * 4 - 2))
  Bullet.CreateEffectBullet(Bullet.CreateBullet("b10he00sEx", _ARG_0_.ShootPos, _ARG_0_.rot), _ARG_2_, _ARG_3_)
  if Enemy.IsConfuse(_ARG_0_.myHandle) then
    Bullet.SetCollision(Bullet.CreateBullet("b10he00sEx", _ARG_0_.ShootPos, _ARG_0_.rot), COLL_KIND_NO_CHECK, COLL_SHAPE_SPHERE, 0.5, 0, _ARG_1_)
  else
    Bullet.SetCollision(Bullet.CreateBullet("b10he00sEx", _ARG_0_.ShootPos, _ARG_0_.rot), COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, 0.5, 0, _ARG_1_)
  end
  SetBulletAttackParam(Bullet.CreateBullet("b10he00sEx", _ARG_0_.ShootPos, _ARG_0_.rot), _ARG_0_.myHandle, _ARG_6_)
  Bullet.SetHitAttackEffectName(Bullet.CreateBullet("b10he00sEx", _ARG_0_.ShootPos, _ARG_0_.rot), _ARG_2_, _ARG_4_)
  Bullet.SetHitBgEffectName(Bullet.CreateBullet("b10he00sEx", _ARG_0_.ShootPos, _ARG_0_.rot), _ARG_2_, _ARG_4_)
  Entity.CalcVelocity(Bullet.CreateBullet("b10he00sEx", _ARG_0_.ShootPos, _ARG_0_.rot), 0.02)
  Bullet.SetMaxMoveDist(Bullet.CreateBullet("b10he00sEx", _ARG_0_.ShootPos, _ARG_0_.rot), 100)
  Bullet.EnableReflect(Bullet.CreateBullet("b10he00sEx", _ARG_0_.ShootPos, _ARG_0_.rot), Enemy.GetAttackReflect(_ARG_0_.myHandle, 0))
  Entity.SetEffect(_ARG_1_, _ARG_2_, _ARG_5_, _ARG_0_.ShootPos, _ARG_0_.rot)
  EntityManager:GetEntity((Bullet.CreateBullet("b10he00sEx", _ARG_0_.ShootPos, _ARG_0_.rot))).masterHandle = _ARG_1_
  EntityManager:GetEntity((Bullet.CreateBullet("b10he00sEx", _ARG_0_.ShootPos, _ARG_0_.rot))).targetHandle = _ARG_0_.targetHandle
  EntityManager:GetEntity((Bullet.CreateBullet("b10he00sEx", _ARG_0_.ShootPos, _ARG_0_.rot))).homing = 0.9 + Script.Random() * 5
  EntityManager:GetEntity((Bullet.CreateBullet("b10he00sEx", _ARG_0_.ShootPos, _ARG_0_.rot))).speed = 0.3 + _ARG_7_ * 0.01
end
function b10he00.CreateBreath(_ARG_0_, _ARG_1_)
  _ARG_0_.WorkVec:set(0, -0.7, 0)
  Entity.GetWorldPos2(_ARG_0_.WorkVec, _ARG_1_, _ARG_0_.WorkVec, _UPVALUE0_)
  Entity.GetWorldPos(_ARG_0_.WorkVec1, _ARG_1_, _UPVALUE0_)
  Entity.GetRot(_ARG_0_.rot, _ARG_1_)
  FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.WorkVec, _ARG_0_.WorkVec1)
  FVECTOR3.normalize(_ARG_0_.workVec)
  _ARG_0_.rot:setx(-Math.Atan2(_ARG_0_.workVec:gety(), Math.Sqrt(_ARG_0_.workVec:getz() * _ARG_0_.workVec:getz() + _ARG_0_.workVec:getx() * _ARG_0_.workVec:getx())))
  _ARG_0_.rot:sety((Math.Atan2(_ARG_0_.workVec:getx(), _ARG_0_.workVec:getz())))
  _ARG_0_.WorkVec:set(0.3, -0.7, 0)
  Entity.GetWorldPos2(_ARG_0_.WorkVec, _ARG_1_, _ARG_0_.WorkVec, _UPVALUE0_)
  if Enemy.IsConfuse(_ARG_0_.myHandle) then
    Bullet.SetCollision(Bullet.CreateBullet("", _ARG_0_.WorkVec, _ARG_0_.rot, _ARG_1_), COLL_KIND_NO_CHECK, COLL_SHAPE_SPHERE, 2.5, 0, _ARG_1_)
  else
    Bullet.SetCollision(Bullet.CreateBullet("", _ARG_0_.WorkVec, _ARG_0_.rot, _ARG_1_), COLL_KIND_NO_CHECK, COLL_SHAPE_SPHERE, 2.5, 0, _ARG_1_)
  end
  SetBulletAttackParam(Bullet.CreateBullet("", _ARG_0_.WorkVec, _ARG_0_.rot, _ARG_1_), _ARG_0_.myHandle, 1)
  Bullet.SetHitAttackEffectName(Bullet.CreateBullet("", _ARG_0_.WorkVec, _ARG_0_.rot, _ARG_1_), "b10he00", "B011_HIT_00_0")
  Entity.CalcVelocity(Bullet.CreateBullet("", _ARG_0_.WorkVec, _ARG_0_.rot, _ARG_1_), 0.2)
  Bullet.SetMaxMoveDist(Bullet.CreateBullet("", _ARG_0_.WorkVec, _ARG_0_.rot, _ARG_1_), 25)
  Entity.EnableAttackBgHit(Bullet.CreateBullet("", _ARG_0_.WorkVec, _ARG_0_.rot, _ARG_1_), 0)
  Entity.EnableBgColl(Bullet.CreateBullet("", _ARG_0_.WorkVec, _ARG_0_.rot, _ARG_1_), 0)
end
function b10he00.OnUpdate(_ARG_0_)
  _ARG_0_:Update()
  _ARG_0_:Debug()
  _ARG_0_:FootDisp()
  _ARG_0_:changeLockon()
end
EntityFactory:Add("b10he00", function(_ARG_0_)
  return (b10he00:new())
end)
EntityFactory:Add("b90vs00", function(_ARG_0_)
  return (b10he00:new())
end)
b10he00b = {}
b10he00b_mt = {__index = b10he00b}
function b10he00b.new(_ARG_0_)
  return setmetatable({}, b10he00b_mt)
end
function b10he00b.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.masterHandle = NULL_HANDLE
  _ARG_0_.step = 0
  Bullet.EnableNoCheckHitBg(_ARG_1_, 0)
  Bullet.SetCollision(_ARG_1_, COLL_KIND_ENEMY, COLL_SHAPE_CYLINDER, 1, 1)
  _ARG_0_.Time = 0
end
function b10he00b.OnReflect(_ARG_0_)
end
function b10he00b.OnUpdate(_ARG_0_)
  _ARG_0_.Time = _ARG_0_.Time + 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_0_.step == 0 then
    if _ARG_0_.Time >= 20 then
      Bullet.SetAddCollRadius(_ARG_0_.myHandle, 0)
      _ARG_0_.step = _ARG_0_.step + 1
    end
  elseif _ARG_0_.step == 1 and _ARG_0_.Time >= 45 then
    Bullet.EnableAttackCollision(_ARG_0_.myHandle, 0)
    _ARG_0_.step = _ARG_0_.step + 1
    if Entity.IsTimeOver(_ARG_0_.myHandle) then
      Bullet.DeleteBullet(_ARG_0_.myHandle)
    end
  end
end
EntityFactory:Add("b10he00b", function(_ARG_0_)
  return (b10he00b:new())
end)
b10he00s = {}
b10he00s_mt = {__index = b10he00s}
function b10he00s.new(_ARG_0_)
  return setmetatable({}, b10he00s_mt)
end
function b10he00s.OnReflect(_ARG_0_)
  _ARG_0_.step = 2
  Entity.SetTimer(_ARG_0_.myHandle, 1980)
end
function b10he00s.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.masterHandle = NULL_HANDLE
  _ARG_0_.step = 0
  _ARG_0_.homing = 1
  _ARG_0_.targetHandle = NULL_HANDLE
  _ARG_0_.WorkTime = 40
  Entity.SetTimer(_ARG_0_.myHandle, 5)
  _ARG_0_.WorkVec = FVECTOR3.new(0, 0, 0)
end
function b10he00s.OnUpdate(_ARG_0_)
  _ARG_0_.WorkTime = _ARG_0_.WorkTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_0_.step == 0 then
    if Entity.IsTimeOver(_ARG_0_.myHandle) then
      _ARG_0_.step = 1
    end
  elseif _ARG_0_.step == 1 then
    Entity.CalcVelocity(_ARG_0_.myHandle, 0.2)
    Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.targetHandle, 5)
    Entity.TurnTargetDegree(_ARG_0_.myHandle, _ARG_0_.WorkVec, 3)
    if _ARG_0_.WorkTime < 0 then
      _ARG_0_.step = 2
      Entity.SetTimer(_ARG_0_.myHandle, 1980)
    end
  elseif _ARG_0_.step == 2 and Entity.IsTimeOver(_ARG_0_.myHandle) then
    Bullet.DeleteBullet(_ARG_0_.myHandle)
  end
end
EntityFactory:Add("b10he00s", function(_ARG_0_)
  return (b10he00s:new())
end)
b10he00sEx = {}
b10he00sEx_mt = {__index = b10he00sEx}
function b10he00sEx.new(_ARG_0_)
  return setmetatable({}, b10he00sEx_mt)
end
function b10he00sEx.OnReflect(_ARG_0_)
  print("OnReflect()\n")
  _ARG_0_.step = 3
  Entity.SetTimer(_ARG_0_.myHandle, 1980)
end
function b10he00sEx.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.masterHandle = NULL_HANDLE
  _ARG_0_.step = 0
  _ARG_0_.speed = 0
  _ARG_0_.homing = 1
  _ARG_0_.targetHandle = NULL_HANDLE
  _ARG_0_.WorkTime = 10
  Entity.SetTimer(_ARG_0_.myHandle, 10)
  _ARG_0_.WorkVec = FVECTOR3.new(0, 0, 0)
end
function b10he00sEx.OnUpdate(_ARG_0_)
  _ARG_0_.WorkTime = _ARG_0_.WorkTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_0_.step == 0 then
    if Entity.IsTimeOver(_ARG_0_.myHandle) then
      _ARG_0_.step = 1
    end
  elseif _ARG_0_.step == 1 then
    Entity.CalcVelocity(_ARG_0_.myHandle, _ARG_0_.speed)
    Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.targetHandle, 5)
    Entity.TurnTargetDegree(_ARG_0_.myHandle, _ARG_0_.WorkVec, 7)
    if _ARG_0_.WorkTime < 0 then
      _ARG_0_.step = 2
      Entity.SetTimer(_ARG_0_.myHandle, 1980)
    end
  elseif _ARG_0_.step == 2 then
    if Entity.IsTimeOver(_ARG_0_.myHandle) then
      Bullet.DeleteBullet(_ARG_0_.myHandle)
    end
  elseif _ARG_0_.step == 3 then
    _ARG_0_.step = 4
    Entity.GetRot(_ARG_0_.WorkVec, _ARG_0_.myHandle)
    _ARG_0_.WorkVec:sety(_ARG_0_.WorkVec:gety() + DegToRad(Script.Random() * 60 - 30))
    _ARG_0_.WorkVec:setx(_ARG_0_.WorkVec:getx() + DegToRad(Script.Random() * 60 - 30))
    Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.WorkVec)
    Entity.CalcVelocity(_ARG_0_.myHandle, _ARG_0_.speed)
  elseif _ARG_0_.step == 4 then
    Entity.CalcVelocity(_ARG_0_.myHandle, _ARG_0_.speed)
    if Entity.IsTimeOver(_ARG_0_.myHandle) then
      Bullet.DeleteBullet(_ARG_0_.myHandle)
    end
  end
end
EntityFactory:Add("b10he00sEx", function(_ARG_0_)
  return (b10he00sEx:new())
end)
