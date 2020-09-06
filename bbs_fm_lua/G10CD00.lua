g10cd00 = {}
g10cd00_mt = {__index = g10cd00}
function g10cd00.new(_ARG_0_)
  return setmetatable({}, g10cd00_mt)
end
function g10cd00.OnRide(_ARG_0_, _ARG_1_, _ARG_2_)
  if Entity.IsPlayer(_ARG_1_) and _ARG_2_ == _ARG_0_.rideID then
    _ARG_0_.wait2 = 0
    _ARG_0_.isRide = true
    _ARG_0_.riderHandle = _ARG_1_
  end
end
function g10cd00.OnRiderLeave(_ARG_0_, _ARG_1_, _ARG_2_)
  if Entity.IsPlayer(_ARG_1_) and _ARG_2_ == _ARG_0_.rideID then
    _ARG_0_.isRide = false
    _ARG_0_.wait2 = 0
    _ARG_0_.riderHandle = 0
  end
end
function g10cd00.GetLockOnPos(_ARG_0_)
  _ARG_0_.lockOnPos:set(0, 0, -0.5)
  Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "X_col3", _ARG_0_.lockOnPos)
  return _ARG_0_.lockOnPos
end
function g10cd00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.isRide = false
  _ARG_0_.lockOnPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.riderHandle = 0
  _ARG_0_.wait = 0
  _ARG_0_.wait2 = 0
  Entity.AttachRideCollision(_ARG_1_, 0, 6)
  Entity.AttachRideCollision(_ARG_1_, 1, 5)
  _ARG_0_.rideID = Entity.AttachRideCollision(_ARG_1_, 2, 4)
  Entity.SetLockOnBoneNum(_ARG_1_, 4)
  Entity.EnableBgColl(_ARG_1_, 0)
  Entity.EnableLockon(_ARG_1_, 0)
  Entity.EnableMarkon(_ARG_1_, 1)
  Entity.SetReplyDistSq(_ARG_1_, 12.25)
  Entity.SetMotion(_ARG_1_, 1)
  Gimmick.SetGimmickKind(_ARG_1_, GIMMICK_KIND_JUMP_STAND)
  Gimmick.SetJumpStand(_ARG_1_, 1)
end
function g10cd00.OnUpdate(_ARG_0_)
  _ARG_0_.wait = _ARG_0_.wait - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_0_.isRide == true then
    Player.NotifyGimmickJump(_ARG_0_.riderHandle, _ARG_0_.myHandle, Gimmick.GetJumpStandPower(_ARG_0_.myHandle))
  end
  if _ARG_0_.step == 0 then
    if _ARG_0_.isRide == true then
      Entity.SetMotion(_ARG_0_.myHandle, 2)
      _ARG_0_.wait = 30
      _ARG_0_.step = 1
    end
  elseif _ARG_0_.step == 1 then
    if Entity.IsMotionEnd(_ARG_0_.myHandle) and _ARG_0_.wait < 0 then
      _ARG_0_.step = 2
    end
  elseif _ARG_0_.step == 2 then
    if _ARG_0_.isRide == false then
      if _ARG_0_.wait2 > 10 or Entity.GetFrameRate(_ARG_0_.myHandle) <= 2.1 then
        Entity.SetMotion(_ARG_0_.myHandle, 3)
        _ARG_0_.step = 3
      end
      _ARG_0_.wait2 = _ARG_0_.wait2 + 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
    else
      _ARG_0_.wait2 = 0
    end
  elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
    _ARG_0_.step = 0
  end
end
EntityFactory:Add("g10cd00", function(_ARG_0_)
  return (g10cd00:new())
end)
