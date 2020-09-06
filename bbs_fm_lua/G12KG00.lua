g12kg00 = {}
g12kg00_mt = {__index = g12kg00}
function g12kg00.new(_ARG_0_)
  return setmetatable({}, g12kg00_mt)
end
function g12kg00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  Entity.EnableMarkon(_ARG_1_, 1)
  if Entity.GetLayoutParam(_ARG_0_.myHandle, 5) ~= 0 then
    Entity.SetReplyDistSq(_ARG_1_, Entity.GetLayoutParam(_ARG_0_.myHandle, 5) * Entity.GetLayoutParam(_ARG_0_.myHandle, 5))
  else
    Entity.SetReplyDistSq(_ARG_1_, _UPVALUE0_)
  end
  Entity.SetCommandReply(_ARG_1_, COMMAND_KIND_Check)
  Entity.EnableBodyColl(_ARG_1_, 1)
end
function g12kg00.OnCommand(_ARG_0_, _ARG_1_)
  Exusia.LoadEvent("gmSelect.exa")
end
function g12kg00.OnUpdate(_ARG_0_)
  if Player.IsBattleFlagBattleOn() == 1 then
    Entity.EnableMarkon(_ARG_0_.myHandle, 0)
  else
    Entity.EnableMarkon(_ARG_0_.myHandle, 1)
  end
end
EntityFactory:Add("g12kg00", function(_ARG_0_)
  return (g12kg00:new())
end)
