setmetatable({
  new = function(_ARG_0_)
    return setmetatable(__StateMachine:new(), _UPVALUE0_)
  end,
  states = {
    Appear = {
      OnBeginState = function(_ARG_0_)
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableLockon(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:GotoState("Idling")
      end
    },
    Idling = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":Idling\n")
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_.IdlingTime + Script.Random() * _UPVALUE0_.IdlingTime)
        if _UPVALUE0_.KeyMode == _UPVALUE1_ then
          _ARG_0_:setMotion(_UPVALUE2_)
        else
          _ARG_0_:setMotion(_UPVALUE3_)
        end
        if Entity.HasNetGameHandle(_ARG_0_.myHandle) then
          if Enemy.IsNetworkMaster(_ARG_0_.myHandle) == false then
          else
            _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
            _ARG_0_.targetHandle = _ARG_0_:PlayersNimHP(_ARG_0_.targetHandle, Player.GetPlayers())
          end
        else
          _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        end
        Keybraid = EntityManager:GetEntity(_ARG_0_.ShieldHandle)
        Keybraid.targetHandle = _ARG_0_.targetHandle
        Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          if _UPVALUE0_.KeyMode == _UPVALUE1_ then
            _ARG_0_:SetingState_Air()
          else
            Entity.EnableGravity(_ARG_0_.myHandle, 1)
            _ARG_0_:SetingState()
            if _ARG_0_:Defense() == true then
              return
            end
            if _ARG_0_:IsPlShootShot() then
              _ARG_0_.stack:push("Idling")
              _ARG_0_.stack:push("SonicImpact")
              _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
              return
            end
            if _ARG_0_:IsPlShootShot() then
              if Script.Random() < 0.5 then
                _ARG_0_.stack:push("Guard")
              end
              if Script.Random() < 0.3 then
                _ARG_0_.stack:push("Goes_away")
              elseif Script.Random() < 0.3 then
                _ARG_0_.stack:push("Parry")
              end
              if 1 == 1 then
                _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
              end
              return
            end
          end
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Approache = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":Approache\n")
        _ARG_0_:setMotion(_UPVALUE0_)
        _ARG_0_.step = 0
        Entity.SetTimer(_ARG_0_.myHandle, 300)
        _ARG_0_.Speed = 0
        _ARG_0_.anglePow = 4
        if Enemy.IsNetworkMaster(_ARG_0_.myHandle) == false then
        else
          _ARG_0_.targetHandle = _ARG_0_:PlayersNimHP(_ARG_0_.targetHandle, Player.GetPlayers())
        end
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if Player.IsDamageFlagDead(_ARG_0_.targetHandle) ~= true or Enemy.IsNetworkMaster(_ARG_0_.myHandle) == false then
        else
          _ARG_0_.targetHandle = _ARG_0_:PlayersNimHP(_ARG_0_.targetHandle, Player.GetPlayers())
        end
        if _ARG_0_:IsPlShootShot() then
          _ARG_0_.stack:push("Idling")
          _ARG_0_.stack:push("SonicImpact")
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          return
        end
        if _ARG_0_.step == 0 then
          Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, _ARG_0_.anglePow)
          _ARG_0_.anglePow = _ARG_0_.anglePow + 0.1
          if _ARG_0_.anglePow > 10 then
            _ARG_0_.anglePow = 10
          end
          _ARG_0_:MoveEx(_UPVALUE0_.RunSpeed, 0.1)
          if Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 4 then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
          if _ARG_0_:CheckAirMovePos(2) == 1 or _ARG_0_:CheckAirMovePos(3) == 1 then
            Entity.SetTimer(_ARG_0_.myHandle, 300)
            _ARG_0_.step = 1
          end
          if _ARG_0_:CheckAirMovePos_ForTarget(8) == 1 then
            _ARG_0_.stack:push("Idling")
            _ARG_0_.stack:push("Appending_InWing")
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        elseif _ARG_0_.step == 1 then
          _ARG_0_:MoveEx(_UPVALUE0_.RunSpeed, 0.1)
          _UPVALUE1_:set(0, 0, 10)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE1_, 4)
          if Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _UPVALUE1_) < 36 then
            Entity.SetTimer(_ARG_0_.myHandle, 300)
            _ARG_0_.step = 0
          end
        end
      end
    },
    Goes_away = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":Goes_away\n")
        _ARG_0_:setMotion(_UPVALUE0_)
        _ARG_0_.step = 0
        Entity.SetTimer(_ARG_0_.myHandle, 20)
        _ARG_0_.Speed = 0
        _ARG_0_.SpeedZ = -0.5
        Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
        _UPVALUE1_:sety(Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle))
        Entity.SetRot(_ARG_0_.myHandle, _UPVALUE1_)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:BackMove(0.1, 0.1)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    AirMove = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":AirMove\n")
        if _UPVALUE0_.KeyMode == _UPVALUE1_ then
          _ARG_0_:setMotion(_UPVALUE2_)
          _ARG_0_.step = 0
          _ARG_0_.Speed = 0.45
        else
          _ARG_0_:setAppend(_UPVALUE1_)
          _ARG_0_:setMotion(_UPVALUE3_)
          _ARG_0_.step = -1
        end
        Entity.SetTimer(_ARG_0_.myHandle, 300)
        _ARG_0_.Speed = 0
        Entity.EnableGravity(_ARG_0_.myHandle, 0)
        _ARG_0_.TripNumber = 1
        _ARG_0_.homingAddAngle = 0
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        _ARG_0_:TurnX(0, 180, 0)
        _ARG_0_:TurnZ(0, 180, 0)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == -1 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_:setMotion(_UPVALUE0_)
            _ARG_0_.step = 0
            _ARG_0_.Speed = 0.45
          end
        elseif _ARG_0_.step == 0 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > _UPVALUE1_.StartAir then
            _ARG_0_:SpeedDlown(_UPVALUE1_.AirSpeed, 0.001)
            Entity.CalcVelocity(_ARG_0_.myHandle, _ARG_0_.Speed)
          end
          Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.myHandle)
          if _UPVALUE2_:gety() > 6 and _UPVALUE2_:gety() < 7 then
            _UPVALUE3_:set(0, 0, 10)
            _UPVALUE3_:set(0, 0, -20)
            if Entity.CalcDistanceSq(_ARG_0_.targetHandle, _UPVALUE3_) > Entity.CalcDistanceSq(_ARG_0_.targetHandle, _UPVALUE3_) then
              _ARG_0_.step = 2
              _ARG_0_:SetTargetPos(7)
            else
              _ARG_0_.step = 1
            end
          end
          if _UPVALUE2_:gety() > 5 then
            if _ARG_0_:TurnX(20, 2, 90) == false then
              _ARG_0_.step = 1
            end
          elseif _ARG_0_:TurnX(-28, 1, 90) == false then
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          _ARG_0_:SpeedDlown(_UPVALUE1_.AirSpeed, 0.001)
          Entity.CalcVelocity(_ARG_0_.myHandle, _ARG_0_.Speed)
          _ARG_0_:TurnX(0, 1, 180)
          _UPVALUE3_:set(0, 0, 10)
          _ARG_0_.homingAddAngle = _ARG_0_.homingAddAngle + 0.05 * Entity.GetFrameRate(_ARG_0_.myHandle)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE3_, 4.5 + _ARG_0_.homingAddAngle)
          _ARG_0_:SetTruns()
          if Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _UPVALUE3_) < 9 then
            Entity.SetTimer(_ARG_0_.myHandle, 300)
            _ARG_0_.step = 2
            _ARG_0_.homingAddAngle = 0
            _ARG_0_:SetTargetPos(7)
            _ARG_0_:GotoState("Air_ToIdling")
          end
        elseif _ARG_0_.step == 2 then
          _ARG_0_:SpeedDlown(_UPVALUE1_.AirSpeed, 0.001)
          Entity.CalcVelocity(_ARG_0_.myHandle, _ARG_0_.Speed)
          _ARG_0_:TurnX(0, 1, 180)
          _UPVALUE3_:set(_ARG_0_.targetPos:getx(), _ARG_0_.targetPos:gety(), _ARG_0_.targetPos:getz())
          _ARG_0_:SetTruns()
          _ARG_0_.homingAddAngle = _ARG_0_.homingAddAngle + 0.05 * Entity.GetFrameRate(_ARG_0_.myHandle)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 4 + _ARG_0_.homingAddAngle)
          if Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetPos) < 36 then
            Entity.SetTimer(_ARG_0_.myHandle, 300)
            _ARG_0_.step = 1
            _ARG_0_.TripNumber = _ARG_0_.TripNumber - 1
            _ARG_0_.homingAddAngle = 0
            _ARG_0_:GotoState("Air_ToIdling")
          end
          if _ARG_0_:CheckAirMovePos_ForAir(2) == 1 or _ARG_0_:CheckAirMovePos_ForAir(3) == 1 then
            Entity.SetTimer(_ARG_0_.myHandle, 300)
            _ARG_0_.step = 1
            _ARG_0_.TripNumber = _ARG_0_.TripNumber - 1
            _ARG_0_.homingAddAngle = 0
          end
        elseif _ARG_0_.step == 3 then
          _ARG_0_:TurnX(0, 180, 0)
          _ARG_0_:TurnZ(0, 180, 0)
          _ARG_0_:SpeedDlown(0, 0.01)
          Entity.CalcVelocity(_ARG_0_.myHandle, _ARG_0_.Speed)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        end
      end
    },
    ApproacheAirMove = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":ApproacheAirMove\n")
        if _UPVALUE0_.KeyMode == _UPVALUE1_ then
          _ARG_0_:setMotion(_UPVALUE2_)
          _ARG_0_.step = 0
          _ARG_0_.Speed = 0.45
        else
          _ARG_0_:setAppend(_UPVALUE1_)
          _ARG_0_:setMotion(_UPVALUE3_)
          _ARG_0_.step = -1
        end
        Entity.SetTimer(_ARG_0_.myHandle, 300)
        _ARG_0_.Speed = 0
        Entity.EnableGravity(_ARG_0_.myHandle, 0)
        _ARG_0_.TripNumber = Script.Random() + 0
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == -1 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_:setMotion(_UPVALUE0_)
            _ARG_0_.step = 0
            _ARG_0_.Speed = 0.45
          end
        elseif _ARG_0_.step == 0 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > _UPVALUE1_.StartAir then
            _ARG_0_:SpeedDlown(_UPVALUE1_.AirSpeed, 0.001)
            Entity.CalcVelocity(_ARG_0_.myHandle, _ARG_0_.Speed)
          end
          Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.myHandle)
          if _UPVALUE2_:gety() > 6 and _UPVALUE2_:gety() < 7 then
            _UPVALUE3_:set(0, 0, 10)
            _UPVALUE3_:set(0, 0, -20)
            if Entity.CalcDistanceSq(_ARG_0_.targetHandle, _UPVALUE3_) > Entity.CalcDistanceSq(_ARG_0_.targetHandle, _UPVALUE3_) then
              _ARG_0_.step = 2
              _ARG_0_:SetTargetPos(7)
              print("next step = 2")
            else
              _ARG_0_.step = 1
              print("next step = 1")
            end
          end
          if _UPVALUE2_:gety() > 5 then
            if _ARG_0_:TurnX(20, 2, 90) == false then
              _UPVALUE3_:set(0, 0, 10)
              _UPVALUE3_:set(0, 0, -20)
              if Entity.CalcDistanceSq(_ARG_0_.targetHandle, _UPVALUE3_) > Entity.CalcDistanceSq(_ARG_0_.targetHandle, _UPVALUE3_) then
                _ARG_0_.step = 2
                _ARG_0_:SetTargetPos(7)
                print("next step = 2")
              else
                _ARG_0_.step = 1
                print("next step = 1")
              end
            end
          elseif _ARG_0_:TurnX(-28, 1, 90) == false then
            _UPVALUE3_:set(0, 0, 10)
            _UPVALUE3_:set(0, 0, -20)
            if Entity.CalcDistanceSq(_ARG_0_.targetHandle, _UPVALUE3_) > Entity.CalcDistanceSq(_ARG_0_.targetHandle, _UPVALUE3_) then
              _ARG_0_.step = 2
              _ARG_0_:SetTargetPos(7)
              _ARG_0_.targetPos:sety(_ARG_0_.targetPos:gety() + Script.Random() * 10)
              print("next step = 2")
            else
              _ARG_0_.step = 1
              print("next step = 1")
            end
          end
        elseif _ARG_0_.step == 1 then
          _ARG_0_:SpeedDlown(_UPVALUE1_.AirSpeed, 0.001)
          Entity.CalcVelocity(_ARG_0_.myHandle, _ARG_0_.Speed)
          _ARG_0_:TurnX(0, 1, 180)
          _UPVALUE3_:set(0, 0, 10)
          _ARG_0_.homingAddAngle = _ARG_0_.homingAddAngle + 0.05 * Entity.GetFrameRate(_ARG_0_.myHandle)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 4 + _ARG_0_.homingAddAngle)
          _ARG_0_:SetTruns()
          if Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _UPVALUE3_) < 42.25 then
            Entity.SetTimer(_ARG_0_.myHandle, 300)
            _ARG_0_.step = 2
            _ARG_0_:SetTargetPos(7)
            _ARG_0_.TripNumber = _ARG_0_.TripNumber - 1
            _ARG_0_:GotoState("Air_ToIdling")
          end
        elseif _ARG_0_.step == 2 then
          _ARG_0_:SpeedDlown(_UPVALUE1_.AirSpeed, 0.001)
          Entity.CalcVelocity(_ARG_0_.myHandle, _ARG_0_.Speed)
          _ARG_0_:TurnX(0, 1, 180)
          _UPVALUE3_:set(_ARG_0_.targetPos:getx(), _ARG_0_.targetPos:gety(), _ARG_0_.targetPos:getz())
          _ARG_0_:SetTruns()
          _ARG_0_:SetTargetPos(7)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 4)
          print("dist = " .. Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetPos) .. "\n")
          if Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetPos) < 42.25 then
            Entity.SetTimer(_ARG_0_.myHandle, 300)
            _ARG_0_:GotoState("Air_ToIdling")
          end
          if _ARG_0_:CheckAirMovePos_ForGoes_away(2) == 1 or _ARG_0_:CheckAirMovePos_ForGoes_away(3) == 1 then
            Entity.SetTimer(_ARG_0_.myHandle, 300)
            _ARG_0_.step = 1
            _ARG_0_:SetTargetPos(0)
            print("next step = 1")
            _ARG_0_.TripNumber = _ARG_0_.TripNumber + 1
          end
        end
      end
    },
    Goes_awayAirMove = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":Goes_awayAirMove\n")
        if _UPVALUE0_.KeyMode == _UPVALUE1_ then
          _ARG_0_:setMotion(_UPVALUE2_)
          _ARG_0_.step = 0
          _ARG_0_.Speed = 0.45
        else
          _ARG_0_:setAppend(_UPVALUE1_)
          _ARG_0_:setMotion(_UPVALUE3_)
          _ARG_0_.step = -1
        end
        Entity.SetTimer(_ARG_0_.myHandle, 300)
        _ARG_0_.Speed = 0
        Entity.EnableGravity(_ARG_0_.myHandle, 0)
        _ARG_0_.TripNumber = Script.Random()
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == -1 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_:setMotion(_UPVALUE0_)
            _ARG_0_.step = 0
            _ARG_0_.Speed = 0.45
          end
        elseif _ARG_0_.step == 0 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > _UPVALUE1_.StartAir then
            _ARG_0_:SpeedDlown(_UPVALUE1_.AirSpeed, 0.001)
            Entity.CalcVelocity(_ARG_0_.myHandle, _ARG_0_.Speed)
          end
          Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.myHandle)
          if _UPVALUE2_:gety() > 6 and _UPVALUE2_:gety() < 7 then
            _UPVALUE3_:set(0, 0, 10)
            _UPVALUE3_:set(0, 0, -20)
            if Entity.CalcDistanceSq(_ARG_0_.targetHandle, _UPVALUE3_) > Entity.CalcDistanceSq(_ARG_0_.targetHandle, _UPVALUE3_) then
              _ARG_0_.step = 2
              _ARG_0_:SetTargetPos(7)
            else
              _ARG_0_.step = 1
            end
          end
          if _UPVALUE2_:gety() > 5 then
            if _ARG_0_:TurnX(20, 2, 90) == false then
              _UPVALUE3_:set(0, 0, 10)
              _UPVALUE3_:set(0, 0, -20)
              if Entity.CalcDistanceSq(_ARG_0_.targetHandle, _UPVALUE3_) < Entity.CalcDistanceSq(_ARG_0_.targetHandle, _UPVALUE3_) then
                _ARG_0_.step = 2
                _ARG_0_:SetTargetPos(7)
              else
                _ARG_0_.step = 1
              end
            end
          elseif _ARG_0_:TurnX(-28, 1, 90) == false then
            _UPVALUE3_:set(0, 0, 10)
            _UPVALUE3_:set(0, 0, -20)
            if Entity.CalcDistanceSq(_ARG_0_.targetHandle, _UPVALUE3_) < Entity.CalcDistanceSq(_ARG_0_.targetHandle, _UPVALUE3_) then
              _ARG_0_.step = 2
              _ARG_0_:SetTargetPos(7)
            else
              _ARG_0_.step = 1
            end
          end
        elseif _ARG_0_.step == 1 then
          _ARG_0_:SpeedDlown(_UPVALUE1_.AirSpeed, 0.001)
          Entity.CalcVelocity(_ARG_0_.myHandle, _ARG_0_.Speed)
          _ARG_0_:TurnX(0, 1, 180)
          _UPVALUE3_:set(0, 0, 10)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE3_, 4.5)
          _ARG_0_:SetTruns()
          if Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _UPVALUE3_) < 42.25 then
            Entity.SetTimer(_ARG_0_.myHandle, 300)
            _ARG_0_.step = 2
            _ARG_0_:SetTargetPos(7)
            _ARG_0_.TripNumber = _ARG_0_.TripNumber - 1
            _ARG_0_:GotoState("Air_ToIdling")
          end
        elseif _ARG_0_.step == 2 then
          _ARG_0_:SpeedDlown(_UPVALUE1_.AirSpeed, 0.001)
          Entity.CalcVelocity(_ARG_0_.myHandle, _ARG_0_.Speed)
          _ARG_0_:TurnX(0, 1, 180)
          _UPVALUE3_:set(_ARG_0_.targetPos:getx(), _ARG_0_.targetPos:gety(), _ARG_0_.targetPos:getz())
          _ARG_0_:SetTruns()
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 4)
          if Entity.IsTimeOver(_ARG_0_.myHandle) or 42.25 > Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetPos) then
            Entity.SetTimer(_ARG_0_.myHandle, 300)
            _ARG_0_.step = 1
            _ARG_0_.TripNumber = _ARG_0_.TripNumber - 1
            _ARG_0_:GotoState("Air_ToIdling")
          end
          if _ARG_0_:CheckAirMovePos_ForGoes_away(2) == 1 or _ARG_0_:CheckAirMovePos_ForGoes_away(3) == 1 then
            Entity.SetTimer(_ARG_0_.myHandle, 300)
            _ARG_0_.step = 1
            _ARG_0_.TripNumber = _ARG_0_.TripNumber + 1
          end
        elseif _ARG_0_.step == 4 then
        end
      end
    },
    Air_ToIdling = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":Air_ToIdling\n")
        _ARG_0_:setMotion(_UPVALUE0_)
        _ARG_0_.step = 0
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_.AirIlidng + Script.Random() * _UPVALUE1_.AirIlidng)
        _ARG_0_:setMotion(_UPVALUE2_)
        Entity.EnableGravity(_ARG_0_.myHandle, 0)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        _ARG_0_:TurnX(0, 180, 0)
        _ARG_0_:TurnZ(0, 180, 0)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:TurnX(0, 180, 0)
        _ARG_0_:TurnZ(0, 180, 0)
        _ARG_0_:SpeedDlown(0, 0.01)
        Entity.CalcVelocity(_ARG_0_.myHandle, _ARG_0_.Speed)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    RightTrun = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":RightTrun\n")
        _ARG_0_:setMotion(_UPVALUE0_)
        _ARG_0_.step = 0
        Entity.SetTimer(_ARG_0_.myHandle, 120)
        _ARG_0_.Speed = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
        _UPVALUE0_:sety(_UPVALUE0_:gety() - DegToRad(_UPVALUE1_.TrunPow))
        Entity.SetRot(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_:MoveEx(_UPVALUE1_.WalkSpeed / 2, 0.1)
        _UPVALUE2_:set(0, 1, 0)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:checkApproacheToSonicImpact()
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
        if Entity.IsTargetWithinFOV(_ARG_0_.myHandle, _ARG_0_.targetHandle, DegToRad(_UPVALUE1_.TrunFOV), 36, _UPVALUE2_) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    LeftTrun = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":LeftTrun\n")
        _ARG_0_:setMotion(_UPVALUE0_)
        _ARG_0_.step = 0
        Entity.SetTimer(_ARG_0_.myHandle, 120)
        _ARG_0_.Speed = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
        _UPVALUE0_:sety(_UPVALUE0_:gety() + DegToRad(_UPVALUE1_.TrunPow))
        Entity.SetRot(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_:MoveEx(_UPVALUE1_.WalkSpeed / 2, 0.1)
        _UPVALUE2_:set(0, 1, 0)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:checkApproacheToSonicImpact()
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
        if Entity.IsTargetWithinFOV(_ARG_0_.myHandle, _ARG_0_.targetHandle, DegToRad(_UPVALUE1_.TrunFOV), 36, _UPVALUE2_) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    FallToLanding = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":FallToLanding\n")
        _ARG_0_.step = 0
        if Entity.IsGround(_ARG_0_.myHandle) == true then
          Entity.ClearSpeed(_ARG_0_.myHandle)
          _ARG_0_:setMotion(_UPVALUE0_)
          _ARG_0_.step = 1
        else
          _ARG_0_:setMotion(_UPVALUE1_)
        end
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsGround(_ARG_0_.myHandle) == true then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_:setMotion(_UPVALUE0_)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Appending_InKeyBlade = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":Appending_InKeyBlade\n")
        SetAppendAndMotion(_ARG_0_, _UPVALUE0_, _UPVALUE1_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        CheckAppendEnd(_ARG_0_)
      end
    },
    Appending_InArm = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":Appending_InArm\n")
        SetAppendAndMotion(_ARG_0_, _UPVALUE0_, _UPVALUE1_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        CheckAppendEnd(_ARG_0_)
      end
    },
    Appending_InLeg = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":Appending_InFoot\n")
        SetAppendAndMotion(_ARG_0_, _UPVALUE0_, _UPVALUE1_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        CheckAppendEnd(_ARG_0_)
      end
    },
    Appending_InWing = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":Appending_InWing\n")
        SetAppendAndMotion(_ARG_0_, _UPVALUE0_, _UPVALUE1_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        CheckAppendEnd(_ARG_0_)
      end
    },
    Appending_Shield = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":Appending_Shield\n")
        SetAppendAndMotion(_ARG_0_, _UPVALUE0_, _UPVALUE1_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        CheckAppendEnd(_ARG_0_)
      end
    },
    KeyBalazs = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":KeyBalazs\n")
        _ARG_0_:setMotion(_UPVALUE0_)
        _ARG_0_.step = 0
        _ARG_0_.balazsStep = 0
        _ARG_0_.time = 0
        _ARG_0_.balazsStep2 = 0
        _UPVALUE1_:set(0, 0, 0)
        _ARG_0_.attackFlag = _ARG_0_.attackFlag + 1
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 20 then
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          _ARG_0_.time = _ARG_0_.time - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 >= _ARG_0_.time then
            _UPVALUE3_:set(Script.Random() * _UPVALUE0_ - _UPVALUE0_ / 2 + (Script.Random() * 1 - 0.5), Script.Random() * _UPVALUE1_ + _UPVALUE2_ + Script.Random() * 1, _UPVALUE4_ + (Script.Random() * 2 - 1))
            Entity.GetWorldPos(_UPVALUE5_, _ARG_0_.targetHandle, 2)
            Entity.GetWorldPos(_UPVALUE6_, _ARG_0_.myHandle, 2)
            _UPVALUE6_:setx(0)
            _UPVALUE6_:sety(2)
            _UPVALUE6_:setz(-2.2)
            _UPVALUE3_:set(_UPVALUE6_:getx(), _UPVALUE6_:gety(), _UPVALUE6_:getz())
            _UPVALUE7_:setx(3 * Script.Random() * Math.Cos((RoundPI(Script.Random() * 2 * PI))))
            _UPVALUE7_:sety(3 * Script.Random() * Math.Sin((RoundPI(Script.Random() * 2 * PI))))
            _UPVALUE7_:setz(0)
            Entity.GetRot(_UPVALUE8_, _ARG_0_.myHandle)
            Math.RotateVectorXYZ(_UPVALUE7_, _UPVALUE8_)
            Math.RotateVectorXYZ(_UPVALUE3_, _UPVALUE8_)
            FVECTOR3.Add(_UPVALUE3_, _UPVALUE3_, _UPVALUE7_)
            Entity.GetWorldPos(_UPVALUE6_, _ARG_0_.myHandle, 2)
            _UPVALUE3_:set(_UPVALUE3_:getx() + _UPVALUE6_:getx(), _UPVALUE3_:gety() + _UPVALUE6_:gety(), _UPVALUE3_:getz() + _UPVALUE6_:getz())
            Entity.GetRot(_UPVALUE9_, _ARG_0_.myHandle)
            _ARG_0_:CreateKeyBalazs(_ARG_0_.myHandle, _UPVALUE10_)
            _ARG_0_.time = 2
            if 4 <= _ARG_0_.balazsStep2 then
              _ARG_0_.balazsStep2 = 0
              _ARG_0_.time = 240
              _ARG_0_.step = 2
            end
            _ARG_0_.balazsStep2 = _ARG_0_.balazsStep2 + 1
          end
        elseif _ARG_0_.step == 2 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
            return
          end
          _ARG_0_.time = _ARG_0_.time - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 >= _ARG_0_.time then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        end
      end
    },
    KeyBalazs2 = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":KeyBalazs2\n")
        _ARG_0_:setMotion(_UPVALUE0_)
        _ARG_0_.step = 0
        _ARG_0_.balazsStep = 0
        _ARG_0_.balazsStep2 = 0
        _ARG_0_.time = 0
        _UPVALUE1_:set(0, 0, 0)
        Entity.SetTimer(_ARG_0_.myHandle, 240)
        _UPVALUE2_.OutFlag = 0
        _ARG_0_.attackFlag = _ARG_0_.attackFlag + 1
        if Player.GetNetworkID(_ARG_0_.targetHandle) == 0 or Player.GetNetworkID(_ARG_0_.targetHandle) == 255 then
          if Player.IsMuteki(_ARG_0_.targetHandle) or Player.GetPlayerState(_ARG_0_.targetHandle) == PLAYER_STATE_GUARD then
            _ARG_0_.step = 2
          elseif Entity.GetCurrentMotion(_ARG_0_.targetHandle) == Entity.GetMotionIndex(_ARG_0_.targetHandle, "006") or Entity.GetCurrentMotion(_ARG_0_.targetHandle) == Entity.GetMotionIndex(_ARG_0_.targetHandle, "206") or Entity.GetCurrentMotion(_ARG_0_.targetHandle) == Entity.GetMotionIndex(_ARG_0_.targetHandle, "204") or Entity.GetCurrentMotion(_ARG_0_.targetHandle) == Entity.GetMotionIndex(_ARG_0_.targetHandle, "202") then
            Player.SetDamage(_ARG_0_.targetHandle, 0, ATK_KIND_GATHERING)
            Entity.GetWorldPos(_UPVALUE3_, _ARG_0_.targetHandle, 1)
            _UPVALUE4_:set(0, 0, 0)
            _ARG_0_.effectHandle2 = Entity.SetEffect(_ARG_0_.myHandle, "b85vs00", "B085_AAR_GRA0_0", _UPVALUE3_, _UPVALUE4_)
            Entity.GetWorldPos(_UPVALUE3_, _ARG_0_.targetHandle, 1)
            _UPVALUE4_:set(0, 0, 0)
            _ARG_0_.effectHandle3 = Entity.SetEffect(_ARG_0_.myHandle, "b85vs00", "B085_KBA_EXP2_0", _UPVALUE3_, _UPVALUE4_)
          end
        end
      end,
      OnEndState = function(_ARG_0_)
        if Entity.GetCurrentMotion(_ARG_0_.targetHandle) == Entity.GetMotionIndex(_ARG_0_.targetHandle, "006") or Entity.GetCurrentMotion(_ARG_0_.targetHandle) == Entity.GetMotionIndex(_ARG_0_.targetHandle, "206") or Entity.GetCurrentMotion(_ARG_0_.targetHandle) == Entity.GetMotionIndex(_ARG_0_.targetHandle, "204") or Entity.GetCurrentMotion(_ARG_0_.targetHandle) == Entity.GetMotionIndex(_ARG_0_.targetHandle, "202") then
          Player.SetDamage(_ARG_0_.targetHandle, Player.CalcDamagePoint(_ARG_0_.targetHandle, Enemy.GetAttackPoint(_ARG_0_.myHandle, 20), (Enemy.GetAttackPowerCorrection(_ARG_0_.myHandle, 20))), ATK_KIND_DMG_BLOW)
          Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.targetHandle, 1)
          _UPVALUE1_:set(0, 0, 0)
          Entity.SetEffect(_ARG_0_.myHandle, "b85vs00", "B085_KBA_EXP1_0", _UPVALUE0_, _UPVALUE1_)
        end
        _UPVALUE2_.OutFlag = 1
        Effect.LoopEnd(_ARG_0_.effectHandle)
        Effect.LoopEnd(_ARG_0_.effectHandle2)
        Effect.LoopEnd(_ARG_0_.effectHandle3)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 20 then
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if Entity.GetCurrentMotion(_ARG_0_.targetHandle) == Entity.GetMotionIndex(_ARG_0_.targetHandle, "006") or Entity.GetCurrentMotion(_ARG_0_.targetHandle) == Entity.GetMotionIndex(_ARG_0_.targetHandle, "206") or Entity.GetCurrentMotion(_ARG_0_.targetHandle) == Entity.GetMotionIndex(_ARG_0_.targetHandle, "204") or Entity.GetCurrentMotion(_ARG_0_.targetHandle) == Entity.GetMotionIndex(_ARG_0_.targetHandle, "202") then
          else
            _ARG_0_.step = 2
            _ARG_0_.time = -1
            _ARG_0_:setMotion(_UPVALUE0_)
          end
          _ARG_0_.time = _ARG_0_.time - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 >= _ARG_0_.time then
            _UPVALUE4_:set(Script.Random() * _UPVALUE1_ - _UPVALUE1_ / 2 + (Script.Random() * 1 - 0.5), Script.Random() * _UPVALUE2_ + _UPVALUE3_ + Script.Random() * 1, _UPVALUE5_ + (Script.Random() * 2 - 1))
            _UPVALUE4_:setx(_UPVALUE4_:getx() + 5.5 * Math.Cos((RoundPI(Script.Random() * 2 * PI))))
            _UPVALUE4_:sety(_UPVALUE4_:gety() + 5.5 * Math.Sin((RoundPI(Script.Random() * 2 * PI))))
            _UPVALUE4_:setz(_UPVALUE4_:getz() + 5.5 * Math.Sin((RoundPI(Script.Random() * 2 * PI))))
            _UPVALUE4_:set(0, 0, 5.5)
            _UPVALUE6_:set(DegToRad(Script.Random() * 360), DegToRad(Script.Random() * 360), DegToRad(Script.Random() * 360))
            Math.RotateVectorXYZ(_UPVALUE4_, _UPVALUE6_)
            Entity.GetWorldPos(_UPVALUE7_, _ARG_0_.targetHandle, 1)
            _UPVALUE4_:setx(_UPVALUE7_:getx() + _UPVALUE4_:getx())
            _UPVALUE4_:sety(_UPVALUE7_:gety() + _UPVALUE4_:gety())
            _UPVALUE4_:setz(_UPVALUE7_:getz() + _UPVALUE4_:getz())
            FVECTOR3.Sub(_UPVALUE8_, _UPVALUE4_, _UPVALUE7_)
            FVECTOR3.normalize(_UPVALUE8_)
            _UPVALUE9_:set(-Math.Atan2(_UPVALUE8_:gety(), Math.Sqrt(_UPVALUE8_:getz() * _UPVALUE8_:getz() + _UPVALUE8_:getx() * _UPVALUE8_:getx())), Math.Atan2(_UPVALUE8_:getx(), _UPVALUE8_:getz()), 0)
            _ARG_0_:CreateKeyBalazs(_ARG_0_.myHandle, _UPVALUE10_)
            _ARG_0_.time = 0
            if 20 <= _ARG_0_.balazsStep2 then
              _ARG_0_.balazsStep2 = 0
              _ARG_0_.time = 60
              _ARG_0_.step = 2
              Entity.GetWorldPos(_UPVALUE7_, _ARG_0_.targetHandle, 1)
              _UPVALUE11_:set(0, 0, 0)
              _ARG_0_.effectHandle = Entity.SetEffect(_ARG_0_.myHandle, "b85vs00", "B085_KBA_EXP0_0", _UPVALUE7_, _UPVALUE11_)
            end
            _ARG_0_.balazsStep2 = _ARG_0_.balazsStep2 + 1
          end
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_:setMotion(_UPVALUE0_)
          end
        elseif _ARG_0_.step == 2 then
          _ARG_0_.time = _ARG_0_.time - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 >= _ARG_0_.time then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        end
      end
    },
    AirKeyBalazs = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":AirKeyBalazs\n")
        _ARG_0_:setMotion(_UPVALUE0_)
        _ARG_0_:setAppend(_UPVALUE1_)
        _ARG_0_.step = 0
        _ARG_0_.balazsStep = 0
        _ARG_0_.time = 0
        _ARG_0_.balazsStep2 = 0
        _UPVALUE2_:set(0, 0, 0)
        _ARG_0_.attackFlag = _ARG_0_.attackFlag + 1
        Entity.EnableGravity(_ARG_0_.myHandle, 0)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 20 then
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          _ARG_0_.time = _ARG_0_.time - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 >= _ARG_0_.time then
            _UPVALUE3_:set(Script.Random() * _UPVALUE0_ - _UPVALUE0_ / 2 + (Script.Random() * 1 - 0.5), Script.Random() * _UPVALUE1_ + _UPVALUE2_ + Script.Random() * 1, _UPVALUE4_ + (Script.Random() * 2 - 1))
            Entity.GetWorldPos(_UPVALUE5_, _ARG_0_.targetHandle, 2)
            Entity.GetWorldPos(_UPVALUE6_, _ARG_0_.myHandle, 2)
            _UPVALUE6_:setx(0)
            _UPVALUE6_:sety(2 + _UPVALUE6_:gety())
            _UPVALUE6_:setz(-2.2)
            _UPVALUE3_:set(_UPVALUE6_:getx(), _UPVALUE6_:gety(), _UPVALUE6_:getz())
            _UPVALUE7_:setx(3 * Script.Random() * Math.Cos((RoundPI(Script.Random() * 2 * PI))))
            _UPVALUE7_:sety(3 * Script.Random() * Math.Sin((RoundPI(Script.Random() * 2 * PI))))
            _UPVALUE7_:setz(0)
            Entity.GetRot(_UPVALUE8_, _ARG_0_.myHandle)
            Math.RotateVectorXYZ(_UPVALUE7_, _UPVALUE8_)
            Math.RotateVectorXYZ(_UPVALUE3_, _UPVALUE8_)
            FVECTOR3.Add(_UPVALUE3_, _UPVALUE3_, _UPVALUE7_)
            Entity.GetWorldPos(_UPVALUE6_, _ARG_0_.myHandle, 2)
            _UPVALUE3_:set(_UPVALUE3_:getx() + _UPVALUE6_:getx(), _UPVALUE3_:gety() + _UPVALUE6_:gety(), _UPVALUE3_:getz() + _UPVALUE6_:getz())
            Entity.GetRot(_UPVALUE9_, _ARG_0_.myHandle)
            _ARG_0_:CreateKeyBalazs(_ARG_0_.myHandle, _UPVALUE10_)
            _ARG_0_.time = 2
            if 4 <= _ARG_0_.balazsStep2 then
              _ARG_0_.balazsStep2 = 0
              _ARG_0_.time = 240
              _ARG_0_.step = 2
            end
            _ARG_0_.balazsStep2 = _ARG_0_.balazsStep2 + 1
          end
        elseif _ARG_0_.step == 2 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
            return
          end
          _ARG_0_.time = _ARG_0_.time - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 >= _ARG_0_.time then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        end
      end
    },
    BurstAttack = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":BurstAttack\n")
        if _UPVALUE0_.KeyMode == _UPVALUE1_ then
          _ARG_0_:setMotion(_UPVALUE2_, 2, 2)
        else
          _ARG_0_:setMotion(_UPVALUE3_, 2, 2)
        end
        _ARG_0_.step = 0
        _ARG_0_.attackFlag = 0
        _ARG_0_.time = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
        _ARG_0_.time = _ARG_0_.time - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > _UPVALUE0_.VolleyStartFrame and Entity.GetMotionNowFrame(_ARG_0_.myHandle) < _UPVALUE0_.VolleyEndFrame and _ARG_0_.time <= 0 then
          _ARG_0_:CreateBurst(_ARG_0_.myHandle)
          _ARG_0_.time = 5000
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    AirDarkBolley = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":AirDarkBolley\n")
        _ARG_0_:setMotion(_UPVALUE0_)
        _ARG_0_:setAppend(_UPVALUE1_)
        _ARG_0_.step = 0
        Entity.EnableGravity(_ARG_0_.myHandle, 0)
        _ARG_0_.time = 0
        _ARG_0_.attackFlag = _ARG_0_.attackFlag + 1
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
        _ARG_0_.time = _ARG_0_.time - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > _UPVALUE0_.VolleyStartFrame and Entity.GetMotionNowFrame(_ARG_0_.myHandle) < _UPVALUE0_.VolleyEndFrame and _ARG_0_.time <= 0 then
          _ARG_0_:CreateVolleyShoot(_ARG_0_.myHandle)
          _ARG_0_.time = 5
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    DarkBolley = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":DarkBolley\n")
        _ARG_0_:setMotion(_UPVALUE0_)
        _ARG_0_.step = 0
        _ARG_0_.time = 0
        _ARG_0_.attackFlag = _ARG_0_.attackFlag + 1
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
        _ARG_0_.time = _ARG_0_.time - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > _UPVALUE0_.VolleyStartFrame and Entity.GetMotionNowFrame(_ARG_0_.myHandle) < _UPVALUE0_.VolleyEndFrame and _ARG_0_.time <= 0 then
          _ARG_0_:CreateVolleyShoot(_ARG_0_.myHandle)
          _ARG_0_.time = 5
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    SonicImpact = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":SonicImpact\n")
        _ARG_0_:setMotion_NoSameCheck(_UPVALUE0_, 2, 2)
        _ARG_0_.step = 0
        _ARG_0_.Speed = 0
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
        Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
        _UPVALUE1_:sety(_UPVALUE1_:gety() + DegToRad(Script.Random() * 180 - 90))
        Entity.SetRot(_ARG_0_.myHandle, _UPVALUE1_)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
        _ARG_0_.attackFlag = _ARG_0_.attackFlag + 1
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 0 then
            _ARG_0_.step = 1
            Entity.SetTimer(_ARG_0_.myHandle, 30)
          end
        elseif _ARG_0_.step == 1 then
          _ARG_0_:MoveEx(0.35, 0.1)
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:setMotion_NoSameCheck(_UPVALUE0_, 1, 1)
            _ARG_0_.step = 2
            Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
            Entity.SetTimer(_ARG_0_.myHandle, 30)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.Speed = _ARG_0_.Speed + _ARG_0_.Speed * 1.3
          end
        elseif _ARG_0_.step == 2 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 8 then
            _ARG_0_.step = 3
          end
        elseif _ARG_0_.step == 3 then
          _ARG_0_.Speed = _ARG_0_.Speed - _ARG_0_.Speed * 0.1
          if 0 > _ARG_0_.Speed then
            _ARG_0_.Speed = 0
          end
          FVECTOR3.set(_UPVALUE1_, 0, 0, _ARG_0_.Speed)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE1_)
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_:GotoState("FallToLanding")
          end
        end
      end
    },
    AbsoluteDraw = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":AbsoluteDraw\n")
        _ARG_0_:setMotion(_UPVALUE0_)
        _ARG_0_:setAppend(_UPVALUE1_)
        _ARG_0_.step = 0
        _ARG_0_.attackFlag = _ARG_0_.attackFlag + 1
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    KonboAttack1 = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":KonboAttack1\n")
        _ARG_0_:setAppend(_UPVALUE0_)
        _ARG_0_:setMotion_NoSameCheck(_UPVALUE1_, -1)
        _ARG_0_.step = 0
        _ARG_0_.attackFlag = _ARG_0_.attackFlag + 1
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    KonboAttack2 = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":KonboAttack2\n")
        _ARG_0_:setMotion_NoSameCheck(_UPVALUE0_, -1)
        _ARG_0_:setAppend(_UPVALUE1_)
        _ARG_0_.step = 0
        _ARG_0_.HitAttackFlag = 0
        _ARG_0_.attackFlag = _ARG_0_.attackFlag + 1
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
        _ARG_0_.reflectFlag = 0
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        if _ARG_0_.HitAttackFlag == 2 then
          Entity.GetDamageCrossPos(_UPVALUE0_, _ARG_0_.targetHandle)
          _UPVALUE1_:set(0, 0, 0)
          Entity.SetEffect(_ARG_0_.myHandle, "b85vs00", "B085_KEY_CRI0_0", _UPVALUE0_, _UPVALUE1_)
          _UPVALUE0_:set(0, 19, 20)
          Entity.GetRot(_UPVALUE2_, _ARG_0_.myHandle)
          Math.RotateVectorXYZ(_UPVALUE0_, _UPVALUE2_)
          Player.SetDamage(_ARG_0_.targetHandle, 0, ATK_KIND_DMG_TOSS, 0, 0, _UPVALUE0_)
        end
        _ARG_0_.HitAttackFlag = 0
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) < 16 then
          _ARG_0_.HitAttackFlag = 0
        elseif Entity.GetMotionNowFrame(_ARG_0_.myHandle) < 29 then
          _ARG_0_.HitAttackFlag = 0
        elseif _ARG_0_.HitAttackFlag == 1 and _ARG_0_.reflectFlag == 0 then
          if Player.IsMuteki(_ARG_0_.targetHandle) or Player.GetPlayerState(_ARG_0_.targetHandle) == PLAYER_STATE_GUARD then
            _ARG_0_.HitAttackFlag = 0
            return
          else
            _ARG_0_.HitAttackFlag = 2
          end
        elseif _ARG_0_.HitAttackFlag == 2 then
          _ARG_0_.stack:push("KonboAttack2_success")
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    KonboAttack2_success = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":KonboAttack2_success\n")
        _ARG_0_.step = 0
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        if _ARG_0_:checkRate(9, 0) == 1 and (Player.IsMuteki(_ARG_0_.targetHandle) == false or Player.GetPlayerState(_ARG_0_.targetHandle) ~= PLAYER_STATE_GUARD) then
          print("\131_\129[\131N\131{\131\140\129[\130\214\n")
          _ARG_0_.stack:push("KeyBalazs2")
        elseif _ARG_0_:checkRate(9, 0) == 2 then
          print("\131L\129[\131u\131\140\129[\131h\131o\131\137\129[\131W\131\133\130\214\n")
          _ARG_0_.stack:push("KeyBalazs2")
        else
          print("\137\189\130\224\130\181\130\200\130\162\130\214\n")
        end
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        _ARG_0_.HitAttackFlag = 0
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    StraightBlow = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":StraightBlow\n")
        _ARG_0_:setAppend(_UPVALUE0_)
        _ARG_0_:setMotion_NoSameCheck(_UPVALUE1_)
        _ARG_0_.step = 0
        _ARG_0_.shootFlara = 0
        _ARG_0_.attackFlag = _ARG_0_.attackFlag + 1
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        _UPVALUE2_ = 0
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        _ARG_0_:setAppend(_ARG_0_.oldKeyMode)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 15)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > _UPVALUE0_.BlowNextStartFrame and _ARG_0_.shootFlara == 0 then
            _ARG_0_:CreateStraightShoot(_ARG_0_.myHandle)
            _ARG_0_.shootFlara = 1
          end
          if _UPVALUE1_ == 1 then
            _ARG_0_.step = 3
            _ARG_0_.shootFlara = 0
            return
          end
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > _UPVALUE0_.BlowStartFrame then
            _ARG_0_.step = 1
            _ARG_0_.shootFlara = 0
            _ARG_0_:setMotion(_UPVALUE2_)
            Entity.SetAnimNowFrame(_ARG_0_.myHandle, 14)
            _ARG_0_:TurnY(DegToRad(-20))
          end
        elseif _ARG_0_.step == 1 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > _UPVALUE0_.BlowNextStartFrame and _ARG_0_.shootFlara == 0 then
            _ARG_0_:CreateStraightShoot(_ARG_0_.myHandle)
            _ARG_0_.shootFlara = 1
          end
          if _UPVALUE1_ == 1 then
            _ARG_0_.step = 3
            _ARG_0_.shootFlara = 0
            return
          end
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > _UPVALUE0_.BlowStartFrame then
            _ARG_0_.step = 2
            _ARG_0_.shootFlara = 0
            _ARG_0_:setMotion(_UPVALUE2_)
            Entity.SetAnimNowFrame(_ARG_0_.myHandle, 14)
            _ARG_0_:TurnY(DegToRad(40))
          end
        elseif _ARG_0_.step == 2 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > _UPVALUE0_.BlowNextStartFrame and _ARG_0_.shootFlara == 0 then
            _ARG_0_:CreateStraightShoot(_ARG_0_.myHandle)
            _ARG_0_.shootFlara = 1
          end
          if _UPVALUE1_ == 1 then
            _ARG_0_.step = 3
            _ARG_0_.shootFlara = 0
            return
          end
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > _UPVALUE0_.BlowStartFrame then
            _ARG_0_.step = 3
            _ARG_0_.shootFlara = 0
          end
        elseif _ARG_0_.step == 3 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Grapple = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":Grapple\n")
        _ARG_0_:setAppend(_UPVALUE0_)
        _ARG_0_:setMotion_NoSameCheck(_UPVALUE1_)
        _ARG_0_.step = 0
        _ARG_0_.HitAttackFlag = 0
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        _ARG_0_.attackFlag = _ARG_0_.attackFlag + 1
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
        if _ARG_0_.step == 0 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) < 12 and _ARG_0_.HitAttackFlag == 1 then
            _ARG_0_.step = 1
          end
        else
          if Player.IsMuteki(_ARG_0_.targetHandle) then
            _ARG_0_.HitAttackFlag = 0
            return
          end
          _ARG_0_:GotoState("GrappleGuriguri")
        end
      end
    },
    GrappleGuriguri = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":GrappleGuriguri\n")
        _ARG_0_:setMotion_NoSameCheck(_UPVALUE0_)
        _ARG_0_.step = 0
        Player.SetDamage(_ARG_0_.targetHandle, 0, ATK_KIND_CAPTURE)
        Entity.SetTimer(_ARG_0_.myHandle, 120)
        Entity.SetMovementCollRadius(_ARG_0_.myHandle, 3)
        Entity.SetLowerHalf(_ARG_0_.myHandle, 3.1)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        _ARG_0_.guriguriTaimer = 20
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Entity.SetMovementCollRadius(_ARG_0_.myHandle, 1.5)
        Entity.SetLowerHalf(_ARG_0_.myHandle, 1.6)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("RetrunState")
          return
        end
        if _ARG_0_.step == 0 then
          if Entity.GetCurrentMotion(_ARG_0_.targetHandle) == Entity.GetMotionIndex(_ARG_0_.targetHandle, "801") then
            SetAttach(_ARG_0_)
            _ARG_0_.step = 1
            _ARG_0_:GotoState("GrappleGuriguriSuccess")
          end
        elseif _ARG_0_.step == 1 and Entity.GetCurrentMotion(_ARG_0_.targetHandle) ~= Entity.GetMotionIndex(_ARG_0_.targetHandle, "801") then
          _ARG_0_:GotoState("RetrunState")
          return
        end
      end
    },
    GrappleGuriguriSuccess = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":GrappleGuriguriSuccess\n")
        _ARG_0_.step = 0
        Entity.SetTimer(_ARG_0_.myHandle, 120)
        Entity.SetMovementCollRadius(_ARG_0_.myHandle, 3)
        Entity.SetLowerHalf(_ARG_0_.myHandle, 3.1)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        _ARG_0_.guriguriTaimer = 20
        SetAttach(_ARG_0_)
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Entity.SetMovementCollRadius(_ARG_0_.myHandle, 1.5)
        Entity.SetLowerHalf(_ARG_0_.myHandle, 1.6)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          if Entity.GetCurrentMotion(_ARG_0_.targetHandle) ~= Entity.GetMotionIndex(_ARG_0_.targetHandle, "801") then
            _ARG_0_:GotoState("RetrunState")
            return
          end
          print("\131O\131\137\131b\131v\131\139\129@\145\188\130\204\131v\131\140\131C\131\132\129[\143\243\139\181 = " .. _ARG_0_:GetUneTargetHandle() .. "\n")
          if _ARG_0_:GetUneTargetHandle() == 1 then
            _ARG_0_:GotoState("GrappleSlow")
            return
          elseif _ARG_0_:GetUneTargetHandle() == 2 then
            _ARG_0_:GotoState("GrappleImpact")
            return
          elseif _ARG_0_:checkRate(10, 0) == 1 then
            _ARG_0_:GotoState("GrappleImpact")
            return
          else
            _ARG_0_:GotoState("GrappleSlow")
            return
          end
        end
        if _ARG_0_.step == 0 then
          _ARG_0_.guriguriTaimer = _ARG_0_.guriguriTaimer - Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 > _ARG_0_.guriguriTaimer then
            _ARG_0_.step = 1
          end
          if Entity.GetCurrentMotion(_ARG_0_.targetHandle) ~= Entity.GetMotionIndex(_ARG_0_.targetHandle, "801") then
            ReleaseAttach(_ARG_0_)
            _ARG_0_:GotoState("RetrunState")
            _ARG_0_.step = 99
            return
          end
        elseif _ARG_0_.step == 1 then
          if Entity.GetCurrentMotion(_ARG_0_.targetHandle) ~= Entity.GetMotionIndex(_ARG_0_.targetHandle, "801") then
            ReleaseAttach(_ARG_0_)
            _ARG_0_:GotoState("RetrunState")
            _ARG_0_.step = 99
            return
          end
          if Entity.GetCurrentMotion(_ARG_0_.targetHandle) == Entity.GetMotionIndex(_ARG_0_.targetHandle, "801") then
            _UPVALUE0_:set(0, 0, 0)
            Entity.SetLocalPos(_ARG_0_.targetHandle, _UPVALUE0_)
            Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 1)
            Entity.SetOldLocalPos(_ARG_0_.targetHandle, _UPVALUE0_)
          end
        elseif _ARG_0_.step == 99 then
        end
      end
    },
    GrappleImpact = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":GrappleImpact\n")
        _ARG_0_:setMotion_NoSameCheck(_UPVALUE0_)
        _ARG_0_.step = 0
        Entity.SetMovementCollRadius(_ARG_0_.myHandle, 3)
        Entity.SetLowerHalf(_ARG_0_.myHandle, 3.1)
        _ARG_0_.attackFlag = _ARG_0_.attackFlag + 1
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.GetCurrentMotion(_ARG_0_.targetHandle) ~= Entity.GetMotionIndex(_ARG_0_.targetHandle, "801") then
            _ARG_0_:GotoState("GrappleImpactBad")
            return
          end
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 27 then
            _ARG_0_:GotoState("GrappleImpactSuccess")
            return
          end
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    GrappleImpactSuccess = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":GrappleImpactSuccess\n")
        _ARG_0_.step = 0
        Player.SetTrgFlagCancel(_ARG_0_.myHandle, 1)
        Player.SetDamage(_ARG_0_.targetHandle, Player.CalcDamagePoint(_ARG_0_.targetHandle, Enemy.GetAttackPoint(_ARG_0_.myHandle, 6), (Enemy.GetAttackPowerCorrection(_ARG_0_.myHandle, 6))), ATK_KIND_DMG_BIG)
        Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
        _UPVALUE0_:sety(RoundPI(_UPVALUE0_:gety() + DegToRad(180)))
        Entity.SetRot(_ARG_0_.targetHandle, _UPVALUE0_)
        Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.targetHandle, 1)
        _UPVALUE2_:set(0, 0, 0)
        Entity.SetEffect(_ARG_0_.myHandle, "b85vs00", "B085_KEY_HIT0_0", _UPVALUE1_, _UPVALUE2_)
        Entity.SetEffect(_ARG_0_.myHandle, "b85vs00", "B085_KEY_HOS0_0", _UPVALUE1_, _UPVALUE2_)
        _ARG_0_.step = 0
        Entity.SetMovementCollRadius(_ARG_0_.myHandle, 1.5)
        Entity.SetLowerHalf(_ARG_0_.myHandle, 1.6)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        _ARG_0_:setAppend(_ARG_0_.oldKeyMode)
        Entity.SetMovementCollRadius(_ARG_0_.myHandle, 1.5)
        Entity.SetLowerHalf(_ARG_0_.myHandle, 1.6)
        ReleaseAttach(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 and Entity.GetCurrentMotion(_ARG_0_.targetHandle) ~= Entity.GetMotionIndex(_ARG_0_.targetHandle, "801") then
          ReleaseAttach(_ARG_0_)
          _ARG_0_.step = 1
          return
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    GrappleImpactBad = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":GrappleImpactBad\n")
        _ARG_0_.step = 0
        Player.SetTrgFlagCancel(_ARG_0_.myHandle, 1)
        ReleaseAttach(_ARG_0_)
        Entity.SetMovementCollRadius(_ARG_0_.myHandle, 1.5)
        Entity.SetLowerHalf(_ARG_0_.myHandle, 1.6)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        _ARG_0_:setAppend(_ARG_0_.oldKeyMode)
        Entity.SetMovementCollRadius(_ARG_0_.myHandle, 1.5)
        Entity.SetLowerHalf(_ARG_0_.myHandle, 1.6)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    GrappleSlow = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":GrappleSlow\n")
        _ARG_0_:setMotion_NoSameCheck(_UPVALUE0_)
        _ARG_0_.step = 0
        Entity.SetMovementCollRadius(_ARG_0_.myHandle, 3)
        Entity.SetLowerHalf(_ARG_0_.myHandle, 3.1)
        _ARG_0_.attackFlag = _ARG_0_.attackFlag + 1
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Entity.SetMovementCollRadius(_ARG_0_.myHandle, 1.5)
        Entity.SetLowerHalf(_ARG_0_.myHandle, 1.6)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 26 then
            _ARG_0_:GotoState("GrappleSlowSuccess")
            return
          end
          if Entity.GetCurrentMotion(_ARG_0_.targetHandle) ~= Entity.GetMotionIndex(_ARG_0_.targetHandle, "801") then
            _ARG_0_:GotoState("GrappleSlowBad")
          end
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    GrappleSlowSuccess = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":GrappleSlowSuccess\n")
        _ARG_0_.step = 0
        Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
        _UPVALUE0_:sety(RoundPI(_UPVALUE0_:gety() + DegToRad(180)))
        Entity.SetRot(_ARG_0_.targetHandle, _UPVALUE0_)
        _UPVALUE1_:set(0, 0, 35)
        Entity.GetRot(_UPVALUE2_, _ARG_0_.myHandle)
        Math.RotateVectorXYZ(_UPVALUE1_, _UPVALUE2_)
        Player.SetTrgFlagCancel(_ARG_0_.myHandle, 1)
        Player.SetDamage(_ARG_0_.targetHandle, Player.CalcDamagePoint(_ARG_0_.targetHandle, Enemy.GetAttackPoint(_ARG_0_.myHandle, 7), (Enemy.GetAttackPowerCorrection(_ARG_0_.myHandle, 7))), ATK_KIND_DMG_TOSS, 0, 0, _UPVALUE1_)
        _ARG_0_.step = 0
        _ARG_0_:SetPlayerBallet()
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        _ARG_0_:setAppend(_ARG_0_.oldKeyMode)
        Entity.SetMovementCollRadius(_ARG_0_.myHandle, 1.5)
        Entity.SetLowerHalf(_ARG_0_.myHandle, 1.6)
        ReleaseAttach(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 and Entity.GetCurrentMotion(_ARG_0_.targetHandle) ~= Entity.GetMotionIndex(_ARG_0_.targetHandle, "801") then
          ReleaseAttach(_ARG_0_)
          _ARG_0_.step = 1
          return
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    GrappleSlowBad = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":GrappleSlowBad\n")
        _ARG_0_:setMotion_NoSameCheck(_UPVALUE0_)
        _ARG_0_.step = 0
        ReleaseAttach(_ARG_0_)
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        _ARG_0_:setAppend(_ARG_0_.oldKeyMode)
        Entity.SetMovementCollRadius(_ARG_0_.myHandle, 1.5)
        Entity.SetLowerHalf(_ARG_0_.myHandle, 1.6)
        if Entity.IsAttachCoord(_ARG_0_.targetHandle) == true then
          Entity.AttachCoord(NULL_HANDLE, "", _ARG_0_.targetHandle, "Root")
        end
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    RetrunState = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":RetrunState\n")
        _ARG_0_:setMotion_NoSameCheck(_UPVALUE0_)
        Entity.SetMotion(_ARG_0_.ArmHandle, _UPVALUE1_)
        _ARG_0_.step = 0
        _ARG_0_.time = 0
        _ARG_0_.attackFlag = _ARG_0_.attackFlag + 1
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        ReleaseAttach(_ARG_0_)
        Entity.LoopEndEffectAttach(_ARG_0_.myHandle, -1)
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.ArmHandle, "900")
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    RetrunStateNomove = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":RetrunStateNomove\n")
        _ARG_0_:setMotion_NoSameCheck(_UPVALUE0_)
        _ARG_0_.step = 0
        Entity.LoopEndEffectAttach(_ARG_0_.myHandle, -1)
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.ArmHandle, "900")
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    SonicWave = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":SonicWave\n")
        _ARG_0_:setMotion_NoSameCheck(_UPVALUE0_)
        _ARG_0_:setAppend(_UPVALUE1_)
        _ARG_0_.step = 0
        _ARG_0_.time = 0
        _ARG_0_.attackFlag = _ARG_0_.attackFlag + 1
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        _ARG_0_:setAppend(_ARG_0_.oldKeyMode)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          _ARG_0_.time = _ARG_0_.time - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > _UPVALUE0_.VolleyStartFrame and Entity.GetMotionNowFrame(_ARG_0_.myHandle) < _UPVALUE0_.VolleyEndFrame then
            _ARG_0_:CreateSonicShoot(_ARG_0_.myHandle)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    ShootStrike = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":ShootStrike\n")
        _ARG_0_:setAppend(_UPVALUE0_)
        _ARG_0_:setMotion_NoSameCheck(_UPVALUE1_, -1)
        _ARG_0_.step = 0
        _ARG_0_.attackFlag = _ARG_0_.attackFlag + 1
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        _ARG_0_:setAppend(_ARG_0_.oldKeyMode)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) < 80 then
          _ARG_0_.HitAttackFlag = 0
        elseif _ARG_0_.HitAttackFlag == 1 then
          _ARG_0_.HitAttackFlag = 2
        elseif _ARG_0_.HitAttackFlag == 2 then
          if Player.IsMuteki(_ARG_0_.targetHandle) then
            _ARG_0_.HitAttackFlag = 0
            return
          else
            Entity.GetDamageCrossPos(_UPVALUE0_, _ARG_0_.targetHandle)
            _UPVALUE1_:set(0, 0, 0)
            Entity.SetEffect(_ARG_0_.myHandle, "b85vs00", "B085_KEY_CRI0_0", _UPVALUE0_, _UPVALUE1_)
            _UPVALUE0_:set(0, 3, 20)
            Entity.GetRot(_UPVALUE2_, _ARG_0_.myHandle)
            Math.RotateVectorXYZ(_UPVALUE0_, _UPVALUE2_)
            Player.SetDamage(_ARG_0_.targetHandle, 0, ATK_KIND_DMG_TOSS, 0, 0, _UPVALUE0_)
            _ARG_0_.HitAttackFlag = 0
            _ARG_0_:SetPlayerBallet()
          end
        end
      end
    },
    StanInpact = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":StanInpact\n")
        _ARG_0_:setMotion_NoSameCheck(_UPVALUE0_)
        _ARG_0_:setAppend(_UPVALUE1_)
        _ARG_0_.step = 0
        _ARG_0_.attackFlag = _ARG_0_.attackFlag + 1
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    BarnImpactIdling = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":BarnImpact\n")
        _ARG_0_:setMotion_NoSameCheck(_UPVALUE0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        if Player.IsMuteki(_ARG_0_.targetHandle) then
        elseif Script.Random() < 0.5 then
          _ARG_0_:GotoState("Idling")
        else
          _ARG_0_:GotoState("BarnImpact")
        end
      end
    },
    BarnImpact = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":BarnImpact\n")
        _ARG_0_:setMotion_NoSameCheck(_UPVALUE0_)
        _ARG_0_:setAppend(_UPVALUE1_)
        _ARG_0_.step = 0
        Keybraid = EntityManager:GetEntity(_ARG_0_.ShieldHandle)
        Keybraid:GotoState("BarnImpact")
        Keybraid.targetHandle = _ARG_0_.targetHandle
        _ARG_0_.attackFlag = _ARG_0_.attackFlag + 1
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      end,
      OnEndState = function(_ARG_0_)
        RsetAttackOrMagicPow()
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    WincCutter = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":WincCutter\n")
        _ARG_0_:setMotion_NoSameCheck(_UPVALUE0_)
        _ARG_0_:setAppend(_UPVALUE1_)
        _ARG_0_.step = 0
        Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.myHandle)
        Entity.EnableGravity(_ARG_0_.myHandle, 0)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        print("y = " .. _UPVALUE2_:gety() .. "\n")
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, _UPVALUE2_:gety() / 10, 1)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
        _ARG_0_.attackFlag = _ARG_0_.attackFlag + 1
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
        Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
        _UPVALUE0_:setx(0)
        _UPVALUE0_:setz(0)
        Entity.SetRot(_ARG_0_.myHandle, _UPVALUE0_)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
        _ARG_0_.attTimer = _ARG_0_.attTimer - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.attTimer < 0 then
          _ARG_0_.attTimer = 20
          Entity.AACUpdateAttackID(_ARG_0_.myHandle)
        end
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 20 then
          Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    DarkGigaFlare = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":DarkGigaFlare\n")
        _ARG_0_:setAppend(_UPVALUE0_)
        _ARG_0_:setMotion_NoSameCheck(_UPVALUE1_)
        Entity.EnableGravity(_ARG_0_.myHandle, 0)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        _ARG_0_.step = 0
        _ARG_0_.attackFlag = _ARG_0_.attackFlag + 1
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        _ARG_0_.SpeedY = 0
        _ARG_0_.damageFlag = 0
        _ARG_0_.taimer = 0
      end,
      OnEndState = function(_ARG_0_)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
          Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
          if _UPVALUE0_:gety() < 10 then
            _ARG_0_:OnMove(0.2, 0.05)
          else
            Entity.ClearSpeed(_ARG_0_.myHandle)
          end
          if _ARG_0_.damageFlag == 1 then
          end
          _ARG_0_.taimer = _ARG_0_.taimer - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 > _ARG_0_.taimer then
            if Script.Random() == 0.333 then
            elseif Script.Random() == 0.666 then
            else
            end
            for _FORV_8_ = 0, 1 do
              _ARG_0_:CreateDarkGigaShoot(_ARG_0_.myHandle)
            end
            _ARG_0_.taimer = 60
          end
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 120 and _ARG_0_.step == 0 then
            _ARG_0_:CreateDarkFlare(_ARG_0_.myHandle)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Guard = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":Guard\n")
        _ARG_0_:setMotion_NoSameCheck(_UPVALUE0_)
        _ARG_0_:setAppend(_UPVALUE1_)
        _ARG_0_.step = 0
        SetingGuard(_ARG_0_)
      end,
      OnEndState = function(_ARG_0_)
        _ARG_0_:setAppend(_ARG_0_.oldKeyMode)
        _ARG_0_.damageFlag = 0
        EndGuard(_ARG_0_)
        _ARG_0_.noDamageFlag = 0
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
        if _ARG_0_.step == 0 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 20 then
          EndGuard(_ARG_0_)
          _ARG_0_.step = 1
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    ParryStart = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":ParryStart\n")
        _ARG_0_:setMotion_NoSameCheck(_UPVALUE0_)
        _ARG_0_:setAppend(_UPVALUE1_)
        _ARG_0_.step = 0
        _ARG_0_.damageFlag = 0
        _ARG_0_.noDamageFlag = 1
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE2_.ParryTimer)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":B85VS_PARAM.ParryTimer = " .. _UPVALUE2_.ParryTimer .. "\n")
      end,
      OnEndState = function(_ARG_0_)
        _ARG_0_:setAppend(_ARG_0_.oldKeyMode)
        _ARG_0_.damageFlag = 0
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.damageFlag == 1 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
          if _ARG_0_:checkRate(30, 0) == 1 then
            if _ARG_0_:checkRate(31, 0) == 1 then
              print("\146n\143\227\141s\147\174\130\214\n")
            else
              print("\144\218\139\223\141U\140\130\130\214\n")
              _ARG_0_:ShortAttackState()
            end
            _ARG_0_:GotoState("Parry")
          else
          end
          return
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Parry = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":Parry\n")
        _ARG_0_:setMotion_NoSameCheck(_UPVALUE0_)
        _ARG_0_.step = 0
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      end,
      OnEndState = function(_ARG_0_)
        _ARG_0_.damageFlag = 0
        _ARG_0_.noDamageFlag = 0
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) or Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 21 then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    TimeOperation = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":TimeOperation\n")
        _ARG_0_:setMotion_NoSameCheck(_UPVALUE0_)
        _ARG_0_.step = 0
        _ARG_0_.time = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
        if _ARG_0_:IsTimeOperation() == 3 then
          _ARG_0_.step = 9
        end
        _ARG_0_.time = _ARG_0_.time - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.step == 0 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) > _UPVALUE0_.VolleyStartFrame and Entity.GetMotionNowFrame(_ARG_0_.myHandle) < _UPVALUE0_.VolleyEndFrame and _ARG_0_:IsTimeOperation() == 0 and _ARG_0_.time <= 0 then
          _ARG_0_:CreateTimeOperation(_UPVALUE1_[_ARG_0_:setTimeOpePosIndex()].x, _UPVALUE1_[_ARG_0_:setTimeOpePosIndex()].y, _UPVALUE1_[_ARG_0_:setTimeOpePosIndex()].z, _ARG_0_.step)
          _ARG_0_.time = 1
          _ARG_0_.step = _ARG_0_.step + 1
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Invitation_to_the_dark = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":Invitation_to_the_dark\n")
        _ARG_0_:setMotion_NoSameCheck(_UPVALUE0_)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > _UPVALUE0_.VolleyStartFrame and Entity.GetMotionNowFrame(_ARG_0_.myHandle) < _UPVALUE0_.VolleyEndFrame and _UPVALUE0_.IsSetDarkIn ~= 1 then
          _ARG_0_:CreateInDark(_ARG_0_.myHandle)
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Waiting = {
      OnBeginState = function(_ARG_0_)
        print("Waiting\n")
        _ARG_0_:setMotion(_UPVALUE0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        Entity.SetAlpha(_ARG_0_.myHandle, 0)
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableLockon(_ARG_0_.myHandle, 1)
        Entity.SetAlpha(_ARG_0_.myHandle, 1)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Exusia.IsExistenceSchedule() then
            SetupAppearBegin(_ARG_0_.myHandle, -1, _UPVALUE0_, 1)
            _ARG_0_.step = 1
          end
        elseif Enemy.IsAllEnemyWaiting() == false then
          print("Enemy.IsAllEnemyWaiting() == false\n")
          _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    Dead = {
      OnBeginState = function(_ARG_0_)
        print("Dead\n")
        Entity.SetupModelFade(_ARG_0_.KyeHandle, 0, 0, 20)
        Entity.SetupModelFade(_ARG_0_.WindHandle, 0, 0, 20)
        Entity.SetupModelFade(_ARG_0_.ArmHandle, 0, 0, 20)
        Entity.SetupModelFade(_ARG_0_.LegHandle, 0, 0, 20)
        Entity.SetupModelFade(_ARG_0_.ShieldHandle, 0, 0, 20)
        if _UPVALUE0_ ~= 0 then
          Effect.LoopEnd(Bullet.GetEffectHandle(EntityManager:GetEntity(_UPVALUE0_).myHandle))
          EntityManager:GetEntity(_UPVALUE0_).step = 1
          print("\142\128\150S\130\181\130\189\130\204\130\197\136\197\130\214\130\204\151U\130\162\130\205\141\237\143\156\130\162\130\189\130\181\130\220\130\183\129B\n")
        end
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
      end
    }
  },
  createAttachEffect = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
    return Entity.AttachEffect(_ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _UPVALUE0_, _UPVALUE1_)
  end,
  MoveEx = function(_ARG_0_, _ARG_1_, _ARG_2_)
    _ARG_0_.Speed = _ARG_0_.Speed + _ARG_1_ * _ARG_2_ * Entity.GetFrameRate(_ARG_0_.myHandle)
    if _ARG_1_ < _ARG_0_.Speed then
      _ARG_0_.Speed = _ARG_1_
    end
    FVECTOR3.set(_UPVALUE0_, 0, 0, _ARG_0_.Speed)
    Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE0_)
  end,
  BackMove = function(_ARG_0_, _ARG_1_, _ARG_2_)
    _ARG_0_.SpeedZ = _ARG_0_.SpeedZ + _ARG_1_ * _ARG_2_ * Entity.GetFrameRate(_ARG_0_.myHandle)
    if _ARG_0_.SpeedZ > -_ARG_1_ then
      _ARG_0_.SpeedZ = -_ARG_1_
    end
    _UPVALUE0_:set(0, 0, _ARG_0_.SpeedZ)
    Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE0_)
  end,
  OnMove = function(_ARG_0_, _ARG_1_, _ARG_2_)
    _ARG_0_.SpeedY = _ARG_0_.SpeedY + _ARG_1_ * _ARG_2_ * Entity.GetFrameRate(_ARG_0_.myHandle)
    if _ARG_1_ < _ARG_0_.SpeedY then
      _ARG_0_.SpeedY = _ARG_1_
    end
    _UPVALUE0_:set(0, _ARG_0_.SpeedY, 0)
    Entity.CalcVelocity(_ARG_0_.myHandle, _UPVALUE0_)
  end,
  getRate_p1 = function(_ARG_0_, _ARG_1_, _ARG_2_)
    if _ARG_2_ == _UPVALUE0_ then
    elseif _ARG_2_ == _UPVALUE2_ then
    elseif _ARG_2_ == _UPVALUE3_ then
    elseif _ARG_2_ == _UPVALUE4_ then
    elseif _ARG_2_ == _UPVALUE5_ then
    end
    return _UPVALUE1_[_ARG_1_].pppp1
  end,
  getRate_p2 = function(_ARG_0_, _ARG_1_, _ARG_2_)
    if _ARG_2_ == _UPVALUE0_ then
    elseif _ARG_2_ == _UPVALUE2_ then
    elseif _ARG_2_ == _UPVALUE3_ then
    elseif _ARG_2_ == _UPVALUE4_ then
    elseif _ARG_2_ == _UPVALUE5_ then
    end
    return _UPVALUE1_[_ARG_1_].pppp2
  end,
  getRate_p3 = function(_ARG_0_, _ARG_1_, _ARG_2_)
    if _ARG_2_ == _UPVALUE0_ then
    elseif _ARG_2_ == _UPVALUE2_ then
    elseif _ARG_2_ == _UPVALUE3_ then
    elseif _ARG_2_ == _UPVALUE4_ then
    elseif _ARG_2_ == _UPVALUE5_ then
    end
    return _UPVALUE1_[_ARG_1_].pppp3
  end,
  getRate_p4 = function(_ARG_0_, _ARG_1_, _ARG_2_)
    if _ARG_2_ == _UPVALUE0_ then
    elseif _ARG_2_ == _UPVALUE2_ then
    elseif _ARG_2_ == _UPVALUE3_ then
    elseif _ARG_2_ == _UPVALUE4_ then
    elseif _ARG_2_ == _UPVALUE5_ then
    end
    return _UPVALUE1_[_ARG_1_].pppp4
  end,
  getRate_p5 = function(_ARG_0_, _ARG_1_, _ARG_2_)
    if _ARG_2_ == _UPVALUE0_ then
    elseif _ARG_2_ == _UPVALUE2_ then
    elseif _ARG_2_ == _UPVALUE3_ then
    elseif _ARG_2_ == _UPVALUE4_ then
    elseif _ARG_2_ == _UPVALUE5_ then
    end
    return _UPVALUE1_[_ARG_1_].pppp5
  end,
  getRate_p6 = function(_ARG_0_, _ARG_1_, _ARG_2_)
    if _ARG_2_ == _UPVALUE0_ then
    elseif _ARG_2_ == _UPVALUE2_ then
    elseif _ARG_2_ == _UPVALUE3_ then
    elseif _ARG_2_ == _UPVALUE4_ then
    elseif _ARG_2_ == _UPVALUE5_ then
    end
    return _UPVALUE1_[_ARG_1_].pppp6
  end,
  getRate_p7 = function(_ARG_0_, _ARG_1_, _ARG_2_)
    if _ARG_2_ == _UPVALUE0_ then
    elseif _ARG_2_ == _UPVALUE2_ then
    elseif _ARG_2_ == _UPVALUE3_ then
    elseif _ARG_2_ == _UPVALUE4_ then
    elseif _ARG_2_ == _UPVALUE5_ then
    end
    return _UPVALUE1_[_ARG_1_].pppp7
  end,
  getRate_p8 = function(_ARG_0_, _ARG_1_, _ARG_2_)
    if _ARG_2_ == _UPVALUE0_ then
    elseif _ARG_2_ == _UPVALUE2_ then
    elseif _ARG_2_ == _UPVALUE3_ then
    elseif _ARG_2_ == _UPVALUE4_ then
    elseif _ARG_2_ == _UPVALUE5_ then
    end
    return _UPVALUE1_[_ARG_1_].pppp8
  end,
  checkRate = function(_ARG_0_, _ARG_1_, _ARG_2_)
    if _UPVALUE0_[_ARG_1_].getMode == 1 then
      _ARG_2_ = 0
    elseif _UPVALUE0_[_ARG_1_].getMode == 2 then
      _ARG_2_ = _ARG_0_:RestHpRate()
      if _ARG_2_ > 0.5 then
        _ARG_2_ = _UPVALUE1_
      else
        _ARG_2_ = _UPVALUE2_
      end
    elseif _UPVALUE0_[_ARG_1_].getMode == 5 then
      _ARG_2_ = _ARG_0_:RestHpRate()
      if _ARG_0_:IsTimeOperation() == 1 then
        _ARG_2_ = _UPVALUE3_
      elseif _UPVALUE4_.IsSetDarkIn == 1 then
        if _ARG_2_ > 0.5 then
          _ARG_2_ = _UPVALUE5_
        else
          _ARG_2_ = _UPVALUE6_
        end
      elseif _ARG_2_ > 0.5 then
        _ARG_2_ = _UPVALUE1_
      else
        _ARG_2_ = _UPVALUE2_
      end
    else
      _ARG_2_ = _ARG_0_:RestHpRate()
      if _ARG_2_ > 0.5 then
        _ARG_2_ = _UPVALUE1_
      else
        _ARG_2_ = _UPVALUE2_
      end
    end
    if _UPVALUE0_[_ARG_1_].rateType == 2 then
    elseif _UPVALUE0_[_ARG_1_].rateType == 22 then
      d1 = _ARG_0_:getRate_d1(_ARG_1_, _ARG_2_)
      d2 = _ARG_0_:getRate_d2(_ARG_1_, _ARG_2_)
    elseif _UPVALUE0_[_ARG_1_].rateType == 3 then
    elseif _UPVALUE0_[_ARG_1_].rateType == 33 then
      d1 = _ARG_0_:getRate_d1(_ARG_1_, _ARG_2_)
      d2 = _ARG_0_:getRate_d2(_ARG_1_, _ARG_2_)
      d3 = _ARG_0_:getRate_d3(_ARG_1_, _ARG_2_)
    elseif _UPVALUE0_[_ARG_1_].rateType == 4 then
    elseif _UPVALUE0_[_ARG_1_].rateType == 5 then
    elseif _UPVALUE0_[_ARG_1_].rateType == 6 then
    elseif _UPVALUE0_[_ARG_1_].rateType == 7 then
    elseif _UPVALUE0_[_ARG_1_].rateType == 8 then
    end
    if _ARG_0_:getRate_p1(_ARG_1_, _ARG_2_) > Script.Random() then
      return 1
    elseif _ARG_0_:getRate_p2(_ARG_1_, _ARG_2_) + _ARG_0_:getRate_p1(_ARG_1_, _ARG_2_) > Script.Random() then
      return 2
    elseif _ARG_0_:getRate_p3(_ARG_1_, _ARG_2_) + (_ARG_0_:getRate_p2(_ARG_1_, _ARG_2_) + _ARG_0_:getRate_p1(_ARG_1_, _ARG_2_)) > Script.Random() then
      return 3
    elseif _ARG_0_:getRate_p4(_ARG_1_, _ARG_2_) + (_ARG_0_:getRate_p3(_ARG_1_, _ARG_2_) + (_ARG_0_:getRate_p2(_ARG_1_, _ARG_2_) + _ARG_0_:getRate_p1(_ARG_1_, _ARG_2_))) > Script.Random() then
      return 4
    elseif _ARG_0_:getRate_p5(_ARG_1_, _ARG_2_) + (_ARG_0_:getRate_p4(_ARG_1_, _ARG_2_) + (_ARG_0_:getRate_p3(_ARG_1_, _ARG_2_) + (_ARG_0_:getRate_p2(_ARG_1_, _ARG_2_) + _ARG_0_:getRate_p1(_ARG_1_, _ARG_2_)))) > Script.Random() then
      return 5
    elseif _ARG_0_:getRate_p6(_ARG_1_, _ARG_2_) + (_ARG_0_:getRate_p5(_ARG_1_, _ARG_2_) + (_ARG_0_:getRate_p4(_ARG_1_, _ARG_2_) + (_ARG_0_:getRate_p3(_ARG_1_, _ARG_2_) + (_ARG_0_:getRate_p2(_ARG_1_, _ARG_2_) + _ARG_0_:getRate_p1(_ARG_1_, _ARG_2_))))) > Script.Random() then
      return 6
    elseif _ARG_0_:getRate_p7(_ARG_1_, _ARG_2_) + (_ARG_0_:getRate_p6(_ARG_1_, _ARG_2_) + (_ARG_0_:getRate_p5(_ARG_1_, _ARG_2_) + (_ARG_0_:getRate_p4(_ARG_1_, _ARG_2_) + (_ARG_0_:getRate_p3(_ARG_1_, _ARG_2_) + (_ARG_0_:getRate_p2(_ARG_1_, _ARG_2_) + _ARG_0_:getRate_p1(_ARG_1_, _ARG_2_)))))) > Script.Random() then
      return 7
    elseif _ARG_0_:getRate_p8(_ARG_1_, _ARG_2_) + (_ARG_0_:getRate_p7(_ARG_1_, _ARG_2_) + (_ARG_0_:getRate_p6(_ARG_1_, _ARG_2_) + (_ARG_0_:getRate_p5(_ARG_1_, _ARG_2_) + (_ARG_0_:getRate_p4(_ARG_1_, _ARG_2_) + (_ARG_0_:getRate_p3(_ARG_1_, _ARG_2_) + (_ARG_0_:getRate_p2(_ARG_1_, _ARG_2_) + _ARG_0_:getRate_p1(_ARG_1_, _ARG_2_))))))) > Script.Random() then
      return 8
    end
  end,
  PlayerSearch = function(_ARG_0_, _ARG_1_)
    _UPVALUE0_:set(0, 1, 0)
    if Entity.IsTargetWithinFOV(_ARG_0_.myHandle, _ARG_1_, DegToRad(_UPVALUE1_.Blinds), 0) == false then
      print("\142\128\138p\n")
      return _UPVALUE2_
    end
    if Entity.IsTargetWithinFOV(_ARG_0_.myHandle, _ARG_1_, DegToRad(_UPVALUE1_.TrunFOV), 36, _UPVALUE0_) or Entity.GetCurrentMotion(_ARG_1_) ~= Entity.GetMotionIndex(_ARG_1_, "001") then
      if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_1_) < _UPVALUE1_.SearchDistShort then
        print("\148F\146m\148\205\136\205\129@\139\223\139\151\151\163\n")
      elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_1_) < _UPVALUE1_.SearchDistLong then
        print("\148F\146m\148\205\136\205\129@\146\134\139\151\151\163\n")
      else
        print("\148F\146m\148\205\136\205\129@\146\183\139\151\151\163\n")
      end
    elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_1_) < _UPVALUE1_.SearchDistShort then
      print("\138\180\146m\148\205\136\205\129@\139\223\139\151\151\163\n")
    elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_1_) < _UPVALUE1_.SearchDistLong then
      print("\138\180\146m\148\205\136\205\129@\146\134\139\151\151\163\n")
    else
      print("\138\180\146m\148\205\136\205\129@\146\183\139\151\151\163\n")
    end
    return _UPVALUE8_
  end,
  checkHP = function(_ARG_0_, _ARG_1_, _ARG_2_)
    if _ARG_1_ == 0 or _ARG_2_ == 0 then
      return 0
    end
    return _ARG_1_ / _ARG_2_
  end,
  PlayersNimHP = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
    if _ARG_2_ ~= NULL_HANDLE then
      if Player.GetPlayerState(_ARG_2_) == PLAYER_STATE_ILLUSION then
        print("handle1 \131C\131\138\131\133\129[\131W\131\135\131\147\146\134\130\197\130\160\130\233 hp1 = " .. (Entity.GetHp(_ARG_2_) + 1) * 1000 .. "\n")
      elseif 0 < Entity.GetHp(_ARG_2_) then
        print("handle1 HP0\136\200\143\227\n")
      else
        print("handle1 \142\128\150S\130\181\130\196\130\233\n")
      end
    end
    if _ARG_3_ ~= NULL_HANDLE then
      if Player.GetPlayerState(_ARG_3_) == PLAYER_STATE_ILLUSION then
        print("\131C\131\138\131\133\129[\131W\131\135\131\147\146\134\130\197\130\160\130\233 hp2 = " .. (Entity.GetHp(_ARG_3_) + 1) * 1000 .. "\n")
      elseif 0 < Entity.GetHp(_ARG_3_) then
        print("handle2 HP 0\136\200\143\227\n")
      else
        print("handle2 \142\128\150S\130\181\130\196\130\233\n")
      end
    end
    if _ARG_4_ ~= NULL_HANDLE then
      if Player.GetPlayerState(_ARG_4_) == PLAYER_STATE_ILLUSION then
        print("handle3 \131C\131\138\131\133\129[\131W\131\135\131\147\146\134\130\197\130\160\130\233 hp3 = " .. (Entity.GetHp(_ARG_4_) + 1) * 1000 .. "\n")
      elseif 0 < Entity.GetHp(_ARG_4_) then
        print("handle3 HP0\136\200\143\227\n")
      else
        print("handle3 \142\128\150S\130\181\130\196\130\233\n")
      end
    end
    if 9999 > Entity.GetHp(_ARG_2_) then
    end
    if Entity.GetHp(_ARG_3_) < Entity.GetHp(_ARG_2_) then
    end
    if Entity.GetHp(_ARG_4_) < Entity.GetHp(_ARG_3_) then
    end
    if 0 + 1 + 1 + 1 == 1 then
    elseif 0 + 1 + 1 + 1 == 2 then
    elseif 0 + 1 + 1 + 1 == 3 then
      if Entity.GetHp(_ARG_2_) > Entity.GetHp(_ARG_3_) and Entity.GetHp(_ARG_2_) > Entity.GetHp(_ARG_4_) and Entity.GetHp(_ARG_3_) == Entity.GetHp(_ARG_4_) then
      end
      if Entity.GetHp(_ARG_2_) < Entity.GetHp(_ARG_3_) and Entity.GetHp(_ARG_3_) > Entity.GetHp(_ARG_4_) and Entity.GetHp(_ARG_2_) == Entity.GetHp(_ARG_4_) then
      end
      if Entity.GetHp(_ARG_2_) < Entity.GetHp(_ARG_4_) and Entity.GetHp(_ARG_3_) < Entity.GetHp(_ARG_4_) and Entity.GetHp(_ARG_2_) == Entity.GetHp(_ARG_3_) then
      end
    end
    if 0 + 1 + 1 + 1 == 2 then
      if 1 == 1 then
        if Entity.GetHp(_ARG_4_) == Entity.GetHp(_ARG_3_) then
        end
      elseif 1 == 1 then
        if Entity.GetHp(_ARG_2_) == Entity.GetHp(_ARG_4_) then
        end
      elseif 1 == 1 and Entity.GetHp(_ARG_2_) == Entity.GetHp(_ARG_3_) then
      end
    end
    return (_ARG_0_:GetShotDistHandle(_ARG_2_, _ARG_3_))
  end,
  GetShotDistHandle = function(_ARG_0_, _ARG_1_, _ARG_2_)
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_1_) < Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_2_) then
    else
    end
    return _ARG_2_
  end,
  SetingState = function(_ARG_0_)
    print("+++++\146n\143\227\141s\147\174\145I\145\240++++++++++++++;\n")
    _ARG_0_.stack:clear()
    _ARG_0_.stack:push("Idling")
    if _ARG_0_.damageFlag == 1 then
      print("\137\241\148\240\141s\147\174\130\214\n")
      _ARG_0_:SetingState_Evasion()
      _ARG_0_.damageFlag = 0
      return
    end
    print("self.attackFlag = " .. _ARG_0_.attackFlag .. "\n")
    if _ARG_0_.attackFlag >= _UPVALUE0_.ChangeAppendNum then
      _ARG_0_:changeKeyMode()
      if Script.Random() < 0.2 then
        RsetAttackFlags(_ARG_0_)
      end
      return
    end
    if _ARG_0_:PlayerSearch(_ARG_0_.targetHandle) == _UPVALUE1_ or _ARG_0_:PlayerSearch(_ARG_0_.targetHandle) == _UPVALUE2_ then
      if _ARG_0_:checkRate(1, 0) == 1 then
        print("\146\134\139\151\151\163\141U\140\130\130\214\n")
        _ARG_0_:MediumAttackState()
        _ARG_0_.stack:push("Goes_away")
        print("\151\163\130\234\130\233\n")
        return
      else
        print("\139\223\139\151\151\163\141U\140\130\130\214\n")
        _ARG_0_:ShortAttackState()
        return
      end
    end
    if _ARG_0_:PlayerSearch(_ARG_0_.targetHandle) == _UPVALUE1_ or _ARG_0_:PlayerSearch(_ARG_0_.targetHandle) == _UPVALUE3_ or _ARG_0_:PlayerSearch(_ARG_0_.targetHandle) == _UPVALUE4_ then
      if _ARG_0_:PlayerSearch(_ARG_0_.targetHandle) == _UPVALUE4_ then
      elseif _ARG_0_:checkRate(3, 0) == 1 then
        print("\139\223\139\151\151\163\141U\140\130\130\214\n")
        _ARG_0_:ShortAttackState()
        print("\139\223\130\195\130\173\n")
        _ARG_0_:checkApproacheToSonicImpact()
        return
      elseif _ARG_0_:checkRate(3, 0) == 2 then
        print("\141\130\145\172\136\218\147\174\n")
        _ARG_0_.stack:push("SonicImpact")
        return
      else
        print("\146\134\139\151\151\163\141U\140\130\130\214\n")
        _ARG_0_:MediumAttackState()
        return
      end
    elseif _ARG_0_:checkRate(2, 0) == 1 then
      print("\137E\144\249\137\241\n")
      _ARG_0_.stack:push("RightTrun")
      return
    else
      print("\141\182\144\249\137\241\n")
      _ARG_0_.stack:push("LeftTrun")
      return
    end
    if _ARG_0_.heelFlag == 1 or CheckSetCureCommand(_ARG_0_.myHandle, _ARG_0_.targetHandle) == 1 then
      if _ARG_0_:checkHP(Entity.GetHp(_ARG_0_.targetHandle), Entity.GetHpMax(_ARG_0_.targetHandle)) < 0.5 then
        print("\145\206\143\219PC\130\170HP\130T\130O\129\147\150\162\150\158\n")
        if _ARG_0_:checkRate(4, 0) == 1 then
          print("\139\223\139\151\151\163\141U\140\130\130\214\n")
          _ARG_0_:ShortAttackState()
          print("\130\224\130\164\136\234\147x\141s\147\174\130\240\145I\145\240\130\183\130\233\129B\n")
          _ARG_0_:checkApproacheToSonicImpact()
          return
        end
        print("\142\159\130\204\131X\131e\131b\131v\130\214\n")
      end
    else
      _ARG_0_:checkApproacheToSonicImpact()
      return
    end
    if _ARG_0_:checkRate(5, 0) == 1 then
      print("\139\223\139\151\151\163\141U\140\130\130\214\n")
      _ARG_0_:ShortAttackState()
      print("\139\223\130\195\130\173\n")
      _ARG_0_:checkApproacheToSonicImpact()
      return
    elseif _ARG_0_:checkRate(5, 0) == 1 then
      print("\141\130\145\172\136\218\147\174\n")
      _ARG_0_.stack:push("SonicImpact")
      return
    else
      print("\137\147\139\151\151\163\141U\140\130\130\214\n")
      _ARG_0_:DistanceAttackState()
      return
    end
  end,
  SetingState_Air = function(_ARG_0_)
    print("+++++\139\243\146\134\141s\147\174\145I\145\240++++++++++++++;\n")
    _ARG_0_.stack:clear()
    _ARG_0_.stack:push("Idling")
    if _ARG_0_.damageFlag == 1 then
      print("\139\243\146\134\137\241\148\240\141s\147\174\130\214\n")
      _ARG_0_:SetingState_AirEvasion()
      _ARG_0_.damageFlag = 0
      return
    end
    if _ARG_0_.attackFlag >= _UPVALUE0_.ChangeAppendNum then
      _ARG_0_:changeKeyMode()
      _ARG_0_.attackFlag = 0
      return
    end
    if _ARG_0_:PlayerSearch(_ARG_0_.targetHandle) == _UPVALUE1_ or _ARG_0_:PlayerSearch(_ARG_0_.targetHandle) == _UPVALUE2_ then
      if Script.Random() < 0.2 then
        print("\151\163\130\234\130\233\n")
        if Script.Random() < 0.5 then
          print("\148\242\141s\146\134\139\151\151\163\141U\140\130\130\214\n")
          _ARG_0_:MediumAttackState()
          _ARG_0_.stack:push("Goes_awayAirMove")
        else
          print("\148\242\141s\146\134\139\151\151\163\141U\140\130\130\214\n")
          _ARG_0_:MediumAttackState()
        end
        return
      else
        print("\148\242\141s\146\134\139\151\151\163\141U\140\130\130\214\n")
        _ARG_0_:MediumAttackState()
        return
      end
    end
    if _ARG_0_:PlayerSearch(_ARG_0_.targetHandle) == _UPVALUE1_ or _ARG_0_:PlayerSearch(_ARG_0_.targetHandle) == _UPVALUE3_ or _ARG_0_:PlayerSearch(_ARG_0_.targetHandle) == _UPVALUE4_ then
      if Script.Random() < 0.2 then
        print("\148\242\141s\146\134\139\151\151\163\141U\140\130\130\214\n")
        _ARG_0_:MediumAttackState()
        print("\148\242\141s\136\218\147\174\n")
        _ARG_0_.stack:push("AirMove")
        _ARG_0_:MediumAttackState()
        return
      else
        print("\148\242\141s\146\134\139\151\151\163\141U\140\130\130\214\n")
        _ARG_0_:MediumAttackState()
        return
      end
    elseif _ARG_0_:checkRate(6, 0) == 1 then
      print("\148\242\141s\137E\144\249\137\241\n")
      print("\148\242\141s\146\134\139\151\151\163\141U\140\130\130\214\n")
      _ARG_0_:MediumAttackState()
      print("\148\242\141s\136\218\147\174\n")
      _ARG_0_.stack:push("AirMove")
      _ARG_0_.stack:push("ApproacheAirMove")
      return
    else
      print("\148\242\141s\141\182\144\249\137\241\n")
      print("\148\242\141s\146\134\139\151\151\163\141U\140\130\130\214\n")
      _ARG_0_:MediumAttackState()
      print("\148\242\141s\136\218\147\174\n")
      _ARG_0_.stack:push("AirMove")
      _ARG_0_.stack:push("ApproacheAirMove")
      return
    end
    _ARG_0_:MediumAttackState()
  end,
  SetingState_Evasion = function(_ARG_0_)
    print("+++++\137\241\148\240\141s\147\174\145I\145\240++++++++++++++;\n")
    if _ARG_0_:PlayerSearch(_ARG_0_.targetHandle) == _UPVALUE0_ then
      print("\131_\131\129\129[\131W\130\214\n")
      return
    end
    if _UPVALUE1_.KeyMode == _UPVALUE2_ then
    else
      if Script.Random() < 0.5 then
        print("\142\243\130\175\151\172\130\181\130\214\n")
        print("\142\243\130\175\151\172\130\181\140\227\n")
        if _ARG_0_:checkRate(30, 0) == 1 then
          if _ARG_0_:checkRate(31, 0) == 1 then
            print("\146n\143\227\141s\147\174\130\214\n")
          else
            print("\144\218\139\223\141U\140\130\130\214\n")
            _ARG_0_:ShortAttackState()
          end
        else
          print("\131K\129[\131h\n")
          _ARG_0_.stack:push("Guard")
        end
      else
        print("\131K\129[\131h\130\214\n")
        _ARG_0_.stack:push("Guard")
        print("\144\172\140\247\130\200\130\231\146n\143\227\141s\147\174\130\214n")
      end
      _ARG_0_.stack:push("ParryStart")
      return
    end
    print("\131V\129[\131\139\131h\131K\129[\131h\138J\142nn")
  end,
  SetingState_AirEvasion = function(_ARG_0_)
    print("+++++\137\241\148\240\141s\147\174\145I\145\240++++++++++++++;\n")
    if _ARG_0_:PlayerSearch(_ARG_0_.targetHandle) == _UPVALUE0_ then
      print("\131_\131\129\129[\131W\130\214n")
      return
    end
    if _ARG_0_:checkRate(30, 0) == 1 then
      print("\131E\131B\131\147\131O\131J\131b\131^\129[\130\214\n")
      _ARG_0_.stack:push("WincCutter")
    elseif _ARG_0_:checkRate(30, 0) == 2 then
      print("\142\139\138E\147\224\141\197\147K\146n\130\214\136\218\147\174\n")
    else
      print("\131A\131y\131\147\131h\137\240\143\156\n")
      print("\146\133\146n\n")
      print("\146n\143\227\141s\147\174\130\214\n")
    end
  end,
  BurstImpactCheck = function(_ARG_0_)
    return 6.6666665 * (_UPVALUE0_.AttackPow + _UPVALUE0_.MagicPow) * 0.01
  end,
  ShortAttackState = function(_ARG_0_)
    print("ShortAttackState\n")
    if _UPVALUE0_.KeyMode == _UPVALUE1_ then
      if _ARG_0_:checkRate(7, 0) == 1 then
        print("\131_\129[\131N\131{\131\140\129[\130\214\n")
        _ARG_0_.stack:push("DarkBolley")
      elseif _ARG_0_:checkRate(7, 0) == 2 then
        print("\131L\129[\131u\131\140\129[\131h\131o\131\137\129[\131W\131\133\130\214\n")
        _ARG_0_.stack:push("KeyBalazs")
      elseif _ARG_0_:checkRate(7, 0) == 3 then
        print("\152A\145\177\141U\140\1301\130\214\n")
        print("\130\187\130\204\140\227\129@")
        if _ARG_0_:checkRate(8, 0) == 1 then
          print("\131O\131\137\131b\131v\131\139\130\214\n")
          _ARG_0_.stack:push("Grapple")
        elseif _ARG_0_:checkRate(8, 0) == 2 then
          print("\131\131j\131b\131N\131E\131F\129[\131u\130\214\n")
          _ARG_0_.stack:push("SonicWave")
        elseif _ARG_0_:checkRate(8, 0) == 3 then
          print("\131V\131\133\129[\131g\131X\131g\131\137\131C\131N\130\214\n")
          _ARG_0_.stack:push("ShootStrike")
        else
          print("\137\189\130\224\130\181\130\200\130\162\130\214\n")
        end
        _ARG_0_.stack:push("KonboAttack1")
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _UPVALUE0_.SearchDistShort2 then
          _ARG_0_:checkApproacheToSonicImpact()
        end
      elseif _ARG_0_:checkRate(7, 0) == 4 then
        _ARG_0_.stack:push("KonboAttack2")
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _UPVALUE0_.SearchDistShort2 then
          _ARG_0_:checkApproacheToSonicImpact()
        end
      else
        print("\145\149\148\245\149\207\141X\130\214\n")
        _ARG_0_:changeKeyMode()
      end
    elseif _UPVALUE0_.KeyMode == _UPVALUE2_ then
      if _ARG_0_:checkRate(11, 0) == 1 then
        print("\131_\129[\131N\131{\131\140\129[\130\214\n")
        _ARG_0_.stack:push("DarkBolley")
      elseif _ARG_0_:checkRate(11, 0) == 2 then
        print("\131L\129[\131u\131\140\129[\131h\131o\131\137\129[\131W\131\133\130\214\n")
        _ARG_0_.stack:push("KeyBalazs")
      elseif _ARG_0_:checkRate(11, 0) == 3 then
        print("\131X\131g\131\140\129[\131g\131u\131\141\129[\130\214\n")
        _ARG_0_.stack:push("StraightBlow")
      elseif _ARG_0_:checkRate(11, 0) == 4 then
        print("\131O\131\137\131b\131v\131\139\130\214\n")
        _ARG_0_.stack:push("Grapple")
      else
        print("\145\149\148\245\149\207\141X\130\214\n")
        _ARG_0_:changeKeyMode()
      end
      if 1 == 1 then
        _ARG_0_:checkApproacheToSonicImpact()
      end
    elseif _UPVALUE0_.KeyMode == _UPVALUE3_ then
      hprate = _ARG_0_:RestHpRate()
      if hprate > 0.5 then
      elseif _ARG_0_.SinpactFlareFlag == 0 then
        print("\131X\131^\131\147\131v\131C\131\147\131p\131N\131g\130\214\n")
        print("50%\130\190\130\169\130\231\151D\144\230\130\183\130\233\130\230\129B\n")
        _ARG_0_.stack:push("StanInpact")
        _ARG_0_.SinpactFlareFlag = 1
        return
      end
      if _ARG_0_:checkRate(12, 0) == 1 then
        print("\131_\129[\131N\131{\131\140\129[\130\214\n")
        _ARG_0_.stack:push("DarkBolley")
      elseif _ARG_0_:checkRate(12, 0) == 2 then
        print("\131L\129[\131u\131\140\129[\131h\131o\131\137\129[\131W\131\133\130\214\n")
        _ARG_0_.stack:push("KeyBalazs")
      elseif _ARG_0_:checkRate(12, 0) == 3 then
        print("\131\131j\131b\131N\131E\131F\129[\131u\130\214\n")
        _ARG_0_.stack:push("SonicWave")
      elseif _ARG_0_:checkRate(12, 0) == 4 then
        print("\131V\131\133\129[\131g\131X\131g\131\137\131C\131N\130\214\n")
        _ARG_0_.stack:push("ShootStrike")
      elseif _ARG_0_:checkRate(12, 0) == 5 then
        print("\131X\131^\131\147\131v\131C\131\147\131p\131N\131g\130\214\n")
        _ARG_0_.stack:push("StanInpact")
      else
        print("\145\149\148\245\149\207\141X\130\214\n")
        _ARG_0_:changeKeyMode()
      end
    elseif _UPVALUE0_.KeyMode == _UPVALUE4_ then
      hprate = _ARG_0_:RestHpRate()
      if hprate > 0.5 then
      elseif _ARG_0_.burstFlareFlag == 0 then
        print("\131o\129[\131X\131g\131C\131\147\131p\131N\131g\130\214\n")
        print("50%\130\190\130\169\130\231\151D\144\230\130\183\130\233\130\230\129B\n")
        _ARG_0_.stack:push("BarnImpact")
        _ARG_0_.burstFlareFlag = 1
        return
      end
      if _ARG_0_:BurstImpactCheck() > Script.Random() then
        print("\131o\129[\131X\131g\131C\131\147\131p\131N\131g\130\214\n")
        _ARG_0_.stack:push("BarnImpact")
      elseif _ARG_0_:checkRate(13, 0) == 1 then
        print("\131_\129[\131N\131{\131\140\129[\130\214\n")
        _ARG_0_.stack:push("DarkBolley")
      elseif _ARG_0_:checkRate(13, 0) == 2 then
        print("\131L\129[\131u\131\140\129[\131h\131o\131\137\129[\131W\131\133\130\214\n")
        _ARG_0_.stack:push("KeyBalazs")
      elseif _ARG_0_:checkRate(13, 0) == 3 then
        print("\131o\129[\131X\131g\131C\131\147\131p\131N\131g\130\214\n")
        _ARG_0_.stack:push("BarnImpact")
      else
        print("\145\149\148\245\149\207\141X\130\214\n")
        _ARG_0_:changeKeyMode()
      end
    elseif _UPVALUE0_.KeyMode == _UPVALUE5_ then
      hprate = _ARG_0_:RestHpRate()
      if hprate > 0.5 then
      elseif _ARG_0_.gigaFlareFlag == 0 then
        print("\131M\131K\131t\131\140\131A\130\214\n")
        print("50%\130\190\130\169\130\231\151D\144\230\130\183\130\233\130\230\129B\n")
        _ARG_0_.stack:push("DarkGigaFlare")
        _ARG_0_.gigaFlareFlag = 1
        return
      end
      if _ARG_0_:checkRate(14, 0) == 1 then
        print("\131_\129[\131N\131{\131\140\129[\130\214\n")
        _ARG_0_.stack:push("AirDarkBolley")
      elseif _ARG_0_:checkRate(14, 0) == 2 then
        print("\131L\129[\131u\131\140\129[\131h\131o\131\137\129[\131W\131\133\130\214\n")
        _ARG_0_.stack:push("AirKeyBalazs")
      elseif _ARG_0_:checkRate(14, 0) == 3 then
        print("\131E\131C\131\147\131O\131J\131b\131^\129[\130\214\n")
        _ARG_0_.stack:push("WincCutter")
      elseif _ARG_0_:checkRate(14, 0) == 4 then
        print("\131M\131K\131t\131\140\131A\130\214\n")
        _ARG_0_.stack:push("DarkGigaFlare")
      else
        print("\145\149\148\245\149\207\141X\130\214\n")
        _ARG_0_:changeKeyMode()
      end
    end
  end,
  MediumAttackState = function(_ARG_0_)
    print("ShortAttackState\n")
    if _UPVALUE0_.KeyMode == _UPVALUE1_ then
      if _ARG_0_:checkRate(15, 0) == 1 then
        print("\131_\129[\131N\131{\131\140\129[\130\214\n")
        _ARG_0_.stack:push("DarkBolley")
      elseif _ARG_0_:checkRate(15, 0) == 2 then
        print("\131L\129[\131u\131\140\129[\131h\131o\131\137\129[\131W\131\133\130\214\n")
        _ARG_0_.stack:push("KeyBalazs")
      elseif _ARG_0_:checkRate(15, 0) == 3 then
        print("\141\130\145\172\136\218\147\174\130\214\n")
        _ARG_0_.stack:push("SonicImpact")
      elseif _ARG_0_:checkRate(15, 0) == 4 then
        print("\142\158\138\212\152p\139\200\130\214\n")
        _ARG_0_.stack:push("TimeOperation")
      elseif _ARG_0_:checkRate(15, 0) == 5 then
        print("\136\197\130\166\130\204\151U\130\162\130\214\n")
        _ARG_0_.stack:push("Invitation_to_the_dark")
      else
        print("\145\149\148\245\149\207\141X\130\214\n")
        _ARG_0_:changeKeyMode()
      end
    elseif _UPVALUE0_.KeyMode == _UPVALUE2_ then
      if _ARG_0_:checkRate(16, 0) == 1 then
        print("\131_\129[\131N\131{\131\140\129[\130\214\n")
        _ARG_0_.stack:push("DarkBolley")
      elseif _ARG_0_:checkRate(16, 0) == 2 then
        print("\131L\129[\131u\131\140\129[\131h\131o\131\137\129[\131W\131\133\130\214\n")
        _ARG_0_.stack:push("KeyBalazs")
      elseif _ARG_0_:checkRate(16, 0) == 3 then
        print("\141\130\145\172\136\218\147\174\130\214\n")
        _ARG_0_.stack:push("SonicImpact")
      elseif _ARG_0_:checkRate(16, 0) == 4 then
        print("\131X\131g\131\140\129[\131g\131u\131\141\129[\130\214\n")
        _ARG_0_.stack:push("StraightBlow")
      elseif _ARG_0_:checkRate(16, 0) == 5 then
        print("\142\158\138\212\152p\139\200\130\214\n")
        _ARG_0_.stack:push("TimeOperation")
      elseif _ARG_0_:checkRate(16, 0) == 6 then
        print("\136\197\130\166\130\204\151U\130\162\130\214\n")
        _ARG_0_.stack:push("Invitation_to_the_dark")
      else
        print("\145\149\148\245\149\207\141X\130\214\n")
        _ARG_0_:changeKeyMode()
      end
    elseif _UPVALUE0_.KeyMode == _UPVALUE3_ then
      hprate = _ARG_0_:RestHpRate()
      if hprate > 0.5 then
      elseif _ARG_0_.SinpactFlareFlag == 0 then
        print("\131X\131^\131\147\131v\131C\131\147\131p\131N\131g\130\214\n")
        print("50%\130\190\130\169\130\231\151D\144\230\130\183\130\233\130\230\129B\n")
        _ARG_0_.stack:push("StanInpact")
        _ARG_0_.SinpactFlareFlag = 1
        return
      end
      if _ARG_0_:checkRate(17, 0) == 1 then
        print("\131_\129[\131N\131{\131\140\129[\130\214\n")
        _ARG_0_.stack:push("DarkBolley")
      elseif _ARG_0_:checkRate(17, 0) == 2 then
        print("\131L\129[\131u\131\140\129[\131h\131o\131\137\129[\131W\131\133\130\214\n")
        _ARG_0_.stack:push("KeyBalazs")
      elseif _ARG_0_:checkRate(17, 0) == 3 then
        print("\141\130\145\172\136\218\147\174\130\214\n")
        _ARG_0_.stack:push("SonicImpact")
      elseif _ARG_0_:checkRate(17, 0) == 4 then
        print("\131\131j\131b\131N\131E\131F\129[\131u\130\214\n")
        _ARG_0_.stack:push("SonicWave")
      elseif _ARG_0_:checkRate(17, 0) == 5 then
        print("\131X\131^\131\147\131v\131C\131\147\131p\131N\131g\n")
        _ARG_0_.stack:push("StanInpact")
      elseif _ARG_0_:checkRate(17, 0) == 6 then
        print("\142\158\138\212\152p\139\200\130\214\n")
        _ARG_0_.stack:push("TimeOperation")
      elseif _ARG_0_:checkRate(17, 0) == 7 then
        print("\136\197\130\166\130\204\151U\130\162\130\214\n")
        _ARG_0_.stack:push("Invitation_to_the_dark")
      else
        print("\145\149\148\245\149\207\141X\130\214\n")
        _ARG_0_:changeKeyMode()
      end
    elseif _UPVALUE0_.KeyMode == _UPVALUE4_ then
      if _ARG_0_:BurstImpactCheck() > Script.Random() then
        print("\131o\129[\131X\131g\131C\131\147\131p\131N\131g\130\214\n")
        _ARG_0_.stack:push("BarnImpact")
      elseif _ARG_0_:checkRate(18, 0) == 1 then
        print("\131_\129[\131N\131{\131\140\129[\130\214\n")
        _ARG_0_.stack:push("DarkBolley")
      elseif _ARG_0_:checkRate(18, 0) == 2 then
        print("\131L\129[\131u\131\140\129[\131h\131o\131\137\129[\131W\131\133\130\214\n")
        _ARG_0_.stack:push("KeyBalazs")
      elseif _ARG_0_:checkRate(18, 0) == 3 then
        print("\131o\129[\131X\131g\131C\131\147\131p\131N\131g\130\214\n")
        _ARG_0_.stack:push("BarnImpact")
      elseif _ARG_0_:checkRate(18, 0) == 4 then
        print("\142\158\138\212\152p\139\200\130\214\n")
        _ARG_0_.stack:push("TimeOperation")
      elseif _ARG_0_:checkRate(18, 0) == 5 then
        print("\136\197\130\166\130\204\151U\130\162\130\214\n")
        _ARG_0_.stack:push("Invitation_to_the_dark")
      else
        print("\145\149\148\245\149\207\141X\130\214\n")
        _ARG_0_:changeKeyMode()
      end
    elseif _UPVALUE0_.KeyMode == _UPVALUE5_ then
      hprate = _ARG_0_:RestHpRate()
      if hprate > 0.5 then
      elseif _ARG_0_.gigaFlareFlag == 0 then
        print("\131M\131K\131t\131\140\131A\130\214\n")
        print("50%\130\190\130\169\130\231\151D\144\230\130\183\130\233\130\230\129B\n")
        _ARG_0_.stack:push("DarkGigaFlare")
        _ARG_0_.gigaFlareFlag = 1
        return
      end
      if _ARG_0_:checkRate(19, 0) == 1 then
        print("\131_\129[\131N\131{\131\140\129[\130\214\n")
        _ARG_0_.stack:push("AirDarkBolley")
      elseif _ARG_0_:checkRate(19, 0) == 2 then
        print("\131L\129[\131u\131\140\129[\131h\131o\131\137\129[\131W\131\133\130\214\n")
        _ARG_0_.stack:push("AirKeyBalazs")
      elseif _ARG_0_:checkRate(19, 0) == 3 then
        print("\131E\131C\131\147\131O\131J\131b\131^\129[\130\214\n")
        _ARG_0_.stack:push("WincCutter")
      elseif _ARG_0_:checkRate(19, 0) == 4 then
        print("\131_\129[\131N\131M\131K\131t\131\140\131A\130\214\n")
        _ARG_0_.stack:push("DarkGigaFlare")
      else
        print("\145\149\148\245\149\207\141X\130\214\n")
        _ARG_0_:changeKeyMode()
      end
    end
  end,
  DistanceAttackState = function(_ARG_0_)
    print("ShortAttackState\n")
    if _UPVALUE0_.KeyMode == _UPVALUE1_ then
      if _ARG_0_:checkRate(20, 0) == 1 then
        print("\131_\129[\131N\131{\131\140\129[\130\214\n")
        _ARG_0_.stack:push("DarkBolley")
      elseif _ARG_0_:checkRate(20, 0) == 2 then
        print("\131L\129[\131u\131\140\129[\131h\131o\131\137\129[\131W\131\133\130\214\n")
        _ARG_0_.stack:push("KeyBalazs")
      elseif _ARG_0_:checkRate(20, 0) == 3 then
        print("\141\130\145\172\136\218\147\174\130\214\n")
      elseif _ARG_0_:checkRate(20, 0) == 4 then
        print("\142\158\138\212\152p\139\200\130\214\n")
        _ARG_0_.stack:push("TimeOperation")
      elseif _ARG_0_:checkRate(20, 0) == 5 then
        print("\136\197\130\166\130\204\151U\130\162\130\214\n")
        _ARG_0_.stack:push("Invitation_to_the_dark")
      else
        print("\145\149\148\245\149\207\141X\130\214\n")
        _ARG_0_:changeKeyMode()
      end
    elseif _UPVALUE0_.KeyMode == _UPVALUE2_ then
      if _ARG_0_:checkRate(21, 0) == 1 then
        print("\131_\129[\131N\131{\131\140\129[\130\214\n")
        _ARG_0_.stack:push("DarkBolley")
      elseif _ARG_0_:checkRate(21, 0) == 2 then
        print("\131L\129[\131u\131\140\129[\131h\131o\131\137\129[\131W\131\133\130\214\n")
        _ARG_0_.stack:push("KeyBalazs")
      elseif _ARG_0_:checkRate(21, 0) == 3 then
        print("\141\130\145\172\136\218\147\174\130\214\n")
      elseif _ARG_0_:checkRate(21, 0) == 4 then
        print("\131X\131g\131\140\129[\131g\131u\131\141\129[\130\214\n")
        _ARG_0_.stack:push("StraightBlow")
      elseif _ARG_0_:checkRate(21, 0) == 5 then
        print("\142\158\138\212\152p\139\200\130\214\n")
        _ARG_0_.stack:push("TimeOperation")
      elseif _ARG_0_:checkRate(21, 0) == 6 then
        print("\136\197\130\166\130\204\151U\130\162\130\214\n")
        _ARG_0_.stack:push("Invitation_to_the_dark")
      else
        print("\145\149\148\245\149\207\141X\130\214\n")
        _ARG_0_:changeKeyMode()
      end
    elseif _UPVALUE0_.KeyMode == _UPVALUE3_ then
      hprate = _ARG_0_:RestHpRate()
      if hprate > 0.5 then
      elseif _ARG_0_.SinpactFlareFlag == 0 then
        print("\131X\131^\131\147\131v\131C\131\147\131p\131N\131g\130\214\n")
        print("50%\130\190\130\169\130\231\151D\144\230\130\183\130\233\130\230\129B\n")
        _ARG_0_.stack:push("StanInpact")
        _ARG_0_.SinpactFlareFlag = 1
        return
      end
      if _ARG_0_:checkRate(22, 0) == 1 then
        print("\131_\129[\131N\131{\131\140\129[\130\214\n")
        _ARG_0_.stack:push("DarkBolley")
      elseif _ARG_0_:checkRate(22, 0) == 2 then
        print("\131L\129[\131u\131\140\129[\131h\131o\131\137\129[\131W\131\133\130\214\n")
        _ARG_0_.stack:push("KeyBalazs")
      elseif _ARG_0_:checkRate(22, 0) == 3 then
        print("\141\130\145\172\136\218\147\174\130\214\n")
      elseif _ARG_0_:checkRate(22, 0) == 4 then
        print("\131\131j\131b\131N\131E\131F\129[\131u\130\214\n")
      elseif _ARG_0_:checkRate(22, 0) == 5 then
        print("\142\158\138\212\152p\139\200\130\214\n")
        _ARG_0_.stack:push("TimeOperation")
      elseif _ARG_0_:checkRate(22, 0) == 6 then
        print("\136\197\130\166\130\204\151U\130\162\130\214\n")
        _ARG_0_.stack:push("Invitation_to_the_dark")
      else
        print("\145\149\148\245\149\207\141X\130\214\n")
        _ARG_0_:changeKeyMode()
      end
    elseif _UPVALUE0_.KeyMode == _UPVALUE4_ then
      if _ARG_0_:BurstImpactCheck() > Script.Random() then
        print("\131o\129[\131X\131g\131C\131\147\131p\131N\131g\130\214\n")
        _ARG_0_.stack:push("BarnImpact")
      elseif _ARG_0_:checkRate(23, 0) == 1 then
        print("\131_\129[\131N\131{\131\140\129[\130\214\n")
        _ARG_0_.stack:push("DarkBolley")
      elseif _ARG_0_:checkRate(23, 0) == 2 then
        print("\131L\129[\131u\131\140\129[\131h\131o\131\137\129[\131W\131\133\130\214\n")
        _ARG_0_.stack:push("KeyBalazs")
      elseif _ARG_0_:checkRate(23, 0) == 3 then
        print("\142\158\138\212\152p\139\200\130\214\n")
        _ARG_0_.stack:push("TimeOperation")
      elseif _ARG_0_:checkRate(23, 0) == 4 then
        print("\136\197\130\166\130\204\151U\130\162\130\214\n")
        _ARG_0_.stack:push("Invitation_to_the_dark")
      else
        print("\145\149\148\245\149\207\141X\130\214\n")
        _ARG_0_:changeKeyMode()
      end
    elseif _UPVALUE0_.KeyMode == _UPVALUE5_ then
      hprate = _ARG_0_:RestHpRate()
      if hprate > 0.5 then
      elseif _ARG_0_.gigaFlareFlag == 0 then
        print("\131M\131K\131t\131\140\131A\130\214\n")
        print("50%\130\190\130\169\130\231\151D\144\230\130\183\130\233\130\230\129B\n")
        _ARG_0_.stack:push("DarkGigaFlare")
        _ARG_0_.gigaFlareFlag = 1
        return
      end
      if _ARG_0_:checkRate(24, 0) == 1 then
        print("\131_\129[\131N\131{\131\140\129[\130\214\n")
        _ARG_0_.stack:push("AirDarkBolley")
      elseif _ARG_0_:checkRate(24, 0) == 2 then
        print("\131L\129[\131u\131\140\129[\131h\131o\131\137\129[\131W\131\133\130\214\n")
        _ARG_0_.stack:push("AirKeyBalazs")
      elseif _ARG_0_:checkRate(24, 0) == 3 then
        print("\131E\131C\131\147\131O\131J\131b\131^\129[\130\214\n")
        _ARG_0_.stack:push("WincCutter")
      elseif _ARG_0_:checkRate(24, 0) == 4 then
        print("\131_\129[\131N\131M\131K\131t\131\140\131A\130\214\n")
        _ARG_0_.stack:push("DarkGigaFlare")
      else
        print("\145\149\148\245\149\207\141X\130\214\n")
        _ARG_0_:changeKeyMode()
      end
    end
  end,
  keyChangeBeforeChange = function(_ARG_0_)
    if Script.Random() < _UPVALUE0_.ChangeAppendKyeMode then
      print("\131L\129[\131u\131\140\129[\131h\130\214\n")
      _ARG_0_.stack:push("Appending_InKeyBlade")
      if _UPVALUE0_.KeyMode == _UPVALUE1_ then
        _ARG_0_.stack:push("FallToLanding")
      end
      return true
    end
    return false
  end,
  changeKeyMode = function(_ARG_0_)
    print("self.attackFlag = " .. _ARG_0_.attackFlag .. "\n")
    if _ARG_0_.attackFlag <= 0 then
      return
    end
    if _UPVALUE0_.KeyMode == _UPVALUE1_ then
    elseif _ARG_0_:keyChangeBeforeChange() == true then
      return
    end
    if _UPVALUE0_.KeyMode == _UPVALUE1_ then
      if _ARG_0_:checkRate(25, 0) == 1 then
        print("\131A\129[\131\128\131A\131y\131\147\131h\130\214\n")
        _ARG_0_.stack:push("Appending_InArm")
      elseif _ARG_0_:checkRate(25, 0) == 2 then
        print("\131\140\131b\131O\131A\131y\131\147\131h\130\214\n")
        _ARG_0_.stack:push("Appending_InLeg")
      elseif _ARG_0_:checkRate(25, 0) == 3 then
        print("\131V\129[\131\139\131h\131A\131y\131\147\131h\130\214\n")
        _ARG_0_.stack:push("Appending_Shield")
      else
        print("\131E\131C\131\147\131O\131A\131y\131\147\131h\130\214\n")
        _ARG_0_.stack:push("Appending_InWing")
      end
    elseif _UPVALUE0_.KeyMode == _UPVALUE2_ then
      if _ARG_0_:checkRate(26, 0) == 1 then
        print("\131L\129[\131u\131\140\129[\131h\130\214\n")
        _ARG_0_.stack:push("Appending_InKeyBlade")
      elseif _ARG_0_:checkRate(26, 0) == 2 then
        print("\131\140\131b\131O\131A\131y\131\147\131h\130\214\n")
        _ARG_0_.stack:push("Appending_InLeg")
      elseif _ARG_0_:checkRate(26, 0) == 3 then
        print("\131V\129[\131\139\131h\131A\131y\131\147\131h\130\214\n")
        _ARG_0_.stack:push("Appending_Shield")
      else
        print("\131E\131C\131\147\131O\131A\131y\131\147\131h\130\214\130\214\n")
        _ARG_0_.stack:push("Appending_InWing")
      end
    elseif _UPVALUE0_.KeyMode == _UPVALUE3_ then
      if _ARG_0_:checkRate(27, 0) == 1 then
        print("\131L\129[\131u\131\140\129[\131h\130\214\n")
        _ARG_0_.stack:push("Appending_InKeyBlade")
      elseif _ARG_0_:checkRate(27, 0) == 2 then
        print("\131A\129[\131\128\131A\131y\131\147\131h\130\214\n")
        _ARG_0_.stack:push("Appending_InArm")
      elseif _ARG_0_:checkRate(27, 0) == 3 then
        print("\131V\129[\131\139\131h\131A\131y\131\147\131h\130\214\n")
        _ARG_0_.stack:push("Appending_Shield")
      else
        print("\131E\131C\131\147\131O\131A\131y\131\147\131h\130\214\130\214\n")
        _ARG_0_.stack:push("Appending_InWing")
      end
    elseif _UPVALUE0_.KeyMode == _UPVALUE4_ then
      if _ARG_0_:checkRate(27, 0) == 1 then
        print("\131L\129[\131u\131\140\129[\131h\130\214\n")
        _ARG_0_.stack:push("Appending_InKeyBlade")
      elseif _ARG_0_:checkRate(27, 0) == 2 then
        print("\131A\129[\131\128\131A\131y\131\147\131h\130\214\n")
        _ARG_0_.stack:push("Appending_InArm")
      elseif _ARG_0_:checkRate(27, 0) == 3 then
        print("\131\140\131b\131O\131A\131y\131\147\131h\130\214\n")
        _ARG_0_.stack:push("Appending_InLeg")
      else
        print("\131E\131C\131\147\131O\131A\131y\131\147\131h\130\214\130\214\n")
        _ARG_0_.stack:push("Appending_InWing")
      end
    elseif _UPVALUE0_.KeyMode == _UPVALUE5_ then
      if _ARG_0_:checkRate(27, 0) == 1 then
        print("\131L\129[\131u\131\140\129[\131h\130\214\n")
        _ARG_0_.stack:push("Appending_InKeyBlade")
      elseif _ARG_0_:checkRate(27, 0) == 2 then
        print("\131A\129[\131\128\131A\131y\131\147\131h\130\214\n")
        _ARG_0_.stack:push("Appending_InArm")
      elseif _ARG_0_:checkRate(27, 0) == 3 then
        print("\131\140\131b\131O\131A\131y\131\147\131h\130\214\n")
        _ARG_0_.stack:push("Appending_InLeg")
      else
        print("\131V\129[\131\139\131h\131y\131\147\131h\130\214\130\214\n")
        _ARG_0_.stack:push("Appending_Shield")
      end
      _ARG_0_.stack:push("FallToLanding")
    end
  end,
  setMotion = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    if _ARG_2_ == nil then
      _ARG_2_ = 0
    end
    if _ARG_3_ == nil then
      _ARG_3_ = 0
    end
    if _ARG_2_ == 0 or _ARG_3_ == 0 then
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_1_)
    else
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_1_, _ARG_2_, _ARG_3_)
    end
    if _UPVALUE0_.KeyMode == _UPVALUE1_ then
      Entity.SetMotion(_ARG_0_.KyeHandle, _ARG_1_)
    elseif _UPVALUE0_.KeyMode == _UPVALUE2_ then
      Entity.SetMotion(_ARG_0_.WindHandle, _ARG_1_)
    elseif _UPVALUE0_.KeyMode == _UPVALUE3_ then
      Entity.SetMotion(_ARG_0_.ArmHandle, _ARG_1_)
    elseif _UPVALUE0_.KeyMode == _UPVALUE4_ then
      Entity.SetMotion(_ARG_0_.LegHandle, _ARG_1_)
    elseif _UPVALUE0_.KeyMode == _UPVALUE5_ then
    end
  end,
  setMotion_NoSameCheck = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    if _ARG_2_ == nil then
      _ARG_2_ = 0
    end
    if _ARG_3_ == nil then
      _ARG_3_ = 0
    end
    if _ARG_2_ == 0 or _ARG_3_ == 0 then
      Entity.SetMotion(_ARG_0_.myHandle, _ARG_1_)
    else
      Entity.SetMotion(_ARG_0_.myHandle, _ARG_1_, _ARG_2_, _ARG_3_)
    end
    if _UPVALUE0_.KeyMode == _UPVALUE1_ then
      Entity.SetMotion(_ARG_0_.KyeHandle, _ARG_1_)
    elseif _UPVALUE0_.KeyMode == _UPVALUE2_ then
      Entity.SetMotion(_ARG_0_.WindHandle, _ARG_1_)
    elseif _UPVALUE0_.KeyMode == _UPVALUE3_ then
      Entity.SetMotion(_ARG_0_.ArmHandle, _ARG_1_)
    elseif _UPVALUE0_.KeyMode == _UPVALUE4_ then
      Entity.SetMotion(_ARG_0_.LegHandle, _ARG_1_)
    elseif _UPVALUE0_.KeyMode == _UPVALUE5_ then
      Entity.SetMotion(_ARG_0_.ShieldHandle, _ARG_1_)
    end
  end,
  checkApproacheToSonicImpact = function(_ARG_0_)
    if Script.Random() < 0.8 then
      _ARG_0_.stack:push("SonicImpact")
    else
      _ARG_0_.stack:push("Approache")
    end
  end,
  fadeOut = function(_ARG_0_, _ARG_1_)
    if _ARG_1_ == _UPVALUE0_ then
      Entity.SetupModelFade(_ARG_0_.KyeHandle, 1, 0, 10)
      Entity.SetupModelFade(_ARG_0_.WindHandle, 0, 0, 1)
      Entity.SetupModelFade(_ARG_0_.ArmHandle, 0, 0, 1)
      Entity.SetupModelFade(_ARG_0_.LegHandle, 0, 0, 1)
      Entity.SetupModelFade(_ARG_0_.ShieldHandle, 0, 0, 1)
    elseif _ARG_1_ == _UPVALUE1_ then
      Entity.SetupModelFade(_ARG_0_.WindHandle, 1, 0, 10)
      Entity.SetupModelFade(_ARG_0_.KyeHandle, 0, 0, 1)
      Entity.SetupModelFade(_ARG_0_.ArmHandle, 0, 0, 1)
      Entity.SetupModelFade(_ARG_0_.LegHandle, 0, 0, 1)
      Entity.SetupModelFade(_ARG_0_.ShieldHandle, 0, 0, 1)
    elseif _ARG_1_ == _UPVALUE2_ then
      Entity.SetupModelFade(_ARG_0_.ArmHandle, 1, 0, 10)
      Entity.SetupModelFade(_ARG_0_.WindHandle, 0, 0, 1)
      Entity.SetupModelFade(_ARG_0_.KyeHandle, 0, 0, 1)
      Entity.SetupModelFade(_ARG_0_.LegHandle, 0, 0, 1)
      Entity.SetupModelFade(_ARG_0_.ShieldHandle, 0, 0, 1)
    elseif _ARG_1_ == _UPVALUE3_ then
      Entity.SetupModelFade(_ARG_0_.LegHandle, 1, 0, 10)
      Entity.SetupModelFade(_ARG_0_.WindHandle, 0, 0, 1)
      Entity.SetupModelFade(_ARG_0_.ArmHandle, 0, 0, 1)
      Entity.SetupModelFade(_ARG_0_.KyeHandle, 0, 0, 1)
      Entity.SetupModelFade(_ARG_0_.ShieldHandle, 0, 0, 1)
    elseif _ARG_1_ == _UPVALUE4_ then
      Entity.SetupModelFade(_ARG_0_.ShieldHandle, 1, 0, 10)
      Entity.SetupModelFade(_ARG_0_.WindHandle, 0, 0, 1)
      Entity.SetupModelFade(_ARG_0_.ArmHandle, 0, 0, 1)
      Entity.SetupModelFade(_ARG_0_.LegHandle, 0, 0, 1)
      Entity.SetupModelFade(_ARG_0_.KyeHandle, 0, 0, 1)
      Entity.EnableBodyColl(_ARG_0_.ShieldHandle, 0)
      Entity.EnableDamageColl(_ARG_0_.ShieldHandle, 0)
      Entity.EnableLockonAndShooton(_ARG_0_.ShieldHandle, 0)
    end
    return _ARG_0_.ShieldHandle
  end,
  setAppend = function(_ARG_0_, _ARG_1_, _ARG_2_)
    _ARG_0_.oldoldKeyMode = _ARG_0_.oldKeyMode
    _ARG_0_.oldoldKeyModeCrearTime = 30
    _ARG_0_.oldKeyMode = _UPVALUE0_.KeyMode
    if _ARG_1_ == _UPVALUE0_.KeyMode then
      return
    end
    Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
    if _ARG_1_ == _UPVALUE1_ then
      _UPVALUE0_.KeyMode = _UPVALUE1_
      Entity.SetupModelFade(_ARG_0_.KyeHandle, 0, 1, 20)
      Entity.FadeoutEffectAttach(_ARG_0_.ShieldHandle, 0, -1)
      EntityManager:GetEntity(_ARG_0_.ShieldHandle):GotoState("Idling")
    elseif _ARG_1_ == _UPVALUE2_ then
      _UPVALUE0_.KeyMode = _UPVALUE2_
      Entity.SetupModelFade(_ARG_0_.WindHandle, 0, 1, 20)
      Entity.FadeoutEffectAttach(_ARG_0_.ShieldHandle, 0, -1)
      EntityManager:GetEntity(_ARG_0_.ShieldHandle):GotoState("Idling")
    elseif _ARG_1_ == _UPVALUE3_ then
      _UPVALUE0_.KeyMode = _UPVALUE3_
      Entity.SetupModelFade(_ARG_0_.ArmHandle, 0, 1, 20)
      Entity.FadeoutEffectAttach(_ARG_0_.ShieldHandle, 0, -1)
      EntityManager:GetEntity(_ARG_0_.ShieldHandle):GotoState("Idling")
    elseif _ARG_1_ == _UPVALUE4_ then
      _UPVALUE0_.KeyMode = _UPVALUE4_
      Entity.SetupModelFade(_ARG_0_.LegHandle, 0, 1, 20)
      Entity.FadeoutEffectAttach(_ARG_0_.ShieldHandle, 0, -1)
      EntityManager:GetEntity(_ARG_0_.ShieldHandle):GotoState("Idling")
    elseif _ARG_1_ == _UPVALUE5_ then
      _UPVALUE0_.KeyMode = _UPVALUE5_
      Entity.SetupModelFade(_ARG_0_.ShieldHandle, 0, 1, 20)
      Entity.EnableBodyColl(_ARG_0_.ShieldHandle, 1)
      Entity.EnableDamageColl(_ARG_0_.ShieldHandle, 1)
      Entity.EnableLockonAndShooton(_ARG_0_.ShieldHandle, 1)
      Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
      if Script.Random() < 0.5 then
        EntityManager:GetEntity(_ARG_0_.ShieldHandle):GotoState("Move_Magic")
      else
        EntityManager:GetEntity(_ARG_0_.ShieldHandle):GotoState("Move_Attack")
      end
    end
    if _ARG_2_ == nil and _ARG_0_.oldoldKeyMode ~= append then
      _UPVALUE6_:set(0, 0, 0)
      _UPVALUE6_:set(0, 0, 0)
      Entity.AttachEffect(_ARG_0_.ShieldHandle, "b85vs00", "B085_APP_APP0_0", "Root", _UPVALUE6_, _UPVALUE7_)
      Entity.AttachEffect(_ARG_0_:fadeOut(_ARG_0_.oldKeyMode), "b85vs00", "B085_APP_APP0_0", "Root", _UPVALUE6_, _UPVALUE7_)
    end
  end,
  CreateTimeOperation = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
    _UPVALUE0_.Flag = 1
    _UPVALUE1_:set(0, 0, 0)
    _UPVALUE2_:set(_ARG_1_, _ARG_2_, _ARG_3_)
    if Script.Random() < 0.33 then
    elseif Script.Random() < 0.666 then
    else
    end
    SetTimeParam(Entity.CreateEntity("g27vs00", _UPVALUE2_, _UPVALUE1_), 11, 5, 0.1, 5, 1800)
    SetTimeParam2(Entity.CreateEntity("g27vs00", _UPVALUE2_, _UPVALUE1_), 11, 4)
    SetTimeParam3(Entity.CreateEntity("g27vs00", _UPVALUE2_, _UPVALUE1_), 13, 1)
    Entity.EnableLockonAndShooton(Entity.CreateEntity("g27vs00", _UPVALUE2_, _UPVALUE1_), 0)
    _UPVALUE0_[_ARG_4_].handle = Entity.CreateEntity("g27vs00", _UPVALUE2_, _UPVALUE1_)
    _UPVALUE1_:set(0, 0, 0)
    _UPVALUE2_:set(_ARG_1_, _ARG_2_, _ARG_3_)
  end,
  IsTimeOperation = function(_ARG_0_)
    for _FORV_5_ = 0, 2 do
      if Entity.IsAlive(_UPVALUE0_[_FORV_5_].handle) then
      end
    end
    if 0 + 1 == 0 then
      _UPVALUE0_[0].handle = NULL_HANDLE
      _UPVALUE0_[1].handle = NULL_HANDLE
      _UPVALUE0_[2].handle = NULL_HANDLE
      for _FORV_5_ = 0, 5 do
        _UPVALUE1_[_FORV_5_].flag = 0
      end
    else
      return 1, 0 + 1
    end
    return 0, 0 + 1
  end,
  setTimeOpePosIndex = function(_ARG_0_)
    for _FORV_5_ = 0, 100 do
      if _UPVALUE0_[Script.RandomInteger(6)].flag == 0 then
        _UPVALUE0_[Script.RandomInteger(6)].flag = 1
        return (Script.RandomInteger(6))
      end
    end
    return (Script.RandomInteger(6))
  end,
  CreateKeyBalazs = function(_ARG_0_, _ARG_1_, _ARG_2_)
    if _UPVALUE0_.Number > 20 then
      return
    end
    for _FORV_8_ = 0, 9 do
      if Script.Random() < _FORV_8_ / 10 then
        break
      end
    end
    if _ARG_2_ == _FOR_ then
    end
    if _ARG_2_ ~= _UPVALUE1_ then
      Bullet.CreateEffectBullet(Bullet.CreateBullet("Balazs" .. _FORV_8_ .. "0", _UPVALUE2_, _UPVALUE3_), "b85vs00", "B085_KBA_LOC0_0")
    end
    Bullet.SetCollision(Bullet.CreateBullet("Balazs" .. _FORV_8_ .. "0", _UPVALUE2_, _UPVALUE3_), COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, _UPVALUE0_.CollSize, 0, _ARG_1_)
    SetBulletAttackParam(Bullet.CreateBullet("Balazs" .. _FORV_8_ .. "0", _UPVALUE2_, _UPVALUE3_), _ARG_0_.myHandle, 17)
    Entity.CalcVelocity(Bullet.CreateBullet("Balazs" .. _FORV_8_ .. "0", _UPVALUE2_, _UPVALUE3_), 0)
    Bullet.SetMaxMoveDist(Bullet.CreateBullet("Balazs" .. _FORV_8_ .. "0", _UPVALUE2_, _UPVALUE3_), 14400)
    Entity.SetRotateMode(Bullet.CreateBullet("Balazs" .. _FORV_8_ .. "0", _UPVALUE2_, _UPVALUE3_), 4)
    if 1 > Script.Random() * 3 then
    elseif 0 < 2 then
    else
    end
    Bullet.SetHitAttackEffectName(Bullet.CreateBullet("Balazs" .. _FORV_8_ .. "0", _UPVALUE2_, _UPVALUE3_), "b85vs00", "B085_KBA_HIT" .. 2 .. "_0")
    Bullet.SetHitBgEffectName(Bullet.CreateBullet("Balazs" .. _FORV_8_ .. "0", _UPVALUE2_, _UPVALUE3_), "b85vs00", "B085_KBA_LOS0_0")
    _UPVALUE4_:set(Script.Random() * 0.5 + 1, Script.Random() * 0.5 + 1, Script.Random() * 0.5 + 1)
    Entity.SetScale(Bullet.CreateBullet("Balazs" .. _FORV_8_ .. "0", _UPVALUE2_, _UPVALUE3_), _UPVALUE4_)
    Entity.GetRot(_UPVALUE5_, (Bullet.CreateBullet("Balazs" .. _FORV_8_ .. "0", _UPVALUE2_, _UPVALUE3_)))
    Entity.SetEffect(_ARG_0_.myHandle, "b85vs00", "B085_KBA_FIR0_0", _UPVALUE2_, _UPVALUE5_)
    _UPVALUE5_:setz(Script.Random() * PI)
    Entity.SetRot(Bullet.CreateBullet("Balazs" .. _FORV_8_ .. "0", _UPVALUE2_, _UPVALUE3_), _UPVALUE5_)
    EntityManager:GetEntity((Bullet.CreateBullet("Balazs" .. _FORV_8_ .. "0", _UPVALUE2_, _UPVALUE3_))).mode = _ARG_2_
    if _ARG_2_ == _UPVALUE6_ then
      EntityManager:GetEntity((Bullet.CreateBullet("Balazs" .. _FORV_8_ .. "0", _UPVALUE2_, _UPVALUE3_))).Speed = _UPVALUE0_.Speed
    elseif _ARG_2_ == _UPVALUE7_ then
    elseif _ARG_2_ == _UPVALUE8_ then
      EntityManager:GetEntity((Bullet.CreateBullet("Balazs" .. _FORV_8_ .. "0", _UPVALUE2_, _UPVALUE3_))).Speed = _UPVALUE0_.Speed + (Script.Random() * 0.1 - 0.05)
    elseif _ARG_2_ == _UPVALUE9_ then
      EntityManager:GetEntity((Bullet.CreateBullet("Balazs" .. _FORV_8_ .. "0", _UPVALUE2_, _UPVALUE3_))).Speed = _UPVALUE0_.Speed + (Script.Random() * 0.1 - 0.05)
    elseif _ARG_2_ == _UPVALUE1_ then
      EntityManager:GetEntity((Bullet.CreateBullet("Balazs" .. _FORV_8_ .. "0", _UPVALUE2_, _UPVALUE3_))).Speed = _UPVALUE0_.Speed2
      Bullet.EnableAttackCollision(Bullet.CreateBullet("Balazs" .. _FORV_8_ .. "0", _UPVALUE2_, _UPVALUE3_), 0)
    end
    EntityManager:GetEntity((Bullet.CreateBullet("Balazs" .. _FORV_8_ .. "0", _UPVALUE2_, _UPVALUE3_))).targetHandle = _ARG_0_.targetHandle
    EntityManager:GetEntity((Bullet.CreateBullet("Balazs" .. _FORV_8_ .. "0", _UPVALUE2_, _UPVALUE3_))).initDist = Entity.CalcDistanceXZ(Bullet.CreateBullet("Balazs" .. _FORV_8_ .. "0", _UPVALUE2_, _UPVALUE3_), _ARG_0_.targetHandle)
    _UPVALUE0_.Number = _UPVALUE0_.Number + 1
  end,
  CreateVolleyShoot = function(_ARG_0_, _ARG_1_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.targetHandle, 2)
    Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle, 2)
    _UPVALUE1_:setx(0)
    _UPVALUE1_:sety(0.5)
    _UPVALUE1_:setz(2.2)
    _UPVALUE3_:set(_UPVALUE1_:getx(), _UPVALUE1_:gety(), _UPVALUE1_:getz())
    _UPVALUE4_:setx(1 * Script.Random() * Math.Cos((RoundPI(Script.Random() * 2 * PI))))
    _UPVALUE4_:sety(1 * Script.Random() * Math.Sin((RoundPI(Script.Random() * 2 * PI))))
    _UPVALUE4_:setz(0)
    Entity.GetRot(_UPVALUE5_, _ARG_1_)
    Math.RotateVectorXYZ(_UPVALUE4_, _UPVALUE5_)
    Math.RotateVectorXYZ(_UPVALUE3_, _UPVALUE5_)
    FVECTOR3.Add(_UPVALUE3_, _UPVALUE3_, _UPVALUE4_)
    Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle, 2)
    _UPVALUE3_:set(_UPVALUE3_:getx() + _UPVALUE1_:getx(), _UPVALUE3_:gety() + _UPVALUE1_:gety(), _UPVALUE3_:getz() + _UPVALUE1_:getz())
    _UPVALUE5_:setx(_UPVALUE5_:getx() + (1 * (Script.Random() * 0.05) + 0.5) * Math.Cos((RoundPI(Script.Random() * 2 * PI))))
    _UPVALUE5_:sety(_UPVALUE5_:gety() + (1 * (Script.Random() * 0.05) + 0.5) * Math.Sin((RoundPI(Script.Random() * 2 * PI))))
    if _UPVALUE5_:getx() > 0 then
      _UPVALUE5_:setx(0)
    end
    Entity.GetRot(_UPVALUE2_, _ARG_1_)
    Entity.SetEffect(_ARG_0_.myHandle, "p_sl_dav_00", "P_SL_DAV_FIR0_0", _UPVALUE3_, _UPVALUE2_)
    Bullet.CreateEffectBullet(Bullet.CreateBullet("Volley", _UPVALUE3_, _UPVALUE5_), "p_sl_dav_00", "P_SL_DAV_BLT0_0")
    Bullet.SetCollision(Bullet.CreateBullet("Volley", _UPVALUE3_, _UPVALUE5_), COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, 0.5, 0, _ARG_1_)
    SetBulletAttackParam(Bullet.CreateBullet("Volley", _UPVALUE3_, _UPVALUE5_), _ARG_0_.myHandle, 18)
    Bullet.SetHitAttackEffectName(Bullet.CreateBullet("Volley", _UPVALUE3_, _UPVALUE5_), "p_sl_dav_00", "P_SL_DAV_HIT0_0")
    Bullet.SetHitBgEffectName(Bullet.CreateBullet("Volley", _UPVALUE3_, _UPVALUE5_), "p_sl_dav_00", "P_SL_DAV_WAL0_0")
    Entity.CalcVelocity(Bullet.CreateBullet("Volley", _UPVALUE3_, _UPVALUE5_), 0.25)
    Bullet.SetMaxMoveDist(Bullet.CreateBullet("Volley", _UPVALUE3_, _UPVALUE5_), 14400)
    EntityManager:GetEntity((Bullet.CreateBullet("Volley", _UPVALUE3_, _UPVALUE5_))).targetHandle = _ARG_0_.targetHandle
  end,
  CreateDarkFlare = function(_ARG_0_, _ARG_1_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 2)
    Entity.GetRot(_UPVALUE1_, _ARG_1_)
    Bullet.SetCollision(Bullet.CreateBullet("DGigaFlare", _UPVALUE0_, _UPVALUE1_), COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, 25, 0, _ARG_1_)
    SetBulletAttackParam(Bullet.CreateBullet("DGigaFlare", _UPVALUE0_, _UPVALUE1_), _ARG_0_.myHandle, 15)
    Bullet.SetHitAttackEffectName(Bullet.CreateBullet("DGigaFlare", _UPVALUE0_, _UPVALUE1_), "b85vs00", "B085_AWI_HIT1_0")
    Bullet.SetMaxMoveDist(Bullet.CreateBullet("DGigaFlare", _UPVALUE0_, _UPVALUE1_), 14400)
    EntityManager:GetEntity((Bullet.CreateBullet("DGigaFlare", _UPVALUE0_, _UPVALUE1_))).targetHandle = _ARG_0_.targetHandle
  end,
  CreateDarkGigaShoot = function(_ARG_0_, _ARG_1_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
    _UPVALUE0_:sety(_UPVALUE0_:gety() - Entity.GetFloorDistance(_ARG_0_.myHandle) + 0.01)
    Entity.GetRot(_UPVALUE1_, _ARG_1_)
    _UPVALUE2_:set(0, 0, 0)
    Bullet.CreateEffectBullet(Bullet.CreateBullet("DarkGround", _UPVALUE0_, _UPVALUE2_), "b85vs00", "B085_AWI_ZBS0_0")
    Bullet.SetCollision(Bullet.CreateBullet("DarkGround", _UPVALUE0_, _UPVALUE2_), COLL_KIND_ENEMY, COLL_SHAPE_CYLINDER, 0.5, 0.5, _ARG_1_)
    Entity.SetLowerHalf(Bullet.CreateBullet("DarkGround", _UPVALUE0_, _UPVALUE2_), 1)
    SetBulletAttackParam(Bullet.CreateBullet("DarkGround", _UPVALUE0_, _UPVALUE2_), _ARG_0_.myHandle, 21)
    Bullet.SetHitAttackEffectName(Bullet.CreateBullet("DarkGround", _UPVALUE0_, _UPVALUE2_), "p_sl_dav_00", "B085_AWI_HIT1_0")
    Bullet.SetMaxMoveDist(Bullet.CreateBullet("DarkGround", _UPVALUE0_, _UPVALUE2_), 14400)
    EntityManager:GetEntity((Bullet.CreateBullet("DarkGround", _UPVALUE0_, _UPVALUE2_))).targetHandle = _ARG_0_.targetHandle
  end,
  CreateSonicShoot = function(_ARG_0_, _ARG_1_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.targetHandle, 2)
    Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle, 2)
    _UPVALUE1_:setx(0)
    _UPVALUE1_:sety(0)
    _UPVALUE1_:setz(2.2)
    _UPVALUE2_:set(_UPVALUE1_:getx(), _UPVALUE1_:gety(), _UPVALUE1_:getz())
    Entity.GetRot(_UPVALUE3_, _ARG_1_)
    Math.RotateVectorXYZ(_UPVALUE2_, _UPVALUE3_)
    Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
    _UPVALUE2_:set(_UPVALUE2_:getx() + _UPVALUE1_:getx(), _UPVALUE2_:gety() + _UPVALUE1_:gety(), _UPVALUE2_:getz() + _UPVALUE1_:getz())
    Entity.GetRot(_UPVALUE4_, _ARG_1_)
    Bullet.CreateEffectBullet(Bullet.CreateBullet("sonicwaveb", _UPVALUE2_, _UPVALUE3_), "b85vs00", "B085_ALE_SON0_0")
    Bullet.SetCollision(Bullet.CreateBullet("sonicwaveb", _UPVALUE2_, _UPVALUE3_), COLL_KIND_ENEMY, COLL_SHAPE_CYLINDER, 0.9, 1.8, _ARG_1_, -5)
    SetBulletAttackParam(Bullet.CreateBullet("sonicwaveb", _UPVALUE2_, _UPVALUE3_), _ARG_0_.myHandle, 6)
    Bullet.SetHitAttackEffectName(Bullet.CreateBullet("sonicwaveb", _UPVALUE2_, _UPVALUE3_), "b85vs00", "B085_KEY_HIT0_0")
    Entity.CalcVelocity(Bullet.CreateBullet("sonicwaveb", _UPVALUE2_, _UPVALUE3_), 0.25)
    Bullet.SetMaxMoveDist(Bullet.CreateBullet("sonicwaveb", _UPVALUE2_, _UPVALUE3_), 14400)
    EntityManager:GetEntity((Bullet.CreateBullet("sonicwaveb", _UPVALUE2_, _UPVALUE3_))).targetHandle = _ARG_0_.targetHandle
    Entity.EnableBgColl(Bullet.CreateBullet("sonicwaveb", _UPVALUE2_, _UPVALUE3_), 0)
    Bullet.EnableNoCheckHitBg(Bullet.CreateBullet("sonicwaveb", _UPVALUE2_, _UPVALUE3_), 1)
    _UPVALUE5_:set(-20, 1, 0)
    Bullet.SetCollOffset(Bullet.CreateBullet("sonicwaveb", _UPVALUE2_, _UPVALUE3_), _UPVALUE5_, 0)
    _UPVALUE5_:set(20, 1, 0)
    Bullet.SetCollOffset(Bullet.CreateBullet("sonicwaveb", _UPVALUE2_, _UPVALUE3_), _UPVALUE5_, 1)
  end,
  CreateStraightShoot = function(_ARG_0_, _ARG_1_)
    _UPVALUE0_:setx(0)
    _UPVALUE0_:sety(0)
    _UPVALUE0_:setz(2.2)
    _UPVALUE1_:set(_UPVALUE0_:getx(), _UPVALUE0_:gety(), _UPVALUE0_:getz())
    Entity.GetRot(_UPVALUE2_, _ARG_1_)
    Math.RotateVectorXYZ(_UPVALUE3_, _UPVALUE2_)
    Math.RotateVectorXYZ(_UPVALUE1_, _UPVALUE2_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
    _UPVALUE1_:set(_UPVALUE1_:getx() + _UPVALUE0_:getx(), _UPVALUE1_:gety() + _UPVALUE0_:gety() + 1, _UPVALUE1_:getz() + _UPVALUE0_:getz())
    Entity.GetRot(_UPVALUE4_, _ARG_1_)
    Bullet.CreateEffectBullet(Bullet.CreateBullet("Straightb", _UPVALUE1_, _UPVALUE4_), "b85vs00", "B085_AAR_BLT0_0")
    Bullet.SetCollision(Bullet.CreateBullet("Straightb", _UPVALUE1_, _UPVALUE4_), COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, 0.5, 0, _ARG_1_)
    SetBulletAttackParam(Bullet.CreateBullet("Straightb", _UPVALUE1_, _UPVALUE4_), _ARG_0_.myHandle, 6)
    Bullet.SetHitAttackEffectName(Bullet.CreateBullet("Straightb", _UPVALUE1_, _UPVALUE4_), "b85vs00", "B085_KEY_HIT0_0")
    Bullet.SetHitBgEffectName(Bullet.CreateBullet("Straightb", _UPVALUE1_, _UPVALUE4_), "b85vs00", "B085_AAR_LOS0_0")
    Bullet.SetMaxMoveDist(Bullet.CreateBullet("Straightb", _UPVALUE1_, _UPVALUE4_), 14400)
    Entity.CalcVelocity(Bullet.CreateBullet("Straightb", _UPVALUE1_, _UPVALUE4_), 0.3)
    EntityManager:GetEntity((Bullet.CreateBullet("Straightb", _UPVALUE1_, _UPVALUE4_))).targetHandle = _ARG_0_.targetHandle
  end,
  CreateInDark = function(_ARG_0_, _ARG_1_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
    Entity.GetRot(_UPVALUE1_, _ARG_1_)
    Bullet.CreateEffectBullet(Bullet.CreateBullet("InDark", _UPVALUE0_, _UPVALUE1_), "b85vs00", "B085_SDA_HAN0_0")
    Bullet.SetCollision(Bullet.CreateBullet("InDark", _UPVALUE0_, _UPVALUE1_), COLL_KIND_ENEMY, COLL_SHAPE_CYLINDER, 0.5, 0, _ARG_1_)
    SetBulletAttackParam(Bullet.CreateBullet("InDark", _UPVALUE0_, _UPVALUE1_), _ARG_0_.myHandle, 6)
    Bullet.SetMaxMoveDist(Bullet.CreateBullet("InDark", _UPVALUE0_, _UPVALUE1_), 14400)
    _UPVALUE2_ = Bullet.CreateBullet("InDark", _UPVALUE0_, _UPVALUE1_)
    EntityManager:GetEntity(_UPVALUE2_).targetHandle = _ARG_0_.targetHandle
    Bullet.EnableNoCheckHitBg(Bullet.CreateBullet("InDark", _UPVALUE0_, _UPVALUE1_), 1)
    Bullet.EnableAttackCollision(Bullet.CreateBullet("InDark", _UPVALUE0_, _UPVALUE1_), 0)
  end,
  SetPlayerBallet = function(_ARG_0_)
    _UPVALUE0_:set(0, 0, 0)
    Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
    _UPVALUE1_:set(0, 0, 0)
    Bullet.SetCollision(Bullet.CreateBullet("SetPlyaerB", _UPVALUE0_, _UPVALUE1_), COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, 0.5, 0, _ARG_0_.targetHandle)
    Bullet.SetHitAttackEffectName(Bullet.CreateBullet("SetPlyaerB", _UPVALUE0_, _UPVALUE1_), "b85vs00", "B085_KEY_HIT0_0")
    Bullet.SetMaxMoveDist(Bullet.CreateBullet("SetPlyaerB", _UPVALUE0_, _UPVALUE1_), 14400)
    EntityManager:GetEntity((Bullet.CreateBullet("SetPlyaerB", _UPVALUE0_, _UPVALUE1_))).targetHandle = _ARG_0_.targetHandle
    EntityManager:GetEntity((Bullet.CreateBullet("SetPlyaerB", _UPVALUE0_, _UPVALUE1_))).owner = _ARG_0_.myHandle
    Bullet.EnableAttackCollision(Bullet.CreateBullet("SetPlyaerB", _UPVALUE0_, _UPVALUE1_), 0)
  end,
  CreateBurst = function(_ARG_0_, _ARG_1_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 2)
    Entity.GetRot(_UPVALUE1_, _ARG_1_)
    Bullet.SetCollision(Bullet.CreateBullet("BurstB", _UPVALUE0_, _UPVALUE1_), COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, 4, 0, _ARG_1_)
    SetBulletAttackParam(Bullet.CreateBullet("BurstB", _UPVALUE0_, _UPVALUE1_), _ARG_0_.myHandle, 22)
    Bullet.SetHitAttackEffectName(Bullet.CreateBullet("BurstB", _UPVALUE0_, _UPVALUE1_), "b85vs00", "B085_AWI_HIT1_0")
    Bullet.SetMaxMoveDist(Bullet.CreateBullet("BurstB", _UPVALUE0_, _UPVALUE1_), 14400)
    EntityManager:GetEntity((Bullet.CreateBullet("BurstB", _UPVALUE0_, _UPVALUE1_))).targetHandle = _ARG_0_.targetHandle
  end,
  WhichRightandLeft = function(_ARG_0_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
    Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
    FVECTOR3.Sub(_UPVALUE0_, _UPVALUE2_, _UPVALUE0_)
    FVECTOR3.normalize(_UPVALUE0_)
    if RoundPI(Math.Atan2(_UPVALUE0_:getx(), _UPVALUE0_:getz()) - _UPVALUE1_:gety()) < DegToRad(1) and RoundPI(Math.Atan2(_UPVALUE0_:getx(), _UPVALUE0_:getz()) - _UPVALUE1_:gety()) > DegToRad(-1) then
      return 2
    end
    if RoundPI((Math.Atan2(_UPVALUE0_:getx(), _UPVALUE0_:getz()) - _UPVALUE1_:gety()) * -1) < 0 then
      return 1
    else
      return 0
    end
  end,
  TurnY = function(_ARG_0_, _ARG_1_)
    Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
    _UPVALUE0_:sety(_UPVALUE0_:gety() + _ARG_1_)
    Entity.SetRot(_ARG_0_.myHandle, _UPVALUE0_)
  end,
  TurnZ = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
    _UPVALUE0_:setz(HomingDegree(_UPVALUE0_:getz(), DegToRad(_ARG_1_), _ARG_2_, Entity.GetFrameRate(_ARG_0_.myHandle)))
    if _UPVALUE0_:getz() < DegToRad(-_ARG_3_) then
      _UPVALUE0_:setz(DegToRad(-_ARG_3_))
    end
    if _UPVALUE0_:getz() > DegToRad(_ARG_3_) then
      _UPVALUE0_:setz(DegToRad(_ARG_3_))
    end
    Entity.SetRot(_ARG_0_.myHandle, _UPVALUE0_)
    Entity.SetRotateMode(_ARG_0_.myHandle, 4)
    return HomingDegree(_UPVALUE0_:getz(), DegToRad(_ARG_1_), _ARG_2_, Entity.GetFrameRate(_ARG_0_.myHandle))
  end,
  CheckAirMovePos = function(_ARG_0_, _ARG_1_)
    _UPVALUE0_:set(_UPVALUE1_[_ARG_1_].x, _UPVALUE1_[_ARG_1_].y, _UPVALUE1_[_ARG_1_].z)
    Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.myHandle)
    Entity.GetWorldPos(_UPVALUE3_, _ARG_0_.targetHandle)
    _UPVALUE0_:sety(_UPVALUE2_:gety())
    if _UPVALUE3_:getx() > 9 or _UPVALUE3_:getx() < -9 then
      return 0
    end
    if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _UPVALUE0_) < 16 then
      return 1
    end
    if _UPVALUE2_:getx() > 9 or _UPVALUE2_:getx() < -9 then
      return 1
    end
  end,
  CheckAirMovePos_ForGoes_away = function(_ARG_0_, _ARG_1_)
    _UPVALUE0_:set(_UPVALUE1_[_ARG_1_].x, _UPVALUE1_[_ARG_1_].y, _UPVALUE1_[_ARG_1_].z)
    Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.myHandle)
    Entity.GetWorldPos(_UPVALUE3_, _ARG_0_.targetHandle)
    _UPVALUE0_:sety(_UPVALUE2_:gety())
    if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _UPVALUE0_) < 20.25 then
      return 1
    end
    if _UPVALUE2_:getx() > 9 or _UPVALUE2_:getx() < -9 then
      return 1
    end
  end,
  CheckAirMovePos_ForAir = function(_ARG_0_, _ARG_1_)
    _UPVALUE0_:set(_UPVALUE1_[_ARG_1_].x, _UPVALUE1_[_ARG_1_].y, _UPVALUE1_[_ARG_1_].z)
    Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.myHandle)
    Entity.GetWorldPos(_UPVALUE3_, _ARG_0_.targetHandle)
    _UPVALUE0_:sety(_UPVALUE2_:gety())
    if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _UPVALUE0_) < 16 then
      return 1
    end
  end,
  CheckAirMovePos_ForTarget = function(_ARG_0_, _ARG_1_)
    _UPVALUE0_:set(_UPVALUE1_[_ARG_1_].x, _UPVALUE1_[_ARG_1_].y, _UPVALUE1_[_ARG_1_].z)
    Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.targetHandle)
    _UPVALUE0_:sety(_UPVALUE2_:gety())
    if Entity.CalcDistanceXZSq(_ARG_0_.targetHandle, _UPVALUE0_) < 16 then
      return 1
    end
  end,
  SetTargetPos = function(_ARG_0_, _ARG_1_)
    _ARG_0_.targetPos:set(_UPVALUE0_[_ARG_1_].x, _UPVALUE0_[_ARG_1_].y, _UPVALUE0_[_ARG_1_].z)
  end,
  TurnX = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
    _UPVALUE0_:setx(HomingDegree(_UPVALUE0_:getx(), DegToRad(_ARG_1_), _ARG_2_, Entity.GetFrameRate(_ARG_0_.myHandle)))
    if _UPVALUE0_:getx() < DegToRad(-_ARG_3_) then
      _UPVALUE0_:setx(DegToRad(-_ARG_3_))
    end
    if _UPVALUE0_:getx() > DegToRad(_ARG_3_) then
      _UPVALUE0_:setx(DegToRad(_ARG_3_))
    end
    Entity.SetRot(_ARG_0_.myHandle, _UPVALUE0_)
    return HomingDegree(_UPVALUE0_:getx(), DegToRad(_ARG_1_), _ARG_2_, Entity.GetFrameRate(_ARG_0_.myHandle))
  end,
  SetTruns = function(_ARG_0_)
    if _ARG_0_:WhichRightandLeft() == 2 then
      _ARG_0_:TurnZ(0, 1, 180)
    elseif _ARG_0_:WhichRightandLeft() == 1 then
      _ARG_0_:TurnZ(-45, 1, 90)
    else
      _ARG_0_:TurnZ(45, 1, 180)
    end
  end,
  SpeedUp = function(_ARG_0_, _ARG_1_, _ARG_2_)
    _ARG_0_.Speed = _ARG_0_.Speed + _ARG_2_ * Entity.GetFrameRate(_ARG_0_.myHandle)
    if _ARG_1_ < _ARG_0_.Speed then
      _ARG_0_.Speed = _ARG_1_
    end
  end,
  SpeedDlown = function(_ARG_0_, _ARG_1_, _ARG_2_)
    _ARG_0_.Speed = _ARG_0_.Speed - _ARG_2_ * Entity.GetFrameRate(_ARG_0_.myHandle)
    if _ARG_1_ > _ARG_0_.Speed then
      _ARG_0_.Speed = _ARG_1_
    end
  end,
  Defense = function(_ARG_0_)
    if _ARG_0_.evadeTimer > 0 then
      return
    end
    if _ARG_0_.evadeFlag == false then
      if Entity.IsAttacking(_ARG_0_.targetHandle) then
        _ARG_0_.evadeFlag = true
        _ARG_0_.evadeTimer = -1
      end
    else
      print("Defense!!\n")
      _ARG_0_.stack:push("Idling")
      if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 81 then
        _ARG_0_:SetingState()
        if Script.Random() < 0.5 then
          _ARG_0_.stack:push("Parry")
        else
          _ARG_0_.stack:push("SonicImpact")
        end
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      else
      end
      _ARG_0_.evadeTimer = 60 * (1 + Script.Random() * 2)
      _ARG_0_.evadeFlag = false
      return true
    end
    return false
  end,
  IsNoChangeState = function(_ARG_0_)
    if _ARG_0_:GetState() ~= "Grapple" and _ARG_0_:GetState() ~= "GrappleGuriguri" and _ARG_0_:GetState() ~= "GrappleGuriguriSuccess" and _ARG_0_:GetState() ~= "GrappleSlow" and _ARG_0_:GetState() ~= "GrappleSlowSuccess" and _ARG_0_:GetState() ~= "GrappleSlowBad" and _ARG_0_:GetState() ~= "RetrunState" and _ARG_0_:GetState() ~= "GrappleImpactSuccess" and _ARG_0_:GetState() ~= "GrappleImpactBad" and _ARG_0_:GetState() ~= "GrappleImpact" then
      return true
    end
    return false
  end,
  GetUneTargetHandle = function(_ARG_0_)
    dist = 9999
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, Player.GetPlayers()) > _UPVALUE0_.SearchDistLong then
      if Player.GetPlayers() ~= _ARG_0_.targetHandle and Player.GetPlayers() ~= nil then
      else
        print("handle1\130\205\131n\131\147\131h\131\139\130\200\130\181\150\148\130\205\131^\129[\131Q\131b\131g\n")
      end
    end
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, Player.GetPlayers()) > _UPVALUE0_.SearchDistLong then
      if Player.GetPlayers() ~= _ARG_0_.targetHandle and Player.GetPlayers() ~= NULL_HANDLE then
      else
        print("handle2\130\205\131n\131\147\131h\131\139\130\200\130\181\150\148\130\205\131^\129[\131Q\131b\131g\n")
      end
    end
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, Player.GetPlayers()) > _UPVALUE0_.SearchDistLong then
      if Player.GetPlayers() ~= _ARG_0_.targetHandle and Player.GetPlayers() ~= NULL_HANDLE then
      else
        print("handle3\130\205\131n\131\147\131h\131\139\130\200\130\181\150\148\130\205\131^\129[\131Q\131b\131g\n")
      end
    end
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, Player.GetPlayers()) > _UPVALUE0_.SearchDistShort and Entity.CalcDistanceSq(_ARG_0_.myHandle, Player.GetPlayers()) < _UPVALUE0_.SearchDistLong then
      if Player.GetPlayers() ~= _ARG_0_.targetHandle and Player.GetPlayers() ~= nil then
      else
        print("handle1\130\205\131n\131\147\131h\131\139\130\200\130\181\150\148\130\205\131^\129[\131Q\131b\131g\n")
      end
    end
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, Player.GetPlayers()) > _UPVALUE0_.SearchDistShort and Entity.CalcDistanceSq(_ARG_0_.myHandle, Player.GetPlayers()) < _UPVALUE0_.SearchDistLong then
      if Player.GetPlayers() ~= _ARG_0_.targetHandle and Player.GetPlayers() ~= nil then
      else
        print("handle2\130\205\131n\131\147\131h\131\139\130\200\130\181\150\148\130\205\131^\129[\131Q\131b\131g\n")
      end
    end
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, Player.GetPlayers()) > _UPVALUE0_.SearchDistShort and Entity.CalcDistanceSq(_ARG_0_.myHandle, Player.GetPlayers()) < _UPVALUE0_.SearchDistLong then
      if Player.GetPlayers() ~= _ARG_0_.targetHandle and Player.GetPlayers() ~= nil then
      else
        print("handle3\130\205\131n\131\147\131h\131\139\130\200\130\181\150\148\130\205\131^\129[\131Q\131b\131g\n")
      end
    end
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, Player.GetPlayers()) < _UPVALUE0_.SearchDistShort then
      if Player.GetPlayers() ~= _ARG_0_.targetHandle and Player.GetPlayers() ~= nil then
      else
        print("handle1\130\205\131n\131\147\131h\131\139\130\200\130\181\150\148\130\205\131^\129[\131Q\131b\131g\n")
      end
    end
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, Player.GetPlayers()) < _UPVALUE0_.SearchDistShort then
      if Player.GetPlayers() ~= _ARG_0_.targetHandle and Player.GetPlayers() ~= nil then
      else
        print("handle2\130\205\131n\131\147\131h\131\139\130\200\130\181\150\148\130\205\131^\129[\131Q\131b\131g\n")
      end
    end
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, Player.GetPlayers()) < _UPVALUE0_.SearchDistShort then
      if Player.GetPlayers() ~= _ARG_0_.targetHandle and Player.GetPlayers() ~= nil then
      else
        print("handle3\130\205\131n\131\147\131h\131\139\130\200\130\181\150\148\130\205\131^\129[\131Q\131b\131g\n")
      end
    end
    return 1
  end,
  setState = function(_ARG_0_, _ARG_1_)
    _ARG_0_.oldState = _ARG_0_:GetState()
    _ARG_0_:GotoState(_ARG_1_)
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    print("b85vs00:OnInit()\n")
    _UPVALUE0_ = "010"
    _UPVALUE1_ = "012"
    _UPVALUE2_ = "030"
    _UPVALUE3_ = "040"
    _UPVALUE4_ = "051"
    _UPVALUE5_ = "052"
    _UPVALUE6_ = "060"
    _UPVALUE7_ = "070"
    _UPVALUE8_ = "220"
    _UPVALUE9_ = "220"
    _UPVALUE10_ = "222"
    _UPVALUE11_ = "223"
    _UPVALUE12_ = "310"
    _UPVALUE13_ = "320"
    _UPVALUE14_ = "340"
    _UPVALUE15_ = "350"
    _UPVALUE16_ = "360"
    _UPVALUE17_ = "370"
    _UPVALUE18_ = "380"
    _UPVALUE19_ = "381"
    _UPVALUE20_ = "382"
    _UPVALUE21_ = "383"
    _UPVALUE22_ = "410"
    _UPVALUE23_ = "420"
    _UPVALUE24_ = "430"
    _UPVALUE25_ = "480"
    _UPVALUE26_ = "500"
    _UPVALUE27_ = "510"
    _UPVALUE28_ = "520"
    _UPVALUE29_ = "600"
    _UPVALUE30_ = "601"
    _UPVALUE31_ = "700"
    _UPVALUE32_ = "710"
    _UPVALUE33_ = "711"
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.oldState = 0
    _ARG_0_.targetHandle = NULL_HANDLE
    _ARG_0_.effectHandle = NULL_HANDLE
    _ARG_0_.effectHandle2 = NULL_HANDLE
    _ARG_0_.effectHandle3 = NULL_HANDLE
    _ARG_0_.reflectFlag = 0
    _ARG_0_.InDarkBalletHandle = NULL_HANDLE
    _UPVALUE34_[0].handle = NULL_HANDLE
    _UPVALUE34_[1].handle = NULL_HANDLE
    _UPVALUE34_[2].handle = NULL_HANDLE
    _ARG_0_.step = 0
    _ARG_0_.stack = Stack:Create()
    _ARG_0_.damageFlag = 0
    _ARG_0_.Speed = 0
    _ARG_0_.noDamageFlag = 0
    _ARG_0_.shootFlara = 0
    _ARG_0_.attackFlag = 0
    _ARG_0_.attTimer = 0
    _ARG_0_.TossDamageCnt = 0
    _ARG_0_.Height = 0
    _ARG_0_.TripNumber = 0
    _ARG_0_.homingAddAngle = 0
    _ARG_0_.anglePow = 0
    _ARG_0_.straightHitFlag = 0
    _ARG_0_.gigaFlareFlag = 0
    _ARG_0_.SinpactFlareFlag = 0
    _ARG_0_.SinpactFlareFlag = 0
    _ARG_0_.burstFlareFlag = 0
    _ARG_0_.guriguriTaimer = 0
    _ARG_0_.burstTimer = 0
    _ARG_0_.burstStartFlag = 0
    _ARG_0_.burstEndTimer = 0
    _ARG_0_.oldShootLockNum = 0
    _ARG_0_.evadeTimer = 0
    _ARG_0_.evadeFlag = false
    _ARG_0_.KyeHandle = NULL_HANDLE
    _ARG_0_.WindHandle = NULL_HANDLE
    _ARG_0_.ArmHandle = NULL_HANDLE
    _ARG_0_.LegHandle = NULL_HANDLE
    _ARG_0_.ShieldHandle = NULL_HANDLE
    _ARG_0_.KyeHandle = Entity.CreateEntity("b87vs00", _UPVALUE35_, _UPVALUE36_, _ARG_1_)
    Entity.AttachCoord(_ARG_1_, "R_buki", _ARG_0_.KyeHandle, "Root")
    Entity.EnableLockonAndShooton(_ARG_0_.KyeHandle, 0)
    EntityManager:GetEntity(_ARG_0_.KyeHandle).Master = _ARG_1_
    Entity.SetAlpha(_ARG_0_.KyeHandle, 0)
    _ARG_0_.WindHandle = Entity.CreateEntity("b91vs00", _UPVALUE35_, _UPVALUE36_, _ARG_1_)
    Entity.AttachCoord(_ARG_1_, "mune", _ARG_0_.WindHandle, "Root")
    Entity.EnableLockonAndShooton(_ARG_0_.WindHandle, 0)
    Entity.SetAlpha(_ARG_0_.WindHandle, 0)
    Entity.EnableBgColl(_ARG_0_.WindHandle, 0)
    _ARG_0_.ArmHandle = Entity.CreateEntity("b92vs00", _UPVALUE35_, _UPVALUE36_, _ARG_1_)
    Entity.AttachCoord(_ARG_1_, "R_ude2", _ARG_0_.ArmHandle, "Root")
    Entity.EnableLockonAndShooton(_ARG_0_.ArmHandle, 0)
    Entity.SetAlpha(_ARG_0_.ArmHandle, 0)
    Entity.EnableBgColl(_ARG_0_.ArmHandle, 0)
    _ARG_0_.LegHandle = Entity.CreateEntity("b93vs00", _UPVALUE35_, _UPVALUE36_, _ARG_1_)
    Entity.AttachCoord(_ARG_1_, "R_sune", _ARG_0_.LegHandle, "Root")
    Entity.EnableLockonAndShooton(_ARG_0_.LegHandle, 0)
    Entity.SetAlpha(_ARG_0_.LegHandle, 0)
    Entity.EnableBgColl(_ARG_0_.LegHandle, 0)
    _ARG_0_.ShieldHandle = Entity.CreateEntity("b94vs00", _UPVALUE35_, _UPVALUE36_, _ARG_1_)
    Entity.EnableLockonAndShooton(_ARG_0_.ShieldHandle, 0)
    EntityManager:GetEntity(_ARG_0_.ShieldHandle).Master = _ARG_1_
    Entity.SetMotion(_ARG_0_.ShieldHandle, "470", 9, 9)
    Entity.EnableBodyColl(_ARG_0_.ShieldHandle, 0)
    Entity.EnableDamageColl(_ARG_0_.ShieldHandle, 0)
    Entity.SetAlpha(_ARG_0_.ShieldHandle, 0)
    _UPVALUE37_.KeyMode = _UPVALUE38_
    _ARG_0_.oldKeyMode = 999
    _ARG_0_.oldoldKeyMode = 999
    _ARG_0_.oldoldKeyModeCrearTime = 999
    _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.time = 0
    _ARG_0_.HitAttackFlag = 0
    _ARG_0_.keyNumber = 0
    _ARG_0_.rnd = 0
    _ARG_0_.rndx = 0
    _ARG_0_.rndy = 0
    _ARG_0_.balazsStep = 0
    _ARG_0_.balazsStep2 = 0
    _ARG_0_.SpeedY = 0
    _ARG_0_:setAppend(_UPVALUE39_, 0)
    _ARG_0_.HANDLE_LIST = {}
    for _FORV_6_ = 0, _UPVALUE40_ do
      _ARG_0_.HANDLE_LIST[_FORV_6_] = NULL_HANDLE
    end
    _UPVALUE37_.IdlingTime = Enemy.GetExtraParam(_ARG_1_, "IdlingTime")
    _UPVALUE37_.SearchDistShort = Enemy.GetExtraParam(_ARG_1_, "DistShort")
    _UPVALUE37_.SearchDistShort = _UPVALUE37_.SearchDistShort * _UPVALUE37_.SearchDistShort
    _UPVALUE37_.SearchDistShort2 = Enemy.GetExtraParam(_ARG_1_, "DistShort2")
    _UPVALUE37_.SearchDistShort2 = _UPVALUE37_.SearchDistShort2 * _UPVALUE37_.SearchDistShort2
    _UPVALUE37_.SearchDistLong = Enemy.GetExtraParam(_ARG_1_, "DistLong")
    _UPVALUE37_.SearchDistLong = _UPVALUE37_.SearchDistLong * _UPVALUE37_.SearchDistLong
    _UPVALUE37_.ParryTimer = Enemy.GetExtraParam(_ARG_1_, "ParryTimer") * 60
    _UPVALUE37_.TrunPow = Enemy.GetExtraParam(_ARG_1_, "TrunPow")
    _UPVALUE37_.TrunFOV = Enemy.GetExtraParam(_ARG_1_, "FOVAngle")
    _UPVALUE37_.Blinds = Enemy.GetExtraParam(_ARG_1_, "Blinds")
    _UPVALUE37_.ChangeAppendNum = Enemy.GetExtraParam(_ARG_1_, "ChaANum")
    _UPVALUE37_.ChangeAppendKyeMode = Enemy.GetExtraParam(_ARG_1_, "ChaKeyRM") * 0.01
    _UPVALUE37_.RunSpeed = Enemy.GetExtraParam(_ARG_1_, "RunSpeed")
    _UPVALUE41_ = NULL_HANDLE
    _ARG_0_.heelFlag = 0
    if Entity.HasNetGameHandle(_ARG_0_.myHandle) then
    else
      for _FORV_6_ = 0, 7 do
        print("DeckCom Kind = " .. Player.GetDeckCommondKind(_FORV_6_) .. "\n")
        if Player.GetDeckCommondKind(_FORV_6_) == COMMAND_KIND_Cure or Player.GetDeckCommondKind(_FORV_6_) == COMMAND_KIND_Cura or Player.GetDeckCommondKind(_FORV_6_) == COMMAND_KIND_Curaga or Player.GetDeckCommondKind(_FORV_6_) == COMMAND_KIND_FriendCure or Player.GetDeckCommondKind(_FORV_6_) == COMMAND_KIND_FriendCura or Player.GetDeckCommondKind(_FORV_6_) == COMMAND_KIND_FriendCuraga then
          print("\131P\131A\131\139\140n\130\170\130\160\130\193\130\189\129\129\130R\129\129\n")
          _ARG_0_.heelFlag = 1
        end
      end
    end
    _FOR_.SetMovementCollRadius(_ARG_0_.myHandle, 1.5)
    Entity.SetLowerHalf(_ARG_0_.myHandle, 1.6)
    Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
    Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
    Entity.EnableLockon(_ARG_0_.myHandle, 0)
    Entity.EnableGravity(_ARG_0_.myHandle, 1)
    Player.SetBossCamera("b85vs00")
    Enemy.IsAllEnemyWaiting()
    Entity.SetDropShadowDistance(_ARG_0_.myHandle, 100)
    Enemy.EnableNoVanish(_ARG_0_.myHandle, 1)
    if Enemy.IsAllEnemyWaiting() then
      _ARG_0_:GotoState("Waiting")
    else
      _ARG_0_:GotoState("Appear")
    end
  end,
  RestHpRate = function(_ARG_0_)
    return Enemy.GetHp(_ARG_0_.myHandle) / Enemy.GetHpMax(_ARG_0_.myHandle)
  end,
  OnDamage = function(_ARG_0_, _ARG_1_, _ARG_2_)
    if _ARG_0_:GetState() == "DarkGigaFlare" then
      if Entity.GetDamageCategory(_ARG_0_.myHandle) == 9 then
        return 0
      end
      return 1
    end
    return 1
  end,
  OnDamageBefore = function(_ARG_0_, _ARG_1_)
    if _UPVALUE0_.KeyMode == _UPVALUE1_ then
      print("\131V\129[\131\139\131h\131A\131y\131\147\131h\146\134\130\205\150\179\147G\130\197\130\183\130\193\n")
      if Script.Random() < 0.2 then
      else
        return 1
      end
    end
    if _ARG_0_.burstStartFlag == 0 then
      _ARG_0_.burstTimer = _UPVALUE2_ + Script.Random() * 3 * 60
    end
    _ARG_0_.burstEndTimer = _UPVALUE3_
    _ARG_0_.burstStartFlag = 1
    if _ARG_0_:GetState() == "BurstAttack" then
      return 1
    end
    if _ARG_0_:GetState() == "DarkGigaFlare" then
      if Entity.GetDamageCategory(_ARG_0_.myHandle) == 9 then
        return 0
      end
      return 1
    end
    if _ARG_0_:IsNoChangeState() == true then
      if Entity.GetDamageCategory(_ARG_0_.myHandle) == 9 then
        _ARG_0_.stack:clear()
        _ARG_0_.stack:push("Idling")
        _ARG_0_.stack:push("SonicImpact")
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        return 0
      end
      if Entity.GetDamageCommandKind(_ARG_0_.myHandle) == COMMAND_KIND_RagingCharge and _UPVALUE0_.KeyMode ~= _UPVALUE1_ and _UPVALUE0_.KeyMode ~= _UPVALUE4_ then
        print("\131\134\131j\131I\131\147\131\137\131b\131V\131\133\130\197\141U\140\130\130\240\142\243\130\175\130\189\129I\129I\129I\n")
        _ARG_0_.stack:clear()
        _ARG_0_.stack:push("Idling")
        _ARG_0_.stack:push("BarnImpactIdling")
        _ARG_0_.stack:push("Appending_Shield")
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        return 0
      end
    end
    _ARG_0_.damageFlag = 1
    if _ARG_0_.noDamageFlag == 1 then
      return 1
    end
    return 0
  end,
  OnGuard = function(_ARG_0_)
    Entity.GetDamageCrossPos(_UPVALUE0_, _ARG_0_.myHandle)
    _UPVALUE1_:set(0, 0, 0)
    Entity.SetEffect(_ARG_0_.myHandle, "b85vs00", "B085_COM_GUA0_0", _UPVALUE0_, _UPVALUE1_)
    return 1
  end,
  OnUpdateDamageReaction = function(_ARG_0_, _ARG_1_)
    print("\131_\131\129\129[\131W\131\138\131A\131N\131V\131\135\131\147\146\134\n")
    if _ARG_1_ == REACTION_KIND_BLOW_DAMAGE or _ARG_1_ == REACTION_KIND_TOSS_DAMAGE or _ARG_1_ == REACTION_KIND_FLICK_DAMAGE then
      if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 10 then
        _ARG_0_.stack:clear()
        _ARG_0_.stack:push("Idling")
        _ARG_0_.stack:push("Goes_away")
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        _ARG_0_.TossDamageCnt = _ARG_0_.TossDamageCnt + 1
        if 1 < _ARG_0_.TossDamageCnt then
          _ARG_0_.TossDamageCnt = 1
        end
        return 1
      end
    else
      if _ARG_1_ == REACTION_KIND_SMALL_DAMAGE then
      else
      end
    end
    return 0
  end,
  IsPlShootShot = function(_ARG_0_)
    Entity.GetLocalPos(_UPVALUE0_, _ARG_0_.myHandle)
    return true
  end,
  OnHitAttack = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    print("OnHitAttack kind = " .. _ARG_3_ .. "\n")
    if _ARG_1_ == _ARG_0_.targetHandle then
      _ARG_0_.HitAttackFlag = 1
    end
    Entity.GetDamageCrossPos(_UPVALUE0_, _ARG_1_)
    _UPVALUE1_:set(0, 0, 0)
    Entity.SetEffect(_ARG_0_.myHandle, "b85vs00", "B085_KEY_HIT0_0", _UPVALUE0_, _UPVALUE1_)
    if ATK_KIND_DMG_BLOW == _ARG_3_ or ATK_KIND_DMG_TOSS == _ARG_3_ then
      Entity.GetDamageCrossPos(_UPVALUE0_, _ARG_0_.targetHandle)
      _UPVALUE1_:set(0, 0, 0)
      Entity.SetEffect(_ARG_0_.myHandle, "b85vs00", "B085_KEY_CRI0_0", _UPVALUE0_, _UPVALUE1_)
    end
    return 1
  end,
  OnReflect = function(_ARG_0_)
    _ARG_0_.reflectFlag = 1
    return 1
  end,
  OnDead = function(_ARG_0_)
    SetupBossDead(_ARG_0_.myHandle)
    _ARG_0_:GotoStateSub("Dead")
    return 1
  end,
  OnDestroy = function(_ARG_0_)
    Effect.LoopEnd(_ARG_0_.effectHandle)
    Effect.LoopEnd(_ARG_0_.effectHandle2)
    Effect.LoopEnd(_ARG_0_.effectHandle3)
    if Entity.GetCurrentMotion(Player.GetHandle()) == Entity.GetMotionIndex(Player.GetHandle(), "801") then
      Player.SetDamage(Player.GetHandle(), 0, ATK_KIND_DMG_SMALL)
    end
    if _UPVALUE0_ == 0 then
      Effect.LoopEnd(Bullet.GetEffectHandle(EntityManager:GetEntity(_UPVALUE0_).myHandle))
      EntityManager:GetEntity(_UPVALUE0_).step = 1
    end
  end,
  OnReturnDamage = function(_ARG_0_)
    Entity.ClearSpeed(_ARG_0_.myHandle)
    _ARG_0_:GotoState("Idling")
    return
  end,
  OnUpdate = function(_ARG_0_)
    _ARG_0_:Update()
    _ARG_0_:Debug()
    if Entity.HasNetGameHandle(_ARG_0_.myHandle) and Enemy.IsNetworkMaster(_ARG_0_.myHandle) == false and Enemy.GetRecvTargetHandle(_ARG_0_.myHandle) ~= NULL_HANDLE then
      _ARG_0_.targetHandle = Enemy.GetRecvTargetHandle(_ARG_0_.myHandle)
    end
    if _ARG_0_.oldShootLockNum ~= Entity.GetUserShootLocked(_ARG_0_.myHandle) and (_ARG_0_:GetState() == "Idling" or _ARG_0_:GetState() == "RightTrun" or _ARG_0_:GetState() == "LeftTrun" or _ARG_0_:GetState() == "Approache" or _ARG_0_:GetState() == "Goes_away") then
      print("\131\131j\131b\131N\131C\131\147\131p\131N\131g\130\197\148\240\130\175\130\233\129I\129I\129I\n")
      _ARG_0_.stack:clear()
      _ARG_0_.stack:push("Idling")
      _ARG_0_.stack:push("SonicImpact")
      _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
    end
    _ARG_0_.oldShootLockNum = Entity.GetUserShootLocked(_ARG_0_.myHandle)
    if _ARG_0_.burstStartFlag == 0 then
    elseif _ARG_0_.burstStartFlag == 1 then
      _ARG_0_.burstTimer = _ARG_0_.burstTimer - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      if 0 > _ARG_0_.burstTimer and _ARG_0_:IsNoChangeState() == true then
        _ARG_0_.stack:push("Idling")
        print("\144\218\139\223\141U\140\130\130\214\n")
        _ARG_0_:ShortAttackState()
        _ARG_0_:GotoState("SonicImpact")
        _ARG_0_:GotoState("BurstAttack")
        _ARG_0_.burstTimer = 0
        _ARG_0_.burstStartFlag = 0
        _ARG_0_.burstEndTimer = 0
        return
      end
      _ARG_0_.burstEndTimer = _ARG_0_.burstEndTimer - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      if 0 > _ARG_0_.burstEndTimer then
        _ARG_0_.burstEndTimer = 0
        _ARG_0_.burstTimer = 0
        _ARG_0_.burstStartFlag = 0
      end
    end
    if 0 >= _ARG_0_.evadeTimer then
      _ARG_0_.evadeTimer = 0
    else
      _ARG_0_.evadeTimer = _ARG_0_.evadeTimer - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
    end
    if 0 >= _ARG_0_.oldoldKeyModeCrearTime then
      _ARG_0_.oldoldKeyModeCrearTime = 0
      _ARG_0_.oldoldKeyMode = 9999
    else
      _ARG_0_.oldoldKeyModeCrearTime = _ARG_0_.oldoldKeyModeCrearTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
    end
  end,
  Debug = function(_ARG_0_)
    if Script.IsDebugCheckAttack() then
      for _FORV_5_, _FORV_6_ in pairs(_UPVALUE0_) do
        if _FORV_6_ == _ARG_0_:GetState() then
          return
        end
      end
      if _UPVALUE0_[Script.GetDebugAttackNumber() + 1] ~= nil then
        _ARG_0_.stack:clear()
        _ARG_0_.stack:push("Idling")
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        _ARG_0_:GotoState(_UPVALUE0_[Script.GetDebugAttackNumber() + 1])
      end
    end
  end
}, {__index = __StateMachine})
EntityFactory:Add("b85vs00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
setmetatable({
  new = function(_ARG_0_)
    return setmetatable(__StateMachine:new(), _UPVALUE0_)
  end,
  states = {
    Appear = {
      OnBeginState = function(_ARG_0_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
      end
    },
    Waiting = {
      OnBeginState = function(_ARG_0_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
      end
    },
    Dead = {
      OnBeginState = function(_ARG_0_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
      end
    }
  },
  OnInit = function(_ARG_0_, _ARG_1_)
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.step = 0
    _ARG_0_.Master = NULL_HANDLE
    _ARG_0_.HitAttackFlag = 0
    Entity.EnableLockon(_ARG_0_.myHandle, 0)
    Entity.EnableBgColl(_ARG_0_.myHandle, 0)
    Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
    if Enemy.IsAllEnemyWaiting() then
      _ARG_0_:GotoState("Waiting")
    else
      _ARG_0_:GotoState("Appear")
    end
  end,
  OnDamage = function(_ARG_0_, _ARG_1_, _ARG_2_)
    return 0
  end,
  OnDead = function(_ARG_0_)
    return 0
  end,
  OnReflect = function(_ARG_0_, _ARG_1_, _ARG_2_)
    if _ARG_2_ == EntityManager:GetEntity(_ARG_0_.Master).targetHandle then
      EntityManager:GetEntity(_ARG_0_.Master).reflectFlag = 1
    end
    return 1
  end,
  OnHitAttack = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    print("b87vs00 OnHitAttack kind = " .. _ARG_3_ .. "\n")
    if _ARG_1_ == EntityManager:GetEntity(_ARG_0_.Master).targetHandle then
      EntityManager:GetEntity(_ARG_0_.Master).HitAttackFlag = 1
    end
    if ATK_KIND_DMG_BLOW == _ARG_3_ or ATK_KIND_DMG_TOSS == _ARG_3_ then
      Entity.GetDamageCrossPos(_UPVALUE0_, _ARG_0_.targetHandle)
      _UPVALUE1_:set(0, 0, 0)
      Entity.SetEffect(_ARG_0_.myHandle, "b85vs00", "B085_KEY_CRI0_0", _UPVALUE0_, _UPVALUE1_)
    end
    return 1
  end,
  OnUpdate = function(_ARG_0_)
    if Entity.GetName(_ARG_0_.myHandle) == "b87vs00" then
      Entity.SetAttacker(_ARG_0_.myHandle, _ARG_0_.Master)
      if _ARG_0_.friendFlag == 1 then
        Entity.SetCollKindForAAC(_ARG_0_.myHandle, COLL_KIND_PLAYER)
        Enemy.EnableTargetEnemy(_ARG_0_.myHandle, 1)
      end
    end
    _UPVALUE0_:set(0, 0, 0)
    Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE0_)
    Entity.SetOldLocalPos(_ARG_0_.myHandle, _UPVALUE0_)
  end,
  Debug = function(_ARG_0_)
    if Script.IsDebugCheckAttack() then
      for _FORV_5_, _FORV_6_ in pairs(_UPVALUE0_) do
        if _FORV_6_ == _ARG_0_:GetState() then
          return
        end
      end
      if _UPVALUE0_[Script.GetDebugAttackNumber() + 1] ~= nil then
        _ARG_0_.stack:clear()
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        _ARG_0_:GotoState(_UPVALUE0_[Script.GetDebugAttackNumber() + 1])
      end
    end
  end
}, {__index = __StateMachine})
EntityFactory:Add("b87vs00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b92vs00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b93vs00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
setmetatable({
  new = function(_ARG_0_)
    return setmetatable(__StateMachine:new(), _UPVALUE0_)
  end,
  states = {
    Appear = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, 3)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:GotoState("Move_Magic")
      end
    },
    BarnImpact = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":BarnImpact\n")
        Entity.SetTimer(_ARG_0_.myHandle, 120)
        Entity.SetMotion(_ARG_0_.myHandle, "480")
        Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 1)
        _ARG_0_.attTimer = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 0)
        Entity.SetMotion(_ARG_0_.myHandle, "470")
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.Speed = _ARG_0_.Speed + 0.5 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.Speed > 0.22 then
          _ARG_0_.Speed = 0.22
        end
        _ARG_0_.attTimer = _ARG_0_.attTimer - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.attTimer < 0 then
          _ARG_0_.attTimer = 40
          Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 1)
        end
        Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.targetHandle, 2)
        Entity.TurnTargetDegree(_ARG_0_.myHandle, _UPVALUE0_, 1)
        FVECTOR3.set(_UPVALUE0_, 0, 0, _ARG_0_.Speed)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          if 0.5 > Script.Random() then
            _ARG_0_:GotoState("Move_Magic")
          else
            _ARG_0_:GotoState("Move_Attack")
          end
        end
      end
    },
    Idling = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":Idling\n")
        Entity.SetMotion(_ARG_0_.myHandle, "470")
        Effect.LoopEnd(_ARG_0_.effectHandle)
        _ARG_0_.effectHandle = NULL_HANDLE
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _UPVALUE0_:set(0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle), 0)
        _UPVALUE1_:set(0, 0, 2.5)
        Math.RotateVectorXYZ(_UPVALUE1_, _UPVALUE0_)
        _UPVALUE1_:scale(1.2)
        Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.Master, 2)
        FVECTOR3.Add(_UPVALUE1_, _UPVALUE2_, _UPVALUE1_)
        Entity.GetWorldPos(_UPVALUE3_, _ARG_0_.targetHandle, 1)
        Entity.TurnTargetDegree(_ARG_0_.myHandle, _UPVALUE3_, 16)
        if Entity.CalcDistance(_ARG_0_.myHandle, _UPVALUE1_) < 1.8 then
          _ARG_0_.Speed = _ARG_0_.Speed - 0.05 * Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 > _ARG_0_.Speed then
            _ARG_0_.Speed = 0
          end
        else
          _ARG_0_.Speed = _ARG_0_.Speed + 0.005 * Entity.GetFrameRate(_ARG_0_.myHandle)
          if _ARG_0_.Speed > 0.2 then
            _ARG_0_.Speed = 0.2
          end
        end
        Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
        _UPVALUE4_:set(0, 0, 1)
        Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.myHandle)
        FVECTOR3.Sub(_UPVALUE2_, _UPVALUE2_, _UPVALUE1_)
        _UPVALUE2_:normalize()
        _UPVALUE0_:setx(-Math.Atan2(_UPVALUE2_:gety(), Math.Sqrt(_UPVALUE2_:getx() * _UPVALUE2_:getx() + _UPVALUE2_:getz() * _UPVALUE2_:getz())) * -1)
        _UPVALUE0_:sety((Math.Atan2(_UPVALUE2_:getx(), _UPVALUE2_:getz())))
        _UPVALUE0_:sety(Entity.CalcDirection(_ARG_0_.myHandle, _UPVALUE1_))
        Math.RotateVectorXYZ(_UPVALUE4_, _UPVALUE0_)
        _UPVALUE4_:scale(_ARG_0_.Speed)
        Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE4_)
      end
    },
    Move_Magic = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":Move_Magic\n")
        Entity.SetMotion(_ARG_0_.myHandle, "470")
        if _ARG_0_.effectHandle == NULL_HANDLE then
          _UPVALUE0_:set(0.5, 0, 0)
          _UPVALUE1_:set(0, 0, 0)
          _ARG_0_.effectHandle = Entity.AttachEffect(_ARG_0_.myHandle, "b85vs00", "B085_ASH_ORA1_0", "shield", _UPVALUE0_, _UPVALUE1_)
          Effect.SetAttachNoRot(_ARG_0_.effectHandle, true)
        end
      end,
      OnEndState = function(_ARG_0_)
        Effect.LoopEnd(_ARG_0_.effectHandle)
      end,
      OnUpdate = function(_ARG_0_)
        _UPVALUE0_:set(0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle), 0)
        _UPVALUE1_:set(0, 0, 2.5)
        Math.RotateVectorXYZ(_UPVALUE1_, _UPVALUE0_)
        _UPVALUE1_:scale(1.2)
        Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.Master, 2)
        FVECTOR3.Add(_UPVALUE1_, _UPVALUE2_, _UPVALUE1_)
        Entity.GetWorldPos(_UPVALUE3_, _ARG_0_.targetHandle, 1)
        Entity.TurnTargetDegree(_ARG_0_.myHandle, _UPVALUE3_, 16)
        if Entity.CalcDistance(_ARG_0_.myHandle, _UPVALUE1_) < 1.8 then
          _ARG_0_.Speed = _ARG_0_.Speed - 0.05 * Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 > _ARG_0_.Speed then
            _ARG_0_.Speed = 0
          end
        else
          _ARG_0_.Speed = _ARG_0_.Speed + 0.005 * Entity.GetFrameRate(_ARG_0_.myHandle)
          if _ARG_0_.Speed > 0.2 then
            _ARG_0_.Speed = 0.2
          end
        end
        Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
        _UPVALUE4_:set(0, 0, 1)
        Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.myHandle)
        FVECTOR3.Sub(_UPVALUE2_, _UPVALUE2_, _UPVALUE1_)
        _UPVALUE2_:normalize()
        _UPVALUE0_:setx(-Math.Atan2(_UPVALUE2_:gety(), Math.Sqrt(_UPVALUE2_:getx() * _UPVALUE2_:getx() + _UPVALUE2_:getz() * _UPVALUE2_:getz())) * -1)
        _UPVALUE0_:sety((Math.Atan2(_UPVALUE2_:getx(), _UPVALUE2_:getz())))
        _UPVALUE0_:sety(Entity.CalcDirection(_ARG_0_.myHandle, _UPVALUE1_))
        Math.RotateVectorXYZ(_UPVALUE4_, _UPVALUE0_)
        _UPVALUE4_:scale(_ARG_0_.Speed)
        Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE4_)
      end
    },
    Move_Attack = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, "470", 9, 9)
        if _ARG_0_.effectHandle == NULL_HANDLE then
          _UPVALUE0_:set(0.5, 0, 0)
          _UPVALUE1_:set(0, 0, 0)
          _ARG_0_.effectHandle = Entity.AttachEffect(_ARG_0_.myHandle, "b85vs00", "B085_ASH_ORA0_0", "shield", _UPVALUE0_, _UPVALUE1_)
          Effect.SetAttachNoRot(_ARG_0_.effectHandle, true)
        end
      end,
      OnEndState = function(_ARG_0_)
        Effect.LoopEnd(_ARG_0_.effectHandle)
      end,
      OnUpdate = function(_ARG_0_)
        _UPVALUE0_:set(0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle), 0)
        _UPVALUE1_:set(0, 0, 2.5)
        Math.RotateVectorXYZ(_UPVALUE1_, _UPVALUE0_)
        _UPVALUE1_:scale(1.2)
        Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.Master, 2)
        FVECTOR3.Add(_UPVALUE1_, _UPVALUE2_, _UPVALUE1_)
        Entity.GetWorldPos(_UPVALUE3_, _ARG_0_.targetHandle, 1)
        Entity.TurnTargetDegree(_ARG_0_.myHandle, _UPVALUE3_, 16)
        if Entity.CalcDistance(_ARG_0_.myHandle, _UPVALUE1_) < 1.8 then
          _ARG_0_.Speed = _ARG_0_.Speed - 0.05 * Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 > _ARG_0_.Speed then
            _ARG_0_.Speed = 0
          end
        else
          _ARG_0_.Speed = _ARG_0_.Speed + 0.005 * Entity.GetFrameRate(_ARG_0_.myHandle)
          if _ARG_0_.Speed > 0.2 then
            _ARG_0_.Speed = 0.2
          end
        end
        Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
        _UPVALUE4_:set(0, 0, 1)
        Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.myHandle)
        FVECTOR3.Sub(_UPVALUE2_, _UPVALUE2_, _UPVALUE1_)
        _UPVALUE2_:normalize()
        _UPVALUE0_:setx(-Math.Atan2(_UPVALUE2_:gety(), Math.Sqrt(_UPVALUE2_:getx() * _UPVALUE2_:getx() + _UPVALUE2_:getz() * _UPVALUE2_:getz())) * -1)
        _UPVALUE0_:sety((Math.Atan2(_UPVALUE2_:getx(), _UPVALUE2_:getz())))
        _UPVALUE0_:sety(Entity.CalcDirection(_ARG_0_.myHandle, _UPVALUE1_))
        Math.RotateVectorXYZ(_UPVALUE4_, _UPVALUE0_)
        _UPVALUE4_:scale(_ARG_0_.Speed)
        Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE4_)
      end
    }
  },
  TurnTarget = function(_ARG_0_)
    if 1 == 1 then
      return
    end
    if _ARG_0_:GetState() == "BarnImpact" then
      Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
      _UPVALUE0_:set(0, -0.5, 0)
      Entity.SetLocalBoneTrans(_ARG_0_.myHandle, _UPVALUE0_, 2)
      _ARG_0_.oldAngly = _ARG_0_.oldAngly + 1
      _ARG_0_.oldAnglz = _ARG_0_.oldAnglz + 10
      if _ARG_0_.oldAnglz > 90 then
        _ARG_0_.oldAnglz = 90
      end
      _UPVALUE0_:set(0, RoundPI(_ARG_0_.oldAngly), RoundPI(DegToRad(_ARG_0_.oldAnglz)))
      Entity.RotateBoneXYZ(_ARG_0_.myHandle, 2, _UPVALUE0_)
    else
      _ARG_0_.oldAngly = 0
      _ARG_0_.oldAnglz = _ARG_0_.oldAnglz - 5.5
      if 0 > _ARG_0_.oldAnglz then
        _ARG_0_.oldAnglz = 0
      end
      _UPVALUE0_:set(0, RoundPI(_ARG_0_.oldAngly), RoundPI(DegToRad(_ARG_0_.oldAnglz)))
      Entity.RotateBoneXYZ(_ARG_0_.myHandle, 2, _UPVALUE0_)
    end
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.step = 0
    _ARG_0_.Master = NULL_HANDLE
    _ARG_0_.targetHandle = NULL_HANDLE
    _ARG_0_.effectHandle = NULL_HANDLE
    _ARG_0_.HitAttackFlag = 0
    _ARG_0_.taimer = 0
    Entity.EnableLockon(_ARG_0_.myHandle, 0)
    Entity.EnableHeavy(_ARG_0_.myHandle, 0)
    Entity.EnableGravity(_ARG_0_.myHandle, 0)
    _ARG_0_.hitEffectCreateTimer = 0
    _ARG_0_.hitEffectCreateTimer2 = 0
    _ARG_0_.oldAngly = 0
    _ARG_0_.oldAnglz = 0
    _ARG_0_.Speed = 0
    Entity.SetLockOnBoneNum(_ARG_1_, 26)
    _ARG_0_:GotoState("Idling")
    _ARG_0_.hitPos = FVECTOR3.new(0, 0, 0)
  end,
  OnDamage = function(_ARG_0_, _ARG_1_)
    return 1
  end,
  OnDamageBefore = function(_ARG_0_, _ARG_1_, _ARG_2_)
    Entity.GetDamageCrossPos(_UPVALUE0_, _ARG_0_.myHandle)
    if _UPVALUE1_.KeyMode == _UPVALUE2_ then
      if _ARG_0_:GetState() == "Move_Attack" and _ARG_2_ == COMMAND_CATEGORY_ATTACK then
        _UPVALUE1_.AttackPow = _UPVALUE1_.AttackPow + 1
        _UPVALUE3_:set(0, 0, 0)
        Entity.SetEffect(_ARG_0_.myHandle, "b85vs00", "B085_ASH_GUA0_0", _UPVALUE0_, _UPVALUE3_)
      elseif _ARG_0_:GetState() == "Move_Magic" and _ARG_2_ == COMMAND_CATEGORY_MACIG then
        _UPVALUE1_.MagicPow = _UPVALUE1_.MagicPow + 1
        _UPVALUE3_:set(0, 0, 0)
        Entity.SetEffect(_ARG_0_.myHandle, "b85vs00", "B085_ASH_GUA1_0", _UPVALUE0_, _UPVALUE3_)
      elseif _ARG_2_ == COMMAND_CATEGORY_NETWORK then
        _UPVALUE1_.MagicPow = _UPVALUE1_.MagicPow + 1
        _UPVALUE3_:set(0, 0, 0)
        Entity.SetEffect(_ARG_0_.myHandle, "b85vs00", "B085_ASH_GUA1_0", _UPVALUE0_, _UPVALUE3_)
        _UPVALUE1_.AttackPow = _UPVALUE1_.AttackPow + 1
        _UPVALUE3_:set(0, 0, 0)
        Entity.SetEffect(_ARG_0_.myHandle, "b85vs00", "B085_ASH_GUA0_0", _UPVALUE0_, _UPVALUE3_)
      end
    end
    Entity.SetEffect(_ARG_0_.myHandle, "p_ex_bas_00", "P_EX_ATC_DIS1_0", _UPVALUE0_, _UPVALUE3_)
    print("AttackPow = " .. _UPVALUE1_.AttackPow .. "\n")
    print("MagicPow = " .. _UPVALUE1_.MagicPow .. "\n")
    return 1
  end,
  OnGuard = function(_ARG_0_)
    return 1
  end,
  OnDead = function(_ARG_0_)
    return 1
  end,
  OnUpdatePositionAfter = function(_ARG_0_)
    _ARG_0_:TurnTarget()
  end,
  OnReturnDamage = function(_ARG_0_)
  end,
  OnHitAttack = function(_ARG_0_, _ARG_1_)
    print("B85VS_PARAM.AttackPow = " .. _UPVALUE0_.AttackPow .. "\130\197\130\183\129B\n")
    print("B85VS_PARAM.MagicPow = " .. _UPVALUE0_.MagicPow .. "\130\197\130\183\129B\n")
    print("\131o\129[\131X\131g\131C\131\147\131p\131N\131g\130\204\131_\131\129\129[\131W\130\205" .. Player.CalcDamagePoint(_ARG_1_, Gimmick.GetAttackPoint(_ARG_0_.Master, 19), (Gimmick.GetAttackPowerCorrection(_ARG_0_.Master, 19))) .. "\130\197\130\183\129B\n")
    print("\149\226\144\179\146l\130\240\140v\142Z\130\181\130\196" .. Player.CalcDamagePoint(_ARG_1_, Gimmick.GetAttackPoint(_ARG_0_.Master, 19), (Gimmick.GetAttackPowerCorrection(_ARG_0_.Master, 19))) * (_UPVALUE0_.AttackPow + _UPVALUE0_.MagicPow) .. "\130\201\130\200\130\232\130\220\130\183\129B\n")
    if Entity.GetHp(_ARG_1_) - Player.CalcDamagePoint(_ARG_1_, Gimmick.GetAttackPoint(_ARG_0_.Master, 19), (Gimmick.GetAttackPowerCorrection(_ARG_0_.Master, 19))) * (_UPVALUE0_.AttackPow + _UPVALUE0_.MagicPow) <= 2 then
      print("\131\137\131X\131g\131\138\129[\131u\130\170\147\173\130\173\130\204\130\197" .. Entity.GetHp(_ARG_1_) - 2 .. "\130\204\131_\131\129\129[\131W\130\240\151^\130\166\130\233\130\230\130\164\130\201\130\181\130\220\130\183\129B\n")
    end
    Player.SetDamage(_ARG_1_, 0)
    Entity.GetDamageCrossPos(_ARG_0_.hitPos, _ARG_1_)
    _UPVALUE1_:set(_ARG_0_.hitPos:getx() + Script.Random(), _ARG_0_.hitPos:gety() + Script.Random(), _ARG_0_.hitPos:getz() + Script.Random())
    _UPVALUE2_:set(0, 0, 0)
    Entity.SetEffect(_ARG_0_.myHandle, "b85vs00", "B085_KEY_HIT0_0", _UPVALUE1_, _UPVALUE2_)
    _ARG_0_.hitEffectCreateTimer = 10
    _ARG_0_.hitEffectCreateTimer2 = 4
    return 1
  end,
  OnUpdate = function(_ARG_0_)
    _ARG_0_:Update()
    _ARG_0_.hitEffectCreateTimer = _ARG_0_.hitEffectCreateTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
    _ARG_0_.hitEffectCreateTimer2 = _ARG_0_.hitEffectCreateTimer2 - Entity.GetFrameRate(_ARG_0_.myHandle)
    if _ARG_0_.hitEffectCreateTimer > 0 and _ARG_0_.hitEffectCreateTimer2 < 0 then
      _ARG_0_.hitEffectCreateTimer2 = 4
      _UPVALUE0_:set(_ARG_0_.hitPos:getx() + Script.Random(), _ARG_0_.hitPos:gety() + Script.Random(), _ARG_0_.hitPos:getz() + Script.Random())
      _UPVALUE1_:set(0, 0, 0)
      print("\141U\140\130\131q\131b\131g\142\158\130\204\131G\131t\131F\131N\131g rnd" .. Script.Random() .. "\n")
      if Script.Random() < 0.3 then
        Entity.SetEffect(_ARG_0_.myHandle, "m_ex_fir_00", "P_MA_FI1_HIT0_0", _UPVALUE0_, _UPVALUE1_)
        print("\137\206\n")
      elseif Script.Random() < 0.6 then
        print("\149X\n")
        Entity.SetEffect(_ARG_0_.myHandle, "m_ex_blz_00", "P_MA_BL1_HIT0_0", _UPVALUE0_, _UPVALUE1_)
      elseif Script.Random() < 0.8 then
        print("\151\139\n")
        Entity.SetEffect(_ARG_0_.myHandle, "m_ex_thd_00", "P_MA_TH1_HIT1_0", _UPVALUE0_, _UPVALUE1_)
      elseif Script.Random() < 0.9 then
        print("\146\202\143\237\n")
        Entity.SetEffect(_ARG_0_.myHandle, "b85vs00", "B085_KEY_HIT0_0", _UPVALUE0_, _UPVALUE1_)
      elseif Script.Random() < 1 then
        print("\146\202\143\237\n")
        Entity.SetEffect(_ARG_0_.myHandle, "m_ex_thd_00", "P_MA_TH1_HIT1_0", _UPVALUE0_, _UPVALUE1_)
      end
    end
  end,
  Debug = function(_ARG_0_)
    if Script.IsDebugCheckAttack() then
      for _FORV_5_, _FORV_6_ in pairs(_UPVALUE0_) do
        if _FORV_6_ == _ARG_0_:GetState() then
          return
        end
      end
      if _UPVALUE0_[Script.GetDebugAttackNumber() + 1] ~= nil then
        _ARG_0_.stack:clear()
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        _ARG_0_:GotoState(_UPVALUE0_[Script.GetDebugAttackNumber() + 1])
      end
    end
  end
}, {__index = __StateMachine})
EntityFactory:Add("b94vs00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("Volley", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("DGigaFlare", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("sonicwaveb", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("Straightb", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("InDark", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("DarkGround", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("SetPlyaerB", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("BurstB", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("Balazs00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("Balazs10", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("Balazs20", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("Balazs30", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("Balazs40", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("Balazs50", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("Balazs60", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("Balazs70", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("Balazs80", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("Balazs90", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
function SetingGuard(_ARG_0_)
  print("\131K\129[\131h\138J\142n\n")
  Entity.EnableGuard(_ARG_0_.myHandle, 1)
  Entity.EnableGuardPhysical(_ARG_0_.myHandle, 1)
  Entity.EnableGuardZero(_ARG_0_.myHandle, 1)
  Entity.EnableGuardFire(_ARG_0_.myHandle, 1)
  Entity.EnableGuardIce(_ARG_0_.myHandle, 1)
  Entity.EnableGuardDark(_ARG_0_.myHandle, 1)
  Entity.EnableGuardThunder(_ARG_0_.myHandle, 1)
  Entity.SetGuardDir(_ARG_0_.myHandle, 180)
  Entity.EnableGuardSpecial(_ARG_0_.myHandle, 1)
  Entity.EnableGuardAttack(_ARG_0_.myHandle, 1)
  Entity.EnableGuardZeroEx(_ARG_0_.myHandle, 1)
end
function EndGuard(_ARG_0_)
  print("\131K\129[\131h\143I\151\185\n")
  Entity.EnableGuard(_ARG_0_.myHandle, 0)
  Entity.EnableGuardPhysical(_ARG_0_.myHandle, 0)
  Entity.EnableGuardZero(_ARG_0_.myHandle, 0)
  Entity.EnableGuardFire(_ARG_0_.myHandle, 0)
  Entity.EnableGuardIce(_ARG_0_.myHandle, 0)
  Entity.EnableGuardThunder(_ARG_0_.myHandle, 0)
  Entity.EnableGuardDark(_ARG_0_.myHandle, 0)
  Entity.SetGuardDir(_ARG_0_.myHandle, 0)
  Entity.EnableGuardSpecial(_ARG_0_.myHandle, 0)
  Entity.EnableGuardAttack(_ARG_0_.myHandle, 1)
  Entity.EnableGuardZeroEx(_ARG_0_.myHandle, 0)
end
function RsetAttackOrMagicPow()
  print("\131o\129[\131X\131g\131C\131\147\131p\131N\131g\151p\130\204\131p\131\137\131\129\129[\131^\129[\131\138\131Z\131b\131g\n")
  _UPVALUE0_.AttackPow = 0
  _UPVALUE0_.MagicPow = 0
end
function RsetAttackFlags(_ARG_0_)
  _ARG_0_.gigaFlareFlag = 0
  _ARG_0_.SinpactFlareFlag = 0
  _ARG_0_.SinpactFlareFlag = 0
  _ARG_0_.burstFlareFlag = 0
end
function SetAppendAndMotion(_ARG_0_, _ARG_1_, _ARG_2_)
  _ARG_0_:setAppend(_ARG_1_)
  _ARG_0_.step = 0
  _ARG_0_.attackFlag = 0
  if _ARG_0_.oldoldKeyMode == _ARG_1_ then
    _ARG_0_.step = 1
  else
    _ARG_0_:setMotion(_ARG_2_)
  end
end
function CheckAppendEnd(_ARG_0_)
  if _ARG_0_.step == 0 then
    Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
    if Entity.IsMotionEnd(_ARG_0_.myHandle) then
      _ARG_0_:setMotion(_UPVALUE0_)
      _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
    end
  else
    _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
  end
end
function LockPlayerPos(_ARG_0_)
  Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.targetHandle, 5)
  Entity.SetLocalPos(_ARG_0_.targetHandle, _UPVALUE0_)
  Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 1)
  Entity.SetOldLocalPos(_ARG_0_.targetHandle, _UPVALUE0_)
end
function ReleaseAttach(_ARG_0_)
  if Entity.IsAttachCoord(Player.GetPlayers()) == true then
    Entity.GetWorldPos(_UPVALUE0_, Player.GetPlayers())
    Entity.SetLocalPos(Player.GetPlayers())
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 1)
    Entity.SetOldLocalPos(Player.GetPlayers())
    Entity.AttachCoord(NULL_HANDLE, "", Player.GetPlayers())
  end
  if Entity.IsAttachCoord(Player.GetPlayers()) == true then
    Entity.GetWorldPos(_UPVALUE0_, Player.GetPlayers())
    Entity.SetLocalPos(Player.GetPlayers())
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 1)
    Entity.SetOldLocalPos(Player.GetPlayers())
    Entity.AttachCoord(NULL_HANDLE, "", Player.GetPlayers())
  end
  if Entity.IsAttachCoord(Player.GetPlayers()) == true then
    Entity.GetWorldPos(_UPVALUE0_, Player.GetPlayers())
    Entity.SetLocalPos(Player.GetPlayers())
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 1)
    Entity.SetOldLocalPos(Player.GetPlayers())
    Entity.AttachCoord(NULL_HANDLE, "", Player.GetPlayers())
  end
end
function SetAttach(_ARG_0_)
  if Entity.IsAttachCoord(_ARG_0_.targetHandle) == false then
    _UPVALUE0_:set(0, 0, 0)
    Entity.SetOldLocalPos(_ARG_0_.targetHandle, _UPVALUE0_)
    Entity.SetLocalPos(_ARG_0_.targetHandle, _UPVALUE0_)
    Entity.SetRot(_ARG_0_.targetHandle, _UPVALUE0_)
    Entity.AttachCoord(_ARG_0_.myHandle, "R_buki", _ARG_0_.targetHandle, "Root")
  end
end
