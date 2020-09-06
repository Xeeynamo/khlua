g16sb00 = {}
g16sb00_mt = {__index = g16sb00}
function g16sb00.new(_ARG_0_)
  return setmetatable({}, g16sb00_mt)
end
function g16sb00.GetLockOnPos(_ARG_0_)
  _ARG_0_.lockOnPos:set(0, _UPVALUE0_, 0)
  Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "X_marker", _ARG_0_.lockOnPos)
  return _ARG_0_.lockOnPos
end
function g16sb00.GetCameraTargetPos(_ARG_0_)
  _ARG_0_.lockOnPos:set(0, _UPVALUE0_, 0)
  Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "X_marker", _ARG_0_.lockOnPos)
  return _ARG_0_.lockOnPos
end
function g16sb00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.isRide = false
  _ARG_0_.lockOnPos = FVECTOR3.new(0, 0, 0)
  Entity.EnableMarkon(_ARG_1_, 1)
  Entity.SetReplyDistSq(_ARG_1_, DISTSQ_CHECK)
  Entity.SetCommandReply(_ARG_1_, COMMAND_KIND_Check)
  if _UPVALUE0_ == 0 then
    _UPVALUE1_ = Gimmick.GetExtraParam(_ARG_1_, "LockOnPos")
    _UPVALUE0_ = 1
  end
end
function g16sb00.OnUpdate(_ARG_0_)
end
EntityFactory:Add("g16sb00", function(_ARG_0_)
  EntityManager:Add(g16sb00:new(), _ARG_0_)
  return (g16sb00:new())
end)
