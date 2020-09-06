Sonicimpact = {
  BeginState = function(_ARG_0_)
    _ARG_0_:SetMotion(PLBBASE_COMMAND_ATTACKCOM2)
    _ARG_0_.step = 0
    Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
    Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
    Entity.GetRot(_ARG_0_.workVec, _ARG_0_.myHandle)
    _ARG_0_.workVec:sety(_ARG_0_.workVec:gety() + DegToRad(Script.Random() * 180 - 90))
    Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.workVec)
    Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_:GetCancelTime(PLBBASE_COMMAND_ATTACKCOM2))
    FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_:GetSpeed(PLBBASE_COMMAND_ATTACKCOM2))
    Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
  end,
  EndState = function(_ARG_0_)
    Entity.ClearSpeed(_ARG_0_.myHandle)
  end,
  Update = function(_ARG_0_)
    if _ARG_0_.step == 0 then
      FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_:GetSpeed(PLBBASE_COMMAND_ATTACKCOM2))
      Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:SetMotion_1(PLBBASE_COMMAND_ATTACKCOM2)
        _ARG_0_.step = 2
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
      end
    elseif _ARG_0_.step == 1 then
      FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_:GetSpeed(PLBBASE_COMMAND_ATTACKCOM2))
      Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:SetMotion_1(PLBBASE_COMMAND_ATTACKCOM2)
        _ARG_0_.step = 2
      end
    elseif _ARG_0_.step == 2 then
      FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_:GetSpeed(PLBBASE_COMMAND_ATTACKCOM2))
      Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      end
    end
  end
}
Brutus_force = {
  BeginState = function(_ARG_0_)
    _ARG_0_.step = 0
    Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_0_:GetMotion(PLBBASE_COMMAND_ATTACKCOM3), 380, 0)
    Entity.SetMotionWithSameCheck(_ARG_0_.keyHandle, _ARG_0_:GetMotion(PLBBASE_COMMAND_ATTACKCOM3), 380, 0)
    Entity.SetTimer(_ARG_0_.myHandle, 20)
  end,
  EndState = function(_ARG_0_)
  end,
  Update = function(_ARG_0_)
    if _ARG_0_.step == 0 then
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_0_:GetMotion1(PLBBASE_COMMAND_ATTACKCOM3), 380, 0)
        Entity.SetMotionWithSameCheck(_ARG_0_.keyHandle, _ARG_0_:GetMotion1(PLBBASE_COMMAND_ATTACKCOM3), 380, 0)
        _ARG_0_.step = 2
      end
    elseif _ARG_0_.step == 1 then
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:SetMotionEx_1(PLBBASE_COMMAND_ATTACKCOM3, 380, 0)
        _ARG_0_.step = 2
      end
    elseif _ARG_0_.step == 2 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
      _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
    end
    Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 6)
  end
}
Guardimpact = {
  BeginState = function(_ARG_0_)
    _ARG_0_.GuardFlag = 0
    _ARG_0_.step = 0
    _ARG_0_:SetMotion(PLBBASE_COMMAND_EVASION)
    _ARG_0_:SetingGuard()
    Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
    _ARG_0_.NoEvasionframe = 210
    _ARG_0_.guardDelay = Script.Random() * 20 + 40
  end,
  EndState = function(_ARG_0_)
    _ARG_0_:EndGuard()
  end,
  Update = function(_ARG_0_)
    if _ARG_0_.step == 0 then
      _ARG_0_.guardDelay = _ARG_0_.guardDelay - Entity.GetFrameRate(_ARG_0_.myHandle)
      if _ARG_0_.GuardFlag == 1 then
        if 0 > _ARG_0_.guardDelay then
          if Script.Random() < 0.3 then
            _ARG_0_:SetMotionEx(PLBBASE_COMMAND_ATTACKCOM1, _ARG_0_:GetGroupNum(PLBBASE_COMMAND_ATTACKCOM1), -1)
            _ARG_0_:EndGuard()
            _ARG_0_.step = 1
            Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
          elseif Script.Random() > 0.8 then
            if _ARG_0_:GetAttackRate1() == 1 then
              _ARG_0_:GotoState("Combo")
              return
            elseif _ARG_0_:GetAttackRate1() == 2 then
              _ARG_0_:GotoState("ShortDistAttackCommand")
              Entity.ClearSpeed(_ARG_0_.myHandle)
              return
            else
              _ARG_0_:GotoState("Goes_away")
              return
            end
          end
        end
      elseif _ARG_0_.GuardFlag == 0 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        _ARG_0_:EndGuard()
      end
    elseif _ARG_0_.step == 1 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
      _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
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
