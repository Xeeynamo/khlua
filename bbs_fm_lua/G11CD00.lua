g11cd00 = {}
g11cd00_mt = {__index = g11cd00}
function g11cd00.new(_ARG_0_)
  return setmetatable({}, g11cd00_mt)
end
function g11cd00.OnRide(_ARG_0_, _ARG_1_, _ARG_2_)
  if Entity.IsPlayer(_ARG_1_) then
    _ARG_0_.isRide = true
    Entity.EnableMarkon(_ARG_0_.myHandle, 0)
    Entity.SetDrawParentShadow(_ARG_0_.myHandle, _ARG_1_)
  end
end
function g11cd00.OnRiderLeave(_ARG_0_, _ARG_1_, _ARG_2_)
  if Entity.IsPlayer(_ARG_1_) then
    _ARG_0_.isRide = false
    Entity.EnableMarkon(_ARG_0_.myHandle, 1)
    Entity.SetDrawParentShadow(_ARG_0_.myHandle, NULL_HANDLE)
  end
end
function g11cd00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.sound = NULL_HANDLE
  _ARG_0_.step = 0
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.oldPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.nowPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec0 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec2 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.axis = FVECTOR3.new(1, 0, 0)
  _ARG_0_.oldAxis = FVECTOR3.new(1, 0, 0)
  _ARG_0_.isRide = false
  _ARG_0_.angle = 0
  _ARG_0_.oldAngle = 0
  _ARG_0_.noRideTime = 0
  Entity.EnableBgColl(_ARG_1_, 1)
  Entity.EnableGravity(_ARG_1_, 1)
  Entity.SetMovementCollRadius(_ARG_1_, 1.1)
  Entity.SetLowerHalf(_ARG_1_, 1.1)
  Entity.SetWeight(_ARG_1_, 10)
  Entity.AttachRideCollision(_ARG_1_, 0, 3)
  Entity.EnableLockon(_ARG_1_, 0)
  Entity.EnableMarkon(_ARG_1_, 1)
  Entity.SetReplyDistSq(_ARG_1_, 12.25)
  Entity.SetDamageCollKindForBodyColl(_ARG_1_, COLL_KIND_ENEMY)
  Entity.SetAttackPointForBodyColl(_ARG_1_, Gimmick.GetAttackPoint(_ARG_1_, 0))
  Entity.SetAttackAttrForBodyColl(_ARG_1_, Gimmick.GetAttackAttr(_ARG_1_, 0))
  Entity.SetTechniquePowerCorrectionForBodyColl(_ARG_1_, Gimmick.GetAttackPowerCorrection(_ARG_1_, 0))
  Gimmick.SetGimmickKind(_ARG_1_, GIMMICK_KIND_RIDE_BALL)
  Entity.EnableCameraBodyColl(_ARG_1_, 1)
end
function g11cd00.OnUpdate(_ARG_0_)
  Entity.GetLocalPos(_ARG_0_.oldPos, _ARG_0_.myHandle)
  Entity.GetVelocity(_ARG_0_.workVec0, _ARG_0_.myHandle)
  if _ARG_0_.isRide == false then
    _ARG_0_.workVec0:scale(Math.Pow(0.99, Entity.GetFrameRate(_ARG_0_.myHandle)))
    Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.workVec0)
  end
  if _ARG_0_.noRideTime < 0 then
    _ARG_0_.noRideTime = 0
    Entity.EnableRideColl(_ARG_0_.myHandle, 1, 0)
  end
  _ARG_0_.noRideTime = _ARG_0_.noRideTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
end
function g11cd00.NotifyRide(_ARG_0_, _ARG_1_, _ARG_2_)
  return 1
end
function g11cd00.OnUpdatePositionAfter(_ARG_0_)
  Entity.GetLocalPos(_ARG_0_.nowPos, _ARG_0_.myHandle)
  FVECTOR3.Sub(_ARG_0_.workVec0, _ARG_0_.nowPos, _ARG_0_.oldPos)
  Entity.GetVelocity(_ARG_0_.workVec1, _ARG_0_.myHandle)
  if _ARG_0_.workVec0:length() > 0.05 and _ARG_0_.workVec1:length() > 0 then
    Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 1)
  else
    Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 0)
  end
  if _ARG_0_.workVec0:getx() ~= 0 or _ARG_0_.workVec0:getz() ~= 0 then
    _ARG_0_.angle = RoundPI(-(_ARG_0_.workVec0:length() / 1.1 * Entity.GetFrameRate(_ARG_0_.myHandle)))
    _ARG_0_.workVec1:set(-Math.Atan2(_ARG_0_.workVec0:gety(), Math.Sqrt(_ARG_0_.workVec0:getx() * _ARG_0_.workVec0:getx() + _ARG_0_.workVec0:getz() * _ARG_0_.workVec0:getz())), Math.Atan2(_ARG_0_.workVec0:getx(), _ARG_0_.workVec0:getz()), 0)
    _ARG_0_.workVec2:set(0, 1, 0)
    Math.RotateVectorXYZ(_ARG_0_.workVec2, _ARG_0_.workVec1)
    FVECTOR3.Cross(_ARG_0_.axis, _ARG_0_.workVec0, _ARG_0_.workVec2)
    Entity.RotateBoneAxis2(_ARG_0_.myHandle, 2, _ARG_0_.axis, _ARG_0_.angle)
  end
  if _ARG_0_.workVec0:length() > 0.01 then
    if _ARG_0_.sound == NULL_HANDLE then
      _ARG_0_.sound = Sound.PlaySe(279, 2)
    end
    Sound.SetPosition(_ARG_0_.sound, _ARG_0_.nowPos)
  elseif _ARG_0_.sound ~= NULL_HANDLE then
    Sound.Stop(_ARG_0_.sound, 0)
    _ARG_0_.sound = NULL_HANDLE
  end
end
function g11cd00.OnDamage(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if Entity.GetDamagePoint(_ARG_0_.myHandle) <= 0 or _ARG_3_ == ATK_ATTR_SPECIAL then
    return 0
  end
  _ARG_0_.noRideTime = 30
  Entity.EnableRideColl(_ARG_0_.myHandle, 0, 0)
  _ARG_0_.isRide = false
  _ARG_0_.rider = NULL_HANDLE
  Entity.EnableMarkon(_ARG_0_.myHandle, 1)
  Entity.SetDrawParentShadow(_ARG_0_.myHandle, NULL_HANDLE)
  Entity.GetAttackerPos(_ARG_0_.workVec0, _ARG_0_.myHandle)
  Entity.GetWorldPos(_ARG_0_.workVec1, _ARG_0_.myHandle)
  FVECTOR3.Sub(_ARG_0_.workVec2, _ARG_0_.workVec1, _ARG_0_.workVec0)
  _ARG_0_.workVec2:normalize()
  _ARG_0_.workVec2:scale(0.2)
  Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.workVec2)
  return 0
end
function g11cd00.OnDestroy(_ARG_0_)
  if _ARG_0_.sound ~= NULL_HANDLE then
    Sound.Stop(_ARG_0_.sound, 0)
  end
end
EntityFactory:Add("g11cd00", function(_ARG_0_)
  return (g11cd00:new())
end)
EntityFactory:Add("g18vs00", function(_ARG_0_)
  return (g11cd00:new())
end)
