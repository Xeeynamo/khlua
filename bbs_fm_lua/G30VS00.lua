g30vs00 = {}
g30vs00_base_mt = {__index = __StateMachine}
setmetatable(g30vs00, g30vs00_base_mt)
g30vs00_mt = {__index = g30vs00}
function g30vs00.new(_ARG_0_)
  return setmetatable(__StateMachine:new(), g30vs00_mt)
end
g30vs00.states = {
  Appear = {
    OnBeginState = function(_ARG_0_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_:GotoState("Idling")
    end
  },
  Waiting = {
    OnBeginState = function(_ARG_0_)
      print("Waiting\n")
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Enemy.IsAllEnemyWaiting() == false then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Idling = {
    OnBeginState = function(_ARG_0_)
      print("Idling\n")
      _ARG_0_:setMotion(_UPVALUE0_)
      Entity.SetTimer(_ARG_0_.myHandle, G30VS_IDLING_TIME)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.targetHandle = _ARG_0_:getShortPlayerHandle()
      if Entity.IsTimeOver(_ARG_0_.myHandle) and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE0_ then
        _ARG_0_:GotoState("AttackIdling")
      end
    end
  },
  AttackIdling = {
    OnBeginState = function(_ARG_0_)
      print("AttackIdling\n")
      _ARG_0_:setMotion(_UPVALUE0_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Attack")
      end
    end
  },
  Attack = {
    OnBeginState = function(_ARG_0_)
      print("AttackIdling\n")
      _ARG_0_:setMotion(_UPVALUE0_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Damage = {
    OnBeginState = function(_ARG_0_)
      print("Damage\n")
      _ARG_0_:setMotion(_UPVALUE0_)
      _ARG_0_.damageSave = _ARG_0_.damageSave + 1
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Faint = {
    OnBeginState = function(_ARG_0_)
      print("Faint\n")
      _ARG_0_:setMotion(_UPVALUE0_)
      _ARG_0_.step = 0
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
      Entity.EnableLockon(_ARG_0_.myHandle, 0)
    end,
    OnEndState = function(_ARG_0_)
      Entity.EnableLockon(_ARG_0_.myHandle, 1)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_.step = 1
          _ARG_0_:setMotion(_UPVALUE0_)
        end
      elseif _ARG_0_.step == 1 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  }
}
function g30vs00.setMotion(_ARG_0_, _ARG_1_)
  Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_1_)
end
function g30vs00.getShortPlayerHandle(_ARG_0_)
  if Player.GetPlayers() ~= NULL_HANDLE then
  end
  if Player.GetPlayers() ~= NULL_HANDLE then
  end
  if Player.GetPlayers() ~= NULL_HANDLE then
  end
  if Entity.CalcDistanceSq(_ARG_0_.myHandle, Player.GetPlayers()) > Entity.CalcDistanceSq(_ARG_0_.myHandle, Player.GetPlayers()) then
  end
  if Entity.CalcDistanceSq(_ARG_0_.myHandle, Player.GetPlayers()) < Entity.CalcDistanceSq(_ARG_0_.myHandle, Player.GetPlayers()) then
  end
  if Entity.CalcDistanceSq(_ARG_0_.myHandle, Player.GetPlayers()) < Entity.CalcDistanceSq(_ARG_0_.myHandle, Player.GetPlayers()) then
  end
  return Player.GetPlayers()
end
function g30vs00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.targetHandle = NULL_HANDLE
  _ARG_0_.step = 0
  _ARG_0_.damageSave = 0
  Gimmick.EnableNetwork(_ARG_1_, 1)
  _UPVALUE0_ = Entity.GetMotionIndex(_ARG_1_, "001")
  _UPVALUE1_ = Entity.GetMotionIndex(_ARG_1_, "002")
  _UPVALUE2_ = Entity.GetMotionIndex(_ARG_1_, "003")
  _UPVALUE3_ = Entity.GetMotionIndex(_ARG_1_, "004")
  _UPVALUE4_ = Entity.GetMotionIndex(_ARG_1_, "005")
  _UPVALUE5_ = Entity.GetMotionIndex(_ARG_1_, "006")
  Entity.SetReplyDistSq(_ARG_1_, 9)
  _UPVALUE6_ = Gimmick.GetExtraParam(_ARG_1_, "FaintT") * 60
  G30VS_IDLING_TIME = Gimmick.GetExtraParam(_ARG_1_, "IdlingT") * 60
  _UPVALUE7_ = Gimmick.GetExtraParam(_ARG_1_, "AttDist")
  _UPVALUE7_ = _UPVALUE7_ * _UPVALUE7_
  _UPVALUE8_ = Gimmick.GetExtraParam(_ARG_0_.myHandle, "FaintNum")
  Entity.EnableLockon(_ARG_0_.myHandle, 1)
  Entity.EnableBgColl(_ARG_0_.myHandle, 0)
  _UPVALUE7_ = 81
  _ARG_0_:GotoState("Waiting")
end
function g30vs00.OnDamage(_ARG_0_, _ARG_1_, _ARG_2_)
  print("ondamage\n")
  if _ARG_0_.damageSave >= _UPVALUE0_ then
    _ARG_0_.damageSave = 0
    if _ARG_0_:GetState() ~= "Faint" then
      _ARG_0_:GotoState("Faint")
      return 1
    end
  end
  if _ARG_0_:GetState() == "Faint" then
  else
    _ARG_0_:GotoState("Damage")
  end
  return 1
end
function g30vs00.createEffect(_ARG_0_, _ARG_1_, _ARG_2_)
  _UPVALUE0_:set(0, 0.01, 0)
  _UPVALUE1_:set(0, 0.01, 0)
  _ARG_0_.effectHandle = Entity.SetEffect(_ARG_0_.myHandle, _ARG_1_, _ARG_2_, _UPVALUE0_, _UPVALUE1_)
end
function g30vs00.OnUpdate(_ARG_0_)
  _ARG_0_:Update()
  Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
end
EntityFactory:Add("g30vs00", function(_ARG_0_)
  return (g30vs00:new())
end)
