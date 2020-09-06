m01ex00 = {}
m01ex00_base_mt = {__index = __StateMachine}
setmetatable(m01ex00, m01ex00_base_mt)
m01ex00_mt = {__index = m01ex00}
function m01ex00.new(_ARG_0_)
  return setmetatable(__StateMachine:new(), m01ex00_mt)
end
m01ex00.states = {
  Appear = {
    OnBeginState = function(_ARG_0_)
      SetupAppearBegin(_ARG_0_.myHandle, 1, _UPVALUE0_, 0)
    end,
    OnEndState = function(_ARG_0_)
      SetupAppearEnd(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Idling = {
    OnBeginState = function(_ARG_0_)
      print("Idling\n")
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetAnimNowFrame(_ARG_0_.myHandle, Script.Random() * Entity.GetMotionTotalFrame(_ARG_0_.myHandle))
      Entity.SetTimer(_ARG_0_.myHandle, Script.Random() * Entity.GetMotionTotalFrame(_ARG_0_.myHandle) + Script.Random() * Entity.GetMotionTotalFrame(_ARG_0_.myHandle))
      _ARG_0_.step = 0
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      _ARG_0_.Movetime = 0
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        if Entity.CanUserTarget(_ARG_0_.targetHandle) == false then
          _ARG_0_:GotoState("Wander")
          return
        end
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE0_ and _ARG_0_.step == 0 then
          if 0 < 0.4 then
            if Script.Random() < 0.5 then
              _ARG_0_:GotoState("ExscapeMove")
              return
            else
              if Entity.HasNetGameHandle(_ARG_0_.myHandle) == false then
                _ARG_0_:GotoState("CanShadowchange")
                return
              end
              if Enemy.IsNetworkMaster(_ARG_0_.myHandle) == true then
                _ARG_0_:GotoState("CanShadowchange")
                return
              end
            end
          end
        else
        end
        _ARG_0_:GotoState("Move")
      end
    end
  },
  Move = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.Movetime = _UPVALUE1_ + Script.Random() * _UPVALUE1_
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE0_ then
        if _ARG_0_.step == 0 then
          if Script.Random() < _UPVALUE1_ then
            _ARG_0_:GotoState("Attack1")
          elseif Script.Random() < _UPVALUE1_ + _UPVALUE2_ then
            _ARG_0_:GotoState("Attack2")
          else
            _ARG_0_:GotoState("Attack3")
          end
          return
        end
      elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= ENEMY_COMMON_DISAPPEAR_DIST then
        if _ARG_0_.step == 0 then
          if Script.Random() < _UPVALUE3_ then
            if Script.Random() < 0.2 then
              _ARG_0_.step = 1
            else
              _ARG_0_:GotoState("StrollMove")
            end
          else
            if Entity.HasNetGameHandle(_ARG_0_.myHandle) == false then
              _ARG_0_:GotoState("CanShadowchange")
              return
            end
            if Enemy.IsNetworkMaster(_ARG_0_.myHandle) == true then
              _ARG_0_:GotoState("CanShadowchange")
              return
            end
          end
        end
      elseif CanDisappear(_ARG_0_.myHandle, _ARG_0_.targetHandle) == true then
        _ARG_0_:GotoState("Disappear")
        return
      end
      _ARG_0_:HomingPlayer_Move()
      _ARG_0_.Movetime = _ARG_0_.Movetime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      if 0 >= _ARG_0_.Movetime or Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE0_ then
        _ARG_0_:GotoState("Move")
      end
    end
  },
  ExscapeMove = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
      if Script.Random() < 0.5 then
        _ARG_0_:setAngle(180)
      else
        _ARG_0_:setAngle(-180)
      end
      _ARG_0_.Rot_Angle = 5.8
      _ARG_0_.Movetime = _UPVALUE1_
      _ARG_0_.MoveType = _UPVALUE2_
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_:Escape_Move()
      _ARG_0_.Movetime = _ARG_0_.Movetime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      if _ARG_0_.Movetime <= 0 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  StrollMove = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.Movetime = _UPVALUE1_ + Script.Random() * _UPVALUE1_ * 2
      _ARG_0_.MoveType = _UPVALUE2_
      _ARG_0_.TargetVec:set(Script.Random() * 8 * 2 - 8, 0, 8)
      Entity.GetWorldPos2(_ARG_0_.TargetVec, _ARG_0_.myHandle, _ARG_0_.TargetVec)
      _ARG_0_.Angle = 3
      _ARG_0_.StrollCnt = Script.Random() * 1 + 1
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.HasNetGameHandle(_ARG_0_.myHandle) and Enemy.IsNetworkMaster(_ARG_0_.myHandle) == false then
        return
      end
      _ARG_0_.Movetime = _ARG_0_.Movetime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      if _ARG_0_.Movetime <= 0 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_.AttackCnt = 0
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
        _ARG_0_:GotoState("Idling")
        return
      end
      if 0 >= _ARG_0_.StrollCnt then
        _ARG_0_.AttackCnt = 0
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
        _ARG_0_:GotoState("Idling")
        return
      end
      _ARG_0_:Move()
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_.TargetVec:set(0, 0, Script.Random() * 6 - 3)
        Entity.GetWorldPos2(_ARG_0_.TargetVec, _ARG_0_.myHandle, _ARG_0_.TargetVec)
        _ARG_0_.Angle = 2
        _ARG_0_.StrollCnt = _ARG_0_.StrollCnt - 1
        return
      end
    end
  },
  Wander = {
    OnBeginState = function(_ARG_0_)
      print("Wander")
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_ + Script.Random() * _UPVALUE0_)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.step = _UPVALUE2_
      _ARG_0_.count = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.HasNetGameHandle(_ARG_0_.myHandle) and Enemy.IsNetworkMaster(_ARG_0_.myHandle) == false then
        return
      end
      if _ARG_0_.step == _UPVALUE0_ then
        if Enemy.GetTimeTargetHasBeenVisible(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 180 then
          Enemy.GetTargetLastRecordedPos(_ARG_0_.targetPos, _ARG_0_.myHandle, _ARG_0_.targetHandle)
        else
          Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.myHandle)
        end
        _ARG_0_.targetPos:setx(_ARG_0_.targetPos:getx() + 5 * Script.Random() * Math.Cos((RoundPI(Script.Random() * 2 * PI))))
        _ARG_0_.targetPos:setz(_ARG_0_.targetPos:getz() + 5 * Script.Random() * Math.Sin((RoundPI(Script.Random() * 2 * PI))))
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_ + Script.Random() * _UPVALUE1_)
        _ARG_0_.noWallHitTime = 120
        _ARG_0_.step = _UPVALUE2_
      elseif _ARG_0_.step == _UPVALUE3_ then
      elseif _ARG_0_.step == _UPVALUE2_ then
        if Enemy.CanAttack(_ARG_0_.myHandle, _ARG_0_.targetHandle) == true then
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 5)
        _ARG_0_.MoveFlag = M02EX_MOVETYPE_HOMING
        if CanDisappear(_ARG_0_.myHandle, _ARG_0_.targetHandle) == true then
          _ARG_0_:GotoState("Disappear")
          return
        end
        _ARG_0_:Move()
        _ARG_0_.noWallHitTime = _ARG_0_.noWallHitTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.noWallHitTime < 0 then
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.IsWall(_ARG_0_.myHandle) == true or 1 > Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetPos) then
          _ARG_0_.count = _ARG_0_.count + 1
          if _ARG_0_.count > 3 then
            _ARG_0_:GotoState("Idling")
          else
            _ARG_0_.step = _UPVALUE0_
          end
        end
      end
    end
  },
  Attack1 = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_.AttackCnt = _ARG_0_.AttackCnt + 1
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 and Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10) == false then
        _ARG_0_.step = _ARG_0_.step + 1
      end
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Attack2 = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_.AttackCnt = _ARG_0_.AttackCnt + 1
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 and Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10) == false then
        _ARG_0_.step = _ARG_0_.step + 1
      end
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Attack3 = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetRootMoveScale(_ARG_0_.myHandle, Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) / 4, 1, Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) / 4)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_.AttackCnt = _ARG_0_.AttackCnt + 1
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 and Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10) == false then
        _ARG_0_.step = _ARG_0_.step + 1
      end
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  CanShadowchange = {
    OnBeginState = function(_ARG_0_)
      print("CanShadowchange\n")
      _ARG_0_.ShadowFlag = _UPVALUE0_
      _ARG_0_.step = 90
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 90 then
        if Entity.IsAlive(_ARG_0_.ShadoHandle) then
          _ARG_0_.ShadowFlag = _UPVALUE0_
          if Script.Random() < _UPVALUE1_ then
          elseif Script.Random() < _UPVALUE1_ * 2 then
            _ARG_0_:initStroll((Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle)))
          else
            _ARG_0_:GotoState("ShadowchangeSinVer")
            return
          end
          _ARG_0_:GotoState("Shadowchange")
          return
        else
          _ARG_0_:GotoState("Move")
        end
      end
    end
  },
  Shadowchange = {
    OnBeginState = function(_ARG_0_)
      print("Shadowchange\n")
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
      Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
      Entity.EnableLockon(_ARG_0_.myHandle, 0)
      Shadow_Timer = 0
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      _ARG_0_.ShadowFlag = _UPVALUE1_
    end,
    OnEndState = function(_ARG_0_)
      Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 2)
      _ARG_0_.step = 0
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsAlive(_ARG_0_.ShadoHandle) then
        _ARG_0_.ShadowFlag = _UPVALUE0_
      else
        _ARG_0_.ShadowFlag = _UPVALUE1_
      end
      if _ARG_0_.ShadowFlag == _UPVALUE0_ then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 10 then
          _ARG_0_.ShadowFlag = _UPVALUE2_
        end
      elseif _ARG_0_.ShadowFlag == _UPVALUE2_ then
        _ARG_0_.ShadowFlag = _UPVALUE3_
      end
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Shadowmove_Rotationt")
      end
      _ARG_0_:ShadowStop()
    end
  },
  ShadowchangeSinVer = {
    OnBeginState = function(_ARG_0_)
      print("Shadowchange\n")
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
      Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
      Entity.EnableLockon(_ARG_0_.myHandle, 0)
      Shadow_Timer = 0
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      _ARG_0_.ShadowFlag = _UPVALUE1_
    end,
    OnEndState = function(_ARG_0_)
      Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 2)
      _ARG_0_.step = 0
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsAlive(_ARG_0_.ShadoHandle) then
        _ARG_0_.ShadowFlag = _UPVALUE0_
      else
        _ARG_0_.ShadowFlag = _UPVALUE1_
      end
      if _ARG_0_.ShadowFlag == _UPVALUE0_ then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 10 then
          _ARG_0_.ShadowFlag = _UPVALUE2_
        end
      elseif _ARG_0_.ShadowFlag == _UPVALUE2_ then
        _ARG_0_.ShadowFlag = _UPVALUE3_
      end
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Shadowmove_Rotationt_SinVer")
      end
      _ARG_0_:ShadowStop()
    end
  },
  Shadowmove_Rotationt = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.Homing_Power = 2.8 + Script.Random()
      _ARG_0_.Homing_Flag = 1
      _ARG_0_.Rot_Angle = 20
      Entity.SetTimer(_ARG_0_.myHandle, 10)
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Shadowmove")
        return
      end
      _ARG_0_:Rotation()
    end
  },
  Shadowmove_Rotationt_SinVer = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.Homing_Power = 2.8 + Script.Random()
      _ARG_0_.Homing_Flag = 1
      _ARG_0_.Rot_Angle = 20
      Entity.SetTimer(_ARG_0_.myHandle, 10)
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("ShadowmoveSinVer")
        return
      end
      _ARG_0_:Rotation()
    end
  },
  Shadowmove_Rotationt_Turn = {
    OnBeginState = function(_ARG_0_)
      Entity.SetTimer(_ARG_0_.myHandle, 10)
      if Script.Random() < 0.5 then
        _ARG_0_:setAngle(-_UPVALUE0_[1][1])
      else
        _ARG_0_:setAngle(_UPVALUE0_[1][1])
      end
      _ARG_0_.Rot_Angle = 20
      _ARG_0_.Homing_Power = _UPVALUE0_[1][2]
      _ARG_0_.Shadow_Timer = _UPVALUE0_[1][3] + Script.Random() * _UPVALUE0_[1][4]
      _ARG_0_.Homing_Flag = 1
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("ShadowmoveTrun")
        return
      end
      _ARG_0_:Rotation()
    end
  },
  Shadowmove = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.ShadowFlag = _UPVALUE0_
      _ARG_0_.Wait = 30
      Entity.SetMotion(_ARG_0_.myHandle, 0)
      Entity.SetTimer(_ARG_0_.myHandle, 300 + Script.Random() * 120)
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsAlive(_ARG_0_.ShadoHandle) then
        _ARG_0_.ShadowFlag = _UPVALUE0_
      else
        _ARG_0_.ShadowFlag = _UPVALUE1_
      end
      if _ARG_0_.step == 0 then
        _ARG_0_:ShadowMove()
      elseif _ARG_0_.step == 1 then
        _ARG_0_:ShadowStop()
        if _ARG_0_:isShadowSpeed() == 1 then
          _ARG_0_:GotoState("Shadowmove_Rotationt_Turn")
        end
      end
      if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE2_ then
        _ARG_0_.step = 1
      end
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_.step = 1
      end
    end
  },
  ShadowmoveSinVer = {
    OnBeginState = function(_ARG_0_)
      print("ShadowmoveSinVer\n")
      _ARG_0_.ShadowFlag = _UPVALUE0_
      _ARG_0_.Wait = 30
      Entity.SetMotion(_ARG_0_.myHandle, 0)
      _ARG_0_.Shadow_Timer = Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) + Script.Random() * 10 + 30
      _ARG_0_.SinCurve_Power = Script.Random() * _UPVALUE1_ + _UPVALUE2_
      _ARG_0_.Shadow_MoveTipe = _UPVALUE3_
      _ARG_0_:init_ShadowMove_SinCurve()
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsAlive(_ARG_0_.ShadoHandle) then
        _ARG_0_.ShadowFlag = _UPVALUE0_
      else
        _ARG_0_.ShadowFlag = _UPVALUE1_
      end
      if _ARG_0_.step == 0 then
        _ARG_0_:ShadowMove_SinCurve()
      elseif _ARG_0_.step == 1 then
        _ARG_0_:ShadowStop()
        if _ARG_0_:isShadowSpeed() == 1 then
          _ARG_0_:GotoState("Shadowmove_Rotationt_Turn")
        end
      end
      if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE2_ then
        _ARG_0_.step = 1
      end
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_.step = 1
      end
    end
  },
  ShadowmoveTrun = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.ShadowFlag = _UPVALUE0_
      _ARG_0_.Wait = 30
      Entity.SetMotion(_ARG_0_.myHandle, 0)
      Entity.SetTimer(_ARG_0_.myHandle, 300 + Script.Random() * 120)
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.Shadow_Timer >= 0 then
        _ARG_0_:ShadowMove_Turn()
      end
      if _ARG_0_.Shadow_Timer <= 0 then
        _ARG_0_:GotoState("ShadowmoveStop")
      end
      _ARG_0_.Shadow_Timer = _ARG_0_.Shadow_Timer - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
    end
  },
  ShadowmoveStop = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.ShadowFlag = _UPVALUE0_
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_:ShadowStop(_ARG_0_)
      if _ARG_0_:isShadowSpeed() == 1 then
        _ARG_0_:GotoState("Shadowmove_end")
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end
    end
  },
  Shadowmove_end = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, 1)
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 360)
      _ARG_0_.ShadowFlag = _UPVALUE1_
    end,
    OnEndState = function(_ARG_0_)
      Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
      Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
      Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
      _ARG_0_.step = 0
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.ShadowFlag = _UPVALUE0_
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Uneasiness = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Move")
      end
    end
  },
  Standby = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Enemy.IsAllEnemyWaiting() == false then
        _ARG_0_:GotoState("Idling")
      end
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
function m01ex00.HomingPlayer_Move(_ARG_0_)
  Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
  FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _UPVALUE0_)
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function m01ex00.Escape_Move(_ARG_0_)
  _ARG_0_:Rotation()
  FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _UPVALUE0_)
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function m01ex00.Move(_ARG_0_)
  Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.TargetVec, _ARG_0_.Angle)
  FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _UPVALUE0_)
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function m01ex00.Move_Shadow(_ARG_0_)
  _ARG_0_.Shadow_Speed = _ARG_0_.Shadow_Speed + _UPVALUE0_ * 0.1
  if _ARG_0_.Shadow_Speed > _UPVALUE0_ then
    _ARG_0_.Shadow_Speed = _UPVALUE0_
  end
  Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.TargetVec, _ARG_0_.Angle)
  FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Shadow_Speed)
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function m01ex00.ShadowMove(_ARG_0_)
  _ARG_0_.Shadow_Speed = _ARG_0_.Shadow_Speed + _UPVALUE0_ * 0.1
  if _ARG_0_.Shadow_Speed > _UPVALUE0_ then
    _ARG_0_.Shadow_Speed = _UPVALUE0_
  end
  if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > 1 then
    Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, _ARG_0_.Homing_Power)
  else
  end
  FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Shadow_Speed)
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function m01ex00.ShadowMove_SinCurve(_ARG_0_)
  _ARG_0_.Shadow_Speed = _ARG_0_.Shadow_Speed + _UPVALUE0_ * 0.1
  if _ARG_0_.Shadow_Speed > _UPVALUE0_ then
    _ARG_0_.Shadow_Speed = _UPVALUE0_
  end
  if _ARG_0_.Homing_Flag == 1 then
    Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
    _ARG_0_.angle = FVECTOR3.gety(_ARG_0_.rot)
    _ARG_0_.WorkVec1:set(0, Math.Sin(_ARG_0_.SinTimer * _ARG_0_.SinCurve_Power) + Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle), 0)
    Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.WorkVec1)
  end
  FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Shadow_Speed)
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
  _ARG_0_.SinTimer = _ARG_0_.SinTimer - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
end
function m01ex00.init_ShadowMove_SinCurve(_ARG_0_)
  _ARG_0_.SinTimer = Script.Random() * 360
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  _ARG_0_.angle = FVECTOR3.gety(_ARG_0_.rot)
  _ARG_0_.Angle = Math.Sin(_ARG_0_.SinTimer * _ARG_0_.SinCurve_Power) + Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle)
end
function m01ex00.ShadowMove_Escape(_ARG_0_)
  _ARG_0_.Shadow_Speed = _ARG_0_.Shadow_Speed + _UPVALUE0_ * 0.1
  if _ARG_0_.Shadow_Speed > _UPVALUE0_ then
    _ARG_0_.Shadow_Speed = _UPVALUE0_
  end
  _ARG_0_:Rotation()
  FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Shadow_Speed)
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function m01ex00.ShadowMove_Turn(_ARG_0_)
  _ARG_0_.Shadow_Speed = _ARG_0_.Shadow_Speed + _UPVALUE0_ * 0.1
  if _ARG_0_.Shadow_Speed > _UPVALUE0_ then
    _ARG_0_.Shadow_Speed = _UPVALUE0_
  end
  if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > 1 then
    Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, _ARG_0_.Homing_Power)
  else
  end
  FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Shadow_Speed)
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function m01ex00.ShadowStop(_ARG_0_)
  _ARG_0_.Shadow_Speed = _ARG_0_.Shadow_Speed - _UPVALUE0_ * 0.05 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_0_.Shadow_Speed < 0 then
    _ARG_0_.Shadow_Speed = 0
  end
  FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Shadow_Speed)
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function m01ex00.Rotation(_ARG_0_)
  _ARG_0_.angle = HomingDegree(_ARG_0_.angle, _ARG_0_.Angle, _ARG_0_.Rot_Angle, (Entity.GetFrameRate(_ARG_0_.myHandle)))
  _ARG_0_.WorkVec:set(0, _ARG_0_.angle, 0)
  Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function m01ex00.isShadowSpeed(_ARG_0_)
  if _ARG_0_.Shadow_Speed <= 0 then
    return 1
  end
  return 0
end
function m01ex00.Shadow_Move_Z(_ARG_0_)
  _ARG_0_:ShadowMove()
end
function m01ex00.setAngle(_ARG_0_, _ARG_1_)
  _ARG_0_.rot:sety((Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle)))
  _ARG_0_.angle = FVECTOR3.gety(_ARG_0_.rot)
  _ARG_0_.rot:sety(_ARG_0_.angle + DegToRad(_ARG_1_))
  _ARG_0_.Angle = FVECTOR3.gety(_ARG_0_.rot)
end
function m01ex00.initStroll(_ARG_0_, _ARG_1_)
  _ARG_0_.Homing_Power = 2.8 + Script.Random()
  _ARG_0_.Homing_Flag = 1
  _ARG_0_.Rot_Angle = 20
  _ARG_0_:setAngle(Script.Random() * 180)
  _ARG_0_.Shadow_Timer = _ARG_1_ + Script.Random() * 10 + 30
  _ARG_0_.Shadow_MoveTipe = _UPVALUE0_
  _ARG_0_.Movetime = _ARG_1_ + Script.Random() * 10 + 30
  _ARG_0_.MoveType = _UPVALUE0_
  _ARG_0_.TargetVec:set(Script.Random() * 8 * 2 - 8, 0, 8)
  Entity.GetWorldPos2(_ARG_0_.TargetVec, _ARG_0_.myHandle, _ARG_0_.TargetVec)
  _ARG_0_.Angle = 3
  _ARG_0_.StrollCnt = Script.Random() * 1 + 1
end
function m01ex00.OnDead(_ARG_0_)
  _ARG_0_.ShadowFlag = _UPVALUE0_
end
function m01ex00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.targetHandle = NULL_HANDLE
  _ARG_0_.step = 0
  _ARG_0_.Movetime = 0
  _ARG_0_.angle = 0
  _ARG_0_.Angle = 0
  _ARG_0_.Rot_Angle = 0
  _ARG_0_.MoveType = 0
  _ARG_0_.Wait = 0
  _ARG_0_.StrollCnt = 0
  _ARG_0_.StrollTime = 0
  _ARG_0_.count = 0
  _ARG_0_.noWallHitTime = 0
  _ARG_0_.AttackCnt = 0
  _ARG_0_.Shadow_Cnt = 0
  _ARG_0_.Shadow_Timer = 0
  _ARG_0_.Shadow_Speed = 0
  _ARG_0_.ShadowFlag = 0
  _ARG_0_.Homing_Power = 0
  _ARG_0_.SinCurve_Power = 0
  _ARG_0_.SinTimer = 0
  _ARG_0_.Shadow_MoveTipe = 0
  _ARG_0_.Homing_Flag = 0
  _ARG_0_.ShadoHandle = NULL_HANDLE
  _ARG_0_.WorkVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.TargetVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.TargetVec2 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkVec1 = FVECTOR3.new(0, 0, 0)
  Entity.EnableGravity(_ARG_0_.myHandle, 1)
  if Enemy.IsAllEnemyWaiting() == true then
    _ARG_0_:GotoState("Standby")
  else
    _ARG_0_:GotoState("Appear")
  end
end
function m01ex00.IsShadow(_ARG_0_, _ARG_1_)
  return _ARG_0_.ShadowFlag
end
function m01ex00.SetNumber(_ARG_0_, _ARG_1_)
  _ARG_0_.ShadoHandle = _ARG_1_
end
function m01ex00.GetNumber(_ARG_0_)
  return _ARG_0_.Shadow_Speed * 100000
end
function m01ex00.Debug(_ARG_0_)
  if Script.IsDebugCheckAttack() then
    for _FORV_5_, _FORV_6_ in pairs(_UPVALUE0_) do
      if _FORV_6_ == _ARG_0_:GetState() then
        return
      end
    end
    if Script.GetDebugAttackNumber() == 0 then
      _ARG_0_:GotoState("Attack1")
    elseif Script.GetDebugAttackNumber() == 1 then
      _ARG_0_:GotoState("Attack2")
    elseif Script.GetDebugAttackNumber() == 2 then
      _ARG_0_:GotoState("Attack3")
    end
  end
end
function m01ex00.ChangeState(_ARG_0_, _ARG_1_)
  if _ARG_1_ == "Shadowchange" or _ARG_1_ == "Shadowmove_Rotationt" or _ARG_1_ == "Shadowmove_end" or _ARG_1_ == "Shadowmove" then
    return -1
  end
  _ARG_0_:GotoState(_ARG_1_)
end
function m01ex00.OnReturnDamage(_ARG_0_)
  _ARG_0_:GotoState("Idling")
end
function m01ex00.OnUpdate(_ARG_0_)
  _ARG_0_:Update()
  _ARG_0_:Debug()
end
EntityFactory:Add("m01ex00", function(_ARG_0_)
  return (m01ex00:new())
end)
EntityFactory:Add("m01vs00", function(_ARG_0_)
  return (m01ex00:new())
end)
