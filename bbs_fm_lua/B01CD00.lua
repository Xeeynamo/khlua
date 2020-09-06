SymphonyMaster = {
  MSG_ATTACK = 1,
  MSG_ATTACK_END = 2,
  MSG_PLAY = 3,
  MSG_STOP = 4,
  MSG_ORCHESTRA_HIT_IDLING = 5,
  MSG_ORCHESTRA_HIT = 6,
  TRUMPET_SPEED = 0.1,
  VIOLIN_SPEED = 0.1,
  DRUM_SPEED = 0.1,
  NORMAL_ROT_SPEED = 0.5,
  SPIN_ATTACK_ROT_SPEED = 10,
  ORCHESTRA_HIT_SPEED = 0.2,
  ORCHESTRA_HIT_WAIT = 30,
  ORCHESTRA_HIT_NEXT_WAIT = 120,
  ORCHESTRA_HIT_COUNT = 3,
  BIG_BATON_ATTACK_SPEED = 0.25,
  NORMAL_HEIGHT = 2.5,
  SPIN_ATTACK_HEIGHT = 0.75,
  ORCHESTRA_HIT_HEIGHT = 0.75,
  MUSICALINSTRUMENT_RADIUS = 3.5
}
b01cd00 = {}
b01cd00_base_mt = {__index = __StateMachine}
setmetatable(b01cd00, b01cd00_base_mt)
b01cd00_mt = {__index = b01cd00}
function b01cd00.new(_ARG_0_)
  return setmetatable(__StateMachine:new(), b01cd00_mt)
end
b01cd00.states = {
  Appear = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_, 0, -2)
      _ARG_0_:SendMessageToMusicalInstrument(SymphonyMaster.MSG_PLAY)
      Entity.EnableLockon(_ARG_0_.myHandle, 0)
      Entity.EnableLockon(_ARG_0_.trumpetHandle, 0)
      Entity.EnableLockon(_ARG_0_.violinHandle, 0)
      Entity.EnableLockon(_ARG_0_.drumHandle, 0)
    end,
    OnEndState = function(_ARG_0_)
      Entity.EnableLockon(_ARG_0_.myHandle, 1)
      Entity.EnableLockon(_ARG_0_.trumpetHandle, 1)
      Entity.EnableLockon(_ARG_0_.violinHandle, 1)
      Entity.EnableLockon(_ARG_0_.drumHandle, 1)
    end,
    OnUpdate = function(_ARG_0_)
      if Enemy.IsAllEnemyWaiting() == false then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Idling = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_, 0, -2)
      Entity.SetTimer(_ARG_0_.myHandle, Script.RandomInRange(_UPVALUE1_, _UPVALUE1_ * 2))
      _ARG_0_:SendMessageToMusicalInstrument(SymphonyMaster.MSG_PLAY)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_.stack:clear()
        _ARG_0_.stack:push("Idling")
        if _ARG_0_:IsAliveMusicalInstrument() and _ARG_0_:RestHpRate() > _UPVALUE0_ then
          if Script.Random() > 0.5 then
            _ARG_0_.stack:push("SpinAttack")
          else
            _ARG_0_.stack:push("BatonThrow")
          end
          if _ARG_0_:IsAliveMusicalInstrument() then
            if _ARG_0_:IsAliveAllMusicalInstrument() then
              _ARG_0_.stack:push("OrchestraHit")
            end
            _ARG_0_.stack:push("MusicalInstrumentAttack")
          end
        else
          if _ARG_0_:IsAliveMusicalInstrument() then
            _ARG_0_.stack:push("SpinAttack")
            if _ARG_0_:IsAliveAllMusicalInstrument() then
              _ARG_0_.stack:push("OrchestraHit")
            end
            _ARG_0_.stack:push("MusicalInstrumentAttack")
          else
            _ARG_0_.stack:push("BatonThrow")
            _ARG_0_.stack:push("JumpAttack")
          end
          _ARG_0_.stack:push("BigBatonAttack")
          _ARG_0_.stack:push("JumpAttack")
        end
        if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _UPVALUE1_ then
          _ARG_0_.stack:push("Move")
        end
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      end
    end
  },
  Move = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
      _ARG_0_.velocity:set(0, 0, _UPVALUE0_)
      Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
      if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= _UPVALUE1_ then
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      end
    end
  },
  Wait = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 0, -2)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 30)
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        if (_ARG_0_.stack:pop(1) == "MusicalInstrumentAttack" or _ARG_0_.stack:pop(1) == "SpinAttack") and _ARG_0_:IsAliveMusicalInstrument() == false then
          _ARG_0_:GotoState("JumpAttack")
          return
        end
        _ARG_0_:GotoState((_ARG_0_.stack:pop(1)))
      end
    end
  },
  Hysteria = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
      _ARG_0_:SendMessageToMusicalInstrument(SymphonyMaster.MSG_STOP)
    end,
    OnEndState = function(_ARG_0_)
      Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
      _ARG_0_:SendMessageToMusicalInstrument(SymphonyMaster.MSG_PLAY)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  MusicalInstrumentAttack = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_, 0, -2)
      _ARG_0_.step = 0
      _ARG_0_.count = 0
      if 0 <= Script.Random() and Script.Random() < 0.35 then
        _ARG_0_.choice[0] = _ARG_0_.trumpetHandle
        _ARG_0_.choice[1] = _ARG_0_.violinHandle
        _ARG_0_.choice[2] = _ARG_0_.drumHandle
      elseif Script.Random() >= 0.35 and Script.Random() < 0.7 then
        _ARG_0_.choice[0] = _ARG_0_.violinHandle
        _ARG_0_.choice[1] = _ARG_0_.trumpetHandle
        _ARG_0_.choice[2] = _ARG_0_.drumHandle
      else
        _ARG_0_.choice[0] = _ARG_0_.drumHandle
        _ARG_0_.choice[1] = _ARG_0_.trumpetHandle
        _ARG_0_.choice[2] = _ARG_0_.violinHandle
      end
      if Script.Random() < 0.5 then
        _ARG_0_.choice[1] = _ARG_0_.choice[2]
        _ARG_0_.choice[2] = _ARG_0_.choice[1]
      end
      _ARG_0_:SetMusicalInstrumentRotSpeed(0)
      _ARG_0_.canMusicalInstrumentRot = false
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_:SetMusicalInstrumentRotSpeed(0.5)
      _ARG_0_.canMusicalInstrumentRot = true
    end,
    OnUpdate = function(_ARG_0_)
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 30)
      if _ARG_0_.step == 0 then
        while _ARG_0_.count < 3 do
          _ARG_0_.count = _ARG_0_.count + 1
          if Entity.IsAlive(_ARG_0_.choice[_ARG_0_.count]) then
            Enemy.SendMessage(0, _ARG_0_.myHandle, _ARG_0_.choice[_ARG_0_.count], SymphonyMaster.MSG_ATTACK)
            _ARG_0_.step = 1
            return
          end
        end
        _ARG_0_:GotoState("Wait")
      end
    end
  },
  JumpAttack = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 18 then
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) * 0.05)
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 80 then
          Camera.QuakeV(50, 0.5, 12)
          Entity.ClearSpeed(_ARG_0_.myHandle)
          _ARG_0_.step = 2
        end
      elseif _ARG_0_.step == 2 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Wait")
      end
    end
  },
  SpinAttack = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetTimer(_ARG_0_.myHandle, Script.RandomInRange(_UPVALUE1_, _UPVALUE1_ * 2))
      _ARG_0_:SetMusicalInstrumentRotSpeed(SymphonyMaster.SPIN_ATTACK_ROT_SPEED)
      _ARG_0_:SetMusicalInstrumentHeight(SymphonyMaster.SPIN_ATTACK_HEIGHT)
      _ARG_0_:SetMusicalInstrumentMotion(2, 1, 0)
      _ARG_0_:EnableMusicalInstrumentNoDamageReaction(1)
      _ARG_0_.step = 0
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      Entity.GetWorldPos(_ARG_0_.playerPos, _ARG_0_.targetHandle)
      SymphonyMaster.MUSICALINSTRUMENT_RADIUS = _UPVALUE2_
      Entity.EnableLockon(_ARG_0_.trumpetHandle, 0)
      Entity.EnableLockon(_ARG_0_.violinHandle, 0)
      Entity.EnableLockon(_ARG_0_.drumHandle, 0)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      _ARG_0_:SetMusicalInstrumentRotSpeed(SymphonyMaster.NORMAL_ROT_SPEED)
      _ARG_0_:SetMusicalInstrumentHeight(SymphonyMaster.NORMAL_HEIGHT)
      _ARG_0_:SetMusicalInstrumentMotion(2, 0, -2)
      _ARG_0_:EnableMusicalInstrumentNoDamageReaction(0)
      SymphonyMaster.MUSICALINSTRUMENT_RADIUS = _UPVALUE0_
      Entity.EnableLockon(_ARG_0_.trumpetHandle, 1)
      Entity.EnableLockon(_ARG_0_.violinHandle, 1)
      Entity.EnableLockon(_ARG_0_.drumHandle, 1)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.playerPos, 20)
        _ARG_0_.velocity:set(0, 0, _UPVALUE0_)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
        if Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.playerPos) <= 2.25 then
          _ARG_0_.step = 1
        end
      else
        Entity.GetVelocity(_ARG_0_.velocity, _ARG_0_.myHandle)
        _ARG_0_.velocity:scale(0.9)
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
        if Entity.IsWall(_ARG_0_.myHandle) or _ARG_0_.velocity:length() <= 0.01 then
          _ARG_0_:GotoState("Wait")
        end
      end
    end
  },
  BatonThrow = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
    end,
    OnEndState = function(_ARG_0_)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        Entity.CalcTargetPos(_ARG_0_.playerPos, _ARG_0_.myHandle, _ARG_0_.targetHandle)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.playerPos, 10)
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 37 then
          Entity.GetWorldPos(_ARG_0_.target, _ARG_0_.targetHandle, 2)
          _ARG_0_.playerPos:sety(_ARG_0_.target:gety())
          _ARG_0_:CreateBaton(71, DegToRad(-30), _ARG_0_.playerPos)
          _ARG_0_:CreateBaton(72, DegToRad(-15), _ARG_0_.playerPos)
          _ARG_0_:CreateBaton(73, DegToRad(0), _ARG_0_.playerPos)
          _ARG_0_:CreateBaton(74, DegToRad(15), _ARG_0_.playerPos)
          _ARG_0_:CreateBaton(75, DegToRad(30), _ARG_0_.playerPos)
          _ARG_0_.step = 1
        end
      end
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Wait")
      end
    end
  },
  BigBatonAttack = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
    end,
    OnEndState = function(_ARG_0_)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        Entity.CalcTargetPos(_ARG_0_.playerPos, _ARG_0_.myHandle, _ARG_0_.targetHandle)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.playerPos, 10)
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 50 then
          Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle, 58)
          Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
          EntityManager:GetEntity((Entity.CreateEntity("b05cd00", _ARG_0_.myPos, _ARG_0_.rot))):Setup(_ARG_0_.myHandle, 1)
          _ARG_0_.batonHandle = Entity.CreateEntity("b05cd00", _ARG_0_.myPos, _ARG_0_.rot)
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 then
        if EntityManager:GetEntity(_ARG_0_.batonHandle) == nil then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
          _ARG_0_.step = 2
        end
      elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Wait")
      end
    end
  },
  OrchestraHit = {
    OnBeginState = function(_ARG_0_)
      Entity.SetTimer(_ARG_0_.myHandle, 180)
      _ARG_0_:SetMusicalInstrumentRotSpeed(0)
      _ARG_0_.canMusicalInstrumentRot = false
      _ARG_0_:SetMusicalInstrumentParent(_ARG_0_.targetHandle)
      _ARG_0_:SendMessageToMusicalInstrument(SymphonyMaster.MSG_ORCHESTRA_HIT_IDLING)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_:SetMusicalInstrumentRotSpeed(0.5)
      _ARG_0_.canMusicalInstrumentRot = true
      _ARG_0_:SetMusicalInstrumentParent(_ARG_0_.myHandle)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:SendMessageToMusicalInstrument(SymphonyMaster.MSG_ORCHESTRA_HIT)
          _ARG_0_.step = 1
        end
      else
        for _FORV_4_ = 0, 2 do
          if EntityManager:GetEntity(_ARG_0_.choice[_FORV_4_]) ~= nil and EntityManager:GetEntity(_ARG_0_.choice[_FORV_4_]):GetState() == "OrchestraHit" then
            return
          end
        end
        _ARG_0_:GotoState("Wait")
      end
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
}
function b01cd00.CreateBaton(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle, _ARG_1_)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  _ARG_0_.rot:sety(RoundPI(_ARG_0_.rot:gety() + _ARG_2_))
  FVECTOR3.Sub(_ARG_0_.workVec0, _ARG_3_, _ARG_0_.myPos)
  _ARG_0_.workVec0:normalize()
  _ARG_0_.rot:setx(-Math.Atan2(_ARG_0_.workVec0:gety(), Math.Sqrt(_ARG_0_.workVec0:getx() * _ARG_0_.workVec0:getx() + _ARG_0_.workVec0:getz() * _ARG_0_.workVec0:getz())))
  _ARG_0_.rot:sety(Math.Atan2(_ARG_0_.workVec0:getx(), _ARG_0_.workVec0:getz()) + _ARG_2_)
  Entity.SetMotion(Entity.CreateEntity("b05cd00", _ARG_0_.myPos, _ARG_0_.rot), 1)
  Entity.CalcVelocity(Entity.CreateEntity("b05cd00", _ARG_0_.myPos, _ARG_0_.rot), _UPVALUE0_)
end
function b01cd00.IsAliveMusicalInstrument(_ARG_0_)
  if Entity.IsAlive(_ARG_0_.trumpetHandle) then
    return true
  end
  if Entity.IsAlive(_ARG_0_.violinHandle) then
    return true
  end
  if Entity.IsAlive(_ARG_0_.drumHandle) then
    return true
  end
  return false
end
function b01cd00.IsAliveAllMusicalInstrument(_ARG_0_)
  if Entity.IsAlive(_ARG_0_.trumpetHandle) and Entity.IsAlive(_ARG_0_.violinHandle) and Entity.IsAlive(_ARG_0_.drumHandle) then
    return true
  end
  return false
end
function b01cd00.IsDestroyMusicalInstrument(_ARG_0_)
  if _ARG_0_.trumpetHandle ~= NULL_HANDLE and Entity.IsAlive(_ARG_0_.trumpetHandle) == false then
    _ARG_0_.trumpetHandle = NULL_HANDLE
  end
  if _ARG_0_.violinHandle ~= NULL_HANDLE and Entity.IsAlive(_ARG_0_.violinHandle) == false then
    _ARG_0_.violinHandle = NULL_HANDLE
  end
  if _ARG_0_.drumHandle ~= NULL_HANDLE and Entity.IsAlive(_ARG_0_.drumHandle) == false then
    _ARG_0_.drumHandle = NULL_HANDLE
  end
  if _ARG_0_.restHpRateCheck == false and _ARG_0_:RestHpRate() < 0.4 then
    _ARG_0_.restHpRateCheck = true
    return true
  end
  return true
end
function b01cd00.SetMusicalInstrumentRotSpeed(_ARG_0_, _ARG_1_)
  for _FORV_5_ = 0, 2 do
    if EntityManager:GetEntity(_ARG_0_.choice[_FORV_5_]) ~= nil then
      EntityManager:GetEntity(_ARG_0_.choice[_FORV_5_]).rotSpeed = _ARG_1_
    end
  end
end
function b01cd00.RotateMusicalInstrument(_ARG_0_)
  for _FORV_4_ = 0, 2 do
    if EntityManager:GetEntity(_ARG_0_.choice[_FORV_4_]) ~= nil then
      EntityManager:GetEntity(_ARG_0_.choice[_FORV_4_]).angle = RoundPI(EntityManager:GetEntity(_ARG_0_.choice[_FORV_4_]).angle + DegToRad(EntityManager:GetEntity(_ARG_0_.choice[_FORV_4_]).rotSpeed * Entity.GetFrameRate(_ARG_0_.myHandle)))
    end
  end
end
function b01cd00.SetMusicalInstrumentMotion(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  for _FORV_7_ = 0, 2 do
    Entity.SetMotion(_ARG_0_.choice[_FORV_7_], _ARG_1_, _ARG_2_, _ARG_3_)
  end
end
function b01cd00.SetMusicalInstrumentHeight(_ARG_0_, _ARG_1_)
  for _FORV_5_ = 0, 2 do
    if EntityManager:GetEntity(_ARG_0_.choice[_FORV_5_]) ~= nil then
      EntityManager:GetEntity(_ARG_0_.choice[_FORV_5_]).height = _ARG_1_
    end
  end
end
function b01cd00.SetMusicalInstrumentParent(_ARG_0_, _ARG_1_)
  for _FORV_5_ = 0, 2 do
    if EntityManager:GetEntity(_ARG_0_.choice[_FORV_5_]) ~= nil then
      EntityManager:GetEntity(_ARG_0_.choice[_FORV_5_]).parentHandle = _ARG_1_
      EntityManager:GetEntity(_ARG_0_.choice[_FORV_5_]):GotoState("Return")
    end
  end
end
function b01cd00.EnableMusicalInstrumentNoDamageReaction(_ARG_0_, _ARG_1_)
  for _FORV_5_ = 0, 2 do
    Enemy.EnableNoDamageReaction(_ARG_0_.choice[_FORV_5_], _ARG_1_)
  end
end
function b01cd00.SendMessageToMusicalInstrument(_ARG_0_, _ARG_1_)
  Enemy.SendMessage(0, _ARG_0_.myHandle, _ARG_0_.trumpetHandle, _ARG_1_)
  Enemy.SendMessage(0, _ARG_0_.myHandle, _ARG_0_.violinHandle, _ARG_1_)
  Enemy.SendMessage(0, _ARG_0_.myHandle, _ARG_0_.drumHandle, _ARG_1_)
end
function b01cd00.RestHpRate(_ARG_0_)
  return Enemy.GetHp(_ARG_0_.myHandle) / Enemy.GetHpMax(_ARG_0_.myHandle)
end
function b01cd00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _UPVALUE0_ = Enemy.GetExtraParam(_ARG_1_, "BT_SPD")
  _UPVALUE1_ = Enemy.GetExtraParam(_ARG_1_, "SA_SPD")
  SymphonyMaster.BIG_BATON_ATTACK_SPEED = Enemy.GetExtraParam(_ARG_1_, "BBA_SPD")
  SymphonyMaster.ORCHESTRA_HIT_SPEED = Enemy.GetExtraParam(_ARG_1_, "OH_SPD")
  SymphonyMaster.TRUMPET_SPEED = Enemy.GetExtraParam(_ARG_1_, "T_ATK_SPD")
  SymphonyMaster.VIOLIN_SPEED = Enemy.GetExtraParam(_ARG_1_, "V_ATK_SPD")
  SymphonyMaster.DRUM_SPEED = Enemy.GetExtraParam(_ARG_1_, "D_ATK_SPD")
  SymphonyMaster.ORCHESTRA_HIT_NEXT_WAIT = Enemy.GetExtraParam(_ARG_1_, "OCH_N_TIME") * 60
  Entity.EnableGravity(_ARG_0_.myHandle, 1)
  Entity.SetMovementCollRadius(_ARG_0_.myHandle, 1)
  Entity.SetLowerHalf(_ARG_0_.myHandle, 1.5)
  _ARG_0_.playerPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.target = FVECTOR3.new(0, 0, 0)
  _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec0 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.cameraTargetPos = FVECTOR3.new(0, 0, 0)
  Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle, 2)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  Enemy.SetViewDist(_ARG_1_, 50)
  _ARG_0_.workVec0:set(3, 0, 0)
  Math.RotateVectorZYX(_ARG_0_.workVec0, _ARG_0_.rot)
  FVECTOR3.Add(_ARG_0_.workVec0, _ARG_0_.workVec0, _ARG_0_.myPos)
  _ARG_0_.trumpetHandle = Entity.CreateEntity("b02cd00", _ARG_0_.workVec0, _ARG_0_.rot)
  if EntityManager:GetEntity(_ARG_0_.trumpetHandle) ~= nil then
    EntityManager:GetEntity(_ARG_0_.trumpetHandle).parentHandle = _ARG_1_
    EntityManager:GetEntity(_ARG_0_.trumpetHandle).ownerHandle = _ARG_1_
  end
  _ARG_0_.workVec0:set(-3, 0, 0)
  Math.RotateVectorZYX(_ARG_0_.workVec0, _ARG_0_.rot)
  FVECTOR3.Add(_ARG_0_.workVec0, _ARG_0_.workVec0, _ARG_0_.myPos)
  _ARG_0_.violinHandle = Entity.CreateEntity("b03cd00", _ARG_0_.workVec0, _ARG_0_.rot)
  if EntityManager:GetEntity(_ARG_0_.violinHandle) ~= nil then
    EntityManager:GetEntity(_ARG_0_.violinHandle).parentHandle = _ARG_1_
    EntityManager:GetEntity(_ARG_0_.violinHandle).ownerHandle = _ARG_1_
  end
  _ARG_0_.workVec0:set(0, 0, 3)
  Math.RotateVectorZYX(_ARG_0_.workVec0, _ARG_0_.rot)
  FVECTOR3.Add(_ARG_0_.workVec0, _ARG_0_.workVec0, _ARG_0_.myPos)
  _ARG_0_.drumHandle = Entity.CreateEntity("b04cd00", _ARG_0_.workVec0, _ARG_0_.rot)
  if EntityManager:GetEntity(_ARG_0_.drumHandle) ~= nil then
    EntityManager:GetEntity(_ARG_0_.drumHandle).parentHandle = _ARG_1_
    EntityManager:GetEntity(_ARG_0_.drumHandle).ownerHandle = _ARG_1_
  end
  _ARG_0_.batonHandle = NULL_HANDLE
  _ARG_0_.step = 0
  _ARG_0_.count = 0
  _ARG_0_.targetHandle = NULL_HANDLE
  _ARG_0_.canMusicalInstrumentRot = true
  _ARG_0_.restHpRateCheck = false
  _ARG_0_.choice = {
    NULL_HANDLE,
    NULL_HANDLE,
    NULL_HANDLE
  }
  _ARG_0_.choice[0] = _ARG_0_.trumpetHandle
  _ARG_0_.choice[1] = _ARG_0_.violinHandle
  _ARG_0_.choice[2] = _ARG_0_.drumHandle
  _ARG_0_.stack = Stack:Create()
  Player.SetBossCamera("b01cd")
  if Enemy.IsAllEnemyWaiting() == true then
    _ARG_0_:GotoState("Appear")
  else
    _ARG_0_:GotoState("Idling")
  end
end
function b01cd00.OnMessage(_ARG_0_, _ARG_1_)
  if _ARG_1_ == SymphonyMaster.MSG_ATTACK_END and _ARG_0_:GetState() == "MusicalInstrumentAttack" then
    _ARG_0_.step = 0
  end
end
function b01cd00.OnBeginDamageReaction(_ARG_0_, _ARG_1_)
  Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
  _ARG_0_:SendMessageToMusicalInstrument(SymphonyMaster.MSG_STOP)
end
function b01cd00.OnReturnDamage(_ARG_0_)
  _ARG_0_.stack:clear()
  _ARG_0_:IsDestroyMusicalInstrument()
  Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
  _ARG_0_:GotoState("Hysteria")
end
function b01cd00.OnDead(_ARG_0_)
  SetupBossDead(_ARG_0_.myHandle)
  Entity.EnableDamageColl(_ARG_0_.trumpetHandle, 0)
  Entity.EnableDamageColl(_ARG_0_.violinHandle, 0)
  Entity.EnableDamageColl(_ARG_0_.drumHandle, 0)
  Entity.EnableLockon(_ARG_0_.trumpetHandle, 0)
  Entity.EnableLockon(_ARG_0_.violinHandle, 0)
  Entity.EnableLockon(_ARG_0_.drumHandle, 0)
  if Enemy.IsAttackerFront(_ARG_0_.myHandle) then
    Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
  else
    Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
  end
  _ARG_0_:GotoState("Dead")
  return 1
end
function b01cd00.OnSetMotion(_ARG_0_, _ARG_1_)
  if _ARG_1_ == _UPVALUE0_ or _ARG_1_ == _UPVALUE1_ then
    _ARG_0_:SendMessageToMusicalInstrument(SymphonyMaster.MSG_STOP)
  end
end
function b01cd00.GetCameraTargetPos(_ARG_0_)
  Entity.GetWorldPos(_ARG_0_.cameraTargetPos, _ARG_0_.myHandle)
  _ARG_0_.cameraTargetPos:sety(2)
  return _ARG_0_.cameraTargetPos
end
function b01cd00.OnUpdate(_ARG_0_)
  _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
  _ARG_0_:Update()
  _ARG_0_:Debug()
  if _ARG_0_.canMusicalInstrumentRot then
    _ARG_0_:RotateMusicalInstrument()
  end
  if _ARG_0_:GetState() ~= "Hysteria" and Entity.IsGround(_ARG_0_.myHandle) and _ARG_0_:IsDestroyMusicalInstrument() then
    _ARG_0_:GotoState("Hysteria")
  end
end
function b01cd00.Debug(_ARG_0_)
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
EntityFactory:Add("b01cd00", function(_ARG_0_)
  return (b01cd00:new())
end)
