WorldPos = FVECTOR3.new(0, 0, 0)
g05ex00 = {}
g05ex00_mt = {__index = g05ex00}
function g05ex00.new(_ARG_0_)
  return setmetatable({}, g05ex00_mt)
end
function g05ex00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  Entity.EnableMarkon(_ARG_1_, 1)
  if Entity.GetLayoutParam(_ARG_0_.myHandle, 5) ~= 0 then
    Entity.SetReplyDistSq(_ARG_1_, Entity.GetLayoutParam(_ARG_0_.myHandle, 5) * Entity.GetLayoutParam(_ARG_0_.myHandle, 5))
  else
    Entity.SetReplyDistSq(_ARG_1_, _UPVALUE0_)
  end
  Entity.SetCommandReply(_ARG_1_, COMMAND_KIND_Check)
  Entity.EnableBodyColl(_ARG_1_, 1)
  Entity.AttachEffect(_ARG_0_.myHandle, "g_ex_mrk_00", "G_EX_MRK_ZAK0_0", "Root", WorldPos, WorldPos)
end
function g05ex00.OnCommand(_ARG_0_, _ARG_1_)
  Exusia.LoadEvent("zkSelect.exa")
  Entity.OnCommandCheck(_ARG_0_.myHandle)
end
function g05ex00.OnUpdate(_ARG_0_)
  if Player.IsBattleFlagBattleOn() == 1 then
    Entity.EnableMarkon(_ARG_0_.myHandle, 0)
  else
    Entity.EnableMarkon(_ARG_0_.myHandle, 1)
  end
end
EntityFactory:Add("g05ex00", function(_ARG_0_)
  return (g05ex00:new())
end)
