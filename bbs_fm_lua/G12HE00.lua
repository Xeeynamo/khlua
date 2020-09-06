g12he00 = {}
g12he00_mt = {__index = g12he00}
function g12he00.new(_ARG_0_)
  return setmetatable({}, g12he00_mt)
end
function g12he00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.isRide = false
  _ARG_0_.speed = 0
  _ARG_0_.angle = 0
  _ARG_0_.attaker = NULL_HANDLE
  _ARG_0_.damageCont = 0
  _ARG_0_.ThrowFalg = 0
  _ARG_0_.oldAnglx = 0
  _ARG_0_.oldAngly = 0
  _ARG_0_.oldAnglz = 0
  _ARG_0_.timeLimit = _UPVALUE0_
  if _UPVALUE1_ == 0 then
    _UPVALUE2_ = Gimmick.GetExtraParam(_ARG_0_.myHandle, "Scale")
    _UPVALUE0_ = Gimmick.GetExtraParam(_ARG_0_.myHandle, "Timelimit") * 60
    _UPVALUE3_ = Gimmick.GetExtraParam(_ARG_0_.myHandle, "HitMax")
    _UPVALUE4_ = Gimmick.GetExtraParam(_ARG_0_.myHandle, "HitBackPow")
    _UPVALUE5_ = Gimmick.GetExtraParam(_ARG_0_.myHandle, "PowerTP")
    _ARG_0_.timeLimit = _UPVALUE0_
    _UPVALUE1_ = 1
  end
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
  _ARG_0_.plPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.oldPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.nowPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec0 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec2 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.axis = FVECTOR3.new(1, 0, 0)
  _ARG_0_.oldAxis = FVECTOR3.new(1, 0, 0)
  Entity.SetMovementCollRadius(_ARG_0_.myHandle, 0.64)
  Entity.SetLowerHalf(_ARG_0_.myHandle, 0.65)
  Entity.EnableGravity(_ARG_0_.myHandle, 1)
  Entity.EnableBgColl(_ARG_0_.myHandle, 1)
  Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
  Entity.EnableLockonAndShooton(_ARG_1_, 1)
  Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 0)
  Entity.AttachRideCollision(_ARG_1_, 0, 0)
  Entity.SetReplyDistSq(_ARG_1_, 12.25)
  Entity.EnableRideColl(_ARG_1_, 0, 0)
  Entity.SetMotion(_ARG_0_.myHandle, 1)
  Entity.SetAttackCollKindForBodyColl(_ARG_0_.myHandle, COLL_KIND_PLAYER)
  Entity.SetAttackPointForBodyColl(_ARG_0_.myHandle, Gimmick.GetAttackPoint(_ARG_0_.myHandle, 0))
  Entity.SetTechniquePowerCorrectionForBodyColl(_ARG_0_.myHandle, Gimmick.GetAttackPowerCorrection(_ARG_0_.myHandle, 0))
  Gimmick.SetGimmickKind(_ARG_0_.myHandle, GIMMICK_KIND_BARREL)
end
function ROUND_PI(_ARG_0_)
  if _ARG_0_ < -PI then
    return _ARG_0_ + PI * 2
  elseif _ARG_0_ > PI then
    return _ARG_0_ - PI * 2
  else
    return _ARG_0_
  end
end
function g12he00.OnRide(_ARG_0_, _ARG_1_, _ARG_2_)
  if Entity.IsPlayer(_ARG_1_) then
    _ARG_0_.attaker = _ARG_1_
    _ARG_0_.isRide = true
    Entity.EnableMarkon(_ARG_0_.myHandle, 0)
    Entity.SetDrawParentShadow(_ARG_0_.myHandle, _ARG_1_)
    Entity.SetMotion(_ARG_0_.myHandle, 1)
  end
end
function g12he00.OnRiderLeave(_ARG_0_, _ARG_1_, _ARG_2_)
  if Entity.IsPlayer(_ARG_1_) then
    _ARG_0_.isRide = false
    Entity.EnableMarkon(_ARG_0_.myHandle, 1)
    Entity.SetDrawParentShadow(_ARG_0_.myHandle, NULL_HANDLE)
    Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 0)
    Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
  end
end
function g12he00.NotifyRide(_ARG_0_, _ARG_1_, _ARG_2_)
  return 1
end
function g12he00.Throw(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  _ARG_0_.step = 2
  _ARG_0_.speed = _UPVALUE0_
  Entity.GetWorldPos(_ARG_0_.plPos, _ARG_1_)
  Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle, 1)
  Entity.GetRot(_ARG_0_.rot, _ARG_1_)
  _ARG_0_.velocity:set(0, 0, 1)
  Math.RotateVectorXYZ(_ARG_0_.velocity, _ARG_0_.rot)
  _ARG_0_.velocity:scale(_ARG_0_.speed)
  Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
  _ARG_0_.velocity:sety(0)
  _ARG_0_.axis:set(_ARG_3_:getx(), _ARG_3_:gety(), _ARG_3_:getz())
  Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 1)
  Entity.SetMotion(_ARG_0_.myHandle, 0)
  Entity.EnableGravity(_ARG_0_.myHandle, 0)
end
function g12he00.GetAttakerHandle(_ARG_0_, _ARG_1_)
  print("g12he00 :GetAttakerHandle\n")
  if Entity.IsAlive(_ARG_1_) == true then
    print("\130\177\130\204\131n\131\147\131h\131\139\130\205\144\182\130\171\130\196\130\220\130\183\129B\n")
  else
    print("\130\177\130\204\131n\131\147\131h\131\139\130\205\142\128\130\241\130\197\130\220\130\183\129B\n")
  end
  print("g10he00 :local AttakerName = " .. Entity.GetName(_ARG_1_) .. "\n")
  if Entity.GetName(_ARG_1_):sub(1, 1) == "w" or Entity.GetName(_ARG_1_):sub(1, 1) == "p" or Entity.GetName(_ARG_1_):sub(1, 1) == "b" then
    return _ARG_1_
  end
  for _FORV_7_ = 0, 100 do
    if Entity.IsAlive(_ARG_1_) == true then
      if Gimmick.IsScript(_ARG_1_) == true or Entity.GetName(_ARG_1_) == "g13heExplode" then
        if Entity.IsAlive(EntityManager:GetEntity(_ARG_1_).attaker) == true then
          if Entity.GetName(EntityManager:GetEntity(_ARG_1_).attaker):sub(1, 1) == "w" or Entity.GetName(EntityManager:GetEntity(_ARG_1_).attaker):sub(1, 1) == "p" then
            return EntityManager:GetEntity(_ARG_1_).attaker
          elseif Entity.GetName(EntityManager:GetEntity(_ARG_1_).attaker):sub(1, 1) == "b" then
            return EntityManager:GetEntity(_ARG_1_).attaker
          elseif Entity.GetName(EntityManager:GetEntity(_ARG_1_).attaker):sub(1, 1) == "g" then
          end
        else
          return _ARG_1_
        end
      else
        print("\130\177\130\204\131M\131~\131b\131N\130\204\131X\131N\131\138\131v\131g\130\205\141\237\143\156\141\207\130\221\129I\129I\129I\n")
        return _ARG_1_
      end
      return _ARG_1_
    end
  end
  return _ARG_1_
end
function g12he00.OnDamage(_ARG_0_, _ARG_1_)
  _ARG_0_.step = 1
  Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
  Entity.EnableMarkon(_ARG_0_.myHandle, 1)
  Entity.EnableRideColl(_ARG_0_.myHandle, 1, 0)
  _ARG_0_.attaker = _ARG_0_:GetAttakerHandle(Entity.GetAttacker(_ARG_0_.myHandle))
  if Entity.IsAlive(_ARG_0_.attaker) == false and Gimmick.IsScript(_ARG_0_.attaker) == false then
    _ARG_0_.attaker = Player.GetNearestPlayer()
  end
  if Entity.GetName(_ARG_0_.attaker):sub(1, 1) == "g13he00" then
    _ARG_0_.attaker = EntityManager:GetEntity(_ARG_0_.attaker).attaker
  end
  _ARG_0_.damageCont = _ARG_0_.damageCont + 1
  if _ARG_0_.damageCont >= _UPVALUE0_ then
    Gimmick.AddHp(_ARG_0_.myHandle, -10000)
    _ARG_0_:createEffect("g_he_012_00", "G_HE_TRU_00_0")
    Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 0)
    Gimmick.Delete(_ARG_0_.myHandle)
    return 1
  end
  _ARG_0_.speed = _UPVALUE1_
  Entity.GetWorldPos(_ARG_0_.plPos, (_ARG_0_:GetAttakerHandle(Entity.GetAttacker(_ARG_0_.myHandle))))
  Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle, 1)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  FVECTOR3.Sub(_UPVALUE2_, _ARG_0_.plPos, _ARG_0_.myPos)
  FVECTOR3.normalize(_UPVALUE2_)
  _ARG_0_.angle = Math.Atan2(_UPVALUE2_:getx(), _UPVALUE2_:getz()) - DegToRad(180)
  _ARG_0_.rot:set(0, ROUND_PI(Math.Atan2(_UPVALUE2_:getx(), _UPVALUE2_:getz()) - DegToRad(180)), 0)
  _ARG_0_.velocity:set(0, 0, 1)
  Math.RotateVectorXYZ(_ARG_0_.velocity, _ARG_0_.rot)
  _ARG_0_.velocity:scale(_ARG_0_.speed)
  Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
  _ARG_0_.velocity:sety(0)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  _UPVALUE2_:set(0, 0, 1)
  Entity.GetWorldPos2(_UPVALUE2_, _ARG_0_.myHandle, _UPVALUE2_, 1)
  Entity.GetWorldPos(_UPVALUE3_, _ARG_0_.myHandle, 1)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  FVECTOR3.Sub(_UPVALUE2_, _UPVALUE2_, _UPVALUE3_)
  FVECTOR3.normalize(_UPVALUE2_)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  _ARG_0_.rot:sety(Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.attaker))
  Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
  Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 1)
  Entity.EnableGravity(_ARG_0_.myHandle, 1)
  return 1
end
function g12he00.OnUpdate(_ARG_0_)
  Entity.GetLocalPos(_ARG_0_.oldPos, _ARG_0_.myHandle)
  if _ARG_0_.oldPos:gety() < -1 then
    Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 0)
    Gimmick.Delete(_ARG_0_.myHandle)
    Gimmick.AddHp(_ARG_0_.myHandle, -10000)
    return
  end
  Entity.GetVelocity(_ARG_0_.workVec0, _ARG_0_.myHandle)
  if _ARG_0_.isRide == false then
    if Entity.IsGround(_ARG_0_.myHandle) then
      _ARG_0_.speed = HomingDegree(_ARG_0_.speed, 0, 0.05, Entity.GetFrameRate(_ARG_0_.myHandle))
    else
      _ARG_0_.speed = HomingDegree(_ARG_0_.speed, 0, 0.05, Entity.GetFrameRate(_ARG_0_.myHandle))
    end
    if _ARG_0_.speed < 0.15 then
      Entity.EnableGravity(_ARG_0_.myHandle, 1)
    end
    Entity.GetVelocity(_ARG_0_.velocity, _ARG_0_.myHandle)
    FVECTOR3.normalize(_ARG_0_.velocity)
    if _ARG_0_.step == 0 then
    end
    if Entity.IsWall(_ARG_0_.myHandle) then
      Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
      if (_ARG_0_.myPos:getx() < -10.1835 or _ARG_0_.myPos:getx() > 10.1835 or _ARG_0_.myPos:getz() < -11.1835 or _ARG_0_.myPos:getz() > 11.1835) and (_ARG_0_.step == 1 or _ARG_0_.step == 2 or _ARG_0_.step == 3) then
        Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 0)
        Gimmick.Delete(_ARG_0_.myHandle)
        Gimmick.AddHp(_ARG_0_.myHandle, -10000)
        _ARG_0_:createEffect("g_he_012_00", "G_HE_TRU_00_0")
      end
    end
    _ARG_0_.velocity:scale(_ARG_0_.speed)
    Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
  else
    _ARG_0_.timeLimit = _ARG_0_.timeLimit - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
    if 0 > _ARG_0_.timeLimit then
      Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 0)
      Gimmick.Delete(_ARG_0_.myHandle)
      Gimmick.AddHp(_ARG_0_.myHandle, -10000)
      _ARG_0_:createEffect("g_he_012_00", "G_HE_TRU_00_0")
    end
  end
end
function g12he00.CheckAttaker(_ARG_0_, _ARG_1_)
  if Entity.IsAlive(_ARG_1_) == true then
    if Entity.GetName(_ARG_1_) == "b21he00" then
      return 1
    elseif Entity.GetName(_ARG_1_):sub(1, 1) == "w" or Entity.GetName(_ARG_1_):sub(1, 1) == "p" then
      return 0
    elseif Entity.GetName(_ARG_1_) == "g13heExplode" then
      if Entity.IsAlive(_ARG_1_) == true then
        if Entity.GetName(EntityManager:GetEntity(_ARG_1_).attaker):sub(1, 1) == "w" or Entity.GetName(EntityManager:GetEntity(_ARG_1_).attaker):sub(1, 1) == "p" then
          return 0
        else
          return 1
        end
      end
    elseif Entity.GetName(_ARG_1_):sub(1, 1) == "g" then
      if Entity.IsAlive(_ARG_1_) == true then
        if Gimmick.IsScript(_ARG_1_) == true then
          if Entity.IsAlive(EntityManager:GetEntity(_ARG_1_).attaker) == true then
            if Entity.GetName(EntityManager:GetEntity(_ARG_1_).attaker):sub(1, 1) == "w" or Entity.GetName(EntityManager:GetEntity(_ARG_1_).attaker):sub(1, 1) == "p" then
              return 0
            elseif Entity.GetName(EntityManager:GetEntity(_ARG_1_).attaker) == "b21he00" then
              return 1
            end
            if Gimmick.IsScript(EntityManager:GetEntity(_ARG_1_).attaker) == true then
              if Entity.GetName(EntityManager:GetEntity(_ARG_1_).attaker):sub(1, 1) == "w" or Entity.GetName(EntityManager:GetEntity(_ARG_1_).attaker):sub(1, 1) == "p" then
                return 0
              else
                return 1
              end
            else
              return 1
            end
          else
            return 1
          end
        else
          return 1
        end
      else
        return 1
      end
    elseif Entity.GetName(_ARG_1_) == "b21he00" then
      return 1
    else
      return 0
    end
  else
    return 1
  end
end
function g12he00.NotifyItGripBarrel(_ARG_0_)
  print("g12he00 Call NotifyItGripBarrel\n")
  Entity.EnableMarkon(_ARG_0_.myHandle, 0)
  Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
  Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
  Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
  Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 1)
  Entity.EnableRideColl(_ARG_0_.myHandle, 0, 0)
  _ARG_0_.step = 2
end
function g12he00.NotifyGripBarrel(_ARG_0_, _ARG_1_)
  if _ARG_0_.isRide == false and _ARG_0_.speed <= 0 then
    _ARG_0_.attaker = _ARG_1_
    print("g12he00 : NotifyGripwBarrel is called \n")
    return 1
  else
    return 0
  end
  return 0
end
function g12he00.NotifyThrowBarrel(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if _ARG_3_ == _UPVALUE0_ then
    Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
    Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
    _ARG_0_:Throw(_ARG_1_, _ARG_2_, _ARG_4_)
    _ARG_0_.step = 3
    _ARG_0_.ThrowFalg = 1
  elseif _ARG_3_ == _UPVALUE1_ then
    Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 0)
    Gimmick.AddHp(_ARG_0_.myHandle, -10000)
    _ARG_0_:createEffect("g_he_012_00", "G_HE_TRU_00_0")
    Gimmick.Delete(_ARG_0_.myHandle)
  end
end
function g12he00.createEffect(_ARG_0_, _ARG_1_, _ARG_2_)
  Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
  Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
  Entity.SetEffect(_ARG_0_.myHandle, _ARG_1_, _ARG_2_, _UPVALUE0_, _UPVALUE1_)
end
function g12he00.OnDestroy(_ARG_0_)
  if Mission.IsMissionNow() == true then
    Mission.SendMissonMessagePod(_ARG_0_:CheckAttaker(_ARG_0_.attaker), GIMMICK_KIND_BARREL)
  end
end
function g12he00.OnDead(_ARG_0_)
  _ARG_0_:createEffect("g_he_012_00", "G_HE_TRU_00_0")
  Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 0)
end
function g12he00.OnUpdatePositionAfter(_ARG_0_)
  if Gimmick.IsDelteFlag(_ARG_0_.myHandle) then
    Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 0)
    return
  end
  if _ARG_0_.isRide == false then
    if _ARG_0_.step == 1 then
      Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
      _ARG_0_.oldAngly = _ARG_0_.oldAngly + _ARG_0_.speed * 3
      if _ARG_0_.oldAngly > 0.2 then
        Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 1)
      else
        Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 0)
      end
      _ARG_0_.velocity:set(0, _ARG_0_.oldAngly, DegToRad(90))
      Entity.RotateBoneXYZ(_ARG_0_.myHandle, 2, _ARG_0_.velocity)
    elseif _ARG_0_.step == 2 then
      Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 1)
    elseif _ARG_0_.step == 3 and Entity.IsGround(_ARG_0_.myHandle) then
      Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 0)
      Gimmick.AddHp(_ARG_0_.myHandle, -10000)
      _ARG_0_:createEffect("g_he_012_00", "G_HE_TRU_00_0")
      Gimmick.Delete(_ARG_0_.myHandle)
    end
  else
    Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
    Entity.GetLocalPos(_ARG_0_.nowPos, _ARG_0_.myHandle)
    FVECTOR3.Sub(_ARG_0_.workVec0, _ARG_0_.nowPos, _ARG_0_.oldPos)
    Entity.GetVelocity(_ARG_0_.workVec1, _ARG_0_.myHandle)
    if _ARG_0_.workVec0:length() > 0.05 and 0 < _ARG_0_.workVec1:length() then
      Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 1)
    else
      Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 0)
    end
    _ARG_0_.oldAngly = _ARG_0_.oldAngly - _ARG_0_.workVec0:length()
    if _ARG_0_.workVec0:getx() ~= 0 or _ARG_0_.workVec0:getz() ~= 0 then
      _ARG_0_.angle = RoundPI(-(_ARG_0_.workVec0:length() / 1.1 * Entity.GetFrameRate(_ARG_0_.myHandle)))
      _ARG_0_.workVec1:set(-Math.Atan2(_ARG_0_.workVec0:gety(), Math.Sqrt(_ARG_0_.workVec0:getx() * _ARG_0_.workVec0:getx() + _ARG_0_.workVec0:getz() * _ARG_0_.workVec0:getz())), Math.Atan2(_ARG_0_.workVec0:getx(), _ARG_0_.workVec0:getz()), 0)
      _ARG_0_.workVec2:set(0, 0, 1)
      Math.RotateVectorXYZ(_ARG_0_.workVec2, _ARG_0_.workVec1)
      FVECTOR3.Cross(_ARG_0_.axis, _ARG_0_.workVec0, _ARG_0_.workVec2)
      _UPVALUE0_:set(0, 0, (_ARG_0_.workVec0:length()))
      Entity.GetWorldPos2(_UPVALUE0_, Player.GetHandle(), _UPVALUE1_, 2)
      Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle, 1)
      FVECTOR3.Sub(_UPVALUE0_, _UPVALUE0_, _UPVALUE1_)
      FVECTOR3.normalize(_UPVALUE0_)
      _ARG_0_.velocity:set(0, _ARG_0_.oldAngly, DegToRad(90))
      Entity.RotateBoneXYZ(_ARG_0_.myHandle, 2, _ARG_0_.velocity)
      _UPVALUE0_:set(0, 0, 2)
      Entity.GetWorldPos2(_UPVALUE0_, Player.GetHandle(), _UPVALUE0_)
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE0_, 10)
    else
      _ARG_0_.velocity:set(0, 0, DegToRad(90))
      Entity.RotateBoneXYZ(_ARG_0_.myHandle, 2, _ARG_0_.velocity)
      _UPVALUE0_:set(0, 0, 1)
      Entity.GetWorldPos2(_UPVALUE0_, Player.GetHandle(), _UPVALUE0_)
    end
  end
end
EntityFactory:Add("g12he00", function(_ARG_0_)
  return (g12he00:new())
end)
