Aero_Command = {
  BeginState = function(_ARG_0_)
    _ARG_0_:SetMotionEx(PLBBASE_COMMAND_ATTACKCOM1, _ARG_0_:GetGroupNum(PLBBASE_COMMAND_ATTACKCOM1), _ARG_0_:GetGroupNum(PLBBASE_COMMAND_ATTACKCOM1))
    _ARG_0_.step = 0
  end,
  EndState = function(_ARG_0_)
  end,
  Update = function(_ARG_0_)
    if _ARG_0_.step == 0 then
      if Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10) == false then
      end
      if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 16 then
        _ARG_0_:CreateBulletEx(PLBBASE_COMMAND_ATTACKCOM1)
        _ARG_0_.step = 1
      end
    elseif _ARG_0_.step == 1 then
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:SetMotion(PLBBASE_COMMAND_BATTLEIDLING)
        _ARG_0_.step = 2
        Entity.SetTimer(_ARG_0_.myHandle, 30)
      end
    elseif _ARG_0_.step == 2 and Entity.IsTimeOver(_ARG_0_.myHandle) then
      _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
    end
  end
}
Rush_Command = {
  BeginState = function(_ARG_0_)
    _ARG_0_:SetMotion(PLBBASE_COMMAND_ATTACKCOM2)
    _ARG_0_:SetMotionEx(PLBBASE_COMMAND_ATTACKCOM2, 134, -1)
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 10 then
    else
    end
    Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
    _ARG_0_.step = 0
    _ARG_0_:InitKeyBraid()
  end,
  EndState = function(_ARG_0_)
    Entity.ClearSpeed(_ARG_0_.myHandle)
    Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
  end,
  Update = function(_ARG_0_)
    if _ARG_0_.step == 0 then
      if Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180) == false then
        _ARG_0_.step = _ARG_0_.step + 1
      end
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:SetMotionEx_1(PLBBASE_COMMAND_ATTACKCOM2, 134, -1)
        _ARG_0_.step = 2
      end
      Entity.ClearSpeed(_ARG_0_.myHandle)
    elseif _ARG_0_.step == 1 then
      if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 6 then
        FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_:GetSpeed(PLBBASE_COMMAND_ATTACKCOM2))
      end
      if Entity.IsMotionEnd(_ARG_0_.myHandle) or EntityManager:GetEntity(_ARG_0_.keyHandle).HitAttackFlag == 1 then
        EntityManager:GetEntity(_ARG_0_.keyHandle).HitAttackFlag = 0
        _ARG_0_:SetMotionEx_1(PLBBASE_COMMAND_ATTACKCOM2, 134, -1)
        _ARG_0_.step = 2
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end
    elseif _ARG_0_.step == 2 then
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_.step = 3
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, "007")
        Entity.SetMotionWithSameCheck(_ARG_0_.keyHandle, "007")
      end
    elseif _ARG_0_.step == 3 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
      _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
    end
  end
}
StrikeReid = {
  BeginState = function(_ARG_0_)
    _ARG_0_:SetMotionEx(PLBBASE_COMMAND_ATTACKCOM3, 351, -1)
    _ARG_0_.step = 0
  end,
  EndState = function(_ARG_0_)
  end,
  Update = function(_ARG_0_)
    if _ARG_0_.step == 0 then
      if Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10) == false then
        _ARG_0_.step = _ARG_0_.step + 1
      end
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:SetMotionEx_1(PLBBASE_COMMAND_ATTACKCOM3, 351, -1)
        _ARG_0_.step = 2
      end
    elseif _ARG_0_.step == 1 then
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:SetMotionEx_1(PLBBASE_COMMAND_ATTACKCOM3, 351, -1)
        _ARG_0_.step = 2
      end
    elseif _ARG_0_.step == 2 then
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:SetMotionEx_2(PLBBASE_COMMAND_ATTACKCOM3, 351, -1)
        _ARG_0_.step = 3
      end
    elseif _ARG_0_.step == 3 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
      _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
    end
  end
}
Dodgerool = {
  BeginState = function(_ARG_0_)
    _ARG_0_:SetMotion(PLBBASE_COMMAND_EVASION)
    _ARG_0_.step = 0
    Entity.SetTimer(_ARG_0_.myHandle, 6)
    Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
    Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
    Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
    Entity.GetRot(_ARG_0_.workVec, _ARG_0_.myHandle)
    _ARG_0_.workVec:sety(_ARG_0_.workVec:gety() + DegToRad(180))
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
    elseif _ARG_0_.step == 1 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
      Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
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
