m14ex00 = {}
m14ex00_base_mt = {__index = __StateMachine}
setmetatable(m14ex00, m14ex00_base_mt)
m14ex00_mt = {__index = m14ex00}
function m14ex00.new(_ARG_0_)
  return setmetatable(__StateMachine:new(), m14ex00_mt)
end
m14ex00.states = {
  Appear = {
    OnBeginState = function(_ARG_0_)
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
  Idling = {
    OnBeginState = function(_ARG_0_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      _ARG_0_:SetMode(_UPVALUE2_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        if not (Script.Random() < _UPVALUE0_) or Enemy.isBind(_ARG_0_.myHandle) == 1 then
        else
          _ARG_0_:GotoState("ModeChange_in_Search")
          return
        end
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE1_ then
          if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) == true then
            if Script.Random() < _UPVALUE2_ then
              _ARG_0_:GotoState("Energyspin")
            else
              _ARG_0_:GotoState("Move")
            end
          else
            _ARG_0_:GotoState("Move")
          end
        elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _UPVALUE1_ then
          if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) == true then
            if Script.Random() < _UPVALUE3_ then
              _ARG_0_:GotoState("Laser")
            else
              _ARG_0_:GotoState("Move")
            end
          else
            _ARG_0_:GotoState("Wander")
          end
        end
      end
    end
  },
  Move = {
    OnBeginState = function(_ARG_0_)
      print("m14ex00:Move\n")
      _ARG_0_.step = 0
      _ARG_0_.work0 = 1.5 + Script.Random()
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        if _ARG_0_:RandomMove() == 1 then
          if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) == true then
            if Script.Random() < _UPVALUE0_ then
              _ARG_0_:GotoState("Energyspin")
            else
              Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
            end
          else
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
          end
        elseif _ARG_0_:RandomMove() == 2 then
          if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) == true then
            if Script.Random() < _UPVALUE2_ then
              _ARG_0_:GotoState("Laser")
            else
              Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE3_)
            end
          else
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
          end
        end
      end
    end
  },
  Wander = {
    OnBeginState = function(_ARG_0_)
      print("m14ex00:Wander\n")
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_ * (Script.Random() * 4 + 1))
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.step = _UPVALUE2_
      _ARG_0_.count = 0
      _ARG_0_.work0 = 1.5 + Script.Random()
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
        _UPVALUE1_:set(0, 0, 0)
        _ARG_0_.targetPos:setx(_ARG_0_.targetPos:getx() + (5 * Script.Random() + 3) * Math.Cos((RoundPI(Script.Random() * 2 * PI))))
        _ARG_0_.targetPos:setz(_ARG_0_.targetPos:getz() + (5 * Script.Random() + 3) * Math.Sin((RoundPI(Script.Random() * 2 * PI))))
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE2_ * (Script.Random() * 2))
        _ARG_0_.noWallHitTime = 120
        _ARG_0_.step = _UPVALUE3_
      elseif _ARG_0_.step == _UPVALUE4_ then
      elseif _ARG_0_.step == _UPVALUE3_ then
        if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) == true then
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE5_ then
            if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) == true then
              if Script.Random() < _UPVALUE6_ then
                _ARG_0_:GotoState("Energyspin")
              end
            else
              _ARG_0_:GotoState("Move")
            end
          elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _UPVALUE5_ then
            _ARG_0_:GotoState("Move")
          end
          return
        end
        _ARG_0_.MoveFlag = M14EX_MOVETYPE_HOMING
        if CanDisappear(_ARG_0_.myHandle, _ARG_0_.targetHandle) == true then
          _ARG_0_:GotoState("Disappear")
          return
        end
        _ARG_0_:RetrievalAirMove((Entity.GetFrameRate(_ARG_0_.myHandle)))
        _ARG_0_.noWallHitTime = _ARG_0_.noWallHitTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if 0 > _ARG_0_.noWallHitTime then
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.IsWall(_ARG_0_.myHandle) == true or 1 > Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetPos) then
          _ARG_0_.count = _ARG_0_.count + 1
          if _ARG_0_.count > 6 then
            _ARG_0_:GotoState("Idling")
          else
            _ARG_0_.step = _UPVALUE0_
          end
        end
      end
    end
  },
  Energyspin = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10) == false then
          _ARG_0_.step = _ARG_0_.step + 1
        end
      elseif _ARG_0_.step == 1 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.step = 2
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        end
      elseif _ARG_0_.step == 2 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Laser = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
      _ARG_0_.SearchFlag = _UPVALUE1_
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
    end,
    OnEndState = function(_ARG_0_)
      Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 0)
      Effect.LoopEnd(_ARG_0_.LightHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10) == false then
          _ARG_0_.step = _ARG_0_.step + 1
        end
      elseif _ARG_0_.step == 1 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 27 then
          _ARG_0_.workVec0:set(0, 0, 0)
          _ARG_0_.rot:set(0, DegToRad(90), 0)
          _ARG_0_.LightHandle = Entity.AttachEffect(_ARG_0_.myHandle, "e_ex140", "E014_REY_01_0", "atama", _ARG_0_.workVec0, _ARG_0_.rot)
          _ARG_0_.workVec1:set(10, 0, 0)
          Entity.GetWorldPos2(_ARG_0_.workVec1, _ARG_0_.myHandle, _ARG_0_.workVec1, 10)
          _ARG_0_.rot:set(0, 0, 0)
          Enemy.SetGeneralPurposeAttackColl(_ARG_0_.myHandle, COLL_KIND_ENEMY, COLL_SHAPE_CYLINDER, 0.3)
          Enemy.SetGeneralPurposeAttackCollParam(_ARG_0_.myHandle, Enemy.GetAttackKind(_ARG_0_.myHandle, 0), Enemy.GetAttackAttr(_ARG_0_.myHandle, 0), Enemy.GetAttackPoint(_ARG_0_.myHandle, 0), Enemy.GetAttackPowerCorrection(_ARG_0_.myHandle, 0))
          Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 0)
          Enemy.SetGeneralPurposeAttackCollHitAttackEffectName(_ARG_0_.myHandle, "e_ex140", "E014_REY_04_0")
          _ARG_0_.step = 2
        end
      elseif _ARG_0_.step == 2 then
        if Effect.IsAlive(_ARG_0_.LightHandle) then
          Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.myHandle, 10)
          _ARG_0_.workVec1:set(10, 0, 0)
          Entity.GetWorldPos2(_ARG_0_.workVec1, _ARG_0_.myHandle, _ARG_0_.workVec1, 10)
          Collision.IntersectRayBg(_ARG_0_.workVec1, COLL_KIND_ENEMY, _ARG_0_.workVec0, _ARG_0_.workVec1)
          _ARG_0_.rot:set(0, 0, 0)
          Enemy.SetGeneralPurposeAttackCollPos(_ARG_0_.myHandle, _ARG_0_.workVec0, _ARG_0_.workVec1)
          FVECTOR3.Sub(_ARG_0_.workVec2, _ARG_0_.workVec1, _ARG_0_.workVec0)
          _ARG_0_.workVec3:set(1, 1, _ARG_0_.workVec2:length() / 11)
          Effect.SetScale(_ARG_0_.LightHandle, _ARG_0_.workVec3)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) <= 43 then
            Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 1)
          else
            Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 0)
          end
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 39 then
            Effect.LoopEnd(_ARG_0_.LightHandle)
            _ARG_0_.LightHandle = NULL_HANDLE
            _ARG_0_.step = 3
          end
        end
      elseif _ARG_0_.step == 3 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) <= 43 then
          Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 1)
        else
          Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 0)
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.step = 4
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
          Effect.LoopEnd(_ARG_0_.LightHandle)
          _ARG_0_.LightHandle = NULL_HANDLE
        end
      elseif _ARG_0_.step == 4 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  ModeChange_in_Search = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
      Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
    end,
    OnEndState = function(_ARG_0_)
      Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.step = 1
          _ARG_0_:SetMode(_UPVALUE0_)
        end
      elseif _ARG_0_.step == 1 then
        Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
        _UPVALUE1_:set(0, 0, 0)
        _ARG_0_.targetPos:setx(_ARG_0_.targetPos:getx() + (5 * Script.Random() + 2) * Math.Cos((RoundPI(Script.Random() * 2 * PI))))
        _ARG_0_.targetPos:setz(_ARG_0_.targetPos:getz() + (5 * Script.Random() + 2) * Math.Sin((RoundPI(Script.Random() * 2 * PI))))
        Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.targetHandle)
        Collision.IntersectRayBg(_ARG_0_.targetPos, COLL_KIND_ENEMY, _UPVALUE1_, _ARG_0_.targetPos)
        Entity.SetLocalPos(_ARG_0_.myHandle, _ARG_0_.targetPos)
        _ARG_0_.step = 2
      elseif _ARG_0_.step == 2 then
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
        _ARG_0_.step = 3
      elseif _ARG_0_.step == 3 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("SearchIdling")
      end
    end
  },
  ModeChange_in_Attack = {
    OnBeginState = function(_ARG_0_)
      print("ModeChange_in_Attack\n")
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
      Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
    end,
    OnEndState = function(_ARG_0_)
      Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.step = 1
          _ARG_0_:SetMode(_UPVALUE0_)
        end
      elseif _ARG_0_.step == 1 then
        if 0 > _ARG_0_.loockOnNum then
          Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.myHandle)
        else
          Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
        end
        _UPVALUE1_:set(0, 0, 0)
        _ARG_0_.targetPos:setx(_ARG_0_.targetPos:getx() + (5 * Script.Random() + 2) * Math.Cos((RoundPI(Script.Random() * 2 * PI))))
        _ARG_0_.targetPos:setz(_ARG_0_.targetPos:getz() + (5 * Script.Random() + 2) * Math.Sin((RoundPI(Script.Random() * 2 * PI))))
        if 0 >= _ARG_0_.loockOnNum then
          Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
        else
          Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.targetHandle)
        end
        Collision.IntersectRayBg(_ARG_0_.targetPos, COLL_KIND_ENEMY, _UPVALUE1_, _ARG_0_.targetPos)
        if Enemy.isBind(_ARG_0_.myHandle) == 1 then
          Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.myHandle)
        else
        end
        Entity.SetLocalPos(_ARG_0_.myHandle, _ARG_0_.targetPos)
        _ARG_0_.step = 2
      elseif _ARG_0_.step == 2 then
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
        _ARG_0_.step = 3
      elseif _ARG_0_.step == 3 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        if 0 >= _ARG_0_.loockOnNum then
          _ARG_0_:GotoState("Idling")
          return
        else
          _ARG_0_:GotoState("EnergyShot")
          return
        end
      end
    end
  },
  SearchIdling = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_ * (Script.Random() * 0.5))
      _ARG_0_.SearchLightTime = 240
      _ARG_0_.step = _UPVALUE2_
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.noWallHitTime = _ARG_0_.noWallHitTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      _ARG_0_.SearchWait = _ARG_0_.SearchWait - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      _ARG_0_.SearchLightTime = _ARG_0_.SearchLightTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      if _ARG_0_.step == _UPVALUE0_ then
        if Enemy.GetTimeTargetHasBeenVisible(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 2400 then
          Enemy.GetTargetLastRecordedPos(_ARG_0_.targetPos, _ARG_0_.myHandle, _ARG_0_.targetHandle)
        else
          Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.myHandle)
        end
        _UPVALUE1_:set(0, 0, 0)
        _ARG_0_.targetPos:setx(_ARG_0_.targetPos:getx() + (5 * Script.Random() + 3) * Math.Cos((RoundPI(Script.Random() * 2 * PI))))
        _ARG_0_.targetPos:setz(_ARG_0_.targetPos:getz() + (5 * Script.Random() + 3) * Math.Sin((RoundPI(Script.Random() * 2 * PI))))
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE2_ * (Script.Random() * 2))
        _ARG_0_.noWallHitTime = 120
        _ARG_0_.step = _UPVALUE3_
      elseif _ARG_0_.step == _UPVALUE4_ then
      elseif _ARG_0_.step == _UPVALUE3_ then
        _ARG_0_:RetrievalAirMove((Entity.GetFrameRate(_ARG_0_.myHandle)))
        if _ARG_0_.SearchLightTime < 0 then
          _ARG_0_:GotoState("SearchLight")
          return
        end
        if _ARG_0_.noWallHitTime < 0 then
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.IsWall(_ARG_0_.myHandle) == true or 1 > Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetPos) then
          _ARG_0_.step = _UPVALUE0_
        end
      end
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("SearchLight")
        return
      end
    end
  },
  SearchLightDamage = {
    OnBeginState = function(_ARG_0_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
    end
  },
  SearchLight = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetTimer(_ARG_0_.myHandle, 60)
      _ARG_0_.SearchAng = 0.05
      _ARG_0_.SearchFlag = _UPVALUE1_
      Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
      _ARG_0_.loockOnNum = 0
      _ARG_0_.step = _UPVALUE2_
      _UPVALUE3_:set(0, 0, 0)
      _UPVALUE4_:set(0, DegToRad(90), 0)
      _ARG_0_.SearchLightTime = _UPVALUE5_
      _ARG_0_.SearchWait = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      _ARG_0_.rot:setx(DegToRad(0))
      Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.rot:setx(DegToRad(20))
      Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
      _ARG_0_.noWallHitTime = _ARG_0_.noWallHitTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      _ARG_0_.SearchWait = _ARG_0_.SearchWait - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      _ARG_0_.SearchLightTime = _ARG_0_.SearchLightTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      if _ARG_0_.step == _UPVALUE0_ then
        if Enemy.GetTimeTargetHasBeenVisible(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 2400 then
          Enemy.GetTargetLastRecordedPos(_ARG_0_.targetPos, _ARG_0_.myHandle, _ARG_0_.targetHandle)
        else
          Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.myHandle)
        end
        _UPVALUE1_:set(0, 0, 0)
        _ARG_0_.targetPos:setx(_ARG_0_.targetPos:getx() + (5 * Script.Random() + 3) * Math.Cos((RoundPI(Script.Random() * 2 * PI))))
        _ARG_0_.targetPos:setz(_ARG_0_.targetPos:getz() + (5 * Script.Random() + 3) * Math.Sin((RoundPI(Script.Random() * 2 * PI))))
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE2_ / (Script.Random() * 1) + 3)
        _ARG_0_.noWallHitTime = 120
        _ARG_0_.step = _UPVALUE3_
      elseif _ARG_0_.step == _UPVALUE4_ then
      elseif _ARG_0_.step == _UPVALUE3_ then
        _ARG_0_.MoveFlag = M14EX_MOVETYPE_HOMING
        if 0 >= _ARG_0_.loockOnNum then
          _ARG_0_:RetrievalAirMove((Entity.GetFrameRate(_ARG_0_.myHandle)))
          Entity.GetWorldPos(_ARG_0_.playerPos, _ARG_0_.targetHandle, 2)
          _ARG_0_:initOldPos(_ARG_0_.playerPos:getx(), _ARG_0_.playerPos:gety(), _ARG_0_.playerPos:getz())
        else
          _ARG_0_.SearchFlag = _UPVALUE5_
          _ARG_0_:PLSearchAirMove((Entity.GetFrameRate(_ARG_0_.myHandle)))
        end
        if _ARG_0_.SearchLightTime < 0 or _ARG_0_.loockOnNum >= _UPVALUE6_ then
          _ARG_0_:GotoState("ModeChange_in_Attack")
          Player.SetEnemyLockOne(_ARG_0_.myHandle)
          return
        end
        if _ARG_0_.noWallHitTime < 0 then
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.IsWall(_ARG_0_.myHandle) == true or 1 > Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetPos) then
          _ARG_0_.step = _UPVALUE0_
        end
      end
      if Entity.IsPlayer(_ARG_0_.targetHandle) then
      else
        return
      end
      if Entity.CanUserTarget(_ARG_0_.targetHandle) == true then
        Entity.GetWorldPos(_ARG_0_.playerPos, _ARG_0_.targetHandle, 2)
        Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle, 11)
        Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
        FVECTOR3.Sub(_UPVALUE1_, _ARG_0_.playerPos, _ARG_0_.myPos)
        FVECTOR3.normalize(_UPVALUE1_)
        if _ARG_0_.SearchWait < 0 and ROUND_PI(Math.Atan2(_UPVALUE1_:getx(), _UPVALUE1_:getz()) * -1) - (_ARG_0_.oldAngly - _ARG_0_.rot:gety()) < DegToRad(_UPVALUE7_) and ROUND_PI(Math.Atan2(_UPVALUE1_:getx(), _UPVALUE1_:getz()) * -1) - (_ARG_0_.oldAngly - _ARG_0_.rot:gety()) > DegToRad(_UPVALUE8_) and ROUND_PI(-Math.Atan2(_UPVALUE1_:gety(), Math.Sqrt(_UPVALUE1_:getz() * _UPVALUE1_:getz() + _UPVALUE1_:getx() * _UPVALUE1_:getx()))) + _ARG_0_.rot:getz() < DegToRad(_UPVALUE9_) and ROUND_PI(-Math.Atan2(_UPVALUE1_:gety(), Math.Sqrt(_UPVALUE1_:getz() * _UPVALUE1_:getz() + _UPVALUE1_:getx() * _UPVALUE1_:getx()))) + _ARG_0_.rot:getz() > DegToRad(_UPVALUE10_) then
          if Entity.HasNetGameHandle(_ARG_0_.myHandle) == true then
            if Player.GetHandleForNet() == _ARG_0_.meaHandle then
              Player.SetLockOnMakert(_ARG_0_.myHandle, 1)
            end
          else
            Player.SetLockOnMakert(_ARG_0_.myHandle, 1)
          end
          _ARG_0_.loockOnNum = _ARG_0_.loockOnNum + 1
          if _ARG_0_.loockOnNum == 1 then
            _ARG_0_.SearchWait = 45
            Entity.SetTimer(_ARG_0_.myHandle, 60)
          else
            _ARG_0_.SearchWait = 5
          end
          if _ARG_0_.loockOnNum >= _UPVALUE6_ then
            _ARG_0_.loockOnNum = _UPVALUE6_
          end
        end
      end
    end
  },
  EnergyShot = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
      _ARG_0_.loockOnNum = _ARG_0_.loockOnNum - 1
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      _ARG_0_.loockOnNum = 0
      Player.SetLockOnMakert(_ARG_0_.myHandle, 0)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 20) == false then
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 21 then
          _ARG_0_:CreateShot(_ARG_0_.myHandle)
          _ARG_0_.step = 5
          _ARG_0_.loockOnNum = _ARG_0_.loockOnNum - 1
          Player.SetLockOnMakert(_ARG_0_.myHandle, 0)
        end
      elseif _ARG_0_.step == 4 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          if 0 >= _ARG_0_.loockOnNum then
            _ARG_0_.step = 2
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            Player.SetLockOnMakert(_ARG_0_.myHandle, 0)
          else
            _ARG_0_.step = 6
          end
          _ARG_0_.loockOnNum = _ARG_0_.loockOnNum - 1
        end
      elseif _ARG_0_.step == 5 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.step = 6
        end
      elseif _ARG_0_.step == 6 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 21 then
          _ARG_0_:CreateShot(_ARG_0_.myHandle)
          _ARG_0_.step = 4
        end
        if Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 30) == false then
        end
      elseif _ARG_0_.step == 2 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.step = 3
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
        end
      elseif _ARG_0_.step == 3 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
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
function m14ex00.PLSearchAirMove(_ARG_0_, _ARG_1_)
  Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.targetHandle, 2)
  _ARG_0_:setOldPos(_UPVALUE0_:getx(), _UPVALUE0_:gety(), _UPVALUE0_:getz())
  _UPVALUE0_:set(_ARG_0_.oldPlayerPos[_UPVALUE1_].x, _ARG_0_.oldPlayerPos[_UPVALUE1_].y, _ARG_0_.oldPlayerPos[_UPVALUE1_].z)
  Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE0_, 5)
  if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > 16 then
    _ARG_0_.velocity:set(0, 0, 1)
    _ARG_0_.velocity:scale(_UPVALUE2_)
    _ARG_0_.velocity:sety(0)
    Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
  elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 9 then
    _ARG_0_.velocity:set(0, 0, 1)
    _ARG_0_.velocity:scale(-_UPVALUE2_)
    _ARG_0_.velocity:sety(0)
    Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
  else
    Entity.ClearSpeed(_ARG_0_.myHandle)
  end
end
function m14ex00.RetrievalAirMove(_ARG_0_, _ARG_1_)
  _UPVALUE0_ = _UPVALUE0_ - 1 * _ARG_1_
  if _UPVALUE0_ <= 0 then
    _ARG_0_.targetAngle = (Script.Random() - Script.Random()) * (0.5 * PI)
    _UPVALUE0_ = 240 + Script.Random() * 80
    _ARG_0_.noWallHitTime = 30
    _UPVALUE1_:set(Math.Cos((RoundPI(DegToRad(Script.Random() * 360)))) * (Script.Random() * 1 + 5), 0, Math.Sin((RoundPI(DegToRad(Script.Random() * 360)))) * (Script.Random() * 1 + 5))
    _ARG_0_.targetSpeed = Script.Random() * 0.3 + 0.1
  end
  Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
  Entity.GetWorldPos(_ARG_0_.playerPos, _ARG_0_.targetHandle, 2)
  if Entity.GetFloorDistance(_ARG_0_.myHandle) < 0.2 then
    _ARG_0_.targetAngle = -Script.Random() * (0.5 * PI)
    _ARG_0_.targetSpeed = Script.Random() * 0.3 + 0.1
  elseif 1 < Entity.GetFloorDistance(_ARG_0_.myHandle) then
    _ARG_0_.targetAngle = Script.Random() * (0.5 * PI)
    _ARG_0_.targetSpeed = Script.Random() * 0.3 + 0.1
  end
  FVECTOR3.Add(_ARG_0_.targetPos, _ARG_0_.targetPos, _UPVALUE1_)
  Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 3)
  _ARG_0_.angle = HomingDegree(_ARG_0_.angle, _ARG_0_.targetAngle, RoundPI(1.5), _ARG_1_)
  _ARG_0_.noWallHitTime = _ARG_0_.noWallHitTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if 0 > _ARG_0_.noWallHitTime then
  end
  if Entity.IsWall(_ARG_0_.myHandle) == true or 1 > Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.playerPos) then
    _UPVALUE0_ = -1
  end
  _ARG_0_.Speed = HomingDegree(_ARG_0_.Speed, _ARG_0_.targetAngle, RoundPI(1.5), _ARG_1_)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  _ARG_0_.rot:setx(_ARG_0_.angle)
  _ARG_0_.velocity:set(0, 0, 1)
  Math.RotateVectorXYZ(_ARG_0_.velocity, _ARG_0_.rot)
  _ARG_0_.velocity:scale(_UPVALUE2_)
  Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
end
function m14ex00.RandomMove(_ARG_0_)
  _UPVALUE0_ = _UPVALUE0_ - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _UPVALUE0_ <= 0 then
    _ARG_0_.targetAngle = (Script.Random() - Script.Random()) * (0.5 * PI)
    _UPVALUE0_ = 240 + Script.Random() * 80
    _ARG_0_.noWallHitTime = 30
    _UPVALUE1_:set(Math.Cos((RoundPI(DegToRad(Script.Random() * 360)))) * (Script.Random() * 1 + 5), 0, Math.Sin((RoundPI(DegToRad(Script.Random() * 360)))) * (Script.Random() * 1 + 5))
    _ARG_0_.targetSpeed = Script.Random() * 0.3 + 0.1
  end
  Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
  Entity.GetWorldPos(_ARG_0_.playerPos, _ARG_0_.targetHandle, 2)
  if 1 > Entity.GetFloorDistance(_ARG_0_.myHandle) then
    _ARG_0_.targetAngle = -Script.Random() * (0.5 * PI)
    _ARG_0_.targetSpeed = Script.Random() * 0.3 + 0.1
  elseif 2 < Entity.GetFloorDistance(_ARG_0_.myHandle) then
    _ARG_0_.targetAngle = Script.Random() * (0.5 * PI)
    _ARG_0_.targetSpeed = Script.Random() * 0.3 + 0.1
  end
  FVECTOR3.Add(_ARG_0_.playerPos, _ARG_0_.playerPos, _UPVALUE1_)
  Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.playerPos, 2)
  _ARG_0_.angle = HomingDegree(_ARG_0_.angle, _ARG_0_.targetAngle, RoundPI(1.5), (Entity.GetFrameRate(_ARG_0_.myHandle)))
  _ARG_0_.noWallHitTime = _ARG_0_.noWallHitTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if 0 > _ARG_0_.noWallHitTime then
  end
  if Entity.IsWall(_ARG_0_.myHandle) == true or 1 > Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.playerPos) then
    _UPVALUE0_ = -1
  end
  _ARG_0_.Speed = HomingDegree(_ARG_0_.Speed, _ARG_0_.targetAngle, RoundPI(1.5), (Entity.GetFrameRate(_ARG_0_.myHandle)))
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  _ARG_0_.rot:setx(_ARG_0_.angle)
  _ARG_0_.velocity:set(0, 0, 1)
  Math.RotateVectorXYZ(_ARG_0_.velocity, _ARG_0_.rot)
  _ARG_0_.velocity:scale(_UPVALUE2_)
  Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
  _UPVALUE3_ = _UPVALUE3_ - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE4_ then
    return 1
  elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _UPVALUE4_ and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE5_ then
    return 2
  elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _UPVALUE5_ then
    return 3
  end
  if CanDisappear(_ARG_0_.myHandle, _ARG_0_.targetHandle) == true then
    _ARG_0_:GotoState("Disappear")
    return
  end
  return 0
end
function ROUND_PI(_ARG_0_)
  if _ARG_0_ < -PI then
    return _ARG_0_ + PI * 2
  elseif _ARG_0_ > PI then
    return _ARG_0_ - PI * 2
  else
    return _ARG_0_
  end
end
function m14ex00.initOldPos(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  for _FORV_7_ = _UPVALUE0_, 0, -1 do
    _ARG_0_.oldPlayerPos[_FORV_7_].x = _ARG_1_
    _ARG_0_.oldPlayerPos[_FORV_7_].y = _ARG_2_
    _ARG_0_.oldPlayerPos[_FORV_7_].z = _ARG_3_
  end
end
function m14ex00.setOldPos(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  _ARG_0_.oldPlayerPos[0].x = _ARG_1_
  _ARG_0_.oldPlayerPos[0].y = _ARG_2_
  _ARG_0_.oldPlayerPos[0].z = _ARG_3_
  for _FORV_7_ = _UPVALUE0_, 1, -1 do
    _ARG_0_.oldPlayerPos[_FORV_7_].x = _ARG_0_.oldPlayerPos[_FORV_7_ - 1].x
    _ARG_0_.oldPlayerPos[_FORV_7_].y = _ARG_0_.oldPlayerPos[_FORV_7_ - 1].y
    _ARG_0_.oldPlayerPos[_FORV_7_].z = _ARG_0_.oldPlayerPos[_FORV_7_ - 1].z
  end
end
function m14ex00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.targetHandle = NULL_HANDLE
  _ARG_0_.LightEffectHandle = NULL_HANDLE
  _ARG_0_.LightHandle = NULL_HANDLE
  _ARG_0_.LightHandle_End = NULL_HANDLE
  _ARG_0_.LightHandleColl = NULL_HANDLE
  _ARG_0_.angle = 0
  _ARG_0_.Speed = 0
  _ARG_0_.work0 = 0
  _ARG_0_.targetSpeed = 0
  _ARG_0_.targetAngle = 0
  _ARG_0_.oldAnglx = 0
  _ARG_0_.oldAngly = 0
  _ARG_0_.modeFlag = 0
  _ARG_0_.noWallHitTime = 0
  _ARG_0_.SearchLightTime = 0
  _ARG_0_.SearchFlag = 0
  _ARG_0_.SearchAng = 0
  _ARG_0_.SearchWait = 0
  _ARG_0_.loockOnNum = 0
  _ARG_0_.workVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec0 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec2 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec3 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
  _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.playerPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.AntennaPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.LookMaxMin = {}
  _ARG_0_.LookMaxMin[0] = {
    Max = DegToRad(10),
    Min = DegToRad(-10)
  }
  _ARG_0_.LookMaxMin[1] = {
    Max = DegToRad(10),
    Min = DegToRad(-10)
  }
  _ARG_0_.oldPlayerPos = {}
  for _FORV_5_ = 0, _UPVALUE0_ do
    _ARG_0_.oldPlayerPos[_FORV_5_] = {
      x = 0,
      y = 0,
      z = 0
    }
  end
  if _FOR_ == false then
    _UPVALUE2_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "Action1Dist") * Enemy.GetExtraParam(_ARG_0_.myHandle, "Action1Dist")
    _UPVALUE3_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "Action2Dist") * Enemy.GetExtraParam(_ARG_0_.myHandle, "Action2Dist")
    _UPVALUE4_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "LockOnNum")
    _UPVALUE1_ = true
  end
  Entity.SetMovementCollRadius(_ARG_0_.myHandle, 1.1)
  Entity.SetLowerHalf(_ARG_0_.myHandle, 1.2)
  Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
  Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
  Entity.EnableLockon(_ARG_0_.myHandle, 0)
  Entity.EnableGravity(_ARG_0_.myHandle, 0)
  Enemy.IsAllEnemyWaiting()
  if Enemy.IsAllEnemyWaiting() == true then
    _ARG_0_:GotoState("Standby")
  else
    _ARG_0_:GotoState("Appear")
    Entity.EnableLockon(_ARG_0_.myHandle, 1)
  end
end
function m14ex00.OnDead(_ARG_0_)
  Effect.LoopEnd(_ARG_0_.LightHandle)
  _ARG_0_.LightHandle = NULL_HANDLE
  Player.SetLockOnMakert(_ARG_0_.myHandle, 0)
end
function m14ex00.OnDamage(_ARG_0_, _ARG_1_)
  Player.SetLockOnMakert(_ARG_0_.myHandle, 0)
  _ARG_0_.loockOnNum = 0
  if _ARG_0_:GetState() == "SearchLight" then
    _ARG_0_:GotoState("SearchLightDamage")
  else
  end
  Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 0)
  Effect.LoopEnd(_ARG_0_.LightHandle)
  _ARG_0_.SearchFlag = _UPVALUE0_
  Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
end
function m14ex00.SetMode(_ARG_0_, _ARG_1_)
  _ARG_0_.modeFlag = _ARG_1_
end
function m14ex00.GetDamageMotionNum(_ARG_0_, _ARG_1_)
  Effect.LoopEnd(_ARG_0_.LightHandle)
  _ARG_0_.LightHandle = NULL_HANDLE
  if _ARG_1_ == DMG_MOT_GROUND_FRONT_UPPER or _ARG_1_ == DMG_MOT_GROUND_FRONT_LOWER or _ARG_1_ == DMG_MOT_GROUND_BACK_UPPER or _ARG_1_ == DMG_MOT_GROUND_BACK_UPPER then
    if _ARG_0_.modeFlag == _UPVALUE0_ then
      return 7
    elseif _ARG_0_.modeFlag == _UPVALUE1_ then
      return 8
    end
  elseif _ARG_1_ == DMG_MOT_AIR_FRONT or _ARG_1_ == DMG_MOT_AIR_BACK then
    if _ARG_0_.modeFlag == _UPVALUE0_ then
      return 7
    elseif _ARG_0_.modeFlag == _UPVALUE1_ then
      return 8
    end
  elseif _ARG_1_ == DMG_MOT_FRONT_BLOW or _ARG_1_ == DMG_MOT_BACK_BLOW then
    if _ARG_0_.modeFlag == _UPVALUE0_ then
      return 9
    elseif _ARG_0_.modeFlag == _UPVALUE1_ then
      return 11
    end
  elseif _ARG_1_ == DMG_MOT_FRONT_RETURN or _ARG_1_ == DMG_MOT_BACK_RETURN then
    if _ARG_0_.modeFlag == _UPVALUE0_ then
      return 10
    elseif _ARG_0_.modeFlag == _UPVALUE1_ then
      return 12
    end
  elseif _ARG_1_ == DMG_MOT_REFLECT then
  elseif _ARG_1_ == DMG_MOT_FAINT then
  elseif _ARG_1_ == DMG_MOT_FAINT_RETURN then
  elseif _ARG_1_ == DMG_MOT_REFLECT_AIR then
  elseif _ARG_1_ == DMG_MOT_JUMP then
  elseif _ARG_1_ == 17 then
    return 1
  end
end
function m14ex00.OnReturnDamage(_ARG_0_)
  if _ARG_0_.LightHandle ~= NULL_HANDLE then
    Effect.LoopEnd(_ARG_0_.LightHandle)
  end
  if _ARG_0_:GetState() == "SearchIdling" or _ARG_0_:GetState() == "SearchLight" or _ARG_0_:GetState() == "ModeChange_in_Search" or _ARG_0_:GetState() == "SearchLightDamage" then
    _ARG_0_:GotoState("ModeChange_in_Attack")
    _ARG_0_.loockOnNum = 0
    Player.SetLockOnMakert(_ARG_0_.myHandle, 0)
  else
    _ARG_0_:GotoState("Idling")
    _ARG_0_.loockOnNum = 0
    Player.SetLockOnMakert(_ARG_0_.myHandle, 0)
  end
end
function m14ex00.GetNumber(_ARG_0_)
  if _ARG_0_:GetState() == "SearchLight" then
    return 1
  else
    return 0
  end
end
function m14ex00.LockOnNumber(_ARG_0_)
  return _ARG_0_.loockOnNum
end
function m14ex00.OnHitAttack(_ARG_0_)
end
function m14ex00.Search(_ARG_0_)
  if _ARG_0_.SearchFlag == _UPVALUE0_ then
    if _ARG_0_.oldAngly + _ARG_0_.SearchAng < DegToRad(-45) or _ARG_0_.oldAngly + _ARG_0_.SearchAng > DegToRad(45) then
      _ARG_0_.SearchAng = _ARG_0_.SearchAng * -1
    end
    _ARG_0_.oldAngly = HomingDegree(_ARG_0_.oldAngly, _ARG_0_.oldAngly + _ARG_0_.SearchAng, 1, (Entity.GetFrameRate(_ARG_0_.myHandle)))
    _ARG_0_.AntennaPos:set(0, ROUND_PI((HomingDegree(_ARG_0_.oldAngly, _ARG_0_.oldAngly + _ARG_0_.SearchAng, 1, (Entity.GetFrameRate(_ARG_0_.myHandle))))), 0)
    Entity.RotateBoneXYZ(_ARG_0_.myHandle, 11, _ARG_0_.AntennaPos)
  elseif _ARG_0_.SearchFlag == _UPVALUE1_ then
    _ARG_0_.oldAngly = HomingDegree(_ARG_0_.oldAnglx, 0, DegToRad(1), (Entity.GetFrameRate(_ARG_0_.myHandle)))
    _ARG_0_.AntennaPos:set(0, ROUND_PI(_ARG_0_.oldAngly), 0)
    Entity.RotateBoneXYZ(_ARG_0_.myHandle, 11, _ARG_0_.AntennaPos)
  elseif _ARG_0_.SearchFlag == _UPVALUE2_ then
    Entity.GetWorldPos(_ARG_0_.playerPos, _ARG_0_.targetHandle, 5)
    Entity.GetWorldPos(_ARG_0_.AntennaPos, _ARG_0_.myHandle, 11)
    Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
    FVECTOR3.Sub(_UPVALUE3_, _ARG_0_.playerPos, _ARG_0_.AntennaPos)
    FVECTOR3.normalize(_UPVALUE3_)
    _ARG_0_.oldAngly, _ARG_0_.oldAnglx = HomingDegree(_ARG_0_.oldAngly, Math.Atan2(_UPVALUE3_:getx(), _UPVALUE3_:getz()) - _ARG_0_.rot:gety(), 5, (Entity.GetFrameRate(_ARG_0_.myHandle))), HomingDegree(_ARG_0_.oldAnglx, -Math.Atan2(_UPVALUE3_:gety(), Math.Sqrt(_UPVALUE3_:getz() * _UPVALUE3_:getz() + _UPVALUE3_:getx() * _UPVALUE3_:getx())) - _ARG_0_.rot:getx(), 5, (Entity.GetFrameRate(_ARG_0_.myHandle)))
    _ARG_0_.AntennaPos:set(0, ROUND_PI(HomingDegree(_ARG_0_.oldAngly, Math.Atan2(_UPVALUE3_:getx(), _UPVALUE3_:getz()) - _ARG_0_.rot:gety(), 5, (Entity.GetFrameRate(_ARG_0_.myHandle))) * -1), ROUND_PI((HomingDegree(_ARG_0_.oldAnglx, -Math.Atan2(_UPVALUE3_:gety(), Math.Sqrt(_UPVALUE3_:getz() * _UPVALUE3_:getz() + _UPVALUE3_:getx() * _UPVALUE3_:getx())) - _ARG_0_.rot:getx(), 5, (Entity.GetFrameRate(_ARG_0_.myHandle))))))
    if _ARG_0_.AntennaPos:getz() > _ARG_0_.LookMaxMin[1].Max then
      _ARG_0_.AntennaPos:setz(_ARG_0_.LookMaxMin[1].Max)
    end
    if _ARG_0_.AntennaPos:getz() < _ARG_0_.LookMaxMin[1].Min then
      _ARG_0_.AntennaPos:setz(_ARG_0_.LookMaxMin[1].Min)
    end
    Entity.RotateBoneXYZ(_ARG_0_.myHandle, 11, _ARG_0_.AntennaPos)
  elseif _ARG_0_.SearchFlag == _UPVALUE4_ then
    _ARG_0_.workVec:set(-2, 0, 0)
    Entity.GetWorldPos(_ARG_0_.playerPos, _ARG_0_.targetHandle)
    Entity.GetWorldPos2(_ARG_0_.AntennaPos, _ARG_0_.myHandle, _ARG_0_.workVec, 9)
    Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
    FVECTOR3.Sub(_UPVALUE3_, _ARG_0_.playerPos, _ARG_0_.AntennaPos)
    FVECTOR3.normalize(_UPVALUE3_)
    _ARG_0_.AntennaPos:set(0, ROUND_PI(-Math.Atan2(_UPVALUE3_:gety(), Math.Sqrt(_UPVALUE3_:getz() * _UPVALUE3_:getz() + _UPVALUE3_:getx() * _UPVALUE3_:getx()))), 0)
    Entity.RotateBoneXYZ(_ARG_0_.myHandle, 9, _ARG_0_.AntennaPos)
  end
end
function m14ex00.OnUpdatePositionAfter(_ARG_0_)
  _ARG_0_:Search()
end
function m14ex00.Debug(_ARG_0_)
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
function m14ex00.OnUpdate(_ARG_0_)
  _ARG_0_:Update()
  _ARG_0_:Debug()
  if _ARG_0_.modeFlag == _UPVALUE0_ then
    Entity.EnableModelDisp(_ARG_0_.myHandle, 1, 0)
    Entity.EnableModelDisp(_ARG_0_.myHandle, 2, 1)
  else
    Entity.EnableModelDisp(_ARG_0_.myHandle, 1, 1)
    Entity.EnableModelDisp(_ARG_0_.myHandle, 2, 0)
  end
end
EntityFactory:Add("m14ex00", function(_ARG_0_)
  return (m14ex00:new())
end)
EntityFactory:Add("m14vs00", function(_ARG_0_)
  return (m14ex00:new())
end)
function m14ex00.CreateShot(_ARG_0_, _ARG_1_)
  Entity.GetWorldPos(_ARG_0_.playerPos, _ARG_0_.targetHandle, 2)
  Entity.GetWorldPos(_ARG_0_.myPos, _ARG_1_, 10)
  Entity.GetRot(_ARG_0_.rot, _ARG_1_)
  FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.playerPos, _ARG_0_.myPos)
  FVECTOR3.normalize(_ARG_0_.workVec)
  _ARG_0_.rot:setx(-Math.Atan2(_ARG_0_.workVec:gety(), Math.Sqrt(_ARG_0_.workVec:getz() * _ARG_0_.workVec:getz() + _ARG_0_.workVec:getx() * _ARG_0_.workVec:getx())))
  Bullet.CreateEffectBullet(Bullet.CreateBullet("m14ex00b", _ARG_0_.myPos, _ARG_0_.rot), "e_ex140", "E014_SHO_00_0")
  if Enemy.IsConfuse(_ARG_0_.myHandle) then
    Bullet.SetCollision(Bullet.CreateBullet("m14ex00b", _ARG_0_.myPos, _ARG_0_.rot), COLL_KIND_NO_CHECK, COLL_SHAPE_SPHERE, 0.5, 0, _ARG_1_)
  else
    Bullet.SetCollision(Bullet.CreateBullet("m14ex00b", _ARG_0_.myPos, _ARG_0_.rot), COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, 0.5, 0, _ARG_1_)
  end
  SetBulletAttackParam(Bullet.CreateBullet("m14ex00b", _ARG_0_.myPos, _ARG_0_.rot), _ARG_0_.myHandle, 2)
  Bullet.SetHitAttackEffectName(Bullet.CreateBullet("m14ex00b", _ARG_0_.myPos, _ARG_0_.rot), "e_ex140", "E014_SHO_01_0")
  Bullet.SetHitBgEffectName(Bullet.CreateBullet("m14ex00b", _ARG_0_.myPos, _ARG_0_.rot), "e_ex140", "E014_SHO_01_0")
  Entity.GetWorldPos(_ARG_0_.playerPos, _ARG_0_.targetHandle)
  Bullet.EnableReflect(Bullet.CreateBullet("m14ex00b", _ARG_0_.myPos, _ARG_0_.rot), Enemy.GetAttackReflect(_ARG_0_.myHandle, 0))
  Entity.CalcVelocity(Bullet.CreateBullet("m14ex00b", _ARG_0_.myPos, _ARG_0_.rot), 0.25)
end
m14ex00b = {}
m14ex00b_mt = {__index = m14ex00b}
function m14ex00b.new(_ARG_0_)
  return setmetatable({}, m14ex00b_mt)
end
function m14ex00b.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.masterHandle = NULL_HANDLE
  _ARG_0_.step = 0
  _ARG_0_.workVec = FVECTOR3.new(0, 0, 0)
  Entity.SetTimer(_ARG_0_.myHandle, 180)
end
function m14ex00b.OnUpdate(_ARG_0_)
  if _ARG_0_.step == 0 then
    if Entity.IsTimeOver(_ARG_0_.myHandle) then
      Bullet.DeleteBullet(_ARG_0_.myHandle)
    end
  elseif _ARG_0_.step == 1 then
  end
end
EntityFactory:Add("m14ex00b", function(_ARG_0_)
  return (m14ex00b:new())
end)
