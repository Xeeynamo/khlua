g13he00 = {}
g13he00_mt = {__index = g13he00}
function g13he00.new(_ARG_0_)
  return setmetatable({}, g13he00_mt)
end
function g13he00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.isRide = false
  _ARG_0_.attaker = NULL_HANDLE
  _ARG_0_.effectHandle = NULL_HANDLE
  _ARG_0_.speed = 0
  if _UPVALUE0_ == 0 then
    _UPVALUE1_ = Gimmick.GetExtraParam(_ARG_0_.myHandle, "Scale")
    _UPVALUE2_ = Gimmick.GetExtraParam(_ARG_0_.myHandle, "HitBackPow")
    _UPVALUE3_ = Gimmick.GetExtraParam(_ARG_0_.myHandle, "HitBackPoY")
    _UPVALUE0_ = 1
  end
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
  _ARG_0_.plPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
  Gimmick.SetGimmickKind(_ARG_0_.myHandle, GIMMICK_KIND_BOMB_BARREL)
  Entity.SetMovementCollRadius(_ARG_0_.myHandle, 0.64)
  Entity.SetLowerHalf(_ARG_0_.myHandle, 0.65)
  Entity.EnableGravity(_ARG_0_.myHandle, 1)
  Entity.EnableBgColl(_ARG_0_.myHandle, 1)
  Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
  Entity.EnableLockon(_ARG_0_.myHandle, 1)
  Entity.EnableShooton(_ARG_0_.myHandle, 1)
  Entity.SetMotion(_ARG_0_.myHandle, 0)
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
function g13he00.GetAttakerHandle(_ARG_0_, _ARG_1_)
  print("g13he00 :GetAttakerHandle\n")
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
function g13he00.OnDamage(_ARG_0_, _ARG_1_)
  if _ARG_0_.step == 0 then
    if Entity.IsAlive(Entity.GetAttacker(_ARG_0_.myHandle)) == false then
      return 1
    end
    _ARG_0_.attaker = _ARG_0_:GetAttakerHandle(Entity.GetAttacker(_ARG_0_.myHandle))
    _ARG_0_.step = 1
    _ARG_0_.speed = _UPVALUE0_
    Entity.GetWorldPos(_ARG_0_.plPos, _ARG_0_.attaker)
    Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle, 1)
    Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
    FVECTOR3.Sub(_UPVALUE1_, _ARG_0_.plPos, _ARG_0_.myPos)
    FVECTOR3.normalize(_UPVALUE1_)
    _ARG_0_.angle = Math.Atan2(_UPVALUE1_:getx(), _UPVALUE1_:getz()) - DegToRad(180)
    _ARG_0_.rot:set(0, RoundPI(Math.Atan2(_UPVALUE1_:getx(), _UPVALUE1_:getz()) - DegToRad(180)), 0)
    _ARG_0_.velocity:set(0, _UPVALUE2_, 1)
    Math.RotateVectorXYZ(_ARG_0_.velocity, _ARG_0_.rot)
    _ARG_0_.velocity:scale(_ARG_0_.speed)
    Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
    _ARG_0_.velocity:sety(0)
    Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
    _UPVALUE1_:set(0, 0, 1)
    Entity.GetWorldPos2(_UPVALUE1_, _ARG_0_.myHandle, _UPVALUE1_, 1)
    Entity.GetWorldPos(_UPVALUE3_, _ARG_0_.myHandle, 1)
    Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
    FVECTOR3.Sub(_UPVALUE1_, _UPVALUE1_, _UPVALUE3_)
    FVECTOR3.normalize(_UPVALUE1_)
    Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
    Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
    _ARG_0_.rot:sety(Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.attaker))
    Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
    Entity.EnableGravity(_ARG_0_.myHandle, 1)
    Entity.SetTimer(_ARG_0_.myHandle, 60)
  end
  return 1
end
function g13he00.CheckAttaker(_ARG_0_, _ARG_1_)
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
              print("\130P\145\206\143\219\130\205\144\182\130\171\130\196\130\162\130\233\130\170\129A\131X\131N\131\138\131v\131g\130\204\131C\131\147\131X\131^\131\147\131X\130\170\150\179\130\173\130\200\130\193\130\196\130\162\130\220\130\183\129B\n")
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
function g13he00.createEffect(_ARG_0_, _ARG_1_, _ARG_2_)
  Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
  Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
  return Entity.SetEffect(_ARG_0_.myHandle, _ARG_1_, _ARG_2_, _UPVALUE0_, _UPVALUE1_)
end
function g13he00.OnUpdate(_ARG_0_)
  Entity.SetUserGroundColor(_ARG_0_.myHandle, 1)
  if _ARG_0_.step == 1 then
    if Entity.IsTimeOver(_ARG_0_.myHandle) then
      _ARG_0_:Explode()
    end
    if Entity.IsGround(_ARG_0_.myHandle) or Entity.IsWall(_ARG_0_.myHandle) then
      Entity.GetVelocity(_UPVALUE0_, _ARG_0_.myHandle)
      if _UPVALUE0_:gety() < 0 and (Entity.IsGround(_ARG_0_.myHandle) or Entity.IsWall(_ARG_0_.myHandle)) then
        _ARG_0_:Explode()
        _ARG_0_.step = 2
      end
    end
  elseif _ARG_0_.step == 2 then
    Effect.KillEffect(_ARG_0_.effectHandle)
    Mission.SendMissonMessagePod(_ARG_0_:CheckAttaker(_ARG_0_.attaker), GIMMICK_KIND_BOMB_BARREL)
    Entity.Out(_ARG_0_.myHandle)
  end
end
function g13he00.Explode(_ARG_0_)
  Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
  _UPVALUE1_:set(0, 0, 0)
  Bullet.CreateEffectBullet(Bullet.CreateBullet("g13heExplode", _UPVALUE0_, _UPVALUE1_), "g_he_013_00", "G_HE_TRU_10_0")
  _UPVALUE0_:set(Gimmick.GetExtraParam(_ARG_0_.myHandle, "ExplodeR") * 0.5, Gimmick.GetExtraParam(_ARG_0_.myHandle, "ExplodeR") * 0.5, Gimmick.GetExtraParam(_ARG_0_.myHandle, "ExplodeR") * 0.5)
  Bullet.SetAttackParam(Bullet.CreateBullet("g13heExplode", _UPVALUE0_, _UPVALUE1_), Gimmick.GetAttackKind(_ARG_0_.myHandle, 0), 6, 0, 0)
  Bullet.SetCollision(Bullet.CreateBullet("g13heExplode", _UPVALUE0_, _UPVALUE1_), COLL_KIND_NO_CHECK, COLL_SHAPE_SPHERE, (Gimmick.GetExtraParam(_ARG_0_.myHandle, "ExplodeR")))
  Entity.SetTimer(Bullet.CreateBullet("g13heExplode", _UPVALUE0_, _UPVALUE1_), Gimmick.GetExtraParam(_ARG_0_.myHandle, "ExplodeTime") * 60)
  EntityManager:GetEntity((Bullet.CreateBullet("g13heExplode", _UPVALUE0_, _UPVALUE1_))).attaker = _ARG_0_.attaker
end
function g13he00.OnDead(_ARG_0_)
end
EntityFactory:Add("g13he00", function(_ARG_0_)
  return (g13he00:new())
end)
g13heExplode = {}
g13heExplode.__index = g13heExplode
function g13heExplode.new(_ARG_0_)
  return setmetatable({}, g13heExplode)
end
function g13heExplode.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.attaker = NULL_HANDLE
  _ARG_0_.attaker2 = NULL_HANDLE
  Entity.EnableBgColl(_ARG_1_, 0)
  Bullet.SetHitAttackEffectName(_ARG_1_, "g_he_013_00", "G_HE_TRU_12_0")
  Bullet.SetHitBgEffectName(_ARG_1_, "g_he_013_00", "G_HE_TRU_12_0")
end
function g13heExplode.OnHitAttack(_ARG_0_)
end
function g13heExplode.OnHitBg(_ARG_0_)
end
function g13heExplode.OnUpdate(_ARG_0_)
  if _ARG_0_.step == 0 and Entity.IsTimeOver(_ARG_0_.myHandle) then
    Bullet.EnableAttackCollision(_ARG_0_.myHandle, 0)
    _ARG_0_.step = 1
  end
end
EntityFactory:Add("g13heExplode", function(_ARG_0_)
  EntityManager:Add(g13heExplode:new(), _ARG_0_)
  return (g13heExplode:new())
end)
