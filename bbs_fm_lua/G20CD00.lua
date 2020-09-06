g20cd00 = {}
g20cd00_mt = {__index = g20cd00}
function g20cd00.new(_ARG_0_)
  return setmetatable({}, g20cd00_mt)
end
function g20cd00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.workVec0 = FVECTOR3.new(0, 0, 0)
  Entity.SetMotion(_ARG_0_.myHandle, 1)
  Entity.AttachCoord(_ARG_1_, "X_g13cd", Entity.CreateEntity("g13cd00", _ARG_0_.workVec0, _ARG_0_.workVec0, _ARG_1_), "Root")
  Entity.AttachCoord(_ARG_1_, "X_g14cd", Entity.CreateEntity("g14cd00", _ARG_0_.workVec0, _ARG_0_.workVec0, _ARG_1_), "Root")
  Entity.EnableLockon(_ARG_1_, 1)
  Entity.SetLockOnBoneNum(_ARG_1_, 3)
end
function g20cd00.OnUpdate(_ARG_0_)
end
function g20cd00.OnDamage(_ARG_0_, _ARG_1_, _ARG_2_)
  Entity.SetMotion(_ARG_0_.myHandle, 2)
  return 1
end
EntityFactory:Add("g20cd00", function(_ARG_0_)
  return (g20cd00:new())
end)
