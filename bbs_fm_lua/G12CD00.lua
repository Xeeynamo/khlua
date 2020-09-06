g12cd00 = {}
g12cd00_mt = {__index = g12cd00}
function g12cd00.new(_ARG_0_)
  return setmetatable({}, g12cd00_mt)
end
function g12cd00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.state = 0
  Entity.AttachRideCollision(_ARG_1_, 0, 2)
  Entity.AttachRideCollision(_ARG_1_, 1, 3)
  Entity.SetMotion(_ARG_1_, 1)
  Entity.EnableLockon(_ARG_1_, 1)
  Entity.SetMotion(_ARG_1_, 1)
end
function g12cd00.OnUpdate(_ARG_0_)
end
function g12cd00.OnDamage(_ARG_0_, _ARG_1_, _ARG_2_)
  if _ARG_1_ == ATK_KIND_DMG_BIG or _ARG_1_ == ATK_KIND_DMG_BLOW then
    if _ARG_0_.state == 0 then
      Entity.SetMotion(_ARG_0_.myHandle, 3)
      _ARG_0_.state = 1
    else
      Entity.SetMotion(_ARG_0_.myHandle, 4)
      _ARG_0_.state = 0
    end
  elseif _ARG_0_.state == 0 then
    Entity.SetMotion(_ARG_0_.myHandle, 5)
  else
    Entity.SetMotion(_ARG_0_.myHandle, 6)
  end
  return 1
end
EntityFactory:Add("g12cd00", function(_ARG_0_)
  return (g12cd00:new())
end)
