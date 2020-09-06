PI = 3.1415927
NULL_HANDLE = 0
DISPLAYER_3D_OT_START = 0
DISPLAYER_3D_OT_LAST = 0
DISPLAYER_3D_OT_CHRLAST = 0
DISPLAYER_MENU3 = 0
OBJ_BIT_NONE = 0
OBJ_BIT_PLAYER = 0
OBJ_BIT_FRIEND = 0
OBJ_BIT_ENEMY = 0
OBJ_BIT_GIMMICK = 0
OBJ_BIT_AVATAR = 0
OBJ_BIT_BULLET = 0
OBJ_BIT_PRIZE = 0
OBJ_BIT_MAP = 0
OBJ_BIT_BG = 0
OBJ_TYPE_NONE = 0
OBJ_TYPE_PLAYER = 0
OBJ_TYPE_ENEMY = 0
OBJ_TYPE_GIMMICK = 0
OBJ_TYPE_BULLET = 0
OBJ_TYPE_PRIZE = 0
OBJ_TYPE_MAP = 0
OBJ_TYPE_BG = 0
OBJ_TYPE_CAMERA = 0
OBJ_TYPE_2D = 0
OBJ_TYPE_FRIEND = 0
OBJ_TYPE_EXUSIA = 0
OBJ_TYPE_MISSION = 0
OBJ_TYPE_NETWORK = 0
CH_COMMON = 0
CH_PLAYER = 0
CH_EVENT = 0
SE_OPT_ALWAYS = 4
SOUND_MAX_VOLUME = 1
ITEM_DISP_SEQ_NONE = 0
ITEM_DISP_SEQ_ITEM = 1
ITEM_DISP_SEQ_PRIZE = 2
PAD_SELECT = 0
PAD_START = 0
PAD_LUP = 0
PAD_LRIGHT = 0
PAD_LDOWN = 0
PAD_LLEFT = 0
PAD_UP = 0
PAD_DOWN = 0
PAD_LEFT = 0
PAD_RIGHT = 0
PAD_L1 = 0
PAD_R1 = 0
PAD_RUP = 0
PAD_RRIGHT = 0
PAD_RDOWN = 0
PAD_RLEFT = 0
PAD_TRIANGLE = 0
PAD_CIRCLE = 0
PAD_CROSS = 0
PAD_SQUARE = 0
PAD_INTERCEPTED = 0
PAD_HOLD = 0
PAD_SOFTRESET = 0
PAD_S_UP = 0
PAD_S_RIGHT = 0
PAD_S_DOWN = 0
PAD_S_LEFT = 0
function RadToDeg(_ARG_0_)
  return _ARG_0_ * (180 / PI)
end
function DegToRad(_ARG_0_)
  return _ARG_0_ * (PI / 180)
end
function RoundPI(_ARG_0_)
  if _ARG_0_ < -PI then
    return _ARG_0_ + PI * 2
  end
  if _ARG_0_ > PI then
    return _ARG_0_ - PI * 2
  end
  return _ARG_0_
end
function HomingDegree(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if DegToRad(_ARG_2_) * _ARG_3_ < RoundPI(_ARG_1_ - _ARG_0_) then
  elseif RoundPI(_ARG_1_ - _ARG_0_) < -(DegToRad(_ARG_2_) * _ARG_3_) then
  else
  end
  return _ARG_1_, false
end
function TurnRadianRate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if RoundPI(_ARG_0_) == RoundPI(_ARG_1_) then
    return RoundPI(_ARG_1_), false
  end
  if _ARG_2_ * _ARG_3_ <= 0 then
    return RoundPI(_ARG_0_), false
  end
  if _ARG_2_ * _ARG_3_ >= 1 then
    return RoundPI(_ARG_1_), false
  end
  if Math.Abs(RoundPI(RoundPI(_ARG_1_) - RoundPI(_ARG_0_)) * (_ARG_2_ * _ARG_3_)) < 0.001 * (_ARG_2_ * _ARG_3_) then
    return RoundPI(_ARG_1_), false
  end
  return RoundPI(RoundPI(_ARG_0_) + RoundPI(RoundPI(_ARG_1_) - RoundPI(_ARG_0_)) * (_ARG_2_ * _ARG_3_)), true
end
function SetupAppearBegin(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if _ARG_1_ <= 0 then
    _ARG_1_ = ENEMY_COMMON_APPEAR_FADE_TIME
  end
  Entity.SetMotion(_ARG_0_, _ARG_2_, _ARG_3_)
  Entity.EnableBodyColl(_ARG_0_, 0)
  Entity.SetupModelFade(_ARG_0_, 0, 1, _ARG_1_)
  Entity.SetRot(_ARG_0_, 0, Entity.CalcDirection(_ARG_0_, (Enemy.SearchAttackEntity(_ARG_0_, SEARCH_TYPE_NEAR))), 0)
  Entity.EnableDamageColl(_ARG_0_, 1)
  Entity.EnableLockonAndShooton(_ARG_0_, 1)
end
function SetupAppearBegin2(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if _ARG_1_ <= 0 then
    _ARG_1_ = ENEMY_COMMON_APPEAR_FADE_TIME
  end
  Entity.SetMotion(_ARG_0_, _ARG_2_, _ARG_3_)
  Entity.EnableBodyColl(_ARG_0_, 0)
  Entity.SetupModelFade(_ARG_0_, 0, 1, _ARG_1_)
  Entity.SetRot(_ARG_0_, 0, Entity.CalcDirection(_ARG_0_, (Enemy.SearchAttackEntity(_ARG_0_, SEARCH_TYPE_NEAR))), 0)
  Entity.EnableDamageColl(_ARG_0_, 1)
  Entity.EnableLockonAndShooton(_ARG_0_, 1)
end
function SetupAppearEnd(_ARG_0_)
  Entity.EnableDamageColl(_ARG_0_, 1)
  Entity.EnableBodyColl(_ARG_0_, 1)
  Entity.EnableLockonAndShooton(_ARG_0_, 1)
end
function SetupDisappear(_ARG_0_, _ARG_1_)
  Entity.EnableDamageColl(_ARG_0_, 0)
  Entity.EnableBodyColl(_ARG_0_, 0)
  Entity.EnableLockonAndShooton(_ARG_0_, 0)
  Entity.SetupModelFade(_ARG_0_, 1, 0, _ARG_1_)
  Enemy.SetBadStatusEffect(_ARG_0_, BAD_STATUS_DISAPPEAR)
  Entity.LoopEndBSEffect(_ARG_0_)
end
function SetupBossDead(_ARG_0_)
  Mission.CompleteMission()
  Enemy.SetDeadEffect(_ARG_0_, true)
  Entity.EnableDamageColl(_ARG_0_, 0)
  Entity.EnableLockonAndShooton(_ARG_0_, 0)
  Enemy.SetBattleFlagBossDead(1)
end
function CreateEnemyBullet(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_)
  if _ARG_4_ == nil then
  else
  end
  if _ARG_5_ ~= nil then
    Bullet.SetEffectSeExternalId(Bullet.CreateBullet(_ARG_0_.name, _ARG_2_, _ARG_3_, NULL_HANDLE, _ARG_4_), _ARG_5_)
  end
  if _ARG_0_.bulletEffectName ~= nil then
    Bullet.CreateEffectBullet(Bullet.CreateBullet(_ARG_0_.name, _ARG_2_, _ARG_3_, NULL_HANDLE, _ARG_4_), _ARG_0_.fepName, _ARG_0_.bulletEffectName)
  end
  if _ARG_0_.collision.kind == nil then
    Bullet.SetCollision(Bullet.CreateBullet(_ARG_0_.name, _ARG_2_, _ARG_3_, NULL_HANDLE, _ARG_4_), COLL_KIND_ENEMY, _ARG_0_.collision.shape, _ARG_0_.collision.radius, _ARG_0_.collision.height, _ARG_1_)
  else
    Bullet.SetCollision(Bullet.CreateBullet(_ARG_0_.name, _ARG_2_, _ARG_3_, NULL_HANDLE, _ARG_4_), _ARG_0_.collision.kind, _ARG_0_.collision.shape, _ARG_0_.collision.radius, _ARG_0_.collision.height, _ARG_1_)
  end
  SetBulletAttackParam(Bullet.CreateBullet(_ARG_0_.name, _ARG_2_, _ARG_3_, NULL_HANDLE, _ARG_4_), _ARG_1_, _ARG_0_.attackNo)
  Bullet.SetHitAttackEffectName(Bullet.CreateBullet(_ARG_0_.name, _ARG_2_, _ARG_3_, NULL_HANDLE, _ARG_4_), _ARG_0_.fepName, _ARG_0_.hitAttackEffectName)
  Bullet.SetHitBgEffectName(Bullet.CreateBullet(_ARG_0_.name, _ARG_2_, _ARG_3_, NULL_HANDLE, _ARG_4_), _ARG_0_.fepName, _ARG_0_.hitBgEffectName)
  Entity.CalcVelocity(Bullet.CreateBullet(_ARG_0_.name, _ARG_2_, _ARG_3_, NULL_HANDLE, _ARG_4_), _ARG_0_.speed)
  return (Bullet.CreateBullet(_ARG_0_.name, _ARG_2_, _ARG_3_, NULL_HANDLE, _ARG_4_))
end
function SetBulletAttackParam(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if Enemy.IsIllusionEnemy(_ARG_1_) == false then
  end
  Bullet.SetAttackParam(_ARG_0_, Enemy.GetAttackKind(_ARG_1_, _ARG_2_), Enemy.GetAttackAttr(_ARG_1_, _ARG_2_), Enemy.GetAttackPoint(_ARG_1_, _ARG_2_), Enemy.GetAttackPowerCorrection(_ARG_1_, _ARG_2_), _ARG_3_, (Enemy.GetDifficultyCorrection()))
  Bullet.EnableReflect(_ARG_0_, Enemy.GetAttackReflect(_ARG_1_, _ARG_2_))
  Bullet.SetAttacker(_ARG_0_, _ARG_1_)
  if Enemy.IsConfuse(_ARG_1_) then
    Bullet.SetCollKind(_ARG_0_, COLL_KIND_NO_CHECK)
  end
end
function CanDisappear(_ARG_0_, _ARG_1_)
  if Enemy.IsDisappearWatiTimeOver(_ARG_0_) == false then
    return false
  end
  if Entity.IsPlayer(_ARG_1_) == false and Entity.IsDummyObj(_ARG_1_) == false then
    return false
  end
  if Entity.GetUserShootLocked(_ARG_0_) <= 0 and Entity.CalcDistanceSq(_ARG_0_, _ARG_1_) >= ENEMY_COMMON_DISAPPEAR_DIST then
    return true
  end
  return false
end
