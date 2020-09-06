g24ls00 = {}
g24ls00_mt = {__index = g24ls00}
function g24ls00.new(_ARG_0_)
  return setmetatable({}, g24ls00_mt)
end
function g24ls00.GetLockOnPos(_ARG_0_)
  _ARG_0_.lockOnPos:set(0, _UPVALUE0_, 0)
  Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "X_marker", _ARG_0_.lockOnPos)
  return _ARG_0_.lockOnPos
end
function g24ls00.GetCameraTargetPos(_ARG_0_)
  _ARG_0_.lockOnPos:set(0, _UPVALUE0_, 0)
  Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "X_marker", _ARG_0_.lockOnPos)
  return _ARG_0_.lockOnPos
end
function g24ls00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.lockOnPos = FVECTOR3.new(0, 0, 0)
  Entity.EnableMarkon(_ARG_1_, 1)
  Entity.SetReplyDistSq(_ARG_1_, DISTSQ_CHECK)
  Entity.SetCommandReply(_ARG_1_, COMMAND_KIND_Check)
  Entity.AttachRideCollision(_ARG_1_, 0, 0)
  Entity.AttachRideCollision(_ARG_1_, 1, 0)
  if _UPVALUE0_ == 0 then
    _UPVALUE1_ = Gimmick.GetExtraParam(_ARG_1_, "LockOnPos")
    _UPVALUE0_ = 1
  end
  Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
  Entity.SetModelOfsZ(_ARG_0_.myHandle, 5)
end
function g24ls00.OnUpdate(_ARG_0_)
  if _ARG_0_.step == 1 then
    if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 12 then
      Entity.EnableRideColl(_ARG_0_.myHandle, 0, 0)
    end
    if Entity.IsMotionEnd(_ARG_0_.myHandle) then
      _ARG_0_.step = 2
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
    end
  elseif _ARG_0_.step == 0 then
    if Mission.IsMissionNow() == true then
      Entity.EnableMarkon(_ARG_0_.myHandle, 0)
    else
      Entity.EnableMarkon(_ARG_0_.myHandle, 1)
    end
  end
end
function g24ls00.OnCommand(_ARG_0_, _ARG_1_)
  if _ARG_0_.step == 0 then
    Entity.EnableMarkon(_ARG_0_.myHandle, 0)
    _ARG_0_.step = 1
    Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
    Entity.OnCommandCheck(_ARG_0_.myHandle)
  end
end
EntityFactory:Add("g24ls00", function(_ARG_0_)
  return (g24ls00:new())
end)
