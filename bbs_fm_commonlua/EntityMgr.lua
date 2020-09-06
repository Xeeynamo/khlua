EntityManager = {
  entities = {}
}
function EntityManager.Add(_ARG_0_, _ARG_1_, _ARG_2_)
  _ARG_0_.entities[_ARG_2_] = _ARG_1_
end
function EntityManager.Remove(_ARG_0_, _ARG_1_)
  if _ARG_0_.entities[_ARG_1_] ~= nil then
    _ARG_0_.entities[_ARG_1_] = nil
  end
end
function EntityManager.GetSize(_ARG_0_)
  for _FORV_5_, _FORV_6_ in pairs(_ARG_0_.entities) do
  end
  return 0 + 1
end
function EntityManager.GetEntity(_ARG_0_, _ARG_1_)
  if type(_ARG_1_) == "userdata" then
    return _ARG_0_.entities[_ARG_1_]
  elseif type(_ARG_1_) == "string" then
    for _FORV_6_, _FORV_7_ in pairs(_ARG_0_.entities) do
      if Entity.GetName(_FORV_6_) == _ARG_1_ then
        return _FORV_7_
      end
    end
  end
  return nil
end
function EntityManager.CallFunction(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if _ARG_0_.entities[_ARG_2_] ~= nil and _ARG_0_.entities[_ARG_2_][_ARG_1_] ~= nil then
    return true, (_ARG_0_.entities[_ARG_2_][_ARG_1_](_ARG_0_.entities[_ARG_2_], _ARG_3_))
  end
  return false, 0
end
function EntityManager.CallFunctionArg6(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_, _ARG_6_, _ARG_7_)
  if _ARG_0_.entities[_ARG_2_] ~= nil and _ARG_0_.entities[_ARG_2_][_ARG_1_] ~= nil then
    return true, (_ARG_0_.entities[_ARG_2_][_ARG_1_](_ARG_0_.entities[_ARG_2_], _ARG_3_, _ARG_4_, _ARG_5_, _ARG_6_, _ARG_7_))
  end
  return false, 0
end
function EntityManager.CallFunctionArg5(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_, _ARG_6_)
  if _ARG_0_.entities[_ARG_2_] ~= nil and _ARG_0_.entities[_ARG_2_][_ARG_1_] ~= nil then
    return true, (_ARG_0_.entities[_ARG_2_][_ARG_1_](_ARG_0_.entities[_ARG_2_], _ARG_3_, _ARG_4_, _ARG_5_, _ARG_6_))
  end
  return false, 0
end
function EntityManager.CallFunctionArg3(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_)
  if _ARG_0_.entities[_ARG_2_] ~= nil and _ARG_0_.entities[_ARG_2_][_ARG_1_] ~= nil then
    return true, (_ARG_0_.entities[_ARG_2_][_ARG_1_](_ARG_0_.entities[_ARG_2_], _ARG_3_, _ARG_4_, _ARG_5_))
  end
  return false, 0
end
function EntityManager.CallFunctionArg2(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if _ARG_0_.entities[_ARG_2_] ~= nil and _ARG_0_.entities[_ARG_2_][_ARG_1_] ~= nil then
    return true, (_ARG_0_.entities[_ARG_2_][_ARG_1_](_ARG_0_.entities[_ARG_2_], _ARG_3_, _ARG_4_))
  end
  return false, 0
end
function EntityManager.CallFunctionNoArg(_ARG_0_, _ARG_1_, _ARG_2_)
  if _ARG_0_.entities[_ARG_2_] ~= nil and _ARG_0_.entities[_ARG_2_][_ARG_1_] ~= nil then
    return true, (_ARG_0_.entities[_ARG_2_][_ARG_1_](_ARG_0_.entities[_ARG_2_]))
  end
  return false, 0
end
function EntityManager.HasFunction(_ARG_0_, _ARG_1_, _ARG_2_)
  if _ARG_0_.entities[_ARG_2_] ~= nil and _ARG_0_.entities[_ARG_2_][_ARG_1_] ~= nil then
    return true
  end
  return false
end
function EntityManager.CheckFunctions(_ARG_0_, _ARG_1_)
  if _ARG_0_.entities[_ARG_1_] ~= nil then
    for _FORV_8_, _FORV_9_ in pairs(_UPVALUE0_) do
    end
  end
  return 0 + 1
end
