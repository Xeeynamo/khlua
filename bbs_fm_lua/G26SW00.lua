g26sw00 = {}
g26sw00.__index = g26sw00
function g26sw00.new(_ARG_0_)
  return setmetatable({}, g26sw00)
end
function g26sw00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.treeGhostHandle = NULL_HANDLE
  _ARG_0_.workVec0 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.step = 0
  Entity.EnableBgColl(_ARG_0_.myHandle, 1)
  Entity.EnableGravity(_ARG_0_.myHandle, 1)
  _ARG_0_.rideID = Entity.AttachRideCollision(_ARG_1_, 0, 0)
  Entity.SetModelOfsZ(_ARG_1_, 100)
end
function g26sw00.OnUpdate(_ARG_0_)
  if _ARG_0_.step == 0 then
  elseif _ARG_0_.step == 1 then
    if Entity.IsAlive(_ARG_0_.treeGhostHandle) then
      Entity.GetRot(_ARG_0_.workVec0, _ARG_0_.treeGhostHandle)
      Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.workVec0)
      Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.treeGhostHandle)
      Entity.SetLocalPos(_ARG_0_.myHandle, _ARG_0_.workVec0)
      Entity.SetOldLocalPos(_ARG_0_.myHandle, _ARG_0_.workVec0)
    end
  elseif _ARG_0_.step == 2 then
    _ARG_0_:createEffect("o_ms_073", "SW01_SMK2_0")
    _ARG_0_.step = 3
  elseif _ARG_0_.step == 3 then
  end
end
function g26sw00.createEffect(_ARG_0_, _ARG_1_, _ARG_2_)
  Entity.AttachEffect(_ARG_0_.myHandle, _ARG_1_, _ARG_2_, "Root")
end
function g26sw00.NotifyTransform(_ARG_0_)
  _ARG_0_:createTreeGhost()
  _ARG_0_.step = 1
end
function g26sw00.createTreeGhost(_ARG_0_)
  print("createTreeGhost\n")
  Entity.GetWorldPos(_ARG_0_.workVec1, _ARG_0_.myHandle)
  Entity.GetRot(_ARG_0_.workVec0, _ARG_0_.myHandle)
  Entity.EnableRideColl(_ARG_0_.myHandle, 0, 0)
  _ARG_0_.treeGhostHandle = Entity.CreateEntity("m01sw00", _ARG_0_.workVec1, _ARG_0_.workVec0, _ARG_0_.myHandle)
  _ARG_0_:createEffect("o_ms_073", "SW01_SMK2_0")
  Entity.EnableRideColl(_ARG_0_.myHandle, 0, 0)
  EntityManager:GetEntity(_ARG_0_.treeGhostHandle):GotoState("CreateIdling")
  Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 30)
  Entity.SetupModelFade(_ARG_0_.treeGhostHandle, 0, 1, 30)
  Entity.SetAlpha(_ARG_0_.treeGhostHandle, 0)
  _ARG_0_.step = 1
end
EntityFactory:Add("g26sw00", function(_ARG_0_)
  return (g26sw00:new())
end)
