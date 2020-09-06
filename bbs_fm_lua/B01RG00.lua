B01RG_DEBUG = 0
WorkVec = FVECTOR3.new(0, 0, 0)
WorkVec1 = FVECTOR3.new(0, 0, 0)
workVec = FVECTOR3.new(0, 0, 0)
workVec1 = FVECTOR3.new(0, 0, 0)
TagetPos = FVECTOR3.new(0, 0, 0)
LaserCenterPos = FVECTOR3.new(0, 0, 0)
B01RG_ID_HEAD = 0
B04RG_ID_NOMAL_ARM = 1
B05RG_ID_NOMAL_FOOT = 2
B06RG_ID_ROBOT_RIGHTARM = 4
B07RG_ID_ROBOT_LEFTARM = 3
B08RG_ID_ROBOT_FOOT = 5
TRINYTIY_SETPOS = {}
TRINYTIY_SETPOS[0] = {
  x = 1.218,
  y = 0,
  z = -13.927
}
TRINYTIY_SETPOS[1] = {
  x = -7.645,
  y = 0,
  z = 5.1843
}
TRINYTIY_SETPOS[2] = {
  x = 9.6733,
  y = 0,
  z = 4.6722
}
TRINYTIY_SETPOS[3] = {
  x = -10.2252,
  y = 0,
  z = -2.1448
}
TRINYTIY_SETPOS[4] = {
  x = 12.344,
  y = 0,
  z = -2.1448
}
TRINYTIY_SETPOS[10] = {
  x = 5.692758,
  y = 0,
  z = 0.350009
}
TRINYTIY_SETPOS[11] = {
  x = 2.55892,
  y = 0,
  z = 6.724672
}
B01RG_CENTER_POS = {
  x = 0.8,
  y = 0.008,
  z = -2.67
}
COEFFICIENT = 1
B01RG_MODE = 1
B01RG_NOMAL_MODE = 0
B01RG_ROBOT_MODE = 1
B01RG_SAVEINGDAMAGE = 0
B01RG_COUNTER_DAMAGE = 60
B01RG_PARTS_BETFA_ALIVE = 1
B01RG_PARTS_GANMA_ALIVE = 1
B01RG_ALIVE_ALL = 0
B01RG_ALIVE_NO_BETA = 1
B01RG_ALIVE_NO_GANMA = 2
B01RG_ALIVE_NO_BETA_OR_GANMA = 3
B01RG_PARTS_ALIVE = B01RG_ALIVE_ALL
B01RG_HANDLE_HEAD = NULL_HANDLE
B04RG_HANDLE_NOMAL_ARM = NULL_HANDLE
B05RG_HANDLE_NOMAL_FOOT = NULL_HANDLE
B06RG_HANDLE_ROBOT_RIGHTARM = NULL_HANDLE
B07RG_HANDLE_ROBOT_LEFTARM = NULL_HANDLE
B08RG_HANDLE_ROBOT_FOOT = NULL_HANDLE
TARGETHANDLELIST = {}
TRINITY_TRANSFORM_STEP = 0
TRINITY_TRANSFORM_START = 0
TRINITY_TRANSFORM_CHANGE = 1
TRINITY_TRANSFORM_OUT = 2
B01RG_TRIANGLELASER_SETUPPOSMOVE = 0
B01RG_TRIANGLELASER_SETUPPOSINDLING = 1
B01RG_TRIANGLELASER_SHOOT = 2
B01RG_TRIANGLELASER_ATTACK1 = 3
B01RG_TRIANGLELASER_ATTACK2 = 4
B01RG_TRIANGLELASER_ATTACK3 = 5
B01RG_TRIANGLELASER_ATTACK_END = 6
B01RG_TRIANGLELASER_ATTACK_ROTATION = 0.1
B01RG_TRIANGLELASER_ATTACK_UPDATE = 60
B01RG_TRIANGLELASER_ATTACK_SIZE = 0.8
B01RG_TRIANGLELASER_RIMITT_POS1 = {
  x = -6,
  y = 0.008,
  z = -9
}
B01RG_TRIANGLELASER_RIMITT_POS2 = {
  x = 3,
  y = 0.008,
  z = 0
}
B01RG_TRIANGLELASER_MOVEID = 2
B01RG_TRIANGLELASER_MOVEPOW = {}
B01RG_TRIANGLELASER_MOVEPOW[0] = {x = 0.05, z = 0.05}
B01RG_TRIANGLELASER_MOVEPOW[1] = {x = 0.01, z = 0.1}
B01RG_TRIANGLELASER_MOVEPOW[2] = {x = 0.1, z = 0.05}
B01RG_TRIANGLELASER_RADIUS = 90.25
B01RG_TRIANGLELASER_RADIUS2 = 100
B01RG_TRIANGLELASER_ROTNUM = 1.5
B01RG_INIT_PARAM = false
setmetatable({
  new = function(_ARG_0_)
    print("b01rg00:new()\n")
    return setmetatable(__StateMachine:new(), _UPVALUE0_)
  end,
  states = {
    Appear = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_:SetMotion(_UPVALUE0_)
        _ARG_0_:setAllTargetHandleList(Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR))
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        changeSet(_ARG_0_, B04RG_HANDLE_NOMAL_ARM, 0)
        changeSet(_ARG_0_, B05RG_HANDLE_NOMAL_FOOT, 0)
        _ARG_0_:GotoState("StateSettingA1")
      end
    },
    Idling = {
      OnBeginState = function(_ARG_0_)
        print("b01rg00:Idling\n")
        _ARG_0_:changeNomalParts("Idling")
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_:SetMotion(_UPVALUE1_)
        changeSet(_ARG_0_, B04RG_HANDLE_NOMAL_ARM, 1)
        changeSet(_ARG_0_, B05RG_HANDLE_NOMAL_FOOT, 1)
        changeSet(_ARG_0_, B06RG_HANDLE_ROBOT_RIGHTARM, 0)
        changeSet(_ARG_0_, B07RG_HANDLE_ROBOT_LEFTARM, 0)
        changeSet(_ARG_0_, B08RG_HANDLE_ROBOT_FOOT, 0)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
          return
        end
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      end
    },
    StateSettingFinal = {
      OnBeginState = function(_ARG_0_)
        print("b01rg00:StateSettingFinal\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:setthingStateFinal()
      end
    },
    StateSettingA1 = {
      OnBeginState = function(_ARG_0_)
        print("b01rg00:StateSettingA1\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:setthingStateA1()
        _ARG_0_:changeBobotParts("Transform_Idling")
        _ARG_0_:changeStep(1)
      end
    },
    StateSettingB1 = {
      OnBeginState = function(_ARG_0_)
        print("b01rg00:StateSettingB1\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:setthingStateB1()
      end
    },
    StateSettingC1 = {
      OnBeginState = function(_ARG_0_)
        print("b01rg00:StateSettingC1\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:setthingStateC1()
      end
    },
    StateSettingD1 = {
      OnBeginState = function(_ARG_0_)
        print("b01rg00:StateSettingC1\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:setthingStateD1()
      end
    },
    StateSettingB1 = {
      OnBeginState = function(_ARG_0_)
        print("b01rg00:StateSettingB1\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:setthingStateB1()
      end
    },
    StateSettingC1 = {
      OnBeginState = function(_ARG_0_)
        print("b01rg00:StateSettingC1\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:setthingStateC1()
      end
    },
    StateSettingD1 = {
      OnBeginState = function(_ARG_0_)
        print("b01rg00:StateSettingC1\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:setthingStateD1()
      end
    },
    StateSettingA2 = {
      OnBeginState = function(_ARG_0_)
        print("b01rg00:StateSettingA2\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:setthingStateA2()
        _ARG_0_:changeBobotParts("Transform_Idling")
        _ARG_0_:changeStep(1)
      end
    },
    StateSettingB2 = {
      OnBeginState = function(_ARG_0_)
        print("b01rg00:StateSettingB2\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:setthingStateB2()
      end
    },
    StateSettingC2 = {
      OnBeginState = function(_ARG_0_)
        print("b01rg00:StateSettingC2\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:setthingStateC2()
      end
    },
    StateSettingD2 = {
      OnBeginState = function(_ARG_0_)
        print("b01rg00:StateSettingD2\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:setthingStateD2()
      end
    },
    StateSettingA3 = {
      OnBeginState = function(_ARG_0_)
        print("b01rg00:StateSettingA3\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:setthingStateA3()
        _ARG_0_:changeBobotParts("Transform_Idling")
        _ARG_0_:changeStep(1)
      end
    },
    StateSettingB3 = {
      OnBeginState = function(_ARG_0_)
        print("b01rg00:StateSettingB3\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:setthingStateB3()
      end
    },
    StateSettingC3 = {
      OnBeginState = function(_ARG_0_)
        print("b01rg00:StateSettingC3\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:setthingStateC3()
      end
    },
    StateSettingD3 = {
      OnBeginState = function(_ARG_0_)
        print("b01rg00:StateSettingC3\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:setthingStateD3()
      end
    },
    StateTransform = {
      OnBeginState = function(_ARG_0_)
        print("b01rg00:StateTransform\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:setthingTransform()
      end
    },
    SpinningBeam = {
      OnBeginState = function(_ARG_0_)
        print("b01rg00:SpinningBeam\n")
        _ARG_0_:changeNomalFoot("AttackIdling")
        _ARG_0_:changeNomalArm("SpinningBeam")
        _ARG_0_.step = 0
        _ARG_0_.count = 0
        _ARG_0_:SetMotion(_UPVALUE0_)
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsAlive(B04RG_HANDLE_NOMAL_ARM) then
          if EntityManager:GetEntity(B04RG_HANDLE_NOMAL_ARM).EndFlag == 1 then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
            return
          end
          _ARG_0_:RandomMove()
        else
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    TramplingAttack = {
      OnBeginState = function(_ARG_0_)
        print("b01rg00:TramplingAttack\n")
        _ARG_0_:changeNomalFoot("TramplingAttack")
        _ARG_0_:changeNomalArm("AttackIdling")
        _ARG_0_.step = 0
        _ARG_0_.count = 0
        _ARG_0_:SetMotion(_UPVALUE0_)
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsAlive(B05RG_HANDLE_NOMAL_FOOT) then
          if EntityManager:GetEntity(B05RG_HANDLE_NOMAL_FOOT).EndFlag == 1 then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
            return
          end
          _ARG_0_:RandomMove()
        else
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    UltimaImpact = {
      OnBeginState = function(_ARG_0_)
        print("b01rg00:UltimaImpact\n")
        _ARG_0_:changeNomalFoot("AttackIdling")
        _ARG_0_:changeNomalArm("UltimaImpact")
        _ARG_0_.step = 0
        _ARG_0_.count = 0
        _ARG_0_:SetMotion(_UPVALUE0_)
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsAlive(B04RG_HANDLE_NOMAL_ARM) then
          if EntityManager:GetEntity(B04RG_HANDLE_NOMAL_ARM).EndFlag == 1 then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
            return
          end
          _ARG_0_:RandomMove()
        else
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    BoltecShoot = {
      OnBeginState = function(_ARG_0_)
        print("b01rg00:BoltecShoot\n")
        _ARG_0_:changeNomalFoot("BoltecShoot")
        _ARG_0_:changeNomalArm("AttackIdling")
        _ARG_0_.step = 0
        _ARG_0_.count = 0
        _ARG_0_:SetMotion(_UPVALUE0_)
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsAlive(B05RG_HANDLE_NOMAL_FOOT) then
          if EntityManager:GetEntity(B05RG_HANDLE_NOMAL_FOOT).EndFlag == 1 then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
            return
          end
          if _ARG_0_.step == 0 then
            _ARG_0_.targetPos:set(B01RG_CENTER_POS.x, 0, B01RG_CENTER_POS.z)
            _ARG_0_.targetPos:setx(_ARG_0_.targetPos:getx() + (9 * Script.Random() + 4) * Math.Cos((RoundPI(Script.Random() * 2 * PI))))
            _ARG_0_.targetPos:setz(_ARG_0_.targetPos:getz() + (9 * Script.Random() + 4) * Math.Sin((RoundPI(Script.Random() * 2 * PI))))
            _ARG_0_.step = 1
            Entity.SetTimer(_ARG_0_.myHandle, 60)
          elseif _ARG_0_.step == 1 then
            WorkVec:set(0, 0, _UPVALUE0_)
            Entity.CalcVelocityXZ(_ARG_0_.myHandle, WorkVec)
            Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 3)
            _ARG_0_.WorkVec:set(B01RG_CENTER_POS.x, 0, B01RG_CENTER_POS.z)
            if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.WorkVec) < 16 then
              if _ARG_0_:WhichRightandLeft() == 1 then
                _ARG_0_.wanderAng = -10
              else
                _ARG_0_.wanderAng = 10
              end
              Entity.GetRot(_ARG_0_.WorkVec, _ARG_0_.myHandle)
              _ARG_0_.WorkVec:sety(_ARG_0_.WorkVec:gety() + DegToRad(_ARG_0_.wanderAng))
              Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.WorkVec)
            end
            if Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.IsWall(_ARG_0_.myHandle) or 4 > Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetPos) then
              _ARG_0_.step = 0
            end
          end
        else
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    FreeMove = {
      OnBeginState = function(_ARG_0_)
        print("b01rg00:FreeMove\n")
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
        elseif _ARG_0_.step == 1 then
          WorkVec:set(0, 0, _UPVALUE0_)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, WorkVec)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 3)
          _ARG_0_.WorkVec:set(B01RG_CENTER_POS.x, 0, B01RG_CENTER_POS.z)
          if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.WorkVec) < 16 then
            if _ARG_0_:WhichRightandLeft() == 1 then
              _ARG_0_.wanderAng = -10
            else
              _ARG_0_.wanderAng = 10
            end
            Entity.GetRot(_ARG_0_.WorkVec, _ARG_0_.myHandle)
            _ARG_0_.WorkVec:sety(_ARG_0_.WorkVec:gety() + DegToRad(_ARG_0_.wanderAng))
            Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.WorkVec)
          end
          if Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.IsWall(_ARG_0_.myHandle) or 4 > Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetPos) then
            _ARG_0_.count = _ARG_0_.count + 1
            if _ARG_0_.count > 5 then
              _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
            else
              _ARG_0_.step = 0
            end
          end
        end
      end
    },
    Wander = {
      OnBeginState = function(_ARG_0_)
        print("b01rg00:Wander\n")
        Entity.SetTimer(_ARG_0_.myHandle, 180)
        _ARG_0_:SetMotion(_UPVALUE0_)
        _ARG_0_.step = 0
        _ARG_0_.count = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:RandomMove()
      end
    },
    Move = {
      OnBeginState = function(_ARG_0_)
        print("b01rg00:Move\n")
        Entity.SetTimer(_ARG_0_.myHandle, 80)
        _ARG_0_:SetMotion(_UPVALUE0_)
        _ARG_0_:setMotionParts(_UPVALUE1_)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        WorkVec:set(0, 0, 0.02)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, WorkVec)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, GetRandHandleList(), 0.5)
        if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
          return
        end
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      end
    },
    Fixed_position = {
      OnBeginState = function(_ARG_0_)
        print("b01rg00:Fixed_position\n")
        _ARG_0_:SetMotion(_UPVALUE0_)
        _ARG_0_.step = 0
        _ARG_0_.targetPos:set(177, 0, 0)
        if B01RG_PARTS_ALIVE == B01RG_ALIVE_ALL then
          _ARG_0_.targetPos:set(TRINYTIY_SETPOS[0].x, 0, TRINYTIY_SETPOS[0].z)
          print("b01rg00:TRINYTIY_SETPOS[0]\n")
        elseif B01RG_PARTS_ALIVE == B01RG_ALIVE_NO_BETA then
          _ARG_0_.targetPos:set(TRINYTIY_SETPOS[3].x, 0, TRINYTIY_SETPOS[3].z)
          print("b01rg00:TRINYTIY_SETPOS[3]\n")
        elseif B01RG_PARTS_ALIVE == B01RG_ALIVE_NO_GANMA then
          _ARG_0_.targetPos:set(TRINYTIY_SETPOS[3].x, 0, TRINYTIY_SETPOS[3].z)
          print("b01rg00:TRINYTIY_SETPOS[3]\n")
        elseif B01RG_PARTS_ALIVE == B01RG_ALIVE_NO_BETA_OR_GANMA then
          _ARG_0_.targetPos:set(TRINYTIY_SETPOS[0].x, 0, TRINYTIY_SETPOS[0].z)
          print("b01rg00:TRINYTIY_SETPOS[3]\n")
        end
        _ARG_0_:changeNomalParts("Fixed_position")
        TagetPos:set(B01RG_CENTER_POS.x, 0, B01RG_CENTER_POS.z)
        Entity.SetTimer(_ARG_0_.myHandle, 400)
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          _ARG_0_.step = 1
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
            print("\131\191: \146\232\136\202\146u\130\201\130\194\130\162\130\189\n")
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_:SetMotion(_UPVALUE1_)
            Entity.SetTimer(_ARG_0_.myHandle, 60)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, TagetPos) < 81 then
            WorkVec:set(0, 0, -_UPVALUE0_)
            Entity.CalcVelocityXZ(_ARG_0_.myHandle, WorkVec)
          elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, TagetPos) > 90.25 then
            WorkVec:set(0, 0, _UPVALUE0_)
            Entity.CalcVelocityXZ(_ARG_0_.myHandle, WorkVec)
          else
            Entity.ClearSpeed(_ARG_0_.myHandle)
          end
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, TagetPos, 180)
          if not Entity.IsAlive(B04RG_HANDLE_NOMAL_ARM) or Entity.IsAlive(B05RG_HANDLE_NOMAL_FOOT) then
          end
          if B01RG_PARTS_ALIVE == B01RG_ALIVE_ALL then
          elseif B01RG_PARTS_ALIVE == B01RG_ALIVE_NO_BETA then
          elseif B01RG_PARTS_ALIVE == B01RG_ALIVE_NO_GANMA then
          else
          end
          if 1 == 1 and Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        end
      end
    },
    Transform_SetupPosMove = {
      OnBeginState = function(_ARG_0_)
        print("b01rg00:Transform_SetupPosMove\n")
        _ARG_0_:SetMotion(_UPVALUE0_)
        _ARG_0_.targetPos:set(Math.Cos((RoundPI(Script.Random() * 2 * PI))) * (Script.Random() * 3), 0, Math.Sin((RoundPI(Script.Random() * 2 * PI))) * (Script.Random() * 3))
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
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) < 1 then
          _ARG_0_:GotoState("Transform_SetupPosMove_Idling")
        end
      end
    },
    Transform_SetupPosMove_Idling = {
      OnBeginState = function(_ARG_0_)
        print("b01rg00:Transform_SetupPosMove_Idling\n")
        _ARG_0_:SetMotion(_UPVALUE0_)
        if Entity.IsAlive(B04RG_HANDLE_NOMAL_ARM) then
          WorkVec:set(TRINYTIY_SETPOS[10].x, 0, TRINYTIY_SETPOS[10].z)
          Entity.GetWorldPos2(WorkVec1, _ARG_0_.myHandle, WorkVec)
          EntityManager:GetEntity(B04RG_HANDLE_NOMAL_ARM).targetPos:set(WorkVec1:getx(), WorkVec1:gety(), WorkVec1:getz())
          EntityManager:GetEntity(B04RG_HANDLE_NOMAL_ARM):GotoState("Transform_SetupPosMove")
        end
        if Entity.IsAlive(B05RG_HANDLE_NOMAL_FOOT) then
          WorkVec:set(TRINYTIY_SETPOS[11].x, 0, TRINYTIY_SETPOS[11].z)
          Entity.GetWorldPos2(WorkVec1, _ARG_0_.myHandle, WorkVec)
          EntityManager:GetEntity(B05RG_HANDLE_NOMAL_FOOT).targetPos:set(WorkVec1:getx(), WorkVec1:gety(), WorkVec1:getz())
          EntityManager:GetEntity(B05RG_HANDLE_NOMAL_FOOT):GotoState("Transform_SetupPosMove")
        end
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.GetRot(WorkVec, _ARG_0_.myHandle)
        if B01RG_PARTS_ALIVE == B01RG_ALIVE_ALL then
          if EntityManager:GetEntity(B04RG_HANDLE_NOMAL_ARM).changeFlagOn == 1 and EntityManager:GetEntity(B05RG_HANDLE_NOMAL_FOOT).changeFlagOn == 1 then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        elseif B01RG_PARTS_ALIVE == B01RG_ALIVE_NO_BETA then
          if EntityManager:GetEntity(B05RG_HANDLE_NOMAL_FOOT).changeFlagOn == 1 then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        elseif B01RG_PARTS_ALIVE == B01RG_ALIVE_NO_GANMA then
          if EntityManager:GetEntity(B04RG_HANDLE_NOMAL_ARM).changeFlagOn == 1 then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        elseif B01RG_PARTS_ALIVE == B01RG_ALIVE_NO_BETA_OR_GANMA then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Reflect_slash = {
      OnBeginState = function(_ARG_0_)
        print("b01rg00:Reflect_slash\n")
        Entity.SetTimer(_ARG_0_.myHandle, 2000)
        _ARG_0_:SetMotion(_UPVALUE0_)
        B01RG_MODE = B01RG_NOMAL_MODE
        _ARG_0_.step = _UPVALUE1_
        _ARG_0_:changeNomalParts("Reflect_slash")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.GetVelocity(WorkVec, _ARG_0_.myHandle)
        if _ARG_0_.step == _UPVALUE0_ then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.GetWorldPos(WorkVec1, _ARG_0_.myHandle)
            Entity.GetWorldPos(WorkVec, GetRandHandleList())
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
        print("b01rg00:Reflect_slash_End\n")
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
        changeSet(_ARG_0_, B04RG_HANDLE_NOMAL_ARM, 1)
        changeSet(_ARG_0_, B05RG_HANDLE_NOMAL_FOOT, 1)
        changeSet(_ARG_0_, B06RG_HANDLE_ROBOT_RIGHTARM, 0)
        changeSet(_ARG_0_, B07RG_HANDLE_ROBOT_LEFTARM, 0)
        changeSet(_ARG_0_, B08RG_HANDLE_ROBOT_FOOT, 0)
        print("b01rg00:TriangleLaser\n")
        _ARG_0_.step = B01RG_TRIANGLELASER_SETUPPOSMOVE
        _ARG_0_:SetMotion(_UPVALUE0_)
        B01RG_MODE = B01RG_NOMAL_MODE
        _ARG_0_.targetPos:set(0, 0, 0)
        if B01RG_PARTS_ALIVE == B01RG_ALIVE_ALL then
          _ARG_0_.targetPos:set(TRINYTIY_SETPOS[0].x, 0, TRINYTIY_SETPOS[0].z)
        elseif B01RG_PARTS_ALIVE == B01RG_ALIVE_NO_BETA then
          _ARG_0_.targetPos:set(TRINYTIY_SETPOS[3].x, 0, TRINYTIY_SETPOS[3].z)
        elseif B01RG_PARTS_ALIVE == B01RG_ALIVE_NO_GANMA then
          _ARG_0_.targetPos:set(TRINYTIY_SETPOS[3].x, 0, TRINYTIY_SETPOS[3].z)
        elseif B01RG_PARTS_ALIVE == B01RG_ALIVE_NO_BETA_OR_GANMA then
          _ARG_0_.targetPos:set(TRINYTIY_SETPOS[0].x, 0, TRINYTIY_SETPOS[0].z)
        end
        Entity.SetTimer(_ARG_0_.myHandle, Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetPos) / _UPVALUE1_ + 100)
        _ARG_0_:changeNomalParts("TriangleLaser")
        TagetPos:set(B01RG_CENTER_POS.x, 0, B01RG_CENTER_POS.z)
        _ARG_0_.Wait = 0
        B01RG_TRIANGLELASER_MOVEID = Script.RandomInteger(2)
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Effect.LoopEnd(_ARG_0_.LightHandle)
        _ARG_0_.LightHandle = NULL_HANDLE
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == B01RG_TRIANGLELASER_SETUPPOSMOVE then
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) < 25 then
            WorkVec:set(0, 0, _UPVALUE0_ / ((Entity.CalcDistance(_ARG_0_.myHandle, _ARG_0_.targetPos) + 0.001) / 5))
            Entity.CalcVelocityXZ(_ARG_0_.myHandle, WorkVec)
          else
            WorkVec:set(0, 0, _UPVALUE0_)
            Entity.CalcVelocityXZ(_ARG_0_.myHandle, WorkVec)
          end
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 30)
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) < 1 or Entity.IsTimeOver(_ARG_0_.myHandle) then
            print("\131\191: \146\232\136\202\146u\130\201\130\194\130\162\130\189\n")
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Entity.SetTimer(_ARG_0_.myHandle, 200)
            _ARG_0_:SetMotion(_UPVALUE1_)
            _ARG_0_.step = B01RG_TRIANGLELASER_SETUPPOSINDLING
          end
        elseif _ARG_0_.step == B01RG_TRIANGLELASER_SETUPPOSINDLING then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, TagetPos, 180)
          if B01RG_PARTS_ALIVE == B01RG_ALIVE_ALL then
          elseif B01RG_PARTS_ALIVE == B01RG_ALIVE_NO_BETA then
          elseif B01RG_PARTS_ALIVE == B01RG_ALIVE_NO_GANMA then
          else
          end
          if 1 == 1 and Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:setMotionNomalParts(_UPVALUE2_)
            _ARG_0_:SetMotion(_UPVALUE2_)
            Entity.SetTimer(_ARG_0_.myHandle, Entity.CalcDistance(_ARG_0_.myHandle, TagetPos) * 2 * PI * B01RG_TRIANGLELASER_ROTNUM / B01RG_TRIANGLELASER_ATTACK_ROTATION)
            Entity.SetTimer(B04RG_HANDLE_NOMAL_ARM, _UPVALUE0_ * (Entity.CalcDistance(_ARG_0_.myHandle, TagetPos) * 2 * PI * B01RG_TRIANGLELASER_ROTNUM))
            Entity.SetTimer(B05RG_HANDLE_NOMAL_FOOT, _UPVALUE0_ * (Entity.CalcDistance(_ARG_0_.myHandle, TagetPos) * 2 * PI * B01RG_TRIANGLELASER_ROTNUM))
            _ARG_0_.step = B01RG_TRIANGLELASER_SHOOT
            _ARG_0_:changeStep(B01RG_TRIANGLELASER_SHOOT)
          end
        elseif _ARG_0_.step == B01RG_TRIANGLELASER_SHOOT then
          if 30 < Entity.GetMotionNowFrame(_ARG_0_.myHandle) then
            WorkVec:set(0, 2, 2.8)
            WorkVec1:set(0, 0, 0)
            _ARG_0_.LightHandle = Entity.SetEffect(_ARG_0_.myHandle, "b01rg00", "B024_TRY_LSR0_0", WorkVec, WorkVec1)
            Enemy.SetGeneralPurposeAttackColl(_ARG_0_.myHandle, COLL_KIND_ENEMY, COLL_SHAPE_CYLINDER, B01RG_TRIANGLELASER_ATTACK_SIZE)
            Enemy.SetGeneralPurposeAttackCollParam(_ARG_0_.myHandle, Enemy.GetAttackKind(_ARG_0_.myHandle, 8), Enemy.GetAttackAttr(_ARG_0_.myHandle, 8), Enemy.GetAttackPoint(_ARG_0_.myHandle, 8), Enemy.GetAttackPowerCorrection(_ARG_0_.myHandle, 8))
            Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 0)
            Enemy.SetGeneralPurposeAttackCollHitAttackEffectName(_ARG_0_.myHandle, "b01rg00", "B024_HIT_SPK0_0")
            Effect.SetAttachNoRot(_ARG_0_.LightHandle, false)
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
          WorkVec:set(B01RG_TRIANGLELASER_ATTACK_ROTATION, 0, _UPVALUE3_)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, WorkVec)
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_.step = B01RG_TRIANGLELASER_ATTACK2
            Entity.SetTimer(_ARG_0_.myHandle, 60)
            _ARG_0_:changeStep(B01RG_TRIANGLELASER_ATTACK2)
          end
          TagetPos:set(TagetPos:getx() + B01RG_TRIANGLELASER_MOVEPOW[B01RG_TRIANGLELASER_MOVEID].x, TagetPos:gety(), TagetPos:getz() + B01RG_TRIANGLELASER_MOVEPOW[B01RG_TRIANGLELASER_MOVEID].z)
          if TagetPos:getx() > B01RG_TRIANGLELASER_RIMITT_POS2.x then
            TagetPos:setx(B01RG_TRIANGLELASER_RIMITT_POS2.x)
          end
          if TagetPos:getx() < B01RG_TRIANGLELASER_RIMITT_POS1.x then
            TagetPos:setx(B01RG_TRIANGLELASER_RIMITT_POS1.x)
          end
          if TagetPos:getz() > B01RG_TRIANGLELASER_RIMITT_POS2.z then
            TagetPos:setz(B01RG_TRIANGLELASER_RIMITT_POS2.z)
          end
          if TagetPos:getz() < B01RG_TRIANGLELASER_RIMITT_POS1.z then
            TagetPos:setz(B01RG_TRIANGLELASER_RIMITT_POS1.z)
          end
        elseif _ARG_0_.step == B01RG_TRIANGLELASER_ATTACK2 then
          Entity.ClearSpeed(_ARG_0_.myHandle)
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetTimer(_ARG_0_.myHandle, Entity.CalcDistance(_ARG_0_.myHandle, TagetPos) * 2 * PI * B01RG_TRIANGLELASER_ROTNUM / B01RG_TRIANGLELASER_ATTACK_ROTATION)
            Entity.SetTimer(B04RG_HANDLE_NOMAL_ARM, _UPVALUE0_ * (Entity.CalcDistance(_ARG_0_.myHandle, TagetPos) * 2 * PI * B01RG_TRIANGLELASER_ROTNUM))
            Entity.SetTimer(B05RG_HANDLE_NOMAL_FOOT, _UPVALUE0_ * (Entity.CalcDistance(_ARG_0_.myHandle, TagetPos) * 2 * PI * B01RG_TRIANGLELASER_ROTNUM))
            _ARG_0_.step = B01RG_TRIANGLELASER_ATTACK3
            _ARG_0_:changeStep(B01RG_TRIANGLELASER_ATTACK3)
          end
        elseif _ARG_0_.step == B01RG_TRIANGLELASER_ATTACK3 then
          TagetPos:set(TagetPos:getx() - B01RG_TRIANGLELASER_MOVEPOW[B01RG_TRIANGLELASER_MOVEID].x, TagetPos:gety(), TagetPos:getz() - B01RG_TRIANGLELASER_MOVEPOW[B01RG_TRIANGLELASER_MOVEID].z)
          if TagetPos:getx() > B01RG_TRIANGLELASER_RIMITT_POS2.x then
            TagetPos:setx(B01RG_TRIANGLELASER_RIMITT_POS2.x)
          end
          if TagetPos:getx() < B01RG_TRIANGLELASER_RIMITT_POS1.x then
            TagetPos:setx(B01RG_TRIANGLELASER_RIMITT_POS1.x)
          end
          if TagetPos:getz() > B01RG_TRIANGLELASER_RIMITT_POS2.z then
            TagetPos:setz(B01RG_TRIANGLELASER_RIMITT_POS2.z)
          end
          if TagetPos:getz() < B01RG_TRIANGLELASER_RIMITT_POS1.z then
            TagetPos:setz(B01RG_TRIANGLELASER_RIMITT_POS1.z)
          end
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, TagetPos) < B01RG_TRIANGLELASER_RADIUS then
          else
            if Entity.CalcDistanceSq(_ARG_0_.myHandle, TagetPos) > B01RG_TRIANGLELASER_RADIUS2 then
            else
            end
          end
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, TagetPos, 180)
          WorkVec:set(-B01RG_TRIANGLELASER_ATTACK_ROTATION, 0, _UPVALUE3_)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, WorkVec)
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 0)
            Enemy.EnableGeneralPurposeAttackColl(B04RG_HANDLE_NOMAL_ARM, 0)
            Enemy.EnableGeneralPurposeAttackColl(B05RG_HANDLE_NOMAL_FOOT, 0)
            _ARG_0_:setMotionNomalParts(_UPVALUE4_)
            _ARG_0_:SetMotion(_UPVALUE4_)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Entity.ClearSpeed(B04RG_HANDLE_NOMAL_ARM)
            Entity.ClearSpeed(B05RG_HANDLE_NOMAL_FOOT)
            _ARG_0_.step = B01RG_TRIANGLELASER_ATTACK_END
            _ARG_0_:changeStep(B01RG_TRIANGLELASER_ATTACK_END)
            Effect.LoopEnd(_ARG_0_.LightHandle)
            _ARG_0_.LightHandle = NULL_HANDLE
          end
        elseif _ARG_0_.step == B01RG_TRIANGLELASER_ATTACK_END and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:changeNomalParts("Idling")
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
        if Effect.IsAlive(_ARG_0_.LightHandle) then
          if B01RG_PARTS_ALIVE == B01RG_ALIVE_ALL then
          elseif B01RG_PARTS_ALIVE == B01RG_ALIVE_NO_BETA then
          else
          end
          WorkVec1:set(0, 2, 2.8)
          Entity.GetWorldPos2(WorkVec, _ARG_0_.myHandle, WorkVec1)
          WorkVec1:set(0, 2, 2.8)
          Entity.GetWorldPos2(WorkVec1, B04RG_HANDLE_NOMAL_ARM, WorkVec1)
          FVECTOR3.Sub(workVec, WorkVec1, WorkVec)
          FVECTOR3.normalize(workVec)
          workVec1:set(0, 0, 0)
          workVec1:setx(DegToRad(90))
          workVec1:sety((Math.Atan2(workVec:getx(), workVec:getz())))
          Effect.UpdateCoord(_ARG_0_.LightHandle, WorkVec, workVec1)
          WorkVec1:set(0, 2, 2.8)
          Entity.GetWorldPos2(WorkVec, _ARG_0_.myHandle, WorkVec1)
          WorkVec1:set(0, 2, 2.8)
          Entity.GetWorldPos2(WorkVec1, B04RG_HANDLE_NOMAL_ARM, WorkVec1)
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
          if Entity.IsAlive(B04RG_HANDLE_NOMAL_ARM) then
          else
          end
          if Entity.IsAlive(B05RG_HANDLE_NOMAL_FOOT) then
          else
          end
          if B01RG_PARTS_ALIVE == B01RG_ALIVE_ALL then
          elseif B01RG_PARTS_ALIVE == B01RG_ALIVE_NO_BETA then
          elseif B01RG_PARTS_ALIVE == B01RG_ALIVE_NO_GANMA then
          else
          end
          if 1 == 1 then
            Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 0)
            Enemy.EnableGeneralPurposeAttackColl(B04RG_HANDLE_NOMAL_ARM, 0)
            Enemy.EnableGeneralPurposeAttackColl(B05RG_HANDLE_NOMAL_FOOT, 0)
            _ARG_0_:setMotionNomalParts(_UPVALUE4_)
            _ARG_0_:SetMotion(_UPVALUE4_)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Entity.ClearSpeed(B04RG_HANDLE_NOMAL_ARM)
            Entity.ClearSpeed(B05RG_HANDLE_NOMAL_FOOT)
            _ARG_0_.step = B01RG_TRIANGLELASER_ATTACK_END
            _ARG_0_:changeStep(B01RG_TRIANGLELASER_ATTACK_END)
            Effect.LoopEnd(_ARG_0_.LightHandle)
            _ARG_0_.LightHandle = NULL_HANDLE
          end
        end
      end
    },
    TouchAndGo = {
      OnBeginState = function(_ARG_0_)
        print("b01rg00:TouchAndGo\n")
        Entity.SetTimer(_ARG_0_.myHandle, 80)
        _ARG_0_:SetMotionSetGroup(_UPVALUE0_, 1)
        _ARG_0_.step = _UPVALUE1_
        _ARG_0_.Speed = 0
        Entity.EnableGravity(_ARG_0_.myHandle, 0)
        _ARG_0_.TauchCnt = 0
        _ARG_0_:changeNomalParts("AttackIdling")
        Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 1)
        _ARG_0_.Wait2 = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 0)
        Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == _UPVALUE0_ then
          _ARG_0_:TurnX(45, -1, 45)
          Entity.GetWorldPos(WorkVec, _ARG_0_.myHandle)
          if 7 > WorkVec:gety() then
          elseif 7 < WorkVec:gety() then
            _ARG_0_.step = _UPVALUE1_
            Entity.SetTimer(_ARG_0_.myHandle, 240)
          end
          _ARG_0_:TouchMove(0.4)
        elseif _ARG_0_.step == _UPVALUE1_ then
          Entity.ClearSpeed(_ARG_0_.myHandle)
          _ARG_0_:TurnX(0, 1, 180)
          _ARG_0_.targetPos:set(B01RG_CENTER_POS.x, 0, B01RG_CENTER_POS.z)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 2)
          _ARG_0_:TouchMove(0.4)
          if _ARG_0_:WhichRightandLeft() == 1 then
            _ARG_0_:SetMotion(_UPVALUE2_)
          elseif _ARG_0_:WhichRightandLeft() == 2 then
            _ARG_0_:SetMotion(_UPVALUE3_)
          else
            _ARG_0_:SetMotion(_UPVALUE4_)
          end
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_.step = _UPVALUE5_
          end
        elseif _ARG_0_.step == _UPVALUE5_ then
          if _ARG_0_:WhichRightandLeft() == 1 then
            _ARG_0_:SetMotion(_UPVALUE2_)
          elseif _ARG_0_:WhichRightandLeft() == 2 then
            _ARG_0_:SetMotion(_UPVALUE3_)
          else
            _ARG_0_:SetMotion(_UPVALUE4_)
          end
          if 0 > _ARG_0_.Wait2 then
            Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 1)
            _ARG_0_.Wait2 = _UPVALUE6_
          end
          _ARG_0_.Wait2 = _ARG_0_.Wait2 - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
          _ARG_0_:TouchMove(0.4)
          Entity.TurnTargetDegree(_ARG_0_.myHandle, GetRandHandleList(), 2)
          Entity.GetWorldPos(WorkVec, _ARG_0_.myHandle)
          Entity.GetWorldPos(_ARG_0_.targetPos, GetRandHandleList())
          if WorkVec:gety() < 0.5 then
            if _ARG_0_.TauchCnt >= _UPVALUE7_ - 1 then
              _ARG_0_.step = _UPVALUE8_
              Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 0)
              Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
              _ARG_0_:SetMotion(_UPVALUE3_)
            else
              _ARG_0_.TauchCnt = _ARG_0_.TauchCnt + 1
              _ARG_0_.step = _UPVALUE0_
            end
          end
        elseif _ARG_0_.step == _UPVALUE8_ then
          _ARG_0_:TouchStop(0.8, 0.01)
          _ARG_0_:TurnX(0, 1, 180)
          if 0 >= _ARG_0_.Speed then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        end
      end
    },
    Fraimerain = {
      OnBeginState = function(_ARG_0_)
        print("b01rg00:Fraimerain\n")
        Entity.SetTimer(_ARG_0_.myHandle, 80)
        _ARG_0_:SetMotion(_UPVALUE0_)
        _ARG_0_.Speed = 0
        _ARG_0_.step = 0
        _ARG_0_.Wait = 0
        _ARG_0_.AttackCnt = 0
        _ARG_0_:changeNomalParts("AttackIdling")
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      end,
      OnEndState = function(_ARG_0_)
        Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.targetPos:set(B01RG_CENTER_POS.x, 0, B01RG_CENTER_POS.z)
        if _ARG_0_.step == 0 then
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) < 25 then
            WorkVec:set(0, 0, _UPVALUE0_ / ((Entity.CalcDistance(_ARG_0_.myHandle, _ARG_0_.targetPos) + 0.001) / 5))
            Entity.CalcVelocityXZ(_ARG_0_.myHandle, WorkVec)
          else
            WorkVec:set(0, 0, _UPVALUE0_)
            Entity.CalcVelocityXZ(_ARG_0_.myHandle, WorkVec)
          end
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 30)
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) < 4 then
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
            _ARG_0_:SetMotionSetGroup(_UPVALUE2_, 1)
            _ARG_0_.step = 1
            Entity.ClearSpeed(_ARG_0_.myHandle)
          end
        elseif _ARG_0_.step == 1 then
          if 0 > _ARG_0_.Wait then
            _ARG_0_.AttackCnt = _ARG_0_.AttackCnt + 1
            _ARG_0_:CreateFraimeBullet(_ARG_0_.myHandle)
            _ARG_0_.Wait = Script.Random() * 10 + 2
          end
          _ARG_0_.Wait = _ARG_0_.Wait - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
          Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
          _ARG_0_.rot:sety(_ARG_0_.rot:gety() + DegToRad(_ARG_0_.Speed))
          _ARG_0_.Speed = _ARG_0_.Speed + 3 * Entity.GetFrameRate(_ARG_0_.myHandle)
          if _ARG_0_.Speed > _UPVALUE3_ then
            _ARG_0_.Speed = _UPVALUE3_
          end
          Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_.step = 2
            Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
          end
        elseif _ARG_0_.step == 2 then
          Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
          Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
          _ARG_0_.rot:sety(_ARG_0_.rot:gety() + DegToRad(_ARG_0_.Speed))
          _ARG_0_.Speed = _ARG_0_.Speed - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 > _ARG_0_.Speed then
            _ARG_0_.Speed = 0
            _ARG_0_.step = 3
          end
          Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
        elseif _ARG_0_.step == 3 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    OneFraimerain = {
      OnBeginState = function(_ARG_0_)
        print("b01rg00:Fraimerain\n")
        Entity.SetTimer(_ARG_0_.myHandle, 80)
        _ARG_0_:SetMotion(_UPVALUE0_)
        _ARG_0_.Speed = 0
        _ARG_0_.step = 0
        _ARG_0_.Wait = 0
        _ARG_0_.AttackCnt = 0
        _ARG_0_:changeNomalParts("AttackIdling")
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      end,
      OnEndState = function(_ARG_0_)
        Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.targetPos:set(B01RG_CENTER_POS.x, 0, B01RG_CENTER_POS.z)
        if _ARG_0_.step == 0 then
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
          _ARG_0_:SetMotionSetGroup(_UPVALUE1_, 1)
          _ARG_0_.step = 1
          Entity.ClearSpeed(_ARG_0_.myHandle)
        elseif _ARG_0_.step == 1 then
          if 0 > _ARG_0_.Wait then
            _ARG_0_.AttackCnt = _ARG_0_.AttackCnt + 1
            _ARG_0_:CreateFraimeBullet(_ARG_0_.myHandle)
            _ARG_0_.Wait = Script.Random() * 10 + 2
          end
          _ARG_0_.Wait = _ARG_0_.Wait - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
          Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
          _ARG_0_.rot:sety(_ARG_0_.rot:gety() + DegToRad(_ARG_0_.Speed))
          _ARG_0_.Speed = _ARG_0_.Speed + 3 * Entity.GetFrameRate(_ARG_0_.myHandle)
          if _ARG_0_.Speed > _UPVALUE2_ then
            _ARG_0_.Speed = _UPVALUE2_
          end
          Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_.step = 2
            Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
          end
        elseif _ARG_0_.step == 2 then
          Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
          Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
          _ARG_0_.rot:sety(_ARG_0_.rot:gety() + DegToRad(_ARG_0_.Speed))
          _ARG_0_.Speed = _ARG_0_.Speed - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 > _ARG_0_.Speed then
            _ARG_0_.Speed = 0
            _ARG_0_.step = 3
          end
          Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
        elseif _ARG_0_.step == 3 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    UltimaBerserk = {
      OnBeginState = function(_ARG_0_)
        print("b01rg00:UltimaBerserk\n")
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, 300)
        _ARG_0_.step = 0
        _ARG_0_.InviFlag = 1
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, GetRandHandleList(), 180)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      end,
      OnEndState = function(_ARG_0_)
        _ARG_0_.InviFlag = 0
        Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.targetPos:set(B01RG_CENTER_POS.x, 0, B01RG_CENTER_POS.z)
        if _ARG_0_.step == 0 then
          WorkVec:set(0, 0, _UPVALUE0_)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, WorkVec)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 180)
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) < 4 then
            Entity.ClearSpeed(_ARG_0_.myHandle)
          end
          if 0 > _ARG_0_.Wait2 then
            _ARG_0_.Wait2 = _UPVALUE1_
          end
          _ARG_0_.Wait2 = _ARG_0_.Wait2 - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 > _ARG_0_.Wait then
            _ARG_0_:CreateUltimaShot(_ARG_0_.myHandle, 7)
            _ARG_0_.AttackCnt = _ARG_0_.AttackCnt + 1
            _ARG_0_.Wait = Script.Random() * 2 + 1
          end
          _ARG_0_.Wait = _ARG_0_.Wait - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:SetMotion(_UPVALUE2_)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Transform_Move = {
      OnBeginState = function(_ARG_0_)
        print("b01rg00:Transform_Move\n")
        Entity.SetTimer(_ARG_0_.myHandle, 80)
        _ARG_0_:setMotionParts(_UPVALUE0_)
        _ARG_0_.step = 0
        _ARG_0_:changeStep(1)
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:changeStep(1)
        WorkVec:set(0, 0, 0.02)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, WorkVec)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, GetRandHandleList(), 0.5)
        if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
          return
        end
      end
    },
    Transform_Jump = {
      OnBeginState = function(_ARG_0_)
        print("b01rg00:Transform_Jump\n")
        _ARG_0_:changeBobotParts("Transform_Jump")
        Entity.EnableGravity(_ARG_0_.myHandle, 0)
        Entity.EnableGravity(B06RG_HANDLE_ROBOT_RIGHTARM, 0)
        Entity.EnableGravity(B07RG_HANDLE_ROBOT_LEFTARM, 0)
        Entity.EnableGravity(B08RG_HANDLE_ROBOT_FOOT, 0)
        _ARG_0_:setMotionParts(_UPVALUE0_)
        _ARG_0_.step = _UPVALUE1_
        _ARG_0_.Speed = 0.5
        AllEnableLock(0)
        _ARG_0_.noChangeColl = 1
        Entity.SetMovementCollRadius(_ARG_0_.myHandle, 0.5)
        Entity.SetLowerHalf(_ARG_0_.myHandle, 0.7)
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        AllEnableLock(0)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:changeStep(1)
        if _ARG_0_.step == _UPVALUE0_ then
          _ARG_0_.step = _UPVALUE1_
          WorkVec:set(0, _ARG_0_.Speed, 0)
          Entity.SetVelocity(_ARG_0_.myHandle, WorkVec)
        elseif _ARG_0_.step == _UPVALUE1_ then
          if Script.GetCurrentArea() == 3 then
          end
          Entity.GetWorldPos(WorkVec, _ARG_0_.myHandle)
          if 12 < WorkVec:gety() then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.step = _UPVALUE2_
          end
        elseif _ARG_0_.step == _UPVALUE2_ and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Transform_Swing_Punch = {
      OnBeginState = function(_ARG_0_)
        print("b01rg00:Transform_Attack1\n")
        _ARG_0_:setMotionParts(_UPVALUE0_)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:changeStep(1)
        if _ARG_0_.step == 0 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:changeBobotParts("Transform_Idling")
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Transform_Trinity_Charge = {
      OnBeginState = function(_ARG_0_)
        print("b01rg00:Transform_Trinity_Charge\n")
        _ARG_0_:changeBobotParts("Transform_Idling")
        _ARG_0_:setMotionParts(_UPVALUE0_)
        _ARG_0_.step = 0
        _ARG_0_.Speed = 0
        _ARG_0_.AttackCnt = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:changeStep(1)
        if _ARG_0_.step == 0 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, TARGETHANDLELIST[_ARG_0_.AttackCnt], 5)
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_:setMotionParts(_UPVALUE0_)
            _ARG_0_.step = 1
            _ARG_0_.WorkTime = Entity.CalcDistanceSq(_ARG_0_.myHandle, TARGETHANDLELIST[_ARG_0_.AttackCnt]) / _UPVALUE1_
            Entity.SetTimer(_ARG_0_.myHandle, 240)
          end
        elseif _ARG_0_.step == 1 then
          _ARG_0_:Advancement(_UPVALUE2_)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, TARGETHANDLELIST[_ARG_0_.AttackCnt], 2)
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, TARGETHANDLELIST[_ARG_0_.AttackCnt]) < _UPVALUE3_ or Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_:setMotionParts(_UPVALUE4_)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            if _ARG_0_.AttackCnt >= 2 then
              _ARG_0_.step = 3
            else
              _ARG_0_.AttackCnt = _ARG_0_.AttackCnt + 1
              _ARG_0_:setMotionParts(_UPVALUE5_)
              _ARG_0_.step = 0
              _ARG_0_.Speed = 0
            end
          end
        elseif _ARG_0_.step == 3 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:changeBobotParts("Transform_Idling")
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Transform_Trinity_Baster = {
      OnBeginState = function(_ARG_0_)
        print("b01rg00:Transform_Trinity_Baster\n")
        _ARG_0_:changeBobotParts("Transform_Idling")
        _ARG_0_:setMotionParts(_UPVALUE0_)
        _ARG_0_.step = _UPVALUE1_
        _ARG_0_.Speed = 0
        _ARG_0_.Rotation = 1
        _ARG_0_.RotationFlag = 0
        _ARG_0_.RotationCnt = 0
        _ARG_0_.AttackCnt = 0
      end,
      OnEndState = function(_ARG_0_)
        Effect.LoopEnd(_ARG_0_.LightHandle)
        Effect.LoopEnd(_ARG_0_.BasterHandle_End)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:changeStep(1)
        if _ARG_0_.step == _UPVALUE0_ then
          Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
          _ARG_0_.rot:setx(0)
          Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 83 then
            _ARG_0_.step = _UPVALUE1_
            WorkVec:set(0, 2.5, 2.5)
            WorkVec1:set(DegToRad(90), 0, 0)
            _ARG_0_.LightHandle = Entity.AttachEffect(_ARG_0_.myHandle, "b01rg00", "B024_TRB_LSR0_0", "Root", WorkVec, WorkVec1)
            Enemy.SetGeneralPurposeAttackColl(_ARG_0_.myHandle, COLL_KIND_ENEMY, COLL_SHAPE_CYLINDER, 2.5)
            Enemy.SetGeneralPurposeAttackCollParam(_ARG_0_.myHandle, Enemy.GetAttackKind(_ARG_0_.myHandle, 3), Enemy.GetAttackAttr(_ARG_0_.myHandle, 3), Enemy.GetAttackPoint(_ARG_0_.myHandle, 3), Enemy.GetAttackPowerCorrection(_ARG_0_.myHandle, 3))
            Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 0)
            Enemy.SetGeneralPurposeAttackCollHitAttackEffectName(_ARG_0_.myHandle, "b01rg00", "B024_HIT_LSR0_0")
            _ARG_0_.BasterHandle_End = Entity.SetEffect(_ARG_0_.myHandle, "b01rg00", "B024_TRB_LSR1_0", WorkVec, WorkVec1)
          end
        elseif _ARG_0_.step == _UPVALUE1_ then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_.step = _UPVALUE2_
            Entity.SetTimer(_ARG_0_.myHandle, 60)
          end
        elseif _ARG_0_.step == _UPVALUE2_ then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_.step = _UPVALUE3_
          end
        elseif _ARG_0_.step == _UPVALUE3_ then
          if 0 > _ARG_0_.Wait then
            Enemy.EnableGeneralPurposeUpdate(_ARG_0_.myHandle)
            _ARG_0_.Wait = _UPVALUE4_
          end
          _ARG_0_.Wait = _ARG_0_.Wait - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
          Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
          _ARG_0_.rot:sety(_ARG_0_.rot:gety() + DegToRad(_ARG_0_.Speed) * Entity.GetFrameRate(_ARG_0_.myHandle))
          if _ARG_0_.RotationFlag == 0 then
            _ARG_0_.Speed = _ARG_0_.Speed + 0.05 * Entity.GetFrameRate(_ARG_0_.myHandle)
          elseif _ARG_0_.RotationFlag == 1 then
            _ARG_0_.Speed = _ARG_0_.Speed - 0.05 * Entity.GetFrameRate(_ARG_0_.myHandle)
          end
          _ARG_0_.RotationCnt = _ARG_0_.RotationCnt + _ARG_0_.Speed * Entity.GetFrameRate(_ARG_0_.myHandle)
          if _ARG_0_.Speed > _UPVALUE5_ then
            _ARG_0_.Speed = _UPVALUE5_
          end
          if _ARG_0_.Speed < -_UPVALUE5_ then
            _ARG_0_.Speed = -_UPVALUE5_
          end
          if _ARG_0_.RotationCnt > 360 and _ARG_0_.RotationFlag == 0 then
            _ARG_0_.RotationFlag = 1
            _ARG_0_.AttackCnt = _ARG_0_.AttackCnt + 1
          end
          if 0 > _ARG_0_.RotationCnt and _ARG_0_.RotationFlag == 1 then
            print(_ARG_0_.AttackCnt .. "\n")
            _ARG_0_.RotationFlag = 0
            _ARG_0_.AttackCnt = _ARG_0_.AttackCnt + 1
          end
          Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
          if 3 <= _ARG_0_.AttackCnt then
            Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 0)
            Effect.LoopEnd(_ARG_0_.LightHandle)
            Effect.LoopEnd(_ARG_0_.BasterHandle_End)
            _ARG_0_.LightHandle = NULL_HANDLE
            _ARG_0_:setMotionParts(_UPVALUE6_)
            _ARG_0_.step = _UPVALUE7_
          end
        elseif _ARG_0_.step == _UPVALUE7_ and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:changeBobotParts("Transform_Idling")
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
        if Effect.IsAlive(_ARG_0_.LightHandle) then
          WorkVec1:set(0, 2.5, 2.6)
          Entity.GetWorldPos2(WorkVec, _ARG_0_.myHandle, WorkVec1)
          WorkVec1:set(0, 2.5, 30)
          Entity.GetWorldPos2(WorkVec1, _ARG_0_.myHandle, WorkVec1)
          Collision.IntersectRayBg(WorkVec1, COLL_KIND_ENEMY, WorkVec, WorkVec1)
          Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
          Effect.UpdateCoord(_ARG_0_.BasterHandle_End, WorkVec1, _ARG_0_.rot)
          Enemy.SetGeneralPurposeAttackCollPos(_ARG_0_.myHandle, WorkVec, WorkVec1)
          FVECTOR3.Sub(workVec1, WorkVec1, WorkVec)
          workVec:set(1, workVec1:length() / 20, 1)
          Effect.SetScale(_ARG_0_.LightHandle, workVec)
          Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 1)
        end
      end
    },
    Transform_Ssatellaite_Baster = {
      OnBeginState = function(_ARG_0_)
        print("b01rg00:Transform_Ssatellaite_Baster\n")
        _ARG_0_:setMotionParts(_UPVALUE0_)
        _ARG_0_.step = _UPVALUE1_
        _ARG_0_.AttackCnt = 0
        _ARG_0_.Wait = 0
        _ARG_0_.sateNumber = _UPVALUE2_ + Script.Random() * _UPVALUE3_
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        AllEnableLock(1)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:changeStep(1)
        if _ARG_0_.step == _UPVALUE0_ then
          _ARG_0_.step = _UPVALUE1_
        elseif _ARG_0_.step == _UPVALUE1_ then
          if _ARG_0_.Wait < 0 then
            if _ARG_0_.AttackCnt >= _ARG_0_.sateNumber then
              _ARG_0_.step = _UPVALUE2_
            else
              WorkVec:set(B01RG_CENTER_POS.x, 0, B01RG_CENTER_POS.z)
              WorkVec:setx(WorkVec:getx() + Script.Random() * 12 * Math.Cos((RoundPI(Script.Random() * 2 * PI))))
              WorkVec:sety(0.008)
              WorkVec:setz(WorkVec:getz() + Script.Random() * 12 * Math.Sin((RoundPI(Script.Random() * 2 * PI))))
              WorkVec1:set(0, 0, 0)
              Bullet.SetCollision(Bullet.CreateBullet("Satellaite", WorkVec, WorkVec1), COLL_KIND_ENEMY, COLL_SHAPE_CYLINDER, 3, 20, _ARG_0_.myHandle)
              Entity.SetLowerHalf(Bullet.CreateBullet("Satellaite", WorkVec, WorkVec1), 20)
              Bullet.EnableAttackCollision(Bullet.CreateBullet("Satellaite", WorkVec, WorkVec1), 0)
              SetBulletAttackParam(Bullet.CreateBullet("Satellaite", WorkVec, WorkVec1), _ARG_0_.myHandle, 21)
              Entity.SetTimer(Bullet.CreateBullet("Satellaite", WorkVec, WorkVec1), _UPVALUE3_)
              _ARG_0_.Wait = 120
              _ARG_0_.AttackCnt = _ARG_0_.AttackCnt + 1
            end
          end
          _ARG_0_.Wait = _ARG_0_.Wait - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        elseif _ARG_0_.step == B01RG_SATELLAITE_BASTER_STEP_ROTATION then
        elseif _ARG_0_.step == _UPVALUE2_ and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Transform_Bic_Diveng = {
      OnBeginState = function(_ARG_0_)
        print("b01rg00:Transform_Bic_Diveng\n")
        _ARG_0_.step = 0
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        Entity.EnableGravity(B06RG_HANDLE_ROBOT_RIGHTARM, 1)
        Entity.EnableGravity(B07RG_HANDLE_ROBOT_LEFTARM, 1)
        Entity.EnableGravity(B08RG_HANDLE_ROBOT_FOOT, 1)
        Entity.SetMovementCollRadius(_ARG_0_.myHandle, 6)
        Entity.SetLowerHalf(_ARG_0_.myHandle, 6.5)
        _ARG_0_.noChangeColl = 0
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:changeStep(1)
        if _ARG_0_.step == 0 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:setMotionParts(_UPVALUE0_)
            Entity.EnableGravity(_ARG_0_.myHandle, 1)
            Entity.EnableGravity(B06RG_HANDLE_ROBOT_RIGHTARM, 1)
            Entity.EnableGravity(B07RG_HANDLE_ROBOT_LEFTARM, 1)
            Entity.EnableGravity(B08RG_HANDLE_ROBOT_FOOT, 1)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if Entity.IsGround(_ARG_0_.myHandle) then
            _ARG_0_:setMotionParts(_UPVALUE1_)
            _ARG_0_.step = 2
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE2_)
            Entity.SetMovementCollRadius(_ARG_0_.myHandle, 6)
            Entity.SetLowerHalf(_ARG_0_.myHandle, 6.5)
            _ARG_0_.noChangeColl = 0
          end
        elseif _ARG_0_.step == 2 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_.step = 3
          end
        elseif _ARG_0_.step == 3 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:changeBobotParts("Transform_Idling")
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Transform_Hexa_Cannon = {
      OnBeginState = function(_ARG_0_)
        print("b01rg00:Transform_Hexa_Cannon\n")
        _ARG_0_:setMotionParts(_UPVALUE0_)
        _ARG_0_.step = 0
        _ARG_0_.Wait = 92
        _ARG_0_.AttackCnt = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:changeStep(1)
        if _ARG_0_.step == 0 then
          if _ARG_0_.AttackCnt <= 2 and 0 > _ARG_0_.Wait then
            _ARG_0_:CreateHexaBullet(_ARG_0_.myHandle, _ARG_0_.AttackCnt)
            _ARG_0_.AttackCnt = _ARG_0_.AttackCnt + 1
            if _ARG_0_.AttackCnt == 1 then
              _ARG_0_.Wait = 24
            elseif _ARG_0_.AttackCnt == 2 then
              _ARG_0_.Wait = 24
            elseif _ARG_0_.AttackCnt == 3 then
            end
          end
          _ARG_0_.Wait = _ARG_0_.Wait - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_:changeBobotParts("Transform_Idling")
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        end
      end
    },
    Transform_Knckle_walk_atttack = {
      OnBeginState = function(_ARG_0_)
        print("b01rg00:Transform_Knckle_walk_atttack\n")
        _ARG_0_:changeBobotParts("Transform_Idling")
        _ARG_0_:setMotionParts(_UPVALUE0_)
        _ARG_0_.step = 0
        B01RG_MODE = B01RG_ROBOT_MODE
        Entity.SetTimer(_ARG_0_.myHandle, 240)
        Entity.EnableGravity(B06RG_HANDLE_ROBOT_RIGHTARM, 1)
        Entity.EnableGravity(B07RG_HANDLE_ROBOT_LEFTARM, 1)
        Entity.EnableGravity(B04RG_HANDLE_NOMAL_ARM, 0)
        _ARG_0_.Speed = 0
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:changeStep(1)
        if _ARG_0_.step == 0 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 36 then
            _ARG_0_:Advancement(_UPVALUE0_)
            Entity.TurnTargetYDegree(_ARG_0_.myHandle, GetRandHandleList(), 5)
          end
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:setMotionParts(_UPVALUE1_)
            _ARG_0_.step = 2
            Entity.ClearSpeed(_ARG_0_.myHandle)
          end
        elseif _ARG_0_.step == 1 then
        elseif _ARG_0_.step == 2 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:changeBobotParts("Transform_Idling")
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Transform_Summer_salt = {
      OnBeginState = function(_ARG_0_)
        print("b01rg00:Transform_Summer_salt\n")
        _ARG_0_:setMotionParts(_UPVALUE0_)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:changeStep(1)
        if _ARG_0_.step == 0 and Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10) == false then
          _ARG_0_.step = 1
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:changeBobotParts("Transform_Idling")
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Transform_Idling = {
      OnBeginState = function(_ARG_0_)
        print("b01rg00:Transform_Idling\n")
        _ARG_0_:setMotionParts(_UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:changeStep(1)
        if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
          return
        end
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      end
    },
    Transform_MapSenterMove = {
      OnBeginState = function(_ARG_0_)
        print("b01rg00:Transform_MapSenterMove\n")
        _ARG_0_:setMotionParts(_UPVALUE0_)
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:changeStep(1)
        WorkVec:set(0, 0, 0.05)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, WorkVec)
        WorkVec:set(B01RG_CENTER_POS.x, B01RG_CENTER_POS.y, B01RG_CENTER_POS.z)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, WorkVec, 1.5)
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, WorkVec) < 4 then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    TransformOut_Idling = {
      OnBeginState = function(_ARG_0_)
        print("b01rg00:TransformOut_Idling\n")
        _ARG_0_:SetMotion(_UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, 240)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
          return
        end
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      end
    },
    Transform_Start = {
      OnBeginState = function(_ARG_0_)
        print("b01rg00:Transform_Start\n")
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
          _ARG_0_:changeRobotParts()
        elseif _ARG_0_.step == TRINITY_TRANSFORM_CHANGE and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Transform_Start_End")
        end
      end
    },
    Transform_Start_End = {
      OnBeginState = function(_ARG_0_)
        print("b01rg00:Transform_Start_End\n")
        TRINITY_TRANSFORM_STEP = TRINITY_TRANSFORM_START
        _ARG_0_.step = TRINITY_TRANSFORM_START
      end,
      OnEndState = function(_ARG_0_)
        B01RG_MODE = B01RG_ROBOT_MODE
      end,
      OnUpdate = function(_ARG_0_)
        WorkVec:set(0, 0, 0)
        if _ARG_0_.step == TRINITY_TRANSFORM_START then
          _ARG_0_:SetMotion(_UPVALUE0_)
          _ARG_0_.step = TRINITY_TRANSFORM_CHANGE
        elseif _ARG_0_.step == TRINITY_TRANSFORM_CHANGE and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:changeStep(1)
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          _ARG_0_:changeBobotParts("Transform_Idling")
        end
      end
    },
    Transform_Out = {
      OnBeginState = function(_ARG_0_)
        print("b01rg00:Transform_Out\n")
        TRINITY_TRANSFORM_STEP = TRINITY_TRANSFORM_OUT
        _ARG_0_.step = TRINITY_TRANSFORM_OUT
        B01RG_MODE = B01RG_NOMAL_MODE
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        WorkVec:set(0, 0, 0)
        if _ARG_0_.step == TRINITY_TRANSFORM_OUT then
          _ARG_0_:SetMotion(_UPVALUE0_)
          _ARG_0_.step = TRINITY_TRANSFORM_CHANGE
          _ARG_0_:changeBobotParts("Transform_Out")
        elseif _ARG_0_.step == TRINITY_TRANSFORM_CHANGE and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Transform_Out_End")
        end
      end
    },
    Transform_Out_End = {
      OnBeginState = function(_ARG_0_)
        changeSet(_ARG_0_, B04RG_HANDLE_NOMAL_ARM, 1)
        changeSet(_ARG_0_, B05RG_HANDLE_NOMAL_FOOT, 1)
        changeSet(_ARG_0_, B06RG_HANDLE_ROBOT_RIGHTARM, 0)
        changeSet(_ARG_0_, B07RG_HANDLE_ROBOT_LEFTARM, 0)
        changeSet(_ARG_0_, B08RG_HANDLE_ROBOT_FOOT, 0)
        print("b01rg00:Transform_Out_End\n")
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
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    Damage = {
      OnBeginState = function(_ARG_0_)
        print("b01rg00:Damage\n")
        if Enemy.IsAttackerFront(_ARG_0_.myHandle) == true then
          _ARG_0_:setMotionParts(_UPVALUE0_)
          _ARG_0_.step = 0
        else
          _ARG_0_:setMotionParts(_UPVALUE1_)
          _ARG_0_.step = 2
        end
        _ARG_0_:changeStep(1)
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_:setMotionParts(_UPVALUE0_)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_:changeBobotParts("Transform_Idling")
          end
        elseif _ARG_0_.step == 2 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_:setMotionParts(_UPVALUE1_)
            _ARG_0_.step = 3
          end
        elseif _ARG_0_.step == 3 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:changeBobotParts("Transform_Idling")
        end
      end
    },
    StandbyArena = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        Entity.SetAlpha(_ARG_0_.myHandle, 0)
        if Mission.IsFlagFinalRound() == 1 then
          _ARG_0_.step = 0
        else
          SetupAppearBegin2(_ARG_0_.myHandle, -1, _UPVALUE0_, 1)
          _ARG_0_.step = 1
        end
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
        SetupAppearEnd(_ARG_0_.myHandle)
        Entity.SetAlpha(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        _ARG_0_:setAllTargetHandleList(_ARG_0_.targetHandle)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
        changeSet(_ARG_0_, B04RG_HANDLE_NOMAL_ARM, 0)
        changeSet(_ARG_0_, B05RG_HANDLE_NOMAL_FOOT, 0)
        if _ARG_0_.step == 0 then
          if Exusia.IsExistenceSchedule() then
            SetupAppearBegin2(_ARG_0_.myHandle, -1, _UPVALUE0_, 1)
            _ARG_0_.step = 1
          end
        elseif Enemy.IsAllEnemyWaiting() == false then
          _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
          _ARG_0_:setAllTargetHandleList(_ARG_0_.targetHandle)
          _ARG_0_:GotoState("StateSettingA1")
        end
      end
    },
    Standby = {
      OnBeginState = function(_ARG_0_)
        print("b01rg00:Standby\n")
        _ARG_0_:SetMotion(_UPVALUE0_)
        _ARG_0_.step = 1
        if Entity.GetName(_ARG_0_.myHandle) == "b71vs00" and Mission.IsFlagFinalRound() == 1 then
          WorkVec:set(0, 0, 0)
          Entity.SetLocalPos(_ARG_0_.myHandle, WorkVec)
          _ARG_0_.step = 0
          Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 1)
        end
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableLockon(_ARG_0_.myHandle, 1)
        Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, 1)
      end,
      OnUpdate = function(_ARG_0_)
        changeSet(_ARG_0_, B04RG_HANDLE_NOMAL_ARM, 0)
        changeSet(_ARG_0_, B05RG_HANDLE_NOMAL_FOOT, 0)
        if Entity.GetName(_ARG_0_.myHandle) == "b71vs00" and Mission.IsFlagFinalRound() == 1 then
          if _ARG_0_.step == 0 then
            if Exusia.IsExistenceSchedule() == true then
              _ARG_0_.step = 1
              Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, 1)
            else
            end
          elseif _ARG_0_.step == 1 then
          end
        end
        if Enemy.IsAllEnemyWaiting() == false then
          _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
          if Entity.GetName(_ARG_0_.myHandle) == "b01rg00" then
            if Entity.GetName((Player.GetHandle())) == "p01ex00" then
              print("\131v\131\140\131C\131\132\129[\129@\131\148\131F\131\147\131g\131D\131X\n")
              TARGETHANDLELIST[0] = Player.GetHandle()
              TARGETHANDLELIST[1] = Enemy.SearchEnemy(_ARG_0_.myHandle, "b79ex00", SEARCH_TYPE_NEAR)
              TARGETHANDLELIST[2] = Enemy.SearchEnemy(_ARG_0_.myHandle, "b89ex00", SEARCH_TYPE_NEAR)
            elseif Entity.GetName((Player.GetHandle())) == "p02ex00" then
              print("\131v\131\140\131C\131\132\129[\129@\131A\131N\131A\n")
              TARGETHANDLELIST[0] = Player.GetHandle()
              TARGETHANDLELIST[1] = Enemy.SearchEnemy(_ARG_0_.myHandle, "b69ex00", SEARCH_TYPE_NEAR)
              TARGETHANDLELIST[2] = Enemy.SearchEnemy(_ARG_0_.myHandle, "b79ex00", SEARCH_TYPE_NEAR)
            elseif Entity.GetName((Player.GetHandle())) == "p03ex00" then
              print("\131v\131\140\131C\131\132\129[\129@\131e\131\137\n")
              TARGETHANDLELIST[0] = Player.GetHandle()
              TARGETHANDLELIST[1] = Enemy.SearchEnemy(_ARG_0_.myHandle, "b61ex00", SEARCH_TYPE_NEAR)
              TARGETHANDLELIST[2] = Enemy.SearchEnemy(_ARG_0_.myHandle, "b82ex00", SEARCH_TYPE_NEAR)
            else
              _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
              _ARG_0_:setAllTargetHandleList(_ARG_0_.targetHandle)
            end
            if TARGETHANDLELIST[1] == NULL_HANDLE then
              TARGETHANDLELIST[1] = Player.GetHandle()
            end
            if TARGETHANDLELIST[2] == NULL_HANDLE then
              TARGETHANDLELIST[2] = Player.GetHandle()
            end
          else
            _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
            _ARG_0_:setAllTargetHandleList(_ARG_0_.targetHandle)
            Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
          end
          _ARG_0_:GotoState("StateSettingA1")
          Entity.EnableLockon(_ARG_0_.myHandle, 1)
        end
      end
    },
    Dead = {
      OnBeginState = function(_ARG_0_)
        Entity.EnableLockon(_ARG_0_.myHandle, 0)
        Effect.LoopEnd(_ARG_0_.LightHandle)
        Effect.LoopEnd(_ARG_0_.BasterHandle_End)
        _ARG_0_.BasterHandle_End = NULL_HANDLE
        _ARG_0_.LightHandle = NULL_HANDLE
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
      end
    },
    Deadarena = {
      OnBeginState = function(_ARG_0_)
        print("Deadarena\n")
        Entity.EnableLockon(_ARG_0_.myHandle, 0)
        Effect.LoopEnd(_ARG_0_.LightHandle)
        Effect.LoopEnd(_ARG_0_.BasterHandle_End)
        _ARG_0_.BasterHandle_End = NULL_HANDLE
        _ARG_0_.LightHandle = NULL_HANDLE
        if Mission.IsFlagFinalRound() == 1 then
        else
          Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 120)
        end
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Mission.IsFlagFinalRound() == 1 then
        elseif Entity.IsModelFade(_ARG_0_.myHandle) == false then
          Enemy.Dead(_ARG_0_.myHandle)
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
  SetMotionSetGroup = function(_ARG_0_, _ARG_1_, _ARG_2_)
    Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_1_, _ARG_2_)
  end,
  controlParts = function(_ARG_0_)
  end,
  CheckHP = function(_ARG_0_)
    if Enemy.GetHp(_ARG_0_.myHandle) < Enemy.GetHpMax(_ARG_0_.myHandle) * 0.5 then
      return 1
    end
    return 0
  end,
  Rotation = function(_ARG_0_, _ARG_1_)
    if Entity.GetMotionNowFrame(_ARG_0_.myHandle) - Entity.GetMotionOldFrame(_ARG_0_.myHandle) < 0 then
    else
    end
    Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
    _ARG_0_.rot:sety(RoundPI(_ARG_0_.rot:gety() + DegToRad((Entity.GetMotionNowFrame(_ARG_0_.myHandle) - Entity.GetMotionOldFrame(_ARG_0_.myHandle)) * (90 / Entity.GetMotionTotalFrame(_ARG_0_.myHandle))) * _ARG_1_))
    Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
    return DegToRad((Entity.GetMotionNowFrame(_ARG_0_.myHandle) - Entity.GetMotionOldFrame(_ARG_0_.myHandle)) * (90 / Entity.GetMotionTotalFrame(_ARG_0_.myHandle))) * _ARG_1_
  end,
  Advancement = function(_ARG_0_, _ARG_1_)
    _ARG_0_.Speed = _ARG_0_.Speed + _ARG_1_ * 0.1 / 2 * Entity.GetFrameRate(_ARG_0_.myHandle)
    if _ARG_1_ < _ARG_0_.Speed then
      _ARG_0_.Speed = _ARG_1_
    end
    FVECTOR3.set(WorkVec, 0, 0, _ARG_0_.Speed)
    Entity.CalcVelocityXZ(_ARG_0_.myHandle, WorkVec)
  end,
  TouchMove = function(_ARG_0_, _ARG_1_)
    _ARG_0_.Speed = _ARG_0_.Speed + _ARG_1_ * 0.1 / 2 * Entity.GetFrameRate(_ARG_0_.myHandle)
    if _ARG_1_ < _ARG_0_.Speed then
      _ARG_0_.Speed = _ARG_1_
    end
    Entity.CalcVelocity(_ARG_0_.myHandle, _ARG_0_.Speed)
  end,
  TurnX = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    Entity.GetRot(WorkVec, _ARG_0_.myHandle)
    WorkVec:setx(HomingDegree(WorkVec:getx(), _ARG_1_, _ARG_2_, Entity.GetFrameRate(_ARG_0_.myHandle)))
    if WorkVec:getx() < DegToRad(-_ARG_3_) then
      WorkVec:setx(DegToRad(-_ARG_3_))
    end
    if WorkVec:getx() > DegToRad(_ARG_3_) then
      WorkVec:setx(DegToRad(_ARG_3_))
    end
    Entity.SetRot(_ARG_0_.myHandle, WorkVec)
    return HomingDegree(WorkVec:getx(), _ARG_1_, _ARG_2_, Entity.GetFrameRate(_ARG_0_.myHandle))
  end,
  TouchStop = function(_ARG_0_, _ARG_1_, _ARG_2_)
    _ARG_0_.Speed = _ARG_0_.Speed - _ARG_1_ * _ARG_2_ * Entity.GetFrameRate(_ARG_0_.myHandle)
    if _ARG_0_.Speed < 0 then
      _ARG_0_.Speed = 0
    end
    FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Speed)
    Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
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
  setAllTargetHandleList = function(_ARG_0_, _ARG_1_)
    TARGETHANDLELIST[0] = _ARG_1_
    TARGETHANDLELIST[1] = _ARG_1_
    TARGETHANDLELIST[2] = _ARG_1_
  end,
  CreateHexaBullet = function(_ARG_0_, _ARG_1_, _ARG_2_)
    WorkVec1:set(0, 8.8, -0.6)
    Entity.GetWorldPos2(WorkVec, _ARG_1_, WorkVec1)
    Entity.GetRot(workVec1, _ARG_0_.myHandle)
    Bullet.CreateEffectBullet(Bullet.CreateBullet("HexaCannon", WorkVec, workVec1), "b01rg00", "B024_HXC_BLT0_0")
    if Enemy.IsConfuse(_ARG_0_.myHandle) then
      Bullet.SetCollision(Bullet.CreateBullet("HexaCannon", WorkVec, workVec1), COLL_KIND_NO_CHECK, COLL_SHAPE_SPHERE, 0.5, 0, _ARG_1_)
    else
      Bullet.SetCollision(Bullet.CreateBullet("HexaCannon", WorkVec, workVec1), COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, 0.5, 0, _ARG_1_)
    end
    SetBulletAttackParam(Bullet.CreateBullet("HexaCannon", WorkVec, workVec1), _ARG_0_.myHandle, 1)
    Bullet.SetHitAttackEffectName(Bullet.CreateBullet("HexaCannon", WorkVec, workVec1), "b01rg00", "B024_HIT_LSR1_0")
    WorkVec:set(0, 0.9, 0)
    Entity.SetVelocity(Bullet.CreateBullet("HexaCannon", WorkVec, workVec1), WorkVec)
    Bullet.SetMaxMoveDist(Bullet.CreateBullet("HexaCannon", WorkVec, workVec1), 900)
    EntityManager:GetEntity((Bullet.CreateBullet("HexaCannon", WorkVec, workVec1))).targetHandle = TARGETHANDLELIST[_ARG_2_]
  end,
  CreateFraimeBullet = function(_ARG_0_, _ARG_1_, _ARG_2_)
    WorkVec:set(0, 2.5, 1.5)
    Entity.GetWorldPos2(WorkVec, _ARG_1_, WorkVec)
    Entity.GetRot(WorkVec1, _ARG_0_.myHandle)
    Bullet.CreateEffectBullet(Bullet.CreateBullet("Fraimeb", WorkVec, WorkVec1), "b01rg00", "B024_FRR_BLT0_0")
    if Enemy.IsConfuse(_ARG_0_.myHandle) then
      Bullet.SetCollision(Bullet.CreateBullet("Fraimeb", WorkVec, WorkVec1), COLL_KIND_NO_CHECK, COLL_SHAPE_SPHERE, 0.7, 0, _ARG_1_)
    else
      Bullet.SetCollision(Bullet.CreateBullet("Fraimeb", WorkVec, WorkVec1), COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, 0.7, 0, _ARG_1_)
    end
    SetBulletAttackParam(Bullet.CreateBullet("Fraimeb", WorkVec, WorkVec1), _ARG_0_.myHandle, 11)
    Bullet.SetHitAttackEffectName(Bullet.CreateBullet("Fraimeb", WorkVec, WorkVec1), "b01rg00", "B024_HIT_FRR0_0")
    WorkVec:set(0, 3, Script.Random() * 1.3 + 0.3)
    Math.RotateVectorXYZ(WorkVec, WorkVec1)
    WorkVec:scale(Script.Random() * 0.3)
    Entity.SetVelocity(Bullet.CreateBullet("Fraimeb", WorkVec, WorkVec1), WorkVec)
    Bullet.SetMaxMoveDist(Bullet.CreateBullet("Fraimeb", WorkVec, WorkVec1), 900)
    EntityManager:GetEntity((Bullet.CreateBullet("Fraimeb", WorkVec, WorkVec1))).owner = _ARG_0_.myHandle
  end,
  CreateUltimaShot = function(_ARG_0_, _ARG_1_, _ARG_2_)
    WorkVec:set(0, -2, 0)
    Entity.GetWorldPos2(WorkVec1, _ARG_1_, WorkVec, 7)
    if Enemy.IsNetworkMaster(_ARG_0_.myHandle) == false then
      Entity.GetWorldPos(WorkVec, TARGETHANDLELIST[0], 2)
    else
      Entity.GetWorldPos(WorkVec, GetRandHandleList(), 2)
    end
    FVECTOR3.Sub(workVec, WorkVec, WorkVec1)
    FVECTOR3.normalize(workVec)
    WorkVec:set(0, -2, 0)
    Entity.GetWorldPos2(WorkVec, _ARG_1_, WorkVec, 7)
    Entity.GetWorldPos(WorkVec1, _ARG_1_, 7)
    FVECTOR3.Sub(workVec, WorkVec, WorkVec1)
    FVECTOR3.normalize(workVec)
    workVec1:set(-Math.Atan2(workVec:gety(), Math.Sqrt(workVec:getz() * workVec:getz() + workVec:getx() * workVec:getx())), Math.Atan2(workVec:getx(), workVec:getz()), 0)
    WorkVec:set(0, -2, 0)
    Entity.GetWorldPos2(WorkVec, _ARG_1_, WorkVec, 7)
    Bullet.CreateEffectBullet(Bullet.CreateBullet("", WorkVec, workVec1), "b01rg00", "B024_ULB_BLT0_0")
    if Enemy.IsConfuse(_ARG_0_.myHandle) then
      Bullet.SetCollision(Bullet.CreateBullet("", WorkVec, workVec1), COLL_KIND_NO_CHECK, COLL_SHAPE_SPHERE, 0.5, 0, _ARG_1_)
    else
      Bullet.SetCollision(Bullet.CreateBullet("", WorkVec, workVec1), COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, 0.5, 0, _ARG_1_)
    end
    SetBulletAttackParam(Bullet.CreateBullet("", WorkVec, workVec1), _ARG_0_.myHandle, 17)
    Bullet.SetHitAttackEffectName(Bullet.CreateBullet("", WorkVec, workVec1), "b01rg00", "B024_HIT_BEM0_0")
    Bullet.SetHitBgEffectName(Bullet.CreateBullet("", WorkVec, workVec1), "b01rg00", "B024_HIT_BEM1_0")
    Bullet.EnableReflect(Bullet.CreateBullet("", WorkVec, workVec1), Enemy.GetAttackReflect(_ARG_0_.myHandle, 0))
    Entity.CalcVelocity(Bullet.CreateBullet("", WorkVec, workVec1), 0.25)
    Bullet.SetMaxMoveDist(Bullet.CreateBullet("", WorkVec, workVec1), 225)
  end,
  RandomMove = function(_ARG_0_)
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
      _ARG_0_.WorkVec:set(B01RG_CENTER_POS.x, 0, B01RG_CENTER_POS.z)
      if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.WorkVec) < 25 then
        if _ARG_0_:WhichRightandLeft() == 1 then
          _ARG_0_.wanderAng = -10
        else
          _ARG_0_.wanderAng = 10
        end
        Entity.GetRot(_ARG_0_.WorkVec, _ARG_0_.myHandle)
        _ARG_0_.WorkVec:sety(_ARG_0_.WorkVec:gety() + DegToRad(_ARG_0_.wanderAng))
        Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.WorkVec)
      end
      if Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.IsWall(_ARG_0_.myHandle) or 4 > Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetPos) then
        _ARG_0_.count = _ARG_0_.count + 1
        if _ARG_0_.count > _ARG_0_.changeCount then
          _ARG_0_.WorkVec:set(B01RG_CENTER_POS.x, 0, B01RG_CENTER_POS.z)
          if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.WorkVec) < 25 then
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
  end,
  changeStep = function(_ARG_0_, _ARG_1_)
    if Entity.IsAlive(B04RG_HANDLE_NOMAL_ARM) then
      EntityManager:GetEntity(B04RG_HANDLE_NOMAL_ARM).step = _ARG_1_
    end
    if Entity.IsAlive(B05RG_HANDLE_NOMAL_FOOT) then
      EntityManager:GetEntity(B05RG_HANDLE_NOMAL_FOOT).step = _ARG_1_
    end
    if Entity.IsAlive(B06RG_HANDLE_ROBOT_RIGHTARM) then
      EntityManager:GetEntity(B06RG_HANDLE_ROBOT_RIGHTARM).step = _ARG_1_
    end
    if Entity.IsAlive(B07RG_HANDLE_ROBOT_LEFTARM) then
      EntityManager:GetEntity(B07RG_HANDLE_ROBOT_LEFTARM).step = _ARG_1_
    end
    if Entity.IsAlive(B08RG_HANDLE_ROBOT_FOOT) then
      EntityManager:GetEntity(B08RG_HANDLE_ROBOT_FOOT).step = _ARG_1_
    end
  end,
  chackBetaAlive = function(_ARG_0_)
    if Entity.IsAlive(B04RG_HANDLE_NOMAL_ARM) and Entity.IsAlive(B07RG_HANDLE_ROBOT_LEFTARM) and Entity.IsAlive(B06RG_HANDLE_ROBOT_RIGHTARM) then
      return 1
    end
    B01RG_PARTS_BETFA_ALIVE = 0
    return 1
  end,
  chackGanmaAlive = function(_ARG_0_)
    if Entity.IsAlive(B05RG_HANDLE_NOMAL_FOOT) and Entity.IsAlive(B08RG_HANDLE_ROBOT_FOOT) then
      return 1
    end
    B01RG_PARTS_GANMA_ALIVE = 0
    return 1
  end,
  chackAlive = function(_ARG_0_)
    if _ARG_0_:GetState() ~= "Transform_Jump" and _ARG_0_:GetState() ~= "Transform_Ssatellaite_Baster" and _ARG_0_:GetState() ~= "Transform_Bic_Diveng" then
      Entity.EnableGravity(_ARG_0_.myHandle, 1)
      Entity.GetWorldPos(WorkVec1, _ARG_0_.myHandle)
      if WorkVec1:gety() > 6 and _ARG_0_:GetState() ~= "TouchAndGo" then
        _ARG_0_.stack:clear()
        _ARG_0_.stack:push("StateSettingFinal")
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      end
    end
    if _ARG_0_:GetState() == "Standby" or _ARG_0_:GetState() == "Appear" or Enemy.IsAllEnemyWaiting() == true then
      return
    end
    if _ARG_0_:chackBetaAlive() == 1 and _ARG_0_:chackGanmaAlive() == 1 then
      if B01RG_PARTS_ALIVE == B01RG_ALIVE_ALL then
        B01RG_PARTS_ALIVE = B01RG_ALIVE_ALL
      else
        B01RG_PARTS_ALIVE = B01RG_ALIVE_ALL
      end
    elseif _ARG_0_:chackBetaAlive() == 1 and _ARG_0_:chackGanmaAlive() == 0 then
      if B01RG_PARTS_ALIVE == B01RG_ALIVE_NO_GANMA then
        B01RG_PARTS_ALIVE = B01RG_ALIVE_NO_GANMA
      else
        B01RG_PARTS_ALIVE = B01RG_ALIVE_NO_GANMA
        print("\130\170\130\241\130\220\130\170\130\181\130\241\130\190\129I\n")
        if B01RG_MODE == B01RG_ROBOT_MODE then
          _ARG_0_.stack:clear()
          _ARG_0_.stack:push("StateSettingB2")
          _ARG_0_.stack:push("Idling")
          _ARG_0_.stack:push("TransformOut_Idling")
          _ARG_0_.stack:push("Transform_Out")
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        else
          _ARG_0_.stack:clear()
          _ARG_0_.stack:push("StateSettingB3")
        end
      end
    elseif _ARG_0_:chackBetaAlive() == 0 and _ARG_0_:chackGanmaAlive() == 1 then
      if B01RG_PARTS_ALIVE == B01RG_ALIVE_NO_BETA then
        B01RG_PARTS_ALIVE = B01RG_ALIVE_NO_BETA
      else
        B01RG_PARTS_ALIVE = B01RG_ALIVE_NO_BETA
        print("\130\215\129[\130\189\130\170\130\181\130\241\130\190\129I\n")
        if B01RG_MODE == B01RG_ROBOT_MODE then
          _ARG_0_.stack:clear()
          _ARG_0_.stack:push("StateSettingB3")
          _ARG_0_.stack:push("Idling")
          _ARG_0_.stack:push("TransformOut_Idling")
          _ARG_0_.stack:push("Transform_Out")
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        else
          _ARG_0_.stack:clear()
          _ARG_0_.stack:push("StateSettingB3")
        end
      end
    elseif _ARG_0_:chackBetaAlive() == 0 and _ARG_0_:chackGanmaAlive() == 0 then
      if B01RG_PARTS_ALIVE == B01RG_ALIVE_NO_BETA_OR_GANMA then
        B01RG_PARTS_ALIVE = B01RG_ALIVE_NO_BETA_OR_GANMA
      else
        B01RG_PARTS_ALIVE = B01RG_ALIVE_NO_BETA_OR_GANMA
        print("\130\160\130\198\130\205\130\160\130\233\130\211\130\159\130\190\130\175\130\193\129I\n")
        if B01RG_MODE == B01RG_ROBOT_MODE then
          _ARG_0_.stack:clear()
          _ARG_0_.stack:push("StateSettingFinal")
          _ARG_0_.stack:push("Idling")
          _ARG_0_.stack:push("TransformOut_Idling")
          _ARG_0_.stack:push("Transform_Out")
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        else
          _ARG_0_.stack:clear()
          _ARG_0_.stack:push("StateSettingFinal")
        end
      end
    end
  end,
  changeRobotParts = function(_ARG_0_)
    if Entity.IsAlive(B04RG_HANDLE_NOMAL_ARM) then
      EntityManager:GetEntity(B04RG_HANDLE_NOMAL_ARM):GotoState("Transform_Start")
    end
    if Entity.IsAlive(B05RG_HANDLE_NOMAL_FOOT) then
      EntityManager:GetEntity(B05RG_HANDLE_NOMAL_FOOT):GotoState("Transform_Start")
    end
  end,
  setMotionParts = function(_ARG_0_, _ARG_1_)
    if Entity.IsAlive(B01RG_HANDLE_HEAD) then
      Entity.SetMotionWithSameCheck(B01RG_HANDLE_HEAD, _ARG_1_)
    end
    if Entity.IsAlive(B06RG_HANDLE_ROBOT_RIGHTARM) then
      Entity.SetMotionWithSameCheck(B06RG_HANDLE_ROBOT_RIGHTARM, _ARG_1_)
    end
    if Entity.IsAlive(B07RG_HANDLE_ROBOT_LEFTARM) then
      Entity.SetMotionWithSameCheck(B07RG_HANDLE_ROBOT_LEFTARM, _ARG_1_)
    end
    if Entity.IsAlive(B08RG_HANDLE_ROBOT_FOOT) then
      Entity.SetMotionWithSameCheck(B08RG_HANDLE_ROBOT_FOOT, _ARG_1_)
    end
  end,
  setMotionNomalParts = function(_ARG_0_, _ARG_1_)
    if Entity.IsAlive(B04RG_HANDLE_NOMAL_ARM) then
      Entity.SetMotionWithSameCheck(B04RG_HANDLE_NOMAL_ARM, _ARG_1_)
    end
    if Entity.IsAlive(B05RG_HANDLE_NOMAL_FOOT) then
      Entity.SetMotionWithSameCheck(B05RG_HANDLE_NOMAL_FOOT, _ARG_1_)
    end
  end,
  changeBobotParts = function(_ARG_0_, _ARG_1_)
    if Entity.IsAlive(B07RG_HANDLE_ROBOT_LEFTARM) then
      EntityManager:GetEntity(B07RG_HANDLE_ROBOT_LEFTARM):GotoState(_ARG_1_)
    end
    if Entity.IsAlive(B06RG_HANDLE_ROBOT_RIGHTARM) then
      EntityManager:GetEntity(B06RG_HANDLE_ROBOT_RIGHTARM):GotoState(_ARG_1_)
    end
    if Entity.IsAlive(B08RG_HANDLE_ROBOT_FOOT) then
      EntityManager:GetEntity(B08RG_HANDLE_ROBOT_FOOT):GotoState(_ARG_1_)
    end
  end,
  changeNomalParts = function(_ARG_0_, _ARG_1_)
    if Entity.IsAlive(B04RG_HANDLE_NOMAL_ARM) then
      EntityManager:GetEntity(B04RG_HANDLE_NOMAL_ARM):GotoState(_ARG_1_)
    end
    if Entity.IsAlive(B05RG_HANDLE_NOMAL_FOOT) then
      parts = EntityManager:GetEntity(B05RG_HANDLE_NOMAL_FOOT)
      parts:GotoState(_ARG_1_)
    end
  end,
  changeNomalArm = function(_ARG_0_, _ARG_1_)
    if Entity.IsAlive(B04RG_HANDLE_NOMAL_ARM) then
      EntityManager:GetEntity(B04RG_HANDLE_NOMAL_ARM):GotoState(_ARG_1_)
    end
  end,
  changeNomalFoot = function(_ARG_0_, _ARG_1_)
    if Entity.IsAlive(B05RG_HANDLE_NOMAL_FOOT) then
      parts = EntityManager:GetEntity(B05RG_HANDLE_NOMAL_FOOT)
      parts:GotoState(_ARG_1_)
    end
  end,
  setthingStateA1 = function(_ARG_0_)
    _ARG_0_.stack:clear()
    _ARG_0_.stack:push("StateSettingB1")
    _ARG_0_.stack:push("Idling")
    _ARG_0_.stack:push("TransformOut_Idling")
    _ARG_0_.stack:push("Transform_Out")
    _ARG_0_.stack:push("Transform_Idling")
    _ARG_0_.stack:push("Transform_Trinity_Baster")
    _ARG_0_.stack:push("Transform_MapSenterMove")
    _ARG_0_.stack:push("Transform_Idling")
    _ARG_0_.stack:push("Transform_Trinity_Charge")
    _ARG_0_.stack:push("Transform_Idling")
    _ARG_0_.stack:push("Transform_Hexa_Cannon")
    _ARG_0_.stack:push("Transform_Idling")
    _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
  end,
  setthingStateB1 = function(_ARG_0_)
    _ARG_0_.stack:clear()
    _ARG_0_.stack:push("StateSettingC1")
    _ARG_0_.stack:push("Transform_Start")
    _ARG_0_.stack:push("Transform_SetupPosMove")
    _ARG_0_.stack:push("Idling")
    _ARG_0_.stack:push("TriangleLaser")
    _ARG_0_.stack:push("TramplingAttack")
    _ARG_0_.stack:push("Idling")
    _ARG_0_.stack:push("Fixed_position")
    _ARG_0_.stack:push("SpinningBeam")
    _ARG_0_.stack:push("Idling")
    _ARG_0_.stack:push("Fixed_position")
    _ARG_0_.stack:push("TouchAndGo")
    _ARG_0_.stack:push("Idling")
    _ARG_0_.stack:push("Fixed_position")
    _ARG_0_.stack:push("Reflect_slash")
    _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
  end,
  setthingStateC1 = function(_ARG_0_)
    _ARG_0_.stack:clear()
    _ARG_0_.stack:push("StateSettingD1")
    _ARG_0_.stack:push("Idling")
    _ARG_0_.stack:push("TransformOut_Idling")
    _ARG_0_.stack:push("Transform_Out")
    _ARG_0_.stack:push("Transform_Idling")
    _ARG_0_.stack:push("Transform_Bic_Diveng")
    _ARG_0_.stack:push("Transform_Ssatellaite_Baster")
    _ARG_0_.stack:push("Transform_Jump")
    _ARG_0_.stack:push("Transform_Idling")
    _ARG_0_.stack:push("Transform_Trinity_Charge")
    _ARG_0_.stack:push("Transform_Idling")
    _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
  end,
  setthingStateD1 = function(_ARG_0_)
    _ARG_0_.stack:clear()
    _ARG_0_.stack:push("StateSettingA1")
    _ARG_0_.stack:push("Transform_Start")
    _ARG_0_.stack:push("Transform_SetupPosMove")
    _ARG_0_.stack:push("Idling")
    _ARG_0_.stack:push("BoltecShoot")
    _ARG_0_.stack:push("Idling")
    _ARG_0_.stack:push("Fixed_position")
    _ARG_0_.stack:push("UltimaImpact")
    _ARG_0_.stack:push("Idling")
    _ARG_0_.stack:push("Fixed_position")
    _ARG_0_.stack:push("Fraimerain")
    _ARG_0_.stack:push("Idling")
    _ARG_0_.stack:push("Fixed_position")
    _ARG_0_.stack:push("Reflect_slash")
    _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
  end,
  setthingStateA2 = function(_ARG_0_)
    _ARG_0_.stack:clear()
    _ARG_0_.stack:push("StateSettingB2")
    _ARG_0_.stack:push("Idling")
    _ARG_0_.stack:push("TransformOut_Idling")
    _ARG_0_.stack:push("Transform_Out")
    _ARG_0_.stack:push("Transform_Idling")
    _ARG_0_.stack:push("Transform_Knckle_walk_atttack")
    _ARG_0_.stack:push("Transform_Idling")
    _ARG_0_.stack:push("Transform_Idling")
    _ARG_0_.stack:push("Transform_Hexa_Cannon")
    _ARG_0_.stack:push("Transform_Idling")
    _ARG_0_.stack:push("Transform_Trinity_Charge")
    _ARG_0_.stack:push("Transform_Idling")
    _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
  end,
  setthingStateB2 = function(_ARG_0_)
    _ARG_0_.stack:clear()
    _ARG_0_.stack:push("StateSettingC2")
    _ARG_0_.stack:push("Transform_Start")
    _ARG_0_.stack:push("Transform_SetupPosMove")
    _ARG_0_.stack:push("Idling")
    _ARG_0_.stack:push("Reflect_slash")
    _ARG_0_.stack:push("SpinningBeam")
    _ARG_0_.stack:push("Idling")
    _ARG_0_.stack:push("Fixed_position")
    _ARG_0_.stack:push("Fraimerain")
    _ARG_0_.stack:push("Idling")
    _ARG_0_.stack:push("Fixed_position")
    _ARG_0_.stack:push("TriangleLaser")
    _ARG_0_.stack:push("Idling")
    _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
  end,
  setthingStateC2 = function(_ARG_0_)
    _ARG_0_.stack:clear()
    _ARG_0_.stack:push("StateSettingD2")
    _ARG_0_.stack:push("Idling")
    _ARG_0_.stack:push("TransformOut_Idling")
    _ARG_0_.stack:push("Transform_Out")
    _ARG_0_.stack:push("Transform_Idling")
    _ARG_0_.stack:push("Transform_Trinity_Charge")
    _ARG_0_.stack:push("Transform_Idling")
    _ARG_0_.stack:push("Transform_Trinity_Baster")
    _ARG_0_.stack:push("Transform_MapSenterMove")
    _ARG_0_.stack:push("Transform_Knckle_walk_atttack")
    _ARG_0_.stack:push("Transform_Idling")
    _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
  end,
  setthingStateD2 = function(_ARG_0_)
    _ARG_0_.stack:clear()
    _ARG_0_.stack:push("StateSettingA2")
    _ARG_0_.stack:push("Transform_Start")
    _ARG_0_.stack:push("Transform_SetupPosMove")
    _ARG_0_.stack:push("Idling")
    _ARG_0_.stack:push("Reflect_slash")
    _ARG_0_.stack:push("Idling")
    _ARG_0_.stack:push("Fixed_position")
    _ARG_0_.stack:push("UltimaImpact")
    _ARG_0_.stack:push("Idling")
    _ARG_0_.stack:push("Fixed_position")
    _ARG_0_.stack:push("TouchAndGo")
    _ARG_0_.stack:push("Idling")
    _ARG_0_.stack:push("Fixed_position")
    _ARG_0_.stack:push("TriangleLaser")
    _ARG_0_.stack:push("Idling")
    _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
  end,
  setthingStateA3 = function(_ARG_0_)
    _ARG_0_.stack:clear()
    _ARG_0_.stack:push("StateSettingB3")
    _ARG_0_.stack:push("Idling")
    _ARG_0_.stack:push("TransformOut_Idling")
    _ARG_0_.stack:push("Transform_Out")
    _ARG_0_.stack:push("Transform_Idling")
    _ARG_0_.stack:push("Transform_Trinity_Baster")
    _ARG_0_.stack:push("Transform_MapSenterMove")
    _ARG_0_.stack:push("Transform_Idling")
    _ARG_0_.stack:push("Transform_Hexa_Cannon")
    _ARG_0_.stack:push("Transform_Idling")
    _ARG_0_.stack:push("Transform_Trinity_Charge")
    _ARG_0_.stack:push("Transform_Idling")
    _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
  end,
  setthingStateB3 = function(_ARG_0_)
    _ARG_0_.stack:clear()
    _ARG_0_.stack:push("StateSettingC3")
    _ARG_0_.stack:push("Transform_Start")
    _ARG_0_.stack:push("Transform_SetupPosMove")
    _ARG_0_.stack:push("Idling")
    _ARG_0_.stack:push("Reflect_slash")
    _ARG_0_.stack:push("BoltecShoot")
    _ARG_0_.stack:push("Idling")
    _ARG_0_.stack:push("Fixed_position")
    _ARG_0_.stack:push("Fraimerain")
    _ARG_0_.stack:push("Idling")
    _ARG_0_.stack:push("Fixed_position")
    _ARG_0_.stack:push("TriangleLaser")
    _ARG_0_.stack:push("Idling")
    _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
  end,
  setthingStateC3 = function(_ARG_0_)
    _ARG_0_.stack:clear()
    _ARG_0_.stack:push("StateSettingD3")
    _ARG_0_.stack:push("Idling")
    _ARG_0_.stack:push("TransformOut_Idling")
    _ARG_0_.stack:push("Transform_Out")
    _ARG_0_.stack:push("Transform_Idling")
    _ARG_0_.stack:push("Transform_Trinity_Charge")
    _ARG_0_.stack:push("Transform_Idling")
    _ARG_0_.stack:push("Transform_Trinity_Baster")
    _ARG_0_.stack:push("Transform_MapSenterMove")
    _ARG_0_.stack:push("Transform_Idling")
    _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
  end,
  setthingStateD3 = function(_ARG_0_)
    _ARG_0_.stack:clear()
    _ARG_0_.stack:push("StateSettingA3")
    _ARG_0_.stack:push("Transform_Start")
    _ARG_0_.stack:push("Transform_SetupPosMove")
    _ARG_0_.stack:push("Idling")
    _ARG_0_.stack:push("Reflect_slash")
    _ARG_0_.stack:push("Reflect_slash")
    _ARG_0_.stack:push("TramplingAttack")
    _ARG_0_.stack:push("Idling")
    _ARG_0_.stack:push("Fixed_position")
    _ARG_0_.stack:push("TouchAndGo")
    _ARG_0_.stack:push("Idling")
    _ARG_0_.stack:push("Fixed_position")
    _ARG_0_.stack:push("TriangleLaser")
    _ARG_0_.stack:push("Idling")
    _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
  end,
  setthingStateFinal = function(_ARG_0_)
    _ARG_0_.stack:clear()
    _ARG_0_.stack:push("StateSettingFinal")
    _ARG_0_.stack:push("OneFraimerain")
    _ARG_0_.stack:push("Idling")
    _ARG_0_.stack:push("FreeMove")
    _ARG_0_.stack:push("Idling")
    _ARG_0_.stack:push("Transform_Trinity_Baster")
    _ARG_0_.stack:push("UltimaBerserk")
    _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
  end,
  setthingTransform = function(_ARG_0_)
    B01RG_DEBUG = 1
    _ARG_0_.stack:clear()
    _ARG_0_.stack:push("StateTransform")
    _ARG_0_.stack:push("Transform_Start")
    _ARG_0_.stack:push("Transform_SetupPosMove")
    _ARG_0_.stack:push("Idling")
    _ARG_0_.stack:push("TransformOut_Idling")
    _ARG_0_.stack:push("Transform_Out")
    _ARG_0_.stack:push("Transform_Idling")
    _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    B01RG_HANDLE_HEAD = NULL_HANDLE
    B04RG_HANDLE_NOMAL_ARM = NULL_HANDLE
    B05RG_HANDLE_NOMAL_FOOT = NULL_HANDLE
    B06RG_HANDLE_ROBOT_RIGHTARM = NULL_HANDLE
    B07RG_HANDLE_ROBOT_LEFTARM = NULL_HANDLE
    B08RG_HANDLE_ROBOT_FOOT = NULL_HANDLE
    _ARG_0_.myHandle = _ARG_1_
    B01RG_HANDLE_HEAD = _ARG_1_
    _ARG_0_.LightHandle = NULL_HANDLE
    _ARG_0_.BasterHandle_End = NULL_HANDLE
    _ARG_0_.step = 0
    _ARG_0_.targetHandle = NULL_HANDLE
    _ARG_0_.modeFlag = 0
    _ARG_0_.coefficient = 1
    _ARG_0_.stack = Stack:Create()
    _ARG_0_.Speed = 0
    _ARG_0_.TauchCnt = 0
    _ARG_0_.AttackCnt = 0
    _ARG_0_.RotationCnt = 0
    _ARG_0_.Rotation = 0
    _ARG_0_.RotationFlag = 0
    _ARG_0_.Wait = 0
    _ARG_0_.Wait2 = 0
    _ARG_0_.InviFlag = 0
    _ARG_0_.sateNumber = 0
    _ARG_0_.noChangeColl = 0
    _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
    _ARG_0_.WorkTime = 0
    _ARG_0_.count = 0
    _ARG_0_.changeCount = 0
    _ARG_0_.isDead = 0
    _ARG_0_.WorkVec = FVECTOR3.new(0, 0, 0)
    _ARG_0_.cameraPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
    if B01RG_INIT_PARAM == false then
      _UPVALUE0_ = Enemy.GetExtraParam(_ARG_1_, "IdlingT") * 60
      print("B01RG_TIME_IDLING = " .. _UPVALUE0_ .. "\n")
      _UPVALUE1_ = Enemy.GetExtraParam(_ARG_1_, "IdlingTT") * 60
      print("B01RG_TIME_TRANSFORM_IDLING = " .. _UPVALUE1_ .. "\n")
      _UPVALUE2_ = Enemy.GetExtraParam(_ARG_1_, "TriBastRot")
      print("B01RG_TRINITY_BASTER_ROTSPEED = " .. _UPVALUE2_ .. "\n")
      _UPVALUE3_ = Enemy.GetExtraParam(_ARG_1_, "SateShootF")
      print("B01RG_SATELLAITE_SHOOTTIME = " .. _UPVALUE3_ .. "\n")
      _UPVALUE3_ = Enemy.GetExtraParam(_ARG_1_, "SateLightF")
      print("B01RG_SATELLAITE_SHOOTTIME = " .. _UPVALUE3_ .. "\n")
      _UPVALUE4_ = Enemy.GetExtraParam(_ARG_1_, "SateLightR")
      print("B01RG_SATELLAITE_NUM_MIN = " .. _UPVALUE4_ .. "\n")
      _UPVALUE5_ = Enemy.GetExtraParam(_ARG_1_, "SateLightA")
      print("B01RG_SATELLAITE_NUM_ADD = " .. _UPVALUE5_ .. "\n")
      _UPVALUE6_ = Enemy.GetExtraParam(_ARG_1_, "BicStartF")
      print("B01RG_BIC_DIVING_START_TIME = " .. _UPVALUE6_ .. "\n")
      _UPVALUE7_ = Enemy.GetExtraParam(_ARG_1_, "BicUnderF")
      print("B01RG_BIC_DIVING_UNDER_TIME = " .. _UPVALUE7_ .. "\n")
      _UPVALUE8_ = Enemy.GetExtraParam(_ARG_1_, "RefSpeed")
      print("B01RG_REFLECT_SPEED = " .. _UPVALUE8_ .. "\n")
      _UPVALUE9_ = Enemy.GetExtraParam(_ARG_1_, "RefDimSpeed")
      print("B01RG_REFLECT_SUBSPEED = " .. _UPVALUE9_ .. "\n")
      B01RG_TRIANGLELASER_ROTNUM = Enemy.GetExtraParam(_ARG_1_, "TriRotNum")
      print("B01RG_TRIANGLELASER_ROTNUM = " .. B01RG_TRIANGLELASER_ROTNUM .. "\n")
      B01RG_INIT_PARAM = true
    end
    Entity.SetMovementCollRadius(_ARG_0_.myHandle, 6)
    Entity.SetLowerHalf(_ARG_0_.myHandle, 6.5)
    Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
    Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
    Entity.EnableLockon(_ARG_0_.myHandle, 0)
    Entity.EnableGravity(_ARG_0_.myHandle, 1)
    Player.SetBossCamera("b01rg")
    if Enemy.IsAllEnemyWaiting() == true then
      if Entity.GetName(_ARG_0_.myHandle) == "b71vs00" then
        _ARG_0_:GotoStateSub("StandbyArena")
      else
        _ARG_0_:GotoState("Standby")
      end
    else
      _ARG_0_:GotoState("Standby")
      Entity.EnableLockon(_ARG_0_.myHandle, 1)
    end
  end,
  OnDamage = function(_ARG_0_, _ARG_1_)
    print("OnDamage\n")
    print("Damage = " .. Entity.GetDamagePoint(_ARG_0_.myHandle) .. [[

Now Damage = ]] .. B01RG_SAVEINGDAMAGE .. "\n")
    B01RG_SAVEINGDAMAGE = B01RG_SAVEINGDAMAGE + Entity.GetDamagePoint(_ARG_0_.myHandle)
    if B01RG_SAVEINGDAMAGE > B01RG_COUNTER_DAMAGE then
      if B01RG_PARTS_ALIVE == B01RG_ALIVE_ALL then
        if B01RG_MODE == B01RG_ROBOT_MODE then
          _ARG_0_:GotoState("Transform_Swing_Punch")
        else
        end
        B01RG_SAVEINGDAMAGE = 0
      elseif B01RG_PARTS_ALIVE == B01RG_ALIVE_NO_BETA then
        if B01RG_MODE == B01RG_ROBOT_MODE then
          _ARG_0_:GotoState("Transform_Summer_salt")
        else
        end
        B01RG_SAVEINGDAMAGE = 0
      elseif B01RG_PARTS_ALIVE == B01RG_ALIVE_NO_GANMA then
        if B01RG_MODE == B01RG_ROBOT_MODE then
          _ARG_0_:GotoState("Transform_Swing_Punch")
        else
        end
        B01RG_SAVEINGDAMAGE = 0
      elseif B01RG_PARTS_ALIVE == B01RG_ALIVE_NO_BETA_OR_GANMA then
        B01RG_SAVEINGDAMAGE = 0
      end
    end
    return 1
  end,
  OnReturnDamage = function(_ARG_0_)
  end,
  OnHitAttack = function(_ARG_0_)
  end,
  OnDestroy = function(_ARG_0_)
    Effect.LoopEnd(_ARG_0_.LightHandle)
    Effect.LoopEnd(_ARG_0_.BasterHandle_End)
  end,
  OnDamageBefore = function(_ARG_0_)
    if B01RG_PARTS_ALIVE == B01RG_ALIVE_NO_BETA_OR_GANMA then
      if _ARG_0_.InviFlag == 1 then
        return 1
      end
    elseif _ARG_0_:CheckHP() == 1 then
      B01RG_SAVEINGDAMAGE = B01RG_SAVEINGDAMAGE + Entity.GetDamagePoint(_ARG_0_.myHandle)
      if B01RG_SAVEINGDAMAGE > B01RG_COUNTER_DAMAGE then
        if B01RG_PARTS_ALIVE == B01RG_ALIVE_ALL then
          if B01RG_MODE == B01RG_ROBOT_MODE then
            _ARG_0_:GotoState("Transform_Swing_Punch")
          else
          end
          B01RG_SAVEINGDAMAGE = 0
        elseif B01RG_PARTS_ALIVE == B01RG_ALIVE_NO_BETA then
          if B01RG_MODE == B01RG_ROBOT_MODE then
            _ARG_0_:GotoState("Transform_Summer_salt")
          else
          end
          B01RG_SAVEINGDAMAGE = 0
        elseif B01RG_PARTS_ALIVE == B01RG_ALIVE_NO_GANMA then
          if B01RG_MODE == B01RG_ROBOT_MODE then
            _ARG_0_:GotoState("Transform_Swing_Punch")
          else
          end
          B01RG_SAVEINGDAMAGE = 0
        elseif B01RG_PARTS_ALIVE == B01RG_ALIVE_NO_BETA_OR_GANMA then
          B01RG_SAVEINGDAMAGE = 0
        end
      end
      return 1
    else
      return 0
    end
  end,
  OnDead = function(_ARG_0_)
    if Entity.GetName(_ARG_0_.myHandle) == "b71vs00" then
      _ARG_0_:GotoStateSub("Deadarena")
      SetupBossDead(_ARG_0_.myHandle)
    else
      _ARG_0_:GotoState("Dead")
      SetupBossDead(_ARG_0_.myHandle)
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
      if _UPVALUE0_[Script.GetDebugAttackNumber() + 1] ~= nil and B01RG_DEBUG == 0 then
        _ARG_0_.stack:clear()
        _ARG_0_.stack:push("Idling")
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        _ARG_0_:GotoState(_UPVALUE0_[Script.GetDebugAttackNumber() + 1])
      end
    end
  end,
  OnUpdate = function(_ARG_0_)
    if Entity.GetName(_ARG_0_.myHandle) == "b01rg00" then
    else
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      _ARG_0_:setAllTargetHandleList(_ARG_0_.targetHandle)
    end
    _ARG_0_:Update()
    _ARG_0_:Debug()
    if B01RG_MODE == B01RG_NOMAL_MODE or _ARG_0_.noChangeColl == 1 then
      Entity.SetMovementCollRadius(_ARG_0_.myHandle, 1.5)
      Entity.SetLowerHalf(_ARG_0_.myHandle, 1.7)
    else
      Entity.SetMovementCollRadius(_ARG_0_.myHandle, 6)
      Entity.SetLowerHalf(_ARG_0_.myHandle, 6.5)
    end
    if Enemy.GetHp(_ARG_0_.myHandle) <= 0 and _ARG_0_.isDead == 0 then
      _ARG_0_:OnDead()
      _ARG_0_.isDead = 1
    end
    _ARG_0_:chackAlive()
  end
}, {__index = __StateMachine})
function GetRandHandleList()
  if Script.Random() < 0.3333 then
  elseif Script.Random() < 0.66666 then
  else
  end
  if Entity.IsAlive(TARGETHANDLELIST[2]) == false then
  end
  return TARGETHANDLELIST[0]
end
EntityFactory:Add("b01rg00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b71vs00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
function PartsAttack(_ARG_0_)
  Entity.GetRot(WorkVec, B01RG_HANDLE_HEAD)
  Entity.SetRot(_ARG_0_, WorkVec)
  Entity.GetWorldPos(WorkVec, B01RG_HANDLE_HEAD)
  Entity.SetLocalPos(_ARG_0_, WorkVec)
  Entity.SetOldLocalPos(_ARG_0_, WorkVec)
end
function changeSet(_ARG_0_, _ARG_1_, _ARG_2_)
  if _ARG_2_ == 0 then
    Entity.SetAlpha(_ARG_1_, 0)
    Entity.EnableDamageColl(_ARG_1_, 0)
    Entity.EnableBodyColl(_ARG_1_, 0)
    Entity.EnableLockon(_ARG_1_, 0)
    Entity.EnableShooton(_ARG_1_, 0)
  elseif _ARG_2_ == 1 then
    Entity.SetAlpha(_ARG_1_, 1)
    Entity.EnableDamageColl(_ARG_1_, 1)
    Entity.EnableBodyColl(_ARG_1_, 1)
    Entity.EnableLockon(_ARG_1_, 1)
    Entity.EnableShooton(_ARG_1_, 1)
  end
end
function AllEnableLock(_ARG_0_)
  Entity.EnableLockonAndShooton(B01RG_HANDLE_HEAD, _ARG_0_)
  Entity.EnableLockonAndShooton(B04RG_HANDLE_NOMAL_ARM, _ARG_0_)
  Entity.EnableLockonAndShooton(B05RG_HANDLE_NOMAL_FOOT, _ARG_0_)
  Entity.EnableLockonAndShooton(B06RG_HANDLE_ROBOT_RIGHTARM, _ARG_0_)
  Entity.EnableLockonAndShooton(B07RG_HANDLE_ROBOT_LEFTARM, _ARG_0_)
  Entity.EnableLockonAndShooton(B08RG_HANDLE_ROBOT_FOOT, _ARG_0_)
end
EntityFactory:Add("Satellaite", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("Fraimeb", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("FraimeBullet", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("HexaCannon", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("HexaCannonMinSmall", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
