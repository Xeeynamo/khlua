m04ex00 = {}
m04ex00_base_mt = {__index = __StateMachine}
setmetatable(m04ex00, m04ex00_base_mt)
m04ex00_mt = {__index = m04ex00}
function m04ex00.new(_ARG_0_)
  return setmetatable(__StateMachine:new(), m04ex00_mt)
end
m04ex00.states = {
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
  Waiting = {
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
  Idling = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling2")
      end
    end
  },
  Idling2 = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      Enemy.GetTargetLastRecordedPos(_ARG_0_.playerPos, _ARG_0_.myHandle, _ARG_0_.targetHandle)
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.playerPos, 1.5)
      if CanDisappear(_ARG_0_.myHandle, (Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR))) then
        _ARG_0_:GotoState("Disappear")
        return
      end
      if Entity.GetFloorDistance(_ARG_0_.myHandle) > 8 and Enemy.CanAttack(_ARG_0_.myHandle, (Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR))) == false then
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        _ARG_0_:GotoState("Move")
        return
      end
      if Entity.CalcDistanceSq(_ARG_0_.myHandle, (Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR))) <= ENEMY_COMMON_DISAPPEAR_DIST then
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, (Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR))) > _UPVALUE0_ and Enemy.CanAttack(_ARG_0_.myHandle, (Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR))) == false then
          return
        end
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        _ARG_0_:GotoState("Move")
      end
    end
  },
  Move = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
      Entity.GetWorldPos(_ARG_0_.playerPos, _ARG_0_.targetHandle)
      Entity.EnableAvoidPlayer(_ARG_0_.myHandle, 1)
      Entity.EnableAvoidEnemy(_ARG_0_.myHandle, 1)
      _ARG_0_.time = 0
      _ARG_0_.angle = 0
      _ARG_0_.step = 0
      _ARG_0_.work0 = 1.5 + Script.Random()
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      Entity.EnableAvoidPlayer(_ARG_0_.myHandle, 0)
      Entity.EnableAvoidEnemy(_ARG_0_.myHandle, 0)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.HasNetGameHandle(_ARG_0_.myHandle) and Enemy.IsNetworkMaster(_ARG_0_.myHandle) == false then
        return
      end
      if Entity.CanUserTarget(_ARG_0_.targetHandle) == false then
        _ARG_0_:GotoState("Idling")
        return
      end
      _ARG_0_.time = _ARG_0_.time - Entity.GetFrameRate(_ARG_0_.myHandle)
      if _ARG_0_.time <= 0 or Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.playerPos) <= 1 then
        Entity.GetWorldPos(_ARG_0_.playerPos, _ARG_0_.targetHandle)
        _ARG_0_.workVec0:set(Math.Cos((Script.RandomInRange(-PI, PI))) * (Script.Random() * 4), 0, Math.Sin((Script.RandomInRange(-PI, PI))) * (Script.Random() * 4))
        FVECTOR3.Add(_ARG_0_.playerPos, _ARG_0_.playerPos, _ARG_0_.workVec0)
        Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.myHandle)
        _ARG_0_.playerPos:sety(_ARG_0_.playerPos:gety() - Entity.GetFloorDistance(_ARG_0_.targetHandle) + Script.Random() * 2)
        _ARG_0_.time = 60
      end
      _ARG_0_:CalcTargetVelocity(_ARG_0_.playerPos, 5, _UPVALUE0_)
      if _ARG_0_.step == 0 then
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE1_ then
          if Script.Random() < _UPVALUE2_ then
            _ARG_0_:GotoState("JetAttack")
            return
          else
            _ARG_0_.step = 1
          end
        elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) >= _UPVALUE3_ and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE4_ then
          if Script.Random() < _UPVALUE5_ then
            _ARG_0_:GotoState("Sneer")
            return
          else
            _ARG_0_.step = 1
          end
        end
      end
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Sneer = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 0)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        if Script.Random() < _UPVALUE0_ then
          _ARG_0_:GotoState("SpiralAttack")
        else
          _ARG_0_:GotoState("Fire")
        end
      end
    end
  },
  SpiralAttack = {
    OnBeginState = function(_ARG_0_)
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
          _ARG_0_.velocity:normalize()
          _ARG_0_.axis:copy(_ARG_0_.velocity)
          _ARG_0_.velocity:scale(_UPVALUE0_)
          Entity.ClearSpeed(_ARG_0_.myHandle)
          _ARG_0_.angle = 0
          _ARG_0_.flag = true
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 then
        Entity.RotateAxis(_ARG_0_.myHandle, _ARG_0_.axis, _ARG_0_.angle, _ARG_0_.radius, _ARG_0_.myPos)
        _ARG_0_.angle = RoundPI(_ARG_0_.angle + DegToRad(15 * Entity.GetFrameRate(_ARG_0_.myHandle)))
        FVECTOR3.Scale(_ARG_0_.workVec0, _ARG_0_.velocity, (Entity.GetFrameRate(_ARG_0_.myHandle)))
        FVECTOR3.Add(_ARG_0_.myPos, _ARG_0_.myPos, _ARG_0_.workVec0)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_.flag = false
          _ARG_0_.step = 2
        end
      elseif _ARG_0_.step == 2 and _ARG_0_:TurnX(0, 10) == false then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  JetAttack = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.velocity:set(0, 0.025, 0)
      Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        Entity.GetWorldPos(_ARG_0_.playerPos, _ARG_0_.targetHandle)
        Entity.TurnTargetDegree(_ARG_0_.myHandle, _ARG_0_.playerPos, 30)
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 26 then
          Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
          FVECTOR3.Sub(_ARG_0_.velocity, _ARG_0_.playerPos, _ARG_0_.myPos)
          Entity.SetTimer(_ARG_0_.myHandle, (_ARG_0_.velocity:length() + 2.5) / _UPVALUE0_)
          _ARG_0_.velocity:normalize()
          _ARG_0_.velocity:scale(_UPVALUE0_)
          Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 then
        if Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.IsWall(_ARG_0_.myHandle) or Entity.IsCeiling(_ARG_0_.myHandle) then
          Entity.ClearSpeed(_ARG_0_.myHandle)
          _ARG_0_.step = 2
        end
      elseif _ARG_0_:TurnX(0, 10) == false then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Fire = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        Entity.GetWorldPos(_ARG_0_.playerPos, _ARG_0_.targetHandle, 0)
        Entity.TurnTargetDegree(_ARG_0_.myHandle, _ARG_0_.playerPos, 20)
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 28 then
          Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle, 2)
          Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
          CreateEnemyBullet(_UPVALUE0_, _ARG_0_.myHandle, _ARG_0_.myPos, _ARG_0_.rot)
          _ARG_0_.step = 1
        end
      elseif _ARG_0_:TurnX(0, 10) == false then
        _ARG_0_:GotoState("Idling")
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
}
function m04ex00.TurnX(_ARG_0_, _ARG_1_, _ARG_2_)
  Entity.EnableAvoidPlayer(_ARG_0_.myHandle, 0)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  _ARG_0_.rot:setx(HomingDegree(_ARG_0_.rot:getx(), _ARG_1_, _ARG_2_, Entity.GetFrameRate(_ARG_0_.myHandle)))
  Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
  return HomingDegree(_ARG_0_.rot:getx(), _ARG_1_, _ARG_2_, Entity.GetFrameRate(_ARG_0_.myHandle))
end
function m04ex00.CalcTargetVelocity(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
  FVECTOR3.Sub(_UPVALUE1_, _ARG_1_, _UPVALUE0_)
  _UPVALUE1_:normalize()
  FVECTOR3.Mul(_UPVALUE2_, _UPVALUE1_, _UPVALUE1_)
  Entity.GetRot(_UPVALUE3_, _ARG_0_.myHandle)
  _UPVALUE3_:sety(HomingDegree(_UPVALUE3_:gety(), Math.Atan2(_UPVALUE1_:getx(), _UPVALUE1_:getz()), _ARG_2_, (Entity.GetFrameRate(_ARG_0_.myHandle))))
  Entity.SetRot(_ARG_0_.myHandle, _UPVALUE3_)
  _UPVALUE3_:setx(-Math.Atan2(_UPVALUE1_:gety(), Math.Sqrt(_UPVALUE2_:getx() + _UPVALUE2_:getz())))
  _UPVALUE4_:set(0, 0, _ARG_3_)
  Math.RotateVectorXYZ(_UPVALUE4_, _UPVALUE3_)
  Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE4_)
end
function m04ex00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.axis = FVECTOR3.new(0, 0, 0)
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
  _ARG_0_.playerPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec0 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.angle = 0
  _ARG_0_.targetAngle = 0
  _ARG_0_.radius = 0.75
  _ARG_0_.step = 0
  _ARG_0_.time = 0
  _ARG_0_.flag = false
  _ARG_0_.work0 = 0
  _ARG_0_.targetHandle = NULL_HANDLE
  if Enemy.IsAllEnemyWaiting() then
    _ARG_0_:GotoState("Waiting")
  else
    _ARG_0_:GotoState("Appear")
  end
end
function m04ex00.OnDamage(_ARG_0_, _ARG_1_, _ARG_2_)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  _ARG_0_.rot:setx(0)
  Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
  _ARG_0_.flag = false
  return 0
end
function m04ex00.OnReturnDamage(_ARG_0_)
  _ARG_0_:GotoState("Idling")
end
function m04ex00.OnReflect(_ARG_0_)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  _ARG_0_.rot:setx(0)
  Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
  _ARG_0_.flag = false
  return 0
end
function m04ex00.OnUpdatePositionAfter(_ARG_0_)
  if _ARG_0_.flag then
    _ARG_0_.rot:set(0, _ARG_0_.angle, 0)
    Entity.RotateBoneXYZ(_ARG_0_.myHandle, 2, _ARG_0_.rot)
  end
end
function m04ex00.OnUpdate(_ARG_0_)
  if Entity.IsAlive(_ARG_0_.targetHandle) == false then
    _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
  end
  _ARG_0_:Update()
  _ARG_0_:Debug()
end
function m04ex00.Debug(_ARG_0_)
  if Script.IsDebugCheckAttack() then
    for _FORV_5_, _FORV_6_ in pairs(_UPVALUE0_) do
      if _FORV_6_ == _ARG_0_:GetState() then
        return
      end
    end
    if _UPVALUE0_[Script.GetDebugAttackNumber() + 1] ~= nil then
      _ARG_0_:GotoState(_UPVALUE0_[Script.GetDebugAttackNumber() + 1])
    end
  end
end
EntityFactory:Add("m04ex00", function(_ARG_0_)
  return (m04ex00:new())
end)
EntityFactory:Add("m04vs00", function(_ARG_0_)
  return (m04ex00:new())
end)
