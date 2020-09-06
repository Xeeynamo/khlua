m10ex00 = {}
m10ex00_base_mt = {__index = __StateMachine}
setmetatable(m10ex00, m10ex00_base_mt)
m10ex00_mt = {__index = m10ex00}
function m10ex00.new(_ARG_0_)
  return setmetatable(__StateMachine:new(), m10ex00_mt)
end
m10ex00.states = {
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
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
      if Script.Random() < 0.5 then
        _ARG_0_.rotDir = 1
      else
        _ARG_0_.rotDir = -1
      end
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
        return
      end
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      if CanDisappear(_ARG_0_.myHandle, _ARG_0_.targetHandle) then
        _ARG_0_:GotoState("Disappear")
        return
      end
      if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) == false then
        Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
        _ARG_0_.rot:sety(RoundPI(_ARG_0_.rot:gety() + DegToRad(_ARG_0_.rotDir * 2) * Entity.GetFrameRate(_ARG_0_.myHandle)))
        Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
        return
      end
      if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE0_ then
        if Script.Random() < _UPVALUE1_ then
          _ARG_0_:GotoState("Passion")
        else
          _ARG_0_:GotoState("Wander")
        end
      elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) >= _UPVALUE0_ and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < ENEMY_COMMON_DISAPPEAR_DIST then
        _ARG_0_:GotoState("Wander")
      end
    end
  },
  Idling2 = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
      if Script.Random() < 0.5 then
        _ARG_0_.rotDir = 1
      else
        _ARG_0_.rotDir = -1
      end
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.modeBTimer <= 0 then
        _ARG_0_.mode = _UPVALUE0_
        _ARG_0_:ChangeIdlingState()
        return
      end
      if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
        return
      end
      Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
      _ARG_0_.rot:sety(RoundPI(_ARG_0_.rot:gety() + DegToRad(_ARG_0_.rotDir * 2) * Entity.GetFrameRate(_ARG_0_.myHandle)))
      Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE1_ then
        if _ARG_0_:IsTargetWithinFOV() then
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 6.25 then
            _ARG_0_:GotoState("RoundTripSlapOrEarJumpAttack")
          else
            _ARG_0_.nextState = 1
            _ARG_0_:GotoState("ApproachTarget")
          end
        end
      elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) >= _UPVALUE1_ and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE2_ then
        if _ARG_0_:IsTargetWithinFOV() then
          _ARG_0_:GotoState("EarHellCar")
        end
      elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) >= _UPVALUE2_ and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < ENEMY_COMMON_DISAPPEAR_DIST then
        if _ARG_0_:IsTargetWithinFOV() then
          _ARG_0_.nextState = 0
          _ARG_0_:GotoState("ApproachTarget")
        end
      elseif 0 >= Entity.GetUserShootLocked(_ARG_0_.myHandle) and (Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) >= ENEMY_COMMON_DISAPPEAR_DIST or Entity.CalcStartPosDistanceSq(_ARG_0_.myHandle) >= ENEMY_COMMON_DISAPPEAR_DIST) then
        _ARG_0_:GotoState("Disappear")
      end
    end
  },
  Wander = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_ * 0.5 + Script.Random() * (_UPVALUE1_ * 0.5))
      _ARG_0_.moveTimer = 0
      _ARG_0_.avoidTimer = 0
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
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
        return
      end
      _ARG_0_.avoidTimer = _ARG_0_.avoidTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
      _ARG_0_.moveTimer = _ARG_0_.moveTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
      if _ARG_0_.moveTimer <= 0 then
        _ARG_0_.workVec0:set(Math.Cos((RoundPI(DegToRad((Script.Random() - Script.Random()) * 360)))) * (1.75 + Script.Random() * 4), 0, Math.Sin((RoundPI(DegToRad((Script.Random() - Script.Random()) * 360)))) * (1.75 + Script.Random() * 4))
        _ARG_0_.moveTimer = _UPVALUE0_
      end
      Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
      FVECTOR3.Add(_ARG_0_.targetPos, _ARG_0_.targetPos, _ARG_0_.workVec0)
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 2.5)
      _ARG_0_.velocity:set(0, 0, _UPVALUE1_)
      Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
      if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) <= 1 then
        _ARG_0_.moveTimer = 0
      end
    end
  },
  ApproachTarget = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
      _ARG_0_.velocity:set(0, 0, _UPVALUE0_)
      Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
      if _ARG_0_.nextState == 0 then
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= 6.25 then
          _ARG_0_:GotoState("EarHellCar")
        end
      elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= 2.25 then
        _ARG_0_:GotoState("RoundTripSlapOrEarJumpAttack")
      end
    end
  },
  EarJumpAttack = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.EnableGravity(_ARG_0_.myHandle, 0)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
    end,
    OnEndState = function(_ARG_0_)
      Entity.EnableGravity(_ARG_0_.myHandle, 1)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
    end,
    OnUpdate = function(_ARG_0_)
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Stiff")
      end
    end
  },
  RoundTripSlapOrEarJumpAttack = {
    OnBeginState = function(_ARG_0_)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      _ARG_0_.step = 0
      _ARG_0_.attackCount = _UPVALUE0_
    end,
    OnEndState = function(_ARG_0_)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      Entity.EnableGravity(_ARG_0_.myHandle, 1)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Script.Random() < _UPVALUE0_ then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
          Entity.EnableGravity(_ARG_0_.myHandle, 1)
        else
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
          Entity.EnableGravity(_ARG_0_.myHandle, 0)
        end
        _ARG_0_.step = 1
      elseif _ARG_0_.step == 1 then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > 9 then
            _ARG_0_.attackCount = _ARG_0_.attackCount - 1
            if 0 < _ARG_0_.attackCount then
              _ARG_0_.step = 0
              return
            end
          end
          if Script.Random() < 0.5 then
            _ARG_0_:GotoState("Stiff")
          else
            _ARG_0_:GotoState("Passion")
          end
        end
      end
    end
  },
  RotationKick = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
      _ARG_0_.rot:sety(Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle))
      Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
    end,
    OnEndState = function(_ARG_0_)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
      _ARG_0_.modeBTimer = _UPVALUE0_
    end,
    OnUpdate = function(_ARG_0_)
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:ChangeIdlingState()
      end
    end
  },
  EarHellCar = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        _ARG_0_.velocity:set(0, 0, _UPVALUE2_)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
          Entity.ClearSpeed(_ARG_0_.myHandle)
          _ARG_0_.step = 2
        end
      elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
        if Script.Random() < 0.5 then
          _ARG_0_:GotoState("Stiff")
        else
          _ARG_0_:GotoState("Passion")
        end
      end
    end
  },
  Passion = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 0)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.mode == _UPVALUE0_ then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("EarJumpAttack")
        end
      elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:ChangeIdlingState()
      end
    end
  },
  Stiff = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
      if _ARG_0_.mode == _UPVALUE1_ then
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE2_)
      else
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE3_)
      end
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:ChangeIdlingState()
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
function m10ex00.IsTargetWithinFOV(_ARG_0_)
  _ARG_0_.workVec0:set(0, 1, 0)
  if Entity.IsTargetWithinFOV(_ARG_0_.myHandle, _ARG_0_.targetHandle, DegToRad(180), 4, _ARG_0_.workVec0) == false then
    return false
  end
  return true
end
function m10ex00.ChangeIdlingState(_ARG_0_)
  if _ARG_0_.mode == _UPVALUE0_ then
    _ARG_0_:GotoState("Idling")
  else
    _ARG_0_:GotoState("Idling2")
  end
end
function m10ex00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  Entity.EnableGravity(_ARG_0_.myHandle, 1)
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
  _ARG_0_.mode = _UPVALUE0_
  _ARG_0_.attackCount = 0
  _ARG_0_.moveTimer = 0
  _ARG_0_.avoidTimer = 0
  _ARG_0_.modeBTimer = 0
  _ARG_0_.rotDir = 1
  _ARG_0_.nextState = 0
  if _UPVALUE1_ == false then
    _UPVALUE2_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "WanderTime") * 60
    _UPVALUE3_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "StiffTimeA") * 60
    _UPVALUE4_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "StiffTimeB") * 60
    _UPVALUE5_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "ModeBTime") * 60
    _UPVALUE6_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "ModeADist1")
    _UPVALUE7_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "ModeARnd") / 100
    _UPVALUE8_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "ModeBDist1")
    _UPVALUE9_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "ModeBDist2")
    M10EX_MODE_B_RND = Enemy.GetExtraParam(_ARG_0_.myHandle, "ModeBRnd") / 100
    _UPVALUE10_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "AtkCnt")
    _UPVALUE11_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "RndChgMode") / 100
    _UPVALUE6_ = _UPVALUE6_ * _UPVALUE6_
    _UPVALUE8_ = _UPVALUE8_ * _UPVALUE8_
    _UPVALUE9_ = _UPVALUE9_ * _UPVALUE9_
    _UPVALUE1_ = true
  end
  if Enemy.IsAllEnemyWaiting() then
    _ARG_0_:GotoState("Waiting")
  else
    _ARG_0_:GotoState("Appear")
  end
end
function m10ex00.OnHitAttack(_ARG_0_)
  if Entity.GetCurrentMotion(_ARG_0_.myHandle) == _UPVALUE0_ then
    Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
    Entity.ClearSpeed(_ARG_0_.myHandle)
    _ARG_0_.step = 2
  end
end
function m10ex00.OnDamage(_ARG_0_, _ARG_1_, _ARG_2_)
  if (Entity.GetCurrentMotion(_ARG_0_.myHandle) == _UPVALUE0_ or Entity.GetCurrentMotion(_ARG_0_.myHandle) == _UPVALUE1_ or Entity.GetCurrentMotion(_ARG_0_.myHandle) == _UPVALUE2_ or Entity.GetCurrentMotion(_ARG_0_.myHandle) == _UPVALUE3_ or Entity.GetCurrentMotion(_ARG_0_.myHandle) == M10EX_MOT_BIG_BACK_FRONT or Entity.GetCurrentMotion(_ARG_0_.myHandle) == M10EX_MOT_BIG_BACK_FRONT_RET) and Script.Random() < _UPVALUE4_ then
    _ARG_0_:GotoState("RotationKick")
    return 1
  end
  if _ARG_0_.mode == _UPVALUE5_ then
    _ARG_0_.mode = _UPVALUE6_
    _ARG_0_.modeBTimer = _UPVALUE7_
  end
  return 0
end
function m10ex00.OnReturnDamage(_ARG_0_)
  _ARG_0_:ChangeIdlingState()
end
function m10ex00.OnEndReaction(_ARG_0_)
  Entity.ClearSpeed(_ARG_0_.myHandle)
  Entity.EnableGravity(_ARG_0_.myHandle, 1)
end
function m10ex00.OnUpdate(_ARG_0_)
  if Entity.IsAlive(_ARG_0_.targetHandle) == false then
    _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
  end
  _ARG_0_:Update()
  _ARG_0_:Debug()
  if _ARG_0_.modeBTimer > 0 then
    _ARG_0_.modeBTimer = _ARG_0_.modeBTimer - 1
  end
end
function m10ex00.Debug(_ARG_0_)
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
EntityFactory:Add("m10ex00", function(_ARG_0_)
  return (m10ex00:new())
end)
EntityFactory:Add("m10vs00", function(_ARG_0_)
  return (m10ex00:new())
end)
