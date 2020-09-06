g10rg00 = {}
g10rg00_mt = {__index = g10rg00}
function g10rg00.new(_ARG_0_)
  return setmetatable({}, g10rg00_mt)
end
function g10rg00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  if Gimmick.IsBattlediesOpenWorld(WORLD_ID_WP) == true then
    Entity.EnableMarkon(_ARG_1_, 0)
  else
    Entity.EnableMarkon(_ARG_1_, 1)
  end
  Entity.SetReplyDistSq(_ARG_1_, 9)
  Entity.SetCommandReply(_ARG_1_, COMMAND_KIND_Check)
end
function g10rg00.OnCommand(_ARG_0_, _ARG_1_)
  Gimmick.TriggerFire(_ARG_0_.myHandle)
end
function g10rg00.OnUpdate(_ARG_0_)
end
EntityFactory:Add("g10rg00", function(_ARG_0_)
  EntityManager:Add(g10rg00:new(), _ARG_0_)
  return (g10rg00:new())
end)
