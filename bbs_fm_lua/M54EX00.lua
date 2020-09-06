WorkVec = FVECTOR3.new(0, 0, 0)
WorkVec0 = FVECTOR3.new(0, 0, 0)
WorkVec1 = FVECTOR3.new(0, 0, 0)
WorkVec2 = FVECTOR3.new(0, 0, 0)
WorkVec3 = FVECTOR3.new(0, 0, 0)
WorkVec4 = FVECTOR3.new(0, 0, 0)
WorkVec5 = FVECTOR3.new(0, 0, 0)
WorkRot = FVECTOR3.new(0, 0, 0)
WorkRot2 = FVECTOR3.new(0, 0, 0)
M54EX_INIT_PARAM = false
m54ex00 = {}
m54ex00_base_mt = {__index = __StateMachine}
setmetatable(m54ex00, m54ex00_base_mt)
m54ex00_mt = {__index = m54ex00}
function m54ex00.new(_ARG_0_)
  return setmetatable(__StateMachine:new(), m54ex00_mt)
end
m54ex00.states = {
  Appear = {
    OnBeginState = function(_ARG_0_)
      SetupAppearBegin2(_ARG_0_.myHandle, 1, _UPVALUE0_, 0)
      Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
    end,
    OnEndState = function(_ARG_0_)
      SetupAppearEnd(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_:GotoState("Idling")
    end
  },
  Idling = {
    OnBeginState = function(_ARG_0_)
      print("m54ex00:Idling\n")
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.onDamageFlag = _ARG_0_.onDamageFlag - 0.01 * Entity.GetFrameRate(_ARG_0_.myHandle)
      if _ARG_0_.onDamageFlag < 0 then
        _ARG_0_.onDamageFlag = 0
      end
    end
  },
  AirIdling = {
    OnBeginState = function(_ARG_0_)
      print("m54ex00:AirIdling\n")
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.onDamageFlag = 0
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.downTimer = _ARG_0_.downTimer - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      if _ARG_0_.downTimer < 0 then
        _ARG_0_:GotoState("InTheGround")
      end
    end
  },
  InTheAir = {
    OnBeginState = function(_ARG_0_)
      print("m54ex00:InTheAir\n")
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.downTimer = 60
      _ARG_0_.onDamageFlag = 0
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("AirIdling")
      end
    end
  },
  DamageReaction = {
    OnBeginState = function(_ARG_0_)
      print("m54ex00:DamageReaction\n")
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
      _ARG_0_.downTimer = 60
      if Script.Random() < 0.5 then
        Entity.CreatePrize(_ARG_0_.myHandle, ITEM_KIND_MANDORAKE1)
      else
        Entity.CreatePrize(_ARG_0_.myHandle, ITEM_KIND_MANDORAKE2)
      end
      if _ARG_0_:DamageComCheck() == 1 then
        return
      end
      if Script.Random() < 0.5 then
        if Script.Random() < 0.5 then
          Entity.CreatePrize(_ARG_0_.myHandle, ITEM_KIND_MANDORAKE1)
        else
          Entity.CreatePrize(_ARG_0_.myHandle, ITEM_KIND_MANDORAKE2)
        end
      end
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.downTimer = _ARG_0_.downTimer - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      if _ARG_0_.step == 0 then
        _ARG_0_.step = 1
      elseif _ARG_0_.step == 1 and _ARG_0_.downTimer < 0 then
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_.downTimer = _UPVALUE0_
        _ARG_0_:GotoState("AirIdling")
      end
    end
  },
  BigDamageReaction = {
    OnBeginState = function(_ARG_0_)
      print("m54ex00:BigDamageReaction\n")
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.onDamageFlag = 0
      _ARG_0_.step = 0
      _ARG_0_.downTimer = 60
      for _FORV_4_ = 0, 9 do
        if Script.Random() < 0.5 then
          Entity.CreatePrize(_ARG_0_.myHandle, ITEM_KIND_MANDORAKE1)
        else
          Entity.CreatePrize(_ARG_0_.myHandle, ITEM_KIND_MANDORAKE2)
        end
        if _ARG_0_:DamageComCheck() == 1 then
          return
        end
      end
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_.onDamageFlag = 0
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.downTimer = _ARG_0_.downTimer - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      if _ARG_0_.step == 0 then
        _ARG_0_.step = 1
      elseif _ARG_0_.step == 1 and _ARG_0_.downTimer < 0 then
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_.downTimer = _UPVALUE0_
        _ARG_0_:GotoState("AirIdling")
      end
    end
  },
  GroundDamage = {
    OnBeginState = function(_ARG_0_)
      print("m54ex00:GroundDamage\n")
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  InTheGround = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
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
        _ARG_0_:GotoState("Appear")
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
function m54ex00.DamageComCheck(_ARG_0_, _ARG_1_)
  if Entity.GetDamageCommandKind(_ARG_0_.myHandle) == COMMAND_KIND_Thunder or Entity.GetDamageCommandKind(_ARG_0_.myHandle) == COMMAND_KIND_Thundra or Entity.GetDamageCommandKind(_ARG_0_.myHandle) == COMMAND_KIND_Thundaga or Entity.GetDamageCommandKind(_ARG_0_.myHandle) == COMMAND_KIND_Magne or Entity.GetDamageCommandKind(_ARG_0_.myHandle) == COMMAND_KIND_Magnera or Entity.GetDamageCommandKind(_ARG_0_.myHandle) == COMMAND_KIND_Magnega or Entity.GetDamageCommandKind(_ARG_0_.myHandle) == COMMAND_KIND_Aero or Entity.GetDamageCommandKind(_ARG_0_.myHandle) == COMMAND_KIND_Aera or Entity.GetDamageCommandKind(_ARG_0_.myHandle) == COMMAND_KIND_Aeroga or Entity.GetDamageCommandKind(_ARG_0_.myHandle) == COMMAND_KIND_MagneSpiral or Entity.GetDamageCommandKind(_ARG_0_.myHandle) == COMMAND_KIND_RagingStorm then
    print("\142w\146\232\131R\131}\131\147\131h\129I\129I\129I\131h\131\141\131b\131v\130\2051\140\194\130\197\130\183\129B")
    return 1
  end
  return 0
end
function m54ex00.DamageMove(_ARG_0_, _ARG_1_)
  WorkRot:set(0, Entity.CalcDirection(_ARG_0_.targetHandle, _ARG_0_.myHandle), 0)
  WorkVec:set(0, 0, 1)
  Math.RotateVectorXYZ(WorkVec, WorkRot)
  WorkVec:scale(1.5)
  Entity.GetWorldPos(WorkVec1, _ARG_0_.myHandle)
  FVECTOR3.Add(WorkVec, WorkVec1, WorkVec)
  Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 16)
  Entity.GetRot(WorkRot, _ARG_0_.myHandle)
  WorkRot:sety(Entity.CalcDirection(_ARG_0_.myHandle, WorkVec))
  WorkVec2:set(0, 1, 1)
  Math.RotateVectorXYZ(WorkVec2, WorkRot)
  WorkVec2:scale(_ARG_1_)
  WorkVec2:sety(WorkVec2:gety() * 1.8)
  WorkVec2:setx(WorkVec2:getx() * 0.2)
  WorkVec2:setz(WorkVec2:getz() * 0.2)
  Entity.SetVelocity(_ARG_0_.myHandle, WorkVec2)
end
function m54ex00.OnInit(_ARG_0_, _ARG_1_)
  _UPVALUE0_ = Entity.GetMotionIndex(_ARG_1_, "010")
  _UPVALUE1_ = Entity.GetMotionIndex(_ARG_1_, "500")
  _UPVALUE2_ = Entity.GetMotionIndex(_ARG_1_, "501")
  _UPVALUE3_ = Entity.GetMotionIndex(_ARG_1_, "502")
  _UPVALUE4_ = Entity.GetMotionIndex(_ARG_1_, "503")
  _UPVALUE5_ = Entity.GetMotionIndex(_ARG_1_, "504")
  _UPVALUE6_ = Entity.GetMotionIndex(_ARG_1_, "505")
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.targetHandle = NULL_HANDLE
  _ARG_0_.Type = 0
  _ARG_0_.AttackDelayTime = 0
  _ARG_0_.FeelingsDelayTime = 0
  _ARG_0_.hitAttackFlag = 0
  _ARG_0_.loopCnt = 0
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkTime = 0
  _ARG_0_.noWallHitTime = 0
  _ARG_0_.noPLTime = 0
  _ARG_0_.wanderAng = 0
  _ARG_0_.downTimer = 0
  _ARG_0_.damagePoint = 0
  _ARG_0_.onDamageFlag = 0
  Player.SetBattleFlagTargetHpOff(1)
  _ARG_0_.WorkVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.cameraPos = FVECTOR3.new(0, 0, 0)
  if M54EX_INIT_PARAM == false then
    _UPVALUE7_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "DameCnt")
    _UPVALUE8_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "FastFrame")
    _UPVALUE9_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "AftDameFra")
    M54EX_INIT_PARAM = true
  end
  Enemy.SetSeFileID(_ARG_1_, 296)
  Entity.SetMovementCollRadius(_ARG_0_.myHandle, 0.7)
  Entity.SetLowerHalf(_ARG_0_.myHandle, 0.9)
  Entity.EnableHeavy(_ARG_0_.myHandle, 1)
  Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
  Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
  Entity.EnableLockon(_ARG_0_.myHandle, 0)
  Entity.EnableShooton(_ARG_0_.myHandle, 0)
  Entity.EnableGravity(_ARG_0_.myHandle, 1)
  Enemy.IsAllEnemyWaiting()
  Enemy.EnableNoBattleMode(_ARG_1_, 1)
  if Enemy.IsAllEnemyWaiting() == true then
    _ARG_0_:GotoState("Standby")
  else
    _ARG_0_:GotoState("Appear")
    Entity.EnableLockon(_ARG_0_.myHandle, 1)
  end
end
function m54ex00.OnDamage(_ARG_0_, _ARG_1_)
  return 1
end
function m54ex00.OnDamageBefore(_ARG_0_, _ARG_1_)
  print("Attaker1 Name = " .. Entity.GetName(Entity.GetAttacker(_ARG_0_.myHandle)) .. "\n")
  if Entity.GetName(Entity.GetAttacker(_ARG_0_.myHandle)) == "m54ex00" then
    print("\147G\130\169\130\231\130\204\141U\140\130\130\200\130\204\130\197\150\179\140\248\129I\129I\n")
    return 1
  end
  Entity.GetDamageCrossPos(WorkVec, _ARG_0_.myHandle)
  WorkVec2:set(0, 0, 0)
  Entity.SetEffect(_ARG_0_.myHandle, "e_ex540", "E054_HIT_00_0", WorkVec, WorkVec2)
  Entity.TurnTargetYDegree(_ARG_0_.myHandle, Player.GetHandle(), 180)
  _ARG_0_.downTimer = _UPVALUE0_
  if _ARG_0_:GetState() == "InTheAir" or _ARG_0_:GetState() == "AirIdling" or _ARG_0_:GetState() == "BigDamageReaction" or _ARG_0_:GetState() == "DamageReaction" then
  else
    _ARG_0_.onDamageFlag = _ARG_0_.onDamageFlag + 1
    print("self.onDamageFlag = " .. _ARG_0_.onDamageFlag .. "\n")
    if _ARG_0_.onDamageFlag >= _UPVALUE1_ then
      _ARG_0_:GotoState("InTheAir")
      return 1
    end
  end
  if _ARG_0_:GetState() == "InTheGround" or _ARG_0_:GetState() == "GroundDamage" then
    return 1
  end
  if _ARG_0_:GetState() == "Idling" then
    _ARG_0_:GotoState("GroundDamage")
    return 1
  end
  if _ARG_1_ == ATK_KIND_DMG_BLOW or _ARG_1_ == ATK_KIND_DMG_BIG then
    _ARG_0_:GotoState("BigDamageReaction")
  else
    _ARG_0_:GotoState("DamageReaction")
  end
  return 1
end
function m54ex00.OnReturnDamage(_ARG_0_)
end
function m54ex00.OnHitAttack(_ARG_0_)
  _ARG_0_.hitAttackFlag = 1
end
function m54ex00.GetDamageMotionNum(_ARG_0_, _ARG_1_)
  if (_ARG_0_:GetState() == "UndergroundIdling" or _ARG_0_:GetState() == "LeafCutter") and _ARG_1_ == DMG_MOT_FAINT then
    return 19
  end
  return -1
end
function m54ex00.Debug(_ARG_0_)
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
function m54ex00.OnUpdate(_ARG_0_)
  _ARG_0_:Update()
  _ARG_0_:Debug()
end
EntityFactory:Add("m54ex00", function(_ARG_0_)
  return (m54ex00:new())
end)
EntityFactory:Add("m19vs00", function(_ARG_0_)
  return (m54ex00:new())
end)
