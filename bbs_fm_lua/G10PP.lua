g10pp00 = {}
g10pp00_mt = {__index = g10pp00}
function g10pp00.new(_ARG_0_)
  return setmetatable({}, g10pp00_mt)
end
function g10pp00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  Entity.AttachRideCollision(_ARG_1_, 0, 0)
  if G13PP_PARAM_FLAG == 0 then
    G13PP_PARAM_FLAG = 1
  end
end
function g10pp00.createEffect(_ARG_0_, _ARG_1_, _ARG_2_)
  Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 1)
  Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
  Entity.SetEffect(_ARG_0_.myHandle, _ARG_1_, _ARG_2_, _UPVALUE0_, _UPVALUE1_)
end
function g10pp00.OnDamage(_ARG_0_, _ARG_1_)
  if Entity.GetName((Entity.GetAttacker(_ARG_0_.myHandle))):sub(1, 1) == "g" or _ARG_1_ == ATK_KIND_DMG_BIG or _ARG_1_ == ATK_KIND_DMG_BLOW or _ARG_1_ == ATK_KIND_DMG_TOSS or _ARG_1_ == ATK_KIND_DMG_BEAT or _ARG_1_ == ATK_KIND_DMG_BEAT or _ARG_1_ == ATK_KIND_DMG_FLICK then
    _ARG_0_:createEffect("g_pp_iwa_00", "G_PP_IWA_CRS0_0")
    Gimmick.Delete(_ARG_0_.myHandle)
    _UPVALUE0_ = NULL_HANDLE
    _UPVALUE1_ = 100000000
  end
end
function g10pp00.OnUpdate(_ARG_0_)
  if Entity.CalcDistanceXZ(_ARG_0_.myHandle, Player.GetHandle()) < _UPVALUE0_ then
    _UPVALUE0_, _UPVALUE1_ = Entity.CalcDistanceXZ(_ARG_0_.myHandle, Player.GetHandle()), _ARG_0_.myHandle
  end
end
EntityFactory:Add("g10pp00", function(_ARG_0_)
  return (g10pp00:new())
end)
EntityFactory:Add("g11pp00", function(_ARG_0_)
  return (g10pp00:new())
end)
EntityFactory:Add("g12pp00", function(_ARG_0_)
  return (g10pp00:new())
end)
g16pp00 = {}
g16pp00_mt = {__index = g16pp00}
function g16pp00.new(_ARG_0_)
  return setmetatable({}, g16pp00_mt)
end
function g16pp00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.shotTimer1 = 210
  _ARG_0_.shotTimer2 = 210
  _ARG_0_.PlHitCnt1 = 0
  _ARG_0_.PlHitCnt2 = 0
  _ARG_0_.PlHitMAxCnt1 = 0
  _ARG_0_.PlHitMAxCnt2 = 0
  print("param = " .. Entity.GetLayoutParam(_ARG_0_.myHandle, 1) .. "\n")
  _UPVALUE0_ = Entity.GetLayoutParam(_ARG_0_.myHandle, 1)
  if _UPVALUE1_ == 0 then
    _UPVALUE2_ = Gimmick.GetExtraParam(_ARG_0_.myHandle, "ShootWait1")
    _UPVALUE3_ = Gimmick.GetExtraParam(_ARG_0_.myHandle, "ShootRnd1")
    _UPVALUE4_ = Gimmick.GetExtraParam(_ARG_0_.myHandle, "ShootWait2")
    _UPVALUE5_ = Gimmick.GetExtraParam(_ARG_0_.myHandle, "ShootRnd2")
    _UPVALUE6_ = Gimmick.GetExtraParam(_ARG_0_.myHandle, "LandTime")
    _UPVALUE7_ = Gimmick.GetExtraParam(_ARG_0_.myHandle, "RLandTime")
    _UPVALUE8_ = Gimmick.GetExtraParam(_ARG_0_.myHandle, "PlHitCon")
    _UPVALUE1_ = 1
  end
  _ARG_0_.PlHitMAxCnt1 = _UPVALUE8_ + Script.Random() * _UPVALUE8_
  _ARG_0_.PlHitMAxCnt2 = _UPVALUE8_ + Script.Random() * _UPVALUE8_
end
function g16pp00.OnUpdate(_ARG_0_)
  _ARG_0_.shotTimer2 = _ARG_0_.shotTimer2 - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
  _ARG_0_.shotTimer1 = _ARG_0_.shotTimer1 - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_0_.shotTimer1 < 0 then
    _ARG_0_:CreateBullet(1)
    _ARG_0_.shotTimer1 = _UPVALUE0_ - (Script.Random() * (_UPVALUE1_ * 2) - _UPVALUE1_)
    _ARG_0_.PlHitCnt1 = _ARG_0_.PlHitCnt1 + 1
  end
  if _ARG_0_.shotTimer2 < 0 then
    _ARG_0_:CreateBullet(2)
    _ARG_0_.shotTimer2 = _UPVALUE2_ - (Script.Random() * (_UPVALUE3_ * 2) - _UPVALUE3_)
    _ARG_0_.PlHitCnt2 = _ARG_0_.PlHitCnt2 + 1
  end
end
function g16pp00.CreateBullet(_ARG_0_, _ARG_1_)
  Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
  Entity.GetWorldPos(_ARG_0_.targetPos, Player.GetHandle(), 2)
  Entity.IsSwim(Player.GetHandle())
  Math.VectorLerp(_ARG_0_.myPos, _ARG_0_.myPos, _ARG_0_.targetPos, 0.4)
  if _UPVALUE0_ == 2 then
    _ARG_0_.myPos:sety(10)
  elseif _UPVALUE0_ == 3 then
    _ARG_0_.myPos:sety(15)
  elseif _UPVALUE0_ == 4 then
    _ARG_0_.myPos:sety(10)
  end
  _ARG_0_.rot:set(0, 0, 0)
  Bullet.SetCollision(Bullet.CreateBullet("g17pp00", _ARG_0_.myPos, _ARG_0_.rot), COLL_KIND_NO_CHECK, COLL_SHAPE_SPHERE, 0.5, 0, _ARG_0_.myHandle)
  Bullet.SetAttackParam(Bullet.CreateBullet("g17pp00", _ARG_0_.myPos, _ARG_0_.rot), Gimmick.GetAttackKind(_ARG_0_.myHandle, 0), Gimmick.GetAttackAttr(_ARG_0_.myHandle, 0), Gimmick.GetAttackPoint(_ARG_0_.myHandle, 0), Gimmick.GetAttackPowerCorrection(_ARG_0_.myHandle, 0))
  Entity.SetMovementCollRadius(Bullet.CreateBullet("g17pp00", _ARG_0_.myPos, _ARG_0_.rot), 0.75)
  Entity.SetLowerHalf(Bullet.CreateBullet("g17pp00", _ARG_0_.myPos, _ARG_0_.rot), 1.25)
  Entity.EnableAttackBgHit(Bullet.CreateBullet("g17pp00", _ARG_0_.myPos, _ARG_0_.rot), 1)
  Entity.EnableBgColl(Bullet.CreateBullet("g17pp00", _ARG_0_.myPos, _ARG_0_.rot), 1)
  Entity.EnableWaterSurface(Bullet.CreateBullet("g17pp00", _ARG_0_.myPos, _ARG_0_.rot), 0)
  Entity.EnableCheckUnderFoot(Bullet.CreateBullet("g17pp00", _ARG_0_.myPos, _ARG_0_.rot), 1)
  Bullet.SetMaxMoveDist(Bullet.CreateBullet("g17pp00", _ARG_0_.myPos, _ARG_0_.rot), 100000000)
  if _UPVALUE0_ == 2 then
    Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
    _ARG_0_.myPos:sety(-6)
    _ARG_0_.myPos:setx(_ARG_0_.myPos:getx() - 5)
    _ARG_0_.myPos:setz(_ARG_0_.myPos:getz() + (Script.Random() * 9 - 4.5))
    Entity.SetEffect(Bullet.CreateBullet("g17pp00", _ARG_0_.myPos, _ARG_0_.rot), "g_pp_fune_0", "G_PP_FNE_KEM0_0", _ARG_0_.myPos, _ARG_0_.rot)
    if _ARG_1_ == 1 then
      if _ARG_0_.PlHitCnt1 > _ARG_0_.PlHitMAxCnt1 then
        EntityManager:GetEntity((Bullet.CreateBullet("g17pp00", _ARG_0_.myPos, _ARG_0_.rot))).PlHitFlag = 1
        _ARG_0_.PlHitCnt1 = 0
        _ARG_0_.PlHitMAxCnt1 = _UPVALUE1_ + Script.Random() * _UPVALUE1_
      end
    elseif _ARG_0_.PlHitCnt2 > _ARG_0_.PlHitMAxCnt2 then
      EntityManager:GetEntity((Bullet.CreateBullet("g17pp00", _ARG_0_.myPos, _ARG_0_.rot))).PlHitFlag = 1
      _ARG_0_.PlHitCnt2 = 0
      _ARG_0_.PlHitMAxCnt2 = _UPVALUE1_ + Script.Random() * _UPVALUE1_
    end
  elseif _UPVALUE0_ == 3 then
    Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
    _ARG_0_.myPos:sety(3)
    _ARG_0_.myPos:setx(_ARG_0_.myPos:getx() - 5)
    _ARG_0_.myPos:setz(_ARG_0_.myPos:getz() + (Script.Random() * 9 - 4.5))
    Entity.SetEffect(Bullet.CreateBullet("g17pp00", _ARG_0_.myPos, _ARG_0_.rot), "g_pp_fune_0", "G_PP_FNE_KEM0_0", _ARG_0_.myPos, _ARG_0_.rot)
    if _ARG_1_ == 1 then
      if _ARG_0_.PlHitCnt1 > _ARG_0_.PlHitMAxCnt1 then
        EntityManager:GetEntity((Bullet.CreateBullet("g17pp00", _ARG_0_.myPos, _ARG_0_.rot))).PlHitFlag = 1
        _ARG_0_.PlHitCnt1 = 0
        _ARG_0_.PlHitMAxCnt1 = _UPVALUE1_ + Script.Random() * _UPVALUE1_
      end
    elseif _ARG_0_.PlHitCnt2 > _ARG_0_.PlHitMAxCnt2 then
      EntityManager:GetEntity((Bullet.CreateBullet("g17pp00", _ARG_0_.myPos, _ARG_0_.rot))).PlHitFlag = 1
      _ARG_0_.PlHitCnt2 = 0
      _ARG_0_.PlHitMAxCnt2 = _UPVALUE1_ + Script.Random() * _UPVALUE1_
    end
  elseif _UPVALUE0_ == 4 then
    Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
    _ARG_0_.myPos:sety(-6)
    _ARG_0_.myPos:setx(_ARG_0_.myPos:getx() - 5)
    _ARG_0_.myPos:setz(_ARG_0_.myPos:getz() + (Script.Random() * 9 - 4.5))
    Entity.SetEffect(Bullet.CreateBullet("g17pp00", _ARG_0_.myPos, _ARG_0_.rot), "g_pp_fune_0", "G_PP_FNE_KEM0_0", _ARG_0_.myPos, _ARG_0_.rot)
    if _ARG_1_ == 1 then
      if _ARG_0_.PlHitCnt1 > _ARG_0_.PlHitMAxCnt1 then
        EntityManager:GetEntity((Bullet.CreateBullet("g17pp00", _ARG_0_.myPos, _ARG_0_.rot))).PlHitFlag = 1
        _ARG_0_.PlHitCnt1 = 0
        _ARG_0_.PlHitMAxCnt1 = _UPVALUE1_ + Script.Random() * _UPVALUE1_
      end
    elseif _ARG_0_.PlHitCnt2 > _ARG_0_.PlHitMAxCnt2 then
      EntityManager:GetEntity((Bullet.CreateBullet("g17pp00", _ARG_0_.myPos, _ARG_0_.rot))).PlHitFlag = 1
      _ARG_0_.PlHitCnt2 = 0
      _ARG_0_.PlHitMAxCnt2 = _UPVALUE1_ + Script.Random() * _UPVALUE1_
    end
  end
end
EntityFactory:Add("g16pp00", function(_ARG_0_)
  return (g16pp00:new())
end)
g17pp00 = {}
g17pp00_mt = {__index = g17pp00}
function g17pp00.new(_ARG_0_)
  return setmetatable({}, g17pp00_mt)
end
function g17pp00.OnHitAttack(_ARG_0_, _ARG_1_)
  return 1
end
function g17pp00.OnHitBg(_ARG_0_)
  if Entity.IsSwim(_ARG_0_.myHandle) then
    _ARG_0_:createEffect("g_pp_houd_0", "G_PP_HOU_SIB0_0")
    Bullet.DeleteBullet(_ARG_0_.myHandle)
    Camera.QuakeV(20, 0.01, 5)
    return
  end
  if Entity.IsWall(_ARG_0_.myHandle) then
    _ARG_0_:createEffect("g_pp_houd_0", "G_PP_HOU_KAK0_0")
    Bullet.SetHitBgEffectName(_ARG_0_.myHandle, "g_pp_houd_0", "G_PP_HOU_TYK0_0")
    Bullet.SetHitBgEffect(_ARG_0_.myHandle)
  end
  if Entity.IsGround(_ARG_0_.myHandle) then
    Bullet.SetHitBgEffectName(_ARG_0_.myHandle, "g_pp_houd_0", "G_PP_HOU_DAN0_0")
    _ARG_0_:createEffect("g_pp_houd_0", "G_PP_HOU_KAK0_0")
    Bullet.SetHitBgEffect(_ARG_0_.myHandle)
  end
  Bullet.DeleteBullet(_ARG_0_.myHandle)
  Camera.QuakeV(20, 0.01, 5)
end
function g17pp00.createEffect(_ARG_0_, _ARG_1_, _ARG_2_)
  Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
  Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
  Entity.SetEffect(_ARG_0_.myHandle, _ARG_1_, _ARG_2_, _UPVALUE0_, _UPVALUE1_)
end
function g17pp00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  if _UPVALUE0_ == 2 then
    _ARG_0_.PopPow = 0.4
  elseif _UPVALUE0_ == 3 then
    _ARG_0_.PopPow = 1
  elseif _UPVALUE0_ == 4 then
    _ARG_0_.PopPow = 0.4
  end
  _ARG_0_.fadeFlag = 0
  _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
  _ARG_0_.gravity = FVECTOR3.new(0, 0, 0)
  _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.PlHitFlag = 0
  _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
  Entity.GetWorldPos(_ARG_0_.targetPos, Player.GetHandle(), 2)
  _ARG_0_.targetPos:setx(_ARG_0_.targetPos:getx() + (3 * Script.Random() + 3) * Math.Cos((RoundPI(Script.Random() * 5 * PI))))
  _ARG_0_.targetPos:setz(_ARG_0_.targetPos:getz() + (3 * Script.Random() + 3) * Math.Sin((RoundPI(Script.Random() * 5 * PI))))
  if _UPVALUE1_ ~= NULL_HANDLE then
    Entity.GetWorldPos(_UPVALUE2_, _UPVALUE1_, 1)
    if Entity.CalcDistanceXZ(Player.GetHandle(), _UPVALUE2_) < 9 then
      Entity.GetWorldPos(_ARG_0_.targetPos, _UPVALUE1_, 2)
    end
  else
  end
  Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.myHandle)
  FVECTOR3.Sub(_UPVALUE2_, _UPVALUE3_, _UPVALUE2_)
  _ARG_0_.HeightY = _UPVALUE2_:gety()
  Entity.GetWorldPos(_UPVALUE3_, _ARG_0_.myHandle)
  _UPVALUE3_:sety(_ARG_0_.targetPos:gety())
  Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE3_)
end
function g17pp00.OnUpdate(_ARG_0_)
  if _UPVALUE0_ == 2 then
    if _ARG_0_.step == 0 then
      if _ARG_0_.PlHitFlag == 1 then
        Entity.GetWorldPos(_ARG_0_.targetPos, Player.GetHandle(), 2)
      else
      end
      _ARG_0_.speed = Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetPos) / _UPVALUE1_
      _ARG_0_.GravityNum = _ARG_0_.PopPow / (_UPVALUE1_ / 2)
      _ARG_0_.step = 1
      if _ARG_0_.PlHitFlag == 1 then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, Player.GetHandle(), 180)
      else
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 180)
      end
    elseif _ARG_0_.step == 1 then
      _ARG_0_.PopPow = _ARG_0_.PopPow - _ARG_0_.GravityNum * Entity.GetFrameRate(_ARG_0_.myHandle)
      _ARG_0_.gravity:sety(_ARG_0_.PopPow)
      if 0 > _ARG_0_.speed then
        _ARG_0_.speed = 0
      end
      Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.gravity)
    end
    _ARG_0_.velocity:set(0, 0, _ARG_0_.speed)
    Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
    if _ARG_0_.fadeFlag == 0 then
      if 0 > _ARG_0_.PopPow then
        Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, 20)
        _ARG_0_.fadeFlag = 1
      else
        Entity.SetAlpha(_ARG_0_.myHandle, 0)
      end
    end
  elseif _UPVALUE0_ == 3 then
    if _ARG_0_.step == 0 then
      if _ARG_0_.PlHitFlag == 1 then
        Entity.GetWorldPos(_ARG_0_.targetPos, Player.GetHandle(), 2)
      else
      end
      _ARG_0_.speed = Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetPos) / _UPVALUE1_
      _ARG_0_.GravityNum = _ARG_0_.PopPow / (_UPVALUE1_ / 2)
      _ARG_0_.step = 1
      if _ARG_0_.PlHitFlag == 1 then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, Player.GetHandle(), 180)
      else
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 180)
      end
    elseif _ARG_0_.step == 1 then
      _ARG_0_.PopPow = _ARG_0_.PopPow - _ARG_0_.GravityNum * Entity.GetFrameRate(_ARG_0_.myHandle)
      _ARG_0_.gravity:sety(_ARG_0_.PopPow)
      if 0 > _ARG_0_.speed then
        _ARG_0_.speed = 0
      end
      Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.gravity)
    end
    _ARG_0_.velocity:set(0, 0, _ARG_0_.speed)
    Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
    if _ARG_0_.fadeFlag == 0 then
      if 0 > _ARG_0_.PopPow then
        Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, 20)
        _ARG_0_.fadeFlag = 1
      else
        Entity.SetAlpha(_ARG_0_.myHandle, 0)
      end
    end
  elseif _UPVALUE0_ == 4 then
    if _ARG_0_.step == 0 then
      if _ARG_0_.PlHitFlag == 1 then
        Entity.GetWorldPos(_ARG_0_.targetPos, Player.GetHandle(), 2)
      else
      end
      _ARG_0_.speed = Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetPos) / _UPVALUE1_
      _ARG_0_.GravityNum = _ARG_0_.PopPow / (_UPVALUE1_ / 2)
      _ARG_0_.step = 1
      if _ARG_0_.PlHitFlag == 1 then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, Player.GetHandle(), 180)
      else
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 180)
      end
    elseif _ARG_0_.step == 1 then
      _ARG_0_.PopPow = _ARG_0_.PopPow - _ARG_0_.GravityNum * Entity.GetFrameRate(_ARG_0_.myHandle)
      _ARG_0_.gravity:sety(_ARG_0_.PopPow)
      if 0 > _ARG_0_.speed then
        _ARG_0_.speed = 0
      end
      Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.gravity)
    end
    _ARG_0_.velocity:set(0, 0, _ARG_0_.speed)
    Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
    if _ARG_0_.fadeFlag == 0 then
      if 0 > _ARG_0_.PopPow then
        Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, 20)
        _ARG_0_.fadeFlag = 1
      else
        Entity.SetAlpha(_ARG_0_.myHandle, 0)
      end
    end
  end
end
EntityFactory:Add("g17pp00", function(_ARG_0_)
  return (g17pp00:new())
end)
