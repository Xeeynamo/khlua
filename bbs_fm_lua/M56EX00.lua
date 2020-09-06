M25_FAST_MOB = 0
m56ex00 = {}
m56ex00_base_mt = {__index = __StateMachine}
setmetatable(m56ex00, m56ex00_base_mt)
m56ex00_mt = {__index = m56ex00}
function m56ex00.new(_ARG_0_)
  return setmetatable(__StateMachine:new(), m56ex00_mt)
end
m56ex00.states = {
  Appear = {
    OnBeginState = function(_ARG_0_)
      SetupAppearBegin(_ARG_0_.myHandle, 1, _UPVALUE0_, 1)
    end,
    OnEndState = function(_ARG_0_)
      SetupAppearEnd(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_:GotoState("Idling")
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
      end
    end
  },
  Idling = {
    OnBeginState = function(_ARG_0_)
      Entity.SetTimer(_ARG_0_.myHandle, Script.Random() * _UPVALUE0_ + Script.Random() * _UPVALUE0_)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE1_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_:ChngeState()
    end
  },
  Move = {
    OnBeginState = function(_ARG_0_)
      Entity.SetTimer(_ARG_0_.myHandle, 20)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
      _ARG_0_.prizeHandle = Enemy.SearchPrize(_ARG_0_.myHandle, SEARCH_TYPE_HP_FEWEST)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.maxPrizeNumber = Enemy.GetPrizeNumber(0)
      _ARG_0_.huntPrizeNumber = Math.integer(_ARG_0_.maxPrizeNumber)
      if Entity.IsAlive(_ARG_0_.prizeHandle) then
      else
        _ARG_0_.prizeHandle = Enemy.SearchPrize(_ARG_0_.myHandle, SEARCH_TYPE_HP_FEWEST)
      end
      if Enemy.GetPrizeNumber(0) >= _UPVALUE0_ then
        _ARG_0_:GotoState("MovePrize")
        return
      end
      if Enemy.GetPrizeNumber(0) <= 0 then
        _ARG_0_:StopMove2()
        if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 25 then
          _ARG_0_:GotoState("NeedleSpin")
        elseif Mission.SendMissonMessageGetPrizeNum(MES_BALL_REMAINING_ENEMY) > Mission.SendMissonMessageGetPrizeNum(MES_BALL_REMAINING_PLAYER) then
          if Script.Random() < 1 then
            _ARG_0_:GotoState("HomingMove")
          else
            if Script.Random() < 0.5 then
              _ARG_0_:GotoState("Tentaclebeam")
            else
              _ARG_0_:GotoState("TentacleRotation")
            end
            return
          end
        elseif Script.Random() < 1 then
          _ARG_0_:GotoState("HomingMove")
        else
          if Script.Random() < 0.5 then
            _ARG_0_:GotoState("Tentaclebeam")
          else
            _ARG_0_:GotoState("TentacleRotation")
          end
          return
        end
      else
        Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.prizeHandle)
        if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _UPVALUE1_) < _UPVALUE2_ then
          if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _UPVALUE1_) and Script.Random() < 0.7 then
            if Script.Random() < 0.5 then
              _ARG_0_:GotoState("Tentaclebeam")
            else
              _ARG_0_:GotoState("TentacleRotation")
            end
            return
          end
        elseif Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _UPVALUE1_) then
          if Script.Random() < 0.6 then
            _ARG_0_:GotoState("Tentaclebeam")
          else
            _ARG_0_:GotoState("NeedleSpin")
          end
          return
        end
        _ARG_0_:GotoState("MovePrize")
      end
    end
  },
  Wander = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.step = _UPVALUE0_
      _ARG_0_.count = 0
      _ARG_0_.WanderCnt = Script.Random() * 2
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE1_)
      Entity.EnableGravity(_ARG_0_.myHandle, 1)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE2_ + Script.Random() * _UPVALUE2_)
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == _UPVALUE0_ then
        Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
        _ARG_0_.targetPos:setx(_ARG_0_.targetPos:getx() + (10 * Script.Random() + 20) * Math.Cos((RoundPI(Script.Random() * 2 * PI))))
        _ARG_0_.targetPos:setz(_ARG_0_.targetPos:getz() + (10 * Script.Random() + 20) * Math.Sin((RoundPI(Script.Random() * 2 * PI))))
        _ARG_0_.noWallHitTime = 20
        _ARG_0_.step = _UPVALUE1_
      elseif _ARG_0_.step == _UPVALUE2_ then
      elseif _ARG_0_.step == _UPVALUE1_ then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 5)
        _ARG_0_.velocity:set(0, 0, _UPVALUE3_)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
        _ARG_0_.noWallHitTime = _ARG_0_.noWallHitTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.noWallHitTime < 0 then
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
        if Entity.IsWall(_ARG_0_.myHandle) == true or Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetPos) < 9 then
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
  MovePrize = {
    OnBeginState = function(_ARG_0_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.maxPrizeNumber = Enemy.GetPrizeNumber(0)
      _ARG_0_.huntPrizeNumber = Math.integer(_ARG_0_.maxPrizeNumber)
      if Entity.IsAlive(_ARG_0_.prizeHandle) then
      else
        _ARG_0_:GotoState("Move")
        return
      end
      if Enemy.GetPrizeNumber(0) <= 0 then
        _ARG_0_:GotoState("Move")
        return
      else
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.prizeHandle, 4)
        _ARG_0_.Speed = _ARG_0_.Speed + 0.01 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.Speed > _UPVALUE0_ then
          _ARG_0_.Speed = _UPVALUE0_
        end
        _UPVALUE1_:set(0, 0, 1)
        _UPVALUE1_:scale(_ARG_0_.Speed)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE1_)
      end
    end
  },
  PriorityMovePrize = {
    OnBeginState = function(_ARG_0_)
      print("m56ex00:PriorityMovePrize\n")
      Entity.SetTimer(_ARG_0_.myHandle, 1200)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.maxPrizeNumber = Enemy.GetPrizeNumber(0)
      _ARG_0_.huntPrizeNumber = Math.integer(_ARG_0_.maxPrizeNumber)
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Move")
      end
      if Entity.IsAlive(_ARG_0_.prizeHandle) then
      else
        print("\150\218\149W\131Z\131b\131g\n")
        _ARG_0_.prizeHandle = Enemy.SearchPrize(_ARG_0_.myHandle, SEARCH_TYPE_HP_FEWEST)
      end
      if Enemy.GetPrizeNumber(0) <= 0 then
        _ARG_0_:GotoState("Move")
        return
      else
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.prizeHandle, 4)
        _ARG_0_.Speed = _ARG_0_.Speed + 0.01 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.Speed > _UPVALUE0_ then
          _ARG_0_.Speed = _UPVALUE0_
        end
        _UPVALUE1_:set(0, 0, 1)
        _UPVALUE1_:scale(_ARG_0_.Speed)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE1_)
      end
    end
  },
  HomingMove = {
    OnBeginState = function(_ARG_0_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_ + Script.Random() * _UPVALUE0_)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Enemy.GetPrizeNumber(0) >= _UPVALUE0_ then
        _ARG_0_:GotoState("MovePrize")
        return
      end
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 2)
      _ARG_0_.RLSpeed = HomingDegree(_ARG_0_.RLSpeed, 0, 1.1, Entity.GetFrameRate(_ARG_0_.myHandle))
      _ARG_0_.ABSpeed = HomingDegree(_ARG_0_.ABSpeed, _UPVALUE1_, 1.15, Entity.GetFrameRate(_ARG_0_.myHandle))
      FVECTOR3.set(_ARG_0_.WorkVec, _ARG_0_.RLSpeed, 0, _ARG_0_.ABSpeed)
      Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
      if Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 9 then
        _ARG_0_:GotoState("Move")
      end
    end
  },
  AhedMove = {
    OnBeginState = function(_ARG_0_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.step = 0
      _ARG_0_.away = 5
      _ARG_0_.WorkVec:set(0, 0, 0)
      Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
      _ARG_0_.targetPos:setx(_ARG_0_.targetPos:getx() + ((_ARG_0_.away * Script.Random() + _ARG_0_.away) * Math.Cos((RoundPI(Script.Random() * 5 * PI))) + _ARG_0_.WorkVec:getx()))
      _ARG_0_.targetPos:setz(_ARG_0_.targetPos:getz() + ((_ARG_0_.away * Script.Random() + _ARG_0_.away) * Math.Sin((RoundPI(Script.Random() * 5 * PI))) + _ARG_0_.WorkVec:getz()))
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Enemy.GetPrizeNumber(0) >= _UPVALUE0_ then
        _ARG_0_:GotoState("MovePrize")
        return
      end
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 1)
      _ARG_0_.RLSpeed = HomingDegree(_ARG_0_.RLSpeed, 1, 0.05, Entity.GetFrameRate(_ARG_0_.myHandle))
      _ARG_0_.ABSpeed = HomingDegree(_ARG_0_.ABSpeed, _UPVALUE1_, 1.05, Entity.GetFrameRate(_ARG_0_.myHandle))
      FVECTOR3.set(_ARG_0_.WorkVec, _ARG_0_.RLSpeed, 0, _ARG_0_.ABSpeed)
      Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
      if Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 9 then
        _ARG_0_:GotoState("Move")
      end
    end
  },
  BackMove = {
    OnBeginState = function(_ARG_0_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Enemy.GetPrizeNumber(0) >= _UPVALUE0_ then
        _ARG_0_:GotoState("MovePrize")
        return
      end
      _ARG_0_.RLSpeed = HomingDegree(_ARG_0_.RLSpeed, 0, 1.05, Entity.GetFrameRate(_ARG_0_.myHandle))
      _ARG_0_.ABSpeed = HomingDegree(_ARG_0_.ABSpeed, -_UPVALUE1_, 1.05, Entity.GetFrameRate(_ARG_0_.myHandle))
      FVECTOR3.set(_ARG_0_.WorkVec, _ARG_0_.RLSpeed, 0, _ARG_0_.ABSpeed)
      Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
      if Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 9 then
        _ARG_0_:GotoState("Move")
      end
    end
  },
  RightMove = {
    OnBeginState = function(_ARG_0_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Enemy.GetPrizeNumber(0) >= _UPVALUE0_ then
        _ARG_0_:GotoState("MovePrize")
        return
      end
      _ARG_0_.RLSpeed = HomingDegree(_ARG_0_.RLSpeed, -_UPVALUE1_, 1.05, Entity.GetFrameRate(_ARG_0_.myHandle))
      _ARG_0_.ABSpeed = HomingDegree(_ARG_0_.ABSpeed, 0, 1.05, Entity.GetFrameRate(_ARG_0_.myHandle))
      FVECTOR3.set(_ARG_0_.WorkVec, _ARG_0_.RLSpeed, 0, _ARG_0_.ABSpeed)
      Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
      if Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 9 then
        _ARG_0_:GotoState("Move")
      end
    end
  },
  LeftMove = {
    OnBeginState = function(_ARG_0_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Enemy.GetPrizeNumber(0) >= _UPVALUE0_ then
        _ARG_0_:GotoState("MovePrize")
        return
      end
      _ARG_0_.RLSpeed = HomingDegree(_ARG_0_.RLSpeed, _UPVALUE1_, 1.05, Entity.GetFrameRate(_ARG_0_.myHandle))
      _ARG_0_.ABSpeed = HomingDegree(_ARG_0_.ABSpeed, 0, 1.05, Entity.GetFrameRate(_ARG_0_.myHandle))
      FVECTOR3.set(_ARG_0_.WorkVec, _ARG_0_.RLSpeed, 0, _ARG_0_.ABSpeed)
      Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
      if Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 9 then
        _ARG_0_:GotoState("Move")
      end
    end
  },
  CounterNeedle = {
    OnBeginState = function(_ARG_0_)
      print("m56ex00:: CounterNeedle\n")
      _ARG_0_:SetMotion(_UPVALUE0_)
      _ARG_0_.damageNum = 0
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_.BicDmgCount = 0
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_:StopMove2()
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      end
    end
  },
  Tentaclebeam = {
    OnBeginState = function(_ARG_0_)
      print("m56ex00:: Tentaclebeam\n")
      _ARG_0_:SetMotion(_UPVALUE0_)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_.BicDmgCount = 0
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_:StopMove2()
      if _ARG_0_.step == 0 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 33 then
        _ARG_0_:CreateShot(_ARG_0_.myHandle, 14)
        _ARG_0_:CreateShot(_ARG_0_.myHandle, 16)
        _ARG_0_:CreateShot(_ARG_0_.myHandle, 18)
        _ARG_0_:CreateShot(_ARG_0_.myHandle, 20)
        _ARG_0_.step = 1
      else
      end
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  TentacleRotation = {
    OnBeginState = function(_ARG_0_)
      print("m56ex00:: TentacleRotation\n")
      _ARG_0_:SetMotion(_UPVALUE0_)
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_.BicDmgCount = 0
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_:StopMove2()
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  NeedleSpin = {
    OnBeginState = function(_ARG_0_)
      print("m56ex00:: NeedleSpin\n")
      _ARG_0_:SetMotion(_UPVALUE0_)
      Entity.SetTimer(_ARG_0_.myHandle, 120)
      _ARG_0_.ABSpeed = 0
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
      if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 40 then
        _ARG_0_:AheadMove(0.15, 0.1)
      end
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("NeedleSpinEnd")
      end
    end
  },
  NeedleSpinEnd = {
    OnBeginState = function(_ARG_0_)
      print("m56ex00:: NeedleSpinEnd\n")
      _ARG_0_:SetMotion(_UPVALUE0_)
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_.BicDmgCount = 0
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_:StopMove(0.15, 0.01)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
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
      if Enemy.IsAllEnemyWaiting() == false then
        _ARG_0_:GotoState("Idling")
        Entity.EnableLockon(_ARG_0_.myHandle, 1)
      end
    end
  },
  Dead = {
    OnBeginState = function(_ARG_0_)
      print("m56ex Dead\129I\129I\129I\n")
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
    end
  },
  DeadEnd = {
    OnBeginState = function(_ARG_0_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
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
function m56ex00.SetMotionWithSameCheck(_ARG_0_, _ARG_1_)
  Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_1_)
end
function m56ex00.SetMotion(_ARG_0_, _ARG_1_)
  Entity.SetMotion(_ARG_0_.myHandle, _ARG_1_)
end
function m56ex00.ChngeState(_ARG_0_)
  if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE0_ then
    if Script.Random() < _UPVALUE1_ then
      _ARG_0_:ContinuanceMove()
    elseif Script.Random() < _UPVALUE2_ then
      _ARG_0_:GotoState("TentacleRotation")
    else
      _ARG_0_:GotoState("Tentaclebeam")
    end
  elseif Script.Random() < _UPVALUE1_ then
    _ARG_0_:ContinuanceMove()
  end
end
function m56ex00.ContinuanceMove(_ARG_0_)
  if Script.Random() < 0.25 then
    _ARG_0_:GotoState("AhedMove")
  elseif Script.Random() < 0.5 then
    _ARG_0_:GotoState("RightMove")
  elseif Script.Random() < 0.75 then
    _ARG_0_:GotoState("RightMove")
  else
    _ARG_0_:GotoState("LeftMove")
  end
end
function m56ex00.CreateShot(_ARG_0_, _ARG_1_, _ARG_2_)
  Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.targetHandle, 2)
  Entity.GetWorldPos(_ARG_0_.WorkVec1, _ARG_1_, _ARG_2_)
  Entity.GetRot(_ARG_0_.rot, _ARG_1_)
  FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.WorkVec, _ARG_0_.WorkVec1)
  FVECTOR3.normalize(_ARG_0_.workVec)
  _ARG_0_.WorkVec:set(0.2, 0, 0)
  Entity.GetWorldPos2(_ARG_0_.WorkVec, _ARG_1_, _ARG_0_.WorkVec, _ARG_2_)
  Entity.GetWorldPos(_ARG_0_.WorkVec1, _ARG_1_, _ARG_2_)
  Entity.GetRot(_ARG_0_.rot, _ARG_1_)
  FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.WorkVec, _ARG_0_.WorkVec1)
  FVECTOR3.normalize(_ARG_0_.workVec)
  _ARG_0_.rot:sety((Math.Atan2(_ARG_0_.workVec:getx(), _ARG_0_.workVec:getz())))
  _ARG_0_.WorkVec:set(1, 0, 0)
  Entity.GetWorldPos2(_ARG_0_.WorkVec1, _ARG_1_, _ARG_0_.WorkVec, _ARG_2_)
  Bullet.CreateEffectBullet(Bullet.CreateBullet("b25ex00b", _ARG_0_.WorkVec1, _ARG_0_.rot), "e_ex250", "E025_BEM_00_0")
  if Enemy.IsConfuse(_ARG_0_.myHandle) then
    Bullet.SetCollision(Bullet.CreateBullet("b25ex00b", _ARG_0_.WorkVec1, _ARG_0_.rot), COLL_KIND_NO_CHECK, COLL_SHAPE_SPHERE, 0.2, 0, _ARG_1_)
  else
    Bullet.SetCollision(Bullet.CreateBullet("b25ex00b", _ARG_0_.WorkVec1, _ARG_0_.rot), COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, 0.2, 0, _ARG_1_)
  end
  SetBulletAttackParam(Bullet.CreateBullet("b25ex00b", _ARG_0_.WorkVec1, _ARG_0_.rot), _ARG_0_.myHandle, 0)
  Bullet.SetHitAttackEffectName(Bullet.CreateBullet("b25ex00b", _ARG_0_.WorkVec1, _ARG_0_.rot), "e_ex250", "E025_HIT_00_0")
  Bullet.SetHitBgEffectName(Bullet.CreateBullet("b25ex00b", _ARG_0_.WorkVec1, _ARG_0_.rot), "e_ex250", "E025_HIT_00_0")
  Bullet.EnableReflect(Bullet.CreateBullet("b25ex00b", _ARG_0_.WorkVec1, _ARG_0_.rot), Enemy.GetAttackReflect(_ARG_0_.myHandle, 0))
  Entity.CalcVelocity(Bullet.CreateBullet("b25ex00b", _ARG_0_.WorkVec1, _ARG_0_.rot), 0.25)
end
function m56ex00.AheadMove(_ARG_0_, _ARG_1_, _ARG_2_)
  _ARG_0_.Speed = _ARG_0_.Speed + _ARG_1_ * _ARG_2_ * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_1_ < _ARG_0_.Speed then
    _ARG_0_.Speed = _ARG_1_
  end
  FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Speed)
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function m56ex00.StopMove(_ARG_0_, _ARG_1_, _ARG_2_)
  _ARG_0_.Speed = _ARG_0_.Speed - _ARG_1_ * _ARG_2_ * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_0_.Speed < 0 then
    _ARG_0_.Speed = 0
  end
  FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Speed)
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function m56ex00.StopMove2(_ARG_0_, _ARG_1_, _ARG_2_)
  _UPVALUE0_:set(0, 0, 1)
  Math.RotateVectorXYZ(_UPVALUE0_, _UPVALUE1_)
  _ARG_0_.Speed = _ARG_0_.Speed - 0.01 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if 0 > _ARG_0_.Speed then
    _ARG_0_.Speed = 0
  end
  _UPVALUE0_:scale(_ARG_0_.Speed)
  Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE0_)
end
function m56ex00.SetingState(_ARG_0_)
end
function m56ex00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.stack = Stack:Create()
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.targetHandle = NULL_HANDLE
  _ARG_0_.DivFlag75 = 0
  _ARG_0_.DivFlag50 = 0
  _ARG_0_.DivFlag25 = 0
  _ARG_0_.ABSpeed = 0
  _ARG_0_.RLSpeed = 0
  _ARG_0_.Speed = 0
  _ARG_0_.damageNum = 0
  _ARG_0_.counterNum = 0
  _ARG_0_.saveDamagePoint = 0
  _ARG_0_.piorityGetTime = 0
  _ARG_0_.exec = 0
  _ARG_0_.c = 0
  _ARG_0_.theta = 0
  _ARG_0_.noWallHitTime = 0
  _ARG_0_.WanderCnt = 0
  _ARG_0_.count = 0
  _ARG_0_.exec2 = 0
  _ARG_0_.c2 = 0
  _ARG_0_.theta2 = 0
  _ARG_0_.shootLockDmgCount = 0
  _ARG_0_.BicDmgCount = 0
  _ARG_0_.targetHandle = NULL_HANDLE
  _ARG_0_.prizeHandle = NULL_HANDLE
  _ARG_0_.huntPrizeNumber = 0
  _ARG_0_.maxPrizeNumber = 0
  _ARG_0_.dropSpeed = 0.2
  Player.SetBattleFlagTargetHpOff(1)
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkTime = 0
  _ARG_0_.NowScale = FVECTOR3.new(1, 1, 1)
  _ARG_0_.WorkVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
  _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.cameraPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
  Enemy.SetSeFileID(_ARG_1_, 298)
  if _UPVALUE0_ == false then
    _UPVALUE1_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "Speed")
    print("M56EX_SPEED = " .. _UPVALUE1_ .. "\n")
    _UPVALUE2_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "PSpeed")
    _ARG_0_.dropSpeed = Enemy.GetExtraParam(_ARG_0_.myHandle, "DropPow")
    _UPVALUE3_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "SDropNum")
    _UPVALUE4_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "BDropNum")
    _UPVALUE5_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "PSDropNum")
    _UPVALUE6_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "PBDropNum")
    _UPVALUE7_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "PDropNum")
    _UPVALUE8_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "Dist_n")
    _UPVALUE8_ = _UPVALUE8_ * _UPVALUE8_
    _UPVALUE9_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "PLDist_n")
    _UPVALUE9_ = _UPVALUE9_ * _UPVALUE9_
    _UPVALUE10_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "MoveTn1") * 60
    _UPVALUE11_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "MoveTime") * 60
    _UPVALUE11_ = 0
    _UPVALUE12_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "PrioPGTim") * 60
    _UPVALUE13_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "PrioPGSpe")
    _UPVALUE0_ = true
  end
  Enemy.EnableGetPrize(_ARG_0_.myHandle, 1)
  Entity.SetMovementCollRadius(_ARG_0_.myHandle, 1.7)
  Entity.SetLowerHalf(_ARG_0_.myHandle, 2)
  Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
  Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
  Entity.EnableLockon(_ARG_0_.myHandle, 0)
  Entity.EnableGravity(_ARG_0_.myHandle, 1)
  Enemy.IsAllEnemyWaiting()
  if Enemy.IsAllEnemyWaiting() == true then
    _ARG_0_:GotoState("Standby")
  else
    _ARG_0_:GotoState("Appear")
    Entity.EnableLockon(_ARG_0_.myHandle, 1)
  end
end
function m56ex00.OnDamageBefore(_ARG_0_, _ARG_1_, _ARG_2_)
  print("OnDamageBefore\n")
  _ARG_0_.exec = true
  _ARG_0_.c = 0.12
  _ARG_0_.theta = 0
  _ARG_0_.exec2 = true
  _ARG_0_.c2 = 0.1
  _ARG_0_.theta2 = 0
  _ARG_0_.prizenum = 0
  if _ARG_2_ == COMMAND_CATEGORY_SHOOTLOCK then
    _ARG_0_.shootLockDmgCount = _ARG_0_.shootLockDmgCount + 1
    if _ARG_0_.shootLockDmgCount > 1 then
      return 1
    end
  end
  if Enemy.GetPrizeNumber(0) > _UPVALUE0_ then
  end
  print("nowprize = " .. Mission.SendMissonMessageGetPrizeNum(MES_BALL_REMAINING_ENEMY) .. "\n")
  if 0 >= Mission.SendMissonMessageGetPrizeNum(MES_BALL_REMAINING_ENEMY) then
    return 1
  end
  if _ARG_1_ == ATK_KIND_DMG_SMALL then
    for _FORV_9_ = 0, _UPVALUE1_ - 1 do
      if 0 >= Mission.SendMissonMessageGetPrizeNum(MES_BALL_REMAINING_ENEMY) then
        print("\147G\130\169\130\231\131v\131\137\131C\131Y\130\240" .. _ARG_0_.prizenum .. "\143o\130\181\130\189\n")
        return 1
      end
      if Script.Random() < 0.125 then
      elseif Script.Random() < 0.25 then
      elseif Script.Random() < 0.375 then
      elseif Script.Random() < 0.5 then
      elseif Script.Random() < 0.625 then
      elseif Script.Random() < 0.75 then
      elseif Script.Random() < 0.875 then
      else
      end
      _UPVALUE2_:set(0, 0, Script.Random() * 0.6)
      _UPVALUE3_:set(0, RadToDeg(Script.Random() * 360), 0)
      Math.RotateVectorXYZ(_UPVALUE2_, _UPVALUE3_)
      _ARG_0_.prizenum = _ARG_0_.prizenum + 1
      Mission.SendMissonMessage(MES_BALL_POINT_ENEMY, -1)
      _UPVALUE4_ = _UPVALUE4_ - 1
      if _UPVALUE4_ < 0 then
        _UPVALUE4_ = 0
      end
    end
  elseif _ARG_1_ == ATK_KIND_DMG_BLOW or _ARG_1_ == ATK_KIND_DMG_TOSS or _ARG_1_ == ATK_KIND_DMG_BEAT or _ARG_1_ == ATK_KIND_DMG_FLICK then
    for _FORV_9_ = 0, _UPVALUE5_ - 1 do
      if 0 >= Mission.SendMissonMessageGetPrizeNum(MES_BALL_REMAINING_ENEMY) then
        print("\147G\130\169\130\231\131v\131\137\131C\131Y\130\240" .. _ARG_0_.prizenum .. "\143o\130\181\130\189\n")
        return 1
      end
      if Script.Random() < 0.125 then
      elseif Script.Random() < 0.25 then
      elseif Script.Random() < 0.375 then
      elseif Script.Random() < 0.5 then
      elseif Script.Random() < 0.625 then
      elseif Script.Random() < 0.75 then
      elseif Script.Random() < 0.875 then
      else
      end
      _UPVALUE2_:set(0, 0, Script.Random() * 0.6)
      _UPVALUE3_:set(0, RadToDeg(Script.Random() * 360), 0)
      Math.RotateVectorXYZ(_UPVALUE2_, _UPVALUE3_)
      _ARG_0_.prizenum = _ARG_0_.prizenum + 1
      Mission.SendMissonMessage(MES_BALL_POINT_ENEMY, -1)
      _UPVALUE4_ = _UPVALUE4_ - 1
      if _UPVALUE4_ < 0 then
        _UPVALUE4_ = 0
      end
    end
  end
  print("\147G\130\169\130\231\131v\131\137\131C\131Y\130\240" .. _ARG_0_.prizenum .. "\143o\130\181\130\189\n")
  _ARG_0_.saveDamagePoint = _ARG_0_.saveDamagePoint + 1
  if _ARG_0_.saveDamagePoint > 5 then
    _ARG_0_.saveDamagePoint = 0
    _ARG_0_.stack:push("Idling")
    if Script.Random() < 0.5 then
      _ARG_0_.stack:push("Wander")
    end
    _ARG_0_.stack:push("CounterNeedle")
    _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
    return 1
  end
  if Script.Random() < 0.5 then
    _ARG_0_:GotoState("Wander")
    return 1
  end
  return 1
end
function m56ex00.NotifyGetPrize(_ARG_0_, _ARG_1_)
  Mission.SendMissonMessage(MES_BALL_POINT_ENEMY, 1)
  _UPVALUE0_ = _UPVALUE0_ + 1
end
function m56ex00.RestHpRate(_ARG_0_)
  return Enemy.GetHp(_ARG_0_.myHandle) / Enemy.GetHpMax(_ARG_0_.myHandle)
end
function m56ex00.OnDamage(_ARG_0_, _ARG_1_)
  print("OnDamage\n")
end
function m56ex00.OnDead(_ARG_0_)
  _ARG_0_:GotoState("Dead")
end
function m56ex00.OnNoReaction(_ARG_0_, _ARG_1_)
  if Enemy.IsStop(_ARG_0_.myHandle) then
    return
  end
  print("OnNoReaction\n")
  _ARG_0_.exec = true
  _ARG_0_.c = 0.15
  _ARG_0_.theta = 0
  _ARG_0_.exec2 = true
  _ARG_0_.c2 = 0.15
  _ARG_0_.theta2 = 0
end
function m56ex00.OnReturnDamage(_ARG_0_)
  _ARG_0_:GotoState("Idling")
end
function m56ex00.OnHitAttack(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  print("OnHitAttack\n")
  _ARG_0_.prizenum = 0
  print("nowprize = " .. Mission.SendMissonMessageGetPrizeNum(MES_BALL_REMAINING_PLAYER) .. "\n")
  if 0 >= Mission.SendMissonMessageGetPrizeNum(MES_BALL_REMAINING_PLAYER) then
    return 1
  end
  if Enemy.GetPrizeNumber(0) > _UPVALUE0_ then
    return 1
  end
  if _ARG_3_ == ATK_KIND_DMG_SMALL then
    _ARG_0_.BicDmgCount = _ARG_0_.BicDmgCount + 1
    if 1 < _ARG_0_.BicDmgCount then
      return 1
    end
    for _FORV_9_ = 0, _UPVALUE1_ - 1 do
      if 0 >= Mission.SendMissonMessageGetPrizeNum(MES_BALL_REMAINING_PLAYER) then
        print("\131v\131\140\131C\131\132\129[\130\169\130\231\131v\131\137\131C\131Y\130\240" .. _ARG_0_.prizenum .. "\143o\130\181\130\189\n")
        return 1
      end
      if Script.Random() < 0.125 then
      elseif Script.Random() < 0.25 then
      elseif Script.Random() < 0.375 then
      elseif Script.Random() < 0.5 then
      elseif Script.Random() < 0.625 then
      elseif Script.Random() < 0.75 then
      elseif Script.Random() < 0.875 then
      else
      end
      _UPVALUE2_:set(0, 0, Script.Random() * 0.6)
      _UPVALUE3_:set(0, RadToDeg(Script.Random() * 360), 0)
      Math.RotateVectorXYZ(_UPVALUE2_, _UPVALUE3_)
      _ARG_0_.prizenum = _ARG_0_.prizenum + 1
      Mission.SendMissonMessage(MES_BALL_POINT_PLAYER, -1)
      _UPVALUE4_ = _UPVALUE4_ - 1
      if _UPVALUE4_ < 0 then
        _UPVALUE4_ = 0
      end
    end
  elseif _ARG_3_ == ATK_KIND_DMG_BLOW or _ARG_3_ == ATK_KIND_DMG_TOSS or _ARG_3_ == ATK_KIND_DMG_BEAT or _ARG_3_ == ATK_KIND_DMG_FLICK then
    _ARG_0_.BicDmgCount = _ARG_0_.BicDmgCount + 1
    if 1 < _ARG_0_.BicDmgCount then
      return 1
    end
    for _FORV_9_ = 0, _UPVALUE5_ - 1 do
      if 0 >= Mission.SendMissonMessageGetPrizeNum(MES_BALL_REMAINING_PLAYER) then
        print("\131v\131\140\131C\131\132\129[\130\169\130\231\131v\131\137\131C\131Y\130\240" .. _ARG_0_.prizenum .. "\143o\130\181\130\189\n")
        return 1
      end
      if Script.Random() < 0.125 then
      elseif Script.Random() < 0.25 then
      elseif Script.Random() < 0.375 then
      elseif Script.Random() < 0.5 then
      elseif Script.Random() < 0.625 then
      elseif Script.Random() < 0.75 then
      elseif Script.Random() < 0.875 then
      else
      end
      _UPVALUE2_:set(0, 0, Script.Random() * 0.6)
      _UPVALUE3_:set(0, RadToDeg(Script.Random() * 360), 0)
      Math.RotateVectorXYZ(_UPVALUE2_, _UPVALUE3_)
      _ARG_0_.prizenum = _ARG_0_.prizenum + 1
      Mission.SendMissonMessage(MES_BALL_POINT_PLAYER, -1)
      _UPVALUE4_ = _UPVALUE4_ - 1
      if _UPVALUE4_ < 0 then
        _UPVALUE4_ = 0
      end
    end
  end
  print("\131v\131\140\131C\131\132\129[\130\169\130\231\131v\131\137\131C\131Y\130\240" .. _ARG_0_.prizenum .. "\143o\130\181\130\189\n")
end
function m56ex00.OnUpdatePositionAfter(_ARG_0_)
  if _ARG_0_.exec then
    _ARG_0_.theta = RoundPI(_ARG_0_.theta + Entity.GetFrameRate(_ARG_0_.myHandle) * DegToRad(32))
    _ARG_0_.c = _ARG_0_.c - Entity.GetFrameRate(_ARG_0_.myHandle) * 0.0025
    if _ARG_0_.c < 0 then
      _ARG_0_.exec = false
    end
    Entity.GetLocalBoneTrans(_ARG_0_.workVec, _ARG_0_.myHandle, 3)
    _ARG_0_.workVec:set(_ARG_0_.workVec:getx() + Math.Cos(_ARG_0_.theta) * _ARG_0_.c, _ARG_0_.workVec:gety() + Math.Cos(_ARG_0_.theta) * _ARG_0_.c, _ARG_0_.workVec:getz() + Math.Sin(_ARG_0_.theta) * _ARG_0_.c)
    Entity.SetLocalBoneTrans(_ARG_0_.myHandle, _ARG_0_.workVec, 3)
    Entity.GetScale(_ARG_0_.workVec, _ARG_0_.myHandle)
    _ARG_0_.workVec:set(1 + Math.Cos(_ARG_0_.theta) * _ARG_0_.c, 1 + Math.Cos(_ARG_0_.theta) * _ARG_0_.c, 1 + Math.Sin(_ARG_0_.theta) * _ARG_0_.c)
    Entity.ScalingBone(_ARG_0_.myHandle, 3, _ARG_0_.workVec)
  end
  if _ARG_0_.exec2 then
    _ARG_0_.theta2 = RoundPI(_ARG_0_.theta2 + Entity.GetFrameRate(_ARG_0_.myHandle) * DegToRad(32))
    _ARG_0_.c2 = _ARG_0_.c2 - Entity.GetFrameRate(_ARG_0_.myHandle) * 0.0015
    if 0 > _ARG_0_.c2 then
      _ARG_0_.exec2 = false
    end
    Entity.GetLocalBoneTrans(_ARG_0_.workVec, _ARG_0_.myHandle, 2)
    _ARG_0_.workVec:set(_ARG_0_.workVec:getx() + Math.Cos(_ARG_0_.theta2) * _ARG_0_.c2, _ARG_0_.workVec:gety() + Math.Cos(_ARG_0_.theta2) * _ARG_0_.c2, _ARG_0_.workVec:getz() + Math.Sin(_ARG_0_.theta2) * _ARG_0_.c2)
    Entity.SetLocalBoneTrans(_ARG_0_.myHandle, _ARG_0_.workVec, 2)
    Entity.GetScale(_ARG_0_.workVec, _ARG_0_.myHandle)
    _ARG_0_.workVec:set(1 + Math.Cos(_ARG_0_.theta2) * _ARG_0_.c2, 1 + Math.Cos(_ARG_0_.theta2) * _ARG_0_.c2, 1 + Math.Sin(_ARG_0_.theta2) * _ARG_0_.c2)
    Entity.ScalingBone(_ARG_0_.myHandle, 2, _ARG_0_.workVec)
  end
end
function m56ex00.Debug(_ARG_0_)
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
function m56ex00.OnUpdate(_ARG_0_)
  _ARG_0_:Update()
  _ARG_0_:Debug()
  if Player.IsMuteki(_ARG_0_.targetHandle) == false then
    _ARG_0_.shootLockDmgCount = 0
  end
  if _ARG_0_:GetState() ~= "PriorityMovePrize" and 0 < Enemy.GetPrizeNumber(0) then
    _ARG_0_.piorityGetTime = _ARG_0_.piorityGetTime + Entity.GetFrameRate(_ARG_0_.myHandle)
    if _ARG_0_.piorityGetTime > _UPVALUE0_ then
      print("m56ex00:\151D\144\230\147I\130\201\131v\131\137\131C\131Y\130\240\130\198\130\233\130\230\n")
      _ARG_0_:GotoState("PriorityMovePrize")
      _ARG_0_.piorityGetTime = 0
    end
  end
end
EntityFactory:Add("m56ex00", function(_ARG_0_)
  return (m56ex00:new())
end)
EntityFactory:Add("m25vs00", function(_ARG_0_)
  return (m56ex00:new())
end)
b25ex00b = {}
b25ex00b_mt = {__index = b25ex00b}
function b25ex00b.new(_ARG_0_)
  return setmetatable({}, b25ex00b_mt)
end
function b25ex00b.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.masterHandle = NULL_HANDLE
  _ARG_0_.step = 0
  Entity.SetTimer(_ARG_0_.myHandle, 180)
end
function b25ex00b.OnHitAttack(_ARG_0_)
  Entity.ClearSpeed(_ARG_0_.myHandle)
  Effect.LoopEnd(Bullet.GetEffectHandle(_ARG_0_.myHandle))
  return 1
end
function b25ex00b.OnHitBg(_ARG_0_)
  if _ARG_0_.step == 0 then
    if Entity.IsGround(_ARG_0_.myHandle) then
      _ARG_0_.step = 1
    end
    _ARG_0_.step = 1
  end
  Effect.LoopEnd(Bullet.GetEffectHandle(_ARG_0_.myHandle))
end
function b25ex00b.OnUpdate(_ARG_0_)
  if _ARG_0_.step == 0 then
    if Entity.IsTimeOver(_ARG_0_.myHandle) then
      Effect.LoopEnd(Bullet.GetEffectHandle(_ARG_0_.myHandle))
    end
  elseif _ARG_0_.step == 1 then
  end
end
EntityFactory:Add("b25ex00b", function(_ARG_0_)
  return (b25ex00b:new())
end)
