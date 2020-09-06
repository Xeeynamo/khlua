g02ex00 = {}
g02ex00_mt = {__index = g02ex00}
function g02ex00.new(_ARG_0_)
  return setmetatable({}, g02ex00_mt)
end
function g02ex00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.messageHandle = NULL_HANDLE
  _ARG_0_.messageID = Entity.GetLayoutParam(_ARG_0_.myHandle, 11)
  Entity.EnableMarkon(_ARG_1_, 1)
  if Entity.GetLayoutParam(_ARG_0_.myHandle, 5) ~= 0 then
    Entity.SetReplyDistSq(_ARG_1_, Entity.GetLayoutParam(_ARG_0_.myHandle, 5) * Entity.GetLayoutParam(_ARG_0_.myHandle, 5))
  else
    Entity.SetReplyDistSq(_ARG_1_, _UPVALUE0_)
  end
  Entity.SetCommandReply(_ARG_1_, COMMAND_KIND_Check)
end
function g02ex00.OnCommand(_ARG_0_, _ARG_1_)
  if _ARG_0_.messageHandle == NULL_HANDLE then
    _ARG_0_.messageHandle = Wnd.CreateMesWndForString(_ARG_0_.messageID)
  end
end
function g02ex00.OnUpdate(_ARG_0_)
  if Player.IsBattleFlagBattleOn() == 1 then
    Entity.EnableMarkon(_ARG_0_.myHandle, 0)
  else
    Entity.EnableMarkon(_ARG_0_.myHandle, 1)
  end
  if _ARG_0_.messageHandle ~= NULL_HANDLE and Wnd.IsWindowAnimEnd(_ARG_0_.messageHandle) and (Pad.IsButtonTrg(PAD_CIRCLE) ~= 0 or Pad.IsButtonTrg(PAD_CROSS) ~= 0) then
    print("\131E\131B\131\147\131h\131E\130\240\149\194\130\182\130\220\130\183.\n")
    Wnd.MesWndClose(_ARG_0_.messageHandle)
    _ARG_0_.messageHandle = NULL_HANDLE
    Entity.OnCommandCheck(_ARG_0_.myHandle)
  end
end
EntityFactory:Add("g02ex00", function(_ARG_0_)
  return (g02ex00:new())
end)
