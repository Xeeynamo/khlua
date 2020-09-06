m20ex00 = {}
m20ex00_base_mt = {__index = __StateMachine}
setmetatable(m20ex00, m20ex00_base_mt)
m20ex00_mt = {__index = m20ex00}
function m20ex00.new(_ARG_0_)
  return setmetatable(__StateMachine:new(), m20ex00_mt)
end
m20ex00.states = {
  Appear = {
    OnBeginState = function(_ARG_0_)
      SetupAppearBegin2(_ARG_0_.myHandle, 1, _UPVALUE0_, 0)
      _ARG_0_:SetingGuard()
    end,
    OnEndState = function(_ARG_0_)
      SetupAppearEnd(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
        Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.myHandle, 25)
        Entity.AttachCoord(_ARG_0_.myHandle, "X_r_tate", _ARG_0_.shieldRHandle, "Root")
        Entity.EnableLockonAndShooton(_ARG_0_.shieldRHandle, 0)
        Entity.SetLocalBoneTrans(_ARG_0_.shieldRHandle, _ARG_0_.WorkVec, 0)
        Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.myHandle, 20)
        Entity.AttachCoord(_ARG_0_.myHandle, "X_l_tate", _ARG_0_.shieldLHandle, "Root")
        Entity.EnableLockonAndShooton(_ARG_0_.shieldLHandle, 0)
        Entity.SetLocalBoneTrans(_ARG_0_.shieldLHandle, _ARG_0_.WorkVec, 0)
      end
    end
  },
  Idling = {
    OnBeginState = function(_ARG_0_)
      print("m20ex00:Idling\n")
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
      if _ARG_0_.step == 99 then
        Entity.SetAnimNowFrame(_ARG_0_.myHandle, Script.Random() * Entity.GetMotionTotalFrame(_ARG_0_.myHandle))
      end
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_ + Script.Random() * _UPVALUE1_)
      _ARG_0_.step = 0
      _ARG_0_.Wait = _UPVALUE1_ + Script.Random() * _UPVALUE1_
      _ARG_0_.step = 0
      if _ARG_0_:CheckHP() == 1 then
        _ARG_0_.step = 1
      end
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.Wait = _ARG_0_.Wait - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      if _ARG_0_.step == 0 then
        if _ARG_0_.Wait < 0 and Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) == true then
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE0_ then
            if Script.Random() < _UPVALUE1_ then
              _ARG_0_:GotoState("Attack1")
            else
              _ARG_0_:GotoState("Attack2")
            end
            return
          elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _UPVALUE0_ and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE2_ then
            if Script.Random() < _UPVALUE3_ then
              _ARG_0_:GotoState("Move")
            else
              _ARG_0_:GotoState("Goes_away")
            end
            return
          elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _UPVALUE2_ then
            if Script.Random() < _UPVALUE4_ then
              _ARG_0_:GotoState("Attack3")
            else
              _ARG_0_:GotoState("Idling")
            end
            return
          end
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE0_ then
            _ARG_0_:GotoState("Move")
          elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _UPVALUE0_ and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE2_ then
            _ARG_0_:GotoState("Move")
          elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _UPVALUE2_ then
            if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) == true then
              return
            elseif CanDisappear(_ARG_0_.myHandle, _ARG_0_.targetHandle) == true then
              _ARG_0_:GotoState("Disappear")
              return
            end
          end
        end
      elseif _ARG_0_.step == 1 then
        if CanDisappear(_ARG_0_.myHandle, _ARG_0_.targetHandle) == true then
          _ARG_0_:GotoState("Disappear")
          return
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Attack4")
        end
      end
    end
  },
  Move = {
    OnBeginState = function(_ARG_0_)
      print("m20ex00:Move\n")
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.WorkVec:set(0, 0, _UPVALUE0_)
      Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 3)
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
        return
      end
      if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE1_ then
        if Script.Random() < _UPVALUE2_ then
          _ARG_0_:GotoState("Attack1")
        else
          _ARG_0_:GotoState("Attack2")
        end
      end
    end
  },
  Goes_away = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
      _ARG_0_.away = Script.Random() * 1 + 6
      Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
      _ARG_0_.WorkVec:set(0, 0, 0)
      _ARG_0_.targetPos:setx(_ARG_0_.targetPos:getx() + ((_ARG_0_.away * Script.Random() + _ARG_0_.away) * Math.Cos((RoundPI(Script.Random() * 2 * PI))) + _ARG_0_.WorkVec:getx()))
      _ARG_0_.targetPos:setz(_ARG_0_.targetPos:getz() + ((_ARG_0_.away * Script.Random() + _ARG_0_.away) * Math.Sin((RoundPI(Script.Random() * 2 * PI))) + _ARG_0_.WorkVec:getz()))
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_ * (Script.Random() * 120))
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 3)
      _ARG_0_.WorkVec:set(0, 0, _UPVALUE0_)
      Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
      if Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.IsWall(_ARG_0_.myHandle) or Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetPos) < 1 then
        _ARG_0_:GotoState("Attack3")
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end
    end
  },
  Front_Move = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 3.5)
      _ARG_0_:Move(_ARG_0_:GetSpeed(PLBBASE_COMMAND_BATTLEWALK))
      if Entity.IsTargetWithinFOV(_ARG_0_.myHandle, _ARG_0_.targetHandle, DegToRad(20)) == true then
      end
      _ARG_0_:GotoState("Move")
    end
  },
  Stiffening = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.step = 0
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Attack1 = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.step = 0
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 and Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10) == false then
        _ARG_0_.step = 1
      end
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Stiffening")
      end
    end
  },
  Attack2 = {
    OnBeginState = function(_ARG_0_)
      Entity.SetTimer(_ARG_0_.myHandle, 0)
      _ARG_0_.step = 0
      _ARG_0_.hitFlag = 0
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      print("m20ex00:Attack2\n")
    end,
    OnEndState = function(_ARG_0_)
      Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 0)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 25 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) < 40 and _ARG_0_.hitFlag == 0 then
        Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 1)
      else
        Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 0)
      end
      if _ARG_0_.step == 0 and Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10) == false then
        _ARG_0_.step = 1
      end
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Stiffening")
      end
    end
  },
  Attack3 = {
    OnBeginState = function(_ARG_0_)
      Entity.SetTimer(_ARG_0_.myHandle, 0)
      _ARG_0_.step = 0
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 and Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10) == false then
        _ARG_0_.step = 1
      end
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Stiffening")
      end
    end
  },
  Attack4 = {
    OnBeginState = function(_ARG_0_)
      Entity.SetTimer(_ARG_0_.myHandle, 0)
      _ARG_0_.hitFlag = 0
      _ARG_0_.step = 0
      Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle, 2)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, _ARG_0_.AngerFlag, _ARG_0_.AngerFlag)
      if _ARG_0_.AngerFlag == 1 then
      end
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
    end,
    OnEndState = function(_ARG_0_)
      Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 0)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      _ARG_0_:SetingGuard()
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10) == false then
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 10)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.step = 2
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        end
      elseif _ARG_0_.step == 2 then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 10)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 30)
        if 2 <= Entity.GetMotionNowFrame(_ARG_0_.myHandle) then
          _ARG_0_.velocity:set(0, 0, _UPVALUE1_ / 40)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
          _ARG_0_.step = 3
        end
      elseif _ARG_0_.step == 3 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 21 then
          _ARG_0_.step = 4
          Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 1)
        end
      elseif _ARG_0_.step == 4 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 21 then
          Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 0)
          Camera.QuakeV(50, 0.5, 12)
          Entity.ClearSpeed(_ARG_0_.myHandle)
          _ARG_0_.step = 5
          _ARG_0_:EndGuard()
        end
      elseif _ARG_0_.step == 5 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.step = 6
        end
      elseif _ARG_0_.step == 6 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
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
      print("m20ex00:Dead\n")
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
      Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsModelFade(_ARG_0_.myHandle) then
        Enemy.Disappear(_ARG_0_.myHandle)
      end
    end
  }
}
function m20ex00.CheckHP(_ARG_0_)
  if Enemy.GetHp(_ARG_0_.myHandle) < Enemy.GetHpMax(_ARG_0_.myHandle) * _UPVALUE0_ then
    if _ARG_0_.AngerFlag == 0 then
      _ARG_0_.AngerFlag = 2
    end
    return 1
  end
  return 0
end
function m20ex00.SetingGuard(_ARG_0_)
  Entity.EnableGuard(_ARG_0_.myHandle, 1)
  Entity.SetGuardDir(_ARG_0_.myHandle, DegToRad(75))
  Entity.EnableGuardAttack(_ARG_0_.myHandle, 1)
  Entity.EnableGuardMagic(_ARG_0_.myHandle, 0)
end
function m20ex00.EndGuard(_ARG_0_)
  Entity.EnableGuard(_ARG_0_.myHandle, 0)
  Entity.SetGuardDir(_ARG_0_.myHandle, 0)
  Entity.EnableGuardAttack(_ARG_0_.myHandle, 0)
  Entity.EnableGuardMagic(_ARG_0_.myHandle, 0)
end
function m20ex00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.EffectHandle = NULL_HANDLE
  _ARG_0_.step = 0
  _ARG_0_.targetHandle = NULL_HANDLE
  _ARG_0_.shieldRHandle = NULL_HANDLE
  _ARG_0_.shieldLHandle = NULL_HANDLE
  _ARG_0_.Wait = 0
  _ARG_0_.NowMotionID = 0
  _ARG_0_.targetHandle = NULL_HANDLE
  _ARG_0_.away = 0
  _ARG_0_.hitFlag = 0
  _ARG_0_.MoveType = 0
  _ARG_0_.StrollCnt = 0
  _ARG_0_.Angle = 0
  _ARG_0_.onDmageFLag = 0
  _ARG_0_.AngerFlag = 0
  _ARG_0_.SavingsDamage = 0
  _ARG_0_.exec = false
  _ARG_0_.c = 0.15
  _ARG_0_.theta = 0
  _ARG_0_.smallDamageCount = 0
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
  _ARG_0_.vec = FVECTOR3.new(1, 1, 1)
  _ARG_0_.workVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
  if M20EX_INIT_PARAM == false then
    _UPVALUE0_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "IdlingT") * 60
    _UPVALUE1_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "ActionDis1")
    _UPVALUE1_ = _UPVALUE1_ * _UPVALUE1_
    _UPVALUE2_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "ActionDis2")
    _UPVALUE2_ = _UPVALUE2_ * _UPVALUE2_
    _UPVALUE3_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "Attack4Dis")
    _UPVALUE3_ = _UPVALUE3_ * _UPVALUE3_
    _UPVALUE4_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "Attack1R") * 0.01
    _UPVALUE5_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "Attack2R") * 0.01
    _UPVALUE6_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "MoveRate") * 0.01
    _UPVALUE6_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "MoveTime") * 60
    _UPVALUE7_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "CounterP")
    _UPVALUE8_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "ChangeHP") * 0.01
    M20EX_INIT_PARAM = true
  end
  _ARG_0_.shieldRHandle = Entity.CreateEntity("m27ex00", _ARG_0_.WorkVec, _ARG_0_.WorkVec, _ARG_1_)
  Entity.EnableBgColl(_ARG_0_.shieldRHandle, 0)
  Entity.AttachCoord(_ARG_1_, "X_r_tate", _ARG_0_.shieldRHandle, "Root")
  Entity.EnableLockonAndShooton(_ARG_0_.shieldRHandle, 0)
  EntityManager:GetEntity(_ARG_0_.shieldRHandle).ownerHandle = _ARG_1_
  _ARG_0_.shieldLHandle = Entity.CreateEntity("m28ex00", _ARG_0_.WorkVec, _ARG_0_.WorkVec, _ARG_1_)
  Entity.EnableBgColl(_ARG_0_.shieldLHandle, 0)
  Entity.AttachCoord(_ARG_1_, "X_l_tate", _ARG_0_.shieldLHandle, "Root")
  Entity.EnableLockonAndShooton(_ARG_0_.shieldLHandle, 0)
  Entity.SetDrawParentShadow(_ARG_0_.shieldRHandle, _ARG_0_.myHandle)
  Entity.SetDrawParentShadow(_ARG_0_.shieldLHandle, _ARG_0_.myHandle)
  EntityManager:GetEntity(_ARG_0_.shieldLHandle).ownerHandle = _ARG_1_
  Entity.SetMovementCollRadius(_ARG_0_.myHandle, 1.2)
  Entity.SetLowerHalf(_ARG_0_.myHandle, 1.5)
  Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
  Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
  Entity.EnableLockon(_ARG_0_.myHandle, 0)
  Entity.EnableGravity(_ARG_0_.myHandle, 1)
  Enemy.IsAllEnemyWaiting()
  Entity.SetDropShadowDistance(_ARG_0_.myHandle, 80)
  if Enemy.IsAllEnemyWaiting() == true then
    _ARG_0_:GotoState("Standby")
  else
    _ARG_0_:GotoState("Appear")
    Entity.EnableLockon(_ARG_0_.myHandle, 1)
  end
end
function m20ex00.OnReturnDamage(_ARG_0_, _ARG_1_)
  _ARG_0_:SetingGuard()
  _ARG_0_:GotoState("Idling")
  Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
end
function m20ex00.OnDamageBefore(_ARG_0_, _ARG_1_, _ARG_2_)
end
function m20ex00.OnDamage(_ARG_0_, _ARG_1_, _ARG_2_)
  print("OnDamageBefore kind = " .. _ARG_1_ .. "\n")
  Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 0)
  if Enemy.IsSpecialDamage(_ARG_0_.myHandle) or Enemy.IsMinimum(_ARG_0_.myHandle) then
    return 0
  end
  if _ARG_1_ == ATK_KIND_DMG_TOSS or _ARG_1_ == ATK_KIND_DMG_BEAT or _ARG_1_ == ATK_KIND_DMG_FLICK or _ARG_1_ == ATK_KIND_DMG_RISE or _ARG_1_ == ATK_KIND_ZEROGRAVITY or _ARG_1_ == ATK_KIND_MAGNESPIRAL or _ARG_2_ == 2 then
    _ARG_0_:EndGuard()
    return 0
  end
  _ARG_0_.SavingsDamage = _ARG_0_.SavingsDamage + Entity.GetDamagePoint(_ARG_0_.myHandle)
  print("Damage = " .. Entity.GetDamagePoint(_ARG_0_.myHandle) .. [[

Now Damage = ]] .. _ARG_0_.SavingsDamage .. "\n")
  if _ARG_0_.SavingsDamage > _UPVALUE0_ then
    _ARG_0_:GotoState("Attack2")
    Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
    _ARG_0_.SavingsDamage = 0
  end
end
function m20ex00.OnDead(_ARG_0_)
  _ARG_0_:GotoState("Dead")
end
function m20ex00.OnGuard(_ARG_0_)
  Entity.GetDamageCrossPos(_ARG_0_.workVec, _ARG_0_.myHandle)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  Entity.SetEffect(_ARG_0_.myHandle, "p_ex_bas_00", "P_EX_ATC_DIS0_0", _ARG_0_.workVec, _ARG_0_.rot)
  Entity.AttachEffect(_ARG_0_.myHandle, "e_ex200", "E020_GUD_00_0", "X_hara")
end
function m20ex00.OnUpdatePositionAfter(_ARG_0_)
  if _ARG_0_.exec then
    _ARG_0_.theta = RoundPI(_ARG_0_.theta + Entity.GetFrameRate(_ARG_0_.myHandle) * DegToRad(32))
    _ARG_0_.c = _ARG_0_.c - Entity.GetFrameRate(_ARG_0_.myHandle) * 0.0025
    if _ARG_0_.c < 0 then
      _ARG_0_.exec = false
    end
    Entity.GetLocalBoneTrans(_ARG_0_.workVec, _ARG_0_.myHandle, 26)
    _ARG_0_.workVec:set(_ARG_0_.workVec:getx() + Math.Cos(_ARG_0_.theta) * _ARG_0_.c, _ARG_0_.workVec:gety() + Math.Cos(_ARG_0_.theta) * _ARG_0_.c, _ARG_0_.workVec:getz() + Math.Sin(_ARG_0_.theta) * _ARG_0_.c)
    Entity.SetLocalBoneTrans(_ARG_0_.myHandle, _ARG_0_.workVec, 26)
  end
end
function m20ex00.OnNoReaction(_ARG_0_, _ARG_1_)
  if Enemy.IsStop(_ARG_0_.myHandle) then
    return
  end
  _ARG_0_.smallDamageCount = _ARG_0_.smallDamageCount + 1
  _ARG_0_.exec = true
  _ARG_0_.c = 0.15
  _ARG_0_.theta = 0
end
function m20ex00.OnHitAttack(_ARG_0_)
  _ARG_0_.hitFlag = 1
end
function m20ex00.Debug(_ARG_0_)
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
function m20ex00.OnUpdate(_ARG_0_)
  _ARG_0_:Update()
  _ARG_0_:Debug()
  if Enemy.IsSpecialDamage(_ARG_0_.myHandle) then
    _ARG_0_:EndGuard()
  else
    _ARG_0_:SetingGuard()
  end
  _ARG_0_.SavingsDamage = _ARG_0_.SavingsDamage - 0.01 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_0_.SavingsDamage < 0 then
    _ARG_0_.SavingsDamage = 0
  end
end
EntityFactory:Add("m20ex00", function(_ARG_0_)
  return (m20ex00:new())
end)
EntityFactory:Add("m20vs00", function(_ARG_0_)
  return (m20ex00:new())
end)
m27ex00 = {}
m27ex00_mt = {__index = m27ex00}
function m27ex00.new(_ARG_0_)
  print("new Shield\n")
  return setmetatable({}, m27ex00_mt)
end
function m27ex00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.ownerHandle = NULL_HANDLE
  Enemy.SetNoNetwork(_ARG_1_, 1)
end
function m27ex00.OnUpdate(_ARG_0_)
  Entity.SetAlpha(_ARG_0_.myHandle, (Entity.GetAlpha(_ARG_0_.ownerHandle)))
end
EntityFactory:Add("m27ex00", function(_ARG_0_)
  return (m27ex00:new())
end)
m28ex00 = {}
m28ex00_mt = {__index = m28ex00}
function m28ex00.new(_ARG_0_)
  print("new Shield\n")
  return setmetatable({}, m28ex00_mt)
end
function m28ex00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.ownerHandle = NULL_HANDLE
  Enemy.SetNoNetwork(_ARG_1_, 1)
end
function m28ex00.OnUpdate(_ARG_0_)
  Entity.SetAlpha(_ARG_0_.myHandle, (Entity.GetAlpha(_ARG_0_.ownerHandle)))
end
EntityFactory:Add("m28ex00", function(_ARG_0_)
  return (m28ex00:new())
end)
