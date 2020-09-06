b11sb00 = {}
b11sb00_mt = {__index = b11sb00}
function b11sb00.new(_ARG_0_)
  return setmetatable({}, b11sb00_mt)
end
function b11sb00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.workVec0 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec2 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec3 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.cameraTargetPos = FVECTOR3.new(0, 0, 0)
  Entity.EnableBgColl(_ARG_1_, 0)
  Entity.SetDropShadowDistance(_ARG_1_, 10)
  Entity.SetLockOnBoneNum(_ARG_1_, 5)
end
function b11sb00.OnDamage(_ARG_0_, _ARG_1_, _ARG_2_)
  return 1
end
function b11sb00.OnUpdateLast(_ARG_0_)
  if EntityManager:GetEntity(Entity.GetParent(_ARG_0_.myHandle)) == nil then
    return
  end
  if Effect.IsAlive(EntityManager:GetEntity(Entity.GetParent(_ARG_0_.myHandle)).string2Handle) then
    _ARG_0_.workVec0:set(1.3, 0, 0)
    Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "R_ude2_scl", _ARG_0_.workVec0)
    Entity.GetWorldPos(_ARG_0_.workVec1, EntityManager:GetEntity(Entity.GetParent(_ARG_0_.myHandle)).targetHandle, 2)
    FVECTOR3.Sub(_ARG_0_.workVec2, _ARG_0_.workVec1, _ARG_0_.workVec0)
    _ARG_0_.workVec3:set(1, 1, _ARG_0_.workVec2:length() / 15)
    Effect.SetScale(EntityManager:GetEntity(Entity.GetParent(_ARG_0_.myHandle)).string2Handle, _ARG_0_.workVec3)
    _ARG_0_.workVec2:set(-Math.Atan2(_ARG_0_.workVec2:gety(), Math.Sqrt(_ARG_0_.workVec2:getx() * _ARG_0_.workVec2:getx() + _ARG_0_.workVec2:getz() * _ARG_0_.workVec2:getz())), Math.Atan2(_ARG_0_.workVec2:getx(), _ARG_0_.workVec2:getz()), 0)
    Effect.UpdateCoord(EntityManager:GetEntity(Entity.GetParent(_ARG_0_.myHandle)).string2Handle, _ARG_0_.workVec0, _ARG_0_.workVec2)
  end
end
function b11sb00.OnHitAttack(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  print("OnHitAttack\n")
  if Entity.GetCurrentMotion(_ARG_0_.myHandle) == _UPVALUE0_ then
    print("OnHitAttack ... String of death\n")
    if EntityManager:GetEntity(Entity.GetParent(_ARG_0_.myHandle)) ~= nil and EntityManager:GetEntity(Entity.GetParent(_ARG_0_.myHandle)).targetHandle2 == _ARG_1_ then
      EntityManager:GetEntity(Entity.GetParent(_ARG_0_.myHandle)).hitHandle = _ARG_1_
      if _ARG_3_ == ATK_KIND_CAPTURE then
        Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 0)
        EntityManager:GetEntity(Entity.GetParent(_ARG_0_.myHandle)):ChangeState("StringOfDeathSuccess")
      else
        EntityManager:GetEntity(Entity.GetParent(_ARG_0_.myHandle)).step = 4
      end
    end
  elseif Entity.GetCurrentMotion(_ARG_0_.myHandle) == _UPVALUE1_ and EntityManager:GetEntity(Entity.GetParent(_ARG_0_.myHandle)) ~= nil then
    Effect.KillEffect(EntityManager:GetEntity(Entity.GetParent(_ARG_0_.myHandle)).string2Handle)
    Effect.KillEffect(EntityManager:GetEntity(Entity.GetParent(_ARG_0_.myHandle)).captureHandle)
    Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
  end
end
function b11sb00.GetCameraTargetPos(_ARG_0_)
  if EntityManager:GetEntity(Entity.GetParent(_ARG_0_.myHandle)) ~= nil then
    return EntityManager:GetEntity(Entity.GetParent(_ARG_0_.myHandle)).cameraTargetPos
  else
    Entity.GetWorldPos(_ARG_0_.cameraTargetPos, _ARG_0_.myHandle)
    return _ARG_0_.cameraTargetPos
  end
end
function b11sb00.GetLockOnPos(_ARG_0_)
  _ARG_0_.workVec0:set(1, 0, 0)
  Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "R_ude2_scl", _ARG_0_.workVec0)
  return _ARG_0_.workVec0
end
function b11sb00.OnUpdate(_ARG_0_)
  Entity.SetAlpha(_ARG_0_.myHandle, (Entity.GetAlpha(Entity.GetParent(_ARG_0_.myHandle))))
end
function b11sb00.OnReflect(_ARG_0_)
  print("b11sb00:OnReflect\n")
  if EntityManager:GetEntity(Entity.GetParent(_ARG_0_.myHandle)) ~= nil and EntityManager:GetEntity(Entity.GetParent(_ARG_0_.myHandle)):GetState() == "StringOfDeath" then
    Enemy.EnableGeneralPurposeAttackColl(_ARG_0_.myHandle, 0)
    Entity.SetMotion(EntityManager:GetEntity(Entity.GetParent(_ARG_0_.myHandle)).myHandle, 28)
    EntityManager:GetEntity(Entity.GetParent(_ARG_0_.myHandle)):ReleaseStringOfDeath()
    EntityManager:GetEntity(Entity.GetParent(_ARG_0_.myHandle)).step = 3
  end
  return 0
end
EntityFactory:Add("b11sb00", function(_ARG_0_)
  return (b11sb00:new())
end)
EntityFactory:Add("b51vs00", function(_ARG_0_)
  return (b11sb00:new())
end)
