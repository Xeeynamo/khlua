g03 = {}
g03_mt = {__index = g03}
function g03.new(_ARG_0_)
  return setmetatable({}, g03_mt)
end
function g03.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  Entity.InitCollision(_ARG_1_, "g03")
  Entity.EnableBgColl(_ARG_1_, 0)
  Entity.EnableGravity(_ARG_1_, 0)
  Entity.EnableMarkon(_ARG_1_, 1)
  Entity.SetUserGroundColor(_ARG_1_, 1)
  Entity.SetReplyDistSq(_ARG_1_, DISTSQ_OPEN)
  Entity.SetCommandReply(_ARG_1_, COMMAND_KIND_Open)
  Entity.SetTimer(_ARG_1_, 30)
end
function g03.OnUpdate(_ARG_0_)
  if _ARG_0_.step == 0 then
    if Entity.IsTimeOver(_ARG_0_.myHandle) then
      Entity.SetUserGroundColor(_ARG_0_.myHandle, 0)
      _ARG_0_.step = 2
    end
  elseif _ARG_0_.step == 1 and Entity.IsMotionEnd(Player.GetHandle()) then
    Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
    Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
    Entity.CreateEntity("m08ex00", _UPVALUE0_, _UPVALUE1_)
    Entity.Out(_ARG_0_.myHandle)
  end
end
function g03.OnCommand(_ARG_0_, _ARG_1_)
  if _ARG_1_ == COMMAND_KIND_Open then
    _ARG_0_.step = 1
    Entity.EnableMarkon(_ARG_0_.myHandle, 0)
  end
end
if Script.GetCurrentWorld() == WORLD_ID_CD then
  EntityFactory:Add("g03cd00", function(_ARG_0_)
    return (g03:new())
  end)
elseif Script.GetCurrentWorld() == WORLD_ID_DC then
  EntityFactory:Add("g03dc00", function(_ARG_0_)
    return (g03:new())
  end)
elseif Script.GetCurrentWorld() == WORLD_ID_DI then
  EntityFactory:Add("g03di00", function(_ARG_0_)
    return (g03:new())
  end)
elseif Script.GetCurrentWorld() == WORLD_ID_DP then
  EntityFactory:Add("g03dp00", function(_ARG_0_)
    return (g03:new())
  end)
elseif Script.GetCurrentWorld() == WORLD_ID_HE then
  EntityFactory:Add("g03he00", function(_ARG_0_)
    return (g03:new())
  end)
elseif Script.GetCurrentWorld() == WORLD_ID_JB then
  EntityFactory:Add("g03jb00", function(_ARG_0_)
    return (g03:new())
  end)
elseif Script.GetCurrentWorld() == WORLD_ID_KG then
  EntityFactory:Add("g03kg00", function(_ARG_0_)
    return (g03:new())
  end)
elseif Script.GetCurrentWorld() == WORLD_ID_LS then
  EntityFactory:Add("g03ls00", function(_ARG_0_)
    return (g03:new())
  end)
elseif Script.GetCurrentWorld() == WORLD_ID_PP then
  EntityFactory:Add("g03pp00", function(_ARG_0_)
    return (g03:new())
  end)
elseif Script.GetCurrentWorld() == WORLD_ID_RG then
  EntityFactory:Add("g03rg00", function(_ARG_0_)
    return (g03:new())
  end)
elseif Script.GetCurrentWorld() == WORLD_ID_SB then
  EntityFactory:Add("g03sb00", function(_ARG_0_)
    return (g03:new())
  end)
elseif Script.GetCurrentWorld() == WORLD_ID_SW then
  EntityFactory:Add("g03sw00", function(_ARG_0_)
    return (g03:new())
  end)
elseif Script.GetCurrentWorld() == WORLD_ID_VS then
  EntityFactory:Add("g03vs00", function(_ARG_0_)
    return (g03:new())
  end)
elseif Script.GetCurrentWorld() == WORLD_ID_YT then
  EntityFactory:Add("g03yt00", function(_ARG_0_)
    return (g03:new())
  end)
else
  EntityFactory:Add("g03cd00", function(_ARG_0_)
    return (g03:new())
  end)
end
