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
B04RG_INIT_PARAM = false
setmetatable({
  new = function(_ARG_0_)
    print("b04rg00:new()\n")
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
        print("b04rg00:Idling\n")
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
        print("b04rg00:Fixed_position\n")
        _ARG_0_:SetMotion(_UPVALUE0_)
        _ARG_0_.step = 0
        _ARG_0_.targetPos:set(0, 0, 0)
        if B01RG_PARTS_ALIVE == B01RG_ALIVE_ALL then
          _ARG_0_.targetPos:set(TRINYTIY_SETPOS[1].x, 0, TRINYTIY_SETPOS[1].z)
        elseif B01RG_PARTS_ALIVE == B01RG_ALIVE_NO_GANMA then
          _ARG_0_.targetPos:set(TRINYTIY_SETPOS[4].x, 0, TRINYTIY_SETPOS[4].z)
        elseif B01RG_PARTS_ALIVE == B01RG_ALIVE_NO_BETA_OR_GANMA then
          _ARG_0_.targetPos:set(TRINYTIY_SETPOS[1].x, 0, TRINYTIY_SETPOS[1].z)
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
            print("\131\192: \146\232\136\202\146u\130\201\130\194\130\162\130\189\n")
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
    AttackIdling = {
      OnBeginState = function(_ARG_0_)
        print("b04rg00:AttackIdling\n")
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
        print("b04rg00:Transform_SetupPosMove\n")
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
        print("b04rg00:Transform_SetupPosMove_Idling\n")
        _ARG_0_:SetMotion(_UPVALUE0_)
        Entity.GetRot(WorkVec, B01RG_HANDLE_HEAD)
        Entity.SetRot(_ARG_0_.myHandle, WorkVec)
        Entity.SetRot(B06RG_HANDLE_ROBOT_RIGHTARMe, WorkVec)
        Entity.SetRot(B07RG_HANDLE_ROBOT_LEFTARM, WorkVec)
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
        print("b04rg00:Reflect_slash\n")
        Entity.SetTimer(_ARG_0_.myHandle, 2000)
        _ARG_0_:SetMotion(_UPVALUE0_)
        _ARG_0_.step = _UPVALUE1_
        changeSet(_ARG_0_, _ARG_0_.myHandle, 1)
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.GetVelocity(WorkVec, _ARG_0_.myHandle)
        if _ARG_0_.step == _UPVALUE0_ then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 16 then
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
        print("b04rg00:Reflect_slash_End\n")
        _ARG_0_.step = _UPVALUE0_
        _ARG_0_:SetMotion(_UPVALUE1_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.GetVelocity(WorkVec, _ARG_0_.myHandle)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    TriangleLaser = {
      OnBeginState = function(_ARG_0_)
        print("b04rg00:TriangleLaser\n")
        _ARG_0_.step = B01RG_TRIANGLELASER_SETUPPOSMOVE
        _ARG_0_:SetMotion(_UPVALUE0_)
        _ARG_0_.changeFlagOn = 0
        _ARG_0_.targetPos:set(0, 0, 0)
        if B01RG_PARTS_ALIVE == B01RG_ALIVE_ALL then
          _ARG_0_.targetPos:set(TRINYTIY_SETPOS[1].x, 0, TRINYTIY_SETPOS[1].z)
        elseif B01RG_PARTS_ALIVE == B01RG_ALIVE_NO_GANMA then
          _ARG_0_.targetPos:set(TRINYTIY_SETPOS[4].x, 0, TRINYTIY_SETPOS[4].z)
        elseif B01RG_PARTS_ALIVE == B01RG_ALIVE_NO_BETA_OR_GANMA then
          _ARG_0_.targetPos:set(TRINYTIY_SETPOS[1].x, 0, TRINYTIY_SETPOS[1].z)
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
            print("\131\192: \146\232\136\202\146u\130\201\130\194\130\162\130\189\n")
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Entity.SetTimer(_ARG_0_.myHandle, 200)
            _ARG_0_:SetMotion(_UPVALUE1_)
            _ARG_0_.step = B01RG_TRIANGLELASER_SETUPPOSINDLING
            _ARG_0_.changeFlagOn = 1
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
          Entity.GetWorldPos2(WorkVec1, B05RG_HANDLE_NOMAL_FOOT, WorkVec1)
          FVECTOR3.Sub(workVec, WorkVec1, WorkVec)
          FVECTOR3.normalize(workVec)
          workVec1:set(0, 0, 0)
          workVec1:setx(DegToRad(90))
          workVec1:sety((Math.Atan2(workVec:getx(), workVec:getz())))
          Effect.UpdateCoord(_ARG_0_.LightHandle, WorkVec, workVec1)
          WorkVec1:set(0, 2, 2.8)
          Entity.GetWorldPos2(WorkVec, _ARG_0_.myHandle, WorkVec1)
          WorkVec1:set(0, 2, 2.8)
          Entity.GetWorldPos2(WorkVec1, B05RG_HANDLE_NOMAL_FOOT, WorkVec1)
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
    UltimaImpact = {
      OnBeginState = function(_ARG_0_)
        print("b04rg00:UltimaImpact\n")
        _ARG_0_:SetMotion(_UPVALUE0_)
        _ARG_0_.step = 0
        _ARG_0_.EndFlag = 0
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        Entity.SetTimer(_ARG_0_.myHandle, 300)
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
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) < 0.040000003 or Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetTimer(_ARG_0_.myHandle, 200)
            _ARG_0_:SetMotion(_UPVALUE1_)
            _ARG_0_.step = 1
            Entity.ClearSpeed(_ARG_0_.myHandle)
          end
        elseif _ARG_0_.step == 1 then
          FVECTOR3.set(WorkVec, 0, 0, _UPVALUE2_)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, WorkVec)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 15)
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE3_ or Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_:SetMotion(_UPVALUE4_)
            _ARG_0_.step = 3
          end
        elseif _ARG_0_.step == 2 then
        elseif _ARG_0_.step == 3 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.EndFlag = 1
        end
      end
    },
    SpinningBeam = {
      OnBeginState = function(_ARG_0_)
        print("b04rg00:SpinningBeam\n")
        _ARG_0_:SetMotion(_UPVALUE0_)
        _ARG_0_.step = 0
        _ARG_0_.EndFlag = 0
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        Entity.SetTimer(_ARG_0_.myHandle, 300)
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        _ARG_0_.EndFlag = 1
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.targetPos:set(B01RG_CENTER_POS.x, 0, B01RG_CENTER_POS.z)
        if _ARG_0_.step == 0 then
          WorkVec:set(0, 0, _UPVALUE0_)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, WorkVec)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 180)
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) < 4 or Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
            _ARG_0_:SetMotion(_UPVALUE2_)
            _ARG_0_.step = 1
            Entity.ClearSpeed(_ARG_0_.myHandle)
          end
        elseif _ARG_0_.step == 1 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:SetMotion(_UPVALUE3_)
            _ARG_0_.step = 3
            return
          end
          if 0 > _ARG_0_.Wait then
            _ARG_0_:CreateShot(_ARG_0_.myHandle, 10)
            _ARG_0_.Wait = Script.Random() * 10 + 2
            return
          end
          if 0 > _ARG_0_.Wait1 then
            _ARG_0_:CreateShot(_ARG_0_.myHandle, 14)
            _ARG_0_.Wait1 = Script.Random() * 10 + 2
            return
          end
          if 0 > _ARG_0_.Wait2 then
            _ARG_0_:CreateShot(_ARG_0_.myHandle, 17)
            _ARG_0_.Wait2 = Script.Random() * 10 + 2
            return
          end
          if 0 > _ARG_0_.Wait3 then
            _ARG_0_:CreateShot(_ARG_0_.myHandle, 20)
            _ARG_0_.Wait3 = Script.Random() * 10 + 2
            return
          end
          _ARG_0_.Wait = _ARG_0_.Wait - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
          _ARG_0_.Wait1 = _ARG_0_.Wait1 - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
          _ARG_0_.Wait2 = _ARG_0_.Wait2 - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
          _ARG_0_.Wait3 = _ARG_0_.Wait3 - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        elseif _ARG_0_.step == 2 then
        elseif _ARG_0_.step == 3 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.EndFlag = 1
          _ARG_0_.step = 2
        end
      end
    },
    Move = {
      OnBeginState = function(_ARG_0_)
        print("b04rg00:Move\n")
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
    Transform_Idling = {
      OnBeginState = function(_ARG_0_)
        print("b04rg00:Transform_Idling\n")
        _ARG_0_.step = 0
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
        print("b04rg00:Transform_Start\n")
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
          Entity.SetLocalPos(B07RG_HANDLE_ROBOT_LEFTARM, WorkVec)
          Entity.GetWorldPos(WorkVec, _ARG_0_.myHandle)
          Entity.SetLocalPos(B06RG_HANDLE_ROBOT_RIGHTARM, WorkVec)
        elseif _ARG_0_.step == TRINITY_TRANSFORM_CHANGE and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Transform_Idling")
          if Entity.IsAlive(B07RG_HANDLE_ROBOT_LEFTARM) and Entity.IsAlive(B06RG_HANDLE_ROBOT_RIGHTARM) then
            Entity.GetWorldPos(WorkVec, _ARG_0_.myHandle)
            Entity.SetLocalPos(B07RG_HANDLE_ROBOT_LEFTARM, WorkVec)
            Entity.GetRot(WorkVec, _ARG_0_.myHandle)
            Entity.SetRot(B07RG_HANDLE_ROBOT_LEFTARM, WorkVec)
            larm = EntityManager:GetEntity(B07RG_HANDLE_ROBOT_LEFTARM)
            larm:GotoState("Transform_Start")
            Entity.GetWorldPos(WorkVec, _ARG_0_.myHandle)
            Entity.SetLocalPos(B06RG_HANDLE_ROBOT_RIGHTARM, WorkVec)
            Entity.GetRot(WorkVec, _ARG_0_.myHandle)
            Entity.SetRot(B06RG_HANDLE_ROBOT_RIGHTARM, WorkVec)
            rarm = EntityManager:GetEntity(B06RG_HANDLE_ROBOT_RIGHTARM)
            rarm:GotoState("Transform_Start")
          end
        end
      end
    },
    Transform_Out = {
      OnBeginState = function(_ARG_0_)
        print("b04rg00:Transform_Out\n")
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
        print("b04rg00:Dead\n")
        Effect.LoopEnd(_ARG_0_.LightHandle)
        _ARG_0_.LightHandle = NULL_HANDLE
        if Enemy.IsAttackerFront(_ARG_0_.myHandle) == true then
          _ARG_0_:SetMotion(_UPVALUE0_)
          _ARG_0_.step = 0
        else
          _ARG_0_:SetMotion(_UPVALUE1_)
          _ARG_0_.step = 2
        end
        Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
        Entity.EnableLockon(_ARG_0_.myHandle, 0)
        Entity.EnableShooton(_ARG_0_.myHandle, 0)
        if B01RG_MODE == B01RG_NOMAL_MODE then
          Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 60)
        end
        B04RG_HANDLE_NOMAL_ARM = NULL_HANDLE
        if Entity.IsAlive(B06RG_HANDLE_ROBOT_RIGHTARM) then
          larm = EntityManager:GetEntity(B06RG_HANDLE_ROBOT_RIGHTARM)
          if larm:GetState() ~= "Dead" then
            larm:GotoState("Dead")
          end
        end
        if Entity.IsAlive(B07RG_HANDLE_ROBOT_LEFTARM) then
          larm = EntityManager:GetEntity(B07RG_HANDLE_ROBOT_LEFTARM)
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
  CreateShot = function(_ARG_0_, _ARG_1_, _ARG_2_)
    if Enemy.IsNetworkMaster(_ARG_0_.myHandle) == false then
      Entity.GetWorldPos(WorkVec, TARGETHANDLELIST[0], 2)
    else
      Entity.GetWorldPos(WorkVec, _ARG_0_.targetHandle, 2)
    end
    Entity.GetWorldPos(WorkVec1, _ARG_1_, _ARG_2_)
    FVECTOR3.Sub(workVec, WorkVec, WorkVec1)
    FVECTOR3.normalize(workVec)
    if Script.Random() < 0.5 then
      WorkVec:set(1, 0, 0)
      Entity.GetWorldPos2(WorkVec, _ARG_1_, WorkVec, _ARG_2_)
      Entity.GetWorldPos(WorkVec1, _ARG_1_, _ARG_2_)
      FVECTOR3.Sub(workVec, WorkVec, WorkVec1)
      FVECTOR3.normalize(workVec)
    end
    workVec1:set(-Math.Atan2(workVec:gety(), Math.Sqrt(workVec:getz() * workVec:getz() + workVec:getx() * workVec:getx())), Math.Atan2(workVec:getx(), workVec:getz()), 0)
    Bullet.CreateEffectBullet(Bullet.CreateBullet("", WorkVec1, workVec1), "b01rg00", "B024_ULB_BLT0_0")
    if Enemy.IsConfuse(_ARG_0_.myHandle) then
      Bullet.SetCollision(Bullet.CreateBullet("", WorkVec1, workVec1), COLL_KIND_NO_CHECK, COLL_SHAPE_SPHERE, 0.5, 0, _ARG_1_)
    else
      Bullet.SetCollision(Bullet.CreateBullet("", WorkVec1, workVec1), COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, 0.5, 0, _ARG_1_)
    end
    SetBulletAttackParam(Bullet.CreateBullet("", WorkVec1, workVec1), _ARG_0_.myHandle, 6)
    Bullet.SetHitAttackEffectName(Bullet.CreateBullet("", WorkVec1, workVec1), "b01rg00", "B024_HIT_LSR0_0")
    Bullet.SetHitBgEffectName(Bullet.CreateBullet("", WorkVec1, workVec1), "b01rg00", "B024_HIT_BEM1_0")
    Bullet.EnableReflect(Bullet.CreateBullet("", WorkVec1, workVec1), Enemy.GetAttackReflect(_ARG_0_.myHandle, 0))
    Entity.CalcVelocity(Bullet.CreateBullet("", WorkVec1, workVec1), 0.25)
    Bullet.SetMaxMoveDist(Bullet.CreateBullet("", WorkVec1, workVec1), 225)
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    print("b04rg00:: OnInit\n")
    _ARG_0_.myHandle = _ARG_1_
    B04RG_HANDLE_NOMAL_ARM = _ARG_1_
    _ARG_0_.step = 0
    _ARG_0_.targetHandle = NULL_HANDLE
    _ARG_0_.LightHandle = NULL_HANDLE
    _ARG_0_.changeFlagOn = 0
    _ARG_0_.WorkTime = 0
    _ARG_0_.Wait = 0
    _ARG_0_.Wait1 = 0
    _ARG_0_.Wait2 = 0
    _ARG_0_.Wait3 = 0
    _ARG_0_.EndFlag = 0
    _ARG_0_.changeCount = 0
    _ARG_0_.isDead = 0
    _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.cameraPos = FVECTOR3.new(0, 0, 0)
    if B04RG_INIT_PARAM == false then
      _UPVALUE0_ = Enemy.GetExtraParam(_ARG_1_, "IdlingT") * 60
      print("B04RG_TIME_IDLING = " .. _UPVALUE0_ .. "\n")
      _UPVALUE1_ = Enemy.GetExtraParam(_ARG_1_, "SpinTime") * 60
      print("B04RG_TIME_SPINNING = " .. _UPVALUE1_ .. "\n")
      B04RG_INIT_PARAM = true
    end
    _ARG_0_.stack = Stack:Create()
    Entity.SetMovementCollRadius(_ARG_0_.myHandle, 1.7)
    Entity.SetLowerHalf(_ARG_0_.myHandle, 2)
    Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
    Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
    Entity.EnableLockon(_ARG_0_.myHandle, 0)
    Entity.EnableGravity(_ARG_0_.myHandle, 1)
    Enemy.IsAllEnemyWaiting()
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
  OnDestroy = function(_ARG_0_)
    Effect.LoopEnd(_ARG_0_.LightHandle)
  end,
  OnDamage = function(_ARG_0_, _ARG_1_)
    print("b04rg00: OnDamage\n")
    Enemy.SetHP(B06RG_HANDLE_ROBOT_RIGHTARM, (Enemy.GetHp(_ARG_0_.myHandle)))
    Enemy.SetHP(B07RG_HANDLE_ROBOT_LEFTARM, (Enemy.GetHp(_ARG_0_.myHandle)))
    return 1
  end,
  OnReturnDamage = function(_ARG_0_)
  end,
  OnHitAttack = function(_ARG_0_)
  end,
  OnDead = function(_ARG_0_)
    print("b04rg00: OnDead()\n")
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
EntityFactory:Add("b04rg00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b74vs00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
