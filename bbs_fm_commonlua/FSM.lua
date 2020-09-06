__StateMachine = {
  current_state = {},
  current_OnUpdate = nil,
  current_OnEnd = nil,
  change_count = 0,
  change_flag = false,
  change_state = false,
  noSetTargetHandle = false
}
__StateMachine.__index = __StateMachine
function __StateMachine.new(_ARG_0_)
  return setmetatable({}, __StateMachine)
end
function __StateMachine.HasState(_ARG_0_, _ARG_1_)
  for _FORV_5_, _FORV_6_ in pairs(_ARG_0_.states) do
    if _FORV_5_ == _ARG_1_ then
      return true
    end
  end
  return false
end
function __StateMachine.GetState(_ARG_0_)
  for _FORV_4_, _FORV_5_ in pairs(_ARG_0_.states) do
    if _FORV_5_ == _ARG_0_.current_state then
      return _FORV_4_
    end
  end
  return "unknown"
end
function __StateMachine.GetStateIndex(_ARG_0_)
  if _ARG_0_.states == nil then
    return -1
  end
  for _FORV_5_, _FORV_6_ in pairs(_ARG_0_.states) do
    if _FORV_6_ == _ARG_0_.current_state then
      return 1
    end
  end
  return -1
end
function __StateMachine.GotoStateIndex(_ARG_0_, _ARG_1_, _ARG_2_)
  if _ARG_0_.states == nil then
    return
  end
  for _FORV_7_, _FORV_8_ in pairs(_ARG_0_.states) do
    if _ARG_1_ == 1 then
      if _ARG_0_.CanGotoState ~= nil and _ARG_0_.CanGotoState(_ARG_0_) == false then
        return
      end
      if _ARG_2_ > _ARG_0_.change_count then
        _ARG_0_.change_count = _ARG_2_
        _ARG_0_:GotoStateSub(_FORV_7_)
      end
      return
    end
  end
end
function __StateMachine.GotoState(_ARG_0_, _ARG_1_)
  if Entity.HasNetGameHandle(_ARG_0_.myHandle) then
    if Entity.IsEnemy(_ARG_0_.myHandle) then
      if Enemy.IsNetworkMaster(_ARG_0_.myHandle) == false and _ARG_0_.change_flag then
        return
      end
    elseif Entity.IsGimmick(_ARG_0_.myHandle) and Gimmick.IsNetworkMaster(_ARG_0_.myHandle) == false and _ARG_0_.change_flag then
      return
    end
  end
  if Enemy.IsExternalControl(_ARG_0_.myHandle) then
    _ARG_0_.change_state = true
    return
  end
  _ARG_0_.change_flag = true
  _ARG_0_.change_count = _ARG_0_.change_count + 1
  _ARG_0_:GotoStateSub(_ARG_1_)
end
function __StateMachine.GotoStateSub(_ARG_0_, _ARG_1_)
  if _ARG_0_.states[_ARG_1_] ~= nil then
    if _ARG_0_.current_OnEnd ~= nil then
      _ARG_0_.current_OnEnd(_ARG_0_, _ARG_1_)
    end
    if _ARG_0_.states[_ARG_1_].OnBeginState ~= nil then
      _ARG_0_.states[_ARG_1_].OnBeginState(_ARG_0_)
    end
    _ARG_0_.current_state = _ARG_0_.states[_ARG_1_]
    _ARG_0_.current_OnUpdate = _ARG_0_.states[_ARG_1_].OnUpdate
    _ARG_0_.current_OnEnd = _ARG_0_.states[_ARG_1_].OnEndState
    _ARG_0_.change_state = false
  elseif _ARG_1_ ~= nil then
    print("state not found [" .. _ARG_1_ .. "]\n")
  else
    print("state not found [statename was nil]\n")
  end
end
function __StateMachine.GetChangeCount(_ARG_0_)
  return _ARG_0_.change_count
end
function __StateMachine.GetTargetHandle(_ARG_0_)
  return _ARG_0_.targetHandle
end
function __StateMachine.SetTargetHandle(_ARG_0_, _ARG_1_)
  if _ARG_0_.noSetTargetHandle == false then
    _ARG_0_.targetHandle = _ARG_1_
  end
end
function __StateMachine.SetTargetHandleForce(_ARG_0_, _ARG_1_)
  _ARG_0_.targetHandle = _ARG_1_
end
function __StateMachine.IsGotoState(_ARG_0_)
  return _ARG_0_.change_state
end
function __StateMachine.EnableNoSetTargetHandle(_ARG_0_, _ARG_1_)
  _ARG_0_.noSetTargetHandle = _ARG_1_
end
function __StateMachine.Update(_ARG_0_)
  if _ARG_0_.current_OnUpdate ~= nil then
    _ARG_0_.current_OnUpdate(_ARG_0_)
  end
end
