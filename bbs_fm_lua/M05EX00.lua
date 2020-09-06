m05ex00 = {}
m05ex00_base_mt = {__index = __StateMachine}
setmetatable(m05ex00, m05ex00_base_mt)
m05ex00_mt = {__index = m05ex00}
function m05ex00.new(_ARG_0_)
  return setmetatable(__StateMachine:new(), m05ex00_mt)
end
m05ex00.states = {
  Appear = {
    OnBeginState = function(_ARG_0_)
      SetupAppearBegin(_ARG_0_.myHandle, 1, _UPVALUE0_, 99)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
    end,
    OnEndState = function(_ARG_0_)
      SetupAppearEnd(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Move_Start")
      end
    end
  },
  Feelings = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.CanUserTarget(_ARG_0_.targetHandle) == true then
          if Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10) == false then
            _ARG_0_.step = 1
          end
        else
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Idling = {
    OnBeginState = function(_ARG_0_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.step = 0
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
        return
      end
      if _ARG_0_.step == 0 then
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < ENEMY_COMMON_DISAPPEAR_DIST and Script.Random() < _UPVALUE0_ then
          _ARG_0_:GotoState("Feelings")
          return
        end
        if Entity.CanUserTarget(_ARG_0_.targetHandle) == true then
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE1_ then
            _ARG_0_:GotoState("Turuhashi_Crash")
            return
          elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < ENEMY_COMMON_DISAPPEAR_DIST then
            if Script.Random() < _UPVALUE2_ then
              _ARG_0_:GotoState("DashAttack")
            end
            return
          elseif CanDisappear(_ARG_0_.myHandle, _ARG_0_.targetHandle) == true then
            _ARG_0_:GotoState("Disappear")
            return
          end
        end
        if CanDisappear(_ARG_0_.myHandle, _ARG_0_.targetHandle) == true then
          _ARG_0_:GotoState("Disappear")
          return
        end
      elseif _ARG_0_.step == 1 then
      end
    end
  },
  Move_Start = {
    OnBeginState = function(_ARG_0_)
      Entity.SetTimer(_ARG_0_.myHandle, 0)
      _ARG_0_.step = 0
      _ARG_0_.MoveFlag = 0
      _ARG_0_.Speed = 0
      _ARG_0_.WorkTime = 0
      _ARG_0_.noWallTime = 0
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
          _ARG_0_:GotoState("Move")
        end
        return
      end
    end
  },
  Move = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.step = 1
      if Script.Random() < 0.5 then
        _ARG_0_.MoveMode = 0
      else
        _ARG_0_.MoveMode = 1
      end
      if _ARG_0_.MoveMode == 0 then
        _ARG_0_.step = 0
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
      elseif _ARG_0_.MoveMode == 1 then
        _ARG_0_.step = 1
        if Script.Random() < 0.5 then
          _ARG_0_.MoveFlag = 0
        else
          _ARG_0_.MoveFlag = 1
        end
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_ + Script.Random() * _UPVALUE1_)
        _ARG_0_.WorkTime = _UPVALUE2_
      end
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.HasNetGameHandle(_ARG_0_.myHandle) and Enemy.IsNetworkMaster(_ARG_0_.myHandle) == false then
        return
      end
      if _ARG_0_.step == 0 then
        if Script.Random() < 0.5 then
          _ARG_0_.MoveFlag = 0
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        elseif Script.Random() < 0.5 then
          _ARG_0_.MoveFlag = 1
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
        else
          _ARG_0_.MoveFlag = 2
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
        end
        _ARG_0_.step = 1
        _ARG_0_.WorkTime = _UPVALUE3_ + Script.Random() * _UPVALUE4_
      elseif _ARG_0_.step == 1 then
        if _ARG_0_.MoveMode == 0 then
          if _ARG_0_.MoveFlag == 1 then
            _ARG_0_:Rotation(1)
          elseif _ARG_0_.MoveFlag == 2 then
            _ARG_0_:Rotation(-1)
          end
          if 0 > _ARG_0_.DelayTime then
            if Entity.CanUserTarget(_ARG_0_.targetHandle) == true then
              if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE5_ then
                if Script.Random() < _UPVALUE6_ then
                  _ARG_0_:GotoState("Spiketrun")
                  return
                end
                _ARG_0_.DelayTime = _UPVALUE7_
              end
            else
              if Script.Random() < _UPVALUE6_ then
                _ARG_0_:GotoState("Spiketrun")
                return
              end
              _ARG_0_.DelayTime = _UPVALUE7_ * 1.5
            end
          end
          if 0 > _ARG_0_.noWallTime and Entity.IsWall(_ARG_0_.myHandle) then
            if Script.Random() < 0.5 then
              _ARG_0_.MoveFlag = 1
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
            else
              _ARG_0_.MoveFlag = 2
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
            end
            _ARG_0_.noWallTime = 120
            _ARG_0_.WorkTime = 60
          end
          if 0 > _ARG_0_.WorkTime then
            _ARG_0_.step = 0
          end
          _ARG_0_:Move(_UPVALUE8_, 0.1)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.startpos, 1)
        elseif _ARG_0_.MoveMode == 1 then
          if 0 > _ARG_0_.WorkTime then
            _ARG_0_.MoveFlag = _ARG_0_.MoveFlag + 1
            if _ARG_0_.MoveFlag >= 2 then
              _ARG_0_.MoveFlag = 0
            end
            _ARG_0_.WorkTime = _UPVALUE9_
            if Script.Random() < 0.2 then
              _ARG_0_.MoveMode = 0
            elseif Script.Random() < 0.4 then
              _ARG_0_.MoveMode = 1
            end
          else
          end
          if _ARG_0_.MoveFlag == 0 then
            _ARG_0_:TurnY(DegToRad(_ARG_0_.AngY))
            _ARG_0_.AngY = _ARG_0_.AngY + _UPVALUE10_ * 0.05 * Entity.GetFrameRate(_ARG_0_.myHandle)
            if _ARG_0_.AngY > _UPVALUE10_ then
              _ARG_0_.AngY = _UPVALUE10_
            end
            Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE1_)
          end
          if _ARG_0_.MoveFlag == 1 then
            _ARG_0_:TurnY(DegToRad(_ARG_0_.AngY))
            _ARG_0_.AngY = _ARG_0_.AngY - _UPVALUE10_ * 0.1 * Entity.GetFrameRate(_ARG_0_.myHandle)
            if _ARG_0_.AngY < -_UPVALUE10_ then
              _ARG_0_.AngY = -_UPVALUE10_
            end
            Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE2_)
          end
          _ARG_0_:Move(_UPVALUE8_, 0.1)
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_.step = 2
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE11_)
          Entity.ClearSpeed(_ARG_0_.myHandle)
          return
        end
      elseif _ARG_0_.step == 2 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
        Entity.ClearSpeed(_ARG_0_.myHandle)
        return
      elseif _ARG_0_.step == 3 then
      end
      _ARG_0_.WorkTime = _ARG_0_.WorkTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      _ARG_0_.noWallTime = _ARG_0_.noWallTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
    end
  },
  Spiketrun = {
    OnBeginState = function(_ARG_0_)
      Entity.EnableHeavy(_ARG_0_.myHandle, 1)
      Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
      _ARG_0_.WorkVec1:set(1, 0, 0)
      Math.RotateVectorXYZ(_ARG_0_.WorkVec1, _ARG_0_.rot)
      Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
      Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
      FVECTOR3.Sub(_ARG_0_.WorkVec, _ARG_0_.myPos, _ARG_0_.targetPos)
      _ARG_0_.WorkVec:normalize()
      if 0 > _ARG_0_.WorkVec1:dot(_ARG_0_.WorkVec) then
        _ARG_0_.MoveFlag = 1
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      else
        _ARG_0_.MoveFlag = 2
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
      end
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
    end,
    OnEndState = function(_ARG_0_)
      Entity.EnableLockon(_ARG_0_.myHandle, 1)
      Entity.EnableHeavy(_ARG_0_.myHandle, 0)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.MoveFlag == 1 then
        _ARG_0_:Rotation(0.8)
      elseif _ARG_0_.MoveFlag == 2 then
        _ARG_0_:Rotation(-0.8)
      end
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Move")
        return
      end
      _ARG_0_:Move(_UPVALUE0_, 0.01)
      _ARG_0_:DownSpeed(_UPVALUE0_, 0.005)
    end
  },
  Turuhashi_Crash = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10) == false then
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.step = 2
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        end
      elseif _ARG_0_.step == 2 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Move_Start")
      end
    end
  },
  DashAttack = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      _ARG_0_.step = 0
      _ARG_0_.AttackFlag = 0
      _ARG_0_.Speed = 0
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_.AttackFlag = 0
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5) == false then
          _ARG_0_.step = 1
        end
        return
      elseif _ARG_0_.step == 1 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 40 then
          Entity.SetTimer(_ARG_0_.myHandle, Math.Sqrt((Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle))) / (_UPVALUE0_ * Entity.GetFrameRate(_ARG_0_.myHandle)) + 30)
          _ARG_0_.step = 2
        end
        return
      elseif _ARG_0_.step == 2 then
        if _ARG_0_.AttackFlag == 1 or Entity.IsWall(_ARG_0_.myHandle) then
          _ARG_0_.step = 99
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
          return
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_.step = 99
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
          return
        end
      elseif _ARG_0_.step == 3 then
      elseif _ARG_0_.step == 4 then
      elseif _ARG_0_.step == 99 then
        _ARG_0_:DownSpeed(_UPVALUE0_, 0.1)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.step = 100
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
        end
        return
      elseif _ARG_0_.step == 100 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Move_Start")
        end
        return
      end
      _ARG_0_:Move(_UPVALUE0_, 0.1)
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
      if Enemy.IsAllEnemyWaiting() == false then
        _ARG_0_:GotoState("Idling")
        Entity.EnableLockon(_ARG_0_.myHandle, 1)
      end
    end
  },
  Dead = {
    OnBeginState = function(_ARG_0_)
      Entity.EnableLockon(_ARG_0_.myHandle, 0)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
    end
  },
  Disappear = {
    OnBeginState = function(_ARG_0_)
      SetupDisappear(_ARG_0_.myHandle, 60)
    end,
    OnEndState = function(_ARG_0_)
      Entity.MoveStartPos(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsModelFade(_ARG_0_.myHandle) then
        Enemy.Disappear(_ARG_0_.myHandle)
      end
    end
  }
}
function m05ex00.Move(_ARG_0_, _ARG_1_, _ARG_2_)
  _ARG_0_.Speed = _ARG_0_.Speed + _ARG_1_ * _ARG_2_ * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_1_ < _ARG_0_.Speed then
    _ARG_0_.Speed = _ARG_1_
  end
  FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Speed)
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function m05ex00.DownSpeed(_ARG_0_, _ARG_1_, _ARG_2_)
  _ARG_0_.Speed = _ARG_0_.Speed - _ARG_1_ * _ARG_2_ * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_0_.Speed < 0 then
    _ARG_0_.Speed = 0
  end
  FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Speed)
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function m05ex00.Rotation(_ARG_0_, _ARG_1_)
  if Entity.GetMotionNowFrame(_ARG_0_.myHandle) - Entity.GetMotionOldFrame(_ARG_0_.myHandle) < 0 then
  else
  end
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  _ARG_0_.rot:sety(RoundPI(_ARG_0_.rot:gety() + DegToRad((Entity.GetMotionNowFrame(_ARG_0_.myHandle) - Entity.GetMotionOldFrame(_ARG_0_.myHandle)) * (90 / Entity.GetMotionTotalFrame(_ARG_0_.myHandle))) * _ARG_1_))
  Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
  return DegToRad((Entity.GetMotionNowFrame(_ARG_0_.myHandle) - Entity.GetMotionOldFrame(_ARG_0_.myHandle)) * (90 / Entity.GetMotionTotalFrame(_ARG_0_.myHandle))) * _ARG_1_
end
function m05ex00.TurnY(_ARG_0_, _ARG_1_)
  Entity.GetRot(_ARG_0_.WorkVec, _ARG_0_.myHandle)
  _ARG_0_.WorkVec:sety(_ARG_0_.WorkVec:gety() + _ARG_1_)
  Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function m05ex00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.targetHandle = NULL_HANDLE
  _ARG_0_.MoveFlag = 0
  _ARG_0_.Speed = 0
  _ARG_0_.noWallTime = 0
  _ARG_0_.DelayTime = 0
  _ARG_0_.IdlingTime = 0
  _ARG_0_.MoveMode = 0
  _ARG_0_.AngY = 0
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkTime = 0
  _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
  _ARG_0_.startpos = FVECTOR3.new(0, 0, 0)
  Entity.GetWorldPos(_ARG_0_.startpos, _ARG_0_.myHandle)
  _ARG_0_.cameraPos = FVECTOR3.new(0, 0, 0)
  if B90CD_INIT_PARAM == false then
    B90CD_INIT_PARAM = true
  end
  Entity.SetLowerHalf(_ARG_0_.myHandle, 0.8)
  Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
  Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
  Entity.EnableLockon(_ARG_0_.myHandle, 0)
  Entity.EnableGravity(_ARG_0_.myHandle, 1)
  if Enemy.IsAllEnemyWaiting() == true then
    _ARG_0_:GotoState("Standby")
  else
    _ARG_0_:GotoState("Appear")
    Entity.EnableLockon(_ARG_0_.myHandle, 1)
  end
end
function m05ex00.OnDamage(_ARG_0_, _ARG_1_)
end
function m05ex00.OnReturnDamage(_ARG_0_)
  _ARG_0_:GotoState("Idling")
end
function m05ex00.OnHitAttack(_ARG_0_)
  _ARG_0_.AttackFlag = 1
end
function m05ex00.OnUpdatePositionAfter(_ARG_0_)
  if _ARG_0_.flag then
    _ARG_0_.rot:set(0, _ARG_0_.angle, 0)
    Entity.RotateBoneXYZ(_ARG_0_.myHandle, 2, _ARG_0_.rot)
  end
end
function m05ex00.Debug(_ARG_0_)
  if Script.IsDebugCheckAttack() then
    for _FORV_5_, _FORV_6_ in pairs(_UPVALUE0_) do
      if _FORV_6_ == _ARG_0_:GetState() then
        return
      end
    end
    if _UPVALUE0_[Script.GetDebugAttackNumber() + 1] ~= nil then
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      _ARG_0_:GotoState(_UPVALUE0_[Script.GetDebugAttackNumber() + 1])
    end
  end
end
function m05ex00.OnUpdate(_ARG_0_)
  _ARG_0_:Update()
  _ARG_0_:Debug()
  _ARG_0_.DelayTime = _ARG_0_.DelayTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
  _ARG_0_.IdlingTime = _ARG_0_.DelayTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
end
EntityFactory:Add("m05ex00", function(_ARG_0_)
  return (m05ex00:new())
end)
EntityFactory:Add("m05vs00", function(_ARG_0_)
  return (m05ex00:new())
end)
