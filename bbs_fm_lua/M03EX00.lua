m03ex00 = {}
m03ex00_base_mt = {__index = __StateMachine}
setmetatable(m03ex00, m03ex00_base_mt)
m03ex00_mt = {__index = m03ex00}
function m03ex00.new(_ARG_0_)
  return setmetatable(__StateMachine:new(), m03ex00_mt)
end
m03ex00.states = {
  Appear = {
    OnBeginState = function(_ARG_0_)
      SetupAppearBegin(_ARG_0_.myHandle, 1, _UPVALUE0_, 0)
      _ARG_0_.NowMotionID = _UPVALUE0_
    end,
    OnEndState = function(_ARG_0_)
      SetupAppearEnd(_ARG_0_.myHandle)
      _ARG_0_.step = 99
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Idling = {
    OnBeginState = function(_ARG_0_)
      Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.NowMotionID = _UPVALUE0_
      if _ARG_0_.step == 99 then
        Entity.SetAnimNowFrame(_ARG_0_.myHandle, Script.Random() * Entity.GetMotionTotalFrame(_ARG_0_.myHandle))
      end
      Entity.SetTimer(_ARG_0_.myHandle, Entity.GetMotionTotalFrame(_ARG_0_.myHandle) + Script.Random() * Entity.GetMotionTotalFrame(_ARG_0_.myHandle))
      _ARG_0_.step = 0
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      _ARG_0_.Wait = Entity.GetMotionTotalFrame(_ARG_0_.myHandle) / 3
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.Wait = _ARG_0_.Wait - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      if _ARG_0_.Wait < 0 then
        if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) == true then
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE0_ then
            if Script.Random() < _UPVALUE1_ then
              _ARG_0_:GotoState("Attack1")
            else
              _ARG_0_:GotoState("Attack2")
            end
            return
          elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE2_ then
            _ARG_0_:GotoState("Attack2")
            return
          end
        else
          _ARG_0_:GotoState("Wander")
          return
        end
      end
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE0_ then
          if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) == true then
            if Script.Random() < _UPVALUE1_ then
              _ARG_0_:GotoState("Attack1")
            else
              _ARG_0_:GotoState("Attack2")
            end
            return
          else
            _ARG_0_:GotoState("Rotation")
          end
        elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE2_ then
          if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) == true then
            _ARG_0_:GotoState("Attack2")
            return
          else
            _ARG_0_:GotoState("Rotation")
          end
        elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _UPVALUE2_ then
          if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) == true then
            if Script.Random() < _UPVALUE3_ then
              _ARG_0_:GotoState("Assault_Start")
            else
              _ARG_0_:GotoState("Hipattackofrun")
            end
            return
          else
            _ARG_0_:GotoState("Wander")
            return
          end
        end
      end
    end
  },
  Wander = {
    OnBeginState = function(_ARG_0_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_ + Script.Random() * _UPVALUE0_)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.step = _UPVALUE2_
      _ARG_0_.count = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.HasNetGameHandle(_ARG_0_.myHandle) and Enemy.IsNetworkMaster(_ARG_0_.myHandle) == false then
        return
      end
      if _ARG_0_.step == _UPVALUE0_ then
        if Enemy.GetTimeTargetHasBeenVisible(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 2400 then
          Enemy.GetTargetLastRecordedPos(_ARG_0_.targetPos, _ARG_0_.myHandle, _ARG_0_.targetHandle)
        else
          Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.myHandle)
        end
        _ARG_0_.WorkVec:set(0, 0, 0)
        if Entity.IsWall(_ARG_0_.myHandle) then
          Entity.GetWallNormal(_ARG_0_.WorkVec, _ARG_0_.myHandle)
        end
        _ARG_0_.targetPos:setx(_ARG_0_.targetPos:getx() + (5 * Script.Random() * Math.Cos((RoundPI(Script.Random() * 2 * PI))) + _ARG_0_.WorkVec:getx()))
        _ARG_0_.targetPos:setz(_ARG_0_.targetPos:getz() + (5 * Script.Random() * Math.Sin((RoundPI(Script.Random() * 2 * PI))) + _ARG_0_.WorkVec:getz()))
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_ + Script.Random() * _UPVALUE1_)
        _ARG_0_.noWallHitTime = 120
        _ARG_0_.step = _UPVALUE2_
      elseif _ARG_0_.step == _UPVALUE3_ then
      elseif _ARG_0_.step == _UPVALUE2_ then
        if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) == true then
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE4_ then
            if Script.Random() < _UPVALUE5_ then
              _ARG_0_:GotoState("Attack1")
            else
              _ARG_0_:GotoState("Attack2")
            end
            return
          elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _UPVALUE4_ then
            if Script.Random() < _UPVALUE6_ then
              _ARG_0_:GotoState("Assault_Start")
            else
              _ARG_0_:GotoState("Hipattackofrun")
            end
            return
          end
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 3)
        _ARG_0_.MoveFlag = _UPVALUE7_
        if CanDisappear(_ARG_0_.myHandle, _ARG_0_.targetHandle) == true then
          _ARG_0_:GotoState("Disappear")
          return
        end
        _ARG_0_:Move(_UPVALUE8_)
        _ARG_0_.noWallHitTime = _ARG_0_.noWallHitTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if 0 > _ARG_0_.noWallHitTime then
        end
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
        if Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.IsWall(_ARG_0_.myHandle) == true or 1 > Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetPos) then
          _ARG_0_.count = _ARG_0_.count + 1
          if _ARG_0_.count > 4 then
            _ARG_0_.MoveFlag = _UPVALUE9_
            _ARG_0_:GotoState("Idling")
          else
            _ARG_0_.step = _UPVALUE0_
          end
        end
      end
    end
  },
  Rotation = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      _ARG_0_.step = 0
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.step = _ARG_0_.step + 1
        end
        if Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 2.5) == false then
        end
        FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _UPVALUE0_)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
      elseif _ARG_0_.step == 1 then
        if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE1_ then
          if Script.Random() < _UPVALUE2_ then
            _ARG_0_:GotoState("Attack1")
          else
            _ARG_0_:GotoState("Attack2")
          end
        else
          _ARG_0_:GotoState("Attack2")
        end
        return
      end
    end
  },
  Search = {
    OnBeginState = function(_ARG_0_)
      if not _ARG_0_.NowMotionID == _UPVALUE0_ then
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      end
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_.step = 0
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        if _ARG_0_.step == 0 and Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _UPVALUE0_ and Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE1_ then
          if Script.Random() < _UPVALUE2_ then
            _ARG_0_:GotoState("Assault_Start")
          else
            _ARG_0_:GotoState("Hipattackofrun")
          end
          return
        end
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Attack1 = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_.step = 0
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 and Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10) == false then
        _ARG_0_.step = _ARG_0_.step + 1
      end
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Attack2 = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
      Entity.SetTimer(_ARG_0_.myHandle, 60)
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_.step = 0
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 and Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_.step = 1
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      else
      end
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Assault_Start = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Assault")
      end
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 6)
    end
  },
  Assault = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE0_ then
        _ARG_0_:GotoState("Assault_End")
        return
      end
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Assault_End")
        return
      end
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 1)
      FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _UPVALUE1_)
      Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
    end
  },
  Assault_End = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if _UPVALUE0_ < Entity.GetMotionNowFrame(_ARG_0_.myHandle) * Entity.GetFrameRate(_ARG_0_.myHandle) then
        Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
      end
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Stiffening")
        return
      end
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 0)
      FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, 0)
      Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
    end
  },
  Hipattackofrun = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetTimer(_ARG_0_.myHandle, 20)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      _ARG_0_.step = 0
      _ARG_0_.Wait = _UPVALUE1_
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      _ARG_0_.step = 0
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsTimeOver(_ARG_0_.myHandle) and Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE0_ then
        _ARG_0_:GotoState("Hipattack")
      end
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 2.5)
      FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _UPVALUE1_)
      Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
      if 0 > _ARG_0_.Wait then
        _ARG_0_:GotoState("Hipattack")
        return
      end
      _ARG_0_.Wait = _ARG_0_.Wait - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
    end
  },
  Hipattack = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      _ARG_0_.step = 0
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Stiffening")
      end
      FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, 0)
      Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
    end
  },
  Stiffening = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.NowMotionID = _UPVALUE0_
      _ARG_0_.step = 0
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Standby = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Enemy.IsAllEnemyWaiting() == false then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Disappear = {
    OnBeginState = function(_ARG_0_)
      SetupDisappear(_ARG_0_.myHandle, 20)
    end,
    OnEndState = function(_ARG_0_)
      Entity.MoveStartPos(_ARG_0_.myHandle)
      Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsModelFade(_ARG_0_.myHandle) then
        Enemy.Disappear(_ARG_0_.myHandle)
      end
    end
  }
}
function m03ex00.HomingPlayerMove(_ARG_0_, _ARG_1_, _ARG_2_)
  Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, _ARG_2_)
  FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_1_)
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function m03ex00.HomingTargetMove(_ARG_0_, _ARG_1_, _ARG_2_)
  Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.TargetVec, _ARG_2_)
  FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_1_)
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function m03ex00.Move(_ARG_0_, _ARG_1_)
  FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_1_)
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function m03ex00.ArrackisSelect(_ARG_0_)
  if Script.Random() < 0.7 then
    _ARG_0_:GotoState("Attack1")
  else
    _ARG_0_:GotoState("Attack2")
  end
end
function m03ex00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.vec = FVECTOR3.new(1, 1, 1)
  _ARG_0_.workVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.Wait = 0
  _ARG_0_.NowMotionID = 0
  _ARG_0_.targetHandle = NULL_HANDLE
  _ARG_0_.MoveType = 0
  _ARG_0_.StrollCnt = 0
  _ARG_0_.Angle = 0
  _ARG_0_.exec = false
  _ARG_0_.c = 0.15
  _ARG_0_.theta = 0
  _ARG_0_.smallDamageCount = 0
  _ARG_0_.TargetVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
  Entity.EnableGravity(_ARG_0_.myHandle, 1)
  Entity.SetMovementCollRadius(_ARG_0_.myHandle, 1)
  Entity.SetLowerHalf(_ARG_0_.myHandle, 1.5)
  if Enemy.IsAllEnemyWaiting() == true then
    _ARG_0_:GotoState("Standby")
  else
    _ARG_0_:GotoState("Appear")
  end
end
function m03ex00.Debug(_ARG_0_)
  if Script.IsDebugCheckAttack() then
    for _FORV_5_, _FORV_6_ in pairs(_UPVALUE0_) do
      if _FORV_6_ == _ARG_0_:GetState() then
        return
      end
    end
    if Script.GetDebugAttackNumber() == 0 then
      _ARG_0_:GotoState("Attack1")
    elseif Script.GetDebugAttackNumber() == 1 then
      _ARG_0_:GotoState("Attack2")
    elseif Script.GetDebugAttackNumber() == 2 then
      _ARG_0_:GotoState("Assault_Start")
    elseif Script.GetDebugAttackNumber() == 3 then
      _ARG_0_:GotoState("Hipattackofrun")
    end
  end
end
function m03ex00.OnReturnDamage(_ARG_0_)
  _ARG_0_:GotoState("Idling")
  Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
end
function m03ex00.OnDead(_ARG_0_)
  if Enemy.GetHp(_ARG_0_.myHandle) <= 0 then
    Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
  end
end
function m03ex00.OnUpdatePositionAfter(_ARG_0_)
  if _ARG_0_.exec then
    _ARG_0_.theta = RoundPI(_ARG_0_.theta + Entity.GetFrameRate(_ARG_0_.myHandle) * DegToRad(32))
    _ARG_0_.c = _ARG_0_.c - Entity.GetFrameRate(_ARG_0_.myHandle) * 0.0025
    if _ARG_0_.c < 0 then
      _ARG_0_.exec = false
    end
    Entity.GetLocalBoneTrans(_ARG_0_.workVec, _ARG_0_.myHandle, 34)
    _ARG_0_.workVec:set(_ARG_0_.workVec:getx() + Math.Cos(_ARG_0_.theta) * _ARG_0_.c, _ARG_0_.workVec:gety() + Math.Cos(_ARG_0_.theta) * _ARG_0_.c, _ARG_0_.workVec:getz() + Math.Sin(_ARG_0_.theta) * _ARG_0_.c)
    Entity.SetLocalBoneTrans(_ARG_0_.myHandle, _ARG_0_.workVec, 34)
  end
end
function m03ex00.OnNoReaction(_ARG_0_, _ARG_1_)
  if Enemy.IsStop(_ARG_0_.myHandle) then
    return
  end
  _ARG_0_.smallDamageCount = _ARG_0_.smallDamageCount + 1
  if _ARG_0_.smallDamageCount >= _UPVALUE0_ then
    if Script.Random() < 0.3 then
      _ARG_0_:GotoState("Attack2")
    else
      Enemy.SetReaction(_ARG_0_.myHandle, ATK_KIND_DMG_BLOW)
    end
    Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
    _ARG_0_.smallDamageCount = 0
  else
    _ARG_0_.exec = true
    _ARG_0_.c = 0.15
    _ARG_0_.theta = 0
  end
end
function m03ex00.OnUpdate(_ARG_0_)
  _ARG_0_:Update()
  _ARG_0_:Debug()
end
EntityFactory:Add("m03ex00", function(_ARG_0_)
  return (m03ex00:new())
end)
EntityFactory:Add("m30ex00", function(_ARG_0_)
  return (m03ex00:new())
end)
EntityFactory:Add("m03vs00", function(_ARG_0_)
  return (m03ex00:new())
end)
