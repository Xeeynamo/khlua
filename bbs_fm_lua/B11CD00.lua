b11cd00 = {}
b11cd00_base_mt = {__index = __StateMachine}
setmetatable(b11cd00, b11cd00_base_mt)
b11cd00_mt = {__index = b11cd00}
function b11cd00.new(_ARG_0_)
  return setmetatable(__StateMachine:new(), b11cd00_mt)
end
function b11cd00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.MasterHandle = NULL_HANDLE
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkTime = 0
  _ARG_0_.WorkVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkRot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.OldmyPos = FVECTOR3.new(0, 0, 0)
  Entity.SetTimer(_ARG_0_.myHandle, 120)
  _ARG_0_.myshadowHandle = Entity.SetEffect(_ARG_0_.myHandle, "b10cd00", "B004_SDW_00_0", _ARG_0_.WorkVec)
end
function b11cd00.OnHitAttack(_ARG_0_)
end
function b11cd00.OnHitBg(_ARG_0_)
  if _ARG_0_.step == 0 then
    if Entity.IsGround(_ARG_0_.myHandle) then
      _ARG_0_.step = 1
    end
    _ARG_0_.step = 1
  end
end
function b11cd00.OnUpdatePositionAfter(_ARG_0_)
  if _ARG_0_.flag then
    _ARG_0_.rot:set(0, _ARG_0_.angle, 0)
    Entity.RotateBoneXYZ(_ARG_0_.myHandle, 2, _ARG_0_.rot)
  end
end
function b11cd00.OnDestroy(_ARG_0_)
  Effect.KillEffect(_ARG_0_.myshadowHandle)
end
function b11cd00.OnUpdate(_ARG_0_)
  Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle, 0)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  _ARG_0_.WorkVec:set(_ARG_0_.myPos:getx(), 0.01, _ARG_0_.myPos:getz())
  Effect.UpdateCoord(_ARG_0_.myshadowHandle, _ARG_0_.WorkVec, _ARG_0_.WorkRot)
  if _ARG_0_.step == 0 then
    if _ARG_0_.OldmyPos:gety() == _ARG_0_.myPos:gety() then
      _ARG_0_.step = 1
      return
    end
    if Entity.IsTimeOver(_ARG_0_.myHandle) then
      _ARG_0_.step = 1
      return
    end
    Entity.GetWorldPos(_ARG_0_.OldmyPos, _ARG_0_.myHandle, 0)
  elseif _ARG_0_.step == 1 then
    _ARG_0_.step = 99
    _ARG_0_.myPos:sety(_ARG_0_.myPos:gety() - Entity.GetFloorDistance(_ARG_0_.myHandle))
    SetBulletAttackParam(Bullet.CreateBullet("b11cd00b", _ARG_0_.myPos, _ARG_0_.rot), _ARG_0_.MasterHandle, 4)
    Bullet.SetMaxMoveDist(Bullet.CreateBullet("b11cd00b", _ARG_0_.myPos, _ARG_0_.rot), 100000000)
    _ARG_0_.rot:setx(0)
    _ARG_0_.rot:sety(0)
    _ARG_0_.rot:setz(0)
    Entity.SetRot(Bullet.CreateBullet("b11cd00b", _ARG_0_.myPos, _ARG_0_.rot), _ARG_0_.rot)
    Effect.KillEffect(_ARG_0_.myshadowHandle)
    Entity.Out(_ARG_0_.myHandle)
  end
end
EntityFactory:Add("b11cd00", function(_ARG_0_)
  return (b11cd00:new())
end)
b11cd00b = {}
b11cd00b_mt = {__index = b11cd00b}
function b11cd00b.new(_ARG_0_)
  return setmetatable({}, b11cd00b_mt)
end
function b11cd00b.OnHitAttack(_ARG_0_)
  return 1
end
function b11cd00b.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
  Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle, 0)
  if _ARG_0_.myPos:gety() > 0.009 then
    Bullet.CreateEffectBullet(_ARG_1_, "b10cd00", "B004_BOM_03_0")
  else
    Bullet.CreateEffectBullet(_ARG_1_, "b10cd00", "B004_BOM_00_0")
  end
  Bullet.SetHitAttackEffectName(_ARG_1_, "b10cd00", "B004_HIT_02_0")
  Bullet.EnableNoCheckHitBg(_ARG_1_, 0)
  Bullet.SetCollision(_ARG_1_, COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, 1.1, 0)
end
function b11cd00b.OnUpdate(_ARG_0_)
  if _ARG_0_.step == 0 and Effect.GetNowFrame((Bullet.GetEffectHandle(_ARG_0_.myHandle))) >= 40 then
    Bullet.EnableAttackCollision(_ARG_0_.myHandle, 0)
    _ARG_0_.step = _ARG_0_.step + 1
  end
end
EntityFactory:Add("b11cd00b", function(_ARG_0_)
  return (b11cd00b:new())
end)
