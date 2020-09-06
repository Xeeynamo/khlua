g18cd = {}
g18cd_mt = {__index = g18cd}
function g18cd.new(_ARG_0_)
  return setmetatable({}, g18cd_mt)
end
function g18cd.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  Entity.SetReplyDistSq(_ARG_1_, 12.25)
  Entity.EnableMarkon(_ARG_1_, 1)
  Entity.SetCommandReply(_ARG_1_, COMMAND_KIND_Check)
  Entity.SetUserGroundColor(_ARG_1_, 1)
  if Item.GetHaveItemCount(KEY_WHITE_LACE) == 1 then
    print("\147\252\142\232\141\207\130\221\131A\131C\131e\131\128\129F\148\146\130\162\131\140\129[\131X\129F\131M\131~\131b\131N\148j\138\252\n")
    Entity.Out(_ARG_1_)
  end
end
function g18cd.OnUpdate(_ARG_0_)
end
function g18cd.OnCommand(_ARG_0_, _ARG_1_)
  if _ARG_1_ == COMMAND_KIND_Check then
    Exusia.LoadEvent("g18cd.exa")
    Entity.Out(_ARG_0_.myHandle)
  end
end
function Create_g18cd(_ARG_0_)
  EntityManager:Add(g18cd:new(), _ARG_0_)
  return (g18cd:new())
end
EntityFactory:Add("g18cd00", function(_ARG_0_)
  EntityManager:Add(g18cd:new(), _ARG_0_)
  return (g18cd:new())
end)
