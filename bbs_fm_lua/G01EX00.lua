g01ex00 = {}
g01ex00_mt = {__index = g01ex00}
function g01ex00.new(_ARG_0_)
  return setmetatable({}, g01ex00_mt)
end
function g01ex00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.effecthandle = NULL_HANDLE
  _ARG_0_.Portalhandle = NULL_HANDLE
  _ARG_0_.alpha = 1
  _ARG_0_.effectCnt = 0
  _ARG_0_.addhp = Gimmick.GetExtraParam(_ARG_1_, "AddHPNum")
  _UPVALUE0_ = Gimmick.GetExtraParam(_ARG_1_, "Alpha")
  Entity.EnableMarkon(_ARG_1_, 1)
  Entity.SetReplyDistSq(_ARG_1_, _UPVALUE1_)
  Entity.SetCommandReply(_ARG_1_, COMMAND_KIND_Save)
  _ARG_0_.WorldPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.step = 0
  Entity.GetRot(_ARG_0_.rot, _ARG_1_)
  _ARG_0_.Portalhandle = NULL_HANDLE
end
function g01ex00.crateSaveMainEffect(_ARG_0_)
  if _ARG_0_.Portalhandle == NULL_HANDLE then
    print("\131Z\129[\131u\131|\131C\131\147\131g\144\182\144\172\n")
    _ARG_0_.Portalhandle = Entity.AttachEffect(_ARG_0_.myHandle, "g_ex_001_00", "G01EX_SVP_00_0", "Root", _ARG_0_.WorldPos, _ARG_0_.rot)
  end
end
function g01ex00.LoopEndEffect(_ARG_0_)
  if _ARG_0_.Portalhandle then
    Effect.LoopEnd(_ARG_0_.Portalhandle)
    _ARG_0_.Portalhandle = NULL_HANDLE
  end
end
function g01ex00.OnCommand(_ARG_0_, _ARG_1_)
  Gimmick.MenuLauncher(ID_SAVEPOINT)
  Entity.OnCommandCheck(_ARG_0_.myHandle)
end
function g01ex00.OnUpdate(_ARG_0_)
  if Player.IsBattleFlagBattleOn_Save() == 1 then
    _ARG_0_:LoopEndEffect()
    Entity.EnableMarkon(_ARG_0_.myHandle, 0)
    return
  else
    Entity.EnableMarkon(_ARG_0_.myHandle, 1)
    _ARG_0_:crateSaveMainEffect()
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, (Player.GetHandle())) < _UPVALUE0_ then
      if _ARG_0_.step == 0 then
        Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
        _ARG_0_.effecthandle = Entity.AttachEffect(_ARG_0_.myHandle, "g_ex_001_00", "G01EX_SVP_01_0", "Root", _ARG_0_.WorldPos, _ARG_0_.rot)
        _ARG_0_.step = 1
      end
      Player.AddHP(Player.GetHandle(), _ARG_0_.addhp)
      return
    elseif Player.GetPlayerHPMax() > Player.GetPlayerHP() then
      _ARG_0_.step = 0
    end
  end
  return
end
EntityFactory:Add("g01ex00", function(_ARG_0_)
  return (g01ex00:new())
end)
