g15cd = {}
g15cd_mt = {__index = g15cd}
function g15cd.new(_ARG_0_)
  return setmetatable({}, g15cd_mt)
end
function g15cd.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  Entity.SetReplyDistSq(_ARG_1_, 6.25)
  Entity.EnableMarkon(_ARG_1_, 1)
  Entity.SetCommandReply(_ARG_1_, COMMAND_KIND_Check)
  Entity.SetUserGroundColor(_ARG_1_, 1)
  if Item.GetHaveItemCount(KEY_RIBBON) == 1 then
    print("\147\252\142\232\141\207\130\221\131A\131C\131e\131\128\129F\131\138\131{\131\147\129F\131M\131~\131b\131N\148j\138\252\n")
    Entity.Out(_ARG_1_)
  end
end
function g15cd.OnUpdate(_ARG_0_)
end
function g15cd.OnCommand(_ARG_0_, _ARG_1_)
  if _ARG_1_ == COMMAND_KIND_Check then
    Exusia.LoadEvent("g15cd.exa")
    Entity.Out(_ARG_0_.myHandle)
  end
end
EntityFactory:Add("g15cd00", function(_ARG_0_)
  EntityManager:Add(g15cd:new(), _ARG_0_)
  return (g15cd:new())
end)
