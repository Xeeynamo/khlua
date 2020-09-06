WorkVec = FVECTOR3.new(0, 0, 0)
WorkVec1 = FVECTOR3.new(0, 0, 0)
workVec = FVECTOR3.new(0, 0, 0)
workVec1 = FVECTOR3.new(0, 0, 0)
TagetPos = FVECTOR3.new(0, 0, 0)
B01RG_CENTER_POS = {
  x = 0.8,
  y = 0.008,
  z = -2.67
}
B05RG_INIT_PARAM = false
setmetatable({
  new = function(_ARG_0_)
    print("b05rg00:new()\n")
    return setmetatable(__StateMachine:new(), _UPVALUE0_)
  end,
  states = {
    Appear = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:GotoState("Transform_Idling")
      end
    },
    Idling = {
      OnBeginState = function(_ARG_0_)
        print("b05rg00:Idling\n")
        Entity.SetTimer(_ARG_0_.myHandle, 80)
        _ARG_0_:SetMotion(_UPVALUE0_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
          return
        end
      end
    },
    Fixed_position = {
      OnBeginState = function(_ARG_0_)
        print("b05rg00:Fixed_position\n")
        _ARG_0_:SetMotion(_UPVALUE0_)
        _ARG_0_.step = 0
        _ARG_0_.targetPos:set(0, 0, 0)
        if B01RG_PARTS_ALIVE == B01RG_ALIVE_ALL then
          _ARG_0_.targetPos:set(TRINYTIY_SETPOS[2].x, 0, TRINYTIY_SETPOS[2].z)
        elseif B01RG_PARTS_ALIVE == B01RG_ALIVE_NO_BETA then
          _ARG_0_.targetPos:set(TRINYTIY_SETPOS[4].x, 0, TRINYTIY_SETPOS[4].z)
        elseif B01RG_PARTS_ALIVE == B01RG_ALIVE_NO_BETA_OR_GANMA then
          _ARG_0_.targetPos:set(TRINYTIY_SETPOS[2].x, 0, TRINYTIY_SETPOS[2].z)
        end
        _ARG_0_.changeFlagOn = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          _ARG_0_.step = 1
          Entity.SetTimer(_ARG_0_.myHandle, 300)
        elseif _ARG_0_.step == 1 then
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) < 25 then
            WorkVec:set(0, 0, _UPVALUE0_ / ((Entity.CalcDistance(_ARG_0_.myHandle, _ARG_0_.targetPos) + 0.001) / 5))
            Entity.CalcVelocityXZ(_ARG_0_.myHandle, WorkVec)
          else
            WorkVec:set(0, 0, _UPVALUE0_)
            Entity.CalcVelocityXZ(_ARG_0_.myHandle, WorkVec)
          end
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 30)
          if 1 > Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) or Entity.IsTimeOver(_ARG_0_.myHandle) then
            print("\131\193: \146\232\136\202\146u\130\201\130\194\130\162\130\189\n")
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_:SetMotion(_UPVALUE1_)
            _ARG_0_.step = 2
            _ARG_0_.changeFlagOn = 1
          end
        elseif _ARG_0_.step == 2 then
          _ARG_0_.changeFlagOn = 1
          _ARG_0_.targetPos:set(B01RG_CENTER_POS.x, 0, B01RG_CENTER_POS.z)
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) < 81 then
            WorkVec:set(0, 0, -_UPVALUE0_)
            Entity.CalcVelocityXZ(_ARG_0_.myHandle, WorkVec)
          elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) > 90.25 then
            WorkVec:set(0, 0, _UPVALUE0_)
            Entity.CalcVelocityXZ(_ARG_0_.myHandle, WorkVec)
          else
            Entity.ClearSpeed(_ARG_0_.myHandle)
          end
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 30)
        end
      end
    },
    Move = {
      OnBeginState = function(_ARG_0_)
        print("b05rg00:Move\n")
        Entity.SetTimer(_ARG_0_.myHandle, 80)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
          return
        end
      end
    },
    AttackIdling = {
      OnBeginState = function(_ARG_0_)
        print("b05rg00:AttackIdling\n")
        Entity.SetTimer(_ARG_0_.myHandle, 180)
        _ARG_0_:SetMotion(_UPVALUE0_)
        _ARG_0_.step = 0
        _ARG_0_.count = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          _ARG_0_.targetPos:set(B01RG_CENTER_POS.x, 0, B01RG_CENTER_POS.z)
          _ARG_0_.targetPos:setx(_ARG_0_.targetPos:getx() + (9 * Script.Random() + 4) * Math.Cos((RoundPI(Script.Random() * 2 * PI))))
          _ARG_0_.targetPos:setz(_ARG_0_.targetPos:getz() + (9 * Script.Random() + 4) * Math.Sin((RoundPI(Script.Random() * 2 * PI))))
          _ARG_0_.step = 1
          Entity.SetTimer(_ARG_0_.myHandle, 60)
          _ARG_0_.changeCount = Script.Random() * 10 + 2
        elseif _ARG_0_.step == 1 then
          WorkVec:set(0, 0, _UPVALUE0_)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, WorkVec)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 3)
          WorkVec:set(B01RG_CENTER_POS.x, 0, B01RG_CENTER_POS.z)
          if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, WorkVec) < 25 then
            if _ARG_0_:WhichRightandLeft() == 1 then
              _ARG_0_.wanderAng = -10
            else
              _ARG_0_.wanderAng = 10
            end
            Entity.GetRot(WorkVec, _ARG_0_.myHandle)
            WorkVec:sety(WorkVec:gety() + DegToRad(_ARG_0_.wanderAng))
            Entity.SetRot(_ARG_0_.myHandle, WorkVec)
          end
          if Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.IsWall(_ARG_0_.myHandle) or 4 > Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetPos) then
            _ARG_0_.count = _ARG_0_.count + 1
            if _ARG_0_.count > _ARG_0_.changeCount then
              WorkVec:set(B01RG_CENTER_POS.x, 0, B01RG_CENTER_POS.z)
              if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, WorkVec) < 25 then
              else
                _ARG_0_:SetMotion(_UPVALUE1_)
                _ARG_0_.step = 2
                Entity.SetTimer(_ARG_0_.myHandle, (Script.Random() * 8 + 2) * 60)
                Entity.ClearSpeed(_ARG_0_.myHandle)
              end
            else
              _ARG_0_.step = 0
            end
          end
        elseif _ARG_0_.step == 2 and Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:SetMotion(_UPVALUE2_)
          _ARG_0_.step = 0
          _ARG_0_.count = 0
        end
      end
    },
    Transform_SetupPosMove = {
      OnBeginState = function(_ARG_0_)
        print("b05rg00:Transform_SetupPosMove\n")
        _ARG_0_:SetMotion(_UPVALUE0_)
        _ARG_0_.changeFlagOn = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) < 25 then
          WorkVec:set(0, 0, _UPVALUE0_ / ((Entity.CalcDistance(_ARG_0_.myHandle, _ARG_0_.targetPos) + 0.001) / 5))
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, WorkVec)
        else
          WorkVec:set(0, 0, _UPVALUE0_)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, WorkVec)
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 30)
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) < 4 then
          Entity.SetLocalPos(_ARG_0_.myHandle, _ARG_0_.targetPos)
          _ARG_0_:GotoState("Transform_SetupPosMove_Idling")
        end
      end
    },
    Transform_SetupPosMove_Idling = {
      OnBeginState = function(_ARG_0_)
        print("b05rg00:Transform_SetupPosMove_Idling\n")
        _ARG_0_:SetMotion(_UPVALUE0_)
        Entity.GetRot(WorkVec, B01RG_HANDLE_HEAD)
        Entity.SetRot(_ARG_0_.myHandle, WorkVec)
        Entity.SetRot(B08RG_HANDLE_ROBOT_FOOT, WorkVec)
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.changeFlagOn = 1
      end
    },
    Reflect_slash = {
      OnBeginState = function(_ARG_0_)
        print("b05rg00:Reflect_slash\n")
        Entity.SetTimer(_ARG_0_.myHandle, 2000)
        _ARG_0_:SetMotion(_UPVALUE0_)
        B05RG_MODE = B01RG_NOMAL_MODE
        _ARG_0_.step = _UPVALUE1_
        changeSet(_ARG_0_, _ARG_0_.myHandle, 1)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.GetVelocity(WorkVec, _ARG_0_.myHandle)
        if _ARG_0_.step == _UPVALUE0_ then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.GetWorldPos(WorkVec1, _ARG_0_.myHandle)
            Entity.GetWorldPos(WorkVec, _ARG_0_.targetHandle)
            FVECTOR3.Sub(WorkVec, WorkVec, WorkVec1)
            WorkVec:sety(0)
            WorkVec:normalize()
            WorkVec:scale(_UPVALUE1_)
            Entity.SetVelocity(_ARG_0_.myHandle, WorkVec)
            _ARG_0_.step = _UPVALUE2_
          end
        elseif _ARG_0_.step == _UPVALUE2_ then
          if Entity.IsWall(_ARG_0_.myHandle) then
            Entity.GetWallNormal(workVec, _ARG_0_.myHandle)
            WorkVec1:set(-WorkVec:dot(workVec) * (1 + COEFFICIENT) * workVec:getx(), -WorkVec:dot(workVec) * (1 + COEFFICIENT) * workVec:gety(), -WorkVec:dot(workVec) * (1 + COEFFICIENT) * workVec:getz())
            FVECTOR3.Add(WorkVec, WorkVec, WorkVec1)
            WorkVec:sety(0)
          end
          WorkVec:normalize()
          WorkVec:scale(WorkVec:length() * Math.Pow(0.99, Entity.GetFrameRate(_ARG_0_.myHandle)) - _UPVALUE3_ * Entity.GetFrameRate(_ARG_0_.myHandle))
          Entity.SetVelocity(_ARG_0_.myHandle, WorkVec)
          if WorkVec:length() * Math.Pow(0.99, Entity.GetFrameRate(_ARG_0_.myHandle)) - _UPVALUE3_ * Entity.GetFrameRate(_ARG_0_.myHandle) < 0.05 then
            _ARG_0_:GotoState("Reflect_slash_End")
          end
        elseif _ARG_0_.step == _UPVALUE4_ then
        end
      end
    },
    Reflect_slash_End = {
      OnBeginState = function(_ARG_0_)
        print("b05rg00:Reflect_slash_End\n")
        _ARG_0_.step = _UPVALUE0_
        _ARG_0_:SetMotion(_UPVALUE1_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    TriangleLaser = {
      OnBeginState = function(_ARG_0_)
        print("b05rg00:TriangleLaser\n")
        _ARG_0_.step = B01RG_TRIANGLELASER_SETUPPOSMOVE
        _ARG_0_.changeFlagOn = 0
        _ARG_0_:SetMotion(_UPVALUE0_)
        _ARG_0_.targetPos:set(0, 0, 0)
        if B01RG_PARTS_ALIVE == B01RG_ALIVE_ALL then
          _ARG_0_.targetPos:set(TRINYTIY_SETPOS[2].x, 0, TRINYTIY_SETPOS[2].z)
        elseif B01RG_PARTS_ALIVE == B01RG_ALIVE_NO_BETA then
          _ARG_0_.targetPos:set(TRINYTIY_SETPOS[4].x, 0, TRINYTIY_SETPOS[4].z)
        end
        Entity.SetTimer(_ARG_0_.myHandle, Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetPos) / _UPVALUE1_ + 100)
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Effect.LoopEnd(_ARG_0_.LightHandle)
        _ARG_0_.LightHandle = NULL_HANDLE
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == B01RG_TRIANGLELASER_SETUPPOSMOVE then
          WorkVec:set(0, 0, _UPVALUE0_)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, WorkVec)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 5)
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) < 1 or Entity.IsTimeOver(_ARG_0_.myHandle) then
            print("\131\193: \146\232\136\202\146u\130\201\130\194\130\162\130\189\n")
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Entity.SetTimer(_ARG_0_.myHandle, 200)
            _ARG_0_:SetMotion(_UPVALUE1_)
            _ARG_0_.step = B01RG_TRIANGLELASER_SETUPPOSINDLING
          end
        elseif _ARG_0_.step == B01RG_TRIANGLELASER_SETUPPOSINDLING then
          _ARG_0_.changeFlagOn = 1
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, TagetPos, 30)
        elseif _ARG_0_.step == B01RG_TRIANGLELASER_SHOOT then
          if 30 < Entity.GetMotionNowFrame(_ARG_0_.myHandle) then
            WorkVec:set(0, 2, 2.8)
            WorkVec1:set(0, 0, 0)
            if B01RG_PARTS_ALIVE == B01RG_ALIVE_ALL then
              _ARG_0_.LightHandle = Entity.SetEffect(_ARG_0_.myHandle, "b01rg00", "B024_TRY_LSR0_0", WorkVec, WorkVec1)
              Enemy.SetGeneralPurposeAttackColl(_ARG_0_.myHandle, COLL_KIND_ENEMY, COLL_SHAPE_CYLINDER, B01RG_TRIANGLELASER_ATTACK_SIZE)
              Enemy.SetGeneralPurposeAttackCollParam(_ARG_0_.myHandle, Enemy.GetAttackKind(_ARG_0_.myHandle, 8), Enemy.GetAttackAttr(_ARG_0_.myHandle, 8), Enemy.GetAttackPoint(_ARG_0_.myHandle, 8), Enemy.GetAttackPowerCorrection(_ARG_0_.myHandle, 8))
              Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 0)
              Enemy.SetGeneralPurposeAttackCollHitAttackEffectName(_ARG_0_.myHandle, "b01rg00", "B024_HIT_SPK0_0")
              Effect.SetAttachNoRot(_ARG_0_.LightHandle, false)
            end
            _ARG_0_.step = B01RG_TRIANGLELASER_ATTACK1
          end
        elseif _ARG_0_.step == B01RG_TRIANGLELASER_ATTACK1 then
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, TagetPos) < B01RG_TRIANGLELASER_RADIUS then
          else
            if Entity.CalcDistanceSq(_ARG_0_.myHandle, TagetPos) > B01RG_TRIANGLELASER_RADIUS2 then
            else
            end
          end
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, TagetPos, 180)
          WorkVec:set(B01RG_TRIANGLELASER_ATTACK_ROTATION, 0, _UPVALUE2_)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, WorkVec)
        elseif _ARG_0_.step == B01RG_TRIANGLELASER_ATTACK2 then
          Entity.ClearSpeed(_ARG_0_.myHandle)
        elseif _ARG_0_.step == B01RG_TRIANGLELASER_ATTACK3 then
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, TagetPos) < B01RG_TRIANGLELASER_RADIUS then
          else
            if Entity.CalcDistanceSq(_ARG_0_.myHandle, TagetPos) > B01RG_TRIANGLELASER_RADIUS2 then
            else
            end
          end
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, TagetPos, 180)
          WorkVec:set(-B01RG_TRIANGLELASER_ATTACK_ROTATION, 0, _UPVALUE2_)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, WorkVec)
        elseif _ARG_0_.step == B01RG_TRIANGLELASER_ATTACK_END then
          Effect.LoopEnd(_ARG_0_.LightHandle)
          _ARG_0_.LightHandle = NULL_HANDLE
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        end
        if B01RG_PARTS_ALIVE == B01RG_ALIVE_ALL and Effect.IsAlive(_ARG_0_.LightHandle) then
          WorkVec1:set(0, 2, 2.8)
          Entity.GetWorldPos2(WorkVec, _ARG_0_.myHandle, WorkVec1)
          WorkVec1:set(0, 2, 2.8)
          Entity.GetWorldPos2(WorkVec1, B01RG_HANDLE_HEAD, WorkVec1)
          FVECTOR3.Sub(workVec, WorkVec1, WorkVec)
          FVECTOR3.normalize(workVec)
          workVec1:set(0, 0, 0)
          workVec1:setx(DegToRad(90))
          workVec1:sety((Math.Atan2(workVec:getx(), workVec:getz())))
          Effect.UpdateCoord(_ARG_0_.LightHandle, WorkVec, workVec1)
          WorkVec1:set(0, 2, 2.8)
          Entity.GetWorldPos2(WorkVec, _ARG_0_.myHandle, WorkVec1)
          WorkVec1:set(0, 2, 2.8)
          Entity.GetWorldPos2(WorkVec1, B01RG_HANDLE_HEAD, WorkVec1)
          Enemy.SetGeneralPurposeAttackCollPos(_ARG_0_.myHandle, WorkVec1, WorkVec)
          FVECTOR3.Sub(workVec1, WorkVec1, WorkVec)
          workVec:set(1, workVec1:length() / 1, 1)
          Effect.SetScale(_ARG_0_.LightHandle, workVec)
          Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 1)
          if 0 > _ARG_0_.Wait then
            Enemy.EnableGeneralPurposeUpdate(_ARG_0_.myHandle)
            _ARG_0_.Wait = B01RG_TRIANGLELASER_ATTACK_UPDATE
          end
          _ARG_0_.Wait = _ARG_0_.Wait - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        end
      end
    },
    TramplingAttack = {
      OnBeginState = function(_ARG_0_)
        print("b05rg00:TramplingAttack\n")
        _ARG_0_.step = 0
        _ARG_0_:SetMotion(_UPVALUE0_)
        _ARG_0_.EndFlag = 0
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.targetPos:set(B01RG_CENTER_POS.x, 0, B01RG_CENTER_POS.z)
        if _ARG_0_.step == 0 then
          WorkVec:set(0, 0, _UPVALUE0_)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, WorkVec)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 180)
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) < 4 then
            _ARG_0_:SetMotion(_UPVALUE1_)
            _ARG_0_.step = 1
            Entity.ClearSpeed(_ARG_0_.myHandle)
          end
        elseif _ARG_0_.step == 1 then
          FVECTOR3.set(WorkVec, 0, 0, _UPVALUE2_)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, WorkVec)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 15)
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE3_ or Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 35 then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
            _ARG_0_.EndFlag = 1
          end
        elseif _ARG_0_.step == 3 then
        end
      end
    },
    BoltecShoot = {
      OnBeginState = function(_ARG_0_)
        print("b05rg00:BoltecShoot\n")
        _ARG_0_.step = 0
        _ARG_0_:SetMotion(_UPVALUE0_)
        _ARG_0_.EndFlag = 0
        _ARG_0_.AttackCnt = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.targetPos:set(B01RG_CENTER_POS.x, 0, B01RG_CENTER_POS.z)
        if _ARG_0_.step == 0 then
          WorkVec:set(0, 0, _UPVALUE0_)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, WorkVec)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 180)
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) < 4 then
            _ARG_0_.step = 1
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_:SetMotion(_UPVALUE1_)
          end
        elseif _ARG_0_.step == 1 then
          _ARG_0_.step = 2
        elseif _ARG_0_.step == 2 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 16 then
            _ARG_0_.BoltecHandle[_ARG_0_.AttackCnt] = _ARG_0_:CreateBoltecBullet(_ARG_0_.myHandle)
            _ARG_0_.AttackCnt = _ARG_0_.AttackCnt + 1
            _ARG_0_.step = 3
          end
        elseif _ARG_0_.step == 3 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            if _ARG_0_.AttackCnt >= 3 then
              _ARG_0_:SetMotion(_UPVALUE2_)
              _ARG_0_.EndFlag = 1
              _ARG_0_.step = 4
            else
              _ARG_0_:SetMotionNomal(_UPVALUE1_)
              _ARG_0_.step = 1
            end
          end
        elseif _ARG_0_.step == 4 and Effect.IsAlive(_ARG_0_.BoltecHandle[0]) == false and Effect.IsAlive(_ARG_0_.BoltecHandle[1]) == false and Effect.IsAlive(_ARG_0_.BoltecHandle[2]) == false then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Transform_Idling = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_.step = 0
        print("b05rg00:Transform_Idling\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 1 then
          PartsAttack(_ARG_0_.myHandle)
        end
      end
    },
    Transform_Start = {
      OnBeginState = function(_ARG_0_)
        print("b05rg00:Transform_Start\n")
        TRINITY_TRANSFORM_STEP = TRINITY_TRANSFORM_START
        _ARG_0_.step = TRINITY_TRANSFORM_START
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        WorkVec:set(0, 0, 0)
        if _ARG_0_.step == TRINITY_TRANSFORM_START then
          _ARG_0_:SetMotion(_UPVALUE0_)
          _ARG_0_.step = TRINITY_TRANSFORM_CHANGE
          Entity.GetWorldPos(WorkVec, _ARG_0_.myHandle)
          Entity.SetLocalPos(B08RG_HANDLE_ROBOT_FOOT, WorkVec)
        elseif _ARG_0_.step == TRINITY_TRANSFORM_CHANGE and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          if Entity.IsAlive(B08RG_HANDLE_ROBOT_FOOT) then
            Entity.GetWorldPos(WorkVec, _ARG_0_.myHandle)
            Entity.SetLocalPos(B08RG_HANDLE_ROBOT_FOOT, WorkVec)
            Entity.GetRot(WorkVec, _ARG_0_.myHandle)
            Entity.SetRot(B08RG_HANDLE_ROBOT_FOOT, WorkVec)
            EntityManager:GetEntity(B08RG_HANDLE_ROBOT_FOOT):GotoState("Transform_Start")
          end
          _ARG_0_:GotoState("Transform_Idling")
        end
      end
    },
    Transform_Out = {
      OnBeginState = function(_ARG_0_)
        print("b05rg00:Transform_Out\n")
        TRINITY_TRANSFORM_STEP = TRINITY_TRANSFORM_OUT
        _ARG_0_.step = TRINITY_TRANSFORM_OUT
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        WorkVec:set(0, 0, 0)
        if _ARG_0_.step == TRINITY_TRANSFORM_OUT then
          _ARG_0_:SetMotion(_UPVALUE0_)
          _ARG_0_.step = TRINITY_TRANSFORM_CHANGE
        elseif _ARG_0_.step == TRINITY_TRANSFORM_CHANGE and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    Standby = {
      OnBeginState = function(_ARG_0_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Enemy.IsAllEnemyWaiting() == false then
          _ARG_0_:GotoState("Transform_Idling")
        end
      end
    },
    Dead = {
      OnBeginState = function(_ARG_0_)
        print("b05rg00:Dead\n")
        Effect.LoopEnd(_ARG_0_.LightHandle)
        _ARG_0_.LightHandle = NULL_HANDLE
        if Enemy.IsAttackerFront(_ARG_0_.myHandle) == true then
          _ARG_0_:SetMotion(_UPVALUE0_)
          _ARG_0_.step = 0
        else
          _ARG_0_:SetMotion(_UPVALUE1_)
          _ARG_0_.step = 2
        end
        B05RG_HANDLE_NOMAL_FOOT = NULL_HANDLE
        Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
        Entity.EnableLockon(_ARG_0_.myHandle, 0)
        Entity.EnableShooton(_ARG_0_.myHandle, 0)
        if B01RG_MODE == B01RG_NOMAL_MODE then
          Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 60)
        end
        B05RG_HANDLE_NOMAL_FOOT = NULL_HANDLE
        if Entity.IsAlive(B08RG_HANDLE_ROBOT_FOOT) then
          larm = EntityManager:GetEntity(B08RG_HANDLE_ROBOT_FOOT)
          if larm:GetState() ~= "Dead" then
            larm:GotoState("Dead")
          end
        end
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Enemy.Dead(_ARG_0_.myHandle)
          end
        elseif _ARG_0_.step == 1 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          end
        elseif _ARG_0_.step == 2 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Enemy.Dead(_ARG_0_.myHandle)
          end
        elseif _ARG_0_.step ~= 3 or Entity.IsMotionEnd(_ARG_0_.myHandle) then
        end
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
  },
  SetMotion = function(_ARG_0_, _ARG_1_)
    Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_1_)
  end,
  SetMotionNomal = function(_ARG_0_, _ARG_1_)
    Entity.SetMotion(_ARG_0_.myHandle, _ARG_1_)
  end,
  WhichRightandLeft = function(_ARG_0_)
    Entity.GetWorldPos(WorkVec1, _ARG_0_.myHandle)
    Entity.GetRot(workVec1, _ARG_0_.myHandle)
    FVECTOR3.Sub(workVec, _ARG_0_.targetPos, WorkVec1)
    FVECTOR3.normalize(workVec)
    if RoundPI((Math.Atan2(workVec:getx(), workVec:getz()) - workVec1:gety()) * -1) < DegToRad(1) and RoundPI((Math.Atan2(workVec:getx(), workVec:getz()) - workVec1:gety()) * -1) > DegToRad(-1) then
      return 2
    elseif RoundPI((Math.Atan2(workVec:getx(), workVec:getz()) - workVec1:gety()) * -1) < 0 then
      return 1
    else
      return 0
    end
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    print("b05rg00:: OnInit\n")
    _ARG_0_.myHandle = _ARG_1_
    B05RG_HANDLE_NOMAL_FOOT = _ARG_1_
    _ARG_0_.step = 0
    _ARG_0_.targetHandle = NULL_HANDLE
    _ARG_0_.LightHandle = NULL_HANDLE
    _ARG_0_.BoltecHandle = {}
    _ARG_0_.BoltecHandle[0] = NULL_HANDLE
    _ARG_0_.BoltecHandle[1] = NULL_HANDLE
    _ARG_0_.BoltecHandle[2] = NULL_HANDLE
    _ARG_0_.changeFlagOn = 0
    _ARG_0_.WorkTime = 0
    _ARG_0_.AttackCnt = 0
    _ARG_0_.EndFlag = 0
    _ARG_0_.Wait = 0
    _ARG_0_.changeCount = 0
    _ARG_0_.isDead = 0
    _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.lockonPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.cameraPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.count = 0
    _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
    if B05RG_INIT_PARAM == false then
      _UPVALUE0_ = Enemy.GetExtraParam(_ARG_1_, "IdlingT") * 60
      print("B05RG_TIME_IDLING = " .. _UPVALUE0_ .. "\n")
      B05RG_INIT_PARAM = true
    end
    _ARG_0_.stack = Stack:Create()
    Entity.SetMovementCollRadius(_ARG_0_.myHandle, 1.7)
    Entity.SetLowerHalf(_ARG_0_.myHandle, 2)
    Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
    Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
    Entity.EnableLockon(_ARG_0_.myHandle, 0)
    Entity.EnableGravity(_ARG_0_.myHandle, 1)
    Player.SetBossCamera("b05rg00")
    Enemy.IsAllEnemyWaiting()
    Entity.SetDropShadowDistance(_ARG_0_.myHandle, 80)
    Entity.SetDrawParentShadow(_ARG_0_.myHandle, B01RG_HANDLE_HEAD)
    if Enemy.IsAllEnemyWaiting() == true then
      _ARG_0_:GotoState("Standby")
    else
      _ARG_0_:GotoState("Appear")
      Entity.EnableLockon(_ARG_0_.myHandle, 1)
    end
    Entity.SetAlpha(_ARG_1_, 0)
    Entity.EnableDamageColl(_ARG_1_, 0)
    Entity.EnableBodyColl(_ARG_1_, 0)
    Entity.EnableLockon(_ARG_1_, 0)
    Entity.EnableShooton(_ARG_1_, 0)
  end,
  CreateBoltecBullet = function(_ARG_0_, _ARG_1_)
    WorkVec:set(0, 2.5, 1.5)
    Entity.GetWorldPos2(WorkVec, _ARG_1_, WorkVec)
    Entity.GetRot(WorkVec1, _ARG_0_.myHandle)
    Bullet.CreateEffectBullet(Bullet.CreateBullet("BoltecShoot", WorkVec, WorkVec1), "b01rg00", "B024_BTS_BLT0_0")
    if Enemy.IsConfuse(_ARG_0_.myHandle) then
      Bullet.SetCollision(Bullet.CreateBullet("BoltecShoot", WorkVec, WorkVec1), COLL_KIND_NO_CHECK, COLL_SHAPE_SPHERE, 0.5, 0, _ARG_1_)
    else
      Bullet.SetCollision(Bullet.CreateBullet("BoltecShoot", WorkVec, WorkVec1), COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, 0.5, 0, _ARG_1_)
    end
    SetBulletAttackParam(Bullet.CreateBullet("BoltecShoot", WorkVec, WorkVec1), _ARG_0_.myHandle, 13)
    Bullet.SetHitAttackEffectName(Bullet.CreateBullet("BoltecShoot", WorkVec, WorkVec1), "b01rg00", "B024_HIT_SPK0_0")
    Bullet.SetHitBgEffectName(Bullet.CreateBullet("BoltecShoot", WorkVec, WorkVec1), "b01rg00", "B024_HIT_SPK1_0")
    WorkVec:set(0, 1, Script.Random() * 1.3 + 0.3)
    Math.RotateVectorXYZ(WorkVec, WorkVec1)
    WorkVec:scale(Script.Random() * 0.3)
    Entity.SetVelocity(Bullet.CreateBullet("BoltecShoot", WorkVec, WorkVec1), WorkVec)
    Bullet.SetMaxMoveDist(Bullet.CreateBullet("BoltecShoot", WorkVec, WorkVec1), 900)
    EntityManager:GetEntity((Bullet.CreateBullet("BoltecShoot", WorkVec, WorkVec1))).targetHandle = _ARG_0_.targetHandle
    return (Bullet.CreateBullet("BoltecShoot", WorkVec, WorkVec1))
  end,
  OnDamage = function(_ARG_0_, _ARG_1_)
    print("b05rg00: OnDamage\n")
    Enemy.SetHP(B08RG_HANDLE_ROBOT_FOOT, (Enemy.GetHp(_ARG_0_.myHandle)))
    return 1
  end,
  OnReturnDamage = function(_ARG_0_)
  end,
  OnHitAttack = function(_ARG_0_)
  end,
  OnDestroy = function(_ARG_0_)
    Effect.LoopEnd(_ARG_0_.BoltecHandle[0])
    Effect.LoopEnd(_ARG_0_.BoltecHandle[1])
    Effect.LoopEnd(_ARG_0_.BoltecHandle[2])
    Effect.LoopEnd(_ARG_0_.LightHandle)
  end,
  OnDead = function(_ARG_0_)
    Effect.LoopEnd(_ARG_0_.BoltecHandle[0])
    Effect.LoopEnd(_ARG_0_.BoltecHandle[1])
    Effect.LoopEnd(_ARG_0_.BoltecHandle[2])
    print("b05rg00: OnDead()\n")
    if Enemy.IsNetworkMaster(_ARG_0_.myHandle) == false then
      _ARG_0_:GotoStateSub("Dead")
    else
      _ARG_0_:GotoState("Dead")
    end
    if Entity.GetAlpha(_ARG_0_.myHandle) > 0.1 then
      Entity.GetWorldPos(WorkVec, _ARG_0_.myHandle, 2)
      Enemy.MakePrize(_ARG_0_.myHandle, WorkVec)
    end
    return 1
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
  end,
  OnUpdate = function(_ARG_0_)
    _ARG_0_:Update()
    if B01RG_MODE == B01RG_NOMAL_MODE then
      _ARG_0_:Debug()
    end
    if Enemy.GetHp(_ARG_0_.myHandle) <= 0 and _ARG_0_.isDead == 0 then
      _ARG_0_:OnDead()
      _ARG_0_.isDead = 1
    end
  end
}, {__index = __StateMachine})
EntityFactory:Add("b05rg00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b75vs00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("BoltecShoot", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
