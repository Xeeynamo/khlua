g14sw00 = {}
g14sw00.__index = g14sw00
function g14sw00.new(_ARG_0_)
  return setmetatable({}, g14sw00)
end
function g14sw00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.workVec0 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.step = 0
  _ARG_0_.effHandle = Entity.AttachEffect(_ARG_0_.myHandle, "g_sw_bin_a0", "G_SW_BIN_RGY0_0", "center", _ARG_0_.workVec0, _ARG_0_.workVec1)
  Effect.SetModel(_ARG_0_.effHandle, _ARG_0_.myHandle)
  Effect.SetAttachAlpha(_ARG_0_.effHandle, true)
  Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
  Entity.SetMotion(_ARG_0_.myHandle, 1, 1)
  Entity.SetModelFixZ(_ARG_0_.myHandle, DISPLAYER_3D_OT_CHRLAST)
  Entity.SetDispOffCameraDistance(_ARG_0_.myHandle, 20)
end
function g14sw00.OnUpdate(_ARG_0_)
  if _ARG_0_.step == 1 and Entity.IsTimeOver(_ARG_0_.myHandle) then
    _ARG_0_:Explode()
    Entity.Out(_ARG_0_.myHandle)
  end
end
function g14sw00.OnDamage(_ARG_0_, _ARG_1_, _ARG_2_)
  if _ARG_0_.step ~= 0 or 0 >= Entity.GetDamagePoint(_ARG_0_.myHandle) then
    return 1
  end
  Effect.KillEffect(_ARG_0_.effHandle)
  _ARG_0_.effHandle = NULL_HANDLE
  if 0 <= Math.Mod(Effect.GetNowFrame(_ARG_0_.effHandle), 480) and Math.Mod(Effect.GetNowFrame(_ARG_0_.effHandle), 480) < 160 then
    Entity.SetMotion(_ARG_0_.myHandle, 2, 2)
    Entity.SetTimer(_ARG_0_.myHandle, Gimmick.GetExtraParam(_ARG_0_.myHandle, "ExplodeS") * 60)
    _ARG_0_.step = 1
  elseif Math.Mod(Effect.GetNowFrame(_ARG_0_.effHandle), 480) >= 160 and Math.Mod(Effect.GetNowFrame(_ARG_0_.effHandle), 480) < 320 then
    _ARG_0_:Destruction(0, Gimmick.GetExtraParam(_ARG_0_.myHandle, "H_PrizeNum"))
  else
    _ARG_0_:Destruction(5, Gimmick.GetExtraParam(_ARG_0_.myHandle, "F_PrizeNum"))
  end
  return 1
end
function g14sw00.OnDestroy(_ARG_0_)
  Effect.KillEffect(_ARG_0_.effHandle)
end
function g14sw00.Destruction(_ARG_0_, _ARG_1_, _ARG_2_)
  Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.myHandle, 1)
  Entity.SetEffect(_ARG_0_.myHandle, "g_sw_bin_a0", "G_SW_BIN_BRK0_0", _ARG_0_.workVec0, _ARG_0_.workVec1)
  for _FORV_6_ = 1, _ARG_2_ do
    Entity.CreatePrize(_ARG_0_.myHandle, _ARG_1_)
  end
  _FOR_.Delete(_ARG_0_.myHandle)
end
function g14sw00.OnStartModelClipFar(_ARG_0_)
  Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
end
function g14sw00.OnEndModelClipFar(_ARG_0_)
  Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
end
function g14sw00.Explode(_ARG_0_)
  Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.myHandle)
  Bullet.CreateEffectBullet(Bullet.CreateBullet("g14swExplode", _ARG_0_.workVec0, _ARG_0_.workVec1), "g_sw_bin_a0", "G_SW_BIN_BOM0_0")
  _ARG_0_.workVec0:set(Gimmick.GetExtraParam(_ARG_0_.myHandle, "ExplodeR") * 0.5, Gimmick.GetExtraParam(_ARG_0_.myHandle, "ExplodeR") * 0.5, Gimmick.GetExtraParam(_ARG_0_.myHandle, "ExplodeR") * 0.5)
  Effect.SetScale(Bullet.GetEffectHandle((Bullet.CreateBullet("g14swExplode", _ARG_0_.workVec0, _ARG_0_.workVec1))), _ARG_0_.workVec0)
  Bullet.SetAttackParam(Bullet.CreateBullet("g14swExplode", _ARG_0_.workVec0, _ARG_0_.workVec1), Gimmick.GetAttackKind(_ARG_0_.myHandle, 0), Gimmick.GetAttackAttr(_ARG_0_.myHandle, 0), Gimmick.GetAttackPoint(_ARG_0_.myHandle, 0), Gimmick.GetAttackPowerCorrection(_ARG_0_.myHandle, 0))
  Bullet.SetCollision(Bullet.CreateBullet("g14swExplode", _ARG_0_.workVec0, _ARG_0_.workVec1), COLL_KIND_NO_CHECK, COLL_SHAPE_SPHERE, (Gimmick.GetExtraParam(_ARG_0_.myHandle, "ExplodeR")))
  Entity.SetTimer(Bullet.CreateBullet("g14swExplode", _ARG_0_.workVec0, _ARG_0_.workVec1), Gimmick.GetExtraParam(_ARG_0_.myHandle, "ExplodeTime") * 60)
end
EntityFactory:Add("g14sw00", function(_ARG_0_)
  return (g14sw00:new())
end)
g14swExplode = {}
g14swExplode.__index = g14swExplode
function g14swExplode.new(_ARG_0_)
  return setmetatable({}, g14swExplode)
end
function g14swExplode.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  Bullet.SetHitAttackEffectName(_ARG_1_, "g_sw_bin_a0", "G_SW_BIN_HIT0_0")
  Entity.EnableBgColl(_ARG_1_, 0)
end
function g14swExplode.OnHitAttack(_ARG_0_)
end
function g14swExplode.OnHitBg(_ARG_0_)
end
function g14swExplode.OnUpdate(_ARG_0_)
  if _ARG_0_.step == 0 and Entity.IsTimeOver(_ARG_0_.myHandle) then
    Bullet.EnableAttackCollision(_ARG_0_.myHandle, 0)
    _ARG_0_.step = 1
  end
end
EntityFactory:Add("g14swExplode", function(_ARG_0_)
  EntityManager:Add(g14swExplode:new(), _ARG_0_)
  return (g14swExplode:new())
end)
