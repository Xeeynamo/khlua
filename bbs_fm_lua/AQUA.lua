Faira = {
  BeginState = function(_ARG_0_)
    _ARG_0_:SetMotion(PLBBASE_COMMAND_ATTACKCOM2)
    _ARG_0_.step = 0
  end,
  EndState = function(_ARG_0_)
  end,
  Update = function(_ARG_0_)
    if _ARG_0_.step == 0 then
      if Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10) == false then
      end
      if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 8 then
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        _ARG_0_:CreateBulletEx(PLBBASE_COMMAND_ATTACKCOM2)
        _ARG_0_.step = 1
      end
    elseif _ARG_0_.step == 1 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
      _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
    end
  end
}
Brizara = {
  BeginState = function(_ARG_0_)
    _ARG_0_:SetMotion(PLBBASE_COMMAND_ATTACKCOM3)
    _ARG_0_.step = 0
  end,
  EndState = function(_ARG_0_)
  end,
  Update = function(_ARG_0_)
    if _ARG_0_.step == 0 then
      if Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10) == false then
      end
      if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 8 then
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        _ARG_0_:CreateBulletEx(PLBBASE_COMMAND_ATTACKCOM3)
        _ARG_0_.step = 1
      end
    elseif _ARG_0_.step == 1 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
      _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
    end
  end
}
Rifrectobritts = {
  BeginState = function(_ARG_0_)
    _ARG_0_:SetMotionEx(PLBBASE_COMMAND_ATTACKCOM1, 327, 0)
    _ARG_0_.step = 0
    _ARG_0_:SetingGuard()
    Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
    _ARG_0_.step = 0
  end,
  EndState = function(_ARG_0_)
    Entity.ClearSpeed(_ARG_0_.myHandle)
    _ARG_0_:EndGuard()
  end,
  Update = function(_ARG_0_)
    if _ARG_0_.step == 0 then
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_.step = 1
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, "007")
        Entity.SetMotionWithSameCheck(_ARG_0_.keyHandle, "007")
      end
    elseif _ARG_0_.step == 1 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
      _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      _ARG_0_:EndGuard()
    end
  end
}
Keal = {
  BeginState = function(_ARG_0_)
    _ARG_0_:SetMotion(PLBBASE_COMMAND_KEAL)
    _ARG_0_.step = 0
  end,
  EndState = function(_ARG_0_)
  end,
  Update = function(_ARG_0_)
    if _ARG_0_.step == 0 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 16 then
      Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.keyHandle, 2)
      Entity.GetWorldPos(_ARG_0_.workVec, _ARG_0_.myHandle, 2)
      Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
      Entity.SetEffect(_ARG_0_.keyHandle, "m_ex_cur_00", "P_MA_CU1_CUR0_0", _ARG_0_.myPos, _ARG_0_.rot)
      Entity.SetEffect(_ARG_0_.keyHandle, "m_ex_cur_00", "P_MA_CUR_FIR0_0", _ARG_0_.myPos, _ARG_0_.rot)
      Entity.SetEffect(_ARG_0_.keyHandle, "m_ex_cur_00", "P_MA_CU1_CUR1_0", _ARG_0_.workVec, _ARG_0_.rot)
      Enemy.AddHp(_ARG_0_.myHandle, _ARG_0_:GetRecoveryAmon(PLBBASE_COMMAND_KEAL))
      _ARG_0_.step = 1
    end
    if Entity.IsMotionEnd(_ARG_0_.myHandle) then
      _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
    end
  end
}
Cartwheel = {
  BeginState = function(_ARG_0_)
    if Entity.IsGround(_ARG_0_.myHandle) then
      _ARG_0_:SetMotion(PLBBASE_COMMAND_EVASION)
    else
      _ARG_0_:SetMotion_2(PLBBASE_COMMAND_EVASION)
    end
    _ARG_0_.step = 0
    Entity.SetTimer(_ARG_0_.myHandle, 6)
    Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
    Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
    Entity.GetRot(_ARG_0_.workVec, _ARG_0_.myHandle)
    _ARG_0_.workVec:sety(_ARG_0_.workVec:gety() + DegToRad(270))
    Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.workVec)
    _ARG_0_.NoEvasionframe = 210
  end,
  EndState = function(_ARG_0_)
    Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
  end,
  Update = function(_ARG_0_)
    if _ARG_0_.step == 0 then
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:SetMotion_1(PLBBASE_COMMAND_EVASION)
        _ARG_0_.step = 1
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end
    elseif _ARG_0_.step == 1 and (Entity.IsMotionEnd(_ARG_0_.myHandle) or Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 23) then
      print("Old State = " .. _ARG_0_.OldState .. "\n")
      _ARG_0_:GotoState(_ARG_0_.OldState)
    end
  end
}
Blackout_Command = {
  BeginState = function(_ARG_0_)
    _ARG_0_:SetMotion(PLBBASE_COMMAND_SPECIAL0)
    _ARG_0_.step = 0
  end,
  EndState = function(_ARG_0_)
  end,
  Update = function(_ARG_0_)
    if _ARG_0_.step == 0 then
      if Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10) == false then
      end
      if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 16 then
        _ARG_0_:CreateBulletEx(PLBBASE_COMMAND_SPECIAL0)
        _ARG_0_.step = 1
      end
    elseif _ARG_0_.step == 1 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
      _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
    end
  end
}
