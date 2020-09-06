function CreateClass(_ARG_0_)
  setmetatable({
    new = function(_ARG_0_, ...)
      setmetatable({class = _UPVALUE1_, super = _UPVALUE2_}, _UPVALUE0_)
      {class = _UPVALUE1_, super = _UPVALUE2_}:constructor(unpack(nil))
      print("Lua::new Class\n")
      return {class = _UPVALUE1_, super = _UPVALUE2_}
    end
  }, {__index = _ARG_0_})
  return {
    new = function(_ARG_0_, ...)
      setmetatable({class = _UPVALUE1_, super = _UPVALUE2_}, _UPVALUE0_)
      {class = _UPVALUE1_, super = _UPVALUE2_}:constructor(unpack(nil))
      print("Lua::new Class\n")
      return {class = _UPVALUE1_, super = _UPVALUE2_}
    end
  }
end
EnemyBase = {}
EnemyBase_base_mt = {__index = __StateMachine}
setmetatable(EnemyBase, EnemyBase_base_mt)
EnemyBase_mt = {__index = EnemyBase}
function EnemyBase.new(_ARG_0_)
  return setmetatable(__StateMachine:new(), EnemyBase_mt)
end
function EnemyBase.constructor(_ARG_0_)
  print("EnemyBase::constructor\n")
end
function EnemyBase.className(_ARG_0_)
  print("EnemyBase::EnemyBase\n")
end
function EnemyBase.BaseMove(_ARG_0_, _ARG_1_)
  return print("call EnemyBase::Move\n")
end
function CreateEnemyBase(_ARG_0_)
  return (setmetatable(EnemyBase:new(), {__index = _ARG_0_}))
end
function getEnemyBase(_ARG_0_)
  print("Lua::call getEnemyBase()\n")
  return setmetatable(_ARG_0_, {__index = EnemyBase})
end
