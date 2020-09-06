g13pp00 = {}
g13pp00_mt = {__index = g13pp00}
function g13pp00.new(_ARG_0_)
  return setmetatable({}, g13pp00_mt)
end
function g13pp00.GetLockOnPos(_ARG_0_)
  _ARG_0_.lockOnPos:set(0, _UPVALUE0_, 0)
  Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "X_marker", _ARG_0_.lockOnPos)
  return _ARG_0_.lockOnPos
end
function g13pp00.GetCameraTargetPos(_ARG_0_)
  _ARG_0_.lockOnPos:set(0, _UPVALUE0_, 0)
  Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "X_marker", _ARG_0_.lockOnPos)
  return _ARG_0_.lockOnPos
end
function g13pp00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.lockOnPos = FVECTOR3.new(0, 0, 0)
  Entity.EnableMarkon(_ARG_1_, 1)
  Entity.SetReplyDistSq(_ARG_1_, 25)
  if _UPVALUE0_ == 0 then
    _UPVALUE1_ = Gimmick.GetExtraParam(_ARG_1_, "LockOnPos")
    _UPVALUE2_ = Gimmick.GetExtraParam(_ARG_1_, "HitDist")
    _UPVALUE2_ = _UPVALUE2_ * _UPVALUE2_
    _UPVALUE0_ = 1
  end
end
function g13pp00.OnUpdate(_ARG_0_)
  Entity.GetWorldPos(_UPVALUE0_, Player.GetNearestPlayer(), 2)
  Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle, 2)
  FVECTOR3.Sub(_UPVALUE0_, _UPVALUE1_, _UPVALUE0_)
  if _ARG_0_.step == 0 then
    if _UPVALUE0_:length() * _UPVALUE0_:length() < _UPVALUE2_ then
      Player.NotifyGimmickJump(Player.GetNearestPlayer(), _ARG_0_.myHandle, Gimmick.GetJumpStandPower(_ARG_0_.myHandle))
      Player.SetTrgFlagAccelerator(Player.GetNearestPlayer(), 1)
      _ARG_0_.ridePlayer = Player.GetNearestPlayer()
      _ARG_0_.step = 1
    end
  elseif _ARG_0_.step == 1 and _UPVALUE0_:length() * _UPVALUE0_:length() > _UPVALUE2_ then
    _ARG_0_.step = 0
  end
end
EntityFactory:Add("g13pp00", function(_ARG_0_)
  return (g13pp00:new())
end)
