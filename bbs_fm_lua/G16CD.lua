g16cd = {}
g16cd_mt = {__index = g16cd}
function g16cd.new(_ARG_0_)
  return setmetatable({}, g16cd_mt)
end
function g16cd.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  Entity.SetReplyDistSq(_ARG_1_, 12.25)
  Entity.EnableMarkon(_ARG_1_, 1)
  Entity.SetCommandReply(_ARG_1_, COMMAND_KIND_Check)
  Entity.SetUserGroundColor(_ARG_1_, 1)
  if Item.GetHaveItemCount(KEY_WHITE_BUTTON) == 1 then
    print("\147\252\142\232\141\207\130\221\131A\131C\131e\131\128\129F\148\146\130\162\131{\131^\131\147\129F\131M\131~\131b\131N\148j\138\252\n")
    Entity.Out(_ARG_1_)
  end
end
function g16cd.OnUpdate(_ARG_0_)
end
function g16cd.OnCommand(_ARG_0_, _ARG_1_)
  if _ARG_1_ == COMMAND_KIND_Check then
    Exusia.LoadEvent("g16cd.exa")
    Entity.Out(_ARG_0_.myHandle)
  end
end
EntityFactory:Add("g16cd00", function(_ARG_0_)
  EntityManager:Add(g16cd:new(), _ARG_0_)
  return (g16cd:new())
end)
