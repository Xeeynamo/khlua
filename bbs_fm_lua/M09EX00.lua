m09ex00 = {}
m09ex00_base_mt = {__index = __StateMachine}
setmetatable(m09ex00, m09ex00_base_mt)
m09ex00_mt = {__index = m09ex00}
function m09ex00.new(_ARG_0_)
  return setmetatable(__StateMachine:new(), m09ex00_mt)
end
m09ex00.states = {
  Appear = {
    OnBeginState = function(_ARG_0_)
      print("m09ex: appear1\n")
      SetupAppearBegin(_ARG_0_.myHandle, 1, _UPVALUE0_, 1)
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
  Waiting = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      print("m09ex: Waiting\n")
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
      print("m09ex: Idling\n")
      _ARG_0_.step = 1
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_:GotoState("Search")
    end
  },
  Search = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_, 0, 0)
      _ARG_0_.step = 0
      _ARG_0_.MoveType = 0
      if Script.Random() < 0.5 then
        _ARG_0_.MoveType = 0
        _ARG_0_.workTime = _UPVALUE1_
        _ARG_0_.AngY = 0
        _ARG_0_.step = 0
        _ARG_0_.Height = Script.Random() * _UPVALUE2_ + _UPVALUE3_ - Script.Random() * 3
      else
        _ARG_0_.MoveType = 2
        _ARG_0_.step = 1
        _ARG_0_.Height = Script.Random() * _UPVALUE2_ + _UPVALUE3_ - Script.Random() * 3
      end
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE4_ + Script.Random() * 20)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      _ARG_0_.workTime2 = _UPVALUE5_
      _ARG_0_.workTime3 = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.HasNetGameHandle(_ARG_0_.myHandle) and Enemy.IsNetworkMaster(_ARG_0_.myHandle) == false then
        return
      end
      if _ARG_0_.workTime3 < 0 then
        _ARG_0_.prizeHandle = Enemy.SearchPrize(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        if _ARG_0_.prizeHandle ~= 0 and not (Enemy.GetPrizeNumber() <= 1) then
          if Script.Random() < _UPVALUE0_ then
            _ARG_0_:GotoState("Prize_hunt")
          else
            _ARG_0_.workTime3 = _UPVALUE1_
          end
        end
      end
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE2_ then
          if Entity.CanUserTarget(_ARG_0_.targetHandle) == true and Script.Random() < _UPVALUE3_ then
            _ARG_0_:GotoState("Beak_diving")
            return
          else
          end
        elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE4_ then
          if Entity.CanUserTarget(_ARG_0_.targetHandle) == true and Script.Random() < _UPVALUE3_ then
            _ARG_0_:GotoState("Glide_attack")
            return
          else
          end
        elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > ENEMY_COMMON_DISAPPEAR_DIST or Entity.CalcStartPosDistanceSq(_ARG_0_.myHandle) > ENEMY_COMMON_DISAPPEAR_DIST then
          _ARG_0_:GotoState("Disappear")
          return
        end
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _UPVALUE5_ then
          _ARG_0_.MoveType = 2
          _ARG_0_.step = 1
        elseif Script.Random() < 0.5 then
          if Script.Random() < 0.5 then
            _ARG_0_.MoveType = 0
          else
            _ARG_0_.MoveType = 1
          end
          _ARG_0_.workTime = _UPVALUE6_
          _ARG_0_.AngY = 0
          _ARG_0_.step = 0
        else
          _ARG_0_.MoveType = 2
          _ARG_0_.step = 1
        end
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE7_)
      end
      if 0 > _ARG_0_.workTime2 then
        _ARG_0_.Height = Script.Random() * _UPVALUE8_ + _UPVALUE9_ - Script.Random() * 3
        _ARG_0_.workTime2 = _UPVALUE10_
        if Script.Random() < _UPVALUE11_ then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE12_, 0, 0)
        else
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE13_, 0, 0)
        end
      end
      if _ARG_0_.MoveType == 0 or _ARG_0_.MoveType == 1 then
        Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
        _ARG_0_.WorkVec:set(0, _ARG_0_.Height, 0)
        Entity.GetWorldPos2(_ARG_0_.targetPos, _ARG_0_.targetHandle, _ARG_0_.WorkVec)
        if _ARG_0_.myPos:gety() < _ARG_0_.targetPos:gety() + 1 and _ARG_0_.myPos:gety() > _ARG_0_.targetPos:gety() - 1 then
          _ARG_0_:TurnX(0, _UPVALUE14_, 180)
        elseif _ARG_0_.myPos:gety() < _ARG_0_.targetPos:gety() then
          _ARG_0_:TurnX(45, -_UPVALUE14_, 45)
        elseif _ARG_0_.myPos:gety() > _ARG_0_.targetPos:gety() then
          _ARG_0_:TurnX(45, _UPVALUE14_, 45)
        end
        if _ARG_0_.MoveType == 0 then
          _ARG_0_:TurnY(DegToRad(_ARG_0_.AngY))
          _ARG_0_.AngY = _ARG_0_.AngY + _UPVALUE15_ * 0.1
          if _ARG_0_.AngY > _UPVALUE15_ then
            _ARG_0_.AngY = _UPVALUE15_
          end
        end
        if _ARG_0_.MoveType == 1 then
          _ARG_0_:TurnY(DegToRad(_ARG_0_.AngY))
          _ARG_0_.AngY = _ARG_0_.AngY - _UPVALUE15_ * 0.1
          if _ARG_0_.AngY < -_UPVALUE15_ then
            _ARG_0_.AngY = -_UPVALUE15_
          end
        end
        _ARG_0_:Move(_UPVALUE16_)
        if 0 > _ARG_0_.workTime then
          _ARG_0_.MoveType = _ARG_0_.MoveType + 1
          if _ARG_0_.MoveType >= 2 then
            _ARG_0_.MoveType = 0
          end
          _ARG_0_.workTime = _UPVALUE6_
        end
      else
        _ARG_0_.WorkVec:set(0, _ARG_0_.Height, 0)
        Entity.GetWorldPos2(_ARG_0_.targetPos, _ARG_0_.targetHandle, _ARG_0_.WorkVec)
        _ARG_0_:TargetHomingMove(_UPVALUE16_, _UPVALUE14_)
      end
      _ARG_0_.workTime = _ARG_0_.workTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      _ARG_0_.workTime2 = _ARG_0_.workTime2 - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      _ARG_0_.workTime3 = _ARG_0_.workTime3 - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
    end
  },
  Move = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.step = 1
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
    end
  },
  Faction_Rise = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.step = 0
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 0, -2)
      if Script.Random() < _UPVALUE1_ then
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 0, -2)
      else
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_, 0, -2)
      end
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE3_)
      _ARG_0_.Height = 6
      Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        _ARG_0_.WorkVec:set(0, _ARG_0_.Height, 0)
        Entity.GetWorldPos2(_ARG_0_.targetPos, _ARG_0_.targetHandle, _ARG_0_.WorkVec)
        _ARG_0_:TargetHomingMove(_UPVALUE0_, _UPVALUE1_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Search")
        end
      elseif _ARG_0_.step == 1 then
      end
    end
  },
  Beak_diving = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.step = 0
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 2, 0)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      _ARG_0_.BeakDivingFlag = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      _ARG_0_.BeakDivingFlag = 0
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if _ARG_0_:TurnX(0, 3, 180) == false then
          Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 3)
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_.BeakDivingFlag = 1
            _ARG_0_.step = 11
            Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
          end
        end
      elseif _ARG_0_.step == 11 then
        _ARG_0_.BeakDivingFlag = 2
        _ARG_0_.step = 1
      elseif _ARG_0_.step == 1 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 8 then
          Entity.GetWorldPos(_ARG_0_.playerPos, _ARG_0_.targetHandle)
          if Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.playerPos, 30) == false and Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 14 then
            _ARG_0_.step = 2
            Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
            FVECTOR3.Sub(_ARG_0_.velocity, _ARG_0_.playerPos, _ARG_0_.myPos)
            _ARG_0_.velocity:normalize()
            _ARG_0_.velocity:scale(_UPVALUE1_ * 2)
            Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
          end
        end
      elseif _ARG_0_.step == 2 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 21 then
          Entity.ClearSpeed(_ARG_0_.myHandle)
          _ARG_0_.BeakDivingFlag = 0
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Faction_Rise")
          _ARG_0_.BeakDivingFlag = 0
        end
      end
    end
  },
  Glide_attack = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.step = 0
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 2, 1)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.overAngle = 90
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if _ARG_0_:TurnX(0, 3, 180) == false then
          Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 3)
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_.step = 1
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, _UPVALUE1_)
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE2_)
          end
        end
      elseif _ARG_0_.step == 1 then
        Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
        Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
        if _ARG_0_.myPos:gety() - _ARG_0_.playerPos:gety() < _UPVALUE3_ then
          _ARG_0_:TurnX(0, 2, 180)
        else
          _ARG_0_:TurnX(180, _UPVALUE4_, _UPVALUE5_)
        end
        _ARG_0_:Move(_UPVALUE6_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) and _ARG_0_:TurnX(0, 30, 180) == false then
          Entity.ClearSpeed(_ARG_0_.myHandle)
          _ARG_0_:GotoState("Faction_Rise")
        end
      elseif _ARG_0_.step == 2 then
        _ARG_0_:Move(_UPVALUE7_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) and _ARG_0_:TurnX(0, 30, 180) == false then
          Entity.ClearSpeed(_ARG_0_.myHandle)
          _ARG_0_:GotoState("Faction_Rise")
        end
      end
    end
  },
  Prize_hunt = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.step = 0
      _ARG_0_.Speed = 0
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 2, 2)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.overAngle = 90
      Enemy.EnableGetPrize(_ARG_0_.myHandle, 1)
      _ARG_0_.maxPrizeNumber = Enemy.GetPrizeNumber()
      _ARG_0_.huntPrizeNumber = Math.integer(_ARG_0_.maxPrizeNumber * _UPVALUE2_)
      print("m09ex: \131v\131\137\131C\131Y\130\204\144\148 = " .. Enemy.GetPrizeNumber() .. "\n")
      print("m09ex: \131n\131\147\131g\130\204\144\148 = " .. Math.integer(_ARG_0_.huntPrizeNumber) .. "\n")
      _ARG_0_.Prizenumber = 0
      _ARG_0_.PrizeHuntFlag = 1
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
    end,
    OnEndState = function(_ARG_0_)
      Enemy.EnableGetPrize(_ARG_0_.myHandle, 0)
      _ARG_0_.PrizeHuntFlag = 0
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.PrizeHuntFlag = 2
      _ARG_0_.maxPrizeNumber = Enemy.GetPrizeNumber()
      _ARG_0_.huntPrizeNumber = Math.integer(_ARG_0_.maxPrizeNumber * _UPVALUE0_)
      if _ARG_0_.step == 0 then
        if _ARG_0_:TurnX(0, 3, 180) == false then
          Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.prizeHandle)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.prizeHandle, 3)
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_.step = 1
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE2_)
          end
        end
      elseif _ARG_0_.step == 1 then
        _ARG_0_.prizeHandle = Enemy.SearchPrize(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.prizeHandle)
        Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.prizeHandle, 3)
        if _ARG_0_.myPos:gety() - _ARG_0_.playerPos:gety() < 0.6 then
          _ARG_0_:TurnX(0, 2, 180)
        else
          _ARG_0_:TurnX(180, _UPVALUE3_, _UPVALUE4_)
        end
        _ARG_0_:Move(_UPVALUE5_)
        if (Entity.IsTimeOver(_ARG_0_.myHandle) or Enemy.GetPrizeNumber() <= 0) and _ARG_0_:TurnX(0, 10, 180) == false then
          Entity.ClearSpeed(_ARG_0_.myHandle)
          _ARG_0_:GotoState("Faction_Rise")
        end
      elseif _ARG_0_.step == 2 then
      end
    end
  },
  Disappear = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
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
function m09ex00.TurnX(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  _ARG_0_.rot:setx(HomingDegree(_ARG_0_.rot:getx(), _ARG_1_, _ARG_2_, Entity.GetFrameRate(_ARG_0_.myHandle)))
  if _ARG_0_.rot:getx() < DegToRad(-_ARG_3_) then
    _ARG_0_.rot:setx(DegToRad(-_ARG_3_))
  end
  if _ARG_0_.rot:getx() > DegToRad(_ARG_3_) then
    _ARG_0_.rot:setx(DegToRad(_ARG_3_))
  end
  Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
  return HomingDegree(_ARG_0_.rot:getx(), _ARG_1_, _ARG_2_, Entity.GetFrameRate(_ARG_0_.myHandle))
end
function m09ex00.TurnY(_ARG_0_, _ARG_1_)
  Entity.GetRot(_ARG_0_.WorkVec, _ARG_0_.myHandle)
  _ARG_0_.WorkVec:sety(_ARG_0_.WorkVec:gety() + _ARG_1_)
  Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function m09ex00.Turn8Move(_ARG_0_, _ARG_1_)
  _ARG_0_.Speed = _ARG_0_.Speed + _ARG_1_ * 0.1 / 2 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_1_ < _ARG_0_.Speed then
    _ARG_0_.Speed = _ARG_1_
  end
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  Entity.TurnTargetDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, _UPVALUE0_)
  Entity.GetRot(_ARG_0_.workVec0, _ARG_0_.myHandle)
  _ARG_0_.workVec0:sety(_ARG_0_.rot:gety())
  _ARG_0_.workVec0:setz(_ARG_0_.rot:getz())
  Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.workVec0)
  Entity.CalcVelocity(_ARG_0_.myHandle, _ARG_0_.Speed)
end
function m09ex00.Move(_ARG_0_, _ARG_1_)
  _ARG_0_.Speed = _ARG_0_.Speed + _ARG_1_ * 0.1 / 2 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_1_ < _ARG_0_.Speed then
    _ARG_0_.Speed = _ARG_1_
  end
  Entity.CalcVelocity(_ARG_0_.myHandle, _ARG_0_.Speed)
end
function m09ex00.TargetHomingMove(_ARG_0_, _ARG_1_, _ARG_2_)
  _ARG_0_.Speed = _ARG_0_.Speed + _ARG_1_ * 0.1 / 2 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_1_ < _ARG_0_.Speed then
    _ARG_0_.Speed = _ARG_1_
  end
  Entity.TurnTargetDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, _ARG_2_)
  Entity.CalcVelocity(_ARG_0_.myHandle, _ARG_0_.Speed)
end
function m09ex00.Stop(_ARG_0_, _ARG_1_)
  _ARG_0_.Speed = _ARG_0_.Speed - _ARG_1_ * 0.1 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_0_.Speed < 0 then
    _ARG_0_.Speed = 0
  end
  FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Speed)
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function m09ex00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
  _ARG_0_.playerPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec0 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workTime = 0
  _ARG_0_.workTime2 = 0
  _ARG_0_.workTime3 = 0
  _ARG_0_.step = 0
  _ARG_0_.targetHandle = NULL_HANDLE
  _ARG_0_.prizeHandle = NULL_HANDLE
  _ARG_0_.damageCount = 0
  _ARG_0_.dizzy = false
  _ARG_0_.attack = 0
  _ARG_0_.hitAttack = false
  _ARG_0_.fastModeTimer = 0
  _ARG_0_.rotDir = 1
  _ARG_0_.aura = false
  _ARG_0_.angle = 0
  _ARG_0_.targetAngle = 0
  _ARG_0_.Speed = 0
  _ARG_0_.AngY = 0
  _ARG_0_.MoveType = 0
  _ARG_0_.Height = 0
  _ARG_0_.overAngle = 0
  _ARG_0_.huntPrizeNumber = 0
  _ARG_0_.maxPrizeNumber = 0
  _ARG_0_.PrizeHunt_Delay = 0
  _ARG_0_.getTaimer = 0
  _ARG_0_.PrizeHuntFlag = 0
  _ARG_0_.BeakDivingFlag = 0
  _ARG_0_.HpPrizeS = 0
  _ARG_0_.HpPrizeL = 0
  _ARG_0_.FpPrizeS = 0
  _ARG_0_.FpPrizeL = 0
  _ARG_0_.MunnyPrizeS = 0
  _ARG_0_.MunnyPrizeM = 0
  _ARG_0_.MunnyPrizeL = 0
  _ARG_0_.AllMaxPrize = 0
  _ARG_0_.Prizenumber = 0
  Entity.SetDropShadowDistance(_ARG_0_.myHandle, 225)
  if _UPVALUE0_ == false then
    _UPVALUE0_ = true
    _UPVALUE1_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "Speed")
    _UPVALUE2_ = _UPVALUE1_ * Enemy.GetExtraParam(_ARG_0_.myHandle, "SpeedMul")
    _UPVALUE3_ = _UPVALUE2_
  end
  if Enemy.IsAllEnemyWaiting() then
    _ARG_0_:GotoState("Waiting")
  else
    _ARG_0_:GotoState("Appear")
  end
end
function m09ex00.NotifyGetPrize(_ARG_0_, _ARG_1_)
  Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
  if _ARG_1_ == PRIZE_KIND_HpPrizeS then
    _ARG_0_.HpPrizeS = _ARG_0_.HpPrizeS + 1
    Enemy.PlaySe(_ARG_0_.myHandle, 4, _ARG_0_.myPos)
  elseif _ARG_1_ == PRIZE_KIND_HpPrizeL then
    _ARG_0_.HpPrizeL = _ARG_0_.HpPrizeL + 1
    Enemy.PlaySe(_ARG_0_.myHandle, 4, _ARG_0_.myPos)
  elseif _ARG_1_ == PRIZE_KIND_FpPrizeS then
    _ARG_0_.FpPrizeS = _ARG_0_.FpPrizeS + 1
    Enemy.PlaySe(_ARG_0_.myHandle, 5, _ARG_0_.myPos)
  elseif _ARG_1_ == PRIZE_KIND_FpPrizeL then
    _ARG_0_.FpPrizeL = _ARG_0_.FpPrizeL + 1
    Enemy.PlaySe(_ARG_0_.myHandle, 5, _ARG_0_.myPos)
  elseif _ARG_1_ == PRIZE_KIND_MunnyPrizeS then
    _ARG_0_.MunnyPrizeS = _ARG_0_.MunnyPrizeS + 1
    Enemy.PlaySe(_ARG_0_.myHandle, 6, _ARG_0_.myPos)
  elseif _ARG_1_ == PRIZE_KIND_MunnyPrizeM then
    _ARG_0_.MunnyPrizeM = _ARG_0_.MunnyPrizeM + 1
    Enemy.PlaySe(_ARG_0_.myHandle, 6, _ARG_0_.myPos)
  elseif _ARG_1_ == PRIZE_KIND_MunnyPrizeL then
    _ARG_0_.MunnyPrizeL = _ARG_0_.MunnyPrizeL + 1
    Enemy.PlaySe(_ARG_0_.myHandle, 6, _ARG_0_.myPos)
  end
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
  if _ARG_0_.getTaimer < 0 then
    Entity.AttachEffect(_ARG_0_.myHandle, "e_ex090", "E009_ORA_01_0", "mune")
    _ARG_0_.getTaimer = 30
  end
  _ARG_0_.AllMaxPrize = _ARG_0_.MunnyPrizeL + _ARG_0_.MunnyPrizeM + _ARG_0_.MunnyPrizeS + _ARG_0_.FpPrizeL + _ARG_0_.FpPrizeS + _ARG_0_.HpPrizeL + _ARG_0_.HpPrizeS
  _ARG_0_.Prizenumber = _ARG_0_.Prizenumber + 1
  _ARG_0_.prizeHandle = Enemy.SearchPrize(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
  if _ARG_0_.prizeHandle == 0 then
    _ARG_0_:GotoState("Search")
  end
  return 1
end
function m09ex00.OnDamage(_ARG_0_, _ARG_1_, _ARG_2_)
  _ARG_0_.BeakDivingFlag = 0
  Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  _ARG_0_.rot:setx(0)
  Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
  return 0
end
function m09ex00.OnReturnDamage(_ARG_0_)
  _ARG_0_:GotoState("Faction_Rise")
end
function m09ex00.OnUpdatePositionAfter(_ARG_0_)
  if _ARG_0_.flag then
    _ARG_0_.rot:set(0, _ARG_0_.angle, 0)
    Entity.RotateBoneXYZ(_ARG_0_.myHandle, 2, _ARG_0_.rot)
  end
end
function m09ex00.OnDead(_ARG_0_)
  Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
  _ARG_0_.PrizeHuntFlag = 0
  if 0 < _ARG_0_.HpPrizeS then
    for _FORV_4_ = 0, _ARG_0_.HpPrizeS - 1, 2 do
      Enemy.SetPrize(_ARG_0_.myHandle, 0)
    end
  end
  if _FOR_ > 0 then
    for _FORV_4_ = 0, _ARG_0_.HpPrizeL - 1, 2 do
      Enemy.SetPrize(_ARG_0_.myHandle, 1)
    end
  end
  if _FOR_ > 0 then
    for _FORV_4_ = 0, _ARG_0_.FpPrizeS - 1, 2 do
      Enemy.SetPrize(_ARG_0_.myHandle, 5)
    end
  end
  if _FOR_ > 0 then
    for _FORV_4_ = 0, _ARG_0_.FpPrizeL - 1, 2 do
      Enemy.SetPrize(_ARG_0_.myHandle, 6)
    end
  end
  if _FOR_ > 0 then
    for _FORV_4_ = 0, _ARG_0_.MunnyPrizeS - 1, 2 do
      Enemy.SetPrize(_ARG_0_.myHandle, 2)
    end
  end
  if _FOR_ > 0 then
    for _FORV_4_ = 0, _ARG_0_.MunnyPrizeM - 1, 2 do
      Enemy.SetPrize(_ARG_0_.myHandle, 3)
    end
  end
  if _FOR_ > 0 then
    for _FORV_4_ = 0, _ARG_0_.MunnyPrizeL - 1, 2 do
      Enemy.SetPrize(_ARG_0_.myHandle, 4)
    end
  end
  return _FOR_
end
function m09ex00.OnUpdate(_ARG_0_)
  _ARG_0_:Update()
  _ARG_0_:Debug()
  _ARG_0_.getTaimer = _ARG_0_.getTaimer - Entity.GetFrameRate(_ARG_0_.myHandle)
end
function m09ex00.GetNumber(_ARG_0_)
  return _ARG_0_.BeakDivingFlag
end
function m09ex00.OnSetupBlow(_ARG_0_)
  _ARG_0_.BeakDivingFlag = 0
end
function m09ex00.Debug(_ARG_0_)
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
EntityFactory:Add("m09ex00", function(_ARG_0_)
  return (m09ex00:new())
end)
EntityFactory:Add("m09vs00", function(_ARG_0_)
  return (m09ex00:new())
end)
