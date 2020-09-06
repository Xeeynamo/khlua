g18vs00 = {}
g18vs00_mt = {__index = g18vs00}
function g18vs00.new(_ARG_0_)
  return setmetatable({}, g18vs00_mt)
end
function g18vs00.OnRide(_ARG_0_, _ARG_1_, _ARG_2_)
  if Entity.IsPlayer(_ARG_1_) and _ARG_1_ == Player.GetHandleForNet() then
    _ARG_0_.isRide = true
    _ARG_0_.rider = _ARG_1_
    Entity.EnableMarkon(_ARG_0_.myHandle, 0)
    Entity.SetDrawParentShadow(_ARG_0_.myHandle, _ARG_1_)
  end
end
function g18vs00.OnRiderLeave(_ARG_0_, _ARG_1_, _ARG_2_)
  if Entity.IsPlayer(_ARG_1_) and _ARG_1_ == Player.GetHandleForNet() then
    _ARG_0_.isRide = false
    _ARG_0_.rider = NULL_HANDLE
    Entity.EnableMarkon(_ARG_0_.myHandle, 1)
    Entity.SetDrawParentShadow(_ARG_0_.myHandle, NULL_HANDLE)
    SetRideTargetHandle(_ARG_0_.myHandle, NULL_HANDLE, _UPVALUE0_)
    _ARG_0_.noRideAttackTime = 120
    print("g18vs00: OnRiderLeave\n")
  end
end
function g18vs00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.rider = NULL_HANDLE
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
  _ARG_0_.noRideAttackTime = 0
  _ARG_0_.noAttTime = 0
  Entity.EnableBgColl(_ARG_1_, 1)
  Entity.EnableGravity(_ARG_1_, 1)
  Entity.SetMovementCollRadius(_ARG_1_, 1.1)
  Entity.SetLowerHalf(_ARG_1_, 1.1)
  Entity.SetWeight(_ARG_1_, 10)
  Entity.AttachRideCollision(_ARG_1_, 0, 3)
  Entity.EnableLockon(_ARG_1_, 0)
  Entity.EnableMarkon(_ARG_1_, 1)
  Entity.SetReplyDistSq(_ARG_1_, 12.25)
  Entity.SetDamageCollKindForBodyColl(_ARG_1_, COLL_KIND_NO_CHECK)
  Entity.SetAttackKindForBodyColl(_ARG_1_, Gimmick.GetAttackKind(_ARG_1_, 0))
  Entity.SetAttackPointForBodyColl(_ARG_1_, Gimmick.GetAttackPoint(_ARG_1_, 0))
  Entity.SetAttackAttrForBodyColl(_ARG_1_, Gimmick.GetAttackAttr(_ARG_1_, 0))
  Entity.SetTechniquePowerCorrectionForBodyColl(_ARG_1_, Gimmick.GetAttackPowerCorrection(_ARG_1_, 0))
  Gimmick.SetGimmickKind(_ARG_1_, GIMMICK_KIND_RIDE_BALL)
  Gimmick.EnableNetwork(_ARG_0_.myHandle, 1)
  Entity.EnableCameraBodyColl(_ARG_0_.myHandle, 1)
end
function g18vs00.OnUpdate(_ARG_0_)
  Gimmick.EnableNetwork(_ARG_0_.myHandle, 1)
  Entity.GetLocalPos(_ARG_0_.oldPos, _ARG_0_.myHandle)
  Entity.GetVelocity(_ARG_0_.workVec0, _ARG_0_.myHandle)
  if _ARG_0_.isRide == false then
    _ARG_0_.workVec0:scale(Math.Pow(0.99, Entity.GetFrameRate(_ARG_0_.myHandle)))
    Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.workVec0)
    if _ARG_0_.noRideTime < 0 then
      _ARG_0_.noRideTime = 0
      Entity.EnableRideColl(_ARG_0_.myHandle, 1, 0)
    end
  end
  if GetRideTargetHandle(_ARG_0_.myHandle) == NULL_HANDLE and 0 > _ARG_0_.noRideAttackTime then
    _ARG_0_.noRideAttackTime = 0
    Entity.SetAttackerIsBody(_ARG_0_.myHandle, _ARG_0_.myHandle)
  end
  if Player.IsBattleFlagArenaBattlePlay() == 1 then
    if IsAttackFlag(_ARG_0_.myHandle) then
      Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 1)
    else
      Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 0)
    end
  else
    Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 0)
  end
  _ARG_0_.noRideTime = _ARG_0_.noRideTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
  _ARG_0_.noRideAttackTime = _ARG_0_.noRideAttackTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
end
function g18vs00.OnUpdatePositionAfter(_ARG_0_)
  Entity.GetLocalPos(_ARG_0_.nowPos, _ARG_0_.myHandle)
  FVECTOR3.Sub(_ARG_0_.workVec0, _ARG_0_.nowPos, _ARG_0_.oldPos)
  Entity.GetVelocity(_ARG_0_.workVec1, _ARG_0_.myHandle)
  if Gimmick.IsNetworkMaster(_ARG_0_.myHandle) then
    if _ARG_0_.workVec0:length() > 0.23 then
      if _ARG_0_.noAttTime < 0 then
        SetAttackFlag(_ARG_0_.myHandle, 1)
      end
    else
      if _ARG_0_.isRide == false then
        SetRideTargetHandle(_ARG_0_.myHandle, NULL_HANDLE, _UPVALUE0_)
      end
      SetAttackFlag(_ARG_0_.myHandle, 0)
    end
  end
  _ARG_0_.noAttTime = _ARG_0_.noAttTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_0_.noAttTime < 0 then
    _ARG_0_.noAttTime = -1
  end
  if _ARG_0_.workVec0:getx() ~= 0 or _ARG_0_.workVec0:getz() ~= 0 then
    _ARG_0_.angle = RoundPI(-(_ARG_0_.workVec0:length() / 1.1 * Entity.GetFrameRate(_ARG_0_.myHandle)))
    _ARG_0_.workVec1:set(-Math.Atan2(_ARG_0_.workVec0:gety(), Math.Sqrt(_ARG_0_.workVec0:getx() * _ARG_0_.workVec0:getx() + _ARG_0_.workVec0:getz() * _ARG_0_.workVec0:getz())), Math.Atan2(_ARG_0_.workVec0:getx(), _ARG_0_.workVec0:getz()), 0)
    _ARG_0_.workVec2:set(0, 1, 0)
    Math.RotateVectorXYZ(_ARG_0_.workVec2, _ARG_0_.workVec1)
    FVECTOR3.Cross(_ARG_0_.axis, _ARG_0_.workVec0, _ARG_0_.workVec2)
    if _ARG_0_.axis:getx() ~= 0 or _ARG_0_.axis:getz() ~= 0 or _ARG_0_.axis:gety() ~= 0 then
      Entity.RotateBoneAxis2(_ARG_0_.myHandle, 2, _ARG_0_.axis, _ARG_0_.angle)
    else
      print("\130\226\131\148\130\159\130\162\130\182\130\229\130\164\130\189\130\162\129I\129I\n")
    end
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
function g18vs00.NotifyRide(_ARG_0_, _ARG_1_, _ARG_2_)
  if _ARG_2_ == 0 then
    print("coll NotifyRide  in Type Zero\n")
    if _ARG_1_ == Player.GetHandleForNet() then
      print("\142\169\146[\150\150\130\204\131v\131\140\131C\131\132\129[\130\170\143\230\130\232\130\220\130\181\130\189\129B\n")
      _ARG_0_.rider = _ARG_1_
      _ARG_0_.isRide = true
      SetRideTargetHandle(_ARG_0_.myHandle, _ARG_1_, Player.GetNetMyPlayerNum())
      Gimmick.SetNetworkMaster(_ARG_0_.myHandle, 1)
      Entity.SetDrawParentShadow(_ARG_0_.myHandle, _ARG_1_)
      AddRideCount(_ARG_0_.myHandle)
      Entity.SetAttackerIsBody(_ARG_0_.myHandle, _ARG_1_)
      return 1
    end
    Entity.SetAttackerIsBody(_ARG_0_.myHandle, _ARG_1_)
  elseif _ARG_2_ == 1 then
    if _ARG_1_ ~= _ARG_0_.rider then
      _ARG_0_.isRide = false
      _ARG_0_.rider = NULL_HANDLE
      print("\145\151\130\231\130\234\130\196\130\171\130\189\131n\131\147\131h\131\139\130\198\149\219\145\182\130\181\130\196\130\233\131n\131\147\131h\131\139\130\170\136\225\130\164\129I\129I\n")
    end
    if Gimmick.IsNetworkMaster(_ARG_0_.myHandle) then
    else
    end
  elseif _ARG_2_ == 2 then
  end
  return 0
end
function g18vs00.OnDamage(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if Entity.GetDamagePoint(_ARG_0_.myHandle) <= 0 or _ARG_3_ == ATK_ATTR_SPECIAL then
    return 0
  end
  _ARG_0_.noRideTime = 30
  Entity.EnableRideColl(_ARG_0_.myHandle, 0, 0)
  _ARG_0_.isRide = false
  _ARG_0_.rider = NULL_HANDLE
  Entity.EnableMarkon(_ARG_0_.myHandle, 1)
  Entity.SetDrawParentShadow(_ARG_0_.myHandle, NULL_HANDLE)
  SetRideTargetHandle(_ARG_0_.myHandle, Entity.GetAttacker(_ARG_0_.myHandle), _UPVALUE0_)
  Entity.GetAttackerPos(_ARG_0_.workVec0, _ARG_0_.myHandle)
  Entity.GetWorldPos(_ARG_0_.workVec1, _ARG_0_.myHandle)
  FVECTOR3.Sub(_ARG_0_.workVec2, _ARG_0_.workVec1, _ARG_0_.workVec0)
  _ARG_0_.workVec2:normalize()
  _ARG_0_.workVec2:scale(0.2)
  Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.workVec2)
  _ARG_0_.noAttTime = 0
  return 0
end
function g18vs00.OnDestroy(_ARG_0_)
  if _ARG_0_.sound ~= NULL_HANDLE then
    Sound.Stop(_ARG_0_.sound, 0)
  end
  Gimmick.SetNetworkMaster(_ARG_0_.myHandle, 0)
end
EntityFactory:Add("g18vs00", function(_ARG_0_)
  return (g18vs00:new())
end)
