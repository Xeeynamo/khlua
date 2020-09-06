Sonicimpact = {
  BeginState = function(_ARG_0_)
    _ARG_0_:SetMotionEx(PLBBASE_COMMAND_ATTACKCOM2, 0, -1)
    _ARG_0_.step = 0
    Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
    Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
    Entity.GetRot(_ARG_0_.WorkVec, _ARG_0_.myHandle)
    _ARG_0_.WorkVec:sety(_ARG_0_.WorkVec:gety() + DegToRad(Script.Random() * 180 - 90))
    Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.WorkVec)
    Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_:GetCancelTime(PLBBASE_COMMAND_ATTACKCOM2))
    _ARG_0_.Speed = _ARG_0_:GetSpeed(PLBBASE_COMMAND_ATTACKCOM2)
    FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Speed)
    Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
    _ARG_0_.GoseAppFlag = 1
    Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
  end,
  EndState = function(_ARG_0_)
    Entity.ClearSpeed(_ARG_0_.myHandle)
    Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
  end,
  Update = function(_ARG_0_)
    if _ARG_0_.step == 0 then
      FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Speed)
      Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:SetMotionEx_1(PLBBASE_COMMAND_ATTACKCOM2, 213, -1)
        _ARG_0_.step = 2
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
        _ARG_0_.Speed = _ARG_0_:GetSpeed2(PLBBASE_COMMAND_ATTACKCOM2)
      end
    elseif _ARG_0_.step == 1 then
      FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Speed)
      Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:SetMotionEx_1(PLBBASE_COMMAND_ATTACKCOM2, 213, -1)
        _ARG_0_.step = 2
      end
    elseif _ARG_0_.step == 2 then
      _ARG_0_.Speed = _ARG_0_.Speed - _ARG_0_.Speed * 0.01
      if 0 > _ARG_0_.Speed then
        _ARG_0_.Speed = 0
      end
      FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Speed)
      Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      end
    end
  end
}
SonicimpactEx = {
  BeginState = function(_ARG_0_)
    _ARG_0_:SetMotionEx(PLBBASE_COMMAND_ATTACKCOM2, 0, -1)
    _ARG_0_.step = 0
    Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
    Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
    Entity.GetRot(_ARG_0_.WorkVec, _ARG_0_.myHandle)
    _ARG_0_.WorkVec:sety(_ARG_0_.WorkVec:gety() + DegToRad(Script.Random() * 180 - 90))
    Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.WorkVec)
    Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_:GetCancelTime(PLBBASE_COMMAND_ATTACKCOM2))
    _ARG_0_.Speed = _ARG_0_:GetSpeed(PLBBASE_COMMAND_ATTACKCOM2)
    FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Speed)
    Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
    _ARG_0_.GoseAppFlag = 1
    Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
    _ARG_0_.noReactionFlag = 1
  end,
  EndState = function(_ARG_0_)
    Entity.ClearSpeed(_ARG_0_.myHandle)
    Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
    _ARG_0_.noReactionFlag = 0
  end,
  Update = function(_ARG_0_)
    if _ARG_0_.step == 0 then
      FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Speed)
      Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:SetMotionEx_1(PLBBASE_COMMAND_ATTACKCOM2, 213, -1)
        _ARG_0_.step = 2
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
        _ARG_0_.Speed = _ARG_0_:GetSpeed2(PLBBASE_COMMAND_ATTACKCOM2)
      end
    elseif _ARG_0_.step == 1 then
      FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Speed)
      Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:SetMotionEx_1(PLBBASE_COMMAND_ATTACKCOM2, 213, -1)
        _ARG_0_.step = 2
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
      end
    elseif _ARG_0_.step == 2 then
      _ARG_0_.Speed = _ARG_0_.Speed - _ARG_0_.Speed * 0.01
      if 0 > _ARG_0_.Speed then
        _ARG_0_.Speed = 0
      end
      FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Speed)
      Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      end
    end
  end
}
DashVolley = {
  BeginState = function(_ARG_0_)
    _ARG_0_:SetMotionEx(PLBBASE_COMMAND_ATTACKCOM2, 0, -1)
    _ARG_0_.step = 0
    Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
    Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
    Entity.GetRot(_ARG_0_.WorkVec, _ARG_0_.myHandle)
    _ARG_0_.WorkVec:sety(_ARG_0_.WorkVec:gety() + DegToRad(180))
    Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.WorkVec)
    _ARG_0_.WorkVec:set(0, 0, 10)
    Entity.GetWorldPos2(_ARG_0_.targetPos, _ARG_0_.myHandle, _ARG_0_.WorkVec)
    Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.myHandle)
    if Collision.IntersectRayBg(_ARG_0_.WorkVec, COLL_KIND_ENEMY, _ARG_0_.WorkVec, _ARG_0_.targetPos) then
      _ARG_0_.WorkVec:set(10, 0, 10)
      Entity.GetWorldPos2(_ARG_0_.targetPos, _ARG_0_.myHandle, _ARG_0_.WorkVec)
      Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.myHandle)
      if Collision.IntersectRayBg(_ARG_0_.WorkVec, COLL_KIND_ENEMY, _ARG_0_.WorkVec, _ARG_0_.targetPos) then
        _ARG_0_.WorkVec:set(-10, 0, 10)
        Entity.GetWorldPos2(_ARG_0_.targetPos, _ARG_0_.myHandle, _ARG_0_.WorkVec)
        Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.myHandle)
        if Collision.IntersectRayBg(_ARG_0_.WorkVec, COLL_KIND_ENEMY, _ARG_0_.WorkVec, _ARG_0_.targetPos) then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
          Entity.GetRot(_ARG_0_.WorkVec, _ARG_0_.myHandle)
          _ARG_0_.WorkVec:sety(_ARG_0_.WorkVec:gety() + DegToRad(-45))
          Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.WorkVec)
        else
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
          Entity.GetRot(_ARG_0_.WorkVec, _ARG_0_.myHandle)
          _ARG_0_.WorkVec:sety(_ARG_0_.WorkVec:gety() + DegToRad(135))
          Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.WorkVec)
          print("\141\182\130\201\149\199\130\205\130\200\130\162\130\197\130\183\129B\n")
        end
      else
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
        Entity.GetRot(_ARG_0_.WorkVec, _ARG_0_.myHandle)
        _ARG_0_.WorkVec:sety(_ARG_0_.WorkVec:gety() + DegToRad(225))
        Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.WorkVec)
        print("\137E\130\201\149\199\130\205\130\200\130\162\130\197\130\183\129B\n")
      end
    else
      print("\149\199\130\205\130\200\130\162\130\197\130\183\129B\n")
    end
    Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_:GetCancelTime(PLBBASE_COMMAND_ATTACKCOM2))
    _ARG_0_.Speed = _ARG_0_:GetSpeed(PLBBASE_COMMAND_ATTACKCOM2)
    FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Speed)
    Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
    _ARG_0_.noReactionFlag = 1
    Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
    Entity.EnableGravity(_ARG_0_.myHandle, 0)
  end,
  EndState = function(_ARG_0_)
    Entity.ClearSpeed(_ARG_0_.myHandle)
    Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
    _ARG_0_.noReactionFlag = 0
    Entity.EnableGravity(_ARG_0_.myHandle, 1)
  end,
  Update = function(_ARG_0_)
    Entity.EnableGravity(_ARG_0_.myHandle, 0)
    if _ARG_0_.step == 0 then
      FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Speed)
      Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_.step = 1
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
      end
    elseif _ARG_0_.step == 1 then
      _ARG_0_.Speed = _ARG_0_.Speed - _ARG_0_.Speed * 0.01
      if 0 > _ARG_0_.Speed then
        _ARG_0_.Speed = 0
      end
      FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Speed)
      Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        return
      end
    elseif _ARG_0_.step == 2 then
    end
  end
}
DashVolley2 = {
  BeginState = function(_ARG_0_)
    _ARG_0_:SetMotionEx(PLBBASE_COMMAND_ATTACKCOM2, 0, -1)
    _ARG_0_.step = 0
    Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
    Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
    Entity.GetRot(_ARG_0_.WorkVec, _ARG_0_.myHandle)
    _ARG_0_.WorkVec:sety(_ARG_0_.WorkVec:gety() + DegToRad(45))
    Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.WorkVec)
    _ARG_0_.WorkVec:set(10, 0, 0)
    Entity.GetWorldPos2(_ARG_0_.targetPos, _ARG_0_.myHandle, _ARG_0_.WorkVec)
    Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.myHandle)
    if Collision.IntersectRayBg(_ARG_0_.WorkVec, COLL_KIND_ENEMY, _ARG_0_.WorkVec, _ARG_0_.targetPos) then
      _ARG_0_.WorkVec:set(-10, 0, 0)
      Entity.GetWorldPos2(_ARG_0_.targetPos, _ARG_0_.myHandle, _ARG_0_.WorkVec)
      Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.myHandle)
      if Collision.IntersectRayBg(_ARG_0_.WorkVec, COLL_KIND_ENEMY, _ARG_0_.WorkVec, _ARG_0_.targetPos) then
        _ARG_0_.WorkVec:set(0, 0, 10)
        Entity.GetWorldPos2(_ARG_0_.targetPos, _ARG_0_.myHandle, _ARG_0_.WorkVec)
        Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.myHandle)
        if Collision.IntersectRayBg(_ARG_0_.WorkVec, COLL_KIND_ENEMY, _ARG_0_.WorkVec, _ARG_0_.targetPos) then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
          Entity.GetRot(_ARG_0_.WorkVec, _ARG_0_.myHandle)
          _ARG_0_.WorkVec:sety(_ARG_0_.WorkVec:gety() + DegToRad(-45))
          Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.WorkVec)
        else
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
          Entity.GetRot(_ARG_0_.WorkVec, _ARG_0_.myHandle)
          _ARG_0_.WorkVec:sety(_ARG_0_.WorkVec:gety() + DegToRad(180))
          Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.WorkVec)
          print("\141\182\130\201\149\199\130\205\130\200\130\162\130\197\130\183\129B\n")
        end
      else
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
        Entity.GetRot(_ARG_0_.WorkVec, _ARG_0_.myHandle)
        _ARG_0_.WorkVec:sety(_ARG_0_.WorkVec:gety() + DegToRad(-45))
        Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.WorkVec)
        print("\141\182\130\201\149\199\130\205\130\200\130\162\130\197\130\183\129B\n")
      end
    else
      print("\137E\130\201\149\199\130\205\130\200\130\162\130\197\130\183\129B\n")
    end
    Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_:GetCancelTime(PLBBASE_COMMAND_ATTACKCOM2))
    _ARG_0_.Speed = _ARG_0_:GetSpeed(PLBBASE_COMMAND_ATTACKCOM2)
    FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Speed)
    Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
    _ARG_0_.noReactionFlag = 1
    Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
    Entity.EnableGravity(_ARG_0_.myHandle, 0)
  end,
  EndState = function(_ARG_0_)
    Entity.ClearSpeed(_ARG_0_.myHandle)
    Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
    _ARG_0_.noReactionFlag = 0
    Entity.EnableGravity(_ARG_0_.myHandle, 1)
  end,
  Update = function(_ARG_0_)
    if _ARG_0_.step == 0 then
      FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Speed)
      Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_.step = 1
      end
    elseif _ARG_0_.step == 1 then
      _ARG_0_.Speed = _ARG_0_.Speed - _ARG_0_.Speed * 0.01
      if 0 > _ARG_0_.Speed then
        _ARG_0_.Speed = 0
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
      end
      FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Speed)
      Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        return
      end
    elseif _ARG_0_.step == 2 then
    end
  end
}
Sonicimpact2 = {
  BeginState = function(_ARG_0_)
    _ARG_0_:SetMotionEx(PLBBASE_COMMAND_ATTACKCOM2, 0, -1)
    _ARG_0_.step = 0
    Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
    Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
    Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_:GetCancelTime(PLBBASE_COMMAND_ATTACKCOM2))
    _ARG_0_.Speed = _ARG_0_:GetSpeed(PLBBASE_COMMAND_ATTACKCOM2)
    FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Speed)
    Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
    _ARG_0_.GoseAppFlag = 1
    _ARG_0_.noReactionFlag = 1
    Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
    Entity.EnableGravity(_ARG_0_.myHandle, 0)
  end,
  EndState = function(_ARG_0_)
    Entity.ClearSpeed(_ARG_0_.myHandle)
    Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
    _ARG_0_.noReactionFlag = 0
    Entity.EnableGravity(_ARG_0_.myHandle, 1)
  end,
  Update = function(_ARG_0_)
    Entity.EnableGravity(_ARG_0_.myHandle, 0)
    if _ARG_0_.step == 0 then
      FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Speed)
      Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:SetMotionEx_1(PLBBASE_COMMAND_ATTACKCOM2, 213, -1)
        _ARG_0_.step = 2
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
        _ARG_0_.Speed = _ARG_0_:GetSpeed2(PLBBASE_COMMAND_ATTACKCOM2)
      end
    elseif _ARG_0_.step == 1 then
      FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Speed)
      Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:SetMotionEx_1(PLBBASE_COMMAND_ATTACKCOM2, 213, -1)
        _ARG_0_.step = 2
      end
    elseif _ARG_0_.step == 2 then
      _ARG_0_.Speed = _ARG_0_.Speed - _ARG_0_.Speed * 0.01
      if 0 > _ARG_0_.Speed then
        _ARG_0_.Speed = 0
      end
      FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Speed)
      Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      end
    end
  end
}
Quake = {
  BeginState = function(_ARG_0_)
    _ARG_0_:SetMotionEx(PLBBASE_COMMAND_ATTACKCOM3, _ARG_0_:GetGroupNum(PLBBASE_COMMAND_ATTACKCOM3), 171)
    _ARG_0_.step = 0
  end,
  EndState = function(_ARG_0_)
  end,
  Update = function(_ARG_0_)
    if _ARG_0_.step == 0 then
      if Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10) == false then
      end
      if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 16 then
        Camera.QuakeV(50, 0.25, 10)
        _ARG_0_:CreateBulletForQuake(PLBBASE_COMMAND_ATTACKCOM3, 0)
        _ARG_0_.step = 1
      end
    elseif _ARG_0_.step == 1 then
      if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 16 then
        _ARG_0_:CreateBulletForQuake(PLBBASE_COMMAND_ATTACKCOM3, 1)
        _ARG_0_.step = 2
      end
    elseif _ARG_0_.step == 2 then
      if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 16 then
        _ARG_0_:CreateBulletForQuake(PLBBASE_COMMAND_ATTACKCOM3, 2)
        _ARG_0_.step = 3
      end
    elseif _ARG_0_.step == 3 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
      _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
    end
  end
}
Meteor = {
  BeginState = function(_ARG_0_)
    _ARG_0_:SetMotionEx(PLBBASE_COMMAND_SPECIAL0, _ARG_0_:GetGroupNum(PLBBASE_COMMAND_SPECIAL0), 173)
    _ARG_0_.step = 0
  end,
  EndState = function(_ARG_0_)
  end,
  Update = function(_ARG_0_)
    if _ARG_0_.step == 0 then
      if Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10) == false then
      end
      if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 16 then
        _ARG_0_:CreateBulletForMeteor(PLBBASE_COMMAND_SPECIAL0, 0)
        _ARG_0_.step = 1
      end
    elseif _ARG_0_.step == 1 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
      _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
    end
  end
}
Midareuti = {
  BeginState = function(_ARG_0_)
    _ARG_0_:SetMotionEx(PLBBASE_COMMAND_SPECIAL1, _ARG_0_:GetGroupNum(PLBBASE_COMMAND_SPECIAL1), -1)
    if Entity.GetName(_ARG_0_.myHandle) == "b52ex00" then
      Entity.SetAnimNowFrame(_ARG_0_.myHandle, 12)
      Entity.SetAnimNowFrame(_ARG_0_.keyHandle, 12)
    end
    _ARG_0_.step = 0
    _ARG_0_.noReactionFlag = 1
  end,
  EndState = function(_ARG_0_)
    Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
    _ARG_0_.noReactionFlag = 0
  end,
  Update = function(_ARG_0_)
    if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 16 then
      Entity.SetRootMoveScale(_ARG_0_.myHandle, Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) / 3, 1, Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) / 3)
    end
    Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
    if _ARG_0_.step == 0 then
      if Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10) == false then
        _ARG_0_.step = 1
      end
    elseif _ARG_0_.step == 1 then
      if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 66 then
        _ARG_0_:SetMotionEx_1(PLBBASE_COMMAND_SPECIAL1, _ARG_0_:GetGroupNum(PLBBASE_COMMAND_SPECIAL1), 0)
        _ARG_0_.step = 2
      end
    elseif _ARG_0_.step == 2 then
      if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 22 then
        _ARG_0_:SetMotionEx_2(PLBBASE_COMMAND_SPECIAL1, _ARG_0_:GetGroupNum(PLBBASE_COMMAND_SPECIAL1), 0)
        _ARG_0_.step = 3
      end
    elseif _ARG_0_.step == 3 then
      if 16 <= Entity.GetMotionNowFrame(_ARG_0_.myHandle) then
        _ARG_0_:SetMotionEx_3(PLBBASE_COMMAND_SPECIAL1, _ARG_0_:GetGroupNum(PLBBASE_COMMAND_SPECIAL1), 0)
        _ARG_0_.step = 4
      end
    elseif _ARG_0_.step == 4 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
      _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
    end
  end
}
DarkImpulse = {
  BeginState = function(_ARG_0_)
    _ARG_0_:SetMotionEx(PLBBASE_COMMAND_SPECIAL2, _ARG_0_:GetGroupNum(PLBBASE_COMMAND_SPECIAL2), -1)
    _ARG_0_.step = 0
    _ARG_0_.noReactionFlag = 1
    _ARG_0_.HitAttackFlag = 0
    Entity.EnableGravity(_ARG_0_.myHandle, 0)
  end,
  EndState = function(_ARG_0_)
    Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
    Entity.LoopEndEffectAttach(_ARG_0_.keyHandle)
    DeleteModel(_ARG_0_.myHandle)
    _ARG_0_.noReactionFlag = 0
    _ARG_0_.HitAttackFlag = 0
    Entity.ClearSpeed(_ARG_0_.myHandle)
    Entity.EnableGravity(_ARG_0_.myHandle, 1)
  end,
  Update = function(_ARG_0_)
    if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 25 then
      Entity.SetRootMoveScale(_ARG_0_.myHandle, (Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) + 0.001) / 5, 1, (Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) + 0.001) / 5)
    else
      Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
    end
    Entity.GetWorldPos(_ARG_0_.playerPos, _ARG_0_.targetHandle)
    Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 9 then
    else
    end
    FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.playerPos, _ARG_0_.myPos)
    FVECTOR3.normalize(_ARG_0_.workVec)
    _ARG_0_.workVec:scale(0.01)
    Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
    if _ARG_0_.step == 0 then
      if Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10) == false then
        _ARG_0_.step = 1
      end
      if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 12 then
        _ARG_0_:SetMotionEx_1(PLBBASE_COMMAND_SPECIAL2, _ARG_0_:GetGroupNum(PLBBASE_COMMAND_SPECIAL2), -1)
        _ARG_0_.step = 2
      end
    elseif _ARG_0_.step == 1 then
      if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 4 then
        Entity.ClearSpeed(_ARG_0_.myHandle)
      else
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.workVec)
      end
      if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 12 then
        _ARG_0_:SetMotionEx_1(PLBBASE_COMMAND_SPECIAL2, _ARG_0_:GetGroupNum(PLBBASE_COMMAND_SPECIAL2), -1)
        _ARG_0_.step = 2
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end
    elseif _ARG_0_.step == 2 then
      if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 4 then
        Entity.ClearSpeed(_ARG_0_.myHandle)
      else
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.workVec)
      end
      if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 13 then
        _ARG_0_:SetMotionEx_2(PLBBASE_COMMAND_SPECIAL2, _ARG_0_:GetGroupNum(PLBBASE_COMMAND_SPECIAL2), -1)
        _ARG_0_.step = 3
        Entity.ClearSpeed(_ARG_0_.myHandle)
        _ARG_0_.noReactionFlag = 1
      end
    elseif _ARG_0_.step == 3 then
      if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 4 then
        Entity.ClearSpeed(_ARG_0_.myHandle)
      else
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.workVec)
      end
      if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 34 then
        _ARG_0_:SetMotionEx_3(PLBBASE_COMMAND_SPECIAL2, _ARG_0_:GetGroupNum(PLBBASE_COMMAND_SPECIAL2), -1)
        _ARG_0_.step = 4
        CreateHandModel(_ARG_0_.myHandle)
        ChangeHandMotion(_ARG_0_.myHandle, _ARG_0_:GetMotion3(PLBBASE_COMMAND_SPECIAL2))
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
      end
    elseif _ARG_0_.step == 4 then
      if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 38 then
        _ARG_0_:SetMotionEx_4(PLBBASE_COMMAND_SPECIAL2, _ARG_0_:GetGroupNum(PLBBASE_COMMAND_SPECIAL2), -1)
        _ARG_0_.step = 5
        _ARG_0_.HitAttackFlag = 0
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
      end
    elseif _ARG_0_.step == 5 then
      Entity.EnableGravity(_ARG_0_.myHandle, 1)
      if _ARG_0_:isHitAttack() == 1 then
        workVec:set(0, 19, 0)
        Player.SetDamage(_ARG_0_.targetHandle, 0, ATK_KIND_DMG_TOSS, 0, 0, workVec)
        _ARG_0_.HitAttackFlag = 0
      end
      if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 20 then
        Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
        _ARG_0_.rot:sety(Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle))
        _ARG_0_.WorkVec:set(0, 0, 1)
        Math.RotateVectorXYZ(_ARG_0_.WorkVec, _ARG_0_.rot)
        _ARG_0_.WorkVec:scale(0.4)
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.WorkVec)
      end
      if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 1 then
        Entity.ClearSpeed(_ARG_0_.myHandle)
        _ARG_0_:SetMotionEx_5(PLBBASE_COMMAND_SPECIAL2, _ARG_0_:GetGroupNum(PLBBASE_COMMAND_SPECIAL2), -1)
        ChangeHandMotion(_ARG_0_.myHandle, _ARG_0_:GetMotion5(PLBBASE_COMMAND_SPECIAL2))
        _ARG_0_.step = 6
      end
    elseif _ARG_0_.step == 6 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
      Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
      Entity.LoopEndEffectAttach(_ARG_0_.keyHandle)
      DeleteModel(_ARG_0_.myHandle)
      _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
    end
  end
}
DarkVolley = {
  BeginState = function(_ARG_0_)
    _ARG_0_:SetMotionEx(PLBBASE_COMMAND_SPECIAL3, _ARG_0_:GetGroupNum(PLBBASE_COMMAND_SPECIAL3), 173)
    _ARG_0_.step = 0
    _ARG_0_.WorkTime = 0
    _ARG_0_.noReactionFlag = 1
    _ARG_0_.VolleyCnt = _ARG_0_.VolleyCnt + 1
    if _ARG_0_.VolleyCnt > 3 then
      _ARG_0_.VolleyFrame = 300
    end
  end,
  EndState = function(_ARG_0_)
    _ARG_0_.noReactionFlag = 0
  end,
  Update = function(_ARG_0_)
    Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
    if _ARG_0_.step == 0 then
      if Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10) == false then
        _ARG_0_.step = 1
      end
    elseif _ARG_0_.step == 1 then
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:SetMotionEx_1(PLBBASE_COMMAND_SPECIAL3, _ARG_0_:GetGroupNum(PLBBASE_COMMAND_SPECIAL3), -1)
        _ARG_0_.step = 2
      end
    elseif _ARG_0_.step == 2 then
      if 0 > _ARG_0_.WorkTime then
        _ARG_0_.WorkTime = _ARG_0_:GetWait(PLBBASE_COMMAND_SPECIAL3)
        _ARG_0_:CreateBulletEx(PLBBASE_COMMAND_SPECIAL3)
      end
      _ARG_0_.WorkTime = _ARG_0_.WorkTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:SetMotionEx_2(PLBBASE_COMMAND_SPECIAL3, _ARG_0_:GetGroupNum(PLBBASE_COMMAND_SPECIAL3), -1)
        _ARG_0_.step = 3
      end
    elseif _ARG_0_.step == 3 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
      Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
      _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
    end
  end
}
DarkVolleyLvMax = {
  BeginState = function(_ARG_0_)
    _ARG_0_:SetMotionEx(PLBBASE_COMMAND_SPECIAL6, _ARG_0_:GetGroupNum(PLBBASE_COMMAND_SPECIAL6), 173)
    _ARG_0_.step = 0
    _ARG_0_.WorkTime = 0
    _ARG_0_.noReactionFlag = 1
    _ARG_0_.VolleyCnt = _ARG_0_.VolleyCnt + 1
    if _ARG_0_.VolleyCnt > 3 then
      _ARG_0_.VolleyFrame = 300
    end
    Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
  end,
  EndState = function(_ARG_0_)
    _ARG_0_.GoseAppFlag = 0
    _ARG_0_.noReactionFlag = 0
  end,
  Update = function(_ARG_0_)
    Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
    _ARG_0_.WorkTime = _ARG_0_.WorkTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
    if _ARG_0_.step == 0 then
      if Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10) == false then
        _ARG_0_.step = 1
      end
    elseif _ARG_0_.step == 1 then
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:SetMotionEx_1(PLBBASE_COMMAND_SPECIAL6, _ARG_0_:GetGroupNum(PLBBASE_COMMAND_SPECIAL3), -1)
        _ARG_0_.step = 2
      end
    elseif _ARG_0_.step == 2 then
      if _ARG_0_.WorkTime < 0 then
        _ARG_0_.WorkTime = _ARG_0_:GetWait(PLBBASE_COMMAND_SPECIAL6)
        _ARG_0_:CreateBulletVolley(PLBBASE_COMMAND_SPECIAL6, 0)
      end
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:SetMotionEx_2(PLBBASE_COMMAND_SPECIAL6, _ARG_0_:GetGroupNum(PLBBASE_COMMAND_SPECIAL6), -1)
        _ARG_0_.step = 3
      end
    elseif _ARG_0_.step == 3 then
      if _ARG_0_.WorkTime < 0 then
        _ARG_0_.WorkTime = _ARG_0_:GetWait(PLBBASE_COMMAND_SPECIAL6)
        _ARG_0_:CreateBulletVolley(PLBBASE_COMMAND_SPECIAL6, 0)
      end
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:SetMotionEx_3(PLBBASE_COMMAND_SPECIAL6, _ARG_0_:GetGroupNum(PLBBASE_COMMAND_SPECIAL6), -1)
        _ARG_0_.step = 4
      end
    elseif _ARG_0_.step == 4 then
      if _ARG_0_.WorkTime < 0 then
        _ARG_0_.WorkTime = _ARG_0_:GetWait(PLBBASE_COMMAND_SPECIAL6)
        _ARG_0_:CreateBulletVolley(PLBBASE_COMMAND_SPECIAL6, 0)
      end
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:SetMotionEx_4(PLBBASE_COMMAND_SPECIAL6, _ARG_0_:GetGroupNum(PLBBASE_COMMAND_SPECIAL6), -1)
        _ARG_0_.step = 5
      end
    elseif _ARG_0_.step == 5 then
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:SetMotionEx_5(PLBBASE_COMMAND_SPECIAL6, _ARG_0_:GetGroupNum(PLBBASE_COMMAND_SPECIAL6), -1)
        _ARG_0_.step = 6
        Entity.SetTimer(_ARG_0_.myHandle, 60)
      end
    elseif _ARG_0_.step == 6 then
      if _ARG_0_.WorkTime < 0 then
        _ARG_0_.WorkTime = _ARG_0_:GetWait2(PLBBASE_COMMAND_SPECIAL6)
        _ARG_0_:CreateBulletVolley(PLBBASE_COMMAND_SPECIAL6, 1)
        _ARG_0_:CreateBulletVolley(PLBBASE_COMMAND_SPECIAL6, 2)
        _ARG_0_:CreateBulletVolley(PLBBASE_COMMAND_SPECIAL6, 3)
      end
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:SetMotionEx_6(PLBBASE_COMMAND_SPECIAL6, _ARG_0_:GetGroupNum(PLBBASE_COMMAND_SPECIAL6), -1)
        _ARG_0_.step = 7
      end
    elseif _ARG_0_.step == 7 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
      Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
      _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
    end
  end
}
UltimaCannon = {
  BeginState = function(_ARG_0_)
    print("UltimaCannon\n")
    _ARG_0_.WorkVec:set(0, 0, 0)
    _ARG_0_.workHandle = Entity.CreateEntity("b55ex00", _ARG_0_.WorkVec, _ARG_0_.WorkVec, _ARG_0_.myHandle)
    Entity.EnableLockonAndShooton(_ARG_0_.workHandle, 0)
    _ARG_0_:SetMotionEx(PLBBASE_COMMAND_SPECIAL4, _ARG_0_:GetGroupNum(PLBBASE_COMMAND_SPECIAL4), -1)
    Entity.AttachCoord(_ARG_0_.keyHandle, "Root", _ARG_0_.workHandle, "Root")
    _ARG_0_.keyModelOffFlag = 1
    Entity.SetMotionWithSameCheck(_ARG_0_.workHandle, _ARG_0_:GetMotion(PLBBASE_COMMAND_SPECIAL4), _ARG_0_:GetGroupNum(PLBBASE_COMMAND_SPECIAL4), -1)
    _ARG_0_.step = 0
    _ARG_0_.WorkNum = 0
    _ARG_0_.noReactionFlag = 1
  end,
  EndState = function(_ARG_0_)
    _ARG_0_.noReactionFlag = 0
    _ARG_0_.keyModelOffFlag = 0
  end,
  Update = function(_ARG_0_)
    Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
    if _ARG_0_.step == 0 then
      if Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10) == false then
        _ARG_0_.step = 1
      end
    elseif _ARG_0_.step == 1 then
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:SetMotionEx_1(PLBBASE_COMMAND_SPECIAL4, _ARG_0_:GetGroupNum(PLBBASE_COMMAND_SPECIAL4), 0)
        Entity.SetMotionWithSameCheck(_ARG_0_.workHandle, _ARG_0_:GetMotion1(PLBBASE_COMMAND_SPECIAL4), _ARG_0_:GetGroupNum(PLBBASE_COMMAND_SPECIAL4), -1)
        _ARG_0_.step = 2
      end
    elseif _ARG_0_.step == 2 then
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:SetMotionEx_2(PLBBASE_COMMAND_SPECIAL4, _ARG_0_:GetGroupNum(PLBBASE_COMMAND_SPECIAL4), 0)
        Entity.SetMotionWithSameCheck(_ARG_0_.workHandle, _ARG_0_:GetMotion2(PLBBASE_COMMAND_SPECIAL4), _ARG_0_:GetGroupNum(PLBBASE_COMMAND_SPECIAL4), -1)
        _ARG_0_.step = 3
      end
    elseif _ARG_0_.step == 3 then
      if _ARG_0_.WorkNum == 0 then
        _ARG_0_.WorkNum = 1
        _ARG_0_:CreateUltima(PLBBASE_COMMAND_SPECIAL4)
      end
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:SetMotionEx_3(PLBBASE_COMMAND_SPECIAL4, _ARG_0_:GetGroupNum(PLBBASE_COMMAND_SPECIAL4), 0)
        Entity.SetMotionWithSameCheck(_ARG_0_.workHandle, _ARG_0_:GetMotion3(PLBBASE_COMMAND_SPECIAL4), _ARG_0_:GetGroupNum(PLBBASE_COMMAND_SPECIAL4), -1)
        _ARG_0_.step = 4
      end
    elseif _ARG_0_.step == 4 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
      _ARG_0_.keyModelOffFlag = 0
      Entity.Out(_ARG_0_.workHandle)
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
Keal = {
  BeginState = function(_ARG_0_)
    _ARG_0_.step = 0
    _ARG_0_:SetMotionEx(PLBBASE_COMMAND_KEAL, _ARG_0_:GetGroupNum(PLBBASE_COMMAND_KEAL), -1)
  end,
  EndState = function(_ARG_0_)
  end,
  Update = function(_ARG_0_)
    if _ARG_0_.step == 0 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 16 then
      Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.keyHandle, 2)
      Entity.GetWorldPos(_ARG_0_.workVec, _ARG_0_.myHandle, 2)
      Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
      Entity.SetEffect(_ARG_0_.keyHandle, "m_ex_cu3_00", "P_MA_CU3_CUR0_0", _ARG_0_.myPos, _ARG_0_.rot)
      Enemy.AddHp(_ARG_0_.myHandle, _ARG_0_:GetRecoveryAmon(PLBBASE_COMMAND_KEAL))
      _ARG_0_.step = 1
    end
    if Entity.IsMotionEnd(_ARG_0_.myHandle) then
      _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
    end
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
    _ARG_0_.noReactionFlag = 1
  end,
  EndState = function(_ARG_0_)
    _ARG_0_:EndGuard()
    _ARG_0_.noReactionFlag = 0
  end,
  Update = function(_ARG_0_)
    if _ARG_0_.step == 0 then
      _ARG_0_.guardDelay = _ARG_0_.guardDelay - Entity.GetFrameRate(_ARG_0_.myHandle)
      if _ARG_0_.GuardFlag == 1 then
        if 0 > _ARG_0_.guardDelay then
          if Script.Random() < 0.3 then
            _ARG_0_:SetMotionEx(PLBBASE_COMMAND_ATTACKCOM1, _ARG_0_:GetGroupNum(PLBBASE_COMMAND_ATTACKCOM1), -1)
            _ARG_0_.step = 3
            Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
          elseif Script.Random() > 0.8 then
            if _ARG_0_:GetAttackRate1() == 1 then
              if _ARG_0_:RestHpRate() < _ARG_0_:GetChangeModeHPRate1() then
                _ARG_0_.stack:push("SpecialCommandAttack2")
              else
                _ARG_0_.stack:push("Combo")
              end
              return
            elseif _ARG_0_:GetAttackRate1() == 2 then
              _ARG_0_:SetMotionEx(PLBBASE_COMMAND_ATTACKCOM1, _ARG_0_:GetGroupNum(PLBBASE_COMMAND_ATTACKCOM1), -1)
              _ARG_0_:EndGuard()
              _ARG_0_.step = 2
              Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
              Entity.ClearSpeed(_ARG_0_.myHandle)
              return
            else
              if _ARG_0_:RestHpRate() < _ARG_0_:GetChangeModeHPRate1() then
                _ARG_0_.stack:push("SpecialCommandAttack4")
                _ARG_0_.stack:push("WarpMoveOut")
              else
                _ARG_0_.stack:push("Goes_away")
                _ARG_0_.step = 1
              end
              return
            end
          end
        end
      elseif _ARG_0_.GuardFlag == 0 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      end
    elseif _ARG_0_.step == 1 then
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      end
    elseif _ARG_0_.step == 2 then
      if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 38 then
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      end
    elseif _ARG_0_.step == 3 then
      if Entity.IsAttacking(_ARG_0_.targetHandle) then
        _ARG_0_.stack:push("BattleIdling")
        _ARG_0_.stack:push("SpecialCommandAttack7")
      end
      if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 38 then
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      end
    end
  end
}
Rockstorm = {
  BeginState = function(_ARG_0_)
    _ARG_0_:SetMotion(PLBBASE_COMMAND_BATTLEIDLING)
    _ARG_0_.step = 0
    Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 20)
    Entity.SetupModelFade(_ARG_0_.keyHandle, 1, 0, 20)
    Entity.GetWorldPos(workVec, _ARG_0_.myHandle, 1)
    Entity.GetRot(workVec1, _ARG_0_.myHandle)
    if Entity.GetName(_ARG_0_.myHandle) == "b51ex00" then
    end
    Entity.SetEffect(_ARG_0_.myHandle, "b50ex00", "B026_WRP_APP0_0", workVec, workVec1)
    Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
    _ARG_0_.BulletStep = _UPVALUE0_
    _ARG_0_.RockstormIndex = 0
    _ARG_0_.RockStormCount = 0
    _ARG_0_.noReactionFlag = 1
    _ARG_0_.oldShootLockNum = 0
  end,
  EndState = function(_ARG_0_)
    _ARG_0_.noReactionFlag = 1
    Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
    Entity.EnableLockon(_ARG_0_.myHandle, 1)
    Entity.EnableShooton(_ARG_0_.myHandle, 1)
    Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
    Entity.SetupModelFade(_ARG_0_.myHandle, 1, 1, 20)
    Entity.SetupModelFade(_ARG_0_.keyHandle, 1, 1, 20)
  end,
  Update = function(_ARG_0_)
    if _ARG_0_.step == _UPVALUE0_ then
      if Entity.IsModelFade(_ARG_0_.myHandle) == false then
        _ARG_0_.step = _UPVALUE1_
        _ARG_0_.targetPos:set(0, 0, 0)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
        Entity.SetLocalPos(_ARG_0_.myHandle, _ARG_0_.targetPos)
      end
    elseif _ARG_0_.step == _UPVALUE1_ then
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
      Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, 20)
      Entity.SetupModelFade(_ARG_0_.keyHandle, 0, 1, 20)
      Entity.GetWorldPos(workVec, _ARG_0_.myHandle, 1)
      Entity.GetRot(workVec1, _ARG_0_.myHandle)
      if Entity.GetName(_ARG_0_.myHandle) == "b51ex00" then
      end
      Entity.SetEffect(_ARG_0_.myHandle, "b50ex00", "B026_WRP_LST0_0", workVec, workVec1)
      _ARG_0_.step = _UPVALUE2_
      _ARG_0_:SetMotionEx(PLBBASE_COMMAND_SPECIAL5, _ARG_0_:GetGroupNum(PLBBASE_COMMAND_SPECIAL5), 171)
    elseif _ARG_0_.step == _UPVALUE2_ then
      if Entity.IsModelFade(_ARG_0_.myHandle) == false then
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        _ARG_0_.step = _UPVALUE3_
      end
    elseif _ARG_0_.step == _UPVALUE3_ then
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_.step = ROCKSTORM_STEP_ATTACK
        _ARG_0_.BulletStep = _UPVALUE4_
        _ARG_0_.BulletTime = 90
        Camera.QuakeV(80, 0.2, 20)
      end
    elseif _ARG_0_.step == ROCKSTORM_STEP_ATTACK then
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:SetMotion(PLBBASE_COMMAND_BATTLEIDLING)
        _ARG_0_.step = _UPVALUE5_
        Entity.SetTimer(_ARG_0_.myHandle, 1200)
      end
    elseif _ARG_0_.step == _UPVALUE5_ then
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
      if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 36 or Entity.GetUserShootLocked(_ARG_0_.myHandle) ~= _ARG_0_.oldShootLockNum then
        _ARG_0_.step = _UPVALUE6_
      end
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_.step = _UPVALUE7_
      end
      _ARG_0_.oldShootLockNum = Entity.GetUserShootLocked(_ARG_0_.myHandle)
    elseif _ARG_0_.step == _UPVALUE6_ then
      Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 20)
      Entity.SetupModelFade(_ARG_0_.keyHandle, 1, 0, 20)
      Entity.GetWorldPos(workVec, _ARG_0_.myHandle, 1)
      Entity.GetRot(workVec1, _ARG_0_.myHandle)
      if Entity.GetName(_ARG_0_.myHandle) == "b51ex00" then
      end
      Entity.SetEffect(_ARG_0_.myHandle, "b50ex00", "B026_WRP_APP0_0", workVec, workVec1)
      Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
      _ARG_0_.step = _UPVALUE8_
    elseif _ARG_0_.step == _UPVALUE8_ then
      if Entity.IsModelFade(_ARG_0_.myHandle) == false then
        _ARG_0_.step = _UPVALUE9_
        Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
        _ARG_0_.WorkVec:set(0, 0, 0)
        _ARG_0_.targetPos:setx(_ARG_0_.WorkVec:getx() + (9 * Script.Random() + 5) * Math.Cos((RoundPI(Script.Random() * 2 * PI))))
        _ARG_0_.targetPos:setz(_ARG_0_.WorkVec:getz() + (9 * Script.Random() + 5) * Math.Sin((RoundPI(Script.Random() * 2 * PI))))
        Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.targetHandle)
        Collision.IntersectRayBg(_ARG_0_.targetPos, COLL_KIND_ENEMY, _ARG_0_.WorkVec, _ARG_0_.targetPos)
        Entity.SetLocalPos(_ARG_0_.myHandle, _ARG_0_.targetPos)
      end
    elseif _ARG_0_.step == _UPVALUE9_ then
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
      Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, 20)
      Entity.SetupModelFade(_ARG_0_.keyHandle, 0, 1, 20)
      Entity.GetWorldPos(workVec, _ARG_0_.myHandle, 1)
      Entity.GetRot(workVec1, _ARG_0_.myHandle)
      if Entity.GetName(_ARG_0_.myHandle) == "b51ex00" then
      end
      Entity.SetEffect(_ARG_0_.myHandle, "b50ex00", "B026_WRP_LST0_0", workVec, workVec1)
      _ARG_0_.step = _UPVALUE5_
      Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
    elseif _ARG_0_.step == _UPVALUE7_ and Entity.IsTimeOver(_ARG_0_.myHandle) then
      _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
    end
    _ARG_0_.BulletTime = _ARG_0_.BulletTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
    if _ARG_0_.BulletStep == _UPVALUE10_ then
    elseif _ARG_0_.BulletStep == _UPVALUE11_ then
      if 0 > _ARG_0_.BulletTime then
        _ARG_0_.BulletStep = _UPVALUE12_
      end
    elseif _ARG_0_.BulletStep == _UPVALUE12_ then
      _ARG_0_:CreateRockStorm(PLBBASE_COMMAND_SPECIAL5, _ARG_0_.RockstormIndex)
      print("Number:" .. _ARG_0_.RockstormIndex .. " Create\n")
      Camera.QuakeV(50, 0.1 - 0.2 / Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle), 10)
      _ARG_0_.BulletTime = 40
      _ARG_0_.RockstormIndex = _ARG_0_.RockstormIndex + 1
      if _ARG_0_.RockstormIndex > 7 then
        _ARG_0_.BulletStep = _UPVALUE13_
        _ARG_0_.BulletTime = 90
        _ARG_0_.RockstormIndex = 0
      else
        _ARG_0_.BulletStep = _UPVALUE11_
      end
    elseif _ARG_0_.BulletStep == _UPVALUE13_ then
      if 0 > _ARG_0_.BulletTime then
        _ARG_0_.BulletTime = 20
        _ARG_0_.BulletStep = _UPVALUE14_
      end
    elseif _ARG_0_.BulletStep == _UPVALUE14_ then
      if 0 > _ARG_0_.BulletTime then
        EntityManager:GetEntity(_ARG_0_.RockstormBullet[_ARG_0_.RockstormIndex].handle).step = 2
        _ARG_0_.RockstormIndex = _ARG_0_.RockstormIndex + 1
        if _ARG_0_.RockstormIndex > _ARG_0_:GetBulletNum() - 1 then
          _ARG_0_.BulletStep = _UPVALUE15_
          _ARG_0_.RockstormIndex = 0
        else
          _ARG_0_.BulletStep = _UPVALUE13_
        end
      end
    elseif _ARG_0_.BulletStep == _UPVALUE16_ then
    elseif _ARG_0_.BulletStep == _UPVALUE15_ then
      _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
    elseif _ARG_0_.BulletStep == _UPVALUE4_ and 0 > _ARG_0_.BulletTime then
      _ARG_0_.BulletStep = _UPVALUE11_
    end
  end
}
function chackBulletStep(_ARG_0_)
  for _FORV_5_ = 0, 7 do
  end
  return nil
end
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
