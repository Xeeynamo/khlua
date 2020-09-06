M19EX_INIT_PARAM = false
m19ex00 = {}
m19ex00_base_mt = {__index = __StateMachine}
setmetatable(m19ex00, m19ex00_base_mt)
m19ex00_mt = {__index = m19ex00}
function m19ex00.new(_ARG_0_)
  return setmetatable(__StateMachine:new(), m19ex00_mt)
end
m19ex00.states = {
  Appear = {
    OnBeginState = function(_ARG_0_)
      SetupAppearBegin2(_ARG_0_.myHandle, 1, _UPVALUE0_, 0)
      Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
    end,
    OnEndState = function(_ARG_0_)
      SetupAppearEnd(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("UndergroundIdling")
      end
    end
  },
  UndergroundIdling = {
    OnBeginState = function(_ARG_0_)
      print("m19ex00:UndergroundIdling\n")
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_ + Script.Random() * 2)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      Entity.EnableHeavy(_ARG_0_.myHandle, 1)
      _ARG_0_.FeelingsDelayTime = _UPVALUE2_
      Entity.EnableShooton(_ARG_0_.myHandle, 0)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE0_ then
        _ARG_0_.Type = _UPVALUE1_
        _ARG_0_:GotoState("PoisonAttack")
        Enemy.EnableNoBattleMode(_ARG_0_.myHandle, 0)
        return
      end
      if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE2_ then
        Enemy.EnableNoBattleMode(_ARG_0_.myHandle, 0)
      else
        Enemy.EnableNoBattleMode(_ARG_0_.myHandle, 1)
      end
      if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
        return
      end
      if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE2_ then
        if Script.Random() < _UPVALUE3_ then
          _ARG_0_:GotoState("LeafCutter")
        else
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE4_ + Script.Random() * 2)
        end
      elseif CanDisappear(_ARG_0_.myHandle, _ARG_0_.targetHandle) == true then
        _ARG_0_:GotoState("Disappear")
        return
      end
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE4_ + Script.Random() * _UPVALUE5_)
    end
  },
  Idling = {
    OnBeginState = function(_ARG_0_)
      print("m19ex00:Idling\n")
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_ + Script.Random() * _UPVALUE1_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      Enemy.EnableNoBattleMode(_ARG_0_.myHandle, 0)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
        return
      end
      if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) == true then
        _ARG_0_:GotoState("Wander")
      else
        _ARG_0_:GotoState("Wander")
      end
    end
  },
  Move = {
    OnBeginState = function(_ARG_0_)
      print("m19ex00:Move\n")
      Entity.SetTimer(_ARG_0_.myHandle, 0)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
    end
  },
  LeafCutter = {
    OnBeginState = function(_ARG_0_)
      print("m19ex00:LeafCutter\n")
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.CanUserTarget(_ARG_0_.targetHandle) == true then
          if Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10) == false then
            _ARG_0_.step = 1
          end
        else
          Entity.GetRot(_ARG_0_.WorkVec, _ARG_0_.myHandle)
          _ARG_0_.WorkVec:sety(_ARG_0_.WorkVec:gety() + DegToRad(Script.Random() * 180 - 180))
          Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.WorkVec)
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 32 then
        _ARG_0_:CreateShot(_ARG_0_.myHandle)
        _ARG_0_.step = 2
      end
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("UndergroundIdling")
      end
    end
  },
  PanicAttack = {
    OnBeginState = function(_ARG_0_)
      print("m19ex00:PanicAttack\n")
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
      _ARG_0_.AttackDelayTime = _UPVALUE1_
      _ARG_0_.hitAttackFlag = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10) == false then
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 then
        if _ARG_0_.hitAttackFlag == 1 then
          _ARG_0_.hitAttackFlag = 0
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_ + Script.Random() * _UPVALUE2_)
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
          _ARG_0_.step = 2
        end
      elseif _ARG_0_.step == 2 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Wander")
        end
      elseif _ARG_0_.step == 3 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Wander")
      end
    end
  },
  PoisonAttack = {
    OnBeginState = function(_ARG_0_)
      print("m19ex00:PoisonAttack\n")
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
      _ARG_0_.loopCnt = _UPVALUE1_
      Entity.EnableHeavy(_ARG_0_.myHandle, 0)
      Entity.EnableShooton(_ARG_0_.myHandle, 1)
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10) == false then
          _ARG_0_.step = 1
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.loopCnt = _ARG_0_.loopCnt - 1
          if 0 >= _ARG_0_.loopCnt then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            _ARG_0_.step = 2
          end
        end
      elseif _ARG_0_.step == 1 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.loopCnt = _ARG_0_.loopCnt - 1
          if 0 >= _ARG_0_.loopCnt then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            _ARG_0_.step = 2
          end
        end
      elseif _ARG_0_.step == 2 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE2_ + Script.Random() * _UPVALUE3_)
          _ARG_0_.step = 3
        end
      elseif _ARG_0_.step == 3 then
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE4_)
          _ARG_0_.step = 4
        end
      elseif _ARG_0_.step == 4 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Wander")
      end
    end
  },
  Wander = {
    OnBeginState = function(_ARG_0_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_ * (Script.Random() * _UPVALUE1_))
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE2_)
      _ARG_0_.step = _UPVALUE3_
      _ARG_0_.count = 0
      _ARG_0_.wanderAng = 90
      if Script.Random() < 0.5 then
        _ARG_0_.wanderAng = 270
      end
      Entity.GetRot(_ARG_0_.WorkVec, _ARG_0_.myHandle)
      _ARG_0_.WorkVec:sety(_ARG_0_.WorkVec:gety() + DegToRad(_ARG_0_.wanderAng))
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
        _ARG_0_.noPLTime = 0
        _ARG_0_.wanderAng = 0
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_ * (Script.Random() * _UPVALUE2_))
        _ARG_0_.noWallHitTime = 120
        _ARG_0_.step = _UPVALUE3_
      elseif _ARG_0_.step == _UPVALUE4_ then
      elseif _ARG_0_.step == _UPVALUE3_ then
        _ARG_0_.AttackDelayTime = _ARG_0_.AttackDelayTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        _ARG_0_.FeelingsDelayTime = _ARG_0_.FeelingsDelayTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if 0 > _ARG_0_.AttackDelayTime and Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) == true and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE5_ then
          _ARG_0_:GotoState("PanicAttack")
          Entity.SetTimer(_ARG_0_.myHandle, 60 * (Script.Random() * 60))
          return
        end
        if 0 > _ARG_0_.FeelingsDelayTime then
          if Script.Random() < _UPVALUE6_ and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _UPVALUE7_ then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE8_)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.step = _UPVALUE9_
            _ARG_0_.FeelingsDelayTime = _UPVALUE10_
            return
          end
          if CanDisappear(_ARG_0_.myHandle, _ARG_0_.targetHandle) == true then
            _ARG_0_:GotoState("Disappear")
            return
          end
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 3)
        if CanDisappear(_ARG_0_.myHandle, _ARG_0_.targetHandle) == true then
          _ARG_0_:GotoState("Disappear")
          return
        end
        _ARG_0_.WorkVec:set(0, 0, _UPVALUE11_)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
        _ARG_0_.noWallHitTime = _ARG_0_.noWallHitTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if 0 > _ARG_0_.noWallHitTime then
        end
        _ARG_0_.noPLTime = _ARG_0_.noPLTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if 0 > _ARG_0_.noPLTime then
          _ARG_0_.noPLTime = 0
          _ARG_0_.wanderAng = 0
        end
        if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 4 then
          if _ARG_0_:WhichRightandLeft() == 1 then
            _ARG_0_.wanderAng = -10
          else
            _ARG_0_.wanderAng = 10
          end
          Entity.GetRot(_ARG_0_.WorkVec, _ARG_0_.myHandle)
          _ARG_0_.WorkVec:sety(_ARG_0_.WorkVec:gety() + DegToRad(_ARG_0_.wanderAng))
          Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.WorkVec)
        else
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.IsWall(_ARG_0_.myHandle) == true or 1 > Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetPos) then
          _ARG_0_.count = _ARG_0_.count + 1
          if 4 < _ARG_0_.count then
            _ARG_0_:GotoState("Wander")
          else
            _ARG_0_.step = _UPVALUE0_
          end
        end
      elseif _ARG_0_.step == _UPVALUE9_ then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.step = _UPVALUE12_
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE13_)
        end
      elseif _ARG_0_.step == _UPVALUE12_ and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Wander")
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
      if Enemy.IsAllEnemyWaiting() == false then
        _ARG_0_:GotoState("UndergroundIdling")
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
      SetupDisappear(_ARG_0_.myHandle, 20)
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
function m19ex00.WhichRightandLeft(_ARG_0_)
  Entity.GetWorldPos(_ARG_0_.WorkVec1, _ARG_0_.targetHandle)
  Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.myHandle)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  FVECTOR3.Sub(_ARG_0_.WorkVec, _ARG_0_.WorkVec1, _ARG_0_.WorkVec)
  FVECTOR3.normalize(_ARG_0_.WorkVec)
  if RoundPI((Math.Atan2(_ARG_0_.WorkVec:getx(), _ARG_0_.WorkVec:getz()) - _ARG_0_.rot:gety()) * -1) < 0 then
    return 1
  else
    return 0
  end
end
function m19ex00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.targetHandle = NULL_HANDLE
  _ARG_0_.Type = 0
  _ARG_0_.AttackDelayTime = 0
  _ARG_0_.FeelingsDelayTime = 0
  _ARG_0_.hitAttackFlag = 0
  _ARG_0_.loopCnt = 0
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkTime = 0
  _ARG_0_.noWallHitTime = 0
  _ARG_0_.noPLTime = 0
  _ARG_0_.wanderAng = 0
  _ARG_0_.WorkVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.cameraPos = FVECTOR3.new(0, 0, 0)
  if M19EX_INIT_PARAM == false then
    _UPVALUE0_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "UploopNum")
    _UPVALUE1_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "Action1Dist")
    print("M19EX_DIST_ACTION1 = " .. _UPVALUE1_ .. "\n")
    _UPVALUE1_ = _UPVALUE1_ * _UPVALUE1_
    _UPVALUE2_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "Action2Dist")
    _UPVALUE2_ = _UPVALUE2_ * _UPVALUE2_
    _UPVALUE3_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "Action3Dist")
    _UPVALUE3_ = _UPVALUE3_ * _UPVALUE3_
    _UPVALUE4_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "Action4Dist")
    _UPVALUE4_ = _UPVALUE4_ * _UPVALUE4_
    _UPVALUE5_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "IdlingTime") * 60
    _UPVALUE6_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "IdlingATime") * 60
    _UPVALUE7_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "FeelingsT") * 60
    _UPVALUE8_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "FeelingsAT") * 60
    _UPVALUE9_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "MoveTime") * 60
    _UPVALUE10_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "MoveATime") * 60
    _UPVALUE11_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "RisPor")
    _UPVALUE12_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "FeelingsR")
    _UPVALUE13_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "FeelingsW")
    M19EX_INIT_PARAM = true
  end
  Entity.SetMovementCollRadius(_ARG_0_.myHandle, 0.7)
  Entity.SetLowerHalf(_ARG_0_.myHandle, 0.9)
  Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
  Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
  Entity.EnableLockon(_ARG_0_.myHandle, 0)
  Entity.EnableShooton(_ARG_0_.myHandle, 0)
  Entity.EnableGravity(_ARG_0_.myHandle, 1)
  Enemy.IsAllEnemyWaiting()
  Enemy.EnableNoBattleMode(_ARG_1_, 1)
  if Enemy.IsAllEnemyWaiting() == true then
    _ARG_0_:GotoState("Standby")
  else
    _ARG_0_:GotoState("Appear")
    Entity.EnableLockon(_ARG_0_.myHandle, 1)
  end
end
function m19ex00.CreateShot(_ARG_0_, _ARG_1_)
  Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.targetHandle, 2)
  Entity.GetWorldPos(_ARG_0_.WorkVec1, _ARG_1_)
  Entity.GetRot(_ARG_0_.rot, _ARG_1_)
  FVECTOR3.Sub(_ARG_0_.WorkVec, _ARG_0_.WorkVec, _ARG_0_.WorkVec1)
  FVECTOR3.normalize(_ARG_0_.WorkVec)
  _ARG_0_.WorkVec1:set(0, 0.5, 0)
  Entity.GetWorldPos2(_ARG_0_.WorkVec1, _ARG_1_, _ARG_0_.WorkVec1)
  Bullet.CreateEffectBullet(Bullet.CreateBullet("m19ex00b", _ARG_0_.WorkVec1, _ARG_0_.rot, _ARG_1_), "e_ex190", "E019_CUT_01_0")
  if Enemy.IsConfuse(_ARG_0_.myHandle) then
    Bullet.SetCollision(Bullet.CreateBullet("m19ex00b", _ARG_0_.WorkVec1, _ARG_0_.rot, _ARG_1_), COLL_KIND_ENEMY, COLL_SHAPE_CYLINDER, 1.5, 0.2, _ARG_1_, -1.5)
  else
    Bullet.SetCollision(Bullet.CreateBullet("m19ex00b", _ARG_0_.WorkVec1, _ARG_0_.rot, _ARG_1_), COLL_KIND_ENEMY, COLL_SHAPE_CYLINDER, 1.5, 0.2, _ARG_1_, -1.5)
  end
  SetBulletAttackParam(Bullet.CreateBullet("m19ex00b", _ARG_0_.WorkVec1, _ARG_0_.rot, _ARG_1_), _ARG_0_.myHandle, 0)
  Bullet.SetHitAttackEffectName(Bullet.CreateBullet("m19ex00b", _ARG_0_.WorkVec1, _ARG_0_.rot, _ARG_1_), "e_ex190", "E019_CUT_02_0")
  Bullet.SetHitBgEffectName(Bullet.CreateBullet("m19ex00b", _ARG_0_.WorkVec1, _ARG_0_.rot, _ARG_1_), "e_ex190", "E019_CUT_02_0")
  Entity.SetMovementCollRadius(Bullet.CreateBullet("m19ex00b", _ARG_0_.WorkVec1, _ARG_0_.rot, _ARG_1_), 0.1)
  Entity.CalcVelocity(Bullet.CreateBullet("m19ex00b", _ARG_0_.WorkVec1, _ARG_0_.rot, _ARG_1_), 0.25)
  Bullet.SetMaxMoveDist(Bullet.CreateBullet("m19ex00b", _ARG_0_.WorkVec1, _ARG_0_.rot, _ARG_1_), 225)
  EntityManager:GetEntity((Bullet.CreateBullet("m19ex00b", _ARG_0_.WorkVec1, _ARG_0_.rot, _ARG_1_))).targetHandle = _ARG_0_.targetHandle
end
function m19ex00.OnDamage(_ARG_0_, _ARG_1_)
  print("OnDamage\n")
  Enemy.EnableNoBattleMode(_ARG_0_.myHandle, 0)
  if _ARG_0_.Type == _UPVALUE0_ and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE1_ then
    print("OnDamage M19EX_DIST_APPEAR\n")
    _ARG_0_.Type = _UPVALUE2_
    _ARG_0_:GotoState("PoisonAttack")
    return 1
  end
end
function m19ex00.OnReturnDamage(_ARG_0_)
  _ARG_0_:GotoState("Idling")
end
function m19ex00.OnHitAttack(_ARG_0_)
  _ARG_0_.hitAttackFlag = 1
end
function m19ex00.GetDamageMotionNum(_ARG_0_, _ARG_1_)
  if (_ARG_0_:GetState() == "UndergroundIdling" or _ARG_0_:GetState() == "LeafCutter") and _ARG_1_ == DMG_MOT_FAINT then
    return 19
  end
  return -1
end
function m19ex00.Debug(_ARG_0_)
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
function m19ex00.OnUpdate(_ARG_0_)
  _ARG_0_:Update()
  _ARG_0_:Debug()
end
EntityFactory:Add("m19ex00", function(_ARG_0_)
  return (m19ex00:new())
end)
EntityFactory:Add("m19vs00", function(_ARG_0_)
  return (m19ex00:new())
end)
m19ex00b = {}
m19ex00b_mt = {__index = m19ex00b}
function m19ex00b.new(_ARG_0_)
  return setmetatable({}, m19ex00b_mt)
end
function m19ex00b.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.masterHandle = NULL_HANDLE
  _ARG_0_.targetHandle = NULL_HANDLE
  _ARG_0_.step = 0
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
end
function m19ex00b.OnHitAttack(_ARG_0_)
  Entity.ClearSpeed(_ARG_0_.myHandle)
  Effect.Fadeout(Bullet.GetEffectHandle(_ARG_0_.myHandle), 1)
  Bullet.EnableAttackCollision(_ARG_0_.myHandle, 0)
  _ARG_0_.step = 1
  return 1
end
function m19ex00b.OnReflect(_ARG_0_)
  print("Entity.GetName(handle) = " .. Entity.GetName((Player.IsNowTarget(_ARG_0_.targetHandle))) .. "\n")
  if Entity.GetName((Player.IsNowTarget(_ARG_0_.targetHandle))) == "m19ex00" or Entity.GetName((Player.IsNowTarget(_ARG_0_.targetHandle))) == "m19vs00" then
    _ARG_0_.step = 2
  end
end
function m19ex00b.OnUpdate(_ARG_0_)
  if _ARG_0_.step == 2 then
    Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
    _ARG_0_.rot:setx(0)
    Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
    Entity.CalcVelocity(_ARG_0_.myHandle, 0.25)
    _ARG_0_.step = 0
  end
end
EntityFactory:Add("m19ex00b", function(_ARG_0_)
  return (m19ex00b:new())
end)
