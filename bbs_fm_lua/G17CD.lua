g17cd = {}
g17cd_mt = {__index = g17cd}
function g17cd.new(_ARG_0_)
  return setmetatable({}, g17cd_mt)
end
function g17cd.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  Entity.SetReplyDistSq(_ARG_1_, 12.25)
  Entity.EnableMarkon(_ARG_1_, 1)
  Entity.SetCommandReply(_ARG_1_, COMMAND_KIND_Check)
  Entity.SetUserGroundColor(_ARG_1_, 1)
  if Item.GetHaveItemCount(KEY_PINK_CLOTH) == 1 then
    print("\147\252\142\232\141\207\130\221\131A\131C\131e\131\128\129F\131s\131\147\131N\130\204\149z\129F\131M\131~\131b\131N\148j\138\252\n")
    Entity.Out(_ARG_1_)
  end
end
function g17cd.OnUpdate(_ARG_0_)
end
function g17cd.OnCommand(_ARG_0_, _ARG_1_)
  if _ARG_1_ == COMMAND_KIND_Check then
    Exusia.LoadEvent("g17cd.exa")
    Entity.Out(_ARG_0_.myHandle)
  end
end
EntityFactory:Add("g17cd00", function(_ARG_0_)
  EntityManager:Add(g17cd:new(), _ARG_0_)
  return (g17cd:new())
end)
