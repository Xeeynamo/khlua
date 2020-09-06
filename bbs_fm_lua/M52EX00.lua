m52ex00 = {}
m52ex00_base_mt = {__index = __StateMachine}
setmetatable(m52ex00, m52ex00_base_mt)
m52ex00_mt = {__index = m52ex00}
function m52ex00.new(_ARG_0_)
  return setmetatable(__StateMachine:new(), m52ex00_mt)
end
m52ex00.states = {
  Appear = {
    OnBeginState = function(_ARG_0_)
      SetupAppearBegin(_ARG_0_.myHandle, 1, _UPVALUE0_, 0)
      _ARG_0_.step = 0
      if Player.GetPlayerID(_ARG_0_.targetHandle) == PLAYER_ID_VENTUS then
      elseif Player.GetPlayerID(_ARG_0_.targetHandle) == PLAYER_ID_AQUA then
      elseif Player.GetPlayerID(_ARG_0_.targetHandle) == PLAYER_ID_TERRA then
      end
    end,
    OnEndState = function(_ARG_0_)
      SetupAppearEnd(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Wander")
      end
    end
  },
  Idling = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetTimer(_ARG_0_.myHandle, Script.Random() * 180)
      _ARG_0_.step = 0
      Entity.EnableGravity(_ARG_0_.myHandle, 0)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnEndState = function(_ARG_0_)
      Entity.EnableGravity(_ARG_0_.myHandle, 1)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:ChangeState()
      end
    end
  },
  Move = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_ + Script.Random() * _UPVALUE1_)
      _ARG_0_.step = 0
      Entity.EnableGravity(_ARG_0_.myHandle, 1)
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      _ARG_0_.TowsteppeFlag = 0
      Entity.EnableGravity(_ARG_0_.myHandle, 1)
    end,
    OnUpdate = function(_ARG_0_)
    end
  },
  Wander = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetAnimNowFrame(_ARG_0_.myHandle, Script.Random() * Entity.GetMotionTotalFrame(_ARG_0_.myHandle))
      _ARG_0_.step = _UPVALUE1_
      _ARG_0_.count = 0
      _ARG_0_.WanderCnt = Script.Random() * 3 + 50
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      Entity.EnableGravity(_ARG_0_.myHandle, 1)
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == _UPVALUE0_ then
        Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
        _ARG_0_.targetPos:setx(_ARG_0_.targetPos:getx() + (10 * Script.Random() + 20) * Math.Cos((RoundPI(Script.Random() * 2 * PI))))
        _ARG_0_.targetPos:setz(_ARG_0_.targetPos:getz() + (10 * Script.Random() + 20) * Math.Sin((RoundPI(Script.Random() * 2 * PI))))
        Entity.SetTimer(_ARG_0_.myHandle, 60 + Script.Random() * _UPVALUE1_)
        _ARG_0_.noWallHitTime = 20
        _ARG_0_.step = _UPVALUE2_
      elseif _ARG_0_.step == _UPVALUE3_ then
      elseif _ARG_0_.step == _UPVALUE2_ then
        if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) == true then
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 5)
        _ARG_0_.MoveFlag = M02EX_MOVETYPE_HOMING
        _ARG_0_.velocity:set(0, 0, _UPVALUE4_)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
        _ARG_0_.noWallHitTime = _ARG_0_.noWallHitTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.noWallHitTime < 0 then
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.IsWall(_ARG_0_.myHandle) == true or Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetPos) < 4 then
          _ARG_0_.count = _ARG_0_.count + 1
          if _ARG_0_.count > _ARG_0_.WanderCnt then
            _ARG_0_:GotoState("Idling")
          else
            _ARG_0_.step = _UPVALUE0_
          end
        end
      end
    end
  },
  Guard = {
    OnBeginState = function(_ARG_0_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
      _ARG_0_.GuardFlag = 1
      Entity.EnableGuard(_ARG_0_.myHandle, 1)
      Entity.EnableGuardPhysical(_ARG_0_.myHandle, 1)
      Entity.EnableGuardZero(_ARG_0_.myHandle, 1)
      Entity.EnableGuardFire(_ARG_0_.myHandle, 1)
      Entity.EnableGuardIce(_ARG_0_.myHandle, 1)
      Entity.EnableGuardThunder(_ARG_0_.myHandle, 1)
      Entity.SetGuardDir(_ARG_0_.myHandle, 360)
      Entity.EnableGuardSpecial(_ARG_0_.myHandle, 1)
      _ARG_0_.AttackCnt = 0
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.TowsteppeFlag = 0
      Entity.ClearSpeed(_ARG_0_.myHandle)
      Entity.EnableGravity(_ARG_0_.myHandle, 1)
    end,
    OnEndState = function(_ARG_0_)
      Entity.EnableGuard(_ARG_0_.myHandle, 0)
      Entity.EnableGuardPhysical(_ARG_0_.myHandle, 0)
      Entity.EnableGuardZero(_ARG_0_.myHandle, 0)
      Entity.EnableGuardZeroEx(_ARG_0_.myHandle, 0)
      Entity.EnableGuardFire(_ARG_0_.myHandle, 0)
      Entity.EnableGuardIce(_ARG_0_.myHandle, 0)
      Entity.EnableGuardThunder(_ARG_0_.myHandle, 0)
      Entity.SetGuardDir(_ARG_0_.myHandle, 0)
      Entity.EnableGuardSpecial(_ARG_0_.myHandle, 0)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_.step = 1
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        end
      elseif _ARG_0_.step == 1 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= _UPVALUE1_ / 2 then
          Entity.EnableGuard(_ARG_0_.myHandle, 0)
          Entity.EnableGuardPhysical(_ARG_0_.myHandle, 0)
          Entity.EnableGuardZero(_ARG_0_.myHandle, 0)
          Entity.EnableGuardZeroEx(_ARG_0_.myHandle, 0)
          Entity.EnableGuardFire(_ARG_0_.myHandle, 0)
          Entity.EnableGuardIce(_ARG_0_.myHandle, 0)
          Entity.EnableGuardThunder(_ARG_0_.myHandle, 0)
          Entity.SetGuardDir(_ARG_0_.myHandle, 0)
          Entity.EnableGuardSpecial(_ARG_0_.myHandle, 0)
          _ARG_0_.GuardFlag = 0
          _ARG_0_.step = 2
        end
      elseif _ARG_0_.step == 2 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Wander")
      end
    end
  },
  Standby = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.EnableGravity(_ARG_0_.myHandle, 0)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Enemy.IsAllEnemyWaiting() == false then
        _ARG_0_:GotoState("Wander")
      end
    end
  },
  Disappear = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.EnableGravity(_ARG_0_.myHandle, 0)
      SetupDisappear(_ARG_0_.myHandle, 20)
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
function m52ex00.WhichRightandLeft(_ARG_0_)
  Entity.GetWorldPos(_ARG_0_.WorkVec1, _ARG_0_.targetHandle)
  Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.myHandle)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.WorkVec1, _ARG_0_.WorkVec)
  FVECTOR3.normalize(_ARG_0_.workVec)
  if RoundPI((Math.Atan2(_ARG_0_.workVec:getx(), _ARG_0_.workVec:getz()) - _ARG_0_.rot:gety()) * -1) < 0 then
    return 1
  else
    return 0
  end
end
function m52ex00.Rotation(_ARG_0_, _ARG_1_)
  Entity.GetRot(_ARG_0_.WorkVec, _ARG_0_.myHandle)
  _ARG_0_.WorkVec:set(0, _ARG_0_.WorkVec:gety() + _ARG_1_, 0)
  Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function m52ex00.OnItGathers(_ARG_0_, _ARG_1_)
end
function m52ex00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.targetHandle = NULL_HANDLE
  _ARG_0_.targetStompar = NULL_HANDLE
  _ARG_0_.MoveFlag = 0
  _ARG_0_.DamageCnt = 0
  _ARG_0_.GuardFlag = 0
  _ARG_0_.RushFlag = 0
  _ARG_0_.TramplingFlag = 0
  _ARG_0_.TramplingCnt = 0
  _ARG_0_.AttackFlag = 0
  _ARG_0_.AttackCnt = 0
  _ARG_0_.JumpPow = 0
  _ARG_0_.Gravity = 0
  _ARG_0_.Standstill = 0
  _ARG_0_.TowsteppeFlag = 0
  _ARG_0_.noWallHitTim = 0
  _ARG_0_.WanderCnt = 0
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkTime = 0
  _ARG_0_.WorkVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
  _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.cameraPos = FVECTOR3.new(0, 0, 0)
  if _UPVALUE0_ == false then
    _UPVALUE1_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "SearchDist")
    _UPVALUE1_ = _UPVALUE1_ * _UPVALUE1_
    _UPVALUE2_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "GuardTime") * 60
    _UPVALUE3_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "RunTime") * 60
    _UPVALUE4_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "MoveRate") * 0.01
    _UPVALUE5_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "IdlingRate") * 0.01
    _UPVALUE6_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "GuardRate") * 0.01
    _UPVALUE7_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "EnemyMum")
    _UPVALUE0_ = true
  end
  if _UPVALUE8_ == 0 then
  end
  _UPVALUE8_ = 1
  Entity.SetMovementCollRadius(_ARG_0_.myHandle, 0.6)
  Entity.SetLowerHalf(_ARG_0_.myHandle, 1)
  Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
  Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
  Entity.EnableLockon(_ARG_0_.myHandle, 1)
  Entity.EnableGravity(_ARG_0_.myHandle, 1)
  Entity.SetLockOnBoneNum(_ARG_0_.myHandle, 4)
  if Enemy.IsAllEnemyWaiting() == true then
    _ARG_0_:GotoState("Standby")
  else
    _ARG_0_:GotoState("Appear")
  end
end
function m52ex00.OnMessage(_ARG_0_, _ARG_1_)
  if _ARG_1_ == 1 then
    _ARG_0_:GotoState("ItGathers")
  end
end
function m52ex00.ChangeState(_ARG_0_)
  if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE0_ then
    if Script.Random() < _UPVALUE1_ then
      _ARG_0_:GotoState("Wander")
    else
      _ARG_0_:GotoState("Guard")
    end
  elseif Script.Random() < _UPVALUE2_ then
    _ARG_0_:GotoState("Idilng")
  elseif Script.Random() < _UPVALUE2_ + _UPVALUE3_ then
    _ARG_0_:GotoState("Guard")
  else
    _ARG_0_:GotoState("Wander")
  end
end
function m52ex00.OnDamage(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if _ARG_1_ == ATK_KIND_SLEEP or _ARG_3_ == ATK_ATTR_ZERO or _ARG_1_ == ATK_KIND_FAINT or _ARG_1_ == ATK_KIND_MAGNET or _ARG_1_ == ATK_KIND_ZEROGRAVITY or _ARG_1_ == ATK_KIND_MINIMUM or _ARG_1_ == ATK_KIND_MAGNEBREAKER then
    Entity.EnableGuard(_ARG_0_.myHandle, 0)
    Entity.EnableGuardPhysical(_ARG_0_.myHandle, 0)
    Entity.EnableGuardZero(_ARG_0_.myHandle, 0)
    Entity.EnableGuardZeroEx(_ARG_0_.myHandle, 0)
    Entity.EnableGuardFire(_ARG_0_.myHandle, 0)
    Entity.EnableGuardIce(_ARG_0_.myHandle, 0)
    Entity.EnableGuardThunder(_ARG_0_.myHandle, 0)
    Entity.SetGuardDir(_ARG_0_.myHandle, 0)
    Entity.EnableGuardSpecial(_ARG_0_.myHandle, 0)
  end
  if Enemy.IsSpecialDamage(_ARG_0_.myHandle) == false then
    Entity.EnableGravity(_ARG_0_.myHandle, 1)
  end
  if Enemy.IsSpecialDamage(_ARG_0_.myHandle) or _ARG_1_ == ATK_KIND_SLEEP or _ARG_1_ == ATK_KIND_FAINT or _ARG_1_ == ATK_KIND_MINIMUM or _ARG_1_ == ATK_KIND_SLEEP then
    Entity.EnableGuard(_ARG_0_.myHandle, 0)
    Entity.EnableGuardPhysical(_ARG_0_.myHandle, 0)
    Entity.EnableGuardZero(_ARG_0_.myHandle, 0)
    Entity.EnableGuardZeroEx(_ARG_0_.myHandle, 0)
    Entity.EnableGuardFire(_ARG_0_.myHandle, 0)
    Entity.EnableGuardIce(_ARG_0_.myHandle, 0)
    Entity.EnableGuardThunder(_ARG_0_.myHandle, 0)
    Entity.SetGuardDir(_ARG_0_.myHandle, 0)
    Entity.EnableGuardSpecial(_ARG_0_.myHandle, 0)
    return
  end
end
function m52ex00.OnReturnDamage(_ARG_0_)
  if Enemy.IsSpecialDamage(_ARG_0_.myHandle) == false then
    Entity.EnableGravity(_ARG_0_.myHandle, 1)
    _ARG_0_:GotoState("Idling")
  end
  _ARG_0_.targetStompar = NULL_HANDLE
end
function m52ex00.OnHitAttack(_ARG_0_)
  if _ARG_0_.TramplingFlag == 1 then
    _ARG_0_.AttackFlag = 1
  end
end
function m52ex00.OnUpdatePositionAfter(_ARG_0_)
  if _ARG_0_.flag then
    _ARG_0_.rot:set(0, _ARG_0_.angle, 0)
    Entity.RotateBoneXYZ(_ARG_0_.myHandle, 2, _ARG_0_.rot)
  end
end
function m52ex00.OnDead(_ARG_0_)
  _ARG_0_.step = 99
  Mission.SendMissonMessage(MES_STOMPER_OUT)
end
function m52ex00.OnDestroy(_ARG_0_)
  _ARG_0_.step = 99
end
function m52ex00.OnGuard(_ARG_0_)
  Entity.GetDamageCrossPos(_ARG_0_.WorkVec, _ARG_0_.myHandle)
  _ARG_0_.WorkVec1:set(0, 0, 0)
  Entity.SetEffect(_ARG_0_.myHandle, "p_ex_bas_00", "P_EX_ATC_DIS0_0", _ARG_0_.WorkVec, _ARG_0_.WorkVec1)
end
function m52ex00.GetCameraTargetPos(_ARG_0_)
  Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.myHandle)
  _ARG_0_.cameraPos:set(_ARG_0_.WorkVec:getx(), _ARG_0_.WorkVec:gety() - Entity.GetFloorDistance(_ARG_0_.myHandle) + 1, _ARG_0_.WorkVec:getz())
  return _ARG_0_.cameraPos
end
function m52ex00.Debug(_ARG_0_)
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
function m52ex00.OnUpdate(_ARG_0_)
  if Entity.IsAlive(_ARG_0_.targetHandle) == false then
    _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
  end
  _ARG_0_:Update()
  _ARG_0_:Debug()
end
EntityFactory:Add("m52ex00", function(_ARG_0_)
  return (m52ex00:new())
end)
EntityFactory:Add("m60ex00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
