M01SW_CHASER_HANDLE = NULL_HANDLE
M01SW_NEAR_DIST = 100000000
m01sw00 = {}
m01sw00_base_mt = {__index = __StateMachine}
setmetatable(m01sw00, m01sw00_base_mt)
m01sw00_mt = {__index = m01sw00}
function m01sw00.new(_ARG_0_)
  return setmetatable(__StateMachine:new(), m01sw00_mt)
end
m01sw00.states = {
  Appear = {
    OnBeginState = function(_ARG_0_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
    end
  },
  Idling = {
    OnBeginState = function(_ARG_0_)
      print("m01sw00:Idling\n")
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.EnableLockon(_ARG_0_.myHandle, 0)
      Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
      Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      M01SW_NEAR_DIST = 100000000
    end,
    OnUpdate = function(_ARG_0_)
      Entity.GetStartPos(_ARG_0_.WorkVec, _ARG_0_.myHandle)
      if _ARG_0_.moveFlag == 1 then
        if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, Entity.GetNpc()) < 20.25 then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, Entity.GetNpc(), 1)
          if Entity.IsTargetWithinFOV(_ARG_0_.myHandle, Entity.GetNpc(), DegToRad(160)) then
            _ARG_0_:GotoState("Change")
          end
          Entity.ClearSpeed(_ARG_0_.myHandle)
          return
        end
        if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, Entity.GetNpc()) < _ARG_0_.searchDist and Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.WorkVec) < _ARG_0_.startDist then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, Entity.GetNpc(), 1)
          FVECTOR3.set(_UPVALUE1_, 0, 0, 0.02)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE1_)
        else
          Entity.ClearSpeed(_ARG_0_.myHandle)
          _ARG_0_:GotoState("CreateEnd2")
        end
      else
      end
    end
  },
  Change = {
    OnBeginState = function(_ARG_0_)
      print("m01sw00:Change\n")
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Mission.SendMissonMessageGhosttree(MES_TREE_CHANGE_START, _ARG_0_.myHandle)
      Entity.EnableLockon(_ARG_0_.myHandle, 1)
      _ARG_0_.step = 0
      _ARG_0_.changeFlag = 1
      _ARG_0_.workTime = 0
      _ARG_0_.moveFlag = 0
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_.changeFlag = 0
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
          _ARG_0_.step = 1
          Mission.SendMissonMessageGhosttree(MES_DIRECT_ATTACK_TO_SNOWWHITE, _ARG_0_.myHandle)
          Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        end
      elseif _ARG_0_.step == 1 then
        _ARG_0_.workTime = _ARG_0_.workTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if 0 > _ARG_0_.workTime then
          _ARG_0_.workTime = 1200
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
          if _ARG_0_.originFlag == 0 then
            Mission.SendMissonMessageGhosttreeOrign(MES_RETURNS_TO_ORIGIN)
            _ARG_0_.originFlag = 1
          end
          Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
          _ARG_0_.step = 2
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
          return
        end
      elseif _ARG_0_.step == 2 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("CreateEnd")
      end
    end
  },
  CreateIdling = {
    OnBeginState = function(_ARG_0_)
      print("m01sw00:CreateIdling\n")
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.moveFlag = 1
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsModelFade(_ARG_0_.myHandle) == false then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  CreateEnd = {
    OnBeginState = function(_ARG_0_)
      print("m01sw00:CreateEnd\n")
      Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 30)
      Entity.SetupModelFade(Entity.GetParent(_ARG_0_.myHandle), 0, 1, 30)
      Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
      Entity.EnableLockon(_ARG_0_.myHandle, 0)
      Entity.EnableGravity(_ARG_0_.myHandle, 0)
      Entity.EnableBgColl(_ARG_0_.myHandle, 0)
      Entity.GetRot(_ARG_0_.WorkVec, _ARG_0_.myHandle)
      Entity.SetRot(Entity.GetParent(_ARG_0_.myHandle), _ARG_0_.WorkVec)
      Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.myHandle)
      Entity.SetLocalPos(Entity.GetParent(_ARG_0_.myHandle), _ARG_0_.WorkVec)
      Entity.SetOldLocalPos(Entity.GetParent(_ARG_0_.myHandle), _ARG_0_.WorkVec)
      Entity.EnableRideColl(Entity.GetParent(_ARG_0_.myHandle), 1, 0)
      Entity.SetAlpha(Entity.GetParent(_ARG_0_.myHandle), 0)
      EntityManager:GetEntity((Entity.GetParent(_ARG_0_.myHandle))).step = 2
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsModelFade(_ARG_0_.myHandle) == false then
        Entity.Out(_ARG_0_.myHandle)
      end
    end
  },
  CreateEnd2 = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.EnableLockon(_ARG_0_.myHandle, 0)
      _ARG_0_.step = 0
      _ARG_0_.moveFlag = 0
      Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("CreateEnd")
      else
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
        Entity.EnableLockon(_ARG_0_.myHandle, 0)
      end
    end
  },
  Dead = {
    OnBeginState = function(_ARG_0_)
      print("m01sw00:Dead\n")
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.EnableLockon(_ARG_0_.myHandle, 0)
      if _ARG_0_.originFlag == 0 then
        Mission.SendMissonMessageGhosttreeOrign(MES_RETURNS_TO_ORIGIN)
        _ARG_0_.originFlag = 1
      end
      _ARG_0_.step = 0
      _ARG_0_.moveFlag = 0
      Enemy.PlayerReportDeadCountUp(_ARG_0_.myHandle)
      Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("CreateEnd")
      else
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
}
function m01sw00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.targetHandle = NULL_HANDLE
  _ARG_0_.changeFlag = 0
  _ARG_0_.workTime = 0
  _ARG_0_.moveFlag = 0
  _ARG_0_.originFlag = 0
  _ARG_0_.startDist = _UPVALUE0_
  _ARG_0_.searchDist = _UPVALUE1_
  _ARG_0_.WorkTime = 0
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
  _ARG_0_.cameraPos = FVECTOR3.new(0, 0, 0)
  if Entity.GetLayoutParam(_ARG_0_.myHandle, 5) * Entity.GetLayoutParam(_ARG_0_.myHandle, 5) ~= 0 then
    _ARG_0_.startDist = Entity.GetLayoutParam(_ARG_0_.myHandle, 5) * Entity.GetLayoutParam(_ARG_0_.myHandle, 5)
    print("" .. _ARG_0_.startDist .. "\n")
  end
  if Entity.GetLayoutParam(_ARG_0_.myHandle, 6) * Entity.GetLayoutParam(_ARG_0_.myHandle, 6) ~= 0 then
    _ARG_0_.searchDist = Entity.GetLayoutParam(_ARG_0_.myHandle, 6) * Entity.GetLayoutParam(_ARG_0_.myHandle, 6)
    print("" .. _ARG_0_.searchDist .. "\n")
  end
  print("startDist = " .. _ARG_0_.startDist .. "\n")
  print("searchDist = " .. _ARG_0_.searchDist .. "\n")
  if _UPVALUE2_ == false then
    _UPVALUE3_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "attTime") * 60
    _UPVALUE2_ = true
  end
  M01SW_CHASER_HANDLE = _ARG_0_.myHandle
  Entity.SetMovementCollRadius(_ARG_0_.myHandle, 1.7)
  Entity.SetLowerHalf(_ARG_0_.myHandle, 2)
  Entity.SetLockOnBoneNum(_ARG_0_.myHandle, 4)
  Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
  Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
  Entity.EnableLockon(_ARG_0_.myHandle, 0)
  Entity.EnableGravity(_ARG_0_.myHandle, 1)
  Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
end
function m01sw00.OnDamage(_ARG_0_, _ARG_1_)
  print("m01sw00:OnDamage\n")
  if Entity.GetDamageCommandKind(_ARG_0_.myHandle) == COMMAND_KIND_WhiteSilence then
    _ARG_0_:GotoState("Dead")
  end
end
function m01sw00.OnDead(_ARG_0_)
  print("m01sw00:OnDead\n")
  _ARG_0_:GotoState("Dead")
  return 2
end
function m01sw00.OnUpdate(_ARG_0_)
  _ARG_0_:Update()
end
EntityFactory:Add("m01sw00", function(_ARG_0_)
  return (m01sw00:new())
end)
