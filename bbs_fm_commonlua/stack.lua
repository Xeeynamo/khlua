Stack = {}
Stack.__index = Stack

function Stack.Create()
  for _FORV_6_ = 1, 64 do
    table.insert({}, nil)
  end

  return setmetatable({
    _et = {},
    ptr = 1
  }, Stack)
end

function Stack.push(_ARG_0_, _ARG_1_)
  if _ARG_1_ then
    _ARG_0_._et[_ARG_0_.ptr] = _ARG_1_
    _ARG_0_.ptr = _ARG_0_.ptr + 1
  end
end

function Stack.pop(_ARG_0_)
  if _ARG_0_.ptr > 1 then
    _ARG_0_.ptr = _ARG_0_.ptr - 1
    _ARG_0_._et[_ARG_0_.ptr] = nil
    return _ARG_0_._et[_ARG_0_.ptr]
  end
  return nil
end

function Stack.get(_ARG_0_, _ARG_1_)
  if _ARG_0_.ptr > 1 then
    if _ARG_1_ ~= nil then
      return _ARG_0_._et[_ARG_0_.ptr - _ARG_1_]
    end
    return _ARG_0_._et[_ARG_0_.ptr - 1]
  end
  return nil
end

function Stack.getn(_ARG_0_)
  return _ARG_0_.ptr - 1
end

function Stack.isExist(_ARG_0_, _ARG_1_)
  for _FORV_6_ = 1, _ARG_0_.ptr do
    if _ARG_0_._et[_FORV_6_] == _ARG_1_ then
      return true
    end
  end
  return _FOR_
end

function Stack.clear(_ARG_0_)
  for _FORV_5_ = 1, _ARG_0_.ptr do
    _ARG_0_._et[_FORV_5_] = nil
  end
  _ARG_0_.ptr = 1
end